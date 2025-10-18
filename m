Return-Path: <stable+bounces-187868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2F4BEDAB9
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 21:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AC8F4EA9EA
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5B82580F9;
	Sat, 18 Oct 2025 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcHrgMZj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62718DB26
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760816227; cv=none; b=BLDemJLYhnUNjrh4/g+C+PpmN4FUKNNekZQBCDBVqoTqucPudOQ9EX3io55pIqek0l1ITBoOXy3WD/+E3Y6MOyzgHsj4+bEAf96kCIQoO0IRheoRaIxODyPMc2UA0G6+RjNtCko/3+ZBjkZVHte+SmpNmMJmct928DnRTNkC8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760816227; c=relaxed/simple;
	bh=5iiTdNEgDqSUu/AqeVL2miXbD8ZzmQIKBpVn7ZM4Cxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKFyg/0/CHp4kQZvvJZtCSQ2Fmrp6mvY7vfDafJ2Eys2EoO1K6uWi7QXePq4b0VnyJDZRNXHkuqWH+T1b5Veky4MAk4yyDXZL7X5wjVadCXM7EHXrCl4SMK6nU6LBoReZ2f7zxDo9AZVOjrkhvkUMd0oWfEzC3t/ieAPY0/wby8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcHrgMZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBF1C4CEF8;
	Sat, 18 Oct 2025 19:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760816227;
	bh=5iiTdNEgDqSUu/AqeVL2miXbD8ZzmQIKBpVn7ZM4Cxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tcHrgMZjZjjQjQbAqY7g6/Fqvoa4v3Dw9rQQO/g4daAtBLbzIR7fy2oQARL+e1G4m
	 6ABm7LCVvHvSBILjPyVFceNVqRjlA/foLjTp9vBMrLO5pm85lDxwaLDC5FnpT/YEdY
	 D/JbxFaZocl7eYq7+ECedaHnZ2ntQeqZHWSb6WGN8P/49+UepzBzEaBmAi/g5TnA7Z
	 EU7icW2bLqr6Ahd+Bwpg5xFqfHEUOMrPkz+r5FkUfb7Xgsuq4i6kqIYyHE2v2xM9dg
	 J+cVq9Qf+oiRR+1l5fHBSxHShhEPTJvOB7bTguMeyn3rNOoVdwjmL5DSxyuC/QSL5y
	 1aKD1eeoMqybg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] crypto: rockchip - Fix dma_unmap_sg() nents value
Date: Sat, 18 Oct 2025 15:37:04 -0400
Message-ID: <20251018193704.891321-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101646-unsent-pull-230d@gregkh>
References: <2025101646-unsent-pull-230d@gregkh>
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


