Return-Path: <stable+bounces-264385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h1B9BwZ1MWo2jwUAu9opvQ
	(envelope-from <stable+bounces-264385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:08:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9091C691B92
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:08:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=yGyiMfJy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264385-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264385-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F002F32C88A7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BE0477E57;
	Tue, 16 Jun 2026 16:00:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815FA477E37;
	Tue, 16 Jun 2026 16:00:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625610; cv=none; b=Dyniov4h27GLRhS/uaHKkZBV/beXSuu3f00rQ5SMeeoZMnmzdQaOZOS2oyBXXnX1kQIRkue9XRL9w3hed+QQ+USwHS4OnLsHnsAh16ScdHCxRy4lFj0tqs32WzLhhKXk2Y+NVXWPz4WuSyYcyj8AGlv4mpp1GY7uCZ+Y3FDwBxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625610; c=relaxed/simple;
	bh=7YveC6kSKmjghzwW1+Hez5WASt25ancWuclBxIN/5Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcc6DWcidIuXnqFzN8z59uX6XO6sTA/wHFr82QGrQogBGMSp5OB7ISHhdSaLZfhd6luVDTwq3IxKP+V0QQX0CqXhgQ5NuV0TSYIZzWWHxgF0ZkzciwwA1BWP+uyEsz95WiblVjiLx+zan2bHXmlzBxjQ7KAkEXnFcbhpHHEtyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yGyiMfJy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3C41F00A3D;
	Tue, 16 Jun 2026 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625609;
	bh=KJJXYa01wjjpe8vL1RevYACbuGkuIGlPUeSQ+7woFHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yGyiMfJyrac9EBFk5fZEKmzLlwLWp96f8UiwECMgslGRo1R8XMUL0qq996leOKmwA
	 eb8ZbpVbXeyrZqS+H+lDf152kuieeBOBhsuFKT1/P669LcmKakOiSMASPqfnaGs6O4
	 hzGcC21R0dHv9iYyVlUMBQjd1r79ZqlDL0UPCCiQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 6.18 158/325] tracing/probes: Point the error offset correctly for eprobe argument error
Date: Tue, 16 Jun 2026 20:29:14 +0530
Message-ID: <20260616145105.623584897@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-264385-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mhiramat@kernel.org,m:rostedt@goodmis.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,goodmis.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9091C691B92

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -962,8 +962,6 @@ static int parse_probe_vars(char *orig_a
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



