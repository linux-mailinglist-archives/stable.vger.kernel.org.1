Return-Path: <stable+bounces-25900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD10E87003A
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 12:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A9B1F23ABF
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 11:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5086839859;
	Mon,  4 Mar 2024 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njz5WTwT"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49AB38DFC
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551238; cv=none; b=M//xvWX2Ziuv4hRjZKMhwAZeSHEoHub0xEGpVCsvbB0qSZPRatzT9XXQ+0ERw84DHnlm2NgasBTmA6Edf3IUY6gZL1EfGjpF7rCgCSPQ5DU057xGOvMdJW5C4cyUcMIeC5Y445tuoSWYmI1HjJWSkbcCbASV5ysE1s6jyboBwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551238; c=relaxed/simple;
	bh=nc3yv9vSe7W8oX9ypNryMk2uuXxCuXX1190k7PyASdo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LVzlv6/OeUQ87wVim6nsagWF+v7HCJXV55KLfrkxQSvmXnYrsNNn9NJtqrK7pYDt7xbQGksulrdSFGMjDtD/dqnKxm884gC9dqgro7QB7Zs+Y637BpsXrjkhTt1hXBj2MZYCbpXkxKVjSNI8ZMJ68LAi3KjQrFI2gooQCuvB2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=njz5WTwT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609a1063919so21206537b3.0
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 03:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551235; x=1710156035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=boAOdLB13m5baTjp0KeGHT68NglbdhYPJKK+DDLhf7I=;
        b=njz5WTwTPirvOv7ny849ilAUr+HvJZRvM6Vq/pUPtQQtaWJbYNxNaq9+1ABEvs3wMA
         +QXeMSpNmfAzY8VD7kNTs1V7LVLG73RP3fIjofr7SD+bY3oVcx5zb7xw8QkvdHEgrWFG
         JqjhRtbeZLZBnbwX64SyF+MUzULD/ZDaD1q1zhW2+bO0Y0JrSK2nSYxHMF4HUyU+cWSX
         XlO+dsUqFXsaTsZerzqvGK82QOcpEJEjuZwM8q94Pz/yMAl6f7SoUw+X3UJwm5OtjAA7
         rCeNiacKKlgG1bM0FctVZLUHXYv2wJy/ad4I6BbjpNUBtMnfFzHV3NKkP8E+jwXuinc6
         MY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551235; x=1710156035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boAOdLB13m5baTjp0KeGHT68NglbdhYPJKK+DDLhf7I=;
        b=SXsojG8ssCHLg1up67k0WgQPa6PDv2iVE4JRAbH6F2G91RW0Mgf5KGDxpABpJAzHiN
         HPUwdwheSzMksJX/SARQLbSgKLWkQ1Lq65wExpe27sPNVMhg8JAbGLRXoMAwDcSFxX1V
         6jMS/jASJXyx4PJHX5MgQY/XMMlbBiRDsGV271aBrTTAli0y7hzArjE5E1H0SXr1sis3
         6BVZvDYvThUqZFRr4soWrsjjpAFZ1Xy/Ig6QKuvTaa9BNj6w5zFXSkcijXrBMecyIxUc
         nR/GbaJRhsaXLPDQDuxxiGb6xk7/iKzw0mheIv/dtNTA6mgj51wfDJ688gNZHolCqwa/
         Rp7w==
X-Gm-Message-State: AOJu0YzZIbMplm4D6mDEJjyqg3qhZ5SduDNMl4q9Sp1IGRr1IFQu+Vil
	lY0wmIU/RIGUNCqUCZEoQc8B+nVMPLnawfvSxt9zy2pjOueJmkInIci2/8iI7sfHgzO0YCj3Igh
	njUEb93NTzFw2yMVF1MQvjBWtIFSw9IOiWlnBirjS9nfw6iwQCUincYv6UXW6jOiA1DoupKKDlN
	QENoiscAqbN5CYB3qF4a2VBg==
