Return-Path: <stable+bounces-139355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A75AA6329
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B99F4682B5
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921AC223DE3;
	Thu,  1 May 2025 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJTS5atR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A581C1F22
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125504; cv=none; b=pFYSpdPGL761xLo5ppzL6RLQaZjXF2Pn8jgscjtleXhC/SUuadZ0FgbTzXsVoBzc78h+w0AxkuFiUTwkF36rTLXeOPzCnksp1h+xIYvD4SqgQEjook7oXm1Sg6w2//WVZG0mr5hBNH64y8LEwb9SvdMzWV1zTf2WhagzD01WujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125504; c=relaxed/simple;
	bh=M535i6+mF117QQiL5klB4gLtLFUwXVJ2hkHDUzyj73E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sA28Ovfye6yy11jp+Cf7j+SkNEgxoYgAmh1BNZK+kdthMAl7JNiSvU9hf4xE+r6YSt6o85ll3LJLgPTyN2qlY9ZZtJp6Sprt51+t25o8dG4MrW825HcsQL1QwyNsI0IWD+ykDvfRGfX9i01jKBu7MEjqkK5XKBOjtZFpOCRG6tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJTS5atR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3AAC4CEE3;
	Thu,  1 May 2025 18:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125503;
	bh=M535i6+mF117QQiL5klB4gLtLFUwXVJ2hkHDUzyj73E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJTS5atRvO6Sc+4RO+ifNETwxgMU2c1UVXc3BSwhrdKV/FQdUmbm+liqCLxZeO4+t
	 /WMXqk4ya6Jh1fEpvthbr084cvGopx8jNZ6jmWI7WBVb7dtEWxbYk6VWuFZcf9JPLu
	 7ZGSVDmAS98HpppXuDof97ORked39LwZ9PzF9Plpk8AWGqWTB+MRl7afwSyUGBrBrc
	 1XguJAM3kynw2d4+IWlNyc8aa2ymBWgv/iO6nLKcmMdGMoIjLiX/GCbxtF/NkDJ4jR
	 toYSihC6dKYJgQaUi3bGCObDmOnFCObpHaRKcx0yNsIAdHDD+WTvf4lv7fKigXwtAT
	 kEA23DP57cN5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 01/16] xfs: fix error returns from xfs_bmapi_write
Date: Thu,  1 May 2025 14:51:39 -0400
Message-Id: <20250501122150-5b5e37f70e94af53@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-2-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 6773da870ab89123d1b513da63ed59e32a29cb77

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Christoph Hellwig<hch@lst.de>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: f43bd357fde0)

Note: The patch differs from the upstream commit:
---
1:  6773da870ab89 ! 1:  00b5c634c7b39 xfs: fix error returns from xfs_bmapi_write
    @@ Metadata
      ## Commit message ##
         xfs: fix error returns from xfs_bmapi_write
     
    +    [ Upstream commit 6773da870ab89123d1b513da63ed59e32a29cb77 ]
    +
         xfs_bmapi_write can return 0 without actually returning a mapping in
         mval in two different cases:
     
    @@ Commit message
         Reported-by: 刘通 <lyutoon@gmail.com>
         Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_attr_remote.c ##
     @@ fs/xfs/libxfs/xfs_attr_remote.c: xfs_attr_rmtval_set_blk(
    @@ fs/xfs/libxfs/xfs_bmap.c: xfs_bmapi_write(
      	return 0;
      error0:
      	xfs_bmapi_finish(&bma, whichfork, error);
    -@@ fs/xfs/libxfs/xfs_bmap.c: xfs_bmapi_convert_one_delalloc(
    +@@ fs/xfs/libxfs/xfs_bmap.c: xfs_bmapi_convert_delalloc(
      	if (error)
      		goto out_finish;
      
     -	error = -ENOSPC;
     -	if (WARN_ON_ONCE(bma.blkno == NULLFSBLOCK))
     -		goto out_finish;
    - 	if (WARN_ON_ONCE(!xfs_valid_startblock(ip, bma.got.br_startblock))) {
    - 		xfs_bmap_mark_sick(ip, whichfork);
    - 		error = -EFSCORRUPTED;
    + 	error = -EFSCORRUPTED;
    + 	if (WARN_ON_ONCE(!xfs_valid_startblock(ip, bma.got.br_startblock)))
    + 		goto out_finish;
     
      ## fs/xfs/libxfs/xfs_da_btree.c ##
     @@ fs/xfs/libxfs/xfs_da_btree.c: xfs_da_grow_inode_int(
    @@ fs/xfs/libxfs/xfs_da_btree.c: xfs_da_grow_inode_int(
      	/*
      	 * Count the blocks we got, make sure it matches the total.
     
    - ## fs/xfs/scrub/quota_repair.c ##
    -@@ fs/xfs/scrub/quota_repair.c: xrep_quota_item_fill_bmap_hole(
    - 			irec, &nmaps);
    - 	if (error)
    - 		return error;
    --	if (nmaps != 1)
    --		return -ENOSPC;
    - 
    - 	dq->q_blkno = XFS_FSB_TO_DADDR(mp, irec->br_startblock);
    - 
    -@@ fs/xfs/scrub/quota_repair.c: xrep_quota_data_fork(
    - 					XFS_BMAPI_CONVERT, 0, &nrec, &nmap);
    - 			if (error)
    - 				goto out;
    --			if (nmap != 1) {
    --				error = -ENOSPC;
    --				goto out;
    --			}
    - 			ASSERT(nrec.br_startoff == irec.br_startoff);
    - 			ASSERT(nrec.br_blockcount == irec.br_blockcount);
    - 
    -
    - ## fs/xfs/scrub/rtbitmap_repair.c ##
    -@@ fs/xfs/scrub/rtbitmap_repair.c: xrep_rtbitmap_data_mappings(
    - 				0, &map, &nmaps);
    - 		if (error)
    - 			return error;
    --		if (nmaps != 1)
    --			return -EFSCORRUPTED;
    - 
    - 		/* Commit new extent and all deferred work. */
    - 		error = xrep_defer_finish(sc);
    -
      ## fs/xfs/xfs_bmap_util.c ##
     @@ fs/xfs/xfs_bmap_util.c: xfs_alloc_file_space(
      		if (error)
    @@ fs/xfs/xfs_iomap.c: xfs_iomap_write_direct(
     -		goto out_unlock;
     -	}
     -
    - 	if (unlikely(!xfs_valid_startblock(ip, imap->br_startblock))) {
    - 		xfs_bmap_mark_sick(ip, XFS_DATA_FORK);
    + 	if (unlikely(!xfs_valid_startblock(ip, imap->br_startblock)))
      		error = xfs_alert_fsblock_zero(ip, imap);
    + 
     
      ## fs/xfs/xfs_reflink.c ##
     @@ fs/xfs/xfs_reflink.c: xfs_reflink_fill_cow_hole(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

