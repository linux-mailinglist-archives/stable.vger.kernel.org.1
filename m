Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0963C7D67DD
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 12:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjJYKIM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 06:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjJYKIM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 06:08:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C343DD
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 03:08:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893AFC433C7;
        Wed, 25 Oct 2023 10:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698228486;
        bh=rQZngrJPodypktqWe65fZUp4NUgFzXhqXBIT3hE1Lx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sZjrRxW/7DDnWCl+6ML4nYPNav6rYPyJZwafUoSn/ZqXdr93aw8cfbT0sh7MYAUJ8
         nKoxlXBzVpq2h3QTNBrqJBgbZNJ3DIw7kICRcnDlfr/jGaio27O+sM0e3UMQWVXrJ6
         3FbkgKh5ScapRsTwyj/2aMuc1Gfb+X4bBducAwes=
Date:   Wed, 25 Oct 2023 12:08:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Tony Lu <tonylu@linux.alibaba.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.5 159/241] net/smc: support smc release version
 negotiation in clc handshake
Message-ID: <2023102521-undated-edition-d501@gregkh>
References: <20231023104833.832874523@linuxfoundation.org>
 <20231023104837.750719920@linuxfoundation.org>
 <80669f40-3bc5-440e-9440-e153d12e37ef@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80669f40-3bc5-440e-9440-e153d12e37ef@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 23, 2023 at 08:05:01PM +0800, Guangguan Wang wrote:
> Hi, Greg.
> 
> [PATCH 6.5 159/241] net/smc: support smc release version negotiation in clc handshake
> [PATCH 6.5 160/241] net/smc: support smc v2.x features validate
> 
> The above two patches should not backport to stable tree 6.5, which may result in unexpected
> fallback if communication between 6.6 and 6.5(with these two patch) via SMC-R v2.1. The above
> two patches should not exist individually without the patch 7f0620b9(net/smc: support max
> connections per lgr negotiation) and the patch 69b888e3(net/smc: support max links per lgr 
> negotiation in clc handshake).
> 
> The patch c68681ae46ea ("net/smc: fix smc clc failed issue when netdevice not in init_net")
> does not rely the feature SMC-R v2.1. But I think it may have conflict here when backport
> to stable tree 6.5:
> 
> @@ -1201,6 +1201,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>  		(struct smc_clc_msg_accept_confirm_v2 *)aclc;
>  	struct smc_clc_first_contact_ext *fce =
>  		smc_get_clc_first_contact_ext(clc_v2, false);    --conflict here
> +	struct net *net = sock_net(&smc->sk);
> 
> 
> I think it is better to resolve the confilict rather than backport more patches.
> The resolution of the conflict should be like:
> 
> @@ -1201,6 +1201,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>  		(struct smc_clc_msg_accept_confirm_v2 *)aclc;
>   	struct smc_clc_first_contact_ext *fce =
> 		(struct smc_clc_first_contact_ext *)
> 			(((u8 *)clc_v2) + sizeof(*clc_v2));      --replace the line smc_get_clc_first_contact_ext(clc_v2, false);
> +	struct net *net = sock_net(&smc->sk);

Thanks for letting me know.

I've dropped this patch entirely from the 6.5.y queue now (and the
follow-on ones.)  Can you send a backported, and tested, set of patches
to us for inclusion if you want this fixed up in the 6.5.y tree?  That
way we make sure to get this done properly.

thanks,

greg k-h
