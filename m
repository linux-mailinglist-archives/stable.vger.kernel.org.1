Return-Path: <stable+bounces-161749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B29ABB02CFA
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 22:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7021AA58FB
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 20:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569A822652D;
	Sat, 12 Jul 2025 20:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ks5ZzqDR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7F2AE99
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752353773; cv=none; b=OfdzKVaVYuPjWVq9BJo1S4lXJrphbBcyouI4ydM7WHIQg1ZVAdony1CqYY7n5bPnHE6W7rcnpoBtQLOqzcC27oWFEcWzRT5Yiz+Xw9HuVphU1aRNqcowpiRJxHPri1oH/1EkuaAhZ6j/g0QvL/H6PcwxF+QOdESksa34xhQE9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752353773; c=relaxed/simple;
	bh=d9VDneEhgXaHiNGPMvOTEaRaZEMx/STHE2yR4hXGT74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drxekdrlTAMRR8sig61gM/zluS98kcSSZ97h6lf//6iU7V25zR9dQhM9mBCYPP7fF1oaGbINcacCln/v0iugZNCFlUIDD5aqgzOSGOS8ooQRfdkGLz7Ku/rSorNdqvmYhlqC72EX4LLMM21GJur0KwzDjbPhl/uSSgHLxRwAS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ks5ZzqDR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso5234953a12.2
        for <stable@vger.kernel.org>; Sat, 12 Jul 2025 13:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752353768; x=1752958568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1g1pkJh83TSclyQ1CNIx/RZEKJ3+sOjU0gRAKumiEDc=;
        b=ks5ZzqDR1X4aPI3QYS3ikvyDhy0/ojdQcxAA1IYaTDt5e3sJLfmDQFmZ5H8yefpx5U
         kn295IRnJDZFss6YdpOh1Sr5Z0KovnxB4prR0RbGTM+ELKgtE4BEReCd7CIvlBdNRJ8Y
         vuz0sNWpZfe5AsU9me+Et+a6YSvQOu5LeSiVtMWk6/KpEXazWZ7j0v0i9pjgsoRDxGHl
         eTtut6JtzWuBi/a5n1CkAhorlbEaqVXPqO+KziCEv06xdfF/wIa6bLS4MYzC9Rramnqy
         vhfHP1WWo8SpM/Yee9XtXVoZoHxVUN4D7hFBMDj67hWlojt2563oOu7wgBJqdeLLxmFa
         FLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752353768; x=1752958568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1g1pkJh83TSclyQ1CNIx/RZEKJ3+sOjU0gRAKumiEDc=;
        b=oJFCD76gSQU/jS1F36nV3s1vArFV+6APM2VWKC0eD3ITGt123cQvSxDnI3CsuNCcz/
         TwUDW+veRLnBEaPcPZTpiCIVlLV/kPFMKOFhzOuvs1Rd5Aq/3NRDh995bQVyCcddWAJq
         5LGlX1xrUubBod85g3lPKZC7ajDWxX6L5U1Nu8EdJXqncbBxt7xjHOrcjr5wPlbPIX2P
         zkaZSziKbjasgR1p0oeCkbfUWr8tDIRLMCeMZbwdsNksvh2g0YlXypqx1J/azbM+Eqc1
         IfRZoh4zJIicg5DziuW7ABbSKjg0FFD3zU0jwcFFnr0OsjTUmKi3NeRDdoFhFPjkBD0f
         QYJQ==
X-Gm-Message-State: AOJu0YwUJ4PxfefAAPB+957ONSVeSAL+XqjM3QGoeS6qhZOFzC3TKNhs
	OEJ8vFx75kZvPS3C/2MV6pyBxag+8BN+hnetmBzWNdCF0asRJoo4zb+yfZ1x3pd25s8Eyg71+dl
	Lhwpd
