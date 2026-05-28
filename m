Return-Path: <stable+bounces-256438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNorKjrLGGrrnQgAu9opvQ
	(envelope-from <stable+bounces-256438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:09:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 205C35FB371
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 676F430E355F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397CD368D76;
	Thu, 28 May 2026 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfaItyyV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E8D2E6CC0
	for <stable@vger.kernel.org>; Thu, 28 May 2026 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009679; cv=none; b=bFdfHMDT03R3zVObUNYeWg0hLYyrhYria27Xxt4kUFUOGpvRf/9Fe+Mzg7d6MMWVpxooM5OREke8nYKZrDPGqGip/rL1v3PeY9ttU9uQsNqRivzF2HKKNvoovCEr4RhLBqYuyS8Jz6gL6ysP1D9s7iJ8nH4v85vhFtUpsHGdnbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009679; c=relaxed/simple;
	bh=+4t3Gs4dNBrwz9KCzJpmkQXSngU3pbblQPUNrZVuQ5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hddiRx1ut1k335TC3QV3QOVdGfJXt+12OMKuOT8N20gt5fS+hpS/VNooTm7A2NWqAE78QjXO2ghKLlb/oLmM9kO2DGGFki6miGSns7q91NV92X6xkhunXveQjyd2R/TzqgNvafg3UZhR7sPHv7+pHJU6BpF6tBpv/dX5TVGHXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pfaItyyV; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7c7fc722b50so108914077b3.2
        for <stable@vger.kernel.org>; Thu, 28 May 2026 16:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780009676; x=1780614476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EsmYLjdQXSnwyvW2KX4QOuwimq2GRxmHKitgrfKsf1E=;
        b=pfaItyyVQ3VRBPrEIMVRSoFwTEhToC5qo2g8rtcSBCqwxBqe5ymQ2M2P+SlUoR4wJ/
         3fukwAIYx7/XGalSMZSXV7Y8DB3XFwVkJBo5sJlEGc8PyQR5kH/vjLLICvxGXkVnfqKs
         Lx2O9ymxQFFKeVEY3PtgnPFC4DswO2XZ9EdJz64DKOYfGu3uFJmpM5P+y59642Sbzr+e
         HN0mTldDSYTY6qpg42/rIHE3c9HzLDCK7Zs6Yicp8egokRVi3NvcVV1MXMBb/Ire8nIu
         SpJJMfjtOfOG2xlGPx7Pb90iAZ/Bgwq1w5vF89oI05FPJUlAn+a4bVKoH2mJ9DeRqu2a
         YGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780009676; x=1780614476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsmYLjdQXSnwyvW2KX4QOuwimq2GRxmHKitgrfKsf1E=;
        b=VccQzE0KBAjN/ELmE8oG4gfABd9Bu1kkURxwZXU9TkItyRKbMha67WckykGvhGyjnF
         xX6SDVsMrVnk+yE5DmtSrnf0mKqrZhyBypTs3to3yjuHFn0uLknnVV6lw7F7D9K0DeaM
         gLeZV5CuHndegVboS+1V5bngiJSSFhOKb9lSsIY9Cv+avoSXnBk84HFADs9lucRMOPHJ
         nZeEKvQSWOHwmCurZM9dzlz+F3+dLrC0XZqZji0q/Nq8MGNpEl3T9J2UfS+xZ2kN6Ild
         0qXa9GPp9qpQRLFOeqVfXwCioS5Cqqsi/mRvNHNCjbdKjb54W9j9/fhnuGdpBGNMmVkb
         17Dw==
X-Forwarded-Encrypted: i=1; AFNElJ+f4DNW5b5odPrhxfA81EVh9vwBg7WEWHx2OB3Q/8d3dgrwZa1She5tdnciAzvlre8DAVyrrlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXi0KV1zcNAob0MAQEkKwZsbtXxy4YSFKdiD369IVpoGxWImss
	YfmH278Rq/4jrTRm1LWbInz5jbdqwPvIZjfSzE2PpPozf8u8ztWPEzUN
X-Gm-Gg: Acq92OEFD2woRUw4sO6UCT7o7vbmoRKCrHj4O5s2dQ5btAyYGHr8pCPhEzLJ6Ckr+8V
	RT1U7jYgaVUsalS4Mkuzdexc6R6Q/ZuQSQtz2Wbg/DDaG68ifQlPw8ecHOrDdND48fPuC2TdlIE
	/ducCRF+MIorg1hWpx+s4M574n2k3VWFsfTpJZ7dQPCARMLfQ+7FvpVamny0xVIS/IBrUERnmQi
	fT2n1ZFVCZFVAWp0xZFyJGQzHQH7p7WfV/h0SZ0GTz9BepplPqQTtBt87RKz5j6jCDBE/DtU2EZ
	8drV1xu/3S3Pq5dKV2mCdHV8AKRw+cgzJnMzmEvzKa/k4b4qALPtRsiMFjoqDZmOOv+uNaDlxNp
	iSpXR9mC3qkziLFLIIBAULDWyO5l9DNLWAUmZ48SY35fOS6Fg5AvRc8kXHLYCs+0TNgo6jB4dao
	llpMHNOyzRNqS9ORZ3d7u7rOjvDMkZ5SmM6XOqWlIZa2PQxcsrmoC+lI7MhZlc5LBlSRwmR9M1L
	xTrEYUPRT+KlOwrD45y+ea3
X-Received: by 2002:a05:690c:e3f1:b0:7cf:a117:4ece with SMTP id 00721157ae682-7de43b55932mr3086127b3.10.1780009676141;
        Thu, 28 May 2026 16:07:56 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6d1f3943sm69177b3.26.2026.05.28.16.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 16:07:55 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] alpha: Use work_on_cpu() for cross-CPU RTC access
