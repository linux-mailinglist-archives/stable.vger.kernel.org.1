Return-Path: <stable+bounces-132857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA7AA9062C
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA6F16EA0A
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3072F14F9D9;
	Wed, 16 Apr 2025 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlcmhQkl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EFF205AA3
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813030; cv=none; b=DsqhPgxCZ2UawkSH3nUxfarTIwmipcv6V22obi97VZLpuUHOoL5+ZHeK7tOqNMDz+RzknrdH/3Bga5rVkpF6Gbib/yFkqT8mYPaZfb0Fl00ewd+3GQdX1f0g4IkXVecFWpTs1iDzKXp3hFDaPvuSH3M6imZn80wY86AUMxihz5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813030; c=relaxed/simple;
	bh=CtATdprh0ZDro9ILwImBzbgBuG1ftAMnQ9igGBJOOYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TiaqlqYN0FpPojO5QWnJKDgzi/Y67C0pYXbEtBPWe7UBmmkIUnncD3K7Wv0JznYLrNmx02mmte8/BJqfJzniD4X5Y9PuTEPTAOGqkVQ2Cz7jLwll73fSUQGflmC+Ky/yCFrTPE2PVn0KxtfSbMtpSE8B/W07mo0OKZSXmenE/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlcmhQkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33209C4CEE2;
	Wed, 16 Apr 2025 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813029;
	bh=CtATdprh0ZDro9ILwImBzbgBuG1ftAMnQ9igGBJOOYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BlcmhQklO2ksYVN7jTrFCblgA0/haSJr3WL/8ZQJkJ8yimZsgL8hWQiE58/3zEQJh
	 10YWvowTxskpYlAKc2Cg2vgS0MAtjR5NbT2gc9sIzryuN5d1gD6sbGu1HLoRPQHxPk
	 AlW/wOGXaTYuja0twUeUHqIK0Hksjex/UbgSF4yE2Sigo+P1fQpWQvkBCydKy4N0i1
	 TRy6p/paWNLVnTM8eAN3szXcnQAmN+P1S+yhQQa5x0gQr0UesTmO2zIU4tz4q/Nnzi
	 luRe6VE5rGBAYBxAC2E6gegdt3SUODjNDMX7d/0/7yU42BNQuRDGNAYU0fP0SmR397
	 pPx1pA+02G7oA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhi Yang <Zhi.Yang@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] jfs: Fix shift-out-of-bounds in dbDiscardAG
Date: Wed, 16 Apr 2025 10:17:07 -0400
Message-Id: <20250416091747-0e7fe5347440a8ea@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416015106.1714709-1-Zhi.Yang@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 7063b80268e2593e58bee8a8d709c2f3ff93e2f2

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhi Yang<Zhi.Yang@eng.windriver.com>
Commit author: Pei Li<peili.dev@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: f650148b4394)
6.1.y | Present (different SHA1: bd04a149e3a2)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7063b80268e25 ! 1:  60ee929ac5c8b jfs: Fix shift-out-of-bounds in dbDiscardAG
    @@ Metadata
      ## Commit message ##
         jfs: Fix shift-out-of-bounds in dbDiscardAG
     
    +    commit 7063b80268e2593e58bee8a8d709c2f3ff93e2f2 upstream.
    +
         When searching for the next smaller log2 block, BLKSTOL2() returned 0,
         causing shift exponent -1 to be negative.
     
    @@ Commit message
         Closes: https://syzkaller.appspot.com/bug?extid=61be3359d2ee3467e7e4
         Signed-off-by: Pei Li <peili.dev@gmail.com>
         Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
    +    Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## fs/jfs/jfs_dmap.c ##
     @@ fs/jfs/jfs_dmap.c: s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

