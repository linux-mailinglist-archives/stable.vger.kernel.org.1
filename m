Return-Path: <stable+bounces-116628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04989A38F2C
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 23:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A3B3ADCF5
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 22:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28A01A8F7A;
	Mon, 17 Feb 2025 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8FbEnNT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8B18B495
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739831852; cv=none; b=F5GsXQ9zXvU1eLteTFj/MACSpb9LTKWM9wnlm0mqFC0WWCyKyIOHZwTDwPjaD33x50r8G+i1XzCHyZOCbGTfLIzdHd+xaXe25IY8/GN8AI2Z/wvRnURrUpaPHmcM+2PIOcuRuoFWxlulEsFv1cfB2F9RQE7VBCvlZLij/rRze6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739831852; c=relaxed/simple;
	bh=e3W15pdFUay2X4MUqjFbksdjtZgDa/8IFND6iZsW3n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sptmknfqtWCrcU/++i7jN46o4f8bmaptjtq4Rq9o57qiGvHx8aB900G9hUcQ2asgDfckCf1zGwxHriB0NRq8bb1cA8WFm73ho4IFrZHTXdJ+0XvX6GUR3XE9NJGHTHbraJ7X1juELNtvEHLQa4irewyHbrnjJggb+tXf9SvHMNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8FbEnNT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739831851; x=1771367851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3W15pdFUay2X4MUqjFbksdjtZgDa/8IFND6iZsW3n4=;
  b=U8FbEnNTUc1MrlXXKCnYFISIVi7rCwrrjvIBnbVppm8bvWPtxlBg/Ult
   BgijUDumKFJvDC3b+8bipUeEOSsUjY/O9hnoUui6OWS78DEp682Pu5SAK
   4f6p4Qi2ky2XVHzIGjGPOPG/aa18V5ga8+1K9XRTZm1jEb+tE0ZIXa97v
   FL/4f5XkZwIkeD25orhhL7FbMk5HecnvW4es4VzRsoWU0Z7svK/qA32o5
   mnqpTmxhGgMo12j+ncMt45QT8cTQTkZ2ThBC+OD80bohxwp0xrVjq/8hA
   RSKh76ZP1oUayFNCV34xZqVsFFXplgYq2Du+F6vX0YzfaML0RbY63zLLM
   g==;
X-CSE-ConnectionGUID: G/mONJiBQkaJKqgu4Ye8Qw==
X-CSE-MsgGUID: /r44tIY/QZakemmYVZqTwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44171143"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="44171143"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 14:37:30 -0800
X-CSE-ConnectionGUID: fThTQHpRTZ+1kgrSflZ3CQ==
X-CSE-MsgGUID: 6YzBTyUBS4yR3NmF6zzZKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="114872573"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 14:37:28 -0800
From: Imre Deak <imre.deak@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 1/2] drm/i915/dp: Fix error handling during 128b/132b link training
Date: Tue, 18 Feb 2025 00:38:27 +0200
Message-ID: <20250217223828.1166093-2-imre.deak@intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20250217223828.1166093-1-imre.deak@intel.com>
References: <20250217223828.1166093-1-imre.deak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the end of a 128b/132b link training sequence, the HW expects the
transcoder training pattern to be set to TPS2 and from that to normal
mode (disabling the training pattern). Transitioning from TPS1 directly
to normal mode leaves the transcoder in a stuck state, resulting in
page-flip timeouts later in the modeset sequence.

Atm, in case of a failure during link training, the transcoder may be
still set to output the TPS1 pattern. Later the transcoder is then set
from TPS1 directly to normal mode in intel_dp_stop_link_train(), leading
to modeset failures later as described above. Fix this by setting the
training patter to TPS2, if the link training failed at any point.

Cc: stable@vger.kernel.org # v5.18+
Cc: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 .../gpu/drm/i915/display/intel_dp_link_training.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index 3cc06c916017d..11953b03bb6aa 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -1563,7 +1563,7 @@ intel_dp_128b132b_link_train(struct intel_dp *intel_dp,
 
 	if (wait_for(intel_dp_128b132b_intra_hop(intel_dp, crtc_state) == 0, 500)) {
 		lt_err(intel_dp, DP_PHY_DPRX, "128b/132b intra-hop not clear\n");
-		return false;
+		goto out;
 	}
 
 	if (intel_dp_128b132b_lane_eq(intel_dp, crtc_state) &&
@@ -1575,6 +1575,19 @@ intel_dp_128b132b_link_train(struct intel_dp *intel_dp,
 	       passed ? "passed" : "failed",
 	       crtc_state->port_clock, crtc_state->lane_count);
 
+out:
+	/*
+	 * Ensure that the training pattern does get set to TPS2 even in case
+	 * of a failure, as is the case at the end of a passing link training
+	 * and what is expected by the transcoder. Leaving TPS1 set (and
+	 * disabling the link train mode in DP_TP_CTL later from TPS1 directly)
+	 * would result in a stuck transcoder HW state and flip-done timeouts
+	 * later in the modeset sequence.
+	 */
+	if (!passed)
+		intel_dp_program_link_training_pattern(intel_dp, crtc_state,
+						       DP_PHY_DPRX, DP_TRAINING_PATTERN_2);
+
 	return passed;
 }
 
-- 
2.44.2


