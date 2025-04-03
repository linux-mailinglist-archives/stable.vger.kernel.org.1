Return-Path: <stable+bounces-127995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 716B0A7ADFB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C77317D704
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8431EA7D3;
	Thu,  3 Apr 2025 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4BY0NT8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E851E633C;
	Thu,  3 Apr 2025 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707708; cv=none; b=q1Ykn1qIq0KlVhIATvcKBeVqbe4oxLTCzrz4r5D98kJa4sGVg81+ASBsdL97HC2rDLOk40epyoMZyW4nA+7TgqI8dCCHFRZC53OTI7bdYVr/eyVNyugnMu/ztER5C1hwz6P/CsTunjxa4TVdeImL6YYExu/L96cJRqi4UFDo9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707708; c=relaxed/simple;
	bh=thBWjRBwekKKe8ey9uRsJtj2H8/gTtY0UZU+DdxEXwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hwkUBYRnkX2d7N6qEo28X4PL8CbSYCKSKwmAk15DX/Atmu7o1LglP0mV/bKUGN+od97uEhnJljpI4gJTa7u+hovnvTOb5D6ZoJwkOyjHZ5m0jok6TDrY+K0/ZMaGrG0cgeEcqIbrjtyXRspOKwrCulfMAlh0AmJhL1/s3BM1HME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4BY0NT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B801C4CEE8;
	Thu,  3 Apr 2025 19:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707707;
	bh=thBWjRBwekKKe8ey9uRsJtj2H8/gTtY0UZU+DdxEXwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T4BY0NT8QJwmhTUCSl9mvOndJIgx8C53gyI2QmFI4nTO4xAspn1HeVLxpeludHy/Y
	 m/I+4cDJJl9tjICigrmAIW5JV63a75KPVH8MM+FeBfe6eTb8wqGsHJBZIU18kTx4jm
	 ORrQbwT74Bv/+oyNwynZ6t+N3ZQ5kxBayudghslx5f8Roh91VIOzgD5nLrTWJYsQuG
	 +nGcx9ur6o9Jt6o+rmPztC5P0mXEHBTx69bJ36SVwoB1hlRE0sp0OCkyO8u9H0f/gJ
	 /tPmCLwEFjIDulPbDzXoU6kgFLvkS+mT88RMtQuCfJBh5pJlnHu0hjoJNot78QTQ0l
	 gyU9gK1wIPKEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 40/44] tracing: probe-events: Log error for exceeding the number of arguments
Date: Thu,  3 Apr 2025 15:13:09 -0400
Message-Id: <20250403191313.2679091-40-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 57faaa04804ccbf16582f7fc7a6b986fd0c0e78c ]

Add error message when the number of arguments exceeds the limitation.

Link: https://lore.kernel.org/all/174055075075.4079315.10916648136898316476.stgit@mhiramat.tok.corp.google.com/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_eprobe.c | 2 ++
 kernel/trace/trace_fprobe.c | 5 ++++-
 kernel/trace/trace_kprobe.c | 5 ++++-
 kernel/trace/trace_probe.h  | 1 +
 kernel/trace/trace_uprobe.c | 9 +++++++--
 5 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 82fd637cfc19e..af9fa0632b574 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -913,6 +913,8 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	}
 
 	if (argc - 2 > MAX_TRACE_ARGS) {
+		trace_probe_log_set_index(2);
+		trace_probe_log_err(0, TOO_MANY_ARGS);
 		ret = -E2BIG;
 		goto error;
 	}
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 985ff98272da8..5d7ca80173ea2 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1199,8 +1199,11 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 		argc = new_argc;
 		argv = new_argv;
 	}
-	if (argc > MAX_TRACE_ARGS)
+	if (argc > MAX_TRACE_ARGS) {
+		trace_probe_log_set_index(2);
+		trace_probe_log_err(0, TOO_MANY_ARGS);
 		return -E2BIG;
+	}
 
 	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
 	if (ret)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d8d5f18a141ad..8287b175667f3 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1007,8 +1007,11 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
 		argc = new_argc;
 		argv = new_argv;
 	}
-	if (argc > MAX_TRACE_ARGS)
+	if (argc > MAX_TRACE_ARGS) {
+		trace_probe_log_set_index(2);
+		trace_probe_log_err(0, TOO_MANY_ARGS);
 		return -E2BIG;
+	}
 
 	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
 	if (ret)
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 96792bc4b0924..854e5668f5ee5 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -545,6 +545,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_BTF_TID,		"Failed to get BTF type info."),\
 	C(BAD_TYPE4STR,		"This type does not fit for string."),\
 	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),\
+	C(TOO_MANY_ARGS,	"Too many arguments are specified"),	\
 	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),
 
 #undef C
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index ccc762fbb69cd..3386439ec9f67 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -562,8 +562,14 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	if (argc < 2)
 		return -ECANCELED;
-	if (argc - 2 > MAX_TRACE_ARGS)
+
+	trace_probe_log_init("trace_uprobe", argc, argv);
+
+	if (argc - 2 > MAX_TRACE_ARGS) {
+		trace_probe_log_set_index(2);
+		trace_probe_log_err(0, TOO_MANY_ARGS);
 		return -E2BIG;
+	}
 
 	if (argv[0][1] == ':')
 		event = &argv[0][2];
@@ -582,7 +588,6 @@ static int __trace_uprobe_create(int argc, const char **argv)
 		return -ECANCELED;
 	}
 
-	trace_probe_log_init("trace_uprobe", argc, argv);
 	trace_probe_log_set_index(1);	/* filename is the 2nd argument */
 
 	*arg++ = '\0';
-- 
2.39.5


