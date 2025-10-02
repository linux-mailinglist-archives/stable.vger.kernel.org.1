Return-Path: <stable+bounces-183046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F49BB4089
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107EA2A276F
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F4E30FF36;
	Thu,  2 Oct 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pnWWS+Ac"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3E31281F;
	Thu,  2 Oct 2025 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411813; cv=none; b=RQgvU9F3veGlsrla+1UMU6ZYDagTaZV8tlnQb3LPt6eD7QlKCWTDft7kFxd0z5xUXEWoPn1iTRw+a4zYgzGpsfR2MSAZ1M06vgPIgNwd2AcXT19/EHCnkcDxMPXtdgtIpqKvDuFXP6UVZebpKGNEXlvOYuNHaPAgo3A1qaTzlB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411813; c=relaxed/simple;
	bh=a/xXCa+kcV6P2JbSiTDXzUwfLFk39fwtpFaP9snwvgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHmXBD/E7Bs6/XL2svY921HY/0CILt/OqyXEyKFCH67RMHqXtNxsl/CVu2owB+JXsF8pcpOmn0jd3VLp936xrS25k+mAvXzXkEb7nTqG3PlEajA734YyvDNXFhtGaNoGxh870HpvKZ1pnaTYOk7ihyA4SxtJ+hidFWJZ/4kFsyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pnWWS+Ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AC3C4CEF4;
	Thu,  2 Oct 2025 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759411811;
	bh=a/xXCa+kcV6P2JbSiTDXzUwfLFk39fwtpFaP9snwvgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pnWWS+AcG7c677gfRjCHGQqkLUyrv3VtyhpkWZlTiKMwpcqfJoG73A+xf/kFCWcMr
	 A2nGgm8u+7/k++HjKfQipMvbUic+chEddtMfw7/95hsj3zxrC3BWi/eF2mfDRu/jU3
	 n9Tx8igyGqARAyVbLL2xMCqUIR2K9bz3RyNqLWrs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.300
Date: Thu,  2 Oct 2025 15:29:58 +0200
Message-ID: <2025100258-monotone-sloppy-1167@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025100258-chaste-acre-069a@gregkh>
References: <2025100258-chaste-acre-069a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 819dd9649e78..e56e5031852c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 299
+SUBLEVEL = 300
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index e9444e202c33..cb3c86014adb 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5580,8 +5580,7 @@ static inline void sync_lapic_to_cr8(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u64 cr8;
 
-	if (svm_nested_virtualize_tpr(vcpu) ||
-	    kvm_vcpu_apicv_active(vcpu))
+	if (svm_nested_virtualize_tpr(vcpu))
 		return;
 
 	cr8 = kvm_get_cr8(vcpu);
diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index ef73f65224b1..b04c55c7ca24 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1266,13 +1266,17 @@ static int bam_dma_probe(struct platform_device *pdev)
 	if (bdev->controlled_remotely) {
 		ret = of_property_read_u32(pdev->dev.of_node, "num-channels",
 					   &bdev->num_channels);
-		if (ret)
+		if (ret) {
 			dev_err(bdev->dev, "num-channels unspecified in dt\n");
+			return ret;
+		}
 
 		ret = of_property_read_u32(pdev->dev.of_node, "qcom,num-ees",
 					   &bdev->num_ees);
-		if (ret)
+		if (ret) {
 			dev_err(bdev->dev, "num-ees unspecified in dt\n");
+			return ret;
+		}
 	}
 
 	bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 01089e5c565f..7a0f188fb43c 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2029,8 +2029,8 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	 * priority. So Q0 is the highest priority queue and the last queue has
 	 * the lowest priority.
 	 */
-	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8),
-					  GFP_KERNEL);
+	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1,
+					  sizeof(*queue_priority_map), GFP_KERNEL);
 	if (!queue_priority_map)
 		return -ENOMEM;
 
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 4e1a9a2574ce..3bd8259aa030 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -125,7 +125,6 @@ static ssize_t altr_sdr_mc_err_inject_write(struct file *file,
 
 	ptemp = dma_alloc_coherent(mci->pdev, 16, &dma_handle, GFP_KERNEL);
 	if (!ptemp) {
-		dma_free_coherent(mci->pdev, 16, ptemp, dma_handle);
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "Inject: Buffer Allocation error\n");
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index f4c520893ceb..93a0a791b8c3 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -741,8 +741,8 @@ void oaktrail_hdmi_teardown(struct drm_device *dev)
 
 	if (hdmi_dev) {
 		pdev = hdmi_dev->dev;
-		pci_set_drvdata(pdev, NULL);
 		oaktrail_hdmi_i2c_exit(pdev);
+		pci_set_drvdata(pdev, NULL);
 		iounmap(hdmi_dev->regs);
 		kfree(hdmi_dev);
 		pci_dev_put(pdev);
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index ad8057bfd0c8..3d7e067fde09 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -245,6 +245,7 @@ static u16 get_legacy_obj_type(u16 opcode)
 {
 	switch (opcode) {
 	case MLX5_CMD_OP_CREATE_RQ:
+	case MLX5_CMD_OP_CREATE_RMP:
 		return MLX5_EVENT_QUEUE_TYPE_RQ;
 	case MLX5_CMD_OP_CREATE_QP:
 		return MLX5_EVENT_QUEUE_TYPE_QP;
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 0dfcf7bea9ff..bba02c1a0979 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -292,7 +292,7 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
 		host->pio_ptr = NULL;
 		host->pio_size = 0;
 	} else {
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
 			     mmc_get_dma_dir(data));
 	}
 
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index a54ad340f1e2..21fa4f95082c 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1312,13 +1312,23 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
 		return ret;
 
 	/*
-	 * The write cycle timing is directly matching tWC, but is also
+	 * Read setup timing depends on the operation done on the NAND:
+	 *
+	 * NRD_SETUP = max(tAR, tCLR)
+	 */
+	timeps = max(conf->timings.sdr.tAR_min, conf->timings.sdr.tCLR_min);
+	ncycles = DIV_ROUND_UP(timeps, mckperiodps);
+	totalcycles += ncycles;
+	ret = atmel_smc_cs_conf_set_setup(smcconf, ATMEL_SMC_NRD_SHIFT, ncycles);
+	if (ret)
+		return ret;
+
+	/*
+	 * The read cycle timing is directly matching tRC, but is also
 	 * dependent on the setup and hold timings we calculated earlier,
 	 * which gives:
 	 *
-	 * NRD_CYCLE = max(tRC, NRD_PULSE + NRD_HOLD)
-	 *
-	 * NRD_SETUP is always 0.
+	 * NRD_CYCLE = max(tRC, NRD_SETUP + NRD_PULSE + NRD_HOLD)
 	 */
 	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRC_min, mckperiodps);
 	ncycles = max(totalcycles, ncycles);
diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index ad4d944ada0c..fc0c0377efab 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -266,6 +266,7 @@ struct stm32_fmc2_nfc {
 	struct sg_table dma_data_sg;
 	struct sg_table dma_ecc_sg;
 	u8 *ecc_buf;
+	dma_addr_t dma_ecc_addr;
 	int dma_ecc_len;
 
 	struct completion complete;
@@ -942,24 +943,19 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
 
 	if (!write_data && !raw) {
 		/* Configure DMA ECC status */
-		p = fmc2->ecc_buf;
 		for_each_sg(fmc2->dma_ecc_sg.sgl, sg, eccsteps, s) {
-			sg_set_buf(sg, p, fmc2->dma_ecc_len);
-			p += fmc2->dma_ecc_len;
+			sg_dma_address(sg) = fmc2->dma_ecc_addr +
+					     s * fmc2->dma_ecc_len;
+			sg_dma_len(sg) = fmc2->dma_ecc_len;
 		}
 
-		ret = dma_map_sg(fmc2->dev, fmc2->dma_ecc_sg.sgl,
-				 eccsteps, dma_data_dir);
-		if (ret < 0)
-			goto err_unmap_data;
-
 		desc_ecc = dmaengine_prep_slave_sg(fmc2->dma_ecc_ch,
 						   fmc2->dma_ecc_sg.sgl,
 						   eccsteps, dma_transfer_dir,
 						   DMA_PREP_INTERRUPT);
 		if (!desc_ecc) {
 			ret = -ENOMEM;
-			goto err_unmap_ecc;
+			goto err_unmap_data;
 		}
 
 		reinit_completion(&fmc2->dma_ecc_complete);
@@ -967,7 +963,7 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
 		desc_ecc->callback_param = &fmc2->dma_ecc_complete;
 		ret = dma_submit_error(dmaengine_submit(desc_ecc));
 		if (ret)
-			goto err_unmap_ecc;
+			goto err_unmap_data;
 
 		dma_async_issue_pending(fmc2->dma_ecc_ch);
 	}
@@ -988,7 +984,7 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
 		if (!write_data && !raw)
 			dmaengine_terminate_all(fmc2->dma_ecc_ch);
 		ret = -ETIMEDOUT;
-		goto err_unmap_ecc;
+		goto err_unmap_data;
 	}
 
 	/* Wait DMA data transfer completion */
@@ -1009,11 +1005,6 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
 		}
 	}
 
-err_unmap_ecc:
-	if (!write_data && !raw)
-		dma_unmap_sg(fmc2->dev, fmc2->dma_ecc_sg.sgl,
-			     eccsteps, dma_data_dir);
-
 err_unmap_data:
 	dma_unmap_sg(fmc2->dev, fmc2->dma_data_sg.sgl, eccsteps, dma_data_dir);
 
@@ -1037,9 +1028,21 @@ static int stm32_fmc2_sequencer_write(struct nand_chip *chip,
 
 	/* Write oob */
 	if (oob_required) {
-		ret = nand_change_write_column_op(chip, mtd->writesize,
-						  chip->oob_poi, mtd->oobsize,
-						  false);
+		unsigned int offset_in_page = mtd->writesize;
+		const void *buf = chip->oob_poi;
+		unsigned int len = mtd->oobsize;
+
+		if (!raw) {
+			struct mtd_oob_region oob_free;
+
+			mtd_ooblayout_free(mtd, 0, &oob_free);
+			offset_in_page += oob_free.offset;
+			buf += oob_free.offset;
+			len = oob_free.length;
+		}
+
+		ret = nand_change_write_column_op(chip, offset_in_page,
+						  buf, len, false);
 		if (ret)
 			return ret;
 	}
@@ -1625,8 +1628,8 @@ static int stm32_fmc2_dma_setup(struct stm32_fmc2_nfc *fmc2)
 		return ret;
 
 	/* Allocate a buffer to store ECC status registers */
-	fmc2->ecc_buf = devm_kzalloc(fmc2->dev, FMC2_MAX_ECC_BUF_LEN,
-				     GFP_KERNEL);
+	fmc2->ecc_buf = dmam_alloc_coherent(fmc2->dev, FMC2_MAX_ECC_BUF_LEN,
+					   &fmc2->dma_ecc_addr, GFP_KERNEL);
 	if (!fmc2->ecc_buf)
 		return -ENOMEM;
 
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index b99b1b235348..087c9d16118b 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -869,7 +869,6 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct rcar_can_priv *priv = netdev_priv(ndev);
-	u16 ctlr;
 	int err;
 
 	if (!netif_running(ndev))
@@ -881,12 +880,7 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 		return err;
 	}
 
