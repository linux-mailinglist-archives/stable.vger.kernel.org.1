Return-Path: <stable+bounces-170209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E46B2A34E
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3C5173647
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB6B31CA58;
	Mon, 18 Aug 2025 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oHiM5s1N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD6931B13E;
	Mon, 18 Aug 2025 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521888; cv=none; b=REtZU6C++/ezwo1xddaiWFaNmZCzrkUKkWu0UOWmGhHKKA85P+HTI+/0BcMfHtvOKI3NBEVkAm4rrp1y+DJ79aiMFuAUyCF0zYFyZ1u2rKYFStgJlJQvHqw+3j14Bz0x4FrrPqhAI8tYUtIAaBrhFlEUzEnXlqb8OpBOvPjZkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521888; c=relaxed/simple;
	bh=2k70UraitaKesaZTrViFuHxApoKIqFrURY6QAxyUzsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceeXhyvSg1FJQkVYWpEHUratTg9/LS9HJokS9x7/FVYU9cumF65wm/nqysLvn+mt0FZKkCWq8zk5pIzsr1JScYsAk5CK4AAg4VxxlmkTGwQBe3BAo1YIuleaRpoY6XxbrtJyEGZl5Sg9ziigfKDUwiEm+KZYSxP6JN5CeJ2Unbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oHiM5s1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF41C4CEEB;
	Mon, 18 Aug 2025 12:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755521888;
	bh=2k70UraitaKesaZTrViFuHxApoKIqFrURY6QAxyUzsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHiM5s1NLBzd9hySC4vV3MkvzCheq+QbmG5amHmdDLMbXUPbw9+n7DsqQ4d3Ttqqx
	 wdOcf/UEcXKFYcoAFNKAViIPHNtpswysEm1x4uM6yi9TvEks/XBsgM1YiDtZv6RI3q
	 KKwXLHjxm2jIrx1sCii8mJerfbWuFuonpBJzdjbM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 119/444] gpio: tps65912: check the return value of regmap_update_bits()
Date: Mon, 18 Aug 2025 14:42:25 +0200
Message-ID: <20250818124453.384235669@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit a0b2a6bbff8c26aafdecd320f38f52c341d5cafa ]

regmap_update_bits() can fail, check its return value like we do
elsewhere in the driver.

Link: https://lore.kernel.org/r/20250707-gpiochip-set-rv-gpio-round4-v1-2-35668aaaf6d2@linaro.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-tps65912.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-tps65912.c b/drivers/gpio/gpio-tps65912.c
index fab771cb6a87..bac757c191c2 100644
--- a/drivers/gpio/gpio-tps65912.c
+++ b/drivers/gpio/gpio-tps65912.c
@@ -49,10 +49,13 @@ static int tps65912_gpio_direction_output(struct gpio_chip *gc,
 					  unsigned offset, int value)
 {
 	struct tps65912_gpio *gpio = gpiochip_get_data(gc);
+	int ret;
 
 	/* Set the initial value */
-	regmap_update_bits(gpio->tps->regmap, TPS65912_GPIO1 + offset,
-			   GPIO_SET_MASK, value ? GPIO_SET_MASK : 0);
+	ret = regmap_update_bits(gpio->tps->regmap, TPS65912_GPIO1 + offset,
+				 GPIO_SET_MASK, value ? GPIO_SET_MASK : 0);
+	if (ret)
+		return ret;
 
 	return regmap_update_bits(gpio->tps->regmap, TPS65912_GPIO1 + offset,
 				  GPIO_CFG_MASK, GPIO_CFG_MASK);
-- 
2.39.5




