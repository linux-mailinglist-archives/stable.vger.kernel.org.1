Return-Path: <stable+bounces-136939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3321CA9F8B9
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E3D3BED9E
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1892957D0;
	Mon, 28 Apr 2025 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1IlWvuo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342FC2957A8;
	Mon, 28 Apr 2025 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745865576; cv=none; b=u4kfoqDtG2alwfKo92ZVXvbo/TadQINy1yYirzKtob/6EWIkyEptgj63vyWBKWhBZ4fsCe/nCy8QtNHhq/JBKMWYVF1A2CLyz/RJWGxTjacmzgxvmGJxWcDPsqAvUftNu3aiIwMn3cBdkz/U6B8z+oFTSmXvK1bOWwVFRi+MAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745865576; c=relaxed/simple;
	bh=msHTTHw8Te8ztF2PXa36D8eyF0IqDvf/uSXKHMo9XvM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qj/5dfYbJncr1+JB851nTuKhK09CAAa6s6O5tJM0Fbc0LEWQAEw38BmJ8XlCBdFs54bNMudLOm5jrgSXWWQ9Psk0QjeoQ6J2vbGcYKQSA1kuNspCwdwvn2mHaLJHs41KK0IyumOQ4w63EnndYkNkDNfO0co4hEGD8PoMt5VAkYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1IlWvuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED222C4CEE4;
	Mon, 28 Apr 2025 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745865576;
	bh=msHTTHw8Te8ztF2PXa36D8eyF0IqDvf/uSXKHMo9XvM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=a1IlWvuoGee2eEMiSLAdYFSOqthWK5wAvTuk7LuDJ8vKeNV074x6q0pTEe7Oj9tMI
	 ojoTgRqlfZ9qTjp06FBA9YMJCZ/zAf9rAFGFKYnHk6pVQis86YoRscrd+auTA3FMAg
	 Ms6RxJYjcSBn0NIMOObNOMOo82A4f1yyINawPPA7Y1kB9NOTLYBCHNdKMZkogWMShB
	 me8gm3TEWAqAZO3GAMkBcI7dtp46LM0bPTToXf8ekk391FdhKZP/mXQi+DYoS1OXda
	 90XPwwkmOQhwlqPhD41sorYJzyil2rd+DzO2Iv00j9LkQer3dqkpI24VOUbCQGx1/d
	 aX2+GAlpAVbHA==
Date: Mon, 28 Apr 2025 11:39:35 -0700
Subject: [PATCH 2/4] xfs: Do not allow norecovery mount with quotacheck
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, xfs-stable@lists.linux.dev
Cc: cem@kernel.org, cmaiolino@redhat.com, stable@vger.kernel.org
Message-ID: <174586545419.480536.17699094964584987030.stgit@frogsfrogsfrogs>
In-Reply-To: <174586545357.480536.7498456094082551730.stgit@frogsfrogsfrogs>
References: <174586545357.480536.7498456094082551730.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Carlos Maiolino <cem@kernel.org>

Commit 9f0902091c332b2665951cfb970f60ae7cbdc0f3 upstream

Mounting a filesystem that requires quota state changing will generate a
transaction.

We already check for a read-only device; we should do that for
norecovery too.

A quotacheck on a norecovery mount, and with the right log size, will cause
the mount process to hang on:

[<0>] xlog_grant_head_wait+0x5d/0x2a0 [xfs]
[<0>] xlog_grant_head_check+0x112/0x180 [xfs]
[<0>] xfs_log_reserve+0xe3/0x260 [xfs]
[<0>] xfs_trans_reserve+0x179/0x250 [xfs]
[<0>] xfs_trans_alloc+0x101/0x260 [xfs]
[<0>] xfs_sync_sb+0x3f/0x80 [xfs]
[<0>] xfs_qm_mount_quotas+0xe3/0x2f0 [xfs]
[<0>] xfs_mountfs+0x7ad/0xc20 [xfs]
[<0>] xfs_fs_fill_super+0x762/0xa50 [xfs]
[<0>] get_tree_bdev_flags+0x131/0x1d0
[<0>] vfs_get_tree+0x26/0xd0
[<0>] vfs_cmd_create+0x59/0xe0
[<0>] __do_sys_fsconfig+0x4e3/0x6b0
[<0>] do_syscall_64+0x82/0x160
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

