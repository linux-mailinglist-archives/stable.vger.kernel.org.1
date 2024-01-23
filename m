Return-Path: <stable+bounces-14619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A86E8381A3
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D635528620A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF571EEEA;
	Tue, 23 Jan 2024 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xh1rADfe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79837C;
	Tue, 23 Jan 2024 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972192; cv=none; b=ffmogmtgOcWKGtPx9TaDYAowx0/nm5xBeXiUt470ZhK9far6eoRgKiSvnZhxr5YZpOob1XepDLkQZibsDKoueosELQDnBU1QKo0AeApW7EQHirKyLkCcTU+sYu9ZjZ8CvYpAJQRQZ4M+9oR5XXdrsIU2HitADRf51B6ySItuK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972192; c=relaxed/simple;
	bh=Gu9kSAaBUAp2z8Ixb360pSuxCKgbn6dAhdIlF7vjxw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6bdfSPL6pSTRtQfTz1PhlPmxcYNEIUdsWX8569BB4fpJjAy96YgEFIp2w1dvXO3n6LUv+0XumfRVDFqEWMYfjHHIxeamDP0LTeXhMnCM3uMxMoC7ibhB0ycIvlzvLTcFwL0omZsBccUt3zo4ILP3ZEv/w8tIFDshUpNfnywJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xh1rADfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480E6C433C7;
	Tue, 23 Jan 2024 01:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705972192;
	bh=Gu9kSAaBUAp2z8Ixb360pSuxCKgbn6dAhdIlF7vjxw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xh1rADfeHemqBIViKp0VwbduN3ZsFs8rhV4Jc1MURImmAdjRSezzW/lzZviH5xXig
	 zb/1JJZtMLi/grqxNJG4R0zEBpVikwrVX7lh33NnslVzzeFr0Jj4DUYlFmnygnhpoU
	 ks9E0Se8cwnsegTtbFxU6UFb/PVb3tC1z1x43Uao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 113/374] crypto: sahara - do not resize req->src when doing hash operations
Date: Mon, 22 Jan 2024 15:56:09 -0800
Message-ID: <20240122235748.574314955@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 538beec3b062..b9832978b935 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -887,24 +887,6 @@ static int sahara_sha_hw_context_descriptor_create(struct sahara_dev *dev,
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
@@ -941,36 +923,20 @@ static int sahara_sha_prepare_request(struct ahash_request *req)
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




