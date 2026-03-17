Return-Path: <stable+bounces-226794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO9lDFyVuWlcKwIAu9opvQ
	(envelope-from <stable+bounces-226794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:54:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF5B2B0546
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3AB43377010
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0DD30C63B;
	Tue, 17 Mar 2026 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZscHh7W1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F802DECC6;
	Tue, 17 Mar 2026 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768222; cv=none; b=vBYeY+jPtxGALxWXQyklav5exsPsITRw3aFrI6+yjsLVYDw+fKmGSKn7bwPuKeWi3irw4FOco1Iv/BLPdgxqIdePjFdBGeFbjzU+EXUuNQ0TH0BmqTO7Ro9sM+MpOkM9GxkvrO61m7l3/TX6C3n6MN9Gy7P2VzpoDsBUm5Ir3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768222; c=relaxed/simple;
	bh=sinkKH5kMEc/NP4LhgbP45TeW6ldarB3rNqLPxCMHak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X46OAPkDeFjv61Y1vIDDONw3kCBemUKzy2TsggycloER/n/RGmXA1AtCZrr8HSMJoleqRj1nkLJHbQWvBaIPDxxJhC7AjBWzd4VonUgFBEcAr3XOazEyONPKQ1LsNwXVG0ZHVGzvj/We3HBFSFnbEjE086BkqsVLUQPz8V7Y1Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZscHh7W1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DB6C4CEF7;
	Tue, 17 Mar 2026 17:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768221;
	bh=sinkKH5kMEc/NP4LhgbP45TeW6ldarB3rNqLPxCMHak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZscHh7W1hlXDv+7j3g6r/ce7gQW2DBlsLxRkbNTG0wXyAFICtz3XrIZHSQPQupB8C
	 iBu4pBLcqCGCcNSfoTNBGMnTxVVfdyqFuV8pMJQxsGf0mRctpUYOaP5RPI5wcaUJq2
	 wiRH1vly06oAVhmee8zmgZTtZZH3aHDdOHWROZB4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrei-Alexandru Tachici <andrei-alexandru.tachici@oss.qualcomm.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.18 261/333] tracing: Fix enabling multiple events on the kernel command line and bootconfig
Date: Tue, 17 Mar 2026 17:34:50 +0100
Message-ID: <20260317163009.048168259@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226794-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email,efficios.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,qualcomm.com:email]
X-Rspamd-Queue-Id: 8AF5B2B0546
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4342,7 +4342,11 @@ static char bootup_event_buf[COMMAND_LIN
 
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
 



