Return-Path: <stable+bounces-222965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFGTKxmOp2nliAAAu9opvQ
	(envelope-from <stable+bounces-222965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 02:42:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 280931F994C
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 02:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 614DD3069E75
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 01:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7717930E82E;
	Wed,  4 Mar 2026 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jWo3HOOp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F1030BB91;
	Wed,  4 Mar 2026 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772588561; cv=none; b=HuSdZL8qz1kst3vzqR+/ciYwxBw5iBb9DT8Rj0wBOiB3rco0JfPTeOQn0fCH5NmQDsP3PFlqqLQqUB9Xd7coz0fTsDUvEY2cxmm32fvS1D7B3gamT+iVJSyjPWSvKnQVqgXgB13Q2wenGb2lL73GvsO2kYX/Qy3d15HQozWTo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772588561; c=relaxed/simple;
	bh=BSq8rkjqLX6pc064HPSrz6SRDRmOkPt8UjnspdSlOHo=;
	h=Date:To:From:Subject:Message-Id; b=XfdLdt6072XULIuWrT4V0oXROH0SHtNrBDR8Yyn41SlifJ2rT6HNXZ4MyYBlJcuU9uLGDAfe4iKpQxS5aNYbq9MiccAdgXRGX1wlRyCZ6EVVYtUQTf7HQFS7BnkLYhS6o68GdKs/h6JfOy5OcSRbkDSQgFU9lCPDIoXq+69l1hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jWo3HOOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE038C116C6;
	Wed,  4 Mar 2026 01:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772588560;
	bh=BSq8rkjqLX6pc064HPSrz6SRDRmOkPt8UjnspdSlOHo=;
	h=Date:To:From:Subject:From;
	b=jWo3HOOptExkMsJP8WlIOdMDzNf1AApqqrFLt85mLdyaGvhXjDMjxxcWey8X18QTQ
	 YD8Ahw0v2j3FDEMmTw9mIVIvtsg9SNaJSTbyQRsG4A7WRVt32Umo9q6+eEl36cKTFG
	 tFKOsTcpVMPJcF632JFswkHgdEBZBgkgQ4V3uXAs=
Date: Tue, 03 Mar 2026 17:42:40 -0800
To: mm-commits@vger.kernel.org,ziy@nvidia.com,willy@infradead.org,surenb@google.com,stable@vger.kernel.org,ryan.roberts@arm.com,rppt@kernel.org,npache@redhat.com,liam.howlett@oracle.com,lance.yang@linux.dev,dev.jain@arm.com,david@kernel.org,baolin.wang@linux.alibaba.com,baohua@kernel.org,lorenzo.stoakes@oracle.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [alternative-merged] mm-huge_memory-fix-memory-corruption-on-huge-zero-page-move.patch removed from -mm tree
Message-Id: <20260304014240.CE038C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 280931F994C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222965-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action


The quilt patch titled
     Subject: mm/huge_memory: fix memory corruption on huge zero page move
has been removed from the -mm tree.  Its filename was
     mm-huge_memory-fix-memory-corruption-on-huge-zero-page-move.patch

This patch was dropped because an alternative patch was or shall be merged

------------------------------------------------------
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: mm/huge_memory: fix memory corruption on huge zero page move
Date: Mon, 2 Mar 2026 17:06:19 +0000

In commit eb1521dad8f3 ("userfaultfd: handle zeropage moves by
UFFDIO_MOVE"), handling was added to enable the moving of huge zero pages
in move_pages_huge_pmd().

This achieves this by setting src_folio to NULL, and adding subsequent
checks for src_folio being NULL to determine whether to perform the usual
move operations or to simply establish the huge zero page in the
destination.

As part of this change, when installing the destination huge zero page it
invoked mk_huge_pmd() on src_page, correctly.

However, commit e3981db444a0 ("mm: add folio_mk_pmd()") updated the code
in the huge zero page branch from mk_huge_pmd(src_page, ...) to
folio_mk_pmd(src_folio, ...), where src_folio is guaranteed to be NULL at
this point.

This resulted in an invocation of folio_mk_pmd(NULL, ...) in effect, which
causes an invocation of page_to_pfn(0) and results in the installation of
a corrupted PMD entry and undefined behaviour.

This patch fixes the issue by obtaining the zero folio via
page_folio(src_page) and feeding this into folio_mk_pmd().  This retains
the use of folio_mk_pmd() whilst avoiding the memory corruption.

Additionally, this code path was not updated to reflect the changes
introduced by commit d82d09e48219 ("mm/huge_memory: mark PMD mappings of
the huge zero folio special"), meaning a zero huge folio was installed but
not marked special in this case.

This patch additionally fixes that issue by invoking pmd_mkspecial().

With thanks to Chris Down who exposed this bug by adding an explicit test
for UFFDIO_MOVE in commit f07254dce67d ("selftests/mm: add UFFDIO_MOVE
huge zeropage PMD regression test").

Link: https://lkml.kernel.org/r/20260302170619.867056-1-lorenzo.stoakes@oracle.com
Fixes: e3981db444a0 ("mm: add folio_mk_pmd()")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/huge_memory.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/mm/huge_memory.c~mm-huge_memory-fix-memory-corruption-on-huge-zero-page-move
+++ a/mm/huge_memory.c
@@ -2796,8 +2796,12 @@ int move_pages_huge_pmd(struct mm_struct
 		/* Follow mremap() behavior and treat the entry dirty after the move */
 		_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
 	} else {
+		struct folio *zero_folio = page_folio(src_page);
+
+		VM_WARN_ON_ONCE_FOLIO(!is_huge_zero_folio(zero_folio), zero_folio);
 		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
-		_dst_pmd = folio_mk_pmd(src_folio, dst_vma->vm_page_prot);
+		_dst_pmd = folio_mk_pmd(zero_folio, dst_vma->vm_page_prot);
+		_dst_pmd = pmd_mkspecial(_dst_pmd);
 	}
 	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
 
_

Patches currently in -mm which might be from lorenzo.stoakes@oracle.com are



