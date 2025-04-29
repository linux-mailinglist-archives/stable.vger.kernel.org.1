Return-Path: <stable+bounces-138329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2FDAA177C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074911BA19BF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7622459FA;
	Tue, 29 Apr 2025 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B6dp1A8H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2B5C148;
	Tue, 29 Apr 2025 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948888; cv=none; b=aoACwFvouErVNdFcgwY/xh1AgGAVMQgQQhKthrUkPlnzOuPpd8aBN9a5GRrNCbkjP/FuPqzfVYwVcllzo1X2NJuXsZbAeZoeEAOyHywlvrJ+ZE+ZY2Ju/vpAmf0TfVkzw/XtzsPv9tzSRIKXnBIhoIuwUIyGa62akJVaxEgMFas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948888; c=relaxed/simple;
	bh=q7CkJayjYJqFqUwGemmPW3VYWXTA/ZSsP2ATXJXGsLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucl5FXgdkcddLmqjzDw32nc9q5kJbOqpmsFJNvOutSjbDkcKTpEIhKotxjqTSTRJjsfeeIVx2K4HhHB40NEOYSEQeegejYkh26zgD5isJGOBHllRPTqJNdSQqJj6jWPAdgsVqmD/+IHo899/VA80vRRG3RsSldwuizwkFD7iL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B6dp1A8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45CFC4CEE3;
	Tue, 29 Apr 2025 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948888;
	bh=q7CkJayjYJqFqUwGemmPW3VYWXTA/ZSsP2ATXJXGsLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B6dp1A8HjU/xnBvNdZiVqOL6km68zw3bcUOUAUTsVcDvyV/d61GnPvQuogIy5K30f
	 Ykd2pFQiWSh8DKpNoauGdjhTJZqNEv3SWQ3Cf7v0EfIIr2hcizwWwK7RHwkQHUQWO/
	 OSYrqU+mkB1F7hFEtEGke3oXdd4qqtSHVe7yUHFw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 150/373] riscv: Properly export reserved regions in /proc/iomem
Date: Tue, 29 Apr 2025 18:40:27 +0200
Message-ID: <20250429161129.327047839@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Björn Töpel <bjorn@rivosinc.com>

[ Upstream commit e94eb7ea6f206e229791761a5fdf9389f8dbd183 ]

The /proc/iomem represents the kernel's memory map. Regions marked
with "Reserved" tells the user that the range should not be tampered
with. Kexec-tools, when using the older kexec_load syscall relies on
the "Reserved" regions to build the memory segments, that will be the
target of the new kexec'd kernel.

The RISC-V port tries to expose all reserved regions to userland, but
some regions were not properly exposed: Regions that resided in both
the "regular" and reserved memory block, e.g. the EFI Memory Map. A
missing entry could result in reserved memory being overwritten.

It turns out, that arm64, and loongarch had a similar issue a while
back:

  commit d91680e687f4 ("arm64: Fix /proc/iomem for reserved but not memory regions")
  commit 50d7ba36b916 ("arm64: export memblock_reserve()d regions via /proc/iomem")

Similar to the other ports, resolve the issue by splitting the regions
in an arch initcall, since we need a working allocator.

Fixes: ffe0e5261268 ("RISC-V: Improve init_resources()")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20250409182129.634415-1-bjorn@kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/setup.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 8cc147491c675..0c85b9e59ec0e 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -84,6 +84,9 @@ static struct resource bss_res = { .name = "Kernel bss", };
 static struct resource elfcorehdr_res = { .name = "ELF Core hdr", };
 #endif
 
+static int num_standard_resources;
+static struct resource *standard_resources;
+
 static int __init add_resource(struct resource *parent,
 				struct resource *res)
 {
@@ -157,7 +160,7 @@ static void __init init_resources(void)
 	struct resource *res = NULL;
 	struct resource *mem_res = NULL;
 	size_t mem_res_sz = 0;
-	int num_resources = 0, res_idx = 0;
+	int num_resources = 0, res_idx = 0, non_resv_res = 0;
 	int ret = 0;
 
 	/* + 1 as memblock_alloc() might increase memblock.reserved.cnt */
@@ -221,6 +224,7 @@ static void __init init_resources(void)
 	/* Add /memory regions to the resource tree */
 	for_each_mem_region(region) {
 		res = &mem_res[res_idx--];
+		non_resv_res++;
 
 		if (unlikely(memblock_is_nomap(region))) {
 			res->name = "Reserved";
@@ -238,6 +242,9 @@ static void __init init_resources(void)
 			goto error;
 	}
 
+	num_standard_resources = non_resv_res;
+	standard_resources = &mem_res[res_idx + 1];
+
 	/* Clean-up any unused pre-allocated resources */
 	if (res_idx >= 0)
 		memblock_free(__pa(mem_res), (res_idx + 1) * sizeof(*mem_res));
@@ -249,6 +256,33 @@ static void __init init_resources(void)
 	memblock_free(__pa(mem_res), mem_res_sz);
 }
 
+static int __init reserve_memblock_reserved_regions(void)
+{
+	u64 i, j;
+
+	for (i = 0; i < num_standard_resources; i++) {
+		struct resource *mem = &standard_resources[i];
+		phys_addr_t r_start, r_end, mem_size = resource_size(mem);
+
+		if (!memblock_is_region_reserved(mem->start, mem_size))
+			continue;
+
+		for_each_reserved_mem_range(j, &r_start, &r_end) {
+			resource_size_t start, end;
+
+			start = max(PFN_PHYS(PFN_DOWN(r_start)), mem->start);
+			end = min(PFN_PHYS(PFN_UP(r_end)) - 1, mem->end);
+
+			if (start > mem->end || end < mem->start)
+				continue;
+
+			reserve_region_with_split(mem, start, end, "Reserved");
+		}
+	}
+
+	return 0;
+}
+arch_initcall(reserve_memblock_reserved_regions);
 
 static void __init parse_dtb(void)
 {
-- 
2.39.5




