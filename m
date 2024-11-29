Return-Path: <stable+bounces-95833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC2A9DEC98
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FF6281FC2
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 20:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BC8150994;
	Fri, 29 Nov 2024 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTHQKSqs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E7D13DB9F
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732910595; cv=none; b=GOwMne6uHpX95VtwPZosDJ7d0dL8dGnprX5R7zSrQVv9HRkaF8avg1lz/ZHKsT/i0o8pYB7O37yr1vUpRANj3z4J9UgUXYtojzb1qUDrgd1KKciZ6gtYkQkE27jV6ThhF9P+wdS6vyh19uyjpQ6M8zEGil31JycrOwFneW/vPdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732910595; c=relaxed/simple;
	bh=4HNEB/dZvaCuCaRHnEv/eIQWACKnBTNXomB/mtFhJww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeuYFitdfcdYSyveLmNEiotbjXGeiP3iWOkV8IC+fAw9Wqs0H18xfEHo9lxwLqe8BV2Vkdu9bzZ4S7NWo1XzcA4+TwUfMQCXu964MeMOoaglM0Q7/nBc9mdjzY58c5TDxhkoeXjESgwPrfpl5O5lzqccC+x3z9jhd/9cksxVkX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTHQKSqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E02C4CECF;
	Fri, 29 Nov 2024 20:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732910595;
	bh=4HNEB/dZvaCuCaRHnEv/eIQWACKnBTNXomB/mtFhJww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VTHQKSqs8GXOKvQCn8OlCnTiNIFlZN8+bAeWo3tyPU59yG3lxTVwzgwSFlRHaGMJq
	 DAZgOm/rOcy2m9k5hKkRMBeA+/ICa3H4MGG9SV+3kGwWdTFYXYltU2VR2tsZgQEupM
	 X+kYoKgJpqSP5LyMSjNdSIMhUm1/EAHnr6H7UoMkqIoWTy8H9F5LI8m2/ULafZVImZ
	 SbjML3tqx1ayiuKqwIX8BONSfDjBmu2tZ4iPuB9BLMRbYYXBP5279YX0ghFaLLYE0F
	 UaWvHCDTX6x8oKPnl5jPj3r45Od5Y+hRrho5htU0qEbQg6b1rUxeGEXq3Qalwpgrgg
	 CscSMX37x+oeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] btrfs: do not BUG_ON() when freeing tree block after error
