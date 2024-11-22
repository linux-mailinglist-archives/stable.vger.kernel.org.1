Return-Path: <stable+bounces-94649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DBE9D6522
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB1F1613DC
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5331F1DF730;
	Fri, 22 Nov 2024 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8g7gwq8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2721531C8
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309669; cv=none; b=HPgMrgAuaTdLQzJylVrMy6zN8carzAMpXf91NJ7XrJc0QR3PfpMiyDfsyxvk87Lp62QMAR9oH+NucoBUZKfWOCZGeVq+PRjh9mMwgB2FYlar4MbtiS0Lbyu3Ydq4m6NLMKiUvKwKsn97u1CzQru1SgjCmaBwSx2rmktHpjR5kIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309669; c=relaxed/simple;
	bh=gvendXGs5DkqzIeF06vBe8Si3aEgdUocKbIijYod9Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmXdQuHMSY9pWmFXCYQpxBeMUlSPRH4SnxdusyvYHs5F2q7rbZ0nd8dpShCwa/pXNu76nFR4R6mCbX7Vw+bdn+drEzq4xt820LJzvjeVSLEGjXtVE14OfhSQvvNgkL4uD5x2tfG66fOZSZxA+1BHYo6b49e2EOA/VVnQgRJ0OSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8g7gwq8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309667; x=1763845667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gvendXGs5DkqzIeF06vBe8Si3aEgdUocKbIijYod9Go=;
  b=O8g7gwq8DOm+t6ar7fucqcUzSGu5+Pn6DgxfDsN0LlAuKFArZBY7s4Je
   IDg/V2lWqHsTWQ8fGDa3VhbAR3bZCWs+aJEdIE5cBM3eLGP5F3v65yM0A
   bjNJo0BX7abdZaKypI8a4A5hkiqy7UiI2ye+iP4WpbwFouzX7iDIi7D7K
   9KJF4PcVTiVfLwi+d6BaN9+CQFcinw+w87Eo6EsJljhIkI5p5A+63gRLo
   XuDoev3K2qnMXSKk1R2RPUxMhz2LIn7OGeuTcdWeSfI7BN8iAyczN3kaM
   IZJ2Lwzs5jS+tAX+BBGiGPF326ODA2fKZreVbvepQK3A+x8PrKgNqAfuq
   Q==;
X-CSE-ConnectionGUID: O2zyRi7ATXW9wOKVcfw+ag==
X-CSE-MsgGUID: 0zL+x9i3Rkyt+E9KVBNzng==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878268"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878268"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:41 -0800
X-CSE-ConnectionGUID: 9GuHrez4RryNDdbYr76yUw==
X-CSE-MsgGUID: QEB9SlKNQduYvs6t71guuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457221"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:41 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Arun R Murthy <arun.r.murthy@intel.com>,
	Vinod Govindapillai <vinod.govindapillai@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 12/31] drm/xe: Handle polling only for system s/r in xe_display_pm_suspend/resume()
Date: Fri, 22 Nov 2024 13:07:00 -0800
Message-ID: <20241122210719.213373-13-lucas.demarchi@intel.com>
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

commit 122824165471ea492d8b07d15384345940aababb upstream.

This is a preparation for the follow-up patch where polling
will be handled properly for all cases during runtime suspend/resume.

v2: rebased

Reviewed-by: Arun R Murthy <arun.r.murthy@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Vinod Govindapillai <vinod.govindapillai@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240823112148.327015-3-vinod.govindapillai@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index c860fda410c82..34b7050fc7c33 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -316,14 +316,11 @@ void xe_display_pm_suspend(struct xe_device *xe, bool runtime)
 	 */
 	intel_power_domains_disable(xe);
 	intel_fbdev_set_suspend(&xe->drm, FBINFO_STATE_SUSPENDED, true);
-	if (has_display(xe)) {
+	if (!runtime && has_display(xe)) {
 		drm_kms_helper_poll_disable(&xe->drm);
-		if (!runtime)
-			intel_display_driver_disable_user_access(xe);
-	}
-
-	if (!runtime)
+		intel_display_driver_disable_user_access(xe);
 		intel_display_driver_suspend(xe);
+	}
 
 	xe_display_flush_cleanup_work(xe);
 
@@ -380,15 +377,12 @@ void xe_display_pm_resume(struct xe_device *xe, bool runtime)
 
 	/* MST sideband requires HPD interrupts enabled */
 	intel_dp_mst_resume(xe);
-	if (!runtime)
+	if (!runtime && has_display(xe)) {
 		intel_display_driver_resume(xe);
-
-	if (has_display(xe)) {
 		drm_kms_helper_poll_enable(&xe->drm);
-		if (!runtime)
-			intel_display_driver_enable_user_access(xe);
+		intel_display_driver_enable_user_access(xe);
+		intel_hpd_poll_disable(xe);
 	}
-	intel_hpd_poll_disable(xe);
 
 	intel_opregion_resume(xe);
 
-- 
2.47.0


