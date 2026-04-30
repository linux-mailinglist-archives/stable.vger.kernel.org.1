Return-Path: <stable+bounces-242199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDedGoay82nn6AEAu9opvQ
	(envelope-from <stable+bounces-242199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 21:50:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E054A778A
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 21:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 840223022A83
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C471F350A05;
	Thu, 30 Apr 2026 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5FavkWM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D633F37F
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777578626; cv=none; b=K73waou1SDaemgup7GGERN6GtgGhQOeNjjAcB4QyfWQiLpBRv9f1awf2MicW5KjCV1q+ia5sT5jQOZiy3TeBN+D6d7s1XxPAee25sXB7fsddMPkgiUnf7SpqxOrEPCyWyWUX5IPJcBvBCqLIjBiOEaxikwxyzIB9JOwsvgp7L0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777578626; c=relaxed/simple;
	bh=lVj9l+0N1jtYsqvEBiLnFZ2/3v1EchPWkJh38hXrag4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDpbr1HPdDdZ/VpEtWOkdUc9oXyEudN6BlRxW7HdjkMSJfDCwPE51SDZkI0e7LLDwEHjfotX+J8jnCX1y4tqPNC5ClBK/B72bNBS5DIqaOEaQwTFLiHT6kbE3HB0XQGqSpih9JnOK4JGxrXQuXb31YUZPXVt5yse7EaUzLJbtNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5FavkWM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so12670965e9.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 12:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777578624; x=1778183424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xV2RUgdcgAI6HubmbhhtbLRAwJ2b8LARLx9dBYFOMRs=;
        b=C5FavkWMYAKh0TWNMMWZDqV8Erp3ztkDV+Fb7wWNdiG52UXVulTg5d/qfCNRXYmP+z
         ihDj32IX37nWolccCfKK77FFjHtpkVMPo5ZmGubg3j6HqflIwnpEV9ZNYcHvxeZAc5+S
         L35o2dfB6urA2o/R3yaQT8hGfXlTMLbBYhNA3nlMG7CB/nKQ4KX5iD56mdYlioRDibpC
         5rPozV+orgp6tU9DiwNc7DwRWoTA6z4QZA/lDH9CnjKtxN16hwaEf2w+CmZTdYvWTjGs
         mjCzSXEGCcioVT+jo/Fc9xuVd42FwwO9D+js9lMoqDsKd693l3OOeZwdUDK8NQvaJlnh
         tPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777578624; x=1778183424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV2RUgdcgAI6HubmbhhtbLRAwJ2b8LARLx9dBYFOMRs=;
        b=p50wkZ2BW2EHO4j463VmBpaNxLmT/l3BTJO3Ch/NAEInSOPq3heZs1RXF3lkpQhhht
         UWn9Rl1BvHFafvrgEzjZdytl6qMLFGnkObh2DlG7+xug3JujiymjvO7ZIePz4IIBUIRV
         cLzYTwhoOwiAbRJEJBpgyEXx/HZg0aboNbgcpCJnMP12BahLPpclY8asS7wMSwaLX2xz
         uWhMJ9WYz8hZo7OvfIWzM15uvWDdfmV8FAi127BME95ISSn5UkS5tDIuBLTuQeCrddMS
         Aoci2Uwx6gnJbYRJHbUe3ve7Ds1TgjpcW6MTwQWgmjSE53ZdIG75v0iszOZJOiHTD7/o
         xCLg==
X-Forwarded-Encrypted: i=1; AFNElJ9XQtXZB/q+XOZ16dhEu3KaiOjjvLdL4xod+/Qliidwy9wjF7oRcK7D2UlWySsbTLM/kEwwsWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/kvd2ZEE+Xh7VIrTskOfUcNpX7RUPmw9w4hxznLp9wR/+Ym8d
	0X4KxZHYuhwSDiaKryGOmm2ehPXsMZRRYRPWNkaYCh/1h+17LPJbPWpJ
X-Gm-Gg: AeBDieulEfls/COu0/xKG8dk5PdWu7FVGfzCDASmzzxo0AUcwVNW5ow5fqfaR+UBpqo
	p2zlWNDqefB2VomJRWqgSbR9F3PKhZ4vKkO6vFKvSmiZxbsXJMmY7Pr605/773iphoSaEuW5HiB
	0aPTJM1CVRZrIFqzqYuwCOjGuWZHKH67Nv+tYX/QLQXJ+fqdJNZTL4cBXiD3KobwHFWvN1fDoZv
	Ol1WHtEos5X7ZmBZXW8ErZjIInzh7ey62o/9J0dIfAQdc29/OyakRGF255Nc711T4QZ8kgLqM3o
	dyIEbIAjW1QEJgVOlxYV9IdiokpcZ+aQh94yPP82YVg/yqO862PeChTqVMCKUnqPKc861Asosid
	ay/l8cagySnubDav/ppOiFvF1fr4Ek75WBCpsU0vknv9fAsW5Ph/5BxWQhReQYAIrijYgwKmp88
	mIfpIKHH6Bwlw7Azd/2yv+7vmmfWExPrZ1hOJm0H/bwrgtk4p3JQb7kw32qxibVwBEkElzt/U=
X-Received: by 2002:a05:600c:a14:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-48a844525c5mr68630135e9.17.1777578623521;
        Thu, 30 Apr 2026 12:50:23 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:55a4:d495:8d6f:1416])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm3109615e9.7.2026.04.30.12.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:50:22 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com,
	Jagan Teki <jagan@amarulasolutions.com>,
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
Subject: [PATCH v4 1/2] drm/bridge: chipone-icn6211: use devm_drm_bridge_add in i2c probe
Date: Thu, 30 Apr 2026 21:49:42 +0200
Message-ID: <20260430194944.78119-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C9E054A778A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-242199-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[bootlin.com,amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,denx.de,lists.freedesktop.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Use devm_drm_bridge_add() so the bridge is released if probe
fails after registration, and drop drm_bridge_remove() in chipone_i2c_probe.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Fixes: 8dde6f7452a1 ("drm: bridge: icn6211: Add I2C configuration support")
Cc: stable@vger.kernel.org
---
v4: refresh the patch
v3: split the patch into two, one for i2c probe (bugfix) and one for dsi probe,
    and add Fixes and Cc tags
v2: devm_drm_bridge_add instead of drm_bridge_add
---

 drivers/gpu/drm/bridge/chipone-icn6211.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index 814713c5bea9..553a1df4688d 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -758,7 +758,9 @@ static int chipone_i2c_probe(struct i2c_client *client)
 	dev_set_drvdata(dev, icn);
 	i2c_set_clientdata(client, icn);
 
-	drm_bridge_add(&icn->bridge);
+	ret = devm_drm_bridge_add(dev, &icn->bridge);
+	if (ret)
+		return ret;
 
 	return chipone_dsi_host_attach(icn);
 }
-- 
2.43.0


