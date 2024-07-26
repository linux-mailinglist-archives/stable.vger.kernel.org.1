Return-Path: <stable+bounces-61806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014A193CC50
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 03:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEAE281BF3
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 01:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709FAA2A;
	Fri, 26 Jul 2024 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoWjq5JM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B817C368
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721956632; cv=none; b=qexjsBxdA3pZx4KAgSBwURq9fgUHIwUlLh7ljUgMy3NEtiXTAoJ55xUK0Zi0OOZiPoEOrNz+3Z047V/mmxiqOf9RnuhHLcuLG8AKBrKkn+PNJT6b3eIxYlWUH8uwJirprQj2xsgECdwPLQz3MhwRd+ZDYiQu0oT5FTuLJuhoypU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721956632; c=relaxed/simple;
	bh=xfYtZpdwUP04fWozOpZmyFfctIIyjAQvjlE3RRC6KPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndCIu7plMdwF8gY7kDbsolSD+05wlT8hA8zi7laHqmooLHYIqL9bW1P3IZpTJ4M5pbm20yggiDV+UUO5IPka/zNlUSwq+yb730+UPfOHNNTBK52nLGFLVTlRnWyexmt+WbhKlfO5s/6xksyhwdW0h4S55FU25OF2fNe7k+sewbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoWjq5JM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d316f0060so289113b3a.1
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 18:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721956629; x=1722561429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPjryx8Cy6HHBIocihbdqvt8OeiJ+Bol3KJlya+YIaE=;
        b=aoWjq5JMaSLn32VHbatMaZjF860XMragaCCVIl4lW2wZ/uCTW45WFM1xptXcP9R/Lx
         GzjK9WDG89kjIb8XTPNuneIoC+zilNYSZvV7no25ArM+XpsDiGMv1qKHvby4xUnaDE07
         JXa/eU56VH8dfWWOZogoyktoLkbPSgkMF3zk84INJHlH3dBDpMrGQcdqa67fCyBqRmBH
         h4es36W+/T8ytYB+pTdb1Bo7Lbky6irHN+sfhBM+r+fOyUGG5CF2YlLOGIKi66vVBTP8
         onjE42CZ+5m1lNcRaZzBXKYYEyb8HMVg7NdHwHkne7NIVrzapGmIh1Y1qITEx5f+q2pX
         TUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721956629; x=1722561429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPjryx8Cy6HHBIocihbdqvt8OeiJ+Bol3KJlya+YIaE=;
        b=txtadqr3xfcUgos0nXsXECWHed4dOtWDm78YdhIRJb6DsVk0GhLpzgd/V44Be96p9N
         Srb9YuA8qgfVZYT3s9c0faAcNGyoyiD7mX+VW1jZziNFhjk5+DxOj6tRdVnlI+v9kXEE
         oALYqByTa10haKrjKellf2HEhZaCgHsVd6uVBYHWPshbYGj+Aqvm/T3XlyJUtFAoIwIR
         OBpuLNkj5LuANKz98PF2OCFonZiE00EmEg+jqD2iZBNRuhnVgVC9uZ3miAKcZFB3RYk3
         ziTsYhVg+qPUrBCFP+10cOnIkm+t5JzfWRo8+0qtiS05pdb3Zs3mB3xidRwETjfvLNFM
         HJRw==
X-Forwarded-Encrypted: i=1; AJvYcCX8v7p8o8FgDdvgL01GxDO6J5iJNPjWGU4kHlT+/gH6F2mj+uBOd/Okp9rqzmZ+zqLfevfk8IsLioxWDGzU+wJgQVEIyqV/
X-Gm-Message-State: AOJu0YyBUI6EiFLkUL/HvuyvWd0KztFNdk8VOGYgBfDOH2h4pmUUkexc
	r+7svd5e5X0s4C0qvlGhbXGvG3PtTG5U33FRVwIeofJvYyayORYe12ae4HlRX8iYJebnRzj9rP4
	n8mSi1SvOTQaqgB1wElOhl+IirZc=
X-Google-Smtp-Source: AGHT+IHl9MWyyqqXAwU5kSazjmMcg4lRAV9jTa2UtJ7bBQaIRnYiJlygQryzJzcdaKb2SpnpATj/x26imUkBUo3pE6I=
X-Received: by 2002:a17:90b:1d12:b0:2c7:d24b:57f with SMTP id
 98e67ed59e1d1-2cdb9466810mr10808263a91.19.1721956628872; Thu, 25 Jul 2024
 18:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717090126.467511-1-linchengming884@gmail.com> <2024072359-suitcase-statutory-b7e4@gregkh>
