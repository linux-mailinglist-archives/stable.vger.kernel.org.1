Return-Path: <stable+bounces-179111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B485DB50406
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 19:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8E116674F
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 17:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DF635CEAE;
	Tue,  9 Sep 2025 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FHxNKvSt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0822F747B;
	Tue,  9 Sep 2025 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437838; cv=none; b=Dyvicq+rFfZmUUQg81T7hzL9EUlHQJT2ZpgiSvyNOCpfbf4L6q0GfMaESJLKaplxdUMwyN3kBJn/4vJfz82PCJuadulh+7y+nO66LgR7D9sdPfGkcSFNMHeqBpERHNLuLLsEubFDHgIGzOAY+As8V/2HqT2V9ibuAn/eOI1dE8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437838; c=relaxed/simple;
	bh=y8v8aSME2aJD7j8F2gjFYCCsi+fAdPmIKCFtvHaGqQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pF2tL+Sbkn2KH5nKSV9+dixEOGkc3GuveCYukRXD1yfQ9SW9fV0XxmYG2z19WIsdfE/ZGmnf+3l/4b/5eORM8WPD/KO/5wjYVwQNFKd8yaWMTtv1kb/t5+YycL/y5/DBeWzZ6SLM3Kbwp1T8bNl8cLPIPIhSrrX3eQzaVJ71RAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FHxNKvSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984F7C4CEF4;
	Tue,  9 Sep 2025 17:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757437838;
	bh=y8v8aSME2aJD7j8F2gjFYCCsi+fAdPmIKCFtvHaGqQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FHxNKvSt9/TrItwKNjjeFl6Dw7GHUVxyIlg2AUHGLHSGSXLVFmyPt7RBMYaYrM+/C
	 IgOTuWA0nhqcSQYt0H3fVNH/FfY35lTfWUQrPEsSkguurEWMdXYhg47MXZnz/jz0h/
	 /nPDKJRD0Bnbf4zBcT2dCbvvjskLs9ok85drRch0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.299
Date: Tue,  9 Sep 2025 19:10:28 +0200
Message-ID: <2025090928-slider-wake-d05d@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090928-grid-uncured-a227@gregkh>
References: <2025090928-grid-uncured-a227@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 39b0ac41f636..819dd9649e78 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 298
+SUBLEVEL = 299
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/powerpc/boot/util.S b/arch/powerpc/boot/util.S
index f11f0589a669..5ab2bc864e66 100644
--- a/arch/powerpc/boot/util.S
+++ b/arch/powerpc/boot/util.S
@@ -41,12 +41,12 @@ udelay:
 	srwi	r4,r4,16
 	cmpwi	0,r4,1		/* 601 ? */
 	bne	.Ludelay_not_601
-00:	li	r0,86	/* Instructions / microsecond? */
+0:	li	r0,86	/* Instructions / microsecond? */
 	mtctr	r0
 10:	addi	r0,r0,0 /* NOP */
 	bdnz	10b
 	subic.	r3,r3,1
