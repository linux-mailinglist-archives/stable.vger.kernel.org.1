Return-Path: <stable+bounces-100650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5A09ED1DB
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21727166661
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A664B1D619D;
	Wed, 11 Dec 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4D+HORa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E241632CA
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934741; cv=none; b=bGXtd7TcesfP/dGzbuPJp8wJy+l3wdA4FLrNck1F7hzdgvg5Z/iGYcV1d62RPFFsFmv2Eeu1txkFoKITL5WsZ/a5QhJRa0qfPJhmlpgniH3zZ55C9TwAEhr6Nhg1gGaCAH5ODtqL67YzcvKuwmVlop7HIprjQmjRoVFKy0dQzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934741; c=relaxed/simple;
	bh=GxQmFITPxFKEvNH7USsujWtA5nhtPIgyswQf1q74SZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J51xl6L1puzIBvzCjLbNT8VOnbXaoUQ7IntC5i+NZkxSVNs1VhXiIb0iUlFbm/2aZX6RLrO+67j0DU1Y9gFthvTqfArAfyGvXVOOq/CTLhNBZ7pnR/SDIO4d4uCTpw6aXSBoh3XEhV66fahuc87OK/9Z2WkbeZrxULR0O6IpFiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4D+HORa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B631AC4CED2;
	Wed, 11 Dec 2024 16:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934741;
	bh=GxQmFITPxFKEvNH7USsujWtA5nhtPIgyswQf1q74SZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4D+HORaJVQTvlWJ7jYKr0O8ZUZRi8ys4MDsetndqSOvWvMg1eCTOFgGJa98Vwaea
	 wXBPeqApjTOPcGc4ZDXdj1Q+td5uOJRQYSWuUySrK4uclMwL/5eb60iVLgR+aTXNaQ
	 75oqUtR+913OtKrQ2BRFKswHHbyF1l2gtlrjL9zLlRyTfR/vNZ/48kArwymJDfCzVM
	 u8b8t8BJfgkqXDaYvd/88WTEjDcW/rEcJSl0mJRkEn1csgEawGazQUS+kalt9KhLT5
	 qYaW60ysj+CZby5nmeDy1tjFKBq/iIq2wHB5lm6VP5RcGjSWH5YmnS6AwczUlTsfpa
	 EwbJeQoZx/VZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
Date: Wed, 11 Dec 2024 11:32:19 -0500
Message-ID: <20241211105115-2bdcf876d06bbf47@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211100409.2069734-1-jianqi.ren.cn@windriver.com>
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
1:  bbcc1c83f343e ! 1:  7df439bf2621c dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
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

