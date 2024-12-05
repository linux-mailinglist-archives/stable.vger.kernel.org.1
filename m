Return-Path: <stable+bounces-98826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCB09E58BA
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CB216C40C
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3175F218853;
	Thu,  5 Dec 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmW2/f1/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0321C165
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409918; cv=none; b=moqGlqlmIgt9AYXxBuE63ijA2SyxNKjeVtV2ZuIuikr82ORCbFLhl5ZcBDRxwr5Jhjz03lrRNN6ahFU7BZ8yQiUTYwFMU+PPkxTiecGFFl0krbCQqWHY2pr3Nop1/iLJq0uHSksWVbyNRk9OtN74FfcNOaGgdf0nNbwMs35NhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409918; c=relaxed/simple;
	bh=k+EFcu8x+LS/r2UflzGSa8aIIoKX0aNf5x0TdzQ3slY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOHhgVJdLA1zHQud6mMWJ0dc9QVn1Riu9kRzgHyyGJ05CvUVson0He3RpDRd7XJqB8kK2Zeg9oy6vtPaOwRYDzYimTNhLN6BtXkYX7C7TURv4aaTBMnv8oIvhv1YJXeskaFc/70QcRSCHxjVFUsQypYbS6T34cg2cdT1b85KUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmW2/f1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECF6C4CED1;
	Thu,  5 Dec 2024 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733409917;
	bh=k+EFcu8x+LS/r2UflzGSa8aIIoKX0aNf5x0TdzQ3slY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmW2/f1/77PxSXrFqG1njkccHt6KDcgUr54l3B0EZfzcmEfgASqtNv4yG286XTU/X
	 Ojz26/NsaL06BV47PYy3XHklkUpa6bCvvfFUVjpbxG0tPxf89tsKkM6kmMyVEsEc9t
	 QBbmkt4VU/56rUrdVFK9neRBamnfeJqlBWdfqCtV7ArQZ1McerWFGWxObkjHbVmQL7
	 kM3db4JJLlAhl692EKc/uw70FePwjm1l3rcfK6S/diUbEBtDR99Ouse5JeNmsLbE5Z
	 hJ/vnKIVrx/lUiyneBArcucEckyepWhrvAjUgV01uNGVkcYDInd/ONlBYIlRoaUHsD
	 apwl4At2F87rA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
Date: Thu,  5 Dec 2024 08:33:57 -0500
Message-ID: <20241205064613-4d3ad8b96c1199ec@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241205093758.2163649-1-jianqi.ren.cn@windriver.com>
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
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d24fe6d5a1cf)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bbcc1c83f343e ! 1:  9152d76cc2fe0 dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
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
     +		readl(chunk->ll_region.vaddr.io);
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
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.1.y:
    drivers/dma/dw-edma/dw-edma-v0-core.c: In function 'dw_edma_v0_sync_ll_data':
    drivers/dma/dw-edma/dw-edma-v0-core.c:371:45: error: request for member 'io' in something not a structure or union
      371 |                 readl(chunk->ll_region.vaddr.io);
          |                                             ^
    make[4]: *** [scripts/Makefile.build:250: drivers/dma/dw-edma/dw-edma-v0-core.o] Error 1
    make[4]: Target 'drivers/dma/dw-edma/' not remade because of errors.
    make[3]: *** [scripts/Makefile.build:503: drivers/dma/dw-edma] Error 2
    make[3]: Target 'drivers/dma/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:503: drivers/dma] Error 2
    make[2]: Target 'drivers/' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:503: drivers] Error 2
    make[1]: Target './' not remade because of errors.
    make: *** [Makefile:2009: .] Error 2
    make: Target '__all' not remade because of errors.

