Return-Path: <stable+bounces-203658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66562CE7436
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CD1F30141F6
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D8E2C08C2;
	Mon, 29 Dec 2025 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MSJc+ngX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FF7261B9F
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023625; cv=none; b=B++nEC1ar4wFFZav79+HS3TSp/i2jmr3TBK6aAySmqbZAOrEKbP8SZX6uvvZHoQmKA01ZEiDGS1onmOkUHmAepJdFYtmBnUHeNyXPrOqFLFKPzWSY7FLRjx2JTa76YT6fgsezS/JazP0CdlJ6iVlKn2NDxW+djxswbbRZZWV5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023625; c=relaxed/simple;
	bh=GUtjWINYL/fA6hzcMPB3Owj8vdyBsy/zHtihHeHWryA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UPv3byddkx4mOPR6CqEwibgLVdAW40LCj+r2KKEIAMFcbG38mDTa4Z6ZGTWE2XkAGk3KV51NCM+YuDZ0K5aK8NZjGIhCinHfySvDALxBMhtYPPq8KuF/89ZaWxP/nDIZUlFvmECfCzG740I4+4JOii1wXjXT+arkhgz1o2V/TwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MSJc+ngX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F094C4CEF7;
	Mon, 29 Dec 2025 15:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767023624;
	bh=GUtjWINYL/fA6hzcMPB3Owj8vdyBsy/zHtihHeHWryA=;
	h=Subject:To:Cc:From:Date:From;
	b=MSJc+ngXAVmk56g3c7EKuG8I+NEmPoAQYWU5X3N1OBDEufZhlH50S2lIs3unU0zvk
	 c/7QtFlsjoFd+d45CP9kpn3esLf5pXxuR/V5khBPtHDvePfbx/d2dchNujNH3S3u5F
	 WvK2E7cB59pDStFD4T8OYS1pyf85LQuRUTkpuCiA=
Subject: FAILED: patch "[PATCH] tracing: Fix fixed array of synthetic event" failed to apply to 6.1-stable tree
To: rostedt@goodmis.org,douglas.raillard@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 16:53:41 +0100
Message-ID: <2025122941-citric-sushi-4f65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 47ef834209e5981f443240d8a8b45bf680df22aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122941-citric-sushi-4f65@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47ef834209e5981f443240d8a8b45bf680df22aa Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 4 Dec 2025 15:19:35 -0500
Subject: [PATCH] tracing: Fix fixed array of synthetic event

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


