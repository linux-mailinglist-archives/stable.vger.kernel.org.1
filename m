Return-Path: <stable+bounces-124237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 403FDA5EED6
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14CA7A9047
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AB6265632;
	Thu, 13 Mar 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBxkMlgO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFCE263F34
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856502; cv=none; b=TBnsXvnHiyLnX6Xi9nBi0wq3AIC6I8Vgwd0fc039MDmUdtusKrIqeZSS1pqqk6MW0LOyOONFY0XCLQY1POYxwROn/WZ1M3rYmJOBSuYgOSEEebuXT9Xrs7QXy+3fT9cZaVO2SC1hBZRneRZTCY6Lk/qW8l7B15ASq94P6VsPGcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856502; c=relaxed/simple;
	bh=VJAyTo2d0Spz07f+H8siY3RM076CTYbImha9pUMSpeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fb3a3+pS8EJZpVfMTNv8dEEnoj7nXO2z4wTxQ6IUP0N0zWbN1Dhl4m+RLJp0AdE1JRXrsVZ+csTTAPu9ls7dT98tl52O57X0kfoQgQO1zSaPdUSxSc8pjabNgYgftv6MBlAFkMo5Yj35tVkh2BU27p3aoIwNTHzBrrSlj+ICWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBxkMlgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BABC4CEDD;
	Thu, 13 Mar 2025 09:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856501;
	bh=VJAyTo2d0Spz07f+H8siY3RM076CTYbImha9pUMSpeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VBxkMlgOHWv46q1QyDwpXJybrcIVxIMeQmQDkbi/FxkxKAomddTpv9ZvyodnOSPTx
	 /jNXo+UzQt3prJwqN/IkR4mMav58SvbKRLTPUs1jGMUwbsxCGJz97Dve8gH/DpEtLS
	 +ISAji1UDecTTzyvx/HC3h828OzDsswUKSY5aQUEvzIhqshwqZvqCdel159Fya0zBV
	 sAvifsSBnqxih48HN2LRP7B3w/H+9HyLozes493JWaNd8aHf/wTOjGsKcSeqBQgDu4
	 bTm4pk7VsK+zUv8xGnqvLYWVE102hXVoHewxol5q4/1BG/B7NBeuf1PvzE2SNxCjgD
	 8dnSbkngp/BCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ardb+git@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH for-stable-6.x 1/2] x86/boot: Rename conflicting 'boot_params' pointer to 'boot_params_ptr'
Date: Thu, 13 Mar 2025 05:01:39 -0400
Message-Id: <20250312232815-56061b85bb310b1d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250309220320.1876084-2-ardb+git@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Build failures detected

The upstream commit SHA1 provided is correct: d55d5bc5d937743aa8ebb7ca3af25111053b5d8c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Ard Biesheuvel<ardb+git@google.com>
Commit author: Ard Biesheuvel<ardb@kernel.org>

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Failed     |  N/A       |
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-6.13.y. Reject:

diff a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h	(rejected hunks)
@@ -86,6 +86,8 @@ extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 				void (*error)(char *x));
+
+extern struct boot_params *boot_params_ptr;
 #endif
 
 #endif /* _ASM_X86_BOOT_H */
diff a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c	(rejected hunks)
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
diff a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c	(rejected hunks)
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
diff a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c	(rejected hunks)
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
 
diff a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c	(rejected hunks)
@@ -618,7 +618,7 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
 	 * accessed after switchover.
 	 */
 	if (sev_snp_enabled()) {
-		unsigned long cc_info_pa = boot_params->cc_blob_address;
+		unsigned long cc_info_pa = boot_params_ptr->cc_blob_address;
 		struct cc_blob_sev_info *cc_info;
 
 		kernel_add_identity_map(cc_info_pa, cc_info_pa + sizeof(*cc_info));
diff a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c	(rejected hunks)
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
diff a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c	(rejected hunks)
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
diff a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h	(rejected hunks)
@@ -61,7 +61,6 @@ extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
 void *malloc(int size);
 void free(void *where);
-extern struct boot_params *boot_params;
 void __putstr(const char *s);
 void __puthex(unsigned long value);
 #define error_putstr(__x)  __putstr(__x)
diff a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c	(rejected hunks)
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
 
diff a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c	(rejected hunks)
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
diff a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c	(rejected hunks)
@@ -883,7 +883,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	unsigned long kernel_entry;
 	efi_status_t status;
 
-	boot_params_pointer = boot_params;
+	boot_params_ptr = boot_params;
 
 	efi_system_table = sys_table_arg;
 	/* Check if we were booted by the EFI firmware */
diff a/drivers/firmware/efi/libstub/x86-stub.h b/drivers/firmware/efi/libstub/x86-stub.h	(rejected hunks)
@@ -2,8 +2,6 @@
 
 #include <linux/efi.h>
 
-extern struct boot_params *boot_params_pointer asm("boot_params");
-
 extern void trampoline_32bit_src(void *, bool);
 extern const u16 trampoline_ljmp_imm_offset;
 
Patch failed to apply on stable/linux-6.12.y. Reject:

diff a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h	(rejected hunks)
@@ -86,6 +86,8 @@ extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 				void (*error)(char *x));
+
+extern struct boot_params *boot_params_ptr;
 #endif
 
 #endif /* _ASM_X86_BOOT_H */
