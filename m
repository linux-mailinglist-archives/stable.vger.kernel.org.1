Return-Path: <stable+bounces-149638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D51ACB40A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0943316324A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E38223099F;
	Mon,  2 Jun 2025 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TfkUEAXd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3C1ACEAF;
	Mon,  2 Jun 2025 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874569; cv=none; b=YLvEikagkHULe4687wN9US9D4OM99X77GeXbZPDqTwXxOvdJqEQCUoJ3BW1GfMMpUg41qt/Ikkz5drbAgY6h83MV1JWzSGp7x8vDPADxdG5SNFAWaAYVwUcxWuaWB7SSuZ0ORor4T7eMM8xSL20/vjP9yki944SY1Crh60jdTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874569; c=relaxed/simple;
	bh=6i8pNmpPPJqC5pZEwwe9r3FZqpG4Ki/zpCGXeB+zY24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/DmrXVYiS8q1FRGAB/YRwwmD9dL9HNnNzHLbfHG+Dvl4s+T+z2oVPm+MalXfp6BqMdVNOVvXbphqiY3622p0Kqs2cytwPASTdn0U7ImPF/i/vaGZYAP+0yKOeT//yOeuxbqvNXpJgVvG7Hs9ckrd5qKctSNDFmo6yNScQ44oPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TfkUEAXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B52AC4CEEB;
	Mon,  2 Jun 2025 14:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874569;
	bh=6i8pNmpPPJqC5pZEwwe9r3FZqpG4Ki/zpCGXeB+zY24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfkUEAXdPDLnu343IbE+9cLTxwXcKhAnbEYrnWk2KNGF9jYZVpQexvn7ZuEpEbzqy
	 dCWr0q6o1q6YvncoQ2/XnwLoK8u0PpPHs98DQXWNjxz+zGrIb8/80DSNSPgeufEoxo
	 8VFW4fzMWG8pTfbS34FlDjxT8xEZZx8g3E01gpf8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 065/204] staging: axis-fifo: avoid parsing ignored device tree properties
Date: Mon,  2 Jun 2025 15:46:38 +0200
Message-ID: <20250602134258.234151326@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134255.449974357@linuxfoundation.org>
References: <20250602134255.449974357@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quentin Deslandes <quentin.deslandes@itdev.co.uk>

[ Upstream commit ed6daf2b2832d9b07582a6ff884039afa9063206 ]

Some properties were parsed from the device tree and then ignored by the
driver. Some would return an error if absent from the device tree, then
return an error if they were found because they are unsupported by the
driver.

Avoid parsing unused properties and clearly explain in the documentation
the ignored / unsupported properties.

Signed-off-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Link: https://lore.kernel.org/r/20191101214232.16960-2-quentin.deslandes@itdev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 2ca34b508774 ("staging: axis-fifo: Correct handling of tx_fifo_depth for size validation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/axis-fifo/axis-fifo.c   | 247 ++++++------------------
 drivers/staging/axis-fifo/axis-fifo.txt |  18 +-
 2 files changed, 74 insertions(+), 191 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 42528d4593b83..08f9990ab499a 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -738,6 +738,68 @@ static int get_dts_property(struct axis_fifo *fifo,
 	return 0;
 }
 
