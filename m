Return-Path: <stable+bounces-118554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FC9A3EF0E
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 09:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3F67A266E
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 08:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0449F20103F;
	Fri, 21 Feb 2025 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qQZbeT7q"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8E33EA
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127837; cv=none; b=UxY1hnnRdj5gNFYEz4X/tHDDTMHf8Md35hoLYzcfveIXTFOq9xvy66L1c06x7tIx8I+GljCiAUwlhb9ZbqQI9ie+IsmH0vONPNeDByKDJptByIC+tND0jO28bxJfdTlYsFdtdukbhDPyKJt7m+2cv8DnrfJtZXSBc6l0IMkd5Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127837; c=relaxed/simple;
	bh=+u4ZUUxYbpjny3lGXGhCenne03oyRN1rIG8puegrYp0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vj9kJqj0/XaZOfb4jx1whysbiBIczz5LjgmjFbstq5GX1HQIhYCBZaM3ymlXQ9piO+iwypmdb8bauZXW/a5SytvkMzzAOhGbBoogqRcXF/xDmZZucA4Iz6S/j/80f48TXUcEZNWzr5nOvFgndKHE+1xLQkxE+lz1fqbrYkA1xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qQZbeT7q; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sF5jP
	a8x3eUqKV43haU9RXQTmqoi3lfX6ykyXmW3NIw=; b=qQZbeT7qIuan1/wioBDkN
	WEFRQi7PZNq6eAqgSspZe57IHPogVChR+Tip62DM09YXdQGDnmXO9iN8dWx1U3Ld
	MYvsxFkMsxU9qD0SEMW2/IdAMnco+Aaqc0fLflkttwkjLVJXuIbsJrLfNYD66gre
	XQgYCB/HuyPraCmjueh0ZM=
Received: from public (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDX77gsPrhn8vJwNA--.20469S4;
	Fri, 21 Feb 2025 16:50:00 +0800 (CST)
From: jetlan9@163.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Yunfei Dong <yunfei.dong@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.1.y] media: mediatek: vcodec: Fix H264 multi stateless decoder smatch warning
Date: Fri, 21 Feb 2025 16:49:44 +0800
Message-Id: <20250221084944.5376-1-jetlan9@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX77gsPrhn8vJwNA--.20469S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy5ZF1kXrWDWFWkCw13CFg_yoW8tw17p3
	WkKr4UZrW5Xwnrur48Jw4ruFy5Aa93W34Iga12v3WSyr9xXF48XrW2ya4ayrWkArsava43
	Krn0q34I9F4Ykr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pujgn5UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/1tbiWwH4yGe1nILujQABsE

From: Yunfei Dong <yunfei.dong@mediatek.com>

[ Upstream commit 9be85491619f1953b8a29590ca630be571941ffa ]

Fix a smatch static checker warning on vdec_h264_req_multi_if.c.
Which leads to a kernel crash when fb is NULL.

Fixes: 397edc703a10 ("media: mediatek: vcodec: add h264 decoder driver for mt8186")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[ drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
is renamed from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
since 0934d3759615 ("media: mediatek: vcodec: separate decoder and encoder").
The path is changed accordingly to apply the patch on 6.1.y. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 .../mediatek/vcodec/vdec/vdec_h264_req_multi_if.c        | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
index 999ce7ee5fdc..6952875ca183 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
@@ -729,11 +729,16 @@ static int vdec_h264_slice_single_decode(void *h_vdec, struct mtk_vcodec_mem *bs
 		return vpu_dec_reset(vpu);
 
 	fb = inst->ctx->dev->vdec_pdata->get_cap_buffer(inst->ctx);
+	if (!fb) {
+		mtk_vcodec_err(inst, "fb buffer is NULL");
+		return -ENOMEM;
+	}
+
 	src_buf_info = container_of(bs, struct mtk_video_dec_buf, bs_buffer);
 	dst_buf_info = container_of(fb, struct mtk_video_dec_buf, frame_buffer);
 
-	y_fb_dma = fb ? (u64)fb->base_y.dma_addr : 0;
-	c_fb_dma = fb ? (u64)fb->base_c.dma_addr : 0;
+	y_fb_dma = fb->base_y.dma_addr;
+	c_fb_dma = fb->base_c.dma_addr;
 	mtk_vcodec_debug(inst, "[h264-dec] [%d] y_dma=%llx c_dma=%llx",
 			 inst->ctx->decoded_frame_cnt, y_fb_dma, c_fb_dma);
 
-- 
2.34.1


