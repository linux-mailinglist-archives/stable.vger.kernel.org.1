Return-Path: <stable+bounces-211238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL94A/MzcmmadwAAu9opvQ
	(envelope-from <stable+bounces-211238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:28:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8205F67EE3
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F42292403C
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A331A564;
	Thu, 22 Jan 2026 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dC1wa78e"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A83131B803;
	Thu, 22 Jan 2026 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088550; cv=none; b=Bx1GXLNBRl5J09jroDk2O6+xmNyO5mj4I4MMGpeS/iZJ9CdG9MpxG52Dh5q5fLR2Dova6fHHDCCToFVYhW7fdgCTl2y2hiLq0ZVxFgNHAjQxonhBu9HRm+UShT8qsjXSOx7oFwyXsRtGXXFYKXbtqFaNDITsmzBcSsAa4RKukHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088550; c=relaxed/simple;
	bh=m9U6Y+bSWTgs4pYYcQrqD8WdR2YkpRXqY9YeVrThtjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pe6BeFIf7FyFc6gwFBt9ojFuSleVZKfszD/I9nssGdCFpWZ+9HakMDhiRU9tjqjsF1EbKJwycMWzoFgPIGXGf0FyW7eE+MM5uhrUj0wwLjr29SYJ6Y5FELSfD9GQoNADV4kLqZkobiOqSU+5hoqLiMKfnjd2aha86Wj32H0RGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dC1wa78e; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=e+
	6gDoaU6sjJYiXvvo+102yEP3zTOi6BPXPONrmdz8k=; b=dC1wa78esyeMyra8fB
	Ue5iSWNlHlVvxuY3NcWOQse2SSMGWXKuMf6PBV/dz1nnHH2I/C4v74o5OT5qoye7
	M21pKWJm/hmqwHr0UcNJiKjxzX+ocJ4dj9uLykTa1YoKx5Hnu6EcPpzUexqLwxjV
	BNOA1Ag/wMheQnO8B32WwAWEs=
Received: from ubuntu24-z.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnE2TOJXJpoBt0MQ--.31S2;
	Thu, 22 Jan 2026 21:27:46 +0800 (CST)
From: ranxiaokai627@163.com
To: pratyush@kernel.org,
	surenb@google.com,
	akpm@linux-foundation.org
Cc: pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev,
	rppt@kernel.org,
	graf@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	stable@vger.kernel.org
Subject: [PATCH RESEND v3] kho: init alloc tags when restoring pages from reserved memory
Date: Thu, 22 Jan 2026 13:27:40 +0000
Message-ID: <20260122132740.176468-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAnE2TOJXJpoBt0MQ--.31S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWkWr1xuFWrXFyruw4xXrb_yoW8CFWDpr
	WUJr1kt3y5JwnrZws2va4vk34fXws5C3y5Jasru34fZF13Awn2yas7ZFy0vF15Zr4FvF48
	Wr4UXrZ0v3WYk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piFdgJUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxRJ0wGlyJdLrAwAA3n
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211238-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[soleen.com,linux.dev,kernel.org,amazon.com,kvack.org,vger.kernel.org,lists.infradead.org,zte.com.cn,163.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_NONE(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[163.com,none];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FREEMAIL_FROM(0.00)[163.com];
	FROM_NEQ_ENVFROM(0.00)[ranxiaokai627@163.com,stable@vger.kernel.org]
X-Rspamd-Queue-Id: 8205F67EE3
X-Rspamd-Action: no action

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Memblock pages (including reserved memory) should have their allocation
tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
released to the page allocator. When kho restores pages through
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

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---

v2 -> v3: 
 - also call clear_page_tag_ref() for non-compound order-0 tail pages

 kernel/liveupdate/kexec_handover.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index d4482b6e3cae..96767b106cac 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -255,6 +255,14 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
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
-- 
2.25.1



