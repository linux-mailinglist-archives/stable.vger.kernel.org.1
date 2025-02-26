Return-Path: <stable+bounces-119676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA3FA46184
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 14:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB81A188C011
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 13:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE084221704;
	Wed, 26 Feb 2025 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9uykdne"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D0E221543
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578355; cv=none; b=ft60s5q4hu41gcBwmDkUbsYcPAEGiMnS5pp/dPGlLJU64svUl0gF/s7kQLqGkUoWORVBRn50e98g/6tWU7OrwzWt6LwC4hgt68RD5i3PWu4YmGDgdwZuiootuVuunlUWUN33miU5nsWgRxS0oAvE9HUsnfJYEBS8GK1lp7rIXhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578355; c=relaxed/simple;
	bh=XYRfpTjP9qW9moSWCxxYfrR+hnJkds8ER5//VmmAb7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XpzOX8t9Md+nwaKzMkgS7NchCiti7S7+uk5IFdXyEvLGR4KSjGoXFScZiX047T14VKyeuqYzgz2TmIxRqg4YLRvpLrE6tdKK823DZgkqf2sduLfRBmq1fF8XcGWoEM/xC9ldfXtz3fvkkSRU6X9DkjyEesuNsfaAOW3RduI0m74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y9uykdne; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb7f539c35so1321519566b.1
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 05:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740578352; x=1741183152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJer/KBt7SDqr/LxaHmlrgDfxoYGiPXLElseSBTXWLs=;
        b=y9uykdne47Vq34AJJ+nfp2BH2HX2vAs2gxh5LGjdNJkBf1ztNqKl+TZGOzxfxJ+A+F
         wNqH4pMaVPqB2510AuWiEdtWsX+4geKmZ1x5pZDwdk21wgs7Dqe8p2OhqaDB/Z5ndhzp
         vy1mQTKb1YfEXXQwbBWleww099TDf3iyUiDaChbPKAg7xJreP82rE2hpWdd42UzX2VpO
         inRoMDeyKeDflyAxTYtTOxGYWMRGyzLsUyuo/A1+fyzMWzaliB1OeL2YmyngLxSIstSF
         2m8CchQpqv7Uw6WuILWSVkeyaiSus69Ff0I2ox/lfCw/bgUhGDi8/Fkqs2u+Gmvwj4br
         WhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740578352; x=1741183152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJer/KBt7SDqr/LxaHmlrgDfxoYGiPXLElseSBTXWLs=;
        b=Iq78co0iVnh7dxn3iVf/5k9oTcQ74SkXF4iiTYZO4axms8Ycsb7WzQWI9P2rY3bZ9h
         OlKR8RDsFXD5z+Dnrz4YihekoFHeWBb76I0bmcIwwva3YB9JtWWaM2DW4YKmbR+FYFxe
         Mlsg8H3yiv+n4KhOtis8UcHN5KTI/FIxDUw098hFGY14BgK0VDbF9wDfqS6CJ32ZJEoe
         w5d/0/8Qr0UBUnaat5VrIMTSMZOjfXvSebZHg+kv/AwEcdlW2eRr7pBUn7mgc3wUoL1W
         fD2D9bishCPTUxo3+3wLbq4P2IDZIJiDpN2AVOB+cMXOhvplAeyfQ7YA/kt78V8LhR9V
         vZUw==
X-Forwarded-Encrypted: i=1; AJvYcCU6J4UiJJQd6Y870NJbfpIwZbQn54l/La114d0fqz+j/7jLWbX+2xvTIJ7D9aoSDFhjLQXTxbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykxcKRX7IcuTc0HRj3MNZjxeCCjeKhysk4Z5ja3UaExglSvSTM
	lgRca3TcJZhZApvpvDNbjR7pGjcq/G5gekvWzYvfspdXq/2bCN0JpC/Kc/NzWjg=
X-Gm-Gg: ASbGnctuVQBKR2MMMD9DhWe3Mc9xZvHEAhhC5g7khcAbKkDkYLw4M1U9Y27DKWQ8v6b
	5ph5+iPcG9Zr+9E1Dikz9lRW82305B94BNzObyJ4svcO393YNVyYEUQTzeXW7K3wpRzr+Hv1iwx
	zLDS8TklmfjpC0iyibpTg2ohv7jJ4JiR7tFithH0jeqz8aB/SinQ7S3tYcdxSakK74+MqvZWLAb
	5psp4F/JsMBYv4PX6ben4L9IDKX/rNiXG2sD68cPrxPgV1+a91e4s+WcPxs3s8eZkk3TSpk5c5d
	OMGnJ+f+XUcSLeZLCMe/jE/j
