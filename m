Return-Path: <stable+bounces-197103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BA6C8E8E1
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE17B3AD8D1
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDAA28751D;
	Thu, 27 Nov 2025 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogq4axpe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC56A280CE0;
	Thu, 27 Nov 2025 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251048; cv=none; b=lkB5a79kofjDz0jmnBLvs7oSRfebA8bNZFlFKyLQL/+L6GDcZM5o3//ukG/wU00oWJm5PGuHV8hk0KulCoteodA2SprN5b6WGkHSyLwhbW73oiRF3ElPRDc1MYeP0mLcZSvekqsjGCIBYopIZfTV5tgFUCKkuK2X3qobWQn1DTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251048; c=relaxed/simple;
	bh=sDTsqEmZ9Mndcjle4rPk0x0FCm5WsLVdSg1rgBSA+TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgP9m5OJXCWA50VO0WHhqx/gJu1Wl8jcOldgM48VkXGX2HncEJQnZG3E0vy0V2vy3pcRTSaJB9ee0PGnGNOmbrHcX0n+XLr1WgQTPqDbYkLIHWQFxpLxFZO7i+l5qTCHS+M6Bd/55xFm7h3MwVrZMFUXq21HJ/b8ZtjBpQD8yPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogq4axpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA27C4CEF8;
	Thu, 27 Nov 2025 13:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764251048;
	bh=sDTsqEmZ9Mndcjle4rPk0x0FCm5WsLVdSg1rgBSA+TU=;
	h=From:To:Cc:Subject:Date:From;
	b=Ogq4axpeAdUCyXagyQS3YW0B6OyfXAudHSmazG55F6bcgPFJlA5a/2Yq8n7n/77bd
	 bXAczZSbRGGOpzilXTrZLgWRObC7eAqtKnFe5IX+1ZeRh43V89NEBkDoP3H+MtwhH1
	 ZQ6xbb41zLUwRI2bDhe/5cR8mPUMZrYCkBgOYXvJYWU1ZpsjAtNY3UZgTko5bFmR0S
	 WXstpi04z+8YQEu180L7noXT4piR5pNhr7TbFD05nmgDTQ8Sz+w9eRmPGktmob46Bj
	 YTWYWAUeVJ5RKEbSGmqu8fJBOgixPC2LDRqfmGZ6Uv8KCP1TKelxSaCaWFyPOfJCOT
	 d9HbHz3qF79bA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vOcI7-000000000Q6-09M5;
	Thu, 27 Nov 2025 14:44:11 +0100
From: Johan Hovold <johan@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (max6697) fix regmap leak on probe failure
Date: Thu, 27 Nov 2025 14:43:51 +0100
Message-ID: <20251127134351.1585-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i2c regmap allocated during probe is never freed.

Switch to using the device managed allocator so that the regmap is
released on probe failures (e.g. probe deferral) and on driver unbind.

Fixes: 3a2a8cc3fe24 ("hwmon: (max6697) Convert to use regmap")
Cc: stable@vger.kernel.org	# 6.12
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/hwmon/max6697.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index 0735a1d2c20f..6926d787b5ad 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -548,7 +548,7 @@ static int max6697_probe(struct i2c_client *client)
 	struct regmap *regmap;
 	int err;
 
-	regmap = regmap_init_i2c(client, &max6697_regmap_config);
+	regmap = devm_regmap_init_i2c(client, &max6697_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-- 
2.51.2


