Return-Path: <stable+bounces-211466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEjVDwMCdWmi/wAAu9opvQ
	(envelope-from <stable+bounces-211466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 18:31:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDB77E4EE
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 18:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 881D53008D24
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039A6220F29;
	Sat, 24 Jan 2026 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Xrg4c5Wb"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F3E18FDBD;
	Sat, 24 Jan 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769275897; cv=none; b=Z9GbMIfgXZWwIC6JpmVS0z+nn2o6HaO0r+uiaTbqU+Foj1alQBxRE1XH0+r6AB5ZYeTyVzjG0i+ByAlu5PCSpV3RxwgkGtPPk+Wbwb5LxA2PyZtILk3Gh+/xu7WuDsPaq1gyGMQCJgS1KtMk8LvDlVWEyy+rDW82vceUbynlxRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769275897; c=relaxed/simple;
	bh=VyJNORh+kqAENWPGajL+8qZsG7n89eFpUynRgv2k1MA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G9E2+XUdiTz+4EF/X1WGOgCKHGMJJFmLlHuwlD+eRt9uezvih8VdhMJEtLOEcZHNYJuSTuqQF3kaGFbuf2rwc3vjwgQcB/RXzgUOhvmY27XioxzwO0Vd1586Wp9rNkIR9CR4E2H8KCvGONAorXHgJFCODsyIg/BTLOtUE2/YsQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Xrg4c5Wb; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 407F527DC1;
	Sat, 24 Jan 2026 18:21:30 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vTPiSNRYof_E; Sat, 24 Jan 2026 18:21:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769275289; bh=VyJNORh+kqAENWPGajL+8qZsG7n89eFpUynRgv2k1MA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Xrg4c5WbW83SYcMqZhK/qfDm/MAy8Ba0qAIvijWc0K1XeKunNtV7vcdS1Tl3xnGQp
	 oRhq89ao5I0w2Z5t+0nlFVbTJHo4WfbELsbI89VFyVaO4g8WBLfgk2960506dCnYu8
	 mhWbNQO3mbIcrAXrmbNwf4IbPA5GlY+nh7jyVAFEZvjRjWBM+5HZBAkdCPzzEG6l0J
	 VLnbyfhumw8bS1I7GLSlkzT6Q3YvaJc1jOVQ8SyANp0AOmSDg2voA1RbFRBexjPqJ1
	 TTKmgTLWVduEzQaGgEoVR/pygle86jll+dSZisUG1TLYjKxlVngu7+hzOp0pazosV+
	 99EYdAKSoD05g==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sat, 24 Jan 2026 22:50:46 +0530
Subject: [PATCH 1/3] drm/bridge: samsung-dsim: move bridge init sequence to
 atomic_enable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260124-exynos-dsim-fixes-v1-1-122d047a23d1@disroot.org>
References: <20260124-exynos-dsim-fixes-v1-0-122d047a23d1@disroot.org>
In-Reply-To: <20260124-exynos-dsim-fixes-v1-0-122d047a23d1@disroot.org>
To: Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211466-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[samsung.com,amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[disroot.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:email,disroot.org:dkim,disroot.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACDB77E4EE
X-Rspamd-Action: no action

Since commit c9b1150a68d9 ("drm/atomic-helper: Re-order bridge chain
pre-enable and post-disable"), pre-enable sequence is called before the
CRTC is enabled.

This causes unintended side-effects (abberation among potentially other
things) in the display when samsung_dsim_init() is called in the
pre-enable part of the sequence. Call it in samsung_dsim_atomic_enable()
instead.

Cc: stable@vger.kernel.org # v6.17 and later
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 1d85e706c74b9..975f8b50ae660 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1655,6 +1655,13 @@ static void samsung_dsim_atomic_pre_enable(struct drm_bridge *bridge,
 	}
 
 	dsi->state |= DSIM_STATE_ENABLED;
+}
+
+static void samsung_dsim_atomic_enable(struct drm_bridge *bridge,
+				       struct drm_atomic_state *state)
+{
+	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
+	int ret;
 
 	/*
 	 * For Exynos-DSIM the downstream bridge, or panel are expecting
@@ -1665,12 +1672,6 @@ static void samsung_dsim_atomic_pre_enable(struct drm_bridge *bridge,
 		if (ret)
 			return;
 	}
-}
-
-static void samsung_dsim_atomic_enable(struct drm_bridge *bridge,
-				       struct drm_atomic_state *state)
-{
-	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
 
 	samsung_dsim_set_display_mode(dsi);
 	samsung_dsim_set_display_enable(dsi, true);

-- 
2.52.0


