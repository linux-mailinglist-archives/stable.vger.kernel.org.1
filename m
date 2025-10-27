Return-Path: <stable+bounces-190404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 498BDC104F7
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E4E84FEF0F
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468B331D742;
	Mon, 27 Oct 2025 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyeZS27M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFE332AAC5
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591206; cv=none; b=Seb2bl16DODpN13krALqZvISfMkv6I2aeY7/yfocuLfHXGG2CdpnhAvTvFaWIw1Gnu85NdO81zGHDhFdNx7KvwWtpjbatD7jFZLrFpoqQN6+ni+E+UodGnzBdv+Weze8l1M05gbpeXMVPQoYGY42myyUaRb7IgLk8ll2mTT6qQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591206; c=relaxed/simple;
	bh=T9mCKGaPJasIrMyH+Q4KKwEZ6sae9x4LV40CiuC7BYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4WXd21DuIbSd8LdbQ+hO2NZLbCETcX/LwWLsBFOwLN9JVYlLarsEW9ug9FyZHmFX1u6ClsPviN2h2BZqbAlyBHJvKysTt789vI5LqTwNjJO7JnNkoDuMZ0p1oPq4VspfoQj9euoRFYT+9k7QHihHw45VldMbOlNMtOqTCN2Chw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyeZS27M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D1AC113D0;
	Mon, 27 Oct 2025 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761591205;
	bh=T9mCKGaPJasIrMyH+Q4KKwEZ6sae9x4LV40CiuC7BYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KyeZS27MUrgs5FT61asLekKWnTKtWIbDr1R1CjeeMYp06tcSefcymA8CqZo7b/xfi
	 cu+PO+UwbZjZoWU0JVLnwsoEy3U3zn0+pP0wxKsl4Q5nRHDfHp7dXh9LcdlKRrjVnt
	 keDeDE2rOyoHnpVm+pDSviQM/JfXjkJjjps+0CwLmSfn64GbOXE3PR0bqIj/ie73xe
	 RLKYWinrXrqtiHFYZ3QMsdXfjaFFHvxdNtGgD0wuHV45hF4i4SSN/nyFdNsCILLsJm
	 VnNAO5dW7x0ishynuXGj2JjMmjoN4uncBCEVYbwiMYvr60VWCKqBjQJlJU0fjlurs+
	 pm2mrZBAOWveg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] serial: sc16is7xx: refactor EFR lock
Date: Mon, 27 Oct 2025 14:53:20 -0400
Message-ID: <20251027185321.644316-3-sashal@kernel.org>
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

[ Upstream commit 0c84bea0cabc4e2b98a3de88eeb4ff798931f056 ]

Move common code for EFR lock/unlock of mutex into functions for code reuse
and clarity.

With the addition of old_lcr, move irda_mode within struct sc16is7xx_one to
reduce memory usage:
    Before: /* size: 752, cachelines: 12, members: 10 */
    After:  /* size: 744, cachelines: 12, members: 10 */

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231221231823.2327894-17-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1c05bf6c0262 ("serial: sc16is7xx: remove useless enable of enhanced features")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 106 ++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 49 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index f87fcde9a3d49..c0c2c1450e88d 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -329,8 +329,9 @@ struct sc16is7xx_one {
 	struct kthread_work		reg_work;
 	struct kthread_delayed_work	ms_work;
 	struct sc16is7xx_one_config	config;
-	bool				irda_mode;
 	unsigned int			old_mctrl;
+	u8				old_lcr; /* Value before EFR access. */
+	bool				irda_mode;
 };
 
 struct sc16is7xx_port {
@@ -412,6 +413,49 @@ static void sc16is7xx_power(struct uart_port *port, int on)
 			      on ? 0 : SC16IS7XX_IER_SLEEP_BIT);
 }
 
+/*
+ * In an amazing feat of design, the Enhanced Features Register (EFR)
+ * shares the address of the Interrupt Identification Register (IIR).
+ * Access to EFR is switched on by writing a magic value (0xbf) to the
+ * Line Control Register (LCR). Any interrupt firing during this time will
+ * see the EFR where it expects the IIR to be, leading to
+ * "Unexpected interrupt" messages.
+ *
+ * Prevent this possibility by claiming a mutex while accessing the EFR,
+ * and claiming the same mutex from within the interrupt handler. This is
+ * similar to disabling the interrupt, but that doesn't work because the
+ * bulk of the interrupt processing is run as a workqueue job in thread
+ * context.
+ */
+static void sc16is7xx_efr_lock(struct uart_port *port)
+{
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+
+	mutex_lock(&one->efr_lock);
+
+	/* Backup content of LCR. */
+	one->old_lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
+
+	/* Enable access to Enhanced register set */
+	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, SC16IS7XX_LCR_CONF_MODE_B);
+
+	/* Disable cache updates when writing to EFR registers */
+	regcache_cache_bypass(one->regmap, true);
+}
+
+static void sc16is7xx_efr_unlock(struct uart_port *port)
+{
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+
+	/* Re-enable cache updates when writing to normal registers */
+	regcache_cache_bypass(one->regmap, false);
+
+	/* Restore original content of LCR */
+	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, one->old_lcr);
+
+	mutex_unlock(&one->efr_lock);
+}
+
 static void sc16is7xx_ier_clear(struct uart_port *port, u8 bit)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
