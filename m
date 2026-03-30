Return-Path: <stable+bounces-231156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A+BMsZVymn27gUAu9opvQ
	(envelope-from <stable+bounces-231156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:51:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B0E359B0A
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FB9A3033526
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A144E3BED0F;
	Mon, 30 Mar 2026 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aASh7vEN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7773BE167
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867496; cv=none; b=RS6U8HvrqEGJw/NMxTpSb+pmeGse1UIStEpD9t/EZ4cFvxprNoN0xDs2so2+dXvfRSXxM/I2/WjF3gO//FlvMhlV5uwrXNLaoLXr4s3VmmoAM4IQ1510Bj6/tsO3EeIyWr6tWd6bOMULhptzmuqqJWZNmJtUWgWJSXhfccs9Hpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867496; c=relaxed/simple;
	bh=f4rAtE8vL2LeqX7HrmP60xf02GC7I+FcyqdIHkqLAGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ip/7rdFnk0hGKtWXj7vhh6ZL8YfNzQA70tMjMoGCjrjcg6BLRjgVS6DhgkfrRvBUlMFjJZrAHZApha11/gNKUgOlH3NkZLcrv9beqXAsNI7TdDwAeftPyDXs0GLruf/1ipbIfzQZYcDTTy4zMVuFQxZq8CYDMS9jvZaXjCzSRB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aASh7vEN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so57570015e9.1
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 03:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774867493; x=1775472293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Cmbluhj5GyyYqaF3P2muL1bB8tOOS7mRoOIdtU1n1U=;
        b=aASh7vENOIrmOLYlx/DSOHnDM7s+y0dC0kfWazCSRI8Mjy+W6RqBQ14kSTFpx3XK9S
         vfTgz1v/4qYZjTCzJLG5/EwZLeQDpZHYljwO/Qsto8FUNTtqWiq0keg+J/LY90yN4xth
         05Tq8zjoLjQ0cryBrPhNjwL4KeO2npkqnbnDJ7Jzloy/3xSBq0wd1vPGxSHv64hIZjd+
         Ad5jKx+Y34IJWjyBBi3FYB8bu1HyaCNbL83gt5R9HEZV6YxM3AJNRiOa2dZsvCmjuA0r
         yBO69zAfZTbkYCctenlEuTIj8oVaifjvDXw9PecD0qbC+maiOqXMgoQgmqb4ZQIcGU+m
         stdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774867493; x=1775472293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Cmbluhj5GyyYqaF3P2muL1bB8tOOS7mRoOIdtU1n1U=;
        b=aZx7mUn83SolGV9BXL1SRfvWmc/EAm7R1tpr1H2pEeEgooQJCrtiP7nPYc4KdsnAC6
         SQobee5tVs7n1Xs7cdMH5qQOsjmvvVHVmD/U/56KCkKJlQuu14CpR142awJPnGJwgwq7
         qGP4m1Ot7AjLus9dDQ8Hou89+Aat6F+48oGLqRGdqoOY6u8gkSB+71TYYhN+fxBTEcDX
         ZLmEZQJux8m15Ubi7OFzNuhqst5kmNMoECuw42HZG3DUdyzzY9M5nCl/oVVlo9B0q2+N
         35rM1O9T/1cCjMOtC0QZY/DUTmqwkypUC8Zi576dtn4iou+HgFja5CtnqbZ7bPIGgjI5
         bpoA==
X-Forwarded-Encrypted: i=1; AJvYcCVpXHdoxhyJODuH4ZCZfaylymgDs+A+Kh+KYRixxJJKxrjQYOMG7DvI+xwX1rqP6xotSZu29tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwrvSjnj4bo+P4/4jBSj6SglUxuFLIq3gixd0c7CnKCYmaPQQE
	EMNd9+WPMKzY2MJTuuet6a4KnUPNgMRx/oQ3l12ROAwlgyeykIktczMA
X-Gm-Gg: ATEYQzxIc5IPHJOzgrllG5lvaThtgh8AYWRNkvXBNqWu6KjdFnKb+bab9fLtPEWZa2q
	1LUEzOnj2/1OkmPG6guOSTTYL6/Y+AzIXPI5vGt518mZ/pDLlCa00uGSUOFw7aOwDd1NsLMMORT
	tdkJTODH/GAoXTY3tUwHdx3F2iPgVP1IK55oOIMtcu6C8b90dVuTAEq8M5YqdZoWg7C8hihGqkJ
	cdekEfxZBHIPiZ8A50CM0ak5ElDTpyAQcZhWyil4fjTtKhqhKLZ/gS2OSuntgNW0wP+Pmvi6ACG
	uvmONYnbYB85RIovpaoJC198NVk2Gc1cvoSupJF+RVaRd4bse4nQc7ytc0d67T9LuFJw6qb9EQy
	9wnvs4PmpWo+W3ZhTTgtnUesoiV1+Zc5mXpXMiiRfH1oL159sR+mlXoQTjflhOiESUDsprNZJEi
	0Up/REpRpWSI9g0U1R2Fe1yYp90YMCiw==
X-Received: by 2002:a05:600c:c109:b0:486:f9d0:aac8 with SMTP id 5b1f17b1804b1-48727ec776bmr151656035e9.18.1774867493375;
        Mon, 30 Mar 2026 03:44:53 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:e60:2c8a:54bb:d692])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48727bfc5ecsm185842685e9.1.2026.03.30.03.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:44:53 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Chris Brandt <chris.brandt@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dri-devel@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] drm: renesas: rzg2l_mipi_dsi: Move rzg2l_mipi_dsi_set_display_timing()
