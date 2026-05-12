Return-Path: <stable+bounces-245632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPiJKqcxA2oA1gEAu9opvQ
	(envelope-from <stable+bounces-245632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:56:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB20521C84
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E06A13024A2C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2B637DAA5;
	Tue, 12 May 2026 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N1TKlxFt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12DF3911DC
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593828; cv=none; b=HTpTRyxZC2CnAVo216wmase/GWXXHjTEZMl4/MxkUuTMVs64C3b5wI5TIQnu7WJgYu9gyQ+PzpY06QTxXY6F9tFPxLHRPRLc27TovS+x3Igt0bwDwCZ7CKeYTNApq5LfuFY+dBD9WdD3qzbZZukt0ehXBQCpUxc0fUlsgQ+t3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593828; c=relaxed/simple;
	bh=X3JRhr9XAtkE14c3MjxffnFEeC4sLZ1Sz95F4anRoHc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LSv8vtYFLy7W2npgdNAfZkEvRiOC9COBMexnh+huTsU+CpMg98FlEpVvBbLgu37v3l1tq6Yi4NmPUPV9E822jPFVXrY0i98fppxHzqXrvOiygsNfi9J/PS+xthP+XG62wtWh+s711SbLW+vnn91c5zTcXzficj+AG8tquBRe+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N1TKlxFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2F2C2BCB0;
	Tue, 12 May 2026 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778593828;
	bh=X3JRhr9XAtkE14c3MjxffnFEeC4sLZ1Sz95F4anRoHc=;
	h=Subject:To:Cc:From:Date:From;
	b=N1TKlxFt+BySBnD3Bm/xImwd40+kKkYqmUHKiYVCFX57OE1/bRDOqJNUfQPgMK0bM
	 yUEzh1pQ/FdSOE+9Hm15e7zs/LeQkdAeEQko1afs43uLGMEUpjqq+M3vBGtUkRXBHA
	 UiB3u8heh4i3GUGKsnpzjSZAIsqxOdqO8eM2hGXs=
Subject: FAILED: patch "[PATCH] tracing/probes: Limit size of event probe to 3K" failed to apply to 6.6-stable tree
To: rostedt@goodmis.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:50:25 +0200
Message-ID: <2026051225-penny-nutcase-3d81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3EB20521C84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245632-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,msgid.link:url,linuxfoundation.org:dkim,goodmis.org:email,efficios.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b2aa3b4d64e460ac606f386c24e7d8a873ce6f1a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051225-penny-nutcase-3d81@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b2aa3b4d64e460ac606f386c24e7d8a873ce6f1a Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 28 Apr 2026 12:23:02 -0400
Subject: [PATCH] tracing/probes: Limit size of event probe to 3K

There currently isn't a max limit an event probe can be. One could make an
event greater than PAGE_SIZE, which makes the event useless because if
it's bigger than the max event that can be recorded into the ring buffer,
then it will never be recorded.

A event probe should never need to be greater than 3K, so make that the
max size. As long as the max is less than the max that can be recorded
onto the ring buffer, it should be fine.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: 93ccae7a22274 ("tracing/kprobes: Support basic types on dynamic events")
Link: https://patch.msgid.link/20260428122302.706610ba@gandalf.local.home
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e1c73065dae5..e0d3a0da26af 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1523,6 +1523,12 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	parg->offset = *size;
 	*size += parg->type->size * (parg->count ?: 1);
 
+	if (*size > MAX_PROBE_EVENT_SIZE) {
+		ret = -E2BIG;
+		trace_probe_log_err(ctx->offset, EVENT_TOO_BIG);
+		goto fail;
+	}
+
 	if (parg->count) {
 		len = strlen(parg->type->fmttype) + 6;
 		parg->fmt = kmalloc(len, GFP_KERNEL);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 9fc56c937130..262d8707a3df 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -38,6 +38,7 @@
 #define MAX_BTF_ARGS_LEN	128
 #define MAX_DENTRY_ARGS_LEN	256
 #define MAX_STRING_SIZE		PATH_MAX
+#define MAX_PROBE_EVENT_SIZE	3072
 
 /* Reserved field names */
 #define FIELD_STRING_IP		"__probe_ip"
@@ -561,7 +562,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_TYPE4STR,		"This type does not fit for string."),\
 	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),\
 	C(TOO_MANY_ARGS,	"Too many arguments are specified"),	\
-	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),
+	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),	\
+	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a


