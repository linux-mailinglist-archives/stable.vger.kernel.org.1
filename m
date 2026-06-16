Return-Path: <stable+bounces-266563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bNQkGoOmMWpCowUAu9opvQ
	(envelope-from <stable+bounces-266563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:39:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7BE694FDE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:39:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=Nz5ysZFx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266563-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266563-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AEF930500E7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DDD3DFC88;
	Tue, 16 Jun 2026 19:39:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A953CF943;
	Tue, 16 Jun 2026 19:39:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638784; cv=none; b=Ip0VrYDqzavoFb+9VPlp3ER4b7w1iwJFLgin8koQWApaKTTcnpioEOtQvYYX2rDtX/qXhgRcZ5Bw9g9VyjvFIWwgkTryTX6nk3CkevBL1YqpA+fuUtJYq7tpjnAyo0Pof/UMRmHrBBcHu48l2KIIutRRWL8364rGySLfWa+idcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638784; c=relaxed/simple;
	bh=Q2ikB1r2NxRfwBGkiSdGMjOKzSogcZ7DUPodQQOXy1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGvn7Zw0BwBDGdfW5BDJH/mkqKRZivr8DVbU1wNLMqrgNwkXbHeZmNoQr0K3jzPSoG8DAN/IjIzA3FmX4dWRITgXPKL1yiyGgeyIuDgqSx3fVtt7afyX4E4XFPcwwcwV/PGZVykUEwaHrEBQ3gb88MLfHpwkEvv5WsMGtp547aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nz5ysZFx; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=25EV8+cd30BCeMpggJSyntHwUrkjR4MOGFomUCaILko=; b=Nz5ysZFx7oRrJ8mgZA+/6ui/Xw
	P0hAPmCKcZBs3kcp7O8LwIRtRku80y56umzhAP3vJKjDZyF0/cm6mxFu31WWvIIWM9R5Bmuf3xHW3
	YjkIUsXMGTVpPOVbfRMyTjjj46B8V3kjCg547TNn5LhLweXVYWUnjRyf1YJCaRDb+g3P1K78MdYXL
	tS1u3xY4t7SKKFcooshoO5NElFv0TzwBm9MrXLVqu0buXPkZpILXsGf7nDaDUt5xdvbyi30+oU8Bi
	0YpMh/GvW/gBWdXWV4utHK6gxa1mvQv4TWwo6Y2UUzF3p0cTdMoxYffKxTnd17LbhZ95Ah0Zw1wjc
	AhCftxQA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZZdC-0000000GFwq-0yxY;
	Tue, 16 Jun 2026 19:39:30 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH] slab: recognize @GFP parameter as optional in kernel-doc
Date: Tue, 16 Jun 2026 12:39:29 -0700
Message-ID: <20260616193929.2394119-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266563-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rdunlap@infradead.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:rdunlap@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B7BE694FDE

Since the @GFP parameter in kmalloc_obj() etc. is now optional, change
the kernel-doc to indicate that it is optional. This avoids kernel-doc
warnings:

WARNING: include/linux/slab.h:1101 Excess function parameter 'GFP' description in 'kmalloc_obj'
WARNING: include/linux/slab.h:1113 Excess function parameter 'GFP' description in 'kmalloc_objs'
WARNING: include/linux/slab.h:1128 Excess function parameter 'GFP' description in 'kmalloc_flex'

Fixes: e19e1b480ac7 ("add default_gfp() helper macro and use it in the new *alloc_obj() helpers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org

 include/linux/slab.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20260615.orig/include/linux/slab.h
+++ linux-next-20260615/include/linux/slab.h
@@ -1094,7 +1094,7 @@ void *kmalloc_nolock(size_t size, gfp_t
 /**
  * kmalloc_obj - Allocate a single instance of the given type
  * @VAR_OR_TYPE: Variable or type to allocate.
- * @GFP: GFP flags for the allocation.
+ * @...: GFP flags for the allocation.
  *
  * Returns: newly allocated pointer to a @VAR_OR_TYPE on success, or NULL
  * on failure.
@@ -1106,7 +1106,7 @@ void *kmalloc_nolock(size_t size, gfp_t
  * kmalloc_objs - Allocate an array of the given type
  * @VAR_OR_TYPE: Variable or type to allocate an array of.
  * @COUNT: How many elements in the array.
- * @GFP: GFP flags for the allocation.
+ * @...: GFP flags for the allocation.
  *
  * Returns: newly allocated pointer to array of @VAR_OR_TYPE on success,
  * or NULL on failure.
@@ -1119,7 +1119,7 @@ void *kmalloc_nolock(size_t size, gfp_t
  * @VAR_OR_TYPE: Variable or type to allocate (with its flex array).
  * @FAM: The name of the flexible array member of the structure.
  * @COUNT: How many flexible array member elements are desired.
- * @GFP: GFP flags for the allocation.
+ * @...: GFP flags for the allocation.
  *
  * Returns: newly allocated pointer to @VAR_OR_TYPE on success, NULL on
  * failure. If @FAM has been annotated with __counted_by(), the allocation

