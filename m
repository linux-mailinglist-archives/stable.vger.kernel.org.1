Return-Path: <stable+bounces-106646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 193259FF92A
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 13:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C15C18830A2
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 12:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02078194C8B;
	Thu,  2 Jan 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KAbcbDYd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9930C7DA9C;
	Thu,  2 Jan 2025 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735819785; cv=none; b=klZKbtodSmgYm/WoDJ6T7IVyG5Dd0fovAu3f1Tdp9o1jPwWlE8CWAAAdTWLRWx0c1QJcebXhWDVbptH+LRzdZwj57+muw7g+/NOnPXQ2vdof0j+r9q5ZjDaobqdf4yFlHFRbLjKhQECtz/IAwZVadTKgZK46L3C/RLFbSzSrbqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735819785; c=relaxed/simple;
	bh=xJFW0PucgvSau4N2nvoTe48qd8dYYVIF0Pvr5UEeaRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poTX9F9m6oNsNR/+5Z5nA5N2XbiAB6xuW4NeMf+X8uDxgTdth6fdPfBZyzBTMbTJOd1+qA3x6Dck99O2oK+Iogjp+3zp16GkLuxc+pjoZp7L/Q/dJbCDJfj23Oda6YVIPdP13tf9p+tzd7mVSU56F1MlBVsxFIwKKzzt8OliBX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KAbcbDYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CF1C4CED0;
	Thu,  2 Jan 2025 12:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735819785;
	bh=xJFW0PucgvSau4N2nvoTe48qd8dYYVIF0Pvr5UEeaRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAbcbDYdgea3z2hJjemdMUf9PDLRPUIwkjEj/EDt1AijHaX1ipqltNou/hrhipeWO
	 lPNmFAq569IBHylPmNnUWsIfohBpxffZfouMk6JppV8XFTt+goBKucIIXMS9UoXRou
	 7YiW4/K/R7M801N6jEXKnPvYJOT5xrSuI5EYk94Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.123
Date: Thu,  2 Jan 2025 13:09:34 +0100
Message-ID: <2025010233-proponent-obstruct-ae82@gregkh>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025010233-oops-sasquatch-e108@gregkh>
References: <2025010233-oops-sasquatch-e108@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 23af31992b81..43ecffba11a6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 122
+SUBLEVEL = 123
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index dd6486097e1d..6468f1eb39f3 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -304,7 +304,7 @@ drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 ifdef CONFIG_64BIT
   ifndef KBUILD_SYM32
     ifeq ($(shell expr $(load-y) \< 0xffffffff80000000), 0)
