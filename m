Return-Path: <stable+bounces-58742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299D392B9A7
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3971C2244C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3822215958D;
	Tue,  9 Jul 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPwlCK5A"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D315AD8B
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528615; cv=none; b=fR9uhec/YvN+TZ1ESNgWPa34b3m56/cPRCZV9Uzn6vGPz76ZHwMgq9PxQp+tfWyaV244J9M+BVQvVyrguwoYgdfbI1VhvHjYUyKPVAyx/p0scE+Mti+Nn4BiqTEdOOTULCko3cAB1TWb8KJVtPzDfcTkGnW4xgzYlkIs7HLatic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528615; c=relaxed/simple;
	bh=QD16/W+gTAFQtTHcyhUoWKx3JHae4ORgoBXvLF+JsCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FyPiexARKR1LLakcTqmX2hBnbQT9EBC5PcNG6q/YB+5LY80dZqLK1CQVjJHT5+ZDpjdkEmxjIIWzFgDrZclZShDsYu6XnfiFx2nLrFc8XoHMAAjWLlAdy3JVCCYbk8NkjeZ5scmJBBgB0cLLCsET0p14q3zqHtpUnmOM3rRxFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPwlCK5A; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720528614; x=1752064614;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QD16/W+gTAFQtTHcyhUoWKx3JHae4ORgoBXvLF+JsCs=;
  b=gPwlCK5AkO64qV8K/2qya/X3pMFMKLenLy+/51cds5ctJS4Myk148Na8
   1yPSEs5Pkx33YsCR/rB9Y6s6DDN196RG1QBvIaXyR0NwapPMxAA7c+JLn
   D2EWdygIt4S9nVTm9x/agqToDhSgm44IHaUVyK+bBzK/5JWzfdTaPDPLs
   igUSMAY+DX2lhxdAymyKmz/1Vle1Jm0PHa1L5/STtkyjUyVESPcvc+ZKE
   efIGfPjkgmbgtq/BdwPKpIlfWLFp318mWv/1gKDu8WH8494zLf1XRDfPL
   IRRZc5yWKAsH3jsxLU07uWobrG13MnrD58dLcp94dY76LpbVVzAhg1xkr
   Q==;
X-CSE-ConnectionGUID: IVty9rx7SnalVP/Me/G13g==
X-CSE-MsgGUID: W15Iva4sRSSHzaxuQXc2og==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="21547569"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="21547569"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 05:36:53 -0700
X-CSE-ConnectionGUID: Zb6repQVQH639LokAwoWFA==
X-CSE-MsgGUID: x8lnZKcNQbyrXb2xCwItww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="78581940"
Received: from nitin-super-server.iind.intel.com ([10.145.169.70])
  by orviesa002.jf.intel.com with ESMTP; 09 Jul 2024 05:36:50 -0700
From: Nitin Gote <nitin.r.gote@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	andi.shyti@intel.com,
	chris.p.wilson@linux.intel.com,
	nirmoy.das@intel.com,
	janusz.krzysztofik@linux.intel.com,
	nitin.r.gote@intel.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gt: Do not consider preemption during execlists_dequeue for gen8
Date: Tue,  9 Jul 2024 18:23:02 +0530
Message-Id: <20240709125302.861319-1-nitin.r.gote@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We're seeing a GPU HANG issue on a CHV platform, which was caused by
bac24f59f454 ("drm/i915/execlists: Enable coarse preemption boundaries for gen8").

Gen8 platform has only timeslice and doesn't support a preemption mechanism
as engines do not have a preemption timer and doesn't send an irq if the
preemption timeout expires. So, add a fix to not consider preemption
during dequeuing for gen8 platforms.

Also move can_preemt() above need_preempt() function to resolve implicit
declaration of function ‘can_preempt' error and make can_preempt()
function param as const to resolve error: passing argument 1 of
‘can_preempt’ discards ‘const’ qualifier from the pointer target type.

Fixes: bac24f59f454 ("drm/i915/execlists: Enable coarse preemption boundaries for gen8")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11396
Suggested-by: Andi Shyti <andi.shyti@intel.com>
Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
CC: <stable@vger.kernel.org> # v5.2+
---
 .../drm/i915/gt/intel_execlists_submission.c  | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index 21829439e686..30631cc690f2 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -294,11 +294,26 @@ static int virtual_prio(const struct intel_engine_execlists *el)
 	return rb ? rb_entry(rb, struct ve_node, rb)->prio : INT_MIN;
 }
 
+static bool can_preempt(const struct intel_engine_cs *engine)
+{
+	if (GRAPHICS_VER(engine->i915) > 8)
+		return true;
+
+	if (IS_CHERRYVIEW(engine->i915) || IS_BROADWELL(engine->i915))
+		return false;
+
+	/* GPGPU on bdw requires extra w/a; not implemented */
+	return engine->class != RENDER_CLASS;
+}
+
 static bool need_preempt(const struct intel_engine_cs *engine,
 			 const struct i915_request *rq)
 {
 	int last_prio;
 
+	if ((GRAPHICS_VER(engine->i915) <= 8) && can_preempt(engine))
+		return false;
+
 	if (!intel_engine_has_semaphores(engine))
 		return false;
 
@@ -3313,15 +3328,6 @@ static void remove_from_engine(struct i915_request *rq)
 	i915_request_notify_execute_cb_imm(rq);
 }
 
-static bool can_preempt(struct intel_engine_cs *engine)
-{
-	if (GRAPHICS_VER(engine->i915) > 8)
-		return true;
-
-	/* GPGPU on bdw requires extra w/a; not implemented */
-	return engine->class != RENDER_CLASS;
-}
-
 static void kick_execlists(const struct i915_request *rq, int prio)
 {
 	struct intel_engine_cs *engine = rq->engine;
-- 
2.25.1


