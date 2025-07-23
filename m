Return-Path: <stable+bounces-164430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD84B0F2A0
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 14:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603F0543A4E
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 12:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759582E7165;
	Wed, 23 Jul 2025 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=nicusor.huhulea@siemens.com header.b="FP5C+JhI"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F32E6106
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275294; cv=none; b=IRse8JWx0cplXZ/is1fyEFRljLmBmB1PAG1u9ahW1jKNdoDZ4Yb8LuNTFeQ/Sa/r7TjTgs6cd0mXUkDqT2owBDaP+iH8MGe77nQzx+YHyXPlNVHDaV54EWy0cgX2MO8wvbchVexZJybwj4ZYDEoxRsKd18jRta44/D72AuW1WX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275294; c=relaxed/simple;
	bh=ha+tBCcIRY+7jsPxaY6CUPv0X1znuHXWE4XibZ/EoOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFhtIlGjfsKAdYVVfkeblRgnkFPEDJ/GKLF02zrchOhEbmdHojhTZh/gQmtnOl0Zrrhec9WIyyCMEgGndHb/h4B2Gv1f2/nZyGVztPxh4qyPQoWLfUeC9JM+5tV37HPdg28tw3gZc9N7cHHtZetv9q8LsYsnSAKY6optJkACpKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=nicusor.huhulea@siemens.com header.b=FP5C+JhI; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202507231254471495684a0af4589d34
        for <stable@vger.kernel.org>;
        Wed, 23 Jul 2025 14:54:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=nicusor.huhulea@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mMY6koi/7lGlCmPZAEmoeOab4VQfFn7AF6DFerqVnfM=;
 b=FP5C+JhIkIjA3o7aTijHB9mC8ddi7RfjWn0AnegaYMsWswwi7ZXtIxMjmhJSAmxNOYTh1F
 GdvAzKNcdx/6MwOpL1Abb1SGnMeWpj8inwNjNIVEGaWf+0zwfHavyt4ALa58dchQgy4GdoKN
 elrJl9yEammFwF+aVR3+ulWdFhPdYQ/RenJ+QXlz49fgaHmO+VSBmy7a40xIzTjeFcpwq3Ov
 gDuWjQ3/2Xa2Gc2fXjTDXBT+CwYvMY269FE1C1QB4fPBO7G+0Wp38fQflsiubjnmB/TTrc7Y
 QzSLmpnrq8waa35iN8pDO9nrQw8MBeHb48oEekLXFrCZZTWBEBUvH7nA==;
From: Nicusor Huhulea <nicusor.huhulea@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Imre Deak <imre.deak@intel.com>,
	stable@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Nicusor Huhulea <nicusor.huhulea@siemens.com>
Subject: [PATCH 6.1.y-cip 2/5] [PARTIAL BACKPORT]drm: Add an HPD poll helper to reschedule the poll work
Date: Wed, 23 Jul 2025 15:54:24 +0300
Message-Id: <20250723125427.59324-3-nicusor.huhulea@siemens.com>
In-Reply-To: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
References: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1331196:519-21489:flowmailer

From: Imre Deak <imre.deak@intel.com>

Add a helper to reschedule drm_mode_config::output_poll_work after
polling has been enabled for a connector (and needing a reschedule,
since previously polling was disabled for all connectors and hence
output_poll_work was not running).

This is needed by the next patch fixing HPD polling on i915.

CC: stable@vger.kernel.org # 6.4+
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230822113015.41224-1-imre.deak@intel.com
(cherry picked from commit fe2352fd64029918174de4b460dfe6df0c6911cd)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Partial-Backport-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 74 +++++++++++++++++++-----------
 include/drm/drm_probe_helper.h     |  1 +
 2 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 0e5eadc6d44de..787f6699971f1 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -224,6 +224,26 @@ drm_connector_mode_valid(struct drm_connector *connector,
 }
 
 #define DRM_OUTPUT_POLL_PERIOD (10*HZ)
