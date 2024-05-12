Return-Path: <stable+bounces-43589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC39B8C366B
	for <lists+stable@lfdr.de>; Sun, 12 May 2024 14:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893F4281836
	for <lists+stable@lfdr.de>; Sun, 12 May 2024 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966BB29422;
	Sun, 12 May 2024 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YoTqa+xh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC55320DD2;
	Sun, 12 May 2024 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516525; cv=none; b=J/AxazDtz2E0GVYDGPaPG+Td3+3AUVx5l7G/tuvdQGlfwvyy5rVWEepieVPNQUuU6LbbApcylwwY1tG04nIuWEtF1Pgrf/S7k2Z+2UE1zBsJTZLMZiGAU6uFY8g0piZ7GEtY6F5ijaH12RPAQ3EbkSIDHr2pJ5ex53YQlsyrBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516525; c=relaxed/simple;
	bh=vXjpiAWnFIFzITKji76szzy+4Es+7EaqG8Svln0Ps1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T61c/iwmdxKSioTQjiob+9E2oPX77EtcsqvL3ibfDdfIyt+cP5fHBumq+rCyjHb62iqlLQ7OZci2LEoZ5IFGCKe01zdc6QOiBROpePMHWpgAYeVYo2lbEuv+clyR/AGPwoUtGzBOM4KuuF1Y1wurh4sPAAmQ6M0cp+6icMjTduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YoTqa+xh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516524; x=1747052524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vXjpiAWnFIFzITKji76szzy+4Es+7EaqG8Svln0Ps1k=;
  b=YoTqa+xhtTWGjVVm4KtJPhDx5qRjQhTj++Cg9ghiABSbVgMq4yb4+OBK
   fDwCna8Cb5/GbYtoMPZAeqyQ68FNLQwkI4U4/aM35vV+uIZXNH3MIoqrh
   jEpoWZvYnf7cGgTssz87CrTFAQ/G9hk8cVElBnLczCco7uKKt0l2ek4RT
   aVKxqQ0uBkQkf5M7326FXzN2TxOrGjDUAUUq7kj4YqRSO/ubvaUyFl3mG
   a3UoGK5gkcjcVkIiQQs4Ge0nuaMogxZkClVafUV5MMGjKRbCt+oAWl82n
   HnLKwryNTDRNvKnmZdBin/6fvQDeH7ybsqhqvVykdx7qpqbX+bWRVBGDp
   g==;
X-CSE-ConnectionGUID: iUxcaWb0TZayf5FwPMnOAQ==
X-CSE-MsgGUID: Iyy5n9uXS/Gizgz0Lc6OMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11594200"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11594200"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:22:01 -0700
X-CSE-ConnectionGUID: HHCqyTMnSlat9q9u2aGp0Q==
X-CSE-MsgGUID: jY3JzaDUSZK8fyVyHiksJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="61258777"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 12 May 2024 05:21:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3468F354; Sun, 12 May 2024 15:21:58 +0300 (EEST)
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
	stable@vger.kernel.org
Subject: [PATCHv4 3/4] x86/tdx: Dynamically disable SEPT violations from causing #VEs
Date: Sun, 12 May 2024 15:21:53 +0300
Message-ID: <20240512122154.2655269-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240512122154.2655269-1-kirill.shutemov@linux.intel.com>
References: <20240512122154.2655269-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory access #VE's are hard for Linux to handle in contexts like the
entry code or NMIs.  But other OSes need them for functionality.
There's a static (pre-guest-boot) way for a VMM to choose one or the
other.  But VMMs don't always know which OS they are booting, so they
choose to deliver those #VE's so the "other" OSes will work.  That,
unfortunately has left us in the lurch and exposed to these
hard-to-handle #VEs.

The TDX module has introduced a new feature.  Even if the static
configuration is "send nasty #VE's", the kernel can dynamically request
that they be disabled.

Check if the feature is available and disable SEPT #VE if possible.

If the TD allowed to disable/enable SEPT #VEs, the ATTR_SEPT_VE_DISABLE
attribute is no longer reliable. It reflects the initial state of the
control for the TD, but it will not be updated if someone (e.g. bootloader)
changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
determine if SEPT #VEs are enabled or disabled.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 373e715e31bf ("x86/tdx: Panic on bad configs that #VE on "private" memory access")
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c           | 88 +++++++++++++++++++++++++------
 arch/x86/include/asm/shared/tdx.h | 11 +++-
 2 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1ff571cb9177..ba37f4306f4e 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -77,6 +77,20 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
