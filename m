Return-Path: <stable+bounces-89127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669C09B3CA0
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 22:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266832833C0
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 21:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D841E1A27;
	Mon, 28 Oct 2024 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XC62+How"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB9192585
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730150715; cv=none; b=pF5BKR5hT0mIrrMCb+4WNGUa0dxQCjF+g2hY4aLW6Xri6Mei56qrJPQIwUBO+CFzIy1kLPcuSgx/MElLDjmDJJ5rH+6DCUJfJwMFmDDmn5F8GCKzvjbZq7sz0pfvLBmnPb9UZ47O5/AprNiNFtynms/Utd5IbWr+8nxIuMSZR6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730150715; c=relaxed/simple;
	bh=pLRRnqJAPwskef6FrBxl1E3683EQf+jkK+gJCpfUKQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLmLriMLxt8fUnqXqWjQH9pSp31AZc770YEOf3+t6hmvQR9CMd43nM6nws3JxBqKzxcEu1ekc4U1gUQytb2FFo/soYGnsXPuIajJy8geaUMm/i8cee3bZScwXH6IFWQkl0V5Nozfr67B+4ly9JMYNRnWTk9WC3tgBvp5v9QDPzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XC62+How; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b152a923a3so373710885a.3
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730150711; x=1730755511; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=585mKsRT7d06ESGh3mIJ8b6bPBzsGlMV5JaQkeOeFsk=;
        b=XC62+HowIJktyI/3WW5ZLGPefmhKPm3wy+9PmDYAPVHcFC9mtB59PtecfTUDIfU/s+
         X5UIPHFspbHkTTtmtWHnbv0yw63RljM5HbPR9OMyQj2xonxR2ds9wiCYPaxmJnXZvBww
         c41SFDh0bCV0IdMXHqNjVdpzHCFvgV5yFPtNxkgQ/bBneUMS64yLMsmxDbQmT2ouFsmh
         10w+x1NSXmEdyxCZnXhlF7xL9oHJYVGUXy6WZ1LkrpxvS9aF4OXOk6GJYSDqwcLOpq0o
         o70KA3l6bVvu2Ni/P0WSRTh8zZUtGOf9xSirPUjldRndpKfnIo8ze4zaz0+ZkFJZyf2p
         OQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730150711; x=1730755511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=585mKsRT7d06ESGh3mIJ8b6bPBzsGlMV5JaQkeOeFsk=;
        b=JujCLWNYBRRykm8bwZ8OYjuU1kXgSmLGlNCk6Ka+qY5nmRwDSkGMmvJ+G5QVNbovy+
         GHYwxjzCDQByJge6dXMde6N9jW8HK+3tH/9sp/S/cL+jokK5oXrJtIYKX7Rt4/SCM4OK
         ZyS2GIHHE2IlKl6L37WYNJIw/Wl54rBXC97si7j4P2y2RLhDFCq5bF9A9AennqicoV6B
         HggAY35d1bH2E72VjWwxHqHmRaOoV325pedMORcXk9W38HT6E+mgOxrH4iP9DBDgKTwq
         Dyj1izNuVL2ZS3LDcnv/hmRZWzRrFuzkC3VcOOHisEaVWDgC0bUdFWzw356RHq+PLaD7
         eCKg==
X-Forwarded-Encrypted: i=1; AJvYcCUriqzD8OYsOTnv9Lvfvup/alu7wIFCjVvxi+pqhZroxtxdFUTKM37j9zp6XIjouexUdDNKckc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMEk0pWPPYv+W9paMeQo9xMNIjfitcRMx9nOFVQiZ73AzM0vSc
	d3gOF8WgTIdolbPGll9o07ptFOJMqK+b6oRBGpPB3KpcS4fjVyVlqG2iZk7uz5o=
X-Google-Smtp-Source: AGHT+IFzTlrI74jY4d3DbIaVjhK5zLVVE83AfXgTDT4O8X7A3dLUwf3PsR3yfJKmz8swudu8twoovw==
X-Received: by 2002:a05:620a:29c3:b0:7b1:54f6:d1e0 with SMTP id af79cd13be357-7b193f59b61mr1413923985a.62.1730150711346;
        Mon, 28 Oct 2024 14:25:11 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d3484b6sm356677985a.124.2024.10.28.14.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 14:25:10 -0700 (PDT)
