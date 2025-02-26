Return-Path: <stable+bounces-119677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F336A46187
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F42273B38AA
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44F522155C;
	Wed, 26 Feb 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJty9foa"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE97221542
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578356; cv=none; b=KNeK67OieBww9LyS9sghsw1cQYibfzsyJfC8sGa7hpGxUUl24IEEUzDGhv7PtI+xv2LtqcSyIox1aZLWOr1NftOvmQ5pOGQeyjovWJzLIJenesypH74kwgLBu5hnM+hawCW/yMu9D7qEL0kpVNqoe+up7DZXQ1sYlvK6v1YjlFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578356; c=relaxed/simple;
	bh=B6vNRR24vZm7iSTdEc4QXuLRyq/IRPqoeXQGjK0c00E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DtqkVrYCzVim8xtJB0hMmVfx59TMBDUL+I0LWiR1Q2Gn8HvJHuwx0Fe1gr+AiTWCG0rCgOmOnsqqI/QY1Ztv9ruZZ8Bjws2s58GHDqdMpOWLhO/zOpHO7Oib5r5gg5Y/4u73wjMdXoOMIXewlfPvOlidxJzZDMAj6+njB5O8ZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AJty9foa; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so10446005a12.0
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 05:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740578352; x=1741183152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=436GsJyLmwRgLe/Pi/bM1GPjpxKDesYcznC8EJvTAV0=;
        b=AJty9foaOFCNTcFISDPOiUln1DzprL/0pvfUnI4hP/loPrclGot4zA3rANemzNkXLW
         At/kJmMf+ASZyzFMurB56acxTTvx4+jG+Yo2oImY7mCAAmCrDhCqgWZYPM7fegBkHpjR
         VVKK7AUNHZ8QHoqRkQhh0V7NREkjgfx7NIIwwHa8S2uQIXCso+u/bIi6yAEoG4wFo077
         lVl+umbE0gC/nOjI0G9MflIyJi1g2LUh+AZ0UnsaQgbSOlzete1zsMYz5QlqKyKkdaRO
         WS98/aBa26lAiPTXX7Lon6MPjiTt6TDMY3LDbk4HHycPkAOnckio8hkF43xbta5UeKTA
         lAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740578352; x=1741183152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=436GsJyLmwRgLe/Pi/bM1GPjpxKDesYcznC8EJvTAV0=;
        b=RTCLNghujykARpDFTVkQmu7DDL0wZV2LW7QyOsYGql3NXYmBZbJwmws24aj300u7/f
         LJzoLifWCGf/fRrpPfxXW+NE8D8LTtMT5Ddc2jpqoJY9ZO3DrY5kcQgLng7k8FtITTqA
         5bj1/ImvQ0qPMfVgRwoXnlUSptQEqLl7fK8fczJd2ysPD6CTTyis+yXpBRv4cJMfwhHC
         SjYGY15hRUtIakDSQYemck48tMRzbbdTsv3J9SjNTAS/dY3//xcf0cUeAwSTXPtapuJE
         JGhYM1mROiMoPw2DH2L6kJ+F61D22Jqi8Mi5fQ1nnjR3Fx99U5jYMArjz/F9Y4HyQG2m
         IZfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhg9MiBZNHPxMHH3+g1U9V9zw2QYzXL2mhqCcC57ONp0LtoVmhnhOnhcV8+5RrSYHeWkFS+ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEutC+AmholYTJ0FxK/KpvvrP6ANl3hiXnNhhwBtjN5HY80fCZ
	uMhtSfZQqU+sA8125IUAJTWYyYjLPA/JSrM+QXkap8aOhr7lBTlppl7xQpMtVNg=
X-Gm-Gg: ASbGncs0TrTVKnjE+uzr+lhwNbc1KhkKRhVYlQjPrSViKU7nX/MQ2XxWLD7+jQWszjP
	6sIUk96m9MeDrlSk5nUgw4/dIicYcTh4eNV20ffdGyx4c4rwUbwbPU9DrjFjznrDcemTqDgkI4c
	fI9WOl34ufSI8m1R9MgCb1CJ0euJuctcl/wkXQkMDRLa7d8Jk5t5gzC+FFcfmlOdCD9vTH8xu/s
	27xgjg1aprE7RrojUqgmfrklOGLNr0fHAFgoXkQWpvnM5ophoE/OL142oJHUZk9iAzEDiABlTgc
	ogNL2EnAUFL+xyVLZ9DC5xpJ
