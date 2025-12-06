Return-Path: <stable+bounces-200214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1139CA9CE8
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 02:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E477E30573A1
	for <lists+stable@lfdr.de>; Sat,  6 Dec 2025 01:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4A023BCED;
	Sat,  6 Dec 2025 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVKTJc7t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6BC21CC68;
	Sat,  6 Dec 2025 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764983152; cv=none; b=k1ks5wRQPtaadjPv9ibnhdQ+2+xu8FooWiei0DJb59xk9nFH8ZDKtacLl/9YBfYGvIzPekskgNTkgKEs1f5FY9BpQ7jNDxgcF9bd9/DzruOcRd2Zjf0OWJrEr3raBGJEoObZgCMZobdKuYeICHecTdAnjMDU7f95A1eLFct0qC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764983152; c=relaxed/simple;
	bh=XziP3BZvKCUwzNrgPVp+a4VK1kBazIplv/7b3TjByT0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dQ9bFI08d+H3YrbsDZUb35OPP70Q8U1e6KIkPezV/ZN7vc6T2ue0/dW5/nZ3VkIFtSGPu/mvlEWRBzA0Wa+vU5PgpiXyuRX6WTivYPLZmzybl2AEza9tVToHrOpKcjEBuUV9nsNAw+dhMPqAVQ1pVYHj1+lNIFYlBbaRpWMukdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVKTJc7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878A3C19421;
	Sat,  6 Dec 2025 01:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764983152;
	bh=XziP3BZvKCUwzNrgPVp+a4VK1kBazIplv/7b3TjByT0=;
	h=Date:From:To:Cc:Subject:References:From;
	b=TVKTJc7tS1LNfRyV3wB1vRszmFyK1qX8KnEfHi03XeKM0ZmkP1Gy/pjVHDHpUxiFi
	 0vwqee4TWk+WpsByfkjDwPMsIeAfv0Vlx62yYeDZwTIAqEV0ItQnAikLNjUllMdFf6
	 g8jncTAJy5Qjg2A/sFzr+e5hIRSorVlgtqGiwLnu1xu3Q3WxnXE6ln5MGoNRXJOqaa
	 iwOMVqM+3jiQnhDDaAMKZpUOl0+5r0xrVVrP6PAWzOZB14QpXKQqgubrwD2q6sNuLU
	 +V8hqrriAl4Lz7JNqLDomYdkcBrk4baSUDkNyVKmsn3r8l0P3hVdUgGNwrj6lBX6mg
	 0plsdi4joMjtQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vRglJ-00000009Vlx-0XCw;
	Fri, 05 Dec 2025 20:07:01 -0500
Message-ID: <20251206010700.980966840@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 05 Dec 2025 20:06:35 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [for-linus][PATCH 02/15] tracing: Fix fixed array of synthetic event
References: <20251206010633.884804695@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The commit 4d38328eb442d ("tracing: Fix synth event printk format for str
fields") replaced "%.*s" with "%s" but missed removing the number size of
the dynamic and static strings. The commit e1a453a57bc7 ("tracing: Do not
add length to print format in synthetic events") fixed the dynamic part
but did not fix the static part. That is, with the commands:

  # echo 's:wake_lat char[] wakee; u64 delta;' >> /sys/kernel/tracing/dynamic_events
  # echo 'hist:keys=pid:ts=common_timestamp.usecs if !(common_flags & 0x18)' > /sys/kernel/tracing/events/sched/sched_waking/trigger
  # echo 'hist:keys=next_pid:delta=common_timestamp.usecs-$ts:onmatch(sched.sched_waking).trace(wake_lat,next_comm,$delta)' > /sys/kernel/tracing/events/sched/sched_switch/trigger

That caused the output of:

          <idle>-0       [001] d..5.   193.428167: wake_lat: wakee=(efault)sshd-sessiondelta=155
    sshd-session-879     [001] d..5.   193.811080: wake_lat: wakee=(efault)kworker/u34:5delta=58
          <idle>-0       [002] d..5.   193.811198: wake_lat: wakee=(efault)bashdelta=91

The commit e1a453a57bc7 fixed the part where the synthetic event had
"char[] wakee". But if one were to replace that with a static size string:

  # echo 's:wake_lat char[16] wakee; u64 delta;' >> /sys/kernel/tracing/dynamic_events

Where "wakee" is defined as "char[16]" and not "char[]" making it a static
size, the code triggered the "(efaul)" again.

Remove the added STR_VAR_LEN_MAX size as the string is still going to be
nul terminated.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Douglas Raillard <douglas.raillard@arm.com>
Link: https://patch.msgid.link/20251204151935.5fa30355@gandalf.local.home
Fixes: e1a453a57bc7 ("tracing: Do not add length to print format in synthetic events")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 2f19bbe73d27..4554c458b78c 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -375,7 +375,6 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 				n_u64++;
 			} else {
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
-						 STR_VAR_LEN_MAX,
 						 (char *)&entry->fields[n_u64].as_u64,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
-- 
2.51.0



