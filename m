Return-Path: <stable+bounces-215965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK0DDmXgjWnE8AAAu9opvQ
	(envelope-from <stable+bounces-215965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 15:15:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C88312E2EF
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 15:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FB5C3047535
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC3535CB7C;
	Thu, 12 Feb 2026 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qD++ga1E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA835B65E;
	Thu, 12 Feb 2026 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905691; cv=none; b=WflAsCslXjEe6GQz8rQ+tTm23sGvPCUg4ym3XL8xJoBDPzum2lYvukPHjyZkeEbXPu9deyrX41zhT4uJvKyYk+FzF5z2NlhoqbllcFKloOEn1S3dz0lKyGyhYW7iTFr1Lm5dNqkGZeTf8tT33MEHMU2V7VEkd4k8205HjA7JYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905691; c=relaxed/simple;
	bh=5iN4Au8UeMri4/4aTlWwZL5atQwbRH8ebxaQUHqwz2s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=K6QkPCH71eFlJvi57SjkTX6NmAq168amWQixxPJ18dt/5xoy3w2B4LH6E1jUwrr+sEAN75J0mxBholO1J+gIjt0eaig+iZ3Yzm12D4ZRObXvDbgceKmdcUijoMforUWgJ4+zss+ocT5Hb4eT9gYLjhWNNuBc5gmK6GoQ2voxMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qD++ga1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1A3C19425;
	Thu, 12 Feb 2026 14:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770905691;
	bh=5iN4Au8UeMri4/4aTlWwZL5atQwbRH8ebxaQUHqwz2s=;
	h=Date:From:To:Cc:Subject:References:From;
	b=qD++ga1EipNku49K9KDr4FwpMMGbM/xHHR98ZELglWNTXuOT/WecTQeGk6/H5BI5U
	 Y0ZKPNWk8X1oH/sYfomyZNBbdId643Ce86MAkJYdQn9fXNQHMo7GKhUQYM4PZN7yqV
	 qpRqCOuvr01xHgWXZ35EK0njz4r58qDEH74S3BiNwuhJvxKQSF+4uoNiu3Y2Kacyv6
	 97q46v+9M/h/vad5SGTcTv1XT7y2VhdvAsBn/OUbCWNAunpX5k043hJE/ubeUQLg7B
	 DxpS+e7T74rLHcNCTone/XlxYwZXOr/6aBmfqxNwaFF+B4t+9MTuI6Jk7nMQp5Ch0C
	 704QwXX0xNKOA==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vqXT0-000000002mM-2XMg;
	Thu, 12 Feb 2026 09:14:50 -0500
Message-ID: <20260212141450.462148762@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 12 Feb 2026 09:14:35 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-next][PATCH 2/3] tracing: Reset last_boot_info if ring buffer is reset
References: <20260212141433.849771751@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215965-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,efficios.com:email]
X-Rspamd-Queue-Id: 8C88312E2EF
X-Rspamd-Action: no action

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Commit 32dc0042528d ("tracing: Reset last-boot buffers when reading
out all cpu buffers") resets the last_boot_info when user read out
all data via trace_pipe* files. But it is not reset when user
resets the buffer from other files. (e.g. write `trace` file)

Reset it when the corresponding ring buffer is reset too.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/177071302364.2293046.17895165659153977720.stgit@mhiramat.tok.corp.google.com
Fixes: 32dc0042528d ("tracing: Reset last-boot buffers when reading out all cpu buffers")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index fd470675809b..e884d32b7895 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4127,6 +4127,8 @@ static int tracing_single_release_tr(struct inode *inode, struct file *file)
 	return single_release(inode, file);
 }
 
+static bool update_last_data_if_empty(struct trace_array *tr);
+
 static int tracing_open(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
@@ -4151,6 +4153,8 @@ static int tracing_open(struct inode *inode, struct file *file)
 			tracing_reset_online_cpus(trace_buf);
 		else
 			tracing_reset_cpu(trace_buf, cpu);
+
+		update_last_data_if_empty(tr);
 	}
 
 	if (file->f_mode & FMODE_READ) {
@@ -5215,6 +5219,7 @@ tracing_set_trace_read(struct file *filp, char __user *ubuf,
 int tracer_init(struct tracer *t, struct trace_array *tr)
 {
 	tracing_reset_online_cpus(&tr->array_buffer);
+	update_last_data_if_empty(tr);
 	return t->init(tr);
 }
 
@@ -7028,6 +7033,7 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 		ring_buffer_set_clock(tr->snapshot_buffer.buffer, trace_clocks[i].func);
 	tracing_reset_online_cpus(&tr->snapshot_buffer);
 #endif
+	update_last_data_if_empty(tr);
 
 	if (tr->scratch && !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT)) {
 		struct trace_scratch *tscratch = tr->scratch;
-- 
2.51.0



