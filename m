Return-Path: <stable+bounces-16018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CFA83E733
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981531C27E82
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369395914E;
	Fri, 26 Jan 2024 23:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ezYzEk7h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC40558AD6
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312830; cv=none; b=QcvRGRrHpp6DNM5ljgDFGIFxqb0fHoO+Gg3yVLHYV+ArPK3N8aFVh4sA1rHV+EjROB0R+lgzpEEOIQwZm/b3pv92FD5ZLlQFDB+XHxH9l2o+WsUdCxYj47IifX/e94m/0mYUCSuQ6dLkBk6tVSJM+LM4M0Scv9dat/b8LElscRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312830; c=relaxed/simple;
	bh=L8lBD5hP9c7kJFtLci4VV7oUxRo3EkyM4JEL0uMGCP8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=al+OgzhOCx3e8hzfJFLV25U+TCgbzuR10dPrRRqRfNrxQ0WmRCR2JXf5tODDHftV2BFMz6nQ8sWWrv3dK5Cs2dvpS5f/7Da8uIwAOAmhHZ7QF5+vI8eHtSFEXHfvM+NfpCLJmNPstyBCfgm4XbYLak+lT9R171GAi7nYMLy/CI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ezYzEk7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B73C433C7;
	Fri, 26 Jan 2024 23:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706312829;
	bh=L8lBD5hP9c7kJFtLci4VV7oUxRo3EkyM4JEL0uMGCP8=;
	h=Subject:To:Cc:From:Date:From;
	b=ezYzEk7hJqFHVqftDyoe6vzakHHTu65n1e8DSF1owBM8YusJA0698vZ4co4uL2X0S
	 uukdqWhkwP4mujJMJwn3230f4vPIion63oCoTLUXt1mSxX2ou3SZv/GZZdh0R9WBZ0
	 TcY/CPlD3CrDNJyVHW1vSJ/Inw7wzxHgBN+ts56c=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: convert from _raw_ to _noinc_ regmap" failed to apply to 5.4-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:47:08 -0800
Message-ID: <2024012608-refocus-gender-343a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x dbf4ab821804df071c8b566d9813083125e6d97b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012608-refocus-gender-343a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
 


