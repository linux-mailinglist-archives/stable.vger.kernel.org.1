Return-Path: <stable+bounces-16387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7C583FCAD
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 04:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F9B1F223DE
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 03:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AC1101CF;
	Mon, 29 Jan 2024 03:25:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B34EFC0E;
	Mon, 29 Jan 2024 03:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706498724; cv=none; b=XCveUON2mFMM5MdkN15eYBc0LWQLhoOypGmznd4F3g5lwBuPbOCLICh0XwV4MKo0y0vCapxFmdSYXcJMzMnMLGDHY4pFcSigHewGcv5pQOra2wwju6W8WHVGLyW9w/KHYsznsUjvs4M0TsYJt3hMf0E9wcUsafdz3kf4iV9m+yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706498724; c=relaxed/simple;
	bh=cQZnw0XY6CFlQ+Z4GEoHFMmClO2ao+MY79xo8Dq099I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GbLg7nsnyR2N9+ugBriWUXmmwIkee3IoVUH5jJ2Cl7wLzWTgWGYzpjLCG98ZlNxTS3Qwdyzx5dv5jd9BbeGUAABMnEIDUfZVkk2pXuwP34UMhuCBi02PMCqW/CZ6q8M+wFQF4it8JGg3GE+KJqhsXunXeRK/fJMZAD/lcSj5osw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DE5C41679;
	Mon, 29 Jan 2024 03:25:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rUIH6-00000004Fr1-40QR;
	Sun, 28 Jan 2024 22:25:32 -0500
Message-ID: <20240129032532.819040059@goodmis.org>
User-Agent: quilt/0.67
Date: Sun, 28 Jan 2024 22:25:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 1/2] tracing/trigger: Fix to return error if failed to alloc snapshot
References: <20240129032507.290291577@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Fix register_snapshot_trigger() to return error code if it failed to
allocate a snapshot instead of 0 (success). Unless that, it will register
snapshot trigger without an error.

Link: https://lore.kernel.org/linux-trace-kernel/170622977792.270660.2789298642759362200.stgit@devnote2

Fixes: 0bbe7f719985 ("tracing: Fix the race between registering 'snapshot' event trigger and triggering 'snapshot' operation")
Cc: stable@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 46439e3bcec4..b33c3861fbbb 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1470,8 +1470,10 @@ register_snapshot_trigger(char *glob,
 			  struct event_trigger_data *data,
 			  struct trace_event_file *file)
 {
-	if (tracing_alloc_snapshot_instance(file->tr) != 0)
-		return 0;
+	int ret = tracing_alloc_snapshot_instance(file->tr);
+
+	if (ret < 0)
+		return ret;
 
 	return register_trigger(glob, data, file);
 }
-- 
2.43.0



