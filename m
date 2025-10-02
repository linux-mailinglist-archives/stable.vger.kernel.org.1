Return-Path: <stable+bounces-183048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF420BB4093
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C612A58B5
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6DC3126C4;
	Thu,  2 Oct 2025 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r68KeaE8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD69310620;
	Thu,  2 Oct 2025 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411824; cv=none; b=WBBaeI0FAxxlvBsG7hJa0tl5RPmKJclbwD0J/LaRKEGGT03ZYiQNrJ8XtTzEIreF1vZ8zuVyH67kWgEDhqEOVurRsYkSS25/XupEzdT/gaCLNz3NdSmBK1LelO+78Hs9nn+nZg2lKKHAfhNS6UWQg+GMLyOzezXtlERh01tCDDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411824; c=relaxed/simple;
	bh=HgTpno30JhHP6MgW8kLDmGRFvTs8N0R947CeqOVnaHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=az1pAVapyv2GeGF1IP967/dmIxoN5hYVdKLQLPM2VEqux43yZmIYmyTYqqf9khAlFIEDirNPzDdm8olWWt5z8sD24Z8oR4Ldj78gFsK5F1xf8wTlWF44eQt55MEE+48IsxHKhevyXvN6CLWLEPe+3b4+gy1YXt8oZ+FtmmU1NDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r68KeaE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F957C4CEFA;
	Thu,  2 Oct 2025 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759411824;
	bh=HgTpno30JhHP6MgW8kLDmGRFvTs8N0R947CeqOVnaHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r68KeaE8TofbcnlM6nNdS0pRUubgr6CrG6sX8O0VZ9EjV0gYXRyK9/r8b3zUn8sTd
	 z5QXh1VtCvlY3Dli6yJP5mHnyusHYMKNND1bO1eJarqjhFBKUfQ2+ehZlOwmD9UyIZ
	 zAKKLmKa+7RAEaemy8cDlJP1dSMVSoHGDxSXfOH0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.245
