Return-Path: <stable+bounces-18820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 351B58497B2
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 11:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E5BB263B4
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 10:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEB0168DA;
	Mon,  5 Feb 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB9xsQxo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECBE17559
	for <stable@vger.kernel.org>; Mon,  5 Feb 2024 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128630; cv=none; b=kaTlchsPWs6vH2Lr0VDUzaYDkdoe9hmorPVNqy5hsZeyHHuCm1ia3Bkm3RREWh0CI5NRmqD+p+fK/VGdW3vy+tgCeB9/xjrCC4fIKdTW7eZPSnBjxcoI5fPFotsFXNU90ZpVzmndu+c73TcilZetpAcC/m4PyzAj3ZAigaWWnZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128630; c=relaxed/simple;
	bh=sq/Qrf0HFbvnzzZSkvn/VEorD3BS2h/vLEufdJf87sI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrQEI3BK+ddMXYn91kmxNKZce4TE757JSZHEx5NLpPg0+fHXERmSqe82OFS2TPFMrLokofD5rm3vHhR2rGkmVYqulvpjQi3JWUNRgssSFXyCGlZL8DcXhtbRCVGs3Rcaki0QpnxYC/ewqkNZIW0BG4rC+rHsCStNldEfiEWlfaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SB9xsQxo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a26fa294e56so583517166b.0
        for <stable@vger.kernel.org>; Mon, 05 Feb 2024 02:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707128627; x=1707733427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XX4Ym3d2uPw+/HY4vPGG7XwZmCRiTXwEgrLOAbWQDn4=;
        b=SB9xsQxoFvPuPlbazSzMLA21q88QeYFv9s3JBTgAzjxfTmxnweT5XOluMmp5gCDtaT
         EPP0OoZ0PRGUqYVQWtP/vRiPrvM5qFXa1AQMV6YWtuC8nJ7n/PfSn4iW5rUpPwYbCnw8
         OByPYNILadjod1HBKORtGAT8DU3szul9b1Pqyj6wZyZhTSG8w1N6Oq6K+rPg3WUjFXOb
         vsD6WTgNxCVytO3wN4oM6YyOMUNNJYaoMHkkjjsvjzfUAiK2+zGMtsvhYhgxkkPQZUTP
         x+8+Em0mBHfDrXxcsEXOjyTT9598W9LwvIAsN64w9MlK0yRkpPyVxLEz8A2rPVcUqlq/
         epyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128627; x=1707733427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XX4Ym3d2uPw+/HY4vPGG7XwZmCRiTXwEgrLOAbWQDn4=;
        b=vMH5Qeg7IDLE/xvixVccJ//vyHUP4JjR6Pj9mBiyf3xINTcBUO2xx8CGTfQuf1wLwF
         l7PnbhUIvl+yvQxT8ZtkasDUnj6MwbM6Ru3LDCyNjumIx8M6G7NXX9N/Z0ii3FI0iTJh
         dvWoQAB0JvIC8xL1/NaTwLLShAw7we/v0acRR7yNEHxr5IwZ4CVeeaTgyTS3KhcTnqTM
         +keuwYhgs7x+jArxX4Z3I4+ikV2NvTe0otYTN+5sCCCRwtqdrh+8mmjGIUHhGi6ox4kG
         WFtUr7pa+98H2dM2SEbTrsGAHGksTdNd3AxtlZk8JAQCddhNC5e0Iu4zy0wyEcsVd66I
         5fqw==
X-Gm-Message-State: AOJu0Yyu+k0XpkAbshCQyiepKtJy56U55HKB2GAxEgUooCyQUF6gsEjZ
	3XMtZ3bXY+HJwscua4B8qWu0ZWUKtMlw2kxJxI5Dk6yxSBNZYXIX
X-Google-Smtp-Source: AGHT+IEhgC7WpQxUeQ7w9jPqIfihBfLgrkJnQPKhaKfxYJQOVq5OuY1YA+3A/JW3juiNLHkOHk1kzw==
X-Received: by 2002:a17:906:194e:b0:a37:e7ee:3ba4 with SMTP id b14-20020a170906194e00b00a37e7ee3ba4mr565762eje.20.1707128627157;
        Mon, 05 Feb 2024 02:23:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUebXMJzoW8NsFszB6JpWkjxUdvAicQboDttoHPbN0WsjspbdhzsPFJda6aPJXWwbl+JhZNTdV/w/IrsNtPLUGzfAlTARSg+7WtavOZFwmBGpol5IIFic+HnPzk/+aZ7oVFts+fnQtR8HIhZ4ulBkUfzkJRpPr/rSazL32pTy2NsbQzjV4IiVTUsEeJ9bdmRNCD7qDQbx0GZUJkZg==
Received: from localhost ([2a02:1210:8690:9300:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id vg11-20020a170907d30b00b00a37669280d1sm2450005ejc.141.2024.02.05.02.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 02:23:46 -0800 (PST)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: soc@kernel.org
Cc: Nikita Shubin <nikita.shubin@maquefel.me>,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: [PATCH] ARM: ep93xx: Add terminator to gpiod_lookup_table
Date: Mon,  5 Feb 2024 11:23:34 +0100
Message-ID: <20240205102337.439002-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikita Shubin <nikita.shubin@maquefel.me>

Without the terminator, if a con_id is passed to gpio_find() that
does not exist in the lookup table the function will not stop looping
correctly, and eventually cause an oops.

Cc: stable@vger.kernel.org
Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/arm/mach-ep93xx/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 71b113976420..8b1ec60a9a46 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -339,6 +339,7 @@ static struct gpiod_lookup_table ep93xx_i2c_gpiod_table = {
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("G", 0, NULL, 1,
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		{ }
 	},
 };
 
-- 
2.42.0


