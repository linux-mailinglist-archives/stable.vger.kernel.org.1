Return-Path: <stable+bounces-236685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +6pjMhEh3Wn5aAkAu9opvQ
	(envelope-from <stable+bounces-236685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:00:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D063F074C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A52E4328FE83
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401A930B508;
	Mon, 13 Apr 2026 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gxadQttD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0252E2E11B9;
	Mon, 13 Apr 2026 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097541; cv=none; b=Dl1eDQPCLJeb/qh5XryOm2CL8PyHLQr0YghoFbJZOjLNFOvbGg4OhNaZ9ODCK0+2Pi6f73tg2BG0ahplPnoHQKuDxeN+ufQFJIRu6u5NGuxyr4pBf2Bgm3BRRk8G8PZva/3Galg0uiMNzXTsNg7KjOxcEF4rxRfzMi/vzXV4CWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097541; c=relaxed/simple;
	bh=KpEf4MZR/3yvNHDNguCDoSwQXN35290e7jg9rdzSFOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESFQ9lf1usYQH/ZqSXulyRCpI1X54H13amqYx4kJN5hcLTs1hU3m4hmbfpfb3oFmOSjt2kWZd3FvjzS3hfBlAz1w/mNJ6Aj6mRCHlnrN/LSEmayKBUy2uNl00NsLwMRYxWa+CgQw5ubLFZrbaBINOuNfWg2G6+pwpBVmkd/u9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gxadQttD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52603C2BCB0;
	Mon, 13 Apr 2026 16:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097540;
	bh=KpEf4MZR/3yvNHDNguCDoSwQXN35290e7jg9rdzSFOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxadQttD/i/eWwNkovWMprxonWOOCzk8V21cQosnA48J/QxesWNmef2VeH3sJE0qt
	 k8KgyVJRB+a99SI5xT2Qiq73iv6c/USWKFtjuvmn2K4GPO7TtWrevueBPkzFOec1XB
	 xsYlDxuqP2YhgVFwGLIwbiZxgGyuQrsk1uGtWUMw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Law <objecting@objecting.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH 5.15 176/570] lib/bootconfig: fix off-by-one in xbc_verify_tree() unclosed brace error
Date: Mon, 13 Apr 2026 17:55:07 +0200
Message-ID: <20260413155837.050067189@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236685-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,objecting.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41D063F074C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Law <objecting@objecting.org>

commit 39ebc8d7f561e1b64eca87353ef9b18e2825e591 upstream.

__xbc_open_brace() pushes entries with post-increment
(open_brace[brace_index++]), so brace_index always points one past
the last valid entry.  xbc_verify_tree() reads open_brace[brace_index]
to report which brace is unclosed, but this is one past the last
pushed entry and contains stale/zero data, causing the error message
to reference the wrong node.

Use open_brace[brace_index - 1] to correctly identify the unclosed
brace.  brace_index is known to be > 0 here since we are inside the
if (brace_index) guard.

Link: https://lore.kernel.org/all/20260312191143.28719-2-objecting@objecting.org/

Fixes: ead1e19ad905 ("lib/bootconfig: Fix a bug of breaking existing tree nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/bootconfig.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -725,7 +725,7 @@ static int __init xbc_verify_tree(void)
 
 	/* Brace closing */
 	if (brace_index) {
-		n = &xbc_nodes[open_brace[brace_index]];
+		n = &xbc_nodes[open_brace[brace_index - 1]];
 		return xbc_parse_error("Brace is not closed",
 					xbc_node_get_data(n));
 	}



