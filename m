Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACC97DA627
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 11:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjJ1JXe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 28 Oct 2023 05:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjJ1JXd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 28 Oct 2023 05:23:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BBAC6
        for <stable@vger.kernel.org>; Sat, 28 Oct 2023 02:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=W/g9f7l6jIflfVTO6azM776jOoL43h29jYipA4JfLSQ=; b=dO9JxZYpYH4BpOkhUAK66Nr8Ry
        4JVEXtJAbmqTrioNKBRZIZgJYpfbgdrWm3K+Gnw7nnQyUcvQ3unkJYiLw5FY7HxXYHxkN4bN1IV21
        Y/xqGBrSXx0EON+zFR2qTiIpZOwOqzF5Cfr3xCBHB0NIbkA2xv6/H5JTSjGifCTVGrsQvbTca5oet
        gaMB7nDizXDxKncMTbzBsG0g+31Yc4Tw0swA5teDXHZvR39DEn2UxhX8i670tPhZ9/U0ttEQ8eJ5V
        pjH8XpTxQ6l7mRIlLbbV7W4foiv+BdA0do3kqfswBAR7hqXQ2wiD3WpPWAWXe1O98meRLYnlWGvhK
        NtJ5zSbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qwfXJ-008dUX-ME; Sat, 28 Oct 2023 09:23:17 +0000
Date:   Sat, 28 Oct 2023 10:23:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Mike Snitzer <snitzer@kernel.org>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        dm-devel@lists.linux.dev, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
Message-ID: <ZTzTBUdaX1h8ivZZ@casper.infradead.org>
References: <ZTNH0qtmint/zLJZ@mail-itl>
 <e427823c-e869-86a2-3549-61b3fdf29537@redhat.com>
 <ZTiHQDY54E7WAld+@mail-itl>
 <ZTiJ3CO8w0jauOzW@mail-itl>
 <a413efbf-7194-95ff-562b-f2eb766ca5c1@redhat.com>
 <34f6678e-6460-f77-73f4-fc8d3652a8e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34f6678e-6460-f77-73f4-fc8d3652a8e5@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 27, 2023 at 07:32:54PM +0200, Mikulas Patocka wrote:
> So, we got no reponse from the MM maintainers. Marek - please try this 

yes, how dare i go on holiday.  i'll look at this when i'm back.
probably.

> patch on all the machines where you hit the bug and if you still hit the 
> bug with this patch, report it.
> 
> Mikulas
> 
> 
> 
> From: Mikulas Patocka <mpatocka@redhat.com>
> Subject: [PATCH] dm-crypt: don't allocate large compound pages
> 
> It was reported that the patch 5054e778fcd9cd29ddaa8109077cd235527e4f94
> ("dm crypt: allocate compound pages if possible") causes intermittent
> freezes [1].
> 
> So far, it is not clear what is the root cause. It was reported that with
> the allocation order 3 or lower it works [1], so we restrict the order to
> 3 (that is PAGE_ALLOC_COSTLY_ORDER).
> 
> [1] https://www.spinics.net/lists/dm-devel/msg56048.html
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Cc: stable@vger.kernel.org	# v6.5+
> Fixes: 5054e778fcd9 ("dm crypt: allocate compound pages if possible")
> 
> ---
>  drivers/md/dm-crypt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/md/dm-crypt.c
> ===================================================================
> --- linux-2.6.orig/drivers/md/dm-crypt.c
> +++ linux-2.6/drivers/md/dm-crypt.c
> @@ -1679,7 +1679,7 @@ static struct bio *crypt_alloc_buffer(st
>  	unsigned int nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	gfp_t gfp_mask = GFP_NOWAIT | __GFP_HIGHMEM;
>  	unsigned int remaining_size;
> -	unsigned int order = MAX_ORDER - 1;
> +	unsigned int order = PAGE_ALLOC_COSTLY_ORDER;
>  
>  retry:
>  	if (unlikely(gfp_mask & __GFP_DIRECT_RECLAIM))

