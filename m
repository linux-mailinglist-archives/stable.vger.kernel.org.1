Return-Path: <stable+bounces-161748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDFCB02CEC
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 22:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BAE4E288A
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E341F3B87;
	Sat, 12 Jul 2025 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LJNj4MK/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1618D
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752353172; cv=none; b=Q7IsuwxwZ9mD4UZtQTnzvOhUxtBvq9ilEK1dNRhK5Fe2RB8XQoXvX++3tYW207dt6Gpmk63ocRYaO00fhbNNH3MTGiOVKzHWgU/B/41W4ogyZ9ZootQ36c26gTuKknTv8UvXnDJpmmWEHe0eK4cNzN6kOl9OtkpKs7MomhJtbn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752353172; c=relaxed/simple;
	bh=YIzys8uD9Jtj377Ty5Qd7KGV95r50wTPlNJEKiFkWo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVYz0GMbRRohlEj8LwoOYlfINtZWc87xE6Xbe4WIpTEvZvex21QO2If0eMY3rHglifeEuilIlPxxwJvSf+TTkRKl4RSJF6uqU07Z7A85NkL0EgbXvuIqusCiKHUrQ0NA6dg1v//hG/ZSzHWyL9g/WaoHEW9w7PGXfThy/5T8GqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LJNj4MK/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso4394651a12.0
        for <stable@vger.kernel.org>; Sat, 12 Jul 2025 13:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752353166; x=1752957966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mYIzTU08KF9gAvuJ8XpFyDGY/9XYSjjpl1oP8i7Rko=;
        b=LJNj4MK/U8G+UkWcHO+A50BDP3J+ofSFYllVPlkvHOOhEKFa03cHIyLdbtjjKz/pMp
         wANXCQxGRJendjs8rfQEjfsLSoPQLyfKtDlXvqjtmi5lzqL26DRKib+EI2eTZF9fKK5B
         NoKsPKjjNxKaABd8BGFAGb4cLramETtZaUcsMZSvJjWKtIYOcY/OJmTfeuReRv4PRVgB
         2xgYB9LuqXm1vhgPsmz44hh/SHtLCGS3nAhIa/tgyAQTUXdO4XTWhrBFkoSL5I6VpnSb
         8JDheEnc+HW1bGvYafx4UKdP8qIGXOY8n9eJ4059GG2vKWz7AEoYlXx5vM2CRNPLsTQm
         /eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752353166; x=1752957966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mYIzTU08KF9gAvuJ8XpFyDGY/9XYSjjpl1oP8i7Rko=;
        b=egm5zSyr2ab5bmpguA/MQzhm/YxUxJF5etGkkQMvxnLAHPddm1729FcV1cG7cJB6Ju
         YHlyCCq9YK1pV9Zx/W09wQZIXahSXBVakgqGHSxsKZdosRCcfa8PQqgMq636PJliyZ/r
         wd5MTLKQkaQoMB+UzyvkK5LuAt4FXxNFg9qcjKmRBxfU8mH65alDJd+0xrOXpbKzoe2m
         ZrIS6nNmCDgC6fSdwp+WRJSp2ucM4bifepv+Cip/3WhdUaAYXNlClfymUja9aQs5Cotq
         4Yv8X/ukYbEl4Xq20CFy22Y2KV1MHl78zotMngu+4W7I+JjFiiRNzswXeb0hwRxdMPZ1
         fKhA==
X-Gm-Message-State: AOJu0YyMsvrEEz+1JU8WIPj+/OMucF5Rep8i0Qtpg98LOMclZqT2/SUB
	5x+i4Ve7UC6Jz6PJdSGvKXo8YyZX5J4bkB+dL7Tl16fkMWsVUumyKci8RbfvZegfCPRk+AABQza
	2tF7Z
X-Gm-Gg: ASbGncspQfdEvJkvqTFvf1O3WEvvwKOkBV6Bj6wYAG7FiBGavt7Oe1QeR1J5HNh8Dlw
	DLqThXZb4LCqgdJxVeRR5s8R8HGlMfGdrqKcF9w/FdYEOJwBqig95xiDzAFsO6Ci9re7+SSgNoX
	Ofi9adm96wNiM9ms77Cz+Uxuj4j1B/XM1Ix8nkJQZYJuQLohWMkaT2XMUzIHje0EKpdn0ng028K
	48ommE1S+FF8IamyGscvftFHHCrErjMpbjPFUY3g2j6y+7C8cYFAXPtL4WpC/x3jhyVru6O9U+O
	PXpK6yOankJJqnUzZuB4+NxoMLUeF2MCz9sqq37qxA9+dQ14qdi5YDYNKEFvAERt5npbo8jQXRg
	nq5InGGcqU9W4gx25N0Dlg7UR6WI=
X-Google-Smtp-Source: AGHT+IGHS1lToEM6N0lEjafuZLh7PV1hpzOXIk7myo7VZh1Dh1NaaeKy+EQpXaWJfvtpPSF7/MxA+g==
X-Received: by 2002:a05:6402:274b:b0:60c:403c:ab77 with SMTP id 4fb4d7f45d1cf-611e84799e2mr7376060a12.19.1752353166365;
        Sat, 12 Jul 2025 13:46:06 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-611c9523a75sm3994818a12.25.2025.07.12.13.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 13:46:05 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH 6.6.y] pwm: mediatek: Ensure to disable clocks in error path
Date: Sat, 12 Jul 2025 22:45:44 +0200
Message-ID: <20250712204543.2166878-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2025071234-appealing-unless-4a54@gregkh>
References: <2025071234-appealing-unless-4a54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2159; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=YIzys8uD9Jtj377Ty5Qd7KGV95r50wTPlNJEKiFkWo0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBocsl4nE0PoTTXFYsWhnvyB+BL9VEP05U/Aqg2E SOC7ylewXeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaHLJeAAKCRCPgPtYfRL+ TgmTB/wLgbjO1K4St8X0sTNSsxsWFzczyIOnLcbuzwF2Dxrc/J3ktdMYHHmErlByU6FT6bUxKRD sCHuCL8ek+DqtLqaUG7G9/APS0AgMoTdFWtwRrP7DV5a66HLpafNixCrLcQUxj5KOR3ty7Tce/H Mv+a7BrbXDVIo9cQJI1MDrc/tjYOsxhel+ioPliBvT/jnhISVdP25nXRk2rhXEXwXXmQXPefw3y VzC2lI3nbJigxmiMK9DvOTv+QUsr+7bqSeKYYTH+QXcEu7M7rvIcbWfnDXg8QynaZ16W0GC10+X lLXciKVPW4DF6bAFUbLcDrTgvdepP2y+CdNrEZjQQ7y8w1yr
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
[ukleinek: backported to 6.6.y]
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 6b1a75b6bd12..ff7c70a0033d 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -133,8 +133,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
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
@@ -153,9 +155,9 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (clkdiv > PWM_CLK_DIV_MAX) {
-		pwm_mediatek_clk_disable(chip, pwm);
 		dev_err(chip->dev, "period of %d ns not supported\n", period_ns);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
@@ -172,9 +174,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
 
+out:
 	pwm_mediatek_clk_disable(chip, pwm);
 
-	return 0;
+	return ret;
 }
 
 static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)

base-commit: 59a2de10b81ae4765d73142acde15106028b1571
-- 
2.50.0


