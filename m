Return-Path: <stable+bounces-89186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E34A29B4865
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 12:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8861C28393D
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 11:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB66205152;
	Tue, 29 Oct 2024 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="ap/W9MXz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507E7464
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201666; cv=none; b=X6HeLGf4SVMOrnXQMilbmro9gxnR4EPcvmqy1qLjud/3HC5IsFAYqsBc3Ej4rjAH3PSeKvpqp8SpkO3qyINW5A9OiMWfN238/qasQf2+HW3gI0RkoBqvBVrl/OkOUZb9xP5785OkBhU1+YhviVyrEIY9tSIhJNDYJNlL5fsuiQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201666; c=relaxed/simple;
	bh=cPKEJ4jerXa/h6ueOtoFqHZZD6u7n4AElLCBfDVkuAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z90EgBJsaJmmF+95pzKYQB3Iu0Y2nah3kicV7DuSbbq9ZaWigqWO+KFJLjvU3Mh7hwxPZ0kFVhg0fTdLVLjQEMLxFKY7rEWdP7VRLTn0GfeYx8HmV0iIdRCdBgv2ECWVUqj2xc9hspfXipPcXE39K/oz/8Wy/PAN2UQnc4AzSZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=ap/W9MXz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37ed7eb07a4so4194101f8f.2
        for <stable@vger.kernel.org>; Tue, 29 Oct 2024 04:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1730201660; x=1730806460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUO11C/JRTs4GKxfufQ6dUqgB6gKo2LmLUMdUeU8K1k=;
        b=ap/W9MXzkQRzXylxlEwl9vrjtn4+mVxv5Dln5/HFOmSJtI2c1uJDvPw+iTmPDB6+NM
         ogtZzXTUR0mOpR4sKySkHlXlwfGp2SVUCRPOWNM934bn42MyKO/j0AW86OTPImOeKcq7
         ehYDhB6SbvxWHr9PZ28OxYEKvyioWUz4eLZ/5aury1TZa0G8wEIFXfyBVnFG3G3b49Fc
         yvQor9LnoJhhJm1sQuR5nd2A4XENxUIpsZmMuH9+JWbDWzpK+sdTL7FO501zS3pi1YGL
         IyEyu9Xgun/pPgBSnura1G3Q6dHNJA6h6E0XPPz8roSsapXM/Ya/tjj9PPS0qtJsY3y3
         hjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730201660; x=1730806460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUO11C/JRTs4GKxfufQ6dUqgB6gKo2LmLUMdUeU8K1k=;
        b=k+O37GU1auZuzNN9KhymeoIYIZNzLFG5LUVtp5YlFUqTiY9k2qAow6SbTJ2zE73ZbZ
         aMl320wnQHmjO7Itat1sTtYzqS0iLIT2D3J/cu6drNZVdrNGzceSvF6bE4M1r/6kjXLA
         f3bOCzURLo8dcy5T5ggxQKi7v6AarXW4ELw1TVWtaIEJXno/zKp6tBIBF18j+CwVSnAX
         4rWoPzzncaWKXFuoiayEbXgzQEIlmGDl2bC4Q+ITAjZIWtil5sOQ8oehwS8OjybXpVau
         /rvkIg3Lv+rNVr1wblHaPUBShZBR+U5UOV4gJqot+R8vAVMTt8d3CoyK8r8zhDpgvqVd
         tASQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9SSLomK031FIcInd98Kvusa4WFP0mkxAzMq5X+ksTZxN7qRmyD/DxBWarFh8d0PRRYW03Qks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjxYwWyNBW4QmRBw4g5DMhuP3wZwRUMfwSQoI6tg+KzsZcDn7u
	cIbmOGT7mJ+FU68hqSdOr5C2azAoT6TwIlDtVTzHY3piPy5vUSXtHu/R2zflPWg=
X-Google-Smtp-Source: AGHT+IFJoyZ6NxzI4ys9GDFWfJixnTkKlsJEMZbZjWGrqOc2/MIuNQIrRuJSwDRXg2rPjjIDI76/9g==
X-Received: by 2002:adf:fdc9:0:b0:37d:43e5:a013 with SMTP id ffacd0b85a97d-380610f49e4mr7243573f8f.8.1730201660311;
        Tue, 29 Oct 2024 04:34:20 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38058b47952sm12152755f8f.48.2024.10.29.04.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 04:34:20 -0700 (PDT)
From: David Gstir <david@sigma-star.at>
To: parthiban@linumiz.com,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Gstir <david@sigma-star.at>,
	stable@vger.kernel.org
Subject: [PATCH] KEYS: trusted: dcp: fix NULL dereference in AEAD crypto operation
Date: Tue, 29 Oct 2024 12:34:01 +0100
Message-ID: <20241029113401.90539-1-david@sigma-star.at>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <254d3bb1-6dbc-48b4-9c08-77df04baee2f@linumiz.com>
References: <254d3bb1-6dbc-48b4-9c08-77df04baee2f@linumiz.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sealing or unsealing a key blob we currently do not wait for
the AEAD cipher operation to finish and simply return after submitting
the request. If there is some load on the system we can exit before
the cipher operation is done and the buffer we read from/write to
is already removed from the stack. This will e.g. result in NULL
pointer dereference errors in the DCP driver during blob creation.

Fix this by waiting for the AEAD cipher operation to finish before
resuming the seal and unseal calls.

Cc: stable@vger.kernel.org # v6.10+
Fixes: 0e28bf61a5f9 ("KEYS: trusted: dcp: fix leak of blob encryption key")
Reported-by: Parthiban N <parthiban@linumiz.com>
Closes: https://lore.kernel.org/keyrings/254d3bb1-6dbc-48b4-9c08-77df04baee2f@linumiz.com/
Signed-off-by: David Gstir <david@sigma-star.at>
---
 security/keys/trusted-keys/trusted_dcp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
index 4edc5bbbcda3..e908c53a803c 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -133,6 +133,7 @@ static int do_aead_crypto(u8 *in, u8 *out, size_t len, u8 *key, u8 *nonce,
 	struct scatterlist src_sg, dst_sg;
 	struct crypto_aead *aead;
 	int ret;
+	DECLARE_CRYPTO_WAIT(wait);
 
 	aead = crypto_alloc_aead("gcm(aes)", 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(aead)) {
@@ -163,8 +164,8 @@ static int do_aead_crypto(u8 *in, u8 *out, size_t len, u8 *key, u8 *nonce,
 	}
 
 	aead_request_set_crypt(aead_req, &src_sg, &dst_sg, len, nonce);
-	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL,
-				  NULL);
+	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_SLEEP,
+				  crypto_req_done, &wait);
 	aead_request_set_ad(aead_req, 0);
 
 	if (crypto_aead_setkey(aead, key, AES_KEYSIZE_128)) {
@@ -174,9 +175,9 @@ static int do_aead_crypto(u8 *in, u8 *out, size_t len, u8 *key, u8 *nonce,
 	}
 
 	if (do_encrypt)
-		ret = crypto_aead_encrypt(aead_req);
+		ret = crypto_wait_req(crypto_aead_encrypt(aead_req), &wait);
 	else
-		ret = crypto_aead_decrypt(aead_req);
+		ret = crypto_wait_req(crypto_aead_decrypt(aead_req), &wait);
 
 free_req:
 	aead_request_free(aead_req);
-- 
2.47.0


