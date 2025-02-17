Return-Path: <stable+bounces-116604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B802A389FA
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 17:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF8877A1222
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A2E22A7F7;
	Mon, 17 Feb 2025 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1SWIqM7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA518225A57;
	Mon, 17 Feb 2025 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810561; cv=none; b=BGzvfXOe0SdEfFtq+jlGIVT2CTgcNXx2DOI4L9u53qYde/QBb3z4L8RTIVINxLnplvB6zGBPmkuW9BBIl+c5o62x2JbN2dyK1+xHH6N0JjWGViTrGnmxqRxfUzIq9+ymyP1kHT/4z3z3WcznWugsYdSsCUAvkSl0oyyXR3wlrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810561; c=relaxed/simple;
	bh=Q/y2Ura+ZZ4aJJSpOsP2M0RlMQFJRNDUTUtpYBZlPro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8L9r2JBeEIZuNv3usyf9ogpkVtTMllUzkn9igw9xdSuEaQnqPK784ufZ7Ng0fG1aIivfiu8soWP9Oa0MxuxlfDkQNL2KZolKkGexYtX/oiIakVmYC1fKVn+SPLlBhe9S2YEW0lll/ezqfA/STVaSt/Dq1U4S1MSfevrmpk1jZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1SWIqM7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739810560; x=1771346560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q/y2Ura+ZZ4aJJSpOsP2M0RlMQFJRNDUTUtpYBZlPro=;
  b=c1SWIqM7gHfLQ6x+cmRUSV/pE+5v8a4csJ7jO+uhm7By3gNM9EB7MgDb
   rkQASHkeKx+ARY3Ag0KoWhu7WCuEcBgLzlarc1fmCeFrW5qFIDC0a7pYq
   V5XX39ZX+x7e4T6zlTExIFifOZ9tWfvzY4iEkxZAkeGjwTQUO34Ckpr6V
   Wag3MwmlK0nk/9A8MRCoFsflF6BReQhVsewvrRQsJzarqSufmBUrDBend
   C0cichzBD3NTiZ9lbxveqRUDUKHO2GgneHF0yFZbArI+j5jOzSh66qB9/
   Yldr74jpKmF008mQdZSaKAfZf4TbvuP5ZtOnk45mf0XG7mUOuaKHD3rfE
   g==;
X-CSE-ConnectionGUID: NndbcaRYT2GC5v/RGdMzDA==
X-CSE-MsgGUID: UEVzFiioRzWH+nqvn64S6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44426586"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="44426586"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 08:42:38 -0800
X-CSE-ConnectionGUID: DLaoWa/wSWS1Bb+Zkbv1Tw==
X-CSE-MsgGUID: X50OseD7Tkq0w6139d7UYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119092112"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 17 Feb 2025 08:42:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 98D08139; Mon, 17 Feb 2025 18:42:29 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>
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
	Ashish Kalra <ashish.kalra@amd.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCHv4 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default
Date: Mon, 17 Feb 2025 18:38:21 +0200
Message-ID: <20250217163822.343400-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217163822.343400-1-kirill.shutemov@linux.intel.com>
References: <20250217163822.343400-1-kirill.shutemov@linux.intel.com>
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
default unless MEMREMAP_DEC is specified or if the kernel runs on
a machine with SME enabled.

It fixes the crash due to #VE on kexec in TDX guests if CONFIG_EISA is
enabled.

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
index 8d29163568a7..a4b23d2e92d2 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -503,6 +503,14 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
+{
+	if ((flags & MEMREMAP_DEC) || cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
+		return (void __force *)ioremap_cache(phys_addr, size);
+
+	return (void __force *)ioremap_encrypted(phys_addr, size);
+}
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
-- 
2.47.2


