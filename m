Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F897268BC
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 20:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjFGSbo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 14:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjFGSbo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 14:31:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A584E95
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 11:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A48D642B5
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 18:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D119C433D2;
        Wed,  7 Jun 2023 18:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686162702;
        bh=yYT5ZwQZx0i1gC6YUT7HEAdlZHXc6t8aR1CEd0rJNjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nfeSgLBl/HNSxh0YWgUgRHYN85HRDgOeO/IoX736dOXokvhRAQhSslC1jNIhIiuNk
         nGWpIMneHqZw7/sKIj67+up66UZsQMeuacWb43QOM7WQ10op/lXIOnaZEwM54PKeH3
         KhOvdmGEvOzVRuDBRsHMI0I9IwmDxONRKnl1BCl4=
Date:   Wed, 7 Jun 2023 20:31:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 6.1] tls: rx: strp: don't use GFP_KERNEL in softirq
 context
Message-ID: <2023060733-uncurious-security-b9e4@gregkh>
References: <20230606044241.877280-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606044241.877280-1-kuba@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 05, 2023 at 09:42:41PM -0700, Jakub Kicinski wrote:
> [ Upstream commit 74836ec828fe17b63f2006fdbf53311d691396bf ]
> 
> When receive buffer is small, or the TCP rx queue looks too
> complicated to bother using it directly - we allocate a new
> skb and copy data into it.
> 
> We already use sk->sk_allocation... but nothing actually
> sets it to GFP_ATOMIC on the ->sk_data_ready() path.
> 
> Users of HW offload are far more likely to experience problems
> due to scheduling while atomic. "Copy mode" is very rarely
> triggered with SW crypto.
> 
> Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
> Tested-by: Shai Amiram <samiram@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  net/tls/tls_sw.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Now queued up, thanks.

greg k-h
