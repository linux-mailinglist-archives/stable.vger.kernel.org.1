Return-Path: <stable+bounces-45694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BBE8CD369
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13DA2851B5
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F97814A4E9;
	Thu, 23 May 2024 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mQj7pgvi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8E313D2BD;
	Thu, 23 May 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470096; cv=none; b=UIV3mFu709H5DKtoFSqpZWMsuIZplAYG0+ioRkTLt/a8aO2EPlz9M2FH9gTKPGcUv91/BKdMSKvwyXJgL4Cqq06v41QtVgRcwxYuuMAsOoGKfadLeLJSErUTOp18AarHerqo7lkVgp0ilSvY8D12vyuWRoUYAjEK9GX48AVABhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470096; c=relaxed/simple;
	bh=JK4Lw6+bmkcV7118jblhoo4tJUaI1rDkEituQXd3H0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRYfQW+tGiuxDrpeltjEwqVB77f06lLtCrgjfXsddSn6j4fDjEPZcWR9vAdAUIEFUnW16BsxFV8sLujHfWyClouSmHKxcUKw+FLYxfgdboKO9WGOdOSNUDIMuBfHnLLxs+FuS42dJzx0Dxvqo5psP1FoIJA8fVkc+tXw7Jq2T4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mQj7pgvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0464DC32781;
	Thu, 23 May 2024 13:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470096;
	bh=JK4Lw6+bmkcV7118jblhoo4tJUaI1rDkEituQXd3H0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQj7pgviniZhNSvtpr8Qh5+DOZ4YowHnmUlJAAcWoXlkm519U4mnwbn0MYSbf7pl1
	 XcL78xNx9JKpKd0EbxUpRjcRkK76FXg0fLVigmWm2Z5HQwzqHsgrWSHfxBQjw5RU2d
	 o9pUkJTawwcwRoaSn537Ev3/Oidi1TE8Eu0elcIw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"stable@vger.kernel.org, George Guo" <guodongtai@kylinos.cn>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4.19 06/18] tracing: Use dyn_event framework for synthetic events
Date: Thu, 23 May 2024 15:12:29 +0200
Message-ID: <20240523130325.973749340@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130325.727602650@linuxfoundation.org>
References: <20240523130325.727602650@linuxfoundation.org>
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

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 7bbab38d07f3185fddf6fce126e2239010efdfce upstream.

Use dyn_event framework for synthetic events. This shows
synthetic events on "tracing/dynamic_events" file in addition
to tracing/synthetic_events interface.

User can also define new events via tracing/dynamic_events
with "s:" prefix. So, the new syntax is below;

  s:[synthetic/]EVENT_NAME TYPE ARG; [TYPE ARG;]...

To remove events via tracing/dynamic_events, you can use
"-:" prefix as same as other events.

Link: http://lkml.kernel.org/r/154140861301.17322.15454611233735614508.stgit@devbox

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/Kconfig             |    1 
 kernel/trace/trace.c             |    8 +
 kernel/trace/trace_events_hist.c |  265 ++++++++++++++++++++++++---------------
 3 files changed, 176 insertions(+), 98 deletions(-)

--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -633,6 +633,7 @@ config HIST_TRIGGERS
 	depends on ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select TRACING_MAP
 	select TRACING
+	select DYNAMIC_EVENTS
 	default n
 	help
 	  Hist triggers allow one or more arbitrary trace event fields
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4681,6 +4681,9 @@ static const char readme_msg[] =
 	"\t  accepts: event-definitions (one definition per line)\n"
 	"\t   Format: p[:[<group>/]<event>] <place> [<args>]\n"
 	"\t           r[maxactive][:[<group>/]<event>] <place> [<args>]\n"
+#ifdef CONFIG_HIST_TRIGGERS
+	"\t           s:[synthetic/]<event> <field> [<field>]\n"
+#endif
 	"\t           -:[<group>/]<event>\n"
 #ifdef CONFIG_KPROBE_EVENTS
 	"\t    place: [<module>:]<symbol>[+<offset>]|<memaddr>\n"
@@ -4694,6 +4697,11 @@ static const char readme_msg[] =
 	"\t           $stack<index>, $stack, $retval, $comm\n"
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>\n"
+#ifdef CONFIG_HIST_TRIGGERS
+	"\t    field: <stype> <name>;\n"
+	"\t    stype: u8/u16/u32/u64, s8/s16/s32/s64, pid_t,\n"
+	"\t           [unsigned] char/int/long\n"
+#endif
 #endif
 	"  events/\t\t- Directory containing all trace event subsystems:\n"
 	"      enable\t\t- Write 0/1 to enable/disable tracing of all events\n"
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -15,6 +15,7 @@
 
 #include "tracing_map.h"
 #include "trace.h"
