Return-Path: <stable+bounces-177745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6417DB44005
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 17:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370E448014D
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E44303C9E;
	Thu,  4 Sep 2025 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E2N+Dm/2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3A2D46AF;
	Thu,  4 Sep 2025 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998624; cv=none; b=mQ0SfiS2OVL0aAxYGhiLYV+a46PZ4vUWDatzvw/j3Sh866WBTg/hTTRgorJ3LcrwfF46L918kkdNP7mE5PxrnYgNT5HMTeOwgmPtqgoOZwRp9yn1kdR6TqUiMWtrHXZEa4PMAzsM+IQbY7cEH17hlsJRxzAIx2rmk2J6eUJKeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998624; c=relaxed/simple;
	bh=70Q27DiIidm2MmteWplh2ays3mUlu5x5SFo8MV8XCdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7UzSPICzbzx63/4oukxjteEFEcgWVitDOFvwJhvnWtgK3TtmPJD2Hf2/8cY6EzlI1d93BPvH1r+XuxS7nczqXXyzrI/D3X9ZI9GUX3xgVCcEKtx9ftXe1XCOu2mTQC30ebBo6W4zjF1IFwy+55n6+eJGN5RNiuB5dZwOSM6hYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E2N+Dm/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8988FC4CEF0;
	Thu,  4 Sep 2025 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756998624;
	bh=70Q27DiIidm2MmteWplh2ays3mUlu5x5SFo8MV8XCdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E2N+Dm/2bYh9oJVOLAqKo49K4VKeNH0fjhm3vlXnhp1XuRmKCcwYJ7I+FSK8G2nXb
	 gFXc4UEuC+gt7aXwYw0+Uq4PPe1dRwqs6b+81ebqSNocY9wkhKyuRvp92HAyrSXQRq
	 xfm035Qj7vsIUMzXRwQNsieVjyZYrtPB5ymPwlfQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.298
Date: Thu,  4 Sep 2025 17:10:12 +0200
Message-ID: <2025090412-massager-kitchen-01f8@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090412-treat-unleveled-cef8@gregkh>
References: <2025090412-treat-unleveled-cef8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 3a6324569093..39b0ac41f636 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 297
+SUBLEVEL = 298
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index d89cf802d9aa..8067641561a4 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -632,19 +632,19 @@ static void __init kvm_check_ins(u32 *inst, u32 features)
 #endif
 	}
 
-	switch (inst_no_rt & ~KVM_MASK_RB) {
 #ifdef CONFIG_PPC_BOOK3S_32
+	switch (inst_no_rt & ~KVM_MASK_RB) {
 	case KVM_INST_MTSRIN:
 		if (features & KVM_MAGIC_FEAT_SR) {
 			u32 inst_rb = _inst & KVM_MASK_RB;
 			kvm_patch_ins_mtsrin(inst, inst_rt, inst_rb);
 		}
 		break;
-#endif
 	}
+#endif
 
-	switch (_inst) {
 #ifdef CONFIG_BOOKE
+	switch (_inst) {
 	case KVM_INST_WRTEEI_0:
 		kvm_patch_ins_wrteei_0(inst);
 		break;
@@ -652,8 +652,8 @@ static void __init kvm_check_ins(u32 *inst, u32 features)
 	case KVM_INST_WRTEEI_1:
 		kvm_patch_ins_wrtee(inst, 0, 1);
 		break;
-#endif
 	}
+#endif
 }
 
 extern u32 kvm_template_start[];
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 319ed873a111..257fba652aa5 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -589,6 +589,9 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
 
 	if (min > map->max_apic_id)
 		goto out;
+
+	min = array_index_nospec(min, map->max_apic_id + 1);
+
 	/* Bits above cluster_size are masked in the caller.  */
 	for_each_set_bit(i, &ipi_bitmap_low,
 		min((u32)BITS_PER_LONG, (map->max_apic_id - min + 1))) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 07154cae7a15..b50d0da06b59 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7506,8 +7506,11 @@ static void kvm_sched_yield(struct kvm *kvm, unsigned long dest_id)
 	rcu_read_lock();
 	map = rcu_dereference(kvm->arch.apic_map);
 
-	if (likely(map) && dest_id <= map->max_apic_id && map->phys_map[dest_id])
-		target = map->phys_map[dest_id]->vcpu;
+	if (likely(map) && dest_id <= map->max_apic_id) {
+		dest_id = array_index_nospec(dest_id, map->max_apic_id + 1);
+		if (map->phys_map[dest_id])
+			target = map->phys_map[dest_id]->vcpu;
+	}
 
 	rcu_read_unlock();
 
diff --git a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
index afc1af542c3b..c6915c5effbd 100644
--- a/drivers/atm/atmtcp.c
+++ b/drivers/atm/atmtcp.c
@@ -279,6 +279,19 @@ static struct atm_vcc *find_vcc(struct atm_dev *dev, short vpi, int vci)
         return NULL;
 }
 
