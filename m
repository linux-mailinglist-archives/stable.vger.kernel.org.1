Return-Path: <stable+bounces-221160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHv3F+9Jo2kF/QQAu9opvQ
	(envelope-from <stable+bounces-221160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:02:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 968351C7D11
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF4593245D0A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8904373148;
	Sat, 28 Feb 2026 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K82l3ZCl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0FE37314B;
	Sat, 28 Feb 2026 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301512; cv=none; b=eoMAl+ZwOSezv7Z4KnRRC5LeZsOlGi9+1fZJeZOOrQeYY4e8cEnJb5ZcRftr3U1MzM91+z19hN6yGzssHhTBXnITfymtk0WHL1nZB7tgv8/0jYrXOZflvw09AGD8vXnjlDYqscYPuWoNeXBEgYDS4SKKCyopY8OLqg7Do3Di5Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301512; c=relaxed/simple;
	bh=XRwiZaNZbQuldDj1VDHUkDd1Y9KjC1P2HuPvJvBYOIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Op0blqbHLwhMYIxE8ZueESS1hNLSnvkO5algVYKQf+3ikFeCkipjLxPeEpsC3OBQDnDrZPBphtLkEaf3Cez8MtCN/kW+OZggln+yM/sOax1N+Ku+WTbcy43h0KNCwez3hzB8C5Lb9exyZjBXMrac+PQ+XfE3/w5Vj6QgLnUr7Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K82l3ZCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E428DC116D0;
	Sat, 28 Feb 2026 17:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301512;
	bh=XRwiZaNZbQuldDj1VDHUkDd1Y9KjC1P2HuPvJvBYOIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K82l3ZCl0cFQ8r9Z95KU39H/S47scP/nW+8BpLPKq+5PkBkMqAU7VcPMqCsy5bHOf
	 T7fm49YK8XxaB5iXvPbsWoN0rNCJzhCtU2ZBaLjpiWKbqCBLqxTOoF+aBW984umXeG
	 LRaBFD6+EoQv7z9xvyCTFkN6m7JXpKbwIrU/KkXC8vw/0BEB/4OPOhSGDQHVa0mx89
	 oQcDZ/WswHmJV98g5kVCGI2dtcHEe7b1rM1nZAEspx762TE2L0c2Y4QYvZfW3dLtl/
	 NKXrYh0PgR4YsTtB43TkX+4F9jjcIeMmrq9AB7J+pRc53JIcWEy3mY/tTLIOuLDK0r
	 2NigqZ7xODfNw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	stable@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 698/752] tracing: Reset last_boot_info if ring buffer is reset
Date: Sat, 28 Feb 2026 12:46:49 -0500
Message-ID: <20260228174750.1542406-698-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221160-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,efficios.com:email,goodmis.org:email,msgid.link:url]
X-Rspamd-Queue-Id: 968351C7D11
X-Rspamd-Action: no action

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 804c4a2209bcf6ed4c45386f033e4d0f7c5bfda5 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e1d902464e080..d2eabc162205c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4852,6 +4852,8 @@ static int tracing_single_release_tr(struct inode *inode, struct file *file)
 	return single_release(inode, file);
 }
 
+static bool update_last_data_if_empty(struct trace_array *tr);
+
 static int tracing_open(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
@@ -4876,6 +4878,8 @@ static int tracing_open(struct inode *inode, struct file *file)
 			tracing_reset_online_cpus(trace_buf);
 		else
 			tracing_reset_cpu(trace_buf, cpu);
+
+		update_last_data_if_empty(tr);
 	}
 
 	if (file->f_mode & FMODE_READ) {
@@ -5917,6 +5921,7 @@ tracing_set_trace_read(struct file *filp, char __user *ubuf,
 int tracer_init(struct tracer *t, struct trace_array *tr)
 {
 	tracing_reset_online_cpus(&tr->array_buffer);
+	update_last_data_if_empty(tr);
 	return t->init(tr);
 }
 
@@ -7582,6 +7587,7 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 		ring_buffer_set_clock(tr->max_buffer.buffer, trace_clocks[i].func);
 	tracing_reset_online_cpus(&tr->max_buffer);
 #endif
+	update_last_data_if_empty(tr);
 
 	if (tr->scratch && !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT)) {
 		struct trace_scratch *tscratch = tr->scratch;
-- 
2.51.0


