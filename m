Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6127CB9B3
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 06:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjJQEUi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 00:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbjJQEUe (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 00:20:34 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D728EEB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 21:20:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qsbZG-0005F9-5C; Tue, 17 Oct 2023 06:20:30 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qsbZF-002Eko-F6; Tue, 17 Oct 2023 06:20:29 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qsbZF-00Eqk3-Cj; Tue, 17 Oct 2023 06:20:29 +0200
Date:   Tue, 17 Oct 2023 06:20:29 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Patrick Rohr <prohr@google.com>
Subject: Re: USB_NET_AX8817X dependency on AX88796B_PHY
Message-ID: <20231017042029.GA3539182@pengutronix.de>
References: <CANP3RGdzJ7RYWkMT_zNXbg0FyPcCF4rixABvF0++OR-2gpEtow@mail.gmail.com>
 <CANP3RGe82EQhdKd_sc7kWDm2jqx1jTa-Rnj23xBSVpFvK_-T2Q@mail.gmail.com>
 <20231016082913.GB3502392@pengutronix.de>
 <CANP3RGfp9dNun7-gAarqXo71ay2jeLnqO6eJzmXpNKAmXYeosw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANP3RGfp9dNun7-gAarqXo71ay2jeLnqO6eJzmXpNKAmXYeosw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 16, 2023 at 11:27:07AM -0700, Maciej Żenczykowski wrote:
> On Mon, Oct 16, 2023 at 1:29 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > On Sun, Oct 15, 2023 at 03:13:26PM -0700, Maciej Żenczykowski wrote:
> > > This means even with the option manually enabled, we'd still need to
> > > cherrypick dde25846925765a88df8964080098174495c1f10
> > > "net: usb/phy: asix: add support for ax88772A/C PHYs"
> > > since apparently this is simply new(ish) hardware with built-in x88772C PHY.
> >
> >
> > As far as I see, you are not using clean mainline stable kernel. All changes
> > which make your kernel to need an external PHY driver are _not_ in v5.10.198.
> 
> No, the dmesg was actually from a (probably clean-ish 6.4-ish) debian
> kernel on my laptop,
> where the device enumerates and works in one of the 2 usb-c ports.
> 
> As I mentioned the hardware that actually runs 5.10 is having issues
> even detecting my test device.
> (and while that 5.10 is far from clean mainline, the usb and network
> driver portions are more or less untouched)
> 
> > You will need to cherrypick at least 28 last patches from this stack:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/net/usb/asix_devices.c?h=v6.6-rc6
> >
> > and some from here too:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/net/usb/usbnet.c?h=v6.6-rc6
> 
> I think this basically means the answer is "if you want this to work
> upgrade to a newer kernel".
> Which of course won't make any users happy, but oh well...

It means - what ever problem there is, it is most probably not related
to the asix driver. In kernel v5.10, there are no external dependencies
to other PHY drivers.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
