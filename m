Return-Path: <stable+bounces-220429-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNt+JtQ6o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220429-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:58:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA3F1C6789
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A95F5321338F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21F83B2B90;
	Sat, 28 Feb 2026 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prrriFa0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725FB3B343E;
	Sat, 28 Feb 2026 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300319; cv=none; b=Bw8q+Uc+O6w3OhaVf9OLg4YSwDjKV790meeVFG+xdSFPfTauvv96m38P8yb1yswqNtO2OBVqxsjeS71+bKhKpxgaXcSGklHxm7+q7VZwhrjLlSWsMP9d+KUvjudKozCG7UAkdrq0KoxjCarowG0ML2rrUHI66XXyrYLhUajnJbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300319; c=relaxed/simple;
	bh=eJSxD8m6JPX70xqr8kY9rAV2Of6LboOOQtQM4nRT1nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccFBsIYN/tFNL2mv431XOD5rD5YL2+hwo0aZs9LFiFraOiLRZSLvakRiycfu0+P4S1lFg1OfAwXL0vdvTDJahXRPI7uKc/c8ZbxWAJ5Bjo0IL2eJlW5toGOakn64LrH47UIS3Bs+GpHYqqmx8iOZzF8+73xtPFBlSgyOxCTzlTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prrriFa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B51C19425;
	Sat, 28 Feb 2026 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300319;
	bh=eJSxD8m6JPX70xqr8kY9rAV2Of6LboOOQtQM4nRT1nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=prrriFa0JHmcox3R0ZrqsZ4G4xWc8Jx1BL7wzjAbbtog7IgSYVvwiiHaxAv3tVUKu
	 6D8Oqr2J/aM0bRwUKLTeE2SB9ZOrv7YZS2zllQHyAiO4szhXni8I4afxPSIKCBPpwO
	 yHt5UrpPEgXVJuX8iZleVnQJAQPbrYL6ZoFJH8HCnZj/Qpv/+5ZZQ1SBeHUkHhorIj
	 lUVytm6Xh11QMsuH1pzfzHUxykX/OsCyEKC3qPHmXfjkUkwlHb3mplvBqV8NHD2Mop
	 3GvF0FwT3kxBQFEm8waWryexF2p6gxXzl1pDn63aE/2pdOOEWu3jyEgyvG3ntB57Wx
	 tANewmctiChNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Colin Lord <clord@mykolab.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 350/844] tracing: Fix false sharing in hwlat get_sample()
Date: Sat, 28 Feb 2026 12:24:23 -0500
Message-ID: <20260228173244.1509663-351-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220429-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,efficios.com:email,mykolab.com:email,msgid.link:url,goodmis.org:email]
X-Rspamd-Queue-Id: DEA3F1C6789
X-Rspamd-Action: no action

From: Colin Lord <clord@mykolab.com>

[ Upstream commit f743435f988cb0cf1f521035aee857851b25e06d ]

The get_sample() function in the hwlat tracer assumes the caller holds
hwlat_data.lock, but this is not actually happening. The result is
unprotected data access to hwlat_data, and in per-cpu mode can result in
false sharing which may show up as false positive latency events.

The specific case of false sharing observed was primarily between
hwlat_data.sample_width and hwlat_data.count. These are separated by
just 8B and are therefore likely to share a cache line. When one thread
modifies count, the cache line is in a modified state so when other
threads read sample_width in the main latency detection loop, they fetch
the modified cache line. On some systems, the fetch itself may be slow
enough to count as a latency event, which could set up a self
reinforcing cycle of latency events as each event increments count which
then causes more latency events, continuing the cycle.

The other result of the unprotected data access is that hwlat_data.count
can end up with duplicate or missed values, which was observed on some
systems in testing.

Convert hwlat_data.count to atomic64_t so it can be safely modified
without locking, and prevent false sharing by pulling sample_width into
a local variable.

One system this was tested on was a dual socket server with 32 CPUs on
each numa node. With settings of 1us threshold, 1000us width, and
2000us window, this change reduced the number of latency events from
500 per second down to approximately 1 event per minute. Some machines
tested did not exhibit measurable latency from the false sharing.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20260210074810.6328-1-clord@mykolab.com
Signed-off-by: Colin Lord <clord@mykolab.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_hwlat.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 2f7b94e98317c..3fe274b84f1c2 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -102,9 +102,9 @@ struct hwlat_sample {
 /* keep the global state somewhere. */
 static struct hwlat_data {
 
-	struct mutex lock;		/* protect changes */
+	struct mutex	lock;		/* protect changes */
 
-	u64	count;			/* total since reset */
+	atomic64_t	count;		/* total since reset */
 
 	u64	sample_window;		/* total sampling window (on+off) */
 	u64	sample_width;		/* active sampling portion of window */
@@ -193,8 +193,7 @@ void trace_hwlat_callback(bool enter)
  * get_sample - sample the CPU TSC and look for likely hardware latencies
  *
  * Used to repeatedly capture the CPU TSC (or similar), looking for potential
- * hardware-induced latency. Called with interrupts disabled and with
- * hwlat_data.lock held.
+ * hardware-induced latency. Called with interrupts disabled.
  */
 static int get_sample(void)
 {
@@ -204,6 +203,7 @@ static int get_sample(void)
 	time_type start, t1, t2, last_t2;
 	s64 diff, outer_diff, total, last_total = 0;
 	u64 sample = 0;
+	u64 sample_width = READ_ONCE(hwlat_data.sample_width);
 	u64 thresh = tracing_thresh;
 	u64 outer_sample = 0;
 	int ret = -1;
@@ -267,7 +267,7 @@ static int get_sample(void)
 		if (diff > sample)
 			sample = diff; /* only want highest value */
 
-	} while (total <= hwlat_data.sample_width);
+	} while (total <= sample_width);
 
 	barrier(); /* finish the above in the view for NMIs */
 	trace_hwlat_callback_enabled = false;
@@ -285,8 +285,7 @@ static int get_sample(void)
 		if (kdata->nmi_total_ts)
 			do_div(kdata->nmi_total_ts, NSEC_PER_USEC);
 
-		hwlat_data.count++;
-		s.seqnum = hwlat_data.count;
+		s.seqnum = atomic64_inc_return(&hwlat_data.count);
 		s.duration = sample;
 		s.outer_duration = outer_sample;
 		s.nmi_total_ts = kdata->nmi_total_ts;
@@ -832,7 +831,7 @@ static int hwlat_tracer_init(struct trace_array *tr)
 
 	hwlat_trace = tr;
 
-	hwlat_data.count = 0;
+	atomic64_set(&hwlat_data.count, 0);
 	tr->max_latency = 0;
 	save_tracing_thresh = tracing_thresh;
 
-- 
2.51.0


