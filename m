Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A85D719790
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 11:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjFAJrY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 05:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjFAJrX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 05:47:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC1A134
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 02:47:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21E776427F
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 09:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CD3C433EF;
        Thu,  1 Jun 2023 09:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685612840;
        bh=T/eu2t11QsK3l9V2BAVNLAFb3GEpY/+LtYo4dDbfe4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brfZYFkMB6iFBKlZPvQwIsGvMH5qBbXbAiKqjwCtwIqx22E9xg/ro4VDX1ShyfokP
         JEgWMxoEltVaLccoD9Sd2YPHwrAZiZXVi/YmS8qo5zyhlna4/5GxesGSMXsKBix/Ai
         PLBaRT1HWRZXGhiMMRoHFuBsMrJSRgK4xNLwnMzk=
Date:   Thu, 1 Jun 2023 10:47:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     stable@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6.1.y] block: fix bio-cache for passthru IO
Message-ID: <2023060106-untried-jugular-ee6a@gregkh>
References: <2023052844-splatter-emphasize-8de2@gregkh>
 <CGME20230529121959epcas5p1817b7f018f3b60495a8374d58b5fec01@epcas5p1.samsung.com>
 <20230529121630.302280-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529121630.302280-1-joshi.k@samsung.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 29, 2023 at 05:46:30PM +0530, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> commit <8af870aa5b847> ("block: enable bio caching use for passthru IO")
> introduced bio-cache for passthru IO. In case when nr_vecs are greater
> than BIO_INLINE_VECS, bio and bvecs are allocated from mempool (instead
> of percpu cache) and REQ_ALLOC_CACHE is cleared. This causes the side
> effect of not freeing bio/bvecs into mempool on completion.
> 
> This patch lets the passthru IO fallback to allocation using bio_kmalloc
> when nr_vecs are greater than BIO_INLINE_VECS. The corresponding bio
> is freed during call to blk_mq_map_bio_put during completion.
> 
> Cc: stable@vger.kernel.org # 6.1
> fixes <8af870aa5b847> ("block: enable bio caching use for passthru IO")
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Link: https://lore.kernel.org/r/20230523111709.145676-1-anuj20.g@samsung.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> (cherry picked from commit 46930b7cc7727271c9c27aac1fdc97a8645e2d00)
> ---
>  block/blk-map.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Now queued up, thanks.

greg k-h