+static int axis_fifo_parse_dt(struct axis_fifo *fifo)
+{
+	int ret;
+	unsigned int value;
+
+	ret = get_dts_property(fifo, "xlnx,axi-str-rxd-tdata-width", &value);
+	if (ret) {
+		dev_err(fifo->dt_device, "missing xlnx,axi-str-rxd-tdata-width property\n");
+		goto end;
+	} else if (value != 32) {
+		dev_err(fifo->dt_device, "xlnx,axi-str-rxd-tdata-width only supports 32 bits\n");
+		ret = -EIO;
+		goto end;
+	}
+
+	ret = get_dts_property(fifo, "xlnx,axi-str-txd-tdata-width", &value);
+	if (ret) {
+		dev_err(fifo->dt_device, "missing xlnx,axi-str-txd-tdata-width property\n");
+		goto end;
+	} else if (value != 32) {
+		dev_err(fifo->dt_device, "xlnx,axi-str-txd-tdata-width only supports 32 bits\n");
+		ret = -EIO;
+		goto end;
+	}
+
+	ret = get_dts_property(fifo, "xlnx,rx-fifo-depth",
+			       &fifo->rx_fifo_depth);
+	if (ret) {
+		dev_err(fifo->dt_device, "missing xlnx,rx-fifo-depth property\n");
+		ret = -EIO;
+		goto end;
+	}
+
+	ret = get_dts_property(fifo, "xlnx,tx-fifo-depth",
+			       &fifo->tx_fifo_depth);
+	if (ret) {
+		dev_err(fifo->dt_device, "missing xlnx,tx-fifo-depth property\n");
+		ret = -EIO;
+		goto end;
+	}
+
+	/* IP sets TDFV to fifo depth - 4 so we will do the same */
+	fifo->tx_fifo_depth -= 4;
+
+	ret = get_dts_property(fifo, "xlnx,use-rx-data", &fifo->has_rx_fifo);
+	if (ret) {
+		dev_err(fifo->dt_device, "missing xlnx,use-rx-data property\n");
+		ret = -EIO;
+		goto end;
+	}
+
+	ret = get_dts_property(fifo, "xlnx,use-tx-data", &fifo->has_tx_fifo);
+	if (ret) {
+		dev_err(fifo->dt_device, "missing xlnx,use-tx-data property\n");
+		ret = -EIO;
+		goto end;
+	}
+
+end:
+	return ret;
+}
+
 static int axis_fifo_probe(struct platform_device *pdev)
 {
 	struct resource *r_irq; /* interrupt resources */
@@ -749,34 +811,6 @@ static int axis_fifo_probe(struct platform_device *pdev)
 
 	int rc = 0; /* error return value */
 
-	/* IP properties from device tree */
-	unsigned int rxd_tdata_width;
-	unsigned int txc_tdata_width;
-	unsigned int txd_tdata_width;
-	unsigned int tdest_width;
-	unsigned int tid_width;
-	unsigned int tuser_width;
-	unsigned int data_interface_type;
-	unsigned int has_tdest;
-	unsigned int has_tid;
-	unsigned int has_tkeep;
-	unsigned int has_tstrb;
-	unsigned int has_tuser;
-	unsigned int rx_fifo_depth;
-	unsigned int rx_programmable_empty_threshold;
-	unsigned int rx_programmable_full_threshold;
-	unsigned int axi_id_width;
-	unsigned int axi4_data_width;
-	unsigned int select_xpm;
-	unsigned int tx_fifo_depth;
-	unsigned int tx_programmable_empty_threshold;
-	unsigned int tx_programmable_full_threshold;
-	unsigned int use_rx_cut_through;
-	unsigned int use_rx_data;
-	unsigned int use_tx_control;
-	unsigned int use_tx_cut_through;
-	unsigned int use_tx_data;
-
 	/* ----------------------------
 	 *     init wrapper device
 	 * ----------------------------
@@ -843,164 +877,9 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	 * ----------------------------
 	 */
 
-	/* retrieve device tree properties */
-	rc = get_dts_property(fifo, "xlnx,axi-str-rxd-tdata-width",
-			      &rxd_tdata_width);
+	rc = axis_fifo_parse_dt(fifo);
 	if (rc)
 		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,axi-str-txc-tdata-width",
-			      &txc_tdata_width);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,axi-str-txd-tdata-width",
-			      &txd_tdata_width);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,axis-tdest-width", &tdest_width);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,axis-tid-width", &tid_width);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,axis-tuser-width", &tuser_width);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,data-interface-type",
-			      &data_interface_type);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,has-axis-tdest", &has_tdest);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,has-axis-tid", &has_tid);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,has-axis-tkeep", &has_tkeep);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,has-axis-tstrb", &has_tstrb);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,has-axis-tuser", &has_tuser);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,rx-fifo-depth", &rx_fifo_depth);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,rx-fifo-pe-threshold",
-			      &rx_programmable_empty_threshold);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,rx-fifo-pf-threshold",
-			      &rx_programmable_full_threshold);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,s-axi-id-width", &axi_id_width);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,s-axi4-data-width", &axi4_data_width);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,select-xpm", &select_xpm);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,tx-fifo-depth", &tx_fifo_depth);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,tx-fifo-pe-threshold",
-			      &tx_programmable_empty_threshold);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,tx-fifo-pf-threshold",
-			      &tx_programmable_full_threshold);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,use-rx-cut-through",
-			      &use_rx_cut_through);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,use-rx-data", &use_rx_data);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,use-tx-ctrl", &use_tx_control);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,use-tx-cut-through",
-			      &use_tx_cut_through);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,use-tx-data", &use_tx_data);
-	if (rc)
-		goto err_unmap;
-
-	/* check validity of device tree properties */
-	if (rxd_tdata_width != 32) {
-		dev_err(fifo->dt_device,
-			"rxd_tdata_width width [%u] unsupported\n",
-			rxd_tdata_width);
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (txd_tdata_width != 32) {
-		dev_err(fifo->dt_device,
-			"txd_tdata_width width [%u] unsupported\n",
-			txd_tdata_width);
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (has_tdest) {
-		dev_err(fifo->dt_device, "tdest not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (has_tid) {
-		dev_err(fifo->dt_device, "tid not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (has_tkeep) {
-		dev_err(fifo->dt_device, "tkeep not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (has_tstrb) {
-		dev_err(fifo->dt_device, "tstrb not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (has_tuser) {
-		dev_err(fifo->dt_device, "tuser not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (use_rx_cut_through) {
-		dev_err(fifo->dt_device, "rx cut-through not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (use_tx_cut_through) {
-		dev_err(fifo->dt_device, "tx cut-through not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (use_tx_control) {
-		dev_err(fifo->dt_device, "tx control not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-
-	/* TODO
-	 * these exist in the device tree but it's unclear what they do
-	 * - select-xpm
-	 * - data-interface-type
-	 */
-
-	/* set device wrapper properties based on IP config */
-	fifo->rx_fifo_depth = rx_fifo_depth;
-	/* IP sets TDFV to fifo depth - 4 so we will do the same */
-	fifo->tx_fifo_depth = tx_fifo_depth - 4;
-	fifo->has_rx_fifo = use_rx_data;
-	fifo->has_tx_fifo = use_tx_data;
 
 	reset_ip_core(fifo);
 
diff --git a/drivers/staging/axis-fifo/axis-fifo.txt b/drivers/staging/axis-fifo/axis-fifo.txt
index 85d88c010e724..5828e1b8e8223 100644
--- a/drivers/staging/axis-fifo/axis-fifo.txt
+++ b/drivers/staging/axis-fifo/axis-fifo.txt
@@ -25,10 +25,10 @@ Required properties:
 - xlnx,axi-str-txc-tdata-width: Should be <0x20>
 - xlnx,axi-str-txd-protocol: Should be "XIL_AXI_STREAM_ETH_DATA"
 - xlnx,axi-str-txd-tdata-width: Should be <0x20>
-- xlnx,axis-tdest-width: AXI-Stream TDEST width
-- xlnx,axis-tid-width: AXI-Stream TID width
-- xlnx,axis-tuser-width: AXI-Stream TUSER width
-- xlnx,data-interface-type: Should be <0x0>
+- xlnx,axis-tdest-width: AXI-Stream TDEST width (ignored by the driver)
+- xlnx,axis-tid-width: AXI-Stream TID width (ignored by the driver)
+- xlnx,axis-tuser-width: AXI-Stream TUSER width (ignored by the driver)
+- xlnx,data-interface-type: Should be <0x0> (ignored by the driver)
 - xlnx,has-axis-tdest: Should be <0x0> (this feature isn't supported)
 - xlnx,has-axis-tid: Should be <0x0> (this feature isn't supported)
 - xlnx,has-axis-tkeep: Should be <0x0> (this feature isn't supported)
@@ -36,13 +36,17 @@ Required properties:
 - xlnx,has-axis-tuser: Should be <0x0> (this feature isn't supported)
 - xlnx,rx-fifo-depth: Depth of RX FIFO in words
 - xlnx,rx-fifo-pe-threshold: RX programmable empty interrupt threshold
+	(ignored by the driver)
 - xlnx,rx-fifo-pf-threshold: RX programmable full interrupt threshold
-- xlnx,s-axi-id-width: Should be <0x4>
-- xlnx,s-axi4-data-width: Should be <0x20>
-- xlnx,select-xpm: Should be <0x0>
+	(ignored by the driver)
+- xlnx,s-axi-id-width: Should be <0x4> (ignored by the driver)
+- xlnx,s-axi4-data-width: Should be <0x20> (ignored by the driver)
+- xlnx,select-xpm: Should be <0x0> (ignored by the driver)
 - xlnx,tx-fifo-depth: Depth of TX FIFO in words
 - xlnx,tx-fifo-pe-threshold: TX programmable empty interrupt threshold
+	(ignored by the driver)
 - xlnx,tx-fifo-pf-threshold: TX programmable full interrupt threshold
+	(ignored by the driver)
 - xlnx,use-rx-cut-through: Should be <0x0> (this feature isn't supported)
 - xlnx,use-rx-data: <0x1> if RX FIFO is enabled, <0x0> otherwise
 - xlnx,use-tx-ctrl: Should be <0x0> (this feature isn't supported)
-- 
2.39.5




