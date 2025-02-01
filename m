Return-Path: <stable+bounces-111934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D94A24C42
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03DC1885196
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C11155393;
	Sat,  1 Feb 2025 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0udw2MK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4A126F1E
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454048; cv=none; b=lDF/98rQWJL2RI80olmLTavB1JC2dRs4IeQ+pW/ahssdCtcVF0hplf9WGVjoPjW0iRVOVoWJe+eBUYlkSMZFH1Y9qm0yJCklVezuQLMRjr0Q0acBFxN3hjRi8rh57yoUhF3iMGuQ0i1W4p7iXVT/5zG40aE4oXGBjD5oK8Umkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454048; c=relaxed/simple;
	bh=7YM/eyDEdTgXM3X4iL2AOxcbB7PXfk+C9yqkF5ODm98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ugPj4DXYg5teP0YsPF3zL7WsPmkDGEIIuq6jESe5ax48Dibxuxy+uIsK7+tCwvqEKGY6gHhbxkNNeeOcoFF/cjtK51wok3MMtjShJMrSkAAEHF/XV9rkh/O8aRLqb6g0/XNDAR2I8c5NvMAn+diopMY16dG8+e2mErlHi6aznFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0udw2MK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EE4C4CED3;
	Sat,  1 Feb 2025 23:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454048;
	bh=7YM/eyDEdTgXM3X4iL2AOxcbB7PXfk+C9yqkF5ODm98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0udw2MK9mdrfcTkZXmc2g8iWvneKQbhoRd8sgFilrhTlhIRUGTaxv/IvP2RMy27l
	 f+XWiaB07chTTXd5x/CSGMXHeg4a9AjBgFP2AMb3otazniXAQiYoDitBXpr9znNbL3
	 H00YzJHmWM8JE5lXhZibjIzzwPRsapST9s7PyzKcGMx0mcWn9up2Qz8Io+9LopQsjC
	 WCq8MdkOFlBHt5KvjmNRh4MO+WBmd7Xvf7mag8BzpNSrUY8gG8KxYV/UYQVxjIjltt
	 TJ1hj9XE/xbGN5x+H6uJSeoEcNXTQlrmhquNdCisT4zs+BbIACTBTCEIiJDnewTCJe
	 LzVv31hDg+Zag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 06/19] xfs: make sure maxlen is still congruent with prod when rounding down
Date: Sat,  1 Feb 2025 18:54:06 -0500
Message-Id: <20250201134309-f4de91ffc3776e9e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-7-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: f6a2dae2a1f52ea23f649c02615d073beba4cc35

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 0fbbfe5fbfbe)
6.1.y | Present (different SHA1: 5d1a85efae8f)

Note: The patch differs from the upstream commit:
---
1:  f6a2dae2a1f52 ! 1:  ce863045e9922 xfs: make sure maxlen is still congruent with prod when rounding down
    @@ Metadata
      ## Commit message ##
         xfs: make sure maxlen is still congruent with prod when rounding down
     
    +    [ Upstream commit f6a2dae2a1f52ea23f649c02615d073beba4cc35 ]
    +
         In commit 2a6ca4baed62, we tried to fix an overflow problem in the
         realtime allocator that was caused by an overly large maxlen value
         causing xfs_rtcheck_range to run off the end of the realtime bitmap.
    @@ Commit message
         Fixes: 2a6ca4baed62 ("xfs: make sure the rt allocator doesn't run off the end")
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/xfs_rtalloc.c ##
     @@ fs/xfs/xfs_rtalloc.c: xfs_rtallocate_range(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

