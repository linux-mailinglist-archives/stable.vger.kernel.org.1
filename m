Return-Path: <stable+bounces-164619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BFAB10DD3
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 16:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4910E3BAB88
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1E82E2652;
	Thu, 24 Jul 2025 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o++Usffs"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDAC1632C8;
	Thu, 24 Jul 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367990; cv=none; b=cIR94WcfY5EpLRrSgohIT3HH2rysgA+Y0fGZh6OfCpSSBsQ6TgbLSmKCsyEipduHPLNz8GDMNMiJBLz7PNJLZkzmYNTgcDxTa6Vnz7rkp0dWMFzgbc3L4ixz9P9P8mGe8lJ1KErtMdogM5+iKXaqWqD53K3uMNa5KbdkGcoqYMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367990; c=relaxed/simple;
	bh=xg2atMU/cA+E9kWDYocMv4tlsJgUDqoy5fxUbDfUXlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BY0hQqCaRDoPzEeeRlI39LohJHklBQWGi7l0YC6d/MzpCrQ7YC9JoaY7FY3X+lBtVeyM870OKR7i0oRwWdhm/THPhUJi5rl9jxfvdch3kq20EHQV0eSXYQoPuppmHNLKQYk1DMDCJYqBpPyxCPNLM4a0Aq4x50gSelnJ3autE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o++Usffs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753367986;
	bh=xg2atMU/cA+E9kWDYocMv4tlsJgUDqoy5fxUbDfUXlg=;
	h=From:Date:Subject:To:Cc:From;
	b=o++Usffs2STqsJCEKZag/TIYBLHnlf6S/vzpky7JztXxcvbY1cROpmwvdjuGqjV7E
	 qOd67tWGpyJTWmDrA0/nP9jOFQD5NqjvJGNHWdP53PQ0gEr+CQe44JuLSB0Y/CvoMK
	 iNI3A9Xc80BdW5mWCDlDrGM/NwmxLkaSx79tbEn+YghKYnsLSb/HgyFWJNB3QK3KH9
	 kduDeYMBNn0AJ8xdfMP27nfzBXfeF964hwMjSpRgYnji9k6DLSmjRfDhAysqf7TMS9
	 UDw0xvoejzdQNrPrXnh3gm0W14qkpdTiC5MhgXgkQSf37OAWisu83p52jmRyZ7LmPf
	 dU7cJiIVoLUDA==
