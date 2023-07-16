Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DEA7550E5
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjGPTSe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGPTSe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C24EE4B;
        Sun, 16 Jul 2023 12:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3CD260DD0;
        Sun, 16 Jul 2023 19:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE37C433C8;
        Sun, 16 Jul 2023 19:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689535112;
        bh=DSFIV8zlzSImOGC2wEpAwibiamA9oYkeRfaUYowc7p8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5a7dIydg8iVkD4d9UjmWyDZOZr1oeydiHKBNoopVXollvQYREYsMzNAyLwPv8NEY
         613gdY+bjQs2BnzhfIkkz056ehpI2nHEqr/ZcZyKE0ti/GmowDcOC7BhZdNQ7s15UD
         PE+3EdrbItJi8ogCAKbLT+HVUj3ENhNHYXNKlH4Y=
Date:   Sun, 16 Jul 2023 21:18:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: Re: [PATCH -stable,5.10 v3 01/11] netfilter: nf_tables: use
 net_generic infra for transaction data
Message-ID: <2023071608-pushcart-egotism-c77f@gregkh>
References: <20230713084859.71541-1-pablo@netfilter.org>
 <20230713084859.71541-2-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713084859.71541-2-pablo@netfilter.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jul 13, 2023 at 10:48:49AM +0200, Pablo Neira Ayuso wrote:
> From: Florian Westphal <fw@strlen.de>
> 
> [ Upstream commit 0854db2aaef3fcdd3498a9d299c60adea2aa3dc6 ]
> 
> This moves all nf_tables pernet data from struct net to a net_generic
> extension, with the exception of the gencursor.
> 
> The latter is used in the data path and also outside of the nf_tables
> core. All others are only used from the configuration plane.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  include/net/netfilter/nf_tables.h |  10 +
>  include/net/netns/nftables.h      |   7 -
>  net/netfilter/nf_tables_api.c     | 382 ++++++++++++++++++------------
>  net/netfilter/nf_tables_offload.c |  30 ++-
>  net/netfilter/nft_chain_filter.c  |  11 +-
>  net/netfilter/nft_dynset.c        |   6 +-
>  6 files changed, 279 insertions(+), 167 deletions(-)

This doesn't apply to the 5.10.y tree, what version did you make it
against?

thanks,

greg k-h
