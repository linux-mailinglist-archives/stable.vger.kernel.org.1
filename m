Return-Path: <stable+bounces-100197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B249E98FB
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3D91887D87
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085851B042A;
	Mon,  9 Dec 2024 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUVVLDPu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB6123313D
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754917; cv=none; b=lpPc4DgnmNzPh4lSaRHaSEM8Haf/+RYHIXKvSR3RopwogkpxQkGNPST3YuPMDOHYCWeHdIoFn9Eo+XnRPMzvUVPZOyCALMRzBtgQWHv6H+NoinJjy8uPzAX2l/L04VsJmlfIV/+8yPFGpN1GkD4QhUn/FE/kkjhoYYssfepodug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754917; c=relaxed/simple;
	bh=W0poUoVCQO9Vk36OiKarGiuNQjvzCbzqXOoHpm3O67s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Db+NtQkealKLSQ1tnSmv3CvRo9vbIHkBbiJijCu1x4p/c4LggQxkdGC083RDHTIT0LWPVAfQ4Ttj5qhjOpuWKdaIiT+lK1j1ue/ZAPQ8cPWtUl0p7SF2n3qyD4qVTxTLfvawY6NDSw7VFtsIzYo9H5UtZDjjV2rZbEp3O0GvCTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUVVLDPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A38C4CEE2;
	Mon,  9 Dec 2024 14:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754917;
	bh=W0poUoVCQO9Vk36OiKarGiuNQjvzCbzqXOoHpm3O67s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUVVLDPuB2ayDJTFSzizy9Wn9pHs06zFKyyCSbsAfpqshzYDBSXzY5Zy45p6+tuW3
	 Oq92IOjpLOvyaVGwppy7GkZmMEytSDXbEJ6tCLF6y1cgZ9yo1HWwMrw8xptPx8GWr8
	 zFI2vWXc8gRM/GTXKh32x3GU4lf+ldL7skBg2eJiYQ9P0y6s7/CRK6D+H3kKlLIZZu
	 /5Xet0mYv3W+BU6MioPeSl9+T+dSNhVczz1N/lHMmaQeJ07sJx8O1zZySs1YqGdp/m
	 Gfb7PVtpGvYwUIAa6GGsHoqRXWt6YmkzXW8RKLJkTI/VJAkeScDC9LoVTVZdtaEy4T
	 WZRzjq7in1OuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy-ld Lu <andy-ld.lu@mediatek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] mmc: mtk-sd: Fix error handle of probe function
Date: Mon,  9 Dec 2024 09:35:15 -0500
Message-ID: <20241209073439-067e83314e344a66@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209064441.10793-1-andy-ld.lu@mediatek.com>
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

Found matching upstream commit: 291220451c775a054cedc4fab4578a1419eb6256


Status in newer kernel trees:
6.12.y | Present (different SHA1: 4600bcb7eff1)
6.6.y | Present (different SHA1: 61788dcf2b34)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  291220451c775 ! 1:  c689d1cab4b70 mmc: mtk-sd: Fix error handle of probe function
    @@ Commit message
         make sure the clocks be disabled after probe failure.
     
         Fixes: ffaea6ebfe9c ("mmc: mtk-sd: Use readl_poll_timeout instead of open-coded polling")
    -    Fixes: 7a2fa8eed936 ("mmc: mtk-sd: use devm_mmc_alloc_host")
         Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
         Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
         Cc: stable@vger.kernel.org
         Message-ID: <20241107121215.5201-1-andy-ld.lu@mediatek.com>
         Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
    +    (cherry picked from commit 291220451c775a054cedc4fab4578a1419eb6256)
     
      ## drivers/mmc/host/mtk-sd.c ##
     @@ drivers/mmc/host/mtk-sd.c: static int msdc_drv_probe(struct platform_device *pdev)
    @@ drivers/mmc/host/mtk-sd.c: static int msdc_drv_probe(struct platform_device *pde
      					     GFP_KERNEL);
      		if (!host->cq_host) {
      			ret = -ENOMEM;
    --			goto release_mem;
    +-			goto host_free;
     +			goto release;
      		}
      		host->cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
    @@ drivers/mmc/host/mtk-sd.c: static int msdc_drv_probe(struct platform_device *pde
      		host->cq_host->ops = &msdc_cmdq_ops;
      		ret = cqhci_init(host->cq_host, mmc, true);
      		if (ret)
    --			goto release_mem;
    +-			goto host_free;
     +			goto release;
      		mmc->max_segs = 128;
      		/* cqhci 16bit length */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

