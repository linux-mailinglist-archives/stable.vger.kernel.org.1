Return-Path: <stable+bounces-217472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NkfGuVFl2lMwQIAu9opvQ
	(envelope-from <stable+bounces-217472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:18:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC80161123
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2063630D2ECF
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E599A34DCCC;
	Thu, 19 Feb 2026 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKrlFlES"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4735266EE9
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521222; cv=none; b=GwyCsbXQxQ7YXCA+z8Yg+pFpNoSeSJIDA8RgxVU/CvbCk10nOZ87QxM9JS3fLx+wpk7yFOfQkKmh+DBI8b18i1kauMGbMdlcMGviciV7iOYpn0gLLsGOH2pICOo+IebctjNNT9E48/Qt3JOkux3cLzC3E+4RDo1lnL/jWchdjF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521222; c=relaxed/simple;
	bh=p4TRIPhh7eCXg4oL8eEB5Ly0L/lmhP7XDzG06yVs7As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lH7A8C3HouRdbG5B2ktQjrzCvLHr4fi5lR2p+4tTwWP2D+WWXTT0vWl97BKUJPq2WcDGUZ9IbuQppzLidFyY4KsGf0aESGsyiHlSpK3P9En8s4D05SqvnNj78stQR6FJ91tRqIOxX/p/dZ099xFDSTZH0e6nTrDFZX/RbQSU1Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKrlFlES; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-823c56765fdso560956b3a.1
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521220; x=1772126020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWjvp+vOFGL8T/NXTev+NZf62jPu9HyIJqL4GkC+d9Y=;
        b=FKrlFlES6e6BGVghY8oWZK3LyO/CF2mkwPfSWj/5/7ziUBrV/6mOMLEE4QxJhCxaTH
         rYroFZ7raOj9l3ErtFIcEsYuf9wEeRGhKYtOGGPtYx03vQTwlWZ2qQLisyp9oblOJgmB
         nsBL3dek3d9pUUCuJui1cgLaAZFn+rH8uAHED239238h1tkqfP+c/OblFrIFd7cz/PbN
         6wHvW+KpCBtAqEIgEVMMjfwfw5yNViW9z70tJ6nNTQ2EMAUq7Mn8Sgzg8cnjTylhvOTj
         +NpxcrorjQkmpHvYV6nlX0NQs6Mig/akS0/zKWfu2fVGPpKj5HKGNkrqW52dPflxiVvf
         WnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521220; x=1772126020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pWjvp+vOFGL8T/NXTev+NZf62jPu9HyIJqL4GkC+d9Y=;
        b=iRmCj8NliNheXBzhVwRh1CDVtvXRrUYS2RH9LdohkSUjquGzOKL0trXyw96x+/Wxue
         0tDKKAKUU55LD2XBQt7bblunIHVXQwfJsIZ6GxnkJ4ghYY0vA+Ar3C9adC1wHQ3l38so
         1/B1wV30I4nz6SlAKEZ2VklnsVgRcUjs7cwiKq7t/pFt4eL2v9eBgrTfVD5qEL8UEvl8
         f6pBV3j4iU94dJtbzHn++fCBrwMi6SdsS7jLzAqPal7A7BqLgR1kIBdxIRU9L+yozaxQ
         oGm53bCa08rf+8TiNGKYOkyKHkDcd1YuMXvoLmORvOI7THd+Z/06Y+qzxknH4iAdcKEr
         nifQ==
X-Gm-Message-State: AOJu0YzRjCxVoaslDYsz0tCj+Y8ni1eZdN3ZUX2bsrVmEGnnUwwUdEUr
	A+Kq7WJa2f2GRUR3DWQSbmQpFTgXaV95YYSSJvc/MW4U6zDC9WGjuCyzDqb7Bb0i
X-Gm-Gg: AZuq6aIRR8fuYBKHXhDUzeh0p9hOlEwbZFyvxHS9/WkVVbi3y31AhIw5dqXxndBhNyN
	KnW0KD8XSf7jfib8NXAv+qvww+CTlIvSO+nYQeVC/b/42zu3PlWN1rJzNzs09jDEBREAAcy1idk
	5lXSHtwMH4+IUK/EaZCQyC2aj2KoBfctuymoVocqWdecCtTBl+L5nbAIJPZ/Mh4wFfeBcVGYY5U
	1NaiV6B6vY+i6HXOz36zIcOZjPGbJZxZi2BhVNMCrzOIMT7NH8S9ihQVMIfCFRSNgRhJ9M59enP
	EzAFSafUDdJ6tI0TlGXmC16+ZX/Epp9xXZl721YGVnrnmlrtjbBBvkCx2tLvq5qwejve0PkQMLX
	/c9NdIM6cHXQNg/OKsMpy2HZuEBNWu8B2Z3P0eEdD2vUWfugyxxdCKrY/epBVfy53+ZcAefzUaW
	C4NA0TTMm946uvwNKkT5T8bucZTyZq1nI7MVF//Y66JXhkMDhNKQ==
X-Received: by 2002:a05:6a21:330b:b0:394:6023:a0f2 with SMTP id adf61e73a8af0-394fc21a2d7mr5528099637.21.1771521220510;
        Thu, 19 Feb 2026 09:13:40 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:39 -0800 (PST)
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
Subject: [PATCH 5.10.y 06/15] timers: Replace BUG_ON()s
Date: Fri, 20 Feb 2026 02:13:01 +0900
Message-Id: <20260219171310.118170-7-aha310510@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-217472-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,roeck-us.net:email,linutronix.de:email]
X-Rspamd-Queue-Id: BBC80161123
X-Rspamd-Action: no action

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 82ed6f7ef58f9634fe4462dd721902c580f01569 ]

The timer code still has a few BUG_ON()s left which are crashing the kernel
in situations where it still can recover or simply refuse to take an
action.

Remove the one in the hotplug callback which checks for the CPU being
offline. If that happens then the whole hotplug machinery will explode in
colourful ways.

Replace the rest with WARN_ON_ONCE() and conditional returns where
appropriate.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221123201624.769128888@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 kernel/time/timer.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index e09852be4e63..7094b916c854 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1208,7 +1208,8 @@ EXPORT_SYMBOL(timer_reduce);
  */
 void add_timer(struct timer_list *timer)
 {
-	BUG_ON(timer_pending(timer));
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
 	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
 }
 EXPORT_SYMBOL(add_timer);
@@ -1227,7 +1228,8 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	struct timer_base *new_base, *base;
 	unsigned long flags;
 
-	BUG_ON(timer_pending(timer) || !timer->function);
+	if (WARN_ON_ONCE(timer_pending(timer) || !timer->function))
+		return;
 
 	new_base = get_timer_cpu_base(timer->flags, cpu);
 
@@ -2047,8 +2049,6 @@ int timers_dead_cpu(unsigned int cpu)
 	struct timer_base *new_base;
 	int b, i;
 
-	BUG_ON(cpu_online(cpu));
-
 	for (b = 0; b < NR_BASES; b++) {
 		old_base = per_cpu_ptr(&timer_bases[b], cpu);
 		new_base = get_cpu_ptr(&timer_bases[b]);
@@ -2065,7 +2065,8 @@ int timers_dead_cpu(unsigned int cpu)
 		 */
 		forward_timer_base(new_base);
 
-		BUG_ON(old_base->running_timer);
+		WARN_ON_ONCE(old_base->running_timer);
+		old_base->running_timer = NULL;
 
 		for (i = 0; i < WHEEL_SIZE; i++)
 			migrate_timer_list(new_base, old_base->vectors + i);
--

