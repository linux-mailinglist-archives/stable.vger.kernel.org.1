Return-Path: <stable+bounces-87995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EFC9ADA91
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55F61F22445
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B2B16F271;
	Thu, 24 Oct 2024 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyE/ifGV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6E16E863
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741144; cv=none; b=fpSErrRiySTFoqRnEHZh+1PzWaCI8yu4Ath8KMMPUiwDHMbfivY6dth3U0ytKpFhtsC3TYDVQ+u0RFG5JDCP4ypOiA5qgRI5mFhoJ5NuzqUQPfBk4eOsgb/oM9KN+z1jn9Sbxs7Covbd+jFtSjQwiG2rAfeMQYj7wW6GQLV5Edg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741144; c=relaxed/simple;
	bh=2zzVvcPWJ+JFmxqG1sCxJ4PSjU5vNTb2jspDlEPk3NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7cDose80yLFcuGWtCEnKTiXSZgp4BxOjV7HCh/O55dkDU5J1iBik9A6hvC/+A4ofYOueKMdlNL0CrDAEA5g4OxNsF+OkWkxIDgivfRXS58K8Pm4zGYAVPjfFoArZkKewpYZnroqy6xpNbuX7+OCs0PftPDB+6fjNz3SPd4Xr3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyE/ifGV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741142; x=1761277142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2zzVvcPWJ+JFmxqG1sCxJ4PSjU5vNTb2jspDlEPk3NA=;
  b=cyE/ifGVLff0TJZtDYycuDGuDQuQ3gTIpNkO7aYABUEV7Df8oPOsxv7s
   TEcREe90+pNGy4y0YMfxQmsyZUCYDAq1eFQc4VAgC6EP5S9BVaqZcaLRU
   bBpEagSMltia1IQ2K1O5wng8kh+utt50/e4RENpHKgl8sgtJCsPBhOVG7
   0lZqjH8exBzkTaX5cIEqlmbygJrdLn3RiMcAyhFsrruwxPE0e6lsS2ktg
   /fhbjn8I5czMI4TXlze5YsKcH9JNcnqdrAuMp5EiTJNpJvNklxlyGIt/A
   WBHDVzODY/37s35+z0pReG+vZpZ+2S418KTwY2jQOrlbwknLhF1+oRLlW
   A==;
X-CSE-ConnectionGUID: mOZLV+EnQteu0h3rI/IFYA==
X-CSE-MsgGUID: OXiaO/sCSCySYoP1okdtdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33265002"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33265002"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:53 -0700
X-CSE-ConnectionGUID: UlXFsXriQwGvbnlpVPH0ig==
X-CSE-MsgGUID: WcMBxpJGSMeGEK17F3wpww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384983"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:51 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 16/22] drm/xe/mcr: Use Xe2_LPM steering tables for Xe2_HPM
Date: Wed, 23 Oct 2024 20:38:08 -0700
Message-ID: <20241024033815.3538736-16-lucas.demarchi@intel.com>
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

From: Gustavo Sousa <gustavo.sousa@intel.com>

commit 7929ffce0f8b9c76cb5c2a67d1966beaed20ab61 upstream.

According to Bspec, Xe2 steering tables must be used for Xe2_HPM, just
as it is with Xe2_LPM. Update our driver to reflect that.

Bspec: 71186
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240920211459.255181-2-gustavo.sousa@intel.com
(cherry picked from commit 21ae035ae5c33ef176f4062bd9d4aa973dde240b)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_gt_mcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_mcr.c b/drivers/gpu/drm/xe/xe_gt_mcr.c
index 6d948a4691264..d57a765a1a969 100644
--- a/drivers/gpu/drm/xe/xe_gt_mcr.c
+++ b/drivers/gpu/drm/xe/xe_gt_mcr.c
@@ -407,7 +407,7 @@ void xe_gt_mcr_init(struct xe_gt *gt)
 	if (gt->info.type == XE_GT_TYPE_MEDIA) {
 		drm_WARN_ON(&xe->drm, MEDIA_VER(xe) < 13);
 
-		if (MEDIA_VER(xe) >= 20) {
+		if (MEDIA_VERx100(xe) >= 1301) {
 			gt->steering[OADDRM].ranges = xe2lpm_gpmxmt_steering_table;
 			gt->steering[INSTANCE0].ranges = xe2lpm_instance0_steering_table;
 		} else {
-- 
2.47.0


