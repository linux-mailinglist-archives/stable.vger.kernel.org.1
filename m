Return-Path: <stable+bounces-124493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80374A62157
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A44C19C5C34
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833D01C6FE4;
	Fri, 14 Mar 2025 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNvqVBh3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4251515D5C4
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993839; cv=none; b=rGE0Q7RCBewcdyjSTV2njjPU188sVuhunhvsYaRDcDkiDD6Kjivhv43w4NTGXYae/7ht5HJz1tIQvJfPrqLIYU1b5ui2UZmHDOi5uVhVOvoXO/nKylIg53mE2mKGSJTaCl2hNEiSZ+wJjQE876/CSz+StdrHh6zUTUPGVLiof6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993839; c=relaxed/simple;
	bh=wR+T4YD+bvNG4I7Ug8lUl5PalYNIF3+1mLtuZPZV0vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2WTyUQOB1dAgyuMkA8U7iDfk+/TKmIhDbYHQ/gL1u/7TR5DeF3I05kE3EOVkottSVTPb2x6aSVH/I76IebgChaXqdhMwJAOFw29ZSzA6D4bCSz87Cju7No9eb7oCm2sAMKX/aTvljQLHJe+0rG7a81svyaoKs0q33KZ/Cp0lUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNvqVBh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFEBC4CEE3;
	Fri, 14 Mar 2025 23:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993839;
	bh=wR+T4YD+bvNG4I7Ug8lUl5PalYNIF3+1mLtuZPZV0vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VNvqVBh30h2xeavsWaj+q79VMAV2rl1R6FfwHzU5YzJ/vUPYl6LLNV08a2GfcATJS
	 46i6+MJWe61AoNQ0vvDHdRZT/7yLNgACRbKNJte91LbOZdGDAlxZNyf06fksuua1jc
	 8RdS1BwU4WpXH1QCPdEnddGlllldh4xMXWUi61hcyVS5XTYn4Xk/wQ515zloHgg3XF
	 eujDu7NVkR9Pp36hbLjord0ub6etBHISErkZrlQCV7EbZ3kbrhbI3ZHUfiv5JyJPYb
	 7Bzzuo4rJq+9KbMdQCHsk3W04rsjSIx00VoaP8ySrn0TkijEN8Zts3JtXwnfH8/Q40
	 9KyvQ1HHZuALA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 05/29] xfs: pass per-ag references to xfs_free_extent
Date: Fri, 14 Mar 2025 19:10:37 -0400
Message-Id: <20250314113436-e76a211948bfdcc0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250313202550.2257219-6-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: b2ccab3199aa7cea9154d80ea2585312c5f6eba0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  b2ccab3199aa7 ! 1:  ab2da2d8a4063 xfs: pass per-ag references to xfs_free_extent
    @@ Metadata
      ## Commit message ##
         xfs: pass per-ag references to xfs_free_extent
     
    +    [ Upstream commit b2ccab3199aa7cea9154d80ea2585312c5f6eba0 ]
    +
         Pass a reference to the per-AG structure to xfs_free_extent.  Most
         callers already have one, so we can eliminate unnecessary lookups.  The
         one exception to this is the EFI code, which the next patch will fix.
     
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Dave Chinner <dchinner@redhat.com>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_ag.c ##
     @@ fs/xfs/libxfs/xfs_ag.c: xfs_ag_extend_space(
    @@ fs/xfs/libxfs/xfs_alloc.c: __xfs_free_extent(
      
     
      ## fs/xfs/libxfs/xfs_alloc.h ##
    -@@ fs/xfs/libxfs/xfs_alloc.h: int xfs_alloc_vextent_first_ag(struct xfs_alloc_arg *args,
    +@@ fs/xfs/libxfs/xfs_alloc.h: xfs_alloc_vextent(
      int				/* error */
      __xfs_free_extent(
      	struct xfs_trans	*tp,	/* transaction pointer */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

