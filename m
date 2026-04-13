Return-Path: <stable+bounces-235963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMsNJaqu3GnfVAkAu9opvQ
	(envelope-from <stable+bounces-235963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:51:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 345293E95EE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B54D4300FB5C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0753AD508;
	Mon, 13 Apr 2026 08:50:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8463AB29F
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070245; cv=none; b=f5KChAONBOklmFb3ieEuyeuaWWCrsSgtAzR2TA5foOLNbuPJo0OnXeidbTpDagyORquD1pEBPbfkpF8z+1Dgwa1Y7GQvPVqRGq+SN4JYK868Zna75H1mgcF2i0ZphuQ5rFENG10lifqKH7JQWt4SKXpnGZUNbvfvYo2Y18qoMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070245; c=relaxed/simple;
	bh=SrkCU6fzyLPhCQJnD/l8G+79/d1gx+afHo6RwDGcB5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCXf3xcBJkm64HfZhbRdT4ti00WCwiLO8irXM19kNH02ngF+hzM2/0wx0+/bmv69dIjYJdqXDSy0+stIM8XU+e5ipMJ8tsV518wUtybQ4luV7ePfnPXtkfBzPN2ux5pCSEsRm2P5zyLInc5/qt4GZnKhlEX082wHFxXxcYWBIIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88D3D6A901;
	Mon, 13 Apr 2026 08:50:42 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FB3E4ADD1;
	Mon, 13 Apr 2026 08:50:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wOZvAmKu3GkfKAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 13 Apr 2026 08:50:42 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: xinliang.liu@linaro.org,
	tiantao6@hisilicon.com,
	kong.kongxinwei@hisilicon.com,
	sumit.semwal@linaro.org,
	yongqin.liu@linaro.org,
	jstultz@google.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rongrong Zou <zourongrong@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Baihan Li <libaihan@huawei.com>,
	Yongbang Shi <shiyongbang@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] drm/hibmc: Use drm_atomic_helper_check_plane_state()
Date: Mon, 13 Apr 2026 10:40:01 +0200
Message-ID: <20260413085037.17491-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413085037.17491-1-tzimmermann@suse.de>
References: <20260413085037.17491-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235963-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,suse.de,gmail.com,chromium.org,kernel.org,huawei.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[linaro.org,hisilicon.com,google.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.927];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,chromium.org:email]
X-Rspamd-Queue-Id: 345293E95EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Call drm_atomic_helper_check_plane_state() from the primary plane's
atomic-check helper and replace the custom implementation.

All plane's implementations of atomic_check should call the shared
_check_plane_state() helper first. It adjusts the plane state for
correct positioning, rotation and scaling of the plane. If the plane
is not visible, it clears the corresponding flag in the plane state.

On errors or if the plane is not visible, the atomic-check helper can
return early. Implement all this in hibmc and drop the custom code
that does some of it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: da52605eea8f ("drm/hisilicon/hibmc: Add support for display engine")
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Baihan Li <libaihan@huawei.com>
Cc: Yongbang Shi <shiyongbang@huawei.com>
Cc: <stable@vger.kernel.org> # v4.10+
---
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 46 ++++++-------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index 89bed78f1466..8fa2a95bcdd1 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -55,46 +55,28 @@ static const struct hibmc_dislay_pll_config hibmc_pll_table[] = {
 static int hibmc_plane_atomic_check(struct drm_plane *plane,
 				    struct drm_atomic_state *state)
 {
-	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
-										 plane);
-	struct drm_framebuffer *fb = new_plane_state->fb;
-	struct drm_crtc *crtc = new_plane_state->crtc;
-	struct drm_crtc_state *crtc_state;
-	u32 src_w = new_plane_state->src_w >> 16;
-	u32 src_h = new_plane_state->src_h >> 16;
-
-	if (!crtc || !fb)
-		return 0;
+	struct drm_plane_state *new_plane_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc_state *new_crtc_state = NULL;
+	int ret;
 
-	crtc_state = drm_atomic_get_crtc_state(state, crtc);
-	if (IS_ERR(crtc_state))
-		return PTR_ERR(crtc_state);
+	if (new_plane_state->crtc)
+		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
 
-	if (src_w != new_plane_state->crtc_w || src_h != new_plane_state->crtc_h) {
-		drm_dbg_atomic(plane->dev, "scale not support\n");
-		return -EINVAL;
-	}
-
-	if (new_plane_state->crtc_x < 0 || new_plane_state->crtc_y < 0) {
-		drm_dbg_atomic(plane->dev, "crtc_x/y of drm_plane state is invalid\n");
-		return -EINVAL;
-	}
-
-	if (!crtc_state->enable)
+	ret = drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, true);
+	if (ret)
+		return ret;
+	else if (!new_plane_state->visible)
 		return 0;
 
-	if (new_plane_state->crtc_x + new_plane_state->crtc_w >
-	    crtc_state->adjusted_mode.hdisplay ||
-	    new_plane_state->crtc_y + new_plane_state->crtc_h >
-	    crtc_state->adjusted_mode.vdisplay) {
-		drm_dbg_atomic(plane->dev, "visible portion of plane is invalid\n");
-		return -EINVAL;
-	}
-
 	if (new_plane_state->fb->pitches[0] % 128 != 0) {
 		drm_dbg_atomic(plane->dev, "wrong stride with 128-byte aligned\n");
 		return -EINVAL;
 	}
+
 	return 0;
 }
 
-- 
2.53.0


