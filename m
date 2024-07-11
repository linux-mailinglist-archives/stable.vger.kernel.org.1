Return-Path: <stable+bounces-59057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655E592DF39
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 06:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2DC1C21CBF
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 04:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5276E29CF0;
	Thu, 11 Jul 2024 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQKr+dHT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC117441E
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720673751; cv=none; b=NL986XTGFi1T8yxEnS7+NaMXvtQsc8x7wso1xTKVHQ3SfxvzFewXJ+FcH2nRok4zJ/1Aul4opkaggLN6POOudhF41GCSxMZY0Y1HsIfSvEHDp+gip1DhIER7acC4LpqLMn0JxoO0vi0Gv5CgBlvQPlkf/HiePXQskCf6Dq8DXXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720673751; c=relaxed/simple;
	bh=/0lBTOC+XozR7hq6QbSIgtUpJiqj6LHeBDiAh2GLgD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rplne31U22xS3eM7MjzoPXa5dJq+FvIaQks4/HsK8ESFJpdl0/9fc3HuorfC/93zVZpCSIO4DAyXZu9zaMB4DhoHRwQdBZCZfBIDdf7Na2tBuzEuv45TOqxXZexORc4XjRm+45dd7ZdV96g3/LTG3Xqxl5RIfwwoyyPDhSSptD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQKr+dHT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720673749; x=1752209749;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/0lBTOC+XozR7hq6QbSIgtUpJiqj6LHeBDiAh2GLgD0=;
  b=OQKr+dHTfT24cuQFUNyfyFeWajiSFofdYCSMQ8mUDq22pmbAhnp5/OdW
   2O52m/H5BgY5DsKH4m1itNlZcs1sBYxam4Yr2MTExRaTWmNMLCkoaPn1c
   E40D8kMpfeaBDoSkxPrXmdmU5Jb6GdIkAN6CawPdqITRIv2Lu5k9QjXAN
   3SMS7gF/9oCab9ExYEc3MVi1nP/TBWh8DYeYLS8sJf5PUJtXfaSbifLER
   6DYzcXMTv+iqEid5mjR7pDKEkTVVjFJ1+An9Bmn19gDGux8xGBdUjr9Bn
   /9ga4ARCNX3zjJ6D/vQb16abgxlR1LRuxNo0EJMm3VqUuOg02gKdjgaUF
   A==;
X-CSE-ConnectionGUID: GPDEBPcpRl2CFxhkjE5eAg==
X-CSE-MsgGUID: 2ZmtYiJMR0qWXkEDB8OOyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="28625534"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="28625534"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 21:55:48 -0700
X-CSE-ConnectionGUID: vKSWl+xFSHKTRdYCfOKMQA==
X-CSE-MsgGUID: vu2h8A4LQm6iYQb0PopQwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48331962"
Received: from nitin-super-server.iind.intel.com ([10.145.169.70])
  by fmviesa007.fm.intel.com with ESMTP; 10 Jul 2024 21:55:45 -0700
From: Nitin Gote <nitin.r.gote@intel.com>
To: tursulin@ursulin.net,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	andi.shyti@intel.com,
	chris.p.wilson@linux.intel.com,
	nirmoy.das@intel.com,
	janusz.krzysztofik@linux.intel.com,
	nitin.r.gote@intel.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gt: Do not consider preemption during execlists_dequeue for gen8
Date: Thu, 11 Jul 2024 10:42:15 +0530
Message-Id: <20240711051215.1143127-1-nitin.r.gote@intel.com>
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

v2: Simplify can_preemt() function (Tvrtko Ursulin)

Fixes: bac24f59f454 ("drm/i915/execlists: Enable coarse preemption boundaries for gen8")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11396
Suggested-by: Andi Shyti <andi.shyti@intel.com>
Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
CC: <stable@vger.kernel.org> # v5.2+
---
 .../drm/i915/gt/intel_execlists_submission.c    | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index 21829439e686..59885d7721e4 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -294,11 +294,19 @@ static int virtual_prio(const struct intel_engine_execlists *el)
 	return rb ? rb_entry(rb, struct ve_node, rb)->prio : INT_MIN;
 }
 
+static bool can_preempt(const struct intel_engine_cs *engine)
+{
+	return GRAPHICS_VER(engine->i915) > 8;
+}
+
 static bool need_preempt(const struct intel_engine_cs *engine,
 			 const struct i915_request *rq)
 {
 	int last_prio;
 
+	if (!can_preempt(engine))
+		return false;
+
 	if (!intel_engine_has_semaphores(engine))
 		return false;
 
@@ -3313,15 +3321,6 @@ static void remove_from_engine(struct i915_request *rq)
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


