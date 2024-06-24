Return-Path: <stable+bounces-54999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15948914904
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 13:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6AF1C22C6B
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 11:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4087713C9CB;
	Mon, 24 Jun 2024 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrvvDsxS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EAA13A879;
	Mon, 24 Jun 2024 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229335; cv=none; b=Vfxj/ICUfHhLTn9za8uFIudVn6iS26+zszMtC2GHdCK8jSbFd02Oz1WfkR26g1sC3UmFGYEFWpLwtuerHaorWLonOBfT9OdII8lWGF2x3sasMoHWzvUhNthY5Q9tRnX9Lo0mV07OsjgYMGXxk5j35fJrUQTAh2rEIj6PYXO+Yjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229335; c=relaxed/simple;
	bh=Evn3CciU5+MT/8KiO0RjooJvNArmoH7Yzw9c2SS6Lek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrsvLBJqw815QtRhSequhYZUpI9Llzi2Di/IwInph8jIQzrDoZ8qCbqYge6lwA5TLWrO6qdmpliM8Fl3UWaiwAqjxWqAAHTultgUtLTUtoPh5hq4chTpADhaPUgRwfdYFw8pswZ1TpDXS5i5Bq9NdWFGhtyPSL7uEjRmEAKKbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrvvDsxS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719229334; x=1750765334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Evn3CciU5+MT/8KiO0RjooJvNArmoH7Yzw9c2SS6Lek=;
  b=JrvvDsxSatoPJd4Zm1HSDSovAS8Tegl5I+WJJt7yf9m+/jJNVyHbeKPb
   Mj1CMVNGukLB35ms6OXE9WKneVT8KFwfE6i185rgtdcOwtTtr/uALXswm
   WrHCftXTYzecPjmSbbmFAi8vexdAhE7TJPX//L3jBA8cLuxB8Isg+jepS
   vcoV7CDnBbPd1dxUiJAOcGS28zFqvWtWrr4Tt4JN5TEhRM998HtHbMmcp
   F5i8jceDKqHpIm9Ua/lvKamCVNrvAv2iKQrsjRO+NpDhB7fK0nc64bdpP
   JRLRklHRONq82SqGYwps0acK4yKYjnsG4KuMOvNU1cU30psEmMJpfjRBK
   w==;
X-CSE-ConnectionGUID: dGrvE//ySz+XEEExBac2fQ==
X-CSE-MsgGUID: YTiG0Ar4Q+qVsy+PlwLojA==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="20008076"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="20008076"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 04:42:10 -0700
X-CSE-ConnectionGUID: RcVLuAFdR8CNElsdiHLUjg==
X-CSE-MsgGUID: 4Miheq5kR6mdDqAMKCQ2ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="74502457"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 24 Jun 2024 04:42:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5C84E206; Mon, 24 Jun 2024 14:42:05 +0300 (EEST)
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
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	stable@vger.kernel.org
Subject: [PATCHv5 2/4] x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
Date: Mon, 24 Jun 2024 14:41:47 +0300
Message-ID: <20240624114149.377492-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624114149.377492-1-kirill.shutemov@linux.intel.com>
References: <20240624114149.377492-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename tdx_parse_tdinfo() to tdx_setup() and move setting NOTIFY_ENABLES
there.

The function will be extended to adjust TD configuration.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 64717a96a936..08ce488b54d0 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -193,7 +193,7 @@ static void __noreturn tdx_panic(const char *msg)
 		__tdx_hypercall(&args);
 }
 
-static void tdx_parse_tdinfo(u64 *cc_mask)
+static void tdx_setup(u64 *cc_mask)
 {
 	struct tdx_module_args args = {};
 	unsigned int gpa_width;
@@ -218,6 +218,9 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	gpa_width = args.rcx & GENMASK(5, 0);
 	*cc_mask = BIT_ULL(gpa_width - 1);
 
+	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
+	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
+
 	/*
 	 * The kernel can not handle #VE's when accessing normal kernel
 	 * memory.  Ensure that no #VE will be delivered for accesses to
@@ -964,11 +967,11 @@ void __init tdx_early_init(void)
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
 	cc_vendor = CC_VENDOR_INTEL;
-	tdx_parse_tdinfo(&cc_mask);
-	cc_set_mask(cc_mask);
 
-	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
+	/* Configure the TD */
+	tdx_setup(&cc_mask);
+
+	cc_set_mask(cc_mask);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
-- 
2.43.0


