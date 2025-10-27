Return-Path: <stable+bounces-190151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE219C100EC
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED28919C571D
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFBC2D8DB9;
	Mon, 27 Oct 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZUyVh6v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB45320A0E
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590570; cv=none; b=UpaIw86PEa1bApmvd7tLmcO3AoA4ZZpURERSr+6jdzRH0MZwB6RnFc/8P7V9vUP97r0iIWm1Pw55+vMy6d5ncC9Nay6h6ODQIH08NwikE10TZFT6vmiCe/uiO8hCRIHexnQOiVonsAJK0A3Yo1m69RYke+fd/JSe/+sqpIojDMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590570; c=relaxed/simple;
	bh=lnulCHohDIPF8VbFj/wYQCUp5vF7xYDzkESlnzNHWUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUkTiAgAdcEo/cwnfzF+ZSRB3LYXyeaxNE8xMbOQrCUeCMQaz95LT6Rncy9OWKJlQJJ2Oc4ozDibKKvye6z4Olw5U5sTjnjWFgv8scGK9SfRgrjBWUGu9ZA8RReUhdabPSbDadGtGSM4lRhYI4bWmsR9gYklGR3tzwPMMZ2mj+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZUyVh6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DE5C113D0;
	Mon, 27 Oct 2025 18:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761590570;
	bh=lnulCHohDIPF8VbFj/wYQCUp5vF7xYDzkESlnzNHWUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZUyVh6vzkABKMUbr9Jw+N1nsCjVgwA2vMr9LPCIsXCojZ/e/NYb9H6JSdQ4Bly54
	 PerTZnU3mUb8JGHeWqVEc8dtXknKDimEBYUNjCAiCPGs6KZa7OwesMbUwEFY07vW7/
	 rTjn8lAio1WImaKU0CEj/JVPhzo6M3B5e/w1wbGZb6h3zh5qbHH8TeFCmrDKqB8pT3
	 PW4n5z0VBAYwi00I4+N/fX6Q+2/tvzwmmaV2zYR2VG/pRxlFc4ENsAgCGNJR4Qs/Qm
	 ZOSjHmAw8uJjTaGWuLCmRE7RE9kBeo++yaL78zX4LBR5uc8FxyfFFp4yklGwaViEJ8
	 eV44o0S+1OlMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] serial: sc16is7xx: reorder code to remove prototype declarations
Date: Mon, 27 Oct 2025 14:42:44 -0400
Message-ID: <20251027184246.638748-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027184246.638748-1-sashal@kernel.org>
References: <2025102739-casualty-hankering-f9ab@gregkh>
 <20251027184246.638748-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 2de8a1b46756b5a79d8447f99afdfe49e914225a ]

Move/reorder some functions to remove sc16is7xx_ier_set() and
sc16is7xx_stop_tx() prototypes declarations.

No functional change.

sc16is7xx_ier_set() was introduced in
commit cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop").

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231221231823.2327894-16-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1c05bf6c0262 ("serial: sc16is7xx: remove useless enable of enhanced features")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 75 ++++++++++++++++------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 847ed5b155aad..3e4bdc62ae0bb 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -355,9 +355,6 @@ static struct uart_driver sc16is7xx_uart = {
 	.nr		= SC16IS7XX_MAX_DEVS,
 };
 
-static void sc16is7xx_ier_set(struct uart_port *port, u8 bit);
-static void sc16is7xx_stop_tx(struct uart_port *port);
-
 #define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
 
 static u8 sc16is7xx_port_read(struct uart_port *port, u8 reg)
@@ -415,6 +412,42 @@ static void sc16is7xx_power(struct uart_port *port, int on)
 			      on ? 0 : SC16IS7XX_IER_SLEEP_BIT);
 }
 
+static void sc16is7xx_ier_clear(struct uart_port *port, u8 bit)
+{
+	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+
+	lockdep_assert_held_once(&port->lock);
+
+	one->config.flags |= SC16IS7XX_RECONF_IER;
+	one->config.ier_mask |= bit;
+	one->config.ier_val &= ~bit;
+	kthread_queue_work(&s->kworker, &one->reg_work);
+}
+
+static void sc16is7xx_ier_set(struct uart_port *port, u8 bit)
+{
+	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+
+	lockdep_assert_held_once(&port->lock);
+
+	one->config.flags |= SC16IS7XX_RECONF_IER;
+	one->config.ier_mask |= bit;
+	one->config.ier_val |= bit;
+	kthread_queue_work(&s->kworker, &one->reg_work);
+}
+
+static void sc16is7xx_stop_tx(struct uart_port *port)
+{
+	sc16is7xx_ier_clear(port, SC16IS7XX_IER_THRI_BIT);
+}
+
+static void sc16is7xx_stop_rx(struct uart_port *port)
+{
+	sc16is7xx_ier_clear(port, SC16IS7XX_IER_RDI_BIT);
+}
+
 static const struct sc16is7xx_devtype sc16is74x_devtype = {
 	.name		= "SC16IS74X",
 	.nr_gpio	= 0,
@@ -888,42 +921,6 @@ static void sc16is7xx_reg_proc(struct kthread_work *ws)
 		sc16is7xx_reconf_rs485(&one->port);
 }
 
-static void sc16is7xx_ier_clear(struct uart_port *port, u8 bit)
-{
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
-
-	lockdep_assert_held_once(&port->lock);
-
-	one->config.flags |= SC16IS7XX_RECONF_IER;
-	one->config.ier_mask |= bit;
-	one->config.ier_val &= ~bit;
-	kthread_queue_work(&s->kworker, &one->reg_work);
-}
-
-static void sc16is7xx_ier_set(struct uart_port *port, u8 bit)
-{
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
-
-	lockdep_assert_held_once(&port->lock);
-
-	one->config.flags |= SC16IS7XX_RECONF_IER;
-	one->config.ier_mask |= bit;
-	one->config.ier_val |= bit;
-	kthread_queue_work(&s->kworker, &one->reg_work);
-}
-
-static void sc16is7xx_stop_tx(struct uart_port *port)
-{
-	sc16is7xx_ier_clear(port, SC16IS7XX_IER_THRI_BIT);
-}
-
-static void sc16is7xx_stop_rx(struct uart_port *port)
-{
-	sc16is7xx_ier_clear(port, SC16IS7XX_IER_RDI_BIT);
-}
-
 static void sc16is7xx_ms_proc(struct kthread_work *ws)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(ws, ms_work.work);
-- 
2.51.0