Date: Thu,  2 Oct 2025 15:30:11 +0200
Message-ID: <2025100211-flavorful-unlined-96a4@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025100211-unlearned-shuffle-fce1@gregkh>
References: <2025100211-unlearned-shuffle-fce1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 59f8dcbbea8c..3a8b862026a5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 244
+SUBLEVEL = 245
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 0186b3992b95..8b02ead72a88 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -142,7 +142,7 @@ thermal-zones {
 		cpu-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <2000>;
-			thermal-sensors = <&tmu 0>;
+			thermal-sensors = <&tmu 1>;
 			trips {
 				cpu_alert0: trip0 {
 					temperature = <85000>;
@@ -172,7 +172,7 @@ map0 {
 		soc-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <2000>;
-			thermal-sensors = <&tmu 1>;
+			thermal-sensors = <&tmu 0>;
 			trips {
 				soc_alert0: trip0 {
 					temperature = <85000>;
diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index d5d768188b3b..0178d33e5946 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1129,10 +1129,12 @@ static int virtio_uml_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, vu_dev);
 
 	rc = register_virtio_device(&vu_dev->vdev);
-	if (rc)
+	if (rc) {
 		put_device(&vu_dev->vdev.dev);
+		return rc;
+	}
 	vu_dev->registered = 1;
-	return rc;
+	return 0;
 
 error_init:
 	os_close_file(vu_dev->sock);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 1616e39ddc3f..8caf3c7a0601 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3397,8 +3397,7 @@ static inline void sync_lapic_to_cr8(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u64 cr8;
 
-	if (nested_svm_virtualize_tpr(vcpu) ||
-	    kvm_vcpu_apicv_active(vcpu))
+	if (nested_svm_virtualize_tpr(vcpu))
 		return;
 
 	cr8 = kvm_get_cr8(vcpu);
diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 755e6caf18d2..25cf2fa3dde7 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -862,6 +862,12 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	}
 
 	lock_sock(sk);
+	if (ctx->write) {
+		release_sock(sk);
+		return -EBUSY;
+	}
+	ctx->write = true;
+
 	if (ctx->init && !ctx->more) {
 		if (ctx->used) {
 			err = -EINVAL;
@@ -969,6 +975,7 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 
 unlock:
 	af_alg_data_wakeup(sk);
+	ctx->write = false;
 	release_sock(sk);
 
 	return copied ?: err;
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 149ba2e39a96..ff0daac63819 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2792,6 +2792,15 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 			goto err_null_driver;
 	}
 
+	/*
+	 * Mark support for the scheduler's frequency invariance engine for
+	 * drivers that implement target(), target_index() or fast_switch().
+	 */
+	if (!cpufreq_driver->setpolicy) {
+		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
+		pr_debug("cpufreq: supports frequency invariance\n");
+	}
+
 	ret = subsys_interface_register(&cpufreq_interface);
 	if (ret)
 		goto err_boost_unreg;
@@ -2814,21 +2823,14 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	hp_online = ret;
 	ret = 0;
 
-	/*
-	 * Mark support for the scheduler's frequency invariance engine for
-	 * drivers that implement target(), target_index() or fast_switch().
-	 */
-	if (!cpufreq_driver->setpolicy) {
-		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
-		pr_debug("supports frequency invariance");
-	}
-
 	pr_debug("driver %s up and running\n", driver_data->name);
 	goto out;
 
 err_if_unreg:
 	subsys_interface_unregister(&cpufreq_interface);
 err_boost_unreg:
+	if (!cpufreq_driver->setpolicy)
+		static_branch_disable_cpuslocked(&cpufreq_freq_invariance);
 	remove_boost_sysfs_file();
 err_null_driver:
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 4eeb8bb27279..86a1c239b36c 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1265,13 +1265,17 @@ static int bam_dma_probe(struct platform_device *pdev)
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
index 560fe658b894..c555b0991ad1 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2121,8 +2121,8 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
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
index 61de8b1ed75e..9de928346b2b 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -126,7 +126,6 @@ static ssize_t altr_sdr_mc_err_inject_write(struct file *file,
 
 	ptemp = dma_alloc_coherent(mci->pdev, 16, &dma_handle, GFP_KERNEL);
 	if (!ptemp) {
-		dma_free_coherent(mci->pdev, 16, ptemp, dma_handle);
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "Inject: Buffer Allocation error\n");
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index ae99d04f0045..5876589d42b7 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1978,8 +1978,10 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 	mhdp_state = to_cdns_mhdp_bridge_state(new_state);
 
 	mhdp_state->current_mode = drm_mode_duplicate(bridge->dev, mode);
-	if (!mhdp_state->current_mode)
-		return;
+	if (!mhdp_state->current_mode) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	drm_mode_set_name(mhdp_state->current_mode);
 
diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index a097a59a9eae..08e83b751319 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -724,8 +724,8 @@ void oaktrail_hdmi_teardown(struct drm_device *dev)
 
 	if (hdmi_dev) {
 		pdev = hdmi_dev->dev;
-		pci_set_drvdata(pdev, NULL);
 		oaktrail_hdmi_i2c_exit(pdev);
+		pci_set_drvdata(pdev, NULL);
 		iounmap(hdmi_dev->regs);
 		kfree(hdmi_dev);
 		pci_dev_put(pdev);
diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
index 7277e58b01f1..30174c050cc1 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -4780,7 +4780,7 @@ static void icl_mbus_init(struct drm_i915_private *dev_priv)
 	if (IS_GEN(dev_priv, 12))
 		abox_regs |= BIT(0);
 
-	for_each_set_bit(i, &abox_regs, sizeof(abox_regs))
+	for_each_set_bit(i, &abox_regs, BITS_PER_TYPE(abox_regs))
 		intel_de_rmw(dev_priv, MBUS_ABOX_CTL(i), mask, val);
 }
 
@@ -5277,11 +5277,11 @@ static void tgl_bw_buddy_init(struct drm_i915_private *dev_priv)
 	if (table[config].page_mask == 0) {
 		drm_dbg(&dev_priv->drm,
 			"Unknown memory configuration; disabling address buddy logic.\n");
-		for_each_set_bit(i, &abox_mask, sizeof(abox_mask))
+		for_each_set_bit(i, &abox_mask, BITS_PER_TYPE(abox_mask))
 			intel_de_write(dev_priv, BW_BUDDY_CTL(i),
 				       BW_BUDDY_DISABLE);
 	} else {
-		for_each_set_bit(i, &abox_mask, sizeof(abox_mask)) {
+		for_each_set_bit(i, &abox_mask, BITS_PER_TYPE(abox_mask)) {
 			intel_de_write(dev_priv, BW_BUDDY_PAGE_MASK(i),
 				       table[config].page_mask);
 
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 301c061bb319..679d85db26f4 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -194,6 +194,7 @@ static u16 get_legacy_obj_type(u16 opcode)
 {
 	switch (opcode) {
 	case MLX5_CMD_OP_CREATE_RQ:
+	case MLX5_CMD_OP_CREATE_RMP:
 		return MLX5_EVENT_QUEUE_TYPE_RQ;
 	case MLX5_CMD_OP_CREATE_QP:
 		return MLX5_EVENT_QUEUE_TYPE_QP;
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 9dc8ed9bc5c0..194d899f3ef8 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1155,6 +1155,20 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "XxHP4NAx"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "XxKK4NAx_XxSP4NAx"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
 	/*
 	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
 	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index cee1a4817af9..9df760f1f699 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -20,7 +20,9 @@
 #include <media/v4l2-subdev.h>
 
 #define IMX214_DEFAULT_CLK_FREQ	24000000
-#define IMX214_DEFAULT_LINK_FREQ 480000000
+#define IMX214_DEFAULT_LINK_FREQ	600000000
+/* Keep wrong link frequency for backward compatibility */
+#define IMX214_DEFAULT_LINK_FREQ_LEGACY	480000000
 #define IMX214_DEFAULT_PIXEL_RATE ((IMX214_DEFAULT_LINK_FREQ * 8LL) / 10)
 #define IMX214_FPS 30
 #define IMX214_MBUS_CODE MEDIA_BUS_FMT_SRGGB10_1X10
@@ -891,17 +893,26 @@ static int imx214_parse_fwnode(struct device *dev)
 		goto done;
 	}
 
-	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++)
+	if (bus_cfg.nr_of_link_frequencies != 1)
+		dev_warn(dev, "Only one link-frequency supported, please review your DT. Continuing anyway\n");
+
+	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++) {
 		if (bus_cfg.link_frequencies[i] == IMX214_DEFAULT_LINK_FREQ)
 			break;
-
-	if (i == bus_cfg.nr_of_link_frequencies) {
-		dev_err(dev, "link-frequencies %d not supported, Please review your DT\n",
-			IMX214_DEFAULT_LINK_FREQ);
-		ret = -EINVAL;
-		goto done;
+		if (bus_cfg.link_frequencies[i] ==
+		    IMX214_DEFAULT_LINK_FREQ_LEGACY) {
+			dev_warn(dev,
+				 "link-frequencies %d not supported, please review your DT. Continuing anyway\n",
+				 IMX214_DEFAULT_LINK_FREQ);
+			break;
+		}
 	}
 
+	if (i == bus_cfg.nr_of_link_frequencies)
+		ret = dev_err_probe(dev, -EINVAL,
+				    "link-frequencies %d not supported, please review your DT\n",
+				    IMX214_DEFAULT_LINK_FREQ);
+
 done:
 	v4l2_fwnode_endpoint_free(&bus_cfg);
 	fwnode_handle_put(endpoint);
diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
index d0123dfc5f93..ea305f6f49ed 100644
--- a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
@@ -509,7 +509,11 @@ static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
 
 	inst->ctx = ctx;
 	inst->vpu_inst.ctx = ctx;
-	inst->vpu_inst.id = is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
+	if (is_ext)
+		inst->vpu_inst.id = SCP_IPI_VENC_H264;
+	else
+		inst->vpu_inst.id = IPI_VENC_H264;
+
 	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx, VENC_SYS);
 
 	mtk_vcodec_debug_enter(inst);
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index b4f6a0a2fcb5..bc31921e2c4d 100644
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
 
diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
index 5594a22c0137..e86b6c9c44d3 100644
--- a/drivers/mtd/mtdpstore.c
+++ b/drivers/mtd/mtdpstore.c
@@ -423,6 +423,9 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
 	cxt->badmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
 
+	if (!cxt->rmmap || !cxt->usedmap || !cxt->badmap)
+		return;
+
 	cxt->dev.total_size = mtd->size;
 	/* just support dmesg right now */
 	cxt->dev.flags = PSTORE_FLAGS_DMESG;
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 3468cc329399..179696ea6f57 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1378,13 +1378,23 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
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
index c0c47f31c100..f04769f4b27a 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -261,6 +261,7 @@ struct stm32_fmc2_nfc {
 	struct sg_table dma_data_sg;
 	struct sg_table dma_ecc_sg;
 	u8 *ecc_buf;
+	dma_addr_t dma_ecc_addr;
 	int dma_ecc_len;
 
 	struct completion complete;
@@ -858,8 +859,8 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 
 	ret = dma_map_sg(nfc->dev, nfc->dma_data_sg.sgl,
 			 eccsteps, dma_data_dir);
-	if (ret < 0)
-		return ret;
+	if (!ret)
+		return -EIO;
 
 	desc_data = dmaengine_prep_slave_sg(dma_ch, nfc->dma_data_sg.sgl,
 					    eccsteps, dma_transfer_dir,
@@ -881,24 +882,19 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 
 	if (!write_data && !raw) {
 		/* Configure DMA ECC status */
-		p = nfc->ecc_buf;
 		for_each_sg(nfc->dma_ecc_sg.sgl, sg, eccsteps, s) {
-			sg_set_buf(sg, p, nfc->dma_ecc_len);
-			p += nfc->dma_ecc_len;
+			sg_dma_address(sg) = nfc->dma_ecc_addr +
+					     s * nfc->dma_ecc_len;
+			sg_dma_len(sg) = nfc->dma_ecc_len;
 		}
 
-		ret = dma_map_sg(nfc->dev, nfc->dma_ecc_sg.sgl,
-				 eccsteps, dma_data_dir);
-		if (ret < 0)
-			goto err_unmap_data;
-
 		desc_ecc = dmaengine_prep_slave_sg(nfc->dma_ecc_ch,
 						   nfc->dma_ecc_sg.sgl,
 						   eccsteps, dma_transfer_dir,
 						   DMA_PREP_INTERRUPT);
 		if (!desc_ecc) {
 			ret = -ENOMEM;
-			goto err_unmap_ecc;
+			goto err_unmap_data;
 		}
 
 		reinit_completion(&nfc->dma_ecc_complete);
@@ -906,7 +902,7 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 		desc_ecc->callback_param = &nfc->dma_ecc_complete;
 		ret = dma_submit_error(dmaengine_submit(desc_ecc));
 		if (ret)
-			goto err_unmap_ecc;
+			goto err_unmap_data;
 
 		dma_async_issue_pending(nfc->dma_ecc_ch);
 	}
@@ -926,7 +922,7 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 		if (!write_data && !raw)
 			dmaengine_terminate_all(nfc->dma_ecc_ch);
 		ret = -ETIMEDOUT;
-		goto err_unmap_ecc;
+		goto err_unmap_data;
 	}
 
 	/* Wait DMA data transfer completion */
@@ -946,11 +942,6 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 		}
 	}
 
-err_unmap_ecc:
-	if (!write_data && !raw)
-		dma_unmap_sg(nfc->dev, nfc->dma_ecc_sg.sgl,
-			     eccsteps, dma_data_dir);
-
 err_unmap_data:
 	dma_unmap_sg(nfc->dev, nfc->dma_data_sg.sgl, eccsteps, dma_data_dir);
 
@@ -973,9 +964,21 @@ static int stm32_fmc2_nfc_seq_write(struct nand_chip *chip, const u8 *buf,
 
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
@@ -1576,7 +1579,8 @@ static int stm32_fmc2_nfc_dma_setup(struct stm32_fmc2_nfc *nfc)
 		return ret;
 
 	/* Allocate a buffer to store ECC status registers */
-	nfc->ecc_buf = devm_kzalloc(nfc->dev, FMC2_MAX_ECC_BUF_LEN, GFP_KERNEL);
+	nfc->ecc_buf = dmam_alloc_coherent(nfc->dev, FMC2_MAX_ECC_BUF_LEN,
+					   &nfc->dma_ecc_addr, GFP_KERNEL);
 	if (!nfc->ecc_buf)
 		return -ENOMEM;
 
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 134eda66f0dc..e759d940977a 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -867,7 +867,6 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct rcar_can_priv *priv = netdev_priv(ndev);
-	u16 ctlr;
 	int err;
 
 	if (!netif_running(ndev))
@@ -879,12 +878,7 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
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
index 89796691917b..1f2402f02774 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -751,6 +751,7 @@ static const struct net_device_ops sun4ican_netdev_ops = {
 	.ndo_open = sun4ican_open,
 	.ndo_stop = sun4ican_close,
 	.ndo_start_xmit = sun4ican_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct of_device_id sun4ican_of_match[] = {
diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index c07e327929ba..7179eb0fedb1 100644
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
index 73c1bc3cb70d..3a963f2a8c44 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -84,7 +84,7 @@ void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
 		u32 delta_ts = time_ref->ts_dev_2 - time_ref->ts_dev_1;
 
 		if (time_ref->ts_dev_2 < time_ref->ts_dev_1)
-			delta_ts &= (1 << time_ref->adapter->ts_used_bits) - 1;
+			delta_ts &= (1ULL << time_ref->adapter->ts_used_bits) - 1;
 
 		time_ref->ts_total += delta_ts;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index 775d0b7521ca..ef2bd84c55ff 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -243,7 +243,7 @@ bnxt_tc_parse_pedit(struct bnxt *bp, struct bnxt_tc_actions *actions,
 			   offset < offset_of_ip6_daddr + 16) {
 			actions->nat.src_xlate = false;
 			idx = (offset - offset_of_ip6_daddr) / 4;
-			actions->nat.l3.ipv6.saddr.s6_addr32[idx] = htonl(val);
+			actions->nat.l3.ipv6.daddr.s6_addr32[idx] = htonl(val);
 		} else {
 			netdev_err(bp->dev,
 				   "%s: IPv6_hdr: Invalid pedit field\n",
diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index f7f10cfb3476..582ca9753286 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -4223,8 +4223,7 @@ static void cnic_cm_stop_bnx2x_hw(struct cnic_dev *dev)
 
 	cnic_bnx2x_delete_wait(dev, 0);
 
-	cancel_delayed_work(&cp->delete_task);
-	flush_workqueue(cnic_wq);
+	cancel_delayed_work_sync(&cp->delete_task);
 
 	if (atomic_read(&cp->iscsi_conn) != 0)
 		netdev_warn(dev->netdev, "%d iSCSI connections not destroyed\n",
diff --git a/drivers/net/ethernet/cavium/liquidio/request_manager.c b/drivers/net/ethernet/cavium/liquidio/request_manager.c
index 8e59c2825533..2a066f193bca 100644
--- a/drivers/net/ethernet/cavium/liquidio/request_manager.c
+++ b/drivers/net/ethernet/cavium/liquidio/request_manager.c
@@ -135,7 +135,7 @@ int octeon_init_instr_queue(struct octeon_device *oct,
 	oct->io_qmask.iq |= BIT_ULL(iq_no);
 
 	/* Set the 32B/64B mode for each input queue */
-	oct->io_qmask.iq64B |= ((conf->instr_type == 64) << iq_no);
+	oct->io_qmask.iq64B |= ((u64)(conf->instr_type == 64) << iq_no);
 	iq->iqcmd_64B = (conf->instr_type == 64);
 
 	oct->fn_list.setup_iq_regs(oct, iq_no);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index adf70a1650f4..9905e6562100 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1986,7 +1986,8 @@ static void fec_enet_phy_reset_after_clk_enable(struct net_device *ndev)
 		 */
 		phy_dev = of_phy_find_device(fep->phy_node);
 		phy_reset_after_clk_enable(phy_dev);
-		put_device(&phy_dev->mdio.dev);
+		if (phy_dev)
+			put_device(&phy_dev->mdio.dev);
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index add9a3107d9a..512354442891 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -50,6 +50,7 @@
 #define I40E_MAX_VEB			16
 
 #define I40E_MAX_NUM_DESCRIPTORS	4096
+#define I40E_MAX_NUM_DESCRIPTORS_XL710	8160
 #define I40E_MAX_CSR_SPACE		(4 * 1024 * 1024 - 64 * 1024)
 #define I40E_DEFAULT_NUM_DESCRIPTORS	512
 #define I40E_REQ_DESCRIPTOR_MULTIPLE	32
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 7f8fc9b3b105..588b72aba4f6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1916,6 +1916,18 @@ static void i40e_get_drvinfo(struct net_device *netdev,
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
@@ -1923,8 +1935,8 @@ static void i40e_get_ringparam(struct net_device *netdev,
 	struct i40e_pf *pf = np->vsi->back;
 	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 
-	ring->rx_max_pending = I40E_MAX_NUM_DESCRIPTORS;
-	ring->tx_max_pending = I40E_MAX_NUM_DESCRIPTORS;
+	ring->rx_max_pending = i40e_get_max_num_descriptors(pf);
+	ring->tx_max_pending = i40e_get_max_num_descriptors(pf);
 	ring->rx_mini_max_pending = 0;
 	ring->rx_jumbo_max_pending = 0;
 	ring->rx_pending = vsi->rx_rings[0]->count;
@@ -1947,12 +1959,12 @@ static bool i40e_active_tx_ring_index(struct i40e_vsi *vsi, u16 index)
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
@@ -1960,14 +1972,15 @@ static int i40e_set_ringparam(struct net_device *netdev,
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
index aa24d1808c98..f11cb3176cab 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3969,10 +3969,10 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
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
@@ -3983,8 +3983,8 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
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
@@ -4801,7 +4801,7 @@ static void i40e_vsi_free_irq(struct i40e_vsi *vsi)
 			/* clear the affinity notifier in the IRQ descriptor */
 			irq_set_affinity_notifier(irq_num, NULL);
 			/* remove our suggested affinity mask for this IRQ */
-			irq_set_affinity_hint(irq_num, NULL);
+			irq_update_affinity_hint(irq_num, NULL);
 			synchronize_irq(irq_num);
 			free_irq(irq_num, vsi->q_vectors[i]);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 57667ccc28f5..0678705cb1b4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -795,9 +795,6 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 		if (!eop_desc)
 			break;
 
-		/* prevent any other reads prior to eop_desc */
-		smp_rmb();
-
 		i40e_trace(clean_tx_irq, tx_ring, tx_desc, tx_buf);
 		/* we have caught up to head, no work left to do */
 		if (tx_head == tx_desc)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index c86c429e9a3a..3ddb712b732d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -393,7 +393,7 @@ static void i40e_config_irq_link_list(struct i40e_vf *vf, u16 vsi_id,
 		    (qtype << I40E_QINT_RQCTL_NEXTQ_TYPE_SHIFT) |
 		    (pf_queue_id << I40E_QINT_RQCTL_NEXTQ_INDX_SHIFT) |
 		    BIT(I40E_QINT_RQCTL_CAUSE_ENA_SHIFT) |
-		    (itr_idx << I40E_QINT_RQCTL_ITR_INDX_SHIFT);
+		    FIELD_PREP(I40E_QINT_RQCTL_ITR_INDX_MASK, itr_idx);
 		wr32(hw, reg_idx, reg);
 	}
 
@@ -600,6 +600,13 @@ static int i40e_config_vsi_tx_queue(struct i40e_vf *vf, u16 vsi_id,
 
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
@@ -665,6 +672,13 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 
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
@@ -1402,6 +1416,7 @@ static void i40e_trigger_vf_reset(struct i40e_vf *vf, bool flr)
 	 * functions that may still be running at this point.
 	 */
 	clear_bit(I40E_VF_STATE_INIT, &vf->vf_states);
+	clear_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states);
 
 	/* In the case of a VFLR, the HW has already reset the VF and we
 	 * just need to clean up, so don't hit the VFRTRIG register.
@@ -2068,7 +2083,10 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
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
@@ -2164,6 +2182,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 				vf->default_lan_addr.addr);
 	}
 	set_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states);
+	set_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states);
 
 err:
 	/* send the response back to the VF */
@@ -2326,7 +2345,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		}
 
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = I40E_ERR_NO_AVAILABLE_VSI;
 				goto error_param;
 			}
@@ -2347,7 +2366,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		 * to its appropriate VSIs based on TC mapping
 		 */
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = I40E_ERR_NO_AVAILABLE_VSI;
 				goto error_param;
 			}
@@ -2397,8 +2416,10 @@ static int i40e_validate_queue_map(struct i40e_vf *vf, u16 vsi_id,
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
@@ -3410,7 +3431,7 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 
 	/* action_meta is TC number here to which the filter is applied */
 	if (!tc_filter->action_meta ||
-	    tc_filter->action_meta > vf->num_tc) {
+	    tc_filter->action_meta >= vf->num_tc) {
 		dev_info(&pf->pdev->dev, "VF %d: Invalid TC number %u\n",
 			 vf->vf_id, tc_filter->action_meta);
 		goto err;
@@ -3708,6 +3729,8 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 				       aq_ret);
 }
 
+#define I40E_MAX_VF_CLOUD_FILTER 0xFF00
+
 /**
  * i40e_vc_add_cloud_filter
  * @vf: pointer to the VF info
@@ -3747,6 +3770,14 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
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
index 97e9c34d7c6c..3b841fbaffa6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -39,7 +39,8 @@ enum i40e_vf_states {
 	I40E_VF_STATE_MC_PROMISC,
 	I40E_VF_STATE_UC_PROMISC,
 	I40E_VF_STATE_PRE_ENABLE,
-	I40E_VF_STATE_RESETTING
+	I40E_VF_STATE_RESETTING,
+	I40E_VF_STATE_RESOURCES_LOADED,
 };
 
 /* VF capabilities */
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 2d1d9090f2cb..d472e01c2c99 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2081,11 +2081,8 @@ static void igb_diag_test(struct net_device *netdev,
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
index cc93c503984a..cef60bc2589c 100644
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
index 72794d158871..09dbc975fcee 100644
--- a/drivers/net/ethernet/natsemi/ns83820.c
+++ b/drivers/net/ethernet/natsemi/ns83820.c
@@ -820,7 +820,7 @@ static void rx_irq(struct net_device *ndev)
 	struct ns83820 *dev = PRIV(ndev);
 	struct rx_info *info = &dev->rx_info;
 	unsigned next_rx;
-	int rx_rc, len;
+	int len;
 	u32 cmdsts;
 	__le32 *desc;
 	unsigned long flags;
@@ -881,8 +881,10 @@ static void rx_irq(struct net_device *ndev)
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
@@ -901,15 +903,12 @@ static void rx_irq(struct net_device *ndev)
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
diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
index 4b4077cf2d26..b4e108d3ec94 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -4374,10 +4374,11 @@ static enum dbg_status qed_protection_override_dump(struct qed_hwfn *p_hwfn,
 		goto out;
 	}
 
-	/* Add override window info to buffer */
+	/* Add override window info to buffer, preventing buffer overflow */
 	override_window_dwords =
-		qed_rd(p_hwfn, p_ptt, GRC_REG_NUMBER_VALID_OVERRIDE_WINDOW) *
-		PROTECTION_OVERRIDE_ELEMENT_DWORDS;
+		min(qed_rd(p_hwfn, p_ptt, GRC_REG_NUMBER_VALID_OVERRIDE_WINDOW) *
+		PROTECTION_OVERRIDE_ELEMENT_DWORDS,
+		PROTECTION_OVERRIDE_DEPTH_DWORDS);
 	if (override_window_dwords) {
 		addr = BYTES_TO_DWORDS(GRC_REG_PROTECTION_OVERRIDE_WINDOW);
 		offset += qed_grc_dump_addr_range(p_hwfn,
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index d3ef5534991e..a98841db02d5 100644
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
 		.name	= driver_name,
 	},
diff --git a/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c b/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
index b074682d9dd8..548e46776100 100644
--- a/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
+++ b/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
@@ -126,7 +126,6 @@ static int cygnus_pcie_phy_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node, *child;
 	struct cygnus_pcie_phy_core *core;
 	struct phy_provider *provider;
-	struct resource *res;
 	unsigned cnt = 0;
 	int ret;
 
@@ -141,8 +140,7 @@ static int cygnus_pcie_phy_probe(struct platform_device *pdev)
 
 	core->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	core->base = devm_ioremap_resource(dev, res);
+	core->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(core->base))
 		return PTR_ERR(core->base);
 
diff --git a/drivers/phy/broadcom/phy-bcm-kona-usb2.c b/drivers/phy/broadcom/phy-bcm-kona-usb2.c
index 6459296d9bf9..e9cc5f2cb89a 100644
--- a/drivers/phy/broadcom/phy-bcm-kona-usb2.c
+++ b/drivers/phy/broadcom/phy-bcm-kona-usb2.c
@@ -94,7 +94,6 @@ static int bcm_kona_usb2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct bcm_kona_usb *phy;
-	struct resource *res;
 	struct phy *gphy;
 	struct phy_provider *phy_provider;
 
@@ -102,8 +101,7 @@ static int bcm_kona_usb2_probe(struct platform_device *pdev)
 	if (!phy)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	phy->regs = devm_ioremap_resource(&pdev->dev, res);
+	phy->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(phy->regs))
 		return PTR_ERR(phy->regs);
 
diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb2.c b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
index 9f2f84d65dcd..4b015b8a71c3 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb2.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
@@ -83,7 +83,6 @@ static int bcm_ns_usb2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct bcm_ns_usb2 *usb2;
-	struct resource *res;
 	struct phy_provider *phy_provider;
 
 	usb2 = devm_kzalloc(&pdev->dev, sizeof(*usb2), GFP_KERNEL);
@@ -91,8 +90,7 @@ static int bcm_ns_usb2_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	usb2->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmu");
-	usb2->dmu = devm_ioremap_resource(dev, res);
+	usb2->dmu = devm_platform_ioremap_resource_byname(pdev, "dmu");
 	if (IS_ERR(usb2->dmu)) {
 		dev_err(dev, "Failed to map DMU regs\n");
 		return PTR_ERR(usb2->dmu);
diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb3.c b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
index 47b029fbebbd..45b366855e80 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb3.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
@@ -16,14 +16,13 @@
 #include <linux/iopoll.h>
 #include <linux/mdio.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
-#define BCM_NS_USB3_MII_MNG_TIMEOUT_US	1000	/* usecs */
-
 #define BCM_NS_USB3_PHY_BASE_ADDR_REG	0x1f
 #define BCM_NS_USB3_PHY_PLL30_BLOCK	0x8000
 #define BCM_NS_USB3_PHY_TX_PMD_BLOCK	0x8040
@@ -51,11 +50,8 @@ struct bcm_ns_usb3 {
 	struct device *dev;
 	enum bcm_ns_family family;
 	void __iomem *dmp;
-	void __iomem *ccb_mii;
 	struct mdio_device *mdiodev;
 	struct phy *phy;
-
-	int (*phy_write)(struct bcm_ns_usb3 *usb3, u16 reg, u16 value);
 };
 
 static const struct of_device_id bcm_ns_usb3_id_table[] = {
@@ -69,13 +65,9 @@ static const struct of_device_id bcm_ns_usb3_id_table[] = {
 	},
 	{},
 };
-MODULE_DEVICE_TABLE(of, bcm_ns_usb3_id_table);
 
 static int bcm_ns_usb3_mdio_phy_write(struct bcm_ns_usb3 *usb3, u16 reg,
-				      u16 value)
-{
-	return usb3->phy_write(usb3, reg, value);
-}
+				      u16 value);
 
 static int bcm_ns_usb3_phy_init_ns_bx(struct bcm_ns_usb3 *usb3)
 {
@@ -187,8 +179,8 @@ static const struct phy_ops ops = {
  * MDIO driver code
  **************************************************/
 
-static int bcm_ns_usb3_mdiodev_phy_write(struct bcm_ns_usb3 *usb3, u16 reg,
-					 u16 value)
+static int bcm_ns_usb3_mdio_phy_write(struct bcm_ns_usb3 *usb3, u16 reg,
+				      u16 value)
 {
 	struct mdio_device *mdiodev = usb3->mdiodev;
 
@@ -198,7 +190,6 @@ static int bcm_ns_usb3_mdiodev_phy_write(struct bcm_ns_usb3 *usb3, u16 reg,
 static int bcm_ns_usb3_mdio_probe(struct mdio_device *mdiodev)
 {
 	struct device *dev = &mdiodev->dev;
-	const struct of_device_id *of_id;
 	struct phy_provider *phy_provider;
 	struct device_node *syscon_np;
 	struct bcm_ns_usb3 *usb3;
@@ -212,10 +203,7 @@ static int bcm_ns_usb3_mdio_probe(struct mdio_device *mdiodev)
 	usb3->dev = dev;
 	usb3->mdiodev = mdiodev;
 
-	of_id = of_match_device(bcm_ns_usb3_id_table, dev);
-	if (!of_id)
-		return -EINVAL;
-	usb3->family = (enum bcm_ns_family)of_id->data;
+	usb3->family = (enum bcm_ns_family)device_get_match_data(dev);
 
 	syscon_np = of_parse_phandle(dev->of_node, "usb3-dmp-syscon", 0);
 	err = of_address_to_resource(syscon_np, 0, &res);
@@ -229,8 +217,6 @@ static int bcm_ns_usb3_mdio_probe(struct mdio_device *mdiodev)
 		return PTR_ERR(usb3->dmp);
 	}
 
-	usb3->phy_write = bcm_ns_usb3_mdiodev_phy_write;
-
 	usb3->phy = devm_phy_create(dev, NULL, &ops);
 	if (IS_ERR(usb3->phy)) {
 		dev_err(dev, "Failed to create PHY\n");
@@ -254,145 +240,7 @@ static struct mdio_driver bcm_ns_usb3_mdio_driver = {
 	.probe = bcm_ns_usb3_mdio_probe,
 };
 
-/**************************************************
- * Platform driver code
- **************************************************/
-
-static int bcm_ns_usb3_wait_reg(struct bcm_ns_usb3 *usb3, void __iomem *addr,
-				u32 mask, u32 value, int usec)
-{
-	u32 val;
-	int ret;
-
-	ret = readl_poll_timeout_atomic(addr, val, ((val & mask) == value),
-					10, usec);
-	if (ret)
-		dev_err(usb3->dev, "Timeout waiting for register %p\n", addr);
-
-	return ret;
-}
-
-static inline int bcm_ns_usb3_mii_mng_wait_idle(struct bcm_ns_usb3 *usb3)
-{
-	return bcm_ns_usb3_wait_reg(usb3, usb3->ccb_mii + BCMA_CCB_MII_MNG_CTL,
-				    0x0100, 0x0000,
-				    BCM_NS_USB3_MII_MNG_TIMEOUT_US);
-}
-
-static int bcm_ns_usb3_platform_phy_write(struct bcm_ns_usb3 *usb3, u16 reg,
-					  u16 value)
-{
-	u32 tmp = 0;
-	int err;
-
-	err = bcm_ns_usb3_mii_mng_wait_idle(usb3);
-	if (err < 0) {
-		dev_err(usb3->dev, "Couldn't write 0x%08x value\n", value);
-		return err;
-	}
-
-	/* TODO: Use a proper MDIO bus layer */
-	tmp |= 0x58020000; /* Magic value for MDIO PHY write */
-	tmp |= reg << 18;
-	tmp |= value;
-	writel(tmp, usb3->ccb_mii + BCMA_CCB_MII_MNG_CMD_DATA);
-
-	return bcm_ns_usb3_mii_mng_wait_idle(usb3);
-}
-
-static int bcm_ns_usb3_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	const struct of_device_id *of_id;
-	struct bcm_ns_usb3 *usb3;
-	struct resource *res;
-	struct phy_provider *phy_provider;
-
-	usb3 = devm_kzalloc(dev, sizeof(*usb3), GFP_KERNEL);
-	if (!usb3)
-		return -ENOMEM;
-
-	usb3->dev = dev;
-
-	of_id = of_match_device(bcm_ns_usb3_id_table, dev);
-	if (!of_id)
-		return -EINVAL;
-	usb3->family = (enum bcm_ns_family)of_id->data;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmp");
-	usb3->dmp = devm_ioremap_resource(dev, res);
-	if (IS_ERR(usb3->dmp)) {
-		dev_err(dev, "Failed to map DMP regs\n");
-		return PTR_ERR(usb3->dmp);
-	}
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ccb-mii");
-	usb3->ccb_mii = devm_ioremap_resource(dev, res);
-	if (IS_ERR(usb3->ccb_mii)) {
-		dev_err(dev, "Failed to map ChipCommon B MII regs\n");
-		return PTR_ERR(usb3->ccb_mii);
-	}
-
-	/* Enable MDIO. Setting MDCDIV as 26  */
-	writel(0x0000009a, usb3->ccb_mii + BCMA_CCB_MII_MNG_CTL);
-
-	/* Wait for MDIO? */
-	udelay(2);
-
-	usb3->phy_write = bcm_ns_usb3_platform_phy_write;
-
-	usb3->phy = devm_phy_create(dev, NULL, &ops);
-	if (IS_ERR(usb3->phy)) {
-		dev_err(dev, "Failed to create PHY\n");
-		return PTR_ERR(usb3->phy);
-	}
-
-	phy_set_drvdata(usb3->phy, usb3);
-	platform_set_drvdata(pdev, usb3);
-
-	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-	if (!IS_ERR(phy_provider))
-		dev_info(dev, "Registered Broadcom Northstar USB 3.0 PHY driver\n");
-
-	return PTR_ERR_OR_ZERO(phy_provider);
-}
-
-static struct platform_driver bcm_ns_usb3_driver = {
-	.probe		= bcm_ns_usb3_probe,
-	.driver = {
-		.name = "bcm_ns_usb3",
-		.of_match_table = bcm_ns_usb3_id_table,
-	},
-};
-
-static int __init bcm_ns_usb3_module_init(void)
-{
-	int err;
-
-	/*
-	 * For backward compatibility we register as MDIO and platform driver.
-	 * After getting MDIO binding commonly used (e.g. switching all DT files
-	 * to use it) we should deprecate the old binding and eventually drop
-	 * support for it.
-	 */
-
-	err = mdio_driver_register(&bcm_ns_usb3_mdio_driver);
-	if (err)
-		return err;
-
-	err = platform_driver_register(&bcm_ns_usb3_driver);
-	if (err)
-		mdio_driver_unregister(&bcm_ns_usb3_mdio_driver);
-
-	return err;
-}
-module_init(bcm_ns_usb3_module_init);
-
-static void __exit bcm_ns_usb3_module_exit(void)
-{
-	platform_driver_unregister(&bcm_ns_usb3_driver);
-	mdio_driver_unregister(&bcm_ns_usb3_mdio_driver);
-}
-module_exit(bcm_ns_usb3_module_exit)
+mdio_module_driver(bcm_ns_usb3_mdio_driver);
 
 MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(of, bcm_ns_usb3_id_table);
diff --git a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
index 9630ac127366..65a399acc845 100644
--- a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
+++ b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
@@ -293,7 +293,6 @@ static int ns2_drd_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ns2_phy_driver *driver;
 	struct ns2_phy_data *data;
-	struct resource *res;
 	int ret;
 	u32 val;
 
@@ -307,23 +306,19 @@ static int ns2_drd_phy_probe(struct platform_device *pdev)
 	if (!driver->data)
 		return -ENOMEM;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "icfg");
-	driver->icfgdrd_regs = devm_ioremap_resource(dev, res);
+	driver->icfgdrd_regs = devm_platform_ioremap_resource_byname(pdev, "icfg");
 	if (IS_ERR(driver->icfgdrd_regs))
 		return PTR_ERR(driver->icfgdrd_regs);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rst-ctrl");
-	driver->idmdrd_rst_ctrl = devm_ioremap_resource(dev, res);
+	driver->idmdrd_rst_ctrl = devm_platform_ioremap_resource_byname(pdev, "rst-ctrl");
 	if (IS_ERR(driver->idmdrd_rst_ctrl))
 		return PTR_ERR(driver->idmdrd_rst_ctrl);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "crmu-ctrl");
-	driver->crmu_usb2_ctrl = devm_ioremap_resource(dev, res);
+	driver->crmu_usb2_ctrl = devm_platform_ioremap_resource_byname(pdev, "crmu-ctrl");
 	if (IS_ERR(driver->crmu_usb2_ctrl))
 		return PTR_ERR(driver->crmu_usb2_ctrl);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "usb2-strap");
-	driver->usb2h_strap_reg = devm_ioremap_resource(dev, res);
+	driver->usb2h_strap_reg = devm_platform_ioremap_resource_byname(pdev, "usb2-strap");
 	if (IS_ERR(driver->usb2h_strap_reg))
 		return PTR_ERR(driver->usb2h_strap_reg);
 
diff --git a/drivers/phy/broadcom/phy-bcm-sr-pcie.c b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
index 96a3af126a78..8a4aadf166cf 100644
--- a/drivers/phy/broadcom/phy-bcm-sr-pcie.c
+++ b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
@@ -217,7 +217,6 @@ static int sr_pcie_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct sr_pcie_phy_core *core;
-	struct resource *res;
 	struct phy_provider *provider;
 	unsigned int phy_idx = 0;
 
@@ -226,9 +225,7 @@ static int sr_pcie_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	core->dev = dev;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	core->base = devm_ioremap_resource(core->dev, res);
+	core->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(core->base))
 		return PTR_ERR(core->base);
 
diff --git a/drivers/phy/broadcom/phy-bcm-sr-usb.c b/drivers/phy/broadcom/phy-bcm-sr-usb.c
index c3e99ad17487..0002da3b5b5d 100644
--- a/drivers/phy/broadcom/phy-bcm-sr-usb.c
+++ b/drivers/phy/broadcom/phy-bcm-sr-usb.c
@@ -300,14 +300,12 @@ static int bcm_usb_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node;
 	const struct of_device_id *of_id;
-	struct resource *res;
 	void __iomem *regs;
 	int ret;
 	enum bcm_usb_phy_version version;
 	struct phy_provider *phy_provider;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(dev, res);
+	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
index 18251f232172..53942973f508 100644
--- a/drivers/phy/broadcom/phy-brcm-sata.c
+++ b/drivers/phy/broadcom/phy-brcm-sata.c
@@ -726,7 +726,6 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 	struct device_node *dn = dev->of_node, *child;
 	const struct of_device_id *of_id;
 	struct brcm_sata_phy *priv;
-	struct resource *res;
 	struct phy_provider *provider;
 	int ret, count = 0;
 
@@ -739,8 +738,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, priv);
 	priv->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
-	priv->phy_base = devm_ioremap_resource(dev, res);
+	priv->phy_base = devm_platform_ioremap_resource_byname(pdev, "phy");
 	if (IS_ERR(priv->phy_base))
 		return PTR_ERR(priv->phy_base);
 
@@ -751,9 +749,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 		priv->version = BRCM_SATA_PHY_STB_28NM;
 
 	if (priv->version == BRCM_SATA_PHY_IPROC_NS2) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "phy-ctrl");
-		priv->ctrl_base = devm_ioremap_resource(dev, res);
+		priv->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "phy-ctrl");
 		if (IS_ERR(priv->ctrl_base))
 			return PTR_ERR(priv->ctrl_base);
 	}
diff --git a/drivers/phy/marvell/phy-berlin-usb.c b/drivers/phy/marvell/phy-berlin-usb.c
index a43df63007c5..49de0741cdbf 100644
--- a/drivers/phy/marvell/phy-berlin-usb.c
+++ b/drivers/phy/marvell/phy-berlin-usb.c
@@ -8,9 +8,10 @@
 
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/reset.h>
 
 #define USB_PHY_PLL		0x04
@@ -162,8 +163,6 @@ MODULE_DEVICE_TABLE(of, phy_berlin_usb_of_match);
 
 static int phy_berlin_usb_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match =
-		of_match_device(phy_berlin_usb_of_match, &pdev->dev);
 	struct phy_berlin_usb_priv *priv;
 	struct resource *res;
 	struct phy *phy;
@@ -182,7 +181,7 @@ static int phy_berlin_usb_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->rst_ctrl))
 		return PTR_ERR(priv->rst_ctrl);
 
-	priv->pll_divider = *((u32 *)match->data);
+	priv->pll_divider = *((u32 *)device_get_match_data(&pdev->dev));
 
 	phy = devm_phy_create(&pdev->dev, NULL, &phy_berlin_usb_ops);
 	if (IS_ERR(phy)) {
diff --git a/drivers/phy/ralink/phy-ralink-usb.c b/drivers/phy/ralink/phy-ralink-usb.c
index 95dfa9fd284d..9d227a79139e 100644
--- a/drivers/phy/ralink/phy-ralink-usb.c
+++ b/drivers/phy/ralink/phy-ralink-usb.c
@@ -13,9 +13,10 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -172,18 +173,13 @@ static int ralink_usb_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct phy_provider *phy_provider;
-	const struct of_device_id *match;
 	struct ralink_usb_phy *phy;
 
-	match = of_match_device(ralink_usb_phy_of_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
 	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
 		return -ENOMEM;
 
-	phy->clk = (uintptr_t)match->data;
+	phy->clk = (uintptr_t)device_get_match_data(&pdev->dev);
 	phy->base = NULL;
 
 	phy->sysctl = syscon_regmap_lookup_by_phandle(dev->of_node, "ralink,sysctl");
diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 75216091d901..c6b4c0b5a6be 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -12,10 +12,9 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -63,7 +62,7 @@ struct rockchip_pcie_data {
 };
 
 struct rockchip_pcie_phy {
-	struct rockchip_pcie_data *phy_data;
+	const struct rockchip_pcie_data *phy_data;
 	struct regmap *reg_base;
 	struct phy_pcie_instance {
 		struct phy *phy;
@@ -365,7 +364,6 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
 	struct rockchip_pcie_phy *rk_phy;
 	struct phy_provider *phy_provider;
 	struct regmap *grf;
-	const struct of_device_id *of_id;
 	int i;
 	u32 phy_num;
 
@@ -379,11 +377,10 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
 	if (!rk_phy)
 		return -ENOMEM;
 
-	of_id = of_match_device(rockchip_pcie_phy_dt_ids, &pdev->dev);
-	if (!of_id)
+	rk_phy->phy_data = device_get_match_data(&pdev->dev);
+	if (!rk_phy->phy_data)
 		return -EINVAL;
 
-	rk_phy->phy_data = (struct rockchip_pcie_data *)of_id->data;
 	rk_phy->reg_base = grf;
 
 	mutex_init(&rk_phy->pcie_mutex);
diff --git a/drivers/phy/rockchip/phy-rockchip-usb.c b/drivers/phy/rockchip/phy-rockchip-usb.c
index 8454285977eb..666a896c8f0a 100644
--- a/drivers/phy/rockchip/phy-rockchip-usb.c
+++ b/drivers/phy/rockchip/phy-rockchip-usb.c
@@ -13,10 +13,9 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/regmap.h>
@@ -458,7 +457,6 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rockchip_usb_phy_base *phy_base;
 	struct phy_provider *phy_provider;
-	const struct of_device_id *match;
 	struct device_node *child;
 	int err;
 
@@ -466,14 +464,12 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 	if (!phy_base)
 		return -ENOMEM;
 
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data) {
+	phy_base->pdata = device_get_match_data(dev);
+	if (!phy_base->pdata) {
 		dev_err(dev, "missing phy data\n");
 		return -EINVAL;
 	}
 
-	phy_base->pdata = match->data;
-
 	phy_base->dev = dev;
 	phy_base->reg_base = ERR_PTR(-ENODEV);
 	if (dev->parent && dev->parent->of_node)
diff --git a/drivers/phy/ti/phy-omap-control.c b/drivers/phy/ti/phy-omap-control.c
index ccd0e4e00451..1009afc5f421 100644
--- a/drivers/phy/ti/phy-omap-control.c
+++ b/drivers/phy/ti/phy-omap-control.c
@@ -8,9 +8,9 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/clk.h>
@@ -268,33 +268,24 @@ MODULE_DEVICE_TABLE(of, omap_control_phy_id_table);
 
 static int omap_control_phy_probe(struct platform_device *pdev)
 {
-	struct resource	*res;
-	const struct of_device_id *of_id;
 	struct omap_control_phy *control_phy;
 
-	of_id = of_match_device(omap_control_phy_id_table, &pdev->dev);
-	if (!of_id)
-		return -EINVAL;
-
 	control_phy = devm_kzalloc(&pdev->dev, sizeof(*control_phy),
 		GFP_KERNEL);
 	if (!control_phy)
 		return -ENOMEM;
 
 	control_phy->dev = &pdev->dev;
-	control_phy->type = *(enum omap_control_phy_type *)of_id->data;
+	control_phy->type = *(enum omap_control_phy_type *)device_get_match_data(&pdev->dev);
 
 	if (control_phy->type == OMAP_CTRL_TYPE_OTGHS) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-			"otghs_control");
-		control_phy->otghs_control = devm_ioremap_resource(
-			&pdev->dev, res);
+		control_phy->otghs_control =
+			devm_platform_ioremap_resource_byname(pdev, "otghs_control");
 		if (IS_ERR(control_phy->otghs_control))
 			return PTR_ERR(control_phy->otghs_control);
 	} else {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-				"power");
-		control_phy->power = devm_ioremap_resource(&pdev->dev, res);
+		control_phy->power =
+			devm_platform_ioremap_resource_byname(pdev, "power");
 		if (IS_ERR(control_phy->power)) {
 			dev_err(&pdev->dev, "Couldn't get power register\n");
 			return PTR_ERR(control_phy->power);
@@ -312,9 +303,8 @@ static int omap_control_phy_probe(struct platform_device *pdev)
 	}
 
 	if (control_phy->type == OMAP_CTRL_TYPE_PCIE) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "pcie_pcs");
-		control_phy->pcie_pcs = devm_ioremap_resource(&pdev->dev, res);
+		control_phy->pcie_pcs =
+			devm_platform_ioremap_resource_byname(pdev, "pcie_pcs");
 		if (IS_ERR(control_phy->pcie_pcs))
 			return PTR_ERR(control_phy->pcie_pcs);
 	}
diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index 95e72f7a3199..5a80d77c72b9 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -19,6 +19,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
@@ -362,26 +363,29 @@ static void omap_usb2_init_errata(struct omap_usb *phy)
 		phy->flags |= OMAP_USB2_DISABLE_CHRG_DET;
 }
 
+static void omap_usb2_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int omap_usb2_probe(struct platform_device *pdev)
 {
 	struct omap_usb	*phy;
 	struct phy *generic_phy;
-	struct resource *res;
 	struct phy_provider *phy_provider;
 	struct usb_otg *otg;
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *control_node;
 	struct platform_device *control_pdev;
-	const struct of_device_id *of_id;
-	struct usb_phy_data *phy_data;
-
-	of_id = of_match_device(omap_usb2_id_table, &pdev->dev);
+	const struct usb_phy_data *phy_data;
+	int ret;
 
-	if (!of_id)
+	phy_data = device_get_match_data(&pdev->dev);
+	if (!phy_data)
 		return -EINVAL;
 
-	phy_data = (struct usb_phy_data *)of_id->data;
-
 	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
 		return -ENOMEM;
@@ -403,8 +407,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 
 	omap_usb2_init_errata(phy);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	phy->phy_base = devm_ioremap_resource(&pdev->dev, res);
+	phy->phy_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(phy->phy_base))
 		return PTR_ERR(phy->phy_base);
 
@@ -428,6 +431,11 @@ static int omap_usb2_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 		phy->control_dev = &control_pdev->dev;
+
+		ret = devm_add_action_or_reset(&pdev->dev, omap_usb2_put_device,
+					       phy->control_dev);
+		if (ret)
+			return ret;
 	} else {
 		if (of_property_read_u32_index(node,
 					       "syscon-phy-power", 1,
diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index e9332c90f75f..9f24db315513 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/phy/phy.h>
 #include <linux/of.h>
@@ -666,12 +667,20 @@ static int ti_pipe3_get_clk(struct ti_pipe3 *phy)
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
@@ -702,6 +711,11 @@ static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 		}
 
 		phy->control_dev = &control_pdev->dev;
+
+		ret = devm_add_action_or_reset(dev, ti_pipe3_put_device,
+					       phy->control_dev);
+		if (ret)
+			return ret;
 	}
 
 	if (phy->mode == PIPE3_MODE_PCIE) {
@@ -745,35 +759,28 @@ static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 
 static int ti_pipe3_get_tx_rx_base(struct ti_pipe3 *phy)
 {
-	struct resource *res;
 	struct device *dev = phy->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "phy_rx");
-	phy->phy_rx = devm_ioremap_resource(dev, res);
+	phy->phy_rx = devm_platform_ioremap_resource_byname(pdev, "phy_rx");
 	if (IS_ERR(phy->phy_rx))
 		return PTR_ERR(phy->phy_rx);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "phy_tx");
-	phy->phy_tx = devm_ioremap_resource(dev, res);
+	phy->phy_tx = devm_platform_ioremap_resource_byname(pdev, "phy_tx");
 
 	return PTR_ERR_OR_ZERO(phy->phy_tx);
 }
 
 static int ti_pipe3_get_pll_base(struct ti_pipe3 *phy)
 {
-	struct resource *res;
 	struct device *dev = phy->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 
 	if (phy->mode == PIPE3_MODE_PCIE)
 		return 0;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "pll_ctrl");
-	phy->pll_ctrl_base = devm_ioremap_resource(dev, res);
+	phy->pll_ctrl_base =
+		devm_platform_ioremap_resource_byname(pdev, "pll_ctrl");
 	return PTR_ERR_OR_ZERO(phy->pll_ctrl_base);
 }
 
@@ -784,23 +791,16 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
 	int ret;
-	const struct of_device_id *match;
-	struct pipe3_data *data;
+	const struct pipe3_data *data;
 
 	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
 		return -ENOMEM;
 
-	match = of_match_device(ti_pipe3_id_table, dev);
-	if (!match)
+	data = device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
-	data = (struct pipe3_data *)match->data;
-	if (!data) {
-		dev_err(dev, "no driver data\n");
-		return -EINVAL;
-	}
-
 	phy->dev = dev;
 	phy->mode = data->mode;
 	phy->dpll_map = data->dpll_map;
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index b8131f823654..1bd48e4e26d4 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1828,8 +1828,8 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
 
 	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
-	if ((cache.flags & 0xff) == 0xff)
-		cache.flags = -1; /* read error */
+	if (di->chip == BQ27000 && (cache.flags & 0xff) == 0xff)
+		cache.flags = -ENODEV; /* bq27000 hdq read error */
 	if (cache.flags >= 0) {
 		cache.temperature = bq27xxx_battery_read_temperature(di);
 		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
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
index 4ea52426acf9..758537381d77 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1018,7 +1018,6 @@ static int sc16is7xx_config_rs485(struct uart_port *port,
 static int sc16is7xx_startup(struct uart_port *port)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	unsigned int val;
 
 	sc16is7xx_power(port, 1);
@@ -1030,16 +1029,6 @@ static int sc16is7xx_startup(struct uart_port *port)
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
@@ -1051,7 +1040,8 @@ static int sc16is7xx_startup(struct uart_port *port)
 			     SC16IS7XX_TCR_RX_RESUME(24) |
 			     SC16IS7XX_TCR_RX_HALT(48));
 
-	regcache_cache_bypass(s->regmap, false);
+	/* Disable TCR/TLR access */
+	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG, SC16IS7XX_MCR_TCRTLR_BIT, 0);
 
 	/* Now, initialize the UART */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, SC16IS7XX_LCR_WORD_LEN_8);
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index f5894cb16686..55efefc5d702 100644
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
index 92d01ddaee0d..0852d231959a 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -749,7 +749,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	struct dummy		*dum;
 	int			retval = -EINVAL;
 	unsigned long		flags;
-	struct dummy_request	*req = NULL;
+	struct dummy_request	*req = NULL, *iter;
 
 	if (!_ep || !_req)
 		return retval;
@@ -759,25 +759,26 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
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
 
diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 03f047f5508b..64fdaf468eda 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -86,13 +86,34 @@ static u32 xhci_dbc_populate_strings(struct dbc_str_descs *strings)
 	return string_length;
 }
 
+static void xhci_dbc_init_ep_contexts(struct xhci_dbc *dbc)
+{
+	struct xhci_ep_ctx      *ep_ctx;
+	unsigned int		max_burst;
+	dma_addr_t		deq;
+
+	max_burst               = DBC_CTRL_MAXBURST(readl(&dbc->regs->control));
+
+	/* Populate bulk out endpoint context: */
+	ep_ctx                  = dbc_bulkout_ctx(dbc);
+	deq                     = dbc_bulkout_enq(dbc);
+	ep_ctx->ep_info         = 0;
+	ep_ctx->ep_info2        = dbc_epctx_info2(BULK_OUT_EP, 1024, max_burst);
+	ep_ctx->deq             = cpu_to_le64(deq | dbc->ring_out->cycle_state);
+
+	/* Populate bulk in endpoint context: */
+	ep_ctx                  = dbc_bulkin_ctx(dbc);
+	deq                     = dbc_bulkin_enq(dbc);
+	ep_ctx->ep_info         = 0;
+	ep_ctx->ep_info2        = dbc_epctx_info2(BULK_IN_EP, 1024, max_burst);
+	ep_ctx->deq             = cpu_to_le64(deq | dbc->ring_in->cycle_state);
+}
+
 static void xhci_dbc_init_contexts(struct xhci_dbc *dbc, u32 string_length)
 {
 	struct dbc_info_context	*info;
-	struct xhci_ep_ctx	*ep_ctx;
 	u32			dev_info;
-	dma_addr_t		deq, dma;
-	unsigned int		max_burst;
+	dma_addr_t		dma;
 
 	if (!dbc)
 		return;
@@ -106,20 +127,8 @@ static void xhci_dbc_init_contexts(struct xhci_dbc *dbc, u32 string_length)
 	info->serial		= cpu_to_le64(dma + DBC_MAX_STRING_LENGTH * 3);
 	info->length		= cpu_to_le32(string_length);
 
-	/* Populate bulk out endpoint context: */
-	ep_ctx			= dbc_bulkout_ctx(dbc);
-	max_burst		= DBC_CTRL_MAXBURST(readl(&dbc->regs->control));
-	deq			= dbc_bulkout_enq(dbc);
-	ep_ctx->ep_info		= 0;
-	ep_ctx->ep_info2	= dbc_epctx_info2(BULK_OUT_EP, 1024, max_burst);
-	ep_ctx->deq		= cpu_to_le64(deq | dbc->ring_out->cycle_state);
-
-	/* Populate bulk in endpoint context: */
-	ep_ctx			= dbc_bulkin_ctx(dbc);
-	deq			= dbc_bulkin_enq(dbc);
-	ep_ctx->ep_info		= 0;
-	ep_ctx->ep_info2	= dbc_epctx_info2(BULK_IN_EP, 1024, max_burst);
-	ep_ctx->deq		= cpu_to_le64(deq | dbc->ring_in->cycle_state);
+	/* Populate bulk in and out endpoint contexts: */
+	xhci_dbc_init_ep_contexts(dbc);
 
 	/* Set DbC context and info registers: */
 	lo_hi_writeq(dbc->ctx->dma, &dbc->regs->dccp);
@@ -421,6 +430,42 @@ dbc_alloc_ctx(struct device *dev, gfp_t flags)
 	return ctx;
 }
 
+static void xhci_dbc_ring_init(struct xhci_ring *ring)
+{
+	struct xhci_segment *seg = ring->first_seg;
+
+	/* clear all trbs on ring in case of old ring */
+	memset(seg->trbs, 0, TRB_SEGMENT_SIZE);
+
+	/* Only event ring does not use link TRB */
+	if (ring->type != TYPE_EVENT) {
+		union xhci_trb *trb = &seg->trbs[TRBS_PER_SEGMENT - 1];
+
+		trb->link.segment_ptr = cpu_to_le64(ring->first_seg->dma);
+		trb->link.control = cpu_to_le32(LINK_TOGGLE | TRB_TYPE(TRB_LINK));
+	}
+	xhci_initialize_ring_info(ring, 1);
+}
+
+static int xhci_dbc_reinit_ep_rings(struct xhci_dbc *dbc)
+{
+	struct xhci_ring *in_ring = dbc->eps[BULK_IN].ring;
+	struct xhci_ring *out_ring = dbc->eps[BULK_OUT].ring;
+
+	if (!in_ring || !out_ring || !dbc->ctx) {
+		dev_warn(dbc->dev, "Can't re-init unallocated endpoints\n");
+		return -ENODEV;
+	}
+
+	xhci_dbc_ring_init(in_ring);
+	xhci_dbc_ring_init(out_ring);
+
+	/* set ep context enqueue, dequeue, and cycle to initial values */
+	xhci_dbc_init_ep_contexts(dbc);
+
+	return 0;
+}
+
 static struct xhci_ring *
 xhci_dbc_ring_alloc(struct device *dev, enum xhci_ring_type type, gfp_t flags)
 {
@@ -449,15 +494,10 @@ xhci_dbc_ring_alloc(struct device *dev, enum xhci_ring_type type, gfp_t flags)
 
 	seg->dma = dma;
 
-	/* Only event ring does not use link TRB */
-	if (type != TYPE_EVENT) {
-		union xhci_trb *trb = &seg->trbs[TRBS_PER_SEGMENT - 1];
-
-		trb->link.segment_ptr = cpu_to_le64(dma);
-		trb->link.control = cpu_to_le32(LINK_TOGGLE | TRB_TYPE(TRB_LINK));
-	}
 	INIT_LIST_HEAD(&ring->td_list);
-	xhci_initialize_ring_info(ring, 1);
+
+	xhci_dbc_ring_init(ring);
+
 	return ring;
 dma_fail:
 	kfree(seg);
@@ -850,7 +890,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			dev_info(dbc->dev, "DbC cable unplugged\n");
 			dbc->state = DS_ENABLED;
 			xhci_dbc_flush_requests(dbc);
-
+			xhci_dbc_reinit_ep_rings(dbc);
 			return EVT_DISC;
 		}
 
@@ -860,7 +900,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			writel(portsc, &dbc->regs->portsc);
 			dbc->state = DS_ENABLED;
 			xhci_dbc_flush_requests(dbc);
-
+			xhci_dbc_reinit_ep_rings(dbc);
 			return EVT_DISC;
 		}
 
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index f1a99519bbd5..2cd04ceeb2b6 100644
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
index 080b615a5581..3dd03e02bf97 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2500,7 +2500,7 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
 	unsigned charcount = font->charcount;
 	int w = font->width;
 	int h = font->height;
-	int size;
+	int size, alloc_size;
 	int i, csum;
 	u8 *new_data, *data = font->data;
 	int pitch = PITCH(font->width);
@@ -2527,9 +2527,16 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
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
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 35b94fe5e78e..c28bb37688c6 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1545,10 +1545,10 @@ static int check_inode_ref(struct extent_buffer *leaf,
 	while (ptr < end) {
 		u16 namelen;
 
-		if (ptr + sizeof(iref) > end) {
+		if (unlikely(ptr + sizeof(*iref) > end)) {
 			inode_ref_err(leaf, slot,
 			"inode ref overflow, ptr %lu end %lu inode_ref_size %zu",
-				ptr, end, sizeof(iref));
+				ptr, end, sizeof(*iref));
 			return -EUCLEAN;
 		}
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index fd7263ed25b9..c0acdb0a2986 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3384,7 +3384,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		.nodeid_out = ff_out->nodeid,
 		.fh_out = ff_out->fh,
 		.off_out = pos_out,
-		.len = len,
+		.len = min_t(size_t, len, UINT_MAX & PAGE_MASK),
 		.flags = flags
 	};
 	struct fuse_write_out outarg;
@@ -3450,6 +3450,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		fc->no_copy_file_range = 1;
 		err = -EOPNOTSUPP;
 	}
+	if (!err && outarg.size > len)
+		err = -EIO;
+
 	if (err)
 		goto out;
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 6e97a54ffda1..306da7cb3d8b 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -515,13 +515,13 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
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
 
@@ -533,8 +533,6 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 					(index + 1) * pages_per_huge_page(h));
 				i_mmap_unlock_write(mapping);
 			}
-
-			lock_page(page);
 			/*
 			 * We must free the huge page and remove from page
 			 * cache (remove_huge_page) BEFORE removing the
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index ac2fbbba1521..6134101184fa 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -850,6 +850,8 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 
 	if (fsinfo->xattr_support)
 		server->caps |= NFS_CAP_XATTR;
+	else
+		server->caps &= ~NFS_CAP_XATTR;
 #endif
 }
 
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 57150b27c0fd..ee103cde19cd 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -270,7 +270,7 @@ ff_lseg_match_mirrors(struct pnfs_layout_segment *l1,
 		struct pnfs_layout_segment *l2)
 {
 	const struct nfs4_ff_layout_segment *fl1 = FF_LAYOUT_LSEG(l1);
-	const struct nfs4_ff_layout_segment *fl2 = FF_LAYOUT_LSEG(l1);
+	const struct nfs4_ff_layout_segment *fl2 = FF_LAYOUT_LSEG(l2);
 	u32 i;
 
 	if (fl1->mirror_array_cnt != fl2->mirror_array_cnt)
@@ -750,8 +750,11 @@ ff_layout_choose_ds_for_read(struct pnfs_layout_segment *lseg,
 			continue;
 
 		if (check_device &&
-		    nfs4_test_deviceid_unavailable(&mirror->mirror_ds->id_node))
+		    nfs4_test_deviceid_unavailable(&mirror->mirror_ds->id_node)) {
+			// reinitialize the error state in case if this is the last iteration
+			ds = ERR_PTR(-EINVAL);
 			continue;
+		}
 
 		*best_idx = idx;
 		break;
@@ -781,7 +784,7 @@ ff_layout_choose_best_ds_for_read(struct pnfs_layout_segment *lseg,
 	struct nfs4_pnfs_ds *ds;
 
 	ds = ff_layout_choose_valid_ds_for_read(lseg, start_idx, best_idx);
-	if (ds)
+	if (!IS_ERR(ds))
 		return ds;
 	return ff_layout_choose_any_ds_for_read(lseg, start_idx, best_idx);
 }
@@ -795,7 +798,7 @@ ff_layout_get_ds_for_read(struct nfs_pageio_descriptor *pgio,
 
 	ds = ff_layout_choose_best_ds_for_read(lseg, pgio->pg_mirror_idx,
 					       best_idx);
-	if (ds || !pgio->pg_mirror_idx)
+	if (!IS_ERR(ds) || !pgio->pg_mirror_idx)
 		return ds;
 	return ff_layout_choose_best_ds_for_read(lseg, 0, best_idx);
 }
@@ -856,7 +859,7 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	req->wb_nio = 0;
 
 	ds = ff_layout_get_ds_for_read(pgio, &ds_idx);
-	if (!ds) {
+	if (IS_ERR(ds)) {
 		if (!ff_layout_no_fallback_to_mds(pgio->pg_lseg))
 			goto out_mds;
 		pnfs_generic_pg_cleanup(pgio);
@@ -1066,11 +1069,13 @@ static void ff_layout_resend_pnfs_read(struct nfs_pgio_header *hdr)
 {
 	u32 idx = hdr->pgio_mirror_idx + 1;
 	u32 new_idx = 0;
+	struct nfs4_pnfs_ds *ds;
 
-	if (ff_layout_choose_any_ds_for_read(hdr->lseg, idx, &new_idx))
-		ff_layout_send_layouterror(hdr->lseg);
-	else
+	ds = ff_layout_choose_any_ds_for_read(hdr->lseg, idx, &new_idx);
+	if (IS_ERR(ds))
 		pnfs_error_mark_layout_for_return(hdr->inode, hdr->lseg);
+	else
+		ff_layout_send_layouterror(hdr->lseg);
 	pnfs_read_resend_pnfs(hdr, new_idx);
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 973b708ff332..c094413c1754 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3935,7 +3935,6 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
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
index 7b93e9c766f6..888c485b5646 100644
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
@@ -794,9 +800,11 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
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
 
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index a406e281ae57..9af84cad92e9 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -136,6 +136,7 @@ struct af_alg_async_req {
  *			SG?
  * @enc:		Cryptographic operation to be performed when
  *			recvmsg is invoked.
+ * @write:		True if we are in the middle of a write.
  * @init:		True if metadata has been sent.
  * @len:		Length of memory allocated for this data structure.
  * @inflight:		Non-zero when AIO requests are in flight.
@@ -151,10 +152,11 @@ struct af_alg_ctx {
 	size_t used;
 	atomic_t rcvused;
 
-	bool more;
-	bool merge;
-	bool enc;
-	bool init;
+	bool		more:1,
+			merge:1,
+			enc:1,
+			write:1,
+			init:1;
 
 	unsigned int len;
 
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 9ba951e3a6c2..777fded63f4e 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -24,23 +24,42 @@
 #define KASAN_ABI_VERSION 5
 
 /*
+ * Clang 22 added preprocessor macros to match GCC, in hopes of eventually
+ * dropping __has_feature support for sanitizers:
+ * https://github.com/llvm/llvm-project/commit/568c23bbd3303518c5056d7f03444dae4fdc8a9c
+ * Create these macros for older versions of clang so that it is easy to clean
+ * up once the minimum supported version of LLVM for building the kernel always
+ * creates these macros.
+ *
  * Note: Checking __has_feature(*_sanitizer) is only true if the feature is
  * enabled. Therefore it is not required to additionally check defined(CONFIG_*)
  * to avoid adding redundant attributes in other configurations.
  */
+#if __has_feature(address_sanitizer) && !defined(__SANITIZE_ADDRESS__)
+#define __SANITIZE_ADDRESS__
+#endif
+#if __has_feature(hwaddress_sanitizer) && !defined(__SANITIZE_HWADDRESS__)
+#define __SANITIZE_HWADDRESS__
+#endif
+#if __has_feature(thread_sanitizer) && !defined(__SANITIZE_THREAD__)
+#define __SANITIZE_THREAD__
+#endif
 
-#if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
-/* Emulate GCC's __SANITIZE_ADDRESS__ flag */
+/*
+ * Treat __SANITIZE_HWADDRESS__ the same as __SANITIZE_ADDRESS__ in the kernel.
+ */
+#ifdef __SANITIZE_HWADDRESS__
 #define __SANITIZE_ADDRESS__
+#endif
+
+#ifdef __SANITIZE_ADDRESS__
 #define __no_sanitize_address \
 		__attribute__((no_sanitize("address", "hwaddress")))
 #else
 #define __no_sanitize_address
 #endif
 
-#if __has_feature(thread_sanitizer)
-/* emulate gcc's __SANITIZE_THREAD__ flag */
-#define __SANITIZE_THREAD__
+#ifdef __SANITIZE_THREAD__
 #define __no_sanitize_thread \
 		__attribute__((no_sanitize("thread")))
 #else
@@ -72,19 +91,6 @@
 #define __no_sanitize_coverage
 #endif
 
-/*
- * Not all versions of clang implement the type-generic versions
- * of the builtin overflow checkers. Fortunately, clang implements
- * __has_builtin allowing us to avoid awkward version
- * checks. Unfortunately, we don't know which version of gcc clang
- * pretends to be, so the macro may or may not be defined.
- */
-#if __has_builtin(__builtin_mul_overflow) && \
-    __has_builtin(__builtin_add_overflow) && \
-    __has_builtin(__builtin_sub_overflow)
-#define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
-#endif
-
 #if __has_feature(shadow_call_stack)
 # define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 5b481a22b5fe..ae9a8e17287c 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -140,10 +140,6 @@
 #define __no_sanitize_coverage
 #endif
 
-#if GCC_VERSION >= 50100
-#define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
-#endif
-
 /*
  * Turn individual warnings and errors on and off locally, depending
  * on version.
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 71d3fa7f0265..4994465ad1d9 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -318,44 +318,54 @@ struct irq_affinity_desc {
 
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
@@ -385,12 +395,30 @@ static inline int irq_can_set_affinity(unsigned int irq)
 
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
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 35af574d006f..73bc67ec2136 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -6,12 +6,9 @@
 #include <linux/limits.h>
 
 /*
- * In the fallback code below, we need to compute the minimum and
- * maximum values representable in a given type. These macros may also
- * be useful elsewhere, so we provide them outside the
- * COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW block.
- *
- * It would seem more obvious to do something like
+ * We need to compute the minimum and maximum values representable in a given
+ * type. These macros may also be useful elsewhere. It would seem more obvious
+ * to do something like:
  *
  * #define type_min(T) (T)(is_signed_type(T) ? (T)1 << (8*sizeof(T)-1) : 0)
  * #define type_max(T) (T)(is_signed_type(T) ? ((T)1 << (8*sizeof(T)-1)) - 1 : ~(T)0)
@@ -54,169 +51,50 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	return unlikely(overflow);
 }
 
-#ifdef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
-/*
- * For simplicity and code hygiene, the fallback code below insists on
- * a, b and *d having the same type (similar to the min() and max()
- * macros), whereas gcc's type-generic overflow checkers accept
- * different types. Hence we don't just make check_add_overflow an
- * alias for __builtin_add_overflow, but add type checks similar to
- * below.
- */
-#define check_add_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_add_overflow(__a, __b, __d);	\
-}))
-
-#define check_sub_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_sub_overflow(__a, __b, __d);	\
-}))
-
-#define check_mul_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_mul_overflow(__a, __b, __d);	\
-}))
-
-#else
-
-
-/* Checking for unsigned overflow is relatively easy without causing UB. */
-#define __unsigned_add_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = __a + __b;			\
-	*__d < __a;				\
-})
-#define __unsigned_sub_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = __a - __b;			\
-	__a < __b;				\
-})
-/*
- * If one of a or b is a compile-time constant, this avoids a division.
- */
-#define __unsigned_mul_overflow(a, b, d) ({		\
-	typeof(a) __a = (a);				\
-	typeof(b) __b = (b);				\
-	typeof(d) __d = (d);				\
-	(void) (&__a == &__b);				\
-	(void) (&__a == __d);				\
-	*__d = __a * __b;				\
-	__builtin_constant_p(__b) ?			\
-	  __b > 0 && __a > type_max(typeof(__a)) / __b : \
-	  __a > 0 && __b > type_max(typeof(__b)) / __a;	 \
-})
-
-/*
- * For signed types, detecting overflow is much harder, especially if
- * we want to avoid UB. But the interface of these macros is such that
- * we must provide a result in *d, and in fact we must produce the
- * result promised by gcc's builtins, which is simply the possibly
- * wrapped-around value. Fortunately, we can just formally do the
- * operations in the widest relevant unsigned type (u64) and then
- * truncate the result - gcc is smart enough to generate the same code
- * with and without the (u64) casts.
- */
-
-/*
- * Adding two signed integers can overflow only if they have the same
- * sign, and overflow has happened iff the result has the opposite
- * sign.
+/** check_add_overflow() - Calculate addition with overflow checking
+ *
+ * @a: first addend
+ * @b: second addend
+ * @d: pointer to store sum
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted addition, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * sum has overflowed or been truncated.
  */
