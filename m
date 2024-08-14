Return-Path: <stable+bounces-67686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E25A952165
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 19:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3AC1F23348
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 17:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6F81BBBE4;
	Wed, 14 Aug 2024 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rDCgZZo2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C71B32D2
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657151; cv=none; b=Oe8SNOMey7MHdZQfNWblP5y2R0G821PVe292ERwgl46Dcdr79pvnBWGsyMvxm1/N+hAFWjV0NxFsSP8YGMv/O8CVBXt93GayqcOGrKzTmCCBotvD6ltTgxK04MwxOeK52CRcqU/74NYVfQl1awvUKcKOjFR5a6cZ57+pzcnYLAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657151; c=relaxed/simple;
	bh=GW3hQGXNEaHpO0OQSPm7FpNNguLp79U5O1lUSS9XyCU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=od/8sXZAn7/ycEfoV4T6keSv/UCqmYQN1NdrTcesDk15ku/bc4pqua3JkEwD6a2CSdFwT4FIFE+S93wzRLnQW1RbwLFVHAdEDsHGlsKtHar2U0HpW5g3ZX/f0SIg3tU6Sws4aa91RmlYN5Q6otbJa2gz+YQPXdh2qqqCz8LRf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rDCgZZo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02919C116B1;
	Wed, 14 Aug 2024 17:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723657150;
	bh=GW3hQGXNEaHpO0OQSPm7FpNNguLp79U5O1lUSS9XyCU=;
	h=Subject:To:Cc:From:Date:From;
	b=rDCgZZo2T40+htAWy94iM7+P08gW4Pf4dbZoj4txPfGKBHCCBV8fW9IPU6h6QPyR4
	 XSWksOZOIg76HSWHY5qjBvFkin1y+d3/VCTbD2jE2pYzD9gEQXVF6aZNwkRFjdo1BE
	 OJLU2xueagjR/6OvTWNzHcLUtvHU4quEzV2YrY5M=
Subject: FAILED: patch "[PATCH] exec: Fix ToCToU between perm check and set-uid/gid usage" failed to apply to 5.10-stable tree
To: kees@kernel.org,brauner@kernel.org,ebiederm@xmission.com,mvanotti@google.com,torvalds@linux-foundation.org,viro@zeniv.linux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Aug 2024 19:39:06 +0200
Message-ID: <2024081405-fender-shortcut-a18f@gregkh>
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
git cherry-pick -x f50733b45d865f91db90919f8311e2127ce5a0cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081405-fender-shortcut-a18f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

f50733b45d86 ("exec: Fix ToCToU between perm check and set-uid/gid usage")
e67fe63341b8 ("fs: port i_{g,u}id_into_vfs{g,u}id() to mnt_idmap")
9452e93e6dae ("fs: port privilege checking helpers to mnt_idmap")
f2d40141d5d9 ("fs: port inode_init_owner() to mnt_idmap")
4609e1f18e19 ("fs: port ->permission() to pass mnt_idmap")
13e83a4923be ("fs: port ->set_acl() to pass mnt_idmap")
77435322777d ("fs: port ->get_acl() to pass mnt_idmap")
011e2b717b1b ("fs: port ->tmpfile() to pass mnt_idmap")
5ebb29bee8d5 ("fs: port ->mknod() to pass mnt_idmap")
c54bd91e9eab ("fs: port ->mkdir() to pass mnt_idmap")
7a77db95511c ("fs: port ->symlink() to pass mnt_idmap")
6c960e68aaed ("fs: port ->create() to pass mnt_idmap")
b74d24f7a74f ("fs: port ->getattr() to pass mnt_idmap")
c1632a0f1120 ("fs: port ->setattr() to pass mnt_idmap")
abf08576afe3 ("fs: port vfs_*() helpers to struct mnt_idmap")
6022ec6ee2c3 ("Merge tag 'ntfs3_for_6.2' of https://github.com/Paragon-Software-Group/linux-ntfs3")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f50733b45d865f91db90919f8311e2127ce5a0cb Mon Sep 17 00:00:00 2001
From: Kees Cook <kees@kernel.org>
Date: Thu, 8 Aug 2024 11:39:08 -0700
Subject: [PATCH] exec: Fix ToCToU between perm check and set-uid/gid usage

When opening a file for exec via do_filp_open(), permission checking is
done against the file's metadata at that moment, and on success, a file
pointer is passed back. Much later in the execve() code path, the file
metadata (specifically mode, uid, and gid) is used to determine if/how
to set the uid and gid. However, those values may have changed since the
permissions check, meaning the execution may gain unintended privileges.

For example, if a file could change permissions from executable and not
set-id:

---------x 1 root root 16048 Aug  7 13:16 target

to set-id and non-executable:

---S------ 1 root root 16048 Aug  7 13:16 target

it is possible to gain root privileges when execution should have been
disallowed.

While this race condition is rare in real-world scenarios, it has been
observed (and proven exploitable) when package managers are updating
the setuid bits of installed programs. Such files start with being
world-executable but then are adjusted to be group-exec with a set-uid
bit. For example, "chmod o-x,u+s target" makes "target" executable only
by uid "root" and gid "cdrom", while also becoming setuid-root:

-rwxr-xr-x 1 root cdrom 16048 Aug  7 13:16 target

becomes:

-rwsr-xr-- 1 root cdrom 16048 Aug  7 13:16 target

But racing the chmod means users without group "cdrom" membership can
get the permission to execute "target" just before the chmod, and when
the chmod finishes, the exec reaches brpm_fill_uid(), and performs the
setuid to root, violating the expressed authorization of "only cdrom
group members can setuid to root".

Re-check that we still have execute permissions in case the metadata
has changed. It would be better to keep a copy from the perm-check time,
but until we can do that refactoring, the least-bad option is to do a
full inode_permission() call (under inode lock). It is understood that
this is safe against dead-locks, but hardly optimal.

Reported-by: Marco Vanotti <mvanotti@google.com>
Tested-by: Marco Vanotti <mvanotti@google.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>

diff --git a/fs/exec.c b/fs/exec.c
index a126e3d1cacb..50e76cc633c4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1692,6 +1692,7 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	unsigned int mode;
 	vfsuid_t vfsuid;
 	vfsgid_t vfsgid;
+	int err;
 
 	if (!mnt_may_suid(file->f_path.mnt))
 		return;
@@ -1708,12 +1709,17 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	/* Be careful if suid/sgid is set */
 	inode_lock(inode);
 
-	/* reload atomically mode/uid/gid now that lock held */
+	/* Atomically reload and check mode/uid/gid now that lock held. */
 	mode = inode->i_mode;
 	vfsuid = i_uid_into_vfsuid(idmap, inode);
 	vfsgid = i_gid_into_vfsgid(idmap, inode);
+	err = inode_permission(idmap, inode, MAY_EXEC);
 	inode_unlock(inode);
 
+	/* Did the exec bit vanish out from under us? Give up. */
+	if (err)
+		return;
+
 	/* We ignore suid/sgid if there are no mappings for them in the ns */
 	if (!vfsuid_has_mapping(bprm->cred->user_ns, vfsuid) ||
 	    !vfsgid_has_mapping(bprm->cred->user_ns, vfsgid))


