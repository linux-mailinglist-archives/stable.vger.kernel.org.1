Return-Path: <stable+bounces-91720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623039BF682
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 20:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D24CEB23912
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 19:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FF1199247;
	Wed,  6 Nov 2024 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOQ5VB7T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7917B4FF;
	Wed,  6 Nov 2024 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921476; cv=none; b=sPTmSOBYLFm5ib+zitqOelUynt2iz8uL9LB+5mPFwYcEQK9XCdQ1kwmoZki4SOIxqaMrRzVQyHwoRnp4pcp8IY7N9/SPdZX+Wk1v+TlGAs0afowO6c2DwCMWnVnHI9kE0ww1YQyhMgXhbBDn2xiCFeYLhktiClAge5d5LEQOIZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921476; c=relaxed/simple;
	bh=x3k5T9tm1IL41huMBWQShiLEM3JxmfzJI2hNeRps8g8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m3X27mx9lFForPPF3dZ3Sq2sNkGFTkGw/ad4W3OVEtvTmSgNDMAQxMgLshnl7fK/Gqk16BiFTQLiblHf2M9sr3CYWTbp7Ojh9eqwYDRWbB9+SMyNf0lebIfQ+i+g2i/eNln+iYGIInsbavxyQ/Gdqx3fEjGGooznDJkVhh3gbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOQ5VB7T; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730921475; x=1762457475;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x3k5T9tm1IL41huMBWQShiLEM3JxmfzJI2hNeRps8g8=;
  b=NOQ5VB7ToXt0j2KW/I/pshdWgFzMcrOKn6EgoOjAioKKtFlUR2VIZZB2
   03PDADha5OGiRTcpd2npl+VFqC7yA7Y2CHCB//ii0EKqcXDOxFyWd8GOn
   PRz5DMHpiAyrRXKkVikzhs6UDesY4s+m4lI2T0RTBd4urAPikOT1v88hO
   jZ5uBn3gIQTFtPpEpRXphrILCvLkwbd/ekf44lcuk+RWcS2L3LwNdisbr
   gdouSr4Z2yBgDEhnc9UfG2DXok4bjAramfMhX9wTe3K98LlDzqhd6vTfz
   3X+LiyUxTQ5Zt/oGMfrAfmMIKyfGnO230pkAfeUNCY+VTgzncweTk34Ze
   A==;
X-CSE-ConnectionGUID: bh/1N4VuS/qrxWPV4tM67A==
X-CSE-MsgGUID: pIiSvpkITdqf1mpxo7he9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30920184"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30920184"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 11:31:14 -0800
X-CSE-ConnectionGUID: tP7qi/7dTHy6W4OMrTCGEw==
X-CSE-MsgGUID: wL27oUjmTra/lpWEvNHoHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="89505903"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 06 Nov 2024 11:31:13 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel: Fix bitmask of OCR and FRONTEND events for LNC
Date: Wed,  6 Nov 2024 11:32:14 -0800
Message-Id: <20241106193214.358984-1-kan.liang@linux.intel.com>
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


