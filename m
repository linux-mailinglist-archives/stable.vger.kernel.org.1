Return-Path: <stable+bounces-210975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFLCG00wcWmcfAAAu9opvQ
	(envelope-from <stable+bounces-210975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:00:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F11945CB82
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4505A6CC39
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D92C332ED0;
	Wed, 21 Jan 2026 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Us0cNAxr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB4B33DECE;
	Wed, 21 Jan 2026 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020015; cv=none; b=DLyfiqD9odI+ULadNReIlhfwGGGju7WdYalweFl7a8aSY6EbK4srDZAYpqLl6tEh++3Y/8G4MY9qrqHqV1+jtMUq3bLS7J02PUKUcSGWDZSca848kLNGqeZvb49eeXpqZQt2DjwxXOrT5xFkJEDDNrfxX2DiAEbw+ga9lCxw4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020015; c=relaxed/simple;
	bh=LeqHAOMU8SG2C1mTUCxCnFBnvNetOLVkYSeSXk5zSCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/2w2CooibiEsKBHH51gRJeUVtjR3SQ+q1ixjSIloIucrbEbDdrTXJs5OOk7XhG7ARe6/DK7rBtkSDDDVToS2hvR25FRQeS0vXBUazWGBnudee6umTu+MTqQVsmGFBXJb3qJ8vzCPI8nNpP5DrvdyjCcVKW57BSUOCxhmXIT3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Us0cNAxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A418FC4CEF1;
	Wed, 21 Jan 2026 18:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020015;
	bh=LeqHAOMU8SG2C1mTUCxCnFBnvNetOLVkYSeSXk5zSCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Us0cNAxrrsShO7ZHGZIEelXNeqtufQ4QN3MvgOxIuYbTDrtZHjmRoZGtCRgYT3CL/
	 EeUAKUesais3kHlP0XHGRXBXRN5OlLofsIy51TLjsZHs9mjBI42BUjCDKhYrdtjBFl
	 7YNrV1Ks4GIo4p1dgO6TwP3/YuATS09xnT7znrpU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shenghao Yang <me@shenghaoyang.info>,
	Ruben Wauters <rubenru09@aol.com>
Subject: [PATCH 6.18 009/198] drm/gud: fix NULL fb and crtc dereferences on USB disconnect
Date: Wed, 21 Jan 2026 19:13:57 +0100
Message-ID: <20260121181418.881060368@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-210975-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,shenghaoyang.info,aol.com];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: F11945CB82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shenghao Yang <me@shenghaoyang.info>

commit dc2d5ddb193e363187bae2ad358245642d2721fb upstream.

On disconnect drm_atomic_helper_disable_all() is called which
sets both the fb and crtc for a plane to NULL before invoking a commit.

This causes a kernel oops on every display disconnect.

Add guards for those dereferences.

Cc: <stable@vger.kernel.org> # 6.18.x
Fixes: 73cfd166e045 ("drm/gud: Replace simple display pipe with DRM atomic helpers")
Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
Reviewed-by: Ruben Wauters <rubenru09@aol.com>
Signed-off-by: Ruben Wauters <rubenru09@aol.com>
Link: https://patch.msgid.link/20251231055039.44266-1-me@shenghaoyang.info
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/gud/gud_pipe.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 76d77a736d84..4b77be94348d 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -457,27 +457,20 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_crtc *crtc = new_plane_state->crtc;
-	struct drm_crtc_state *crtc_state;
+	struct drm_crtc_state *crtc_state = NULL;
 	const struct drm_display_mode *mode;
 	struct drm_framebuffer *old_fb = old_plane_state->fb;
 	struct drm_connector_state *connector_state = NULL;
 	struct drm_framebuffer *fb = new_plane_state->fb;
-	const struct drm_format_info *format = fb->format;
+	const struct drm_format_info *format;
 	struct drm_connector *connector;
 	unsigned int i, num_properties;
 	struct gud_state_req *req;
 	int idx, ret;
 	size_t len;
 
-	if (drm_WARN_ON_ONCE(plane->dev, !fb))
-		return -EINVAL;
-
-	if (drm_WARN_ON_ONCE(plane->dev, !crtc))
-		return -EINVAL;
-
-	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
-
-	mode = &crtc_state->mode;
+	if (crtc)
+		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 
 	ret = drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
 						  DRM_PLANE_NO_SCALING,
@@ -492,6 +485,9 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 	if (old_plane_state->rotation != new_plane_state->rotation)
 		crtc_state->mode_changed = true;
 
+	mode = &crtc_state->mode;
+	format = fb->format;
+
 	if (old_fb && old_fb->format != format)
 		crtc_state->mode_changed = true;
 
@@ -598,7 +594,7 @@ void gud_plane_atomic_update(struct drm_plane *plane,
 	struct drm_atomic_helper_damage_iter iter;
 	int ret, idx;
 
-	if (crtc->state->mode_changed || !crtc->state->enable) {
+	if (!crtc || crtc->state->mode_changed || !crtc->state->enable) {
 		cancel_work_sync(&gdrm->work);
 		mutex_lock(&gdrm->damage_lock);
 		if (gdrm->fb) {
-- 
2.52.0




