Return-Path: <stable+bounces-254045-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGtOLYkpE2pE8gYAu9opvQ
	(envelope-from <stable+bounces-254045-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 18:38:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBB35C32AD
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 18:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3188F300B9FB
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087CD395AFA;
	Sun, 24 May 2026 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwZu3f+L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E12390989
	for <stable@vger.kernel.org>; Sun, 24 May 2026 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779640650; cv=none; b=mgQ/NC9m7RFIMisO2v9ROkBw6dGDdO7Y6BV7GLUGNhEWFPtKxDhyJqegf0EMcLqFUTKEFJhUZikLgqtnHTfGZg++Dnj7NQy0Se9WmWAEG2PMNuGKF8E1fxDyakTzHjH+IOqRyt/5Bni+CQ6qA0x/f9ogzBzeX/cvnhAHRyEEUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779640650; c=relaxed/simple;
	bh=179DNAqWwqA+ngm396BWCNZCs34hNz1yV8fwEPHqlUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTbYjjaro0fUHfA59ypclD6+pStRPrjjyci5a6iF6wO22Tnfy2mDcinL55rbZhcjAkqXjHBRlq509jPLM59ZSRPvDg9cDTWrmEiUVQjmiKv3PwOtuaFR6jaJDfAV4/myUVw5r+LxC6n6OyjPUc3qYZdaxnyW/DhP+YMpNB/dWqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwZu3f+L; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bc763e2ba8so44436745ad.3
        for <stable@vger.kernel.org>; Sun, 24 May 2026 09:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779640649; x=1780245449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0HUvMlBgBGQWslCXm5T/VCz5F81Ghf/XcT+I734BSU=;
        b=YwZu3f+LOXDYsXl8wSRe4Rbd+aVPd1nBUCxXuFWAgHnGU5dAhF6WYJNmLjPGd3CVT8
         C9wrML4zg90uHbQzqrhmoqWH/XhmYfObt34g6F1btfbdOUuwqTykWXsY/NsMmwQoZVVo
         dzw+O1/iIkVk6k6MUC5zSmyK2qCoSddcYpCFAstnFcHB8QkX5Qe5F7XcndenGRMA7Syp
         qF3GvIeIo019Nh9yVPE22Cwd5UQ9i4S6Y1ksWMkS7TIxmKyon0+6Rd8qOnDLeQVN0rwk
         k+BnusMHg/QZQwjcZ76VxujkgB2JFEN2IUF6Zp2ZK2Ix9MI3tUnLkalp37Y+3eyNoMkn
         LSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779640649; x=1780245449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G0HUvMlBgBGQWslCXm5T/VCz5F81Ghf/XcT+I734BSU=;
        b=CZJPz0oDxax6h7BC2G8O+GZuTnV+/JibWuNYu6WZ5MNPw8x24jEQlMpsJcKvRzWZVb
         fhrqS/GXxFcMKT9PicEzKEiZVX9tG6z3DveUXgQ9qDeQSxb6wJ3I3iq2rZ+Bfjhx6t5R
         BO6lIXQc+xU+9U3sw7dxe2ygDMYH26o7JB2t5fMhNI8umvKzU94O9jnq9lBaUFAqnB6B
         pDNTLdmj1lnepgNJiEPFe1aPe6qAb2ALSgbZTvslwY3BS7kBDX2IKs7V1TYYTDxLlwCj
         O08i34k6jHtv8cpdlH0Kl5eIR/v+20aJJm1CttKVE99qyZ+ZlTQvaLvX6d7A0iqUFw6I
         qy0w==
X-Forwarded-Encrypted: i=1; AFNElJ/3xB/DY+gkgCUdeGjBnV3cvsapjohPd1x4m6NpvZ8eJirmipUtw6iOO9651zPSWsqpnfVzABI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZ1NOrdIHxRN8p1GTGWArbAQr78Q0cAvkUoGev9xecUcUD8yS
	7lZmR4v2wDLsBLYuO83bG4i9r5J4beoFplOpMRa4JKDQ1TVAH8Bw2s8=
X-Gm-Gg: Acq92OFUXwjrePoUyEbg+/1UNknt2LM27N0usdi/y0wWmY8zr5U2zpZICdX0Rqf5r/y
	UU/PUKE7cMltDSbeWB2NJYYP15BQg/zfu7HVkSMHTsIMwy7tIHBtSkqHed6o0gtPBRDCEMYPCWc
	VpAOQvnhCeQHsIx3ICjEOaGZ5P0rgrzscLNOfziEMMEWSC6Tm0+Fb8jF367lyItCZx2qhN9+ewB
	o9Fg2EMAt2SOc9MlOkUcwontnemOdWucAAQ0EI0WLzFj679SJUBYXbvZ/zGIsOX9dNUdobfBUu5
	21JWTjZ5chQyFN+dBmuMwgm8BABooIGdRMghKA20/4F7bT4O9EXZx8v4wWuyUlY6HcjZfXPaAQo
	ZYey6d4/z/zXgnRtVXGGtf49gt625t1wAlwHTkpd4Q8P6VLYDJ7RzOldmd5VqY9o2i+X8SusYVt
	FqMLwtOz9UvCpSCMTQrPZAq+eGjM2qMQsus18fXUjZZtXPM1TtXu8ohv+XbTMCvF7tLUepK7B12
	QA6SCdVtg==
X-Received: by 2002:a17:902:d4c4:b0:2b2:4d78:eec2 with SMTP id d9443c01a7336-2beb0711965mr114609995ad.18.1779640649048;
        Sun, 24 May 2026 09:37:29 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b309bsm73017325ad.51.2026.05.24.09.37.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 May 2026 09:37:28 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jianhua Lu <lujianhua000@gmail.com>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH 2/2] drm/panel: novatek-nt36523: use devm_drm_panel_add()
Date: Mon, 25 May 2026 01:36:33 +0900
Message-ID: <c6fe4a162692b4df5525353dbdac5b88eda91a79.1779640137.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1779640137.git.mhun512@gmail.com>
References: <cover.1779640137.git.mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254045-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1BBB35C32AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nt36523_probe() adds the DRM panel before attaching the DSI devices. If
one of the devm_mipi_dsi_attach() calls fails, probe returns with the
panel still registered.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 0993234a0045 ("drm/panel: Add driver for Novatek NT36523")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt36523.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
index 226d91daf8..f6592b01df 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
@@ -1047,13 +1047,6 @@ static int nt36523_unprepare(struct drm_panel *panel)
 	return 0;
 }
 
-static void nt36523_remove(struct mipi_dsi_device *dsi)
-{
-	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_remove(&pinfo->panel);
-}
-
 static int nt36523_get_modes(struct drm_panel *panel,
 			       struct drm_connector *connector)
 {
@@ -1225,7 +1218,9 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
 			return dev_err_probe(dev, ret, "Failed to get backlight\n");
 	}
 
-	drm_panel_add(&pinfo->panel);
+	ret = devm_drm_panel_add(dev, &pinfo->panel);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < DSI_NUM_MIN + pinfo->desc->is_dual_dsi; i++) {
 		pinfo->dsi[i]->lanes = pinfo->desc->lanes;
@@ -1259,7 +1254,6 @@ MODULE_DEVICE_TABLE(of, nt36523_of_match);
 
 static struct mipi_dsi_driver nt36523_driver = {
 	.probe = nt36523_probe,
-	.remove = nt36523_remove,
 	.driver = {
 		.name = "panel-novatek-nt36523",
 		.of_match_table = nt36523_of_match,
-- 
2.47.1


