Return-Path: <stable+bounces-247005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBLvCgvBBGoeNgIAu9opvQ
	(envelope-from <stable+bounces-247005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:20:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB454538CD0
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECD823024FD1
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F139A3A7597;
	Wed, 13 May 2026 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+dG5vH3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E33321B1
	for <stable@vger.kernel.org>; Wed, 13 May 2026 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696421; cv=none; b=jLzvwcHgHg0TnCb/DomFUcbQV4FDtyLPl5d//Q/3fyfVXAXx2g7clEnoR4wZEPou5dsT/EyXSGyQfk2OxGPGKhwy/16n4EQ492fVHCGkNbdFpUMbKoh16KXNZR55tExpVxDoeRxZeLOInmSt+C+fikUZDF3LjOXSufaZ2PXy/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696421; c=relaxed/simple;
	bh=VWTN44Meo3XaDQ2LgmH7s6Ph/bZcQ/AvOXM44zVRHBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgfgoiKaryjO4Rgpuaz2g0v2yZtHarC43da36ZLWU4jc/6GQdQEKxXkLwaYdxcnng3VtlE3HGZWcVWjbv4OfbM5+OpPYkgKFDYNrq/1tmLVC54ChvouYEw5JsxIzANjKGckzcfcjeOC6EgXp97YOph+bW0VRxh6dKAw4EJqScQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+dG5vH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D52C2BCB7;
	Wed, 13 May 2026 18:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778696421;
	bh=VWTN44Meo3XaDQ2LgmH7s6Ph/bZcQ/AvOXM44zVRHBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+dG5vH3JAyOImc3V4jtDVA6rZ3chwcXScjCirXthpWnS8CnrKF7ovAm9nTKKJY6N
	 4SKY1NLDC21lup54N24agRwvyyMFUzWMk030YW2M/PkFCt2M4EK/2vTIbRMaWoEpPu
	 QJ6pzv6y0cRfCZElO7QPMRrVoTnMxkoxa1QpXszmxUu6eU8MZ+Qd9jPL9nTnLj975m
	 d6n0SNEbxW4dprwNiQEImtHbcXc2IgDeaN2mXNQJKcByk/n+plSNND+vYd/+ox2uzZ
	 Yr4bkZoTHtsXZqFHKRTo0tu+yhhm+o71Ga1MMQqaytWic96PdhvLZkfKYyZVhsnrI+
	 cJvP5bB61vpkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] spi: spi-ti-qspi: switch to use modern name
Date: Wed, 13 May 2026 14:20:16 -0400
Message-ID: <20260513182017.3918352-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513182017.3918352-1-sashal@kernel.org>
References: <2026051215-exclusion-jargon-8c4e@gregkh>
 <20260513182017.3918352-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BB454538CD0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247005-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,msgid.link:url]
X-Rspamd-Action: no action

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 9d93c8d97b4cdb5edddb4c5530881c90eecb7e44 ]

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://msgid.link/r/20231128093031.3707034-16-yangyingliang@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 0c18a1bacbb1 ("spi: ti-qspi: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-ti-qspi.c | 88 +++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 8b488b9aacbd6..49146009ea426 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -41,7 +41,7 @@ struct ti_qspi {
 	/* list synchronization */
 	struct mutex            list_lock;
 
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	void __iomem            *base;
 	void __iomem            *mmap_base;
 	size_t			mmap_size;
