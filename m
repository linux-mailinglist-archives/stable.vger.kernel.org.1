Return-Path: <stable+bounces-43481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851708C09C8
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 04:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B751282DAF
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 02:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594E98121F;
	Thu,  9 May 2024 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WwSzok//"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800E3D96D
	for <stable@vger.kernel.org>; Thu,  9 May 2024 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221817; cv=none; b=DiYK4GmXoC4OfWVGuEedXrcmbwiVkLJN2Wtup8MJodKnF1PEr3baeeApsVv6QSpD2dWbkrewro9HJq4667Hi8Nlm1zigMfYL0KcSpAbOOmg3Za4CSmjAbR7UVQKPZphOcScY8tZPDWmbxITrdDYhnrUaTwrYPfYqj0d4P10cSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221817; c=relaxed/simple;
	bh=6pmIkdSItIeLdxGGdzX811JHFZ1KkYB0w/FZXTeZOB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mp0xWfYbPNBXP3+WZj4B5fqsLB+4oZvIZVJJo+VRkar9zt6r1g905MfQHvCJhmx0Ib2UtAmzB1oAQlhAgxhudvIRg+WNQC3gS245xzGF/fbpa0G6hboPeZsQnIhRNuX8lg+Q03dJDKfkESLs+sq3wZydu/oub8dHvClOREMLli8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WwSzok//; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715221812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzVIXrekGv5cFQPUgqitIQ1NRxvl8fUmILmr5W3Yn38=;
	b=WwSzok//j99afa+0KSVBUahWTVfA968Kmgi2FJITiwF8ftW/IJ0V+aTciTpMhRsUfu3xI9
	8zr5Qh+UJdfIa5SqKwtJScT+mulvyw3op8nGkn4KGo0adWHTVAc8LbGZkuUUw7L1qZQ82I
	/WT21v+GiHr88oiW/9wIqt/yUj1JmXw=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	tom.zanussi@linux.intel.com
Cc: stable@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4.19.y 04/13] tracing: Remove unneeded synth_event_mutex
Date: Thu,  9 May 2024 10:29:22 +0800
Message-Id: <20240509022931.3513365-5-dongtai.guo@linux.dev>
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

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 0e2b81f7b52a1c1a8c46986f9ca01eb7b3c421f8 upstream.

Rmove unneeded synth_event_mutex. This mutex protects the reference
count in synth_event, however, those operational points are already
protected by event_mutex.

1. In __create_synth_event() and create_or_delete_synth_event(),
 those synth_event_mutex clearly obtained right after event_mutex.

2. event_hist_trigger_func() is trigger_hist_cmd.func() which is
 called by trigger_process_regex(), which is a part of
 event_trigger_regex_write() and this function takes event_mutex.

3. hist_unreg_all() is trigger_hist_cmd.unreg_all() which is called
 by event_trigger_regex_open() and it takes event_mutex.

4. onmatch_destroy() and onmatch_create() have long call tree,
 but both are finally invoked from event_trigger_regex_write()
 and event_trace_del_tracer(), former takes event_mutex, and latter
 ensures called under event_mutex locked.

Finally, I ensured there is no resource conflict. For safety,
I added lockdep_assert_held(&event_mutex) for each function.

Link: http://lkml.kernel.org/r/154140864134.17322.4796059721306031894.stgit@devbox

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 kernel/trace/trace_events_hist.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1996da54f2b2..1a32b64d350b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -443,8 +443,6 @@ static bool have_hist_err(void)
 	return false;
 }
 
