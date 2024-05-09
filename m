Return-Path: <stable+bounces-43482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C4B8C09C9
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 04:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842F3B21DAB
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 02:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1080983CB2;
	Thu,  9 May 2024 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S9d6+6FU"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F312B5D74C
	for <stable@vger.kernel.org>; Thu,  9 May 2024 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221820; cv=none; b=JuvhOGFdIt1d1Yqtcf1JztZ6U7RAziiLIrdjYCpwVr+gTzHOAp71ZIQtjDOa0cTsv2vSHqI4FNUIISNGTO2/wX5Xo7+I0y1sjIFRQPhW01oD5f/8nYeuTAn/sLpF1scktdo8nHRBeefhqrtHWf6EDlFT5Pf47RhsT4RtBZ0ZC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221820; c=relaxed/simple;
	bh=96G+pxgiivRuhhZiBDXzLsiCdPIRBdtNExIs4klSNOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H9da8CpX8FFbVxSRHSZqrLlHsT7n1+WlThPeQQ5Vl7l2+zXU2dfPMnTswPiGpqOYirxV3nigeXuLvo6bagQfxyJ37wjp51M4pz9YpUWh8+JtX43rgk10FPjjeFp3mInuvT89Uil1oKfkZrzHrAVfC82ACVejP2fppLJJ0YzAINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S9d6+6FU; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715221815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0JkrosJyE9tyU8ag45IGeUbEuZZuNQYNnEKiEH/KiU=;
	b=S9d6+6FUTUQOclmmeQlvPdUDoc1fCQ/R9QJgA0fnv3cfdA/4KDHW+kJvg4biFwLqQcRcK3
	s7jNSx3o9eGnYCg5piDjlWrraHPk+rB9tQxUvXdOwWXoRR7qz5CEadEsHNOot941AgMMHx
	uoreNMy+qrFwOzglga3gknRZXmkbHoo=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	tom.zanussi@linux.intel.com
Cc: stable@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4.19.y 05/13] tracing: Consolidate trace_add/remove_event_call back to the nolock functions
Date: Thu,  9 May 2024 10:29:23 +0800
Message-Id: <20240509022931.3513365-6-dongtai.guo@linux.dev>
In-Reply-To: <20240509022931.3513365-1-dongtai.guo@linux.dev>
References: <20240509022931.3513365-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

commit 7e1413edd6194a9807aa5f3ac0378b9b4b9da879 upstream.

The trace_add/remove_event_call_nolock() functions were added to allow
the tace_add/remove_event_call() code be called when the event_mutex
lock was already taken. Now that all callers are done within the
event_mutex, there's no reason to have two different interfaces.

Remove the current wrapper trace_add/remove_event_call()s and rename the
_nolock versions back to the original names.

Link: http://lkml.kernel.org/r/154140866955.17322.2081425494660638846.stgit@devbox

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/linux/trace_events.h     |  2 --
 kernel/trace/trace_events.c      | 30 ++++--------------------------
 kernel/trace/trace_events_hist.c |  6 +++---
 3 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 755daada7def..f4077379420f 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -529,8 +529,6 @@ extern int trace_event_raw_init(struct trace_event_call *call);
 extern int trace_define_field(struct trace_event_call *call, const char *type,
 			      const char *name, int offset, int size,
 			      int is_signed, int filter_type);
-extern int trace_add_event_call_nolock(struct trace_event_call *call);
-extern int trace_remove_event_call_nolock(struct trace_event_call *call);
 extern int trace_add_event_call(struct trace_event_call *call);
 extern int trace_remove_event_call(struct trace_event_call *call);
 extern int trace_event_get_offsets(struct trace_event_call *call);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 2830a9cbe648..949eac9362a6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2312,7 +2312,8 @@ __trace_early_add_new_event(struct trace_event_call *call,
 struct ftrace_module_file_ops;
 static void __add_event_to_tracers(struct trace_event_call *call);
 
-int trace_add_event_call_nolock(struct trace_event_call *call)
+/* Add an additional event_call dynamically */
+int trace_add_event_call(struct trace_event_call *call)
 {
 	int ret;
 	lockdep_assert_held(&event_mutex);
@@ -2327,17 +2328,6 @@ int trace_add_event_call_nolock(struct trace_event_call *call)
 	return ret;
 }
 
-/* Add an additional event_call dynamically */
-int trace_add_event_call(struct trace_event_call *call)
-{
-	int ret;
-
-	mutex_lock(&event_mutex);
-	ret = trace_add_event_call_nolock(call);
-	mutex_unlock(&event_mutex);
-	return ret;
-}
-
 /*
  * Must be called under locking of trace_types_lock, event_mutex and
  * trace_event_sem.
@@ -2383,8 +2373,8 @@ static int probe_remove_event_call(struct trace_event_call *call)
 	return 0;
 }
 
-/* no event_mutex version */
-int trace_remove_event_call_nolock(struct trace_event_call *call)
+/* Remove an event_call */
+int trace_remove_event_call(struct trace_event_call *call)
 {
 	int ret;
 
@@ -2399,18 +2389,6 @@ int trace_remove_event_call_nolock(struct trace_event_call *call)
 	return ret;
 }
 
-/* Remove an event_call */
-int trace_remove_event_call(struct trace_event_call *call)
-{
-	int ret;
-
-	mutex_lock(&event_mutex);
-	ret = trace_remove_event_call_nolock(call);
-	mutex_unlock(&event_mutex);
-
-	return ret;
-}
-
 #define for_each_event(event, start, end)			\
 	for (event = start;					\
 	     (unsigned long)event < (unsigned long)end;		\
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1a32b64d350b..1139075a6395 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -980,7 +980,7 @@ static int register_synth_event(struct synth_event *event)
 	call->data = event;
 	call->tp = event->tp;
 
-	ret = trace_add_event_call_nolock(call);
+	ret = trace_add_event_call(call);
 	if (ret) {
 		pr_warn("Failed to register synthetic event: %s\n",
 			trace_event_name(call));
@@ -989,7 +989,7 @@ static int register_synth_event(struct synth_event *event)
 
 	ret = set_synth_event_print_fmt(call);
 	if (ret < 0) {
-		trace_remove_event_call_nolock(call);
+		trace_remove_event_call(call);
 		goto err;
 	}
  out:
@@ -1004,7 +1004,7 @@ static int unregister_synth_event(struct synth_event *event)
 	struct trace_event_call *call = &event->call;
 	int ret;
 
-	ret = trace_remove_event_call_nolock(call);
+	ret = trace_remove_event_call(call);
 
 	return ret;
 }
-- 
2.34.1


