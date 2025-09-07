Return-Path: <stable+bounces-178814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6FDB48103
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 00:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2815F4E1489
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072BA221546;
	Sun,  7 Sep 2025 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQCKUSBv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5F7E107
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757283935; cv=none; b=VQ7P3vCauWc1lV3YG/o9LMN2+lxX00wyWWRPm/nwsqCG++15aNWF4sO43XiTLMMLPsjESl3SRLy0tfMKMq9njh5XGWQGBTpsq4s7uUVigMIx/GxSgjEVjxmKJw2U4vzdKl5Gx3Owp0SVFARGOkJA330vDL7UxXK9ougXB1V1TbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757283935; c=relaxed/simple;
	bh=yLyVxa55Zo5qEB405XWXc94a82DqtQFrSWc0PVC5Q9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=km70pOP2AI2mVW3m7jZy0YfXCiETCpIYBxw/TPAyIDGfBE3RpxsLc/FPu0nURNZ4mx5BllYTriQs90RgGsAdKLUIZ5fDMEFzXcrw2ZrI/Q8vRfpISNdZVY2d9wC0vnLnDE9eThz1l91DRWj6H/1F2PIgC3kLgIij+6CEzWjrXhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQCKUSBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F48C4CEF0;
	Sun,  7 Sep 2025 22:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757283935;
	bh=yLyVxa55Zo5qEB405XWXc94a82DqtQFrSWc0PVC5Q9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQCKUSBvZ40D4JktKdAfMqmaP6jk190EjoOzab18q6KRAaYX8TTUeyYb75p6ICWG1
	 zuWffLQVyXTZxtlcpjwxTqI9E5oH1Ij2T7Qc6tzVcmvvtksZ02NLJnxVNRBaAVVWzM
	 jI9ahKroCRdLns9I20k/RZq1wJKtoUU9DuuGP7CUG5vuHRyHNELf4ZTvOAm/pPQrpM
	 /glEHWa+8j0hktsRJQZkyiyWKzGn6FHiwRS6WoTXFPPA6sHmxpVmH1aOi1+a8Pugk2
	 ewrzlfd9ykEqt4oGjoGrIU6k9oPQ4TciLQ+XAYmTlie6wAcwQgw1pZIYytYGyRzIRK
	 Ge/2fRVG4Al0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	Douglas Raillard <douglas.raillard@arm.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] tracing: Do not add length to print format in synthetic events
Date: Sun,  7 Sep 2025 18:25:32 -0400
Message-ID: <20250907222532.932220-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041706-ambiance-zen-5f4e@gregkh>
References: <2025041706-ambiance-zen-5f4e@gregkh>
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
index 385e9fbbfbe7c..c2817d0c05b69 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -383,13 +383,11 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
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


