Return-Path: <stable+bounces-190402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A688EC104C7
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 529773517E3
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B0832BF25;
	Mon, 27 Oct 2025 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ6ZBwue"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9CD2D8DB9
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591205; cv=none; b=uHibkU/g2Nxr+7LJU4lU8BWWj+IifLOimnHs4eDUE0mhb5CEzvUgzOQ7zq73MIoGv6YgSPQMkcLvfZY8rnq3z+HFwQPuLCreft743NjmU31CDnNfREfCAWaqd0rih/hG1R8WlCsoy0bni3pmdRiQhIoMmTo0B7yL10pJWrG0h6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591205; c=relaxed/simple;
	bh=InfPhsnOJHLzogaV3xy72HAtQniSF/OBdsAQ/1y5cY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYTVvCrUSuuPirpSuihty4Ve6xONJEIIKqWeEsLkXL+65Z7TqhPwHmL8rPM0pSvWvXkRL9JsmXgoMkUFby3/xGDxUJV3AymXJbug6vpZ1cq9y66/xS3unSPayhopFNlNTc4u3bwdxvEUjKlx19DmyViLTgmiVDt+IRPGS4NA+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ6ZBwue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161DAC116B1;
	Mon, 27 Oct 2025 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761591204;
	bh=InfPhsnOJHLzogaV3xy72HAtQniSF/OBdsAQ/1y5cY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQ6ZBwue7Z/nyM0zpAVEhtUJ2V65ik+0nl6257EFQcOr6EyAD+A3bxJbStXdlLW9q
	 DxZLHmkXcUxAHkDXNfxPIZLFAZrTgvKKVydMWC9x40RhM8juudvGtPmb8y+pvI6kGQ
	 H1eO2lAjsT21mCF7k0NR2PoORjRQ+bTZq8zNoZzm4qHCgA7txMvH7vtrq1bVCguMmG
	 tLu3crvV67RJV4PPfImK3x0SXdLVHgSoOlHo3MjL4H/L0MtNiCggFdir40rB4yABjr
	 YmfTfE8Fj/FN8bsg8zbVu+bxwk6l8lLtHVmwc5feqmFkdiOnNzoKQR6wZNtV+NPDyu
	 Jp1RWoaElwXnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] serial: sc16is7xx: reorder code to remove prototype declarations
Date: Mon, 27 Oct 2025 14:53:19 -0400
Message-ID: <20251027185321.644316-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027185321.644316-1-sashal@kernel.org>
References: <2025102739-fable-reroute-e6a6@gregkh>
 <20251027185321.644316-1-sashal@kernel.org>
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
index a187ae217fc4c..f87fcde9a3d49 100644
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
@@ -891,42 +924,6 @@ static void sc16is7xx_reg_proc(struct kthread_work *ws)
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


