Return-Path: <stable+bounces-184101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 115F3BD016F
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 13:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE1E74E3D17
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FE927381B;
	Sun, 12 Oct 2025 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qVmnhcl6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955172737F2;
	Sun, 12 Oct 2025 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760268273; cv=none; b=IiDwj529vqv72XoaaRsw5jFGpXF1peRYUjs+iqH97D1IIzk5Rj14nn/FZZWDvB1WDsd2iMHW6DDmSwJqfs8/q8U+lGT/v+Oy3mNkh5X/XvtaPrum8f1EeKdFLANrwagi7ytPVziABjCwyrysApd7n6VL1QMkcnX6LkR6xG5uMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760268273; c=relaxed/simple;
	bh=gPmLqDEvcEnxHxWn6MUP2enDKufswh6Cl4/O3mBVsyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmX1ZwcJlV9wu9xL4Kp2MJVlhhr1VCL4MfcUppWhb7HQ+XPzaA3T+GnS1VAcLZJKEZaFb0PszOZRVNIpUbBZVXTRF8WRiNbE1WshjHkHrcDT1rXJvznqjVUvT6z4YNvwcJh6QYhw/HRgC9TFj5dVyXoOqZMm7LswQNz8CF1+LoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qVmnhcl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9451CC4CEF1;
	Sun, 12 Oct 2025 11:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760268273;
	bh=gPmLqDEvcEnxHxWn6MUP2enDKufswh6Cl4/O3mBVsyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVmnhcl6jbQJ2AC4Okg1RkMI0JfBQh53RQwtmxsy0Eptdg1H3y/xvdNMqy+OnY3Vq
	 s5s8TrxvbEWVTOp8DDalpCcTzP/cqK6xAU+xe3USJRTguUxXN/t6dGrz8oeqxjdoJl
	 apR3NdJ8tMQ/0cfHXGF25zfCcQkzJktknbo0DX/s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.16.12
Date: Sun, 12 Oct 2025 13:24:22 +0200
Message-ID: <2025101235-grimy-baked-0e68@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101235-eliminate-dexterity-d7f9@gregkh>
References: <2025101235-eliminate-dexterity-d7f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 0d1e19ef28b9..d4677e7a7161 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 16
-SUBLEVEL = 11
+SUBLEVEL = 12
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 1349e278cd2a..542d3664afa3 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5107,12 +5107,11 @@ void init_decode_cache(struct x86_emulate_ctxt *ctxt)
 	ctxt->mem_read.end = 0;
 }
 
-int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
+int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts)
 {
 	const struct x86_emulate_ops *ops = ctxt->ops;
 	int rc = X86EMUL_CONTINUE;
 	int saved_dst_type = ctxt->dst.type;
-	bool is_guest_mode = ctxt->ops->is_guest_mode(ctxt);
 
 	ctxt->mem_read.pos = 0;
 
@@ -5160,7 +5159,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 				fetch_possible_mmx_operand(&ctxt->dst);
 		}
 
