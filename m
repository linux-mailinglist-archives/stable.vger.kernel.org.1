Return-Path: <stable+bounces-136640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9A7A9BB60
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 01:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97171BA2C1A
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 23:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF57F288C8D;
	Thu, 24 Apr 2025 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFuCr5ug"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90754223DDF
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745537724; cv=none; b=eWE+gn/2LY2vojYE3waI4DQBZYjOKvds7OeY4Ef1MJD2tn9NKreFvTVF0sb4lqolh8C9ZhjPFXErs8BLoJPbYpamMlM7kG8EhJ1PEKLPir8wFwVnwjWqATVjvYzmp23se5hH8LCQTXS6+6GiI3ite5l4NOWORI0V1igMy9sEZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745537724; c=relaxed/simple;
	bh=AJmix0PsfvPNJ4VsR4xGBp/jHApNt7wMcIBJ0cO/5jk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ccuHAH8Uu2YcmSu74wP1GfhH4Ofs9rA37nRjVGZ79pcEkdvIt2GdwspMc4wT6n/o31k5hCwe9LI+P7M/iRfXQ8qbzwxKjhzgFdXxsgF6ZxAVOg4GASanHBAMW4mSbTMa6uEd3ARQcl3VcUB3aA8spzWuTOzQQ3iNLXreORJzjN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFuCr5ug; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745537723; x=1777073723;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AJmix0PsfvPNJ4VsR4xGBp/jHApNt7wMcIBJ0cO/5jk=;
  b=lFuCr5ugd9veJ6JDm2DL1DMA1PwIWm5ohdYdwVfrOoawx3R6jIEUN9b6
   X7vSDJozzqfDtqKRMcyRUjxM2sRP6c0XfwQ2NY4xCNMUlRaLWibdgmwlY
   3cyuhE3fOPbv5sAZPctqWoaAkeDqJR4/U8EcP7J7yBsWlHi2mBCDBNfpp
   0vWrXoDbo505d485wVd9N5S7GnXGaMgYNurYg0nEs2qCPbI3TDEHVsb6e
   xPh1MHckXe4zMCiGMO1a4qjn8CYrf/8wFDqOrBQhRPxQ9qTT49GdxisHm
   bk+Qf4ObShIGPeBO5OGp9jcBsRvHuTzL8h0qrh9NbHnwHrkUol2d5PrFT
   A==;
X-CSE-ConnectionGUID: MmMVwk4ERhWbz+zJxQg2Hg==
X-CSE-MsgGUID: Q68jQ+4xQH6vDGdinBE2DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="57391450"
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="57391450"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 16:35:22 -0700
X-CSE-ConnectionGUID: ZN1JpK0iTsqy0F3xIJOREg==
X-CSE-MsgGUID: F+ZSC1bHQIqzSMEcueRFcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="137596446"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 24 Apr 2025 16:35:22 -0700
From: kan.liang@linux.intel.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 5.10.y] perf/x86/intel/uncore: Fix the scale of IIO free running counters on SNR
Date: Thu, 24 Apr 2025 16:35:01 -0700
Message-Id: <20250424233501.676485-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 96a720db59ab330c8562b2437153faa45dac705f ]

(The existing patch in queue-5.10 was wrong.
queue-5.10/perf-x86-intel-uncore-fix-the-scale-of-iio-free-running-counters-on-snr.patch
It's supposed to change the array snr_uncore_iio_freerunning_events[]
rather than icx_uncore_iio_freerunning_events[]. Send the patch to
replace the wrong one.
With this fix the https://lore.kernel.org/stable/2025042139-protector-rickety-a72d@gregkh/
can be applied then.)

There was a mistake in the SNR uncore spec. The counter increments for
every 32 bytes of data sent from the IO agent to the SOC, not 4 bytes
which was documented in the spec.

The event list has been updated:

  "EventName": "UNC_IIO_BANDWIDTH_IN.PART0_FREERUN",
  "BriefDescription": "Free running counter that increments for every 32
		       bytes of data sent from the IO agent to the SOC",

Update the scale of the IIO bandwidth in free running counters as well.

Fixes: 210cc5f9db7a ("perf/x86/intel/uncore: Add uncore support for Snow Ridge server")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250416142426.3933977-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index ad084a5a1463..dd70a6b7879b 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4487,28 +4487,28 @@ static struct uncore_event_desc snr_uncore_iio_freerunning_events[] = {
 	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
 	/* Free-Running IIO BANDWIDTH IN Counters */
 	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=0xff,umask=0x24"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=0xff,umask=0x25"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=0xff,umask=0x26"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=0xff,umask=0x27"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
 	{ /* end: all zeroes */ },
 };
-- 
2.38.1