X-Google-Smtp-Source: AGHT+IFQ0RYtUdet2mfByZW8v1Tgu/DzOE5jK5heIX6l9OiqSL8gXpox0Omb5YSgBd21e6oHoQtBow==
X-Received: by 2002:a17:907:1ca4:b0:ab6:d575:9540 with SMTP id a640c23a62f3a-abed1076c86mr934130366b.50.1740578350230;
        Wed, 26 Feb 2025 05:59:10 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d59391sm335378766b.56.2025.02.26.05.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:59:09 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 26 Feb 2025 15:58:54 +0200
Subject: [PATCH v2 1/2] leds: rgb: leds-qcom-lpg: Fix pwm resolution max
 for Hi-Res PWMs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-leds-qcom-lpg-fix-max-pwm-on-hi-res-v2-1-7af5ef5d220b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1674; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=XYRfpTjP9qW9moSWCxxYfrR+hnJkds8ER5//VmmAb7E=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnvx4oO2+aiOnRV48CWCNrMcM3UwN/AvNbfSnSI
 SdlHZOzZwmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ78eKAAKCRAbX0TJAJUV
 VpeNEACp3RRwESa0LKp5fHhA1psTMkZcIR1AsQa5/rcN5lgabpDB2eRjmN1V66CeQtMZT82rY76
 Blf7KTt1sl/gF1o9DTjTTsk7rs5jajzjazNNMmRVT8gN1znTP20+3ELGCadjJER5+S3XSNtG0IS
 0zsLg1UUcijYfi4hhDY+w4VJ8tSoGHkyaS+RdyMEmIwnN/5utYTByGyO3veQ8IvOVgaHtk82rnr
 k2aNCaNKwHBh9KKTWEDNTvdwZxzL4nhsh1Y/huDiwJhsi/cnSYlCAhjTr3P25rL+m2d9IoF4OeM
 TCH6DrVadrzAbEivcbJTWyHB6tJ0cKVOJiI+7cfLAKvAJhJoYWaqb1ml+fSeQemTuYuNZfJUJEC
 lZN73Mz6iXneLFthncCmXLnMUlXdVBsdv96CQmV2mFeCMvL2DXEW4RyZr9nGMs1JXSO0qhuUPix
 TGgmvM1OrnjiDHbrjUhORYVlqxxAUjYYY/U3PujFEhqnfKX7sGFmsyfd3VRsusmNYdKdzs7lqcZ
 shaeTPDgtEzl1YIKbdvnsnzjLFsFM7AecNY/97rg3lPU2vD+87AINHWDUkbeWnJnc5BHvpL9Idn
 XXco0Zs0/vPVqIi/PRJKqEnE8tMWU8xyE4w62pbzJlJwzMAuaWDrGs747eI+MGWbZzzGoHW+JEK
 8kIXhWqWf0/yl1Q==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Ideally, the requested duty cycle should never translate to a PWM
value higher than the selected resolution (PWM size), but currently the
best matched period is never reported back to the PWM consumer, so the
consumer will still be using the requested period which is higher than
the best matched one. This will result in PWM consumer requesting
duty cycle values higher than the allowed PWM value.

Currently, the consumer driver known to fail this way is the PWM backlight
(pwm_bl) and should be reworked in such a way that the best matched period
is used instead.

As for the current implementation of the duty cycle calculation, it is
capping the max value, fix that by using the resolution to figure out the
maximum allowed PWM value.

Cc: stable@vger.kernel.org    # 6.4
Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high resolution PWM")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index f3c9ef2bfa572f9ee86c8b8aa37deb8231965490..146cd9b447787bf170310321e939022dfb176e9f 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -529,7 +529,7 @@ static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty)
 	unsigned int clk_rate;
 
 	if (chan->subtype == LPG_SUBTYPE_HI_RES_PWM) {
-		max = LPG_RESOLUTION_15BIT - 1;
+		max = BIT(lpg_pwm_resolution_hi_res[chan->pwm_resolution_sel]) - 1;
 		clk_rate = lpg_clk_rates_hi_res[chan->clk_sel];
 	} else {
 		max = LPG_RESOLUTION_9BIT - 1;

-- 
2.34.1