-      KBUILD_SYM32 = y
+      KBUILD_SYM32 = $(call cc-option-yn, -msym32)
     endif
   endif
 
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 99eeafe6dcab..c60e72917a28 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -2078,7 +2078,14 @@ do {									\
 		_ASM_INSN_IF_MIPS(0x4200000c)				\
 		_ASM_INSN32_IF_MM(0x0000517c)
 #else	/* !TOOLCHAIN_SUPPORTS_VIRT */
-#define _ASM_SET_VIRT ".set\tvirt\n\t"
+#if MIPS_ISA_REV >= 5
+#define _ASM_SET_VIRT_ISA
+#elif defined(CONFIG_64BIT)
+#define _ASM_SET_VIRT_ISA ".set\tmips64r5\n\t"
+#else
+#define _ASM_SET_VIRT_ISA ".set\tmips32r5\n\t"
+#endif
+#define _ASM_SET_VIRT _ASM_SET_VIRT_ISA ".set\tvirt\n\t"
 #define _ASM_SET_MFGC0	_ASM_SET_VIRT
 #define _ASM_SET_DMFGC0	_ASM_SET_VIRT
 #define _ASM_SET_MTGC0	_ASM_SET_VIRT
@@ -2099,7 +2106,6 @@ do {									\
 ({ int __res;								\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
-		".set\tmips32r5\n\t"					\
 		_ASM_SET_MFGC0						\
 		"mfgc0\t%0, " #source ", %1\n\t"			\
 		_ASM_UNSET_MFGC0					\
@@ -2113,7 +2119,6 @@ do {									\
 ({ unsigned long long __res;						\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
-		".set\tmips64r5\n\t"					\
 		_ASM_SET_DMFGC0						\
 		"dmfgc0\t%0, " #source ", %1\n\t"			\
 		_ASM_UNSET_DMFGC0					\
@@ -2127,7 +2132,6 @@ do {									\
 do {									\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
-		".set\tmips32r5\n\t"					\
 		_ASM_SET_MTGC0						\
 		"mtgc0\t%z0, " #register ", %1\n\t"			\
 		_ASM_UNSET_MTGC0					\
@@ -2140,7 +2144,6 @@ do {									\
 do {									\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
-		".set\tmips64r5\n\t"					\
 		_ASM_SET_DMTGC0						\
 		"dmtgc0\t%z0, " #register ", %1\n\t"			\
 		_ASM_UNSET_DMTGC0					\
diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
index 92e60cb3163f..d954ddf7f059 100644
--- a/arch/powerpc/platforms/book3s/vas-api.c
+++ b/arch/powerpc/platforms/book3s/vas-api.c
@@ -464,7 +464,43 @@ static vm_fault_t vas_mmap_fault(struct vm_fault *vmf)
 	return VM_FAULT_SIGBUS;
 }
 
+/*
+ * During mmap() paste address, mapping VMA is saved in VAS window
+ * struct which is used to unmap during migration if the window is
+ * still open. But the user space can remove this mapping with
+ * munmap() before closing the window and the VMA address will
+ * be invalid. Set VAS window VMA to NULL in this function which
+ * is called before VMA free.
+ */
+static void vas_mmap_close(struct vm_area_struct *vma)
+{
+	struct file *fp = vma->vm_file;
+	struct coproc_instance *cp_inst = fp->private_data;
+	struct vas_window *txwin;
+
+	/* Should not happen */
+	if (!cp_inst || !cp_inst->txwin) {
+		pr_err("No attached VAS window for the paste address mmap\n");
+		return;
+	}
+
+	txwin = cp_inst->txwin;
+	/*
+	 * task_ref.vma is set in coproc_mmap() during mmap paste
+	 * address. So it has to be the same VMA that is getting freed.
+	 */
+	if (WARN_ON(txwin->task_ref.vma != vma)) {
+		pr_err("Invalid paste address mmaping\n");
+		return;
+	}
+
+	mutex_lock(&txwin->task_ref.mmap_mutex);
+	txwin->task_ref.vma = NULL;
+	mutex_unlock(&txwin->task_ref.mmap_mutex);
+}
+
 static const struct vm_operations_struct vas_vm_ops = {
+	.close = vas_mmap_close,
 	.fault = vas_mmap_fault,
 };
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a5ed12bd2b0a..373a67a630f3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3671,16 +3671,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
 {
 	hctx->queue_num = hctx_idx;
 
-	if (!(hctx->flags & BLK_MQ_F_STACKING))
-		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
-				&hctx->cpuhp_online);
-	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
-
 	hctx->tags = set->tags[hctx_idx];
 
 	if (set->ops->init_hctx &&
 	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
-		goto unregister_cpu_notifier;
+		goto fail;
 
 	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx,
 				hctx->numa_node))
@@ -3689,6 +3684,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (xa_insert(&q->hctx_table, hctx_idx, hctx, GFP_KERNEL))
 		goto exit_flush_rq;
 
+	if (!(hctx->flags & BLK_MQ_F_STACKING))
+		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+				&hctx->cpuhp_online);
+	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
+
 	return 0;
 
  exit_flush_rq:
@@ -3697,8 +3697,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
- unregister_cpu_notifier:
-	blk_mq_remove_cpuhp(hctx);
+ fail:
 	return -1;
 }
 
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e01bb359034b..3c44b0313a10 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2012,6 +2012,7 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 
 static void genpd_free_data(struct generic_pm_domain *genpd)
 {
+	put_device(&genpd->dev);
 	if (genpd_is_cpu_domain(genpd))
 		free_cpumask_var(genpd->cpus);
 	if (genpd->free_states)
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index c822af48d2c9..8748cea3bc38 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1155,13 +1155,13 @@ struct regmap *__regmap_init(struct device *dev,
 
 		/* Sanity check */
 		if (range_cfg->range_max < range_cfg->range_min) {
-			dev_err(map->dev, "Invalid range %d: %d < %d\n", i,
+			dev_err(map->dev, "Invalid range %d: %u < %u\n", i,
 				range_cfg->range_max, range_cfg->range_min);
 			goto err_range;
 		}
 
 		if (range_cfg->range_max > map->max_register) {
-			dev_err(map->dev, "Invalid range %d: %d > %d\n", i,
+			dev_err(map->dev, "Invalid range %d: %u > %u\n", i,
 				range_cfg->range_max, map->max_register);
 			goto err_range;
 		}
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 28644729dc97..0ba56caa41ef 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1201,9 +1201,12 @@ static void virtblk_remove(struct virtio_device *vdev)
 static int virtblk_freeze(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
+	struct request_queue *q = vblk->disk->queue;
 
 	/* Ensure no requests in virtqueues before deleting vqs. */
-	blk_mq_freeze_queue(vblk->disk->queue);
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue_nowait(q);
+	blk_mq_unfreeze_queue(q);
 
 	/* Ensure we don't receive any more interrupts */
 	virtio_reset_device(vdev);
@@ -1227,8 +1230,8 @@ static int virtblk_restore(struct virtio_device *vdev)
 		return ret;
 
 	virtio_device_ready(vdev);
+	blk_mq_unquiesce_queue(vblk->disk->queue);
 
-	blk_mq_unfreeze_queue(vblk->disk->queue);
 	return 0;
 }
 #endif
diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
index cac4532fe23a..1e6d13278c5a 100644
--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -152,6 +152,8 @@ static int admac_alloc_sram_carveout(struct admac_data *ad,
 {
 	struct admac_sram *sram;
 	int i, ret = 0, nblocks;
+	ad->txcache.size = readl_relaxed(ad->base + REG_TX_SRAM_SIZE);
+	ad->rxcache.size = readl_relaxed(ad->base + REG_RX_SRAM_SIZE);
 
 	if (dir == DMA_MEM_TO_DEV)
 		sram = &ad->txcache;
@@ -911,12 +913,7 @@ static int admac_probe(struct platform_device *pdev)
 		goto free_irq;
 	}
 
-	ad->txcache.size = readl_relaxed(ad->base + REG_TX_SRAM_SIZE);
-	ad->rxcache.size = readl_relaxed(ad->base + REG_RX_SRAM_SIZE);
-
 	dev_info(&pdev->dev, "Audio DMA Controller\n");
-	dev_info(&pdev->dev, "imprint %x TX cache %u RX cache %u\n",
-		 readl_relaxed(ad->base + REG_IMPRINT), ad->txcache.size, ad->rxcache.size);
 
 	return 0;
 
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 7919906b02e7..c457aaf15231 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1287,6 +1287,8 @@ at_xdmac_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 		return NULL;
 
 	desc = at_xdmac_memset_create_desc(chan, atchan, dest, len, value);
+	if (!desc)
+		return NULL;
 	list_add_tail(&desc->desc_node, &desc->descs_list);
 
 	desc->tx_dma_desc.cookie = -EBUSY;
diff --git a/drivers/dma/dw/acpi.c b/drivers/dma/dw/acpi.c
index c510c109d2c3..b6452fffa657 100644
--- a/drivers/dma/dw/acpi.c
+++ b/drivers/dma/dw/acpi.c
@@ -8,13 +8,15 @@
 
 static bool dw_dma_acpi_filter(struct dma_chan *chan, void *param)
 {
+	struct dw_dma *dw = to_dw_dma(chan->device);
+	struct dw_dma_chip_pdata *data = dev_get_drvdata(dw->dma.dev);
 	struct acpi_dma_spec *dma_spec = param;
 	struct dw_dma_slave slave = {
 		.dma_dev = dma_spec->dev,
 		.src_id = dma_spec->slave_id,
 		.dst_id = dma_spec->slave_id,
-		.m_master = 0,
-		.p_master = 1,
+		.m_master = data->m_master,
+		.p_master = data->p_master,
 	};
 
 	return dw_dma_filter(chan, &slave);
diff --git a/drivers/dma/dw/internal.h b/drivers/dma/dw/internal.h
index 563ce73488db..f1bd06a20cd6 100644
--- a/drivers/dma/dw/internal.h
+++ b/drivers/dma/dw/internal.h
@@ -51,11 +51,15 @@ struct dw_dma_chip_pdata {
 	int (*probe)(struct dw_dma_chip *chip);
 	int (*remove)(struct dw_dma_chip *chip);
 	struct dw_dma_chip *chip;
+	u8 m_master;
+	u8 p_master;
 };
 
 static __maybe_unused const struct dw_dma_chip_pdata dw_dma_chip_pdata = {
 	.probe = dw_dma_probe,
 	.remove = dw_dma_remove,
+	.m_master = 0,
+	.p_master = 1,
 };
 
 static const struct dw_dma_platform_data idma32_pdata = {
@@ -72,6 +76,8 @@ static __maybe_unused const struct dw_dma_chip_pdata idma32_chip_pdata = {
 	.pdata = &idma32_pdata,
 	.probe = idma32_dma_probe,
 	.remove = idma32_dma_remove,
+	.m_master = 0,
+	.p_master = 0,
 };
 
 static const struct dw_dma_platform_data xbar_pdata = {
@@ -88,6 +94,8 @@ static __maybe_unused const struct dw_dma_chip_pdata xbar_chip_pdata = {
 	.pdata = &xbar_pdata,
 	.probe = idma32_dma_probe,
 	.remove = idma32_dma_remove,
+	.m_master = 0,
+	.p_master = 0,
 };
 
 #endif /* _DMA_DW_INTERNAL_H */
diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
index ad2d4d012cf7..e8a0eb81726a 100644
--- a/drivers/dma/dw/pci.c
+++ b/drivers/dma/dw/pci.c
@@ -56,10 +56,10 @@ static int dw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
 	if (ret)
 		return ret;
 
-	dw_dma_acpi_controller_register(chip->dw);
-
 	pci_set_drvdata(pdev, data);
 
+	dw_dma_acpi_controller_register(chip->dw);
+
 	return 0;
 }
 
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 23b232b57518..ea48661e87ea 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1393,6 +1393,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 			irq = irq_of_parse_and_map(np, 0);
 			if (!irq) {
 				ret = -ENODEV;
+				of_node_put(np);
 				goto err_channel_add;
 			}
 
@@ -1401,6 +1402,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 			if (IS_ERR(chan)) {
 				ret = PTR_ERR(chan);
 				irq_dispose_mapping(irq);
+				of_node_put(np);
 				goto err_channel_add;
 			}
 
diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index e70b7c41dcab..7433d0da34f1 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -228,6 +228,7 @@ struct tegra_dma_channel {
 	bool config_init;
 	char name[30];
 	enum dma_transfer_direction sid_dir;
+	enum dma_status status;
 	int id;
 	int irq;
 	int slave_id;
@@ -389,6 +390,8 @@ static int tegra_dma_pause(struct tegra_dma_channel *tdc)
 		tegra_dma_dump_chan_regs(tdc);
 	}
 
+	tdc->status = DMA_PAUSED;
+
 	return ret;
 }
 
@@ -415,6 +418,8 @@ static void tegra_dma_resume(struct tegra_dma_channel *tdc)
 	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
 	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
 	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
+
+	tdc->status = DMA_IN_PROGRESS;
 }
 
 static int tegra_dma_device_resume(struct dma_chan *dc)
@@ -540,6 +545,7 @@ static void tegra_dma_xfer_complete(struct tegra_dma_channel *tdc)
 
 	tegra_dma_sid_free(tdc);
 	tdc->dma_desc = NULL;
+	tdc->status = DMA_COMPLETE;
 }
 
 static void tegra_dma_chan_decode_error(struct tegra_dma_channel *tdc,
@@ -712,6 +718,7 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 		tdc->dma_desc = NULL;
 	}
 
+	tdc->status = DMA_COMPLETE;
 	tegra_dma_sid_free(tdc);
 	vchan_get_all_descriptors(&tdc->vc, &head);
 	spin_unlock_irqrestore(&tdc->vc.lock, flags);
@@ -765,6 +772,9 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	if (ret == DMA_COMPLETE)
 		return ret;
 
+	if (tdc->status == DMA_PAUSED)
+		ret = DMA_PAUSED;
+
 	spin_lock_irqsave(&tdc->vc.lock, flags);
 	vd = vchan_find_desc(&tdc->vc, cookie);
 	if (vd) {
diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 4f8fcfaa80fd..d8cbb4eadc5b 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -4033,9 +4033,10 @@ static void drm_dp_mst_up_req_work(struct work_struct *work)
 static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 {
 	struct drm_dp_pending_up_req *up_req;
+	struct drm_dp_mst_branch *mst_primary;
 
 	if (!drm_dp_get_one_sb_msg(mgr, true, NULL))
-		goto out;
+		goto out_clear_reply;
 
 	if (!mgr->up_req_recv.have_eomt)
 		return 0;
@@ -4053,10 +4054,19 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 		drm_dbg_kms(mgr->dev, "Received unknown up req type, ignoring: %x\n",
 			    up_req->msg.req_type);
 		kfree(up_req);
-		goto out;
+		goto out_clear_reply;
+	}
+
+	mutex_lock(&mgr->lock);
+	mst_primary = mgr->mst_primary;
+	if (!mst_primary || !drm_dp_mst_topology_try_get_mstb(mst_primary)) {
+		mutex_unlock(&mgr->lock);
+		kfree(up_req);
+		goto out_clear_reply;
 	}
+	mutex_unlock(&mgr->lock);
 
-	drm_dp_send_up_ack_reply(mgr, mgr->mst_primary, up_req->msg.req_type,
+	drm_dp_send_up_ack_reply(mgr, mst_primary, up_req->msg.req_type,
 				 false);
 
 	if (up_req->msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
@@ -4073,13 +4083,13 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 			    conn_stat->peer_device_type);
 
 		mutex_lock(&mgr->probe_lock);
-		handle_csn = mgr->mst_primary->link_address_sent;
+		handle_csn = mst_primary->link_address_sent;
 		mutex_unlock(&mgr->probe_lock);
 
 		if (!handle_csn) {
 			drm_dbg_kms(mgr->dev, "Got CSN before finish topology probing. Skip it.");
 			kfree(up_req);
-			goto out;
+			goto out_put_primary;
 		}
 	} else if (up_req->msg.req_type == DP_RESOURCE_STATUS_NOTIFY) {
 		const struct drm_dp_resource_status_notify *res_stat =
@@ -4096,7 +4106,9 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 	mutex_unlock(&mgr->up_req_lock);
 	queue_work(system_long_wq, &mgr->up_req_work);
 
-out:
+out_put_primary:
+	drm_dp_mst_topology_put_mstb(mst_primary);
+out_clear_reply:
 	memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 0c203c614197..76d5b80abfc7 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -287,6 +287,7 @@ static const struct of_device_id i2c_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx6sll-i2c", .data = &imx6_i2c_hwdata, },
 	{ .compatible = "fsl,imx6sx-i2c", .data = &imx6_i2c_hwdata, },
 	{ .compatible = "fsl,imx6ul-i2c", .data = &imx6_i2c_hwdata, },
+	{ .compatible = "fsl,imx7d-i2c", .data = &imx6_i2c_hwdata, },
 	{ .compatible = "fsl,imx7s-i2c", .data = &imx6_i2c_hwdata, },
 	{ .compatible = "fsl,imx8mm-i2c", .data = &imx6_i2c_hwdata, },
 	{ .compatible = "fsl,imx8mn-i2c", .data = &imx6_i2c_hwdata, },
diff --git a/drivers/i2c/busses/i2c-microchip-corei2c.c b/drivers/i2c/busses/i2c-microchip-corei2c.c
index 4d7e9b25f018..71edb0d38e6a 100644
--- a/drivers/i2c/busses/i2c-microchip-corei2c.c
+++ b/drivers/i2c/busses/i2c-microchip-corei2c.c
@@ -93,27 +93,35 @@
  * @base:		pointer to register struct
  * @dev:		device reference
  * @i2c_clk:		clock reference for i2c input clock
+ * @msg_queue:		pointer to the messages requiring sending
  * @buf:		pointer to msg buffer for easier use
  * @msg_complete:	xfer completion object
  * @adapter:		core i2c abstraction
  * @msg_err:		error code for completed message
  * @bus_clk_rate:	current i2c bus clock rate
  * @isr_status:		cached copy of local ISR status
+ * @total_num:		total number of messages to be sent/received
+ * @current_num:	index of the current message being sent/received
  * @msg_len:		number of bytes transferred in msg
  * @addr:		address of the current slave
+ * @restart_needed:	whether or not a repeated start is required after current message
  */
 struct mchp_corei2c_dev {
 	void __iomem *base;
 	struct device *dev;
 	struct clk *i2c_clk;
+	struct i2c_msg *msg_queue;
 	u8 *buf;
 	struct completion msg_complete;
 	struct i2c_adapter adapter;
 	int msg_err;
+	int total_num;
+	int current_num;
 	u32 bus_clk_rate;
 	u32 isr_status;
 	u16 msg_len;
 	u8 addr;
+	bool restart_needed;
 };
 
 static void mchp_corei2c_core_disable(struct mchp_corei2c_dev *idev)
@@ -222,6 +230,47 @@ static int mchp_corei2c_fill_tx(struct mchp_corei2c_dev *idev)
 	return 0;
 }
 
+static void mchp_corei2c_next_msg(struct mchp_corei2c_dev *idev)
+{
+	struct i2c_msg *this_msg;
+	u8 ctrl;
+
+	if (idev->current_num >= idev->total_num) {
+		complete(&idev->msg_complete);
+		return;
+	}
+
+	/*
+	 * If there's been an error, the isr needs to return control
+	 * to the "main" part of the driver, so as not to keep sending
+	 * messages once it completes and clears the SI bit.
+	 */
+	if (idev->msg_err) {
+		complete(&idev->msg_complete);
+		return;
+	}
+
+	this_msg = idev->msg_queue++;
+
+	if (idev->current_num < (idev->total_num - 1)) {
+		struct i2c_msg *next_msg = idev->msg_queue;
+
+		idev->restart_needed = next_msg->flags & I2C_M_RD;
+	} else {
+		idev->restart_needed = false;
+	}
+
+	idev->addr = i2c_8bit_addr_from_msg(this_msg);
+	idev->msg_len = this_msg->len;
+	idev->buf = this_msg->buf;
+
+	ctrl = readb(idev->base + CORE_I2C_CTRL);
+	ctrl |= CTRL_STA;
+	writeb(ctrl, idev->base + CORE_I2C_CTRL);
+
+	idev->current_num++;
+}
+
 static irqreturn_t mchp_corei2c_handle_isr(struct mchp_corei2c_dev *idev)
 {
 	u32 status = idev->isr_status;
@@ -238,8 +287,6 @@ static irqreturn_t mchp_corei2c_handle_isr(struct mchp_corei2c_dev *idev)
 		ctrl &= ~CTRL_STA;
 		writeb(idev->addr, idev->base + CORE_I2C_DATA);
 		writeb(ctrl, idev->base + CORE_I2C_CTRL);
-		if (idev->msg_len == 0)
-			finished = true;
 		break;
 	case STATUS_M_ARB_LOST:
 		idev->msg_err = -EAGAIN;
@@ -247,10 +294,14 @@ static irqreturn_t mchp_corei2c_handle_isr(struct mchp_corei2c_dev *idev)
 		break;
 	case STATUS_M_SLAW_ACK:
 	case STATUS_M_TX_DATA_ACK:
-		if (idev->msg_len > 0)
+		if (idev->msg_len > 0) {
 			mchp_corei2c_fill_tx(idev);
-		else
-			last_byte = true;
+		} else {
+			if (idev->restart_needed)
+				finished = true;
+			else
+				last_byte = true;
+		}
 		break;
 	case STATUS_M_TX_DATA_NACK:
 	case STATUS_M_SLAR_NACK:
@@ -287,7 +338,7 @@ static irqreturn_t mchp_corei2c_handle_isr(struct mchp_corei2c_dev *idev)
 		mchp_corei2c_stop(idev);
 
 	if (last_byte || finished)
-		complete(&idev->msg_complete);
+		mchp_corei2c_next_msg(idev);
 
 	return IRQ_HANDLED;
 }
@@ -311,21 +362,48 @@ static irqreturn_t mchp_corei2c_isr(int irq, void *_dev)
 	return ret;
 }
 
-static int mchp_corei2c_xfer_msg(struct mchp_corei2c_dev *idev,
-				 struct i2c_msg *msg)
+static int mchp_corei2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			     int num)
 {
-	u8 ctrl;
+	struct mchp_corei2c_dev *idev = i2c_get_adapdata(adap);
+	struct i2c_msg *this_msg = msgs;
 	unsigned long time_left;
+	u8 ctrl;
+
+	mchp_corei2c_core_enable(idev);
+
+	/*
+	 * The isr controls the flow of a transfer, this info needs to be saved
+	 * to a location that it can access the queue information from.
+	 */
+	idev->restart_needed = false;
+	idev->msg_queue = msgs;
+	idev->total_num = num;
+	idev->current_num = 0;
 
-	idev->addr = i2c_8bit_addr_from_msg(msg);
-	idev->msg_len = msg->len;
-	idev->buf = msg->buf;
+	/*
+	 * But the first entry to the isr is triggered by the start in this
+	 * function, so the first message needs to be "dequeued".
+	 */
+	idev->addr = i2c_8bit_addr_from_msg(this_msg);
+	idev->msg_len = this_msg->len;
+	idev->buf = this_msg->buf;
 	idev->msg_err = 0;
 
-	reinit_completion(&idev->msg_complete);
+	if (idev->total_num > 1) {
+		struct i2c_msg *next_msg = msgs + 1;
 
-	mchp_corei2c_core_enable(idev);
+		idev->restart_needed = next_msg->flags & I2C_M_RD;
+	}
 
+	idev->current_num++;
+	idev->msg_queue++;
+
+	reinit_completion(&idev->msg_complete);
+
+	/*
+	 * Send the first start to pass control to the isr
+	 */
 	ctrl = readb(idev->base + CORE_I2C_CTRL);
 	ctrl |= CTRL_STA;
 	writeb(ctrl, idev->base + CORE_I2C_CTRL);
@@ -335,20 +413,8 @@ static int mchp_corei2c_xfer_msg(struct mchp_corei2c_dev *idev,
 	if (!time_left)
 		return -ETIMEDOUT;
 
-	return idev->msg_err;
-}
-
-static int mchp_corei2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
-			     int num)
-{
-	struct mchp_corei2c_dev *idev = i2c_get_adapdata(adap);
-	int i, ret;
-
-	for (i = 0; i < num; i++) {
-		ret = mchp_corei2c_xfer_msg(idev, msgs++);
-		if (ret)
-			return ret;
-	}
+	if (idev->msg_err)
+		return idev->msg_err;
 
 	return num;
 }
diff --git a/drivers/media/dvb-frontends/dib3000mb.c b/drivers/media/dvb-frontends/dib3000mb.c
index c598b2a63325..7c452ddd9e40 100644
--- a/drivers/media/dvb-frontends/dib3000mb.c
+++ b/drivers/media/dvb-frontends/dib3000mb.c
@@ -51,7 +51,7 @@ MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=setfe,8=getfe (|-a
 static int dib3000_read_reg(struct dib3000_state *state, u16 reg)
 {
 	u8 wb[] = { ((reg >> 8) | 0x80) & 0xff, reg & 0xff };
-	u8 rb[2];
+	u8 rb[2] = {};
 	struct i2c_msg msg[] = {
 		{ .addr = state->config.demod_address, .flags = 0,        .buf = wb, .len = 2 },
 		{ .addr = state->config.demod_address, .flags = I2C_M_RD, .buf = rb, .len = 2 },
diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
index e6ffe87a599e..864c0524c9ea 100644
--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -1425,8 +1425,8 @@ static int anfc_parse_cs(struct arasan_nfc *nfc)
 	 * case, the "not" chosen CS is assigned to nfc->spare_cs and selected
 	 * whenever a GPIO CS must be asserted.
 	 */
-	if (nfc->cs_array && nfc->ncs > 2) {
-		if (!nfc->cs_array[0] && !nfc->cs_array[1]) {
+	if (nfc->cs_array) {
+		if (nfc->ncs > 2 && !nfc->cs_array[0] && !nfc->cs_array[1]) {
 			dev_err(nfc->dev,
 				"Assign a single native CS when using GPIOs\n");
 			return -EINVAL;
@@ -1510,8 +1510,15 @@ static int anfc_probe(struct platform_device *pdev)
 
 static int anfc_remove(struct platform_device *pdev)
 {
+	int i;
 	struct arasan_nfc *nfc = platform_get_drvdata(pdev);
 
+	for (i = 0; i < nfc->ncs; i++) {
+		if (nfc->cs_array[i]) {
+			gpiod_put(nfc->cs_array[i]);
+		}
+	}
+
 	anfc_chips_cleanup(nfc);
 
 	clk_disable_unprepare(nfc->bus_clk);
diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index a22aab4ed4e8..3c7dee1be21d 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -380,10 +380,8 @@ atmel_pmecc_create_user(struct atmel_pmecc *pmecc,
 	user->delta = user->dmu + req->ecc.strength + 1;
 
 	gf_tables = atmel_pmecc_get_gf_tables(req);
-	if (IS_ERR(gf_tables)) {
-		kfree(user);
+	if (IS_ERR(gf_tables))
 		return ERR_CAST(gf_tables);
-	}
 
 	user->gf_tables = gf_tables;
 
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 2068025d5639..594e13a852c4 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -1098,7 +1098,7 @@ static inline int __init inftl_partscan(struct mtd_info *mtd, struct mtd_partiti
 		    (i == 0) && (ip->firstUnit > 0)) {
 			parts[0].name = " DiskOnChip IPL / Media Header partition";
 			parts[0].offset = 0;
-			parts[0].size = mtd->erasesize * ip->firstUnit;
+			parts[0].size = (uint64_t)mtd->erasesize * ip->firstUnit;
 			numparts = 1;
 		}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 385904502a6b..8ee6a81b42b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5980,7 +5980,9 @@ static void mlx5e_remove(struct auxiliary_device *adev)
 	mlx5e_dcbnl_delete_app(priv);
 	unregister_netdev(priv->netdev);
 	mlx5e_suspend(adev, state);
-	priv->profile->cleanup(priv);
+	/* Avoid cleanup if profile rollback failed. */
+	if (priv->profile)
+		priv->profile->cleanup(priv);
 	mlx5e_devlink_port_unregister(priv);
 	mlx5e_destroy_netdev(priv);
 }
diff --git a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
index 3b374b37b965..1bc9557c5806 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
@@ -309,6 +309,12 @@ static void usb_init_common_7216(struct brcm_usb_init_params *params)
 	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 
 	USB_CTRL_UNSET(ctrl, USB_PM, XHC_S2_CLK_SWITCH_EN);
+
+	/*
+	 * The PHY might be in a bad state if it is already powered
+	 * up. Toggle the power just in case.
+	 */
+	USB_CTRL_SET(ctrl, USB_PM, USB_PWRDN);
 	USB_CTRL_UNSET(ctrl, USB_PM, USB_PWRDN);
 
 	/* 1 millisecond - for USB clocks to settle down */
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index d93ddf1262c5..0730fe80dc3c 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -138,8 +138,10 @@ static struct phy_provider *of_phy_provider_lookup(struct device_node *node)
 			return phy_provider;
 
 		for_each_child_of_node(phy_provider->children, child)
-			if (child == node)
+			if (child == node) {
+				of_node_put(child);
 				return phy_provider;
+			}
 	}
 
 	return ERR_PTR(-EPROBE_DEFER);
@@ -575,8 +577,10 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 		return ERR_PTR(-ENODEV);
 
 	/* This phy type handled by the usb-phy subsystem for now */
-	if (of_device_is_compatible(args.np, "usb-nop-xceiv"))
-		return ERR_PTR(-ENODEV);
+	if (of_device_is_compatible(args.np, "usb-nop-xceiv")) {
+		phy = ERR_PTR(-ENODEV);
+		goto out_put_node;
+	}
 
 	mutex_lock(&phy_provider_mutex);
 	phy_provider = of_phy_provider_lookup(args.np);
@@ -598,6 +602,7 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 
 out_unlock:
 	mutex_unlock(&phy_provider_mutex);
+out_put_node:
 	of_node_put(args.np);
 
 	return phy;
@@ -683,7 +688,7 @@ void devm_phy_put(struct device *dev, struct phy *phy)
 	if (!phy)
 		return;
 
-	r = devres_destroy(dev, devm_phy_release, devm_phy_match, phy);
+	r = devres_release(dev, devm_phy_release, devm_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_phy_put);
@@ -1056,7 +1061,7 @@ void devm_phy_destroy(struct device *dev, struct phy *phy)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_phy_consume, devm_phy_match, phy);
+	r = devres_release(dev, devm_phy_consume, devm_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_phy_destroy);
@@ -1194,12 +1199,12 @@ EXPORT_SYMBOL_GPL(of_phy_provider_unregister);
  * of_phy_provider_unregister to unregister the phy provider.
  */
 void devm_of_phy_provider_unregister(struct device *dev,
-	struct phy_provider *phy_provider)
+				     struct phy_provider *phy_provider)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_phy_provider_release, devm_phy_match,
-		phy_provider);
+	r = devres_release(dev, devm_phy_provider_release, devm_phy_match,
+			   phy_provider);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY provider device resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_provider_unregister);
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index f0ba35bb73c1..605591314f25 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1393,7 +1393,7 @@ static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_rx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
-	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FO_GAIN, 0x0a),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL1, 0x54),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x0f),
 	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 7b213825fb5d..d97a7164c496 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -299,7 +299,7 @@ static int rockchip_combphy_parse_dt(struct device *dev, struct rockchip_combphy
 
 	priv->ext_refclk = device_property_present(dev, "rockchip,ext-refclk");
 
-	priv->phy_rst = devm_reset_control_array_get_exclusive(dev);
+	priv->phy_rst = devm_reset_control_get(dev, "phy");
 	if (IS_ERR(priv->phy_rst))
 		return dev_err_probe(dev, PTR_ERR(priv->phy_rst), "failed to get phy reset\n");
 
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index af3da303e2b1..cba515ce3444 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -590,6 +590,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
+	{ KE_IGNORE, 0xCF, },	/* AC mode */
 	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
 	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on ROG xflow laptops */
 	{ KE_END, 0},
diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 68212b39785b..6139f736ecbe 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -67,6 +67,14 @@ static int set_charge_current_limit(struct gpio_charger *gpio_charger, int val)
 		if (gpio_charger->current_limit_map[i].limit_ua <= val)
 			break;
 	}
+
+	/*
+	 * If a valid charge current limit isn't found, default to smallest
+	 * current limitation for safety reasons.
+	 */
+	if (i >= gpio_charger->current_limit_map_size)
+		i = gpio_charger->current_limit_map_size - 1;
+
 	mapping = gpio_charger->current_limit_map[i];
 
 	for (i = 0; i < ndescs; i++) {
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 37208bc08c66..f4b32ce45ce0 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -8905,8 +8905,11 @@ megasas_aen_polling(struct work_struct *work)
 						   (ld_target_id / MEGASAS_MAX_DEV_PER_CHANNEL),
 						   (ld_target_id % MEGASAS_MAX_DEV_PER_CHANNEL),
 						   0);
-			if (sdev1)
+			if (sdev1) {
+				mutex_unlock(&instance->reset_mutex);
 				megasas_remove_scsi_device(sdev1);
+				mutex_lock(&instance->reset_mutex);
+			}
 
 			event_type = SCAN_VD_CHANNEL;
 			break;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 03fcaf735939..5c13358416c4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -7061,11 +7061,12 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
 	int i;
 	u8 failed;
 	__le32 *mfp;
+	int ret_val;
 
 	/* make sure doorbell is not in use */
 	if ((ioc->base_readl_ext_retry(&ioc->chip->Doorbell) & MPI2_DOORBELL_USED)) {
 		ioc_err(ioc, "doorbell is in use (line=%d)\n", __LINE__);
-		return -EFAULT;
+		goto doorbell_diag_reset;
 	}
 
 	/* clear pending doorbell interrupts from previous state changes */
@@ -7155,6 +7156,10 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
 			    le32_to_cpu(mfp[i]));
 	}
 	return 0;
+
+doorbell_diag_reset:
+	ret_val = _base_diag_reset(ioc);
+	return ret_val;
 }
 
 /**
diff --git a/drivers/scsi/qla1280.h b/drivers/scsi/qla1280.h
index d309e2ca14de..dea2290b37d4 100644
--- a/drivers/scsi/qla1280.h
+++ b/drivers/scsi/qla1280.h
@@ -116,12 +116,12 @@ struct device_reg {
 	uint16_t id_h;		/* ID high */
 	uint16_t cfg_0;		/* Configuration 0 */
 #define ISP_CFG0_HWMSK   0x000f	/* Hardware revision mask */
-#define ISP_CFG0_1020    BIT_0	/* ISP1020 */
-#define ISP_CFG0_1020A	 BIT_1	/* ISP1020A */
-#define ISP_CFG0_1040	 BIT_2	/* ISP1040 */
-#define ISP_CFG0_1040A	 BIT_3	/* ISP1040A */
-#define ISP_CFG0_1040B	 BIT_4	/* ISP1040B */
-#define ISP_CFG0_1040C	 BIT_5	/* ISP1040C */
+#define ISP_CFG0_1020	 1	/* ISP1020 */
+#define ISP_CFG0_1020A	 2	/* ISP1020A */
+#define ISP_CFG0_1040	 3	/* ISP1040 */
+#define ISP_CFG0_1040A	 4	/* ISP1040A */
+#define ISP_CFG0_1040B	 5	/* ISP1040B */
+#define ISP_CFG0_1040C	 6	/* ISP1040C */
 	uint16_t cfg_1;		/* Configuration 1 */
 #define ISP_CFG1_F128    BIT_6  /* 128-byte FIFO threshold */
 #define ISP_CFG1_F64     BIT_4|BIT_5 /* 128-byte FIFO threshold */
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 4fad9d85bd6f..0685cbe7f0eb 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -149,6 +149,8 @@ struct hv_fc_wwn_packet {
 */
 static int vmstor_proto_version;
 
+static bool hv_dev_is_fc(struct hv_device *hv_dev);
+
 #define STORVSC_LOGGING_NONE	0
 #define STORVSC_LOGGING_ERROR	1
 #define STORVSC_LOGGING_WARN	2
@@ -1129,6 +1131,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 	 * not correctly handle:
 	 * INQUIRY command with page code parameter set to 0x80
 	 * MODE_SENSE command with cmd[2] == 0x1c
+	 * MAINTENANCE_IN is not supported by HyperV FC passthrough
 	 *
 	 * Setup srb and scsi status so this won't be fatal.
 	 * We do this so we can distinguish truly fatal failues
@@ -1136,7 +1139,9 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 	 */
 
 	if ((stor_pkt->vm_srb.cdb[0] == INQUIRY) ||
-	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE)) {
+	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE) ||
+	   (stor_pkt->vm_srb.cdb[0] == MAINTENANCE_IN &&
+	   hv_dev_is_fc(device))) {
 		vstor_packet->vm_srb.scsi_status = 0;
 		vstor_packet->vm_srb.srb_status = SRB_STATUS_SUCCESS;
 	}
diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index 843f9f8e3917..239947df613d 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -20,6 +20,8 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bits.h>
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -40,6 +42,7 @@
 #define VAL		0x2f
 
 /* Logical device Numbers LDN */
+#define EC		0x04
 #define GPIO		0x07
 
 /* Configuration Registers and Functions */
@@ -71,6 +74,12 @@
 #define IT8784_ID	0x8784
 #define IT8786_ID	0x8786
 
+/* Environment Controller Configuration Registers LDN=0x04 */
+#define SCR1		0xfa
+
+/* Environment Controller Bits SCR1 */
+#define WDT_PWRGD	0x20
+
 /* GPIO Configuration Registers LDN=0x07 */
 #define WDTCTRL		0x71
 #define WDTCFG		0x72
@@ -233,6 +242,21 @@ static int wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
 	return ret;
 }
 
+enum {
+	IT87_WDT_OUTPUT_THROUGH_PWRGD	= BIT(0),
+};
+
+static const struct dmi_system_id it87_quirks[] = {
+	{
+		/* Qotom Q30900P (IT8786) */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "QCML04"),
+		},
+		.driver_data = (void *)IT87_WDT_OUTPUT_THROUGH_PWRGD,
+	},
+	{}
+};
+
 static const struct watchdog_info ident = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
 	.firmware_version = 1,
@@ -254,8 +278,10 @@ static struct watchdog_device wdt_dev = {
 
 static int __init it87_wdt_init(void)
 {
+	const struct dmi_system_id *dmi_id;
 	u8  chip_rev;
 	u8 ctrl;
+	int quirks = 0;
 	int rc;
 
 	rc = superio_enter();
@@ -266,6 +292,10 @@ static int __init it87_wdt_init(void)
 	chip_rev  = superio_inb(CHIPREV) & 0x0f;
 	superio_exit();
 
+	dmi_id = dmi_first_match(it87_quirks);
+	if (dmi_id)
+		quirks = (long)dmi_id->driver_data;
+
 	switch (chip_type) {
 	case IT8702_ID:
 		max_units = 255;
@@ -326,6 +356,15 @@ static int __init it87_wdt_init(void)
 		superio_outb(0x00, WDTCTRL);
 	}
 
+	if (quirks & IT87_WDT_OUTPUT_THROUGH_PWRGD) {
+		superio_select(EC);
+		ctrl = superio_inb(SCR1);
+		if (!(ctrl & WDT_PWRGD)) {
+			ctrl |= WDT_PWRGD;
+			superio_outb(ctrl, SCR1);
+		}
+	}
+
 	superio_exit();
 
 	if (timeout < 1 || timeout > max_units * 60) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eb5f03c3336c..16789490078f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7387,6 +7387,8 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			ret = -EAGAIN;
 			goto out;
 		}
+
+		cond_resched();
 	}
 
 	if (orig_start)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index fc468d1079c2..44a94ac21e2f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -971,7 +971,7 @@ static ssize_t btrfs_nodesize_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return sysfs_emit(buf, "%u\n", fs_info->super_copy->nodesize);
+	return sysfs_emit(buf, "%u\n", fs_info->nodesize);
 }
 
 BTRFS_ATTR(, nodesize, btrfs_nodesize_show);
@@ -981,7 +981,7 @@ static ssize_t btrfs_sectorsize_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return sysfs_emit(buf, "%u\n", fs_info->super_copy->sectorsize);
+	return sysfs_emit(buf, "%u\n", fs_info->sectorsize);
 }
 
 BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
@@ -1033,7 +1033,7 @@ static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return sysfs_emit(buf, "%u\n", fs_info->super_copy->sectorsize);
+	return sysfs_emit(buf, "%u\n", fs_info->sectorsize);
 }
 
 BTRFS_ATTR(, clone_alignment, btrfs_clone_alignment_show);
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index a6dc8c479a4b..d2885dd4822d 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -986,7 +986,7 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 		args.authflavor = clp->cl_cred.cr_flavor;
 		clp->cl_cb_ident = conn->cb_ident;
 	} else {
-		if (!conn->cb_xprt)
+		if (!conn->cb_xprt || !ses)
 			return -EINVAL;
 		clp->cl_cb_session = ses;
 		args.bc_xprt = conn->cb_xprt;
@@ -1379,8 +1379,6 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 		ses = c->cn_session;
 	}
 	spin_unlock(&clp->cl_lock);
