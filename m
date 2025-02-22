Return-Path: <stable+bounces-118664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A9FA40997
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 16:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B631727F6
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440551C8601;
	Sat, 22 Feb 2025 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cut78GYu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C4469D2B
	for <stable@vger.kernel.org>; Sat, 22 Feb 2025 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239615; cv=none; b=oidsLK67bDxy5NJ2aiu7nQeztQIf16NZw0F+2rtPJk3bgN1+OujWWHee1MlE51AfEVBX6HdXC5tT8ob5TfSrk6SlqWS4cwGnCjvwOX/XbaXPkrExFSySe3LRtrpdnDPHkcEPWuHkmsBrwIStC1w0FsZiZx9HDTtd/k9hP9a1CtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239615; c=relaxed/simple;
	bh=HDZtgIDIno0oc8jyAtqChymjLLlS0fS/doO7nyUGfdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uL8hYvkTFgld091ZEVCJ03VPzqmu45fpfLC1dj0xShwS20+N8zicYqyOdmOUhoBBBpVRzQiDxM8qtQNyT/Wgr7hsk5yFS5xaxqbha6NQ/wbQVVQRLEiHnO4gnueFDToQcLTWem/ghKLvfXUwpBKaJu1f0obIJtXYK/rr0VhPMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cut78GYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAA6C4CEE6;
	Sat, 22 Feb 2025 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740239614;
	bh=HDZtgIDIno0oc8jyAtqChymjLLlS0fS/doO7nyUGfdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cut78GYuhBNJNKXseIggA5AtgLcTpe8oY8t2VNGz80LR5y/Oi4XElDVbYu0Yg38py
	 f18EyQ+/dL20encXVT/mXO+GO24TddVev86MXNUyvjgfvdl7oRPN1E6ZS33AWBhZrh
	 zrZoeDMrR5k+PN+OO4A9a6xTqw0yXbtIDLISo56WZDSBf7BKmLr/V3CRNsqqSqJeO4
	 bgdO6rr2Hxaf1FGN/mtfEPNot5xMaft/08VbxOj7UDy1Ddv3KcKH3+mp0IYWl4OhLB
	 6UWaGfYNKzDrPEjavK/rlkl+qLQih4yZ9LTGT1PbMgLsUNkM9kKatiCNox7TGVdwB/
	 KG0yzj7LUoIxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jetlan9@163.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] media: mediatek: vcodec: Fix H264 multi stateless decoder smatch warning
Date: Sat, 22 Feb 2025 10:53:33 -0500
Message-Id: <20250222102625-9a6ecc43c442bcda@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250221084944.5376-1-jetlan9@163.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 9be85491619f1953b8a29590ca630be571941ffa

WARNING: Author mismatch between patch and upstream commit:
Backport author: jetlan9@163.com
Commit author: Yunfei Dong<yunfei.dong@mediatek.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 588bcce9e64c)

Note: The patch differs from the upstream commit:
---
1:  9be85491619f1 ! 1:  dffd0505449e8 media: mediatek: vcodec: Fix H264 multi stateless decoder smatch warning
    @@ Metadata
      ## Commit message ##
         media: mediatek: vcodec: Fix H264 multi stateless decoder smatch warning
     
    +    [ Upstream commit 9be85491619f1953b8a29590ca630be571941ffa ]
    +
         Fix a smatch static checker warning on vdec_h264_req_multi_if.c.
         Which leads to a kernel crash when fb is NULL.
     
    @@ Commit message
         Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
         Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
         Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
    +    [ drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
    +    is renamed from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
    +    since 0934d3759615 ("media: mediatek: vcodec: separate decoder and encoder").
    +    The path is changed accordingly to apply the patch on 6.1.y. ]
    +    Signed-off-by: Wenshan Lan <jetlan9@163.com>
     
    - ## drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c ##
    -@@ drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c: static int vdec_h264_slice_single_decode(void *h_vdec, struct mtk_vcodec_mem *bs
    + ## drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c ##
    +@@ drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c: static int vdec_h264_slice_single_decode(void *h_vdec, struct mtk_vcodec_mem *bs
      		return vpu_dec_reset(vpu);
      
      	fb = inst->ctx->dev->vdec_pdata->get_cap_buffer(inst->ctx);
     +	if (!fb) {
    -+		mtk_vdec_err(inst->ctx, "fb buffer is NULL");
    ++		mtk_vcodec_err(inst, "fb buffer is NULL");
     +		return -ENOMEM;
     +	}
     +
    @@ drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c: st
     -	c_fb_dma = fb ? (u64)fb->base_c.dma_addr : 0;
     +	y_fb_dma = fb->base_y.dma_addr;
     +	c_fb_dma = fb->base_c.dma_addr;
    - 	mtk_vdec_debug(inst->ctx, "[h264-dec] [%d] y_dma=%llx c_dma=%llx",
    - 		       inst->ctx->decoded_frame_cnt, y_fb_dma, c_fb_dma);
    + 	mtk_vcodec_debug(inst, "[h264-dec] [%d] y_dma=%llx c_dma=%llx",
    + 			 inst->ctx->decoded_frame_cnt, y_fb_dma, c_fb_dma);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

