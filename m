Return-Path: <stable+bounces-187869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A063BEDAE3
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 21:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27C358808C
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 19:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684E27F732;
	Sat, 18 Oct 2025 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIin2Oko"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5372D258CD7
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760816560; cv=none; b=bA0DDhhbjvA0b+2zrIEJjZyNBC78gAWXzsEo1rxHihz+CIK2R1BKIrG+Y8T3INR0vpOjNakbPiVpBMpY05dhQZRXZbeB88Yad6dEoQGVI1J9iqO38kXX6vS2IIlyVn4QMIPjcuTyDrs7cItJs7q74XJnOWcuSeDd7pT2lZrtIYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760816560; c=relaxed/simple;
	bh=5iiTdNEgDqSUu/AqeVL2miXbD8ZzmQIKBpVn7ZM4Cxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDR92pdz4AA8iMwPgNvGE8tPzK/fYwbWvjInwdHAYngKNNOcpFxnigsregd1QUIKBeMfUPaPQJjBPq29GcsR88m8BagFJVf6LK6PhMHfSe/znVEjfSz+h2t4J/LaYb/AdXukgoXpEWX9uSEp1HV/vHATKUMjvkw7KevEghBDTWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIin2Oko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF08C4CEF8;
	Sat, 18 Oct 2025 19:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760816559;
	bh=5iiTdNEgDqSUu/AqeVL2miXbD8ZzmQIKBpVn7ZM4Cxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YIin2OkoXfBQccUHtTquBmEgkSXnhV9cQ7PxGhr+zMHlHHdMQFGGNbarsKKZuDmb1
	 qqqYPwxxDmH1nhVcrVASa4rbZJhE7l29MlBYCRFVBedzzkM0oDFgE2kEbnfS529XyX
	 DrSXGprG3Ux4N1UWHF1IZ/shGgcqZRIanJUEPbJEO2VTfHDSUTQ75MCQlGNxdjDgq7
	 vhs0f6pKBr3HLk4TZAAtMSFJcaEJuuErVBJc7pKLTtSgi64x5baBG3Lb6KwA1MVYQe
	 qcLxUsrIxrYNaNwUVmgfxqEmZP1EHfmgajedvRZegUlH+NQ9XCrunWeI///fBt06Oc
	 YDVuphgp0JBMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] crypto: rockchip - Fix dma_unmap_sg() nents value
Date: Sat, 18 Oct 2025 15:42:37 -0400
Message-ID: <20251018194237.892519-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101646-entitle-romp-923e@gregkh>
References: <2025101646-entitle-romp-923e@gregkh>
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


