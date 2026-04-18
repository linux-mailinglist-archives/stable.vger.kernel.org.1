Return-Path: <stable+bounces-238561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O5AFS4542lIDgEAu9opvQ
	(envelope-from <stable+bounces-238561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 09:56:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A02420587
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 09:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F2FD300B454
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 07:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D0E37104C;
	Sat, 18 Apr 2026 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mZIqXeP5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04872370D77;
	Sat, 18 Apr 2026 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776498986; cv=none; b=e2DizZLY1PfwptIS5cDD9RpMil5KqixXZDMGQzMl8SawqvgCP2gtPs/7Cz7Phh3VTEbKwzcm84DnLE2Rz4Y40vMBc1jy757UDWr0nVbo3QrgVORYAqDKf9U8e2HQOOkqX13jvZJ4ml0smlV4tsp9q12N7T0OR3SyuOeYDaW+/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776498986; c=relaxed/simple;
	bh=EyxAAX+4BPF5JfO+C2t2JaR1JEpsM7Z4Ko+ym7kjsd0=;
	h=Date:To:From:Subject:Message-Id; b=L338YuSUd0idh1nNs77VTKfes3+oVD7L+0I4M0WeoC5Xo5D1Pa1tzG3bWOjSGOgP4OWrSHeJ7E7oYAHeE7ZnoJ2jDOYVHlFBA9yhyTg3dCb0ZuNdRljrydYX52EOmkEd4+0s/A2e3cMfubJJGqKxVKWSLsYfguAqiizsNn9QgRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mZIqXeP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8848C19424;
	Sat, 18 Apr 2026 07:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776498985;
	bh=EyxAAX+4BPF5JfO+C2t2JaR1JEpsM7Z4Ko+ym7kjsd0=;
	h=Date:To:From:Subject:From;
	b=mZIqXeP5lk5UqIUk32T6wqOo44t9Wpp6Nbh8BD2PQNMT6Hc8gBncjuIg5KcNg/RzW
	 HB+31WvWBaDsreFHd+G0t56TAbwgh+0EEIA+vfVHU/4K79SA3D3LSFS4HdJtX2wfrH
	 Nm4ucBFkWp5nDaf02ruWEOHSxNt1kYuVF/B9ynCg=
Date: Sat, 18 Apr 2026 00:56:20 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,rppt@kernel.org,pratyush@kernel.org,pasha.tatashin@soleen.com,jianghaoran@kylinos.cn,duanchenghao@kylinos.cn,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] mm-memfd_luo-fix-physical-address-conversion-in-put_folios-cleanup.patch removed from -mm tree
Message-Id: <20260418075624.D8848C19424@smtp.kernel.org>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TAGGED_FROM(0.00)[bounces-238561-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,linux-foundation.org:dkim,linux-foundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: E0A02420587
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: mm/memfd_luo: fix physical address conversion in put_folios cleanup
has been removed from the -mm tree.  Its filename was
     mm-memfd_luo-fix-physical-address-conversion-in-put_folios-cleanup.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Chenghao Duan <duanchenghao@kylinos.cn>
Subject: mm/memfd_luo: fix physical address conversion in put_folios cleanup
Date: Thu, 26 Mar 2026 16:47:25 +0800

In memfd_luo_retrieve_folios()'s put_folios cleanup path:

1. kho_restore_folio() expects a phys_addr_t (physical address) but
   receives a raw PFN (pfolio->pfn). This causes kho_restore_page() to
   check the wrong physical address (pfn << PAGE_SHIFT instead of the
   actual physical address).

2. This loop lacks the !pfolio->pfn check that exists in the main
   retrieval loop and memfd_luo_discard_folios(), which could
   incorrectly process sparse file holes where pfn=0.

Fix by converting PFN to physical address with PFN_PHYS() and adding
the !pfolio->pfn check, matching the pattern used elsewhere in this file.

This issue was identified by the AI review.
https://sashiko.dev/#/patchset/20260323110747.193569-1-duanchenghao@kylinos.cn

Link: https://lore.kernel.org/20260326084727.118437-6-duanchenghao@kylinos.cn
Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Cc: Haoran Jiang <jianghaoran@kylinos.cn>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memfd_luo.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/mm/memfd_luo.c~mm-memfd_luo-fix-physical-address-conversion-in-put_folios-cleanup
+++ a/mm/memfd_luo.c
@@ -484,8 +484,13 @@ put_folios:
 	 */
 	for (long j = i + 1; j < nr_folios; j++) {
 		const struct memfd_luo_folio_ser *pfolio = &folios_ser[j];
+		phys_addr_t phys;
 
-		folio = kho_restore_folio(pfolio->pfn);
+		if (!pfolio->pfn)
+			continue;
+
+		phys = PFN_PHYS(pfolio->pfn);
+		folio = kho_restore_folio(phys);
 		if (folio)
 			folio_put(folio);
 	}
_

Patches currently in -mm which might be from duanchenghao@kylinos.cn are



