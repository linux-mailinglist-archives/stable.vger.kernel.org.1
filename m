Return-Path: <stable+bounces-55072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D349154AE
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5501C1F245C2
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E7B19CCF7;
	Mon, 24 Jun 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b6ikx11E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AF62F24
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247671; cv=none; b=hOdU4SNQIP+NGvrYSxeTH5y6ZPpROOY0kFKOuKsWayjQ3P9GiiR9WO+7HiANycj923oz/PN4e+8vAClibulwoF8Bryrxej9pu1638WVf2194+R1qUfH7oUhhmUkWU49upm4X/Vpl/WultqBY0wLJImuJMZK56fNImiOw65bHmFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247671; c=relaxed/simple;
	bh=glRVoRc6BTH6KUt0YV4UCACXkkzZ2OrhlMc7WVlZphY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ThOF2E1UP6V2jLmo7yvAZA9cmwngPLvy/Tnio556dSVaudVikUNtz21zR2lC69MYyp9Sm8cVjvrg6TBYznrIoZyFF1QVTPEs0tA8hyn55ktW4KpBuHr9WOD1mKMWJEjIgqZL6epC4xbE1t91/8i1M9bmcDUr8zi9OKjL1iY6SaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b6ikx11E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD87C2BBFC;
	Mon, 24 Jun 2024 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719247671;
	bh=glRVoRc6BTH6KUt0YV4UCACXkkzZ2OrhlMc7WVlZphY=;
	h=Subject:To:Cc:From:Date:From;
	b=b6ikx11EJLBVgGWwscfrGTX4tI4jqnSCFdgWBrVL3GcaPNXkwKiy9MoJNAPEubK0b
	 5TKYBsJSEtRLnwDlWGsoZDyx51Dr3VeWN061oI1I3pAjido+6KypD45xgYKX3cNV9N
	 mOipzTf/42Nm7DyajrssT6dma9b41G1tOL9CfECk=
Subject: FAILED: patch "[PATCH] ima: Avoid blocking in RCU read-side critical section" failed to apply to 5.10-stable tree
To: guozihua@huawei.com,casey@schaufler-ca.com,john.johansen@canonical.com,paul@paul-moore.com,zohar@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 18:47:43 +0200
Message-ID: <2024062443-rocket-emptiness-09d2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9a95c5bfbf02a0a7f5983280fe284a0ff0836c34
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062443-rocket-emptiness-09d2@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

9a95c5bfbf02 ("ima: Avoid blocking in RCU read-side critical section")
260017f31a8c ("lsm: use default hook return value in call_int_hook()")
923831117611 ("evm: Move to LSM infrastructure")
84594c9ecdca ("ima: Move IMA-Appraisal to LSM infrastructure")
cd3cec0a02c7 ("ima: Move to LSM infrastructure")
06cca5110774 ("integrity: Move integrity_kernel_module_request() to IMA")
b8d997032a46 ("security: Introduce key_post_create_or_update hook")
2d705d802414 ("security: Introduce inode_post_remove_acl hook")
8b9d0b825c65 ("security: Introduce inode_post_set_acl hook")
a7811e34d100 ("security: Introduce inode_post_create_tmpfile hook")
f09068b5a114 ("security: Introduce file_release hook")
8f46ff5767b0 ("security: Introduce file_post_open hook")
dae52cbf5887 ("security: Introduce inode_post_removexattr hook")
77fa6f314f03 ("security: Introduce inode_post_setattr hook")
314a8dc728d0 ("security: Align inode_setattr hook definition with EVM")
779cb1947e27 ("evm: Align evm_inode_post_setxattr() definition with LSM infrastructure")
2b6a4054f8c2 ("evm: Align evm_inode_setxattr() definition with LSM infrastructure")
784111d0093e ("evm: Align evm_inode_post_setattr() definition with LSM infrastructure")
fec5f85e468d ("ima: Align ima_post_read_file() definition with LSM infrastructure")
526864dd2f60 ("ima: Align ima_inode_removexattr() definition with LSM infrastructure")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9a95c5bfbf02a0a7f5983280fe284a0ff0836c34 Mon Sep 17 00:00:00 2001
From: GUO Zihua <guozihua@huawei.com>
Date: Tue, 7 May 2024 01:25:41 +0000
Subject: [PATCH] ima: Avoid blocking in RCU read-side critical section

