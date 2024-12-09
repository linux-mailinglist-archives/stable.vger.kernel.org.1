Return-Path: <stable+bounces-100213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BCC9E990F
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6774D282B56
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC61B4222;
	Mon,  9 Dec 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cidUCMiL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F49A15575F
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754951; cv=none; b=OKGY/bhYGJz9kBnp2G36bHayX7zlv4NbEgyeR6HBrRRxDu2Z1kjBrTDDGmVG+bB/DlU9RhotuR+9M172jSYOZ+niSgE7xGzy1w+QSOLB0VMV5Ypd2Hsa43HckMvBI2XURFOTDMR2Wa9S/64V3KRDP/rd482/dn+3Z+GOxtLMEas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754951; c=relaxed/simple;
	bh=c5v8IVgftKHWhGyY3gCTryoN174gWkhb4tbWnzgWF7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwriVjUIRmK09/YqkBxx7qBshK0W55cVwGclt6AFoP7eSDV4so+4hAOONqdGLYk8YnNsxEQhxGEOuMDz2PbGsvHRPUf3c7d1kQckbgXhERZGXvRgHkJSWc+BmUe7BQ/laO5+eumBjX3RFdhfJxyoUnepKfPsLf8u0O7/2WIhdXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cidUCMiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F85C4CED1;
	Mon,  9 Dec 2024 14:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754951;
	bh=c5v8IVgftKHWhGyY3gCTryoN174gWkhb4tbWnzgWF7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cidUCMiLYbgNEeYhb4co0FjxZvL/fKZS8l4lvce1Gk1dnhP3rX1C7o/rretyhpt/f
	 BdCBpYqOGTjpfH8LO0mWIswS1RgkuL5bmzRiM/zhHfF/0Mios+eGxeTU9hk/9mhPAM
	 Qih5hy6F01BH5eVuwe3XhK7YkHf7+Kgdj/h+uMy+bD7Kp/JvUV/Hx5TkQyWDVCctzV
	 UvGYYxKE/thzIOgktKS4ZZe0JcF2miM4r3uO8ZWIjz6Cq/DD5m6lS4aA0zN0ccNluY
	 20fa91NIs1ObHdZd/hpIwGIWuK6PryQwc5tGn5bNdh8djQkMa1meh0cA71qGq51mox
	 pkvohAJpGIzcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
Date: Mon,  9 Dec 2024 09:35:49 -0500
Message-ID: <20241209073831-26fd8c26fc9f7493@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209042647.3426260-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: bbcc1c83f343e580c3aa1f2a8593343bf7b55bba

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Kory Maincent <kory.maincent@bootlin.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d24fe6d5a1cf)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bbcc1c83f343e ! 1:  b768445d42818 dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
    @@ Metadata
      ## Commit message ##
         dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
     
    +    [ Upstream commit bbcc1c83f343e580c3aa1f2a8593343bf7b55bba ]
    +
         The Linked list element and pointer are not stored in the same memory as
         the eDMA controller register. If the doorbell register is toggled before
         the full write of the linked list a race condition error will occur.
    @@ Commit message
         Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
         Link: https://lore.kernel.org/r/20240129-b4-feature_hdma_mainline-v7-6-8e8c1acb7a46@bootlin.com
         Signed-off-by: Vinod Koul <vkoul@kernel.org>
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
     
      ## drivers/dma/dw-edma/dw-edma-v0-core.c ##
     @@ drivers/dma/dw-edma/dw-edma-v0-core.c: static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
    - 	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
    + 	#endif /* CONFIG_64BIT */
      }
      
     +static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
    @@ drivers/dma/dw-edma/dw-edma-v0-core.c: static void dw_edma_v0_core_write_chunk(s
     +	 * last MWr TLP is completed
     +	 */
     +	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
    -+		readl(chunk->ll_region.vaddr.io);
    ++		readl(chunk->ll_region.vaddr);
     +}
     +
    - static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
    + void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
      {
      	struct dw_edma_chan *chan = chunk->chan;
    -@@ drivers/dma/dw-edma/dw-edma-v0-core.c: static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
    +@@ drivers/dma/dw-edma/dw-edma-v0-core.c: void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
      		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
      			  upper_32_bits(chunk->ll_region.paddr));
      	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

