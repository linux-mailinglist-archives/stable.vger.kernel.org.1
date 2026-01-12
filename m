Return-Path: <stable+bounces-208195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCE8D14BF6
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 19:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59DB73026F2C
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 18:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F23876AB;
	Mon, 12 Jan 2026 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJXQGzNy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FC63876C1
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242243; cv=none; b=n4nrhR2I7DG6B9ilA7D86tCHi/IhzB+nYZHfJoZL5kamVyHqEAtcJAe5XUjLH2j1M9d9lmncter6PBwL8HPLjr4Q+0DkfPGIm+TYoJXIVemMwUBxKG6o1eBK/YI4r0Ibxn+EoYhiAI+hbqLkuuHzCAmQVuv9VGy6E/+BOiGNe5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242243; c=relaxed/simple;
	bh=A8H/mCgzXZ/gyGMV7iJz86MAs43bp1oMFTky1CT95Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWhFBsnrSDvXEUpzH/0CsiNxMPyEh6AEY5Z+5s3b7+Dkz+wzUAtX7XLP4nlpDW9j2CAX2pqgIOGIE39MawpE1+dn9rwdjYIEX/R8UZJVnkFkK43MLub2c1q9B+oXVeICZKlEwOZm8qfo/SgichbqiIuNtILWq/aubtkvqNmvBDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJXQGzNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB7EC19422;
	Mon, 12 Jan 2026 18:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768242243;
	bh=A8H/mCgzXZ/gyGMV7iJz86MAs43bp1oMFTky1CT95Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJXQGzNytLg5S1V9c/1/LtB1gmmPnDeUcA5x3eTb+XIlJuhikxndZcqrEkrZq5jOQ
	 cvPbIU6An/LXn8Y8mZxwL8nddyHjsYFAPbBNHgsbbxif2TaW5ploE6g4PPRblh2oy0
	 bGiO069D3bcg9S7+UN0J/U/KiEgWe2V+pjfnbL0xHxzBnBZkksgUebKjzqM/UDSbzs
	 IyOGp1KvJajT+dcpYRDn0aTIhGtjeDM9TS2UePJ6Zu3k/HCpg7cRjJ8tWi5wUcy0pk
	 HQNKBEwyIGFkAftXFOgKHDvQYen/Xy845lDjDaATpIgQ0x0qGzMsKP3cwc7xHuhekD
	 34J0EJW3bfG8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] pinctrl: qcom: lpass-lpi: Remove duplicate assignment of of_gpio_n_cells
Date: Mon, 12 Jan 2026 13:23:59 -0500
Message-ID: <20260112182400.841200-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026011237-those-catatonic-066d@gregkh>
References: <2026011237-those-catatonic-066d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit a3fc976a2d68cb74ae4234314002e4e398e4c337 ]

The of_gpio_n_cells default is 2 when ->of_xlate() callback is
not defined. No need to assign it explicitly in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230112184923.80442-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Stable-dep-of: ebc18e9854e5 ("pinctrl: qcom: lpass-lpi: mark the GPIO controller as sleeping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index ec37ad43a6364..61c7f230d071e 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -644,7 +644,6 @@ static int lpi_pinctrl_probe(struct platform_device *pdev)
 	pctrl->chip.base = -1;
 	pctrl->chip.ngpio = data->npins;
 	pctrl->chip.label = dev_name(dev);
-	pctrl->chip.of_gpio_n_cells = 2;
 	pctrl->chip.can_sleep = false;
 
 	mutex_init(&pctrl->lock);
-- 
2.51.0


