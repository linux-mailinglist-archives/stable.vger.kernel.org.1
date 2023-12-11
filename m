Return-Path: <stable+bounces-5514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0154A80D369
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE4D1F216C9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC594D5A6;
	Mon, 11 Dec 2023 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="pxwSLNoU"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5228DD8;
	Mon, 11 Dec 2023 09:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=xxIt/w1kc+j/AwMPEIjsWTLQoLPMTkOHcLF8iblisas=; b=pxwSLNoUqThTKTrGXJRiPaeGmT
	YsUZWVzdEWmYYGfbrY93lHLxnEwdQ4zRfW7wQgCe1tBDiFB1F0QX1JyQfQP1JD99qGydJQfVYrSxd
	EL2LmerRK0FBckjjMkFDDUwcb/rFYK+70QjFVyCLs2hEn0JkbzCAsJlO7b2IhfEwz9W0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56730 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rCjr3-0003yC-T8; Mon, 11 Dec 2023 12:14:06 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	jringle@gridpoint.com,
	tomasz.mon@camlingroup.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	stable@vger.kernel.org
Date: Mon, 11 Dec 2023 12:13:52 -0500
Message-Id: <20231211171353.2901416-6-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211171353.2901416-1-hugo@hugovil.com>
References: <20231211171353.2901416-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: [PATCH v2 5/6] serial: sc16is7xx: convert from _raw_ to _noinc_ regmap functions for FIFO
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

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
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

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
 
-- 
2.39.2


