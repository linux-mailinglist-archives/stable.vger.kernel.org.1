Return-Path: <stable+bounces-14847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937758382E1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54134286E84
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C085FDC7;
	Tue, 23 Jan 2024 01:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z1swg/kQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437565FDBB;
	Tue, 23 Jan 2024 01:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974649; cv=none; b=WxyAl34q1e2BamnaLbj77nSwSzEnaRJi8TMv01Nw1q0Z5Oolbe0GLVp7L8KH07mXtgYkxmYlin7AYECJJm9SwwxMJ0Cv7FkaCipoZcXeKAbUoy3qnINo2hadJFWRs29dO3ea4/hck58r5DE5LV3F2NgnkhePxiylYMtgnlJ8sb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974649; c=relaxed/simple;
	bh=EEcn7JEHHpqjS7Gg50C1DxDu/1a/j+3TBFcwpXnJj5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeG1ZdsVskJeAHedo9ANqZxPPmIkL7ziENkm8tLJvGCQhD/IoenYM6s/0cHX6DvumVebtA0Ma936zv4xhlNNm73I+HKeqiwdae4/ZbC35y8erZbigdLA+PibdPDHSW61fzjSkMh0g3xmUi3Fdl1n+H5E4zEyRPNNfCE1Ar1BY+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z1swg/kQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C31C433F1;
	Tue, 23 Jan 2024 01:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974649;
	bh=EEcn7JEHHpqjS7Gg50C1DxDu/1a/j+3TBFcwpXnJj5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z1swg/kQBEqgkSBWXsiOzNYzlo0p4cGNK0Xj12L3R2p0tJj0WiruuyHMTyc15DG5Q
	 NJYlPiCZCdBz4kVB8yvMbOsqEfyZnCN+6+0iRi9N7KMjwxEYn0NS/h9fuYGwAynY7O
	 fBFaJgGG+rNrRxGGkM8hDm1dYIIoVWdXKQ3j/Gms=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 073/583] crypto: sahara - do not resize req->src when doing hash operations
Date: Mon, 22 Jan 2024 15:52:04 -0800
Message-ID: <20240122235814.388678943@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 477b4d8b450d..8e84dd98a273 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -886,24 +886,6 @@ static int sahara_sha_hw_context_descriptor_create(struct sahara_dev *dev,
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
@@ -940,36 +922,20 @@ static int sahara_sha_prepare_request(struct ahash_request *req)
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




