Return-Path: <stable+bounces-132867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 549F6A90672
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C351897C13
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1441FBC92;
	Wed, 16 Apr 2025 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhCQtLcf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27EC1F9F7C
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813698; cv=none; b=L5VhgjlD8qRhKlSNJ238enwuqTup5bPLc62+wi+fC2zNkSK5h8zOYgvSFv+7RDNXKC5J3I9x9VrlSMrIrWV8Ix5IcrR9UTD9tGrUrA3Y7da90OvM6lkH9Uni5A/hDlflhGIy6tpZfEjPPS0QHY/1+l7Dk2M1Okqmv6sXVhOmPK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813698; c=relaxed/simple;
	bh=V+h9Tr+OWaI2rlHx4MSBvb3GHm7MPa+CCXU8/k1kgKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSF95Wwonmt4pFS6MgPyjKSDK+z+HaVNW9wie093gcvrm+3skgQe/CpfN2MuQXNEe+5IeSIpF518i8Qb+ckEKe83bp8fLnqHjNtWVXn9Ygiv/V5Gbv7i9eaKItDhoKQe7N+S74ZeyHZzOff469m5XKbk02/4SER9+b4oLv3oZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhCQtLcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B84C4CEEC;
	Wed, 16 Apr 2025 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813696;
	bh=V+h9Tr+OWaI2rlHx4MSBvb3GHm7MPa+CCXU8/k1kgKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KhCQtLcfTi3XfpF9gPvrm/HZ6KXLUldrbB6gPaXp3F+1b507+xn3X9Bpuiw+TOIyu
	 cra6UaBq1r2ej7roufH7PfWsdfma+Rw7bW6AvvA6gWEaOvJ9h9HpIk0MGUaRd/62c5
	 qPD7aczsm9GDQq1t6ZJaSZpPAnzRDk7cngVAwkZZGzneQx5/kelSOkIK2sTvOBUPS3
	 Of44SSRw7ItanP9JRYhSqCziyGqHGQh6lJa0Gtga/jyJFD+20CnskcAZ4jey6Ev+jO
	 N23pK9xcifPmvt1VFRRm9vn6Ds5/P0/jzSCkCaPGDf++qCLPxZtWPqHH8vggUDn1yo
	 IZ8zDGYpqGJaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhi Yang <Zhi.Yang@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] jfs: Fix shift-out-of-bounds in dbDiscardAG
Date: Wed, 16 Apr 2025 10:28:14 -0400
Message-Id: <20250416091411-765bbace521087f3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416014938.1713735-1-Zhi.Yang@eng.windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  7063b80268e25 ! 1:  d8916f054bb95 jfs: Fix shift-out-of-bounds in dbDiscardAG
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
| stable/linux-5.15.y       |  Success    |  Success   |

