Return-Path: <stable+bounces-109361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEF6A15037
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 14:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3054D162D7A
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 13:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A281FFC5E;
	Fri, 17 Jan 2025 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nqrCeu4R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17B7202F68;
	Fri, 17 Jan 2025 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119262; cv=none; b=b3qh6pz3e0PwCH5ZLY0MNFDmkpglH41i2FMocPLIE49htfvwvUu9O4Pep50nVHz8i29442/6pjXTytkjevq2ENIr/3KpkOGH1xT5SceVOkMKP35k6X9D55Pb3nhZlVyNYMNL7Tv3hJvzjJeKriobNfetnOicXgKVhEgAUZ+/Iuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119262; c=relaxed/simple;
	bh=gnKIcJHo8sfGvlUzalFa+g2hSCR5PmiyzPETGAS7Utk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jb49W/zxCHgkMRJ13vtJuS9WNI1bEubMrmWe0/Ov5cScP9MD01eHVmVCORcB2vd8EWuFAaLsA3p7cUWdir0RG+rwBR6JEk9w4t1jFzPP2XAajzH4E/lhicux9bYoN8iN8qqWXuw6jr2cASTs+ajwV3/NqMjZQqspMoY2ZTCxbx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nqrCeu4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA65C4CEDD;
	Fri, 17 Jan 2025 13:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737119262;
	bh=gnKIcJHo8sfGvlUzalFa+g2hSCR5PmiyzPETGAS7Utk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nqrCeu4RyYuP4mfMzL+SDQYu6IWUtCKFoNdvecNtt8NvoB8uplOxL0UKLDdCn36Vm
	 Hcaen7KlEJ77lGX/zd6Bd6Au1/T7IJvmVAnpO5PPlIOwR7E3LtB92ow9vM/8jRqMA6
	 J6BQAMgB796zvjhEYQ/AY0tj/qYwrQSl9/veN7/o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.125
Date: Fri, 17 Jan 2025 14:07:29 +0100
Message-ID: <2025011727-rebound-require-6709@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025011725-urging-clubhouse-273f@gregkh>
References: <2025011725-urging-clubhouse-273f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index d26a3c2e4519..9151052c19af 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 124
+SUBLEVEL = 125
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/boot/dts/imxrt1050.dtsi b/arch/arm/boot/dts/imxrt1050.dtsi
index 03e6a858a7be..a25eae9bd38a 100644
--- a/arch/arm/boot/dts/imxrt1050.dtsi
+++ b/arch/arm/boot/dts/imxrt1050.dtsi
@@ -87,7 +87,7 @@ usdhc1: mmc@402c0000 {
 			reg = <0x402c0000 0x4000>;
 			interrupts = <110>;
 			clocks = <&clks IMXRT1050_CLK_IPG_PDOF>,
-				<&clks IMXRT1050_CLK_OSC>,
+				<&clks IMXRT1050_CLK_AHB_PODF>,
 				<&clks IMXRT1050_CLK_USDHC1>;
 			clock-names = "ipg", "ahb", "per";
 			bus-width = <4>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 75ea512e9724..ce7c1d3c345e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -302,6 +302,7 @@ power: power-controller {
 
 			power-domain@RK3328_PD_HEVC {
 				reg = <RK3328_PD_HEVC>;
+				clocks = <&cru SCLK_VENC_CORE>;
 				#power-domain-cells = <0>;
 			};
 			power-domain@RK3328_PD_VIDEO {
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 5d07f6b3ca32..7a6c02e17f4f 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -27,7 +27,7 @@
 
 int show_unhandled_signals = 1;
 
-static DEFINE_SPINLOCK(die_lock);
+static DEFINE_RAW_SPINLOCK(die_lock);
 
 void die(struct pt_regs *regs, const char *str)
 {
@@ -38,7 +38,7 @@ void die(struct pt_regs *regs, const char *str)
 
 	oops_enter();
 
-	spin_lock_irqsave(&die_lock, flags);
+	raw_spin_lock_irqsave(&die_lock, flags);
 	console_verbose();
 	bust_spinlocks(1);
 
@@ -55,7 +55,7 @@ void die(struct pt_regs *regs, const char *str)
 
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-	spin_unlock_irqrestore(&die_lock, flags);
+	raw_spin_unlock_irqrestore(&die_lock, flags);
 	oops_exit();
 
 	if (in_interrupt())
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 8e797782cfe3..f75945764653 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6733,16 +6733,24 @@ static struct bfq_queue *bfq_waker_bfqq(struct bfq_queue *bfqq)
 		if (new_bfqq == waker_bfqq) {
 			/*
 			 * If waker_bfqq is in the merge chain, and current
-			 * is the only procress.
+			 * is the only process, waker_bfqq can be freed.
 			 */
 			if (bfqq_process_refs(waker_bfqq) == 1)
 				return NULL;
-			break;
+
+			return waker_bfqq;
 		}
 
 		new_bfqq = new_bfqq->new_bfqq;
 	}
 
+	/*
+	 * If waker_bfqq is not in the merge chain, and it's procress reference
+	 * is 0, waker_bfqq can be freed.
+	 */
+	if (bfqq_process_refs(waker_bfqq) == 0)
+		return NULL;
+
 	return waker_bfqq;
 }
 
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b36b8592667d..6e041d40cad5 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -439,6 +439,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
 		},
 	},
+	{
+		/* Asus Vivobook X1504VAP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "X1504VAP"),
+		},
+	},
 	{
 		/* Asus Vivobook X1704VAP */
 		.matches = {
@@ -615,6 +622,17 @@ static const struct dmi_system_id lg_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
 		},
 	},
