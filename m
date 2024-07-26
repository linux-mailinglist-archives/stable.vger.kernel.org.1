Return-Path: <stable+bounces-61820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A3E93CD9B
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 07:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B75B214D3
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 05:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F792771C;
	Fri, 26 Jul 2024 05:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkKqK8/D"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A001A716
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721971958; cv=none; b=pYWfnJowyxxBIYj2nhqvQksnRX578zD6kI15o5xX8lcR26KFvrY3W7atVi3Nd65mbk6o0iczYwnk11NUnVFlbHzLlNRqkz/aDWl5GfC29UQkT/9l8V8BrEBUz+YsrKETyELbd4PXYzxXOj+LGNOMtQGE8n4LBljtg7SI6vhLnE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721971958; c=relaxed/simple;
	bh=PgbImsnclS79CZO0hSBT1V8BfJi6dkFXudTeZXaSIQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1jToIRq3ltxYEUg3dt+YShhS0/f4Q8nm6IUBjzrdpzQcKZTOLoZJVT1lUqgJ7Zd93wfi/REcA2wDwnO2Tzp8UX54QgskbUQfJDUdOD+P3+8GazdZEzj+Us0AVi3IyFklIZyhiuiP+eRxsvGd/+d+alAfznCTOCwzpOOLMrVDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkKqK8/D; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d2b921cdfso556666b3a.0
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 22:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721971956; x=1722576756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XWOkuRQOuyHdimjfYTATVH9w85XtZhrpq0X9O9R1WI=;
        b=EkKqK8/DCF/WEbgvbWmOzrPi5g2GqLs5LKbzxX0mYg60jl6H53SvF7R+Vi8tjnRM3h
         b2ZUx1TrUZ9l28AUCGtiHoYTAOxnESJTVZcjbu0iWlmh0kWmN7g41nyVdp552t4Z0Hgi
         pIDWQAiG0XtTatyhwqx8LZHSur5R2oQ46PR+FOQVnY3KdHJRLFWd6QS4sIgc6YQSFN4R
         a6wroLYIK9F7CUzM0yCWz7WmmPXAMYjfNMy5B9Y9s1DryW12Fc448vWwpS3jNH/Dla++
         791jgTaYbxJBrjq11HyThQZZflEFN955Zvrg1k6Zk1+MYsZeQE+z7AiergYwJnbQr5NT
         BgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721971956; x=1722576756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XWOkuRQOuyHdimjfYTATVH9w85XtZhrpq0X9O9R1WI=;
        b=lf6JqCRJFyBi4nO7A6AbSGn0+1t1o2VB4LrkSJemJG6xKHPnNlvAcF1PcfVlbNN06n
         FACLB4pl0Cv+2lctHl096udxgMw2AslxmG8YbcG3rjU/hKOsEj01SeERJJdMOa3Sx1Be
         hZ1n1H/Ezop4TwI9atvMBSHsEUL1N7J2rJKbg5fKis7xsB92UwB9XPCBEOVsbgmMA8T6
         7sa5aBrsbTaOLMBUNptjb/DO+8ypUIzKdErJ4DAuKDfL+XBI9BOX6qxbBIffOOxX6963
         3bYnt/AAgCwaaaUApg8WLNwHrBhSj1CGVY615HUW+QU+ebByDe/fLTk+y1z+vuz+ldR+
         eeLw==
X-Forwarded-Encrypted: i=1; AJvYcCVbHTqFhpxJScejcED5qTSlHE7iL5ILEIoLG9iyJGT8t8lvYsnUT8d3vbNg5hHzb4x2RP8zKxooHtWOyaeilBLkKfRWgwOC
X-Gm-Message-State: AOJu0Yy5EC9wUfdZEcP/w2Ka0KX75wXr74Ga8QMb9ahIHE/MP4DD5CGi
	MrI8706/mp0BI3UrKhVABb21kwPIj3iv34KR1B/RT/LGLBYOk7NQYnEJl1pYSpfVOPf173bsKQR
	25MWQ0YtUCaRT+Q+8FoF321R5cw5WgQ==
X-Google-Smtp-Source: AGHT+IEnX8zd+codrMAcwVdXOmYhfU5fZTXZquR4FEB4ZqOZ6tUirL8p6QtnTcw+ftvxSoGB+/dnHc8BNowCat2pqLY=
X-Received: by 2002:a05:6a21:a4c1:b0:1c4:8bba:76e9 with SMTP id
 adf61e73a8af0-1c48bbaac17mr1721943637.53.1721971956212; Thu, 25 Jul 2024
 22:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717090126.467511-1-linchengming884@gmail.com>
 <2024072359-suitcase-statutory-b7e4@gregkh> <CAAyq3Sb+D_+F5qX9HQ=EZkhm44RDf4BG4EuzDE6W_R9+Av8j-A@mail.gmail.com>
 <2024072659-pavement-alienate-e629@gregkh>
