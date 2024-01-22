Return-Path: <stable+bounces-12813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F7483746C
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78588B2623A
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EC4481AA;
	Mon, 22 Jan 2024 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZDA0ax07"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE84BA88
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956299; cv=none; b=bIq/en1TvuRnmXYuhG9or9MU/MkfqhsQvhfLNjwSckNqZyF02PrEIGMhluCMGnyA9xbFja/to0wUmdqPdpRn4rI65G4SQiWtJZxHWQW2D/cFGMbmqBLoVJo+e09cbCIEGXHacn3iu1s6DuYXDFst7tqqKlvTxnx17TE0aG3IgTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956299; c=relaxed/simple;
	bh=g6xaSKZDP6ofReqSz5vu+HuLjLS2h0NXy9Z6C5o2PcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNav9vgMJt/NxI6tl7hvqjHdZZ2OtwoUlq16BeTFfcLSE+u+/AURRSU2mVQ/UuAykEhPS4zW9+x4/V4eeRIyu9J+1ujUrUaoHGYQto++E4Xp3AaLWCLnjh+mIpzKC7Bv6ejzEUV+cT2eb3PdtVpuVWYICEAQtR6Dbyuz+wYjPUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZDA0ax07; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd9cb17cbeso6319191fa.1
        for <stable@vger.kernel.org>; Mon, 22 Jan 2024 12:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1705956294; x=1706561094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14o4A7ZljgoD8Pn95jwq8PPzUV9gsCH/1yNA7rahmQs=;
        b=ZDA0ax07B8UH/0Iwifwlw9TtizYm/7UUv8rRoXsIGRKisjNiOEqNHPftR/GpTFraV4
         gM1fLIbb65JQXeLcw1/WN3pVUZ9HfZWTMmBJ8Wp0Yy3tMbUi2B79vSVINXiHaZa10M+H
         RTQq0X/fMhXbstT0ybku19lT7TCEer9usgtDLBvuyejhoRrjIrDuLXCXENlBbJYeDuNg
         1GTPkYsMLs8FACM98g7wGkxsM2bgUq20/6MLSfRxKgHT6HHY0NNAkPkhN0WjHkS4G4aH
         2gUlFsldiEf+7PE5FL9JBKgAkIGPxV3GGJ3w0zilcv7tJW+Bji9MIsQX34Brvqe6L/vl
         cIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705956294; x=1706561094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14o4A7ZljgoD8Pn95jwq8PPzUV9gsCH/1yNA7rahmQs=;
        b=ZmcYPwVQWwdQVMGyXz1zgGnQfI+KRydMWVoFKRu+jL3VzZJ/tA7SAmdFSImATPl0aJ
         oMQZAzStibPJh4c54f2TYDt5jVNShhW7k/qot6i5gmvBC7PDZqmZ5WMv7NkU9TzrCjad
         vA5I3Z4hIwuhdtfJEt40blac2KVDPzj6hjHJhJyQpCSJ8b3ZwcVIKJUeNCSgyZklovty
         9s9bSNZBMiY3dw6yLsGTFToAbpCWNTY/KUT8jkajYzka81i5JPHY185tYGWeuaSJWncJ
         fJnTfUPsVXWh4tSTzlWg05Fn3KmLCzebuvEl6g4WQfxprSHjSGM26FlHYJvIo2xfhdqw
         4pfQ==
X-Gm-Message-State: AOJu0YzfJ2NrrqfsOBuTndKa/F+3NyKbG8Ch39Xs4Wrogq7B3zh9+NeI
	RpnGDTMbEBWqYhKMVOPNqqrkdl0MNbL6jg4nKbBvGtb7GUJzrTU5vwhn3pL+6OY/1fzF011nWbi
	99wo038KmuFwCg8N/OKVjFkHuy442BOxNrUBLGFNqMDdjU3qC+U16vg==
X-Google-Smtp-Source: AGHT+IFUPq4ubBVDpKCfSFl7DOYz2OWSloLvlgV2IP3dVTKTc6ea7OOsuCys5raTvW8fLxBof4jPf4taxbQ7ucQZP7k=
X-Received: by 2002:a2e:2e19:0:b0:2cc:e68b:ee59 with SMTP id
 u25-20020a2e2e19000000b002cce68bee59mr4418775lju.1.1705956294210; Mon, 22 Jan
 2024 12:44:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120192125.1340857-1-andrew@lunn.ch> <20240122122457.jt6xgvbiffhmmksr@skbuf>
 <0d9e0412-6ca3-407a-b2a1-b18ab4c20714@lunn.ch>
