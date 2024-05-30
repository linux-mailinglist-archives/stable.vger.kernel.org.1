Return-Path: <stable+bounces-47696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E709E8D491E
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 12:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E7C282737
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 10:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BD2169ACD;
	Thu, 30 May 2024 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R83T4z8O"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083AF18396D;
	Thu, 30 May 2024 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063329; cv=none; b=RO6TKHYmfCDymWm7nfg/5XbC5rsumkb9qY+PRnzYkV3j4cRacCzlr5e3sAk9kqZiV5Zlj+xU2X+N3Lwj8ZtdjDQN8C49DTb8XHhEub+pa+C9wfdaq32dpUzFQeY1QNb2VzeANTqDkGD8K8kMoqYHjCSzssrc0NCo/vM2T7r0RzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063329; c=relaxed/simple;
	bh=1LP2rTo7NH0u3HUMgvoQtIkwfwWpjfpCFYaEhS+TgdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GxglIErD6S4CYv44SZseejnN8HDEfo+fS/TVCwjUjAkHmdpfg1/u5hUqUizfaSgabkaYWDILodFr1sn4lozPKiy0tGD7NbWBdXc20YaapB0+kRMnukxiMeJI2zt6HtUF4/S7hCPNJ+wT5JtiFD5GpuuAoUPeDYihiYzjIqJWhmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R83T4z8O; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717063328; x=1748599328;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1LP2rTo7NH0u3HUMgvoQtIkwfwWpjfpCFYaEhS+TgdI=;
  b=R83T4z8O1rpXRNZ9Ji6yJHaVjStc4ZVqQg1wtDs7tcoO88ywDLuXjB4w
   O5Xbo3C4NTwMPvJmMe5Z26ILxCDOPLtZ5pN1ngvCIfQt4z180RvHe9etZ
   MwnZagCmmzrE+NaCmNGeNkeY5KyWMY73QBGF/AzP2S3yCuw2YOO1quIXw
   S4U6HsRFpDpbHo6WFYQUXRam1ULm4RAdNnxjsrfqCI+wNoXfFMwDLQuZj
   ZfBlGxZN4DXiclewHdB/gYf9vr5RIHqzuEKwQwwyMPqs1ThFFiHgPqTXP
   YoiRbCWGPK8tMYsH5ZMW3vcwVg/JkjOM5EHq8tVLXKP9TRFsiM4qQAszT
   A==;
X-CSE-ConnectionGUID: 54nMk7gVQSC6eP6wt2W/CQ==
X-CSE-MsgGUID: WFX1lcDkRTGCBVxNkai47A==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24942804"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="24942804"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 03:02:07 -0700
X-CSE-ConnectionGUID: 899tdr+XSt+622yob0QDcA==
X-CSE-MsgGUID: q2Tk505KSB+DoG7+DejYbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="40235059"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.132])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 03:02:04 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	Jani Nikula <jani.nikula@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] drm/exynos/vidi: fix memory leak in .get_modes()
Date: Thu, 30 May 2024 13:01:51 +0300
Message-Id: <20240530100154.317683-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

The duplicated EDID is never freed. Fix it.

Cc: stable@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index fab135308b70..11a720fef32b 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -309,6 +309,7 @@ static int vidi_get_modes(struct drm_connector *connector)
 	struct vidi_context *ctx = ctx_from_connector(connector);
 	struct edid *edid;
 	int edid_len;
+	int count;
 
 	/*
 	 * the edid data comes from user side and it would be set
@@ -328,7 +329,11 @@ static int vidi_get_modes(struct drm_connector *connector)
 
 	drm_connector_update_edid_property(connector, edid);
 
-	return drm_add_edid_modes(connector, edid);
+	count = drm_add_edid_modes(connector, edid);
+
+	kfree(edid);
+
+	return count;
 }
 
 static const struct drm_connector_helper_funcs vidi_connector_helper_funcs = {
-- 
2.39.2


