Return-Path: <stable+bounces-13040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD33837AB8
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA68AB2D151
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB57312BEB9;
	Tue, 23 Jan 2024 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D2afgtrm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6812A17F;
	Tue, 23 Jan 2024 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968872; cv=none; b=gIL87QtXG2NhZFIFHbYRxdNxeGCmn9SN/v6aSxTIj+8AenZgP1Zamr5w0MIsUyiVs3Abl3ROy/YJ/C4lW7aX9tqnX4jFjTxUVhzkrOa/uWf+zpA5/ezsC6k7DOza2O3l+WtIcTPMELC7xBLWS84TnRBY6007DlZzLm7EDFm0HcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968872; c=relaxed/simple;
	bh=itS5Lkb3qEHt2INGL22kw5ocFF0bMH8O5UnwbTAXbiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxPAK61tcJiih4jgtfX57o5FF+4kOwyzZN72elS803hO3wimIpuSHyxDGnvkvwGxufduutLPPLBMEYmDtexEU2v1nOBEISeJdlRyZtp3/gwqauYTWOtiE37JPjrHCdQ6bMfIauVWSCoNMg8uMGBnoeMgpz730lzwkhkV4cNUM0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D2afgtrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B95C43394;
	Tue, 23 Jan 2024 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968872;
	bh=itS5Lkb3qEHt2INGL22kw5ocFF0bMH8O5UnwbTAXbiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2afgtrm7w7uFHqOVtC6XyH+ULbv+Oh+M7PGRDeFm8ekhN+utPrKCFHdOygyWMiA6
	 09QxOSnVwbF+vutVPu95EmkRsYBolyhJq45mY8ly1lPIOG2F8t+3OZOrnWwJw2lMtz
	 rE2VDo1+VoRoXunof36t5A9fIF9F76SEagMrLeF0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 076/194] crypto: sahara - do not resize req->src when doing hash operations
Date: Mon, 22 Jan 2024 15:56:46 -0800
Message-ID: <20240122235722.494089413@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ovidiu Panait <ovidiu.panait@windriver.com>

[ Upstream commit a3c6f4f4d249cecaf2f34471aadbfb4f4ef57298 ]

When testing sahara sha256 speed performance with tcrypt (mode=404) on
imx53-qsrb board, multiple "Invalid numbers of src SG." errors are
reported. This was traced to sahara_walk_and_recalc() resizing req->src
and causing the subsequent dma_map_sg() call to fail.

Now that the previous commit fixed sahara_sha_hw_links_create() to take
into account the actual request size, rather than relying on sg->length
values, the resize operation is no longer necessary.

Therefore, remove sahara_walk_and_recalc() and simplify associated logic.

Fixes: 5a2bb93f5992 ("crypto: sahara - add support for SHA1/256")
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/sahara.c | 38 ++------------------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
index 0f4bb8574a4a..19186617eafc 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -902,24 +902,6 @@ static int sahara_sha_hw_context_descriptor_create(struct sahara_dev *dev,
 	return 0;
 }
 
-static int sahara_walk_and_recalc(struct scatterlist *sg, unsigned int nbytes)
-{
-	if (!sg || !sg->length)
-		return nbytes;
-
-	while (nbytes && sg) {
-		if (nbytes <= sg->length) {
-			sg->length = nbytes;
-			sg_mark_end(sg);
-			break;
-		}
-		nbytes -= sg->length;
-		sg = sg_next(sg);
-	}
-
-	return nbytes;
-}
-
 static int sahara_sha_prepare_request(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
@@ -956,36 +938,20 @@ static int sahara_sha_prepare_request(struct ahash_request *req)
 					hash_later, 0);
 	}
 
-	/* nbytes should now be multiple of blocksize */
-	req->nbytes = req->nbytes - hash_later;
-
-	sahara_walk_and_recalc(req->src, req->nbytes);
-
+	rctx->total = len - hash_later;
 	/* have data from previous operation and current */
 	if (rctx->buf_cnt && req->nbytes) {
 		sg_init_table(rctx->in_sg_chain, 2);
 		sg_set_buf(rctx->in_sg_chain, rctx->rembuf, rctx->buf_cnt);
-
 		sg_chain(rctx->in_sg_chain, 2, req->src);
-
-		rctx->total = req->nbytes + rctx->buf_cnt;
 		rctx->in_sg = rctx->in_sg_chain;
-
-		req->src = rctx->in_sg_chain;
 	/* only data from previous operation */
 	} else if (rctx->buf_cnt) {
-		if (req->src)
-			rctx->in_sg = req->src;
-		else
-			rctx->in_sg = rctx->in_sg_chain;
-		/* buf was copied into rembuf above */
+		rctx->in_sg = rctx->in_sg_chain;
 		sg_init_one(rctx->in_sg, rctx->rembuf, rctx->buf_cnt);
-		rctx->total = rctx->buf_cnt;
 	/* no data from previous operation */
 	} else {
 		rctx->in_sg = req->src;
-		rctx->total = req->nbytes;
-		req->src = rctx->in_sg;
 	}
 
 	/* on next call, we only have the remaining data in the buffer */
-- 
2.43.0




