Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E26775C1B
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjHILX5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjHILX4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1B419A1
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B6E763236
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47704C433C7;
        Wed,  9 Aug 2023 11:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580234;
        bh=oh5YTeWtFtYhqYP0jIGuJbtKviybn2hcfZ1MW1iT3a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rKKmGbzsjkrnfaEpURrhpY6y4xOJP3DewEI6W1Usu1k2jIsF+5NQoj3Lvt9VdJ67L
         Ve9yyuFo4FujdamEK3j0mpPgr55mcqKWHhJ4++NQ5cp+dyFvz6n9gyVYX/5CexaIG/
         H/RnYvRv9PqgO1qgsaL7aLF+JPAF/KXwY1nQtxUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 276/323] serial: 8250_dw: split Synopsys DesignWare 8250 common functions
Date:   Wed,  9 Aug 2023 12:41:54 +0200
Message-ID: <20230809103710.680481947@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 136e0ab99b22378e3ff7d54f799a3a329316e869 ]

We would like to use same functions in the couple of drivers for
Synopsys DesignWare 8250 UART. Split them from 8250_dw into new brand
library module which users will select explicitly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20190806094322.64987-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 748c5ea8b879 ("serial: 8250_dw: Preserve original value of DLF register")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_dwlib.c | 126 +++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_dwlib.h |  19 ++++
 drivers/tty/serial/8250/Kconfig      |   3 +
 drivers/tty/serial/8250/Makefile     |   1 +
 4 files changed, 149 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_dwlib.c
 create mode 100644 drivers/tty/serial/8250/8250_dwlib.h

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
new file mode 100644
index 0000000000000..6d6a78eead3ef
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Synopsys DesignWare 8250 library. */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_core.h>
+
+#include "8250_dwlib.h"
+
+/* Offsets for the DesignWare specific registers */
+#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
+#define DW_UART_CPR	0xf4 /* Component Parameter Register */
+#define DW_UART_UCV	0xf8 /* UART Component Version */
+
+/* Component Parameter Register bits */
+#define DW_UART_CPR_ABP_DATA_WIDTH	(3 << 0)
+#define DW_UART_CPR_AFCE_MODE		(1 << 4)
+#define DW_UART_CPR_THRE_MODE		(1 << 5)
+#define DW_UART_CPR_SIR_MODE		(1 << 6)
+#define DW_UART_CPR_SIR_LP_MODE		(1 << 7)
+#define DW_UART_CPR_ADDITIONAL_FEATURES	(1 << 8)
+#define DW_UART_CPR_FIFO_ACCESS		(1 << 9)
+#define DW_UART_CPR_FIFO_STAT		(1 << 10)
+#define DW_UART_CPR_SHADOW		(1 << 11)
+#define DW_UART_CPR_ENCODED_PARMS	(1 << 12)
+#define DW_UART_CPR_DMA_EXTRA		(1 << 13)
+#define DW_UART_CPR_FIFO_MODE		(0xff << 16)
+
+/* Helper for FIFO size calculation */
+#define DW_UART_CPR_FIFO_SIZE(a)	(((a >> 16) & 0xff) * 16)
+
+static inline u32 dw8250_readl_ext(struct uart_port *p, int offset)
+{
+	if (p->iotype == UPIO_MEM32BE)
+		return ioread32be(p->membase + offset);
+	return readl(p->membase + offset);
+}
+
+static inline void dw8250_writel_ext(struct uart_port *p, int offset, u32 reg)
+{
+	if (p->iotype == UPIO_MEM32BE)
+		iowrite32be(reg, p->membase + offset);
+	else
+		writel(reg, p->membase + offset);
+}
+
+/*
+ * divisor = div(I) + div(F)
+ * "I" means integer, "F" means fractional
+ * quot = div(I) = clk / (16 * baud)
+ * frac = div(F) * 2^dlf_size
+ *
+ * let rem = clk % (16 * baud)
+ * we have: div(F) * (16 * baud) = rem
+ * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) / (16 * baud)
+ */
+static unsigned int dw8250_get_divisor(struct uart_port *p, unsigned int baud,
+				       unsigned int *frac)
+{
+	unsigned int quot, rem, base_baud = baud * 16;
+	struct dw8250_port_data *d = p->private_data;
+
+	quot = p->uartclk / base_baud;
+	rem = p->uartclk % base_baud;
+	*frac = DIV_ROUND_CLOSEST(rem << d->dlf_size, base_baud);
+
+	return quot;
+}
+
+static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
+{
+	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
+	serial8250_do_set_divisor(p, baud, quot, quot_frac);
+}
+
+void dw8250_setup_port(struct uart_port *p)
+{
+	struct uart_8250_port *up = up_to_u8250p(p);
+	u32 reg;
+
+	/*
+	 * If the Component Version Register returns zero, we know that
+	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
+	 */
+	reg = dw8250_readl_ext(p, DW_UART_UCV);
+	if (!reg)
+		return;
+
+	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
+		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
+
+	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
+	reg = dw8250_readl_ext(p, DW_UART_DLF);
+	dw8250_writel_ext(p, DW_UART_DLF, 0);
+
+	if (reg) {
+		struct dw8250_port_data *d = p->private_data;
+
+		d->dlf_size = fls(reg);
+		p->get_divisor = dw8250_get_divisor;
+		p->set_divisor = dw8250_set_divisor;
+	}
+
+	reg = dw8250_readl_ext(p, DW_UART_CPR);
+	if (!reg)
+		return;
+
+	/* Select the type based on FIFO */
+	if (reg & DW_UART_CPR_FIFO_MODE) {
+		p->type = PORT_16550A;
+		p->flags |= UPF_FIXED_TYPE;
+		p->fifosize = DW_UART_CPR_FIFO_SIZE(reg);
+		up->capabilities = UART_CAP_FIFO;
+	}
+
+	if (reg & DW_UART_CPR_AFCE_MODE)
+		up->capabilities |= UART_CAP_AFE;
+
+	if (reg & DW_UART_CPR_SIR_MODE)
+		up->capabilities |= UART_CAP_IRDA;
+}
+EXPORT_SYMBOL_GPL(dw8250_setup_port);
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
new file mode 100644
index 0000000000000..87a4db2a8aba6
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Synopsys DesignWare 8250 library header file. */
+
+#include <linux/types.h>
+
+#include "8250.h"
+
+struct dw8250_port_data {
+	/* Port properties */
+	int			line;
+
+	/* DMA operations */
+	struct uart_8250_dma	dma;
+
+	/* Hardware configuration */
+	u8			dlf_size;
+};
+
+void dw8250_setup_port(struct uart_port *p);
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index a9ddd76d41701..733ac320938c1 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -312,6 +312,9 @@ config SERIAL_8250_RSA
 
 	  If you don't have such card, or if unsure, say N.
 
+config SERIAL_8250_DWLIB
+	bool
+
 config SERIAL_8250_ACORN
 	tristate "Acorn expansion card serial port support"
 	depends on ARCH_ACORN && SERIAL_8250
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 18751bc63a848..9b451d81588b2 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
 8250-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
 8250_base-y				:= 8250_port.o
 8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
+8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
 8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
 obj-$(CONFIG_SERIAL_8250_GSC)		+= 8250_gsc.o
 obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
-- 
2.40.1



