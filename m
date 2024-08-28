Return-Path: <stable+bounces-71360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EDB961C6B
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 04:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB921F24610
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 02:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E50C83A18;
	Wed, 28 Aug 2024 02:58:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377912F5A5
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813892; cv=none; b=BP4n3ZqF1ggV8ZnVCGuJT5uqK37saMdIfWGKvZf7qCdR05tSkcQoKK7OvwOypB37+ISxBs10x9SeHzbY197sv2ih9iMwZxUH+Ym3pAtuklYz3MBkPr7QB0YziOhun4TyLn3K4Y07u2ro17erjmcBGP3CuUPojiM9rfM6ndVP0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813892; c=relaxed/simple;
	bh=wokkPR4C0SimwXFkUL8lFsXqFpFwAePu3VavZDYfYkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvew2MyEHz2nbfilQwBy3LM+GdqfhLn1TIDzsR9mUtTTU60DxyeCKz1WGkuNhaiK8JvixIIiHdqMYeiUeEFbPueLK/g3QVHNDXrXfa9QqdBJQvuEwesSWyVDKksksoxEAITSw/adnoJfMDNKhLcTxQAS30v/BM7SbzNqpNWDpHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WtpxM69VCz4f3jQv
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 10:57:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6E61F1A0AA4
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 10:57:58 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP4 (Coremail) with SMTP id gCh0CgDHOoEtks5mDOuuCw--.8462S2;
	Wed, 28 Aug 2024 10:57:56 +0800 (CST)
From: Zheng Yejian <zhengyejian@huaweicloud.com>
To: stable@vger.kernel.org
Cc: zhengyejian@huaweicloud.com
Subject: [PATCH 6.6.y] tracing: Have format file honor EVENT_FILE_FL_FREED
Date: Wed, 28 Aug 2024 10:59:40 +0800
Message-Id: <20240828025940.683521-1-zhengyejian@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024081258-amusement-designing-88e9@gregkh>
References: <2024081258-amusement-designing-88e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHOoEtks5mDOuuCw--.8462S2
X-Coremail-Antispam: 1UD129KBjvJXoW3tFW7Jry5Zr1xAw48uw43Awb_yoWkAw1UpF
	98JFnxKrW8twsFgF1fCa1DuFy5J393GryDWFy8W34rXr15Grn29F42kr45uw13trykJ34q
	v3Wj9rW2kryUuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYOVAac2xI67A07wC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUU_cTPUUUUU==
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

From: Steven Rostedt <rostedt@goodmis.org>

commit b1560408692cd0ab0370cfbe9deb03ce97ab3f6d upstream.

When eventfs was introduced, special care had to be done to coordinate the
freeing of the file meta data with the files that are exposed to user
space. The file meta data would have a ref count that is set when the file
is created and would be decremented and freed after the last user that
opened the file closed it. When the file meta data was to be freed, it
would set a flag (EVENT_FILE_FL_FREED) to denote that the file is freed,
and any new references made (like new opens or reads) would fail as it is
marked freed. This allowed other meta data to be freed after this flag was
set (under the event_mutex).

All the files that were dynamically created in the events directory had a
pointer to the file meta data and would call event_release() when the last
reference to the user space file was closed. This would be the time that it
is safe to free the file meta data.

A shortcut was made for the "format" file. It's i_private would point to
the "call" entry directly and not point to the file's meta data. This is
because all format files are the same for the same "call", so it was
thought there was no reason to differentiate them.  The other files
maintain state (like the "enable", "trigger", etc). But this meant if the
file were to disappear, the "format" file would be unaware of it.

This caused a race that could be trigger via the user_events test (that
would create dynamic events and free them), and running a loop that would
read the user_events format files:

In one console run:

 # cd tools/testing/selftests/user_events
 # while true; do ./ftrace_test; done

And in another console run:

 # cd /sys/kernel/tracing/
 # while true; do cat events/user_events/__test_event/format; done 2>/dev/null

With KASAN memory checking, it would trigger a use-after-free bug report
(which was a real bug). This was because the format file was not checking
the file's meta data flag "EVENT_FILE_FL_FREED", so it would access the
event that the file meta data pointed to after the event was freed.

