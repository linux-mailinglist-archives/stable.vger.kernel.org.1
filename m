Return-Path: <stable+bounces-48712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ABB8FEA29
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDF41F21A45
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193BF19E7E7;
	Thu,  6 Jun 2024 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mdz1bwnv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8EE19E7EA;
	Thu,  6 Jun 2024 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683109; cv=none; b=hvtYGj2eT/Mw+Gu6AWPMxwLhXoru2eHeoTUkCS1bnJ/ESA0Sc4IhZOXIfSR5v20OM864H6tzwiqIIWruJl109zjYJa9OTQt4dBTwwDDCiM4bflc+YFLH1aK5BuPROeMlrfzQkgqvxKm0XBvfZ5AUr5Y8+H3/sBv53nxIHQmuaBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683109; c=relaxed/simple;
	bh=Wff0JAXTxo9V1xGK05HFIfYFDunc4yZHGFZx1wF7d38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEDl91n+xFWfjSS/y3MCKo0v/0FZs+rKHKF1Jj22j7/G8D4LHuX+SBuppkeRCX/6CuXGbO3WrFR+w92OU9j2F/K0NNfdIFRDT9eWsz/YRAtLiZW3FdWO3B6TKfxPX8wj1SG8nryG/tTSHRkiaB9WveYKdeSB/V/XPg/hd9t4XeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mdz1bwnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD33C32781;
	Thu,  6 Jun 2024 14:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683109;
	bh=Wff0JAXTxo9V1xGK05HFIfYFDunc4yZHGFZx1wF7d38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mdz1bwnvjHJLtqOS/4oYzamzP1lkJCRM1Utmf+j0uEWfPKk66qwLNNHY4sRPTz4XN
	 5oJsDhINzs/xNQBn4TJELp5bvtWh1ASG5GP9A80mB7p3oDpih/NvxIbyR9EjlIwRGP
	 SPAqN/6s8wnd81rLrW4PUenNYS5xSWoS5bX9iLPw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 6.6 007/744] serial: 8250_bcm7271: use default_mux_rate if possible
Date: Thu,  6 Jun 2024 15:54:39 +0200
Message-ID: <20240606131732.684998471@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doug Berger <opendmb@gmail.com>

commit 614a19b89ca43449196a8af1afac7d55c6781687 upstream.

There is a scenario when resuming from some power saving states
with no_console_suspend where console output can be generated
before the 8250_bcm7271 driver gets the opportunity to restore
the baud_mux_clk frequency. Since the baud_mux_clk is at its
default frequency at this time the output can be garbled until
the driver gets the opportunity to resume.

Since this is only an issue with console use of the serial port
during that window and the console isn't likely to use baud
rates that require alternate baud_mux_clk frequencies, allow the
driver to select the default_mux_rate if it is accurate enough.

Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
Cc: stable@vger.kernel.org
Signed-off-by: Doug Berger <opendmb@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20240424222559.1844045-1-opendmb@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_bcm7271.c |  101 +++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 41 deletions(-)

--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -676,18 +676,46 @@ static void init_real_clk_rates(struct d
 	clk_set_rate(priv->baud_mux_clk, priv->default_mux_rate);
 }
 
