Return-Path: <stable+bounces-204853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF90CF4E15
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8BBE331FFAF
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC33054D0;
	Mon,  5 Jan 2026 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syuCft8M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A12DECD2
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631693; cv=none; b=Dggz9hl4Xq/MBuoBs0YmXgKFAOuOvZUxElj55eH2GmbvOfU4MopD02GgtcKtS3zoTx0eAlSaei4J/RJ13xEB+DcBZoGd5ck7pSeW//mA85s5sjjtQirEyjbeM19Biok4H6U0uFo0lAp31iHCjjKIiIcNcyb/C3kFRFFEDWBUluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631693; c=relaxed/simple;
	bh=jLsLVHwhRT/MSFbNQgRGSBuD73hDeUcoKpI0w8RueXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0MOzTNBbTFLYSYANYkDfp3kRUOFtbWxuq9wOy7+tjyeVXuXZXT9Dmi9A1oTIltF0hXaBuOqJwJ+etKGIkzcJGfNst1PQEIIyYZd9wFIErcSZPQs5BDk3yxp8IbfEXqohiR3fKpgraehSn5+0S/cVF1KtTconOeY5XWYVZLxxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syuCft8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59618C19425;
	Mon,  5 Jan 2026 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767631691;
	bh=jLsLVHwhRT/MSFbNQgRGSBuD73hDeUcoKpI0w8RueXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=syuCft8MmyAD1pjTdJwCO1bALP/yMDcQFbJlRZwEIOiwUzDNjKPcMofD/ymr0QHE2
	 m3xdtY8Y2AUGtq5scCLnKUQ1Jcahnck90DyFCqrc9Htmjow/2WWZThOHETPtMI8/SB
	 WhetmkoeqfqXsnL3vBLjtAy3Bf2epqBzJR2T/7mfP71tOckW8s9IyjcyH/dGnHr7o9
	 LiylaKGb4tQmE2SQxZKXidt25NXmaDrn5FGMBv2aNGQLc8OcpMMCCCcJmXjWjhBTsE
	 9+mpHHJjb3y/7fyxFzcBD5dvvqXRR+NPobCDYwD7ARAo6UTtD9aYexYsl3dJRMyRqZ
	 XW1HPXTLJOLMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] leds: lp50xx: Get rid of redundant check in lp50xx_enable_disable()
Date: Mon,  5 Jan 2026 11:48:06 -0500
Message-ID: <20260105164808.2675734-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105164808.2675734-1-sashal@kernel.org>
References: <2026010519-botanical-suds-31fa@gregkh>
 <20260105164808.2675734-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 5d2bfb3fb95b2d448c0fbcaa2c58b215b2fa87fc ]

Since GPIO is optional the API is NULL aware and will check descriptor anyway.
Remove duplicate redundant check in lp50xx_enable_disable().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Stable-dep-of: 434959618c47 ("leds: leds-lp50xx: Enable chip before any communication")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-lp50xx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index 66299605d133..35ab4e259897 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -382,11 +382,9 @@ static int lp50xx_enable_disable(struct lp50xx *priv, int enable_disable)
 {
 	int ret;
 
-	if (priv->enable_gpio) {
-		ret = gpiod_direction_output(priv->enable_gpio, enable_disable);
-		if (ret)
-			return ret;
-	}
+	ret = gpiod_direction_output(priv->enable_gpio, enable_disable);
+	if (ret)
+		return ret;
 
 	if (enable_disable)
 		return regmap_write(priv->regmap, LP50XX_DEV_CFG0, LP50XX_CHIP_EN);
-- 
2.51.0


