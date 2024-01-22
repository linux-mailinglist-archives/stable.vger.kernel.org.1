Return-Path: <stable+bounces-12815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B6783761D
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 23:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B0EAB217AE
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 22:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B98F9F4;
	Mon, 22 Jan 2024 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mHAEfL2p"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF45FBE7
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962753; cv=none; b=X+Ulkze8gS0FvxMDeibMD0HBkRoy8ckC9l5mFdUJQfsFXhq1CJmtknC86HKZ7/qdDah3J2Y5i5wI84a7Hn3+pSpZjjuL+iwRf/uotr7vSD/ubc3UC3yeG20Gkqv25za2kuKg2jntHK7ussXO7Yjf0W0jpz439ri9iUcJuGlWDX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962753; c=relaxed/simple;
	bh=NL6UigAOoJwX6ytkQYZpLGZmKPQlk2IR6JlVMyuzZYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDho/a7GvR4V/134beaQ4EyebTjk8hKKpmQ9pPHhSTSqRlkk1N6DxTvjRr3PDBqTXMOvlpIQcsGztAAGyyfhyZmaruv0+y6jsaFt6QrA1CjCLQuZEnKTWZawqIGhje8aUcxnZyXHGzDze+SYBeXwodmqiyzFDPOOkg970X3casA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mHAEfL2p; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QjOCZKW47OzV5Lij2qlzjWDyeeWwes1OTiXq1bllBC8=; b=mHAEfL2p+hNFvVMkWGHvizDB+i
	uHXJQbCGaNjgSwvUQiqH6CMixhy7HircGyvf8hllC5aFF08ZXlu4UP2yS7H292kFJOglV/Hw4xPPj
	pr9UGBb0oezzCuGLXgtLihgn91T83CuOlm31pNEPBC1YzA1OUMKbpInK1bwTOL89BQpGSCRlIhFS1
	YXKDON3PfAqdOEQ6+h+NzPhNBlDSRzZD5K6dkWGnMhok5V3MBkzqkcpz9ey1G68Uf+aquup0EWHpI
	jo/GbArubA8qq23iqJWa/dXqmw34salwELjG8OikOxyEZSBi0tm5UYfr1U4x7P6Y0r9nnzC/fYXy2
	U0+Uwd8A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rS2qD-00000001KPw-2CHo;
	Mon, 22 Jan 2024 22:32:29 +0000
Date: Mon, 22 Jan 2024 22:32:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: gregkh@linuxfoundation.org
Cc: akpm@osdl.org, axboe@kernel.dk, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] block: Remove special-casing of compound
 pages" failed to apply to 5.15-stable tree
Message-ID: <Za7s_bGJsDLe4yyb@casper.infradead.org>
References: <2024012218-elevator-shrug-f68a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012218-elevator-shrug-f68a@gregkh>

On Mon, Jan 22, 2024 at 11:31:18AM -0800, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here it is for 5.15:

diff --git a/block/bio.c b/block/bio.c
index ba9120d4fe49..a0080dc55c95 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1026,7 +1026,7 @@ void bio_release_pages(struct bio *bio, bool mark_dirty)
 		return;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (mark_dirty && !PageCompound(bvec->bv_page))
+		if (mark_dirty)
 			set_page_dirty_lock(bvec->bv_page);
 		put_page(bvec->bv_page);
 	}
@@ -1345,8 +1345,7 @@ void bio_set_pages_dirty(struct bio *bio)
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (!PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
+		set_page_dirty_lock(bvec->bv_page);
 	}
 }
 
@@ -1394,7 +1393,7 @@ void bio_check_pages_dirty(struct bio *bio)
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
+		if (!PageDirty(bvec->bv_page))
 			goto defer;
 	}
 

