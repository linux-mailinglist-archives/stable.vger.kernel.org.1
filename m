Return-Path: <stable+bounces-178809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B249B480B9
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 00:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A5D189D7C2
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FCA29BDB3;
	Sun,  7 Sep 2025 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXmtgKri"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382A28C84D;
	Sun,  7 Sep 2025 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757282798; cv=none; b=gXwkEgHySOvI/M+KSaNWZCjSwWin/lV50vqlyuUNdVjJ5YKsux7EnZZosJjm7SUuh7ClOZbrW+KOS0QLT0Baty1pL0ZiOSE0GijA/0QS3HFZGJC7NA8Xt4Nt/XbNRHMjWN4fRxyfi3qrfb72EnDBynZpQed1vt+6sOywJKRbofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757282798; c=relaxed/simple;
	bh=uc+iGOI3vMytLhnfiWMAxd++CsALy4iVltWPtaEMLj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qQmYCrPuvnQUU9ziThhE7wnI+7cOYaaDrUVVlayoPoKJOg2wkmKt+1ntEt/Mod2Do1HBzi6KoO1dZz1lEBXOxaqL4kGCaRSolOwzJdP3h5ELcF9e3HHQXnbWL8xLOoTUHEuOO6Yj0iDLmEGvvyRHLLvqC3oc7iObXNxrphquS0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXmtgKri; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-544acb1f41dso1668746e0c.2;
        Sun, 07 Sep 2025 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757282796; x=1757887596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixfFvmhL1239ziDAjIicFKxrzPCQKO+lA677Kys/xGc=;
        b=UXmtgKri8bHG9t+yGVpes8BjKvuDRjX4xDqdZjuB+E67o4e86GCI42+x0Cs/E9qPdL
         +gFqDQeSrM+kG71ibChzRH88EQoHQt7fy/HY8VTY7pPbOQEHugNLPV4pLruH7P0xYx+3
         okXuifjrnysDAf00OpTXlImkms+pof0ro+RWi41vMALVmKpGlIbeh3vmDRvJmPnrPK7l
         Dt4B9QYDWVsfKz/eKgrQ6Y0h0WvnFcMuCgBB9IbL7X62MeJF3c4nWnxk7tgFHBatf1L6
         5vUa1IuPZKmj9QRFTi7VkRav7mWrlQU+bQ5ftwt0LlvWw1ZmX43X2cN0J8QxxgtdFdYi
         zyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757282796; x=1757887596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixfFvmhL1239ziDAjIicFKxrzPCQKO+lA677Kys/xGc=;
        b=g8rnEhvi9Fp9wIMDmwJFXhxl+lbqhKbdElHGT5Zf8qh5pviTe6YuJTFwjodpQ/3acJ
         7bllhHLkFplyOzIEkbTj5SQ4Q7UI3K6i4cwvNNWlwfuoPNZNptt+TbT395iCdX+1vfJP
         B3P0bvN76AeSHxghELy/FgrduqQpTZwBzsW5C9g+/56VQ2vSeq0Z+t0pnbS+VCkk0yPq
         JXltn4GdJAWNbD7ykj7i2bGHgn9aQJsvqQbYLgyQwpxOBw86xV65CS4+f5vetx+wk9SK
         pQ7Y4mEwx6GRGi7/k9HSvwYnc2YPw9hcgfGlfBsbnXrxQ+pjolFRiTUWhzxjRZYRkaFD
         nUTg==
