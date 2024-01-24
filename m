Return-Path: <stable+bounces-15722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D04D583ADE2
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 17:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6B91C23DBE
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 16:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4889F7CF08;
	Wed, 24 Jan 2024 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZUSIS8Df"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA577F12
	for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112004; cv=none; b=FtptUu+4oPeMuJcJNAX678zLJKPIcKuMzSmc6Pc45Nbwp3TRNlCwZOYDzaJzV1IkuKjKf9cFl0TGmUcFU8YQMLk25OUG8p92Y3XKRN1kdPJ7mmtz2aTjWfnqvySTG88MzBOBG2FeXb/dgLasJ+XoRBD8Wg8HWSwNEg6cyuS0VZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112004; c=relaxed/simple;
	bh=xSv5nclyl9NZUM36WnT/fxvfMVq4JPnlI8sG5frcNO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsUXvDYXVTkHWXweuxNew4FE0ynk4YhfpsVrsyAsMuUCby5vART6BCjoL0hLl2uvvaVAPJMXpAeEPZOlHAD1JH/KQ0niO9/s1QccACQDZSvtKqmpEFY/YNCxPhoQDi8ObbRagC2T6qyot6HIb/+hObH6DKMGUseKl9/uls438w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZUSIS8Df; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd9cb17cbeso11460701fa.1
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 08:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1706112000; x=1706716800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE7CWWItyYbfndXuvlxJHXRIBozZLlFnhH3yXJATkyM=;
        b=ZUSIS8DfMyaGc2tugmEnqMRROPQtNSFo0eUEJK+TgtOO7rcIA5B8QQQ9rCahj0h/4g
         6iPVM7aRfCJzMbfaZr7CMlJr2StbznxoaLZ/jL23ElMajlsVL+0XLaD2AqjahLcXfT8J
         3SRTRWUeqVmoHxh24j2UF9EkiKm02IYJeLmR56+ZoYyIOBzhRyaXx5pUKEDzl28+0JXT
         MrzKZp5l9bcmXG/cjwXQ3o+px7fbOmdptmwnvBL9klFtbhKDlK9PVaqiX9zBETudoQM7
         frRJxekTZ59cQ360ZYev1H3ZD+fe2o4dOVnXBCAk3ksmPJ/Wy5WrCdBIjONuneXpncGV
         0VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706112000; x=1706716800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KE7CWWItyYbfndXuvlxJHXRIBozZLlFnhH3yXJATkyM=;
        b=DoefQf7Qkzg9DFTByYlrJUzQRJ3EmUYmkcQV7r1M7wVna2jjaXJ+t/VTYEDjMx54RE
         cQBW7wXS50heMpX5Fe3yjPkgti4ipZWIquT6tFp9umg3nL96h1EGD6C2h6XkUKKnNtpg
         +2FxOgIruTIGfakR5NfhTLjKxot/0qBQgQBU29poAnUCQmJ2tXotB2IBd4SLKtcfTo2V
         DlzqBpFfz9rgYMd40I378IbL1ArHj8+oentNKSambjv497H6RH4+l4ic9obWjvbkDh3f
         HikGSzHGXsOCn8dv80Az1nZxlx9Q3gwPmIqg48JY2uprhvh/dVgzpuA9wWr3HdkOT73A
         f6YA==
X-Gm-Message-State: AOJu0YwRTxNGNCQPwoiLcKV4yYGk4E7mF9cIvFRnEvdS8vWlFO1lXzVD
	Bsnk/5vs41CsJV9tpPqi5ILp/PpVjlbUP0+9TV1dvHh+NOYFNKHNpvLyKhu3dtRk6aAfuJ+F+PI
	Nq819PP/m71JXYYuHPm9rkozHpMLVonXrutggOQ==
X-Google-Smtp-Source: AGHT+IEc+PIQoVWA63nP+lsGiLgGYaT/0T2jdnesRdyAalXgG+1YO9CryOECZfYyD8CBvfBWOvihp5gTv3iT0LORUEg=
X-Received: by 2002:a2e:9943:0:b0:2cd:1ca5:282c with SMTP id
 r3-20020a2e9943000000b002cd1ca5282cmr1895907ljj.5.1706111999959; Wed, 24 Jan
 2024 07:59:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120192125.1340857-1-andrew@lunn.ch> <20240122122457.jt6xgvbiffhmmksr@skbuf>
 <0d9e0412-6ca3-407a-b2a1-b18ab4c20714@lunn.ch> <CAO-L_45iCb+TFMSqZJex-mZKfopBXxR=KH5aV4Wfx5eF5_N_8Q@mail.gmail.com>
 <5f449e47-fc39-48c3-a784-77b808c31050@lunn.ch> <CAO-L_46Ltq0Ju_BO+rfvAbe7F=T6m0hZZKu9gzv7=bMV5n6naw@mail.gmail.com>
 <32d96dd3-7fbb-49e5-8b05-269eac1ac80d@lunn.ch>
In-Reply-To: <32d96dd3-7fbb-49e5-8b05-269eac1ac80d@lunn.ch>
From: Tim Menninger <tmenninger@purestorage.com>
Date: Wed, 24 Jan 2024 07:59:48 -0800
Message-ID: <CAO-L_47Cvh2QFiQ-Ug3Zsa4BnoC85MTN3W4cWJaJddtVUvmOPg@mail.gmail.com>
Subject: Re: [PATCH net v1] net: dsa: mv88e6xxx: Make unsupported C45 reads
 return 0xffff
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev-maintainers <edumazet@google.com>, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, netdev <netdev@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 2:59=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Does that mean if there's a device there but it doesn't support C45 (no
> > phy_read_c45), it will now return ENODEV?
>
> Yes, mv88e6xxx_mdio_read_c45() will return -ENODEV if
> chip->info->ops->phy_read_c45 is NULL. That will cause the scan of
> that address to immediately skip to the next address. This is old
> behaviour for C22:
>
> commit 02a6efcab675fe32815d824837784c3f42a7d892
> Author: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Date:   Tue Apr 24 18:09:04 2018 +0200
>
>     net: phy: allow scanning busses with missing phys
>
>     Some MDIO busses will error out when trying to read a phy address wit=
h no
>     phy present at that address. In that case, probing the bus will fail
>     because __mdiobus_register() is scanning the bus for all possible phy=
s
>     addresses.
>
>     In case MII_PHYSID1 returns -EIO or -ENODEV, consider there is no phy=
 at
>     this address and set the phy ID to 0xffffffff which is then properly
>     handled in get_phy_device().
>
> And there are a few MDIO bus drivers which make use of this, e.g.
>
> static int lan9303_phy_read(struct dsa_switch *ds, int phy, int regnum)
> {
>         struct lan9303 *chip =3D ds->priv;
>         int phy_base =3D chip->phy_addr_base;
>
>         if (phy =3D=3D phy_base)
>                 return lan9303_virt_phy_reg_read(chip, regnum);
>         if (phy > phy_base + 2)
>                 return -ENODEV;
>
>         return chip->ops->phy_read(chip, phy, regnum);
>
> This Ethernet switch supports only a number of PHY addresses, and
> returns -ENODEV for the rest.
>
> So its a legitimate way to say there is nothing here.
>
> You suggestion of allowing ENOPSUPP for C45 would of fixed the
> problem, but C22 and C45 would support different error codes, which i
> don't like. Its better to be uniform.
>
>         Andrew

Excellent, color me convinced.

