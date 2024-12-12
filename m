Return-Path: <stable+bounces-101969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A2C9EF01A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F46161F41
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1BD22FDEA;
	Thu, 12 Dec 2024 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KADz1Cpn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F73622E9FC;
	Thu, 12 Dec 2024 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019468; cv=none; b=QuFDdbSmaR0dXjhwecC82ZehUqRReRlDiznj7hMH2Y1tyShZ9dfmGF8K1EE5KWViF1MO18W+xyC9m6lQuKW1RLNlW73M1oLsgBLuG0etiJwr2jA0Gsk1pVlH6a2wNg5aKmsTbUqLYaBAySYU2tEPn7N7ZeB3oezR9Puog1a0/Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019468; c=relaxed/simple;
	bh=8UDeOAL+gQcEht1kTleYQAsOpEkkP3KhiIMN+G+ccpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTJrx2PZM7CZSCGmfmSL/X5XBab41L5eJsZz0oLlQZJ92h6vgqOB6HXjQvQXT2Io+uG0BJzy0NQmNask6mhg5guBoFgeyeQtS92eFdq5KXwHEkBMxpKHMPWVP6RMqCQAZPw8BLYl75ru09hY52IVZ4JeSvMS69iXF79IYXkAZt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KADz1Cpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C37BC4CED0;
	Thu, 12 Dec 2024 16:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019466;
	bh=8UDeOAL+gQcEht1kTleYQAsOpEkkP3KhiIMN+G+ccpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KADz1Cpn+AxlYtovhkPvenXDhf5Xjs7Heem33vMFaGs3lXiwsKfyAmWW0Y4rlavby
	 tYxKrZz9sRimZpPlZPdaqdl4zrffcR44XY//necIOjxQTId09KFWrJ4Z20Q/A8NR8d
	 IrL1sBOjwOGUT3iYjW+80BOgZ127Q1236l/nrFvY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 214/772] memory: renesas-rpc-if: Pass device instead of rpcif to rpcif_*()
Date: Thu, 12 Dec 2024 15:52:39 +0100
Message-ID: <20241212144358.761826254@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit a198fcd1d53cbaf616d94822921c77910b94edb7 ]

Most rpcif_*() API functions do not need access to any other fields in
the rpcif structure than the device pointer.  Simplify dependencies by
passing the device pointer instead.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/0460fe82ba348cedec7a9a75a8eff762c50e817b.1669213027.git.geert+renesas@glider.be
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Stable-dep-of: 7d189579a287 ("mtd: hyperbus: rpc-if: Add missing MODULE_DEVICE_TABLE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/renesas-rpc-if.c | 32 ++++++++++++++++----------------
 drivers/mtd/hyperbus/rpc-if.c   | 18 +++++++++---------
 drivers/spi/spi-rpc-if.c        | 14 +++++++-------
 include/memory/renesas-rpc-if.h | 16 ++++++++--------
 4 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 6991185caa7bb..6a2b3c2565996 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -299,13 +299,13 @@ static void rpcif_rzg2l_timing_adjust_sdr(struct rpcif_priv *rpc)
 	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000032);
 }
 