-	ctlr = readw(&priv->regs->ctlr);
-	ctlr &= ~RCAR_CAN_CTLR_SLPM;
-	writew(ctlr, &priv->regs->ctlr);
-	ctlr &= ~RCAR_CAN_CTLR_CANM;
-	writew(ctlr, &priv->regs->ctlr);
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+	rcar_can_start(ndev);
 
 	netif_device_attach(ndev);
 	netif_start_queue(ndev);
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 28273e84171a..a7d594a5ad36 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -807,6 +807,7 @@ static const struct net_device_ops hi3110_netdev_ops = {
 	.ndo_open = hi3110_open,
 	.ndo_stop = hi3110_stop,
 	.ndo_start_xmit = hi3110_hard_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct of_device_id hi3110_of_match[] = {
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 0eddd5779e5a..a1e151d37359 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -752,6 +752,7 @@ static const struct net_device_ops sun4ican_netdev_ops = {
 	.ndo_open = sun4ican_open,
 	.ndo_stop = sun4ican_close,
 	.ndo_start_xmit = sun4ican_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct of_device_id sun4ican_of_match[] = {
diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 16fb4fc26518..e43bd02401a2 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -769,6 +769,7 @@ static const struct net_device_ops mcba_netdev_ops = {
 	.ndo_open = mcba_usb_open,
 	.ndo_stop = mcba_usb_close,
 	.ndo_start_xmit = mcba_usb_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 /* Microchip CANBUS has hardcoded bittiming values by default.
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 4b18f37beb4c..14e9b1052c5c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -84,7 +84,7 @@ void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
 		u32 delta_ts = time_ref->ts_dev_2 - time_ref->ts_dev_1;
 
 		if (time_ref->ts_dev_2 < time_ref->ts_dev_1)
-			delta_ts &= (1 << time_ref->adapter->ts_used_bits) - 1;
+			delta_ts &= (1ULL << time_ref->adapter->ts_used_bits) - 1;
 
 		time_ref->ts_total += delta_ts;
 	}
diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index 155599dcee76..3283f66e02b6 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -4224,8 +4224,7 @@ static void cnic_cm_stop_bnx2x_hw(struct cnic_dev *dev)
 
 	cnic_bnx2x_delete_wait(dev, 0);
 
-	cancel_delayed_work(&cp->delete_task);
-	flush_workqueue(cnic_wq);
+	cancel_delayed_work_sync(&cp->delete_task);
 
 	if (atomic_read(&cp->iscsi_conn) != 0)
 		netdev_warn(dev->netdev, "%d iSCSI connections not destroyed\n",
diff --git a/drivers/net/ethernet/cavium/liquidio/request_manager.c b/drivers/net/ethernet/cavium/liquidio/request_manager.c
index 6dd65f9b347c..b606cb190664 100644
--- a/drivers/net/ethernet/cavium/liquidio/request_manager.c
+++ b/drivers/net/ethernet/cavium/liquidio/request_manager.c
@@ -139,7 +139,7 @@ int octeon_init_instr_queue(struct octeon_device *oct,
 	oct->io_qmask.iq |= BIT_ULL(iq_no);
 
 	/* Set the 32B/64B mode for each input queue */
-	oct->io_qmask.iq64B |= ((conf->instr_type == 64) << iq_no);
+	oct->io_qmask.iq64B |= ((u64)(conf->instr_type == 64) << iq_no);
 	iq->iqcmd_64B = (conf->instr_type == 64);
 
 	oct->fn_list.setup_iq_regs(oct, iq_no);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f8a096633280..7b2ab0cc562c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2018,7 +2018,8 @@ static void fec_enet_phy_reset_after_clk_enable(struct net_device *ndev)
 		 */
 		phy_dev = of_phy_find_device(fep->phy_node);
 		phy_reset_after_clk_enable(phy_dev);
-		put_device(&phy_dev->mdio.dev);
+		if (phy_dev)
+			put_device(&phy_dev->mdio.dev);
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index edb5e408c980..1622573ffe37 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -48,6 +48,7 @@
 #define I40E_MAX_VEB			16
 
 #define I40E_MAX_NUM_DESCRIPTORS	4096
+#define I40E_MAX_NUM_DESCRIPTORS_XL710	8160
 #define I40E_MAX_CSR_SPACE		(4 * 1024 * 1024 - 64 * 1024)
 #define I40E_DEFAULT_NUM_DESCRIPTORS	512
 #define I40E_REQ_DESCRIPTOR_MULTIPLE	32
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 95a6f8689b6f..4c42c8b0e893 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1914,6 +1914,18 @@ static void i40e_get_drvinfo(struct net_device *netdev,
 		drvinfo->n_priv_flags += I40E_GL_PRIV_FLAGS_STR_LEN;
 }
 
+static u32 i40e_get_max_num_descriptors(struct i40e_pf *pf)
+{
+	struct i40e_hw *hw = &pf->hw;
+
+	switch (hw->mac.type) {
+	case I40E_MAC_XL710:
+		return I40E_MAX_NUM_DESCRIPTORS_XL710;
+	default:
+		return I40E_MAX_NUM_DESCRIPTORS;
+	}
+}
+
 static void i40e_get_ringparam(struct net_device *netdev,
 			       struct ethtool_ringparam *ring)
 {
@@ -1921,8 +1933,8 @@ static void i40e_get_ringparam(struct net_device *netdev,
 	struct i40e_pf *pf = np->vsi->back;
 	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 
-	ring->rx_max_pending = I40E_MAX_NUM_DESCRIPTORS;
-	ring->tx_max_pending = I40E_MAX_NUM_DESCRIPTORS;
+	ring->rx_max_pending = i40e_get_max_num_descriptors(pf);
+	ring->tx_max_pending = i40e_get_max_num_descriptors(pf);
 	ring->rx_mini_max_pending = 0;
 	ring->rx_jumbo_max_pending = 0;
 	ring->rx_pending = vsi->rx_rings[0]->count;
@@ -1945,12 +1957,12 @@ static bool i40e_active_tx_ring_index(struct i40e_vsi *vsi, u16 index)
 static int i40e_set_ringparam(struct net_device *netdev,
 			      struct ethtool_ringparam *ring)
 {
+	u32 new_rx_count, new_tx_count, max_num_descriptors;
 	struct i40e_ring *tx_rings = NULL, *rx_rings = NULL;
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_hw *hw = &np->vsi->back->hw;
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	u32 new_rx_count, new_tx_count;
 	u16 tx_alloc_queue_pairs;
 	int timeout = 50;
 	int i, err = 0;
@@ -1958,14 +1970,15 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
 
-	if (ring->tx_pending > I40E_MAX_NUM_DESCRIPTORS ||
+	max_num_descriptors = i40e_get_max_num_descriptors(pf);
+	if (ring->tx_pending > max_num_descriptors ||
 	    ring->tx_pending < I40E_MIN_NUM_DESCRIPTORS ||
-	    ring->rx_pending > I40E_MAX_NUM_DESCRIPTORS ||
+	    ring->rx_pending > max_num_descriptors ||
 	    ring->rx_pending < I40E_MIN_NUM_DESCRIPTORS) {
 		netdev_info(netdev,
 			    "Descriptors requested (Tx: %d / Rx: %d) out of range [%d-%d]\n",
 			    ring->tx_pending, ring->rx_pending,
-			    I40E_MIN_NUM_DESCRIPTORS, I40E_MAX_NUM_DESCRIPTORS);
+			    I40E_MIN_NUM_DESCRIPTORS, max_num_descriptors);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index dfa06737ff05..e37e8a31b35d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3882,10 +3882,10 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
 		 *
 		 * get_cpu_mask returns a static constant mask with
 		 * a permanent lifetime so it's ok to pass to
-		 * irq_set_affinity_hint without making a copy.
+		 * irq_update_affinity_hint without making a copy.
 		 */
 		cpu = cpumask_local_spread(q_vector->v_idx, -1);
-		irq_set_affinity_hint(irq_num, get_cpu_mask(cpu));
+		irq_update_affinity_hint(irq_num, get_cpu_mask(cpu));
 	}
 
 	vsi->irqs_ready = true;
@@ -3896,8 +3896,8 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
 		vector--;
 		irq_num = pf->msix_entries[base + vector].vector;
 		irq_set_affinity_notifier(irq_num, NULL);
-		irq_set_affinity_hint(irq_num, NULL);
-		free_irq(irq_num, &vsi->q_vectors[vector]);
+		irq_update_affinity_hint(irq_num, NULL);
+		free_irq(irq_num, vsi->q_vectors[vector]);
 	}
 	return err;
 }
@@ -4714,7 +4714,7 @@ static void i40e_vsi_free_irq(struct i40e_vsi *vsi)
 			/* clear the affinity notifier in the IRQ descriptor */
 			irq_set_affinity_notifier(irq_num, NULL);
 			/* remove our suggested affinity mask for this IRQ */
-			irq_set_affinity_hint(irq_num, NULL);
+			irq_update_affinity_hint(irq_num, NULL);
 			synchronize_irq(irq_num);
 			free_irq(irq_num, vsi->q_vectors[i]);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 6067c8866834..ff213cbe84ca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -794,9 +794,6 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 		if (!eop_desc)
 			break;
 
-		/* prevent any other reads prior to eop_desc */
-		smp_rmb();
-
 		i40e_trace(clean_tx_irq, tx_ring, tx_desc, tx_buf);
 		/* we have caught up to head, no work left to do */
 		if (tx_head == tx_desc)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index d8ba40912203..33d9b9e0438b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/bitfield.h>
 #include "i40e.h"
 
 /*********************notification routines***********************/
@@ -393,7 +394,7 @@ static void i40e_config_irq_link_list(struct i40e_vf *vf, u16 vsi_id,
 		    (qtype << I40E_QINT_RQCTL_NEXTQ_TYPE_SHIFT) |
 		    (pf_queue_id << I40E_QINT_RQCTL_NEXTQ_INDX_SHIFT) |
 		    BIT(I40E_QINT_RQCTL_CAUSE_ENA_SHIFT) |
-		    (itr_idx << I40E_QINT_RQCTL_ITR_INDX_SHIFT);
+		    FIELD_PREP(I40E_QINT_RQCTL_ITR_INDX_MASK, itr_idx);
 		wr32(hw, reg_idx, reg);
 	}
 
@@ -600,6 +601,13 @@ static int i40e_config_vsi_tx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* only set the required fields */
 	tx_ctx.base = info->dma_ring_addr / 128;
+
+	/* ring_len has to be multiple of 8 */
+	if (!IS_ALIGNED(info->ring_len, 8) ||
+	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+		ret = -EINVAL;
+		goto error_context;
+	}
 	tx_ctx.qlen = info->ring_len;
 	tx_ctx.rdylist = le16_to_cpu(vsi->info.qs_handle[0]);
 	tx_ctx.rdylist_act = 0;
@@ -665,6 +673,13 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* only set the required fields */
 	rx_ctx.base = info->dma_ring_addr / 128;
+
+	/* ring_len has to be multiple of 32 */
+	if (!IS_ALIGNED(info->ring_len, 32) ||
+	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+		ret = -EINVAL;
+		goto error_param;
+	}
 	rx_ctx.qlen = info->ring_len;
 
 	if (info->splithdr_enabled) {
@@ -1375,6 +1390,7 @@ static void i40e_trigger_vf_reset(struct i40e_vf *vf, bool flr)
 	 * functions that may still be running at this point.
 	 */
 	clear_bit(I40E_VF_STATE_INIT, &vf->vf_states);
+	clear_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states);
 
 	/* In the case of a VFLR, the HW has already reset the VF and we
 	 * just need to clean up, so don't hit the VFRTRIG register.
@@ -2048,7 +2064,10 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	size_t len = 0;
 	int ret;
 
-	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_INIT)) {
+	i40e_sync_vf_state(vf, I40E_VF_STATE_INIT);
+
+	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states) ||
+	    test_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
@@ -2144,6 +2163,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 				vf->default_lan_addr.addr);
 	}
 	set_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states);
+	set_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states);
 
 err:
 	/* send the response back to the VF */
@@ -2306,7 +2326,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		}
 
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = I40E_ERR_NO_AVAILABLE_VSI;
 				goto error_param;
 			}
@@ -2327,7 +2347,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		 * to its appropriate VSIs based on TC mapping
 		 */
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = I40E_ERR_NO_AVAILABLE_VSI;
 				goto error_param;
 			}
@@ -2376,8 +2396,10 @@ static int i40e_validate_queue_map(struct i40e_vf *vf, u16 vsi_id,
 	u16 vsi_queue_id, queue_id;
 
 	for_each_set_bit(vsi_queue_id, &queuemap, I40E_MAX_VSI_QP) {
-		if (vf->adq_enabled) {
-			vsi_id = vf->ch[vsi_queue_id / I40E_MAX_VF_VSI].vsi_id;
+		u16 idx = vsi_queue_id / I40E_MAX_VF_VSI;
+
+		if (vf->adq_enabled && idx < vf->num_tc) {
+			vsi_id = vf->ch[idx].vsi_id;
 			queue_id = (vsi_queue_id % I40E_DEFAULT_QUEUES_PER_VF);
 		} else {
 			queue_id = vsi_queue_id;
@@ -3365,7 +3387,7 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 
 	/* action_meta is TC number here to which the filter is applied */
 	if (!tc_filter->action_meta ||
-	    tc_filter->action_meta > vf->num_tc) {
+	    tc_filter->action_meta >= vf->num_tc) {
 		dev_info(&pf->pdev->dev, "VF %d: Invalid TC number %u\n",
 			 vf->vf_id, tc_filter->action_meta);
 		goto err;
@@ -3663,6 +3685,8 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 				       aq_ret);
 }
 
+#define I40E_MAX_VF_CLOUD_FILTER 0xFF00
+
 /**
  * i40e_vc_add_cloud_filter
  * @vf: pointer to the VF info
@@ -3702,6 +3726,14 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		goto err_out;
 	}
 
+	if (vf->num_cloud_filters >= I40E_MAX_VF_CLOUD_FILTER) {
+		dev_warn(&pf->pdev->dev,
+			 "VF %d: Max number of filters reached, can't apply cloud filter\n",
+			 vf->vf_id);
+		aq_ret = -ENOSPC;
+		goto err_out;
+	}
+
 	cfilter = kzalloc(sizeof(*cfilter), GFP_KERNEL);
 	if (!cfilter)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 75d916714ad8..de04b5b545b9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -41,7 +41,8 @@ enum i40e_vf_states {
 	I40E_VF_STATE_MC_PROMISC,
 	I40E_VF_STATE_UC_PROMISC,
 	I40E_VF_STATE_PRE_ENABLE,
-	I40E_VF_STATE_RESETTING
+	I40E_VF_STATE_RESETTING,
+	I40E_VF_STATE_RESOURCES_LOADED,
 };
 
 /* VF capabilities */
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index de2c39436fe0..8166fb619db4 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2070,11 +2070,8 @@ static void igb_diag_test(struct net_device *netdev,
 	} else {
 		dev_info(&adapter->pdev->dev, "online testing starting\n");
 
-		/* PHY is powered down when interface is down */
-		if (if_running && igb_link_test(adapter, &data[TEST_LINK]))
+		if (igb_link_test(adapter, &data[TEST_LINK]))
 			eth_test->flags |= ETH_TEST_FL_FAILED;
-		else
-			data[TEST_LINK] = 0;
 
 		/* Online tests aren't run; pass by default */
 		data[TEST_REG] = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b8d0b68befcb..41bd16cc9d0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -141,8 +141,6 @@ void mlx5e_update_carrier(struct mlx5e_priv *priv)
 	if (port_state == VPORT_STATE_UP) {
 		netdev_info(priv->netdev, "Link up\n");
 		netif_carrier_on(priv->netdev);
-		mlx5e_port_manual_buffer_config(priv, 0, priv->netdev->mtu,
-						NULL, NULL, NULL);
 	} else {
 		netdev_info(priv->netdev, "Link down\n");
 		netif_carrier_off(priv->netdev);
diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
index 6af9a7eee114..ded37141683a 100644
--- a/drivers/net/ethernet/natsemi/ns83820.c
+++ b/drivers/net/ethernet/natsemi/ns83820.c
@@ -818,7 +818,7 @@ static void rx_irq(struct net_device *ndev)
 	struct ns83820 *dev = PRIV(ndev);
 	struct rx_info *info = &dev->rx_info;
 	unsigned next_rx;
-	int rx_rc, len;
+	int len;
 	u32 cmdsts;
 	__le32 *desc;
 	unsigned long flags;
@@ -879,8 +879,10 @@ static void rx_irq(struct net_device *ndev)
 		if (likely(CMDSTS_OK & cmdsts)) {
 #endif
 			skb_put(skb, len);
-			if (unlikely(!skb))
+			if (unlikely(!skb)) {
+				ndev->stats.rx_dropped++;
 				goto netdev_mangle_me_harder_failed;
+			}
 			if (cmdsts & CMDSTS_DEST_MULTI)
 				ndev->stats.multicast++;
 			ndev->stats.rx_packets++;
@@ -899,15 +901,12 @@ static void rx_irq(struct net_device *ndev)
 				__vlan_hwaccel_put_tag(skb, htons(ETH_P_IPV6), tag);
 			}
 #endif
-			rx_rc = netif_rx(skb);
-			if (NET_RX_DROP == rx_rc) {
-netdev_mangle_me_harder_failed:
-				ndev->stats.rx_dropped++;
-			}
+			netif_rx(skb);
 		} else {
 			dev_kfree_skb_irq(skb);
 		}
 
+netdev_mangle_me_harder_failed:
 		nr++;
 		next_rx = info->next_rx;
 		desc = info->descs + (DESC_SIZE * next_rx);
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 0a04eb04f3a2..2e7559b7f103 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -327,7 +327,13 @@ static int __exit omap_cf_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver omap_cf_driver = {
+/*
+ * omap_cf_remove() lives in .exit.text. For drivers registered via
+ * platform_driver_probe() this is ok because they cannot get unbound at
+ * runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver omap_cf_driver __refdata = {
 	.driver = {
 		.name	= (char *) driver_name,
 	},
diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index edd6859afba8..bad704f9e8a9 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -667,12 +667,20 @@ static int ti_pipe3_get_clk(struct ti_pipe3 *phy)
 	return 0;
 }
 
+static void ti_pipe3_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 {
 	struct device *dev = phy->dev;
 	struct device_node *node = dev->of_node;
 	struct device_node *control_node;
 	struct platform_device *control_pdev;
+	int ret;
 
 	phy->phy_power_syscon = syscon_regmap_lookup_by_phandle(node,
 							"syscon-phy-power");
@@ -703,6 +711,11 @@ static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 		}
 
 		phy->control_dev = &control_pdev->dev;
+
+		ret = devm_add_action_or_reset(dev, ti_pipe3_put_device,
+					       phy->control_dev);
+		if (ret)
+			return ret;
 	}
 
 	if (phy->mode == PIPE3_MODE_PCIE) {
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 1cfec675f82f..d1731682533e 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1552,8 +1552,8 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
 
 	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
-	if ((cache.flags & 0xff) == 0xff)
-		cache.flags = -1; /* read error */
+	if (di->chip == BQ27000 && (cache.flags & 0xff) == 0xff)
+		cache.flags = -ENODEV; /* bq27000 hdq read error */
 	if (cache.flags >= 0) {
 		cache.temperature = bq27xxx_battery_read_temperature(di);
 		if (has_ci_flag && (cache.flags & BQ27000_FLAG_CI)) {
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index c2bbde533e66..e13cde26f78c 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -39,12 +39,14 @@ static bool mdt_header_valid(const struct firmware *fw)
 	if (phend > fw->size)
 		return false;
 
-	if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
-		return false;
+	if (ehdr->e_shentsize || ehdr->e_shnum) {
+		if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
+			return false;
 
-	shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
-	if (shend > fw->size)
-		return false;
+		shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
+		if (shend > fw->size)
+			return false;
+	}
 
 	return true;
 }
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index cdcc64ea2554..5543847070fc 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -543,10 +543,10 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 	}
 
 	/*
-	 * Racy, but harmless, kick thread if there is still pending data.
+	 * Kick thread to flush if there's still pending data
+	 * or to wakeup the write queue.
 	 */
-	if (hp->n_outbuf)
-		hvc_kick();
+	hvc_kick();
 
 	return written;
 }
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 8fb47f73cc7a..cd767f3878df 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1032,16 +1032,6 @@ static int sc16is7xx_startup(struct uart_port *port)
 	sc16is7xx_port_write(port, SC16IS7XX_FCR_REG,
 			     SC16IS7XX_FCR_FIFO_BIT);
 
-	/* Enable EFR */
-	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
-			     SC16IS7XX_LCR_CONF_MODE_B);
-
-	regcache_cache_bypass(s->regmap, true);
-
-	/* Enable write access to enhanced features and internal clock div */
-	sc16is7xx_port_write(port, SC16IS7XX_EFR_REG,
-			     SC16IS7XX_EFR_ENABLE_BIT);
-
 	/* Enable TCR/TLR */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_TCRTLR_BIT,
@@ -1053,7 +1043,8 @@ static int sc16is7xx_startup(struct uart_port *port)
 			     SC16IS7XX_TCR_RX_RESUME(24) |
 			     SC16IS7XX_TCR_RX_HALT(48));
 
-	regcache_cache_bypass(s->regmap, false);
+	/* Disable TCR/TLR access */
+	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG, SC16IS7XX_MCR_TCRTLR_BIT, 0);
 
 	/* Now, initialize the UART */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, SC16IS7XX_LCR_WORD_LEN_8);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 1a2039d1b342..63bb62680362 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1030,12 +1030,11 @@ int usb_remove_device(struct usb_device *udev)
 
 enum hub_activation_type {
 	HUB_INIT, HUB_INIT2, HUB_INIT3,		/* INITs must come first */
-	HUB_POST_RESET, HUB_RESUME, HUB_RESET_RESUME, HUB_POST_RESUME,
+	HUB_POST_RESET, HUB_RESUME, HUB_RESET_RESUME,
 };
 
 static void hub_init_func2(struct work_struct *ws);
 static void hub_init_func3(struct work_struct *ws);
-static void hub_post_resume(struct work_struct *ws);
 
 static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 {
@@ -1059,12 +1058,6 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		goto init3;
 	}
 
-	if (type == HUB_POST_RESUME) {
-		usb_autopm_put_interface_async(to_usb_interface(hub->intfdev));
-		kref_put(&hub->kref, hub_release);
-		return;
-	}
-
 	kref_get(&hub->kref);
 
 	/* The superspeed hub except for root hub has to use Hub Depth
@@ -1318,8 +1311,8 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		usb_autopm_get_interface_no_resume(
 			to_usb_interface(hub->intfdev));
 
-		INIT_DELAYED_WORK(&hub->init_work, hub_post_resume);
-		queue_delayed_work(system_power_efficient_wq, &hub->init_work,
+		queue_delayed_work(system_power_efficient_wq,
+				   &hub->post_resume_work,
 				   msecs_to_jiffies(USB_SS_PORT_U0_WAKE_TIME));
 		return;
 	}
@@ -1344,9 +1337,10 @@ static void hub_init_func3(struct work_struct *ws)
 
 static void hub_post_resume(struct work_struct *ws)
 {
-	struct usb_hub *hub = container_of(ws, struct usb_hub, init_work.work);
+	struct usb_hub *hub = container_of(ws, struct usb_hub, post_resume_work.work);
 
-	hub_activate(hub, HUB_POST_RESUME);
+	usb_autopm_put_interface_async(to_usb_interface(hub->intfdev));
+	kref_put(&hub->kref, hub_release);
 }
 
 enum hub_quiescing_type {
@@ -1374,7 +1368,7 @@ static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
 
 	/* Stop hub_wq and related activity */
 	del_timer_sync(&hub->irq_urb_retry);
-	flush_delayed_work(&hub->init_work);
+	flush_delayed_work(&hub->post_resume_work);
 	usb_kill_urb(hub->urb);
 	if (hub->has_indicators)
 		cancel_delayed_work_sync(&hub->leds);
@@ -1921,6 +1915,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	hub->hdev = hdev;
 	INIT_DELAYED_WORK(&hub->leds, led_work);
 	INIT_DELAYED_WORK(&hub->init_work, NULL);
+	INIT_DELAYED_WORK(&hub->post_resume_work, hub_post_resume);
 	INIT_WORK(&hub->events, hub_event);
 	spin_lock_init(&hub->irq_urb_lock);
 	timer_setup(&hub->irq_urb_retry, hub_retry_irq_urb, 0);
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 1c455800f7d3..de29ce856953 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -69,6 +69,7 @@ struct usb_hub {
 	u8			indicator[USB_MAXCHILDREN];
 	struct delayed_work	leds;
 	struct delayed_work	init_work;
+	struct delayed_work	post_resume_work;
 	struct work_struct      events;
 	spinlock_t		irq_urb_lock;
 	struct timer_list	irq_urb_retry;
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 75a4d162c58b..716bcf9f4d34 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -728,7 +728,7 @@ void usb_detect_quirks(struct usb_device *udev)
 	udev->quirks ^= usb_detect_dynamic_quirks(udev);
 
 	if (udev->quirks)
-		dev_dbg(&udev->dev, "USB quirks for this device: %x\n",
+		dev_dbg(&udev->dev, "USB quirks for this device: 0x%x\n",
 			udev->quirks);
 
 #ifdef CONFIG_USB_DEFAULT_PERSIST
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 58261ec1300a..7790a1a9c933 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -748,7 +748,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	struct dummy		*dum;
 	int			retval = -EINVAL;
 	unsigned long		flags;
-	struct dummy_request	*req = NULL;
+	struct dummy_request	*req = NULL, *iter;
 
 	if (!_ep || !_req)
 		return retval;
@@ -758,25 +758,26 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	if (!dum->driver)
 		return -ESHUTDOWN;
 
-	local_irq_save(flags);
-	spin_lock(&dum->lock);
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req) {
-			list_del_init(&req->queue);
-			_req->status = -ECONNRESET;
-			retval = 0;
-			break;
-		}
+	spin_lock_irqsave(&dum->lock, flags);
+	list_for_each_entry(iter, &ep->queue, queue) {
+		if (&iter->req != _req)
+			continue;
+		list_del_init(&iter->queue);
+		_req->status = -ECONNRESET;
+		req = iter;
+		retval = 0;
+		break;
 	}
-	spin_unlock(&dum->lock);
 
 	if (retval == 0) {
 		dev_dbg(udc_dev(dum),
 				"dequeued req %p from %s, len %d buf %p\n",
 				req, _ep->name, _req->length, _req->buf);
+		spin_unlock(&dum->lock);
 		usb_gadget_giveback_request(_ep, _req);
+		spin_lock(&dum->lock);
 	}
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dum->lock, flags);
 	return retval;
 }
 
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 233be8250b61..a417d32bfc96 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1322,7 +1322,18 @@ static const struct usb_device_id option_ids[] = {
 	 .driver_info = NCTRL(0) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1033, 0xff),	/* Telit LE910C1-EUX (ECM) */
 	 .driver_info = NCTRL(0) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1034, 0xff),	/* Telit LE910C4-WWX (rmnet) */
+	 .driver_info = RSVD(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1035, 0xff) }, /* Telit LE910C4-WWX (ECM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1036, 0xff) },  /* Telit LE910C4-WWX */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1037, 0xff),	/* Telit LE910C4-WWX (rmnet) */
+	 .driver_info = NCTRL(0) | NCTRL(1) | RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1038, 0xff),	/* Telit LE910C4-WWX (rmnet) */
+	 .driver_info = NCTRL(0) | RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x103b, 0xff),	/* Telit LE910C4-WWX */
+	 .driver_info = NCTRL(0) | NCTRL(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x103c, 0xff),	/* Telit LE910C4-WWX */
+	 .driver_info = NCTRL(0) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE922_USBCFG0),
 	  .driver_info = RSVD(0) | RSVD(1) | NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE922_USBCFG1),
