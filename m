Return-Path: <stable+bounces-158043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B97F3AE5702
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6343B13D4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D8A22370A;
	Mon, 23 Jun 2025 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R4S+xbjj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BDF199FBA;
	Mon, 23 Jun 2025 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717343; cv=none; b=AUt4UCB8CiRVOgtFBtZGR6ogH5c43Ids4lau1M9aD4OTkejmTbIgwphrTX2JHqR0uRIGsP/KZvFUaY4tHcu75IwbalIg2fF5EUoLWUYzCWkl0x+C9u4hwa+AeyyKlSKbMjUtK3JwpYM5ubVgPsbqP8ZokMs6G6wHdXFKh57tlDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717343; c=relaxed/simple;
	bh=fImO82QCXva0QjAm1ZUP5Vuy5zxL5Z2vdgkKYvxcSsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9z7SAQpgBtkpR6ldqYcpaFK4lGDEPnpHjdKRnKmY++kfYAjZtYve6fqaaZ/L2FXtSzEikAJs0x3Tuoh6aHgCpvswMVyV+9N0vED2nXy4cNuNa0zQigzpxw0cXbhB4wAR0jnxBY6DYWe4RfBg2SJN/YaQyTU72t6dqG4r02bcSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R4S+xbjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B71C4CEEA;
	Mon, 23 Jun 2025 22:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717343;
	bh=fImO82QCXva0QjAm1ZUP5Vuy5zxL5Z2vdgkKYvxcSsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4S+xbjjgJbwDz0/zqed0i9kHvGvAcjDhu/WIreIEDPFB2pOXUpDtSteBJK8Q0mSA
	 HhdObN7tBsmD5RvmR9kgLw4xRvau4dc2ZZgCrlKURwftWv5J46/O9YJOOo7s1C4rDy
	 SwhHGKxn7h4UkXHMahQ04wjJs0TQWUn3SycqNdV4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Imre Kaloz <kaloz@openwrt.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gabor Juhos <j4g8y7@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 408/508] pinctrl: armada-37xx: propagate error from armada_37xx_pmx_gpio_set_direction()
Date: Mon, 23 Jun 2025 15:07:33 +0200
Message-ID: <20250623130655.266302435@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabor Juhos <j4g8y7@gmail.com>

[ Upstream commit bfa0ff804ffa8b1246ade8be08de98c9eb19d16f ]

The armada_37xx_gpio_direction_{in,out}put() functions can fail, so
propagate their error values back to the stack instead of silently
ignoring those.

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Link: https://lore.kernel.org/20250514-pinctrl-a37xx-fixes-v2-5-07e9ac1ab737@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index e9032359a68a5..3ada8dcaa806b 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -474,16 +474,17 @@ static int armada_37xx_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 {
 	struct armada_37xx_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
 	struct gpio_chip *chip = range->gc;
+	int ret;
 
 	dev_dbg(info->dev, "gpio_direction for pin %u as %s-%d to %s\n",
 		offset, range->name, offset, input ? "input" : "output");
 
 	if (input)
-		armada_37xx_gpio_direction_input(chip, offset);
+		ret = armada_37xx_gpio_direction_input(chip, offset);
 	else
-		armada_37xx_gpio_direction_output(chip, offset, 0);
+		ret = armada_37xx_gpio_direction_output(chip, offset, 0);
 
-	return 0;
+	return ret;
 }
 
 static int armada_37xx_gpio_request_enable(struct pinctrl_dev *pctldev,
-- 
2.39.5




