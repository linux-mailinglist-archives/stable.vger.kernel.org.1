Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC44B738DD5
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 19:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjFURzQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 13:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjFURyr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 13:54:47 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C8826A5;
        Wed, 21 Jun 2023 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xoeWVWevdJefHs6dLVlcOT+MfB0qCI9uaO5SHze2lDA=; b=DTYtZ4gRa6NOcoqIRIuKKxeTb2
        p2zPTSWDwEVIeiRg2fhmisqXIPXUAF5H8r4JYlDxvQA7GEkAAJcdlkNMNTDb8HH7qnovOyJuc4uxj
        JydT4uYFVfC+EpNrVSof77CsgXFYD/gdhA0lR6NJWcA9zvLRYeDSaBfULqfq4CbbUlEuRlVvT3H/D
        fm1MPMlWyIeRBjfxv72GC4QtJXNApTAeVv1yDhANF/9wsMIf9lINuUXQIDrGgtaJb3JGFRHzFhja/
        rzvCxjQdT3me7CDnNEYXINg+8ilJWMM5zHoCvGDrgiAcBPpflS613a/6BV1DBVM1F876yU7j8bvRB
        rjgVAdKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38908)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qC20n-00036t-U9; Wed, 21 Jun 2023 18:52:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qC20n-0007x3-0L; Wed, 21 Jun 2023 18:52:57 +0100
Date:   Wed, 21 Jun 2023 18:52:56 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, netdev <netdev@vger.kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>, ansuelsmth@gmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH net] net: phy: Manual remove LEDs to ensure correct
 ordering
Message-ID: <ZJM4+PlE5MhQUvW1@shell.armlinux.org.uk>
References: <20230617155500.4005881-1-andrew@lunn.ch>
 <8a41a15a-b832-3e66-d10a-df29f1a4c880@gmail.com>
 <ZJMtrw6zdi2YP7b5@shell.armlinux.org.uk>
 <cb3d7ae2-a7f8-537b-3b51-3491265b0e65@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb3d7ae2-a7f8-537b-3b51-3491265b0e65@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 21, 2023 at 06:12:40PM +0100, Florian Fainelli wrote:
> Hi Russell,
> 
> On 6/21/2023 6:04 PM, Russell King (Oracle) wrote:
> > On Wed, Jun 21, 2023 at 03:04:14PM +0100, Florian Fainelli wrote:
> > > Hi Andrew,
> > > 
> > > On 6/17/2023 4:55 PM, Andrew Lunn wrote:
> > > > If the core is left to remove the LEDs via devm_, it is performed too
> > > > late, after the PHY driver is removed from the PHY. This results in
> > > > dereferencing a NULL pointer when the LED core tries to turn the LED
> > > > off before destroying the LED.
> > > > 
> > > > Manually unregister the LEDs at a safe point in phy_remove.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: Florian Fainelli <f.fainelli@gmail.com>
> > > > Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
> > > > Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
> > > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > 
> > > Thanks for fixing this, this is an improvement, though I can still hit
> > > another sort of use after free whereby the GENET driver removes the
> > > mdio-bcm-unimac platform device and eventually cuts the clock to the MDIO
> > > block thus causing the following:
> > 
> > Hi Florian,
> > 
> > Can you try setting trigger_data->led_cdev to NULL after the
> > cancel_delayed_work_sync() in netdev_trig_deactivate() and see
> > what the effect is?
> 
> Thanks for the suggestion, getting an identical trace as before with that
> change.

Thanks for trying. I was wondering whether the work was being re-queued
after the flush_work(), but seemingly not.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
