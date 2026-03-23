Return-Path: <stable+bounces-227951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FawAs4ZwWn5QQQAu9opvQ
	(envelope-from <stable+bounces-227951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:45:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CD92F06AC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBEAB303B92B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0B438C42E;
	Mon, 23 Mar 2026 10:40:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097EA38C42B;
	Mon, 23 Mar 2026 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262424; cv=none; b=Z64fkQWAfbsXt83lcXv7dRDcVar3uOwEqN2p5Q2QKDeaAyqgcs5G+ksqrva3z0rqfb7sEHBEoyxHa6+PE9S0xDADOc/uYhQFjBi8VmVzR35UXs5TYsUA5UYdgV4cLDflZKKDHbCdDDcUjt28Gcp8AEeWg6IS4geQTwTm02qzLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262424; c=relaxed/simple;
	bh=1hCCkmQUs0bLrA/OH4MBJ4sc2NkuG0D52C4RqPnGYSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+gZTXtOFPNVobH5G9iULe/0ejxJ+rYQyIAI8R/VzFQcxXXsDja6CjwYYTEE1Ls/a0ZbutUtDHhoIUFzhFn92+Vn+Hz43FzY2JlX5Fwy6U950jb5IqTMITBTXKq54hoBgjkplrbIpWFyeLaF8VIcFiQ/AdJAYBU7TiyytBFn8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1w4cOk-00000001Wr7-16Ro;
	Mon, 23 Mar 2026 11:20:38 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: fprobe: fix the length of unused fgraph_data
Date: Mon, 23 Mar 2026 11:19:36 +0100
Message-ID: <20260323102020.239567-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[kaiser.cx : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227951-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[martin@kaiser.cx,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43CD92F06AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If fprobe_entry does not fill the allocated fgraph_data completely, the
unused part is zeroed with memset.

Fix the length for this memset call. Both reserved_words and used are in
units of return stack words, but memset needs the number of bytes.

Cc: stable@vger.kernel.org
Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 kernel/trace/fprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index dcadf1d23b8a..6a1192515afd 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -451,7 +451,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 		}
 	}
 	if (used < reserved_words)
-		memset(fgraph_data + used, 0, reserved_words - used);
+		memset(fgraph_data + used, 0, (reserved_words - used) * sizeof(long));
 
 	/* If any exit_handler is set, data must be used. */
 	return used != 0;
-- 
2.43.7


