Return-Path: <stable+bounces-72709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E998A9683FD
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 12:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BB41C21E64
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 10:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DA413D52B;
	Mon,  2 Sep 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F8UgvejB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gGdrrhe+"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E194D13B580;
	Mon,  2 Sep 2024 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271364; cv=none; b=ZV+cm9Avo/Xl63r8sQ/HMbTfuYnoOHdGa+0PXu4/gjh0VtEoAn9VNKVD2jvAK8YOt1CTkVVGkxV6VdwXo8mHPCH8xNMoFRkmuc+xCfoiwOUbTYI+9EnU7eHVWgTPcEjqHOtaCoE+ann6MzV+WYIlrLHs6PYdDproxvDPUAHy1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271364; c=relaxed/simple;
	bh=7JLEJZTdBsyFoOBy5JIKt7d79I8IhsJr/X8vHcxNdkI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PK1qUuHyZhsMSYZxoPKZx2nB5OC+6LpJgqMuJdTnUeXPRg3XFHv2ygHcQRqFjAIZZ7fWegIz6TsWfGXpwTQKlXw6VTSVHI2a9tKFfwftvaZffuqOjTbOHW+KxX6XftLmizNuPVsB4DK9Zx6jBxlA6XXGUuU62aVtE+e/9ujIm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F8UgvejB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gGdrrhe+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Sep 2024 10:02:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725271360;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWxWM1rvb9drwc6Jn35tWXvtOBsNmJMFupZthmoEf20=;
	b=F8UgvejBJN+nybNZ2/l/XtTXlh4VEGVCErxjIVzf+SHMrgD5+yQ/JQ0k/S1Y8qhwaMtBmM
	1tLGp4DRNmDjV+1AqAscha3mKqhZ1c/uvhRX2ggfLuRq/0TqF4Gb/ZDfd+hKct/Mt2BsiF
	g7f9baLo9WGAKXCwo2pcF7wjs9i0Dbw7vzCOcXiO9dgWKpSitQy2bj2P+sKOmi6mq/uZl0
	BxJzoN7Ico+syncc5J9ohyXULVgkgi3S0LBhXaJINGeLDUOSTW+13qSIo+KNyO9qcd3CHc
	WSFl/+DyO2hjxxxrCQPztEBXjXwEtoU3We42IDNdDJxECmdfhV0Qq1dANa8HPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725271360;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWxWM1rvb9drwc6Jn35tWXvtOBsNmJMFupZthmoEf20=;
	b=gGdrrhe+GX59qzCYR0A0MbK+mpDY9QvyYgEE+LtU4005P6yvi7o1NZckTUd1wZ+ieme7zB
	I4HSkth/ciD5otDw==
From: "tip-bot2 for Jacky Bai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/imx-tpm: Fix return -ETIME
 when delta exceeds INT_MAX
Cc: stable@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jason Liu <jason.hui.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240725193355.1436005-1-Frank.Li@nxp.com>
References: <20240725193355.1436005-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172527135997.2215.1173075166097988868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     5b8843fcd49827813da80c0f590a17ae4ce93c5d
Gitweb:        https://git.kernel.org/tip/5b8843fcd49827813da80c0f590a17ae4ce93c5d
Author:        Jacky Bai <ping.bai@nxp.com>
AuthorDate:    Thu, 25 Jul 2024 15:33:54 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 02 Sep 2024 10:04:15 +02:00

clocksource/drivers/imx-tpm: Fix return -ETIME when delta exceeds INT_MAX

In tpm_set_next_event(delta), return -ETIME by wrong cast to int when delta
is larger than INT_MAX.

For example:

tpm_set_next_event(delta = 0xffff_fffe)
{
        ...
        next = tpm_read_counter(); // assume next is 0x10
        next += delta; // next will 0xffff_fffe + 0x10 = 0x1_0000_000e
        now = tpm_read_counter();  // now is 0x10
        ...

        return (int)(next - now) <= 0 ? -ETIME : 0;
                     ^^^^^^^^^^
                     0x1_0000_000e - 0x10 = 0xffff_fffe, which is -2 when
                     cast to int. So return -ETIME.
}

To fix this, introduce a 'prev' variable and check if 'now - prev' is
larger than delta.

Cc: stable@vger.kernel.org
Fixes: 059ab7b82eec ("clocksource/drivers/imx-tpm: Add imx tpm timer support")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20240725193355.1436005-1-Frank.Li@nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-tpm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index bd64a8a..cd23caf 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -83,10 +83,10 @@ static u64 notrace tpm_read_sched_clock(void)
 static int tpm_set_next_event(unsigned long delta,
 				struct clock_event_device *evt)
 {
-	unsigned long next, now;
+	unsigned long next, prev, now;
 
-	next = tpm_read_counter();
-	next += delta;
+	prev = tpm_read_counter();
+	next = prev + delta;
 	writel(next, timer_base + TPM_C0V);
 	now = tpm_read_counter();
 
@@ -96,7 +96,7 @@ static int tpm_set_next_event(unsigned long delta,
 	 * of writing CNT registers which may cause the min_delta event got
 	 * missed, so we need add a ETIME check here in case it happened.
 	 */
-	return (int)(next - now) <= 0 ? -ETIME : 0;
+	return (now - prev) >= delta ? -ETIME : 0;
 }
 
 static int tpm_set_state_oneshot(struct clock_event_device *evt)

