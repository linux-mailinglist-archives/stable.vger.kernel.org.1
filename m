Return-Path: <stable+bounces-93683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C869D0437
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 15:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320DC28340E
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63A71D966B;
	Sun, 17 Nov 2024 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gOvwnadV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65B76048;
	Sun, 17 Nov 2024 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731853103; cv=none; b=orTmjFstELKEyVsNSML/3G4ix2pQyX3UM3Q9eIXbR2240ccFIZeT+lDu9QZ0sCexVlQvIRma6rkXWExaK790c5nJZexauIEiM+G66u0F+SjeDWyUWIviLtZ86IG2YdnRv1N4GSvuXXsUTrracJt2ds/6VzHHu4BWFZ2O4bsObZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731853103; c=relaxed/simple;
	bh=+dq11QtYtSoLKnl/NrUI9mc98lYhhHKz+428fSC9hDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSeCi4PFf3j/FF13Z73R8Ce5G+VJ6zz8++bYMLlsFV1dBLe9ht5J6+vLUTELkfUq8sUR3M5/uCFtIVNophDNpL6BT2dqOIK+JziI+2n3AyIV5UZXgzTF8NYXr9Nv8Y3YUlMCLs8J8Y2wBpS4aqb2MnNwJRrPrVPiNpO9XPz01kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gOvwnadV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CEAC4CECD;
	Sun, 17 Nov 2024 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731853103;
	bh=+dq11QtYtSoLKnl/NrUI9mc98lYhhHKz+428fSC9hDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gOvwnadVMx8Axe2XHSzOY5QahHMGHX38lwK+yI9JDzegAoiHJqosz6vuqa5v5Jnj+
	 OPOk1fX03jjTg3GUz+6TktkFMbDEHGEieq4ImctAsQSmGwFEfb0JFQEVI69GEKtZBZ
	 MAJwFZa4VooAf8CKSFkOpNe4qu6QE5ItBOO24TSQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.324
Date: Sun, 17 Nov 2024 15:17:52 +0100
Message-ID: <2024111751-revenue-enroll-3823@gregkh>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111751-reclusive-perennial-7b59@gregkh>
References: <2024111751-reclusive-perennial-7b59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 0f4d0d011787..bb5071b9a89a 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 323
+SUBLEVEL = 324
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index cd109aebb783..c7fda457e5a8 100644
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
index c5144f06c3e7..9e30c726b708 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -316,12 +316,13 @@
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
 
@@ -331,7 +332,6 @@
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru  PCLK_HDMI>;
 		clock-names = "pclk";
-		rockchip,grf = <&grf>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&hdmi_ctl>;
 		status = "disabled";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
