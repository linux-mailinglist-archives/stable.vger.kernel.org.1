Return-Path: <stable+bounces-197604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9DCC92816
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 17:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C72534A17B
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13852D23A5;
	Fri, 28 Nov 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVsshIDi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C19288C30
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345962; cv=none; b=OhyZqLrzdT0FTAbnQGH6CDkLXKelR5zGpo8kKPLg+fPPl17YzUudb/FydIhfw89hjKY3oWymUcFrDsD0o+ybiT78rDdcl9gUGFKXE7oIofbOsRWgeQe8yocQiH0kLWofxp2Yrsy9TzPTko6a1MIGcPLC9fuM8VcHPOhwWNYD5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345962; c=relaxed/simple;
	bh=FgQfbLiyDT66S+sNI1wE/oslfO+pvzybNJFnYppNieM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jO/ELSg7cDh9fJ/P/lzKyJ8bCc1ccGD0tSf6UE7GhCuWqOFJDugNjR2Ci3WIbSgQ4T0paq0M32e0wOCMf5le1FXMEjeEiTUG4pMMVPmA5vbYaSutD/9ub0NE6V4FuQOe58yY4QOUuRZKzOS99p82TTLBy9hrr1Ha0YGhlSvBKW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVsshIDi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so2101534b3a.0
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345958; x=1764950758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89KuTptWUmkm9h+FhspeGpsBdyDf36NNXIP8b7hhqek=;
        b=UVsshIDiMTeVetzWcr46lZWBkHx5enSo+AAFgzbi5/pbetdKdEdL2LPflg7bmTqEVO
         npp/7O0T+IPGSzY5kZ6nLE6nAfYVqumDxspQr4yxnoIfPHZAa992pkpNlPGAjYu9COeg
         sTRNThIoaXK8yNO6mJGcGzMm0TT6r0VNwsnlSj0QX+IWgiUGKdPwbee0qGuKaOQ+pATz
         0/Le1ChtWm1VN3eOOKipDtUMm/XWN/4C1FroPL4oNOXgLP4wVDJjGR3TEwbtiFcGgZVo
         pcbVs1G9qid4+LbrxPKzNNG/C7qDgZhMS8K3iPoy2xg9P3LBAmDe4hXWg0r/yVQHVzem
         HNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345958; x=1764950758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=89KuTptWUmkm9h+FhspeGpsBdyDf36NNXIP8b7hhqek=;
        b=XjJVnvRa33MKx6L/2sDjA6+gFoTruA6Ks1P6GlPzCn+2vUBAD0FxznAh8ff+Hglken
         cE5XpXeUqwozGuAwQAcSx6Lz3ZnYjGY8dczk4Ojfjtw5nsw2Da7PTyC3iLdTa6jJERrI
         P98WXOrCGDOtPU9hGhzQu8x2fA8CvQwHeifCSgyuzNIQVLWSHSdWI5nuY87sVlzASfvk
         Bq6TGggXBaS2c9JbhcTZgCpmirKPEsxItqsZKXD0Y6wZ7ZV1jZS9fZvpU5ppD7p/dCBz
         nXLHkHuUf4mbrHxsnzP1+x7xKAU+bKwCq3Bg2xjCOLx52K6a9aYcdy+Kp9/x9M9+7Xwi
         Xu8g==
X-Gm-Message-State: AOJu0YxLQDvbBvIu4oRpRq/hB11Vkw5+9BH9DLjDapFKJZTXTvLwkjP+
	itdtw4CNOQggoo109jCMpGELAQSQoh9hrFGU9TTM1q4lGXRMg3QUd/e9At9H/Y+oP1gLRWId
X-Gm-Gg: ASbGncsYvbuRNIOA4Ak7/VQKDqHBbK765dglAcKF/BrUDxK/DvsKJhfb/n1i9MLhI1q
	qiEpjSZJm78cE6dENolwdku+ou98wneOcN9l34SIVLVrudioqdzayfXiHgdjGQiFnw/BQud03yM
	+aHlVrzFQUhopMhFOfawehIdkTbsdcpjy/kbo/6+Gm6Dz+iwiplItEPuKVRoY4bgfLgbaXVPAs8
	bcBjmlFXGp2lisvwpWa/EfJMXGTvj9m2Yqdh47jLpZTRKQo8rGicZaE5dGAB6oj0eiRAgZ0236/
	5IvRaL9Qy1fhMMiVMt4LOV4SpLjhqJPhje0qeD6kpK6su8q73OR58cCGxSXdENQqeoKF2ueYgRa
	a95N744ZAhrtJD+ElbkAEgyVE3cYamsfXsAqZlOBGgyUAk4ZqkjbyOOd8Osbio3yQcsyfqYsw9o
	om3n1nM8pupuiGOY8U2NFkhWjyYnSEvmN2dvfUJQ==
X-Google-Smtp-Source: AGHT+IF0Q8QvQVgk/GlOhROATsy4H0jZvj77M4n2inngSNShmeeB6QTjv1ds/QlTk5r7jRniqk/a7w==
X-Received: by 2002:a05:6a21:99a5:b0:35d:53dc:cb64 with SMTP id adf61e73a8af0-3614ee0a109mr30924321637.54.1764345957992;
        Fri, 28 Nov 2025 08:05:57 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:05:57 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	Julia.Lawall@inria.fr,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	arnd@arndb.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	maz@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sboyd@kernel.org,
	viresh.kumar@linaro.org,
	aha310510@gmail.com,
	linux-staging@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.15.y 02/14] ARM: spear: Do not use timer namespace for timer_shutdown() function
Date: Sat, 29 Nov 2025 01:05:27 +0900
Message-Id: <20251128160539.358938-3-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128160539.358938-1-aha310510@gmail.com>
References: <20251128160539.358938-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit 80b55772d41d8afec68dbc4ff0368a9fe5d1f390 ]

A new "shutdown" timer state is being added to the generic timer code. One
of the functions to change the timer into the state is called
"timer_shutdown()". This means that there can not be other functions called
"timer_shutdown()" as the timer code owns the "timer_*" name space.

Rename timer_shutdown() to spear_timer_shutdown() to avoid this conflict.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lkml.kernel.org/r/20221106212701.822440504@goodmis.org
Link: https://lore.kernel.org/all/20221105060155.228348078@goodmis.org/
Link: https://lore.kernel.org/r/20221110064146.810953418@goodmis.org
Link: https://lore.kernel.org/r/20221123201624.513863211@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 arch/arm/mach-spear/time.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index e979e2197f8e..5371c824786d 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -90,7 +90,7 @@ static void __init spear_clocksource_init(void)
 		200, 16, clocksource_mmio_readw_up);
 }
 
-static inline void timer_shutdown(struct clock_event_device *evt)
+static inline void spear_timer_shutdown(struct clock_event_device *evt)
 {
 	u16 val = readw(gpt_base + CR(CLKEVT));
 
@@ -101,7 +101,7 @@ static inline void timer_shutdown(struct clock_event_device *evt)
 
 static int spear_shutdown(struct clock_event_device *evt)
 {
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
 
 	return 0;
 }
@@ -111,7 +111,7 @@ static int spear_set_oneshot(struct clock_event_device *evt)
 	u16 val;
 
 	/* stop the timer */
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
 
 	val = readw(gpt_base + CR(CLKEVT));
 	val |= CTRL_ONE_SHOT;
@@ -126,7 +126,7 @@ static int spear_set_periodic(struct clock_event_device *evt)
 	u16 val;
 
 	/* stop the timer */
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
 
 	period = clk_get_rate(gpt_clk) / HZ;
 	period >>= CTRL_PRESCALER16;
--

