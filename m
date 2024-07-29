Return-Path: <stable+bounces-62403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7926093EF1E
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3632828456C
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E0A126F2A;
	Mon, 29 Jul 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u8KqUiKB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D141EB2C
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239668; cv=none; b=bV4pS6Vqhlgnmfe0RZ0RbXITEr5/wm330FCF5lKIV8V+JuG72J0BvQ5fJjwdbSZaMpEnohfGxKCLUaKgwRYyjWJe6I8s2CaocbHzpaqujMToLZbXVmOoItY04RBDRc5WPezbMaD76ZsyLPLGqOoiBMGz3SJ8l6t841EoMv8Ca/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239668; c=relaxed/simple;
	bh=Cx5SHPEUtNCDZjcbaN+M0YSwfoc15Fm+N8WrlQ0+WtI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q10dXsAOUbQXWa5bpcioCV8T+1TcKVjvdr4RWzNJO5RDff/KaTQ9bW/Bv9LZAi6wpVykkY6bMzsexqusyrkfNDQ3I0hbd7P0ciXk4255OPq/LbmSeyUl/67Ls7WK7eNymM2jioEAgUYi9wq7uGPisAplZeAqqdljRtCnmQmK+ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u8KqUiKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87486C32786;
	Mon, 29 Jul 2024 07:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239668;
	bh=Cx5SHPEUtNCDZjcbaN+M0YSwfoc15Fm+N8WrlQ0+WtI=;
	h=Subject:To:Cc:From:Date:From;
	b=u8KqUiKBqCC1W1ezHaVsVUxs+oEs3XT5Pu3IHJIKYPrdQQxy7Q+vu3lGkESe9dKIC
	 AlKy9p2kAnP/W3X8s25DR5XfB1AB9CrUrDdRBHgECuEUx1gHKJPzJTLfOVb1zy4Tia
	 Hh3WbSWcSJVbJmuT1XhNKOL57Jr1CmyR3jb37neQ=
Subject: FAILED: patch "[PATCH] sysctl: always initialize i_uid/i_gid" failed to apply to 6.1-stable tree
To: linux@weissschuh.net,j.granados@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:54:21 +0200
Message-ID: <2024072920-anytime-unfailing-5f2c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 98ca62ba9e2be5863c7d069f84f7166b45a5b2f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072920-anytime-unfailing-5f2c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

98ca62ba9e2b ("sysctl: always initialize i_uid/i_gid")
520713a93d55 ("sysctl: treewide: drop unused argument ctl_table_root::set_ownership(table)")
f9436a5d0497 ("sysctl: allow to change limits for posix messages queues")
50ec499b9a43 ("sysctl: allow change system v ipc sysctls inside ipc namespace")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 98ca62ba9e2be5863c7d069f84f7166b45a5b2f4 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 2 Apr 2024 23:10:34 +0200
Subject: [PATCH] sysctl: always initialize i_uid/i_gid
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Always initialize i_uid/i_gid inside the sysfs core so set_ownership()
can safely skip setting them.

Commit 5ec27ec735ba ("fs/proc/proc_sysctl.c: fix the default values of
i_uid/i_gid on /proc/sys inodes.") added defaults for i_uid/i_gid when
set_ownership() was not implemented. It also missed adjusting
net_ctl_set_ownership() to use the same default values in case the
computation of a better value failed.

Fixes: 5ec27ec735ba ("fs/proc/proc_sysctl.c: fix the default values of i_uid/i_gid on /proc/sys inodes.")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Joel Granados <j.granados@samsung.com>

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index b1c2c0b82116..dd7b462387a0 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -476,12 +476,10 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 			make_empty_dir_inode(inode);
 	}
 
+	inode->i_uid = GLOBAL_ROOT_UID;
+	inode->i_gid = GLOBAL_ROOT_GID;
 	if (root->set_ownership)
 		root->set_ownership(head, &inode->i_uid, &inode->i_gid);
-	else {
-		inode->i_uid = GLOBAL_ROOT_UID;
-		inode->i_gid = GLOBAL_ROOT_GID;
-	}
 
 	return inode;
 }


