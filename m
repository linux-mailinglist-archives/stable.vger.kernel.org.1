Return-Path: <stable+bounces-34213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E12893E61
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A091C20A31
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921C74779E;
	Mon,  1 Apr 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="muK/e81q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFB4383BA;
	Mon,  1 Apr 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987365; cv=none; b=LAy1KxuvGFll+e75i+NeZGib/dV3RGafGh8cP0mjdVZwsezN+X80GsjNtazTda49evCipC41UwZ1OY/OGHCOsCGKt55QMQyml4x9mEpCdXiCL2yF08zZMpYL191XAT/mpfvybVbnLcefOjUA3b5GBX+OBa0MeDGJakrT2PvvfUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987365; c=relaxed/simple;
	bh=LdRrXTzlbyFKItxG7N89PXVwxbDNQbD3gmfnibVTYcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3T7hbjkDOiEbu67dJ5KOqbDllxjJQeXMLrLQP1H4zMVFlqxyPDLKyHHloOQSbgaPo8t3l4qPbZ71vNMPOH6s2O+pxeXqJE4sFHTJT4uMKyCLQXXsOeTew3uqNsVcqKZ6sv7abCBgqQtInB1g+mEwWQo6K0vYEd71wf4wiqpkDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=muK/e81q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AFDC433C7;
	Mon,  1 Apr 2024 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987365;
	bh=LdRrXTzlbyFKItxG7N89PXVwxbDNQbD3gmfnibVTYcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=muK/e81q3CEwIrRRVvOPm4wJqqNF9ISr97YLRovqaieXohzRa2q9z0mPvMs6lcJBy
	 jIrm4aq09ShfiOJ6KJ53t6bh21KkuyXt18dWhP3GBSxyMuKk82DiSAV2hBF19tWalx
	 5aOlzwj9yuYs2V20XPpUFwYLaxCptCvZJ9zGEk7E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrien Grassein <adrien.grassein@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 237/399] drm/bridge: lt8912b: use drm_bridge_edid_read()
Date: Mon,  1 Apr 2024 17:43:23 +0200
Message-ID: <20240401152556.252884678@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit 60d1fe1a7f302cc1151b155ac2d134db59bb1420 ]

Prefer using the struct drm_edid based functions.

cc: Adrien Grassein <adrien.grassein@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/32c9b52fe6fa7cbad6bfd0ff00041876977e02ea.1706038510.git.jani.nikula@intel.com
Stable-dep-of: 171b711b26cc ("drm/bridge: lt8912b: do not return negative values from .get_modes()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 273157428c827..4dc748d5d1ee0 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -440,16 +440,16 @@ lt8912_connector_mode_valid(struct drm_connector *connector,
 
 static int lt8912_connector_get_modes(struct drm_connector *connector)
 {
-	struct edid *edid;
+	const struct drm_edid *drm_edid;
 	int ret = -1;
 	int num = 0;
 	struct lt8912 *lt = connector_to_lt8912(connector);
 	u32 bus_format = MEDIA_BUS_FMT_RGB888_1X24;
 
-	edid = drm_bridge_get_edid(lt->hdmi_port, connector);
-	if (edid) {
-		drm_connector_update_edid_property(connector, edid);
-		num = drm_add_edid_modes(connector, edid);
+	drm_edid = drm_bridge_edid_read(lt->hdmi_port, connector);
+	if (drm_edid) {
+		drm_edid_connector_update(connector, drm_edid);
+		num = drm_edid_connector_add_modes(connector);
 	} else {
 		return ret;
 	}
@@ -459,7 +459,7 @@ static int lt8912_connector_get_modes(struct drm_connector *connector)
 	if (ret)
 		num = ret;
 
-	kfree(edid);
+	drm_edid_free(drm_edid);
 	return num;
 }
 
-- 
2.43.0




