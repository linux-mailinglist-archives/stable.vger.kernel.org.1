Return-Path: <stable+bounces-184099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF73BD0136
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 13:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A253BC849
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED6A273D92;
	Sun, 12 Oct 2025 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UDFWi7L9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351A2561AA;
	Sun, 12 Oct 2025 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760268002; cv=none; b=pKjMhXl2nNXlJJeqd4BfObKZuggvZHGGzEkCIBzDdqPXTHGymjdgD+MVPHc8VOLeUaJy+vaiF/DgS8/eQlubk6/XsvE+W5YzKIkNCutuHNV485gy+dqVrBOfNg7DTxLuXd5us6cKXMQ+AC0y0r8wpODjF253x4MstXXCy/Zfygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760268002; c=relaxed/simple;
	bh=pFcAqGvwNs6UlzwpGq2O5KC8oAsf3cIRJaPBOTRajp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNOgesi0kDfHwkHZ8jpw5Br3IPkeO7NPBTC4UVQsso1HE1iOYsOf8p9J+g4g7r/D/UxT81a46Peai2Rib2+Brjf8MYFnsceMD36F0GGN5wL5vORYVJbEiPeSIKVahEMYyX81Vy3xZPPOtBTVQMcmTbEfUcsbSc9CyD1jfI/3pJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UDFWi7L9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C268C4CEF1;
	Sun, 12 Oct 2025 11:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760268001;
	bh=pFcAqGvwNs6UlzwpGq2O5KC8oAsf3cIRJaPBOTRajp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UDFWi7L979KCu8ch86u87nRrkEIKFyZA8cS900wQwN8/PN9Mq3Qvay2sSi5KtOflx
	 D/YoXoUXPy1+uP3eC0upiG2Qof1JyvNJRdw/60x8fnE/2wnuNI5MGAznnbFTyiaFEh
	 du5AHVZWjYWBTS5fSRctXqMVAh0j9Em4N0M3rBK4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.52
Date: Sun, 12 Oct 2025 13:19:45 +0200
Message-ID: <2025101245-variably-sprint-08f0@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101245-friction-starring-6238@gregkh>
References: <2025101245-friction-starring-6238@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 05b7983b56ed..3345d6257350 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 51
+SUBLEVEL = 52
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 60986f67c35a..4b4394414103 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5104,12 +5104,11 @@ void init_decode_cache(struct x86_emulate_ctxt *ctxt)
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
 
@@ -5157,7 +5156,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 				fetch_possible_mmx_operand(&ctxt->dst);
 		}
 
