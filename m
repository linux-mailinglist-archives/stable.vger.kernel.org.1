Return-Path: <stable+bounces-183056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C095BB40D8
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725451885C5A
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D303313E36;
	Thu,  2 Oct 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qxWXC/Ns"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C976C313E2E;
	Thu,  2 Oct 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411855; cv=none; b=hPOXEZGDI2uIplLbSN6aUNZt5pzsDXR0DzRfsNzbsy3I7AV2T0mT16gIuu2gpGVOfVk4mxSy2zXuP8A3E0vgV2vwJ8TGlMVHx1SGS1O1QlQRvlEv54Q77o66MlDmT7bTC5Ciwac3PUvYLCRIZ3Jht0AkibvMgAwj2NsKR14ofug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411855; c=relaxed/simple;
	bh=m8Fbwf/LO0LuiKcCx/npKcbL9KRNYEQ5RFFuW1BYEB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSgXx/oc8aRPtv+9fbSnyhelzDPLW1GW0kGzsq613O8+pPQXgOf6ggKMmbWnFQMW6LGSXkWOPt73WGBt57ej1V+enFrNUqzlCvvv/sJiJRYukTleda8x00s8lCnxc5ziKge3FVKYvnQAD6I9BHbzzUHKxGq7uwO+H0uLdaL1DU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qxWXC/Ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2EFC4CEFA;
	Thu,  2 Oct 2025 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759411855;
	bh=m8Fbwf/LO0LuiKcCx/npKcbL9KRNYEQ5RFFuW1BYEB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxWXC/Ns94Idnq7n+ogeuW9K5iJPaNllZaZivTBM5YWSF8YhFOBbMFeNRaxoornor
	 oSYo8a7C2//68hUN3fgr7W/PKQfdcurAqFnx04N94L4I44rVLij19ASilt+wH8nLoO
	 +curqR8tGyVYxSwl0FpRsQNb4ztEeUPYLM3+b9aQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.50
Date: Thu,  2 Oct 2025 15:30:39 +0200
Message-ID: <2025100239-taps-frame-68d3@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025100239-remote-sabotage-da09@gregkh>
References: <2025100239-remote-sabotage-da09@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/laptops/lg-laptop.rst b/Documentation/admin-guide/laptops/lg-laptop.rst
index 67fd6932cef4..c4dd534f91ed 100644
--- a/Documentation/admin-guide/laptops/lg-laptop.rst
+++ b/Documentation/admin-guide/laptops/lg-laptop.rst
@@ -48,8 +48,8 @@ This value is reset to 100 when the kernel boots.
 Fan mode
 --------
 
-Writing 1/0 to /sys/devices/platform/lg-laptop/fan_mode disables/enables
-the fan silent mode.
+Writing 0/1/2 to /sys/devices/platform/lg-laptop/fan_mode sets fan mode to
+Optimal/Silent/Performance respectively.
 
 
 USB charge
