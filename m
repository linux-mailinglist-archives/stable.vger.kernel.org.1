Return-Path: <stable+bounces-64411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4180B941DB6
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C871F279B0
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4531A76B0;
	Tue, 30 Jul 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i3u7PVlN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB21A76B3;
	Tue, 30 Jul 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360035; cv=none; b=PcSsXyOk7JXO4JZX2EIZxYDWpIhVBSsN8FR9ECfueKpfmrtq7N/ix3cYPAG/sdW3QPF62kaFkerdvTE/zmevTjC7tLcxgWnAcmPFE2KWEY8Kuua+Fvb55VgVyHtMfvexTP1hFKg8bF5attxciZ/TwqL36njkxK/Q/pDBY4cOk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360035; c=relaxed/simple;
	bh=/HuYw87GkFBgE/EZkpDfkiCS77Rn3ImMdXXtrInc2Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZcgIteGSeMJCrGzVbDuoVF44T6YP38fJpMMdewkiEhllVEh0P8X2eqgMZzQQtzgThK184EOkjSxsVki71gCeiZ0UBt0WAvKDqr61XIs3lmZ3KIHeAY1nNZpaZ/l/uFkyoGr5pLKmxWLB2tVNuSMLQsaRXM9bFP4VVq3lC9GhQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i3u7PVlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26129C4AF0E;
	Tue, 30 Jul 2024 17:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360035;
	bh=/HuYw87GkFBgE/EZkpDfkiCS77Rn3ImMdXXtrInc2Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3u7PVlN7P5t1dLEmrvv8I9KtN5yC7BuafCyFILdBouwaMMttmj67p/DQ38pcNtpj
	 4xAmiZkdRjnSSHM+1/NLXVg6fHGFtFyBdr5KhLULdnst48JX59ajjXSa1BIMLMm51i
	 MHtxQguNddUgPIoCN15/tvLzAfwborVyEpp+UwuY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Casey Schaufler <casey@schaufler-ca.com>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 6.10 576/809] lsm: fixup the inode xattr capability handling
Date: Tue, 30 Jul 2024 17:47:32 +0200
Message-ID: <20240730151747.528652208@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Moore <paul@paul-moore.com>

commit 61df7b82820494368bd46071ca97e43a3dfc3b11 upstream.

The current security_inode_setxattr() and security_inode_removexattr()
hooks rely on individual LSMs to either call into the associated
capability hooks (cap_inode_setxattr() or cap_inode_removexattr()), or
return a magic value of 1 to indicate that the LSM layer itself should
perform the capability checks.  Unfortunately, with the default return
value for these LSM hooks being 0, an individual LSM hook returning a
1 will cause the LSM hook processing to exit early, potentially
skipping a LSM.  Thankfully, with the exception of the BPF LSM, none
of the LSMs which currently register inode xattr hooks should end up
returning a value of 1, and in the BPF LSM case, with the BPF LSM hooks
executing last there should be no real harm in stopping processing of
the LSM hooks.  However, the reliance on the individual LSMs to either
call the capability hooks themselves, or signal the LSM with a return
value of 1, is fragile and relies on a specific set of LSMs being
enabled.  This patch is an effort to resolve, or minimize, these
issues.

Before we discuss the solution, there are a few observations and
considerations that we need to take into account:
* BPF LSM registers an implementation for every LSM hook, and that
  implementation simply returns the hook's default return value, a
  0 in this case.  We want to ensure that the default BPF LSM behavior
  results in the capability checks being called.
* SELinux and Smack do not expect the traditional capability checks
  to be applied to the xattrs that they "own".
* SELinux and Smack are currently written in such a way that the
  xattr capability checks happen before any additional LSM specific
  access control checks.  SELinux does apply SELinux specific access
  controls to all xattrs, even those not "owned" by SELinux.
* IMA and EVM also register xattr hooks but assume that the LSM layer
  and specific LSMs have already authorized the basic xattr operation.

In order to ensure we perform the capability based access controls
before the individual LSM access controls, perform only one capability
access control check for each operation, and clarify the logic around
applying the capability controls, we need a mechanism to determine if
any of the enabled LSMs "own" a particular xattr and want to take
responsibility for controlling access to that xattr.  The solution in
this patch is to create a new LSM hook, 'inode_xattr_skipcap', that is
not exported to the rest of the kernel via a security_XXX() function,
but is used by the LSM layer to determine if a LSM wants to control
access to a given xattr and avoid the traditional capability controls.
Registering an inode_xattr_skipcap hook is optional, if a LSM declines
to register an implementation, or uses an implementation that simply
returns the default value (0), there is no effect as the LSM continues
to enforce the capability based controls (unless another LSM takes
ownership of the xattr).  If none of the LSMs signal that the
capability checks should be skipped, the capability check is performed
and if access is granted the individual LSM xattr access control hooks
are executed, keeping with the DAC-before-LSM convention.