-	if (!c)
-		return;
 
 	err = setup_callback_client(clp, &conn, ses);
 	if (err) {
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8bceae771c1c..f6fa719ee326 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8208,7 +8208,7 @@ nfs4_state_shutdown_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	unregister_shrinker(&nn->nfsd_client_shrinker);
-	cancel_work(&nn->nfsd_shrinker_work);
+	cancel_work_sync(&nn->nfsd_shrinker_work);
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
 
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index bdcdc0fc9cad..7134abeeb53e 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -18,8 +18,8 @@
 #include "mgmt/share_config.h"
 
 /*for shortname implementation */
-static const char basechars[43] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_-!@#$%";
-#define MANGLE_BASE (sizeof(basechars) / sizeof(char) - 1)
+static const char *basechars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_-!@#$%";
+#define MANGLE_BASE (strlen(basechars) - 1)
 #define MAGIC_CHAR '~'
 #define PERIOD '.'
 #define mangle(V) ((char)(basechars[(V) % MANGLE_BASE]))
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0cac69902ec5..e87a68b136da 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1663,15 +1663,16 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(TASK_REPORT_MAX);
 
-	if (tsk_state == TASK_IDLE)
+	if ((tsk_state & TASK_IDLE) == TASK_IDLE)
 		state = TASK_REPORT_IDLE;
 
 	/*
 	 * We're lying here, but rather than expose a completely new task state
 	 * to userspace, we can make this appear as if the task has gone through
 	 * a regular rt_mutex_lock() call.
+	 * Report frozen tasks as uninterruptible.
 	 */
-	if (tsk_state == TASK_RTLOCK_WAIT)
+	if ((tsk_state & TASK_RTLOCK_WAIT) || (tsk_state & TASK_FROZEN))
 		state = TASK_UNINTERRUPTIBLE;
 
 	return fls(state);
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 062fe440f5d0..6ccfd9236387 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -308,17 +308,22 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
-static inline void sk_psock_queue_msg(struct sk_psock *psock,
+static inline bool sk_psock_queue_msg(struct sk_psock *psock,
 				      struct sk_msg *msg)
 {
+	bool ret;
+
 	spin_lock_bh(&psock->ingress_lock);
-	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
+	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 		list_add_tail(&msg->list, &psock->ingress_msg);
-	else {
+		ret = true;
+	} else {
 		sk_msg_free(psock->sk, msg);
 		kfree(msg);
+		ret = false;
 	}
 	spin_unlock_bh(&psock->ingress_lock);
+	return ret;
 }
 
 static inline struct sk_msg *sk_psock_dequeue_msg(struct sk_psock *psock)
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index f70624ec4188..f042574d1fb6 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -355,7 +355,7 @@ struct trace_event_call {
 	struct list_head	list;
 	struct trace_event_class *class;
 	union {
-		char			*name;
+		const char		*name;
 		/* Set TRACE_EVENT_FL_TRACEPOINT flag when using "tp" */
 		struct tracepoint	*tp;
 	};
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 19cf5b6892ce..4fb5fa0cc84e 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -513,7 +513,7 @@ static inline const char *node_stat_name(enum node_stat_item item)
 
 static inline const char *lru_list_name(enum lru_list lru)
 {
-	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
+	return node_stat_name(NR_LRU_BASE + (enum node_stat_item)lru) + 3; // skip "nr_"
 }
 
 static inline const char *writeback_stat_name(enum writeback_stat_item item)
diff --git a/include/net/sock.h b/include/net/sock.h
index 0a06c997b45b..e716b2ba00bb 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1660,7 +1660,7 @@ static inline bool sk_wmem_schedule(struct sock *sk, int size)
 }
 
 static inline bool
-sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
+__sk_rmem_schedule(struct sock *sk, int size, bool pfmemalloc)
 {
 	int delta;
 
@@ -1668,7 +1668,13 @@ sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
 		return true;
 	delta = size - sk->sk_forward_alloc;
 	return delta <= 0 || __sk_mem_schedule(sk, delta, SK_MEM_RECV) ||
-		skb_pfmemalloc(skb);
+	       pfmemalloc;
+}
+
+static inline bool
+sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
+{
+	return __sk_rmem_schedule(sk, size, skb_pfmemalloc(skb));
 }
 
 static inline int sk_unused_reserved_mem(const struct sock *sk)
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index dcd50fb2164a..ef892cb1cbb7 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -8,6 +8,13 @@
 #define __always_inline inline
 #endif
 
+/* Not all C++ standards support type declarations inside an anonymous union */
+#ifndef __cplusplus
+#define __struct_group_tag(TAG)		TAG
+#else
+#define __struct_group_tag(TAG)
+#endif
+
 /**
  * __struct_group() - Create a mirrored named and anonyomous struct
  *
@@ -20,13 +27,13 @@
  * and size: one anonymous and one named. The former's members can be used
  * normally without sub-struct naming, and the latter can be used to
  * reason about the start, end, and size of the group of struct members.
- * The named struct can also be explicitly tagged for layer reuse, as well
- * as both having struct attributes appended.
+ * The named struct can also be explicitly tagged for layer reuse (C only),
+ * as well as both having struct attributes appended.
  */
 #define __struct_group(TAG, NAME, ATTRS, MEMBERS...) \
 	union { \
 		struct { MEMBERS } ATTRS; \
-		struct TAG { MEMBERS } ATTRS NAME; \
+		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
 	} ATTRS
 
 /**
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 3331daa0aae3..0d66bef60285 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -345,6 +345,7 @@ int io_sqpoll_wait_sq(struct io_ring_ctx *ctx)
 __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 				struct io_uring_params *p)
 {
+	struct task_struct *task_to_put = NULL;
 	int ret;
 
 	/* Retain compatibility with failing for an invalid attach attempt */
@@ -425,6 +426,7 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		}
 
 		sqd->thread = tsk;
+		task_to_put = get_task_struct(tsk);
 		ret = io_uring_alloc_task_context(tsk, ctx);
 		wake_up_new_task(tsk);
 		if (ret)
@@ -435,11 +437,15 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		goto err;
 	}
 