index b14d83919f14..dacb1331ae9c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
@@ -123,7 +123,7 @@
 	status = "okay";
 
 	rt5651: rt5651@1a {
-		compatible = "rockchip,rt5651";
+		compatible = "realtek,rt5651";
 		reg = <0x1a>;
 		clocks = <&cru SCLK_I2S_8CH_OUT>;
 		clock-names = "mclk";
diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index e71f2111c8c0..676ec9fdd115 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -289,6 +289,7 @@ int __init opal_event_init(void)
 				 name, NULL);
 		if (rc) {
 			pr_warn("Error %d requesting OPAL irq %d\n", rc, (int)r->start);
+			kfree(name);
 			continue;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index bf8044bf4734..cb27016b2a76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -115,8 +115,8 @@ static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
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
index 98bd8a23e5b0..4776196b2021 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -394,7 +394,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	if (!adev->smc_rreg)
 		return -EOPNOTSUPP;
 
-	if (size & 0x3 || *pos & 0x3)
+	if (size > 4096 || size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
 	while (size) {
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 0757097d2550..3387e64d8441 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1482,7 +1482,7 @@ u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags)
 
 	u32 len = hid_report_len(report) + 7;
 
-	return kmalloc(len, flags);
+	return kzalloc(len, flags);
 }
 EXPORT_SYMBOL_GPL(hid_alloc_report_buf);
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 14dc5ec9edc6..6e975d639c36 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1986,6 +1986,11 @@ static const struct hid_device_id mt_devices[] = {
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
index 8d8b8d192e2e..e712b7705487 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -252,6 +252,13 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
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
index b3371812a215..016212f9991d 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2080,7 +2080,6 @@ struct cache_args {
 	sector_t cache_sectors;
 
 	struct dm_dev *origin_dev;
-	sector_t origin_sectors;
 
 	uint32_t block_size;
 
@@ -2162,6 +2161,7 @@ static int parse_cache_dev(struct cache_args *ca, struct dm_arg_set *as,
 static int parse_origin_dev(struct cache_args *ca, struct dm_arg_set *as,
 			    char **error)
 {
+	sector_t origin_sectors;
 	int r;
 
 	if (!at_least_one_arg(as, error))
@@ -2174,8 +2174,8 @@ static int parse_origin_dev(struct cache_args *ca, struct dm_arg_set *as,
 		return r;
 	}
 
-	ca->origin_sectors = get_dev_size(ca->origin_dev);
-	if (ca->ti->len > ca->origin_sectors) {
+	origin_sectors = get_dev_size(ca->origin_dev);
+	if (ca->ti->len > origin_sectors) {
 		*error = "Device size larger than cached device";
 		return -EINVAL;
 	}
@@ -2498,7 +2498,7 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 
 	ca->metadata_dev = ca->origin_dev = ca->cache_dev = NULL;
 
-	origin_blocks = cache->origin_sectors = ca->origin_sectors;
+	origin_blocks = cache->origin_sectors = ti->len;
 	origin_blocks = block_div(origin_blocks, ca->block_size);
 	cache->origin_blocks = to_oblock(origin_blocks);
 
@@ -2991,19 +2991,19 @@ static dm_cblock_t get_cache_dev_size(struct cache *cache)
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
@@ -3039,20 +3039,15 @@ static int cache_preresume(struct dm_target *ti)
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
diff --git a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
index 182a300e2d44..84f8ca9bf028 100644
--- a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
+++ b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
@@ -1639,6 +1639,9 @@ static void tpg_precalculate_line(struct tpg_data *tpg)
 	unsigned p;
 	unsigned x;
 
+	if (WARN_ON_ONCE(!tpg->src_width || !tpg->scaled_width))
+		return;
+
 	switch (tpg->pattern) {
 	case TPG_PAT_GREEN:
 		contrast = TPG_COLOR_100_RED;
diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 90acf52cc253..6082a8019c15 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -454,8 +454,8 @@ static int dvb_frontend_swzigzag_autotune(struct dvb_frontend *fe, int check_wra
 
 		default:
 			fepriv->auto_step++;
-			fepriv->auto_sub_step = -1; /* it'll be incremented to 0 in a moment */
-			break;
+			fepriv->auto_sub_step = 0;
+			continue;
 		}
 
 		if (!ready) fepriv->auto_sub_step++;
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 5124f412c05d..49d55c5bf717 100644
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
index cb82998619c8..a26fc0ad20eb 100644
--- a/drivers/media/dvb-frontends/cx24116.c
+++ b/drivers/media/dvb-frontends/cx24116.c
@@ -753,6 +753,7 @@ static int cx24116_read_snr_pct(struct dvb_frontend *fe, u16 *snr)
 {
 	struct cx24116_state *state = fe->demodulator_priv;
 	u8 snr_reading;
+	int ret;
 	static const u32 snr_tab[] = { /* 10 x Table (rounded up) */
 		0x00000, 0x0199A, 0x03333, 0x04ccD, 0x06667,
 		0x08000, 0x0999A, 0x0b333, 0x0cccD, 0x0e667,
@@ -761,7 +762,11 @@ static int cx24116_read_snr_pct(struct dvb_frontend *fe, u16 *snr)
 
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
index bd2defde7a77..ba2394e924a6 100644
--- a/drivers/media/dvb-frontends/stb0899_algo.c
+++ b/drivers/media/dvb-frontends/stb0899_algo.c
@@ -281,7 +281,7 @@ static enum stb0899_status stb0899_search_carrier(struct stb0899_state *state)
 
 	short int derot_freq = 0, last_derot_freq = 0, derot_limit, next_loop = 3;
 	int index = 0;
-	u8 cfr[2];
+	u8 cfr[2] = {0};
 	u8 reg;
 
 	internal->status = NOCARRIER;
diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index 04577d409e63..c48952f36af1 100644
--- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -2453,10 +2453,10 @@ static int adv76xx_log_status(struct v4l2_subdev *sd)
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
@@ -2555,13 +2555,21 @@ static int adv76xx_log_status(struct v4l2_subdev *sd)
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
index fa7c42cf4b4e..7d36e0fdb8cc 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.c
@@ -803,11 +803,14 @@ static void exynos4_jpeg_parse_decode_h_tbl(struct s5p_jpeg_ctx *ctx)
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
 
@@ -1086,6 +1089,7 @@ static int get_word_be(struct s5p_jpeg_buffer *buf, unsigned int *word)
 	if (byte == -1)
 		return -1;
 	*word = (unsigned int)byte | temp;
+
 	return 0;
 }
 
@@ -1173,7 +1177,7 @@ static bool s5p_jpeg_parse_hdr(struct s5p_jpeg_q_data *result,
 			if (get_word_be(&jpeg_buffer, &word))
 				break;
 			length = (long)word - 2;
-			if (!length)
+			if (length <= 0)
 				return false;
 			sof = jpeg_buffer.curr; /* after 0xffc0 */
 			sof_len = length;
@@ -1204,7 +1208,7 @@ static bool s5p_jpeg_parse_hdr(struct s5p_jpeg_q_data *result,
 			if (get_word_be(&jpeg_buffer, &word))
 				break;
 			length = (long)word - 2;
-			if (!length)
+			if (length <= 0)
 				return false;
 			if (n_dqt >= S5P_JPEG_MAX_MARKER)
 				return false;
@@ -1217,7 +1221,7 @@ static bool s5p_jpeg_parse_hdr(struct s5p_jpeg_q_data *result,
 			if (get_word_be(&jpeg_buffer, &word))
 				break;
 			length = (long)word - 2;
-			if (!length)
+			if (length <= 0)
 				return false;
 			if (n_dht >= S5P_JPEG_MAX_MARKER)
 				return false;
@@ -1242,6 +1246,7 @@ static bool s5p_jpeg_parse_hdr(struct s5p_jpeg_q_data *result,
 			if (get_word_be(&jpeg_buffer, &word))
 				break;
 			length = (long)word - 2;
+			/* No need to check underflows as skip() does it  */
 			skip(&jpeg_buffer, length);
 			break;
 		}
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 6367ee9c0066..cbad244a307d 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -575,7 +575,7 @@ static int uvc_parse_format(struct uvc_device *dev,
 	/* Parse the frame descriptors. Only uncompressed, MJPEG and frame
 	 * based formats have frame descriptors.
 	 */
-	while (buflen > 2 && buffer[1] == USB_DT_CS_INTERFACE &&
+	while (ftype && buflen > 2 && buffer[1] == USB_DT_CS_INTERFACE &&
 	       buffer[2] == ftype) {
 		frame = &format->frame[format->nframes];
 		if (ftype != UVC_VS_FRAME_FRAME_BASED)
diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 2278c5fff5c6..8e72c379740c 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -991,7 +991,6 @@ static int c_can_handle_bus_err(struct net_device *dev,
 
 	/* common for all type of bus errors */
 	priv->can.can_stats.bus_error++;
-	stats->rx_errors++;
 
 	/* propagate the error condition to the CAN stack */
 	skb = alloc_can_err_skb(dev, &cf);
@@ -1008,26 +1007,32 @@ static int c_can_handle_bus_err(struct net_device *dev,
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
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index b250d0fe9ac5..1265010f063f 100644
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
index bbd5183e5e63..57ccbc8a6c05 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1385,6 +1385,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x030e, 4)},	/* Quectel EM05GV2 */
 	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0104, 4)},	/* Fibocom NL678 series */
+	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0112, 0)},	/* Fibocom FG132 */
 	{QMI_FIXED_INTF(0x0489, 0xe0b4, 0)},	/* Foxconn T77W968 LTE */
 	{QMI_FIXED_INTF(0x0489, 0xe0b5, 0)},	/* Foxconn T77W968 LTE with eSIM support*/
 	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */
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
index 44c902c7d240..6e4478c0da14 100644
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
index 761054bdb733..641bf1b72c77 100644
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
index 09a12115b640..afb194d45a2e 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -426,7 +426,7 @@ static int insert_delayed_ref(struct btrfs_trans_handle *trans,
 					      &href->ref_add_list);
 			else if (ref->action == BTRFS_DROP_DELAYED_REF) {
 				ASSERT(!list_empty(&exist->add_list));
-				list_del(&exist->add_list);
+				list_del_init(&exist->add_list);
 			} else {
 				ASSERT(0);
 			}
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 592b95ab378b..36ce31f20e03 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1483,6 +1483,7 @@ void nfs_fattr_init(struct nfs_fattr *fattr)
 	fattr->gencount = nfs_inc_attr_generation_counter();
 	fattr->owner_name = NULL;
 	fattr->group_name = NULL;
+	fattr->mdsthreshold = NULL;
 }
 EXPORT_SYMBOL_GPL(nfs_fattr_init);
 
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 3c71c05a0581..9062002fd56c 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1143,9 +1143,12 @@ int ocfs2_setattr(struct dentry *dentry, struct iattr *attr)
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
index b9dfac2a5649..34358d88b481 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -2050,8 +2050,7 @@ static int ocfs2_xa_remove(struct ocfs2_xa_loc *loc,
 				rc = 0;
 			ocfs2_xa_cleanup_value_truncate(loc, "removing",
 							orig_clusters);
-			if (rc)
-				goto out;
+			goto out;
 		}
 	}
 
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index cd384a1ebef5..4618e8c61aba 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -431,10 +431,6 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 #endif
 }
 
-static const struct vm_operations_struct vmcore_mmap_ops = {
-	.fault = mmap_vmcore_fault,
-};
-
 /**
  * vmcore_alloc_buf - allocate buffer in vmalloc memory
  * @sizez: size of buffer
@@ -462,6 +458,11 @@ static inline char *vmcore_alloc_buf(size_t size)
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
diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
index 3a6c932b6dca..52467d0b4677 100644
--- a/include/net/bond_alb.h
+++ b/include/net/bond_alb.h
@@ -172,8 +172,8 @@ int bond_alb_init_slave(struct bonding *bond, struct slave *slave);
 void bond_alb_deinit_slave(struct bonding *bond, struct slave *slave);
 void bond_alb_handle_link_change(struct bonding *bond, struct slave *slave, char link);
 void bond_alb_handle_active_change(struct bonding *bond, struct slave *new_slave);
-int bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
-int bond_tlb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
+netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
+netdev_tx_t bond_tlb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
 void bond_alb_monitor(struct work_struct *);
 int bond_alb_set_mac_address(struct net_device *bond_dev, void *addr);
 void bond_alb_clear_vlan(struct bonding *bond, unsigned short vlan_id);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a48de55f5630..de0926cff835 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6446,7 +6446,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr)
 	/* 'struct bpf_verifier_env' can be global, but since it's not small,
 	 * allocate/free it every time bpf_check() is called
 	 */
-	env = kzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
+	env = kvzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
 	if (!env)
 		return -ENOMEM;
 	log = &env->log;
@@ -6573,6 +6573,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr)
 	mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
 err_free_env:
-	kfree(env);
+	kvfree(env);
 	return ret;
 }
diff --git a/net/9p/client.c b/net/9p/client.c
index a7518e8e7626..0bc87544914c 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1016,8 +1016,10 @@ static int p9_client_version(struct p9_client *c)
 struct p9_client *p9_client_create(const char *dev_name, char *options)
 {
 	int err;
+	static atomic_t seqno = ATOMIC_INIT(0);
 	struct p9_client *clnt;
 	char *client_id;
+	char *cache_name;
 
 	err = 0;
 	clnt = kmalloc(sizeof(struct p9_client), GFP_KERNEL);
@@ -1070,15 +1072,23 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
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
index 9475e0443ff9..233d4bb975ca 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -41,6 +41,11 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
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
index 8298f27e8de0..0b44ad00dbb6 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -3652,7 +3652,7 @@ enum sctp_disposition sctp_sf_ootb(struct net *net,
 		}
 
 		ch = (struct sctp_chunkhdr *)ch_end;
-	} while (ch_end < skb_tail_pointer(skb));
+	} while (ch_end + sizeof(*ch) < skb_tail_pointer(skb));
 
 	if (ootb_shut_ack)
 		return sctp_sf_shut_8_4_5(net, ep, asoc, type, arg, commands);
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 2bdf36845a5f..144883fdc83c 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -510,6 +510,7 @@ static void hvs_destruct(struct vsock_sock *vsk)
 		vmbus_hvsock_device_unregister(chan);
 
 	kfree(hvs);
+	vsk->trans = NULL;
 }
 
 static int hvs_dgram_bind(struct vsock_sock *vsk, struct sockaddr_vm *addr)
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 187d0f7253a6..25aade735857 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -646,6 +646,7 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
 	struct virtio_vsock_sock *vvs = vsk->trans;
 
 	kfree(vvs);
+	vsk->trans = NULL;
 }
 EXPORT_SYMBOL_GPL(virtio_transport_destruct);
 
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index e8f2366021ea..0f414a114729 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -739,8 +739,11 @@ static bool search_nested_keyrings(struct key *keyring,
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
index 76febc37862d..be30a24daaf1 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -1,6 +1,6 @@
 menuconfig SOUND
 	tristate "Sound card support"
-	depends on HAS_IOMEM || UML
+	depends on HAS_IOMEM || INDIRECT_IOMEM
 	help
 	  If you have a sound card in your computer, i.e. if it can say more
 	  than an occasional beep, say Y.
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index c376471cf760..463c04e82558 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2178,11 +2178,16 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 		goto _end_unlock;
 
 	if (!is_playback &&
-	    runtime->status->state == SNDRV_PCM_STATE_PREPARED &&
-	    size >= runtime->start_threshold) {
-		err = snd_pcm_start(substream);
-		if (err < 0)
+	    runtime->status->state == SNDRV_PCM_STATE_PREPARED) {
+		if (size >= runtime->start_threshold) {
+			err = snd_pcm_start(substream);
+			if (err < 0)
+				goto _end_unlock;
+		} else {
+			/* nothing to do */
+			err = 0;
 			goto _end_unlock;
+		}
 	}
 
 	runtime->twake = runtime->control->avail_min ? : 1;
diff --git a/sound/firewire/tascam/amdtp-tascam.c b/sound/firewire/tascam/amdtp-tascam.c
index ab482423c165..726cf659133b 100644
--- a/sound/firewire/tascam/amdtp-tascam.c
+++ b/sound/firewire/tascam/amdtp-tascam.c
@@ -172,7 +172,7 @@ int amdtp_tscm_init(struct amdtp_stream *s, struct fw_unit *unit,
 				CIP_NONBLOCKING | CIP_SKIP_DBC_ZERO_CHECK, fmt,
 				process_data_blocks, sizeof(struct amdtp_tscm));
 	if (err < 0)
-		return 0;
+		return err;
 
 	/* Use fixed value for FDF field. */
 	s->fdf = 0x00;
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 3bb89fcaa2f5..897d3118357b 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -29,6 +29,7 @@
 
 #include <linux/hid.h>
 #include <linux/init.h>
+#include <linux/math64.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
 #include <linux/usb/audio.h>
@@ -36,6 +37,7 @@
 #include <sound/asoundef.h>
 #include <sound/core.h>
 #include <sound/control.h>
+#include <sound/hda_verbs.h>
 #include <sound/hwdep.h>
 #include <sound/info.h>
 #include <sound/tlv.h>
@@ -1803,6 +1805,169 @@ static int snd_soundblaster_e1_switch_create(struct usb_mixer_interface *mixer)
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
@@ -1823,6 +1988,380 @@ static int dell_dock_mixer_init(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
+/* RME Class Compliant device quirks */
+
+#define SND_RME_GET_STATUS1			23
+#define SND_RME_GET_CURRENT_FREQ		17
+#define SND_RME_CLK_SYSTEM_SHIFT		16
+#define SND_RME_CLK_SYSTEM_MASK			0x1f
+#define SND_RME_CLK_AES_SHIFT			8
+#define SND_RME_CLK_SPDIF_SHIFT			12
+#define SND_RME_CLK_AES_SPDIF_MASK		0xf
+#define SND_RME_CLK_SYNC_SHIFT			6
+#define SND_RME_CLK_SYNC_MASK			0x3
+#define SND_RME_CLK_FREQMUL_SHIFT		18
+#define SND_RME_CLK_FREQMUL_MASK		0x7
+#define SND_RME_CLK_SYSTEM(x) \
+	((x >> SND_RME_CLK_SYSTEM_SHIFT) & SND_RME_CLK_SYSTEM_MASK)
+#define SND_RME_CLK_AES(x) \
+	((x >> SND_RME_CLK_AES_SHIFT) & SND_RME_CLK_AES_SPDIF_MASK)
+#define SND_RME_CLK_SPDIF(x) \
+	((x >> SND_RME_CLK_SPDIF_SHIFT) & SND_RME_CLK_AES_SPDIF_MASK)
+#define SND_RME_CLK_SYNC(x) \
+	((x >> SND_RME_CLK_SYNC_SHIFT) & SND_RME_CLK_SYNC_MASK)
+#define SND_RME_CLK_FREQMUL(x) \
+	((x >> SND_RME_CLK_FREQMUL_SHIFT) & SND_RME_CLK_FREQMUL_MASK)
+#define SND_RME_CLK_AES_LOCK			0x1
+#define SND_RME_CLK_AES_SYNC			0x4
+#define SND_RME_CLK_SPDIF_LOCK			0x2
+#define SND_RME_CLK_SPDIF_SYNC			0x8
+#define SND_RME_SPDIF_IF_SHIFT			4
+#define SND_RME_SPDIF_FORMAT_SHIFT		5
+#define SND_RME_BINARY_MASK			0x1
+#define SND_RME_SPDIF_IF(x) \
+	((x >> SND_RME_SPDIF_IF_SHIFT) & SND_RME_BINARY_MASK)
+#define SND_RME_SPDIF_FORMAT(x) \
+	((x >> SND_RME_SPDIF_FORMAT_SHIFT) & SND_RME_BINARY_MASK)
+
+static const u32 snd_rme_rate_table[] = {
+	32000, 44100, 48000, 50000,
+	64000, 88200, 96000, 100000,
+	128000, 176400, 192000, 200000,
+	256000,	352800, 384000, 400000,
+	512000, 705600, 768000, 800000
+};
+/* maximum number of items for AES and S/PDIF rates for above table */
+#define SND_RME_RATE_IDX_AES_SPDIF_NUM		12
+
+enum snd_rme_domain {
+	SND_RME_DOMAIN_SYSTEM,
+	SND_RME_DOMAIN_AES,
+	SND_RME_DOMAIN_SPDIF
+};
+
+enum snd_rme_clock_status {
+	SND_RME_CLOCK_NOLOCK,
+	SND_RME_CLOCK_LOCK,
+	SND_RME_CLOCK_SYNC
+};
+
+static int snd_rme_read_value(struct snd_usb_audio *chip,
+			      unsigned int item,
+			      u32 *value)
+{
+	struct usb_device *dev = chip->dev;
+	int err;
+
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
+			      item,
+			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      0, 0,
+			      value, sizeof(*value));
+	if (err < 0)
+		dev_err(&dev->dev,
+			"unable to issue vendor read request %d (ret = %d)",
+			item, err);
+	return err;
+}
+
+static int snd_rme_get_status1(struct snd_kcontrol *kcontrol,
+			       u32 *status1)
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_audio *chip = list->mixer->chip;
+	int err;
+
+	err = snd_usb_lock_shutdown(chip);
+	if (err < 0)
+		return err;
+	err = snd_rme_read_value(chip, SND_RME_GET_STATUS1, status1);
+	snd_usb_unlock_shutdown(chip);
+	return err;
+}
+
+static int snd_rme_rate_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	u32 status1;
+	u32 rate = 0;
+	int idx;
+	int err;
+
+	err = snd_rme_get_status1(kcontrol, &status1);
+	if (err < 0)
+		return err;
+	switch (kcontrol->private_value) {
+	case SND_RME_DOMAIN_SYSTEM:
+		idx = SND_RME_CLK_SYSTEM(status1);
+		if (idx < ARRAY_SIZE(snd_rme_rate_table))
+			rate = snd_rme_rate_table[idx];
+		break;
+	case SND_RME_DOMAIN_AES:
+		idx = SND_RME_CLK_AES(status1);
+		if (idx < SND_RME_RATE_IDX_AES_SPDIF_NUM)
+			rate = snd_rme_rate_table[idx];
+		break;
+	case SND_RME_DOMAIN_SPDIF:
+		idx = SND_RME_CLK_SPDIF(status1);
+		if (idx < SND_RME_RATE_IDX_AES_SPDIF_NUM)
+			rate = snd_rme_rate_table[idx];
+		break;
+	default:
+		return -EINVAL;
+	}
+	ucontrol->value.integer.value[0] = rate;
+	return 0;
+}
+
+static int snd_rme_sync_state_get(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	u32 status1;
+	int idx = SND_RME_CLOCK_NOLOCK;
+	int err;
+
+	err = snd_rme_get_status1(kcontrol, &status1);
+	if (err < 0)
+		return err;
+	switch (kcontrol->private_value) {
+	case SND_RME_DOMAIN_AES:  /* AES */
+		if (status1 & SND_RME_CLK_AES_SYNC)
+			idx = SND_RME_CLOCK_SYNC;
+		else if (status1 & SND_RME_CLK_AES_LOCK)
+			idx = SND_RME_CLOCK_LOCK;
+		break;
+	case SND_RME_DOMAIN_SPDIF:  /* SPDIF */
+		if (status1 & SND_RME_CLK_SPDIF_SYNC)
+			idx = SND_RME_CLOCK_SYNC;
+		else if (status1 & SND_RME_CLK_SPDIF_LOCK)
+			idx = SND_RME_CLOCK_LOCK;
+		break;
+	default:
+		return -EINVAL;
+	}
+	ucontrol->value.enumerated.item[0] = idx;
+	return 0;
+}
+
+static int snd_rme_spdif_if_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	u32 status1;
+	int err;
+
+	err = snd_rme_get_status1(kcontrol, &status1);
+	if (err < 0)
+		return err;
+	ucontrol->value.enumerated.item[0] = SND_RME_SPDIF_IF(status1);
+	return 0;
+}
+
+static int snd_rme_spdif_format_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	u32 status1;
+	int err;
+
+	err = snd_rme_get_status1(kcontrol, &status1);
+	if (err < 0)
+		return err;
+	ucontrol->value.enumerated.item[0] = SND_RME_SPDIF_FORMAT(status1);
+	return 0;
+}
+
+static int snd_rme_sync_source_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	u32 status1;
+	int err;
+
+	err = snd_rme_get_status1(kcontrol, &status1);
+	if (err < 0)
+		return err;
+	ucontrol->value.enumerated.item[0] = SND_RME_CLK_SYNC(status1);
+	return 0;
+}
+
+static int snd_rme_current_freq_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_audio *chip = list->mixer->chip;
+	u32 status1;
+	const u64 num = 104857600000000ULL;
+	u32 den;
+	unsigned int freq;
+	int err;
+
+	err = snd_usb_lock_shutdown(chip);
+	if (err < 0)
+		return err;
+	err = snd_rme_read_value(chip, SND_RME_GET_STATUS1, &status1);
+	if (err < 0)
+		goto end;
+	err = snd_rme_read_value(chip, SND_RME_GET_CURRENT_FREQ, &den);
+	if (err < 0)
+		goto end;
+	freq = (den == 0) ? 0 : div64_u64(num, den);
+	freq <<= SND_RME_CLK_FREQMUL(status1);
+	ucontrol->value.integer.value[0] = freq;
+
+end:
+	snd_usb_unlock_shutdown(chip);
+	return err;
+}
+
+static int snd_rme_rate_info(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	switch (kcontrol->private_value) {
+	case SND_RME_DOMAIN_SYSTEM:
+		uinfo->value.integer.min = 32000;
+		uinfo->value.integer.max = 800000;
+		break;
+	case SND_RME_DOMAIN_AES:
+	case SND_RME_DOMAIN_SPDIF:
+	default:
+		uinfo->value.integer.min = 0;
+		uinfo->value.integer.max = 200000;
+	}
+	uinfo->value.integer.step = 0;
+	return 0;
+}
+
+static int snd_rme_sync_state_info(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const sync_states[] = {
+		"No Lock", "Lock", "Sync"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1,
+				 ARRAY_SIZE(sync_states), sync_states);
+}
+
+static int snd_rme_spdif_if_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const spdif_if[] = {
+		"Coaxial", "Optical"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1,
+				 ARRAY_SIZE(spdif_if), spdif_if);
+}
+
+static int snd_rme_spdif_format_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const optical_type[] = {
+		"Consumer", "Professional"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1,
+				 ARRAY_SIZE(optical_type), optical_type);
+}
+
+static int snd_rme_sync_source_info(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const sync_sources[] = {
+		"Internal", "AES", "SPDIF", "Internal"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1,
+				 ARRAY_SIZE(sync_sources), sync_sources);
+}
+
+static struct snd_kcontrol_new snd_rme_controls[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "AES Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_rate_info,
+		.get = snd_rme_rate_get,
+		.private_value = SND_RME_DOMAIN_AES
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "AES Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_sync_state_get,
+		.private_value = SND_RME_DOMAIN_AES
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "SPDIF Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_rate_info,
+		.get = snd_rme_rate_get,
+		.private_value = SND_RME_DOMAIN_SPDIF
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "SPDIF Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_sync_state_get,
+		.private_value = SND_RME_DOMAIN_SPDIF
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "SPDIF Interface",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_spdif_if_info,
+		.get = snd_rme_spdif_if_get,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "SPDIF Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_spdif_format_info,
+		.get = snd_rme_spdif_format_get,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Sync Source",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_source_info,
+		.get = snd_rme_sync_source_get
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "System Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_rate_info,
+		.get = snd_rme_rate_get,
+		.private_value = SND_RME_DOMAIN_SYSTEM
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Current Frequency",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_rate_info,
+		.get = snd_rme_current_freq_get
+	}
+};
+
+static int snd_rme_controls_create(struct usb_mixer_interface *mixer)
+{
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(snd_rme_controls); ++i) {
+		err = add_single_ctl_with_resume(mixer, 0,
+						 NULL,
+						 &snd_rme_controls[i],
+						 NULL);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 {
 	int err = 0;
@@ -1908,8 +2447,20 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
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
+
+	case USB_ID(0x2a39, 0x3fd2): /* RME ADI-2 Pro */
+	case USB_ID(0x2a39, 0x3fd3): /* RME ADI-2 DAC */
+	case USB_ID(0x2a39, 0x3fd4): /* RME */
+		err = snd_rme_controls_create(mixer);
+		break;
 	}
 
 	return err;