@@ -1369,6 +1380,12 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990A (PCIe) */
 	  .driver_info = RSVD(0) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1077, 0xff),	/* Telit FN990A (rmnet + audio) */
+	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1078, 0xff),	/* Telit FN990A (MBIM + audio) */
+	  .driver_info = NCTRL(0) | RSVD(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1079, 0xff),	/* Telit FN990A (RNDIS + audio) */
+	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1080, 0xff),	/* Telit FE990A (rmnet) */
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1081, 0xff),	/* Telit FE990A (MBIM) */
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index e48792828939..7f2678de635c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2482,7 +2482,7 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
 	unsigned charcount = font->charcount;
 	int w = font->width;
 	int h = font->height;
-	int size;
+	int size, alloc_size;
 	int i, csum;
 	u8 *new_data, *data = font->data;
 	int pitch = PITCH(font->width);
@@ -2509,9 +2509,16 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
 	if (fbcon_invalid_charcount(info, charcount))
 		return -EINVAL;
 
-	size = CALC_FONTSZ(h, pitch, charcount);
+	/* Check for integer overflow in font size calculation */
+	if (check_mul_overflow(h, pitch, &size) ||
+	    check_mul_overflow(size, charcount, &size))
+		return -EINVAL;
+
+	/* Check for overflow in allocation size calculation */
+	if (check_add_overflow(FONT_EXTRA_WORDS * sizeof(int), size, &alloc_size))
+		return -EINVAL;
 
