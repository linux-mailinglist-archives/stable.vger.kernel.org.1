Return-Path: <stable+bounces-78521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A16098BED9
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8CB1F22BDC
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D7A1C243B;
	Tue,  1 Oct 2024 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QPGBZ/v4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637BD19C54A
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791416; cv=none; b=kgbRf7nAY3n3Rpu1qMYbOeQyydxalZtrZhStOp/zUlp0mEukRiYTKCMhzla67TlP42gjBZA48Ah/yOVlTcPtTucFYZOg9MutIWQmVT8iaCmOT5XQP/NKKb/9J+Rp6HzgyxoXb2p32RZ4aS3ZE2ZLjYhe7F8xkqIHC0GfSPBB218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791416; c=relaxed/simple;
	bh=YB0SDM32uBjA6xPaPzuP/xUjFXCcPEWmokApxZxx1nw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FgI/PfGykY93f15O0lOC20gp4Z1WZTSuJYLcny2cnABtyoMqIjmIDXpmD7QD1k9Rw1sUmdUfvR1AX3xni2dUsTmJJLCzOc3WAtThyvq51gFuNy9CFTKvdqBkm+Lm0V8BO+JDjD5BSocRowAA3R/VxFF7xFEnD5JxjGFbkKvmP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QPGBZ/v4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5404C4CEC6;
	Tue,  1 Oct 2024 14:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727791416;
	bh=YB0SDM32uBjA6xPaPzuP/xUjFXCcPEWmokApxZxx1nw=;
	h=Subject:To:Cc:From:Date:From;
	b=QPGBZ/v4Lqq29kydPxmL962/lhOr8jfqOaHIlOgSRXjIr/RtVZmn5jiNxFvrbVUI5
	 AACNQCQImvqBhAZa80b9dmWl8mP/oZUa8SgSXOH2dANxV9iNyfDjdnr5y6Oyf+wAA/
	 I2ZxBAofRWC0ESOWSVh1GbD/NmP84NBBq4dUuFMI=
Subject: FAILED: patch "[PATCH] lsm: add the inode_free_security_rcu() LSM implementation" failed to apply to 6.1-stable tree
To: paul@paul-moore.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 16:03:30 +0200
Message-ID: <2024100130-superior-viewpoint-e91a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 63dff3e48871b0583be5032ff8fb7260c349a18c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100130-superior-viewpoint-e91a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

63dff3e48871 ("lsm: add the inode_free_security_rcu() LSM implementation hook")
4de2f084fbff ("ima: Make it independent from 'integrity' LSM")
75a323e604fc ("evm: Make it independent from 'integrity' LSM")
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

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 63dff3e48871b0583be5032ff8fb7260c349a18c Mon Sep 17 00:00:00 2001
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Jul 2024 19:43:06 -0400
Subject: [PATCH] lsm: add the inode_free_security_rcu() LSM implementation
 hook

The LSM framework has an existing inode_free_security() hook which
is used by LSMs that manage state associated with an inode, but
due to the use of RCU to protect the inode, special care must be
taken to ensure that the LSMs do not fully release the inode state
until it is safe from a RCU perspective.

This patch implements a new inode_free_security_rcu() implementation
hook which is called when it is safe to free the LSM's internal inode
state.  Unfortunately, this new hook does not have access to the inode
itself as it may already be released, so the existing
inode_free_security() hook is retained for those LSMs which require
access to the inode.

Cc: stable@vger.kernel.org
Reported-by: syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/00000000000076ba3b0617f65cc8@google.com
Signed-off-by: Paul Moore <paul@paul-moore.com>

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 63e2656d1d56..520730fe2d94 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -114,6 +114,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
 	 unsigned int obj_type)
 LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
+LSM_HOOK(void, LSM_RET_VOID, inode_free_security_rcu, void *inode_security)
 LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
 	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
 	 int *xattr_count)
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c51e24d24d1e..3c323ca213d4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -223,7 +223,7 @@ static inline void ima_inode_set_iint(const struct inode *inode,
 
 struct ima_iint_cache *ima_iint_find(struct inode *inode);
 struct ima_iint_cache *ima_inode_get(struct inode *inode);
-void ima_inode_free(struct inode *inode);
+void ima_inode_free_rcu(void *inode_security);
 void __init ima_iintcache_init(void);
 
 extern const int read_idmap[];
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index e23412a2c56b..00b249101f98 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -109,22 +109,18 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
 }
 
 /**
- * ima_inode_free - Called on inode free
- * @inode: Pointer to the inode
+ * ima_inode_free_rcu - Called to free an inode via a RCU callback
+ * @inode_security: The inode->i_security pointer
  *
- * Free the iint associated with an inode.
+ * Free the IMA data associated with an inode.
  */
