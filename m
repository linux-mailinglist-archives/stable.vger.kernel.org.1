Return-Path: <stable+bounces-83614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF3999B907
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 12:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B55B1F2143F
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 10:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FD113C9A4;
	Sun, 13 Oct 2024 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ6PMeYH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7E182BD;
	Sun, 13 Oct 2024 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728814491; cv=none; b=NKTY5vwW+9XtJkbYCemrmSNcOVy2U/k+dFtezlgYrF7V95MrbmG+8ndaLWuLsu9eHM9m8KpUpyNUCcPot0FQ0MV9wdDPgGOR6S1iI4SbnN0/P41mI4UXFNN4Fd/7wEiG9By9ViF7RDX9+hq5FNZZ0Tw/UCyE15UsgtfzUitZROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728814491; c=relaxed/simple;
	bh=7+RcficBzc14ETf8NEF5WHyfEtENBovrl6Xqlc98hLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kiHzV8oUpIdMLJNHaMPYVBadUVoyx7hlleE8cadvkEWpMXEF+wWzwWOCy/yE2XUYrpfEgT3hnuNVkZGVjGO5cF7Eu2KQzD4WoRyobCJtnWmFK5MGrkEsFXqT5sd0machbkWZAaxM7IkOaWgw7VQj27fKery7MbE2YGcuf0FM9CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ6PMeYH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4311fd48032so13273025e9.0;
        Sun, 13 Oct 2024 03:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728814488; x=1729419288; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/mk73CKrklNspB81avVAhd0DlaNLFtrpaW5syyiDkJo=;
        b=IZ6PMeYHNO72yOt8bFf8p7h1VcZnQDveVbyXvHwQiW9v2LH72N8Gz8Um4FLEz7wqAo
         3/PDnDec2gP/OAXGaRoNr8K80vwjA65IKaCRNo2QEVTp5pGNGklO0Fbdkzv1o5Gj84zB
         hFq/UFttUIUvESgnQ2qiV0lDW21ULA7F3JCXZcpO3JDGlU7+suFJm4wvbjo0JyiEkt15
         IfOcsiMPDA3v81+2ZW5UN6771O2HRdZrMVRP6sZ8GrBL+40izRC/srgUyhb3eyvCvo8d
         nKIFmtdKYgaLVVxLkzBBnGYz7HsL1NZX8noXj3Tsi9Ez6ncxQZz9GW1Inuy53qAWLNAt
         480Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728814488; x=1729419288;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mk73CKrklNspB81avVAhd0DlaNLFtrpaW5syyiDkJo=;
        b=kU5A2YecShwjnwi0SpjZwcjBeOepIU0JgV6pdYqoGI81uUmhPIaV+YbNXjFusBf4Et
         WHRKRZHw/jt+RXMQ7qGd6bk1TAf0gJs6lJ8g8JafeAAlRKcmeJNOvXNIu6BSJ2X2bdnR
         ehMfOlP9NvTMaBRVFxsTX5WSuaa+0w1AMNhR4w6N0bjTW5NYbsOC37Gt8xjum5+cDr+/
         eeI4vYsgto6mfCV+WAFR/UHnGRnGswSfF1IhdLFzfddcktftnvsKfFhXMmeq6YE3Vdeh
         gSPVrsJo8Zj+yEz7rB9IZ9Ea5N9NkRSgtpikvvp8Ucxra7j32li763RZAei1f3PkvORE
         xVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyWYh7Mj2eH3pYS4K+JGH1Wai8AF/eqtbSRAci+Qpo/pi40hX7s9qJyN0mZ9yS0saqgQLTdGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTCJCwHhNza2/1lSy3RQ3UZPjDXrAdGgdpHftunYPkiC6sJJ3I
	P5QLh+rrfr7GY9WO5JMuIwEtGpFOFNWQDS8SDqd+TCBxkQglUeDC
X-Google-Smtp-Source: AGHT+IGCOgNIc4rS+8pa7uJsokRdoIQLWUs7Eyp7Z4Ome3ezHBMJMFCoQgFlnyEsp4DG53u9u1J/eQ==
X-Received: by 2002:adf:b1c9:0:b0:37d:2e59:68ca with SMTP id ffacd0b85a97d-37d551f19b3mr5278932f8f.28.1728814487367;
        Sun, 13 Oct 2024 03:14:47 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-01f9-6cb5-d67b-9d29.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1f9:6cb5:d67b:9d29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f679sm8235568f8f.73.2024.10.13.03.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 03:14:46 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 13 Oct 2024 12:14:45 +0200
Subject: [PATCH] clocksource/drivers/timer-ti-dm: fix child node refcount
 handling
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241013-timer-ti-dm-systimer-of_node_put-v1-1-0cf0c9a37684@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJSdC2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0Nj3ZLM3NQiIKmbkqtbXFkM4eanxeflp6TGF5SW6KaYGJkbm5pZmJt
 ZWigBjSkoSk3LrABbER1bWwsAyFlRn3IAAAA=
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728814486; l=1481;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=7+RcficBzc14ETf8NEF5WHyfEtENBovrl6Xqlc98hLA=;
 b=PeONw693MDWIV8OHMec0Fa78BjjJWFwtICqLMxfbu980WynbvxWD14jkdPBQNtZ5ecSW3a0vv
 40vd6GJmVLIDRo9lvN/GrcNdXnsY59rb+fMioipwwRhI6lGJkcAukes
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

of_find_compatible_node() increments the node's refcount, and it must be
decremented again with a call to of_node_put() when the pointer is no
longer required to avoid leaking memory.

Add the missing calls to of_node_put() in dmtimer_percpu_quirck_init()
for the 'arm_timer' device node.

Cc: stable@vger.kernel.org
Fixes: 25de4ce5ed02 ("clocksource/drivers/timer-ti-dm: Handle dra7 timer wrap errata i940")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/clocksource/timer-ti-dm-systimer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index c2dcd8d68e45..23be1d21ce21 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -691,8 +691,10 @@ static int __init dmtimer_percpu_quirk_init(struct device_node *np, u32 pa)
 	arm_timer = of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
 	if (of_device_is_available(arm_timer)) {
 		pr_warn_once("ARM architected timer wrap issue i940 detected\n");
+		of_node_put(arm_timer);
 		return 0;
 	}
+	of_node_put(arm_timer);
 
 	if (pa == 0x4882c000)           /* dra7 dmtimer15 */
 		return dmtimer_percpu_timer_init(np, 0);

---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241013-timer-ti-dm-systimer-of_node_put-d42735687698

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


