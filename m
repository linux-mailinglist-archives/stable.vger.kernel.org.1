Return-Path: <stable+bounces-137041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B304DAA085D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F0A1B620D1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AE229DB6C;
	Tue, 29 Apr 2025 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRrY8wkx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A01DF73C
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745922071; cv=none; b=BRATPBLEDfTgkLZZx5eY++8jS7Csd1Yd1Rhc7B/7Z5fiYaJUtU2xWOMVmLYyZ7j3M64rzWb1eCI9+RVcH2U/43kZ+vrcOldbzSfsFkXKyyaIPUrtusjAQ+2prpHOAtHPFdU9SOeAjTApZJk5kfb0MBqZHZVQEF+yxtwMZAUfDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745922071; c=relaxed/simple;
	bh=XEywyMwGbXRMSVcyHVf46uriX8FbSQh9ac2GYEv1J2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s9mOWqBZl56CXBtlMSpa9XilNRm8dtDvjXxTCsVuC8gb4dYirTzsajedS++/rmxrvjNUlk4tQ7yhnFs6TonAXphLrxR04mJVYXIJvYiB8x7ghLMDH29gKMmqUU2hZx+bwb876fYaBv1sg71DFrjzaNkAn7pjLnQyzLSHhUX0QIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRrY8wkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7594DC4CEE3;
	Tue, 29 Apr 2025 10:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745922069;
	bh=XEywyMwGbXRMSVcyHVf46uriX8FbSQh9ac2GYEv1J2o=;
	h=From:To:Cc:Subject:Date:From;
	b=CRrY8wkxDv6w9O1MgD9Y+vwNkfGohEZxQTYsNipWx+BcER8QFoGjDDwZiQR15O45v
	 mRIQOBgI9FjpEfSDoWFzHLJUbpBnsRERbhp3dJ+fWiMZlr4Fi6LxxEyRLeW2nPPsvw
	 iJmnmROEi/SHpqw2K5kqOOqRKYkbNDq54+sgtkS0H0UCqhzLB4XB2cSh79I07TUiil
	 QS2phrq2nDYWcRIwOMdYwAtiKdqQLNAZWxGxIoSEzYxgbv8n6vKn+Qf8Mfw8HZbo0x
	 sh7PFDuiKmETlw/NZpbFoZF/ozfy1F7ljK48DYpAZpNvH2cvlyCG+X/RJXqxjOCC1u
	 Wwvl3sZw8oufQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: ardb@kernel.org,
	herbert@gondor.apana.org.au,
	linus.walleij@linaro.org
Subject: [PATCH 5.15.y] crypto: atmel-sha204a - Set hwrng quality to lowest possible
Date: Tue, 29 Apr 2025 12:21:06 +0200
Message-ID: <20250429102106.19708-1-kabel@kernel.org>
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
[ rebased for 5.15 ]
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


