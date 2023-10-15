Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0A97C9C59
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 00:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjJOWNm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 18:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOWNl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 18:13:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3F4C1
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 15:13:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso6023a12.1
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697408018; x=1698012818; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuUc6lu6FyOncDmS7H2xiP3vBaQl3V/EEAb+rzTgTW4=;
        b=vRJ0rAYxEjqNMiNbKlWuWXsr1IbDJ2Q3ihDlZfUUR88cFKJzV+47XxU4MVFo803fb2
         hRM8YPpOZqufBCZluVIxX+azMdc7c5+5KOnudNkddFV2103n3XUwt34XHWK89GKWbFJV
         NvxhDr7+xsS15OXj76kSERr1jtrmcIeLBE9/dieA1m2LJ7THH1hGDYsxskVlbrjpMx7b
         tLMJJTngvVgMBm3okTAxPgAyrmzxBGTCLfB8Hhqh8fQcL5FomZwHgHo9o6nCwXk3o25k
         xBoLSdXfOsUMv7jEn/OoFTALgmEw5TDzODmfLfaSe07Br7jZqS2vHeN9WRHOnzYkgq7W
         GFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697408018; x=1698012818;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuUc6lu6FyOncDmS7H2xiP3vBaQl3V/EEAb+rzTgTW4=;
        b=VcXKDQLCGXw9v/utq9y21+GuMTdlr2wc3eQF0pExmsFDImydwEXAMncN5JhrrSmlLI
         EytIpuD5ymm55tovuNWBzyi1dpGqxjBhd7FzSC0gWnsanRKcdMVJsBVx7OHLmdt2eBp0
         cInpKQIHySfZZPOiMlw2Z+BHI2DwEn7gj2uNAwPphbFjjB9qW21vCaOxTnYAJL3FbKXh
         vcjH1liQCML3SRHCzI07M3qU1/EEu2XeQ5x4DbhFXoiszROg/qPFD1FR4nayQ2xsWJVB
         sT8DAwokzCx1rXumPSyyGDn9JCeVPfMHtg+1rFuo1MEnyY8sS0smAofmrzg04ZeSuhm7
         tK3w==
X-Gm-Message-State: AOJu0YwyN9OWGMR56tj611NBHYVw3Hhf/y4w/4NF4u6gShmXckyhtMRT
        5amBsbNb5klHxeFeozffZ9J3h+H1E/8631HEi7mp0ct672Q0rUnSprqzpw==
X-Google-Smtp-Source: AGHT+IGb9dEiKyDdPxWXfC2dKUjRkAOZsi9aiIMQRL0B0v8Z0kZ59cQIF0PORIG8GW5QBwedKux9+KbbMabRKp0luGI=
X-Received: by 2002:a50:a45d:0:b0:538:7038:6bdf with SMTP id
 v29-20020a50a45d000000b0053870386bdfmr110130edb.1.1697408018288; Sun, 15 Oct
 2023 15:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <CANP3RGdzJ7RYWkMT_zNXbg0FyPcCF4rixABvF0++OR-2gpEtow@mail.gmail.com>
In-Reply-To: <CANP3RGdzJ7RYWkMT_zNXbg0FyPcCF4rixABvF0++OR-2gpEtow@mail.gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Sun, 15 Oct 2023 15:13:26 -0700
Message-ID: <CANP3RGe82EQhdKd_sc7kWDm2jqx1jTa-Rnj23xBSVpFvK_-T2Q@mail.gmail.com>
Subject: Re: USB_NET_AX8817X dependency on AX88796B_PHY
To:     stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Patrick Rohr <prohr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Oct 15, 2023 at 2:55=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
>
> I've received reports that an ethernet usb dongle doesn't work (google
> internal bug 304028301)...
>
> Investigation shows that we have 5.10 (GKI) with USB_NET_AX8817X=3Dy and
> AX88796B_PHY not set.
> I *think* this configuration combination makes no sense?
> [note: I'm unsure how many different phy's this driver supports...]
>
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
> I'm guessing the above fix (ie. commit dde25846925765a88df896408009817449=
5c1f10)
> could (should?) simply be backported to older stable kernels?
>
> I've verified it cherrypicks cleanly and builds (on x86_64 5.10 gki),
> ie.
> $ git checkout android/kernel/common/android13-5.10
> $ git cherry-pick -x dde25846925765a88df8964080098174495c1f10
> $ make ARCH=3Dx86_64 gki_defconfig
> $ egrep -i ax88796b < .config
> CONFIG_AX88796B_PHY=3Dy
> $ make -j50
> ./drivers/net/phy/ax88796b.o gets built
>
> I've sourced a copy of the problematic hardware, but I'm hitting
> problems where on at least two (both my chromebook and 1 of the 2
> usb-c ports on my lenovo laptop) totally different usb
> controllers/ports it doesn't even usb enumerate (ie. nothing in dmesg,
> no show on lsusb), which is making testing difficult (unsure if I just
> got a bad sample)...

And actually looking longer at the logs:

usb 1-5: new high-speed USB device number 9 using xhci_hcd
usb 1-5: New USB device found, idVendor=3D0b95, idProduct=3D772b, bcdDevice=
=3D 0.02
usb 1-5: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
usb 1-5: Product: AX88772C
usb 1-5: Manufacturer: ASIX Elec. Corp.
usb 1-5: SerialNumber: 000002
asix 1-5:1.0 (unnamed net_device) (uninitialized): PHY
[usb-001:009:10] driver [Asix Electronics AX88772C] (irq=3DPOLL)
Asix Electronics AX88772C usb-001:009:10: attached PHY driver
(mii_bus:phy_addr=3Dusb-001:009:10, irq=3DPOLL)
asix 1-5:1.0 eth0: register 'asix' at usb-0000:00:14.0-5, ASIX
AX88772B USB 2.0 Ethernet, 14:ae:85:70:44:29
asix 1-5:1.0 enx14ae85704429: renamed from eth0
asix 1-5:1.0 enx14ae85704429: configuring for phy/internal link mode
usb 1-5: USB disconnect, device number 9
asix 1-5:1.0 enx14ae85704429: unregister 'asix' usb-0000:00:14.0-5,
ASIX AX88772B USB 2.0 Ethernet

It looks like the rest of that patch is needed too, since it is a AX88772C =
phy.

This means even with the option manually enabled, we'd still need to
cherrypick dde25846925765a88df8964080098174495c1f10
"net: usb/phy: asix: add support for ax88772A/C PHYs"
since apparently this is simply new(ish) hardware with built-in x88772C PHY=
.
