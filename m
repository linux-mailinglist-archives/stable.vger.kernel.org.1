Return-Path: <stable+bounces-215041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG77HWvxiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:38:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C89B7110990
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8B3D31C60C1
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749BF3783D3;
	Mon,  9 Feb 2026 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D2CFAkW/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891423B604;
	Mon,  9 Feb 2026 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647477; cv=none; b=lSPmF+i9BSirs/EJZL3AkqdfcNULrnenirAPalhlEHQH+WB9yPTh2/2TwiVS4tlArNIgO51b4wsQpOXYd+tznjSNRBWOGPCgGAEKFUOh5VQZtDVa3GDT5ZMk4x+QddJozQTEO5NgcorzQWINXIoV6mXvEQEonooC7x2Hds2rth0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647477; c=relaxed/simple;
	bh=2PL94hpQS6vf+UisD1u2/+Wc79PJOoIJRM3a4gJoD+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1BfNzgzb+9aPBle8+KHlLQ4ayxPsaJnNJFl+J79M3RmzxLvzJrbVARP6uN3PCchqQ0v7el0d3HwX/DIp9YFvp2uBpBEUXsJCF/xxh/g8fQHOnXuifczpHMrvCsioYu4Rt2f2X963uWclzTRm9+ThpPB2h7EhhPTUx6IQkuUDS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D2CFAkW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB673C116C6;
	Mon,  9 Feb 2026 14:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647477;
	bh=2PL94hpQS6vf+UisD1u2/+Wc79PJOoIJRM3a4gJoD+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2CFAkW/xlssdKTSFpmVEChQaObz7XgVzB8x0BYbT8mxKPQbuUSpymfWBWTS/128M
	 L0R0Jzs/RykXk/3kcOGp+FQu5MZxkeaauVMHrGo4lMC1VnzpgvL2TJPLlLQD+jH9+v
	 kKfzKTG9O+DkUBRJe60Tf/OTkbNW8EPqbHPVnilk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ian Rogers <irogers@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 111/175] tracing: Avoid possible signed 64-bit truncation
Date: Mon,  9 Feb 2026 15:23:04 +0100
Message-ID: <20260209142324.411334819@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215041-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,efficios.com:email]
X-Rspamd-Queue-Id: C89B7110990
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 00f13e28a9c3acd40f0551cde7e9d2d1a41585bf ]

64-bit truncation to 32-bit can result in the sign of the truncated
value changing. The cmp_mod_entry is used in bsearch and so the
truncation could result in an invalid search order. This would only
happen were the addresses more than 2GB apart and so unlikely, but
let's fix the potentially broken compare anyway.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20260108002625.333331-1-irogers@google.com
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 142e3b737f0bc..907923d5f8bbb 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6061,10 +6061,10 @@ static int cmp_mod_entry(const void *key, const void *pivot)
 	unsigned long addr = (unsigned long)key;
 	const struct trace_mod_entry *ent = pivot;
 
-	if (addr >= ent[0].mod_addr && addr < ent[1].mod_addr)
-		return 0;
-	else
-		return addr - ent->mod_addr;
+	if (addr < ent[0].mod_addr)
+		return -1;
+
+	return addr >= ent[1].mod_addr;
 }
 
 /**
-- 
2.51.0




