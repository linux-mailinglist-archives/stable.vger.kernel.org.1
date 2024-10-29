Return-Path: <stable+bounces-89177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5EE9B460E
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 10:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED0A1F23799
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C049920408C;
	Tue, 29 Oct 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QuqLiBct"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C68821
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195660; cv=none; b=nmtvNG6PmQWZdX/fifLymkiexS9NfNIEL957ABHV2VeeI7EPq2urcbrGeMgVPLYJebFOmKGQZrQtbRceKrI+3N6QMeh9vBx5NCMrEZFaHUdqI7mYpjD+1DLM7Ho3/5CUTpe2Rje8V5Zn9pEo52hJGZCCvGPbG/95lN/9V+u8RxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195660; c=relaxed/simple;
	bh=4TzmmDoPs2T7BWH4lmLx2iMOLyLLeDpoERxRmNcYf8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d88w4KInym9JikUOa2vNDup1C0alEJrlZ9r05oQAr0T/yFG5d5PnCj4vAnBDyCR2jjYq/333766m+/oOYhMLrlphLqwm0/DdDTdPMul26YVNWf4CZC/eIi1+8n2wfjsSDt7PvEK5L6thztmLZat8mo0Wj7YOUsedapan60f9Gs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QuqLiBct; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20e6981ca77so56079125ad.2
        for <stable@vger.kernel.org>; Tue, 29 Oct 2024 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730195658; x=1730800458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zRN2Q2s1tXUlBpPwz2Gezq5YzOvyUe388g/hG6wINCo=;
        b=QuqLiBctMHMsnJHFnH7I5KnJLWmAziIXXemINuSHsOsmM+DpYiqtuiv4DVdxAuBMOn
         GGlcwbDTRnswiUJOlBXkEm6BxonSGCvW1vWj5lKXARB6SLV7Dkyzcowpmi0XOHEyXoV4
         QMFRwcZiABsJIoWueKcdJ/9Hndnv54tUD/rtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730195658; x=1730800458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRN2Q2s1tXUlBpPwz2Gezq5YzOvyUe388g/hG6wINCo=;
        b=KJ37HiBiNCmDxGc7dmf5QDKk90qICNW3rKb2yn33GLz+aZ9QJycNrgUr/WKPo/tVGV
         eDNwIvGpAzxOEICs+D8KzGZ9KDvVoQsZQqeEDfkAoEpIw1aStOPa7TJgLrIwwAIKLcb9
         TT9HtHhDN2u2lUA3fyKWZ09WXbairqaMxUd8giO8Wh/LyEdgVcQ0Ew1rkHHlbouw49v8
         blq4A6MbUiO2qMJrXu8mNTSOifwcKrgcdfm3Bsmp5v2m5b6iNaF6M6OWH87kWuVcVO0c
         sZ2MrYz3ic9nl76mR2Pn5s1WA1DBfEcC48gHlRMZ1aND+ANX7fHSeqAI5D0ieN/L8uLc
         qr1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/pzy3UfIfKyjvtAV0xoFO7HfHW8zIriYjO2vOD9PPYQEy0b8N7sBKVJX0heSBEP86pkrXR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwzEBldocXahDgSx8vFMR4FPZzuC+pY41J3aZGW4v2eXmr/D6N
	Rp9sTXKcCR3yakaGv3jL0qZlhiCeAC19WZL0sdiQGNMElh149NLG3b+/vNpBgg==
X-Google-Smtp-Source: AGHT+IGJKLBeHml2mgw0fqam5oO7OYmdphXyqZ72BkhYs4KBfI3AcNJBCtRzWfdnOR4KM6obA5v1sA==
X-Received: by 2002:a17:903:2289:b0:20b:7ec0:ee21 with SMTP id d9443c01a7336-210c68cf5a9mr165968125ad.19.1730195657831;
        Tue, 29 Oct 2024 02:54:17 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1fef:f494:7cba:476])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02efb1sm62901235ad.221.2024.10.29.02.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 02:54:17 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: it6505: Fix inverted reset polarity
Date: Tue, 29 Oct 2024 17:54:10 +0800
Message-ID: <20241029095411.657616-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IT6505 bridge chip has a active low reset line. Since it is a
"reset" and not an "enable" line, the GPIO should be asserted to
put it in reset and deasserted to bring it out of reset during
the power on sequence.

The polarity was inverted when the driver was first introduced, likely
because the device family that was targeted had an inverting level
shifter on the reset line.

The MT8186 Corsola devices already have the IT6505 in their device tree,
but the whole display pipeline is actually disabled and won't be enabled
until some remaining issues are sorted out. The other known user is
the MT8183 Kukui / Jacuzzi family; their device trees currently do not
have the IT6505 included.

Fix the polarity in the driver while there are no actual users.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 7502a5f81557..df7ecdf0f422 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2618,9 +2618,9 @@ static int it6505_poweron(struct it6505 *it6505)
 	/* time interval between OVDD and SYSRSTN at least be 10ms */
 	if (pdata->gpiod_reset) {
 		usleep_range(10000, 20000);
-		gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
-		usleep_range(1000, 2000);
 		gpiod_set_value_cansleep(pdata->gpiod_reset, 1);
+		usleep_range(1000, 2000);
+		gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
 		usleep_range(25000, 35000);
 	}
 
@@ -2651,7 +2651,7 @@ static int it6505_poweroff(struct it6505 *it6505)
 	disable_irq_nosync(it6505->irq);
 
 	if (pdata->gpiod_reset)
-		gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
+		gpiod_set_value_cansleep(pdata->gpiod_reset, 1);
 
 	if (pdata->pwr18) {
 		err = regulator_disable(pdata->pwr18);
@@ -3205,7 +3205,7 @@ static int it6505_init_pdata(struct it6505 *it6505)
 		return PTR_ERR(pdata->ovdd);
 	}
 
-	pdata->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	pdata->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(pdata->gpiod_reset)) {
 		dev_err(dev, "gpiod_reset gpio not found");
 		return PTR_ERR(pdata->gpiod_reset);
-- 
2.47.0.163.g1226f6d8fa-goog


