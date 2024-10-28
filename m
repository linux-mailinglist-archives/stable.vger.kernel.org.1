Return-Path: <stable+bounces-88504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094D09B2645
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D63A1C2124C
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BF118EFDC;
	Mon, 28 Oct 2024 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k7i+aIog"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F518DF68;
	Mon, 28 Oct 2024 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097483; cv=none; b=ZxVUz3OfUAkbudyJo/lyzMjH80rIeTpf5xKAfRjW5DpRXvqEENyiAw7sPquzZoHK72ruDNqKg7NZFVwXoYmDv+WxT3ILtPg6qqHOWDZS/DxqrKZJOND/c4TajMYkvMyodvHarCFtUvdF/jnsahcKIi/nV0hDpmsQlCfXlch5JAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097483; c=relaxed/simple;
	bh=g/TZYnw5ET0gr5mNpc1qUsDcqsE2UnnMRafEkQDW63k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQlCF8wOzRUWxaQcBPQISTdjGvrdLNHUxmol+2DCWzJ2jE0EKOp5Kq1OIWL3VqXfrxtRveAwyRBN8Vi2sBxlKm6lD+8kNpTywWe31D/m4EYED2+i1OGXQExryt3daFHAN+Ilmn9qWClcQYkyd5qVmXy8WUauDqfQskvhC5kv7Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k7i+aIog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72F4C4CEC3;
	Mon, 28 Oct 2024 06:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097483;
	bh=g/TZYnw5ET0gr5mNpc1qUsDcqsE2UnnMRafEkQDW63k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7i+aIoghnJKn9hfB3Vyeoo4EtTu7kJOWtpHt9L3Q+Gqs6AuQCYpsxh4LkaNQB2Df
	 XigA116IZ6K6aGYuWXf3ngEDDZ4PDxLUa00gml9YjiaZv8sj0r+O/gqfkjevkNYgtH
	 HkxyB8IkIhoIkQ+cUelxTQ4jm5nYzpvRifavZ8AI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 013/208] bpf: Add missed value to kprobe perf link info
Date: Mon, 28 Oct 2024 07:23:13 +0100
Message-ID: <20241028062306.985158201@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
References: <20241028062306.649733554@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 3acf8ace68230e9558cf916847f1cc9f208abdf1 ]

Add missed value to kprobe attached through perf link info to
hold the stats of missed kprobe handler execution.

The kprobe's missed counter gets incremented when kprobe handler
is not executed due to another kprobe running on the same cpu.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230920213145.1941596-4-jolsa@kernel.org
Stable-dep-of: 4deecdd29cf2 ("bpf: fix unpopulated name_len field in perf_event link info")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/trace_events.h   |  6 ++++--
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           | 14 ++++++++------
 kernel/trace/bpf_trace.c       |  5 +++--
 kernel/trace/trace_kprobe.c    | 14 +++++++++++---
 tools/include/uapi/linux/bpf.h |  1 +
 6 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index cb8bd759e8005..9d799777c333c 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -765,7 +765,8 @@ struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name);
 void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp);
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
-			    u64 *probe_offset, u64 *probe_addr);
+			    u64 *probe_offset, u64 *probe_addr,
+			    unsigned long *missed);
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 #else
@@ -805,7 +806,7 @@ static inline void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 static inline int bpf_get_perf_event_info(const struct perf_event *event,
 					  u32 *prog_id, u32 *fd_type,
 					  const char **buf, u64 *probe_offset,
-					  u64 *probe_addr)
+					  u64 *probe_addr, unsigned long *missed)
 {
 	return -EOPNOTSUPP;
 }
@@ -880,6 +881,7 @@ extern void perf_kprobe_destroy(struct perf_event *event);
 extern int bpf_get_kprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **symbol,
 			       u64 *probe_offset, u64 *probe_addr,
+			       unsigned long *missed,
 			       bool perf_type_tracepoint);
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4bb38409b26ad..6ea588d1ae149 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6562,6 +6562,7 @@ struct bpf_link_info {
 					__u32 name_len;
 					__u32 offset; /* offset from func_name */
 					__u64 addr;
+					__u64 missed;
 				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
 				struct {
 					__aligned_u64 tp_name;   /* in/out */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b1933d074f051..9c76f21f187f6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3444,7 +3444,7 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
 static int bpf_perf_link_fill_common(const struct perf_event *event,
 				     char __user *uname, u32 ulen,
 				     u64 *probe_offset, u64 *probe_addr,
-				     u32 *fd_type)
+				     u32 *fd_type, unsigned long *missed)
 {
 	const char *buf;
 	u32 prog_id;
@@ -3455,7 +3455,7 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 		return -EINVAL;
 
 	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
-				      probe_offset, probe_addr);
+				      probe_offset, probe_addr, missed);
 	if (err)
 		return err;
 	if (!uname)
