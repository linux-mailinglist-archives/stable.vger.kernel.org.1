Return-Path: <stable+bounces-43590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED78C366C
	for <lists+stable@lfdr.de>; Sun, 12 May 2024 14:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAAA3B2102E
	for <lists+stable@lfdr.de>; Sun, 12 May 2024 12:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA742B9D1;
	Sun, 12 May 2024 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEtBX9de"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3199D21A04;
	Sun, 12 May 2024 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516525; cv=none; b=gZvIN2SEcXuILOmpDxQu1ZS/7KttVM7T6IiKGomKcVXRMujb/bjyWovC90x3TQn7NAG+DBEhrmLRzcYMaGL3zTMmKy6VKYu/UIys0FKrrFvhkg3bH3eqqRZMMxiQpTh/nmzT6jipMtsvLFTadWVAFBEMJqelo8ob/aHjum6oC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516525; c=relaxed/simple;
	bh=6OozzRL9Ac8RminZLGX0NityVv8OgHFWYl7lEm738KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gb+0iPN1RiKi/oWFsn5GmY6PeuSoqz67Vy85IN4PTOLdgInPROBIAw71ekZOOAG878FCAgjO68HTwvSDIb9pvkixmxamIW0jAGYWJfcZfg4vmbI8j2REn6zGnksU1VSi/qt0rWRqxOPpmPM2bsSg1TsOvIjilBjtN9Q22/lRtsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEtBX9de; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516524; x=1747052524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6OozzRL9Ac8RminZLGX0NityVv8OgHFWYl7lEm738KY=;
  b=hEtBX9deyCS8tnoY7JroSTP/gtlXnvR7OtilMceIEx/RapE+0aMnOsez
   8mbX9PCIwGfcVyIHW0Kpb4RgGKH9e1M8KV2SVZ5m1azloAe6vla0Q8VD3
   sw3JERv4NVuw2XmpikzxqAk/MS+Jh6kPPcYhhL2Xj3Qz7qdQLE6PCLcHw
   4EjiEPETeK+P5Ed019YHMO40lybW5IavjWZye6jwHvJg7nYCcXBtBJodY
   u2n0ptAQHs+j4ZcFrGuPYdWtOmhutFxu5/GZ+wHk416wrsdDpsSRiZeqE
   EqT9LQ+0DlgNTQ/RK2hb5L82RXcAYex+STkF2LNHwDq3mNVYHeZS5BoPe
   g==;
X-CSE-ConnectionGUID: DGPOg0aRThiOTX7Cv+jPWg==
X-CSE-MsgGUID: v7U69mV4RLKjmZ1pglxIEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11594206"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11594206"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:22:02 -0700
X-CSE-ConnectionGUID: 3tizv2yDTRO6W5TGaqJsUQ==
X-CSE-MsgGUID: 5e9xAJobSmCweaAA/TZMbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="61258786"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 12 May 2024 05:21:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 163BFA5; Sun, 12 May 2024 15:21:58 +0300 (EEST)
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
Subject: [PATCHv4 1/4] x86/tdx: Factor out TD metadata write TDCALL
Date: Sun, 12 May 2024 15:21:51 +0300
Message-ID: <20240512122154.2655269-2-kirill.shutemov@linux.intel.com>
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

The TDG_VM_WR TDCALL is used to ask the TDX module to change some
TD-specific VM configuration. There is currently only one user in the
kernel of this TDCALL leaf.  More will be added shortly.

Refactor to make way for more users of TDG_VM_WR who will need to modify
other TD configuration values.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index b556cbcc847e..4bb786dcd6b4 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -77,6 +77,18 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
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
@@ -901,10 +913,6 @@ static void tdx_kexec_finish(void)
 
 void __init tdx_early_init(void)
 {
-	struct tdx_module_args args = {
-		.rdx = TDCS_NOTIFY_ENABLES,
-		.r9 = -1ULL,
-	};
 	u64 cc_mask;
 	u32 eax, sig[3];
 
@@ -923,7 +931,7 @@ void __init tdx_early_init(void)
 	cc_set_mask(cc_mask);
 
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdcall(TDG_VM_WR, &args);
+	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
-- 
2.43.0


