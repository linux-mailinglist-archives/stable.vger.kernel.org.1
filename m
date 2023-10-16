Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6597C9E8F
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 07:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjJPFOW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 01:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPFOV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 01:14:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E065BE7
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 22:14:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qsFvm-0003EG-DT; Mon, 16 Oct 2023 07:14:18 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qsFvl-0020aW-CK; Mon, 16 Oct 2023 07:14:17 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qsFvl-00EgBO-A8; Mon, 16 Oct 2023 07:14:17 +0200
Date:   Mon, 16 Oct 2023 07:14:17 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Patrick Rohr <prohr@google.com>
Subject: Re: USB_NET_AX8817X dependency on AX88796B_PHY
Message-ID: <20231016051417.GD3387557@pengutronix.de>
References: <CANP3RGdzJ7RYWkMT_zNXbg0FyPcCF4rixABvF0++OR-2gpEtow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANP3RGdzJ7RYWkMT_zNXbg0FyPcCF4rixABvF0++OR-2gpEtow@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Maciej,

On Sun, Oct 15, 2023 at 02:55:29PM -0700, Maciej Żenczykowski wrote:
> I've received reports that an ethernet usb dongle doesn't work (google
> internal bug 304028301)...
> 
> Investigation shows that we have 5.10 (GKI) with USB_NET_AX8817X=y and
> AX88796B_PHY not set.
> I *think* this configuration combination makes no sense?
> [note: I'm unsure how many different phy's this driver supports...]

After porting part of this driver to PHYlib and then to PHYlink, the driver is
capable of supporting nearly all drivers/net/phy/*

I did this port for following USB Ethernet adapter which needs different PHY:
https://linux-automation.com/en/products/usb-t1l.html

> Obviously, we could simply turn it on 'manually'... but:
> 
> commit dde25846925765a88df8964080098174495c1f10
> Author: Oleksij Rempel <o.rempel@pengutronix.de>
> Date:   Mon Jun 7 10:27:22 2021 +0200
> 
>     net: usb/phy: asix: add support for ax88772A/C PHYs
> 
>     Add support for build-in x88772A/C PHYs
> 
>     Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>     Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> includes (as a side effect):
> 
> drivers/net/usb/Kconfig
> @@ -164,6 +164,7 @@ config USB_NET_AX8817X
>         depends on USB_USBNET
>         select CRC32
>         select PHYLIB
> +       select AX88796B_PHY
>         default y
> 
> which presumably makes this (particular problem) a non issue on 5.15+
> 
> I'm guessing the above fix (ie. commit dde25846925765a88df8964080098174495c1f10)
> could (should?) simply be backported to older stable kernels?
> 
> I've verified it cherrypicks cleanly and builds (on x86_64 5.10 gki),
> ie.
> $ git checkout android/kernel/common/android13-5.10
> $ git cherry-pick -x dde25846925765a88df8964080098174495c1f10
> $ make ARCH=x86_64 gki_defconfig
> $ egrep -i ax88796b < .config
> CONFIG_AX88796B_PHY=y
> $ make -j50
> ./drivers/net/phy/ax88796b.o gets built

As far as i know, mainline kernel v5.10.198 do not supports ax88772A/C PHYs
within the ax88796b.c driver:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/phy/ax88796b.c?h=v5.10.198

There is no need to backport this patch to other stable kernels, except
they include porting of drivers/net/usb/asix_devices to PHYlink
framework.

> I've sourced a copy of the problematic hardware, but I'm hitting
> problems where on at least two (both my chromebook and 1 of the 2
> usb-c ports on my lenovo laptop) totally different usb
> controllers/ports it doesn't even usb enumerate (ie. nothing in dmesg,
> no show on lsusb), which is making testing difficult (unsure if I just
> got a bad sample)...

I use ax88772 based HW on different systems including on UCB-C ports (for
example on DELL XPS 13 developer edition)

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