Date: Fri, 29 Nov 2024 15:03:13 -0500
Message-ID: <20241129144949-e094b8978adf72bb@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241129062713.1510250-1-bin.lan.cn@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: bb3868033a4cccff7be57e9145f2117cbdc91c11

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@eng.windriver.com
Commit author: Filipe Manana <fdmanana@suse.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bb3868033a4cc ! 1:  7b3a3b03bd7a2 btrfs: do not BUG_ON() when freeing tree block after error
    @@ Metadata
      ## Commit message ##
         btrfs: do not BUG_ON() when freeing tree block after error
     
    +    [ Upstream commit bb3868033a4cccff7be57e9145f2117cbdc91c11 ]
    +
         When freeing a tree block, at btrfs_free_tree_block(), if we fail to
         create a delayed reference we don't deal with the error and just do a
         BUG_ON(). The error most likely to happen is -ENOMEM, and we have a
    @@ Commit message
         Signed-off-by: Filipe Manana <fdmanana@suse.com>
         Reviewed-by: David Sterba <dsterba@suse.com>
         Signed-off-by: David Sterba <dsterba@suse.com>
    +    [ Resolve minor conflicts ]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
     
      ## fs/btrfs/ctree.c ##
    -@@ fs/btrfs/ctree.c: int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
    +@@ fs/btrfs/ctree.c: static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
      		atomic_inc(&cow->refs);
      		rcu_assign_pointer(root->node, cow);
      
    @@ fs/btrfs/ctree.c: int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
      	} else {
      		WARN_ON(trans->transid != btrfs_header_generation(parent));
      		ret = btrfs_tree_mod_log_insert_key(parent, parent_slot,
    -@@ fs/btrfs/ctree.c: int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
    +@@ fs/btrfs/ctree.c: static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
      				return ret;
      			}
      		}
    @@ fs/btrfs/ctree.c: int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
     @@ fs/btrfs/ctree.c: static noinline int balance_level(struct btrfs_trans_handle *trans,
      		free_extent_buffer(mid);
      
    - 		root_sub_used_bytes(root);
    + 		root_sub_used(root, mid->len);
     -		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
     +		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
      		/* once for the root ptr */
    @@ fs/btrfs/ctree.c: static noinline int balance_level(struct btrfs_trans_handle *t
     @@ fs/btrfs/ctree.c: static noinline int balance_level(struct btrfs_trans_handle *trans,
      				goto out;
      			}
    - 			root_sub_used_bytes(root);
    + 			root_sub_used(root, right->len);
     -			btrfs_free_tree_block(trans, btrfs_root_id(root), right,
    --					      0, 1);
    -+			ret = btrfs_free_tree_block(trans, btrfs_root_id(root),
    -+						    right, 0, 1);
    ++			ret = btrfs_free_tree_block(trans, btrfs_root_id(root), right,
    + 					      0, 1);
      			free_extent_buffer_stale(right);
      			right = NULL;
     +			if (ret < 0) {
    @@ fs/btrfs/ctree.c: static noinline int balance_level(struct btrfs_trans_handle *t
     @@ fs/btrfs/ctree.c: static noinline int balance_level(struct btrfs_trans_handle *trans,
      			goto out;
      		}
    - 		root_sub_used_bytes(root);
    + 		root_sub_used(root, mid->len);
     -		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
     +		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
      		free_extent_buffer_stale(mid);
    @@ fs/btrfs/ctree.c: static noinline int insert_new_root(struct btrfs_trans_handle
      		free_extent_buffer(c);
      		return ret;
     @@ fs/btrfs/ctree.c: static noinline int btrfs_del_leaf(struct btrfs_trans_handle *trans,
    - 	root_sub_used_bytes(root);
    + 	root_sub_used(root, leaf->len);
      
      	atomic_inc(&leaf->refs);
     -	btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
    @@ fs/btrfs/extent-tree.c: static noinline int check_ref_cleanup(struct btrfs_trans
     +			  u64 parent, int last_ref)
      {
      	struct btrfs_fs_info *fs_info = trans->fs_info;
    - 	struct btrfs_block_group *bg;
    + 	struct btrfs_ref generic_ref = { 0 };
     @@ fs/btrfs/extent-tree.c: void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
    - 		btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf), 0, false);
    + 	if (root_id != BTRFS_TREE_LOG_OBJECTID) {
      		btrfs_ref_tree_mod(fs_info, &generic_ref);
      		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref, NULL);
     -		BUG_ON(ret); /* -ENOMEM */
    @@ fs/btrfs/extent-tree.c: void btrfs_free_tree_block(struct btrfs_trans_handle *tr
     +			return ret;
      	}
      
    - 	if (!last_ref)
    --		return;
    -+		return 0;
    - 
    - 	if (btrfs_header_generation(buf) != trans->transid)
    - 		goto out;
    + 	if (last_ref && btrfs_header_generation(buf) == trans->transid) {
     @@ fs/btrfs/extent-tree.c: void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
    - 	 * matter anymore.
    - 	 */
    - 	clear_bit(EXTENT_BUFFER_CORRUPT, &buf->bflags);
    + 		 */
    + 		clear_bit(EXTENT_BUFFER_CORRUPT, &buf->bflags);
    + 	}
     +	return 0;
      }
      
    @@ fs/btrfs/extent-tree.c: static noinline int walk_up_proc(struct btrfs_trans_hand
     
      ## fs/btrfs/extent-tree.h ##
     @@ fs/btrfs/extent-tree.h: struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
    + 					     int level, u64 hint,
      					     u64 empty_size,
    - 					     u64 reloc_src_root,
      					     enum btrfs_lock_nesting nest);
     -void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
     -			   u64 root_id,
    @@ fs/btrfs/free-space-tree.c: int btrfs_delete_free_space_tree(struct btrfs_fs_inf
     +	}
      
      	return btrfs_commit_transaction(trans);
    - }
    + 
     
      ## fs/btrfs/ioctl.c ##
     @@ fs/btrfs/ioctl.c: static noinline int create_subvol(struct mnt_idmap *idmap,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

