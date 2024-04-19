Return-Path: <stable+bounces-40259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A19B8AA9E1
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E5CB232AC
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A873A55;
	Fri, 19 Apr 2024 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2rPFJF+2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CFC4E1AD
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514340; cv=none; b=r11t4xpa2PPpEHWzD+Bl/+mWvVL3p8ie5jDF5T+mgdQvwg5c6QfGi1J/fvFPm/90cN1oZ2vHlS5yNtiwaoQgJKWajqg5bZWJG9eLHUbqSz9jnCvnIWYsjtmSnJ7Z0Zmh+0vRnrTmX87X1Dld/sZRl51UAWkT9TFvmdLeWyx9T0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514340; c=relaxed/simple;
	bh=p1XdwJfsE21MtGtcoD4ctHbfB/8+qXVMGCEb1zVBrQs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FFKn7PpD/8nalJkHgSXmZGj1kCYE+TzbYu+BJh8FSS75lbUYXeNPbFRvPe9KTj32h+B1OH3ZzfSsrHBfkDG0fzv4dwA5Wt0qR0BHayRpmNSd/ZppPxlOADjbkA0Gsncvzj2kspMm27na49P5W2kK/cQLR4FFkoW2ZUSQjrVhOH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2rPFJF+2; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-417df7b0265so8978305e9.3
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514337; x=1714119137; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjkNQ5iVSg+OWtUwVEniFrBciNEkP0ZUaHhGpbLm8hw=;
        b=2rPFJF+2F7CP7XY4DzPr1wq+VeFg95b8lmYoZnt7IY60Jvs81oje4do8Tx2dGVhwLW
         A4fVPFn4B+ZQxgVnU+s3kM1Sk6lnSjxgTHTrFopPnTEF+o2sHCcquBwUg6dmawEAC3q9
         NDJ26mtk5QniO6cpl2E1sq5pgmNtEXHD2c8bl8Ol/9T6y3CAu5g0kY3dEwC95WYKNHRJ
         Xg5wvmcDQaKxATASGBXLu894Z4MTzP6Jxhc3lltQljQe243tdpFeQI75JgNN6tcPbrRv
         DD65eCL1VBzssK5op3S94yY0REYNOVLmAeTn4O7sAkRlWcAf91rlNy74txm8u/cQdR2P
         nQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514337; x=1714119137;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjkNQ5iVSg+OWtUwVEniFrBciNEkP0ZUaHhGpbLm8hw=;
        b=UbfUHZJAmBqN4Ws9u1iQbXVHYAlDfs+E4SggEb95uWm9dO4FoB3gHyxVkMxqlaa1sY
         k1n8rf4AsR7EsTjdK4Kawu6Iie4ZikYVFTNa0RkP6QhCl/NPE5aXzr9wGDlTD0sHG/Ah
         8c34BzfeuM4tqPxFxVajo5yfifxXP4ncnDrOAn+8m+KuW7HRZ4l4zYdP5CRB23kzFKJ6
         f1BxSX2pjWltrmkWtmLPPfbTptpTb5jT8iy42B2VTUyBN+QkZsDLdbBzr+WPT/r6+LSm
         aPxfyByPBWC8C2q+3ZkXIakXsoIQflR01kqIXSBox6cyBjkdtkkbvwDmXNr1kV8dazOi
         ysvw==
X-Gm-Message-State: AOJu0YxAvuLSuyPjyvHmWEw7MCT39ID3ourYQQyMD27YmHlgc55g8INl
	mGEJAbL6MT5PPcQJoUkt9Fx73pkX987fMtCVMsvMhqGknfTnaepxIgyp43cohPSVMnVQW3p45s6
	eFRaxcrMhyS2SokGKZD8LQhD1yYSj7gwjTG5I7BrubcdvgYjRfr0/uF83BPS/w+mF5YdijRtlS5
	yIqbuGjYA7+dFMG2CTgNHACg==
