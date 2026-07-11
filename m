Return-Path: <stable+bounces-273398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fnzAELpAUmrENgMAu9opvQ
	(envelope-from <stable+bounces-273398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 15:10:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8C97419E8
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 15:10:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=RbbaB3m1;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273398-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273398-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD70C301F4A6
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 13:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BF73C1F24;
	Sat, 11 Jul 2026 13:10:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94B3644A1;
	Sat, 11 Jul 2026 13:10:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775412; cv=none; b=vFscc5Q7pXlniFkErHhuZn45XBcH8VSCnRVTET+uzfOYd5ftODil2UpgWf/9mvj6zcPxJ5P1ehy9NYRDVxtSUC7pcx+8XCgGZVezgKSLBDZxKOSOuhvU4HURKAewahef6kf+nDs8zprlmlFTQzgBkJt5VLfzB40Dl9goGCiSJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775412; c=relaxed/simple;
	bh=T0GD5bivugp2d8VVA9aIzmp/hDHu9TKTk9CZkdcMi6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/+RJuGIR0uAXuyD2kGcBNxD+v/NmH971vvQR2YVJmTx4tMYcGm4MBmmayY54lpNtWPLxfKGaoxdJrP3o34c9KewV3HsJ8j1N+X50u99nqqkKHnafRzPFlcZAqSpnYntJkQi2Ui9rz9xZoTAxXsOePdhSAo51V8zcD0jd0P0ncY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RbbaB3m1; arc=none smtp.client-ip=91.218.175.170
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783775407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jVKKrioraKSDfaDaMgjgygxPfYcIZrSPy52HWbulI0s=;
	b=RbbaB3m1jmWIHpVQU8CXskIyhsYL8TST/LJW5qIUR/c8Q9+GQ5LlnzAjTyvhSfWFsmLPPY
	KNXKhe9V2US9IvqZpHRIix5ggRhzIHLnRrIm6spY+XISGTzmgpgEGiobqS0ANxVu6SXc7m
	4DTqx0JoJ7LLN5NM1Ahh49NGFtPcMgo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	MOKUNO Masakazu <mokuno@sm.sony.co.jp>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Geoff Levand <geoffrey.levand@am.sony.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
Date: Sat, 11 Jul 2026 15:09:32 +0200
Message-ID: <20260711130931.740719-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=thorsten.blum@linux.dev; h=from:subject; bh=T0GD5bivugp2d8VVA9aIzmp/hDHu9TKTk9CZkdcMi6c=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlBDt03bZckXWqR2jHbYLG3lfO5YM07odfPTZ93c/ttl x+vjT3DOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiUTsYGU7srE9y4566cu+/ sJ3uPGFrHc7ODP5SX8z0fdlamTesH2UZGVb5vemyEagxmt6vdMaq0LVq2flgmz+aL7QCg1qZZ5R 9ZgIA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273398-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:geoff@infradead.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:Geert.Uytterhoeven@sonycom.com,m:paulus@ozlabs.org,m:mokuno@sm.sony.co.jp,m:thorsten.blum@linux.dev,m:stable@vger.kernel.org,m:geoffrey.levand@am.sony.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[infradead.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,sonycom.com,ozlabs.org,sm.sony.co.jp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F8C97419E8

If lv1_put_iopte() fails in dma_ioc0_map_pages(), the error path
decrements iopage but keeps using the failed mapping's offset. As a
result, it repeatedly tries to invalidate the failed IOPTE slot and
leaves the already installed IOPTEs valid.

Recompute offset and invalidate the installed IOPTEs instead.

Fixes: 6bb5cf102541 ("[POWERPC] PS3: System-bus rework")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/ps3/mm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index 20fc5b68faee..315a32fd75b1 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -615,6 +615,7 @@ static int dma_ioc0_map_pages(struct ps3_dma_region *r, unsigned long phys_addr,
 
 fail_map:
 	for (iopage--; 0 <= iopage; iopage--) {
+		offset = (1 << r->page_size) * iopage;
 		lv1_put_iopte(0,
 			      c->bus_addr + offset,
 			      c->lpar_addr + offset,

