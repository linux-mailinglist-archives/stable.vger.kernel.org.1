Return-Path: <stable+bounces-139369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F32AA6383
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2039C162B
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371A0224B15;
	Thu,  1 May 2025 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iua30g2I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB298224AEF
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126597; cv=none; b=P8PM3p0qn3ovkgohO76yX6ThZudp4y8xdgHOheknknznnc/9stRteNeI1Kt34uAF1QpOKoybTDY14laMzfjNjaqSORe6BEek75fyI3tEr386vSqt/icjk2uGo38EnT9zxH272WV0NObQP+gSJpebeEn0C42gVL9iRlinPhTrYQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126597; c=relaxed/simple;
	bh=E7ALtBzcOygvoB5JJr3CnYIbhWrgLwzEA46QGhHokFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDKknacd9kqM+Tidzx0bCrtjURNdSXYca+80KfNpr0eycUdlnf95FKII+36SU2fcw+siIcik5o/3w+mpSp9qedriLqdKE/38tcpvophiXnKIWluAqaf3zgAz/jZcA4BTEheRqRAeH9iX++h1rP0cIVdLiAKzX3k3lpV9Ej4jArs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iua30g2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005F7C4CEED;
	Thu,  1 May 2025 19:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126596;
	bh=E7ALtBzcOygvoB5JJr3CnYIbhWrgLwzEA46QGhHokFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iua30g2Ia/4VFafZDtL2TjWPyCB4N+Hlzpa24XdY5wz+qhQHpNthG5S9GIomzgH6H
	 EdhcNfsk1e9j6dPBFaKle/lwT9+awtz0gUVMqxhAjAN6MlHPpaq4xYjzMA0MTW9H8Q
	 U77WYvWwPKaTbubqDR3z7YB8mSMZmvW6FOV88QtlnjhzRZLodNs3SQbxyQ/TRgx8C2
	 2HomAR68ZYD8WGQ9AJYPMEsk0mXt3z7m3RdenETQEuSuqikj+XFHm6HRlK2rpEx1PQ
	 pMsA+4oNTegbudElSPcVquR9imcXScem9QTkNJorHm/fMxtdCoP4POCL4HxaY0WdsN
	 IYWAWzix2gtfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 02/16] xfs: fix xfs_bmap_add_extent_delay_real for partial conversions
Date: Thu,  1 May 2025 15:09:52 -0400
Message-Id: <20250501122544-91d3200aad8a5b10@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-3-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: d69bee6a35d3c5e4873b9e164dd1a9711351a97c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Christoph Hellwig<hch@lst.de>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 4bcef72d96b5)

Note: The patch differs from the upstream commit:
---
1:  d69bee6a35d3c ! 1:  2cb51f69d0955 xfs: fix xfs_bmap_add_extent_delay_real for partial conversions
    @@ Metadata
      ## Commit message ##
         xfs: fix xfs_bmap_add_extent_delay_real for partial conversions
     
    +    [ Upstream commit d69bee6a35d3c5e4873b9e164dd1a9711351a97c ]
    +
         xfs_bmap_add_extent_delay_real takes parts or all of a delalloc extent
         and converts them to a real extent.  It is written to deal with any
         potential overlap of the to be converted range with the delalloc extent,
    @@ Commit message
         Signed-off-by: Christoph Hellwig <hch@lst.de>
         Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_bmap.c ##
     @@ fs/xfs/libxfs/xfs_bmap.c: xfs_bmap_add_extent_delay_real(
    @@ fs/xfs/libxfs/xfs_bmap.c: xfs_bmap_add_extent_delay_real(
      	}
      
      	/* adjust for changes in reserved delayed indirect blocks */
    --	if (da_new < da_old) {
    -+	if (da_new < da_old)
    - 		xfs_add_fdblocks(mp, da_old - da_new);
    --	} else if (da_new > da_old) {
    --		ASSERT(state == 0);
    --		error = xfs_dec_fdblocks(mp, da_new - da_old, false);
    +-	if (da_new != da_old) {
    +-		ASSERT(state == 0 || da_new < da_old);
    ++	if (da_new != da_old)
    + 		error = xfs_mod_fdblocks(mp, (int64_t)(da_old - da_new),
    +-				false);
     -	}
    -+	else if (da_new > da_old)
    -+		error = xfs_dec_fdblocks(mp, da_new - da_old, true);
    ++				true);
      
      	xfs_bmap_check_leaf_extents(bma->cur, bma->ip, whichfork);
      done:
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