-	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);
+	new_data = kmalloc(alloc_size, GFP_USER);
 
 	if (!new_data)
 		return -ENOMEM;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d157eef3ede2..d651a5c960ef 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3299,7 +3299,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		.nodeid_out = ff_out->nodeid,
 		.fh_out = ff_out->fh,
 		.off_out = pos_out,
-		.len = len,
+		.len = min_t(size_t, len, UINT_MAX & PAGE_MASK),
 		.flags = flags
 	};
 	struct fuse_write_out outarg;
@@ -3365,6 +3365,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		fc->no_copy_file_range = 1;
 		err = -EOPNOTSUPP;
 	}
+	if (!err && outarg.size > len)
+		err = -EIO;
+
 	if (err)
 		goto out;
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index c18a47a86e8b..504820e0e229 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -502,13 +502,13 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
 			/*
 			 * If page is mapped, it was faulted in after being
-			 * unmapped in caller.  Unmap (again) now after taking
-			 * the fault mutex.  The mutex will prevent faults
-			 * until we finish removing the page.
-			 *
-			 * This race can only happen in the hole punch case.
-			 * Getting here in a truncate operation is a bug.
+			 * unmapped in caller or hugetlb_vmdelete_list() skips
+			 * unmapping it due to fail to grab lock.  Unmap (again)
+			 * while holding the fault mutex.  The mutex will prevent
+			 * faults until we finish removing the page.  Hold page
+			 * lock to guarantee no concurrent migration.
 			 */
+			lock_page(page);
 			if (unlikely(page_mapped(page))) {
 				BUG_ON(truncate_op);
 
@@ -518,8 +518,6 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 					(index + 1) * pages_per_huge_page(h));
 				i_mmap_unlock_write(mapping);
 			}
