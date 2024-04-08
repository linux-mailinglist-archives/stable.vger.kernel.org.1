Return-Path: <stable+bounces-36316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A80789B7F5
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 08:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EFD282D7C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 06:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F277F224C9;
	Mon,  8 Apr 2024 06:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUNnR6Aa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206C121364
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558994; cv=none; b=Trto0dYOEpJhBe30W7O4tfZzHw1amQjzDm4XEcQRExqAhW6dYkmcZB+7M7kaDqx/dtuwz/f3DX/R2Qdm78IiNrfUZ1vGhnM/uRYoBVM1NAhpXTUMwWfK8zJ4pbBitVmKMD+dhNty7vN/6Heg64SQcGgPXaFkqqtVIaA/BPT0YQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558994; c=relaxed/simple;
	bh=DFpknI8P6wWPxDwus1dAOqUHJZ4dSYAdM/1vsg1WkvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q9LSk5bSkjI4bsKO49LXCc8IgdMVbElSq+tcu4L9kRXdnURrQI6Tg/c+jokpnaMMlRWrSYKvb9LIRRrNpSf6oJckEeg6DHF1qzwgDYp50fQAkDJNH3JuKeq0wnNJlQW6qKVFq39pWkiAlsz5etukuA/UcaoPxh7sVyJfyVD0riE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUNnR6Aa; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-343e00c8979so1807871f8f.1
        for <stable@vger.kernel.org>; Sun, 07 Apr 2024 23:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712558991; x=1713163791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VrLPVbHoM+VBLfPMVNOnBVQudNNB00ZVI6qS9WAg3MQ=;
        b=sUNnR6AaVbRsWtST6HbpqBIXjATNq9neG6Izd0YdAvbSI90xUvkO94/mY/M2brBpSd
         ZlDqYxlPcYy+yVBux67NOJAHYcFpZRtFS69QQb1jRaFeyd5PKdG23JGKHK1IWCod989Y
         xqxVUzeWqu2wNMcn4SBfILx61i1/HOX+yKM+nOsrjM+7NGiJt2rS2UcYG4FPmsOcOkev
         r9T2bG76+LzBi4W1Qyn5S5EY8F5LluKo2KyNSE2k6rBJtkHFRzExupsWlJDz5i2pr3Y0
         sgu0akQOgmB8OeSMgGEOrumrXsOp/xl+At86PwtyVnGtvLL59LHBssFoCA66HBtFGpda
         BumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558991; x=1713163791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VrLPVbHoM+VBLfPMVNOnBVQudNNB00ZVI6qS9WAg3MQ=;
        b=rd9nwc31Dk21c9UCkmBDTdbWhynTjL5ygWk4S1v9pmXIAg6lgoe2ehZpLt9QjK3RmI
         kNhw+/vIYowWjAwlaKOa8JlYw2XUBRwqF2FnBdop4rFzG3b2k3Lr1fWvsMUPhPHxanoo
         T2aW3hgyeHXHJtljDSRAFwtMgTL8h/GX7ML34sFbKMRCLF+gkw2z+rhcRjmYE4wRWvLI
         DN5xyiCOEciBeXSryvC3yHe+52wwz8NYNXD0eL+/W2sUTZ8FOPlxLiG8yF/lb4sbBYhR
         v5ebzqHMf8kQE2jaxFSRNU3DTT70QMuM0Fq+xqtjNFvFbgU5OsQTxfmsL+cRYy+To4Bb
         IO1Q==
X-Gm-Message-State: AOJu0YwA9ZdyBA9NBYwyjYMVC3bnERKMsWC6Xlywa7qp40/Q3FgWYSQB
	ae05a/3gR2/CxXKER1BmWRH3hmsFF4F1H2+Nyj50K6MiQL+Q8xOgHinu62sWQbaCrqCK8lnQdcL
	ObuQ0xvbUjTm5g6W5KdWeJLzm+GoYHgxLF9bgMx1VkYSA+NxdSlgI9ohLnxjUiwo+6qRJpt4reE
	o5LJ6istqhAHXEb6tq7EjzlQ==
X-Google-Smtp-Source: AGHT+IGdKjUHd7C+NdzcoDuuqcpyNTpQvgJjfNM/S8N56gEAb3hywARHZKrFbrDd+yzxsd26TYtdOdET
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3b93:b0:416:69ef:f6cc with SMTP id
 n19-20020a05600c3b9300b0041669eff6ccmr7093wms.3.1712558991651; Sun, 07 Apr
 2024 23:49:51 -0700 (PDT)
Date: Mon,  8 Apr 2024 08:49:24 +0200
In-Reply-To: <20240408064917.3391405-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408064917.3391405-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4117; i=ardb@kernel.org;
 h=from:subject; bh=c0Q+Hb45AwWQCvN7Z/7jbhQ+tWND6aqiJBeUpgXOYi0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU14cknwtsSlGudX/We5G3Zq+cJl1R8nXMm6qyC7ucnO0
 DN4Zbl2RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiIrxbDX0nz+mVmh35PeyL/
 YNrLLVkdfq8lTQ2fVMypsj4tczDo/XVGhg0bbWx3bdvd2H+uS4fx43KLN8k3Lpo9rlvAcH7V7ow 2R14A
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408064917.3391405-14-ardb+git@google.com>
Subject: [PATCH -for-stable-v6.6+ 6/6] x86/efistub: Remap kernel text
 read-only before dropping NX attribute
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
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
index 71fc531b95b4..583c11664c63 100644
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
index c6136a1be283..b5ecbd32a46f 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -330,6 +330,7 @@ static size_t parse_elf(void *output)
 	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
+const unsigned long kernel_text_size = VO___start_rodata - VO__text;
 const unsigned long kernel_total_size = VO__end - VO__text;
 
 static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index b3a7cfb0d99e..c945c893c52e 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -81,6 +81,7 @@
 
 #ifndef __ASSEMBLY__
 extern unsigned int output_len;
+extern const unsigned long kernel_text_size;
 extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 6224f5c40532..e4ae3db727ef 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -238,6 +238,15 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
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
@@ -816,7 +825,7 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 
 	*kernel_entry = addr + entry;
 
-	return efi_adjust_memory_range_protection(addr, kernel_total_size);
+	return efi_adjust_memory_range_protection(addr, kernel_text_size);
 }
 
 static void __noreturn enter_kernel(unsigned long kernel_addr,
-- 
2.44.0.478.gd926399ef9-goog