A panic happens in ima_match_policy:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
PGD 42f873067 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 5 PID: 1286325 Comm: kubeletmonit.sh
Kdump: loaded Tainted: P
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
               BIOS 0.0.0 02/06/2015
RIP: 0010:ima_match_policy+0x84/0x450
Code: 49 89 fc 41 89 cf 31 ed 89 44 24 14 eb 1c 44 39
      7b 18 74 26 41 83 ff 05 74 20 48 8b 1b 48 3b 1d
      f2 b9 f4 00 0f 84 9c 01 00 00 <44> 85 73 10 74 ea
      44 8b 6b 14 41 f6 c5 01 75 d4 41 f6 c5 02 74 0f
RSP: 0018:ff71570009e07a80 EFLAGS: 00010207
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
RDX: ffffffffad8dc7c0 RSI: 0000000024924925 RDI: ff3e27850dea2000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffabfce739
R10: ff3e27810cc42400 R11: 0000000000000000 R12: ff3e2781825ef970
R13: 00000000ff3e2785 R14: 000000000000000c R15: 0000000000000001
FS:  00007f5195b51740(0000)
GS:ff3e278b12d40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 0000000626d24002 CR4: 0000000000361ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ima_get_action+0x22/0x30
 process_measurement+0xb0/0x830
 ? page_add_file_rmap+0x15/0x170
 ? alloc_set_pte+0x269/0x4c0
 ? prep_new_page+0x81/0x140
 ? simple_xattr_get+0x75/0xa0
 ? selinux_file_open+0x9d/0xf0
 ima_file_check+0x64/0x90
 path_openat+0x571/0x1720
 do_filp_open+0x9b/0x110
 ? page_counter_try_charge+0x57/0xc0
 ? files_cgroup_alloc_fd+0x38/0x60
 ? __alloc_fd+0xd4/0x250
 ? do_sys_open+0x1bd/0x250
 do_sys_open+0x1bd/0x250
 do_syscall_64+0x5d/0x1d0
 entry_SYSCALL_64_after_hwframe+0x65/0xca

Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
ima_filter_rule_match()") introduced call to ima_lsm_copy_rule within a
RCU read-side critical section which contains kmalloc with GFP_KERNEL.
This implies a possible sleep and violates limitations of RCU read-side
critical sections on non-PREEMPT systems.

Sleeping within RCU read-side critical section might cause
synchronize_rcu() returning early and break RCU protection, allowing a
UAF to happen.

The root cause of this issue could be described as follows:
|	Thread A	|	Thread B	|
|			|ima_match_policy	|
|			|  rcu_read_lock	|
|ima_lsm_update_rule	|			|
|  synchronize_rcu	|			|
|			|    kmalloc(GFP_KERNEL)|
|			|      sleep		|
==> synchronize_rcu returns early
|  kfree(entry)		|			|
|			|    entry = entry->next|
==> UAF happens and entry now becomes NULL (or could be anything).
|			|    entry->action	|
==> Accessing entry might cause panic.

To fix this issue, we are converting all kmalloc that is called within
RCU read-side critical section to use GFP_ATOMIC.

Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
Cc: stable@vger.kernel.org
Signed-off-by: GUO Zihua <guozihua@huawei.com>
Acked-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
[PM: fixed missing comment, long lines, !CONFIG_IMA_LSM_RULES case]
Signed-off-by: Paul Moore <paul@paul-moore.com>

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index f804b76cde44..44488b1ab9a9 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -413,7 +413,7 @@ LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
 
 #ifdef CONFIG_AUDIT
 LSM_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
-	 void **lsmrule)
+	 void **lsmrule, gfp_t gfp)
 LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
 LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
 LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
