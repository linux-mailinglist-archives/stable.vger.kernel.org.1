Return-Path: <stable+bounces-124899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4500EA68A07
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6FE3BF901
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DEE253F24;
	Wed, 19 Mar 2025 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q62PP3w3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1D251796
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381650; cv=none; b=HORNdR1ya3UbWa3TEI3ox3Y8eYkhvJRpnoEeXvJ4PRskZi7QTH0fnC8Cwn2m7ba5eQiC9j5+MI74VWMb5rVzGEoaoTxRpPqnw951n1NXd1yaIkjsuujQzhGOXCTuYRLeAUOK/B0EAMlId6OeK2/DD63lmEcpBMq/j9+EIlfBlwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381650; c=relaxed/simple;
	bh=an+WgFVse1usF3HhjsrsWF0AUsRbMPruBabEbqUrhn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jACJ8HSErNTJeyRoum9I9NjFEFtD1gN10JRnqNtkAoa9/D6SYdXioh0rNCp16qEs+B/Nf9+srgaZ3oJiPAJim/5Pi+xdQqsoreAVBtZ/DajP9hsXayBtrL0L9+x1UI21X44jDkM6g2jrQjAD4QMaqWsDBXfQN9mviZ5DchFY1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q62PP3w3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9A7C4CEE9;
	Wed, 19 Mar 2025 10:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742381650;
	bh=an+WgFVse1usF3HhjsrsWF0AUsRbMPruBabEbqUrhn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q62PP3w3MAh/WaBJlXRJ8dWctS+fuiEntZAhiJHcIy2AVJ0+DVJ0v8Y9FAqjus2au
	 58JOdwqpoo0F+asFxssPNNcE6Ge79SwJQYAXIYsKbP7/uM9osCzXLQHzjqSQrmM0qP
	 n6GUqTiusmNhAkYasUsjvaBH+QdFG/lxHzE516aJeEFqCowaBErwi93I91hxBRrJCm
	 4FtsfGKWM6zscxJjHju94YiVW97PviHJ5amR+HN6aT6KjDnbAWEzgOJGEa8kT0Yv50
	 f3YrzReJS4a8OfkzPRauQYzMZYKsTt/sUUWwO7sm7ksiS7jAxXLTqGrYwqd0Gfrt9f
	 GXILoXDSnPfHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] media: mediatek: vcodec: Fix VP8 stateless decoder smatch warning
Date: Wed, 19 Mar 2025 06:54:07 -0400
Message-Id: <20250319054649-f8a943d9c3ca80af@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250319024937.530352-1-bin.lan.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: b113bc7c0e83b32f4dd2d291a2b6c4803e0a2c44

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Yunfei Dong<yunfei.dong@mediatek.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: dbe5b7373801)

Note: The patch differs from the upstream commit:
---
1:  b113bc7c0e83b ! 1:  7220bc28bdb34 media: mediatek: vcodec: Fix VP8 stateless decoder smatch warning
    @@ Metadata
      ## Commit message ##
         media: mediatek: vcodec: Fix VP8 stateless decoder smatch warning
     
    +    [ Upstream commit b113bc7c0e83b32f4dd2d291a2b6c4803e0a2c44 ]
    +
         Fix a smatch static checker warning on vdec_vp8_req_if.c.
         Which leads to a kernel crash when fb is NULL.
     
    @@ Commit message
         Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
         Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
         Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
    - ## drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c ##
    -@@ drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c: static int vdec_vp8_slice_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
    + ## drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c ##
    +@@ drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c: static int vdec_vp8_slice_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
      	src_buf_info = container_of(bs, struct mtk_video_dec_buf, bs_buffer);
      
      	fb = inst->ctx->dev->vdec_pdata->get_cap_buffer(inst->ctx);
     -	dst_buf_info = container_of(fb, struct mtk_video_dec_buf, frame_buffer);
     +	if (!fb) {
    -+		mtk_vdec_err(inst->ctx, "fb buffer is NULL");
    ++		mtk_vcodec_err(inst, "fb buffer is NULL");
     +		return -ENOMEM;
     +	}
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

