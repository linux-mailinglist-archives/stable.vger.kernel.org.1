Return-Path: <stable+bounces-83503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED3399AEEE
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 00:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 338C9B21648
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 22:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2981D3561;
	Fri, 11 Oct 2024 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cc0vY/LE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0871CF5E9
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687316; cv=none; b=tWXZnARttBd4CPNT8DobplTxDN1+2TYFITp28zdIVCj/a4DjejgR512+Jb6Md3fOp2a8URJXxcP5asOu2Er/vL+abUROoU2744JPHJCVj9YMqcNm/9iiQ3tRkIazL2teaxs5P6KuRGA0riPqE7xKmkWVGRbBUuP9BoermV3yJbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687316; c=relaxed/simple;
	bh=JiwuPzjgKOW+98aSOHdvXirT8c2zPb6r2BSYy66ajaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfXbSzMkr5M3JfZdE/en+CtaY10WS6WJAuxU+FAFxVEZz9y7O/Bkz+RRDfynG+5uIvDsMJIEaq+IsXDQyi294z3kAIqXJnA51LD1ctLosRkcpOJ8iA/XzfV92l8w9w5kYcUGV4QEnZe8kKE/08adicvFXxoM2E343xDManKPKMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cc0vY/LE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728687313; x=1760223313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JiwuPzjgKOW+98aSOHdvXirT8c2zPb6r2BSYy66ajaA=;
  b=Cc0vY/LEIwDXaZTRqZXSFKxQhUVAv0O3O+TNQ8GIlP2VjF8M9jRSm4tB
   bYGHcpCNdT+i8lyMUshyK39UXJ1kJ2Wav5wbJLyVP30W4eDrzy+TwIs14
   niKSjn2Obdxb4wRe/YFjkE5oGE8i8o81/536C9NOpfEWwAw1vcpeBj1Kx
   Yx5n8L+HATzLpcLRy8o85UYKmNn+NHUM0x+Cy8SqsRl+th5VH4/n0Lne5
   0D2lfLPEnQk54hEnwLs7vkVg3xPCkJ3o8wBbiBSEGj8/5p+F5Y2KFelrd
   FX9336hpgS/2KMlc6TLD4Cr3aYCxtiZfcercJ4LkvThgZ1B/N6w0cCOEW
   g==;
X-CSE-ConnectionGUID: lxdGYKosQdiIu7uz8xUDqg==
X-CSE-MsgGUID: E9Uzv12hQmSMDEXm7MV4Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53519750"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="53519750"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 15:55:13 -0700
X-CSE-ConnectionGUID: Y7C13T72STSMZ8qD41yjrA==
X-CSE-MsgGUID: kst7psRUTM+NYYIBoLTDGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77040410"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 15:55:13 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/8] drm/i915/pmu: Fix crash due to use-after-free
Date: Fri, 11 Oct 2024 15:54:25 -0700
Message-ID: <20241011225430.1219345-4-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011225430.1219345-1-lucas.demarchi@intel.com>
References: <20241011225430.1219345-1-lucas.demarchi@intel.com>
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

(c) is only done to have a flag to avoid some function entrypoints when
pmu is unregistered.

Cc: stable@vger.kernel.org # 5.11+
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/i915_pmu.c | 36 ++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 4d05d98f51b8e..dc9f753369170 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -515,15 +515,6 @@ static enum hrtimer_restart i915_sample(struct hrtimer *hrtimer)
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
@@ -629,11 +620,6 @@ static int i915_pmu_event_init(struct perf_event *event)
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
@@ -1154,6 +1158,8 @@ static void free_pmu(struct drm_device *dev, void *res)
 	struct i915_pmu *pmu = res;
 	struct drm_i915_private *i915 = pmu_to_i915(pmu);
 
+	perf_pmu_free(&pmu->base);
+
 	free_event_attributes(pmu);
 	kfree(pmu->base.attr_groups);
 	if (IS_DGFX(i915))
@@ -1299,6 +1305,8 @@ void i915_pmu_register(struct drm_i915_private *i915)
 	pmu->base.stop		= i915_pmu_event_stop;
 	pmu->base.read		= i915_pmu_event_read;
 	pmu->base.event_idx	= i915_pmu_event_event_idx;
+	pmu->base.get		= i915_pmu_get;
+	pmu->base.put		= i915_pmu_put;
 
 	ret = perf_pmu_register(&pmu->base, pmu->name, -1);
 	if (ret)
-- 
2.47.0


