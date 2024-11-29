Return-Path: <stable+bounces-93685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EC19D043B
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 15:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63FC2B2249F
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF81B1D9A47;
	Sun, 17 Nov 2024 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hwZrWoZn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569331D95A2;
	Sun, 17 Nov 2024 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731853111; cv=none; b=UFAcx1M6AhNDwuES61h8ACdLoFfedeCvUNn4100aCSwr5h6alGk3J/taEsSgELv7P0XhXnnPBZ4TZBTvqHBDHvRv+MYdowTjEiHPZTu121Gfzx2ZrNT0RE3fl4ST4PM0ysbRA0xNdlf3MgMZg16dZcx7J1qPeORSnVDbwF69L8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731853111; c=relaxed/simple;
	bh=HULHVgNTe95wjDztC+kenTcsT6thxFg8IRZ4sT1qDHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJmaQeBcsVSh0pdNJIJ7heuGHKFSO5mxA89iL9LEoRrDGHKz7yUq7c8kJVgmQgS0HskQ8iG7ajSJ8EnL/2yzk7CCAceXjE2btQo3X8V35wct5YMfYVyNMqtYaFQN/usfdOyRZ6gvL2ls4UOZ6pRqt/uXLsZkMC/PBlDH7mtC5Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hwZrWoZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8FCC4CED8;
	Sun, 17 Nov 2024 14:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731853111;
	bh=HULHVgNTe95wjDztC+kenTcsT6thxFg8IRZ4sT1qDHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwZrWoZn10EoQsI03aAjCsL3uBgQJhYhoU179sAaFHbQMQ182o75+e3dSKFQkQ4sV
	 AhnwY7F0C09Jydae2yi0+V+gdP7zRBRlLjuUwFrZoR1GB1j8yPqaMStyPHFzaHFBhl
	 YI+p+6/28AsTmUkIlCpKeMR6QCJoajJksfO9YpcA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.286
