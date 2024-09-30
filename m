Return-Path: <stable+bounces-78274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0A198A76B
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 16:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBD01F22B72
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2CE1917E9;
	Mon, 30 Sep 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U1+YP8+X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212A1917C9;
	Mon, 30 Sep 2024 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707309; cv=none; b=sC0pmUUhokB7CDbzg4BegkwoPRUxKyUjDQXJmU/GNwh25F8dTqX/0mqs/+7VCWBjRTtyIDdauE2ppx4jwlXWWHX+E158+4vVhIMqZIQu45TeNGj3VLixKEBc0tORR6SZUZc8c/mhY9uRDzLcOwVbmz86tRk70Sw9lSBWLt02kK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707309; c=relaxed/simple;
	bh=u7LsXU7rIdxkIR1G5dQxxDnnaBU98R+F9wCaUBf0vVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psQxsa3dRn3bU2njnSW36Gvk1DO+Xwp/wVvMSZpPsOIQX3ixGdR2mHMExeziJ2y7ZiMP/v5slyEl5jlczm/J9X5ex3i+nZ23sNc2wCTjkV1m6FehbwXfRCIOwDZeMaOGnyTIC9rYUaPJgMGRIcqK+KDB0f5+Uy/fYdSItURA9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U1+YP8+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5298C4CEC7;
	Mon, 30 Sep 2024 14:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727707308;
	bh=u7LsXU7rIdxkIR1G5dQxxDnnaBU98R+F9wCaUBf0vVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1+YP8+XiIsTnL0BnPNJT945tVFKpJJD+2lwPaR2T6LJOXCum6iEhmW/cwnjHJBhx
	 pBPuobMRMdzgqGGjpmY4IQh55zMxb3CIeBvhgzWY42SerAZo7NnbJL9A4kT1sXsK1Y
	 o+16pljhZWot7ilvRcOkMazzeaUrcfJabmvO4XAA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.112
Date: Mon, 30 Sep 2024 16:41:34 +0200
Message-ID: <2024093033-vengeful-area-33f8@gregkh>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <2024093032-durable-dandelion-9d0a@gregkh>
References: <2024093032-durable-dandelion-9d0a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index d2ff3ff02625..bc0473d33c2f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 111
+SUBLEVEL = 112
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/loongarch/include/asm/hw_irq.h b/arch/loongarch/include/asm/hw_irq.h
index af4f4e8fbd85..8156ffb67415 100644
--- a/arch/loongarch/include/asm/hw_irq.h
+++ b/arch/loongarch/include/asm/hw_irq.h
@@ -9,6 +9,8 @@
 
 extern atomic_t irq_err_count;
 
+#define ARCH_IRQ_INIT_FLAGS	IRQ_NOPROBE
+
 /*
  * interrupt-retrigger: NOP for now. This may not be appropriate for all
  * machines, we'll see ...
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index 0524bf1169b7..4496649c9e68 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -122,9 +122,6 @@ void __init init_IRQ(void)
 		panic("IPI IRQ request failed\n");
 #endif
 
-	for (i = 0; i < NR_IRQS; i++)
-		irq_set_noprobe(i);
-
 	for_each_possible_cpu(i) {
 		page = alloc_pages_node(cpu_to_node(i), GFP_KERNEL, order);
 
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 353fabdfcbc5..2a3248194d50 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -193,11 +193,6 @@ asmlinkage void __init mmu_init(void)
 {
 	unsigned int kstart, ksize;
 
-	if (!memblock.reserved.cnt) {
-		pr_emerg("Error memory count\n");
-		machine_restart(NULL);
-	}
-
 	if ((u32) memblock.memory.regions[0].size < 0x400000) {
 		pr_emerg("Memory must be greater than 4MB\n");
 		machine_restart(NULL);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 9b039e9635e4..542b818c0d20 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -324,6 +324,7 @@ static void __init ms_hyperv_init_platform(void)
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
 		x86_platform.calibrate_tsc = hv_get_tsc_khz;
 		x86_platform.calibrate_cpu = hv_get_tsc_khz;
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 
 	if (ms_hyperv.priv_high & HV_ISOLATION) {
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 913287b9340c..ed861ef33f80 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -262,21 +262,17 @@ static void __init probe_page_size_mask(void)
 	}
 }
 
-#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
-			      .family  = 6,			\
-			      .model = _model,			\
-			    }
 /*
  * INVLPG may not properly flush Global entries
  * on these CPUs when PCIDs are enabled.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,    0),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0),
 	{}
 };
 
diff --git a/block/blk-core.c b/block/blk-core.c
index a4155f123ab3..94941e3ce219 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -49,6 +49,7 @@
 #include "blk-pm.h"
 #include "blk-cgroup.h"
 #include "blk-throttle.h"
+#include "blk-ioprio.h"
 
 struct dentry *blk_debugfs_root;
 
@@ -799,6 +800,14 @@ void submit_bio_noacct(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio_noacct);
 
+static void bio_set_ioprio(struct bio *bio)
+{
+	/* Nobody set ioprio so far? Initialize it based on task's nice value */
+	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
+		bio->bi_ioprio = get_current_ioprio();
+	blkcg_set_ioprio(bio);
+}
+
 /**
  * submit_bio - submit a bio to the block device layer for I/O
  * @bio: The &struct bio which describes the I/O
@@ -824,6 +833,7 @@ void submit_bio(struct bio *bio)
 		count_vm_events(PGPGOUT, bio_sectors(bio));
 	}
 
+	bio_set_ioprio(bio);
 	submit_bio_noacct(bio);
 }
 EXPORT_SYMBOL(submit_bio);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index daf0e4f3444e..542b28a2e6b0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -42,7 +42,6 @@
 #include "blk-stat.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
-#include "blk-ioprio.h"
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 
@@ -2949,14 +2948,6 @@ static bool blk_mq_can_use_cached_rq(struct request *rq, struct blk_plug *plug,
 	return true;
 }
 
-static void bio_set_ioprio(struct bio *bio)
-{
-	/* Nobody set ioprio so far? Initialize it based on task's nice value */
-	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
-		bio->bi_ioprio = get_current_ioprio();
-	blkcg_set_ioprio(bio);
-}
-
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -2980,7 +2971,6 @@ void blk_mq_submit_bio(struct bio *bio)
 	blk_status_t ret;
 
 	bio = blk_queue_bounce(bio, q);
-	bio_set_ioprio(bio);
 
 	if (plug) {
 		rq = rq_list_peek(&plug->cached_rq);
diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index be51bd00d2fd..55f640ef3fee 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1523,12 +1523,14 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 		line = &lr->lines[i];
 		desc = lr->lines[i].desc;
 		flags = gpio_v2_line_config_flags(lc, i);
-		gpio_v2_line_config_flags_to_desc_flags(flags, &desc->flags);
-		edflags = flags & GPIO_V2_LINE_EDGE_DETECTOR_FLAGS;
 		/*
-		 * Lines have to be requested explicitly for input
-		 * or output, else the line will be treated "as is".
+		 * Lines not explicitly reconfigured as input or output
+		 * are left unchanged.
 		 */
+		if (!(flags & GPIO_V2_LINE_DIRECTION_FLAGS))
+			continue;
+		gpio_v2_line_config_flags_to_desc_flags(flags, &desc->flags);
+		edflags = flags & GPIO_V2_LINE_EDGE_DETECTOR_FLAGS;
 		if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
 			int val = gpio_v2_line_config_output_value(lc, i);
 
@@ -1536,7 +1538,7 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 			ret = gpiod_direction_output(desc, val);
 			if (ret)
 				return ret;
-		} else if (flags & GPIO_V2_LINE_FLAG_INPUT) {
+		} else {
 			ret = gpiod_direction_input(desc);
 			if (ret)
 				return ret;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9d8c78312403..a0c1dabd2939 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -5,6 +5,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/nospec.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/device.h>
@@ -146,7 +147,7 @@ struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc,
 	if (hwnum >= gdev->ngpio)
 		return ERR_PTR(-EINVAL);
 
-	return &gdev->descs[hwnum];
+	return &gdev->descs[array_index_nospec(hwnum, gdev->ngpio)];
 }
 EXPORT_SYMBOL_GPL(gpiochip_get_desc);
 
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
index 451746ebbe71..89f3d6aa72b0 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -163,6 +163,7 @@ static int komeda_crtc_normalize_zpos(struct drm_crtc *crtc,
 	struct drm_plane *plane;
 	struct list_head zorder_list;
 	int order = 0, err;
+	u32 slave_zpos = 0;
 
 	DRM_DEBUG_ATOMIC("[CRTC:%d:%s] calculating normalized zpos values\n",
 			 crtc->base.id, crtc->name);
@@ -202,10 +203,13 @@ static int komeda_crtc_normalize_zpos(struct drm_crtc *crtc,
 				 plane_st->zpos, plane_st->normalized_zpos);
 
 		/* calculate max slave zorder */
-		if (has_bit(drm_plane_index(plane), kcrtc->slave_planes))
+		if (has_bit(drm_plane_index(plane), kcrtc->slave_planes)) {
+			slave_zpos = plane_st->normalized_zpos;
+			if (to_kplane_st(plane_st)->layer_split)
+				slave_zpos++;
 			kcrtc_st->max_slave_zorder =
-				max(plane_st->normalized_zpos,
-				    kcrtc_st->max_slave_zorder);
+				max(slave_zpos, kcrtc_st->max_slave_zorder);
+		}
 	}
 
 	crtc_st->zpos_changed = true;
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index b4d65916b3c0..d893cfd1cb82 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -369,7 +369,7 @@ static const struct ec_board_info board_info_strix_b550_i_gaming = {
 
 static const struct ec_board_info board_info_strix_x570_e_gaming = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_T_SENSOR |
 		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 		SENSOR_IN_CPU_CORE,
 	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index a9bafa96e2f9..6fecfe4cd080 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -744,6 +744,7 @@ static void mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
 
 	mcp251xfd_chip_interrupts_disable(priv);
 	mcp251xfd_chip_rx_int_disable(priv);
+	mcp251xfd_timestamp_stop(priv);
 	mcp251xfd_chip_sleep(priv);
 }
 
@@ -763,6 +764,8 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 	if (err)
 		goto out_chip_stop;
 
+	mcp251xfd_timestamp_start(priv);
+
 	err = mcp251xfd_set_bittiming(priv);
 	if (err)
 		goto out_chip_stop;
@@ -791,7 +794,7 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 
 	return 0;
 
- out_chip_stop:
+out_chip_stop:
 	mcp251xfd_dump(priv);
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
 
@@ -1576,7 +1579,7 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
 		handled = IRQ_HANDLED;
 	} while (1);
 
- out_fail:
+out_fail:
 	can_rx_offload_threaded_irq_finish(&priv->offload);
 
 	netdev_err(priv->ndev, "IRQ handler returned %d (intf=0x%08x).\n",
@@ -1610,11 +1613,12 @@ static int mcp251xfd_open(struct net_device *ndev)
 	if (err)
 		goto out_mcp251xfd_ring_free;
 
+	mcp251xfd_timestamp_init(priv);
+
 	err = mcp251xfd_chip_start(priv);
 	if (err)
 		goto out_transceiver_disable;
 
-	mcp251xfd_timestamp_init(priv);
 	clear_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
 	can_rx_offload_enable(&priv->offload);
 
@@ -1641,22 +1645,21 @@ static int mcp251xfd_open(struct net_device *ndev)
 
 	return 0;
 
- out_free_irq:
+out_free_irq:
 	free_irq(spi->irq, priv);
- out_destroy_workqueue:
+out_destroy_workqueue:
 	destroy_workqueue(priv->wq);
- out_can_rx_offload_disable:
+out_can_rx_offload_disable:
 	can_rx_offload_disable(&priv->offload);
 	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
-	mcp251xfd_timestamp_stop(priv);
- out_transceiver_disable:
+out_transceiver_disable:
 	mcp251xfd_transceiver_disable(priv);
- out_mcp251xfd_ring_free:
+out_mcp251xfd_ring_free:
 	mcp251xfd_ring_free(priv);
- out_pm_runtime_put:
+out_pm_runtime_put:
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
 	pm_runtime_put(ndev->dev.parent);
- out_close_candev:
+out_close_candev:
 	close_candev(ndev);
 
 	return err;
@@ -1674,7 +1677,6 @@ static int mcp251xfd_stop(struct net_device *ndev)
 	free_irq(ndev->irq, priv);
 	destroy_workqueue(priv->wq);
 	can_rx_offload_disable(&priv->offload);
-	mcp251xfd_timestamp_stop(priv);
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
 	mcp251xfd_transceiver_disable(priv);
 	mcp251xfd_ring_free(priv);
@@ -1820,9 +1822,9 @@ mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
 	*effective_speed_hz_slow = xfer[0].effective_speed_hz;
 	*effective_speed_hz_fast = xfer[1].effective_speed_hz;
 
- out_kfree_buf_tx:
+out_kfree_buf_tx:
 	kfree(buf_tx);
- out_kfree_buf_rx:
+out_kfree_buf_rx:
 	kfree(buf_rx);
 
 	return err;
@@ -1936,13 +1938,13 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
 
 	return 0;
 
- out_unregister_candev:
+out_unregister_candev:
 	unregister_candev(ndev);
- out_chip_sleep:
+out_chip_sleep:
 	mcp251xfd_chip_sleep(priv);
- out_runtime_disable:
+out_runtime_disable:
 	pm_runtime_disable(ndev->dev.parent);
- out_runtime_put_noidle:
+out_runtime_put_noidle:
 	pm_runtime_put_noidle(ndev->dev.parent);
 	mcp251xfd_clks_and_vdd_disable(priv);
 
@@ -2162,9 +2164,9 @@ static int mcp251xfd_probe(struct spi_device *spi)
 
 	return 0;
 
- out_can_rx_offload_del:
+out_can_rx_offload_del:
 	can_rx_offload_del(&priv->offload);
- out_free_candev:
+out_free_candev:
 	spi->max_speed_hz = priv->spi_max_speed_hz_orig;
 
 	free_candev(ndev);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c
index 004eaf96262b..050321345304 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c
@@ -94,7 +94,7 @@ static void mcp251xfd_dump_registers(const struct mcp251xfd_priv *priv,
 		kfree(buf);
 	}
 
- out:
+out:
 	mcp251xfd_dump_header(iter, MCP251XFD_DUMP_OBJECT_TYPE_REG, reg);
 }
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 92b7bc7f14b9..65150e762007 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -397,7 +397,7 @@ mcp251xfd_regmap_crc_read(void *context,
 
 		return err;
 	}
- out:
+out:
 	memcpy(val_buf, buf_rx->data, val_len);
 
 	return 0;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index 0fde8154a649..a894cb1fb9bf 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -280,7 +280,7 @@ int mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 	const struct mcp251xfd_rx_ring *rx_ring;
 	u16 base = 0, ram_used;
 	u8 fifo_nr = 1;
-	int i;
+	int err = 0, i;
 
 	netdev_reset_queue(priv->ndev);
 
@@ -376,10 +376,18 @@ int mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 		netdev_err(priv->ndev,
 			   "Error during ring configuration, using more RAM (%u bytes) than available (%u bytes).\n",
 			   ram_used, MCP251XFD_RAM_SIZE);
-		return -ENOMEM;
+		err = -ENOMEM;
 	}
 
-	return 0;
+	if (priv->tx_obj_num_coalesce_irq &&
+	    priv->tx_obj_num_coalesce_irq * 2 != priv->tx->obj_num) {
+		netdev_err(priv->ndev,
+			   "Error during ring configuration, number of TEF coalescing buffers (%u) must be half of TEF buffers (%u).\n",
+			   priv->tx_obj_num_coalesce_irq, priv->tx->obj_num);
+		err = -EINVAL;
+	}
+
+	return err;
 }
 
 void mcp251xfd_ring_free(struct mcp251xfd_priv *priv)
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index 8f39730f3122..d4df5ccb60e3 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -219,7 +219,7 @@ int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 		total_frame_len += frame_len;
 	}
 
- out_netif_wake_queue:
+out_netif_wake_queue:
 	len = i;	/* number of handled goods TEFs */
 	if (len) {
 		struct mcp251xfd_tef_ring *ring = priv->tef;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
index 1db99aabe85c..202ca0d24d03 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
@@ -48,9 +48,12 @@ void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv)
 	cc->shift = 1;
 	cc->mult = clocksource_hz2mult(priv->can.clock.freq, cc->shift);
 
-	timecounter_init(&priv->tc, &priv->cc, ktime_get_real_ns());
-
 	INIT_DELAYED_WORK(&priv->timestamp, mcp251xfd_timestamp_work);
+}
+
+void mcp251xfd_timestamp_start(struct mcp251xfd_priv *priv)
+{
+	timecounter_init(&priv->tc, &priv->cc, ktime_get_real_ns());
 	schedule_delayed_work(&priv->timestamp,
 			      MCP251XFD_TIMESTAMP_WORK_DELAY_SEC * HZ);
 }
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index c07300443c6a..0711a2f3c037 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -939,6 +939,7 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv);
 int mcp251xfd_handle_rxif(struct mcp251xfd_priv *priv);
 int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv);
+void mcp251xfd_timestamp_start(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv);
 
 void mcp251xfd_tx_obj_write_sync(struct work_struct *work);
diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index a03879a27b04..7adc46aa75e6 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -566,7 +566,7 @@ static bool ftgmac100_rx_packet(struct ftgmac100 *priv, int *processed)
 	(*processed)++;
 	return true;
 
- drop:
+drop:
 	/* Clean rxdes0 (which resets own bit) */
 	rxdes->rxdes0 = cpu_to_le32(status & priv->rxdes0_edorr_mask);
 	priv->rx_pointer = ftgmac100_next_rx_pointer(priv, pointer);
