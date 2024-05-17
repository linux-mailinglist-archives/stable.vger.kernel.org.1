Return-Path: <stable+bounces-45404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DC28C8D2E
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 22:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9421B1F210CC
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 20:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E59112FF80;
	Fri, 17 May 2024 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwt9qPb4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ACE65F;
	Fri, 17 May 2024 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715976336; cv=none; b=WWgDooKyZ3NYutiAMbrNU9YubbtMGbAyRvMc2XTpPJIIbPlHdbI5GBbRNzmrURjIQ/fFocY9897ZmRGiEoqYkeHWjLVu5NfkKc7/Ndk0UzuH+FEizyOP8AisRMtBNGefpGMDlcbiW5UDeQPGmH4hG937eI3fjgn7P68r5I5k+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715976336; c=relaxed/simple;
	bh=L4UHLoKNdvHEJ52gXHRJqvJH5NbwO+Do+x6c9RoKfa4=;
	h=Subject:To:Cc:From:Date:Message-Id; b=l1elmyI2P/yhG1omxukHmZDlzV+PP+3ovdSS+L6XNpKSnrRGCpP0QvMO02Aj0A0zONqyv5Ka2BwaCIzEr6e0GYvBDORIXwYtiG2RJrmYjeeFzHKAi6AVWk3PsKHuc0ocSdcE9gvOD/xro5DQJiNTgu+eY1gP8G6ZwuUL1BVaRz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwt9qPb4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715976336; x=1747512336;
  h=subject:to:cc:from:date:message-id;
  bh=L4UHLoKNdvHEJ52gXHRJqvJH5NbwO+Do+x6c9RoKfa4=;
  b=fwt9qPb4kVc8gV+0tbb4TnZ/38AJc3tkvcr/M5Woxs9mkfRq/fWf5tcZ
   5Zo0LPDA+GibK7cOeoK42qXrSEbXpVZb3lQQS4JhkKjmU+qn8lcUnLsuo
   TkQUYh/NyIIxVBIwFxtx60LizV++0Aop/82O5+oPRXEYU7gWgIP6SkP5b
   YdONsSnvBvUt+CYDFnz+shrxp0WfMt66yo1cPsGnIui1F4r8SrbRIebmJ
   bSM9s3FZ6yWf2Rq3Hx97YNa1DjBCs7Ena6tQfb1Iei8MycF5ohY0CHrYO
   7ht2aTFJN/EE6hsLRkI4Hwgx8Q3wI9mN2Vx6qPBUSf9RoMLA1iXf/VLP6
   A==;
X-CSE-ConnectionGUID: ToER8IJ7TOOURuQsERfF5w==
X-CSE-MsgGUID: nkdozRhpRMa7gjeVBs5arA==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12024949"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12024949"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 13:05:35 -0700
X-CSE-ConnectionGUID: Cam4j2YbRM+lHBAMBnOLVw==
X-CSE-MsgGUID: R4YZAeCsTgWpVghNZicH7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="32306903"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa006.jf.intel.com with ESMTP; 17 May 2024 13:05:34 -0700
Subject: [PATCH] x86/cpu: Provide default cache line size if not enumerated
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>,andriy.shevchenko@linux.intel.com,stable@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 17 May 2024 13:05:34 -0700
Message-Id: <20240517200534.8EC5F33E@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

tl;dr: CPUs with CPUID.80000008H but without CPUID.01H:EDX[CLFSH]
will end up reporting cache_line_size()==0 and bad things happen.
Fill in a default on those to avoid the problem.

Long Story:

The kernel dies a horrible death if c->x86_cache_alignment (aka.
cache_line_size() is 0.  Normally, this value is populated from
c->x86_clflush_size.

Right now the code is set up to get c->x86_clflush_size from two
places.  First, modern CPUs get it from CPUID.  Old CPUs that don't
have leaf 0x80000008 (or CPUID at all) just get some sane defaults
from the kernel in get_cpu_address_sizes().

The vast majority of CPUs that have leaf 0x80000008 also get
->x86_clflush_size from CPUID.  But there are oddballs.

Intel Quark CPUs[1] and others[2] have leaf 0x80000008 but don't set
CPUID.01H:EDX[CLFSH], so they skip over filling in ->x86_clflush_size:

	cpuid(0x00000001, &tfms, &misc, &junk, &cap0);
	if (cap0 & (1<<19))
		c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;

So they: land in get_cpu_address_sizes(), set vp_bits_from_cpuid=0 and
never fill in c->x86_clflush_size, assign c->x86_cache_alignment, and
hilarity ensues in code like:

        buffer = kzalloc(ALIGN(sizeof(*buffer), cache_line_size()),
                         GFP_KERNEL);

To fix this, always provide a sane value for ->x86_clflush_size.

Big thanks to Andy Shevchenko for finding and reporting this and also
providing a first pass at a fix. But his fix was only partial and only
worked on the Quark CPUs.  It would not, for instance, have worked on
the QEMU config.

1. https://raw.githubusercontent.com/InstLatx64/InstLatx64/master/GenuineIntel/GenuineIntel0000590_Clanton_03_CPUID.txt
2. You can also get this behavior if you use "-cpu 486,+clzero"
   in QEMU.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Fixes: fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct value straight away, instead of a two-phase approach")
Link: https://lore.kernel.org/all/20240516173928.3960193-1-andriy.shevchenko@linux.intel.com/
Cc: stable@vger.kernel.org
---

 b/arch/x86/kernel/cpu/common.c |    4 ++++
 1 file changed, 4 insertions(+)

diff -puN arch/x86/kernel/cpu/common.c~default-x86_clflush_size arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~default-x86_clflush_size	2024-05-17 12:51:25.886169008 -0700
+++ b/arch/x86/kernel/cpu/common.c	2024-05-17 13:03:09.761999885 -0700
@@ -1064,6 +1064,10 @@ void get_cpu_address_sizes(struct cpuinf
 
 		c->x86_virt_bits = (eax >> 8) & 0xff;
 		c->x86_phys_bits = eax & 0xff;
+
+		/* Provide a sane default if not enumerated: */
+		if (!c->x86_clflush_size)
+			c->x86_clflush_size = 32;
 	} else {
 		if (IS_ENABLED(CONFIG_X86_64)) {
 			c->x86_clflush_size = 64;
_

