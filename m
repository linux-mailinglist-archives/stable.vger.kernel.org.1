Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8913F7E602A
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 22:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjKHVsc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 16:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHVsb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 16:48:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737D8258D
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 13:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b8NLj0A75vECiKuBG76LMuM8DoRoYCbpAFm9PE4OATA=; b=ZZeqBfonCcqvEi+G9NBtIC6djJ
        Uu3cxaTrNvM3/v1/pvq/oDskntrFwuqw2PJ5dckJXj7ZjUmufYegNKROa4tvivONASNgHFbXoI1or
        9+skRzWL713TjsD4t4PIpin7WF93ZpZwRnCBYJIR1M+Vp5J245L/Zc/BMl4388GKC3Oq+k2ZBiYBi
        Ych/mz0n11wF+tB9kfDVqit+jfrcypb0zyRr/VQ3MYpzUU7jL8xKAQmI+88yTpm9dXQmNZ7R+47xQ
        mgpk2QraMQlO38pCypexOvygSbPDWpDT7k0rayjVqgWiZXDU8vvhZswd7XcQ96ggBxzooqk9Gieav
        /l/x5xGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0qPM-003O3N-Al; Wed, 08 Nov 2023 21:48:20 +0000
Date:   Wed, 8 Nov 2023 21:48:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/6] mm: Convert __do_fault() to use a folio
Message-ID: <ZUwCJJy7kqrMPS4M@casper.infradead.org>
References: <20231108182809.602073-1-willy@infradead.org>
 <20231108182809.602073-3-willy@infradead.org>
 <20231108130751.f515f0f3c5ce5fb5b1d70fb0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108130751.f515f0f3c5ce5fb5b1d70fb0@linux-foundation.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 08, 2023 at 01:07:51PM -0800, Andrew Morton wrote:
> On Wed,  8 Nov 2023 18:28:05 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > Convert vmf->page to a folio as soon as we're going to use it.  This fixes
> > a bug if the fault handler returns a tail page with hardware poison;
> > tail pages have an invalid page->index, so we would fail to unmap the
> > page from the page tables.  We actually have to unmap the entire folio (or
> > mapping_evict_folio() will
> 
> Would we merely fail to unmap or is there a possibility of unmapping
> some random innocent other page?
> 
> How might this bug manifest in userspace, worst case?

I think we might unmap a random other page in this file.  But then the
next fault on that page will bring it back in, so it's only going to be
a tiny performance blip.  And we've just found a hwpoisoned page which
is going to cause all kinds of other excitement, so I doubt it'll be
noticed in the grand scheme of things.

> As it's cc:stable I'll pluck this patch out of the rest of the series
> and shall stage it for 6.7-rcX, via mm-hotfixes-unstable ->
> mm-hotfixes-stable -> Linus.  Unless this bug is a very minor thing?

I think it's minor enough that it can wait for 6.8.  Unless anyone
disagrees?
