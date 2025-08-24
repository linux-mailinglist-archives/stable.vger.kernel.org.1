Return-Path: <stable+bounces-172747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCE4B3304E
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 16:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A752517BED5
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 14:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D93C2D4B4B;
	Sun, 24 Aug 2025 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqRWWL8I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD0213D503
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756044524; cv=none; b=o+T6WTIQ1qRi85en3VAJMo5mtJzeeSYGBMZMPupZDj71Ne4ODELsYJWQaOtVZeS9yrdj/UgCZ+1AiwbOJQNkpGF1wZRpUwDb1eUo96U9J9xCOrFqFxDO8SKJC+YMLplLXMdXiOrJS58bn141EHw9oHSEnZAq82tU3xntLY29J0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756044524; c=relaxed/simple;
	bh=f/j948PzWqlV/OFdsn2a6vN6+hHjGhT+Mg6aQ4zuuq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlwV3/nkPLoLHBe2Qjlz7FmbJUiCoFLIRTeAEZ3M6ACZKMMVodSFb0x2tAutRsdxjjkiMPI1NVFNz2vmZKO+1j0m1X4S0i/2gGDTYh0MO6ds8P4vPKbLOtepWcGGgHuVHB6CFSMsibDQLbj225VC27wO5rHjgTHu9I8An5b0EQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqRWWL8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9E2C4CEF1;
	Sun, 24 Aug 2025 14:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756044521;
	bh=f/j948PzWqlV/OFdsn2a6vN6+hHjGhT+Mg6aQ4zuuq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QqRWWL8IImLvr18ENX2ugQCMr0Waq2dxiEsCgBBZ1jYxXP+5v4OKt1M3YuXfzeGI3
	 CLmo6Od6QhrbpstAwbSneyYWi87WisixBOqRbOyWB2G40Iv5mbTIWQV53fsjFCDrkE
	 XxBkS/4TokniqI/pPZMjMD9kQYVZcdrZBbC3PzYshg5Q/YUtefKnmsi+QMh6bzbJQX
	 fiG/2J4d8tZP/vXhxlp2/UpvTvLmi/M6BKk6SE4o5Sl5ylk3BzKo/idXSel2xRrOIq
	 i07WttJ/D+EfYCCf4QJz1/uRxW2T7e+f+LtO8n5nnkVwVBHs2YzBomFOjfz58H+qoM
	 vhHWLXDNNB6VA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huawei.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] tracing: Limit access to parser->buffer when trace_get_user failed
Date: Sun, 24 Aug 2025 10:08:38 -0400
Message-ID: <20250824140838.2935876-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824140838.2935876-1-sashal@kernel.org>
References: <2025082332-jubilance-impotency-10c3@gregkh>
 <20250824140838.2935876-1-sashal@kernel.org>
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
index e0f1a8a6d85b..0c7aa47fb4d3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1613,7 +1613,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 
 	ret = get_user(ch, ubuf++);
 	if (ret)
-		return ret;
+		goto fail;
 
 	read++;
 	cnt--;
@@ -1627,7 +1627,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		while (cnt && isspace(ch)) {
 			ret = get_user(ch, ubuf++);
 			if (ret)
-				return ret;
+				goto fail;
 			read++;
 			cnt--;
 		}
@@ -1645,12 +1645,14 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
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
@@ -1665,11 +1667,15 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
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
index f47938d8401a..2f5558a097e9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1269,6 +1269,7 @@ bool ftrace_event_is_function(struct trace_event_call *call);
  */
 struct trace_parser {
 	bool		cont;
+	bool		fail;
 	char		*buffer;
 	unsigned	idx;
 	unsigned	size;
@@ -1276,7 +1277,7 @@ struct trace_parser {
 
 static inline bool trace_parser_loaded(struct trace_parser *parser)
 {
-	return (parser->idx != 0);
+	return !parser->fail && parser->idx != 0;
 }
 
 static inline bool trace_parser_cont(struct trace_parser *parser)
@@ -1290,6 +1291,11 @@ static inline void trace_parser_clear(struct trace_parser *parser)
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


