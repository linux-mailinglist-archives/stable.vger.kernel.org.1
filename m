Return-Path: <stable+bounces-136649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE7AA9BC2D
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 03:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9E892026C
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 01:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75A721348;
	Fri, 25 Apr 2025 01:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbGLnWa+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F940101DE
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 01:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745543696; cv=none; b=mk468ItreQIQtUaHcexECPXhZGtLKUNrYObkdk/xI8SeOJvnRSYQuMMzVzlCFEWDIvyJJ9jKlU3Uf0vrELJgN3tbaQbLOVX8/p7btvauwnv0od+UXriPghLljQg7Bjfh24B4+3E2grXRAkmcdspvgN/WEix7TdbLH4TD4bErxbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745543696; c=relaxed/simple;
	bh=PbtGp/mgoo4X9FEeJzUWhhUQlkVd18+95EXVPi+BYAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oftLEvxoE5bCGopW/+xSca7xSXW2+RLPCm6xo48NBE+7O/130PamR3BF7N+TOt0jAlKOeZy/Fj2Hkfb/H8sgCQxPdG2UL3dcotIQTNzPvuQD3DiiFO2d9+iesC7otjMg4kGpkzVspfliz8tYTjL2UCNtos6SYJKrXAjieBgLNbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbGLnWa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4B6C4CEE3;
	Fri, 25 Apr 2025 01:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745543695;
	bh=PbtGp/mgoo4X9FEeJzUWhhUQlkVd18+95EXVPi+BYAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbGLnWa+zb9wggsf1toQZIyetq+MSnJLTtDJn/6ClK1tX9KXanh+moni/4+yR7g6/
	 6TY3TrQi8hKmmPMQS0mi07+7Hhb0QCqnD0LtihuqMftWiVpsdHRy2qwim1oKW2Kms5
	 tMmccbaNfEXafz+OwLhnNRdk6Fu/HtHxyjGoz5lWWPQz+ChWx7ksk2l/bNn13dNlYF
	 jyCcnEgjRfXJcUKlqnVJaY2qU/McODw/MPbZgrXVNPagv279LEtVEIl0NgzdS3FsQ1
	 l1Y4jD0akPPIoATdEVP8GD+rRtz21KSzfleQut66/jJlnRobdLxWspFbnchkq/YHGV
	 QtBHfkm8kYVRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hgohil@mvista.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/3 v5.4.y] dmaengine: ti: edma: Add support for handling reserved channels
Date: Thu, 24 Apr 2025 21:14:51 -0400
Message-Id: <20250424162545-6ebf98d67892969e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250424060854.50783-1-hgohil@mvista.com>
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
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  31f4b28f6c41f ! 1:  f2bbef69f3dbe dmaengine: ti: edma: Add support for handling reserved channels
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

