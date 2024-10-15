Return-Path: <stable+bounces-85740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7095199E8DB
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1461F21944
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E631EF92C;
	Tue, 15 Oct 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y+2Awbgv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032441EBA1D;
	Tue, 15 Oct 2024 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994138; cv=none; b=mZ8MBy+fyRIflrQf9PQUs4A/RQBMqGQkDMqkkLzjjfVhqNYtNaEd/kD4ysF7r8VsZG5q4sppBz1BBHwpiQkrK1epVTrr9Ji1/F34YUF0O0uS5jDnbd1fDOfdubOX/w/IhwK/laARpgYAIC0jjbpH8tmnoL5cEKxnb5yQyoBEUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994138; c=relaxed/simple;
	bh=BJl/451UQZ3rHkNZfbA552jmzYD8tqImlWU/3fQ6DIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFfvi8YXiC8BhWdFL9+SBP3KOhUAQabs+5QAwvsfDCBFX6BdPSJpUBTh89h7TEu0KnM5YTfjVMWaJHHwGh5VBgQEGpM/J6X+g7T2mFM80JlDffu7yAZAHel0GwpCHsurbKWtn/rATMZr4kvBSyOaHOqJ5U/1ijXDQ8uapo+AtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y+2Awbgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10700C4CEC6;
	Tue, 15 Oct 2024 12:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728994137;
	bh=BJl/451UQZ3rHkNZfbA552jmzYD8tqImlWU/3fQ6DIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y+2AwbgvIZbGr3TeC1D7i66zPGdSWWv33AMUbw5tIg5ybOF5tL71RwUPb6zYNQCUx
	 +oFzzgW0vhxjoLaFganQGsHLBiA2OTCdDHcVJqtZcKmmPjR9i6ytIqCtR/goJ0BtGI
	 faYVeULq/3+DjQv/iceC9BvkeSJ1DxvMwaE5pCEc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sachin Sant <sachinp@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 587/691] tracing: Remove precision vsnprintf() check from print event
Date: Tue, 15 Oct 2024 13:28:55 +0200
Message-ID: <20241015112503.646643440@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

[ Upstream commit 5efd3e2aef91d2d812290dcb25b2058e6f3f532c ]

This reverts 60be76eeabb3d ("tracing: Add size check when printing
trace_marker output"). The only reason the precision check was added
was because of a bug that miscalculated the write size of the string into
the ring buffer and it truncated it removing the terminating nul byte. On
reading the trace it crashed the kernel. But this was due to the bug in
the code that happened during development and should never happen in
practice. If anything, the precision can hide bugs where the string in the
ring buffer isn't nul terminated and it will not be checked.

Link: https://lore.kernel.org/all/C7E7AF1A-D30F-4D18-B8E5-AF1EF58004F5@linux.ibm.com/
Link: https://lore.kernel.org/linux-trace-kernel/20240227125706.04279ac2@gandalf.local.home
Link: https://lore.kernel.org/all/20240302111244.3a1674be@gandalf.local.home/
Link: https://lore.kernel.org/linux-trace-kernel/20240304174341.2a561d9f@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 60be76eeabb3d ("tracing: Add size check when printing trace_marker output")
Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_output.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 4c4b84e507f74..6b4d3f3abdae2 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1446,12 +1446,11 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 {
 	struct print_entry *field;
 	struct trace_seq *s = &iter->seq;
-	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
 	seq_print_ip_sym(s, field->ip, flags);
-	trace_seq_printf(s, ": %.*s", max, field->buf);
+	trace_seq_printf(s, ": %s", field->buf);
 
 	return trace_handle_return(s);
 }
@@ -1460,11 +1459,10 @@ static enum print_line_t trace_print_raw(struct trace_iterator *iter, int flags,
 					 struct trace_event *event)
 {
 	struct print_entry *field;
-	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
-	trace_seq_printf(&iter->seq, "# %lx %.*s", field->ip, max, field->buf);
+	trace_seq_printf(&iter->seq, "# %lx %s", field->ip, field->buf);
 
 	return trace_handle_return(&iter->seq);
 }
-- 
2.43.0




