Return-Path: <stable+bounces-104393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE799F3997
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 20:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE0D16ACC9
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 19:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B3F2080F0;
	Mon, 16 Dec 2024 19:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="vEa93dtT"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B3207E00;
	Mon, 16 Dec 2024 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376729; cv=none; b=Z/3btimYkxh4l8R9A6U+IMc+vra2lwGUM4o/3W9Ywb+dN9yDF9/rmXzzlL4aE9AEw7wTVI+ozCZpHT/o+BtNKEoYXF7IUDbZqzsbZ/kGM3BkW6hXJo1z5Dw7+ZxM3jvCVbkPoeU9eUjExmMPXQ7Sebc+W4lIPioBMsijIGH55s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376729; c=relaxed/simple;
	bh=WwFYAwt27fCugB/li54GwmTHrX1sUMJ3OKtLrIAeSEA=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=G0T4Rlvg30ccuMjn/6Dmz20IPyWSYkKrtFVRONpe8BvPQ3HIVh3T8o1y5W8m5XeXaIpxv6lb9GwkFLgmieWKjKmXglGRoUvI8Hfd0TtTEGF1dtA0haLmh++7bvXAZHL3feq6HTea7Etfgx0UTq6gSDK8z0g55gxKrTzZ0MQVJdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=vEa93dtT; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=0QAk008WYmWY1Bk09fKOFWYuqb0WfbqZTl0M750e2xM=; b=vEa93dtTqvFH38Z2Q3FuQqVzaX
	bqtKE7Y6DF6+ux/odhoovtwm+Gd5ckjNaKBEZ0I4wdZQ9DXf8T+TyXh5dZgzj/hVaFJ1lq9vuGvMu
	Vtig5N+1ETKCvTTB4yzaoTCPRoGXywXFvWOJB/UlVHpzCMgPpVUmO74t38AD3KH6XB/w=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:42958 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1tNGc6-0002CS-Ve; Mon, 16 Dec 2024 14:18:43 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com,
	hui.wang@canonical.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Mon, 16 Dec 2024 14:18:16 -0500
Message-Id: <20241216191818.1553557-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216191818.1553557-1-hugo@hugovil.com>
References: <20241216191818.1553557-1-hugo@hugovil.com>
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
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH 2/4] serial: sc16is7xx: refactor FIFO access functions to increase commonality
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Simplify FIFO access functions by avoiding to declare
a struct sc16is7xx_port *s variable within each function.

This is mainly done to have more commonality between the max310x and
sc16is7xx drivers.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231221231823.2327894-15-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sc16is7xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 3d3f66563b73b..591f97e78cdb7 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -361,17 +361,15 @@ static void sc16is7xx_port_write(struct uart_port *port, u8 reg, u8 val)
 	regmap_write(one->regmap, reg, val);
 }
 
-static void sc16is7xx_fifo_read(struct uart_port *port, unsigned int rxlen)
+static void sc16is7xx_fifo_read(struct uart_port *port, u8 *rxbuf, unsigned int rxlen)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
-	regmap_noinc_read(one->regmap, SC16IS7XX_RHR_REG, s->buf, rxlen);
+	regmap_noinc_read(one->regmap, SC16IS7XX_RHR_REG, rxbuf, rxlen);
 }
 
-static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
+static void sc16is7xx_fifo_write(struct uart_port *port, u8 *txbuf, u8 to_send)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
 	/*
@@ -381,7 +379,7 @@ static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
 	if (unlikely(!to_send))
 		return;
 
-	regmap_noinc_write(one->regmap, SC16IS7XX_THR_REG, s->buf, to_send);
+	regmap_noinc_write(one->regmap, SC16IS7XX_THR_REG, txbuf, to_send);
 }
 
 static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
@@ -583,7 +581,7 @@ static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
 			s->buf[0] = sc16is7xx_port_read(port, SC16IS7XX_RHR_REG);
 			bytes_read = 1;
 		} else {
-			sc16is7xx_fifo_read(port, rxlen);
+			sc16is7xx_fifo_read(port, s->buf, rxlen);
 			bytes_read = rxlen;
 		}
 
@@ -670,7 +668,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		}
 
-		sc16is7xx_fifo_write(port, to_send);
+		sc16is7xx_fifo_write(port, s->buf, to_send);
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-- 
2.39.5


