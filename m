Return-Path: <stable+bounces-184010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E19BCDAF0
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 17:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68B10350946
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613672F6192;
	Fri, 10 Oct 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpWrckV/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981832F60CD
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108592; cv=none; b=JrretvbE6JSQieKuNAlm/Q7HC7oeay1rqMKO8L1hglGqO2kv7iCeFd6Xa97hIcMCu32isVc4UFlIp3hFXJPNNTBTxQSS/pxHNIJpldjned+KgVLOvhkbQ8FLyL4ft/iLknGlH/zAwOOiB45hCSfpHVohMOp60R+TJ45YvZ9h0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108592; c=relaxed/simple;
	bh=FgQfbLiyDT66S+sNI1wE/oslfO+pvzybNJFnYppNieM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bBP6WhxDhKG1GHLaEAIG/TbsDpe2eqtQ8qp9IPUKig5tMWeUFzWB+s8jjz6pvgYXNnKZ3fX4M9MRMlwjCnAU+hAu/WjRizTIka7QJYeUphiX6b+xSl1v/e1qcChN5Y8dCB0y0ykWbIDHVWf9JyngLNQvJjrPlwHDQ7aDGn9/PfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpWrckV/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781db5068b8so1854907b3a.0
        for <stable@vger.kernel.org>; Fri, 10 Oct 2025 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108589; x=1760713389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89KuTptWUmkm9h+FhspeGpsBdyDf36NNXIP8b7hhqek=;
        b=RpWrckV/JP7K3rBXqLxBCPZ3r+/KHE+Zva9B+hQ/IpZyvb9ML8WbUa8q/esCb2fb4y
         ymlmTU0QbOJlDRiqXD0JpKBUcDmkrAJ9upSO9ZF6NWWmhx3PrAPRz0Ah3/fsPaoVHi59
         NK6Pizz6h/bi7LjWTOMf1lSdl/txsUs5vF0zKcEM0JFe2qYLg/eM5lPyM7TZFNMRHhe+
         A+cwnS4gZ7o7opxLNINSNzjGJlHOxnFUG4cFW/LnEKqvGqV4dfjCSNYhg3zHCJv6ktl1
         l1Dnju47/ug9Zv7TrKZ/cv9mld/mHDw562LCLoXgSN7COm4MzXa90Ye+NiSn/XGoHy/k
         ok/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108589; x=1760713389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89KuTptWUmkm9h+FhspeGpsBdyDf36NNXIP8b7hhqek=;
        b=cJ/ph67LckE65k36j4TgP7NTmC0h8HYvrPud/H9M2jKvnUHRnFltaSascX7zmkgK3s
         H146MWfmtDIn1NuJzoNP6taShwAW4cQVW/VUH0FPdWm1Fsuqdixo4lXq34KHtUIyvIGD
         +TwSJPBIQJfqlwE6wXLslUClF9xbfJf0Uw9uBSAH9Z/tfcKSEdRmjY6woCfGZjH91PcX
         gq2oRUSxT4SUvreZEXyBL9j4iHiBXauEUshigpIIlaLj7sIQhn/uaSk576l5szFYu+4n
         vvjlHlcpZAIyUVNIQ076fJQU5KlBsx1YdJjB946CUXj9CXZG3RZBBKoxiltnEzalGtLB
         9j2w==
X-Gm-Message-State: AOJu0YwiCoJpneAHdV1mqyoi9bTiTkvm6Zr7nnthm8QLyZJDpx197Zul
	IaH5QCb2oYqbZ5bVQ2xMKCr4P2QcYoVLp2HWfQQct6dbyf7hZtcNM4qjsP4JukD/Z2PoqQ==
X-Gm-Gg: ASbGncshQps1u0DUX8x+x9q0BFyu6X1jB4It6BFCr5wdpHLNrKtravBtDVrBWlI21/l
	1txHyW2gCg3lv0WzKd93xbxeLK+Zm6CDApAcKoCYr1wkZzg3LqKRz35y+eJ7ORazOzt9tM28vDP
	aH80f0FyqLSFnMixTX0DECaPtQ0LpkM2ToBfYn8B4m8GRSkikE+MTQpNnd+QUXv21JBEWrfk7Tf
	g8Wy+gekBSIopuKdt5NzVAmn9Shaj7xLCjYoivUlqtlYizt3htokAPh91CnY20a3bKY8sxUUjHy
	rgGogu7UkcKgY71fmuP1IbUR31TjbgZ0HGy4WYDOqFMvWCHXZ7uKTfEWl5jyMebDHWyQts+RG+P
	okU1GXHepICujzx0RPuKJ9P6zf0J4ExkKeKjqE5NPa/kiq//jO9ebCjunyDDGTsOorAgtIfge2d
	W9oMU=
X-Google-Smtp-Source: AGHT+IGEQqV4pmO4XmsOQ15F9bsuz1pxj5V/e0Gc4K06vCx6p2KIreXiVTGYqdNwaxkJG480WOWOvA==
X-Received: by 2002:a05:6a21:50f:b0:32d:a8fd:396c with SMTP id adf61e73a8af0-32da8fd3980mr15459388637.35.1760108589350;
        Fri, 10 Oct 2025 08:03:09 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:03:09 -0700 (PDT)
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
Subject: [PATCH 6.1.y 02/12] ARM: spear: Do not use timer namespace for timer_shutdown() function
Date: Sat, 11 Oct 2025 00:02:42 +0900
Message-Id: <20251010150252.1115788-3-aha310510@gmail.com>
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

