Return-Path: <stable+bounces-242077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELJuEKcq82mwxgEAu9opvQ
	(envelope-from <stable+bounces-242077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:10:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4774A08B3
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F8E83009CC7
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435EA3FCB11;
	Thu, 30 Apr 2026 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAjAQH7w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004B03D8138;
	Thu, 30 Apr 2026 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543840; cv=none; b=I6W8NIHrMkjTOsJbAuHqonN/yEIsHAJtJGqFsHNlDIbuiMdX6A6vMS1C6s1SAoEsiXpA6OFnWVHuVv6Y0TOYaH1rxV7SdImPiv2MM/030eNQb1C+mjgvFCOXC7R0iTuQH3/MaRsr9TjzohZwVqLz75YlfTj8EUADAYRYvW/olmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543840; c=relaxed/simple;
	bh=/J1nUBci+E8Pw/IKzTnHKNwPygs5jxzuwzYeRCMks7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWjNzgAAVyhQz/wr30U4UsTxrXfi4tiYihszlv6oaDsQ2FP813dIvUpYkTQUESYIj/CTlbAZvTyjnhw+S0kz6nPSoTMXwIc8sU8JjMT5HP38jAiSoRB1aSwSB8AGKXlLeaTzdOsPx8J8W8C/jqucz4PTCBCM4fCepLYcWb4G7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAjAQH7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81950C2BCC4;
	Thu, 30 Apr 2026 10:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777543839;
	bh=/J1nUBci+E8Pw/IKzTnHKNwPygs5jxzuwzYeRCMks7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAjAQH7w2Jth1SkpLLheSRV035Yf2WM9booYaohKvDHPwnVg1kjuRGJqFxJSSNhBw
	 j6urlmsZQOHlHjX/NJpSEZ0JDGYgYzHzrQQyXZlprVhh5lKSVZXQuZ8ZAFsgpoGtOF
	 7tfA1+3RQymyU0C28clO6dJIv6+7+abHKq4x0mPZSwQqivQECHiJaWp1p/3qFuKcpn
	 HK6ctu1b0GlhhnC80SsrdX/wltNrbXjav25sF7lNIzmJOBuU1Z5eIVsABs7FHsD7NO
	 Ijnu0yjtV2uULWw6KOUSDlU+YmrO0AxKMjT5qzYg+VLawnyRUy/7q8fEseC4thoCK5
	 0OMWJhKISXskA==
From: Conor Dooley <conor@kernel.org>
To: broonie@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] spi: microchip-core-qspi: control built-in cs manually
Date: Thu, 30 Apr 2026 11:10:18 +0100
Message-ID: <20260430-hamstring-busload-f941d0347b5e@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430-levers-defiling-00406e391c5a@spud>
References: <20260430-levers-defiling-00406e391c5a@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6779; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=5HdeUiVuRH6ATNnnzTOweOk/nyMJ666L2b1WoXdR8YI=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJmftToERCMvzYu6y1MyI6fh8KJ7Zuc/m7t1qOXtqjtet pV70+ftHaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiIwnxGhrPvMxyeWgfZbs9w e1OQXdXxIfFhganiBfEjYuk/T6zJbmD4K/05ofVeIteHF0s2fhHbt551Y/WcSwc4Nk/savK+d06 /lQ8A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DD4774A08B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242077-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email]

From: Conor Dooley <conor.dooley@microchip.com>

The coreQSPI IP supports only a single chip select, which is
automagically operated by the hardware - set low when the transmit
buffer first gets written to and set high when the number of bytes
written to the TOTALBYTES field of the FRAMES register have been sent on
the bus. Additional devices must use GPIOs for their chip selects.
It was reported to me that if there are two devices attached to this
QSPI controller that the in-built chip select is set low while linux
tries to access the device attached to the GPIO.

This went undetected as the boards that connected multiple devices to
the SPI controller all exclusively used GPIOs for chip selects, not
relying on the built-in chip select at all. It turns out that this was
because the built-in chip select, when controlled automagically, is set
low when active and high when inactive, thereby ruling out its use for
active-high devices or devices that need to transmit with the chip
select disabled.

Modify the driver so that it controls chip select directly, retaining
the behaviour for mem_ops of setting the chip select active for the
entire duration of the transfer in the exec_op callback. For regular
transfers, implement the set_cs callback for the core to use.

As part of this, the existing setup callback, mchp_coreqspi_setup_op(),
is removed. Modifying the CLKIDLE field is not safe to do during
operation when there are multiple devices, so this code is removed
entirely. Setting the MASTER and ENABLE fields is something that can be
done once at probe, it doesn't need to be re-run for each device.
Instead the new setup callback sets the built-in chip select to its
inactive state for active-low devices, as the reset value of the chip
select in software controlled mode is low.

Fixes: 8f9cf02c88528 ("spi: microchip-core-qspi: Add regular transfers")
Fixes: 8596124c4c1bc ("spi: microchip-core-qspi: Add support for microchip fpga qspi controllers")
CC: stable@vger.kernel.org
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 79 ++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index eab059fb0bc2c..ffa0f33a0ae09 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -74,6 +74,13 @@
 #define STATUS_FLAGSX4		BIT(8)
 #define STATUS_MASK		GENMASK(8, 0)
 
