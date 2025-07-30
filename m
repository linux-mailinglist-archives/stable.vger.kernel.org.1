Return-Path: <stable+bounces-165543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9626B16478
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5861564BDE
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79952DE6E7;
	Wed, 30 Jul 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=nicusor.huhulea@siemens.com header.b="iIaJRT+c"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1A52DAFA9
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892004; cv=none; b=IgIBISX4B8PBgHPAzkSsS5otxpDZ5KVfmWxVjJXBNXR9MwgV2rMZLoVQaD2ZgdN8KXT0M7O/2vEjGB3rVKJhh5JyUaKMBH/MCmsJ9UPJ87855YJuCPI8RqscX65n9je30tw63ZQau2xl5jWVtOme7q/FduUtUPirhcZ/8cP4uxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892004; c=relaxed/simple;
	bh=WXCnWgnITYQQ3SzA6kUiqvbTKy1ZnO7jKbuB+/feJ0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRA9PN+yVDQTfSXlFjuvIZfd+GMP2doQBtpBWO4q/LKtQiVpcGUs4Aarexbld2qXLAgnnIjw1JBu/TJ3YUR2u5PofrXmi5QRAtg7wePipvZDP/MMql2YTs1R+BOs9eK8QASZYOeUhmc5PgVA3+zLbtqqQ8VLRm7/QkDOi+5SUR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=nicusor.huhulea@siemens.com header.b=iIaJRT+c; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250730161314963f49c62ea0138602
        for <stable@vger.kernel.org>;
        Wed, 30 Jul 2025 18:13:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=nicusor.huhulea@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/FpSd6XrEiDlegW7TGUbZc+yNUb5v89AQii/650dub8=;
 b=iIaJRT+ccdwMSxtQ0LahuNcmrmJLW+d2XTD3d4FczQ11pSmyFkOSt4wZ/ax2EwnSCCS+ob
 L9oP7O5DwVwfuFyzO2w4CzWDoOr147DQqywYz/KnG/8KrI1ghYlq8p+dHQsE9GFGSwsRlxQn
 1Xjv69PVnzY1CXcH/uSsXFXk3m4J7le1hArDXgwR6Z4xqSLNe2SMkNvMWB0m75ZsGX8SADHR
 QR82HglZUd6fW8g0DVAf7/6p6zYWzlBkoH99WbCE2LFWf2ozRKEZaCcA3ilvhrk2zg7ky7B3
 BsNN8tgZktek7TtfGc6cfey+CAJA2OHfONnJ9eMrlNjl90sn6dwI4ocA==;
From: Nicusor Huhulea <nicusor.huhulea@siemens.com>
To: stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: cip-dev@lists.cip-project.org,
	imre.deak@intel.com,
	jouni.hogander@intel.com,
	neil.armstrong@linaro.org,
	jani.nikula@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tvrtko.ursulin@linux.intel.com,
	laurentiu.palcu@oss.nxp.com,
	cedric.hombourger@siemens.com,
	shrikant.bobade@siemens.com,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Nicusor Huhulea <nicusor.huhulea@siemens.com>
Subject: [PATCH 3/5] drm/probe_helper: extract two helper functions
Date: Wed, 30 Jul 2025 19:11:04 +0300
Message-Id: <20250730161106.80725-4-nicusor.huhulea@siemens.com>
In-Reply-To: <20250730161106.80725-1-nicusor.huhulea@siemens.com>
References: <20250730161106.80725-1-nicusor.huhulea@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1331196:519-21489:flowmailer

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

commit cbf143b282c64e59559cc8351c0b5b1ab4bbdcbe upstream

This is not a direct cherry-pick of the upstream commit. Only the helper
functions required as dependencies for "drm/i915: Fix HPD polling, reenabling
the output poll work as needed" were extracted from the original commit. The rest
of the code was not applied, as the codebase has diverged significantly.

This partial adaptation ensures that the required helpers are available for the
dependent fix, while minimizing changes to the existing code.

Extract drm_kms_helper_enable_hpd() and drm_kms_helper_disable_hpd(),
two helpers that enable and disable HPD handling on all device's
connectors.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230124104548.3234554-1-dmitry.baryshkov@linaro.org
Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 787f6699971f..938649e3a282 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -244,6 +244,45 @@ static void reschedule_output_poll_work(struct drm_device *dev)
 	schedule_delayed_work(&dev->mode_config.output_poll_work, delay);
 }
 
+static void drm_kms_helper_disable_hpd(struct drm_device *dev)
+{
+	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		const struct drm_connector_helper_funcs *funcs =
+			connector->helper_private;
+
+		if (funcs && funcs->disable_hpd)
+			funcs->disable_hpd(connector);
+	}
+	drm_connector_list_iter_end(&conn_iter);
+}
+
+static bool drm_kms_helper_enable_hpd(struct drm_device *dev)
+{
+	bool poll = false;
+	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		const struct drm_connector_helper_funcs *funcs =
+			connector->helper_private;
+
+		if (funcs && funcs->enable_hpd)
+			funcs->enable_hpd(connector);
+
+		if (connector->polled & (DRM_CONNECTOR_POLL_CONNECT |
+					 DRM_CONNECTOR_POLL_DISCONNECT))
+			poll = true;
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return poll;
+}
+
 /**
  * drm_kms_helper_poll_enable - re-enable output polling.
  * @dev: drm_device
-- 
2.39.2


