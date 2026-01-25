Return-Path: <stable+bounces-211493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LffC1VQdmk4PQEAu9opvQ
	(envelope-from <stable+bounces-211493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 18:18:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A78081929
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 18:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0053D3001F9D
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 17:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327BD23E340;
	Sun, 25 Jan 2026 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZzVFnCD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12EA2206AC
	for <stable@vger.kernel.org>; Sun, 25 Jan 2026 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769361485; cv=none; b=iRL/kcuxJU9dVKiJTS1aL9bl0d90XL9LXyO99DYDfAK9hMRFUskfZAQA66xbIsiHAwIgdXY/KGzWObJdjf28s2l2dDcf/XNB6U7C3YFX8C9i2r1cP57VRyQpkndcPAfXBesZVNERPCeeGHOoXvZoiw4W7+67Nmc7iz5U7g0K9d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769361485; c=relaxed/simple;
	bh=SoaC+bTBADZsZ6lBW8YnpUI8AOZA6Bnbyobzs3M9ObI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AT8jZLj1BeghjvgGwiZqP6gE6oul1vbcAONwnbLm1XPqEKmm1ukFt8UiTd7TBTG/afTaduDL2sQ5LZAHroQzawRbeWMvq1kgwIhaFKQDK/gc1EQjyPN8+kmbC2hD0K5Li6QQMa7iV/rCXVCi+0tR2z4kzWk3DZxOXuNIbBO4C+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZzVFnCD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a2ea96930cso23430115ad.2
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 09:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769361483; x=1769966283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9H4UePuprwIqygwTYXIxu8X5uuYTZS1QdaUvyOfOkw=;
        b=RZzVFnCDOydk6G/N+EnSGCb0lhH/ldFiFgLgYCZFSN42B0rZKqsKOCGbTEkxPrx98r
         WoCCwYRavF/HYnQ+/qWzhQ5L1KyeqHhHmCGm6EPA0RvbYH7G5oF5pkFN8Es1rJ5JZyxA
         1nluzrj+yfZr2inGwLY0gmVaGoJuftFt0mI8Ngqen20pDQQT6uchQwRd3ZRt1rhUoi5K
         u8DRUQ0XBF4c7+sc/p/d0T8GFzN51m4Kf9uBzf28yAibDaAuhtyVpaNBFMY+ycUA2RTn
         A6E/kDSO9yTvbTklIMmENi6Ssr6TW/4aOK0reNL6kYpHG6R9H3kCMiGkr1IX68Ic37bs
         BL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769361483; x=1769966283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l9H4UePuprwIqygwTYXIxu8X5uuYTZS1QdaUvyOfOkw=;
        b=UiEIrPG5T3EO4RxH+2Z4tH7GQ6LH/vcLQjAdFDO+H6Sy82jeUasbpMDhVpoDItUfmw
         vlw6TAke4svGltLzpzZv81qkqXMWjwQzx4sFZ2p6Qk1Z94nOEDbnmbcY2Iv/oQGTnxms
         tKMZM6wqJ9y7ntvv9w7MSlmGE7MMFowcAnuCH1Mu/KgKNGu0ui5GcKmwv5BE6+86n4mm
         MVHxQBCxOm5BYXv2k4Mk8npJaBwQ6HJBbEHap30CJH53Cj73BtHkHymIzFfBQhFZuW8o
         l4U0jmYOyLR/u80G/DP14EU9rLzwzTWQedQAM9nlkApClXjaOyX23izGjVkdJ0wEuI49
         3Wrg==
X-Forwarded-Encrypted: i=1; AJvYcCW+O3PBW2iGSBrQSIFouW9WsNa99fZPF7kB1y2fXUEHZJZ2GsnhIsVJfFQpIiuzk/jMH+aUyoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzFB+NqmC3C/VH42kCYshIPbI2x1XITyCYNUYfwBmCxRIzUFBH
	HnmE/zmBMi+I/+ki1crPkiZ/Y4b5LjP5CqP5P3YlRtTgEZjZGFYmtqbH
X-Gm-Gg: AZuq6aKU7EWDS0QMGLl3igAIPufeuaJbgQXUb00lgaTFIgfmT7DwxZPN5aI4gSCO2HM
	DUM5rcOtTE2MWI5YvzQYkzWpc/vdh7GU7MzTHgCM+pfOHvuLffySO49DCDT8LIqgoQh1wuoJ5D5
	mX43iUXLCU435RGsdUSE1sgsXcMcEvrz/9DjpPtE5+RH7KvLRa4lxjEh1p72N2RegImMROQe0Ig
	FhILZoVEu8skjqTzYmr8lmR/TtOqjLCy0Y0iiZrHohbmcbaAEaZwCkToau6wJi8c/XKGcR8AZ+X
	mdSu0y5y3lGZmhdMjbJdW4bxksTBIoNG6AxqME1iH1vUOnvp/TYLfEFMcV6Mr4ZVe+b6+V2mzgk
	DkCM6C1Kx7/FxxTEIQ1ri9H+7edcmEXtmu4UreycEy+GrA4wXVM/I7/DAUUyc3leYP54ad4TOzQ
	xbMJE209mclbUtWIkTQ+cDuEpThC2h/2Yaat9i
X-Received: by 2002:a17:902:f541:b0:29f:301a:f6cf with SMTP id d9443c01a7336-2a8452f0c27mr22161865ad.35.1769361482880;
        Sun, 25 Jan 2026 09:18:02 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:35ca:7619:a2ef:5e6c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a3f2e12sm6924293a12.22.2026.01.25.09.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 09:18:02 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: linux-media@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	rfoss@kernel.org,
	todor.too@gmail.com,
	bryan.odonoghue@linaro.org,
	bod@kernel.org,
	vladimir.zapolskiy@linaro.org,
	hansg@kernel.org,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	Saikiran <bjsaikiran@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] media: i2c: ov02c10: Check for errors in disable_streams