-#define __signed_add_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = (u64)__a + (u64)__b;		\
-	(((~(__a ^ __b)) & (*__d ^ __a))	\
-		& type_min(typeof(__a))) != 0;	\
-})
+#define check_add_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_add_overflow(a, b, d))
 
-/*
- * Subtraction is similar, except that overflow can now happen only
- * when the signs are opposite. In this case, overflow has happened if
- * the result has the opposite sign of a.
+/** check_sub_overflow() - Calculate subtraction with overflow checking
+ *
+ * @a: minuend; value to subtract from
+ * @b: subtrahend; value to subtract from @a
+ * @d: pointer to store difference
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted subtraction, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * difference has underflowed or been truncated.
  */
-#define __signed_sub_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = (u64)__a - (u64)__b;		\
-	((((__a ^ __b)) & (*__d ^ __a))		\
-		& type_min(typeof(__a))) != 0;	\
-})
+#define check_sub_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_sub_overflow(a, b, d))
 
-/*
- * Signed multiplication is rather hard. gcc always follows C99, so
- * division is truncated towards 0. This means that we can write the
- * overflow check like this:
- *
- * (a > 0 && (b > MAX/a || b < MIN/a)) ||
- * (a < -1 && (b > MIN/a || b < MAX/a) ||
- * (a == -1 && b == MIN)
- *
- * The redundant casts of -1 are to silence an annoying -Wtype-limits
- * (included in -Wextra) warning: When the type is u8 or u16, the
- * __b_c_e in check_mul_overflow obviously selects
- * __unsigned_mul_overflow, but unfortunately gcc still parses this
- * code and warns about the limited range of __b.
+/** check_mul_overflow() - Calculate multiplication with overflow checking
+ *
+ * @a: first factor
+ * @b: second factor
+ * @d: pointer to store product
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted multiplication, but is not
+ * considered "safe for use" on a non-zero return value, which indicates
+ * that the product has overflowed or been truncated.
  */