-		if (unlikely(is_guest_mode) && ctxt->intercept) {
+		if (unlikely(check_intercepts) && ctxt->intercept) {
 			rc = emulator_check_intercept(ctxt, ctxt->intercept,
 						      X86_ICPT_PRE_EXCEPT);
 			if (rc != X86EMUL_CONTINUE)
@@ -5189,7 +5188,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 				goto done;
 		}
 
-		if (unlikely(is_guest_mode) && (ctxt->d & Intercept)) {
+		if (unlikely(check_intercepts) && (ctxt->d & Intercept)) {
 			rc = emulator_check_intercept(ctxt, ctxt->intercept,
 						      X86_ICPT_POST_EXCEPT);
 			if (rc != X86EMUL_CONTINUE)
@@ -5243,7 +5242,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 
 special_insn:
 
-	if (unlikely(is_guest_mode) && (ctxt->d & Intercept)) {
+	if (unlikely(check_intercepts) && (ctxt->d & Intercept)) {
 		rc = emulator_check_intercept(ctxt, ctxt->intercept,
 					      X86_ICPT_POST_MEMACCESS);
 		if (rc != X86EMUL_CONTINUE)
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index c1df5acfacaf..7b5ddb787a25 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -235,7 +235,6 @@ struct x86_emulate_ops {
 	void (*set_nmi_mask)(struct x86_emulate_ctxt *ctxt, bool masked);
 
 	bool (*is_smm)(struct x86_emulate_ctxt *ctxt);
-	bool (*is_guest_mode)(struct x86_emulate_ctxt *ctxt);
 	int (*leave_smm)(struct x86_emulate_ctxt *ctxt);
 	void (*triple_fault)(struct x86_emulate_ctxt *ctxt);
 	int (*set_xcr)(struct x86_emulate_ctxt *ctxt, u32 index, u64 xcr);
@@ -521,7 +520,7 @@ bool x86_page_table_writing_insn(struct x86_emulate_ctxt *ctxt);
 #define EMULATION_RESTART 1
 #define EMULATION_INTERCEPTED 2
 void init_decode_cache(struct x86_emulate_ctxt *ctxt);
-int x86_emulate_insn(struct x86_emulate_ctxt *ctxt);
+int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts);
 int emulator_task_switch(struct x86_emulate_ctxt *ctxt,
 			 u16 tss_selector, int idt_index, int reason,
 			 bool has_error_code, u32 error_code);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6b3a64e73f21..689a06acd00f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8613,11 +8613,6 @@ static bool emulator_is_smm(struct x86_emulate_ctxt *ctxt)
 	return is_smm(emul_to_vcpu(ctxt));
 }
 
-static bool emulator_is_guest_mode(struct x86_emulate_ctxt *ctxt)
-{
-	return is_guest_mode(emul_to_vcpu(ctxt));
-}
-
 #ifndef CONFIG_KVM_SMM
 static int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 {
@@ -8701,7 +8696,6 @@ static const struct x86_emulate_ops emulate_ops = {
 	.guest_cpuid_is_intel_compatible = emulator_guest_cpuid_is_intel_compatible,
 	.set_nmi_mask        = emulator_set_nmi_mask,
 	.is_smm              = emulator_is_smm,
-	.is_guest_mode       = emulator_is_guest_mode,
 	.leave_smm           = emulator_leave_smm,
 	.triple_fault        = emulator_triple_fault,
 	.set_xcr             = emulator_set_xcr,
@@ -9286,7 +9280,14 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		ctxt->exception.address = 0;
 	}
 
-	r = x86_emulate_insn(ctxt);
+	/*
+	 * Check L1's instruction intercepts when emulating instructions for
+	 * L2, unless KVM is re-emulating a previously decoded instruction,
+	 * e.g. to complete userspace I/O, in which case KVM has already
+	 * checked the intercepts.
+	 */
+	r = x86_emulate_insn(ctxt, is_guest_mode(vcpu) &&
+				   !(emulation_type & EMULTYPE_NO_DECODE));
 
 	if (r == EMULATION_INTERCEPTED)
 		return 1;
diff --git a/crypto/rng.c b/crypto/rng.c
index b8ae6ebc091d..ee1768c5a400 100644
--- a/crypto/rng.c
+++ b/crypto/rng.c
@@ -168,6 +168,11 @@ int crypto_del_default_rng(void)
 EXPORT_SYMBOL_GPL(crypto_del_default_rng);
 #endif
 
+static void rng_default_set_ent(struct crypto_rng *tfm, const u8 *data,
+				unsigned int len)
+{
+}
+
 int crypto_register_rng(struct rng_alg *alg)
 {
 	struct crypto_alg *base = &alg->base;
@@ -179,6 +184,9 @@ int crypto_register_rng(struct rng_alg *alg)
 	base->cra_flags &= ~CRYPTO_ALG_TYPE_MASK;
 	base->cra_flags |= CRYPTO_ALG_TYPE_RNG;
 
+	if (!alg->set_ent)
+		alg->set_ent = rng_default_set_ent;
+
 	return crypto_register_alg(base);
 }
 EXPORT_SYMBOL_GPL(crypto_register_rng);
diff --git a/drivers/android/dbitmap.h b/drivers/android/dbitmap.h
index 956f1bd087d1..c7299ce8b374 100644
--- a/drivers/android/dbitmap.h
+++ b/drivers/android/dbitmap.h
@@ -37,6 +37,7 @@ static inline void dbitmap_free(struct dbitmap *dmap)
 {
 	dmap->nbits = 0;
 	kfree(dmap->map);
+	dmap->map = NULL;
 }
 
 /* Returns the nbits that a dbitmap can shrink to, 0 if not possible. */
diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index f5fbda0a9a44..21dd02124231 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -155,6 +155,7 @@ struct faux_device *faux_device_create_with_groups(const char *name,
 		dev->parent = &faux_bus_root;
 	dev->bus = &faux_bus_type;
 	dev_set_name(dev, "%s", name);
+	device_set_pm_not_required(dev);
 
 	ret = device_add(dev);
 	if (ret) {
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9efdd111baf5..e49f491f0fa7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -520,6 +520,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8851BU Bluetooth devices */
 	{ USB_DEVICE(0x3625, 0x010b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2001, 0x332a), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index bfb04e67c4bc..7b95d1b03361 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -317,6 +317,18 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "PNP0C50:00@8",
 		},
 	},
+	{
+		/*
+		 * Same as G1619-04. New model.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1619-05"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "PNP0C50:00@8",
+		},
+	},
 	{
 		/*
 		 * Spurious wakeups from GPIO 11
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 96566870f079..199bd9340b3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1654,6 +1654,21 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 			}
 		}
 		break;
+	case IP_VERSION(11, 0, 1):
+	case IP_VERSION(11, 0, 4):
+		adev->gfx.cleaner_shader_ptr = gfx_11_0_3_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_11_0_3_cleaner_shader_hex);
+		if (adev->gfx.pfp_fw_version >= 102 &&
+		    adev->gfx.mec_fw_version >= 66 &&
+		    adev->mes.fw_version[0] >= 128) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 		adev->gfx.cleaner_shader_ptr = gfx_11_0_3_cleaner_shader_hex;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 3f6a828cad8a..1445da1f53af 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -711,6 +711,12 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
+	if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x7f)
+		mes_set_hw_res_pkt.enable_lr_compute_wa = 1;
+	else
+		dev_info_once(mes->adev->dev,
+			      "MES FW version must be >= 0x7f to enable LR compute workaround.\n");
+
 	if (amdgpu_mes_log_enable) {
 		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
 		mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6b222630f3fa..39caac14d5fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -738,6 +738,11 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
+	if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x82)
+		mes_set_hw_res_pkt.enable_lr_compute_wa = 1;
+	else
+		dev_info_once(adev->dev,
+			      "MES FW version must be >= 0x82 to enable LR compute workaround.\n");
 
 	/*
 	 * Keep oversubscribe timer for sdma . When we have unmapped doorbell
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 15680c3f4970..ab1cfc92dbeb 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -238,7 +238,8 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t enable_mes_sch_stb_log : 1;
 				uint32_t limit_single_process : 1;
 				uint32_t is_strix_tmz_wa_enabled  :1;
-				uint32_t reserved : 13;
+				uint32_t enable_lr_compute_wa : 1;
+				uint32_t reserved : 12;
 			};
 			uint32_t	uint32_t_all;
 		};
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index d85ffab2aff9..a402974939d6 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -286,7 +286,8 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t limit_single_process : 1;
 				uint32_t unmapped_doorbell_handling: 2;
 				uint32_t enable_mes_fence_int: 1;
-				uint32_t reserved : 10;
+				uint32_t enable_lr_compute_wa : 1;
+				uint32_t reserved : 9;
 			};
 			uint32_t uint32_all;
 		};
diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 6c0ac14f11a6..2cfc8e1a2912 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -816,6 +816,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 			}
 			if (data[2] == MCP2221_I2C_READ_COMPL ||
 			    data[2] == MCP2221_I2C_READ_PARTIAL) {
+				if (!mcp->rxbuf || mcp->rxbuf_idx < 0 || data[3] > 60) {
+					mcp->status = -EINVAL;
+					break;
+				}
 				buf = mcp->rxbuf;
 				memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
 				mcp->rxbuf_idx = mcp->rxbuf_idx + data[3];
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 86244403b532..674f9f244f7b 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -661,6 +661,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
 	mutex_unlock(&igroup->lock);
 
+	iommufd_hw_pagetable_put(idev->ictx, hwpt);
+
 	/* Caller must destroy hwpt */
 	return hwpt;
 }
@@ -1007,7 +1009,6 @@ void iommufd_device_detach(struct iommufd_device *idev, ioasid_t pasid)
 	hwpt = iommufd_hw_pagetable_detach(idev, pasid);
 	if (!hwpt)
 		return;
-	iommufd_hw_pagetable_put(idev->ictx, hwpt);
 	refcount_dec(&idev->obj.users);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, "IOMMUFD");
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9ccc83341f32..e68d8d63076a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -390,9 +390,8 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 	if (hwpt->obj.type == IOMMUFD_OBJ_HWPT_PAGING) {
 		struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
 
-		lockdep_assert_not_held(&hwpt_paging->ioas->mutex);
-
 		if (hwpt_paging->auto_domain) {
+			lockdep_assert_not_held(&hwpt_paging->ioas->mutex);
 			iommufd_object_put_and_try_destroy(ictx, &hwpt->obj);
 			return;
 		}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 62a3469bbd37..2b26747ac202 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -62,6 +62,10 @@ void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
 	old = xas_store(&xas, NULL);
 	xa_unlock(&ictx->objects);
 	WARN_ON(old != XA_ZERO_ENTRY);
+
+	if (WARN_ON(!refcount_dec_and_test(&obj->users)))
+		return;
+
 	kfree(obj);
 }
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 4395657fa583..7b1d8f0c62fd 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -133,7 +133,7 @@ struct journal_sector {
 	commit_id_t commit_id;
 };
 
-#define MAX_TAG_SIZE			(JOURNAL_SECTOR_DATA - JOURNAL_MAC_PER_SECTOR - offsetof(struct journal_entry, last_bytes[MAX_SECTORS_PER_BLOCK]))
+#define MAX_TAG_SIZE			255
 
 #define METADATA_PADDING_SECTORS	8
 
diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
index 4840831c84ca..4aae0733d0fc 100644
--- a/drivers/misc/amd-sbi/Kconfig
+++ b/drivers/misc/amd-sbi/Kconfig
@@ -2,6 +2,7 @@
 config AMD_SBRMI_I2C
 	tristate "AMD side band RMI support"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  Side band RMI over I2C support for AMD out of band management.
 
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 7f10213738e5..e2ae8d6a9de6 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -870,9 +870,6 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	/* Reset Global error flags */
 	rcar_canfd_write(gpriv->base, RCANFD_GERFL, 0x0);
 
-	/* Set the controller into appropriate mode */
-	rcar_canfd_set_mode(gpriv);
-
 	/* Transition all Channels to reset mode */
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_clear_bit(gpriv->base,
@@ -892,6 +889,10 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 			return err;
 		}
 	}
+
+	/* Set the controller into appropriate mode */
+	rcar_canfd_set_mode(gpriv);
+
 	return 0;
 }
 
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 6441ff3b4198..963ea8510dd9 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -545,8 +545,6 @@ static int hi3110_stop(struct net_device *net)
 
 	priv->force_quit = 1;
 	free_irq(spi->irq, priv);
-	destroy_workqueue(priv->wq);
-	priv->wq = NULL;
 
 	mutex_lock(&priv->hi3110_lock);
 
@@ -770,34 +768,23 @@ static int hi3110_open(struct net_device *net)
 		goto out_close;
 	}
 
-	priv->wq = alloc_workqueue("hi3110_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM,
-				   0);
-	if (!priv->wq) {
-		ret = -ENOMEM;
-		goto out_free_irq;
-	}
-	INIT_WORK(&priv->tx_work, hi3110_tx_work_handler);
-	INIT_WORK(&priv->restart_work, hi3110_restart_work_handler);
-
 	ret = hi3110_hw_reset(spi);
 	if (ret)
-		goto out_free_wq;
+		goto out_free_irq;
 
 	ret = hi3110_setup(net);
 	if (ret)
-		goto out_free_wq;
+		goto out_free_irq;
 
 	ret = hi3110_set_normal_mode(spi);
 	if (ret)
-		goto out_free_wq;
+		goto out_free_irq;
 
 	netif_wake_queue(net);
 	mutex_unlock(&priv->hi3110_lock);
 
 	return 0;
 
- out_free_wq:
-	destroy_workqueue(priv->wq);
  out_free_irq:
 	free_irq(spi->irq, priv);
 	hi3110_hw_sleep(spi);
@@ -909,6 +896,15 @@ static int hi3110_can_probe(struct spi_device *spi)
 	if (ret)
 		goto out_clk;
 
+	priv->wq = alloc_workqueue("hi3110_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM,
+				   0);
+	if (!priv->wq) {
+		ret = -ENOMEM;
+		goto out_clk;
+	}
+	INIT_WORK(&priv->tx_work, hi3110_tx_work_handler);
+	INIT_WORK(&priv->restart_work, hi3110_restart_work_handler);
+
 	priv->spi = spi;
 	mutex_init(&priv->hi3110_lock);
 
@@ -944,6 +940,8 @@ static int hi3110_can_probe(struct spi_device *spi)
 	return 0;
 
  error_probe:
+	destroy_workqueue(priv->wq);
+	priv->wq = NULL;
 	hi3110_power_enable(priv->power, 0);
 
  out_clk:
@@ -964,6 +962,9 @@ static void hi3110_can_remove(struct spi_device *spi)
 
 	hi3110_power_enable(priv->power, 0);
 
+	destroy_workqueue(priv->wq);
+	priv->wq = NULL;
+
 	clk_disable_unprepare(priv->clk);
 
 	free_candev(net);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index c6f69d87c38d..d07f0f75d23f 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -8170,8 +8170,6 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x06f8, 0xe033, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
-{USB_DEVICE_AND_INTERFACE_INFO(0x07b8, 0x8188, 0xff, 0xff, 0xff),
-	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x07b8, 0x8189, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9041, 0xff, 0xff, 0xff),
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
index c9b9e2bc90cc..1d75d8ec0016 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
@@ -291,7 +291,6 @@ static const struct usb_device_id rtl8192c_usb_ids[] = {
 	{RTL_USB_DEVICE(0x050d, 0x1102, rtl92cu_hal_cfg)}, /*Belkin - Edimax*/
 	{RTL_USB_DEVICE(0x050d, 0x11f2, rtl92cu_hal_cfg)}, /*Belkin - ISY*/
 	{RTL_USB_DEVICE(0x06f8, 0xe033, rtl92cu_hal_cfg)}, /*Hercules - Edimax*/
-	{RTL_USB_DEVICE(0x07b8, 0x8188, rtl92cu_hal_cfg)}, /*Abocom - Abocom*/
 	{RTL_USB_DEVICE(0x07b8, 0x8189, rtl92cu_hal_cfg)}, /*Funai - Abocom*/
 	{RTL_USB_DEVICE(0x0846, 0x9041, rtl92cu_hal_cfg)}, /*NetGear WNA1000M*/
 	{RTL_USB_DEVICE(0x0846, 0x9043, rtl92cu_hal_cfg)}, /*NG WNA1000Mv2*/
diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index b18019b53181..17daf93fec0a 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1595,6 +1595,35 @@ static bool rtw89_mcc_duration_decision_on_bt(struct rtw89_dev *rtwdev)
 	return false;
 }
 
+void rtw89_mcc_prepare_done_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
+						mcc_prepare_done_work.work);
+
+	lockdep_assert_wiphy(wiphy);
+
+	ieee80211_wake_queues(rtwdev->hw);
+}
+
+static void rtw89_mcc_prepare(struct rtw89_dev *rtwdev, bool start)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_config *config = &mcc->config;
+
+	if (start) {
+		ieee80211_stop_queues(rtwdev->hw);
+
+		wiphy_delayed_work_queue(rtwdev->hw->wiphy,
+					 &rtwdev->mcc_prepare_done_work,
+					 usecs_to_jiffies(config->prepare_delay));
+	} else {
+		wiphy_delayed_work_queue(rtwdev->hw->wiphy,
+					 &rtwdev->mcc_prepare_done_work, 0);
+		wiphy_delayed_work_flush(rtwdev->hw->wiphy,
+					 &rtwdev->mcc_prepare_done_work);
+	}
+}
+
 static int rtw89_mcc_fill_start_tsf(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
@@ -1630,6 +1659,8 @@ static int rtw89_mcc_fill_start_tsf(struct rtw89_dev *rtwdev)
 
 	config->start_tsf = start_tsf;
 	config->start_tsf_in_aux_domain = tsf_aux + start_tsf - tsf;
+	config->prepare_delay = start_tsf - tsf;
+
 	return 0;
 }
 
