Return-Path: <stable+bounces-223144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCf/KxStqGmfwQAAu9opvQ
	(envelope-from <stable+bounces-223144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:07:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F83C208507
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F5D6305416A
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 22:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B673DEADC;
	Wed,  4 Mar 2026 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn27ZKkt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DBA3DBD57;
	Wed,  4 Mar 2026 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661781; cv=none; b=Q+cr6n8ETllbcuO0duYoeryKT9WBLYbP9EvjJVjr26+vaXZMNjRRY9O2IpJccAWOIhKKHGKSIsbkNldoKOBfCZhtPPKK/iL4ekJvZ/nPaekMPfKx/F7dlriui2Pl5C5nlkEgC0oXkEZMstX9Sfo1IWfm5L7lzLl8iJPSm56n2XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661781; c=relaxed/simple;
	bh=aGJcSz/aF8E9C71Ws74vWip8cBalYHhYyN2cRT9NUT8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NOdOxJPRKGalVQy6QOPotx7KtfAMTRJbdkOcaWY57Edu6EhBrWuq/+A6GIT+0YQGqTXSvE4Vyp/0dghG1bwFBNkXIbAZaAPP13zQ6Isr1p3ma+UMNvQmvPQgtiUCd/xXEQU8w0L8B6gRcccdQuN9P60zKitbgHDjfwVR62TOgV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn27ZKkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4E2C19425;
	Wed,  4 Mar 2026 22:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661781;
	bh=aGJcSz/aF8E9C71Ws74vWip8cBalYHhYyN2cRT9NUT8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Rn27ZKkt25O/hLwT3PfSxL0u357f3cUyYEPP8EAB0YUOp7m7maYXttPKd6id69vMk
	 J3/0a3sSNBXQ2EXf2VT1ykk6vb7x6U4T4TdwC0ylGoFjNSOWLGYR8jwoTUejUQvEzy
	 kK5YfEXAZHRkrD6EoIiRuyfxrmZRbD7J/HX9ZMsnYrBl3fgp31H6OBv9qjvlLoaDOe
	 BY4WDW5PAKJcAapyq643DW1KZHRrvZmZjhpZbdWrH7KFAQTn5ukXVzK59FYJpe97A0
	 fM5CNpSyUcMnL2WGXBNWnbCueYFIFY2ZLDSmgBycHW0aFsf2vAF0ljrT71dNJwnq4f
	 2V1J6c0ZaKoKw==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vxuJe-00000003CTE-1BsF;
	Wed, 04 Mar 2026 17:03:38 -0500
Message-ID: <20260304220338.162605195@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 04 Mar 2026 17:03:25 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com,
 Qing Wang <wangqing7171@gmail.com>
Subject: [for-linus][PATCH 6/6] tracing: Fix WARN_ON in tracing_buffers_mmap_close
References: <20260304220319.218314827@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 4F83C208507
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,efficios.com,linux-foundation.org,vger.kernel.org,google.com,oracle.com,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-223144-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,3b5dd2030fe08afdf65d];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,goodmis.org:email,msgid.link:url,efficios.com:email,appspotmail.com:email,oracle.com:email]
X-Rspamd-Action: no action

From: Qing Wang <wangqing7171@gmail.com>

When a process forks, the child process copies the parent's VMAs but the
user_mapped reference count is not incremented. As a result, when both the
parent and child processes exit, tracing_buffers_mmap_close() is called
twice. On the second call, user_mapped is already 0, causing the function to
return -ENODEV and triggering a WARN_ON.

Normally, this isn't an issue as the memory is mapped with VM_DONTCOPY set.
But this is only a hint, and the application can call
madvise(MADVISE_DOFORK) which resets the VM_DONTCOPY flag. When the
application does that, it can trigger this issue on fork.

Fix it by incrementing the user_mapped reference count without re-mapping
the pages in the VMA's open callback.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://patch.msgid.link/20260227025842.1085206-1-wangqing7171@gmail.com
Fixes: cf9f0f7c4c5bb ("tracing: Allow user-space mapping of the ring-buffer")
Reported-by: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3b5dd2030fe08afdf65d
Tested-by: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  1 +
 kernel/trace/ring_buffer.c  | 21 +++++++++++++++++++++
 kernel/trace/trace.c        | 13 +++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 876358cfe1b1..d862fa610270 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -248,6 +248,7 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
 
 int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		    struct vm_area_struct *vma);
+void ring_buffer_map_dup(struct trace_buffer *buffer, int cpu);
 int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
 int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f16f053ef77d..17d0ea0cc3e6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7310,6 +7310,27 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	return err;
 }
 
+/*
+ * This is called when a VMA is duplicated (e.g., on fork()) to increment
+ * the user_mapped counter without remapping pages.
+ */
+void ring_buffer_map_dup(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+
+	if (WARN_ON(!cpumask_test_cpu(cpu, buffer->cpumask)))
+		return;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	guard(mutex)(&cpu_buffer->mapping_lock);
+
+	if (cpu_buffer->user_mapped)
+		__rb_inc_dec_mapped(cpu_buffer, true);
+	else
+		WARN(1, "Unexpected buffer stat, it should be mapped");
+}
+
 int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 23de3719f495..1e7c032a72d2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8213,6 +8213,18 @@ static inline int get_snapshot_map(struct trace_array *tr) { return 0; }
 static inline void put_snapshot_map(struct trace_array *tr) { }
 #endif
 
+/*
+ * This is called when a VMA is duplicated (e.g., on fork()) to increment
+ * the user_mapped counter without remapping pages.
+ */
+static void tracing_buffers_mmap_open(struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	ring_buffer_map_dup(iter->array_buffer->buffer, iter->cpu_file);
+}
+
 static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
 {
 	struct ftrace_buffer_info *info = vma->vm_file->private_data;
@@ -8232,6 +8244,7 @@ static int tracing_buffers_may_split(struct vm_area_struct *vma, unsigned long a
 }
 
 static const struct vm_operations_struct tracing_buffers_vmops = {
+	.open		= tracing_buffers_mmap_open,
 	.close		= tracing_buffers_mmap_close,
 	.may_split      = tracing_buffers_may_split,
 };
-- 
2.51.0



