Return-Path: <stable+bounces-46132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDD18CEF65
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82391F214BD
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 14:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175635A0F9;
	Sat, 25 May 2024 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zmGh/EqE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D825A0E6;
	Sat, 25 May 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648478; cv=none; b=BJs/7klklM/w0NSIW0juI1s03+gCe5Bw7Kk+bVC2YLf/Ao/nJpW38M95b6RtvAqSNB/KAga/aw9IwqYH8IobtxWLoYuqDlpwZSw95XSStdhwgZDYyS5m46/kGJiU586dJgvSQj95kIRyZfGnxpJhb/jyJo85uOvjmLn1gP9jdhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648478; c=relaxed/simple;
	bh=BdtdYfa5wIecKQu4t1BuNKbVwkMuqbSe8rxNr3hJZ6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnCbULA0I0o+dUv1jL/a2pE+pEZ1UaPqMohKiJMJ+u97Z8+9e4inLAdGk88QyxKa2R98OWBveFzcfTMmZv0BN3gCPXqAgg4bqQpEzOlSMQB6MSuJr2cokv9wbOWn3vT7xRbdgW8JTiJevIJX+xd38/1mun0JoBKRLP0gbBQoXoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zmGh/EqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F68C2BD11;
	Sat, 25 May 2024 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716648478;
	bh=BdtdYfa5wIecKQu4t1BuNKbVwkMuqbSe8rxNr3hJZ6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zmGh/EqE7IQCRtTTE74L2U3/1MtFd+Be/K3szRQ9oUgG/pZhau1RgXHXVWGbD7rwT
	 +Q9G8LZPaD0Bk7Hlgz1ffvz24yDqHft8u+knW9doEQX1mc19Ul8bmrtxbPwQQ/8vJx
	 MkLMyjmT/nM9nDQBxi45iE3oupAebLupvFe+HZ/4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.315
Date: Sat, 25 May 2024 16:47:46 +0200
Message-ID: <2024052545-tubeless-jolliness-dee3@gregkh>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <2024052545-fridge-semester-b4a7@gregkh>
References: <2024052545-fridge-semester-b4a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index f523aa68a36b..cf601bd058ab 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -94,7 +94,6 @@ class KernelInclude(Include):
         # HINT: this is the only line I had to change / commented out:
         #path = utils.relative_path(None, path)
 
-        path = nodes.reprunicode(path)
         encoding = self.options.get(
             'encoding', self.state.document.settings.input_encoding)
         e_handler=self.state.document.settings.input_encoding_error_handler
diff --git a/Makefile b/Makefile
index ba5ae757b2c6..67d36496debd 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 314
+SUBLEVEL = 315
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 8cda3f7ddbae..2542f0881ac6 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -18,6 +18,8 @@
 #include "dm.h"
 
 #define DM_RESERVED_MAX_IOS		1024
+#define DM_MAX_TARGETS			1048576
+#define DM_MAX_TARGET_PARAMS		1024
 
 struct dm_kobject_holder {
 	struct kobject kobj;
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 88e89796ccbf..70929ff79eec 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1734,7 +1734,8 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 	if (copy_from_user(param_kernel, user, minimum_data_size))
 		return -EFAULT;
 
-	if (param_kernel->data_size < minimum_data_size)
+	if (unlikely(param_kernel->data_size < minimum_data_size) ||
+	    unlikely(param_kernel->data_size > DM_MAX_TARGETS * DM_MAX_TARGET_PARAMS))
 		return -EINVAL;
 
 	secure_data = param_kernel->flags & DM_SECURE_DATA_FLAG;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 3faaf21be5b6..4822f66b08d9 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -187,7 +187,12 @@ static int alloc_targets(struct dm_table *t, unsigned int num)
 int dm_table_create(struct dm_table **result, fmode_t mode,
 		    unsigned num_targets, struct mapped_device *md)
 {
-	struct dm_table *t = kzalloc(sizeof(*t), GFP_KERNEL);
+	struct dm_table *t;
+
+	if (num_targets > DM_MAX_TARGETS)
+		return -EOVERFLOW;
+
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
 
 	if (!t)
 		return -ENOMEM;
@@ -202,7 +207,7 @@ int dm_table_create(struct dm_table **result, fmode_t mode,
 
 	if (!num_targets) {
 		kfree(t);
-		return -ENOMEM;
+		return -EOVERFLOW;
 	}
 
 	if (alloc_targets(t, num_targets)) {
diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 6e81d782d8a0..d837a585f114 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -16,6 +16,7 @@
 #include <linux/console.h>
 #include <linux/vt_kern.h>
 #include <linux/input.h>
+#include <linux/irq_work.h>
 #include <linux/module.h>
 
 #define MAX_CONFIG_LEN		40
@@ -35,6 +36,25 @@ static int kgdboc_use_kms;  /* 1 if we use kernel mode switching */
 static struct tty_driver	*kgdb_tty_driver;
 static int			kgdb_tty_line;
 
+/*
+ * When we leave the debug trap handler we need to reset the keyboard status
+ * (since the original keyboard state gets partially clobbered by kdb use of
+ * the keyboard).
+ *
+ * The path to deliver the reset is somewhat circuitous.
+ *
+ * To deliver the reset we register an input handler, reset the keyboard and
+ * then deregister the input handler. However, to get this done right, we do
+ * have to carefully manage the calling context because we can only register
+ * input handlers from task context.
+ *
+ * In particular we need to trigger the action from the debug trap handler with
+ * all its NMI and/or NMI-like oddities. To solve this the kgdboc trap exit code
+ * (the "post_exception" callback) uses irq_work_queue(), which is NMI-safe, to
+ * schedule a callback from a hardirq context. From there we have to defer the
+ * work again, this time using schedule_work(), to get a callback using the
+ * system workqueue, which runs in task context.
+ */
 #ifdef CONFIG_KDB_KEYBOARD
 static int kgdboc_reset_connect(struct input_handler *handler,
 				struct input_dev *dev,
@@ -86,10 +106,17 @@ static void kgdboc_restore_input_helper(struct work_struct *dummy)
 
 static DECLARE_WORK(kgdboc_restore_input_work, kgdboc_restore_input_helper);
 
+static void kgdboc_queue_restore_input_helper(struct irq_work *unused)
+{
+	schedule_work(&kgdboc_restore_input_work);
+}
+
+static DEFINE_IRQ_WORK(kgdboc_restore_input_irq_work, kgdboc_queue_restore_input_helper);
+
 static void kgdboc_restore_input(void)
 {
 	if (likely(system_state == SYSTEM_RUNNING))
-		schedule_work(&kgdboc_restore_input_work);
+		irq_work_queue(&kgdboc_restore_input_irq_work);
 }
 
 static int kgdboc_register_kbd(char **cptr)
@@ -120,6 +147,7 @@ static void kgdboc_unregister_kbd(void)
 			i--;
 		}
 	}
+	irq_work_sync(&kgdboc_restore_input_irq_work);
 	flush_work(&kgdboc_restore_input_work);
 }
 #else /* ! CONFIG_KDB_KEYBOARD */
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 30b5646b2c0d..ba5324be100a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2957,6 +2957,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			 * alignment and size).
 			 */
 			ret = -EUCLEAN;
+			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
 			goto error;
 		}
 
diff --git a/include/linux/string.h b/include/linux/string.h
index 1e0c442b941e..f85860ab7e55 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -492,4 +492,24 @@ static inline void memcpy_and_pad(void *dest, size_t dest_len,
 		memcpy(dest, src, dest_len);
 }
 
+/**
+ * str_has_prefix - Test if a string has a given prefix
+ * @str: The string to test
+ * @prefix: The string to see if @str starts with
+ *
+ * A common way to test a prefix of a string is to do:
+ *  strncmp(str, prefix, sizeof(prefix) - 1)
+ *
+ * But this can lead to bugs due to typos, or if prefix is a pointer
+ * and not a constant. Instead use str_has_prefix().
+ *
+ * Returns: 0 if @str does not start with @prefix
+         strlen(@prefix) if @str does start with @prefix
+ */
+static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
+{
+	size_t len = strlen(prefix);
+	return strncmp(str, prefix, len) == 0 ? len : 0;
+}
+
 #endif /* _LINUX_STRING_H_ */
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
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e656d1e232da..f589c37b4573 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -518,6 +518,9 @@ config BPF_EVENTS
 	help
 	  This allows the user to attach BPF programs to kprobe events.
 
