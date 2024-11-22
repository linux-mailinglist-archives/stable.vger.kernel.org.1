Return-Path: <stable+bounces-94654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA589D6528
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B65161493
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C27D1DFD98;
	Fri, 22 Nov 2024 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEh2RZpc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1418C002
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309671; cv=none; b=KZcHtvjgFz04nwjTEzWmDxZ15C00XbpscwK0UCIv3MVTrzcs7UCzXPuT2NqAgAgA7H5CPygX+r3kq64RdNrwsAzDh0gMsLLQI7ZjR1HUcYXTZDfUxTE0xEZTB59ro/4hifRpKd0BiP+bsqc9lFYVmFaikS33ZJTpXup2g5r3tGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309671; c=relaxed/simple;
	bh=zRakL6j4akpaUp3pa/zG3UT82TlbQZq42vr5hLedjtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5l8wylHJQiQVsz0OCC75gFPvNL/EGPYTvRS9q++NuyHPdPgCp2c46RpBHQa3EnFqYJLLXes9U9qSBKhuzkmli7Ta5dR3Sk+3OwnKIdqnAOw3XhamZcGgky34nk2n89U4BDaJ1Mb1z0UFF0+bFB+lYnfDty4R9HC9rCR8xhRuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEh2RZpc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309669; x=1763845669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zRakL6j4akpaUp3pa/zG3UT82TlbQZq42vr5hLedjtA=;
  b=oEh2RZpcDbNpEiYzRXkb3NqYjiSJWau2UckdGgd5GzQ3EwDh7owHFMVU
   vgFibCLrP7yr7kHTuvXM4YFZ4oUHRg71EYGQm+8Oq3oRBbmE1mH3oirRN
   QyMu84vSFqyivsjsc0stcaYzdwotpSAd+dIFZrYNVimxYtn7y4+M7QuL9
   P5RSFK2tyxcNESolSWRAUtJaPPJE/50f2IHLW6DROohjTDGjFZIsx1Wi/
   BPYNlLgGSytemyhrNMl98oMCl0ozpNPujMyu4/YOsHRrY7IOGnfyse3jG
   87sELsXObszqsNxVPVgyOOm1W6hT2+kT7IkTHsWxWhonq3bcwyr4fIdK5
   Q==;
X-CSE-ConnectionGUID: 7PiN3NCUROu/uHzOEaeZXg==
X-CSE-MsgGUID: a44kGM8QRxiRdMvb/fAXvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878273"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878273"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:42 -0800
X-CSE-ConnectionGUID: AfhT6Ht4TrG0NETud2Dphg==
X-CSE-MsgGUID: 1uf5gB4SQ8CrfSrx2gGuUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457249"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:42 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 17/31] drm/xe/display: Separate the d3cold and non-d3cold runtime PM handling
Date: Fri, 22 Nov 2024 13:07:05 -0800
Message-ID: <20241122210719.213373-18-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Imre Deak <imre.deak@intel.com>

commit a4de6beb83fc5adee788518350247c629568901e upstream.

For clarity separate the d3cold and non-d3cold runtime PM handling. The
only change in behavior is disabling polling later during runtime
resume. This shouldn't make a difference, since the poll disabling is
handled from a work, which could run at any point wrt. the runtime
resume handler. The work will also require a runtime PM reference,
syncing it with the resume handler.

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241009194358.1321200-4-imre.deak@intel.com
[ Fix conflict: intel_opregion_resume() takes xe as argument instead of display ]
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index 04e99d1beb21a..b011a1e3ffa38 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -337,6 +337,9 @@ static void __xe_display_pm_suspend(struct xe_device *xe, bool runtime)
 	intel_opregion_suspend(xe, s2idle ? PCI_D1 : PCI_D3cold);
 
 	intel_dmc_suspend(xe);
+
+	if (runtime && has_display(xe))
+		intel_hpd_poll_enable(xe);
 }
 
 void xe_display_pm_suspend(struct xe_device *xe)
@@ -349,8 +352,10 @@ void xe_display_pm_runtime_suspend(struct xe_device *xe)
 	if (!xe->info.enable_display)
 		return;
 
-	if (xe->d3cold.allowed)
+	if (xe->d3cold.allowed) {
 		__xe_display_pm_suspend(xe, true);
+		return;
+	}
 
 	intel_hpd_poll_enable(xe);
 }
@@ -398,9 +403,11 @@ static void __xe_display_pm_resume(struct xe_device *xe, bool runtime)
 		intel_display_driver_resume(xe);
 		drm_kms_helper_poll_enable(&xe->drm);
 		intel_display_driver_enable_user_access(xe);
-		intel_hpd_poll_disable(xe);
 	}
 
+	if (has_display(xe))
+		intel_hpd_poll_disable(xe);
+
 	intel_opregion_resume(xe);
 
 	intel_fbdev_set_suspend(&xe->drm, FBINFO_STATE_RUNNING, false);
@@ -418,10 +425,12 @@ void xe_display_pm_runtime_resume(struct xe_device *xe)
 	if (!xe->info.enable_display)
 		return;
 
-	intel_hpd_poll_disable(xe);
-
-	if (xe->d3cold.allowed)
+	if (xe->d3cold.allowed) {
 		__xe_display_pm_resume(xe, true);
+		return;
+	}
+
+	intel_hpd_poll_disable(xe);
 }
 
 
-- 
2.47.0


