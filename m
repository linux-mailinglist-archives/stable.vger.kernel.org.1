Return-Path: <stable+bounces-197605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5577C92822
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 17:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C78734F76B
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7472D7DF9;
	Fri, 28 Nov 2025 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSVWatJd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55AB2949E0
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345968; cv=none; b=hM4yZy3Mypw1QLz2DUQaVYHjahmfgCiq4t4ynTjf1wNNDoHWn3sWYs1x5Daz2H0ynw248jiwBIu6RNb5b+SsIvbbnZvjUwNK6F3lBYnkCl5baC7Z0mBtw/UXlw9cNOPEnOHCTN0DjtM905KHnL29k5aB+K+xLooi2As9q3YJF00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345968; c=relaxed/simple;
	bh=YY7i+ekw8WEClpFqVZfbZbIPcOFXG9mqoVtYSHhdgrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ULEOu6Bd+D9WAIU2X7Nn3pggsZL8bg4f+BQGjlZbYfZdG7NkHTHoP1OU6nJNgXg1K9AJxtmQWmBnR4qRg+CbX19Y++rW2zciOUn0ujQZ1nm8ePYSKho0vFKdJ/4eXjyOq/d6C80OnmjRVcQHri+vJ3vyR6bN69GZvgCpga4BFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSVWatJd; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aad4823079so1794639b3a.0
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345964; x=1764950764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lru4V+cwKFfxLK/nzfZUd/f7wkQ+5dEE9KWoaatQVPo=;
        b=QSVWatJdQOzmUezAOc32ZH0M3/HAPWABCph9Uu2t2OE8NaVxreBhIAdD9FWj1TomRy
         BOErNd5sD5m4b549B7NOOR6yueHQ1atWchkQ1P6u9nmD607PTEctMYr/1Llp4n+HEbn5
         1UdFcap54P7mVQbCdvwyg/kznLTItf/9YnG6Q1QzoaDN4fJwQF2Rr8iD1crFQTjjZXzR
         xPWDARJI7hixToZN0fiFAo+4J55QPok+oguDdDZS/jJrenHTnwwhHxMOjwD4Ese/RBDd
         rvwDPKREk5KoAvvGmkuVEN3/98MEPaQ51U61otD9lVnOMTKu5fTFYmRd/XmzXuHydszP
         WL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345964; x=1764950764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lru4V+cwKFfxLK/nzfZUd/f7wkQ+5dEE9KWoaatQVPo=;
        b=QQWP5Lb3NeoZcQ+Jq21X9tXn+IRDla4LDdESq2m6Hz/hTu3heKyNzt1BrDdNgnbQr3
         tzaPrZMO2o/k1Tq19hzjYc1pSUeFVnNPWV3mdUj2P+bgXNUwQ8HDYYS8fqSKS6NDF7kp
         FfiSC0C43hRhuScMWLjOEAd82GjMc5JhBeHwGtaibUu6HY0/udsdaKmv2TKdu4NAXaU4
         xecaPVQ4Aelf5KwvTmEs1Dga7PHS9sSoIj6PuiodZScRLTzgEoz0e9mrvOjEVEhhE+Ys
         Z65CnCQ5tdWM/CsuhSukZuDqMIUuZyMF82a7a0m+kCGFRZ3RWG0DnkmbgopurKmyPVe5
         RpWQ==
X-Gm-Message-State: AOJu0YyWr72JvTpETCzL0sKvdacBV4jtKcaEHXljeGh6ZPsF4xYLoxzv
	ZktEgfYq4jOUOIznpc15y+Qo1wL1bPwcWxVXWulKtBxeSDwp4zDJSa6B1SANL4RN42Idsfg0
X-Gm-Gg: ASbGnculv6y2ASwyf/VAyr16QNIrERwWUGjaKdtJGn1ZBpBhQ1/2T9tbzcYW1pAn9v/
	PyCY87SdmAmQK26SGD1Kau+KE1CeJ9BVf9DlFa6i9QW2h5NZKcHXb7/Est9q/1FAoAmLJ7Y6F+J
	fjD/+iNLLwLhJdPvEQjHgSfNULiOgPDPyVyGt+aScEercMRaoTaTmNlxrgMyzM1ginbUJxeICh0
	O1gTFnrjk7JAnoef3Zjm2mJ6W7XP1mcWaojcBN6rKdVzIxJ1LQCvNowznE3C9MY0M/R8cyNDtiG
	WkgjKPW4Ra6cH16wmZtjX+geK+Tva1UN5e8EJkaPGzl0KTvyj5znWQLDjNOX9JreiH3s7Exi1k7
	d3eIjyprLdiMGQkAQ/q7d5iB8ND8fKBvdFnRdan2ABBY2hsti8NjYRQKtRabVJGUUEr0WQVS8ND
	SnUcLZvRuRr2CQcaAoFevT8Ro4AvXFvvGd1w+YcQ==
X-Google-Smtp-Source: AGHT+IExmbTt0di4gnbgeXwjl0MdJHHrgB9GIijfMB5lD+egrT6JfkOALPfqqLh5IPKK0ig7n/DpYw==
X-Received: by 2002:a05:6a00:1383:b0:7b9:7349:4f0f with SMTP id d2e1a72fcca58-7c58988f7camr27966972b3a.0.1764345963342;
        Fri, 28 Nov 2025 08:06:03 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:06:02 -0800 (PST)
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
Subject: [PATCH 5.15.y 03/14] clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function
Date: Sat, 29 Nov 2025 01:05:28 +0900
Message-Id: <20251128160539.358938-4-aha310510@gmail.com>
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

[ Upstream commit 73737a5833ace25a8408b0d3b783637cb6bf29d1 ]

A new "shutdown" timer state is being added to the generic timer code. One
of the functions to change the timer into the state is called
"timer_shutdown()". This means that there can not be other functions
called "timer_shutdown()" as the timer code owns the "timer_*" name space.

Rename timer_shutdown() to arch_timer_shutdown() to avoid this conflict.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lkml.kernel.org/r/20221106212702.002251651@goodmis.org
Link: https://lore.kernel.org/all/20221105060155.409832154@goodmis.org/
Link: https://lore.kernel.org/r/20221110064146.981725531@goodmis.org
Link: https://lore.kernel.org/r/20221123201624.574672568@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/clocksource/arm_arch_timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index fee1c4bf1021..ddcbf2b19651 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -687,8 +687,8 @@ static irqreturn_t arch_timer_handler_virt_mem(int irq, void *dev_id)
 	return timer_handler(ARCH_TIMER_MEM_VIRT_ACCESS, evt);
 }
 
-static __always_inline int timer_shutdown(const int access,
-					  struct clock_event_device *clk)
+static __always_inline int arch_timer_shutdown(const int access,
+					       struct clock_event_device *clk)
 {
 	unsigned long ctrl;
 
@@ -701,22 +701,22 @@ static __always_inline int timer_shutdown(const int access,
 
 static int arch_timer_shutdown_virt(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_phys(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_virt_mem(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_phys_mem(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
 }
 
 static __always_inline void set_next_event(const int access, unsigned long evt,
--