@@ -2219,6 +2250,8 @@ static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_START);
 
 	rtw89_mcc_start_beacon_noa(rtwdev);
+
+	rtw89_mcc_prepare(rtwdev, true);
 	return 0;
 }
 
@@ -2307,6 +2340,8 @@ static void rtw89_mcc_stop(struct rtw89_dev *rtwdev,
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_STOP);
 
 	rtw89_mcc_stop_beacon_noa(rtwdev);
+
+	rtw89_mcc_prepare(rtwdev, false);
 }
 
 static int rtw89_mcc_update(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 2a25563593af..be998fdd8724 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -129,6 +129,8 @@ const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 #define rtw89_mgnt_chan_get(rtwdev, link_index) \
 	__rtw89_mgnt_chan_get(rtwdev, __func__, link_index)
 
+void rtw89_mcc_prepare_done_work(struct wiphy *wiphy, struct wiphy_work *work);
+
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_chanctx_conf *ctx);
 void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 894ab7ab94cc..b506afaaa3ec 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1050,6 +1050,14 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw89_tx_wait_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
+						tx_wait_work.work);
+
+	rtw89_tx_wait_list_clear(rtwdev);
+}
+
 void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)
 {
 	u8 ch_dma;
@@ -1067,6 +1075,8 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 	unsigned long time_left;
 	int ret = 0;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	wait = kzalloc(sizeof(*wait), GFP_KERNEL);
 	if (!wait) {
 		rtw89_core_tx_kick_off(rtwdev, qsel);
@@ -1074,18 +1084,23 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 	}
 
 	init_completion(&wait->completion);
+	wait->skb = skb;
 	rcu_assign_pointer(skb_data->wait, wait);
 
 	rtw89_core_tx_kick_off(rtwdev, qsel);
 	time_left = wait_for_completion_timeout(&wait->completion,
 						msecs_to_jiffies(timeout));
-	if (time_left == 0)
-		ret = -ETIMEDOUT;
-	else if (!wait->tx_done)
-		ret = -EAGAIN;
 
-	rcu_assign_pointer(skb_data->wait, NULL);
-	kfree_rcu(wait, rcu_head);
+	if (time_left == 0) {
+		ret = -ETIMEDOUT;
+		list_add_tail(&wait->list, &rtwdev->tx_waits);
+		wiphy_delayed_work_queue(rtwdev->hw->wiphy, &rtwdev->tx_wait_work,
+					 RTW89_TX_WAIT_WORK_TIMEOUT);
+	} else {
+		if (!wait->tx_done)
+			ret = -EAGAIN;
+		rtw89_tx_wait_release(wait);
+	}
 
 	return ret;
 }
