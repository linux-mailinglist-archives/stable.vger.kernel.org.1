Return-Path: <stable+bounces-206973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 519DED096D2
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3345330205A1
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546FE35A951;
	Fri,  9 Jan 2026 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g4bem4t4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090CE35A941;
	Fri,  9 Jan 2026 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960732; cv=none; b=Kxrqd/zuCO81s8uN+2duVfINxBbGw6rwsTtavewIPxYyx5slfXaqMgiITxtl4gpmfknp1v22c5JyJ3C+nstGOzPaPmz4mbsaMgQojqI0n05oteGZqdlhxixyjAkrNq2k/X+oMKsCHG6FnI0D03d6vOklxBEQrLqAG6irhDqkBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960732; c=relaxed/simple;
	bh=BRuYznMgKAT9H2HHWW7TywJBnSSp+DU9lglECBxLOWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MO8JS2KhxYmxVcoJytsNw10aGdUcEOSIlh2KgrMrgIgGfaGvYMd7azRBwGPUm5FVI51INeb8W2NxIF4wYl/k6LM6cR9aPpsnFdqzU5trFdMlG4wQBP/Y5D4l5xRXj/8caEPEKV3qvWcvwM79nA7vNGlYb4ZLL0x/ZyYZuRh0GYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g4bem4t4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E29C4CEF1;
	Fri,  9 Jan 2026 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767960731;
	bh=BRuYznMgKAT9H2HHWW7TywJBnSSp+DU9lglECBxLOWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4bem4t4UlrHdogOJTV+Kqo8MKWiG8Fy64gREGTvsSthH8f93sia5j6RCjuKL4yhl
	 hW9R/+FuIfy0ZCl8cDSRm92a+GihX+UWtuwUH5bossOVGzzpAeFxbDoQ593L8S1fsT
	 N282buExoD1Lqm2GpaYG87vXCOKqHhmwsoVOrFQs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiumei Mu <xmu@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 506/737] crypto: seqiv - Do not use req->iv after crypto_aead_encrypt
Date: Fri,  9 Jan 2026 12:40:45 +0100
Message-ID: <20260109112153.028454749@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
References: <20260109112133.973195406@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 50fdb78b7c0bcc550910ef69c0984e751cac72fa ]

As soon as crypto_aead_encrypt is called, the underlying request
may be freed by an asynchronous completion.  Thus dereferencing
req->iv after it returns is invalid.

Instead of checking req->iv against info, create a new variable
unaligned_info and use it for that purpose instead.

Fixes: 0a270321dbf9 ("[CRYPTO] seqiv: Add Sequence Number IV Generator")
Reported-by: Xiumei Mu <xmu@redhat.com>
Reported-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/seqiv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/crypto/seqiv.c b/crypto/seqiv.c
index 17e11d51ddc3..04928df0095b 100644
--- a/crypto/seqiv.c
+++ b/crypto/seqiv.c
@@ -50,6 +50,7 @@ static int seqiv_aead_encrypt(struct aead_request *req)
 	struct aead_geniv_ctx *ctx = crypto_aead_ctx(geniv);
 	struct aead_request *subreq = aead_request_ctx(req);
 	crypto_completion_t compl;
+	bool unaligned_info;
 	void *data;
 	u8 *info;
 	unsigned int ivsize = 8;
@@ -79,8 +80,9 @@ static int seqiv_aead_encrypt(struct aead_request *req)
 			return err;
 	}
 
-	if (unlikely(!IS_ALIGNED((unsigned long)info,
-				 crypto_aead_alignmask(geniv) + 1))) {
+	unaligned_info = !IS_ALIGNED((unsigned long)info,
+				     crypto_aead_alignmask(geniv) + 1);
+	if (unlikely(unaligned_info)) {
 		info = kmemdup(req->iv, ivsize, req->base.flags &
 			       CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL :
 			       GFP_ATOMIC);
@@ -100,7 +102,7 @@ static int seqiv_aead_encrypt(struct aead_request *req)
 	scatterwalk_map_and_copy(info, req->dst, req->assoclen, ivsize, 1);
 
 	err = crypto_aead_encrypt(subreq);
-	if (unlikely(info != req->iv))
+	if (unlikely(unaligned_info))
 		seqiv_aead_encrypt_complete2(req, err);
 	return err;
 }
-- 
2.51.0




