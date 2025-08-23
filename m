Return-Path: <stable+bounces-172620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D2BB329CB
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403BC188542E
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1188E2E8DE0;
	Sat, 23 Aug 2025 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sl9DFtyk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46EF22097
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963878; cv=none; b=mBSVwaEGkanf92Cc1qYCp0dy18vWFvp05Jn4/27PooRZNElFmw/ldbKePyAaqc87ln1jaRbL5G7X5jTPxUo74yzoydBNLjo9TNXhTLAT0vNgEhyrp4TwkhfEJp+tPYG1niDJpLU6MtFV7F0KkCR6vDklMs0jYhLwVjlv+19t3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963878; c=relaxed/simple;
	bh=/AyRhmvguqED8IZcrOeam98rr7qOW3UdJGclGXZ2fiM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mKn85NGa1uMkRvBick+7IB3LmtQ6lgMRCfFxLPHDP4ch7vAugJR0f5oeN9EmSChMTS3I6n1kui6VzS7KPW0vbVqm3hMOixyLXRipviaFj+wZL4Yt21r1o/nqdt8/wUvi8m4KBNxWrPgZvcbGIO/TpBy4faNXecSMQIkeGKjHE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sl9DFtyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF87FC4CEF4;
	Sat, 23 Aug 2025 15:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755963878;
	bh=/AyRhmvguqED8IZcrOeam98rr7qOW3UdJGclGXZ2fiM=;
	h=Subject:To:Cc:From:Date:From;
	b=Sl9DFtykuvs/LURNhc07IT3af6T82o/E1OX345A2+3fmWSd+yy8gJlOt5pRpNE7gY
	 1TYrdAugIxtrqgU9WpXgqIQaGmi9RC+jXzW8zOAWRz45xiaAmFPirXyFBFlFzgVQ0s
	 AyXO94SN1i3JhxqpDlYOXr7S0qHf2i//IwtnVsKY=
Subject: FAILED: patch "[PATCH] tracing: Limit access to parser->buffer when trace_get_user" failed to apply to 6.12-stable tree
To: pulehui@huawei.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 17:44:30 +0200
Message-ID: <2025082330-tameness-senator-c4d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6a909ea83f226803ea0e718f6e88613df9234d58
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082330-tameness-senator-c4d5@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a909ea83f226803ea0e718f6e88613df9234d58 Mon Sep 17 00:00:00 2001
From: Pu Lehui <pulehui@huawei.com>
Date: Wed, 13 Aug 2025 04:02:32 +0000
Subject: [PATCH] tracing: Limit access to parser->buffer when trace_get_user
 failed

When the length of the string written to set_ftrace_filter exceeds
FTRACE_BUFF_MAX, the following KASAN alarm will be triggered:

BUG: KASAN: slab-out-of-bounds in strsep+0x18c/0x1b0
Read of size 1 at addr ffff0000d00bd5ba by task ash/165

CPU: 1 UID: 0 PID: 165 Comm: ash Not tainted 6.16.0-g6bcdbd62bd56-dirty
Hardware name: linux,dummy-virt (DT)
Call trace:
 show_stack+0x34/0x50 (C)
 dump_stack_lvl+0xa0/0x158
 print_address_description.constprop.0+0x88/0x398
 print_report+0xb0/0x280
 kasan_report+0xa4/0xf0
 __asan_report_load1_noabort+0x20/0x30
 strsep+0x18c/0x1b0
 ftrace_process_regex.isra.0+0x100/0x2d8
 ftrace_regex_release+0x484/0x618
 __fput+0x364/0xa58
 ____fput+0x28/0x40
 task_work_run+0x154/0x278
 do_notify_resume+0x1f0/0x220
 el0_svc+0xec/0xf0
 el0t_64_sync_handler+0xa0/0xe8
 el0t_64_sync+0x1ac/0x1b0

The reason is that trace_get_user will fail when processing a string
longer than FTRACE_BUFF_MAX, but not set the end of parser->buffer to 0.
Then an OOB access will be triggered in ftrace_regex_release->
ftrace_process_regex->strsep->strpbrk. We can solve this problem by
limiting access to parser->buffer when trace_get_user failed.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250813040232.1344527-1-pulehui@huaweicloud.com
Fixes: 8c9af478c06b ("ftrace: Handle commands when closing set_ftrace_filter file")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4283ed4e8f59..8d8935ed416d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1816,7 +1816,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 
 	ret = get_user(ch, ubuf++);
 	if (ret)
-		return ret;
+		goto fail;
 
 	read++;
 	cnt--;
@@ -1830,7 +1830,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		while (cnt && isspace(ch)) {
 			ret = get_user(ch, ubuf++);
 			if (ret)
-				return ret;
+				goto fail;
 			read++;
 			cnt--;
 		}
@@ -1848,12 +1848,14 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 	while (cnt && !isspace(ch) && ch) {
 		if (parser->idx < parser->size - 1)
 			parser->buffer[parser->idx++] = ch;
-		else
-			return -EINVAL;
+		else {
+			ret = -EINVAL;
+			goto fail;
+		}
 
 		ret = get_user(ch, ubuf++);
 		if (ret)
-			return ret;
+			goto fail;
 		read++;
 		cnt--;
 	}
@@ -1868,11 +1870,15 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		/* Make sure the parsed string always terminates with '\0'. */
 		parser->buffer[parser->idx] = 0;
 	} else {
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	*ppos += read;
 	return read;
+fail:
+	trace_parser_fail(parser);
+	return ret;
 }
 
 /* TODO add a seq_buf_to_buffer() */
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 1dbf1d3cf2f1..be6654899cae 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1292,6 +1292,7 @@ bool ftrace_event_is_function(struct trace_event_call *call);
  */
 struct trace_parser {
 	bool		cont;
+	bool		fail;
 	char		*buffer;
 	unsigned	idx;
 	unsigned	size;
@@ -1299,7 +1300,7 @@ struct trace_parser {
 
 static inline bool trace_parser_loaded(struct trace_parser *parser)
 {
-	return (parser->idx != 0);
+	return !parser->fail && parser->idx != 0;
 }
 
 static inline bool trace_parser_cont(struct trace_parser *parser)
@@ -1313,6 +1314,11 @@ static inline void trace_parser_clear(struct trace_parser *parser)
 	parser->idx = 0;
 }
 
+static inline void trace_parser_fail(struct trace_parser *parser)
+{
+	parser->fail = true;
+}
+
 extern int trace_parser_get_init(struct trace_parser *parser, int size);
 extern void trace_parser_put(struct trace_parser *parser);
 extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,


