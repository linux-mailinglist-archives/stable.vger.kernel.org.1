Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5E377BCDA
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 17:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjHNPU1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 11:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjHNPTz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 11:19:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED759DA
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 08:19:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7638C61009
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 15:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFB4C433C8;
        Mon, 14 Aug 2023 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692026090;
        bh=g9SZlKOPWWnC6NmGW13v2jdDr2kwqfhBFZBSUHkDY0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yqFYS0KhAzz7SMTnc/UtpvttJHIfGuVOELqnTQsEoG9RCM2dp7JvRfKCQ8c0s6YDL
         D0AldwN2wDfGolrlr5z8b6L/6b28ti3hkqhHFTNYTHaDUCWvDUhEVBerEO+FrduYel
         /DeD0VOMCl6CDqfvK1Ud5Ea769vYna0kvT+ddQW4=
Date:   Mon, 14 Aug 2023 17:14:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH 6.4 090/206] netfilter: nf_tables: dont skip expired
 elements during walk
Message-ID: <2023081418-goes-vitally-3c6f@gregkh>
References: <20230813211724.969019629@linuxfoundation.org>
 <20230813211727.651202695@linuxfoundation.org>
 <20230813221730.GA22068@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813221730.GA22068@breakpoint.cc>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 14, 2023 at 12:17:30AM +0200, Florian Westphal wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > From: Florian Westphal <fw@strlen.de>
> > 
> > commit 24138933b97b055d486e8064b4a1721702442a9b upstream.
> 
> Just FYI, this change is not correct.
> 
> > There is an asymmetry between commit/abort and preparation phase if the
> > following conditions are met:
> 
> > 1. set is a verdict map ("1.2.3.4 : jump foo")
> > 2. timeouts are enabled
> 
> [..]
> 
> > --- a/net/netfilter/nft_set_pipapo.c
> > +++ b/net/netfilter/nft_set_pipapo.c
> > @@ -566,8 +566,7 @@ next_match:
> >  			goto out;
> >  
> >  		if (last) {
> > -			if (nft_set_elem_expired(&f->mt[b].e->ext) ||
> > -			    (genmask &&
> > +			if ((genmask &&
> >  			     !nft_set_elem_active(&f->mt[b].e->ext, genmask)))
> >  				goto next_match;
> 
> This part is bonkers, it papers over the real issue and introduces
> another bug while at it (insertions for key K will fail if we have
> a key K that is already expired).
> 
> A patch to resolve it is queued on the mailing list and I'll make sure
> it gets passed to the net tree by this wednesday.
> 
> Sorry for the inconvenience, I hope this doesn't interefere with
> -stable release plans and this is leaves enough time for
> the fix to make it to -stable too.

Is there an upstream fix for this yet?  If so, I can pull it into the
stable tree, or should I drop this one for now and wait for the real
fix?  It's your call.

thanks,

greg k-h
