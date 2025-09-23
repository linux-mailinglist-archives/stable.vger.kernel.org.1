Return-Path: <stable+bounces-181443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CD3B94E54
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 10:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CB5173AB2
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 08:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C5A2F3C07;
	Tue, 23 Sep 2025 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ReoZYFy2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF912F1FE3
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614452; cv=none; b=kdc23eHdCXI5voPSCIE6dcJ4SMfcuQ3CxIaK/pQVtOXUxY0AmxugeekjIRmR6AKLX9TBJyEe0UNodNYha3iqq1Ha5RB25pgnj6WmCBg2fF0XAt4u11RFJqS1Pth7Gc6XhXszftoUeakni2JQubkJ2bMgWeTZT7KxKQm+WON4amo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614452; c=relaxed/simple;
	bh=2Nmv4rZNUfTXcZw7YzLDJ5L6s3/QDtMNlHCYycuCRfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DELnSDNosh/VquobZlPxUX5wCt8IwHTkx4YxvUwnwPiz+kuGEb/psCicY/4UKMiaYH8Q7RvaaoS17olbVKuZE/vfi/OkYqGrstqXswZMpE6ydJb7j0d13ohxYQXGjYmgtxmKhqlnlOHacEy02kC6JLB/WgA8/CMDxN9czgrCPn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ReoZYFy2; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-b54dd647edcso5154867a12.1
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 01:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758614450; x=1759219250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FeQF6j+JjXOV0QRTrdt9GGdX4jZQxW0sWiD25FD7sA=;
        b=NmG37mzUxNcitQbnOp0okhkNtSi5MPnut8K6XJmNEdP3GPOg7e5p58t8RAr28CnExE
         ASfi4j+q47DVUCpeG3b5l+wobhQFSEAplb8ywTIFmv5btgjJB39coq8PtNqwcAxVC86j
         XWJbuT7gzAcNP7mAJxziMeGJcfNtrY5RHB4HetoURg32cXSkPvHqNGxVCctGetLHWax1
         0cXEGY8d7+HMVb59Il+1VQcs0QUC3h9FhQeRLj08sLXh19K7oIjr+ydzDWvvZ9Jv2pmH
         MfZ73cdQlE6XE3WnclRMKAQnORGf4Ht3iXAi6fBxwA2KY+lJMazss/DI0t4P4ZVJ0uJP
         3V4A==
X-Forwarded-Encrypted: i=1; AJvYcCUommPwc23Ih65dzNOaHNX5AHFDi1Nd6viQK0l8cVadv3K5dJtOogUfgGvtbiDnT4zC1jAlR/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWV64e7X9UY6R6J4EP3fXzLBjjdwAFPhWTdnQho4SnM1guv4MX
	30YniOKMFhUEIlqVDi1Rpxx5P+QjG6jllnXXpZx00pxCnpzMzPm+e1lmHN1UxOnxI7FCiSxH2oi
	AhijQrgfbjrkOdFUCvH30XIqV2t5OoFIbVxYGv5V9wq6JLmJv2optBdV3d5ZOSBsG8jB1bD7nEO
	k6v9auKWZN7DwwnQeORMuhWXofNu58luvWczIVaKf/qSg+M818/DUAHggFHi9UuuCtGfNuTkauK
	HsI/yRraVv27l8n9Q==
X-Gm-Gg: ASbGnct9v9orGF6B9NVCkjSTY9qv2p/w/SsOK7ILD9uFtLUvPEdq5ABPbToVstfkMNK
	UqpMtBcuBkWisijjXXzI5koCdto+M1r7w1ddwEGSgCh/utMnyT6EI4P7/t7TNO9kDGpqersqeQ5
	ra3Mfq4PoWwCtdSzmG7weLrh/dEG2s4d+4IGl9lu59WnFPsgWs0KthyYbhZ73frA1QalRfzW4l0
	0MkKug8WiX2J+2WQ6ykDk1pwizSp/7xxFb7awr+/kBdX+QbC2EwVdijwwMWBaJkwEaCKKzp8bQ4
	vyYOpR00TdzFB6b04tDZ0wdnOITkYj5Gx24TPJ5cmN4pnbpWW7TbHUiU98Wm2d2rVshyZxCetrd
	lDb/Zp2NFCGltZ7PeNcoqtBsXZnI9mu5B93+zeXz7XyovjteaTEOiQWHHUfOzro3OFg/JeVxb8Y
	58dQA=
X-Google-Smtp-Source: AGHT+IEkCEzCmkaNws5uZVB2idNvFHx+qcFPX5CVyJ2VPAK86/q6WMC/jntVFQclTb3S6trYW0a2uN4OwHAI
X-Received: by 2002:a17:903:8c6:b0:269:82a5:fa19 with SMTP id d9443c01a7336-27cc61bed26mr22253375ad.45.1758614450341;
        Tue, 23 Sep 2025 01:00:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2697f73def8sm10049455ad.0.2025.09.23.01.00.49
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 01:00:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2698b5fbe5bso65865995ad.0
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758614448; x=1759219248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6FeQF6j+JjXOV0QRTrdt9GGdX4jZQxW0sWiD25FD7sA=;
        b=ReoZYFy2ZLsMXQXwlcA4zdb0MJseA0BsoCWJBVAUcQ3fHZIwm2/J4Gpna3RbGJHcud
         PwmuCGoW6BGxauHCyUXAwz6lSLQO6uX4rVb4MPvcU+sJRLHCbnsPuhg7TbOHavKqcG0P
         FGtI6DDns/rCSUpO24la12nOBzEOPpmWTNa34=