+config DYNAMIC_EVENTS
+	def_bool n
+
 config PROBE_EVENTS
 	def_bool n
 
@@ -630,6 +633,7 @@ config HIST_TRIGGERS
 	depends on ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select TRACING_MAP
 	select TRACING
+	select DYNAMIC_EVENTS
 	default n
 	help
 	  Hist triggers allow one or more arbitrary trace event fields
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f81dadbc7c4a..9ff3c4fa91b6 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -78,6 +78,7 @@ endif
 ifeq ($(CONFIG_TRACING),y)
 obj-$(CONFIG_KGDB_KDB) += trace_kdb.o
 endif
+obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
 obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
 obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e6b2d443bab9..8292c7441e23 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4470,7 +4470,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
 
 	cmp = strstrip(option);
 
-	if (strncmp(cmp, "no", 2) == 0) {
+	if (str_has_prefix(cmp, "no")) {
 		neg = 1;
 		cmp += 2;
 	}
@@ -4665,6 +4665,10 @@ static const char readme_msg[] =
 	"\t\t\t  traces\n"
 #endif
 #endif /* CONFIG_STACK_TRACER */
+#ifdef CONFIG_DYNAMIC_EVENTS
+	"  dynamic_events\t\t- Add/remove/show the generic dynamic events\n"
+	"\t\t\t  Write into this file to define/undefine new trace events.\n"
+#endif
 #ifdef CONFIG_KPROBE_EVENTS
 	"  kprobe_events\t\t- Add/remove/show the kernel dynamic events\n"
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
@@ -4677,6 +4681,9 @@ static const char readme_msg[] =
 	"\t  accepts: event-definitions (one definition per line)\n"
 	"\t   Format: p[:[<group>/]<event>] <place> [<args>]\n"
 	"\t           r[maxactive][:[<group>/]<event>] <place> [<args>]\n"
+#ifdef CONFIG_HIST_TRIGGERS
+	"\t           s:[synthetic/]<event> <field> [<field>]\n"
+#endif
 	"\t           -:[<group>/]<event>\n"
 #ifdef CONFIG_KPROBE_EVENTS
 	"\t    place: [<module>:]<symbol>[+<offset>]|<memaddr>\n"
@@ -4690,6 +4697,11 @@ static const char readme_msg[] =
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
@@ -4742,6 +4754,7 @@ static const char readme_msg[] =
 	"\t            [:size=#entries]\n"
 	"\t            [:pause][:continue][:clear]\n"
 	"\t            [:name=histname1]\n"
+	"\t            [:<handler>.<action>]\n"
 	"\t            [if <filter>]\n\n"
 	"\t    Note, special fields can be used as well:\n"
 	"\t            common_timestamp - to record current timestamp\n"
@@ -4787,7 +4800,16 @@ static const char readme_msg[] =
 	"\t    The enable_hist and disable_hist triggers can be used to\n"
 	"\t    have one event conditionally start and stop another event's\n"
 	"\t    already-attached hist trigger.  The syntax is analagous to\n"
-	"\t    the enable_event and disable_event triggers.\n"
+	"\t    the enable_event and disable_event triggers.\n\n"
+	"\t    Hist trigger handlers and actions are executed whenever a\n"
+	"\t    a histogram entry is added or updated.  They take the form:\n\n"
+	"\t        <handler>.<action>\n\n"
+	"\t    The available handlers are:\n\n"
+	"\t        onmatch(matching.event)  - invoke on addition or update\n"
+	"\t        onmax(var)               - invoke if var exceeds current max\n\n"
+	"\t    The available actions are:\n\n"
+	"\t        <synthetic_event>(param list)        - generate synthetic event\n"
+	"\t        save(field,...)                      - save current event fields\n"
 #endif
 ;
 
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
new file mode 100644
index 000000000000..f17a887abb66
--- /dev/null
+++ b/kernel/trace/trace_dynevent.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic dynamic event control interface
+ *
+ * Copyright (C) 2018 Masami Hiramatsu <mhiramat@kernel.org>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/tracefs.h>
+
+#include "trace.h"
+#include "trace_dynevent.h"
+
+static DEFINE_MUTEX(dyn_event_ops_mutex);
+static LIST_HEAD(dyn_event_ops_list);
+
+int dyn_event_register(struct dyn_event_operations *ops)
+{
+	if (!ops || !ops->create || !ops->show || !ops->is_busy ||
+	    !ops->free || !ops->match)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&ops->list);
+	mutex_lock(&dyn_event_ops_mutex);
+	list_add_tail(&ops->list, &dyn_event_ops_list);
+	mutex_unlock(&dyn_event_ops_mutex);
+	return 0;
+}
+
+int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
+{
+	struct dyn_event *pos, *n;
+	char *system = NULL, *event, *p;
+	int ret = -ENOENT;
+
+	if (argv[0][1] != ':')
+		return -EINVAL;
+
+	event = &argv[0][2];
+	p = strchr(event, '/');
+	if (p) {
+		system = event;
+		event = p + 1;
+		*p = '\0';
+	}
+	if (event[0] == '\0')
+		return -EINVAL;
+
+	mutex_lock(&event_mutex);
+	for_each_dyn_event_safe(pos, n) {
+		if (type && type != pos->ops)
+			continue;
+		if (pos->ops->match(system, event, pos)) {
+			ret = pos->ops->free(pos);
+			break;
+		}
+	}
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
+static int create_dyn_event(int argc, char **argv)
+{
+	struct dyn_event_operations *ops;
+	int ret;
+
+	if (argv[0][0] == '-')
+		return dyn_event_release(argc, argv, NULL);
+
+	mutex_lock(&dyn_event_ops_mutex);
+	list_for_each_entry(ops, &dyn_event_ops_list, list) {
+		ret = ops->create(argc, (const char **)argv);
+		if (!ret || ret != -ECANCELED)
+			break;
+	}
+	mutex_unlock(&dyn_event_ops_mutex);
+	if (ret == -ECANCELED)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+/* Protected by event_mutex */
+LIST_HEAD(dyn_event_list);
+
+void *dyn_event_seq_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&event_mutex);
+	return seq_list_start(&dyn_event_list, *pos);
+}
+
+void *dyn_event_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &dyn_event_list, pos);
+}
+
+void dyn_event_seq_stop(struct seq_file *m, void *v)
+{
+	mutex_unlock(&event_mutex);
+}
+
+static int dyn_event_seq_show(struct seq_file *m, void *v)
+{
+	struct dyn_event *ev = v;
+
+	if (ev && ev->ops)
+		return ev->ops->show(m, ev);
+
+	return 0;
+}
+
+static const struct seq_operations dyn_event_seq_op = {
+	.start	= dyn_event_seq_start,
+	.next	= dyn_event_seq_next,
+	.stop	= dyn_event_seq_stop,
+	.show	= dyn_event_seq_show
+};
+
+/*
+ * dyn_events_release_all - Release all specific events
+ * @type:	the dyn_event_operations * which filters releasing events
+ *
+ * This releases all events which ->ops matches @type. If @type is NULL,
+ * all events are released.
+ * Return -EBUSY if any of them are in use, and return other errors when
+ * it failed to free the given event. Except for -EBUSY, event releasing
+ * process will be aborted at that point and there may be some other
+ * releasable events on the list.
+ */
+int dyn_events_release_all(struct dyn_event_operations *type)
+{
+	struct dyn_event *ev, *tmp;
+	int ret = 0;
+
+	mutex_lock(&event_mutex);
+	for_each_dyn_event(ev) {
+		if (type && ev->ops != type)
+			continue;
+		if (ev->ops->is_busy(ev)) {
+			ret = -EBUSY;
+			goto out;
+		}
+	}
+	for_each_dyn_event_safe(ev, tmp) {
+		if (type && ev->ops != type)
+			continue;
+		ret = ev->ops->free(ev);
+		if (ret)
+			break;
+	}
+out:
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
+static int dyn_event_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
+		ret = dyn_events_release_all(NULL);
+		if (ret < 0)
+			return ret;
+	}
+
+	return seq_open(file, &dyn_event_seq_op);
+}
+
+static ssize_t dyn_event_write(struct file *file, const char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	return trace_parse_run_command(file, buffer, count, ppos,
+				       create_dyn_event);
+}
+
+static const struct file_operations dynamic_events_ops = {
+	.owner          = THIS_MODULE,
+	.open           = dyn_event_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = seq_release,
+	.write		= dyn_event_write,
+};
+
+/* Make a tracefs interface for controlling dynamic events */
+static __init int init_dynamic_event(void)
+{
+	struct dentry *d_tracer;
+	struct dentry *entry;
+
+	d_tracer = tracing_init_dentry();
+	if (IS_ERR(d_tracer))
+		return 0;
+
+	entry = tracefs_create_file("dynamic_events", 0644, d_tracer,
+				    NULL, &dynamic_events_ops);
+
+	/* Event list interface */
+	if (!entry)
+		pr_warn("Could not create tracefs 'dynamic_events' entry\n");
+
+	return 0;
+}
+fs_initcall(init_dynamic_event);
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
new file mode 100644
index 000000000000..8c334064e4d6
--- /dev/null
+++ b/kernel/trace/trace_dynevent.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common header file for generic dynamic events.
+ */
+
+#ifndef _TRACE_DYNEVENT_H
+#define _TRACE_DYNEVENT_H
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/seq_file.h>
+
+#include "trace.h"
+
+struct dyn_event;
+
+/**
+ * struct dyn_event_operations - Methods for each type of dynamic events
+ *
+ * These methods must be set for each type, since there is no default method.
+ * Before using this for dyn_event_init(), it must be registered by
+ * dyn_event_register().
+ *
+ * @create: Parse and create event method. This is invoked when user passes
+ *  a event definition to dynamic_events interface. This must not destruct
+ *  the arguments and return -ECANCELED if given arguments doesn't match its
+ *  command prefix.
+ * @show: Showing method. This is invoked when user reads the event definitions
+ *  via dynamic_events interface.
+ * @is_busy: Check whether given event is busy so that it can not be deleted.
+ *  Return true if it is busy, otherwides false.
+ * @free: Delete the given event. Return 0 if success, otherwides error.
+ * @match: Check whether given event and system name match this event.
+ *  Return true if it matches, otherwides false.
+ *
+ * Except for @create, these methods are called under holding event_mutex.
+ */
+struct dyn_event_operations {
+	struct list_head	list;
+	int (*create)(int argc, const char *argv[]);
+	int (*show)(struct seq_file *m, struct dyn_event *ev);
+	bool (*is_busy)(struct dyn_event *ev);
+	int (*free)(struct dyn_event *ev);
+	bool (*match)(const char *system, const char *event,
+			struct dyn_event *ev);
+};
+
+/* Register new dyn_event type -- must be called at first */
+int dyn_event_register(struct dyn_event_operations *ops);
+
+/**
+ * struct dyn_event - Dynamic event list header
+ *
+ * The dyn_event structure encapsulates a list and a pointer to the operators
+ * for making a global list of dynamic events.
+ * User must includes this in each event structure, so that those events can
+ * be added/removed via dynamic_events interface.
+ */
+struct dyn_event {
+	struct list_head		list;
+	struct dyn_event_operations	*ops;
+};
+
+extern struct list_head dyn_event_list;
+
+static inline
+int dyn_event_init(struct dyn_event *ev, struct dyn_event_operations *ops)
+{
+	if (!ev || !ops)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&ev->list);
+	ev->ops = ops;
+	return 0;
+}
+
+static inline int dyn_event_add(struct dyn_event *ev)
+{
+	lockdep_assert_held(&event_mutex);
+
+	if (!ev || !ev->ops)
+		return -EINVAL;
+
+	list_add_tail(&ev->list, &dyn_event_list);
+	return 0;
+}
+
+static inline void dyn_event_remove(struct dyn_event *ev)
+{
+	lockdep_assert_held(&event_mutex);
+	list_del_init(&ev->list);
+}
+
+void *dyn_event_seq_start(struct seq_file *m, loff_t *pos);
+void *dyn_event_seq_next(struct seq_file *m, void *v, loff_t *pos);
+void dyn_event_seq_stop(struct seq_file *m, void *v);
+int dyn_events_release_all(struct dyn_event_operations *type);
+int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type);
+
+/*
+ * for_each_dyn_event	-	iterate over the dyn_event list
+ * @pos:	the struct dyn_event * to use as a loop cursor
+ *
+ * This is just a basement of for_each macro. Wrap this for
+ * each actual event structure with ops filtering.
+ */
+#define for_each_dyn_event(pos)	\
+	list_for_each_entry(pos, &dyn_event_list, list)
+
+/*
+ * for_each_dyn_event	-	iterate over the dyn_event list safely
+ * @pos:	the struct dyn_event * to use as a loop cursor
+ * @n:		the struct dyn_event * to use as temporary storage
+ */
+#define for_each_dyn_event_safe(pos, n)	\
+	list_for_each_entry_safe(pos, n, &dyn_event_list, list)
+
+#endif
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 2830a9cbe648..a982cbfcb9f1 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1249,7 +1249,7 @@ static int f_show(struct seq_file *m, void *v)
 	 */
 	array_descriptor = strchr(field->type, '[');
 