Date: Sun, 17 Nov 2024 15:17:58 +0100
Message-ID: <2024111758-power-saved-4039@gregkh>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111758-talisman-unsubtly-0bd8@gregkh>
References: <2024111758-talisman-unsubtly-0bd8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 831fc4cffbbc..8849e295ce77 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 285
+SUBLEVEL = 286
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index 2ef47ebeb0cb..e5bee30b3558 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -300,8 +300,8 @@
 &i2c2 {
 	status = "okay";
 
-	rt5616: rt5616@1b {
-		compatible = "rt5616";
+	rt5616: audio-codec@1b {
+		compatible = "realtek,rt5616";
 		reg = <0x1b>;
 		clocks = <&cru SCLK_I2S_OUT>;
 		clock-names = "mclk";
diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index cc2d596da7d4..c26981c75c21 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -317,12 +317,13 @@
 		};
 	};
 
-	acodec: acodec-ana@20030000 {
-		compatible = "rk3036-codec";
+	acodec: audio-codec@20030000 {
+		compatible = "rockchip,rk3036-codec";
 		reg = <0x20030000 0x4000>;
-		rockchip,grf = <&grf>;
 		clock-names = "acodec_pclk";
 		clocks = <&cru PCLK_ACODEC>;
+		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
@@ -332,7 +333,6 @@
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru  PCLK_HDMI>;
 		clock-names = "pclk";
-		rockchip,grf = <&grf>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&hdmi_ctl>;
 		status = "disabled";
@@ -489,11 +489,11 @@
 	};
 
 	spi: spi@20074000 {
-		compatible = "rockchip,rockchip-spi";
+		compatible = "rockchip,rk3036-spi";
 		reg = <0x20074000 0x1000>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru PCLK_SPI>, <&cru SCLK_SPI>;
-		clock-names = "apb-pclk","spi_pclk";
+		clocks = <&cru SCLK_SPI>, <&cru PCLK_SPI>;
+		clock-names = "spiclk", "apb_pclk";
 		dmas = <&pdma 8>, <&pdma 9>;
 		dma-names = "tx", "rx";
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 9f300719a8fd..5bb84ec31c6f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -667,8 +667,7 @@
 		compatible = "rockchip,rk3328-dw-hdmi";
 		reg = <0x0 0xff3c0000 0x0 0x20000>;
 		reg-io-width = <4>;
-		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru PCLK_HDMI>,
 			 <&cru SCLK_HDMI_SFC>,
 			 <&cru SCLK_RTC32K>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
index 216aafd90e7f..08a8e35cd7d6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
@@ -56,7 +56,6 @@
 			fan: fan@18 {
 				compatible = "ti,amc6821";
 				reg = <0x18>;
-				#cooling-cells = <2>;
 			};
 
 			rtc_twi: rtc@6f {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index c7d48d41e184..f5ad0a539920 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -557,7 +557,7 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		clocks = <&rk808 1>;
-		clock-names = "ext_clock";
+		clock-names = "txco";
 		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
 		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
 		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
index 808ea77f951d..0d495716df6d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
@@ -159,7 +159,7 @@
 	status = "okay";
 
 	rt5651: rt5651@1a {
-		compatible = "rockchip,rt5651";
+		compatible = "realtek,rt5651";
 		reg = <0x1a>;
 		clocks = <&cru SCLK_I2S_8CH_OUT>;
 		clock-names = "mclk";
diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index dcec0f760c8f..522bda391179 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -285,6 +285,7 @@ int __init opal_event_init(void)
 				 name, NULL);
 		if (rc) {
 			pr_warn("Error %d requesting OPAL irq %d\n", rc, (int)r->start);
+			kfree(name);
 			continue;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 4597d441198d..09965b5fa9cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -110,8 +110,8 @@ static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
 				      &buffer);
 	obj = (union acpi_object *)buffer.pointer;
 
-	/* Fail if calling the method fails and ATIF is supported */
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+	/* Fail if calling the method fails */
+	if (ACPI_FAILURE(status)) {
 		DRM_DEBUG_DRIVER("failed to evaluate ATIF got %s\n",
 				 acpi_format_exception(status));
 		kfree(obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 48b8b5600402..fa42b3c7e1b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -395,7 +395,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	if (!adev->smc_rreg)
 		return -EOPNOTSUPP;
 
-	if (size & 0x3 || *pos & 0x3)
+	if (size > 4096 || size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
 	while (size) {
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 2462be8c4ae6..10ee4d3269b9 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1657,7 +1657,7 @@ u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags)
 
 	u32 len = hid_report_len(report) + 7;
 
-	return kmalloc(len, flags);
+	return kzalloc(len, flags);
 }
 EXPORT_SYMBOL_GPL(hid_alloc_report_buf);
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c3810e7140a5..5994e7d1b82d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2008,6 +2008,11 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			0x347d, 0x7853) },
 
+	/* HONOR MagicBook Art 14 touchpad */
+	{ .driver_data = MT_CLS_VTL,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			0x35cc, 0x0104) },
+
 	/* Ilitek dual touch panel */
 	{  .driver_data = MT_CLS_NSMU,
 		MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 77a130c03223..4cbfd8c18615 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -383,6 +383,13 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
 	}
 
 	gic_poke_irq(d, reg);
+
+	/*
+	 * Force read-back to guarantee that the active state has taken
+	 * effect, and won't race with a guest-driven deactivation.
+	 */
+	if (reg == GICD_ISACTIVER)
+		gic_peek_irq(d, reg);
 	return 0;
 }
 
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 08b5e44df324..c1d2e3376afc 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2085,7 +2085,6 @@ struct cache_args {
 	sector_t cache_sectors;
 
 	struct dm_dev *origin_dev;
-	sector_t origin_sectors;
 
 	uint32_t block_size;
 
@@ -2167,6 +2166,7 @@ static int parse_cache_dev(struct cache_args *ca, struct dm_arg_set *as,
 static int parse_origin_dev(struct cache_args *ca, struct dm_arg_set *as,
 			    char **error)
 {
+	sector_t origin_sectors;
 	int r;
 
 	if (!at_least_one_arg(as, error))
@@ -2179,8 +2179,8 @@ static int parse_origin_dev(struct cache_args *ca, struct dm_arg_set *as,
 		return r;
 	}
 
-	ca->origin_sectors = get_dev_size(ca->origin_dev);
-	if (ca->ti->len > ca->origin_sectors) {
+	origin_sectors = get_dev_size(ca->origin_dev);
+	if (ca->ti->len > origin_sectors) {
 		*error = "Device size larger than cached device";
 		return -EINVAL;
 	}
@@ -2506,7 +2506,7 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 
 	ca->metadata_dev = ca->origin_dev = ca->cache_dev = NULL;
 
-	origin_blocks = cache->origin_sectors = ca->origin_sectors;
+	origin_blocks = cache->origin_sectors = ti->len;
 	origin_blocks = block_div(origin_blocks, ca->block_size);
 	cache->origin_blocks = to_oblock(origin_blocks);
 
@@ -2999,19 +2999,19 @@ static dm_cblock_t get_cache_dev_size(struct cache *cache)
 static bool can_resize(struct cache *cache, dm_cblock_t new_size)
 {
 	if (from_cblock(new_size) > from_cblock(cache->cache_size)) {
-		if (cache->sized) {
-			DMERR("%s: unable to extend cache due to missing cache table reload",
-			      cache_device_name(cache));
-			return false;
-		}
+		DMERR("%s: unable to extend cache due to missing cache table reload",
+		      cache_device_name(cache));
+		return false;
 	}
 
 	/*
 	 * We can't drop a dirty block when shrinking the cache.
 	 */
-	while (from_cblock(new_size) < from_cblock(cache->cache_size)) {
-		new_size = to_cblock(from_cblock(new_size) + 1);
-		if (is_dirty(cache, new_size)) {
+	if (cache->loaded_mappings) {
+		new_size = to_cblock(find_next_bit(cache->dirty_bitset,
+						   from_cblock(cache->cache_size),
+						   from_cblock(new_size)));
+		if (new_size != cache->cache_size) {
 			DMERR("%s: unable to shrink cache; cache block %llu is dirty",
 			      cache_device_name(cache),
 			      (unsigned long long) from_cblock(new_size));
@@ -3047,20 +3047,15 @@ static int cache_preresume(struct dm_target *ti)
 	/*
 	 * Check to see if the cache has resized.
 	 */
-	if (!cache->sized) {
-		r = resize_cache_dev(cache, csize);
-		if (r)
-			return r;
-
-		cache->sized = true;
-
-	} else if (csize != cache->cache_size) {
+	if (!cache->sized || csize != cache->cache_size) {
 		if (!can_resize(cache, csize))
 			return -EINVAL;
 
 		r = resize_cache_dev(cache, csize);
 		if (r)
 			return r;
+
+		cache->sized = true;
 	}
 
 	if (!cache->loaded_mappings) {
diff --git a/drivers/md/dm-unstripe.c b/drivers/md/dm-unstripe.c
index e673dacf6418..e18106e99426 100644
--- a/drivers/md/dm-unstripe.c
+++ b/drivers/md/dm-unstripe.c
@@ -84,8 +84,8 @@ static int unstripe_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	}
 	uc->physical_start = start;
 
-	uc->unstripe_offset = uc->unstripe * uc->chunk_size;
-	uc->unstripe_width = (uc->stripes - 1) * uc->chunk_size;
+	uc->unstripe_offset = (sector_t)uc->unstripe * uc->chunk_size;
+	uc->unstripe_width = (sector_t)(uc->stripes - 1) * uc->chunk_size;
 	uc->chunk_shift = is_power_of_2(uc->chunk_size) ? fls(uc->chunk_size) - 1 : 0;
 
 	tmp_len = ti->len;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 3983d5c8b5cd..b064f2927a76 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3069,7 +3069,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			sector_t sect;
 			int must_sync;
 			int any_working;
-			int need_recover = 0;
 			struct raid10_info *mirror = &conf->mirrors[i];
 			struct md_rdev *mrdev, *mreplace;
 
@@ -3077,14 +3076,13 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			mrdev = rcu_dereference(mirror->rdev);
 			mreplace = rcu_dereference(mirror->replacement);
 
-			if (mrdev != NULL &&
-			    !test_bit(Faulty, &mrdev->flags) &&
-			    !test_bit(In_sync, &mrdev->flags))
-				need_recover = 1;
+			if (mrdev && (test_bit(Faulty, &mrdev->flags) ||
+			    test_bit(In_sync, &mrdev->flags)))
+				mrdev = NULL;
 			if (mreplace && test_bit(Faulty, &mreplace->flags))
 				mreplace = NULL;
 
-			if (!need_recover && !mreplace) {
+			if (!mrdev && !mreplace) {
 				rcu_read_unlock();
 				continue;
 			}
@@ -3118,7 +3116,8 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				rcu_read_unlock();
 				continue;
 			}
-			atomic_inc(&mrdev->nr_pending);
+			if (mrdev)
+				atomic_inc(&mrdev->nr_pending);
 			if (mreplace)
 				atomic_inc(&mreplace->nr_pending);
 			rcu_read_unlock();
@@ -3205,7 +3204,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				r10_bio->devs[1].devnum = i;
 				r10_bio->devs[1].addr = to_addr;
 
-				if (need_recover) {
+				if (mrdev) {
 					bio = r10_bio->devs[1].bio;
 					bio->bi_next = biolist;
 					biolist = bio;
@@ -3250,7 +3249,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 					for (k = 0; k < conf->copies; k++)
 						if (r10_bio->devs[k].devnum == i)
 							break;
-					if (!test_bit(In_sync,
+					if (mrdev && !test_bit(In_sync,
 						      &mrdev->flags)
 					    && !rdev_set_badblocks(
 						    mrdev,
@@ -3276,12 +3275,14 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				if (rb2)
 					atomic_dec(&rb2->remaining);
 				r10_bio = rb2;
-				rdev_dec_pending(mrdev, mddev);
+				if (mrdev)
+					rdev_dec_pending(mrdev, mddev);
 				if (mreplace)
 					rdev_dec_pending(mreplace, mddev);
 				break;
 			}
-			rdev_dec_pending(mrdev, mddev);
+			if (mrdev)
+				rdev_dec_pending(mrdev, mddev);
 			if (mreplace)
 				rdev_dec_pending(mreplace, mddev);
 			if (r10_bio->devs[0].bio->bi_opf & MD_FAILFAST) {
diff --git a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
index a4d729a4f330..1e4e91510396 100644
--- a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
+++ b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
@@ -1789,6 +1789,9 @@ static void tpg_precalculate_line(struct tpg_data *tpg)
 	unsigned p;
 	unsigned x;
 
+	if (WARN_ON_ONCE(!tpg->src_width || !tpg->scaled_width))
+		return;
+
 	switch (tpg->pattern) {
 	case TPG_PAT_GREEN:
 		contrast = TPG_COLOR_100_RED;
diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index ad3e42a4eaf7..01efb4bd260d 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -442,8 +442,8 @@ static int dvb_frontend_swzigzag_autotune(struct dvb_frontend *fe, int check_wra
 
 		default:
 			fepriv->auto_step++;
-			fepriv->auto_sub_step = -1; /* it'll be incremented to 0 in a moment */
-			break;
+			fepriv->auto_sub_step = 0;
+			continue;
 		}
 
 		if (!ready) fepriv->auto_sub_step++;
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index ba91c6f8fe1d..4a6e8a6b36f4 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -96,10 +96,15 @@ static DECLARE_RWSEM(minor_rwsem);
 static int dvb_device_open(struct inode *inode, struct file *file)
 {
 	struct dvb_device *dvbdev;
+	unsigned int minor = iminor(inode);
+
+	if (minor >= MAX_DVB_MINORS)
+		return -ENODEV;
 
 	mutex_lock(&dvbdev_mutex);
 	down_read(&minor_rwsem);
-	dvbdev = dvb_minors[iminor(inode)];
+
+	dvbdev = dvb_minors[minor];
 
 	if (dvbdev && dvbdev->fops) {
 		int err = 0;
@@ -539,7 +544,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	for (minor = 0; minor < MAX_DVB_MINORS; minor++)
 		if (dvb_minors[minor] == NULL)
 			break;
-	if (minor == MAX_DVB_MINORS) {
+	if (minor >= MAX_DVB_MINORS) {
 		if (new_node) {
 			list_del (&new_node->list_head);
 			kfree(dvbdevfops);
@@ -554,6 +559,14 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	}
 #else
 	minor = nums2minor(adap->num, type, id);
+	if (minor >= MAX_DVB_MINORS) {
+		dvb_media_device_free(dvbdev);
+		list_del(&dvbdev->list_head);
+		kfree(dvbdev);
+		*pdvbdev = NULL;
+		mutex_unlock(&dvbdev_register_lock);
+		return ret;
+	}
 #endif
 	dvbdev->minor = minor;
 	dvb_minors[minor] = dvb_device_get(dvbdev);
diff --git a/drivers/media/dvb-frontends/cx24116.c b/drivers/media/dvb-frontends/cx24116.c
index 8b978a9f74a4..f5dd3a81725a 100644
--- a/drivers/media/dvb-frontends/cx24116.c
+++ b/drivers/media/dvb-frontends/cx24116.c
@@ -741,6 +741,7 @@ static int cx24116_read_snr_pct(struct dvb_frontend *fe, u16 *snr)
 {
 	struct cx24116_state *state = fe->demodulator_priv;
 	u8 snr_reading;
+	int ret;
 	static const u32 snr_tab[] = { /* 10 x Table (rounded up) */
 		0x00000, 0x0199A, 0x03333, 0x04ccD, 0x06667,
 		0x08000, 0x0999A, 0x0b333, 0x0cccD, 0x0e667,
@@ -749,7 +750,11 @@ static int cx24116_read_snr_pct(struct dvb_frontend *fe, u16 *snr)
 
 	dprintk("%s()\n", __func__);
 
-	snr_reading = cx24116_readreg(state, CX24116_REG_QUALITY0);
+	ret = cx24116_readreg(state, CX24116_REG_QUALITY0);
+	if (ret  < 0)
+		return ret;
+
+	snr_reading = ret;
 
 	if (snr_reading >= 0xa0 /* 100% */)
 		*snr = 0xffff;
diff --git a/drivers/media/dvb-frontends/stb0899_algo.c b/drivers/media/dvb-frontends/stb0899_algo.c
index df89c33dac23..40537c4ccb0d 100644
--- a/drivers/media/dvb-frontends/stb0899_algo.c
+++ b/drivers/media/dvb-frontends/stb0899_algo.c
@@ -269,7 +269,7 @@ static enum stb0899_status stb0899_search_carrier(struct stb0899_state *state)
 
 	short int derot_freq = 0, last_derot_freq = 0, derot_limit, next_loop = 3;
 	int index = 0;
-	u8 cfr[2];
+	u8 cfr[2] = {0};
 	u8 reg;
 
 	internal->status = NOCARRIER;
diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index 1cee69919e1b..d0b2d960c784 100644
--- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -2477,10 +2477,10 @@ static int adv76xx_log_status(struct v4l2_subdev *sd)
 	const struct adv76xx_chip_info *info = state->info;
 	struct v4l2_dv_timings timings;
 	struct stdi_readback stdi;
-	u8 reg_io_0x02 = io_read(sd, 0x02);
+	int ret;
+	u8 reg_io_0x02;
 	u8 edid_enabled;
 	u8 cable_det;
-
 	static const char * const csc_coeff_sel_rb[16] = {
 		"bypassed", "YPbPr601 -> RGB", "reserved", "YPbPr709 -> RGB",
 		"reserved", "RGB -> YPbPr601", "reserved", "RGB -> YPbPr709",
@@ -2579,13 +2579,21 @@ static int adv76xx_log_status(struct v4l2_subdev *sd)
 	v4l2_info(sd, "-----Color space-----\n");
 	v4l2_info(sd, "RGB quantization range ctrl: %s\n",
 			rgb_quantization_range_txt[state->rgb_quantization_range]);
-	v4l2_info(sd, "Input color space: %s\n",
-			input_color_space_txt[reg_io_0x02 >> 4]);
-	v4l2_info(sd, "Output color space: %s %s, alt-gamma %s\n",
-			(reg_io_0x02 & 0x02) ? "RGB" : "YCbCr",
-			(((reg_io_0x02 >> 2) & 0x01) ^ (reg_io_0x02 & 0x01)) ?
-				"(16-235)" : "(0-255)",
-			(reg_io_0x02 & 0x08) ? "enabled" : "disabled");
+
+	ret = io_read(sd, 0x02);
+	if (ret < 0) {
+		v4l2_info(sd, "Can't read Input/Output color space\n");
+	} else {
+		reg_io_0x02 = ret;
+
+		v4l2_info(sd, "Input color space: %s\n",
+				input_color_space_txt[reg_io_0x02 >> 4]);
+		v4l2_info(sd, "Output color space: %s %s, alt-gamma %s\n",
+				(reg_io_0x02 & 0x02) ? "RGB" : "YCbCr",
+				(((reg_io_0x02 >> 2) & 0x01) ^ (reg_io_0x02 & 0x01)) ?
+					"(16-235)" : "(0-255)",
+				(reg_io_0x02 & 0x08) ? "enabled" : "disabled");
+	}
 	v4l2_info(sd, "Color space conversion: %s\n",
 			csc_coeff_sel_rb[cp_read(sd, info->cp_csc) >> 4]);
 
diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/s5p-jpeg/jpeg-core.c
index 06e17946bbb6..4ee1e275ba89 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.c
@@ -774,11 +774,14 @@ static void exynos4_jpeg_parse_decode_h_tbl(struct s5p_jpeg_ctx *ctx)
 		(unsigned long)vb2_plane_vaddr(&vb->vb2_buf, 0) + ctx->out_q.sos + 2;
 	jpeg_buffer.curr = 0;
 
-	word = 0;
-
 	if (get_word_be(&jpeg_buffer, &word))
 		return;
-	jpeg_buffer.size = (long)word - 2;
+
+	if (word < 2)
+		jpeg_buffer.size = 0;
+	else
+		jpeg_buffer.size = (long)word - 2;
+
 	jpeg_buffer.data += 2;
 	jpeg_buffer.curr = 0;
 
@@ -1057,6 +1060,7 @@ static int get_word_be(struct s5p_jpeg_buffer *buf, unsigned int *word)
 	if (byte == -1)
 		return -1;
 	*word = (unsigned int)byte | temp;
+
 	return 0;
 }
 
@@ -1144,7 +1148,7 @@ static bool s5p_jpeg_parse_hdr(struct s5p_jpeg_q_data *result,
 			if (get_word_be(&jpeg_buffer, &word))
 				break;
 			length = (long)word - 2;
-			if (!length)
+			if (length <= 0)
 				return false;
 			sof = jpeg_buffer.curr; /* after 0xffc0 */
 			sof_len = length;
@@ -1175,7 +1179,7 @@ static bool s5p_jpeg_parse_hdr(struct s5p_jpeg_q_data *result,
 			if (get_word_be(&jpeg_buffer, &word))
 				break;
 			length = (long)word - 2;
-			if (!length)
+			if (length <= 0)
 				return false;
 			if (n_dqt >= S5P_JPEG_MAX_MARKER)
 				return false;
@@ -1188,7 +1192,7 @@ static bool s5p_jpeg_parse_hdr(struct s5p_jpeg_q_data *result,
 			if (get_word_be(&jpeg_buffer, &word))
 				break;
 			length = (long)word - 2;
-			if (!length)
+			if (length <= 0)
 				return false;
 			if (n_dht >= S5P_JPEG_MAX_MARKER)
 				return false;
@@ -1213,6 +1217,7 @@ static bool s5p_jpeg_parse_hdr(struct s5p_jpeg_q_data *result,
 			if (get_word_be(&jpeg_buffer, &word))
 				break;
 			length = (long)word - 2;
+			/* No need to check underflows as skip() does it  */
 			skip(&jpeg_buffer, length);
 			break;
 		}
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 6d1a7e02da51..2f913ea44b28 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -602,7 +602,7 @@ static int uvc_parse_format(struct uvc_device *dev,
 	/* Parse the frame descriptors. Only uncompressed, MJPEG and frame
 	 * based formats have frame descriptors.
 	 */
-	while (buflen > 2 && buffer[1] == USB_DT_CS_INTERFACE &&
+	while (ftype && buflen > 2 && buffer[1] == USB_DT_CS_INTERFACE &&
 	       buffer[2] == ftype) {
 		frame = &format->frame[format->nframes];
 		if (ftype != UVC_VS_FRAME_FRAME_BASED)
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index db66c1be6e5f..29e3a5b04778 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -359,16 +359,19 @@ static int nand_isbad_bbm(struct nand_chip *chip, loff_t ofs)
  *
  * Return: -EBUSY if the chip has been suspended, 0 otherwise
  */
-static int nand_get_device(struct nand_chip *chip)
+static void nand_get_device(struct nand_chip *chip)
 {
-	mutex_lock(&chip->lock);
-	if (chip->suspended) {
+	/* Wait until the device is resumed. */
+	while (1) {
+		mutex_lock(&chip->lock);
+		if (!chip->suspended) {
+			mutex_lock(&chip->controller->lock);
+			return;
+		}
 		mutex_unlock(&chip->lock);
-		return -EBUSY;
-	}
-	mutex_lock(&chip->controller->lock);
 
-	return 0;
+		wait_event(chip->resume_wq, !chip->suspended);
+	}
 }
 
 /**
@@ -593,9 +596,7 @@ static int nand_block_markbad_lowlevel(struct nand_chip *chip, loff_t ofs)
 		nand_erase_nand(chip, &einfo, 0);
 
 		/* Write bad block marker to OOB */
-		ret = nand_get_device(chip);
-		if (ret)
-			return ret;
+		nand_get_device(chip);
 
 		ret = nand_markbad_bbm(chip, ofs);
 		nand_release_device(chip);
@@ -3576,9 +3577,7 @@ static int nand_read_oob(struct mtd_info *mtd, loff_t from,
 	    ops->mode != MTD_OPS_RAW)
 		return -ENOTSUPP;
 
-	ret = nand_get_device(chip);
-	if (ret)
-		return ret;
+	nand_get_device(chip);
 
 	if (!ops->datbuf)
 		ret = nand_do_read_oob(chip, from, ops);
@@ -4122,13 +4121,11 @@ static int nand_write_oob(struct mtd_info *mtd, loff_t to,
 			  struct mtd_oob_ops *ops)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	int ret;
+	int ret = 0;
 
 	ops->retlen = 0;
 
-	ret = nand_get_device(chip);
-	if (ret)
-		return ret;
+	nand_get_device(chip);
 
 	switch (ops->mode) {
 	case MTD_OPS_PLACE_OOB:
@@ -4184,9 +4181,7 @@ int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 		return -EINVAL;
 
 	/* Grab the lock and see if the device is available */
-	ret = nand_get_device(chip);
-	if (ret)
-		return ret;
+	nand_get_device(chip);
 
 	/* Shift to get first page */
 	page = (int)(instr->addr >> chip->page_shift);
@@ -4273,7 +4268,7 @@ static void nand_sync(struct mtd_info *mtd)
 	pr_debug("%s: called\n", __func__);
 
 	/* Grab the lock and see if the device is available */
-	WARN_ON(nand_get_device(chip));
+	nand_get_device(chip);
 	/* Release it and go back */
 	nand_release_device(chip);
 }
@@ -4290,9 +4285,7 @@ static int nand_block_isbad(struct mtd_info *mtd, loff_t offs)
 	int ret;
 
 	/* Select the NAND device */
-	ret = nand_get_device(chip);
-	if (ret)
-		return ret;
+	nand_get_device(chip);
 
 	nand_select_target(chip, chipnr);
 
@@ -4354,6 +4347,8 @@ static void nand_resume(struct mtd_info *mtd)
 		pr_err("%s called for a chip which is not in suspended state\n",
 			__func__);
 	mutex_unlock(&chip->lock);
+
+	wake_up_all(&chip->resume_wq);
 }
 
 /**
@@ -5014,6 +5009,7 @@ static int nand_scan_ident(struct nand_chip *chip, unsigned int maxchips,
 	chip->cur_cs = -1;
 
 	mutex_init(&chip->lock);
+	init_waitqueue_head(&chip->resume_wq);
 
 	/* Enforce the right timings for reset/detection */
 	onfi_fill_data_interface(chip, NAND_SDR_IFACE, 0);
diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index f14e739ba3f4..07cf6fda9720 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -1001,7 +1001,6 @@ static int c_can_handle_bus_err(struct net_device *dev,
 
 	/* common for all type of bus errors */
 	priv->can.can_stats.bus_error++;
-	stats->rx_errors++;
 
 	/* propagate the error condition to the CAN stack */
 	skb = alloc_can_err_skb(dev, &cf);
@@ -1018,26 +1017,32 @@ static int c_can_handle_bus_err(struct net_device *dev,
 	case LEC_STUFF_ERROR:
 		netdev_dbg(dev, "stuff error\n");
 		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		stats->rx_errors++;
 		break;
 	case LEC_FORM_ERROR:
 		netdev_dbg(dev, "form error\n");
 		cf->data[2] |= CAN_ERR_PROT_FORM;
+		stats->rx_errors++;
 		break;
 	case LEC_ACK_ERROR:
 		netdev_dbg(dev, "ack error\n");
 		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		stats->tx_errors++;
 		break;
 	case LEC_BIT1_ERROR:
 		netdev_dbg(dev, "bit1 error\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT1;
+		stats->tx_errors++;
 		break;
 	case LEC_BIT0_ERROR:
 		netdev_dbg(dev, "bit0 error\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT0;
+		stats->tx_errors++;
 		break;
 	case LEC_CRC_ERROR:
 		netdev_dbg(dev, "CRC error\n");
 		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		stats->rx_errors++;
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 3a8c2049b417..85998060df70 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -94,6 +94,8 @@ static int enetc_vf_set_mac_addr(struct net_device *ndev, void *addr)
 	if (err)
 		return err;
 
+	eth_hw_addr_set(ndev, saddr->sa_data);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index 2e38c7d214c4..6c7cef6f1532 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -25,8 +25,11 @@ void hnae3_unregister_ae_algo_prepare(struct hnae3_ae_algo *ae_algo)
 		pci_id = pci_match_id(ae_algo->pdev_id_table, ae_dev->pdev);
 		if (!pci_id)
 			continue;
-		if (IS_ENABLED(CONFIG_PCI_IOV))
+		if (IS_ENABLED(CONFIG_PCI_IOV)) {
+			device_lock(&ae_dev->pdev->dev);
 			pci_disable_sriov(ae_dev->pdev);
+			device_unlock(&ae_dev->pdev->dev);
+		}
 	}
 }
 EXPORT_SYMBOL(hnae3_unregister_ae_algo_prepare);
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index cce5ee84d29d..db52090bb27b 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1382,6 +1382,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x030e, 4)},	/* Quectel EM05GV2 */
 	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0104, 4)},	/* Fibocom NL678 series */
+	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0112, 0)},	/* Fibocom FG132 */
 	{QMI_FIXED_INTF(0x0489, 0xe0b4, 0)},	/* Foxconn T77W968 LTE */
 	{QMI_FIXED_INTF(0x0489, 0xe0b5, 0)},	/* Foxconn T77W968 LTE with eSIM support*/
 	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 85aad55b7a8f..77492bf0551c 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -108,7 +108,9 @@ static int pwm_imx_tpm_round_state(struct pwm_chip *chip,
 	p->prescale = prescale;
 
 	period_count = (clock_unit + ((1 << prescale) >> 1)) >> prescale;
-	p->mod = period_count;
+	if (period_count == 0)
+		return -EINVAL;
+	p->mod = period_count - 1;
 
 	/* calculate real period HW can support */
 	tmp = (u64)period_count << prescale;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0f9410ed4829..27d51b9f15d4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -472,12 +472,6 @@ static LIST_HEAD(spi_controller_list);
  */
 static DEFINE_MUTEX(board_lock);
 
-/*
- * Prevents addition of devices with same chip select and
- * addition of devices below an unregistering controller.
- */
-static DEFINE_MUTEX(spi_add_lock);
-
 /**
  * spi_alloc_device - Allocate a new SPI device
  * @ctlr: Controller to which device is connected
@@ -580,7 +574,7 @@ int spi_add_device(struct spi_device *spi)
 	 * chipselect **BEFORE** we call setup(), else we'll trash
 	 * its configuration.  Lock against concurrent add() calls.
 	 */
-	mutex_lock(&spi_add_lock);
+	mutex_lock(&ctlr->add_lock);
 
 	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
 	if (status) {
@@ -624,7 +618,7 @@ int spi_add_device(struct spi_device *spi)
 	}
 
 done:
-	mutex_unlock(&spi_add_lock);
+	mutex_unlock(&ctlr->add_lock);
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_add_device);
@@ -2512,6 +2506,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 	spin_lock_init(&ctlr->bus_lock_spinlock);
 	mutex_init(&ctlr->bus_lock_mutex);
 	mutex_init(&ctlr->io_mutex);
+	mutex_init(&ctlr->add_lock);
 	ctlr->bus_lock_flag = 0;
 	init_completion(&ctlr->xfer_completion);
 	if (!ctlr->max_dma_len)
@@ -2657,7 +2652,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 
 	/* Prevent addition of new devices, unregister existing ones */
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
-		mutex_lock(&spi_add_lock);
+		mutex_lock(&ctlr->add_lock);
 
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
 
@@ -2675,12 +2670,6 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 
 	device_del(&ctlr->dev);
 
-	/* Release the last reference on the controller if its driver
-	 * has not yet been converted to devm_spi_alloc_master/slave().
-	 */
-	if (!ctlr->devm_allocated)
-		put_device(&ctlr->dev);
-
 	/* free bus id */
 	mutex_lock(&board_lock);
 	if (found == ctlr)
@@ -2688,7 +2677,13 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	mutex_unlock(&board_lock);
 
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
-		mutex_unlock(&spi_add_lock);
+		mutex_unlock(&ctlr->add_lock);
+
+	/* Release the last reference on the controller if its driver
+	 * has not yet been converted to devm_spi_alloc_master/slave().
+	 */
+	if (!ctlr->devm_allocated)
+		put_device(&ctlr->dev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
 
diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index 832a41f9ee7d..1a423edd832c 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -286,8 +286,6 @@ static int sunxi_musb_exit(struct musb *musb)
 	if (test_bit(SUNXI_MUSB_FL_HAS_SRAM, &glue->flags))
 		sunxi_sram_release(musb->controller->parent);
 
-	devm_usb_put_phy(glue->dev, glue->xceiv);
-
 	return 0;
 }
 
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 3b4d1ff9033d..7ae2bc1c3c9b 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -846,11 +846,12 @@ static void edge_bulk_out_data_callback(struct urb *urb)
 static void edge_bulk_out_cmd_callback(struct urb *urb)
 {
 	struct edgeport_port *edge_port = urb->context;
+	struct device *dev = &urb->dev->dev;
 	int status = urb->status;
 
 	atomic_dec(&CmdUrbs);
-	dev_dbg(&urb->dev->dev, "%s - FREE URB %p (outstanding %d)\n",
-		__func__, urb, atomic_read(&CmdUrbs));
+	dev_dbg(dev, "%s - FREE URB %p (outstanding %d)\n", __func__, urb,
+		atomic_read(&CmdUrbs));
 
 
 	/* clean up the transfer buffer */
@@ -860,8 +861,7 @@ static void edge_bulk_out_cmd_callback(struct urb *urb)
 	usb_free_urb(urb);
 
 	if (status) {
-		dev_dbg(&urb->dev->dev,
-			"%s - nonzero write bulk status received: %d\n",
+		dev_dbg(dev, "%s - nonzero write bulk status received: %d\n",
 			__func__, status);
 		return;
 	}
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index aaa91f98d85b..4b77994d7a4d 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -251,6 +251,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_VENDOR_ID			0x2c7c
 /* These Quectel products use Quectel's vendor ID */
 #define QUECTEL_PRODUCT_EC21			0x0121
+#define QUECTEL_PRODUCT_RG650V			0x0122
 #define QUECTEL_PRODUCT_EM061K_LTA		0x0123
 #define QUECTEL_PRODUCT_EM061K_LMS		0x0124
 #define QUECTEL_PRODUCT_EC25			0x0125
@@ -1273,6 +1274,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG912Y, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG916Q, 0xff, 0x00, 0x00) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG650V, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG650V, 0xff, 0, 0) },
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
@@ -2320,6 +2323,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },		/* Fibocom FG150 AT */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0111, 0xff) },			/* Fibocom FM160 (MBIM mode) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0112, 0xff, 0xff, 0x30) },	/* Fibocom FG132 Diag */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0112, 0xff, 0xff, 0x40) },	/* Fibocom FG132 AT */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0112, 0xff, 0, 0) },		/* Fibocom FG132 NMEA */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0115, 0xff),			/* Fibocom FM135 (laptop MBIM) */
 	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index 5570c50d005d..69306e444da1 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -166,6 +166,8 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x1199, 0x9090)},	/* Sierra Wireless EM7565 QDL */
 	{DEVICE_SWI(0x1199, 0x9091)},	/* Sierra Wireless EM7565 */
 	{DEVICE_SWI(0x1199, 0x90d2)},	/* Sierra Wireless EM9191 QDL */
+	{DEVICE_SWI(0x1199, 0x90e4)},	/* Sierra Wireless EM86xx QDL*/
+	{DEVICE_SWI(0x1199, 0x90e5)},	/* Sierra Wireless EM86xx */
 	{DEVICE_SWI(0x1199, 0xc080)},	/* Sierra Wireless EM7590 QDL */
 	{DEVICE_SWI(0x1199, 0xc081)},	/* Sierra Wireless EM7590 */
 	{DEVICE_SWI(0x413c, 0x81a2)},	/* Dell Wireless 5806 Gobi(TM) 4G LTE Mobile Broadband Card */
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index dfdb7d4f8406..cc1a2689ac88 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -621,7 +621,7 @@ static int insert_delayed_ref(struct btrfs_trans_handle *trans,
 					      &href->ref_add_list);
 			else if (ref->action == BTRFS_DROP_DELAYED_REF) {
 				ASSERT(!list_empty(&exist->add_list));
-				list_del(&exist->add_list);
+				list_del_init(&exist->add_list);
 			} else {
 				ASSERT(0);
 			}
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 6a7a3b1d926e..251f45fee53c 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1494,6 +1494,7 @@ void nfs_fattr_init(struct nfs_fattr *fattr)
 	fattr->gencount = nfs_inc_attr_generation_counter();
 	fattr->owner_name = NULL;
 	fattr->group_name = NULL;
+	fattr->mdsthreshold = NULL;
 }
 EXPORT_SYMBOL_GPL(nfs_fattr_init);
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1d24fff2709c..55b18c145390 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1068,14 +1068,6 @@ nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, struct nfsd4_putfh *putfh)
 	DECODE_TAIL;
 }
 
-static __be32
-nfsd4_decode_putpubfh(struct nfsd4_compoundargs *argp, void *p)
-{
-	if (argp->minorversion == 0)
-		return nfs_ok;
-	return nfserr_notsupp;
-}
-
 static __be32
 nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 {
@@ -1825,7 +1817,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
 	[OP_OPEN_CONFIRM]	= (nfsd4_dec)nfsd4_decode_open_confirm,
 	[OP_OPEN_DOWNGRADE]	= (nfsd4_dec)nfsd4_decode_open_downgrade,
 	[OP_PUTFH]		= (nfsd4_dec)nfsd4_decode_putfh,
-	[OP_PUTPUBFH]		= (nfsd4_dec)nfsd4_decode_putpubfh,
+	[OP_PUTPUBFH]		= (nfsd4_dec)nfsd4_decode_noop,
 	[OP_PUTROOTFH]		= (nfsd4_dec)nfsd4_decode_noop,
 	[OP_READ]		= (nfsd4_dec)nfsd4_decode_read,
 	[OP_READDIR]		= (nfsd4_dec)nfsd4_decode_readdir,
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 0c62cb90d63d..3bbeea2e60f7 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1133,9 +1133,12 @@ int ocfs2_setattr(struct dentry *dentry, struct iattr *attr)
 	trace_ocfs2_setattr(inode, dentry,
 			    (unsigned long long)OCFS2_I(inode)->ip_blkno,
 			    dentry->d_name.len, dentry->d_name.name,
-			    attr->ia_valid, attr->ia_mode,
-			    from_kuid(&init_user_ns, attr->ia_uid),
-			    from_kgid(&init_user_ns, attr->ia_gid));
+			    attr->ia_valid,
+				attr->ia_valid & ATTR_MODE ? attr->ia_mode : 0,
+				attr->ia_valid & ATTR_UID ?
+					from_kuid(&init_user_ns, attr->ia_uid) : 0,
+				attr->ia_valid & ATTR_GID ?
+					from_kgid(&init_user_ns, attr->ia_gid) : 0);
 
 	/* ensuring we don't even attempt to truncate a symlink */
 	if (S_ISLNK(inode->i_mode))
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 42368577786e..5b56e10e510b 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -2042,8 +2042,7 @@ static int ocfs2_xa_remove(struct ocfs2_xa_loc *loc,
 				rc = 0;
 			ocfs2_xa_cleanup_value_truncate(loc, "removing",
 							orig_clusters);
-			if (rc)
-				goto out;
+			goto out;
 		}
 	}
 
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 80d904368613..0ff2f1ddf9ef 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -447,10 +447,6 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 #endif
 }
 
-static const struct vm_operations_struct vmcore_mmap_ops = {
-	.fault = mmap_vmcore_fault,
-};
-
 /**
  * vmcore_alloc_buf - allocate buffer in vmalloc memory
  * @sizez: size of buffer
@@ -478,6 +474,11 @@ static inline char *vmcore_alloc_buf(size_t size)
  * virtually contiguous user-space in ELF layout.
  */
 #ifdef CONFIG_MMU
+
+static const struct vm_operations_struct vmcore_mmap_ops = {
+	.fault = mmap_vmcore_fault,
+};
+
 /*
  * remap_oldmem_pfn_checked - do remap_oldmem_pfn_range replacing all pages
  * reported as not being ram with the zero page.
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d14aba548ff4..4d3657b630db 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2566,6 +2566,8 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
+int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot);
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
 int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2b3b2fc1cb33..afbe3056a8d7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -284,8 +284,8 @@ struct vm_userfaultfd_ctx {};
 #endif /* CONFIG_USERFAULTFD */
 
 /*
- * This struct defines a memory VMM memory area. There is one of these
- * per VM-area/task.  A VM area is any part of the process virtual memory
+ * This struct describes a virtual memory area. There is one of these
+ * per VM-area/task. A VM area is any part of the process virtual memory
  * space that has a special rule for the page-fault handlers (ie a shared
  * library, the executable area etc).
  */
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 4ab9bccfcde0..9db457532870 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1064,6 +1064,7 @@ struct nand_legacy {
  * @lock:		lock protecting the suspended field. Also used to
  *			serialize accesses to the NAND device.
  * @suspended:		set to 1 when the device is suspended, 0 when it's not.
+ * @resume_wq:		wait queue to sleep if rawnand is in suspended state.
  * @bbt:		[INTERN] bad block table pointer
  * @bbt_td:		[REPLACEABLE] bad block table descriptor for flash
  *			lookup.
@@ -1117,6 +1118,7 @@ struct nand_chip {
 
 	struct mutex lock;
 	unsigned int suspended : 1;
+	wait_queue_head_t resume_wq;
 
 	uint8_t *oob_poi;
 	struct nand_controller *controller;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index ca39b33105bd..1b9cb90480e2 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -483,6 +483,9 @@ struct spi_controller {
 	/* I/O mutex */
 	struct mutex		io_mutex;
 
+	/* Used to avoid adding the same CS twice */
+	struct mutex		add_lock;
+
 	/* lock and mutex for SPI bus locking */
 	spinlock_t		bus_lock_spinlock;
 	struct mutex		bus_lock_mutex;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0901911b42b5..013b9062c47c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9558,7 +9558,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 	/* 'struct bpf_verifier_env' can be global, but since it's not small,
 	 * allocate/free it every time bpf_check() is called
 	 */
-	env = kzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
+	env = kvzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
 	if (!env)
 		return -ENOMEM;
 	log = &env->log;
@@ -9728,6 +9728,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 		mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
 err_free_env:
-	kfree(env);
+	kvfree(env);
 	return ret;
 }
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 412505d94865..60bf8a6d55ce 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1552,7 +1552,9 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 	struct dyn_ftrace key;
+	unsigned long ip = 0;
 
+	rcu_read_lock();
 	key.ip = start;
 	key.flags = end;	/* overload flags, as it is unsigned long */
 
@@ -1565,10 +1567,13 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 			      sizeof(struct dyn_ftrace),
 			      ftrace_cmp_recs);
 		if (rec)
-			return rec->ip;
+		{
+			ip = rec->ip;
+			break;
+		}
 	}
-
-	return 0;
+	rcu_read_unlock();
+	return ip;
 }
 
 /**
@@ -5736,6 +5741,8 @@ static int ftrace_process_locs(struct module *mod,
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
 		WARN_ON(!skipped);
+		/* Need to synchronize with ftrace_location_range() */
+		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
 	}
 	return ret;
@@ -5889,6 +5896,9 @@ void ftrace_release_mod(struct module *mod)
  out_unlock:
 	mutex_unlock(&ftrace_lock);
 
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page)
+		synchronize_rcu();
 	for (pg = tmp_page; pg; pg = tmp_page) {
 
 		/* Needs to be called outside of ftrace_lock */
@@ -6196,6 +6206,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	unsigned long start = (unsigned long)(start_ptr);
 	unsigned long end = (unsigned long)(end_ptr);
 	struct ftrace_page **last_pg = &ftrace_pages_start;
+	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 	struct dyn_ftrace key;
@@ -6239,12 +6250,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		ftrace_update_tot_cnt--;
 		if (!pg->index) {
 			*last_pg = pg->next;
-			if (pg->records) {
-				free_pages((unsigned long)pg->records, pg->order);
-				ftrace_number_of_pages -= 1 << pg->order;
-			}
-			ftrace_number_of_groups--;
-			kfree(pg);
+			pg->next = tmp_page;
+			tmp_page = pg;
 			pg = container_of(last_pg, struct ftrace_page, next);
 			if (!(*last_pg))
 				ftrace_pages = pg;
@@ -6261,6 +6268,11 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		clear_func_from_hashes(func);
 		kfree(func);
 	}
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page) {
+		synchronize_rcu();
+		ftrace_free_pages(tmp_page);
+	}
 }
 
 void __init ftrace_free_init_mem(void)
diff --git a/mm/memory.c b/mm/memory.c
index f8d76c66311d..3cde782d2856 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1917,28 +1917,18 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 	return 0;
 }
 
-/**
- * remap_pfn_range - remap kernel memory to userspace
- * @vma: user vma to map to
- * @addr: target user address to start at
- * @pfn: physical address of kernel memory
- * @size: size of map area
- * @prot: page protection flags for this mapping
- *
- * Note: this is only safe if the mm semaphore is held when called.
- *
- * Return: %0 on success, negative error code otherwise.
- */
-int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
-		    unsigned long pfn, unsigned long size, pgprot_t prot)
+static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	pgd_t *pgd;
 	unsigned long next;
 	unsigned long end = addr + PAGE_ALIGN(size);
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long remap_pfn = pfn;
 	int err;
 
+	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr)))
+		return -EINVAL;
+
 	/*
 	 * Physically remapped pages are special. Tell the
 	 * rest of the world about it:
@@ -1963,10 +1953,6 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 		vma->vm_pgoff = pfn;
 	}
 
-	err = track_pfn_remap(vma, &prot, remap_pfn, addr, PAGE_ALIGN(size));
-	if (err)
-		return -EINVAL;
-
 	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
 
 	BUG_ON(addr >= end);
@@ -1978,12 +1964,57 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 		err = remap_p4d_range(mm, pgd, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
-			break;
+			return err;
 	} while (pgd++, addr = next, addr != end);
 
+	return 0;
+}
+
+/*
+ * Variant of remap_pfn_range that does not call track_pfn_remap.  The caller
+ * must have pre-validated the caching bits of the pgprot_t.
+ */
+int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	int error = remap_pfn_range_internal(vma, addr, pfn, size, prot);
+
+	if (!error)
+		return 0;
+
+	/*
+	 * A partial pfn range mapping is dangerous: it does not
+	 * maintain page reference counts, and callers may free
+	 * pages due to the error. So zap it early.
+	 */
+	zap_page_range_single(vma, addr, size, NULL);
+	return error;
+}
+
+/**
+ * remap_pfn_range - remap kernel memory to userspace
+ * @vma: user vma to map to
+ * @addr: target page aligned user address to start at
+ * @pfn: page frame number of kernel physical memory address
+ * @size: size of mapping area
+ * @prot: page protection flags for this mapping
+ *
+ * Note: this is only safe if the mm semaphore is held when called.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		    unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	int err;
+
+	err = track_pfn_remap(vma, &prot, pfn, addr, PAGE_ALIGN(size));
 	if (err)
-		untrack_pfn(vma, remap_pfn, PAGE_ALIGN(size));
+		return -EINVAL;
 
+	err = remap_pfn_range_notrack(vma, addr, pfn, size, prot);
+	if (err)
+		untrack_pfn(vma, pfn, PAGE_ALIGN(size));
 	return err;
 }
 EXPORT_SYMBOL(remap_pfn_range);
diff --git a/net/9p/client.c b/net/9p/client.c
index 2b54f1cef2b0..6e9d7a5ac6bc 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1001,8 +1001,10 @@ static int p9_client_version(struct p9_client *c)
 struct p9_client *p9_client_create(const char *dev_name, char *options)
 {
 	int err;
+	static atomic_t seqno = ATOMIC_INIT(0);
 	struct p9_client *clnt;
 	char *client_id;
+	char *cache_name;
 
 	err = 0;
 	clnt = kmalloc(sizeof(struct p9_client), GFP_KERNEL);
@@ -1055,15 +1057,23 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	if (err)
 		goto close_trans;
 
+	cache_name = kasprintf(GFP_KERNEL,
+		"9p-fcall-cache-%u", atomic_inc_return(&seqno));
+	if (!cache_name) {
+		err = -ENOMEM;
+		goto close_trans;
+	}
+
 	/* P9_HDRSZ + 4 is the smallest packet header we can have that is
 	 * followed by data accessed from userspace by read
 	 */
 	clnt->fcall_cache =