Received: from jupiter.universe (dyndsl-091-248-210-114.ewe-ip-backbone.de [91.248.210.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 72FB617E0188;
	Thu, 24 Jul 2025 16:39:46 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 39E0D480039; Thu, 24 Jul 2025 16:39:46 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 24 Jul 2025 16:39:42 +0200
Subject: [PATCH net v2] net: phy: realtek: Reset after clock enable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-phy-realtek-clock-fix-v2-1-ae53e341afb7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAK1FgmgC/4WNTQqDMBCFryKz7pSY+NO66j2KC41TDUoikxAqk
 rs3eIEu3/d43zvBExvy0BUnMEXjjbM5yFsBehnsTGimnEEKWYtWVLgvBzINW6AV9eb0ih/zxUZ
 P6qnooUc5QN7uTBlf3jdYCtBnuBgfHB/XVyyv6o82llhio0alJimqWrWvldjSdnc8Q59S+gG+D
 FyPwAAAAA==
X-Change-ID: 20250704-phy-realtek-clock-fix-6cd393e8cb2a
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Detlev Casanova <detlev.casanova@collabora.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, stable@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3041; i=sre@kernel.org;
 h=from:subject:message-id; bh=xg2atMU/cA+E9kWDYocMv4tlsJgUDqoy5fxUbDfUXlg=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGiCRbJ/xtvcileJVIl8LJxn9j7Jf26r56TdP
 il8Ob78nspdyIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJogkWyAAoJENju1/PI
 O/qawAoP/2BnLWGbH9smbQPfj88LlvRMoYRUSyHLmHdDSjR1xRrkdBbUF28+l702Mw6u0sllwx+
 TXvMSOZnVTC3vPRBnW3kTl5EndmQUk/4Ui43Glb4xrtLBoiwFq23JEXxcNhUkKwTKrZlZaOD/SG
 HF4i5+UXBdxRjXXDcpUhXn0e6KfeT/sluNi08y0IhqVTX+nU0xabXWCfIHr7Xq5IyFzEXmZ1Tbi
 Gbxeb8kszJa2s9dkk/ZvWF3qJQ1fm6EuGuowwMbBWHTVxl+RDgW1t/07ImyOzjzLalGKRusJSc6
 CqK6k+GpArYxDqGpBdRQfaMFro2B0V1+jLRjceSKwGLF6yGXaHksoR+0aaWXgcfnoWl/qWLughJ
 bCbHyp2F4SxzIAM6KrGhV0hCwjSHbCYhC5ExS3+t/W936Pe/00eJQjSMHW1AHYO6nYRqu4mX8nG
 m3QNIoIJLoDQxhMyoaHz/wqUSC/hIOFSKBjRo4h0VMUurKg7FW1D0qK6IU/8g79OUuDLW5luP0o
 rtYhsWPZ7uC0c/2fL3/tTGDZXrm0cveXDqfqPUH/y9coSsSoGz+WPQvdPLhqRN16DFgafhp+6FU
 uK0UaDVbUMNWG48gcnI2iow3glAOw0A4vNNUVI4T/kv1NbS2uSmg49O2UAP5gA/pwyLDv61y6vo
 IYtDXmoUh3C8AVIwHWOsvPQ==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

On Radxa ROCK 4D boards we are seeing some issues with PHY detection and
stability (e.g. link loss or not capable of transceiving packages) after
new board revisions switched from a dedicated crystal to providing the
25 MHz PHY input clock from the SoC instead.

This board is using a RTL8211F PHY, which is connected to an always-on
regulator. Unfortunately the datasheet does not explicitly mention the
power-up sequence regarding the clock, but it seems to assume that the
clock is always-on (i.e. dedicated crystal).

By doing an explicit reset after enabling the clock, the issue on the
boards could no longer be observed.

Note, that the RK3576 SoC used by the ROCK 4D board does not yet
support system level PM, so the resume path has not been tested.

Cc: stable@vger.kernel.org
Fixes: 7300c9b574cc ("net: phy: realtek: Add optional external PHY clock")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Changes in v2:
- Switch to PHY_RST_AFTER_CLK_EN + phy_reset_after_clk_enable(); the
  API is so far only used by the freescale/NXP MAC driver and does
  not seem to be written for usage from within the PHY driver, but
  I also don't see a good reason not to use it.
- Also reset after re-enabling the clock in rtl821x_resume()
- Link to v1: https://lore.kernel.org/r/20250704-phy-realtek-clock-fix-v1-1-63b33d204537@kernel.org
---
 drivers/net/phy/realtek/realtek_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index c3dcb62574303374666b46a454cd4e10de455d24..cf128af0ec0c778262d70d6dc4524d06cbfccf1f 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -230,6 +230,7 @@ static int rtl821x_probe(struct phy_device *phydev)
 	if (IS_ERR(priv->clk))
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "failed to get phy clock\n");
+	phy_reset_after_clk_enable(phydev);
 
 	ret = phy_read_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1);
 	if (ret < 0)
@@ -627,8 +628,10 @@ static int rtl821x_resume(struct phy_device *phydev)
 	struct rtl821x_priv *priv = phydev->priv;
 	int ret;
 
-	if (!phydev->wol_enabled)
+	if (!phydev->wol_enabled) {
 		clk_prepare_enable(priv->clk);
+		phy_reset_after_clk_enable(phydev);
+	}
 
 	ret = genphy_resume(phydev);
 	if (ret < 0)
@@ -1617,7 +1620,7 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtl821x_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
-		.flags		= PHY_ALWAYS_CALL_SUSPEND,
+		.flags		= PHY_ALWAYS_CALL_SUSPEND | PHY_RST_AFTER_CLK_EN,
 		.led_hw_is_supported = rtl8211x_led_hw_is_supported,
 		.led_hw_control_get = rtl8211f_led_hw_control_get,
 		.led_hw_control_set = rtl8211f_led_hw_control_set,

---
base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
change-id: 20250704-phy-realtek-clock-fix-6cd393e8cb2a

Best regards,
-- 
Sebastian Reichel <sre@kernel.org>


