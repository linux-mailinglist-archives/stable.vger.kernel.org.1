Return-Path: <stable+bounces-273082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8MEkKqYlUGpYuQIAu9opvQ
	(envelope-from <stable+bounces-273082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 00:50:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E62073621F
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 00:50:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=CUpBrn30;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273082-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273082-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABCED302BA60
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 22:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878093ACEE2;
	Thu,  9 Jul 2026 22:49:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9F2AEF5;
	Thu,  9 Jul 2026 22:49:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637397; cv=none; b=KaKwa7K0DvGWrrzAiDznhZF3jIJ6GqO8Fg8qth+4PeM29SWH5bO/cGvtPwnIrnr0WVfxswtLkw6nEjtd2QBHIP/RMl+bld8JM81VPbXSsCYnE7uOi9IA9mNGHmN30YVitsJEZCP/EWp0tST34FPpkIdNneNZXwULmlxtrrZZVaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637397; c=relaxed/simple;
	bh=J2ZHywfMWzulZuy2OjWCdxoBkkP/zZ82wfTx4AbpumY=;
	h=Date:To:From:Subject:Message-Id; b=V29x3KwEvaDEsTCmYiTJ4AMQyHQIftCruoukFyBv8XoUyIhT+wmwW9kVvW3zuJGibepDR+DlbW5dGGQCwWBHCJthiDxkHMJI9cMMwJHIPKnqwnfOXi0cYgiIvI8a8TPHUWT1MMmTDrik2h4WisU3k4v7RaqIF1rrW5ZV5h9RU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CUpBrn30; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEA81F00A3A;
	Thu,  9 Jul 2026 22:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783637396;
	bh=cAlVrl6XaLaTpGvh18XYl4py9y1ozHd2thqHEBxpXEo=;
	h=Date:To:From:Subject;
	b=CUpBrn30HDmvibGopaXoCKT9z8sRqpx6/cYjHE5+Vim94SdaWOOdLMYRqZiCef3fI
	 Vwniq97KQSZG6kovxWRIiN9c3XM6WqSJBPQLgwWbfsAHNXU0XlRQ6MJOZ/LBySECrL
	 neZtwkcfSznHkwoUDv7XS2I+K8yE5J5Mgg1yTVZE=
Date: Thu, 09 Jul 2026 15:49:55 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,schwab@linux-m68k.org,geert@linux-m68k.org,david@kernel.org,ankur.a.arora@oracle.com,linux@weissschuh.net,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] m68k-avoid-wunused-but-set-parameter-in-clear_user_page.patch removed from -mm tree
Message-Id: <20260709224955.DDEA81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273082-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:schwab@linux-m68k.org,m:geert@linux-m68k.org,m:david@kernel.org,m:ankur.a.arora@oracle.com,m:linux@weissschuh.net,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,weissschuh.net:email,linux-m68k.org:email,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E62073621F


The quilt patch titled
     Subject: m68k: avoid -Wunused-but-set-parameter in clear_user_page()
has been removed from the -mm tree.  Its filename was
     m68k-avoid-wunused-but-set-parameter-in-clear_user_page.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Thomas Weißschuh <linux@weissschuh.net>
Subject: m68k: avoid -Wunused-but-set-parameter in clear_user_page()
Date: Mon, 25 May 2026 10:33:52 +0200

The loop in clear_user_pages() iterates over all pages and calls
clear_user_page() for each of them.  During the loop "vaddr" is modified. 
However on m68k clear_user() is a macro which does not use "vaddr".  The
compiler sees a variable which is modified but never used and emits a
warning for that:

include/linux/highmem.h: In function 'clear_user_pages':
include/linux/highmem.h:234:63: warning: parameter 'vaddr' set but not used [-Wunused-but-set-parameter=]
    static inline void clear_user_pages(void *addr, unsigned long vaddr,

Other architectures use an inline function for clear_user_page() which
avoids the warning.  This is not possible on m68k, as dlush_dcache_page()
is another macro which is not yet defined where clear_user_page() is
defined.  Including cacheflush_mm.h will trigger recursive and lots of
other issues.

So hide the warning with a cast to (void) instead.

While we are here, do the same for copy_user_page().

Link: https://lore.kernel.org/20260525-m68k-clear_user_page-v2-1-0c8981c6eca1@weissschuh.net
Fixes: 62a9f5a85b98 ("mm: introduce clear_pages() and clear_user_pages()")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/m68k/include/asm/page_mm.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/m68k/include/asm/page_mm.h~m68k-avoid-wunused-but-set-parameter-in-clear_user_page
+++ a/arch/m68k/include/asm/page_mm.h
@@ -55,10 +55,12 @@ static inline void clear_page(void *page
 #define clear_user_page(addr, vaddr, page)	\
 	do {	clear_page(addr);		\
 		flush_dcache_page(page);	\
+		(void)(vaddr);			\
 	} while (0)
 #define copy_user_page(to, from, vaddr, page)	\
 	do {	copy_page(to, from);		\
 		flush_dcache_page(page);	\
+		(void)(vaddr);			\
 	} while (0)
 
 extern unsigned long m68k_memoffset;
_

Patches currently in -mm which might be from linux@weissschuh.net are