-
-#define __signed_mul_overflow(a, b, d) ({				\
-	typeof(a) __a = (a);						\
-	typeof(b) __b = (b);						\
-	typeof(d) __d = (d);						\
-	typeof(a) __tmax = type_max(typeof(a));				\
-	typeof(a) __tmin = type_min(typeof(a));				\
-	(void) (&__a == &__b);						\
-	(void) (&__a == __d);						\
-	*__d = (u64)__a * (u64)__b;					\
-	(__b > 0   && (__a > __tmax/__b || __a < __tmin/__b)) ||	\
-	(__b < (typeof(__b))-1  && (__a > __tmin/__b || __a < __tmax/__b)) || \
-	(__b == (typeof(__b))-1 && __a == __tmin);			\
-})
-
-
-#define check_add_overflow(a, b, d)	__must_check_overflow(		\
-	__builtin_choose_expr(is_signed_type(typeof(a)),		\
-			__signed_add_overflow(a, b, d),			\
-			__unsigned_add_overflow(a, b, d)))
-
-#define check_sub_overflow(a, b, d)	__must_check_overflow(		\
-	__builtin_choose_expr(is_signed_type(typeof(a)),		\
-			__signed_sub_overflow(a, b, d),			\
-			__unsigned_sub_overflow(a, b, d)))
-
-#define check_mul_overflow(a, b, d)	__must_check_overflow(		\
-	__builtin_choose_expr(is_signed_type(typeof(a)),		\
-			__signed_mul_overflow(a, b, d),			\
-			__unsigned_mul_overflow(a, b, d)))
-
-#endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
+#define check_mul_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_mul_overflow(a, b, d))
 
 /** check_shl_overflow() - Calculate a left-shifted value and check overflow
  *
@@ -235,7 +113,7 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * - 'a << s' sets the sign bit, if any, in '*d'.
  *
  * '*d' will hold the results of the attempted shift, but is not
- * considered "safe for use" if false is returned.
+ * considered "safe for use" if true is returned.
  */
 #define check_shl_overflow(a, s, d) __must_check_overflow(({		\
 	typeof(a) _a = a;						\
diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index fd87d727aa21..aa19809bfd73 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -105,7 +105,8 @@ struct nexthop {
 };
 
 enum nexthop_event_type {
-	NEXTHOP_EVENT_DEL
+	NEXTHOP_EVENT_DEL,
+	NEXTHOP_EVENT_REPLACE,
 };
 
 int register_nexthop_notifier(struct net *net, struct notifier_block *nb);
diff --git a/include/net/sock.h b/include/net/sock.h
index bc9a1e535d58..bfba1c312a55 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -341,6 +341,8 @@ struct bpf_local_storage;
   *	@sk_txtime_deadline_mode: set deadline mode for SO_TXTIME
   *	@sk_txtime_report_errors: set report errors mode for SO_TXTIME
   *	@sk_txtime_unused: unused txtime flags
+  *	@sk_owner: reference to the real owner of the socket that calls
+  *		   sock_lock_init_class_and_name().
   */
 struct sock {
 	/*
@@ -521,6 +523,10 @@ struct sock {
 	struct bpf_local_storage __rcu	*sk_bpf_storage;
 #endif
 	struct rcu_head		sk_rcu;
+
+#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
+	struct module		*sk_owner;
+#endif
 };
 
 enum sk_pacing {
@@ -1607,6 +1613,35 @@ static inline void sock_release_ownership(struct sock *sk)
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
@@ -1616,13 +1651,14 @@ static inline void sock_release_ownership(struct sock *sk)
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
 
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 31be7345e0c2..5fb40c0c57ff 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -396,11 +396,13 @@ struct rtnexthop {
 #define RTNH_F_DEAD		1	/* Nexthop is dead (used by multipath)	*/
 #define RTNH_F_PERVASIVE	2	/* Do recursive gateway lookup	*/
 #define RTNH_F_ONLINK		4	/* Gateway is forced on link	*/
-#define RTNH_F_OFFLOAD		8	/* offloaded route */
+#define RTNH_F_OFFLOAD		8	/* Nexthop is offloaded */
 #define RTNH_F_LINKDOWN		16	/* carrier-down on nexthop */
 #define RTNH_F_UNRESOLVED	32	/* The entry is unresolved (ipmr) */
+#define RTNH_F_TRAP		64	/* Nexthop is trapping packets */
 
-#define RTNH_COMPARE_MASK	(RTNH_F_DEAD | RTNH_F_LINKDOWN | RTNH_F_OFFLOAD)
+#define RTNH_COMPARE_MASK	(RTNH_F_DEAD | RTNH_F_LINKDOWN | \
+				 RTNH_F_OFFLOAD | RTNH_F_TRAP)
 
 /* Macros to handle hexthops */
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 37d7a99be8f0..d709375d7509 100644
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
@@ -5165,7 +5188,7 @@ static void css_release_work_fn(struct work_struct *work)
 	mutex_unlock(&cgroup_mutex);
 
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
-	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
+	queue_rcu_work(cgroup_free_wq, &css->destroy_rwork);
 }
 
 static void css_release(struct percpu_ref *ref)