This is caused by a transaction running with bogus initialized head/tail

I initially hit this while running generic/050, with random log
sizes, but I managed to reproduce it reliably here with the steps
below:

mkfs.xfs -f -lsize=1025M -f -b size=4096 -m crc=1,reflink=1,rmapbt=1, -i
sparse=1 /dev/vdb2 > /dev/null
mount -o usrquota,grpquota,prjquota /dev/vdb2 /mnt
xfs_io -x -c 'shutdown -f' /mnt
umount /mnt
mount -o ro,norecovery,usrquota,grpquota,prjquota  /dev/vdb2 /mnt

Last mount hangs up

As we add yet another validation if quota state is changing, this also
add a new helper named xfs_qm_validate_state_change(), factoring the
quota state changes out of xfs_qm_newmount() to reduce cluttering
within it.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_qm_bhv.c |   49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)


diff --git a/fs/xfs/xfs_qm_bhv.c b/fs/xfs/xfs_qm_bhv.c
index ed1d597c30ca25..dabb1d6d7e463e 100644
--- a/fs/xfs/xfs_qm_bhv.c
+++ b/fs/xfs/xfs_qm_bhv.c
@@ -79,6 +79,28 @@ xfs_qm_statvfs(
 	}
 }
 
+STATIC int
+xfs_qm_validate_state_change(
+	struct xfs_mount	*mp,
+	uint			uqd,
+	uint			gqd,
+	uint			pqd)
+{
+	int state;
+
+	/* Is quota state changing? */
+	state = ((uqd && !XFS_IS_UQUOTA_ON(mp)) ||
+		(!uqd &&  XFS_IS_UQUOTA_ON(mp)) ||
+		 (gqd && !XFS_IS_GQUOTA_ON(mp)) ||
+		(!gqd &&  XFS_IS_GQUOTA_ON(mp)) ||
+		 (pqd && !XFS_IS_PQUOTA_ON(mp)) ||
+		(!pqd &&  XFS_IS_PQUOTA_ON(mp)));
+
+	return  state &&
+		(xfs_dev_is_read_only(mp, "changing quota state") ||
+		xfs_has_norecovery(mp));
+}
+
 int
 xfs_qm_newmount(
 	xfs_mount_t	*mp,
@@ -98,24 +120,21 @@ xfs_qm_newmount(
 	}
 
 	/*
-	 * If the device itself is read-only, we can't allow
-	 * the user to change the state of quota on the mount -
-	 * this would generate a transaction on the ro device,
-	 * which would lead to an I/O error and shutdown
+	 * If the device itself is read-only and/or in norecovery
+	 * mode, we can't allow the user to change the state of
+	 * quota on the mount - this would generate a transaction
+	 * on the ro device, which would lead to an I/O error and
+	 * shutdown.
 	 */
 
-	if (((uquotaondisk && !XFS_IS_UQUOTA_ON(mp)) ||
-	    (!uquotaondisk &&  XFS_IS_UQUOTA_ON(mp)) ||
-	     (gquotaondisk && !XFS_IS_GQUOTA_ON(mp)) ||
-	    (!gquotaondisk &&  XFS_IS_GQUOTA_ON(mp)) ||
-	     (pquotaondisk && !XFS_IS_PQUOTA_ON(mp)) ||
-	    (!pquotaondisk &&  XFS_IS_PQUOTA_ON(mp)))  &&
-	    xfs_dev_is_read_only(mp, "changing quota state")) {
+	if (xfs_qm_validate_state_change(mp, uquotaondisk,
+			    gquotaondisk, pquotaondisk)) {
+
 		xfs_warn(mp, "please mount with%s%s%s%s.",
-			(!quotaondisk ? "out quota" : ""),
-			(uquotaondisk ? " usrquota" : ""),
-			(gquotaondisk ? " grpquota" : ""),
-			(pquotaondisk ? " prjquota" : ""));
+				(!quotaondisk ? "out quota" : ""),
+				(uquotaondisk ? " usrquota" : ""),
+				(gquotaondisk ? " grpquota" : ""),
+				(pquotaondisk ? " prjquota" : ""));
 		return -EPERM;
 	}
 