In-Reply-To: <0d9e0412-6ca3-407a-b2a1-b18ab4c20714@lunn.ch>
From: Tim Menninger <tmenninger@purestorage.com>
Date: Mon, 22 Jan 2024 12:44:42 -0800
Message-ID: <CAO-L_45iCb+TFMSqZJex-mZKfopBXxR=KH5aV4Wfx5eF5_N_8Q@mail.gmail.com>
Subject: Re: [PATCH net v1] net: dsa: mv88e6xxx: Make unsupported C45 reads
 return 0xffff
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev-maintainers <edumazet@google.com>, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, netdev <netdev@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 5:39=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Jan 22, 2024 at 02:24:57PM +0200, Vladimir Oltean wrote:
> > Hi Andrew,
> >
> > On Sat, Jan 20, 2024 at 08:21:25PM +0100, Andrew Lunn wrote:
> > > When there is no device on the bus for a given address, the pull up
> > > resistor on the data line results in the read returning 0xffff. The
> > > phylib core code understands this when scanning for devices on the
> > > bus, and a number of MDIO bus masters make use of this as a way to
> > > indicate they cannot perform the read.
> > >
> > > Make us of this as a minimal fix for stable where the mv88e6xxx
> >
> > s/us/use/
> >
> > Also, what is the "proper" fix if this is the minimal one for stable?
>
> Hi Vladimir
>
> I have a patchset for net-next, once it opens. I looked at how C22 and
> C45 differ in handling error codes. C22 allows the MDIO bus driver to
> return -ENODEV to indicate its impossible for a device to be at a
> given address. The scan code then skips that address and continues to
> the next address. Current C45 code would turn that -ENODEV into an
> -EIO and consider it fatal. So i change the C45 code to allow for
> -ENODEV in the same way, and change the mv88e6xxx driver to return
> -ENODEV if there are is no C45 read op.
>
> Since making the handling of the error codes uniform is more than a
> simple fix, i decided on a minimal fix for net.
>
> Thanks for the comments on the commit message, i will address them
> soon.
>
>         Andrew

I'm not sure I fully agree with returning 0xffff here, and especially not
for just one of the four functions (reads and writes, c22 and c45). If the
end goal is to unify error handling, what if we keep the return values as
they are, i.e. continue to return -EOPNOTSUPP, and then in get_phy_c22_id
and get_phy_c45_ids on error we do something like:

    return (phy_reg =3D=3D -EIO || phy_reg =3D=3D -ENODEV || phy_reg =3D=3D=
 -EOPNOTSUPP)
        ? -ENODEV : -EIO;

So the diff looks something like (just getting a point across, haven't
tried or style checked this)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3611ea64875e..f21f07f33f06 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -758,12 +758,14 @@ static int get_phy_c45_devs_in_pkg(struct
mii_bus *bus, int addr, int dev_addr,

        phy_reg =3D mdiobus_c45_read(bus, addr, dev_addr, MDIO_DEVS2);
        if (phy_reg < 0)
-               return -EIO;
+               return (phy_reg =3D=3D -EIO || phy_reg =3D=3D -ENODEV ||
phy_reg =3D=3D -EOPNOTSUPP)
+                       ? -ENODEV : -EIO;
        *devices_in_package =3D phy_reg << 16;

        phy_reg =3D mdiobus_c45_read(bus, addr, dev_addr, MDIO_DEVS1);
        if (phy_reg < 0)
-               return -EIO;
+               return (phy_reg =3D=3D -EIO || phy_reg =3D=3D -ENODEV ||
phy_reg =3D=3D -EOPNOTSUPP)
+                       ? -ENODEV : -EIO;
        *devices_in_package |=3D phy_reg;

        return 0;
@@ -882,7 +884,8 @@ static int get_phy_c22_id(struct mii_bus *bus, int
addr, u32 *phy_id)
        phy_reg =3D mdiobus_read(bus, addr, MII_PHYSID1);
        if (phy_reg < 0) {
                /* returning -ENODEV doesn't stop bus scanning */
-               return (phy_reg =3D=3D -EIO || phy_reg =3D=3D -ENODEV) ? -E=
NODEV : -EIO;
+               return (phy_reg =3D=3D -EIO || phy_reg =3D=3D -ENODEV ||
phy_reg =3D=3D -EOPNOTSUPP)
+                       ? -ENODEV : -EIO;
        }

        *phy_id =3D phy_reg << 16;
@@ -891,7 +894,8 @@ static int get_phy_c22_id(struct mii_bus *bus, int
addr, u32 *phy_id)
        phy_reg =3D mdiobus_read(bus, addr, MII_PHYSID2);
        if (phy_reg < 0) {
                /* returning -ENODEV doesn't stop bus scanning */
-               return (phy_reg =3D=3D -EIO || phy_reg =3D=3D -ENODEV) ? -E=
NODEV : -EIO;
+               return (phy_reg =3D=3D -EIO || phy_reg =3D=3D -ENODEV ||
phy_reg =3D=3D -EOPNOTSUPP)
+                       ? -ENODEV : -EIO;
        }

        *phy_id |=3D phy_reg;

This might even resemble what you had in mind in your initial feedback...

Tim