@@ -4810,12 +4825,14 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 	wiphy_work_cancel(wiphy, &btc->dhcp_notify_work);
 	wiphy_work_cancel(wiphy, &btc->icmp_notify_work);
 	cancel_delayed_work_sync(&rtwdev->txq_reinvoke_work);
+	wiphy_delayed_work_cancel(wiphy, &rtwdev->tx_wait_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->track_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->chanctx_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->coex_act1_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->coex_bt_devinfo_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->coex_rfk_chk_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->cfo_track_work);
+	wiphy_delayed_work_cancel(wiphy, &rtwdev->mcc_prepare_done_work);
 	cancel_delayed_work_sync(&rtwdev->forbid_ba_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->antdiv_work);
 
@@ -5033,6 +5050,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 		INIT_LIST_HEAD(&rtwdev->scan_info.pkt_list[band]);
 	}
 	INIT_LIST_HEAD(&rtwdev->scan_info.chan_list);
+	INIT_LIST_HEAD(&rtwdev->tx_waits);
 	INIT_WORK(&rtwdev->ba_work, rtw89_core_ba_work);
 	INIT_WORK(&rtwdev->txq_work, rtw89_core_txq_work);
 	INIT_DELAYED_WORK(&rtwdev->txq_reinvoke_work, rtw89_core_txq_reinvoke_work);
@@ -5042,6 +5060,8 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	wiphy_delayed_work_init(&rtwdev->coex_bt_devinfo_work, rtw89_coex_bt_devinfo_work);
 	wiphy_delayed_work_init(&rtwdev->coex_rfk_chk_work, rtw89_coex_rfk_chk_work);
 	wiphy_delayed_work_init(&rtwdev->cfo_track_work, rtw89_phy_cfo_track_work);
+	wiphy_delayed_work_init(&rtwdev->mcc_prepare_done_work, rtw89_mcc_prepare_done_work);
+	wiphy_delayed_work_init(&rtwdev->tx_wait_work, rtw89_tx_wait_work);
 	INIT_DELAYED_WORK(&rtwdev->forbid_ba_work, rtw89_forbid_ba_work);
 	wiphy_delayed_work_init(&rtwdev->antdiv_work, rtw89_phy_antdiv_work);
 	rtwdev->txq_wq = alloc_workqueue("rtw89_tx_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1c8f3b9b7c4c..e2e90eab15ce 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3429,9 +3429,12 @@ struct rtw89_phy_rate_pattern {
 	bool enable;
 };
 
+#define RTW89_TX_WAIT_WORK_TIMEOUT msecs_to_jiffies(500)
 struct rtw89_tx_wait_info {
 	struct rcu_head rcu_head;
+	struct list_head list;
 	struct completion completion;
+	struct sk_buff *skb;
 	bool tx_done;
 };
 
