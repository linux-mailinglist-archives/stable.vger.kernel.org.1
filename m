Return-Path: <stable+bounces-139385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCBEAA6397
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E523B5B6F
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E242253EB;
	Thu,  1 May 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE8QDDD4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DE6224AEF
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126716; cv=none; b=bIcuITuJGddPkHzWk1HbjBCbVfMud33ZjqEzr6Ycw1xkEVnGamCPt0AIayr1KkbtL/9NtSc1eg0LIhN/Bf+0VsoXWJUfqYIS8vLeOfutvXUONI58txRM+X3IjTDjiXZ4xuLrqtNnz7AQYTWldurQsuCcYWs/2jiVObFBfXl8B+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126716; c=relaxed/simple;
	bh=m9xHXkx3cbrHQSLprIG1pXqq3XuK4+M7vZ9dhk748hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQ5YLVbedBIQ9NKHUGFQgnrBan/6a+A8ZVxuYCifru6wabPleXdouVL61ZgRhUjkT5XyrkefrvEufFjvu4I5U0i30icXVlqV76wXi3A0ppJ3A13xYaBPDRYM72vYcmhZ+GVzj8ly8wLR4ZaHuB+7GoS5EFnz7VuLmf/H+yqvC6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE8QDDD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB492C4CEED;
	Thu,  1 May 2025 19:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126716;
	bh=m9xHXkx3cbrHQSLprIG1pXqq3XuK4+M7vZ9dhk748hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KE8QDDD4HYwsCpmIRkNeJB8mcx6OKTWjnrngwfAYwKeKVmE0ZAGu1UKIpdmNdWunv
	 1jU2dtY7//b1VnCAv9Wr56pyjRiLUFzH1L7UFlZkkNd5H+6XVwBu4PD1x36Q2gcj4O
	 RbLPkuEpKVyho0l4M86Bhx0sdRbIu5KYNmHsNd91Jwr8yGaU+ip2KxrZrJ03Z/4laq
	 gIFfzQwQtkj9CaSmFn60MgkIbC30v8VmiNfsd67l4zB7Qn9BFgeTdCRAasP65rVrTF
	 U2SYKlTwvAwDNn463j006zJg1bPP0xK+aeXdXn6/e3kYXa52WUyh3Zf1cC8qg7GhRC
	 kyy+znKlh6Fag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 09/16] xfs: make the seq argument to xfs_bmapi_convert_delalloc() optional
Date: Thu,  1 May 2025 15:11:52 -0400
Message-Id: <20250501125312-0845a4c8f3700f06@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-10-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: fc8d0ba0ff5fe4700fa02008b7751ec6b84b7677

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Zhang Yi<yi.zhang@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 0f726c17dfd8)

Note: The patch differs from the upstream commit:
---
1:  fc8d0ba0ff5fe ! 1:  66fa71c76709d xfs: make the seq argument to xfs_bmapi_convert_delalloc() optional
    @@ Metadata
      ## Commit message ##
         xfs: make the seq argument to xfs_bmapi_convert_delalloc() optional
     
    +    [ Upstream commit fc8d0ba0ff5fe4700fa02008b7751ec6b84b7677 ]
    +
         Allow callers to pass a NULLL seq argument if they don't care about
         the fork sequence number.
     
    @@ Commit message
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_bmap.c ##
     @@ fs/xfs/libxfs/xfs_bmap.c: xfs_bmapi_convert_delalloc(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

