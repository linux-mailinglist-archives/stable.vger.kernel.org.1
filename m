Return-Path: <stable+bounces-241008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGI0M7qj62lpPgAAu9opvQ
	(envelope-from <stable+bounces-241008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 19:09:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70034461A38
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 19:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3B64302F6BA
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0D433C198;
	Fri, 24 Apr 2026 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/nnZDXa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5ED33BBCD
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049937; cv=none; b=oOMcczTyhmieSk+syTl2ep8Et/KOVasbfyI1bG2I8bbmURfIw/XTKP7A0ux9h2l6ycvwErSC3G5FdQGhyzKeiSZO1svLwztFUVqkA+VGYcrnamZAW+jepeBmnLr7u+wD/dIjCh/oOfm9We0bNqN2cpzSVhCDz2ExcuOnzYlEiJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049937; c=relaxed/simple;
	bh=AzOjxNZrv+J9Fly0aItH1+BiGcAPcSLRn572rDJv24g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aDsXrLQH2etCALVKEQSrDIexD6gz8euOzFf01mG7XXvlRgVor+5XXI5E3JD70u+vwDVW/Kiz24KzS4ydRlPw/XLSmHs5YFmxrVbD/RO1W8CucYKVKe4Ga8U2Z1WFzcDI+CPmsr8hS6vOwv1zJWaVbED8jrCqzKCuL4oFqeMgdNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/nnZDXa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-824c9da9928so4111940b3a.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777049935; x=1777654735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2RXCXJGDvOh2rTTR70eKdmZmyxI9wZ3/3Yn4C43EO+c=;
        b=J/nnZDXafChGaX9sdDegZJufznr5oB934qAOeMq6p6GOYfc3W2I/nVk60kBL+DM+6X
         mIesI5psoxFv1DPECRDcFbxN6dTSyTIB4RU8OxGlST2Nwqno3Lkgc8dYb+Gncp9qOEFF
         BiUHraC7kk6UgKiiliUh3VWnDOiLUTbZyC/yTIAbcBwMPoEUEXn/QPenIa0fm2uaGPZI
         69VyphUJXCXUfR5k5bsoYkaEuEP01qPfY8lpY6uCsHFz2T5qlG2woA0x2SJiyGdpd9Dn
         AmsiSdCvxRGy2r7sTBpoKX6egmN/udaQlXTX8ga3GyYmikRBONV3xeOmVPlNgrElAkB/
         P+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049935; x=1777654735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RXCXJGDvOh2rTTR70eKdmZmyxI9wZ3/3Yn4C43EO+c=;
        b=ExYhNwOR+cBGPg2RmjwLkTwAyOUUald5nFjnMNq26TSvDWyrBUXlHGPWrko4qmFvNe
         A+grAc2J+7wnyRZyvkTOF5FuwA/BaesMP4dP9nkHGJ0poXx6xsLyjCg3A30LKSqNWu69
         +bUCzcqr0oGZ/jUZHOrzLx9Pkkf5ZuamVnk6pmE942TDKCGdxL/fRiXpHg2i6vY6q121
         v+9/joSBg5tILV4ciF13lPk6gQOGASpxFy7VkveNAObton3wk14tHJCCQyJl9vfQGQ65
         CLjD9uhahIjGcoWzUUpDHou5T8IdYw4a8+6k/lpI0Dk8lCf9Wuaz9JOfbkb2dJkt7nS5
         SXHw==
X-Forwarded-Encrypted: i=1; AFNElJ8Fkq1zZYNHVDh2D+7hUvi4XSBK5dFyBDgw4X4zALYH7H/7S0rUCaCvl71ChnyzyYWMlBp6vaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNprn/ADGIuO6PNmsF8BJtAqfAbR5SAZwgJSc9V/9KIjZGEtM
	0ysPxJeCSnXY3VF+Crn0JDYfP23bwWwtiBvVRtuAPpr3wR/AtvNFxaA=
X-Gm-Gg: AeBDieshcL600yfioy4F75hwKqbCY+NDW2Y1z05RnDBzf9vTozwnnFPQacnluzu222j
	RGahZXsWKmRKxg/3dXHIckNf2gLy22zkKiHki4URdq1ludC37zddAdP6Zwn28V64vtUaj5h0Z6A
	xw4GHDuamABU4sDL4waLvJi3UDI4yTtW9CCB3ztKL80EBconVG27usjQlRJFwn8j8UId/dEcUE2
	ZfTRd8JwQgOGf7RWKKtz9pLNpb623ypad0gWzi58yOEL25EF2R8WeGkGEdMJQ9vuZRwZ2voPLFI
	dmmgkZDD2GqC+osFzVQq//60SjySH8b1j3xBTfyZ/GkOb7jCCkJQKXHVb73Mh4038YhYAis4vYZ
	4/VNNI9YGI6Sis9Px4j8Iy19nJrRDmInbGFTbAnq37fCDjiamp8u+g0N8jKmd6MNN7tfCJfiiBj
	roqf7ASgFd5Z5PFag5eX8AsDpaeok8uoTXql77yx0gkUeP3FXTC7ESR3DLruOzib56buZOTN3ta
	BHRzCGQfzmiN8OGYLgcXhRrqeupDicgrCfDiQUJISlii3Q=
X-Received: by 2002:a05:6a00:c8f:b0:82c:26a4:df02 with SMTP id d2e1a72fcca58-82f8c9bad60mr35494584b3a.42.1777049935465;
        Fri, 24 Apr 2026 09:58:55 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d6adbsm30739984b3a.18.2026.04.24.09.58.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 09:58:54 -0700 (PDT)
From: "=?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?=" <mhun512@gmail.com>
X-Google-Original-From: =?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?= <pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
To: Devarsh Thakkar <devarsht@ti.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: imagination: e5010: release m2m device on probe failure
Date: Sat, 25 Apr 2026 01:58:43 +0900
Message-ID: <20260424-e5010-m2m-probe-unwind-v1-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 70034461A38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-241008-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6]

