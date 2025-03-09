Return-Path: <stable+bounces-121633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FACA588BF
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 23:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 584E57A3290
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 22:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DEF19F43A;
	Sun,  9 Mar 2025 22:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bed7+sQ/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17319B5B8
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557833; cv=none; b=PQoctCroUyOuy4k7Sb4kX6G3YtvBuRUCnujTD7qSp1EJk9DmBZN42n6+khNYDq1XSaf6MDCLgb2qyYb3bLEB6VetKUh6iAT+BVt4BM9KkPuwB66bVcyOU5UO1dEZrb048j3xggY6Hy4zOrpT4ISfj3+dEd9xU2BqzfRw0N1Mw0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557833; c=relaxed/simple;
	bh=Q2J+vPBn041RytoPwRn5YnHWs4svGmhBIoBE3fpG8+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TEQznu+d2A4TGQPiI9h72QYhb516pmr2jI+HlWtp8jcZ6m+8B+6beKOICiQnqbqYYAUE3Wn0i2kgp8tXy+QQsFk6xXxbJj1LEP+e4/PkfLT6KE000yAw0v8V+/D1yms+KSkDq2/EZCFXKid7p8Y3WRYD2iquVh0EJEIQessCUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bed7+sQ/; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3913f546dfbso699208f8f.1
        for <stable@vger.kernel.org>; Sun, 09 Mar 2025 15:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741557829; x=1742162629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=92yWzmGaxBvvO9z6MfRRfuk2DdoO0npYcRF/HiGU4g4=;
        b=bed7+sQ/wV0NQxxw7xukB4unPho3YqPCLYTzYZVy+ybj6fk3V2HWJmkRnCR8kwrdEp
         ht6IXUDI2WaT4Xsqp4+yD4bE5NHFgD1A1MZpZ5H80eb4GEnA47LfSBzz14ZTsdCOeufx
         BLnnhFi83+S3msysShApv+TCqrGVsFDvqg+KHm4VREZgotpcl3a7cKO1hjLcmr49b0Sr
         s5xraZNhr1OsgPHn1SJYm1VVnzUPQ/Mf99j19OwgS6ANFD5Gi73eGeEz9htiUrKvGciK
         tgeWGJa9agAyTH4gWXkMCqbPC9UijjHXRJCNbdPnOueA2qZeybyUIwLty6S00E17Bawe
         VpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741557829; x=1742162629;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92yWzmGaxBvvO9z6MfRRfuk2DdoO0npYcRF/HiGU4g4=;
        b=b4YdSnKd1EPqmaM470FX4eeVENkr8y7e75bcPajicys8ZXOt6YXhTVpcZtNjMMH2Om
         NSug0DCcsNv6keHikwLu3h2wUayc446q/dKYg58sKAGCCGmaoMg293bzh5C9tPsNjexs
         kDlRFHye4epYNQTXtI/IUjMv55afbhR/wmjNhA7DRThVf8XSshqJx0s8TaUKoEcx97y6
         XRtMdbS+6bc89yRzul6mAUGtZoBisflivnepcmgX3WVd5v0w79cvcOuGsbzSJCplaozz
         vO7xgxDxhRqCRwS+cWeXxBTt3AfC06YAvvpbm4HR+Fi/WWHuhsarpden5rJW2yyu9+fr
         3nAg==
X-Gm-Message-State: AOJu0Yzp82Us2NgYWA3OhUCjHpEX3TgPStRZN22VLlL2o4zhomGwH6qX
	Qd2q9LdkZD/C/2h3Gmq3WVC+5yTRexyxZ5uuCQ+rVdfSe+mgvn7UcnsEYPazyjmEMP8mxNTKvV3
	uVNOR4eq57O7Vw1WmyjPJgtiJVOQD476A8Xjy9syWFEkPeB8k318OIwcIXZLI5JN85O7ndlMexY
	v6TwyhNpF4YO9y4UF0YgbkBw==
X-Google-Smtp-Source: AGHT+IEY06PBuXF2WzYNvecHbrFfFhTF4ib55O8Oao59kMNjfX5sn+Sn04VTUFPPi2HQ7K613lvzK2qV
X-Received: from wmbhc25.prod.google.com ([2002:a05:600c:8719:b0:43b:d212:f974])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2cb:b0:391:306f:57de
 with SMTP id ffacd0b85a97d-39132db1ac3mr9751061f8f.45.1741557829724; Sun, 09
 Mar 2025 15:03:49 -0700 (PDT)
