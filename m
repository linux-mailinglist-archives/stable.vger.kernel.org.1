Return-Path: <stable+bounces-268915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q5tcFFGCPmoxHQkAu9opvQ
	(envelope-from <stable+bounces-268915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:44:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A197C6CDA89
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:44:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yandex.ru header.s=mail header.b=LIj3K3Es;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268915-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268915-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=yandex.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0346C30C16C8
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB7D3F786F;
	Fri, 26 Jun 2026 13:40:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CB3F6C25;
	Fri, 26 Jun 2026 13:40:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481214; cv=none; b=ebm2MEelUCApZuh27N82CJ22SVkUphn1XdDn/BijY3UovfTHjLq6lrYkzNAmAIDDjxp/vB6QLgIIuDNVz5+9TcAq8+hnNuVCwvHl7jZ0T7Uz3e8ql5cGaPInVeW3s7lwfY+0aok5bKkPvXZUgyYNldlHuFLEDFMyGpRlMdolWf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481214; c=relaxed/simple;
	bh=+yIcYd7txG+ZhB7z6YVw2+F3PLGEia3MKLJeXMjyEKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAydsiphA+YPhFjVwVegMnJtVdHLkEa3VfAvzT4sZ5GbYLYf8xw6q12d1eE90Eej/fbyUY2awm/c9xoZ8c/TQDbb/nDaTgM4JT+8Tk1/QpGaxjkCWDH2SaV4aDg6L+P0TCa1lGadJBwx5Frv/3IxCFyCt/jtGObwEkr3enYpajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=LIj3K3Es; arc=none smtp.client-ip=178.154.239.83
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:582e:0:640:200:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id C44DDC0735;
	Fri, 26 Jun 2026 16:40:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp) with ESMTPSA id rdanEUkf5Gk0-AkfTld3r;
	Fri, 26 Jun 2026 16:40:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1782481200; bh=e9YMAmOw7IfaTS4/uOeKkF1326th313osWzDsbfnnqo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=LIj3K3EsdqMFaoe1y6wJVJzk0ObBELltGEm3Mf5hqdoomBHz5B2NUaF4Gw2FEtyXT
	 +n5leGC6MSBb1Zqj9s6SMJcVDK52G/Xo0i5Cm26D73OT6z6W+//x+GXD9n1vD36dcG
	 0dYGAWirlFQF0LxVv7qo8YNHWpATZ4FaoOM4sLZg=
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	mario.limonciello@amd.com,
	alex.hung@amd.com,
	superm1@kernel.org,
	timur.kristof@gmail.com,
	ivan.lipski@amd.com,
	ray.wu@amd.com,
	aurabindo.pillai@amd.com,
	chen-yu.chen@amd.com,
	mripard@kernel.org,
	Dillon.Varone@amd.com,
	mwen@igalia.com,
	chiahsuan.chung@amd.com,
	kenneth.feng@amd.com,
	srinivasan.shanmugam@amd.com,
	contact@emersion.fr,
	Alvin.Lee2@amd.com,
	chaitanya.kumar.borah@intel.com,
	dmitry.baryshkov@oss.qualcomm.com,
	pierre-eric.pelloux-prayer@amd.com,
	ekurzinger@gmail.com,
	HaoPing.Liu@amd.com,
	Tony.Cheng@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] drm/amd/display: Fix dangling pointers in state reset functions on allocation failure
Date: Fri, 26 Jun 2026 16:38:49 +0300
Message-ID: <20260626133859.21492-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268915-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[yandex.ru,amd.com,igalia.com,gmail.com,ffwll.ch,kernel.org,emersion.fr,intel.com,oss.qualcomm.com,lists.freedesktop.org,vger.kernel.org,linuxtesting.org];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:evg28bur@yandex.ru,m:harry.wentland@amd.com,m:sunpeng.li@amd.com,m:siqueira@igalia.com,m:alexander.deucher@amd.com,m:christian.koenig@amd.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:mario.limonciello@amd.com,m:alex.hung@amd.com,m:superm1@kernel.org,m:timur.kristof@gmail.com,m:ivan.lipski@amd.com,m:ray.wu@amd.com,m:aurabindo.pillai@amd.com,m:chen-yu.chen@amd.com,m:mripard@kernel.org,m:Dillon.Varone@amd.com,m:mwen@igalia.com,m:chiahsuan.chung@amd.com,m:kenneth.feng@amd.com,m:srinivasan.shanmugam@amd.com,m:contact@emersion.fr,m:Alvin.Lee2@amd.com,m:chaitanya.kumar.borah@intel.com,m:dmitry.baryshkov@oss.qualcomm.com,m:pierre-eric.pelloux-prayer@amd.com,m:ekurzinger@gmail.com,m:HaoPing.Liu@amd.com,m:Tony.Cheng@amd.com,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:timurkristof@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yandex.ru:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxtesting.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A197C6CDA89

