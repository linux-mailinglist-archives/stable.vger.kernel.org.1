Return-Path: <stable+bounces-163284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F7AB092A3
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 19:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCAF4E4032
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF3D2FEE14;
	Thu, 17 Jul 2025 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JoFy8uZK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBF72FEE0A;
	Thu, 17 Jul 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771851; cv=none; b=FkX68Rq54xWJ/5yRdm4KpsHhAt7HIo0SM/1tYtS3/MfFCp/wuTE4TfyKzGIkt0wdgeJfqsIoSuRXcNBUgptS1qLtV1akICVfzCK1e0RHiElQhAAxMnIfqrzWlDY0nZz8Yw06CybBX6/ceQRXbjmcPdlpCwvpvyI7Cf8+nBQTimw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771851; c=relaxed/simple;
	bh=Tmmb8ElUHoLOWwErXC6DxGWBXbXFikEzjgyxXOxqmRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2l1HZVG5olXghapbYIhVg3ZOOcsD0U818TOtn8bvSly6loOiEJzagTQC9a9dBNLyNTvXpRlsCuepa9AgPGSxTzKnQDSBNIdK56JL+PYPOMXdbxHcbQAnQUSL/MYDheXjXRJ47l91ruFfEvj1lWlCLZJTUdPCDHukMlQiFRnX0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JoFy8uZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26F6C4AF09;
	Thu, 17 Jul 2025 17:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752771850;
	bh=Tmmb8ElUHoLOWwErXC6DxGWBXbXFikEzjgyxXOxqmRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JoFy8uZKsFBpZM2jPSxqH7scJNi7eJu9UsgaKqfrqDRY3koM6O0rBYR6InNtrc6ne
	 aMI7cLmlO3z83Zn+zKwmDL1xcORFaH22tcgDz/VecZuEhoNxif4R+xnKpaXrHBHkY7
	 rCgyUY0iIsLY+yZhnt3gb+w6nQoGFOOwGTXx3OIk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.146
