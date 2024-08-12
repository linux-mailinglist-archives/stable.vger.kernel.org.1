Return-Path: <stable+bounces-67290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A256E94F4C1
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57AF21F211B6
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C807C1494B8;
	Mon, 12 Aug 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nWB9Ww8q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A3187328;
	Mon, 12 Aug 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480443; cv=none; b=D5aAIRMS7wzWc4HDEi+RAbj6PkiahWUivh5shsmbJgZcuZdKxMHp/UO8dusMmlAX/pEQtKjZcGuSmymyBBG6i+NBiK+V3yVZSgXyO4gxSux4IeU3R7nF3SZOlPUBh1XiFPln5DKzQzdGL8Ho7jAadgQWwiO8QULKqVSO5hVBYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480443; c=relaxed/simple;
	bh=E4Li5F5c/dDYYn/LP/ZdOlBKBjjnz/+FxG9TXK95Uok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFR534pE9RQLtXEQBA5EOCjoYzWJtKeVKnn6WB/bxVnBYR1vE33KYe1adGLqQcpoKtoNlY/OWEU2hQF5V+O/CTr/GDiOqLdwZ4ROI+KL+PrCCK+micTuclmxWkeJ93nZmuKj6X24YgkwSfPstxefMpwjXDS31wX6NK2Vj86dU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nWB9Ww8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F99C32782;
	Mon, 12 Aug 2024 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723480443;
	bh=E4Li5F5c/dDYYn/LP/ZdOlBKBjjnz/+FxG9TXK95Uok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWB9Ww8qdf9ylI5W3agRYyQnoHuN6XHUbKFznvEwuGTWGvqWeJYxtEpCxkcYItYR8
	 niYOpmQvVbVlqI+EWbTBWt07RE49kWwz2fWas4/ioqcxJRXL/mI9t6a88RxgWEZmIS
	 RCZOfC1k40JPkByRORNGxRRokTjZf7iMURradgBE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Wang <00107082@163.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yu Liao <liaoyu15@huawei.com>
Subject: [PATCH 6.10 198/263] tick/broadcast: Move per CPU pointer access into the atomic section
Date: Mon, 12 Aug 2024 18:03:19 +0200
Message-ID: <20240812160154.126298173@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
References: <20240812160146.517184156@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 6881e75237a84093d0986f56223db3724619f26e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/tick-broadcast.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1141,7 +1141,6 @@ void tick_broadcast_switch_to_oneshot(vo
 #ifdef CONFIG_HOTPLUG_CPU
 void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 {
-	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 	struct clock_event_device *bc;
 	unsigned long flags;
 
@@ -1167,6 +1166,8 @@ void hotplug_cpu__broadcast_tick_pull(in
 		 * device to avoid the starvation.
 		 */
 		if (tick_check_broadcast_expired()) {
+			struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
+
 			cpumask_clear_cpu(smp_processor_id(), tick_broadcast_force_mask);
 			tick_program_event(td->evtdev->next_event, 1);
 		}