+	if (task_to_put)
+		put_task_struct(task_to_put);
 	return 0;
 err_sqpoll:
 	complete(&ctx->sq_data->exited);
 err:
 	io_sq_thread_finish(ctx);
+	if (task_to_put)
+		put_task_struct(task_to_put);
 	return ret;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f9906e5ad2e5..6455f80099cd 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2816,16 +2816,21 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 {
 	const struct bpf_link *link = filp->private_data;
 	const struct bpf_prog *prog = link->prog;
+	enum bpf_link_type type = link->type;
 	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
 
+	if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
+		seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
+	} else {
+		WARN_ONCE(1, "missing BPF_LINK_TYPE(...) for link type %u\n", type);
+		seq_printf(m, "link_type:\t<%u>\n", type);
+	}
+	seq_printf(m, "link_id:\t%u\n", link->id);
+
 	bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
 	seq_printf(m,
-		   "link_type:\t%s\n"
-		   "link_id:\t%u\n"
 		   "prog_tag:\t%s\n"
 		   "prog_id:\t%u\n",
-		   bpf_link_type_strs[link->type],
-		   link->id,
 		   prog_tag,
 		   prog->aux->id);
 	if (link->ops->show_fdinfo)
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 46b207eac171..bb6b037ef30f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -31,7 +31,6 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @barrier_q_head: RCU callback for barrier operation.
  * @rtp_blkd_tasks: List of tasks blocked as readers.
  * @cpu: CPU number corresponding to this entry.
