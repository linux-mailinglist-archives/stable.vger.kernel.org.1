Return-Path: <stable+bounces-144896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF412ABC895
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 22:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985E11B65710
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 20:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6E62192FC;
	Mon, 19 May 2025 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CrVFg7Wv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98F4B1E73
	for <stable@vger.kernel.org>; Mon, 19 May 2025 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687425; cv=none; b=dSJFkmoIXjt6ImUW+8bg8+sFwN+JxbrIxT59gWtf1H12X6kBLStIOZnut3bABYieP9N5cmXpZI6GdVM6QD/f3XSnOPElHlepLcbSGziFmakMSN/sXVimAc5JvumcaTLshq7ZMfFyTgt7tj6VImWi4Zn3poGATLUW9c7XOxOoceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687425; c=relaxed/simple;
	bh=fiynrl1U0kMcMPVVScJed3hQaXfpNGEbeJqXUjanyJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fke+i4aan6hwF6cpVL/gz/kiIDVXZzgTHd1BVniWlReVA4S8+cUMikLYg7dHl3nReQbYljPkMkbH83xUtIA69LEV47SPVRjZq+vJ1YPp28Dgukw0KcuBbVN7TsGBwqLljQOM7M0zSM6rXmz3mAgzBGJ7UBWru8r2jFPccakkEiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CrVFg7Wv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747687423; x=1779223423;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=fiynrl1U0kMcMPVVScJed3hQaXfpNGEbeJqXUjanyJ0=;
  b=CrVFg7WvY2gBXnwuiO2PxBXnZwg3ftdlyGfvK/vMTVzQ+uP8+FdYzxmD
   IGD4EennqU1reS/6+M8RFn9cNm9ztLaGUyHaHlv4yFJ2SiWGBe83jiFTH
   6UEkyPFFQ93ggYJniIu7+8iL7y1SXc/FPq7mDkZp41IozBjDdDzdLw6te
   8dcTqrNtXVGWFkaTAvx1O4TdIZdmmEVXBXq8p4YQ6+AYJ0aqQZdz86RDN
   W+p1lJMgAloT27mRqmQ+4Vl53dk0A+Kpp8GSC0Z1uqSN/Fqb1CKgG28zJ
   OiYcQ46Nr9cgSDzWq5CsZRPhWvUOMEr7gV9uSIPQfBgs+5c6PH9mE+QCo
   Q==;
X-CSE-ConnectionGUID: wefUrymtRY+C762yjtZlFg==
X-CSE-MsgGUID: DSWXT8J1R+CQOpnJXPv2Sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49508494"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="49508494"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 13:43:43 -0700
X-CSE-ConnectionGUID: iRBs/iIuR+ephaIygu94zw==
X-CSE-MsgGUID: bMjkZzN+Rfq1QD/E+Bylgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="139211702"
Received: from shikevix-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.20])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 13:43:43 -0700
Date: Mon, 19 May 2025 13:43:42 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH 6.6] x86/its: Fix build error for its_static_thunk()
Message-ID: <20250519-its-build-fix-6-6-v1-1-225ac41eb447@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAOWVK2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU0NL3cySYt2k0sycFN20zApdMyBMsjBONrM0M0lONk5VAuorKEoFSoH
 NjFYKcAxx9gCJmumZKcXW1gIArEPFinEAAAA=
X-Change-ID: 20250519-its-build-fix-6-6-b83c6964cc3e
X-Mailer: b4 0.14.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519195021.mgldcftlu5k4u5sw@desk>

Due to a likely merge resolution error of backport commit 772934d9062a
("x86/its: FineIBT-paranoid vs ITS"), the function its_static_thunk() was
placed in the wrong ifdef block, causing a build error when
CONFIG_MITIGATION_ITS and CONFIG_FINEIBT are both disabled:

  /linux-6.6/arch/x86/kernel/alternative.c:1452:5: error: redefinition of 'its_static_thunk'
   1452 | u8 *its_static_thunk(int reg)
        |     ^~~~~~~~~~~~~~~~

Fix it by moving its_static_thunk() under CONFIG_MITIGATION_ITS.

Reported-by: Natanael Copa <ncopa@alpinelinux.org>
Link: https://lore.kernel.org/all/20250519164717.18738b4e@ncopa-desktop/
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
commit ("x86/its: FineIBT-paranoid vs ITS") was resolved correctly in
v6.12:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.12.29&id=7e78061be78b8593df9b0cd0f21b1fee425035de

Fix is required in v6.6 and v6.1

v5.15 is unaffected:

https://lore.kernel.org/stable/20250516-its-5-15-v3-16-16fcdaaea544@linux.intel.com/
---
 arch/x86/kernel/alternative.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 4817e424d6965875b7e56ed9aeee5cd6ba8ed5b0..8e6cad42b296ee08aa16df2598ba7196f70b609c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -730,7 +730,15 @@ static bool cpu_wants_indirect_its_thunk_at(unsigned long addr, int reg)
 	/* Lower-half of the cacheline? */
 	return !(addr & 0x20);
 }
-#endif
+
+u8 *its_static_thunk(int reg)
+{
+	u8 *thunk = __x86_indirect_its_thunk_array[reg];
+
+	return thunk;
+}
+
+#endif /* CONFIG_MITIGATION_ITS */
 
 /*
  * Rewrite the compiler generated retpoline thunk calls.
@@ -1449,13 +1457,6 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 static void poison_cfi(void *addr) { }
 #endif
 
-u8 *its_static_thunk(int reg)
-{
-	u8 *thunk = __x86_indirect_its_thunk_array[reg];
-
-	return thunk;
-}
-
 #endif
 
 void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,

---
base-commit: 615b9e10e3377467ced8f50592a1b5ba8ce053d8
change-id: 20250519-its-build-fix-6-6-b83c6964cc3e

Best regards,
-- 
Pawan