X-Google-Smtp-Source: AGHT+IE5ZCJikWYBQYNCfYeCZ7i01fPaQ1YL5PYutRrdkWV8ZfElsYhJmfpfgT7H3II/AP9b0v/4mA==
X-Received: by 2002:a17:907:7706:b0:abb:c7d2:3a65 with SMTP id a640c23a62f3a-abeeef64485mr389483966b.39.1740578351780;
        Wed, 26 Feb 2025 05:59:11 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d59391sm335378766b.56.2025.02.26.05.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:59:11 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 26 Feb 2025 15:58:55 +0200
Subject: [PATCH v2 2/2] leds: rgb: leds-qcom-lpg: Fix calculation of best
 period Hi-Res PWMs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-leds-qcom-lpg-fix-max-pwm-on-hi-res-v2-2-7af5ef5d220b@linaro.org>
References: <20250226-leds-qcom-lpg-fix-max-pwm-on-hi-res-v2-0-7af5ef5d220b@linaro.org>
In-Reply-To: <20250226-leds-qcom-lpg-fix-max-pwm-on-hi-res-v2-0-7af5ef5d220b@linaro.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Anjelique Melendez <quic_amelende@quicinc.com>
Cc: Kamal Wadhwa <quic_kamalw@quicinc.com>, 
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=B6vNRR24vZm7iSTdEc4QXuLRyq/IRPqoeXQGjK0c00E=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnvx4qQlcZWrwEMBg5/sca45Aic4oiGh3wo+wat
 QxqpZiktruJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ78eKgAKCRAbX0TJAJUV
 VpcOD/9avCUtmDTMHZbfSFIgp5PcEQzz734ZCCgByqtIk66s8J7P8Ssk5NGSJ2FdPbW1rnKkd9k
 qUdvQBApJpc6D23MzZURiVTANNCrnK6g/VyPHRPHI3LHwBN6pmgPUzaDQe8zPPqOEouXXToFcxm
 bHGP8OaM+isg2DJyL5+KXRCG1LuMOqFVDOBQT1g9TeMdE1QXwWj4uQfUOL73tAhXaYjXRMiButy
 tPMx9Tk8lDmfpKqJJ3T9BXv0NRkLJLsbhRnEzhWqvcpu1Dpa95OkzfduDzMmD9zkpc+9NmMPhyA
 BBBxRHYNuU6xuIEhTjentojQGNJyN6FSvh4QPF/bZX4QG404U+Hp/vfpZEvaT92IcUtx9sWZB/4
 mdvPjal7XDY1u5hW7HD1d9nfLNvv/v9DPyL7MBYDXcv55JeIabLdQM2oaTQ+wg4HPoqWglAJkIq
 bLIAGRbwuEcYFjbbjPYL28XzWKKYtRUpoU3UZdHVWyet8HpOAtf7M7eSPmAHMHXLzmD7jEnqlRp
 b8b6ijyCibnOMivunZWBbFA34qMVdi+a6+jEYN8YuLHIXs4dNQxq9R8tISx39iKxE5PZ5jzpCSn
 yi0XbiH2/NC/yC2MpdR89E111LpqkptQuElxYqIf78UohQyelGaoqXm9LbwMm9fnDj9nZ1CoMnc
 afCK0DsTY7N4UyQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

When determining the actual best period by looping through all
possible PWM configs, the resolution currently used is based on
bit shift value which is off-by-one above the possible maximum
PWM value allowed.

So subtract one from the resolution before determining the best
period so that the maximum duty cycle requested by the PWM user
won't result in a value above the maximum allowed.

Cc: stable@vger.kernel.org    # 6.4
Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high resolution PWM")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 146cd9b447787bf170310321e939022dfb176e9f..5d8e27e2e7ae71c19637b90cc15eb363c53317d9 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -461,7 +461,7 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 		max_res = LPG_RESOLUTION_9BIT;
 	}
 
-	min_period = div64_u64((u64)NSEC_PER_SEC * (1 << pwm_resolution_arr[0]),
+	min_period = div64_u64((u64)NSEC_PER_SEC * ((1 << pwm_resolution_arr[0]) - 1),
 			       clk_rate_arr[clk_len - 1]);
 	if (period <= min_period)
 		return -EINVAL;
@@ -482,7 +482,7 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 	 */
 
 	for (i = 0; i < pwm_resolution_count; i++) {
-		resolution = 1 << pwm_resolution_arr[i];
+		resolution = (1 << pwm_resolution_arr[i]) - 1;
 		for (clk_sel = 1; clk_sel < clk_len; clk_sel++) {
 			u64 numerator = period * clk_rate_arr[clk_sel];
 
@@ -1291,7 +1291,7 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (ret)
 			return ret;
 
-		state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * (1 << resolution) *
+		state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * ((1 << resolution) - 1) *
 						 pre_div * (1 << m), refclk);
 		state->duty_cycle = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * pwm_value * pre_div * (1 << m), refclk);
 	} else {

-- 
2.34.1


