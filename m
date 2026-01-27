Return-Path: <stable+bounces-211714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI9lAbEpeGl7oQEAu9opvQ
	(envelope-from <stable+bounces-211714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 03:57:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDBE8F475
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 03:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1B083008D4F
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 02:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF7C2E541E;
	Tue, 27 Jan 2026 02:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yg4iR/nc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1127FB2E;
	Tue, 27 Jan 2026 02:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769482668; cv=none; b=Q90SLnaaeHOP+RJuOyZnXB5wcKZtujdRtGxT565xjR0CIQWNtfjBtpFqPESGht1tadzITIb8ZKMrqMpTio5jxSkqFYURAUNQE5U+gGqMRCEiGG8hniC0lp+gDWDDBq2CkhC6WQaQagDYZ2NezcyWRwFnkyn9lzojTkg4WTXkCFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769482668; c=relaxed/simple;
	bh=L270rayzRkStnXktKzReZ0G0WLHOD9I3U0htQb8tvUE=;
	h=Date:To:From:Subject:Message-Id; b=dpucJijkP76wGV2oGVmXCALf8jgYxkaKjKzBmQ1zpoqOstdAfxiSCq0rUVGEA5oHaLsLxA6/I5p22oV25p+AiBQxcfFWV1eO/Y1OA6ejv9xCkji6JFf7MNqSgAZ3tMQCMIrOGGtb9fKg1C3dyA6mv948wkI7CCmExQYz6mpKkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yg4iR/nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066E7C116C6;
	Tue, 27 Jan 2026 02:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769482668;
	bh=L270rayzRkStnXktKzReZ0G0WLHOD9I3U0htQb8tvUE=;
	h=Date:To:From:Subject:From;
	b=yg4iR/ncP1+Sv6m6hTQLZk6lrV5OnDnD4ZfsA6wO69XLIQka4u+ryQtTzE+WXTc8w
	 zxOlojsOc3glOslixWeBLdNbu5itjNJOmgkynQuissT5ASCsB/m3SdC5UCEGB06x5N
	 mSFFy8NtgNXhc1vkdkZU2w0lWZ4U/E+iuplhRTyI=
Date: Mon, 26 Jan 2026 18:57:47 -0800
To: mm-commits@vger.kernel.org,surenb@google.com,stable@vger.kernel.org,rppt@kernel.org,pratyush@kernel.org,pasha.tatashin@soleen.com,kent.overstreet@linux.dev,graf@amazon.com,ran.xiaokai@zte.com.cn,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] kho-init-alloc-tags-when-restoring-pages-from-reserved-memory.patch removed from -mm tree
Message-Id: <20260127025748.066E7C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TAGGED_FROM(0.00)[bounces-211714-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 8DDBE8F475
X-Rspamd-Action: no action


The quilt patch titled
     Subject: kho: init alloc tags when restoring pages from reserved memory
has been removed from the -mm tree.  Its filename was
     kho-init-alloc-tags-when-restoring-pages-from-reserved-memory.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: kho: init alloc tags when restoring pages from reserved memory
Date: Thu, 22 Jan 2026 13:27:40 +0000

Memblock pages (including reserved memory) should have their allocation
tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
released to the page allocator.  When kho restores pages through
kho_restore_page(), missing this call causes mismatched
allocation/deallocation tracking and below warning message:

alloc_tag was not set
WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CPU#1: swapper/0/1
RIP: 0010:___free_pages+0xb8/0x260
 kho_restore_vmalloc+0x187/0x2e0
 kho_test_init+0x3c4/0xa30
 do_one_initcall+0x62/0x2b0
 kernel_init_freeable+0x25b/0x480
 kernel_init+0x1a/0x1c0
 ret_from_fork+0x2d1/0x360

Add missing clear_page_tag_ref() annotation in kho_restore_page() to
fix this.

Link: https://lkml.kernel.org/r/20260122132740.176468-1-ranxiaokai627@163.com
Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/liveupdate/kexec_handover.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/liveupdate/kexec_handover.c~kho-init-alloc-tags-when-restoring-pages-from-reserved-memory
+++ a/kernel/liveupdate/kexec_handover.c
@@ -255,6 +255,14 @@ static struct page *kho_restore_page(phy
 	if (is_folio && info.order)
 		prep_compound_page(page, info.order);
 
+	/* Always mark headpage's codetag as empty to avoid accounting mismatch */
+	clear_page_tag_ref(page);
+	if (!is_folio) {
+		/* Also do that for the non-compound tail pages */
+		for (unsigned int i = 1; i < nr_pages; i++)
+			clear_page_tag_ref(page + i);
+	}
+
 	adjust_managed_page_count(page, nr_pages);
 	return page;
 }
_

Patches currently in -mm which might be from ran.xiaokai@zte.com.cn are

alloc_tag-fix-rw-permission-issue-when-handling-boot-parameter.patch


