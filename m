Return-Path: <stable+bounces-27161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833348767FF
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 17:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399DD1F22F68
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A0125759;
	Fri,  8 Mar 2024 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CG8CNpxx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09519539C
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913868; cv=none; b=PqUD5pUZR7zTCPKZx54h+yTBjyL9hUoMMOe3A2C21ExB5H2xZVSxvsAX6Y9xDWWTsURDRwj/Q0xaCtXNjJ8ZauCTdD13MHbG5sklSCAHmJ3MH/4wKi6uDvCLHOOF+25oEndJ8GIlLfuJE0G6TgLDxmXAkEXXqDUzqRPShBylzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913868; c=relaxed/simple;
	bh=KXJrWvv1xKt2KLA8a50uHO5Sfo6P1Jlo6SC0EB4ahKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wxg7ASvkKwuhL0DHAvzGUBYY3egJ7QNAulQukKlyV51F4fPiJhR1uN4PEVk8u61GoXBGyqZMpXn2Ej1x+u/hJTIoSbUfkBvN3sn+zCYZ7zj+NJ91AheN4d242/Etof1Jj+bi8TdIb/AQx/B9mo1fxcCoZTuBtH17iHUNTTBsLVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CG8CNpxx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709913867; x=1741449867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KXJrWvv1xKt2KLA8a50uHO5Sfo6P1Jlo6SC0EB4ahKY=;
  b=CG8CNpxxEfEp2fazKJycjoNAmrnRjPGy41UyijTjY6UpfbTV86fvKchN
   P7LBdF3R7e0d0DnBcH6PNVP0vaAmXy8TAR4wDTKJAxaTb/3eCaGGx4Mbh
   ux74p2V5NhM4cF8JBb+yOq/6vc0K65nAZLWeBpC4PzfA4nM0znqZh8KR2
   F0Ic4dHpXgqeIy85g8Sf8wBM9vu0MuqGgmD2u8Y+/wuMwKnkbEOZdFO+J
   lkjdRtdUMiFGqw7jVHJmWqYEf7renFVaxm1mD0uGEtMUFerG0uImknsmU
   dyd69jC0Nehul67rDS0N9PgiYs9v9nRnkPIkV/IMsGs02O8TAQqYqmtEU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4522298"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4522298"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 08:04:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="15172897"
Received: from unknown (HELO localhost) ([10.252.34.187])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 08:04:25 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	jani.nikula@intel.com,
	Maxime Ripard <mripard@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 6/8] drm/vc4: hdmi: do not return negative values from .get_modes()
Date: Fri,  8 Mar 2024 18:03:44 +0200
Message-Id: <dcda6d4003e2c6192987916b35c7304732800e08.1709913674.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1709913674.git.jani.nikula@intel.com>
References: <cover.1709913674.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

The .get_modes() hooks aren't supposed to return negative error
codes. Return 0 for no modes, whatever the reason.

Cc: Maxime Ripard <mripard@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 34f807ed1c31..d8751ea20303 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -509,7 +509,7 @@ static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
 	edid = drm_get_edid(connector, vc4_hdmi->ddc);
 	cec_s_phys_addr_from_edid(vc4_hdmi->cec_adap, edid);
 	if (!edid)
-		return -ENODEV;
+		return 0;
 
 	drm_connector_update_edid_property(connector, edid);
 	ret = drm_add_edid_modes(connector, edid);
-- 
2.39.2


