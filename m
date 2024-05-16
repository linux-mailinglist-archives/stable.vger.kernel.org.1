Return-Path: <stable+bounces-45326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEDE8C7B71
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 19:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70010B21579
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA00156642;
	Thu, 16 May 2024 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDrB1Gnd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F3A14533D;
	Thu, 16 May 2024 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881187; cv=none; b=gIOziQeMUcSbjoXs2yh5aKb64mEFzhL9O/4gPHURU/7lnjkjkhwamoyDuzFo6GoSjxVXQTPRPICDYT0mLPRT2ns88OgGbfBCn8tyP0at0JX27w9RegtNGak85q0bg6XeFsD6LaXWSef+WP7UohV7llcwK+yRW3kGi6M8kHTwVlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881187; c=relaxed/simple;
	bh=Ih2+B019IWo/SlVm8UkxUi6Qnobr9mo23QA54zfP0TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3MBx1Mk627WNGnxq1ZOHMXJ2fubhyZqCd4eb1y0X7039HPQMQrMOzyCyaX6xUz4FJgjxeNI8iV/p63rExZ5W1Z0B5yNhdT3RfnLfMBUttqdBFHjS+PIDpUBawcodHfd1kLLku2opAYWcZWuUM7aYL92U/cke4yF1tevs/jxo7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDrB1Gnd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715881185; x=1747417185;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ih2+B019IWo/SlVm8UkxUi6Qnobr9mo23QA54zfP0TA=;
  b=DDrB1GndXWCT9JmhCG+s9rbvMxjtBBc1S+NQNv6b9r0Wz17U2XSKaRyi
   0N9AhPFaq4g0h4nfPsuDtiAA1V7rCrmGYvyw+YdoP7A3NE3ugoZpYg/2v
   r6QxkaddiAuIZV/UGdbp2xg8VhgmrSnG6VJKTRx8g0/lnq5nyGMWZgG6R
   FOdibfFB+TxApXdppNXScOmvy+xp9YosNMfTcl6BtkMFNVNSRzuYLOxJV
   i5kMDGa1sNefzUm/MoQXEqJzqgHsfLy97OGmO6mcB3Ij56Oq/krpdx2kr
   D3RjjO04uiQ1jyopdqQNpYcEcdDLSm3U6VXDgICR1tiYttyDSKdzh6xOP
   A==;
X-CSE-ConnectionGUID: RoZQALqvQF6LvC0MrN1sZw==
X-CSE-MsgGUID: BMqKIO3pQqC2mTvYiBPUDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="29518937"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="29518937"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 10:39:45 -0700
X-CSE-ConnectionGUID: jT8Zz+qdSda7PJgRpZIGQA==
X-CSE-MsgGUID: sv+ffuftRNKRBMZxBxaVvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="31513810"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 16 May 2024 10:39:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C22FD136; Thu, 16 May 2024 20:39:40 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Adam Dunlap <acdunlap@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] x86/cpu: Fix boot on Intel Quark X1000
Date: Thu, 16 May 2024 20:39:27 +0300
Message-ID: <20240516173928.3960193-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial change to set x86_virt_bits to the correct value straight
away broke boot on Intel Quark X1000 CPUs (which are family 5, model 9,
stepping 0)

With deeper investigation it appears that the Quark doesn't have
the bit 19 set in 0x01 CPUID leaf, which means it doesn't provide
any clflush instructions and hence the cache alignment is set to 0.
The actual cache line size is 16 bytes, hence we may set the alignment
accordingly. At the same time the physical and virtual address bits
are retrieved via 0x80000008 CPUID leaf.

Note, we don't really care about the value of x86_clflush_size as it
is either used with a proper check for the instruction to be present,
or, like in PCI case, it assumes 32 bytes for all supported 32-bit CPUs
that have actually smaller cache line sizes and don't advertise it.

The commit fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct
value straight away, instead of a two-phase approach") basically
revealed the issue that has been present from day 1 of introducing
the Quark support.

Fixes: aece118e487a ("x86: Add cpu_detect_cache_sizes to init_intel() add Quark legacy_cache()")
Cc: stable@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/cpu/intel.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index be30d7fa2e66..2bffae158dd5 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -321,6 +321,15 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_SYSENTER32);
 #else
+	/*
+	 * The Quark doesn't have bit 19 set in 0x01 CPUID leaf, which means
+	 * it doesn't provide any clflush instructions and hence the cache
+	 * alignment is set to 0. The actual cache line size is 16 bytes,
+	 * hence set the alignment accordingly. At the same time the physical
+	 * and virtual address bits are retrieved via 0x80000008 CPUID leaf.
+	 */
+	if (c->x86 == 5 && c->x86_model == 9)
+		c->x86_cache_alignment = 16;
 	/* Netburst reports 64 bytes clflush size, but does IO in 128 bytes */
 	if (c->x86 == 15 && c->x86_cache_alignment == 64)
 		c->x86_cache_alignment = 128;
-- 
2.43.0.rc1.1336.g36b5255a03ac