@@ -538,39 +582,12 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 		div /= prescaler;
 	}
 
-	/* In an amazing feat of design, the Enhanced Features Register shares
-	 * the address of the Interrupt Identification Register, and is
-	 * switched in by writing a magic value (0xbf) to the Line Control
-	 * Register. Any interrupt firing during this time will see the EFR
-	 * where it expects the IIR to be, leading to "Unexpected interrupt"
-	 * messages.
-	 *
-	 * Prevent this possibility by claiming a mutex while accessing the
-	 * EFR, and claiming the same mutex from within the interrupt handler.
-	 * This is similar to disabling the interrupt, but that doesn't work
-	 * because the bulk of the interrupt processing is run as a workqueue
-	 * job in thread context.
-	 */
-	mutex_lock(&one->efr_lock);
-
-	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
-
-	/* Open the LCR divisors for configuration */
-	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
-			     SC16IS7XX_LCR_CONF_MODE_B);
-
 	/* Enable enhanced features */
-	regcache_cache_bypass(one->regmap, true);
+	sc16is7xx_efr_lock(port);
 	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
 			      SC16IS7XX_EFR_ENABLE_BIT,
 			      SC16IS7XX_EFR_ENABLE_BIT);
-
-	regcache_cache_bypass(one->regmap, false);
-
-	/* Put LCR back to the normal mode */
-	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
-
-	mutex_unlock(&one->efr_lock);
+	sc16is7xx_efr_unlock(port);
 
 	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
@@ -580,7 +597,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 
 	mutex_lock(&one->efr_lock);
 
-	/* Open the LCR divisors for configuration */
+	/* Backup LCR and access special register set (DLL/DLH) */
+	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
 			     SC16IS7XX_LCR_CONF_MODE_A);
 
@@ -590,7 +608,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	sc16is7xx_port_write(port, SC16IS7XX_DLL_REG, div % 256);
 	regcache_cache_bypass(one->regmap, false);
 
-	/* Put LCR back to the normal mode */
+	/* Restore LCR and access to general register set */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
 	mutex_unlock(&one->efr_lock);
@@ -1073,17 +1091,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	if (!(termios->c_cflag & CREAD))
 		port->ignore_status_mask |= SC16IS7XX_LSR_BRK_ERROR_MASK;
 
-	/* As above, claim the mutex while accessing the EFR. */
-	mutex_lock(&one->efr_lock);
-
-	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
-			     SC16IS7XX_LCR_CONF_MODE_B);
-
 	/* Configure flow control */
-	regcache_cache_bypass(one->regmap, true);
-	sc16is7xx_port_write(port, SC16IS7XX_XON1_REG, termios->c_cc[VSTART]);
-	sc16is7xx_port_write(port, SC16IS7XX_XOFF1_REG, termios->c_cc[VSTOP]);
-
 	port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS);
 	if (termios->c_cflag & CRTSCTS) {
 		flow |= SC16IS7XX_EFR_AUTOCTS_BIT |
@@ -1095,16 +1103,16 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	if (termios->c_iflag & IXOFF)
 		flow |= SC16IS7XX_EFR_SWFLOW1_BIT;
 
-	sc16is7xx_port_update(port,
-			      SC16IS7XX_EFR_REG,
-			      SC16IS7XX_EFR_FLOWCTRL_BITS,
-			      flow);
-	regcache_cache_bypass(one->regmap, false);
-
 	/* Update LCR register */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
-	mutex_unlock(&one->efr_lock);
+	/* Update EFR registers */
+	sc16is7xx_efr_lock(port);
+	sc16is7xx_port_write(port, SC16IS7XX_XON1_REG, termios->c_cc[VSTART]);
+	sc16is7xx_port_write(port, SC16IS7XX_XOFF1_REG, termios->c_cc[VSTOP]);
+	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
+			      SC16IS7XX_EFR_FLOWCTRL_BITS, flow);
+	sc16is7xx_efr_unlock(port);
 
 	/* Get baud rate generator configuration */
 	baud = uart_get_baud_rate(port, termios, old,
-- 
2.51.0


