Return-Path: <stable+bounces-33079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B0988FF2F
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 13:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9842F281FEB
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 12:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D9C7FBC1;
	Thu, 28 Mar 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TRBLHyWT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDDF7F46E
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629548; cv=none; b=gR5DsEm/9oquTIk7KriigGZUubvlaPAOsQgoJBMVxDQHY1xw+C1/1zhezbnSPkzeBv6Ajw8dUYDfrdCKZfue5GDzidXU23aZCKo0mGVB0rlT0foDLCWkmlAbXRlenyQQRkUYF1Apvl4Q97ei1ks9nsjxFqbsuAWtfPZgjJ0ZWG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629548; c=relaxed/simple;
	bh=LhEmO1/QpTYLcqhWQ1oIVDE/05mjh3QmxpGCsp1Ngzo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ocCDrGkSCiiQ/kguM4Ma+DtPxGKoFG0L/sWh6aS0j3jFiOJ274N72P9/Xdzfiz5nznoW3hhgVE97QpHuPr1lvO9pbeYSyR6zUpF+r3PbaBuj+VRMuqhqfeV/9hVeNB0hW90nsVcjduF3gCG5OCEu6DqxQ1m5q8942S1M3+A9P5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TRBLHyWT; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-5e152c757a5so554199a12.2
        for <stable@vger.kernel.org>; Thu, 28 Mar 2024 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711629546; x=1712234346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GCsDnnNASp8ef4/b0tg4ZDvexLdNUsjbgwDUzBJT2lQ=;
        b=TRBLHyWTuhizE0v9jZ9LJjAkCslFZU0nNY6VZxFSmVSB3pu/aXcoslaYio6Qq5VT4m
         VjchB21Hmjo68kTZCFNDQqk85a+1TRj1liQZKq2PFHiUzazuBptnQy3miTXCfu0sFa1k
         pP04bmUSB/fWKNNXSrthHVU8n7qqZe6H2AZLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629546; x=1712234346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCsDnnNASp8ef4/b0tg4ZDvexLdNUsjbgwDUzBJT2lQ=;
        b=e6+p4M3tLC8+vBHXU1YN+/Ydoeqfp2prVU9pd7YpeRxX1Ti075ETtOTrYO6UGNAmeV
         RI622iJeGu7EVUpx5/Tb8vfhJjzSNbcqUkwvzg7C9hvN0VOmABUglxfK51F9FrN13lfl
         MQUORXX7o3JNC0ItEbyo8povFcM3UPNdbIsNlXjVCvqSyLak0ubhMrkPgUo+eNqWAebV
         8IwJZHQAi2gVwiZufy/PVHysx8GmVQ0fP07dlfEeOeypCBnxOANn/htjd7p6nGRtguU1
         o6zj9n2yUWFGCZMr5nwskhHuUkfq/6dzVY1Fy4mH2nnL2S848BurwkYo+iiaJhKy450B
         +Stw==
X-Gm-Message-State: AOJu0Yzawx3edmOcXVL9uNRCm9sEfHAt5au88fSv5xIYuhiLHKQTx6IA
	ILxGSoYWkZbqM7yQ/NxRo9AV9slai/JfwkC3kmpkEFn5soFI79EnBMtLc1ZKxY/0aSQm5Z8ntAt
	39KZnm0vhtaypCyUTcuapeqns8wbV2HXkn0S3KEbMqD4cLCgccbQnzbT3eH7B4XQRryWogm4J7K
	jNiBOylHy/R0isyWjuSXbVKn5nIcsE5V/+AhvLqJM475Xvw2Qe725Y+g==
X-Google-Smtp-Source: AGHT+IGIRxGSrxYY3VCs5Jj9rn9qLfuCbkVocf3OMBUZsTxdS3k81sJrbt3PnRXofn/Pb2GTq6PCKA==
X-Received: by 2002:a05:6a20:7346:b0:1a5:6f7e:3b81 with SMTP id v6-20020a056a20734600b001a56f7e3b81mr1346855pzc.41.1711629545458;
        Thu, 28 Mar 2024 05:39:05 -0700 (PDT)
