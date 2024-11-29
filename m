Return-Path: <stable+bounces-95834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614B79DEC9B
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACBB1B21261
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 20:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DDB150994;
	Fri, 29 Nov 2024 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJZekui5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BB513DB9F
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732910599; cv=none; b=YXrV6zOFinf09Y4sFs6iSt9DQl2MWsUNd46sIuoxJds/WCOf36ofp2MBqYt9J2hLvbAaKHa9lzPjnjvRp/JlROJyl56ympyaX0o0YmtHnttpsLijbx189cNsaYRMOw3yWaJcBSlnoO2lukv5FEuncYoDdJRtIZYT937pCmEs/Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732910599; c=relaxed/simple;
	bh=WaH5wfKujkZlhd6qSN2qntTw5B+yZY0NaQ1fOi5EcIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUPuUzze6EM+BddPixSrhehCp3NFevquBQoPmwxzWodPq2Cq5+DddfivZkyNDytBpWLvioztak/E6rvCvSkvcsCRsySjlSew8BV6sJtwgUGwD+UL4SIQRS2UcoeZBNhB/TIkWzKhhZo1h8YK2veIZgauXPfErWeMR2+VfEEgbp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJZekui5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF70C4CECF;
	Fri, 29 Nov 2024 20:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732910597;
	bh=WaH5wfKujkZlhd6qSN2qntTw5B+yZY0NaQ1fOi5EcIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QJZekui5pnNlvF96LiI7Ld08uPCuKl2B+h9dWoEi/kXbZvw5cCsC110Xz8Ixo3pB1
	 SfhpJ2fIcZrlLrG5BL03vVaKwIVkNk4qrzEayuu324gugG94UsV3a7YnQ74VoxnqJi
	 gWfjR1flNZOalp+WTjo8QrC0j3ZMkt46bItBFOrl1kSvuzXYEbPN40Hr6oeE0N8UMa
	 jX6ca9CDiUvINYm8J7G9bS7fmT3Wkt3kXBwdQmkI1tNMyke5VkwAv7dFCsRF82lDbN
	 eKqOHht6Kub5959NJ/1SyLuEGvAzJ3f/Z0YeU30mW5S+d6zQLuPJ4ikrrIpzEyHFwP
	 vXD/hjGfO1zwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume operations
