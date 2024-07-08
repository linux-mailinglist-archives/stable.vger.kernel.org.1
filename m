Return-Path: <stable+bounces-58248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEFC92A96E
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 21:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E9FB21AFF
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 19:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6427B149DF4;
	Mon,  8 Jul 2024 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mm+bkeSA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504201474BE
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465222; cv=none; b=WN3A6+38lxUXBcJJkLHni2hcVgHX1TqWUOpgVtOzlw7Zzx4p2qBMQTJ5icpBWUiC9hO21/xxdvYyxiKJa7bfKd8ibEMhCT7irRYcZdNTDURugdlMN5gt+9a9KUby11ZN/7W1sM5q4gxdrYLv479NZv9RZRoFXLwUnFTu7Rg95Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465222; c=relaxed/simple;
	bh=GNxv+R12ylRsoWXQk72T4lYT3jeo6FtncipNXpy8Pck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPXRlMImnio1iyfb4TI2tYYHpRXee04OUu/JzWX/lcd5PeTMhlU0oc49tPttTd6fYrrmcV43pYcYcr2D1AqodCIw6A3m+nJ41Wr1Ek0+C3kd4ALdRK4u7fM2KGXzzglIz1MhXEOs3keFctmeSRSlizpRWjoJCAbujweFu50MRag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mm+bkeSA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720465220; x=1752001220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GNxv+R12ylRsoWXQk72T4lYT3jeo6FtncipNXpy8Pck=;
  b=Mm+bkeSAMKVpavywAjwDzKX0xvXA8NBlGImKOHoUoCD/7SvSY58EuK6b
   Awq0D2xua7ZPvrZ1/Ujo50SpcxmrgOeFZdPOQa5pggHrYY/c60IMKHlGb
   8+EqtbivJ851XLldkFLZOTbV+OwlS9TDN9eu9Ge/4mMgPh1h233eIMDFP
   TvGLdPSHn3gVxvpcwO62aIVc0Xs5lg1j7+I98pB7zhDwbA9mv7Y6YhFOq
   rHnBBniJ8HlvsxI1PKtvmBgtDKgwgMZoKCMAeYAwO0eQABkzRzLCzzs6V
   ykon2dHkdIIyIPWTuJzjkM47A9tyW+0veOKrrIWHSv/BRBXb8Nah3NwYj
   g==;
X-CSE-ConnectionGUID: 00RvFHBaS0uZ44NUv2OgKg==
X-CSE-MsgGUID: KkZDTo2aSZqLT7b4SwIEFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17821046"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="17821046"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 12:00:19 -0700
X-CSE-ConnectionGUID: RIt7j5OcQNyh/vHN31slLA==
X-CSE-MsgGUID: AQwgXFuHQxypMA3vj6Ri+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="85140009"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 12:00:18 -0700
From: Imre Deak <imre.deak@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH v2 1/6] drm/i915/dp: Reset intel_dp->link_trained before retraining the link
Date: Mon,  8 Jul 2024 22:00:24 +0300
Message-ID: <20240708190029.271247-2-imre.deak@intel.com>
X-Mailer: git-send-email 2.43.3
In-Reply-To: <20240708190029.271247-1-imre.deak@intel.com>
References: <20240708190029.271247-1-imre.deak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Regularly retraining a link during an atomic commit happens with the
given pipe/link already disabled and hence intel_dp->link_trained being
false. Ensure this also for retraining a DP SST link via direct calls to
the link training functions (vs. an actual commit as for DP MST). So far
nothing depended on this, however the next patch will depend on
link_trained==false for changing the LTTPR mode to non-transparent.

Cc: <stable@vger.kernel.org> # v5.15+
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 3903f6ead6e66..59f11af3b0a1d 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5314,6 +5314,8 @@ static int intel_dp_retrain_link(struct intel_encoder *encoder,
 		const struct intel_crtc_state *crtc_state =
 			to_intel_crtc_state(crtc->base.state);
 
+		intel_dp->link_trained = false;
+
 		intel_dp_check_frl_training(intel_dp);
 		intel_dp_pcon_dsc_configure(intel_dp, crtc_state);
 		intel_dp_start_link_train(NULL, intel_dp, crtc_state);
-- 
2.43.3