-void ima_inode_free(struct inode *inode)
+void ima_inode_free_rcu(void *inode_security)
 {
-	struct ima_iint_cache *iint;
+	struct ima_iint_cache **iint_p = inode_security + ima_blob_sizes.lbs_inode;
 
-	if (!IS_IMA(inode))
-		return;
-
-	iint = ima_iint_find(inode);
-	ima_inode_set_iint(inode, NULL);
-
-	ima_iint_free(iint);
+	/* *iint_p should be NULL if !IS_IMA(inode) */
+	if (*iint_p)
+		ima_iint_free(*iint_p);
 }
 
 static void ima_iint_init_once(void *foo)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f04f43af651c..5b3394864b21 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1193,7 +1193,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
 	LSM_HOOK_INIT(kernel_module_request, ima_kernel_module_request),
 #endif
-	LSM_HOOK_INIT(inode_free_security, ima_inode_free),
+	LSM_HOOK_INIT(inode_free_security_rcu, ima_inode_free_rcu),
 };
 
 static const struct lsm_id ima_lsmid = {
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 7877a64cc6b8..0804f76a67be 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1207,13 +1207,16 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 
 /* Inode hooks */
 
-static void hook_inode_free_security(struct inode *const inode)
+static void hook_inode_free_security_rcu(void *inode_security)
 {
+	struct landlock_inode_security *inode_sec;
+
 	/*
 	 * All inodes must already have been untied from their object by
 	 * release_inode() or hook_sb_delete().
 	 */
-	WARN_ON_ONCE(landlock_inode(inode)->object);
+	inode_sec = inode_security + landlock_blob_sizes.lbs_inode;
+	WARN_ON_ONCE(inode_sec->object);
 }
 
 /* Super-block hooks */
@@ -1637,7 +1640,7 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
-	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
+	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
 
 	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
 	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
diff --git a/security/security.c b/security/security.c
index b316e6586be2..611d3c124ba6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1609,9 +1609,8 @@ int security_inode_alloc(struct inode *inode)
 
 static void inode_free_by_rcu(struct rcu_head *head)
 {
-	/*
-	 * The rcu head is at the start of the inode blob
-	 */
+	/* The rcu head is at the start of the inode blob */
+	call_void_hook(inode_free_security_rcu, head);
 	kmem_cache_free(lsm_inode_cache, head);
 }
 
@@ -1619,23 +1618,24 @@ static void inode_free_by_rcu(struct rcu_head *head)
  * security_inode_free() - Free an inode's LSM blob
  * @inode: the inode
  *
- * Deallocate the inode security structure and set @inode->i_security to NULL.
+ * Release any LSM resources associated with @inode, although due to the
+ * inode's RCU protections it is possible that the resources will not be
+ * fully released until after the current RCU grace period has elapsed.
+ *
+ * It is important for LSMs to note that despite being present in a call to
+ * security_inode_free(), @inode may still be referenced in a VFS path walk
+ * and calls to security_inode_permission() may be made during, or after,
+ * a call to security_inode_free().  For this reason the inode->i_security
+ * field is released via a call_rcu() callback and any LSMs which need to
+ * retain inode state for use in security_inode_permission() should only
+ * release that state in the inode_free_security_rcu() LSM hook callback.
  */
 void security_inode_free(struct inode *inode)
 {
 	call_void_hook(inode_free_security, inode);
-	/*
-	 * The inode may still be referenced in a path walk and
-	 * a call to security_inode_permission() can be made
-	 * after inode_free_security() is called. Ideally, the VFS
-	 * wouldn't do this, but fixing that is a much harder
-	 * job. For now, simply free the i_security via RCU, and
-	 * leave the current inode->i_security pointer intact.
-	 * The inode will be freed after the RCU grace period too.
-	 */
-	if (inode->i_security)
-		call_rcu((struct rcu_head *)inode->i_security,
-			 inode_free_by_rcu);
+	if (!inode->i_security)
+		return;
+	call_rcu((struct rcu_head *)inode->i_security, inode_free_by_rcu);
 }
 
 /**