+static int atmtcp_c_pre_send(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	struct atmtcp_hdr *hdr;
+
+	if (skb->len < sizeof(struct atmtcp_hdr))
+		return -EINVAL;
+
+	hdr = (struct atmtcp_hdr *)skb->data;
+	if (hdr->length == ATMTCP_HDR_MAGIC)
+		return -EINVAL;
+
+	return 0;
+}
 
 static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 {
@@ -288,9 +301,6 @@ static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 	struct sk_buff *new_skb;
 	int result = 0;
 
-	if (skb->len < sizeof(struct atmtcp_hdr))
-		goto done;
-
 	dev = vcc->dev_data;
 	hdr = (struct atmtcp_hdr *) skb->data;
 	if (hdr->length == ATMTCP_HDR_MAGIC) {
@@ -347,6 +357,7 @@ static struct atmdev_ops atmtcp_v_dev_ops = {
 
 static const struct atmdev_ops atmtcp_c_dev_ops = {
 	.close		= atmtcp_c_close,
+	.pre_send	= atmtcp_c_pre_send,
 	.send		= atmtcp_c_send
 };
 
diff --git a/drivers/atm/eni.c b/drivers/atm/eni.c
index 4816db0553ef..0f082bd62654 100644
--- a/drivers/atm/eni.c
+++ b/drivers/atm/eni.c
@@ -2035,21 +2035,6 @@ static int eni_ioctl(struct atm_dev *dev,unsigned int cmd,void __user *arg)
 	return dev->phy->ioctl(dev,cmd,arg);
 }
 
-
-static int eni_getsockopt(struct atm_vcc *vcc,int level,int optname,
-    void __user *optval,int optlen)
-{
-	return -EINVAL;
-}
-
-
-static int eni_setsockopt(struct atm_vcc *vcc,int level,int optname,
-    void __user *optval,unsigned int optlen)
-{
-	return -EINVAL;
-}
-
-
 static int eni_send(struct atm_vcc *vcc,struct sk_buff *skb)
 {
 	enum enq_res res;
@@ -2223,8 +2208,6 @@ static const struct atmdev_ops ops = {
 	.open		= eni_open,
 	.close		= eni_close,
 	.ioctl		= eni_ioctl,
-	.getsockopt	= eni_getsockopt,
-	.setsockopt	= eni_setsockopt,
 	.send		= eni_send,
 	.phy_put	= eni_phy_put,
 	.phy_get	= eni_phy_get,
diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index 8995c39330fa..c7c3aeecd1c6 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -1278,8 +1278,6 @@ static const struct atmdev_ops ops = {
 	.send =         fs_send,
 	.owner =        THIS_MODULE,
 	/* ioctl:          fs_ioctl, */
-	/* getsockopt:     fs_getsockopt, */
-	/* setsockopt:     fs_setsockopt, */
 	/* change_qos:     fs_change_qos, */
 
 	/* For now implement these internally here... */  
diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 8fbd36eb8941..a36f555cc040 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -1710,31 +1710,6 @@ fore200e_getstats(struct fore200e* fore200e)
     return 0;
 }
 
-
-static int
-fore200e_getsockopt(struct atm_vcc* vcc, int level, int optname, void __user *optval, int optlen)
-{
-    /* struct fore200e* fore200e = FORE200E_DEV(vcc->dev); */
-
-    DPRINTK(2, "getsockopt %d.%d.%d, level = %d, optname = 0x%x, optval = 0x%p, optlen = %d\n",
-	    vcc->itf, vcc->vpi, vcc->vci, level, optname, optval, optlen);
-
-    return -EINVAL;
-}
-
-
-static int
-fore200e_setsockopt(struct atm_vcc* vcc, int level, int optname, void __user *optval, unsigned int optlen)
-{
-    /* struct fore200e* fore200e = FORE200E_DEV(vcc->dev); */
-    
-    DPRINTK(2, "setsockopt %d.%d.%d, level = %d, optname = 0x%x, optval = 0x%p, optlen = %d\n",
-	    vcc->itf, vcc->vpi, vcc->vci, level, optname, optval, optlen);
-    
-    return -EINVAL;
-}
-
-
 #if 0 /* currently unused */
 static int
 fore200e_get_oc3(struct fore200e* fore200e, struct oc3_regs* regs)
@@ -3026,8 +3001,6 @@ static const struct atmdev_ops fore200e_ops = {
 	.open       = fore200e_open,
 	.close      = fore200e_close,
 	.ioctl      = fore200e_ioctl,
-	.getsockopt = fore200e_getsockopt,
-	.setsockopt = fore200e_setsockopt,
 	.send       = fore200e_send,
 	.change_qos = fore200e_change_qos,
 	.proc_read  = fore200e_proc_read,
diff --git a/drivers/atm/horizon.c b/drivers/atm/horizon.c
index e5da51f907a2..4f2951cbe69c 100644
--- a/drivers/atm/horizon.c
+++ b/drivers/atm/horizon.c
@@ -2527,46 +2527,6 @@ static void hrz_close (struct atm_vcc * atm_vcc) {
   clear_bit(ATM_VF_ADDR,&atm_vcc->flags);
 }
 
-#if 0
-static int hrz_getsockopt (struct atm_vcc * atm_vcc, int level, int optname,
-			   void *optval, int optlen) {
-  hrz_dev * dev = HRZ_DEV(atm_vcc->dev);
-  PRINTD (DBG_FLOW|DBG_VCC, "hrz_getsockopt");
-  switch (level) {
-    case SOL_SOCKET:
-      switch (optname) {
-//	case SO_BCTXOPT:
-//	  break;
-//	case SO_BCRXOPT:
-//	  break;
-	default:
-	  return -ENOPROTOOPT;
-      };
-      break;
-  }
-  return -EINVAL;
-}
-
-static int hrz_setsockopt (struct atm_vcc * atm_vcc, int level, int optname,
-			   void *optval, unsigned int optlen) {
-  hrz_dev * dev = HRZ_DEV(atm_vcc->dev);
-  PRINTD (DBG_FLOW|DBG_VCC, "hrz_setsockopt");
-  switch (level) {
-    case SOL_SOCKET:
-      switch (optname) {
-//	case SO_BCTXOPT:
-//	  break;
-//	case SO_BCRXOPT:
-//	  break;
-	default:
-	  return -ENOPROTOOPT;
-      };
-      break;
-  }
-  return -EINVAL;
-}
-#endif
-
 #if 0
 static int hrz_ioctl (struct atm_dev * atm_dev, unsigned int cmd, void *arg) {
   hrz_dev * dev = HRZ_DEV(atm_dev);
diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index bfc889367d5e..cc90f550ab75 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -2882,20 +2882,6 @@ static int ia_ioctl(struct atm_dev *dev, unsigned int cmd, void __user *arg)
    return 0;  
 }  
   
-static int ia_getsockopt(struct atm_vcc *vcc, int level, int optname,   
-	void __user *optval, int optlen)  
-{  
-	IF_EVENT(printk(">ia_getsockopt\n");)  
-	return -EINVAL;  
-}  
-  
-static int ia_setsockopt(struct atm_vcc *vcc, int level, int optname,   
-	void __user *optval, unsigned int optlen)  
-{  
-	IF_EVENT(printk(">ia_setsockopt\n");)  
-	return -EINVAL;  
-}  
-  
 static int ia_pkt_tx (struct atm_vcc *vcc, struct sk_buff *skb) {
         IADEV *iadev;
         struct dle *wr_ptr;
@@ -3166,8 +3152,6 @@ static const struct atmdev_ops ops = {
 	.open		= ia_open,  
 	.close		= ia_close,  
 	.ioctl		= ia_ioctl,  
-	.getsockopt	= ia_getsockopt,  
-	.setsockopt	= ia_setsockopt,  
 	.send		= ia_send,  
 	.phy_put	= ia_phy_put,  
 	.phy_get	= ia_phy_get,  
diff --git a/drivers/atm/lanai.c b/drivers/atm/lanai.c
index c6b38112bcf4..2ed832e1dafa 100644
--- a/drivers/atm/lanai.c
+++ b/drivers/atm/lanai.c
@@ -2540,8 +2540,6 @@ static const struct atmdev_ops ops = {
 	.dev_close	= lanai_dev_close,
 	.open		= lanai_open,
 	.close		= lanai_close,
-	.getsockopt	= NULL,
-	.setsockopt	= NULL,
 	.send		= lanai_send,
 	.phy_put	= NULL,
 	.phy_get	= NULL,
diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 9f2148daf8ad..669466d010ef 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -1179,8 +1179,6 @@ static const struct atmdev_ops fpga_ops = {
 	.open =		popen,
 	.close =	pclose,
 	.ioctl =	NULL,
-	.getsockopt =	NULL,
-	.setsockopt =	NULL,
 	.send =		psend,
 	.send_oam =	NULL,
 	.phy_put =	NULL,
diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
index 165eebe06e39..ee059c77e3bb 100644
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -1515,20 +1515,6 @@ static int zatm_ioctl(struct atm_dev *dev,unsigned int cmd,void __user *arg)
 	}
 }
 
-
-static int zatm_getsockopt(struct atm_vcc *vcc,int level,int optname,
-    void __user *optval,int optlen)
-{
-	return -EINVAL;
-}
-
-
-static int zatm_setsockopt(struct atm_vcc *vcc,int level,int optname,
-    void __user *optval,unsigned int optlen)
-{
-	return -EINVAL;
-}
-
 static int zatm_send(struct atm_vcc *vcc,struct sk_buff *skb)
 {
 	int error;
@@ -1582,8 +1568,6 @@ static const struct atmdev_ops ops = {
 	.open		= zatm_open,
 	.close		= zatm_close,
 	.ioctl		= zatm_ioctl,
-	.getsockopt	= zatm_getsockopt,
-	.setsockopt	= zatm_setsockopt,
 	.send		= zatm_send,
 	.phy_put	= zatm_phy_put,
 	.phy_get	= zatm_phy_get,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index 2e811e963e35..35a8d3c96fc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -94,8 +94,8 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	r = amdgpu_vm_bo_map(adev, *bo_va, csa_addr, 0, size,
-			     AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
-			     AMDGPU_VM_PAGE_EXECUTABLE);
+			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
+			     AMDGPU_PTE_EXECUTABLE);
 
 	if (r) {
 		DRM_ERROR("failed to do bo_map on static CSA, err=%d\n", r);
diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 4eabef5b86d0..ffc68d305afe 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -280,7 +280,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 	 * We just have to do it before any DPCD access and hope that the
 	 * monitor doesn't power down exactly after the throw away read.
 	 */
-	ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_LANE0_1_STATUS, buffer,
+	ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_DPCD_REV, buffer,
 				 1);
 	if (ret != 1)
 		goto out;
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index dea926862905..8f560cdebf48 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1035,7 +1035,13 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	if (!drvdata->input) {
+	/*
+	 * Check that input registration succeeded. Checking that
+	 * HID_CLAIMED_INPUT is set prevents a UAF when all input devices
+	 * were freed during registration due to no usages being mapped,
+	 * leaving drvdata->input pointing to freed memory.
+	 */
+	if (!drvdata->input || !(hdev->claimed & HID_CLAIMED_INPUT)) {
 		hid_err(hdev, "Asus input not registered\n");
 		ret = -ENOMEM;
 		goto err_stop_hw;
diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index b5d26f03fe6b..a1128c5315ff 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -144,6 +144,9 @@ static void ntrig_report_version(struct hid_device *hdev)
 	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
 	unsigned char *data = kmalloc(8, GFP_KERNEL);
 
+	if (!hid_is_usb(hdev))
+		return;
+
 	if (!data)
 		goto err_free;
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 7851cbec79dc..fd51a97c3722 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -684,6 +684,7 @@ static bool wacom_is_art_pen(int tool_id)
 	case 0x885:	/* Intuos3 Marker Pen */
 	case 0x804:	/* Intuos4/5 13HD/24HD Marker Pen */
 	case 0x10804:	/* Intuos4/5 13HD/24HD Art Pen */
+	case 0x204:     /* Art Pen 2 */
 		is_art_pen = true;
 		break;
 	}
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 8d57fb507205..b4a8d4f12087 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -1102,7 +1102,7 @@ get_stats (struct net_device *dev)
 	dev->stats.rx_bytes += dr32(OctetRcvOk);
 	dev->stats.tx_bytes += dr32(OctetXmtOk);
 
-	dev->stats.multicast = dr32(McstFramesRcvdOk);
+	dev->stats.multicast += dr32(McstFramesRcvdOk);
 	dev->stats.collisions += dr32(SingleColFrames)
 			     +  dr32(MultiColFrames);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index 99c7cdd0404a..44d3d6826f69 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -341,7 +341,6 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 		if (err)
 			return err;
 	}
-	priv->dcbx.xoff = xoff;
 
 	/* Apply the settings */
 	if (update_buffer) {
@@ -350,6 +349,8 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 			return err;
 	}
 
+	priv->dcbx.xoff = xoff;
+
 	if (update_prio2buffer)
 		err = mlx5e_port_set_priority2buffer(priv->mdev, prio2buffer);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
index 34f55b81a0de..7b852b87a609 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
@@ -64,11 +64,23 @@ struct mlx5e_port_buffer {
 	struct mlx5e_bufferx_reg  buffer[MLX5E_MAX_BUFFER];
 };
 
+#ifdef CONFIG_MLX5_CORE_EN_DCB
 int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 				    u32 change, unsigned int mtu,
 				    struct ieee_pfc *pfc,
 				    u32 *buffer_size,
 				    u8 *prio2buffer);
+#else
+static inline int
+mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
+				u32 change, unsigned int mtu,
+				void *pfc,
+				u32 *buffer_size,
+				u8 *prio2buffer)
+{
+	return 0;
+}
+#endif
 
 int mlx5e_port_query_buffer(struct mlx5e_priv *priv,
 			    struct mlx5e_port_buffer *port_buffer);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b3ba996004f1..b8d0b68befcb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -42,6 +42,7 @@
 #include "eswitch.h"
 #include "en.h"
 #include "en/txrx.h"
+#include "en/port_buffer.h"
 #include "en_tc.h"
 #include "en_rep.h"
 #include "en_accel/ipsec.h"
@@ -140,6 +141,8 @@ void mlx5e_update_carrier(struct mlx5e_priv *priv)
 	if (port_state == VPORT_STATE_UP) {
 		netdev_info(priv->netdev, "Link up\n");
 		netif_carrier_on(priv->netdev);
+		mlx5e_port_manual_buffer_config(priv, 0, priv->netdev->mtu,
+						NULL, NULL, NULL);
 	} else {
 		netdev_info(priv->netdev, "Link down\n");
 		netif_carrier_off(priv->netdev);
@@ -2894,9 +2897,11 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
 	struct mlx5e_params *params = &priv->channels.params;
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = priv->mdev;
-	u16 mtu;
+	u16 mtu, prev_mtu;
 	int err;
 
+	mlx5e_query_mtu(mdev, params, &prev_mtu);
+
 	err = mlx5e_set_mtu(mdev, params, params->sw_mtu);
 	if (err)
 		return err;
@@ -2906,6 +2911,18 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
 		netdev_warn(netdev, "%s: VPort MTU %d is different than netdev mtu %d\n",
 			    __func__, mtu, params->sw_mtu);
 
+	if (mtu != prev_mtu && MLX5_BUFFER_SUPPORTED(mdev)) {
+		err = mlx5e_port_manual_buffer_config(priv, 0, mtu,
+						      NULL, NULL, NULL);
+		if (err) {
+			netdev_warn(netdev, "%s: Failed to set Xon/Xoff values with MTU %d (err %d), setting back to previous MTU %d\n",
+				    __func__, mtu, err, prev_mtu);
+
+			mlx5e_set_mtu(mdev, params, prev_mtu);
+			return err;
+		}
+	}
+
 	params->sw_mtu = mtu;
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 07ef0ac725b3..93d1b78c9d4e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -206,10 +206,6 @@ static void dwxgmac2_dma_rx_mode(void __iomem *ioaddr, int mode,
 	}
 
 	writel(value, ioaddr + XGMAC_MTL_RXQ_OPMODE(channel));
-
-	/* Enable MTL RX overflow */
-	value = readl(ioaddr + XGMAC_MTL_QINTEN(channel));
-	writel(value | XGMAC_RXOIE, ioaddr + XGMAC_MTL_QINTEN(channel));
 }
 
 static void dwxgmac2_dma_tx_mode(void __iomem *ioaddr, int mode,
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 496cff5f3d0a..acf1321657ec 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1319,6 +1319,9 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2357, 0x0201, 4)},	/* TP-LINK HSUPA Modem MA180 */
 	{QMI_FIXED_INTF(0x2357, 0x9000, 4)},	/* TP-LINK MA260 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1031, 3)}, /* Telit LE910C1-EUX */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1034, 2)}, /* Telit LE910C4-WWX */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1037, 4)}, /* Telit LE910C4-WWX */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1038, 3)}, /* Telit LE910C4-WWX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x103a, 0)}, /* Telit LE910C4-WWX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1040, 2)},	/* Telit LE922A */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1050, 2)},	/* Telit FN980 */
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index b372419d61f2..57426dc52f9f 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -278,6 +278,7 @@ config PINCTRL_STMFX
 	tristate "STMicroelectronics STMFX GPIO expander pinctrl driver"
 	depends on I2C
 	depends on OF_GPIO
