Return-Path: <stable+bounces-135617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B45A98F55
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834EA1B869D2
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DA5284696;
	Wed, 23 Apr 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xF98fxNc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CF828468E;
	Wed, 23 Apr 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420395; cv=none; b=e0S9WWDOBanSzv6dfbL3/UbrAFKSjU0xZOQai+BVhU6V4C4MGbX1H/iY3Uvro4QgLbMOzbxMcExXIiUtiJF/PLqFHDgZEsVINiiXWO0r7Gq+MdzEEe4S5185IabJRvJSqHY1w2hbvo1NnAVwVsVKzzIZSGKis2GnyvkwFllvt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420395; c=relaxed/simple;
	bh=0RHgjRXovHduyPYU5KCqch+V3nU4v7Rbarx3NiCEFP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgGy7SdCQeVmR4BzbNf9eFMVCRF1efxku9QJNu9r+TlKFG9ouCQLjy4A0wJcPDVFfrUWf/NLygGIWpx4r+aABOBqZlllf2B6E5hhJNlBxAffs5VLY12SKGHtpGJ6o/eFM0OCGNmgW530HRTTxAeB9aaMl9ySi3uA2t1tA9YPtiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xF98fxNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC4FC4CEE2;
	Wed, 23 Apr 2025 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420395;
	bh=0RHgjRXovHduyPYU5KCqch+V3nU4v7Rbarx3NiCEFP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xF98fxNcH478/pkov6BDO13TSe+u9P44FNwkACwoZJ8641RaIK1svZNr1wJbbDHO0
	 kTwBP8Ps9qxOeOrMxnubacNW+8+1LxWwik6ofacn+Ny8zYMwfilPvrSJkSMR2xq+8w
	 b9fzF5A1I9L/dlbV/RFxvm6meE4PUV5ARjJRCYFA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 088/241] riscv: Properly export reserved regions in /proc/iomem
Date: Wed, 23 Apr 2025 16:42:32 +0200
Message-ID: <20250423142624.177116964@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

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
index 4fe45daa6281e..b7d0bd4c0a81a 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -66,6 +66,9 @@ static struct resource bss_res = { .name = "Kernel bss", };
 static struct resource elfcorehdr_res = { .name = "ELF Core hdr", };
 #endif
 
+static int num_standard_resources;
+static struct resource *standard_resources;
+
 static int __init add_resource(struct resource *parent,
 				struct resource *res)
 {
@@ -139,7 +142,7 @@ static void __init init_resources(void)
 	struct resource *res = NULL;
 	struct resource *mem_res = NULL;
 	size_t mem_res_sz = 0;
-	int num_resources = 0, res_idx = 0;
+	int num_resources = 0, res_idx = 0, non_resv_res = 0;
 	int ret = 0;
 
 	/* + 1 as memblock_alloc() might increase memblock.reserved.cnt */
@@ -193,6 +196,7 @@ static void __init init_resources(void)
 	/* Add /memory regions to the resource tree */
 	for_each_mem_region(region) {
 		res = &mem_res[res_idx--];
+		non_resv_res++;
 
 		if (unlikely(memblock_is_nomap(region))) {
 			res->name = "Reserved";
@@ -210,6 +214,9 @@ static void __init init_resources(void)
 			goto error;
 	}
 
+	num_standard_resources = non_resv_res;
+	standard_resources = &mem_res[res_idx + 1];
+
 	/* Clean-up any unused pre-allocated resources */
 	if (res_idx >= 0)
 		memblock_free(mem_res, (res_idx + 1) * sizeof(*mem_res));
@@ -221,6 +228,33 @@ static void __init init_resources(void)
 	memblock_free(mem_res, mem_res_sz);
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




