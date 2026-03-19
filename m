Return-Path: <stable+bounces-227345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNTCHxAqvGn4twIAu9opvQ
	(envelope-from <stable+bounces-227345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:53:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC16B2CF2CD
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94DEA304877F
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87203EF0AA;
	Thu, 19 Mar 2026 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3mA3qet"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D33EDAD9
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938924; cv=none; b=raG0qDNIciiAAtgmo1bPNBNS/JCXTvJ1KrSPbIqyMI0O3CVGNxjlsLhWY37U39/RcDc8bw4TtO9z4/Q+CVz3RRcZRyLjvJ2FiRANplPMG1KGk5ecL+RMjtluejueUSy4J6dWCs+J487QH9mC2w7Q2E6hmp+nBLvNdYFHsHjw9FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938924; c=relaxed/simple;
	bh=wSrtoof78gY7cl0/kTqen6G7IMto9m9YkmvWmlpqlNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJsYgfSSXkVCH+1rJereiq008uvfkNvb3p/m5LrFlCFTuNBWbgZV1nxsR9qrrktn4P3VZmCpv6CIw1bRbHAubuHn1L1reNRV7VGAOxPQLfi+pJ/geTtuhNaTxzmKpQtlXCj1/S0xILow2RKY5GLSgQRwZnaIevfLg+cjOj+bGWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3mA3qet; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48538c5956bso10451255e9.0
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773938916; x=1774543716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIvSNKXz4qc5DB7Emu7Dw1mSZJPjUbF0QIFG+kNxKiA=;
        b=L3mA3qetVfn3JvgWmB2Cf1QnBoHJH46AeHIxw9WCw/VouIA6MAywnMjF95EjkMdEH9
         d3sx9mf9hKqE118PPJvZjzmupAMDiq7zxmFRJxqjKbCcJJBhEeQ/+3eLR7su+n6gTeS2
         qj7n71ibNBeETQAL+OpEaY8CGo7Ct22Rak0T1M/Zc6woYyroBIzaNoMzy4R1x9zdfVZc
         53C8qZSs91tT4RWXH2er5sK9lfxpjtpwTqXzGMcIt6mhhf+NOUHDdAeEJui9UXS+/cVH
         oeesdEuwv7xR9Fv2EY2f4tcBP42rrWu1Er4uGR748vH+/sYfYHmHTWzACpJMZeeuxioc
         2sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773938916; x=1774543716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aIvSNKXz4qc5DB7Emu7Dw1mSZJPjUbF0QIFG+kNxKiA=;
        b=f1RYG0x2SeMpLvW0rIdETncDhWEUXMHbeHinIpD+Nby0C/uon+mY5QoWYIpO8SZngi
         K8IKXS8qU2GoLwSXLF5admAXjo98uZgyZLwwAtH8d330obrQcqrIf7sJu5fpy72zZiOT
         y9fNs5yTFjDBstFPjRi9G3snCQiCbzCyuWmQl8tht4iQ8BBeI36oLXPMhTu9Qz7X17LX
         CJ/vjc7uAhJiRKPdPBONBuRS4Fgqvgyn6pUFSVFb40h/5HXg1HMEpHPEPn0Qqhjhtq8+
         javnbp2BPbO6M9Xu+DII0UiElRf8qYIHeJlZi7PE+DUl6G7EEJ+IUVCvY1d4lulEJ9x0
         MU7g==
X-Forwarded-Encrypted: i=1; AJvYcCUQQ0xivYZyrmdt/LH51QyHc30H3jQRYDCKrpFkQMrq1y5pzLKB5EPk2qfTMWhOBkGdBo7iAfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81LIUJAFhwTTLKFq7SdRjTBZu4eiPDYMe4w6L+haGLwnZTFz8
	e9SzfDfWxAllVpD+Ws/lg9KxrOHtUZHXWV1DLBx9Kx0mtHFs7Rcq2TPB
X-Gm-Gg: ATEYQzyXIcPP14bG27vlWpte3MyWfM8oYfL0uNuQY+N+GvdeTVLFI6eXpQn1gk8fdFX
	8N0+SZqvPf7cbx29hcjDljwkgBwRNA7tD816tMKEc3NzuT/9sQiiOIxKfyug5jS96cb6eORErkC
	d6Ic7z07wj4dpXARRDo7r5/HcNS4XRziaeN4dQPJXrs+4KkAqY/I2tN+MySRp716KOdp/B25Ocg
	mjuKbId8xEFEAzNAJdQvbax6P3luG6TW8ym4rvk4W3sIWEJo373kIK7ZZYdGwEIn69e9vrLuV9/
	oVqWq4n6qMQ7srwjwrNeC4PE/SVysaukyqhSnWOqjm16TCpkVi8sjP5+xE4VjsqvSSeXupWrnZx
	gQtsqQB2cRbuMjyG5/LuO2YNP2ALuvQDRokaQPqpz4bq/3/qqm/KCd5dphzOYCLdW9RwhjWzNaQ
	0t3Jyf1oquqRnFF4NrDybfLf+f6G8T6m3H0FGDs/IRDg==
X-Received: by 2002:a05:600c:3e10:b0:485:3428:774c with SMTP id 5b1f17b1804b1-486fe8b0073mr521675e9.4.1773938916334;
        Thu, 19 Mar 2026 09:48:36 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:8326:7b31:bf82:d2d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe68ec05sm5238505e9.0.2026.03.19.09.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:48:36 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Chris Brandt <chris.brandt@renesas.com>,
	Hugo Villeneuve <hugo@hugovil.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dri-devel@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] drm: renesas: rzg2l_mipi_dsi: Move rzg2l_mipi_dsi_set_display_timing()
Date: Thu, 19 Mar 2026 16:48:25 +0000
Message-ID: <20260319164833.409126-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319164833.409126-1-biju.das.jz@bp.renesas.com>
References: <20260319164833.409126-1-biju.das.jz@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227345-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bp.renesas.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[renesas.com,hugovil.com,ideasonboard.com,ravnborg.org,lists.freedesktop.org,vger.kernel.org,glider.be,bp.renesas.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	NEURAL_HAM(-0.00)[-0.850];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bp.renesas.com:mid]
X-Rspamd-Queue-Id: EC16B2CF2CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G2L hardware manual (Rev. 1.50, May 2025), Section 34.4.2.4
Video-Input Operation, requires display timings to be set after the
HS clock is started. Move rzg2l_mipi_dsi_set_display_timing() from
rzg2l_mipi_dsi_atomic_pre_enable() to rzg2l_mipi_dsi_atomic_enable(),
placing it after rzg2l_mipi_dsi_start_hs_clock(). Drop the unused ret
variable from rzg2l_mipi_dsi_atomic_pre_enable().

Fixes: 5ce16c169a4c ("drm: renesas: rz-du: Add atomic_pre_enable")
Fixes: 7a043f978ed1 ("drm: rcar-du: Add RZ/G2L DSI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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