Date: Thu, 28 May 2026 19:07:50 -0400
Message-ID: <20260528230750.1840681-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256438-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linaro.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mattst88@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,x.tm:url]
X-Rspamd-Queue-Id: 205C35FB371
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

smp_call_function_single() runs its callback in IPI (hardirq)
context. mc146818_set_time() and mc146818_get_time() take rtc_lock
(spinlock_t), which is a sleeping lock on PREEMPT_RT, triggering
a lockdep "Invalid wait context" splat on Marvel SMP.

work_on_cpu() runs the callback in a kthread (process) context,
which can acquire sleeping locks.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/rtc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git ./arch/alpha/kernel/rtc.c ./arch/alpha/kernel/rtc.c
index cfdf90bc8b3f..4ad5846a1d71 100644
--- ./arch/alpha/kernel/rtc.c
+++ ./arch/alpha/kernel/rtc.c
@@ -15,6 +15,7 @@
 #include <linux/bcd.h>
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
+#include <linux/workqueue.h>
 
 #include "proto.h"
 
@@ -155,11 +156,12 @@ union remote_data {
 	long retval;
 };
 
-static void
+static long
 do_remote_read(void *data)
 {
 	union remote_data *x = data;
 	x->retval = alpha_rtc_read_time(NULL, x->tm);
+	return 0;
 }
 
 static int
@@ -168,17 +170,18 @@ remote_read_time(struct device *dev, struct rtc_time *tm)
 	union remote_data x;
 	if (smp_processor_id() != boot_cpuid) {
 		x.tm = tm;
-		smp_call_function_single(boot_cpuid, do_remote_read, &x, 1);
+		work_on_cpu(boot_cpuid, do_remote_read, &x);
 		return x.retval;
 	}
 	return alpha_rtc_read_time(NULL, tm);
 }
 
-static void
+static long
 do_remote_set(void *data)
 {
 	union remote_data *x = data;
 	x->retval = alpha_rtc_set_time(NULL, x->tm);
+	return 0;
 }
 
 static int
@@ -187,7 +190,7 @@ remote_set_time(struct device *dev, struct rtc_time *tm)
 	union remote_data x;
 	if (smp_processor_id() != boot_cpuid) {
 		x.tm = tm;
-		smp_call_function_single(boot_cpuid, do_remote_set, &x, 1);
+		work_on_cpu(boot_cpuid, do_remote_set, &x);
 		return x.retval;
 	}
 	return alpha_rtc_set_time(NULL, tm);
-- 
2.53.0


