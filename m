Return-Path: <stable+bounces-4951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B870480916A
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 20:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56390B20C10
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 19:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB74F886;
	Thu,  7 Dec 2023 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqdh80n7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4711D
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 11:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701977688; x=1733513688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x7JwbeZlmAnu+J4sqBwbzQ1kQYquGiO7GpVgmC4HGRY=;
  b=eqdh80n7Mk+Mg+DmbBnmYUVE3w2HIUGBqxkmHArRkNDOmTjhJ/740dd8
   nJNqK4nIJUUrhtLzfspngWUcGf8I9xGa+RqXBQNPo9eDtcCInsHn5mpvj
   e8XRNcx8IdotIwBh7iDPoY8FEidVzCjMK1VaDCdV22Io+jyTpp7ALh0mG
   rudLDQen8A93PbC0W4SzzfWU2OEqCFXqhuRkI4CyN6WN4hcvPtvpexzFC
   7YUSmKPJzris+falxy1/q64R3K79+f6JU4tJDuzgswFeOmsVjZulVTOun
   eNYiyAzxhq55l07hv6IPaheRKRys1J4I0iV4br2OJU+xJrkLLlvVchZ3y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="384694336"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="384694336"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:34:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="765213022"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="765213022"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 07 Dec 2023 11:34:45 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 07 Dec 2023 21:34:44 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/8] drm/i915: Fix intel_atomic_setup_scalers() plane_state handling
Date: Thu,  7 Dec 2023 21:34:34 +0200
Message-ID: <20231207193441.20206-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231207193441.20206-1-ville.syrjala@linux.intel.com>
References: <20231207193441.20206-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Since the plane_state variable is declared outside the scaler_users
loop in intel_atomic_setup_scalers(), and it's never reset back to
NULL inside the loop we may end up calling intel_atomic_setup_scaler()
with a non-NULL plane state for the pipe scaling case. That is bad
because intel_atomic_setup_scaler() determines whether we are doing
plane scaling or pipe scaling based on plane_state!=NULL. The end
result is that we may miscalculate the scaler mode for pipe scaling.

The hardware becomes somewhat upset if we end up in this situation
when scanning out a planar format on a SDR plane. We end up
programming the pipe scaler into planar mode as well, and the
result is a screenfull of garbage.

Fix the situation by making sure we pass the correct plane_state==NULL
when calculating the scaler mode for pipe scaling.

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/skl_scaler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/skl_scaler.c b/drivers/gpu/drm/i915/display/skl_scaler.c
index 1e7c97243fcf..8a934bada624 100644
--- a/drivers/gpu/drm/i915/display/skl_scaler.c
+++ b/drivers/gpu/drm/i915/display/skl_scaler.c
@@ -504,7 +504,6 @@ int intel_atomic_setup_scalers(struct drm_i915_private *dev_priv,
 {
 	struct drm_plane *plane = NULL;
 	struct intel_plane *intel_plane;
-	struct intel_plane_state *plane_state = NULL;
 	struct intel_crtc_scaler_state *scaler_state =
 		&crtc_state->scaler_state;
 	struct drm_atomic_state *drm_state = crtc_state->uapi.state;
@@ -536,6 +535,7 @@ int intel_atomic_setup_scalers(struct drm_i915_private *dev_priv,
 
 	/* walkthrough scaler_users bits and start assigning scalers */
 	for (i = 0; i < sizeof(scaler_state->scaler_users) * 8; i++) {
+		struct intel_plane_state *plane_state = NULL;
 		int *scaler_id;
 		const char *name;
 		int idx, ret;
-- 
2.41.0


