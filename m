Return-Path: <stable+bounces-225127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBJXNgQhs2m5SQAAu9opvQ
	(envelope-from <stable+bounces-225127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:24:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8222278FAE
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7FC930055F7
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0EC374E44;
	Thu, 12 Mar 2026 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mfpGoehL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580335A3A9;
	Thu, 12 Mar 2026 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347070; cv=none; b=hKD2kahScGb9zzZ4SsU2KKlKv2u43nY5nWbE0UlBJqHfFP9Sg0PDH5p8vha96UjSWWg2WVoJteHFw90XvcmoE5A/f8DuNRTuIsyaBSjsQ2vPa4IYV9i3swwQj7Y+EIMioArMQdvQKUnAsOcNAqRNPAR53iHMl+S9lJFqN8f7vZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347070; c=relaxed/simple;
	bh=APVeU+FZjkc23cipIRSp4lxWuPDTqL7qycXOLHHShws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjycedIsDIG7FaxiAgXeL81nyJxhgJIHpArpHwWjME/O7ZNgzjfviJGMZcRFW/JEVGpqoV4qGIvIUPtweXfuZZCpzxCPkSlabGOeKP/SRqvi7u9tPmQWVoZD+B+X5isZcwmAbe6KvU5KITbb8ESecA/sXBSW9IZuSSEULj5X3GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mfpGoehL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AD2C4CEF7;
	Thu, 12 Mar 2026 20:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347070;
	bh=APVeU+FZjkc23cipIRSp4lxWuPDTqL7qycXOLHHShws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfpGoehL00O6IdhZwmAKxhS9kPqdDEWeqyJEvi5esnmo6VdA/WEka+MrBwKeIp6nF
	 GoPGYS22VXfptp0C75eSz7cZbZ7ApXkuaJ8wk9+ExErJZZFrxSXxRNHfGK16LeJ6Jw
	 9jUbYtbhYl6TZ8GGZJxS8x51H52Xag3hrSv9IxT0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com,
	Qing Wang <wangqing7171@gmail.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.12 152/265] tracing: Fix WARN_ON in tracing_buffers_mmap_close
Date: Thu, 12 Mar 2026 21:08:59 +0100
Message-ID: <20260312201023.753560609@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-225127-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,efficios.com,google.com,oracle.com,syzkaller.appspotmail.com,gmail.com,goodmis.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,3b5dd2030fe08afdf65d];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,syzkaller.appspot.com:url,efficios.com:email,appspotmail.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,oracle.com:email,goodmis.org:email]
X-Rspamd-Queue-Id: B8222278FAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qing Wang <wangqing7171@gmail.com>

commit e39bb9e02b68942f8e9359d2a3efe7d37ae6be0e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/ring_buffer.h |    1 +
 kernel/trace/ring_buffer.c  |   21 +++++++++++++++++++++
 kernel/trace/trace.c        |   13 +++++++++++++
 3 files changed, 35 insertions(+)

--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -244,6 +244,7 @@ int trace_rb_cpu_prepare(unsigned int cp
 
 int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		    struct vm_area_struct *vma);
+void ring_buffer_map_dup(struct trace_buffer *buffer, int cpu);
 int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
 int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
 #endif /* _LINUX_RING_BUFFER_H */
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7154,6 +7154,27 @@ unlock:
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
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8274,6 +8274,18 @@ static inline int get_snapshot_map(struc
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
@@ -8293,6 +8305,7 @@ static int tracing_buffers_may_split(str
 }
 
 static const struct vm_operations_struct tracing_buffers_vmops = {
+	.open		= tracing_buffers_mmap_open,
 	.close		= tracing_buffers_mmap_close,
 	.may_split      = tracing_buffers_may_split,
 };