@@ -5174,7 +5197,7 @@ static void css_release(struct percpu_ref *ref)
 		container_of(ref, struct cgroup_subsys_state, refcnt);
 
 	INIT_WORK(&css->destroy_work, css_release_work_fn);
-	queue_work(cgroup_destroy_wq, &css->destroy_work);
+	queue_work(cgroup_release_wq, &css->destroy_work);
 }
 
 static void init_and_link_css(struct cgroup_subsys_state *css,
@@ -5305,7 +5328,7 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 err_free_css:
 	list_del_rcu(&css->rstat_css_node);
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
-	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
+	queue_rcu_work(cgroup_free_wq, &css->destroy_rwork);
 	return ERR_PTR(err);
 }
 
@@ -5545,7 +5568,7 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
 
 	if (atomic_dec_and_test(&css->online_cnt)) {
 		INIT_WORK(&css->destroy_work, css_killed_work_fn);
-		queue_work(cgroup_destroy_wq, &css->destroy_work);
+		queue_work(cgroup_offline_wq, &css->destroy_work);
 	}
 }
 
@@ -5922,8 +5945,14 @@ static int __init cgroup_wq_init(void)
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
index c7f4f948f17e..4998e8a56156 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -386,7 +386,78 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
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
@@ -401,7 +472,38 @@ int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
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
@@ -410,12 +512,11 @@ int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
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
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d08320c47a15..8f4d6c974372 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6891,7 +6891,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	entry = ring_buffer_event_data(event);
 	entry->ip = _THIS_IP_;
 
