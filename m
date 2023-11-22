Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93347F4E59
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 18:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344111AbjKVRZs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 12:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344228AbjKVRZq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 12:25:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F0B83
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 09:25:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA144C433C7;
        Wed, 22 Nov 2023 17:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700673943;
        bh=CoYWXf0W6j9yJoJ+oKD69scu7AsR8CgzUhbRzWIIZic=;
        h=Subject:To:Cc:From:Date:From;
        b=ZBQ1g88q6SnCHgUsbx9bOuHsoxcjhkBdvpFD7sGa/S/oeX2/Vk3B7k21J37oW5Y+o
         RdxahSqwN5eZkY3sejQLqP3ZD6Wvrd0mj+6hDjfWprgL7eAtf0uksJ/RBUMzRFZNWm
         Z4pVxmFNHUdzktUKjyd1uR0XCnQRi6kjev54RgfA=
Subject: FAILED: patch "[PATCH] apparmor: Fix regression in mount mediation" failed to apply to 5.15-stable tree
To:     john.johansen@canonical.com, anstein99@googlemail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 17:25:35 +0000
Message-ID: <2023112235-lumpish-zap-8c3f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 157a3537d6bc28ceb9a11fc8cb67f2152d860146
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112235-lumpish-zap-8c3f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

157a3537d6bc ("apparmor: Fix regression in mount mediation")
90c436a64a6e ("apparmor: pass cred through to audit info.")
d20f5a1a6e79 ("apparmor: rename audit_data->label to audit_data->subj_label")
bd7bd201ca46 ("apparmor: combine common_audit_data and apparmor_audit_data")
25ff0ff2d628 ("apparmor: Fix kernel-doc warnings in apparmor/policy.c")
13c1748e2170 ("apparmor: Fix kernel-doc warnings in apparmor/resource.c")
892148228611 ("apparmor: Fix kernel-doc warnings in apparmor/lib.c")
26c9ecb34f5f ("apparmor: Fix kernel-doc warnings in apparmor/audit.c")
76862af5d1ad ("apparmor: fix kernel-doc complaints")
665b1856dc23 ("apparmor: Fix loading of child before parent")
2f7a29debae2 ("apparmor: remove useless static inline functions")
65f7f666f21c ("apparmor: make __aa_path_perm() static")
1ad22fcc4d0d ("apparmor: rework profile->rules to be a list")
217af7e2f4de ("apparmor: refactor profile rules and attachments")
3bf3d728a58d ("apparmor: verify loaded permission bits masks don't overlap")
3dfd16ab697f ("apparmor: cleanup: move perm accumulation into perms.h")
0bece4fa97a2 ("apparmor: make sure perm indexes are accumulated")
670f31774ab6 ("apparmor: verify permission table indexes")
371e50a0b19f ("apparmor: make unpack_array return a trianary value")
ad596ea74e74 ("apparmor: group dfa policydb unpacking")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 157a3537d6bc28ceb9a11fc8cb67f2152d860146 Mon Sep 17 00:00:00 2001
From: John Johansen <john.johansen@canonical.com>
Date: Sun, 10 Sep 2023 03:35:22 -0700
Subject: [PATCH] apparmor: Fix regression in mount mediation

commit 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")

introduced a new move_mount(2) system call and a corresponding new LSM
security_move_mount hook but did not implement this hook for any
existing LSM. This creates a regression for AppArmor mediation of
mount. This patch provides a base mapping of the move_mount syscall to
the existing mount mediation. In the future we may introduce
additional mediations around the new mount calls.

Fixes: 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
CC: stable@vger.kernel.org
Reported-by: Andreas Steinmetz <anstein99@googlemail.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>

diff --git a/security/apparmor/include/mount.h b/security/apparmor/include/mount.h
index 10c76f906a65..46834f828179 100644
--- a/security/apparmor/include/mount.h
+++ b/security/apparmor/include/mount.h
@@ -38,9 +38,12 @@ int aa_mount_change_type(const struct cred *subj_cred,
 			 struct aa_label *label, const struct path *path,
 			 unsigned long flags);
 