-		if (unlikely(is_guest_mode) && ctxt->intercept) {
+		if (unlikely(check_intercepts) && ctxt->intercept) {
 			rc = emulator_check_intercept(ctxt, ctxt->intercept,
 						      X86_ICPT_PRE_EXCEPT);
 			if (rc != X86EMUL_CONTINUE)
@@ -5186,7 +5185,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 				goto done;
 		}
 
-		if (unlikely(is_guest_mode) && (ctxt->d & Intercept)) {
+		if (unlikely(check_intercepts) && (ctxt->d & Intercept)) {
 			rc = emulator_check_intercept(ctxt, ctxt->intercept,
 						      X86_ICPT_POST_EXCEPT);
 			if (rc != X86EMUL_CONTINUE)
@@ -5240,7 +5239,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 
 special_insn:
 
-	if (unlikely(is_guest_mode) && (ctxt->d & Intercept)) {
+	if (unlikely(check_intercepts) && (ctxt->d & Intercept)) {
 		rc = emulator_check_intercept(ctxt, ctxt->intercept,
 					      X86_ICPT_POST_MEMACCESS);
 		if (rc != X86EMUL_CONTINUE)
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 10495fffb890..1bede46b67c3 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -230,7 +230,6 @@ struct x86_emulate_ops {
 	void (*set_nmi_mask)(struct x86_emulate_ctxt *ctxt, bool masked);
 
 	bool (*is_smm)(struct x86_emulate_ctxt *ctxt);
-	bool (*is_guest_mode)(struct x86_emulate_ctxt *ctxt);
 	int (*leave_smm)(struct x86_emulate_ctxt *ctxt);
 	void (*triple_fault)(struct x86_emulate_ctxt *ctxt);
 	int (*set_xcr)(struct x86_emulate_ctxt *ctxt, u32 index, u64 xcr);
@@ -514,7 +513,7 @@ bool x86_page_table_writing_insn(struct x86_emulate_ctxt *ctxt);
 #define EMULATION_RESTART 1
 #define EMULATION_INTERCEPTED 2
 void init_decode_cache(struct x86_emulate_ctxt *ctxt);
-int x86_emulate_insn(struct x86_emulate_ctxt *ctxt);
+int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts);
 int emulator_task_switch(struct x86_emulate_ctxt *ctxt,
 			 u16 tss_selector, int idt_index, int reason,
 			 bool has_error_code, u32 error_code);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 13ab13d2e9d6..86cabeca6265 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8567,11 +8567,6 @@ static bool emulator_is_smm(struct x86_emulate_ctxt *ctxt)
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
@@ -8655,7 +8650,6 @@ static const struct x86_emulate_ops emulate_ops = {
 	.guest_cpuid_is_intel_compatible = emulator_guest_cpuid_is_intel_compatible,
 	.set_nmi_mask        = emulator_set_nmi_mask,
 	.is_smm              = emulator_is_smm,
-	.is_guest_mode       = emulator_is_guest_mode,
 	.leave_smm           = emulator_leave_smm,
 	.triple_fault        = emulator_triple_fault,
 	.set_xcr             = emulator_set_xcr,
@@ -9209,7 +9203,14 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
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
index 9d8804e46422..72da96fdfb5d 100644
--- a/crypto/rng.c
+++ b/crypto/rng.c
@@ -167,6 +167,11 @@ int crypto_del_default_rng(void)
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
@@ -178,6 +183,9 @@ int crypto_register_rng(struct rng_alg *alg)
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
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d7aaaeb4fe32..c07d57eaca3b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -514,6 +514,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8851BU Bluetooth devices */
 	{ USB_DEVICE(0x3625, 0x010b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2001, 0x332a), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 49113df8baef..25b175f23312 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -677,6 +677,12 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
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
index 459f7b8d72b4..e3f4f5fbbd6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -610,6 +610,11 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
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
index 21ceafce1f9b..ab1cfc92dbeb 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -230,13 +230,24 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t disable_add_queue_wptr_mc_addr : 1;
 				uint32_t enable_mes_event_int_logging : 1;
 				uint32_t enable_reg_active_poll : 1;
-				uint32_t reserved	: 21;
+				uint32_t use_disable_queue_in_legacy_uq_preemption : 1;
+				uint32_t send_write_data : 1;
+				uint32_t os_tdr_timeout_override : 1;
+				uint32_t use_rs64mem_for_proc_gang_ctx : 1;
+				uint32_t use_add_queue_unmap_flag_addr : 1;
+				uint32_t enable_mes_sch_stb_log : 1;
+				uint32_t limit_single_process : 1;
+				uint32_t is_strix_tmz_wa_enabled  :1;
+				uint32_t enable_lr_compute_wa : 1;
+				uint32_t reserved : 12;
 			};
 			uint32_t	uint32_t_all;
 		};
 		uint32_t	oversubscription_timer;
 		uint64_t        doorbell_info;
 		uint64_t        event_intr_history_gpu_mc_ptr;
+		uint64_t	timestamp;
+		uint32_t	os_tdr_timeout_in_sec;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -256,7 +267,8 @@ union MESAPI_SET_HW_RESOURCES_1 {
 		};
 		uint64_t							mes_info_ctx_mc_addr;
 		uint32_t							mes_info_ctx_size;
-		uint32_t							mes_kiq_unmap_timeout; // unit is 100ms
+		uint64_t							reserved1;
+		uint64_t							cleaner_shader_fence_mc_addr;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -563,6 +575,11 @@ enum MESAPI_MISC_OPCODE {
 	MESAPI_MISC__READ_REG,
 	MESAPI_MISC__WAIT_REG_MEM,
 	MESAPI_MISC__SET_SHADER_DEBUGGER,
+	MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE,
+	MESAPI_MISC__NOTIFY_TO_UNMAP_PROCESSES,
+	MESAPI_MISC__CHANGE_CONFIG,
+	MESAPI_MISC__LAUNCH_CLEANER_SHADER,
+
 	MESAPI_MISC__MAX,
 };
 
@@ -617,6 +634,31 @@ struct SET_SHADER_DEBUGGER {
 	uint32_t trap_en;
 };
 
+enum MESAPI_MISC__CHANGE_CONFIG_OPTION {
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_SINGLE_PROCESS = 0,
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_ENABLE_HWS_LOGGING_BUFFER = 1,
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_CHANGE_TDR_CONFIG    = 2,
+
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_MAX = 0x1F
+};
+
+struct CHANGE_CONFIG {
+	enum MESAPI_MISC__CHANGE_CONFIG_OPTION opcode;
+	union {
+		struct {
+			uint32_t limit_single_process : 1;
+			uint32_t enable_hws_logging_buffer : 1;
+			uint32_t reserved : 31;
+		} bits;
+		uint32_t all;
+	} option;
+
+	struct {
+		uint32_t tdr_level;
+		uint32_t tdr_delay;
+	} tdr_config;
+};
+
 union MESAPI__MISC {
 	struct {
 		union MES_API_HEADER	header;
@@ -631,6 +673,7 @@ union MESAPI__MISC {
 			struct          WAIT_REG_MEM wait_reg_mem;
 			struct		SET_SHADER_DEBUGGER set_shader_debugger;
 			enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
+			struct		CHANGE_CONFIG change_config;
 
 			uint32_t	data[MISC_DATA_MAX_SIZE_IN_DWORDS];
 		};
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index 101e2fe962c6..a402974939d6 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -105,6 +105,43 @@ struct MES_API_STATUS {
 	uint64_t api_completion_fence_value;
 };
 
+/*
+ * MES will set api_completion_fence_value in api_completion_fence_addr
+ * when it can successflly process the API. MES will also trigger
+ * following interrupt when it finish process the API no matter success
+ * or failed.
+ *     Interrupt source id 181 (EOP) with context ID (DW 6 in the int
+ *     cookie) set to 0xb1 and context type set to 8. Driver side need
+ *     to enable TIME_STAMP_INT_ENABLE in CPC_INT_CNTL for MES pipe to
+ *     catch this interrupt.
+ *     Driver side also need to set enable_mes_fence_int = 1 in
+ *     set_HW_resource package to enable this fence interrupt.
+ * when the API process failed.
+ *     lowre 32 bits set to 0.
+ *     higher 32 bits set as follows (bit shift within high 32)
+ *         bit 0  -  7    API specific error code.
+ *         bit 8  - 15    API OPCODE.
+ *         bit 16 - 23    MISC OPCODE if any
+ *         bit 24 - 30    ERROR category (API_ERROR_XXX)
+ *         bit 31         Set to 1 to indicate error status
+ *
+ */
+enum { MES_SCH_ERROR_CODE_HEADER_SHIFT_12 = 8 };
+enum { MES_SCH_ERROR_CODE_MISC_OP_SHIFT_12 = 16 };
+enum { MES_ERROR_CATEGORY_SHIFT_12 = 24 };
+enum { MES_API_STATUS_ERROR_SHIFT_12 = 31 };
+
+enum MES_ERROR_CATEGORY_CODE_12 {
+	MES_ERROR_API                = 1,
+	MES_ERROR_SCHEDULING         = 2,
+	MES_ERROR_UNKNOWN            = 3,
+};
+
+#define MES_ERR_CODE(api_err, opcode, misc_op, category) \
+			((uint64) (api_err | opcode << MES_SCH_ERROR_CODE_HEADER_SHIFT_12 | \
+			misc_op << MES_SCH_ERROR_CODE_MISC_OP_SHIFT_12 | \
+			category << MES_ERROR_CATEGORY_SHIFT_12 | \
+			1 << MES_API_STATUS_ERROR_SHIFT_12) << 32)
 
 enum { MAX_COMPUTE_PIPES = 8 };
 enum { MAX_GFX_PIPES	 = 2 };
@@ -248,7 +285,9 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t enable_mes_sch_stb_log : 1;
 				uint32_t limit_single_process : 1;
 				uint32_t unmapped_doorbell_handling: 2;
-				uint32_t reserved : 11;
+				uint32_t enable_mes_fence_int: 1;
+				uint32_t enable_lr_compute_wa : 1;
+				uint32_t reserved : 9;
 			};
 			uint32_t uint32_all;
 		};
@@ -278,6 +317,8 @@ union MESAPI_SET_HW_RESOURCES_1 {
 		uint32_t                            mes_debug_ctx_size;
 		/* unit is 100ms */
 		uint32_t                            mes_kiq_unmap_timeout;
+		uint64_t                            reserved1;
+		uint64_t                            cleaner_shader_fence_mc_addr;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -643,6 +684,10 @@ enum MESAPI_MISC_OPCODE {
 	MESAPI_MISC__SET_SHADER_DEBUGGER,
 	MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE,
 	MESAPI_MISC__NOTIFY_TO_UNMAP_PROCESSES,
+	MESAPI_MISC__QUERY_HUNG_ENGINE_ID,
+	MESAPI_MISC__CHANGE_CONFIG,
+	MESAPI_MISC__LAUNCH_CLEANER_SHADER,
+	MESAPI_MISC__SETUP_MES_DBGEXT,
 
 	MESAPI_MISC__MAX,
 };
@@ -713,6 +758,31 @@ struct SET_GANG_SUBMIT {
 	uint32_t slave_gang_context_array_index;
 };
 
+enum MESAPI_MISC__CHANGE_CONFIG_OPTION {
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_SINGLE_PROCESS = 0,
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_ENABLE_HWS_LOGGING_BUFFER = 1,
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_CHANGE_TDR_CONFIG    = 2,
+
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_MAX = 0x1F
+};
+
+struct CHANGE_CONFIG {
+	enum MESAPI_MISC__CHANGE_CONFIG_OPTION opcode;
+	union {
+		struct  {
+			uint32_t limit_single_process : 1;
+			uint32_t enable_hws_logging_buffer : 1;
+			uint32_t reserved : 30;
+		} bits;
+		uint32_t all;
+	} option;
+
+	struct {
+		uint32_t tdr_level;
+		uint32_t tdr_delay;
+	} tdr_config;
+};
+
 union MESAPI__MISC {
 	struct {
 		union MES_API_HEADER	header;
@@ -726,7 +796,7 @@ union MESAPI__MISC {
 			struct WAIT_REG_MEM wait_reg_mem;
 			struct SET_SHADER_DEBUGGER set_shader_debugger;
 			enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
-
+			struct CHANGE_CONFIG change_config;
 			uint32_t data[MISC_DATA_MAX_SIZE_IN_DWORDS];
 		};
 		uint64_t		timestamp;
diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 0f93c22a479f..83941b916cd6 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -814,6 +814,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
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
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 450e1a7e7bac..444cf35feebf 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -133,7 +133,7 @@ struct journal_sector {
 	commit_id_t commit_id;
 };
 
-#define MAX_TAG_SIZE			(JOURNAL_SECTOR_DATA - JOURNAL_MAC_PER_SECTOR - offsetof(struct journal_entry, last_bytes[MAX_SECTORS_PER_BLOCK]))
+#define MAX_TAG_SIZE			255
 
 #define METADATA_PADDING_SECTORS	8
 
diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index d1306f39fa13..6a023fe22635 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -2189,10 +2189,10 @@ static int tc358743_probe(struct i2c_client *client)
 err_work_queues:
 	cec_unregister_adapter(state->cec_adap);
 	if (!state->i2c_client->irq) {
-		del_timer(&state->timer);
+		timer_delete_sync(&state->timer);
 		flush_work(&state->work_i2c_poll);
 	}
-	cancel_delayed_work(&state->delayed_work_enable_hotplug);
+	cancel_delayed_work_sync(&state->delayed_work_enable_hotplug);
 	mutex_destroy(&state->confctl_mutex);
 err_hdl:
 	media_entity_cleanup(&sd->entity);
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index aa3df0d05b85..24dd15c91722 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -732,9 +732,6 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	/* Reset Global error flags */
 	rcar_canfd_write(gpriv->base, RCANFD_GERFL, 0x0);
 
-	/* Set the controller into appropriate mode */
-	rcar_canfd_set_mode(gpriv);
-
 	/* Transition all Channels to reset mode */
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_clear_bit(gpriv->base,
@@ -754,6 +751,10 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
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
index ff39afc77d7d..c9eba1d37b0e 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -545,8 +545,6 @@ static int hi3110_stop(struct net_device *net)
 
 	priv->force_quit = 1;
 	free_irq(spi->irq, priv);
-	destroy_workqueue(priv->wq);
-	priv->wq = NULL;
 
 	mutex_lock(&priv->hi3110_lock);
 
@@ -771,34 +769,23 @@ static int hi3110_open(struct net_device *net)
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
@@ -910,6 +897,15 @@ static int hi3110_can_probe(struct spi_device *spi)
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
 
@@ -945,6 +941,8 @@ static int hi3110_can_probe(struct spi_device *spi)
 	return 0;
 
  error_probe:
+	destroy_workqueue(priv->wq);
+	priv->wq = NULL;
 	hi3110_power_enable(priv->power, 0);
 
  out_clk:
@@ -965,6 +963,9 @@ static void hi3110_can_remove(struct spi_device *spi)
 
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
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c336c66ac8e3..99711a4fb85d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -960,6 +960,14 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
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
@@ -977,6 +985,8 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
 	unsigned long time_left;
 	int ret = 0;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	wait = kzalloc(sizeof(*wait), GFP_KERNEL);
 	if (!wait) {
 		rtw89_core_tx_kick_off(rtwdev, qsel);
@@ -984,18 +994,23 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *sk
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
@@ -4419,6 +4434,7 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 void rtw89_core_stop(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	struct wiphy *wiphy = rtwdev->hw->wiphy;
 
 	/* Prvent to stop twice; enter_ips and ops_stop */
 	if (!test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
@@ -4437,6 +4453,7 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 	cancel_work_sync(&btc->dhcp_notify_work);
 	cancel_work_sync(&btc->icmp_notify_work);
 	cancel_delayed_work_sync(&rtwdev->txq_reinvoke_work);
+	wiphy_delayed_work_cancel(wiphy, &rtwdev->tx_wait_work);
 	cancel_delayed_work_sync(&rtwdev->track_work);
 	cancel_delayed_work_sync(&rtwdev->chanctx_work);
 	cancel_delayed_work_sync(&rtwdev->coex_act1_work);
@@ -4657,6 +4674,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 			continue;
 		INIT_LIST_HEAD(&rtwdev->scan_info.pkt_list[band]);
 	}
+	INIT_LIST_HEAD(&rtwdev->tx_waits);
 	INIT_WORK(&rtwdev->ba_work, rtw89_core_ba_work);
 	INIT_WORK(&rtwdev->txq_work, rtw89_core_txq_work);
 	INIT_DELAYED_WORK(&rtwdev->txq_reinvoke_work, rtw89_core_txq_reinvoke_work);
@@ -4666,6 +4684,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	INIT_DELAYED_WORK(&rtwdev->coex_bt_devinfo_work, rtw89_coex_bt_devinfo_work);
 	INIT_DELAYED_WORK(&rtwdev->coex_rfk_chk_work, rtw89_coex_rfk_chk_work);
 	INIT_DELAYED_WORK(&rtwdev->cfo_track_work, rtw89_phy_cfo_track_work);
+	wiphy_delayed_work_init(&rtwdev->tx_wait_work, rtw89_tx_wait_work);
 	INIT_DELAYED_WORK(&rtwdev->forbid_ba_work, rtw89_forbid_ba_work);
 	INIT_DELAYED_WORK(&rtwdev->antdiv_work, rtw89_phy_antdiv_work);
 	rtwdev->txq_wq = alloc_workqueue("rtw89_tx_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4f64ea392e6c..cb703588e3a4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3406,9 +3406,12 @@ struct rtw89_phy_rate_pattern {
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
 
@@ -5539,6 +5542,9 @@ struct rtw89_dev {
 	/* used to protect rpwm */
 	spinlock_t rpwm_lock;
 
+	struct list_head tx_waits;
+	struct wiphy_delayed_work tx_wait_work;
+
 	struct rtw89_cam_info cam_info;
 
 	struct sk_buff_head c2h_queue;
@@ -5735,6 +5741,26 @@ u8 rtw89_sta_link_inst_get_index(struct rtw89_sta_link *rtwsta_link)
 	return rtwsta_link - rtwsta->links_inst;
 }
 
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
@@ -5744,6 +5770,7 @@ static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
 static inline void rtw89_hci_reset(struct rtw89_dev *rtwdev)
 {
 	rtwdev->hci.ops->reset(rtwdev);
+	rtw89_tx_wait_list_clear(rtwdev);
 }
 
 static inline int rtw89_hci_start(struct rtw89_dev *rtwdev)
@@ -6745,11 +6772,12 @@ static inline struct sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rtwdev,
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
 
@@ -6757,11 +6785,14 @@ static inline void rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
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
index e203d3b2a827..5fd5fe88e6b0 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -458,7 +458,8 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rtwdev,
 	struct rtw89_tx_skb_data *skb_data = RTW89_TX_SKB_CB(skb);
 	struct ieee80211_tx_info *info;
 
-	rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status == RTW89_TX_DONE);
+	if (rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status == RTW89_TX_DONE))
+		return;
 
 	info = IEEE80211_SKB_CB(skb);
 	ieee80211_tx_info_clear_status(info);
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 02c2ac12f197..c0f0e3d71f5f 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -484,6 +484,7 @@ static void ser_l1_reset_pre_st_hdl(struct rtw89_ser *ser, u8 evt)
 static void ser_reset_trx_st_hdl(struct rtw89_ser *ser, u8 evt)
 {
 	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+	struct wiphy *wiphy = rtwdev->hw->wiphy;
 
 	switch (evt) {
 	case SER_EV_STATE_IN:
@@ -496,7 +497,9 @@ static void ser_reset_trx_st_hdl(struct rtw89_ser *ser, u8 evt)
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
index 6f5437d210a6..9fd2829ee2ab 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -233,6 +233,14 @@ static const struct dmi_system_id fwbug_list[] = {
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
@@ -242,6 +250,13 @@ static const struct dmi_system_id fwbug_list[] = {
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
index 719caa2a00f0..8a1e2268d301 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -406,6 +406,7 @@ static const struct acpi_device_id amd_pmf_acpi_ids[] = {
 	{"AMDI0103", 0},
 	{"AMDI0105", 0},
 	{"AMDI0107", 0},
+	{"AMDI0108", 0},
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, amd_pmf_acpi_ids);
diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 6769f066b0b4..028ed5d0ecbe 100644
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
index 28e4beeabf8f..4fd789a77a13 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1401,7 +1401,7 @@ config SERIAL_STM32
 
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
index 896d1d4219ed..be77a137cc87 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -340,7 +340,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		folio_put(folio);
 		ret = filemap_write_and_wait_range(mapping, fpos, fpos + flen - 1);
 		if (ret < 0)
-			goto error_folio_unlock;
+			goto out;
 		continue;
 
 	copied:
diff --git a/include/linux/device.h b/include/linux/device.h
index 39120b172992..1f6130e13620 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -873,6 +873,9 @@ static inline bool device_pm_not_required(struct device *dev)
 static inline void device_set_pm_not_required(struct device *dev)
 {
 	dev->power.no_pm = true;
+#ifdef CONFIG_PM
+	dev->power.no_callbacks = true;
+#endif
 }
 
 static inline void dev_pm_syscore_device(struct device *dev, bool val)
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 791e4868f2d4..7e9d731c4597 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -725,10 +725,10 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
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
index c6df153ebb88..8cd47ddd1dbb 100644
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
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 854269fea875..aa0aa64202fe 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -135,7 +135,7 @@
 #define PDM_DMA_INTR_MASK       0x10000
 #define PDM_DEC_64              0x2
 #define PDM_CLK_FREQ_MASK       0x07
-#define PDM_MISC_CTRL_MASK      0x10
+#define PDM_MISC_CTRL_MASK      0x18
 #define PDM_ENABLE              0x01
 #define PDM_DISABLE             0x00
 #define DMA_EN_MASK             0x02
diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index ce2e88e066f3..d773c96e2543 100644
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
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index a792ada18863..461e183680da 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1522,12 +1522,12 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
 {
 	int i;
 
+	if (!umidi->disconnected)
+		snd_usbmidi_disconnect(&umidi->list);
+
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
-		if (ep->out)
-			snd_usbmidi_out_endpoint_delete(ep->out);
-		if (ep->in)
-			snd_usbmidi_in_endpoint_delete(ep->in);
+		kfree(ep->out);
 	}
 	mutex_destroy(&umidi->mutex);
 	kfree(umidi);
@@ -1553,7 +1553,7 @@ void snd_usbmidi_disconnect(struct list_head *p)
 	spin_unlock_irq(&umidi->disc_lock);
 	up_write(&umidi->disc_rwsem);
 
-	del_timer_sync(&umidi->error_timer);
+	timer_shutdown_sync(&umidi->error_timer);
 
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
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