+static u32 find_quot(struct device *dev, u32 freq, u32 baud, u32 *percent)
+{
+	u32 quot;
+	u32 rate;
+	u64 hires_rate;
+	u64 hires_baud;
+	u64 hires_err;
+
+	rate = freq / 16;
+	quot = DIV_ROUND_CLOSEST(rate, baud);
+	if (!quot)
+		return 0;
+
+	/* increase resolution to get xx.xx percent */
+	hires_rate = div_u64((u64)rate * 10000, (u64)quot);
+	hires_baud = (u64)baud * 10000;
+
+	/* get the delta */
+	if (hires_rate > hires_baud)
+		hires_err = (hires_rate - hires_baud);
+	else
+		hires_err = (hires_baud - hires_rate);
+
+	*percent = (unsigned long)DIV_ROUND_CLOSEST_ULL(hires_err, baud);
+
+	dev_dbg(dev, "Baud rate: %u, MUX Clk: %u, Error: %u.%u%%\n",
+		baud, freq, *percent / 100, *percent % 100);
+
+	return quot;
+}
+
 static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
 			u32 baud)
 {
 	u32 percent;
 	u32 best_percent = UINT_MAX;
 	u32 quot;
+	u32 freq;
 	u32 best_quot = 1;
-	u32 rate;
-	int best_index = -1;
-	u64 hires_rate;
-	u64 hires_baud;
-	u64 hires_err;
+	u32 best_freq = 0;
 	int rc;
 	int i;
 	int real_baud;
@@ -696,44 +724,35 @@ static void set_clock_mux(struct uart_po
 	if (priv->baud_mux_clk == NULL)
 		return;
 
-	/* Find the closest match for specified baud */
-	for (i = 0; i < ARRAY_SIZE(priv->real_rates); i++) {
-		if (priv->real_rates[i] == 0)
-			continue;
-		rate = priv->real_rates[i] / 16;
-		quot = DIV_ROUND_CLOSEST(rate, baud);
-		if (!quot)
-			continue;
-
-		/* increase resolution to get xx.xx percent */
-		hires_rate = (u64)rate * 10000;
-		hires_baud = (u64)baud * 10000;
-
-		hires_err = div_u64(hires_rate, (u64)quot);
-
-		/* get the delta */
-		if (hires_err > hires_baud)
-			hires_err = (hires_err - hires_baud);
-		else
-			hires_err = (hires_baud - hires_err);
-
-		percent = (unsigned long)DIV_ROUND_CLOSEST_ULL(hires_err, baud);
-		dev_dbg(up->dev,
-			"Baud rate: %u, MUX Clk: %u, Error: %u.%u%%\n",
-			baud, priv->real_rates[i], percent / 100,
-			percent % 100);
-		if (percent < best_percent) {
-			best_percent = percent;
-			best_index = i;
-			best_quot = quot;
+	/* Try default_mux_rate first */
+	quot = find_quot(up->dev, priv->default_mux_rate, baud, &percent);
+	if (quot) {
+		best_percent = percent;
+		best_freq = priv->default_mux_rate;
+		best_quot = quot;
+	}
+	/* If more than 1% error, find the closest match for specified baud */
+	if (best_percent > 100) {
+		for (i = 0; i < ARRAY_SIZE(priv->real_rates); i++) {
+			freq = priv->real_rates[i];
+			if (freq == 0 || freq == priv->default_mux_rate)
+				continue;
+			quot = find_quot(up->dev, freq, baud, &percent);
+			if (!quot)
+				continue;
+
+			if (percent < best_percent) {
+				best_percent = percent;
+				best_freq = freq;
+				best_quot = quot;
+			}
 		}
 	}
-	if (best_index == -1) {
+	if (!best_freq) {
 		dev_err(up->dev, "Error, %d BAUD rate is too fast.\n", baud);
 		return;
 	}
-	rate = priv->real_rates[best_index];
-	rc = clk_set_rate(priv->baud_mux_clk, rate);
+	rc = clk_set_rate(priv->baud_mux_clk, best_freq);
 	if (rc)
 		dev_err(up->dev, "Error selecting BAUD MUX clock\n");
 
@@ -742,8 +761,8 @@ static void set_clock_mux(struct uart_po
 		dev_err(up->dev, "Error, baud: %d has %u.%u%% error\n",
 			baud, percent / 100, percent % 100);
 
-	real_baud = rate / 16 / best_quot;
-	dev_dbg(up->dev, "Selecting BAUD MUX rate: %u\n", rate);
+	real_baud = best_freq / 16 / best_quot;
+	dev_dbg(up->dev, "Selecting BAUD MUX rate: %u\n", best_freq);
 	dev_dbg(up->dev, "Requested baud: %u, Actual baud: %u\n",
 		baud, real_baud);
 
@@ -752,7 +771,7 @@ static void set_clock_mux(struct uart_po
 	i += (i / 2);
 	priv->char_wait = ns_to_ktime(i);
 
-	up->uartclk = rate;
+	up->uartclk = best_freq;
 }
 
 static void brcmstb_set_termios(struct uart_port *up,



