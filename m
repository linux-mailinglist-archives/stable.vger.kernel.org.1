Return-Path: <stable+bounces-25702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF9686D7CF
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 00:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5C228546E
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 23:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A4F44376;
	Thu, 29 Feb 2024 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A61VY9a1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD125765
	for <stable@vger.kernel.org>; Thu, 29 Feb 2024 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249354; cv=none; b=b7Oq9GUSWiPauqYDE98qQ85VTLJToFOBXSsuIdoDtGQzjFMyqt8R7YehAMMeguqfeIaPjfOkwoahNust6/NPni811fqXzJTX0TaCojkZ069o9T9W/JvcdlMagSEVngbggPtvpl8UvVfJ1pfCjcOKuYG45dNBXWdoc19tH3ODg5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249354; c=relaxed/simple;
	bh=+bA01XdC0cIkAiSG74UJpDn5jpqKv7/AKErJHNqRmU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeq6OsIcsnFShtB2QZ5zciwNxwnL7aqAaD/knXCjAyIID2Eg0ujS2QoqZzcqJLclA8bERW3kCM7nbQJW8kn19mN1k0sIY9L8RU2WI8/04DVLFHR4TpusueYQCSui7bqeQlUtUaZpZTo4DJeXZ1grYtStr/7pW8dATqiKkxQVxRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A61VY9a1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709249352; x=1740785352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+bA01XdC0cIkAiSG74UJpDn5jpqKv7/AKErJHNqRmU4=;
  b=A61VY9a1BNnwBvfsjKJSRzhdJIqF5K12FZI7YYEhy+KmLAK+RfFuA59Y
   ASxp8/RV74phiC/VxTtPpvBPv+tm+4vuAHavKXiLhSoyLTLm2SzZHLVYD
   vsHqz1nrvYyxYouhCKAdo4PyYSOZdps6xlBNFbBEqSpFMLK3Qn7/WB4ai
   jIU4j/GOAftyMG/pjFsvbP3DgNmmGkM7nr7XXBtjHajl9/euK38s8bQkN
   Pe4nVIQBvcPC1dbVm8zpBqkXNJxY2szi1U5TqYXrPM8AO2PtIgTJj7p7Y
   NrLGuzx7qDTIV1vWhr3zPRuF01SOd8Qp4slEcyI1TekT5MyhbMdL/COid
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="29193385"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="29193385"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 15:29:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="38836012"
Received: from syhu-mobl2.ccr.corp.intel.com (HELO intel.com) ([10.94.248.193])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 15:29:09 -0800
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
	Andi Shyti <andi.shyti@kernel.org>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH v3 1/4] drm/i915/gt: Refactor uabi engine class/instance list creation
Date: Fri,  1 Mar 2024 00:28:56 +0100
Message-ID: <20240229232859.70058-2-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229232859.70058-1-andi.shyti@linux.intel.com>
References: <20240229232859.70058-1-andi.shyti@linux.intel.com>
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
---
 drivers/gpu/drm/i915/gt/intel_engine_user.c | 29 ++++++++++++---------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_user.c b/drivers/gpu/drm/i915/gt/intel_engine_user.c
index 833987015b8b..cf8f24ad88f6 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_user.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_user.c
@@ -203,7 +203,7 @@ static void engine_rename(struct intel_engine_cs *engine, const char *name, u16
 
 void intel_engines_driver_register(struct drm_i915_private *i915)
 {
-	u16 name_instance, other_instance = 0;
+	u16 class_instance[I915_LAST_UABI_ENGINE_CLASS + 1] = { };
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