Date: Sun,  9 Mar 2025 23:03:19 +0100
In-Reply-To: <20250309220320.1876084-1-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250309220320.1876084-1-ardb+git@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250309220320.1876084-2-ardb+git@google.com>
Subject: [PATCH for-stable-6.x 1/2] x86/boot: Rename conflicting 'boot_params'
 pointer to 'boot_params_ptr'
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

commit d55d5bc5d937743aa8ebb7ca3af25111053b5d8c upstream.

The x86 decompressor is built and linked as a separate executable, but
it shares components with the kernel proper, which are either #include'd
as C files, or linked into the decompresor as a static library (e.g, the
EFI stub)

Both the kernel itself and the decompressor define a global symbol
'boot_params' to refer to the boot_params struct, but in the former
case, it refers to the struct directly, whereas in the decompressor, it
refers to a global pointer variable referring to the struct boot_params
passed by the bootloader or constructed from scratch.

This ambiguity is unfortunate, and makes it impossible to assign this
decompressor variable from the x86 EFI stub, given that declaring it as
extern results in a clash. So rename the decompressor version (whose
scope is limited) to boot_params_ptr.

[ mingo: Renamed 'boot_params_p' to 'boot_params_ptr' for clarity ]

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
[ardb: include references to boot_params in x86-stub.[ch]]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/acpi.c         | 14 +++++------
 arch/x86/boot/compressed/cmdline.c      |  4 +--
 arch/x86/boot/compressed/ident_map_64.c |  7 +++---
 arch/x86/boot/compressed/kaslr.c        | 26 ++++++++++----------
 arch/x86/boot/compressed/mem.c          |  6 ++---
 arch/x86/boot/compressed/misc.c         | 26 ++++++++++----------
 arch/x86/boot/compressed/misc.h         |  1 -
 arch/x86/boot/compressed/pgtable_64.c   |  9 +++----
 arch/x86/boot/compressed/sev.c          |  2 +-
 arch/x86/include/asm/boot.h             |  2 ++
 drivers/firmware/efi/libstub/x86-stub.c |  2 +-
 drivers/firmware/efi/libstub/x86-stub.h |  2 --
 12 files changed, 50 insertions(+), 51 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 9caf89063e77..55c98fdd67d2 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -30,13 +30,13 @@ __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
 	 * Search EFI system tables for RSDP. Preferred is ACPI_20_TABLE_GUID to
 	 * ACPI_TABLE_GUID because it has more features.
 	 */