@@ -650,6 +650,11 @@ static bool ftgmac100_tx_complete_packet(struct ftgmac100 *priv)
 	ftgmac100_free_tx_packet(priv, pointer, skb, txdes, ctl_stat);
 	txdes->txdes0 = cpu_to_le32(ctl_stat & priv->txdes0_edotr_mask);
 
+	/* Ensure the descriptor config is visible before setting the tx
+	 * pointer.
+	 */
+	smp_wmb();
+
 	priv->tx_clean_pointer = ftgmac100_next_tx_pointer(priv, pointer);
 
 	return true;
@@ -803,6 +808,11 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	dma_wmb();
 	first->txdes0 = cpu_to_le32(f_ctl_stat);
 
+	/* Ensure the descriptor config is visible before setting the tx
+	 * pointer.
+	 */
+	smp_wmb();
+
 	/* Update next TX pointer */
 	priv->tx_pointer = pointer;
 
@@ -823,7 +833,7 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 
 	return NETDEV_TX_OK;
 
- dma_err:
+dma_err:
 	if (net_ratelimit())
 		netdev_err(netdev, "map tx fragment failed\n");
 
@@ -845,7 +855,7 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	 * last fragment, so we know ftgmac100_free_tx_packet()
 	 * hasn't freed the skb yet.
 	 */
- drop:
+drop:
 	/* Drop the packet */
 	dev_kfree_skb_any(skb);
 	netdev->stats.tx_dropped++;
@@ -1338,7 +1348,7 @@ static void ftgmac100_reset(struct ftgmac100 *priv)
 	ftgmac100_init_all(priv, true);
 
 	netdev_dbg(netdev, "Reset done !\n");
- bail:
+bail:
 	if (priv->mii_bus)
 		mutex_unlock(&priv->mii_bus->mdio_lock);
 	if (netdev->phydev)
@@ -1537,15 +1547,15 @@ static int ftgmac100_open(struct net_device *netdev)
 
 	return 0;
 
- err_ncsi:
+err_ncsi:
 	napi_disable(&priv->napi);
 	netif_stop_queue(netdev);
- err_alloc:
+err_alloc:
 	ftgmac100_free_buffers(priv);
 	free_irq(netdev->irq, netdev);
- err_irq:
+err_irq:
 	netif_napi_del(&priv->napi);
