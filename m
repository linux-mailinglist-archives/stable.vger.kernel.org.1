Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6038A789B9D
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 09:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjH0G7z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 02:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjH0G7Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 02:59:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D878D120
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 23:59:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CF7761EA0
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 06:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778ABC433C8;
        Sun, 27 Aug 2023 06:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693119560;
        bh=6bQ18e+z/fnPfsWFMPaQsDGaUI/Hm2JJlPsU5bIuGg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXlHEaOwH6DKksThTFgh+PIFf+sXExVypRmF8qKRifBxprfiLv/R3UXrsBChDaihE
         x2Z28BZ1d/hY13yCmdRZ5iOkfIoxwTLG0lI1/jpkPc67fzRI3IuPFJ4ar7/0xt7pGI
         hXDCjEihzXjHpt/u1xMh8QW8EgkMtlqfaJKBoXV8=
Date:   Sun, 27 Aug 2023 08:59:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Paul Fertser <fercerpav@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 066/135] net/ncsi: change from ndo_set_mac_address
 to dev_set_mac_address
Message-ID: <2023082706-winter-ebony-c94a@gregkh>
References: <20230824170617.074557800@linuxfoundation.org>
 <20230824170620.057993946@linuxfoundation.org>
 <739b18f9dc2ae6cde7b1060ee8071d7687b5d4e3.camel@gmail.com>
 <2023082507-breezy-eastward-da6d@gregkh>
 <e81e0014604bc8cf6f387c67875e43dc9a339815.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e81e0014604bc8cf6f387c67875e43dc9a339815.camel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Aug 25, 2023 at 11:38:02AM +0300, Ivan Mikhaylov wrote:
> On Fri, 2023-08-25 at 09:16 +0200, Greg Kroah-Hartman wrote:
> > On Fri, Aug 25, 2023 at 09:24:46AM +0300, Ivan Mikhaylov wrote:
> > > On Thu, 2023-08-24 at 19:08 +0200, Greg Kroah-Hartman wrote:
> > > > 5.10-stable review patch.  If anyone has any objections, please
> > > > let
> > > > me know.
> > > > 
> > > > ------------------
> > > > 
> > > > From: Ivan Mikhaylov <fr0st61te@gmail.com>
> > > > 
> > > > [ Upstream commit 790071347a0a1a89e618eedcd51c687ea783aeb3 ]
> > > > 
> > > > Change ndo_set_mac_address to dev_set_mac_address because
> > > > dev_set_mac_address provides a way to notify network layer about
> > > > MAC
> > > > change. In other case, services may not aware about MAC change
> > > > and
> > > > keep
> > > > using old one which set from network adapter driver.
> > > > 
> > > > As example, DHCP client from systemd do not update MAC address
> > > > without
> > > > notification from net subsystem which leads to the problem with
> > > > acquiring
> > > > the right address from DHCP server.
> > > > 
> > > > Fixes: cb10c7c0dfd9e ("net/ncsi: Add NCSI Broadcom OEM command")
> > > > Cc: stable@vger.kernel.org # v6.0+ 2f38e84 net/ncsi: make one
> > > > oem_gma
> > > > function for all mfr id
> > > > Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> > > > Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> > > > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > ---
> > > >  net/ncsi/ncsi-rsp.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> > > > index 888ccc2d4e34b..47ffb790ff99f 100644
> > > > --- a/net/ncsi/ncsi-rsp.c
> > > > +++ b/net/ncsi/ncsi-rsp.c
> > > > @@ -616,7 +616,6 @@ static int
> > > > ncsi_rsp_handler_oem_mlx_gma(struct
> > > > ncsi_request *nr)
> > > >  {
> > > >         struct ncsi_dev_priv *ndp = nr->ndp;
> > > >         struct net_device *ndev = ndp->ndev.dev;
> > > > -       const struct net_device_ops *ops = ndev->netdev_ops;
> > > >         struct ncsi_rsp_oem_pkt *rsp;
> > > >         struct sockaddr saddr;
> > > >         int ret = 0;
> > > > @@ -630,7 +629,9 @@ static int
> > > > ncsi_rsp_handler_oem_mlx_gma(struct
> > > > ncsi_request *nr)
> > > >         /* Set the flag for GMA command which should only be
> > > > called
> > > > once */
> > > >         ndp->gma_flag = 1;
> > > >  
> > > > -       ret = ops->ndo_set_mac_address(ndev, &saddr);
> > > > +       rtnl_lock();
> > > > +       ret = dev_set_mac_address(ndev, &saddr, NULL);
> > > > +       rtnl_unlock();
> > > >         if (ret < 0)
> > > >                 netdev_warn(ndev, "NCSI: 'Writing mac address to
> > > > device failed\n");
> > > >  
> > > 
> > > Greg, we had conversation in the past about this particular
> > > patchset
> > > series:
> > > https://www.spinics.net/lists/stable-commits/msg308587.html
> > > 
> > > Just one patch is not enough, I didn't test it either on linux
> > > kernel
> > > version < 6.0 , also I saw the Sasha's commits about the same for
> > > 5.4,
> > > 5.10, 5.15 and answered to him about necessity of two patchsets
> > > instead
> > > of one on 19 aug.
> > 
> > Ah, so I should also include commit 74b449b98dcc ("net/ncsi: make one
> > oem_gma function for all mfr id"), right?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Greg, yes, that's right and I'm not sure if these two patches applies
> well for 5.x stable releases.

It worked for 5.15.y, which is good enough for me :)

thanks,

greg k-h
