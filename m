Return-Path: <stable+bounces-62316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8712593E85F
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495D7280F6E
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F3718EFD3;
	Sun, 28 Jul 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nboZ8qJG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7ED18EFC8;
	Sun, 28 Jul 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722183007; cv=none; b=jsB/MvZAQPZSTa13PU8uXlYsqN6tluiB3yB6Bvq54KOMeSKHyEL3f1ox0yPzYbgi9cHn02vlKLFcTI9pPd5vIG4dAk7AOXFGvVzMm5wWVeaiTenQhnv5d41eUaVj7qCHZD8ecP4qoRe/BorJJPIwddot3POfYpPGI905yAA56dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722183007; c=relaxed/simple;
	bh=orsUegusOHUKkDIGWhR61glVCl5aIZX5UuF6e/4RCG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UV/MDNdPJvQgV3SG0OXLhY9GF3JPDKX9DRab1Lr5Dpmsal76l6hLelKXl5aVZBDK4zTHdEKalo52P0g7i5MXEh35Uy/hnyACMNUo3DaQqtFOWJp6i6065c/rBgfOgcnc7n2QfKZE3dToOjL2cuVaSXOyR5IapjJ3CyOdL2pXkb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nboZ8qJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A69C116B1;
	Sun, 28 Jul 2024 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722183007;
	bh=orsUegusOHUKkDIGWhR61glVCl5aIZX5UuF6e/4RCG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nboZ8qJGEIWLHkGpbY/sesUfN78k2fOP3pGooDRzE+JL25T17UYevMCTKZmgavzEl
	 Dza4CBEfx+lRxRbV87K6dWCg5fS4VKIEfP31jFtBojZaL6Z9NQc37qASnrNRsJ72u/
	 KZq7p9EI+GHpvvod/u0uutYQzUu7nW4M0VqW2lrFNar+fwGPzzTwL+Xgo58oCLbWOh
	 51Altbh+1SWGUuks8XAzqsC2y5JxUqwXW8DfX3UTkZMdPwysrLE4fwJ6yxIH7l6aKv
	 oSj+H9Xb0/QdPNyaig0Rk2eXLRQ1PTdY70Dq27/yaOkazCo342jPiWT4Rdpa/+6bn2
	 euMn9X1ugUJUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Hongchi <hongchi.peng@siengine.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	hminas@synopsys.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 05/11] usb: dwc2: gadget: Don't write invalid mapped sg entries into dma_desc with iommu enabled
Date: Sun, 28 Jul 2024 12:09:38 -0400
Message-ID: <20240728160954.2054068-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160954.2054068-1-sashal@kernel.org>
References: <20240728160954.2054068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Peng Hongchi <hongchi.peng@siengine.com>

[ Upstream commit 1134289b6b93d73721340b66c310fd985385e8fa ]

When using dma_map_sg() to map the scatterlist with iommu enabled,
the entries in the scatterlist can be mergerd into less but longer
entries in the function __finalise_sg(). So that the number of
valid mapped entries is actually smaller than ureq->num_reqs,and
there are still some invalid entries in the scatterlist with
dma_addr=0xffffffff and len=0. Writing these invalid sg entries
into the dma_desc can cause a data transmission error.

The function dma_map_sg() returns the number of valid map entries
and the return value is assigned to usb_request::num_mapped_sgs in
function usb_gadget_map_request_by_dev(). So that just write valid
mapped entries into dma_desc according to the usb_request::num_mapped_sgs,
and set the IOC bit if it's the last valid mapped entry.

This patch poses no risk to no-iommu situation, cause
ureq->num_mapped_sgs equals ureq->num_sgs while using dma_direct_map_sg()
to map the scatterlist whith iommu disabled.

Signed-off-by: Peng Hongchi <hongchi.peng@siengine.com>
Link: https://lore.kernel.org/r/20240523100315.7226-1-hongchi.peng@siengine.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index d8b83665581f5..af8a0bb5c5085 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -886,10 +886,10 @@ static void dwc2_gadget_config_nonisoc_xfer_ddma(struct dwc2_hsotg_ep *hs_ep,
 	}
 
 	/* DMA sg buffer */
-	for_each_sg(ureq->sg, sg, ureq->num_sgs, i) {
+	for_each_sg(ureq->sg, sg, ureq->num_mapped_sgs, i) {
 		dwc2_gadget_fill_nonisoc_xfer_ddma_one(hs_ep, &desc,
 			sg_dma_address(sg) + sg->offset, sg_dma_len(sg),
-			sg_is_last(sg));
+			(i == (ureq->num_mapped_sgs - 1)));
 		desc_count += hs_ep->desc_count;
 	}
 
-- 
2.43.0