-
-			lock_page(page);
 			/*
 			 * We must free the huge page and remove from page
 			 * cache (remove_huge_page) BEFORE removing the
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5f8de86b2798..f511087d5e1c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3885,7 +3885,6 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 	};
 	int err;
 
-	nfs_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),
diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 64ea44be0a64..e64c2b636eb5 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -1081,7 +1081,7 @@ void nilfs_sysfs_delete_device_group(struct the_nilfs *nilfs)
  ************************************************************************/
 
 static ssize_t nilfs_feature_revision_show(struct kobject *kobj,
-					    struct attribute *attr, char *buf)
+					    struct kobj_attribute *attr, char *buf)
 {
 	return sysfs_emit(buf, "%d.%d\n",
 			NILFS_CURRENT_REV, NILFS_MINOR_REV);
@@ -1093,7 +1093,7 @@ static const char features_readme_str[] =
 	"(1) revision\n\tshow current revision of NILFS file system driver.\n";
 
 static ssize_t nilfs_feature_README_show(struct kobject *kobj,
-					 struct attribute *attr,
+					 struct kobj_attribute *attr,
 					 char *buf)
 {
 	return sysfs_emit(buf, features_readme_str);
diff --git a/fs/nilfs2/sysfs.h b/fs/nilfs2/sysfs.h
index d001eb862dae..1543f7f2efc5 100644
--- a/fs/nilfs2/sysfs.h
+++ b/fs/nilfs2/sysfs.h
@@ -50,16 +50,16 @@ struct nilfs_sysfs_dev_subgroups {
 	struct completion sg_segments_kobj_unregister;
 };
 
-#define NILFS_COMMON_ATTR_STRUCT(name) \
+#define NILFS_KOBJ_ATTR_STRUCT(name) \
 struct nilfs_##name##_attr { \
 	struct attribute attr; \
-	ssize_t (*show)(struct kobject *, struct attribute *, \
+	ssize_t (*show)(struct kobject *, struct kobj_attribute *, \
 			char *); \
-	ssize_t (*store)(struct kobject *, struct attribute *, \
+	ssize_t (*store)(struct kobject *, struct kobj_attribute *, \
 			 const char *, size_t); \
 }
 
-NILFS_COMMON_ATTR_STRUCT(feature);
+NILFS_KOBJ_ATTR_STRUCT(feature);
 
 #define NILFS_DEV_ATTR_STRUCT(name) \
 struct nilfs_##name##_attr { \
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index f3926765c3f0..f64b1394c3e5 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -698,6 +698,8 @@ int ocfs2_extent_map_get_blocks(struct inode *inode, u64 v_blkno, u64 *p_blkno,
  * it not only handles the fiemap for inlined files, but also deals
  * with the fast symlink, cause they have no difference for extent
  * mapping per se.
+ *
+ * Must be called with ip_alloc_sem semaphore held.
  */
 static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
 			       struct fiemap_extent_info *fieinfo,
@@ -709,6 +711,7 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
 	u64 phys;
 	u32 flags = FIEMAP_EXTENT_DATA_INLINE|FIEMAP_EXTENT_LAST;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
+	lockdep_assert_held_read(&oi->ip_alloc_sem);
 
 	di = (struct ocfs2_dinode *)di_bh->b_data;
 	if (ocfs2_inode_is_fast_symlink(inode))
@@ -724,8 +727,11 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
 			phys += offsetof(struct ocfs2_dinode,
 					 id2.i_data.id_data);
 
+		/* Release the ip_alloc_sem to prevent deadlock on page fault */
+		up_read(&OCFS2_I(inode)->ip_alloc_sem);
 		ret = fiemap_fill_next_extent(fieinfo, 0, phys, id_count,
 					      flags);
+		down_read(&OCFS2_I(inode)->ip_alloc_sem);
 		if (ret < 0)
 			return ret;
 	}
@@ -796,9 +802,11 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		len_bytes = (u64)le16_to_cpu(rec.e_leaf_clusters) << osb->s_clustersize_bits;
 		phys_bytes = le64_to_cpu(rec.e_blkno) << osb->sb->s_blocksize_bits;
 		virt_bytes = (u64)le32_to_cpu(rec.e_cpos) << osb->s_clustersize_bits;
-
+		/* Release the ip_alloc_sem to prevent deadlock on page fault */
+		up_read(&OCFS2_I(inode)->ip_alloc_sem);
 		ret = fiemap_fill_next_extent(fieinfo, virt_bytes, phys_bytes,
 					      len_bytes, fe_flags);
+		down_read(&OCFS2_I(inode)->ip_alloc_sem);
 		if (ret)
 			break;
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 7b8bdc468492..7c06e33ad05e 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -303,44 +303,54 @@ struct irq_affinity_desc {
 
 extern cpumask_var_t irq_default_affinity;
 
-/* Internal implementation. Use the helpers below */
-extern int __irq_set_affinity(unsigned int irq, const struct cpumask *cpumask,
-			      bool force);
+extern int irq_set_affinity(unsigned int irq, const struct cpumask *cpumask);
+extern int irq_force_affinity(unsigned int irq, const struct cpumask *cpumask);
+
+extern int irq_can_set_affinity(unsigned int irq);
+extern int irq_select_affinity(unsigned int irq);
+
+extern int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
+				     bool setaffinity);
 
 /**
- * irq_set_affinity - Set the irq affinity of a given irq
- * @irq:	Interrupt to set affinity
- * @cpumask:	cpumask
+ * irq_update_affinity_hint - Update the affinity hint
+ * @irq:	Interrupt to update
+ * @m:		cpumask pointer (NULL to clear the hint)
  *
- * Fails if cpumask does not contain an online CPU
+ * Updates the affinity hint, but does not change the affinity of the interrupt.
  */
 static inline int
-irq_set_affinity(unsigned int irq, const struct cpumask *cpumask)
+irq_update_affinity_hint(unsigned int irq, const struct cpumask *m)
 {
-	return __irq_set_affinity(irq, cpumask, false);
+	return __irq_apply_affinity_hint(irq, m, false);
 }
 
 /**
- * irq_force_affinity - Force the irq affinity of a given irq
- * @irq:	Interrupt to set affinity
- * @cpumask:	cpumask
- *
- * Same as irq_set_affinity, but without checking the mask against
- * online cpus.
+ * irq_set_affinity_and_hint - Update the affinity hint and apply the provided
+ *			     cpumask to the interrupt
+ * @irq:	Interrupt to update
+ * @m:		cpumask pointer (NULL to clear the hint)
  *
- * Solely for low level cpu hotplug code, where we need to make per
- * cpu interrupts affine before the cpu becomes online.
+ * Updates the affinity hint and if @m is not NULL it applies it as the
+ * affinity of that interrupt.
  */
 static inline int
-irq_force_affinity(unsigned int irq, const struct cpumask *cpumask)
+irq_set_affinity_and_hint(unsigned int irq, const struct cpumask *m)
 {
-	return __irq_set_affinity(irq, cpumask, true);
+	return __irq_apply_affinity_hint(irq, m, true);
 }
 
-extern int irq_can_set_affinity(unsigned int irq);
-extern int irq_select_affinity(unsigned int irq);
+/*
+ * Deprecated. Use irq_update_affinity_hint() or irq_set_affinity_and_hint()
+ * instead.
+ */
+static inline int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
+{
+	return irq_set_affinity_and_hint(irq, m);
+}
 
-extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
+extern int irq_update_affinity_desc(unsigned int irq,
+				    struct irq_affinity_desc *affinity);
 
 extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
@@ -370,12 +380,30 @@ static inline int irq_can_set_affinity(unsigned int irq)
 
 static inline int irq_select_affinity(unsigned int irq)  { return 0; }
 
+static inline int irq_update_affinity_hint(unsigned int irq,
+					   const struct cpumask *m)
+{
+	return -EINVAL;
+}
+
+static inline int irq_set_affinity_and_hint(unsigned int irq,
+					    const struct cpumask *m)
+{
+	return -EINVAL;
+}
+
 static inline int irq_set_affinity_hint(unsigned int irq,
 					const struct cpumask *m)
 {
 	return -EINVAL;
 }
 
+static inline int irq_update_affinity_desc(unsigned int irq,
+					   struct irq_affinity_desc *affinity)
+{
+	return -EINVAL;
+}
+
 static inline int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 {
diff --git a/include/net/sock.h b/include/net/sock.h
index 0218a45b1a92..2dafb83448c8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -321,6 +321,8 @@ struct bpf_sk_storage;
   *	@sk_clockid: clockid used by time-based scheduling (SO_TXTIME)
   *	@sk_txtime_deadline_mode: set deadline mode for SO_TXTIME
   *	@sk_txtime_unused: unused txtime flags
+  *	@sk_owner: reference to the real owner of the socket that calls
+  *		   sock_lock_init_class_and_name().
   */
 struct sock {
 	/*
@@ -515,6 +517,10 @@ struct sock {
 	struct bpf_sk_storage __rcu	*sk_bpf_storage;
 #endif
 	struct rcu_head		sk_rcu;
+
+#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
+	struct module		*sk_owner;
+#endif
 };
 
 enum sk_pacing {
@@ -1525,6 +1531,35 @@ static inline void sock_release_ownership(struct sock *sk)
 	}
 }
 
+#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
+static inline void sk_owner_set(struct sock *sk, struct module *owner)
+{
+	__module_get(owner);
+	sk->sk_owner = owner;
+}
+
+static inline void sk_owner_clear(struct sock *sk)
+{
+	sk->sk_owner = NULL;
+}
+
+static inline void sk_owner_put(struct sock *sk)
+{
+	module_put(sk->sk_owner);
+}
+#else
+static inline void sk_owner_set(struct sock *sk, struct module *owner)
+{
+}
+
+static inline void sk_owner_clear(struct sock *sk)
+{
+}
+
+static inline void sk_owner_put(struct sock *sk)
+{
+}
+#endif
 /*
  * Macro so as to not evaluate some arguments when
  * lockdep is not enabled.
@@ -1534,13 +1569,14 @@ static inline void sock_release_ownership(struct sock *sk)
  */
 #define sock_lock_init_class_and_name(sk, sname, skey, name, key)	\
 do {									\
+	sk_owner_set(sk, THIS_MODULE);					\
 	sk->sk_lock.owned = 0;						\
 	init_waitqueue_head(&sk->sk_lock.wq);				\
 	spin_lock_init(&(sk)->sk_lock.slock);				\
 	debug_check_no_locks_freed((void *)&(sk)->sk_lock,		\
-			sizeof((sk)->sk_lock));				\
+				   sizeof((sk)->sk_lock));		\
 	lockdep_set_class_and_name(&(sk)->sk_lock.slock,		\
-				(skey), (sname));				\
+				   (skey), (sname));			\
 	lockdep_init_map(&(sk)->sk_lock.dep_map, (name), (key), 0);	\
 } while (0)
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 801022a8899b..b761d70eccbf 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -114,8 +114,31 @@ DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem);
  * of concurrent destructions.  Use a separate workqueue so that cgroup
  * destruction work items don't end up filling up max_active of system_wq
  * which may lead to deadlock.
+ *
+ * A cgroup destruction should enqueue work sequentially to:
+ * cgroup_offline_wq: use for css offline work
+ * cgroup_release_wq: use for css release work
+ * cgroup_free_wq: use for free work
+ *
+ * Rationale for using separate workqueues:
+ * The cgroup root free work may depend on completion of other css offline
+ * operations. If all tasks were enqueued to a single workqueue, this could
+ * create a deadlock scenario where:
+ * - Free work waits for other css offline work to complete.
+ * - But other css offline work is queued after free work in the same queue.
+ *
+ * Example deadlock scenario with single workqueue (cgroup_destroy_wq):
+ * 1. umount net_prio
+ * 2. net_prio root destruction enqueues work to cgroup_destroy_wq (CPUx)
+ * 3. perf_event CSS A offline enqueues work to same cgroup_destroy_wq (CPUx)
+ * 4. net_prio cgroup_destroy_root->cgroup_lock_and_drain_offline.
+ * 5. net_prio root destruction blocks waiting for perf_event CSS A offline,
+ *    which can never complete as it's behind in the same queue and
+ *    workqueue's max_active is 1.
  */
-static struct workqueue_struct *cgroup_destroy_wq;
+static struct workqueue_struct *cgroup_offline_wq;
+static struct workqueue_struct *cgroup_release_wq;
+static struct workqueue_struct *cgroup_free_wq;
 
 /* generate an array of cgroup subsystem pointers */
 #define SUBSYS(_x) [_x ## _cgrp_id] = &_x ## _cgrp_subsys,
@@ -5233,7 +5256,7 @@ static void css_release_work_fn(struct work_struct *work)
 	mutex_unlock(&cgroup_mutex);
 
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
-	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
+	queue_rcu_work(cgroup_free_wq, &css->destroy_rwork);
 }
 
 static void css_release(struct percpu_ref *ref)
@@ -5242,7 +5265,7 @@ static void css_release(struct percpu_ref *ref)
 		container_of(ref, struct cgroup_subsys_state, refcnt);
 
 	INIT_WORK(&css->destroy_work, css_release_work_fn);
-	queue_work(cgroup_destroy_wq, &css->destroy_work);
+	queue_work(cgroup_release_wq, &css->destroy_work);
 }
 
 static void init_and_link_css(struct cgroup_subsys_state *css,
@@ -5373,7 +5396,7 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 err_free_css:
 	list_del_rcu(&css->rstat_css_node);
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
-	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
+	queue_rcu_work(cgroup_free_wq, &css->destroy_rwork);
 	return ERR_PTR(err);
 }
 