-	bne	00b
+	bne	0b
 	blr
 
 .Ludelay_not_601:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b50d0da06b59..8eb62dbb3a18 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10394,11 +10394,18 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 {
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
+	int ret;
 
+	spin_lock_irq(&kvm->irqfds.lock);
 	irqfd->producer = prod;
 
-	return kvm_x86_ops->update_pi_irte(irqfd->kvm,
+	ret = kvm_x86_ops->update_pi_irte(irqfd->kvm,
 					   prod->irq, irqfd->gsi, 1);
+
+	spin_unlock_irq(&kvm->irqfds.lock);
+
+	return ret;
 }
 
 void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
@@ -10407,9 +10414,9 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	int ret;
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
 
 	WARN_ON(irqfd->producer != prod);
-	irqfd->producer = NULL;
 
 	/*
 	 * When producer of consumer is unregistered, we change back to
@@ -10417,10 +10424,15 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	 * when the irq is masked/disabled or the consumer side (KVM
 	 * int this case doesn't want to receive the interrupts.
 	*/
+	spin_lock_irq(&kvm->irqfds.lock);
+	irqfd->producer = NULL;
+
 	ret = kvm_x86_ops->update_pi_irte(irqfd->kvm, prod->irq, irqfd->gsi, 0);
 	if (ret)
 		printk(KERN_INFO "irq bypass consumer (token %p) unregistration"
 		       " fails: %d\n", irqfd->consumer.token, ret);
+
+	spin_unlock_irq(&kvm->irqfds.lock);
 }
 
 int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 723b11c190b3..175b27b66b04 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -421,15 +421,11 @@ static struct virt_dma_desc *mtk_cqdma_find_active_desc(struct dma_chan *c,
 {
 	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
 	struct virt_dma_desc *vd;
-	unsigned long flags;
 
-	spin_lock_irqsave(&cvc->pc->lock, flags);
 	list_for_each_entry(vd, &cvc->pc->queue, node)
 		if (vd->tx.cookie == cookie) {
-			spin_unlock_irqrestore(&cvc->pc->lock, flags);
 			return vd;
 		}
-	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	list_for_each_entry(vd, &cvc->vc.desc_issued, node)
 		if (vd->tx.cookie == cookie)
@@ -453,9 +449,11 @@ static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
 	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
-	spin_lock_irqsave(&cvc->vc.lock, flags);
+	spin_lock_irqsave(&cvc->pc->lock, flags);
+	spin_lock(&cvc->vc.lock);
 	vd = mtk_cqdma_find_active_desc(c, cookie);
-	spin_unlock_irqrestore(&cvc->vc.lock, flags);
+	spin_unlock(&cvc->vc.lock);
+	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	if (vd) {
 		cvd = to_cqdma_vdesc(vd);
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index c81d73d5e015..37c209a83ecd 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1199,6 +1199,9 @@ static int pca953x_suspend(struct device *dev)
 	struct pca953x_chip *chip = dev_get_drvdata(dev);
 
 	mutex_lock(&chip->i2c_lock);
+	/* Disable IRQ to prevent early triggering while regmap "cache only" is on */
+	if (chip->client->irq > 0)
+		disable_irq(chip->client->irq);
 	regcache_cache_only(chip->regmap, true);
 	mutex_unlock(&chip->i2c_lock);
 
@@ -1224,6 +1227,8 @@ static int pca953x_resume(struct device *dev)
 	}
 
 	mutex_lock(&chip->i2c_lock);
+	if (chip->client->irq > 0)
+		enable_irq(chip->client->irq);
 	regcache_cache_only(chip->regmap, false);
 	regcache_mark_dirty(chip->regmap);
 	ret = pca953x_regcache_sync(dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 645550e7caf5..1be25ca9e4fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1445,17 +1445,12 @@ static int dce_v10_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v10_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v10_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index d9f470632b2c..755b3e545c84 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -1487,17 +1487,12 @@ static int dce_v11_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v11_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v11_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 3eb2e7429269..48dc43f3d9e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1358,17 +1358,12 @@ static int dce_v6_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index a16c5e9e610e..478afc9f7d74 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1408,17 +1408,12 @@ static int dce_v8_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v8_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v8_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index 07bb90d72434..28521da56755 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -5,7 +5,6 @@
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  */
 
-#include <asm/unaligned.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -19,6 +18,8 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/serdev.h>
+#include <linux/types.h>
+#include <asm/unaligned.h>
 
 #define PMS7003_DRIVER_NAME "pms7003"
 
@@ -76,7 +77,7 @@ struct pms7003_state {
 	/* Used to construct scan to push to the IIO buffer */
 	struct {
 		u16 data[3]; /* PM1, PM2P5, PM10 */
-		s64 ts;
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 088779f723f7..924fe985e0c6 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -691,8 +691,9 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
 	bool wake_result_ready_queue = false;
+	bool ok_to_ignore_lock = opt->ok_to_ignore_lock;
 
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
@@ -729,7 +730,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	}
 
 out:
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_unlock(&opt->lock);
 
 	if (wake_result_ready_queue)
diff --git a/drivers/isdn/mISDN/dsp_hwec.c b/drivers/isdn/mISDN/dsp_hwec.c
index 0b3f29195330..0cd216e28f00 100644
--- a/drivers/isdn/mISDN/dsp_hwec.c
+++ b/drivers/isdn/mISDN/dsp_hwec.c
@@ -51,14 +51,14 @@ void dsp_hwec_enable(struct dsp *dsp, const char *arg)
 		goto _do;
 
 	{
-		char *dup, *tok, *name, *val;
+		char *dup, *next, *tok, *name, *val;
 		int tmp;
 
-		dup = kstrdup(arg, GFP_ATOMIC);
+		dup = next = kstrdup(arg, GFP_ATOMIC);
 		if (!dup)
 			return;
 
-		while ((tok = strsep(&dup, ","))) {
+		while ((tok = strsep(&next, ","))) {
 			if (!strlen(tok))
 				continue;
 			name = strsep(&tok, "=");
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 8854025610e6..8f4f831237cd 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1497,13 +1497,17 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		 * this cortina phy, for which there is no driver
 		 * support, ignore it.
 		 */
-		if (phy_np &&
-		    !of_device_is_compatible(phy_np, "cortina,cs4223-slice")) {
-			/* Wait until the phy drivers are available */
-			pd = of_phy_find_device(phy_np);
-			if (!pd)
-				goto defer;
-			bgx->lmac[lmac].phydev = pd;
+		if (phy_np) {
+			if (!of_device_is_compatible(phy_np, "cortina,cs4223-slice")) {
+				/* Wait until the phy drivers are available */
+				pd = of_phy_find_device(phy_np);
+				if (!pd) {
+					of_node_put(phy_np);
+					goto defer;
+				}
+				bgx->lmac[lmac].phydev = pd;
+			}
+			of_node_put(phy_np);
 		}
 
 		lmac++;
@@ -1519,11 +1523,11 @@ static int bgx_init_of_phy(struct bgx *bgx)
 	 * for phy devices we may have already found.
 	 */
 	while (lmac) {
+		lmac--;
 		if (bgx->lmac[lmac].phydev) {
 			put_device(&bgx->lmac[lmac].phydev->mdio.dev);
 			bgx->lmac[lmac].phydev = NULL;
 		}
-		lmac--;
 	}
 	of_node_put(node);
 	return -EPROBE_DEFER;
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index de8c5818a305..6f1bc6446e99 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -552,12 +552,12 @@ static int e1000_set_eeprom(struct net_device *netdev,
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
+	size_t total_len, max_len;
 	u16 *eeprom_buff;
-	void *ptr;
-	int max_len;
+	int ret_val = 0;
 	int first_word;
 	int last_word;
-	int ret_val = 0;
+	void *ptr;
 	u16 i;
 
 	if (eeprom->len == 0)
@@ -572,6 +572,10 @@ static int e1000_set_eeprom(struct net_device *netdev,
 
 	max_len = hw->nvm.word_size * 2;
 
+	if (check_add_overflow(eeprom->offset, eeprom->len, &total_len) ||
+	    total_len > max_len)
+		return -EFBIG;
+
 	first_word = eeprom->offset >> 1;
 	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
 	eeprom_buff = kmalloc(max_len, GFP_KERNEL);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 10125b02d154..b7c3625aec15 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -320,8 +320,8 @@ static void i40e_client_add_instance(struct i40e_pf *pf)
 		return;
 	}
 
-	mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
-			       struct netdev_hw_addr, list);
+	mac = list_first_entry_or_null(&cdev->lan_info.netdev->dev_addrs.list,
+				       struct netdev_hw_addr, list);
 	if (mac)
 		ether_addr_copy(cdev->lan_info.lanmac, mac->addr);
 	else
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 7b9f5eba78dc..6ab4c84bc22e 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1173,6 +1173,13 @@ static int mtk_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool gso = false;
 	int tx_num;
 
+	if (skb_vlan_tag_present(skb) &&
+	    !eth_proto_is_802_3(eth_hdr(skb)->h_proto)) {
+		skb = __vlan_hwaccel_push_inside(skb);
+		if (!skb)
+			goto dropped;
+	}
+
 	/* normally we can rely on the stack not calling this more than once,
 	 * however we have 2 queues running on the same ring so we need to lock
 	 * the ring access
@@ -1218,8 +1225,9 @@ static int mtk_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 drop:
 	spin_unlock(&eth->page_lock);
-	stats->tx_dropped++;
 	dev_kfree_skb_any(skb);
+dropped:
+	stats->tx_dropped++;
 	return NETDEV_TX_OK;
 }
 
diff --git a/drivers/net/ethernet/xircom/xirc2ps_cs.c b/drivers/net/ethernet/xircom/xirc2ps_cs.c
index e3438cef5f9c..4d8a1728e8ed 100644
--- a/drivers/net/ethernet/xircom/xirc2ps_cs.c
+++ b/drivers/net/ethernet/xircom/xirc2ps_cs.c
@@ -1584,7 +1584,7 @@ do_reset(struct net_device *dev, int full)
 	    msleep(40);			/* wait 40 msec to let it complete */
 	}
 	if (full_duplex)
-	    PutByte(XIRCREG1_ECR, GetByte(XIRCREG1_ECR | FullDuplex));
+	    PutByte(XIRCREG1_ECR, GetByte(XIRCREG1_ECR) | FullDuplex);
     } else {  /* No MII */
 	SelectPage(0);
 	value = GetByte(XIRCREG_ESR);	 /* read the ESR */
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 7b9337e16d6e..dd7c84e4b498 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1528,7 +1528,6 @@ pad_compress_skb(struct ppp *ppp, struct sk_buff *skb)
 		 */
 		if (net_ratelimit())
 			netdev_err(ppp->dev, "ppp: compressor dropped pkt\n");
-		kfree_skb(skb);
 		consume_skb(new_skb);
 		new_skb = NULL;
 	}
@@ -1630,9 +1629,10 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 					   "down - pkt dropped.\n");
 			goto drop;
 		}
-		skb = pad_compress_skb(ppp, skb);
-		if (!skb)
+		new_skb = pad_compress_skb(ppp, skb);
+		if (!new_skb)
 			goto drop;
+		skb = new_skb;
 	}
 
 	/*
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 609f65530b9b..a51c4ad9ed20 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2998,8 +2998,6 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 	int err = 0;
 
-	netdev->mtu = new_mtu;
-
 	/*
 	 * Reset_work may be in the middle of resetting the device, wait for its
 	 * completion.
@@ -3013,6 +3011,7 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 
 		/* we need to re-create the rx queue based on the new mtu */
 		vmxnet3_rq_destroy_all(adapter);
+		netdev->mtu = new_mtu;
 		vmxnet3_adjust_rx_ring_size(adapter);
 		err = vmxnet3_rq_create_all(adapter);
 		if (err) {
@@ -3029,6 +3028,8 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 				   "Closing it\n", err);
 			goto out;
 		}
+	} else {
+		netdev->mtu = new_mtu;
 	}
 
 out:
diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 4e3de684928b..a659054c1bcd 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -1102,10 +1102,13 @@ static int lbs_associate(struct lbs_private *priv,
 	/* add SSID TLV */
 	rcu_read_lock();
 	ssid_eid = ieee80211_bss_get_ie(bss, WLAN_EID_SSID);
-	if (ssid_eid)
-		pos += lbs_add_ssid_tlv(pos, ssid_eid + 2, ssid_eid[1]);
-	else
+	if (ssid_eid) {
+		u32 ssid_len = min(ssid_eid[1], IEEE80211_MAX_SSID_LEN);
+
+		pos += lbs_add_ssid_tlv(pos, ssid_eid + 2, ssid_len);
+	} else {
 		lbs_deb_assoc("no SSID\n");
+	}
 	rcu_read_unlock();
 
 	/* add DS param TLV */
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index e40f727547ec..40e10f6e3dbf 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4273,8 +4273,9 @@ int mwifiex_init_channel_scan_gap(struct mwifiex_adapter *adapter)
 	 * additional active scan request for hidden SSIDs on passive channels.
 	 */
 	adapter->num_in_chan_stats = 2 * (n_channels_bg + n_channels_a);
-	adapter->chan_stats = vmalloc(array_size(sizeof(*adapter->chan_stats),
-						 adapter->num_in_chan_stats));
+	adapter->chan_stats = kcalloc(adapter->num_in_chan_stats,
+				      sizeof(*adapter->chan_stats),
+				      GFP_KERNEL);
 
 	if (!adapter->chan_stats)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index d788e2e6397c..2198bbf8e2e7 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -635,7 +635,7 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 	goto done;
 
 err_add_intf:
-	vfree(adapter->chan_stats);
+	kfree(adapter->chan_stats);
 err_init_chan_scan:
 	wiphy_unregister(adapter->wiphy);
 	wiphy_free(adapter->wiphy);
@@ -1448,7 +1448,7 @@ static void mwifiex_uninit_sw(struct mwifiex_adapter *adapter)
 	wiphy_free(adapter->wiphy);
 	adapter->wiphy = NULL;
 
-	vfree(adapter->chan_stats);
+	kfree(adapter->chan_stats);
 	mwifiex_free_cmd_buffers(adapter);
 }
 
diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index 236022d4ae2a..0f2d1ec34cd8 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -1289,7 +1289,7 @@ static void cw1200_do_join(struct cw1200_common *priv)
 		rcu_read_lock();
 		ssidie = ieee80211_bss_get_ie(bss, WLAN_EID_SSID);
 		if (ssidie) {
-			join.ssid_len = ssidie[1];
+			join.ssid_len = min(ssidie[1], IEEE80211_MAX_SSID_LEN);
 			memcpy(join.ssid, &ssidie[2], join.ssid_len);
 		}
 		rcu_read_unlock();
diff --git a/drivers/pcmcia/rsrc_iodyn.c b/drivers/pcmcia/rsrc_iodyn.c
index b04b16496b0c..2677b577c1f8 100644
--- a/drivers/pcmcia/rsrc_iodyn.c
+++ b/drivers/pcmcia/rsrc_iodyn.c
@@ -62,6 +62,9 @@ static struct resource *__iodyn_find_io_region(struct pcmcia_socket *s,
 	unsigned long min = base;
 	int ret;
 
+	if (!res)
+		return NULL;
+
 	data.mask = align - 1;
 	data.offset = base & data.mask;
 
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 6b311d6f8bf0..12bcbeca4a44 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -375,7 +375,9 @@ static int do_validate_mem(struct pcmcia_socket *s,
 
 	if (validate && !s->fake_cis) {
 		/* move it to the validated data set */
-		add_interval(&s_data->mem_db_valid, base, size);
+		ret = add_interval(&s_data->mem_db_valid, base, size);
+		if (ret)
+			return ret;
 		sub_interval(&s_data->mem_db, base, size);
 	}
 
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 979a6d11b1b7..728ec3f47e02 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1172,7 +1172,7 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct lpfc_nvmet_rcv_ctx *ctxp =
 		container_of(rsp, struct lpfc_nvmet_rcv_ctx, ctx.fcp_req);
-	struct rqb_dmabuf *nvmebuf = ctxp->rqb_buffer;
+	struct rqb_dmabuf *nvmebuf;
 	struct lpfc_hba *phba = ctxp->phba;
 	unsigned long iflag;
 
@@ -1180,13 +1180,18 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 	lpfc_nvmeio_data(phba, "NVMET DEFERRCV: xri x%x sz %d CPU %02x\n",
 			 ctxp->oxid, ctxp->size, raw_smp_processor_id());
 
+	spin_lock_irqsave(&ctxp->ctxlock, iflag);
+	nvmebuf = ctxp->rqb_buffer;
 	if (!nvmebuf) {
+		spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 		lpfc_printf_log(phba, KERN_INFO, LOG_NVME_IOERR,
 				"6425 Defer rcv: no buffer oxid x%x: "
 				"flg %x ste %x\n",
 				ctxp->oxid, ctxp->flag, ctxp->state);
 		return;
 	}
+	ctxp->rqb_buffer = NULL;
+	spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 
 	tgtp = phba->targetport->private;
 	if (tgtp)
@@ -1194,9 +1199,6 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 
 	/* Free the nvmebuf since a new buffer already replaced it */
 	nvmebuf->hrq->rqbp->rqb_free_buffer(phba, nvmebuf);
-	spin_lock_irqsave(&ctxp->ctxlock, iflag);
-	ctxp->rqb_buffer = NULL;
-	spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 }
 
 static void
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 2708bf15e126..789cdb001eb6 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -3,8 +3,9 @@
 // Freescale i.MX7ULP LPSPI driver
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
-// Copyright 2018 NXP Semiconductors
+// Copyright 2018, 2023, 2025 NXP
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -74,7 +75,7 @@
 #define DER_TDDE	BIT(0)
 #define CFGR1_PCSCFG	BIT(27)
 #define CFGR1_PINCFG	(BIT(24)|BIT(25))
-#define CFGR1_PCSPOL	BIT(8)
+#define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_MASTER	BIT(0)
 #define FSR_TXCOUNT	(0xFF)
@@ -415,7 +416,9 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 	else
 		temp = CFGR1_PINCFG;
 	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
-		temp |= CFGR1_PCSPOL;
+		temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
+				   BIT(fsl_lpspi->config.chip_select));
+
 	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
 
 	temp = readl(fsl_lpspi->base + IMX7ULP_CR);
@@ -719,12 +722,10 @@ static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
 	fsl_lpspi_write_tx_fifo(fsl_lpspi);
 
 	ret = fsl_lpspi_wait_for_completion(controller);
-	if (ret)
-		return ret;
 
 	fsl_lpspi_reset(fsl_lpspi);
 
-	return 0;
+	return ret;
 }
 
 static int fsl_lpspi_transfer_one(struct spi_controller *controller,
@@ -772,7 +773,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	if (temp_SR & SR_MBF ||
 	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_TXCOUNT) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
-		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
+		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE | (temp_IER & IER_TDIE));
 		return IRQ_HANDLED;
 	}
 
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index d8d9d9061544..93fc906f732b 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2144,6 +2144,11 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 					 __func__);
 				goto cifs_parse_mount_err;
 			}
