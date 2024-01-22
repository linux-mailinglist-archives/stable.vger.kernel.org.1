Return-Path: <stable+bounces-12814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58577837613
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 23:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6501F24C2C
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 22:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D82487A7;
	Mon, 22 Jan 2024 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="glGsQ7LP"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A2F48791
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962415; cv=none; b=m58MiZKH/SmOIJPBnWRyCQiWlP8h/MNjyl9cthAzQaS3oUJCGWjUlKe7J2fsHIcnQhcFCo/z8tvxSSlD5XyY6Oq1knggUg0dyTQexGuNzPf2EtEH/g5SnXx6kano9m6dqENpysJfbMPHWC/Qda90p9ZbudsNFelNQzPig2YB3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962415; c=relaxed/simple;
	bh=K9DlWIzX07ncSL4GurciUJMKL4/iDZRR1r6lnXMQfvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9mSRS7APYUh4oX+r3MbbiaXgHGV53YpmdHQlkvq/5Sa4PiKOqrAsvTLxthX0BLdAQqVSBF3pcWs0VgRKa4Gm6ZFUlM84J7xVtmxCcknAir1v02M06yheTEacsrhYNiVjst9/Mfwjbh0MQTh7xO/oX9n4q6YKGzN80mLsXXnrh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=glGsQ7LP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fjX7+rymcA8BfFCxlbslzCs2DnJVNLgs8MJ9RoM/tAc=; b=glGsQ7LPjZnBXJOHJa0L5sQ2Ix
	D0BBRE3p3EqGfdppJXgdCHu2v/2pl85WqfQIJKdIRphty6Ybq8JT+omI9PjTbXURm9Hk/3cPT5yRh
	AI7G+RBJXPgpjQrnmQnaKCyJjlRsfGihLnh8dpdgoIH+qZu6uI/1cJmoTIje8WUDOCS+XRBPaJmRK
	it0zO0do8HIOvrfwtd+Jy8OIJEM0A77WwNeRxZDdffwUSJIFIN/B7cMZ9Fl1MnBZgWEIQ8Udq15of
	1FFk0WDNCCgyJ4pVTCdW/bSnt3NNsVFd3/L8UQN6vSKHlU9oVKjUFB3S+COix1/iVPFeSunCdXVd4
	ImWgMegA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rS2kk-00000001JQ0-0Prq;
	Mon, 22 Jan 2024 22:26:50 +0000
Date: Mon, 22 Jan 2024 22:26:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: gregkh@linuxfoundation.org
Cc: akpm@osdl.org, axboe@kernel.dk, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] block: Remove special-casing of compound
 pages" failed to apply to 6.1-stable tree
Message-ID: <Za7rqt0I5VaLT6FU@casper.infradead.org>
References: <2024012215-drainable-immortal-a01a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012215-drainable-immortal-a01a@gregkh>

On Mon, Jan 22, 2024 at 11:31:15AM -0800, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Thanks.  Here's the fix (compile tested only)

diff --git a/block/bio.c b/block/bio.c
index 9ec72a78f114..6c22dd7b6f27 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1109,13 +1109,22 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
 
 void __bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-	struct bvec_iter_all iter_all;
-	struct bio_vec *bvec;
+	struct folio_iter fi;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (mark_dirty && !PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+	bio_for_each_folio_all(fi, bio) {
+		struct page *page;
+		size_t done = 0;
+
+		if (mark_dirty) {
+			folio_lock(fi.folio);
+			folio_mark_dirty(fi.folio);
+			folio_unlock(fi.folio);
+		}
+		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
+		do {
+			folio_put(fi.folio);
+			done += PAGE_SIZE;
+		} while (done < fi.length);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1414,12 +1423,12 @@ EXPORT_SYMBOL(bio_free_pages);
  */
 void bio_set_pages_dirty(struct bio *bio)
 {
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (!PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
+	bio_for_each_folio_all(fi, bio) {
+		folio_lock(fi.folio);
+		folio_mark_dirty(fi.folio);
+		folio_unlock(fi.folio);
 	}
 }
 
@@ -1462,12 +1471,11 @@ static void bio_dirty_fn(struct work_struct *work)
 
 void bio_check_pages_dirty(struct bio *bio)
 {
-	struct bio_vec *bvec;
+	struct folio_iter fi;
 	unsigned long flags;
-	struct bvec_iter_all iter_all;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
+	bio_for_each_folio_all(fi, bio) {
+		if (!folio_test_dirty(fi.folio))
 			goto defer;
 	}
 

