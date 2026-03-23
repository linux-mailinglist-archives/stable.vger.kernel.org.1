Return-Path: <stable+bounces-229728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLaWBIV0wWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:12:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCCA2F9957
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D6DE30C2D8D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B043B95E4;
	Mon, 23 Mar 2026 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NWk0ub+E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4894638B7C4;
	Mon, 23 Mar 2026 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282707; cv=none; b=NswkufzZAjHsNfzfIrR9fZrHuwjfTJv5BztHzk/ZvpInbVKvaJaKjuX3+c/dNQMO4O3YiALdsVjPHRqwPzV7FPWLizO4C/iNL51kS+//bfc2LFvpKkoV3Ldggw2/LyGPOKCtkcynwsLq86LoWF+igsS5mHNU98RywB6mgIcSQhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282707; c=relaxed/simple;
	bh=1L3JCWHpEA/g7nsyUEzi669NVSItSjOtorhqcQynbG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1FPedGGSEP7HZ3i0yooAcJch8Jjd1W5c+/CD7qVCFktYWqMov6wJEDY+gbMAX5Qore4ZnzTB95k9MLM9CFx/PE3pqLx08m0UHxk4apj0ok7ODuuRyjmT6ReElI1d/DioTIRFfxU0CC4wyNV5GIf/rprNxlEkKVwNCy0FTu1XZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NWk0ub+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48DBC2BCB0;
	Mon, 23 Mar 2026 16:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282707;
	bh=1L3JCWHpEA/g7nsyUEzi669NVSItSjOtorhqcQynbG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NWk0ub+E1kqeeyclc889eBeyrFTu/i0fl1zPXOHJ4PVYQbAEkqYo0qi+m8srzUjbU
	 uXVVrRmZGxCCLilszQUpZmlbT4xFTzRkcYjoWRhmlBmPo16tXWMUsZ1Re9nZWdtCgF
	 TJxcQn5abIbd93NwwI3ioEUtqWinutmIxngjY9Ac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Law <objecting@objecting.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH 6.1 256/481] lib/bootconfig: fix off-by-one in xbc_verify_tree() unclosed brace error
Date: Mon, 23 Mar 2026 14:43:58 +0100
Message-ID: <20260323134531.393988430@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229728-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EDCCA2F9957
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -793,7 +793,7 @@ static int __init xbc_verify_tree(void)
 
 	/* Brace closing */
 	if (brace_index) {
-		n = &xbc_nodes[open_brace[brace_index]];
+		n = &xbc_nodes[open_brace[brace_index - 1]];
 		return xbc_parse_error("Brace is not closed",
 					xbc_node_get_data(n));
 	}



