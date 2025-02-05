Return-Path: <stable+bounces-113247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2AEA290A2
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955607A3CA9
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AF6158218;
	Wed,  5 Feb 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e1OwHUC1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFDE155A21;
	Wed,  5 Feb 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766316; cv=none; b=bS2zLvqOfQaEDcHiijhePUOb8nXSDo7jz+rN3DuL16yC6Wt06wktOCXysRxHKcZwy6gvi9aykQLTxFo28dkwoCEoMMLEZvgQV2oi02Iz+GcckqID4ofUIVIFeEr4s2DduXEwQWp6Ce8Cu1KqfiuUWtUAx3SDNFnFhybemj8cmGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766316; c=relaxed/simple;
	bh=jcRvdZesKUBUriztB3ROgexnUi8x2WDApZU51ecIjLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6IqQ8D2h/qqWpqLIGBIAOonpzDLKJucA/q4YUC05cPHRybuFZSeu+Av6HRNRod3pZSZqjUBH66CTmd3FQ/49gD5R7ejU4HIpSf0qRhl/zjwvCxnkA95J536ejEQkuBwT6dDEcWnAzTs+61l2WaaWQh8THx/j9Ybgml3ZTySrI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e1OwHUC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA62C4CEE7;
	Wed,  5 Feb 2025 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766316;
	bh=jcRvdZesKUBUriztB3ROgexnUi8x2WDApZU51ecIjLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1OwHUC1jjYNdjMhgdPOo0rRBspRxIOvqfP8k0pVl8cxKg40AQS9N34LdupLDFmFI
	 X5JnwEumdq4IKQ2sL9UgsD85raOq8ngJNlVdFgk63vJjbQqmR/aYnvrYiqO15LXWhZ
	 xLDlPuloBf3eST8l/VSVB/nvidMCmxXSrJ5NDaio=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ridong <chenridong@huawei.com>,
	Akhil R <akhilrajeev@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 262/623] crypto: tegra - do not transfer req when tegra init fails
Date: Wed,  5 Feb 2025 14:40:04 +0100
Message-ID: <20250205134506.253826148@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
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

From: Chen Ridong <chenridong@huawei.com>

[ Upstream commit 15589bda46830695a3261518bb7627afac61f519 ]

The tegra_cmac_init or tegra_sha_init function may return an error when
memory is exhausted. It should not transfer the request when they return
an error.

Fixes: 0880bb3b00c8 ("crypto: tegra - Add Tegra Security Engine driver")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Acked-by: Akhil R <akhilrajeev@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/tegra/tegra-se-aes.c  | 7 +++++--
 drivers/crypto/tegra/tegra-se-hash.c | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/tegra/tegra-se-aes.c b/drivers/crypto/tegra/tegra-se-aes.c
index 9d130592cc0ac..d734c9a567868 100644
--- a/drivers/crypto/tegra/tegra-se-aes.c
+++ b/drivers/crypto/tegra/tegra-se-aes.c
@@ -1750,10 +1750,13 @@ static int tegra_cmac_digest(struct ahash_request *req)
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct tegra_cmac_ctx *ctx = crypto_ahash_ctx(tfm);
 	struct tegra_cmac_reqctx *rctx = ahash_request_ctx(req);
+	int ret;
 
-	tegra_cmac_init(req);
-	rctx->task |= SHA_UPDATE | SHA_FINAL;
+	ret = tegra_cmac_init(req);
+	if (ret)
+		return ret;
 
+	rctx->task |= SHA_UPDATE | SHA_FINAL;
 	return crypto_transfer_hash_request_to_engine(ctx->se->engine, req);
 }
 
diff --git a/drivers/crypto/tegra/tegra-se-hash.c b/drivers/crypto/tegra/tegra-se-hash.c
index 4d4bd727f4986..0b5cdd5676b17 100644
--- a/drivers/crypto/tegra/tegra-se-hash.c
+++ b/drivers/crypto/tegra/tegra-se-hash.c
@@ -615,13 +615,16 @@ static int tegra_sha_digest(struct ahash_request *req)
 	struct tegra_sha_reqctx *rctx = ahash_request_ctx(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct tegra_sha_ctx *ctx = crypto_ahash_ctx(tfm);
+	int ret;
 
 	if (ctx->fallback)
 		return tegra_sha_fallback_digest(req);
 
-	tegra_sha_init(req);
-	rctx->task |= SHA_UPDATE | SHA_FINAL;
+	ret = tegra_sha_init(req);
+	if (ret)
+		return ret;
 
+	rctx->task |= SHA_UPDATE | SHA_FINAL;
 	return crypto_transfer_hash_request_to_engine(ctx->se->engine, req);
 }
 
-- 
2.39.5