diff a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c	(rejected hunks)
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
diff a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c	(rejected hunks)
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
diff a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c	(rejected hunks)
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
 
diff a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c	(rejected hunks)
@@ -618,7 +618,7 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
 	 * accessed after switchover.
 	 */
 	if (sev_snp_enabled()) {
-		unsigned long cc_info_pa = boot_params->cc_blob_address;
+		unsigned long cc_info_pa = boot_params_ptr->cc_blob_address;
 		struct cc_blob_sev_info *cc_info;
 
 		kernel_add_identity_map(cc_info_pa, cc_info_pa + sizeof(*cc_info));
diff a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c	(rejected hunks)
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
diff a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c	(rejected hunks)
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
diff a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h	(rejected hunks)
@@ -61,7 +61,6 @@ extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
 void *malloc(int size);
 void free(void *where);
-extern struct boot_params *boot_params;
 void __putstr(const char *s);
 void __puthex(unsigned long value);
 #define error_putstr(__x)  __putstr(__x)
diff a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c	(rejected hunks)
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
 
diff a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c	(rejected hunks)
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
diff a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c	(rejected hunks)
@@ -883,7 +883,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	unsigned long kernel_entry;
 	efi_status_t status;
 
-	boot_params_pointer = boot_params;
+	boot_params_ptr = boot_params;
 
 	efi_system_table = sys_table_arg;
 	/* Check if we were booted by the EFI firmware */
diff a/drivers/firmware/efi/libstub/x86-stub.h b/drivers/firmware/efi/libstub/x86-stub.h	(rejected hunks)
@@ -2,8 +2,6 @@
 
 #include <linux/efi.h>
 
-extern struct boot_params *boot_params_pointer asm("boot_params");
-
 extern void trampoline_32bit_src(void *, bool);
 extern const u16 trampoline_ljmp_imm_offset;
 
Patch failed to apply on stable/linux-6.1.y. Reject:

diff a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h	(rejected hunks)
@@ -86,6 +86,8 @@ extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 				void (*error)(char *x));
+
+extern struct boot_params *boot_params_ptr;
 #endif
 
 #endif /* _ASM_X86_BOOT_H */
diff a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c	(rejected hunks)
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
diff a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c	(rejected hunks)
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
diff a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c	(rejected hunks)
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
 
diff a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c	(rejected hunks)
@@ -618,7 +618,7 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
 	 * accessed after switchover.
 	 */
 	if (sev_snp_enabled()) {
-		unsigned long cc_info_pa = boot_params->cc_blob_address;
+		unsigned long cc_info_pa = boot_params_ptr->cc_blob_address;
 		struct cc_blob_sev_info *cc_info;
 
 		kernel_add_identity_map(cc_info_pa, cc_info_pa + sizeof(*cc_info));
diff a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c	(rejected hunks)
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
diff a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c	(rejected hunks)
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
diff a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h	(rejected hunks)
@@ -61,7 +61,6 @@ extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
 void *malloc(int size);
 void free(void *where);
-extern struct boot_params *boot_params;
 void __putstr(const char *s);
 void __puthex(unsigned long value);
 #define error_putstr(__x)  __putstr(__x)
diff a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c	(rejected hunks)
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
 
diff a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c	(rejected hunks)
@@ -883,7 +883,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	unsigned long kernel_entry;
 	efi_status_t status;
 
-	boot_params_pointer = boot_params;
+	boot_params_ptr = boot_params;
 
 	efi_system_table = sys_table_arg;
 	/* Check if we were booted by the EFI firmware */
diff a/drivers/firmware/efi/libstub/x86-stub.h b/drivers/firmware/efi/libstub/x86-stub.h	(rejected hunks)
@@ -2,8 +2,6 @@
 
 #include <linux/efi.h>
 
-extern struct boot_params *boot_params_pointer asm("boot_params");
-
 extern void trampoline_32bit_src(void *, bool);
 extern const u16 trampoline_ljmp_imm_offset;
 
Patch failed to apply on stable/linux-5.15.y. Reject:

diff a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h	(rejected hunks)
@@ -86,6 +86,8 @@ extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 				void (*error)(char *x));
+
+extern struct boot_params *boot_params_ptr;
 #endif
 
 #endif /* _ASM_X86_BOOT_H */
diff a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c	(rejected hunks)
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
diff a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c	(rejected hunks)
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
 
