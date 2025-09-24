Return-Path: <stable+bounces-181572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68149B985E9
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 08:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF50A16841A
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 06:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA1421C16E;
	Wed, 24 Sep 2025 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PkYXkjMN"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA38188715
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758694655; cv=none; b=NQNQBzE7CFscizvqeAyW0xx/DqMCSXNand5dUIyGyoZN6/PNJYMybq1dcAvb5xY9x+qHauOPl+ohyKNcBUGFxRaG6qKvpaVCyRZzToDdZe1fspnUNaIhPruK17fPNN9QX23zrqBbJlGSPChSng5QejJttGZD0D8wWYIeVZW9xdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758694655; c=relaxed/simple;
	bh=PckVkjVIHmHqtDvxZzcDiEQw5wOKZpgKyeDyTLIwb9o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p+Uct2DYlNMt05VYLuHtdaY47er1rGThlcwYV6sWi7OVbotKygxMoxUOaOIE+3GPIi6RKW9RPOgk72vsqfvn01/XU0HiW6+0hydqny1BsAe5pF9SHdSfq1NxZW4HFr+9TmiGEVVDA/bHOPvN3yso03RqqmNZGYwfGH2kkenoszw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PkYXkjMN; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-78ed682e9d3so56615306d6.0
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 23:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758694652; x=1759299452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymWB1hrEQwy+qhGGeeTAshnrOMJoU7hn+WhGD+V50Sw=;
        b=bXUQhZITggWxggDGYxbwm+teE5lJ6L4ci1BeT6MQnA39iLyj/C4loSi8UzdT+/Zzvr
         zI9WtFaugqvgml2FetV0glXwfP7hz9b3XZeYkAv1CEwqc8w6jhR9/Z3tlnvLCoi4l2Ua
         6uyocmK1R2Zwxt9Nala1YjdXNQu/YLFa/9zfHSJ0LNxDzF+SfgFGWreyhbVhTL3htgoz
         44BqslINQTh2fGMSLQm7GgtFTMnpVrVyeWvFLNAOt1facB6k/Bx0FLOD059k1BLE4L44
         MvrK9AqggjfpQIQplw5476hD5z0pGlMVb5SN8qPTSq4rL6qPUZ1eALcImdiXa0zssv3p
         CcYA==
X-Forwarded-Encrypted: i=1; AJvYcCVzF7q1bVpHT+0sR44NfDwOB/oZQFgqjrMcm6hn78a9cn9uAmjRWsn5QMAt7C1mWC0n5DWok0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZkT3bWGtXTa1HtvVo+U4PiXt0fQQ9FktJKJOpm/Lg/Sq6+plz
	BXT5uEXKJx5oOvhYTxGekceGzXSowhO/msqxu0fzusA60yLiCwkq23DAsmSxLY8P5zFp5GPY2mT
	b5EoVcVjD3U/Zq3HF7Na/mgRdSVNx/0c1hnUi+QXH/SiC0TUkzyQn/iqifjqcXk6Ibiy1nX8sG4
	LsMW0a0Xfz+OYByxPFgBiOTjcKQtiJsy060K43it1hvPvkO5q7V+zYREJW7mPBQm2EqgW9RM2bp
	Lg7PQssCjqdyHeZsA==
X-Gm-Gg: ASbGncs8HJOa8qH+pqD2aRn2IOA6mIHQ6C9eZOjJpQnPFjbQJsgLgx+iW50CmRE47MO
	zb/tZxwqdZjyIY973uMvtGoS4Is7D10LVa6CiBMmCBaBjCPXh3Y2wn9H70xmJylsnOiJXWQWeIo
	MMYj43JgvjdLYM+VplE5obof82BVgjeDqP25rWOAj8DpxEJ2dkcWG0s2PQddceDd8e7UTgstBGL
	H1eenIhtga2ecW1J3Ms2AACIPByRgN/d48s8AI+acH3KedcCQG5Gy1WuAQFhVeIzHuMz8L0DbYE
	M+5NpF+pzxbC40shHOHdEccp0rVneaLlSxHp9crtklgxNxU+ZBdx4zZgFQcsRH/VTZ0BKmVC1tx
	4RIjPygLB24bLbEl5BkY6keVjxsbZZx+EwZcFcaEQaRseNivjO+VNqntUqci5emN/HHkJCs5w2h
	9NPZFJdg==
X-Google-Smtp-Source: AGHT+IGJ8gtJH5cm1n3Q3kFS3PTK22S7xPQ+EQ/cI8tdl1I79gOE6Df6J2fLwxrqnxplfatcRUZ8EEK5JwYf
X-Received: by 2002:ad4:5ce9:0:b0:7e3:4084:fcbe with SMTP id 6a1803df08f44-7e70381d7camr75422656d6.19.1758694652418;
        Tue, 23 Sep 2025 23:17:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-79343dfe02bsm10424036d6.9.2025.09.23.23.17.32
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 23:17:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-329cb4c3f78so5591239a91.2
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 23:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758694651; x=1759299451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ymWB1hrEQwy+qhGGeeTAshnrOMJoU7hn+WhGD+V50Sw=;
        b=PkYXkjMNesfU/mxfWVIa/hbHW4oLg7kyyYzpmI0J9nfPQykIxCj/lZYBpugmTGy+f/
         UYgIMKZin9obQnHTGQHtNUAIPz6JATT4qKt2ID0b5c8Vq3Tp8q8FpCUCnBFWLqcJ/E7r
         ZqxTz98W7aBMVibvTMNZGjglH/4/UDwNz1SAQ=
X-Forwarded-Encrypted: i=1; AJvYcCWCUNe7DvYCbeD1T0CQU02Yhbo4xRkbh+hLxY2zwXDssR4swUIDxHWG2qqdcpgGhKq9yZhssyc=@vger.kernel.org
X-Received: by 2002:a17:90a:d2cf:b0:32b:d8bf:c785 with SMTP id 98e67ed59e1d1-332a95bc6eemr6454708a91.20.1758694651124;
        Tue, 23 Sep 2025 23:17:31 -0700 (PDT)
X-Received: by 2002:a17:90a:d2cf:b0:32b:d8bf:c785 with SMTP id 98e67ed59e1d1-332a95bc6eemr6454689a91.20.1758694650630;
        Tue, 23 Sep 2025 23:17:30 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5576e90efesm1180580a12.3.2025.09.23.23.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 23:17:29 -0700 (PDT)
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
Subject: [PATCH v2] crypto: zero initialize memory allocated via sock_kmalloc
Date: Tue, 23 Sep 2025 23:01:48 -0700
Message-Id: <20250924060148.299749-1-shivani.agarwal@broadcom.com>
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
Fixes: 67b164a871af ("crypto: af_alg - Disallow multiple in-flight AIO requests")
Cc: stable@vger.kernel.org
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
Changes in v2:
- Dropped algif_skcipher_export changes, The ctx->state will immediately
be overwritten by crypto_skcipher_export.
- No other changes.
---
 crypto/af_alg.c     | 5 ++---
 crypto/algif_hash.c | 3 +--
 crypto/algif_rng.c  | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

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
-- 
2.40.4


