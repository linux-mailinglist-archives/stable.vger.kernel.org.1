Return-Path: <stable+bounces-64751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA62942C34
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 12:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7CB1C208D1
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1FE1AAE20;
	Wed, 31 Jul 2024 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="koN49hfT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bn6l+77Y"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A67916D4CB;
	Wed, 31 Jul 2024 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422526; cv=none; b=mpgR8ouOwAZsPyCv4euTVuoID6cT76ASh1ykud5TuI5Oa4z50mPKRd3sBtX9tfGtLfMNtCGgPgFqmvFzhy4Tn66z9dLuY3EBlH2it6hvswwWVsaTNgDlgV1J+NhtdL4f4nXbTzWi0MwHFhXkGtRFPjWGetR/uMbifEM8U0cTEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422526; c=relaxed/simple;
	bh=c1PZJWTnZ77sIhB6Q/PuYa0ol3vZjIlc5O0OR+alf90=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KtR/RlqKVDpZ5+tQW3cJ3e+MQZC/zJHo+gYLVnT9y6M/YKSEqayy8UGqCTDcss9R/lcx5zHkVPWWSglcLDDCjSDdgSO/kIs/UyPNwrfa0OftfOOfF4hsI6dFFR5ix/gUjKYyeOAw1Gd7sgift2/8j4W+NXxhc8JkWDTcefYoMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=koN49hfT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bn6l+77Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jul 2024 10:42:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722422523;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4xsLdUGOkXdnQjiuDxXU6QaiwEFqtg7nmTnt54WPI64=;
	b=koN49hfTZoAcWLH2L3t3CUJMOONhPHfQbpvwIaebqzJDh0zNBK19YBf748KQSK42JBYy8n
	3+Cg0hW5as/yTmjR85DG5T1i67fZvosMaIP/EhWsQY5D+2ew5hWcrPnBI4LJxLMeXjPQSK
	zChsEx37IoAJEqO3kID3IjlYy7O818MpFjDXVqJybBfOhEe7oVSY6ub1tjQzNu6N4yL1rz
	uPdnAPVOmK0dKL4FZssM7rbQkc725hPF9ZPTER8qvOkhi5Ojp/9oohbsZtuEhPZx4JdooI
	2ntSicEqTIcg1vJ2ZtlKlh0uYmAQRpx0VsDOoCw1xg8FNh1UxrPDwX7low/ecw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722422523;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4xsLdUGOkXdnQjiuDxXU6QaiwEFqtg7nmTnt54WPI64=;
	b=Bn6l+77YApqoK1b5OnItdksiN8vEx0/TbZeolFY+z8/YC9yiZNpkkfYDRm2LF79u0aRq+f
	Z6JgTiZUWtpH28CA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] tick/broadcast: Move per CPU pointer access into
 the atomic section
Cc: David Wang <00107082@163.com>, Thomas Gleixner <tglx@linutronix.de>,
 Yu Liao <liaoyu15@huawei.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87ttg56ers.ffs@tglx>
References: <87ttg56ers.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172242252292.2215.8458613461295137284.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     6881e75237a84093d0986f56223db3724619f26e
Gitweb:        https://git.kernel.org/tip/6881e75237a84093d0986f56223db3724619f26e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 31 Jul 2024 12:23:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 31 Jul 2024 12:37:43 +02:00

tick/broadcast: Move per CPU pointer access into the atomic section

The recent fix for making the take over of the broadcast timer more
reliable retrieves a per CPU pointer in preemptible context.

This went unnoticed as compilers hoist the access into the non-preemptible
region where the pointer is actually used. But of course it's valid that
the compiler keeps it at the place where the code puts it which rightfully
triggers:

  BUG: using smp_processor_id() in preemptible [00000000] code:
       caller is hotplug_cpu__broadcast_tick_pull+0x1c/0xc0

Move it to the actual usage site which is in a non-preemptible region.

Fixes: f7d43dd206e7 ("tick/broadcast: Make takeover of broadcast hrtimer reliable")
Reported-by: David Wang <00107082@163.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Yu Liao <liaoyu15@huawei.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/87ttg56ers.ffs@tglx
---
 kernel/time/tick-broadcast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index b484309..ed58eeb 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1141,7 +1141,6 @@ void tick_broadcast_switch_to_oneshot(void)
 #ifdef CONFIG_HOTPLUG_CPU
 void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 {
-	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 	struct clock_event_device *bc;
 	unsigned long flags;
 
@@ -1167,6 +1166,8 @@ void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 		 * device to avoid the starvation.
 		 */
 		if (tick_check_broadcast_expired()) {
+			struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
+
 			cpumask_clear_cpu(smp_processor_id(), tick_broadcast_force_mask);
 			tick_program_event(td->evtdev->next_event, 1);
 		}