X-Gm-Gg: ASbGncvBl1Q7s+8ZM3Ef2aXoxzVEK36LI0U3HPe29WHMkz/BSq8aB80DbqJxB4ANjFJ
	VC4NRmReZYjVRDVDMA7P+IVhiV5ruDKleAhWT9V4bQJLx8sl0z61GBlQfzikBKRa0nt4uYV04QS
	MJdGpyZONvwYYk4U1oVLp49ToB1fIwDa1EM6qOHH1/jdLUdLSCBaZky84BQkqPWgKIkvqDNmev1
	pO7LCgihVWy/cEX+Fu5tONeNJH6bD8EhPpIab2htOPtyEGSswYVGv6M6pbkhPraoGCygg81T5Re
	r0jQKALQtRroFcFWqpm0vWkQSe7S6dJQKwD2QvY7qeEXFiu3Brv3IQWTAkKlylaw4UB4yeBoDNi
	sshjg8FPRoMaRf5WPzhw1E1/1wvwLACmxumC+tA==
X-Google-Smtp-Source: AGHT+IG44bcETsH/Ktx+IlY4Zp1VC1Zo74ESPfj0IJHRUGnNYFXOYmdE73IsbrS351gyt3DRBgb8+A==
X-Received: by 2002:a17:907:3d42:b0:ada:4b3c:ea81 with SMTP id a640c23a62f3a-ae6fca6db62mr718993766b.39.1752353767677;
        Sat, 12 Jul 2025 13:56:07 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae6e7c09dfdsm539257966b.0.2025.07.12.13.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 13:56:07 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH 5.15.y] pwm: mediatek: Ensure to disable clocks in error path
Date: Sat, 12 Jul 2025 22:56:01 +0200
Message-ID: <20250712205600.2182944-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2025071235-ebook-definite-e54a@gregkh>
References: <2025071235-ebook-definite-e54a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2226; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=d9VDneEhgXaHiNGPMvOTEaRaZEMx/STHE2yR4hXGT74=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBocsvhdw9m45p3p60zC27VUOx4RaLrPBl1PPeMP S3bvYnxjveJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaHLL4QAKCRCPgPtYfRL+ Tg2fB/sG4T/66tA/TcpcXdv+Jea4IJMqiQsJSVw3BdYKRozui5GGeDs7HWlPlv/3xJkVyAVyG2K DeRXB4luE173ToM+9KOp5y2oPBVIEu8YvQJypjrRVj/QZ6YvyiqFcHwmLNKBOP5wOikkMTIcFH4 qSmyMkRpqh2WW/AtUB5E7o8kwJHf6HEkXqzNHFPuLObZ9iT28vOiHzRXdU5erOxtJL7i3ehQedi fzc/a41GL+aa05+HS7RacoVUbBlUB8stI4jh8pci36XImEaO2dFpNg6N9/WZJGZMy0Go1beunIu +L5NubzMcIsFMe6DyUCuDH/4STuLv2yx9/Fz6sYlqQ16dJnV
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

commit 505b730ede7f5c4083ff212aa955155b5b92e574 upstream.

After enabling the clocks each error path must disable the clocks again.
One of them failed to do so. Unify the error paths to use goto to make it
harder for future changes to add a similar bug.

Fixes: 7ca59947b5fc ("pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://lore.kernel.org/r/20250704172728.626815-2-u.kleine-koenig@baylibre.com
Cc: stable@vger.kernel.org
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
[ukleinek: backported to 5.15.y]
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index bb764428bfe7..d8a80b06a6f2 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -129,8 +129,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 
 	clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
-	if (!clk_rate)
-		return -EINVAL;
+	if (!clk_rate) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* Make sure we use the bus clock and not the 26MHz clock */
 	if (pc->soc->has_ck_26m_sel)
@@ -149,9 +151,9 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (clkdiv > PWM_CLK_DIV_MAX) {
-		pwm_mediatek_clk_disable(chip, pwm);
-		dev_err(chip->dev, "period %d not supported\n", period_ns);
-		return -EINVAL;
+		dev_err(chip->dev, "period of %d ns not supported\n", period_ns);
+		ret = -EINVAL;
+		goto out;
 	}
 
 	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
@@ -168,9 +170,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
 
+out:
 	pwm_mediatek_clk_disable(chip, pwm);
 
-	return 0;
+	return ret;
 }
 
 static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)

base-commit: 2f693b60754599cbe248b385e7bf939c72f3e30e
-- 
2.50.0


