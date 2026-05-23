Return-Path: <stable+bounces-253955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDniKtzDEWpDpgYAu9opvQ
	(envelope-from <stable+bounces-253955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 17:12:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AEF5BF969
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 17:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4BEA7300B9D7
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 15:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E61B311C2A;
	Sat, 23 May 2026 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgj8APO6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2430FC1E
	for <stable@vger.kernel.org>; Sat, 23 May 2026 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779549116; cv=none; b=BqTlakUyrYQXV3pERXLDk2JpkuM6As4RDUxp+hvgqmY+9DpysPXb6+Ydd4/qAYGOt/hz60iKhhmzcRBAiQgyMM0E4/dFUA+cKjmkQFYhfTChuW3xqPdYTh9yEurueNobWxjZ7roIvZcO7y9ChZ+KcywPbtEqI2rk834NXGtodpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779549116; c=relaxed/simple;
	bh=mhZ5EgYm1uEO8wYkbnknTvEBKv+Yz2a/FMmsfjr4Qfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECKoYwTpq+RPW+NKDAzeCTPZk3VoIF3YkGwfTjk56rSFXdTrKOupTlWBsqyJPnvIo7QCKdSxy4h1HfwlsNgKgJIV/brKLOkurCQq7dICix2Mm0yYhY+WLK2+xeUPge0twkL3bFzeXlUhty4tx3UuwQ42cDQDN2N7Dj9xq9tDQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgj8APO6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso27201235e9.0
        for <stable@vger.kernel.org>; Sat, 23 May 2026 08:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779549114; x=1780153914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cw7XVcaORy+d/dFYODK+UOJC8GePay1GtMpoNR5qLgs=;
        b=bgj8APO6qmhkcJ6z3WJTrqZZ+mI1ArCcEY4KVDF2OPwrrsvA19Nn+ERz+rdLua9CY6
         3FMwtgPa7vBpkWdIPcOvTHCnIZ8PkLusNK/NJ/YNFizal5MSimV0lc08R4kdPIWyJL2a
         7mr2uFsoJRncUdQjRFDxDpkWFxG0por0ABt4ZHgqdb4vXdQJq1oNIji4Wbe9XziqkVfn
         ol0w2mtRUbwXHuWoFyYLxZJa6cmL3z3srzfm+0bq2SLtqkvKn+/jVRacIDeQa7fptJRA
         tz/ZxpOUeJPRCMgrCQlQPQ9MzVe44z1vraqD/ujy6sfdvU8Ip68UxYAZucg8UZpRai2z
         kEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779549114; x=1780153914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cw7XVcaORy+d/dFYODK+UOJC8GePay1GtMpoNR5qLgs=;
        b=nrW49w9b8TXL8oN7dIRLMzVXdpzm7cPwwbgD14qu78ULV9oYt1NLM5kGeiVCsQW9ix
         NRrUVblqmdGLiLoMfl6ZeSFEHLUKAtQPwMvNU1ANb3QqhdZflMko6LX1z5afZvIrGYuX
         0w560IBJkOY00GkHp7gjeXyJtaKD0QASmQDxpZ2C6+txahfcKmV/jy/sFJiTKTy+4Vnl
         98kzoLG7Evi4IrJprrFV5fDhgmCF2ph8ObWNzLL5hvGSY/zZve66CtR51/XF5UDTB8cf
         CKpJASmES1AkwkgQGkqbsWsY6FY//K60IFsLhz0LskrYf/Pu6VYpXaA3TU63y5yQn4QV
         qWIg==
X-Forwarded-Encrypted: i=1; AFNElJ+5ZK5kyhd9R79687Z7pyYWjONys+YjaDtUqlCL+3mXkJNfPmWBf2qx+qLKuEg3ZQsgeAbzkUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgegjXeuE4Iita1rXE8doIIRTqQQrNdEAdMqIRPPmvvQNr06hH
	d6UYzAeItzdFcD4tNdrvexziLF6ULrHdlpDDZFdr7fuCbm3eD6t1FI/C
X-Gm-Gg: Acq92OHOY1wQwq7Ee3vGCtwTYf4qzQ5r2snHU0al/63o8zRpD7B1zbYehSgA5ulujpc
	tosjE6NiXbrEUZs45o/6yU27yHAUEKX99INd4RR3ELK5tsc3RcST/yqEbuTiTnWP8L/agk7RrBF
	TXELZoIm2MOttHC/7qua6F/M9EIblTfV76HyEK0pAyvhhtaiC8LQQnjlyaj92xGrUb0VPW6Ovs6
	RQZRBZPWmenqcMM4QnG/6AdrDo0zVMDSOGBlHQhset3c5CBzYjT5THFJs3Asyx7SlcxKeS5XnVD
	83XYRCr3iOVVgGlE0f6K8+H9ItCNf2XHDRTtaPEZyilGXKzv/aFLYs+GkHZWUgvXM0cS58JsHjp
	C0L3XtJi8ZakjNF4puudTqRRcAhlzou/xI0BGzNlbEiiy82XtV/118iwKufDXAo2FYzgm51tYOh
	Ue1vHGdEMxw4gxA/mFbpKmvtez/VGPoVAx
X-Received: by 2002:a05:600c:1d11:b0:48a:5574:3a5d with SMTP id 5b1f17b1804b1-4904248ac81mr111740575e9.7.1779549113577;
        Sat, 23 May 2026 08:11:53 -0700 (PDT)
Received: from mini.main.internal ([2a02:908:c211:cd18:36:c98d:902c:348d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d7167dsm12629156f8f.35.2026.05.23.08.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 08:11:52 -0700 (PDT)
From: Goetz Goerisch <ggoerisch@gmail.com>
To: gregkh@linuxfoundation.org
Cc: ggoerisch@gmail.com,
	herbert@gondor.apana.org.au,
	herve.codina@bootlin.com,
	linux-crypto@vger.kernel.org,
	miquel.raynal@bootlin.com,
	paul.louvel@bootlin.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH 3/5] crypto: talitos - stop using crypto_ahash::init
Date: Sat, 23 May 2026 17:10:46 +0200
Message-ID: <20260523151048.14914-4-ggoerisch@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523151048.14914-1-ggoerisch@gmail.com>
References: <2026052212-aged-amply-7bd8@gregkh>
 <20260523151048.14914-1-ggoerisch@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,bootlin.com,vger.kernel.org,kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-253955-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ggoerisch@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,apana.org.au:email]
X-Rspamd-Queue-Id: A9AEF5BF969
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eric Biggers <ebiggers@google.com>

commit 9826d1d6ed5f86cb3d61610b3b1fe31e96a40418 upstream.

The function pointer crypto_ahash::init is an internal implementation
detail of the ahash API that exists to help it support both ahash and
shash algorithms.  With an upcoming refactoring of how the ahash API
supports shash algorithms, this field will be removed.

Some drivers are invoking crypto_ahash::init to call into their own
code, which is unnecessary and inefficient.  The talitos driver is one
of those drivers.  Make it just call its own code directly.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/talitos.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 4ca4fbd227bc..a941ec08817e 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2119,13 +2119,14 @@ static int ahash_finup(struct ahash_request *areq)
 
 static int ahash_digest(struct ahash_request *areq)
 {
-	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
-	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
-
-	ahash->init(areq);
-	req_ctx->last = 1;
+	ahash_init(areq);
+	return ahash_finup(areq);
+}
 
-	return ahash_process_req(areq, areq->nbytes);
+static int ahash_digest_sha224_swinit(struct ahash_request *areq)
+{
+	ahash_init_sha224_swinit(areq);
+	return ahash_finup(areq);
 }
 
 static int ahash_export(struct ahash_request *areq, void *out)
@@ -3242,6 +3243,8 @@ static struct talitos_crypto_alg *talitos_alg_alloc(struct device *dev,
 		    (!strcmp(alg->cra_name, "sha224") ||
 		     !strcmp(alg->cra_name, "hmac(sha224)"))) {
 			t_alg->algt.alg.hash.init = ahash_init_sha224_swinit;
+			t_alg->algt.alg.hash.digest =
+				ahash_digest_sha224_swinit;
 			t_alg->algt.desc_hdr_template =
 					DESC_HDR_TYPE_COMMON_NONSNOOP_NO_AFEU |
 					DESC_HDR_SEL0_MDEUA |
-- 
2.54.0


