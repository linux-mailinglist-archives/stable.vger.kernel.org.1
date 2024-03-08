Return-Path: <stable+bounces-27160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4929C8767FD
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 17:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048F6283C6A
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A265D1D54D;
	Fri,  8 Mar 2024 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZ3NxBQ/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3CD539C
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913865; cv=none; b=Wbikb+lDeubXafGANX5ILW5Vxp+lMXU1yExE/ybFUJVGS/71bNofdEJfJYX0cVkvruK432/jEWStFQgSY6lD6WKV6PJXC0wEhmyA+7bO4iqAV470CpZlS0SPMbpw7ZbQNx2zJnl31UI1yyVjN+S4MvozBh0LuEZSo42i6c8TaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913865; c=relaxed/simple;
	bh=ZIhMoZY6IvnVeWvm+alFU0h92+PmjPQxvT5gbumIZFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AWNYp5a1zeXaTXW3qWr7rbrrq01xmi5BTUml/Mx7Fg1K4EU8KLk28pFFJdQ9FOXpFOusWsZZKKnF9J/dIQLEJqDMxbNvdSh/S1bPaSB6qnVnH1RsjmJOE1pGq5xBAQarNHbEdiK0v0dpIxWAy2LLm9a3Q34ZoionVH8FbO6eMvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZ3NxBQ/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709913864; x=1741449864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZIhMoZY6IvnVeWvm+alFU0h92+PmjPQxvT5gbumIZFY=;
  b=YZ3NxBQ/3Uuo1V9ntFtfyQ1rL313tANWQU4Yli8QltaL7wMw6QA4jgAR
   zzHtQU3e7I5r4yx5sYrD5qbz02BNS/mH0i8Vtsts2+k2E6gyVDsk1AVN/
   STsburI/JvTUhm8Lfg9SqifMJXMzUmFnvUV+BG/gf2cpikeN/Uu6u8KBw
   EGsZ/XB/KI0ZyvnON8tlcIbogtgKF/7h5DZ8bnQ5e4p47OdKdIp4fmlOv
   w8t+ZCSgfZFe9cRrYLeX6CoxNug0OxQgXWizfmMSicQjnpaCg3nJTDbo1
   tY5kCMyCs49jUwW9WdiryaWEWOVgC5I/WIkcNL0bkYqw3er062tAuNfDI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4522267"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4522267"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 08:04:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="15172881"
Received: from unknown (HELO localhost) ([10.252.34.187])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 08:04:20 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	jani.nikula@intel.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH 5/8] drm/imx/ipuv3: do not return negative values from .get_modes()
Date: Fri,  8 Mar 2024 18:03:43 +0200
Message-Id: <311f6eec96d47949b16a670529f4d89fcd97aefa.1709913674.git.jani.nikula@intel.com>
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

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/imx/ipuv3/parallel-display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/parallel-display.c b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
index 70349739dd89..55dedd73f528 100644
--- a/drivers/gpu/drm/imx/ipuv3/parallel-display.c
+++ b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
@@ -72,14 +72,14 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
 		int ret;
 
 		if (!mode)
-			return -EINVAL;
+			return 0;
 
 		ret = of_get_drm_display_mode(np, &imxpd->mode,
 					      &imxpd->bus_flags,
 					      OF_USE_NATIVE_MODE);
 		if (ret) {
 			drm_mode_destroy(connector->dev, mode);
-			return ret;
+			return 0;
 		}
 
 		drm_mode_copy(mode, &imxpd->mode);
-- 
2.39.2


