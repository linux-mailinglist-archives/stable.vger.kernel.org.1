Return-Path: <stable+bounces-171681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD07AB2B534
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80131963343
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6CDEAD7;
	Tue, 19 Aug 2025 00:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6z5/lG0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58730DDC5
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 00:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755562044; cv=none; b=tdq5SYNt58Y88rT8ZLuPizesdgeNAbNosvBpU9+Ox1X4pvaz5aL07J73r6llEzxfgWsGcVprI2FVxi53KTGXu5RubZ4Y6pLH/tnmW9LMBdiSsC9ki6EUifSampTFCSk/s6re0D+ZQLB0m6mcZ7GgCjxDhtg3233N7+ZTY0hN7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755562044; c=relaxed/simple;
	bh=ksU4oTPU1th8Kz8coBOz1Ve346HdiMRBvrn4ehQDvFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNgYp51OjiyptN+dxGDHY4Znv5x/owdU6OCATPK0hfpubv+sk90u8f+V49o3sNItP6UF1+bnKkOWH4OGU/0Lzjr+ajRjrH5Uqh/ju10NpQWA5ZLVfu4Woe9wICIQ+UvZPUD2JEvv0uH9IEpfh3ucfb2Y28bXLRolX2wHqpZr27I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6z5/lG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187D3C4CEF1;
	Tue, 19 Aug 2025 00:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755562043;
	bh=ksU4oTPU1th8Kz8coBOz1Ve346HdiMRBvrn4ehQDvFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q6z5/lG0LHP40IBExNPR2mhn816vveWtq5rVoMb6GUtCNdTZb7JxTR5wR9M0dhaWI
	 T6WvRACLet52V1b3lG5pFr0aY/C6sDlmT0Hcm7c46SW+weXmFG8SBNPB4paJcxtXa0
	 XSXC2eBjZnxK6XXmZoTjdfBO/t9qnl1yDUBtzS4lQQ7KoIzEDFvKxW2dgMtq5mU+qG
	 WbK3r11RPbZyKoLI4wkDc4N+z29258VlAx5DY3DxwHPct8HQwkTTARiHFU93mYyKp5
	 rAqkv+EkijkS/wUEJRd/MMOOfpEn46VhxjuHPCjMQDKXRXBsrQ6CTqP2Wcyw7/vOB0
	 J8zM+xXTcngaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	cen zhang <zzzccc427@gmail.com>,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] btrfs: qgroup: fix race between quota disable and quota rescan ioctl
Date: Mon, 18 Aug 2025 20:07:19 -0400
Message-ID: <20250819000719.186990-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081831-cancel-lunchtime-0e51@gregkh>
References: <2025081831-cancel-lunchtime-0e51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit e1249667750399a48cafcf5945761d39fa584edf ]

There's a race between a task disabling quotas and another running the
rescan ioctl that can result in a use-after-free of qgroup records from
the fs_info->qgroup_tree rbtree.

This happens as follows:

1) Task A enters btrfs_ioctl_quota_rescan() -> btrfs_qgroup_rescan();

2) Task B enters btrfs_quota_disable() and calls
   btrfs_qgroup_wait_for_completion(), which does nothing because at that
   point fs_info->qgroup_rescan_running is false (it wasn't set yet by
   task A);

3) Task B calls btrfs_free_qgroup_config() which starts freeing qgroups
   from fs_info->qgroup_tree without taking the lock fs_info->qgroup_lock;

4) Task A enters qgroup_rescan_zero_tracking() which starts iterating
   the fs_info->qgroup_tree tree while holding fs_info->qgroup_lock,
   but task B is freeing qgroup records from that tree without holding
   the lock, resulting in a use-after-free.

Fix this by taking fs_info->qgroup_lock at btrfs_free_qgroup_config().
Also at btrfs_qgroup_rescan() don't start the rescan worker if quotas
were already disabled.

Reported-by: cen zhang <zzzccc427@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAFRLqsV+cMDETFuzqdKSHk_FDm6tneea45krsHqPD6B3FetLpQ@mail.gmail.com/
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ Check for BTRFS_FS_QUOTA_ENABLED, instead of btrfs_qgroup_full_accounting() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1b9f4f16d124..c46ea2ecf188 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -579,22 +579,30 @@ bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info)
 
 /*
  * This is called from close_ctree() or open_ctree() or btrfs_quota_disable(),
- * first two are in single-threaded paths.And for the third one, we have set
- * quota_root to be null with qgroup_lock held before, so it is safe to clean
- * up the in-memory structures without qgroup_lock held.
+ * first two are in single-threaded paths.
  */
 void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
 {
 	struct rb_node *n;
 	struct btrfs_qgroup *qgroup;
 
+	/*
+	 * btrfs_quota_disable() can be called concurrently with
+	 * btrfs_qgroup_rescan() -> qgroup_rescan_zero_tracking(), so take the
+	 * lock.
+	 */
+	spin_lock(&fs_info->qgroup_lock);
 	while ((n = rb_first(&fs_info->qgroup_tree))) {
 		qgroup = rb_entry(n, struct btrfs_qgroup, node);
 		rb_erase(n, &fs_info->qgroup_tree);
 		__del_qgroup_rb(fs_info, qgroup);
+		spin_unlock(&fs_info->qgroup_lock);
 		btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
 		kfree(qgroup);
+		spin_lock(&fs_info->qgroup_lock);
 	}
+	spin_unlock(&fs_info->qgroup_lock);
+
 	/*
 	 * We call btrfs_free_qgroup_config() when unmounting
 	 * filesystem and disabling quota, so we set qgroup_ulist
@@ -3616,12 +3624,21 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
 	qgroup_rescan_zero_tracking(fs_info);
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	fs_info->qgroup_rescan_running = true;
-	btrfs_queue_work(fs_info->qgroup_rescan_workers,
-			 &fs_info->qgroup_rescan_work);
+	/*
+	 * The rescan worker is only for full accounting qgroups, check if it's
+	 * enabled as it is pointless to queue it otherwise. A concurrent quota
+	 * disable may also have just cleared BTRFS_FS_QUOTA_ENABLED.
+	 */
+	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
+		fs_info->qgroup_rescan_running = true;
+		btrfs_queue_work(fs_info->qgroup_rescan_workers,
+				 &fs_info->qgroup_rescan_work);
+	} else {
+		ret = -ENOTCONN;
+	}
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
-	return 0;
+	return ret;
 }
 
 int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
-- 
2.50.1


