Return-Path: <stable+bounces-130767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FB6A80637
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309534A012E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350252690EB;
	Tue,  8 Apr 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bZJgVWOF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C9E26B975;
	Tue,  8 Apr 2025 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114597; cv=none; b=RroMC5Y+cr1RUaB9pFsq2K2VlRRztUQG9pejtpXaZDbhI1OAKEHy9ZVUzmz5NV68gWcXBWNB9+tDgfroBZZfTlpWffb+S/zxdNwHKrhNqWMSAaCmIhV+JINLBuIfi1T3VptNQtGiz4vwF+VRKGkJnGLlVx1kQl9t6hBOL9ZcIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114597; c=relaxed/simple;
	bh=+TcZFT2qZx90arxq7BTS4qI8q/5N6kYkLIovTr1BB34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbjE+a/tbCUdb8/bQBGRBc9YvXDhnTYPZ3a2V5nzXBX9cjOo2v7BckWDd/GLEbAmg3BdiVvTYKFeB3yzTGbLo/nyM8EQOLkmpMFktHTHGPqV8JuqRhA/LbxKs0qVDfCxbOp3gUIREo8RA5xQrKSHEWgXzVs9dSWtZ+lisfQdPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bZJgVWOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745D1C4CEE5;
	Tue,  8 Apr 2025 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114596;
	bh=+TcZFT2qZx90arxq7BTS4qI8q/5N6kYkLIovTr1BB34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZJgVWOF66BtL+Mv5JFTfl/hcMsGkGFbrkBayXF/ARS7qd/NVyjyG88p+UfeWvpGM
	 HXAerrkIOuZHRb0CPCWAVpn+vy52Q/epBlZ5qMTLJFwJQa1AUyvejIYuBHOMPuWJ9D
	 jSycugKvHDVbSB2isjRrD7ueGkMRc13cy/QYQgBI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akhil R <akhilrajeev@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 128/499] crypto: tegra - Use HMAC fallback when keyslots are full
Date: Tue,  8 Apr 2025 12:45:40 +0200
Message-ID: <20250408104854.389392229@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akhil R <akhilrajeev@nvidia.com>

[ Upstream commit f80a2e2e77bedd0aa645a60f89b4f581c70accda ]

The intermediate results for HMAC is stored in the allocated keyslot by
the hardware. Dynamic allocation of keyslot during an operation is hence
not possible. As the number of keyslots are limited in the hardware,
fallback to the HMAC software implementation if keyslots are not available

Fixes: 0880bb3b00c8 ("crypto: tegra - Add Tegra Security Engine driver")
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/tegra/tegra-se-hash.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/tegra/tegra-se-hash.c b/drivers/crypto/tegra/tegra-se-hash.c
index 8bed13552ab9e..65a50f29bd7e6 100644
--- a/drivers/crypto/tegra/tegra-se-hash.c
+++ b/drivers/crypto/tegra/tegra-se-hash.c
@@ -632,13 +632,18 @@ static int tegra_hmac_setkey(struct crypto_ahash *tfm, const u8 *key,
 			     unsigned int keylen)
 {
 	struct tegra_sha_ctx *ctx = crypto_ahash_ctx(tfm);
+	int ret;
 
 	if (aes_check_keylen(keylen))
 		return tegra_hmac_fallback_setkey(ctx, key, keylen);
 
+	ret = tegra_key_submit(ctx->se, key, keylen, ctx->alg, &ctx->key_id);
+	if (ret)
+		return tegra_hmac_fallback_setkey(ctx, key, keylen);
+
 	ctx->fallback = false;
 
-	return tegra_key_submit(ctx->se, key, keylen, ctx->alg, &ctx->key_id);
+	return 0;
 }
 
 static int tegra_sha_init(struct ahash_request *req)
-- 
2.39.5