-		kmem_cache_create_usercopy("9p-fcall-cache", clnt->msize,
+		kmem_cache_create_usercopy(cache_name, clnt->msize,
 					   0, 0, P9_HDRSZ + 4,
 					   clnt->msize - (P9_HDRSZ + 4),
 					   NULL);
 
+	kfree(cache_name);
 	return clnt;
 
 close_trans:
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 501f77f0f480..87162b809a89 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -35,6 +35,11 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	const unsigned char *dest;
 	u16 vid = 0;
 
+	if (unlikely(!pskb_may_pull(skb, ETH_HLEN))) {
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
 
 	rcu_read_lock();
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 67df4022853b..6b613569372a 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -3637,7 +3637,7 @@ enum sctp_disposition sctp_sf_ootb(struct net *net,
 		}
 
 		ch = (struct sctp_chunkhdr *)ch_end;
-	} while (ch_end < skb_tail_pointer(skb));
+	} while (ch_end + sizeof(*ch) < skb_tail_pointer(skb));
 
 	if (ootb_shut_ack)
 		return sctp_sf_shut_8_4_5(net, ep, asoc, type, arg, commands);
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index a3c57c048cbd..95d3f57b1247 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -531,6 +531,7 @@ static void hvs_destruct(struct vsock_sock *vsk)
 		vmbus_hvsock_device_unregister(chan);
 
 	kfree(hvs);