@@ -138,20 +138,20 @@ static inline void ti_qspi_write(struct ti_qspi *qspi,
 
 static int ti_qspi_setup(struct spi_device *spi)
 {
-	struct ti_qspi	*qspi = spi_master_get_devdata(spi->master);
+	struct ti_qspi	*qspi = spi_controller_get_devdata(spi->controller);
 	int ret;
 
-	if (spi->master->busy) {
-		dev_dbg(qspi->dev, "master busy doing other transfers\n");
+	if (spi->controller->busy) {
+		dev_dbg(qspi->dev, "host busy doing other transfers\n");
 		return -EBUSY;
 	}
 
-	if (!qspi->master->max_speed_hz) {
+	if (!qspi->host->max_speed_hz) {
 		dev_err(qspi->dev, "spi max frequency not defined\n");
 		return -EINVAL;
 	}
 
-	spi->max_speed_hz = min(spi->max_speed_hz, qspi->master->max_speed_hz);
+	spi->max_speed_hz = min(spi->max_speed_hz, qspi->host->max_speed_hz);
 
 	ret = pm_runtime_resume_and_get(qspi->dev);
 	if (ret < 0) {
@@ -527,7 +527,7 @@ static int ti_qspi_dma_xfer_sg(struct ti_qspi *qspi, struct sg_table rx_sg,
 
 static void ti_qspi_enable_memory_map(struct spi_device *spi)
 {
-	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
+	struct ti_qspi  *qspi = spi_controller_get_devdata(spi->controller);
 
 	ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
 	if (qspi->ctrl_base) {
@@ -541,7 +541,7 @@ static void ti_qspi_enable_memory_map(struct spi_device *spi)
 
 static void ti_qspi_disable_memory_map(struct spi_device *spi)
 {
-	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
+	struct ti_qspi  *qspi = spi_controller_get_devdata(spi->controller);
 
 	ti_qspi_write(qspi, 0, QSPI_SPI_SWITCH_REG);
 	if (qspi->ctrl_base)
@@ -555,7 +555,7 @@ static void ti_qspi_setup_mmap_read(struct spi_device *spi, u8 opcode,
 				    u8 data_nbits, u8 addr_width,
 				    u8 dummy_bytes)
 {
-	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
+	struct ti_qspi  *qspi = spi_controller_get_devdata(spi->controller);
 	u32 memval = opcode;
 
 	switch (data_nbits) {
@@ -577,7 +577,7 @@ static void ti_qspi_setup_mmap_read(struct spi_device *spi, u8 opcode,
 
 static int ti_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
-	struct ti_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
+	struct ti_qspi *qspi = spi_controller_get_devdata(mem->spi->controller);
 	size_t max_len;
 
 	if (op->data.dir == SPI_MEM_DATA_IN) {
@@ -607,7 +607,7 @@ static int ti_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 			       const struct spi_mem_op *op)
 {
-	struct ti_qspi *qspi = spi_master_get_devdata(mem->spi->master);
+	struct ti_qspi *qspi = spi_controller_get_devdata(mem->spi->controller);
 	u32 from = 0;
 	int ret = 0;
 
@@ -634,10 +634,10 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 		struct sg_table sgt;
 
 		if (virt_addr_valid(op->data.buf.in) &&
-		    !spi_controller_dma_map_mem_op_data(mem->spi->master, op,
+		    !spi_controller_dma_map_mem_op_data(mem->spi->controller, op,
 							&sgt)) {
 			ret = ti_qspi_dma_xfer_sg(qspi, sgt, from);
-			spi_controller_dma_unmap_mem_op_data(mem->spi->master,
+			spi_controller_dma_unmap_mem_op_data(mem->spi->controller,
 							     op, &sgt);
 		} else {
 			ret = ti_qspi_dma_bounce_buffer(qspi, from,
@@ -659,10 +659,10 @@ static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
 	.adjust_op_size = ti_qspi_adjust_op_size,
 };
 
-static int ti_qspi_start_transfer_one(struct spi_master *master,
+static int ti_qspi_start_transfer_one(struct spi_controller *host,
 		struct spi_message *m)
 {
-	struct ti_qspi *qspi = spi_master_get_devdata(master);
+	struct ti_qspi *qspi = spi_controller_get_devdata(host);
 	struct spi_device *spi = m->spi;
 	struct spi_transfer *t;
 	int status = 0, ret;
@@ -721,7 +721,7 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 
 	ti_qspi_write(qspi, qspi->cmd | QSPI_INVAL, QSPI_SPI_CMD_REG);
 	m->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return status;
 }
@@ -757,33 +757,33 @@ MODULE_DEVICE_TABLE(of, ti_qspi_match);
 static int ti_qspi_probe(struct platform_device *pdev)
 {
 	struct  ti_qspi *qspi;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct resource         *r, *res_mmap;
 	struct device_node *np = pdev->dev.of_node;
 	u32 max_freq;
 	int ret = 0, num_cs, irq;
 	dma_cap_mask_t mask;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*qspi));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*qspi));
+	if (!host)
 		return -ENOMEM;
 
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD;
 
-	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
-	master->setup = ti_qspi_setup;
-	master->auto_runtime_pm = true;
-	master->transfer_one_message = ti_qspi_start_transfer_one;
-	master->dev.of_node = pdev->dev.of_node;
-	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
-				     SPI_BPW_MASK(8);
-	master->mem_ops = &ti_qspi_mem_ops;
+	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	host->setup = ti_qspi_setup;
+	host->auto_runtime_pm = true;
+	host->transfer_one_message = ti_qspi_start_transfer_one;
+	host->dev.of_node = pdev->dev.of_node;
+	host->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
+				   SPI_BPW_MASK(8);
+	host->mem_ops = &ti_qspi_mem_ops;
 
 	if (!of_property_read_u32(np, "num-cs", &num_cs))
-		master->num_chipselect = num_cs;
+		host->num_chipselect = num_cs;
 
-	qspi = spi_master_get_devdata(master);
-	qspi->master = master;
+	qspi = spi_controller_get_devdata(host);
+	qspi->host = host;
 	qspi->dev = &pdev->dev;
 	platform_set_drvdata(pdev, qspi);
 
@@ -793,7 +793,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		if (r == NULL) {
 			dev_err(&pdev->dev, "missing platform data\n");
 			ret = -ENODEV;
-			goto free_master;
+			goto free_host;
 		}
 	}
 
@@ -813,7 +813,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto free_master;
+		goto free_host;
 	}
 
 	mutex_init(&qspi->list_lock);
@@ -821,7 +821,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	qspi->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(qspi->base)) {
 		ret = PTR_ERR(qspi->base);
-		goto free_master;
+		goto free_host;
 	}
 
 
@@ -831,7 +831,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 						"syscon-chipselects");
 		if (IS_ERR(qspi->ctrl_base)) {
 			ret = PTR_ERR(qspi->ctrl_base);
-			goto free_master;
+			goto free_host;
 		}
 		ret = of_property_read_u32_index(np,
 						 "syscon-chipselects",
@@ -839,7 +839,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev,
 				"couldn't get ctrl_mod reg index\n");
-			goto free_master;
+			goto free_host;
 		}
 	}
 
@@ -854,7 +854,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	if (!of_property_read_u32(np, "spi-max-frequency", &max_freq))
-		master->max_speed_hz = max_freq;
+		host->max_speed_hz = max_freq;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_MEMCPY, mask);
@@ -877,7 +877,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		dma_release_channel(qspi->rx_chan);
 		goto no_dma;
 	}
-	master->dma_rx = qspi->rx_chan;
+	host->dma_rx = qspi->rx_chan;
 	init_completion(&qspi->transfer_complete);
 	if (res_mmap)
 		qspi->mmap_phys_base = (dma_addr_t)res_mmap->start;
@@ -890,21 +890,21 @@ static int ti_qspi_probe(struct platform_device *pdev)
 				 "mmap failed with error %ld using PIO mode\n",
 				 PTR_ERR(qspi->mmap_base));
 			qspi->mmap_base = NULL;
-			master->mem_ops = NULL;
+			host->mem_ops = NULL;
 		}
 	}
 	qspi->mmap_enabled = false;
 	qspi->current_cs = -1;
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (!ret)
 		return 0;
 
 	ti_qspi_dma_cleanup(qspi);
 
 	pm_runtime_disable(&pdev->dev);
-free_master:
-	spi_master_put(master);
+free_host:
+	spi_controller_put(host);
 	return ret;
 }
 
@@ -913,9 +913,9 @@ static void ti_qspi_remove(struct platform_device *pdev)
 	struct ti_qspi *qspi = platform_get_drvdata(pdev);
 	int rc;
 
-	rc = spi_master_suspend(qspi->master);
+	rc = spi_controller_suspend(qspi->host);
 	if (rc) {
-		dev_alert(&pdev->dev, "spi_master_suspend() failed (%pe)\n",
+		dev_alert(&pdev->dev, "spi_controller_suspend() failed (%pe)\n",
 			  ERR_PTR(rc));
 		return;
 	}
-- 
2.53.0


