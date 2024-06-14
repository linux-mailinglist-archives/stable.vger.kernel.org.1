Return-Path: <stable+bounces-52205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BBF908D53
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3725B28AAE
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7E5C152;
	Fri, 14 Jun 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkaHwEx0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2788C2C6
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374999; cv=none; b=nM5NublcqcXP88WXn1S2o4jVPR5v0ryRJZMic7ZBVenUKi4xylA4PnQoWHSBGHLpUK+gYVSk8znUpOSNACqlz/+M/dGB7qiVtEaJSrU8tAo4S7sAUqumvL307MXIjoXAZJ73+a9eRjLjIeXbHXVX6YBIeR3vk5qNYyDOUFQ0gdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374999; c=relaxed/simple;
	bh=WKTZfkq4hlNpel0YHX7G79geSr2AykTXKrvuJ0NvrrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PfKbpsZJ4A2YASSTbu6REFNC3kUbOyRYbfAXXHfcDt+O/dxk8PsrlrYZBCyZkJKTotlMcCghP/yzpksCRXQfC4huxsr71OvrMHB2FNfAB0IQidxNMRNv8VHTBKlAc4FGy4TJGANrt5uy3bf487lDTZIay0hIpLfMVEC93dfzbyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkaHwEx0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718374998; x=1749910998;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WKTZfkq4hlNpel0YHX7G79geSr2AykTXKrvuJ0NvrrI=;
  b=UkaHwEx0+bKNTsC9o0tdG73yX+XbEIYI0fRifluvy8o71Bu1B0SFTWm5
   dZZ2zdYpghyQHkxbfPy5ngncPAFSSgWbeQ5uCiN9LIowH4BP2kvWBZj7q
   uZk8mN7BB2G1ItCWMW5hOJp31M32EpxFGwV/1OmHoScJcxwZWLDd9VUHP
   uFBeFK6o9GQMnMnGjCDrk+D3R1Wjc+huGOlSZBLQKvF5315iFhg0DdU3e
   6HdcAdecK8yh23kd7B0fPLnJb7yS2S/1F1wweZ3/w9dkz57Y9Y30cqN2l
   k1hT/mgF8DoexBhdw7DzL9OWyIPZg9iyqLMkXDdvnljb+Jx+DTGpDhPxs
   A==;
X-CSE-ConnectionGUID: EAhuvh02Q+m0enFjnD5scA==
X-CSE-MsgGUID: RRKbfUJmSCi5yEaTMfSEyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15387295"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15387295"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 07:23:17 -0700
X-CSE-ConnectionGUID: FLvJheGrRyG+AzbwYKmxqA==
X-CSE-MsgGUID: +FRZ0bViQAei76umXpESXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="41020131"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.221])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 07:23:15 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/mso: using joiner is not possible with eDP MSO
Date: Fri, 14 Jun 2024 17:23:11 +0300
Message-Id: <20240614142311.589089-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
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

v3: Only change intel_dp_has_joiner(), leave debugfs alone (Ville)

Cc: stable@vger.kernel.org
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1668
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

---

Just the minimal fix for starters to move things along.
---
 drivers/gpu/drm/i915/display/intel_dp.c | 4 ++++
 1 file changed, 4 insertions(+)

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