Date: Mon, 30 Mar 2026 11:44:44 +0100
Message-ID: <20260330104450.128512-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330104450.128512-1-biju.das.jz@bp.renesas.com>
References: <20260330104450.128512-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231156-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bp.renesas.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[renesas.com,ideasonboard.com,ravnborg.org,lists.freedesktop.org,vger.kernel.org,glider.be,bp.renesas.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: 28B0E359B0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G2L hardware manual (Rev. 1.50, May 2025), Section 34.4.2.1,
requires display timings to be set after the HS clock is started. Move
rzg2l_mipi_dsi_set_display_timing() from
rzg2l_mipi_dsi_atomic_pre_enable() to rzg2l_mipi_dsi_atomic_enable(),
placing it after rzg2l_mipi_dsi_start_hs_clock(). Drop the unused ret
variable from rzg2l_mipi_dsi_atomic_pre_enable().

Fixes: 5ce16c169a4c ("drm: renesas: rz-du: Add atomic_pre_enable")
Fixes: 7a043f978ed1 ("drm: rcar-du: Add RZ/G2L DSI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v2:
 * New patch
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index a87a301326c7..ff95cb9a7de5 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -1025,29 +1025,33 @@ static void rzg2l_mipi_dsi_atomic_pre_enable(struct drm_bridge *bridge,
 	const struct drm_display_mode *mode;
 	struct drm_connector *connector;
 	struct drm_crtc *crtc;
-	int ret;
 
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
 	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
 
-	ret = rzg2l_mipi_dsi_startup(dsi, mode);
-	if (ret < 0)
-		return;
-
-	rzg2l_mipi_dsi_set_display_timing(dsi, mode);
+	rzg2l_mipi_dsi_startup(dsi, mode);
 }
 
 static void rzg2l_mipi_dsi_atomic_enable(struct drm_bridge *bridge,
 					 struct drm_atomic_state *state)
 {
 	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
+	const struct drm_display_mode *mode;
+	struct drm_connector *connector;
+	struct drm_crtc *crtc;
 	int ret;
 
 	ret = rzg2l_mipi_dsi_start_hs_clock(dsi);
 	if (ret < 0)
 		goto err_stop;
 
+	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
+	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
+
+	rzg2l_mipi_dsi_set_display_timing(dsi, mode);
+
 	ret = rzg2l_mipi_dsi_start_video(dsi);
 	if (ret < 0)
 		goto err_stop_clock;
-- 
2.43.0