Date: Thu, 17 Jul 2025 19:03:55 +0200
Message-ID: <2025071755-award-shortness-a98e@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025071755-dispute-neutron-dff5@gregkh>
References: <2025071755-dispute-neutron-dff5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index ebcf5587ebf9..7ebae10b5939 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 145
+SUBLEVEL = 146
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 2baa8d4a33ed..1a068859a418 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1600,35 +1600,19 @@ static void vector_eth_configure(
 
 	device->dev = dev;
 
-	*vp = ((struct vector_private)
-		{
-		.list			= LIST_HEAD_INIT(vp->list),
-		.dev			= dev,
-		.unit			= n,
-		.options		= get_transport_options(def),
-		.rx_irq			= 0,
-		.tx_irq			= 0,
-		.parsed			= def,
-		.max_packet		= get_mtu(def) + ETH_HEADER_OTHER,
-		/* TODO - we need to calculate headroom so that ip header
-		 * is 16 byte aligned all the time
-		 */
-		.headroom		= get_headroom(def),
-		.form_header		= NULL,
-		.verify_header		= NULL,
-		.header_rxbuffer	= NULL,
-		.header_txbuffer	= NULL,
-		.header_size		= 0,
-		.rx_header_size		= 0,
-		.rexmit_scheduled	= false,
-		.opened			= false,
-		.transport_data		= NULL,
-		.in_write_poll		= false,
-		.coalesce		= 2,
-		.req_size		= get_req_size(def),
-		.in_error		= false,
-		.bpf			= NULL
-	});
+	INIT_LIST_HEAD(&vp->list);
+	vp->dev		= dev;
+	vp->unit	= n;
+	vp->options	= get_transport_options(def);
+	vp->parsed	= def;
+	vp->max_packet	= get_mtu(def) + ETH_HEADER_OTHER;
+	/*
+	 * TODO - we need to calculate headroom so that ip header
+	 * is 16 byte aligned all the time
+	 */
+	vp->headroom	= get_headroom(def);
+	vp->coalesce	= 2;
+	vp->req_size	= get_req_size(def);
 
 	dev->features = dev->hw_features = (NETIF_F_SG | NETIF_F_FRAGLIST);
 	INIT_WORK(&vp->reset_tx, vector_reset_tx);
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1da950b1d41a..f23510275076 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -124,7 +124,7 @@ config X86
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_GENERAL_HUGETLB
-	select ARCH_WANT_HUGE_PMD_SHARE
+	select ARCH_WANT_HUGE_PMD_SHARE		if X86_64
 	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP	if X86_64
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_THP_SWAP		if X86_64
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 3419ffa2a350..a4764ec92373 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -43,7 +43,7 @@ endif
 
 # How to compile the 16-bit code.  Note we always compile for -march=i386;
 # that way we can complain to the user if the CPU is insufficient.
-REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
+REALMODE_CFLAGS	:= -std=gnu11 -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1c71f947b426..6f6ea3b9a95e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -429,8 +429,8 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 
+#define X86_FEATURE_VERW_CLEAR		(20*32+ 5) /* "" The memory form of VERW mitigates TSA */
 #define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* "" Automatic IBRS */
-#define X86_FEATURE_VERW_CLEAR		(20*32+ 10) /* "" The memory form of VERW mitigates TSA */
 #define X86_FEATURE_SBPB		(20*32+27) /* "" Selective Branch Prediction Barrier */
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 991f38f57caf..5535749620af 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -333,7 +333,6 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 
 struct thresh_restart {
 	struct threshold_block	*b;
-	int			reset;
 	int			set_lvt_off;
 	int			lvt_off;
 	u16			old_limit;
@@ -428,13 +427,13 @@ static void threshold_restart_bank(void *_tr)
 
 	rdmsr(tr->b->address, lo, hi);
 
-	if (tr->b->threshold_limit < (hi & THRESHOLD_MAX))
-		tr->reset = 1;	/* limit cannot be lower than err count */
-
-	if (tr->reset) {		/* reset err count and overflow bit */
-		hi =
-		    (hi & ~(MASK_ERR_COUNT_HI | MASK_OVERFLOW_HI)) |
-		    (THRESHOLD_MAX - tr->b->threshold_limit);
+	/*
+	 * Reset error count and overflow bit.
+	 * This is done during init or after handling an interrupt.
+	 */
+	if (hi & MASK_OVERFLOW_HI || tr->set_lvt_off) {
+		hi &= ~(MASK_ERR_COUNT_HI | MASK_OVERFLOW_HI);
+		hi |= THRESHOLD_MAX - tr->b->threshold_limit;
 	} else if (tr->old_limit) {	/* change limit w/o reset */
 		int new_count = (hi & THRESHOLD_MAX) +
 		    (tr->old_limit - tr->b->threshold_limit);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 359218bc1b34..e65dfc88b925 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2707,15 +2707,9 @@ static int mce_cpu_dead(unsigned int cpu)
 static int mce_cpu_online(unsigned int cpu)
 {
 	struct timer_list *t = this_cpu_ptr(&mce_timer);
-	int ret;
 
 	mce_device_create(cpu);
-
-	ret = mce_threshold_create_device(cpu);
-	if (ret) {
-		mce_device_remove(cpu);
-		return ret;
-	}
+	mce_threshold_create_device(cpu);
 	mce_reenable_cpu();
 	mce_start_timer(t);
 	return 0;
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 95275a5e57e0..7d0fb5e0b32f 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -500,6 +500,7 @@ void mce_intel_feature_init(struct cpuinfo_x86 *c)
 void mce_intel_feature_clear(struct cpuinfo_x86 *c)
 {
 	intel_clear_lmce();
+	cmci_clear();
 }
 
 bool intel_filter_mce(struct mce *m)
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d8e192ad5953..0e0bc2c46b51 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1755,6 +1755,10 @@ static int sev_check_source_vcpus(struct kvm *dst, struct kvm *src)
 	struct kvm_vcpu *src_vcpu;
 	unsigned long i;
 
+	if (src->created_vcpus != atomic_read(&src->online_vcpus) ||
+	    dst->created_vcpus != atomic_read(&dst->online_vcpus))
+		return -EBUSY;
+
 	if (!sev_es_guest(src))
 		return 0;
 
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 684a39df60d9..8e38f976feb4 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1536,8 +1536,19 @@ int kvm_xen_setup_evtchn(struct kvm *kvm,
 {
 	struct kvm_vcpu *vcpu;
 
-	if (ue->u.xen_evtchn.port >= max_evtchn_port(kvm))
-		return -EINVAL;
+	/*
+	 * Don't check for the port being within range of max_evtchn_port().
+	 * Userspace can configure what ever targets it likes; events just won't
+	 * be delivered if/while the target is invalid, just like userspace can
+	 * configure MSIs which target non-existent APICs.
+	 *
+	 * This allow on Live Migration and Live Update, the IRQ routing table
+	 * can be restored *independently* of other things like creating vCPUs,
+	 * without imposing an ordering dependency on userspace.  In this
+	 * particular case, the problematic ordering would be with setting the
+	 * Xen 'long mode' flag, which changes max_evtchn_port() to allow 4096
+	 * instead of 1024 event channels.
+	 */
 
 	/* We only support 2 level event channels for now */
 	if (ue->u.xen_evtchn.priority != KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL)
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 2f188a734a0c..5a4e02266241 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -241,23 +241,10 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN) {
+		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
 			ret = -ENODEV;
-			break;
-		}
-
-		val->intval = battery->rate_now * 1000;
-		/*
-		 * When discharging, the current should be reported as a
-		 * negative number as per the power supply class interface
-		 * definition.
-		 */
-		if (psp == POWER_SUPPLY_PROP_CURRENT_NOW &&
-		    (battery->state & ACPI_BATTERY_STATE_DISCHARGING) &&
-		    acpi_battery_handle_discharging(battery)
-				== POWER_SUPPLY_STATUS_DISCHARGING)
-			val->intval = -val->intval;
-
+		else
+			val->intval = battery->rate_now * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index 7810f974b2ca..d9ee20f0048f 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -852,6 +852,8 @@ queue_skb(struct idt77252_dev *card, struct vc_map *vc,
 
 	IDT77252_PRV_PADDR(skb) = dma_map_single(&card->pcidev->dev, skb->data,
 						 skb->len, DMA_TO_DEVICE);
+	if (dma_mapping_error(&card->pcidev->dev, IDT77252_PRV_PADDR(skb)))
+		return -ENOMEM;
 
 	error = -EINVAL;
 
@@ -1857,6 +1859,8 @@ add_rx_skb(struct idt77252_dev *card, int queue,
 		paddr = dma_map_single(&card->pcidev->dev, skb->data,
 				       skb_end_pointer(skb) - skb->data,
 				       DMA_FROM_DEVICE);
+		if (dma_mapping_error(&card->pcidev->dev, paddr))
+			goto outpoolrm;
 		IDT77252_PRV_PADDR(skb) = paddr;
 
 		if (push_rx_skb(card, skb, queue)) {
@@ -1871,6 +1875,7 @@ add_rx_skb(struct idt77252_dev *card, int queue,
 	dma_unmap_single(&card->pcidev->dev, IDT77252_PRV_PADDR(skb),
 			 skb_end_pointer(skb) - skb->data, DMA_FROM_DEVICE);
 
+outpoolrm:
 	handle = IDT77252_PRV_POOL(skb);
 	card->sbpool[POOL_QUEUE(handle)].skb[POOL_INDEX(handle)] = NULL;
 
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7f6ef0a2b4a5..120b75ee703d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2089,9 +2089,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 				goto out;
 		}
 	}
-	ret = nbd_start_device(nbd);
-	if (ret)
-		goto out;
+
 	if (info->attrs[NBD_ATTR_BACKEND_IDENTIFIER]) {
 		nbd->backend = nla_strdup(info->attrs[NBD_ATTR_BACKEND_IDENTIFIER],
 					  GFP_KERNEL);
@@ -2107,6 +2105,8 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 	set_bit(NBD_RT_HAS_BACKEND_FILE, &config->runtime_flags);
+
+	ret = nbd_start_device(nbd);
 out:
 	mutex_unlock(&nbd->config_lock);
 	if (!ret) {
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 5d403fb5bd92..e4ac38b39889 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -1241,7 +1241,7 @@ int ipmi_create_user(unsigned int          if_num,
 	}
 	/* Not found, return an error */
 	rv = -EINVAL;
-	goto out_kfree;
+	goto out_unlock;
 
  found:
 	if (atomic_add_return(1, &intf->nr_users) > max_users) {
@@ -1283,6 +1283,7 @@ int ipmi_create_user(unsigned int          if_num,
 
 out_kfree:
 	atomic_dec(&intf->nr_users);
+out_unlock:
 	srcu_read_unlock(&ipmi_interfaces_srcu, index);
 	vfree(new_user);
 	return rv;
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index b87ed4238fc8..ebf60c8d98ed 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -236,6 +236,9 @@ drm_gem_object_release_handle(int id, void *ptr, void *data)
 	struct drm_file *file_priv = data;
 	struct drm_gem_object *obj = ptr;
 
+	if (drm_WARN_ON(obj->dev, !data))
+		return 0;
+
 	if (obj->funcs->close)
 		obj->funcs->close(obj, file_priv);
 
@@ -363,7 +366,7 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
 	idr_preload(GFP_KERNEL);
 	spin_lock(&file_priv->table_lock);
 
-	ret = idr_alloc(&file_priv->object_idr, obj, 1, 0, GFP_NOWAIT);
+	ret = idr_alloc(&file_priv->object_idr, NULL, 1, 0, GFP_NOWAIT);
 
 	spin_unlock(&file_priv->table_lock);
 	idr_preload_end();
@@ -384,6 +387,11 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
 			goto err_revoke;
 	}
 
+	/* mirrors drm_gem_handle_delete to avoid races */
+	spin_lock(&file_priv->table_lock);
+	obj = idr_replace(&file_priv->object_idr, obj, handle);
+	WARN_ON(obj != NULL);
+	spin_unlock(&file_priv->table_lock);
 	*handlep = handle;
 	return 0;
 
diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 7080cf7952ec..e52f72cc000e 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -602,6 +602,10 @@ static irqreturn_t decon_irq_handler(int irq, void *dev_id)
 	if (!ctx->drm_dev)
 		goto out;
 
+	/* check if crtc and vblank have been initialized properly */
+	if (!drm_dev_has_vblank(ctx->drm_dev))
+		goto out;
+
 	if (!ctx->i80_if) {
 		drm_crtc_handle_vblank(&ctx->crtc->base);
 
diff --git a/drivers/gpu/drm/tegra/nvdec.c b/drivers/gpu/drm/tegra/nvdec.c
index 276fe0472730..99ada87e2589 100644
--- a/drivers/gpu/drm/tegra/nvdec.c
+++ b/drivers/gpu/drm/tegra/nvdec.c
@@ -209,10 +209,8 @@ static int nvdec_load_firmware(struct nvdec *nvdec)
 
 	if (!client->group) {
 		virt = dma_alloc_coherent(nvdec->dev, size, &iova, GFP_KERNEL);
-
-		err = dma_mapping_error(nvdec->dev, iova);
-		if (err < 0)
-			return err;
+		if (!virt)
+			return -ENOMEM;
 	} else {
 		virt = tegra_drm_alloc(tegra, size, &iova);
 	}
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index dcb2c23dc6de..7f97c97b49bd 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -244,6 +244,13 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 	ret = dma_resv_trylock(&fbo->base.base._resv);
 	WARN_ON(!ret);
 
+	ret = dma_resv_reserve_fences(&fbo->base.base._resv, 1);
+	if (ret) {
+		dma_resv_unlock(&fbo->base.base._resv);
+		kfree(fbo);
+		return ret;
+	}
+
 	if (fbo->base.resource) {
 		ttm_resource_set_bo(fbo->base.resource, &fbo->base);
 		bo->resource = NULL;
@@ -252,12 +259,6 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 		fbo->base.bulk_move = NULL;
 	}
 
-	ret = dma_resv_reserve_fences(&fbo->base.base._resv, 1);
-	if (ret) {
-		kfree(fbo);
-		return ret;
-	}
-
 	ttm_bo_get(bo);
 	fbo->bo = bo;
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e078d2ac92c8..0bbba80d6c51 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -297,6 +297,8 @@
 #define USB_DEVICE_ID_ASUS_AK1D		0x1125
 #define USB_DEVICE_ID_CHICONY_TOSHIBA_WT10A	0x1408
 #define USB_DEVICE_ID_CHICONY_ACER_SWITCH12	0x1421
+#define USB_DEVICE_ID_CHICONY_HP_5MP_CAMERA	0xb824
+#define USB_DEVICE_ID_CHICONY_HP_5MP_CAMERA2	0xb82c
 
 #define USB_VENDOR_ID_CHUNGHWAT		0x2247
 #define USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH	0x0001
@@ -790,6 +792,7 @@
 #define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
 #define USB_DEVICE_ID_LENOVO_X1_COVER	0x6085
 #define USB_DEVICE_ID_LENOVO_X1_TAB	0x60a3
+#define USB_DEVICE_ID_LENOVO_X1_TAB2	0x60a4
 #define USB_DEVICE_ID_LENOVO_X1_TAB3	0x60b5
 #define USB_DEVICE_ID_LENOVO_X12_TAB	0x60fe
 #define USB_DEVICE_ID_LENOVO_X12_TAB2	0x61ae
@@ -1454,4 +1457,7 @@
 #define USB_VENDOR_ID_SIGNOTEC			0x2133
 #define USB_DEVICE_ID_SIGNOTEC_VIEWSONIC_PD1011	0x0018
 
+#define USB_VENDOR_ID_SMARTLINKTECHNOLOGY              0x4c4a
+#define USB_DEVICE_ID_SMARTLINKTECHNOLOGY_4155         0x4155
+
 #endif
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index ee65da98c7d5..32cb2e75228c 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -473,6 +473,7 @@ static int lenovo_input_mapping(struct hid_device *hdev,
 		return lenovo_input_mapping_tp10_ultrabook_kbd(hdev, hi, field,
 							       usage, bit, max);
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
+	case USB_DEVICE_ID_LENOVO_X1_TAB2:
 	case USB_DEVICE_ID_LENOVO_X1_TAB3:
 		return lenovo_input_mapping_x1_tab_kbd(hdev, hi, field, usage, bit, max);
 	default:
@@ -587,6 +588,7 @@ static ssize_t attr_fn_lock_store(struct device *dev,
 		break;
 	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
+	case USB_DEVICE_ID_LENOVO_X1_TAB2:
 	case USB_DEVICE_ID_LENOVO_X1_TAB3:
 		ret = lenovo_led_set_tp10ubkbd(hdev, TP10UBKBD_FN_LOCK_LED, value);
 		if (ret)
@@ -782,6 +784,7 @@ static int lenovo_event(struct hid_device *hdev, struct hid_field *field,
 		return lenovo_event_cptkbd(hdev, field, usage, value);
 	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
+	case USB_DEVICE_ID_LENOVO_X1_TAB2:
 	case USB_DEVICE_ID_LENOVO_X1_TAB3:
 		return lenovo_event_tp10ubkbd(hdev, field, usage, value);
 	default:
@@ -1065,6 +1068,7 @@ static int lenovo_led_brightness_set(struct led_classdev *led_cdev,
 		break;
 	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
+	case USB_DEVICE_ID_LENOVO_X1_TAB2:
 	case USB_DEVICE_ID_LENOVO_X1_TAB3:
 		ret = lenovo_led_set_tp10ubkbd(hdev, tp10ubkbd_led[led_nr], value);
 		break;
@@ -1296,6 +1300,7 @@ static int lenovo_probe(struct hid_device *hdev,
 		break;
 	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
+	case USB_DEVICE_ID_LENOVO_X1_TAB2:
 	case USB_DEVICE_ID_LENOVO_X1_TAB3:
 		ret = lenovo_probe_tp10ubkbd(hdev);
 		break;
@@ -1383,6 +1388,7 @@ static void lenovo_remove(struct hid_device *hdev)
 		break;
 	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
 	case USB_DEVICE_ID_LENOVO_X1_TAB:
+	case USB_DEVICE_ID_LENOVO_X1_TAB2:
 	case USB_DEVICE_ID_LENOVO_X1_TAB3:
 		lenovo_remove_tp10ubkbd(hdev);
 		break;
@@ -1433,6 +1439,8 @@ static const struct hid_device_id lenovo_devices[] = {
 	 */
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_TAB) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_TAB2) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_TAB3) },
 	{ }
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 6386043aab0b..becd4c1ccf93 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2110,12 +2110,18 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_GENERIC,
 			USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_7010) },
 
-	/* Lenovo X1 TAB Gen 2 */
+	/* Lenovo X1 TAB Gen 1 */
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
 		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
 			   USB_VENDOR_ID_LENOVO,
 			   USB_DEVICE_ID_LENOVO_X1_TAB) },
 
+	/* Lenovo X1 TAB Gen 2 */
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
+			   USB_VENDOR_ID_LENOVO,
+			   USB_DEVICE_ID_LENOVO_X1_TAB2) },
+
 	/* Lenovo X1 TAB Gen 3 */
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
 		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index d8c5c7d451ef..b37927f90941 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -738,6 +738,8 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AVERMEDIA, USB_DEVICE_ID_AVER_FM_MR800) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AXENTIA, USB_DEVICE_ID_AXENTIA_FM_RADIO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_HP_5MP_CAMERA) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_HP_5MP_CAMERA2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CIDC, 0x0103) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI470X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI4713) },
@@ -885,6 +887,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 #endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_HP_5MP_CAMERA_5473) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SMARTLINKTECHNOLOGY, USB_DEVICE_ID_SMARTLINKTECHNOLOGY_4155) },
 	{ }
 };
 
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 872381221e75..7c11d9a1de0e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -167,6 +167,7 @@ static const struct xpad_device {
 	{ 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)", 0, XTYPE_XBOX },
 	{ 0x05fe, 0x3030, "Chic Controller", 0, XTYPE_XBOX },
 	{ 0x05fe, 0x3031, "Chic Controller", 0, XTYPE_XBOX },
+	{ 0x0502, 0x1305, "Acer NGR200", 0, XTYPE_XBOX },
 	{ 0x062a, 0x0020, "Logic3 Xbox GamePad", 0, XTYPE_XBOX },
 	{ 0x062a, 0x0033, "Competition Pro Steering Wheel", 0, XTYPE_XBOX },
 	{ 0x06a3, 0x0200, "Saitek Racing Wheel", 0, XTYPE_XBOX },
@@ -468,6 +469,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft X-Box One controllers */
 	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
+	XPAD_XBOX360_VENDOR(0x0502),		/* Acer Inc. X-Box 360 style controllers */
 	XPAD_XBOX360_VENDOR(0x056e),		/* Elecom JC-U3613M */
 	XPAD_XBOX360_VENDOR(0x06a3),		/* Saitek P3600 */
 	XPAD_XBOX360_VENDOR(0x0738),		/* Mad Catz X-Box 360 controllers */
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index b3a856333d4e..de59fc1a24bc 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -807,7 +807,7 @@ static int atkbd_probe(struct atkbd *atkbd)
 
 	if (atkbd_skip_getid(atkbd)) {
 		atkbd->id = 0xab83;
-		return 0;
+		goto deactivate_kbd;
 	}
 
 /*
@@ -844,6 +844,7 @@ static int atkbd_probe(struct atkbd *atkbd)
 		return -1;
 	}
 
+deactivate_kbd:
 /*
  * Make sure nothing is coming from the keyboard and disturbs our
  * internal state.
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index dac27206cd3d..898ff417928f 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2029,8 +2029,7 @@ int md_bitmap_get_stats(struct bitmap *bitmap, struct md_bitmap_stats *stats)
 
 	if (!bitmap)
 		return -ENOENT;
-	if (!bitmap->mddev->bitmap_info.external &&
-	    !bitmap->storage.sb_page)
+	if (!bitmap->storage.sb_page)
 		return -EINVAL;
 	sb = kmap_local_page(bitmap->storage.sb_page);
 	stats->sync_size = le64_to_cpu(sb->sync_size);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 38e77a4b6b33..ebff40a3423a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3306,6 +3306,7 @@ static int raid1_reshape(struct mddev *mddev)
 	/* ok, everything is stopped */
 	oldpool = conf->r1bio_pool;
 	conf->r1bio_pool = newpool;
+	init_waitqueue_head(&conf->r1bio_pool.wait);
 
 	for (d = d2 = 0; d < conf->raid_disks; d++) {
 		struct md_rdev *rdev = conf->mirrors[d].rdev;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 24427eddf61b..2ae68b7b7959 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1210,8 +1210,11 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 		rcu_read_unlock();
 	}
 
-	if (!regular_request_wait(mddev, conf, bio, r10_bio->sectors))
+	if (!regular_request_wait(mddev, conf, bio, r10_bio->sectors)) {
+		raid_end_bio_io(r10_bio);
 		return;
+	}
+
 	rdev = read_balance(conf, r10_bio, &max_sectors);
 	if (!rdev) {
 		if (err_rdev) {
@@ -1432,8 +1435,11 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 	}
 
 	sectors = r10_bio->sectors;
-	if (!regular_request_wait(mddev, conf, bio, sectors))
+	if (!regular_request_wait(mddev, conf, bio, sectors)) {
+		raid_end_bio_io(r10_bio);
 		return;
+	}
+
 	if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
 	    (mddev->reshape_backwards
 	     ? (bio->bi_iter.bi_sector < conf->reshape_safe &&
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 56b0f49c8116..814f947e7f50 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -577,7 +577,7 @@ static int m_can_handle_lost_msg(struct net_device *dev)
 	struct can_frame *frame;
 	u32 timestamp = 0;
 
-	netdev_err(dev, "msg lost in rxf0\n");
+	netdev_dbg(dev, "msg lost in rxf0\n");
 
 	stats->rx_errors++;
 	stats->rx_over_errors++;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
index 63e067038385..1727e9bb1479 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -487,7 +487,9 @@ static int bnxt_ets_validate(struct bnxt *bp, struct ieee_ets *ets, u8 *tc)
 
 		if ((ets->tc_tx_bw[i] || ets->tc_tsa[i]) && i > bp->max_tc)
 			return -EINVAL;
+	}
 
+	for (i = 0; i < max_tc; i++) {
 		switch (ets->tc_tsa[i]) {
 		case IEEE_8021QAZ_TSA_STRICT:
 			break;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index d9a7b85343a4..967a7fa291ea 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -122,7 +122,7 @@ static void __bnxt_xmit_xdp_redirect(struct bnxt *bp,
 	tx_buf->action = XDP_REDIRECT;
 	tx_buf->xdpf = xdpf;
 	dma_unmap_addr_set(tx_buf, mapping, mapping);
-	dma_unmap_len_set(tx_buf, len, 0);
+	dma_unmap_len_set(tx_buf, len, len);
 }
 
 void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index f923cdab03f5..91291b5e8a2a 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -211,7 +211,6 @@ struct ibmvnic_statistics {
 	u8 reserved[72];
 } __packed __aligned(8);
 
-#define NUM_TX_STATS 3
 struct ibmvnic_tx_queue_stats {
 	u64 batched_packets;
 	u64 direct_packets;
@@ -219,13 +218,18 @@ struct ibmvnic_tx_queue_stats {
 	u64 dropped_packets;
 };
 
-#define NUM_RX_STATS 3
+#define NUM_TX_STATS \
+	(sizeof(struct ibmvnic_tx_queue_stats) / sizeof(u64))
+
 struct ibmvnic_rx_queue_stats {
 	u64 packets;
 	u64 bytes;
 	u64 interrupts;
 };
 
+#define NUM_RX_STATS \
+	(sizeof(struct ibmvnic_rx_queue_stats) / sizeof(u64))
+
 struct ibmvnic_acl_buffer {
 	__be32 len;
 	__be32 version;
diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 08c45756b218..d9b5c1c6ceaa 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1311,7 +1311,7 @@ ll_temac_ethtools_set_ringparam(struct net_device *ndev,
 	if (ering->rx_pending > RX_BD_NUM_MAX ||
 	    ering->rx_mini_pending ||
 	    ering->rx_jumbo_pending ||
-	    ering->rx_pending > TX_BD_NUM_MAX)
+	    ering->tx_pending > TX_BD_NUM_MAX)
 		return -EINVAL;
 
 	if (netif_running(ndev))
diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index 0b88635f4fbc..3750f8778c65 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -351,7 +351,7 @@ static void lan88xx_link_change_notify(struct phy_device *phydev)
 	 * As workaround, set to 10 before setting to 100
 	 * at forced 100 F/H mode.
 	 */
-	if (!phydev->autoneg && phydev->speed == 100) {
+	if (phydev->state == PHY_NOLINK && !phydev->autoneg && phydev->speed == 100) {
 		/* disable phy interrupt */
 		temp = phy_read(phydev, LAN88XX_INT_MASK);
 		temp &= ~LAN88XX_INT_MASK_MDINTPIN_EN_;
diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index df2c5435c5c4..5186cc97c655 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -136,10 +136,29 @@ static int smsc_phy_reset(struct phy_device *phydev)
 
 static int lan87xx_config_aneg(struct phy_device *phydev)
 {
-	int rc;
+	u8 mdix_ctrl;
 	int val;
+	int rc;
 
-	switch (phydev->mdix_ctrl) {
+	/* When auto-negotiation is disabled (forced mode), the PHY's
+	 * Auto-MDIX will continue toggling the TX/RX pairs.
+	 *
+	 * To establish a stable link, we must select a fixed MDI mode.
+	 * If the user has not specified a fixed MDI mode (i.e., mdix_ctrl is
+	 * 'auto'), we default to ETH_TP_MDI. This choice of a ETH_TP_MDI mode
+	 * mirrors the behavior the hardware would exhibit if the AUTOMDIX_EN
+	 * strap were configured for a fixed MDI connection.
+	 */
+	if (phydev->autoneg == AUTONEG_DISABLE) {
+		if (phydev->mdix_ctrl == ETH_TP_MDI_AUTO)
+			mdix_ctrl = ETH_TP_MDI;
+		else
+			mdix_ctrl = phydev->mdix_ctrl;
+	} else {
+		mdix_ctrl = phydev->mdix_ctrl;
+	}
+
+	switch (mdix_ctrl) {
 	case ETH_TP_MDI:
 		val = SPECIAL_CTRL_STS_OVRRD_AMDIX_;
 		break;
@@ -148,7 +167,8 @@ static int lan87xx_config_aneg(struct phy_device *phydev)
 			SPECIAL_CTRL_STS_AMDIX_STATE_;
 		break;
 	case ETH_TP_MDI_AUTO:
-		val = SPECIAL_CTRL_STS_AMDIX_ENABLE_;
+		val = SPECIAL_CTRL_STS_OVRRD_AMDIX_ |
+			SPECIAL_CTRL_STS_AMDIX_ENABLE_;
 		break;
 	default:
 		return genphy_config_aneg(phydev);
@@ -164,7 +184,7 @@ static int lan87xx_config_aneg(struct phy_device *phydev)
 	rc |= val;
 	phy_write(phydev, SPECIAL_CTRL_STS, rc);
 
-	phydev->mdix = phydev->mdix_ctrl;
+	phydev->mdix = mdix_ctrl;
 	return genphy_config_aneg(phydev);
 }
 
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index b4c0413c6522..96656e56e809 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1431,6 +1431,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x22de, 0x9051, 2)}, /* Hucom Wireless HM-211S/K */
 	{QMI_FIXED_INTF(0x22de, 0x9061, 3)},	/* WeTelecom WPD-600N */
 	{QMI_QUIRK_SET_DTR(0x1e0e, 0x9001, 5)},	/* SIMCom 7100E, 7230E, 7600E ++ */
+	{QMI_QUIRK_SET_DTR(0x1e0e, 0x9071, 3)},	/* SIMCom 8230C ++ */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0121, 4)},	/* Quectel EC21 Mini PCIe */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0195, 4)},	/* Quectel EG95 */
diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
index 80b905d49954..57269c317ce2 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
@@ -583,7 +583,11 @@ void zd_mac_tx_to_dev(struct sk_buff *skb, int error)
 
 		skb_queue_tail(q, skb);
 		while (skb_queue_len(q) > ZD_MAC_MAX_ACK_WAITERS) {
-			zd_mac_tx_status(hw, skb_dequeue(q),
+			skb = skb_dequeue(q);
+			if (!skb)
+				break;
+
+			zd_mac_tx_status(hw, skb,
 					 mac->ack_pending ? mac->ack_signal : 0,
 					 NULL);
 			mac->ack_pending = 0;
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 7d25d95e156c..34fc47c5c65a 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1000,6 +1000,25 @@ static bool msm_gpio_needs_dual_edge_parent_workaround(struct irq_data *d,
 	       test_bit(d->hwirq, pctrl->skip_wake_irqs);
 }
 
+static void msm_gpio_irq_init_valid_mask(struct gpio_chip *gc,
+					 unsigned long *valid_mask,
+					 unsigned int ngpios)
+{
+	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
+	const struct msm_pingroup *g;
+	int i;
+
+	bitmap_fill(valid_mask, ngpios);
+
+	for (i = 0; i < ngpios; i++) {
+		g = &pctrl->soc->groups[i];
+
+		if (g->intr_detection_width != 1 &&
+		    g->intr_detection_width != 2)
+			clear_bit(i, valid_mask);
+	}
+}
+
 static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
@@ -1358,6 +1377,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_bad_irq;
 	girq->parents[0] = pctrl->irq;
+	girq->init_valid_mask = msm_gpio_irq_init_valid_mask;
 
 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 6674ad529ae9..bddd240d68ab 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/fb.h>
@@ -223,6 +224,20 @@ static void ideapad_shared_exit(struct ideapad_private *priv)
  */
 #define IDEAPAD_EC_TIMEOUT 200 /* in ms */
 
+/*
+ * Some models (e.g., ThinkBook since 2024) have a low tolerance for being
+ * polled too frequently. Doing so may break the state machine in the EC,
+ * resulting in a hard shutdown.
+ *
+ * It is also observed that frequent polls may disturb the ongoing operation
+ * and notably delay the availability of EC response.
+ *
+ * These values are used as the delay before the first poll and the interval
+ * between subsequent polls to solve the above issues.
+ */
+#define IDEAPAD_EC_POLL_MIN_US 150
+#define IDEAPAD_EC_POLL_MAX_US 300
+
 static int eval_int(acpi_handle handle, const char *name, unsigned long *res)
 {
 	unsigned long long result;
@@ -328,7 +343,7 @@ static int read_ec_data(acpi_handle handle, unsigned long cmd, unsigned long *da
 	end_jiffies = jiffies + msecs_to_jiffies(IDEAPAD_EC_TIMEOUT) + 1;
 
 	while (time_before(jiffies, end_jiffies)) {
-		schedule();
+		usleep_range(IDEAPAD_EC_POLL_MIN_US, IDEAPAD_EC_POLL_MAX_US);
 
 		err = eval_vpcr(handle, 1, &val);
 		if (err)
@@ -359,7 +374,7 @@ static int write_ec_cmd(acpi_handle handle, unsigned long cmd, unsigned long dat
 	end_jiffies = jiffies + msecs_to_jiffies(IDEAPAD_EC_TIMEOUT) + 1;
 
 	while (time_before(jiffies, end_jiffies)) {
-		schedule();
+		usleep_range(IDEAPAD_EC_POLL_MIN_US, IDEAPAD_EC_POLL_MAX_US);
 
 		err = eval_vpcr(handle, 1, &val);
 		if (err)
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 10c2ed23f551..27821f57ef6e 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -129,8 +129,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 
 	clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
-	if (!clk_rate)
-		return -EINVAL;
+	if (!clk_rate) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* Make sure we use the bus clock and not the 26MHz clock */
 	if (pc->soc->has_ck_26m_sel)
@@ -149,9 +151,9 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (clkdiv > PWM_CLK_DIV_MAX) {
-		pwm_mediatek_clk_disable(chip, pwm);
 		dev_err(chip->dev, "period of %d ns not supported\n", period_ns);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
@@ -168,9 +170,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
 
+out:
 	pwm_mediatek_clk_disable(chip, pwm);
 
-	return 0;
+	return ret;
 }
 
 static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index ccfd9d93c10c..f6457263354b 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4452,6 +4452,7 @@ void do_unblank_screen(int leaving_gfx)
 	set_palette(vc);
 	set_cursor(vc);
 	vt_event_post(VT_EVENT_UNBLANK, vc->vc_num, vc->vc_num);
+	notify_update(vc);
 }
 EXPORT_SYMBOL(do_unblank_screen);
 
diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debug.h
index f0ca865cce2a..86860686d836 100644
--- a/drivers/usb/cdns3/cdnsp-debug.h
+++ b/drivers/usb/cdns3/cdnsp-debug.h
@@ -131,8 +131,6 @@ static inline const char *cdnsp_trb_type_string(u8 type)
 		return "Endpoint Not ready";
 	case TRB_HALT_ENDPOINT:
 		return "Halt Endpoint";
-	case TRB_FLUSH_ENDPOINT:
-		return "FLush Endpoint";
 	default:
 		return "UNKNOWN";
 	}
@@ -189,203 +187,203 @@ static inline const char *cdnsp_decode_trb(char *str, size_t size, u32 field0,
 
 	switch (type) {
 	case TRB_LINK:
-		ret = snprintf(str, size,
-			       "LINK %08x%08x intr %ld type '%s' flags %c:%c:%c:%c",
-			       field1, field0, GET_INTR_TARGET(field2),
-			       cdnsp_trb_type_string(type),
-			       field3 & TRB_IOC ? 'I' : 'i',
-			       field3 & TRB_CHAIN ? 'C' : 'c',
-			       field3 & TRB_TC ? 'T' : 't',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"LINK %08x%08x intr %ld type '%s' flags %c:%c:%c:%c",
+				field1, field0, GET_INTR_TARGET(field2),
+				cdnsp_trb_type_string(type),
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_TC ? 'T' : 't',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_TRANSFER:
 	case TRB_COMPLETION:
 	case TRB_PORT_STATUS:
 	case TRB_HC_EVENT:
-		ret = snprintf(str, size,
-			       "ep%d%s(%d) type '%s' TRB %08x%08x status '%s'"
-			       " len %ld slot %ld flags %c:%c",
-			       ep_num, ep_id % 2 ? "out" : "in",
-			       TRB_TO_EP_INDEX(field3),
-			       cdnsp_trb_type_string(type), field1, field0,
-			       cdnsp_trb_comp_code_string(GET_COMP_CODE(field2)),
-			       EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
-			       field3 & EVENT_DATA ? 'E' : 'e',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"ep%d%s(%d) type '%s' TRB %08x%08x status '%s'"
+				" len %ld slot %ld flags %c:%c",
+				ep_num, ep_id % 2 ? "out" : "in",
+				TRB_TO_EP_INDEX(field3),
+				cdnsp_trb_type_string(type), field1, field0,
+				cdnsp_trb_comp_code_string(GET_COMP_CODE(field2)),
+				EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
+				field3 & EVENT_DATA ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_MFINDEX_WRAP:
-		ret = snprintf(str, size, "%s: flags %c",
-			       cdnsp_trb_type_string(type),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size, "%s: flags %c",
+				cdnsp_trb_type_string(type),
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_SETUP:
-		ret = snprintf(str, size,
-			       "type '%s' bRequestType %02x bRequest %02x "
-			       "wValue %02x%02x wIndex %02x%02x wLength %d "
-			       "length %ld TD size %ld intr %ld Setup ID %ld "
-			       "flags %c:%c:%c",
-			       cdnsp_trb_type_string(type),
-			       field0 & 0xff,
-			       (field0 & 0xff00) >> 8,
-			       (field0 & 0xff000000) >> 24,
-			       (field0 & 0xff0000) >> 16,
-			       (field1 & 0xff00) >> 8,
-			       field1 & 0xff,
-			       (field1 & 0xff000000) >> 16 |
-			       (field1 & 0xff0000) >> 16,
-			       TRB_LEN(field2), GET_TD_SIZE(field2),
-			       GET_INTR_TARGET(field2),
-			       TRB_SETUPID_TO_TYPE(field3),
-			       field3 & TRB_IDT ? 'D' : 'd',
-			       field3 & TRB_IOC ? 'I' : 'i',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"type '%s' bRequestType %02x bRequest %02x "
+				"wValue %02x%02x wIndex %02x%02x wLength %d "
+				"length %ld TD size %ld intr %ld Setup ID %ld "
+				"flags %c:%c:%c",
+				cdnsp_trb_type_string(type),
+				field0 & 0xff,
+				(field0 & 0xff00) >> 8,
+				(field0 & 0xff000000) >> 24,
+				(field0 & 0xff0000) >> 16,
+				(field1 & 0xff00) >> 8,
+				field1 & 0xff,
+				(field1 & 0xff000000) >> 16 |
+				(field1 & 0xff0000) >> 16,
+				TRB_LEN(field2), GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				TRB_SETUPID_TO_TYPE(field3),
+				field3 & TRB_IDT ? 'D' : 'd',
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_DATA:
-		ret = snprintf(str, size,
-			       "type '%s' Buffer %08x%08x length %ld TD size %ld "
-			       "intr %ld flags %c:%c:%c:%c:%c:%c:%c",
-			       cdnsp_trb_type_string(type),
-			       field1, field0, TRB_LEN(field2),
-			       GET_TD_SIZE(field2),
-			       GET_INTR_TARGET(field2),
-			       field3 & TRB_IDT ? 'D' : 'i',
-			       field3 & TRB_IOC ? 'I' : 'i',
-			       field3 & TRB_CHAIN ? 'C' : 'c',
-			       field3 & TRB_NO_SNOOP ? 'S' : 's',
-			       field3 & TRB_ISP ? 'I' : 'i',
-			       field3 & TRB_ENT ? 'E' : 'e',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"type '%s' Buffer %08x%08x length %ld TD size %ld "
+				"intr %ld flags %c:%c:%c:%c:%c:%c:%c",
+				cdnsp_trb_type_string(type),
+				field1, field0, TRB_LEN(field2),
+				GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				field3 & TRB_IDT ? 'D' : 'i',
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_NO_SNOOP ? 'S' : 's',
+				field3 & TRB_ISP ? 'I' : 'i',
+				field3 & TRB_ENT ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_STATUS:
-		ret = snprintf(str, size,
-			       "Buffer %08x%08x length %ld TD size %ld intr"
-			       "%ld type '%s' flags %c:%c:%c:%c",
-			       field1, field0, TRB_LEN(field2),
-			       GET_TD_SIZE(field2),
-			       GET_INTR_TARGET(field2),
-			       cdnsp_trb_type_string(type),
-			       field3 & TRB_IOC ? 'I' : 'i',
-			       field3 & TRB_CHAIN ? 'C' : 'c',
-			       field3 & TRB_ENT ? 'E' : 'e',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"Buffer %08x%08x length %ld TD size %ld intr"
+				"%ld type '%s' flags %c:%c:%c:%c",
+				field1, field0, TRB_LEN(field2),
+				GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				cdnsp_trb_type_string(type),
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_ENT ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_NORMAL:
 	case TRB_ISOC:
 	case TRB_EVENT_DATA:
 	case TRB_TR_NOOP:
-		ret = snprintf(str, size,
-			       "type '%s' Buffer %08x%08x length %ld "
-			       "TD size %ld intr %ld "
-			       "flags %c:%c:%c:%c:%c:%c:%c:%c:%c",
-			       cdnsp_trb_type_string(type),
-			       field1, field0, TRB_LEN(field2),
-			       GET_TD_SIZE(field2),
-			       GET_INTR_TARGET(field2),
-			       field3 & TRB_BEI ? 'B' : 'b',
-			       field3 & TRB_IDT ? 'T' : 't',
-			       field3 & TRB_IOC ? 'I' : 'i',
-			       field3 & TRB_CHAIN ? 'C' : 'c',
-			       field3 & TRB_NO_SNOOP ? 'S' : 's',
-			       field3 & TRB_ISP ? 'I' : 'i',
-			       field3 & TRB_ENT ? 'E' : 'e',
-			       field3 & TRB_CYCLE ? 'C' : 'c',
-			       !(field3 & TRB_EVENT_INVALIDATE) ? 'V' : 'v');
+		ret = scnprintf(str, size,
+				"type '%s' Buffer %08x%08x length %ld "
+				"TD size %ld intr %ld "
+				"flags %c:%c:%c:%c:%c:%c:%c:%c:%c",
+				cdnsp_trb_type_string(type),
+				field1, field0, TRB_LEN(field2),
+				GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				field3 & TRB_BEI ? 'B' : 'b',
+				field3 & TRB_IDT ? 'T' : 't',
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_NO_SNOOP ? 'S' : 's',
+				field3 & TRB_ISP ? 'I' : 'i',
+				field3 & TRB_ENT ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c',
+				!(field3 & TRB_EVENT_INVALIDATE) ? 'V' : 'v');
 		break;
 	case TRB_CMD_NOOP:
 	case TRB_ENABLE_SLOT:
-		ret = snprintf(str, size, "%s: flags %c",
-			       cdnsp_trb_type_string(type),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size, "%s: flags %c",
+				cdnsp_trb_type_string(type),
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_DISABLE_SLOT:
-		ret = snprintf(str, size, "%s: slot %ld flags %c",
-			       cdnsp_trb_type_string(type),
-			       TRB_TO_SLOT_ID(field3),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size, "%s: slot %ld flags %c",
+				cdnsp_trb_type_string(type),
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_ADDR_DEV:
-		ret = snprintf(str, size,
-			       "%s: ctx %08x%08x slot %ld flags %c:%c",
-			       cdnsp_trb_type_string(type), field1, field0,
-			       TRB_TO_SLOT_ID(field3),
-			       field3 & TRB_BSR ? 'B' : 'b',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"%s: ctx %08x%08x slot %ld flags %c:%c",
+				cdnsp_trb_type_string(type), field1, field0,
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_BSR ? 'B' : 'b',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_CONFIG_EP:
-		ret = snprintf(str, size,
-			       "%s: ctx %08x%08x slot %ld flags %c:%c",
-			       cdnsp_trb_type_string(type), field1, field0,
-			       TRB_TO_SLOT_ID(field3),
-			       field3 & TRB_DC ? 'D' : 'd',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"%s: ctx %08x%08x slot %ld flags %c:%c",
+				cdnsp_trb_type_string(type), field1, field0,
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_DC ? 'D' : 'd',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_EVAL_CONTEXT:
-		ret = snprintf(str, size,
-			       "%s: ctx %08x%08x slot %ld flags %c",
-			       cdnsp_trb_type_string(type), field1, field0,
-			       TRB_TO_SLOT_ID(field3),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"%s: ctx %08x%08x slot %ld flags %c",
+				cdnsp_trb_type_string(type), field1, field0,
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_RESET_EP:
 	case TRB_HALT_ENDPOINT:
-	case TRB_FLUSH_ENDPOINT:
-		ret = snprintf(str, size,
-			       "%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
-			       cdnsp_trb_type_string(type),
-			       ep_num, ep_id % 2 ? "out" : "in",
-			       TRB_TO_EP_INDEX(field3), field1, field0,
-			       TRB_TO_SLOT_ID(field3),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c %c",
+				cdnsp_trb_type_string(type),
+				ep_num, ep_id % 2 ? "out" : "in",
+				TRB_TO_EP_INDEX(field3), field1, field0,
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c',
+				field3 & TRB_ESP ? 'P' : 'p');
 		break;
 	case TRB_STOP_RING:
-		ret = snprintf(str, size,
-			       "%s: ep%d%s(%d) slot %ld sp %d flags %c",
-			       cdnsp_trb_type_string(type),
-			       ep_num, ep_id % 2 ? "out" : "in",
-			       TRB_TO_EP_INDEX(field3),
-			       TRB_TO_SLOT_ID(field3),
-			       TRB_TO_SUSPEND_PORT(field3),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"%s: ep%d%s(%d) slot %ld sp %d flags %c",
+				cdnsp_trb_type_string(type),
+				ep_num, ep_id % 2 ? "out" : "in",
+				TRB_TO_EP_INDEX(field3),
+				TRB_TO_SLOT_ID(field3),
+				TRB_TO_SUSPEND_PORT(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_SET_DEQ:
-		ret = snprintf(str, size,
-			       "%s: ep%d%s(%d) deq %08x%08x stream %ld slot %ld  flags %c",
-			       cdnsp_trb_type_string(type),
-			       ep_num, ep_id % 2 ? "out" : "in",
-			       TRB_TO_EP_INDEX(field3), field1, field0,
-			       TRB_TO_STREAM_ID(field2),
-			       TRB_TO_SLOT_ID(field3),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"%s: ep%d%s(%d) deq %08x%08x stream %ld slot %ld  flags %c",
+				cdnsp_trb_type_string(type),
+				ep_num, ep_id % 2 ? "out" : "in",
+				TRB_TO_EP_INDEX(field3), field1, field0,
+				TRB_TO_STREAM_ID(field2),
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_RESET_DEV:
-		ret = snprintf(str, size, "%s: slot %ld flags %c",
-			       cdnsp_trb_type_string(type),
-			       TRB_TO_SLOT_ID(field3),
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size, "%s: slot %ld flags %c",
+				cdnsp_trb_type_string(type),
+				TRB_TO_SLOT_ID(field3),
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_ENDPOINT_NRDY:
 		temp = TRB_TO_HOST_STREAM(field2);
 
-		ret = snprintf(str, size,
-			       "%s: ep%d%s(%d) H_SID %x%s%s D_SID %lx flags %c:%c",
-			       cdnsp_trb_type_string(type),
-			       ep_num, ep_id % 2 ? "out" : "in",
-			       TRB_TO_EP_INDEX(field3), temp,
-			       temp == STREAM_PRIME_ACK ? "(PRIME)" : "",
-			       temp == STREAM_REJECTED ? "(REJECTED)" : "",
-			       TRB_TO_DEV_STREAM(field0),
-			       field3 & TRB_STAT ? 'S' : 's',
-			       field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = scnprintf(str, size,
+				"%s: ep%d%s(%d) H_SID %x%s%s D_SID %lx flags %c:%c",
+				cdnsp_trb_type_string(type),
+				ep_num, ep_id % 2 ? "out" : "in",
+				TRB_TO_EP_INDEX(field3), temp,
+				temp == STREAM_PRIME_ACK ? "(PRIME)" : "",
+				temp == STREAM_REJECTED ? "(REJECTED)" : "",
+				TRB_TO_DEV_STREAM(field0),
+				field3 & TRB_STAT ? 'S' : 's',
+				field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	default:
-		ret = snprintf(str, size,
-			       "type '%s' -> raw %08x %08x %08x %08x",
-			       cdnsp_trb_type_string(type),
-			       field0, field1, field2, field3);
+		ret = scnprintf(str, size,
+				"type '%s' -> raw %08x %08x %08x %08x",
+				cdnsp_trb_type_string(type),
+				field0, field1, field2, field3);
 	}
 
-	if (ret >= size)
-		pr_info("CDNSP: buffer overflowed.\n");
+	if (ret == size - 1)
+		pr_info("CDNSP: buffer may be truncated.\n");
 
 	return str;
 }
@@ -468,32 +466,32 @@ static inline const char *cdnsp_decode_portsc(char *str, size_t size,
 {
 	int ret;
 
-	ret = snprintf(str, size, "%s %s %s Link:%s PortSpeed:%d ",
-		       portsc & PORT_POWER ? "Powered" : "Powered-off",
-		       portsc & PORT_CONNECT ? "Connected" : "Not-connected",
-		       portsc & PORT_PED ? "Enabled" : "Disabled",
-		       cdnsp_portsc_link_state_string(portsc),
-		       DEV_PORT_SPEED(portsc));
+	ret = scnprintf(str, size, "%s %s %s Link:%s PortSpeed:%d ",
+			portsc & PORT_POWER ? "Powered" : "Powered-off",
+			portsc & PORT_CONNECT ? "Connected" : "Not-connected",
+			portsc & PORT_PED ? "Enabled" : "Disabled",
+			cdnsp_portsc_link_state_string(portsc),
+			DEV_PORT_SPEED(portsc));
 
 	if (portsc & PORT_RESET)
-		ret += snprintf(str + ret, size - ret, "In-Reset ");
+		ret += scnprintf(str + ret, size - ret, "In-Reset ");
 
-	ret += snprintf(str + ret, size - ret, "Change: ");
+	ret += scnprintf(str + ret, size - ret, "Change: ");
 	if (portsc & PORT_CSC)
-		ret += snprintf(str + ret, size - ret, "CSC ");
+		ret += scnprintf(str + ret, size - ret, "CSC ");
 	if (portsc & PORT_WRC)
-		ret += snprintf(str + ret, size - ret, "WRC ");
+		ret += scnprintf(str + ret, size - ret, "WRC ");
 	if (portsc & PORT_RC)
-		ret += snprintf(str + ret, size - ret, "PRC ");
+		ret += scnprintf(str + ret, size - ret, "PRC ");
 	if (portsc & PORT_PLC)
-		ret += snprintf(str + ret, size - ret, "PLC ");
+		ret += scnprintf(str + ret, size - ret, "PLC ");
 	if (portsc & PORT_CEC)
-		ret += snprintf(str + ret, size - ret, "CEC ");
-	ret += snprintf(str + ret, size - ret, "Wake: ");
+		ret += scnprintf(str + ret, size - ret, "CEC ");
+	ret += scnprintf(str + ret, size - ret, "Wake: ");
 	if (portsc & PORT_WKCONN_E)
-		ret += snprintf(str + ret, size - ret, "WCE ");
+		ret += scnprintf(str + ret, size - ret, "WCE ");
 	if (portsc & PORT_WKDISC_E)
-		ret += snprintf(str + ret, size - ret, "WDE ");
+		ret += scnprintf(str + ret, size - ret, "WDE ");
 
 	return str;
 }
@@ -565,20 +563,20 @@ static inline const char *cdnsp_decode_ep_context(char *str, size_t size,
 
 	avg = EP_AVG_TRB_LENGTH(tx_info);
 
-	ret = snprintf(str, size, "State %s mult %d max P. Streams %d %s",
-		       cdnsp_ep_state_string(ep_state), mult,
-		       max_pstr, lsa ? "LSA " : "");
+	ret = scnprintf(str, size, "State %s mult %d max P. Streams %d %s",
+			cdnsp_ep_state_string(ep_state), mult,
+			max_pstr, lsa ? "LSA " : "");
 
-	ret += snprintf(str + ret, size - ret,
-			"interval %d us max ESIT payload %d CErr %d ",
-			(1 << interval) * 125, esit, cerr);
+	ret += scnprintf(str + ret, size - ret,
+			 "interval %d us max ESIT payload %d CErr %d ",
+			 (1 << interval) * 125, esit, cerr);
 
-	ret += snprintf(str + ret, size - ret,
-			"Type %s %sburst %d maxp %d deq %016llx ",
-			cdnsp_ep_type_string(ep_type), hid ? "HID" : "",
-			burst, maxp, deq);
+	ret += scnprintf(str + ret, size - ret,
+			 "Type %s %sburst %d maxp %d deq %016llx ",
+			 cdnsp_ep_type_string(ep_type), hid ? "HID" : "",
+			 burst, maxp, deq);
 
-	ret += snprintf(str + ret, size - ret, "avg trb len %d", avg);
+	ret += scnprintf(str + ret, size - ret, "avg trb len %d", avg);
 
 	return str;
 }
diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-ep0.c
index f317d3c84781..5cd9b898ce97 100644
--- a/drivers/usb/cdns3/cdnsp-ep0.c
+++ b/drivers/usb/cdns3/cdnsp-ep0.c
@@ -414,6 +414,7 @@ static int cdnsp_ep0_std_request(struct cdnsp_device *pdev,
 void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 {
 	struct usb_ctrlrequest *ctrl = &pdev->setup;
+	struct cdnsp_ep *pep;
 	int ret = -EINVAL;
 	u16 len;
 
@@ -427,10 +428,21 @@ void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 		goto out;
 	}
 
+	pep = &pdev->eps[0];
+
 	/* Restore the ep0 to Stopped/Running state. */
-	if (pdev->eps[0].ep_state & EP_HALTED) {
-		trace_cdnsp_ep0_halted("Restore to normal state");
-		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
+	if (pep->ep_state & EP_HALTED) {
+		if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_HALTED)
+			cdnsp_halt_endpoint(pdev, pep, 0);
+
+		/*
+		 * Halt Endpoint Command for SSP2 for ep0 preserve current
+		 * endpoint state and driver has to synchronize the
+		 * software endpoint state with endpoint output context
+		 * state.
+		 */
+		pep->ep_state &= ~EP_HALTED;
+		pep->ep_state |= EP_STOPPED;
 	}
 
 	/*
diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index bc63c039d3ac..ccd02f6be78a 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1061,10 +1061,8 @@ static int cdnsp_gadget_ep_disable(struct usb_ep *ep)
 	pep->ep_state |= EP_DIS_IN_RROGRESS;
 
 	/* Endpoint was unconfigured by Reset Device command. */
-	if (!(pep->ep_state & EP_UNCONFIGURED)) {
+	if (!(pep->ep_state & EP_UNCONFIGURED))
 		cdnsp_cmd_stop_ep(pdev, pep);
-		cdnsp_cmd_flush_ep(pdev, pep);
-	}
 
 	/* Remove all queued USB requests. */
 	while (!list_empty(&pep->pending_list)) {
@@ -1461,8 +1459,6 @@ static void cdnsp_stop(struct cdnsp_device *pdev)
 {
 	u32 temp;
 
-	cdnsp_cmd_flush_ep(pdev, &pdev->eps[0]);
-
 	/* Remove internally queued request for ep0. */
 	if (!list_empty(&pdev->eps[0].pending_list)) {
 		struct cdnsp_request *req;
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
index 2998548177ab..155fd770a8cd 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -987,6 +987,12 @@ enum cdnsp_setup_dev {
 #define STREAM_ID_FOR_TRB(p)		((((p)) << 16) & GENMASK(31, 16))
 #define SCT_FOR_TRB(p)			(((p) << 1) & 0x7)
 
+/*
+ * Halt Endpoint Command TRB field.
+ * The ESP bit only exists in the SSP2 controller.
+ */
+#define TRB_ESP				BIT(9)
+
 /* Link TRB specific fields. */
 #define TRB_TC				BIT(1)
 
@@ -1138,8 +1144,6 @@ union cdnsp_trb {
 #define TRB_HALT_ENDPOINT	54
 /* Doorbell Overflow Event. */
 #define TRB_DRB_OVERFLOW	57
-/* Flush Endpoint Command. */
-#define TRB_FLUSH_ENDPOINT	58
 
 #define TRB_TYPE_LINK(x)	(((x) & TRB_TYPE_BITMASK) == TRB_TYPE(TRB_LINK))
 #define TRB_TYPE_LINK_LE32(x)	(((x) & cpu_to_le32(TRB_TYPE_BITMASK)) == \
@@ -1552,8 +1556,6 @@ void cdnsp_queue_configure_endpoint(struct cdnsp_device *pdev,
 void cdnsp_queue_reset_ep(struct cdnsp_device *pdev, unsigned int ep_index);
 void cdnsp_queue_halt_endpoint(struct cdnsp_device *pdev,
 			       unsigned int ep_index);
-void cdnsp_queue_flush_endpoint(struct cdnsp_device *pdev,
-				unsigned int ep_index);
 void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num);
 void cdnsp_queue_reset_device(struct cdnsp_device *pdev);
 void cdnsp_queue_new_dequeue_state(struct cdnsp_device *pdev,
@@ -1587,7 +1589,6 @@ void cdnsp_irq_reset(struct cdnsp_device *pdev);
 int cdnsp_halt_endpoint(struct cdnsp_device *pdev,
 			struct cdnsp_ep *pep, int value);
 int cdnsp_cmd_stop_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep);
-int cdnsp_cmd_flush_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep);
 void cdnsp_setup_analyze(struct cdnsp_device *pdev);
 int cdnsp_status_stage(struct cdnsp_device *pdev);
 int cdnsp_reset_device(struct cdnsp_device *pdev);
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index c9ad4280f4ba..42db256978bc 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -2157,19 +2157,6 @@ int cdnsp_cmd_stop_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
 	return ret;
 }
 
-int cdnsp_cmd_flush_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
-{
-	int ret;
-
-	cdnsp_queue_flush_endpoint(pdev, pep->idx);
-	cdnsp_ring_cmd_db(pdev);
-	ret = cdnsp_wait_for_cmd_compl(pdev);
-
-	trace_cdnsp_handle_cmd_flush_ep(pep->out_ctx);
-
-	return ret;
-}
-
 /*
  * The transfer burst count field of the isochronous TRB defines the number of
  * bursts that are required to move all packets in this TD. Only SuperSpeed
@@ -2488,18 +2475,8 @@ void cdnsp_queue_halt_endpoint(struct cdnsp_device *pdev, unsigned int ep_index)
 {
 	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_HALT_ENDPOINT) |
 			    SLOT_ID_FOR_TRB(pdev->slot_id) |
-			    EP_ID_FOR_TRB(ep_index));
-}
-
-/*
- * Queue a flush endpoint request on the command ring.
- */
-void  cdnsp_queue_flush_endpoint(struct cdnsp_device *pdev,
-				 unsigned int ep_index)
-{
-	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_FLUSH_ENDPOINT) |
-			    SLOT_ID_FOR_TRB(pdev->slot_id) |
-			    EP_ID_FOR_TRB(ep_index));
+			    EP_ID_FOR_TRB(ep_index) |
+			    (!ep_index ? TRB_ESP : 0));
 }
 
 void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num)
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 324d7673e3c3..70ae3246d8d5 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2153,6 +2153,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	u32 reg;
+	int ret;
 
 	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
 		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
@@ -2171,7 +2172,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
 			break;
-		dwc3_gadget_suspend(dwc);
+		ret = dwc3_gadget_suspend(dwc);
+		if (ret)
+			return ret;
 		synchronize_irq(dwc->irq_gadget);
 		dwc3_core_exit(dwc);
 		break;
@@ -2202,7 +2205,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 			break;
 
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			dwc3_gadget_suspend(dwc);
+			ret = dwc3_gadget_suspend(dwc);
+			if (ret)
+				return ret;
 			synchronize_irq(dwc->irq_gadget);
 		}
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3360a59c3d33..53a267550520 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4641,26 +4641,22 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	int ret;
 
 	ret = dwc3_gadget_soft_disconnect(dwc);
-	if (ret)
-		goto err;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	if (dwc->gadget_driver)
-		dwc3_disconnect_gadget(dwc);
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	return 0;
-
-err:
 	/*
 	 * Attempt to reset the controller's state. Likely no
 	 * communication can be established until the host
 	 * performs a port reset.
 	 */
-	if (dwc->softconnect)
+	if (ret && dwc->softconnect) {
 		dwc3_gadget_soft_connect(dwc);
+		return -EAGAIN;
+	}
 
-	return ret;
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->gadget_driver)
+		dwc3_disconnect_gadget(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return 0;
 }
 
 int dwc3_gadget_resume(struct dwc3 *dwc)
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 8802dd53fbea..5ca703d45d8c 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -290,8 +290,8 @@ __acquires(&port->port_lock)
 			break;
 	}
 
-	if (do_tty_wake && port->port.tty)
-		tty_wakeup(port->port.tty);
+	if (do_tty_wake)
+		tty_port_tty_wakeup(&port->port);
 	return status;
 }
 
@@ -568,7 +568,7 @@ static int gs_start_io(struct gs_port *port)
 		gs_start_tx(port);
 		/* Unblock any pending writes into our circular buffer, in case
 		 * we didn't in gs_start_tx() */
-		tty_wakeup(port->port.tty);
+		tty_port_tty_wakeup(&port->port);
 	} else {
 		/* Free reqs only if we are still connected */
 		if (port->port_usb) {
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 09e7eabdb73f..537a0bc0f5e1 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1453,6 +1453,10 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
 	/* Periodic endpoint bInterval limit quirk */
 	if (usb_endpoint_xfer_int(&ep->desc) ||
 	    usb_endpoint_xfer_isoc(&ep->desc)) {
+		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_9) &&
+		    interval >= 9) {
+			interval = 8;
+		}
 		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_7) &&
 		    udev->speed >= USB_SPEED_HIGH &&
 		    interval >= 7) {
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index ca27bc15209c..7ad6d13d65ee 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -65,12 +65,22 @@
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI		0x51ed
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
 
+#define PCI_DEVICE_ID_AMD_ARIEL_TYPEC_XHCI		0x13ed
+#define PCI_DEVICE_ID_AMD_ARIEL_TYPEA_XHCI		0x13ee
+#define PCI_DEVICE_ID_AMD_STARSHIP_XHCI			0x148c
+#define PCI_DEVICE_ID_AMD_FIREFLIGHT_15D4_XHCI		0x15d4
+#define PCI_DEVICE_ID_AMD_FIREFLIGHT_15D5_XHCI		0x15d5
+#define PCI_DEVICE_ID_AMD_RAVEN_15E0_XHCI		0x15e0
+#define PCI_DEVICE_ID_AMD_RAVEN_15E1_XHCI		0x15e1
+#define PCI_DEVICE_ID_AMD_RAVEN2_XHCI			0x15e5
 #define PCI_DEVICE_ID_AMD_RENOIR_XHCI			0x1639
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_4			0x43b9
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_2			0x43bb
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
 
+#define PCI_DEVICE_ID_ATI_NAVI10_7316_XHCI		0x7316
+
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
 #define PCI_DEVICE_ID_ASMEDIA_1142_XHCI			0x1242
@@ -167,6 +177,21 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_NEC)
 		xhci->quirks |= XHCI_NEC_HOST;
 
+	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
+	    (pdev->device == PCI_DEVICE_ID_AMD_ARIEL_TYPEC_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_ARIEL_TYPEA_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_STARSHIP_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_FIREFLIGHT_15D4_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_FIREFLIGHT_15D5_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_RAVEN_15E0_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_RAVEN_15E1_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_RAVEN2_XHCI))
+		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_9;
+
+	if (pdev->vendor == PCI_VENDOR_ID_ATI &&
+	    pdev->device == PCI_DEVICE_ID_ATI_NAVI10_7316_XHCI)
+		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_9;
+
 	if (pdev->vendor == PCI_VENDOR_ID_AMD && xhci->hci_version == 0x96)
 		xhci->quirks |= XHCI_AMD_0x96_HOST;
 
@@ -190,8 +215,11 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 	}
 
-	if (pdev->vendor == PCI_VENDOR_ID_AMD)
+	if (pdev->vendor == PCI_VENDOR_ID_AMD) {
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
+		if (pdev->device == 0x43f7)
+			xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
+	}
 
 	if ((pdev->vendor == PCI_VENDOR_ID_AMD) &&
 		((pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4) ||
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 542a4b7fd7ce..fd095ff9fc8b 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1663,6 +1663,7 @@ struct xhci_hcd {
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
+#define XHCI_LIMIT_ENDPOINT_INTERVAL_9 BIT_ULL(49)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 3077cb9d58d6..87f2f56fd20a 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -568,8 +568,10 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		ret = copy_to_iter(&v_rsp, sizeof(v_rsp), &iov_iter);
 		if (likely(ret == sizeof(v_rsp))) {
 			struct vhost_scsi_virtqueue *q;
-			vhost_add_used(cmd->tvc_vq, cmd->tvc_vq_desc, 0);
 			q = container_of(cmd->tvc_vq, struct vhost_scsi_virtqueue, vq);
+			mutex_lock(&q->vq.mutex);
+			vhost_add_used(cmd->tvc_vq, cmd->tvc_vq_desc, 0);
+			mutex_unlock(&q->vq.mutex);
 			vq = q - vs->vqs;
 			__set_bit(vq, vs->compl_bitmap);
 		} else
@@ -1173,8 +1175,11 @@ static void vhost_scsi_tmf_resp_work(struct vhost_work *work)
 	else
 		resp_code = VIRTIO_SCSI_S_FUNCTION_REJECTED;
 
+	mutex_lock(&tmf->svq->vq.mutex);
 	vhost_scsi_send_tmf_resp(tmf->vhost, &tmf->svq->vq, tmf->in_iovs,
 				 tmf->vq_desc, &tmf->resp_iov, resp_code);
+	mutex_unlock(&tmf->svq->vq.mutex);
+
 	vhost_scsi_release_tmf_res(tmf);
 }
 
diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 24192a7667ed..7a9b1ce9c98a 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -55,15 +55,26 @@ static struct file_system_type anon_inode_fs_type = {
 	.kill_sb	= kill_anon_super,
 };
 
-static struct inode *anon_inode_make_secure_inode(
-	const char *name,
-	const struct inode *context_inode)
+/**
+ * anon_inode_make_secure_inode - allocate an anonymous inode with security context
+ * @sb:		[in]	Superblock to allocate from
+ * @name:	[in]	Name of the class of the newfile (e.g., "secretmem")
+ * @context_inode:
+ *		[in]	Optional parent inode for security inheritance
+ *
+ * The function ensures proper security initialization through the LSM hook
+ * security_inode_init_security_anon().
+ *
+ * Return:	Pointer to new inode on success, ERR_PTR on failure.
+ */
+struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
+					   const struct inode *context_inode)
 {
 	struct inode *inode;
 	const struct qstr qname = QSTR_INIT(name, strlen(name));
 	int error;
 
-	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
+	inode = alloc_anon_inode(sb);
 	if (IS_ERR(inode))
 		return inode;
 	inode->i_flags &= ~S_PRIVATE;
@@ -74,6 +85,7 @@ static struct inode *anon_inode_make_secure_inode(
 	}
 	return inode;
 }
+EXPORT_SYMBOL_GPL(anon_inode_make_secure_inode);
 
 static struct file *__anon_inode_getfile(const char *name,
 					 const struct file_operations *fops,
@@ -88,7 +100,8 @@ static struct file *__anon_inode_getfile(const char *name,
 		return ERR_PTR(-ENOENT);
 
 	if (secure) {
-		inode =	anon_inode_make_secure_inode(name, context_inode);
+		inode =	anon_inode_make_secure_inode(anon_inode_mnt->mnt_sb,
+						     name, context_inode);
 		if (IS_ERR(inode)) {
 			file = ERR_CAST(inode);
 			goto err;
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 6a44733a95e1..14bdb241ff6b 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1098,11 +1098,21 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot_for_read(extent_root, &key, path, 1, 0);
 	if (ret < 0)
 		goto out_locked;
-	ASSERT(ret == 0);
+	/*
+	 * If ret is 1 (no key found), it means this is an empty block group,
+	 * without any extents allocated from it and there's no block group
+	 * item (key BTRFS_BLOCK_GROUP_ITEM_KEY) located in the extent tree
+	 * because we are using the block group tree feature, so block group
+	 * items are stored in the block group tree. It also means there are no
+	 * extents allocated for block groups with a start offset beyond this
+	 * block group's end offset (this is the last, highest, block group).
+	 */
+	if (!btrfs_fs_compat_ro(trans->fs_info, BLOCK_GROUP_TREE))
+		ASSERT(ret == 0);
 
 	start = block_group->start;
 	end = block_group->start + block_group->length;
-	while (1) {
+	while (ret == 0) {
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
 		if (key.type == BTRFS_EXTENT_ITEM_KEY ||
@@ -1132,8 +1142,6 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 		ret = btrfs_next_item(extent_root, path);
 		if (ret < 0)
 			goto out_locked;
-		if (ret)
-			break;
 	}
 	if (start < end) {
 		ret = __add_to_free_space_tree(trans, block_group, path2,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5ecc2f3dc3a9..469a622b440b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4881,6 +4881,23 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 		goto out_notrans;
 	}
 
+	/*
+	 * Propagate the last_unlink_trans value of the deleted dir to its
+	 * parent directory. This is to prevent an unrecoverable log tree in the
+	 * case we do something like this:
+	 * 1) create dir foo
+	 * 2) create snapshot under dir foo
+	 * 3) delete the snapshot
+	 * 4) rmdir foo
+	 * 5) mkdir foo
+	 * 6) fsync foo or some file inside foo
+	 *
+	 * This is because we can't unlink other roots when replaying the dir
+	 * deletes for directory foo.
+	 */
+	if (BTRFS_I(inode)->last_unlink_trans >= trans->transid)
+		BTRFS_I(dir)->last_unlink_trans = BTRFS_I(inode)->last_unlink_trans;
+
 	if (unlikely(btrfs_ino(BTRFS_I(inode)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
 		err = btrfs_unlink_subvol(trans, dir, dentry);
 		goto out;
@@ -4895,17 +4912,6 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 				 &fname.disk_name);
 	if (!err) {
 		btrfs_i_size_write(BTRFS_I(inode), 0);
-		/*
-		 * Propagate the last_unlink_trans value of the deleted dir to
-		 * its parent directory. This is to prevent an unrecoverable
-		 * log tree in the case we do something like this:
-		 * 1) create dir foo
-		 * 2) create snapshot under dir foo
-		 * 3) delete the snapshot
-		 * 4) rmdir foo
-		 * 5) mkdir foo
-		 * 6) fsync foo or some file inside foo
-		 */
 		if (BTRFS_I(inode)->last_unlink_trans >= trans->transid)
 			btrfs_record_snapshot_destroy(trans, BTRFS_I(dir));
 	}
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 5c2e6fbb70a3..7b648bec61fd 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -354,6 +354,8 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
+	trace_erofs_read_folio(folio, true);
+
 	return iomap_read_folio(folio, &erofs_iomap_ops);
 }
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 94e9e0bf3bbd..32ca6d3e373a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2022 Alibaba Cloud
  */
 #include "compress.h"
-#include <linux/prefetch.h>
 #include <linux/psi.h>
 
 #include <trace/events/erofs.h>
@@ -237,14 +236,20 @@ static void z_erofs_bvec_iter_begin(struct z_erofs_bvec_iter *iter,
 
 static int z_erofs_bvec_enqueue(struct z_erofs_bvec_iter *iter,
 				struct z_erofs_bvec *bvec,
-				struct page **candidate_bvpage)
+				struct page **candidate_bvpage,
+				struct page **pagepool)
 {
-	if (iter->cur == iter->nr) {
-		if (!*candidate_bvpage)
-			return -EAGAIN;
-
+	if (iter->cur >= iter->nr) {
+		struct page *nextpage = *candidate_bvpage;
+
+		if (!nextpage) {
+			nextpage = erofs_allocpage(pagepool, GFP_NOFS);
+			if (!nextpage)
+				return -ENOMEM;
+			set_page_private(nextpage, Z_EROFS_SHORTLIVED_PAGE);
+		}
 		DBG_BUGON(iter->bvset->nextpage);
-		iter->bvset->nextpage = *candidate_bvpage;
+		iter->bvset->nextpage = nextpage;
 		z_erofs_bvset_flip(iter);
 
 		iter->bvset->nextpage = NULL;
@@ -402,12 +407,12 @@ struct z_erofs_decompress_frontend {
 	struct erofs_map_blocks map;
 	struct z_erofs_bvec_iter biter;
 
+	struct page *pagepool;
 	struct page *candidate_bvpage;
 	struct z_erofs_pcluster *pcl;
 	z_erofs_next_pcluster_t owned_head;
 	enum z_erofs_pclustermode mode;
 
-	bool readahead;
 	/* used for applying cache strategy on the fly */
 	bool backmost;
 	erofs_off_t headoffset;
@@ -437,8 +442,7 @@ static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
 	return false;
 }
 
-static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
-			       struct page **pagepool)
+static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 {
 	struct address_space *mc = MNGD_MAPPING(EROFS_I_SB(fe->inode));
 	struct z_erofs_pcluster *pcl = fe->pcl;
@@ -479,7 +483,7 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 			 * succeeds or fallback to in-place I/O instead
 			 * to avoid any direct reclaim.
 			 */
-			newpage = erofs_allocpage(pagepool, gfp);
+			newpage = erofs_allocpage(&fe->pagepool, gfp);
 			if (!newpage)
 				continue;
 			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
@@ -492,7 +496,7 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 		if (page)
 			put_page(page);
 		else if (newpage)
-			erofs_pagepool_add(pagepool, newpage);
+			erofs_pagepool_add(&fe->pagepool, newpage);
 	}
 
 	/*
@@ -590,7 +594,8 @@ static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
 		    !fe->candidate_bvpage)
 			fe->candidate_bvpage = bvec->page;
 	}
-	ret = z_erofs_bvec_enqueue(&fe->biter, bvec, &fe->candidate_bvpage);
+	ret = z_erofs_bvec_enqueue(&fe->biter, bvec, &fe->candidate_bvpage,
+				   &fe->pagepool);
 	fe->pcl->vcnt += (ret >= 0);
 	return ret;
 }
@@ -746,10 +751,8 @@ static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
 	z_erofs_bvec_iter_end(&fe->biter);
 	mutex_unlock(&pcl->lock);
 
-	if (fe->candidate_bvpage) {
-		DBG_BUGON(z_erofs_is_shortlived_page(fe->candidate_bvpage));
+	if (fe->candidate_bvpage)
 		fe->candidate_bvpage = NULL;
-	}
 
 	/*
 	 * if all pending pages are added, don't hold its reference
@@ -796,7 +799,7 @@ static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
 }
 
 static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
-				struct page *page, struct page **pagepool)
+				struct page *page)
 {
 	struct inode *const inode = fe->inode;
 	struct erofs_map_blocks *const map = &fe->map;
@@ -857,7 +860,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	} else {
 		/* bind cache first when cached decompression is preferred */
-		z_erofs_bind_cache(fe, pagepool);
+		z_erofs_bind_cache(fe);
 	}
 hitted:
 	/*
@@ -898,24 +901,13 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	if (cur)
 		tight &= (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED);
 
-retry:
 	err = z_erofs_attach_page(fe, &((struct z_erofs_bvec) {
 					.page = page,
 					.offset = offset - map->m_la,
 					.end = end,
 				  }), exclusive);
-	/* should allocate an additional short-lived page for bvset */
-	if (err == -EAGAIN && !fe->candidate_bvpage) {
-		fe->candidate_bvpage = alloc_page(GFP_NOFS | __GFP_NOFAIL);
-		set_page_private(fe->candidate_bvpage,
-				 Z_EROFS_SHORTLIVED_PAGE);
-		goto retry;
-	}
-
-	if (err) {
-		DBG_BUGON(err == -EAGAIN && fe->candidate_bvpage);
+	if (err)
 		goto out;
-	}
 
 	z_erofs_onlinepage_split(page);
 	/* bump up the number of spiltted parts of a page */
@@ -949,7 +941,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	return err;
 }
 
-static bool z_erofs_get_sync_decompress_policy(struct erofs_sb_info *sbi,
+static bool z_erofs_is_sync_decompress(struct erofs_sb_info *sbi,
 				       unsigned int readahead_pages)
 {
 	/* auto: enable for read_folio, disable for readahead */
@@ -1480,9 +1472,8 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
 }
 
 static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
-				 struct page **pagepool,
 				 struct z_erofs_decompressqueue *fgq,
-				 bool *force_fg)
+				 bool *force_fg, bool readahead)
 {
 	struct super_block *sb = f->inode->i_sb;
 	struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
@@ -1538,8 +1529,8 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 		do {
 			struct page *page;
 
-			page = pickup_page_for_submission(pcl, i++, pagepool,
-							  mc);
+			page = pickup_page_for_submission(pcl, i++,
+					&f->pagepool, mc);
 			if (!page)
 				continue;
 
@@ -1568,7 +1559,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				bio->bi_iter.bi_sector = (sector_t)cur <<
 					(sb->s_blocksize_bits - 9);
 				bio->bi_private = q[JQ_SUBMIT];
-				if (f->readahead)
+				if (readahead)
 					bio->bi_opf |= REQ_RAHEAD;
 				++nr_bios;
 			}
@@ -1604,16 +1595,16 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 }
 
 static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
-			     struct page **pagepool, bool force_fg)
+			     bool force_fg, bool ra)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 
 	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		return;
-	z_erofs_submit_queue(f, pagepool, io, &force_fg);
+	z_erofs_submit_queue(f, io, &force_fg, ra);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
-	z_erofs_decompress_queue(&io[JQ_BYPASS], pagepool);
+	z_erofs_decompress_queue(&io[JQ_BYPASS], &f->pagepool);
 
 	if (!force_fg)
 		return;
@@ -1622,7 +1613,7 @@ static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
 	wait_for_completion_io(&io[JQ_SUBMIT].u.done);
 
 	/* handle synchronous decompress queue in the caller context */
-	z_erofs_decompress_queue(&io[JQ_SUBMIT], pagepool);
+	z_erofs_decompress_queue(&io[JQ_SUBMIT], &f->pagepool);
 }
 
 /*
@@ -1630,29 +1621,28 @@ static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
  * approximate readmore strategies as a start.
  */
 static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
-				      struct readahead_control *rac,
-				      erofs_off_t end,
-				      struct page **pagepool,
-				      bool backmost)
+		struct readahead_control *rac, bool backmost)
 {
 	struct inode *inode = f->inode;
 	struct erofs_map_blocks *map = &f->map;
-	erofs_off_t cur;
+	erofs_off_t cur, end, headoffset = f->headoffset;
 	int err;
 
 	if (backmost) {
+		if (rac)
+			end = headoffset + readahead_length(rac) - 1;
+		else
+			end = headoffset + PAGE_SIZE - 1;
 		map->m_la = end;
 		err = z_erofs_map_blocks_iter(inode, map,
 					      EROFS_GET_BLOCKS_READMORE);
 		if (err)
 			return;
 
-		/* expend ra for the trailing edge if readahead */
+		/* expand ra for the trailing edge if readahead */
 		if (rac) {
-			loff_t newstart = readahead_pos(rac);
-
 			cur = round_up(map->m_la + map->m_llen, PAGE_SIZE);
-			readahead_expand(rac, newstart, cur - newstart);
+			readahead_expand(rac, headoffset, cur - headoffset);
 			return;
 		}
 		end = round_up(end, PAGE_SIZE);
@@ -1673,7 +1663,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 			if (PageUptodate(page)) {
 				unlock_page(page);
 			} else {
-				err = z_erofs_do_read_page(f, page, pagepool);
+				err = z_erofs_do_read_page(f, page);
 				if (err)
 					erofs_err(inode->i_sb,
 						  "readmore error at page %lu @ nid %llu",
@@ -1690,32 +1680,27 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct inode *const inode = page->mapping->host;
+	struct inode *const inode = folio->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
-	struct page *pagepool = NULL;
 	int err;
 
-	trace_erofs_readpage(page, false);
-	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
-
-	z_erofs_pcluster_readmore(&f, NULL, f.headoffset + PAGE_SIZE - 1,
-				  &pagepool, true);
-	err = z_erofs_do_read_page(&f, page, &pagepool);
-	z_erofs_pcluster_readmore(&f, NULL, 0, &pagepool, false);
+	trace_erofs_read_folio(folio, false);
+	f.headoffset = (erofs_off_t)folio->index << PAGE_SHIFT;
 
+	z_erofs_pcluster_readmore(&f, NULL, true);
+	err = z_erofs_do_read_page(&f, &folio->page);
+	z_erofs_pcluster_readmore(&f, NULL, false);
 	(void)z_erofs_collector_end(&f);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(&f, &pagepool,
-			 z_erofs_get_sync_decompress_policy(sbi, 0));
+	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, 0), false);
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
 
 	erofs_put_metabuf(&f.map.buf);
-	erofs_release_pages(&pagepool);
+	erofs_release_pages(&f.pagepool);
 	return err;
 }
 
@@ -1724,14 +1709,12 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct inode *const inode = rac->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
-	struct page *pagepool = NULL, *head = NULL, *page;
+	struct page *head = NULL, *page;
 	unsigned int nr_pages;
 
-	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
 
-	z_erofs_pcluster_readmore(&f, rac, f.headoffset +
-				  readahead_length(rac) - 1, &pagepool, true);
+	z_erofs_pcluster_readmore(&f, rac, true);
 	nr_pages = readahead_count(rac);
 	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
 
@@ -1747,20 +1730,19 @@ static void z_erofs_readahead(struct readahead_control *rac)
 		/* traversal in reverse order */
 		head = (void *)page_private(page);
 
-		err = z_erofs_do_read_page(&f, page, &pagepool);
+		err = z_erofs_do_read_page(&f, page);
 		if (err)
 			erofs_err(inode->i_sb,
 				  "readahead error at page %lu @ nid %llu",
 				  page->index, EROFS_I(inode)->nid);
 		put_page(page);
 	}
-	z_erofs_pcluster_readmore(&f, rac, 0, &pagepool, false);
+	z_erofs_pcluster_readmore(&f, rac, false);
 	(void)z_erofs_collector_end(&f);
 
-	z_erofs_runqueue(&f, &pagepool,
-			 z_erofs_get_sync_decompress_policy(sbi, nr_pages));
+	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, nr_pages), true);
 	erofs_put_metabuf(&f.map.buf);
-	erofs_release_pages(&pagepool);
+	erofs_release_pages(&f.pagepool);
 }
 
 const struct address_space_operations z_erofs_aops = {
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 025490480be1..bc4011901c90 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -52,7 +52,7 @@ static void proc_evict_inode(struct inode *inode)
 
 	head = ei->sysctl;
 	if (head) {
-		RCU_INIT_POINTER(ei->sysctl, NULL);
+		WRITE_ONCE(ei->sysctl, NULL);
 		proc_sys_evict_inode(inode, head);
 	}
 }
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index df77a7bcce49..6db1489abc68 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -924,17 +924,21 @@ static int proc_sys_compare(const struct dentry *dentry,
 	struct ctl_table_header *head;
 	struct inode *inode;
 
-	/* Although proc doesn't have negative dentries, rcu-walk means
-	 * that inode here can be NULL */
-	/* AV: can it, indeed? */
-	inode = d_inode_rcu(dentry);
-	if (!inode)
-		return 1;
 	if (name->len != len)
 		return 1;
 	if (memcmp(name->name, str, len))
 		return 1;
-	head = rcu_dereference(PROC_I(inode)->sysctl);
+
+	// false positive is fine here - we'll recheck anyway
+	if (d_in_lookup(dentry))
+		return 0;
+
+	inode = d_inode_rcu(dentry);
+	// we just might have run into dentry in the middle of __dentry_kill()
+	if (!inode)
+		return 1;
+
+	head = READ_ONCE(PROC_I(inode)->sysctl);
 	return !head || !sysctl_is_seen(head);
 }
 
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 899285bba8dd..a04413095b23 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8144,11 +8144,6 @@ static void smb20_oplock_break_ack(struct ksmbd_work *work)
 		goto err_out;
 	}
 
-	opinfo->op_state = OPLOCK_STATE_NONE;
-	wake_up_interruptible_all(&opinfo->oplock_q);
-	opinfo_put(opinfo);
-	ksmbd_fd_put(work, fp);
-
 	rsp->StructureSize = cpu_to_le16(24);
 	rsp->OplockLevel = rsp_oplevel;
 	rsp->Reserved = 0;
@@ -8156,16 +8151,15 @@ static void smb20_oplock_break_ack(struct ksmbd_work *work)
 	rsp->VolatileFid = volatile_id;
 	rsp->PersistentFid = persistent_id;
 	ret = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_oplock_break));
-	if (!ret)
-		return;
-
+	if (ret) {
 err_out:
+		smb2_set_err_rsp(work);
+	}
+
 	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
-
 	opinfo_put(opinfo);
 	ksmbd_fd_put(work, fp);
-	smb2_set_err_rsp(work);
 }
 
 static int check_lease_state(struct lease *lease, __le32 req_state)
@@ -8295,11 +8289,6 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	}
 
 	lease_state = lease->state;
-	opinfo->op_state = OPLOCK_STATE_NONE;
-	wake_up_interruptible_all(&opinfo->oplock_q);
-	atomic_dec(&opinfo->breaking_cnt);
-	wake_up_interruptible_all(&opinfo->oplock_brk);
-	opinfo_put(opinfo);
 
 	rsp->StructureSize = cpu_to_le16(36);
 	rsp->Reserved = 0;
@@ -8308,16 +8297,16 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	rsp->LeaseState = lease_state;
 	rsp->LeaseDuration = 0;
 	ret = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_lease_ack));
-	if (!ret)
-		return;
-
+	if (ret) {
 err_out:
+		smb2_set_err_rsp(work);
+	}
+
+	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
 	atomic_dec(&opinfo->breaking_cnt);
 	wake_up_interruptible_all(&opinfo->oplock_brk);
-
 	opinfo_put(opinfo);
-	smb2_set_err_rsp(work);
 }
 
 /**
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 8faa25c6e129..7b6639949c25 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -426,7 +426,8 @@ static void free_transport(struct smb_direct_transport *t)
 	if (t->qp) {
 		ib_drain_qp(t->qp);
 		ib_mr_pool_destroy(t->qp, &t->qp->rdma_mrs);
-		ib_destroy_qp(t->qp);
+		t->qp = NULL;
+		rdma_destroy_qp(t->cm_id);
 	}
 
 	ksmbd_debug(RDMA, "drain the reassembly queue\n");
@@ -1934,8 +1935,8 @@ static int smb_direct_create_qpair(struct smb_direct_transport *t,
 	return 0;
 err:
 	if (t->qp) {
-		ib_destroy_qp(t->qp);
 		t->qp = NULL;
+		rdma_destroy_qp(t->cm_id);
 	}
 	if (t->recv_cq) {
 		ib_destroy_cq(t->recv_cq);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index fa647b75fba8..63276a752373 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1283,6 +1283,7 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 
 		err = ksmbd_vfs_lock_parent(parent_path->dentry, path->dentry);
 		if (err) {
+			mnt_drop_write(parent_path->mnt);
 			path_put(path);
 			path_put(parent_path);
 		}
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index d780fd151789..8fe888c3bd49 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -273,6 +273,9 @@ struct drm_file {
 	 *
 	 * Mapping of mm object handles to object pointers. Used by the GEM
 	 * subsystem. Protected by @table_lock.
+	 *
+	 * Note that allocated entries might be NULL as a transient state when
+	 * creating or deleting a handle.
 	 */
 	struct idr object_idr;
 
diff --git a/include/drm/spsc_queue.h b/include/drm/spsc_queue.h
index 125f096c88cb..ee9df8cc67b7 100644
--- a/include/drm/spsc_queue.h
+++ b/include/drm/spsc_queue.h
@@ -70,9 +70,11 @@ static inline bool spsc_queue_push(struct spsc_queue *queue, struct spsc_node *n
 
 	preempt_disable();
 
+	atomic_inc(&queue->job_count);
+	smp_mb__after_atomic();
+
 	tail = (struct spsc_node **)atomic_long_xchg(&queue->tail, (long)&node->next);
 	WRITE_ONCE(*tail, node);
-	atomic_inc(&queue->job_count);
 
 	/*
 	 * In case of first element verify new node will be visible to the consumer
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 08fba309ddc7..1a619b681bcc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3469,6 +3469,8 @@ extern int simple_write_begin(struct file *file, struct address_space *mapping,
 extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
+struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
+					   const struct inode *context_inode);
 extern int simple_nosetlease(struct file *, long, struct file_lock **, void **);
 extern const struct dentry_operations simple_dentry_operations;
 
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index df7775afb92b..0097791e1eed 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -353,7 +353,7 @@ static inline __be16 __nf_flow_pppoe_proto(const struct sk_buff *skb)
 
 static inline bool nf_flow_pppoe_proto(struct sk_buff *skb, __be16 *inner_proto)
 {
-	if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
+	if (!pskb_may_pull(skb, ETH_HLEN + PPPOE_SES_HLEN))
 		return false;
 
 	*inner_proto = __nf_flow_pppoe_proto(skb);
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index a5e7f79ba557..54a876f52e9b 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -75,11 +75,11 @@ TRACE_EVENT(erofs_fill_inode,
 		  __entry->blkaddr, __entry->ofs)
 );
 
-TRACE_EVENT(erofs_readpage,
+TRACE_EVENT(erofs_read_folio,
 
-	TP_PROTO(struct page *page, bool raw),
+	TP_PROTO(struct folio *folio, bool raw),
 
-	TP_ARGS(page, raw),
+	TP_ARGS(folio, raw),
 
 	TP_STRUCT__entry(
 		__field(dev_t,		dev	)
@@ -91,11 +91,11 @@ TRACE_EVENT(erofs_readpage,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= page->mapping->host->i_sb->s_dev;
-		__entry->nid	= EROFS_I(page->mapping->host)->nid;
-		__entry->dir	= S_ISDIR(page->mapping->host->i_mode);
-		__entry->index	= page->index;
-		__entry->uptodate = PageUptodate(page);
+		__entry->dev	= folio->mapping->host->i_sb->s_dev;
+		__entry->nid	= EROFS_I(folio->mapping->host)->nid;
+		__entry->dir	= S_ISDIR(folio->mapping->host->i_mode);
+		__entry->index	= folio->index;
+		__entry->uptodate = folio_test_uptodate(folio);
 		__entry->raw = raw;
 	),
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2761db0365dd..f815b808db20 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10207,7 +10207,7 @@ static int perf_uprobe_event_init(struct perf_event *event)
 	if (event->attr.type != perf_uprobe.type)
 		return -ENOENT;
 
-	if (!perfmon_capable())
+	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
 	/*
diff --git a/kernel/rseq.c b/kernel/rseq.c
index d38ab944105d..840927ac417b 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -120,6 +120,29 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 	return 0;
 }
 
+/*
+ * Get the user-space pointer value stored in the 'rseq_cs' field.
+ */
+static int rseq_get_rseq_cs_ptr_val(struct rseq __user *rseq, u64 *rseq_cs)
+{
+	if (!rseq_cs)
+		return -EFAULT;
+
+#ifdef CONFIG_64BIT
+	if (get_user(*rseq_cs, &rseq->rseq_cs))
+		return -EFAULT;
+#else
+	if (copy_from_user(rseq_cs, &rseq->rseq_cs, sizeof(*rseq_cs)))
+		return -EFAULT;
+#endif
+
+	return 0;
+}
+
+/*
+ * If the rseq_cs field of 'struct rseq' contains a valid pointer to
+ * user-space, copy 'struct rseq_cs' from user-space and validate its fields.
+ */
 static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 {
 	struct rseq_cs __user *urseq_cs;
@@ -128,17 +151,16 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 	u32 sig;
 	int ret;
 
-#ifdef CONFIG_64BIT
-	if (get_user(ptr, &t->rseq->rseq_cs))
-		return -EFAULT;
-#else
-	if (copy_from_user(&ptr, &t->rseq->rseq_cs, sizeof(ptr)))
-		return -EFAULT;
-#endif
+	ret = rseq_get_rseq_cs_ptr_val(t->rseq, &ptr);
+	if (ret)
+		return ret;
+
+	/* If the rseq_cs pointer is NULL, return a cleared struct rseq_cs. */
 	if (!ptr) {
 		memset(rseq_cs, 0, sizeof(*rseq_cs));
 		return 0;
 	}
+	/* Check that the pointer value fits in the user-space process space. */
 	if (ptr >= TASK_SIZE)
 		return -EINVAL;
 	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
@@ -214,7 +236,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 	return !!event_mask;
 }
 
-static int clear_rseq_cs(struct task_struct *t)
+static int clear_rseq_cs(struct rseq __user *rseq)
 {
 	/*
 	 * The rseq_cs field is set to NULL on preemption or signal
@@ -225,9 +247,9 @@ static int clear_rseq_cs(struct task_struct *t)
 	 * Set rseq_cs to NULL.
 	 */
 #ifdef CONFIG_64BIT
-	return put_user(0UL, &t->rseq->rseq_cs);
+	return put_user(0UL, &rseq->rseq_cs);
 #else
-	if (clear_user(&t->rseq->rseq_cs, sizeof(t->rseq->rseq_cs)))
+	if (clear_user(&rseq->rseq_cs, sizeof(rseq->rseq_cs)))
 		return -EFAULT;
 	return 0;
 #endif
@@ -259,11 +281,11 @@ static int rseq_ip_fixup(struct pt_regs *regs)
 	 * Clear the rseq_cs pointer and return.
 	 */
 	if (!in_rseq_cs(ip, &rseq_cs))
-		return clear_rseq_cs(t);
+		return clear_rseq_cs(t->rseq);
 	ret = rseq_need_restart(t, rseq_cs.flags);
 	if (ret <= 0)
 		return ret;
-	ret = clear_rseq_cs(t);
+	ret = clear_rseq_cs(t->rseq);
 	if (ret)
 		return ret;
 	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
@@ -337,6 +359,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		int, flags, u32, sig)
 {
 	int ret;
+	u64 rseq_cs;
 
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
@@ -382,6 +405,19 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
+
+	/*
+	 * If the rseq_cs pointer is non-NULL on registration, clear it to
+	 * avoid a potential segfault on return to user-space. The proper thing
+	 * to do would have been to fail the registration but this would break
+	 * older libcs that reuse the rseq area for new threads without
+	 * clearing the fields.
+	 */
+	if (rseq_get_rseq_cs_ptr_val(rseq, &rseq_cs))
+	        return -EFAULT;
+	if (rseq_cs && clear_rseq_cs(rseq))
+		return -EFAULT;
+
 	current->rseq = rseq;
 	current->rseq_sig = sig;
 	/*
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b5d216bdd3a5..95fe42835f08 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5619,6 +5619,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
 	struct maple_enode *start;
 
 	if (mte_is_leaf(enode)) {
+		mte_set_node_dead(enode);
 		node->type = mte_node_type(enode);
 		goto free_leaf;
 	}
@@ -5802,10 +5803,12 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	int ret;
 
+	mas->mas_flags &= ~MA_STATE_PREALLOC;
 	mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
-	mas->mas_flags |= MA_STATE_PREALLOC;
-	if (likely(!mas_is_err(mas)))
+	if (likely(!mas_is_err(mas))) {
+		mas->mas_flags |= MA_STATE_PREALLOC;
 		return 0;
+	}
 
 	mas_set_alloc_req(mas, 0);
 	ret = xa_err(mas->node);
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 6ad986c267b5..d21d216f838a 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -337,17 +337,8 @@ static void print_address_description(void *addr, u8 tag,
 	}
 
 	if (is_vmalloc_addr(addr)) {
-		struct vm_struct *va = find_vm_area(addr);
-
-		if (va) {
-			pr_err("The buggy address belongs to the virtual mapping at\n"
-			       " [%px, %px) created by:\n"
-			       " %pS\n",
-			       va->addr, va->addr + va->size, va->caller);
-			pr_err("\n");
-
-			page = vmalloc_to_page(addr);
-		}
+		pr_err("The buggy address %px belongs to a vmalloc virtual mapping\n", addr);
+		page = vmalloc_to_page(addr);
 	}
 
 	if (page) {
diff --git a/mm/secretmem.c b/mm/secretmem.c
index c6006d765bbd..18954eae995f 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -193,19 +193,10 @@ static struct file *secretmem_file_create(unsigned long flags)
 	struct file *file = ERR_PTR(-ENOMEM);
 	struct inode *inode;
 	const char *anon_name = "[secretmem]";
-	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
-	int err;
 
-	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
+	inode = anon_inode_make_secure_inode(secretmem_mnt->mnt_sb, anon_name, NULL);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
-
-	err = security_inode_init_security_anon(inode, &qname, NULL);
-	if (err) {
-		file = ERR_PTR(err);
-		goto err_free_inode;
-	}
-
 	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
 				 O_RDWR, &secretmem_fops);
 	if (IS_ERR(file))
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index f67f14db1633..5c9a9652449d 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -563,6 +563,7 @@ static int atrtr_create(struct rtentry *r, struct net_device *devhint)
 
 	/* Fill in the routing entry */
 	rt->target  = ta->sat_addr;
+	dev_put(rt->dev); /* Release old device */
 	dev_hold(devhint);
 	rt->dev     = devhint;
 	rt->flags   = r->rt_flags;
diff --git a/net/atm/clip.c b/net/atm/clip.c
index 511467bb7fe4..53d62361ae46 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -45,7 +45,8 @@
 #include <net/atmclip.h>
 
 static struct net_device *clip_devs;
-static struct atm_vcc *atmarpd;
+static struct atm_vcc __rcu *atmarpd;
+static DEFINE_MUTEX(atmarpd_lock);
 static struct timer_list idle_timer;
 static const struct neigh_ops clip_neigh_ops;
 
@@ -53,24 +54,35 @@ static int to_atmarpd(enum atmarp_ctrl_type type, int itf, __be32 ip)
 {
 	struct sock *sk;
 	struct atmarp_ctrl *ctrl;
+	struct atm_vcc *vcc;
 	struct sk_buff *skb;
+	int err = 0;
 
 	pr_debug("(%d)\n", type);
-	if (!atmarpd)
-		return -EUNATCH;
+
+	rcu_read_lock();
+	vcc = rcu_dereference(atmarpd);
+	if (!vcc) {
+		err = -EUNATCH;
+		goto unlock;
+	}
 	skb = alloc_skb(sizeof(struct atmarp_ctrl), GFP_ATOMIC);
-	if (!skb)
-		return -ENOMEM;
+	if (!skb) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 	ctrl = skb_put(skb, sizeof(struct atmarp_ctrl));
 	ctrl->type = type;
 	ctrl->itf_num = itf;
 	ctrl->ip = ip;
-	atm_force_charge(atmarpd, skb->truesize);
+	atm_force_charge(vcc, skb->truesize);
 
-	sk = sk_atm(atmarpd);
+	sk = sk_atm(vcc);
 	skb_queue_tail(&sk->sk_receive_queue, skb);
 	sk->sk_data_ready(sk);
-	return 0;
+unlock:
+	rcu_read_unlock();
+	return err;
 }
 
 static void link_vcc(struct clip_vcc *clip_vcc, struct atmarp_entry *entry)
@@ -417,6 +429,8 @@ static int clip_mkip(struct atm_vcc *vcc, int timeout)
 
 	if (!vcc->push)
 		return -EBADFD;
+	if (vcc->user_back)
+		return -EINVAL;
 	clip_vcc = kmalloc(sizeof(struct clip_vcc), GFP_KERNEL);
 	if (!clip_vcc)
 		return -ENOMEM;
@@ -607,17 +621,27 @@ static void atmarpd_close(struct atm_vcc *vcc)
 {
 	pr_debug("\n");
 
-	rtnl_lock();
-	atmarpd = NULL;
+	mutex_lock(&atmarpd_lock);
+	RCU_INIT_POINTER(atmarpd, NULL);
+	mutex_unlock(&atmarpd_lock);
+
+	synchronize_rcu();
 	skb_queue_purge(&sk_atm(vcc)->sk_receive_queue);
-	rtnl_unlock();
 
 	pr_debug("(done)\n");
 	module_put(THIS_MODULE);
 }
 
+static int atmarpd_send(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	atm_return_tx(vcc, skb);
+	dev_kfree_skb_any(skb);
+	return 0;
+}
+
 static const struct atmdev_ops atmarpd_dev_ops = {
-	.close = atmarpd_close
+	.close = atmarpd_close,
+	.send = atmarpd_send
 };
 
 
@@ -631,15 +655,18 @@ static struct atm_dev atmarpd_dev = {
 
 static int atm_init_atmarp(struct atm_vcc *vcc)
 {
-	rtnl_lock();
+	if (vcc->push == clip_push)
+		return -EINVAL;
+
+	mutex_lock(&atmarpd_lock);
 	if (atmarpd) {
-		rtnl_unlock();
+		mutex_unlock(&atmarpd_lock);
 		return -EADDRINUSE;
 	}
 
 	mod_timer(&idle_timer, jiffies + CLIP_CHECK_INTERVAL * HZ);
 
-	atmarpd = vcc;
+	rcu_assign_pointer(atmarpd, vcc);
 	set_bit(ATM_VF_META, &vcc->flags);
 	set_bit(ATM_VF_READY, &vcc->flags);
 	    /* allow replies and avoid getting closed if signaling dies */
@@ -648,13 +675,14 @@ static int atm_init_atmarp(struct atm_vcc *vcc)
 	vcc->push = NULL;
 	vcc->pop = NULL; /* crash */
 	vcc->push_oam = NULL; /* crash */
-	rtnl_unlock();
+	mutex_unlock(&atmarpd_lock);
 	return 0;
 }
 
 static int clip_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	struct atm_vcc *vcc = ATM_SD(sock);
+	struct sock *sk = sock->sk;
 	int err = 0;
 
 	switch (cmd) {
@@ -675,14 +703,18 @@ static int clip_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		err = clip_create(arg);
 		break;
 	case ATMARPD_CTRL:
+		lock_sock(sk);
 		err = atm_init_atmarp(vcc);
 		if (!err) {
 			sock->state = SS_CONNECTED;
 			__module_get(THIS_MODULE);
 		}
+		release_sock(sk);
 		break;
 	case ATMARP_MKIP:
+		lock_sock(sk);
 		err = clip_mkip(vcc, arg);
+		release_sock(sk);
 		break;
 	case ATMARP_SETENTRY:
 		err = clip_setentry(vcc, (__force __be32)arg);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c1e018eaa6f4..7d22b2b02745 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1204,7 +1204,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	 * Command Disallowed error, so we must first disable the
 	 * instance if it is active.
 	 */
-	if (adv && !adv->pending) {
+	if (adv) {
 		err = hci_disable_ext_adv_instance_sync(hdev, instance);
 		if (err)
 			return err;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 40ee2d6ef229..69915bb8b96d 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3472,11 +3472,9 @@ static void addrconf_gre_config(struct net_device *dev)
 
 	ASSERT_RTNL();
 
-	idev = ipv6_find_idev(dev);
-	if (IS_ERR(idev)) {
-		pr_debug("%s: add_dev failed\n", __func__);
+	idev = addrconf_add_dev(dev);
+	if (IS_ERR(idev))
 		return;
-	}
 
 	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
 	 * unless we have an IPv4 GRE device not bound to an IP address and
@@ -3490,9 +3488,6 @@ static void addrconf_gre_config(struct net_device *dev)
 	}
 
 	add_v4_addrs(idev);
-
-	if (dev->flags & IFF_POINTOPOINT)
-		addrconf_add_mroute(dev);
 }
 #endif
 
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 8a74847dacaf..7e55328a4338 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -387,7 +387,6 @@ static void netlink_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
 	WARN_ON(skb->sk != NULL);
 	skb->sk = sk;
 	skb->destructor = netlink_skb_destructor;
-	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
 	sk_mem_charge(sk, skb->truesize);
 }
 
@@ -1211,41 +1210,48 @@ static struct sk_buff *netlink_alloc_large_skb(unsigned int size,
 int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
 		      long *timeo, struct sock *ssk)
 {
+	DECLARE_WAITQUEUE(wait, current);
 	struct netlink_sock *nlk;
+	unsigned int rmem;
 
 	nlk = nlk_sk(sk);
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
 
-	if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
-	     test_bit(NETLINK_S_CONGESTED, &nlk->state))) {
-		DECLARE_WAITQUEUE(wait, current);
-		if (!*timeo) {
-			if (!ssk || netlink_is_kernel(ssk))
-				netlink_overrun(sk);
-			sock_put(sk);
-			kfree_skb(skb);
-			return -EAGAIN;
-		}
-
-		__set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&nlk->wait, &wait);
+	if ((rmem == skb->truesize || rmem < READ_ONCE(sk->sk_rcvbuf)) &&
+	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
+		netlink_skb_set_owner_r(skb, sk);
+		return 0;
+	}
 
-		if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
-		     test_bit(NETLINK_S_CONGESTED, &nlk->state)) &&
-		    !sock_flag(sk, SOCK_DEAD))
-			*timeo = schedule_timeout(*timeo);
+	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 
-		__set_current_state(TASK_RUNNING);
-		remove_wait_queue(&nlk->wait, &wait);
+	if (!*timeo) {
+		if (!ssk || netlink_is_kernel(ssk))
+			netlink_overrun(sk);
 		sock_put(sk);
+		kfree_skb(skb);
+		return -EAGAIN;
+	}
 
-		if (signal_pending(current)) {
-			kfree_skb(skb);
-			return sock_intr_errno(*timeo);
-		}
-		return 1;
+	__set_current_state(TASK_INTERRUPTIBLE);
+	add_wait_queue(&nlk->wait, &wait);
+	rmem = atomic_read(&sk->sk_rmem_alloc);
+
+	if (((rmem && rmem + skb->truesize > READ_ONCE(sk->sk_rcvbuf)) ||
+	     test_bit(NETLINK_S_CONGESTED, &nlk->state)) &&
+	    !sock_flag(sk, SOCK_DEAD))
+		*timeo = schedule_timeout(*timeo);
+
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&nlk->wait, &wait);
+	sock_put(sk);
+
+	if (signal_pending(current)) {
+		kfree_skb(skb);
+		return sock_intr_errno(*timeo);
 	}
-	netlink_skb_set_owner_r(skb, sk);
-	return 0;
+
+	return 1;
 }
 
 static int __netlink_sendskb(struct sock *sk, struct sk_buff *skb)
@@ -1305,6 +1311,7 @@ static int netlink_unicast_kernel(struct sock *sk, struct sk_buff *skb,
 	ret = -ECONNREFUSED;
 	if (nlk->netlink_rcv != NULL) {
 		ret = skb->len;
+		atomic_add(skb->truesize, &sk->sk_rmem_alloc);
 		netlink_skb_set_owner_r(skb, sk);
 		NETLINK_CB(skb).sk = ssk;
 		netlink_deliver_tap_kernel(sk, ssk, skb);
@@ -1381,13 +1388,19 @@ EXPORT_SYMBOL_GPL(netlink_strict_get_check);
 static int netlink_broadcast_deliver(struct sock *sk, struct sk_buff *skb)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
+	unsigned int rmem, rcvbuf;
 
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
+	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+
+	if ((rmem == skb->truesize || rmem <= rcvbuf) &&
 	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
 		netlink_skb_set_owner_r(skb, sk);
 		__netlink_sendskb(sk, skb);
-		return atomic_read(&sk->sk_rmem_alloc) > (sk->sk_rcvbuf >> 1);
+		return rmem > (rcvbuf >> 1);
 	}
+
+	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 	return -1;
 }
 
@@ -2155,6 +2168,7 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	struct netlink_ext_ack extack = {};
 	struct netlink_callback *cb;
 	struct sk_buff *skb = NULL;
+	unsigned int rmem, rcvbuf;
 	size_t max_recvmsg_len;
 	struct module *module;
 	int err = -ENOBUFS;
@@ -2168,9 +2182,6 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 		goto errout_skb;
 	}
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
-		goto errout_skb;
-
 	/* NLMSG_GOODSIZE is small to avoid high order allocations being
 	 * required, but it makes sense to _attempt_ a 16K bytes allocation
 	 * to reduce number of system calls on dump operations, if user
@@ -2193,6 +2204,13 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	if (!skb)
 		goto errout_skb;
 
+	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
+	if (rmem != skb->truesize && rmem >= rcvbuf) {
+		atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+		goto errout_skb;
+	}
+
 	/* Trim skb to allocated size. User is expected to provide buffer as
 	 * large as max(min_dump_alloc, 16KiB (mac_recvmsg_len capped at
 	 * netlink_recvmsg())). dump will pack as many smaller messages as
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 99e10eea3732..658b592e58e0 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -270,6 +270,9 @@ static struct rxrpc_call *rxrpc_alloc_incoming_call(struct rxrpc_sock *rx,
 	unsigned short call_tail, conn_tail, peer_tail;
 	unsigned short call_count, conn_count;
 
+	if (!b)
+		return NULL;
+
 	/* #calls >= #conns >= #peers must hold true. */
 	call_head = smp_load_acquire(&b->call_backlog_head);
 	call_tail = b->call_backlog_tail;
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 7c5df62421bb..e53149a973a6 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -333,17 +333,22 @@ struct Qdisc *qdisc_lookup_rcu(struct net_device *dev, u32 handle)
 	return q;
 }
 
-static struct Qdisc *qdisc_leaf(struct Qdisc *p, u32 classid)
+static struct Qdisc *qdisc_leaf(struct Qdisc *p, u32 classid,
+				struct netlink_ext_ack *extack)
 {
 	unsigned long cl;
 	const struct Qdisc_class_ops *cops = p->ops->cl_ops;
 
-	if (cops == NULL)
-		return NULL;
+	if (cops == NULL) {
+		NL_SET_ERR_MSG(extack, "Parent qdisc is not classful");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
 	cl = cops->find(p, classid);
 
-	if (cl == 0)
-		return NULL;
+	if (cl == 0) {
+		NL_SET_ERR_MSG(extack, "Specified class not found");
+		return ERR_PTR(-ENOENT);
+	}
 	return cops->leaf(p, cl);
 }
 
@@ -1500,7 +1505,7 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					NL_SET_ERR_MSG(extack, "Failed to find qdisc with specified classid");
 					return -ENOENT;
 				}
-				q = qdisc_leaf(p, clid);
+				q = qdisc_leaf(p, clid, extack);
 			} else if (dev_ingress_queue(dev)) {
 				q = rtnl_dereference(dev_ingress_queue(dev)->qdisc_sleeping);
 			}
@@ -1511,6 +1516,8 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 			NL_SET_ERR_MSG(extack, "Cannot find specified qdisc on specified device");
 			return -ENOENT;
 		}
+		if (IS_ERR(q))
+			return PTR_ERR(q);
 
 		if (tcm->tcm_handle && q->handle != tcm->tcm_handle) {
 			NL_SET_ERR_MSG(extack, "Invalid handle");
@@ -1604,7 +1611,9 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					NL_SET_ERR_MSG(extack, "Failed to find specified qdisc");
 					return -ENOENT;
 				}
-				q = qdisc_leaf(p, clid);
+				q = qdisc_leaf(p, clid, extack);
+				if (IS_ERR(q))
+					return PTR_ERR(q);
 			} else if (dev_ingress_queue_create(dev)) {
 				q = rtnl_dereference(dev_ingress_queue(dev)->qdisc_sleeping);
 			}
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 69c88cc03887..0445c91db009 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -699,8 +699,10 @@ static void tipc_topsrv_stop(struct net *net)
 	for (id = 0; srv->idr_in_use; id++) {
 		con = idr_find(&srv->conn_idr, id);
 		if (con) {
+			conn_get(con);
 			spin_unlock_bh(&srv->idr_lock);
 			tipc_conn_close(con);
+			conn_put(con);
 			spin_lock_bh(&srv->idr_lock);
 		}
 	}
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index a2271da346d3..678b809affe0 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -403,6 +403,8 @@ EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
 
 static bool vsock_use_local_transport(unsigned int remote_cid)
 {
+	lockdep_assert_held(&vsock_register_mutex);
+
 	if (!transport_local)
 		return false;
 
@@ -460,6 +462,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 
 	remote_flags = vsk->remote_addr.svm_flags;
 
+	mutex_lock(&vsock_register_mutex);
+
 	switch (sk->sk_type) {
 	case SOCK_DGRAM:
 		new_transport = transport_dgram;
@@ -475,12 +479,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 			new_transport = transport_h2g;
 		break;
 	default:
-		return -ESOCKTNOSUPPORT;
+		ret = -ESOCKTNOSUPPORT;
+		goto err;
 	}
 
 	if (vsk->transport) {
-		if (vsk->transport == new_transport)
-			return 0;
+		if (vsk->transport == new_transport) {
+			ret = 0;
+			goto err;
+		}
 
 		/* transport->release() must be called with sock lock acquired.
 		 * This path can only be taken during vsock_connect(), where we
@@ -504,8 +511,16 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 	/* We increase the module refcnt to prevent the transport unloading
 	 * while there are open sockets assigned to it.
 	 */
-	if (!new_transport || !try_module_get(new_transport->module))
-		return -ENODEV;
+	if (!new_transport || !try_module_get(new_transport->module)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* It's safe to release the mutex after a successful try_module_get().
+	 * Whichever transport `new_transport` points at, it won't go away until
+	 * the last module_put() below or in vsock_deassign_transport().
+	 */
+	mutex_unlock(&vsock_register_mutex);
 
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
@@ -524,12 +539,31 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 	vsk->transport = new_transport;
 
 	return 0;
+err:
+	mutex_unlock(&vsock_register_mutex);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(vsock_assign_transport);
 
+/*
+ * Provide safe access to static transport_{h2g,g2h,dgram,local} callbacks.
+ * Otherwise we may race with module removal. Do not use on `vsk->transport`.
+ */
+static u32 vsock_registered_transport_cid(const struct vsock_transport **transport)
+{
+	u32 cid = VMADDR_CID_ANY;
+
+	mutex_lock(&vsock_register_mutex);
+	if (*transport)
+		cid = (*transport)->get_local_cid();
+	mutex_unlock(&vsock_register_mutex);
+
+	return cid;
+}
+
 bool vsock_find_cid(unsigned int cid)
 {
-	if (transport_g2h && cid == transport_g2h->get_local_cid())
+	if (cid == vsock_registered_transport_cid(&transport_g2h))
 		return true;
 
 	if (transport_h2g && cid == VMADDR_CID_HOST)
@@ -2320,18 +2354,19 @@ static long vsock_dev_do_ioctl(struct file *filp,
 			       unsigned int cmd, void __user *ptr)
 {
 	u32 __user *p = ptr;
-	u32 cid = VMADDR_CID_ANY;
 	int retval = 0;
+	u32 cid;
 
 	switch (cmd) {
 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
 		/* To be compatible with the VMCI behavior, we prioritize the
 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
 		 */
-		if (transport_g2h)
-			cid = transport_g2h->get_local_cid();
-		else if (transport_h2g)
-			cid = transport_h2g->get_local_cid();
+		cid = vsock_registered_transport_cid(&transport_g2h);
+		if (cid == VMADDR_CID_ANY)
+			cid = vsock_registered_transport_cid(&transport_h2g);
+		if (cid == VMADDR_CID_ANY)
+			cid = vsock_registered_transport_cid(&transport_local);
 
 		if (put_user(cid, p) != 0)
 			retval = -EFAULT;
diff --git a/net/wireless/util.c b/net/wireless/util.c
index c71b85fd6052..00c1530e1979 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -813,6 +813,52 @@ bool ieee80211_is_valid_amsdu(struct sk_buff *skb, bool mesh_hdr)
 }
 EXPORT_SYMBOL(ieee80211_is_valid_amsdu);
 
+
+/*
+ * Detects if an MSDU frame was maliciously converted into an A-MSDU
+ * frame by an adversary. This is done by parsing the received frame
+ * as if it were a regular MSDU, even though the A-MSDU flag is set.
+ *
+ * For non-mesh interfaces, detection involves checking whether the
+ * payload, when interpreted as an MSDU, begins with a valid RFC1042
+ * header. This is done by comparing the A-MSDU subheader's destination
+ * address to the start of the RFC1042 header.
+ *
+ * For mesh interfaces, the MSDU includes a 6-byte Mesh Control field
+ * and an optional variable-length Mesh Address Extension field before
+ * the RFC1042 header. The position of the RFC1042 header must therefore
+ * be calculated based on the mesh header length.
+ *
+ * Since this function intentionally parses an A-MSDU frame as an MSDU,
+ * it only assumes that the A-MSDU subframe header is present, and
+ * beyond this it performs its own bounds checks under the assumption
+ * that the frame is instead parsed as a non-aggregated MSDU.
+ */
+static bool
+is_amsdu_aggregation_attack(struct ethhdr *eth, struct sk_buff *skb,
+			    enum nl80211_iftype iftype)
+{
+	int offset;
+
+	/* Non-mesh case can be directly compared */
+	if (iftype != NL80211_IFTYPE_MESH_POINT)
+		return ether_addr_equal(eth->h_dest, rfc1042_header);
+
+	offset = __ieee80211_get_mesh_hdrlen(eth->h_dest[0]);
+	if (offset == 6) {
+		/* Mesh case with empty address extension field */
+		return ether_addr_equal(eth->h_source, rfc1042_header);
+	} else if (offset + ETH_ALEN <= skb->len) {
+		/* Mesh case with non-empty address extension field */
+		u8 temp[ETH_ALEN];
+
+		skb_copy_bits(skb, offset, temp, ETH_ALEN);
+		return ether_addr_equal(temp, rfc1042_header);
+	}
+
+	return false;
+}
+
 void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 			      const u8 *addr, enum nl80211_iftype iftype,
 			      const unsigned int extra_headroom,
@@ -857,8 +903,10 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 		/* the last MSDU has no padding */
 		if (subframe_len > remaining)
 			goto purge;
-		/* mitigate A-MSDU aggregation injection attacks */
-		if (ether_addr_equal(hdr.eth.h_dest, rfc1042_header))
+		/* mitigate A-MSDU aggregation injection attacks, to be
+		 * checked when processing first subframe (offset == 0).
+		 */
+		if (offset == 0 && is_amsdu_aggregation_attack(&hdr.eth, skb, iftype))
 			goto purge;
 
 		offset += sizeof(struct ethhdr);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 13b3ec78010a..f0c67b6af33a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9995,6 +9995,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8975, "HP EliteBook x360 840 Aero G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x897d, "HP mt440 Mobile Thin Client U74", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8981, "HP Elite Dragonfly G3", ALC245_FIXUP_CS35L41_SPI_4),
+	SND_PCI_QUIRK(0x103c, 0x898a, "HP Pavilion 15-eg100", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x898e, "HP EliteBook 835 G9", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x898f, "HP EliteBook 835 G9", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8991, "HP EliteBook 845 G9", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index ecf4f4c0e696..1f4c43bf817e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -339,6 +339,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "RB"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Nitro ANV15-41"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index e16e7b3fa96c..c541e2a0202a 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -517,7 +517,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair, bool use_ideal_rate)
 	regmap_update_bits(asrc->regmap, REG_ASRCTR,
 			   ASRCTR_ATSi_MASK(index), ASRCTR_ATS(index));
 	regmap_update_bits(asrc->regmap, REG_ASRCTR,
-			   ASRCTR_USRi_MASK(index), 0);
+			   ASRCTR_IDRi_MASK(index) | ASRCTR_USRi_MASK(index),
+			   ASRCTR_USR(index));
 
 	/* Set the input and output clock sources */
 	regmap_update_bits(asrc->regmap, REG_ASRCSR,
diff --git a/tools/include/linux/kallsyms.h b/tools/include/linux/kallsyms.h
index 5a37ccbec54f..f61a01dd7eb7 100644
--- a/tools/include/linux/kallsyms.h
+++ b/tools/include/linux/kallsyms.h
@@ -18,6 +18,7 @@ static inline const char *kallsyms_lookup(unsigned long addr,
 	return NULL;
 }
 
+#ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
 #include <stdlib.h>
 static inline void print_ip_sym(const char *loglvl, unsigned long ip)
@@ -30,5 +31,8 @@ static inline void print_ip_sym(const char *loglvl, unsigned long ip)
 
 	free(name);
 }
+#else
+static inline void print_ip_sym(const char *loglvl, unsigned long ip) {}
+#endif
 
 #endif