- * @index: Index of this CPU in rtpcp_array of the rcu_tasks structure.
  * @rtpp: Pointer to the rcu_tasks structure.
  */
 struct rcu_tasks_percpu {
@@ -44,7 +43,6 @@ struct rcu_tasks_percpu {
 	struct rcu_head barrier_q_head;
 	struct list_head rtp_blkd_tasks;
 	int cpu;
-	int index;
 	struct rcu_tasks *rtpp;
 };
 
@@ -70,7 +68,6 @@ struct rcu_tasks_percpu {
  * @postgp_func: This flavor's post-grace-period function (optional).
  * @call_func: This flavor's call_rcu()-equivalent function.
  * @rtpcpu: This flavor's rcu_tasks_percpu structure.
- * @rtpcp_array: Array of pointers to rcu_tasks_percpu structure of CPUs in cpu_possible_mask.
  * @percpu_enqueue_shift: Shift down CPU ID this much when enqueuing callbacks.
  * @percpu_enqueue_lim: Number of per-CPU callback queues in use for enqueuing.
  * @percpu_dequeue_lim: Number of per-CPU callback queues in use for dequeuing.
@@ -103,7 +100,6 @@ struct rcu_tasks {
 	postgp_func_t postgp_func;
 	call_rcu_func_t call_func;
 	struct rcu_tasks_percpu __percpu *rtpcpu;
-	struct rcu_tasks_percpu **rtpcp_array;
 	int percpu_enqueue_shift;
 	int percpu_enqueue_lim;
 	int percpu_dequeue_lim;
@@ -168,8 +164,6 @@ module_param(rcu_task_contend_lim, int, 0444);
 static int rcu_task_collapse_lim __read_mostly = 10;
 module_param(rcu_task_collapse_lim, int, 0444);
 
-static int rcu_task_cpu_ids;
-
 /* RCU tasks grace-period state for debugging. */
 #define RTGS_INIT		 0
 #define RTGS_WAIT_WAIT_CBS	 1
@@ -234,8 +228,6 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	unsigned long flags;
 	int lim;
 	int shift;
-	int maxcpu;
-	int index = 0;
 
 	raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 	if (rcu_task_enqueue_lim < 0) {
@@ -246,9 +238,14 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	}
 	lim = rcu_task_enqueue_lim;
 
-	rtp->rtpcp_array = kcalloc(num_possible_cpus(), sizeof(struct rcu_tasks_percpu *), GFP_KERNEL);
-	BUG_ON(!rtp->rtpcp_array);
-
+	if (lim > nr_cpu_ids)
+		lim = nr_cpu_ids;
+	shift = ilog2(nr_cpu_ids / lim);
+	if (((nr_cpu_ids - 1) >> shift) >= lim)
+		shift++;
+	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
+	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
+	smp_store_release(&rtp->percpu_enqueue_lim, lim);
 	for_each_possible_cpu(cpu) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
@@ -261,33 +258,16 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
 		rtpcp->cpu = cpu;
 		rtpcp->rtpp = rtp;
-		rtpcp->index = index;
-		rtp->rtpcp_array[index] = rtpcp;
-		index++;
 		if (!rtpcp->rtp_blkd_tasks.next)
 			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
 		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
-		maxcpu = cpu;
 	}
 	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 
 	if (rcu_task_cb_adjust)
 		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
 
-	rcu_task_cpu_ids = maxcpu + 1;
-	if (lim > rcu_task_cpu_ids)
-		lim = rcu_task_cpu_ids;
-	shift = ilog2(rcu_task_cpu_ids / lim);
-	if (((rcu_task_cpu_ids - 1) >> shift) >= lim)
-		shift++;
-	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
-	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
-	smp_store_release(&rtp->percpu_enqueue_lim, lim);
-
-	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d rcu_task_cpu_ids=%d.\n",
-			rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim),
-			rcu_task_cb_adjust, rcu_task_cpu_ids);
-
+	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
 }
 
 // IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
