Return-Path: <stable+bounces-178819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8020CB481B3
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 02:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3409017A73F
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 00:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79A71369B4;
	Mon,  8 Sep 2025 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7siQeps"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6D2110
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757291004; cv=none; b=kpiKsQieHSrmt/mY531xTsjz5v5cO+/AysGxb0Ho0oCq7Hov43fuRV6QIi1QxM3wdc6nsxoZKMkNE8ScGGubUcbGNUZ8iFU6nzwiHm4ucqtqteM3i11LHCqSym4ciyLM0muvvtiBHw2t0jZBiFOYAV2/H8nQnXSKN1zSNmM4+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757291004; c=relaxed/simple;
	bh=ofkxrUMOoukMAjGb1GpwCj33riTMAfqrbd2xGSYNVCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIIhbYQ5Pzq7qYTif0hF7dW5JjU/QLkh6BNGAOGBTFVjWYZNhwwbKiydSg29VhpLXcs7oaBJEoBJL9oRuNd0TIVJ6sm7uof02crQRbV7eaf0BTYsFW43ibawawYsGL3lzbpMQ6fdMLvMaaeiva8gR0fsGF2uYbrz/SK3YjW50k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7siQeps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FDEC4CEF1;
	Mon,  8 Sep 2025 00:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757291004;
	bh=ofkxrUMOoukMAjGb1GpwCj33riTMAfqrbd2xGSYNVCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7siQepsDZdETIC0BnAAvnNEwdxESnADLfNqwYARGHe07HannsQcu///rmamRVzMi
	 70cQQQNbzNsMosgiU9ky1gmeL75ENW14Y9ESsenIr/YzJwnSKKAAd4KjMMWza3TExK
	 IWYjlePN+3DjXw/1uwHw1+PdWdWpe/U04onubHeZxvQzNPoSZRrScDe6WGtZoPoP3i
	 HNJRjB4CwmLeGG43EwCcFQQ5//UBR0XPKsNEKK7OTnvL2kujuIAGID+og7fG4AmoRp
	 gOl5egX/aHBwtkClxugMHr3kT1t57ORhQ7RFsN/dqQss9nawIKVQWalGqazZ9Gd0KL
	 yKgp4EIR3KbYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	Douglas Raillard <douglas.raillard@arm.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tracing: Do not add length to print format in synthetic events
Date: Sun,  7 Sep 2025 20:23:21 -0400
Message-ID: <20250908002321.961475-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041710-herald-hardwood-63d1@gregkh>
References: <2025041710-herald-hardwood-63d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit e1a453a57bc76be678bd746f84e3d73f378a9511 ]

The following causes a vsnprintf fault:

  # echo 's:wake_lat char[] wakee; u64 delta;' >> /sys/kernel/tracing/dynamic_events
  # echo 'hist:keys=pid:ts=common_timestamp.usecs if !(common_flags & 0x18)' > /sys/kernel/tracing/events/sched/sched_waking/trigger
  # echo 'hist:keys=next_pid:delta=common_timestamp.usecs-$ts:onmatch(sched.sched_waking).trace(wake_lat,next_comm,$delta)' > /sys/kernel/tracing/events/sched/sched_switch/trigger

Because the synthetic event's "wakee" field is created as a dynamic string
(even though the string copied is not). The print format to print the
dynamic string changed from "%*s" to "%s" because another location
(__set_synth_event_print_fmt()) exported this to user space, and user
space did not need that. But it is still used in print_synth_event(), and
the output looks like:

          <idle>-0       [001] d..5.   193.428167: wake_lat: wakee=(efault)sshd-sessiondelta=155
    sshd-session-879     [001] d..5.   193.811080: wake_lat: wakee=(efault)kworker/u34:5delta=58
          <idle>-0       [002] d..5.   193.811198: wake_lat: wakee=(efault)bashdelta=91
            bash-880     [002] d..5.   193.811371: wake_lat: wakee=(efault)kworker/u35:2delta=21
          <idle>-0       [001] d..5.   193.811516: wake_lat: wakee=(efault)sshd-sessiondelta=129
    sshd-session-879     [001] d..5.   193.967576: wake_lat: wakee=(efault)kworker/u34:5delta=50

The length isn't needed as the string is always nul terminated. Just print
the string and not add the length (which was hard coded to the max string
length anyway).

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Douglas Raillard <douglas.raillard@arm.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/20250407154139.69955768@gandalf.local.home
Fixes: 4d38328eb442d ("tracing: Fix synth event printk format for str fields");
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
[ offset calculations instead of union-based data structures ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_synth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index ab54810bd8d99..62d146254f470 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -364,13 +364,11 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 				str_field = (char *)entry + data_offset;
 
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
-						 STR_VAR_LEN_MAX,
 						 str_field,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64++;
 			} else {
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
-						 STR_VAR_LEN_MAX,
 						 (char *)&entry->fields[n_u64],
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
-- 
2.51.0


