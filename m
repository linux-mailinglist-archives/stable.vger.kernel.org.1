Return-Path: <stable+bounces-20816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883AC85BEA8
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4D91F22A6A
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 14:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E197D6F51A;
	Tue, 20 Feb 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIuQOYDu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9B6F063
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438870; cv=none; b=ahf3Z/Ju94EGyjCd1H5SrcL2MEZ7FHspWpwsxTtcYeqfdbc+lw0yUNHLA8Ti/SeIEG3B2XfEK3dkff/8xoixCBJF/5bz7BSBR/IiR/KcohJgWFMz06x2Bya25pugzTpbkKiD53UvX4oPIVZWC79Am0LHQua95oZtodaGIF1eU+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438870; c=relaxed/simple;
	bh=HPtiP7PZxZwC5GGDZKuHaMs0/IGLQ0pcFgPpdFKI2tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdzrbEfK/FFq4kXU5W7tK2z+8GYMbGOr+C4rZgtsyjaCk968BiMyW5Qwzn1rrlxdcRcuBO+MvXHc7Z/TiT2IPV9agVynnhiq+tJPdg5igkdAasEvqHXcvxr3lckIJBYiD3t+AE0XlhETmCrhyZdG4uxNQrKpsZVT0R7IkCuJ04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIuQOYDu; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708438869; x=1739974869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HPtiP7PZxZwC5GGDZKuHaMs0/IGLQ0pcFgPpdFKI2tg=;
  b=SIuQOYDuCLqPU82n0+It/SCumoiYKGEPSpNclL0TTgjfv8tFgsLtHt8s
   LvXSz5+PEhn6HhgGshKq12OFg2vTDcdftYDO4PQwJLvA1o82v9sYUa9oc
   zvOixnsQeGH8FLcPhQh4lmirqeiXHtJMRaD7KxsXAf3Oq+EY79C9KIyPk
   vseX9xbtIfkhU8l1CyfIKtK11pGwbrD/JkVSr4V+ankGkkmGM8MCWPiyg
   dzgAZ1Xb3QrDzydSEqbdJoWqs5PueILmtOg0vtbW8NUK4HLxnOAeQecSf
   vcEysNt8uh7g62r1w3Os/P7LyZrkEUO36lkWiwYqr0Ei5mcBJ9IR/0XBQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2447037"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2447037"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:21:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="42283471"
Received: from alichtma-mobl.ger.corp.intel.com (HELO intel.com) ([10.246.34.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:21:06 -0800
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 1/2] drm/i915/gt: Disable HW load balancing for CCS
Date: Tue, 20 Feb 2024 15:20:33 +0100
Message-ID: <20240220142034.257370-2-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220142034.257370-1-andi.shyti@linux.intel.com>
References: <20240220142034.257370-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware should not dynamically balance the load between CCS
engines. Wa_16016805146 recommends disabling it across all
platforms.

Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: <stable@vger.kernel.org> # v6.2+
---
 drivers/gpu/drm/i915/gt/intel_gt_regs.h     | 1 +
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
index 50962cfd1353..cf709f6c05ae 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1478,6 +1478,7 @@
 
 #define GEN12_RCU_MODE				_MMIO(0x14800)
 #define   GEN12_RCU_MODE_CCS_ENABLE		REG_BIT(0)
+#define   XEHP_RCU_MODE_FIXED_SLICE_CCS_MODE	REG_BIT(1)
 
 #define CHV_FUSE_GT				_MMIO(VLV_GUNIT_BASE + 0x2168)
 #define   CHV_FGT_DISABLE_SS0			(1 << 10)
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index d67d44611c28..7f42c8015f71 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -2988,6 +2988,12 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 		wa_mcr_masked_en(wal, GEN8_HALF_SLICE_CHICKEN1,
 				 GEN7_PSD_SINGLE_PORT_DISPATCH_ENABLE);
 	}
+
+	/*
+	 * Wa_16016805146: disable the CCS load balancing
+	 * indiscriminately for all the platforms
+	 */
+	wa_masked_en(wal, GEN12_RCU_MODE, XEHP_RCU_MODE_FIXED_SLICE_CCS_MODE);
 }
 
 static void
-- 
2.43.0


