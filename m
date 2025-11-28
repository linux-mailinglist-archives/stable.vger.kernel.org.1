Return-Path: <stable+bounces-197609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A58DC92849
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 17:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49532351535
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 16:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848A432ED53;
	Fri, 28 Nov 2025 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GONYey7a"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50832F765
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345987; cv=none; b=q8u4EMiUtDwN4fHqwusT4b/icOUu1870MQJmvHkB/edENN0JJ2jgQ+3r6JcMJa/nq+y4kVycv1ubiVYUMV9Aox32Cwt6Oxr0u/0O+70dJCOf2YhK4d0MOh4UXFScGzfwc+O10zeh/cefYlDhXvtYgiYai6kC1SbgkQxlp8dQ4/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345987; c=relaxed/simple;
	bh=xUOfVR4rsP4k4iSxfTxt28P2aCRP7f27RFLz88rROqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbFsMI79zx+w7/GQsgg+/TvHMU9zynszAIYw9BvJkWUP0ShdSc09GVKNDFrEUtKlB8qnLrUqic+Ecn3BTryw5/fA0LO/YjKSlqH1pBrx3EKuF67JU8r87k5smfHljqcumeF9cU/M6N7bLxlvsYpYrqHHnRIWm+Wu7LmNnBuJ7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GONYey7a; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b75e366866so1013539b3a.2
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345985; x=1764950785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aRj16inyvCNx7XEzEMiTg0hEspzqpDmbN1/ltb1rWU=;
        b=GONYey7aKY1Qli2QU187NYWEtijrZYSSrGDyDZuvBWIXX3wPFvjFAq+dNrVsgy6Y1+
         JIrpusGVJZfLpWhf34s+nNQ913aNP76l0V65Zf+45ZFze9OtXanXOSHSv3Hcx5FvzGeB
         b9dL2tuXLzlBQXJAsbgRQ+1UMrHJKKj4AHLcTsRIAm+lsauWgWxAWaioTbHgjOwxmEVf
         bKRn/mkrQ1aPGyxDxyeoelB3cOSoTwiqITvyw62mqxLRdxoa2bex/T4iKogfQzm4elyV
         IwX+0h4nPo8mUep/HKJaRVuVJYXewWPdphBZUQRBievnctv5tdOW8oROQJHEcrXLXyaY
         lnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345985; x=1764950785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5aRj16inyvCNx7XEzEMiTg0hEspzqpDmbN1/ltb1rWU=;
        b=GgSBSbtjPbzCkLQOEylBue7GRRFwpGDPkIC/bmz1bRGzHFO+Q6SDJxYHjqV80Ib3GT
         6n4W8cACVJxXLHuQ62R+kPdohBa//CRSTgdCN8+TQgbowceacArtN/lP2gwsJxb9Saj4
         9iqiv6kcUaltZBC4eRPlsTgmiTu92s32Lasj/AT7ALLbGM/rDNAa1XiBXJnGVQTTU/oV
         HNe8OOJRlSRw+RYhb7HL+HniG6ftuYmHM++b+GrTt0boN3GXgZVd/qybSzuH/7yCnx4O
         hTk6GN8ZT3NQ+xc1/GLQyI0bBYcTiOgRvFgZW7iJ9hZJLv46GRGSCzydXketrnAo4exl
         I+tw==
X-Gm-Message-State: AOJu0YzsWQDC07q0ZuArD19D4nFf9h8wIGHzcVPy8SopUzuiazG1IsHO
	8opPx+4SdWFnmMHKsE0o20LIa0ZncstqUAD25NzBgNqrfGD0UUVWvlZE/0RsmYeLo6ew5w==
