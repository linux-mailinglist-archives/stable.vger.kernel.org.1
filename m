Return-Path: <stable+bounces-230220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB3MKq3nwmnnnAQAu9opvQ
	(envelope-from <stable+bounces-230220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:36:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3822431B996
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7109306B3B0
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 19:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571CC30649C;
	Tue, 24 Mar 2026 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON/ulE09"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBD8303A0A
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380626; cv=none; b=tN4lOfiwspUMseSwoJQisXKh5YYU/Jx0lpdpZNS/8KDAlIz1vZBANR8lpngrJPUM+vJ2+y/zKQNbqW/r1tVUXgEVLHg3q9jDEIQITSXp2NMmcz/0iButkfmktx4hTjrh9ClDLYfpBN6zcp8nzrTCzowOldI8I7Lw3GrJ2ROfag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380626; c=relaxed/simple;
	bh=tAIXeDCNByqCw5z/f5mAXfeb5SSuanCsZ35iifvnizg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k0YEK41eW/HV+/0ioju5hvudfg4rNr4y2bQNck0ziIcEf1F/WHPlWXS1zpUMy+IDdjiXhgSb6x0/+L7JXRxiv2cqX+OPV7wlPbbD5KM2tcfz1zvvGWQHFqXJ1Od0TsQ4pkLmIMihcVuKq5L5VLXxs9Z28KA9HeEYX5XoZizCgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON/ulE09; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483487335c2so46137495e9.2
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774380623; x=1774985423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4NWl+nIdcZDyj9SaWGNpDFXb3knx3+VKeGhhxFBSjxc=;
        b=ON/ulE09xZ7GTdjIXMwJQrMaEGG0CcFfZfJC4PR5Ihd7BRwQ1i9IV+7KS3YaYtHqJy
         47n3b44soqY/Nfo9VvKb4ZV9DKSRMWGrC2xU8lzrETH1EsPS0TXiwSwxbm5tEParofEL
         TwDuBXRXJlUjhz7VBgN7Ufd3/1YqbUb+JU0U0fmt1f3Sgut+sbqFrak1If/JV3uH1T0h
         ulPWCQenhrKn5yuDvc41UtkllBIzZxipCmhZT1V8MBFJgjNdQNncJYv0a1hiGzN/itHh
         4sogggrKqeoiY3iThsYaJCcoZFENHudK+niwZmx2eKim+ZBVV9r1C9/AybcRw2NkAAhH
         d5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774380623; x=1774985423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NWl+nIdcZDyj9SaWGNpDFXb3knx3+VKeGhhxFBSjxc=;
        b=m55kv2pVntoh4dRhOupUuIthlupshCr18pa136R3BxmwqhVSnhiVTI7s/7NizEQghs
         7gJfr+X99UuNMDecWriis8sbzzpaJkXJqnhaCG7qicKlTWh+sYKFRzNWcnhRXZV2m6PW
         BimuTuW45+/5/Fy3JL4Gy+MBgCCMizs3e/KiexFLHGo6mBZN7MwHMV5i5AJPYGdnfunS
         aDg3c79lwwsR3V+HToKkMJocj6f77Idq8q/H/bvX8m1BJajKV+F6rOkAOEjQBqoq1Hjz
         bTKE9Hov/O1ThcYXbHrOkfh9bTTMNB3VkAgsY3O3xPxsdWNihjfbxHJuqdhJKh2f9ppr
         sEzg==
X-Forwarded-Encrypted: i=1; AJvYcCUshm6MlgBGgN/In5+hVRzQ/VaXyshUuYQW1PQR6j/FlBwyYU4ENk7SQlYexRNTSqj3cUjxtDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvpG1yTEodOjaXY21o2BFWFIwAyOzPV9m2eyONhc8vLpch1Sj3
	FfFJPpPG5XcVSmBPgL9od7EITXhucSMPPX6d3sNrnV/FyPxxmXtODatC
X-Gm-Gg: ATEYQzzedIqYlcQ9f2+5VszJnO8+k0NQZpOXDCo60cjxUQiKU7LsBoQc3EFER+0HXes
	VdB4aYfAd0ZRCg1qklURI1Gdr51e0Xp21KZ+kcroG5S3duECkdPxz3CWXpNHBjUYmYyi8Hfc2hU
	sHDDSy/NU3k3VYVB6Vl5pW7UW9R6QB1lTGe90JGSRTSvG1JmD1aXYp3NHeTclgLLuQaZys40Fbl
	30GNMp1IFgZqQtPmitVPEcXFPId1AFdqq+qwYKlw4ZMzNdKtIEOs1nAcBhdKQ2OSL74LOW5uA0S
	9iJzKDJ9Kx9RKTFT/WarLA7DwAZwPJfIclCcGzKVaDvEJPZ/ZCFWTkBXitpep4K+NsMZH1+6LCC
	qJOYj5nG7TzV4cz+7a+e0qLm8GdmtG37P+bqWn5iKxafGP9eGqy/4GopGEk7JrgQ/YN9iQuR5pa
	I1RPntk63sRDicRIGTNTRNYbXCZ47I0Yv54/33OEXLDF40pee8S6a+h09Tp7lHDJjLykJjEWWX3
	Sl4QYKq7W3hzJNG+RtSaBjdxGUAig==
X-Received: by 2002:a05:600d:486:20b0:487:386:3714 with SMTP id 5b1f17b1804b1-48716043919mr10455905e9.17.1774380622686;
        Tue, 24 Mar 2026 12:30:22 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nan-1-1836-142.w90-104.abo.wanadoo.fr. [90.104.252.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48717373ef3sm737135e9.26.2026.03.24.12.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:30:22 -0700 (PDT)
From: Julien Chauveau <chauveau.julien@gmail.com>
To: Phong LE <ple@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Julien Chauveau <chauveau.julien@gmail.com>
Subject: [PATCH] drm/bridge: it66121: acquire reset GPIO in probe
Date: Tue, 24 Mar 2026 20:30:11 +0100
Message-ID: <20260324193011.16583-1-chauveau.julien@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230220-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chauveaujulien@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3822431B996
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The it66121_ctx structure has a gpio_reset field, and it66121_hw_reset()
calls gpiod_set_value() on it. However, the GPIO descriptor is never
acquired via devm_gpiod_get(), leaving gpio_reset as NULL throughout
the driver lifetime.

gpiod_set_value() silently returns when passed a NULL descriptor, so
the hardware reset sequence in it66121_hw_reset() is a no-op. This
leaves the chip in an undefined state at probe time, which can prevent
it from responding on the I2C bus.

The DT binding marks reset-gpios as a required property, so all
compliant device trees provide this GPIO. Add the missing
devm_gpiod_get() call after enabling power supplies and before the
hardware reset, so the chip is properly reset with power applied.

Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Julien Chauveau <chauveau.julien@gmail.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1559,6 +1559,11 @@ static int it66121_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	ctx->gpio_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->gpio_reset))
+		return dev_err_probe(dev, PTR_ERR(ctx->gpio_reset),
+				     "Failed to get reset GPIO\n");
+
 	it66121_hw_reset(ctx);