X-Google-Smtp-Source: AGHT+IFhBHs0+QiaDmaQQa5r7u0RTJU4CL8YLKUjmhRKvmGUN2IqqWkORsqzlrkv5TrTcnj3B+cqRXlw
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:9949:0:b0:609:2fba:12a0 with SMTP id
 q70-20020a819949000000b006092fba12a0mr2621976ywg.3.1709551234793; Mon, 04 Mar
 2024 03:20:34 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:45 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3758; i=ardb@kernel.org;
 h=from:subject; bh=3td9ZQtrGoE5RQr3hLiRl84FZti+/Le62H16smm2+LM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpukD+vAMub74LHFzqu3OSYWBH4JmSJUcva+4v3L9D9
 mLVArGijlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRR5cYGT5dbd3+jskobOs9
 xy3sTv08HLYdZx59fMXBoR30X/PF1WRGhkMl1oW7Fx+/sjx4/6bcXK7tTvtY2UJsTnXP/ZkyQfp dHB8A
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-27-ardb+git@google.com>
Subject: [PATCH stable-v6.1 07/18] efi/libstub: Add memory attribute protocol definitions
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>, 
	Mario Limonciello <mario.limonciello@amd.com>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Evgeniy Baskov <baskov@ispras.ru>

[ Commit 79729f26b074a5d2722c27fa76cc45ef721e65cd upstream ]

EFI_MEMORY_ATTRIBUTE_PROTOCOL servers as a better alternative to
DXE services for setting memory attributes in EFI Boot Services
environment. This protocol is better since it is a part of UEFI
specification itself and not UEFI PI specification like DXE
services.

Add EFI_MEMORY_ATTRIBUTE_PROTOCOL definitions.
Support mixed mode properly for its calls.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h             |  7 +++++++
 drivers/firmware/efi/libstub/efistub.h | 20 ++++++++++++++++++++
 include/linux/efi.h                    |  1 +
 3 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 233ae6986d6f..522ff2e443b3 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -325,6 +325,13 @@ static inline u32 efi64_convert_status(efi_status_t status)
 #define __efi64_argmap_set_memory_space_attributes(phys, size, flags) \
 	(__efi64_split(phys), __efi64_split(size), __efi64_split(flags))
 
+/* Memory Attribute Protocol */
+#define __efi64_argmap_set_memory_attributes(protocol, phys, size, flags) \
+	((protocol), __efi64_split(phys), __efi64_split(size), __efi64_split(flags))
+
+#define __efi64_argmap_clear_memory_attributes(protocol, phys, size, flags) \
+	((protocol), __efi64_split(phys), __efi64_split(size), __efi64_split(flags))
+
 /*
  * The macros below handle the plumbing for the argument mapping. To add a
  * mapping for a specific EFI method, simply define a macro
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 002f02a6d359..6f5a1a16db15 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -419,6 +419,26 @@ union efi_dxe_services_table {
 	} mixed_mode;
 };
 
+typedef union efi_memory_attribute_protocol efi_memory_attribute_protocol_t;
+
+union efi_memory_attribute_protocol {
+	struct {
+		efi_status_t (__efiapi *get_memory_attributes)(
+			efi_memory_attribute_protocol_t *, efi_physical_addr_t, u64, u64 *);
+
+		efi_status_t (__efiapi *set_memory_attributes)(
+			efi_memory_attribute_protocol_t *, efi_physical_addr_t, u64, u64);
+
+		efi_status_t (__efiapi *clear_memory_attributes)(
+			efi_memory_attribute_protocol_t *, efi_physical_addr_t, u64, u64);
+	};
+	struct {
+		u32 get_memory_attributes;
+		u32 set_memory_attributes;
+		u32 clear_memory_attributes;
+	} mixed_mode;
+};
+
 typedef union efi_uga_draw_protocol efi_uga_draw_protocol_t;
 
 union efi_uga_draw_protocol {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 4e1bfee9675d..de6d6558a4d3 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -390,6 +390,7 @@ void efi_native_runtime_setup(void);
 #define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
 #define EFI_DXE_SERVICES_TABLE_GUID		EFI_GUID(0x05ad34ba, 0x6f02, 0x4214,  0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
 #define EFI_SMBIOS_PROTOCOL_GUID		EFI_GUID(0x03583ff6, 0xcb36, 0x4940,  0x94, 0x7e, 0xb9, 0xb3, 0x9f, 0x4a, 0xfa, 0xf7)
+#define EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID	EFI_GUID(0xf4560cf6, 0x40ec, 0x4b4a,  0xa1, 0x92, 0xbf, 0x1d, 0x57, 0xd0, 0xb1, 0x89)
 
 #define EFI_IMAGE_SECURITY_DATABASE_GUID	EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
 #define EFI_SHIM_LOCK_GUID			EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
-- 
2.44.0.278.ge034bb2e1d-goog