Date: Sun, 25 Jan 2026 22:47:45 +0530
Message-ID: <20260125171745.484806-3-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125171745.484806-1-bjsaikiran@gmail.com>
References: <20260125171745.484806-1-bjsaikiran@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linaro.org,linux.intel.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-211493-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1A78081929
X-Rspamd-Action: no action

The ov02c10_disable_streams() function ignores the return value from
cci_write() when stopping the sensor. If the I2C write fails (e.g.,
due to CCI timeout, power management race, or device removal), the
error is silently lost.

While we still need to return 0 and call pm_runtime_put() regardless
of hardware state (to prevent PM reference leaks and pipeline lock
issues), we should at least log when the hardware stop fails.

This change:
1. Captures the cci_write() return value
2. Logs an error if the write fails
3. Still returns 0 to ensure proper cleanup

Returning an error from disable_streams would cause the camss driver's
video_stop_streaming() to exit early without releasing the pipeline
lock, permanently locking the camera.

Fixes: 0e98938b0157 ("media: i2c: add OmniVision OV02C10 sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/media/i2c/ov02c10.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
index b86cae3d2b74..743d8544ac53 100644
--- a/drivers/media/i2c/ov02c10.c
+++ b/drivers/media/i2c/ov02c10.c
@@ -629,8 +629,12 @@ static int ov02c10_disable_streams(struct v4l2_subdev *sd,
 				   u32 pad, u64 streams_mask)
 {
 	struct ov02c10 *ov02c10 = to_ov02c10(sd);
+	int ret;
+
+	ret = cci_write(ov02c10->regmap, OV02C10_REG_STREAM_CONTROL, 0, NULL);
+	if (ret)
+		dev_err(ov02c10->dev, "failed to stop streaming: %d\n", ret);
 
-	cci_write(ov02c10->regmap, OV02C10_REG_STREAM_CONTROL, 0, NULL);
 	pm_runtime_put(ov02c10->dev);
 
 	return 0;
-- 
2.51.0


