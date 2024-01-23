Return-Path: <stable+bounces-15543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234628392A7
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 16:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF920284737
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 15:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68BE5FDD2;
	Tue, 23 Jan 2024 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZJUdZUtq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5B50A72
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023663; cv=none; b=rA8wW/35oyJsKEVF5pb5M0dWbVqtGO4H6oOMAlhFziK6UoThKk6LjEapjwyjKkGBpufM3qUPtGxkVCZiMow9vc2SjzOZnLH6zCdbxhEBZvIvG09pWAkfzl8diyGCu57Tcw+J/i5jVnJUi2R6IhVpEKRyDDuwKoK1kKViI2E6MFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023663; c=relaxed/simple;
	bh=Z25+7+eZRMEehXGp6WoC4354Ldu8Jwzdw/xs6nI5mas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlYfRq4V/FWffsv9r7iROFyLL9pZ0s/vlHXtJNDeRE2LX9QTridfttcgjLAluz/SeV6yr9Oh4BGCnHUY+F74MEQiD3b45Gc/Mng9EwhABk4uPHyIMDBazg13fSEHpuiYd454MHh4AF9IMr5wo1d/V9lK3BAFCDQu/ZjQED8AwD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZJUdZUtq; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf15a524ffso1088801fa.0
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1706023659; x=1706628459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/acSyEquTjXcuiLAZAu9D5jbI1RMTR/MKbLTHxg44OI=;
        b=ZJUdZUtqF9XMIQDqFUojYL8t8gC6Jxax7LXcNWSe8Df4oKJhCCFprbiXoGrZ1fj9WQ
         MT0kC2nYPrwXtLQJu4mZ/aATDA6cuFxzAJ8kKyBTczUiXL1bqqrOqDC1V3By11I9kK4Y
         fuw9SyvRdulYbx87pL0XMdSOVmMRedKqUpEvSOn+Z0jjCoDYsKhHI/x/jl82FaXrRqY+
         HbwR9a4kKh3p6g9yIdGBqFDyMcDaluudWIXUAoDRqwyBaqPDE7xYMuejDIqphAcvmG/1
         McHUxduPJldwGGnHFsxeUpWWndcZqO1eSDMCkuhh3NObyaaWJcj67Ky4k7G9WfrmAjHF
         gOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706023659; x=1706628459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/acSyEquTjXcuiLAZAu9D5jbI1RMTR/MKbLTHxg44OI=;
        b=Dt5VkykfJpZokNrAfItwV2ZOyXAUeafObdRmz2oG2Ugk9pIirhMG0hM4W0QDLovH70
         T1RVEhPGu5LFOOS2ywNxCWqHx/S6q5/74NHS86jK7+v8yJlEybUyd8HF2lAF+TBmEEWH
         Kce2HRayIzRPUUbkWoXeKmeCq7OmHOaHoBydCOZ6n3WABqMCQa8ENh/NSt63L4md3sni
         GNX3j2ZkMvP0CjjRzxqzM1BVvOw20Af6kCGrJ/ourqENrEjr5frj6jXMYoqEx263ubKK
         alg64tVZi1KCLZiGVLqtx+Hw+fE7n5oDG6eKGkWIXQPiFxbieilLWNRL4U+JxyF20V1L
         GuIw==
X-Gm-Message-State: AOJu0YzjxWuFisIRHdQf9kZO6PYgShoJr1g9p6l151TnRz7fFfvDHfz3
	jSjeDlhEjez5CLqW8g4gXlBe3Isjz+C80AigZ3RO1+j9lg89jkNdbAyJacX1w8H9jTjuF+KyT/o
	RQu6O9wM05dw4wkHSQrkRA+lGEbyLYKFw9KoIyg==
X-Google-Smtp-Source: AGHT+IECOsu0WmbMJlmTCB3EljPXp0hBtHwIU8u+z0RczVGoG395LSveV3dNvEJs5hqE6Jjd9Fu7sQw0E9z43zZ65dM=
X-Received: by 2002:a2e:8356:0:b0:2cd:f76f:640d with SMTP id
 l22-20020a2e8356000000b002cdf76f640dmr5982118ljh.2.1706023658752; Tue, 23 Jan
 2024 07:27:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120192125.1340857-1-andrew@lunn.ch> <20240122122457.jt6xgvbiffhmmksr@skbuf>
 <0d9e0412-6ca3-407a-b2a1-b18ab4c20714@lunn.ch> <CAO-L_45iCb+TFMSqZJex-mZKfopBXxR=KH5aV4Wfx5eF5_N_8Q@mail.gmail.com>
 <5f449e47-fc39-48c3-a784-77b808c31050@lunn.ch>
In-Reply-To: <5f449e47-fc39-48c3-a784-77b808c31050@lunn.ch>
From: Tim Menninger <tmenninger@purestorage.com>
Date: Tue, 23 Jan 2024 07:27:27 -0800
Message-ID: <CAO-L_46Ltq0Ju_BO+rfvAbe7F=T6m0hZZKu9gzv7=bMV5n6naw@mail.gmail.com>
Subject: Re: [PATCH net v1] net: dsa: mv88e6xxx: Make unsupported C45 reads
 return 0xffff
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev-maintainers <edumazet@google.com>, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, netdev <netdev@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 3:01=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I'm not sure I fully agree with returning 0xffff here, and especially n=
ot
> > for just one of the four functions (reads and writes, c22 and c45). If =
the
> > end goal is to unify error handling, what if we keep the return values =
as
> > they are, i.e. continue to return -EOPNOTSUPP, and then in get_phy_c22_=
id
> > and get_phy_c45_ids on error we do something like:
> >
> >     return (phy_reg =3D=3D -EIO || phy_reg =3D=3D -ENODEV || phy_reg =
=3D=3D -EOPNOTSUPP)
> >         ? -ENODEV : -EIO;
>
> As i said to Vladimir, what i posted so far is just a minimal fix for
> stable. After that, i have two patches for net-next, which are the
> full, clean fix. And the first patch is similar to what you suggest:
>
> +++ b/drivers/net/phy/phy_device.c
> @@ -780,7 +780,7 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bu=
s, int addr, int dev_addr,
>   * and identifiers in @c45_ids.
>   *
>   * Returns zero on success, %-EIO on bus access error, or %-ENODEV if
> - * the "devices in package" is invalid.
> + * the "devices in package" is invalid or no device responds.
>   */
>  static int get_phy_c45_ids(struct mii_bus *bus, int addr,
>                            struct phy_c45_device_ids *c45_ids)
> @@ -803,7 +803,10 @@ static int get_phy_c45_ids(struct mii_bus *bus, int =
addr,
>                          */
>                         ret =3D phy_c45_probe_present(bus, addr, i);
>                         if (ret < 0)
> -                               return -EIO;
> +                               /* returning -ENODEV doesn't stop bus
> +                                * scanning */
> +                               return (phy_reg =3D=3D -EIO ||
> +                                       phy_reg =3D=3D -ENODEV) ? -ENODEV=
 : -EIO;
>
>                         if (!ret)
>                                 continue;
>
> This makes C22 and C45 handling of -ENODEV the same.
>
> I then have another patch which changed mv88e6xxx to return -ENODEV.
> I cannot post the net-next patches for merging until the net patch is
> accepted and then merged into net-next.
>
>   Andrew

Does that mean if there's a device there but it doesn't support C45 (no
phy_read_c45), it will now return ENODEV?

I suppose that's my only nit but at the end of the day I'm not unhappy with=
 it.

Thank you for taking the time to look at this with me. Is there anything
else you need from me?