Multiple reset functions in amdgpu_dm free the old state before allocating
a new one. If kzalloc_obj() fails, the function returns without updating
the state pointer, leaving a dangling pointer to already freed memory.

Fix this by allocating the new state first. If allocation fails, warn and
return without touching the old state, as it remains valid and the caller
will handle the error appropriately.

This affects three functions:
- amdgpu_dm_plane_drm_plane_reset()
- amdgpu_dm_crtc_reset_state()
- amdgpu_dm_connector_funcs_reset()

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5d945cbcd4b1 ("drm/amd/display: Create a file dedicated to planes")
Fixes: 473683a03495 ("drm/amd/display: Create a file dedicated for CRTC")
Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_types and amdgpu_dm")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
Changes in v2:
- Also fix amdgpu_dm_crtc_reset_state() and amdgpu_dm_connector_funcs_reset()
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 48 ++++++++++---------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  8 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 14 +++---
 3 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 97ab1e83b318..6ef1b07ec251 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8151,33 +8151,35 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 
 void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
 {
-	struct dm_connector_state *state =
-		to_dm_connector_state(connector->state);
-
-	if (connector->state)
-		__drm_atomic_helper_connector_destroy_state(connector->state);
-
-	kfree(state);
+	struct dm_connector_state *state;
 
+	/* Allocate new state first */
 	state = kzalloc_obj(*state);
+	if (WARN_ON(!state))
+		return;
 
-	if (state) {
-		state->scaling = RMX_OFF;
-		state->underscan_enable = false;
-		state->underscan_hborder = 0;
-		state->underscan_vborder = 0;
-		state->base.max_requested_bpc = 8;
-		state->vcpi_slots = 0;
-		state->pbn = 0;
-
-		if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
-			if (amdgpu_dm_abm_level <= 0)
-				state->abm_level = ABM_LEVEL_IMMEDIATE_DISABLE;
-			else
-				state->abm_level = amdgpu_dm_abm_level;
-		}
+	/* Destroy old state only after successful allocation */
+	if (connector->state)
+		__drm_atomic_helper_connector_destroy_state(connector->state);
 
-		__drm_atomic_helper_connector_reset(connector, &state->base);
+	/* Let DRM core install the new state */
+	__drm_atomic_helper_connector_reset(connector, &state->base);
+
+	/* Initialize driver-specific fields */
+	state->scaling = RMX_OFF;
+	state->underscan_enable = false;
+	state->underscan_hborder = 0;
+	state->underscan_vborder = 0;
+	state->base.max_requested_bpc = 8;
+	state->vcpi_slots = 0;
+	state->pbn = 0;
+
+	/* eDP-specific initialization */
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+		if (amdgpu_dm_abm_level <= 0)
+			state->abm_level = ABM_LEVEL_IMMEDIATE_DISABLE;
+		else
+			state->abm_level = amdgpu_dm_abm_level;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 3dcedaa67ed8..6146fbc528c3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -437,13 +437,15 @@ static void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
 {
 	struct dm_crtc_state *state;
 
-	if (crtc->state)
-		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
-
+	/* Allocate new state first */
 	state = kzalloc_obj(*state);
 	if (WARN_ON(!state))
 		return;
 
+	/* Destroy old state only after successful allocation */
+	if (crtc->state)
+		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
+
 	__drm_atomic_helper_crtc_reset(crtc, &state->base);
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index e957657b06c7..eb1c0a26f20d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1488,17 +1488,17 @@ static const struct drm_plane_helper_funcs dm_primary_plane_helper_funcs = {
 
 static void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
 {
-	struct dm_plane_state *amdgpu_state = NULL;
-
-	if (plane->state)
-		plane->funcs->atomic_destroy_state(plane, plane->state);
+	struct dm_plane_state *amdgpu_state;
 
+	/* Allocate new state first */
 	amdgpu_state = kzalloc_obj(*amdgpu_state);
-	WARN_ON(amdgpu_state == NULL);
-
-	if (!amdgpu_state)
+	if (WARN_ON(!amdgpu_state))
 		return;
 
+	/* Destroy old state only after successful allocation */
+	if (plane->state)
+		plane->funcs->atomic_destroy_state(plane, plane->state);
+
 	__drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
 	amdgpu_state->degamma_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
 	amdgpu_state->hdr_mult = AMDGPU_HDR_MULT_DEFAULT;
-- 
2.43.0


