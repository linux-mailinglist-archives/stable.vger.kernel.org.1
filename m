Return-Path: <stable+bounces-26896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198AE872C30
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 02:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA16FB2839D
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 01:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE82D51E;
	Wed,  6 Mar 2024 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWSK1Sca"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFDD51D
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 01:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688210; cv=none; b=Ng7Hh+XWyRtRasSIb969V2MMjRTV8jCqvqGJRzmylBKRVDqW6w1Ccs0peEIQ+RFf5PeXjrgEj60EjbnLERByX9jS1k+uAgfkk63KWmpcGkiE6KD3f3CTk74z1CX9JIEjJKGFt8ZqRudfHf4WwzMFLZeFTCawHdu1t8MIDM7gqJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688210; c=relaxed/simple;
	bh=ecdZVCYFIQKJ7XYWiZumdnMJJ0H31nX8duv0O4f5jPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhWVXmFomleo/FTtdliQbOEJLjvHDlg8UlMI55vNgZjMHpyesZ6J0++WczBuXRTqYTwBLZh6Y8Pe67i6VUj9wzja+PO7A1BW314yEl6wX80t7Iqpn49PGH53THbbgSDG8HVQm0jDMhIGFNvatAnJF8S6eNC5jjEAzqMlwy/9RNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWSK1Sca; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709688209; x=1741224209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ecdZVCYFIQKJ7XYWiZumdnMJJ0H31nX8duv0O4f5jPg=;
  b=bWSK1Sca9C1KNT+kdPTJVKbSzRLqWo0pw8yhXBsLXumzODAxa8SmzUAA
   RwrGcD6Qh+Kbung6WcbnUz5epO0pfHq53nwwXRl9ap3mt4UK2nwE/v9fs
   Es+G78wgbfbnmbdUZQFoOtFXIPOpl6S/fo+uGTFhmal+J7MHcyTR6yIUV
   pc/Npn6/Pd7815aN73l+q0fMrxk2P3IbwDRa6Iu148n3TJtr+7XpT0H4g
   lPCWDBwIYXmozZfXYv0joDA2J1ZPgrhZmcFlYRInlwlSfdLPAFbtJpR5+
   L2hrMmEPazaJcFbiF1BX9X3/mpeoDz+G2NOH1LYoBhw2qxCCVsNv6CWpd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="8098445"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="8098445"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 17:23:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="40574384"
Received: from unknown (HELO intel.com) ([10.247.118.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 17:23:22 -0800
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH v4 2/3] drm/i915/gt: Refactor uabi engine class/instance list creation
Date: Wed,  6 Mar 2024 02:22:46 +0100
Message-ID: <20240306012247.246003-3-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306012247.246003-1-andi.shyti@linux.intel.com>
References: <20240306012247.246003-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the upcoming changes we need a cleaner way to build the list
of uabi engines.

Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.2+
---
 drivers/gpu/drm/i915/gt/intel_engine_user.c | 29 ++++++++++++---------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_user.c b/drivers/gpu/drm/i915/gt/intel_engine_user.c
index 833987015b8b..11cc06c0c785 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_user.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_user.c
@@ -203,7 +203,7 @@ static void engine_rename(struct intel_engine_cs *engine, const char *name, u16
 
 void intel_engines_driver_register(struct drm_i915_private *i915)
 {
-	u16 name_instance, other_instance = 0;
+	u16 class_instance[I915_LAST_UABI_ENGINE_CLASS + 2] = { };
 	struct legacy_ring ring = {};
 	struct list_head *it, *next;
 	struct rb_node **p, *prev;
@@ -214,6 +214,8 @@ void intel_engines_driver_register(struct drm_i915_private *i915)
 	prev = NULL;
 	p = &i915->uabi_engines.rb_node;
 	list_for_each_safe(it, next, &engines) {
+		u16 uabi_class;
+
 		struct intel_engine_cs *engine =
 			container_of(it, typeof(*engine), uabi_list);
 
@@ -222,15 +224,14 @@ void intel_engines_driver_register(struct drm_i915_private *i915)
 
 		GEM_BUG_ON(engine->class >= ARRAY_SIZE(uabi_classes));
 		engine->uabi_class = uabi_classes[engine->class];
-		if (engine->uabi_class == I915_NO_UABI_CLASS) {
-			name_instance = other_instance++;
-		} else {
-			GEM_BUG_ON(engine->uabi_class >=
-				   ARRAY_SIZE(i915->engine_uabi_class_count));
-			name_instance =
-				i915->engine_uabi_class_count[engine->uabi_class]++;
-		}
-		engine->uabi_instance = name_instance;
+
+		if (engine->uabi_class == I915_NO_UABI_CLASS)
+			uabi_class = I915_LAST_UABI_ENGINE_CLASS + 1;
+		else
+			uabi_class = engine->uabi_class;
+
+		GEM_BUG_ON(uabi_class >= ARRAY_SIZE(class_instance));
+		engine->uabi_instance = class_instance[uabi_class]++;
 
 		/*
 		 * Replace the internal name with the final user and log facing
@@ -238,11 +239,15 @@ void intel_engines_driver_register(struct drm_i915_private *i915)
 		 */
 		engine_rename(engine,
 			      intel_engine_class_repr(engine->class),
-			      name_instance);
+			      engine->uabi_instance);
 
-		if (engine->uabi_class == I915_NO_UABI_CLASS)
+		if (uabi_class > I915_LAST_UABI_ENGINE_CLASS)
 			continue;
 
+		GEM_BUG_ON(uabi_class >=
+			   ARRAY_SIZE(i915->engine_uabi_class_count));
+		i915->engine_uabi_class_count[uabi_class]++;
+
 		rb_link_node(&engine->uabi_node, prev, p);
 		rb_insert_color(&engine->uabi_node, &i915->uabi_engines);
 
-- 
2.43.0


