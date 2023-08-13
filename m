Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0DD77AE29
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 00:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjHMWRf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 18:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjHMWRe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 18:17:34 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B38D18F
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 15:17:33 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qVJOs-0006Vk-J9; Mon, 14 Aug 2023 00:17:30 +0200
Date:   Mon, 14 Aug 2023 00:17:30 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH 6.4 090/206] netfilter: nf_tables: dont skip expired
 elements during walk
Message-ID: <20230813221730.GA22068@breakpoint.cc>
References: <20230813211724.969019629@linuxfoundation.org>
 <20230813211727.651202695@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813211727.651202695@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> From: Florian Westphal <fw@strlen.de>
> 
> commit 24138933b97b055d486e8064b4a1721702442a9b upstream.

Just FYI, this change is not correct.

> There is an asymmetry between commit/abort and preparation phase if the
> following conditions are met:

> 1. set is a verdict map ("1.2.3.4 : jump foo")
> 2. timeouts are enabled

[..]

> --- a/net/netfilter/nft_set_pipapo.c
> +++ b/net/netfilter/nft_set_pipapo.c
> @@ -566,8 +566,7 @@ next_match:
>  			goto out;
>  
>  		if (last) {
> -			if (nft_set_elem_expired(&f->mt[b].e->ext) ||
> -			    (genmask &&
> +			if ((genmask &&
>  			     !nft_set_elem_active(&f->mt[b].e->ext, genmask)))
>  				goto next_match;

This part is bonkers, it papers over the real issue and introduces
another bug while at it (insertions for key K will fail if we have
a key K that is already expired).

A patch to resolve it is queued on the mailing list and I'll make sure
it gets passed to the net tree by this wednesday.

Sorry for the inconvenience, I hope this doesn't interefere with
-stable release plans and this is leaves enough time for
the fix to make it to -stable too.
