Return-Path: <stable+bounces-35997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDDB89952F
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5411C217F2
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9615A22612;
	Fri,  5 Apr 2024 06:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gbPQbAwa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535042232B
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297982; cv=none; b=uSihxHgR5FdCZYoiHqbvK+KwOM/28EEmhfAdgN/ZWhCMcNQFlp/UgIrStbhpTrZ3fY2sXdDrBOBlaAjJoxqmvCK18iDgmR24FIuoVxvC7xlZuAvBRSba7ZxUlg/DZTpJyEjUSTr5+mvQA+K45XsBOO8BlvtuhnxvVrLzU/aFdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297982; c=relaxed/simple;
	bh=7U+gbWZyIhMBSmNjD3iq2zOhXw97j5GMNCccXnqVQ84=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=leC4DjldVoqAiCVP6qnfU/Lon404qmx8W+XYhY07rObjDALfTJWKgOohDF+/dsd0cWt5G0s+Uvue1MEZ8OoUk1KJA/hv4e1MdgOuspzb1a37enXVTdPa4we0gme2R/K+Rb38KJeshJsqcwx8+3U3XMfZJ01C0oYkIcESwZK2J+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gbPQbAwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A530C433C7;
	Fri,  5 Apr 2024 06:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712297981;
	bh=7U+gbWZyIhMBSmNjD3iq2zOhXw97j5GMNCccXnqVQ84=;
	h=Subject:To:Cc:From:Date:From;
	b=gbPQbAwauRx6CMvwQyTiKZY783naqRBLrsxEgsv0k16vWsJspiSIijqA1U4R+UupM
	 t+6ggnM568kAKGFgQWrUYsGMi5rUjWV0AufoAQaafFdyTukFrMcpOcas6JfDFeaeOO
	 FjgmZjU2ewr7PDmCEBmxZVLmOUHUupNp0T9gTTDc=
Subject: FAILED: patch "[PATCH] selinux: avoid dereference of garbage after mount failure" failed to apply to 5.4-stable tree
To: cgzones@googlemail.com,paul@paul-moore.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 08:19:38 +0200
Message-ID: <2024040538-clip-legwarmer-18fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 37801a36b4d68892ce807264f784d818f8d0d39b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040538-clip-legwarmer-18fc@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

37801a36b4d6 ("selinux: avoid dereference of garbage after mount failure")
cd2bb4cb0996 ("selinux: mark some global variables __ro_after_init")
db478cd60d55 ("selinux: make selinuxfs_mount static")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 37801a36b4d68892ce807264f784d818f8d0d39b Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Thu, 28 Mar 2024 20:16:58 +0100
Subject: [PATCH] selinux: avoid dereference of garbage after mount failure
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In case kern_mount() fails and returns an error pointer return in the
error branch instead of continuing and dereferencing the error pointer.

While on it drop the never read static variable selinuxfs_mount.

Cc: stable@vger.kernel.org
Fixes: 0619f0f5e36f ("selinux: wrap selinuxfs state")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 0619a1cbbfbe..074d6c2714eb 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2123,7 +2123,6 @@ static struct file_system_type sel_fs_type = {
 	.kill_sb	= sel_kill_sb,
 };
 
-static struct vfsmount *selinuxfs_mount __ro_after_init;
 struct path selinux_null __ro_after_init;
 
 static int __init init_sel_fs(void)
@@ -2145,18 +2144,21 @@ static int __init init_sel_fs(void)
 		return err;
 	}
 
-	selinux_null.mnt = selinuxfs_mount = kern_mount(&sel_fs_type);
-	if (IS_ERR(selinuxfs_mount)) {
+	selinux_null.mnt = kern_mount(&sel_fs_type);
+	if (IS_ERR(selinux_null.mnt)) {
 		pr_err("selinuxfs:  could not mount!\n");
-		err = PTR_ERR(selinuxfs_mount);
-		selinuxfs_mount = NULL;
+		err = PTR_ERR(selinux_null.mnt);
+		selinux_null.mnt = NULL;
+		return err;
 	}
+
 	selinux_null.dentry = d_hash_and_lookup(selinux_null.mnt->mnt_root,
 						&null_name);
 	if (IS_ERR(selinux_null.dentry)) {
 		pr_err("selinuxfs:  could not lookup null!\n");
 		err = PTR_ERR(selinux_null.dentry);
 		selinux_null.dentry = NULL;
+		return err;
 	}
 
 	return err;


