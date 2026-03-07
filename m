Return-Path: <stable+bounces-223428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJQUD6BArGl8oAEAu9opvQ
	(envelope-from <stable+bounces-223428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 16:13:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B421422C574
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 16:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A7DC30131F6
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 15:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B00E3A452A;
	Sat,  7 Mar 2026 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmWEfbYk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B95395D87;
	Sat,  7 Mar 2026 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772896359; cv=none; b=mtfLsUrDhtnIQ/B65SoNXV5Z33ziv+nHd+zeBNTTpsAZioAeR8pPKHaegWQ+PCeKT0XJpp4UMkjRcbaNOHKmE6ILWh5rw8GizvvAxjMifSbcbkwK3EKAzqcEnaCgya+NdRiPqi9xwNZZGkjl1UOTCajsRL3EPFEn5wur1Ra38LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772896359; c=relaxed/simple;
	bh=WAy+8low3pplFgAVrxMFFzftkqpYzsxhPoP9RFA1wOg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BOVoslQjAsz3bZMXo9t7v1yHUEYCfHMM7VSbQv/nWr4D3UqgGXZ9kMR8yoqK8cXRUPURvBLfPcSeS7zYBlCj1cHYpZCmYAfxKR/bH2jQ1dLDDWY+1DPP+8cKD1chaKuBAqb9Pwj34Ps3clS0jHe9YcGShFI7eAwUJPYUPxHu4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmWEfbYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA136C2BCAF;
	Sat,  7 Mar 2026 15:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772896358;
	bh=WAy+8low3pplFgAVrxMFFzftkqpYzsxhPoP9RFA1wOg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=TmWEfbYk5kXp+T06ZIjvWlf+KPf/bm8/wNHLbeNJeKLoxZ3yDxkRtQfApY0Yf2Q/9
	 lMYbk/BzMt0zRRJ+Y6JIHvbSgfqodEj4W1D+5yLOcwNuj2fZViQqtYVguo76IB4g1L
	 M0bvt0m/MzKGnNODs/9kwjLrjTmfWhYZqnc44vmiK8euj6NRsVT2Q5lARN8257DtWY
	 luYs0YdIHLbJaHcfgXTIVUnE7KVAstFu7gC3pYsSIR9Bmq5pxMJ1zLCBYA1/xbP28n
	 Cw1O+W84dtyy9cnsn0Kl5TMQ5cQ+6ELuUo+wkIVStXJqmBwnqbM4TC5sWjh1zGXoo9
	 F/ge1MQQHu+2w==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vytKc-000000010Ns-08Vs;
	Sat, 07 Mar 2026 10:12:42 -0500
Message-ID: <20260307151241.888254981@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 07 Mar 2026 10:12:26 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Andrei-Alexandru Tachici <andrei-alexandru.tachici@oss.qualcomm.com>
Subject: [for-linus][PATCH 2/3] tracing: Fix enabling multiple events on the kernel command line and
 bootconfig
References: <20260307151224.447677123@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: B421422C574
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223428-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.944];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,qualcomm.com:email]
X-Rspamd-Action: no action

From: Andrei-Alexandru Tachici <andrei-alexandru.tachici@oss.qualcomm.com>

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
---
 kernel/trace/trace_events.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index b7343fdfd7b0..249d1cba72c0 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -4493,7 +4493,11 @@ static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
 
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
 
-- 
2.51.0



