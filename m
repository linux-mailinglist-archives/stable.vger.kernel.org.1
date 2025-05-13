Return-Path: <stable+bounces-144261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE99AB5CDA
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870AA3A7EE5
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7632BFC74;
	Tue, 13 May 2025 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZozIThqo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1BE20E032
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162277; cv=none; b=Q5CsQ08TuXmO9tpR/oGoBr2BtQlhJ9ydX/CGD1Z4eZ4L1POnYcVKwdY/ikl2jSxil9Ye0jrK1Jq2Ige3h335SdDxzbUCby5O/hs9kdq8T+VYfuTlgSX7oHGct3D7GLdENhCVAIgrN9GJBxQb1L0tV/hGHAsZSgtSYJfm9JjooVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162277; c=relaxed/simple;
	bh=2mbHESpuLpwdQDqUfLG8BWEg/BWdDn82eEBllPe5c+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buO4i6QgnTVycCGXmQmahhEyDTy1Mi9I85mRW9UuGZXHCGbHTpHKQsSCn1PxD1sHJWWB29BHY0h/NDcUfYOz3MxyInIoT0dibW+dKmdY4myYZ/iascDw1J1UGYp0FSKENZ3dedodHzgaacKj+wi4LygXDARqZ1H2BOJlbYKnSVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZozIThqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894DEC4CEE4;
	Tue, 13 May 2025 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162277;
	bh=2mbHESpuLpwdQDqUfLG8BWEg/BWdDn82eEBllPe5c+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZozIThqoC5OVR48JSQYuQNIVYlh1ks9zDdAdsxbWOnOZw2E36bm3RdJY/lTEWkrep
	 lGnI+EPRiZJ7PQ/fp5JVxvSP6iaU1wv2GyNSWn++C211oLVdM2qAJC1U/a1wzEzqaU
	 INmZovSJx/aP0JsFYLgZiPapel+aK8jX4u8at3Oe6kRssmnu9L5J5MRnSQ3XFw8Ghb
	 Wgf5Hnr4Mr5VysxTvmKeydqwOl50U5GPO7qEmulUzk04FOy2l4c6YobEZdK07BKNj9
	 hWf20EOHmhbCEcrqABYRKQX9DJjSydsFgCD0SVnsbp4ZlVRCCKPYEpONqeMTmrXAhf
	 wU4yehnwE/STg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhi Yang <Zhi.Yang@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] btrfs: get rid of warning on transaction commit when using flushoncommit
Date: Tue, 13 May 2025 14:51:12 -0400
Message-Id: <20250513074055-c3ce54f7c117e623@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513024200.1811319-1-Zhi.Yang@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: a0f0cf8341e34e5d2265bfd3a7ad68342da1e2aa

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhi Yang<Zhi.Yang@eng.windriver.com>
Commit author: Filipe Manana<fdmanana@suse.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: 850a77c999b8)

Note: The patch differs from the upstream commit:
---
1:  a0f0cf8341e34 ! 1:  af3df33f85da5 btrfs: get rid of warning on transaction commit when using flushoncommit
    @@ Metadata
      ## Commit message ##
         btrfs: get rid of warning on transaction commit when using flushoncommit
     
    +    commit a0f0cf8341e34e5d2265bfd3a7ad68342da1e2aa upstream.
    +
         When using the flushoncommit mount option, during almost every transaction
         commit we trigger a warning from __writeback_inodes_sb_nr():
     
    @@ Commit message
         Signed-off-by: Filipe Manana <fdmanana@suse.com>
         [ add more link reports ]
         Signed-off-by: David Sterba <dsterba@suse.com>
    +    [Minor context change fixed]
    +    Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## fs/btrfs/transaction.c ##
    -@@ fs/btrfs/transaction.c: static void btrfs_cleanup_pending_block_groups(struct btrfs_trans_handle *trans)
    - static inline int btrfs_start_delalloc_flush(struct btrfs_fs_info *fs_info)
    - {
    +@@ fs/btrfs/transaction.c: static inline int btrfs_start_delalloc_flush(struct btrfs_trans_handle *trans)
    + 	struct btrfs_fs_info *fs_info = trans->fs_info;
    + 
      	/*
     -	 * We use writeback_inodes_sb here because if we used
     +	 * We use try_to_writeback_inodes_sb() here because if we used
    @@ fs/btrfs/transaction.c: static void btrfs_cleanup_pending_block_groups(struct bt
     +	 * Note that we don't call writeback_inodes_sb() directly, because it
     +	 * will emit a warning if sb->s_umount is not locked.
      	 */
    - 	if (btrfs_test_opt(fs_info, FLUSHONCOMMIT))
    + 	if (btrfs_test_opt(fs_info, FLUSHONCOMMIT)) {
     -		writeback_inodes_sb(fs_info->sb, WB_REASON_SYNC);
     +		try_to_writeback_inodes_sb(fs_info->sb, WB_REASON_SYNC);
    - 	return 0;
    - }
    - 
    + 	} else {
    + 		struct btrfs_pending_snapshot *pending;
    + 		struct list_head *head = &trans->transaction->pending_snapshots;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