@@ -327,7 +307,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 			rtpcp->rtp_n_lock_retries = 0;
 		}
 		if (rcu_task_cb_adjust && ++rtpcp->rtp_n_lock_retries > rcu_task_contend_lim &&
-		    READ_ONCE(rtp->percpu_enqueue_lim) != rcu_task_cpu_ids)
+		    READ_ONCE(rtp->percpu_enqueue_lim) != nr_cpu_ids)
 			needadjust = true;  // Defer adjustment to avoid deadlock.
 	}
 	if (!rcu_segcblist_is_enabled(&rtpcp->cblist)) {
@@ -340,10 +320,10 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	if (unlikely(needadjust)) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
-		if (rtp->percpu_enqueue_lim != rcu_task_cpu_ids) {
+		if (rtp->percpu_enqueue_lim != nr_cpu_ids) {
 			WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
-			WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
-			smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
+			WRITE_ONCE(rtp->percpu_dequeue_lim, nr_cpu_ids);
+			smp_store_release(&rtp->percpu_enqueue_lim, nr_cpu_ids);
 			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
 		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
@@ -414,8 +394,6 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	int needgpcb = 0;
 
 	for (cpu = 0; cpu < smp_load_acquire(&rtp->percpu_dequeue_lim); cpu++) {
-		if (!cpu_possible(cpu))
-			continue;
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
 		/* Advance and accelerate any new callbacks. */
@@ -448,7 +426,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	if (rcu_task_cb_adjust && ncbs <= rcu_task_collapse_lim) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim > 1) {
-			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(rcu_task_cpu_ids));
+			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(nr_cpu_ids));
 			smp_store_release(&rtp->percpu_enqueue_lim, 1);
 			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
 			gpdone = false;
@@ -463,9 +441,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 			pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
 		}
 		if (rtp->percpu_dequeue_lim == 1) {
-			for (cpu = rtp->percpu_dequeue_lim; cpu < rcu_task_cpu_ids; cpu++) {
-				if (!cpu_possible(cpu))
-					continue;
+			for (cpu = rtp->percpu_dequeue_lim; cpu < nr_cpu_ids; cpu++) {
 				struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
 				WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp->cblist));
@@ -480,32 +456,30 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 // Advance callbacks and invoke any that are ready.
 static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu *rtpcp)
 {
+	int cpu;
+	int cpunext;
 	int cpuwq;
 	unsigned long flags;
 	int len;
-	int index;
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	struct rcu_tasks_percpu *rtpcp_next;
 
-	index = rtpcp->index * 2 + 1;
-	if (index < num_possible_cpus()) {
-		rtpcp_next = rtp->rtpcp_array[index];
-		if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
-			cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
+	cpu = rtpcp->cpu;
+	cpunext = cpu * 2 + 1;
+	if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
+		rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
+		cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
+		queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
+		cpunext++;
+		if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
+			rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
+			cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
 			queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
-			index++;
-			if (index < num_possible_cpus()) {
-				rtpcp_next = rtp->rtpcp_array[index];
-				if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
-					cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
-					queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
-				}
-			}
 		}
 	}
 
