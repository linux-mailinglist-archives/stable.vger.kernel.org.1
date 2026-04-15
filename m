Return-Path: <stable+bounces-238201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FfcI23k32n9ZwAAu9opvQ
	(envelope-from <stable+bounces-238201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:18:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF76407548
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67940304C7E9
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEC4351C39;
	Wed, 15 Apr 2026 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5aQWJzo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5475829ACC5
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280680; cv=none; b=lDl2pRpHvSJ5Ih1y0M5fQOOsAp112auuUNT9a3Etyk62ZPYyFD8wokOPzaV3d/MRmQwCW0wH0FAnLhOyIgiCr0SRQ4EvXLcYluJvnE3jpcxL2aLo5wLvV6OwoIlUMeijeSM85ujPG2ZygsklRpZMNuBLNNqvTM2AsuidB9tXVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280680; c=relaxed/simple;
	bh=tU1EdtcTkfiSn33FVUfgxFLQ6+RoNw+otoyWsdjSe/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruVQJWMeNEbOUMCzyKvw+ImO/ZUPaE/rh9/qfmhGZ2ZCO+dWfEQL1dcle3i/F4Gh6H2guEPdeN2lwz9wWk7mfVZIgrd3nrFXhiVwgfjT/9xueDOF6yliuPZw8GBIcF1UvXHrHw8EK44tsUJT6YH4eoUsT0o2dlxRO2ZWIo29eQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5aQWJzo; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c795f096fa5so331085a12.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776280679; x=1776885479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=db1viqbuVUDqwJpETiZkl//3ER+sg+ZcMt0690Q+Yiw=;
        b=M5aQWJzo63TTC0+jytJyBW/wM7qf1tQRh8wHeakV2i6liL9o9ThKNxPeoCzcdWJVgF
         Max5r7dpqtNBrM9ajScjBNiCuZu1B8dZ1dacS+HP2g/kL3sIVbZAyCvbjkX4T3nnX67B
         S+2T3tOUI918VkFRipzz9hJq1bGokozkS09PVATVQ/Ks/CBMY/T6WZn85Vl/6n5tVn78
         grwAN8qlAYffmI/Yv0RU4uxENUhZfs5Q/80ng99gVUnSO1CxO4Pgd/Kx6VkbquX4TbLe
         /nvpnToaUUQp7smPqBBVJEtWQTGHlL4Kd19ljc06iiGDjh8zSpXz7JUD878TkIpThJ6z
         b0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776280679; x=1776885479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=db1viqbuVUDqwJpETiZkl//3ER+sg+ZcMt0690Q+Yiw=;
        b=V9DOVLO1AATNqhx8RSpfaHPpJNr/GJX+BFNzlbjyBJbKBIx4OZzcdzu1RzKfuRUeh6
         dAZs9HKowiV0ZRDcJmdlEX5QrtKXu/HERJhnZd9MJI1aIOo+xv6KcHVDgxtgegjhIfRU
         xbK9XL4rvvx/Y6gs2/A6ABeZgGhySVIN7X6pTJLQeG9P33Z6HDWyLghVST6B5UxOYmi6
         Gi/Rf8ES0JfIrziR0pNrPP6UwC7VaxBExja3jriFnLE5CAag29c6MOe9CV2uwMgnJR0g
         90RVhG54ESAo+dP3C91egrkyRNY85osfObRkOgDNEcd0J/sFws9gMvghsnOb70Ucqo82
         1rQQ==
X-Gm-Message-State: AOJu0YxM3TJaiK8IIkqIW27PadPb/AdfDCQqQyOSuU4R90pUo1U31WE0
	f9QKkOCXhBdc9/aJ9XW6ZpCk1We9PhoYO0a7x3ulGAxLvNsoAK2lgfy6MfB3sF84gdnTLQ==
X-Gm-Gg: AeBDieuSsOWH361m9392K9bUmOEdK5AiSTQ61yhHzJVlfV9xOzF+QlXY9thdEwtaStf
	n7BDEHHjMqlEeDamYlyDM10khoei+JSMaQ/PfttxLAGh9Gj1R9cjsT2KcQU73iGrnHA/s80DUhe
	brXKD/+sj4FMZDAgFecSB3yRUCXSkQVsJxed+OXfbGxcjRTO6pvBd793C5GUEgsueDgdoSQsFYi
	Lj/tl491Sk9qw8IRFbErechtUeut4uaTAi26oUHPN9tI7T+QnekZCTL2qSkyVRnL+W5Jc1wlheD
	aRUwY4BtLsendQFf0zM8SuhilU579y949OiqHCgT1IJz0VCQTjx4V6apZiSxZ/ihsMsqJZfmde5
	fxotxBC/oceqhiBYM2aslVk9ODlG7+PMleS/GgaxqStEt4Kkx8vEE8P6dw/Qvpx7YcKxgBvIpjf
	tHMq0ri4POr9H1LLUYxK4ExXRZlSwl7+2L4zk=
X-Received: by 2002:a17:903:284:b0:2b2:5822:7a70 with SMTP id d9443c01a7336-2b2d5a63d4dmr227552715ad.38.1776280678725;
        Wed, 15 Apr 2026 12:17:58 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782acaf0sm32022445ad.67.2026.04.15.12.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:17:58 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Kees Cook <kees@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Tomi Valkeinen <tomi.valkeinen@nokia.com>,
	linux-fbdev@vger.kernel.org,
	linux-omap@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] fbdev: omapfb: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 03:17:47 +0800
Message-ID: <20260415191747.3845525-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-238201-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,suse.de,kernel.org,gmail.com,linaro.org,nokia.com,vger.kernel.org,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FF76407548
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in omapfb_probe(), the embedded
struct device in omapdss_device has already been initialized by
device_initialize(), but the failure path only reports the error and
returns without dropping the device reference for the current platform
device:

  omapfb_probe()
    -> platform_device_register(&omapdss_device)
       -> device_initialize(&omapdss_device.dev)
       -> setup_pdev_dma_masks(&omapdss_device)
       -> platform_device_add(&omapdss_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: f778a12dd3320 ("OMAP: OMAPFB: fix clk_get for RFBI")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index cafe859d6e5a..0d47a8aec5c5 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1768,6 +1768,7 @@ static int omapfb_probe(struct platform_device *pdev)
 	r = platform_device_register(&omapdss_device);
 	if (r) {
 		dev_err(&pdev->dev, "can't register omapdss device\n");
+		platform_device_put(&omapdss_device);
 		return r;
 	}
 
-- 
2.43.0


