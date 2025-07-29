Return-Path: <stable+bounces-165140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A7EB153EA
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78E2560ECE
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1023C512;
	Tue, 29 Jul 2025 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFX85jY9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F723184F
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818599; cv=none; b=e0vTXXnncHXJvfQYvyk4P4Lu4oXQacTQyuYdvggKa2fauT7z5FjHtWLFH0FadSc3mtSJMyfYvs88O5Gi9RWMih8edmOmFkh+Gi9kYOd+ju+FYckVDAKzDKflw6c+d2T6xL9H/lnt9zXQ4qppFj9jZG2NsWVbaFe4wzVReMA1Rmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818599; c=relaxed/simple;
	bh=4woA870kgWDYfDIvJpkfXEU8xEwfxRzvjfOv8fjtB0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMUqBKqNwdr8OX2/Dq0yE+p18krpIyy6wZKAW0fJaeSlLNXe3O/IPwCump4foqaeIItURdvqZb0Jd4VsErEsycClaqTk0k+Nx3cQ3FW15sx9KC1m2WUMzhVrQbniIuVgYOH0XM+CdktuRkZOw6eFYXzuSTENqWIeMP1jXl301cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFX85jY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D87AC4CEEF;
	Tue, 29 Jul 2025 19:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818599;
	bh=4woA870kgWDYfDIvJpkfXEU8xEwfxRzvjfOv8fjtB0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iFX85jY9hkdVlSqAJULQuZEr+2HAQT0pU3jyxhaY0TscHo9jFXo6Qmgeue4yx6Yds
	 SMI6eq2TJ1jNbFHfGJmeFu576rVJ8BhASlSjgBnJBr6NrgcjiF9IKNeviWaKJc/upb
	 ob+InXjXv7erh6I3p9uIUFtY3r5MJdan/5tZXwULWNaUXIbkYpnb8AVxo7VJZyLIiU
	 fk9//pFLCnX9z5LwzntQ80hbmgx148sNl4IrTHbW8XKvsIk8m98VKvto3t8ViMcpaF
	 d+cY1REZGagZXVcfDqZF88oz2SVyIra2ei0+JOAY7MWl0fNa1KLFhRmYAqBqMfJSj7
	 7wIbhKjuDNdKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10] btrfs: fix deadlock when cloning inline extents and using qgroups
Date: Tue, 29 Jul 2025 15:49:57 -0400
Message-Id: <1753812619-d536d06d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729050753.98449-1-shivani.agarwal@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: f9baa501b4fd6962257853d46ddffbc21f27e344

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shivani Agarwal <shivani.agarwal@broadcom.com>
Commit author: Filipe Manana <fdmanana@suse.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  f9baa501b4fd ! 1:  0c0156bba7e3 btrfs: fix deadlock when cloning inline extents and using qgroups
    @@ Metadata
      ## Commit message ##
         btrfs: fix deadlock when cloning inline extents and using qgroups
     
    +    commit f9baa501b4fd6962257853d46ddffbc21f27e344 upstream.
    +
         There are a few exceptional cases where cloning an inline extent needs to
         copy the inline extent data into a page of the destination inode.
     
    @@ Commit message
         Signed-off-by: Filipe Manana <fdmanana@suse.com>
         Reviewed-by: David Sterba <dsterba@suse.com>
         Signed-off-by: David Sterba <dsterba@suse.com>
    +    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    [Shivani: Modified to apply on 5.10.y, Passed false to
    +    btrfs_start_delalloc_flush() in fs/btrfs/transaction.c file to
    +    maintain the default behaviour]
    +    Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
     
      ## fs/btrfs/ctree.h ##
     @@ fs/btrfs/ctree.h: int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
    - 			       struct btrfs_inode *inode, u64 new_size,
    + 			       struct inode *inode, u64 new_size,
      			       u32 min_type);
      
     -int btrfs_start_delalloc_snapshot(struct btrfs_root *root);
     +int btrfs_start_delalloc_snapshot(struct btrfs_root *root, bool in_reclaim_context);
    - int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
    + int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr,
      			       bool in_reclaim_context);
      int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
     
    @@ fs/btrfs/inode.c: int btrfs_start_delalloc_snapshot(struct btrfs_root *root)
     +	return start_delalloc_inodes(root, &wbc, true, in_reclaim_context);
      }
      
    - int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
    + int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr,
     
      ## fs/btrfs/ioctl.c ##
     @@ fs/btrfs/ioctl.c: static noinline int btrfs_mksnapshot(const struct path *parent,
    @@ fs/btrfs/send.c: static int flush_delalloc_roots(struct send_ctx *sctx)
      		if (ret)
      			return ret;
      		btrfs_wait_ordered_extents(root, U64_MAX, 0, U64_MAX);
    +
    + ## fs/btrfs/transaction.c ##
    +@@ fs/btrfs/transaction.c: static inline int btrfs_start_delalloc_flush(struct btrfs_trans_handle *trans)
    + 		list_for_each_entry(pending, head, list) {
    + 			int ret;
    + 
    +-			ret = btrfs_start_delalloc_snapshot(pending->root);
    ++			ret = btrfs_start_delalloc_snapshot(pending->root, false);
    + 			if (ret)
    + 				return ret;
    + 		}

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

