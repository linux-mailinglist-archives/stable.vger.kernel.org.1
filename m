Return-Path: <stable+bounces-35998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B35899530
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E981F24ED8
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F53D224DC;
	Fri,  5 Apr 2024 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vBb4mxUP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2C82232B
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297985; cv=none; b=c+x5d0A1zsGoykv3Wm2LMVBQAxaeLqMK6DCUwM01UzjW/ik3ofZvfxE5GPMcMj42aaxZQYf/m53pdAeb4eHSoXppu4OzwrhBLpg6LIse7//AEuD1p6/BqUAURtTN6ypng4KsgoC8aj8OQV1ACHeOia2Rk4Qvy2aFSY1Rr9mpJow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297985; c=relaxed/simple;
	bh=/geXSPsNWCkqNn1OSWMI0CDL14MO8Bzz7plTHaGoaWE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rrFdrrQ21XBe6TAvyGIu5fwhFYuVZafwBBYdoPhWf6Y910zfsDFK5RyHyOZt0I/eIg/eRj3fgACSZQP1YZ4Pj+g0YboPnlQ8wttQohrm2tnB8uc6x2C4JUugd7JTWcPKL0ogYOSD/tQWsRz/+RIhn8KKtegYM65S7CAdiUKLUEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vBb4mxUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B655BC433F1;
	Fri,  5 Apr 2024 06:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712297985;
	bh=/geXSPsNWCkqNn1OSWMI0CDL14MO8Bzz7plTHaGoaWE=;
	h=Subject:To:Cc:From:Date:From;
	b=vBb4mxUPLpZlBIL+qaKzICwpRggb7lx9e2aOJhW66ME7WP116qkIo16xpBP8f+H7n
	 UlQD/AysrL/DuvfRDvrN7NjkK8xCRRYi0a0MfCFcwD+aYHOvzZRAjRRqwxm4yynVfW
	 kl294pTy4HQmM0R9z9z6fOfVpQ2DrjbJgqFU5hm8=
Subject: FAILED: patch "[PATCH] selinux: avoid dereference of garbage after mount failure" failed to apply to 5.10-stable tree
To: cgzones@googlemail.com,paul@paul-moore.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 08:19:38 +0200
Message-ID: <2024040537-reexamine-stunner-cd63@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 37801a36b4d68892ce807264f784d818f8d0d39b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040537-reexamine-stunner-cd63@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


