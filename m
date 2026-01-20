Return-Path: <stable+bounces-210444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD20D3BFF6
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 08:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FD2C4FA4CB
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 06:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24C437F0E5;
	Tue, 20 Jan 2026 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x9bRt6bq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Yd+XbN6"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE25F32FA3F;
	Tue, 20 Jan 2026 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892173; cv=none; b=etez7EyPz44NuGSq1nXffOBjvZ5m+bp/2Qxjn7utMArTFkN10sXef2F+kJtO3L2Xa4I6zoITZOMrZDxu4uEJ50GPE0rjcnxXvF4GWkOnMvggkeNTwRc4LaatsLI2MpoJ2UxuJKX1du1VconpVX+oumr8nxTZ3KiXfwfQtmCuH0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892173; c=relaxed/simple;
	bh=OgBUlue3yhxMO4wjnYKnxBSQE9/EJt/EAb8kqemi6+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p3dBijtRl/8mI8bQ83ZHJiNjSLgEfUWbikFYZ6O4M//ZZuxtQiNzilvpT6DYxEgT5GiYXjVbEXmCctLgzTeQTn7vcw7KU2dyxYcNB3dd7tkuLfi6JhTXksynxGN4ljAIluTQPxvSTj5aOQNvp6w3fQlW07qrxdjeouZbkf3Xwoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x9bRt6bq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Yd+XbN6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768892161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I1RMzRkjzzPKXpcnt4IcK3UmCNyPTPJMvmYlzb4CnBw=;
	b=x9bRt6bquCE2QgONkScUYj7EFHC9H/o4HzV48PYxVVGTpxAxkvIi6UJHVo6jrY1RdEEt7X
	9t/PnSMLAWmALcWyS+E2OviOWome9i4OwGmJ6AP43iaXEMMtqSxApCwl3XcKJLjb0KlORf
	lM4YL+/ytTMeVYDm2JXAMhQ1jk/Z10f0n1JN9x2biNf9G8OBOqI5vptfr+GlxPLgmSw3Ti
	GwHQuimjRVUgF9iuJrfQ4DesNzjWg7dVR1/ZnziGg8ikUNWSF/M5ar3BEOIqA1QH7ZqWJw
	gWNwoiwklwoseqUV330Fabx/818nrw2aSojV52GzGPBbFDwtbmW+yc5DSPBSDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768892161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I1RMzRkjzzPKXpcnt4IcK3UmCNyPTPJMvmYlzb4CnBw=;
	b=1Yd+XbN6uGs16+Bwmes6cNz+LN5WEEmGvm7ibFb8pEE9U39YJKiXMvQE6U4CqpiTXL7I60
	dCXMS3fxhn69TsCg==
Date: Tue, 20 Jan 2026 07:55:55 +0100
Subject: [PATCH] timekeeping: Adjust the leap state for the correct
 auxiliary timekeeper
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-timekeeper-auxclock-leapstate-v1-1-5b358c6b3cfd@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAPomb2kC/x3MQQqDMBAF0KvIrB1IsrCxVykuhvjbDloNSRRBv
 Luhy7d5J2UkRaZnc1LCrlnXpcK2DYWvLB+wjtXkjOuMtT0X/WECIhLLdoR5DRPPkJiLFLAY/3C
 uD97AUz1iwluP//8arusGOEVchG8AAAA=
X-Change-ID: 20260119-timekeeper-auxclock-leapstate-a087229c80e8
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768892155; l=1871;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=OgBUlue3yhxMO4wjnYKnxBSQE9/EJt/EAb8kqemi6+E=;
 b=ywObaNcz4Kv1ucvlRgfi+BgbsNq3+qPdlMUx88QkBJWxpi7Waeqc1SmLwSCWsKNorX2gOmfdp
 +uyye56/XGAD2NoIdPQ++ftieBigLyCmLtR6zUf9qqzuEL9yH9SSfbA
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When __do_ajdtimex() was introduced to handle adjtimex for any
timekeeper, this reference to tk_core was not updated. When called on an
auxiliary timekeeper, the core timekeeper would be updated incorrectly.

This gets caught by the lock debugging diagnostics because the
timekeepers sequence lock gets written to without holding its
associated spinlock:

WARNING: include/linux/seqlock.h:226 at __do_adjtimex+0x394/0x3b0, CPU#2: test/125
aux_clock_adj (kernel/time/timekeeping.c:2979)
__do_sys_clock_adjtime (kernel/time/posix-timers.c:1161 kernel/time/posix-timers.c:1173)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)

Update the correct auxiliary timekeeper.

Fixes: 775f71ebedd3 ("timekeeping: Make do_adjtimex() reusable")
Fixes: ecf3e7030491 ("timekeeping: Provide adjtimex() for auxiliary clocks")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 3ec3daa4acab..91fa2003351c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2735,7 +2735,7 @@ static int __do_adjtimex(struct tk_data *tkd, struct __kernel_timex *txc,
 		timekeeping_update_from_shadow(tkd, TK_CLOCK_WAS_SET);
 		result->clock_set = true;
 	} else {
-		tk_update_leap_state_all(&tk_core);
+		tk_update_leap_state_all(tkd);
 	}
 
 	/* Update the multiplier immediately if frequency was set directly */

---
base-commit: 3db5306b0bd562ac0fe7eddad26c60ebb6f5fdd4
change-id: 20260119-timekeeper-auxclock-leapstate-a087229c80e8

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