+/*
+ * QSPI Direct Access register defines
+ */
+#define DIRECT_ACCESS_EN_SSEL		BIT(0)
+#define DIRECT_ACCESS_OP_SSEL		BIT(1)
+#define DIRECT_ACCESS_OP_SSEL_SHIFT	1
+
 #define BYTESUPPER_MASK		GENMASK(31, 16)
 #define BYTESLOWER_MASK		GENMASK(15, 0)
 
@@ -158,6 +165,38 @@ static int mchp_coreqspi_set_mode(struct mchp_coreqspi *qspi, const struct spi_m
 	return 0;
 }
 
+static void mchp_coreqspi_set_cs(struct spi_device *spi, bool enable)
+{
+	struct mchp_coreqspi *qspi = spi_controller_get_devdata(spi->controller);
+	u32 val;
+
+	val = readl(qspi->regs + REG_DIRECT_ACCESS);
+
+	val &= ~DIRECT_ACCESS_OP_SSEL;
+	val |= !enable << DIRECT_ACCESS_OP_SSEL_SHIFT;
+
+	writel(val, qspi->regs + REG_DIRECT_ACCESS);
+}
+
+static int mchp_coreqspi_setup(struct spi_device *spi)
+{
+	struct mchp_coreqspi *qspi = spi_controller_get_devdata(spi->controller);
+	u32 val;
+
+	/*
+	 * Active low devices need to be specifically set to their inactive
+	 * states during probe.
+	 */
+	if (spi->mode & SPI_CS_HIGH)
+		return 0;
+
+	val = readl(qspi->regs + REG_DIRECT_ACCESS);
+	val |= DIRECT_ACCESS_OP_SSEL;
+	writel(val, qspi->regs + REG_DIRECT_ACCESS);
+
+	return 0;
+}
+
 static inline void mchp_coreqspi_read_op(struct mchp_coreqspi *qspi)
 {
 	u32 control, data;
@@ -380,19 +419,6 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
 	return 0;
 }
 
-static int mchp_coreqspi_setup_op(struct spi_device *spi_dev)
-{
-	struct spi_controller *ctlr = spi_dev->controller;
-	struct mchp_coreqspi *qspi = spi_controller_get_devdata(ctlr);
-	u32 control = readl_relaxed(qspi->regs + REG_CONTROL);
-
-	control |= (CONTROL_MASTER | CONTROL_ENABLE);
-	control &= ~CONTROL_CLKIDLE;
-	writel_relaxed(control, qspi->regs + REG_CONTROL);
-
-	return 0;
-}
-
 static inline void mchp_coreqspi_config_op(struct mchp_coreqspi *qspi, const struct spi_mem_op *op)
 {
 	u32 idle_cycles = 0;
@@ -483,6 +509,7 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 
 	reinit_completion(&qspi->data_completion);
 	mchp_coreqspi_config_op(qspi, op);
+	mchp_coreqspi_set_cs(mem->spi, true);
 	if (op->cmd.opcode) {
 		qspi->txbuf = &opcode;
 		qspi->rxbuf = NULL;
@@ -523,6 +550,7 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 		err = -ETIMEDOUT;
 
 error:
+	mchp_coreqspi_set_cs(mem->spi, false);
 	mutex_unlock(&qspi->op_lock);
 	mchp_coreqspi_disable_ints(qspi);
 
@@ -686,6 +714,7 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	int ret;
+	u32 num_cs, val;
 
 	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*qspi));
 	if (!ctlr)
@@ -718,10 +747,18 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * The IP core only has a single CS, any more have to be provided via
+	 * gpios
+	 */
+	if (of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs))
+		num_cs = 1;
+
+	ctlr->num_chipselect = num_cs;
+
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->mem_ops = &mchp_coreqspi_mem_ops;
 	ctlr->mem_caps = &mchp_coreqspi_mem_caps;
-	ctlr->setup = mchp_coreqspi_setup_op;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 			  SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->dev.of_node = np;
@@ -729,9 +766,21 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 	ctlr->prepare_message = mchp_coreqspi_prepare_message;
 	ctlr->unprepare_message = mchp_coreqspi_unprepare_message;
 	ctlr->transfer_one = mchp_coreqspi_transfer_one;
-	ctlr->num_chipselect = 2;
+	ctlr->setup = mchp_coreqspi_setup;
+	ctlr->set_cs = mchp_coreqspi_set_cs;
 	ctlr->use_gpio_descriptors = true;
 
+	val = readl_relaxed(qspi->regs + REG_CONTROL);
+	val |= (CONTROL_MASTER | CONTROL_ENABLE);
+	writel_relaxed(val, qspi->regs + REG_CONTROL);
+
+	/*
+	 * Put cs into software controlled mode
+	 */
+	val = readl_relaxed(qspi->regs + REG_DIRECT_ACCESS);
+	val |= DIRECT_ACCESS_EN_SSEL;
+	writel(val, qspi->regs + REG_DIRECT_ACCESS);
+
 	ret = spi_register_controller(ctlr);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
-- 
2.53.0


