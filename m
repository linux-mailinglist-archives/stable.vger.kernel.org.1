Return-Path: <stable+bounces-14599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EF583818A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E564285803
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6442599;
	Tue, 23 Jan 2024 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l2Fofbly"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02D2114;
	Tue, 23 Jan 2024 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972169; cv=none; b=DL7tdHkKG5z4f9sUSHVrpASxgSbit88HOW+NlmN/i80Ntd/NQEPjLX9FzAR13vFHV9cKIHs9uJOX7dBiVgWmnZ6yUUU4gc+7npr9DddK8CjIKfh/W9G7ZUzkdSXeHk2niLLiYbkgOpJgnuXqQk2DodVxes87Og705mBbrWXslM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972169; c=relaxed/simple;
	bh=GBxiZugJPlgnCVHSaGq/HigkOfC7nbNaS6azTLT/JQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9tRjIUA6dxoQ0VWz2A7iOSvMW6fhGvR/u6cyTLQ7z9S9QJ6Km1R4A0aikFK++WvGj9CuFOSubznDDN0LJpheZveA5JVr5F/cL2iwKW7XyghAduhqJboBzK2Scrw0CkPlkhK7ZNxRetH6sROwKKobijN91pCvlKaZOokL9+296o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l2Fofbly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F7BC433C7;
	Tue, 23 Jan 2024 01:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705972169;
	bh=GBxiZugJPlgnCVHSaGq/HigkOfC7nbNaS6azTLT/JQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l2FofblyROxzNYugcl+vAIdcoxcTLeuMAnq1vrceEnCt0iFRoxuqp3TdCM85nJ9+Y
	 +iWC9e+BpzC+l/gLYiPjwmSYjgPKdNJNku6OJ0lGNm9ppQDiGgTXpqz/8Hdi1dNLS3
	 RX/DFBvXkTOasonpyImwTeWT5PAtwjEgfYpHEGaY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 095/374] crypto: sa2ul - Return crypto_aead_setkey to transfer the error
Date: Mon, 22 Jan 2024 15:55:51 -0800
Message-ID: <20240122235747.908812531@linuxfoundation.org>
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

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit ce852f1308ac738e61c5b2502517deea593a1554 ]

Return crypto_aead_setkey() in order to transfer the error if
it fails.

Fixes: d2c8ac187fc9 ("crypto: sa2ul - Add AEAD algorithm support")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/sa2ul.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index 544d7040cfc5..91ab33690ccf 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -1868,9 +1868,8 @@ static int sa_aead_setkey(struct crypto_aead *authenc,
 	crypto_aead_set_flags(ctx->fallback.aead,
 			      crypto_aead_get_flags(authenc) &
 			      CRYPTO_TFM_REQ_MASK);
-	crypto_aead_setkey(ctx->fallback.aead, key, keylen);
 
-	return 0;
+	return crypto_aead_setkey(ctx->fallback.aead, key, keylen);
 }
 
 static int sa_aead_setauthsize(struct crypto_aead *tfm, unsigned int authsize)
-- 
2.43.0