-	if (rcu_segcblist_empty(&rtpcp->cblist))
+	if (rcu_segcblist_empty(&rtpcp->cblist) || !cpu_possible(cpu))
 		return;
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 	rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 96749a6cf111..acc176aa1cbe 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5262,6 +5262,9 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
 	cpumask_var_t tracing_cpumask_new;
 	int err;
 
+	if (count == 0 || count > KMALLOC_MAX_SIZE)
+		return -EINVAL;
+
 	if (!zalloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 8657c9b1448e..72655d81b37d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -702,7 +702,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 
 static struct notifier_block trace_kprobe_module_nb = {
 	.notifier_call = trace_kprobe_module_callback,
-	.priority = 1	/* Invoked after kprobe module callback */
+	.priority = 2	/* Invoked after kprobe and jump_label module callback */
 };
 
 static int count_symbols(void *data, unsigned long unused)
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a0b650f50faa..7c6694514606 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2709,7 +2709,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			struct page *page = area->pages[i];
 
 			BUG_ON(!page);
-			mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
+			if (!(area->flags & VM_MAP_PUT_PAGES))
+				mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
 			/*
 			 * High-order allocs for huge vmallocs are split, so
 			 * can be freed as an array of order-0 allocations
@@ -2717,7 +2718,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			__free_pages(page, 0);
 			cond_resched();
 		}
-		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
+		if (!(area->flags & VM_MAP_PUT_PAGES))
+			atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
 
 		kvfree(area->pages);
 	}
diff --git a/net/core/filter.c b/net/core/filter.c
index 34cefd85aaf6..cf87e29a5e8f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3695,13 +3695,22 @@ static const struct bpf_func_proto bpf_skb_adjust_room_proto = {
 
 static u32 __bpf_skb_min_len(const struct sk_buff *skb)
 {
-	u32 min_len = skb_network_offset(skb);
+	int offset = skb_network_offset(skb);
+	u32 min_len = 0;
 
-	if (skb_transport_header_was_set(skb))
-		min_len = skb_transport_offset(skb);
-	if (skb->ip_summed == CHECKSUM_PARTIAL)
-		min_len = skb_checksum_start_offset(skb) +
-			  skb->csum_offset + sizeof(__sum16);
+	if (offset > 0)
+		min_len = offset;
+	if (skb_transport_header_was_set(skb)) {
+		offset = skb_transport_offset(skb);
+		if (offset > 0)
+			min_len = offset;
+	}
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		offset = skb_checksum_start_offset(skb) +
+			 skb->csum_offset + sizeof(__sum16);
+		if (offset > 0)
+			min_len = offset;
+	}
 	return min_len;
 }
 
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 584516387fda..65764952bc68 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -444,8 +444,10 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 			if (likely(!peek)) {
 				sge->offset += copy;
 				sge->length -= copy;
-				if (!msg_rx->skb)
+				if (!msg_rx->skb) {
 					sk_mem_uncharge(sk, copy);
+					atomic_sub(copy, &sk->sk_rmem_alloc);
+				}
 				msg_rx->sg.size -= copy;
 
 				if (!sge->length) {
@@ -771,6 +773,8 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
 
 	list_for_each_entry_safe(msg, tmp, &psock->ingress_msg, list) {
 		list_del(&msg->list);
+		if (!msg->skb)
+			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
 		sk_msg_free(psock->sk, msg);
 		kfree(msg);
 	}
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index deb6286b5881..a8db010e9e61 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -49,13 +49,14 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 		sge = sk_msg_elem(msg, i);
 		size = (apply && apply_bytes < sge->length) ?
 			apply_bytes : sge->length;
-		if (!sk_wmem_schedule(sk, size)) {
+		if (!__sk_rmem_schedule(sk, size, false)) {
 			if (!copied)
 				ret = -ENOMEM;
 			break;
 		}
 
 		sk_mem_charge(sk, size);
+		atomic_add(size, &sk->sk_rmem_alloc);
 		sk_msg_xfer(tmp, msg, i, size);
 		copied += size;
 		if (sge->length)
@@ -74,7 +75,8 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 
 	if (!ret) {
 		msg->sg.start = i;
-		sk_psock_queue_msg(psock, tmp);
+		if (!sk_psock_queue_msg(psock, tmp))
+			atomic_sub(copied, &sk->sk_rmem_alloc);
 		sk_psock_data_ready(sk, psock);
 	} else {
 		sk_msg_free(sk, tmp);
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index a14b9cb48f69..7edb029f08a3 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -311,6 +311,7 @@ enum {
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
 	CXT_PINCFG_SWS_JS201D,
 	CXT_PINCFG_TOP_SPEAKER,
+	CXT_FIXUP_HP_A_U,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -778,6 +779,18 @@ static void cxt_setup_mute_led(struct hda_codec *codec,
 	}
 }
 
+static void cxt_setup_gpio_unmute(struct hda_codec *codec,
+				  unsigned int gpio_mute_mask)
+{
+	if (gpio_mute_mask) {
+		// set gpio data to 0.
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA, 0);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK, gpio_mute_mask);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DIRECTION, gpio_mute_mask);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_STICKY_MASK, 0);
+	}
+}
+
 static void cxt_fixup_mute_led_gpio(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -792,6 +805,15 @@ static void cxt_fixup_hp_zbook_mute_led(struct hda_codec *codec,
 		cxt_setup_mute_led(codec, 0x10, 0x20);
 }
 
+static void cxt_fixup_hp_a_u(struct hda_codec *codec,
+			     const struct hda_fixup *fix, int action)
+{
+	// Init vers in BIOS mute the spk/hp by set gpio high to avoid pop noise,
+	// so need to unmute once by clearing the gpio data when runs into the system.
+	if (action == HDA_FIXUP_ACT_INIT)
+		cxt_setup_gpio_unmute(codec, 0x2);
+}
+
 /* ThinkPad X200 & co with cxt5051 */
 static const struct hda_pintbl cxt_pincfg_lenovo_x200[] = {
 	{ 0x16, 0x042140ff }, /* HP (seq# overridden) */
@@ -1016,6 +1038,10 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_sirius_top_speaker,
 	},
+	[CXT_FIXUP_HP_A_U] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_hp_a_u,
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -1090,6 +1116,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x8457, "HP Z2 G4 mini", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8458, "HP Z2 G4 mini premium", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
+	SND_PCI_QUIRK(0x14f1, 0x0252, "MBX-Z60MR100", CXT_FIXUP_HP_A_U),
 	SND_PCI_QUIRK(0x14f1, 0x0265, "SWS JS201D", CXT_PINCFG_SWS_JS201D),
 	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT_FIXUP_OLPC_XO),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400", CXT_PINCFG_LENOVO_TP410),
