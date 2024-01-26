Return-Path: <stable+bounces-16019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B81683E734
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5713F28A012
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61AD59168;
	Fri, 26 Jan 2024 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gs/PUC2B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EDD58AD6
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312831; cv=none; b=cH4gFeIS0D55+uy65fgTm0TLSr7+75+yVgYEZc40BIMiCrZpRBvY/czUYL9P7uaCCvIhX/0EnFIwudEMpNtJgfMEXd9paRjeypg12xMYehqNKoitOXVyys8SW5e5WiInV6cZF/FCePYtkjTydhvyNns5H8ZxXXHmDwKegnlE6nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312831; c=relaxed/simple;
	bh=89hY2Htok2/DQp2OTd+6l8Qm+MwjuexvzR+a+TyHcno=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WrSQM3vgrC5kj85ZgTXFZ28Plg4fDbPDhNNet0iacuHVqVx9Z8FC0AhAwFUrbk0/c7UdoRRtjymJDtsVkiFkk6cVRA5Jge0ePxJzU2Wjj0LAgYh3ibns4cbSB4PN6+9whDdfaLq4QGLm4usBmRafNwfbWlESkF97kw3QsvOTBy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gs/PUC2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0FDC433F1;
	Fri, 26 Jan 2024 23:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706312831;
	bh=89hY2Htok2/DQp2OTd+6l8Qm+MwjuexvzR+a+TyHcno=;
	h=Subject:To:Cc:From:Date:From;
	b=Gs/PUC2Bclu7byMfpssrYyWYRI3JnXaOqy9FrniLjFoQVjMZlC2dXWoz8j6n8AZG2
	 HslcjAFcUinzkpzIuhoDRKMa7BDP33YFES4cHrkD8InshvjyYGHc/aF5uVT/d/dmgc
	 YzdYAgnOwB5/G/RfZhJxOXZOSKyrPRE9PTGwl0Qg=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: convert from _raw_ to _noinc_ regmap" failed to apply to 4.19-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:47:10 -0800
Message-ID: <2024012610-grumbly-purge-ae51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x dbf4ab821804df071c8b566d9813083125e6d97b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012610-grumbly-purge-ae51@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

dbf4ab821804 ("serial: sc16is7xx: convert from _raw_ to _noinc_ regmap functions for FIFO")
3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
049994292834 ("serial: sc16is7xx: fix regression with GPIO configuration")
dabc54a45711 ("serial: sc16is7xx: remove obsolete out_thread label")
c8f71b49ee4d ("serial: sc16is7xx: setup GPIO controller later in probe")
267913ecf737 ("serial: sc16is7xx: Fill in rs485_supported")
21144bab4f11 ("sc16is7xx: Handle modem status lines")
cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop")
d4ab5487cc77 ("Merge 5.17-rc6 into tty-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dbf4ab821804df071c8b566d9813083125e6d97b Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 11 Dec 2023 12:13:52 -0500
Subject: [PATCH] serial: sc16is7xx: convert from _raw_ to _noinc_ regmap
 functions for FIFO

The SC16IS7XX IC supports a burst mode to access the FIFOs where the
initial register address is sent ($00), followed by all the FIFO data
without having to resend the register address each time. In this mode, the
IC doesn't increment the register address for each R/W byte.

The regmap_raw_read() and regmap_raw_write() are functions which can
perform IO over multiple registers. They are currently used to read/write
from/to the FIFO, and although they operate correctly in this burst mode on
the SPI bus, they would corrupt the regmap cache if it was not disabled
manually. The reason is that when the R/W size is more than 1 byte, these
functions assume that the register address is incremented and handle the
cache accordingly.

Convert FIFO R/W functions to use the regmap _noinc_ versions in order to
remove the manual cache control which was a workaround when using the
_raw_ versions. FIFO registers are properly declared as volatile so
cache will not be used/updated for FIFO accesses.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231211171353.2901416-6-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 0bda9b74d096..7e4b9b52841d 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -381,9 +381,7 @@ static void sc16is7xx_fifo_read(struct uart_port *port, unsigned int rxlen)
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
-	regcache_cache_bypass(one->regmap, true);
-	regmap_raw_read(one->regmap, SC16IS7XX_RHR_REG, s->buf, rxlen);
-	regcache_cache_bypass(one->regmap, false);
+	regmap_noinc_read(one->regmap, SC16IS7XX_RHR_REG, s->buf, rxlen);
 }
 
 static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
@@ -398,9 +396,7 @@ static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
 	if (unlikely(!to_send))
 		return;
 
-	regcache_cache_bypass(one->regmap, true);
-	regmap_raw_write(one->regmap, SC16IS7XX_THR_REG, s->buf, to_send);
-	regcache_cache_bypass(one->regmap, false);
+	regmap_noinc_write(one->regmap, SC16IS7XX_THR_REG, s->buf, to_send);
 }
 
 static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
@@ -492,6 +488,11 @@ static bool sc16is7xx_regmap_precious(struct device *dev, unsigned int reg)
 	return false;
 }
 
+static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
+{
+	return reg == SC16IS7XX_RHR_REG;
+}
+
 static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
@@ -1709,6 +1710,10 @@ static struct regmap_config regcfg = {
 	.cache_type = REGCACHE_RBTREE,
 	.volatile_reg = sc16is7xx_regmap_volatile,
 	.precious_reg = sc16is7xx_regmap_precious,
+	.writeable_noinc_reg = sc16is7xx_regmap_noinc,
+	.readable_noinc_reg = sc16is7xx_regmap_noinc,
+	.max_raw_read = SC16IS7XX_FIFO_SIZE,
+	.max_raw_write = SC16IS7XX_FIFO_SIZE,
 	.max_register = SC16IS7XX_EFCR_REG,
 };
 


