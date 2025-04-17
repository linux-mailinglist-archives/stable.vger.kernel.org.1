Return-Path: <stable+bounces-133084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007B4A91C31
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609C419E5126
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5148624168C;
	Thu, 17 Apr 2025 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jmO3hbbW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1164E248193
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892865; cv=none; b=VVXZxXa2/2T6jCPUcy8l9OIVCbxo7bZ25rES8v9/nUs8J5Pc5XXEfBAWyAY99MVxfaigmNeheK3N4t8j3veZnWtt6y9sb6BNU+jb6UnUDsMQDE/59QatG1IWg5sSETnq1X/N/BbawwP1W2ybtnMnzS6XmPatf38436N10F1nEIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892865; c=relaxed/simple;
	bh=78nI6pp2XX8HLnT26eOrtpfSB6uX1VHUubTSTIWOqWY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Fj2rJLfYbSZPRceWURIRc8gL0pryDnx6Y6+mT5EQ25q3d/Ve0jsDp0aAwRJifBV4dVNUs/mBDil0D28yv0S922CZd0F9wnalnBmORZBO7CIq7eT2F02CTrxMq46tDxf+j9/Deu0y+Mw3KGeRGCYXlyPMNW9yMBNt0DMzDau58p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jmO3hbbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8509CC4CEE4;
	Thu, 17 Apr 2025 12:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744892864;
	bh=78nI6pp2XX8HLnT26eOrtpfSB6uX1VHUubTSTIWOqWY=;
	h=Subject:To:Cc:From:Date:From;
	b=jmO3hbbWUVPUKz/t8Ah/L5I6S3RIGB86bfnu/2rCFPdSzaQ+gOQ3+DnjEShyz4dYF
	 k3mXYek31+DDa6cwvsaBdr1thX3AcWVSNLDflnVEM5qbKRkPco801M3z5FJkNM0tIs
	 FKofutxpLq8ytc/GVt7Oma+9P8hYy1wU6kyL7BBI=
Subject: FAILED: patch "[PATCH] tracing: Do not add length to print format in synthetic" failed to apply to 5.15-stable tree
To: rostedt@goodmis.org,douglas.raillard@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,zanussi@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 14:26:10 +0200
Message-ID: <2025041710-herald-hardwood-63d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e1a453a57bc76be678bd746f84e3d73f378a9511
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041710-herald-hardwood-63d1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e1a453a57bc76be678bd746f84e3d73f378a9511 Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 7 Apr 2025 15:41:39 -0400
Subject: [PATCH] tracing: Do not add length to print format in synthetic
 events

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

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 969f48742d72..33cfbd4ed76d 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -370,7 +370,6 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 				union trace_synth_field *data = &entry->fields[n_u64];
 
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
-						 STR_VAR_LEN_MAX,
 						 (char *)entry + data->as_dynamic.offset,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64++;