+	{
+		/*
+		 * TongFang GM5HG0A in case of the SKIKK Vanaheim relabel the
+		 * board-name is changed, so check OEM strings instead. Note
+		 * OEM string matches are always exact matches.
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=219614
+		 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_OEM_STRING, "GM5HG0A"),
+		},
+	},
 	{ }
 };
 
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 89f98be5c5b9..d293cbd253e4 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -27,9 +27,17 @@ static ssize_t name##_read(struct file *file, struct kobject *kobj,		\
 			   loff_t off, size_t count)				\
 {										\
 	struct device *dev = kobj_to_dev(kobj);                                 \
+	cpumask_var_t mask;							\
+	ssize_t n;								\
 										\
-	return cpumap_print_bitmask_to_buf(buf, topology_##mask(dev->id),	\
-					   off, count);                         \
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))				\
+		return -ENOMEM;							\
+										\
+	cpumask_copy(mask, topology_##mask(dev->id));				\
+	n = cpumap_print_bitmask_to_buf(buf, mask, off, count);			\
+	free_cpumask_var(mask);							\
+										\
+	return n;								\
 }										\
 										\
 static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
@@ -37,9 +45,17 @@ static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
 				loff_t off, size_t count)			\
 {										\
 	struct device *dev = kobj_to_dev(kobj);					\
+	cpumask_var_t mask;							\
+	ssize_t n;								\
+										\
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))				\
+		return -ENOMEM;							\
+										\
+	cpumask_copy(mask, topology_##mask(dev->id));				\
+	n = cpumap_print_list_to_buf(buf, mask, off, count);			\
+	free_cpumask_var(mask);							\
 										\
-	return cpumap_print_list_to_buf(buf, topology_##mask(dev->id),		\
-					off, count);				\
+	return n;								\
 }
 
 define_id_show_func(physical_package_id, "%d");
diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index af7320a768d2..963d5f171ef7 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -540,12 +540,12 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
 	int cpu, ret;
 	struct cpuidle_driver *drv;
 	struct cpuidle_device *dev;
-	struct device_node *np, *pds_node;
+	struct device_node *pds_node;
 
 	/* Detect OSI support based on CPU DT nodes */
 	sbi_cpuidle_use_osi = true;
 	for_each_possible_cpu(cpu) {
-		np = of_cpu_device_node_get(cpu);
+		struct device_node *np __free(device_node) = of_cpu_device_node_get(cpu);
 		if (np &&
 		    of_find_property(np, "power-domains", NULL) &&
 		    of_find_property(np, "power-domain-names", NULL)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7e775cec0692..fb0aac0ee88e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -49,7 +49,7 @@ struct dmub_notification;
 
 #define DC_VER "3.2.207"
 
-#define MAX_SURFACES 3
+#define MAX_SURFACES 4
 #define MAX_PLANES 6
 #define MAX_STREAMS 6
 #define MAX_SINKS_PER_LINK 4
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
index 072bd0539605..6b2ab4ec2b5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
@@ -66,11 +66,15 @@ static inline double dml_max5(double a, double b, double c, double d, double e)
 
 static inline double dml_ceil(double a, double granularity)
 {
+	if (granularity == 0)
+		return 0;
 	return (double) dcn_bw_ceil2(a, granularity);
 }
 
 static inline double dml_floor(double a, double granularity)
 {
+	if (granularity == 0)
+		return 0;
 	return (double) dcn_bw_floor2(a, granularity);
 }
 
@@ -114,11 +118,15 @@ static inline double dml_ceil_2(double f)
 
 static inline double dml_ceil_ex(double x, double granularity)
 {
+	if (granularity == 0)
+		return 0;
 	return (double) dcn_bw_ceil2(x, granularity);
 }
 
 static inline double dml_floor_ex(double x, double granularity)
 {
+	if (granularity == 0)
+		return 0;
 	return (double) dcn_bw_floor2(x, granularity);
 }
 
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 9f9874acfb2b..3e6fe8604959 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1225,8 +1225,8 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 
 	ret = adv7511_init_regulators(adv7511);
 	if (ret) {
-		dev_err(dev, "failed to init regulators\n");
-		return ret;
+		dev_err_probe(dev, ret, "failed to init regulators\n");
+		goto err_of_node_put;
 	}
 
 	/*
@@ -1347,6 +1347,8 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 	i2c_unregister_device(adv7511->i2c_edid);
 uninit_regulators:
 	adv7511_uninit_regulators(adv7511);
+err_of_node_put:
+	of_node_put(adv7511->host_node);
 
 	return ret;
 }
@@ -1355,6 +1357,8 @@ static void adv7511_remove(struct i2c_client *i2c)
 {
 	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
 
+	of_node_put(adv7511->host_node);
+
 	adv7511_uninit_regulators(adv7511);
 
 	drm_bridge_remove(&adv7511->bridge);
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
index 145b43f5e427..6a4733c70827 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
@@ -146,16 +146,14 @@ int adv7533_attach_dsi(struct adv7511 *adv)
 						 };
 
 	host = of_find_mipi_dsi_host_by_node(adv->host_node);
-	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER,
+				     "failed to find dsi host\n");
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
-	if (IS_ERR(dsi)) {
-		dev_err(dev, "failed to create dsi device\n");
-		return PTR_ERR(dsi);
-	}
+	if (IS_ERR(dsi))
+		return dev_err_probe(dev, PTR_ERR(dsi),
+				     "failed to create dsi device\n");
 
 	adv->dsi = dsi;
 
@@ -165,10 +163,8 @@ int adv7533_attach_dsi(struct adv7511 *adv)
 			  MIPI_DSI_MODE_NO_EOT_PACKET | MIPI_DSI_MODE_VIDEO_HSE;
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
-	if (ret < 0) {
-		dev_err(dev, "failed to attach dsi to host\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to attach dsi to host\n");
 
 	return 0;
 }
@@ -188,8 +184,6 @@ int adv7533_parse_dt(struct device_node *np, struct adv7511 *adv)
 	if (!adv->host_node)
 		return -ENODEV;
 
-	of_node_put(adv->host_node);
-
 	adv->use_timing_gen = !of_property_read_bool(np,
 						"adi,disable-timing-generator");
 
diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index d1eededee943..d663869bfce1 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -11,9 +11,6 @@ config DRM_MEDIATEK
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL
-	select MEMORY
-	select MTK_SMI
-	select PHY_MTK_MIPI_DSI
 	select VIDEOMODE_HELPERS
 	help
 	  Choose this option if you have a Mediatek SoCs.
@@ -24,7 +21,6 @@ config DRM_MEDIATEK
 config DRM_MEDIATEK_DP
 	tristate "DRM DPTX Support for MediaTek SoCs"
 	depends on DRM_MEDIATEK
-	select PHY_MTK_DP
 	select DRM_DISPLAY_HELPER
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DP_AUX_BUS
@@ -35,6 +31,5 @@ config DRM_MEDIATEK_HDMI
 	tristate "DRM HDMI Support for Mediatek SoCs"
 	depends on DRM_MEDIATEK
 	select SND_SOC_HDMI_CODEC if SND_SOC
-	select PHY_MTK_HDMI
 	help
 	  DRM/KMS HDMI driver for Mediatek SoCs
diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index c24eeb7ffde7..6bf50a15c9b4 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -457,18 +457,16 @@ static int mtk_dp_set_color_format(struct mtk_dp *mtk_dp,
 				   enum dp_pixelformat color_format)
 {
 	u32 val;
-
-	/* update MISC0 */
-	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3034,
-			   color_format << DP_TEST_COLOR_FORMAT_SHIFT,
-			   DP_TEST_COLOR_FORMAT_MASK);
+	u32 misc0_color;
 
 	switch (color_format) {
 	case DP_PIXELFORMAT_YUV422:
 		val = PIXEL_ENCODE_FORMAT_DP_ENC0_P0_YCBCR422;
+		misc0_color = DP_COLOR_FORMAT_YCbCr422;
 		break;
 	case DP_PIXELFORMAT_RGB:
 		val = PIXEL_ENCODE_FORMAT_DP_ENC0_P0_RGB;
+		misc0_color = DP_COLOR_FORMAT_RGB;
 		break;
 	default:
 		drm_warn(mtk_dp->drm_dev, "Unsupported color format: %d\n",
@@ -476,6 +474,11 @@ static int mtk_dp_set_color_format(struct mtk_dp *mtk_dp,
 		return -EINVAL;
 	}
 
+	/* update MISC0 */
+	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3034,
+			   misc0_color,
+			   DP_TEST_COLOR_FORMAT_MASK);
+
 	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_303C,
 			   val, PIXEL_ENCODE_FORMAT_DP_ENC0_P0_MASK);
 	return 0;
@@ -1949,7 +1952,6 @@ static enum drm_connector_status mtk_dp_bdg_detect(struct drm_bridge *bridge)
 	struct mtk_dp *mtk_dp = mtk_dp_from_bridge(bridge);
 	enum drm_connector_status ret = connector_status_disconnected;
 	bool enabled = mtk_dp->enabled;
-	u8 sink_count = 0;
 
 	if (!mtk_dp->train_info.cable_plugged_in)
 		return ret;
@@ -1971,8 +1973,8 @@ static enum drm_connector_status mtk_dp_bdg_detect(struct drm_bridge *bridge)
 	 * function, we just need to check the HPD connection to check
 	 * whether we connect to a sink device.
 	 */
-	drm_dp_dpcd_readb(&mtk_dp->aux, DP_SINK_COUNT, &sink_count);
-	if (DP_GET_SINK_COUNT(sink_count))
+
+	if (drm_dp_read_sink_count(&mtk_dp->aux) > 0)
 		ret = connector_status_connected;
 
 	if (!enabled) {
@@ -2274,12 +2276,19 @@ mtk_dp_bridge_mode_valid(struct drm_bridge *bridge,
 {
 	struct mtk_dp *mtk_dp = mtk_dp_from_bridge(bridge);
 	u32 bpp = info->color_formats & DRM_COLOR_FORMAT_YCBCR422 ? 16 : 24;
-	u32 rate = min_t(u32, drm_dp_max_link_rate(mtk_dp->rx_cap) *
-			      drm_dp_max_lane_count(mtk_dp->rx_cap),
-			 drm_dp_bw_code_to_link_rate(mtk_dp->max_linkrate) *
-			 mtk_dp->max_lanes);
+	u32 lane_count_min = mtk_dp->train_info.lane_count;
+	u32 rate = drm_dp_bw_code_to_link_rate(mtk_dp->train_info.link_rate) *
+		   lane_count_min;
 
-	if (rate < mode->clock * bpp / 8)
+	/*
+	 *FEC overhead is approximately 2.4% from DP 1.4a spec 2.2.1.4.2.
+	 *The down-spread amplitude shall either be disabled (0.0%) or up
+	 *to 0.5% from 1.4a 3.5.2.6. Add up to approximately 3% total overhead.
+	 *
+	 *Because rate is already divided by 10,
+	 *mode->clock does not need to be multiplied by 10
+	 */
+	if ((rate * 97 / 100) < (mode->clock * bpp / 8))
 		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
@@ -2320,10 +2329,9 @@ static u32 *mtk_dp_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 	struct drm_display_info *display_info =
 		&conn_state->connector->display_info;
-	u32 rate = min_t(u32, drm_dp_max_link_rate(mtk_dp->rx_cap) *
-			      drm_dp_max_lane_count(mtk_dp->rx_cap),
-			 drm_dp_bw_code_to_link_rate(mtk_dp->max_linkrate) *
-			 mtk_dp->max_lanes);
+	u32 lane_count_min = mtk_dp->train_info.lane_count;
+	u32 rate = drm_dp_bw_code_to_link_rate(mtk_dp->train_info.link_rate) *
+		   lane_count_min;
 
 	*num_input_fmts = 0;
 
@@ -2332,8 +2340,8 @@ static u32 *mtk_dp_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	 * datarate of YUV422 and sink device supports YUV422, we output YUV422
 	 * format. Use this condition, we can support more resolution.
 	 */
-	if ((rate < (mode->clock * 24 / 8)) &&
-	    (rate > (mode->clock * 16 / 8)) &&
+	if (((rate * 97 / 100) < (mode->clock * 24 / 8)) &&
+	    ((rate * 97 / 100) > (mode->clock * 16 / 8)) &&
 	    (display_info->color_formats & DRM_COLOR_FORMAT_YCBCR422)) {
 		input_fmts = kcalloc(1, sizeof(*input_fmts), GFP_KERNEL);
 		if (!input_fmts)
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 0d0884d3b246..5d4abe81d2a2 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -931,6 +931,9 @@ static int ad7124_setup(struct ad7124_state *st)
 		 * set all channels to this default value.
 		 */
 		ad7124_set_channel_odr(st, i, 10);
+
+		/* Disable all channels to prevent unintended conversions. */
+		ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, 0);
 	}
 
 	return ret;
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 366e252ebeb0..ff61b7649113 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -985,7 +985,7 @@ static int at91_ts_register(struct iio_dev *idev,
 	return ret;
 
 err:
-	input_free_device(st->ts_input);
+	input_free_device(input);
 	return ret;
 }
 
diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 4ca62121f0d1..c6004f2b5d3d 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -183,9 +183,9 @@ static int ads124s_reset(struct iio_dev *indio_dev)
 	struct ads124s_private *priv = iio_priv(indio_dev);
 
 	if (priv->reset_gpio) {
-		gpiod_set_value(priv->reset_gpio, 0);
+		gpiod_set_value_cansleep(priv->reset_gpio, 0);
 		udelay(200);
-		gpiod_set_value(priv->reset_gpio, 1);
+		gpiod_set_value_cansleep(priv->reset_gpio, 1);
 	} else {
 		return ads124s_write_cmd(indio_dev, ADS124S08_CMD_RESET);
 	}
diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index ef06a897421a..66a3b67019b8 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -382,7 +382,7 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	/* Ensure naturally aligned timestamp */
-	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8);
+	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8) = { };
 	int i, j = 0;
 
 	for (i = 0; i < indio_dev->masklength; i++) {
diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 9b2f99449a82..bc85fe6610c1 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -48,7 +48,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	int i = 0, j;
 	u16 *data;
 
-	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	data = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (!data)
 		goto done;
 
diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index a36d71d9e3ea..e38fd7dcecfe 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -730,14 +730,21 @@ static irqreturn_t fxas21002c_trigger_handler(int irq, void *p)
 	int ret;
 
 	mutex_lock(&data->lock);
+	ret = fxas21002c_pm_get(data);
+	if (ret < 0)
+		goto out_unlock;
+
 	ret = regmap_bulk_read(data->regmap, FXAS21002C_REG_OUT_X_MSB,
 			       data->buffer, CHANNEL_SCAN_MAX * sizeof(s16));
 	if (ret < 0)
-		goto out_unlock;
+		goto out_pm_put;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
 					   data->timestamp);
 
+out_pm_put:
+	fxas21002c_pm_put(data);
+
 out_unlock:
 	mutex_unlock(&data->lock);
 
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index b10c0dcac0bb..c9c3a276378c 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1192,7 +1192,7 @@ static irqreturn_t kmx61_trigger_handler(int irq, void *p)
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 	int bit, ret, i = 0;
 	u8 base;
-	s16 buffer[8];
+	s16 buffer[8] = { };
 
 	if (indio_dev == data->acc_indio_dev)
 		base = KMX61_ACC_XOUT_L;
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 21c07178bd2d..5c210f48bd9c 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -513,7 +513,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 	return chans;
 
 error_free_chans:
-	for (i = 0; i < nummaps; i++)
+	for (i = 0; i < mapind; i++)
 		iio_device_put(chans[i].indio_dev);
 	kfree(chans);
 error_ret:
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index a23c415fcb7a..db954c6faa2f 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -105,7 +105,7 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct vcnl4035_data *data = iio_priv(indio_dev);
 	/* Ensure naturally aligned timestamp */
-	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8);
+	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8) = { };
 	int ret;
 
 	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, (int *)buffer);
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 67119a9b95fc..fdb1b765206b 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -586,6 +586,8 @@ static int zpa2326_fill_sample_buffer(struct iio_dev               *indio_dev,
 	}   sample;
 	int err;
 