Date: Mon, 28 Oct 2024 17:25:15 -0400
From: Gregory Price <gourry@gourry.net>
To: Yang Shi <shy828301@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
	akpm@linux-foundation.org, ying.huang@intel.com, weixugc@google.com,
	dave.hansen@linux.intel.com, osalvador@suse.de,
	stable@vger.kernel.org
Subject: Re: [PATCH] vmscan,migrate: fix double-decrement on node stats when
 demoting pages
Message-ID: <ZyABO4wOoXs9vC3F@PC2K9PVX.TheFacebook.com>
References: <20241025141724.17927-1-gourry@gourry.net>
 <CAHbLzkqYoHTQz6ifZHuVkWL449EVt9H1v2ukXhS+ExDC2JZMHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkqYoHTQz6ifZHuVkWL449EVt9H1v2ukXhS+ExDC2JZMHA@mail.gmail.com>

On Mon, Oct 28, 2024 at 01:45:48PM -0700, Yang Shi wrote:
> On Fri, Oct 25, 2024 at 7:17 AM Gregory Price <gourry@gourry.net> wrote:
> >
> > When numa balancing is enabled with demotion, vmscan will call
> > migrate_pages when shrinking LRUs.  Successful demotions will
> > cause node vmstat numbers to double-decrement, leading to an
> > imbalanced page count.  The result is dmesg output like such:
> >
> > $ cat /proc/sys/vm/stat_refresh
> >
> > [77383.088417] vmstat_refresh: nr_isolated_anon -103212
> > [77383.088417] vmstat_refresh: nr_isolated_file -899642
> >
> > This negative value may impact compaction and reclaim throttling.
> >
> > The double-decrement occurs in the migrate_pages path:
> >
> > caller to shrink_folio_list decrements the count
> >   shrink_folio_list
> >     demote_folio_list
> >       migrate_pages
> >         migrate_pages_batch
> >           migrate_folio_move
> >             migrate_folio_done
> >               mod_node_page_state(-ve) <- second decrement
> >
> > This path happens for SUCCESSFUL migrations, not failures. Typically
> > callers to migrate_pages are required to handle putback/accounting for
> > failures, but this is already handled in the shrink code.
> 
> AFAIK, MGLRU doesn't dec/inc this counter, so it is not
> double-decrement for MGLRU. Maybe "imbalance update" is better?
> Anyway, it is just a nit. I'd suggest capturing the MGLRU case in the
> commit log too.
>

Gotcha, so yeah saying it's an imbalance fix is more accurate.

So more accurate changelog is:


[PATCH] vmscan,migrate: fix page count imbalance on node stats when demoting pages

When numa balancing is enabled with demotion, vmscan will call
migrate_pages when shrinking LRUs.  migrate_pages will decrement the
the node's isolated page count, leading to an imbalanced count when
invoked from (MG)LRU code.

The result is dmesg output like such:

$ cat /proc/sys/vm/stat_refresh

[77383.088417] vmstat_refresh: nr_isolated_anon -103212
[77383.088417] vmstat_refresh: nr_isolated_file -899642

This negative value may impact compaction and reclaim throttling.

The following path produces the decrement:

shrink_folio_list
  demote_folio_list
    migrate_pages
      migrate_pages_batch
        migrate_folio_move
          migrate_folio_done
            mod_node_page_state(-ve) <- decrement

This path happens for SUCCESSFUL migrations, not failures. Typically
callers to migrate_pages are required to handle putback/accounting for
failures, but this is already handled in the shrink code.

When accounting for migrations, instead do not decrement the count
when the migration reason is MR_DEMOTION. As of v6.11, this demotion
logic is the only source of MR_DEMOTION.


> >
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > Fixes: 26aa2d199d6f2 ("mm/migrate: demote pages during reclaim")
> > Cc: stable@vger.kernel.org
> 
> Thanks for catching this. Reviewed-by: Yang Shi <shy828301@gmail.com>
> 
> > ---
> >  mm/migrate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 923ea80ba744..e3aac274cf16 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1099,7 +1099,7 @@ static void migrate_folio_done(struct folio *src,
> >          * not accounted to NR_ISOLATED_*. They can be recognized
> >          * as __folio_test_movable
> >          */
> > -       if (likely(!__folio_test_movable(src)))
> > +       if (likely(!__folio_test_movable(src)) && reason != MR_DEMOTION)
> >                 mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
> >                                     folio_is_file_lru(src), -folio_nr_pages(src));
> >
> > --
> > 2.43.0
> >