+			if (option < SMB_ECHO_INTERVAL_MIN ||
+			    option > SMB_ECHO_INTERVAL_MAX) {
+				cifs_dbg(VFS, "echo interval is out of bounds\n");
+				goto cifs_parse_mount_err;
+			}
 			vol->echo_interval = option;
 			break;
 		case Opt_snapshot:
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 831fee509404..babdfed7f24c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -88,9 +88,20 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	if (!cpufreq_this_cpu_can_update(sg_policy->policy))
 		return false;
 
-	if (unlikely(sg_policy->limits_changed)) {
-		sg_policy->limits_changed = false;
+	if (unlikely(READ_ONCE(sg_policy->limits_changed))) {
+		WRITE_ONCE(sg_policy->limits_changed, false);
 		sg_policy->need_freq_update = true;
+
+		/*
+		 * The above limits_changed update must occur before the reads
+		 * of policy limits in cpufreq_driver_resolve_freq() or a policy
+		 * limits update might be missed, so use a memory barrier to
+		 * ensure it.
+		 *
+		 * This pairs with the write memory barrier in sugov_limits().
+		 */
+		smp_mb();
+
 		return true;
 	}
 
@@ -444,7 +455,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu, struct sugov_policy *sg_policy)
 {
 	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
-		sg_policy->limits_changed = true;
+		WRITE_ONCE(sg_policy->limits_changed, true);
 }
 
 static void sugov_update_single(struct update_util_data *hook, u64 time,
@@ -894,7 +905,16 @@ static void sugov_limits(struct cpufreq_policy *policy)
 		mutex_unlock(&sg_policy->work_lock);
 	}
 