+	memset(&sample, 0, sizeof(sample));
+
 	if (test_bit(0, indio_dev->active_scan_mask)) {
 		/* Get current pressure from hardware FIFO. */
 		err = zpa2326_dequeue_pressure(indio_dev, &sample.pressure);
diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 7606c6695a0e..828a98acf2a6 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -441,7 +441,7 @@ static int ebs_iterate_devices(struct dm_target *ti,
 static struct target_type ebs_target = {
 	.name		 = "ebs",
 	.version	 = {1, 0, 1},
-	.features	 = DM_TARGET_PASSES_INTEGRITY,
+	.features	 = 0,
 	.module		 = THIS_MODULE,
 	.ctr		 = ebs_ctr,
 	.dtr		 = ebs_dtr,
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 669d47755231..aca3cfb46cf4 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -2306,10 +2306,9 @@ static struct thin_c *get_first_thin(struct pool *pool)
 	struct thin_c *tc = NULL;
 
 	rcu_read_lock();
-	if (!list_empty(&pool->active_thins)) {
-		tc = list_entry_rcu(pool->active_thins.next, struct thin_c, list);
+	tc = list_first_or_null_rcu(&pool->active_thins, struct thin_c, list);
+	if (tc)
 		thin_get(tc);
-	}
 	rcu_read_unlock();
 
 	return tc;
diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 0304e36af329..9bf48d34ef0f 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -60,14 +60,19 @@ static int fec_decode_rs8(struct dm_verity *v, struct dm_verity_fec_io *fio,
  * to the data block. Caller is responsible for releasing buf.
  */
 static u8 *fec_read_parity(struct dm_verity *v, u64 rsb, int index,
-			   unsigned int *offset, struct dm_buffer **buf)
+			   unsigned int *offset, unsigned int par_buf_offset,
+			  struct dm_buffer **buf)
 {
 	u64 position, block, rem;
 	u8 *res;
 
+	/* We have already part of parity bytes read, skip to the next block */
+	if (par_buf_offset)
+		index++;
+
 	position = (index + rsb) * v->fec->roots;
 	block = div64_u64_rem(position, v->fec->io_size, &rem);
-	*offset = (unsigned int)rem;
+	*offset = par_buf_offset ? 0 : (unsigned int)rem;
 
 	res = dm_bufio_read(v->fec->bufio, block, buf);
 	if (IS_ERR(res)) {
@@ -127,10 +132,11 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_fec_io *fio,
 {
 	int r, corrected = 0, res;
 	struct dm_buffer *buf;
-	unsigned int n, i, offset;
-	u8 *par, *block;
+	unsigned int n, i, offset, par_buf_offset = 0;
+	u8 *par, *block, par_buf[DM_VERITY_FEC_RSM - DM_VERITY_FEC_MIN_RSN];
 
-	par = fec_read_parity(v, rsb, block_offset, &offset, &buf);
+	par = fec_read_parity(v, rsb, block_offset, &offset,
+			      par_buf_offset, &buf);
 	if (IS_ERR(par))
 		return PTR_ERR(par);
 
@@ -140,7 +146,8 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_fec_io *fio,
 	 */
 	fec_for_each_buffer_rs_block(fio, n, i) {
 		block = fec_buffer_rs_block(v, fio, n, i);
-		res = fec_decode_rs8(v, fio, block, &par[offset], neras);
+		memcpy(&par_buf[par_buf_offset], &par[offset], v->fec->roots - par_buf_offset);
+		res = fec_decode_rs8(v, fio, block, par_buf, neras);
 		if (res < 0) {
 			r = res;
 			goto error;
@@ -153,12 +160,21 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_fec_io *fio,
 		if (block_offset >= 1 << v->data_dev_block_bits)
 			goto done;
 
-		/* read the next block when we run out of parity bytes */
-		offset += v->fec->roots;
+		/* Read the next block when we run out of parity bytes */
+		offset += (v->fec->roots - par_buf_offset);
+		/* Check if parity bytes are split between blocks */
+		if (offset < v->fec->io_size && (offset + v->fec->roots) > v->fec->io_size) {
+			par_buf_offset = v->fec->io_size - offset;
+			memcpy(par_buf, &par[offset], par_buf_offset);
+			offset += par_buf_offset;
+		} else
+			par_buf_offset = 0;
+
 		if (offset >= v->fec->io_size) {
 			dm_bufio_release(buf);
 
-			par = fec_read_parity(v, rsb, block_offset, &offset, &buf);
+			par = fec_read_parity(v, rsb, block_offset, &offset,
+					      par_buf_offset, &buf);
 			if (IS_ERR(par))
 				return PTR_ERR(par);
 		}
@@ -743,10 +759,7 @@ int verity_fec_ctr(struct dm_verity *v)
 		return -E2BIG;
 	}
 
-	if ((f->roots << SECTOR_SHIFT) & ((1 << v->data_dev_block_bits) - 1))
-		f->io_size = 1 << v->data_dev_block_bits;
-	else
-		f->io_size = v->fec->roots << SECTOR_SHIFT;
+	f->io_size = 1 << v->data_dev_block_bits;
 
 	f->bufio = dm_bufio_client_create(f->dev->bdev,
 					  f->io_size,
diff --git a/drivers/md/persistent-data/dm-array.c b/drivers/md/persistent-data/dm-array.c
index eff9b41869f2..767ab60507d9 100644
--- a/drivers/md/persistent-data/dm-array.c
+++ b/drivers/md/persistent-data/dm-array.c
@@ -912,23 +912,27 @@ static int load_ablock(struct dm_array_cursor *c)
 	if (c->block)
 		unlock_ablock(c->info, c->block);
 
-	c->block = NULL;
-	c->ab = NULL;
 	c->index = 0;
 
 	r = dm_btree_cursor_get_value(&c->cursor, &key, &value_le);
 	if (r) {
 		DMERR("dm_btree_cursor_get_value failed");
-		dm_btree_cursor_end(&c->cursor);
+		goto out;
 
 	} else {
 		r = get_ablock(c->info, le64_to_cpu(value_le), &c->block, &c->ab);
 		if (r) {
 			DMERR("get_ablock failed");
-			dm_btree_cursor_end(&c->cursor);
+			goto out;
 		}
 	}
 
+	return 0;
+
+out:
+	dm_btree_cursor_end(&c->cursor);
+	c->block = NULL;
+	c->ab = NULL;
 	return r;
 }
 
@@ -951,10 +955,10 @@ EXPORT_SYMBOL_GPL(dm_array_cursor_begin);
 
 void dm_array_cursor_end(struct dm_array_cursor *c)
 {
-	if (c->block) {
+	if (c->block)
 		unlock_ablock(c->info, c->block);
-		dm_btree_cursor_end(&c->cursor);
-	}
+
+	dm_btree_cursor_end(&c->cursor);
 }
 EXPORT_SYMBOL_GPL(dm_array_cursor_end);
 
@@ -994,6 +998,7 @@ int dm_array_cursor_skip(struct dm_array_cursor *c, uint32_t count)
 		}
 
 		count -= remaining;
+		c->index += (remaining - 1);
 		r = dm_array_cursor_next(c);
 
 	} while (!r);
diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
index 3389803cb281..c6199ded8f6d 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
@@ -148,7 +148,7 @@ static int pci1xxxx_gpio_set_config(struct gpio_chip *gpio, unsigned int offset,
 		pci1xxx_assign_bit(priv->reg_base, OPENDRAIN_OFFSET(offset), (offset % 32), true);
 		break;
 	default:
-		ret = -EOPNOTSUPP;
+		ret = -ENOTSUPP;
 		break;
 	}
 	spin_unlock_irqrestore(&priv->lock, flags);
@@ -273,7 +273,7 @@ static irqreturn_t pci1xxxx_gpio_irq_handler(int irq, void *dev_id)
 			writel(BIT(bit), priv->reg_base + INTR_STATUS_OFFSET(gpiobank));
 			spin_unlock_irqrestore(&priv->lock, flags);
 			irq = irq_find_mapping(gc->irq.domain, (bit + (gpiobank * 32)));
-			generic_handle_irq(irq);
+			handle_nested_irq(irq);
 		}
 	}
 	spin_lock_irqsave(&priv->lock, flags);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 2e54bf4fc7a7..c0f67db641c3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -252,7 +252,7 @@ static int bnxt_send_msg(struct bnxt_en_dev *edev, unsigned int ulp_id,
 
 	rc = hwrm_req_replace(bp, req, fw_msg->msg, fw_msg->msg_len);
 	if (rc)
-		return rc;
+		goto drop_req;
 
 	hwrm_req_timeout(bp, req, fw_msg->timeout);
 	resp = hwrm_req_hold(bp, req);
@@ -264,6 +264,7 @@ static int bnxt_send_msg(struct bnxt_en_dev *edev, unsigned int ulp_id,
 
 		memcpy(fw_msg->resp, resp, resp_len);
 	}
+drop_req:
 	hwrm_req_drop(bp, req);
 	return rc;
 }
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 7ce112b95b62..c09240a5693b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -1800,7 +1800,10 @@ void cxgb4_remove_tid(struct tid_info *t, unsigned int chan, unsigned int tid,
 	struct adapter *adap = container_of(t, struct adapter, tids);
 	struct sk_buff *skb;
 
-	WARN_ON(tid_out_of_range(&adap->tids, tid));
+	if (tid_out_of_range(&adap->tids, tid)) {
+		dev_err(adap->pdev_dev, "tid %d out of range\n", tid);
+		return;
+	}
 
 	if (t->tid_tab[tid - adap->tids.tid_base]) {
 		t->tid_tab[tid - adap->tids.tid_base] = NULL;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index 4109aa3b2fcd..87ce20540f57 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -359,9 +359,9 @@ const struct ice_vernier_info_e822 e822_vernier[NUM_ICE_PTP_LNK_SPD] = {
 		/* rx_desk_rsgb_par */
 		644531250, /* 644.53125 MHz Reed Solomon gearbox */
 		/* tx_desk_rsgb_pcs */
-		644531250, /* 644.53125 MHz Reed Solomon gearbox */
+		390625000, /* 390.625 MHz Reed Solomon gearbox */
 		/* rx_desk_rsgb_pcs */
-		644531250, /* 644.53125 MHz Reed Solomon gearbox */
+		390625000, /* 390.625 MHz Reed Solomon gearbox */
 		/* tx_fixed_delay */
 		1620,
 		/* pmd_adj_divisor */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 4a1eb6cd699c..6dbb4021fd2f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1003,6 +1003,7 @@ static void cmd_work_handler(struct work_struct *work)
 				complete(&ent->done);
 			}
 			up(&cmd->vars.sem);
+			complete(&ent->slotted);
 			return;
 		}
 	} else {
diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index c2201e0adc46..1659bbffdb91 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -3078,7 +3078,11 @@ static int ca8210_probe(struct spi_device *spi_device)
 	spi_set_drvdata(priv->spi, priv);
 	if (IS_ENABLED(CONFIG_IEEE802154_CA8210_DEBUGFS)) {
 		cascoda_api_upstream = ca8210_test_int_driver_write;
-		ca8210_test_interface_init(priv);
+		ret = ca8210_test_interface_init(priv);
+		if (ret) {
+			dev_crit(&spi_device->dev, "ca8210_test_interface_init failed\n");
+			goto error;
+		}
 	} else {
 		cascoda_api_upstream = NULL;
 	}
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 18498619177c..e93b7b527f61 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -50,7 +50,7 @@ struct of_bus {
 	u64		(*map)(__be32 *addr, const __be32 *range,
 				int na, int ns, int pna);
 	int		(*translate)(__be32 *addr, u64 offset, int na);
-	bool	has_flags;
+	int		flag_cells;
 	unsigned int	(*get_flags)(const __be32 *addr);
 };
 
@@ -95,11 +95,43 @@ static int of_bus_default_translate(__be32 *addr, u64 offset, int na)
 	return 0;
 }
 
+static unsigned int of_bus_default_flags_get_flags(const __be32 *addr)
+{
+	return of_read_number(addr, 1);
+}
+
 static unsigned int of_bus_default_get_flags(const __be32 *addr)
 {
 	return IORESOURCE_MEM;
 }
 
+static u64 of_bus_default_flags_map(__be32 *addr, const __be32 *range, int na,
+				    int ns, int pna)
+{
+	u64 cp, s, da;
+
+	/* Check that flags match */
+	if (*addr != *range)
+		return OF_BAD_ADDR;
+
+	/* Read address values, skipping high cell */
+	cp = of_read_number(range + 1, na - 1);
+	s  = of_read_number(range + na + pna, ns);
+	da = of_read_number(addr + 1, na - 1);
+
+	pr_debug("default flags map, cp=%llx, s=%llx, da=%llx\n", cp, s, da);
+
+	if (da < cp || da >= (cp + s))
+		return OF_BAD_ADDR;
+	return da - cp;
+}
+
+static int of_bus_default_flags_translate(__be32 *addr, u64 offset, int na)
+{
+	/* Keep "flags" part (high cell) in translated address */
+	return of_bus_default_translate(addr + 1, offset, na - 1);
+}
+
 #ifdef CONFIG_PCI
 static unsigned int of_bus_pci_get_flags(const __be32 *addr)
 {
@@ -189,10 +221,6 @@ static u64 of_bus_pci_map(__be32 *addr, const __be32 *range, int na, int ns,
 	return da - cp;
 }
 
-static int of_bus_pci_translate(__be32 *addr, u64 offset, int na)
-{
-	return of_bus_default_translate(addr + 1, offset, na - 1);
-}
 #endif /* CONFIG_PCI */
 
 int of_pci_address_to_resource(struct device_node *dev, int bar,
@@ -302,11 +330,6 @@ static u64 of_bus_isa_map(__be32 *addr, const __be32 *range, int na, int ns,
 	return da - cp;
 }
 
-static int of_bus_isa_translate(__be32 *addr, u64 offset, int na)
-{
-	return of_bus_default_translate(addr + 1, offset, na - 1);
-}
-
 static unsigned int of_bus_isa_get_flags(const __be32 *addr)
 {
 	unsigned int flags = 0;
@@ -319,6 +342,11 @@ static unsigned int of_bus_isa_get_flags(const __be32 *addr)
 	return flags;
 }
 
+static int of_bus_default_flags_match(struct device_node *np)
+{
+	return of_bus_n_addr_cells(np) == 3;
+}
+
 /*
  * Array of bus specific translators
  */
@@ -332,8 +360,8 @@ static struct of_bus of_busses[] = {
 		.match = of_bus_pci_match,
 		.count_cells = of_bus_pci_count_cells,
 		.map = of_bus_pci_map,
-		.translate = of_bus_pci_translate,
-		.has_flags = true,
+		.translate = of_bus_default_flags_translate,
+		.flag_cells = 1,
 		.get_flags = of_bus_pci_get_flags,
 	},
 #endif /* CONFIG_PCI */
@@ -344,10 +372,21 @@ static struct of_bus of_busses[] = {
 		.match = of_bus_isa_match,
 		.count_cells = of_bus_isa_count_cells,
 		.map = of_bus_isa_map,
-		.translate = of_bus_isa_translate,
-		.has_flags = true,
+		.translate = of_bus_default_flags_translate,
+		.flag_cells = 1,
 		.get_flags = of_bus_isa_get_flags,
 	},
+	/* Default with flags cell */
+	{
+		.name = "default-flags",
+		.addresses = "reg",
+		.match = of_bus_default_flags_match,
+		.count_cells = of_bus_default_count_cells,
+		.map = of_bus_default_flags_map,
+		.translate = of_bus_default_flags_translate,
+		.flag_cells = 1,
+		.get_flags = of_bus_default_flags_get_flags,
+	},
 	/* Default */
 	{
 		.name = "default",
@@ -427,7 +466,8 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 	}
 	if (ranges == NULL || rlen == 0) {
 		offset = of_read_number(addr, na);
-		memset(addr, 0, pna * 4);
+		/* set address to zero, pass flags through */
+		memset(addr + pbus->flag_cells, 0, (pna - pbus->flag_cells) * 4);
 		pr_debug("empty ranges; 1:1 translation\n");
 		goto finish;
 	}
@@ -714,7 +754,7 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	int na = parser->na;
 	int ns = parser->ns;
 	int np = parser->pna + na + ns;
-	int busflag_na = 0;
+	int busflag_na = parser->bus->flag_cells;
 
 	if (!range)
 		return NULL;
@@ -724,10 +764,6 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 
 	range->flags = parser->bus->get_flags(parser->range);
 
-	/* A extra cell for resource flags */
-	if (parser->bus->has_flags)
-		busflag_na = 1;
-
 	range->bus_addr = of_read_number(parser->range + busflag_na, na - busflag_na);
 
 	if (parser->dma)
diff --git a/drivers/of/unittest-data/tests-address.dtsi b/drivers/of/unittest-data/tests-address.dtsi
index 6604a52bf6cb..bc0029cbf8ea 100644
--- a/drivers/of/unittest-data/tests-address.dtsi
+++ b/drivers/of/unittest-data/tests-address.dtsi
@@ -14,7 +14,7 @@ address-tests {
 			#size-cells = <1>;
 			/* ranges here is to make sure we don't use it for
 			 * dma-ranges translation */
-			ranges = <0x70000000 0x70000000 0x40000000>,
+			ranges = <0x70000000 0x70000000 0x50000000>,
 				 <0x00000000 0xd0000000 0x20000000>;
 			dma-ranges = <0x0 0x20000000 0x40000000>;
 
@@ -43,6 +43,13 @@ pci@90000000 {
 					     <0x42000000 0x0 0xc0000000 0x20000000 0x0 0x10000000>;
 			};
 
+			bus@a0000000 {
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0xf00baa 0x0 0x0 0xa0000000 0x0 0x100000>,
+					 <0xf00bee 0x1 0x0 0xb0000000 0x0 0x200000>;
+			};
+
 		};
 	};
 };
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index ce1386074e66..598e0891533f 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1019,6 +1019,113 @@ static void __init of_unittest_pci_dma_ranges(void)
 	of_node_put(np);
 }
 
+static void __init of_unittest_bus_ranges(void)
+{
+	struct device_node *np;
+	struct of_range range;
+	struct of_range_parser parser;
+	int i = 0;
+
+	np = of_find_node_by_path("/testcase-data/address-tests");
+	if (!np) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	if (of_range_parser_init(&parser, np)) {
+		pr_err("missing ranges property\n");
+		return;
+	}
+
+	/*
+	 * Get the "ranges" from the device tree
+	 */
+	for_each_of_range(&parser, &range) {
+		unittest(range.flags == IORESOURCE_MEM,
+			"for_each_of_range wrong flags on node %pOF flags=%x (expected %x)\n",
+			np, range.flags, IORESOURCE_MEM);
+		if (!i) {
+			unittest(range.size == 0x50000000,
+				 "for_each_of_range wrong size on node %pOF size=%llx\n",
+				 np, range.size);
+			unittest(range.cpu_addr == 0x70000000,
+				 "for_each_of_range wrong CPU addr (%llx) on node %pOF",
+				 range.cpu_addr, np);
+			unittest(range.bus_addr == 0x70000000,
+				 "for_each_of_range wrong bus addr (%llx) on node %pOF",
+				 range.pci_addr, np);
+		} else {
+			unittest(range.size == 0x20000000,
+				 "for_each_of_range wrong size on node %pOF size=%llx\n",
+				 np, range.size);
+			unittest(range.cpu_addr == 0xd0000000,
+				 "for_each_of_range wrong CPU addr (%llx) on node %pOF",
+				 range.cpu_addr, np);
+			unittest(range.bus_addr == 0x00000000,
+				 "for_each_of_range wrong bus addr (%llx) on node %pOF",
+				 range.pci_addr, np);
+		}
+		i++;
+	}
+
+	of_node_put(np);
+}
+
+static void __init of_unittest_bus_3cell_ranges(void)
+{
+	struct device_node *np;
+	struct of_range range;
+	struct of_range_parser parser;
+	int i = 0;
+
+	np = of_find_node_by_path("/testcase-data/address-tests/bus@a0000000");
+	if (!np) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	if (of_range_parser_init(&parser, np)) {
+		pr_err("missing ranges property\n");
+		return;
+	}
+
+	/*
+	 * Get the "ranges" from the device tree
+	 */
+	for_each_of_range(&parser, &range) {
+		if (!i) {
+			unittest(range.flags == 0xf00baa,
+				 "for_each_of_range wrong flags on node %pOF flags=%x\n",
+				 np, range.flags);
+			unittest(range.size == 0x100000,
+				 "for_each_of_range wrong size on node %pOF size=%llx\n",
+				 np, range.size);
+			unittest(range.cpu_addr == 0xa0000000,
+				 "for_each_of_range wrong CPU addr (%llx) on node %pOF",
+				 range.cpu_addr, np);
+			unittest(range.bus_addr == 0x0,
+				 "for_each_of_range wrong bus addr (%llx) on node %pOF",
+				 range.pci_addr, np);
+		} else {
+			unittest(range.flags == 0xf00bee,
+				 "for_each_of_range wrong flags on node %pOF flags=%x\n",
+				 np, range.flags);
+			unittest(range.size == 0x200000,
+				 "for_each_of_range wrong size on node %pOF size=%llx\n",
+				 np, range.size);
+			unittest(range.cpu_addr == 0xb0000000,
+				 "for_each_of_range wrong CPU addr (%llx) on node %pOF",
+				 range.cpu_addr, np);
+			unittest(range.bus_addr == 0x100000000,
+				 "for_each_of_range wrong bus addr (%llx) on node %pOF",
+				 range.pci_addr, np);
+		}
+		i++;
+	}
+
+	of_node_put(np);
+}
+
 static void __init of_unittest_parse_interrupts(void)
 {
 	struct device_node *np;
@@ -3521,6 +3628,8 @@ static int __init of_unittest(void)
 	of_unittest_dma_get_max_cpu_address();
 	of_unittest_parse_dma_ranges();
 	of_unittest_pci_dma_ranges();
+	of_unittest_bus_ranges();
+	of_unittest_bus_3cell_ranges();
 	of_unittest_match_node();
 	of_unittest_platform_populate();
 	of_unittest_overlay();
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index d58d99d8375e..b40609b92980 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -158,7 +158,7 @@ static int ad9832_write_frequency(struct ad9832_state *st,
 static int ad9832_write_phase(struct ad9832_state *st,
 			      unsigned long addr, unsigned long phase)
 {
-	if (phase > BIT(AD9832_PHASE_BITS))
+	if (phase >= BIT(AD9832_PHASE_BITS))
 		return -EINVAL;
 
 	st->phase_data[0] = cpu_to_be16((AD9832_CMD_PHA8BITSW << CMD_SHIFT) |
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 89abb0709260..f66688ee7f4a 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -131,7 +131,7 @@ static int ad9834_write_frequency(struct ad9834_state *st,
 static int ad9834_write_phase(struct ad9834_state *st,
 			      unsigned long addr, unsigned long phase)
 {
-	if (phase > BIT(AD9834_PHASE_BITS))
+	if (phase >= BIT(AD9834_PHASE_BITS))
 		return -EINVAL;
 	st->data = cpu_to_be16(addr | phase);
 
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 07476147559a..95939df314d1 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -315,6 +315,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 				goto out;
 			}
 
+			of_node_put(sensor_specs.np);
 			if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
 								  sensor_specs.args[0] : 0)) {
 				pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, child);
diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index f27b4aecff3d..759f567538e2 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -1337,11 +1337,12 @@ static int usblp_set_protocol(struct usblp *usblp, int protocol)
 	if (protocol < USBLP_FIRST_PROTOCOL || protocol > USBLP_LAST_PROTOCOL)
 		return -EINVAL;
 
+	alts = usblp->protocol[protocol].alt_setting;
+	if (alts < 0)
+		return -EINVAL;
+
 	/* Don't unnecessarily set the interface if there's a single alt. */
 	if (usblp->intf->num_altsetting > 1) {
-		alts = usblp->protocol[protocol].alt_setting;
-		if (alts < 0)
-			return -EINVAL;
 		r = usb_set_interface(usblp->dev, usblp->ifnum, alts);
 		if (r < 0) {
 			printk(KERN_ERR "usblp: can't set desired altsetting %d on interface %d\n",
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 50a5608c204f..02922d923b7b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2632,13 +2632,13 @@ int usb_new_device(struct usb_device *udev)
 		err = sysfs_create_link(&udev->dev.kobj,
 				&port_dev->dev.kobj, "port");
 		if (err)
-			goto fail;
+			goto out_del_dev;
 
 		err = sysfs_create_link(&port_dev->dev.kobj,
 				&udev->dev.kobj, "device");
 		if (err) {
 			sysfs_remove_link(&udev->dev.kobj, "port");
-			goto fail;
+			goto out_del_dev;
 		}
 
 		if (!test_and_set_bit(port1, hub->child_usage_bits))
@@ -2650,6 +2650,8 @@ int usb_new_device(struct usb_device *udev)
 	pm_runtime_put_sync_autosuspend(&udev->dev);
 	return err;
 
+out_del_dev:
+	device_del(&udev->dev);
 fail:
 	usb_set_device_state(udev, USB_STATE_NOTATTACHED);
 	pm_runtime_disable(&udev->dev);
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 0007031fad0d..0c97f15adfc8 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -412,10 +412,11 @@ static int usb_port_runtime_suspend(struct device *dev)
 static void usb_port_shutdown(struct device *dev)
 {
 	struct usb_port *port_dev = to_usb_port(dev);
+	struct usb_device *udev = port_dev->child;
 
-	if (port_dev->child) {
-		usb_disable_usb2_hardware_lpm(port_dev->child);
-		usb_unlocked_disable_lpm(port_dev->child);
+	if (udev && !udev->port_is_suspended) {
+		usb_disable_usb2_hardware_lpm(udev);
+		usb_unlocked_disable_lpm(udev);
 	}
 }
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5a7a86273883..77aa59de8514 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -447,6 +447,7 @@
 #define DWC3_DCTL_TRGTULST_SS_INACT	(DWC3_DCTL_TRGTULST(6))
 
 /* These apply for core versions 1.94a and later */
+#define DWC3_DCTL_NYET_THRES_MASK	(0xf << 20)
 #define DWC3_DCTL_NYET_THRES(n)		(((n) & 0xf) << 20)
 
 #define DWC3_DCTL_KEEP_CONNECT		BIT(19)
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index ad8a2eadb472..ed3e27f3cd61 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -263,6 +263,7 @@ static int dwc3_ti_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_set_suspended(dev);
 
 	platform_set_drvdata(pdev, NULL);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 90ad996fed69..489493a0adee 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4056,8 +4056,10 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		WARN_ONCE(DWC3_VER_IS_PRIOR(DWC3, 240A) && dwc->has_lpm_erratum,
 				"LPM Erratum not available on dwc3 revisions < 2.40a\n");
 
-		if (dwc->has_lpm_erratum && !DWC3_VER_IS_PRIOR(DWC3, 240A))
+		if (dwc->has_lpm_erratum && !DWC3_VER_IS_PRIOR(DWC3, 240A)) {
+			reg &= ~DWC3_DCTL_NYET_THRES_MASK;
 			reg |= DWC3_DCTL_NYET_THRES(dwc->lpm_nyet_threshold);
+		}
 
 		dwc3_gadget_dctl_write_safe(dwc, reg);
 	} else {
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 698bf24ba44c..e68425db9a6a 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1868,7 +1868,7 @@ static int functionfs_bind(struct ffs_data *ffs, struct usb_composite_dev *cdev)
 
 	ENTER();
 
-	if (WARN_ON(ffs->state != FFS_ACTIVE
+	if ((ffs->state != FFS_ACTIVE
 		 || test_and_set_bit(FFS_FL_BOUND, &ffs->flags)))
 		return -EBADFD;
 
diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index b3dc5f5164f4..eabd10817e1e 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -1176,6 +1176,7 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 		uac2->as_in_alt = 0;
 	}
 
+	std_ac_if_desc.bNumEndpoints = 0;
 	if (FUOUT_EN(uac2_opts) || FUIN_EN(uac2_opts)) {
 		uac2->int_ep = usb_ep_autoconfig(gadget, &fs_ep_int_desc);
 		if (!uac2->int_ep) {
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 8802dd53fbea..35f1b8a0b506 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1393,6 +1393,10 @@ void gserial_disconnect(struct gserial *gser)
 	/* REVISIT as above: how best to track this? */
 	port->port_line_coding = gser->port_line_coding;
 
+	/* disable endpoints, aborting down any active I/O */
+	usb_ep_disable(gser->out);
+	usb_ep_disable(gser->in);
+
 	port->port_usb = NULL;
 	gser->ioport = NULL;
 	if (port->port.count > 0) {
@@ -1404,10 +1408,6 @@ void gserial_disconnect(struct gserial *gser)
 	spin_unlock(&port->port_lock);
 	spin_unlock_irqrestore(&serial_port_lock, flags);
 
-	/* disable endpoints, aborting down any active I/O */
-	usb_ep_disable(gser->out);
-	usb_ep_disable(gser->in);
-
 	/* finally, free any unused/unusable I/O buffers */
 	spin_lock_irqsave(&port->port_lock, flags);
 	if (port->port.count == 0)
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 2ff049e02326..1d71e8ef9919 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -571,7 +571,6 @@ static void xhci_pci_remove(struct pci_dev *dev)
 		pci_set_power_state(dev, PCI_D3hot);
 }
 
-#ifdef CONFIG_PM
 /*
  * In some Intel xHCI controllers, in order to get D3 working,
  * through a vendor specific SSIC CONFIG register at offset 0x883c,
@@ -721,7 +720,6 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
 	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
 		pci_set_power_state(pdev, PCI_D3hot);
 }
-#endif /* CONFIG_PM */
 
 /*-------------------------------------------------------------------------*/
 
@@ -763,21 +761,17 @@ static struct pci_driver xhci_pci_driver = {
 	/* suspend and resume implemented later */
 
 	.shutdown = 	usb_hcd_pci_shutdown,
-#ifdef CONFIG_PM
 	.driver = {
-		.pm = &usb_hcd_pci_pm_ops
+		.pm = pm_ptr(&usb_hcd_pci_pm_ops),
 	},
-#endif
 };
 
 static int __init xhci_pci_init(void)
 {
 	xhci_init_driver(&xhci_pci_hc_driver, &xhci_pci_overrides);
-#ifdef CONFIG_PM
 	xhci_pci_hc_driver.pci_suspend = xhci_pci_suspend;
 	xhci_pci_hc_driver.pci_resume = xhci_pci_resume;
 	xhci_pci_hc_driver.shutdown = xhci_pci_shutdown;
-#endif
 	return pci_register_driver(&xhci_pci_driver);
 }
 module_init(xhci_pci_init);
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index aa30288c8a8e..c869cddb5471 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -223,6 +223,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x19CF, 0x3000) }, /* Parrot NMEA GPS Flight Recorder */
 	{ USB_DEVICE(0x1ADB, 0x0001) }, /* Schweitzer Engineering C662 Cable */
 	{ USB_DEVICE(0x1B1C, 0x1C00) }, /* Corsair USB Dongle */
+	{ USB_DEVICE(0x1B93, 0x1013) }, /* Phoenix Contact UPS Device */
 	{ USB_DEVICE(0x1BA4, 0x0002) },	/* Silicon Labs 358x factory default */
 	{ USB_DEVICE(0x1BE3, 0x07A6) }, /* WAGO 750-923 USB Service Cable */
 	{ USB_DEVICE(0x1D6F, 0x0010) }, /* Seluxit ApS RF Dongle */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 6d80ed3cc540..89e6a9afb808 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -621,7 +621,7 @@ static void option_instat_callback(struct urb *urb);
 
 /* MeiG Smart Technology products */
 #define MEIGSMART_VENDOR_ID			0x2dee
-/* MeiG Smart SRM825L based on Qualcomm 315 */
+/* MeiG Smart SRM815/SRM825L based on Qualcomm 315 */
 #define MEIGSMART_PRODUCT_SRM825L		0x4d22
 /* MeiG Smart SLM320 based on UNISOC UIS8910 */
 #define MEIGSMART_PRODUCT_SLM320		0x4d41
@@ -2405,6 +2405,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM320, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM770A, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x60) },
@@ -2412,6 +2413,7 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0640, 0xff),			/* TCL IK512 ECM */
 	  .driver_info = NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x2949, 0x8700, 0xff) },			/* Neoway N723-EA */
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index e5ad23d86833..54f0b1c83317 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -255,6 +255,13 @@ UNUSUAL_DEV(  0x0421, 0x06aa, 0x1110, 0x1110,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_MAX_SECTORS_64 ),
 
+/* Added by Lubomir Rintel <lkundrak@v3.sk>, a very fine chap */
+UNUSUAL_DEV(  0x0421, 0x06c2, 0x0000, 0x0406,
+		"Nokia",
+		"Nokia 208",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_MAX_SECTORS_64 ),
+
 #ifdef NO_SDDR09
 UNUSUAL_DEV(  0x0436, 0x0005, 0x0100, 0x0100,
 		"Microtech",
diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index 432cb4b23961..3ea5f3e3c922 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -10,7 +10,7 @@
 
 #include <linux/in.h>
 
-#define AFS_MAXCELLNAME		256  	/* Maximum length of a cell name */
+#define AFS_MAXCELLNAME		253  	/* Maximum length of a cell name (DNS limited) */
 #define AFS_MAXVOLNAME		64  	/* Maximum length of a volume name */
 #define AFS_MAXNSERVERS		8   	/* Maximum servers in a basic volume record */
 #define AFS_NMAXNSERVERS	13  	/* Maximum servers in a N/U-class volume record */
diff --git a/fs/afs/afs_vl.h b/fs/afs/afs_vl.h
index 9c65ffb8a523..8da0899fbc08 100644
--- a/fs/afs/afs_vl.h
+++ b/fs/afs/afs_vl.h
@@ -13,6 +13,7 @@
 #define AFS_VL_PORT		7003	/* volume location service port */
 #define VL_SERVICE		52	/* RxRPC service ID for the Volume Location service */
 #define YFS_VL_SERVICE		2503	/* Service ID for AuriStor upgraded VL service */
+#define YFS_VL_MAXCELLNAME	256  	/* Maximum length of a cell name in YFS protocol */
 
 enum AFSVL_Operations {
 	VLGETENTRYBYID		= 503,	/* AFS Get VLDB entry by ID */
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index f04a80e4f5c3..83cf1bfbe343 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -302,6 +302,7 @@ static char *afs_vl_get_cell_name(struct afs_cell *cell, struct key *key)
 static int yfs_check_canonical_cell_name(struct afs_cell *cell, struct key *key)
 {
 	struct afs_cell *master;
+	size_t name_len;
 	char *cell_name;
 
 	cell_name = afs_vl_get_cell_name(cell, key);
@@ -313,8 +314,11 @@ static int yfs_check_canonical_cell_name(struct afs_cell *cell, struct key *key)
 		return 0;
 	}
 
-	master = afs_lookup_cell(cell->net, cell_name, strlen(cell_name),
-				 NULL, false);
+	name_len = strlen(cell_name);
+	if (!name_len || name_len > AFS_MAXCELLNAME)
+		master = ERR_PTR(-EOPNOTSUPP);
+	else
+		master = afs_lookup_cell(cell->net, cell_name, name_len, NULL, false);
 	kfree(cell_name);
 	if (IS_ERR(master))
 		return PTR_ERR(master);
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index 00fca3c66ba6..16653f2ffe4f 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -671,7 +671,7 @@ static int afs_deliver_yfsvl_get_cell_name(struct afs_call *call)
 			return ret;
 
 		namesz = ntohl(call->tmp);
-		if (namesz > AFS_MAXCELLNAME)
+		if (namesz > YFS_VL_MAXCELLNAME)
 			return afs_protocol_error(call, afs_eproto_cellname_len);
 		paddedsz = (namesz + 3) & ~3;
 		call->count = namesz;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index da9fcf48ab6c..741ca7d10032 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2447,12 +2447,11 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 
 	if (pos < 0) {
 		/*
-		 * A rename didn't occur, but somehow we didn't end up where
-		 * we thought we would. Throw a warning and try again.
+		 * The path is longer than PATH_MAX and this function
+		 * cannot ever succeed.  Creating paths that long is
+		 * possible with Ceph, but Linux cannot use them.
 		 */
-		pr_warn("build_path did not end path lookup where "
-			"expected, pos is %d\n", pos);
-		goto retry;
+		return ERR_PTR(-ENAMETOOLONG);
 	}
 
 	*pbase = base;
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index d58c69018051..e651ffb06a43 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -125,7 +125,7 @@ static int exfat_readdir(struct inode *inode, loff_t *cpos, struct exfat_dir_ent
 			type = exfat_get_entry_type(ep);
 			if (type == TYPE_UNUSED) {
 				brelse(bh);
-				break;
+				goto out;
 			}
 
 			if (type != TYPE_FILE && type != TYPE_DIR) {
@@ -185,6 +185,7 @@ static int exfat_readdir(struct inode *inode, loff_t *cpos, struct exfat_dir_ent
 		}
 	}
 
+out:
 	dir_entry->namebuf.lfn[0] = '\0';
 	*cpos = EXFAT_DEN_TO_B(dentry);
 	return 0;
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 41ae4cce1f42..fe007ae2f23c 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -216,6 +216,16 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 
 			if (err)
 				goto dec_used_clus;
+
+			if (num_clusters >= sbi->num_clusters - EXFAT_FIRST_CLUSTER) {
+				/*
+				 * The cluster chain includes a loop, scan the
+				 * bitmap to get the number of used clusters.
+				 */
+				exfat_count_used_clusters(sb, &sbi->used_clusters);
+
+				return 0;
+			}
 		} while (clu != EXFAT_EOF_CLUSTER);
 	}
 
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 7b34deec8b87..6d02dcad8ffd 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -811,9 +811,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	/*
 	 * If the journal is not located on the file system device,
 	 * then we must flush the file system device before we issue
-	 * the commit record
+	 * the commit record and update the journal tail sequence.
 	 */
-	if (commit_transaction->t_need_data_flush &&
+	if ((commit_transaction->t_need_data_flush || update_tail) &&
 	    (journal->j_fs_dev != journal->j_dev) &&
 	    (journal->j_flags & JBD2_BARRIER))
 		blkdev_issue_flush(journal->j_fs_dev);
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 4556e4689024..ce63d5fde9c3 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -654,7 +654,7 @@ static void flush_descriptor(journal_t *journal,
 	set_buffer_jwrite(descriptor);
 	BUFFER_TRACE(descriptor, "write");
 	set_buffer_dirty(descriptor);
-	write_dirty_buffer(descriptor, REQ_SYNC);
+	write_dirty_buffer(descriptor, JBD2_JOURNAL_REQ_FLAGS);
 }
 #endif
 
diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index dc9f76ab7e13..0dffd6a44d39 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -881,7 +881,7 @@ static int ocfs2_get_next_id(struct super_block *sb, struct kqid *qid)
 	int status = 0;
 
 	trace_ocfs2_get_next_id(from_kqid(&init_user_ns, *qid), type);
-	if (!sb_has_quota_loaded(sb, type)) {
+	if (!sb_has_quota_active(sb, type)) {
 		status = -ESRCH;
 		goto out;
 	}
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 404ca3a62508..4b4fa58cd32f 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -815,7 +815,7 @@ static int ocfs2_local_free_info(struct super_block *sb, int type)
 	struct ocfs2_quota_chunk *chunk;
 	struct ocfs2_local_disk_chunk *dchunk;
 	int mark_clean = 1, len;
-	int status;
+	int status = 0;
 
 	iput(oinfo->dqi_gqinode);
 	ocfs2_simple_drop_lockres(OCFS2_SB(sb), &oinfo->dqi_gqlock);
@@ -857,17 +857,15 @@ static int ocfs2_local_free_info(struct super_block *sb, int type)
 				 oinfo->dqi_libh,
 				 olq_update_info,
 				 info);
-	if (status < 0) {
+	if (status < 0)
 		mlog_errno(status);
-		goto out;
-	}
-
 out:
 	ocfs2_inode_unlock(sb_dqopt(sb)->files[type], 1);
 	brelse(oinfo->dqi_libh);
 	brelse(oinfo->dqi_lqi_bh);
 	kfree(oinfo);
-	return 0;
+	info->dqi_priv = NULL;
+	return status;
 }
 
 static void olq_set_dquot(struct buffer_head *bh, void *private)
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 71478a590e83..9d041fc558e3 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -712,6 +712,9 @@ void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
 	struct smb2_hdr *rsp_hdr;
 	struct ksmbd_work *in_work = ksmbd_alloc_work_struct();
 
+	if (!in_work)
+		return;
+
 	if (allocate_interim_rsp_buf(in_work)) {
 		pr_err("smb_allocate_rsp_buf failed!\n");
 		ksmbd_free_work_struct(in_work);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index eaae67a2f720..396d4ea77d34 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1249,6 +1249,8 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 					      filepath,
 					      flags,
 					      path);
+			if (!is_last)
+				next[0] = '/';
 			if (err)
 				goto out2;
 			else if (is_last)
@@ -1256,7 +1258,6 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 			path_put(parent_path);
 			*parent_path = *path;
 
-			next[0] = '/';
 			remain_len -= filename_len + 1;
 		}
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7f4ce183dcb0..2189c0d18fa7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -464,6 +464,7 @@ enum bpf_type_flag {
 	 */
 	PTR_UNTRUSTED		= BIT(6 + BPF_BASE_TYPE_BITS),
 
+	/* MEM can be uninitialized. */
 	MEM_UNINIT		= BIT(7 + BPF_BASE_TYPE_BITS),
 
 	/* DYNPTR points to memory local to the bpf program. */
@@ -480,6 +481,13 @@ enum bpf_type_flag {
 	 */
 	MEM_ALIGNED		= BIT(17 + BPF_BASE_TYPE_BITS),
 
+	/* MEM is being written to, often combined with MEM_UNINIT. Non-presence
+	 * of MEM_WRITE means that MEM is only being read. MEM_WRITE without the
+	 * MEM_UNINIT means that memory needs to be initialized since it is also
+	 * read.
+	 */
+	MEM_WRITE		= BIT(18 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -537,10 +545,10 @@ enum bpf_arg_type {
 	ARG_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_ALLOC_MEM,
 	ARG_PTR_TO_STACK_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
 	ARG_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
-	/* pointer to memory does not need to be initialized, helper function must fill
-	 * all bytes or clear them in error case.
+	/* Pointer to memory does not need to be initialized, since helper function
+	 * fills all bytes or clears them in error case.
 	 */
-	ARG_PTR_TO_UNINIT_MEM		= MEM_UNINIT | ARG_PTR_TO_MEM,
+	ARG_PTR_TO_UNINIT_MEM		= MEM_UNINIT | MEM_WRITE | ARG_PTR_TO_MEM,
 	/* Pointer to valid memory of size known at compile time. */
 	ARG_PTR_TO_FIXED_SIZE_MEM	= MEM_FIXED_SIZE | ARG_PTR_TO_MEM,
 
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index f158b025c175..d2117e1c8fa5 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -8,6 +8,7 @@
 
 #include <linux/sched.h>
 #include <linux/magic.h>
+#include <linux/kasan.h>
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 
@@ -88,6 +89,7 @@ static inline int object_is_on_stack(const void *obj)
 {
 	void *stack = task_stack_page(current);
 
+	obj = kasan_reset_tag(obj);
 	return (obj >= stack) && (obj < (stack + THREAD_SIZE));
 }
 
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 3ce7b052a19f..1326dded358f 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -697,13 +697,12 @@ struct usb_device {
 
 	unsigned long active_duration;
 
-#ifdef CONFIG_PM
 	unsigned long connect_time;
 
 	unsigned do_remote_wakeup:1;
 	unsigned reset_resume:1;
 	unsigned port_is_suspended:1;
-#endif
+
 	struct wusb_dev *wusb_dev;
 	int slot_id;
 	struct usb2_lpm_parameters l1_params;
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index cd667acf6267..575716d3672a 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -486,9 +486,7 @@ extern void usb_hcd_pci_shutdown(struct pci_dev *dev);
 
 extern int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *dev);
 
-#ifdef CONFIG_PM
 extern const struct dev_pm_ops usb_hcd_pci_pm_ops;
-#endif
 #endif /* CONFIG_USB_PCI */
 
 /* pci-ish (pdev null is ok) buffer alloc/mapping support */
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 4242f863f560..7649d4901f0c 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -281,7 +281,7 @@ static inline int inet_csk_reqsk_queue_len(const struct sock *sk)
 
 static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
 {
-	return inet_csk_reqsk_queue_len(sk) >= sk->sk_max_ack_backlog;
+	return inet_csk_reqsk_queue_len(sk) > READ_ONCE(sk->sk_max_ack_backlog);
 }
 
 bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req);
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 9b58ba4616d4..480752fc3eb6 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -479,6 +479,13 @@ static __cold void io_queue_deferred(struct io_ring_ctx *ctx)
 	}
 }
 
+static void io_eventfd_free(struct rcu_head *rcu)
+{
+	struct io_ev_fd *ev_fd = container_of(rcu, struct io_ev_fd, rcu);
+
+	eventfd_ctx_put(ev_fd->cq_ev_fd);
+	kfree(ev_fd);
+}
 
 static void io_eventfd_ops(struct rcu_head *rcu)
 {
@@ -492,10 +499,8 @@ static void io_eventfd_ops(struct rcu_head *rcu)
 	 * ordering in a race but if references are 0 we know we have to free
 	 * it regardless.
 	 */
-	if (atomic_dec_and_test(&ev_fd->refs)) {
-		eventfd_ctx_put(ev_fd->cq_ev_fd);
-		kfree(ev_fd);
-	}
+	if (atomic_dec_and_test(&ev_fd->refs))
+		call_rcu(&ev_fd->rcu, io_eventfd_free);
 }
 
 static void io_eventfd_signal(struct io_ring_ctx *ctx)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 14ad6856257c..4fef0a015525 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -107,7 +107,7 @@ const struct bpf_func_proto bpf_map_pop_elem_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_PTR_TO_MAP_VALUE | MEM_UNINIT,
+	.arg2_type	= ARG_PTR_TO_MAP_VALUE | MEM_UNINIT | MEM_WRITE,
 };
 
 BPF_CALL_2(bpf_map_peek_elem, struct bpf_map *, map, void *, value)
@@ -120,7 +120,7 @@ const struct bpf_func_proto bpf_map_peek_elem_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_PTR_TO_MAP_VALUE | MEM_UNINIT,
+	.arg2_type	= ARG_PTR_TO_MAP_VALUE | MEM_UNINIT | MEM_WRITE,
 };
 
 BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, key, u32, cpu)
@@ -531,7 +531,7 @@ const struct bpf_func_proto bpf_strtol_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg4_size	= sizeof(s64),
 };
 
@@ -561,7 +561,7 @@ const struct bpf_func_proto bpf_strtoul_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg4_size	= sizeof(u64),
 };
 
@@ -1502,7 +1502,7 @@ static const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
+	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT | MEM_WRITE,
 };
 
 BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, struct bpf_dynptr_kern *, src,
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index af75c54eb84f..095416e40df3 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -618,7 +618,7 @@ const struct bpf_func_proto bpf_ringbuf_reserve_dynptr_proto = {
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | MEM_UNINIT,
+	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | MEM_UNINIT | MEM_WRITE,
 };
 
 BPF_CALL_2(bpf_ringbuf_submit_dynptr, struct bpf_dynptr_kern *, ptr, u64, flags)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6455f80099cd..cfb361f4b00e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5265,7 +5265,7 @@ static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg4_size	= sizeof(u64),
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bdd5105337dc..ead1811534a0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5416,7 +5416,8 @@ static int check_stack_range_initialized(
 }
 
 static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
