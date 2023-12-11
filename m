Return-Path: <stable+bounces-5261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 623CF80C2CA
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 09:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03ACF1F20F68
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6474820B26;
	Mon, 11 Dec 2023 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iO8u/E3I"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E08F1
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 00:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702282298; x=1733818298;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3y/6jtPf/sYdDgmZrk2dD62GBVv5VUYMIz3c0DY0yPk=;
  b=iO8u/E3IbNF4KQrnOe2kkGjCxTVRlA1G/aHEcD4ZKe3iRSQquWkil6/C
   qJNSsSQTaUQKv61mv3k7Mc2L1a54Hsa5zW0N18M2X6TJUpEj8NLnFJW9e
   C/H5fPBx4PfpxuSofM6RAT1YbyRkRWFJbRzI9N8sbb+ayEGsqrDc3pG7j
   SZg2hZE6Yr55ct2kzdjLRBpMddQv8dg6jBRas7ptMjoT9NQGKE47qrVGh
   RlowcO47AH1R4DXPsOluUVtvv4ivDWxdODgmazQkvI5u+5XQ5T5mtzZ8F
   OvuOSs2uIAiM6IGm7aIa6DvuXrTLaBmgIYqIZodSdia5Dq3D8Fqp2Te6R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="461088225"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="461088225"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 00:11:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="766284738"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="766284738"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 11 Dec 2023 00:11:35 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 11 Dec 2023 10:11:34 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/i915: Reject async flips with bigjoiner
Date: Mon, 11 Dec 2023 10:11:34 +0200
Message-ID: <20231211081134.2698-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Currently async flips are busted when bigjoiner is in use.
As a short term fix simply reject async flips in that case.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9769
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index d955957b7d18..61053c19f4cc 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -5926,6 +5926,17 @@ static int intel_async_flip_check_uapi(struct intel_atomic_state *state,
 		return -EINVAL;
 	}
 
+	/*
+	 * FIXME: Bigjoiner+async flip is busted currently.
+	 * Remove this check once the issues are fixed.
+	 */
+	if (new_crtc_state->bigjoiner_pipes) {
+		drm_dbg_kms(&i915->drm,
+			    "[CRTC:%d:%s] async flip disallowed with bigjoiner\n",
+			    crtc->base.base.id, crtc->base.name);
+		return -EINVAL;
+	}
+
 	for_each_oldnew_intel_plane_in_state(state, plane, old_plane_state,
 					     new_plane_state, i) {
 		if (plane->pipe != crtc->pipe)
-- 
2.41.0


