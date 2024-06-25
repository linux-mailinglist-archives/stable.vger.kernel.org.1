Return-Path: <stable+bounces-55152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8E0916079
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03091C2321C
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 07:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A58146A86;
	Tue, 25 Jun 2024 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Mc+0k3h0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3411482FE
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302061; cv=none; b=hsdmjrfhBGGblSqKuD04h9VU86o3ZgBWz/xUIWm3up5S73uMyRM2A6FGeB4Qg4BU5rtc1MBG24mGJKXgoUZ+Q5c97BJzoQ0gv4ptQFHCie7u5zXesAuyYQ1vVgVGkVLSoQ18HJZ6GDB2HVQGlOcH2+MPYDQY/f0eTxPnsZEUjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302061; c=relaxed/simple;
	bh=vgHzisDuT0iJzCuuIoW7X2DUFgML5VTu7SmEM1cGiG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRw8Q5qZGVntKokZfdLPXdY8wsx6IFQ+oA7bAY8SEJHi3k67KjHts1zmryKjFpGp43HBbO9RhGV4vBQc7d3E4C4/jqRiG81PF1HVgxWmeHRWm2ZqdEXD94DlNRS5DwGtVUxxxN9lstuZPOUu4JVssxCapL3OEvDQ+YKbJ0B8ACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Mc+0k3h0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d280e2d5dso5100587a12.1
        for <stable@vger.kernel.org>; Tue, 25 Jun 2024 00:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719302057; x=1719906857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bB3xYYe7ZA/uAnW7E+pDtVTV7cgwJ7qX0XaQXIZK9tA=;
        b=Mc+0k3h0YSyLLLNm+dLNwE5U3FNx5NFa+XKSzlyYVdDHkjbK/VIBOrFcTqk+I0YnZ1
         CTbvxaAErmkYckjdHhAfaNWaaRWVICJCqf+KrJi4rSXSqL/r6AND8/AbsWoCMtVWR1z1
         e9N1GmUNVS7nNf7bBbVYZdBNxClVrCL/OcjOCPCzoXY9GlpI1ckcOvmxX6fUgllVWH5Y
         J9d5lDRSOxOY9Abf1Ycym8vqP1ze1LEUoPVLievvn/zDBQtpYCTsD5b9BTv8PahaK5/W
         TKG9RJsyjimbmEWpZdDjzNCFbZ20wUf5Wt7dGIQ8DKJZha9ZtwOfUYLGv9sVo5jan9/s
         j9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719302057; x=1719906857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bB3xYYe7ZA/uAnW7E+pDtVTV7cgwJ7qX0XaQXIZK9tA=;
        b=UoLTSoBoKsLsnkCvFfjjepGK7mUixYSWyPRJJjKhY5Aea8ttdaMy170M5n7yYQIe9r
         pfVRkeUCu6oH8jF1m00ysymFcJXz5kAS2gjbZKumKmD492wH5mpAKYsWEdQSEfZUzSlt
         QaN/g+f88mBocLAxS37DECmVsC5n0itMOxUKHjAi5bZis4MlgwSzWENOAvCYLcZPoZZg
         g1uXAFWbGm6q3A5UhjIRnFVi0tZoW+VhY3Oa1nVFR6yn5BAx4KKrD7acgc5cdq+uVj6V
         EcO6p0MDEs4w7DzCu5DSFiUorIt311wYlUKjEx6ZX/24qZGcP1wht5sV0ve5tmzsJf3R
         XF0Q==
X-Gm-Message-State: AOJu0Yxwv4MZ5hYc/4icohRvqsYc5bTU/X9ecp0sRJZ0mkys+M0+LS+J
	hi1rU7c3IZF1+kmW0kpMtpq+2mfBovFCn+X3e3jVGOdwYLO/0mDzCJIhAgMOu6nKMocmbk2b/uz
	v12k=
X-Google-Smtp-Source: AGHT+IGGh2clfBWEbl+VVyTbJVBos2Uurbt0TynqiVjvhTAzbLUNtOdEpJRlxrn6onzE/+HeRE1n7Q==
X-Received: by 2002:a50:931d:0:b0:57d:2659:9142 with SMTP id 4fb4d7f45d1cf-57d7003207bmr1247046a12.16.1719302056962;
        Tue, 25 Jun 2024 00:54:16 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d66b04378sm1265743a12.38.2024.06.25.00.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:54:16 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: stable@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH 6.9.y and older] pwm: stm32: Refuse too small period requests
Date: Tue, 25 Jun 2024 09:54:05 +0200
Message-ID: <20240625075405.2196169-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024062455-green-reach-3f21@gregkh>
References: <2024062455-green-reach-3f21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=vgHzisDuT0iJzCuuIoW7X2DUFgML5VTu7SmEM1cGiG0=; b=owGbwMvMwMXY3/A7olbonx/jabUkhrSq8rnh+lOTC6JkONPWzWb3k2VvNjm9wSZ/daH/T5u2/ YZXGt06GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZhIZR/7fxfVf4Y1L3rX+Hxt iFx06ki42YcG5tctvy0UFPblG9mw/Ne1+cOpUcHJ91ClI+2DSuIEo3IzzitN/Zc3VS4oKhDM2ff 3/NvmjTOO/I/TXayZKZWx7nUPa7um1xE+0UkHzKR+8frK6j12iSli/OsXJXuUk/vilAkTbye376 xInH1+hzhT9d7YflPG1I4LxieSGfg9n/nmfSnM/2Mr9HwzX8/W/ezGVUeYa9w+htkf694aLfROI 0FVMFJvedZfDcebnsFHp+jwvLG1bj3x6s/rot2zymzSI9Nn75J6vnnL5tyCZy9bd22SXTKlOrIv xqznWt2SBKEmtUtL5uf4X/u+3fXd1fJv3/dP+vNENHA2AA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

If period_ns is small, prd might well become 0. Catch that case because
otherwise with

	regmap_write(priv->regmap, TIM_ARR, prd - 1);

a few lines down quite a big period is configured.

Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
Cc: stable@vger.kernel.org
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://lore.kernel.org/r/b86f62f099983646f97eeb6bfc0117bb2d0c340d.1718979150.git.u.kleine-koenig@baylibre.com
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
(cherry picked from commit c45fcf46ca2368dafe7e5c513a711a6f0f974308)
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

this is a backport of c45fcf46ca2368dafe7e5c513a711a6f0f974308 to 6.9.y.
It applies fine to 4.19.y, 5.4.y, 5.10.y, 5.15.y, 6.1.y and 6.6.y, too.
Please apply accordingly.

Best regards
Uwe

 drivers/pwm/pwm-stm32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 0c028d17c075..9f07d50aba2a 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -329,6 +329,9 @@ static int stm32_pwm_config(struct stm32_pwm *priv, unsigned int ch,
 
 	prd = div;
 
+	if (!prd)
+		return -EINVAL;
+
 	if (prescaler > MAX_TIM_PSC)
 		return -EINVAL;
 

base-commit: 9c5a72fbc90d829ffb761da64a73c23cd4e0503f
-- 
2.43.0


