Return-Path: <stable+bounces-76028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE6C977847
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 07:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4879E1F24E81
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 05:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625E3153BE4;
	Fri, 13 Sep 2024 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvUuyRy+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535C4A07;
	Fri, 13 Sep 2024 05:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726205115; cv=none; b=QVEi7qnCrUKC56nAHdGYmrAGqK+QVceSmTu8Gn+fbI7TE5ZFZSPoN9k/D2kuLoGEbiy1mTJWNBee4Rlk4e4T0i40xEkNJiMPI+KbNRqBRmDxG3tQFrEHKMMAHBeZYSIj8vndCAi+/K7jw87ubb/X9Qr8m17En0JlZ/zf1qwXvdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726205115; c=relaxed/simple;
	bh=27gpEokVPxNneEEgKh8PwQgYDDsz/nj+/b0k1NQV3fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDRLRIhzmH7grAHGUiLAX4KD5ORwF02AiIfdEki+mvY2rhjt0xKLS5xRt9ZLB6Ez0mlwMylHlPOLeh7veXISh/M0Kc14lR8TnSiDnuT5XUFN3/INJVP7u4LH967LfWzwKBQ+du17jtB0yFmIuRaNWC/JDw+C4pRCqbTILdGykUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvUuyRy+; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so1541908a12.2;
        Thu, 12 Sep 2024 22:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726205113; x=1726809913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20ZaIfIVSeWUJgDUWvfCEP+VNL9P/nfw/kHDqiLJ47k=;
        b=TvUuyRy+f9eI/nye1+bRS+RR6DSwM7IR1OMssftnp6V6RLHxkfB65gaNbT15dhI3Z0
         1kHlcsdnbZR2p0mGcMgtUZrP2KBWrZEAYD1wLmCvwfbTUwfmFZ/ZMFxeq5PDX6yRGfVT
         wMap1vq+nnnA/7L1JCJ98uU7+zRSZ8TZ8+EnxWZHGZaY7jgmYFElluwF/bgAOb2fYWsU
         IhhCnN6zh71fFn+oGz1evCISMJBaWuI/zFCmxe3wJqZFYp4v8ORZM6QIYeRMb0DafH0h
         76xHU4k0/ktvvif7sdS7jJP3YSrFAtQ8eu//pK5p0yVeeTIt/e6kIkqjoRB1B7/zpDz+
         2jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726205113; x=1726809913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20ZaIfIVSeWUJgDUWvfCEP+VNL9P/nfw/kHDqiLJ47k=;
        b=IWydeHNLVY5VyMNMThuwoYziwaGhPnfbBz5kLGyRCq8StfxRj3JdZAOSy9v0BBeYdJ
         JXvr2sTRzQm0zX6y55Y72OUUcjL/y5fBYzoFnOGx2exKDmGkru8/UtmjSkZtUSzgY8Ng
         gQNW60e6s/1CH/ocFe85p5s3x1GaLy70GeblKKBdDSzPOFcvuvcF1nUT0yzrH6ap0Dbe
         5JWcgrX1C/ycPrFT/kqywWWZfSUNzwlESLvugetvvF1kg1NN7vhVNma5o9qzPbQsPdl1
         PRe/6uJHmwXBYBifegfLbHd1ZRdm19BOD1EukYLUizMiGg7mmhMStjNw4b4wYie6sOJJ
         FDTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHNOikg/j/WkMGacBmxFvH7xnIhzOJKyZlEB9EvMENodFReOiIVcp+IDJeWRyUuaqXX2raGQ29@vger.kernel.org, AJvYcCX4XeXQNYQ5ZGZzGTJE0GPUdQFTrtJoVPYJW99wv5hsAxsjlnvXM6WTvUtb2RihbXi8JzKpsIBDclas@vger.kernel.org, AJvYcCXtWbAoNhJ9IiZO9wjqs3nd7ycAZTktoqqT4vUkkqtrYI+dCDn8JOp/s4nQUAc9TYsTq80Hec1+znijVfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4sURdgkYEPwHquBLiYzKq8gnEKhQ+z9jof6uMFwApYIU4xGcT
	LQpwHXQN2rYjnxCCtHaWRhhEAFiaOExKwUAAzMhIgOCVYjiMHeTcCfzCUDoXjIpM++pKHmsC//E
	z5Rfq+0Iaz90rRrXDhN3alHoDwNc=
X-Google-Smtp-Source: AGHT+IGdVg8q8qvyLIEMHbHsPv/DvSwUDUKj0IRac1OwT3hrcFwNwy5nZqfkXIzxp2oIAKxdmnaUNjMKrxKD5eWTv5Y=
X-Received: by 2002:a17:90a:46cb:b0:2da:5d71:fbc with SMTP id
 98e67ed59e1d1-2db9ffcc71emr6157282a91.16.1726205112882; Thu, 12 Sep 2024
 22:25:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911051716.6572-1-ki.chiang65@gmail.com> <20240911051716.6572-2-ki.chiang65@gmail.com>
 <d222e5b9-7241-46a1-84fe-be2343fa4346@linux.intel.com>
In-Reply-To: <d222e5b9-7241-46a1-84fe-be2343fa4346@linux.intel.com>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Fri, 13 Sep 2024 13:25:06 +0800
Message-ID: <CAHN5xi3UEJJ2aPuF3y0PHoqzb6xhmD+UG3YZyh2Ut_hk0H58gg@mail.gmail.com>
Subject: Re: [PATCH 2/3] xhci: Fix control transfer error on Etron xHCI host
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: gregkh@linuxfoundation.org, mathias.nyman@intel.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the review.

Mathias Nyman <mathias.nyman@linux.intel.com> =E6=96=BC 2024=E5=B9=B49=E6=
=9C=8811=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:05=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On 11.9.2024 8.17, Kuangyi Chiang wrote:
> > Performing a stability stress test on a USB3.0 2.5G ethernet adapter
> > results in errors like this:
> >
> > [   91.441469] r8152 2-3:1.0 eth3: get_registers -71
> > [   91.458659] r8152 2-3:1.0 eth3: get_registers -71
> > [   91.475911] r8152 2-3:1.0 eth3: get_registers -71
> > [   91.493203] r8152 2-3:1.0 eth3: get_registers -71
> > [   91.510421] r8152 2-3:1.0 eth3: get_registers -71
> >
> > The r8152 driver will periodically issue lots of control-IN requests
> > to access the status of ethernet adapter hardware registers during
> > the test.
> >
> > This happens when the xHCI driver enqueue a control TD (which cross
> > over the Link TRB between two ring segments, as shown) in the endpoint
> > zero's transfer ring. Seems the Etron xHCI host can not perform this
> > TD correctly, causing the USB transfer error occurred, maybe the upper
> > driver retry that control-IN request can solve problem, but not all
> > drivers do this.
> >
> > |     |
> > -------
> > | TRB | Setup Stage
> > -------
> > | TRB | Link
> > -------
> > -------
> > | TRB | Data Stage
> > -------
> > | TRB | Status Stage
> > -------
> > |     |
> >
>
> What if the link TRB is between Data and Status stage, does that
> case work normally?

I am not sure, I don't encounter this case, maybe OK.

>
> > To work around this, the xHCI driver should enqueue a No Op TRB if
> > next available TRB is the Link TRB in the ring segment, this can
> > prevent the Setup and Data Stage TRB to be breaked by the Link TRB.
>
> There are some hosts that need the 'Chain' bit set in the Link TRB,
> does that work in this case?

No, it doesn't work. It seems to be a hardware issue.

>
> Thanks
> Mathias
>

Thanks,
Kuangyi Chiang

