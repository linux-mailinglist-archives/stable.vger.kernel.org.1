Return-Path: <stable+bounces-4962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72B78096D9
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 00:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DEB282047
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 23:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFDC57336;
	Thu,  7 Dec 2023 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gqhWqtmp"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2023E1720;
	Thu,  7 Dec 2023 15:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YO6MVl02oBiITEYrEywlC3LVDyTUqOlWipn5vN0fmhA=; b=gqhWqtmpvP9SALAF/Q1zmqoGHm
	HxMwUKrMpAPGfReElYZa/S3TvjzUkkyxt10c7razZ5wU/hSxDRc3RN+qkzI4JtEhv37wXZd9YSbbS
	jmePUN0WrspPoPUXkxLQOf7YyHxFy1OiHeXOzAdUxMBynWUHg342NjmGGP19/c1f9GAzvI+qJMQYw
	n4937Xk5nGkIBOJPaceqsLyaBJkOgp/i2Yeaa/1eCg4UW6P61UajreLPS91lO2endUQfeifDbnTti
	kRHruEUK3J0P+gpL56LlxdthWqnXJR3WCc6ztejMQz4wuBkPMZW5ovM7EQDeY0a9vMaw1w0ZXJUcU
	e9k8dAbg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBOEp-004cCW-JH; Thu, 07 Dec 2023 23:57:03 +0000
Date: Thu, 7 Dec 2023 23:57:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] block: Remove special-casing of compound pages
Message-ID: <ZXJbz2F6xi/ZGnsP@casper.infradead.org>
References: <20230814144100.596749-1-willy@infradead.org>
 <ZXJCxbAm1_V7lPnF@kbusch-mbp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXJCxbAm1_V7lPnF@kbusch-mbp>

On Thu, Dec 07, 2023 at 03:10:13PM -0700, Keith Busch wrote:
> On Mon, Aug 14, 2023 at 03:41:00PM +0100, Matthew Wilcox (Oracle) wrote:
> >  void __bio_release_pages(struct bio *bio, bool mark_dirty)
> >  {
> > -	struct bvec_iter_all iter_all;
> > -	struct bio_vec *bvec;
> > +	struct folio_iter fi;
> > +
> > +	bio_for_each_folio_all(fi, bio) {
> > +		struct page *page;
> > +		size_t done = 0;
> >  
> > -	bio_for_each_segment_all(bvec, bio, iter_all) {
> > -		if (mark_dirty && !PageCompound(bvec->bv_page))
> > -			set_page_dirty_lock(bvec->bv_page);
> > -		bio_release_page(bio, bvec->bv_page);
> > +		if (mark_dirty) {
> > +			folio_lock(fi.folio);
> > +			folio_mark_dirty(fi.folio);
> > +			folio_unlock(fi.folio);
> > +		}
> > +		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
> > +		do {
> > +			bio_release_page(bio, page++);
> > +			done += PAGE_SIZE;
> > +		} while (done < fi.length);
> >  	}
> >  }
> 
> Is it okay to release same-folio pages while creating the bio instead of
> releasing all the pages at the completion? If so, the completion could
> provide just the final bio_release_page() instead looping. I'm more
> confirming if that's an appropriate way to use folios here.

For this patch, I'm just replicating the existing behaviour.  We can
probably do much better.  Honestly, the whole thing is kind of grotesque
and needs to be reformed ... but I think that's part of the physr project.