-	if (!strncmp(field->type, "__data_loc", 10))
+	if (str_has_prefix(field->type, "__data_loc"))
 		array_descriptor = NULL;
 
 	if (!array_descriptor)
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
index ede370225245..6108c9176c21 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -15,6 +15,7 @@
 
 #include "tracing_map.h"
 #include "trace.h"
+#include "trace_dynevent.h"
 
 #define SYNTH_SYSTEM		"synthetic"
 #define SYNTH_FIELDS_MAX	16
@@ -286,9 +287,24 @@ struct hist_trigger_data {
 	struct field_var_hist		*field_var_hists[SYNTH_FIELDS_MAX];
 	unsigned int			n_field_var_hists;
 
-	struct field_var		*max_vars[SYNTH_FIELDS_MAX];
-	unsigned int			n_max_vars;
-	unsigned int			n_max_var_str;
+	struct field_var		*save_vars[SYNTH_FIELDS_MAX];
+	unsigned int			n_save_vars;
+	unsigned int			n_save_var_str;
+};
+
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
 };
 
 struct synth_field {
@@ -300,7 +316,7 @@ struct synth_field {
 };
 
 struct synth_event {
-	struct list_head			list;
+	struct dyn_event			devent;
 	int					ref;
 	char					*name;
 	struct synth_field			**fields;
@@ -311,38 +327,107 @@ struct synth_event {
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
 			     struct tracing_map_elt *elt, void *rec,
-			     struct ring_buffer_event *rbe,
+			     struct ring_buffer_event *rbe, void *key,
 			     struct action_data *data, u64 *var_ref_vals);
 
+typedef bool (*check_track_val_fn_t) (u64 track_val, u64 var_val);
+
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
 
+	/*
+	 * When a histogram trigger is hit, the values of any
+	 * references to variables, including variables being passed
+	 * as parameters to synthetic events, are collected into a
+	 * var_ref_vals array.  This var_ref_idx is the index of the
+	 * first param in the array to be passed to the synthetic
+	 * event invocation.
+	 */
+	unsigned int		var_ref_idx;
+	struct synth_event	*synth_event;
+
 	union {
 		struct {
-			unsigned int		var_ref_idx;
-			char			*match_event;
-			char			*match_event_system;
-			char			*synth_event_name;
-			struct synth_event	*synth_event;
-		} onmatch;
+			char			*event;
+			char			*event_system;
+		} match_data;
 
 		struct {
+			/*
+			 * var_str contains the $-unstripped variable
+			 * name referenced by var_ref, and used when
+			 * printing the action.  Because var_ref
+			 * creation is deferred to create_actions(),
+			 * we need a per-action way to save it until
+			 * then, thus var_str.
+			 */
 			char			*var_str;
-			char			*fn_name;
-			unsigned int		max_var_ref_idx;
-			struct hist_field	*max_var;
-			struct hist_field	*var;
-		} onmax;
+
+			/*
+			 * var_ref refers to the variable being
+			 * tracked e.g onmax($var).
+			 */
+			struct hist_field	*var_ref;
+
+			/*
+			 * track_var contains the 'invisible' tracking
+			 * variable created to keep the current
+			 * e.g. max value.
+			 */
+			struct hist_field	*track_var;
+
+			check_track_val_fn_t	check_val;
+			action_fn_t		save_data;
+		} track_data;
 	};
 };
 