+static void reschedule_output_poll_work(struct drm_device *dev)
+{
+	unsigned long delay = DRM_OUTPUT_POLL_PERIOD;
+
+	if (dev->mode_config.delayed_event)
+		/*
+		 * FIXME:
+		 *
+		 * Use short (1s) delay to handle the initial delayed event.
+		 * This delay should not be needed, but Optimus/nouveau will
+		 * fail in a mysterious way if the delayed event is handled as
+		 * soon as possible like it is done in
+		 * drm_helper_probe_single_connector_modes() in case the poll
+		 * was enabled before.
+		 */
+		delay = HZ;
+
+	schedule_delayed_work(&dev->mode_config.output_poll_work, delay);
+}
+
 /**
  * drm_kms_helper_poll_enable - re-enable output polling.
  * @dev: drm_device
@@ -244,43 +264,45 @@ drm_connector_mode_valid(struct drm_connector *connector,
  */
 void drm_kms_helper_poll_enable(struct drm_device *dev)
 {
-	bool poll = false;
+
 	struct drm_connector *connector;
 	struct drm_connector_list_iter conn_iter;
-	unsigned long delay = DRM_OUTPUT_POLL_PERIOD;
 
 	if (drm_WARN_ON_ONCE(dev, !dev->mode_config.poll_enabled) ||
 	    !drm_kms_helper_poll || dev->mode_config.poll_running)
 		return;
 
-	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
-		if (connector->polled & (DRM_CONNECTOR_POLL_CONNECT |
-					 DRM_CONNECTOR_POLL_DISCONNECT))
-			poll = true;
-	}
-	drm_connector_list_iter_end(&conn_iter);
+	if (drm_kms_helper_enable_hpd(dev) ||
+	    dev->mode_config.delayed_event)
+		reschedule_output_poll_work(dev);
 
-	if (dev->mode_config.delayed_event) {
-		/*
-		 * FIXME:
-		 *
-		 * Use short (1s) delay to handle the initial delayed event.
-		 * This delay should not be needed, but Optimus/nouveau will
-		 * fail in a mysterious way if the delayed event is handled as
-		 * soon as possible like it is done in
-		 * drm_helper_probe_single_connector_modes() in case the poll
-		 * was enabled before.
-		 */
-		poll = true;
-		delay = HZ;
-	}
-
-	if (poll)
-		schedule_delayed_work(&dev->mode_config.output_poll_work, delay);
+	dev->mode_config.poll_running = true;
 }
 EXPORT_SYMBOL(drm_kms_helper_poll_enable);
 
+/**
+ * drm_kms_helper_poll_reschedule - reschedule the output polling work
+ * @dev: drm_device
+ *
+ * This function reschedules the output polling work, after polling for a
+ * connector has been enabled.
+ *
+ * Drivers must call this helper after enabling polling for a connector by
+ * setting %DRM_CONNECTOR_POLL_CONNECT / %DRM_CONNECTOR_POLL_DISCONNECT flags
+ * in drm_connector::polled. Note that after disabling polling by clearing these
+ * flags for a connector will stop the output polling work automatically if
+ * the polling is disabled for all other connectors as well.
+ *
+ * The function can be called only after polling has been enabled by calling
+ * drm_kms_helper_poll_init() / drm_kms_helper_poll_enable().
+ */
+void drm_kms_helper_poll_reschedule(struct drm_device *dev)
+{
+	if (dev->mode_config.poll_running)
+		reschedule_output_poll_work(dev);
+}
+EXPORT_SYMBOL(drm_kms_helper_poll_reschedule);
+
 static enum drm_connector_status
 drm_helper_probe_detect_ctx(struct drm_connector *connector, bool force)
 {
diff --git a/include/drm/drm_probe_helper.h b/include/drm/drm_probe_helper.h
index 5880daa146240..429a85f38036a 100644
--- a/include/drm/drm_probe_helper.h
+++ b/include/drm/drm_probe_helper.h
@@ -25,6 +25,7 @@ void drm_kms_helper_connector_hotplug_event(struct drm_connector *connector);
 
 void drm_kms_helper_poll_disable(struct drm_device *dev);
 void drm_kms_helper_poll_enable(struct drm_device *dev);
+void drm_kms_helper_poll_reschedule(struct drm_device *dev);
 bool drm_kms_helper_is_poll_worker(void);
 
 enum drm_mode_status drm_crtc_helper_mode_valid_fixed(struct drm_crtc *crtc,
-- 
2.39.2