@@ -5626,7 +5649,7 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
 
 	if (atomic_dec_and_test(&css->online_cnt)) {
 		INIT_WORK(&css->destroy_work, css_killed_work_fn);
-		queue_work(cgroup_destroy_wq, &css->destroy_work);
+		queue_work(cgroup_offline_wq, &css->destroy_work);
 	}
 }
 
@@ -6002,8 +6025,14 @@ static int __init cgroup_wq_init(void)
 	 * We would prefer to do this in cgroup_init() above, but that
 	 * is called before init_workqueues(): so leave this until after.
 	 */
-	cgroup_destroy_wq = alloc_workqueue("cgroup_destroy", 0, 1);
-	BUG_ON(!cgroup_destroy_wq);
+	cgroup_offline_wq = alloc_workqueue("cgroup_offline", 0, 1);
+	BUG_ON(!cgroup_offline_wq);
+
+	cgroup_release_wq = alloc_workqueue("cgroup_release", 0, 1);
+	BUG_ON(!cgroup_release_wq);
+
+	cgroup_free_wq = alloc_workqueue("cgroup_free", 0, 1);
+	BUG_ON(!cgroup_free_wq);
 	return 0;
 }
 core_initcall(cgroup_wq_init);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 2a8a5e1779c9..32513a2e26eb 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -332,7 +332,78 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 	return ret;
 }
 
-int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
+/**
+ * irq_update_affinity_desc - Update affinity management for an interrupt
+ * @irq:	The interrupt number to update
+ * @affinity:	Pointer to the affinity descriptor
+ *
+ * This interface can be used to configure the affinity management of
+ * interrupts which have been allocated already.
+ *
+ * There are certain limitations on when it may be used - attempts to use it
+ * for when the kernel is configured for generic IRQ reservation mode (in
+ * config GENERIC_IRQ_RESERVATION_MODE) will fail, as it may conflict with
+ * managed/non-managed interrupt accounting. In addition, attempts to use it on
+ * an interrupt which is already started or which has already been configured
+ * as managed will also fail, as these mean invalid init state or double init.
+ */
+int irq_update_affinity_desc(unsigned int irq,
+			     struct irq_affinity_desc *affinity)
+{
+	struct irq_desc *desc;
+	unsigned long flags;
+	bool activated;
+	int ret = 0;
+
+	/*
+	 * Supporting this with the reservation scheme used by x86 needs
+	 * some more thought. Fail it for now.
+	 */
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
+		return -EOPNOTSUPP;
+
+	desc = irq_get_desc_buslock(irq, &flags, 0);
+	if (!desc)
+		return -EINVAL;
+
+	/* Requires the interrupt to be shut down */
+	if (irqd_is_started(&desc->irq_data)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	/* Interrupts which are already managed cannot be modified */
+	if (irqd_affinity_is_managed(&desc->irq_data)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	/*
+	 * Deactivate the interrupt. That's required to undo
+	 * anything an earlier activation has established.
+	 */
+	activated = irqd_is_activated(&desc->irq_data);
+	if (activated)
+		irq_domain_deactivate_irq(&desc->irq_data);
+
+	if (affinity->is_managed) {
+		irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
+		irqd_set(&desc->irq_data, IRQD_MANAGED_SHUTDOWN);
+	}
+
+	cpumask_copy(desc->irq_common_data.affinity, &affinity->mask);
+
+	/* Restore the activation state */
+	if (activated)
+		irq_domain_activate_irq(&desc->irq_data, false);
+
+out_unlock:
+	irq_put_desc_busunlock(desc, flags);
+	return ret;
+}
+
+static int __irq_set_affinity(unsigned int irq, const struct cpumask *mask,
+			      bool force)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 	unsigned long flags;
@@ -347,7 +418,38 @@ int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
 	return ret;
 }
 
-int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
+/**
+ * irq_set_affinity - Set the irq affinity of a given irq
+ * @irq:	Interrupt to set affinity
+ * @cpumask:	cpumask
+ *
+ * Fails if cpumask does not contain an online CPU
+ */
+int irq_set_affinity(unsigned int irq, const struct cpumask *cpumask)
+{
+	return __irq_set_affinity(irq, cpumask, false);
+}
+EXPORT_SYMBOL_GPL(irq_set_affinity);
+
+/**
+ * irq_force_affinity - Force the irq affinity of a given irq
+ * @irq:	Interrupt to set affinity
+ * @cpumask:	cpumask
+ *
+ * Same as irq_set_affinity, but without checking the mask against
+ * online cpus.
+ *
+ * Solely for low level cpu hotplug code, where we need to make per
+ * cpu interrupts affine before the cpu becomes online.
+ */
+int irq_force_affinity(unsigned int irq, const struct cpumask *cpumask)
+{
+	return __irq_set_affinity(irq, cpumask, true);
+}
+EXPORT_SYMBOL_GPL(irq_force_affinity);
+
+int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
+			      bool setaffinity)
 {
 	unsigned long flags;
 	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
@@ -356,12 +458,11 @@ int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
 		return -EINVAL;
 	desc->affinity_hint = m;
 	irq_put_desc_unlock(desc, flags);
-	/* set the initial affinity to prevent every interrupt being on CPU0 */
-	if (m)
+	if (m && setaffinity)
 		__irq_set_affinity(irq, m, false);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(irq_set_affinity_hint);
+EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);
 
 static void irq_affinity_notify(struct work_struct *work)
 {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d6da1fcbef6f..dbbe86bdf04e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1227,7 +1227,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		}
 		if (pte_young(pteval) ||
 		    page_is_young(page) || PageReferenced(page) ||
-		    mmu_notifier_test_young(vma->vm_mm, address))
+		    mmu_notifier_test_young(vma->vm_mm, _address))
 			referenced++;
 	}
 	if (writable) {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0e7566c25939..e57ada07030d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1543,10 +1543,9 @@ int unpoison_memory(unsigned long pfn)
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
 
-	if (!pfn_valid(pfn))
-		return -ENXIO;
-
-	p = pfn_to_page(pfn);
+	p = pfn_to_online_page(pfn);
+	if (!p)
+		return -EIO;
 	page = compound_head(p);
 
 	if (!PageHWPoison(p)) {
diff --git a/mm/migrate.c b/mm/migrate.c
index 9cfd53eaeb4e..aef7978cc56b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2967,21 +2967,17 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 			newpage = page;
 		}
 
+		if (!is_zone_device_page(newpage))
+			lru_cache_add(newpage);
 		remove_migration_ptes(page, newpage, false);
 		unlock_page(page);
 		migrate->cpages--;
 
-		if (is_zone_device_page(page))
-			put_page(page);
-		else
-			putback_lru_page(page);
+		put_page(page);
 
 		if (newpage != page) {
 			unlock_page(newpage);
-			if (is_zone_device_page(newpage))
-				put_page(newpage);
-			else
-				putback_lru_page(newpage);
+			put_page(newpage);
 		}
 	}
 }
diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 486687901602..e0b966c2517c 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -290,8 +290,11 @@ int j1939_local_ecu_get(struct j1939_priv *priv, name_t name, u8 sa)
 	if (!ecu)
 		ecu = j1939_ecu_create_locked(priv, name);
 	err = PTR_ERR_OR_ZERO(ecu);
