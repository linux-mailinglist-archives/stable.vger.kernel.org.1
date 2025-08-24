Return-Path: <stable+bounces-172739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C643B33038
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C74189615D
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 13:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEBE266591;
	Sun, 24 Aug 2025 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lgmi9Lzv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B341514F7
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756043382; cv=none; b=rRzhfxBXcZi77f9aNTcO4QlnRZMim9wo8qUKIzwHCxd8OmTBooAP4Dc6i5SsbohIsEpLRHQeS5buIUGipIhvEXt73mjAtq32NtZMU2XIREDx8Y079BMvfUlK8JmVKmBPmKwJKRFjfjupnCmuKG0RmitO8+9hesmt0gJJiZ4QO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756043382; c=relaxed/simple;
	bh=DBOFaAsSLtJpLE0tnMD25MQi5lHBPAikjl9oyO5Nzvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lW9XZ48EH1/j9RKuUhHmLDhfrYDqMTp4v3ewKiFWaafNh6HZ6KJp9gbDMaJHXPna8xWe8LzvKi+C/XMIyEl9kjxS2FOfSzaVGQxp5sSZLHU3Iovtj24BHhHzyvglIc4kr+KBzWYpUIMTwYoOyhwp+7t8pyMFNyVXWbhax7pgx98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lgmi9Lzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA326C116D0;
	Sun, 24 Aug 2025 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756043381;
	bh=DBOFaAsSLtJpLE0tnMD25MQi5lHBPAikjl9oyO5Nzvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lgmi9LzvdhVQG0aXFuL0fbOjU10mwC9Pjr3Ut4eiqwmizYWdMy+1Waxk1fGRcXb6w
	 yz2BKIByYCFz2oiKf1eok23GWt8bLOnlgemKji7FhV92aD47Zwo+392n80XiOMGGUy
	 Nl0xeEX3xN0G+Ud8hldBqkM5x3K0d6EID8mbqWSqFTf/e4OVwPV8wtnm+wnWrQV0I8
	 2FsxOAjMZdpHRWepxW/L5cGzE34oSEVUdTLcdKJA5fCakfKVnQaCFiDrMST3NR8gCv
	 t8XCVyaQuAUSJoAXljfpZdlqHL8PQah6+Z2XCl9Ha7H9rit8AUUljLlHZn1BN21QUe
	 BjJkScSBwVuAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huawei.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] tracing: Limit access to parser->buffer when trace_get_user failed
Date: Sun, 24 Aug 2025 09:49:36 -0400
Message-ID: <20250824134936.2918494-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824134936.2918494-1-sashal@kernel.org>
References: <2025082331-axis-politely-d9d3@gregkh>
 <20250824134936.2918494-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pu Lehui <pulehui@huawei.com>

[ Upstream commit 6a909ea83f226803ea0e718f6e88613df9234d58 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 18 ++++++++++++------
 kernel/trace/trace.h |  8 +++++++-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f08f2f98df2e..874f869ae72e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1618,7 +1618,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 
 	ret = get_user(ch, ubuf++);
 	if (ret)
-		return ret;
+		goto fail;
 
 	read++;
 	cnt--;
@@ -1632,7 +1632,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		while (cnt && isspace(ch)) {
 			ret = get_user(ch, ubuf++);
 			if (ret)
-				return ret;
+				goto fail;
 			read++;
 			cnt--;
 		}
@@ -1650,12 +1650,14 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
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
@@ -1670,11 +1672,15 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
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
index 950782b0ab1c..9a6568217fc9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1131,6 +1131,7 @@ bool ftrace_event_is_function(struct trace_event_call *call);
  */
 struct trace_parser {
 	bool		cont;
+	bool		fail;
 	char		*buffer;
 	unsigned	idx;
 	unsigned	size;
@@ -1138,7 +1139,7 @@ struct trace_parser {
 
 static inline bool trace_parser_loaded(struct trace_parser *parser)
 {
-	return (parser->idx != 0);
+	return !parser->fail && parser->idx != 0;
 }
 
 static inline bool trace_parser_cont(struct trace_parser *parser)
@@ -1152,6 +1153,11 @@ static inline void trace_parser_clear(struct trace_parser *parser)
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
-- 
2.50.1


