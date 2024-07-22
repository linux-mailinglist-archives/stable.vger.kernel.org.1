Return-Path: <stable+bounces-60717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EB0939520
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 23:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670211C21492
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 21:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF30744C68;
	Mon, 22 Jul 2024 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LT+sorIw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DEF38DC7;
	Mon, 22 Jul 2024 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682425; cv=none; b=J7ykZ/AMFkJDczM2CeqgDNC0OJBHI/mgcKbAn5uFuvIkc/RfGKsEQYQIB91t+iGRPjE8iBLbYWnw/+97LyLCvGK5qbpaY13LHZ7XWN5UqBxoT0PcpSBHSpycVJpuK9EcRjkjV7OjJBVx1u7HLpFfl9lW0OGjHYZrjrAqEii16zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682425; c=relaxed/simple;
	bh=VAfU6gzUiAe44BSUbXq2+RC8Fp/CWug4QPOlPPDUjyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eorxyK/0nrltH9UpYu0y/bXcp6+YU31Tr/tNY4/9ieUuo22fTRza9z8Pl8PfwLNrPm6GhCXap5OGvoJS8VjdAEni+LeGjSPqynBteJhv+pFwYfydyBR+niSw4ure12uoLVoR8c9/lPEXmXSJ5rlR5C0L3nmjSyp17h/kQugC0PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LT+sorIw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721682424; x=1753218424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VAfU6gzUiAe44BSUbXq2+RC8Fp/CWug4QPOlPPDUjyo=;
  b=LT+sorIw30NfqLWihneFKCOGehzfFSCGvB4yHnJ9on3T2rSpijyOtabW
   zxb65JnraTZ6logat6UJO/TQWMgW6RsJ1YSu4m1bSOgehPZOXhPYHcqqh
   SAORWKKfDxrAdAnKRMusvID3wvcYtvQdujNZ3M2+Ddxnz9t7guCpucAzE
   NeK35/vW+9mTV/OAsQJgrvootT8MPoQp7XCKMWw73LlXJl6BJptQDEQKr
   Scn1RUpCEID1Bvc5fcrOKV0p05qsHzCSpQ8/krCuE4wphGIPEDHMvPRoV
   g8B0zMe4Z+mZhI1+c3IpaBHo4UOn7WkePQDBwApw37gzYZmHJEKpQGHDf
   w==;
X-CSE-ConnectionGUID: felPt+bSQWCuDUY0aH9MYA==
X-CSE-MsgGUID: FV1j0LdHQyu+jhupLlNZqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30428296"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="30428296"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:07:01 -0700
X-CSE-ConnectionGUID: DkVx8NGRRuOCzUS/0sNtzQ==
X-CSE-MsgGUID: gWSi5Rj6T3m97o+tGcOgvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="51653288"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:07:00 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: intel-gfx@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/7] drm/i915/pmu: Fix crash due to use-after-free
Date: Mon, 22 Jul 2024 14:06:43 -0700
Message-ID: <20240722210648.80892-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722210648.80892-1-lucas.demarchi@intel.com>
References: <20240722210648.80892-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an i915 PMU counter is enabled and the driver is then unbound, the
PMU will be unregistered via perf_pmu_unregister(), however the event
will still be alive. i915 currently tries to deal with this situation
by:

	a) Marking the pmu as "closed" and shortcut the calls from perf
	b) Taking a reference from i915, that is put back when the event
	   is destroyed.
	c) Setting event_init to NULL to avoid any further event

(a) is ugly, but may be left as is since it protects not trying to
access the HW that is now gone. Unless a pmu driver can call
perf_pmu_unregister() and not receive any more calls, it's a necessary
ugliness.

(b) doesn't really work: when the event is destroyed and the i915 ref is
put it may free the i915 object, that contains the pmu, not only the
event. After event->destroy() callback, perf still expects the pmu
object to be alive.

Instead of pigging back on the event->destroy() to take and put the
device reference, implement the new get()/put() on the pmu object for
that purpose.

(c) is not entirely correct as from the perf POV it's not an optional
call: perf would just dereference the NULL pointer. However this also
protects other entrypoints in i915_pmu. A new event creation from perf
after the pmu has been unregistered should not be possible anyway:
perf_init_event() bails out when not finding the pmu. This may be
cleaned up later.

Cc: <stable@vger.kernel.org> # 5.11+
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/i915_pmu.c | 34 +++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 21eb0c5b320d..cb5f6471ec6e 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -514,15 +514,6 @@ static enum hrtimer_restart i915_sample(struct hrtimer *hrtimer)
 	return HRTIMER_RESTART;
 }
 
-static void i915_pmu_event_destroy(struct perf_event *event)
-{
-	struct i915_pmu *pmu = event_to_pmu(event);
-	struct drm_i915_private *i915 = pmu_to_i915(pmu);
-
-	drm_WARN_ON(&i915->drm, event->parent);
-
-	drm_dev_put(&i915->drm);
-}
 
 static int
 engine_event_status(struct intel_engine_cs *engine,
@@ -628,11 +619,6 @@ static int i915_pmu_event_init(struct perf_event *event)
 	if (ret)
 		return ret;
 
-	if (!event->parent) {
-		drm_dev_get(&i915->drm);
-		event->destroy = i915_pmu_event_destroy;
-	}
-
 	return 0;
 }
 
@@ -872,6 +858,24 @@ static int i915_pmu_event_event_idx(struct perf_event *event)
 	return 0;
 }
 
+static struct pmu *i915_pmu_get(struct pmu *base)
+{
+	struct i915_pmu *pmu = container_of(base, struct i915_pmu, base);
+	struct drm_i915_private *i915 = pmu_to_i915(pmu);
+
+	drm_dev_get(&i915->drm);
+
+	return base;
+}
+
+static void i915_pmu_put(struct pmu *base)
+{
+	struct i915_pmu *pmu = container_of(base, struct i915_pmu, base);
+	struct drm_i915_private *i915 = pmu_to_i915(pmu);
+
+	drm_dev_put(&i915->drm);
+}
+
 struct i915_str_attribute {
 	struct device_attribute attr;
 	const char *str;
@@ -1299,6 +1303,8 @@ void i915_pmu_register(struct drm_i915_private *i915)
 	pmu->base.stop		= i915_pmu_event_stop;
 	pmu->base.read		= i915_pmu_event_read;
 	pmu->base.event_idx	= i915_pmu_event_event_idx;
+	pmu->base.get		= i915_pmu_get;
+	pmu->base.put		= i915_pmu_put;
 
 	ret = perf_pmu_register(&pmu->base, pmu->name, -1);
 	if (ret)
-- 
2.43.0


