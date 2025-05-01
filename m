Return-Path: <stable+bounces-139387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB51AA639A
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A53157B3F8E
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A19222539C;
	Thu,  1 May 2025 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3FkQ33g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E761DF751
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126726; cv=none; b=CqvGdLhFzO1Dacd2A89Zl4SlmASU9zsiN1qSc5GkEXn+BVF3RY9m/0ObXPv2djj24MCHCY4BuxMTQTV77pqrvQmEm2gZTPKjlGAdrnJzVwzBq52A5qAfJVS9X8Colahwwf/UWgZgVeXul94A4H4q5zDrMSkTm2oDJDFPwmopSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126726; c=relaxed/simple;
	bh=yIZmJqfZVJGDsJOWrGNGTJrYfJzaNfPovcD8AO1oCm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7AxgPrdh2IlF4shEPCAHnCknz9/Tv0jySA2tlzNNcNUmS0ABd1wuPuvaImArwRXVKLRNAmBp7VB2mABhkz9alccFfKFgu/knTYbHqPWqaJr4DsBTzIE8KhcrB7PtxUAs9f/W1Jnh0hx3wKK01UBcv+z/NtSZmJQkKekSYO1rHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3FkQ33g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D654C4CEE3;
	Thu,  1 May 2025 19:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126725;
	bh=yIZmJqfZVJGDsJOWrGNGTJrYfJzaNfPovcD8AO1oCm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L3FkQ33gLCVG3FE+zLPkaOT7xL1rF3gvb4DxxEOLhLkg99BsCGdgH3BiUcX3qNrO3
	 PwV5OyhqRxVCByksHdzzroIKYygf/h/axBRC9ewIgqZGZeNWVlv6C9ssxY3mxdEHEO
	 lMLA1HqXo5bFHAHfajfGAEUtmxWN3sRBQbdlHw/lVTJF3yS7IwzqwZAr+D2lAWPXVn
	 w1ciiktDO9Fqhx041sIFg+eySw7zC5xMlRozeAWIqr194NeCD0Ux+8h6C+A0/3unCY
	 zk9oJfrUlMG1ibwSOWUBB012hv6RLPuYqggnwVKtFUr7KGzq83FRZ9RedZYk/Cmh9E
	 sf1Nf4Cr8+rsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 16/16] xfs: restrict when we try to align cow fork delalloc to cowextsz hints
Date: Thu,  1 May 2025 15:12:01 -0400
Message-Id: <20250501132127-5923b0726077e7fc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-17-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 288e1f693f04e66be99f27e7cbe4a45936a66745

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 9a0ab4fc28ed)

Note: The patch differs from the upstream commit:
---
1:  288e1f693f04e ! 1:  982df6cb2b8c2 xfs: restrict when we try to align cow fork delalloc to cowextsz hints
    @@ Metadata
      ## Commit message ##
         xfs: restrict when we try to align cow fork delalloc to cowextsz hints
     
    +    [ Upstream commit 288e1f693f04e66be99f27e7cbe4a45936a66745 ]
    +
         xfs/205 produces the following failure when always_cow is enabled:
     
           --- a/tests/xfs/205.out       2024-02-28 16:20:24.437887970 -0800
    @@ Commit message
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_bmap.c ##
     @@ fs/xfs/libxfs/xfs_bmap.c: xfs_bmapi_reserve_delalloc(
    + 	xfs_extlen_t		alen;
      	xfs_extlen_t		indlen;
    - 	uint64_t		fdblocks;
      	int			error;
     -	xfs_fileoff_t		aoff = off;
     +	xfs_fileoff_t		aoff;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