- err_hw:
+err_hw:
 	iowrite32(0, priv->base + FTGMAC100_OFFSET_IER);
 	ftgmac100_free_rings(priv);
 	return err;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 3b0ed1cdfa11..7fadaec777ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3131,7 +3131,7 @@ void iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
 {
 	int ret __maybe_unused = 0;
 
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status))
+	if (!iwl_trans_fw_running(fwrt->trans))
 		return;
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 70022cadee35..ad29663a356b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1472,8 +1472,8 @@ static inline void iwl_trans_fw_error(struct iwl_trans *trans, bool sync)
 
 	/* prevent double restarts due to the same erroneous FW */
 	if (!test_and_set_bit(STATUS_FW_ERROR, &trans->status)) {
-		iwl_op_mode_nic_error(trans->op_mode, sync);
 		trans->state = IWL_TRANS_NO_FW;
+		iwl_op_mode_nic_error(trans->op_mode, sync);
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4e8bdd3d701b..bd4301857ba8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4800,6 +4800,10 @@ static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
 	int i;
 
 	if (!iwl_mvm_has_new_tx_api(mvm)) {
+		/* we can't ask the firmware anything if it is dead */
+		if (test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+			     &mvm->status))
+			return;
 		if (drop) {
 			mutex_lock(&mvm->mutex);
 			iwl_mvm_flush_tx_path(mvm,
@@ -4881,8 +4885,11 @@ static void iwl_mvm_mac_flush(struct ieee80211_hw *hw,
 
 	/* this can take a while, and we may need/want other operations
 	 * to succeed while doing this, so do it without the mutex held
+	 * If the firmware is dead, this can't work...
 	 */
-	if (!drop && !iwl_mvm_has_new_tx_api(mvm))
+	if (!drop && !iwl_mvm_has_new_tx_api(mvm) &&
+	    !test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+		      &mvm->status))
 		iwl_trans_wait_tx_queues_empty(mvm->trans, msk);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 88b6d4e566c4..0a11ee347bf3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1366,6 +1366,8 @@ void iwl_mvm_stop_device(struct iwl_mvm *mvm)
 
 	clear_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
 
+	iwl_mvm_pause_tcm(mvm, false);
+
 	iwl_fw_dbg_stop_sync(&mvm->fwrt);
 	iwl_trans_stop_device(mvm->trans);
 	iwl_free_fw_paging(&mvm->fwrt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index b58441c2af73..20c5cc72e426 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -824,8 +824,8 @@ static inline bool iwl_mvm_scan_fits(struct iwl_mvm *mvm, int n_ssids,
 	return ((n_ssids <= PROBE_OPTION_MAX) &&
 		(n_channels <= mvm->fw->ucode_capa.n_scan_channels) &
 		(ies->common_ie_len +
-		 ies->len[NL80211_BAND_2GHZ] +
-		 ies->len[NL80211_BAND_5GHZ] <=
+		 ies->len[NL80211_BAND_2GHZ] + ies->len[NL80211_BAND_5GHZ] +
+		 ies->len[NL80211_BAND_6GHZ] <=
 		 iwl_mvm_max_scan_ie_fw_cmd_room(mvm)));
 }
 
@@ -2935,18 +2935,16 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 		params.n_channels = j;
 	}
 
-	if (non_psc_included &&
-	    !iwl_mvm_scan_fits(mvm, req->n_ssids, ies, params.n_channels)) {
-		kfree(params.channels);
-		return -ENOBUFS;
+	if (!iwl_mvm_scan_fits(mvm, req->n_ssids, ies, params.n_channels)) {
+		ret = -ENOBUFS;
+		goto out;
 	}
 
 	uid = iwl_mvm_build_scan_cmd(mvm, vif, &hcmd, &params, type);
-
-	if (non_psc_included)
-		kfree(params.channels);
-	if (uid < 0)
-		return uid;
+	if (uid < 0) {
+		ret = uid;
+		goto out;
+	}
 
 	ret = iwl_mvm_send_cmd(mvm, &hcmd);
 	if (!ret) {
@@ -2963,6 +2961,9 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 		mvm->sched_scan_pass_all = SCHED_SCAN_PASS_ALL_DISABLED;
 	}
 
+out:
+	if (non_psc_included)
+		kfree(params.channels);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 75fd386b048e..35c60faf8e8f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -68,7 +68,8 @@ iwl_pcie_ctxt_info_dbg_enable(struct iwl_trans *trans,
 		}
 		break;
 	default:
-		IWL_ERR(trans, "WRT: Invalid buffer destination\n");
+		IWL_DEBUG_FW(trans, "WRT: Invalid buffer destination (%d)\n",
+			     le32_to_cpu(fw_mon_cfg->buf_location));
 	}
 out:
 	if (dbg_flags)
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index ff3b6a8a0b17..333f9d70c7f4 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1420,8 +1420,11 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 
 	/* We will handle a range of GPIO pins */
 	for (i = 0; i < gpio_banks; i++)
-		if (gpio_chips[i])
+		if (gpio_chips[i]) {
 			pinctrl_add_gpio_range(info->pctl, &gpio_chips[i]->range);
+			gpiochip_add_pin_range(&gpio_chips[i]->chip, dev_name(info->pctl->dev), 0,
+				gpio_chips[i]->range.pin_base, gpio_chips[i]->range.npins);
+		}
 
 	dev_info(&pdev->dev, "initialized AT91 pinctrl driver\n");
 
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 65adb4cbaaf8..e46a7641e42f 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -136,12 +136,12 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
 
 /* List of verified CPUs. */
 static const struct x86_cpu_id pl4_support_ids[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_TIGERLAKE_L, X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE, X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_L, X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_N, X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE, X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE_P, X86_FEATURE_ANY },
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
 	{}
 };
 
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 2373dad01603..fc300febe914 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -5409,7 +5409,7 @@ lpfc_get_cgnbuf_info(struct bsg_job *job)
 	struct get_cgnbuf_info_req *cgnbuf_req;
 	struct lpfc_cgn_info *cp;
 	uint8_t *cgn_buff;
-	int size, cinfosz;
+	size_t size, cinfosz;
 	int  rc = 0;
 
 	if (job->request_len < sizeof(struct fc_bsg_request) +
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 147199002df1..a9921dcd6b79 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -482,6 +482,7 @@ static const struct of_device_id bcm63xx_spi_of_match[] = {
 	{ .compatible = "brcm,bcm6358-spi", .data = &bcm6358_spi_reg_offsets },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, bcm63xx_spi_of_match);
 
 static int bcm63xx_spi_probe(struct platform_device *pdev)
 {
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 477c3578e7d9..81a3cf925345 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -694,6 +694,7 @@ static struct class *spidev_class;
 static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = "bh2228fv" },
 	{ .name = "dh2228fv" },
+	{ .name = "jg10309-01" },
 	{ .name = "ltc2488" },
 	{ .name = "sx1301" },
 	{ .name = "bk4" },
@@ -722,6 +723,7 @@ static int spidev_of_check(struct device *dev)
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
+	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
 	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 311007b1d904..c2e666e82857 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -754,7 +754,7 @@ static struct urb *usbtmc_create_urb(void)
 	if (!urb)
 		return NULL;
 
-	dmabuf = kmalloc(bufsize, GFP_KERNEL);
+	dmabuf = kzalloc(bufsize, GFP_KERNEL);
 	if (!dmabuf) {
 		usb_free_urb(urb);
 		return NULL;
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index 8949c1891164..05ca236023bb 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -118,6 +118,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(SMART_VENDOR_ID, SMART_PRODUCT_ID) },
 	{ USB_DEVICE(AT_VENDOR_ID, AT_VTKIT3_PRODUCT_ID) },
 	{ USB_DEVICE(IBM_VENDOR_ID, IBM_PRODUCT_ID) },
+	{ USB_DEVICE(MACROSILICON_VENDOR_ID, MACROSILICON_MS3020_PRODUCT_ID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index 732f9b13ad5d..d60eda7f6eda 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -171,3 +171,7 @@
 /* Allied Telesis VT-Kit3 */
 #define AT_VENDOR_ID		0x0caa
 #define AT_VTKIT3_PRODUCT_ID	0x3001
+
+/* Macrosilicon MS3020 */
+#define MACROSILICON_VENDOR_ID		0x345f
+#define MACROSILICON_MS3020_PRODUCT_ID	0x3020
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 4cbf38616620..a47c8b450996 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -384,17 +384,19 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 
 	/*
 	 * But we also want to reserve enough space so we can do the fallback
-	 * global reserve for an unlink, which is an additional 5 items (see the
-	 * comment in __unlink_start_trans for what we're modifying.)
+	 * global reserve for an unlink, which is an additional
+	 * BTRFS_UNLINK_METADATA_UNITS items.
 	 *
 	 * But we also need space for the delayed ref updates from the unlink,
-	 * so its 10, 5 for the actual operation, and 5 for the delayed ref
-	 * updates.
+	 * so add BTRFS_UNLINK_METADATA_UNITS units for delayed refs, one for
+	 * each unlink metadata item.
 	 */
-	min_items += 10;
+	min_items += BTRFS_UNLINK_METADATA_UNITS;
 
 	num_bytes = max_t(u64, num_bytes,
-			  btrfs_calc_insert_metadata_size(fs_info, min_items));
+			  btrfs_calc_insert_metadata_size(fs_info, min_items) +
+			  btrfs_calc_delayed_ref_bytes(fs_info,
+					       BTRFS_UNLINK_METADATA_UNITS));
 
 	spin_lock(&sinfo->lock);
 	spin_lock(&block_rsv->lock);
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index df87c4949d06..fd8bfaf26da5 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -50,6 +50,18 @@ struct btrfs_block_rsv {
 	u64 qgroup_rsv_reserved;
 };
 
+/*
+ * Number of metadata items necessary for an unlink operation:
+ *
+ * 1 for the possible orphan item
+ * 1 for the dir item
+ * 1 for the dir index
+ * 1 for the inode ref
+ * 1 for the inode
+ * 1 for the parent inode
+ */
+#define BTRFS_UNLINK_METADATA_UNITS		6
+
 void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, enum btrfs_rsv_type type);
 void btrfs_init_root_block_rsv(struct btrfs_root *root);
 struct btrfs_block_rsv *btrfs_alloc_block_rsv(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 712a6315e956..d325bf294867 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -253,6 +253,27 @@ extern struct kmem_cache *btrfs_delayed_extent_op_cachep;
 int __init btrfs_delayed_ref_init(void);
 void __cold btrfs_delayed_ref_exit(void);
 
+static inline u64 btrfs_calc_delayed_ref_bytes(struct btrfs_fs_info *fs_info,
+					       int num_delayed_refs)
+{
+	u64 num_bytes;
+
+	num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_delayed_refs);
+
+	/*
+	 * We have to check the mount option here because we could be enabling
+	 * the free space tree for the first time and don't have the compat_ro
+	 * option set yet.
+	 *
+	 * We need extra reservations if we have the free space tree because
+	 * we'll have to modify that tree as well.
+	 */
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
+		num_bytes *= 2;
+
+	return num_bytes;
+}
+
 static inline void btrfs_init_generic_ref(struct btrfs_ref *generic_ref,
 				int action, u64 bytenr, u64 len, u64 parent)
 {
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 55699c573541..3ba40f16ef05 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1066,13 +1066,13 @@ ssize_t ocfs2_listxattr(struct dentry *dentry,
 	return i_ret + b_ret;
 }
 
-static int ocfs2_xattr_find_entry(int name_index,
+static int ocfs2_xattr_find_entry(struct inode *inode, int name_index,
 				  const char *name,
 				  struct ocfs2_xattr_search *xs)
 {
 	struct ocfs2_xattr_entry *entry;
 	size_t name_len;
-	int i, cmp = 1;
+	int i, name_offset, cmp = 1;
 
 	if (name == NULL)
 		return -EINVAL;
@@ -1080,13 +1080,22 @@ static int ocfs2_xattr_find_entry(int name_index,
 	name_len = strlen(name);
 	entry = xs->here;
 	for (i = 0; i < le16_to_cpu(xs->header->xh_count); i++) {
+		if ((void *)entry >= xs->end) {
+			ocfs2_error(inode->i_sb, "corrupted xattr entries");
+			return -EFSCORRUPTED;
+		}
 		cmp = name_index - ocfs2_xattr_get_type(entry);
 		if (!cmp)
 			cmp = name_len - entry->xe_name_len;
-		if (!cmp)
-			cmp = memcmp(name, (xs->base +
-				     le16_to_cpu(entry->xe_name_offset)),
-				     name_len);
+		if (!cmp) {
+			name_offset = le16_to_cpu(entry->xe_name_offset);
+			if ((xs->base + name_offset + name_len) > xs->end) {
+				ocfs2_error(inode->i_sb,
+					    "corrupted xattr entries");
+				return -EFSCORRUPTED;
+			}
+			cmp = memcmp(name, (xs->base + name_offset), name_len);
+		}
 		if (cmp == 0)
 			break;
 		entry += 1;
@@ -1170,7 +1179,7 @@ static int ocfs2_xattr_ibody_get(struct inode *inode,
 	xs->base = (void *)xs->header;
 	xs->here = xs->header->xh_entries;
 
-	ret = ocfs2_xattr_find_entry(name_index, name, xs);
+	ret = ocfs2_xattr_find_entry(inode, name_index, name, xs);
 	if (ret)
 		return ret;
 	size = le64_to_cpu(xs->here->xe_value_size);
@@ -2702,7 +2711,7 @@ static int ocfs2_xattr_ibody_find(struct inode *inode,
 
 	/* Find the named attribute. */
 	if (oi->ip_dyn_features & OCFS2_INLINE_XATTR_FL) {
-		ret = ocfs2_xattr_find_entry(name_index, name, xs);
+		ret = ocfs2_xattr_find_entry(inode, name_index, name, xs);
 		if (ret && ret != -ENODATA)
 			return ret;
 		xs->not_found = ret;
@@ -2837,7 +2846,7 @@ static int ocfs2_xattr_block_find(struct inode *inode,
 		xs->end = (void *)(blk_bh->b_data) + blk_bh->b_size;
 		xs->here = xs->header->xh_entries;
 
-		ret = ocfs2_xattr_find_entry(name_index, name, xs);
+		ret = ocfs2_xattr_find_entry(inode, name_index, name, xs);
 	} else
 		ret = ocfs2_xattr_index_block_find(inode, blk_bh,
 						   name_index,
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 21b344762d0f..87ce71b39b77 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -673,6 +673,19 @@ allocate_buffers(struct TCP_Server_Info *server)
 static bool
 server_unresponsive(struct TCP_Server_Info *server)
 {
+	/*
+	 * If we're in the process of mounting a share or reconnecting a session
+	 * and the server abruptly shut down (e.g. socket wasn't closed, packet
+	 * had been ACK'ed but no SMB response), don't wait longer than 20s to
+	 * negotiate protocol.
+	 */
+	spin_lock(&server->srv_lock);
+	if (server->tcpStatus == CifsInNegotiate &&
+	    time_after(jiffies, server->lstrp + 20 * HZ)) {
+		spin_unlock(&server->srv_lock);
+		cifs_reconnect(server, false);
+		return true;
+	}
 	/*
 	 * We need to wait 3 echo intervals to make sure we handle such
 	 * situations right:
@@ -684,7 +697,6 @@ server_unresponsive(struct TCP_Server_Info *server)
 	 * 65s kernel_recvmsg times out, and we see that we haven't gotten
 	 *     a response in >60s.
 	 */
-	spin_lock(&server->srv_lock);
 	if ((server->tcpStatus == CifsGood ||
 	    server->tcpStatus == CifsNeedNegotiate) &&
 	    (!server->ops->can_echo || server->ops->can_echo(server)) &&
diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index bb0c700afe3c..bf47efe08a58 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -415,10 +415,12 @@ xfs_freesp_init_recs(
 		ASSERT(start >= mp->m_ag_prealloc_blocks);
 		if (start != mp->m_ag_prealloc_blocks) {
 			/*
-			 * Modify first record to pad stripe align of log
+			 * Modify first record to pad stripe align of log and
+			 * bump the record count.
 			 */
 			arec->ar_blockcount = cpu_to_be32(start -
 						mp->m_ag_prealloc_blocks);
+			be16_add_cpu(&block->bb_numrecs, 1);
 			nrec = arec + 1;
 
 			/*
@@ -429,7 +431,6 @@ xfs_freesp_init_recs(
 					be32_to_cpu(arec->ar_startblock) +
 					be32_to_cpu(arec->ar_blockcount));
 			arec = nrec;
-			be16_add_cpu(&block->bb_numrecs, 1);
 		}
 		/*
 		 * Change record start to after the internal log
@@ -438,15 +439,13 @@ xfs_freesp_init_recs(
 	}
 
 	/*
-	 * Calculate the record block count and check for the case where
-	 * the log might have consumed all available space in the AG. If
-	 * so, reset the record count to 0 to avoid exposure of an invalid
-	 * record start block.
+	 * Calculate the block count of this record; if it is nonzero,
+	 * increment the record count.
 	 */
 	arec->ar_blockcount = cpu_to_be32(id->agsize -
 					  be32_to_cpu(arec->ar_startblock));
-	if (!arec->ar_blockcount)
-		block->bb_numrecs = 0;
+	if (arec->ar_blockcount)
+		be16_add_cpu(&block->bb_numrecs, 1);
 }
 
 /*
@@ -458,7 +457,7 @@ xfs_bnoroot_init(
 	struct xfs_buf		*bp,
 	struct aghdr_init_data	*id)
 {
-	xfs_btree_init_block(mp, bp, XFS_BTNUM_BNO, 0, 1, id->agno);
+	xfs_btree_init_block(mp, bp, XFS_BTNUM_BNO, 0, 0, id->agno);
 	xfs_freesp_init_recs(mp, bp, id);
 }
 
@@ -468,7 +467,7 @@ xfs_cntroot_init(
 	struct xfs_buf		*bp,
 	struct aghdr_init_data	*id)
 {
-	xfs_btree_init_block(mp, bp, XFS_BTNUM_CNT, 0, 1, id->agno);
+	xfs_btree_init_block(mp, bp, XFS_BTNUM_CNT, 0, 0, id->agno);
 	xfs_freesp_init_recs(mp, bp, id);
 }
 
diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index de79f5d07f65..8bb024b06b95 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -3164,10 +3164,13 @@ xfs_alloc_vextent(
 	xfs_alloctype_t		type;	/* input allocation type */
 	int			bump_rotor = 0;
 	xfs_agnumber_t		rotorstep = xfs_rotorstep; /* inode32 agf stepper */
+	xfs_agnumber_t		minimum_agno = 0;
 
 	mp = args->mp;
 	type = args->otype = args->type;
 	args->agbno = NULLAGBLOCK;
+	if (args->tp->t_firstblock != NULLFSBLOCK)
+		minimum_agno = XFS_FSB_TO_AGNO(mp, args->tp->t_firstblock);
 	/*
 	 * Just fix this up, for the case where the last a.g. is shorter
 	 * (or there's only one a.g.) and the caller couldn't easily figure
@@ -3201,6 +3204,13 @@ xfs_alloc_vextent(
 		 */
 		args->agno = XFS_FSB_TO_AGNO(mp, args->fsbno);
 		args->pag = xfs_perag_get(mp, args->agno);
+
+		if (minimum_agno > args->agno) {
+			trace_xfs_alloc_vextent_skip_deadlock(args);
+			error = 0;
+			break;
+		}
+
 		error = xfs_alloc_fix_freelist(args, 0);
 		if (error) {
 			trace_xfs_alloc_vextent_nofix(args);
@@ -3232,6 +3242,8 @@ xfs_alloc_vextent(
 	case XFS_ALLOCTYPE_FIRST_AG:
 		/*
 		 * Rotate through the allocation groups looking for a winner.
+		 * If we are blocking, we must obey minimum_agno contraints for
+		 * avoiding ABBA deadlocks on AGF locking.
 		 */
 		if (type == XFS_ALLOCTYPE_FIRST_AG) {
 			/*
@@ -3239,7 +3251,7 @@ xfs_alloc_vextent(
 			 */
 			args->agno = XFS_FSB_TO_AGNO(mp, args->fsbno);
 			args->type = XFS_ALLOCTYPE_THIS_AG;
-			sagno = 0;
+			sagno = minimum_agno;
 			flags = 0;
 		} else {
 			/*
@@ -3248,6 +3260,7 @@ xfs_alloc_vextent(
 			args->agno = sagno = XFS_FSB_TO_AGNO(mp, args->fsbno);
 			flags = XFS_ALLOC_FLAG_TRYLOCK;
 		}
+
 		/*
 		 * Loop over allocation groups twice; first time with
 		 * trylock set, second time without.
@@ -3276,19 +3289,21 @@ xfs_alloc_vextent(
 			if (args->agno == sagno &&
 			    type == XFS_ALLOCTYPE_START_BNO)
 				args->type = XFS_ALLOCTYPE_THIS_AG;
+
 			/*
-			* For the first allocation, we can try any AG to get
-			* space.  However, if we already have allocated a
-			* block, we don't want to try AGs whose number is below
-			* sagno. Otherwise, we may end up with out-of-order
-			* locking of AGF, which might cause deadlock.
-			*/
+			 * If we are try-locking, we can't deadlock on AGF
+			 * locks, so we can wrap all the way back to the first
+			 * AG. Otherwise, wrap back to the start AG so we can't
+			 * deadlock, and let the end of scan handler decide what
+			 * to do next.
+			 */
 			if (++(args->agno) == mp->m_sb.sb_agcount) {
-				if (args->tp->t_firstblock != NULLFSBLOCK)
-					args->agno = sagno;
-				else
+				if (flags & XFS_ALLOC_FLAG_TRYLOCK)
 					args->agno = 0;
+				else
+					args->agno = sagno;
 			}
+
 			/*
 			 * Reached the starting a.g., must either be done
 			 * or switch to non-trylock mode.
@@ -3300,7 +3315,14 @@ xfs_alloc_vextent(
 					break;
 				}
 
+				/*
+				 * Blocking pass next, so we must obey minimum
+				 * agno constraints to avoid ABBA AGF deadlocks.
+				 */
 				flags = 0;
+				if (minimum_agno > sagno)
+					sagno = minimum_agno;
+
 				if (type == XFS_ALLOCTYPE_START_BNO) {
 					args->agbno = XFS_FSB_TO_AGBNO(mp,
 						args->fsbno);
@@ -3322,9 +3344,9 @@ xfs_alloc_vextent(
 		ASSERT(0);
 		/* NOTREACHED */
 	}
-	if (args->agbno == NULLAGBLOCK)
+	if (args->agbno == NULLAGBLOCK) {
 		args->fsbno = NULLFSBLOCK;
-	else {
+	} else {
 		args->fsbno = XFS_AGB_TO_FSB(mp, args->agno, args->agbno);
 #ifdef DEBUG
 		ASSERT(args->len >= args->minlen);
@@ -3335,6 +3357,29 @@ xfs_alloc_vextent(
 #endif
 
 	}
+
+	/*
+	 * We end up here with a locked AGF. If we failed, the caller is likely
+	 * going to try to allocate again with different parameters, and that
+	 * can widen the AGs that are searched for free space. If we have to do
+	 * BMBT block allocation, we have to do a new allocation.
+	 *
+	 * Hence leaving this function with the AGF locked opens up potential
+	 * ABBA AGF deadlocks because a future allocation attempt in this
+	 * transaction may attempt to lock a lower number AGF.
+	 *
+	 * We can't release the AGF until the transaction is commited, so at
+	 * this point we must update the "firstblock" tracker to point at this
+	 * AG if the tracker is empty or points to a lower AG. This allows the
+	 * next allocation attempt to be modified appropriately to avoid
+	 * deadlocks.
+	 */
+	if (args->agbp &&
+	    (args->tp->t_firstblock == NULLFSBLOCK ||
+	     args->pag->pag_agno > minimum_agno)) {
+		args->tp->t_firstblock = XFS_AGB_TO_FSB(mp,
+					args->pag->pag_agno, 0);
+	}
 	xfs_perag_put(args->pag);
 	return 0;
 error0:
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 0d56a8d862e8..9dc33cdc2ab9 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3413,21 +3413,7 @@ xfs_bmap_process_allocated_extent(
 	xfs_fileoff_t		orig_offset,
 	xfs_extlen_t		orig_length)
 {
-	int			nullfb;
-
-	nullfb = ap->tp->t_firstblock == NULLFSBLOCK;
-
-	/*
-	 * check the allocation happened at the same or higher AG than
-	 * the first block that was allocated.
-	 */
-	ASSERT(nullfb ||
-		XFS_FSB_TO_AGNO(args->mp, ap->tp->t_firstblock) <=
-		XFS_FSB_TO_AGNO(args->mp, args->fsbno));
-
 	ap->blkno = args->fsbno;
-	if (nullfb)
-		ap->tp->t_firstblock = args->fsbno;
 	ap->length = args->len;
 	/*
 	 * If the extent size hint is active, we tried to round the
@@ -4256,7 +4242,7 @@ xfs_bmapi_convert_unwritten(
 	return 0;
 }
 
-static inline xfs_extlen_t
+xfs_extlen_t
 xfs_bmapi_minleft(
 	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index 16db95b11589..08c16e4edc0f 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -220,6 +220,8 @@ int	xfs_bmap_add_extent_unwritten_real(struct xfs_trans *tp,
 		struct xfs_inode *ip, int whichfork,
 		struct xfs_iext_cursor *icur, struct xfs_btree_cur **curp,
 		struct xfs_bmbt_irec *new, int *logflagsp);
+xfs_extlen_t xfs_bmapi_minleft(struct xfs_trans *tp, struct xfs_inode *ip,
+		int fork);
 
 enum xfs_bmap_intent_type {
 	XFS_BMAP_MAP = 1,
diff --git a/fs/xfs/libxfs/xfs_bmap_btree.c b/fs/xfs/libxfs/xfs_bmap_btree.c
index cfa052d40105..18de4fbfef4e 100644
--- a/fs/xfs/libxfs/xfs_bmap_btree.c
+++ b/fs/xfs/libxfs/xfs_bmap_btree.c
@@ -213,18 +213,16 @@ xfs_bmbt_alloc_block(
 	if (args.fsbno == NULLFSBLOCK) {
 		args.fsbno = be64_to_cpu(start->l);
 		args.type = XFS_ALLOCTYPE_START_BNO;
+
 		/*
-		 * Make sure there is sufficient room left in the AG to
-		 * complete a full tree split for an extent insert.  If
-		 * we are converting the middle part of an extent then
-		 * we may need space for two tree splits.
-		 *
-		 * We are relying on the caller to make the correct block
-		 * reservation for this operation to succeed.  If the
-		 * reservation amount is insufficient then we may fail a
-		 * block allocation here and corrupt the filesystem.
+		 * If we are coming here from something like unwritten extent
+		 * conversion, there has been no data extent allocation already
+		 * done, so we have to ensure that we attempt to locate the
+		 * entire set of bmbt allocations in the same AG, as
+		 * xfs_bmapi_write() would have reserved.
 		 */
-		args.minleft = args.tp->t_blk_res;
+		args.minleft = xfs_bmapi_minleft(cur->bc_tp, cur->bc_ino.ip,
+						cur->bc_ino.whichfork);
 	} else if (cur->bc_tp->t_flags & XFS_TRANS_LOWMODE) {
 		args.type = XFS_ALLOCTYPE_START_BNO;
 	} else {
@@ -248,6 +246,7 @@ xfs_bmbt_alloc_block(
 		 * successful activate the lowspace algorithm.
 		 */
 		args.fsbno = 0;
+		args.minleft = 0;
 		args.type = XFS_ALLOCTYPE_FIRST_AG;
 		error = xfs_alloc_vextent(&args);
 		if (error)
diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 4c16c8c31fcb..6b084b3cac83 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -2913,9 +2913,22 @@ xfs_btree_split_worker(
 }
 
 /*
- * BMBT split requests often come in with little stack to work on. Push
+ * BMBT split requests often come in with little stack to work on so we push
  * them off to a worker thread so there is lots of stack to use. For the other
  * btree types, just call directly to avoid the context switch overhead here.
+ *
+ * Care must be taken here - the work queue rescuer thread introduces potential
+ * AGF <> worker queue deadlocks if the BMBT block allocation has to lock new
+ * AGFs to allocate blocks. A task being run by the rescuer could attempt to
+ * lock an AGF that is already locked by a task queued to run by the rescuer,
+ * resulting in an ABBA deadlock as the rescuer cannot run the lock holder to
+ * release it until the current thread it is running gains the lock.
+ *
+ * To avoid this issue, we only ever queue BMBT splits that don't have an AGF
+ * already locked to allocate from. The only place that doesn't hold an AGF
+ * locked is unwritten extent conversion at IO completion, but that has already
+ * been offloaded to a worker thread and hence has no stack consumption issues
+ * we have to worry about.
  */
 STATIC int					/* error */
 xfs_btree_split(
@@ -2929,7 +2942,8 @@ xfs_btree_split(
 	struct xfs_btree_split_args	args;
 	DECLARE_COMPLETION_ONSTACK(done);
 
-	if (cur->bc_btnum != XFS_BTNUM_BMAP)
+	if (cur->bc_btnum != XFS_BTNUM_BMAP ||
+	    cur->bc_tp->t_firstblock == NULLFSBLOCK)
 		return __xfs_btree_split(cur, level, ptrp, key, curp, stat);
 
 	args.cur = cur;
diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 1cfd5bc6520a..9c60ebb328b4 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -257,6 +257,8 @@ typedef struct xfs_fsop_resblks {
 #define XFS_MAX_AG_BLOCKS	(XFS_MAX_AG_BYTES / XFS_MIN_BLOCKSIZE)
 #define XFS_MAX_CRC_AG_BLOCKS	(XFS_MAX_AG_BYTES / XFS_MIN_CRC_BLOCKSIZE)
 
+#define XFS_MAX_AGNUMBER	((xfs_agnumber_t)(NULLAGNUMBER - 1))
+
 /* keep the maximum size under 2^31 by a small amount */
 #define XFS_MAX_LOG_BYTES \
 	((2 * 1024 * 1024 * 1024ULL) - XFS_MIN_LOG_BYTES)
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 94db50eb706a..120dbec16f5c 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -1737,6 +1737,7 @@ xfs_dialloc(
 	struct xfs_perag	*pag;
 	struct xfs_ino_geometry	*igeo = M_IGEO(mp);
 	bool			ok_alloc = true;
+	bool			low_space = false;
 	int			flags;
 	xfs_ino_t		ino;
 
@@ -1767,6 +1768,20 @@ xfs_dialloc(
 		ok_alloc = false;
 	}
 
+	/*
+	 * If we are near to ENOSPC, we want to prefer allocation from AGs that
+	 * have free inodes in them rather than use up free space allocating new
+	 * inode chunks. Hence we turn off allocation for the first non-blocking
+	 * pass through the AGs if we are near ENOSPC to consume free inodes
+	 * that we can immediately allocate, but then we allow allocation on the
+	 * second pass if we fail to find an AG with free inodes in it.
+	 */
+	if (percpu_counter_read_positive(&mp->m_fdblocks) <
+			mp->m_low_space[XFS_LOWSP_1_PCNT]) {
+		ok_alloc = false;
+		low_space = true;
+	}
+
 	/*
 	 * Loop until we find an allocation group that either has free inodes
 	 * or in which we can allocate some inodes.  Iterate through the
@@ -1795,6 +1810,8 @@ xfs_dialloc(
 				break;
 			}
 			flags = 0;
+			if (low_space)
+				ok_alloc = true;
 		}
 		xfs_perag_put(pag);
 	}
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index f13e0809dc63..269573c82808 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -324,7 +324,6 @@ struct xfs_inode_log_format_32 {
 #define XFS_ILOG_DOWNER	0x200	/* change the data fork owner on replay */
 #define XFS_ILOG_AOWNER	0x400	/* change the attr fork owner on replay */
 
-
 /*
  * The timestamps are dirty, but not necessarily anything else in the inode
  * core.  Unlike the other fields above this one must never make it to disk
@@ -333,6 +332,14 @@ struct xfs_inode_log_format_32 {
  */
 #define XFS_ILOG_TIMESTAMP	0x4000
 
+/*
+ * The version field has been changed, but not necessarily anything else of
+ * interest. This must never make it to disk - it is used purely to ensure that
+ * the inode item ->precommit operation can update the fsync flag triggers
+ * in the inode item correctly.
+ */
+#define XFS_ILOG_IVERSION	0x8000
+
 #define	XFS_ILOG_NONCORE	(XFS_ILOG_DDATA | XFS_ILOG_DEXT | \
 				 XFS_ILOG_DBROOT | XFS_ILOG_DEV | \
 				 XFS_ILOG_ADATA | XFS_ILOG_AEXT | \
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index bf2cca78304e..c24a38272cb7 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -413,7 +413,6 @@ xfs_validate_sb_common(
 	    sbp->sb_inodelog < XFS_DINODE_MIN_LOG			||
 	    sbp->sb_inodelog > XFS_DINODE_MAX_LOG			||
 	    sbp->sb_inodesize != (1 << sbp->sb_inodelog)		||
-	    sbp->sb_logsunit > XLOG_MAX_RECORD_BSIZE			||
 	    sbp->sb_inopblock != howmany(sbp->sb_blocksize,sbp->sb_inodesize) ||
 	    XFS_FSB_TO_B(mp, sbp->sb_agblocks) < XFS_MIN_AG_BYTES	||
 	    XFS_FSB_TO_B(mp, sbp->sb_agblocks) > XFS_MAX_AG_BYTES	||
@@ -431,6 +430,61 @@ xfs_validate_sb_common(
 		return -EFSCORRUPTED;
 	}
 
+	/*
+	 * Logs that are too large are not supported at all. Reject them
+	 * outright. Logs that are too small are tolerated on v4 filesystems,
+	 * but we can only check that when mounting the log. Hence we skip
+	 * those checks here.
+	 */
+	if (sbp->sb_logblocks > XFS_MAX_LOG_BLOCKS) {
+		xfs_notice(mp,
+		"Log size 0x%x blocks too large, maximum size is 0x%llx blocks",
+			 sbp->sb_logblocks, XFS_MAX_LOG_BLOCKS);
+		return -EFSCORRUPTED;
+	}
+
+	if (XFS_FSB_TO_B(mp, sbp->sb_logblocks) > XFS_MAX_LOG_BYTES) {
+		xfs_warn(mp,
+		"log size 0x%llx bytes too large, maximum size is 0x%llx bytes",
+			 XFS_FSB_TO_B(mp, sbp->sb_logblocks),
+			 XFS_MAX_LOG_BYTES);
+		return -EFSCORRUPTED;
+	}
+
+	/*
+	 * Do not allow filesystems with corrupted log sector or stripe units to
+	 * be mounted. We cannot safely size the iclogs or write to the log if
+	 * the log stripe unit is not valid.
+	 */
+	if (sbp->sb_versionnum & XFS_SB_VERSION_SECTORBIT) {
+		if (sbp->sb_logsectsize != (1U << sbp->sb_logsectlog)) {
+			xfs_notice(mp,
+			"log sector size in bytes/log2 (0x%x/0x%x) must match",
+				sbp->sb_logsectsize, 1U << sbp->sb_logsectlog);
+			return -EFSCORRUPTED;
+		}
+	} else if (sbp->sb_logsectsize || sbp->sb_logsectlog) {
+		xfs_notice(mp,
+		"log sector size in bytes/log2 (0x%x/0x%x) are not zero",
+			sbp->sb_logsectsize, sbp->sb_logsectlog);
+		return -EFSCORRUPTED;
+	}
+
+	if (sbp->sb_logsunit > 1) {
+		if (sbp->sb_logsunit % sbp->sb_blocksize) {
+			xfs_notice(mp,
+		"log stripe unit 0x%x bytes must be a multiple of block size",
+				sbp->sb_logsunit);
+			return -EFSCORRUPTED;
+		}
+		if (sbp->sb_logsunit > XLOG_MAX_RECORD_BSIZE) {
+			xfs_notice(mp,
+		"log stripe unit 0x%x bytes over maximum size (0x%x bytes)",
+				sbp->sb_logsunit, XLOG_MAX_RECORD_BSIZE);
+			return -EFSCORRUPTED;
+		}
+	}
+
 	/* Validate the realtime geometry; stolen from xfs_repair */
 	if (sbp->sb_rextsize * sbp->sb_blocksize > XFS_MAX_RTEXTSIZE ||
 	    sbp->sb_rextsize * sbp->sb_blocksize < XFS_MIN_RTEXTSIZE) {
diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 8b5547073379..cb4796b6e693 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -40,9 +40,8 @@ xfs_trans_ijoin(
 	iip->ili_lock_flags = lock_flags;
 	ASSERT(!xfs_iflags_test(ip, XFS_ISTALE));
 
-	/*
-	 * Get a log_item_desc to point at the new item.
-	 */
+	/* Reset the per-tx dirty context and add the item to the tx. */
+	iip->ili_dirty_flags = 0;
 	xfs_trans_add_item(tp, &iip->ili_item);
 }
 
@@ -76,17 +75,10 @@ xfs_trans_ichgtime(
 /*
  * This is called to mark the fields indicated in fieldmask as needing to be
  * logged when the transaction is committed.  The inode must already be
- * associated with the given transaction.
- *
- * The values for fieldmask are defined in xfs_inode_item.h.  We always log all
- * of the core inode if any of it has changed, and we always log all of the
- * inline data/extents/b-tree root if any of them has changed.
- *
- * Grab and pin the cluster buffer associated with this inode to avoid RMW
- * cycles at inode writeback time. Avoid the need to add error handling to every
- * xfs_trans_log_inode() call by shutting down on read error.  This will cause
- * transactions to fail and everything to error out, just like if we return a
- * read error in a dirty transaction and cancel it.
+ * associated with the given transaction. All we do here is record where the
+ * inode was dirtied and mark the transaction and inode log item dirty;
+ * everything else is done in the ->precommit log item operation after the
+ * changes in the transaction have been completed.
  */
 void
 xfs_trans_log_inode(
@@ -96,7 +88,6 @@ xfs_trans_log_inode(
 {
 	struct xfs_inode_log_item *iip = ip->i_itemp;
 	struct inode		*inode = VFS_I(ip);
-	uint			iversion_flags = 0;
 
 	ASSERT(iip);
 	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
@@ -104,18 +95,6 @@ xfs_trans_log_inode(
 
 	tp->t_flags |= XFS_TRANS_DIRTY;
 
-	/*
-	 * Don't bother with i_lock for the I_DIRTY_TIME check here, as races
-	 * don't matter - we either will need an extra transaction in 24 hours
-	 * to log the timestamps, or will clear already cleared fields in the
-	 * worst case.
-	 */
-	if (inode->i_state & I_DIRTY_TIME) {
-		spin_lock(&inode->i_lock);
-		inode->i_state &= ~I_DIRTY_TIME;
-		spin_unlock(&inode->i_lock);
-	}
-
 	/*
 	 * First time we log the inode in a transaction, bump the inode change
 	 * counter if it is configured for this to occur. While we have the
@@ -128,86 +107,10 @@ xfs_trans_log_inode(
 	if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags)) {
 		if (IS_I_VERSION(inode) &&
 		    inode_maybe_inc_iversion(inode, flags & XFS_ILOG_CORE))
-			iversion_flags = XFS_ILOG_CORE;
-	}
-
-	/*
-	 * If we're updating the inode core or the timestamps and it's possible
-	 * to upgrade this inode to bigtime format, do so now.
-	 */
-	if ((flags & (XFS_ILOG_CORE | XFS_ILOG_TIMESTAMP)) &&
-	    xfs_has_bigtime(ip->i_mount) &&
-	    !xfs_inode_has_bigtime(ip)) {
-		ip->i_diflags2 |= XFS_DIFLAG2_BIGTIME;
-		flags |= XFS_ILOG_CORE;
-	}
-
-	/*
-	 * Inode verifiers do not check that the extent size hint is an integer
-	 * multiple of the rt extent size on a directory with both rtinherit
-	 * and extszinherit flags set.  If we're logging a directory that is
-	 * misconfigured in this way, clear the hint.
-	 */
-	if ((ip->i_diflags & XFS_DIFLAG_RTINHERIT) &&
-	    (ip->i_diflags & XFS_DIFLAG_EXTSZINHERIT) &&
-	    (ip->i_extsize % ip->i_mount->m_sb.sb_rextsize) > 0) {
-		ip->i_diflags &= ~(XFS_DIFLAG_EXTSIZE |
-				   XFS_DIFLAG_EXTSZINHERIT);
-		ip->i_extsize = 0;
-		flags |= XFS_ILOG_CORE;
+			flags |= XFS_ILOG_IVERSION;
 	}
 
-	/*
-	 * Record the specific change for fdatasync optimisation. This allows
-	 * fdatasync to skip log forces for inodes that are only timestamp
-	 * dirty.
-	 */
-	spin_lock(&iip->ili_lock);
-	iip->ili_fsync_fields |= flags;
-
-	if (!iip->ili_item.li_buf) {
-		struct xfs_buf	*bp;
-		int		error;
-
-		/*
-		 * We hold the ILOCK here, so this inode is not going to be
-		 * flushed while we are here. Further, because there is no
-		 * buffer attached to the item, we know that there is no IO in
-		 * progress, so nothing will clear the ili_fields while we read
-		 * in the buffer. Hence we can safely drop the spin lock and
-		 * read the buffer knowing that the state will not change from
-		 * here.
-		 */
-		spin_unlock(&iip->ili_lock);
-		error = xfs_imap_to_bp(ip->i_mount, tp, &ip->i_imap, &bp);
-		if (error) {
-			xfs_force_shutdown(ip->i_mount, SHUTDOWN_META_IO_ERROR);
-			return;
-		}
-
-		/*
-		 * We need an explicit buffer reference for the log item but
-		 * don't want the buffer to remain attached to the transaction.
-		 * Hold the buffer but release the transaction reference once
-		 * we've attached the inode log item to the buffer log item
-		 * list.
-		 */
-		xfs_buf_hold(bp);
-		spin_lock(&iip->ili_lock);
-		iip->ili_item.li_buf = bp;
-		bp->b_flags |= _XBF_INODES;
-		list_add_tail(&iip->ili_item.li_bio_list, &bp->b_li_list);
-		xfs_trans_brelse(tp, bp);
-	}
-
-	/*
-	 * Always OR in the bits from the ili_last_fields field.  This is to
-	 * coordinate with the xfs_iflush() and xfs_buf_inode_iodone() routines
-	 * in the eventual clearing of the ili_fields bits.  See the big comment
-	 * in xfs_iflush() for an explanation of this coordination mechanism.
-	 */
-	iip->ili_fields |= (flags | iip->ili_last_fields | iversion_flags);
-	spin_unlock(&iip->ili_lock);
+	iip->ili_dirty_flags |= flags;
 }
 
 int
diff --git a/fs/xfs/xfs_attr_inactive.c b/fs/xfs/xfs_attr_inactive.c
index 5db87b34fb6e..89c7a9f4f930 100644
--- a/fs/xfs/xfs_attr_inactive.c
+++ b/fs/xfs/xfs_attr_inactive.c
@@ -333,7 +333,6 @@ xfs_attr_inactive(
 	int			error = 0;
 
 	mp = dp->i_mount;
-	ASSERT(! XFS_NOT_DQATTACHED(mp, dp));
 
 	xfs_ilock(dp, lock_mode);
 	if (!xfs_inode_has_attr_fork(dp))
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 867645b74d88..ce8e17ab5434 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -314,15 +314,13 @@ xfs_getbmap_report_one(
 	if (isnullstartblock(got->br_startblock) ||
 	    got->br_startblock == DELAYSTARTBLOCK) {
 		/*
-		 * Delalloc extents that start beyond EOF can occur due to
-		 * speculative EOF allocation when the delalloc extent is larger
-		 * than the largest freespace extent at conversion time.  These
-		 * extents cannot be converted by data writeback, so can exist
-		 * here even if we are not supposed to be finding delalloc
-		 * extents.
+		 * Take the flush completion as being a point-in-time snapshot
+		 * where there are no delalloc extents, and if any new ones
+		 * have been created racily, just skip them as being 'after'
+		 * the flush and so don't get reported.
 		 */
-		if (got->br_startoff < XFS_B_TO_FSB(ip->i_mount, XFS_ISIZE(ip)))
-			ASSERT((bmv->bmv_iflags & BMV_IF_DELALLOC) != 0);
+		if (!(bmv->bmv_iflags & BMV_IF_DELALLOC))
+			return 0;
 
 		p->bmv_oflags |= BMV_OF_DELALLOC;
 		p->bmv_block = -2;
@@ -560,7 +558,9 @@ xfs_getbmap(
 		if (!xfs_iext_next_extent(ifp, &icur, &got)) {
 			xfs_fileoff_t	end = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
 
-			out[bmv->bmv_entries - 1].bmv_oflags |= BMV_OF_LAST;
+			if (bmv->bmv_entries > 0)
+				out[bmv->bmv_entries - 1].bmv_oflags |=
+								BMV_OF_LAST;
 
 			if (whichfork != XFS_ATTR_FORK && bno < end &&
 			    !xfs_getbmap_full(bmv)) {
diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index df7322ed73fa..023d4e0385dd 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -452,10 +452,18 @@ xfs_buf_item_format(
  * This is called to pin the buffer associated with the buf log item in memory
  * so it cannot be written out.
  *
- * We also always take a reference to the buffer log item here so that the bli
- * is held while the item is pinned in memory. This means that we can
- * unconditionally drop the reference count a transaction holds when the
- * transaction is completed.
+ * We take a reference to the buffer log item here so that the BLI life cycle
+ * extends at least until the buffer is unpinned via xfs_buf_item_unpin() and
+ * inserted into the AIL.
+ *
+ * We also need to take a reference to the buffer itself as the BLI unpin
+ * processing requires accessing the buffer after the BLI has dropped the final
+ * BLI reference. See xfs_buf_item_unpin() for an explanation.
+ * If unpins race to drop the final BLI reference and only the
+ * BLI owns a reference to the buffer, then the loser of the race can have the
+ * buffer fgreed from under it (e.g. on shutdown). Taking a buffer reference per
+ * pin count ensures the life cycle of the buffer extends for as
+ * long as we hold the buffer pin reference in xfs_buf_item_unpin().
  */
 STATIC void
 xfs_buf_item_pin(
@@ -470,13 +478,30 @@ xfs_buf_item_pin(
 
 	trace_xfs_buf_item_pin(bip);
 
+	xfs_buf_hold(bip->bli_buf);
 	atomic_inc(&bip->bli_refcount);
 	atomic_inc(&bip->bli_buf->b_pin_count);
 }
 
 /*
- * This is called to unpin the buffer associated with the buf log item which
- * was previously pinned with a call to xfs_buf_item_pin().
+ * This is called to unpin the buffer associated with the buf log item which was
+ * previously pinned with a call to xfs_buf_item_pin().  We enter this function
+ * with a buffer pin count, a buffer reference and a BLI reference.
+ *
+ * We must drop the BLI reference before we unpin the buffer because the AIL
+ * doesn't acquire a BLI reference whenever it accesses it. Therefore if the
+ * refcount drops to zero, the bli could still be AIL resident and the buffer
+ * submitted for I/O at any point before we return. This can result in IO
+ * completion freeing the buffer while we are still trying to access it here.
+ * This race condition can also occur in shutdown situations where we abort and
+ * unpin buffers from contexts other that journal IO completion.
+ *
+ * Hence we have to hold a buffer reference per pin count to ensure that the
+ * buffer cannot be freed until we have finished processing the unpin operation.
+ * The reference is taken in xfs_buf_item_pin(), and we must hold it until we
+ * are done processing the buffer state. In the case of an abort (remove =
+ * true) then we re-use the current pin reference as the IO reference we hand
+ * off to IO failure handling.
  */
 STATIC void
 xfs_buf_item_unpin(
@@ -493,24 +518,18 @@ xfs_buf_item_unpin(
 
 	trace_xfs_buf_item_unpin(bip);
 
-	/*
-	 * Drop the bli ref associated with the pin and grab the hold required
-	 * for the I/O simulation failure in the abort case. We have to do this
-	 * before the pin count drops because the AIL doesn't acquire a bli
-	 * reference. Therefore if the refcount drops to zero, the bli could
-	 * still be AIL resident and the buffer submitted for I/O (and freed on
-	 * completion) at any point before we return. This can be removed once
-	 * the AIL properly holds a reference on the bli.
-	 */
 	freed = atomic_dec_and_test(&bip->bli_refcount);
-	if (freed && !stale && remove)
-		xfs_buf_hold(bp);
 	if (atomic_dec_and_test(&bp->b_pin_count))
 		wake_up_all(&bp->b_waiters);
 
-	 /* nothing to do but drop the pin count if the bli is active */
-	if (!freed)
+	/*
+	 * Nothing to do but drop the buffer pin reference if the BLI is
+	 * still active.
+	 */
+	if (!freed) {
+		xfs_buf_rele(bp);
 		return;
+	}
 
 	if (stale) {
 		ASSERT(bip->bli_flags & XFS_BLI_STALE);
@@ -522,6 +541,15 @@ xfs_buf_item_unpin(
 
 		trace_xfs_buf_item_unpin_stale(bip);
 
+		/*
+		 * The buffer has been locked and referenced since it was marked
+		 * stale so we own both lock and reference exclusively here. We
+		 * do not need the pin reference any more, so drop it now so
+		 * that we only have one reference to drop once item completion
+		 * processing is complete.
+		 */
+		xfs_buf_rele(bp);
+
 		/*
 		 * If we get called here because of an IO error, we may or may
 		 * not have the item on the AIL. xfs_trans_ail_delete() will
@@ -538,16 +566,30 @@ xfs_buf_item_unpin(
 			ASSERT(bp->b_log_item == NULL);
 		}
 		xfs_buf_relse(bp);
-	} else if (remove) {
+		return;
+	}
+
+	if (remove) {
 		/*
-		 * The buffer must be locked and held by the caller to simulate
-		 * an async I/O failure. We acquired the hold for this case
-		 * before the buffer was unpinned.
+		 * We need to simulate an async IO failures here to ensure that
+		 * the correct error completion is run on this buffer. This
+		 * requires a reference to the buffer and for the buffer to be
+		 * locked. We can safely pass ownership of the pin reference to
+		 * the IO to ensure that nothing can free the buffer while we
+		 * wait for the lock and then run the IO failure completion.
 		 */
 		xfs_buf_lock(bp);
 		bp->b_flags |= XBF_ASYNC;
 		xfs_buf_ioend_fail(bp);
+		return;
 	}
+
+	/*
+	 * BLI has no more active references - it will be moved to the AIL to
+	 * manage the remaining BLI/buffer life cycle. There is nothing left for
+	 * us to do here so drop the pin reference to the buffer.
+	 */
+	xfs_buf_rele(bp);
 }
 
 STATIC uint
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 8fb90da89787..7f071757f278 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -798,7 +798,6 @@ xfs_qm_dqget_cache_insert(
 	error = radix_tree_insert(tree, id, dqp);
 	if (unlikely(error)) {
 		/* Duplicate found!  Caller must try again. */
-		WARN_ON(error != -EEXIST);
 		mutex_unlock(&qi->qi_tree_lock);
 		trace_xfs_dqget_dup(dqp);
 		return error;
diff --git a/fs/xfs/xfs_export.c b/fs/xfs/xfs_export.c
index 1064c2342876..7cd09c3a82cb 100644
--- a/fs/xfs/xfs_export.c
+++ b/fs/xfs/xfs_export.c
@@ -146,6 +146,20 @@ xfs_nfs_get_inode(
 		return ERR_PTR(error);
 	}
 
+	/*
+	 * Reload the incore unlinked list to avoid failure in inodegc.
+	 * Use an unlocked check here because unrecovered unlinked inodes
+	 * should be somewhat rare.
+	 */
+	if (xfs_inode_unlinked_incomplete(ip)) {
+		error = xfs_inode_reload_unlinked(ip);
+		if (error) {
+			xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
+			xfs_irele(ip);
+			return ERR_PTR(error);
+		}
+	}
+
 	if (VFS_I(ip)->i_generation != generation) {
 		xfs_irele(ip);
 		return ERR_PTR(-ESTALE);
diff --git a/fs/xfs/xfs_extent_busy.c b/fs/xfs/xfs_extent_busy.c
index ad22a003f959..f3d328e4a440 100644
--- a/fs/xfs/xfs_extent_busy.c
+++ b/fs/xfs/xfs_extent_busy.c
@@ -236,6 +236,7 @@ xfs_extent_busy_update_extent(
 		 *
 		 */
 		busyp->bno = fend;
+		busyp->length = bend - fend;
 	} else if (bbno < fbno) {
 		/*
 		 * Case 8:
diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index d8337274c74d..062e5dc5db9f 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -761,6 +761,7 @@ xfs_getfsmap_datadev_bnobt(
 {
 	struct xfs_alloc_rec_incore	akeys[2];
 
+	memset(akeys, 0, sizeof(akeys));
 	info->missing_owner = XFS_FMR_OWN_UNKNOWN;
 	return __xfs_getfsmap_datadev(tp, keys, info,
 			xfs_getfsmap_datadev_bnobt_query, &akeys[0]);
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 332da0d7b85c..77b14f788214 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -115,11 +115,16 @@ xfs_growfs_data_private(
 
 	nb_div = nb;
 	nb_mod = do_div(nb_div, mp->m_sb.sb_agblocks);
-	nagcount = nb_div + (nb_mod != 0);
-	if (nb_mod && nb_mod < XFS_MIN_AG_BLOCKS) {
-		nagcount--;
-		nb = (xfs_rfsblock_t)nagcount * mp->m_sb.sb_agblocks;
+	if (nb_mod && nb_mod >= XFS_MIN_AG_BLOCKS)
+		nb_div++;
+	else if (nb_mod)
+		nb = nb_div * mp->m_sb.sb_agblocks;
+
+	if (nb_div > XFS_MAX_AGNUMBER + 1) {
+		nb_div = XFS_MAX_AGNUMBER + 1;
+		nb = nb_div * mp->m_sb.sb_agblocks;
 	}
+	nagcount = nb_div;
 	delta = nb - mp->m_sb.sb_dblocks;
 	/*
 	 * Reject filesystems with a single AG because they are not
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index dd5a664c294f..6df826fc787c 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -113,7 +113,7 @@ xfs_inode_alloc(
 	INIT_LIST_HEAD(&ip->i_ioend_list);
 	spin_lock_init(&ip->i_ioend_lock);
 	ip->i_next_unlinked = NULLAGINO;
-	ip->i_prev_unlinked = NULLAGINO;
+	ip->i_prev_unlinked = 0;
 
 	return ip;
 }
@@ -454,6 +454,27 @@ xfs_inodegc_queue_all(
 	return ret;
 }
 
+/* Wait for all queued work and collect errors */
+static int
+xfs_inodegc_wait_all(
+	struct xfs_mount	*mp)
+{
+	int			cpu;
+	int			error = 0;
+
+	flush_workqueue(mp->m_inodegc_wq);
+	for_each_online_cpu(cpu) {
+		struct xfs_inodegc	*gc;
+
+		gc = per_cpu_ptr(mp->m_inodegc, cpu);
+		if (gc->error && !error)
+			error = gc->error;
+		gc->error = 0;
+	}
+
+	return error;
+}
+
 /*
  * Check the validity of the inode we just found it the cache
  */
@@ -1490,15 +1511,14 @@ xfs_blockgc_free_space(
 	if (error)
 		return error;
 
-	xfs_inodegc_flush(mp);
-	return 0;
+	return xfs_inodegc_flush(mp);
 }
 
 /*
  * Reclaim all the free space that we can by scheduling the background blockgc
  * and inodegc workers immediately and waiting for them all to clear.
  */
-void
+int
 xfs_blockgc_flush_all(
 	struct xfs_mount	*mp)
 {
@@ -1519,7 +1539,7 @@ xfs_blockgc_flush_all(
 	for_each_perag_tag(mp, agno, pag, XFS_ICI_BLOCKGC_TAG)
 		flush_delayed_work(&pag->pag_blockgc_work);
 
-	xfs_inodegc_flush(mp);
+	return xfs_inodegc_flush(mp);
 }
 
 /*
@@ -1841,13 +1861,17 @@ xfs_inodegc_set_reclaimable(
  * This is the last chance to make changes to an otherwise unreferenced file
  * before incore reclamation happens.
  */
-static void
+static int
 xfs_inodegc_inactivate(
 	struct xfs_inode	*ip)
 {
+	int			error;
+
 	trace_xfs_inode_inactivating(ip);
-	xfs_inactive(ip);
+	error = xfs_inactive(ip);
 	xfs_inodegc_set_reclaimable(ip);
+	return error;
+
 }
 
 void
@@ -1858,6 +1882,7 @@ xfs_inodegc_worker(
 						struct xfs_inodegc, work);
 	struct llist_node	*node = llist_del_all(&gc->list);
 	struct xfs_inode	*ip, *n;
+	unsigned int		nofs_flag;
 
 	ASSERT(gc->cpu == smp_processor_id());
 
@@ -1866,14 +1891,27 @@ xfs_inodegc_worker(
 	if (!node)
 		return;
 
+	/*
+	 * We can allocate memory here while doing writeback on behalf of
+	 * memory reclaim.  To avoid memory allocation deadlocks set the
+	 * task-wide nofs context for the following operations.
+	 */
+	nofs_flag = memalloc_nofs_save();
+
 	ip = llist_entry(node, struct xfs_inode, i_gclist);
 	trace_xfs_inodegc_worker(ip->i_mount, READ_ONCE(gc->shrinker_hits));
 
 	WRITE_ONCE(gc->shrinker_hits, 0);
 	llist_for_each_entry_safe(ip, n, node, i_gclist) {
+		int	error;
+
 		xfs_iflags_set(ip, XFS_INACTIVATING);
-		xfs_inodegc_inactivate(ip);
+		error = xfs_inodegc_inactivate(ip);
+		if (error && !gc->error)
+			gc->error = error;
 	}
+
+	memalloc_nofs_restore(nofs_flag);
 }
 
 /*
@@ -1894,13 +1932,13 @@ xfs_inodegc_push(
  * Force all currently queued inode inactivation work to run immediately and
  * wait for the work to finish.
  */
-void
+int
 xfs_inodegc_flush(
 	struct xfs_mount	*mp)
 {
 	xfs_inodegc_push(mp);
 	trace_xfs_inodegc_flush(mp, __return_address);
-	flush_workqueue(mp->m_inodegc_wq);
+	return xfs_inodegc_wait_all(mp);
 }
 
 /*
diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
index 6cd180721659..da58984b80d2 100644
--- a/fs/xfs/xfs_icache.h
+++ b/fs/xfs/xfs_icache.h
@@ -59,7 +59,7 @@ int xfs_blockgc_free_dquots(struct xfs_mount *mp, struct xfs_dquot *udqp,
 		unsigned int iwalk_flags);
 int xfs_blockgc_free_quota(struct xfs_inode *ip, unsigned int iwalk_flags);
 int xfs_blockgc_free_space(struct xfs_mount *mp, struct xfs_icwalk *icm);
-void xfs_blockgc_flush_all(struct xfs_mount *mp);
+int xfs_blockgc_flush_all(struct xfs_mount *mp);
 
 void xfs_inode_set_eofblocks_tag(struct xfs_inode *ip);
 void xfs_inode_clear_eofblocks_tag(struct xfs_inode *ip);
@@ -77,7 +77,7 @@ void xfs_blockgc_start(struct xfs_mount *mp);
 
 void xfs_inodegc_worker(struct work_struct *work);
 void xfs_inodegc_push(struct xfs_mount *mp);
-void xfs_inodegc_flush(struct xfs_mount *mp);
+int xfs_inodegc_flush(struct xfs_mount *mp);
 void xfs_inodegc_stop(struct xfs_mount *mp);
 void xfs_inodegc_start(struct xfs_mount *mp);
 void xfs_inodegc_cpu_dead(struct xfs_mount *mp, unsigned int cpu);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 54b707787f90..909085269227 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1620,16 +1620,7 @@ xfs_inactive_ifree(
 	 */
 	xfs_trans_mod_dquot_byino(tp, ip, XFS_TRANS_DQ_ICOUNT, -1);
 
-	/*
-	 * Just ignore errors at this point.  There is nothing we can do except
-	 * to try to keep going. Make sure it's not a silent error.
-	 */
-	error = xfs_trans_commit(tp);
-	if (error)
-		xfs_notice(mp, "%s: xfs_trans_commit returned error %d",
-			__func__, error);
-
-	return 0;
+	return xfs_trans_commit(tp);
 }
 
 /*
@@ -1696,12 +1687,12 @@ xfs_inode_needs_inactive(
  * now be truncated.  Also, we clear all of the read-ahead state
  * kept for the inode here since the file is now closed.
  */
-void
+int
 xfs_inactive(
 	xfs_inode_t	*ip)
 {
 	struct xfs_mount	*mp;
-	int			error;
+	int			error = 0;
 	int			truncate = 0;
 
 	/*
@@ -1742,7 +1733,7 @@ xfs_inactive(
 		 * reference to the inode at this point anyways.
 		 */
 		if (xfs_can_free_eofblocks(ip, true))
-			xfs_free_eofblocks(ip);
+			error = xfs_free_eofblocks(ip);
 
 		goto out;
 	}
@@ -1752,9 +1743,21 @@ xfs_inactive(
 	     ip->i_df.if_nextents > 0 || ip->i_delayed_blks > 0))
 		truncate = 1;
 
-	error = xfs_qm_dqattach(ip);
-	if (error)
-		goto out;
+	if (xfs_iflags_test(ip, XFS_IQUOTAUNCHECKED)) {
+		/*
+		 * If this inode is being inactivated during a quotacheck and
+		 * has not yet been scanned by quotacheck, we /must/ remove
+		 * the dquots from the inode before inactivation changes the
+		 * block and inode counts.  Most probably this is a result of
+		 * reloading the incore iunlinked list to purge unrecovered
+		 * unlinked inodes.
+		 */
+		xfs_qm_dqdetach(ip);
+	} else {
+		error = xfs_qm_dqattach(ip);
+		if (error)
+			goto out;
+	}
 
 	if (S_ISLNK(VFS_I(ip)->i_mode))
 		error = xfs_inactive_symlink(ip);
@@ -1779,7 +1782,7 @@ xfs_inactive(
 	/*
 	 * Free the inode.
 	 */
-	xfs_inactive_ifree(ip);
+	error = xfs_inactive_ifree(ip);
 
 out:
 	/*
@@ -1787,6 +1790,7 @@ xfs_inactive(
 	 * the attached dquots.
 	 */
 	xfs_qm_dqdetach(ip);
+	return error;
 }
 
 /*
@@ -1837,12 +1841,17 @@ xfs_iunlink_lookup(
 
 	rcu_read_lock();
 	ip = radix_tree_lookup(&pag->pag_ici_root, agino);
+	if (!ip) {
+		/* Caller can handle inode not being in memory. */
+		rcu_read_unlock();
+		return NULL;
+	}
 
 	/*
-	 * Inode not in memory or in RCU freeing limbo should not happen.
-	 * Warn about this and let the caller handle the failure.
+	 * Inode in RCU freeing limbo should not happen.  Warn about this and
+	 * let the caller handle the failure.
 	 */
-	if (WARN_ON_ONCE(!ip || !ip->i_ino)) {
+	if (WARN_ON_ONCE(!ip->i_ino)) {
 		rcu_read_unlock();
 		return NULL;
 	}
@@ -1851,7 +1860,10 @@ xfs_iunlink_lookup(
 	return ip;
 }
 
-/* Update the prev pointer of the next agino. */
+/*
+ * Update the prev pointer of the next agino.  Returns -ENOLINK if the inode
+ * is not in cache.
+ */
 static int
 xfs_iunlink_update_backref(
 	struct xfs_perag	*pag,
@@ -1866,7 +1878,8 @@ xfs_iunlink_update_backref(
 
 	ip = xfs_iunlink_lookup(pag, next_agino);
 	if (!ip)
-		return -EFSCORRUPTED;
+		return -ENOLINK;
+
 	ip->i_prev_unlinked = prev_agino;
 	return 0;
 }
@@ -1910,6 +1923,64 @@ xfs_iunlink_update_bucket(
 	return 0;
 }
 
+/*
+ * Load the inode @next_agino into the cache and set its prev_unlinked pointer
+ * to @prev_agino.  Caller must hold the AGI to synchronize with other changes
+ * to the unlinked list.
+ */
+STATIC int
+xfs_iunlink_reload_next(
+	struct xfs_trans	*tp,
+	struct xfs_buf		*agibp,
+	xfs_agino_t		prev_agino,
+	xfs_agino_t		next_agino)
+{
+	struct xfs_perag	*pag = agibp->b_pag;
+	struct xfs_mount	*mp = pag->pag_mount;
+	struct xfs_inode	*next_ip = NULL;
+	xfs_ino_t		ino;
+	int			error;
+
+	ASSERT(next_agino != NULLAGINO);
+
+#ifdef DEBUG
+	rcu_read_lock();
+	next_ip = radix_tree_lookup(&pag->pag_ici_root, next_agino);
+	ASSERT(next_ip == NULL);
+	rcu_read_unlock();
+#endif
+
+	xfs_info_ratelimited(mp,
+ "Found unrecovered unlinked inode 0x%x in AG 0x%x.  Initiating recovery.",
+			next_agino, pag->pag_agno);
+
+	/*
+	 * Use an untrusted lookup just to be cautious in case the AGI has been
+	 * corrupted and now points at a free inode.  That shouldn't happen,
+	 * but we'd rather shut down now since we're already running in a weird
+	 * situation.
+	 */
+	ino = XFS_AGINO_TO_INO(mp, pag->pag_agno, next_agino);
+	error = xfs_iget(mp, tp, ino, XFS_IGET_UNTRUSTED, 0, &next_ip);
+	if (error)
+		return error;
+
+	/* If this is not an unlinked inode, something is very wrong. */
+	if (VFS_I(next_ip)->i_nlink != 0) {
+		error = -EFSCORRUPTED;
+		goto rele;
+	}
+
+	next_ip->i_prev_unlinked = prev_agino;
+	trace_xfs_iunlink_reload_next(next_ip);
+rele:
+	ASSERT(!(VFS_I(next_ip)->i_state & I_DONTCACHE));
+	if (xfs_is_quotacheck_running(mp) && next_ip)
+		xfs_iflags_set(next_ip, XFS_IQUOTAUNCHECKED);
+	xfs_irele(next_ip);
+	return error;
+}
+
 static int
 xfs_iunlink_insert_inode(
 	struct xfs_trans	*tp,
@@ -1941,6 +2012,8 @@ xfs_iunlink_insert_inode(
 	 * inode.
 	 */
 	error = xfs_iunlink_update_backref(pag, agino, next_agino);
+	if (error == -ENOLINK)
+		error = xfs_iunlink_reload_next(tp, agibp, agino, next_agino);
 	if (error)
 		return error;
 
@@ -1956,6 +2029,7 @@ xfs_iunlink_insert_inode(
 	}
 
 	/* Point the head of the list to point to this inode. */
+	ip->i_prev_unlinked = NULLAGINO;
 	return xfs_iunlink_update_bucket(tp, pag, agibp, bucket_index, agino);
 }
 
@@ -2035,6 +2109,9 @@ xfs_iunlink_remove_inode(
 	 */
 	error = xfs_iunlink_update_backref(pag, ip->i_prev_unlinked,
 			ip->i_next_unlinked);
+	if (error == -ENOLINK)
+		error = xfs_iunlink_reload_next(tp, agibp, ip->i_prev_unlinked,
+				ip->i_next_unlinked);
 	if (error)
 		return error;
 
@@ -2055,7 +2132,7 @@ xfs_iunlink_remove_inode(
 	}
 
 	ip->i_next_unlinked = NULLAGINO;
-	ip->i_prev_unlinked = NULLAGINO;
+	ip->i_prev_unlinked = 0;
 	return error;
 }
 
@@ -2235,11 +2312,26 @@ xfs_ifree_cluster(
 		 * This buffer may not have been correctly initialised as we
 		 * didn't read it from disk. That's not important because we are
 		 * only using to mark the buffer as stale in the log, and to
-		 * attach stale cached inodes on it. That means it will never be
-		 * dispatched for IO. If it is, we want to know about it, and we
-		 * want it to fail. We can acheive this by adding a write
-		 * verifier to the buffer.
+		 * attach stale cached inodes on it.
+		 *
+		 * For the inode that triggered the cluster freeing, this
+		 * attachment may occur in xfs_inode_item_precommit() after we
+		 * have marked this buffer stale.  If this buffer was not in
+		 * memory before xfs_ifree_cluster() started, it will not be
+		 * marked XBF_DONE and this will cause problems later in
+		 * xfs_inode_item_precommit() when we trip over a (stale, !done)
+		 * buffer to attached to the transaction.
+		 *
+		 * Hence we have to mark the buffer as XFS_DONE here. This is
+		 * safe because we are also marking the buffer as XBF_STALE and
+		 * XFS_BLI_STALE. That means it will never be dispatched for
+		 * IO and it won't be unlocked until the cluster freeing has
+		 * been committed to the journal and the buffer unpinned. If it
+		 * is written, we want to know about it, and we want it to
+		 * fail. We can acheive this by adding a write verifier to the
+		 * buffer.
 		 */
+		bp->b_flags |= XBF_DONE;
 		bp->b_ops = &xfs_inode_buf_ops;
 
 		/*
@@ -3544,3 +3636,117 @@ xfs_iunlock2_io_mmap(
 	if (ip1 != ip2)
 		inode_unlock(VFS_I(ip1));
 }
+
+/*
+ * Reload the incore inode list for this inode.  Caller should ensure that
+ * the link count cannot change, either by taking ILOCK_SHARED or otherwise
+ * preventing other threads from executing.
+ */
+int
+xfs_inode_reload_unlinked_bucket(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*ip)
+{
+	struct xfs_mount	*mp = tp->t_mountp;
+	struct xfs_buf		*agibp;
+	struct xfs_agi		*agi;
+	struct xfs_perag	*pag;
+	xfs_agnumber_t		agno = XFS_INO_TO_AGNO(mp, ip->i_ino);
+	xfs_agino_t		agino = XFS_INO_TO_AGINO(mp, ip->i_ino);
+	xfs_agino_t		prev_agino, next_agino;
+	unsigned int		bucket;
+	bool			foundit = false;
+	int			error;
+
+	/* Grab the first inode in the list */
+	pag = xfs_perag_get(mp, agno);
+	error = xfs_ialloc_read_agi(pag, tp, &agibp);
+	xfs_perag_put(pag);
+	if (error)
+		return error;
+
+	/*
+	 * We've taken ILOCK_SHARED and the AGI buffer lock to stabilize the
+	 * incore unlinked list pointers for this inode.  Check once more to
+	 * see if we raced with anyone else to reload the unlinked list.
+	 */
+	if (!xfs_inode_unlinked_incomplete(ip)) {
+		foundit = true;
+		goto out_agibp;
+	}
+
+	bucket = agino % XFS_AGI_UNLINKED_BUCKETS;
+	agi = agibp->b_addr;
+
+	trace_xfs_inode_reload_unlinked_bucket(ip);
+
+	xfs_info_ratelimited(mp,
+ "Found unrecovered unlinked inode 0x%x in AG 0x%x.  Initiating list recovery.",
+			agino, agno);
+
+	prev_agino = NULLAGINO;
+	next_agino = be32_to_cpu(agi->agi_unlinked[bucket]);
+	while (next_agino != NULLAGINO) {
+		struct xfs_inode	*next_ip = NULL;
+
+		/* Found this caller's inode, set its backlink. */
+		if (next_agino == agino) {
+			next_ip = ip;
+			next_ip->i_prev_unlinked = prev_agino;
+			foundit = true;
+			goto next_inode;
+		}
+
+		/* Try in-memory lookup first. */
+		next_ip = xfs_iunlink_lookup(pag, next_agino);
+		if (next_ip)
+			goto next_inode;
+
+		/* Inode not in memory, try reloading it. */
+		error = xfs_iunlink_reload_next(tp, agibp, prev_agino,
+				next_agino);
+		if (error)
+			break;
+
+		/* Grab the reloaded inode. */
+		next_ip = xfs_iunlink_lookup(pag, next_agino);
+		if (!next_ip) {
+			/* No incore inode at all?  We reloaded it... */
+			ASSERT(next_ip != NULL);
+			error = -EFSCORRUPTED;
+			break;
+		}
+
+next_inode:
+		prev_agino = next_agino;
+		next_agino = next_ip->i_next_unlinked;
+	}
+
+out_agibp:
+	xfs_trans_brelse(tp, agibp);
+	/* Should have found this inode somewhere in the iunlinked bucket. */
+	if (!error && !foundit)
+		error = -EFSCORRUPTED;
+	return error;
+}
+
+/* Decide if this inode is missing its unlinked list and reload it. */
+int
+xfs_inode_reload_unlinked(
+	struct xfs_inode	*ip)
+{
+	struct xfs_trans	*tp;
+	int			error;
+
+	error = xfs_trans_alloc_empty(ip->i_mount, &tp);
+	if (error)
+		return error;
+
+	xfs_ilock(ip, XFS_ILOCK_SHARED);
+	if (xfs_inode_unlinked_incomplete(ip))
+		error = xfs_inode_reload_unlinked_bucket(tp, ip);
+	xfs_iunlock(ip, XFS_ILOCK_SHARED);
+	xfs_trans_cancel(tp);
+
+	return error;
+}
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index fa780f08dc89..85395ad2859c 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -68,8 +68,21 @@ typedef struct xfs_inode {
 	uint64_t		i_diflags2;	/* XFS_DIFLAG2_... */
 	struct timespec64	i_crtime;	/* time created */
 
-	/* unlinked list pointers */
+	/*
+	 * Unlinked list pointers.  These point to the next and previous inodes
+	 * in the AGI unlinked bucket list, respectively.  These fields can
+	 * only be updated with the AGI locked.
+	 *
+	 * i_next_unlinked caches di_next_unlinked.
+	 */
 	xfs_agino_t		i_next_unlinked;
+
+	/*
+	 * If the inode is not on an unlinked list, this field is zero.  If the
+	 * inode is the first element in an unlinked list, this field is
+	 * NULLAGINO.  Otherwise, i_prev_unlinked points to the previous inode
+	 * in the unlinked list.
+	 */
 	xfs_agino_t		i_prev_unlinked;
 
 	/* VFS inode */
@@ -81,6 +94,11 @@ typedef struct xfs_inode {
 	struct list_head	i_ioend_list;
 } xfs_inode_t;
 
+static inline bool xfs_inode_on_unlinked_list(const struct xfs_inode *ip)
+{
+	return ip->i_prev_unlinked != 0;
+}
+
 static inline bool xfs_inode_has_attr_fork(struct xfs_inode *ip)
 {
 	return ip->i_forkoff > 0;
@@ -326,6 +344,9 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
  */
 #define XFS_INACTIVATING	(1 << 13)
 
+/* Quotacheck is running but inode has not been added to quota counts. */
+#define XFS_IQUOTAUNCHECKED	(1 << 14)
+
 /* All inode state flags related to inode reclaim. */
 #define XFS_ALL_IRECLAIM_FLAGS	(XFS_IRECLAIMABLE | \
 				 XFS_IRECLAIM | \
@@ -340,7 +361,7 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 #define XFS_IRECLAIM_RESET_FLAGS	\
 	(XFS_IRECLAIMABLE | XFS_IRECLAIM | \
 	 XFS_IDIRTY_RELEASE | XFS_ITRUNCATED | XFS_NEED_INACTIVE | \
-	 XFS_INACTIVATING)
+	 XFS_INACTIVATING | XFS_IQUOTAUNCHECKED)
 
 /*
  * Flags for inode locking.
@@ -470,7 +491,7 @@ enum layout_break_reason {
 	(xfs_has_grpid((pip)->i_mount) || (VFS_I(pip)->i_mode & S_ISGID))
 
 int		xfs_release(struct xfs_inode *ip);
-void		xfs_inactive(struct xfs_inode *ip);
+int		xfs_inactive(struct xfs_inode *ip);
 int		xfs_lookup(struct xfs_inode *dp, const struct xfs_name *name,
 			   struct xfs_inode **ipp, struct xfs_name *ci_name);
 int		xfs_create(struct user_namespace *mnt_userns,
@@ -575,4 +596,13 @@ void xfs_end_io(struct work_struct *work);
 int xfs_ilock2_io_mmap(struct xfs_inode *ip1, struct xfs_inode *ip2);
 void xfs_iunlock2_io_mmap(struct xfs_inode *ip1, struct xfs_inode *ip2);
 
+static inline bool
+xfs_inode_unlinked_incomplete(
+	struct xfs_inode	*ip)
+{
+	return VFS_I(ip)->i_nlink == 0 && !xfs_inode_on_unlinked_list(ip);
+}
+int xfs_inode_reload_unlinked_bucket(struct xfs_trans *tp, struct xfs_inode *ip);
+int xfs_inode_reload_unlinked(struct xfs_inode *ip);
+
 #endif	/* __XFS_INODE_H__ */
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index ca2941ab6cbc..91c847a84e10 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -29,6 +29,153 @@ static inline struct xfs_inode_log_item *INODE_ITEM(struct xfs_log_item *lip)
 	return container_of(lip, struct xfs_inode_log_item, ili_item);
 }
 
+static uint64_t
+xfs_inode_item_sort(
+	struct xfs_log_item	*lip)
+{
+	return INODE_ITEM(lip)->ili_inode->i_ino;
+}
+
+/*
+ * Prior to finally logging the inode, we have to ensure that all the
+ * per-modification inode state changes are applied. This includes VFS inode
+ * state updates, format conversions, verifier state synchronisation and
+ * ensuring the inode buffer remains in memory whilst the inode is dirty.
+ *
+ * We have to be careful when we grab the inode cluster buffer due to lock
+ * ordering constraints. The unlinked inode modifications (xfs_iunlink_item)
+ * require AGI -> inode cluster buffer lock order. The inode cluster buffer is
+ * not locked until ->precommit, so it happens after everything else has been
+ * modified.
+ *
+ * Further, we have AGI -> AGF lock ordering, and with O_TMPFILE handling we
+ * have AGI -> AGF -> iunlink item -> inode cluster buffer lock order. Hence we
+ * cannot safely lock the inode cluster buffer in xfs_trans_log_inode() because
+ * it can be called on a inode (e.g. via bumplink/droplink) before we take the
+ * AGF lock modifying directory blocks.
+ *
+ * Rather than force a complete rework of all the transactions to call
+ * xfs_trans_log_inode() once and once only at the end of every transaction, we
+ * move the pinning of the inode cluster buffer to a ->precommit operation. This
+ * matches how the xfs_iunlink_item locks the inode cluster buffer, and it
+ * ensures that the inode cluster buffer locking is always done last in a
+ * transaction. i.e. we ensure the lock order is always AGI -> AGF -> inode
+ * cluster buffer.
+ *
+ * If we return the inode number as the precommit sort key then we'll also
+ * guarantee that the order all inode cluster buffer locking is the same all the
+ * inodes and unlink items in the transaction.
+ */
+static int
+xfs_inode_item_precommit(
+	struct xfs_trans	*tp,
+	struct xfs_log_item	*lip)
+{
+	struct xfs_inode_log_item *iip = INODE_ITEM(lip);
+	struct xfs_inode	*ip = iip->ili_inode;
+	struct inode		*inode = VFS_I(ip);
+	unsigned int		flags = iip->ili_dirty_flags;
+
+	/*
+	 * Don't bother with i_lock for the I_DIRTY_TIME check here, as races
+	 * don't matter - we either will need an extra transaction in 24 hours
+	 * to log the timestamps, or will clear already cleared fields in the
+	 * worst case.
+	 */
+	if (inode->i_state & I_DIRTY_TIME) {
+		spin_lock(&inode->i_lock);
+		inode->i_state &= ~I_DIRTY_TIME;
+		spin_unlock(&inode->i_lock);
+	}
+
+	/*
+	 * If we're updating the inode core or the timestamps and it's possible
+	 * to upgrade this inode to bigtime format, do so now.
+	 */
+	if ((flags & (XFS_ILOG_CORE | XFS_ILOG_TIMESTAMP)) &&
+	    xfs_has_bigtime(ip->i_mount) &&
+	    !xfs_inode_has_bigtime(ip)) {
+		ip->i_diflags2 |= XFS_DIFLAG2_BIGTIME;
+		flags |= XFS_ILOG_CORE;
+	}
+
+	/*
+	 * Inode verifiers do not check that the extent size hint is an integer
+	 * multiple of the rt extent size on a directory with both rtinherit
+	 * and extszinherit flags set.  If we're logging a directory that is
+	 * misconfigured in this way, clear the hint.
+	 */
+	if ((ip->i_diflags & XFS_DIFLAG_RTINHERIT) &&
+	    (ip->i_diflags & XFS_DIFLAG_EXTSZINHERIT) &&
+	    (ip->i_extsize % ip->i_mount->m_sb.sb_rextsize) > 0) {
+		ip->i_diflags &= ~(XFS_DIFLAG_EXTSIZE |
+				   XFS_DIFLAG_EXTSZINHERIT);
+		ip->i_extsize = 0;
+		flags |= XFS_ILOG_CORE;
+	}
+
+	/*
+	 * Record the specific change for fdatasync optimisation. This allows
+	 * fdatasync to skip log forces for inodes that are only timestamp
+	 * dirty. Once we've processed the XFS_ILOG_IVERSION flag, convert it
+	 * to XFS_ILOG_CORE so that the actual on-disk dirty tracking
+	 * (ili_fields) correctly tracks that the version has changed.
+	 */
+	spin_lock(&iip->ili_lock);
+	iip->ili_fsync_fields |= (flags & ~XFS_ILOG_IVERSION);
+	if (flags & XFS_ILOG_IVERSION)
+		flags = ((flags & ~XFS_ILOG_IVERSION) | XFS_ILOG_CORE);
+
+	if (!iip->ili_item.li_buf) {
+		struct xfs_buf	*bp;
+		int		error;
+
+		/*
+		 * We hold the ILOCK here, so this inode is not going to be
+		 * flushed while we are here. Further, because there is no
+		 * buffer attached to the item, we know that there is no IO in
+		 * progress, so nothing will clear the ili_fields while we read
+		 * in the buffer. Hence we can safely drop the spin lock and
+		 * read the buffer knowing that the state will not change from
+		 * here.
+		 */
+		spin_unlock(&iip->ili_lock);
+		error = xfs_imap_to_bp(ip->i_mount, tp, &ip->i_imap, &bp);
+		if (error)
+			return error;
+
+		/*
+		 * We need an explicit buffer reference for the log item but
+		 * don't want the buffer to remain attached to the transaction.
+		 * Hold the buffer but release the transaction reference once
+		 * we've attached the inode log item to the buffer log item
+		 * list.
+		 */
+		xfs_buf_hold(bp);
+		spin_lock(&iip->ili_lock);
+		iip->ili_item.li_buf = bp;
+		bp->b_flags |= _XBF_INODES;
+		list_add_tail(&iip->ili_item.li_bio_list, &bp->b_li_list);
+		xfs_trans_brelse(tp, bp);
+	}
+
+	/*
+	 * Always OR in the bits from the ili_last_fields field.  This is to
+	 * coordinate with the xfs_iflush() and xfs_buf_inode_iodone() routines
+	 * in the eventual clearing of the ili_fields bits.  See the big comment
+	 * in xfs_iflush() for an explanation of this coordination mechanism.
+	 */
+	iip->ili_fields |= (flags | iip->ili_last_fields);
+	spin_unlock(&iip->ili_lock);
+
+	/*
+	 * We are done with the log item transaction dirty state, so clear it so
+	 * that it doesn't pollute future transactions.
+	 */
+	iip->ili_dirty_flags = 0;
+	return 0;
+}
+
 /*
  * The logged size of an inode fork is always the current size of the inode
  * fork. This means that when an inode fork is relogged, the size of the logged
@@ -662,6 +809,8 @@ xfs_inode_item_committing(
 }
 
 static const struct xfs_item_ops xfs_inode_item_ops = {
+	.iop_sort	= xfs_inode_item_sort,
+	.iop_precommit	= xfs_inode_item_precommit,
 	.iop_size	= xfs_inode_item_size,
 	.iop_format	= xfs_inode_item_format,
 	.iop_pin	= xfs_inode_item_pin,
diff --git a/fs/xfs/xfs_inode_item.h b/fs/xfs/xfs_inode_item.h
index bbd836a44ff0..377e06007804 100644
--- a/fs/xfs/xfs_inode_item.h
+++ b/fs/xfs/xfs_inode_item.h
@@ -17,6 +17,7 @@ struct xfs_inode_log_item {
 	struct xfs_log_item	ili_item;	   /* common portion */
 	struct xfs_inode	*ili_inode;	   /* inode ptr */
 	unsigned short		ili_lock_flags;	   /* inode lock flags */
+	unsigned int		ili_dirty_flags;   /* dirty in current tx */
 	/*
 	 * The ili_lock protects the interactions between the dirty state and
 	 * the flush state of the inode log item. This allows us to do atomic
diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
index a1c2bcf65d37..44d603364d5a 100644
--- a/fs/xfs/xfs_itable.c
+++ b/fs/xfs/xfs_itable.c
@@ -80,6 +80,17 @@ xfs_bulkstat_one_int(
 	if (error)
 		goto out;
 
+	/* Reload the incore unlinked list to avoid failure in inodegc. */
+	if (xfs_inode_unlinked_incomplete(ip)) {
+		error = xfs_inode_reload_unlinked_bucket(tp, ip);
+		if (error) {
+			xfs_iunlock(ip, XFS_ILOCK_SHARED);
+			xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
+			xfs_irele(ip);
+			return error;
+		}
+	}
+
 	ASSERT(ip != NULL);
 	ASSERT(ip->i_imap.im_blkno != 0);
 	inode = VFS_I(ip);
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index d9aa5eab02c3..59c982297503 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -639,7 +639,6 @@ xfs_log_mount(
 	int		num_bblks)
 {
 	struct xlog	*log;
-	bool		fatal = xfs_has_crc(mp);
 	int		error = 0;
 	int		min_logfsbs;
 
@@ -661,53 +660,37 @@ xfs_log_mount(
 	mp->m_log = log;
 
 	/*
-	 * Validate the given log space and drop a critical message via syslog
-	 * if the log size is too small that would lead to some unexpected
-	 * situations in transaction log space reservation stage.
+	 * Now that we have set up the log and it's internal geometry
+	 * parameters, we can validate the given log space and drop a critical
+	 * message via syslog if the log size is too small. A log that is too
+	 * small can lead to unexpected situations in transaction log space
+	 * reservation stage. The superblock verifier has already validated all
+	 * the other log geometry constraints, so we don't have to check those
+	 * here.
 	 *
-	 * Note: we can't just reject the mount if the validation fails.  This
-	 * would mean that people would have to downgrade their kernel just to
-	 * remedy the situation as there is no way to grow the log (short of
-	 * black magic surgery with xfs_db).
+	 * Note: For v4 filesystems, we can't just reject the mount if the
+	 * validation fails.  This would mean that people would have to
+	 * downgrade their kernel just to remedy the situation as there is no
+	 * way to grow the log (short of black magic surgery with xfs_db).
 	 *
-	 * We can, however, reject mounts for CRC format filesystems, as the
+	 * We can, however, reject mounts for V5 format filesystems, as the
 	 * mkfs binary being used to make the filesystem should never create a
 	 * filesystem with a log that is too small.
 	 */
 	min_logfsbs = xfs_log_calc_minimum_size(mp);
-
 	if (mp->m_sb.sb_logblocks < min_logfsbs) {
 		xfs_warn(mp,
 		"Log size %d blocks too small, minimum size is %d blocks",
 			 mp->m_sb.sb_logblocks, min_logfsbs);
-		error = -EINVAL;
-	} else if (mp->m_sb.sb_logblocks > XFS_MAX_LOG_BLOCKS) {
-		xfs_warn(mp,
-		"Log size %d blocks too large, maximum size is %lld blocks",
-			 mp->m_sb.sb_logblocks, XFS_MAX_LOG_BLOCKS);
-		error = -EINVAL;
-	} else if (XFS_FSB_TO_B(mp, mp->m_sb.sb_logblocks) > XFS_MAX_LOG_BYTES) {
-		xfs_warn(mp,
-		"log size %lld bytes too large, maximum size is %lld bytes",
-			 XFS_FSB_TO_B(mp, mp->m_sb.sb_logblocks),
-			 XFS_MAX_LOG_BYTES);
-		error = -EINVAL;
-	} else if (mp->m_sb.sb_logsunit > 1 &&
-		   mp->m_sb.sb_logsunit % mp->m_sb.sb_blocksize) {
-		xfs_warn(mp,
-		"log stripe unit %u bytes must be a multiple of block size",
-			 mp->m_sb.sb_logsunit);
-		error = -EINVAL;
-		fatal = true;
-	}
-	if (error) {
+
 		/*
 		 * Log check errors are always fatal on v5; or whenever bad
 		 * metadata leads to a crash.
 		 */
-		if (fatal) {
+		if (xfs_has_crc(mp)) {
 			xfs_crit(mp, "AAIEEE! Log failed size checks. Abort!");
 			ASSERT(0);
+			error = -EINVAL;
 			goto out_free_log;
 		}
 		xfs_crit(mp, "Log size out of supported range.");
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 05e48523ea40..affe94356ed1 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2711,7 +2711,9 @@ xlog_recover_iunlink_bucket(
 			 * just to flush the inodegc queue and wait for it to
 			 * complete.
 			 */
-			xfs_inodegc_flush(mp);
+			error = xfs_inodegc_flush(mp);
+			if (error)
+				break;
 		}
 
 		prev_agino = agino;
@@ -2719,10 +2721,15 @@ xlog_recover_iunlink_bucket(
 	}
 
 	if (prev_ip) {
+		int	error2;
+
 		ip->i_prev_unlinked = prev_agino;
 		xfs_irele(prev_ip);
+
+		error2 = xfs_inodegc_flush(mp);
+		if (error2 && !error)
+			return error2;
 	}
-	xfs_inodegc_flush(mp);
 	return error;
 }
 
@@ -2789,7 +2796,6 @@ xlog_recover_iunlink_ag(
 			 * bucket and remaining inodes on it unreferenced and
 			 * unfreeable.
 			 */
-			xfs_inodegc_flush(pag->pag_mount);
 			xlog_recover_clear_agi_bucket(pag, bucket);
 		}
 	}
@@ -2806,13 +2812,6 @@ xlog_recover_process_iunlinks(
 
 	for_each_perag(log->l_mp, agno, pag)
 		xlog_recover_iunlink_ag(pag);
-
-	/*
-	 * Flush the pending unlinked inodes to ensure that the inactivations
-	 * are fully completed on disk and the incore inodes can be reclaimed
-	 * before we signal that recovery is complete.
-	 */
-	xfs_inodegc_flush(log->l_mp);
 }
 
 STATIC void
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 69ddd5319634..9dc0acf7314f 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -62,6 +62,7 @@ struct xfs_error_cfg {
 struct xfs_inodegc {
 	struct llist_head	list;
 	struct delayed_work	work;
+	int			error;
 
 	/* approximate count of inodes in the list */
 	unsigned int		items;
@@ -400,6 +401,8 @@ __XFS_HAS_FEAT(nouuid, NOUUID)
 #define XFS_OPSTATE_WARNED_SHRINK	8
 /* Kernel has logged a warning about logged xattr updates being used. */
 #define XFS_OPSTATE_WARNED_LARP		9
+/* Mount time quotacheck is running */
+#define XFS_OPSTATE_QUOTACHECK_RUNNING	10
 
 #define __XFS_IS_OPSTATE(name, NAME) \
 static inline bool xfs_is_ ## name (struct xfs_mount *mp) \
@@ -422,6 +425,11 @@ __XFS_IS_OPSTATE(inode32, INODE32)
 __XFS_IS_OPSTATE(readonly, READONLY)
 __XFS_IS_OPSTATE(inodegc_enabled, INODEGC_ENABLED)
 __XFS_IS_OPSTATE(blockgc_enabled, BLOCKGC_ENABLED)
+#ifdef CONFIG_XFS_QUOTA
+__XFS_IS_OPSTATE(quotacheck_running, QUOTACHECK_RUNNING)
+#else
+# define xfs_is_quotacheck_running(mp)	(false)
+#endif
 
 static inline bool
 xfs_should_warn(struct xfs_mount *mp, long nr)
@@ -439,7 +447,8 @@ xfs_should_warn(struct xfs_mount *mp, long nr)
 	{ (1UL << XFS_OPSTATE_BLOCKGC_ENABLED),		"blockgc" }, \
 	{ (1UL << XFS_OPSTATE_WARNED_SCRUB),		"wscrub" }, \
 	{ (1UL << XFS_OPSTATE_WARNED_SHRINK),		"wshrink" }, \
-	{ (1UL << XFS_OPSTATE_WARNED_LARP),		"wlarp" }
+	{ (1UL << XFS_OPSTATE_WARNED_LARP),		"wlarp" }, \
+	{ (1UL << XFS_OPSTATE_QUOTACHECK_RUNNING),	"quotacheck" }
 
 /*
  * Max and min values for mount-option defined I/O
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index c4078d0ec108..a7daa522e00f 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -114,7 +114,8 @@ xfs_dax_notify_ddev_failure(
 	int			error = 0;
 	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, daddr);
 	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
-	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp, daddr + bblen);
+	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp,
+							     daddr + bblen - 1);
 	xfs_agnumber_t		end_agno = XFS_FSB_TO_AGNO(mp, end_fsbno);
 
 	error = xfs_trans_alloc_empty(mp, &tp);
@@ -125,8 +126,8 @@ xfs_dax_notify_ddev_failure(
 		struct xfs_rmap_irec	ri_low = { };
 		struct xfs_rmap_irec	ri_high;
 		struct xfs_agf		*agf;
-		xfs_agblock_t		agend;
 		struct xfs_perag	*pag;
+		xfs_agblock_t		range_agend;
 
 		pag = xfs_perag_get(mp, agno);
 		error = xfs_alloc_read_agf(pag, tp, 0, &agf_bp);
@@ -147,10 +148,10 @@ xfs_dax_notify_ddev_failure(
 			ri_high.rm_startblock = XFS_FSB_TO_AGBNO(mp, end_fsbno);
 
 		agf = agf_bp->b_addr;
-		agend = min(be32_to_cpu(agf->agf_length),
+		range_agend = min(be32_to_cpu(agf->agf_length) - 1,
 				ri_high.rm_startblock);
 		notify.startblock = ri_low.rm_startblock;
-		notify.blockcount = agend - ri_low.rm_startblock;
+		notify.blockcount = range_agend + 1 - ri_low.rm_startblock;
 
 		error = xfs_rmap_query_range(cur, &ri_low, &ri_high,
 				xfs_dax_failure_fn, &notify);
@@ -210,7 +211,7 @@ xfs_dax_notify_failure(
 	ddev_end = ddev_start + bdev_nr_bytes(mp->m_ddev_targp->bt_bdev) - 1;
 
 	/* Ignore the range out of filesystem area */
-	if (offset + len < ddev_start)
+	if (offset + len - 1 < ddev_start)
 		return -ENXIO;
 	if (offset > ddev_end)
 		return -ENXIO;
@@ -222,8 +223,8 @@ xfs_dax_notify_failure(
 		len -= ddev_start - offset;
 		offset = 0;
 	}
-	if (offset + len > ddev_end)
-		len -= ddev_end - offset;
+	if (offset + len - 1 > ddev_end)
+		len = ddev_end - offset + 1;
 
 	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
 			mf_flags);
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 18bb4ec4d7c9..bd907bbc389c 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -422,6 +422,14 @@ xfs_qm_dquot_isolate(
 	if (!xfs_dqlock_nowait(dqp))
 		goto out_miss_busy;
 
+	/*
+	 * If something else is freeing this dquot and hasn't yet removed it
+	 * from the LRU, leave it for the freeing task to complete the freeing
+	 * process rather than risk it being free from under us here.
+	 */
+	if (dqp->q_flags & XFS_DQFLAG_FREEING)
+		goto out_miss_unlock;
+
 	/*
 	 * This dquot has acquired a reference in the meantime remove it from
 	 * the freelist and try again.
@@ -441,10 +449,8 @@ xfs_qm_dquot_isolate(
 	 * skip it so there is time for the IO to complete before we try to
 	 * reclaim it again on the next LRU pass.
 	 */
-	if (!xfs_dqflock_nowait(dqp)) {
-		xfs_dqunlock(dqp);
-		goto out_miss_busy;
-	}
+	if (!xfs_dqflock_nowait(dqp))
+		goto out_miss_unlock;
 
 	if (XFS_DQ_IS_DIRTY(dqp)) {
 		struct xfs_buf	*bp = NULL;
@@ -478,6 +484,8 @@ xfs_qm_dquot_isolate(
 	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaims);
 	return LRU_REMOVED;
 
+out_miss_unlock:
+	xfs_dqunlock(dqp);
 out_miss_busy:
 	trace_xfs_dqreclaim_busy(dqp);
 	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaim_misses);
@@ -1152,6 +1160,19 @@ xfs_qm_dqusage_adjust(
 	if (error)
 		return error;
 
+	/*
+	 * Reload the incore unlinked list to avoid failure in inodegc.
+	 * Use an unlocked check here because unrecovered unlinked inodes
+	 * should be somewhat rare.
+	 */
+	if (xfs_inode_unlinked_incomplete(ip)) {
+		error = xfs_inode_reload_unlinked(ip);
+		if (error) {
+			xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
+			goto error0;
+		}
+	}
+
 	ASSERT(ip->i_delayed_blks == 0);
 
 	if (XFS_IS_REALTIME_INODE(ip)) {
@@ -1165,6 +1186,7 @@ xfs_qm_dqusage_adjust(
 	}
 
 	nblks = (xfs_qcnt_t)ip->i_nblocks - rtblks;
+	xfs_iflags_clear(ip, XFS_IQUOTAUNCHECKED);
 
 	/*
 	 * Add the (disk blocks and inode) resources occupied by this
@@ -1311,17 +1333,18 @@ xfs_qm_quotacheck(
 		flags |= XFS_PQUOTA_CHKD;
 	}
 
+	xfs_set_quotacheck_running(mp);
 	error = xfs_iwalk_threaded(mp, 0, 0, xfs_qm_dqusage_adjust, 0, true,
 			NULL);
-	if (error) {
-		/*
-		 * The inode walk may have partially populated the dquot
-		 * caches.  We must purge them before disabling quota and
-		 * tearing down the quotainfo, or else the dquots will leak.
-		 */
-		xfs_qm_dqpurge_all(mp);
-		goto error_return;
-	}
+	xfs_clear_quotacheck_running(mp);
+
+	/*
+	 * On error, the inode walk may have partially populated the dquot
+	 * caches.  We must purge them before disabling quota and tearing down
+	 * the quotainfo, or else the dquots will leak.
+	 */
+	if (error)
+		goto error_purge;
 
 	/*
 	 * We've made all the changes that we need to make incore.  Flush them
@@ -1355,10 +1378,8 @@ xfs_qm_quotacheck(
 	 * and turn quotaoff. The dquots won't be attached to any of the inodes
 	 * at this point (because we intentionally didn't in dqget_noattach).
 	 */
-	if (error) {
-		xfs_qm_dqpurge_all(mp);
-		goto error_return;
-	}
+	if (error)
+		goto error_purge;
 
 	/*
 	 * If one type of quotas is off, then it will lose its
@@ -1368,7 +1389,7 @@ xfs_qm_quotacheck(
 	mp->m_qflags &= ~XFS_ALL_QUOTA_CHKD;
 	mp->m_qflags |= flags;
 
- error_return:
+error_return:
 	xfs_buf_delwri_cancel(&buffer_list);
 
 	if (error) {
@@ -1387,6 +1408,21 @@ xfs_qm_quotacheck(
 	} else
 		xfs_notice(mp, "Quotacheck: Done.");
 	return error;
+
+error_purge:
+	/*
+	 * On error, we may have inodes queued for inactivation. This may try
+	 * to attach dquots to the inode before running cleanup operations on
+	 * the inode and this can race with the xfs_qm_destroy_quotainfo() call
+	 * below that frees mp->m_quotainfo. To avoid this race, flush all the
+	 * pending inodegc operations before we purge the dquots from memory,
+	 * ensuring that background inactivation is idle whilst we turn off
+	 * quotas.
+	 */
+	xfs_inodegc_flush(mp);
+	xfs_qm_dqpurge_all(mp);
+	goto error_return;
+
 }
 
 /*
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 12662b169b71..1c143c69da6e 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1089,6 +1089,7 @@ xfs_inodegc_init_percpu(
 #endif
 		init_llist_head(&gc->list);
 		gc->items = 0;
+		gc->error = 0;
 		INIT_DELAYED_WORK(&gc->work, xfs_inodegc_worker);
 	}
 	return 0;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 372d871bccc5..0cd62031e53f 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1877,6 +1877,7 @@ DEFINE_ALLOC_EVENT(xfs_alloc_small_notenough);
 DEFINE_ALLOC_EVENT(xfs_alloc_small_done);
 DEFINE_ALLOC_EVENT(xfs_alloc_small_error);
 DEFINE_ALLOC_EVENT(xfs_alloc_vextent_badargs);
+DEFINE_ALLOC_EVENT(xfs_alloc_vextent_skip_deadlock);
 DEFINE_ALLOC_EVENT(xfs_alloc_vextent_nofix);
 DEFINE_ALLOC_EVENT(xfs_alloc_vextent_noagbp);
 DEFINE_ALLOC_EVENT(xfs_alloc_vextent_loopfailed);
@@ -3678,6 +3679,51 @@ TRACE_EVENT(xfs_iunlink_update_dinode,
 		  __entry->new_ptr)
 );
 
+TRACE_EVENT(xfs_iunlink_reload_next,
+	TP_PROTO(struct xfs_inode *ip),
+	TP_ARGS(ip),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_agnumber_t, agno)
+		__field(xfs_agino_t, agino)
+		__field(xfs_agino_t, prev_agino)
+		__field(xfs_agino_t, next_agino)
+	),
+	TP_fast_assign(
+		__entry->dev = ip->i_mount->m_super->s_dev;
+		__entry->agno = XFS_INO_TO_AGNO(ip->i_mount, ip->i_ino);
+		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
+		__entry->prev_agino = ip->i_prev_unlinked;
+		__entry->next_agino = ip->i_next_unlinked;
+	),
+	TP_printk("dev %d:%d agno 0x%x agino 0x%x prev_unlinked 0x%x next_unlinked 0x%x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->agno,
+		  __entry->agino,
+		  __entry->prev_agino,
+		  __entry->next_agino)
+);
+
+TRACE_EVENT(xfs_inode_reload_unlinked_bucket,
+	TP_PROTO(struct xfs_inode *ip),
+	TP_ARGS(ip),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_agnumber_t, agno)
+		__field(xfs_agino_t, agino)
+	),
+	TP_fast_assign(
+		__entry->dev = ip->i_mount->m_super->s_dev;
+		__entry->agno = XFS_INO_TO_AGNO(ip->i_mount, ip->i_ino);
+		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
+	),
+	TP_printk("dev %d:%d agno 0x%x agino 0x%x bucket %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->agno,
+		  __entry->agino,
+		  __entry->agino % XFS_AGI_UNLINKED_BUCKETS)
+);
+
 DECLARE_EVENT_CLASS(xfs_ag_inode_class,
 	TP_PROTO(struct xfs_inode *ip),
 	TP_ARGS(ip),
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 7bd16fbff534..b45879868f90 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -290,7 +290,9 @@ xfs_trans_alloc(
 		 * Do not perform a synchronous scan because callers can hold
 		 * other locks.
 		 */
-		xfs_blockgc_flush_all(mp);
+		error = xfs_blockgc_flush_all(mp);
+		if (error)
+			return error;
 		want_retry = false;
 		goto retry;
 	}
@@ -970,6 +972,11 @@ __xfs_trans_commit(
 		error = xfs_defer_finish_noroll(&tp);
 		if (error)
 			goto out_unreserve;
+
+		/* Run precommits from final tx in defer chain. */
+		error = xfs_trans_run_precommits(tp);
+		if (error)
+			goto out_unreserve;
 	}
 
 	/*
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index e365302fed95..c24b04235d91 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -296,9 +296,22 @@ struct nft_set_elem {
 	void			*priv;
 };
 
+/**
+ * enum nft_iter_type - nftables set iterator type
+ *
+ * @NFT_ITER_READ: read-only iteration over set elements
+ * @NFT_ITER_UPDATE: iteration under mutex to update set element state
+ */
+enum nft_iter_type {
+	NFT_ITER_UNSPEC,
+	NFT_ITER_READ,
+	NFT_ITER_UPDATE,
+};
+
 struct nft_set;
 struct nft_set_iter {
 	u8		genmask;
+	enum nft_iter_type type:8;
 	unsigned int	count;
 	unsigned int	skip;
 	int		err;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 419baf8efdde..0685ae2ea64e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5196,8 +5196,10 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	if (beacon->tail)
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 
-	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0)
+	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0) {
+		dev_kfree_skb(skb);
 		return NULL;
+	}
 
 	ieee80211_beacon_get_finish(hw, vif, link, offs, beacon, skb,
 				    chanctx_conf, csa_off_base);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 63b7be0a95d0..25a9bce8cd3a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -628,6 +628,7 @@ static void nft_map_deactivate(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	struct nft_set_iter iter = {
 		.genmask	= nft_genmask_next(ctx->net),
+		.type		= NFT_ITER_UPDATE,
 		.fn		= nft_mapelem_deactivate,
 	};
 
@@ -5143,6 +5144,7 @@ int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 		}
 
 		iter.genmask	= nft_genmask_next(ctx->net);
+		iter.type	= NFT_ITER_UPDATE;
 		iter.skip 	= 0;
 		iter.count	= 0;
 		iter.err	= 0;
@@ -5218,6 +5220,7 @@ static void nft_map_activate(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	struct nft_set_iter iter = {
 		.genmask	= nft_genmask_next(ctx->net),
+		.type		= NFT_ITER_UPDATE,
 		.fn		= nft_mapelem_activate,
 	};
 
@@ -5574,6 +5577,7 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	args.cb			= cb;
 	args.skb		= skb;
 	args.iter.genmask	= nft_genmask_cur(net);
+	args.iter.type		= NFT_ITER_READ;
 	args.iter.skip		= cb->args[0];
 	args.iter.count		= 0;
 	args.iter.err		= 0;
@@ -6957,6 +6961,7 @@ static int nft_set_flush(struct nft_ctx *ctx, struct nft_set *set, u8 genmask)
 {
 	struct nft_set_iter iter = {
 		.genmask	= genmask,
+		.type		= NFT_ITER_UPDATE,
 		.fn		= nft_setelem_flush,
 	};
 
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index 33daee2e54c5..fc0ac535d0d8 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -211,6 +211,7 @@ static int nft_lookup_validate(const struct nft_ctx *ctx,
 		return 0;
 
 	iter.genmask	= nft_genmask_next(ctx->net);
+	iter.type	= NFT_ITER_UPDATE;
 	iter.skip	= 0;
 	iter.count	= 0;
 	iter.err	= 0;
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index d9c1c467ea68..8336f2052f22 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2042,13 +2042,15 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 			    struct nft_set_iter *iter)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
-	struct net *net = read_pnet(&set->net);
 	const struct nft_pipapo_match *m;
 	const struct nft_pipapo_field *f;
 	int i, r;
 
+	WARN_ON_ONCE(iter->type != NFT_ITER_READ &&
+		     iter->type != NFT_ITER_UPDATE);
+
 	rcu_read_lock();
-	if (iter->genmask == nft_genmask_cur(net))
+	if (iter->type == NFT_ITER_READ)
 		m = rcu_dereference(priv->match);
 	else
 		m = priv->clone;
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 0f37738e4b26..4148df6d6a47 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -9,7 +9,8 @@
 
 struct nft_socket {
 	enum nft_socket_keys		key:8;
-	u8				level;
+	u8				level;		/* cgroupv2 level to extract */
+	u8				level_user;	/* cgroupv2 level provided by userspace */
 	u8				len;
 	union {
 		u8			dreg;
@@ -53,6 +54,28 @@ nft_sock_get_eval_cgroupv2(u32 *dest, struct sock *sk, const struct nft_pktinfo
 	memcpy(dest, &cgid, sizeof(u64));
 	return true;
 }
+
+/* process context only, uses current->nsproxy. */
+static noinline int nft_socket_cgroup_subtree_level(void)
+{
+	struct cgroup *cgrp = cgroup_get_from_path("/");
+	int level;
+
+	if (IS_ERR(cgrp))
+		return PTR_ERR(cgrp);
+
+	level = cgrp->level;
+
+	cgroup_put(cgrp);
+
+	if (WARN_ON_ONCE(level > 255))
+		return -ERANGE;
+
+	if (WARN_ON_ONCE(level < 0))
+		return -EINVAL;
+
+	return level;
+}
 #endif
 
 static struct sock *nft_socket_do_lookup(const struct nft_pktinfo *pkt)
@@ -174,9 +197,10 @@ static int nft_socket_init(const struct nft_ctx *ctx,
 	case NFT_SOCKET_MARK:
 		len = sizeof(u32);
 		break;
-#ifdef CONFIG_CGROUPS
+#ifdef CONFIG_SOCK_CGROUP_DATA
 	case NFT_SOCKET_CGROUPV2: {
 		unsigned int level;
+		int err;
 
 		if (!tb[NFTA_SOCKET_LEVEL])
 			return -EINVAL;
@@ -185,6 +209,17 @@ static int nft_socket_init(const struct nft_ctx *ctx,
 		if (level > 255)
 			return -EOPNOTSUPP;
 
+		err = nft_socket_cgroup_subtree_level();
+		if (err < 0)
+			return err;
+
+		priv->level_user = level;
+
+		level += err;
+		/* Implies a giant cgroup tree */
+		if (WARN_ON_ONCE(level > 255))
+			return -EOPNOTSUPP;
+
 		priv->level = level;
 		len = sizeof(u64);
 		break;
@@ -209,7 +244,7 @@ static int nft_socket_dump(struct sk_buff *skb,
 	if (nft_dump_register(skb, NFTA_SOCKET_DREG, priv->dreg))
 		return -1;
 	if (priv->key == NFT_SOCKET_CGROUPV2 &&
-	    nla_put_be32(skb, NFTA_SOCKET_LEVEL, htonl(priv->level)))
+	    nla_put_be32(skb, NFTA_SOCKET_LEVEL, htonl(priv->level_user)))
 		return -1;
 	return 0;
 }
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 8118b8614ac6..ee980965a7cf 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -228,7 +228,6 @@ void cfg80211_register_wdev(struct cfg80211_registered_device *rdev,
 static inline void wdev_lock(struct wireless_dev *wdev)
 	__acquires(wdev)
 {
-	lockdep_assert_held(&wdev->wiphy->mtx);
 	mutex_lock(&wdev->mtx);
 	__acquire(wdev->mtx);
 }
@@ -236,16 +235,11 @@ static inline void wdev_lock(struct wireless_dev *wdev)
 static inline void wdev_unlock(struct wireless_dev *wdev)
 	__releases(wdev)
 {
-	lockdep_assert_held(&wdev->wiphy->mtx);
 	__release(wdev->mtx);
 	mutex_unlock(&wdev->mtx);
 }
 
-static inline void ASSERT_WDEV_LOCK(struct wireless_dev *wdev)
-{
-	lockdep_assert_held(&wdev->wiphy->mtx);
-	lockdep_assert_held(&wdev->mtx);
-}
+#define ASSERT_WDEV_LOCK(wdev) lockdep_assert_held(&(wdev)->mtx)
 
 static inline bool cfg80211_has_monitors_only(struct cfg80211_registered_device *rdev)
 {
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d869d6ba96f3..277303cbe96d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4928,6 +4928,30 @@ static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 	}
 }
 
+static void alc_hp_mute_disable(struct hda_codec *codec, unsigned int delay)
+{
+	if (delay <= 0)
+		delay = 75;
+	snd_hda_codec_write(codec, 0x21, 0,
+		    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+	msleep(delay);
+	snd_hda_codec_write(codec, 0x21, 0,
+		    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+	msleep(delay);
+}
+
+static void alc_hp_enable_unmute(struct hda_codec *codec, unsigned int delay)
+{
+	if (delay <= 0)
+		delay = 75;
+	snd_hda_codec_write(codec, 0x21, 0,
+		    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+	msleep(delay);
+	snd_hda_codec_write(codec, 0x21, 0,
+		    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+	msleep(delay);
+}
+
 static const struct coef_fw alc225_pre_hsmode[] = {
 	UPDATE_COEF(0x4a, 1<<8, 0),
 	UPDATE_COEFEX(0x57, 0x05, 1<<14, 0),
@@ -5029,6 +5053,7 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 	case 0x10ec0236:
 	case 0x10ec0256:
 	case 0x19e58326:
+		alc_hp_mute_disable(codec, 75);
 		alc_process_coef_fw(codec, coef0256);
 		break;
 	case 0x10ec0234:
@@ -5063,6 +5088,7 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 	case 0x10ec0295:
 	case 0x10ec0289:
 	case 0x10ec0299:
+		alc_hp_mute_disable(codec, 75);
 		alc_process_coef_fw(codec, alc225_pre_hsmode);
 		alc_process_coef_fw(codec, coef0225);
 		break;
@@ -5288,6 +5314,7 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 	case 0x10ec0299:
 		alc_process_coef_fw(codec, alc225_pre_hsmode);
 		alc_process_coef_fw(codec, coef0225);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0255:
 		alc_process_coef_fw(codec, coef0255);
@@ -5300,6 +5327,7 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 		alc_write_coef_idx(codec, 0x45, 0xc089);
 		msleep(50);
 		alc_process_coef_fw(codec, coef0256);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
@@ -5397,6 +5425,7 @@ static void alc_headset_mode_ctia(struct hda_codec *codec)
 	case 0x10ec0256:
 	case 0x19e58326:
 		alc_process_coef_fw(codec, coef0256);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
@@ -5445,6 +5474,7 @@ static void alc_headset_mode_ctia(struct hda_codec *codec)
 			alc_process_coef_fw(codec, coef0225_2);
 		else
 			alc_process_coef_fw(codec, coef0225_1);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0867:
 		alc_update_coefex_idx(codec, 0x57, 0x5, 1<<14, 0);
@@ -5512,6 +5542,7 @@ static void alc_headset_mode_omtp(struct hda_codec *codec)
 	case 0x10ec0256:
 	case 0x19e58326:
 		alc_process_coef_fw(codec, coef0256);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
@@ -5549,6 +5580,7 @@ static void alc_headset_mode_omtp(struct hda_codec *codec)
 	case 0x10ec0289:
 	case 0x10ec0299:
 		alc_process_coef_fw(codec, coef0225);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	}
 	codec_dbg(codec, "Headset jack set to Nokia-style headset mode.\n");
@@ -5617,25 +5649,21 @@ static void alc_determine_headset_type(struct hda_codec *codec)
 		alc_write_coef_idx(codec, 0x06, 0x6104);
 		alc_write_coefex_idx(codec, 0x57, 0x3, 0x09a3);
 
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-		msleep(80);
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
-
 		alc_process_coef_fw(codec, coef0255);
 		msleep(300);
 		val = alc_read_coef_idx(codec, 0x46);
 		is_ctia = (val & 0x0070) == 0x0070;
-
+		if (!is_ctia) {
+			alc_write_coef_idx(codec, 0x45, 0xe089);
+			msleep(100);
+			val = alc_read_coef_idx(codec, 0x46);
+			if ((val & 0x0070) == 0x0070)
+				is_ctia = false;
+			else
+				is_ctia = true;
+		}
 		alc_write_coefex_idx(codec, 0x57, 0x3, 0x0da3);
 		alc_update_coefex_idx(codec, 0x57, 0x5, 1<<14, 0);
-
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
-		msleep(80);
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
@@ -5712,12 +5740,6 @@ static void alc_determine_headset_type(struct hda_codec *codec)
 	case 0x10ec0295:
 	case 0x10ec0289:
 	case 0x10ec0299:
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-		msleep(80);
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
-
 		alc_process_coef_fw(codec, alc225_pre_hsmode);
 		alc_update_coef_idx(codec, 0x67, 0xf000, 0x1000);
 		val = alc_read_coef_idx(codec, 0x45);
@@ -5734,15 +5756,19 @@ static void alc_determine_headset_type(struct hda_codec *codec)
 			val = alc_read_coef_idx(codec, 0x46);
 			is_ctia = (val & 0x00f0) == 0x00f0;
 		}
+		if (!is_ctia) {
+			alc_update_coef_idx(codec, 0x45, 0x3f<<10, 0x38<<10);
+			alc_update_coef_idx(codec, 0x49, 3<<8, 1<<8);
+			msleep(100);
+			val = alc_read_coef_idx(codec, 0x46);
+			if ((val & 0x00f0) == 0x00f0)
+				is_ctia = false;
+			else
+				is_ctia = true;
+		}
 		alc_update_coef_idx(codec, 0x4a, 7<<6, 7<<6);
 		alc_update_coef_idx(codec, 0x4a, 3<<4, 3<<4);
 		alc_update_coef_idx(codec, 0x67, 0xf000, 0x3000);
-
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
-		msleep(80);
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
 		break;
 	case 0x10ec0867:
 		is_ctia = true;
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index 972600d27158..c594af432b3e 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -152,6 +152,8 @@ static const struct platform_device_id board_ids[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, board_ids);
+
 static struct platform_driver acp_asoc_audio = {
 	.driver = {
 		.name = "sof_mach",
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 400eaf9f8b14..f185711180cb 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -44,6 +44,7 @@ static const struct platform_device_id db1200_pids[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(platform, db1200_pids);
 
 /*-------------------------  AC97 PART  ---------------------------*/
 
diff --git a/sound/soc/codecs/tda7419.c b/sound/soc/codecs/tda7419.c
index d964e5207569..6010df2994c7 100644
--- a/sound/soc/codecs/tda7419.c
+++ b/sound/soc/codecs/tda7419.c
@@ -623,6 +623,7 @@ static const struct of_device_id tda7419_of_match[] = {
 	{ .compatible = "st,tda7419" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, tda7419_of_match);
 
 static struct i2c_driver tda7419_driver = {
 	.driver = {
diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index 5e2ec60e2954..e4c3492a0c28 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -84,7 +84,6 @@ static const struct dmi_system_id lenovo_yoga_tab3_x90[] = {
 		/* Lenovo Yoga Tab 3 Pro YT3-X90, codec missing from DSDT */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
 		},
 	},
diff --git a/sound/soc/intel/keembay/kmb_platform.c b/sound/soc/intel/keembay/kmb_platform.c
index b4893365d01d..d5c48bed7a25 100644
--- a/sound/soc/intel/keembay/kmb_platform.c
+++ b/sound/soc/intel/keembay/kmb_platform.c
@@ -817,6 +817,7 @@ static const struct of_device_id kmb_plat_of_match[] = {
 	{ .compatible = "intel,keembay-tdm", .data = &intel_kmb_tdm_dai},
 	{}
 };
+MODULE_DEVICE_TABLE(of, kmb_plat_of_match);
 
 static int kmb_plat_dai_probe(struct platform_device *pdev)
 {
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 53cadbe8a05c..ac96ea07e591 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -663,6 +663,9 @@ static struct snd_sof_of_mach sof_mt8195_machs[] = {
 	{
 		.compatible = "google,tomato",
 		.sof_tplg_filename = "sof-mt8195-mt6359-rt1019-rt5682.tplg"
+	}, {
+		.compatible = "google,dojo",
+		.sof_tplg_filename = "sof-mt8195-mt6359-max98390-rt5682.tplg"
 	}, {
 		.compatible = "mediatek,mt8195",
 		.sof_tplg_filename = "sof-mt8195.tplg"
diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index fe770e679ae8..5643058e2d37 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -47,7 +47,7 @@ $(OUTPUT)hv_fcopy_daemon: $(HV_FCOPY_DAEMON_IN)
 
 clean:
 	rm -f $(ALL_PROGRAMS)
-	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(sbindir); \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 446b8daa23e0..ed7c0193ffc3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3048,7 +3048,9 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
+		if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
+			pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
+		fi
 		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1

