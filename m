Return-Path: <stable+bounces-128283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57088A7B8A9
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 10:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F5A1795CA
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 08:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D7D188CB1;
	Fri,  4 Apr 2025 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOlDocqH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03031CD3F
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743754645; cv=none; b=Qhfo+68RBVceZZs3HFCqNLFrSR7TkESLw/uj9jc8/XR0Qney4nAZ2CvMINbq444KB0iTB/2PlNVIxvL3Dgoz7/jvJ2jux7B0O40y/4EfLPiirx4WXb6SQ3qM9ZDhEswJ92Exf1EfrgyjwAVkl5SRyAY/8EFR6rZTVboirchA+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743754645; c=relaxed/simple;
	bh=e02cM4R1rabkKdpv0fMVX5NelBsQhTZnE1vEIOu25tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ia3JdynbGhWM/aU9jMgh6rIO5Tp9Q3HVUZklJZuSst5fW4GIMGPZztKVcB3+14YfSI88gE0FcF2e1a3t8dNZFtGks4R4RmMkb81fr/yNiY1GSKH/GPkm+3BxR26cuHvPPwLkSXq0dGnNTNF4ZY7T8oN35/xF3jumVdaQltNBpBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOlDocqH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743754644; x=1775290644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e02cM4R1rabkKdpv0fMVX5NelBsQhTZnE1vEIOu25tQ=;
  b=MOlDocqHRXDzzCqPffcNLQ7BbR3P2Ln7c7zfWr98DEWkImNO9BQQrRQw
   Lx5HuJvmeZlbQtI7zWJihHjAKjWweVTLyZwxMrzL4qYAXrvzheeONteOS
   Rh1wsrfa7K5SNhuIAFMZpOdnFWUjMZtuvj/FBD3xIzwPNdLilhSFoIin8
   jCuhsk38nDh9x6cNCgMjeIo2x+q7XoKSi4nt7Qh0tSeKrHjqQ91sHOH4c
   FWALxDtxWCRk2IgK5li0Bz3fuPg7DsWdnJ1feVt0dtMLsVAmTdsqyCPbL
   Io6Eu6LqVbb6sFgPWzFcwmVO6bKXld3060RRymrTQFgGrIN8I5pDtD028
   g==;
X-CSE-ConnectionGUID: CrK+7T4wQZOYpMtUEgxq0A==
X-CSE-MsgGUID: olvlE/k2Q1mgIMMrnjJceg==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="45078274"
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="45078274"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 01:17:23 -0700
X-CSE-ConnectionGUID: hcnaVYezRkKOHWodik+HRw==
X-CSE-MsgGUID: jBT1B4KuQ3ulxn2lV0uSXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="132453241"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 01:17:21 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com,
	mitulkumar.ajitkumar.golani@intel.com,
	arun.r.murthy@intel.com,
	stable@vger.kernel.org,
	ville.syrjala@linux.intel.com
Subject: [PATCH] drm/i915/vrr: Add vrr.vsync_{start,end} in vrr_params_changed
Date: Fri,  4 Apr 2025 13:35:40 +0530
Message-ID: <20250404080540.2059511-1-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing vrr parameters in vrr_params_changed() helper.
This ensures that changes in vrr.vsync_{start,end} trigger a call to
appropriate helpers to update the VRR registers.

Fixes: e8cd188e91bb ("drm/i915/display: Compute vrr_vsync params")
Cc: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
Cc: Arun R Murthy <arun.r.murthy@intel.com>
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index c540e2cae1f0..ced8ba0f8d6d 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -969,7 +969,9 @@ static bool vrr_params_changed(const struct intel_crtc_state *old_crtc_state,
 		old_crtc_state->vrr.vmin != new_crtc_state->vrr.vmin ||
 		old_crtc_state->vrr.vmax != new_crtc_state->vrr.vmax ||
 		old_crtc_state->vrr.guardband != new_crtc_state->vrr.guardband ||
-		old_crtc_state->vrr.pipeline_full != new_crtc_state->vrr.pipeline_full;
+		old_crtc_state->vrr.pipeline_full != new_crtc_state->vrr.pipeline_full ||
+		old_crtc_state->vrr.vsync_start != new_crtc_state->vrr.vsync_start ||
+		old_crtc_state->vrr.vsync_end != new_crtc_state->vrr.vsync_end;
 }
 
 static bool cmrr_params_changed(const struct intel_crtc_state *old_crtc_state,
-- 
2.45.2