From: Myeonghun Pak <mhun512@gmail.com>

The probe path allocates the mem2mem device with v4l2_m2m_init(),
but several later failures jump directly to the v4l2_device_unregister()
unwind path. Since the driver core does not call .remove() after a failed
probe, those paths leak the m2m device.

Route post-v4l2_m2m_init() failures through the existing m2m release step
before unregistering the v4l2 device.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/imagination/e5010-jpeg-enc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index 42ad9ee399..4c250e2275 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -1072,14 +1072,14 @@ static int e5010_probe(struct platform_device *pdev)
 	if (IS_ERR(e5010->core_base)) {
 		ret = PTR_ERR(e5010->core_base);
 		dev_err_probe(dev, ret, "Missing 'core' resources area\n");
-		goto fail_after_v4l2_register;
+		goto fail_after_m2m_init;
 	}
 
 	e5010->mmu_base = devm_platform_ioremap_resource_byname(pdev, "mmu");
 	if (IS_ERR(e5010->mmu_base)) {
 		ret = PTR_ERR(e5010->mmu_base);
 		dev_err_probe(dev, ret, "Missing 'mmu' resources area\n");
-		goto fail_after_v4l2_register;
+		goto fail_after_m2m_init;
 	}
 
 	e5010->last_context_run = NULL;
@@ -1089,14 +1089,14 @@ static int e5010_probe(struct platform_device *pdev)
 			       E5010_MODULE_NAME, e5010);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to register IRQ %d\n", irq);
-		goto fail_after_v4l2_register;
+		goto fail_after_m2m_init;
 	}
 
 	e5010->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(e5010->clk)) {
 		ret = PTR_ERR(e5010->clk);
 		dev_err_probe(dev, ret, "failed to get clock\n");
-		goto fail_after_v4l2_register;
+		goto fail_after_m2m_init;
 	}
 
 	pm_runtime_enable(dev);
@@ -1113,6 +1113,7 @@ static int e5010_probe(struct platform_device *pdev)
 	return 0;
 
 fail_after_video_register_device:
+fail_after_m2m_init:
 	v4l2_m2m_release(e5010->m2m_dev);
 fail_after_v4l2_register:
 	v4l2_device_unregister(&e5010->v4l2_dev);
-- 
2.50.0

