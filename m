Return-Path: <stable+bounces-192168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A59C2AEE2
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 11:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8011893672
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA522FBE08;
	Mon,  3 Nov 2025 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WDTS+oto";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1jYj1FO"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE5F14A60F;
	Mon,  3 Nov 2025 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164614; cv=none; b=ahAAt0pb5gjWlpeYhY22vyLXPjUO7Ex8NerA6RSDOx28lpZVNrUTWHVV3iQBDl6Np/Bo0kiBWVtJ2mAsvOjO/vH5W7dkg429vC2OJSF12AZGxINGkr5fDC9ItWb4f/K+SmnfJ16oeHt6B1x0bkHQILQg0W55C/C3+oq/xxiB34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164614; c=relaxed/simple;
	bh=V9YvBpMPCeKQCzNbxg+VMyRL1o9qkLYfE8o0iwL3+zc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dlSUYMoiv7kbrbjxoj4i3TqX4aa1nhcAjjw9owKkm75lK19yek4NUr0bSym1mTGFjBH1stjzk0B1roUqeKnnn9Mth5mmJus06rY4z8eKPwQASyQ8V0EhX6smKdJXsQ4FDIGViplOqAnIbDgSOyhFq9TWZ07jXk1dB1byTo7J6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WDTS+oto; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1jYj1FO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 10:10:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762164609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVarb4so6O4MwXTO1StH9mqdDIEJ8bBowHieREy6Bmc=;
	b=WDTS+otoJGs9JUVMwGDiZb4X9t2w66jh27JH1erGHwxnx1wyPzuaO8WSU8l1kZEC5iguiX
	xi4xU2y9Zfde1f+VBvbW/4N+sSouNb5EDUmoHXUF9hlTClTpObqA9+6rbVVe3QfbyhURql
	PXUJAavbS0miXeTsNhM+mbTeA7AORXFGLlbLCkFg4kTfwHcZKXQ67YGf5hFJdjEZWJ9Bau
	/8FMxaTxp7urCpePoW+KMZ46zipujK/rdkCnRIqEUOuy7fKVdvh3kNrhDlU3+CJRamIVhv
	MY87b+wSDItuQPyvifjY/hmgDlS0UefsXRFMRxf+vs6gOfR01LfWxlKVLVujyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762164609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVarb4so6O4MwXTO1StH9mqdDIEJ8bBowHieREy6Bmc=;
	b=c1jYj1FOzfS2Oh+G+d4joM69VSOA1AcsXexEXnMzdyjI8aWvJR8QjHhD1LQK3N0AmfBOIf
	Q/gU3DR1TFTX++BA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/core: Fix system hang caused by cpu-clock usage
Cc: Octavia Togami <octavia.togami@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251015051828.12809-1-dapeng1.mi@linux.intel.com>
References: <20251015051828.12809-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176216460800.2601451.733142302683512228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     eb3182ef0405ff2f6668fd3e5ff9883f60ce8801
Gitweb:        https://git.kernel.org/tip/eb3182ef0405ff2f6668fd3e5ff9883f60c=
e8801
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 15 Oct 2025 13:18:28 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Nov 2025 11:04:19 +01:00

perf/core: Fix system hang caused by cpu-clock usage

cpu-clock usage by the async-profiler tool can trigger a system hang,
which got bisected back to the following commit by Octavia Togami:

  18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage") causes this issue

The root cause of the hang is that cpu-clock is a special type of SW
event which relies on hrtimers. The __perf_event_overflow() callback
is invoked from the hrtimer handler for cpu-clock events, and
__perf_event_overflow() tries to call cpu_clock_event_stop()
to stop the event, which calls htimer_cancel() to cancel the hrtimer.

But that's a recursion into the hrtimer code from a hrtimer handler,
which (unsurprisingly) deadlocks.

To fix this bug, use hrtimer_try_to_cancel() instead, and set
the PERF_HES_STOPPED flag, which causes perf_swevent_hrtimer()
to stop the event once it sees the PERF_HES_STOPPED flag.