diff a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c	(rejected hunks)
@@ -618,7 +618,7 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
 	 * accessed after switchover.
 	 */
 	if (sev_snp_enabled()) {
-		unsigned long cc_info_pa = boot_params->cc_blob_address;
+		unsigned long cc_info_pa = boot_params_ptr->cc_blob_address;
 		struct cc_blob_sev_info *cc_info;
 
 		kernel_add_identity_map(cc_info_pa, cc_info_pa + sizeof(*cc_info));
diff a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c	(rejected hunks)
@@ -107,7 +106,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
-	boot_params = bp;
+	boot_params_ptr = bp;
 
 	/*
 	 * Check if LA57 is desired and supported.
diff a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h	(rejected hunks)
@@ -61,7 +61,6 @@ extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
 void *malloc(int size);
 void free(void *where);
-extern struct boot_params *boot_params;
 void __putstr(const char *s);
 void __puthex(unsigned long value);
 #define error_putstr(__x)  __putstr(__x)
diff a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c	(rejected hunks)
@@ -46,7 +46,7 @@ void *memmove(void *dest, const void *src, size_t n);
 /*
  * This is set up by the setup-routine at boot-time
  */
-struct boot_params *boot_params;
+struct boot_params *boot_params_ptr;
 
 struct port_io_ops pio_ops;
 
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
 
diff a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c	(rejected hunks)
@@ -883,7 +883,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	unsigned long kernel_entry;
 	efi_status_t status;
 
-	boot_params_pointer = boot_params;
+	boot_params_ptr = boot_params;
 
 	efi_system_table = sys_table_arg;
 	/* Check if we were booted by the EFI firmware */
Patch failed to apply on stable/linux-5.10.y. Reject:

diff a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h	(rejected hunks)
@@ -86,6 +86,8 @@ extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 				void (*error)(char *x));
+
+extern struct boot_params *boot_params_ptr;
 #endif
 
 #endif /* _ASM_X86_BOOT_H */
diff a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c	(rejected hunks)
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
diff a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c	(rejected hunks)
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
 
diff a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c	(rejected hunks)
@@ -107,7 +106,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
-	boot_params = bp;
+	boot_params_ptr = bp;
 
 	/*
 	 * Check if LA57 is desired and supported.
diff a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h	(rejected hunks)
@@ -61,7 +61,6 @@ extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
 void *malloc(int size);
 void free(void *where);
-extern struct boot_params *boot_params;
 void __putstr(const char *s);
 void __puthex(unsigned long value);
 #define error_putstr(__x)  __putstr(__x)
diff a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c	(rejected hunks)
@@ -46,7 +46,7 @@ void *memmove(void *dest, const void *src, size_t n);
 /*
  * This is set up by the setup-routine at boot-time
  */
-struct boot_params *boot_params;
+struct boot_params *boot_params_ptr;
 
 struct port_io_ops pio_ops;
 
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
 
diff a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c	(rejected hunks)
@@ -883,7 +883,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	unsigned long kernel_entry;
 	efi_status_t status;
 
-	boot_params_pointer = boot_params;
+	boot_params_ptr = boot_params;
 
 	efi_system_table = sys_table_arg;
 	/* Check if we were booted by the EFI firmware */
Patch failed to apply on stable/linux-5.4.y. Reject:

diff a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h	(rejected hunks)
@@ -86,6 +86,8 @@ extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 				void (*error)(char *x));
+
+extern struct boot_params *boot_params_ptr;
 #endif
 
 #endif /* _ASM_X86_BOOT_H */
diff a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c	(rejected hunks)
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
diff a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c	(rejected hunks)
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
 
@@ -852,7 +852,7 @@ void choose_random_location(unsigned long input,
 		return;
 	}
 
-	boot_params->hdr.loadflags |= KASLR_FLAG;
+	boot_params_ptr->hdr.loadflags |= KASLR_FLAG;
 
 	if (IS_ENABLED(CONFIG_X86_32))
 		mem_limit = KERNEL_IMAGE_SIZE;
diff a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c	(rejected hunks)
@@ -28,7 +28,6 @@ static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
  */
 unsigned long *trampoline_32bit __section(".data");
 
-extern struct boot_params *boot_params;
 int cmdline_find_option_bool(const char *option);
 
 static unsigned long find_trampoline_placement(void)
@@ -107,7 +106,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
-	boot_params = bp;
+	boot_params_ptr = bp;
 
 	/*
 	 * Check if LA57 is desired and supported.
diff a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h	(rejected hunks)
@@ -61,7 +61,6 @@ extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
 void *malloc(int size);
 void free(void *where);
-extern struct boot_params *boot_params;
 void __putstr(const char *s);
 void __puthex(unsigned long value);
 #define error_putstr(__x)  __putstr(__x)
diff a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c	(rejected hunks)
@@ -46,7 +46,7 @@ void *memmove(void *dest, const void *src, size_t n);
 /*
  * This is set up by the setup-routine at boot-time
  */
-struct boot_params *boot_params;
+struct boot_params *boot_params_ptr;
 
 struct port_io_ops pio_ops;
 
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
 

