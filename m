Return-Path: <stable+bounces-137043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA5AA0860
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA181A83558
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0F7225768;
	Tue, 29 Apr 2025 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm52WFcG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC82746A
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745922169; cv=none; b=VWyC/M8sJIgRLoQP/CESW/bsgsfeSGnDtDJNn72XkV9hkdR5tqxFzk3F6BBrSLDBU1Vh9waPfJKWoxpji1plDMcY1yRmrgCQw10HTHlF2xvAplG6OhqXaPKXOI7us2laTmyTTpxRdJPnhNdSkTW8sxxCacfCWR9o2riW/ud/HeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745922169; c=relaxed/simple;
	bh=H2aA3e0YIuYIz0kI07oDrz1qNT6MmbqHAFDxH26f8sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jkqDZ1p47N0ffIT7GKreP8Qj0kyKc0Sl6TycMCyv3gP95T5HBZviouFN+dBwDvVem6mei2xOKkp0Dq+ynaOP3xrf2hVXEzyZZHFF0ITCZgZ3Y0g7v6fPKoCyO8ZvBIytLNhZuaQivXuVB0w7uDupuS79yeLFZ9X6r3v4Ci5IAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm52WFcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B934AC4CEE3;
	Tue, 29 Apr 2025 10:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745922169;
	bh=H2aA3e0YIuYIz0kI07oDrz1qNT6MmbqHAFDxH26f8sU=;
	h=From:To:Cc:Subject:Date:From;
	b=Mm52WFcGXTMTC8Qs3L62MxkZyU1zECYIPktB/XHksA8pDaYgSDfvZU/c+NKAUwL56
	 yMMLH5xjhLlagXdyvVpTkf3DVwIkGIj7wHRXs1/CfNV6zRY9KDOAnn6/PABSK1CG7A
	 cJR5rr1kq9HShfH08sVTdzRco5PivAyHu/ayC+Nl7IiXeVMHaHnFciLvNWoeLFFWZh
	 6SSDg2WQOsHsuLyP6Otb6zmxJ6AMwraJcP7gIEqh6vApxITCsXznOzUudFfos0yM6X
	 l3xWWTAbR3VCyupL/MT3pF7Ppctv0NMhAqewF1YaCjBUS5b2hfWC52N0SIMyR3ZgSf
	 ckLBDUH3oAjlQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: ardb@kernel.org,
	herbert@gondor.apana.org.au,
	linus.walleij@linaro.org
Subject: [PATCH 5.4.y] crypto: atmel-sha204a - Set hwrng quality to lowest possible
Date: Tue, 29 Apr 2025 12:22:45 +0200
Message-ID: <20250429102245.20146-1-kabel@kernel.org>
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
[ rebased for 5.4 ]
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


