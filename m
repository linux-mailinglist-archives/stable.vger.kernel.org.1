Return-Path: <stable+bounces-240346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC+vAPHm6GkHRQIAu9opvQ
	(envelope-from <stable+bounces-240346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:19:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AFD447CC2
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33C0F307E2A0
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 15:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1427633261F;
	Wed, 22 Apr 2026 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIR/lsQo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5BF331203;
	Wed, 22 Apr 2026 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871010; cv=none; b=SCx7l7gf4aEL68VQ3kNkzVCWncXtq6tf20awMNsiKbiI85oY0ST373K5AC/MGcRyv2wsVr148JFp2Ie8YkIq3hHaAyNrYa/BCxTErqyNbUWTjqM342vANYszZFph+jzjsi+/+O5cZJfpX/ynJylzee/KiyZcaVoDWv1KN626F0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871010; c=relaxed/simple;
	bh=R196vWAOeo6tRa5XEJu+I4cYcDIP/RZH8NMiXgF4e4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4zikEsUa6PgC2Eq9Vw1JGtKieG64//+SVvvtVJll7S1N1WmOt/UXPz4MLtvwCLY7a3X/tTZZQAlumwySMyLIWbiUf4jmGaZpC6QI9JZFpbqWKokiXM0Hg0lFukI4vfR3XsbgxdBu/7qoUrH0TVJ3z4vlXOsVUGooRuonq+wnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIR/lsQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927B9C2BCAF;
	Wed, 22 Apr 2026 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776871010;
	bh=R196vWAOeo6tRa5XEJu+I4cYcDIP/RZH8NMiXgF4e4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SIR/lsQoiGxyYSlZlAuZs2lEeDBOitzYWdtnDpJ7jNNFOWh+p49KXF4Tkd9V6ScdC
	 3xMszvAdxZbZclpJ7VvdJki0J+NlJ9FyzpsrlRJCCiPBtDtezuVb876VHA/oOiQZUG
	 3DDu5Y0f77o9KzMbb1IiQWHkzm52MphFUHzaph7qdSK+WQNJYCKFUz819s/KrkvDP4
	 7hcS9GOw/5bgoUVRUwSHapEBg29lljkCRKTjCeesjtokIwhZknb07r759T/MkcVCN3
	 VfXkke6vOqVL4zbFkMNok3EE6YEUQZQtB7+SMh85abOVqOT5RbQFb3Mf4XkDP+U2lt
	 V6ZdUMHym+h4A==
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
Subject: [PATCH v1 1/5] spi: microchip-core-qspi: control built-in cs manually
Date: Wed, 22 Apr 2026 16:15:42 +0100
Message-ID: <20260422-yarn-trifle-dae39766fc7c@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422-foe-strength-a5d8ad650ef4@spud>
References: <20260422-foe-strength-a5d8ad650ef4@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6872; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=yx7bSPCVW2AoaBkEPEUBQB8MXgtwa7rod5q+DgN49ZM=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkvntlrWLq8ZJn20CA3OOi+6Vq+ZSIV7wMDV+/8HKUrw cDz6E5IRykLgxgXg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACYiy8LI8F2G+Zj7nqiIls3e EQxhzrccNwY+v7L2+lrTn/55909pLWf477x61f1z63RX3/j3fpfRgbD3KtKfXyxPmWXIUXOMcaI xHy8A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240346-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 96AFD447CC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/spi/spi-microchip-core-qspi.c | 82 ++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index aafe6cbf2aea7..0a161727706ef 100644
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
 
@@ -158,6 +165,41 @@ static int mchp_coreqspi_set_mode(struct mchp_coreqspi *qspi, const struct spi_m
 	return 0;
 }
 
+static void mchp_coreqspi_set_cs(struct spi_device *spi, bool enable)
+{
+	struct mchp_coreqspi *qspi = spi_controller_get_devdata(spi->controller);
+	u32 val;
+
+	val = readl(qspi->regs + REG_DIRECT_ACCESS);
+
+	val &= ~BIT(1);
+	if (spi->mode & SPI_CS_HIGH)
+		val |= enable << DIRECT_ACCESS_OP_SSEL_SHIFT;
+	else
+		val |= !enable << DIRECT_ACCESS_OP_SSEL_SHIFT;
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
@@ -380,19 +422,6 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
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
@@ -483,6 +512,7 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 
 	reinit_completion(&qspi->data_completion);
 	mchp_coreqspi_config_op(qspi, op);
+	mchp_coreqspi_set_cs(mem->spi, true);
 	if (op->cmd.opcode) {
 		qspi->txbuf = &opcode;
 		qspi->rxbuf = NULL;
@@ -523,6 +553,7 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 		err = -ETIMEDOUT;
 
 error:
+	mchp_coreqspi_set_cs(mem->spi, false);
 	mutex_unlock(&qspi->op_lock);
 	mchp_coreqspi_disable_ints(qspi);
 
@@ -686,6 +717,7 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	int ret;
+	u32 num_cs, val;
 
 	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*qspi));
 	if (!ctlr)
@@ -718,10 +750,18 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
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
@@ -729,9 +769,21 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
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
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
-- 
2.53.0


