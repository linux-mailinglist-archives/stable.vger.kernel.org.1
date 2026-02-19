Return-Path: <stable+bounces-217469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNuCKmZFl2lMwQIAu9opvQ
	(envelope-from <stable+bounces-217469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:16:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3171610B2
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D63B30977E6
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF63834D4C2;
	Thu, 19 Feb 2026 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jR00ZLgb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C4266EE9
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521210; cv=none; b=WpfgySFIff4neWyz3diUPCMTVz7HiGkQA/qOOJ5nikUU3E/33UiS5p8I4E/DcItC6C6tk95zVR/zugIy3kPE2mlBHQ+YDcR/ikHyK495kJ/dPuDUo4BfrU5Maqr5yL2nGdDTCh9A4IXzqjVbkNBacYrY9U/l1XjHfxkX9ScP5pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521210; c=relaxed/simple;
	bh=YY7i+ekw8WEClpFqVZfbZbIPcOFXG9mqoVtYSHhdgrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e7UvwuErHr6vDkVSArLCuU5r+ELc0IEYFYQOctY9gsniIqA1NameGt5iTZcSx2H5BdoYq1A0q0TV4S8yi3c+3pGeRHDiwKZ60jSI0khycHVmk0pJMl/DAIMQXb+7l8Zx7cmyQ5Nc15uVLoxsf8rA3n3T0/nDcovS5F//G1YnbyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jR00ZLgb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-823081bb15fso661536b3a.3
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521208; x=1772126008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lru4V+cwKFfxLK/nzfZUd/f7wkQ+5dEE9KWoaatQVPo=;
        b=jR00ZLgbANM9QQcV6D1qJrZXE56WthEzEZ/6cBIiXYM3oppVe7F9M6qiq0g1aTyy2U
         9RU3gzgybGUrlFOclauBaMFM8Pjri1YBXFs6zeIUMulSYXvkaxlRxVNUEqXz84QS1hlh
         ei43FJYHkEf/s/LyLMUYeAJT6UXdpxzPc0EFg273eS9dm2LNlyQzFehc+3Di0C8MLDdc
         LAdN6Nw14anWlSnNvDX90x23v4ntd2aZIhv/nj09v35hLvtXYDEGcTHweSxR+OIcqXy+
         IUKj2uUNw0lwKvRbXY+z3/nqZEX+4oBXsmBsZmSSfwASZV5ZqWS++Oaj+JPn6iOUE0y4
         uN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521208; x=1772126008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lru4V+cwKFfxLK/nzfZUd/f7wkQ+5dEE9KWoaatQVPo=;
        b=Jnd6d9DwfralPUGRhJYRfXN0JGgOXxfxeu4/VwIJ5DDbzJxK4I7lL/dRlGLCerBH8f
         raRHGUIkZXVveHf/YI09xt7csIjXw/3XnMixzAIpcdWmovRJXWgywtBaMs+NRpppAbd0
         QSAceh8Bq9U6XN8yk8plYd5x+9Yql5VCn89IzIz+2mu4tcGo3bSZd93mhNZHqs8MVhsh
         F5nBDW/gFKr62/HaWw3AVqmKicJYRxLBvY4lpUneZ1Ul/llDkLfuWCLWEAaItvu2COUg
         8XVSBstIBj2flOKe+ZqNUpmBQhLoFdr87WehnupMio/qUe+KKaHAOIn9F8M0aRQwnsEH
         vnVw==
X-Gm-Message-State: AOJu0YyCUShf+/jfUO/1UiQAULxWkMXymytQ50qdpFGkJ3oCt7MxBfy+
	8OcrRBjSrcLfRPY9u/3fVRXd1GZMTUhJZGf9sHzzMav083YRoG1Tm49LCgTb2SQm
X-Gm-Gg: AZuq6aKHrfYvWK+MbWHOFP5aOwpVAn8m6LI1lxfFwzIxc2w99Ki+jP9TSceNLt+S6Wm
	4Gb6hTiD5m3lvjJMkV3crc/zk+nvWwaXc/UvspncNdWp/dH+LiwAgppHM+Gz/dEgXAxiKZ8AIy5
	3i9mzqUykR+dKsNHpWAjqctRxnZXiA+Er9RymC7u/MkKT4wideMd1inqbvJ5qVinG8QSUEqMPW4
	mr/nFsXb4ToQfTHtUBet+NA5LDXfP5wbBgVJX24UGzi4aGmmY2NQXMksyTFgUJ8QA8PPHKU+R/u
	YoP/X+HNklR1Il5d6y3NnZFAapYcies9uurzHzISyZg9ZkYhJAOnBe9BHSwzXxV2Gq9mSG0GOOD
	5hsjZxazbyEzHALKRF83JpC3ULNa35Wmhpu9rBsJtW/j7xiQ8y8nh5GXOFY57y7bvhsTmIqcGVg
	wQlbBiM3RnTRTUQSiFNuGZldpn51sF6jXEq4uzoQB4Pb2nw+ZCTg==
X-Received: by 2002:a05:6a21:4c03:b0:38d:e9e8:25e0 with SMTP id adf61e73a8af0-39483897793mr17324026637.20.1771521208129;
        Thu, 19 Feb 2026 09:13:28 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:27 -0800 (PST)
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
	zouyipeng@huawei.com,
	aha310510@gmail.com,
	linux-staging@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.10.y 03/15] clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function
Date: Fri, 20 Feb 2026 02:12:58 +0900
Message-Id: <20260219171310.118170-4-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219171310.118170-1-aha310510@gmail.com>
References: <20260219171310.118170-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,linutronix.de,inria.fr,linux-foundation.org,arndb.de,vger.kernel.org,roeck-us.net,gmail.com,holtmann.org,kernel.org,infradead.org,goodmis.org,linaro.org,huawei.com,lists.linux.dev,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-217469-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,roeck-us.net:email,linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 0B3171610B2
X-Rspamd-Action: no action

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