X-Forwarded-Encrypted: i=1; AJvYcCUzRLmhJbgrTy0pXoorfaumR3lLzk83mpfQj/P4BwBuBgHe2qa0MAgwSgHuOv3RlofELLR8LclIij7A@vger.kernel.org, AJvYcCWoUSuU9Jjh63PxyNQYMhUwOv5UA/PnU4DbRyfYRTgQZoK9C+eeYWO2aujDyEsiw7NhESomch5SuO3wBg4=@vger.kernel.org, AJvYcCXmyoNtTv7yJ/Mgz0+eZc8w5EU71vYt1SsSV68r9dcIILt/US735hdjDhTW6ttISKBfyXRBYyoTakdi@vger.kernel.org, AJvYcCXnTTTcZm/ay7zPrQnt7zWmewAmSIa3BuyQlziVJB5iEpg49b12ahxiXI2Q+c5QP5coLJaA91pn9CYc1cNU@vger.kernel.org
X-Gm-Message-State: AOJu0YysNNj6LltGLp4CLqA/iaG9dZWrg01Q1/feiBzKbApzCbGOsX+G
	T80A9zse6Lxl9pJ3qFFileJCnvdruzuxoU+/x3gIGnFVlJxEDYOc6pt3
X-Gm-Gg: ASbGncucxaB+eEVbTTxhJRTpd0Hg70wvJg9VhLQhCsN82IKYm5z2yYPQPHVRk9J2exH
	1mMvGkUBGrVsDnJa0kB/9cZvPCJ/q4PuHFwcz+YDpXoqq7nasmRNjX9xHmugI2ISXicU6s0lBzB
	EZ71gzP3XVGWVpfPTBSjxESLFWrEOtKbfihHL9CpY1rpPAaDwgcWciE5l8b3so+gonOHaEj8+fq
	nKx40juCjA9ijc8+OSX8wJHoIKAq3Z+BK89vSQDOh1TutFq5VBWLIeD2M74vOHb2VvmQTT1Vqrw
	iGHWkZ8+vgAoLrmxTL3EIO3qtVtHUTQiEfaUZ/PWVoV0PvwRA2/ftCIWMgdCnR88GzpGRk/R0Zr
	LskDyWBCK8882FK7zJiw5UKY2
X-Google-Smtp-Source: AGHT+IF8MYnSRNwyp4uk7wBZAaSI68by/HNoVmBY+EkDThQeJwtMVD3/6jNLJaovDwK2SvoRA/NJWA==
X-Received: by 2002:a05:6122:829c:b0:531:19f4:ec19 with SMTP id 71dfb90a1353d-5473c5c98admr1427292e0c.9.1757282795709;
        Sun, 07 Sep 2025 15:06:35 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5449ed5a91esm10397004e0c.20.2025.09.07.15.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 15:06:35 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 07 Sep 2025 17:06:16 -0500
Subject: [PATCH 2/3] hwmon: (sht21) Add devicetree support
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-sht2x-v1-2-fd56843b1b43@gmail.com>
References: <20250907-sht2x-v1-0-fd56843b1b43@gmail.com>
In-Reply-To: <20250907-sht2x-v1-0-fd56843b1b43@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: stable@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=878; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=uc+iGOI3vMytLhnfiWMAxd++CsALy4iVltWPtaEMLj8=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7GJ8GzFB2+33Q+bXS8/vB+4vX+Gh9qT54/YCCwaXEY
 zH+Il+yOkpZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAi86Yx/FOcl7Hh66uVWcsL
 Z63sLShvX1B1k9n29vf6l11rYyKFX9kyMuw/+fvhgyMTXh1a+FwzycmvpHX9zptbxT576TR8iG9
 bN48TAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add DT support for sht2x chips.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/hwmon/sht21.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
index a2748659edc262dac9d87771f849a4fc0a29d981..9813e04f60430f8e60f614d9c68785428978c4a4 100644
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -283,8 +283,16 @@ static const struct i2c_device_id sht21_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, sht21_id);
 
+static const struct of_device_id sht21_of_match[] = {
+	{ .compatible = "sensirion,sht2x" },
+	{ }
+};
+
 static struct i2c_driver sht21_driver = {
-	.driver.name = "sht21",
+	.driver = {
+		.name = "sht21",
+		.of_match_table = sht21_of_match,
+	},
 	.probe       = sht21_probe,
 	.id_table    = sht21_id,
 };

-- 
2.51.0