@@ -5728,6 +5731,7 @@ struct rtw89_mcc_config {
 	struct rtw89_mcc_sync sync;
 	u64 start_tsf;
 	u64 start_tsf_in_aux_domain;
+	u64 prepare_delay;
 	u16 mcc_interval; /* TU */
 	u16 beacon_offset; /* TU */
 };
@@ -5801,6 +5805,9 @@ struct rtw89_dev {
 	/* used to protect rpwm */
 	spinlock_t rpwm_lock;
 
+	struct list_head tx_waits;
+	struct wiphy_delayed_work tx_wait_work;
+
 	struct rtw89_cam_info cam_info;
 
 	struct sk_buff_head c2h_queue;
@@ -5858,6 +5865,7 @@ struct rtw89_dev {
 	struct wiphy_delayed_work coex_bt_devinfo_work;
 	struct wiphy_delayed_work coex_rfk_chk_work;
 	struct wiphy_delayed_work cfo_track_work;
+	struct wiphy_delayed_work mcc_prepare_done_work;
 	struct delayed_work forbid_ba_work;
 	struct wiphy_delayed_work antdiv_work;
 	struct rtw89_ppdu_sts_info ppdu_sts;
@@ -6054,6 +6062,26 @@ rtw89_assoc_link_rcu_dereference(struct rtw89_dev *rtwdev, u8 macid)
 	list_first_entry_or_null(&p->dlink_pool, typeof(*p->links_inst), dlink_schd); \
 })
 
+static inline void rtw89_tx_wait_release(struct rtw89_tx_wait_info *wait)
+{
+	dev_kfree_skb_any(wait->skb);
+	kfree_rcu(wait, rcu_head);
+}
+
+static inline void rtw89_tx_wait_list_clear(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_tx_wait_info *wait, *tmp;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	list_for_each_entry_safe(wait, tmp, &rtwdev->tx_waits, list) {
+		if (!completion_done(&wait->completion))
+			continue;
+		list_del(&wait->list);
+		rtw89_tx_wait_release(wait);
+	}
+}
+
 static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
 				     struct rtw89_core_tx_request *tx_req)
 {
@@ -6063,6 +6091,7 @@ static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
 static inline void rtw89_hci_reset(struct rtw89_dev *rtwdev)
 {
 	rtwdev->hci.ops->reset(rtwdev);
+	rtw89_tx_wait_list_clear(rtwdev);
 }
 
 static inline int rtw89_hci_start(struct rtw89_dev *rtwdev)
@@ -7120,11 +7149,12 @@ static inline struct sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rtwdev,
 	return dev_alloc_skb(length);
 }
 
-static inline void rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
+static inline bool rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
 					       struct rtw89_tx_skb_data *skb_data,
 					       bool tx_done)
 {
 	struct rtw89_tx_wait_info *wait;
+	bool ret = false;
 
 	rcu_read_lock();
 
@@ -7132,11 +7162,14 @@ static inline void rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
 	if (!wait)
 		goto out;
 
+	ret = true;
 	wait->tx_done = tx_done;
-	complete(&wait->completion);
+	/* Don't access skb anymore after completion */
+	complete_all(&wait->completion);
 
 out:
 	rcu_read_unlock();
+	return ret;
 }
 
 static inline bool rtw89_is_mlo_1_1(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 064f6a940107..8eeb1a4498cd 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -464,7 +464,8 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rtwdev,
 	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	struct ieee80211_tx_info *info;
 
-	rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status == RTW89_TX_DONE);
+	if (rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status == RTW89_TX_DONE))
+		return;
 
 	info = IEEE80211_SKB_CB(skb);
 	ieee80211_tx_info_clear_status(info);
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 811c91481441..869ab22a7968 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -501,7 +501,9 @@ static void ser_reset_trx_st_hdl(struct rtw89_ser *ser, u8 evt)
 		}
 
 		drv_stop_rx(ser);
+		wiphy_lock(wiphy);
 		drv_trx_reset(ser);
+		wiphy_unlock(wiphy);
 
 		/* wait m3 */
 		hal_send_m2_event(ser);
diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index 65d39e19f6ec..f381ce1e84bd 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -45,11 +45,24 @@ static void nvmem_layout_bus_remove(struct device *dev)
 	return drv->remove(layout);
 }
 
+static int nvmem_layout_bus_uevent(const struct device *dev,
+				   struct kobj_uevent_env *env)
+{
+	int ret;
+
+	ret = of_device_uevent_modalias(dev, env);
+	if (ret != ENODEV)
+		return ret;
+
+	return 0;
+}
+
 static const struct bus_type nvmem_layout_bus_type = {
 	.name		= "nvmem-layout",
 	.match		= nvmem_layout_bus_match,
 	.probe		= nvmem_layout_bus_probe,
 	.remove		= nvmem_layout_bus_remove,
+	.uevent		= nvmem_layout_bus_uevent,
 };
 
 int __nvmem_layout_driver_register(struct nvmem_layout_driver *drv,
diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index 18fb44139de2..d63aaad7ef59 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -239,6 +239,14 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "WUJIE14-GX4HRXL"),
 		}
 	},
+	{
+		.ident = "MECHREVO Yilong15Pro Series GM5HG7A",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MECHREVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Yilong15Pro Series GM5HG7A"),
+		}
+	},
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=220116 */
 	{
 		.ident = "PCSpecialist Lafite Pro V 14M",
@@ -248,6 +256,13 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Lafite Pro V 14M"),
 		}
 	},
+	{
+		.ident = "TUXEDO Stellaris Slim 15 AMD Gen6",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
+		}
+	},
 	{
 		.ident = "TUXEDO InfinityBook Pro 14/15 AMD Gen10",
 		.driver_data = &quirk_spurious_8042,
diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index ef988605c4da..bc544a4a5266 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -403,6 +403,7 @@ static const struct acpi_device_id amd_pmf_acpi_ids[] = {
 	{"AMDI0103", 0},
 	{"AMDI0105", 0},
 	{"AMDI0107", 0},
+	{"AMDI0108", 0},
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, amd_pmf_acpi_ids);
diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index eb076bb4099b..4f540a9932fe 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -306,6 +306,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)oxp_x1,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1Pro EVA-02"),
+		},
+		.driver_data = (void *)oxp_x1,
+	},
 	{},
 };
 
diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 351f983ef914..d88e026204e0 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -42,7 +42,6 @@
 #define DRIVER_NAME "axis_fifo"
 
 #define READ_BUF_SIZE 128U /* read buffer length in words */
