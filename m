Return-Path: <stable+bounces-188197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900FABF26CE
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721153AB1C9
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB1D286D4E;
	Mon, 20 Oct 2025 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+FFR5Ah"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D405B2638BF
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977574; cv=none; b=Q57Dv6mx7NXzLD1zgqHG/dSAfus5wLhraZ3swEEaDN5H1bh3naNOyuaaXqJISXNCpTRWxM4Cqvu0hyiWoIWvgtVKtviTROJ+Cb9krE2kzZ0rHem7Xf9krsSvNOGR6wpJg7NHci+Da1ZfO1okfiLpR+3CDOIrVkCHWjTpAdog8OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977574; c=relaxed/simple;
	bh=qoG20t8R0cP4F+Heb6KoPQ7+/w7nHJOifKUx0dom5DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDP/CA3q9+IHU8UFDt1EbugumrY7mbXQBA9ousapzOS+gKqjcD2vsVyiThv2jgAwLFn3Oe4EWVfpX6p6RtiGyJl9+bchbrCDCH/Jgaqr6Xv17P6ctuPNdNnhswPAaTIdCUfAs1sohxK8e8FQbtnI2y53DMA7RPBVkaFq/zvJmVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+FFR5Ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAF6C4CEF9;
	Mon, 20 Oct 2025 16:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977574;
	bh=qoG20t8R0cP4F+Heb6KoPQ7+/w7nHJOifKUx0dom5DQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+FFR5AhCIeC+2Tn1s3LMv7fvfE6TdZFXxYeoWU3yU7mv9v2Th4vKh/wlgK1qEshN
	 PbVPw1yaeofaEhAw3TlwN4PcU8VIblpgXCJDxVgQRDT6x4jaNz+11L0jqJFyiGuI4u
	 s7UwPxoCjb4mDSqoneJ3B24h2to13aU1lYELb/6AqwwtcTa/kWBgG3OSM3liHEU2rh
	 mvFqfGNxVhb2WqZhUS71qS4dHOIDjdiKiT7q0TZ2JNK36yPNQTe68cQx6xMoWPh0UJ
	 GxTKumTqfjjCCDhZXDFfNzkID1o7ucwRXEOuNy2YPX4OiPVs7kWJAAhx4tB9IawaHb
	 V7L0R/6gOf1RA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KEYS: trusted_tpm1: Compare HMAC values in constant time
Date: Mon, 20 Oct 2025 12:26:11 -0400
Message-ID: <20251020162611.1838605-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101623-bleep-cold-406b@gregkh>
References: <2025101623-bleep-cold-406b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit eed0e3d305530066b4fc5370107cff8ef1a0d229 ]

To prevent timing attacks, HMAC value comparison needs to be constant
time.  Replace the memcmp() with the correct function, crypto_memneq().

[For the Fixes commit I used the commit that introduced the memcmp().
It predates the introduction of crypto_memneq(), but it was still a bug
at the time even though a helper function didn't exist yet.]

Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
[ replaced crypto/utils.h include with crypto/algapi.h ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm1.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 4c3cffcd296ac..3e9dc03d59c91 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -9,6 +9,7 @@
  */
 
 #include <crypto/hash_info.h>
+#include <crypto/algapi.h>
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -248,7 +249,7 @@ int TSS_checkhmac1(unsigned char *buffer,
 	if (ret < 0)
 		goto out;
 
-	if (memcmp(testhmac, authdata, SHA1_DIGEST_SIZE))
+	if (crypto_memneq(testhmac, authdata, SHA1_DIGEST_SIZE))
 		ret = -EINVAL;
 out:
 	kfree_sensitive(sdesc);
@@ -341,7 +342,7 @@ static int TSS_checkhmac2(unsigned char *buffer,
 			  TPM_NONCE_SIZE, ononce, 1, continueflag1, 0, 0);
 	if (ret < 0)
 		goto out;
-	if (memcmp(testhmac1, authdata1, SHA1_DIGEST_SIZE)) {
+	if (crypto_memneq(testhmac1, authdata1, SHA1_DIGEST_SIZE)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -350,7 +351,7 @@ static int TSS_checkhmac2(unsigned char *buffer,
 			  TPM_NONCE_SIZE, ononce, 1, continueflag2, 0, 0);
 	if (ret < 0)
 		goto out;
-	if (memcmp(testhmac2, authdata2, SHA1_DIGEST_SIZE))
+	if (crypto_memneq(testhmac2, authdata2, SHA1_DIGEST_SIZE))
 		ret = -EINVAL;
 out:
 	kfree_sensitive(sdesc);
-- 
2.51.0


