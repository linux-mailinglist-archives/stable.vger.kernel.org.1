Return-Path: <stable+bounces-132864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF2AA90683
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E94F8A4A56
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA92B1B0414;
	Wed, 16 Apr 2025 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpLhiQQz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B49156F20;
	Wed, 16 Apr 2025 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813498; cv=none; b=bnV94kBqx8+0I0oQSA24f/P0fm85SrEQoka/iy3U+INCDX7/SvLXx1npZrOkzpxpGMrz3NiKi+g8seNfLPRRT4kW/WbvD6nEFQ3pGrMTsCsWFqQmcB2/mOWrA2uRUQ02a7DepG7BHkAskPq9QKrX1z6fAazEjYgGRz4jRnB1zkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813498; c=relaxed/simple;
	bh=tA8sXd4VE4qWzGSwlTA/nW94dwKfR/DWTKT7Z8ahn1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SSl3D7LBkGDNgGnPgOwRRSY6q2oNZh6hsh7qS+uMyZzTvV6DwdoLZD92qyemPMXFOv+ReM+0M1sBJ6XEQkuSiIVbDKgoiOv/LqoiWdO25BNBukmL996yrKhrjoUQNqnpJmdMm/WTuuoNgNBAcaGxJAGvJUI1EgbZLqTNA1ACyiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpLhiQQz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744813497; x=1776349497;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tA8sXd4VE4qWzGSwlTA/nW94dwKfR/DWTKT7Z8ahn1s=;
  b=lpLhiQQzBIih/o3Lnep7T6JLCQDd0wECeMmLhkTKJji3JtuGlUurJO2B
   v3WMdZJBU4Pandnbk7UxGwtnDJsbsFTeir1BPLM+iNlO8PbxII+EElBdq
   Zni9M7Ea4XcvlhxI8nrSg1Y9Ick9hpCZioeEar9chdIYvoISdfH0LqxAr
   GEZwUlGzRNzgRibswR8fzWhbDY8taFK1BJ0jSk3pui+KpowNKSA6q3oO9
   zfu7eFvlmSb2IAQYVEn7vz1zVdv+YFdNmEtMXck1KLNJbfxK/3p6wOy3q
   ZVm6MU8BmDR3xUdpqsaAy3DYHxBb4QOjTjhsuwKbE/0ApM9fsOx8p+hrL
   g==;
X-CSE-ConnectionGUID: mcbSyu3bQOWInbuZBESZmA==
X-CSE-MsgGUID: GhXN/oiYRsKfsvi0vz332Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46529290"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="46529290"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 07:24:56 -0700
X-CSE-ConnectionGUID: BoS7IenlQLqQpcDv6hKlew==
X-CSE-MsgGUID: WYDzFqC3SqqdEZGlmM4AwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="131402414"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa009.fm.intel.com with ESMTP; 16 Apr 2025 07:24:56 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: eranian@google.com,
	ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] perf/x86/intel/uncore: Fix the scale of IIO free running counters on SNR
Date: Wed, 16 Apr 2025 07:24:24 -0700
Message-Id: <20250416142426.3933977-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

There was a mistake in the SNR uncore spec. The counter increments for
every 32 bytes of data sent from the IO agent to the SOC, not 4 bytes
which was documented in the spec.

The event list has been updated.
"EventName": "UNC_IIO_BANDWIDTH_IN.PART0_FREERUN",
"BriefDescription": "Free running counter that increments for every 32
		     bytes of data sent from the IO agent to the SOC",

Update the scale of the IIO bandwidth in free running counters as well.

Fixes: 210cc5f9db7a ("perf/x86/intel/uncore: Add uncore support for Snow Ridge server")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/uncore_snbep.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 60973c209c0e..35da2c486e8d 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4891,28 +4891,28 @@ static struct uncore_event_desc snr_uncore_iio_freerunning_events[] = {
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


