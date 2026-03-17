Return-Path: <stable+bounces-226444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OdeHZOJuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:04:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B7E2AEDEE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC6873043623
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0C13F65E5;
	Tue, 17 Mar 2026 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G+jZrcy8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E83F54B8;
	Tue, 17 Mar 2026 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766743; cv=none; b=EDpGIhdq1Tc4fJ/NMNSQV3hv5Y6flojhQIboUm8Bl9m2YN3NjyGZ/5Mehhm/yTK+jb3mtvZg9d7CnKaAm5tfUy5gZliPFsS+JXvYJQVB+oNYT0bvTtBJhxHF1FbK9qXerGR63tPGIOzTwupjKDUhpDgeWxp9ymZua+q8dfUtHBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766743; c=relaxed/simple;
	bh=sSmPp9vhigD3qW8NAPgtEr4UfCBy019L/PInY4LUCjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7CaA+x7u3F8UTFIaFAS7cIVuXbXcjz/pxkiHS3x57d4sEUrOKBBTnBdxOh9PHyq6NHlN1yn/aPUs6Ry78stUP9ywJ8IU0xhEeL3MP8crcqD+zZo5gHsu2zojqLFNyhuU3VFHanylU+poNawL6h/AnL83D48I2LPcQA8WwLZM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G+jZrcy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8905EC4CEF7;
	Tue, 17 Mar 2026 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766743;
	bh=sSmPp9vhigD3qW8NAPgtEr4UfCBy019L/PInY4LUCjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G+jZrcy8ZlbDna//X0/BARrdu5R4NcxTXXcwACWHJUyv5w+eJpUWrHvaSrWAouYMD
	 af5PPceQxugKD7Acxf2iM70aL/18CAzVNLBVBSKpYqz9SsNXF68oCc4QmznVLP2IWV
	 sid2/zXLFUx8hSkxup/QqUvDnc1EiX2RG0bcakBU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrei-Alexandru Tachici <andrei-alexandru.tachici@oss.qualcomm.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.19 312/378] tracing: Fix enabling multiple events on the kernel command line and bootconfig
Date: Tue, 17 Mar 2026 17:34:29 +0100
Message-ID: <20260317163018.474767747@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226444-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,efficios.com:email,msgid.link:url,goodmis.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: E0B7E2AEDEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrei-Alexandru Tachici <andrei-alexandru.tachici@oss.qualcomm.com>

commit 3b1679e086bb869ca02722f6bd29b3573a6a0e7e upstream.

Multiple events can be enabled on the kernel command line via a comma
separator. But if the are specified one at a time, then only the last
event is enabled. This is because the event names are saved in a temporary
buffer, and each call by the init cmdline code will reset that buffer.

This also affects names in the boot config file, as it may call the
callback multiple times with an example of:

  kernel.trace_event = ":mod:rproc_qcom_common", ":mod:qrtr", ":mod:qcom_aoss"

Change the cmdline callback function to append a comma and the next value
if the temporary buffer already has content.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20260302-trace-events-allow-multiple-modules-v1-1-ce4436e37fb8@oss.qualcomm.com
Signed-off-by: Andrei-Alexandru Tachici <andrei-alexandru.tachici@oss.qualcomm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -4341,7 +4341,11 @@ static char bootup_event_buf[COMMAND_LIN
 
 static __init int setup_trace_event(char *str)
 {
-	strscpy(bootup_event_buf, str, COMMAND_LINE_SIZE);
+	if (bootup_event_buf[0] != '\0')
+		strlcat(bootup_event_buf, ",", COMMAND_LINE_SIZE);
+
+	strlcat(bootup_event_buf, str, COMMAND_LINE_SIZE);
+
 	trace_set_ring_buffer_expanded(NULL);
 	disable_tracing_selftest("running event tracing");
 