-	if (err)
+	if (err) {
+		if (j1939_address_is_unicast(sa))
+			priv->ents[sa].nusers--;
 		goto done;
+	}
 
 	ecu->nusers++;
 	/* TODO: do we care if ecu->addr != sa? */
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 29f9a343b0db..f477add424bc 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -520,6 +520,9 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	ret = j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa);
 	if (ret) {
 		j1939_netdev_stop(priv);
+		jsk->priv = NULL;
+		synchronize_rcu();
+		j1939_priv_put(priv);
 		goto out_release_sock;
 	}
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 418d0857d2aa..54f9ad391f89 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1567,6 +1567,8 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
  */
 static inline void sock_lock_init(struct sock *sk)
 {
+	sk_owner_clear(sk);
+
 	if (sk->sk_kern_sock)
 		sock_lock_init_class_and_name(
 			sk,
@@ -1652,6 +1654,9 @@ static void sk_prot_free(struct proto *prot, struct sock *sk)
 	cgroup_sk_free(&sk->sk_cgrp_data);
 	mem_cgroup_sk_free(sk);
 	security_sk_free(sk);
+
+	sk_owner_put(sk);
+
 	if (slab != NULL)
 		kmem_cache_free(slab, sk);
 	else
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 55754bf176d9..cc0efcb4a553 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2593,6 +2593,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	int old_state = sk->sk_state;
+	struct request_sock *req;
 	u32 seq;
 
 	/* Deny disconnect if other threads are blocked in sk_wait_event()
@@ -2711,6 +2712,10 @@ int tcp_disconnect(struct sock *sk, int flags)
 
 
 	/* Clean up fastopen related fields */
+	req = rcu_dereference_protected(tp->fastopen_rsk,
+					lockdep_sock_is_held(sk));
+	if (req)
+		reqsk_fastopen_remove(sk, req, false);
 	tcp_free_fastopen_req(tp);
 	inet->defer_connect = 0;
 	tp->fastopen_client_fail = 0;
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 8c1508a2e241..df0b9edd4e87 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -336,8 +336,11 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		if (!psock->cork) {
 			psock->cork = kzalloc(sizeof(*psock->cork),
 					      GFP_ATOMIC | __GFP_NOWARN);
-			if (!psock->cork)
+			if (!psock->cork) {
+				sk_msg_free(sk, msg);
+				*copied = 0;
 				return -ENOMEM;
+			}
 		}
 		memcpy(psock->cork, msg, sizeof(*msg));
 		return 0;
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index f4c7e0af896b..ce902f8a0894 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1237,7 +1237,7 @@ drv_get_ftm_responder_stats(struct ieee80211_local *local,
 			    struct ieee80211_sub_if_data *sdata,
 			    struct cfg80211_ftm_responder_stats *ftm_stats)
 {
-	u32 ret = -EOPNOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	if (local->ops->get_ftm_responder_stats)
 		ret = local->ops->get_ftm_responder_stats(&local->hw,
diff --git a/net/rds/ib_frmr.c b/net/rds/ib_frmr.c
index ef6acd721118..aecbb313f920 100644
--- a/net/rds/ib_frmr.c
+++ b/net/rds/ib_frmr.c
@@ -133,12 +133,15 @@ static int rds_ib_post_reg_frmr(struct rds_ib_mr *ibmr)
 
 	ret = ib_map_mr_sg_zbva(frmr->mr, ibmr->sg, ibmr->sg_dma_len,
 				&off, PAGE_SIZE);
-	if (unlikely(ret != ibmr->sg_dma_len))
-		return ret < 0 ? ret : -EINVAL;
+	if (unlikely(ret != ibmr->sg_dma_len)) {
+		ret = ret < 0 ? ret : -EINVAL;
+		goto out_inc;
+	}
 
-	if (cmpxchg(&frmr->fr_state,
-		    FRMR_IS_FREE, FRMR_IS_INUSE) != FRMR_IS_FREE)
-		return -EBUSY;
+	if (cmpxchg(&frmr->fr_state, FRMR_IS_FREE, FRMR_IS_INUSE) != FRMR_IS_FREE) {
+		ret = -EBUSY;
+		goto out_inc;
+	}
 
 	atomic_inc(&ibmr->ic->i_fastreg_inuse_count);
 
@@ -166,11 +169,10 @@ static int rds_ib_post_reg_frmr(struct rds_ib_mr *ibmr)
 		/* Failure here can be because of -ENOMEM as well */
 		rds_transition_frwr_state(ibmr, FRMR_IS_INUSE, FRMR_IS_STALE);
 
-		atomic_inc(&ibmr->ic->i_fastreg_wrs);
 		if (printk_ratelimit())
 			pr_warn("RDS/IB: %s returned error(%d)\n",
 				__func__, ret);
-		goto out;
+		goto out_inc;
 	}
 
 	/* Wait for the registration to complete in order to prevent an invalid
@@ -179,8 +181,10 @@ static int rds_ib_post_reg_frmr(struct rds_ib_mr *ibmr)
 	 */
 	wait_event(frmr->fr_reg_done, !frmr->fr_reg);
 
-out:
+	return ret;
 
+out_inc:
+	atomic_inc(&ibmr->ic->i_fastreg_wrs);
 	return ret;
 }
 
diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 2df5bf240b64..1a3560cdba3e 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -78,16 +78,25 @@ static int rfkill_gpio_acpi_probe(struct device *dev,
 static int rfkill_gpio_probe(struct platform_device *pdev)
 {
 	struct rfkill_gpio_data *rfkill;
+	const char *type_name = NULL;
+	const char *name_property;
+	const char *type_property;
 	struct gpio_desc *gpio;
-	const char *type_name;
 	int ret;
 
 	rfkill = devm_kzalloc(&pdev->dev, sizeof(*rfkill), GFP_KERNEL);
 	if (!rfkill)
 		return -ENOMEM;
 
-	device_property_read_string(&pdev->dev, "name", &rfkill->name);
-	device_property_read_string(&pdev->dev, "type", &type_name);
+	if (dev_of_node(&pdev->dev)) {
+		name_property = "label";
+		type_property = "radio-type";
+	} else {
+		name_property = "name";
+		type_property = "type";
+	}
+	device_property_read_string(&pdev->dev, name_property, &rfkill->name);
+	device_property_read_string(&pdev->dev, type_property, &type_name);
 
 	if (!rfkill->name)
 		rfkill->name = dev_name(&pdev->dev);
@@ -169,12 +178,19 @@ static const struct acpi_device_id rfkill_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rfkill_acpi_match);
 #endif
 
+static const struct of_device_id rfkill_of_match[] __maybe_unused = {
+	{ .compatible = "rfkill-gpio", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rfkill_of_match);
+
 static struct platform_driver rfkill_gpio_driver = {
 	.probe = rfkill_gpio_probe,
 	.remove = rfkill_gpio_remove,
 	.driver = {
 		.name = "rfkill_gpio",
 		.acpi_match_table = ACPI_PTR(rfkill_acpi_match),
+		.of_match_table = of_match_ptr(rfkill_of_match),
 	},
 };
 
diff --git a/sound/firewire/motu/motu-hwdep.c b/sound/firewire/motu/motu-hwdep.c
index 0764a477052a..5e1254f106bf 100644
--- a/sound/firewire/motu/motu-hwdep.c
+++ b/sound/firewire/motu/motu-hwdep.c
@@ -73,7 +73,7 @@ static __poll_t hwdep_poll(struct snd_hwdep *hwdep, struct file *file,
 		events = 0;
 	spin_unlock_irq(&motu->lock);
 
-	return events | EPOLLOUT;
+	return events;
 }
 
 static int hwdep_get_info(struct snd_motu *motu, void __user *arg)
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index c194fbde8ad6..a02554b8edf7 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -218,7 +218,7 @@ static const struct snd_kcontrol_new wm8940_snd_controls[] = {
 	SOC_SINGLE_TLV("Digital Capture Volume", WM8940_ADCVOL,
 		       0, 255, 0, wm8940_adc_tlv),
 	SOC_ENUM("Mic Bias Level", wm8940_mic_bias_level_enum),
-	SOC_SINGLE_TLV("Capture Boost Volue", WM8940_ADCBOOST,
+	SOC_SINGLE_TLV("Capture Boost Volume", WM8940_ADCBOOST,
 		       8, 1, 0, wm8940_capture_boost_vol_tlv),
 	SOC_SINGLE_TLV("Speaker Playback Volume", WM8940_SPKVOL,
 		       0, 63, 0, wm8940_spk_vol_tlv),
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index dc4fe4f5239d..f32527ed06fb 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -427,10 +427,14 @@ static int wm8974_update_clocks(struct snd_soc_dai *dai)
 	fs256 = 256 * priv->fs;
 
 	f = wm8974_get_mclkdiv(priv->mclk, fs256, &mclkdiv);
-
 	if (f != priv->mclk) {
 		/* The PLL performs best around 90MHz */
-		fpll = wm8974_get_mclkdiv(22500000, fs256, &mclkdiv);
+		if (fs256 % 8000)
+			f = 22579200;
+		else
+			f = 24576000;
+
+		fpll = wm8974_get_mclkdiv(f, fs256, &mclkdiv);
 	}
 
 	wm8974_set_dai_pll(dai, 0, 0, priv->mclk, fpll);
diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 0c11fceb28a7..d3edc40c7f47 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -655,7 +655,7 @@ int hda_dsp_stream_init(struct snd_sof_dev *sdev)
 
 	if (num_capture >= SOF_HDA_CAPTURE_STREAMS) {
 		dev_err(sdev->dev, "error: too many capture streams %d\n",
-			num_playback);
+			num_capture);
 		return -EINVAL;
 	}
 
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index bc065ec997f3..974926d907c2 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -16,6 +16,7 @@
 
 #include <linux/hid.h>
 #include <linux/init.h>
+#include <linux/input.h>
 #include <linux/math64.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
@@ -75,7 +76,8 @@ static int snd_create_std_mono_ctl_offset(struct usb_mixer_interface *mixer,
 	cval->idx_off = idx_off;
 
 	/* get_min_max() is called only for integer volumes later,
-	 * so provide a short-cut for booleans */
+	 * so provide a short-cut for booleans
+	 */
 	cval->min = 0;
 	cval->max = 1;
 	cval->res = 0;
@@ -124,7 +126,7 @@ static int snd_create_std_mono_table(struct usb_mixer_interface *mixer,
 {
 	int err;
 
-	while (t->name != NULL) {
+	while (t->name) {
 		err = snd_create_std_mono_ctl(mixer, t->unitid, t->control,
 				t->cmask, t->val_type, t->name, t->tlv_callback);
 		if (err < 0)
@@ -206,7 +208,6 @@ static void snd_usb_soundblaster_remote_complete(struct urb *urb)
 	if (code == rc->mute_code)
 		snd_usb_mixer_notify_id(mixer, rc->mute_mixer_id);
 	mixer->rc_code = code;
-	wmb();
 	wake_up(&mixer->rc_waitq);
 }
 
@@ -526,6 +527,265 @@ static int snd_emu0204_controls_create(struct usb_mixer_interface *mixer)
 					  &snd_emu0204_control, NULL);
 }
 
+#if IS_REACHABLE(CONFIG_INPUT)
+/*
+ * Sony DualSense controller (PS5) jack detection
+ *
+ * Since this is an UAC 1 device, it doesn't support jack detection.
+ * However, the controller hid-playstation driver reports HP & MIC
+ * insert events through a dedicated input device.
+ */
+
+#define SND_DUALSENSE_JACK_OUT_TERM_ID 3
+#define SND_DUALSENSE_JACK_IN_TERM_ID 4
+
+struct dualsense_mixer_elem_info {
+	struct usb_mixer_elem_info info;
+	struct input_handler ih;
+	struct input_device_id id_table[2];
+	bool connected;
+};
+
+static void snd_dualsense_ih_event(struct input_handle *handle,
+				   unsigned int type, unsigned int code,
+				   int value)
+{
+	struct dualsense_mixer_elem_info *mei;
+	struct usb_mixer_elem_list *me;
+
+	if (type != EV_SW)
+		return;
+
+	mei = container_of(handle->handler, struct dualsense_mixer_elem_info, ih);
+	me = &mei->info.head;
+
+	if ((me->id == SND_DUALSENSE_JACK_OUT_TERM_ID && code == SW_HEADPHONE_INSERT) ||
+	    (me->id == SND_DUALSENSE_JACK_IN_TERM_ID && code == SW_MICROPHONE_INSERT)) {
+		mei->connected = !!value;
+		snd_ctl_notify(me->mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &me->kctl->id);
+	}
+}
+
+static bool snd_dualsense_ih_match(struct input_handler *handler,
+				   struct input_dev *dev)
+{
+	struct dualsense_mixer_elem_info *mei;
+	struct usb_device *snd_dev;
+	char *input_dev_path, *usb_dev_path;
+	size_t usb_dev_path_len;
+	bool match = false;
+
+	mei = container_of(handler, struct dualsense_mixer_elem_info, ih);
+	snd_dev = mei->info.head.mixer->chip->dev;
+
+	input_dev_path = kobject_get_path(&dev->dev.kobj, GFP_KERNEL);
+	if (!input_dev_path) {
+		dev_warn(&snd_dev->dev, "Failed to get input dev path\n");
+		return false;
+	}
+
+	usb_dev_path = kobject_get_path(&snd_dev->dev.kobj, GFP_KERNEL);
+	if (!usb_dev_path) {
+		dev_warn(&snd_dev->dev, "Failed to get USB dev path\n");
+		goto free_paths;
+	}
+
+	/*
+	 * Ensure the VID:PID matched input device supposedly owned by the
+	 * hid-playstation driver belongs to the actual hardware handled by
+	 * the current USB audio device, which implies input_dev_path being
+	 * a subpath of usb_dev_path.
+	 *
+	 * This verification is necessary when there is more than one identical
+	 * controller attached to the host system.
+	 */
+	usb_dev_path_len = strlen(usb_dev_path);
+	if (usb_dev_path_len >= strlen(input_dev_path))
+		goto free_paths;
+
+	usb_dev_path[usb_dev_path_len] = '/';
+	match = !memcmp(input_dev_path, usb_dev_path, usb_dev_path_len + 1);
+
+free_paths:
+	kfree(input_dev_path);
+	kfree(usb_dev_path);
+
+	return match;
+}
+
+static int snd_dualsense_ih_connect(struct input_handler *handler,
+				    struct input_dev *dev,
+				    const struct input_device_id *id)
+{
+	struct input_handle *handle;
+	int err;
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev = dev;
+	handle->handler = handler;
+	handle->name = handler->name;
+
+	err = input_register_handle(handle);
+	if (err)
+		goto err_free;
+
+	err = input_open_device(handle);
+	if (err)
+		goto err_unregister;
+
+	return 0;
+
+err_unregister:
+	input_unregister_handle(handle);
+err_free:
+	kfree(handle);
+	return err;
+}
+
+static void snd_dualsense_ih_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+static void snd_dualsense_ih_start(struct input_handle *handle)
+{
+	struct dualsense_mixer_elem_info *mei;
+	struct usb_mixer_elem_list *me;
+	int status = -1;
+
+	mei = container_of(handle->handler, struct dualsense_mixer_elem_info, ih);
+	me = &mei->info.head;
+
+	if (me->id == SND_DUALSENSE_JACK_OUT_TERM_ID &&
+	    test_bit(SW_HEADPHONE_INSERT, handle->dev->swbit))
+		status = test_bit(SW_HEADPHONE_INSERT, handle->dev->sw);
+	else if (me->id == SND_DUALSENSE_JACK_IN_TERM_ID &&
+		 test_bit(SW_MICROPHONE_INSERT, handle->dev->swbit))
+		status = test_bit(SW_MICROPHONE_INSERT, handle->dev->sw);
+
+	if (status >= 0) {
+		mei->connected = !!status;
+		snd_ctl_notify(me->mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &me->kctl->id);
+	}
+}
+
+static int snd_dualsense_jack_get(struct snd_kcontrol *kctl,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct dualsense_mixer_elem_info *mei = snd_kcontrol_chip(kctl);
+
+	ucontrol->value.integer.value[0] = mei->connected;
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new snd_dualsense_jack_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.access = SNDRV_CTL_ELEM_ACCESS_READ,
+	.info = snd_ctl_boolean_mono_info,
+	.get = snd_dualsense_jack_get,
+};
+
+static int snd_dualsense_resume_jack(struct usb_mixer_elem_list *list)
+{
+	snd_ctl_notify(list->mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+		       &list->kctl->id);
+	return 0;
+}
+
+static void snd_dualsense_mixer_elem_free(struct snd_kcontrol *kctl)
+{
+	struct dualsense_mixer_elem_info *mei = snd_kcontrol_chip(kctl);
+
+	if (mei->ih.event)
+		input_unregister_handler(&mei->ih);
+
+	snd_usb_mixer_elem_free(kctl);
+}
+
+static int snd_dualsense_jack_create(struct usb_mixer_interface *mixer,
+				     const char *name, bool is_output)
+{
+	struct dualsense_mixer_elem_info *mei;
+	struct input_device_id *idev_id;
+	struct snd_kcontrol *kctl;
+	int err;
+
+	mei = kzalloc(sizeof(*mei), GFP_KERNEL);
+	if (!mei)
+		return -ENOMEM;
+
+	snd_usb_mixer_elem_init_std(&mei->info.head, mixer,
+				    is_output ? SND_DUALSENSE_JACK_OUT_TERM_ID :
+						SND_DUALSENSE_JACK_IN_TERM_ID);
+
+	mei->info.head.resume = snd_dualsense_resume_jack;
+	mei->info.val_type = USB_MIXER_BOOLEAN;
+	mei->info.channels = 1;
+	mei->info.min = 0;
+	mei->info.max = 1;
+
+	kctl = snd_ctl_new1(&snd_dualsense_jack_control, mei);
+	if (!kctl) {
+		kfree(mei);
+		return -ENOMEM;
+	}
+
+	strscpy(kctl->id.name, name, sizeof(kctl->id.name));
+	kctl->private_free = snd_dualsense_mixer_elem_free;
+
+	err = snd_usb_mixer_add_control(&mei->info.head, kctl);
+	if (err)
+		return err;
+
+	idev_id = &mei->id_table[0];
+	idev_id->flags = INPUT_DEVICE_ID_MATCH_VENDOR | INPUT_DEVICE_ID_MATCH_PRODUCT |
+			 INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_SWBIT;
+	idev_id->vendor = USB_ID_VENDOR(mixer->chip->usb_id);
+	idev_id->product = USB_ID_PRODUCT(mixer->chip->usb_id);
+	idev_id->evbit[BIT_WORD(EV_SW)] = BIT_MASK(EV_SW);
+	if (is_output)
+		idev_id->swbit[BIT_WORD(SW_HEADPHONE_INSERT)] = BIT_MASK(SW_HEADPHONE_INSERT);
+	else
+		idev_id->swbit[BIT_WORD(SW_MICROPHONE_INSERT)] = BIT_MASK(SW_MICROPHONE_INSERT);
+
+	mei->ih.event = snd_dualsense_ih_event;
+	mei->ih.match = snd_dualsense_ih_match;
+	mei->ih.connect = snd_dualsense_ih_connect;
+	mei->ih.disconnect = snd_dualsense_ih_disconnect;
+	mei->ih.start = snd_dualsense_ih_start;
+	mei->ih.name = name;
+	mei->ih.id_table = mei->id_table;
+
+	err = input_register_handler(&mei->ih);
+	if (err) {
+		dev_warn(&mixer->chip->dev->dev,
+			 "Could not register input handler: %d\n", err);
+		mei->ih.event = NULL;
+	}
+
+	return 0;
+}
+
+static int snd_dualsense_controls_create(struct usb_mixer_interface *mixer)
+{
+	int err;
+
+	err = snd_dualsense_jack_create(mixer, "Headphone Jack", true);
+	if (err < 0)
+		return err;
+
+	return snd_dualsense_jack_create(mixer, "Headset Mic Jack", false);
+}
+#endif /* IS_REACHABLE(CONFIG_INPUT) */
+
 /* ASUS Xonar U1 / U3 controls */
 
 static int snd_xonar_u1_switch_get(struct snd_kcontrol *kcontrol,
@@ -1591,7 +1851,8 @@ static int snd_microii_spdif_default_put(struct snd_kcontrol *kcontrol,
 	unsigned int pval, pval_old;
 	int err;
 
-	pval = pval_old = kcontrol->private_value;
+	pval = kcontrol->private_value;
+	pval_old = pval;
 	pval &= 0xfffff0f0;
 	pval |= (ucontrol->value.iec958.status[1] & 0x0f) << 8;
 	pval |= (ucontrol->value.iec958.status[0] & 0x0f);
@@ -2380,6 +2641,13 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_emu0204_controls_create(mixer);
 		break;
 
+#if IS_REACHABLE(CONFIG_INPUT)
+	case USB_ID(0x054c, 0x0ce6): /* Sony DualSense controller (PS5) */
+	case USB_ID(0x054c, 0x0df2): /* Sony DualSense Edge controller (PS5) */
+		err = snd_dualsense_controls_create(mixer);
+		break;
+#endif /* IS_REACHABLE(CONFIG_INPUT) */
+
 	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
 	case USB_ID(0x0763, 0x2031): /* M-Audio Fast Track C400 */
 		err = snd_c400_create_mixer(mixer);
@@ -2502,7 +2770,8 @@ static void snd_dragonfly_quirk_db_scale(struct usb_mixer_interface *mixer,
 					 struct snd_kcontrol *kctl)
 {
 	/* Approximation using 10 ranges based on output measurement on hw v1.2.
-	 * This seems close to the cubic mapping e.g. alsamixer uses. */
+	 * This seems close to the cubic mapping e.g. alsamixer uses.
+	 */
 	static const DECLARE_TLV_DB_RANGE(scale,
 		 0,  1, TLV_DB_MINMAX_ITEM(-5300, -4970),
 		 2,  5, TLV_DB_MINMAX_ITEM(-4710, -4160),

