Return-Path: <stable+bounces-143022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A32ECAB0DE4
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41543BE131
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38912741D0;
	Fri,  9 May 2025 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlfdqH5X"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EDF2749DA;
	Fri,  9 May 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781037; cv=none; b=VXo+4+r/2YcwSBrSwchGJZZMyrZd9a1S+h06kKINCsokW+ZnVfTe59fQxqQA8Tq3Ao/4AhDDTccAdVG6F3nuEnfYi1GQUJxGlZHBTg1MqoBY5PvroLI5X8haIh7VIRXlq6fooXq5YMRNMeZ8wLF2DAtv1bi8M26WtAxCj6UBmTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781037; c=relaxed/simple;
	bh=g2kpuyvLGCAKN83aNu3nllO/A1653V53pmPpo/UjVQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYiZyW4SsELaLqwVCTLgOnIv2gAwcIfST2LPeoglI8x/FXbvWKULYQ0+COm08L04sqimqb8Q49f0cI8FWv7nTlCf2V79Ez0RHlirZoEAi+aWKaSB1O0Yxv9/ZLy0O1042yHsz7bKX42xBO5lm+1TaT3BkNkq98JWstcmY7ry0Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlfdqH5X; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746781036; x=1778317036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g2kpuyvLGCAKN83aNu3nllO/A1653V53pmPpo/UjVQk=;
  b=DlfdqH5XzV3u6LSdv7YTytl0YBjDjikhrsP3BZDMT8uAnvLarojhpFH4
   8FKCzOiOKp1lyY0hicffDf7xSCZISnEchyq4z4epswCHMPZeUgMx/sktE
   vlsQ5NCoqX9dt5F2Ryb4GCz6SZxYoy2JB8HHmVcPBWfIaTf9FcUqAJLPM
   AidRf8KiJStGsbDiYSZnm5IAQylXXWSP8h731OfXwKxxr926qd6/HdZPJ
   DHin9Av2hk+gmW0HOV5nEdRfTnyptXrQ0ZvHMkDLG9veqlyITl0xpGRdd
   Kg1eRtKCtXIUuNoT9ekG9zSYE7jg7AMwnCg2YkzB/Z9TEeqdyvarPgsUx
   g==;
X-CSE-ConnectionGUID: 731VyrCqRuSCCgY74NDgKg==
X-CSE-MsgGUID: EM0lxu8ySFePtiWV7d6j+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="58818043"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="58818043"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 01:57:15 -0700
X-CSE-ConnectionGUID: QtZHdK5FRs2Qi9mZx09OMQ==
X-CSE-MsgGUID: vcgmSyiLRf+7TfKxr27H5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="136514060"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.43.235])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 01:57:13 -0700
From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bernhard Kaindl <bk@suse.de>,
	Andi Kleen <ak@linux.intel.com>
Cc: Li Fei <fei1.li@intel.com>,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mtrr: Check if fixed-range MTRR exists in `mtrr_save_fixed_ranges`
Date: Fri,  9 May 2025 08:56:12 +0000
Message-ID: <20250509085612.2236222-2-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When suspending, `save_processor_state` calls `mtrr_save_fixed_ranges`
to save fixed-range MTRRs. On platforms without MTRR or fixed-range
MTRR support, accessing MTRR MSRs triggers unchecked MSR access error.
Make sure fixed-range MTRR is supported before access to prevent such
error.

Fixes: 3ebad5905609 ("[PATCH] x86: Save and restore the fixed-range MTRRs of the BSP when suspending")
Cc: stable@vger.kernel.org
Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
---
 arch/x86/kernel/cpu/mtrr/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index e2c6b471d230..ca37b374d1b0 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -593,7 +593,7 @@ static void get_fixed_ranges(mtrr_type *frs)
 
 void mtrr_save_fixed_ranges(void *info)
 {
-	if (boot_cpu_has(X86_FEATURE_MTRR))
+	if (boot_cpu_has(X86_FEATURE_MTRR) && mtrr_state.have_fixed)
 		get_fixed_ranges(mtrr_state.fixed_ranges);
 }
 
-- 
2.43.0


