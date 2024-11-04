Return-Path: <stable+bounces-89612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF36C9BB147
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E3C281C32
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE0C1B3931;
	Mon,  4 Nov 2024 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGD4SOt4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F31B0F34;
	Mon,  4 Nov 2024 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716711; cv=none; b=PmwDKu6keUBtJAZuCe8UPdKj0cPM8vgl4o9BSjLavpwJmCetwhKKy6XqKdvo8NLU7K6hI0TclA7PRCTKrbvwCn3QWY2S+WM5k/ib2jyWKH/fzBbXSaQpfCVV8y7QcIzBm02+jacBlCo1dAefugMwFbfcgFoNcFR5TS8atBXyDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716711; c=relaxed/simple;
	bh=gocM8aPyttzWISmlvpoeL5oA9VUV8xfMlYkDGj3TCos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3MdAs8ijrqmqDPWtb4gbxhd9A/kRkefxfQO8hpioQcp8LOmK71D9SNjakarS65eAXyQoBBZc4mg4n08jxfANBQwWIegX2wsP7mwi0rZDY+YpuDytjEV6CM/5g30DwuUVsoq0jjs+EaPJ87x6YT1a3Ati/LPdTmOfVKw2ac46AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGD4SOt4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730716710; x=1762252710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gocM8aPyttzWISmlvpoeL5oA9VUV8xfMlYkDGj3TCos=;
  b=nGD4SOt4WSAMJd7Nrs6g3RoQtrquoZWuwg4dlfrSidgK0Px9oiWelVdQ
   y81gZRyBge8dLwezlkTrN7PeIve3fAqta7+LW7cjwtcdOpMOYH7d1xYc6
   ueRXnyLet7il3KjtQhoELFxw2f0ywKNGxEVtOXIPeHMf9lnfZ8jYnVRqx
   F0Iy6/OcVT7Kj3XTxzA2hfxB6CBoJ6ccl+3R1WvBGLqAyUC0JkvNVLTHp
   2IhxXix68H5QzOdo1xm6GibCAmIo8q2z/Hgy5usYDo3vnZn2q0CXG1Dzb
   vHRw3QJJFCG1D/bY3o2+UNG2agtNeXCiz9EizklwPfr//A6/mvFojnxMQ
   g==;
X-CSE-ConnectionGUID: cLU6MBmfTuS+SzGMjymKzQ==
X-CSE-MsgGUID: JLbFsyoCQuucLiuqAm68Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30509352"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30509352"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 02:38:28 -0800
X-CSE-ConnectionGUID: wwOQ0HbqTzOGnBsdtsOHzA==
X-CSE-MsgGUID: G+fvy3I/TXCrnwD2HmbWEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="84433002"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 04 Nov 2024 02:38:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id AA35D26A; Mon, 04 Nov 2024 12:38:23 +0200 (EET)
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
Subject: [PATCHv6, RESEND 2/4] x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
Date: Mon,  4 Nov 2024 12:38:01 +0200
Message-ID: <20241104103803.195705-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104103803.195705-1-kirill.shutemov@linux.intel.com>
References: <20241104103803.195705-1-kirill.shutemov@linux.intel.com>
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
index c74bb9e7d7a3..28b321a95a5e 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -194,7 +194,7 @@ static void __noreturn tdx_panic(const char *msg)
 		__tdx_hypercall(&args);
 }
 
-static void tdx_parse_tdinfo(u64 *cc_mask)
+static void tdx_setup(u64 *cc_mask)
 {
 	struct tdx_module_args args = {};
 	unsigned int gpa_width;
@@ -219,6 +219,9 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	gpa_width = args.rcx & GENMASK(5, 0);
 	*cc_mask = BIT_ULL(gpa_width - 1);
 
+	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
+	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
+
 	/*
 	 * The kernel can not handle #VE's when accessing normal kernel
 	 * memory.  Ensure that no #VE will be delivered for accesses to
@@ -969,11 +972,11 @@ void __init tdx_early_init(void)
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


