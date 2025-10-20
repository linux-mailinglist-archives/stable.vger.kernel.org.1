Return-Path: <stable+bounces-188192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF660BF262F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BE514F7A90
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C60285CB6;
	Mon, 20 Oct 2025 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrYhsZaU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69223E33D
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977426; cv=none; b=l1pzU+vyCnoGtnYHEHgRtMyatc3w1LGGSPpvv5G0/XgJng9/fS5R4moIoCptPy5HgsQsfMa3T5RIvy3CazP9MKsHchHD4D3l9zI5jgEomD47GxRGLHhCwBu7XIOBMFYC/gDRbV55sJIHXQhmBv3dUkxCOavlfAW6TNaYlgY7W4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977426; c=relaxed/simple;
	bh=5iiTdNEgDqSUu/AqeVL2miXbD8ZzmQIKBpVn7ZM4Cxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDvJRfN8xKWYxskcHdP6ZnP2qTFzA5+7jQYqmvwZzw6BIamLuzF+aoYNOT2UJxfhkE/MJfN0v2/iyUzMSCSPcHNeotjUqCtM8OWnhenUaJWnKrDA/aa8rYBLiBm2HMbGP7TLS63tQRyspiH0sTHoCakIZGyXRdY8Aqd+gL+ZUNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrYhsZaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACF1C4CEF9;
	Mon, 20 Oct 2025 16:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977426;
	bh=5iiTdNEgDqSUu/AqeVL2miXbD8ZzmQIKBpVn7ZM4Cxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nrYhsZaUJuMad97hNFc4m87HNvo0DkVc++qCATf0k6sqR9jhMuP9HJgDuCfegzpdQ
	 5aOS2PhhdB0SCKdqRheHYaV/UUeswqirejkG++4VtzfJVzdSV+75+oPujKsNuN7YhR
	 cm2se3xz1wGwo1JC2KEOR4ystyfX6R3oqj+FfXxd7qB8SAokEhyVRsbi7RqdKYh0Pf
	 mlE6fvmcuWBq7BOb6phScUmhgRzkn3+i75HA7NhTYDlWPkKLiXNfUFblWRQtqXeAnC
	 o7fimYroO6AhHZv4308GPFR4qTamg/uYdLPLGwwhDANtL1DmI2r9bjPmqY1dmHEv38
	 aDqUKVEP4ISRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] crypto: rockchip - Fix dma_unmap_sg() nents value
Date: Mon, 20 Oct 2025 12:23:42 -0400
Message-ID: <20251020162342.1837833-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101647-olive-sheet-88ec@gregkh>
References: <2025101647-olive-sheet-88ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit 21140e5caf019e4a24e1ceabcaaa16bd693b393f ]

The dma_unmap_sg() functions should be called with the same nents as the
dma_map_sg(), not the value the map function returned.

Fixes: 57d67c6e8219 ("crypto: rockchip - rework by using crypto_engine")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ removed unused rctx variable declaration since device pointer already came from tctx->dev->dev instead of rctx->dev ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index edd40e16a3f0a..087b7c41c58da 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -236,10 +236,9 @@ static int rk_hash_unprepare(struct crypto_engine *engine, void *breq)
 {
 	struct ahash_request *areq = container_of(breq, struct ahash_request, base);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
-	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
 	struct rk_ahash_ctx *tctx = crypto_ahash_ctx(tfm);
 
-	dma_unmap_sg(tctx->dev->dev, areq->src, rctx->nrsg, DMA_TO_DEVICE);
+	dma_unmap_sg(tctx->dev->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
 	return 0;
 }
 
-- 
2.51.0