-				   int access_size, bool zero_size_allowed,
+				   int access_size, enum bpf_access_type access_type,
+				   bool zero_size_allowed,
 				   struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
@@ -5428,7 +5429,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		return check_packet_access(env, regno, reg->off, access_size,
 					   zero_size_allowed);
 	case PTR_TO_MAP_KEY:
-		if (meta && meta->raw_mode) {
+		if (access_type == BPF_WRITE) {
 			verbose(env, "R%d cannot write into %s\n", regno,
 				reg_type_str(env, reg->type));
 			return -EACCES;
@@ -5436,15 +5437,13 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		return check_mem_region_access(env, regno, reg->off, access_size,
 					       reg->map_ptr->key_size, false);
 	case PTR_TO_MAP_VALUE:
-		if (check_map_access_type(env, regno, reg->off, access_size,
-					  meta && meta->raw_mode ? BPF_WRITE :
-					  BPF_READ))
+		if (check_map_access_type(env, regno, reg->off, access_size, access_type))
 			return -EACCES;
 		return check_map_access(env, regno, reg->off, access_size,
 					zero_size_allowed, ACCESS_HELPER);
 	case PTR_TO_MEM:
 		if (type_is_rdonly_mem(reg->type)) {
-			if (meta && meta->raw_mode) {
+			if (access_type == BPF_WRITE) {
 				verbose(env, "R%d cannot write into %s\n", regno,
 					reg_type_str(env, reg->type));
 				return -EACCES;
@@ -5455,7 +5454,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 					       zero_size_allowed);
 	case PTR_TO_BUF:
 		if (type_is_rdonly_mem(reg->type)) {
-			if (meta && meta->raw_mode) {
+			if (access_type == BPF_WRITE) {
 				verbose(env, "R%d cannot write into %s\n", regno,
 					reg_type_str(env, reg->type));
 				return -EACCES;
@@ -5480,7 +5479,6 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		 * Dynamically check it now.
 		 */
 		if (!env->ops->convert_ctx_access) {
-			enum bpf_access_type atype = meta && meta->raw_mode ? BPF_WRITE : BPF_READ;
 			int offset = access_size - 1;
 
 			/* Allow zero-byte read from PTR_TO_CTX */
@@ -5488,7 +5486,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 				return zero_size_allowed ? 0 : -EACCES;
 
 			return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
-						atype, -1, false);
+						access_type, -1, false);
 		}
 
 		fallthrough;
@@ -5507,6 +5505,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 
 static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg, u32 regno,
+			      enum bpf_access_type access_type,
 			      bool zero_size_allowed,
 			      struct bpf_call_arg_meta *meta)
 {
@@ -5522,15 +5521,12 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 */
 	meta->msize_max_value = reg->umax_value;
 
-	/* The register is SCALAR_VALUE; the access check
-	 * happens using its boundaries.
+	/* The register is SCALAR_VALUE; the access check happens using
+	 * its boundaries. For unprivileged variable accesses, disable
+	 * raw mode so that the program is required to initialize all
+	 * the memory that the helper could just partially fill up.
 	 */
 	if (!tnum_is_const(reg->var_off))
-		/* For unprivileged variable accesses, disable raw
-		 * mode so that the program is required to
-		 * initialize all the memory that the helper could
-		 * just partially fill up.
-		 */
 		meta = NULL;
 
 	if (reg->smin_value < 0) {
@@ -5541,8 +5537,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 
 	if (reg->umin_value == 0) {
 		err = check_helper_mem_access(env, regno - 1, 0,
-					      zero_size_allowed,
-					      meta);
+				      access_type, zero_size_allowed, meta);
 		if (err)
 			return err;
 	}
@@ -5552,9 +5547,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 			regno);
 		return -EACCES;
 	}
-	err = check_helper_mem_access(env, regno - 1,
-				      reg->umax_value,
-				      zero_size_allowed, meta);
+	err = check_helper_mem_access(env, regno - 1, reg->umax_value,
+				      access_type, zero_size_allowed, meta);
 	if (!err)
 		err = mark_chain_precision(env, regno);
 	return err;
@@ -5565,13 +5559,11 @@ int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 {
 	bool may_be_null = type_may_be_null(reg->type);
 	struct bpf_reg_state saved_reg;
-	struct bpf_call_arg_meta meta;
 	int err;
 
 	if (register_is_null(reg))
 		return 0;
 
-	memset(&meta, 0, sizeof(meta));
 	/* Assuming that the register contains a value check if the memory
 	 * access is safe. Temporarily save and restore the register's state as
 	 * the conversion shouldn't be visible to a caller.
@@ -5581,10 +5573,8 @@ int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		mark_ptr_not_null_reg(reg);
 	}
 
-	err = check_helper_mem_access(env, regno, mem_size, true, &meta);
-	/* Check access for BPF_WRITE */
-	meta.raw_mode = true;
-	err = err ?: check_helper_mem_access(env, regno, mem_size, true, &meta);
+	err = check_helper_mem_access(env, regno, mem_size, BPF_READ, true, NULL);
+	err = err ?: check_helper_mem_access(env, regno, mem_size, BPF_WRITE, true, NULL);
 
 	if (may_be_null)
 		*reg = saved_reg;
@@ -5610,13 +5600,12 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
 		mark_ptr_not_null_reg(mem_reg);
 	}
 
-	err = check_mem_size_reg(env, reg, regno, true, &meta);
-	/* Check access for BPF_WRITE */
-	meta.raw_mode = true;
-	err = err ?: check_mem_size_reg(env, reg, regno, true, &meta);
+	err = check_mem_size_reg(env, reg, regno, BPF_READ, true, &meta);
+	err = err ?: check_mem_size_reg(env, reg, regno, BPF_WRITE, true, &meta);
 
 	if (may_be_null)
 		*mem_reg = saved_reg;
+
 	return err;
 }
 
@@ -6227,9 +6216,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verbose(env, "invalid map_ptr to access map->key\n");
 			return -EACCES;
 		}
-		err = check_helper_mem_access(env, regno,
-					      meta->map_ptr->key_size, false,
-					      NULL);
+		err = check_helper_mem_access(env, regno, meta->map_ptr->key_size,
+					      BPF_READ, false, NULL);
 		break;
 	case ARG_PTR_TO_MAP_VALUE:
 		if (type_may_be_null(arg_type) && register_is_null(reg))
@@ -6244,9 +6232,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		meta->raw_mode = arg_type & MEM_UNINIT;
-		err = check_helper_mem_access(env, regno,
-					      meta->map_ptr->value_size, false,
-					      meta);
+		err = check_helper_mem_access(env, regno, meta->map_ptr->value_size,
+					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
+					      false, meta);
 		break;
 	case ARG_PTR_TO_PERCPU_BTF_ID:
 		if (!reg->btf_id) {
@@ -6281,7 +6269,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 */
 		meta->raw_mode = arg_type & MEM_UNINIT;
 		if (arg_type & MEM_FIXED_SIZE) {
-			err = check_helper_mem_access(env, regno, fn->arg_size[arg], false, meta);
+			err = check_helper_mem_access(env, regno, fn->arg_size[arg],
+						      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
+						      false, meta);
 			if (err)
 				return err;
 			if (arg_type & MEM_ALIGNED)
@@ -6289,10 +6279,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_CONST_SIZE:
-		err = check_mem_size_reg(env, reg, regno, false, meta);
+		err = check_mem_size_reg(env, reg, regno,
+					 fn->arg_type[arg - 1] & MEM_WRITE ?
+					 BPF_WRITE : BPF_READ,
+					 false, meta);
 		break;
 	case ARG_CONST_SIZE_OR_ZERO:
-		err = check_mem_size_reg(env, reg, regno, true, meta);
+		err = check_mem_size_reg(env, reg, regno,
+					 fn->arg_type[arg - 1] & MEM_WRITE ?
+					 BPF_WRITE : BPF_READ,
+					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
 		/* We only need to check for initialized / uninitialized helper
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e7b7be074e5a..f46903c1142b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1192,7 +1192,7 @@ static const struct bpf_func_proto bpf_get_func_arg_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg3_size	= sizeof(u64),
 };
 
@@ -1209,7 +1209,7 @@ static const struct bpf_func_proto bpf_get_func_ret_proto = {
 	.func		= get_func_ret,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg2_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg2_size	= sizeof(u64),
 };
 
diff --git a/net/802/psnap.c b/net/802/psnap.c
index 1406bfdbda13..dbd9647f2ef1 100644
--- a/net/802/psnap.c
+++ b/net/802/psnap.c
@@ -55,11 +55,11 @@ static int snap_rcv(struct sk_buff *skb, struct net_device *dev,
 		goto drop;
 
 	rcu_read_lock();
-	proto = find_snap_client(skb_transport_header(skb));
+	proto = find_snap_client(skb->data);
 	if (proto) {
 		/* Pass the frame on. */
-		skb->transport_header += 5;
 		skb_pull_rcsum(skb, 5);
+		skb_reset_transport_header(skb);
 		rc = proto->rcvfunc(skb, dev, &snap_packet_type, orig_dev);
 	}
 	rcu_read_unlock();
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b7a7b2afaa04..c6108e68f5a9 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1006,9 +1006,9 @@ static bool adv_use_rpa(struct hci_dev *hdev, uint32_t flags)
 
 static int hci_set_random_addr_sync(struct hci_dev *hdev, bdaddr_t *rpa)
 {
-	/* If we're advertising or initiating an LE connection we can't
-	 * go ahead and change the random address at this time. This is
-	 * because the eventual initiator address used for the
+	/* If a random_addr has been set we're advertising or initiating an LE
+	 * connection we can't go ahead and change the random address at this
+	 * time. This is because the eventual initiator address used for the
 	 * subsequently created connection will be undefined (some
 	 * controllers use the new address and others the one we had
 	 * when the operation started).
@@ -1016,8 +1016,9 @@ static int hci_set_random_addr_sync(struct hci_dev *hdev, bdaddr_t *rpa)
 	 * In this kind of scenario skip the update and let the random
 	 * address be updated at the next cycle.
 	 */
-	if (hci_dev_test_flag(hdev, HCI_LE_ADV) ||
-	    hci_lookup_le_connect(hdev)) {
+	if (bacmp(&hdev->random_addr, BDADDR_ANY) &&
+	    (hci_dev_test_flag(hdev, HCI_LE_ADV) ||
+	    hci_lookup_le_connect(hdev))) {
 		bt_dev_dbg(hdev, "Deferring random address update");
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 		return 0;
diff --git a/net/core/filter.c b/net/core/filter.c
index cf87e29a5e8f..7f9d703b00e7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6243,7 +6243,7 @@ static const struct bpf_func_proto bpf_skb_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
@@ -6255,7 +6255,7 @@ static const struct bpf_func_proto bpf_xdp_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index e674a686ff71..f4cca477b047 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -411,15 +411,15 @@ static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
 static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 			     struct sock **psk)
 {
-	struct sock *sk;
+	struct sock *sk = NULL;
 	int err = 0;
 
 	if (irqs_disabled())
 		return -EOPNOTSUPP; /* locks here are hardirq-unsafe */
 
 	raw_spin_lock_bh(&stab->lock);
-	sk = *psk;
-	if (!sk_test || sk_test == sk)
+
+	if (!sk_test || sk_test == *psk)
 		sk = xchg(psk, NULL);
 
 	if (likely(sk))
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 984435cb1013..805b1a9eca1c 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -832,7 +832,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 	sock_net_set(ctl_sk, net);
 	if (sk) {
 		ctl_sk->sk_mark = (sk->sk_state == TCP_TIME_WAIT) ?
-				   inet_twsk(sk)->tw_mark : sk->sk_mark;
+				   inet_twsk(sk)->tw_mark : READ_ONCE(sk->sk_mark);
 		ctl_sk->sk_priority = (sk->sk_state == TCP_TIME_WAIT) ?
 				   inet_twsk(sk)->tw_priority : sk->sk_priority;
 		transmit_time = tcp_transmit_time(sk);
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 024f93fc8c0b..b7b2ed05ac50 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2591,12 +2591,15 @@ void *nf_ct_alloc_hashtable(unsigned int *sizep, int nulls)
 	struct hlist_nulls_head *hash;
 	unsigned int nr_slots, i;
 
-	if (*sizep > (UINT_MAX / sizeof(struct hlist_nulls_head)))
+	if (*sizep > (INT_MAX / sizeof(struct hlist_nulls_head)))
 		return NULL;
 
 	BUILD_BUG_ON(sizeof(struct hlist_nulls_head) != sizeof(struct hlist_head));
 	nr_slots = *sizep = roundup(*sizep, PAGE_SIZE / sizeof(struct hlist_nulls_head));
 
+	if (nr_slots > (INT_MAX / sizeof(struct hlist_nulls_head)))
+		return NULL;
+
 	hash = kvcalloc(nr_slots, sizeof(struct hlist_nulls_head), GFP_KERNEL);
 
 	if (hash && nulls)
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 07bcf9b7d779..8176533c50ab 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7979,6 +7979,7 @@ static void nft_unregister_flowtable_hook(struct net *net,
 }
 
 static void __nft_unregister_flowtable_net_hooks(struct net *net,
+						 struct nft_flowtable *flowtable,
 						 struct list_head *hook_list,
 					         bool release_netdev)
 {
@@ -7986,6 +7987,8 @@ static void __nft_unregister_flowtable_net_hooks(struct net *net,
 
 	list_for_each_entry_safe(hook, next, hook_list, list) {
 		nf_unregister_net_hook(net, &hook->ops);
+		flowtable->data.type->setup(&flowtable->data, hook->ops.dev,
+					    FLOW_BLOCK_UNBIND);
 		if (release_netdev) {
 			list_del(&hook->list);
 			kfree_rcu(hook, rcu);
@@ -7994,9 +7997,10 @@ static void __nft_unregister_flowtable_net_hooks(struct net *net,
 }
 
 static void nft_unregister_flowtable_net_hooks(struct net *net,
+					       struct nft_flowtable *flowtable,
 					       struct list_head *hook_list)
 {
-	__nft_unregister_flowtable_net_hooks(net, hook_list, false);
+	__nft_unregister_flowtable_net_hooks(net, flowtable, hook_list, false);
 }
 
 static int nft_register_flowtable_net_hooks(struct net *net,
@@ -8618,8 +8622,6 @@ static void nf_tables_flowtable_destroy(struct nft_flowtable *flowtable)
 
 	flowtable->data.type->free(&flowtable->data);
 	list_for_each_entry_safe(hook, next, &flowtable->hook_list, list) {
-		flowtable->data.type->setup(&flowtable->data, hook->ops.dev,
-					    FLOW_BLOCK_UNBIND);
 		list_del_rcu(&hook->list);
 		kfree_rcu(hook, rcu);
 	}
@@ -9902,6 +9904,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 							   &nft_trans_flowtable_hooks(trans),
 							   NFT_MSG_DELFLOWTABLE);
 				nft_unregister_flowtable_net_hooks(net,
+								   nft_trans_flowtable(trans),
 								   &nft_trans_flowtable_hooks(trans));
 			} else {
 				list_del_rcu(&nft_trans_flowtable(trans)->list);
@@ -9910,6 +9913,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 							   &nft_trans_flowtable(trans)->hook_list,
 							   NFT_MSG_DELFLOWTABLE);
 				nft_unregister_flowtable_net_hooks(net,
+						nft_trans_flowtable(trans),
 						&nft_trans_flowtable(trans)->hook_list);
 			}
 			break;
@@ -10140,11 +10144,13 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		case NFT_MSG_NEWFLOWTABLE:
 			if (nft_trans_flowtable_update(trans)) {
 				nft_unregister_flowtable_net_hooks(net,
+						nft_trans_flowtable(trans),
 						&nft_trans_flowtable_hooks(trans));
 			} else {
 				nft_use_dec_restore(&trans->ctx.table->use);
 				list_del_rcu(&nft_trans_flowtable(trans)->list);
 				nft_unregister_flowtable_net_hooks(net,
+						nft_trans_flowtable(trans),
 						&nft_trans_flowtable(trans)->hook_list);
 			}
 			break;
@@ -10685,7 +10691,8 @@ static void __nft_release_hook(struct net *net, struct nft_table *table)
 	list_for_each_entry(chain, &table->chains, list)
 		__nf_tables_unregister_hook(net, table, chain, true);
 	list_for_each_entry(flowtable, &table->flowtables, list)
-		__nft_unregister_flowtable_net_hooks(net, &flowtable->hook_list,
+		__nft_unregister_flowtable_net_hooks(net, flowtable,
+						     &flowtable->hook_list,
 						     true);
 }
 
diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index 014cd3de7b5d..7657d86ad142 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -354,7 +354,8 @@ static const struct nla_policy flow_policy[TCA_FLOW_MAX + 1] = {
 	[TCA_FLOW_KEYS]		= { .type = NLA_U32 },
 	[TCA_FLOW_MODE]		= { .type = NLA_U32 },
 	[TCA_FLOW_BASECLASS]	= { .type = NLA_U32 },
-	[TCA_FLOW_RSHIFT]	= { .type = NLA_U32 },
+	[TCA_FLOW_RSHIFT]	= NLA_POLICY_MAX(NLA_U32,
+						 31 /* BITS_PER_U32 - 1 */),
 	[TCA_FLOW_ADDEND]	= { .type = NLA_U32 },
 	[TCA_FLOW_MASK]		= { .type = NLA_U32 },
 	[TCA_FLOW_XOR]		= { .type = NLA_U32 },
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index eee9ebad35a5..12dd4d41605c 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -643,6 +643,63 @@ static bool cake_ddst(int flow_mode)
 	return (flow_mode & CAKE_FLOW_DUAL_DST) == CAKE_FLOW_DUAL_DST;
 }
 
+static void cake_dec_srchost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_dsrc(flow_mode) &&
+		   q->hosts[flow->srchost].srchost_bulk_flow_count))
+		q->hosts[flow->srchost].srchost_bulk_flow_count--;
+}
+
+static void cake_inc_srchost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_dsrc(flow_mode) &&
+		   q->hosts[flow->srchost].srchost_bulk_flow_count < CAKE_QUEUES))
+		q->hosts[flow->srchost].srchost_bulk_flow_count++;
+}
+
+static void cake_dec_dsthost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_ddst(flow_mode) &&
+		   q->hosts[flow->dsthost].dsthost_bulk_flow_count))
+		q->hosts[flow->dsthost].dsthost_bulk_flow_count--;
+}
+
+static void cake_inc_dsthost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_ddst(flow_mode) &&
+		   q->hosts[flow->dsthost].dsthost_bulk_flow_count < CAKE_QUEUES))
+		q->hosts[flow->dsthost].dsthost_bulk_flow_count++;
+}
+
+static u16 cake_get_flow_quantum(struct cake_tin_data *q,
+				 struct cake_flow *flow,
+				 int flow_mode)
+{
+	u16 host_load = 1;
+
+	if (cake_dsrc(flow_mode))
+		host_load = max(host_load,
+				q->hosts[flow->srchost].srchost_bulk_flow_count);
+
+	if (cake_ddst(flow_mode))
+		host_load = max(host_load,
+				q->hosts[flow->dsthost].dsthost_bulk_flow_count);
+
+	/* The get_random_u16() is a way to apply dithering to avoid
+	 * accumulating roundoff errors
+	 */
+	return (q->flow_quantum * quantum_div[host_load] +
+		get_random_u16()) >> 16;
+}
+
 static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 		     int flow_mode, u16 flow_override, u16 host_override)
 {
@@ -789,10 +846,8 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 		allocate_dst = cake_ddst(flow_mode);
 
 		if (q->flows[outer_hash + k].set == CAKE_SET_BULK) {
-			if (allocate_src)
-				q->hosts[q->flows[reduced_hash].srchost].srchost_bulk_flow_count--;
-			if (allocate_dst)
-				q->hosts[q->flows[reduced_hash].dsthost].dsthost_bulk_flow_count--;
+			cake_dec_srchost_bulk_flow_count(q, &q->flows[outer_hash + k], flow_mode);
+			cake_dec_dsthost_bulk_flow_count(q, &q->flows[outer_hash + k], flow_mode);
 		}
 found:
 		/* reserve queue for future packets in same flow */
@@ -817,9 +872,10 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 			q->hosts[outer_hash + k].srchost_tag = srchost_hash;
 found_src:
 			srchost_idx = outer_hash + k;
-			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
-				q->hosts[srchost_idx].srchost_bulk_flow_count++;
 			q->flows[reduced_hash].srchost = srchost_idx;
+
+			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
+				cake_inc_srchost_bulk_flow_count(q, &q->flows[reduced_hash], flow_mode);
 		}
 
 		if (allocate_dst) {
@@ -840,9 +896,10 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 			q->hosts[outer_hash + k].dsthost_tag = dsthost_hash;
 found_dst:
 			dsthost_idx = outer_hash + k;
-			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
-				q->hosts[dsthost_idx].dsthost_bulk_flow_count++;
 			q->flows[reduced_hash].dsthost = dsthost_idx;
+
+			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
+				cake_inc_dsthost_bulk_flow_count(q, &q->flows[reduced_hash], flow_mode);
 		}
 	}
 
