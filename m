Return-Path: <stable+bounces-144608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED94AB9F9F
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 17:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464E016CB3D
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 15:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741841A3178;
	Fri, 16 May 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUN1R4Fo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347B813C914
	for <stable@vger.kernel.org>; Fri, 16 May 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408384; cv=none; b=Ix6sGGPwggLcoAtC+/pRocourYeRVZGACpPEdDcwV844sZ+2LZHBizuJt5lKWEOD4WGNSjOLAzWtK0oZJTq+uEfpFnsnynWKTiyqTbj9Y3O5nSw7ItCIXwGac7xJueKCRKbdwaquaTIFZGJPT8w4Bk+VV3BmuqjRYmQTPs5uFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408384; c=relaxed/simple;
	bh=n/fFGAVbE6DsZRhdOOjzs+JDcajFV2wS5XmCryDLjMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsyfdbFFq3dmsyOf4glKNYKeFgEi2MF+ef4yxPy3heiVQrxU4u+0hKpK294hROmaOOhUynho+Q7Ve1O10lv+q2L8E9awdekhVLzXx4krHFBsagLGnExrufRFq8uJ/bdOX/EZUOOTC/WI0DJX6iAwkzV8rvfmpi0fBNQ2jjb3Sx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUN1R4Fo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20878C4CEE4;
	Fri, 16 May 2025 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747408383;
	bh=n/fFGAVbE6DsZRhdOOjzs+JDcajFV2wS5XmCryDLjMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUN1R4FocmkCYXcPcuNK76J0baC3CnsYo02sWsZobzcAtkhNklzKbAdlaFfZIJvJf
	 BYPUJlEs4+4Qb2RaCVkgwLf3IQMH60ooNw8jr6oQwEAZlSS1TNhW2N4fY1fEdlZiqf
	 3ba6zy74VuN31uMIgDOme8IQ6vG6yt0Oggn5mFTNFxJ3qjIAWTDh4xB+q7eOFFyP2V
	 cVZjgVFIZB2qSSVdXx5KlLZEotVoF2B2z2SiAAozyuZd1lYx81DFLYB3zNOQfWEZuz
	 2wFoy1yM+oG2YBa9r5m01dqwsGrC3lBG1XNrvxY4bUPyWLBDSZr4T+kfFwvNn8TX0C
	 +9TJBGd9KbK7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] userfaultfd: fix checks for huge PMDs
Date: Fri, 16 May 2025 11:13:01 -0400
Message-Id: <20250515090212-f1a222f4bb37f95f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250515060237.467793-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 71c186efc1b2cf1aeabfeff3b9bd5ac4c5ac14d8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Jann Horn<jannh@google.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 3c6b4bcf3784)

Note: The patch differs from the upstream commit:
---
1:  71c186efc1b2c ! 1:  5e68b6fcca197 userfaultfd: fix checks for huge PMDs
    @@ Metadata
      ## Commit message ##
         userfaultfd: fix checks for huge PMDs
     
    +    commit 71c186efc1b2cf1aeabfeff3b9bd5ac4c5ac14d8 upstream.
    +
         Patch series "userfaultfd: fix races around pmd_trans_huge() check", v2.
     
         The pmd_trans_huge() code in mfill_atomic() is wrong in three different
    @@ Commit message
         fix for bug 3), so that the first fix can be backported to kernels
         affected by bugs 1+2.
     
    -
         This patch (of 2):
     
         This fixes two issues.
    @@ Commit message
         Cc: Qi Zheng <zhengqi.arch@bytedance.com>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    [ According to backport note in git comment message, using pmd_read_atomic()
    +      instead of pmdp_get_lockless() in older kernels ]
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## mm/userfaultfd.c ##
    -@@ mm/userfaultfd.c: static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
    +@@ mm/userfaultfd.c: static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
      		}
      
    - 		dst_pmdval = pmdp_get_lockless(dst_pmd);
    + 		dst_pmdval = pmd_read_atomic(dst_pmd);
     -		/*
     -		 * If the dst_pmd is mapped as THP don't
     -		 * override it and just be strict.
    @@ mm/userfaultfd.c: static __always_inline ssize_t mfill_atomic(struct userfaultfd
      		}
     -		/* If an huge pmd materialized from under us fail */
     -		if (unlikely(pmd_trans_huge(*dst_pmd))) {
    -+		dst_pmdval = pmdp_get_lockless(dst_pmd);
    ++		dst_pmdval = pmd_read_atomic(dst_pmd);
     +		/*
     +		 * If the dst_pmd is THP don't override it and just be strict.
     +		 * (This includes the case where the PMD used to be THP and
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