-#define WRITE_BUF_SIZE 128U /* write buffer length in words */
 
 /* ----------------------------
  *     IP register offsets
@@ -392,6 +391,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 	}
 
 	bytes_available = ioread32(fifo->base_addr + XLLF_RLR_OFFSET);
+	words_available = bytes_available / sizeof(u32);
 	if (!bytes_available) {
 		dev_err(fifo->dt_device, "received a packet of length 0\n");
 		ret = -EIO;
@@ -402,7 +402,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		dev_err(fifo->dt_device, "user read buffer too small (available bytes=%zu user buffer bytes=%zu)\n",
 			bytes_available, len);
 		ret = -EINVAL;
-		goto end_unlock;
+		goto err_flush_rx;
 	}
 
 	if (bytes_available % sizeof(u32)) {
@@ -411,11 +411,9 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		 */
 		dev_err(fifo->dt_device, "received a packet that isn't word-aligned\n");
 		ret = -EIO;
-		goto end_unlock;
+		goto err_flush_rx;
 	}
 
-	words_available = bytes_available / sizeof(u32);
-
 	/* read data into an intermediate buffer, copying the contents
 	 * to userspace when the buffer is full
 	 */
@@ -427,18 +425,23 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 			tmp_buf[i] = ioread32(fifo->base_addr +
 					      XLLF_RDFD_OFFSET);
 		}
+		words_available -= copy;
 
 		if (copy_to_user(buf + copied * sizeof(u32), tmp_buf,
 				 copy * sizeof(u32))) {
 			ret = -EFAULT;
-			goto end_unlock;
+			goto err_flush_rx;
 		}
 
 		copied += copy;
-		words_available -= copy;
 	}
+	mutex_unlock(&fifo->read_lock);
+
+	return bytes_available;
 
-	ret = bytes_available;
+err_flush_rx:
+	while (words_available--)
+		ioread32(fifo->base_addr + XLLF_RDFD_OFFSET);
 
 end_unlock:
 	mutex_unlock(&fifo->read_lock);
@@ -466,11 +469,8 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 {
 	struct axis_fifo *fifo = (struct axis_fifo *)f->private_data;
 	unsigned int words_to_write;
-	unsigned int copied;
-	unsigned int copy;
-	unsigned int i;
+	u32 *txbuf;
 	int ret;
-	u32 tmp_buf[WRITE_BUF_SIZE];
 
 	if (len % sizeof(u32)) {
 		dev_err(fifo->dt_device,
@@ -486,11 +486,17 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		return -EINVAL;
 	}
 
-	if (words_to_write > fifo->tx_fifo_depth) {
-		dev_err(fifo->dt_device, "tried to write more words [%u] than slots in the fifo buffer [%u]\n",
-			words_to_write, fifo->tx_fifo_depth);
+	/*
+	 * In 'Store-and-Forward' mode, the maximum packet that can be
+	 * transmitted is limited by the size of the FIFO, which is
+	 * (C_TX_FIFO_DEPTH–4)*(data interface width/8) bytes.
+	 *
+	 * Do not attempt to send a packet larger than 'tx_fifo_depth - 4',
+	 * otherwise a 'Transmit Packet Overrun Error' interrupt will be
+	 * raised, which requires a reset of the TX circuit to recover.
+	 */
+	if (words_to_write > (fifo->tx_fifo_depth - 4))
 		return -EINVAL;
-	}
 
 	if (fifo->write_flags & O_NONBLOCK) {
 		/*
@@ -529,32 +535,20 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		}
 	}
 
-	/* write data from an intermediate buffer into the fifo IP, refilling
-	 * the buffer with userspace data as needed
-	 */
-	copied = 0;
-	while (words_to_write > 0) {
-		copy = min(words_to_write, WRITE_BUF_SIZE);
-
-		if (copy_from_user(tmp_buf, buf + copied * sizeof(u32),
-				   copy * sizeof(u32))) {
-			ret = -EFAULT;
-			goto end_unlock;
-		}
-
-		for (i = 0; i < copy; i++)
-			iowrite32(tmp_buf[i], fifo->base_addr +
-				  XLLF_TDFD_OFFSET);
-
-		copied += copy;
-		words_to_write -= copy;
+	txbuf = vmemdup_user(buf, len);
+	if (IS_ERR(txbuf)) {
+		ret = PTR_ERR(txbuf);
+		goto end_unlock;
 	}
 
-	ret = copied * sizeof(u32);
+	for (int i = 0; i < words_to_write; ++i)
+		iowrite32(txbuf[i], fifo->base_addr + XLLF_TDFD_OFFSET);
 
 	/* write packet size to fifo */
-	iowrite32(ret, fifo->base_addr + XLLF_TLR_OFFSET);
+	iowrite32(len, fifo->base_addr + XLLF_TLR_OFFSET);
 
+	ret = len;
+	kvfree(txbuf);
 end_unlock:
 	mutex_unlock(&fifo->write_lock);
 
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 79a8186d3361..d80353287a05 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1405,7 +1405,7 @@ config SERIAL_STM32
 
 config SERIAL_STM32_CONSOLE
 	bool "Support for console on STM32"
-	depends on SERIAL_STM32=y
+	depends on SERIAL_STM32
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index fc869b7f803f..62e984d20e59 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2114,6 +2114,12 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9003, 0xff) },	/* Simcom SIM7500/SIM7600 MBIM mode */
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9011, 0xff),	/* Simcom SIM7500/SIM7600 RNDIS mode */
 	  .driver_info = RSVD(7) },
+	{ USB_DEVICE(0x1e0e, 0x9071),				/* Simcom SIM8230 RMNET mode */
+	  .driver_info = RSVD(3) | RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9078, 0xff),	/* Simcom SIM8230 ECM mode */
+	  .driver_info = RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x907b, 0xff),	/* Simcom SIM8230 RNDIS mode */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9205, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT+ECM mode */
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9206, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT-only mode */
 	{ USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_X060S_X200),
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 2928abf7eb82..fc46190d26c8 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -998,11 +998,18 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 	if (!btrfs_test_opt(fs_info, REF_VERIFY))
 		return 0;
 
+	extent_root = btrfs_extent_root(fs_info, 0);
+	/* If the extent tree is damaged we cannot ignore it (IGNOREBADROOTS). */
+	if (IS_ERR(extent_root)) {
+		btrfs_warn(fs_info, "ref-verify: extent tree not available, disabling");
+		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
+		return 0;
+	}
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	extent_root = btrfs_extent_root(fs_info, 0);
 	eb = btrfs_read_lock_root_node(extent_root);
 	level = btrfs_header_level(eb);
 	path->nodes[level] = eb;
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index f27ea5099a68..09394ac2c180 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -347,7 +347,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		folio_put(folio);
 		ret = filemap_write_and_wait_range(mapping, fpos, fpos + flen - 1);
 		if (ret < 0)
-			goto error_folio_unlock;
+			goto out;
 		continue;
 
 	copied:
