Return-Path: <stable+bounces-265116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uXQvBtuEMWrnlQUAu9opvQ
	(envelope-from <stable+bounces-265116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:16:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95700692F08
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:16:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=jXAR9bk0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265116-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265116-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36D753081101
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF734779B1;
	Tue, 16 Jun 2026 17:05:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B346543E4BC;
	Tue, 16 Jun 2026 17:05:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629548; cv=none; b=ovCMyfvUy/+qolkk4LucnPsRehKWBmEOtJrWwoRE/g1olcctZysl5jAV7f07MvTPq2tocvl3yngJcsJmQzJgeJLfRWRqEKDpYmtDQv5lqbHfcQhmVeNp9Uq0DRLdb2OWp0CiY6Nh5eb7xh/SCMghPpbEJsNGovmKzOuu65igS3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629548; c=relaxed/simple;
	bh=ganKpKBH4TH/BwkjH9bOalzLuE7hKSZvmzSEia+ShTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mt2vucQS11mwEjSeev5ZMTRhJ54+QN3gJsDba0Nb2g7UiexWJBATiGkKbmV6wA8c5I5S1L/LV+QZjK9mgXU+HvLHgkM5ZuaRjpGDAUl4A2HTnk41PkoD5ehJ4F/QKy7jAjiMoHvjc7kZVR0ctQxyLJaZFTGL1wBZcrilHjfEgaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jXAR9bk0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C961F000E9;
	Tue, 16 Jun 2026 17:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629547;
	bh=JPNlIgCPUwutR63MvWwT0/TTx5+paxH7o+4fMo/On7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jXAR9bk0Fc3K6/K45M5FhqgHg00ev3MxdHvFD0ApEr67koNn3UVycfUgh0WyfTo8V
	 K1OAxToCox6HjHfyh60UlqknUlWT4F+fPt4L5/vzVY+Z5+pP1X1Hs8v46rBXJFPvrv
	 HlLKwxPjfQebbPeaUfdxiI01yK+OI+EdHUCkfrFQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 6.6 294/452] tracing/probes: Point the error offset correctly for eprobe argument error
Date: Tue, 16 Jun 2026 20:28:41 +0530
Message-ID: <20260616145132.986460134@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265116-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mhiramat@kernel.org,m:rostedt@goodmis.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95700692F08

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

commit 85e0f27dd1396307913ffc5745b0c05137e9beac upstream.

Fix to point the error offset correctly for eprobe argument error.
In the cleanup commit 1b8b0cd754cd ("tracing/probes: Move event parameter
fetching code to common parser"), due to incorrect backward compatibility
aimed at conforming to the test specifications, the error location was set
to 0 when a non-existent formal parameter was specified for Eprobe.
However, this should be corrected in both the test and the implementation
to point correct error position.

Link: https://lore.kernel.org/all/177967567399.209006.1451571244515632097.stgit@devnote2/

Fixes: 1b8b0cd754cd ("tracing/probes: Move event parameter fetching code to common parser")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_probe.c                                              |    2 --
 tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -933,8 +933,6 @@ static int parse_probe_vars(char *orig_a
 			code->op = FETCH_OP_COMM;
 			return 0;
 		}
-		/* backward compatibility */
-		ctx->offset = 0;
 		goto inval;
 	}
 
--- a/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
@@ -20,7 +20,7 @@ check_error 'e:foo/^12345678901234567890
 check_error 'e:foo/^bar.1 syscalls/sys_enter_openat'	# BAD_EVENT_NAME
 
 check_error 'e:foo/bar syscalls/sys_enter_openat arg=^dfd'	# BAD_FETCH_ARG
-check_error 'e:foo/bar syscalls/sys_enter_openat ^arg=$foo'	# BAD_ATTACH_ARG
+check_error 'e:foo/bar syscalls/sys_enter_openat arg=^$foo'	# BAD_ATTACH_ARG
 
 if grep -q '<attached-group>\.<attached-event>.*\[if <filter>\]' README; then
   check_error 'e:foo/bar syscalls/sys_enter_openat if ^'	# NO_EP_FILTER