diff --git a/Makefile b/Makefile
index 66ae67c52da8..7b0a94828fdb 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 49
+SUBLEVEL = 50
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
index ce0d6514eeb5..e4794ccb8e41 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
@@ -66,8 +66,10 @@ &gmac1 {
 	mdio0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		phy0: ethernet-phy@0 {
-			reg = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy0: ethernet-phy@4 {
+			reg = <4>;
 			rxd0-skew-ps = <0>;
 			rxd1-skew-ps = <0>;
 			rxd2-skew-ps = <0>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts b/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts
index d4e0b8150a84..cf26e2ceaaa0 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts
@@ -38,7 +38,7 @@ sound {
 		simple-audio-card,mclk-fs = <256>;
 
 		simple-audio-card,cpu {
-			sound-dai = <&audio0 0>;
+			sound-dai = <&audio0>;
 		};
 
 		simple-audio-card,codec {
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 40e847bc0b7f..62cf525ab714 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -283,7 +283,7 @@ thermal-zones {
 		cpu-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <2000>;
-			thermal-sensors = <&tmu 0>;
+			thermal-sensors = <&tmu 1>;
 			trips {
 				cpu_alert0: trip0 {
 					temperature = <85000>;
@@ -313,7 +313,7 @@ map0 {
 		soc-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <2000>;
-			thermal-sensors = <&tmu 1>;
+			thermal-sensors = <&tmu 0>;
 			trips {
 				soc_alert0: trip0 {
 					temperature = <85000>;
diff --git a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
index 0f53745a6fa0..41166f865f87 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
+++ b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
@@ -413,7 +413,13 @@ fixed-link {
 /* SRDS #0,#1,#2,#3 - PCIe */
 &cp0_pcie0 {
 	num-lanes = <4>;
-	phys = <&cp0_comphy0 0>, <&cp0_comphy1 0>, <&cp0_comphy2 0>, <&cp0_comphy3 0>;
+	/*
+	 * The mvebu-comphy driver does not currently know how to pass correct
+	 * lane-count to ATF while configuring the serdes lanes.
+	 * Rely on bootloader configuration only.
+	 *
+	 * phys = <&cp0_comphy0 0>, <&cp0_comphy1 0>, <&cp0_comphy2 0>, <&cp0_comphy3 0>;
+	 */
 	status = "okay";
 };
 
@@ -475,7 +481,13 @@ &cp1_eth0 {
 /* SRDS #0,#1 - PCIe */
 &cp1_pcie0 {
 	num-lanes = <2>;
-	phys = <&cp1_comphy0 0>, <&cp1_comphy1 0>;
+	/*
+	 * The mvebu-comphy driver does not currently know how to pass correct
+	 * lane-count to ATF while configuring the serdes lanes.
+	 * Rely on bootloader configuration only.
+	 *
+	 * phys = <&cp1_comphy0 0>, <&cp1_comphy1 0>;
+	 */
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi b/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
index afc041c1c448..bb2bb47fd77c 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
@@ -137,6 +137,14 @@ &ap_sdhci0 {
 	pinctrl-0 = <&ap_mmc0_pins>;
 	pinctrl-names = "default";
 	vqmmc-supply = <&v_1_8>;
+	/*
+	 * Not stable in HS modes - phy needs "more calibration", so disable
+	 * UHS (by preventing voltage switch), SDR104, SDR50 and DDR50 modes.
+	 */
+	no-1-8-v;
+	no-sd;
+	no-sdio;
+	non-removable;
 	status = "okay";
 };
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index bd55c2356303..9600a96f9117 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2973,6 +2973,15 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
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
@@ -2994,21 +3003,14 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
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
diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index b360dca2c69e..cc9731c3616c 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -41,7 +41,7 @@
 /*
  * ABI version history is documented in linux/firewire-cdev.h.
  */
-#define FW_CDEV_KERNEL_VERSION			5
+#define FW_CDEV_KERNEL_VERSION			6
 #define FW_CDEV_VERSION_EVENT_REQUEST2		4
 #define FW_CDEV_VERSION_ALLOCATE_REGION_END	4
 #define FW_CDEV_VERSION_AUTO_FLUSH_ISO_OVERFLOW	5
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 209871c219d6..e5d0d2b0d798 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4317,6 +4317,23 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
 	return desc;
 }
 
+static struct gpio_desc *gpiod_fwnode_lookup(struct fwnode_handle *fwnode,
+					     struct device *consumer,
+					     const char *con_id,
+					     unsigned int idx,
+					     enum gpiod_flags *flags,
+					     unsigned long *lookupflags)
+{
+	struct gpio_desc *desc;
+
+	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, flags, lookupflags);
+	if (gpiod_not_found(desc) && !IS_ERR_OR_NULL(fwnode))
+		desc = gpiod_find_by_fwnode(fwnode->secondary, consumer, con_id,
+					    idx, flags, lookupflags);
+
+	return desc;
+}
+
 struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 					 struct fwnode_handle *fwnode,
 					 const char *con_id,
@@ -4335,8 +4352,8 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 	int ret = 0;
 
 	scoped_guard(srcu, &gpio_devices_srcu) {
-		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
-					    &flags, &lookupflags);
+		desc = gpiod_fwnode_lookup(fwnode, consumer, con_id, idx,
+					   &flags, &lookupflags);
 		if (gpiod_not_found(desc) && platform_lookup_allowed) {
 			/*
 			 * Either we are not using DT or ACPI, or their lookup
diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index 5dadc895e7f2..5e87ca2320a4 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -79,7 +79,7 @@ static int ast_astdp_read_edid_block(void *data, u8 *buf, unsigned int block, si
 			 * 3. The Delays are often longer a lot when system resume from S3/S4.
 			 */
 			if (j)
-				mdelay(j + 1);
+				msleep(j + 1);
 
 			/* Wait for EDID offset to show up in mirror register */
 			vgacrd7 = ast_get_index_reg(ast, AST_IO_VGACRI, 0xd7);
diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index ed8626c73541..f0ae675581d9 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -726,8 +726,8 @@ void oaktrail_hdmi_teardown(struct drm_device *dev)
 
 	if (hdmi_dev) {
 		pdev = hdmi_dev->dev;
-		pci_set_drvdata(pdev, NULL);
 		oaktrail_hdmi_i2c_exit(pdev);
+		pci_set_drvdata(pdev, NULL);
 		iounmap(hdmi_dev->regs);
 		kfree(hdmi_dev);
 		pci_dev_put(pdev);
diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index 9e05745d797d..4d93781f2dd7 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -40,8 +40,9 @@ static u32 scale(u32 source_val,
 {
 	u64 target_val;
 
-	WARN_ON(source_min > source_max);
-	WARN_ON(target_min > target_max);
+	if (WARN_ON(source_min >= source_max) ||
+	    WARN_ON(target_min > target_max))
+		return target_min;
 
 	/* defensive */
 	source_val = clamp(source_val, source_min, source_max);
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 20135a9bc026..0bc5b69ec636 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -865,8 +865,7 @@ static void group_free_queue(struct panthor_group *group, struct panthor_queue *
 	if (IS_ERR_OR_NULL(queue))
 		return;
 
-	if (queue->entity.fence_context)
-		drm_sched_entity_destroy(&queue->entity);
+	drm_sched_entity_destroy(&queue->entity);
 
 	if (queue->scheduler.ops)
 		drm_sched_fini(&queue->scheduler);
@@ -3458,11 +3457,6 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
 	if (!group)
 		return -EINVAL;
 
-	for (u32 i = 0; i < group->queue_count; i++) {
-		if (group->queues[i])
-			drm_sched_entity_destroy(&group->queues[i]->entity);
-	}
-
 	mutex_lock(&sched->reset.lock);
 	mutex_lock(&sched->lock);
 	group->destroyed = true;
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
index 3438d392920f..8dae9a776685 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
@@ -39,8 +39,12 @@ int amd_sfh_get_report(struct hid_device *hid, int report_id, int report_type)
 	struct amdtp_hid_data *hid_data = hid->driver_data;
 	struct amdtp_cl_data *cli_data = hid_data->cli_data;
 	struct request_list *req_list = &cli_data->req_list;
+	struct amd_input_data *in_data = cli_data->in_data;
+	struct amd_mp2_dev *mp2;
 	int i;
 
+	mp2 = container_of(in_data, struct amd_mp2_dev, in_data);
+	guard(mutex)(&mp2->lock);
 	for (i = 0; i < cli_data->num_hid_devices; i++) {
 		if (cli_data->hid_sensor_hubs[i] == hid) {
 			struct request_list *new = kzalloc(sizeof(*new), GFP_KERNEL);
@@ -75,6 +79,8 @@ void amd_sfh_work(struct work_struct *work)
 	u8 report_id, node_type;
 	u8 report_size = 0;
 
+	mp2 = container_of(in_data, struct amd_mp2_dev, in_data);
+	guard(mutex)(&mp2->lock);
 	req_node = list_last_entry(&req_list->list, struct request_list, list);
 	list_del(&req_node->list);
 	current_index = req_node->current_index;
@@ -83,7 +89,6 @@ void amd_sfh_work(struct work_struct *work)
 	node_type = req_node->report_type;
 	kfree(req_node);
 
-	mp2 = container_of(in_data, struct amd_mp2_dev, in_data);
 	mp2_ops = mp2->mp2_ops;
 	if (node_type == HID_FEATURE_REPORT) {
 		report_size = mp2_ops->get_feat_rep(sensor_index, report_id,
@@ -107,6 +112,8 @@ void amd_sfh_work(struct work_struct *work)
 	cli_data->cur_hid_dev = current_index;
 	cli_data->sensor_requested_cnt[current_index] = 0;
 	amdtp_hid_wakeup(cli_data->hid_sensor_hubs[current_index]);
+	if (!list_empty(&req_list->list))
+		schedule_delayed_work(&cli_data->work, 0);
 }
 
 void amd_sfh_work_buffer(struct work_struct *work)
@@ -117,9 +124,10 @@ void amd_sfh_work_buffer(struct work_struct *work)
 	u8 report_size;
 	int i;
 
+	mp2 = container_of(in_data, struct amd_mp2_dev, in_data);
+	guard(mutex)(&mp2->lock);
 	for (i = 0; i < cli_data->num_hid_devices; i++) {
 		if (cli_data->sensor_sts[i] == SENSOR_ENABLED) {
-			mp2 = container_of(in_data, struct amd_mp2_dev, in_data);
 			report_size = mp2->mp2_ops->get_in_rep(i, cli_data->sensor_idx[i],
 							       cli_data->report_id[i], in_data);
 			hid_input_report(cli_data->hid_sensor_hubs[i], HID_INPUT_REPORT,
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_common.h b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
index e5620d7db569..00308d8998d4 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
@@ -10,6 +10,7 @@
 #ifndef AMD_SFH_COMMON_H
 #define AMD_SFH_COMMON_H
 
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include "amd_sfh_hid.h"
 
@@ -57,6 +58,8 @@ struct amd_mp2_dev {
 	u32 mp2_acs;
 	struct sfh_dev_status dev_en;
 	struct work_struct work;
+	/* mp2 to protect data */
+	struct mutex lock;
 	u8 init_done;
 	u8 rver;
 };
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 0c28ca349bcd..9739f66e925c 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -405,6 +405,10 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	if (!privdata->cl_data)
 		return -ENOMEM;
 
+	rc = devm_mutex_init(&pdev->dev, &privdata->lock);
+	if (rc)
+		return rc;
+
 	privdata->sfh1_1_ops = (const struct amd_sfh1_1_ops *)id->driver_data;
 	if (privdata->sfh1_1_ops) {
 		if (boot_cpu_data.x86 >= 0x1A)
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 6b90d2c03e88..dd989b519f86 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -971,7 +971,10 @@ static int asus_input_mapping(struct hid_device *hdev,
 		case 0xc4: asus_map_key_clear(KEY_KBDILLUMUP);		break;
 		case 0xc5: asus_map_key_clear(KEY_KBDILLUMDOWN);		break;
 		case 0xc7: asus_map_key_clear(KEY_KBDILLUMTOGGLE);	break;
+		case 0x4e: asus_map_key_clear(KEY_FN_ESC);		break;
+		case 0x7e: asus_map_key_clear(KEY_EMOJI_PICKER);	break;
 
+		case 0x8b: asus_map_key_clear(KEY_PROG1);	break; /* ProArt Creator Hub key */
 		case 0x6b: asus_map_key_clear(KEY_F21);		break; /* ASUS touchpad toggle */
 		case 0x38: asus_map_key_clear(KEY_PROG1);	break; /* ROG key */
 		case 0xba: asus_map_key_clear(KEY_PROG2);	break; /* Fn+C ASUS Splendid */
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index a3e86930bf41..ef9bed2f2dcc 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -101,7 +101,7 @@ static int bt1_i2c_request_regs(struct dw_i2c_dev *dev)
 }
 #endif
 
-static int txgbe_i2c_request_regs(struct dw_i2c_dev *dev)
+static int dw_i2c_get_parent_regmap(struct dw_i2c_dev *dev)
 {
 	dev->map = dev_get_regmap(dev->dev->parent, NULL);
 	if (!dev->map)
@@ -123,12 +123,15 @@ static int dw_i2c_plat_request_regs(struct dw_i2c_dev *dev)
 	struct platform_device *pdev = to_platform_device(dev->dev);
 	int ret;
 
+	if (device_is_compatible(dev->dev, "intel,xe-i2c"))
+		return dw_i2c_get_parent_regmap(dev);
+
 	switch (dev->flags & MODEL_MASK) {
 	case MODEL_BAIKAL_BT1:
 		ret = bt1_i2c_request_regs(dev);
 		break;
 	case MODEL_WANGXUN_SP:
-		ret = txgbe_i2c_request_regs(dev);
+		ret = dw_i2c_get_parent_regmap(dev);
 		break;
 	default:
 		dev->base = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index f49f78b69ab9..e74273bc078b 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -191,6 +191,7 @@ static u16 get_legacy_obj_type(u16 opcode)
 {
 	switch (opcode) {
 	case MLX5_CMD_OP_CREATE_RQ:
+	case MLX5_CMD_OP_CREATE_RMP:
 		return MLX5_EVENT_QUEUE_TYPE_RQ;
 	case MLX5_CMD_OP_CREATE_QP:
 		return MLX5_EVENT_QUEUE_TYPE_QP;
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 1b0812f8bf84..af39b2379d53 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -415,7 +415,7 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	fdno = get_unused_fd_flags(O_CLOEXEC);
 	if (fdno < 0) {
 		rc = fdno;
-		goto out_fput;
+		goto out_abort;
 	}
 
 	cmd->out_fault_id = fault->obj.id;
@@ -431,8 +431,6 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	return 0;
 out_put_fdno:
 	put_unused_fd(fdno);
-out_fput:
-	fput(filep);
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->obj);
 
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 649fe79d0f0c..6add737a6708 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -23,6 +23,7 @@
 #include "iommufd_test.h"
 
 struct iommufd_object_ops {
+	size_t file_offset;
 	void (*destroy)(struct iommufd_object *obj);
 	void (*abort)(struct iommufd_object *obj);
 };
@@ -97,10 +98,30 @@ void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
 void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 				      struct iommufd_object *obj)
 {
-	if (iommufd_object_ops[obj->type].abort)
-		iommufd_object_ops[obj->type].abort(obj);
+	const struct iommufd_object_ops *ops = &iommufd_object_ops[obj->type];
+
+	if (ops->file_offset) {
+		struct file **filep = ((void *)obj) + ops->file_offset;
+
+		/*
+		 * A file should hold a users refcount while the file is open
+		 * and put it back in its release. The file should hold a
+		 * pointer to obj in their private data. Normal fput() is
+		 * deferred to a workqueue and can get out of order with the
+		 * following kfree(obj). Using the sync version ensures the
+		 * release happens immediately. During abort we require the file
+		 * refcount is one at this point - meaning the object alloc
+		 * function cannot do anything to allow another thread to take a
+		 * refcount prior to a guaranteed success.
+		 */
+		if (*filep)
+			__fput_sync(*filep);
+	}
+
+	if (ops->abort)
+		ops->abort(obj);
 	else
-		iommufd_object_ops[obj->type].destroy(obj);
+		ops->destroy(obj);
 	iommufd_object_abort(ictx, obj);
 }
 
@@ -498,6 +519,12 @@ void iommufd_ctx_put(struct iommufd_ctx *ictx)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_ctx_put, IOMMUFD);
 
+#define IOMMUFD_FILE_OFFSET(_struct, _filep, _obj)                           \
+	.file_offset = (offsetof(_struct, _filep) +                          \
+			BUILD_BUG_ON_ZERO(!__same_type(                      \
+				struct file *, ((_struct *)NULL)->_filep)) + \
+			BUILD_BUG_ON_ZERO(offsetof(_struct, _obj)))
+
 static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_ACCESS] = {
 		.destroy = iommufd_access_destroy_object,
@@ -518,6 +545,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	},
 	[IOMMUFD_OBJ_FAULT] = {
 		.destroy = iommufd_fault_destroy,
+		IOMMUFD_FILE_OFFSET(struct iommufd_fault, filep, obj),
 	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index be1505e8c536..7759531ccca7 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -433,6 +433,13 @@ static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
 	},
 };
 
+static const struct sdhci_cdns_drv_data sdhci_eyeq_drv_data = {
+	.pltfm_data = {
+		.ops = &sdhci_cdns_ops,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	},
+};
+
 static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
 	.pltfm_data = {
 		.ops = &sdhci_cdns_ops,
@@ -595,6 +602,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
 		.compatible = "amd,pensando-elba-sd4hc",
 		.data = &sdhci_elba_drv_data,
 	},
+	{
+		.compatible = "mobileye,eyeq-sd4hc",
+		.data = &sdhci_eyeq_drv_data,
+	},
 	{ .compatible = "cdns,sd4hc" },
 	{ /* sentinel */ }
 };
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 2b7dd359f27b..8569178b66df 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -861,7 +861,6 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct rcar_can_priv *priv = netdev_priv(ndev);
-	u16 ctlr;
 	int err;
 
 	if (!netif_running(ndev))
@@ -873,12 +872,7 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
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
index 1b9501ee10de..ff39afc77d7d 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -813,6 +813,7 @@ static const struct net_device_ops hi3110_netdev_ops = {
 	.ndo_open = hi3110_open,
 	.ndo_stop = hi3110_stop,
 	.ndo_start_xmit = hi3110_hard_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops hi3110_ethtool_ops = {
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 4311c1f0eafd..30b30fdbcae9 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -768,6 +768,7 @@ static const struct net_device_ops sun4ican_netdev_ops = {
 	.ndo_open = sun4ican_open,
 	.ndo_stop = sun4ican_close,
 	.ndo_start_xmit = sun4ican_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops sun4ican_ethtool_ops = {
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 71f24dc0a927..4fc9bed0d2e1 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -7,7 +7,7 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2025 Vincent Mailhol <mailhol@kernel.org>
  */
 
 #include <linux/unaligned.h>
@@ -1977,6 +1977,7 @@ static const struct net_device_ops es58x_netdev_ops = {
 	.ndo_stop = es58x_stop,
 	.ndo_start_xmit = es58x_start_xmit,
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops es58x_ethtool_ops = {
diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 41c0a1c399bf..1f9b915094e6 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -761,6 +761,7 @@ static const struct net_device_ops mcba_netdev_ops = {
 	.ndo_open = mcba_usb_open,
 	.ndo_stop = mcba_usb_close,
 	.ndo_start_xmit = mcba_usb_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops mcba_ethtool_ops = {
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 59f7cd8ceb39..69c44f675ff1 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -111,7 +111,7 @@ void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
 		u32 delta_ts = time_ref->ts_dev_2 - time_ref->ts_dev_1;
 
 		if (time_ref->ts_dev_2 < time_ref->ts_dev_1)
-			delta_ts &= (1 << time_ref->adapter->ts_used_bits) - 1;
+			delta_ts &= (1ULL << time_ref->adapter->ts_used_bits) - 1;
 
 		time_ref->ts_total += delta_ts;
 	}
diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index fcd4505f4925..b1f18a840da7 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -685,18 +685,27 @@ static int gswip_add_single_port_br(struct gswip_priv *priv, int port, bool add)
 	return 0;
 }
 
-static int gswip_port_enable(struct dsa_switch *ds, int port,
-			     struct phy_device *phydev)
+static int gswip_port_setup(struct dsa_switch *ds, int port)
 {
 	struct gswip_priv *priv = ds->priv;
 	int err;
 
 	if (!dsa_is_cpu_port(ds, port)) {
-		u32 mdio_phy = 0;
-
 		err = gswip_add_single_port_br(priv, port, true);
 		if (err)
 			return err;
+	}
+
+	return 0;
+}
+
+static int gswip_port_enable(struct dsa_switch *ds, int port,
+			     struct phy_device *phydev)
+{
+	struct gswip_priv *priv = ds->priv;
+
+	if (!dsa_is_cpu_port(ds, port)) {
+		u32 mdio_phy = 0;
 
 		if (phydev)
 			mdio_phy = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
@@ -1359,8 +1368,9 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
 	int i;
 	int err;
 
+	/* Operation not supported on the CPU port, don't throw errors */
 	if (!bridge)
-		return -EINVAL;
+		return 0;
 
 	for (i = max_ports; i < ARRAY_SIZE(priv->vlans); i++) {
 		if (priv->vlans[i].bridge == bridge) {
@@ -1829,6 +1839,7 @@ static const struct phylink_mac_ops gswip_phylink_mac_ops = {
 static const struct dsa_switch_ops gswip_xrx200_switch_ops = {
 	.get_tag_protocol	= gswip_get_tag_protocol,
 	.setup			= gswip_setup,
+	.port_setup		= gswip_port_setup,
 	.port_enable		= gswip_port_enable,
 	.port_disable		= gswip_port_disable,
 	.port_bridge_join	= gswip_port_bridge_join,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index d2ca90407cce..8057350236c5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -244,7 +244,7 @@ bnxt_tc_parse_pedit(struct bnxt *bp, struct bnxt_tc_actions *actions,
 			   offset < offset_of_ip6_daddr + 16) {
 			actions->nat.src_xlate = false;
 			idx = (offset - offset_of_ip6_daddr) / 4;
-			actions->nat.l3.ipv6.saddr.s6_addr32[idx] = htonl(val);
+			actions->nat.l3.ipv6.daddr.s6_addr32[idx] = htonl(val);
 		} else {
 			netdev_err(bp->dev,
 				   "%s: IPv6_hdr: Invalid pedit field\n",
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 0bd814251d56..d144494f97e9 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -131,7 +131,7 @@ static const struct fec_devinfo fec_mvf600_info = {
 		  FEC_QUIRK_HAS_MDIO_C45,
 };
 
-static const struct fec_devinfo fec_imx6x_info = {
+static const struct fec_devinfo fec_imx6sx_info = {
 	.quirks = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
 		  FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
 		  FEC_QUIRK_HAS_VLAN | FEC_QUIRK_HAS_AVB |
@@ -196,7 +196,7 @@ static const struct of_device_id fec_dt_ids[] = {
 	{ .compatible = "fsl,imx28-fec", .data = &fec_imx28_info, },
 	{ .compatible = "fsl,imx6q-fec", .data = &fec_imx6q_info, },
 	{ .compatible = "fsl,mvf600-fec", .data = &fec_mvf600_info, },
-	{ .compatible = "fsl,imx6sx-fec", .data = &fec_imx6x_info, },
+	{ .compatible = "fsl,imx6sx-fec", .data = &fec_imx6sx_info, },
 	{ .compatible = "fsl,imx6ul-fec", .data = &fec_imx6ul_info, },
 	{ .compatible = "fsl,imx8mq-fec", .data = &fec_imx8mq_info, },
 	{ .compatible = "fsl,imx8qm-fec", .data = &fec_imx8qm_info, },
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index b22bb0ae9b9d..b8de97343ad3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1277,7 +1277,8 @@ struct i40e_mac_filter *i40e_add_mac_filter(struct i40e_vsi *vsi,
 					    const u8 *macaddr);
 int i40e_del_mac_filter(struct i40e_vsi *vsi, const u8 *macaddr);
 bool i40e_is_vsi_in_vlan(struct i40e_vsi *vsi);
-int i40e_count_filters(struct i40e_vsi *vsi);
+int i40e_count_all_filters(struct i40e_vsi *vsi);
+int i40e_count_active_filters(struct i40e_vsi *vsi);
 struct i40e_mac_filter *i40e_find_mac(struct i40e_vsi *vsi, const u8 *macaddr);
 void i40e_vlan_stripping_enable(struct i40e_vsi *vsi);
 static inline bool i40e_is_sw_dcb(struct i40e_pf *pf)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 037c1a0cbd6a..eae5923104f7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1241,12 +1241,30 @@ void i40e_update_stats(struct i40e_vsi *vsi)
 }
 
 /**
- * i40e_count_filters - counts VSI mac filters
+ * i40e_count_all_filters - counts VSI MAC filters
  * @vsi: the VSI to be searched
  *
- * Returns count of mac filters
- **/
-int i40e_count_filters(struct i40e_vsi *vsi)
+ * Return: count of MAC filters in any state.
+ */
+int i40e_count_all_filters(struct i40e_vsi *vsi)
+{
+	struct i40e_mac_filter *f;
+	struct hlist_node *h;
+	int bkt, cnt = 0;
+
+	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist)
+		cnt++;
+
+	return cnt;
+}
+
+/**
+ * i40e_count_active_filters - counts VSI MAC filters
+ * @vsi: the VSI to be searched
+ *
+ * Return: count of active MAC filters.
+ */
+int i40e_count_active_filters(struct i40e_vsi *vsi)
 {
 	struct i40e_mac_filter *f;
 	struct hlist_node *h;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 97f32a0c68d0..646e394f5190 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -448,7 +448,7 @@ static void i40e_config_irq_link_list(struct i40e_vf *vf, u16 vsi_id,
 		    (qtype << I40E_QINT_RQCTL_NEXTQ_TYPE_SHIFT) |
 		    (pf_queue_id << I40E_QINT_RQCTL_NEXTQ_INDX_SHIFT) |
 		    BIT(I40E_QINT_RQCTL_CAUSE_ENA_SHIFT) |
-		    (itr_idx << I40E_QINT_RQCTL_ITR_INDX_SHIFT);
+		    FIELD_PREP(I40E_QINT_RQCTL_ITR_INDX_MASK, itr_idx);
 		wr32(hw, reg_idx, reg);
 	}
 
@@ -653,6 +653,13 @@ static int i40e_config_vsi_tx_queue(struct i40e_vf *vf, u16 vsi_id,
 
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
@@ -716,6 +723,13 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 
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
@@ -1453,6 +1467,7 @@ static void i40e_trigger_vf_reset(struct i40e_vf *vf, bool flr)
 	 * functions that may still be running at this point.
 	 */
 	clear_bit(I40E_VF_STATE_INIT, &vf->vf_states);
+	clear_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states);
 
 	/* In the case of a VFLR, the HW has already reset the VF and we
 	 * just need to clean up, so don't hit the VFRTRIG register.
@@ -2119,7 +2134,10 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	size_t len = 0;
 	int ret;
 
-	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_INIT)) {
+	i40e_sync_vf_state(vf, I40E_VF_STATE_INIT);
+
+	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states) ||
+	    test_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states)) {
 		aq_ret = -EINVAL;
 		goto err;
 	}
@@ -2222,6 +2240,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 				vf->default_lan_addr.addr);
 	}
 	set_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states);
+	set_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states);
 
 err:
 	/* send the response back to the VF */
@@ -2384,7 +2403,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		}
 
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = -ENODEV;
 				goto error_param;
 			}
@@ -2405,7 +2424,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		 * to its appropriate VSIs based on TC mapping
 		 */
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = -ENODEV;
 				goto error_param;
 			}
@@ -2455,8 +2474,10 @@ static int i40e_validate_queue_map(struct i40e_vf *vf, u16 vsi_id,
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
@@ -2844,24 +2865,6 @@ static int i40e_vc_get_stats_msg(struct i40e_vf *vf, u8 *msg)
 				      (u8 *)&stats, sizeof(stats));
 }
 
-/**
- * i40e_can_vf_change_mac
- * @vf: pointer to the VF info
- *
- * Return true if the VF is allowed to change its MAC filters, false otherwise
- */
-static bool i40e_can_vf_change_mac(struct i40e_vf *vf)
-{
-	/* If the VF MAC address has been set administratively (via the
-	 * ndo_set_vf_mac command), then deny permission to the VF to
-	 * add/delete unicast MAC addresses, unless the VF is trusted
-	 */
-	if (vf->pf_set_mac && !vf->trusted)
-		return false;
-
-	return true;
-}
-
 #define I40E_MAX_MACVLAN_PER_HW 3072
 #define I40E_MAX_MACVLAN_PER_PF(num_ports) (I40E_MAX_MACVLAN_PER_HW /	\
 	(num_ports))
@@ -2900,8 +2903,10 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = pf->vsi[vf->lan_vsi_idx];
 	struct i40e_hw *hw = &pf->hw;
-	int mac2add_cnt = 0;
-	int i;
+	int i, mac_add_max, mac_add_cnt = 0;
+	bool vf_trusted;
+
+	vf_trusted = test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
 
 	for (i = 0; i < al->num_elements; i++) {
 		struct i40e_mac_filter *f;
@@ -2921,9 +2926,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 		 * The VF may request to set the MAC address filter already
 		 * assigned to it so do not return an error in that case.
 		 */
-		if (!i40e_can_vf_change_mac(vf) &&
-		    !is_multicast_ether_addr(addr) &&
-		    !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
+		if (!vf_trusted && !is_multicast_ether_addr(addr) &&
+		    vf->pf_set_mac && !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
 			dev_err(&pf->pdev->dev,
 				"VF attempting to override administratively set MAC address, bring down and up the VF interface to resume normal operation\n");
 			return -EPERM;
@@ -2932,29 +2936,33 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 		/*count filters that really will be added*/
 		f = i40e_find_mac(vsi, addr);
 		if (!f)
-			++mac2add_cnt;
+			++mac_add_cnt;
 	}
 
 	/* If this VF is not privileged, then we can't add more than a limited
-	 * number of addresses. Check to make sure that the additions do not
-	 * push us over the limit.
-	 */
-	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
-		if ((i40e_count_filters(vsi) + mac2add_cnt) >
-		    I40E_VC_MAX_MAC_ADDR_PER_VF) {
-			dev_err(&pf->pdev->dev,
-				"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
-			return -EPERM;
-		}
-	/* If this VF is trusted, it can use more resources than untrusted.
+	 * number of addresses.
+	 *
+	 * If this VF is trusted, it can use more resources than untrusted.
 	 * However to ensure that every trusted VF has appropriate number of
 	 * resources, divide whole pool of resources per port and then across
 	 * all VFs.
 	 */
-	} else {
-		if ((i40e_count_filters(vsi) + mac2add_cnt) >
-		    I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
-						       hw->num_ports)) {
+	if (!vf_trusted)
+		mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
+	else
+		mac_add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs, hw->num_ports);
+
+	/* VF can replace all its filters in one step, in this case mac_add_max
+	 * will be added as active and another mac_add_max will be in
+	 * a to-be-removed state. Account for that.
+	 */
+	if ((i40e_count_active_filters(vsi) + mac_add_cnt) > mac_add_max ||
+	    (i40e_count_all_filters(vsi) + mac_add_cnt) > 2 * mac_add_max) {
+		if (!vf_trusted) {
+			dev_err(&pf->pdev->dev,
+				"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
+			return -EPERM;
+		} else {
 			dev_err(&pf->pdev->dev,
 				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
 			return -EPERM;
@@ -3589,7 +3597,7 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 
 	/* action_meta is TC number here to which the filter is applied */
 	if (!tc_filter->action_meta ||
-	    tc_filter->action_meta > vf->num_tc) {
+	    tc_filter->action_meta >= vf->num_tc) {
 		dev_info(&pf->pdev->dev, "VF %d: Invalid TC number %u\n",
 			 vf->vf_id, tc_filter->action_meta);
 		goto err;
@@ -3887,6 +3895,8 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 				       aq_ret);
 }
 
+#define I40E_MAX_VF_CLOUD_FILTER 0xFF00
+
 /**
  * i40e_vc_add_cloud_filter
  * @vf: pointer to the VF info
@@ -3926,6 +3936,14 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
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
 	if (!cfilter) {
 		aq_ret = -ENOMEM;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 66f95e2f3146..e0e797fea138 100644
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
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 971993586fb4..ca74bf684336 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -21,8 +21,7 @@
 #include "rvu.h"
 #include "lmac_common.h"
 
-#define DRV_NAME	"Marvell-CGX/RPM"
-#define DRV_STRING      "Marvell CGX/RPM Driver"
+#define DRV_NAME	"Marvell-CGX-RPM"
 
 #define CGX_RX_STAT_GLOBAL_INDEX	9
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index e63cc1eb6d89..ed041c3f714f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -1319,7 +1319,6 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 
 free_leaf:
 	otx2_tc_del_from_flow_list(flow_cfg, new_node);
-	kfree_rcu(new_node, rcu);
 	if (new_node->is_act_police) {
 		mutex_lock(&nic->mbox.lock);
 
@@ -1339,6 +1338,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 
 		mutex_unlock(&nic->mbox.lock);
 	}
+	kfree_rcu(new_node, rcu);
 
 	return rc;
 }
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 7b33993f7001..f1827a1bd7a5 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -360,6 +360,11 @@ static void sfp_fixup_ignore_tx_fault(struct sfp *sfp)
 	sfp->state_ignore_mask |= SFP_F_TX_FAULT;
 }
 
+static void sfp_fixup_ignore_hw(struct sfp *sfp, unsigned int mask)
+{
+	sfp->state_hw_mask &= ~mask;
+}
+
 static void sfp_fixup_nokia(struct sfp *sfp)
 {
 	sfp_fixup_long_startup(sfp);
@@ -408,7 +413,19 @@ static void sfp_fixup_halny_gsfp(struct sfp *sfp)
 	 * these are possibly used for other purposes on this
 	 * module, e.g. a serial port.
 	 */
-	sfp->state_hw_mask &= ~(SFP_F_TX_FAULT | SFP_F_LOS);
+	sfp_fixup_ignore_hw(sfp, SFP_F_TX_FAULT | SFP_F_LOS);
+}
+
+static void sfp_fixup_potron(struct sfp *sfp)
+{
+	/*
+	 * The TX_FAULT and LOS pins on this device are used for serial
+	 * communication, so ignore them. Additionally, provide extra
+	 * time for this device to fully start up.
+	 */
+
+	sfp_fixup_long_startup(sfp);
+	sfp_fixup_ignore_hw(sfp, SFP_F_TX_FAULT | SFP_F_LOS);
 }
 
 static void sfp_fixup_rollball_cc(struct sfp *sfp)
@@ -474,6 +491,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("ALCATELLUCENT", "3FE46541AA", sfp_quirk_2500basex,
 		  sfp_fixup_nokia),
 
+	// FLYPRO SFP-10GT-CS-30M uses Rollball protocol to talk to the PHY.
+	SFP_QUIRK_F("FLYPRO", "SFP-10GT-CS-30M", sfp_fixup_rollball),
+
 	// Fiberstore SFP-10G-T doesn't identify as copper, uses the Rollball
 	// protocol to talk to the PHY and needs 4 sec wait before probing the
 	// PHY.
@@ -511,6 +531,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("Walsun", "HXSX-ATRC-1", sfp_fixup_fs_10gt),
 	SFP_QUIRK_F("Walsun", "HXSX-ATRI-1", sfp_fixup_fs_10gt),
 
+	SFP_QUIRK_F("YV", "SFP+ONU-XGSPON", sfp_fixup_potron),
+
 	// OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
 	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index fae1a0ab36bd..fb9d425eff8c 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1932,6 +1932,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 				local_bh_enable();
 				goto unlock_frags;
 			}
+
+			if (frags && skb != tfile->napi.skb)
+				tfile->napi.skb = skb;
 		}
 		rcu_read_unlock();
 		local_bh_enable();
diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 4ee374080466..a77a27c36bdb 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -277,7 +277,9 @@ static void virt_wifi_connect_complete(struct work_struct *work)
 		priv->is_connected = true;
 
 	/* Schedules an event that acquires the rtnl lock. */
-	cfg80211_connect_result(priv->upperdev, requested_bss, NULL, 0, NULL, 0,
+	cfg80211_connect_result(priv->upperdev,
+				priv->is_connected ? fake_router_bssid : NULL,
+				NULL, 0, NULL, 0,
 				status, GFP_KERNEL);
 	netif_carrier_on(priv->upperdev);
 }
diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 4b57102c7f62..6af6cf477c5b 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/dev_printk.h>
@@ -75,6 +76,9 @@ MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages");
 #define WMBB_USB_CHARGE 0x10B
 #define WMBB_BATT_LIMIT 0x10C
 
+#define FAN_MODE_LOWER GENMASK(1, 0)
+#define FAN_MODE_UPPER GENMASK(5, 4)
+
 #define PLATFORM_NAME   "lg-laptop"
 
 MODULE_ALIAS("wmi:" WMI_EVENT_GUID0);
@@ -274,29 +278,19 @@ static ssize_t fan_mode_store(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buffer, size_t count)
 {
-	bool value;
+	unsigned long value;
 	union acpi_object *r;
-	u32 m;
 	int ret;
 
-	ret = kstrtobool(buffer, &value);
+	ret = kstrtoul(buffer, 10, &value);
 	if (ret)
 		return ret;
+	if (value >= 3)
+		return -EINVAL;
 
-	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
-	if (!r)
-		return -EIO;
-
-	if (r->type != ACPI_TYPE_INTEGER) {
-		kfree(r);
-		return -EIO;
-	}
-
-	m = r->integer.value;
-	kfree(r);
-	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value << 4));
-	kfree(r);
-	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
+	r = lg_wmab(dev, WM_FAN_MODE, WM_SET,
+		FIELD_PREP(FAN_MODE_LOWER, value) |
+		FIELD_PREP(FAN_MODE_UPPER, value));
 	kfree(r);
 
 	return count;
@@ -305,7 +299,7 @@ static ssize_t fan_mode_store(struct device *dev,
 static ssize_t fan_mode_show(struct device *dev,
 			     struct device_attribute *attr, char *buffer)
 {
-	unsigned int status;
+	unsigned int mode;
 	union acpi_object *r;
 
 	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
@@ -317,10 +311,10 @@ static ssize_t fan_mode_show(struct device *dev,
 		return -EIO;
 	}
 
-	status = r->integer.value & 0x01;
+	mode = FIELD_GET(FAN_MODE_LOWER, r->integer.value);
 	kfree(r);
 
-	return sysfs_emit(buffer, "%d\n", status);
+	return sysfs_emit(buffer, "%d\n", mode);
 }
 
 static ssize_t usb_charge_store(struct device *dev,
diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 420e943bb73a..5e6197a6af5e 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -243,7 +243,7 @@ int ufshcd_mcq_memory_alloc(struct ufs_hba *hba)
 		hwq->sqe_base_addr = dmam_alloc_coherent(hba->dev, utrdl_size,
 							 &hwq->sqe_dma_addr,
 							 GFP_KERNEL);
-		if (!hwq->sqe_dma_addr) {
+		if (!hwq->sqe_base_addr) {
 			dev_err(hba->dev, "SQE allocation failed\n");
 			return -ENOMEM;
 		}
@@ -252,7 +252,7 @@ int ufshcd_mcq_memory_alloc(struct ufs_hba *hba)
 		hwq->cqe_base_addr = dmam_alloc_coherent(hba->dev, cqe_size,
 							 &hwq->cqe_dma_addr,
 							 GFP_KERNEL);
-		if (!hwq->cqe_dma_addr) {
+		if (!hwq->cqe_base_addr) {
 			dev_err(hba->dev, "CQE allocation failed\n");
 			return -ENOMEM;
 		}
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index bfd97cad8aa4..c0fd8ab3fe8f 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -734,7 +734,7 @@ void usb_detect_quirks(struct usb_device *udev)
 	udev->quirks ^= usb_detect_dynamic_quirks(udev);
 
 	if (udev->quirks)
-		dev_dbg(&udev->dev, "USB quirks for this device: %x\n",
+		dev_dbg(&udev->dev, "USB quirks for this device: 0x%x\n",
 			udev->quirks);
 
 #ifdef CONFIG_USB_DEFAULT_PERSIST
diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 1fcc9348dd43..123506681ef0 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -458,7 +458,7 @@ static void xhci_dbc_ring_init(struct xhci_ring *ring)
 		trb->link.segment_ptr = cpu_to_le64(ring->first_seg->dma);
 		trb->link.control = cpu_to_le32(LINK_TOGGLE | TRB_TYPE(TRB_LINK));
 	}
-	xhci_initialize_ring_info(ring);
+	xhci_initialize_ring_info(ring, 1);
 }
 
 static int xhci_dbc_reinit_ep_rings(struct xhci_dbc *dbc)
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index c9694526b157..f0ed38da6a0c 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -27,12 +27,14 @@
  * "All components of all Command and Transfer TRBs shall be initialized to '0'"
  */
 static struct xhci_segment *xhci_segment_alloc(struct xhci_hcd *xhci,
+					       unsigned int cycle_state,
 					       unsigned int max_packet,
 					       unsigned int num,
 					       gfp_t flags)
 {
 	struct xhci_segment *seg;
 	dma_addr_t	dma;
+	int		i;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 
 	seg = kzalloc_node(sizeof(*seg), flags, dev_to_node(dev));
@@ -54,6 +56,11 @@ static struct xhci_segment *xhci_segment_alloc(struct xhci_hcd *xhci,
 			return NULL;
 		}
 	}
+	/* If the cycle state is 0, set the cycle bit to 1 for all the TRBs */
+	if (cycle_state == 0) {
+		for (i = 0; i < TRBS_PER_SEGMENT; i++)
+			seg->trbs[i].link.control = cpu_to_le32(TRB_CYCLE);
+	}
 	seg->num = num;
 	seg->dma = dma;
 	seg->next = NULL;
@@ -131,14 +138,6 @@ static void xhci_link_rings(struct xhci_hcd *xhci, struct xhci_ring *ring,
 
 	chain_links = xhci_link_chain_quirk(xhci, ring->type);
 
-	/* If the cycle state is 0, set the cycle bit to 1 for all the TRBs */
-	if (ring->cycle_state == 0) {
-		xhci_for_each_ring_seg(ring->first_seg, seg) {
-			for (int i = 0; i < TRBS_PER_SEGMENT; i++)
-				seg->trbs[i].link.control |= cpu_to_le32(TRB_CYCLE);
-		}
-	}
-
 	next = ring->enq_seg->next;
 	xhci_link_segments(ring->enq_seg, first, ring->type, chain_links);
 	xhci_link_segments(last, next, ring->type, chain_links);
@@ -288,7 +287,8 @@ void xhci_ring_free(struct xhci_hcd *xhci, struct xhci_ring *ring)
 	kfree(ring);
 }
 
-void xhci_initialize_ring_info(struct xhci_ring *ring)
+void xhci_initialize_ring_info(struct xhci_ring *ring,
+			       unsigned int cycle_state)
 {
 	/* The ring is empty, so the enqueue pointer == dequeue pointer */
 	ring->enqueue = ring->first_seg->trbs;
@@ -302,7 +302,7 @@ void xhci_initialize_ring_info(struct xhci_ring *ring)
 	 * New rings are initialized with cycle state equal to 1; if we are
 	 * handling ring expansion, set the cycle state equal to the old ring.
 	 */
-	ring->cycle_state = 1;
+	ring->cycle_state = cycle_state;
 
 	/*
 	 * Each segment has a link TRB, and leave an extra TRB for SW
@@ -317,6 +317,7 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
 					struct xhci_segment **first,
 					struct xhci_segment **last,
 					unsigned int num_segs,
+					unsigned int cycle_state,
 					enum xhci_ring_type type,
 					unsigned int max_packet,
 					gfp_t flags)
@@ -327,7 +328,7 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
 
 	chain_links = xhci_link_chain_quirk(xhci, type);
 
-	prev = xhci_segment_alloc(xhci, max_packet, num, flags);
+	prev = xhci_segment_alloc(xhci, cycle_state, max_packet, num, flags);
 	if (!prev)
 		return -ENOMEM;
 	num++;
@@ -336,7 +337,8 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
 	while (num < num_segs) {
 		struct xhci_segment	*next;
 
-		next = xhci_segment_alloc(xhci, max_packet, num, flags);
+		next = xhci_segment_alloc(xhci, cycle_state, max_packet, num,
+					  flags);
 		if (!next)
 			goto free_segments;
 
@@ -361,8 +363,9 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
  * Set the end flag and the cycle toggle bit on the last segment.
  * See section 4.9.1 and figures 15 and 16.
  */
-struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci, unsigned int num_segs,
-				  enum xhci_ring_type type, unsigned int max_packet, gfp_t flags)
+struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci,
+		unsigned int num_segs, unsigned int cycle_state,
+		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags)
 {
 	struct xhci_ring	*ring;
 	int ret;
@@ -380,7 +383,7 @@ struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci, unsigned int num_segs,
 		return ring;
 
 	ret = xhci_alloc_segments_for_ring(xhci, &ring->first_seg, &ring->last_seg, num_segs,
-					   type, max_packet, flags);
+					   cycle_state, type, max_packet, flags);
 	if (ret)
 		goto fail;
 
@@ -390,7 +393,7 @@ struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci, unsigned int num_segs,
 		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
 			cpu_to_le32(LINK_TOGGLE);
 	}
-	xhci_initialize_ring_info(ring);
+	xhci_initialize_ring_info(ring, cycle_state);
 	trace_xhci_ring_alloc(ring);
 	return ring;
 
@@ -418,8 +421,8 @@ int xhci_ring_expansion(struct xhci_hcd *xhci, struct xhci_ring *ring,
 	struct xhci_segment	*last;
 	int			ret;
 
-	ret = xhci_alloc_segments_for_ring(xhci, &first, &last, num_new_segs, ring->type,
-					   ring->bounce_buf_len, flags);
+	ret = xhci_alloc_segments_for_ring(xhci, &first, &last, num_new_segs, ring->cycle_state,
+					   ring->type, ring->bounce_buf_len, flags);
 	if (ret)
 		return -ENOMEM;
 
@@ -629,7 +632,8 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
 
 	for (cur_stream = 1; cur_stream < num_streams; cur_stream++) {
 		stream_info->stream_rings[cur_stream] =
-			xhci_ring_alloc(xhci, 2, TYPE_STREAM, max_packet, mem_flags);
+			xhci_ring_alloc(xhci, 2, 1, TYPE_STREAM, max_packet,
+					mem_flags);
 		cur_ring = stream_info->stream_rings[cur_stream];
 		if (!cur_ring)
 			goto cleanup_rings;
@@ -970,7 +974,7 @@ int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
 	}
 
 	/* Allocate endpoint 0 ring */
-	dev->eps[0].ring = xhci_ring_alloc(xhci, 2, TYPE_CTRL, 0, flags);
+	dev->eps[0].ring = xhci_ring_alloc(xhci, 2, 1, TYPE_CTRL, 0, flags);
 	if (!dev->eps[0].ring)
 		goto fail;
 
@@ -1453,7 +1457,7 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
 
 	/* Set up the endpoint ring */
 	virt_dev->eps[ep_index].new_ring =
-		xhci_ring_alloc(xhci, 2, ring_type, max_packet, mem_flags);
+		xhci_ring_alloc(xhci, 2, 1, ring_type, max_packet, mem_flags);
 	if (!virt_dev->eps[ep_index].new_ring)
 		return -ENOMEM;
 
@@ -2262,7 +2266,7 @@ xhci_alloc_interrupter(struct xhci_hcd *xhci, unsigned int segs, gfp_t flags)
 	if (!ir)
 		return NULL;
 
-	ir->event_ring = xhci_ring_alloc(xhci, segs, TYPE_EVENT, 0, flags);
+	ir->event_ring = xhci_ring_alloc(xhci, segs, 1, TYPE_EVENT, 0, flags);
 	if (!ir->event_ring) {
 		xhci_warn(xhci, "Failed to allocate interrupter event ring\n");
 		kfree(ir);
@@ -2468,7 +2472,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 		goto fail;
 
 	/* Set up the command ring to have one segments for now. */
-	xhci->cmd_ring = xhci_ring_alloc(xhci, 1, TYPE_COMMAND, 0, flags);
+	xhci->cmd_ring = xhci_ring_alloc(xhci, 1, 1, TYPE_COMMAND, 0, flags);
 	if (!xhci->cmd_ring)
 		goto fail;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 3970ec831b8c..abbf89e82d01 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -769,7 +769,7 @@ static void xhci_clear_command_ring(struct xhci_hcd *xhci)
 		seg->trbs[TRBS_PER_SEGMENT - 1].link.control &= cpu_to_le32(~TRB_CYCLE);
 	}
 
-	xhci_initialize_ring_info(ring);
+	xhci_initialize_ring_info(ring, 1);
 	/*
 	 * Reset the hardware dequeue pointer.
 	 * Yes, this will need to be re-written after resume, but we're paranoid
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index b2aeb444daaf..b4fa8e7e4376 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1803,12 +1803,14 @@ void xhci_slot_copy(struct xhci_hcd *xhci,
 int xhci_endpoint_init(struct xhci_hcd *xhci, struct xhci_virt_device *virt_dev,
 		struct usb_device *udev, struct usb_host_endpoint *ep,
 		gfp_t mem_flags);
-struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci, unsigned int num_segs,
+struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci,
+		unsigned int num_segs, unsigned int cycle_state,
 		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags);
 void xhci_ring_free(struct xhci_hcd *xhci, struct xhci_ring *ring);
 int xhci_ring_expansion(struct xhci_hcd *xhci, struct xhci_ring *ring,
 		unsigned int num_trbs, gfp_t flags);
-void xhci_initialize_ring_info(struct xhci_ring *ring);
+void xhci_initialize_ring_info(struct xhci_ring *ring,
+			unsigned int cycle_state);
 void xhci_free_endpoint_ring(struct xhci_hcd *xhci,
 		struct xhci_virt_device *virt_dev,
 		unsigned int ep_index);
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 893fd66b5269..469f81f880f0 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2492,7 +2492,7 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	unsigned charcount = font->charcount;
 	int w = font->width;
 	int h = font->height;
-	int size;
+	int size, alloc_size;
 	int i, csum;
 	u8 *new_data, *data = font->data;
 	int pitch = PITCH(font->width);
@@ -2519,9 +2519,16 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
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
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 4504e16b458c..5e40e1332259 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -394,13 +394,14 @@ struct afs_server *afs_use_server(struct afs_server *server, enum afs_server_tra
 void afs_put_server(struct afs_net *net, struct afs_server *server,
 		    enum afs_server_trace reason)
 {
-	unsigned int a, debug_id = server->debug_id;
+	unsigned int a, debug_id;
 	bool zero;
 	int r;
 
 	if (!server)
 		return;
 
+	debug_id = server->debug_id;
 	a = atomic_read(&server->active);
 	zero = __refcount_dec_and_test(&server->ref, &r);
 	trace_afs_server(debug_id, r - 1, a, reason);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 58e0cac5779d..ce991a839046 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2699,6 +2699,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		goto error;
 	}
 
+	if (bdev_nr_bytes(file_bdev(bdev_file)) <= BTRFS_DEVICE_RANGE_RESERVED) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	if (fs_devices->seeding) {
 		seeding_dev = true;
 		down_write(&sb->s_umount);
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index c0856585bb63..4aa9a1428dd5 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -594,14 +594,16 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
 
 	/*
 	 * If folio is mapped, it was faulted in after being
-	 * unmapped in caller.  Unmap (again) while holding
-	 * the fault mutex.  The mutex will prevent faults
-	 * until we finish removing the folio.
+	 * unmapped in caller or hugetlb_vmdelete_list() skips
+	 * unmapping it due to fail to grab lock.  Unmap (again)
+	 * while holding the fault mutex.  The mutex will prevent
+	 * faults until we finish removing the folio.  Hold folio
+	 * lock to guarantee no concurrent migration.
 	 */
+	folio_lock(folio);
 	if (unlikely(folio_mapped(folio)))
 		hugetlb_unmap_file_folio(h, mapping, folio, index);
 
-	folio_lock(folio);
 	/*
 	 * We must remove the folio from page cache before removing
 	 * the region/ reserve map (hugetlb_unreserve_pages).  In
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2257bf52fb2a..8f5ad591d762 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2259,6 +2259,9 @@ static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
 {
 	struct page_region *cur_buf = &p->vec_buf[p->vec_buf_index];
 
+	if (!p->vec_buf)
+		return;
+
 	if (cur_buf->start != addr)
 		cur_buf->end = addr;
 	else
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index b51ccfb88439..104a563dc317 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -641,7 +641,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 
 	tmp_rc = rc;
 	for (i = 0; i < num_cmds; i++) {
-		char *buf = rsp_iov[i + i].iov_base;
+		char *buf = rsp_iov[i + 1].iov_base;
 
 		if (buf && resp_buftype[i + 1] != CIFS_NO_BUFFER)
 			rc = server->ops->map_error(buf, false);
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 2fc689f99997..d059c890d142 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -147,7 +147,7 @@ struct smb_direct_transport {
 	wait_queue_head_t	wait_send_pending;
 	atomic_t		send_pending;
 
-	struct delayed_work	post_recv_credits_work;
+	struct work_struct	post_recv_credits_work;
 	struct work_struct	send_immediate_work;
 	struct work_struct	disconnect_work;
 
@@ -366,8 +366,8 @@ static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
 
 	spin_lock_init(&t->lock_new_recv_credits);
 
-	INIT_DELAYED_WORK(&t->post_recv_credits_work,
-			  smb_direct_post_recv_credits);
+	INIT_WORK(&t->post_recv_credits_work,
+		  smb_direct_post_recv_credits);
 	INIT_WORK(&t->send_immediate_work, smb_direct_send_immediate_work);
 	INIT_WORK(&t->disconnect_work, smb_direct_disconnect_rdma_work);
 
@@ -398,9 +398,9 @@ static void free_transport(struct smb_direct_transport *t)
 	wait_event(t->wait_send_pending,
 		   atomic_read(&t->send_pending) == 0);
 
-	cancel_work_sync(&t->disconnect_work);
-	cancel_delayed_work_sync(&t->post_recv_credits_work);
-	cancel_work_sync(&t->send_immediate_work);
+	disable_work_sync(&t->disconnect_work);
+	disable_work_sync(&t->post_recv_credits_work);
+	disable_work_sync(&t->send_immediate_work);
 
 	if (t->qp) {
 		ib_drain_qp(t->qp);
@@ -614,8 +614,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 			wake_up_interruptible(&t->wait_send_credits);
 
 		if (is_receive_credit_post_required(receive_credits, avail_recvmsg_count))
-			mod_delayed_work(smb_direct_wq,
-					 &t->post_recv_credits_work, 0);
+			queue_work(smb_direct_wq, &t->post_recv_credits_work);
 
 		if (data_length) {
 			enqueue_reassembly(t, recvmsg, (int)data_length);
@@ -772,8 +771,7 @@ static int smb_direct_read(struct ksmbd_transport *t, char *buf,
 		st->count_avail_recvmsg += queue_removed;
 		if (is_receive_credit_post_required(st->recv_credits, st->count_avail_recvmsg)) {
 			spin_unlock(&st->receive_credit_lock);
-			mod_delayed_work(smb_direct_wq,
-					 &st->post_recv_credits_work, 0);
+			queue_work(smb_direct_wq, &st->post_recv_credits_work);
 		} else {
 			spin_unlock(&st->receive_credit_lock);
 		}
@@ -800,7 +798,7 @@ static int smb_direct_read(struct ksmbd_transport *t, char *buf,
 static void smb_direct_post_recv_credits(struct work_struct *work)
 {
 	struct smb_direct_transport *t = container_of(work,
-		struct smb_direct_transport, post_recv_credits_work.work);
+		struct smb_direct_transport, post_recv_credits_work);
 	struct smb_direct_recvmsg *recvmsg;
 	int receive_credits, credits = 0;
 	int ret;
@@ -1681,7 +1679,7 @@ static int smb_direct_prepare_negotiation(struct smb_direct_transport *t)
 		goto out_err;
 	}
 
-	smb_direct_post_recv_credits(&t->post_recv_credits_work.work);
+	smb_direct_post_recv_credits(&t->post_recv_credits_work);
 	return 0;
 out_err:
 	put_recvmsg(t, recvmsg);
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 0c70f3a55575..107b797c33ec 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -152,7 +152,7 @@ struct af_alg_ctx {
 	size_t used;
 	atomic_t rcvused;
 
-	u32		more:1,
+	bool		more:1,
 			merge:1,
 			enc:1,
 			write:1,
diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
index 9b85a3f028d1..61f7a02b0500 100644
--- a/include/linux/firmware/imx/sm.h
+++ b/include/linux/firmware/imx/sm.h
@@ -17,7 +17,19 @@
 #define SCMI_IMX_CTRL_SAI4_MCLK		4	/* WAKE SAI4 MCLK */
 #define SCMI_IMX_CTRL_SAI5_MCLK		5	/* WAKE SAI5 MCLK */
 
+#if IS_ENABLED(CONFIG_IMX_SCMI_MISC_DRV)
 int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
 int scmi_imx_misc_ctrl_set(u32 id, u32 val);
+#else
+static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 
 #endif
diff --git a/include/linux/swap.h b/include/linux/swap.h
index f3e0ac20c2e8..63f85b3fee23 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -382,6 +382,16 @@ void folio_add_lru_vma(struct folio *, struct vm_area_struct *);
 void mark_page_accessed(struct page *);
 void folio_mark_accessed(struct folio *);
 
+static inline bool folio_may_be_lru_cached(struct folio *folio)
+{
+	/*
+	 * Holding PMD-sized folios in per-CPU LRU cache unbalances accounting.
+	 * Holding small numbers of low-order mTHP folios in per-CPU LRU cache
+	 * will be sensible, but nobody has implemented and tested that yet.
+	 */
+	return !folio_test_large(folio);
+}
+
 extern atomic_t lru_disable_count;
 
 static inline bool lru_cache_disabled(void)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index df4af45f8603..69a1d8b12bef 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1203,6 +1203,27 @@ static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *hci_conn_hash_lookup_role(struct hci_dev *hdev,
+							 __u8 type, __u8 role,
+							 bdaddr_t *ba)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == type && c->role == role && !bacmp(&c->dst, ba)) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 						       bdaddr_t *ba,
 						       __u8 ba_type)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9380e0fd5e4a..1f51c8f20722 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2953,7 +2953,10 @@ EXPORT_SYMBOL_GPL(bpf_event_output);
 
 /* Always built-in helper functions. */
 const struct bpf_func_proto bpf_tail_call_proto = {
-	.func		= NULL,
+	/* func is unused for tail_call, we set it to pass the
+	 * get_helper_proto check
+	 */
+	.func		= BPF_PTR_POISON,
 	.gpl_only	= false,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_CTX,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 24ae8f33e5d7..1829f62a74a9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7799,6 +7799,10 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		verbose(env, "verifier bug. Two map pointers in a timer helper\n");
 		return -EFAULT;
 	}
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
+		return -EOPNOTSUPP;
+	}
 	meta->map_uid = reg->map_uid;
 	meta->map_ptr = map;
 	return 0;
@@ -10465,7 +10469,7 @@ static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
 		return -EINVAL;
 
 	*ptr = env->ops->get_func_proto(func_id, env->prog);
-	return *ptr ? 0 : -EINVAL;
+	return *ptr && (*ptr)->func ? 0 : -EINVAL;
 }
 
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index b47bb764b352..559aae55792c 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -225,18 +225,20 @@ static inline
 void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
 			   struct futex_hash_bucket *hb)
 {
-	q->key = *key;
+	struct task_struct *task;
 
+	q->key = *key;
 	__futex_unqueue(q);
 
 	WARN_ON(!q->rt_waiter);
 	q->rt_waiter = NULL;
 
 	q->lock_ptr = &hb->lock;
+	task = READ_ONCE(q->task);
 
 	/* Signal locked state to the waiter */
 	futex_requeue_pi_complete(q, 1);
-	wake_up_state(q->task, TASK_NORMAL);
+	wake_up_state(task, TASK_NORMAL);
 }
 
 /**
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index c9b0533407ed..76737492e750 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -239,6 +239,10 @@ static int dyn_event_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	ret = tracing_check_open_get_tr(NULL);
 	if (ret)
 		return ret;
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 2f844c279a3e..7f24ccc896c6 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
 	 * freeing it below.
 	 */
 	wait_for_completion(&vtsk->exited);
+	put_task_struct(vtsk->task);
 	kfree(vtsk);
 }
 EXPORT_SYMBOL_GPL(vhost_task_stop);
@@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
 		return ERR_PTR(PTR_ERR(tsk));
 	}
 
-	vtsk->task = tsk;
+	vtsk->task = get_task_struct(tsk);
 	return vtsk;
 }
 EXPORT_SYMBOL_GPL(vhost_task_create);
diff --git a/mm/gup.c b/mm/gup.c
index e9be7c49542a..d105817a0c9a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2356,8 +2356,8 @@ static unsigned long collect_longterm_unpinnable_folios(
 		struct pages_or_folios *pofs)
 {
 	unsigned long collected = 0;
-	bool drain_allow = true;
 	struct folio *folio;
+	int drained = 0;
 	long i = 0;
 
 	for (folio = pofs_get_folio(pofs, i); folio;
@@ -2376,10 +2376,17 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (drain_allow && folio_ref_count(folio) !=
-				   folio_expected_ref_count(folio) + 1) {
+		if (drained == 0 && folio_may_be_lru_cached(folio) &&
+				folio_ref_count(folio) !=
+				folio_expected_ref_count(folio) + 1) {
+			lru_add_drain();
+			drained = 1;
+		}
+		if (drained == 1 && folio_may_be_lru_cached(folio) &&
+				folio_ref_count(folio) !=
+				folio_expected_ref_count(folio) + 1) {
 			lru_add_drain_all();
-			drain_allow = false;
+			drained = 2;
 		}
 
 		if (!folio_isolate_lru(folio))
diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index a495debf1436..abb79a6c0769 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -195,7 +195,8 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 				      u32 origin, bool checked)
 {
 	u64 address = (u64)addr;
-	u32 *shadow_start, *origin_start;
+	void *shadow_start;
+	u32 *aligned_shadow, *origin_start;
 	size_t pad = 0;
 
 	KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(addr, size));
@@ -214,9 +215,12 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 	}
 	__memset(shadow_start, b, size);
 
-	if (!IS_ALIGNED(address, KMSAN_ORIGIN_SIZE)) {
+	if (IS_ALIGNED(address, KMSAN_ORIGIN_SIZE)) {
+		aligned_shadow = shadow_start;
+	} else {
 		pad = address % KMSAN_ORIGIN_SIZE;
 		address -= pad;
+		aligned_shadow = shadow_start - pad;
 		size += pad;
 	}
 	size = ALIGN(size, KMSAN_ORIGIN_SIZE);
@@ -230,7 +234,7 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 	 * corresponding shadow slot is zero.
 	 */
 	for (int i = 0; i < size / KMSAN_ORIGIN_SIZE; i++) {
-		if (origin || !shadow_start[i])
+		if (origin || !aligned_shadow[i])
 			origin_start[i] = origin;
 	}
 }
diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 13236d579eba..c95a8e72e496 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -556,6 +556,21 @@ DEFINE_TEST_MEMSETXX(16)
 DEFINE_TEST_MEMSETXX(32)
 DEFINE_TEST_MEMSETXX(64)
 
+/* Test case: ensure that KMSAN does not access shadow memory out of bounds. */
+static void test_memset_on_guarded_buffer(struct kunit *test)
+{
+	void *buf = vmalloc(PAGE_SIZE);
+
+	kunit_info(test,
+		   "memset() on ends of guarded buffer should not crash\n");
+
+	for (size_t size = 0; size <= 128; size++) {
+		memset(buf, 0xff, size);
+		memset(buf + PAGE_SIZE - size, 0xff, size);
+	}
+	vfree(buf);
+}
+
 static noinline void fibonacci(int *array, int size, int start)
 {
 	if (start < 2 || (start == size))
@@ -661,6 +676,7 @@ static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_memset16),
 	KUNIT_CASE(test_memset32),
 	KUNIT_CASE(test_memset64),
+	KUNIT_CASE(test_memset_on_guarded_buffer),
 	KUNIT_CASE(test_long_origin_chain),
 	KUNIT_CASE(test_stackdepot_roundtrip),
 	KUNIT_CASE(test_unpoison_memory),
diff --git a/mm/mlock.c b/mm/mlock.c
index cde076fa7d5e..8c8d522efdd5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -255,7 +255,7 @@ void mlock_folio(struct folio *folio)
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_lru(folio)) ||
-	    folio_test_large(folio) || lru_cache_disabled())
+	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
 }
@@ -278,7 +278,7 @@ void mlock_new_folio(struct folio *folio)
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_new(folio)) ||
-	    folio_test_large(folio) || lru_cache_disabled())
+	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
 }
@@ -299,7 +299,7 @@ void munlock_folio(struct folio *folio)
 	 */
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, folio) ||
-	    folio_test_large(folio) || lru_cache_disabled())
+	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
 }
diff --git a/mm/swap.c b/mm/swap.c
index 59f30a981c6f..ff846915db45 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -195,6 +195,10 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 	for (i = 0; i < folio_batch_count(fbatch); i++) {
 		struct folio *folio = fbatch->folios[i];
 
+		/* block memcg migration while the folio moves between lru */
+		if (move_fn != lru_add && !folio_test_clear_lru(folio))
+			continue;
+
 		folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
 		move_fn(lruvec, folio);
 
@@ -207,14 +211,10 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 }
 
 static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
-		struct folio *folio, move_fn_t move_fn,
-		bool on_lru, bool disable_irq)
+		struct folio *folio, move_fn_t move_fn, bool disable_irq)
 {
 	unsigned long flags;
 
-	if (on_lru && !folio_test_clear_lru(folio))
-		return;
-
 	folio_get(folio);
 
 	if (disable_irq)
@@ -222,8 +222,8 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 	else
 		local_lock(&cpu_fbatches.lock);
 
-	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) || folio_test_large(folio) ||
-	    lru_cache_disabled())
+	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
+			!folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
 
 	if (disable_irq)
@@ -232,13 +232,13 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 		local_unlock(&cpu_fbatches.lock);
 }
 
-#define folio_batch_add_and_move(folio, op, on_lru)						\
-	__folio_batch_add_and_move(								\
-		&cpu_fbatches.op,								\
-		folio,										\
-		op,										\
-		on_lru,										\
-		offsetof(struct cpu_fbatches, op) >= offsetof(struct cpu_fbatches, lock_irq)	\
+#define folio_batch_add_and_move(folio, op)		\
+	__folio_batch_add_and_move(			\
+		&cpu_fbatches.op,			\
+		folio,					\
+		op,					\
+		offsetof(struct cpu_fbatches, op) >=	\
+		offsetof(struct cpu_fbatches, lock_irq)	\
 	)
 
 static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)
@@ -262,10 +262,10 @@ static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)
 void folio_rotate_reclaimable(struct folio *folio)
 {
 	if (folio_test_locked(folio) || folio_test_dirty(folio) ||
-	    folio_test_unevictable(folio))
+	    folio_test_unevictable(folio) || !folio_test_lru(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_move_tail, true);
+	folio_batch_add_and_move(folio, lru_move_tail);
 }
 
 void lru_note_cost(struct lruvec *lruvec, bool file,
@@ -354,10 +354,11 @@ static void folio_activate_drain(int cpu)
 
 void folio_activate(struct folio *folio)
 {
-	if (folio_test_active(folio) || folio_test_unevictable(folio))
+	if (folio_test_active(folio) || folio_test_unevictable(folio) ||
+	    !folio_test_lru(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_activate, true);
+	folio_batch_add_and_move(folio, lru_activate);
 }
 
 #else
@@ -510,7 +511,7 @@ void folio_add_lru(struct folio *folio)
 	    lru_gen_in_fault() && !(current->flags & PF_MEMALLOC))
 		folio_set_active(folio);
 
-	folio_batch_add_and_move(folio, lru_add, false);
+	folio_batch_add_and_move(folio, lru_add);
 }
 EXPORT_SYMBOL(folio_add_lru);
 
@@ -685,10 +686,10 @@ void lru_add_drain_cpu(int cpu)
 void deactivate_file_folio(struct folio *folio)
 {
 	/* Deactivating an unevictable folio will not accelerate reclaim */
-	if (folio_test_unevictable(folio))
+	if (folio_test_unevictable(folio) || !folio_test_lru(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_deactivate_file, true);
+	folio_batch_add_and_move(folio, lru_deactivate_file);
 }
 
 /*
@@ -701,10 +702,11 @@ void deactivate_file_folio(struct folio *folio)
  */
 void folio_deactivate(struct folio *folio)
 {
-	if (folio_test_unevictable(folio) || !(folio_test_active(folio) || lru_gen_enabled()))
+	if (folio_test_unevictable(folio) || !folio_test_lru(folio) ||
+	    !(folio_test_active(folio) || lru_gen_enabled()))
 		return;
 
-	folio_batch_add_and_move(folio, lru_deactivate, true);
+	folio_batch_add_and_move(folio, lru_deactivate);
 }
 
 /**
@@ -717,10 +719,11 @@ void folio_deactivate(struct folio *folio)
 void folio_mark_lazyfree(struct folio *folio)
 {
 	if (!folio_test_anon(folio) || !folio_test_swapbacked(folio) ||
+	    !folio_test_lru(folio) ||
 	    folio_test_swapcache(folio) || folio_test_unevictable(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_lazyfree, true);
+	folio_batch_add_and_move(folio, lru_lazyfree);
 }
 
 void lru_add_drain(void)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 262ff30261d6..1e537ed83ba4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3050,8 +3050,18 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	/* Check for existing connection:
+	 *
+	 * 1. If it doesn't exist then it must be receiver/slave role.
+	 * 2. If it does exist confirm that it is connecting/BT_CONNECT in case
+	 *    of initiator/master role since there could be a collision where
+	 *    either side is attempting to connect or something like a fuzzing
+	 *    testing is trying to play tricks to destroy the hcon object before
+	 *    it even attempts to connect (e.g. hcon->state == BT_OPEN).
+	 */
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
-	if (!conn) {
+	if (!conn ||
+	    (conn->role == HCI_ROLE_MASTER && conn->state != BT_CONNECT)) {
 		/* In case of error status and there is no connection pending
 		 * just unlock as there is nothing to cleanup.
 		 */
@@ -5618,8 +5628,18 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	 */
 	hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
-	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, bdaddr);
-	if (!conn) {
+	/* Check for existing connection:
+	 *
+	 * 1. If it doesn't exist then use the role to create a new object.
+	 * 2. If it does exist confirm that it is connecting/BT_CONNECT in case
+	 *    of initiator/master role since there could be a collision where
+	 *    either side is attempting to connect or something like a fuzzing
+	 *    testing is trying to play tricks to destroy the hcon object before
+	 *    it even attempts to connect (e.g. hcon->state == BT_OPEN).
+	 */
+	conn = hci_conn_hash_lookup_role(hdev, LE_LINK, role, bdaddr);
+	if (!conn ||
+	    (conn->role == HCI_ROLE_MASTER && conn->state != BT_CONNECT)) {
 		/* In case of error status and there is no connection pending
 		 * just unlock as there is nothing to cleanup.
 		 */
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5f5137764b80..333f32a9fd21 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2604,6 +2604,13 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 			hci_remove_ext_adv_instance_sync(hdev, adv->instance,
 							 NULL);
 		}
+
+		/* If current advertising instance is set to instance 0x00
+		 * then we need to re-enable it.
+		 */
+		if (!hdev->cur_adv_instance)
+			err = hci_enable_ext_advertising_sync(hdev,
+							      hdev->cur_adv_instance);
 	} else {
 		/* Schedule for most recent instance to be restarted and begin
 		 * the software rotation loop
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index cf54593149cc..6a92c03ee6f4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6603,7 +6603,7 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
 		return NULL;
 
 	while (data_len) {
-		if (nr_frags == MAX_SKB_FRAGS - 1)
+		if (nr_frags == MAX_SKB_FRAGS)
 			goto failure;
 		while (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << order))
 			order--;
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 93aaea0006ba..c52ff9364ae8 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2375,6 +2375,13 @@ static int replace_nexthop_single(struct net *net, struct nexthop *old,
 		return -EINVAL;
 	}
 
+	if (!list_empty(&old->grp_list) &&
+	    rtnl_dereference(new->nh_info)->fdb_nh !=
+	    rtnl_dereference(old->nh_info)->fdb_nh) {
+		NL_SET_ERR_MSG(extack, "Cannot change nexthop FDB status while in a group");
+		return -EINVAL;
+	}
+
 	err = call_nexthop_notifiers(net, NEXTHOP_EVENT_REPLACE, new, extack);
 	if (err)
 		return err;
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 3c5f64ca4115..85f0b7853b17 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -56,6 +56,7 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 {
 	struct smc_lo_dmb_node *dmb_node, *tmp_node;
 	struct smc_lo_dev *ldev = smcd->priv;
+	struct folio *folio;
 	int sba_idx, rc;
 
 	/* check space for new dmb */
@@ -74,13 +75,16 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 
 	dmb_node->sba_idx = sba_idx;
 	dmb_node->len = dmb->dmb_len;
-	dmb_node->cpu_addr = kzalloc(dmb_node->len, GFP_KERNEL |
-				     __GFP_NOWARN | __GFP_NORETRY |
-				     __GFP_NOMEMALLOC);
-	if (!dmb_node->cpu_addr) {
+
+	/* not critical; fail under memory pressure and fallback to TCP */
+	folio = folio_alloc(GFP_KERNEL | __GFP_NOWARN | __GFP_NOMEMALLOC |
+			    __GFP_NORETRY | __GFP_ZERO,
+			    get_order(dmb_node->len));
+	if (!folio) {
 		rc = -ENOMEM;
 		goto err_node;
 	}
+	dmb_node->cpu_addr = folio_address(folio);
 	dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
 	refcount_set(&dmb_node->refcnt, 1);
 
@@ -122,7 +126,7 @@ static void __smc_lo_unregister_dmb(struct smc_lo_dev *ldev,
 	write_unlock_bh(&ldev->dmb_ht_lock);
 
 	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
-	kvfree(dmb_node->cpu_addr);
+	folio_put(virt_to_folio(dmb_node->cpu_addr));
 	kfree(dmb_node);
 
 	if (atomic_dec_and_test(&ldev->dmb_cnt))
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 6f99fd2d966c..1e2f5ecd6324 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2502,6 +2502,8 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 
 	for (h = 0; h < range; h++) {
 		u32 spi = (low == high) ? low : get_random_u32_inclusive(low, high);
+		if (spi == 0)
+			goto next;
 		newspi = htonl(spi);
 
 		spin_lock_bh(&net->xfrm.xfrm_state_lock);
@@ -2517,6 +2519,7 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 		xfrm_state_put(x0);
 		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
+next:
 		if (signal_pending(current)) {
 			err = -ERESTARTSYS;
 			goto unlock;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5f061d2d9fc9..a41df821e15f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7272,6 +7272,11 @@ static void cs35l41_fixup_spi_two(struct hda_codec *codec, const struct hda_fixu
 	comp_generic_fixup(codec, action, "spi", "CSC3551", "-%s:00-cs35l41-hda.%d", 2);
 }
 
+static void cs35l41_fixup_spi_one(struct hda_codec *codec, const struct hda_fixup *fix, int action)
+{
+	comp_generic_fixup(codec, action, "spi", "CSC3551", "-%s:00-cs35l41-hda.%d", 1);
+}
+
 static void cs35l41_fixup_spi_four(struct hda_codec *codec, const struct hda_fixup *fix, int action)
 {
 	comp_generic_fixup(codec, action, "spi", "CSC3551", "-%s:00-cs35l41-hda.%d", 4);
@@ -7956,6 +7961,7 @@ enum {
 	ALC287_FIXUP_CS35L41_I2C_2,
 	ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED,
 	ALC287_FIXUP_CS35L41_I2C_4,
+	ALC245_FIXUP_CS35L41_SPI_1,
 	ALC245_FIXUP_CS35L41_SPI_2,
 	ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED,
 	ALC245_FIXUP_CS35L41_SPI_4,
@@ -10067,6 +10073,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35l41_fixup_spi_two,
 	},
+	[ALC245_FIXUP_CS35L41_SPI_1] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_spi_one,
+	},
 	[ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35l41_fixup_spi_two,
@@ -11001,6 +11011,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x8398, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x83ce, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x8516, "ASUS X101CH", ALC269_FIXUP_ASUS_X101),
+	SND_PCI_QUIRK(0x1043, 0x88f4, "ASUS NUC14LNS", ALC245_FIXUP_CS35L41_SPI_1),
 	SND_PCI_QUIRK(0x104d, 0x9073, "Sony VAIO", ALC275_FIXUP_SONY_VAIO_GPIO2),
 	SND_PCI_QUIRK(0x104d, 0x907b, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
 	SND_PCI_QUIRK(0x104d, 0x9084, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 7bd87193c617..b663764644cd 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -17,6 +17,7 @@
 #include <linux/bitfield.h>
 #include <linux/hid.h>
 #include <linux/init.h>
+#include <linux/input.h>
 #include <linux/math64.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
@@ -54,13 +55,13 @@ struct std_mono_table {
  * version, we keep it mono for simplicity.
  */
 static int snd_create_std_mono_ctl_offset(struct usb_mixer_interface *mixer,
-				unsigned int unitid,
-				unsigned int control,
-				unsigned int cmask,
-				int val_type,
-				unsigned int idx_off,
-				const char *name,
-				snd_kcontrol_tlv_rw_t *tlv_callback)
+					  unsigned int unitid,
+					  unsigned int control,
+					  unsigned int cmask,
+					  int val_type,
+					  unsigned int idx_off,
+					  const char *name,
+					  snd_kcontrol_tlv_rw_t *tlv_callback)
 {
 	struct usb_mixer_elem_info *cval;
 	struct snd_kcontrol *kctl;
@@ -77,7 +78,8 @@ static int snd_create_std_mono_ctl_offset(struct usb_mixer_interface *mixer,
 	cval->idx_off = idx_off;
 
 	/* get_min_max() is called only for integer volumes later,
-	 * so provide a short-cut for booleans */
+	 * so provide a short-cut for booleans
+	 */
 	cval->min = 0;
 	cval->max = 1;
 	cval->res = 0;
@@ -107,15 +109,16 @@ static int snd_create_std_mono_ctl_offset(struct usb_mixer_interface *mixer,
 }
 
 static int snd_create_std_mono_ctl(struct usb_mixer_interface *mixer,
-				unsigned int unitid,
-				unsigned int control,
-				unsigned int cmask,
-				int val_type,
-				const char *name,
-				snd_kcontrol_tlv_rw_t *tlv_callback)
+				   unsigned int unitid,
+				   unsigned int control,
+				   unsigned int cmask,
+				   int val_type,
+				   const char *name,
+				   snd_kcontrol_tlv_rw_t *tlv_callback)
 {
 	return snd_create_std_mono_ctl_offset(mixer, unitid, control, cmask,
-		val_type, 0 /* Offset */, name, tlv_callback);
+					      val_type, 0 /* Offset */,
+					      name, tlv_callback);
 }
 
 /*
@@ -126,9 +129,10 @@ static int snd_create_std_mono_table(struct usb_mixer_interface *mixer,
 {
 	int err;
 
-	while (t->name != NULL) {
+	while (t->name) {
 		err = snd_create_std_mono_ctl(mixer, t->unitid, t->control,
-				t->cmask, t->val_type, t->name, t->tlv_callback);
+					      t->cmask, t->val_type, t->name,
+					      t->tlv_callback);
 		if (err < 0)
 			return err;
 		t++;
@@ -208,12 +212,11 @@ static void snd_usb_soundblaster_remote_complete(struct urb *urb)
 	if (code == rc->mute_code)
 		snd_usb_mixer_notify_id(mixer, rc->mute_mixer_id);
 	mixer->rc_code = code;
-	wmb();
 	wake_up(&mixer->rc_waitq);
 }
 
 static long snd_usb_sbrc_hwdep_read(struct snd_hwdep *hw, char __user *buf,
-				     long count, loff_t *offset)
+				    long count, loff_t *offset)
 {
 	struct usb_mixer_interface *mixer = hw->private_data;
 	int err;
@@ -233,7 +236,7 @@ static long snd_usb_sbrc_hwdep_read(struct snd_hwdep *hw, char __user *buf,
 }
 
 static __poll_t snd_usb_sbrc_hwdep_poll(struct snd_hwdep *hw, struct file *file,
-					    poll_table *wait)
+					poll_table *wait)
 {
 	struct usb_mixer_interface *mixer = hw->private_data;
 
@@ -309,20 +312,20 @@ static int snd_audigy2nx_led_update(struct usb_mixer_interface *mixer,
 
 	if (chip->usb_id == USB_ID(0x041e, 0x3042))
 		err = snd_usb_ctl_msg(chip->dev,
-			      usb_sndctrlpipe(chip->dev, 0), 0x24,
-			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-			      !value, 0, NULL, 0);
+				      usb_sndctrlpipe(chip->dev, 0), 0x24,
+				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+				      !value, 0, NULL, 0);
 	/* USB X-Fi S51 Pro */
 	if (chip->usb_id == USB_ID(0x041e, 0x30df))
 		err = snd_usb_ctl_msg(chip->dev,
-			      usb_sndctrlpipe(chip->dev, 0), 0x24,
-			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-			      !value, 0, NULL, 0);
+				      usb_sndctrlpipe(chip->dev, 0), 0x24,
+				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+				      !value, 0, NULL, 0);
 	else
 		err = snd_usb_ctl_msg(chip->dev,
-			      usb_sndctrlpipe(chip->dev, 0), 0x24,
-			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-			      value, index + 2, NULL, 0);
+				      usb_sndctrlpipe(chip->dev, 0), 0x24,
+				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+				      value, index + 2, NULL, 0);
 	snd_usb_unlock_shutdown(chip);
 	return err;
 }
@@ -376,10 +379,10 @@ static int snd_audigy2nx_controls_create(struct usb_mixer_interface *mixer)
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
@@ -480,9 +483,9 @@ static int snd_emu0204_ch_switch_update(struct usb_mixer_interface *mixer,
 	buf[0] = 0x01;
 	buf[1] = value ? 0x02 : 0x01;
 	err = snd_usb_ctl_msg(chip->dev,
-		      usb_sndctrlpipe(chip->dev, 0), UAC_SET_CUR,
-		      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
-		      0x0400, 0x0e00, buf, 2);
+			      usb_sndctrlpipe(chip->dev, 0), UAC_SET_CUR,
+			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
+			      0x0400, 0x0e00, buf, 2);
 	snd_usb_unlock_shutdown(chip);
 	return err;
 }
@@ -528,6 +531,265 @@ static int snd_emu0204_controls_create(struct usb_mixer_interface *mixer)
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
@@ -1020,7 +1282,7 @@ static int snd_nativeinstruments_create_mixer(struct usb_mixer_interface *mixer,
 /* M-Audio FastTrack Ultra quirks */
 /* FTU Effect switch (also used by C400/C600) */
 static int snd_ftu_eff_switch_info(struct snd_kcontrol *kcontrol,
-					struct snd_ctl_elem_info *uinfo)
+				   struct snd_ctl_elem_info *uinfo)
 {
 	static const char *const texts[8] = {
 		"Room 1", "Room 2", "Room 3", "Hall 1",
@@ -1054,7 +1316,7 @@ static int snd_ftu_eff_switch_init(struct usb_mixer_interface *mixer,
 }
 
 static int snd_ftu_eff_switch_get(struct snd_kcontrol *kctl,
-					struct snd_ctl_elem_value *ucontrol)
+				  struct snd_ctl_elem_value *ucontrol)
 {
 	ucontrol->value.enumerated.item[0] = kctl->private_value >> 24;
 	return 0;
@@ -1085,7 +1347,7 @@ static int snd_ftu_eff_switch_update(struct usb_mixer_elem_list *list)
 }
 
 static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
-					struct snd_ctl_elem_value *ucontrol)
+				  struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kctl);
 	unsigned int pval = list->kctl->private_value;
@@ -1103,7 +1365,7 @@ static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
 }
 
 static int snd_ftu_create_effect_switch(struct usb_mixer_interface *mixer,
-	int validx, int bUnitID)
+					int validx, int bUnitID)
 {
 	static struct snd_kcontrol_new template = {
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -1142,22 +1404,22 @@ static int snd_ftu_create_volume_ctls(struct usb_mixer_interface *mixer)
 		for (in = 0; in < 8; in++) {
 			cmask = BIT(in);
 			snprintf(name, sizeof(name),
-				"AIn%d - Out%d Capture Volume",
-				in  + 1, out + 1);
+				 "AIn%d - Out%d Capture Volume",
+				 in  + 1, out + 1);
 			err = snd_create_std_mono_ctl(mixer, id, control,
-							cmask, val_type, name,
-							&snd_usb_mixer_vol_tlv);
+						      cmask, val_type, name,
+						      &snd_usb_mixer_vol_tlv);
 			if (err < 0)
 				return err;
 		}
 		for (in = 8; in < 16; in++) {
 			cmask = BIT(in);
 			snprintf(name, sizeof(name),
-				"DIn%d - Out%d Playback Volume",
-				in - 7, out + 1);
+				 "DIn%d - Out%d Playback Volume",
+				 in - 7, out + 1);
 			err = snd_create_std_mono_ctl(mixer, id, control,
-							cmask, val_type, name,
-							&snd_usb_mixer_vol_tlv);
+						      cmask, val_type, name,
+						      &snd_usb_mixer_vol_tlv);
 			if (err < 0)
 				return err;
 		}
@@ -1218,10 +1480,10 @@ static int snd_ftu_create_effect_return_ctls(struct usb_mixer_interface *mixer)
 	for (ch = 0; ch < 4; ++ch) {
 		cmask = BIT(ch);
 		snprintf(name, sizeof(name),
-			"Effect Return %d Volume", ch + 1);
+			 "Effect Return %d Volume", ch + 1);
 		err = snd_create_std_mono_ctl(mixer, id, control,
-						cmask, val_type, name,
-						snd_usb_mixer_vol_tlv);
+					      cmask, val_type, name,
+					      snd_usb_mixer_vol_tlv);
 		if (err < 0)
 			return err;
 	}
@@ -1242,20 +1504,20 @@ static int snd_ftu_create_effect_send_ctls(struct usb_mixer_interface *mixer)
 	for (ch = 0; ch < 8; ++ch) {
 		cmask = BIT(ch);
 		snprintf(name, sizeof(name),
-			"Effect Send AIn%d Volume", ch + 1);
+			 "Effect Send AIn%d Volume", ch + 1);
 		err = snd_create_std_mono_ctl(mixer, id, control, cmask,
-						val_type, name,
-						snd_usb_mixer_vol_tlv);
+					      val_type, name,
+					      snd_usb_mixer_vol_tlv);
 		if (err < 0)
 			return err;
 	}
 	for (ch = 8; ch < 16; ++ch) {
 		cmask = BIT(ch);
 		snprintf(name, sizeof(name),
-			"Effect Send DIn%d Volume", ch - 7);
+			 "Effect Send DIn%d Volume", ch - 7);
 		err = snd_create_std_mono_ctl(mixer, id, control, cmask,
-						val_type, name,
-						snd_usb_mixer_vol_tlv);
+					      val_type, name,
+					      snd_usb_mixer_vol_tlv);
 		if (err < 0)
 			return err;
 	}
@@ -1345,19 +1607,19 @@ static int snd_c400_create_vol_ctls(struct usb_mixer_interface *mixer)
 		for (out = 0; out < num_outs; out++) {
 			if (chan < num_outs) {
 				snprintf(name, sizeof(name),
-					"PCM%d-Out%d Playback Volume",
-					chan + 1, out + 1);
+					 "PCM%d-Out%d Playback Volume",
+					 chan + 1, out + 1);
 			} else {
 				snprintf(name, sizeof(name),
-					"In%d-Out%d Playback Volume",
-					chan - num_outs + 1, out + 1);
+					 "In%d-Out%d Playback Volume",
+					 chan - num_outs + 1, out + 1);
 			}
 
 			cmask = (out == 0) ? 0 : BIT(out - 1);
 			offset = chan * num_outs;
 			err = snd_create_std_mono_ctl_offset(mixer, id, control,
-						cmask, val_type, offset, name,
-						&snd_usb_mixer_vol_tlv);
+							     cmask, val_type, offset, name,
+							     &snd_usb_mixer_vol_tlv);
 			if (err < 0)
 				return err;
 		}
@@ -1376,7 +1638,7 @@ static int snd_c400_create_effect_volume_ctl(struct usb_mixer_interface *mixer)
 	const unsigned int cmask = 0;
 
 	return snd_create_std_mono_ctl(mixer, id, control, cmask, val_type,
-					name, snd_usb_mixer_vol_tlv);
+				       name, snd_usb_mixer_vol_tlv);
 }
 
 /* This control needs a volume quirk, see mixer.c */
@@ -1389,7 +1651,7 @@ static int snd_c400_create_effect_duration_ctl(struct usb_mixer_interface *mixer
 	const unsigned int cmask = 0;
 
 	return snd_create_std_mono_ctl(mixer, id, control, cmask, val_type,
-					name, snd_usb_mixer_vol_tlv);
+				       name, snd_usb_mixer_vol_tlv);
 }
 
 /* This control needs a volume quirk, see mixer.c */
@@ -1402,7 +1664,7 @@ static int snd_c400_create_effect_feedback_ctl(struct usb_mixer_interface *mixer
 	const unsigned int cmask = 0;
 
 	return snd_create_std_mono_ctl(mixer, id, control, cmask, val_type,
-					name, NULL);
+				       name, NULL);
 }
 
 static int snd_c400_create_effect_vol_ctls(struct usb_mixer_interface *mixer)
@@ -1431,18 +1693,18 @@ static int snd_c400_create_effect_vol_ctls(struct usb_mixer_interface *mixer)
 	for (chan = 0; chan < num_outs + num_ins; chan++) {
 		if (chan < num_outs) {
 			snprintf(name, sizeof(name),
-				"Effect Send DOut%d",
-				chan + 1);
+				 "Effect Send DOut%d",
+				 chan + 1);
 		} else {
 			snprintf(name, sizeof(name),
-				"Effect Send AIn%d",
-				chan - num_outs + 1);
+				 "Effect Send AIn%d",
+				 chan - num_outs + 1);
 		}
 
 		cmask = (chan == 0) ? 0 : BIT(chan - 1);
 		err = snd_create_std_mono_ctl(mixer, id, control,
-						cmask, val_type, name,
-						&snd_usb_mixer_vol_tlv);
+					      cmask, val_type, name,
+					      &snd_usb_mixer_vol_tlv);
 		if (err < 0)
 			return err;
 	}
