Return-Path: <stable+bounces-68926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C97B79534A7
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE47B202DC
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649EA19FA99;
	Thu, 15 Aug 2024 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k5KLTEqx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB619DFA4;
	Thu, 15 Aug 2024 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732107; cv=none; b=HPOgRXnqX4zCYiwf6sXpFXnNmuJ4eeGHFTLaG/rUBSzMUx4j5bcqdQIopiQNdpXHfjqIlE7dlM2Q8H5RlmwbN20mmkH5KHtlSdnHAUqacBmphP5n5fBJmoZRZrDbKEnFTkERb4105AufH+fylXvUSsDv/dgwgYqBjN3SdgF1cD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732107; c=relaxed/simple;
	bh=M8tRIlPRg48nUX+maOArMcBx+rlmmdrXD8PrXks3tyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGOys9ZLGhz6U9n/QVhN2XBmTtQ1FO1IdGslNDpMh5sgL3j9sM17NgvxUL3vu6hzPSwIoQFR1EBhJwI1Qgsz9aLHrJC+nxiaJwC1m84J8SW3tLzku9CLv4CuiXUp3H1We6My98Nk+xmUzu4mbcrTbMzSSdD9owJKBNbHLY+4dfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k5KLTEqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF88C32786;
	Thu, 15 Aug 2024 14:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732107;
	bh=M8tRIlPRg48nUX+maOArMcBx+rlmmdrXD8PrXks3tyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5KLTEqxwpGN2OZ7oldGA+LcotPNMxeX03cVyDWUbRmyYD8UPcApCj1Wl8sTOW6yy
	 EY7w4Y2WMUAdIoP7K7eJsbHyFSJWZOe3iJaHYfl/D1ufsNSnOPbeYEO2XVB/E0xExi
	 DRgW7hifzY/MzaftAA3mi1ItmdT7W8kGMashM840=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 075/352] s390/mm: Convert gmap_make_secure to use a folio
Date: Thu, 15 Aug 2024 15:22:21 +0200
Message-ID: <20240815131922.141821409@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

[ Upstream commit d35c34bb32f2cc4ec0b52e91ad7a8fcab55d7856 ]

Remove uses of deprecated page APIs, and move the check for large
folios to here to avoid taking the folio lock if the folio is too large.
We could do better here by attempting to split the large folio, but I'll
leave that improvement for someone who can test it.

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20240322161149.2327518-3-willy@infradead.org
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Stable-dep-of: 3f29f6537f54 ("s390/uv: Don't call folio_wait_writeback() without a folio reference")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/uv.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index c99b7f9de1e1f..8c73d4901e145 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -213,13 +213,10 @@ static int expected_folio_refs(struct folio *folio)
 	return res;
 }
 
-static int make_page_secure(struct page *page, struct uv_cb_header *uvcb)
+static int make_folio_secure(struct folio *folio, struct uv_cb_header *uvcb)
 {
-	struct folio *folio = page_folio(page);
 	int expected, cc = 0;
 
-	if (folio_test_large(folio))
-		return -EINVAL;
 	if (folio_test_writeback(folio))
 		return -EAGAIN;
 	expected = expected_folio_refs(folio);
@@ -285,7 +282,7 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 	bool local_drain = false;
 	spinlock_t *ptelock;
 	unsigned long uaddr;
-	struct page *page;
+	struct folio *folio;
 	pte_t *ptep;
 	int rc;
 
@@ -312,15 +309,19 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 	rc = -ENXIO;
 	ptep = get_locked_pte(gmap->mm, uaddr, &ptelock);
 	if (pte_present(*ptep) && !(pte_val(*ptep) & _PAGE_INVALID) && pte_write(*ptep)) {
-		page = pte_page(*ptep);
+		folio = page_folio(pte_page(*ptep));
+		rc = -EINVAL;
+		if (folio_test_large(folio))
+			goto unlock;
 		rc = -EAGAIN;
-		if (trylock_page(page)) {
+		if (folio_trylock(folio)) {
 			if (should_export_before_import(uvcb, gmap->mm))
-				uv_convert_from_secure(page_to_phys(page));
-			rc = make_page_secure(page, uvcb);
-			unlock_page(page);
+				uv_convert_from_secure(PFN_PHYS(folio_pfn(folio)));
+			rc = make_folio_secure(folio, uvcb);
+			folio_unlock(folio);
 		}
 	}
+unlock:
 	pte_unmap_unlock(ptep, ptelock);
 out:
 	mmap_read_unlock(gmap->mm);
@@ -330,10 +331,10 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 		 * If we are here because the UVC returned busy or partial
 		 * completion, this is just a useless check, but it is safe.
 		 */
-		wait_on_page_writeback(page);
+		folio_wait_writeback(folio);
 	} else if (rc == -EBUSY) {
 		/*
-		 * If we have tried a local drain and the page refcount
+		 * If we have tried a local drain and the folio refcount
 		 * still does not match our expected safe value, try with a
 		 * system wide drain. This is needed if the pagevecs holding
 		 * the page are on a different CPU.
@@ -344,7 +345,7 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 			return -EAGAIN;
 		}
 		/*
-		 * We are here if the page refcount does not match the
+		 * We are here if the folio refcount does not match the
 		 * expected safe value. The main culprits are usually
 		 * pagevecs. With lru_add_drain() we drain the pagevecs
 		 * on the local CPU so that hopefully the refcount will
-- 
2.43.0




