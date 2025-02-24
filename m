Return-Path: <stable+bounces-118753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D7CA41AF2
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324927A629D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D279024C692;
	Mon, 24 Feb 2025 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XeZ1DaKF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E0824CEE4
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392910; cv=none; b=QJxwjhamXZz/Js1oPorBwcOpGuXJNeD4iIskhxrhqClvyBgwWDx6SFZWlULrIi2Y0q7PZ/93WYGwfFcQbrKJ/yDGgF/6a7eP8GP8z28eRwLKjUbf8CjR5m0Gow9X2jjBAfDNbjUz2GpDc+dyQssh3SzUHBCp5x+NLnIpxUwXK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392910; c=relaxed/simple;
	bh=83Ta2M1zpgKT8qz8s/k3dNPIgx6MuhGyOzduK98yqIY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bkw+H3wEgy72d/1JutW3LLML3D6QZvjDPbDGt3w1jnJFzuWME7N427jN+bAfl0fUj3kPwIIX4TZlC8lWy2id9YKm3eMCrSlXIkzNK3sKrnMTyZbcjqtCXxgKamyKPGTIlwxPZ4nIvYDHTV/FtTeTvq79TovnRJDbnAY3R2QQ0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XeZ1DaKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94F1C4CED6;
	Mon, 24 Feb 2025 10:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392910;
	bh=83Ta2M1zpgKT8qz8s/k3dNPIgx6MuhGyOzduK98yqIY=;
	h=Subject:To:Cc:From:Date:From;
	b=XeZ1DaKFSnM8GWeC/Jrd7mrwyuk4nipiDoJMOMJwHdJ3NbGmuRKW2KhUilblWj8Jp
	 y5+iFQQ0Xg/xTVdpxmX/34IW2NBnHiw6tQItv5RWGOjgiEZfIrA5Ng8YceqUlxJoDq
	 BU+mRGtDmZ5BPjx8Rh6KXAuNjn5l+lIDQ9ElOgQc=
Subject: FAILED: patch "[PATCH] gpio: vf610: add locking to gpio direction functions" failed to apply to 6.1-stable tree
To: johan.korsnes@remarkable.no,bartosz.golaszewski@linaro.org,brgl@bgdev.pl,haibo.chen@nxp.com,linus.walleij@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:28:10 +0100
Message-ID: <2025022410-prior-trilogy-94b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4e667a1968099c6deadee2313ecd648f8f0a8956
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022410-prior-trilogy-94b8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e667a1968099c6deadee2313ecd648f8f0a8956 Mon Sep 17 00:00:00 2001
From: Johan Korsnes <johan.korsnes@remarkable.no>
Date: Mon, 17 Feb 2025 10:16:43 +0100
Subject: [PATCH] gpio: vf610: add locking to gpio direction functions

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

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index c4f34a347cb6..c36a9dbccd4d 100644
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
 


