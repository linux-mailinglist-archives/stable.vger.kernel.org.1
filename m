Return-Path: <stable+bounces-108430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E402A0B7E1
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6CA1668DE
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 13:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEC222318;
	Mon, 13 Jan 2025 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jT1vFm4Y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE423A56F;
	Mon, 13 Jan 2025 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774115; cv=none; b=fF98scd5sO/pKChUYd30MMZYB4O8dPaMnS4zDfGAJnHXYM3yG3qdEfXBI5ZiS0RERPniZGSGELreble5VPSkETDLWw+3X78UmLCgh4IORmBsQfFb91Vj/6TxJQM0g48KPID8cYs77A7ZyT9ZA6YVWbUywt1vyRqBR1Dv/J3cci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774115; c=relaxed/simple;
	bh=ZR0aZ2391KMGTJMqGzoYqRNpT5XTC02nSB7usWUD1Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHrAGnOUif2TG2a4OmWduPU9KvscoOKIkgNCmWiY5zovLMojaC+WlCOEZVtq7z7GWXvkCmvtgJn9aShsNJMQZVOVATJM22mkjwALKxRWJOlDcFlGv8B3yFMORw/qBxbMXe9Hdaah01kLu/WqoDTqG359xhGB/qUHX7VXZe5q22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jT1vFm4Y; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736774113; x=1768310113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZR0aZ2391KMGTJMqGzoYqRNpT5XTC02nSB7usWUD1Rs=;
  b=jT1vFm4YpNPtbb8FFiUcXlAWw58AW7kO+WvUMyz6UGK4PoysA9aOcn4z
   xqTIhxCyKaI7xaPWDyiE+joNQqiHTOTJt9Ut4cA/9zmrZPUnGSGCfeHG+
   IEK3yO/4vpJsXp4WRgj8kwBY2RBxR5O3yOMN574sa/0qLMca2HajtkJyK
   jQOITYMdKOyHmszxyta0n2xQtYRW5cC7NVYc2TObkCCDPH70ERCBVEW98
   9tjOWc5PmOV+c3Io4xjXcDFXHHoEUZaFPzaSwZjq0hScH0iXWcrQP6cKS
   WhdgShJKrH45rrtRNGVBQUqasq+MhyFHcurfqSh4FPKG+f2fIkS4IhwXC
   A==;
X-CSE-ConnectionGUID: joywT7BvQ7ucQZLufb01DQ==
X-CSE-MsgGUID: dCywRwVCQG2Z7ZeWzO51BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47700453"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="47700453"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 05:15:09 -0800
X-CSE-ConnectionGUID: LlwqUqmETzaBPtaIAY9Dig==
X-CSE-MsgGUID: giokKlz1Qma+mWVO+2mu1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104359354"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 13 Jan 2025 05:15:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 39CA1331; Mon, 13 Jan 2025 15:15:02 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Chan <ericchancf@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kai Huang <kai.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Russell King <linux@armlinux.org.uk>,
	Samuel Holland <samuel.holland@sifive.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCHv3 1/2] memremap: Pass down MEMREMAP_* flags to arch_memremap_wb()
Date: Mon, 13 Jan 2025 15:14:58 +0200
Message-ID: <20250113131459.2008123-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250113131459.2008123-1-kirill.shutemov@linux.intel.com>
References: <20250113131459.2008123-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86 version of arch_memremap_wb() needs the flags to decide if the mapping
has be encrypted or decrypted.

Pass down the flag to arch_memremap_wb(). All current implementations
ignore the argument.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: stable@vger.kernel.org # 6.11+
---
 arch/arm/include/asm/io.h   | 2 +-
 arch/arm/mm/ioremap.c       | 2 +-
 arch/arm/mm/nommu.c         | 2 +-
 arch/riscv/include/asm/io.h | 2 +-
 kernel/iomem.c              | 5 +++--
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 1815748f5d2a..bae5edf348ef 100644
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
index 794cfea9f9d4..9f7883e6db46 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -411,7 +411,7 @@ void __arm_iomem_set_ro(void __iomem *ptr, size_t size)
 	set_memory_ro((unsigned long)ptr, PAGE_ALIGN(size) / PAGE_SIZE);
 }
 
-void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
 {
 	return (__force void *)arch_ioremap_caller(phys_addr, size,
 						   MT_MEMORY_RW,
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index c415f3859b20..279641f0780e 100644
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
index 1c5c641075d2..0257f4aa7ff4 100644
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
index dc2120776e1c..75e61c1c6bc0 100644
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
-- 
2.45.2


