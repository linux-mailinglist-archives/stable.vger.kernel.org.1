Return-Path: <stable+bounces-272731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ve9eBU2yTmpMSgIAu9opvQ
	(envelope-from <stable+bounces-272731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 22:25:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B91D72A303
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 22:25:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fyErrHMx;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272731-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272731-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 242433030B13
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 20:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C2631CA4E;
	Wed,  8 Jul 2026 20:23:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB353822A5
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 20:23:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542196; cv=none; b=WRHoYTL8O8BSQfuAy1xeMpEl5UAF2APNMBhKU+2ST7InOwwfcXVgsZQfIuiv5GVpZtoTb4qO0jOh0LTR5/oD25OUVE6fbw8bm0YF7lvyoafFEFBk2/EG4hPdy9wO2G7KtsAFvvnV/TL2HzmxxkmjKKOa+r8fD8VYPD1do9YP+bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542196; c=relaxed/simple;
	bh=Dh7op/D6y72KqSKFeOFfXlBif3+8TipGaZ3CMsbhypI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8lKLsbF7u+lcvYT4qAI2Ot/CifOssQgAk6+IqqGuJZ0eVszRws9Usuye+0jy6vPeSb+8JVYL+exOphLRCX05IFjxBZPgVa+I+E3ZDoxZO0SbI4n46oQ/vjU+T+eKTNDBBIOBb3v9PZ2RR4Dk9KWOdPmI9a0jzP7UgMdOA0rH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyErrHMx; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so1707035e9.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 13:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783542193; x=1784146993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGPWKT+T/Sc4FxhkqkRyahjTyPdMRSTRlzX+JKb5mbQ=;
        b=fyErrHMxq4Nekka2qWxh4nwGe2eFKjiklHThFMSod0MFh/dUoyd6TV+87gR8ChvK2B
         jmjG+WxbKTWRwHFRVnwuKN6sSLjYmUKMaHwStEh8uK7s4Kzsa2ia9PsV4OGL1brRwIQB
         PN1MzLyUcUverVODQjrOQtAfRI58TwHG93YVPRNaKe3rbeUilRmiR6K5964p4Th/Fh9p
         Pphz+eTTWxTQQDs3sj99mkq234xxQGp4aLl70UnTUdMdJWc8MXQO2IYvVF7mg8rC5gJL
         4Zm84nP6hVPXjMbnx3HGzTH9VAROVSoIRzHNMJiIRaD4r46bgJ2lfh1kCTN26/CaAeJc
         Ekng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783542193; x=1784146993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xGPWKT+T/Sc4FxhkqkRyahjTyPdMRSTRlzX+JKb5mbQ=;
        b=qiIHhIPBV6QbBAnHWAUcjncxYR6qakE1akyeFXI54NRt+g3o3GVx0HE9U1w5xgEWyF
         wpyTnYbTREsyklu4qDdniHcvhri8pQQZUu5NskbZX6/WebNEsYqN2oX1h/8+E6YV0vzu
         10lIXvbePm6yV68n1f7fWTirchf+Zu4MRj0nez5uMLHRXX4x+gwjVbeE08m+ivcFhVyl
         XPpbZcyqm2tU6ZpiKxz8ykp6YIYppcB4f0TgOnUPoDOBvWtsK7hAcSlYUh2P3HXyaRrP
         +46/2WZrOlghHywxkTSlinPfSv+ejIQBnr5nBeED1yVIh0ySdALHf3HQZv2hUMmKlN0/
         vsYA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0OoWzoWh58FJwenJ+Vtn9xti1ro2G1FT7bT3TIcPGmyfjQ6ei7HxMNCFj43+RegvFCXNkJMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypgWB+F//w3dEvhC1BQHWtX2nVSjXlZ/S642toYTOmuhrPM6iP
	cr7sr8bENJn72S/xNMEsvfJXtOMpraJwQbsoEgHP3qhSiL8a6LIVy94q
X-Gm-Gg: AfdE7clO+ese0QUqtPR6W21pYBtBFxouu4RartaTCpciO8nUjmHddHVFGQ/OSWCqnCp
	8YX/bfq0JttbPlb8Tbsf5v2Mr6jBosacxHnQg8s6UshsWx5Qp5bhZIBYFCDjVzQrXqMJ3idsGkQ
	NGlMqbaE5v98TtOolOh3lEwyccNK/T7dp6WIVnW0JWPxgc8Nkder6I9n4a5gV0cf8xz0ZlTYazM
	0pIye3SRUbhp2m7V5+mdnZ2LCadDh/vk23DLHo2pLyyMDPqLC4IDY5C6nHBXIk920xIf6GxAht9
	FivudZrTXOytgr6Cje8Xxdq/8da+a/op9B9re0kYkr9nLiqpzqt5N8aO17ylOP91T0gWU8N/tET
	LvSroRCrKlgRmQhg7317gk+2nS6Zy2t/EV6P0iiz3XMbuRVOwIW9FmEGQif4/cYGEDLg7Z51af6
	J6dmFrWedkNkXkOw6r3j8ke3Y5YDE9E/CjtTTi7tKcOraVP6DVYQ==
X-Received: by 2002:a05:600c:528e:b0:492:4363:e7eb with SMTP id 5b1f17b1804b1-493e68f03damr41743525e9.32.1783542193163;
        Wed, 08 Jul 2026 13:23:13 -0700 (PDT)
Received: from osama.. ([2a02:908:1b8:2060:2b86:7192:b44e:9f03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a5d174sm101663785e9.2.2026.07.08.13.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 13:23:12 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/imx: check parallel-display drm_bridge_attach
Date: Wed,  8 Jul 2026 22:23:09 +0200
Message-ID: <20260708202310.12971-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706142732.49397-1-osama.abdelkader@gmail.com>
References: <20260706142732.49397-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-272731-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:p.zabel@pengutronix.de,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:lumag@kernel.org,m:dri-devel@lists.freedesktop.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:osama.abdelkader@gmail.com,m:stable@vger.kernel.org,m:osamaabdelkader@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,nxp.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B91D72A303

imx_pd_bind() ignored the return value of drm_bridge_attach(), so a
failed attach could still proceed to drm_bridge_connector_init().

Check the return value, as imx-ldb and dw_hdmi-imx already do.

Fixes: f94b9707a1c9 ("drm/imx: parallel-display: switch to imx_legacy_bridge / drm_bridge_connector")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
- add Fixes and Cc tags
---
 drivers/gpu/drm/imx/ipuv3/parallel-display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/parallel-display.c b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
index eb75827394f8..fd48845877cc 100644
--- a/drivers/gpu/drm/imx/ipuv3/parallel-display.c
+++ b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
@@ -210,7 +210,9 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
-	drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret)
+		return ret;
 
 	connector = drm_bridge_connector_init(drm, encoder);
 	if (IS_ERR(connector))
-- 
2.43.0


