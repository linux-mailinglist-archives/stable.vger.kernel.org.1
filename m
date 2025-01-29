Return-Path: <stable+bounces-111162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC943A21E97
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF46E18834EA
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A0F1E47A6;
	Wed, 29 Jan 2025 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZeELPlO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D029E1E3DFE;
	Wed, 29 Jan 2025 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159400; cv=none; b=VA4lEIcq5OmsOfeacimEwO9O83WY0yb1bmiErVG7xuE4CnOSoRyj9pDvRgkEfkrJsvf7J874YJPPkcdKC9Hq81NhKtsjgtR3knlSdFT30Zz9ONugyB4JIBM1QZ+1cLoGLjZvKEhUB8iWnitPbU1Q0JLREqfO1vaXCKvJKx/XHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159400; c=relaxed/simple;
	bh=txzWVqkcunSac7CoAt8XZJ1LjqwwXpm7uNfSmkgrVrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iNu3V7yrxGLQbi9bXgmAXMdGsIufszJs9nC5+byACH4StBxBvF/zPbD77P+DS0iaXJfUrlW5Ho3QKFLtmbaIbcXZc4dzWOLdm7dkLVVn/oH0MgvQd3spGEkEnL7W9xnQWHzKrfEMUT7hglxGXtPmJ9BKTK3fJbBGDqyU//n3XJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZeELPlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFF2C4CED1;
	Wed, 29 Jan 2025 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159400;
	bh=txzWVqkcunSac7CoAt8XZJ1LjqwwXpm7uNfSmkgrVrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZeELPlOrkhMpx+hXRZI3yKm9LAJxg6BzqcJGtf9CIckk7c0BbRqFtRIVxHmdNih9
	 BdseRfW/YYErS+R24JMeOMy2O4hINLzaBveZwbW5l4Mc9a5ujA6HBGphhqZXDcGwBX
	 Hsfqy9B9ARgZKI+G80fx1MgBCAkRZDku3NUGUjkR8aAcS5cMV6H3OdTCXR08cTebfL
	 B/f6xPedwPxN1ZUo7Eipgc33zLxQVXs0cI3FUuYbFT5ozaNNLfwUfe5J1CJ9vVnkwi
	 qDddfiw7LHVze1L18bxN/7EmlnwRa1NOpfHW++i132fFNV40tNA8zDz6LGBW2uIa0W
	 nzWJda+VR2pZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rengarajan S <rengarajan.s@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	kumaravel.thiagarajan@microchip.com,
	tharunkumar.pasumarthi@microchip.com,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 3/8] 8250: microchip: pci1xxxx: Add workaround for RTS bit toggle
Date: Wed, 29 Jan 2025 07:59:23 -0500
Message-Id: <20250129125930.1273051-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129125930.1273051-1-sashal@kernel.org>
References: <20250129125930.1273051-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Rengarajan S <rengarajan.s@microchip.com>

[ Upstream commit e95cb63e57381f00d9274533ea7fd0ac3bf4e5b0 ]

In the B0 revision, the RTS pin remains high due to incorrect hardware
mapping. To address this issue, enable auto-direction control with the
RTS bit in ADCL_CFG_REG. This configuration ensures that the RTS pin
goes low when the terminal is opened and high when the terminal is
closed. Additionally, we reset the step counter for Rx and Tx engines
by writing into FRAC_DIV_CFG_REG.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
Link: https://lore.kernel.org/r/20241218094017.18290-1-rengarajan.s@microchip.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 60 ++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index d3930bf32fe4c..f462b3d1c104c 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -78,6 +78,12 @@
 #define UART_TX_BYTE_FIFO			0x00
 #define UART_FIFO_CTL				0x02
 
+#define UART_MODEM_CTL_REG			0x04
+#define UART_MODEM_CTL_RTS_SET			BIT(1)
+
+#define UART_LINE_STAT_REG			0x05
+#define UART_LINE_XMIT_CHECK_MASK		GENMASK(6, 5)
+
 #define UART_ACTV_REG				0x11
 #define UART_BLOCK_SET_ACTIVE			BIT(0)
 
