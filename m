Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B31704466
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 06:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjEPEtF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 00:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjEPEtD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 00:49:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA5CAC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 21:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0308624A8
        for <stable@vger.kernel.org>; Tue, 16 May 2023 04:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6288C433D2;
        Tue, 16 May 2023 04:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684212541;
        bh=Xbx8PULHORvZXN3UWYw62kYfwMaP2SvXcXvPKP1XE4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0CR+vgtnjfZDqgYsyL3L97FVNU7MrUTbZbW0ce7O/8v82yYM3uf/T7t6OmHbFAuGM
         1xcMBor3ytKymKUQiey9ejqe+n1Jhr1uTD1wj5qHQmXyq91ZIfhTbqVUTLhWeQCjSi
         3t/M4gvYrs7EXjv+BV0k+jozvUXBgl7TbK9BG+tM=
Date:   Tue, 16 May 2023 06:48:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.2 092/242] net: bcmgenet: Remove phy_stop() from
 bcmgenet_netif_stop()
Message-ID: <2023051640-collision-slouchy-30bf@gregkh>
References: <20230515161721.802179972@linuxfoundation.org>
 <20230515161724.671015328@linuxfoundation.org>
 <a7843640-7fc9-379f-8a21-a2e599f742d8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7843640-7fc9-379f-8a21-a2e599f742d8@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 15, 2023 at 08:42:31PM -0700, Florian Fainelli wrote:
> 
> 
> On 5/15/2023 9:26 AM, Greg Kroah-Hartman wrote:
> > From: Florian Fainelli <f.fainelli@gmail.com>
> > 
> > [ Upstream commit 93e0401e0fc0c54b0ac05b687cd135c2ac38187c ]
> > 
> > The call to phy_stop() races with the later call to phy_disconnect(),
> > resulting in concurrent phy_suspend() calls being run from different
> > CPUs. The final call to phy_disconnect() ensures that the PHY is
> > stopped and suspended, too.
> > 
> > Fixes: c96e731c93ff ("net: bcmgenet: connect and disconnect from the PHY state machine")
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Please drop this patch until
> https://lore.kernel.org/lkml/20230515025608.2587012-1-f.fainelli@gmail.com/
> is merged, thanks!

Now dropped from all queues.  Let us know when this fix is merged so we
can queue them both up.

thanks,

greg k-h
