Return-Path: <stable+bounces-217470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO4eN5dFl2lMwQIAu9opvQ
	(envelope-from <stable+bounces-217470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:17:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4385A1610DE
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAB8B30AA8B8
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF6734E743;
	Thu, 19 Feb 2026 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3Bp0l3H"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921FE34DCC8
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521214; cv=none; b=bTKUMbloQR7zgTP2jXtbkBULi5EclnbJR+1pkGfap80StzIG0IH04K2PNTdTN/UeMksw5xwuNNX/C0dKVSoDRmuAgCZNfQeO998tDo5Iccf7PT6x6allBBx5sS7ZENit3KT9xfr8+ELjJk20AmtgbUzrkgxngFibpws/UTQKtqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521214; c=relaxed/simple;
	bh=kyxULOv2H236l1ucHIwcTRr5nnWT32c4Zye+wWGrJ6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=araVMY8u3gT6z/5fNPm2pXSR8zURAkDH/ssKqhs+oyQ2QqdMJjqPT3+h2tyf8KD3iJ+l9qGGJZWbGc53IqYrOg4qd9yrA6hQ0aGJTr0Ql8FX/Rzku37LCrPHEccDOvkNKa3z0exgFu0p2DyAML5ZIAp82IA5ZuOuwzn13mVoFj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3Bp0l3H; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82491fbf02cso631769b3a.1
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521212; x=1772126012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scjH6AQBXgOEyOguxVYTHq5LOFFjJgFpmI1fsS6Z7tY=;
        b=W3Bp0l3HAahee6jM1ZFsDQY48RFSKlrq9I2k1a0rW5Pr8PGi0dstQu6Ye4Pwlh//36
         vyUFE2XWfsxvdUjrh3kFAWNcjJgBWHineh1GaJWMURPIlIPgyKh9KrSqcYQMkdLPrG5N
         HlHfPj2BGJ3H+I/JXIwjZzZH9gZTEkFMPrgomSWxZq+A6igRcS7FmKMnbh6K0DudrhPM
         TjLf/lqvebR+svC8AoIChIaxlUlM5H6bjQrRPFHPlM9lkluXqsq4gCA3Rn9z/9kXgUza
         py6/waBbNlDwJ00ON8OIXF8dV0lE7aKrJ0O5hOxnT6fL0EZRJWDKp/hOMVCVXgcM4wcv
         da7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521212; x=1772126012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=scjH6AQBXgOEyOguxVYTHq5LOFFjJgFpmI1fsS6Z7tY=;
        b=RJh/twzVDAB+c023UgvhJeH0Q1KMwCTwtoJ9KV6KOEd1SfzFzsnBWkondaZUQERejl
         vMvP2akR5V+6Gikj+Yl9BC5ah/2HTbvKMsVQHzwhdmhkOe3y62LpOyLyHdsdGbt6UVeX
         sXh3zM9RZS3hk3SqjoFQyLErZqf1VGCdkvUIsoKh9vpOAcz6DMMdn866jPfOh7qBagOc
         aOcBIhHnLBwta08rBRNSEtQE3PoDDn6G7NK1Knzb9ZXyGpKT2tasgPxTm6YijxHYBO1D
         saXwepGm5eeif7cVYa6JSNDTJEdoY8EURvrQZIKRXLCgtXYkfVefoS9Fo3nG5uxr5l4b
         ta1w==
X-Gm-Message-State: AOJu0YzMVAfo+VPgmYSHCeg7ghd6bk99c9Y8TK7CUP6YVoy9vW6SA5Gm
	0zVADUIpJLsigLmGk0fwCQuv+pzgEAxwR4m4KEishwWnRBEFckj73Iv3jri8bQdd
X-Gm-Gg: AZuq6aJ+uu1j3iLhzXs1//Yr6bPgMGnXUl+sUyyUynx/j60A1Z1jKpeYa29vy0jIpsX
	LkrqOt78aK8EKouHRP578hVZyrZwaRWOi/d5pKH4DK0Xe9dhqYTBuBHKTanYi0/VS1xYP1LMq7B
	NK9X8gzCi/05Py02RqIuYT2rpCR6Vz7FJFVthBX60ZUl2FVSAvxhlB3WWRvb9dBRPeY4qeZ+aFL
	/GQKp4VHhYSVOrmS6CS7T16lAST1vwzr8Fi1++DCveOn9UMWKZ0LehM/YRqBjUksCK1+Y9V8Uim
	kyniJ6An4Ryy4hIt9acz7UVAlDXyQIthed18bNfugngILiVUnnheixRP5bp1z58M/0dwnAX5jy1
	w7HajoYHlPLx0VBOXM3d5bSOG8ZoiYI+6fJQcc6cVU6WJkdMtpqdWXPHKqe5vamMiKBOihhoGjv
	aEHomTsVROmyPYGLeYPUtRSqwLKMEttuqjlUl1nWO0Hhut25U70Cq15mgfQurM
X-Received: by 2002:a05:6a21:1645:b0:38d:f08d:b349 with SMTP id adf61e73a8af0-394839d554cmr16555786637.43.1771521212312;
        Thu, 19 Feb 2026 09:13:32 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:31 -0800 (PST)
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
Subject: [PATCH 5.10.y 04/15] clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function
Date: Fri, 20 Feb 2026 02:12:59 +0900
Message-Id: <20260219171310.118170-5-aha310510@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,linutronix.de,inria.fr,linux-foundation.org,arndb.de,vger.kernel.org,roeck-us.net,gmail.com,holtmann.org,kernel.org,infradead.org,goodmis.org,linaro.org,huawei.com,lists.linux.dev,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-217470-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,roeck-us.net:email,linutronix.de:email,intel.com:email]
X-Rspamd-Queue-Id: 4385A1610DE
X-Rspamd-Action: no action

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

