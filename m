Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2C377BDAE
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 18:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjHNQL4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 12:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjHNQL3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 12:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475F9F1
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 09:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA95C60C15
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 16:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFE8C433C8;
        Mon, 14 Aug 2023 16:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692029476;
        bh=lMjlapqeyDzouK7rBxj3XpLytHXl61DbEVPIrXEm/Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRy/tMndOIDvb4+cNw875AafCPE/NdBqhjGP64kJGA93iLmZTGzACbbngw9yz98Ga
         jjTTvsE2XIjX+Wy2vfC7jFJ12H4Z9j9rVnrAgZBuKiUgFXd7Bpibk51AdPBF3zAie0
         epGnvlUonikjtRU2tgCUSJqi1wxrdiIAF5qyums4=
Date:   Mon, 14 Aug 2023 18:11:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, stable@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 6.4 090/206] netfilter: nf_tables: dont skip expired
 elements during walk
Message-ID: <2023081404-quality-shindig-552b@gregkh>
References: <20230813211724.969019629@linuxfoundation.org>
 <20230813211727.651202695@linuxfoundation.org>
 <20230813221730.GA22068@breakpoint.cc>
 <2023081418-goes-vitally-3c6f@gregkh>
 <ZNpLHwZ6VlaJjQD1@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNpLHwZ6VlaJjQD1@calendula>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 14, 2023 at 05:41:19PM +0200, Pablo Neira Ayuso wrote:
> On Mon, Aug 14, 2023 at 05:14:48PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Aug 14, 2023 at 12:17:30AM +0200, Florian Westphal wrote:
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > From: Florian Westphal <fw@strlen.de>
> > > > 
> > > > commit 24138933b97b055d486e8064b4a1721702442a9b upstream.
> > > 
> > > Just FYI, this change is not correct.
> > > 
> > > > There is an asymmetry between commit/abort and preparation phase if the
> > > > following conditions are met:
> > > 
> > > > 1. set is a verdict map ("1.2.3.4 : jump foo")
> > > > 2. timeouts are enabled
> > > 
> > > [..]
> > > 
> > > > --- a/net/netfilter/nft_set_pipapo.c
> > > > +++ b/net/netfilter/nft_set_pipapo.c
> > > > @@ -566,8 +566,7 @@ next_match:
> > > >  			goto out;
> > > >  
> > > >  		if (last) {
> > > > -			if (nft_set_elem_expired(&f->mt[b].e->ext) ||
> > > > -			    (genmask &&
> > > > +			if ((genmask &&
> > > >  			     !nft_set_elem_active(&f->mt[b].e->ext, genmask)))
> > > >  				goto next_match;
> > > 
> > > This part is bonkers, it papers over the real issue and introduces
> > > another bug while at it (insertions for key K will fail if we have
> > > a key K that is already expired).
> > > 
> > > A patch to resolve it is queued on the mailing list and I'll make sure
> > > it gets passed to the net tree by this wednesday.
> > > 
> > > Sorry for the inconvenience, I hope this doesn't interefere with
> > > -stable release plans and this is leaves enough time for
> > > the fix to make it to -stable too.
> > 
> > Is there an upstream fix for this yet?  If so, I can pull it into the
> > stable tree, or should I drop this one for now and wait for the real
> > fix?  It's your call.
> 
> I'd suggest: Drop it for 5.10, 5.15 and 6.1, because these versions
> are still missing the full series.
> 
> Keep it for 6.4 (this already have the full series with fixed) the
> incremental fix that is flying upstream will event amend this patch.
> 
> In summary:
> 
> - drop it for 5.10, 5.15 and 6.1
> - keep it for 6.4

Ok, thanks, now dropped for those trees.

greg k-h
