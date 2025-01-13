Return-Path: <stable+bounces-108526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F160A0C0A9
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BABB77A2A3D
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 18:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26881CBA18;
	Mon, 13 Jan 2025 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="neUR/tsv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JLM9iGl8"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25231CB9F0;
	Mon, 13 Jan 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793725; cv=none; b=lu6rw7FdP5Hk22dF2TuWF+tRWOB9Hu+N8nUIXSEZeR/xFlw6haGgepM7b+flwyGqbwyTMbg+JQ2W83elVR3KQMMg/Sy1ZixIFMJnVIkjU6FN/DUBOpSI43nlo2p2r1T8xiDiTgq/PxD2CH7WLJlh/izuvkkFQ9bipiHQngj7Qss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793725; c=relaxed/simple;
	bh=EOuiL0QikfTdWBcat1c1sejRHGNfuETY7FUdZbLCbZA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dSZJiaGdqZiUB1+pYzS8nAiSVtQ7BQIgLZBPRRh4dVpIsitYrHVpDuJPJ1/V36xSt0IDPtgoiuLfi1bZwMNTedAM8nkJDP611/O1cEdh3OtQeN6Qm7j30L+/ylarWv2T7f3lHxP682Qu3R611q2RmX62ZNxCIF0TOEKJI+jmvrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=neUR/tsv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JLM9iGl8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 Jan 2025 18:42:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736793722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3VrjzKgEvJQLkCu9Mrne4JjBpOKpN06McNWW81axPs=;
	b=neUR/tsvalbKcFI3DqzeLKa6el756x7q4smVkq/u9IF5uDNL/wBpeeo1Wcf2vEpkVynmKr
	nzRhmxw/drW5AT5VqoAiDC0SSJtwbC7SuiMjvaNoIQijOystKbGke+aAzE2voVfmeJBbs6
	dtodXd6h3n0iGXDqm6wr1AiQzD7bs5yyF7lLoDjMttLvzvuQ5tIA9cL00mG7cRjXEAyaau
	T87n2UwjaM2VRncdcRuDYQTKVS6Hk0R2Sz++rkofoVw+FyPB69PU9vTB9OBClabpPI7RSh
	FHYI6K7zNQz8eejBmEDy0i6Mxf5usBb0st2UjrbrbnyrjFEFveedSzG2EBkaGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736793722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3VrjzKgEvJQLkCu9Mrne4JjBpOKpN06McNWW81axPs=;
	b=JLM9iGl8MlZcvi827gtq8xahQz616xaXAJaB2DQDBqQY76NwFXbM7XIX4mJ21GBCqWDLas
	ywyTqxSm/Ng/xqCQ==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] memremap: Pass down MEMREMAP_* flags to arch_memremap_wb()
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 6.11+@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250113131459.2008123-2-kirill.shutemov@linux.intel.com>
References: <20250113131459.2008123-2-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173679372142.399.1486852534229781359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3663155bfb47855685ae5f0488117dcbe503eeac
Gitweb:        https://git.kernel.org/tip/3663155bfb47855685ae5f0488117dcbe503eeac
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 13 Jan 2025 15:14:58 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Jan 2025 15:15:13 +01:00

memremap: Pass down MEMREMAP_* flags to arch_memremap_wb()

The x86 version of arch_memremap_wb() needs the flags to decide if the mapping
has be encrypted or decrypted.

Pass down the flag to arch_memremap_wb(). All current implementations
ignore the argument.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org # 6.11+
Link: https://lore.kernel.org/r/20250113131459.2008123-2-kirill.shutemov@linux.intel.com
---
 arch/arm/include/asm/io.h   | 2 +-
 arch/arm/mm/ioremap.c       | 2 +-
 arch/arm/mm/nommu.c         | 2 +-
 arch/riscv/include/asm/io.h | 2 +-
 kernel/iomem.c              | 5 +++--
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 1815748..bae5edf 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -381,7 +381,7 @@ void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size);
 void iounmap(volatile void __iomem *io_addr);
 #define iounmap iounmap
 
-void *arch_memremap_wb(phys_addr_t phys_addr, size_t size);
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags);
 #define arch_memremap_wb arch_memremap_wb
 
 /*
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 89f1c97..748698e 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -436,7 +436,7 @@ void __arm_iomem_set_ro(void __iomem *ptr, size_t size)
 	set_memory_ro((unsigned long)ptr, PAGE_ALIGN(size) / PAGE_SIZE);
 }
 
-void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
 {
 	return (__force void *)arch_ioremap_caller(phys_addr, size,
 						   MT_MEMORY_RW,
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index c415f38..279641f 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -251,7 +251,7 @@ void __iomem *pci_remap_cfgspace(resource_size_t res_cookie, size_t size)
 EXPORT_SYMBOL_GPL(pci_remap_cfgspace);
 #endif
 
-void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
 {
 	return (void *)phys_addr;
 }
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 1c5c641..0257f4a 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -136,7 +136,7 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #include <asm-generic/io.h>
 
 #ifdef CONFIG_MMU
-#define arch_memremap_wb(addr, size)	\
+#define arch_memremap_wb(addr, size, flags)	\
 	((__force void *)ioremap_prot((addr), (size), _PAGE_KERNEL))
 #endif
 
diff --git a/kernel/iomem.c b/kernel/iomem.c
index dc21207..75e61c1 100644
--- a/kernel/iomem.c
+++ b/kernel/iomem.c
@@ -6,7 +6,8 @@
 #include <linux/ioremap.h>
 
 #ifndef arch_memremap_wb
-static void *arch_memremap_wb(resource_size_t offset, unsigned long size)
+static void *arch_memremap_wb(resource_size_t offset, unsigned long size,
+			      unsigned long flags)
 {
 #ifdef ioremap_cache
 	return (__force void *)ioremap_cache(offset, size);
@@ -91,7 +92,7 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 		if (is_ram == REGION_INTERSECTS)
 			addr = try_ram_remap(offset, size, flags);
 		if (!addr)
-			addr = arch_memremap_wb(offset, size);
+			addr = arch_memremap_wb(offset, size, flags);
 	}
 
 	/*

