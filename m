Return-Path: <stable+bounces-12829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0064583788F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05E81F24D9A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDE51339A6;
	Tue, 23 Jan 2024 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A8FGF+xk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9113399C;
	Tue, 23 Jan 2024 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968110; cv=none; b=ZoGUGMSJxnpwnXwCObj+F5YtxXZwTi9m1HEgUyiqDwOmW2t1DqNB2pWa2I54JMBIwfmio3nqPuT6HjpDgk6nXZVlnPwI2ZthryrdEoywbcFdXwOOJXPkMSdzEx0XVqoEcIXQUITAWvDRyTO3gVGhjRx6NXzDZQ30DZdnWi/ejWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968110; c=relaxed/simple;
	bh=7ttjiP3Sdpb+YT35kEUQD8wva32e70JN8mCP8ePXQoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVl2EujFdGhj63zQ/KEZTuhjwPCsnZ4PRabIIyofCaqJUwro+HlFqT+pX+CblUP/xCQsoAe8PmbA1/4xeingcEYtTyB1NgxE3vF2xeLlb1waDFBp9K52MmsTYmAV/Zc4Suj2Ue4oP1e8toGCfuUHNO0b4rGnNJGYQiegyGRDWNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A8FGF+xk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88042C433C7;
	Tue, 23 Jan 2024 00:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968110;
	bh=7ttjiP3Sdpb+YT35kEUQD8wva32e70JN8mCP8ePXQoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8FGF+xkV0d+j4KtbbQVyl74zabmgo6Uh2WFRFSmNP8tm7BPmjvov0rdJBIZie1Fj
	 +9vJQbpsnclrnga97XSAGuYSAXknm1uiWpylDXQs/yexVYkvDad5Ynij1HhTIusSin
	 km7pwfK1vB/a8ieM/9BmlL/iKZmCdbtv5819wbfc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 013/148] tracing: Add size check when printing trace_marker output
Date: Mon, 22 Jan 2024 15:56:09 -0800
Message-ID: <20240122235712.976149522@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235712.442097787@linuxfoundation.org>
References: <20240122235712.442097787@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

[ Upstream commit 60be76eeabb3d83858cc6577fc65c7d0f36ffd42 ]

If for some reason the trace_marker write does not have a nul byte for the
string, it will overflow the print:

  trace_seq_printf(s, ": %s", field->buf);

The field->buf could be missing the nul byte. To prevent overflow, add the
max size that the buf can be by using the event size and the field
location.

  int max = iter->ent_size - offsetof(struct print_entry, buf);

  trace_seq_printf(s, ": %*.s", max, field->buf);

Link: https://lore.kernel.org/linux-trace-kernel/20231212084444.4619b8ce@gandalf.local.home

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_output.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 62015d62dd6f..43fb832d26d2 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1320,11 +1320,12 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 {
 	struct print_entry *field;
 	struct trace_seq *s = &iter->seq;
+	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
 	seq_print_ip_sym(s, field->ip, flags);
-	trace_seq_printf(s, ": %s", field->buf);
+	trace_seq_printf(s, ": %.*s", max, field->buf);
 
 	return trace_handle_return(s);
 }
@@ -1333,10 +1334,11 @@ static enum print_line_t trace_print_raw(struct trace_iterator *iter, int flags,
 					 struct trace_event *event)
 {
 	struct print_entry *field;
+	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
-	trace_seq_printf(&iter->seq, "# %lx %s", field->ip, field->buf);
+	trace_seq_printf(&iter->seq, "# %lx %.*s", field->ip, max, field->buf);
 
 	return trace_handle_return(&iter->seq);
 }
-- 
2.43.0




