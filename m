Return-Path: <stable+bounces-228640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF3EF6NNwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:26:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6520F2F47D7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62656303C4C4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C163AD536;
	Mon, 23 Mar 2026 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gfPETkr5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A923ACF03;
	Mon, 23 Mar 2026 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275688; cv=none; b=Z0m7J/RzX+p/p3sjb2HnIBKYmP16Pjtr6eSrMZhltdnWcEJCdmMR1wZceQdvXD4auScD2a/1kRjyKhbK0mJXNuNa2DbMJThNMYBGtRy4eNLpmZ5CwT+UCDWTzrv34Bdh27XgnQ0ylYAZiamCuHJMZezfV988ZeqwWX0BE0eQPNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275688; c=relaxed/simple;
	bh=GD0ww/ZP5oY3AlUI1XuA2g8zxu47eaTpyGd4H+LFO8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gT5WIDeldLdYWaeoJ6pUjf3/Nb5AP7cIb3954pFR3ywZI28cT7yRYl8qCAueVNTIXBLAdyBoUlexYlvZKH/TF3KMd1Sxpg0rYKx18/wH94XEiDPPuCm4sc9K6vtPSOQFOmNMhFNhsXM5djknxh84FOv2MZTOhSLr+CxBVokbw98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gfPETkr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0078DC2BCB3;
	Mon, 23 Mar 2026 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275688;
	bh=GD0ww/ZP5oY3AlUI1XuA2g8zxu47eaTpyGd4H+LFO8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gfPETkr5l2Q5dSm4LoZuWCFRpOh42SHCzCvH8dC4NfV4JRAbiW670tTiKdIQfiBq9
	 0PpZ9AVLfznPizYt0Rji79MUpK9tC45c+bKBOqjQ69yGvMUbSGnkvkXVf+XoI5jN/u
	 82XsR2+jPWrfsyvKYrGNksLgWFWnyXXj1eqIuaOs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrei-Alexandru Tachici <andrei-alexandru.tachici@oss.qualcomm.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.12 183/460] tracing: Fix enabling multiple events on the kernel command line and bootconfig
Date: Mon, 23 Mar 2026 14:42:59 +0100
Message-ID: <20260323134531.039235695@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228640-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6520F2F47D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3999,7 +3999,11 @@ static char bootup_event_buf[COMMAND_LIN
 
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
 



