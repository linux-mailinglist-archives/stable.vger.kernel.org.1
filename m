Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D1A7CBA73
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 07:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjJQF6V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 01:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjJQF6V (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 01:58:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CFC9E
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 22:58:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso5845a12.0
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 22:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697522298; x=1698127098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rq3LvOe4SfHmFex3vU+w/NmGDGSxbe7VzmQ0Zs+zjU=;
        b=i1UimwAXdoKMFTyKSrvRXBCb7Fd8qyCYvs+k4+MlRaBcA4X7WRHnlyvH7E7Wa38X4w
         RtT9poVjk6X5M+2N7fzPo0+H2Kyz+GlpVmHq7eIvrbniX/fPqt6XXA1CyAuF6TnUhBEG
         SfyzI0CC175ujoORFb7ttuVUOkg5OL2AL/KO2WzQ09PJaXKNVgtcBRQHly4PDGhKrSI0
         tJp909LAGS4/rmkKTE7KKlZxZeEYhGTYlaIvy007GKO/rSMemNilDY53vWA1VYhx2idX
         cU3wWalz9qCiVQWoX29LwEXWS/dMh1XJOq/FDgXWvddqtmah2PPfvRsj5HJy8kZSzmvV
         VedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697522298; x=1698127098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rq3LvOe4SfHmFex3vU+w/NmGDGSxbe7VzmQ0Zs+zjU=;
        b=dMnfiWs05vV5O4lEbcl1fw75f+C/T1xmf2oIGPWY+TmK2DAnUlUnbnPlo1Vj5BbFCa
         BpjblF0dGmUQTeLmoquthuCeEkDOyAqJawT4geIN0LJsCJyHw0LWHnC+NDpw2aR69JJi
         V1eoOd1/Maf0fAxCfuZ1lYEflXfH94WgQZdD9AVBXH7sp5gyEuEztccsyIEkYLMyL/uY
         sEu/EaRIym24p0v/T6tbqBTspWTtYXp70pKZcKUP25rDXf6LZVUOKq/Wt0EJn7FZcXtI
         P8SMVB2NRaeT190RlGNuM28ISg9Ukq9VSwnYwp4TqH6dSkTIDxcIemzmGqEU6WhKXD+K
         H2FA==
X-Gm-Message-State: AOJu0YxzS1fBWwi3BuDkIGULqcrXuyqFo6wITVdTN+aX+AGO2B7wJXLV
        1ECXp/HEJaJ/23GN9VTBqwu7aTsDlOARYnVxt6W8sC0GB+eiHQvKsfBeSA==
X-Google-Smtp-Source: AGHT+IFjp2aDD4eYrqeEl0nw38IecTQFrd/pWHJ3xM27TxsyQLG0k9KkG1IsK+HiPF34IC/DxMkhbyTl5gqWTc1Zoko=
X-Received: by 2002:aa7:d507:0:b0:53f:1f3e:c007 with SMTP id
 y7-20020aa7d507000000b0053f1f3ec007mr18394edq.0.1697522297915; Mon, 16 Oct
 2023 22:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <CANP3RGdzJ7RYWkMT_zNXbg0FyPcCF4rixABvF0++OR-2gpEtow@mail.gmail.com>
 <CANP3RGe82EQhdKd_sc7kWDm2jqx1jTa-Rnj23xBSVpFvK_-T2Q@mail.gmail.com>
 <20231016082913.GB3502392@pengutronix.de> <CANP3RGfp9dNun7-gAarqXo71ay2jeLnqO6eJzmXpNKAmXYeosw@mail.gmail.com>
 <20231017042029.GA3539182@pengutronix.de>
In-Reply-To: <20231017042029.GA3539182@pengutronix.de>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Mon, 16 Oct 2023 22:58:00 -0700
Message-ID: <CANP3RGfRP2yHnNgjj0eGBJ8VpANJg4dnR74aoDUm4UOBuOO8_w@mail.gmail.com>
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

On Mon, Oct 16, 2023 at 9:20=E2=80=AFPM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:
>
> On Mon, Oct 16, 2023 at 11:27:07AM -0700, Maciej =C5=BBenczykowski wrote:
> > On Mon, Oct 16, 2023 at 1:29=E2=80=AFAM Oleksij Rempel <o.rempel@pengut=
ronix.de> wrote:
> > > On Sun, Oct 15, 2023 at 03:13:26PM -0700, Maciej =C5=BBenczykowski wr=
ote:
> > > > This means even with the option manually enabled, we'd still need t=
o
> > > > cherrypick dde25846925765a88df8964080098174495c1f10
> > > > "net: usb/phy: asix: add support for ax88772A/C PHYs"
> > > > since apparently this is simply new(ish) hardware with built-in x88=
772C PHY.
> > >
> > >
> > > As far as I see, you are not using clean mainline stable kernel. All =
changes
> > > which make your kernel to need an external PHY driver are _not_ in v5=
.10.198.
> >
> > No, the dmesg was actually from a (probably clean-ish 6.4-ish) debian
> > kernel on my laptop,
> > where the device enumerates and works in one of the 2 usb-c ports.
> >
> > As I mentioned the hardware that actually runs 5.10 is having issues
> > even detecting my test device.
> > (and while that 5.10 is far from clean mainline, the usb and network
> > driver portions are more or less untouched)
> >
> > > You will need to cherrypick at least 28 last patches from this stack:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/lo=
g/drivers/net/usb/asix_devices.c?h=3Dv6.6-rc6
> > >
> > > and some from here too:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/lo=
g/drivers/net/usb/usbnet.c?h=3Dv6.6-rc6
> >
> > I think this basically means the answer is "if you want this to work
> > upgrade to a newer kernel".
> > Which of course won't make any users happy, but oh well...
>
> It means - what ever problem there is, it is most probably not related
> to the asix driver. In kernel v5.10, there are no external dependencies
> to other PHY drivers.

I take this to mean you think that the built-in ax88772C PHY should
work out of the box with 5.10,
and if it doesn't then this presumably means there's something wrong
at the usb controller level.
(hopefully I'll get a second unit and be able to confirm this...)
