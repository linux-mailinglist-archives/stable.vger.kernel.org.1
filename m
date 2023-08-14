Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E75A77BD50
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 17:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjHNPlw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 11:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjHNPl3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 11:41:29 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD5710E5
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 08:41:26 -0700 (PDT)
Received: from [78.30.34.192] (port=51654 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qVZh2-003wZp-7B; Mon, 14 Aug 2023 17:41:22 +0200
Date:   Mon, 14 Aug 2023 17:41:19 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Westphal <fw@strlen.de>, stable@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 6.4 090/206] netfilter: nf_tables: dont skip expired
 elements during walk
Message-ID: <ZNpLHwZ6VlaJjQD1@calendula>
References: <20230813211724.969019629@linuxfoundation.org>
 <20230813211727.651202695@linuxfoundation.org>
 <20230813221730.GA22068@breakpoint.cc>
 <2023081418-goes-vitally-3c6f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023081418-goes-vitally-3c6f@gregkh>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 14, 2023 at 05:14:48PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 14, 2023 at 12:17:30AM +0200, Florian Westphal wrote:
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > From: Florian Westphal <fw@strlen.de>
> > > 
> > > commit 24138933b97b055d486e8064b4a1721702442a9b upstream.
> > 
> > Just FYI, this change is not correct.
> > 
> > > There is an asymmetry between commit/abort and preparation phase if the
> > > following conditions are met:
> > 
> > > 1. set is a verdict map ("1.2.3.4 : jump foo")
> > > 2. timeouts are enabled
> > 
> > [..]
> > 
> > > --- a/net/netfilter/nft_set_pipapo.c
> > > +++ b/net/netfilter/nft_set_pipapo.c
> > > @@ -566,8 +566,7 @@ next_match:
> > >  			goto out;
> > >  
> > >  		if (last) {
> > > -			if (nft_set_elem_expired(&f->mt[b].e->ext) ||
> > > -			    (genmask &&
> > > +			if ((genmask &&
> > >  			     !nft_set_elem_active(&f->mt[b].e->ext, genmask)))
> > >  				goto next_match;
> > 
> > This part is bonkers, it papers over the real issue and introduces
> > another bug while at it (insertions for key K will fail if we have
> > a key K that is already expired).
> > 
> > A patch to resolve it is queued on the mailing list and I'll make sure
> > it gets passed to the net tree by this wednesday.
> > 
> > Sorry for the inconvenience, I hope this doesn't interefere with
> > -stable release plans and this is leaves enough time for
> > the fix to make it to -stable too.
> 
> Is there an upstream fix for this yet?  If so, I can pull it into the
> stable tree, or should I drop this one for now and wait for the real
> fix?  It's your call.

I'd suggest: Drop it for 5.10, 5.15 and 6.1, because these versions
are still missing the full series.

Keep it for 6.4 (this already have the full series with fixed) the
incremental fix that is flying upstream will event amend this patch.

In summary:

- drop it for 5.10, 5.15 and 6.1
- keep it for 6.4

Thanks
