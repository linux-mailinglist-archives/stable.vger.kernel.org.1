Return-Path: <stable+bounces-87993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B699ADA8D
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62FC282E0E
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B537F16EB7C;
	Thu, 24 Oct 2024 03:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3ZUBlkN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B015887C
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741142; cv=none; b=AjSo6lmgUeCF++VQ1MjXe4WnxDgwacslikk6I8AKSAmPUcRuuorUG463JqIKJdlsvX/z/v2RlzHj1CUksSSDNrNgx4rPE+Y1oyfFUIzvryFGHyJg8WseRLlefTjyU+oOilCP5eTvCgpVa4p92m1hEIgV3TN2oEyr41cidOk2h3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741142; c=relaxed/simple;
	bh=6OcZ49qD24LOivX8MZ8dMGEC2+3b6VTq5wopg7o8fuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aa7eOvi3mtTl07To1K71Em0O1lGz3pMaiurMuArVGKuKrh5qhcorUN685Gu8vPGdtiGOekABXdD3D+o2B8SvSeI9477nFFpy20bKEyDuFROcMBdPU/eoSQfHcxeLQsCFv+MJqYI8VXxYZ7M5JlyT+j1IiaSWHOnn6G+8dKZ+6RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3ZUBlkN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741140; x=1761277140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6OcZ49qD24LOivX8MZ8dMGEC2+3b6VTq5wopg7o8fuo=;
  b=B3ZUBlkNaeEBVzfTmGBLSoeg8TClclSfdB2J6daeisewCCX1d2yzl/Ez
   y/xbdgr229JqgwgCT9yaMkwxM9sRLjHnua8R5WKSpd8WZ/ic2VPyLi9FV
   epxQ3SCasNDtyDmuPKGkUaGb8WLSxsTAeimGdGDLdJSM1bKktSiNVqnNS
   TU6IwVf2m8b8MVMSBuW6gwto9naMzUDtMt763H6TOwHPHyIrv/iBC999/
   OFHfApV48mmMG9edmZH/gFXKvuxJeiMDnRYI7BlgqQ07wwoK+dO2fHJjg
   dZucQKhjTprrkFxt1vv7sFDR1W5uNAQP9+6mJejrKB7fHXu5SEhm8yjDL
   A==;
X-CSE-ConnectionGUID: ppIFOIYiTcmy9pxV0NUiTA==
X-CSE-MsgGUID: reemXm36TPKoyY8j/PyH+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33264998"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33264998"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:52 -0700
X-CSE-ConnectionGUID: iMAYjd8USVi/KTf2KUpLtg==
X-CSE-MsgGUID: NACCN5/KTwynNYkMNwOsLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384974"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:50 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 13/22] drm/i915/display: Don't enable decompression on Xe2 with Tile4
Date: Wed, 23 Oct 2024 20:38:05 -0700
Message-ID: <20241024033815.3538736-13-lucas.demarchi@intel.com>
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

From: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>

commit 4cce34b3835b6f7dc52ee2da95c96b6364bb72e5 upstream.

>From now on expect Tile4 not to be using compression

Signed-off-by: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240816115229.531671-2-juhapekka.heikkila@gmail.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/display/skl_universal_plane.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index ba5a628b4757c..a1ab64db0130c 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -1085,11 +1085,6 @@ static u32 skl_plane_ctl(const struct intel_crtc_state *crtc_state,
 	if (DISPLAY_VER(dev_priv) == 13)
 		plane_ctl |= adlp_plane_ctl_arb_slots(plane_state);
 
-	if (GRAPHICS_VER(dev_priv) >= 20 &&
-	    fb->modifier == I915_FORMAT_MOD_4_TILED) {
-		plane_ctl |= PLANE_CTL_RENDER_DECOMPRESSION_ENABLE;
-	}
-
 	return plane_ctl;
 }
 
-- 
2.47.0


