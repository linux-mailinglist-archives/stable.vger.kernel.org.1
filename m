Return-Path: <stable+bounces-94657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C5F9D652B
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB89B161328
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED93185935;
	Fri, 22 Nov 2024 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEje2Yx6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6D118C027
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309672; cv=none; b=KKaGN1Ni6Kz1sr4bNvGyPKQ2m0wcg6mdgWgESn38b1rLvjuVt254hiuUUJleFRc6h/mAppLcbILVMSmdym5ZrtzErAnm/hhG0OMqBB4IlhRvJI8im6Kqla4W4dBXeTDLg0468G5Kt83OAPJan+2CJlPyiCs3G/UDELaNbmrSJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309672; c=relaxed/simple;
	bh=6u+B9cx5537OOT39ySdPpLeo6SiC0YLXqEUHt7QnwL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYBzYqtjAWL3Mez5REp8iLbZPiJukhpnXsVMtrgX2KeXwYsA+lzlozTj2DVoK+iFI0dXjgJztpuuWRGaSXb1HQpdWZGRaheLBkfrBSQtay3PQe3bWdgm7M37oj+/OQ94lrr8WwM1YY4pu5twoP9FRyiIAJ3mscGxTFpPaOJAF2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEje2Yx6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309671; x=1763845671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6u+B9cx5537OOT39ySdPpLeo6SiC0YLXqEUHt7QnwL0=;
  b=nEje2Yx6t/mZF65z79FqMQYPxnaY8YW67J+6WA1gpJv2y7gls0xzXkoS
   Rlgmocf2Uqgf35pDMuPZSrnUT7llPajBO/kYFjKbMx//7f+8an9gRIb4B
   TtqnNBoV6klLY0ktrBMlpHXdm5CpSXdlNtyBdUBDyDkLGG8KUI4Euncxb
   0QTjG1iYCn008S6DBAuax532yMoHlQeYQi8ia3SRTc9QaOA2Kc/wQ8Dvf
   fP7J8M8JN6neC8PuiclUiZhcCelOtz5+pdxuBCBzVyoUlxIrRB8c6pDDj
   exbfjMuY7oCs4uUDy4TJe6GMb8cFR3VjtOhc9kVI0gVRpY+gjQ+fJSR/j
   Q==;
X-CSE-ConnectionGUID: xOezS+EQRvSjvJhAciFrIg==
X-CSE-MsgGUID: IoabmWQ0S3qgJxXbBYpR1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878276"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878276"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:42 -0800
X-CSE-ConnectionGUID: XQ5b4/PIQtCvdE61kKSmGA==
X-CSE-MsgGUID: jmWCFfkTQmmoIxZH87y9GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457263"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:42 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Arun R Murthy <arun.r.murthy@intel.com>,
	Vinod Govindapillai <vinod.govindapillai@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 20/31] drm/xe: Fix missing conversion to xe_display_pm_runtime_resume
Date: Fri, 22 Nov 2024 13:07:08 -0800
Message-ID: <20241122210719.213373-21-lucas.demarchi@intel.com>
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

From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

commit 474f64cb988a410db8a0b779d6afdaa2a7fc5759 upstream.

This error path was missed when converting away from
xe_display_pm_resume with second argument.

Fixes: 66a0f6b9f5fc ("drm/xe/display: handle HPD polling in display runtime suspend/resume")
Cc: Arun R Murthy <arun.r.murthy@intel.com>
Cc: Vinod Govindapillai <vinod.govindapillai@intel.com>
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Vinod Govindapillai <vinod.govindapillai@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240905150052.174895-2-maarten.lankhorst@linux.intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 356c66fb74a4f..d6501048f6418 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -405,7 +405,7 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 		xe_display_pm_suspend_late(xe);
 out:
 	if (err)
-		xe_display_pm_resume(xe, true);
+		xe_display_pm_runtime_resume(xe);
 	xe_rpm_lockmap_release(xe);
 	xe_pm_write_callback_task(xe, NULL);
 	return err;
-- 
2.47.0


