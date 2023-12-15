Return-Path: <stable+bounces-6821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B28814901
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 14:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FF71C23A82
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 13:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4707830346;
	Fri, 15 Dec 2023 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zya1qhjF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065923033B
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 13:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3170FC433C8;
	Fri, 15 Dec 2023 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702646467;
	bh=OPtsVLpHLwEPJmg13bk8E3I5ELfgEDp0z6pOAgOR4a8=;
	h=Subject:To:From:Date:From;
	b=zya1qhjFGgjISEnFSpyhPIuLp+hZvaQYAoX2QYpQGwW3zCYm+K9J6rXr1EM4aQHIy
	 uc4JJEPYYWnOpdIajewWS6oJAoyBAHbMKHcf0yL9fhONtGkk151sPVgITIMBa9CEqO
	 vXuPltrYLmo64Ve4ZlMpU0rCfXHb/vyWoVqOb+Dk=
Subject: patch "serial: sc16is7xx: remove global regmap from struct sc16is7xx_port" added to tty-testing
To: hvilleneuve@dimonoff.com,andy.shevchenko@gmail.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Dec 2023 14:20:51 +0100
Message-ID: <2023121551-gopher-basis-70d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: sc16is7xx: remove global regmap from struct sc16is7xx_port

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the tty-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From f6959c5217bd799bcb770b95d3c09b3244e175c6 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 11 Dec 2023 12:13:49 -0500
Subject: serial: sc16is7xx: remove global regmap from struct sc16is7xx_port

Remove global struct regmap so that it is more obvious that this
regmap is to be used only in the probe function.

Also add a comment to that effect in probe function.

Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
Cc:  <stable@vger.kernel.org>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231211171353.2901416-3-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sc16is7xx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 8d1de4982b65..a4ad3ae8cae2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -334,7 +334,6 @@ struct sc16is7xx_one {
 
 struct sc16is7xx_port {
 	const struct sc16is7xx_devtype	*devtype;
-	struct regmap			*regmap;
 	struct clk			*clk;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip		gpio;
@@ -1434,7 +1433,8 @@ static void sc16is7xx_setup_irda_ports(struct sc16is7xx_port *s)
 /*
  * Configure ports designated to operate as modem control lines.
  */
-static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s)
+static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s,
+				       struct regmap *regmap)
 {
 	int i;
 	int ret;
@@ -1463,7 +1463,7 @@ static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s)
 
 	if (s->mctrl_mask)
 		regmap_update_bits(
-			s->regmap,
+			regmap,
 			SC16IS7XX_IOCONTROL_REG,
 			SC16IS7XX_IOCONTROL_MODEM_A_BIT |
 			SC16IS7XX_IOCONTROL_MODEM_B_BIT, s->mctrl_mask);
@@ -1495,6 +1495,10 @@ static int sc16is7xx_probe(struct device *dev,
 	 * This device does not have an identification register that would
 	 * tell us if we are really connected to the correct device.
 	 * The best we can do is to check if communication is at all possible.
+	 *
+	 * Note: regmap[0] is used in the probe function to access registers
+	 * common to all channels/ports, as it is guaranteed to be present on
+	 * all variants.
 	 */
 	ret = regmap_read(regmaps[0], SC16IS7XX_LSR_REG, &val);
 	if (ret < 0)
@@ -1530,7 +1534,6 @@ static int sc16is7xx_probe(struct device *dev,
 			return -EINVAL;
 	}
 
-	s->regmap = regmaps[0];
 	s->devtype = devtype;
 	dev_set_drvdata(dev, s);
 	mutex_init(&s->efr_lock);
@@ -1545,7 +1548,7 @@ static int sc16is7xx_probe(struct device *dev,
 	sched_set_fifo(s->kworker_task);
 
 	/* reset device, purging any pending irq / data */
-	regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG,
+	regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
 		     SC16IS7XX_IOCONTROL_SRESET_BIT);
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
@@ -1616,7 +1619,7 @@ static int sc16is7xx_probe(struct device *dev,
 
 	sc16is7xx_setup_irda_ports(s);
 
-	ret = sc16is7xx_setup_mctrl_ports(s);
+	ret = sc16is7xx_setup_mctrl_ports(s, regmaps[0]);
 	if (ret)
 		goto out_ports;
 
-- 
2.43.0



