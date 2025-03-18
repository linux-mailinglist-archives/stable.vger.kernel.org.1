Return-Path: <stable+bounces-124820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97918A6775F
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E70A3B9061
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C3520E702;
	Tue, 18 Mar 2025 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H91Ep2PL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0151E20E6EE
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310771; cv=none; b=VK5tW69//wQ6eZBqamdqPYwRO6lLH4B3BunBinioRBCR/e7VAXVu8JLPdOnU8FqY8OA3kpfzH5EebVGwIyOuGpRzgMszN02+d4U8CiXVxgBzwOOy8c/OC+pEiBc8spuJr98u+uSokW4wt2Xbjpwkpy/+Mf4ys9GLKM4Z/+13xj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310771; c=relaxed/simple;
	bh=Ec2ylzMS0vOHKbkAbiXplj0D5k6hQIhtcvjl8GYj65k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeRhFYCF70rExW558mUTfqxD4G58N+0tBYK4Gji/KGcM6DmQrCcQ+cOqIi5/aGM+4Q8fcHngqWQ3bg62yAZp4fel5tyh1U7zkhiLKdPX10/PSX9EARNAn9Xtkc5awkP+qg55A4K4fuQb3tOw2IMM5X2YIUXPDgRGl/ManBdXpW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H91Ep2PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B069C4CEDD;
	Tue, 18 Mar 2025 15:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310770;
	bh=Ec2ylzMS0vOHKbkAbiXplj0D5k6hQIhtcvjl8GYj65k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H91Ep2PL0gC7bd7laswtVkhJe4Xjy1Gv/ArB5KvNJ6hUYfL+7LlcQRniG4HYuacJo
	 Awp6cIUdIXtbYES/8WVimvjhSGCf+HkoxdwwZzL+npFsfp2ewKhVWc3kuOGpw81wcB
	 8fGzM125u3A0y2n7BnCtpSbYJrV1mfnnXyHFyerpDACtplPGczSG1WQqZwTCmRppwl
	 Mdl5N5kv1mLJGCUL2FfJR+GeoH58modVeKCUIgq2ph940hRk189e8Bo2yuJutwt/L5
	 6SaqVbayZ44lXjzFxIsVaMYDgBIo4XHD73Sh+kWsO31fRkmwd1//bGvpB6zwBED3Uj
	 RamYhtKXjpMVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kamal Dasu <kamal.dasu@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.4] mmc: cqhci: Fix checking of CQHCI_HALT state
Date: Tue, 18 Mar 2025 11:12:48 -0400
Message-Id: <20250317205909-5917d677600d7181@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317220306.44646-1-kamal.dasu@broadcom.com>
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

The upstream commit SHA1 provided is correct: aea62c744a9ae2a8247c54ec42138405216414da

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kamal Dasu<kamal.dasu@broadcom.com>
Commit author: Seunghwan Baek<sh8267.baek@samsung.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: a7fa220ebb41)
6.1.y | Present (different SHA1: ae7b2bd3d458)
5.15.y | Present (different SHA1: c0f43b1f1f7d)
5.10.y | Present (different SHA1: c6bd80f58522)

Note: The patch differs from the upstream commit:
---
1:  aea62c744a9ae ! 1:  e62d1070a5f40 mmc: cqhci: Fix checking of CQHCI_HALT state
    @@ Metadata
      ## Commit message ##
         mmc: cqhci: Fix checking of CQHCI_HALT state
     
    +    commit aea62c744a9ae2a8247c54ec42138405216414da upstream
    +
         To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
         bit. At this time, we need to check with &, not &&.
     
    @@ Commit message
         Acked-by: Adrian Hunter <adrian.hunter@intel.com>
         Link: https://lore.kernel.org/r/20240829061823.3718-2-sh8267.baek@samsung.com
         Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
    +    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
     
    - ## drivers/mmc/host/cqhci-core.c ##
    -@@ drivers/mmc/host/cqhci-core.c: static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
    + ## drivers/mmc/host/cqhci.c ##
    +@@ drivers/mmc/host/cqhci.c: static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
      		cqhci_writel(cq_host, 0, CQHCI_CTL);
      		mmc->cqe_on = true;
      		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

