Return-Path: <stable+bounces-184012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82384BCDB50
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 17:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46325436DC
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C408A2F9DAE;
	Fri, 10 Oct 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su+5/5Ih"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A842F9C37
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108601; cv=none; b=eoOTq193/V1xgpbyaujnIGaloZqbWWdsfl+2dgY+g5NLqiOv6eP09m05Z2mCXuXp1wqiEFOR426QryOK/dTkmw9knK+r4kqXnEtVWMaTyA7qTFt+yx2GLezsV5b45csmkuJkL612psYaaPqYuN17t7NUgk321LR7LCbPzGB6/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108601; c=relaxed/simple;
	bh=kyxULOv2H236l1ucHIwcTRr5nnWT32c4Zye+wWGrJ6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qmE8SHFQT+AgMdxliljenDC/jVSOoP3W0SLCH08vU74HmLqfRDkceYnqaiUwb4Wbtbwf5AsusV1+zoXs3bMWNirqbrxQpS2nLY+b6vj5qAdCQKQ1SRPiTI5D4Y60/iqA5NA6kH7fhRud/9jGlBT5PLVazv46AyP+IlGeHwNBsWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su+5/5Ih; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7841da939deso1994507b3a.2
        for <stable@vger.kernel.org>; Fri, 10 Oct 2025 08:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108599; x=1760713399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scjH6AQBXgOEyOguxVYTHq5LOFFjJgFpmI1fsS6Z7tY=;
        b=Su+5/5IhGDJljNWqvdLuLQXyqkbWvf2cbmnmjD7zjzywNoFV80FhOQIm/b1p1OfZBO
         vk35gqHf8PUvH/ZZZHgIP2CqeRLDHJsFqgGadCIn/QPG9BdjsEyUeONZUs5FXCQVI7RC
         RG25CKozBZaN7DTNR3oeC9qh2I1a9rbdjMu7EXSaSX7/uUvdAaEcqJBsqS3cTqqrUOu1
         6U02NccwfSNp51o9E7nod/5yynsZc2sWPPERn1Vdb5j+zTCejT4bOhSggOC7uprHxnxZ
         v7ZZwhwP9IXbF2Ijr+rUpD+wAcq1rD+2wN9oHLUK/ZsYoo6T9wHP1XBuaxfpPIS5m9Rc
         20Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108599; x=1760713399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scjH6AQBXgOEyOguxVYTHq5LOFFjJgFpmI1fsS6Z7tY=;
        b=DF1RgttcWGntSv6bhZR1CvIgbnbXeXsZEPXtE5GYIWlxR+EYk2qRwXAk33NNgqZomf
         mWWVyMG4zQpdBMqBM1E1UJBYi5aWvjSgbtqX9MhLKOxPyFXA5wsFuCxRVHqwLNyxqyaC
         luKsi2Z6l92EPyVCJSTC5QMQpOLzO6eoVQI9IukTWHKrbNqiS4fAX3qrollCvKvDykEq
         pTJ62yEg/WdF7g0r3QL94ivc/VpCRZ9poJQKXrsOAnK8ttmkjCo2zDbpZI710OcaLhpw
         VQLZ9vzLitPb/eyeeqUO7NryXE0rRCvKBuvXpT9FUpjr2RFBmJyU7tRsjibNFEKoe638
         Tkmg==
X-Gm-Message-State: AOJu0YzfAbVVVydLXF7FZ24xs/lmhkhWppm/UUG37saSn9q4zJj8GJ55
	UXucx0CxRpywlusdUG0AFf+hGAWjjtBIJzFRD+DO+mNZ/QgujT5E+DLLC6I/W69KpQazvQ==
X-Gm-Gg: ASbGncs7ruuJ/e4rjwm5fmJvoeJfsaFqZdyM2BhDkgtmHGotgwP1CoYk5CxU2Itb3VE
	FqjzryLG2PjTQDpMoJ2CyDPaQqTKCuktWLYe5uLfvmAwTSt179xw9Z9rxIiLb+Kxak7oqC3tmbJ
	/+2RWvuLiVazSWA5aMyhVN22/gLrmKe6Wj8bgPSlokgrhnN3LwfXbcQozmxW795xlRQdjlvItFZ
	yB7IdKivAQbHan7mikQGC+uaYxFx4hOJZhttDOYNMpnIzRWQj7Qx1+7FYOobizqrLZNl0A9wu+e
	uj+XqIslUBVJeqKTKoTu3hMcZZffeqhnUVV9HRTdp0poJezrdpe1tl/66ax5MOE9um33OetaAFE
	8YQObnjtRT7yZKtsdcY+mIqLo37hcT58irnXlnnClO5I5vWMZDVrxiaXG+9XjfhadTNuW
X-Google-Smtp-Source: AGHT+IE1TkwVHA7tUUhpnxMC0Ew+qral7pJWbGGXX+m1f8imGiLvrl15HPVZo6jvgfFxLbQ7GCafnA==
X-Received: by 2002:a05:6a20:7d8a:b0:2fb:62bb:dec with SMTP id adf61e73a8af0-32da83db679mr15075982637.39.1760108598855;
        Fri, 10 Oct 2025 08:03:18 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:03:18 -0700 (PDT)
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.1.y 04/12] clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function
Date: Sat, 11 Oct 2025 00:02:44 +0900
Message-Id: <20251010150252.1115788-5-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010150252.1115788-1-aha310510@gmail.com>
References: <20251010150252.1115788-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit 6e1fc2591f116dfb20b65cf27356475461d61bd8 ]

A new "shutdown" timer state is being added to the generic timer code. One
of the functions to change the timer into the state is called
"timer_shutdown()". This means that there can not be other functions
called "timer_shutdown()" as the timer code owns the "timer_*" name space.

Rename timer_shutdown() to evt_timer_shutdown() to avoid this conflict.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lkml.kernel.org/r/20221106212702.182883323@goodmis.org
Link: https://lore.kernel.org/all/20221105060155.592778858@goodmis.org/
Link: https://lore.kernel.org/r/20221110064147.158230501@goodmis.org
Link: https://lore.kernel.org/r/20221123201624.634354813@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/clocksource/timer-sp804.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index e6a87f4af2b5..cd1916c05325 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -155,14 +155,14 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static inline void timer_shutdown(struct clock_event_device *evt)
+static inline void evt_timer_shutdown(struct clock_event_device *evt)
 {
 	writel(0, common_clkevt->ctrl);
 }
 
 static int sp804_shutdown(struct clock_event_device *evt)
 {
-	timer_shutdown(evt);
+	evt_timer_shutdown(evt);
 	return 0;
 }
 
@@ -171,7 +171,7 @@ static int sp804_set_periodic(struct clock_event_device *evt)
 	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
 			     TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
 
-	timer_shutdown(evt);
+	evt_timer_shutdown(evt);
 	writel(common_clkevt->reload, common_clkevt->load);
 	writel(ctrl, common_clkevt->ctrl);
 	return 0;
--

