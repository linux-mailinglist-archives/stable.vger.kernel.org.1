Return-Path: <stable+bounces-71396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A4A96238A
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 11:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD2E282D24
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A961167DAC;
	Wed, 28 Aug 2024 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9/fVQyt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5A515AD90;
	Wed, 28 Aug 2024 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837719; cv=none; b=c7mU5e/o+FPG166djgkVausZJF27+9I5VV59yyPJSQv+Fsul2qz/sszVRy5fuiD1J0mJpjfdiE3c67Vf55stxTNyw4/gYYCJmeifiwfeQZ5HfdOG30kD1BTZ4hB1CzRlf0WUkx7i0A3wdAbLPmCVDNYTYRLOr5XTPm6pgfWTk7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837719; c=relaxed/simple;
	bh=jXkbf1bN1JjFULaCZowJliy7FvNZ7PnLXWSqm/seso8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUGvMr6+M4rm0UzpZhN6y88j1xDegdnCWGfKtrPFhQMhUSzGfDzzETDPberbSz2ZG5wJYHBQHz9+h2tt/hfYYmrFObdUUHrkW9KjiAaHE+RId9jkyKaotlWibC2Ve1X7lbmo3EX47Gj5roQGvdTCqBleLaOO+GlwwHsWZmForEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9/fVQyt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724837718; x=1756373718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXkbf1bN1JjFULaCZowJliy7FvNZ7PnLXWSqm/seso8=;
  b=W9/fVQytqTmNvLJR4dHaKQUzl+HTXi7v+WPvQwwgTCmHAO/Exr5ha9Ak
   vhkdN25X0fAn4kWr4jpo17KpNhgRFYmSN3TvDTTZhNP/ZRt2FXnCKUt7j
   eVZma8y/2gX1LXm0oXMLj0yatYqURW8nc6QwtcyycXtssVJGC+XiRJkfq
   yHcO/GH8Hd3PRN1rrWxtJNyxXvCxf6hsA3TxAZLsD+bkLEaZC/8v5Gs8C
   lVdGG0T8ZBPYt6uggF9tr5HVdkeQtm+8iKK8vN4GIwvRVHUsC3Rwh8LOq
   7w/uG71xt5h+6hP7xzdhAdcX6vQCBmp/TTNZ2plXuMTh2NP0jx76moeQ3
   Q==;
X-CSE-ConnectionGUID: h8r3xcYSTSmdSA8N70yBrg==
X-CSE-MsgGUID: WPEbEYakSvKMY5rKwkptnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27123863"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="27123863"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 02:35:15 -0700
X-CSE-ConnectionGUID: NLkYbWrKSumnDYbdXdcHLQ==
X-CSE-MsgGUID: zL+fveQ7TaeFooruZG2Qjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="93879099"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 28 Aug 2024 02:35:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 7067B118; Wed, 28 Aug 2024 12:35:10 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kai Huang <kai.huang@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCHv6 1/4] x86/tdx: Introduce wrappers to read and write TD metadata
Date: Wed, 28 Aug 2024 12:35:02 +0300
Message-ID: <20240828093505.2359947-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828093505.2359947-1-kirill.shutemov@linux.intel.com>
References: <20240828093505.2359947-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDG_VM_WR TDCALL is used to ask the TDX module to change some
TD-specific VM configuration. There is currently only one user in the
kernel of this TDCALL leaf.  More will be added shortly.

Refactor to make way for more users of TDG_VM_WR who will need to modify
other TD configuration values.

Add a wrapper for the TDG_VM_RD TDCALL that requests TD-specific
metadata from the TDX module. There are currently no users for
TDG_VM_RD. Mark it as __maybe_unused until the first user appears.

This is preparation for enumeration and enabling optional TD features.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c           | 32 ++++++++++++++++++++++++++-----
 arch/x86/include/asm/shared/tdx.h |  1 +
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 078e2bac2553..64717a96a936 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -77,6 +77,32 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
+/* Read TD-scoped metadata */
+static inline u64 __maybe_unused tdg_vm_rd(u64 field, u64 *value)
+{
+	struct tdx_module_args args = {
+		.rdx = field,
+	};
+	u64 ret;
+
+	ret = __tdcall_ret(TDG_VM_RD, &args);
+	*value = args.r8;
+
+	return ret;
+}
+
+/* Write TD-scoped metadata */
+static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
+{
+	struct tdx_module_args args = {
+		.rdx = field,
+		.r8 = value,
+		.r9 = mask,
+	};
+
+	return __tdcall(TDG_VM_WR, &args);
+}
+
 /**
  * tdx_mcall_get_report0() - Wrapper to get TDREPORT0 (a.k.a. TDREPORT
  *                           subtype 0) using TDG.MR.REPORT TDCALL.
@@ -924,10 +950,6 @@ static void tdx_kexec_finish(void)
 
 void __init tdx_early_init(void)
 {
-	struct tdx_module_args args = {
-		.rdx = TDCS_NOTIFY_ENABLES,
-		.r9 = -1ULL,
-	};
 	u64 cc_mask;
 	u32 eax, sig[3];
 
@@ -946,7 +968,7 @@ void __init tdx_early_init(void)
 	cc_set_mask(cc_mask);
 
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdcall(TDG_VM_WR, &args);
+	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index fdfd41511b02..7e12cfa28bec 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -16,6 +16,7 @@
 #define TDG_VP_VEINFO_GET		3
 #define TDG_MR_REPORT			4
 #define TDG_MEM_PAGE_ACCEPT		6
+#define TDG_VM_RD			7
 #define TDG_VM_WR			8
 
 /* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
-- 
2.45.2


