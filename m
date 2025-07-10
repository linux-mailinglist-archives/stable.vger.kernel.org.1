Return-Path: <stable+bounces-161615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ACCB00CDF
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 22:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22ACB645B12
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 20:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DB721CC63;
	Thu, 10 Jul 2025 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCTrMBDP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64BD1F0E50
	for <stable@vger.kernel.org>; Thu, 10 Jul 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178647; cv=none; b=J26NvQKqommAA4YqVyWhmev3ekEvowP6KD/ouK/13QbhfINu1oIymNHeZyy6+TnW7R+G14gJr4T21GHIjQGNtvB3+LNu9WVwy8wmQIWuaxW9W6yf6HwG4NHtKgYFidCed8xYuMnP3FkzKFSqcPlJCoDsJlxT6XCzAS1vB2plSIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178647; c=relaxed/simple;
	bh=6Zk4fBa6kRr/oBR2bQdbV1gR6RhEausXd1tlnv/LMnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUYIE05iVwJrfJUxrS2OuaoqN/gZ0bIqpCKkGG1UREFlY62Z9oXuw43YVwOXwnrPruTOyFPnwEDfkYh5iAkOHmkVI5MdH2S65O68S3AMpq5OKu0mp2VCV2XI36YmVtqcpf1kcNlu8tC0T69W9aqs9jMbwKHn49eXx2FYhiXoExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCTrMBDP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752178646; x=1783714646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Zk4fBa6kRr/oBR2bQdbV1gR6RhEausXd1tlnv/LMnw=;
  b=lCTrMBDPntZGtY9yoNI5yMzQZ0C8ArTE2NZYC5LYe8vb8yw3UGifq/OC
   yR+z+n78UBIHlsPeLFooI1cmIDmWIvn8gUgVP6/wpdUFom2F7Voo48RbP
   iKIt4q5w+O8yx9bDnqPfyxZiSxZSUWWxxp6hiBWwgPWvQAXn/FlPyrBmr
   0+2wqDRf84Py42z61Jm6uwyDtZ7s1vqyxiDCOEUQqVL24mYLNV3kpprLr
   Cwp87HOn4SGxUqqyaN2AGI+GthLfd+2K9DpBJlYIJti1QjYBlnb34X/Jq
   mUIZSg7sHf7uOgSAonst0Gp1TLCdZKf73+HjwMloBswjBQyGrUdGeqbyM
   w==;
X-CSE-ConnectionGUID: H3/uHkSYQMaSdfqf/ra/Cg==
X-CSE-MsgGUID: 0meWLh21ScK7v6nL9ZwYSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54444537"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54444537"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 13:17:25 -0700
X-CSE-ConnectionGUID: IGexykX3Q6GLr585i58kfg==
X-CSE-MsgGUID: KKCb/39xSZGrkC046ENvVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="161877524"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO stinkbox) ([10.245.244.160])
  by orviesa005.jf.intel.com with SMTP; 10 Jul 2025 13:17:23 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 10 Jul 2025 23:17:22 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH 1/7] drm/i915/dp: Fix 2.7 Gbps DP_LINK_BW value on g4x
Date: Thu, 10 Jul 2025 23:17:12 +0300
Message-ID: <20250710201718.25310-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710201718.25310-1-ville.syrjala@linux.intel.com>
References: <20250710201718.25310-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

On g4x we currently use the 96MHz non-SSC refclk, which can't actually
generate an exact 2.7 Gbps link rate. In practice we end up with 2.688
Gbps which seems to be close enough to actually work, but link training
is currently failing due to miscalculating the DP_LINK_BW value (we
calcualte it directly from port_clock which reflects the actual PLL
outpout frequency).

Ideas how to fix this:
- nudge port_clock back up to 270000 during PLL computation/readout
- track port_clock and the nominal link rate separately so they might
  differ a bit
- switch to the 100MHz refclk, but that one should be SSC so perhaps
  not something we want

While we ponder about a better solution apply some band aid to the
immediate issue of miscalculated DP_LINK_BW value. With this
I can again use 2.7 Gbps link rate on g4x.

Cc: stable@vger.kernel.org
Fixes: 665a7b04092c ("drm/i915: Feed the DPLL output freq back into crtc_state")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index f48912f308df..7976fec88606 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1606,6 +1606,12 @@ int intel_dp_rate_select(struct intel_dp *intel_dp, int rate)
 void intel_dp_compute_rate(struct intel_dp *intel_dp, int port_clock,
 			   u8 *link_bw, u8 *rate_select)
 {
+	struct intel_display *display = to_intel_display(intel_dp);
+
+	/* FIXME g4x can't generate an exact 2.7GHz with the 96MHz non-SSC refclk */
+	if (display->platform.g4x && port_clock == 268800)
+		port_clock = 270000;
+
 	/* eDP 1.4 rate select method. */
 	if (intel_dp->use_rate_select) {
 		*link_bw = 0;
-- 
2.49.0


