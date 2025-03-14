Return-Path: <stable+bounces-124486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3F3A6214E
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111C519C58F4
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECCA1C6FE4;
	Fri, 14 Mar 2025 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvPxh+yh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B33C1F92E
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993825; cv=none; b=mMAge6hVUay+31eBKwLA8sneyaXVgMWvPMzdH20pKUiYgxdkyWv5lt1ZfowTFDH87z/uROM5IqMnZzX0xYgkIJDzrYZMuimIpOl2QdL2f7vxmBhKsq3MdreqJq+dmSbmetNX5c3a06M1n+ny3KPjiyBewSxMfky2eQryfmNq/bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993825; c=relaxed/simple;
	bh=BOlxua/vEFsMtA7+KNYcdmtjdH8YYwvu0gUgEKbsL3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqXMsHwhGojPNDoMSD/ere/ROifZB1ZkfzPrTEtusug4zm0KFDEMnQUojFdSkbSkivfYs+2hV2LOCbZAzxDr9NVsSliwQ2qQ2HTFi1ETawdE7Xhdpv5HGivPRmhpBqoIJwPwahlqmzhCY889FU5d4T6nwO4IfUEpkSzQzzUjdYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvPxh+yh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C49FC4CEE3;
	Fri, 14 Mar 2025 23:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993824;
	bh=BOlxua/vEFsMtA7+KNYcdmtjdH8YYwvu0gUgEKbsL3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dvPxh+yhlQwDv7tqD3k6tj8bnzC9alA9bPqflPWCeOD5dAsc3mcbY69J2ZqMAiNng
	 4WDBky5zA9rQZxZRatKdeJ7za0Qeod4PnFM1zSaq1JhqPMxO8XboxA5gmzlMAySyhZ
	 j8V7jd2GU3XYa2+YSq6Say/+7+bAiIkpWOXnUKbu4NtmQVA6+K0et2aTEhB+gHmexn
	 2GNqUq7p3v85Miiysw2/gElIhITL01iDZeAk3vnmwhDmeM8c/sXZVaWQhfIXAr0hvQ
	 mVfHzV2W5NWqfM1JOxncNtoaiWRb0V9OvGYjPTHuRONX1GvSvYYTOhGXQDRPVXB3Gd
	 2LxUJqsV8OoKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 07/29] xfs: fix bounds check in xfs_defer_agfl_block()
Date: Fri, 14 Mar 2025 19:10:23 -0400
Message-Id: <20250314115051-e65091769b2bc533@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250313202550.2257219-8-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 2bed0d82c2f78b91a0a9a5a73da57ee883a0c070

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Dave Chinner<dchinner@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  2bed0d82c2f78 ! 1:  aec5f983044b3 xfs: fix bounds check in xfs_defer_agfl_block()
    @@ Metadata
      ## Commit message ##
         xfs: fix bounds check in xfs_defer_agfl_block()
     
    +    [ Upstream commit 2bed0d82c2f78b91a0a9a5a73da57ee883a0c070 ]
    +
         Need to happen before we allocate and then leak the xefi. Found by
         coverity via an xfsprogs libxfs scan.
     
    @@ Commit message
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_alloc.c ##
     @@ fs/xfs/libxfs/xfs_alloc.c: static int
    @@ fs/xfs/libxfs/xfs_alloc.c: static int
     +	xefi->xefi_startblock = fsbno;
      	xefi->xefi_blockcount = 1;
      	xefi->xefi_owner = oinfo->oi_owner;
    - 	xefi->xefi_agresv = XFS_AG_RESV_AGFL;
      
     -	if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbno(mp, xefi->xefi_startblock)))
     -		return -EFSCORRUPTED;
     -
      	trace_xfs_agfl_free_defer(mp, agno, 0, agbno, 1);
      
    - 	xfs_extent_free_get_group(mp, xefi);
    + 	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_AGFL_FREE, &xefi->xefi_list);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

