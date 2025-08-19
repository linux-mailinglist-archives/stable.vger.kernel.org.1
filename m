Return-Path: <stable+bounces-171713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0389B2B686
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9556C6250E2
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1A5287244;
	Tue, 19 Aug 2025 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sderKxGr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4AF286426
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568733; cv=none; b=ohtzYtPGoFizqAoB8xBt8K0lYOG+VbNkyQOhq34twP1dzBjjFx5qMLJScZKVy+YGp61L2ry51LV2frS06ZoZ7fr14g0UxE638v9CzPR8Jt5H81kCUbKfs3Fa++Und9T2ORiFwRlMrTaXG1MKEB/PSREmOo97RpcC3slK5StnsJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568733; c=relaxed/simple;
	bh=I3MME4JfRhVyKdDUXRm+DivMRBte5H9gQI0phiIoLQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQIN94HBz7blnzlRS9Jwe+acYX4qb2e+qza4vmxdUvFCMkm0XenH1rFbB+haGch+GgvhcvIiGjaXKKZlY7etO7cr/5EzxsjAnWf5lpTixUCwPpfutUW53QM+3IOJoaLA5jN15ddheguNR5+PZigerTiP+Ma++u4zrEIQLMlJLfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sderKxGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3119BC116B1;
	Tue, 19 Aug 2025 01:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755568732;
	bh=I3MME4JfRhVyKdDUXRm+DivMRBte5H9gQI0phiIoLQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sderKxGrzln+Hj/5vHe/l2Y4/O5C0zuKOKLUuWp1Yb8iTH7avk45yNoPdfr/f5nsD
	 kVVUy2OroRIrDPkwEBAHEW+oRUDxqyURVSP1+oqOLzLr4cTk12TH91bej7Pb5AY5Jt
	 cbQebPUpqx9sKQB8MS331ymi37yYfeBuJBhAyNOUj14b3n3MH69CUWdquaWcdaIyqY
	 49RF7CeLJlSez3DtF7xtQ5jlLwlalVsmaIsg9EO5BQpHargLId5oleuKXdUI9YEmbu
	 Jgo2bdUtSbjcFnfYUqj8hvrEpdqVYScSISLUJRlJAYfqt9Gz3PDI4tPFqn5UYD0dBf
	 mbZqSY6BDnaKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] btrfs: explicitly ref count block_group on new_bgs list
Date: Mon, 18 Aug 2025 21:58:47 -0400
Message-ID: <20250819015850.263708-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081853-parrot-skeleton-78e1@gregkh>
References: <2025081853-parrot-skeleton-78e1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit 7cbce3cb4c5cfffd8b08f148e2136afc1ec1ba94 ]

All other users of the bg_list list_head increment the refcount when
adding to a list and decrement it when deleting from the list. Just for
the sake of uniformity and to try to avoid refcounting bugs, do it for
this list as well.

This does not fix any known ref-counting bug, as the reference belongs
to a single task (trans_handle is not shared and this represents
trans_handle->new_bgs linkage) and will not lose its original refcount
while that thread is running. And BLOCK_GROUP_FLAG_NEW protects against
ref-counting errors "moving" the block group to the unused list without
taking a ref.

With that said, I still believe it is simpler to just hold the extra ref
count for this list user as well.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 62be7afcc13b ("btrfs: zoned: requeue to unused block group list if zone finish failed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 2 ++
 fs/btrfs/transaction.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index dd35e29d8082..7a18d862821b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2784,6 +2784,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		spin_lock(&fs_info->unused_bgs_lock);
 		list_del_init(&block_group->bg_list);
 		clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
+		btrfs_put_block_group(block_group);
 		spin_unlock(&fs_info->unused_bgs_lock);
 
 		/*
@@ -2922,6 +2923,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	}
 #endif
 
+	btrfs_get_block_group(cache);
 	list_add_tail(&cache->bg_list, &trans->new_bgs);
 	btrfs_inc_delayed_refs_rsv_bg_inserts(fs_info);
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 24806e19c7c4..d8f7232fd9b7 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2111,6 +2111,7 @@ static void btrfs_cleanup_pending_block_groups(struct btrfs_trans_handle *trans)
 		*/
 	       spin_lock(&fs_info->unused_bgs_lock);
                list_del_init(&block_group->bg_list);
+	       btrfs_put_block_group(block_group);
 	       spin_unlock(&fs_info->unused_bgs_lock);
        }
 }
-- 
2.50.1


