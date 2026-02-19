Return-Path: <stable+bounces-217473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMcxCO5El2lMwQIAu9opvQ
	(envelope-from <stable+bounces-217473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:14:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE62161049
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3057C303388A
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277DE34E75B;
	Thu, 19 Feb 2026 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY0zUH8m"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6A34E750
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521226; cv=none; b=IYbRRRGSkaT+1Ar7j6w92012byeH1cKwUlP2DfkjHR1u8238EbdcOhH6l8/V0cypzXAJlMrCOZ2DwiKwOQldTOTjJd0OLqqzXCw0ejlOA7Vv+bqe6Uq478I4/ZlNlM5xEbdAvDPkSHoG6yzVmi/7oxhKMfXsba+teRMo8tpDa98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521226; c=relaxed/simple;
	bh=xUOfVR4rsP4k4iSxfTxt28P2aCRP7f27RFLz88rROqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sbyFPDymxTYfA76+AyWhOtGLbTDjaeyt7to8Wmhr9n4MHQ7ATW4Icm0ajUa0/cA3/3MiuLffIkUPuhFstlk/15MC1H0sPe6owg5Hsefe4mrf5V6RzE//IyM5GCz9MpU0qny+YzCT3tuaxDrXAOHYiHB3QdprCgChA3Ft0jWbBiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY0zUH8m; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a7a23f5915so6647085ad.2
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521225; x=1772126025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aRj16inyvCNx7XEzEMiTg0hEspzqpDmbN1/ltb1rWU=;
        b=KY0zUH8m7Iw1psu1q0hzSqh8kVqUHFTaFcrn55/eQnUy11muGYTgFrCvWOrV5iJgnt
         lln5LEFtovSDb0HplHUBW3TsI9mEFiXzZRe3Vd9sAGVO1iSfaLsE1BmWJ3mUUllKl29x
         qAJZJBel5oaL0VoWEgo+XGDiBR+b8Tg6/JgF8PNZmHch+GikaexuW3jL8tLzchK5GJiC
         od7B33BMXba+EtDGtQIkkam1AcaTZR5R2UoEGpJ/0sPlc1h527IlL0H3rf2juRSd+b89
         ZR5vk9cR8IQO/+5r8N9HKFpHmiydpeWQD2fW2TQ1blK0HFR9heN805WdC2QQJk0L7LRR
         X0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521225; x=1772126025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5aRj16inyvCNx7XEzEMiTg0hEspzqpDmbN1/ltb1rWU=;
        b=lgcJFezEax3veW8XUEORweQ6W2SfQH9aU3gKes16YoEahqdQqgj47393ZPpw4lIX2/
         1rrDy3DVbt+zVt/+41d+0TBkYgMRJUu2gM8giLrdjzVyRKT7jEpzNUxa+EuCE8lkZ6ak
         ytDRngpJscyDcTgm/J9vGo+vJhRLAIs6w7DZE8t3KGgJTQKx4yEtw4a0GWs0mQXdWK81
         5FI0C2NY9hsxM3XqSUNaEYj09LjOSPJ3Kuo3ymWc0v+YBxKmRy3L7aOzplO5e3S5Rxgv
         SzvnycfhRJ3FSXDLWHqfWF2Atg9B7mbrLV4HWMRbGoOzAiJ13w0f94EG7dyM+0f079FD
         rUTQ==
X-Gm-Message-State: AOJu0Yyv3vNSqD1Dr7Ml4f5TeNESESiN8NiTse7cQXa0xDUj/c/Mxvap
	8N6cYoTWJZDhTk302e1ILZWEjoQGjWrKujIR4Wxs8sfPptB/vse1K1S3BpFifLJO
X-Gm-Gg: AZuq6aL8h/Fj/1Ub4ol5/37LqDygRIeZX7yPL/l6EYUsNG2+iW0PS26DWWCcJRrlTzJ
	IWTdAcKMYC5/Zd8JJLUxK6ymJ0mO+W8fAjq+xWZBKrrGaQ5tma0Fy6JL06qnitLcQLEsGpqUASj
	D9bhF6DW+f9kVCGAQMoBepqKHYKFGYPwXRUCl56Oap58+eqMKY8gzhA29fnUjs5yNCdl+lwrn3T
	3du35fNAVzEtY8QYvgf30AAYxmUY/25G5Ur6/6pz89pCsncja/jJUdK/tS8te887SElzMYzkhMQ
	56TnUiV+ruJFvduGjk90l+iq9oevLLOt0COp7g19iogkFji89uYTyAdlQ24au+6ZbJT+X+pdcmW
	aQniRHwTSbxYtawntKZFOlARF5CWoWz10dv+08cNrcNmNXgD7dCFiKyXEpMdqw7dveRfYaiA6bM
	u1zsxkldTrpQIzFMwcmf1UstQHw9Q133FBVgPE/ad0a+b+nnyfQvpUKZ8XQcWg
X-Received: by 2002:a17:903:2b0d:b0:2aa:d7a7:8091 with SMTP id d9443c01a7336-2ad5aed3fcemr29265505ad.12.1771521224611;
        Thu, 19 Feb 2026 09:13:44 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:43 -0800 (PST)
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
Subject: [PATCH 5.10.y 07/15] timers: Rename del_timer() to timer_delete()
Date: Fri, 20 Feb 2026 02:13:02 +0900
Message-Id: <20260219171310.118170-8-aha310510@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,linutronix.de,inria.fr,linux-foundation.org,arndb.de,vger.kernel.org,roeck-us.net,gmail.com,holtmann.org,kernel.org,infradead.org,goodmis.org,linaro.org,huawei.com,lists.linux.dev,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-217473-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email,roeck-us.net:email,intel.com:email,goodmis.org:email]
X-Rspamd-Queue-Id: CEE62161049
X-Rspamd-Action: no action

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