+	vsk->trans = NULL;
 }
 
 static int hvs_dgram_bind(struct vsock_sock *vsk, struct sockaddr_vm *addr)
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 434c5608a75d..d12d0c85b523 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -680,6 +680,7 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
 	struct virtio_vsock_sock *vvs = vsk->trans;
 
 	kfree(vvs);
+	vsk->trans = NULL;
 }
 EXPORT_SYMBOL_GPL(virtio_transport_destruct);
 
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 5ca620d31cd3..5ec89db5a7c1 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -772,8 +772,11 @@ static bool search_nested_keyrings(struct key *keyring,
 	for (; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
 		ptr = READ_ONCE(node->slots[slot]);
 
-		if (assoc_array_ptr_is_meta(ptr) && node->back_pointer)
-			goto descend_to_node;
+		if (assoc_array_ptr_is_meta(ptr)) {
+			if (node->back_pointer ||
+			    assoc_array_ptr_is_shortcut(ptr))
+				goto descend_to_node;
+		}
 
 		if (!keyring_ptr_is_keyring(ptr))
 			continue;
diff --git a/sound/Kconfig b/sound/Kconfig
index aaf2022ffc57..cb4cb0d5b959 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig SOUND
 	tristate "Sound card support"
-	depends on HAS_IOMEM || UML
+	depends on HAS_IOMEM || INDIRECT_IOMEM
 	help
 	  If you have a sound card in your computer, i.e. if it can say more
 	  than an occasional beep, say Y.
diff --git a/sound/firewire/tascam/amdtp-tascam.c b/sound/firewire/tascam/amdtp-tascam.c
index f823a2ab3544..8ffc065b77f9 100644
--- a/sound/firewire/tascam/amdtp-tascam.c
+++ b/sound/firewire/tascam/amdtp-tascam.c
@@ -244,7 +244,7 @@ int amdtp_tscm_init(struct amdtp_stream *s, struct fw_unit *unit,
 			CIP_NONBLOCKING | CIP_SKIP_DBC_ZERO_CHECK, fmt,
 			process_ctx_payloads, sizeof(struct amdtp_tscm));
 	if (err < 0)
-		return 0;
+		return err;
 
 	if (dir == AMDTP_OUT_STREAM) {
 		// Use fixed value for FDF field.
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 1f7c80541d03..1b547094de59 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -24,6 +24,7 @@
 #include <sound/asoundef.h>
 #include <sound/core.h>
 #include <sound/control.h>
+#include <sound/hda_verbs.h>
 #include <sound/hwdep.h>
 #include <sound/info.h>
 #include <sound/tlv.h>
@@ -1792,6 +1793,169 @@ static int snd_soundblaster_e1_switch_create(struct usb_mixer_interface *mixer)
 					  NULL);
 }
 
+/*
+ * Dell WD15 dock jack detection
+ *
+ * The WD15 contains an ALC4020 USB audio controller and ALC3263 audio codec
+ * from Realtek. It is a UAC 1 device, and UAC 1 does not support jack
+ * detection. Instead, jack detection works by sending HD Audio commands over
+ * vendor-type USB messages.
+ */
+
+#define HDA_VERB_CMD(V, N, D) (((N) << 20) | ((V) << 8) | (D))
+
+#define REALTEK_HDA_VALUE 0x0038
+
+#define REALTEK_HDA_SET		62
+#define REALTEK_HDA_GET_OUT	88
+#define REALTEK_HDA_GET_IN	89
+
+#define REALTEK_LINE1			0x1a
+#define REALTEK_VENDOR_REGISTERS	0x20
+#define REALTEK_HP_OUT			0x21
+
+#define REALTEK_CBJ_CTRL2 0x50
+
+#define REALTEK_JACK_INTERRUPT_NODE 5
+
+#define REALTEK_MIC_FLAG 0x100
+
+static int realtek_hda_set(struct snd_usb_audio *chip, u32 cmd)
+{
+	struct usb_device *dev = chip->dev;
+	__be32 buf = cpu_to_be32(cmd);
+
+	return snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), REALTEK_HDA_SET,
+			       USB_RECIP_DEVICE | USB_TYPE_VENDOR | USB_DIR_OUT,
+			       REALTEK_HDA_VALUE, 0, &buf, sizeof(buf));
+}
+
+static int realtek_hda_get(struct snd_usb_audio *chip, u32 cmd, u32 *value)
+{
+	struct usb_device *dev = chip->dev;
+	int err;
+	__be32 buf = cpu_to_be32(cmd);
+
+	err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), REALTEK_HDA_GET_OUT,
+			      USB_RECIP_DEVICE | USB_TYPE_VENDOR | USB_DIR_OUT,
+			      REALTEK_HDA_VALUE, 0, &buf, sizeof(buf));
+	if (err < 0)
+		return err;
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), REALTEK_HDA_GET_IN,
+			      USB_RECIP_DEVICE | USB_TYPE_VENDOR | USB_DIR_IN,
+			      REALTEK_HDA_VALUE, 0, &buf, sizeof(buf));
+	if (err < 0)
+		return err;
+
+	*value = be32_to_cpu(buf);
+	return 0;
+}
+
+static int realtek_ctl_connector_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	struct snd_usb_audio *chip = cval->head.mixer->chip;
+	u32 pv = kcontrol->private_value;
+	u32 node_id = pv & 0xff;
+	u32 sense;
+	u32 cbj_ctrl2;
+	bool presence;
+	int err;
+
+	err = snd_usb_lock_shutdown(chip);
+	if (err < 0)
+		return err;
+	err = realtek_hda_get(chip,
+			      HDA_VERB_CMD(AC_VERB_GET_PIN_SENSE, node_id, 0),
+			      &sense);
+	if (err < 0)
+		goto err;
+	if (pv & REALTEK_MIC_FLAG) {
+		err = realtek_hda_set(chip,
+				      HDA_VERB_CMD(AC_VERB_SET_COEF_INDEX,
+						   REALTEK_VENDOR_REGISTERS,
+						   REALTEK_CBJ_CTRL2));
+		if (err < 0)
+			goto err;
+		err = realtek_hda_get(chip,
+				      HDA_VERB_CMD(AC_VERB_GET_PROC_COEF,
+						   REALTEK_VENDOR_REGISTERS, 0),
+				      &cbj_ctrl2);
+		if (err < 0)
+			goto err;
+	}
+err:
+	snd_usb_unlock_shutdown(chip);
+	if (err < 0)
+		return err;
+
+	presence = sense & AC_PINSENSE_PRESENCE;
+	if (pv & REALTEK_MIC_FLAG)
+		presence = presence && (cbj_ctrl2 & 0x0070) == 0x0070;
+	ucontrol->value.integer.value[0] = presence;
+	return 0;
+}
+
+static const struct snd_kcontrol_new realtek_connector_ctl_ro = {
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.name = "", /* will be filled later manually */
+	.access = SNDRV_CTL_ELEM_ACCESS_READ,
+	.info = snd_ctl_boolean_mono_info,
+	.get = realtek_ctl_connector_get,
+};
+
+static int realtek_resume_jack(struct usb_mixer_elem_list *list)
+{
+	snd_ctl_notify(list->mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+		       &list->kctl->id);
+	return 0;
+}
+
+static int realtek_add_jack(struct usb_mixer_interface *mixer,
+			    char *name, u32 val)
+{
+	struct usb_mixer_elem_info *cval;
+	struct snd_kcontrol *kctl;
+
+	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
+	if (!cval)
+		return -ENOMEM;
+	snd_usb_mixer_elem_init_std(&cval->head, mixer,
+				    REALTEK_JACK_INTERRUPT_NODE);
+	cval->head.resume = realtek_resume_jack;
+	cval->val_type = USB_MIXER_BOOLEAN;
+	cval->channels = 1;
+	cval->min = 0;
+	cval->max = 1;
+	kctl = snd_ctl_new1(&realtek_connector_ctl_ro, cval);
+	if (!kctl) {
+		kfree(cval);
+		return -ENOMEM;
+	}
+	kctl->private_value = val;
+	strscpy(kctl->id.name, name, sizeof(kctl->id.name));
+	kctl->private_free = snd_usb_mixer_elem_free;
+	return snd_usb_mixer_add_control(&cval->head, kctl);
+}
+
+static int dell_dock_mixer_create(struct usb_mixer_interface *mixer)
+{
+	int err;
+
+	err = realtek_add_jack(mixer, "Line Out Jack", REALTEK_LINE1);
+	if (err < 0)
+		return err;
+	err = realtek_add_jack(mixer, "Headphone Jack", REALTEK_HP_OUT);
+	if (err < 0)
+		return err;
+	err = realtek_add_jack(mixer, "Headset Mic Jack",
+			       REALTEK_HP_OUT | REALTEK_MIC_FLAG);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
 static void dell_dock_init_vol(struct snd_usb_audio *chip, int ch, int id)
 {
 	u16 buf = 0;
@@ -2275,8 +2439,14 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_soundblaster_e1_switch_create(mixer);
 		break;
 	case USB_ID(0x0bda, 0x4014): /* Dell WD15 dock */
+		err = dell_dock_mixer_create(mixer);
+		if (err < 0)
+			break;
 		err = dell_dock_mixer_init(mixer);
 		break;
+	case USB_ID(0x0bda, 0x402e): /* Dell WD19 dock */
+		err = dell_dock_mixer_create(mixer);
+		break;
 
 	case USB_ID(0x2a39, 0x3fd2): /* RME ADI-2 Pro */
 	case USB_ID(0x2a39, 0x3fd3): /* RME ADI-2 DAC */