Date: Fri, 29 Nov 2024 15:03:15 -0500
Message-ID: <20241129141301-d4029fe61627016f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241129082100.981101-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 74e97958121aa1f5854da6effba70143f051b0cd

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Boris Burkov <boris@bur.io>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 14431815a4ae)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  74e97958121aa ! 1:  bd47b55888ef7 btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume operations
    @@ Metadata
      ## Commit message ##
         btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume operations
     
    +    commit 74e97958121aa1f5854da6effba70143f051b0cd upstream.
    +
         Create subvolume, create snapshot and delete subvolume all use
         btrfs_subvolume_reserve_metadata() to reserve metadata for the changes
         done to the parent subvolume's fs tree, which cannot be mediated in the
    @@ Commit message
         Reviewed-by: Qu Wenruo <wqu@suse.com>
         Signed-off-by: Boris Burkov <boris@bur.io>
         Signed-off-by: David Sterba <dsterba@suse.com>
    +    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    [Xiangyu: BP to fix CVE-2024-35956, due to 6.1 btrfs_subvolume_release_metadata()
    +    defined in ctree.h, modified the header file name from root-tree.h to ctree.h]
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
    +
    + ## fs/btrfs/ctree.h ##
    +@@ fs/btrfs/ctree.h: enum btrfs_flush_state {
    + int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
    + 				     struct btrfs_block_rsv *rsv,
    + 				     int nitems, bool use_global_rsv);
    +-void btrfs_subvolume_release_metadata(struct btrfs_root *root,
    +-				      struct btrfs_block_rsv *rsv);
    + void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
    + 
    + int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
     
      ## fs/btrfs/inode.c ##
    -@@ fs/btrfs/inode.c: int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
    +@@ fs/btrfs/inode.c: int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
      	struct btrfs_trans_handle *trans;
      	struct btrfs_block_rsv block_rsv;
      	u64 root_flags;
    @@ fs/btrfs/inode.c: int btrfs_delete_subvolume(struct btrfs_inode *dir, struct den
      	int ret;
      
      	down_write(&fs_info->subvol_sem);
    -@@ fs/btrfs/inode.c: int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
    +@@ fs/btrfs/inode.c: int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
      	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv, 5, true);
      	if (ret)
      		goto out_undead;
    @@ fs/btrfs/inode.c: int btrfs_delete_subvolume(struct btrfs_inode *dir, struct den
      	trans->block_rsv = &block_rsv;
      	trans->bytes_reserved = block_rsv.size;
      
    -@@ fs/btrfs/inode.c: int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
    +@@ fs/btrfs/inode.c: int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
      	ret = btrfs_end_transaction(trans);
      	inode->i_flags |= S_DEAD;
      out_release:
    @@ fs/btrfs/inode.c: int btrfs_delete_subvolume(struct btrfs_inode *dir, struct den
      		spin_lock(&dest->root_item_lock);
     
      ## fs/btrfs/ioctl.c ##
    -@@ fs/btrfs/ioctl.c: static noinline int create_subvol(struct mnt_idmap *idmap,
    +@@ fs/btrfs/ioctl.c: static noinline int create_subvol(struct user_namespace *mnt_userns,
      	int ret;
      	dev_t anon_dev;
      	u64 objectid;
    @@ fs/btrfs/ioctl.c: static noinline int create_subvol(struct mnt_idmap *idmap,
      
      	root_item = kzalloc(sizeof(*root_item), GFP_KERNEL);
      	if (!root_item)
    -@@ fs/btrfs/ioctl.c: static noinline int create_subvol(struct mnt_idmap *idmap,
    +@@ fs/btrfs/ioctl.c: static noinline int create_subvol(struct user_namespace *mnt_userns,
      					       trans_num_items, false);
      	if (ret)
      		goto out_new_inode_args;
    @@ fs/btrfs/ioctl.c: static noinline int create_subvol(struct mnt_idmap *idmap,
     +	qgroup_reserved = 0;
      	trans->block_rsv = &block_rsv;
      	trans->bytes_reserved = block_rsv.size;
    - 	/* Tree log can't currently deal with an inode which is a new root. */
    -@@ fs/btrfs/ioctl.c: static noinline int create_subvol(struct mnt_idmap *idmap,
    + 
    +@@ fs/btrfs/ioctl.c: static noinline int create_subvol(struct user_namespace *mnt_userns,
      out:
      	trans->block_rsv = NULL;
      	trans->bytes_reserved = 0;
     -	btrfs_subvolume_release_metadata(root, &block_rsv);
    --
    - 	btrfs_end_transaction(trans);
    + 
    + 	if (ret)
    + 		btrfs_end_transaction(trans);
    + 	else
    + 		ret = btrfs_commit_transaction(trans);
     +out_release_rsv:
     +	btrfs_block_rsv_release(fs_info, &block_rsv, (u64)-1, NULL);
     +	if (qgroup_reserved)
    @@ fs/btrfs/root-tree.c: int btrfs_subvolume_reserve_metadata(struct btrfs_root *ro
     -	btrfs_block_rsv_release(fs_info, rsv, (u64)-1, &qgroup_to_release);
     -	btrfs_qgroup_convert_reserved_meta(root, qgroup_to_release);
     -}
    -
    - ## fs/btrfs/root-tree.h ##
    -@@ fs/btrfs/root-tree.h: struct btrfs_trans_handle;
    - int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
    - 				     struct btrfs_block_rsv *rsv,
    - 				     int nitems, bool use_global_rsv);
    --void btrfs_subvolume_release_metadata(struct btrfs_root *root,
    --				      struct btrfs_block_rsv *rsv);
    - int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
    - 		       u64 ref_id, u64 dirid, u64 sequence,
    - 		       const struct fscrypt_str *name);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