In-Reply-To: <2024072359-suitcase-statutory-b7e4@gregkh>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Fri, 26 Jul 2024 09:15:54 +0800
Message-ID: <CAAyq3Sb+D_+F5qX9HQ=EZkhm44RDf4BG4EuzDE6W_R9+Av8j-A@mail.gmail.com>
Subject: Re: [PATCH v5.10.y v2] mtd: spinand: macronix: Add support for serial
 NAND flash
To: Greg KH <greg@kroah.com>
Cc: kunchichiang@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>, 
	stable@vger.kernel.org, Jaime Liao <jaimeliao@mxic.com.tw>, 
	Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Greg KH <greg@kroah.com> =E6=96=BC 2024=E5=B9=B47=E6=9C=8823=E6=97=A5 =E9=
=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:36=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Jul 17, 2024 at 05:01:26PM +0800, Cheng Ming Lin wrote:
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > [ Upstream commit c374839f9b4475173e536d1eaddff45cb481dbdf ]
> >
> > Macronix NAND Flash devices are available in different configurations
> > and densities.
> >
> > MX"35" means SPI NAND
> > MX35"LF"/"UF" , LF means 3V and UF meands 1.8V
> > MX35LF"2G" , 2G means 2Gbits
> > MX35LF2G"E4"/"24"/"14",
> > E4 means internal ECC and Quad I/O(x4)
> > 24 means 8-bit ecc requirement and Quad I/O(x4)
> > 14 means 4-bit ecc requirement and Quad I/O(x4)
> >
> > MX35LF2G14AC is 3V 2Gbit serial NAND flash device
> > (without on-die ECC)
> > https://www.mxic.com.tw/Lists/Datasheet/Attachments/7926/MX35LF2G14AC,%=
203V,%202Gb,%20v1.1.pdf
> >
> > MX35UF4G24AD/MX35UF2G24AD/MX35UF1G24AD is 1.8V 4Gbit serial NAND flash =
device
> > (without on-die ECC)
> > https://www.mxic.com.tw/Lists/Datasheet/Attachments/7980/MX35UF4G24AD,%=
201.8V,%204Gb,%20v0.00.pdf
> >
> > MX35UF4GE4AD/MX35UF2GE4AD/MX35UF1GE4AD are 1.8V 4G/2Gbit serial
> > NAND flash device with 8-bit on-die ECC
> > https://www.mxic.com.tw/Lists/Datasheet/Attachments/7983/MX35UF4GE4AD,%=
201.8V,%204Gb,%20v0.00.pdf
> >
> > MX35UF2GE4AC/MX35UF1GE4AC are 1.8V 2G/1Gbit serial
> > NAND flash device with 8-bit on-die ECC
> > https://www.mxic.com.tw/Lists/Datasheet/Attachments/7974/MX35UF2GE4AC,%=
201.8V,%202Gb,%20v1.0.pdf
> >
> > MX35UF2G14AC/MX35UF1G14AC are 1.8V 2G/1Gbit serial
> > NAND flash device (without on-die ECC)
> > https://www.mxic.com.tw/Lists/Datasheet/Attachments/7931/MX35UF2G14AC,%=
201.8V,%202Gb,%20v1.1.pdf
> >
> > Validated via normal(default) and QUAD mode by read, erase, read back,
> > on Xilinx Zynq PicoZed FPGA board which included Macronix
> > SPI Host(drivers/spi/spi-mxic.c).
> >
> > Cc: stable@vger.kernel.org # 5.10.y
> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > Signed-off-by: Jaime Liao <jaimeliao@mxic.com.tw>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Link: https://lore.kernel.org/linux-mtd/1621475108-22523-1-git-send-ema=
il-jaimeliao@mxic.com.tw
> > ---
> >  drivers/mtd/nand/spi/macronix.c | 110 ++++++++++++++++++++++++++++++++
> >  1 file changed, 110 insertions(+)
>
> This is already in the 5.10.y tree, why are you asking for it to be
> applied again?
>

I accidentally sent the wrong patch, which has already been applied to LTS.
I would like to inquire about the possibility of reverting this patch.

Thank you for your understanding,
and I apologize for any inconvenience caused.

> confused,
>
> greg k-h

Best regards,
Cheng-Ming Lin

