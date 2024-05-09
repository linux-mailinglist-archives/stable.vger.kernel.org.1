Return-Path: <stable+bounces-43487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1518C09CF
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 04:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389971C20CE7
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 02:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD382E84F;
	Thu,  9 May 2024 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JZpF4z3X"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14F613CAA0
	for <stable@vger.kernel.org>; Thu,  9 May 2024 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221836; cv=none; b=PnjcVFfs5H+RCXDT7w9XrBflWo17pYKI2kNRXMLP4Q2LeBx5F4g5kxwS4ROcbC79ZiTR4iBWzOnABirxhZkAo+aqIZN2M0vKvVUU1oPWbUEGd0CWH1ncs+BGu/m65E+WSPNtC4goWbq/2vsrykq75P4QFs0dAPShCDNnVBlSSZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221836; c=relaxed/simple;
	bh=HNO0AZPG+xgKH3/llgbFU9EOjILkNTCLOsVS2Yv9/rg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jcAuesWye/G8fD7M2lGu8HyKAs5g1q4WjlThlkQ6OA8/XyNHWxEPzQhEufcsITfvL8e0wJ9aLCQ0EI122S4kFGO555uAh0NUdFG3z1om3ne5wHeY3n5SjHQqSW0qDvlfu/nrhoBTQrYnfX5iUDW0/oAS+31d8+o4wVapY/o/JIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JZpF4z3X; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715221831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r+Uyl+RTzHbQV9KevyEPfVZqihiTZGIHVmBI3EvaQ/s=;
	b=JZpF4z3XTK5DRpa+xRpC0q4f6QkPdjZz0R/3fzVYEIxbQKgnmTd0QqLVTPtXZntC91rtDG
	q8ccWb4Jk11SItHLHWYVdxsoOMxotI6qfCgX9Gh9CMtuBQ8DbRHOaYUA91vsDMqkeAQlOq
	2i1MNCwtd7iLwzU9i5TONMjJS56nsH0=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	tom.zanussi@linux.intel.com
Cc: stable@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4.19.y 10/13] tracing: Refactor hist trigger action code
Date: Thu,  9 May 2024 10:29:28 +0800
Message-Id: <20240509022931.3513365-11-dongtai.guo@linux.dev>
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

From: Tom Zanussi <tom.zanussi@linux.intel.com>

commit 7d18a10c316783357fb1b2b649cfcf97c70a7bee upstream.

The hist trigger action code currently implements two essentially
hard-coded pairs of 'actions' - onmax(), which tracks a variable and
saves some event fields when a max is hit, and onmatch(), which is
hard-coded to generate a synthetic event.

These hardcoded pairs (track max/save fields and detect match/generate
synthetic event) should really be decoupled into separate components
that can then be arbitrarily combined.  The first component of each
pair (track max/detect match) is called a 'handler' in the new code,
while the second component (save fields/generate synthetic event) is
called an 'action' in this scheme.

This change refactors the action code to reflect this split by adding
two handlers, HANDLER_ONMATCH and HANDLER_ONMAX, along with two
actions, ACTION_SAVE and ACTION_TRACE.

The new code combines them to produce the existing ONMATCH/TRACE and
ONMAX/SAVE functionality, but doesn't implement the other combinations
now possible.  Future patches will expand these to further useful
cases, such as ONMAX/TRACE, as well as add additional handlers and
actions such as ONCHANGE and SNAPSHOT.

Also, add abbreviated documentation for handlers and actions to
README.

