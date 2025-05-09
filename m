Return-Path: <stable+bounces-143061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0ABAB1B48
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 19:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26EB1B651EB
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 17:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E82356C9;
	Fri,  9 May 2025 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bjp5HcYi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D820C030;
	Fri,  9 May 2025 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810417; cv=none; b=ofXN6vXdP4+mLmYdAtoFiPVGiILjIeSGK59Xgw4sBmLcGgtP9odhbBSj5zN0oHFppHkcyTpHkgTDVpvZ5lVaS97Qi5tAzg0nRlNQkq+f2MFGFnmA/8ZKIWgaWN0hmu6dhvD7J6v0OD9lWiphOcFUejjGH4J/2mqpaTvUtmgqM20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810417; c=relaxed/simple;
	bh=nrh242XAYGJ4BUggQHAKhdHYKrqxRWsUk/neqm6hKew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPp4x6pb/PSR6PGiPXXQLJ7mUjxrnVHsbsZDvHadpfxbWVay3v8TO46/sQwz4ZKyW9xwLLwjl1lioEdeu5IwjvASDPNNocfnVYrbt1Vldxe38lDFFShowJy1V39aeCLu7u85Pvem/wZo/uQkfLgaeCBVcw8CRWvzYyFe6qTcTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bjp5HcYi; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746810416; x=1778346416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nrh242XAYGJ4BUggQHAKhdHYKrqxRWsUk/neqm6hKew=;
  b=Bjp5HcYi2xiOl7c8smzF3cURF/jQLb9viW8NOgI0EGcBNGYoPyoL8siz
   QetMMUer/+IStBB3rK7a0VzvJpb08n3D6/ebY0T3ZpIpP7tkSj6eP1WLQ
   plbTmkUF3wC5NDQ66XMzGpq1bDx/1QuUS88sQtho2Uyptv+2NPrc8YpdG
   vH32fslu0H/UK+0tErKpS1pROmraO/eRNqzWVPoVHMneg3eko4NqIaM/s
   nj75JPpKc9F+Nl9Rb7m1TuVs4im0JsDUDTs9DafGXhD29u57UZOJNgrf9
   cO9xiPSIR3IMRpcDCDm9kChGak7l2AcN9idsK5DSwPKgDnfi8qnhg+pAp
   Q==;
X-CSE-ConnectionGUID: qpglH75OTh+bGG5TacPXkg==
X-CSE-MsgGUID: B8UCwfELRw+u3AsGYL5nsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="52455779"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="52455779"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 10:06:55 -0700
X-CSE-ConnectionGUID: WaT8JMCHQjqZstX/dzgNuA==
X-CSE-MsgGUID: 5/SnilGKTbK9uA6bdOAFMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="141450336"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.43.235])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 10:06:52 -0700
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
Subject: [PATCH v2] x86/mtrr: Check if fixed-range MTRR exists in mtrr_save_fixed_ranges()
Date: Fri,  9 May 2025 17:06:33 +0000
Message-ID: <20250509170633.3411169-2-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When suspending, save_processor_state() calls mtrr_save_fixed_ranges()
to save fixed-range MTRRs. On platforms without fixed-range MTRRs,
accessing these MSRs will trigger unchecked MSR access error. Make
sure fixed-range MTRRs are supported before access to prevent such
error.

Since mtrr_state.have_fixed is only set when MTRRs are present and
enabled, checking the CPU feature flag in mtrr_save_fixed_ranges()
is unnecessary.

Fixes: 3ebad5905609 ("[PATCH] x86: Save and restore the fixed-range MTRRs of the BSP when suspending")
Cc: stable@vger.kernel.org
Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
---
v2:
* Removed unnecessary boot_cpu_has(X86_FEATURE_MTRR) check.
* Updated commit message.
Link: https://lore.kernel.org/all/20250509085612.2236222-2-jiaqing.zhao@linux.intel.com

 arch/x86/kernel/cpu/mtrr/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index e2c6b471d230..8c18327eb10b 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -593,7 +593,7 @@ static void get_fixed_ranges(mtrr_type *frs)
 
 void mtrr_save_fixed_ranges(void *info)
 {
-	if (boot_cpu_has(X86_FEATURE_MTRR))
+	if (mtrr_state.have_fixed)
 		get_fixed_ranges(mtrr_state.fixed_ranges);
 }
 
-- 
2.43.0


