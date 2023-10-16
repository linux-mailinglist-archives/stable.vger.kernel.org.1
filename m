Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC817CB282
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 20:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjJPS12 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 14:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJPS11 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 14:27:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B7CA2
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 11:27:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso1953a12.0
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 11:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697480844; x=1698085644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qulR/Z8nZoDBfF100MsAT8KtqElz8FwQDRgPBpIWwG8=;
        b=pYo+hN02teKaMm+yP+utUwh69x5J65YAbJngegR2Zm1y+UOJBiDjlNqJaLHvb1hihm
         RSm+GV1ZO2kWjskZyTPyGUU8jmT+6bFodZG49cyUWeX9I+oqIxNRbNuo6Z2ggJNLACtq
         Fa/QabqwixjBxu2pBk1T+QVbm/+9vzu27qBpmrqh1CEPsVr6y8jS2hmK5b2VUtcd8PE8
         MgLYbKLy5ApHucWXBprOTNlnkF4EuYuUMtcWRdTcI0MjoZxdT9ljhcUugb4JOo/YlRXD
         rBhjW9gQJIRvEAwvlAiigY424mQVH/NXrVtSMv927M+TJe2E/fJzZszK227QcaL0vion
         EUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480844; x=1698085644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qulR/Z8nZoDBfF100MsAT8KtqElz8FwQDRgPBpIWwG8=;
        b=AplDE3TyCedl0q6146kWBEWVx7pW8Y4BetJ8gxKapW8dXbNgoqrsrbzT+H8x4ffkF4
         AZ0W2OLkrT33wSxNk4xOlChBclvy0VI8J5X8wzBNPaOckjfVvtvK5JxnklyXfs3Exf9J
         ByCYOlN1WVwzu/pgUfW8R5/CQAHEFpBwZQliWssfako+LT9QdAR/ei3IjGzpSrPynlBk
         A4Dc49oEp9CBuG4qw51ZXsyaaYQpq/+1qlH0IPWbwbjyjCZMEfqL5GF8ThghrsA6Unlr
         vJUJzLfJxOjVVbXT8diegtBI4U6ZfJ4Gvde/OWsB0rhUaBswyOPpmrCi+RLXSBWosa3x
         p5NQ==
X-Gm-Message-State: AOJu0Yzipof5Qt5CcLsQKyPbHycoItx+NSIN2AR74Jc0SAtufGjR9Hxa
        vorrBgDEZoDZuEdwsx/ZcJuOPJXW6dvMQT071ih0fA==
X-Google-Smtp-Source: AGHT+IFF6Jd4LXF0biDoNTh84q2Tu/DPGd8Icez7lSHrIQPiQOPTNXTw4ax67Ujll0gCRKjWhNbmpHa6FNiXz5pxzFA=
X-Received: by 2002:a50:f614:0:b0:519:7d2:e256 with SMTP id
 c20-20020a50f614000000b0051907d2e256mr14807edn.0.1697480844121; Mon, 16 Oct
 2023 11:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <CANP3RGdzJ7RYWkMT_zNXbg0FyPcCF4rixABvF0++OR-2gpEtow@mail.gmail.com>
 <CANP3RGe82EQhdKd_sc7kWDm2jqx1jTa-Rnj23xBSVpFvK_-T2Q@mail.gmail.com> <20231016082913.GB3502392@pengutronix.de>
In-Reply-To: <20231016082913.GB3502392@pengutronix.de>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Mon, 16 Oct 2023 11:27:07 -0700
Message-ID: <CANP3RGfp9dNun7-gAarqXo71ay2jeLnqO6eJzmXpNKAmXYeosw@mail.gmail.com>
Subject: Re: USB_NET_AX8817X dependency on AX88796B_PHY
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     stable@vger.kernel.org,
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

On Mon, Oct 16, 2023 at 1:29=E2=80=AFAM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:
> On Sun, Oct 15, 2023 at 03:13:26PM -0700, Maciej =C5=BBenczykowski wrote:
> > On Sun, Oct 15, 2023 at 2:55=E2=80=AFPM Maciej =C5=BBenczykowski <maze@=
google.com> wrote:
> > And actually looking longer at the logs:
> >
> > usb 1-5: new high-speed USB device number 9 using xhci_hcd
> > usb 1-5: New USB device found, idVendor=3D0b95, idProduct=3D772b, bcdDe=
vice=3D 0.02
> > usb 1-5: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
> > usb 1-5: Product: AX88772C
> > usb 1-5: Manufacturer: ASIX Elec. Corp.
> > usb 1-5: SerialNumber: 000002
> > asix 1-5:1.0 (unnamed net_device) (uninitialized): PHY
> > [usb-001:009:10] driver [Asix Electronics AX88772C] (irq=3DPOLL)
> > Asix Electronics AX88772C usb-001:009:10: attached PHY driver
> > (mii_bus:phy_addr=3Dusb-001:009:10, irq=3DPOLL)
> > asix 1-5:1.0 eth0: register 'asix' at usb-0000:00:14.0-5, ASIX
> > AX88772B USB 2.0 Ethernet, 14:ae:85:70:44:29
> > asix 1-5:1.0 enx14ae85704429: renamed from eth0
> > asix 1-5:1.0 enx14ae85704429: configuring for phy/internal link mode
> > usb 1-5: USB disconnect, device number 9
> > asix 1-5:1.0 enx14ae85704429: unregister 'asix' usb-0000:00:14.0-5,
> > ASIX AX88772B USB 2.0 Ethernet
> >
> > It looks like the rest of that patch is needed too, since it is a AX887=
72C phy.
> >
> > This means even with the option manually enabled, we'd still need to
> > cherrypick dde25846925765a88df8964080098174495c1f10
> > "net: usb/phy: asix: add support for ax88772A/C PHYs"
> > since apparently this is simply new(ish) hardware with built-in x88772C=
 PHY.
>
>
> As far as I see, you are not using clean mainline stable kernel. All chan=
ges
> which make your kernel to need an external PHY driver are _not_ in v5.10.=
198.

No, the dmesg was actually from a (probably clean-ish 6.4-ish) debian
kernel on my laptop,
where the device enumerates and works in one of the 2 usb-c ports.

As I mentioned the hardware that actually runs 5.10 is having issues
even detecting my test device.
(and while that 5.10 is far from clean mainline, the usb and network
driver portions are more or less untouched)

> You will need to cherrypick at least 28 last patches from this stack:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/dr=
ivers/net/usb/asix_devices.c?h=3Dv6.6-rc6
>
> and some from here too:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/dr=
ivers/net/usb/usbnet.c?h=3Dv6.6-rc6

I think this basically means the answer is "if you want this to work
upgrade to a newer kernel".
Which of course won't make any users happy, but oh well...

> Regards,
> Oleksij
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
