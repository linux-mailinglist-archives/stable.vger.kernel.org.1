Return-Path: <stable+bounces-137042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EFDAA085E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53AB87A3511
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DC5217F56;
	Tue, 29 Apr 2025 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD30uWLl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571671DF73C
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745922114; cv=none; b=FUxSiixLH3TLiMdQv9XNUVJ/cLjGiRp7NYOaRw+9Ase5bio16HFaccrZfQ0d9rUSUi2HlbwngCe1iyYD6+ZtQviP0KMCOviS1E03/5lR4mVZH/MbNbfrZqTF5yTNmSL7ZdnDhEfvHFD8EcQP7yE35CHunp9Fj6C8Ana1YZBYs0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745922114; c=relaxed/simple;
	bh=hK0Sjx0GbJ/SJA68AB7xmHRShCZI9kUBVdU1DgQjD5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y5FD8F0bi1niC5jkE8fAgxRkNzC/JwtAlStH6VcyUynOOO+JathmGkg81XPZs/JlPrTU0mvWD7mX+Aku/YtNPmluD4qoLfTib4oSY5GKXNuqrP/zfYRenPjKekly70rufQk/ZdHMv506rCo4bGi6trzOXlLRocTmgbe2aTWUmDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KD30uWLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A21C4CEE3;
	Tue, 29 Apr 2025 10:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745922113;
	bh=hK0Sjx0GbJ/SJA68AB7xmHRShCZI9kUBVdU1DgQjD5o=;
	h=From:To:Cc:Subject:Date:From;
	b=KD30uWLlG7b+0Tq7cRMvuXmv3p/cwlwUJfe4oYPQYd91gdbs6Orqxs1GhqdN2ufiw
	 KDzg3ZTNuPdqlwLcS1qUL0llCwAv5Sfu4sOFtECX40pBgTj8l1u+Lz7yUHYnwRrb2h
	 VRaTLvrsU9gWJCEMuKHpBbl2zWDTdcBWKCOBXvk+w/2FajTlnPaOzF9K+gPcOHUsTu
	 zfvVYnPtuGG0ofWDKksvUgkhCe0Xf8atAKSBLCaFIadaeMF1N+ku3/oKes0rxuYvRW
	 Vxg2jT8let5TCntPzFlygulzPvfnw/cHNo4ctPzLJ8q/ypryxdXTgDLb0cHqOESnlh
	 ALjWi7YK4gxVw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: ardb@kernel.org,
	herbert@gondor.apana.org.au,
	linus.walleij@linaro.org
Subject: [PATCH 5.10.y] crypto: atmel-sha204a - Set hwrng quality to lowest possible
Date: Tue, 29 Apr 2025 12:21:49 +0200
Message-ID: <20250429102149.19901-1-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 8006aff15516a170640239c5a8e6696c0ba18d8e upstream.

According to the review by Bill Cox [1], the Atmel SHA204A random number
generator produces random numbers with very low entropy.

Set the lowest possible entropy for this chip just to be safe.

[1] https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html

Fixes: da001fb651b00e1d ("crypto: atmel-i2c - add support for SHA204A random number generator")
Cc: <stable@vger.kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ rebased for 5.10 ]
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/crypto/atmel-sha204a.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index c96c14e7dab1..0ef92109ce22 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -107,7 +107,12 @@ static int atmel_sha204a_probe(struct i2c_client *client,
 
 	i2c_priv->hwrng.name = dev_name(&client->dev);
 	i2c_priv->hwrng.read = atmel_sha204a_rng_read;
-	i2c_priv->hwrng.quality = 1024;
+
+	/*
+	 * According to review by Bill Cox [1], this HWRNG has very low entropy.
+	 * [1] https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html
+	 */
+	i2c_priv->hwrng.quality = 1;
 
 	ret = devm_hwrng_register(&client->dev, &i2c_priv->hwrng);
 	if (ret)
-- 
2.49.0


