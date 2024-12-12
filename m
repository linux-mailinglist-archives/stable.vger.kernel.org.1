Return-Path: <stable+bounces-102628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 925D09EF2DB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7FC287CCC
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1C5236926;
	Thu, 12 Dec 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ai5vFRLy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5EB235C5E;
	Thu, 12 Dec 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021909; cv=none; b=Ao7XYzzaxZ36zWCe+zHT5rrnon0KnKQ2+0ZIyXfJ9UxfNaLwpuQiNbH291dAyW+sgP1sxMymmaiKAqC6B0Tc/Qgu4KML/EGyhor6rYMTgPur/DWbPS+M43Cxlrj/ZO2spHdEXEjQAzt2Nh/nRjIdXr6xH3vQZ+Q4K2WeZbOC4hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021909; c=relaxed/simple;
	bh=J2lB091Y+m34Wd4VBLQeBtS/iNmST9Ye6lNrCfV+u28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9VLRQ7D8M6cyhOFVRHD0q3/UTM72gTieAPoL7ejFjQXMvY/ySfjbE4rkYzu3uZ2OYI15Li8qf7lv0Bg/XSFnV/JqCmViesIv1XtfGNAtQPPHj2QXufMdz3mrHzU4D0R2Xwa9gEUFTqKICHXzxzMNIdZ+lWzGilt/z/tLeOg+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ai5vFRLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BAAC4CECE;
	Thu, 12 Dec 2024 16:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021908;
	bh=J2lB091Y+m34Wd4VBLQeBtS/iNmST9Ye6lNrCfV+u28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ai5vFRLyw2XrrWVk2Jz7DUPX8SD1GTc277OZi9IJ+FYf63QnN0iWQ6LA5zrdoINB5
	 fEVXwApdjjt+2tCTgZ0gfu1C/NkDcL8Au+Vzul+/ha3RzWqaMBqq/5dl2Jgyivq+oV
	 88S/25Hf13BvXam2c+SH7eDMBmkxq48I/9jLrbfU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yi Yang <yiyang13@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 097/565] crypto: pcrypt - Call crypto layer directly when padata_do_parallel() return -EBUSY
Date: Thu, 12 Dec 2024 15:54:52 +0100
Message-ID: <20241212144315.321000465@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

From: Yi Yang <yiyang13@huawei.com>

[ Upstream commit 662f2f13e66d3883b9238b0b96b17886179e60e2 ]

Since commit 8f4f68e788c3 ("crypto: pcrypt - Fix hungtask for
PADATA_RESET"), the pcrypt encryption and decryption operations return
-EAGAIN when the CPU goes online or offline. In alg_test(), a WARN is
generated when pcrypt_aead_decrypt() or pcrypt_aead_encrypt() returns
-EAGAIN, the unnecessary panic will occur when panic_on_warn set 1.
Fix this issue by calling crypto layer directly without parallelization
in that case.

Fixes: 8f4f68e788c3 ("crypto: pcrypt - Fix hungtask for PADATA_RESET")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/pcrypt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index 005a36cb21bc4..2d7f98709e97c 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -117,8 +117,10 @@ static int pcrypt_aead_encrypt(struct aead_request *req)
 	err = padata_do_parallel(ictx->psenc, padata, &ctx->cb_cpu);
 	if (!err)
 		return -EINPROGRESS;
-	if (err == -EBUSY)
-		return -EAGAIN;
+	if (err == -EBUSY) {
+		/* try non-parallel mode */
+		return crypto_aead_encrypt(creq);
+	}
 
 	return err;
 }
@@ -166,8 +168,10 @@ static int pcrypt_aead_decrypt(struct aead_request *req)
 	err = padata_do_parallel(ictx->psdec, padata, &ctx->cb_cpu);
 	if (!err)
 		return -EINPROGRESS;
-	if (err == -EBUSY)
-		return -EAGAIN;
+	if (err == -EBUSY) {
+		/* try non-parallel mode */
+		return crypto_aead_decrypt(creq);
+	}
 
 	return err;
 }
-- 
2.43.0




