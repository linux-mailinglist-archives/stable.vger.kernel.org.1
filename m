Return-Path: <stable+bounces-215544-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEbzH4Iqimm6HwAAu9opvQ
	(envelope-from <stable+bounces-215544-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 19:42:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F78113B2F
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 19:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 416CE301DEC6
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 18:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E323A0E84;
	Mon,  9 Feb 2026 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6kb6tbk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812DC387375
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662499; cv=none; b=Sl+zbtMV2heZqrxuBK4hPS8ukBZ0HeWnvXt5ko75nFN6emxVumPEDjIacnXjveMtzcw9iZxzhpfBdOKS/Xl61Y3fsNnoeu1Bvn1a5jKDmtYM8P0iqwOsjnKOjPf87/g/SHOJDZAT+rpmBkwjRkuRIs/RbswGAx3BoaGPb3vFAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662499; c=relaxed/simple;
	bh=3GP9kGliJ2oojzVQ9MFLDO3yhh3m+PSMwjdrVQvrrxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S0Xr0RBt/mzlIYpy51RG9LugwAYmwjh06KVaGbxX6YsQQBnLRWimX4Q0VcH8lAZRtagf2kqYe2lIkE/er/fOXKRgt7QHAmOee6cd1GWdaEUMtnM9jBH2R0p2x7KKN1Bjf89JO1x1stTKDLVQrxmRlIIUrnPVvSNnvsdircEvl3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6kb6tbk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so69416655e9.1
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 10:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770662498; x=1771267298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oMtozXDIGyj09zGXANkEQgHzJkoyCjXc2a15Zop0B9Q=;
        b=F6kb6tbkO2dZNUWuNJmPwmAfY+IQ6ykoCbLCOuv7KwhdiXh1omhzCKshdmqCRd9ga3
         Fq55AVNzHjXCqgHSEV99BV3sSS/pbQuCXvIMpTzNtCzAViXXLG7r6adCWRpOGwml91wz
         TqLSnCPSMJs3JEemlNqWV9RitXRyVh3stYh7F4ub4G+eB9Fp17/RTyYUl7baEo/Y+Z2k
         3QJ6Zbj1fYksz8TJD4aPKOHIwIu2O7mQ8DScAFPteBo786Xe3ve1au0FxYb1c9cehNkr
         sHR6SQnSORuHXEB0rkvkbgoj46q552vkFaEavRFRcQ3JKY1pvxEF2IAsa8cIi62lrz5J
         +ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770662498; x=1771267298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMtozXDIGyj09zGXANkEQgHzJkoyCjXc2a15Zop0B9Q=;
        b=nrHeuZAXMFnsHw76lRvSddSCOWi9+d3qPzYF7FzTW4UAq3EYH1m3nxyNRWbSFKU7Fr
         tvdBcRoRz0c7kssmvff306XcJOIPBLsf0KrBXU40UQ0qqzBFY4fveJlZDZu7MpM2Co6/
         Sz4c+3HKOqlciW54vCevb4i2DxbdC2l1fySiMqdTEgSO8CAudoAAi54MY6JT1kSS0wjO
         q+Tx93GGvgGyDYblgby1DyPy1BMr6SIOk8xXsh61sw1kC1kBO30B+lCi2rmGzIzlwBZ1
         FP3tYTqmNn8LOSHwLp9YLro+1lELxDFqIWZMdai+u8eG73URR9JlxfSno15l9ZTq3pnv
         kHAg==
X-Forwarded-Encrypted: i=1; AJvYcCW6/6DwUCR7dcJ+7KZnX7Cnc50AghpPxTgOcRbWyZsg1mUwTN1OLEFe6Kd6kJtp6xcJcpkFplw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcUDAsEtlQyaAdAq79F/ioAzh6HcHPB7OP7+0ebrp3qbejlAmx
	RQtYSkzRizJBJXIguDM2gOpwkdkTpM2ud7/To+w5ar/40FoAYKbirOUi
X-Gm-Gg: AZuq6aLePvN/f3iFTmIDhjCPwbFma/kRLS/DUCsLCNYu/a4gARE64gELmDcnzB4X6en
	qrh8AColYGcMSdJ/5SqoCkAzecnnDxXyGJ7wMsyfkLJY9Dh/2EC2eCxk/HPM30RE3fFrVnfOUPG
	i5VD27/G7kYrTF6e/gqoJRBk3dKx27WYC+GpIWBYnBEQA/wMtDEkITP5JsJxB3cNqDKnNJXoH9C
	ImzJhcwxzE91JnA8UT5Eo3ffm06OxaHPGyMh1e3vLmIHxUPU9agiZWHTuXc8Si0ldWAqbpsrZFV
	72RX7u/HllBFAqeK77t+Vu/UEMKJ+nXm3eJHSOWg9YQr151Erh91HChP5WcIuwvWZDWbuf0SIp9
	225P9cUZopP8un3YTmvM+xwDilNwRVFp2x8AhC4fZ7ywedBgleqri9/baRBv5gub1AzmZh5NrcW
	wUO59eoi5uMhCbGh19qdT7uRyzHePYMyq2gSNWm5qFPgQ=
X-Received: by 2002:a05:600c:4fc8:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-483201dc396mr187849515e9.4.1770662497594;
        Mon, 09 Feb 2026 10:41:37 -0800 (PST)
Received: from osama.. ([102.47.82.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436297455eesm28931232f8f.29.2026.02.09.10.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 10:41:37 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com,
	Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Marek Vasut <marex@denx.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: samsung-dsim: Fix memory leak in error path
Date: Mon,  9 Feb 2026 19:41:14 +0100
Message-ID: <20260209184115.10937-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215544-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[bootlin.com,samsung.com,amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,denx.de,lists.freedesktop.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14F78113B2F
X-Rspamd-Action: no action

In samsung_dsim_host_attach(), drm_bridge_add() is called to add the
bridge. However, if samsung_dsim_register_te_irq() or
pdata->host_ops->attach() fails afterwards, the function returns
without removing the bridge, causing a memory leak.

Fix this by adding proper error handling with goto labels to ensure
drm_bridge_remove() is called in all error paths. Also ensure that
samsung_dsim_unregister_te_irq() is called if the attach operation
fails after the TE IRQ has been registered.

samsung_dsim_unregister_te_irq() function is moved without changes
to be before samsung_dsim_host_attach() to avoid forward declaration.

Fixes: e7447128ca4a ("drm: bridge: Generalize Exynos-DSI driver into a Samsung DSIM bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2: 
- Move samsung_dsim_unregister_te_irq() function
- Add Fixes tag
- Add Cc tag
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index eabc4c32f6ab..ad8c6aa49d48 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1881,6 +1881,14 @@ static int samsung_dsim_register_te_irq(struct samsung_dsim *dsi, struct device
 	return 0;
 }
 
+static void samsung_dsim_unregister_te_irq(struct samsung_dsim *dsi)
+{
+	if (dsi->te_gpio) {
+		free_irq(gpiod_to_irq(dsi->te_gpio), dsi);
+		gpiod_put(dsi->te_gpio);
+	}
+}
+
 static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
 				    struct mipi_dsi_device *device)
 {
@@ -1955,13 +1963,13 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
 	if (!(device->mode_flags & MIPI_DSI_MODE_VIDEO)) {
 		ret = samsung_dsim_register_te_irq(dsi, &device->dev);
 		if (ret)
-			return ret;
+			goto err_remove_bridge;
 	}
 
 	if (pdata->host_ops && pdata->host_ops->attach) {
 		ret = pdata->host_ops->attach(dsi, device);
 		if (ret)
-			return ret;
+			goto err_unregister_te_irq;
 	}
 
 	dsi->lanes = device->lanes;
@@ -1969,14 +1977,13 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
 	dsi->mode_flags = device->mode_flags;
 
 	return 0;
-}
 
-static void samsung_dsim_unregister_te_irq(struct samsung_dsim *dsi)
-{
-	if (dsi->te_gpio) {
-		free_irq(gpiod_to_irq(dsi->te_gpio), dsi);
-		gpiod_put(dsi->te_gpio);
-	}
+err_unregister_te_irq:
+	if (!(device->mode_flags & MIPI_DSI_MODE_VIDEO))
+		samsung_dsim_unregister_te_irq(dsi);
+err_remove_bridge:
+	drm_bridge_remove(&dsi->bridge);
+	return ret;
 }
 
 static int samsung_dsim_host_detach(struct mipi_dsi_host *host,
-- 
2.43.0