@@ -1135,6 +1162,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_PINCFG_LENOVO_NOTEBOOK, .name = "lenovo-20149" },
 	{ .id = CXT_PINCFG_SWS_JS201D, .name = "sws-js201d" },
 	{ .id = CXT_PINCFG_TOP_SPEAKER, .name = "sirius-top-speaker" },
+	{ .id = CXT_FIXUP_HP_A_U, .name = "HP-U-support" },
 	{}
 };
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bd0f00794c30..ef9b0cc339f2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9898,6 +9898,13 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d01, "HP ZBook Power 14 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d84, "HP EliteBook X G1i", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d91, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e18, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
diff --git a/tools/include/uapi/linux/stddef.h b/tools/include/uapi/linux/stddef.h
index bb6ea517efb5..c53cde425406 100644
--- a/tools/include/uapi/linux/stddef.h
+++ b/tools/include/uapi/linux/stddef.h
@@ -8,6 +8,13 @@
 #define __always_inline __inline__
 #endif
 
+/* Not all C++ standards support type declarations inside an anonymous union */
+#ifndef __cplusplus
+#define __struct_group_tag(TAG)		TAG
+#else
+#define __struct_group_tag(TAG)
+#endif
+
 /**
  * __struct_group() - Create a mirrored named and anonyomous struct
  *
@@ -20,14 +27,14 @@
  * and size: one anonymous and one named. The former's members can be used
  * normally without sub-struct naming, and the latter can be used to
  * reason about the start, end, and size of the group of struct members.
- * The named struct can also be explicitly tagged for layer reuse, as well
- * as both having struct attributes appended.
+ * The named struct can also be explicitly tagged for layer reuse (C only),
+ * as well as both having struct attributes appended.
  */
 #define __struct_group(TAG, NAME, ATTRS, MEMBERS...) \
 	union { \
 		struct { MEMBERS } ATTRS; \
-		struct TAG { MEMBERS } ATTRS NAME; \
-	}
+		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
+	} ATTRS
 
 /**
  * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union

