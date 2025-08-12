Return-Path: <stable+bounces-167400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6668BB22FF9
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3E0188B4FC
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231212FDC2B;
	Tue, 12 Aug 2025 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YYNwvFD4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E122FD1B2;
	Tue, 12 Aug 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020690; cv=none; b=KZ4aP24Impp37TT1Dwhsh8fOdwUQxKjBLWvsGihhmIgjYweIT3q7F7rLlPoNS+OgsOaW2win8aGc3XxqBeq0Ymhzr6KJJCq4ZFOVyQph8DYgrjLbZKU+xNhy0ORPVWRjo+GJuljrTLZ79ITk2OaOvbQYMOALQleCWRjFJ81nEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020690; c=relaxed/simple;
	bh=S9X51xQMjqZ3KusggN8JNUHu35sXHCqdFQSDR97YB4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ei70rch+LxJ5ld0kuhGDuzGbUouy9AGo16uOwtcoqTdFPQG1S+yCAP82vljPGdTCQG595LnG93Kj5cC90k+bKnSRPt+tjOTxM0Zw/73SCALEfXwL3jJS6v1LcmLfNgWeGDUYDnaUfDjZmnnqLpDkshIZnHjPlFZCHPH4byEPE0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YYNwvFD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFA0C4CEF7;
	Tue, 12 Aug 2025 17:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020690;
	bh=S9X51xQMjqZ3KusggN8JNUHu35sXHCqdFQSDR97YB4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYNwvFD4KF046mOxpEE3drbKuSaxbxaxO0HU9A6NiyeEzm7+RQbHwTb1qwfhnjycX
	 IyOMhl//LBTt1KxeWPbsZH6stulJToCiXVV+soPllItV4RskwL8uP0A0ghb/WKarII
	 O+UyH/0bRF9pNgtbV3uRJiezq3yvozwQXS2WC0LM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Antoine Tenart <atenart@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 154/253] crypto: inside-secure - Fix `dma_unmap_sg()` nents value
Date: Tue, 12 Aug 2025 19:29:02 +0200
Message-ID: <20250812172955.273051026@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit cb7fa6b6fc71e0c801e271aa498e2f19e6df2931 ]

The `dma_unmap_sg()` functions should be called with the same nents as the
`dma_map_sg()`, not the value the map function returned.

Fixes: c957f8b3e2e5 ("crypto: inside-secure - avoid unmapping DMA memory that was not mapped")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Reviewed-by: Antoine Tenart <atenart@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/inside-secure/safexcel_hash.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index ecf64cc35fff..08227d44a27b 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -249,7 +249,9 @@ static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv,
 	safexcel_complete(priv, ring);
 
 	if (sreq->nents) {
-		dma_unmap_sg(priv->dev, areq->src, sreq->nents, DMA_TO_DEVICE);
+		dma_unmap_sg(priv->dev, areq->src,
+			     sg_nents_for_len(areq->src, areq->nbytes),
+			     DMA_TO_DEVICE);
 		sreq->nents = 0;
 	}
 
@@ -497,7 +499,9 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 			 DMA_FROM_DEVICE);
 unmap_sg:
 	if (req->nents) {
-		dma_unmap_sg(priv->dev, areq->src, req->nents, DMA_TO_DEVICE);
+		dma_unmap_sg(priv->dev, areq->src,
+			     sg_nents_for_len(areq->src, areq->nbytes),
+			     DMA_TO_DEVICE);
 		req->nents = 0;
 	}
 cdesc_rollback:
-- 
2.39.5




