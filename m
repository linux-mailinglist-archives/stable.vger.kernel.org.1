Return-Path: <stable+bounces-172053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51E5B2FA18
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4273BBE9B
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EC23277B9;
	Thu, 21 Aug 2025 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0we5tnMM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354593277BD
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782182; cv=none; b=ADidO1qwfwMb/a8OSxHUlx/hyEodCGsQA6MFVT2Lm2GJhAGQffXdAg5n45BANpwD/Sj2+OzVY0bbnaz8fbYL62ME4+lfxlrbIu8JaPs7xbOoyM3DXOu+aqDPXzGnxbH/1U2AHCQJT6bT+0U/a8+sUFseUjW1S+Fn9/qPFDBBHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782182; c=relaxed/simple;
	bh=O+nDeVi+AXc5mFA/5Iwe32h6jZHHomGXnvJDF7U0ydA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lr4JxYX6w8oFHM7ZBek5mJxysh4+CPGnj4mxgVzQAxqZBVlgXwKCY3/3q47UBGEsbB0PRdVE7ihVZexTZRr8EXNPfKVqyg2C1KyhJC6TDSrms9jTYJB99rqFrkh5PN3pqeEfAabSiCtKMHidBno35bvAEVvecAOJhnWKf7mDXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0we5tnMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5014C4CEEB;
	Thu, 21 Aug 2025 13:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755782182;
	bh=O+nDeVi+AXc5mFA/5Iwe32h6jZHHomGXnvJDF7U0ydA=;
	h=Subject:To:Cc:From:Date:From;
	b=0we5tnMMCoX2+kjPB09V1XvdWaIBBU+hLeH6GJrtOJW2H4CFinp6iyfoYMpuXZLC9
	 5gFWiBi9kSZHTsJKit5ddAW52cWiwlFRLExPi2hjSmaxiEqqI5i2ciMS/GiDm5LU78
	 gShNcYGGYHY+w9JnR4cP/lHI09GqXwcm9FfgwJLA=
Subject: FAILED: patch "[PATCH] ovl: use I_MUTEX_PARENT when locking parent in" failed to apply to 6.12-stable tree
To: neil@brown.name,amir73il@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:13:14 +0200
Message-ID: <2025082114-ocelot-graceless-5693@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5f1c8965e748c150d580a2ea8fbee1bd80d07a24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082114-ocelot-graceless-5693@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f1c8965e748c150d580a2ea8fbee1bd80d07a24 Mon Sep 17 00:00:00 2001
From: NeilBrown <neil@brown.name>
Date: Mon, 4 Aug 2025 22:11:28 +1000
Subject: [PATCH] ovl: use I_MUTEX_PARENT when locking parent in
 ovl_create_temp()

ovl_create_temp() treats "workdir" as a parent in which it creates an
object so it should use I_MUTEX_PARENT.

Prior to the commit identified below the lock was taken by the caller
which sometimes used I_MUTEX_PARENT and sometimes used I_MUTEX_NORMAL.
The use of I_MUTEX_NORMAL was incorrect but unfortunately copied into
ovl_create_temp().

Note to backporters: This patch only applies after the last Fixes given
below (post v6.16).  To fix the bug in v6.7 and later the
inode_lock() call in ovl_copy_up_workdir() needs to nest using
I_MUTEX_PARENT.

Link: https://lore.kernel.org/all/67a72070.050a0220.3d72c.0022.GAE@google.com/
Cc: stable@vger.kernel.org
Reported-by: syzbot+7836a68852a10ec3d790@syzkaller.appspotmail.com
Tested-by: syzbot+7836a68852a10ec3d790@syzkaller.appspotmail.com
Fixes: c63e56a4a652 ("ovl: do not open/llseek lower file with upper sb_writers held")
Fixes: d2c995581c7c ("ovl: Call ovl_create_temp() without lock held.")
Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 70b8687dc45e..dbd63a74df4b 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -225,7 +225,7 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 			       struct ovl_cattr *attr)
 {
 	struct dentry *ret;
-	inode_lock(workdir->d_inode);
+	inode_lock_nested(workdir->d_inode, I_MUTEX_PARENT);
 	ret = ovl_create_real(ofs, workdir,
 			      ovl_lookup_temp(ofs, workdir), attr);
 	inode_unlock(workdir->d_inode);


