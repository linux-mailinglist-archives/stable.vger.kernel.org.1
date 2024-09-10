Return-Path: <stable+bounces-74482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D99D5972F80
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D56286D6D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3355317BB01;
	Tue, 10 Sep 2024 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DyGTweBE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A19224F6;
	Tue, 10 Sep 2024 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961935; cv=none; b=aa9VEkIu1NAOMGwCf1PdQvJq/qUGTaNjzJTVwu2hKIw93Q7nPzu6oX+MLaYWrXOw/jCnDHyPc5PGQPsjz6N3/73fGMS8GN2Xd6N4cO3VB8ibMxjKknfCRWUQgaHRs+JpRCszdm26N62gjP15RjYDI++kznrK7QC3Mj8m8q9yw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961935; c=relaxed/simple;
	bh=EUdq22H8tQy28DJQYUUaNNPszb9mrcVNYRnyZGJSF7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFcPEo1tIcxjpA7vo6kw5LwL2XkYequsXHG9HAkWOb+GxyRSiXk6fG5aPXs8m+WEj+HiMh0WQqtDN9hBy9SnrRtT2n1XnPk6P7shhrdJTxqPa03uL7TAfaQqX1jReTkHzzjIjia9/TlIOoQcgPm7RNF2Uvsfx2fca4hQhDV82uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DyGTweBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FB5C4CEC3;
	Tue, 10 Sep 2024 09:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961934;
	bh=EUdq22H8tQy28DJQYUUaNNPszb9mrcVNYRnyZGJSF7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DyGTweBEko5aAJoFyrVpzy6V0zZvLdLBdpYyMG9i3n93Jsu4Uu0FR+SP+eR1JCWLW
	 58yX/19s3CHgy0PCQYQ1b8IehCIFGu95yOs68Vm76rrMNtYxEsMXWOSU9aIDftjSmI
	 6PD3XqBBvTwD7QVKR7WTLDVJyjHDAItR8hvM+Pos=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 239/375] btrfs: slightly loosen the requirement for qgroup removal
Date: Tue, 10 Sep 2024 11:30:36 +0200
Message-ID: <20240910092630.583856828@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit a776bf5f3c2300cfdf8a195663460b1793ac9847 ]

[BUG]
Currently if one is utilizing "qgroups/drop_subtree_threshold" sysfs,
and a snapshot with level higher than that value is dropped, we will
not be able to delete the qgroup until next qgroup rescan:

  uuid=ffffffff-eeee-dddd-cccc-000000000000

  wipefs -fa $dev
  mkfs.btrfs -f $dev -O quota -s 4k -n 4k -U $uuid
  mount $dev $mnt

  btrfs subvolume create $mnt/subv1/
  for (( i = 0; i < 1024; i++ )); do
  	xfs_io -f -c "pwrite 0 2k" $mnt/subv1/file_$i > /dev/null
  done
  sync
  btrfs subvolume snapshot $mnt/subv1 $mnt/snapshot
  btrfs quota enable $mnt
  btrfs quota rescan -w $mnt
  sync
  echo 1 > /sys/fs/btrfs/$uuid/qgroups/drop_subtree_threshold
  btrfs subvolume delete $mnt/snapshot
  btrfs subvolume sync $mnt
  btrfs qgroup show -prce --sync $mnt
  btrfs qgroup destroy 0/257 $mnt
  umount $mnt

The final qgroup removal would fail with the following error:

  ERROR: unable to destroy quota group: Device or resource busy

[CAUSE]
The above script would generate a subvolume of level 2, then snapshot
it, enable qgroup, set the drop_subtree_threshold, then drop the
snapshot.

Since the subvolume drop would meet the threshold, qgroup would be
marked inconsistent and skip accounting to avoid hanging the system at
transaction commit.

But currently we do not allow a qgroup with any rfer/excl numbers to be
dropped, and this is not really compatible with the new
drop_subtree_threshold behavior.

[FIX]
Only require the strict zero rfer/excl/rfer_cmpr/excl_cmpr for squota
mode.  This is due to the fact that squota can never go inconsistent,
and it can have dropped subvolume but with non-zero qgroup numbers for
future accounting.