-	sg_policy->limits_changed = true;
+	/*
+	 * The limits_changed update below must take place before the updates
+	 * of policy limits in cpufreq_set_policy() or a policy limits update
+	 * might be missed, so use a memory barrier to ensure it.
+	 *
+	 * This pairs with the memory barrier in sugov_should_update_freq().
+	 */
+	smp_wmb();
+
+	WRITE_ONCE(sg_policy->limits_changed, true);
 }
 
 struct cpufreq_governor schedutil_gov = {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f1f98305433e..d6da1fcbef6f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1476,7 +1476,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 * has higher cost too. It would also probably require locking
 		 * the anon_vma.
 		 */
-		if (vma->anon_vma)
+		if (READ_ONCE(vma->anon_vma))
 			continue;
 		addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 		if (addr & ~HPAGE_PMD_MASK)
@@ -1498,6 +1498,18 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 			if (!khugepaged_test_exit(mm)) {
 				struct mmu_notifier_range range;
 
+				/*
+				 * Re-check whether we have an ->anon_vma, because
+				 * collapse_and_free_pmd() requires that either no
+				 * ->anon_vma exists or the anon_vma is locked.
+				 * We already checked ->anon_vma above, but that check
+				 * is racy because ->anon_vma can be populated under the
+				 * mmap_sem in read mode.
+				 */
+				if (vma->anon_vma) {
+					up_write(&mm->mmap_sem);
+					continue;
+				}
 				mmu_notifier_range_init(&range,
 							MMU_NOTIFY_CLEAR, 0,
 							NULL, mm, addr,
diff --git a/mm/slub.c b/mm/slub.c
index e978f647e92a..734f763e7d2e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -719,7 +719,12 @@ void object_err(struct kmem_cache *s, struct page *page,
 			u8 *object, char *reason)
 {
 	slab_bug(s, "%s", reason);
-	print_trailer(s, page, object);
+	if (!object || !check_valid_pointer(s, page, object)) {
+		print_page_info(page);
+		pr_err("Invalid pointer 0x%p\n", object);
+	} else {
+		print_trailer(s, page, object);
+	}
 }
 
 static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
diff --git a/net/atm/resources.c b/net/atm/resources.c
index e244c2576d1e..a00799254e2d 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -114,7 +114,9 @@ struct atm_dev *atm_dev_register(const char *type, struct device *parent,
 
 	if (atm_proc_dev_register(dev) < 0) {
 		pr_err("atm_proc_dev_register failed for dev %s\n", type);
-		goto out_fail;
+		mutex_unlock(&atm_dev_mutex);
+		kfree(dev);
+		return NULL;
 	}
 
 	if (atm_register_sysfs(dev, parent) < 0) {
@@ -130,7 +132,7 @@ struct atm_dev *atm_dev_register(const char *type, struct device *parent,
 	return dev;
 
 out_fail:
-	kfree(dev);
+	put_device(&dev->class_dev);
 	dev = NULL;
 	goto out;
 }
diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index dcdbaeeb2358..506a88b2357b 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -433,6 +433,10 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 int ax25_kiss_rcv(struct sk_buff *skb, struct net_device *dev,
 		  struct packet_type *ptype, struct net_device *orig_dev)
 {
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return NET_RX_DROP;
+
 	skb_orphan(skb);
 
 	if (!net_eq(dev_net(dev), &init_net)) {
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 850f927f33de..645b972d3a36 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1694,7 +1694,12 @@ batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	coding_len = ntohs(coded_packet_tmp.coded_len);
 
-	if (coding_len > skb->len)
+	/* ensure dst buffer is large enough (payload only) */
+	if (coding_len + h_size > skb->len)
+		return NULL;
+
+	/* ensure src buffer is large enough (payload only) */
+	if (coding_len + h_size > nc_packet->skb->len)
 		return NULL;
 
 	/* Here the magic is reversed:
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 93df53f2b76e..dfffc5bb292d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1226,7 +1226,10 @@ static int l2cap_sock_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	lock_sock_nested(sk, L2CAP_NESTING_PARENT);
 	l2cap_sock_cleanup_listen(sk);
+	release_sock(sk);
+
 	bt_sock_unlink(&l2cap_sk_list, sk);
 
 	err = l2cap_sock_shutdown(sock, 2);
diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index 7354c5db3a14..2ccf12dc2093 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -115,7 +115,12 @@ static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
 static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev,
 				  struct packet_type *pt)
 {
-	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+	u8 *tag;
+
+	if (skb_linearize(skb))
+		return NULL;
+
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
 
 	return ksz_common_rcv(skb, dev, tag[0] & 7, KSZ_EGRESS_TAG_LEN);
 }
@@ -149,8 +154,9 @@ MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ8795);
 
 #define KSZ9477_INGRESS_TAG_LEN		2
 #define KSZ9477_PTP_TAG_LEN		4
-#define KSZ9477_PTP_TAG_INDICATION	0x80
+#define KSZ9477_PTP_TAG_INDICATION	BIT(7)
 
+#define KSZ9477_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
 #define KSZ9477_TAIL_TAG_OVERRIDE	BIT(9)
 #define KSZ9477_TAIL_TAG_LOOKUP		BIT(10)
 
@@ -183,10 +189,16 @@ static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_device *dev,
 				   struct packet_type *pt)
 {
-	/* Tag decoding */
-	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
-	unsigned int port = tag[0] & 7;
 	unsigned int len = KSZ_EGRESS_TAG_LEN;
+	unsigned int port;
+	u8 *tag;
+
+	if (skb_linearize(skb))
+		return NULL;
+
+	/* Tag decoding */
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+	port = tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
 
 	/* Extra 4-bytes PTP timestamp */
 	if (tag[0] & KSZ9477_PTP_TAG_INDICATION)
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 6855372d57a3..b4fb75be24d9 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -332,14 +332,13 @@ static void inetdev_destroy(struct in_device *in_dev)
 
 static int __init inet_blackhole_dev_init(void)
 {
-	int err = 0;
+	struct in_device *in_dev;
 
 	rtnl_lock();
-	if (!inetdev_init(blackhole_netdev))
-		err = -ENOMEM;
+	in_dev = inetdev_init(blackhole_netdev);
 	rtnl_unlock();
 
-	return err;
+	return PTR_ERR_OR_ZERO(in_dev);
 }
 late_initcall(inet_blackhole_dev_init);
 
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index ac82a4158b86..875424c428e6 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -790,11 +790,12 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 	struct sk_buff *cloned_skb = NULL;
 	struct ip_options opts = { 0 };
 	enum ip_conntrack_info ctinfo;
+	enum ip_conntrack_dir dir;
 	struct nf_conn *ct;
 	__be32 orig_ip;
 
 	ct = nf_ct_get(skb_in, &ctinfo);
-	if (!ct || !(ct->status & IPS_SRC_NAT)) {
+	if (!ct || !(READ_ONCE(ct->status) & IPS_NAT_MASK)) {
 		__icmp_send(skb_in, type, code, info, &opts);
 		return;
 	}
@@ -809,7 +810,8 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 		goto out;
 
 	orig_ip = ip_hdr(skb_in)->saddr;
-	ip_hdr(skb_in)->saddr = ct->tuplehash[0].tuple.src.u3.ip;
+	dir = CTINFO2DIR(ctinfo);
+	ip_hdr(skb_in)->saddr = ct->tuplehash[dir].tuple.src.u3.ip;
 	__icmp_send(skb_in, type, code, info, &opts);
 	ip_hdr(skb_in)->saddr = orig_ip;
 out:
diff --git a/net/ipv6/ip6_icmp.c b/net/ipv6/ip6_icmp.c
index 9e3574880cb0..233914b63bdb 100644
--- a/net/ipv6/ip6_icmp.c
+++ b/net/ipv6/ip6_icmp.c
@@ -54,11 +54,12 @@ void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 	struct inet6_skb_parm parm = { 0 };
 	struct sk_buff *cloned_skb = NULL;
 	enum ip_conntrack_info ctinfo;
+	enum ip_conntrack_dir dir;
 	struct in6_addr orig_ip;
 	struct nf_conn *ct;
 
 	ct = nf_ct_get(skb_in, &ctinfo);
-	if (!ct || !(ct->status & IPS_SRC_NAT)) {
+	if (!ct || !(READ_ONCE(ct->status) & IPS_NAT_MASK)) {
 		__icmpv6_send(skb_in, type, code, info, &parm);
 		return;
 	}
@@ -73,7 +74,8 @@ void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 		goto out;
 
 	orig_ip = ipv6_hdr(skb_in)->saddr;
-	ipv6_hdr(skb_in)->saddr = ct->tuplehash[0].tuple.src.u3.in6;
+	dir = CTINFO2DIR(ctinfo);
+	ipv6_hdr(skb_in)->saddr = ct->tuplehash[dir].tuple.src.u3.in6;
 	__icmpv6_send(skb_in, type, code, info, &parm);
 	ipv6_hdr(skb_in)->saddr = orig_ip;
 out:
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index 32cc91f5ba99..89174c91053e 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -417,7 +417,7 @@ int nf_conntrack_helper_register(struct nf_conntrack_helper *me)
 			    (cur->tuple.src.l3num == NFPROTO_UNSPEC ||
 			     cur->tuple.src.l3num == me->tuple.src.l3num) &&
 			    cur->tuple.dst.protonum == me->tuple.dst.protonum) {
-				ret = -EEXIST;
+				ret = -EBUSY;
 				goto out;
 			}
 		}
@@ -428,7 +428,7 @@ int nf_conntrack_helper_register(struct nf_conntrack_helper *me)
 		hlist_for_each_entry(cur, &nf_ct_helper_hash[h], hnode) {
 			if (nf_ct_tuple_src_mask_cmp(&cur->tuple, &me->tuple,
 						     &mask)) {
-				ret = -EEXIST;
+				ret = -EBUSY;
 				goto out;
 			}
 		}
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 18398968b3ed..33e6f4103550 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1219,7 +1219,8 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 			 */
 
 			f = rcu_access_pointer(new->pub.beacon_ies);
-			kfree_rcu((struct cfg80211_bss_ies *)f, rcu_head);
+			if (!new->pub.hidden_beacon_bss)
+				kfree_rcu((struct cfg80211_bss_ies *)f, rcu_head);
 			return false;
 		}
 
diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 0907ab19202a..6ec887ae71b6 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -182,6 +182,38 @@ static inline tree build_const_char_string(int len, const char *str)
 	return cstr;
 }
 
+static inline void __add_type_attr(tree type, const char *attr, tree args)
+{
+	tree oldattr;
+
+	if (type == NULL_TREE)
+		return;
+	oldattr = lookup_attribute(attr, TYPE_ATTRIBUTES(type));
+	if (oldattr != NULL_TREE) {
+		gcc_assert(TREE_VALUE(oldattr) == args || TREE_VALUE(TREE_VALUE(oldattr)) == TREE_VALUE(args));
+		return;
+	}
+
+	TYPE_ATTRIBUTES(type) = copy_list(TYPE_ATTRIBUTES(type));
+	TYPE_ATTRIBUTES(type) = tree_cons(get_identifier(attr), args, TYPE_ATTRIBUTES(type));
+}
+
+static inline void add_type_attr(tree type, const char *attr, tree args)
+{
+	tree main_variant = TYPE_MAIN_VARIANT(type);
+
+	__add_type_attr(TYPE_CANONICAL(type), attr, args);
+	__add_type_attr(TYPE_CANONICAL(main_variant), attr, args);
+	__add_type_attr(main_variant, attr, args);
+
+	for (type = TYPE_NEXT_VARIANT(main_variant); type; type = TYPE_NEXT_VARIANT(type)) {
+		if (!lookup_attribute(attr, TYPE_ATTRIBUTES(type)))
+			TYPE_ATTRIBUTES(type) = TYPE_ATTRIBUTES(main_variant);
+
+		__add_type_attr(TYPE_CANONICAL(type), attr, args);
+	}
+}
+
 #define PASS_INFO(NAME, REF, ID, POS)		\
 struct register_pass_info NAME##_pass_info = {	\
 	.pass = make_##NAME##_pass(),		\
diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index c7ff92b4189c..472427f169a4 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -95,6 +95,9 @@ static tree handle_randomize_layout_attr(tree *node, tree name, tree args, int f
 
 	if (TYPE_P(*node)) {
 		type = *node;
+	} else if (TREE_CODE(*node) == FIELD_DECL) {
+		*no_add_attrs = false;
+		return NULL_TREE;
 	} else {
 		gcc_assert(TREE_CODE(*node) == TYPE_DECL);
 		type = TREE_TYPE(*node);
@@ -377,35 +380,18 @@ static int relayout_struct(tree type)
 
 	shuffle(type, (tree *)newtree, shuffle_length);
 
-	/*
-	 * set up a bogus anonymous struct field designed to error out on unnamed struct initializers
-	 * as gcc provides no other way to detect such code
-	 */
-	list = make_node(FIELD_DECL);
-	TREE_CHAIN(list) = newtree[0];
-	TREE_TYPE(list) = void_type_node;
-	DECL_SIZE(list) = bitsize_zero_node;
-	DECL_NONADDRESSABLE_P(list) = 1;
-	DECL_FIELD_BIT_OFFSET(list) = bitsize_zero_node;
-	DECL_SIZE_UNIT(list) = size_zero_node;
-	DECL_FIELD_OFFSET(list) = size_zero_node;
-	DECL_CONTEXT(list) = type;
-	// to satisfy the constify plugin
-	TREE_READONLY(list) = 1;
-
 	for (i = 0; i < num_fields - 1; i++)
 		TREE_CHAIN(newtree[i]) = newtree[i+1];
 	TREE_CHAIN(newtree[num_fields - 1]) = NULL_TREE;
 
+	add_type_attr(type, "randomize_performed", NULL_TREE);
+	add_type_attr(type, "designated_init", NULL_TREE);
+	if (has_flexarray)
+		add_type_attr(type, "has_flexarray", NULL_TREE);
+
 	main_variant = TYPE_MAIN_VARIANT(type);
-	for (variant = main_variant; variant; variant = TYPE_NEXT_VARIANT(variant)) {
-		TYPE_FIELDS(variant) = list;
-		TYPE_ATTRIBUTES(variant) = copy_list(TYPE_ATTRIBUTES(variant));
-		TYPE_ATTRIBUTES(variant) = tree_cons(get_identifier("randomize_performed"), NULL_TREE, TYPE_ATTRIBUTES(variant));
-		TYPE_ATTRIBUTES(variant) = tree_cons(get_identifier("designated_init"), NULL_TREE, TYPE_ATTRIBUTES(variant));
-		if (has_flexarray)
-			TYPE_ATTRIBUTES(type) = tree_cons(get_identifier("has_flexarray"), NULL_TREE, TYPE_ATTRIBUTES(type));
-	}
+	for (variant = main_variant; variant; variant = TYPE_NEXT_VARIANT(variant))
+		TYPE_FIELDS(variant) = newtree[0];
 
 	/*
 	 * force a re-layout of the main variant
@@ -473,10 +459,8 @@ static void randomize_type(tree type)
 	if (lookup_attribute("randomize_layout", TYPE_ATTRIBUTES(TYPE_MAIN_VARIANT(type))) || is_pure_ops_struct(type))
 		relayout_struct(type);
 
-	for (variant = TYPE_MAIN_VARIANT(type); variant; variant = TYPE_NEXT_VARIANT(variant)) {
-		TYPE_ATTRIBUTES(type) = copy_list(TYPE_ATTRIBUTES(type));
-		TYPE_ATTRIBUTES(type) = tree_cons(get_identifier("randomize_considered"), NULL_TREE, TYPE_ATTRIBUTES(type));
-	}
+	add_type_attr(type, "randomize_considered", NULL_TREE);
+
 #ifdef __DEBUG_PLUGIN
 	fprintf(stderr, "Marking randomize_considered on struct %s\n", ORIG_TYPE_NAME(type));
 #ifdef __DEBUG_VERBOSE
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 6bc441fa6abe..8235e3fe4846 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1820,6 +1820,7 @@ static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
 static const struct snd_pci_quirk force_connect_list[] = {
 	SND_PCI_QUIRK(0x103c, 0x83e2, "HP EliteDesk 800 G4", 1),
 	SND_PCI_QUIRK(0x103c, 0x83ef, "HP MP9 G4 Retail System AMS", 1),
+	SND_PCI_QUIRK(0x103c, 0x845a, "HP EliteDesk 800 G4 DM 65W", 1),
 	SND_PCI_QUIRK(0x103c, 0x870f, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x8711, "HP", 1),
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3d12c489ba1e..f9f4a914de6e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8390,6 +8390,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x877d, "HP", ALC236_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x89aa, "HP EliteBook 630 G9", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e1d, "HP ZBook X Gli 16 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 04267d4e3ecf..bc065ec997f3 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -2587,9 +2587,11 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 			snd_dragonfly_quirk_db_scale(mixer, cval, kctl);
 		break;
 	/* lowest playback value is muted on some devices */
+	case USB_ID(0x0572, 0x1b09): /* Conexant Systems (Rockwell), Inc. */
 	case USB_ID(0x0d8c, 0x000c): /* C-Media */
 	case USB_ID(0x0d8c, 0x0014): /* C-Media */
 	case USB_ID(0x19f7, 0x0003): /* RODE NT-USB */
+	case USB_ID(0x2d99, 0x0026): /* HECATE G2 GAMING HEADSET */
 		if (strstr(kctl->id.name, "Playback"))
 			cval->min_mute = 1;
 		break;