@@ -1477,14 +1739,14 @@ static int snd_c400_create_effect_ret_vol_ctls(struct usb_mixer_interface *mixer
 
 	for (chan = 0; chan < num_outs; chan++) {
 		snprintf(name, sizeof(name),
-			"Effect Return %d",
-			chan + 1);
+			 "Effect Return %d",
+			 chan + 1);
 
 		cmask = (chan == 0) ? 0 :
 			BIT(chan + (chan % 2) * num_outs - 1);
 		err = snd_create_std_mono_ctl_offset(mixer, id, control,
-						cmask, val_type, offset, name,
-						&snd_usb_mixer_vol_tlv);
+						     cmask, val_type, offset, name,
+						     &snd_usb_mixer_vol_tlv);
 		if (err < 0)
 			return err;
 	}
@@ -1625,7 +1887,7 @@ static const struct std_mono_table ebox44_table[] = {
  *
  */
 static int snd_microii_spdif_info(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
+				  struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
 	uinfo->count = 1;
@@ -1633,7 +1895,7 @@ static int snd_microii_spdif_info(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_microii_spdif_default_get(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					 struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
 	struct snd_usb_audio *chip = list->mixer->chip;
@@ -1666,13 +1928,13 @@ static int snd_microii_spdif_default_get(struct snd_kcontrol *kcontrol,
 	ep = get_endpoint(alts, 0)->bEndpointAddress;
 
 	err = snd_usb_ctl_msg(chip->dev,
-			usb_rcvctrlpipe(chip->dev, 0),
-			UAC_GET_CUR,
-			USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_IN,
-			UAC_EP_CS_ATTR_SAMPLE_RATE << 8,
-			ep,
-			data,
-			sizeof(data));
+			      usb_rcvctrlpipe(chip->dev, 0),
+			      UAC_GET_CUR,
+			      USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_IN,
+			      UAC_EP_CS_ATTR_SAMPLE_RATE << 8,
+			      ep,
+			      data,
+			      sizeof(data));
 	if (err < 0)
 		goto end;
 
@@ -1699,26 +1961,26 @@ static int snd_microii_spdif_default_update(struct usb_mixer_elem_list *list)
 
 	reg = ((pval >> 4) & 0xf0) | (pval & 0x0f);
 	err = snd_usb_ctl_msg(chip->dev,
-			usb_sndctrlpipe(chip->dev, 0),
-			UAC_SET_CUR,
-			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-			reg,
-			2,
-			NULL,
-			0);
+			      usb_sndctrlpipe(chip->dev, 0),
+			      UAC_SET_CUR,
+			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+			      reg,
+			      2,
+			      NULL,
+			      0);
 	if (err < 0)
 		goto end;
 
 	reg = (pval & IEC958_AES0_NONAUDIO) ? 0xa0 : 0x20;
 	reg |= (pval >> 12) & 0x0f;
 	err = snd_usb_ctl_msg(chip->dev,
-			usb_sndctrlpipe(chip->dev, 0),
-			UAC_SET_CUR,
-			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-			reg,
-			3,
-			NULL,
-			0);
+			      usb_sndctrlpipe(chip->dev, 0),
+			      UAC_SET_CUR,
+			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+			      reg,
+			      3,
+			      NULL,
+			      0);
 	if (err < 0)
 		goto end;
 
@@ -1728,13 +1990,14 @@ static int snd_microii_spdif_default_update(struct usb_mixer_elem_list *list)
 }
 
 static int snd_microii_spdif_default_put(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					 struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
 	unsigned int pval, pval_old;
 	int err;
 
-	pval = pval_old = kcontrol->private_value;
+	pval = kcontrol->private_value;
+	pval_old = pval;
 	pval &= 0xfffff0f0;
 	pval |= (ucontrol->value.iec958.status[1] & 0x0f) << 8;
 	pval |= (ucontrol->value.iec958.status[0] & 0x0f);
@@ -1755,7 +2018,7 @@ static int snd_microii_spdif_default_put(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_microii_spdif_mask_get(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+				      struct snd_ctl_elem_value *ucontrol)
 {
 	ucontrol->value.iec958.status[0] = 0x0f;
 	ucontrol->value.iec958.status[1] = 0xff;
@@ -1766,7 +2029,7 @@ static int snd_microii_spdif_mask_get(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_microii_spdif_switch_get(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					struct snd_ctl_elem_value *ucontrol)
 {
 	ucontrol->value.integer.value[0] = !(kcontrol->private_value & 0x02);
 
@@ -1784,20 +2047,20 @@ static int snd_microii_spdif_switch_update(struct usb_mixer_elem_list *list)
 		return err;
 
 	err = snd_usb_ctl_msg(chip->dev,
-			usb_sndctrlpipe(chip->dev, 0),
-			UAC_SET_CUR,
-			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-			reg,
-			9,
-			NULL,
-			0);
+			      usb_sndctrlpipe(chip->dev, 0),
+			      UAC_SET_CUR,
+			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+			      reg,
+			      9,
+			      NULL,
+			      0);
 
 	snd_usb_unlock_shutdown(chip);
 	return err;
 }
 
 static int snd_microii_spdif_switch_put(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
 	u8 reg;
@@ -1882,9 +2145,9 @@ static int snd_soundblaster_e1_switch_update(struct usb_mixer_interface *mixer,
 	if (err < 0)
 		return err;
 	err = snd_usb_ctl_msg(chip->dev,
-			usb_sndctrlpipe(chip->dev, 0), HID_REQ_SET_REPORT,
-			USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
-			0x0202, 3, buff, 2);
+			      usb_sndctrlpipe(chip->dev, 0), HID_REQ_SET_REPORT,
+			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
+			      0x0202, 3, buff, 2);
 	snd_usb_unlock_shutdown(chip);
 	return err;
 }
@@ -3234,7 +3497,7 @@ static int snd_rme_digiface_enum_put(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_rme_digiface_current_sync_get(struct snd_kcontrol *kcontrol,
-				     struct snd_ctl_elem_value *ucontrol)
+					     struct snd_ctl_elem_value *ucontrol)
 {
 	int ret = snd_rme_digiface_enum_get(kcontrol, ucontrol);
 
@@ -3806,7 +4069,7 @@ static const struct snd_djm_device snd_djm_devices[] = {
 
 
 static int snd_djm_controls_info(struct snd_kcontrol *kctl,
-				struct snd_ctl_elem_info *info)
+				 struct snd_ctl_elem_info *info)
 {
 	unsigned long private_value = kctl->private_value;
 	u8 device_idx = (private_value & SND_DJM_DEVICE_MASK) >> SND_DJM_DEVICE_SHIFT;
@@ -3825,8 +4088,8 @@ static int snd_djm_controls_info(struct snd_kcontrol *kctl,
 		info->value.enumerated.item = noptions - 1;
 
 	name = snd_djm_get_label(device_idx,
-				ctl->options[info->value.enumerated.item],
-				ctl->wIndex);
+				 ctl->options[info->value.enumerated.item],
+				 ctl->wIndex);
 	if (!name)
 		return -EINVAL;
 
@@ -3838,25 +4101,25 @@ static int snd_djm_controls_info(struct snd_kcontrol *kctl,
 }
 
 static int snd_djm_controls_update(struct usb_mixer_interface *mixer,
-				u8 device_idx, u8 group, u16 value)
+				   u8 device_idx, u8 group, u16 value)
 {
 	int err;
 	const struct snd_djm_device *device = &snd_djm_devices[device_idx];
 
-	if ((group >= device->ncontrols) || value >= device->controls[group].noptions)
+	if (group >= device->ncontrols || value >= device->controls[group].noptions)
 		return -EINVAL;
 
 	err = snd_usb_lock_shutdown(mixer->chip);
 	if (err)
 		return err;
 
-	err = snd_usb_ctl_msg(
-		mixer->chip->dev, usb_sndctrlpipe(mixer->chip->dev, 0),
-		USB_REQ_SET_FEATURE,
-		USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-		device->controls[group].options[value],
-		device->controls[group].wIndex,
-		NULL, 0);
+	err = snd_usb_ctl_msg(mixer->chip->dev,
+			      usb_sndctrlpipe(mixer->chip->dev, 0),
+			      USB_REQ_SET_FEATURE,
+			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      device->controls[group].options[value],
+			      device->controls[group].wIndex,
+			      NULL, 0);
 
 	snd_usb_unlock_shutdown(mixer->chip);
 	return err;
@@ -3897,7 +4160,7 @@ static int snd_djm_controls_resume(struct usb_mixer_elem_list *list)
 }
 
 static int snd_djm_controls_create(struct usb_mixer_interface *mixer,
-		const u8 device_idx)
+				   const u8 device_idx)
 {
 	int err, i;
 	u16 value;
@@ -3916,10 +4179,10 @@ static int snd_djm_controls_create(struct usb_mixer_interface *mixer,
 	for (i = 0; i < device->ncontrols; i++) {
 		value = device->controls[i].default_value;
 		knew.name = device->controls[i].name;
-		knew.private_value = (
+		knew.private_value =
 			((unsigned long)device_idx << SND_DJM_DEVICE_SHIFT) |
 			(i << SND_DJM_GROUP_SHIFT) |
-			value);
+			value;
 		err = snd_djm_controls_update(mixer, device_idx, i, value);
 		if (err)
 			return err;
@@ -3961,6 +4224,13 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
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
@@ -3986,13 +4256,15 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		break;
 
 	case USB_ID(0x17cc, 0x1011): /* Traktor Audio 6 */
-		err = snd_nativeinstruments_create_mixer(mixer,
+		err = snd_nativeinstruments_create_mixer(/* checkpatch hack */
+				mixer,
 				snd_nativeinstruments_ta6_mixers,
 				ARRAY_SIZE(snd_nativeinstruments_ta6_mixers));
 		break;
 
 	case USB_ID(0x17cc, 0x1021): /* Traktor Audio 10 */
-		err = snd_nativeinstruments_create_mixer(mixer,
+		err = snd_nativeinstruments_create_mixer(/* checkpatch hack */
+				mixer,
 				snd_nativeinstruments_ta10_mixers,
 				ARRAY_SIZE(snd_nativeinstruments_ta10_mixers));
 		break;
@@ -4127,7 +4399,8 @@ static void snd_dragonfly_quirk_db_scale(struct usb_mixer_interface *mixer,
 					 struct snd_kcontrol *kctl)
 {
 	/* Approximation using 10 ranges based on output measurement on hw v1.2.
-	 * This seems close to the cubic mapping e.g. alsamixer uses. */
+	 * This seems close to the cubic mapping e.g. alsamixer uses.
+	 */
 	static const DECLARE_TLV_DB_RANGE(scale,
 		 0,  1, TLV_DB_MINMAX_ITEM(-5300, -4970),
 		 2,  5, TLV_DB_MINMAX_ITEM(-4710, -4160),
@@ -4211,16 +4484,12 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 		if (unitid == 7 && cval->control == UAC_FU_VOLUME)
 			snd_dragonfly_quirk_db_scale(mixer, cval, kctl);
 		break;
+	}
+
 	/* lowest playback value is muted on some devices */
-	case USB_ID(0x0572, 0x1b09): /* Conexant Systems (Rockwell), Inc. */
-	case USB_ID(0x0d8c, 0x000c): /* C-Media */
-	case USB_ID(0x0d8c, 0x0014): /* C-Media */
-	case USB_ID(0x19f7, 0x0003): /* RODE NT-USB */
-	case USB_ID(0x2d99, 0x0026): /* HECATE G2 GAMING HEADSET */
+	if (mixer->chip->quirk_flags & QUIRK_FLAG_MIXER_MIN_MUTE)
 		if (strstr(kctl->id.name, "Playback"))
 			cval->min_mute = 1;
-		break;
-	}
 
 	/* ALSA-ify some Plantronics headset control names */
 	if (USB_ID_VENDOR(mixer->chip->usb_id) == 0x047f &&
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 0da4ee9757c0..8a20508e055a 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2196,6 +2196,10 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_SET_IFACE_FIRST),
 	DEVICE_FLG(0x0556, 0x0014, /* Phoenix Audio TMX320VC */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x0572, 0x1b08, /* Conexant Systems (Rockwell), Inc. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
+	DEVICE_FLG(0x0572, 0x1b09, /* Conexant Systems (Rockwell), Inc. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x05a3, 0x9420, /* ELP HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x05a7, 0x1020, /* Bose Companion 5 */
@@ -2238,12 +2242,16 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0b0e, 0x0349, /* Jabra 550a */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0bda, 0x498a, /* Realtek Semiconductor Corp. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0c45, 0x636b, /* Microdia JP001 USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
-	DEVICE_FLG(0x0d8c, 0x0014, /* USB Audio Device */
-		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0d8c, 0x000c, /* C-Media */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
+	DEVICE_FLG(0x0d8c, 0x0014, /* C-Media */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
@@ -2252,6 +2260,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x1101, 0x0003, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x12d1, 0x3a07, /* Huawei Technologies Co., Ltd. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
@@ -2290,6 +2300,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x1901, 0x0191, /* GE B850V3 CP2114 audio interface */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x19f7, 0x0003, /* RODE NT-USB */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x19f7, 0x0035, /* RODE NT-USB+ */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1bcf, 0x2281, /* HD Webcam */
@@ -2340,6 +2352,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x2a70, 0x1881, /* OnePlus Technology (Shenzhen) Co., Ltd. BE02T */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x2b53, 0x0023, /* Fiero SC-01 (firmware v1.0.0 @ 48 kHz) */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x2b53, 0x0024, /* Fiero SC-01 (firmware v1.0.0 @ 96 kHz) */
@@ -2350,10 +2364,14 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x2d95, 0x8021, /* VIVO USB-C-XE710 HEADSET */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x2d99, 0x0026, /* HECATE G2 GAMING HEADSET */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x2fc6, 0xf0b7, /* iBasso DC07 Pro */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x30be, 0x0101, /* Schiit Hel */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
+	DEVICE_FLG(0x339b, 0x3a07, /* Synaptics HONOR USB-C HEADSET */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x413c, 0xa506, /* Dell AE515 sound bar */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x534d, 0x0021, /* MacroSilicon MS2100/MS2106 */
@@ -2405,6 +2423,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x2d87, /* Cayin device */
 		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x2fc6, /* Comture-inc devices */
+		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3336, /* HEM devices */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3353, /* Khadas devices */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 158ec053dc44..1ef4d39978df 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -196,6 +196,9 @@ extern bool snd_usb_skip_validation;
  *  for the given endpoint.
  * QUIRK_FLAG_MIC_RES_16 and QUIRK_FLAG_MIC_RES_384
  *  Set the fixed resolution for Mic Capture Volume (mostly for webcams)
+ * QUIRK_FLAG_MIXER_MIN_MUTE
+ *  Set minimum volume control value as mute for devices where the lowest
+ *  playback value represents muted state instead of minimum audible volume
  */
 
 #define QUIRK_FLAG_GET_SAMPLE_RATE	(1U << 0)
@@ -222,5 +225,6 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_FIXED_RATE		(1U << 21)
 #define QUIRK_FLAG_MIC_RES_16		(1U << 22)
 #define QUIRK_FLAG_MIC_RES_384		(1U << 23)
+#define QUIRK_FLAG_MIXER_MIN_MUTE	(1U << 24)
 
 #endif /* __USBAUDIO_H */
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 77c83d9508d3..6845da990281 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -465,8 +465,8 @@ ipv6_fdb_grp_fcnal()
 	log_test $? 0 "Get Fdb nexthop group by id"
 
 	# fdb nexthop group can only contain fdb nexthops
-	run_cmd "$IP nexthop add id 63 via 2001:db8:91::4"
-	run_cmd "$IP nexthop add id 64 via 2001:db8:91::5"
+	run_cmd "$IP nexthop add id 63 via 2001:db8:91::4 dev veth1"
+	run_cmd "$IP nexthop add id 64 via 2001:db8:91::5 dev veth1"
 	run_cmd "$IP nexthop add id 103 group 63/64 fdb"
 	log_test $? 2 "Fdb Nexthop group with non-fdb nexthops"
 
@@ -545,15 +545,15 @@ ipv4_fdb_grp_fcnal()
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
@@ -580,7 +580,7 @@ ipv4_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:14 dev vx10 nhid 12 self"
 	log_test $? 255 "Fdb mac add with nexthop"
 
-	run_cmd "$IP ro add 172.16.0.0/22 nhid 15"
+	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"
 
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 103"