X-Gm-Gg: ASbGncu6ocvxinXTnrCevommr+x1zqpxa9VwKKKLhgOj8QWj1Vaf62/jJ1SaDHHuX08
	PcwTouvhy+7nITvhngJS4OwPoiyiRG44swndDishtDHXZaWmtHQK3Bh5mtIRbQc5nalX9+oiOTz
	IPz8FMhHmqv0qxNMZSTuK6ymCY19of2d6bWnYz16+gppN1V5DXzD1XXCK4158f/BwB3mdilZW+D
	mIffFj22BE99JHUT2AtSIJAWAef08T2LrJa6intCx9Q2dqfMK7a3XG12EOc+F6NvA1VUqxQZCAD
	PkpMNMJUCRg5mzfYJ01n0kOPHAPRpSnQFzrr0DQgjfBtuMTnXTQfN6gBCDE2NN/P+pHuG0SaR4F
	9EWvdS7QRCA9W091c4aPZGYfnSLKgxbF6OTx4WguUQaPoqzwMF4hDF8olxINZZQsE6yXx/WVAZo
	/Y8Ls8iRZK+3yTtAzoD1aTsw4wxFfhq6sT43jh6w==
X-Google-Smtp-Source: AGHT+IEztlvGKlUoqD0g25lCC8MUysNRG6xtAj50T9YwNqBxGNZ27/ROzosGghSBWQujOhn5Z/L7rQ==
X-Received: by 2002:a05:6a00:987:b0:7b8:7c1a:7f60 with SMTP id d2e1a72fcca58-7ca8977c27emr17931768b3a.12.1764345984715;
        Fri, 28 Nov 2025 08:06:24 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:06:23 -0800 (PST)
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
Subject: [PATCH 5.15.y 07/14] timers: Rename del_timer() to timer_delete()
Date: Sat, 29 Nov 2025 01:05:32 +0900
Message-Id: <20251128160539.358938-8-aha310510@gmail.com>
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

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit bb663f0f3c396c6d05f6c5eeeea96ced20ff112e ]

The timer related functions do not have a strict timer_ prefixed namespace
which is really annoying.

Rename del_timer() to timer_delete() and provide del_timer()
as a wrapper. Document that del_timer() is not for new code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221123201625.015535022@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 include/linux/timer.h | 15 ++++++++++++++-
 kernel/time/timer.c   |  6 +++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 551fa467726f..e338e173ce8b 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -169,7 +169,6 @@ static inline int timer_pending(const struct timer_list * timer)
 }
 
 extern void add_timer_on(struct timer_list *timer, int cpu);
-extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
 extern int timer_reduce(struct timer_list *timer, unsigned long expires);
@@ -184,6 +183,7 @@ extern void add_timer(struct timer_list *timer);
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
 extern int timer_delete_sync(struct timer_list *timer);
+extern int timer_delete(struct timer_list *timer);
 
 /**
  * del_timer_sync - Delete a pending timer and wait for a running callback
@@ -198,6 +198,19 @@ static inline int del_timer_sync(struct timer_list *timer)
 	return timer_delete_sync(timer);
 }
 
+/**
+ * del_timer - Delete a pending timer
+ * @timer:	The timer to be deleted
+ *
+ * See timer_delete() for detailed explanation.
+ *
+ * Do not use in new code. Use timer_delete() instead.
+ */
+static inline int del_timer(struct timer_list *timer)
+{
+	return timer_delete(timer);
+}
+
 extern void init_timers(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 60e538b566e3..2b5e8c26b697 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1257,7 +1257,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 EXPORT_SYMBOL_GPL(add_timer_on);
 
 /**
- * del_timer - Deactivate a timer.
+ * timer_delete - Deactivate a timer
  * @timer:	The timer to be deactivated
  *
  * The function only deactivates a pending timer, but contrary to
@@ -1270,7 +1270,7 @@ EXPORT_SYMBOL_GPL(add_timer_on);
  * * %0 - The timer was not pending
  * * %1 - The timer was pending and deactivated
  */
-int del_timer(struct timer_list *timer)
+int timer_delete(struct timer_list *timer)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1286,7 +1286,7 @@ int del_timer(struct timer_list *timer)
 
 	return ret;
 }
-EXPORT_SYMBOL(del_timer);
+EXPORT_SYMBOL(timer_delete);
 
 /**
  * try_to_del_timer_sync - Try to deactivate a timer
-- 

