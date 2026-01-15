Return-Path: <stable+bounces-208421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EB3D22B2D
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 08:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B02630BF33C
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 07:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254B8315D3F;
	Thu, 15 Jan 2026 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdXykBzV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15207314D25
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768460459; cv=none; b=rnXHCxuhwKIuklKFCaCE7jH/orcFNPA8DTWrcawVE1mZ+FoAzPEmYQPxhtjHGYztw+A6531c6Js6hwVyKxfBkl88jR9U1a/zPwrLcLrU1GysdKalNTK4b29fhl/OwRUEifG+bgBTvAg1sBsbkdR4EGBNueUrlIQd5jlMg24xTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768460459; c=relaxed/simple;
	bh=ZvHY6s3dhRLzX0jtIb+bq4GeY1KK2H4zl11ETljkc9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OrXs621M91MSh13/KEog2kvpJCACy9Y47BHK2N7pw3OPZJkaJ4hNSyAxAOMCFjj5HNMtMX/wBz2cRdWmI4wbP8zr77NbgAT/o8NWiwHYUN/UaB456HAVUx+hChhm7UKBHPzHFG7jNUrI5eNwDKi02qB1kI7zAmJyBduGQ3GzCFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdXykBzV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768460458; x=1799996458;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZvHY6s3dhRLzX0jtIb+bq4GeY1KK2H4zl11ETljkc9Y=;
  b=SdXykBzVYWvMixOQJVtZUNiI/GjOaS9GWfM8aYu8h0DvUe6SprXEe4cG
   0K18qCIMieUi08RTLzfcxfFpEFOFRxls9z/Ijgz12SZ4SEjbrHwcQS72A
   jFBNmLlU+Qc9RpNT371BAEvz3ElbF82nDkEB7Q+dnr398rmdpWaTKv43u
   ksJLjRAIeH2VqnHNX+hBeEywVkwZ/gS/AgEcqLH+cmfVIImRmQqecfh45
   I0IHq2eCHu8l1INbSNgRkzjDmCGRhfxRb9nsH5sxowMNifO1yFiWaY8Vg
   +X00WtJRRTEBlfpZZfPcirIz/68VIKt1F3qI6y4NrleROncuCdXJ7KPtG
   Q==;
X-CSE-ConnectionGUID: G6/lkvaUScWpjEa7EYcmWw==
X-CSE-MsgGUID: lX1x2WBFQr2HvsHBjmSd+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="80059980"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="80059980"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 23:00:57 -0800
X-CSE-ConnectionGUID: x1/AbvKgSgSiegeI9l/anw==
X-CSE-MsgGUID: HnnX+Na1SfOvFWpUlvUliQ==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.125])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 23:00:55 -0800
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/psr: Don't enable Panel Replay on sink if globally disabled
Date: Thu, 15 Jan 2026 09:00:39 +0200
Message-ID: <20260115070039.368965-1-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

With some panels informing support for Panel Replay we are observing
problems if having Panel Replay enable bit set on sink when forced to use
PSR instead of Panel Replay. Avoid these problems by not setting Panel
Replay enable bit in sink when Panel Replay is globally disabled during
link training. I.e. disabled by module parameter.

The enable bit is still set when disabling Panel Replay via debugfs
interface. Added note comment about this.

Fixes: 68f3a505b367 ("drm/i915/psr: Enable Panel Replay on sink always when it's supported")
Cc: Mika Kahola <mika.kahola@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 91f4ac86c7ad..62208ffc5101 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -842,7 +842,12 @@ static void intel_psr_enable_sink(struct intel_dp *intel_dp,
 
 void intel_psr_panel_replay_enable_sink(struct intel_dp *intel_dp)
 {
-	if (CAN_PANEL_REPLAY(intel_dp))
+	/*
+	 * NOTE: We might want to trigger mode set when
+	 * disabling/enabling Panel Replay via debugfs interface to
+	 * ensure this bit is cleared/set accordingly.
+	 */
+	if (CAN_PANEL_REPLAY(intel_dp) && panel_replay_global_enabled(intel_dp))
 		drm_dp_dpcd_writeb(&intel_dp->aux, PANEL_REPLAY_CONFIG,
 				   DP_PANEL_REPLAY_ENABLE);
 }
-- 
2.43.0