Received: from srish-ubuntu-desktop.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id a18-20020aa780d2000000b006e6cc93381esm1256685pfn.125.2024.03.28.05.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:39:05 -0700 (PDT)
From: Srish Srinivasan <srish.srinivasan@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vakul.garg@nxp.com,
	davejwatson@fb.com,
	netdev@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Srish Srinivasan <srish.srinivasan@broadcom.com>
Subject: [PATCH 6.1.y] net: tls: handle backlogging of crypto requests
Date: Thu, 28 Mar 2024 18:08:05 +0530
Message-Id: <20240328123805.3886026-1-srish.srinivasan@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

commit 8590541473188741055d27b955db0777569438e3 upstream

Since we're setting the CRYPTO_TFM_REQ_MAY_BACKLOG flag on our
requests to the crypto API, crypto_aead_{encrypt,decrypt} can return
 -EBUSY instead of -EINPROGRESS in valid situations. For example, when
the cryptd queue for AESNI is full (easy to trigger with an
artificially low cryptd.cryptd_max_cpu_qlen), requests will be enqueued
to the backlog but still processed. In that case, the async callback
will also be called twice: first with err == -EINPROGRESS, which it
seems we can just ignore, then with err == 0.

Compared to Sabrina's original patch this version uses the new
tls_*crypt_async_wait() helpers and converts the EBUSY to
EINPROGRESS to avoid having to modify all the error handling
paths. The handling is identical.

Fixes: a54667f6728c ("tls: Add support for encryption using async offload accelerator")
Fixes: 94524d8fc965 ("net/tls: Add support for async decryption of tls records")
Co-developed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/netdev/9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Srish: fixed merge-conflict in stable branch linux-6.1.y,
needs to go on top of https://lore.kernel.org/stable/20240307155930.913525-1-lee@kernel.org/]
Signed-off-by: Srish Srinivasan <srish.srinivasan@broadcom.com>
---
 net/tls/tls_sw.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 2bd27b777..61b01dfc6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -195,6 +195,17 @@ static void tls_decrypt_done(crypto_completion_data_t *data, int err)
 	struct sock *sk;
 	int aead_size;
 
+	/* If requests get too backlogged crypto API returns -EBUSY and calls
+	 * ->complete(-EINPROGRESS) immediately followed by ->complete(0)
+	 * to make waiting for backlog to flush with crypto_wait_req() easier.
+	 * First wait converts -EBUSY -> -EINPROGRESS, and the second one
+	 * -EINPROGRESS -> 0.
+	 * We have a single struct crypto_async_request per direction, this
+	 * scheme doesn't help us, so just ignore the first ->complete().
+	 */
+	if (err == -EINPROGRESS)
+		return;
+
 	aead_size = sizeof(*aead_req) + crypto_aead_reqsize(aead);
 	aead_size = ALIGN(aead_size, __alignof__(*dctx));
 	dctx = (void *)((u8 *)aead_req + aead_size);
@@ -268,6 +279,10 @@ static int tls_do_decryption(struct sock *sk,
 	}
 
 	ret = crypto_aead_decrypt(aead_req);
+	if (ret == -EBUSY) {
+		ret = tls_decrypt_async_wait(ctx);
+		ret = ret ?: -EINPROGRESS;
+	}
 	if (ret == -EINPROGRESS) {
 		if (darg->async)
 			return 0;
@@ -452,6 +467,9 @@ static void tls_encrypt_done(crypto_completion_data_t *data, int err)
 	bool ready = false;
 	struct sock *sk;
 
+	if (err == -EINPROGRESS) /* see the comment in tls_decrypt_done() */
+		return;
+
 	rec = container_of(aead_req, struct tls_rec, aead_req);
 	msg_en = &rec->msg_encrypted;
 
@@ -560,6 +578,10 @@ static int tls_do_encryption(struct sock *sk,
 	atomic_inc(&ctx->encrypt_pending);
 
 	rc = crypto_aead_encrypt(aead_req);
+	if (rc == -EBUSY) {
+		rc = tls_encrypt_async_wait(ctx);
+		rc = rc ?: -EINPROGRESS;
+	}
 	if (!rc || rc != -EINPROGRESS) {
 		atomic_dec(&ctx->encrypt_pending);
 		sge->offset -= prot->prepend_size;
-- 
2.34.1

