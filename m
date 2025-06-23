Return-Path: <stable+bounces-156173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FABAE4E75
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE414189E740
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2462206BB;
	Mon, 23 Jun 2025 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SC9QuebX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19AB21CA07;
	Mon, 23 Jun 2025 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712758; cv=none; b=u3lX2WXKW1QPDTi7x98biAapOAlDB4bY8bqxXc+UYTxLSO/3zx7JWf07gPsZqQDI/rVSdKOT4d2Z+I92T0gt5F1Ew5JBTSDKw2QqYn8IMkXGNOnBXvOlV+gIL39A1BbXt790anXl9qzRvUkmU63Yo16972gpuz4xq0hcqK3Qmf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712758; c=relaxed/simple;
	bh=L5MJPlykFgrdaaNI97hdO/0crEf7fIkE0+z3TfRaP6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhwMmrDpl1pzeLOs21QrummGSW7KNiR/gxj0fpgcaNelIUJa/yuJZ7HQhOHXf04jAixa4YsUYUNpC7ZWjAn8xcrcYy7WpxX6UabWYKXllshl/ViZLYvjcxtJxO5Lls+nxesX/TjWBGVbOAt8/kJ3e5MPr8GcWs8a5Fa7ssXuny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SC9QuebX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07853C4CEEA;
	Mon, 23 Jun 2025 21:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750712758;
	bh=L5MJPlykFgrdaaNI97hdO/0crEf7fIkE0+z3TfRaP6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SC9QuebXBCfTG7DApt0OPV9KLXRFd9hpbGKZ81w+SBiTF+waY26pqS2GtM/GNBWNK
	 SANyrvuowfEx9g6LQG4aHFqge2eO/8/2ln69eYcG5iS+BvQNUduP+CR465Mc7+yEki
	 0pxWqr+2Mz1kOqbHpIooRLBgQA/YXbbMdrkdAOK0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sergio Perez Gonzalez <sperezglz@gmail.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 311/592] net: macb: Check return value of dma_set_mask_and_coherent()
Date: Mon, 23 Jun 2025 15:04:29 +0200
Message-ID: <20250623130707.811498408@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergio Perez Gonzalez <sperezglz@gmail.com>

[ Upstream commit 3920a758800762917177a6b5ab39707d8e376fe6 ]

Issue flagged by coverity. Add a safety check for the return value
of dma_set_mask_and_coherent, go to a safe exit if it returns error.

Link: https://scan7.scan.coverity.com/#/project-view/53936/11354?selectedIssue=1643754
Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Link: https://patch.msgid.link/20250526032034.84900-1-sperezglz@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e1e8bd2ec155b..d1f1ae5ea161c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5283,7 +5283,11 @@ static int macb_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	if (GEM_BFEXT(DAW64, gem_readl(bp, DCFG6))) {
-		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+		if (err) {
+			dev_err(&pdev->dev, "failed to set DMA mask\n");
+			goto err_out_free_netdev;
+		}
 		bp->hw_dma_cap |= HW_DMA_CAP_64B;
 	}
 #endif
-- 
2.39.5




