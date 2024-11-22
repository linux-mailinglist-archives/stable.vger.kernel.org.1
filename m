Return-Path: <stable+bounces-94666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33E59D6534
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36FAAB23663
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966F61DEFFC;
	Fri, 22 Nov 2024 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxLIQNxp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06DF1DFDBF
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309676; cv=none; b=J1RNhCiZvIOqqINxBX8ahi6nn/VfJS5WoVMM/vDzJvkynjaejCSA7I92GAY5YSaOdWY5ExWQrSFPSjtrGoP+jPRwRr8W2TI6XzxcdDL2NwMyplAor+GQSac0OvciwHq7hYKRwTSsS2lOBCJ1tj/nYucDyK8wogrOCGm8AmB/zMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309676; c=relaxed/simple;
	bh=0pJIEOOK9D1TVxpvnoebRbS5HIlLbuutsSPLoz2yCgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAqxL584T2xg4OeaiiLEOrYNCYU93OLLqUMnjgOr8aDfmzSm6WpTU9fmCuwYy2cv8fOVBgtXtMgNwaKtw7qnoqj0UU654V7QOFY2slNzR3Rx4okVx9XYoGugPU1qe6HtSDN5BjoIUScNg4AwMB+WUGECeYFronuFFcVxnII31Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxLIQNxp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309675; x=1763845675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0pJIEOOK9D1TVxpvnoebRbS5HIlLbuutsSPLoz2yCgI=;
  b=LxLIQNxpK2qFCB1prf5HUtzgPxxaDwnNDhYVA8LLd2h3ifD+w+RreLp0
   8iAVF3mggqwqQ+RHQ6hg0Luth9Ve1wPxUm9+BuOnjV0ds89UNT+q4VkwP
   z6vJV/5rda1ih0GHb5vxOVD4FOkNtplDGGjT1pNr4bGmT8LWaIj6ng2DC
   hbK2io20+j4XscFm9wEj/6zyYm16aRGYj7aVZEIjjKh4He+2Q7DKrqQiP
   jKzcwpr/XQITIQlGUNX038iay2db7Y6mSnc+E4zy/AjgwJ+2P5WMTiR1Y
   ReJG7nWe5HPkYJ180yuyA5T355mcKvY9xSOB0WmNQPnM7vo8Yv9y/PIDU
   g==;
X-CSE-ConnectionGUID: a4B0l0QyQgWYIcGslLWXTg==
X-CSE-MsgGUID: V8rv7P/ASqC1yjBcR6LTlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878287"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878287"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:44 -0800
X-CSE-ConnectionGUID: KWombwIHTbSCk3L0x47KHA==
X-CSE-MsgGUID: nMIgh4+NTF6ZGde4X2L1eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457300"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:44 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Aradhya Bhatia <aradhya.bhatia@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 30/31] drm/xe/xe2lpg: Extend Wa_15016589081 for xe2lpg
Date: Fri, 22 Nov 2024 13:07:18 -0800
Message-ID: <20241122210719.213373-31-lucas.demarchi@intel.com>
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

From: Aradhya Bhatia <aradhya.bhatia@intel.com>

commit 4ceead37ca9f5e555fe46e8528bd14dd1d2728e8 upstream.

Add workaround (wa) 15016589081 which applies to Xe2_v3_LPG_MD.

Xe2_v3_LPG_MD is a Lunar Lake platform with GFX version: 20.04.
This wa is type: permanent, and hence is applicable on all steppings.

Signed-off-by: Aradhya Bhatia <aradhya.bhatia@intel.com>
Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241009065542.283151-1-aradhya.bhatia@intel.com
(cherry picked from commit 8fb1da9f9bfb02f710a7f826d50781b0b030cf53)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_wa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index e2d7ccc6f144b..28c514b2aa3a1 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -710,6 +710,10 @@ static const struct xe_rtp_entry_sr lrc_was[] = {
 			     DIS_PARTIAL_AUTOSTRIP |
 			     DIS_AUTOSTRIP))
 	},
+	{ XE_RTP_NAME("15016589081"),
+	  XE_RTP_RULES(GRAPHICS_VERSION(2004), ENGINE_CLASS(RENDER)),
+	  XE_RTP_ACTIONS(SET(CHICKEN_RASTER_1, DIS_CLIP_NEGATIVE_BOUNDING_BOX))
+	},
 
 	/* Xe2_HPG */
 	{ XE_RTP_NAME("15010599737"),
-- 
2.47.0


