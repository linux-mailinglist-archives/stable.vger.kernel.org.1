Return-Path: <stable+bounces-197608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB9C92846
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 17:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C83834E429
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7F232F740;
	Fri, 28 Nov 2025 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frEHY2mJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FBF2BD030
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345981; cv=none; b=sPkrS9fLnp+UXfk6MtSVAAbV5ytbcWeNBTXQwr39pvQ/zcUV+2llEMfjANaWE5tQJwiNXnWcigI3ZzpANN28rz7JRt3HE93CWy0c45h2Vmp47cUDU/XpqbjRYqoLAS8w9r7Md1ou2mWqYhHtu8GiFXnAcn5Os+zCHSYCWUzI/uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345981; c=relaxed/simple;
	bh=p4TRIPhh7eCXg4oL8eEB5Ly0L/lmhP7XDzG06yVs7As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ot1XWpArZt/WVUPYYS3An6M1lCRLfyxSJiWqyriGcLJSpwMCwmzOqs0/g5hTbSpogWzEXQc+GPDCa4KiT389tc8pQ6mGGaA3tj2uVdjBe07MQu8NcGeONVPju3ORwA2w7Ff1gCtRHQTp2UVbB4X/FIOK84nCZ/IAjrLESw9flEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frEHY2mJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7ba55660769so1739190b3a.1
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345980; x=1764950780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWjvp+vOFGL8T/NXTev+NZf62jPu9HyIJqL4GkC+d9Y=;
        b=frEHY2mJ7l5Rncm3cA/ZaOD3JYo++2nO6VWFcYAaLZxferXeZuUWGub4VehRO3fS/X
         KzzK2Jn1cVofOekGtlHP1DuNbasOSfNRKYbacrIaRmpgqLOOeYTt4PcbYQYrjicnw6fQ
         VAOBYFzPnk5839WRKjsDS2tAsnk3WiKZWv4B8v66YHKGjY8xljGP5cbFTEtI80kMn2pb
         5Cs23tHv+JaycJk9XeZAOMIJY+MBeHel8aLZZWfMFAQ7MtiWtOJXlYcZy0Fi5MkogeAM
         zS38vMZ18ux0zWNWQouAKEaEG/WLTv6TW7/nejB2h++AQCh795zvCnmNqAonm+doVAbR
         RGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345980; x=1764950780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pWjvp+vOFGL8T/NXTev+NZf62jPu9HyIJqL4GkC+d9Y=;
        b=Ku9Zt4MY0MR7BHnajQ9nCyUPhonmV9EGOPW3eE3CVqQOt7unQIICZqPCfpEY6BwvaW
         weerlG90frTIJ/8nacJ6URn1iOJOzdVsez4WeWiOojATOoUe9ADL6ig8Q/SlJYO2PQNx
         zwVlz+uG2rSSeKRgtV3pEjrClGlnoox7u/KVrW3iEx80NTGEOrlKMsp+r2PrRQHr9VUV
         3H5d/MB2ZHlt/AEojxy4RobdLh0L5jzTg3/xjgtbYlMAxvaESQVR9z9z9L1KpuXweh+6
         3IXrPuoMEFKvF3p5uaZyA5ZZQ7/ed84IxMFA1fFN8/wdHU0re25jM2io0aI8toa7DmZg
         lJZQ==
X-Gm-Message-State: AOJu0YxZJ5QshgajHJyHD/hZ2Dj/vVLYm3kJvrvH896rgW3nCP3muC6/
	cLveM4JQ51CEglBnCSzEjr7wrPH++mDPdCnns9/wAm3TPqqb3oaQUR7S7a3l9woIVDsLMQ==
X-Gm-Gg: ASbGncvbc173mb2BiZbdUrA3d7f3v8sN0fSsWyrJauGoA5EeOmcBPVmg61wO2a/hiFY
	97pV16HGexgNk9AP0p53fVoHZiKdTTL0enaxJxZAeqUurkE6MkTPKTPGBhJf3Av4D6sfI5JNyUv
	8pJ7G8mPvbic49VJ+4FJajPwg+ut/xZfrzhPCg8EFNZXunm5EV6OkJfVuYmsikuha88yWCNeW9w
	tEtqtiUS7fyuAM0aGKy5bHy5q1oVx3FHD41cDR+ILSrdBNKz7cFp4sFBMKbKvhkkAL9hZzc7VV1
	IP0YG2b0Q4PF0xj+ibawqN6dNUucV4GHzmigHzuSlkLL28L+xVM98cAjNOrTUFYdXSxuvgDkFpu
	hX7nrHN44EDyGpaKsBPTYVV9Zr5nScATdt5UU9w9RMyuOrM2om65aCLz2f7Pa5XCpcyJkZFYx6R
	JllINVPnLO5B+8sS8uoCRmOK+6ryQQSMy+jOMKQg==
X-Google-Smtp-Source: AGHT+IFapLhQU9fdniLElMhOTBueBGSZ5wz5zku4Mw2lynCB6SmbEsu5fwwc8sIpEraRjt+Qk/oxxw==
X-Received: by 2002:a05:6a00:181d:b0:7a2:8111:780a with SMTP id d2e1a72fcca58-7c58c2b1851mr32051480b3a.2.1764345979249;
        Fri, 28 Nov 2025 08:06:19 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:06:18 -0800 (PST)
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
Subject: [PATCH 5.15.y 06/14] timers: Replace BUG_ON()s
Date: Sat, 29 Nov 2025 01:05:31 +0900
Message-Id: <20251128160539.358938-7-aha310510@gmail.com>
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

