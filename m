Return-Path: <stable+bounces-104375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C0D9F3530
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 17:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AF4188A6A7
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFBB19DF8D;
	Mon, 16 Dec 2024 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXfopvWT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0CB154BFE;
	Mon, 16 Dec 2024 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364936; cv=none; b=e/QEYsty/46ldWK1Lt7rFlYq+A4s7MFwchbIy4TsoXFoeRkjXQZ1VJtVkGsotFSdvlZgOjX8yxRh5R2+KJTawXywc4rnpUrCLzs2Okl20AGiW6U1A2IptWnfEDlgy6SeYOE5BEsGM+8HZPo6xUuzmPz2DQ/gH1WF6BoTPtxKSSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364936; c=relaxed/simple;
	bh=x3k5T9tm1IL41huMBWQShiLEM3JxmfzJI2hNeRps8g8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SMWfdN8U8/f32q332DZzZ7ksFXmHsg2vwHl3mhfNBrBwRf6c2+iNn6ClvbtELuRqv2R9WZDmctQyi5gqmDMPxUDEp5eloznD9Hw+wRYmIma6Q7Mz8EEkKl94iL/zZ7xzoBAHHkiuUISs+LO++6En8L2kdVgsFAXJZ+jBQr8gWBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXfopvWT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734364935; x=1765900935;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x3k5T9tm1IL41huMBWQShiLEM3JxmfzJI2hNeRps8g8=;
  b=DXfopvWT9jKoQQRl2jA6CWjxz8LfrJF7wkcPUyxUvcqTrgNGLlFGMOi/
   zNqK4ZbpBrl7kyzGXoih6M27w0RZ70/m1naU9N7JwqEDg/xLs78uvM8NH
   IZ69p1k61xU7ChDdeIv9yLFkJKY/IsjKnjQU9f5Xfh9PhcvLIXbeEx7M+
   rAEeXLZnAy8BOQ+mTOmRh4taOxNHsz8igvQHgtSlk/piWM6aAjdvDr6jS
   Wt8UQVOfxIwWBYWJvT7r6F/eLvEVXoSFMZ8o92pF+lAcNKOzKfG5g4uTK
   pZSuez9YFtCQ/Tu524pi17TctNdGzKL6Bwfr1lQJt+FuN0OFEImivKBEi
   g==;
X-CSE-ConnectionGUID: MP4CcXEKRnGYxwseCxrkSw==
X-CSE-MsgGUID: 5VGYnxT6QvOYesbVkPGTJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34983955"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="34983955"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 08:02:14 -0800
X-CSE-ConnectionGUID: JB38FruOQe6HRzMTL2YF2g==
X-CSE-MsgGUID: 5RkYdeyQR628JKX+z5APdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134579324"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa001.jf.intel.com with ESMTP; 16 Dec 2024 08:02:14 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	stable@vger.kernel.org
Subject: [RESEND PATCH] perf/x86/intel: Fix bitmask of OCR and FRONTEND events for LNC
Date: Mon, 16 Dec 2024 08:02:52 -0800
Message-Id: <20241216160252.430858-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The released OCR and FRONTEND events utilized more bits on Lunar Lake
p-core. The corresponding mask in the extra_regs has to be extended to
unblock the extra bits.

Add a dedicated intel_lnc_extra_regs.

Fixes: a932aa0e868f ("perf/x86: Add Lunar Lake and Arrow Lake support")
Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bb284aff7bfd..a347b4323256 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -429,6 +429,16 @@ static struct event_constraint intel_lnc_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+static struct extra_reg intel_lnc_extra_regs[] __read_mostly = {
+	INTEL_UEVENT_EXTRA_REG(0x012a, MSR_OFFCORE_RSP_0, 0xfffffffffffull, RSP_0),
+	INTEL_UEVENT_EXTRA_REG(0x012b, MSR_OFFCORE_RSP_1, 0xfffffffffffull, RSP_1),
+	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
+	INTEL_UEVENT_EXTRA_REG(0x02c6, MSR_PEBS_FRONTEND, 0x9, FE),
+	INTEL_UEVENT_EXTRA_REG(0x03c6, MSR_PEBS_FRONTEND, 0x7fff1f, FE),
+	INTEL_UEVENT_EXTRA_REG(0x40ad, MSR_PEBS_FRONTEND, 0xf, FE),
+	INTEL_UEVENT_EXTRA_REG(0x04c2, MSR_PEBS_FRONTEND, 0x8, FE),
+	EVENT_EXTRA_END
+};
 
 EVENT_ATTR_STR(mem-loads,	mem_ld_nhm,	"event=0x0b,umask=0x10,ldlat=3");
 EVENT_ATTR_STR(mem-loads,	mem_ld_snb,	"event=0xcd,umask=0x1,ldlat=3");
@@ -6422,7 +6432,7 @@ static __always_inline void intel_pmu_init_lnc(struct pmu *pmu)
 	intel_pmu_init_glc(pmu);
 	hybrid(pmu, event_constraints) = intel_lnc_event_constraints;
 	hybrid(pmu, pebs_constraints) = intel_lnc_pebs_event_constraints;
-	hybrid(pmu, extra_regs) = intel_rwc_extra_regs;
+	hybrid(pmu, extra_regs) = intel_lnc_extra_regs;
 }
 
 static __always_inline void intel_pmu_init_skt(struct pmu *pmu)
-- 
2.38.1


