Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FA47CA0FC
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 09:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjJPHsi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 03:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPHsh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 03:48:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C659BA1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 00:48:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AEEC433C7;
        Mon, 16 Oct 2023 07:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697442515;
        bh=Z1OBth5H0jMWgvzKqmJO0Uq8X3kUdZieUmDZM16Elhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUH9N4Gxypy8gP5gvUw5reYV6hY0V3Zuhq3F7jMuXVEQXYn14hWg7Gfpt/2QmCWwn
         KGFFr0AqUGqx1XL+1UuMVbGE5PFDEriFFSfgZ3j1ldhEt8Fl5Az7e9gMD3CllcyNzi
         pcKm7gvQJQ/rNVWzGjvFjXZiBBxktQHaerTFcQEc=
Date:   Mon, 16 Oct 2023 09:48:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: backport a patch of ravb for v5.10 and v5.4
Message-ID: <2023101647-repossess-humbling-54c3@gregkh>
References: <TYBPR01MB53411662F810BAA815FAF968D8D7A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB53411662F810BAA815FAF968D8D7A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 16, 2023 at 03:04:36AM +0000, Yoshihiro Shimoda wrote:
> Hello Sasha,
> 
> Thank you for backporting the latest ravb patches for stable.
> I found one of patches [1] was queued into v5.10 and v5.4 [2].
> However, another patch [3] was not queued into them. I guess
> that this is because conflict happens.
> 
> The reason for the conflict is that the condition in the following
> line is diffetent:
> ---
> v5.10 or v5.4:
> 	if (priv->chip_id != RCAR_GEN2) {
> 
> mainline:
> 	if (info->multi_irqs) {
> ---
> 
> However, this difference can be ignored when backporting. For your
> reference, I wrote a sample patch at the end of this email. Would
> you backport such a patch to v5.10 and v5.4? I would appreciate it
> if you could let me know if there is an official way to request one.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e6864af61493113558c502b5cd0d754c19b93277
> [2] https://www.spinics.net/lists/stable-commits/msg319990.html
>     https://www.spinics.net/lists/stable-commits/msg320008.html
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3971442870713de527684398416970cf025b4f89
> 
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index a59da6a11976..f218bacec001 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1706,6 +1706,8 @@ static int ravb_close(struct net_device *ndev)
>  			of_phy_deregister_fixed_link(np);
>  	}
>  
> +	cancel_work_sync(&priv->work);
> +
>  	if (priv->chip_id != RCAR_GEN2) {
>  		free_irq(priv->tx_irqs[RAVB_NC], ndev);
>  		free_irq(priv->rx_irqs[RAVB_NC], ndev);
> -- 
> 2.25.1
> 

Can you please just send a working backport for the kernel trees you
wish to see this applied to?  Merging patches like this is not easy and
doesn't usually result in a commit that we know actually works properly.

thanks,

greg k-h
