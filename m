Return-Path: <stable+bounces-159183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C048AF08D7
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 05:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021954A6344
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 03:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397B9190498;
	Wed,  2 Jul 2025 03:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYKvmr7k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7523B0
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425373; cv=none; b=L7mUj2doQPkvQc1lpdatZj1VqHg4+1Vxzasm08tJ9op1Q851WO14LttsktiedjeffXeRphuZFMQ8Y78ykHcMT29vtZ1Uh/QdAI2wkC7xkV7A4IUDTvH6+TxPlhHXrSnMNhKHpZoGR3cy9JQj8cuxZ8jvxeGKdUqzh2qe4L1AuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425373; c=relaxed/simple;
	bh=Y7HnDDEYqdl6u/10OXsBmxK4DlEtf+PsuKWCZhuSlmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYwMOswuO23+IFpryqZ2WQLtXjfjB1BPQVguXUlKYF36Uqmv/tM0O0TxFZjIxFKXGtubaziTej1gVYRYicIWe8umg9rLnFfkEl+QVtCahKoFjgYH239GOm53RXFqC5gMsuoRs8NZrAbpbOZT7flHfmKDj5L0DdMHkqUVXmBhwic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYKvmr7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD47C4CEEB;
	Wed,  2 Jul 2025 03:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425372;
	bh=Y7HnDDEYqdl6u/10OXsBmxK4DlEtf+PsuKWCZhuSlmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYKvmr7kyZdBFRnqcI/pHToUSacEd4P9Rxv+WvXYaJcv68NYkETL+6GxIYDtZpXIY
	 9NNskkP8rhBg6Ok0CHrW8OA8mqV5qjsJuZX3p/tkWRVc6bByj3EV7dj36bLfYTqh/Q
	 6OBmcsuH7Gv/UZs05fJ2fsgn1DodhrHwajtmnuxIx/2Rrgqpl0moMWs9p5BqKa1trx
	 IO4xSXuYA0YVx0RXBLeLkCEhOUnYk9ZbJV/TbYk0XHyR9qURZEkjls4odXtlDhvrxl
	 RGw3EQg4FtjgSQQeKvSIUrtS933BnTAjfWHCEoA8mFZ9KBOcm2AuTy7VFeB7Sxq2gD
	 CpdM6beZfrAlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dev Jain <dev.jain@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] arm64: Restrict pagetable teardown to avoid false warning
Date: Tue,  1 Jul 2025 23:02:50 -0400
Message-Id: <20250701212753-5002117578b1f84e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250701042705.22120-1-dev.jain@arm.com>
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

The upstream commit SHA1 provided is correct: 650768c512faba8070bf4cfbb28c95eb5cd203f3

Status in newer kernel trees:
6.15.y | Present (different SHA1: 1d03bbcb2b98)
6.12.y | Present (different SHA1: 47f34289d100)
6.6.y | Present (different SHA1: 6562806f3200)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  650768c512fab ! 1:  fe24ec1815e3d arm64: Restrict pagetable teardown to avoid false warning
    @@ Metadata
      ## Commit message ##
         arm64: Restrict pagetable teardown to avoid false warning
     
    +    [Commit 650768c512faba8070bf4cfbb28c95eb5cd203f3 upstream]
    +
         Commit 9c006972c3fe ("arm64: mmu: drop pXd_present() checks from
         pXd_free_pYd_table()") removes the pxd_present() checks because the
         caller checks pxd_present(). But, in case of vmap_try_huge_pud(), the
    @@ Commit message
         Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
         Link: https://lore.kernel.org/r/20250527082633.61073-1-dev.jain@arm.com
         Signed-off-by: Will Deacon <will@kernel.org>
    +    (cherry picked from commit 650768c512faba8070bf4cfbb28c95eb5cd203f3)
    +    (use READ_ONCE since pmdp_get() is not defined)
     
      ## arch/arm64/mm/mmu.c ##
     @@ arch/arm64/mm/mmu.c: int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
    @@ arch/arm64/mm/mmu.c: int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
      	end = addr + PUD_SIZE;
      	do {
     -		pmd_free_pte_page(pmdp, next);
    -+		if (pmd_present(pmdp_get(pmdp)))
    ++		if (pmd_present(READ_ONCE(*pmdp)))
     +			pmd_free_pte_page(pmdp, next);
      	} while (pmdp++, next += PMD_SIZE, next != end);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

