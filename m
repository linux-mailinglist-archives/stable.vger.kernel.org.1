Return-Path: <stable+bounces-227294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA+IOIX8u2mzqwIAu9opvQ
	(envelope-from <stable+bounces-227294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:39:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E5A2CC191
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF8533027E0F
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61B63D3312;
	Thu, 19 Mar 2026 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOaEcpgJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EAD1F91E3
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927555; cv=none; b=Exm3w+lGDsgOvl7GlT1epyX6ZIUX8eb1UevuyqeUYqQJXU3JEl5ix3Bzxb9qOI0638CTA48p2ccMOiYd3lSWCnbfNgZHBvm10kWG0XMAF5qMcNmEuImz5GFr/PgGPvO6K23igJQg3m6A1GvsK3Fi31E1YDd9a8glAPy4cxFtrKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927555; c=relaxed/simple;
	bh=I/ASeHHVAHtIrSOg+z3q+6OFb16Ug9VFAmWHt2vvedg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrZbHJ5MHR0WegeYH1Upj6uzY+2dOPfza8ASr26djYQI+UfKYiXw7vNFJ/+qnrZw0vHj3B2sRlWoXHwv5l3PyK7rm+ANyENbs4G8JutQN/3K17Z68dnW5xe7S/9KlnWj1Pb58Z/9TmkeI9rPIvcizlEHdxMWTX76GZXWtgQaF04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOaEcpgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993E4C19424;
	Thu, 19 Mar 2026 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773927555;
	bh=I/ASeHHVAHtIrSOg+z3q+6OFb16Ug9VFAmWHt2vvedg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOaEcpgJGQiiwQ8um8EksZi9976iqyYFIJrLixku+NGXZviESk73OTglv0e53HiEc
	 ag8+hTOmTvLYy54MgmhEtGhxhvZIPo45mv80/L0gOv5OtKNtfC6laizb9AfW8DPcHy
	 /4uI0SVCNZ3DHezuVFnkTpad7grxIcc22fzAnmI5HisciV0voNTOVVcNdxU23c3CiT
	 q81VgLLGIOUEmBybCxVVh711MD4HztouUOnJRhSAJfWPTq0YXRxnT7EK4qP4MeXeca
	 pA2drPhuvqCLC4InvWE9OFDDP9EnZDddC4YTFq+UgzT0UUQpZC5tz82iMTzHnLAhwl
	 YIwL8PgLXi5sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] kprobes: Remove unneeded goto
Date: Thu, 19 Mar 2026 09:39:12 -0400
Message-ID: <20260319133913.2477768-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031701-glider-ominous-ade9@gregkh>
References: <2026031701-glider-ominous-ade9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227294-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.978];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86E5A2CC191
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 5e5b8b49335971b68b54afeb0e7ded004945af07 ]

Remove unneeded gotos. Since the labels referred by these gotos have
only one reference for each, we can replace those gotos with the
referred code.

Link: https://lore.kernel.org/all/173371211203.480397.13988907319659165160.stgit@devnote2/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: 5ef268cb7a0a ("kprobes: Remove unneeded warnings from __arm_kprobe_ftrace()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index da59c68df8412..b477102b72bb2 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1082,20 +1082,18 @@ static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 
 	if (*cnt == 0) {
 		ret = register_ftrace_function(ops);
-		if (WARN(ret < 0, "Failed to register kprobe-ftrace (error %d)\n", ret))
-			goto err_ftrace;
+		if (WARN(ret < 0, "Failed to register kprobe-ftrace (error %d)\n", ret)) {
+			/*
+			 * At this point, sinec ops is not registered, we should be sefe from
+			 * registering empty filter.
+			 */
+			ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
+			return ret;
+		}
 	}
 
 	(*cnt)++;
 	return ret;
-
-err_ftrace:
-	/*
-	 * At this point, sinec ops is not registered, we should be sefe from
-	 * registering empty filter.
-	 */
-	ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
-	return ret;
 }
 
 static int arm_kprobe_ftrace(struct kprobe *p)
@@ -1452,7 +1450,7 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
 	     unsigned long offset, bool *on_func_entry)
 {
 	if ((symbol_name && addr) || (!symbol_name && !addr))
-		goto invalid;
+		return ERR_PTR(-EINVAL);
 
 	if (symbol_name) {
 		/*
@@ -1482,11 +1480,10 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
 	 * at the start of the function.
 	 */
 	addr = arch_adjust_kprobe_addr((unsigned long)addr, offset, on_func_entry);
-	if (addr)
-		return addr;
+	if (!addr)
+		return ERR_PTR(-EINVAL);
 
-invalid:
-	return ERR_PTR(-EINVAL);
+	return addr;
 }
 
 static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
@@ -1509,15 +1506,15 @@ static struct kprobe *__get_valid_kprobe(struct kprobe *p)
 	if (unlikely(!ap))
 		return NULL;
 
-	if (p != ap) {
-		list_for_each_entry(list_p, &ap->list, list)
-			if (list_p == p)
-			/* kprobe p is a valid probe */
-				goto valid;
-		return NULL;
-	}
-valid:
-	return ap;
+	if (p == ap)
+		return ap;
+
+	list_for_each_entry(list_p, &ap->list, list)
+		if (list_p == p)
+		/* kprobe p is a valid probe */
+			return ap;
+
+	return NULL;
 }
 
 /*
-- 
2.51.0