After inspection, there are other locations that were found to not check
the EVENT_FILE_FL_FREED flag when accessing the trace_event_file. Add a
new helper function: event_file_file() that will make sure that the
event_mutex is held, and will return NULL if the trace_event_file has the
EVENT_FILE_FL_FREED flag set. Have the first reference of the struct file
pointer use event_file_file() and check for NULL. Later uses can still use
the event_file_data() helper function if the event_mutex is still held and
was not released since the event_file_file() call.

Link: https://lore.kernel.org/all/20240719204701.1605950-1-minipli@grsecurity.net/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers   <mathieu.desnoyers@efficios.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Ilkka Naulapää    <digirigawa@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al   Viro <viro@zeniv.linux.org.uk>
Cc: Dan Carpenter   <dan.carpenter@linaro.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Florian Fainelli  <florian.fainelli@broadcom.com>
Cc: Alexey Makhalov    <alexey.makhalov@broadcom.com>
Cc: Vasavi Sirnapalli    <vasavi.sirnapalli@broadcom.com>
Link: https://lore.kernel.org/20240730110657.3b69d3c1@gandalf.local.home
Fixes: b63db58e2fa5d ("eventfs/tracing: Add callback for release of an eventfs_inode")
Reported-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
[Resolve conflict due to lack of commit a1f157c7a3bb ("tracing: Expand all
 ring buffers individually") which add tracing_update_buffers() in
event_enable_write(), that commit is more of a feature than a bugfix
and is not related to the problem fixed by this patch]
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
---
 kernel/trace/trace.h                | 23 ++++++++++++++++++++
 kernel/trace/trace_events.c         | 33 +++++++++++++++++------------
 kernel/trace/trace_events_hist.c    |  4 ++--
 kernel/trace/trace_events_inject.c  |  2 +-
 kernel/trace/trace_events_trigger.c |  6 +++---
 5 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 02b727a54648..3db42bae73f8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1555,6 +1555,29 @@ static inline void *event_file_data(struct file *filp)
 extern struct mutex event_mutex;
 extern struct list_head ftrace_events;
 
+/*
+ * When the trace_event_file is the filp->i_private pointer,
+ * it must be taken under the event_mutex lock, and then checked
+ * if the EVENT_FILE_FL_FREED flag is set. If it is, then the
+ * data pointed to by the trace_event_file can not be trusted.
+ *
+ * Use the event_file_file() to access the trace_event_file from
+ * the filp the first time under the event_mutex and check for
+ * NULL. If it is needed to be retrieved again and the event_mutex
+ * is still held, then the event_file_data() can be used and it
+ * is guaranteed to be valid.
+ */
+static inline struct trace_event_file *event_file_file(struct file *filp)
+{
+	struct trace_event_file *file;
+
+	lockdep_assert_held(&event_mutex);
+	file = READ_ONCE(file_inode(filp)->i_private);
+	if (!file || file->flags & EVENT_FILE_FL_FREED)
+		return NULL;
+	return file;
+}
+
 extern const struct file_operations event_trigger_fops;
 extern const struct file_operations event_hist_fops;
 extern const struct file_operations event_hist_debug_fops;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 2ae0f2807438..c68dc50c8bec 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1386,12 +1386,12 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 	char buf[4] = "0";
 
 	mutex_lock(&event_mutex);
-	file = event_file_data(filp);
+	file = event_file_file(filp);
 	if (likely(file))
 		flags = file->flags;
 	mutex_unlock(&event_mutex);
 
-	if (!file || flags & EVENT_FILE_FL_FREED)
+	if (!file)
 		return -ENODEV;
 
 	if (flags & EVENT_FILE_FL_ENABLED &&
@@ -1428,8 +1428,8 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	case 1:
 		ret = -ENODEV;
 		mutex_lock(&event_mutex);
-		file = event_file_data(filp);
-		if (likely(file && !(file->flags & EVENT_FILE_FL_FREED)))
+		file = event_file_file(filp);
+		if (likely(file))
 			ret = ftrace_event_enable_disable(file, val);
 		mutex_unlock(&event_mutex);
 		break;
@@ -1538,7 +1538,8 @@ enum {
 
 static void *f_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct trace_event_call *call = event_file_data(m->private);
+	struct trace_event_file *file = event_file_data(m->private);
+	struct trace_event_call *call = file->event_call;
 	struct list_head *common_head = &ftrace_common_fields;
 	struct list_head *head = trace_get_fields(call);
 	struct list_head *node = v;
@@ -1570,7 +1571,8 @@ static void *f_next(struct seq_file *m, void *v, loff_t *pos)
 
 static int f_show(struct seq_file *m, void *v)
 {
-	struct trace_event_call *call = event_file_data(m->private);
+	struct trace_event_file *file = event_file_data(m->private);
+	struct trace_event_call *call = file->event_call;
 	struct ftrace_event_field *field;
 	const char *array_descriptor;
 
@@ -1625,12 +1627,14 @@ static int f_show(struct seq_file *m, void *v)
 
 static void *f_start(struct seq_file *m, loff_t *pos)
 {
+	struct trace_event_file *file;
 	void *p = (void *)FORMAT_HEADER;
 	loff_t l = 0;
 
 	/* ->stop() is called even if ->start() fails */
 	mutex_lock(&event_mutex);
-	if (!event_file_data(m->private))
+	file = event_file_file(m->private);
+	if (!file)
 		return ERR_PTR(-ENODEV);
 
 	while (l < *pos && p)
@@ -1704,8 +1708,8 @@ event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
 	trace_seq_init(s);
 
 	mutex_lock(&event_mutex);
-	file = event_file_data(filp);
-	if (file && !(file->flags & EVENT_FILE_FL_FREED))
+	file = event_file_file(filp);
+	if (file)
 		print_event_filter(file, s);
 	mutex_unlock(&event_mutex);
 
@@ -1734,9 +1738,13 @@ event_filter_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		return PTR_ERR(buf);
 
 	mutex_lock(&event_mutex);
-	file = event_file_data(filp);
-	if (file)
-		err = apply_event_filter(file, buf);
+	file = event_file_file(filp);
+	if (file) {
+		if (file->flags & EVENT_FILE_FL_FREED)
+			err = -ENODEV;
+		else
+			err = apply_event_filter(file, buf);
+	}
 	mutex_unlock(&event_mutex);
 
 	kfree(buf);
@@ -2451,7 +2459,6 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 	if (strcmp(name, "format") == 0) {
 		*mode = TRACE_MODE_READ;
 		*fops = &ftrace_event_format_fops;
-		*data = call;
 		return 1;
 	}
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 68aaf0bd7a78..dd16faf0d150 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5609,7 +5609,7 @@ static int hist_show(struct seq_file *m, void *v)
 
 	mutex_lock(&event_mutex);
 
-	event_file = event_file_data(m->private);
+	event_file = event_file_file(m->private);
 	if (unlikely(!event_file)) {
 		ret = -ENODEV;
 		goto out_unlock;
@@ -5888,7 +5888,7 @@ static int hist_debug_show(struct seq_file *m, void *v)
 
 	mutex_lock(&event_mutex);
 
-	event_file = event_file_data(m->private);
+	event_file = event_file_file(m->private);
 	if (unlikely(!event_file)) {
 		ret = -ENODEV;
 		goto out_unlock;
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index 8650562bdaa9..a8f076809db4 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -299,7 +299,7 @@ event_inject_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	strim(buf);
 
 	mutex_lock(&event_mutex);
-	file = event_file_data(filp);
+	file = event_file_file(filp);
 	if (file) {
 		call = file->event_call;
 		size = parse_entry(buf, call, &entry);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index b33c3861fbbb..76abc9a45f97 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -159,7 +159,7 @@ static void *trigger_start(struct seq_file *m, loff_t *pos)
 
 	/* ->stop() is called even if ->start() fails */
 	mutex_lock(&event_mutex);
-	event_file = event_file_data(m->private);
+	event_file = event_file_file(m->private);
 	if (unlikely(!event_file))
 		return ERR_PTR(-ENODEV);
 
@@ -213,7 +213,7 @@ static int event_trigger_regex_open(struct inode *inode, struct file *file)
 
 	mutex_lock(&event_mutex);
 
-	if (unlikely(!event_file_data(file))) {
+	if (unlikely(!event_file_file(file))) {
 		mutex_unlock(&event_mutex);
 		return -ENODEV;
 	}
@@ -293,7 +293,7 @@ static ssize_t event_trigger_regex_write(struct file *file,
 	strim(buf);
 
 	mutex_lock(&event_mutex);
-	event_file = event_file_data(file);
+	event_file = event_file_file(file);
 	if (unlikely(!event_file)) {
 		mutex_unlock(&event_mutex);
 		kfree(buf);
-- 
2.25.1