In-Reply-To: <2024072659-pavement-alienate-e629@gregkh>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Fri, 26 Jul 2024 13:31:21 +0800
Message-ID: <CAAyq3SZt4=Zb-Zo4QOMhxFtKaRsdwOFTix89mOJua348bsqFJg@mail.gmail.com>
Subject: Re: [PATCH v5.10.y v2] mtd: spinand: macronix: Add support for serial
 NAND flash
To: Greg KH <greg@kroah.com>
Cc: kunchichiang@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>, 
	stable@vger.kernel.org, Jaime Liao <jaimeliao@mxic.com.tw>, 
	Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Greg KH <greg@kroah.com> =E6=96=BC 2024=E5=B9=B47=E6=9C=8826=E6=97=A5 =E9=
=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=881:23=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Jul 26, 2024 at 09:15:54AM +0800, Cheng Ming Lin wrote:
> > Hi,
> >
> > Greg KH <greg@kroah.com> =E6=96=BC 2024=E5=B9=B47=E6=9C=8823=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:36=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Wed, Jul 17, 2024 at 05:01:26PM +0800, Cheng Ming Lin wrote:
> > > > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > > >
> > > > [ Upstream commit c374839f9b4475173e536d1eaddff45cb481dbdf ]
> > > >
> > > > Macronix NAND Flash devices are available in different configuratio=
ns
> > > > and densities.
> > > >
> > > > MX"35" means SPI NAND
> > > > MX35"LF"/"UF" , LF means 3V and UF meands 1.8V
> > > > MX35LF"2G" , 2G means 2Gbits
> > > > MX35LF2G"E4"/"24"/"14",
> > > > E4 means internal ECC and Quad I/O(x4)
> > > > 24 means 8-bit ecc requirement and Quad I/O(x4)
> > > > 14 means 4-bit ecc requirement and Quad I/O(x4)
> > > >
> > > > MX35LF2G14AC is 3V 2Gbit serial NAND flash device
> > > > (without on-die ECC)
> > > > https://www.mxic.com.tw/Lists/Datasheet/Attachments/7926/MX35LF2G14=
AC,%203V,%202Gb,%20v1.1.pdf
> > > >
> > > > MX35UF4G24AD/MX35UF2G24AD/MX35UF1G24AD is 1.8V 4Gbit serial NAND fl=
ash device
> > > > (without on-die ECC)
> > > > https://www.mxic.com.tw/Lists/Datasheet/Attachments/7980/MX35UF4G24=
AD,%201.8V,%204Gb,%20v0.00.pdf
> > > >
> > > > MX35UF4GE4AD/MX35UF2GE4AD/MX35UF1GE4AD are 1.8V 4G/2Gbit serial
> > > > NAND flash device with 8-bit on-die ECC
> > > > https://www.mxic.com.tw/Lists/Datasheet/Attachments/7983/MX35UF4GE4=
AD,%201.8V,%204Gb,%20v0.00.pdf
> > > >
> > > > MX35UF2GE4AC/MX35UF1GE4AC are 1.8V 2G/1Gbit serial
> > > > NAND flash device with 8-bit on-die ECC
> > > > https://www.mxic.com.tw/Lists/Datasheet/Attachments/7974/MX35UF2GE4=
AC,%201.8V,%202Gb,%20v1.0.pdf
> > > >
> > > > MX35UF2G14AC/MX35UF1G14AC are 1.8V 2G/1Gbit serial
> > > > NAND flash device (without on-die ECC)
> > > > https://www.mxic.com.tw/Lists/Datasheet/Attachments/7931/MX35UF2G14=
AC,%201.8V,%202Gb,%20v1.1.pdf
> > > >
> > > > Validated via normal(default) and QUAD mode by read, erase, read ba=
ck,
> > > > on Xilinx Zynq PicoZed FPGA board which included Macronix
> > > > SPI Host(drivers/spi/spi-mxic.c).
> > > >
> > > > Cc: stable@vger.kernel.org # 5.10.y
> > > > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > > > Signed-off-by: Jaime Liao <jaimeliao@mxic.com.tw>
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > Link: https://lore.kernel.org/linux-mtd/1621475108-22523-1-git-send=
-email-jaimeliao@mxic.com.tw
> > > > ---
> > > >  drivers/mtd/nand/spi/macronix.c | 110 ++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 110 insertions(+)
> > >
> > > This is already in the 5.10.y tree, why are you asking for it to be
> > > applied again?
> > >
> >
> > I accidentally sent the wrong patch, which has already been applied to =
LTS.
> > I would like to inquire about the possibility of reverting this patch.
>
> Revert what, the one that is in the tree already?  If you need/want it
> reverted, please submit a patch to do so along with the reasoning, like
> any other change that is submitted here.
>

No, there's nothing to revert.
Please ignore this patch as I accidentally sent it again,
and it's already in the 5.10.y tree.

> thanks,
>
> greg k-h

