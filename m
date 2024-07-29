Return-Path: <stable+bounces-62406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C5A93EF21
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9361C21BAC
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F9112C54D;
	Mon, 29 Jul 2024 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CCM3oFN7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E791EB2C
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239679; cv=none; b=r80mVYNc4r4pZ1UiulxODEF3VWXl4tRiFaxrSbvOURkYzezyff0uEzgCPLMA9azdTJ/W1WZQhV/A7zCMblTpGcvR8SQWnH3r7PzsfQg5Z7ZoRhh/MhRJGqgsFJZIa5FU0mWtds4IOQTjUb8pT1Xcqm2eJXTYWSrNmDU1LdZoimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239679; c=relaxed/simple;
	bh=NxIbxKp6vBdfba4v/X26gdt94slYLPPb8t73H34glkI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OE5fHPLAJQN6K8fQZmDGeihaujA1ty07rY50HimDfhRJA1zINDcAJgodt4OBXAML9raiZbUEP3NFFXv08zxZYBu6Nq4x64sHPo/pmb8dsDlD5OdkcP3NHcg6BOypljCW3f4DDEAYUQ02TrbCOUYxIdexOuBs/zsHlpUpPHLzmAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CCM3oFN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62571C32786;
	Mon, 29 Jul 2024 07:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239678;
	bh=NxIbxKp6vBdfba4v/X26gdt94slYLPPb8t73H34glkI=;
	h=Subject:To:Cc:From:Date:From;
	b=CCM3oFN7JIo5KmxIKav4SITHHBsaNx1i19zXT3auHaid7m5kGDTNh+iems+knE0lS
	 OehMgHCKwIkxdwit0CPzbSXWKS7NCt4DrRGS7EtlVgZjM5Ov5uDK6u+D2+RdVJ89fI
	 w9uowLbjkd2lwUVgkWx93uCYNfet3ZW+lzLTk7m4=
Subject: FAILED: patch "[PATCH] sysctl: always initialize i_uid/i_gid" failed to apply to 5.4-stable tree
To: linux@weissschuh.net,j.granados@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:54:28 +0200
Message-ID: <2024072928-bunny-banana-9335@gregkh>
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
git cherry-pick -x 98ca62ba9e2be5863c7d069f84f7166b45a5b2f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072928-bunny-banana-9335@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

98ca62ba9e2b ("sysctl: always initialize i_uid/i_gid")
520713a93d55 ("sysctl: treewide: drop unused argument ctl_table_root::set_ownership(table)")
f9436a5d0497 ("sysctl: allow to change limits for posix messages queues")
50ec499b9a43 ("sysctl: allow change system v ipc sysctls inside ipc namespace")
0889f44e2810 ("ipc: Check permissions for checkpoint_restart sysctls at open time")
1f5c135ee509 ("ipc: Store ipc sysctls in the ipc namespace")
dc55e35f9e81 ("ipc: Store mqueue sysctls in the ipc namespace")
0e9beb8a96f2 ("ipc/ipc_sysctl.c: remove fallback for !CONFIG_PROC_SYSCTL")
5563cabdde7e ("ipc: check checkpoint_restore_ns_capable() to modify C/R proc files")
32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
2374c09b1c8a ("sysctl: remove all extern declaration from sysctl.c")
26363af56434 ("mm: remove watermark_boost_factor_sysctl_handler")
6923aa0d8c62 ("mm/compaction: Disable compact_unevictable_allowed on RT")
964b692daf30 ("mm/compaction: really limit compact_unevictable_allowed to 0 and 1")
eaee41727e6d ("sysctl/sysrq: Remove __sysrq_enabled copy")
0a6cad5df541 ("Merge branch 'vmwgfx-coherent' of git://people.freedesktop.org/~thomash/linux into drm-next")

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