-	rsdp_addr = efi_find_vendor_table(boot_params, cfg_tbl_pa, cfg_tbl_len,
+	rsdp_addr = efi_find_vendor_table(boot_params_ptr, cfg_tbl_pa, cfg_tbl_len,
 					  ACPI_20_TABLE_GUID);
 	if (rsdp_addr)
 		return (acpi_physical_address)rsdp_addr;
 
 	/* No ACPI_20_TABLE_GUID found, fallback to ACPI_TABLE_GUID. */
-	rsdp_addr = efi_find_vendor_table(boot_params, cfg_tbl_pa, cfg_tbl_len,
+	rsdp_addr = efi_find_vendor_table(boot_params_ptr, cfg_tbl_pa, cfg_tbl_len,
 					  ACPI_TABLE_GUID);
 	if (rsdp_addr)
 		return (acpi_physical_address)rsdp_addr;
@@ -56,15 +56,15 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	enum efi_type et;
 	int ret;
 
-	et = efi_get_type(boot_params);
+	et = efi_get_type(boot_params_ptr);
 	if (et == EFI_TYPE_NONE)
 		return 0;
 
-	systab_pa = efi_get_system_table(boot_params);
+	systab_pa = efi_get_system_table(boot_params_ptr);
 	if (!systab_pa)
 		error("EFI support advertised, but unable to locate system table.");
 
-	ret = efi_get_conf_table(boot_params, &cfg_tbl_pa, &cfg_tbl_len);
+	ret = efi_get_conf_table(boot_params_ptr, &cfg_tbl_pa, &cfg_tbl_len);
 	if (ret || !cfg_tbl_pa)
 		error("EFI config table not found.");
 
@@ -156,7 +156,7 @@ acpi_physical_address get_rsdp_addr(void)
 {
 	acpi_physical_address pa;
 
-	pa = boot_params->acpi_rsdp_addr;
+	pa = boot_params_ptr->acpi_rsdp_addr;
 
 	if (!pa)
 		pa = efi_get_rsdp_addr();
@@ -210,7 +210,7 @@ static unsigned long get_acpi_srat_table(void)
 	rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();
 	if (!rsdp)
 		rsdp = (struct acpi_table_rsdp *)(long)
-			boot_params->acpi_rsdp_addr;
+			boot_params_ptr->acpi_rsdp_addr;
 
 	if (!rsdp)
 		return 0;
diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index f1add5d85da9..c1bb180973ea 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -14,9 +14,9 @@ static inline char rdfs8(addr_t addr)
 #include "../cmdline.c"
 unsigned long get_cmd_line_ptr(void)
 {
-	unsigned long cmd_line_ptr = boot_params->hdr.cmd_line_ptr;
+	unsigned long cmd_line_ptr = boot_params_ptr->hdr.cmd_line_ptr;
 
-	cmd_line_ptr |= (u64)boot_params->ext_cmd_line_ptr << 32;
+	cmd_line_ptr |= (u64)boot_params_ptr->ext_cmd_line_ptr << 32;
 
 	return cmd_line_ptr;
 }
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index aead80ec70a0..d040080d7edb 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -159,8 +159,9 @@ void initialize_identity_maps(void *rmode)
 	 * or does not touch all the pages covering them.
 	 */
 	kernel_add_identity_map((unsigned long)_head, (unsigned long)_end);
-	boot_params = rmode;
-	kernel_add_identity_map((unsigned long)boot_params, (unsigned long)(boot_params + 1));
+	boot_params_ptr = rmode;
+	kernel_add_identity_map((unsigned long)boot_params_ptr,
+				(unsigned long)(boot_params_ptr + 1));
 	cmdline = get_cmd_line_ptr();
 	kernel_add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
@@ -168,7 +169,7 @@ void initialize_identity_maps(void *rmode)
 	 * Also map the setup_data entries passed via boot_params in case they
 	 * need to be accessed by uncompressed kernel via the identity mapping.
 	 */
-	sd = (struct setup_data *)boot_params->hdr.setup_data;
+	sd = (struct setup_data *)boot_params_ptr->hdr.setup_data;
 	while (sd) {
 		unsigned long sd_addr = (unsigned long)sd;
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 9193acf0e9cd..dec961c6d16a 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -63,7 +63,7 @@ static unsigned long get_boot_seed(void)
 	unsigned long hash = 0;
 
 	hash = rotate_xor(hash, build_str, sizeof(build_str));
-	hash = rotate_xor(hash, boot_params, sizeof(*boot_params));
+	hash = rotate_xor(hash, boot_params_ptr, sizeof(*boot_params_ptr));
 
 	return hash;
 }
@@ -383,7 +383,7 @@ static void handle_mem_options(void)
 static void mem_avoid_init(unsigned long input, unsigned long input_size,
 			   unsigned long output)
 {
-	unsigned long init_size = boot_params->hdr.init_size;
+	unsigned long init_size = boot_params_ptr->hdr.init_size;
 	u64 initrd_start, initrd_size;
 	unsigned long cmd_line, cmd_line_size;
 
@@ -395,10 +395,10 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	mem_avoid[MEM_AVOID_ZO_RANGE].size = (output + init_size) - input;
 
 	/* Avoid initrd. */
-	initrd_start  = (u64)boot_params->ext_ramdisk_image << 32;
-	initrd_start |= boot_params->hdr.ramdisk_image;
-	initrd_size  = (u64)boot_params->ext_ramdisk_size << 32;
-	initrd_size |= boot_params->hdr.ramdisk_size;
+	initrd_start  = (u64)boot_params_ptr->ext_ramdisk_image << 32;
+	initrd_start |= boot_params_ptr->hdr.ramdisk_image;
+	initrd_size  = (u64)boot_params_ptr->ext_ramdisk_size << 32;
+	initrd_size |= boot_params_ptr->hdr.ramdisk_size;
 	mem_avoid[MEM_AVOID_INITRD].start = initrd_start;
 	mem_avoid[MEM_AVOID_INITRD].size = initrd_size;
 	/* No need to set mapping for initrd, it will be handled in VO. */
@@ -413,8 +413,8 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	}
 
 	/* Avoid boot parameters. */
-	mem_avoid[MEM_AVOID_BOOTPARAMS].start = (unsigned long)boot_params;
-	mem_avoid[MEM_AVOID_BOOTPARAMS].size = sizeof(*boot_params);
+	mem_avoid[MEM_AVOID_BOOTPARAMS].start = (unsigned long)boot_params_ptr;
+	mem_avoid[MEM_AVOID_BOOTPARAMS].size = sizeof(*boot_params_ptr);
 
 	/* We don't need to set a mapping for setup_data. */
 
@@ -447,7 +447,7 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 	}
 
 	/* Avoid all entries in the setup_data linked list. */
-	ptr = (struct setup_data *)(unsigned long)boot_params->hdr.setup_data;
+	ptr = (struct setup_data *)(unsigned long)boot_params_ptr->hdr.setup_data;
 	while (ptr) {
 		struct mem_vector avoid;
 
@@ -706,7 +706,7 @@ static inline bool memory_type_is_free(efi_memory_desc_t *md)
 static bool
 process_efi_entries(unsigned long minimum, unsigned long image_size)
 {
-	struct efi_info *e = &boot_params->efi_info;
+	struct efi_info *e = &boot_params_ptr->efi_info;
 	bool efi_mirror_found = false;
 	struct mem_vector region;
 	efi_memory_desc_t *md;
@@ -777,8 +777,8 @@ static void process_e820_entries(unsigned long minimum,
 	struct boot_e820_entry *entry;
 
 	/* Verify potential e820 positions, appending to slots list. */
-	for (i = 0; i < boot_params->e820_entries; i++) {
-		entry = &boot_params->e820_table[i];
+	for (i = 0; i < boot_params_ptr->e820_entries; i++) {
+		entry = &boot_params_ptr->e820_table[i];
 		/* Skip non-RAM entries. */
 		if (entry->type != E820_TYPE_RAM)
 			continue;
@@ -852,7 +852,7 @@ void choose_random_location(unsigned long input,
 		return;
 	}
 
-	boot_params->hdr.loadflags |= KASLR_FLAG;
+	boot_params_ptr->hdr.loadflags |= KASLR_FLAG;
 
 	if (IS_ENABLED(CONFIG_X86_32))
 		mem_limit = KERNEL_IMAGE_SIZE;
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index 3c1609245f2a..b3c3a4be7471 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -54,17 +54,17 @@ bool init_unaccepted_memory(void)
 	enum efi_type et;
 	int ret;
 
-	et = efi_get_type(boot_params);
+	et = efi_get_type(boot_params_ptr);
 	if (et == EFI_TYPE_NONE)
 		return false;
 
-	ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
+	ret = efi_get_conf_table(boot_params_ptr, &cfg_table_pa, &cfg_table_len);
 	if (ret) {
 		warn("EFI config table not found.");
 		return false;
 	}
 
-	table = (void *)efi_find_vendor_table(boot_params, cfg_table_pa,
+	table = (void *)efi_find_vendor_table(boot_params_ptr, cfg_table_pa,
 					      cfg_table_len, guid);
 	if (!table)
 		return false;
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b5ecbd32a46f..ee0fac468e7f 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -46,7 +46,7 @@ void *memmove(void *dest, const void *src, size_t n);
 /*
  * This is set up by the setup-routine at boot-time
  */
-struct boot_params *boot_params;
+struct boot_params *boot_params_ptr;
 
 struct port_io_ops pio_ops;
 
@@ -132,8 +132,8 @@ void __putstr(const char *s)
 	if (lines == 0 || cols == 0)
 		return;
 
-	x = boot_params->screen_info.orig_x;
-	y = boot_params->screen_info.orig_y;
+	x = boot_params_ptr->screen_info.orig_x;
+	y = boot_params_ptr->screen_info.orig_y;
 
 	while ((c = *s++) != '\0') {
 		if (c == '\n') {
@@ -154,8 +154,8 @@ void __putstr(const char *s)
 		}
 	}
 
-	boot_params->screen_info.orig_x = x;
-	boot_params->screen_info.orig_y = y;
+	boot_params_ptr->screen_info.orig_x = x;
+	boot_params_ptr->screen_info.orig_y = y;
 
 	pos = (x + cols * y) * 2;	/* Update cursor position */
 	outb(14, vidport);
@@ -396,16 +396,16 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	size_t entry_offset;
 
 	/* Retain x86 boot parameters pointer passed from startup_32/64. */
-	boot_params = rmode;
+	boot_params_ptr = rmode;
 
 	/* Clear flags intended for solely in-kernel use. */
-	boot_params->hdr.loadflags &= ~KASLR_FLAG;
+	boot_params_ptr->hdr.loadflags &= ~KASLR_FLAG;
 
-	parse_mem_encrypt(&boot_params->hdr);
+	parse_mem_encrypt(&boot_params_ptr->hdr);
 
-	sanitize_boot_params(boot_params);
+	sanitize_boot_params(boot_params_ptr);
 
-	if (boot_params->screen_info.orig_video_mode == 7) {
+	if (boot_params_ptr->screen_info.orig_video_mode == 7) {
 		vidmem = (char *) 0xb0000;
 		vidport = 0x3b4;
 	} else {
@@ -413,8 +413,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 		vidport = 0x3d4;
 	}
 
-	lines = boot_params->screen_info.orig_video_lines;
-	cols = boot_params->screen_info.orig_video_cols;
+	lines = boot_params_ptr->screen_info.orig_video_lines;
+	cols = boot_params_ptr->screen_info.orig_video_cols;
 
 	init_default_io_ops();
 
@@ -433,7 +433,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	 * so that early debugging output from the RSDP parsing code can be
 	 * collected.
 	 */
-	boot_params->acpi_rsdp_addr = get_rsdp_addr();
+	boot_params_ptr->acpi_rsdp_addr = get_rsdp_addr();
 
 	debug_putstr("early console in extract_kernel\n");
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index aae1a2db4251..bc2f0f17fb90 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -61,7 +61,6 @@ extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
 void *malloc(int size);
 void free(void *where);
-extern struct boot_params *boot_params;
 void __putstr(const char *s);
 void __puthex(unsigned long value);
 #define error_putstr(__x)  __putstr(__x)
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 7939eb6e6ce9..51f957b24ba7 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -28,7 +28,6 @@ static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
  */
 unsigned long *trampoline_32bit __section(".data");
 
-extern struct boot_params *boot_params;
 int cmdline_find_option_bool(const char *option);
 
 static unsigned long find_trampoline_placement(void)
@@ -49,7 +48,7 @@ static unsigned long find_trampoline_placement(void)
 	 *
 	 * Only look for values in the legacy ROM for non-EFI system.
 	 */
-	signature = (char *)&boot_params->efi_info.efi_loader_signature;
+	signature = (char *)&boot_params_ptr->efi_info.efi_loader_signature;
 	if (strncmp(signature, EFI32_LOADER_SIGNATURE, 4) &&
 	    strncmp(signature, EFI64_LOADER_SIGNATURE, 4)) {
 		ebda_start = *(unsigned short *)0x40e << 4;
@@ -65,10 +64,10 @@ static unsigned long find_trampoline_placement(void)
 	bios_start = round_down(bios_start, PAGE_SIZE);
 
 	/* Find the first usable memory region under bios_start. */
-	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
+	for (i = boot_params_ptr->e820_entries - 1; i >= 0; i--) {
 		unsigned long new = bios_start;
 
-		entry = &boot_params->e820_table[i];
+		entry = &boot_params_ptr->e820_table[i];
 
 		/* Skip all entries above bios_start. */
 		if (bios_start <= entry->addr)
@@ -107,7 +106,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
-	boot_params = bp;
+	boot_params_ptr = bp;
 
 	/*
 	 * Check if LA57 is desired and supported.
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 0a49218a516a..01d61f0609ab 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -618,7 +618,7 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
 	 * accessed after switchover.
 	 */
 	if (sev_snp_enabled()) {
-		unsigned long cc_info_pa = boot_params->cc_blob_address;
+		unsigned long cc_info_pa = boot_params_ptr->cc_blob_address;
 		struct cc_blob_sev_info *cc_info;
 
 		kernel_add_identity_map(cc_info_pa, cc_info_pa + sizeof(*cc_info));
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index c945c893c52e..a3e0be0470a4 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -86,6 +86,8 @@ extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 				void (*error)(char *x));
+
+extern struct boot_params *boot_params_ptr;
 #endif
 
 #endif /* _ASM_X86_BOOT_H */
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index b2b06d18b7b4..7bea03963b28 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -883,7 +883,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	unsigned long kernel_entry;
 	efi_status_t status;
 
-	boot_params_pointer = boot_params;
+	boot_params_ptr = boot_params;
 
 	efi_system_table = sys_table_arg;
 	/* Check if we were booted by the EFI firmware */
diff --git a/drivers/firmware/efi/libstub/x86-stub.h b/drivers/firmware/efi/libstub/x86-stub.h
index 4433d0f97441..1c20e99a6494 100644
--- a/drivers/firmware/efi/libstub/x86-stub.h
+++ b/drivers/firmware/efi/libstub/x86-stub.h
@@ -2,8 +2,6 @@
 
 #include <linux/efi.h>
 
-extern struct boot_params *boot_params_pointer asm("boot_params");
-
 extern void trampoline_32bit_src(void *, bool);
 extern const u16 trampoline_ljmp_imm_offset;
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


