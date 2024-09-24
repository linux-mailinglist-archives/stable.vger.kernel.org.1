Return-Path: <stable+bounces-77002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 744549848B7
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 17:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A73C1F23A7E
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832251A76A5;
	Tue, 24 Sep 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ccYg9uXq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDCA1AB6D8
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191832; cv=none; b=fLl7l1FxHfWrGmLWhsLm4WqcZSKkhOpImfkXrRhfSFiHvcVod0DHpzcqsW3zhfuY0/oVcKQKZpxeElVgnVs7k9D6JelAq2Db0z9AhBtz58oZaXXignBX3xg5MvvpMNNk3mTfLKC7BvrC5ocz5ZjEVNTnxWyvp8GtlOmS9bOQRXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191832; c=relaxed/simple;
	bh=g2jlVVm2KKdyQP7qu5G8AnJ8GI8bsFkMhfe7xGywr+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IuKZEORXXzUPe3/cTR3DbsF5IBoCd2INt/Pyh3hhXFDT2n77rZ2CDCVnnQ8I/++SmvUsklTHyXVwDwUPxVG2jOyRCn8VaNv0QDskewo3pU4Ra3cdbsIG9LDGNJoElihJ9ENa7BIkNJ6CnjRuD5UzQL2jnC932V4ct4HQOzJNr1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ccYg9uXq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727191830; x=1758727830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g2jlVVm2KKdyQP7qu5G8AnJ8GI8bsFkMhfe7xGywr+A=;
  b=ccYg9uXqiXpXY1d2KnJWyArzW1d9Unj+X9RKn+azSdGMjW/ArLKMV3qy
   fi7kbW2oBoBwKynYqI0LeJo1DpzjEnfXuZtLEIGx1jr5lBP2AStW8UyH8
   Pz2TBHZKDACD81xgG7q+Ct6JtYjBFZBSv4guqeD+oug+6vTGWr7aIY1wE
   iTGb3Ft647jL2lySLIb+0X8SrTKVPMQ6SnLSg78msUiURWJHXvmcDEqH4
   39Uu1hvu4JwmgT8yckT9Akkshon0uCn1GMQAkkK+47C0JE+FxmGzpJL57
   gsWj3eSIGmGdVOC6EqNtxo/pPMGW+gU4TqRK2G+0ptysosagdSfB8et7p
   g==;
X-CSE-ConnectionGUID: EKkIy25wSP66UmxQ30S7iw==
X-CSE-MsgGUID: CsdD0IWTSRWwAMLf4Oe/xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26342269"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="26342269"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 08:30:29 -0700
X-CSE-ConnectionGUID: okIg7rJ0SsWykAqkdoK+3A==
X-CSE-MsgGUID: FdwetQDOQU+tTI7AFHXXFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="102214715"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.183])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 08:30:27 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Sean Paul <seanpaul@chromium.org>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/hdcp: fix connector refcounting
Date: Tue, 24 Sep 2024 18:30:22 +0300
Message-Id: <20240924153022.2255299-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

We acquire a connector reference before scheduling an HDCP prop work,
and expect the work function to release the reference.

However, if the work was already queued, it won't be queued multiple
times, and the reference is not dropped.

Release the reference immediately if the work was already queued.

Fixes: a6597faa2d59 ("drm/i915: Protect workers against disappearing connectors")
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.10+
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

---

I don't know that we have any bugs open about this. Or how it would
manifest itself. Memory leak on driver unload? I just spotted this while
reading the code for other reasons.
---
 drivers/gpu/drm/i915/display/intel_hdcp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index 2afa92321b08..cad309602617 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -1097,7 +1097,8 @@ static void intel_hdcp_update_value(struct intel_connector *connector,
 	hdcp->value = value;
 	if (update_property) {
 		drm_connector_get(&connector->base);
-		queue_work(i915->unordered_wq, &hdcp->prop_work);
+		if (!queue_work(i915->unordered_wq, &hdcp->prop_work))
+			drm_connector_put(&connector->base);
 	}
 }
 
@@ -2531,7 +2532,8 @@ void intel_hdcp_update_pipe(struct intel_atomic_state *state,
 		mutex_lock(&hdcp->mutex);
 		hdcp->value = DRM_MODE_CONTENT_PROTECTION_DESIRED;
 		drm_connector_get(&connector->base);
-		queue_work(i915->unordered_wq, &hdcp->prop_work);
+		if (!queue_work(i915->unordered_wq, &hdcp->prop_work))
+			drm_connector_put(&connector->base);
 		mutex_unlock(&hdcp->mutex);
 	}
 
@@ -2548,7 +2550,9 @@ void intel_hdcp_update_pipe(struct intel_atomic_state *state,
 		 */
 		if (!desired_and_not_enabled && !content_protection_type_changed) {
 			drm_connector_get(&connector->base);
-			queue_work(i915->unordered_wq, &hdcp->prop_work);
+			if (!queue_work(i915->unordered_wq, &hdcp->prop_work))
+				drm_connector_put(&connector->base);
+
 		}
 	}
 
-- 
2.39.2