[ mingo: Fixed the comments and improved the changelog. ]

Closes: https://lore.kernel.org/all/CAHPNGSQpXEopYreir+uDDEbtXTBvBvi8c6fYXJvc=
eqtgTPao3Q@mail.gmail.com/
Fixes: 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage")
Reported-by: Octavia Togami <octavia.togami@gmail.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Octavia Togami <octavia.togami@gmail.com>
Cc: stable@vger.kernel.org
Link: https://github.com/lucko/spark/issues/530
Link: https://patch.msgid.link/20251015051828.12809-1-dapeng1.mi@linux.intel.=
com
---
 kernel/events/core.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 177e57c..1fd347d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11773,7 +11773,8 @@ static enum hrtimer_restart perf_swevent_hrtimer(stru=
ct hrtimer *hrtimer)
=20
 	event =3D container_of(hrtimer, struct perf_event, hw.hrtimer);
=20
-	if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
+	if (event->state !=3D PERF_EVENT_STATE_ACTIVE ||
+	    event->hw.state & PERF_HES_STOPPED)
 		return HRTIMER_NORESTART;
=20
 	event->pmu->read(event);
@@ -11819,15 +11820,20 @@ static void perf_swevent_cancel_hrtimer(struct perf=
_event *event)
 	struct hw_perf_event *hwc =3D &event->hw;
=20
 	/*
-	 * The throttle can be triggered in the hrtimer handler.
-	 * The HRTIMER_NORESTART should be used to stop the timer,
-	 * rather than hrtimer_cancel(). See perf_swevent_hrtimer()
+	 * Careful: this function can be triggered in the hrtimer handler,
+	 * for cpu-clock events, so hrtimer_cancel() would cause a
+	 * deadlock.
+	 *
+	 * So use hrtimer_try_to_cancel() to try to stop the hrtimer,
+	 * and the cpu-clock handler also sets the PERF_HES_STOPPED flag,
+	 * which guarantees that perf_swevent_hrtimer() will stop the
+	 * hrtimer once it sees the PERF_HES_STOPPED flag.
 	 */
 	if (is_sampling_event(event) && (hwc->interrupts !=3D MAX_INTERRUPTS)) {
 		ktime_t remaining =3D hrtimer_get_remaining(&hwc->hrtimer);
 		local64_set(&hwc->period_left, ktime_to_ns(remaining));
=20
-		hrtimer_cancel(&hwc->hrtimer);
+		hrtimer_try_to_cancel(&hwc->hrtimer);
 	}
 }
=20
@@ -11871,12 +11877,14 @@ static void cpu_clock_event_update(struct perf_even=
t *event)
=20
 static void cpu_clock_event_start(struct perf_event *event, int flags)
 {
+	event->hw.state =3D 0;
 	local64_set(&event->hw.prev_count, local_clock());
 	perf_swevent_start_hrtimer(event);
 }
=20
 static void cpu_clock_event_stop(struct perf_event *event, int flags)
 {
+	event->hw.state =3D PERF_HES_STOPPED;
 	perf_swevent_cancel_hrtimer(event);
 	if (flags & PERF_EF_UPDATE)
 		cpu_clock_event_update(event);
@@ -11950,12 +11958,14 @@ static void task_clock_event_update(struct perf_eve=
nt *event, u64 now)
=20
 static void task_clock_event_start(struct perf_event *event, int flags)
 {
+	event->hw.state =3D 0;
 	local64_set(&event->hw.prev_count, event->ctx->time);
 	perf_swevent_start_hrtimer(event);
 }
=20
 static void task_clock_event_stop(struct perf_event *event, int flags)
 {
+	event->hw.state =3D PERF_HES_STOPPED;
 	perf_swevent_cancel_hrtimer(event);
 	if (flags & PERF_EF_UPDATE)
 		task_clock_event_update(event, event->ctx->time);

