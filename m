Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BE27E5FA2
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 22:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjKHVHz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 16:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjKHVHz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 16:07:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030B52581
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 13:07:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B347C433C9;
        Wed,  8 Nov 2023 21:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699477672;
        bh=dTEOxxibjJEmUwqygpeT4jqVsxog1jqYQSpnu48nQYQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=04vsPTMiopiMU58KgFzxKVTaW9vDj2J71Kw+jaUes6u1TjIKfVas2MIL6UE/KSPT3
         /s9FCutL/tkdmUddBSm2DYc3nRBuyEHqKD2NDZ6J6ANwW/5j4C8i0HYk5+i3mm/oVh
         PqbhknJO4s9j6ZRyAK1RQ4KhowkvulMLNbfJPv1A=
Date:   Wed, 8 Nov 2023 13:07:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/6] mm: Convert __do_fault() to use a folio
Message-Id: <20231108130751.f515f0f3c5ce5fb5b1d70fb0@linux-foundation.org>
In-Reply-To: <20231108182809.602073-3-willy@infradead.org>
References: <20231108182809.602073-1-willy@infradead.org>
        <20231108182809.602073-3-willy@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed,  8 Nov 2023 18:28:05 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Convert vmf->page to a folio as soon as we're going to use it.  This fixes
> a bug if the fault handler returns a tail page with hardware poison;
> tail pages have an invalid page->index, so we would fail to unmap the
> page from the page tables.  We actually have to unmap the entire folio (or
> mapping_evict_folio() will

Would we merely fail to unmap or is there a possibility of unmapping
some random innocent other page?

How might this bug manifest in userspace, worst case?

> fail), so use unmap_mapping_folio() instead.
> 
> This also saves various calls to compound_head() hidden in lock_page(),
> put_page(), etc.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org

As it's cc:stable I'll pluck this patch out of the rest of the series
and shall stage it for 6.7-rcX, via mm-hotfixes-unstable ->
mm-hotfixes-stable -> Linus.  Unless this bug is a very minor thing?

