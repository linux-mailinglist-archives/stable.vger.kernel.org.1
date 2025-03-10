Return-Path: <stable+bounces-121951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43FCA59D22
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6EA16CCC2
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAD5230988;
	Mon, 10 Mar 2025 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pD0xVzWx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1981C374EA;
	Mon, 10 Mar 2025 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627102; cv=none; b=RinQMwEql+7e71ji8/XjEsqU1IphmO/EbUBboZRxxvsjer++xMEBn9hzUpEKZzocnMtT4BvhyRo/fVcJojL9y4GzC0MAM5uJpHkNjlxaT2OG8AxOc9UiRunfB/3L6SvA0xayQsmTmC9ewWreNiqS/xWnysX8i4NmJBATgCuN3S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627102; c=relaxed/simple;
	bh=SUxduCipxsHqlGhaXryYK+BTcVLX03aks4nYD+W2kng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tu04J2LjjLOrnbOFC5/VF6JSwflhuXdAvWXEYsVSSNwtciEnwdTJxoTJwuWMN1MwzDWIKhxT3jq2cL2ktPyDd4Wd4O6v5G5ok6VGZSJB9NEx5aFnVzPuTOW6G4SB47aps2OSLuS1tNusRwalZz8Ctwyk0nyd8mo50stnl/EmJKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pD0xVzWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27416C4CEE5;
	Mon, 10 Mar 2025 17:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627101;
	bh=SUxduCipxsHqlGhaXryYK+BTcVLX03aks4nYD+W2kng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pD0xVzWxLGJcjTjIyWHX3mbbloi1c6oHFQ9XnDiL/2hzo9ibD0WGepfw32KmRIX3K
	 5hWDjpNfKObDWYe4fXLroTppVBUUaXmhNB8cMmRjLHukJBmW7yOkyqzDE8yie7h5PU
	 5hJ/BUBf9iwLYbxykoCW0JAEzWZv1YGsPF8Byob0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Korsnes <johan.korsnes@remarkable.no>,
	Linus Walleij <linus.walleij@linaro.org>,
	Haibo Chen <haibo.chen@nxp.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 006/269] gpio: vf610: add locking to gpio direction functions
Date: Mon, 10 Mar 2025 18:02:39 +0100
Message-ID: <20250310170457.960305464@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
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

From: Johan Korsnes <johan.korsnes@remarkable.no>

[ Upstream commit 4e667a1968099c6deadee2313ecd648f8f0a8956 ]

Add locking to `vf610_gpio_direction_input|output()` functions. Without
this locking, a race condition exists between concurrent calls to these
functions, potentially leading to incorrect GPIO direction settings.

To verify the correctness of this fix, a `trylock` patch was applied,
where after a couple of reboots the race was confirmed. I.e., one user
had to wait before acquiring the lock. With this patch the race has not
been encountered. It's worth mentioning that any type of debugging
(printing, tracing, etc.) would "resolve"/hide the issue.

Fixes: 659d8a62311f ("gpio: vf610: add imx7ulp support")
Signed-off-by: Johan Korsnes <johan.korsnes@remarkable.no>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250217091643.679644-1-johan.korsnes@remarkable.no
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-vf610.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index c4f34a347cb6e..c36a9dbccd4dd 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -36,6 +36,7 @@ struct vf610_gpio_port {
 	struct clk *clk_port;
 	struct clk *clk_gpio;
 	int irq;
+	spinlock_t lock; /* protect gpio direction registers */
 };
 
 #define GPIO_PDOR		0x00
@@ -124,6 +125,7 @@ static int vf610_gpio_direction_input(struct gpio_chip *chip, unsigned int gpio)
 	u32 val;
 
 	if (port->sdata->have_paddr) {
+		guard(spinlock_irqsave)(&port->lock);
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val &= ~mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
@@ -142,6 +144,7 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio
 	vf610_gpio_set(chip, gpio, value);
 
 	if (port->sdata->have_paddr) {
+		guard(spinlock_irqsave)(&port->lock);
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val |= mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
@@ -297,6 +300,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	port->sdata = device_get_match_data(dev);
+	spin_lock_init(&port->lock);
 
 	dual_base = port->sdata->have_dual_base;
 
-- 
2.39.5




