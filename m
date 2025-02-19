Return-Path: <stable+bounces-118286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEB6A3C1DD
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 15:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F188E3A9F87
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC72E1FDE01;
	Wed, 19 Feb 2025 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSsjidcM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3011D1F30A9;
	Wed, 19 Feb 2025 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739974197; cv=none; b=l005Ln3ybregdTmUpAf1tidEfpJCYDFKp19oEWfhQvwNN1RXH+hjG4Obn/yY50bFvL29IFh/F5KD03t9FA6aSq2TNXecnwkz31WigGgTchVB2mE8kyl9JQYgPyI/p3L7vvFR57SADmDlY1JfGd8ueavWpC4SMKpOnj+5hUKR8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739974197; c=relaxed/simple;
	bh=FmNh8i/+NBQdKhSxJQWTczf6sC4JYYzdaKEbQ/SujWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J5DIQ4NHpsu83y1FyujdNu7GNWMBJ5zI1Wf3gz2BZS0CMkNQqlSrU9j5QSpiSBTA/DUFTb/qBHvk9ym2ERYJKiDpWSn74zUy6zEiYKO9CJUlBSM8TGDqVxjkgN5FhnH9pDbkXW79DYtbOWffFbIGtokOnw9EJskbU2SxN12jojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSsjidcM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739974196; x=1771510196;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FmNh8i/+NBQdKhSxJQWTczf6sC4JYYzdaKEbQ/SujWk=;
  b=SSsjidcMyZQcdGiy48krTE/TXJSb9Xt+ZrL248UBopobKcjA7bO5CFC/
   vWgTUYYxFO90jDB10vzRZ9mg26KBWSYSiBy6+LoRNIYaPDk33JYOMzPq1
   Tw4kqzEB99ChQzMBwr5RfJNdYQElrzMQRFMvuB9EyrPDw1AH3dga2Qr1/
   H3tBTw14qImCEYsD7ZtwFA87FoGKwZ0sD7ZuIOo+V7HY+HcRq52ZE9fw/
   uiw/Y3H+PweDyqA2KxQ5h14QUnnwvFr6/PF+yGCHoIUo8RYMZGXxyZoRR
   IHaMraVHth2ag38kJkRk8WHCbsMZ3HTqf2rIJG0TYlyH9PAmBts9baxzW
   g==;
X-CSE-ConnectionGUID: kXmosbpmS+uWfQaqo/6oWQ==
X-CSE-MsgGUID: zOmLAjNnQDWlgVy+XJD1mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51351222"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="51351222"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 06:09:55 -0800
X-CSE-ConnectionGUID: FHBLuRzJSRSY2NCfTF611Q==
X-CSE-MsgGUID: Y9EvvsvVS0O0u6GzPtvajg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118860004"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa003.fm.intel.com with ESMTP; 19 Feb 2025 06:09:55 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Amiri Khalil <amiri.khalil@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel: Fix event constraints for LNC
Date: Wed, 19 Feb 2025 06:10:05 -0800
Message-Id: <20250219141005.2446823-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

According to the latest event list, update the event constraint tables
for Lion Cove core.

The general rule (the event codes < 0x90 are restricted to counters
0-3.) has been removed. There is no restriction for most of the
performance monitoring events.

Fixes: a932aa0e868f ("perf/x86: Add Lunar Lake and Arrow Lake support")
Reported-by: Amiri Khalil <amiri.khalil@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/core.c | 20 +++++++-------------
 arch/x86/events/intel/ds.c   |  2 +-
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index da70526194b0..051a5bea0568 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -397,34 +397,28 @@ static struct event_constraint intel_lnc_event_constraints[] = {
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FETCH_LAT, 6),
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_MEM_BOUND, 7),
 
+	INTEL_EVENT_CONSTRAINT(0x20, 0xf),
+
+	INTEL_UEVENT_CONSTRAINT(0x012a, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x012b, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x0148, 0x4),
 	INTEL_UEVENT_CONSTRAINT(0x0175, 0x4),
 
 	INTEL_EVENT_CONSTRAINT(0x2e, 0x3ff),
 	INTEL_EVENT_CONSTRAINT(0x3c, 0x3ff),
-	/*
-	 * Generally event codes < 0x90 are restricted to counters 0-3.
-	 * The 0x2E and 0x3C are exception, which has no restriction.
-	 */
-	INTEL_EVENT_CONSTRAINT_RANGE(0x01, 0x8f, 0xf),
 
-	INTEL_UEVENT_CONSTRAINT(0x01a3, 0xf),
-	INTEL_UEVENT_CONSTRAINT(0x02a3, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x08a3, 0x4),
 	INTEL_UEVENT_CONSTRAINT(0x0ca3, 0x4),
 	INTEL_UEVENT_CONSTRAINT(0x04a4, 0x1),
 	INTEL_UEVENT_CONSTRAINT(0x08a4, 0x1),
 	INTEL_UEVENT_CONSTRAINT(0x10a4, 0x1),
 	INTEL_UEVENT_CONSTRAINT(0x01b1, 0x8),
+	INTEL_UEVENT_CONSTRAINT(0x01cd, 0x3fc),
 	INTEL_UEVENT_CONSTRAINT(0x02cd, 0x3),
-	INTEL_EVENT_CONSTRAINT(0xce, 0x1),
 
 	INTEL_EVENT_CONSTRAINT_RANGE(0xd0, 0xdf, 0xf),
-	/*
-	 * Generally event codes >= 0x90 are likely to have no restrictions.
-	 * The exception are defined as above.
-	 */
-	INTEL_EVENT_CONSTRAINT_RANGE(0x90, 0xfe, 0x3ff),
+
+	INTEL_UEVENT_CONSTRAINT(0x00e0, 0xf),
 
 	EVENT_CONSTRAINT_END
 };
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index df9499d6e4dc..a04618c47f05 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1199,7 +1199,7 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
 
-	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0x3ff),
+	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0x3fc),
 	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
-- 
2.38.1