+/* Read TD-scoped metadata */
+static inline u64 tdg_vm_rd(u64 field, u64 *value)
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
 /* Write TD-scoped metadata */
 static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
 {
@@ -179,6 +193,62 @@ static void __noreturn tdx_panic(const char *msg)
 		__tdx_hypercall(&args);
 }
 
+/*
+ * The kernel cannot handle #VEs when accessing normal kernel memory. Ensure
+ * that no #VE will be delivered for accesses to TD-private memory.
+ *
+ * TDX 1.0 does not allow the guest to disable SEPT #VE on its own. The VMM
+ * controls if the guest will receive such #VE with TD attribute
+ * ATTR_SEPT_VE_DISABLE.
+ *
+ * Newer TDX module allows the guest to control if it wants to receive SEPT
+ * violation #VEs.
+ *
+ * Check if the feature is available and disable SEPT #VE if possible.
+ *
+ * If the TD allowed to disable/enable SEPT #VEs, the ATTR_SEPT_VE_DISABLE
+ * attribute is no longer reliable. It reflects the initial state of the
+ * control for the TD, but it will not be updated if someone (e.g. bootloader)
+ * changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
+ * determine if SEPT #VEs are enabled or disabled.
+ */
+static void disable_sept_ve(u64 td_attr)
+{
+	const char *msg = "TD misconfiguration: SEPT #VE has to be disabled";
+	bool debug = td_attr & ATTR_DEBUG;
+	u64 config, controls;
+
+	/* Is this TD allowed to disable SEPT #VE */
+	tdg_vm_rd(TDCS_CONFIG_FLAGS, &config);
+	if (!(config & TDCS_CONFIG_FLEXIBLE_PENDING_VE)) {
+		/* No SEPT #VE controls for the guest: check the attribute */
+		if (td_attr & ATTR_SEPT_VE_DISABLE)
+			return;
+
+		/* Relax SEPT_VE_DISABLE check for debug TD for backtraces */
+		if (debug)
+			pr_warn("%s\n", msg);
+		else
+			tdx_panic(msg);
+		return;
+	}
+
+	/* Check if SEPT #VE has been disabled before us */
+	tdg_vm_rd(TDCS_TD_CTLS, &controls);
+	if (controls & TD_CTLS_PENDING_VE_DISABLE)
+		return;
+
+	/* Keep #VEs enabled for splats in debugging environments */
+	if (debug)
+		return;
+
+	/* Disable SEPT #VEs */
+	tdg_vm_wr(TDCS_TD_CTLS, TD_CTLS_PENDING_VE_DISABLE,
+		  TD_CTLS_PENDING_VE_DISABLE);
+
+	return;
+}
+
 static void tdx_setup(u64 *cc_mask)
 {
 	struct tdx_module_args args = {};
@@ -204,24 +274,12 @@ static void tdx_setup(u64 *cc_mask)
 	gpa_width = args.rcx & GENMASK(5, 0);
 	*cc_mask = BIT_ULL(gpa_width - 1);
 
+	td_attr = args.rdx;
+
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
 	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
 
-	/*
-	 * The kernel can not handle #VE's when accessing normal kernel
-	 * memory.  Ensure that no #VE will be delivered for accesses to
-	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
-	 */
-	td_attr = args.rdx;
-	if (!(td_attr & ATTR_SEPT_VE_DISABLE)) {
-		const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
-
-		/* Relax SEPT_VE_DISABLE check for debug TD. */
-		if (td_attr & ATTR_DEBUG)
-			pr_warn("%s\n", msg);
-		else
-			tdx_panic(msg);
-	}
+	disable_sept_ve(td_attr);
 }
 
 /*
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index fdfd41511b02..fecb2a6e864b 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -16,11 +16,20 @@
 #define TDG_VP_VEINFO_GET		3
 #define TDG_MR_REPORT			4
 #define TDG_MEM_PAGE_ACCEPT		6
+#define TDG_VM_RD			7
 #define TDG_VM_WR			8
 
-/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
+/* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
+#define TDCS_CONFIG_FLAGS		0x1110000300000016
+#define TDCS_TD_CTLS			0x1110000300000017
 #define TDCS_NOTIFY_ENABLES		0x9100000000000010
 
+/* TDCS_CONFIG_FLAGS bits */
+#define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
+
+/* TDCS_TD_CTLS bits */
+#define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
+
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
 #define TDVMCALL_GET_QUOTE		0x10002
-- 
2.43.0


