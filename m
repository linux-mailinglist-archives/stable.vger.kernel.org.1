Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3502B7CB10E
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 19:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjJPRHz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 13:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbjJPRHB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 13:07:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C249E1A7
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 10:05:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD43DC433C8;
        Mon, 16 Oct 2023 17:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697475900;
        bh=Nbo5C66EwqPAhp286976g1aXkFDklW9lsOICaAJ3fGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRo5YxKEtEgJoIQBzGFAz0LoR9vL0wxbBoxGCdmRWBmYbeNZbO92laIr3nR9Rz0yO
         G0xwM1jRtnb9lX+i1SWJ8h4J0KUyitNLfVeG1ypwcHww2/qzUvCTMf1WaeLFWWvOd9
         3/pZ3Q4tPJt6Olj2pWfHSeYDW7j/bdVPK6KkhfEw=
Date:   Mon, 16 Oct 2023 19:04:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     stable@vger.kernel.org, Zheng Wang <zyytlz.wz@163.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] ravb: Fix use-after-free issue in ravb_tx_timeout_work()
Message-ID: <2023101645-quicksand-swan-56e9@gregkh>
References: <20231016114104.662483-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016114104.662483-1-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 16, 2023 at 08:41:04PM +0900, Yoshihiro Shimoda wrote:
> [ Upstream commit 3971442870713de527684398416970cf025b4f89 ]
> 
> The ravb_stop() should call cancel_work_sync(). Otherwise,
> ravb_tx_timeout_work() is possible to use the freed priv after
> ravb_remove() was called like below:
> 
> CPU0			CPU1
> 			ravb_tx_timeout()
> ravb_remove()
> unregister_netdev()
> free_netdev(ndev)
> // free priv
> 			ravb_tx_timeout_work()
> 			// use priv
> 
> unregister_netdev() will call .ndo_stop() so that ravb_stop() is
> called. And, after phy_stop() is called, netif_carrier_off()
> is also called. So that .ndo_tx_timeout() will not be called
> after phy_stop().
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Reported-by: Zheng Wang <zyytlz.wz@163.com>
> Closes: https://lore.kernel.org/netdev/20230725030026.1664873-1-zyytlz.wz@163.com/
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Link: https://lore.kernel.org/r/20231005011201.14368-3-yoshihiro.shimoda.uh@renesas.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Cc: <stable@vger.kernel.org> # for 5.10.x and 5.4.x
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

Now queued up, thanks.

greg k-h