diff --git a/include/linux/security.h b/include/linux/security.h
index 21cf70346b33..de3af33e6ff5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2048,7 +2048,8 @@ static inline void security_key_post_create_or_update(struct key *keyring,
 
 #ifdef CONFIG_AUDIT
 #ifdef CONFIG_SECURITY
-int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
+int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
+			     gfp_t gfp);
 int security_audit_rule_known(struct audit_krule *krule);
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
@@ -2056,7 +2057,7 @@ void security_audit_rule_free(void *lsmrule);
 #else
 
 static inline int security_audit_rule_init(u32 field, u32 op, char *rulestr,
-					   void **lsmrule)
+					   void **lsmrule, gfp_t gfp)
 {
 	return 0;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index be8c680121e4..d6ef4f4f9cba 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -529,7 +529,8 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
 			entry->rule.buflen += f_val;
 			f->lsm_str = str;
 			err = security_audit_rule_init(f->type, f->op, str,
-						       (void **)&f->lsm_rule);
+						       (void **)&f->lsm_rule,
+						       GFP_KERNEL);
 			/* Keep currently invalid fields around in case they
 			 * become valid after a policy reload. */
 			if (err == -EINVAL) {
@@ -799,7 +800,7 @@ static inline int audit_dupe_lsm_field(struct audit_field *df,
 
 	/* our own (refreshed) copy of lsm_rule */
 	ret = security_audit_rule_init(df->type, df->op, df->lsm_str,
-				       (void **)&df->lsm_rule);
+				       (void **)&df->lsm_rule, GFP_KERNEL);
 	/* Keep currently invalid fields around in case they
 	 * become valid after a policy reload. */
 	if (ret == -EINVAL) {
diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 45beb1c5f747..6b5181c668b5 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -217,7 +217,7 @@ void aa_audit_rule_free(void *vrule)
 	}
 }
 
-int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
+int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule, gfp_t gfp)
 {
 	struct aa_audit_rule *rule;
 
@@ -230,14 +230,14 @@ int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 		return -EINVAL;
 	}
 
-	rule = kzalloc(sizeof(struct aa_audit_rule), GFP_KERNEL);
+	rule = kzalloc(sizeof(struct aa_audit_rule), gfp);
 
 	if (!rule)
 		return -ENOMEM;
 
 	/* Currently rules are treated as coming from the root ns */
 	rule->label = aa_label_parse(&root_ns->unconfined->label, rulestr,
-				     GFP_KERNEL, true, false);
+				     gfp, true, false);
 	if (IS_ERR(rule->label)) {
 		int err = PTR_ERR(rule->label);
 		aa_audit_rule_free(rule);
diff --git a/security/apparmor/include/audit.h b/security/apparmor/include/audit.h
index acbb03b9bd25..0c8cc86b417b 100644
--- a/security/apparmor/include/audit.h
+++ b/security/apparmor/include/audit.h
@@ -200,7 +200,7 @@ static inline int complain_error(int error)
 }
 
 void aa_audit_rule_free(void *vrule);
-int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule);
+int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule, gfp_t gfp);
 int aa_audit_rule_known(struct audit_krule *rule);
 int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule);
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3e568126cd48..c51e24d24d1e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -546,7 +546,7 @@ static inline void ima_free_modsig(struct modsig *modsig)
 #else
 
 static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
-				       void **lsmrule)
+				       void **lsmrule, gfp_t gfp)
 {
 	return -EINVAL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c0556907c2e6..09da8e639239 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -401,7 +401,8 @@ static void ima_free_rule(struct ima_rule_entry *entry)
 	kfree(entry);
 }
 
-static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
+static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry,
+						gfp_t gfp)
 {
 	struct ima_rule_entry *nentry;
 	int i;
@@ -410,7 +411,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	 * Immutable elements are copied over as pointers and data; only
 	 * lsm rules can change
 	 */
-	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
+	nentry = kmemdup(entry, sizeof(*nentry), gfp);
 	if (!nentry)
 		return NULL;
 
@@ -425,7 +426,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
-				     &nentry->lsm[i].rule);
+				     &nentry->lsm[i].rule,
+				     gfp);
 		if (!nentry->lsm[i].rule)
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				nentry->lsm[i].args_p);
@@ -438,7 +440,7 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
 	int i;
 	struct ima_rule_entry *nentry;
 