X-Google-Smtp-Source: AGHT+IGu+9QZzT9Rbe5eCwjuLK1O77rq3tO3vhq1d/0aD5MdQ4mCKxAEw08/PyWlh4H0gJg+UxZxiWTg
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3b9d:b0:418:ee2f:cacb with SMTP id
 n29-20020a05600c3b9d00b00418ee2fcacbmr9617wms.1.1713514337213; Fri, 19 Apr
 2024 01:12:17 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:29 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4117; i=ardb@kernel.org;
 h=from:subject; bh=NxJ4so8cZ7ODeEPtHXBg7uybazHnAn+PlECJWZAeiug=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXbuK7y2n+rKtx+/xqV5i8bM0mfngrVPZ/MWRrpcZJ
 O4v+Tiro5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkKycjQ8flibx+N86V6ks3
 pgdkRHpe1Cqb+epp08bqoksCCifLlBn+F3PIMyjuLpvOuGX9BC+tp55vDu0OVtx68EmDQvDLbSX VTAA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-48-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 23/23] x86/efistub: Remap kernel text read-only
 before dropping NX attribute
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 9c55461040a9264b7e44444c53d26480b438eda6 upstream ]

Currently, the EFI stub invokes the EFI memory attributes protocol to
strip any NX restrictions from the entire loaded kernel, resulting in
all code and data being mapped read-write-execute.

The point of the EFI memory attributes protocol is to remove the need
for all memory allocations to be mapped with both write and execute
permissions by default, and make it the OS loader's responsibility to
transition data mappings to code mappings where appropriate.

Even though the UEFI specification does not appear to leave room for
denying memory attribute changes based on security policy, let's be
cautious and avoid relying on the ability to create read-write-execute
mappings. This is trivially achievable, given that the amount of kernel
code executing via the firmware's 1:1 mapping is rather small and
limited to the .head.text region. So let's drop the NX restrictions only
on that subregion, but not before remapping it as read-only first.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile       |  2 +-
 arch/x86/boot/compressed/misc.c         |  1 +
 arch/x86/include/asm/boot.h             |  1 +
 drivers/firmware/efi/libstub/x86-stub.c | 11 ++++++++++-
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3965b2c9efee..6e61baff223f 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -84,7 +84,7 @@ LDFLAGS_vmlinux += -T
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
-sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(_text\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
+sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(_text\|__start_rodata\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
 
 quiet_cmd_voffset = VOFFSET $@
       cmd_voffset = $(NM) $< | sed -n $(sed-voffset) > $@
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 8ae7893d712f..45435ff88363 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -330,6 +330,7 @@ static size_t parse_elf(void *output)
 	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
+const unsigned long kernel_text_size = VO___start_rodata - VO__text;
 const unsigned long kernel_total_size = VO__end - VO__text;
 
 static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index a38cc0afc90a..a3e0be0470a4 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -81,6 +81,7 @@
 
 #ifndef __ASSEMBLY__
 extern unsigned int output_len;
+extern const unsigned long kernel_text_size;
 extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 1f5edcb6339a..55468debd55d 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -227,6 +227,15 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 	rounded_end = roundup(start + size, EFI_PAGE_SIZE);
 
 	if (memattr != NULL) {
+		status = efi_call_proto(memattr, set_memory_attributes,
+					rounded_start,
+					rounded_end - rounded_start,
+					EFI_MEMORY_RO);
+		if (status != EFI_SUCCESS) {
+			efi_warn("Failed to set EFI_MEMORY_RO attribute\n");
+			return status;
+		}
+
 		status = efi_call_proto(memattr, clear_memory_attributes,
 					rounded_start,
 					rounded_end - rounded_start,
@@ -778,7 +787,7 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 
 	*kernel_entry = addr + entry;
 
-	return efi_adjust_memory_range_protection(addr, kernel_total_size);
+	return efi_adjust_memory_range_protection(addr, kernel_text_size);
 }
 
 static void __noreturn enter_kernel(unsigned long kernel_addr,
-- 
2.44.0.769.g3c40516874-goog


