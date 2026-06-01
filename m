Return-Path: <stable+bounces-259439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKowEb0PHWqRVQkAu9opvQ
	(envelope-from <stable+bounces-259439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 06:51:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B86619818
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 06:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B5473006447
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 04:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F45335066;
	Mon,  1 Jun 2026 04:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UPdE+q6Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C66332EBD;
	Mon,  1 Jun 2026 04:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780289464; cv=none; b=Pg3G8Ny4NbaFBMTmt5v3R135PIqZctv23d+/LEtxIE2vQcQLYQENziBtfNwuUYaI/uBOWf+RLz3X86GWFUdKp3942eOSQ3CkKwCYD4cykJZ91f2VHj7Xu5AHXejzsJZkrYcTXlrQfFd/0bdex8ywyG0ZlBEyQbCkbaOqL7MLqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780289464; c=relaxed/simple;
	bh=jXNiBx4lPtSYSYLsO7RcaI2UiJ+CkWUMtqEoA8pEFBI=;
	h=Date:To:From:Subject:Message-Id; b=c2KRCZmlFNSK8VfGIK8Lp03qTBGOijbl2L2blD7bfODsUKiU7yGSvmvq4JBDoqRJdZY/8ZziJEbIJhm7l89WqB8m7Gik6DhdLmYXCNa3bc/4OY8AwgV+BICr9fUc8zM3ycjn4TsBERbJsBuJyLjhjvVVMb7jMWWblxTXVdwL8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UPdE+q6Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAC81F00893;
	Mon,  1 Jun 2026 04:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780289462;
	bh=DZ2yBPC3J1ooAfNboy1I4rkQ2n8N9FZj1lwjFganxXI=;
	h=Date:To:From:Subject;
	b=UPdE+q6Z1BumFlcblMYj67g9JdKSnMci4/bh5in69l3G/ZENSkhIZG/jHw9BOObwK
	 EjLlWjrE71o++S8o9TkBOHCGJucG2AOaGKRaC2Rz2mDQshLa2dNZFhfmvXZM7wTyO7
	 pZMt17ZevI1kvo7VEvjdX+pDArwXDhShsowVok48=
Date: Sun, 31 May 2026 21:51:02 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,wangkefeng.wang@huawei.com,stable@vger.kernel.org,ryan.roberts@arm.com,npache@redhat.com,ljs@kernel.org,liam@infradead.org,lance.yang@linux.dev,dev.jain@arm.com,david@kernel.org,chenjun102@huawei.com,baolin.wang@linux.alibaba.com,baohua@kernel.org,apopple@nvidia.com,yintirui@huawei.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-huge_memory-update-file-pud-counter-before-folio_put.patch removed from -mm tree
Message-Id: <20260601045102.BBAC81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259439-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C4B86619818
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: mm/huge_memory: update file PUD counter before folio_put()
has been removed from the -mm tree.  Its filename was
     mm-huge_memory-update-file-pud-counter-before-folio_put.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Yin Tirui <yintirui@huawei.com>
Subject: mm/huge_memory: update file PUD counter before folio_put()
Date: Tue, 26 May 2026 18:13:55 +0800

__split_huge_pud_locked() updates the file/shmem RSS counter after
dropping the PUD mapping's folio reference.  If folio_put() drops the last
reference, mm_counter_file() can later read freed folio state via
folio_test_swapbacked().

Move the counter update before folio_put().

Link: https://lore.kernel.org/20260526101355.1984244-1-yintirui@huawei.com
Fixes: dbe54153296d ("mm/huge_memory: add vmf_insert_folio_pud()")
Signed-off-by: Yin Tirui <yintirui@huawei.com>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Acked-by: David Hildenbrand (arm) <david@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chen Jun <chenjun102@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/huge_memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/huge_memory.c~mm-huge_memory-update-file-pud-counter-before-folio_put
+++ a/mm/huge_memory.c
@@ -3015,9 +3015,9 @@ static void __split_huge_pud_locked(stru
 	if (!folio_test_referenced(folio) && pud_young(old_pud))
 		folio_set_referenced(folio);
 	folio_remove_rmap_pud(folio, page, vma);
-	folio_put(folio);
 	add_mm_counter(vma->vm_mm, mm_counter_file(folio),
 		-HPAGE_PUD_NR);
+	folio_put(folio);
 }
 
 void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
_

Patches currently in -mm which might be from yintirui@huawei.com are