-
 static char last_hist_cmd[MAX_FILTER_STR_VAL];
 static char hist_err_str[MAX_FILTER_STR_VAL];
 
@@ -401,9 +486,6 @@ static bool have_hist_err(void)
 	return false;
 }
 
-static LIST_HEAD(synth_event_list);
-static DEFINE_MUTEX(synth_event_mutex);
-
 struct synth_trace_event {
 	struct trace_entry	ent;
 	u64			fields[];
@@ -445,7 +527,7 @@ static int synth_event_define_fields(struct trace_event_call *call)
 
 static bool synth_field_signed(char *type)
 {
-	if (strncmp(type, "u", 1) == 0)
+	if (str_has_prefix(type, "u"))
 		return false;
 	if (strcmp(type, "gfp_t") == 0)
 		return false;
@@ -758,14 +840,12 @@ static void free_synth_field(struct synth_field *field)
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
@@ -782,20 +862,31 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
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
+	if (array)
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
 	if (array)
 		len += strlen(array);
 	if (prefix)
 		len += strlen(prefix);
+
 	field->type = kzalloc(len, GFP_KERNEL);
 	if (!field->type) {
 		ret = -ENOMEM;
@@ -806,7 +897,8 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 	strcat(field->type, field_type);
 	if (array) {
 		strcat(field->type, array);
-		*array = '\0';
+		if (field->type[len - 1] == ';')
+			field->type[len - 1] = '\0';
 	}
 
 	field->size = synth_field_size(field->type);
@@ -820,11 +912,6 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 
 	field->is_signed = synth_field_signed(field->type);
 
-	field->name = kstrdup(field_name, GFP_KERNEL);
-	if (!field->name) {
-		ret = -ENOMEM;
-		goto free;
-	}
  out:
 	return field;
  free:
@@ -888,9 +975,13 @@ static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
 
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
@@ -932,7 +1023,7 @@ static int register_synth_event(struct synth_event *event)
 	call->data = event;
 	call->tp = event->tp;
 
-	ret = trace_add_event_call_nolock(call);
+	ret = trace_add_event_call(call);
 	if (ret) {
 		pr_warn("Failed to register synthetic event: %s\n",
 			trace_event_name(call));
@@ -956,7 +1047,7 @@ static int unregister_synth_event(struct synth_event *event)
 	struct trace_event_call *call = &event->call;
 	int ret;
 
-	ret = trace_remove_event_call_nolock(call);
+	ret = trace_remove_event_call(call);
 
 	return ret;
 }
@@ -979,7 +1070,7 @@ static void free_synth_event(struct synth_event *event)
 	kfree(event);
 }
 
-static struct synth_event *alloc_synth_event(char *event_name, int n_fields,
+static struct synth_event *alloc_synth_event(const char *name, int n_fields,
 					     struct synth_field **fields)
 {
 	struct synth_event *event;
@@ -991,7 +1082,7 @@ static struct synth_event *alloc_synth_event(char *event_name, int n_fields,
 		goto out;
 	}
 
-	event->name = kstrdup(event_name, GFP_KERNEL);
+	event->name = kstrdup(name, GFP_KERNEL);
 	if (!event->name) {
 		kfree(event);
 		event = ERR_PTR(-ENOMEM);
@@ -1005,6 +1096,8 @@ static struct synth_event *alloc_synth_event(char *event_name, int n_fields,
 		goto out;
 	}
 
+	dyn_event_init(&event->devent, &synth_event_ops);
+
 	for (i = 0; i < n_fields; i++)
 		event->fields[i] = fields[i];
 
@@ -1015,12 +1108,12 @@ static struct synth_event *alloc_synth_event(char *event_name, int n_fields,
 
 static void action_trace(struct hist_trigger_data *hist_data,
 			 struct tracing_map_elt *elt, void *rec,
-			 struct ring_buffer_event *rbe,
+			 struct ring_buffer_event *rbe, void *key,
 			 struct action_data *data, u64 *var_ref_vals)
 {
-	struct synth_event *event = data->onmatch.synth_event;
+	struct synth_event *event = data->synth_event;
 
-	trace_synth(event, var_ref_vals, data->onmatch.var_ref_idx);
+	trace_synth(event, var_ref_vals, data->var_ref_idx);
 }
 
 struct hist_var_data {
@@ -1028,28 +1121,11 @@ struct hist_var_data {
 	struct hist_trigger_data *hist_data;
 };
 
-static void add_or_delete_synth_event(struct synth_event *event, int delete)
-{
-	if (delete)
-		free_synth_event(event);
-	else {
-		if (!find_synth_event(event->name))
-			list_add(&event->list, &synth_event_list);
-		else
-			free_synth_event(event);
-	}
-}
-
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
@@ -1057,42 +1133,19 @@ static int create_synth_event(int argc, char **argv)
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
 
 	event = find_synth_event(name);
 	if (event) {
-		if (delete_event) {
-			if (event->ref) {
-				event = NULL;
-				ret = -EBUSY;
-				goto out;
-			}
-			list_del(&event->list);
-			goto out;
-		}
-		event = NULL;
 		ret = -EEXIST;
 		goto out;
-	} else if (delete_event) {
-		ret = -ENOENT;
-		goto out;
-	}
-
-	if (argc < 2) {
-		ret = -EINVAL;
-		goto out;
 	}
 
-	for (i = 1; i < argc - 1; i++) {
+	for (i = 0; i < argc - 1; i++) {
 		if (strcmp(argv[i], ";") == 0)
 			continue;
 		if (n_fields == SYNTH_FIELDS_MAX) {
@@ -1120,80 +1173,91 @@ static int create_synth_event(int argc, char **argv)
 		event = NULL;
 		goto err;
 	}
+	ret = register_synth_event(event);
+	if (!ret)
+		dyn_event_add(&event->devent);
+	else
+		free_synth_event(event);
  out:
-	if (event) {
-		if (delete_event) {
-			ret = unregister_synth_event(event);
-			add_or_delete_synth_event(event, !ret);
-		} else {
-			ret = register_synth_event(event);
-			add_or_delete_synth_event(event, ret);
-		}
-	}
-	mutex_unlock(&synth_event_mutex);
 	mutex_unlock(&event_mutex);
 
 	return ret;
  err:
-	mutex_unlock(&synth_event_mutex);
-	mutex_unlock(&event_mutex);
-
 	for (i = 0; i < n_fields; i++)
 		free_synth_field(fields[i]);
-	free_synth_event(event);
 
-	return ret;
+	goto out;
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
-
-	list_for_each_entry_safe(event, e, &synth_event_list, list) {
-		list_del(&event->list);
+	const char *name = argv[0];
+	struct synth_event *event = NULL;
+	int ret;
 
-		ret = unregister_synth_event(event);
-		add_or_delete_synth_event(event, !ret);
+	/* trace_run_command() ensures argc != 0 */
+	if (name[0] == '!') {
+		mutex_lock(&event_mutex);
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
+		} else
+			ret = -ENOENT;
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
-}
+	if (name[0] != 's' || name[1] != ':')
+		return -ECANCELED;
+	name += 2;
 
-static void *synth_events_seq_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	return seq_list_next(v, &synth_event_list, pos);
+	/* This interface accepts group name prefix */
+	if (strchr(name, '/')) {
+		len = sizeof(SYNTH_SYSTEM "/") - 1;
+		if (strncmp(name, SYNTH_SYSTEM "/", len))
+			return -EINVAL;
+		name += len;
+	}
+	return __create_synth_event(argc - 1, name, argv + 1);
 }
 
-static void synth_events_seq_stop(struct seq_file *m, void *v)
+static int synth_event_release(struct dyn_event *ev)
 {
-	mutex_unlock(&synth_event_mutex);
+	struct synth_event *event = to_synth_event(ev);
+	int ret;
+
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
@@ -1211,11 +1275,30 @@ static int synth_events_seq_show(struct seq_file *m, void *v)
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
@@ -1223,7 +1306,7 @@ static int synth_events_open(struct inode *inode, struct file *file)
 	int ret;
 
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
-		ret = release_all_synth_events();
+		ret = dyn_events_release_all(&synth_event_ops);
 		if (ret < 0)
 			return ret;
 	}
@@ -1236,7 +1319,7 @@ static ssize_t synth_events_write(struct file *file,
 				  size_t count, loff_t *ppos)
 {
 	return trace_parse_run_command(file, buffer, count, ppos,
-				       create_synth_event);
+				       create_or_delete_synth_event);
 }
 
 static const struct file_operations synth_events_fops = {
@@ -1595,9 +1678,9 @@ find_match_var(struct hist_trigger_data *hist_data, char *var_name)
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 
-		if (data->fn == action_trace) {
-			char *system = data->onmatch.match_event_system;
-			char *event_name = data->onmatch.match_event;
+		if (data->handler == HANDLER_ONMATCH) {
+			char *system = data->match_data.event_system;
+			char *event_name = data->match_data.event;
 
 			file = find_var_file(tr, system, event_name, var_name);
 			if (!file)
@@ -1838,8 +1921,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
 	if (attrs->n_actions >= HIST_ACTIONS_MAX)
 		return ret;
 
-	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0) ||
-	    (strncmp(str, "onmax(", strlen("onmax(")) == 0)) {
+	if ((str_has_prefix(str, "onmatch(")) ||
+	    (str_has_prefix(str, "onmax("))) {
 		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
 		if (!attrs->action_str[attrs->n_actions]) {
 			ret = -ENOMEM;
@@ -1856,34 +1939,34 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 {
 	int ret = 0;
 
-	if ((strncmp(str, "key=", strlen("key=")) == 0) ||
-	    (strncmp(str, "keys=", strlen("keys=")) == 0)) {
+	if ((str_has_prefix(str, "key=")) ||
+	    (str_has_prefix(str, "keys="))) {
 		attrs->keys_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->keys_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if ((strncmp(str, "val=", strlen("val=")) == 0) ||
-		 (strncmp(str, "vals=", strlen("vals=")) == 0) ||
-		 (strncmp(str, "values=", strlen("values=")) == 0)) {
+	} else if ((str_has_prefix(str, "val=")) ||
+		   (str_has_prefix(str, "vals=")) ||
+		   (str_has_prefix(str, "values="))) {
 		attrs->vals_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->vals_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "sort=", strlen("sort=")) == 0) {
+	} else if (str_has_prefix(str, "sort=")) {
 		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->sort_key_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "name=", strlen("name=")) == 0) {
+	} else if (str_has_prefix(str, "name=")) {
 		attrs->name = kstrdup(str, GFP_KERNEL);
 		if (!attrs->name) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "clock=", strlen("clock=")) == 0) {
+	} else if (str_has_prefix(str, "clock=")) {
 		strsep(&str, "=");
 		if (!str) {
 			ret = -EINVAL;
@@ -1896,7 +1979,7 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "size=", strlen("size=")) == 0) {
+	} else if (str_has_prefix(str, "size=")) {
 		int map_bits = parse_map_size(str);
 
 		if (map_bits < 0) {
@@ -2033,7 +2116,7 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 		}
 	}
 
-	n_str = hist_data->n_field_var_str + hist_data->n_max_var_str;
+	n_str = hist_data->n_field_var_str + hist_data->n_save_var_str;
 
 	size = STR_VAR_LEN_MAX;
 
@@ -3075,7 +3158,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	int ret;
 
 	if (target_hist_data->n_field_var_hists >= SYNTH_FIELDS_MAX) {
-		hist_err_event("onmatch: Too many field variables defined: ",
+		hist_err_event("trace action: Too many field variables defined: ",
 			       subsys_name, event_name, field_name);
 		return ERR_PTR(-EINVAL);
 	}
@@ -3083,7 +3166,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	file = event_file(tr, subsys_name, event_name);
 
 	if (IS_ERR(file)) {
-		hist_err_event("onmatch: Event file not found: ",
+		hist_err_event("trace action: Event file not found: ",
 			       subsys_name, event_name, field_name);
 		ret = PTR_ERR(file);
 		return ERR_PTR(ret);
@@ -3097,7 +3180,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	 */
 	hist_data = find_compatible_hist(target_hist_data, file);
 	if (!hist_data) {
-		hist_err_event("onmatch: Matching event histogram not found: ",
+		hist_err_event("trace action: Matching event histogram not found: ",
 			       subsys_name, event_name, field_name);
 		return ERR_PTR(-EINVAL);
 	}
@@ -3159,7 +3242,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		kfree(cmd);
 		kfree(var_hist->cmd);
 		kfree(var_hist);
-		hist_err_event("onmatch: Couldn't create histogram for field: ",
+		hist_err_event("trace action: Couldn't create histogram for field: ",
 			       subsys_name, event_name, field_name);
 		return ERR_PTR(ret);
 	}
@@ -3172,7 +3255,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	if (IS_ERR_OR_NULL(event_var)) {
 		kfree(var_hist->cmd);
 		kfree(var_hist);
-		hist_err_event("onmatch: Couldn't find synthetic variable: ",
+		hist_err_event("trace action: Couldn't find synthetic variable: ",
 			       subsys_name, event_name, field_name);
 		return ERR_PTR(-EINVAL);
 	}
@@ -3250,13 +3333,13 @@ static void update_field_vars(struct hist_trigger_data *hist_data,
 			    hist_data->n_field_vars, 0);
 }
 
-static void update_max_vars(struct hist_trigger_data *hist_data,
-			    struct tracing_map_elt *elt,
-			    struct ring_buffer_event *rbe,
-			    void *rec)
+static void save_track_data_vars(struct hist_trigger_data *hist_data,
+				 struct tracing_map_elt *elt, void *rec,
+				 struct ring_buffer_event *rbe, void *key,
+				 struct action_data *data, u64 *var_ref_vals)
 {
-	__update_field_vars(elt, rbe, rec, hist_data->max_vars,
-			    hist_data->n_max_vars, hist_data->n_field_var_str);
+	__update_field_vars(elt, rbe, rec, hist_data->save_vars,
+			    hist_data->n_save_vars, hist_data->n_field_var_str);
 }
 
 static struct hist_field *create_var(struct hist_trigger_data *hist_data,
@@ -3391,18 +3474,71 @@ create_target_field_var(struct hist_trigger_data *target_hist_data,
 	return create_field_var(target_hist_data, file, var_name);
 }
 
-static void onmax_print(struct seq_file *m,
-			struct hist_trigger_data *hist_data,
-			struct tracing_map_elt *elt,
-			struct action_data *data)
+static bool check_track_val_max(u64 track_val, u64 var_val)
+{
+	if (var_val <= track_val)
+		return false;
+
+	return true;
+}
+
+static u64 get_track_val(struct hist_trigger_data *hist_data,
+			 struct tracing_map_elt *elt,
+			 struct action_data *data)
+{
+	unsigned int track_var_idx = data->track_data.track_var->var.idx;
+	u64 track_val;
+
+	track_val = tracing_map_read_var(elt, track_var_idx);
+
+	return track_val;
+}
+
+static void save_track_val(struct hist_trigger_data *hist_data,
+			   struct tracing_map_elt *elt,
+			   struct action_data *data, u64 var_val)
+{
+	unsigned int track_var_idx = data->track_data.track_var->var.idx;
+
+	tracing_map_set_var(elt, track_var_idx, var_val);
+}
+
+static void save_track_data(struct hist_trigger_data *hist_data,
+			    struct tracing_map_elt *elt, void *rec,
+			    struct ring_buffer_event *rbe, void *key,
+			    struct action_data *data, u64 *var_ref_vals)
+{
+	if (data->track_data.save_data)
+		data->track_data.save_data(hist_data, elt, rec, rbe, key, data, var_ref_vals);
+}
+
+static bool check_track_val(struct tracing_map_elt *elt,
+			    struct action_data *data,
+			    u64 var_val)
 {
-	unsigned int i, save_var_idx, max_idx = data->onmax.max_var->var.idx;
+	struct hist_trigger_data *hist_data;
+	u64 track_val;
+
+	hist_data = data->track_data.track_var->hist_data;
+	track_val = get_track_val(hist_data, elt, data);
 
-	seq_printf(m, "\n\tmax: %10llu", tracing_map_read_var(elt, max_idx));
+	return data->track_data.check_val(track_val, var_val);
+}
+
+static void track_data_print(struct seq_file *m,
+			     struct hist_trigger_data *hist_data,
+			     struct tracing_map_elt *elt,
+			     struct action_data *data)
+{
+	u64 track_val = get_track_val(hist_data, elt, data);
+	unsigned int i, save_var_idx;
 
-	for (i = 0; i < hist_data->n_max_vars; i++) {
-		struct hist_field *save_val = hist_data->max_vars[i]->val;
-		struct hist_field *save_var = hist_data->max_vars[i]->var;
+	if (data->handler == HANDLER_ONMAX)
+		seq_printf(m, "\n\tmax: %10llu", track_val);
+
+	for (i = 0; i < hist_data->n_save_vars; i++) {
+		struct hist_field *save_val = hist_data->save_vars[i]->val;
+		struct hist_field *save_var = hist_data->save_vars[i]->var;
 		u64 val;
 
 		save_var_idx = save_var->var.idx;
@@ -3417,64 +3553,67 @@ static void onmax_print(struct seq_file *m,
 	}
 }
 
-static void onmax_save(struct hist_trigger_data *hist_data,
-		       struct tracing_map_elt *elt, void *rec,
-		       struct ring_buffer_event *rbe,
-		       struct action_data *data, u64 *var_ref_vals)
+static void ontrack_action(struct hist_trigger_data *hist_data,
+			   struct tracing_map_elt *elt, void *rec,
+			   struct ring_buffer_event *rbe, void *key,
+			   struct action_data *data, u64 *var_ref_vals)
 {
-	unsigned int max_idx = data->onmax.max_var->var.idx;
-	unsigned int max_var_ref_idx = data->onmax.max_var_ref_idx;
-
-	u64 var_val, max_val;
-
-	var_val = var_ref_vals[max_var_ref_idx];
-	max_val = tracing_map_read_var(elt, max_idx);
-
-	if (var_val <= max_val)
-		return;
-
-	tracing_map_set_var(elt, max_idx, var_val);
+	u64 var_val = var_ref_vals[data->track_data.var_ref->var_ref_idx];
 
-	update_max_vars(hist_data, elt, rbe, rec);
+	if (check_track_val(elt, data, var_val)) {
+		save_track_val(hist_data, elt, data, var_val);
+		save_track_data(hist_data, elt, rec, rbe, key, data, var_ref_vals);
+	}
 }
 
-static void onmax_destroy(struct action_data *data)
+static void action_data_destroy(struct action_data *data)
 {
 	unsigned int i;
 
-	destroy_hist_field(data->onmax.max_var, 0);
-	destroy_hist_field(data->onmax.var, 0);
+	lockdep_assert_held(&event_mutex);
 
-	kfree(data->onmax.var_str);
-	kfree(data->onmax.fn_name);
+	kfree(data->action_name);
 
 	for (i = 0; i < data->n_params; i++)
 		kfree(data->params[i]);
 
+	if (data->synth_event)
+		data->synth_event->ref--;
+
 	kfree(data);
 }
 
-static int onmax_create(struct hist_trigger_data *hist_data,
-			struct action_data *data)
+static void track_data_destroy(struct hist_trigger_data *hist_data,
+			       struct action_data *data)
 {
+	destroy_hist_field(data->track_data.track_var, 0);
+
+	kfree(data->track_data.var_str);
+
+	action_data_destroy(data);
+}
+
+static int action_create(struct hist_trigger_data *hist_data,
+			 struct action_data *data);
+
+static int track_data_create(struct hist_trigger_data *hist_data,
+			     struct action_data *data)
+{
+	struct hist_field *var_field, *ref_field, *track_var = NULL;
 	struct trace_event_file *file = hist_data->event_file;
-	struct hist_field *var_field, *ref_field, *max_var;
-	unsigned int var_ref_idx = hist_data->n_var_refs;
-	struct field_var *field_var;
-	char *onmax_var_str, *param;
-	unsigned int i;
+	char *track_data_var_str;
 	int ret = 0;
 
-	onmax_var_str = data->onmax.var_str;
-	if (onmax_var_str[0] != '$') {
-		hist_err("onmax: For onmax(x), x must be a variable: ", onmax_var_str);
+	track_data_var_str = data->track_data.var_str;
+	if (track_data_var_str[0] != '$') {
+		hist_err("For onmax(x), x must be a variable: ", track_data_var_str);
 		return -EINVAL;
 	}
-	onmax_var_str++;
+	track_data_var_str++;
 
-	var_field = find_target_event_var(hist_data, NULL, NULL, onmax_var_str);
+	var_field = find_target_event_var(hist_data, NULL, NULL, track_data_var_str);
 	if (!var_field) {
-		hist_err("onmax: Couldn't find onmax variable: ", onmax_var_str);
+		hist_err("Couldn't find onmax variable: ", track_data_var_str);
 		return -EINVAL;
 	}
 
@@ -3482,39 +3621,18 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 	if (!ref_field)
 		return -ENOMEM;
 
-	data->onmax.var = ref_field;
+	data->track_data.var_ref = ref_field;
 
-	data->fn = onmax_save;
-	data->onmax.max_var_ref_idx = var_ref_idx;
-	max_var = create_var(hist_data, file, "max", sizeof(u64), "u64");
-	if (IS_ERR(max_var)) {
-		hist_err("onmax: Couldn't create onmax variable: ", "max");
-		ret = PTR_ERR(max_var);
+	if (data->handler == HANDLER_ONMAX)
+		track_var = create_var(hist_data, file, "__max", sizeof(u64), "u64");
+	if (IS_ERR(track_var)) {
+		hist_err("Couldn't create onmax variable: ", "__max");
+		ret = PTR_ERR(track_var);
 		goto out;
 	}
-	data->onmax.max_var = max_var;
+	data->track_data.track_var = track_var;
 
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
@@ -3525,11 +3643,14 @@ static int parse_action_params(char *params, struct action_data *data)
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
@@ -3553,82 +3674,122 @@ static int parse_action_params(char *params, struct action_data *data)
 	return ret;
 }
 
-static struct action_data *onmax_parse(char *str)
+static int action_parse(char *str, struct action_data *data,
+			enum handler_id handler)
 {
-	char *onmax_fn_name, *onmax_var_str;
-	struct action_data *data;
-	int ret = -EINVAL;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return ERR_PTR(-ENOMEM);
+	char *action_name;
+	int ret = 0;
 
-	onmax_var_str = strsep(&str, ")");
-	if (!onmax_var_str || !str) {
+	strsep(&str, ".");
+	if (!str) {
+		hist_err("action parsing: No action found", "");
 		ret = -EINVAL;
-		goto free;
+		goto out;
 	}
 
-	data->onmax.var_str = kstrdup(onmax_var_str, GFP_KERNEL);
-	if (!data->onmax.var_str) {
-		ret = -ENOMEM;
-		goto free;
+	action_name = strsep(&str, "(");
+	if (!action_name || !str) {
+		hist_err("action parsing: No action found", "");
+		ret = -EINVAL;
+		goto out;
 	}
 
-	strsep(&str, ".");
-	if (!str)
-		goto free;
-
-	onmax_fn_name = strsep(&str, "(");
-	if (!onmax_fn_name || !str)
-		goto free;
-
-	if (strncmp(onmax_fn_name, "save", strlen("save")) == 0) {
+	if (str_has_prefix(action_name, "save")) {
 		char *params = strsep(&str, ")");
 
 		if (!params) {
+			hist_err("action parsing: No params found for %s", "save");
 			ret = -EINVAL;
-			goto free;
+			goto out;
 		}
 
 		ret = parse_action_params(params, data);
 		if (ret)
-			goto free;
-	} else
+			goto out;
+
+		if (handler == HANDLER_ONMAX)
+			data->track_data.check_val = check_track_val_max;
+		else {
+			hist_err("action parsing: Handler doesn't support action: ", action_name);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		data->track_data.save_data = save_track_data_vars;
+		data->fn = ontrack_action;
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
+		if (handler == HANDLER_ONMAX)
+			data->track_data.check_val = check_track_val_max;
+
+		if (handler != HANDLER_ONMATCH) {
+			data->track_data.save_data = action_trace;
+			data->fn = ontrack_action;
+		} else
+			data->fn = action_trace;
+
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
+static struct action_data *track_data_parse(struct hist_trigger_data *hist_data,
+					    char *str, enum handler_id handler)
+{
+	struct action_data *data;
+	int ret = -EINVAL;
+	char *var_str;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	var_str = strsep(&str, ")");
+	if (!var_str || !str) {
+		ret = -EINVAL;
 		goto free;
+	}
 
-	data->onmax.fn_name = kstrdup(onmax_fn_name, GFP_KERNEL);
-	if (!data->onmax.fn_name) {
+	data->track_data.var_str = kstrdup(var_str, GFP_KERNEL);
+	if (!data->track_data.var_str) {
 		ret = -ENOMEM;
 		goto free;
 	}
+
+	ret = action_parse(str, data, handler);
+	if (ret)
+		goto free;
  out:
 	return data;
  free:
-	onmax_destroy(data);
+	track_data_destroy(hist_data, data);
 	data = ERR_PTR(ret);
 	goto out;
 }
 
 static void onmatch_destroy(struct action_data *data)
 {
-	unsigned int i;
-
-	mutex_lock(&synth_event_mutex);
-
-	kfree(data->onmatch.match_event);
-	kfree(data->onmatch.match_event_system);
-	kfree(data->onmatch.synth_event_name);
-
-	for (i = 0; i < data->n_params; i++)
-		kfree(data->params[i]);
-
-	if (data->onmatch.synth_event)
-		data->onmatch.synth_event->ref--;
-
-	kfree(data);
+	kfree(data->match_data.event);
+	kfree(data->match_data.event_system);
 
-	mutex_unlock(&synth_event_mutex);
+	action_data_destroy(data);
 }
 
 static void destroy_field_var(struct field_var *field_var)
@@ -3678,8 +3839,9 @@ static int check_synth_field(struct synth_event *event,
 }
 
 static struct hist_field *
-onmatch_find_var(struct hist_trigger_data *hist_data, struct action_data *data,
-		 char *system, char *event, char *var)
+trace_action_find_var(struct hist_trigger_data *hist_data,
+		      struct action_data *data,
+		      char *system, char *event, char *var)
 {
 	struct hist_field *hist_field;
 
@@ -3687,24 +3849,24 @@ onmatch_find_var(struct hist_trigger_data *hist_data, struct action_data *data,
 
 	hist_field = find_target_event_var(hist_data, system, event, var);
 	if (!hist_field) {
-		if (!system) {
-			system = data->onmatch.match_event_system;
-			event = data->onmatch.match_event;
+		if (!system && data->handler == HANDLER_ONMATCH) {
+			system = data->match_data.event_system;
+			event = data->match_data.event;
 		}
 
 		hist_field = find_event_var(hist_data, system, event, var);
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
@@ -3727,9 +3889,9 @@ onmatch_create_field_var(struct hist_trigger_data *hist_data,
 		 * looking for fields on the onmatch(system.event.xxx)
 		 * event.
 		 */
-		if (!system) {
-			system = data->onmatch.match_event_system;
-			event = data->onmatch.match_event;
+		if (!system && data->handler == HANDLER_ONMATCH) {
+			system = data->match_data.event_system;
+			event = data->match_data.event;
 		}
 
 		if (!event)
@@ -3753,9 +3915,8 @@ onmatch_create_field_var(struct hist_trigger_data *hist_data,
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
@@ -3764,15 +3925,15 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 	struct synth_event *event;
 	int ret = 0;
 
-	mutex_lock(&synth_event_mutex);
-	event = find_synth_event(data->onmatch.synth_event_name);
+	lockdep_assert_held(&event_mutex);
+
+	event = find_synth_event(data->action_name);
 	if (!event) {
-		hist_err("onmatch: Couldn't find synthetic event: ", data->onmatch.synth_event_name);
-		mutex_unlock(&synth_event_mutex);
+		hist_err("trace action: Couldn't find synthetic event: ", data->action_name);
 		return -EINVAL;
 	}
+
 	event->ref++;
-	mutex_unlock(&synth_event_mutex);
 
 	var_ref_idx = hist_data->n_var_refs;
 
@@ -3799,13 +3960,15 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
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
@@ -3827,7 +3990,7 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 			continue;
 		}
 
-		hist_err_event("onmatch: Param type doesn't match synthetic event field type: ",
+		hist_err_event("trace action: Param type doesn't match synthetic event field type: ",
 			       system, event_name, param);
 		kfree(p);
 		ret = -EINVAL;
@@ -3835,28 +3998,73 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 	}
 
 	if (field_pos != event->n_fields) {
-		hist_err("onmatch: Param count doesn't match synthetic event field count: ", event->name);
+		hist_err("trace action: Param count doesn't match synthetic event field count: ", event->name);
 		ret = -EINVAL;
 		goto err;
 	}
 
-	data->fn = action_trace;
-	data->onmatch.synth_event = event;
-	data->onmatch.var_ref_idx = var_ref_idx;
+	data->synth_event = event;
+	data->var_ref_idx = var_ref_idx;
  out:
 	return ret;
  err:
-	mutex_lock(&synth_event_mutex);
 	event->ref--;
-	mutex_unlock(&synth_event_mutex);
 
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
 
@@ -3882,43 +4090,19 @@ static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
 		goto free;
 	}
 
-	data->onmatch.match_event = kstrdup(match_event, GFP_KERNEL);
-	if (!data->onmatch.match_event) {
+	data->match_data.event = kstrdup(match_event, GFP_KERNEL);
+	if (!data->match_data.event) {
 		ret = -ENOMEM;
 		goto free;
 	}
 
-	data->onmatch.match_event_system = kstrdup(match_event_system, GFP_KERNEL);
-	if (!data->onmatch.match_event_system) {
-		ret = -ENOMEM;
-		goto free;
-	}
-
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
+	data->match_data.event_system = kstrdup(match_event_system, GFP_KERNEL);
+	if (!data->match_data.event_system) {
 		ret = -ENOMEM;
 		goto free;
 	}
 
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
@@ -4359,10 +4543,10 @@ static void destroy_actions(struct hist_trigger_data *hist_data)
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 
-		if (data->fn == action_trace)
+		if (data->handler == HANDLER_ONMATCH)
 			onmatch_destroy(data);
-		else if (data->fn == onmax_save)
-			onmax_destroy(data);
+		else if (data->handler == HANDLER_ONMAX)
+			track_data_destroy(hist_data, data);
 		else
 			kfree(data);
 	}
@@ -4375,28 +4559,28 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 	unsigned int i;
 	int ret = 0;
 	char *str;
+	int len;
 
 	for (i = 0; i < hist_data->attrs->n_actions; i++) {
 		str = hist_data->attrs->action_str[i];
 
-		if (strncmp(str, "onmatch(", strlen("onmatch(")) == 0) {
-			char *action_str = str + strlen("onmatch(");
+		if ((len = str_has_prefix(str, "onmatch("))) {
+			char *action_str = str + len;
 
 			data = onmatch_parse(tr, action_str);
 			if (IS_ERR(data)) {
 				ret = PTR_ERR(data);
 				break;
 			}
-			data->fn = action_trace;
-		} else if (strncmp(str, "onmax(", strlen("onmax(")) == 0) {
-			char *action_str = str + strlen("onmax(");
+		} else if ((len = str_has_prefix(str, "onmax("))) {
+			char *action_str = str + len;
 
-			data = onmax_parse(action_str);
+			data = track_data_parse(hist_data, action_str,
+						HANDLER_ONMAX);
 			if (IS_ERR(data)) {
 				ret = PTR_ERR(data);
 				break;
 			}
-			data->fn = onmax_save;
 		} else {
 			ret = -EINVAL;
 			break;
@@ -4408,8 +4592,7 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 	return ret;
 }
 
-static int create_actions(struct hist_trigger_data *hist_data,
-			  struct trace_event_file *file)
+static int create_actions(struct hist_trigger_data *hist_data)
 {
 	struct action_data *data;
 	unsigned int i;
@@ -4418,14 +4601,17 @@ static int create_actions(struct hist_trigger_data *hist_data,
 	for (i = 0; i < hist_data->attrs->n_actions; i++) {
 		data = hist_data->actions[i];
 
-		if (data->fn == action_trace) {
-			ret = onmatch_create(hist_data, file, data);
+		if (data->handler == HANDLER_ONMATCH) {
+			ret = onmatch_create(hist_data, data);
 			if (ret)
-				return ret;
-		} else if (data->fn == onmax_save) {
-			ret = onmax_create(hist_data, data);
+				break;
+		} else if (data->handler == HANDLER_ONMAX) {
+			ret = track_data_create(hist_data, data);
 			if (ret)
-				return ret;
+				break;
+		} else {
+			ret = -EINVAL;
+			break;
 		}
 	}
 
@@ -4441,26 +4627,43 @@ static void print_actions(struct seq_file *m,
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 
-		if (data->fn == onmax_save)
-			onmax_print(m, hist_data, elt, data);
+		if (data->handler == HANDLER_ONMAX)
+			track_data_print(m, hist_data, elt, data);
 	}
 }
 
-static void print_onmax_spec(struct seq_file *m,
-			     struct hist_trigger_data *hist_data,
-			     struct action_data *data)
+static void print_action_spec(struct seq_file *m,
+			      struct hist_trigger_data *hist_data,
+			      struct action_data *data)
 {
 	unsigned int i;
 
-	seq_puts(m, ":onmax(");
-	seq_printf(m, "%s", data->onmax.var_str);
-	seq_printf(m, ").%s(", data->onmax.fn_name);
-
-	for (i = 0; i < hist_data->n_max_vars; i++) {
-		seq_printf(m, "%s", hist_data->max_vars[i]->var->var.name);
-		if (i < hist_data->n_max_vars - 1)
-			seq_puts(m, ",");
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
 	}
+}
+
+static void print_track_data_spec(struct seq_file *m,
+				  struct hist_trigger_data *hist_data,
+				  struct action_data *data)
+{
+	if (data->handler == HANDLER_ONMAX)
+		seq_puts(m, ":onmax(");
+	seq_printf(m, "%s", data->track_data.var_str);
+	seq_printf(m, ").%s(", data->action_name);
+
+	print_action_spec(m, hist_data, data);
+
 	seq_puts(m, ")");
 }
 
@@ -4468,18 +4671,12 @@ static void print_onmatch_spec(struct seq_file *m,
 			       struct hist_trigger_data *hist_data,
 			       struct action_data *data)
 {
-	unsigned int i;
-
-	seq_printf(m, ":onmatch(%s.%s).", data->onmatch.match_event_system,
-		   data->onmatch.match_event);
+	seq_printf(m, ":onmatch(%s.%s).", data->match_data.event_system,
+		   data->match_data.event);
 
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
@@ -4496,7 +4693,9 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 		struct action_data *data = hist_data->actions[i];
 		struct action_data *data_test = hist_data_test->actions[i];
 
-		if (data->fn != data_test->fn)
+		if (data->handler != data_test->handler)
+			return false;
+		if (data->action != data_test->action)
 			return false;
 
 		if (data->n_params != data_test->n_params)
@@ -4507,22 +4706,19 @@ static bool actions_match(struct hist_trigger_data *hist_data,
 				return false;
 		}
 
-		if (data->fn == action_trace) {
-			if (strcmp(data->onmatch.synth_event_name,
-				   data_test->onmatch.synth_event_name) != 0)
-				return false;
-			if (strcmp(data->onmatch.match_event_system,
-				   data_test->onmatch.match_event_system) != 0)
-				return false;
-			if (strcmp(data->onmatch.match_event,
-				   data_test->onmatch.match_event) != 0)
+		if (strcmp(data->action_name, data_test->action_name) != 0)
+			return false;
+
+		if (data->handler == HANDLER_ONMATCH) {
+			if (strcmp(data->match_data.event_system,
+				   data_test->match_data.event_system) != 0)
 				return false;
-		} else if (data->fn == onmax_save) {
-			if (strcmp(data->onmax.var_str,
-				   data_test->onmax.var_str) != 0)
+			if (strcmp(data->match_data.event,
+				   data_test->match_data.event) != 0)
 				return false;
-			if (strcmp(data->onmax.fn_name,
-				   data_test->onmax.fn_name) != 0)
+		} else if (data->handler == HANDLER_ONMAX) {
+			if (strcmp(data->track_data.var_str,
+				   data_test->track_data.var_str) != 0)
 				return false;
 		}
 	}
@@ -4539,10 +4735,10 @@ static void print_actions_spec(struct seq_file *m,
 	for (i = 0; i < hist_data->n_actions; i++) {
 		struct action_data *data = hist_data->actions[i];
 
-		if (data->fn == action_trace)
+		if (data->handler == HANDLER_ONMATCH)
 			print_onmatch_spec(m, hist_data, data);
-		else if (data->fn == onmax_save)
-			print_onmax_spec(m, hist_data, data);
+		else if (data->handler == HANDLER_ONMAX)
+			print_track_data_spec(m, hist_data, data);
 	}
 }
 
@@ -4734,14 +4930,15 @@ static inline void add_to_key(char *compound_key, void *key,
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
 
@@ -4802,7 +4999,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 	hist_trigger_elt_update(hist_data, elt, rec, rbe, var_ref_vals);
 
 	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
-		hist_trigger_actions(hist_data, elt, rec, rbe, var_ref_vals);
+		hist_trigger_actions(hist_data, elt, rec, rbe, key, var_ref_vals);
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -5565,6 +5762,8 @@ static void hist_unreg_all(struct trace_event_file *file)
 	struct synth_event *se;
 	const char *se_name;
 
+	lockdep_assert_held(&event_mutex);
+
 	if (hist_file_check_refs(file))
 		return;
 
@@ -5574,12 +5773,10 @@ static void hist_unreg_all(struct trace_event_file *file)
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
@@ -5605,6 +5802,8 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	char *trigger, *p;
 	int ret = 0;
 
+	lockdep_assert_held(&event_mutex);
+
 	if (glob && strlen(glob)) {
 		last_cmd_set(param);
 		hist_err_clear();
@@ -5695,14 +5894,10 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
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
@@ -5723,7 +5918,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	if (get_named_trigger_data(trigger_data))
 		goto enable;
 
-	ret = create_actions(hist_data, file);
+	ret = create_actions(hist_data);
 	if (ret)
 		goto out_unreg;
 
@@ -5741,13 +5936,10 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
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
@@ -5930,6 +6122,12 @@ static __init int trace_events_hist_init(void)
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
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index d85ee1778b99..6efd38b5843c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -342,7 +342,7 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 			f->fn = t->fetch[FETCH_MTD_retval];
 		else
 			ret = -EINVAL;
-	} else if (strncmp(arg, "stack", 5) == 0) {
+	} else if (str_has_prefix(arg, "stack")) {
 		if (arg[5] == '\0') {
 			if (strcmp(t->name, DEFAULT_FETCH_TYPE_STR))
 				return -EINVAL;
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 40337094085c..9a4e24d5b8c0 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -453,7 +453,7 @@ static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata;
 
 static __init int enable_stacktrace(char *str)
 {
-	if (strncmp(str, "_filter=", 8) == 0)
+	if (str_has_prefix(str, "_filter="))
 		strncpy(stack_trace_filter_buf, str+8, COMMAND_LINE_SIZE);
 
 	stack_tracer_enabled = 1;
diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
index c65c55b7a789..312889edb84a 100644
--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -15,7 +15,6 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
-#include "vm_util.h"
 
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
@@ -71,16 +70,10 @@ int main(int argc, char **argv)
 {
 	void *addr;
 	int ret;
-	size_t hugepage_size;
 	size_t length = LENGTH;
 	int flags = FLAGS;
 	int shift = 0;
 
-	hugepage_size = default_huge_page_size();
-	/* munmap with fail if the length is not page aligned */
-	if (hugepage_size > length)
-		length = hugepage_size;
-
 	if (argc > 1)
 		length = atol(argv[1]) << 20;
 	if (argc > 2) {

