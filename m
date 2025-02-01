Return-Path: <stable+bounces-111936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8CCA24C44
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559191885187
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8855F1CD1EA;
	Sat,  1 Feb 2025 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKA6Gs/h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D81C5F34
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454052; cv=none; b=KHayCZlPshXN8DJCsI9N6ETOYJQs54IRG2kZQum5ElIXz7UOZeHoX/kniQnDKi5r8/MAQquAK+2vVXm/kGk2TenR6nCiWKUw8CgkeSxZA2zGdKgoU4X+9QNAEzeovVgO5Pv87IgQoICGazEOfYAU18PJie/4m1RMHjKVacL4P58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454052; c=relaxed/simple;
	bh=XyKXPgvm83wB7T/w1AK6bi2vhvqY2z9xrNvw5dG03h0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tjDyI20g+R+RVhtWogbxvNQdn7NKWe+6DXA0SoFyRnQRAlGlA5G7Zp3oPTXHK5oyrR4kLeQIJhB+a7H5uGv4D+Bqh16PgAPoeAJdHw0vrMW9o5FZ70HXSQ9emMuXZxsRu1qLmoXd/ScO3tQ52FUL0Ic+rLJAIzgx7xiziGe41xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKA6Gs/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF678C4CED3;
	Sat,  1 Feb 2025 23:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454052;
	bh=XyKXPgvm83wB7T/w1AK6bi2vhvqY2z9xrNvw5dG03h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKA6Gs/hvxcsHf8H0p+gUwnvjPPC+BNQ3o6dudZ7SzsJFLHg5nLRXvBIs+TEJlUpl
	 iKsvBPvhwG0SLqvKkjagUpD+ekWPsfm35/j3jHKrjTt/tFUxhyNXB1ZxSXzcdi6Zb4
	 Wj3UBjH2aCxD0PFEVMJubF5e5ZiEOUvvESK6JAZ5ug/soQJFs8Sqw0DICqf8eBFJrr
	 baKsbw0MIUCgvCB6fwJbM4YLkBCMM9nZyMYE+CqsREEUbdCH1Qsw0RNljAKKPg6wkn
	 lZTTinfqyZWLr5PervChKn4qsRRPMC37kDixyBmxlWclvWe4cXcf3thz0HlM9mvmM6
	 JawQNDEWbE2sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 01/19] xfs: bump max fsgeom struct version
Date: Sat,  1 Feb 2025 18:54:10 -0500
Message-Id: <20250201130853-5313903764dcd6bf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-2-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 9488062805943c2d63350d3ef9e4dc093799789a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 195f22386e19)
6.1.y | Present (different SHA1: 593486dfe122)

Note: The patch differs from the upstream commit:
---
1:  9488062805943 ! 1:  ba4444929ed01 xfs: bump max fsgeom struct version
    @@ Metadata
      ## Commit message ##
         xfs: bump max fsgeom struct version
     
    +    [ Upstream commit 9488062805943c2d63350d3ef9e4dc093799789a ]
    +
         The latest version of the fs geometry structure is v5.  Bump this
         constant so that xfs_db and mkfs calls to libxfs_fs_geometry will fill
         out all the fields.
    @@ Commit message
     
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/libxfs/xfs_sb.h ##
     @@ fs/xfs/libxfs/xfs_sb.h: extern uint64_t	xfs_sb_version_to_features(struct xfs_sb *sbp);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

