Return-Path: <stable+bounces-108429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B42A0B7E4
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41413A6371
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544CF23DE86;
	Mon, 13 Jan 2025 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MeJZgmFf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBEF23A57A;
	Mon, 13 Jan 2025 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774113; cv=none; b=WqzE/jWwgF6cMCoHHAwoeBLFfAmQzr0pkD2DkFiRcyWBc9/HLhnFPu4JuXs4InFNEdqEA+wzLQ/GSmav7yshUqhvW4QN0HrXVBS20Cb3FQPNkVBqo/uROmuU6HcQdluPTsiNAuFI2/HGc1VUYPfLKv3prInseYeEIx6m0kU9k0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774113; c=relaxed/simple;
	bh=LHeSsttkoKMeng2VddbV2QNxMpk9HfvJihAeVigQqTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5+yiPOVhujX4bydERdOzEVqQVrEjnd7fvhTtQpvXr+d2Kv53QckbTEOJol8PNcSbqPbDMN5QpFQ3aKY2bpfMNVl54pHPGf+yqMRHLtmXOn9De6EZGJ3yRHMvel4VtaJ+2IvE/BoFZnS+FWs+D3ucDo9c+f+iH66n8WW4z8zUOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MeJZgmFf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736774111; x=1768310111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LHeSsttkoKMeng2VddbV2QNxMpk9HfvJihAeVigQqTw=;
  b=MeJZgmFf8u7QKFR47l1fXiPcpyDzu/pV1fyoRKk4ldfqmSMSLpwXqWds
   vq8f3kbh5xxjL9E7eW/slziGZvsBWM+9sfIyY6kgfBttpD/tDSAznFmXc
   bhXebNFLw3tSv1bxkXXEnl8Q0WqR00f9VTw3TJR9mNckA7TZcmSinetBI
   eAmLwx0RAajGGwci65OPXLphbCWkCUybX2Hpin23Gd/yy7PNDwLk+i0m+
   6rfkgKnsiqWFrC6jClAIZrHJmdnylltt9qpdQe0BWTrvEaEekt3jaIFGI
   O0U84Y1l/Svj2YGFdHqOePsb0bnEZN+heup5UQEm0GIia6m3IS6yVk17v
   A==;
X-CSE-ConnectionGUID: KF8+FsHyRF+lByOLjRVnyQ==
X-CSE-MsgGUID: vXCGekJrT9mCiYRU1alKSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40716157"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40716157"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 05:15:10 -0800
X-CSE-ConnectionGUID: o4VV8uJcSg+ZjlYXelD4Sg==
X-CSE-MsgGUID: vPrizUG7SwOz90kPgmPdAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104560154"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 13 Jan 2025 05:15:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 41AF23B7; Mon, 13 Jan 2025 15:15:02 +0200 (EET)
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
	stable@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCHv3 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default
Date: Mon, 13 Jan 2025 15:14:59 +0200
Message-ID: <20250113131459.2008123-3-kirill.shutemov@linux.intel.com>
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

Currently memremap(MEMREMAP_WB) can produce decrypted/shared mapping:

memremap(MEMREMAP_WB)
  arch_memremap_wb()
    ioremap_cache()
      __ioremap_caller(.encrytped = false)

In such cases, the IORES_MAP_ENCRYPTED flag on the memory will determine
if the resulting mapping is encrypted or decrypted.

Creating a decrypted mapping without explicit request from the caller is
risky:

  - It can inadvertently expose the guest's data and compromise the
    guest.

  - Accessing private memory via shared/decrypted mapping on TDX will
    either trigger implicit conversion to shared or #VE (depending on
    VMM implementation).

    Implicit conversion is destructive: subsequent access to the same
    memory via private mapping will trigger a hard-to-debug #VE crash.

The kernel already provides a way to request decrypted mapping
explicitly via the MEMREMAP_DEC flag.

Modify memremap(MEMREMAP_WB) to produce encrypted/private mapping by
default unless MEMREMAP_DEC is specified.

Fix the crash due to #VE on kexec in TDX guests if CONFIG_EISA is enabled.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: stable@vger.kernel.org # 6.11+
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
---
 arch/x86/include/asm/io.h | 3 +++
 arch/x86/mm/ioremap.c     | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index ed580c7f9d0a..1a0dc2b2bf5b 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -175,6 +175,9 @@ extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, un
 extern void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size);
 #define ioremap_encrypted ioremap_encrypted
 
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags);
+#define arch_memremap_wb arch_memremap_wb
+
 /**
  * ioremap     -   map bus memory into CPU space
  * @offset:    bus address of the memory
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 8d29163568a7..3c36f3f5e688 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -503,6 +503,14 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
+{
+	if (flags & MEMREMAP_DEC)
+		return (void __force *)ioremap_cache(phys_addr, size);
+
+	return (void __force *)ioremap_encrypted(phys_addr, size);
+}
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
-- 
2.45.2