-int rpcif_hw_init(struct rpcif *rpcif, bool hyperflash)
+int rpcif_hw_init(struct device *dev, bool hyperflash)
 {
-	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
+	struct rpcif_priv *rpc = dev_get_drvdata(dev);
 	u32 dummy;
 	int ret;
 
-	ret = pm_runtime_resume_and_get(rpc->dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		return ret;
 
@@ -355,7 +355,7 @@ int rpcif_hw_init(struct rpcif *rpcif, bool hyperflash)
 	regmap_write(rpc->regmap, RPCIF_SSLDR, RPCIF_SSLDR_SPNDL(7) |
 		     RPCIF_SSLDR_SLNDL(7) | RPCIF_SSLDR_SCKDL(7));
 
-	pm_runtime_put(rpc->dev);
+	pm_runtime_put(dev);
 
 	rpc->bus_size = hyperflash ? 2 : 1;
 
@@ -385,10 +385,10 @@ static u8 rpcif_bit_size(u8 buswidth)
 	return buswidth > 4 ? 2 : ilog2(buswidth);
 }
 
-void rpcif_prepare(struct rpcif *rpcif, const struct rpcif_op *op, u64 *offs,
+void rpcif_prepare(struct device *dev, const struct rpcif_op *op, u64 *offs,
 		   size_t *len)
 {
-	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
+	struct rpcif_priv *rpc = dev_get_drvdata(dev);
 
 	rpc->smcr = 0;
 	rpc->smadr = 0;
@@ -473,13 +473,13 @@ void rpcif_prepare(struct rpcif *rpcif, const struct rpcif_op *op, u64 *offs,
 }
 EXPORT_SYMBOL(rpcif_prepare);
 
-int rpcif_manual_xfer(struct rpcif *rpcif)
+int rpcif_manual_xfer(struct device *dev)
 {
-	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
+	struct rpcif_priv *rpc = dev_get_drvdata(dev);
 	u32 smenr, smcr, pos = 0, max = rpc->bus_size == 2 ? 8 : 4;
 	int ret = 0;
 
-	ret = pm_runtime_resume_and_get(rpc->dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
@@ -591,13 +591,13 @@ int rpcif_manual_xfer(struct rpcif *rpcif)
 	}
 
 exit:
-	pm_runtime_put(rpc->dev);
+	pm_runtime_put(dev);
 	return ret;
 
 err_out:
 	if (reset_control_reset(rpc->rstc))
-		dev_err(rpc->dev, "Failed to reset HW\n");
-	rpcif_hw_init(rpcif, rpc->bus_size == 2);
+		dev_err(dev, "Failed to reset HW\n");
+	rpcif_hw_init(dev, rpc->bus_size == 2);
 	goto exit;
 }
 EXPORT_SYMBOL(rpcif_manual_xfer);
@@ -644,9 +644,9 @@ static void memcpy_fromio_readw(void *to,
 	}
 }
 
-ssize_t rpcif_dirmap_read(struct rpcif *rpcif, u64 offs, size_t len, void *buf)
+ssize_t rpcif_dirmap_read(struct device *dev, u64 offs, size_t len, void *buf)
 {
-	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
+	struct rpcif_priv *rpc = dev_get_drvdata(dev);
 	loff_t from = offs & (rpc->size - 1);
 	size_t size = rpc->size - from;
 	int ret;
@@ -654,7 +654,7 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpcif, u64 offs, size_t len, void *buf)
 	if (len > size)
 		len = size;
 
-	ret = pm_runtime_resume_and_get(rpc->dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
@@ -674,7 +674,7 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpcif, u64 offs, size_t len, void *buf)
 	else
 		memcpy_fromio(buf, rpc->dirmap + from, len);
 
-	pm_runtime_put(rpc->dev);
+	pm_runtime_put(dev);
 
 	return len;
 }
diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-if.c
index d00d302434030..41734e337ac00 100644
--- a/drivers/mtd/hyperbus/rpc-if.c
+++ b/drivers/mtd/hyperbus/rpc-if.c
@@ -56,7 +56,7 @@ static void rpcif_hb_prepare_read(struct rpcif *rpc, void *to,
 	op.data.nbytes = len;
 	op.data.buf.in = to;
 
-	rpcif_prepare(rpc, &op, NULL, NULL);
+	rpcif_prepare(rpc->dev, &op, NULL, NULL);
 }
 
 static void rpcif_hb_prepare_write(struct rpcif *rpc, unsigned long to,
@@ -70,7 +70,7 @@ static void rpcif_hb_prepare_write(struct rpcif *rpc, unsigned long to,
 	op.data.nbytes = len;
 	op.data.buf.out = from;
 
-	rpcif_prepare(rpc, &op, NULL, NULL);
+	rpcif_prepare(rpc->dev, &op, NULL, NULL);
 }
 
 static u16 rpcif_hb_read16(struct hyperbus_device *hbdev, unsigned long addr)
@@ -81,7 +81,7 @@ static u16 rpcif_hb_read16(struct hyperbus_device *hbdev, unsigned long addr)
 
 	rpcif_hb_prepare_read(&hyperbus->rpc, &data, addr, 2);
 
-	rpcif_manual_xfer(&hyperbus->rpc);
+	rpcif_manual_xfer(hyperbus->rpc.dev);
 
 	return data.x[0];
 }
@@ -94,7 +94,7 @@ static void rpcif_hb_write16(struct hyperbus_device *hbdev, unsigned long addr,
 
 	rpcif_hb_prepare_write(&hyperbus->rpc, addr, &data, 2);
 
-	rpcif_manual_xfer(&hyperbus->rpc);
+	rpcif_manual_xfer(hyperbus->rpc.dev);
 }
 
 static void rpcif_hb_copy_from(struct hyperbus_device *hbdev, void *to,
@@ -105,7 +105,7 @@ static void rpcif_hb_copy_from(struct hyperbus_device *hbdev, void *to,
 
 	rpcif_hb_prepare_read(&hyperbus->rpc, to, from, len);
 
-	rpcif_dirmap_read(&hyperbus->rpc, from, len, to);
+	rpcif_dirmap_read(hyperbus->rpc.dev, from, len, to);
 }
 
 static const struct hyperbus_ops rpcif_hb_ops = {
@@ -130,9 +130,9 @@ static int rpcif_hb_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hyperbus);
 
-	rpcif_enable_rpm(&hyperbus->rpc);
+	rpcif_enable_rpm(hyperbus->rpc.dev);
 
-	error = rpcif_hw_init(&hyperbus->rpc, true);
+	error = rpcif_hw_init(hyperbus->rpc.dev, true);
 	if (error)
 		goto out_disable_rpm;
 
@@ -150,7 +150,7 @@ static int rpcif_hb_probe(struct platform_device *pdev)
 	return 0;
 
 out_disable_rpm:
-	rpcif_disable_rpm(&hyperbus->rpc);
+	rpcif_disable_rpm(hyperbus->rpc.dev);
 	return error;
 }
 
@@ -160,7 +160,7 @@ static int rpcif_hb_remove(struct platform_device *pdev)
 
 	hyperbus_unregister_device(&hyperbus->hbdev);
 
-	rpcif_disable_rpm(&hyperbus->rpc);
+	rpcif_disable_rpm(hyperbus->rpc.dev);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index 24ec1c83f379c..5063587d2c724 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -58,7 +58,7 @@ static void rpcif_spi_mem_prepare(struct spi_device *spi_dev,
 		rpc_op.data.dir = RPCIF_NO_DATA;
 	}
 
-	rpcif_prepare(rpc, &rpc_op, offs, len);
+	rpcif_prepare(rpc->dev, &rpc_op, offs, len);
 }
 
 static bool rpcif_spi_mem_supports_op(struct spi_mem *mem,
@@ -86,7 +86,7 @@ static ssize_t rpcif_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	rpcif_spi_mem_prepare(desc->mem->spi, &desc->info.op_tmpl, &offs, &len);
 
-	return rpcif_dirmap_read(rpc, offs, len, buf);
+	return rpcif_dirmap_read(rpc->dev, offs, len, buf);
 }
 
 static int rpcif_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