-	len = __copy_from_user_inatomic(&entry->buf, ubuf, cnt);
+	len = copy_from_user_nofault(&entry->buf, ubuf, cnt);
 	if (len) {
 		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
 		cnt = FAULTED_SIZE;
@@ -6971,7 +6971,7 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 
 	entry = ring_buffer_event_data(event);
 
-	len = __copy_from_user_inatomic(&entry->id, ubuf, cnt);
+	len = copy_from_user_nofault(&entry->id, ubuf, cnt);
 	if (len) {
 		entry->id = -1;
 		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index d312a52a10a5..8185f57b2e12 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -176,6 +176,10 @@ static int dyn_event_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	ret = tracing_check_open_get_tr(NULL);
 	if (ret)
 		return ret;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 511499e8e29a..e523bb938118 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1363,7 +1363,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		}
 		if (pte_young(pteval) ||
 		    page_is_young(page) || PageReferenced(page) ||
-		    mmu_notifier_test_young(vma->vm_mm, address))
+		    mmu_notifier_test_young(vma->vm_mm, _address))
 			referenced++;
 	}
 	if (!writable) {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index dba2936292cf..edb43e9fceb2 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1616,10 +1616,9 @@ int unpoison_memory(unsigned long pfn)
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
index c0a8f3c9e256..aafad2112ec8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -3105,20 +3105,16 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 			newpage = page;
 		}
 
