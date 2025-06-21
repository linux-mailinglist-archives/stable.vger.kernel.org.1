Return-Path: <stable+bounces-155211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1EEAE2817
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1BB17C70A
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2211DB124;
	Sat, 21 Jun 2025 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o56cRECc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E006149C41
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495856; cv=none; b=jCgkeujQtVC5E3BJ7WWwep+VoaoVPRUuOvyiC6O8D14+7SDou7+eu/EM3JT/JBq4BrMipG0Mu4o5nBzRKBOBCvuFtfilNpR39BTn3BUEnVpXIiwyrr/z/pYrq36e5tvXuRG+I9CQj63UjE5fJTa5vC0K8EWdWs1bZ1jOt+ibcn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495856; c=relaxed/simple;
	bh=yGDS0GyEWBTstJkStqvepVX1yIH4VeCRjUhrCe06iEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKUXWn9sGtbPr0SkUr5M1zNNfvQjwpCqXyzMgxfV07OVa/1ZGWIq0dhqoJzDiw9kBmqXK0wK9rA/fvNidsZ5S6rxFKh+hqq+u4C8aOpNixeh7lqDUC+7BXHcq47a0V9J8YXEl/l8oSPJznnMuMeYYNqvXPxiEqGVSsU1UQebu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o56cRECc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A839C4CEEF;
	Sat, 21 Jun 2025 08:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495855;
	bh=yGDS0GyEWBTstJkStqvepVX1yIH4VeCRjUhrCe06iEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o56cRECcHX4tglIaM6YwT0E+iZdrH4wFdzspugDfI+XS4oWN9BEHMtIfSV0s4maZ2
	 A83Nx6e7xCBBSJtClcU42zelVOEP0+55Ssr2jgVDfG034qbjs3i6GBwdC9py5KlYt+
	 NpdNtJxR/2XqoWnF8bN5bpj+qQAwyRSIlkQ9KA7ytdXt0hGogsY8BBAoCoa3uxRSP9
	 3AsM5x3cCaxxulV7GPZaR+AZXcK4dFcY7MOQE93pOhvr4x5dCrMFMgeGT3XW4SYiA4
	 Ov0QfygtTVPESj90UMwNU/QgVfoAMdWkPwM5FlQtuSnkv/744ldD242K+qj4Axs9dc
	 hdgF26KffDxGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jetlan9@163.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] wifi: ath12k: Clear affinity hint before calling ath12k_pci_free_irq() in error path
Date: Sat, 21 Jun 2025 04:50:54 -0400
Message-Id: <20250621030711-c98c2cf533928cc2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250619112541.1641-1-jetlan9@163.com>
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

The upstream commit SHA1 provided is correct: b43b1e2c52db77c872bd60d30cdcc72c47df70c7

WARNING: Author mismatch between patch and upstream commit:
Backport author: jetlan9@163.com
Commit author: Manivannan Sadhasivam<manivannan.sadhasivam@linaro.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  b43b1e2c52db7 ! 1:  eea26e883e126 wifi: ath12k: Clear affinity hint before calling ath12k_pci_free_irq() in error path
    @@ Metadata
      ## Commit message ##
         wifi: ath12k: Clear affinity hint before calling ath12k_pci_free_irq() in error path
     
    +    [ Upstream commit b43b1e2c52db77c872bd60d30cdcc72c47df70c7 ]
    +
         If a shared IRQ is used by the driver due to platform limitation, then the
         IRQ affinity hint is set right after the allocation of IRQ vectors in
         ath12k_pci_msi_alloc(). This does no harm unless one of the functions
    @@ Commit message
         Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>
         Link: https://patch.msgid.link/20250225053447.16824-3-manivannan.sadhasivam@linaro.org
         Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
    +    Signed-off-by: Wenshan Lan <jetlan9@163.com>
     
      ## drivers/net/wireless/ath/ath12k/pci.c ##
     @@ drivers/net/wireless/ath/ath12k/pci.c: static int ath12k_pci_probe(struct pci_dev *pdev,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

