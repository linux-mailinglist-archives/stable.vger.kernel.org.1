Return-Path: <stable+bounces-62249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F9E93E78B
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F301C211B3
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8521181723;
	Sun, 28 Jul 2024 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Goozp84F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF2B80C0C;
	Sun, 28 Jul 2024 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182752; cv=none; b=IZLkYpqKilYynad28TxYvN+fwlIDNJU5OeKuL0MJzDc2aRyeCrDrtOGoo5ZlIh29CLMIaXgNenDBATQF3VIH+jkfp9rX4O1l4uw9KC/eEJXGXW57NmxS3rEcG05+vnEGmkl/96GN08tWGAq5jCsMuI9ZKyBIgCSejM7/aPhJ/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182752; c=relaxed/simple;
	bh=T2mSqB6Q08o0mxT/jsh/iMxJ9Mr4dnstDhHx4l7GpnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfqcwFFbQQR7iPwRwzVKRTcnwof+h3eFd/DXMu20cyq6MjJX80AxOe0eOqIG64i8GXaOS7Z5jeA5Mo9QCKsbnMEqt+Uu8MKpnZ/BnO04nkr1dpnxk9zZ7JM3FQPwK7i1OqoNKp7LZblGDksZmLNWOWqr+OhteGkkdj1KXbsmNAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Goozp84F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CE5C4AF0B;
	Sun, 28 Jul 2024 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182751;
	bh=T2mSqB6Q08o0mxT/jsh/iMxJ9Mr4dnstDhHx4l7GpnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Goozp84FUG3slwM8M5LZbSxbZn86A8uw3mhO6CRhskGQi59KIdlxIVSb7q7ZxvJye
	 sSiBQG4gYvFEPbPWdroadG6wxl+5BGKXbzkdyC/bsag/ObvQZ/I6U5uvWLAQhVExs7
	 bgolAsIjoD2Vbkp36vSIVbwRMH2adqQeAXUdOQBlT+eYX/yn2LhaqfWspHGK/gEwQN
	 4E8U8yPosAx6Ful0+PLFEJreVDqfrBli3xIqxwy2UxMJsedDfWByRsXMAwHO9PIMZ7
	 G3DaBI70RgL1M7qMUvM0dG+eS8Iu4kQAPAFsqwdXQ/Qsvv81pzmJqQ8N8hAaU9wN3t
	 sNpbppaN9feZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Hongchi <hongchi.peng@siengine.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	hminas@synopsys.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 06/23] usb: dwc2: gadget: Don't write invalid mapped sg entries into dma_desc with iommu enabled
Date: Sun, 28 Jul 2024 12:04:47 -0400
Message-ID: <20240728160538.2051879-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160538.2051879-1-sashal@kernel.org>
References: <20240728160538.2051879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 74ac79abd8f37..e7bf9cc635be6 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -885,10 +885,10 @@ static void dwc2_gadget_config_nonisoc_xfer_ddma(struct dwc2_hsotg_ep *hs_ep,
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


