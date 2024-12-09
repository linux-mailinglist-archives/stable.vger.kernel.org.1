Return-Path: <stable+bounces-100205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4BB9E9908
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2583A282FD0
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584C41B0427;
	Mon,  9 Dec 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldAwq71h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684F1B041F
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754935; cv=none; b=tpBLO3P1xZYpQqhvLFG6WK3BCZ765kAYtwnWNzNWTiIKS8j4X7aO/xfVZIi0918/CqFYU1iP+LUqmnq4L50AGPK56yTXXIFxH3J8K6c5k13xkZ5mtyZx8W9esWcN5DKzv73/Zn8iHtv747Zqs20B3O2cdsHtChMnmwPzLOSHjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754935; c=relaxed/simple;
	bh=/znCKou4M3b3JDxu6KJRJ9Sc/Hgn1gHqEMQgtxX3CbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNk+7+ZYsMGv21GQxeMsG5n85Jy5NbSkytEBC9dyMWWt4V1P+Dp4C1m7mvHBIC+AECnFXrfDYGHF1vNeE6Hne3w7rjNTNzhUeAFjTf+YqIu4HPt/rNtb9Mj6OUPI9d54PWl5K5NeMGgGbUO5YZDlSx5HjXB7hi5wmdDFbVY8/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldAwq71h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C24C4CED1;
	Mon,  9 Dec 2024 14:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754934;
	bh=/znCKou4M3b3JDxu6KJRJ9Sc/Hgn1gHqEMQgtxX3CbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ldAwq71hvFv0HTRjEt2KjSxAbSNpfHd53mnYuFZD2rG/k5R6EVsQBK58GrmfknHk9
	 rkxWQEZjblJ/AhaJdIODTGHrmFxvjrdLSonrasOYpaQnUpuP9PBr1gUxPIEN5HP4tY
	 XByp/VjeMzKqkn0cCXbOpHeCo3dd7EMaJXtV4tw05RT4crYz6rUGRl9hl3y3LqC87a
	 BCz4HdQgvmazj8Cgua4vV8wbajFXzYCsZDDUzKKbdwNYZoo436/+vSblTfSs7t2SCk
	 52R9od8gsfUwkdCmqF2md+SqRZIUBllaXvuEy+a83lgUN10NS24ObQanoW2EtkDERz
	 ZUoxm5YzfPqcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy-ld Lu <andy-ld.lu@mediatek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] mmc: mtk-sd: Fix error handle of probe function
Date: Mon,  9 Dec 2024 09:35:32 -0500
Message-ID: <20241209083259-71d177fe08992f4c@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209032446.7404-1-andy-ld.lu@mediatek.com>
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

Note: The patch differs from the upstream commit:
---
1:  291220451c775 ! 1:  a5165d693153c mmc: mtk-sd: Fix error handle of probe function
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
| stable/linux-6.1.y        |  Success    |  Success   |