@@ -1855,10 +1912,6 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	/* flowchain */
 	if (!flow->set || flow->set == CAKE_SET_DECAYING) {
-		struct cake_host *srchost = &b->hosts[flow->srchost];
-		struct cake_host *dsthost = &b->hosts[flow->dsthost];
-		u16 host_load = 1;
-
 		if (!flow->set) {
 			list_add_tail(&flow->flowchain, &b->new_flows);
 		} else {
@@ -1868,18 +1921,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		flow->set = CAKE_SET_SPARSE;
 		b->sparse_flow_count++;
 
-		if (cake_dsrc(q->flow_mode))
-			host_load = max(host_load, srchost->srchost_bulk_flow_count);
-
-		if (cake_ddst(q->flow_mode))
-			host_load = max(host_load, dsthost->dsthost_bulk_flow_count);
-
-		flow->deficit = (b->flow_quantum *
-				 quantum_div[host_load]) >> 16;
+		flow->deficit = cake_get_flow_quantum(b, flow, q->flow_mode);
 	} else if (flow->set == CAKE_SET_SPARSE_WAIT) {
-		struct cake_host *srchost = &b->hosts[flow->srchost];
-		struct cake_host *dsthost = &b->hosts[flow->dsthost];
-
 		/* this flow was empty, accounted as a sparse flow, but actually
 		 * in the bulk rotation.
 		 */
@@ -1887,12 +1930,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		b->sparse_flow_count--;
 		b->bulk_flow_count++;
 
-		if (cake_dsrc(q->flow_mode))
-			srchost->srchost_bulk_flow_count++;
-
-		if (cake_ddst(q->flow_mode))
-			dsthost->dsthost_bulk_flow_count++;
-
+		cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
+		cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 	}
 
 	if (q->buffer_used > q->buffer_max_used)
@@ -1949,13 +1988,11 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct cake_tin_data *b = &q->tins[q->cur_tin];
-	struct cake_host *srchost, *dsthost;
 	ktime_t now = ktime_get();
 	struct cake_flow *flow;
 	struct list_head *head;
 	bool first_flow = true;
 	struct sk_buff *skb;
-	u16 host_load;
 	u64 delay;
 	u32 len;
 
@@ -2055,11 +2092,6 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 	q->cur_flow = flow - b->flows;
 	first_flow = false;
 
-	/* triple isolation (modified DRR++) */
-	srchost = &b->hosts[flow->srchost];
-	dsthost = &b->hosts[flow->dsthost];
-	host_load = 1;
-
 	/* flow isolation (DRR++) */
 	if (flow->deficit <= 0) {
 		/* Keep all flows with deficits out of the sparse and decaying
@@ -2071,11 +2103,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				b->sparse_flow_count--;
 				b->bulk_flow_count++;
 
-				if (cake_dsrc(q->flow_mode))
-					srchost->srchost_bulk_flow_count++;
-
-				if (cake_ddst(q->flow_mode))
-					dsthost->dsthost_bulk_flow_count++;
+				cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
+				cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 
 				flow->set = CAKE_SET_BULK;
 			} else {
@@ -2087,19 +2116,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 			}
 		}
 
-		if (cake_dsrc(q->flow_mode))
-			host_load = max(host_load, srchost->srchost_bulk_flow_count);
-
-		if (cake_ddst(q->flow_mode))
-			host_load = max(host_load, dsthost->dsthost_bulk_flow_count);
-
-		WARN_ON(host_load > CAKE_QUEUES);
-
-		/* The get_random_u16() is a way to apply dithering to avoid
-		 * accumulating roundoff errors
-		 */
-		flow->deficit += (b->flow_quantum * quantum_div[host_load] +
-				  get_random_u16()) >> 16;
+		flow->deficit += cake_get_flow_quantum(b, flow, q->flow_mode);
 		list_move_tail(&flow->flowchain, &b->old_flows);
 
 		goto retry;
@@ -2123,11 +2140,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				if (flow->set == CAKE_SET_BULK) {
 					b->bulk_flow_count--;
 
-					if (cake_dsrc(q->flow_mode))
-						srchost->srchost_bulk_flow_count--;
-
-					if (cake_ddst(q->flow_mode))
-						dsthost->dsthost_bulk_flow_count--;
+					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
+					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 
 					b->decaying_flow_count++;
 				} else if (flow->set == CAKE_SET_SPARSE ||
@@ -2145,12 +2159,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				else if (flow->set == CAKE_SET_BULK) {
 					b->bulk_flow_count--;
 
-					if (cake_dsrc(q->flow_mode))
-						srchost->srchost_bulk_flow_count--;
-
-					if (cake_ddst(q->flow_mode))
-						dsthost->dsthost_bulk_flow_count--;
-
+					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
+					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 				} else
 					b->decaying_flow_count--;
 
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 43ebf090029d..916dc2e81e42 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -380,7 +380,8 @@ static struct ctl_table sctp_net_table[] = {
 static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net,
+				       sctp.sctp_hmac_alg);
 	struct ctl_table tbl;
 	bool changed = false;
 	char *none = "none";
@@ -425,7 +426,7 @@ static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
 static int proc_sctp_do_rto_min(struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.rto_min);
 	unsigned int min = *(unsigned int *) ctl->extra1;
 	unsigned int max = *(unsigned int *) ctl->extra2;
 	struct ctl_table tbl;
@@ -453,7 +454,7 @@ static int proc_sctp_do_rto_min(struct ctl_table *ctl, int write,
 static int proc_sctp_do_rto_max(struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.rto_max);
 	unsigned int min = *(unsigned int *) ctl->extra1;
 	unsigned int max = *(unsigned int *) ctl->extra2;
 	struct ctl_table tbl;
@@ -491,7 +492,7 @@ static int proc_sctp_do_alpha_beta(struct ctl_table *ctl, int write,
 static int proc_sctp_do_auth(struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.auth_enable);
 	struct ctl_table tbl;
 	int new_value, ret;
 
@@ -520,7 +521,7 @@ static int proc_sctp_do_auth(struct ctl_table *ctl, int write,
 static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.udp_port);
 	unsigned int min = *(unsigned int *)ctl->extra1;
 	unsigned int max = *(unsigned int *)ctl->extra2;
 	struct ctl_table tbl;
@@ -561,7 +562,8 @@ static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write,
 static int proc_sctp_do_probe_interval(struct ctl_table *ctl, int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net,
+				       sctp.probe_interval);
 	struct ctl_table tbl;
 	int ret, new_value;
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 348abadbc2d8..5310441240e7 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -452,7 +452,7 @@ int tls_tx_records(struct sock *sk, int flags)
 
 tx_err:
 	if (rc < 0 && rc != -EAGAIN)
-		tls_err_abort(sk, -EBADMSG);
+		tls_err_abort(sk, rc);
 
 	return rc;
 }
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index deb7c1d3e979..f0ba2bf5a886 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -110,7 +110,7 @@ static inline unsigned long orc_ip(const int *ip)
 
 static int orc_sort_cmp(const void *_a, const void *_b)
 {
-	struct orc_entry *orc_a;
+	struct orc_entry *orc_a, *orc_b;
 	const int *a = g_orc_ip_table + *(int *)_a;
 	const int *b = g_orc_ip_table + *(int *)_b;
 	unsigned long a_val = orc_ip(a);
@@ -128,6 +128,10 @@ static int orc_sort_cmp(const void *_a, const void *_b)
 	 * whitelisted .o files which didn't get objtool generation.
 	 */
 	orc_a = g_orc_table + (a - g_orc_ip_table);
+	orc_b = g_orc_table + (b - g_orc_ip_table);
+	if (orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end &&
+	    orc_b->sp_reg == ORC_REG_UNDEFINED && !orc_b->end)
+		return 0;
 	return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
 }
 
diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index 01501d5747a7..52495c930ca3 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -120,8 +120,8 @@ int mtk_afe_pcm_new(struct snd_soc_component *component,
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
 
 	size = afe->mtk_afe_hardware->buffer_bytes_max;
-	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
-				       afe->dev, size, size);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV, afe->dev, 0, size);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mtk_afe_pcm_new);