For full qgroup mode, we only check if there is a subvolume for it.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 87 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d4486518414d..24df83177007 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1750,13 +1750,55 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	return ret;
 }
 
-static bool qgroup_has_usage(struct btrfs_qgroup *qgroup)
+/*
+ * Return 0 if we can not delete the qgroup (not empty or has children etc).
+ * Return >0 if we can delete the qgroup.
+ * Return <0 for other errors during tree search.
+ */
+static int can_delete_qgroup(struct btrfs_fs_info *fs_info, struct btrfs_qgroup *qgroup)
 {
-	return (qgroup->rfer > 0 || qgroup->rfer_cmpr > 0 ||
-		qgroup->excl > 0 || qgroup->excl_cmpr > 0 ||
-		qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] > 0 ||
-		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] > 0 ||
-		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS] > 0);
+	struct btrfs_key key;
+	struct btrfs_path *path;
+	int ret;
+
+	/*
+	 * Squota would never be inconsistent, but there can still be case
+	 * where a dropped subvolume still has qgroup numbers, and squota
+	 * relies on such qgroup for future accounting.
+	 *
+	 * So for squota, do not allow dropping any non-zero qgroup.
+	 */
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE &&
+	    (qgroup->rfer || qgroup->excl || qgroup->excl_cmpr || qgroup->rfer_cmpr))
+		return 0;
+
+	/* For higher level qgroup, we can only delete it if it has no child. */
+	if (btrfs_qgroup_level(qgroup->qgroupid)) {
+		if (!list_empty(&qgroup->members))
+			return 0;
+		return 1;
+	}
+
+	/*
+	 * For level-0 qgroups, we can only delete it if it has no subvolume
+	 * for it.
+	 * This means even a subvolume is unlinked but not yet fully dropped,
+	 * we can not delete the qgroup.
+	 */
+	key.objectid = qgroup->qgroupid;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = -1ULL;
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_find_root(fs_info->tree_root, &key, path, NULL, NULL);
+	btrfs_free_path(path);
+	/*
+	 * The @ret from btrfs_find_root() exactly matches our definition for
+	 * the return value, thus can be returned directly.
+	 */
+	return ret;
 }
 
 int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
@@ -1778,7 +1820,10 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 		goto out;
 	}
 
-	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
+	ret = can_delete_qgroup(fs_info, qgroup);
+	if (ret < 0)
+		goto out;
+	if (ret == 0) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -1803,6 +1848,34 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	}
 
 	spin_lock(&fs_info->qgroup_lock);
+	/*
+	 * Warn on reserved space. The subvolume should has no child nor
+	 * corresponding subvolume.
+	 * Thus its reserved space should all be zero, no matter if qgroup
+	 * is consistent or the mode.
+	 */
+	WARN_ON(qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS]);
+	/*
+	 * The same for rfer/excl numbers, but that's only if our qgroup is
+	 * consistent and if it's in regular qgroup mode.
+	 * For simple mode it's not as accurate thus we can hit non-zero values
+	 * very frequently.
+	 */
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL &&
+	    !(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)) {
+		if (WARN_ON(qgroup->rfer || qgroup->excl ||
+			    qgroup->rfer_cmpr || qgroup->excl_cmpr)) {
+			btrfs_warn_rl(fs_info,
+"to be deleted qgroup %u/%llu has non-zero numbers, rfer %llu rfer_cmpr %llu excl %llu excl_cmpr %llu",
+				      btrfs_qgroup_level(qgroup->qgroupid),
+				      btrfs_qgroup_subvolid(qgroup->qgroupid),
+				      qgroup->rfer, qgroup->rfer_cmpr,
+				      qgroup->excl, qgroup->excl_cmpr);
+			qgroup_mark_inconsistent(fs_info);
+		}
+	}
 	del_qgroup_rb(fs_info, qgroupid);
 	spin_unlock(&fs_info->qgroup_lock);
 
-- 
2.43.0




