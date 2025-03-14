Return-Path: <stable+bounces-124478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D592A62144
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C65119C55C2
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144771DF242;
	Fri, 14 Mar 2025 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RV/J/MBQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AEB1F92E
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993808; cv=none; b=Qi0D21i2BcGqfW/da5Oq3Hcaeari7JXnCPP5zQ77P5soI7q0eSLsZ8acyPKqzADFBXRaW6P6epy+nmeztbh+R/lSl7ZPltpKBS3nHnzxVuYz3m0Jqd56EYmH0bzJ0bZ9i+cppUZM95QYDUji7R1WlBEKk8ZlR9nILM+AAtL4y1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993808; c=relaxed/simple;
	bh=wSalaZtqoEhgxesvIgkHrK2m8lEkxMTUrJBq+/X6KM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCbgeb0suVBVxxwtI9s+7JQ0Et87dlwtZ6u4cZxw2zHy+eE+EFcdIfF9LwXOoMwuJWIwszEoxEmPMlikAVVai2Zm4Wj2T0QjSG0EYRPSgJCp9/5Hysds86mlcxxKM+vcXdieLTpAQBpJIiZG2I0c5TedDxNFlD4typ5MmVR7IHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RV/J/MBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C2FC4CEE3;
	Fri, 14 Mar 2025 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993808;
	bh=wSalaZtqoEhgxesvIgkHrK2m8lEkxMTUrJBq+/X6KM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RV/J/MBQTjT+6WUAD9luzROfGICBbUJAN8ZhLuV0gXej1RoE3QAszXe0gDUh/OZez
	 L48AX5MZupMllrXPrWmvPC6XVC8LwJJJFUwzW7XAi1LewuQl6ORl4JkNbwGns9w6R5
	 JSCrDKYh3QtjtfkBQ1x+KEkNFH61zw0nWUwODJxPQBKam3iNF1acCsQ/DG0dYTPtpt
	 rZkj4j39lGeKe2+GMWnfYJO9cRlDL4T3UvLAqyCv1fXUx7NIdAo7jhP6+PHSriF5NB
	 fCuxI6z/Q5AkHbMF38RU5USANhmX4FJ9tkE5KxQAzhvQHBE0hLng+1IW974LAa4iDc
	 HALFeziZ3oQNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	leah.rumancik@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 06/29] xfs: validate block number being freed before adding to xefi
Date: Fri, 14 Mar 2025 19:10:06 -0400
Message-Id: <20250314114210-a6b6a9e69a98be50@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250313202550.2257219-7-leah.rumancik@gmail.com>
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

Summary of potential issues:
ℹ️ This is part 06/29 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 7dfee17b13e5024c5c0ab1911859ded4182de3e5

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Dave Chinner<dchinner@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Found fixes commits:
2bed0d82c2f7 xfs: fix bounds check in xfs_defer_agfl_block()

Note: The patch differs from the upstream commit:
---
1:  7dfee17b13e50 ! 1:  0de6be42d2941 xfs: validate block number being freed before adding to xefi
    @@ Metadata
      ## Commit message ##
         xfs: validate block number being freed before adding to xefi
     
    +    [ Upstream commit 7dfee17b13e5024c5c0ab1911859ded4182de3e5 ]
    +
         Bad things happen in defered extent freeing operations if it is
         passed a bad block number in the xefi. This can come from a bogus
         agno/agbno pair from deferred agfl freeing, or just a bad fsbno
    @@ Commit message
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Dave Chinner <david@fromorbit.com>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_ag.c ##
     @@ fs/xfs/libxfs/xfs_ag.c: xfs_ag_shrink_space(
    @@ fs/xfs/libxfs/xfs_alloc.c: xfs_defer_agfl_block(
     +
      	trace_xfs_agfl_free_defer(mp, agno, 0, agbno, 1);
      
    - 	xfs_extent_free_get_group(mp, xefi);
      	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_AGFL_FREE, &xefi->xefi_list);
     +	return 0;
      }
    @@ fs/xfs/libxfs/xfs_alloc.c: __xfs_free_extent_later(
      			       GFP_KERNEL | __GFP_NOFAIL);
      	xefi->xefi_startblock = bno;
     @@ fs/xfs/libxfs/xfs_alloc.c: __xfs_free_extent_later(
    - 
    - 	xfs_extent_free_get_group(mp, xefi);
    + 			XFS_FSB_TO_AGNO(tp->t_mountp, bno), 0,
    + 			XFS_FSB_TO_AGBNO(tp->t_mountp, bno), len);
      	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_FREE, &xefi->xefi_list);
     +	return 0;
      }
    @@ fs/xfs/libxfs/xfs_alloc.h: xfs_buf_to_agfl_bno(
      		xfs_filblks_t len, const struct xfs_owner_info *oinfo,
      		bool skip_discard);
      
    -@@ fs/xfs/libxfs/xfs_alloc.h: void xfs_extent_free_get_group(struct xfs_mount *mp,
    +@@ fs/xfs/libxfs/xfs_alloc.h: struct xfs_extent_free_item {
      #define XFS_EFI_ATTR_FORK	(1U << 1) /* freeing attr fork block */
      #define XFS_EFI_BMBT_BLOCK	(1U << 2) /* freeing bmap btree block */
      
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

