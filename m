Return-Path: <stable+bounces-202991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B889ACCC211
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 14:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 965013048D56
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420B0345731;
	Thu, 18 Dec 2025 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd8tgZkt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC8B3451DB;
	Thu, 18 Dec 2025 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066019; cv=none; b=ApC0WZWw3x2TRXwKF9JdQ2FmYo0PeXLXKS6i5WV5fFc4G4mQrPxxaG8UaGWvlU1AH7X1UsTlv5WTc2GGEj6nJjq1VwjIR54eg0qqp7Iu2KHbfC8p4qImF6+yo8iQd0knesAjPQHBcnLolYKeFwiDicq8a+0/K+TbpjqLgN38i3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066019; c=relaxed/simple;
	bh=/eiW+1iP3cjjvkC7U5SzOqVLF6O6+71Wi1CUP+IL8dk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dYmOEX3xFgGtJhYZGfWz9kZeXtlBQdM1HnYH/LaHxMnw2AqGYQ8oCITm/kWmnADm3wv4/HhEvTYf4J6Uu0ZJHZ2PJQ8mvCjVeKAB344KGAy/V1GVNpd3Ug7ZusYgLkYwhN+zj5SeKIn6bvHYq3pk2DLCLK1fWAi9ysEhNioKrYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd8tgZkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FD0C19421;
	Thu, 18 Dec 2025 13:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766066018;
	bh=/eiW+1iP3cjjvkC7U5SzOqVLF6O6+71Wi1CUP+IL8dk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Wd8tgZkt+d5N2E8oBx9cmrl9rXEhHmI7X+uRvix98E5iuTg51QHeek/indsMI5fH+
	 C3QtCp0TXfSPTalKZzlvZppuWRhcJsQ4/i8eeJgP0nPXfaLzApCFmL9HcZ7wPbGF8J
	 kcPmPvlg0EafLMPSaPtjMyi6qY9cV3A1aBeSENlpNwi5Ic32jeGsR/6xQTmrm8CWhJ
	 UZia/rBcMAcZA7gEC7q6bEsAQROhGDi8H9rmoiri4GZd6ySFHLFjTT8t2T2+FRpfmb
	 jRm7HjZJ6jjxuIFM+PwmyCnB6YAkfiqc6kOsTaksP/WMdwmh6x9A2vM2kRyxFdvw0O
	 6d/9jtLyapoXA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vWETN-0000000Auxd-1NKk;
	Thu, 18 Dec 2025 08:55:17 -0500
Message-ID: <20251218135517.182085932@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 18 Dec 2025 08:55:06 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>
Subject: [for-linus][PATCH 2/4] tracing: Do not register unsupported perf events
References: <20251218135504.301981830@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Synthetic events currently do not have a function to register perf events.
This leads to calling the tracepoint register functions with a NULL
function pointer which triggers:

 ------------[ cut here ]------------
 WARNING: kernel/tracepoint.c:175 at tracepoint_add_func+0x357/0x370, CPU#2: perf/2272
 Modules linked in: kvm_intel kvm irqbypass
 CPU: 2 UID: 0 PID: 2272 Comm: perf Not tainted 6.18.0-ftest-11964-ge022764176fc-dirty #323 PREEMPTLAZY
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
 RIP: 0010:tracepoint_add_func+0x357/0x370
 Code: 28 9c e8 4c 0b f5 ff eb 0f 4c 89 f7 48 c7 c6 80 4d 28 9c e8 ab 89 f4 ff 31 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc <0f> 0b 49 c7 c6 ea ff ff ff e9 ee fe ff ff 0f 0b e9 f9 fe ff ff 0f
 RSP: 0018:ffffabc0c44d3c40 EFLAGS: 00010246
 RAX: 0000000000000001 RBX: ffff9380aa9e4060 RCX: 0000000000000000
 RDX: 000000000000000a RSI: ffffffff9e1d4a98 RDI: ffff937fcf5fd6c8
 RBP: 0000000000000001 R08: 0000000000000007 R09: ffff937fcf5fc780
 R10: 0000000000000003 R11: ffffffff9c193910 R12: 000000000000000a
 R13: ffffffff9e1e5888 R14: 0000000000000000 R15: ffffabc0c44d3c78
 FS:  00007f6202f5f340(0000) GS:ffff93819f00f000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055d3162281a8 CR3: 0000000106a56003 CR4: 0000000000172ef0
 Call Trace:
  <TASK>
  tracepoint_probe_register+0x5d/0x90
  synth_event_reg+0x3c/0x60
  perf_trace_event_init+0x204/0x340
  perf_trace_init+0x85/0xd0
  perf_tp_event_init+0x2e/0x50
  perf_try_init_event+0x6f/0x230
  ? perf_event_alloc+0x4bb/0xdc0
  perf_event_alloc+0x65a/0xdc0
  __se_sys_perf_event_open+0x290/0x9f0
  do_syscall_64+0x93/0x7b0
  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
  ? trace_hardirqs_off+0x53/0xc0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Instead, have the code return -ENODEV, which doesn't warn and has perf
error out with:

 # perf record -e synthetic:futex_wait
Error:
The sys_perf_event_open() syscall returned with 19 (No such device) for event (synthetic:futex_wait).
"dmesg | grep -i perf" may provide additional information.

Ideally perf should support synthetic events, but for now just fix the
warning. The support can come later.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://patch.msgid.link/20251216182440.147e4453@gandalf.local.home
Fixes: 4b147936fa509 ("tracing: Add support for 'synthetic' events")
Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index b16a5a158040..76067529db61 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -700,6 +700,8 @@ int trace_event_reg(struct trace_event_call *call,
 
 #ifdef CONFIG_PERF_EVENTS
 	case TRACE_REG_PERF_REGISTER:
+		if (!call->class->perf_probe)
+			return -ENODEV;
 		return tracepoint_probe_register(call->tp,
 						 call->class->perf_probe,
 						 call);
-- 
2.51.0



