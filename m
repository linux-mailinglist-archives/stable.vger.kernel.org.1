Return-Path: <stable+bounces-19919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AAD8537E3
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D95F1F29801
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC485FF07;
	Tue, 13 Feb 2024 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VPu2jSGu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDC35F54E;
	Tue, 13 Feb 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845446; cv=none; b=dTxrZaUMIymAZzLVr4hQmrZoLuBDepUCFBlb8Z/k35/O1KInjRkXNPCLDkG9OMVrO8M5z9dsgiohKLLiqXbJ0hB0J4Lqtxe1GUkqwLJmxYINfmCJMEsV9DGDmg/CG8S2x3o9fIYB8JPxygD4mM//IH5KrFMalsXUnOjpEYPv9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845446; c=relaxed/simple;
	bh=aT3BMxODy9oUPPXWrouqVSZ415OVbSCjN4CJeifYRs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gzy/hXtkbJJyz1w9LUlaG77pTRz5hNfrx5TR7jY0CPngdBp7h0jY/qTJnieYEIk3uJQRJB7Yay6e7pGbM6t4YRZqyFXHEvhdJLmfv1fUSWjjS1KGTrfw1zwhUXBGcjNe3nXW3EX8feFRiKgL0SA6G7+1T8R5w48K8+LbGeTUbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VPu2jSGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B69C433F1;
	Tue, 13 Feb 2024 17:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845445;
	bh=aT3BMxODy9oUPPXWrouqVSZ415OVbSCjN4CJeifYRs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VPu2jSGuF61pYHW0cKVLp4fCOaREcicF3bhUdz7b+8LvVzKn24xndb0RClIgy4w6s
	 Epciho3jKrf/GB8SQlaBJm+0p99C/3Mz49E5ykIOTP5DnMcIFCKPe1DQnRik39TGar
	 r3ruRDhYQaUW2rtkaxqA2XravM3gGe1c4+MtszTE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tom Englund <tomenglund26@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 042/121] x86/efistub: Avoid placing the kernel below LOAD_PHYSICAL_ADDR
Date: Tue, 13 Feb 2024 18:20:51 +0100
Message-ID: <20240213171854.226968428@linuxfoundation.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213171852.948844634@linuxfoundation.org>
References: <20240213171852.948844634@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit 2f77465b05b1270c832b5e2ee27037672ad2a10a ]

The EFI stub's kernel placement logic randomizes the physical placement
of the kernel by taking all available memory into account, and picking a
region at random, based on a random seed.

When KASLR is disabled, this seed is set to 0x0, and this results in the
lowest available region of memory to be selected for loading the kernel,
even if this is below LOAD_PHYSICAL_ADDR. Some of this memory is
typically reserved for the GFP_DMA region, to accommodate masters that
can only access the first 16 MiB of system memory.

Even if such devices are rare these days, we may still end up with a
warning in the kernel log, as reported by Tom:

 swapper/0: page allocation failure: order:10, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0

Fix this by tweaking the random allocation logic to accept a low bound
on the placement, and set it to LOAD_PHYSICAL_ADDR.

Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
Reported-by: Tom Englund <tomenglund26@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218404
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h     |  3 ++-
 drivers/firmware/efi/libstub/kaslr.c       |  2 +-
 drivers/firmware/efi/libstub/randomalloc.c | 12 +++++++-----
 drivers/firmware/efi/libstub/x86-stub.c    |  1 +
 drivers/firmware/efi/libstub/zboot.c       |  2 +-
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 212687c30d79..c04b82ea40f2 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -956,7 +956,8 @@ efi_status_t efi_get_random_bytes(unsigned long size, u8 *out);
 
 efi_status_t efi_random_alloc(unsigned long size, unsigned long align,
 			      unsigned long *addr, unsigned long random_seed,
-			      int memory_type, unsigned long alloc_limit);
+			      int memory_type, unsigned long alloc_min,
+			      unsigned long alloc_max);
 
 efi_status_t efi_random_get_seed(void);
 
diff --git a/drivers/firmware/efi/libstub/kaslr.c b/drivers/firmware/efi/libstub/kaslr.c
index 62d63f7a2645..1a9808012abd 100644
--- a/drivers/firmware/efi/libstub/kaslr.c
+++ b/drivers/firmware/efi/libstub/kaslr.c
@@ -119,7 +119,7 @@ efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
 		 */
 		status = efi_random_alloc(*reserve_size, min_kimg_align,
 					  reserve_addr, phys_seed,
-					  EFI_LOADER_CODE, EFI_ALLOC_LIMIT);
+					  EFI_LOADER_CODE, 0, EFI_ALLOC_LIMIT);
 		if (status != EFI_SUCCESS)
 			efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
 	} else {
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 674a064b8f7a..4e96a855fdf4 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -17,7 +17,7 @@
 static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 					 unsigned long size,
 					 unsigned long align_shift,
-					 u64 alloc_limit)
+					 u64 alloc_min, u64 alloc_max)
 {
 	unsigned long align = 1UL << align_shift;
 	u64 first_slot, last_slot, region_end;
@@ -30,11 +30,11 @@ static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 		return 0;
 
 	region_end = min(md->phys_addr + md->num_pages * EFI_PAGE_SIZE - 1,
-			 alloc_limit);
+			 alloc_max);
 	if (region_end < size)
 		return 0;
 
-	first_slot = round_up(md->phys_addr, align);
+	first_slot = round_up(max(md->phys_addr, alloc_min), align);
 	last_slot = round_down(region_end - size + 1, align);
 
 	if (first_slot > last_slot)
@@ -56,7 +56,8 @@ efi_status_t efi_random_alloc(unsigned long size,
 			      unsigned long *addr,
 			      unsigned long random_seed,
 			      int memory_type,
-			      unsigned long alloc_limit)
+			      unsigned long alloc_min,
+			      unsigned long alloc_max)
 {
 	unsigned long total_slots = 0, target_slot;
 	unsigned long total_mirrored_slots = 0;
@@ -78,7 +79,8 @@ efi_status_t efi_random_alloc(unsigned long size,
 		efi_memory_desc_t *md = (void *)map->map + map_offset;
 		unsigned long slots;
 
-		slots = get_entry_num_slots(md, size, ilog2(align), alloc_limit);
+		slots = get_entry_num_slots(md, size, ilog2(align), alloc_min,
+					    alloc_max);
 		MD_NUM_SLOTS(md) = slots;
 		total_slots += slots;
 		if (md->attribute & EFI_MEMORY_MORE_RELIABLE)
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 5d0934ae7dc8..4a11470bed5e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -831,6 +831,7 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 
 	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
 				  seed[0], EFI_LOADER_CODE,
+				  LOAD_PHYSICAL_ADDR,
 				  EFI_X86_KERNEL_ALLOC_LIMIT);
 	if (status != EFI_SUCCESS)
 		return status;
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index bdb17eac0cb4..1ceace956758 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -119,7 +119,7 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 		}
 
 		status = efi_random_alloc(alloc_size, min_kimg_align, &image_base,
-					  seed, EFI_LOADER_CODE, EFI_ALLOC_LIMIT);
+					  seed, EFI_LOADER_CODE, 0, EFI_ALLOC_LIMIT);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to allocate memory\n");
 			goto free_cmdline;
-- 
2.43.0




