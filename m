Return-Path: <stable+bounces-132855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D13A90634
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6285419E1D19
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF529205E37;
	Wed, 16 Apr 2025 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAkXjqGR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB63205AD0
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813025; cv=none; b=eqv7KSHguUJ8ybD6pOp+WFdZojFZuSoW0kfPWK/78YnOJANNFnNNjOQ0D+2noucdhgrqcMQ2xW35wHtT25CkebU/RQ2Yt8WO3TExhy0cgfwpHcQ4JPFqn9N9tNH1RAeAQIiztVyFc/ETSQSWP0tGoYwkxOmz9jOuScMYzS+6CYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813025; c=relaxed/simple;
	bh=kewdEjgo3sJ6tGV/FgpnVkLLwoNLkN6Ekhs8CFaxdf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNnOHUadgjnyif49l7UUuec24PzQ6NTz3BkJD2M8tKeFSa+dTjCiIw0c5JJBjHDuZxd4zPqbvzup3JPUe3DBAyJdQYoWf5aUdw/XWrGQKIJnkmUfmso5oPAZ+kKMwLmJvy/cv20KVBe2Xm6rltLVvHDHFoDMMevDmvKBy7J+MZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAkXjqGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE10C4CEED;
	Wed, 16 Apr 2025 14:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813025;
	bh=kewdEjgo3sJ6tGV/FgpnVkLLwoNLkN6Ekhs8CFaxdf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAkXjqGRIccSon3tXosBL+tSEqQg8LVWHWSOUY25eEXKU+zGRAxberR/nGxw2NEFI
	 V5FoRaQedFQTMx32jh1ciuLqTwgGuXWwkw9GYZHns0iTb9pT7D/J6eQDmtME8Dxxtl
	 wbL1PoPt5fryPKdtXS5UrTdqHtwejxnk9U+AO6kqq3eJ+dmH6QOQ4h8zMn99+xN5FA
	 582rpfrz8laRJTpmps2N+pYzu1v2efKUm+m2EAxi0mpSyC0ds9F+APxoRu/Qqg3W1C
	 CBkjisaFa8+gK3VlGz5DnF+8WyTdb0e+m5Hv0mzpL91k2ZzaEFX7bTR+m5kL+b0FlP
	 J6imXa/Iy66gw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hgohil@mvista.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/3 v5.4.y] dmaengine: ti: edma: Add support for handling reserved channels
Date: Wed, 16 Apr 2025 10:17:03 -0400
Message-Id: <20250416094324-6e022b558e4afeaf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416064325.1979211-1-hgohil@mvista.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 31f4b28f6c41f734957ea66ac84c6abb69e696f0

WARNING: Author mismatch between patch and found commit:
Backport author: Hardik Gohil<hgohil@mvista.com>
Commit author: Peter Ujfalusi<peter.ujfalusi@ti.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  31f4b28f6c41f ! 1:  b6e5827c1f15c dmaengine: ti: edma: Add support for handling reserved channels
    @@ Commit message
         Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
         Link: https://lore.kernel.org/r/20191025073056.25450-4-peter.ujfalusi@ti.com
         Signed-off-by: Vinod Koul <vkoul@kernel.org>
    +    Signed-off-by: Hardik Gohil <hgohil@mvista.com>
     
      ## drivers/dma/ti/edma.c ##
     @@ drivers/dma/ti/edma.c: struct edma_cc {
    @@ drivers/dma/ti/edma.c: static int edma_alloc_channel(struct edma_chan *echan,
      	edma_or_array2(ecc, EDMA_DRAE, 0, EDMA_REG_ARRAY_INDEX(channel),
      		       EDMA_CHANNEL_BIT(channel));
     @@ drivers/dma/ti/edma.c: static int edma_probe(struct platform_device *pdev)
    - {
      	struct edma_soc_info	*info = pdev->dev.platform_data;
      	s8			(*queue_priority_mapping)[2];
    + 	int			i, off;
     -	const s16		(*rsv_slots)[2];
    -+	const s16		(*reserved)[2];
    - 	int			i, irq;
    ++	const s16               (*reserved)[2];
    + 	const s16		(*xbar_chans)[2];
    + 	int			irq;
      	char			*irq_name;
    - 	struct resource		*mem;
     @@ drivers/dma/ti/edma.c: static int edma_probe(struct platform_device *pdev)
      	if (!ecc->slot_inuse)
      		return -ENOMEM;
    @@ drivers/dma/ti/edma.c: static int edma_probe(struct platform_device *pdev)
      
      		ecc->tc_list = devm_kcalloc(dev, ecc->num_tc,
     @@ drivers/dma/ti/edma.c: static int edma_probe(struct platform_device *pdev)
    - 				info->default_queue = i;
      			}
    + 			of_node_put(tc_args.np);
      		}
     +
     +		/* See if we have optional dma-channel-mask array */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

