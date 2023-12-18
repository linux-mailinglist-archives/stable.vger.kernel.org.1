Return-Path: <stable+bounces-6950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993E381673E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 08:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5543F281D20
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 07:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AD479D9;
	Mon, 18 Dec 2023 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VgbYqq4A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7B5D513
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2EEC433C9;
	Mon, 18 Dec 2023 07:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702883868;
	bh=5llRbrQ5Y/dlI2/rE2NY6CTZ2rRRZlGQS79FWh0sBOA=;
	h=Subject:To:Cc:From:Date:From;
	b=VgbYqq4A3q62HyVhC4EDFvUMGVvn+/XwblUD296GgbmW94BwjKOCJyeyawqQjaCSe
	 DlaviOJ/Tg37gBmjnDx8OMOGbUHoMpLvyMn5E0sXnxYWjAlMELIK9EvpuAjmMOqMah
	 HpvjJIRsgkCoUbau1eGIS7Zi7l9nt99RQErq97gU=
Subject: FAILED: patch "[PATCH] btrfs: free qgroup pertrans reserve on transaction abort" failed to apply to 6.1-stable tree
To: boris@bur.io,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Dec 2023 08:17:37 +0100
Message-ID: <2023121837-juggling-vest-964c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b321a52cce062ec7ed385333a33905d22159ce36
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121837-juggling-vest-964c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

b321a52cce06 ("btrfs: free qgroup pertrans reserve on transaction abort")
091344508249 ("btrfs: qgroup: use qgroup_iterator in qgroup_convert_meta()")
f880fe6e0b4b ("btrfs: don't hold an extra reference for redirtied buffers")
c83b56d1dd87 ("btrfs: zero the buffer before marking it dirty in btrfs_redirty_list_add")
921603c76246 ("btrfs: pass a btrfs_bio to btrfs_use_append")
d5e4377d5051 ("btrfs: split zone append bios in btrfs_submit_bio")
285599b6fe15 ("btrfs: remove the fs_info argument to btrfs_submit_bio")
48253076c3a9 ("btrfs: open code submit_encoded_read_bio")
30493ff49f81 ("btrfs: remove stripe boundary calculation for compressed I/O")
2380220e1e13 ("btrfs: remove stripe boundary calculation for buffered I/O")
67d669825090 ("btrfs: pass the iomap bio to btrfs_submit_bio")
852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
69ccf3f4244a ("btrfs: handle recording of zoned writes in the storage layer")
f8a53bb58ec7 ("btrfs: handle checksum generation in the storage layer")
f8c44673e5a5 ("btrfs: simplify the btrfs_csum_one_bio calling convention")
deb6216fa0b6 ("btrfs: open code the submit_bio_start helpers")
295fe46ff19b ("btrfs: remove struct btrfs_bio::is_metadata flag")
0d3acb25e70d ("btrfs: rename btrfs_bio::iter field")
0571b6357c5e ("btrfs: remove the io_failure_record infrastructure")
860c8c451661 ("btrfs: remove struct btrfs_bio::device field")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b321a52cce062ec7ed385333a33905d22159ce36 Mon Sep 17 00:00:00 2001
From: Boris Burkov <boris@bur.io>
Date: Fri, 1 Dec 2023 13:00:11 -0800
Subject: [PATCH] btrfs: free qgroup pertrans reserve on transaction abort

If we abort a transaction, we never run the code that frees the pertrans
qgroup reservation. This results in warnings on unmount as that
reservation has been leaked. The leak isn't a huge issue since the fs is
read-only, but it's better to clean it up when we know we can/should. Do
it during the cleanup_transaction step of aborting.

CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bbcc3df77646..62cb97f7c94f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4799,6 +4799,32 @@ void btrfs_cleanup_dirty_bgs(struct btrfs_transaction *cur_trans,
 	}
 }
 
+static void btrfs_free_all_qgroup_pertrans(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *gang[8];
+	int i;
+	int ret;
+
+	spin_lock(&fs_info->fs_roots_radix_lock);
+	while (1) {
+		ret = radix_tree_gang_lookup_tag(&fs_info->fs_roots_radix,
+						 (void **)gang, 0,
+						 ARRAY_SIZE(gang),
+						 BTRFS_ROOT_TRANS_TAG);
+		if (ret == 0)
+			break;
+		for (i = 0; i < ret; i++) {
+			struct btrfs_root *root = gang[i];
+
+			btrfs_qgroup_free_meta_all_pertrans(root);
+			radix_tree_tag_clear(&fs_info->fs_roots_radix,
+					(unsigned long)root->root_key.objectid,
+					BTRFS_ROOT_TRANS_TAG);
+		}
+	}
+	spin_unlock(&fs_info->fs_roots_radix_lock);
+}
+
 void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 				   struct btrfs_fs_info *fs_info)
 {
@@ -4827,6 +4853,8 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 				     EXTENT_DIRTY);
 	btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);
 
+	btrfs_free_all_qgroup_pertrans(fs_info);
+
 	cur_trans->state =TRANS_STATE_COMPLETED;
 	wake_up(&cur_trans->commit_wait);
 }
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a953c16c7eb8..daec90342dad 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4337,8 +4337,9 @@ static void qgroup_convert_meta(struct btrfs_fs_info *fs_info, u64 ref_root,
 
 		qgroup_rsv_release(fs_info, qgroup, num_bytes,
 				BTRFS_QGROUP_RSV_META_PREALLOC);
-		qgroup_rsv_add(fs_info, qgroup, num_bytes,
-				BTRFS_QGROUP_RSV_META_PERTRANS);
+		if (!sb_rdonly(fs_info->sb))
+			qgroup_rsv_add(fs_info, qgroup, num_bytes,
+				       BTRFS_QGROUP_RSV_META_PERTRANS);
 
 		list_for_each_entry(glist, &qgroup->groups, next_group)
 			qgroup_iterator_add(&qgroup_list, glist->group);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 7af9665bebae..b5aa83b7345a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -37,8 +37,6 @@
 
 static struct kmem_cache *btrfs_trans_handle_cachep;
 
-#define BTRFS_ROOT_TRANS_TAG 0
-
 /*
  * Transaction states and transitions
  *
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 18c4f6e83b78..2bf8bbdfd0b3 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -12,6 +12,9 @@
 #include "ctree.h"
 #include "misc.h"
 
+/* Radix-tree tag for roots that are part of the trasaction. */
+#define BTRFS_ROOT_TRANS_TAG			0
+
 enum btrfs_trans_state {
 	TRANS_STATE_RUNNING,
 	TRANS_STATE_COMMIT_PREP,


