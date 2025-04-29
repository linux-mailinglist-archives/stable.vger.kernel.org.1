Return-Path: <stable+bounces-137040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E62CAA0858
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAEA4602FD
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1BA2BD58E;
	Tue, 29 Apr 2025 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwRz7e0P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C53C2BCF7E
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921989; cv=none; b=F+v7ch/dtjkYU7AwsA3/R4zzDeQE0UGrh0PQwXuyqx0rnBhkxTpItZZa30NeE8Dnrlo7suIe7bf8k5GC5uzNT7YVDNtWfTmRbhesfkMhlj1dER7kBLeNU9ncIn0hd6/81FElAy10vcAcQbpPVNAQmCGFFYdeZN/F+F8xqQjUpT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921989; c=relaxed/simple;
	bh=ZnnR1opHoeqkU7NnaS4z2CSMYREwbdUIkemIpT+1vCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t9IX2Mk5dBe6qEsxSy3+BfKqaLfstqyr3r5c6iNjhvvGvAxKX7t4SUR4JjR5Xl0ask65uOxsXE5sKV852s/45Z/B3vw0bHDCGL71PCixWBedyu+pPCaVe2hVgITMLNJbq9SGocBHOOPPbxpjLwBObKAAL8kO1wWLauTDwepws08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwRz7e0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5084FC4CEE3;
	Tue, 29 Apr 2025 10:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921988;
	bh=ZnnR1opHoeqkU7NnaS4z2CSMYREwbdUIkemIpT+1vCg=;
	h=From:To:Cc:Subject:Date:From;
	b=YwRz7e0PIqX1W96dxIF6Y57Xo2wsATvfIHmA6PpCCHPQf/2zj5ZCoQkg1RlChuZwE
	 YFWEjcyc5F7XpoUzKX4JTin7OevLvdxIg9YGLUqdiQTWii4ZwW4tnb2UPxFdslnPZr
	 sTPm5twL+ogAEk2BplLFqmgemNBThoHd2GyaUj0cayezMHyvHvFFD7O4+9ni4V48xQ
	 6TB00QhoxNqp+M657lyxoRT+0gaPa1Jqt0S0wnjaQ284iCtiOHc/Mf3bFYNyA2xq64
	 k6qao8nyBoMEuLtxzlxoS20ERAr/ghp2cKKqU+Sey0C6sHQrxxA6w904bVh/OfQT2J
	 xU/KJRNoFfNYQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: ardb@kernel.org,
	herbert@gondor.apana.org.au,
	linus.walleij@linaro.org
Subject: [PATCH 6.1.y] crypto: atmel-sha204a - Set hwrng quality to lowest possible
Date: Tue, 29 Apr 2025 12:19:44 +0200
Message-ID: <20250429101944.19440-1-kabel@kernel.org>
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
[ rebased for 6.1 ]
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/crypto/atmel-sha204a.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index a84b657598c6..51738c730717 100644
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


