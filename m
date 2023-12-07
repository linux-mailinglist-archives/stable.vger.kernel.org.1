Return-Path: <stable+bounces-4914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F978084D1
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 10:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50E01C21AEC
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D0B35261;
	Thu,  7 Dec 2023 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4F/DIEh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D972DAC
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 01:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701941908; x=1733477908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NRCb2skgWUY6/0k+GgOYc1syRPquz6NY6LhlUq60Bi8=;
  b=f4F/DIEhI4bqE97XEbAWG31cjlqbmbSeeKKYmbPEvcbPlq+Fjwgn22AC
   3RV675F5T7PyHG+vokhAJCPG4tFVgT1mzfcLyn0dbEeIT/cwudAIT+22/
   3aN8YE+mIH6YPTe3XoP2DZIgezOmlmv34Lf5gKjvZpNvXpz4k7YHY0nHV
   xYDXm4rks/CZ6Cf8HCz7NRgj+7dur0X5rwYjdg088pl+UHxp0SF/mOM8r
   Jvompm83/n39SUWWyV6uip0mrmDmdVaUccz8xCoKOSPE7l9PYdeUn/Iti
   yNT3hQCWsGmXX7MByoIf9pNVMR5MLE26XF21Dj5OelF2XARyXvg4m5FJA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="391378211"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="391378211"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 01:38:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="771668691"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="771668691"
Received: from mrehana-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.62.169])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 01:38:25 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	jani.nikula@intel.com,
	bbaa <bbaa@bbaa.fun>,
	stable@vger.kernel.org
Subject: [PATCH] drm/edid: also call add modes in EDID connector update fallback
Date: Thu,  7 Dec 2023 11:38:21 +0200
Message-Id: <20231207093821.2654267-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

When the separate add modes call was added back in commit c533b5167c7e
("drm/edid: add separate drm_edid_connector_add_modes()"), it failed to
address drm_edid_override_connector_update(). Also call add modes there.

Reported-by: bbaa <bbaa@bbaa.fun>
Closes: https://lore.kernel.org/r/930E9B4C7D91FDFF+29b34d89-8658-4910-966a-c772f320ea03@bbaa.fun
Fixes: c533b5167c7e ("drm/edid: add separate drm_edid_connector_add_modes()")
Cc: <stable@vger.kernel.org> # v6.3+
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/drm_edid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index cb4031d5dcbb..69c68804023f 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2311,7 +2311,8 @@ int drm_edid_override_connector_update(struct drm_connector *connector)
 
 	override = drm_edid_override_get(connector);
 	if (override) {
-		num_modes = drm_edid_connector_update(connector, override);
+		if (drm_edid_connector_update(connector, override) == 0)
+			num_modes = drm_edid_connector_add_modes(connector);
 
 		drm_edid_free(override);
 
-- 
2.39.2