-	nentry = ima_lsm_copy_rule(entry);
+	nentry = ima_lsm_copy_rule(entry, GFP_KERNEL);
 	if (!nentry)
 		return -ENOMEM;
 
@@ -664,7 +666,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		}
 
 		if (rc == -ESTALE && !rule_reinitialized) {
-			lsm_rule = ima_lsm_copy_rule(rule);
+			lsm_rule = ima_lsm_copy_rule(rule, GFP_ATOMIC);
 			if (lsm_rule) {
 				rule_reinitialized = true;
 				goto retry;
@@ -1140,7 +1142,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	entry->lsm[lsm_rule].type = audit_type;
 	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
 				      entry->lsm[lsm_rule].args_p,
-				      &entry->lsm[lsm_rule].rule);
+				      &entry->lsm[lsm_rule].rule,
+				      GFP_KERNEL);
 	if (!entry->lsm[lsm_rule].rule) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
diff --git a/security/security.c b/security/security.c
index e5da848c50b9..e5ca08789f74 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5332,15 +5332,17 @@ void security_key_post_create_or_update(struct key *keyring, struct key *key,
  * @op: rule operator
  * @rulestr: rule context
  * @lsmrule: receive buffer for audit rule struct
+ * @gfp: GFP flag used for kmalloc
  *
  * Allocate and initialize an LSM audit rule structure.
  *
  * Return: Return 0 if @lsmrule has been successfully set, -EINVAL in case of
  *         an invalid rule.
  */
-int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
+int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
+			     gfp_t gfp)
 {
-	return call_int_hook(audit_rule_init, field, op, rulestr, lsmrule);
+	return call_int_hook(audit_rule_init, field, op, rulestr, lsmrule, gfp);
 }
 
 /**
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 52aca71210b4..29c7d4c86f6d 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -21,12 +21,14 @@
  *	@op: the operator the rule uses
  *	@rulestr: the text "target" of the rule
  *	@rule: pointer to the new rule structure returned via this
+ *	@gfp: GFP flag used for kmalloc
  *
  *	Returns 0 if successful, -errno if not.  On success, the rule structure
  *	will be allocated internally.  The caller must free this structure with
  *	selinux_audit_rule_free() after use.
  */
-int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **rule);
+int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **rule,
+			    gfp_t gfp);
 
 /**
  *	selinux_audit_rule_free - free an selinux audit rule structure.
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f20e1968b7f7..e33e55384b75 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3507,7 +3507,8 @@ void selinux_audit_rule_free(void *vrule)
 	}
 }
 
-int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
+int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
+			    gfp_t gfp)
 {
 	struct selinux_state *state = &selinux_state;
 	struct selinux_policy *policy;
@@ -3548,7 +3549,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 		return -EINVAL;
 	}
 
-	tmprule = kzalloc(sizeof(struct selinux_audit_rule), GFP_KERNEL);
+	tmprule = kzalloc(sizeof(struct selinux_audit_rule), gfp);
 	if (!tmprule)
 		return -ENOMEM;
 	context_init(&tmprule->au_ctxt);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 70ba2841e181..f5cbec1e6a92 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4693,11 +4693,13 @@ static int smack_post_notification(const struct cred *w_cred,
  * @op: required testing operator (=, !=, >, <, ...)
  * @rulestr: smack label to be audited
  * @vrule: pointer to save our own audit rule representation
+ * @gfp: type of the memory for the allocation
  *
  * Prepare to audit cases where (@field @op @rulestr) is true.
  * The label to be audited is created if necessay.
  */
-static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
+static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
+				 gfp_t gfp)
 {
 	struct smack_known *skp;
 	char **rule = (char **)vrule;