+int aa_move_mount_old(const struct cred *subj_cred,
+		      struct aa_label *label, const struct path *path,
+		      const char *old_name);
 int aa_move_mount(const struct cred *subj_cred,
-		  struct aa_label *label, const struct path *path,
-		  const char *old_name);
+		  struct aa_label *label, const struct path *from_path,
+		  const struct path *to_path);
 
 int aa_new_mount(const struct cred *subj_cred,
 		 struct aa_label *label, const char *dev_name,
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index ce4f3e7a784d..b047d1d355a9 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -722,8 +722,8 @@ static int apparmor_sb_mount(const char *dev_name, const struct path *path,
 			error = aa_mount_change_type(current_cred(), label,
 						     path, flags);
 		else if (flags & MS_MOVE)
-			error = aa_move_mount(current_cred(), label, path,
-					      dev_name);
+			error = aa_move_mount_old(current_cred(), label, path,
+						  dev_name);
 		else
 			error = aa_new_mount(current_cred(), label, dev_name,
 					     path, type, flags, data);
@@ -733,6 +733,21 @@ static int apparmor_sb_mount(const char *dev_name, const struct path *path,
 	return error;
 }
 
+static int apparmor_move_mount(const struct path *from_path,
+			       const struct path *to_path)
+{
+	struct aa_label *label;
+	int error = 0;
+
+	label = __begin_current_label_crit_section();
+	if (!unconfined(label))
+		error = aa_move_mount(current_cred(), label, from_path,
+				      to_path);
+	__end_current_label_crit_section(label);
+
+	return error;
+}
+
 static int apparmor_sb_umount(struct vfsmount *mnt, int flags)
 {
 	struct aa_label *label;
@@ -1376,6 +1391,7 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capget, apparmor_capget),
 	LSM_HOOK_INIT(capable, apparmor_capable),
 
+	LSM_HOOK_INIT(move_mount, apparmor_move_mount),
 	LSM_HOOK_INIT(sb_mount, apparmor_sb_mount),
 	LSM_HOOK_INIT(sb_umount, apparmor_sb_umount),
 	LSM_HOOK_INIT(sb_pivotroot, apparmor_sb_pivotroot),
diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index 3455dd4b1f99..fb30204c761a 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -483,36 +483,46 @@ int aa_mount_change_type(const struct cred *subj_cred,
 }
 
 int aa_move_mount(const struct cred *subj_cred,
-		  struct aa_label *label, const struct path *path,
-		  const char *orig_name)
+		  struct aa_label *label, const struct path *from_path,
+		  const struct path *to_path)
 {
 	struct aa_profile *profile;
-	char *buffer = NULL, *old_buffer = NULL;
-	struct path old_path;
+	char *to_buffer = NULL, *from_buffer = NULL;
 	int error;
 
 	AA_BUG(!label);
-	AA_BUG(!path);
+	AA_BUG(!from_path);
+	AA_BUG(!to_path);
+
+	to_buffer = aa_get_buffer(false);
+	from_buffer = aa_get_buffer(false);
+	error = -ENOMEM;
+	if (!to_buffer || !from_buffer)
+		goto out;
+	error = fn_for_each_confined(label, profile,
+			match_mnt(subj_cred, profile, to_path, to_buffer,
+				  from_path, from_buffer,
+				  NULL, MS_MOVE, NULL, false));
+out:
+	aa_put_buffer(to_buffer);
+	aa_put_buffer(from_buffer);
+
+	return error;
+}
+
+int aa_move_mount_old(const struct cred *subj_cred, struct aa_label *label,
+		      const struct path *path, const char *orig_name)
+{
+	struct path old_path;
+	int error;
 
 	if (!orig_name || !*orig_name)
 		return -EINVAL;
-
 	error = kern_path(orig_name, LOOKUP_FOLLOW, &old_path);
 	if (error)
 		return error;
 
-	buffer = aa_get_buffer(false);
-	old_buffer = aa_get_buffer(false);
-	error = -ENOMEM;
-	if (!buffer || !old_buffer)
-		goto out;
-	error = fn_for_each_confined(label, profile,
-			match_mnt(subj_cred, profile, path, buffer, &old_path,
-				  old_buffer,
-				  NULL, MS_MOVE, NULL, false));
-out:
-	aa_put_buffer(buffer);
-	aa_put_buffer(old_buffer);
+	error = aa_move_mount(subj_cred, label, &old_path, path);
 	path_put(&old_path);
 
 	return error;

