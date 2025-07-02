Return-Path: <stable+bounces-159185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCB9AF08D9
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 05:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227213BFE48
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 03:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D9C72610;
	Wed,  2 Jul 2025 03:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgY1CoK3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108E623B0
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 03:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425377; cv=none; b=BwO562aRvvurw0L1GCOonsKezAznfCzRWfS/26I0SvCtYfpy+X3qnjhxO2DR+o2UOhDuSVUnICLsf04NFD4AMkF4FICuB3T/7EMyme/U2qlaktb6nB3TiqXnZbG7N09B6MBR4Ngcj8nlu4HZgt+6BQnjDFl4s3hU+A1txa3Zroo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425377; c=relaxed/simple;
	bh=yljTgUjKKXhehwNVVRF6Jd8aSKKUlJ7WJvF5+5KA7tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHRAvGvQS3orBW2IzMPE8xQN28y9kvW7FncZ3hupOr9P1K78tvvwbogun51+KLbkwHG5MGBLAwVVx0ZamrvRTrAZ+wzvRorilAo/PKqVKyCCLR7M7KubirHMtr00h9jcfUDs00blT9jzlHfo/sS8ZXJN+3WPKoTwAjl+vpYBOMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgY1CoK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CF0C4CEEB;
	Wed,  2 Jul 2025 03:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425376;
	bh=yljTgUjKKXhehwNVVRF6Jd8aSKKUlJ7WJvF5+5KA7tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgY1CoK3m6a00kp83G8SQHd3LDrDZ/tKHqQ1+aqeGrl7StWdsQXMnC+M3iILiSFPG
	 5IGhyoyqJ2iu2JNLhiACc3pV5solcoo1wFmdTu+hPJ5ho+bDGWtUe/Zl6fHcv8RpTW
	 6NDHzyMFr/ng8Y8QIXS5M/LBD5ShGUKrao59q+rV0e4LDWfRdqBpQRf8rj97Xiai4v
	 G7pSAShR+M6OoDeDcbzZD7lOAxvfAcdsTZqypiZCKbgVGKhDICylx7slsD16zGhy+d
	 fMJO2t33Xpehd/jIU5Zh3P1tIfZ4k0oP3+SmEYUPIK/vrv6jSqLQUziR19M7ULGhL+
	 ufB/6BwA/7S0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dev Jain <dev.jain@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] arm64: Restrict pagetable teardown to avoid false warning
Date: Tue,  1 Jul 2025 23:02:54 -0400
Message-Id: <20250701221430-79fa4cdf16c4cef4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250701040814.21786-1-dev.jain@arm.com>
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
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  650768c512fab ! 1:  839d9f63f34c0 arm64: Restrict pagetable teardown to avoid false warning
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
    +    (use READ_ONCE() since pmdp_get() is not defined)
     
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
| stable/linux-5.10.y       |  Success    |  Success   |

