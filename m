Return-Path: <stable+bounces-266848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eR/DBhHMMmpz5gUAu9opvQ
	(envelope-from <stable+bounces-266848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 18:32:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C27169B668
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 18:32:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=Io1nRl4G;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266848-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266848-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AC6D300E612
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E66480DC1;
	Wed, 17 Jun 2026 16:31:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F44BC003;
	Wed, 17 Jun 2026 16:31:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713898; cv=none; b=OdL303QE4exoicf4SfuXNEO5Zm+5k1FAYA+cwH/thyONUKuqPK04ZAo1M0Q6wQanDC14qyzSZPeGIWA4QlJvuaioBjvPcgdDmEv3fYy9/xLU8a+3DCt+WDVuz3tJ8cZ5hx21h8bj7qh/P5hnlLsQIcFhnJSeKLs/Lw/Rt5+dXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713898; c=relaxed/simple;
	bh=1+ZGcx5TMr1kWNhSCKBo/Jx/q44j6gy2ujf6YIz4Hok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PY9Ujt2FpvLBbdThKtXrCoVX70Tdc0oqb8BSijR5O7mhCgMgjAAyGjsQw8DzGXupfQPcpOnd73FU/hBPdeMaQg5yKmDK3o5DLHAX1TMY9M3XTbbAenD41kOaSlQ1RTwZ8GCDRr9dKaQT2ZiWLe8+/utaZpDws0szeZOTer85/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Io1nRl4G; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SC2CjG0tyBQTzB68y+c7c4kv0xX9wi+E9xbDTYwfOrw=; b=Io1nRl4GKWGEkviVg4PYxP+8Xh
	LXNMBLy7nu8iHIuLPQ0LAMgxHpfrt+wVsd98vTbzX/pmDOUV2N+52sUGkwfqvB+CVj53WdFjlItO1
	9n8TtThKb3wMCKbsozkalBko4c6zD03emBdp4ifanmq+z72W6NEpH84fwpAbFG9M5+7WYSpo182OH
	maXlypIWcCReEnHkWcNTtIeVVyX70J7zJOJofYI0Fvaf7KUiFV5X10RFgiVkjBhzqVY+hjWAkFlQc
	+uDSrf0cyLAN7+JkVS4bbYu1S0Eg9wyi3v6+xnYKGKF937lvyMYL9sFlPAOX9JQnOd0hpshq0hmFi
	ZWqp7ynQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZtAl-000000003P8-3sVs;
	Wed, 17 Jun 2026 16:31:27 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2] slab: recognize @GFP parameter as optional in kernel-doc
Date: Wed, 17 Jun 2026 09:31:25 -0700
Message-ID: <20260617163125.2716279-1-rdunlap@infradead.org>
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
	TAGGED_FROM(0.00)[bounces-266848-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rdunlap@infradead.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:rdunlap@infradead.org,m:harry@kernel.org,m:vbabka@kernel.org,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:stable@vger.kernel.org,m:kees@kernel.org,m:corbet@lwn.net,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux-foundation.org:email,lwn.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C27169B668

Since the @GFP parameter in kmalloc_obj() etc. is now optional, change
the kernel-doc to indicate that it is optional. This avoids kernel-doc
warnings:

WARNING: include/linux/slab.h:1101 Excess function parameter 'GFP' description in 'kmalloc_obj'
WARNING: include/linux/slab.h:1113 Excess function parameter 'GFP' description in 'kmalloc_objs'
WARNING: include/linux/slab.h:1128 Excess function parameter 'GFP' description in 'kmalloc_flex'

Fixes: e19e1b480ac7 ("add default_gfp() helper macro and use it in the new *alloc_obj() helpers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Harry Yoo (Oracle) <harry@kernel.org>
---
v2: add default value for GFP flags to the description (Harry)

Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>

 include/linux/slab.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20260615.orig/include/linux/slab.h
+++ linux-next-20260615/include/linux/slab.h
@@ -1094,7 +1094,7 @@ void *kmalloc_nolock(size_t size, gfp_t
 /**
  * kmalloc_obj - Allocate a single instance of the given type
  * @VAR_OR_TYPE: Variable or type to allocate.
- * @GFP: GFP flags for the allocation.
+ * @...: optional GFP flags for the allocation (GFP_KERNEL when not specified).
  *
  * Returns: newly allocated pointer to a @VAR_OR_TYPE on success, or NULL
  * on failure.
@@ -1106,7 +1106,7 @@ void *kmalloc_nolock(size_t size, gfp_t
  * kmalloc_objs - Allocate an array of the given type
  * @VAR_OR_TYPE: Variable or type to allocate an array of.
  * @COUNT: How many elements in the array.
- * @GFP: GFP flags for the allocation.
+ * @...: optional GFP flags for the allocation (GFP_KERNEL when not specified).
  *
  * Returns: newly allocated pointer to array of @VAR_OR_TYPE on success,
  * or NULL on failure.
@@ -1119,7 +1119,7 @@ void *kmalloc_nolock(size_t size, gfp_t
  * @VAR_OR_TYPE: Variable or type to allocate (with its flex array).
  * @FAM: The name of the flexible array member of the structure.
  * @COUNT: How many flexible array member elements are desired.
- * @GFP: GFP flags for the allocation.
+ * @...: optional GFP flags for the allocation (GFP_KERNEL when not specified).
  *
  * Returns: newly allocated pointer to @VAR_OR_TYPE on success, NULL on
  * failure. If @FAM has been annotated with __counted_by(), the allocation