-static DEFINE_MUTEX(synth_event_mutex);
-
 struct synth_trace_event {
 	struct trace_entry	ent;
 	u64			fields[];
@@ -1097,7 +1095,6 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 		return -EINVAL;
 
 	mutex_lock(&event_mutex);
-	mutex_lock(&synth_event_mutex);
 
 	event = find_synth_event(name);
 	if (event) {
@@ -1139,7 +1136,6 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 	else
 		free_synth_event(event);
  out:
-	mutex_unlock(&synth_event_mutex);
 	mutex_unlock(&event_mutex);
 
 	return ret;
@@ -1159,7 +1155,6 @@ static int create_or_delete_synth_event(int argc, char **argv)
 	/* trace_run_command() ensures argc != 0 */
 	if (name[0] == '!') {
 		mutex_lock(&event_mutex);
-		mutex_lock(&synth_event_mutex);
 		event = find_synth_event(name + 1);
 		if (event) {
 			if (event->ref)
@@ -1173,7 +1168,6 @@ static int create_or_delete_synth_event(int argc, char **argv)
 			}
 		} else
 			ret = -ENOENT;
-		mutex_unlock(&synth_event_mutex);
 		mutex_unlock(&event_mutex);
 		return ret;
 	}
@@ -3660,7 +3654,7 @@ static void onmatch_destroy(struct action_data *data)
 {
 	unsigned int i;
 
-	mutex_lock(&synth_event_mutex);
+	lockdep_assert_held(&event_mutex);
 
 	kfree(data->onmatch.match_event);
 	kfree(data->onmatch.match_event_system);
@@ -3673,8 +3667,6 @@ static void onmatch_destroy(struct action_data *data)
 		data->onmatch.synth_event->ref--;
 
 	kfree(data);
-
-	mutex_unlock(&synth_event_mutex);
 }
 
 static void destroy_field_var(struct field_var *field_var)
@@ -3810,15 +3802,14 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 	struct synth_event *event;
 	int ret = 0;
 
-	mutex_lock(&synth_event_mutex);
+	lockdep_assert_held(&event_mutex);
+
 	event = find_synth_event(data->onmatch.synth_event_name);
 	if (!event) {
 		hist_err("onmatch: Couldn't find synthetic event: ", data->onmatch.synth_event_name);
-		mutex_unlock(&synth_event_mutex);
 		return -EINVAL;
 	}
 	event->ref++;
-	mutex_unlock(&synth_event_mutex);
 
 	var_ref_idx = hist_data->n_var_refs;
 
@@ -3892,9 +3883,7 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
  out:
 	return ret;
  err:
-	mutex_lock(&synth_event_mutex);
 	event->ref--;
-	mutex_unlock(&synth_event_mutex);
 
 	goto out;
 }
@@ -5611,6 +5600,8 @@ static void hist_unreg_all(struct trace_event_file *file)
 	struct synth_event *se;
 	const char *se_name;
 
+	lockdep_assert_held(&event_mutex);
+
 	if (hist_file_check_refs(file))
 		return;
 
@@ -5620,12 +5611,10 @@ static void hist_unreg_all(struct trace_event_file *file)
 			list_del_rcu(&test->list);
 			trace_event_trigger_enable_disable(file, 0);
 
-			mutex_lock(&synth_event_mutex);
 			se_name = trace_event_name(file->event_call);
 			se = find_synth_event(se_name);
 			if (se)
 				se->ref--;
-			mutex_unlock(&synth_event_mutex);
 
 			update_cond_flag(file);
 			if (hist_data->enable_timestamps)
@@ -5651,6 +5640,8 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	char *trigger, *p;
 	int ret = 0;
 
+	lockdep_assert_held(&event_mutex);
+
 	if (glob && strlen(glob)) {
 		last_cmd_set(param);
 		hist_err_clear();
@@ -5741,14 +5732,10 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		}
 
 		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
-
-		mutex_lock(&synth_event_mutex);
 		se_name = trace_event_name(file->event_call);
 		se = find_synth_event(se_name);
 		if (se)
 			se->ref--;
-		mutex_unlock(&synth_event_mutex);
-
 		ret = 0;
 		goto out_free;
 	}
@@ -5787,13 +5774,10 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	if (ret)
 		goto out_unreg;
 
-	mutex_lock(&synth_event_mutex);
 	se_name = trace_event_name(file->event_call);
 	se = find_synth_event(se_name);
 	if (se)
 		se->ref++;
-	mutex_unlock(&synth_event_mutex);
-
 	/* Just return zero, not the number of registered triggers */
 	ret = 0;
  out:
-- 
2.34.1


