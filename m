Return-Path: <stable+bounces-71395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 890F8962388
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 11:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5FE1C235BD
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DEF166F20;
	Wed, 28 Aug 2024 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zyweyqng"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63111662E7;
	Wed, 28 Aug 2024 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837718; cv=none; b=kVxK/6nyx2ryJxBqcjH0GKuXewz0fFmDPg6kBAa85aTkYW9B8i2KG1s5QC/Z8GY+gT0Kz5i0K1QPsWsilnQrfm0hPrup0M8bK7j4bKz+wEFxCr0YImvXO+NscX3byqhjdfgzncO/WqkDUnifdyqhzAiYqxbygWiFJO7KhhoxPHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837718; c=relaxed/simple;
	bh=txhMMZiJ5qMnU9pWlrkfzR83GU0+BDmAM6j8E24Zs5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azWatfArdUa4lFXnAIT/KmwR6/LB1mBGP4lvLraOUHJ/ERQkW8gd+DsHzLQAIqXO/nDjYidwCBrmSxRrIMwIx1wqquxpAeiKq2QFEAfo0D69yaNWMNvye2zAdW5yVrGMVhWjgvsREaJrkDjW4pvLQp1PrWR0AiFiw7ot0mfVHKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zyweyqng; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724837717; x=1756373717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=txhMMZiJ5qMnU9pWlrkfzR83GU0+BDmAM6j8E24Zs5U=;
  b=ZyweyqngUtIXd21t01uPa0g4rNKD0LdWvJi/pKz95XGsjoXBBXpDqoyR
   k+zvP4COFyZb3T/Qfknhk86YL6e+l6nHxQGkBwic4+dhvO1+R4LF0cF+P
   79U4I++HjF10MGb107t3u3Xm+79N7WbfzKCYA1+V5hJzQYNVLon8uJTko
   emjTafH0yz+jRPSxyErd3PAwF6zVqvYSLe501N/LavfXCwF+8FZLJIcZ9
   NfwFDsVKAPfbTJK7knkwlS9EfByxeogcfQIuqihFADmnqcKK+GE2UmVTL
   kKolQzQogABPKscWMPhJWcygatKebQWCuhmvNwxxHpTR978/BMZHRVCO5
   A==;
X-CSE-ConnectionGUID: uwr7eGUDTE6DdsroZXr9Bw==
X-CSE-MsgGUID: Ly8thP7ATvqEL3w6/vXcMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="26254883"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="26254883"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 02:35:15 -0700
X-CSE-ConnectionGUID: T/h+enk6SfaHYpNv8dnoiw==
X-CSE-MsgGUID: VFvSTLrARWi9vWFF2Kfhmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="62827318"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 28 Aug 2024 02:35:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8665F143; Wed, 28 Aug 2024 12:35:10 +0300 (EEST)
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
Subject: [PATCHv6 2/4] x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
Date: Wed, 28 Aug 2024 12:35:03 +0300
Message-ID: <20240828093505.2359947-3-kirill.shutemov@linux.intel.com>
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
2.45.2


