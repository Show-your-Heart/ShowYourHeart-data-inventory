# ShowYourHeart-data-inventory

Ansible inventory for Show Your Heart


## Deploy project

You need to clone the BI Provisioning repository in order to manage the server deployment.
https://git.coopdevs.org/coopdevs/bi/bi-provisioning

### Server Premissions
- First execution 
```bash
 ansible-playbook playbooks/sys_admins.yml -i ../ShowYourHeart-data-inventory/inventory/hosts  --limit=production --user=root
```

- Next executions 
```bash
 ansible-playbook playbooks/sys_admins.yml -i ../ShowYourHeart-data-inventory/inventory/hosts  --limit=production 
```


### Provision

```bash
ansible-playbook playbooks/provision.yml -i ../ShowYourHeart-data-inventory/inventory/hosts  --limit=production --ask-vault-pass
```

Vault pass inside BW