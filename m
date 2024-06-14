Return-Path: <stable+bounces-52179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F67A90897B
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 12:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D331F29F9C
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 10:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CC219306F;
	Fri, 14 Jun 2024 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ch9mrigQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03FF7E574
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360177; cv=none; b=QDEbSEwAn/UQzNvE/lIx51a8Xj0/RUyMlnsKQOV/kWQaf7FxELC7WsFWRNGfJNqUJPQj8S6ELVcxi3VlRYUMWHDRq4GTJDcGN08sufqsAo1RYDiAIJe0mjSKNj/4X+a2Xldc5WtfaUNhpq4FebOrqZMMjA4g8ZTO3deGoqoQxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360177; c=relaxed/simple;
	bh=/7RCYWGNPYz/U2WZNuk6anoe7bqzGeS+GHcv0XxCLlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tm+txfbpJEPBuC6pi3A0gaL8iHISb3u5Ig2Ut4DwUVB8c62EZvs34FT7M7A72epRHNbRT7ePZv3d0BwVs5OxpFglCwFciPL/n3NvPZwbzxZzSQ8EkTIE+MOiG+/zgUB8I8mW6awqqjXBAVgbt0stH5a3Lq/HLmEv1Fvatg67Pkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ch9mrigQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718360176; x=1749896176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/7RCYWGNPYz/U2WZNuk6anoe7bqzGeS+GHcv0XxCLlo=;
  b=Ch9mrigQ/LNpILUh5cDuhZOVCtYjmGwL2zX8L9TEHYApZ3XS+AZm7o1y
   //Q+qdhtPQLqEBFS56d2vuESQY28mLgEzCnRdQfII7RmnPJoDT6ty5g0F
   BTYhpNgg9oGaxklLs4rea6aDeB6J7tUtxaYrUy5k9trOF6R1pLdzALWSg
   uRzPtSeinhf4tD5OQGmYZa1WBUo2akl9CzLMC7Bdbm0d5vluRIVKaIdI7
   IHuLb2F003L6idrAclvcqEOXwT9vB66uUr3DiWJ7ncAKBC2M0WRIwLTgc
   kW7lpY2QXUCObPSLx05FN5aOCE+x9FgC4khyUm5OYDS6b/bo2BlIMUByb
   g==;
X-CSE-ConnectionGUID: o9EbB1cJStOytHZ0zJGntA==
X-CSE-MsgGUID: jpojpf93R5aF6dRCSjqp3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25814263"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="25814263"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:16:15 -0700
X-CSE-ConnectionGUID: D1fv2w0qRI2fOR/bsGO2pA==
X-CSE-MsgGUID: PLu5+aGXT8eioJAnVk6o5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="63658294"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.221])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:16:12 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/i915/mso: using joiner is not possible with eDP MSO
Date: Fri, 14 Jun 2024 13:16:03 +0300
Message-Id: <137a010815ab8ba8f266fea7a85fe14d7bfb74cd.1718360103.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1718360103.git.jani.nikula@intel.com>
References: <cover.1718360103.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

It's not possible to use the joiner at the same time with eDP MSO. When
a panel needs MSO, it's not optional, so MSO trumps joiner.

While just reporting false for intel_dp_has_joiner() should be
sufficient, also skip creation of the joiner force enable debugfs to
better handle this in testing.

Cc: stable@vger.kernel.org
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1668
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_debugfs.c | 8 ++++++--
 drivers/gpu/drm/i915/display/intel_dp.c              | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 91757fed9c6d..5eb31404436c 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -1546,8 +1546,12 @@ void intel_connector_debugfs_add(struct intel_connector *connector)
 	if (DISPLAY_VER(i915) >= 11 &&
 	    (connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
 	     connector_type == DRM_MODE_CONNECTOR_eDP)) {
-		debugfs_create_bool("i915_bigjoiner_force_enable", 0644, root,
-				    &connector->force_bigjoiner_enable);
+		struct intel_dp *intel_dp = intel_attached_dp(connector);
+
+		/* eDP MSO is not compatible with joiner */
+		if (!intel_dp->mso_link_count)
+			debugfs_create_bool("i915_bigjoiner_force_enable", 0644, root,
+					    &connector->force_bigjoiner_enable);
 	}
 
 	if (connector_type == DRM_MODE_CONNECTOR_DSI ||
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 9a9bb0f5b7fe..ab33c9de393a 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -465,6 +465,10 @@ bool intel_dp_has_joiner(struct intel_dp *intel_dp)
 	struct intel_encoder *encoder = &intel_dig_port->base;
 	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
 
+	/* eDP MSO is not compatible with joiner */
+	if (intel_dp->mso_link_count)
+		return false;
+
 	return DISPLAY_VER(dev_priv) >= 12 ||
 		(DISPLAY_VER(dev_priv) == 11 &&
 		 encoder->port != PORT_A);
-- 
2.39.2