+	depends on HAS_IOMEM
 	select GENERIC_PINCONF
 	select GPIOLIB_IRQCHIP
 	select MFD_STMFX
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 530b14685fd7..8949848fe6a7 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -264,7 +264,7 @@ show_shost_supported_mode(struct device *dev, struct device_attribute *attr,
 	return show_shost_mode(supported_mode, buf);
 }
 
-static DEVICE_ATTR(supported_mode, S_IRUGO | S_IWUSR, show_shost_supported_mode, NULL);
+static DEVICE_ATTR(supported_mode, S_IRUGO, show_shost_supported_mode, NULL);
 
 static ssize_t
 show_shost_active_mode(struct device *dev,
@@ -278,7 +278,7 @@ show_shost_active_mode(struct device *dev,
 		return show_shost_mode(shost->active_mode, buf);
 }
 
-static DEVICE_ATTR(active_mode, S_IRUGO | S_IWUSR, show_shost_active_mode, NULL);
+static DEVICE_ATTR(active_mode, S_IRUGO, show_shost_active_mode, NULL);
 
 static int check_reset_type(const char *str)
 {
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index b19d60adc606..6294e96eb60a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -95,6 +95,7 @@ struct vhost_net_ubuf_ref {
 	atomic_t refcount;
 	wait_queue_head_t wait;
 	struct vhost_virtqueue *vq;
+	struct rcu_head rcu;
 };
 
 #define VHOST_NET_BATCH 64
@@ -248,9 +249,13 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
 
 static int vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
 {
-	int r = atomic_sub_return(1, &ubufs->refcount);
+	int r;
+
+	rcu_read_lock();
+	r = atomic_sub_return(1, &ubufs->refcount);
 	if (unlikely(!r))
 		wake_up(&ubufs->wait);
+	rcu_read_unlock();
 	return r;
 }
 
@@ -263,7 +268,7 @@ static void vhost_net_ubuf_put_and_wait(struct vhost_net_ubuf_ref *ubufs)
 static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref *ubufs)
 {
 	vhost_net_ubuf_put_and_wait(ubufs);
-	kfree(ubufs);
+	kfree_rcu(ubufs, rcu);
 }
 
 static void vhost_net_clear_ubuf_info(struct vhost_net *n)
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index d12a21b2dd9d..0f3d3d96599b 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -46,6 +46,10 @@ static int efivarfs_d_compare(const struct dentry *dentry,
 {
 	int guid = len - EFI_VARIABLE_GUID_LEN;
 
+	/* Parallel lookups may produce a temporary invalid filename */
+	if (guid <= 0)
+		return 1;
+
 	if (name->len != len)
 		return 1;
 
diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 19c0f91c38bd..8cbb992f6293 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -176,11 +176,6 @@ struct atm_dev {
 #define ATM_OF_IMMED  1		/* Attempt immediate delivery */
 #define ATM_OF_INRATE 2		/* Attempt in-rate delivery */
 
-
-/*
- * ioctl, getsockopt, and setsockopt are optional and can be set to NULL.
- */
-
 struct atmdev_ops { /* only send is required */
 	void (*dev_close)(struct atm_dev *dev);
 	int (*open)(struct atm_vcc *vcc);
@@ -190,10 +185,7 @@ struct atmdev_ops { /* only send is required */
 	int (*compat_ioctl)(struct atm_dev *dev,unsigned int cmd,
 			    void __user *arg);
 #endif
-	int (*getsockopt)(struct atm_vcc *vcc,int level,int optname,
-	    void __user *optval,int optlen);
-	int (*setsockopt)(struct atm_vcc *vcc,int level,int optname,
-	    void __user *optval,unsigned int optlen);
+	int (*pre_send)(struct atm_vcc *vcc, struct sk_buff *skb);
 	int (*send)(struct atm_vcc *vcc,struct sk_buff *skb);
 	int (*send_oam)(struct atm_vcc *vcc,void *cell,int flags);
 	void (*phy_put)(struct atm_dev *dev,unsigned char value,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 26b17776e8d2..54601c3ecbe5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9166,10 +9166,10 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 			ret = print_trace_line(&iter);
 			if (ret != TRACE_TYPE_NO_CONSUME)
 				trace_consume(&iter);
+
+			trace_printk_seq(&iter.seq);
 		}
 		touch_nmi_watchdog();
-
-		trace_printk_seq(&iter.seq);
 	}
 
 	if (!cnt)
diff --git a/net/atm/common.c b/net/atm/common.c
index 1e07a5fc53d0..59b61886629e 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -635,18 +635,27 @@ int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t size)
 
 	skb->dev = NULL; /* for paths shared with net_device interfaces */
 	if (!copy_from_iter_full(skb_put(skb, size), size, &m->msg_iter)) {
-		atm_return_tx(vcc, skb);
-		kfree_skb(skb);
 		error = -EFAULT;
-		goto out;
+		goto free_skb;
 	}
 	if (eff != size)
 		memset(skb->data + size, 0, eff-size);
+
+	if (vcc->dev->ops->pre_send) {
+		error = vcc->dev->ops->pre_send(vcc, skb);
+		if (error)
+			goto free_skb;
+	}
+
 	error = vcc->dev->ops->send(vcc, skb);
 	error = error ? error : size;
 out:
 	release_sock(sk);
 	return error;
+free_skb:
+	atm_return_tx(vcc, skb);
+	kfree_skb(skb);
+	goto out;
 }
 
 __poll_t vcc_poll(struct file *file, struct socket *sock, poll_table *wait)
@@ -783,13 +792,8 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
 			vcc->atm_options &= ~ATM_ATMOPT_CLP;
 		return 0;
 	default:
-		if (level == SOL_SOCKET)
-			return -EINVAL;
-		break;
-	}
-	if (!vcc->dev || !vcc->dev->ops->setsockopt)
 		return -EINVAL;
-	return vcc->dev->ops->setsockopt(vcc, level, optname, optval, optlen);
+	}
 }
 
 int vcc_getsockopt(struct socket *sock, int level, int optname,
@@ -827,13 +831,8 @@ int vcc_getsockopt(struct socket *sock, int level, int optname,
 		return copy_to_user(optval, &pvc, sizeof(pvc)) ? -EFAULT : 0;
 	}
 	default:
-		if (level == SOL_SOCKET)
-			return -EINVAL;
-		break;
-	}
-	if (!vcc->dev || !vcc->dev->ops->getsockopt)
 		return -EINVAL;
