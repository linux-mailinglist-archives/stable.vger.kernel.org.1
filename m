Return-Path: <stable+bounces-228642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n0b0BW9UwWlVSQQAu9opvQ:T2
	(envelope-from <stable+bounces-228642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:55:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A393D2F570E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E78C31B990F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013323AC0D2;
	Mon, 23 Mar 2026 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uBWsE+rt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8385199FAB;
	Mon, 23 Mar 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275693; cv=none; b=kq72/N2orp688/YMPabClSDelj7jEuDzHY0G6/fBS8Q57BNxJZF6Oi+H7DiGfmlLBoEceTS3Wk0eS6KSNSLl5YXd2aIkZDupVNdViHjSMWymXZXGiE/+S0MXG8zj7RcPNF+fQU6zr9kInU0CsT7fFSe0rzobn4hMzJlyZ1nKtbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275693; c=relaxed/simple;
	bh=O254SxLn6JbhtO1ZFc1M5v3yYSdwrQ5g2djGWfYlbm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDyR++iMzaPzjg/cqOCkVyFrlGbSRTo/4CPqxm+nZEWzMt0o8C98ee0BEWJewCOaq7U18P+gSdBZaZI542FYFP6IuJrgQcvX0h7Pf6eCFZgiqSoPsWnZNPkev93AiPm4U2xhNeixlU9phTa9agut+7PrHxmlk8fq+6GE/sAhKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uBWsE+rt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B189C4CEF7;
	Mon, 23 Mar 2026 14:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275693;
	bh=O254SxLn6JbhtO1ZFc1M5v3yYSdwrQ5g2djGWfYlbm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBWsE+rtN+mlcd/ETN54bKQ+ZkSkSonoUcB78KYRoNG2Rk59tVN+CB8h8sMtuTSxF
	 ITXhGYInJjrFkI4crEZbxZaQQF5vBBaAcgmRVjOz2Sp4WVTW5e+NxAhauMKFECfTJF
	 JXZfIKbwc3lUU/7HwbtGeek5ZIHvs8haiP9Midqs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Calvin Owens <calvin@wbinvd.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.12 184/460] tracing: Fix trace_buf_size= cmdline parameter with sizes >= 2G
Date: Mon, 23 Mar 2026 14:43:00 +0100
Message-ID: <20260323134531.067899537@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228642-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A393D2F570E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Calvin Owens <calvin@wbinvd.org>

commit d008ba8be8984760e36d7dcd4adbd5a41a645708 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9227,7 +9227,7 @@ static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 
 static int
-allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size)
+allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, unsigned long size)
 {
 	enum ring_buffer_flags rb_flags;
 
@@ -9277,7 +9277,7 @@ static void free_trace_buffer(struct arr
 	}
 }
 
-static int allocate_trace_buffers(struct trace_array *tr, int size)
+static int allocate_trace_buffers(struct trace_array *tr, unsigned long size)
 {
 	int ret;
 
@@ -10479,7 +10479,7 @@ __init static void enable_instances(void
 
 __init static int tracer_alloc_buffers(void)
 {
-	int ring_buf_size;
+	unsigned long ring_buf_size;
 	int ret = -ENOMEM;
 
 