+#include "trace_dynevent.h"
 
 #define SYNTH_SYSTEM		"synthetic"
 #define SYNTH_FIELDS_MAX	16
@@ -291,6 +292,21 @@ struct hist_trigger_data {
 	unsigned int			n_max_var_str;
 };
 
+static int synth_event_create(int argc, const char **argv);
+static int synth_event_show(struct seq_file *m, struct dyn_event *ev);
+static int synth_event_release(struct dyn_event *ev);
+static bool synth_event_is_busy(struct dyn_event *ev);
+static bool synth_event_match(const char *system, const char *event,
+			      struct dyn_event *ev);
+
+static struct dyn_event_operations synth_event_ops = {
+	.create = synth_event_create,
+	.show = synth_event_show,
+	.is_busy = synth_event_is_busy,
+	.free = synth_event_release,
+	.match = synth_event_match,
+};
+
 struct synth_field {
 	char *type;
 	char *name;
@@ -300,7 +316,7 @@ struct synth_field {
 };
 
 struct synth_event {
-	struct list_head			list;
+	struct dyn_event			devent;
 	int					ref;
 	char					*name;
 	struct synth_field			**fields;
@@ -311,6 +327,32 @@ struct synth_event {
 	struct tracepoint			*tp;
 };
 
+static bool is_synth_event(struct dyn_event *ev)
+{
+	return ev->ops == &synth_event_ops;
+}
+
+static struct synth_event *to_synth_event(struct dyn_event *ev)
+{
+	return container_of(ev, struct synth_event, devent);
+}
+
+static bool synth_event_is_busy(struct dyn_event *ev)
+{
+	struct synth_event *event = to_synth_event(ev);
+
+	return event->ref != 0;
+}
+
+static bool synth_event_match(const char *system, const char *event,
+			      struct dyn_event *ev)
+{
+	struct synth_event *sev = to_synth_event(ev);
+
+	return strcmp(sev->name, event) == 0 &&
+		(!system || strcmp(system, SYNTH_SYSTEM) == 0);
+}
+
 struct action_data;
 
 typedef void (*action_fn_t) (struct hist_trigger_data *hist_data,
@@ -401,7 +443,6 @@ static bool have_hist_err(void)
 	return false;
 }
 
-static LIST_HEAD(synth_event_list);
 static DEFINE_MUTEX(synth_event_mutex);
 
 struct synth_trace_event {
@@ -758,14 +799,12 @@ static void free_synth_field(struct synt
 	kfree(field);
 }
 
-static struct synth_field *parse_synth_field(int argc, char **argv,
+static struct synth_field *parse_synth_field(int argc, const char **argv,
 					     int *consumed)
 {
 	struct synth_field *field;
-	const char *prefix = NULL;
-	char *field_type = argv[0], *field_name;
+	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
 	int len, ret = 0;
-	char *array;
 
 	if (field_type[0] == ';')
 		field_type++;
@@ -782,20 +821,31 @@ static struct synth_field *parse_synth_f
 		*consumed = 2;
 	}
 
-	len = strlen(field_name);
-	if (field_name[len - 1] == ';')
-		field_name[len - 1] = '\0';
-
 	field = kzalloc(sizeof(*field), GFP_KERNEL);
 	if (!field)
 		return ERR_PTR(-ENOMEM);
 
-	len = strlen(field_type) + 1;
+	len = strlen(field_name);
 	array = strchr(field_name, '[');
 	if (array)
+		len -= strlen(array);
+	else if (field_name[len - 1] == ';')
+		len--;
+
+	field->name = kmemdup_nul(field_name, len, GFP_KERNEL);
+	if (!field->name) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	if (field_type[0] == ';')
+		field_type++;
+	len = strlen(field_type) + 1;
+	if (array)
 		len += strlen(array);
 	if (prefix)
 		len += strlen(prefix);
+
 	field->type = kzalloc(len, GFP_KERNEL);
 	if (!field->type) {
 		ret = -ENOMEM;
@@ -806,7 +856,8 @@ static struct synth_field *parse_synth_f
 	strcat(field->type, field_type);
 	if (array) {
 		strcat(field->type, array);
-		*array = '\0';
+		if (field->type[len - 1] == ';')
+			field->type[len - 1] = '\0';
 	}
 
 	field->size = synth_field_size(field->type);
@@ -820,11 +871,6 @@ static struct synth_field *parse_synth_f
 
 	field->is_signed = synth_field_signed(field->type);
 
-	field->name = kstrdup(field_name, GFP_KERNEL);
-	if (!field->name) {
-		ret = -ENOMEM;
-		goto free;
-	}
  out:
 	return field;
  free:
@@ -888,9 +934,13 @@ static inline void trace_synth(struct sy
 
 static struct synth_event *find_synth_event(const char *name)
 {
+	struct dyn_event *pos;
 	struct synth_event *event;
 
-	list_for_each_entry(event, &synth_event_list, list) {
+	for_each_dyn_event(pos) {
+		if (!is_synth_event(pos))
+			continue;
+		event = to_synth_event(pos);
 		if (strcmp(event->name, name) == 0)
 			return event;
 	}
@@ -941,7 +991,7 @@ static int register_synth_event(struct s
 
 	ret = set_synth_event_print_fmt(call);
 	if (ret < 0) {
-		trace_remove_event_call(call);
+		trace_remove_event_call_nolock(call);
 		goto err;
 	}
  out:
@@ -979,7 +1029,7 @@ static void free_synth_event(struct synt
 	kfree(event);
 }
 
-static struct synth_event *alloc_synth_event(char *event_name, int n_fields,
+static struct synth_event *alloc_synth_event(const char *name, int n_fields,
 					     struct synth_field **fields)
 {
 	struct synth_event *event;
@@ -991,7 +1041,7 @@ static struct synth_event *alloc_synth_e
 		goto out;
 	}
 
-	event->name = kstrdup(event_name, GFP_KERNEL);
+	event->name = kstrdup(name, GFP_KERNEL);
 	if (!event->name) {
 		kfree(event);
 		event = ERR_PTR(-ENOMEM);
@@ -1005,6 +1055,8 @@ static struct synth_event *alloc_synth_e
 		goto out;
 	}
 
+	dyn_event_init(&event->devent, &synth_event_ops);
+
 	for (i = 0; i < n_fields; i++)
 		event->fields[i] = fields[i];
 
@@ -1028,16 +1080,11 @@ struct hist_var_data {
 	struct hist_trigger_data *hist_data;
 };
 
-static int create_synth_event(int argc, char **argv)
+static int __create_synth_event(int argc, const char *name, const char **argv)
 {
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
 	struct synth_event *event = NULL;
-	bool delete_event = false;
 	int i, consumed = 0, n_fields = 0, ret = 0;
-	char *name;
-
-	mutex_lock(&event_mutex);
-	mutex_lock(&synth_event_mutex);
 
 	/*
 	 * Argument syntax:
@@ -1045,43 +1092,20 @@ static int create_synth_event(int argc,
 	 *  - Remove synthetic event: !<event_name> field[;field] ...
 	 *      where 'field' = type field_name
 	 */
-	if (argc < 1) {
-		ret = -EINVAL;
-		goto out;
-	}
 
-	name = argv[0];
-	if (name[0] == '!') {
-		delete_event = true;
-		name++;
-	}
+	if (name[0] == '\0' || argc < 1)
+		return -EINVAL;
+
+	mutex_lock(&event_mutex);
+	mutex_lock(&synth_event_mutex);
 
 	event = find_synth_event(name);
 	if (event) {
-		if (delete_event) {
-			if (event->ref) {
-				ret = -EBUSY;
-				goto out;
-			}
-			ret = unregister_synth_event(event);
-			if (!ret) {
-				list_del(&event->list);
-				free_synth_event(event);
-			}
-		} else
-			ret = -EEXIST;
-		goto out;
-	} else if (delete_event) {
-		ret = -ENOENT;
+		ret = -EEXIST;
 		goto out;
 	}
 
-	if (argc < 2) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	for (i = 1; i < argc - 1; i++) {
+	for (i = 0; i < argc - 1; i++) {
 		if (strcmp(argv[i], ";") == 0)
 			continue;
 		if (n_fields == SYNTH_FIELDS_MAX) {
@@ -1111,7 +1135,7 @@ static int create_synth_event(int argc,
 	}
 	ret = register_synth_event(event);
 	if (!ret)
-		list_add(&event->list, &synth_event_list);
+		dyn_event_add(&event->devent);
 	else
 		free_synth_event(event);
  out:
@@ -1126,57 +1150,77 @@ static int create_synth_event(int argc,
 	goto out;
 }
 
-static int release_all_synth_events(void)
+static int create_or_delete_synth_event(int argc, char **argv)
 {
-	struct synth_event *event, *e;
-	int ret = 0;
-
-	mutex_lock(&event_mutex);
-	mutex_lock(&synth_event_mutex);
-
-	list_for_each_entry(event, &synth_event_list, list) {
-		if (event->ref) {
-			mutex_unlock(&synth_event_mutex);
-			return -EBUSY;
-		}
-	}
+	const char *name = argv[0];
+	struct synth_event *event = NULL;
+	int ret;
 
-	list_for_each_entry_safe(event, e, &synth_event_list, list) {
-		ret = unregister_synth_event(event);
-		if (!ret) {
-			list_del(&event->list);
-			free_synth_event(event);
+	/* trace_run_command() ensures argc != 0 */
+	if (name[0] == '!') {
+		mutex_lock(&event_mutex);
+		mutex_lock(&synth_event_mutex);
+		event = find_synth_event(name + 1);
+		if (event) {
+			if (event->ref)
+				ret = -EBUSY;
+			else {
+				ret = unregister_synth_event(event);
+				if (!ret) {
+					dyn_event_remove(&event->devent);
+					free_synth_event(event);
+				}
+			}
 		} else
-			break;
+			ret = -ENOENT;
+		mutex_unlock(&synth_event_mutex);
+		mutex_unlock(&event_mutex);
+		return ret;
 	}
-	mutex_unlock(&synth_event_mutex);
-	mutex_unlock(&event_mutex);
 
-	return ret;
+	ret = __create_synth_event(argc - 1, name, (const char **)argv + 1);
+	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
-
-static void *synth_events_seq_start(struct seq_file *m, loff_t *pos)
+static int synth_event_create(int argc, const char **argv)
 {
-	mutex_lock(&synth_event_mutex);
+	const char *name = argv[0];
+	int len;
 
-	return seq_list_start(&synth_event_list, *pos);
+	if (name[0] != 's' || name[1] != ':')
+		return -ECANCELED;
+	name += 2;
+
+	/* This interface accepts group name prefix */
+	if (strchr(name, '/')) {
+		len = sizeof(SYNTH_SYSTEM "/") - 1;
+		if (strncmp(name, SYNTH_SYSTEM "/", len))
+			return -EINVAL;
+		name += len;
+	}
+	return __create_synth_event(argc - 1, name, argv + 1);
 }
 
-static void *synth_events_seq_next(struct seq_file *m, void *v, loff_t *pos)
+static int synth_event_release(struct dyn_event *ev)
 {
-	return seq_list_next(v, &synth_event_list, pos);
-}
+	struct synth_event *event = to_synth_event(ev);
+	int ret;
 
-static void synth_events_seq_stop(struct seq_file *m, void *v)
-{
-	mutex_unlock(&synth_event_mutex);
+	if (event->ref)
+		return -EBUSY;
+
+	ret = unregister_synth_event(event);
+	if (ret)
+		return ret;
+
+	dyn_event_remove(ev);
+	free_synth_event(event);
+	return 0;
 }
 
-static int synth_events_seq_show(struct seq_file *m, void *v)
+static int __synth_event_show(struct seq_file *m, struct synth_event *event)
 {
 	struct synth_field *field;
-	struct synth_event *event = v;
 	unsigned int i;
 
 	seq_printf(m, "%s\t", event->name);
@@ -1194,11 +1238,30 @@ static int synth_events_seq_show(struct
 	return 0;
 }
 
+static int synth_event_show(struct seq_file *m, struct dyn_event *ev)
+{
+	struct synth_event *event = to_synth_event(ev);
+
+	seq_printf(m, "s:%s/", event->class.system);
+
+	return __synth_event_show(m, event);
+}
+
+static int synth_events_seq_show(struct seq_file *m, void *v)
+{
+	struct dyn_event *ev = v;
+
+	if (!is_synth_event(ev))
+		return 0;
+
+	return __synth_event_show(m, to_synth_event(ev));
+}
+
 static const struct seq_operations synth_events_seq_op = {
-	.start  = synth_events_seq_start,
-	.next   = synth_events_seq_next,
-	.stop   = synth_events_seq_stop,
-	.show   = synth_events_seq_show
+	.start	= dyn_event_seq_start,
+	.next	= dyn_event_seq_next,
+	.stop	= dyn_event_seq_stop,
+	.show	= synth_events_seq_show,
 };
 
 static int synth_events_open(struct inode *inode, struct file *file)
@@ -1206,7 +1269,7 @@ static int synth_events_open(struct inod
 	int ret;
 
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
-		ret = release_all_synth_events();
+		ret = dyn_events_release_all(&synth_event_ops);
 		if (ret < 0)
 			return ret;
 	}
@@ -1219,7 +1282,7 @@ static ssize_t synth_events_write(struct
 				  size_t count, loff_t *ppos)
 {
 	return trace_parse_run_command(file, buffer, count, ppos,
-				       create_synth_event);
+				       create_or_delete_synth_event);
 }
 
 static const struct file_operations synth_events_fops = {
@@ -5913,6 +5976,12 @@ static __init int trace_events_hist_init
 	struct dentry *d_tracer;
 	int err = 0;
 
+	err = dyn_event_register(&synth_event_ops);
+	if (err) {
+		pr_warn("Could not register synth_event_ops\n");
+		return err;
+	}
+
 	d_tracer = tracing_init_dentry();
 	if (IS_ERR(d_tracer)) {
 		err = PTR_ERR(d_tracer);



