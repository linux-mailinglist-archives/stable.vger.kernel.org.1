Return-Path: <stable+bounces-99971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB029E76C8
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB3E188410E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7895C1F3D49;
	Fri,  6 Dec 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSSlKPBZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ACE206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505107; cv=none; b=ohv5RqMMhNO++/iFy86PT27o1dMPI2I45JkGsJ2z7RW7z/ZzqOpUBmmkYErRquqSJxlgue9YnoQLUgHr1jlXgqhbhQAmecAGoPZamyYrxpmwZ7pqMfnYz2UgbpcPo0Oq4N6prpTDNV0qKmN7+n5TCSjyeSxEqqPFPFLw9meV9xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505107; c=relaxed/simple;
	bh=1B8Ux3wqbt7tpI2vWiMtWEfasWvwPhXyHyYg9I7eRsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXVlA13Jj3+6JfRmkOcnpIKhEtshTKn7/ZUKyLnEDruW/w27FSFKfH92mTlnkh7R4YS61OLTNl1yxzMVDU/lqQR8KrOkPUC9wAogyE7x/D90YU3GX8LkzPMt9lc+JkLM7zXfV9+nl0cce3m69fW6B4J4Ps5iNmJmtCWXaqs69fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSSlKPBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8E6C4CED1;
	Fri,  6 Dec 2024 17:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505106;
	bh=1B8Ux3wqbt7tpI2vWiMtWEfasWvwPhXyHyYg9I7eRsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eSSlKPBZDj35Dbp0175HaFWji5b/5VGD64DqAZM1FuIlzqv+tcj4gYL1dtRs0Q4Ii
	 uREyZdYMSvmEjwafDwrAy3sIiqLPIloUv3yWdObK5Bg5DUlBCA3QnvBiE+Do9ENyEw
	 m3zaQYwmw2okBWmipb487I2J/Q0rZrUXHZaC8/RaheVrL5cuoG1p4DPl6NYN05UGWD
	 7J40yhvQljwnilYqBw8/f73a9JR9q5CY2CVysds9jFeClt6TQMI+WkMlwIgNIKU9LX
	 eDiFioEOoFV7rzoUvqlRC6vzTjOobntstkVuLuNNr59QanNpDNVefbxr7dovpHEpMa
	 esJrH8tFyZZGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
Date: Fri,  6 Dec 2024 12:11:45 -0500
Message-ID: <20241206095441-33232574ccf00444@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206032214.3089315-1-jianqi.ren.cn@windriver.com>
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
1:  bbcc1c83f343e ! 1:  da1ca4c28e390 dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
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

