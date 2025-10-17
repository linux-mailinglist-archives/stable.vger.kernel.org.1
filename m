Return-Path: <stable+bounces-186330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6931CBE9147
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170CD3AA449
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F27369969;
	Fri, 17 Oct 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3zFn73y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBDB34AB0D
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709575; cv=none; b=Vq+6sC9n9tEkMVtPjseKVOV9bmn3OEhFZB9KEqqhb4GXBp8PtPTSGmTGloEZdUWjfZ4SB1+LR+0AC3vx642u2Cc2Y8/L68tMV2RJQ1sFePdGoASMdsz58N8XL3oHNRKtPhuvGFPIuG0OZvZS16u4fhr3MRiOyF85vPazLCTog/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709575; c=relaxed/simple;
	bh=9arAh/O73YqSPpERlS3pWVEm8/OMghHNzqHE0ev1C1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzUBIUFtfQ1I6VtP7/Rfs/lF7awAcYSen3qiqdlXA+Z+2g/Gh3Bmsc0TiAtVBXj4LYHS3raTs2l0Wuxz3mGszFMkajU7FfjXoRhbNrPJP44NB3kqs0yuQYVktAFcGaO8uSJAvpKf4xey8nIlAsTs/AGkOTxZ7k7eM7Ovb+wq2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3zFn73y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A75FC116B1;
	Fri, 17 Oct 2025 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760709575;
	bh=9arAh/O73YqSPpERlS3pWVEm8/OMghHNzqHE0ev1C1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3zFn73yIO5eCc/wQgzbaPEYEQ46hi9Cp77hVYHticBOFd2f7eseIm0m8G5JeZIH0
	 4cK/MFyBAvxP9y1Io3nQ1r89X0Zv2ziHMnYSMQMXWrwGB4/G6x8ssWJ7mQUoqibB2/
	 bEjzjBVjrAdcPJc0hsUCZThTvfG5NgQ1lHjcBBZFk2NGdITSJ/jrtwjdsdQK91sxDt
	 v35CJQCwxruFvVabaEK3pyOZ75qI7nJh9Hp/xuoHX7ctXsC8ixHMZBrmgjLZ9ccnnF
	 2Hv+Ve+JBW+nvsE+EcT5g7RLW8gVhe6xdJN1OXhVDLbaFnIwUXjqrOzu6ICUvJLlUw
	 1aAlslPEez4Qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] media: pci: ivtv: Add missing check after DMA map
Date: Fri, 17 Oct 2025 09:59:32 -0400
Message-ID: <20251017135932.3966607-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017135932.3966607-1-sashal@kernel.org>
References: <2025101625-respect-living-496e@gregkh>
 <20251017135932.3966607-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit 1069a4fe637d0e3e4c163e3f8df9be306cc299b4 ]

The DMA map functions can fail and should be tested for errors.
If the mapping fails, free blanking_ptr and set it to 0.  As 0 is a
valid DMA address, use blanking_ptr to test if the DMA address
is set.

Fixes: 1a0adaf37c30 ("V4L/DVB (5345): ivtv driver for Conexant cx23416/cx23415 MPEG encoder/decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ivtv/ivtv-irq.c | 2 +-
 drivers/media/pci/ivtv/ivtv-yuv.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtv-irq.c b/drivers/media/pci/ivtv/ivtv-irq.c
index b7aaa8b4a7841..e39bf64c5c715 100644
--- a/drivers/media/pci/ivtv/ivtv-irq.c
+++ b/drivers/media/pci/ivtv/ivtv-irq.c
@@ -351,7 +351,7 @@ void ivtv_dma_stream_dec_prepare(struct ivtv_stream *s, u32 offset, int lock)
 
 	/* Insert buffer block for YUV if needed */
 	if (s->type == IVTV_DEC_STREAM_TYPE_YUV && f->offset_y) {
-		if (yi->blanking_dmaptr) {
+		if (yi->blanking_ptr) {
 			s->sg_pending[idx].src = yi->blanking_dmaptr;
 			s->sg_pending[idx].dst = offset;
 			s->sg_pending[idx].size = 720 * 16;
diff --git a/drivers/media/pci/ivtv/ivtv-yuv.c b/drivers/media/pci/ivtv/ivtv-yuv.c
index e79e8a5a744ad..0e6014f95178b 100644
--- a/drivers/media/pci/ivtv/ivtv-yuv.c
+++ b/drivers/media/pci/ivtv/ivtv-yuv.c
@@ -120,7 +120,7 @@ static int ivtv_yuv_prep_user_dma(struct ivtv *itv, struct ivtv_user_dma *dma,
 	ivtv_udma_fill_sg_array(dma, y_buffer_offset, uv_buffer_offset, y_size);
 
 	/* If we've offset the y plane, ensure top area is blanked */
-	if (f->offset_y && yi->blanking_dmaptr) {
+	if (f->offset_y && yi->blanking_ptr) {
 		dma->SGarray[dma->SG_length].size = cpu_to_le32(720*16);
 		dma->SGarray[dma->SG_length].src = cpu_to_le32(yi->blanking_dmaptr);
 		dma->SGarray[dma->SG_length].dst = cpu_to_le32(IVTV_DECODER_OFFSET + yuv_offset[frame]);
@@ -924,6 +924,12 @@ static void ivtv_yuv_init(struct ivtv *itv)
 		yi->blanking_dmaptr = dma_map_single(&itv->pdev->dev,
 						     yi->blanking_ptr,
 						     720 * 16, DMA_TO_DEVICE);
+		if (dma_mapping_error(&itv->pdev->dev, yi->blanking_dmaptr)) {
+			kfree(yi->blanking_ptr);
+			yi->blanking_ptr = NULL;
+			yi->blanking_dmaptr = 0;
+			IVTV_DEBUG_WARN("Failed to dma_map yuv blanking buffer\n");
+		}
 	} else {
 		yi->blanking_dmaptr = 0;
 		IVTV_DEBUG_WARN("Failed to allocate yuv blanking buffer\n");
-- 
2.51.0