@@ -117,7 +117,7 @@ static int rpcif_spi_mem_exec_op(struct spi_mem *mem,
 
 	rpcif_spi_mem_prepare(mem->spi, op, NULL, NULL);
 
-	return rpcif_manual_xfer(rpc);
+	return rpcif_manual_xfer(rpc->dev);
 }
 
 static const struct spi_controller_mem_ops rpcif_spi_mem_ops = {
@@ -147,7 +147,7 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = parent->of_node;
 
-	rpcif_enable_rpm(rpc);
+	rpcif_enable_rpm(rpc->dev);
 
 	ctlr->num_chipselect = 1;
 	ctlr->mem_ops = &rpcif_spi_mem_ops;
@@ -156,7 +156,7 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD;
 	ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
 
-	error = rpcif_hw_init(rpc, false);
+	error = rpcif_hw_init(rpc->dev, false);
 	if (error)
 		goto out_disable_rpm;
 
@@ -169,7 +169,7 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 	return 0;
 
 out_disable_rpm:
-	rpcif_disable_rpm(rpc);
+	rpcif_disable_rpm(rpc->dev);
 	return error;
 }
 
@@ -179,7 +179,7 @@ static int rpcif_spi_remove(struct platform_device *pdev)
 	struct rpcif *rpc = spi_controller_get_devdata(ctlr);
 
 	spi_unregister_controller(ctlr);
-	rpcif_disable_rpm(rpc);
+	rpcif_disable_rpm(rpc->dev);
 
 	return 0;
 }
diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
index ddf94356752d3..d2130c2c8c82f 100644
--- a/include/memory/renesas-rpc-if.h
+++ b/include/memory/renesas-rpc-if.h
@@ -69,20 +69,20 @@ struct rpcif {
 };
 
 int rpcif_sw_init(struct rpcif *rpc, struct device *dev);
-int rpcif_hw_init(struct rpcif *rpc, bool hyperflash);
-void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
+int rpcif_hw_init(struct device *dev, bool hyperflash);
+void rpcif_prepare(struct device *dev, const struct rpcif_op *op, u64 *offs,
 		   size_t *len);
-int rpcif_manual_xfer(struct rpcif *rpc);
-ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf);
+int rpcif_manual_xfer(struct device *dev);
+ssize_t rpcif_dirmap_read(struct device *dev, u64 offs, size_t len, void *buf);
 
-static inline void rpcif_enable_rpm(struct rpcif *rpc)
+static inline void rpcif_enable_rpm(struct device *dev)
 {
-	pm_runtime_enable(rpc->dev);
+	pm_runtime_enable(dev);
 }
 
-static inline void rpcif_disable_rpm(struct rpcif *rpc)
+static inline void rpcif_disable_rpm(struct device *dev)
 {
-	pm_runtime_disable(rpc->dev);
+	pm_runtime_disable(dev);
 }
 
 #endif // __RENESAS_RPC_IF_H
-- 
2.43.0