-	return vcc->dev->ops->getsockopt(vcc, level, optname, optval, len);
+	}
 }
 
 int register_atmdevice_notifier(struct notifier_block *nb)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 33b025a52b83..4e8911501255 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3681,7 +3681,17 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		if (!conn)
 			continue;
 
-		conn->sent -= count;
+		/* Check if there is really enough packets outstanding before
+		 * attempting to decrease the sent counter otherwise it could
+		 * underflow..
+		 */
+		if (conn->sent >= count) {
+			conn->sent -= count;
+		} else {
+			bt_dev_warn(hdev, "hcon %p sent %u < count %u",
+				    conn, conn->sent, count);
+			conn->sent = 0;
+		}
 
 		switch (conn->type) {
 		case ACL_LINK:
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 80612f73ff53..eb83ce4b845a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2365,12 +2365,16 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
 		    !netif_is_l3_master(dev_out))
 			return ERR_PTR(-EINVAL);
 
-	if (ipv4_is_lbcast(fl4->daddr))
+	if (ipv4_is_lbcast(fl4->daddr)) {
 		type = RTN_BROADCAST;
-	else if (ipv4_is_multicast(fl4->daddr))
+
+		/* reset fi to prevent gateway resolution */
+		fi = NULL;
+	} else if (ipv4_is_multicast(fl4->daddr)) {
 		type = RTN_MULTICAST;
-	else if (ipv4_is_zeronet(fl4->daddr))
+	} else if (ipv4_is_zeronet(fl4->daddr)) {
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (dev_out->flags & IFF_LOOPBACK)
 		flags |= RTCF_LOCAL;
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index fae6157e837a..33981ea10281 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -499,7 +499,9 @@ static void sctp_v6_from_sk(union sctp_addr *addr, struct sock *sk)
 {
 	addr->v6.sin6_family = AF_INET6;
 	addr->v6.sin6_port = 0;
+	addr->v6.sin6_flowinfo = 0;
 	addr->v6.sin6_addr = sk->sk_v6_rcv_saddr;
+	addr->v6.sin6_scope_id = 0;
 }
 
 /* Initialize sk->sk_rcv_saddr from sctp_addr. */