@@ -3478,6 +3478,7 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 				     struct bpf_link_info *info)
 {
+	unsigned long missed;
 	char __user *uname;
 	u64 addr, offset;
 	u32 ulen, type;
@@ -3486,7 +3487,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 	uname = u64_to_user_ptr(info->perf_event.kprobe.func_name);
 	ulen = info->perf_event.kprobe.name_len;
 	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
-					&type);
+					&type, &missed);
 	if (err)
 		return err;
 	if (type == BPF_FD_TYPE_KRETPROBE)
@@ -3495,6 +3496,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 		info->perf_event.type = BPF_PERF_EVENT_KPROBE;
 
 	info->perf_event.kprobe.offset = offset;
+	info->perf_event.kprobe.missed = missed;
 	if (!kallsyms_show_value(current_cred()))
 		addr = 0;
 	info->perf_event.kprobe.addr = addr;
@@ -3514,7 +3516,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 	uname = u64_to_user_ptr(info->perf_event.uprobe.file_name);
 	ulen = info->perf_event.uprobe.name_len;
 	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
-					&type);
+					&type, NULL);
 	if (err)
 		return err;
 
@@ -3550,7 +3552,7 @@ static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
 	uname = u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
 	ulen = info->perf_event.tracepoint.name_len;
 	info->perf_event.type = BPF_PERF_EVENT_TRACEPOINT;
-	return bpf_perf_link_fill_common(event, uname, ulen, NULL, NULL, NULL);
+	return bpf_perf_link_fill_common(event, uname, ulen, NULL, NULL, NULL, NULL);
 }
 
 static int bpf_perf_link_fill_perf_event(const struct perf_event *event,
@@ -4897,7 +4899,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 
 		err = bpf_get_perf_event_info(event, &prog_id, &fd_type,
 					      &buf, &probe_offset,
-					      &probe_addr);
+					      &probe_addr, NULL);
 		if (!err)
 			err = bpf_task_fd_query_copy(attr, uattr, prog_id,
 						     fd_type, buf,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index eca858bde8047..bbdc4199748bd 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2389,7 +2389,8 @@ int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
 
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
-			    u64 *probe_offset, u64 *probe_addr)
+			    u64 *probe_offset, u64 *probe_addr,
+			    unsigned long *missed)
 {
 	bool is_tracepoint, is_syscall_tp;
 	struct bpf_prog *prog;
@@ -2424,7 +2425,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 #ifdef CONFIG_KPROBE_EVENTS
 		if (flags & TRACE_EVENT_FL_KPROBE)
 			err = bpf_get_kprobe_info(event, fd_type, buf,
-						  probe_offset, probe_addr,
+						  probe_offset, probe_addr, missed,
 						  event->attr.type == PERF_TYPE_TRACEPOINT);
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 47812aa16bb57..52f8b537dd0a0 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1249,6 +1249,12 @@ static const struct file_operations kprobe_events_ops = {
 	.write		= probes_write,
 };
 
+static unsigned long trace_kprobe_missed(struct trace_kprobe *tk)
+{
+	return trace_kprobe_is_return(tk) ?
+		tk->rp.kp.nmissed + tk->rp.nmissed : tk->rp.kp.nmissed;
+}
+
 /* Probes profiling interfaces */
 static int probes_profile_seq_show(struct seq_file *m, void *v)
 {
@@ -1260,8 +1266,7 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
 		return 0;
 
 	tk = to_trace_kprobe(ev);
-	nmissed = trace_kprobe_is_return(tk) ?
-		tk->rp.kp.nmissed + tk->rp.nmissed : tk->rp.kp.nmissed;
+	nmissed = trace_kprobe_missed(tk);
 	seq_printf(m, "  %-44s %15lu %15lu\n",
 		   trace_probe_name(&tk->tp),
 		   trace_kprobe_nhit(tk),
@@ -1607,7 +1612,8 @@ NOKPROBE_SYMBOL(kretprobe_perf_func);
 
 int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 			const char **symbol, u64 *probe_offset,
-			u64 *probe_addr, bool perf_type_tracepoint)
+			u64 *probe_addr, unsigned long *missed,
+			bool perf_type_tracepoint)
 {
 	const char *pevent = trace_event_name(event->tp_event);
 	const char *group = event->tp_event->class->system;
@@ -1626,6 +1632,8 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 	*probe_addr = kallsyms_show_value(current_cred()) ?
 		      (unsigned long)tk->rp.kp.addr : 0;
 	*symbol = tk->symbol;
+	if (missed)
+		*missed = trace_kprobe_missed(tk);
 	return 0;
 }
 #endif	/* CONFIG_PERF_EVENTS */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ba6e346c8d669..acda713f8b4d1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6565,6 +6565,7 @@ struct bpf_link_info {
 					__u32 name_len;
 					__u32 offset; /* offset from func_name */
 					__u64 addr;
+					__u64 missed;
 				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
 				struct {
 					__aligned_u64 tp_name;   /* in/out */
-- 
2.43.0




