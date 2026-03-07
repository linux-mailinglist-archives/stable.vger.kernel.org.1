Return-Path: <stable+bounces-223429-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI/rMLBArGl8oAEAu9opvQ
	(envelope-from <stable+bounces-223429-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 16:13:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F01D22C57B
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 16:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250CA30579F7
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 15:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7266D3A4F37;
	Sat,  7 Mar 2026 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0H3qlO7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342333A453F;
	Sat,  7 Mar 2026 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772896359; cv=none; b=ujjyKlUvmqXhvJy8t7TNnAyyHDKt10WcCSkpVw3iBCt+ZLjqaclcjR4TG85+5i26xed/ORRGEZVnfP99vA6WALcw8Ae4fxL3gHvP2j+PP5PYHr2tjm8pOXWKxRwttZLP093KIQttIVSdp9Y9RScBEuCAC6bQp8j8Wka/NDxqfNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772896359; c=relaxed/simple;
	bh=wLGbYtBu6WCu+zKFBx496dNl6JtNSkzUQ30UBesC5lY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=a0FqBCBB5qhX77384xDdNxhmYrXiFp5gVg4ppNQABdEOoG884fca2k6tWjX/pIaX44URFlUqzuY9wM9y8bkBOSuADsA4Lrhq1lf7UGJ++EwUmKO5Ay/QshXxnU3dGp2fpsrIY+mEdPBfI5SAY+WRCP7gJX2hAg0+EcwXP7g1Zxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0H3qlO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0869C2BCB1;
	Sat,  7 Mar 2026 15:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772896359;
	bh=wLGbYtBu6WCu+zKFBx496dNl6JtNSkzUQ30UBesC5lY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=A0H3qlO7TVP6x+XO5MD4G/CR0ylp7u85pF4U7+pEy0buw9z+OJczQm4cFqi7LHr2t
	 uomTM21whMBt3YsFXvMWo/T9MNLcyDFjGIhJaWOlRdifCvLeT1L0CcXvZ5of9db7XR
	 DJ/wNFenN5PGMgY1bOJBAsJoeIG8FSVnfy5/BIBEHDiIyOstkGsi1YOMCio5JVGy6i
	 WXOCcsAIlJ29rdAzohfGwO+wmqm7gpomVG+D6NebsyJzlCSiTwgXdqPG5CRi3RfWo/
	 FeseEOjxZT6/9PdYHfmmtsWbtb++VkHq3iTkTjhpFAmDJ7rO8J92XFlmyBZcBxR9+s
	 n2VJtXYaWPJVw==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vytKc-000000010OM-0o4Y;
	Sat, 07 Mar 2026 10:12:42 -0500
Message-ID: <20260307151242.050347117@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 07 Mar 2026 10:12:27 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Calvin Owens <calvin@wbinvd.org>
Subject: [for-linus][PATCH 3/3] tracing: Fix trace_buf_size= cmdline parameter with sizes >= 2G
References: <20260307151224.447677123@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 2F01D22C57B
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
	TAGGED_FROM(0.00)[bounces-223429-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.945];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,wbinvd.org:email,efficios.com:email]
X-Rspamd-Action: no action

From: Calvin Owens <calvin@wbinvd.org>

Some of the sizing logic through tracer_alloc_buffers() uses int
internally, causing unexpected behavior if the user passes a value that
does not fit in an int (on my x86 machine, the result is uselessly tiny
buffers).

Fix by plumbing the parameter's real type (unsigned long) through to the
ring buffer allocation functions, which already use unsigned long.

It has always been possible to create larger ring buffers via the sysfs
interface: this only affects the cmdline parameter.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/bff42a4288aada08bdf74da3f5b67a2c28b761f8.1772852067.git.calvin@wbinvd.org
Fixes: 73c5162aa362 ("tracing: keep ring buffer to minimum size till used")
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1e7c032a72d2..ebd996f8710e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9350,7 +9350,7 @@ static void setup_trace_scratch(struct trace_array *tr,
 }
 
 static int
-allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size)
+allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, unsigned long size)
 {
 	enum ring_buffer_flags rb_flags;
 	struct trace_scratch *tscratch;
@@ -9405,7 +9405,7 @@ static void free_trace_buffer(struct array_buffer *buf)
 	}
 }
 
-static int allocate_trace_buffers(struct trace_array *tr, int size)
+static int allocate_trace_buffers(struct trace_array *tr, unsigned long size)
 {
 	int ret;
 
@@ -10769,7 +10769,7 @@ __init static void enable_instances(void)
 
 __init static int tracer_alloc_buffers(void)
 {
-	int ring_buf_size;
+	unsigned long ring_buf_size;
 	int ret = -ENOMEM;
 
 
-- 
2.51.0



