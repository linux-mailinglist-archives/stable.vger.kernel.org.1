Return-Path: <stable+bounces-159187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF3EAF08DC
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 05:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF32F169B62
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 03:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E505F1C2437;
	Wed,  2 Jul 2025 03:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agnfHZLh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66C11A3161
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 03:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425383; cv=none; b=l2nQL8GtBTRuaSwoel7FQ0nHkB3iN/g64q/sCFbzs5KPLyHYox7mU/jKhH/Z+tc3TvfbbWZuy7kU5xTs/f1Rug+oWP45ZJLgY2/iVo5mKwNsLH1VLLPehxTgtI3M58FJ4Zg9vlD5JI69oDmEe/XpDXuFp+0uYq+mWrGmUpNY6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425383; c=relaxed/simple;
	bh=HCXHwQCP+iGe0dutpp8oSG98TRuQbr8zi06Wy8rNNlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRLH5yLHb+6zdEyQsDmBv7uZ+ctsYyoNSM1ktH/Ya3yQLDE3lLfDHstMEPhtasc1/e/DF8W+6nJAxoG+n/0hA/QrXt2I5KM6hIs16eNm84LZ3tUM1mgyvv1+YkYfRy6ZDELb5fNqlto8CEGNzCFCpQOMpU+UE10twriHh8w86Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agnfHZLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A98C4CEEF;
	Wed,  2 Jul 2025 03:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425383;
	bh=HCXHwQCP+iGe0dutpp8oSG98TRuQbr8zi06Wy8rNNlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=agnfHZLhCF1a3MBkCl139vlsqQtmnwMz5zyf+kq/+KovjEPNPIg57Cgh50TlsKR+1
	 EVY/Cy/yUKrfJjw77B2WuYnr9YHTlYcWpXgu4tauz0jVfV9LEQdv+yw8Tjp+th/U7B
	 bE5l/oAnJu3gfe91kzN84u6PpMN+feBsi5/bSxBbyVyJKeO5aDamDHnTyYERfG2Oxw
	 hs1c0uNhXrMLFvI6IyQfPgdL0l54OCvbIpWHJD8VKnr9OBYvvA3l/xROgHIRPS+nUx
	 mKyEe2NMZ3hlCLQ1ZEIuf+rkJoC6Mn2XMpdjoWhnkroTx5K0WsWKfYnKRNPtuPqD3k
	 JdE5poKtRKMHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dev Jain <dev.jain@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] arm64: Restrict pagetable teardown to avoid false warning
Date: Tue,  1 Jul 2025 23:03:01 -0400
Message-Id: <20250701213741-03b4a218ef738e79@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250701041822.21892-1-dev.jain@arm.com>
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
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  650768c512fab ! 1:  f902bc53cad9e arm64: Restrict pagetable teardown to avoid false warning
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
    +    (use READ_ONCE since pmdp_get() not defined)
     
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
| stable/linux-5.4.y        |  Success    |  Success   |

