Return-Path: <stable+bounces-63769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C54941A8A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F7F1C23732
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F287018990C;
	Tue, 30 Jul 2024 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dt65+sTJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C31898F7;
	Tue, 30 Jul 2024 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357895; cv=none; b=lDcpVgGoDOy1ftPdNSdPViRtRbYx5ODw6JATE1NT1UT2Bf+7/qNTR7ToFQLRmGRgzl4OOxaxs9bMPqstc3v1095HH0mZj5ljPhbwZRCCGTDBmDtreLrBXlUO8Q91Cireh5xvNbp1pMKxPe5a8PoHc8lbGkDaLl9L17ZjZh4UZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357895; c=relaxed/simple;
	bh=ul0QVal0vhk0mydQTql5mLwWQ5yZsBEGWYDB2o9S9AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAKedOeBNH50xuFfSG83tXY0LoYaunUJ1P9+qpELtAkhuJ0DA8JboqVRqsBoW1lAqYjnRg3aXmHkTF3WbWSLNFiphqlP3czZjLCcPXyT3x140cyDTaLpGG7QaQtmTNdqQhHf5U9iuZfHDqLUHgY8TIf8GxFOzFbVg4JbMqY77Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dt65+sTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242F5C32782;
	Tue, 30 Jul 2024 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357895;
	bh=ul0QVal0vhk0mydQTql5mLwWQ5yZsBEGWYDB2o9S9AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dt65+sTJKoO5y/UPYRYGp3PaIEN3ROc4G5/xoIsCGgZ3F6If/RCgrtZhbD7DZNmYs
	 bBZ2arL+l4LbzyO24l7Bas4/kniBMzwacLSO0ULYNLNu8AFwM79D230V31g0Pvz3Wt
	 zE5clphKmfYIBRlesBSUJizGvllecfWqIisccv3E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 302/809] media: mediatek: vcodec: Fix unreasonable data conversion
Date: Tue, 30 Jul 2024 17:42:58 +0200
Message-ID: <20240730151736.521906686@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunfei Dong <yunfei.dong@mediatek.com>

[ Upstream commit 48d85de244047eabe07c5040af12dfa736d61d6c ]

Both 'bs_dma' and 'dma_addr' are integers. No need to convert the
type from dma_addr_t to uint64_t again.

Fixes: d353c3c34af0 ("media: mediatek: vcodec: support 36 bits physical address")

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
index 4bc89c8644fec..5f848691cea44 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
@@ -449,7 +449,7 @@ static int vdec_vp8_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 		       inst->frm_cnt, y_fb_dma, c_fb_dma, fb);
 
 	inst->cur_fb = fb;
-	dec->bs_dma = (uint64_t)bs->dma_addr;
+	dec->bs_dma = bs->dma_addr;
 	dec->bs_sz = bs->size;
 	dec->cur_y_fb_dma = y_fb_dma;
 	dec->cur_c_fb_dma = c_fb_dma;
-- 
2.43.0