diff --git a/include/linux/device.h b/include/linux/device.h
index 4940db137fff..94bbdef14088 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -851,6 +851,9 @@ static inline bool device_pm_not_required(struct device *dev)
 static inline void device_set_pm_not_required(struct device *dev)
 {
 	dev->power.no_pm = true;
+#ifdef CONFIG_PM
+	dev->power.no_callbacks = true;
+#endif
 }
 
 static inline void dev_pm_syscore_device(struct device *dev, bool val)
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 24bb5287c415..2bb311d99c10 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7180,7 +7180,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		atomic_dec(&cpu_buffer->resize_disabled);
 	}
 
-	return 0;
+	return err;
 }
 
 int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 339ec4e54778..8992d8bebbdd 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -726,10 +726,10 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
 	p9_debug(P9_DEBUG_TRANS, "client %p req %p\n", client, req);
 
 	spin_lock(&m->req_lock);
-	/* Ignore cancelled request if message has been received
-	 * before lock.
-	 */
-	if (req->status == REQ_STATUS_RCVD) {
+	/* Ignore cancelled request if status changed since the request was
+	 * processed in p9_client_flush()
+	*/
+	if (req->status != REQ_STATUS_SENT) {
 		spin_unlock(&m->req_lock);
 		return 0;
 	}
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index cd54cd64ea88..e1af0fa302a3 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -3,7 +3,7 @@
 //! Generic disk abstraction.
 //!
 //! C header: [`include/linux/blkdev.h`](srctree/include/linux/blkdev.h)
-//! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
+//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
 
 use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
 use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 3832779f439f..8df6fb06396c 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -2,7 +2,7 @@
 
 //! DRM device.
 //!
-//! C header: [`include/linux/drm/drm_device.h`](srctree/include/linux/drm/drm_device.h)
+//! C header: [`include/drm/drm_device.h`](srctree/include/drm/drm_device.h)
 
 use crate::{
     alloc::allocator::Kmalloc,
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index af93d46d03d3..349a50d188dd 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -2,7 +2,7 @@
 
 //! DRM driver core.
 //!
-//! C header: [`include/linux/drm/drm_drv.h`](srctree/include/linux/drm/drm_drv.h)
+//! C header: [`include/drm/drm_drv.h`](srctree/include/drm/drm_drv.h)
 
 use crate::{
     bindings, device,
diff --git a/rust/kernel/drm/file.rs b/rust/kernel/drm/file.rs
index b9527705e551..f736cade7eb4 100644
--- a/rust/kernel/drm/file.rs
+++ b/rust/kernel/drm/file.rs
@@ -2,7 +2,7 @@
 
 //! DRM File objects.
 //!
-//! C header: [`include/linux/drm/drm_file.h`](srctree/include/linux/drm/drm_file.h)
+//! C header: [`include/drm/drm_file.h`](srctree/include/drm/drm_file.h)
 
 use crate::{bindings, drm, error::Result, prelude::*, types::Opaque};
 use core::marker::PhantomData;
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 4cd69fa84318..f0af5a5f2a91 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -2,7 +2,7 @@
 
 //! DRM GEM API
 //!
-//! C header: [`include/linux/drm/drm_gem.h`](srctree/include/linux/drm/drm_gem.h)
+//! C header: [`include/drm/drm_gem.h`](srctree/include/drm/drm_gem.h)
 
 use crate::{
     alloc::flags::*,
diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 445639404fb7..a19bc8eca029 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -2,7 +2,7 @@
 
 //! DRM IOCTL definitions.
 //!
-//! C header: [`include/linux/drm/drm_ioctl.h`](srctree/include/linux/drm/drm_ioctl.h)
+//! C header: [`include/drm/drm_ioctl.h`](srctree/include/drm/drm_ioctl.h)
 
 use crate::ioctl;
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8435f8132e38..9c9f256c7f8f 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -238,8 +238,8 @@ pub trait Driver: Send {
 
     /// PCI driver probe.
     ///
-    /// Called when a new platform device is added or discovered.
-    /// Implementers should attempt to initialize the device here.
+    /// Called when a new pci device is added or discovered. Implementers should
+    /// attempt to initialize the device here.
     fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>;
 }
 
diff --git a/sound/pci/hda/tas2781_hda.c b/sound/pci/hda/tas2781_hda.c
index 34217ce9f28e..716bdc5f7d0c 100644
--- a/sound/pci/hda/tas2781_hda.c
+++ b/sound/pci/hda/tas2781_hda.c
@@ -31,6 +31,23 @@ const efi_guid_t tasdev_fct_efi_guid[] = {
 };
 EXPORT_SYMBOL_NS_GPL(tasdev_fct_efi_guid, "SND_HDA_SCODEC_TAS2781");
 
+/*
+ * The order of calibrated-data writing function is a bit different from the
+ * order in UEFI. Here is the conversion to match the order of calibrated-data
+ * writing function.
+ */
+static void cali_cnv(unsigned char *data, unsigned int base, int offset)
+{
+	struct cali_reg reg_data;
+
+	memcpy(&reg_data, &data[base], sizeof(reg_data));
+	/* the data order has to be swapped between r0_low_reg and inv0_reg */
+	swap(reg_data.r0_low_reg, reg_data.invr0_reg);
+
+	cpu_to_be32_array((__force __be32 *)(data + offset + 1),
+		(u32 *)&reg_data, TASDEV_CALIB_N);
+}
+
 static void tas2781_apply_calib(struct tasdevice_priv *p)
 {
 	struct calidata *cali_data = &p->cali_data;
@@ -101,8 +118,7 @@ static void tas2781_apply_calib(struct tasdevice_priv *p)
 
 				data[l] = k;
 				oft++;
-				for (i = 0; i < TASDEV_CALIB_N * 4; i++)
-					data[l + i + 1] = data[4 * oft + i];
+				cali_cnv(data, 4 * oft, l);
 				k++;
 			}
 		}
@@ -128,9 +144,8 @@ static void tas2781_apply_calib(struct tasdevice_priv *p)
 
 		for (j = p->ndev - 1; j >= 0; j--) {
 			l = j * (cali_data->cali_dat_sz_per_dev + 1);
-			for (i = TASDEV_CALIB_N * 4; i > 0 ; i--)
-				data[l + i] = data[p->index * 5 + i];
-			data[l+i] = j;
+			cali_cnv(data, cali_data->cali_dat_sz_per_dev * j, l);
+			data[l] = j;
 		}
 	}
 
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index cb8d97122f95..73a028e67246 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -130,7 +130,7 @@
 #define PDM_DMA_INTR_MASK       0x10000
 #define PDM_DEC_64              0x2
 #define PDM_CLK_FREQ_MASK       0x07
-#define PDM_MISC_CTRL_MASK      0x10
+#define PDM_MISC_CTRL_MASK      0x18
 #define PDM_ENABLE              0x01
 #define PDM_DISABLE             0x00
 #define DMA_EN_MASK             0x02
diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index 73c4b3c31f8c..d44f7574631d 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -653,14 +653,15 @@ static void rt5682s_sar_power_mode(struct snd_soc_component *component, int mode
 	switch (mode) {
 	case SAR_PWR_SAVING:
 		snd_soc_component_update_bits(component, RT5682S_CBJ_CTRL_3,
-			RT5682S_CBJ_IN_BUF_MASK, RT5682S_CBJ_IN_BUF_DIS);
+			RT5682S_CBJ_IN_BUF_MASK, RT5682S_CBJ_IN_BUF_EN);
 		snd_soc_component_update_bits(component, RT5682S_CBJ_CTRL_1,
-			RT5682S_MB1_PATH_MASK | RT5682S_MB2_PATH_MASK,
-			RT5682S_CTRL_MB1_REG | RT5682S_CTRL_MB2_REG);
+			RT5682S_MB1_PATH_MASK | RT5682S_MB2_PATH_MASK |
+			RT5682S_VREF_POW_MASK, RT5682S_CTRL_MB1_FSM |
+			RT5682S_CTRL_MB2_FSM | RT5682S_VREF_POW_FSM);
 		snd_soc_component_update_bits(component, RT5682S_SAR_IL_CMD_1,
 			RT5682S_SAR_BUTDET_MASK | RT5682S_SAR_BUTDET_POW_MASK |
 			RT5682S_SAR_SEL_MB1_2_CTL_MASK, RT5682S_SAR_BUTDET_DIS |
-			RT5682S_SAR_BUTDET_POW_SAV | RT5682S_SAR_SEL_MB1_2_MANU);
+			RT5682S_SAR_BUTDET_POW_NORM | RT5682S_SAR_SEL_MB1_2_MANU);
 		usleep_range(5000, 5500);
 		snd_soc_component_update_bits(component, RT5682S_SAR_IL_CMD_1,
 			RT5682S_SAR_BUTDET_MASK, RT5682S_SAR_BUTDET_EN);
@@ -688,7 +689,7 @@ static void rt5682s_sar_power_mode(struct snd_soc_component *component, int mode
 		snd_soc_component_update_bits(component, RT5682S_SAR_IL_CMD_1,
 			RT5682S_SAR_BUTDET_MASK | RT5682S_SAR_BUTDET_POW_MASK |
 			RT5682S_SAR_SEL_MB1_2_CTL_MASK, RT5682S_SAR_BUTDET_DIS |
-			RT5682S_SAR_BUTDET_POW_SAV | RT5682S_SAR_SEL_MB1_2_MANU);
+			RT5682S_SAR_BUTDET_POW_NORM | RT5682S_SAR_SEL_MB1_2_MANU);
 		break;
 	default:
 		dev_err(component->dev, "Invalid SAR Power mode: %d\n", mode);
@@ -725,7 +726,7 @@ static void rt5682s_disable_push_button_irq(struct snd_soc_component *component)
 	snd_soc_component_update_bits(component, RT5682S_SAR_IL_CMD_1,
 		RT5682S_SAR_BUTDET_MASK | RT5682S_SAR_BUTDET_POW_MASK |
 		RT5682S_SAR_SEL_MB1_2_CTL_MASK, RT5682S_SAR_BUTDET_DIS |
-		RT5682S_SAR_BUTDET_POW_SAV | RT5682S_SAR_SEL_MB1_2_MANU);
+		RT5682S_SAR_BUTDET_POW_NORM | RT5682S_SAR_SEL_MB1_2_MANU);
 }
 
 /**
@@ -786,7 +787,7 @@ static int rt5682s_headset_detect(struct snd_soc_component *component, int jack_
 			jack_type = SND_JACK_HEADSET;
 			snd_soc_component_write(component, RT5682S_SAR_IL_CMD_3, 0x024c);
 			snd_soc_component_update_bits(component, RT5682S_CBJ_CTRL_1,
-				RT5682S_FAST_OFF_MASK, RT5682S_FAST_OFF_EN);
+				RT5682S_FAST_OFF_MASK, RT5682S_FAST_OFF_DIS);
 			snd_soc_component_update_bits(component, RT5682S_SAR_IL_CMD_1,
 				RT5682S_SAR_SEL_MB1_2_MASK, val << RT5682S_SAR_SEL_MB1_2_SFT);
 			rt5682s_enable_push_button_irq(component);
@@ -966,7 +967,7 @@ static int rt5682s_set_jack_detect(struct snd_soc_component *component,
 			RT5682S_EMB_JD_MASK | RT5682S_DET_TYPE |
 			RT5682S_POL_FAST_OFF_MASK | RT5682S_MIC_CAP_MASK,
 			RT5682S_EMB_JD_EN | RT5682S_DET_TYPE |
-			RT5682S_POL_FAST_OFF_HIGH | RT5682S_MIC_CAP_HS);
+			RT5682S_POL_FAST_OFF_LOW | RT5682S_MIC_CAP_HS);
 		regmap_update_bits(rt5682s->regmap, RT5682S_SAR_IL_CMD_1,
 			RT5682S_SAR_POW_MASK, RT5682S_SAR_POW_EN);
 		regmap_update_bits(rt5682s->regmap, RT5682S_GPIO_CTRL_1,
diff --git a/sound/soc/codecs/rt712-sdca.c b/sound/soc/codecs/rt712-sdca.c
index 570c2af1245d..0c57aee766b5 100644
--- a/sound/soc/codecs/rt712-sdca.c
+++ b/sound/soc/codecs/rt712-sdca.c
@@ -1891,11 +1891,9 @@ int rt712_sdca_io_init(struct device *dev, struct sdw_slave *slave)
 
 		rt712_sdca_va_io_init(rt712);
 	} else {
-		if (!rt712->dmic_function_found) {
-			dev_err(&slave->dev, "%s RT712 VB detected but no SMART_MIC function exposed in ACPI\n",
+		if (!rt712->dmic_function_found)
+			dev_warn(&slave->dev, "%s RT712 VB detected but no SMART_MIC function exposed in ACPI\n",
 				__func__);
-			goto suspend;
-		}
 
 		/* multilanes and DMIC are supported by rt712vb */
 		prop->lane_control_support = true;
diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index 9ef569492560..ddaeb4eb3e24 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -75,6 +75,9 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 	size_t ci, cj, ei;
 	int cmp;
 
+	if (!excludes->cnt)
+		return;
+
 	ci = cj = ei = 0;
 	while (ci < cmds->cnt && ei < excludes->cnt) {
 		cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);

