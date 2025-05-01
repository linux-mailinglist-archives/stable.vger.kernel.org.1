Return-Path: <stable+bounces-139375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC97AA638A
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260EF9C1FE4
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61956224AE1;
	Thu,  1 May 2025 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7FnaFWZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E862248A0
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126624; cv=none; b=aENpt2NSog/FsHzwfWRvAbhkR/qnW8ZHCJQTxX4PEOoV/LwRokLXukHjhJQz9PL0Lw7xSyfq2G6ebwq5w63hV+FJChCOPKnLo3En/moVhTwkrRTt+vjHjsczRisMPCj+qaZ5aPwGU0vXxoqLpFaV0kGvKFRVHJ8aRE/Acpo4jqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126624; c=relaxed/simple;
	bh=twsRbVdC+5H4DXfrtGUouISDXeF7rHN5Phv85vngjEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAAa0OrCLEb9uCClmCRcPw/+CULThLQ65b4iYWbKvJGXFYwELwNccaxctjsQQrgHMBAmYAS9ucc4thwt0wGvMCGNSAfo4P8fvGzD7brGgVO0iuOT9LeKADfIYscBjSObV6qLVuOiRClCxoo3aAsh5RVCphgbIZ4NkSEEbhjcxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7FnaFWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B47C4CEE3;
	Thu,  1 May 2025 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126624;
	bh=twsRbVdC+5H4DXfrtGUouISDXeF7rHN5Phv85vngjEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B7FnaFWZEiGo5/ApCSpLS7ILde0VHsdurX15iPOd9ni/2Nzycdj4EZQLI0TNUujsr
	 sMMS+ZPa6kJrjkfTES0NADuLqM9cumfYeJSDVNzBSYJF6jSWuzWaqkzd0zZctbaaPc
	 4WXr18DfNfhxoWxL/xePqLMN9kUuuZRA4tOQyyPvmAoNLkKyfNuvsRFDGCDZFgsx2h
	 fREikV8X9Fj8jk9olfYwzEUsahVPd+cZ8gbyuaL5tMCBqHyJoEf/5u+QbrCdBuSXOv
	 SxGspQzmKYQuY6qEIJ6zTwRi1bbCmOll2pyf0dqsxKzgxoqhfnCuCb4UeDomE1s96E
	 +aiHj0iNsOwlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 14/16] xfs: fix freeing speculative preallocations for preallocated files
Date: Thu,  1 May 2025 15:10:19 -0400
Message-Id: <20250501131322-5e5e27d486a0df0a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-15-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 610b29161b0aa9feb59b78dc867553274f17fb01

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Christoph Hellwig<hch@lst.de>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 2bc2d49c36c2)

Note: The patch differs from the upstream commit:
---
1:  610b29161b0aa ! 1:  1695ca72c95de xfs: fix freeing speculative preallocations for preallocated files
    @@ Metadata
      ## Commit message ##
         xfs: fix freeing speculative preallocations for preallocated files
     
    +    [ Upstream commit 610b29161b0aa9feb59b78dc867553274f17fb01 ]
    +
         xfs_can_free_eofblocks returns false for files that have persistent
         preallocations unless the force flag is passed and there are delayed
         blocks.  This means it won't free delalloc reservations for files
    @@ Commit message
         Signed-off-by: Christoph Hellwig <hch@lst.de>
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/xfs_bmap_util.c ##
     @@ fs/xfs/xfs_bmap_util.c: xfs_bmap_punch_delalloc_range(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