+		if (!is_zone_device_page(newpage))
+			lru_cache_add(newpage);
 		remove_migration_ptes(page, newpage, false);
 		unlock_page(page);
 
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
index 45ae7a235dbf..34cd4792d5d4 100644
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
index 3c8b263d2cf2..3108c999ccdb 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1652,6 +1652,8 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
  */
 static inline void sock_lock_init(struct sock *sk)
 {
+	sk_owner_clear(sk);
+
 	if (sk->sk_kern_sock)
 		sock_lock_init_class_and_name(
 			sk,
@@ -1738,6 +1740,9 @@ static void sk_prot_free(struct proto *prot, struct sock *sk)
 	cgroup_sk_free(&sk->sk_cgrp_data);
 	mem_cgroup_sk_free(sk);
 	security_sk_free(sk);
+
+	sk_owner_put(sk);
+
 	if (slab != NULL)
 		kmem_cache_free(slab, sk);
 	else
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index a308d3f0f845..48516a403a9b 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1705,6 +1705,8 @@ int fib_nexthop_info(struct sk_buff *skb, const struct fib_nh_common *nhc,
 	*flags |= (nhc->nhc_flags & RTNH_F_ONLINK);
 	if (nhc->nhc_flags & RTNH_F_OFFLOAD)
 		*flags |= RTNH_F_OFFLOAD;
+	if (nhc->nhc_flags & RTNH_F_TRAP)
+		*flags |= RTNH_F_TRAP;
 
 	if (!skip_oif && nhc->nhc_dev &&
 	    nla_put_u32(skb, RTA_OIF, nhc->nhc_dev->ifindex))
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 01d362b5b882..3cdb546dbc8d 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -203,6 +203,9 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 	if (!pskb_may_pull(skb, ETH_HLEN + sizeof(struct iphdr)))
 		return -EINVAL;
 
+	if (skb_is_gso(skb))
+		skb_gso_reset(skb);
+
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
 	skb_reset_network_header(skb);
@@ -297,6 +300,9 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 	if (!pskb_may_pull(skb, ETH_HLEN + sizeof(struct ipv6hdr)))
 		return -EINVAL;
 
+	if (skb_is_gso(skb))
+		skb_gso_reset(skb);
+
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
 	skb_reset_network_header(skb);
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index a508fd94b8be..477d6a6f0de3 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -38,7 +38,8 @@ static const struct nla_policy rtm_nh_policy[NHA_MAX + 1] = {
 
 static int call_nexthop_notifiers(struct net *net,
 				  enum nexthop_event_type event_type,
-				  struct nexthop *nh)
+				  struct nexthop *nh,
+				  struct netlink_ext_ack *extack)
 {
 	int err;
 
@@ -908,7 +909,7 @@ static void __remove_nexthop(struct net *net, struct nexthop *nh,
 static void remove_nexthop(struct net *net, struct nexthop *nh,
 			   struct nl_info *nlinfo)
 {
-	call_nexthop_notifiers(net, NEXTHOP_EVENT_DEL, nh);
+	call_nexthop_notifiers(net, NEXTHOP_EVENT_DEL, nh, NULL);
 
 	/* remove from the tree */
 	rb_erase(&nh->rb_node, &net->nexthop.rb_root);
@@ -1008,12 +1009,29 @@ static int replace_nexthop_single(struct net *net, struct nexthop *old,
 				  struct netlink_ext_ack *extack)
 {
 	struct nh_info *oldi, *newi;
+	int err;
 
 	if (new->is_group) {
 		NL_SET_ERR_MSG(extack, "Can not replace a nexthop with a nexthop group.");
 		return -EINVAL;
 	}
 
+	if (!list_empty(&old->grp_list) &&
+	    rtnl_dereference(new->nh_info)->fdb_nh !=
+	    rtnl_dereference(old->nh_info)->fdb_nh) {
+		NL_SET_ERR_MSG(extack, "Cannot change nexthop FDB status while in a group");
+		return -EINVAL;
+	}
+
+	err = call_nexthop_notifiers(net, NEXTHOP_EVENT_REPLACE, new, extack);
+	if (err)
+		return err;
+
+	/* Hardware flags were set on 'old' as 'new' is not in the red-black
+	 * tree. Therefore, inherit the flags from 'old' to 'new'.
+	 */
+	new->nh_flags |= old->nh_flags & (RTNH_F_OFFLOAD | RTNH_F_TRAP);
+
 	oldi = rtnl_dereference(old->nh_info);
 	newi = rtnl_dereference(new->nh_info);
 
@@ -1190,7 +1208,11 @@ static int insert_nexthop(struct net *net, struct nexthop *new_nh,
 
 	rb_link_node_rcu(&new_nh->rb_node, parent, pp);
 	rb_insert_color(&new_nh->rb_node, root);
-	rc = 0;
+
+	rc = call_nexthop_notifiers(net, NEXTHOP_EVENT_REPLACE, new_nh, extack);
+	if (rc)
+		rb_erase(&new_nh->rb_node, &net->nexthop.rb_root);
+
 out:
 	if (!rc) {
 		nh_base_seq_inc(net);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 2d870d5e31cf..afc31f1def76 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2770,6 +2770,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	int old_state = sk->sk_state;
+	struct request_sock *req;
 	u32 seq;
 
 	/* Deny disconnect if other threads are blocked in sk_wait_event()
@@ -2890,6 +2891,10 @@ int tcp_disconnect(struct sock *sk, int flags)
 
 
 	/* Clean up fastopen related fields */
+	req = rcu_dereference_protected(tp->fastopen_rsk,
+					lockdep_sock_is_held(sk));
+	if (req)
+		reqsk_fastopen_remove(sk, req, false);
 	tcp_free_fastopen_req(tp);
 	inet->defer_connect = 0;
 	tp->fastopen_client_fail = 0;
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index f97e357e2644..bcd5fc484f77 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -341,8 +341,11 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
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
index a172f69c7112..d860c905fa73 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1236,7 +1236,7 @@ drv_get_ftm_responder_stats(struct ieee80211_local *local,
 			    struct ieee80211_sub_if_data *sdata,
 			    struct cfg80211_ftm_responder_stats *ftm_stats)
 {
-	u32 ret = -EOPNOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	if (local->ops->get_ftm_responder_stats)
 		ret = local->ops->get_ftm_responder_stats(&local->hw,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 32379fc706ca..c31a1dc69f83 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -869,7 +869,6 @@ static void __flush_addrs(struct pm_nl_pernet *pernet)
 static void __reset_counters(struct pm_nl_pernet *pernet)
 {
 	pernet->add_addr_signal_max = 0;
-	pernet->add_addr_accept_max = 0;
 	pernet->local_addr_max = 0;
 	pernet->addrs = 0;
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f33c3150e690..1342c31df0c4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -326,6 +326,20 @@ static void mptcp_stop_timer(struct sock *sk)
 	mptcp_sk(sk)->timer_ival = 0;
 }
 
+static void mptcp_shutdown_subflows(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		tcp_shutdown(ssk, SEND_SHUTDOWN);
+		unlock_sock_fast(ssk, slow);
+	}
+}
+
 static void mptcp_check_data_fin_ack(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -348,6 +362,7 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 			break;
 		case TCP_CLOSING:
 		case TCP_LAST_ACK:
+			mptcp_shutdown_subflows(msk);
 			inet_sk_state_store(sk, TCP_CLOSE);
 			sk->sk_state_change(sk);
 			break;
@@ -430,6 +445,7 @@ static void mptcp_check_data_fin(struct sock *sk)
 			inet_sk_state_store(sk, TCP_CLOSING);
 			break;
 		case TCP_FIN_WAIT2:
+			mptcp_shutdown_subflows(msk);
 			inet_sk_state_store(sk, TCP_CLOSE);
 			// @@ Close subflows now?
 			break;
diff --git a/net/rds/ib_frmr.c b/net/rds/ib_frmr.c
index 28c1b0022178..bd861191157b 100644
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
index 016cd8aeef37..31234ad14e68 100644
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
index 600e93d61a90..bfc72c2bf90b 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -419,10 +419,14 @@ static int wm8974_update_clocks(struct snd_soc_dai *dai)
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
index 0e09ede922c7..ea4fe28cbdac 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -771,7 +771,7 @@ int hda_dsp_stream_init(struct snd_sof_dev *sdev)
 
 	if (num_capture >= SOF_HDA_CAPTURE_STREAMS) {
 		dev_err(sdev->dev, "error: too many capture streams %d\n",
-			num_playback);
+			num_capture);
 		return -EINVAL;
 	}
 
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 866b5470f84b..7a4d449182d6 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -16,6 +16,7 @@
 
 #include <linux/hid.h>
 #include <linux/init.h>
+#include <linux/input.h>
 #include <linux/math64.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
@@ -76,7 +77,8 @@ static int snd_create_std_mono_ctl_offset(struct usb_mixer_interface *mixer,
 	cval->idx_off = idx_off;
 
 	/* get_min_max() is called only for integer volumes later,
-	 * so provide a short-cut for booleans */
+	 * so provide a short-cut for booleans
+	 */
 	cval->min = 0;
 	cval->max = 1;
 	cval->res = 0;
@@ -125,7 +127,7 @@ static int snd_create_std_mono_table(struct usb_mixer_interface *mixer,
 {
 	int err;
 
-	while (t->name != NULL) {
+	while (t->name) {
 		err = snd_create_std_mono_ctl(mixer, t->unitid, t->control,
 				t->cmask, t->val_type, t->name, t->tlv_callback);
 		if (err < 0)
@@ -207,7 +209,6 @@ static void snd_usb_soundblaster_remote_complete(struct urb *urb)
 	if (code == rc->mute_code)
 		snd_usb_mixer_notify_id(mixer, rc->mute_mixer_id);
 	mixer->rc_code = code;
-	wmb();
 	wake_up(&mixer->rc_waitq);
 }
 
@@ -375,10 +376,10 @@ static int snd_audigy2nx_controls_create(struct usb_mixer_interface *mixer)
 		struct snd_kcontrol_new knew;
 
 		/* USB X-Fi S51 doesn't have a CMSS LED */
-		if ((mixer->chip->usb_id == USB_ID(0x041e, 0x3042)) && i == 0)
+		if (mixer->chip->usb_id == USB_ID(0x041e, 0x3042) && i == 0)
 			continue;
 		/* USB X-Fi S51 Pro doesn't have one either */
-		if ((mixer->chip->usb_id == USB_ID(0x041e, 0x30df)) && i == 0)
+		if (mixer->chip->usb_id == USB_ID(0x041e, 0x30df) && i == 0)
 			continue;
 		if (i > 1 && /* Live24ext has 2 LEDs only */
 			(mixer->chip->usb_id == USB_ID(0x041e, 0x3040) ||
@@ -527,6 +528,265 @@ static int snd_emu0204_controls_create(struct usb_mixer_interface *mixer)
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
@@ -1592,7 +1852,8 @@ static int snd_microii_spdif_default_put(struct snd_kcontrol *kcontrol,
 	unsigned int pval, pval_old;
 	int err;
 
-	pval = pval_old = kcontrol->private_value;
+	pval = kcontrol->private_value;
+	pval_old = pval;
 	pval &= 0xfffff0f0;
 	pval |= (ucontrol->value.iec958.status[1] & 0x0f) << 8;
 	pval |= (ucontrol->value.iec958.status[0] & 0x0f);
@@ -3011,7 +3272,7 @@ static int snd_djm_controls_update(struct usb_mixer_interface *mixer,
 	int err;
 	const struct snd_djm_device *device = &snd_djm_devices[device_idx];
 
-	if ((group >= device->ncontrols) || value >= device->controls[group].noptions)
+	if (group >= device->ncontrols || value >= device->controls[group].noptions)
 		return -EINVAL;
 
 	err = snd_usb_lock_shutdown(mixer->chip);
@@ -3129,6 +3390,13 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
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
@@ -3267,7 +3535,8 @@ static void snd_dragonfly_quirk_db_scale(struct usb_mixer_interface *mixer,
 					 struct snd_kcontrol *kctl)
 {
 	/* Approximation using 10 ranges based on output measurement on hw v1.2.
-	 * This seems close to the cubic mapping e.g. alsamixer uses. */
+	 * This seems close to the cubic mapping e.g. alsamixer uses.
+	 */
 	static const DECLARE_TLV_DB_RANGE(scale,
 		 0,  1, TLV_DB_MINMAX_ITEM(-5300, -4970),
 		 2,  5, TLV_DB_MINMAX_ITEM(-4710, -4160),
diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
index 95c072b70d0e..a590a1dfafd9 100644
--- a/tools/include/linux/compiler-gcc.h
+++ b/tools/include/linux/compiler-gcc.h
@@ -38,7 +38,3 @@
 #endif
 #define __printf(a, b)	__attribute__((format(printf, a, b)))
 #define __scanf(a, b)	__attribute__((format(scanf, a, b)))
-
-#if GCC_VERSION >= 50100
-#define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
-#endif
diff --git a/tools/include/linux/overflow.h b/tools/include/linux/overflow.h
index 8712ff70995f..dcb0c1bf6866 100644
--- a/tools/include/linux/overflow.h
+++ b/tools/include/linux/overflow.h
@@ -5,12 +5,9 @@
 #include <linux/compiler.h>
 
 /*
- * In the fallback code below, we need to compute the minimum and
- * maximum values representable in a given type. These macros may also
- * be useful elsewhere, so we provide them outside the
- * COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW block.
- *
- * It would seem more obvious to do something like
+ * We need to compute the minimum and maximum values representable in a given
+ * type. These macros may also be useful elsewhere. It would seem more obvious
+ * to do something like:
  *
  * #define type_min(T) (T)(is_signed_type(T) ? (T)1 << (8*sizeof(T)-1) : 0)
  * #define type_max(T) (T)(is_signed_type(T) ? ((T)1 << (8*sizeof(T)-1)) - 1 : ~(T)0)
@@ -36,8 +33,6 @@
 #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
 #define type_min(T) ((T)((T)-type_max(T)-(T)1))
 
-
-#ifdef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
 /*
  * For simplicity and code hygiene, the fallback code below insists on
  * a, b and *d having the same type (similar to the min() and max()
@@ -73,135 +68,6 @@
 	__builtin_mul_overflow(__a, __b, __d);	\
 })
 
-#else
-
-
-/* Checking for unsigned overflow is relatively easy without causing UB. */
-#define __unsigned_add_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = __a + __b;			\
-	*__d < __a;				\
-})
-#define __unsigned_sub_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = __a - __b;			\
-	__a < __b;				\
-})
-/*
- * If one of a or b is a compile-time constant, this avoids a division.
- */
-#define __unsigned_mul_overflow(a, b, d) ({		\
-	typeof(a) __a = (a);				\
-	typeof(b) __b = (b);				\
-	typeof(d) __d = (d);				\
-	(void) (&__a == &__b);				\
-	(void) (&__a == __d);				\
-	*__d = __a * __b;				\
-	__builtin_constant_p(__b) ?			\
-	  __b > 0 && __a > type_max(typeof(__a)) / __b : \
-	  __a > 0 && __b > type_max(typeof(__b)) / __a;	 \
-})
-
-/*
- * For signed types, detecting overflow is much harder, especially if
- * we want to avoid UB. But the interface of these macros is such that
- * we must provide a result in *d, and in fact we must produce the
- * result promised by gcc's builtins, which is simply the possibly
- * wrapped-around value. Fortunately, we can just formally do the
- * operations in the widest relevant unsigned type (u64) and then
- * truncate the result - gcc is smart enough to generate the same code
- * with and without the (u64) casts.
- */
-
-/*
- * Adding two signed integers can overflow only if they have the same
- * sign, and overflow has happened iff the result has the opposite
- * sign.
- */
-#define __signed_add_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = (u64)__a + (u64)__b;		\
-	(((~(__a ^ __b)) & (*__d ^ __a))	\
-		& type_min(typeof(__a))) != 0;	\
-})
-
-/*
- * Subtraction is similar, except that overflow can now happen only
- * when the signs are opposite. In this case, overflow has happened if
- * the result has the opposite sign of a.
- */
-#define __signed_sub_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = (u64)__a - (u64)__b;		\
-	((((__a ^ __b)) & (*__d ^ __a))		\
-		& type_min(typeof(__a))) != 0;	\
-})
-
-/*
- * Signed multiplication is rather hard. gcc always follows C99, so
- * division is truncated towards 0. This means that we can write the
- * overflow check like this:
- *
- * (a > 0 && (b > MAX/a || b < MIN/a)) ||
- * (a < -1 && (b > MIN/a || b < MAX/a) ||
- * (a == -1 && b == MIN)
- *
- * The redundant casts of -1 are to silence an annoying -Wtype-limits
- * (included in -Wextra) warning: When the type is u8 or u16, the
- * __b_c_e in check_mul_overflow obviously selects
- * __unsigned_mul_overflow, but unfortunately gcc still parses this
- * code and warns about the limited range of __b.
- */
-
-#define __signed_mul_overflow(a, b, d) ({				\
-	typeof(a) __a = (a);						\
-	typeof(b) __b = (b);						\
-	typeof(d) __d = (d);						\
-	typeof(a) __tmax = type_max(typeof(a));				\
-	typeof(a) __tmin = type_min(typeof(a));				\
-	(void) (&__a == &__b);						\
-	(void) (&__a == __d);						\
-	*__d = (u64)__a * (u64)__b;					\
-	(__b > 0   && (__a > __tmax/__b || __a < __tmin/__b)) ||	\
-	(__b < (typeof(__b))-1  && (__a > __tmin/__b || __a < __tmax/__b)) || \
-	(__b == (typeof(__b))-1 && __a == __tmin);			\
-})
-
-
-#define check_add_overflow(a, b, d)					\
-	__builtin_choose_expr(is_signed_type(typeof(a)),		\
-			__signed_add_overflow(a, b, d),			\
-			__unsigned_add_overflow(a, b, d))
-
-#define check_sub_overflow(a, b, d)					\
-	__builtin_choose_expr(is_signed_type(typeof(a)),		\
-			__signed_sub_overflow(a, b, d),			\
-			__unsigned_sub_overflow(a, b, d))
-
-#define check_mul_overflow(a, b, d)					\
-	__builtin_choose_expr(is_signed_type(typeof(a)),		\
-			__signed_mul_overflow(a, b, d),			\
-			__unsigned_mul_overflow(a, b, d))
-
-
-#endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
-
 /**
  * array_size() - Calculate size of 2-dimensional array.
  *
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 7ece4131dc6f..cdc7c0ff090f 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -370,8 +370,8 @@ ipv6_fdb_grp_fcnal()
 	log_test $? 0 "Get Fdb nexthop group by id"
 
 	# fdb nexthop group can only contain fdb nexthops
-	run_cmd "$IP nexthop add id 63 via 2001:db8:91::4"
-	run_cmd "$IP nexthop add id 64 via 2001:db8:91::5"
+	run_cmd "$IP nexthop add id 63 via 2001:db8:91::4 dev veth1"
+	run_cmd "$IP nexthop add id 64 via 2001:db8:91::5 dev veth1"
 	run_cmd "$IP nexthop add id 103 group 63/64 fdb"
 	log_test $? 2 "Fdb Nexthop group with non-fdb nexthops"
 
@@ -450,15 +450,15 @@ ipv4_fdb_grp_fcnal()
 	log_test $? 0 "Get Fdb nexthop group by id"
 
 	# fdb nexthop group can only contain fdb nexthops
-	run_cmd "$IP nexthop add id 14 via 172.16.1.2"
-	run_cmd "$IP nexthop add id 15 via 172.16.1.3"
+	run_cmd "$IP nexthop add id 14 via 172.16.1.2 dev veth1"
+	run_cmd "$IP nexthop add id 15 via 172.16.1.3 dev veth1"
 	run_cmd "$IP nexthop add id 103 group 14/15 fdb"
 	log_test $? 2 "Fdb Nexthop group with non-fdb nexthops"
 
 	# Non fdb nexthop group can not contain fdb nexthops
 	run_cmd "$IP nexthop add id 16 via 172.16.1.2 fdb"
 	run_cmd "$IP nexthop add id 17 via 172.16.1.3 fdb"
-	run_cmd "$IP nexthop add id 104 group 14/15"
+	run_cmd "$IP nexthop add id 104 group 16/17"
 	log_test $? 2 "Non-Fdb Nexthop group with fdb nexthops"
 
 	# fdb nexthop cannot have blackhole
@@ -485,7 +485,7 @@ ipv4_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:14 dev vx10 nhid 12 self"
 	log_test $? 255 "Fdb mac add with nexthop"
 
-	run_cmd "$IP ro add 172.16.0.0/22 nhid 15"
+	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"
 
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 103"