@@ -94,6 +100,7 @@
 #define UART_BIT_SAMPLE_CNT_16			16
 #define BAUD_CLOCK_DIV_INT_MSK			GENMASK(31, 8)
 #define ADCL_CFG_RTS_DELAY_MASK			GENMASK(11, 8)
+#define FRAC_DIV_TX_END_POINT_MASK		GENMASK(23, 20)
 
 #define UART_WAKE_REG				0x8C
 #define UART_WAKE_MASK_REG			0x90
@@ -134,6 +141,11 @@
 #define UART_BST_STAT_LSR_FRAME_ERR		0x8000000
 #define UART_BST_STAT_LSR_THRE			0x20000000
 
+#define GET_MODEM_CTL_RTS_STATUS(reg)		((reg) & UART_MODEM_CTL_RTS_SET)
+#define GET_RTS_PIN_STATUS(val)			(((val) & TIOCM_RTS) >> 1)
+#define RTS_TOGGLE_STATUS_MASK(val, reg)	(GET_MODEM_CTL_RTS_STATUS(reg) \
+						 != GET_RTS_PIN_STATUS(val))
+
 struct pci1xxxx_8250 {
 	unsigned int nr;
 	u8 dev_rev;
@@ -254,6 +266,47 @@ static void pci1xxxx_set_divisor(struct uart_port *port, unsigned int baud,
 	       port->membase + UART_BAUD_CLK_DIVISOR_REG);
 }
 
+static void pci1xxxx_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	u32 fract_div_cfg_reg;
+	u32 line_stat_reg;
+	u32 modem_ctl_reg;
+	u32 adcl_cfg_reg;
+
+	adcl_cfg_reg = readl(port->membase + ADCL_CFG_REG);
+
+	/* HW is responsible in ADCL_EN case */
+	if ((adcl_cfg_reg & (ADCL_CFG_EN | ADCL_CFG_PIN_SEL)))
+		return;
+
+	modem_ctl_reg = readl(port->membase + UART_MODEM_CTL_REG);
+
+	serial8250_do_set_mctrl(port, mctrl);
+
+	if (RTS_TOGGLE_STATUS_MASK(mctrl, modem_ctl_reg)) {
+		line_stat_reg = readl(port->membase + UART_LINE_STAT_REG);
+		if (line_stat_reg & UART_LINE_XMIT_CHECK_MASK) {
+			fract_div_cfg_reg = readl(port->membase +
+						  FRAC_DIV_CFG_REG);
+
+			writel((fract_div_cfg_reg &
+			       ~(FRAC_DIV_TX_END_POINT_MASK)),
+			       port->membase + FRAC_DIV_CFG_REG);
+
+			/* Enable ADC and set the nRTS pin */
+			writel((adcl_cfg_reg | (ADCL_CFG_EN |
+			       ADCL_CFG_PIN_SEL)),
+			       port->membase + ADCL_CFG_REG);
+
+			/* Revert to the original settings */
+			writel(adcl_cfg_reg, port->membase + ADCL_CFG_REG);
+
+			writel(fract_div_cfg_reg, port->membase +
+			       FRAC_DIV_CFG_REG);
+		}
+	}
+}
+
 static int pci1xxxx_rs485_config(struct uart_port *port,
 				 struct ktermios *termios,
 				 struct serial_rs485 *rs485)
@@ -631,9 +684,14 @@ static int pci1xxxx_setup(struct pci_dev *pdev,
 	port->port.rs485_config = pci1xxxx_rs485_config;
 	port->port.rs485_supported = pci1xxxx_rs485_supported;
 
-	/* From C0 rev Burst operation is supported */
+	/*
+	 * C0 and later revisions support Burst operation.
+	 * RTS workaround in mctrl is applicable only to B0.
+	 */
 	if (rev >= 0xC0)
 		port->port.handle_irq = pci1xxxx_handle_irq;
+	else if (rev == 0xB0)
+		port->port.set_mctrl = pci1xxxx_set_mctrl;
 
 	ret = serial8250_pci_setup_port(pdev, port, 0, PORT_OFFSET * port_idx, 0);
 	if (ret < 0)
-- 
2.39.5