Link: http://lkml.kernel.org/r/98bfdd48c1b4ff29fc5766442f99f5bc3c34b76b.1550100284.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 kernel/trace/trace_events_hist.c | 407 ++++++++++++++++++-------------
 1 file changed, 238 insertions(+), 169 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 460b07d51dd6..70679defb6ee 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -287,9 +287,9 @@ struct hist_trigger_data {
 	struct field_var_hist		*field_var_hists[SYNTH_FIELDS_MAX];
 	unsigned int			n_field_var_hists;
 
-	struct field_var		*max_vars[SYNTH_FIELDS_MAX];
-	unsigned int			n_max_vars;
-	unsigned int			n_max_var_str;
+	struct field_var		*save_vars[SYNTH_FIELDS_MAX];
+	unsigned int			n_save_vars;
+	unsigned int			n_save_var_str;
 };
 
 static int synth_event_create(int argc, const char **argv);
@@ -357,11 +357,25 @@ struct action_data;
 
 typedef void (*action_fn_t) (struct hist_trigger_data *hist_data,
 			     struct tracing_map_elt *elt, void *rec,
-			     struct ring_buffer_event *rbe,
+			     struct ring_buffer_event *rbe, void *key,
 			     struct action_data *data, u64 *var_ref_vals);
 
+enum handler_id {
+	HANDLER_ONMATCH = 1,
+	HANDLER_ONMAX,
+};
+
+enum action_id {
+	ACTION_SAVE = 1,
+	ACTION_TRACE,
+};
+
 struct action_data {
+	enum handler_id		handler;
+	enum action_id		action;
+	char			*action_name;
 	action_fn_t		fn;
+
 	unsigned int		n_params;
 	char			*params[SYNTH_FIELDS_MAX];
 
@@ -370,13 +384,11 @@ struct action_data {
 			unsigned int		var_ref_idx;
 			char			*match_event;
 			char			*match_event_system;
-			char			*synth_event_name;
 			struct synth_event	*synth_event;
 		} onmatch;
 
 		struct {
 			char			*var_str;
-			char			*fn_name;
 			unsigned int		max_var_ref_idx;
 			struct hist_field	*max_var;
 			struct hist_field	*var;
@@ -1065,7 +1077,7 @@ static struct synth_event *alloc_synth_event(const char *name, int n_fields,
 
 static void action_trace(struct hist_trigger_data *hist_data,
 			 struct tracing_map_elt *elt, void *rec,
-			 struct ring_buffer_event *rbe,
+			 struct ring_buffer_event *rbe, void *key,
 			 struct action_data *data, u64 *var_ref_vals)
 {
 	struct synth_event *event = data->onmatch.synth_event;
@@ -1635,7 +1647,7 @@ find_match_var(struct hist_trigger_data *hist_data, char *var_name)
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 
-		if (data->fn == action_trace) {
+		if (data->handler == HANDLER_ONMATCH) {
 			char *system = data->onmatch.match_event_system;
 			char *event_name = data->onmatch.match_event;
 
@@ -2073,7 +2085,7 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 		}
 	}
 
-	n_str = hist_data->n_field_var_str + hist_data->n_max_var_str;
+	n_str = hist_data->n_field_var_str + hist_data->n_save_var_str;
 
 	size = STR_VAR_LEN_MAX;
 
@@ -3115,7 +3127,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	int ret;
 
 	if (target_hist_data->n_field_var_hists >= SYNTH_FIELDS_MAX) {
-		hist_err_event("onmatch: Too many field variables defined: ",
+		hist_err_event("trace action: Too many field variables defined: ",
 			       subsys_name, event_name, field_name);
 		return ERR_PTR(-EINVAL);
 	}
@@ -3123,7 +3135,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	file = event_file(tr, subsys_name, event_name);
 
 	if (IS_ERR(file)) {
-		hist_err_event("onmatch: Event file not found: ",
+		hist_err_event("trace action: Event file not found: ",
 			       subsys_name, event_name, field_name);
 		ret = PTR_ERR(file);
 		return ERR_PTR(ret);
@@ -3137,7 +3149,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	 */
 	hist_data = find_compatible_hist(target_hist_data, file);
 	if (!hist_data) {
-		hist_err_event("onmatch: Matching event histogram not found: ",
+		hist_err_event("trace action: Matching event histogram not found: ",
 			       subsys_name, event_name, field_name);
 		return ERR_PTR(-EINVAL);
 	}
@@ -3199,7 +3211,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		kfree(cmd);
 		kfree(var_hist->cmd);
 		kfree(var_hist);
-		hist_err_event("onmatch: Couldn't create histogram for field: ",
+		hist_err_event("trace action: Couldn't create histogram for field: ",
 			       subsys_name, event_name, field_name);
 		return ERR_PTR(ret);
 	}
@@ -3212,7 +3224,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	if (IS_ERR_OR_NULL(event_var)) {
 		kfree(var_hist->cmd);
 		kfree(var_hist);
-		hist_err_event("onmatch: Couldn't find synthetic variable: ",
+		hist_err_event("trace action: Couldn't find synthetic variable: ",
 			       subsys_name, event_name, field_name);
 		return ERR_PTR(-EINVAL);
 	}
@@ -3295,8 +3307,8 @@ static void update_max_vars(struct hist_trigger_data *hist_data,
 			    struct ring_buffer_event *rbe,
 			    void *rec)
 {
-	__update_field_vars(elt, rbe, rec, hist_data->max_vars,
-			    hist_data->n_max_vars, hist_data->n_field_var_str);
+	__update_field_vars(elt, rbe, rec, hist_data->save_vars,
+			    hist_data->n_save_vars, hist_data->n_field_var_str);
 }
 
 static struct hist_field *create_var(struct hist_trigger_data *hist_data,
@@ -3440,9 +3452,9 @@ static void onmax_print(struct seq_file *m,
 
 	seq_printf(m, "\n\tmax: %10llu", tracing_map_read_var(elt, max_idx));
 
-	for (i = 0; i < hist_data->n_max_vars; i++) {
-		struct hist_field *save_val = hist_data->max_vars[i]->val;
-		struct hist_field *save_var = hist_data->max_vars[i]->var;
+	for (i = 0; i < hist_data->n_save_vars; i++) {
+		struct hist_field *save_val = hist_data->save_vars[i]->val;
+		struct hist_field *save_var = hist_data->save_vars[i]->var;
 		u64 val;
 
 		save_var_idx = save_var->var.idx;
@@ -3459,7 +3471,7 @@ static void onmax_print(struct seq_file *m,
 
 static void onmax_save(struct hist_trigger_data *hist_data,
 		       struct tracing_map_elt *elt, void *rec,
-		       struct ring_buffer_event *rbe,
+		       struct ring_buffer_event *rbe, void *key,
 		       struct action_data *data, u64 *var_ref_vals)
 {
 	unsigned int max_idx = data->onmax.max_var->var.idx;
@@ -3486,7 +3498,7 @@ static void onmax_destroy(struct action_data *data)
 	destroy_hist_field(data->onmax.var, 0);
 
 	kfree(data->onmax.var_str);
-	kfree(data->onmax.fn_name);
+	kfree(data->action_name);
 
 	for (i = 0; i < data->n_params; i++)
 		kfree(data->params[i]);
@@ -3494,15 +3506,16 @@ static void onmax_destroy(struct action_data *data)
 	kfree(data);
 }
 
+static int action_create(struct hist_trigger_data *hist_data,
+			 struct action_data *data);
+
 static int onmax_create(struct hist_trigger_data *hist_data,
 			struct action_data *data)
 {
+	struct hist_field *var_field, *ref_field, *max_var = NULL;
 	struct trace_event_file *file = hist_data->event_file;
-	struct hist_field *var_field, *ref_field, *max_var;
 	unsigned int var_ref_idx = hist_data->n_var_refs;
-	struct field_var *field_var;
-	char *onmax_var_str, *param;
-	unsigned int i;
+	char *onmax_var_str;
 	int ret = 0;
 
 	onmax_var_str = data->onmax.var_str;
@@ -3524,8 +3537,8 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 
 	data->onmax.var = ref_field;
 
-	data->fn = onmax_save;
 	data->onmax.max_var_ref_idx = var_ref_idx;
+
 	max_var = create_var(hist_data, file, "max", sizeof(u64), "u64");
 	if (IS_ERR(max_var)) {
 		hist_err("onmax: Couldn't create onmax variable: ", "max");
@@ -3534,27 +3547,7 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 	}
 	data->onmax.max_var = max_var;
 
-	for (i = 0; i < data->n_params; i++) {
-		param = kstrdup(data->params[i], GFP_KERNEL);
-		if (!param) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		field_var = create_target_field_var(hist_data, NULL, NULL, param);
-		if (IS_ERR(field_var)) {
-			hist_err("onmax: Couldn't create field variable: ", param);
-			ret = PTR_ERR(field_var);
-			kfree(param);
-			goto out;
-		}
-
-		hist_data->max_vars[hist_data->n_max_vars++] = field_var;
-		if (field_var->val->flags & HIST_FIELD_FL_STRING)
-			hist_data->n_max_var_str++;
-
-		kfree(param);
-	}
+	ret = action_create(hist_data, data);
  out:
 	return ret;
 }
@@ -3565,11 +3558,14 @@ static int parse_action_params(char *params, struct action_data *data)
 	int ret = 0;
 
 	while (params) {
-		if (data->n_params >= SYNTH_FIELDS_MAX)
+		if (data->n_params >= SYNTH_FIELDS_MAX) {
+			hist_err("Too many action params", "");
 			goto out;
+		}
 
 		param = strsep(&params, ",");
 		if (!param) {
+			hist_err("No action param found", "");
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3593,10 +3589,71 @@ static int parse_action_params(char *params, struct action_data *data)
 	return ret;
 }
 
-static struct action_data *onmax_parse(char *str)
+static int action_parse(char *str, struct action_data *data,
+			enum handler_id handler)
+{
+	char *action_name;
+	int ret = 0;
+
+	strsep(&str, ".");
+	if (!str) {
+		hist_err("action parsing: No action found", "");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	action_name = strsep(&str, "(");
+	if (!action_name || !str) {
+		hist_err("action parsing: No action found", "");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (str_has_prefix(action_name, "save")) {
+		char *params = strsep(&str, ")");
+
+		if (!params) {
+			hist_err("action parsing: No params found for %s", "save");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = parse_action_params(params, data);
+		if (ret)
+			goto out;
+
+		if (handler == HANDLER_ONMAX)
+			data->fn = onmax_save;
+
+		data->action = ACTION_SAVE;
+	} else {
+		char *params = strsep(&str, ")");
+
+		if (params) {
+			ret = parse_action_params(params, data);
+			if (ret)
+				goto out;
+		}
+
+		data->fn = action_trace;
+		data->action = ACTION_TRACE;
+	}
+
+	data->action_name = kstrdup(action_name, GFP_KERNEL);
+	if (!data->action_name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	data->handler = handler;
+ out:
+	return ret;
+}
+
+static struct action_data *onmax_parse(char *str, enum handler_id handler)
 {
-	char *onmax_fn_name, *onmax_var_str;
 	struct action_data *data;
+	char *onmax_var_str;
 	int ret = -EINVAL;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
@@ -3615,33 +3672,9 @@ static struct action_data *onmax_parse(char *str)
 		goto free;
 	}
 
-	strsep(&str, ".");
-	if (!str)
-		goto free;
-
-	onmax_fn_name = strsep(&str, "(");
-	if (!onmax_fn_name || !str)
-		goto free;
-
-	if (str_has_prefix(onmax_fn_name, "save")) {
-		char *params = strsep(&str, ")");
-
-		if (!params) {
-			ret = -EINVAL;
-			goto free;
-		}
-
-		ret = parse_action_params(params, data);
-		if (ret)
-			goto free;
-	} else
-		goto free;
-
-	data->onmax.fn_name = kstrdup(onmax_fn_name, GFP_KERNEL);
-	if (!data->onmax.fn_name) {
-		ret = -ENOMEM;
+	ret = action_parse(str, data, handler);
+	if (ret)
 		goto free;
-	}
  out:
 	return data;
  free:
@@ -3658,7 +3691,7 @@ static void onmatch_destroy(struct action_data *data)
 
 	kfree(data->onmatch.match_event);
 	kfree(data->onmatch.match_event_system);
-	kfree(data->onmatch.synth_event_name);
+	kfree(data->action_name);
 
 	for (i = 0; i < data->n_params; i++)
 		kfree(data->params[i]);
@@ -3716,8 +3749,9 @@ static int check_synth_field(struct synth_event *event,
 }
 
 static struct hist_field *
-onmatch_find_var(struct hist_trigger_data *hist_data, struct action_data *data,
-		 char *system, char *event, char *var)
+trace_action_find_var(struct hist_trigger_data *hist_data,
+		      struct action_data *data,
+		      char *system, char *event, char *var)
 {
 	struct hist_field *hist_field;
 
@@ -3725,7 +3759,7 @@ onmatch_find_var(struct hist_trigger_data *hist_data, struct action_data *data,
 
 	hist_field = find_target_event_var(hist_data, system, event, var);
 	if (!hist_field) {
-		if (!system) {
+		if (!system && data->handler == HANDLER_ONMATCH) {
 			system = data->onmatch.match_event_system;
 			event = data->onmatch.match_event;
 		}
@@ -3734,15 +3768,15 @@ onmatch_find_var(struct hist_trigger_data *hist_data, struct action_data *data,
 	}
 
 	if (!hist_field)
-		hist_err_event("onmatch: Couldn't find onmatch param: $", system, event, var);
+		hist_err_event("trace action: Couldn't find param: $", system, event, var);
 
 	return hist_field;
 }
 
 static struct hist_field *
-onmatch_create_field_var(struct hist_trigger_data *hist_data,
-			 struct action_data *data, char *system,
-			 char *event, char *var)
+trace_action_create_field_var(struct hist_trigger_data *hist_data,
+			      struct action_data *data, char *system,
+			      char *event, char *var)
 {
 	struct hist_field *hist_field = NULL;
 	struct field_var *field_var;
@@ -3765,7 +3799,7 @@ onmatch_create_field_var(struct hist_trigger_data *hist_data,
 		 * looking for fields on the onmatch(system.event.xxx)
 		 * event.
 		 */
-		if (!system) {
+		if (!system && data->handler == HANDLER_ONMATCH) {
 			system = data->onmatch.match_event_system;
 			event = data->onmatch.match_event;
 		}
@@ -3791,9 +3825,8 @@ onmatch_create_field_var(struct hist_trigger_data *hist_data,
 	goto out;
 }
 
-static int onmatch_create(struct hist_trigger_data *hist_data,
-			  struct trace_event_file *file,
-			  struct action_data *data)
+static int trace_action_create(struct hist_trigger_data *hist_data,
+			       struct action_data *data)
 {
 	char *event_name, *param, *system = NULL;
 	struct hist_field *hist_field, *var_ref;
@@ -3804,11 +3837,12 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 
 	lockdep_assert_held(&event_mutex);
 
-	event = find_synth_event(data->onmatch.synth_event_name);
+	event = find_synth_event(data->action_name);
 	if (!event) {
-		hist_err("onmatch: Couldn't find synthetic event: ", data->onmatch.synth_event_name);
+		hist_err("trace action: Couldn't find synthetic event: ", data->action_name);
 		return -EINVAL;
 	}
+
 	event->ref++;
 
 	var_ref_idx = hist_data->n_var_refs;
@@ -3836,13 +3870,15 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 		}
 
 		if (param[0] == '$')
-			hist_field = onmatch_find_var(hist_data, data, system,
-						      event_name, param);
+			hist_field = trace_action_find_var(hist_data, data,
+							   system, event_name,
+							   param);
 		else
-			hist_field = onmatch_create_field_var(hist_data, data,
-							      system,
-							      event_name,
-							      param);
+			hist_field = trace_action_create_field_var(hist_data,
+								   data,
+								   system,
+								   event_name,
+								   param);
 
 		if (!hist_field) {
 			kfree(p);
@@ -3864,7 +3900,7 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 			continue;
 		}
 
-		hist_err_event("onmatch: Param type doesn't match synthetic event field type: ",
+		hist_err_event("trace action: Param type doesn't match synthetic event field type: ",
 			       system, event_name, param);
 		kfree(p);
 		ret = -EINVAL;
@@ -3872,12 +3908,11 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 	}
 
 	if (field_pos != event->n_fields) {
-		hist_err("onmatch: Param count doesn't match synthetic event field count: ", event->name);
+		hist_err("trace action: Param count doesn't match synthetic event field count: ", event->name);
 		ret = -EINVAL;
 		goto err;
 	}
 
-	data->fn = action_trace;
 	data->onmatch.synth_event = event;
 	data->onmatch.var_ref_idx = var_ref_idx;
  out:
@@ -3888,10 +3923,58 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 	goto out;
 }
 
+static int action_create(struct hist_trigger_data *hist_data,
+			 struct action_data *data)
+{
+	struct field_var *field_var;
+	unsigned int i;
+	char *param;
+	int ret = 0;
+
+	if (data->action == ACTION_TRACE)
+		return trace_action_create(hist_data, data);
+
+	if (data->action == ACTION_SAVE) {
+		if (hist_data->n_save_vars) {
+			ret = -EEXIST;
+			hist_err("save action: Can't have more than one save() action per hist", "");
+			goto out;
+		}
+
+		for (i = 0; i < data->n_params; i++) {
+			param = kstrdup(data->params[i], GFP_KERNEL);
+			if (!param) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			field_var = create_target_field_var(hist_data, NULL, NULL, param);
+			if (IS_ERR(field_var)) {
+				hist_err("save action: Couldn't create field variable: ", param);
+				ret = PTR_ERR(field_var);
+				kfree(param);
+				goto out;
+			}
+
+			hist_data->save_vars[hist_data->n_save_vars++] = field_var;
+			if (field_var->val->flags & HIST_FIELD_FL_STRING)
+				hist_data->n_save_var_str++;
+			kfree(param);
+		}
+	}
+ out:
+	return ret;
+}
+
+static int onmatch_create(struct hist_trigger_data *hist_data,
+			  struct action_data *data)
+{
+	return action_create(hist_data, data);
+}
+
 static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
 {
 	char *match_event, *match_event_system;
-	char *synth_event_name, *params;
 	struct action_data *data;
 	int ret = -EINVAL;
 
@@ -3929,31 +4012,7 @@ static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
 		goto free;
 	}
 
-	strsep(&str, ".");
-	if (!str) {
-		hist_err("onmatch: Missing . after onmatch(): ", str);
-		goto free;
-	}
-
-	synth_event_name = strsep(&str, "(");
-	if (!synth_event_name || !str) {
-		hist_err("onmatch: Missing opening paramlist paren: ", synth_event_name);
-		goto free;
-	}
-
-	data->onmatch.synth_event_name = kstrdup(synth_event_name, GFP_KERNEL);
-	if (!data->onmatch.synth_event_name) {
-		ret = -ENOMEM;
-		goto free;
-	}
-
-	params = strsep(&str, ")");
-	if (!params || !str || (str && strlen(str))) {
-		hist_err("onmatch: Missing closing paramlist paren: ", params);
-		goto free;
-	}
-
-	ret = parse_action_params(params, data);
+	ret = action_parse(str, data, HANDLER_ONMATCH);
 	if (ret)
 		goto free;
  out:
@@ -4394,9 +4453,9 @@ static void destroy_actions(struct hist_trigger_data *hist_data)
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 
-		if (data->fn == action_trace)
+		if (data->handler == HANDLER_ONMATCH)
 			onmatch_destroy(data);
-		else if (data->fn == onmax_save)
+		else if (data->handler == HANDLER_ONMAX)
 			onmax_destroy(data);
 		else
 			kfree(data);
@@ -4423,16 +4482,14 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 				ret = PTR_ERR(data);
 				break;
 			}
-			data->fn = action_trace;
 		} else if ((len = str_has_prefix(str, "onmax("))) {
 			char *action_str = str + len;
 
-			data = onmax_parse(action_str);
+			data = onmax_parse(action_str, HANDLER_ONMAX);
 			if (IS_ERR(data)) {
 				ret = PTR_ERR(data);
 				break;
 			}
-			data->fn = onmax_save;
 		} else {
 			ret = -EINVAL;
 			break;
@@ -4444,8 +4501,7 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 	return ret;
 }
 
-static int create_actions(struct hist_trigger_data *hist_data,
-			  struct trace_event_file *file)
+static int create_actions(struct hist_trigger_data *hist_data)
 {
 	struct action_data *data;
 	unsigned int i;
@@ -4454,14 +4510,17 @@ static int create_actions(struct hist_trigger_data *hist_data,
 	for (i = 0; i < hist_data->attrs->n_actions; i++) {
 		data = hist_data->actions[i];
 
-		if (data->fn == action_trace) {
-			ret = onmatch_create(hist_data, file, data);
+		if (data->handler == HANDLER_ONMATCH) {
+			ret = onmatch_create(hist_data, data);
 			if (ret)
-				return ret;
-		} else if (data->fn == onmax_save) {
+				break;
+		} else if (data->handler == HANDLER_ONMAX) {
 			ret = onmax_create(hist_data, data);
 			if (ret)
-				return ret;
+				break;
+		} else {
+			ret = -EINVAL;
+			break;
 		}
 	}
 
@@ -4477,26 +4536,42 @@ static void print_actions(struct seq_file *m,
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 
-		if (data->fn == onmax_save)
+		if (data->handler == HANDLER_ONMAX)
 			onmax_print(m, hist_data, elt, data);
 	}
 }
 
+static void print_action_spec(struct seq_file *m,
+			      struct hist_trigger_data *hist_data,
+			      struct action_data *data)
+{
+	unsigned int i;
+
+	if (data->action == ACTION_SAVE) {
+		for (i = 0; i < hist_data->n_save_vars; i++) {
+			seq_printf(m, "%s", hist_data->save_vars[i]->var->var.name);
+			if (i < hist_data->n_save_vars - 1)
+				seq_puts(m, ",");
+		}
+	} else if (data->action == ACTION_TRACE) {
+		for (i = 0; i < data->n_params; i++) {
+			if (i)
+				seq_puts(m, ",");
+			seq_printf(m, "%s", data->params[i]);
+		}
+	}
+}
+
 static void print_onmax_spec(struct seq_file *m,
 			     struct hist_trigger_data *hist_data,
 			     struct action_data *data)
 {
-	unsigned int i;
-
 	seq_puts(m, ":onmax(");
 	seq_printf(m, "%s", data->onmax.var_str);
-	seq_printf(m, ").%s(", data->onmax.fn_name);
+	seq_printf(m, ").%s(", data->action_name);
+
+	print_action_spec(m, hist_data, data);
 
-	for (i = 0; i < hist_data->n_max_vars; i++) {
-		seq_printf(m, "%s", hist_data->max_vars[i]->var->var.name);
-		if (i < hist_data->n_max_vars - 1)
-			seq_puts(m, ",");
-	}
 	seq_puts(m, ")");
 }
 
@@ -4504,18 +4579,12 @@ static void print_onmatch_spec(struct seq_file *m,
 			       struct hist_trigger_data *hist_data,
 			       struct action_data *data)
 {
-	unsigned int i;
-
 	seq_printf(m, ":onmatch(%s.%s).", data->onmatch.match_event_system,
 		   data->onmatch.match_event);
 
-	seq_printf(m, "%s(", data->onmatch.synth_event->name);
+	seq_printf(m, "%s(", data->action_name);
 
-	for (i = 0; i < data->n_params; i++) {
-		if (i)
-			seq_puts(m, ",");
-		seq_printf(m, "%s", data->params[i]);
-	}
+	print_action_spec(m, hist_data, data);
 
 	seq_puts(m, ")");
 }
@@ -4532,7 +4601,9 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 		struct action_data *data = hist_data->actions[i];
 		struct action_data *data_test = hist_data_test->actions[i];
 
-		if (data->fn != data_test->fn)
+		if (data->handler != data_test->handler)
+			return false;
+		if (data->action != data_test->action)
 			return false;
 
 		if (data->n_params != data_test->n_params)
@@ -4543,23 +4614,20 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 				return false;
 		}
 
-		if (data->fn == action_trace) {
-			if (strcmp(data->onmatch.synth_event_name,
-				   data_test->onmatch.synth_event_name) != 0)
-				return false;
+		if (strcmp(data->action_name, data_test->action_name) != 0)
+			return false;
+
+		if (data->handler == HANDLER_ONMATCH) {
 			if (strcmp(data->onmatch.match_event_system,
 				   data_test->onmatch.match_event_system) != 0)
 				return false;
 			if (strcmp(data->onmatch.match_event,
 				   data_test->onmatch.match_event) != 0)
 				return false;
-		} else if (data->fn == onmax_save) {
+		} else if (data->handler == HANDLER_ONMAX) {
 			if (strcmp(data->onmax.var_str,
 				   data_test->onmax.var_str) != 0)
 				return false;
-			if (strcmp(data->onmax.fn_name,
-				   data_test->onmax.fn_name) != 0)
-				return false;
 		}
 	}
 
@@ -4575,9 +4643,9 @@ static void print_actions_spec(struct seq_file *m,
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 
-		if (data->fn == action_trace)
+		if (data->handler == HANDLER_ONMATCH)
 			print_onmatch_spec(m, hist_data, data);
-		else if (data->fn == onmax_save)
+		else if (data->handler == HANDLER_ONMAX)
 			print_onmax_spec(m, hist_data, data);
 	}
 }
@@ -4770,14 +4838,15 @@ static inline void add_to_key(char *compound_key, void *key,
 static void
 hist_trigger_actions(struct hist_trigger_data *hist_data,
 		     struct tracing_map_elt *elt, void *rec,
-		     struct ring_buffer_event *rbe, u64 *var_ref_vals)
+		     struct ring_buffer_event *rbe, void *key,
+		     u64 *var_ref_vals)
 {
 	struct action_data *data;
 	unsigned int i;
 
 	for (i = 0; i < hist_data->n_actions; i++) {
 		data = hist_data->actions[i];
-		data->fn(hist_data, elt, rec, rbe, data, var_ref_vals);
+		data->fn(hist_data, elt, rec, rbe, key, data, var_ref_vals);
 	}
 }
 
@@ -4838,7 +4907,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 	hist_trigger_elt_update(hist_data, elt, rec, rbe, var_ref_vals);
 
 	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
-		hist_trigger_actions(hist_data, elt, rec, rbe, var_ref_vals);
+		hist_trigger_actions(hist_data, elt, rec, rbe, key, var_ref_vals);
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -5757,7 +5826,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	if (get_named_trigger_data(trigger_data))
 		goto enable;
 
-	ret = create_actions(hist_data, file);
+	ret = create_actions(hist_data);
 	if (ret)
 		goto out_unreg;
 
-- 
2.34.1


