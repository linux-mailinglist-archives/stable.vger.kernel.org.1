Return-Path: <stable+bounces-165545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED77B1647C
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B4656555B
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928E02DE6EA;
	Wed, 30 Jul 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=nicusor.huhulea@siemens.com header.b="OQnyxUHD"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A82DE216
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892005; cv=none; b=Gm09wTXrGuTX/GGjOPnm68JwIQ9qJAgw8KxLJq8ipdvQlVTan7GxX17yslQmhAxv5+SRb+M8R1zVgF7K1NZcZw+KhZzHflnm8PDS838v80m3Qo62kqRP/firlQNBpdBofAFcakiSrvX5LVTZsMeCESuAIe95Fe1EPf8N9T9JgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892005; c=relaxed/simple;
	bh=+CbQzN6Fvf7hKFsLQ/AE4SPgFBKtJMP3wqf2Q7cYuFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U38E9CDNTIu6kD4TrU4SW5jlAlgFlTowkqMmfRHGqo6V0UN5DD6EFtiWAeSNGFPZXhqAvgvXUKttPikKIyrZgJAKHMv671JfCCzVd3UECqNRPm6Cqxw90NEggwURfeoDi5q7k/dEudv0LajexewjIEIzvKgSWnZKxWuNRLumfms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=nicusor.huhulea@siemens.com header.b=OQnyxUHD; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250730161315a0c6888443cec2d34f
        for <stable@vger.kernel.org>;
        Wed, 30 Jul 2025 18:13:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=nicusor.huhulea@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=YFPzJYoDv3cX+8o/GvSkSkoQ51LHu7AECjzM4Hsiq/U=;
 b=OQnyxUHD5CsAuL9spD+tylm+gUMS42osIg5+Pz8wfGHWjkYP3maOoQjmUpfjRO7BEMe6XI
 n+0RNaAGAvvn+PgdgU6NGC9zs6VnMjXQT/M4wBBHHWrDoosgfSArgqwu9xUOnok6qCa2+Wdy
 33WMdR11z4kiDcMbb3w6b0GmUMjojVuJL/yVvPlQKudonxYSknWC+33q2A0hYbUUISPgUksw
 DhAbgeQLKWz4WLnVeOgrHgrRMVrbWSiNoS5t45uSN5CFtuX/luPAfM5Z5ShoF+MFkteMAWq/
 e2IjBnekR2aNq1Fyab2hgXllDLVC8abdxIIyTOvWwfEOqoB4uiGexfmg==;
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
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Nicusor Huhulea <nicusor.huhulea@siemens.com>
Subject: [PATCH 4/5] drm/probe-helper: enable and disable HPD on connectors
Date: Wed, 30 Jul 2025 19:11:05 +0300
Message-Id: <20250730161106.80725-5-nicusor.huhulea@siemens.com>
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

commit c8268795c9a9cc7be50f78d4502fad83a2a4f8df upstream

This is not a direct cherry-pick of the upstream commit.
Only the helper functions required as dependencies for
"drm/i915: Fix HPD polling, reenabling the output poll work as needed"
were extracted from the original commit. The rest of the code was not
applied, as the codebase has diverged significantly from upstream.

This partial adaptation ensures that the required drm_connector_helper_funcs
are available for the dependent fix, while minimizing changes to the existing code.

Introduce two drm_connector_helper_funcs: enable_hpd() and disable_hpd().
They are called by drm_kms_helper_poll_enable() and
drm_kms_helper_poll_disable() (and thus drm_kms_helper_poll_init() and
drm_kms_helper_poll_fini()) respectively.

This allows DRM drivers to rely on drm_kms_helper_poll for enabling and
disabling HPD detection rather than doing that manually.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20221102180705.459294-3-dmitry.baryshkov@linaro.org
Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
---
 include/drm/drm_modeset_helper_vtables.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 6f19cf5c210e..54f4848a655a 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1144,6 +1144,28 @@ struct drm_connector_helper_funcs {
 	 */
 	void (*cleanup_writeback_job)(struct drm_writeback_connector *connector,
 				      struct drm_writeback_job *job);
+
+	/**
+	 * @enable_hpd:
+	 *
+	 * Enable hot-plug detection for the connector.
+	 *
+	 * This operation is optional.
+	 *
+	 * This callback is used by the drm_kms_helper_poll_enable() helpers.
+	 */
+	void (*enable_hpd)(struct drm_connector *connector);
+
+	/**
+	 * @disable_hpd:
+	 *
+	 * Disable hot-plug detection for the connector.
+	 *
+	 * This operation is optional.
+	 *
+	 * This callback is used by the drm_kms_helper_poll_disable() helpers.
+	 */
+	void (*disable_hpd)(struct drm_connector *connector);
 };
 
 /**
-- 
2.39.2