X-Forwarded-Encrypted: i=1; AJvYcCViLUuzy2dC9ZOInSLJRwlK14UT8WOuLvGoOrFn1ai/l6TY/QK17z8HJvFo5Z3PKK554ZBs+X4=@vger.kernel.org
X-Received: by 2002:a17:902:ce03:b0:278:9051:8e9c with SMTP id d9443c01a7336-27cc61b8c8dmr20437135ad.42.1758614448160;
        Tue, 23 Sep 2025 01:00:48 -0700 (PDT)
X-Received: by 2002:a17:902:ce03:b0:278:9051:8e9c with SMTP id d9443c01a7336-27cc61b8c8dmr20436885ad.42.1758614447798;
        Tue, 23 Sep 2025 01:00:47 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033d788sm154912015ad.127.2025.09.23.01.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:00:47 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	smueller@chronox.de,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	srinidhi.rao@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH] crypto: zero initialize memory allocated via sock_kmalloc
Date: Tue, 23 Sep 2025 00:45:15 -0700
Message-Id: <20250923074515.295899-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Several crypto user API contexts and requests allocated with
sock_kmalloc() were left uninitialized, relying on callers to
set fields explicitly. This resulted in the use of uninitialized
data in certain error paths or when new fields are added in the
future.

The ACVP patches also contain two user-space interface files:
algif_kpp.c and algif_akcipher.c. These too rely on proper
initialization of their context structures.

A particular issue has been observed with the newly added
'inflight' variable introduced in af_alg_ctx by commit:

  67b164a871af ("crypto: af_alg - Disallow multiple in-flight AIO requests")

Because the context is not memset to zero after allocation,
the inflight variable has contained garbage values. As a result,
af_alg_alloc_areq() has incorrectly returned -EBUSY randomly when
the garbage value was interpreted as true:

  https://github.com/gregkh/linux/blame/master/crypto/af_alg.c#L1209

The check directly tests ctx->inflight without explicitly
comparing against true/false. Since inflight is only ever set to
true or false later, an uninitialized value has triggered
-EBUSY failures. Zero-initializing memory allocated with
sock_kmalloc() ensures inflight and other fields start in a known
state, removing random issues caused by uninitialized data.

Fixes: fe869cdb89c9 ("crypto: algif_hash - User-space interface for hash operations")
Fixes: 5afdfd22e6ba ("crypto: algif_rng - add random number generator support")
Fixes: 2d97591ef43d ("crypto: af_alg - consolidation of duplicate code")
Fixes: 99bd99d3e3a7 ("crypto: algif_skcipher - Fix stream cipher chaining")
Fixes: 67b164a871af ("crypto: af_alg - Disallow multiple in-flight AIO requests")
Cc: stable@vger.kernel.org
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 crypto/af_alg.c         | 5 ++---
 crypto/algif_hash.c     | 3 +--
 crypto/algif_rng.c      | 3 +--
 crypto/algif_skcipher.c | 1 +
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index ca6fdcc6c54a..6c271e55f44d 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1212,15 +1212,14 @@ struct af_alg_async_req *af_alg_alloc_areq(struct sock *sk,
 	if (unlikely(!areq))
 		return ERR_PTR(-ENOMEM);
 
+	memset(areq, 0, areqlen);
+
 	ctx->inflight = true;
 
 	areq->areqlen = areqlen;
 	areq->sk = sk;
 	areq->first_rsgl.sgl.sgt.sgl = areq->first_rsgl.sgl.sgl;
-	areq->last_rsgl = NULL;
 	INIT_LIST_HEAD(&areq->rsgl_list);
-	areq->tsgl = NULL;
-	areq->tsgl_entries = 0;
 
 	return areq;
 }
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index e3f1a4852737..4d3dfc60a16a 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -416,9 +416,8 @@ static int hash_accept_parent_nokey(void *private, struct sock *sk)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->result = NULL;
+	memset(ctx, 0, len);
 	ctx->len = len;
-	ctx->more = false;
 	crypto_init_wait(&ctx->wait);
 
 	ask->private = ctx;
diff --git a/crypto/algif_rng.c b/crypto/algif_rng.c
index 10c41adac3b1..1a86e40c8372 100644
--- a/crypto/algif_rng.c
+++ b/crypto/algif_rng.c
@@ -248,9 +248,8 @@ static int rng_accept_parent(void *private, struct sock *sk)
 	if (!ctx)
 		return -ENOMEM;
 
+	memset(ctx, 0, len);
 	ctx->len = len;
-	ctx->addtl = NULL;
-	ctx->addtl_len = 0;
 
 	/*
 	 * No seeding done at that point -- if multiple accepts are
diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index 125d395c5e00..f4ce5473324f 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -70,6 +70,7 @@ static int algif_skcipher_export(struct sock *sk, struct skcipher_request *req)
 	if (!ctx->state)
 		return -ENOMEM;
 
+	memset(ctx->state, 0, statesize);
 	err = crypto_skcipher_export(req, ctx->state);
 	if (err) {
 		sock_kzfree_s(sk, ctx->state, statesize);
-- 
2.40.4


