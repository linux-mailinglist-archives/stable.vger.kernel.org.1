Return-Path: <stable+bounces-87988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE10E9ADA88
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 426A4B21C60
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5D616A397;
	Thu, 24 Oct 2024 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKLdRxrR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0315B96E
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741138; cv=none; b=mx3mhyic6Otp3KZKt0OPvNMwHiVxdcglaOU7sWDJ08DPb2r7A1jF3avyd7DGKioeTYFtOzqCl/o+LJAEltLxtyITs5YvaTXbi+OzrXgjS0kPNKaPW28cBQ3Zn4sP/RA0RxG6zIgSYOJEAMKXA6vISj4cjjFW1CZzSaRVVsMmdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741138; c=relaxed/simple;
	bh=KvydmP62FuktLZ40Jssp76zAUkmY4+Jg9706EIwUYkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mW5Cy0kCv03KTvUp6tcnCXlT2fqVLp4HzrvsJwBk/STVLjF//zICJ/zJKuMu7OwZp5dhMHKPFXxJGqc1KGZNN8aYGezKF7PE1BJ0oKFUgD7w0uO0UpVo3tMje+e5cpoSbLtTCwEgUZji8xdCFHnAfOghLWzCq3cezTYJ6uyydCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKLdRxrR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741137; x=1761277137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KvydmP62FuktLZ40Jssp76zAUkmY4+Jg9706EIwUYkA=;
  b=GKLdRxrR9+ysOwUnOowdAj8pZVA6REK5gV5ax7TCYucB9xn/Ul5jJ7/6
   yQvdKbMEzCzEeOzaMQ/RrmzkNMWm2DtYIyIjPmeWojwd5QChBApfRQy9B
   o2dzmrT1aMCVrxUC91hoBUP2dsd7yhNGpki8BiVqtJjVpheCA0jzxWjo5
   mvG9IqyP6YVV4++/pVgMn8KpHVFYLWyTYle06Ma/VsdS5JJUGAGWAef/G
   XO3lhmL2AkiXEWTWhEZyseLyVSKdWg98YexiZP1TmD2e1huAkEw0G9Sw1
   T/Q7xRfHu5vJnBxQS8ATqNfQwQfxzpF6D/RI0O93PQ2XtgsgkgYY4AT2y
   A==;
X-CSE-ConnectionGUID: J+yFjp3iSTW4ByWLtOOKeA==
X-CSE-MsgGUID: 7/ViJhCqSQCi/VDTIT2FdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33264992"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33264992"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:52 -0700
X-CSE-ConnectionGUID: 9rCVmkJcRSWfBzBKlL5l/g==
X-CSE-MsgGUID: 8ZbDq4diQkSiaUEQCffhDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384957"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:50 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
	Arun R Murthy <arun.r.murthy@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 08/22] drm/i915/display/dp: Compute AS SDP when vrr is also enabled
Date: Wed, 23 Oct 2024 20:38:00 -0700
Message-ID: <20241024033815.3538736-8-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024033815.3538736-1-lucas.demarchi@intel.com>
References: <20241024033815.3538736-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>

commit eb53e5b933b9ff315087305b3dc931af3067d19c upstream.

AS SDP should be computed when VRR timing generator is also enabled.
Correct the compute condition to compute params of Adaptive sync SDP
when VRR timing genrator is enabled along with sink support indication.

--v2:
Modify if condition (Jani).

Fixes: b2013783c445 ("drm/i915/display: Cache adpative sync caps to use it later")
Cc: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
Cc: Arun R Murthy <arun.r.murthy@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Signed-off-by: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
(added prefix drm in subject)
Link: https://patchwork.freedesktop.org/patch/msgid/20240730040941.396862-1-mitulkumar.ajitkumar.golani@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 999557a5c0f12..4ec724e8b2207 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2627,7 +2627,7 @@ static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
 	const struct drm_display_mode *adjusted_mode =
 		&crtc_state->hw.adjusted_mode;
 
-	if (!crtc_state->vrr.enable || intel_dp->as_sdp_supported)
+	if (!crtc_state->vrr.enable || !intel_dp->as_sdp_supported)
 		return;
 
 	crtc_state->infoframes.enable |= intel_hdmi_infoframe_enable(DP_SDP_ADAPTIVE_SYNC);
-- 
2.47.0


