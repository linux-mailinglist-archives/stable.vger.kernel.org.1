Return-Path: <stable+bounces-274481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u2VJFjhzVmo35wAAu9opvQ
	(envelope-from <stable+bounces-274481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:34:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BADCC7577E7
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:34:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b="e/KfRN7L";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274481-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274481-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EDCE318BCBD
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 17:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B65307AF4;
	Tue, 14 Jul 2026 17:31:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C294C2EB859;
	Tue, 14 Jul 2026 17:31:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050278; cv=none; b=Lw4zLphijZvB/BYgqMKXTCvNeWcK1Ymap/Ai91vCL+OikTgHt44XZoZupVxBmImxryMF1wngKPuC8BkOZqjow/Rrpt7SVBHuKwYd/Gxk9d4vbT6Da9b6cWY5uFppipLADRz5CjL+Jh7F0GZ0KIGGf39e5RClbm+rNtZR0WlbrWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050278; c=relaxed/simple;
	bh=SgYw+tKhY9EOguEzIGhkCJ1OXgB6PqiTM1tC1FsfDtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCPuLi9lzApXvryEteWg7gx8QGEdHDgTV1oqG0IEjGRyDsOBLM9MeOp/9QyBt/nZMPDVOeUubC11PpaJuqJApdnFINNyaDJY14+W2KWnaNTb+6Ivcwp1ner1FooLYymjlh6oUmvA3xr4412XVD518Okj+X39t1bkv/OeTbF/7wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=e/KfRN7L; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784050273;
	bh=rp1APUYx0TOZAKa7fp7hjDCITUt2bKcaX9BfvIPZp+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/KfRN7LhkWTwOocLQqme5QzotOehwhB5QUEvEzBb4Ozy3WGbPp38oRNaaisrWm8V
	 xLcYkuDeEDp4LzIAgyRngy54bEBDskULVCnuOKrG0soRxMmmwoPVSqe7SUx9wb5fZA
	 JpjIuim5eQbtgy1HJiK7z1q11ARzMk37WSPMWczs=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4h05v55Vq2z112q;
	Tue, 14 Jul 2026 17:31:13 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4h05v43m4Hz112c;
	Tue, 14 Jul 2026 17:31:12 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Cc: pmladek@suse.com,
	feng.tang@linux.alibaba.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	include@grrlz.net
Subject: [PATCH v4 2/3] panic: flatten nmi_panic control flow
Date: Tue, 14 Jul 2026 17:31:01 +0000
Message-ID: <20260714173103.11585-3-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714173103.11585-1-include@grrlz.net>
References: <20260714173103.11585-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[grrlz.net:server fail,sea.lore.kernel.org:server fail,vger.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-274481-lists,stable=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:pmladek@suse.com,m:feng.tang@linux.alibaba.com,m:sashiko-bot@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:include@grrlz.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[grrlz.net:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,grrlz.net:from_mime,grrlz.net:mid,grrlz.net:email,grrlz.net:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BADCC7577E7

panic() is __noreturn, so the else after panic_try_start() is dead.
Drop it so the force_cpu path can be added cleanly on top.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/panic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 4b1de407a73a..c58c72d9f5a0 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -521,7 +521,8 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 {
 	if (panic_try_start())
 		panic("%s", msg);
-	else if (panic_on_other_cpu())
+
+	if (panic_on_other_cpu())
 		nmi_panic_self_stop(regs);
 }
 EXPORT_SYMBOL(nmi_panic);
-- 
2.53.0


