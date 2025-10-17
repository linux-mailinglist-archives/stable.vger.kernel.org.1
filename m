Return-Path: <stable+bounces-186332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D97BE91A5
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 144BB4EFEB3
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F9D3195E5;
	Fri, 17 Oct 2025 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dg2pVCC9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0A736998C
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710032; cv=none; b=WWNZ9/9rmvaA+n9vL+WRPCd29GFs7pCiQAF11YRCfty7FwDndGTChLaZxFmXDoPHqjyvlgfChtDJk5vZQlY6opBrSHV9SQqT+TQL8SfMq86o451PzXohM/91CSPh+Rx90uz4RSZ5ZM81s6UblJzxFnQoPOo7L/2t4hrlsUh86DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710032; c=relaxed/simple;
	bh=9arAh/O73YqSPpERlS3pWVEm8/OMghHNzqHE0ev1C1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mw4D/Toh+OfI78pvznzYjZyjgo+yYpVbfK51YL77NdJbnykojVJTu9FSGAaOAR9xgRdvhupaoDOg5inri5gPNyiK/oZmSy1RS1MqyhjAw0cqCt43AUfLSa5JG1+DY7O9E/PwXZ59XFHJZ1LiwUJJPlgSHmx5K1FA32ZuzdLcJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dg2pVCC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40605C4CEF9;
	Fri, 17 Oct 2025 14:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760710031;
	bh=9arAh/O73YqSPpERlS3pWVEm8/OMghHNzqHE0ev1C1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dg2pVCC9/7pZF9vCyd/EZliRE3nzA5Vi24LNSF0uk9iyAbq5YbP4XBMdweFSlvPcJ
	 +KDwDJyheHiI90QqP7/FWcP19/3KpPh7eMJ73oUZEJvtLe0LRROWZLyRrCZyz2YfB7
	 kw1Pkpk5IiK8KuUr7UwtLr60VOhRi1aJ785t0VuZtTMp3iyh8Evy+XEmDlzwYi+QMe
	 aEE8puigE037/3n4B7nm579PN+BTI7C/BFc1Ly1c0i/ZN8hvBX2JC8t4vcxJkCQpKq
	 kPa4QVmMhNUWW4TvRW/5T1TbGBw0kwaBNs6DFQjbucd6+ucRmhR6v076dxpK+MQrJo
	 ltCuxx6kuGh7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] media: pci: ivtv: Add missing check after DMA map
Date: Fri, 17 Oct 2025 10:07:08 -0400
Message-ID: <20251017140708.3972659-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017140708.3972659-1-sashal@kernel.org>
References: <2025101625-demise-squander-3a2c@gregkh>
 <20251017140708.3972659-1-sashal@kernel.org>
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


