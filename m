Return-Path: <stable+bounces-70222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ACF95F22A
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2019F280E44
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7B3179958;
	Mon, 26 Aug 2024 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPDi8x4R"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB35155A34;
	Mon, 26 Aug 2024 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676800; cv=none; b=EBc/1mfiA6YWqGorLVx/pidDexXjxbWGuWAVaV30JMyeGbERz5Uens6ta8HQnI4yAyEg9XtXtlsHLWJwoK3uAJBPUO1e9UOUK3X220jiPJxomCCND9F7OgY433itS091VbaYy2sgyeoCXphKm8JR94M4Xf3rgDliFDWbs///FQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676800; c=relaxed/simple;
	bh=04xmOMmXQPrgpBFe2TznVHzIEYdUVgvj/wFaYOAv5YE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aiMNNooQwL279amHhN9BxrIwQGAJI0Lnu7OQdLr+yzeUXg5IHwsq2qsp1UvvvceevJE8O/q/dFJcXH7iwvrvfAlp2oIpBGOa0Q5RP1OkgKh3ANVb6FeWuTGnljiwVrsf3ATeDSHrphOWmIrQNLbDy5AWZjBAw/aCdDU3PIo6Vnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPDi8x4R; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724676798; x=1756212798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=04xmOMmXQPrgpBFe2TznVHzIEYdUVgvj/wFaYOAv5YE=;
  b=gPDi8x4RZdFN2kT/p3bE9J8xfaSIRPyqdgShLDlXknt4ihi6UiZWpI9x
   y41xRwfOpkn7TzkQi22bFwjxOUHdIR+7PuWCfmpu+GliPo2+rW12eM46F
   kzBW6i0iB/Vp6tzg0mqujNj0k6CXK/wdAFiLdyqAQ5m3j8Bjj85j2WwY+
   QZojHs3oq3iLh1H4U/+k9VQs/JY3y3VuoCRNEHEAbwOhw6/vlnBoP+kDh
   q6EoaSOnhvrD3Y4VYGv1RzHhEAOF3JBrE6bwn1lkwgfnh+P4Bz/3uUueS
   GbfmT2Iel5cq0orSF/w6MvlOZV6aA7wuMHNsxKB9SLYGxQSQSiWlF5afA
   g==;
X-CSE-ConnectionGUID: j/z9EEdMQrm9lbVU0XY+4Q==
X-CSE-MsgGUID: 1I0umgA3SYamDVxTPCxYdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23274181"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="23274181"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 05:53:17 -0700
X-CSE-ConnectionGUID: I9LrvHmvQ020Neukqdrwzw==
X-CSE-MsgGUID: 4wiBbbcxRkCCOXEDPsRWPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="67401317"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 26 Aug 2024 05:53:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 7B5D6502; Mon, 26 Aug 2024 15:53:12 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] x86/tdx: Fix data leak in mmio_read()
Date: Mon, 26 Aug 2024 15:53:04 +0300
Message-ID: <20240826125304.1566719-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mmio_read() function makes a TDVMCALL to retrieve MMIO data for an
address from the VMM.

Sean noticed that mmio_read() unintentionally exposes the value of an
initialized variable on the stack to the VMM.

Do not send the original value of *val to the VMM.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Sean Christopherson <seanjc@google.com>
Fixes: 31d58c4e557d ("x86/tdx: Handle in-kernel MMIO")
Cc: stable@vger.kernel.org # v5.19+
---
 arch/x86/coco/tdx/tdx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 078e2bac2553..da8b66dce0da 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -389,7 +389,6 @@ static bool mmio_read(int size, unsigned long addr, unsigned long *val)
 		.r12 = size,
 		.r13 = EPT_READ,
 		.r14 = addr,
-		.r15 = *val,
 	};
 
 	if (__tdx_hypercall(&args))
-- 
2.43.0