Cc: stable@vger.kernel.org
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/lsm_hook_defs.h |    1 
 security/security.c           |   70 ++++++++++++++++++++++++++++--------------
 security/selinux/hooks.c      |   28 ++++++++++++----
 security/smack/smack_lsm.c    |   31 +++++++++++++++++-
 4 files changed, 98 insertions(+), 32 deletions(-)

--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -144,6 +144,7 @@ LSM_HOOK(int, 0, inode_setattr, struct m
 LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, int ia_valid)
 LSM_HOOK(int, 0, inode_getattr, const struct path *path)
+LSM_HOOK(int, 0, inode_xattr_skipcap, const char *name)
 LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name, const void *value,
 	 size_t size, int flags)
--- a/security/security.c
+++ b/security/security.c
@@ -2278,7 +2278,20 @@ int security_inode_getattr(const struct
  * @size: size of xattr value
  * @flags: flags
  *
- * Check permission before setting the extended attributes.
+ * This hook performs the desired permission checks before setting the extended
+ * attributes (xattrs) on @dentry.  It is important to note that we have some
+ * additional logic before the main LSM implementation calls to detect if we
+ * need to perform an additional capability check at the LSM layer.
+ *
+ * Normally we enforce a capability check prior to executing the various LSM
+ * hook implementations, but if a LSM wants to avoid this capability check,
+ * it can register a 'inode_xattr_skipcap' hook and return a value of 1 for
+ * xattrs that it wants to avoid the capability check, leaving the LSM fully
+ * responsible for enforcing the access control for the specific xattr.  If all
+ * of the enabled LSMs refrain from registering a 'inode_xattr_skipcap' hook,
+ * or return a 0 (the default return value), the capability check is still
+ * performed.  If no 'inode_xattr_skipcap' hooks are registered the capability
+ * check is performed.
  *
  * Return: Returns 0 if permission is granted.
  */
@@ -2286,20 +2299,20 @@ int security_inode_setxattr(struct mnt_i
 			    struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
 {
-	int ret;
+	int rc;
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	/*
-	 * SELinux and Smack integrate the cap call,
-	 * so assume that all LSMs supplying this call do so.
-	 */
-	ret = call_int_hook(inode_setxattr, idmap, dentry, name, value, size,
-			    flags);
 
-	if (ret == 1)
-		ret = cap_inode_setxattr(dentry, name, value, size, flags);
-	return ret;
+	/* enforce the capability checks at the lsm layer, if needed */
+	if (!call_int_hook(inode_xattr_skipcap, name)) {
+		rc = cap_inode_setxattr(dentry, name, value, size, flags);
+		if (rc)
+			return rc;
+	}
+
+	return call_int_hook(inode_setxattr, idmap, dentry, name, value, size,
+			     flags);
 }
 
 /**
@@ -2452,26 +2465,39 @@ int security_inode_listxattr(struct dent
  * @dentry: file
  * @name: xattr name
  *
- * Check permission before removing the extended attribute identified by @name
- * for @dentry.
+ * This hook performs the desired permission checks before setting the extended
+ * attributes (xattrs) on @dentry.  It is important to note that we have some
+ * additional logic before the main LSM implementation calls to detect if we
+ * need to perform an additional capability check at the LSM layer.
+ *
+ * Normally we enforce a capability check prior to executing the various LSM
+ * hook implementations, but if a LSM wants to avoid this capability check,
+ * it can register a 'inode_xattr_skipcap' hook and return a value of 1 for
+ * xattrs that it wants to avoid the capability check, leaving the LSM fully
+ * responsible for enforcing the access control for the specific xattr.  If all
+ * of the enabled LSMs refrain from registering a 'inode_xattr_skipcap' hook,
+ * or return a 0 (the default return value), the capability check is still
+ * performed.  If no 'inode_xattr_skipcap' hooks are registered the capability
+ * check is performed.
  *
  * Return: Returns 0 if permission is granted.
  */
 int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name)
 {
-	int ret;
+	int rc;
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	/*
-	 * SELinux and Smack integrate the cap call,
-	 * so assume that all LSMs supplying this call do so.
-	 */
-	ret = call_int_hook(inode_removexattr, idmap, dentry, name);
-	if (ret == 1)
-		ret = cap_inode_removexattr(idmap, dentry, name);
-	return ret;
+
+	/* enforce the capability checks at the lsm layer, if needed */
+	if (!call_int_hook(inode_xattr_skipcap, name)) {
+		rc = cap_inode_removexattr(idmap, dentry, name);
+		if (rc)
+			return rc;
+	}
+
+	return call_int_hook(inode_removexattr, idmap, dentry, name);
 }
 
 /**
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3177,6 +3177,23 @@ static bool has_cap_mac_admin(bool audit
 	return true;
 }
 
+/**
+ * selinux_inode_xattr_skipcap - Skip the xattr capability checks?
+ * @name: name of the xattr
+ *
+ * Returns 1 to indicate that SELinux "owns" the access control rights to xattrs
+ * named @name; the LSM layer should avoid enforcing any traditional
+ * capability based access controls on this xattr.  Returns 0 to indicate that
+ * SELinux does not "own" the access control rights to xattrs named @name and is
+ * deferring to the LSM layer for further access controls, including capability
+ * based controls.
+ */
+static int selinux_inode_xattr_skipcap(const char *name)
+{
+	/* require capability check if not a selinux xattr */
+	return !strcmp(name, XATTR_NAME_SELINUX);
+}
+
 static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 				  struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
@@ -3188,15 +3205,9 @@ static int selinux_inode_setxattr(struct
 	u32 newsid, sid = current_sid();
 	int rc = 0;
 
-	if (strcmp(name, XATTR_NAME_SELINUX)) {
-		rc = cap_inode_setxattr(dentry, name, value, size, flags);
-		if (rc)
-			return rc;
-
-		/* Not an attribute we recognize, so just check the
-		   ordinary setattr permission. */
+	/* if not a selinux xattr, only check the ordinary setattr perm */
+	if (strcmp(name, XATTR_NAME_SELINUX))
 		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
-	}
 
 	if (!selinux_initialized())
 		return (inode_owner_or_capable(idmap, inode) ? 0 : -EPERM);
@@ -7175,6 +7186,7 @@ static struct security_hook_list selinux
 	LSM_HOOK_INIT(inode_permission, selinux_inode_permission),
 	LSM_HOOK_INIT(inode_setattr, selinux_inode_setattr),
 	LSM_HOOK_INIT(inode_getattr, selinux_inode_getattr),
+	LSM_HOOK_INIT(inode_xattr_skipcap, selinux_inode_xattr_skipcap),
 	LSM_HOOK_INIT(inode_setxattr, selinux_inode_setxattr),
 	LSM_HOOK_INIT(inode_post_setxattr, selinux_inode_post_setxattr),
 	LSM_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1283,6 +1283,33 @@ static int smack_inode_getattr(const str
 }
 
 /**
+ * smack_inode_xattr_skipcap - Skip the xattr capability checks?
+ * @name: name of the xattr
+ *
+ * Returns 1 to indicate that Smack "owns" the access control rights to xattrs
+ * named @name; the LSM layer should avoid enforcing any traditional
+ * capability based access controls on this xattr.  Returns 0 to indicate that
+ * Smack does not "own" the access control rights to xattrs named @name and is
+ * deferring to the LSM layer for further access controls, including capability
+ * based controls.
+ */
+static int smack_inode_xattr_skipcap(const char *name)
+{
+	if (strncmp(name, XATTR_SMACK_SUFFIX, strlen(XATTR_SMACK_SUFFIX)))
+		return 0;
+
+	if (strcmp(name, XATTR_NAME_SMACK) == 0 ||
+	    strcmp(name, XATTR_NAME_SMACKIPIN) == 0 ||
+	    strcmp(name, XATTR_NAME_SMACKIPOUT) == 0 ||
+	    strcmp(name, XATTR_NAME_SMACKEXEC) == 0 ||
+	    strcmp(name, XATTR_NAME_SMACKMMAP) == 0 ||
+	    strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0)
+		return 1;
+
+	return 0;
+}
+
+/**
  * smack_inode_setxattr - Smack check for setting xattrs
  * @idmap: idmap of the mount
  * @dentry: the object
@@ -1325,8 +1352,7 @@ static int smack_inode_setxattr(struct m
 		    size != TRANS_TRUE_SIZE ||
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			rc = -EINVAL;
-	} else
-		rc = cap_inode_setxattr(dentry, name, value, size, flags);
+	}
 
 	if (check_priv && !smack_privileged(CAP_MAC_ADMIN))
 		rc = -EPERM;
@@ -5053,6 +5079,7 @@ static struct security_hook_list smack_h
 	LSM_HOOK_INIT(inode_permission, smack_inode_permission),
 	LSM_HOOK_INIT(inode_setattr, smack_inode_setattr),
 	LSM_HOOK_INIT(inode_getattr, smack_inode_getattr),
+	LSM_HOOK_INIT(inode_xattr_skipcap, smack_inode_xattr_skipcap),
 	LSM_HOOK_INIT(inode_setxattr, smack_inode_setxattr),
 	LSM_HOOK_INIT(inode_post_setxattr, smack_inode_post_setxattr),
 	LSM_HOOK_INIT(inode_getxattr, smack_inode_getxattr),



