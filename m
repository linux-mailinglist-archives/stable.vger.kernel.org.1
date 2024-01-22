Return-Path: <stable+bounces-13071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0A5837B9C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D30B238E1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C3C12C53C;
	Tue, 23 Jan 2024 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kjfP+Hwv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816EF12BF3D;
	Tue, 23 Jan 2024 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968932; cv=none; b=jz2h9YHXJnTnVW1d44R8mSS73KDFFJjSRw20It0KjAK1J3gBDDIEFQfe/xNgGd7cC5keMWWdRfKfAQ2XjUx0Dx8Tt6R4pKIp59jt2BDg9uRVJtNOjd8d+KB+jonx6Vo1KVKfb7mn54CKZ28fX4boSgETEA8hBtg1CWhRxRN5AYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968932; c=relaxed/simple;
	bh=hs6PH4WQwvjzE+ANGRBoy0NfYFMcTpZ+WCaGuOmPARY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFsKCpSDB2PeEcNFhX5PlyFzMsAYyCnTyz2zRU7pUwnU45aAtMeF/jUstmBXeEKdNQHyByevUuHDL4xOHt20V6RfgF4vOGvxHmRsbdhuLsKA6XGkB+CYn/C+lFZy2e0HwCSkLne9BEfv1I4Qn42WR73E76LqIKs89tKnGSoxRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kjfP+Hwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A48C43394;
	Tue, 23 Jan 2024 00:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968932;
	bh=hs6PH4WQwvjzE+ANGRBoy0NfYFMcTpZ+WCaGuOmPARY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjfP+HwvUdHQ5bCwqx6lpLK9U3n9GSek7okibj3Nkm8LQ+J6BhTEKqGod/adqMn6D
	 fAQt5c4ChBEZ6Ia7fh0668LT1jAxG2QSP3ehu0Y3+Kye2N/eiugChRat7tFDF7Q9Y5
	 MQcKD1do0aUYffEzIvLfimtcd2MpZ6MUWL1js3oo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 073/194] crypto: sahara - fix wait_for_completion_timeout() error handling
Date: Mon, 22 Jan 2024 15:56:43 -0800
Message-ID: <20240122235722.366782752@linuxfoundation.org>
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

[ Upstream commit 2dba8e1d1a7957dcbe7888846268538847b471d1 ]

The sg lists are not unmapped in case of timeout errors. Fix this.

Fixes: 5a2bb93f5992 ("crypto: sahara - add support for SHA1/256")
Fixes: 5de8875281e1 ("crypto: sahara - Add driver for SAHARA2 accelerator.")
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/sahara.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
index 1284991cd40d..7d24e802d382 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -580,16 +580,17 @@ static int sahara_aes_process(struct ablkcipher_request *req)
 
 	timeout = wait_for_completion_timeout(&dev->dma_completion,
 				msecs_to_jiffies(SAHARA_TIMEOUT_MS));
-	if (!timeout) {
-		dev_err(dev->device, "AES timeout\n");
-		return -ETIMEDOUT;
-	}
 
 	dma_unmap_sg(dev->device, dev->out_sg, dev->nb_out_sg,
 		DMA_FROM_DEVICE);
 	dma_unmap_sg(dev->device, dev->in_sg, dev->nb_in_sg,
 		DMA_TO_DEVICE);
 
+	if (!timeout) {
+		dev_err(dev->device, "AES timeout\n");
+		return -ETIMEDOUT;
+	}
+
 	return 0;
 }
 
@@ -1023,15 +1024,16 @@ static int sahara_sha_process(struct ahash_request *req)
 
 	timeout = wait_for_completion_timeout(&dev->dma_completion,
 				msecs_to_jiffies(SAHARA_TIMEOUT_MS));
-	if (!timeout) {
-		dev_err(dev->device, "SHA timeout\n");
-		return -ETIMEDOUT;
-	}
 
 	if (rctx->sg_in_idx)
 		dma_unmap_sg(dev->device, dev->in_sg, dev->nb_in_sg,
 			     DMA_TO_DEVICE);
 
+	if (!timeout) {
+		dev_err(dev->device, "SHA timeout\n");
+		return -ETIMEDOUT;
+	}
+
 	memcpy(rctx->context, dev->context_base, rctx->context_size);
 
 	if (req->result && rctx->last)
-- 
2.43.0




