Return-Path: <stable+bounces-120222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB06A4D8F1
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 10:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9FBA7A8593
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 09:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062811FCFEE;
	Tue,  4 Mar 2025 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di+IuFYJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC38E1FBC86;
	Tue,  4 Mar 2025 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081307; cv=none; b=YbLVkrqbpWtMke3i7CmhYImCWYfLy3OU0BDVr/dXN518H2ox8qM6uJKia39csZM8wb47iGunmrU/LEaLcYgWtPgQkhyDFGcioe2+bN3OCkSvfLf8NORljaLTbaZ+ssPnRPCwrkwuNGqU4zlQXv8bWR7kXM3mHlzXe049Mp9CYBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081307; c=relaxed/simple;
	bh=xqsWT290M08CL9TfqmTijnS7u9W7Ls3lecKi2A/4lc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bguHbPJQpu0AvvwnwHx/Wp4YgtWuA6Vn4MnJJSVqNItVVJvMpia3TseIWb08Lh7eVqIp8IW1plw9p5pjOz0OrmtK1p/6RVMZ7WOkD+IzAM/nfMRPEU7GBIgglxTLrt/vPZOiu2giUD1cnTAUBEPI2FPw8Y+dHgTSIxGOUx6CqAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=di+IuFYJ; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3cfc8772469so21017825ab.3;
        Tue, 04 Mar 2025 01:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741081305; x=1741686105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KqJ6is3klbnHIEdUEP9fSmANqPzhnkKCP/eVyghMXgI=;
        b=di+IuFYJLFL1t8zxn71NpZO+IyFSdI1p/WyVWCn2DlqatquNHMPpoxdLVhQmQ0DAKE
         lD5lJW6bjfJ/YNbIRUHuJDKLyaU595yOb2zUxy+BEC6jqYOCm1rGtMIjqZtFifqVE+OF
         YlmeramS862E/IibfyizNRyUFmHgj7Ed+SdKulZ27gmDyUhXXHP8XDIgC9P7fVn5R9kC
         X+y8U1lQHIqP9T95cFCAhrhpgb6jViJ3p/YzxyxO6yNYB8ic+EL6dvjLBScHgCC7AgNn
         3qD2ohWphVZFQILUbKq8yXh8zJzqP96qWJv+JcILUqcmhDYpht5fJ4ifaw3QVuVCuQlT
         RT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081305; x=1741686105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqJ6is3klbnHIEdUEP9fSmANqPzhnkKCP/eVyghMXgI=;
        b=D1s1Lyqg8BBiE9+H0UvYzLvoxFVbJn/6ORhWM+x/CRmBw41BCMrHgPuXIigq17e95e
         rGsQ8ADIkEM/3RQe8wFHPzSGKORIejV78xDguJBdR+tTgKx0lmkk6e9jdTlAUnkcR0U3
         PvxQpx6nGWILNkzQoM2BABsI0nXiYKvwwFuVEGLj0eDuwAtP5ag+0i/VgrCVGGTaCVzI
         RGGWdr9F11WE7B5KAhOcLAK+S6izRRwFgq1eAyFX2ltbhd2l2kBHA9mWG4/+2YMRMwTp
         f3RXwHVCPiEsATcDacY/15qxskvmdy1E+wh10cDdCFrW5QXUdDX9ZJ/q0Q5uFhxyjq6e
         w9wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVBDyhA+/FCjzPnWQ0kKnVcGP5GU83Ds5PTNG9F2iGzfk1Ktg99UCSnh3lHdyARVSn+hccUCNREpE=@vger.kernel.org, AJvYcCWSN56m6H5iBqqWbaX4G+rz6KN40HEDn43RbimfN9ogQyKVl2iVFAd/Gi3lPxUqAnmSrcRhYXG1@vger.kernel.org
X-Gm-Message-State: AOJu0YxLsqpD5L0IhCGDZFUYJBqlhvA5Jb44dgBevF5Ux64K8YK+E1MK
	rYuXfgyl3MK/EiAICayZkO08Qx3f1Zg5pQIkDmEc1mKFqChhCODppEVAcrmpDY2z19o9T+G54KQ
	dOQHihRdjXrVxzO8JpmR89XBzWbk=
X-Gm-Gg: ASbGncsNqwu53pYV8PQ6TqaUZjqQog0bEIxAlkbslMAhEte4hMxfTmxYcYdDghrOlFY
	q+qyaObdCqlnN+T4jcp1At+vNPztEstnM1OQ38WxdqgSgJenZp4t8FJ/TtURrcH//aXkkre7TDb
	gFYE0HkTcAqoZPEn+Mjxg+MHA=
X-Google-Smtp-Source: AGHT+IE3vdkxSYK6KG6AlDmGhqqyxgbOen/huKO+dya/8FMZzvG7nz/UTG3zZUqejoq0sXfKfmKnYrPYB+urr7dSZ9I=
X-Received: by 2002:a05:6e02:180d:b0:3d3:dcc4:a58e with SMTP id
 e9e14a558f8ab-3d3e6e42ed7mr174490545ab.8.1741081304527; Tue, 04 Mar 2025
 01:41:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227110655.3647028-1-fabio.porcedda@gmail.com>
 <20250227110655.3647028-2-fabio.porcedda@gmail.com> <CAGRyCJFA4zjYt-h7nDkL9VAfe3=TN9MytrmwU4bpLUTHWjnTmw@mail.gmail.com>
In-Reply-To: <CAGRyCJFA4zjYt-h7nDkL9VAfe3=TN9MytrmwU4bpLUTHWjnTmw@mail.gmail.com>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Tue, 4 Mar 2025 10:41:08 +0100
X-Gm-Features: AQ5f1JoPigUuY2YaIfAghDvy-dVFZz80kG8UizUYWIDTSqYBcEdBhtdgfh-Ot2c
Message-ID: <CAHkwnC8p+3ZYPzPwarW4yzqczKOOZN0URKz_qwL=0fr1tyxgxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] USB: serial: option: add Telit Cinterion FE990B compositions
To: Daniele Palmas <dnlplm@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno mar 4 mar 2025 alle ore 09:56 Daniele Palmas
<dnlplm@gmail.com> ha scritto:
>
> Hello Fabio,
>
> Il giorno gio 27 feb 2025 alle ore 12:08 Fabio Porcedda
> <fabio.porcedda@gmail.com> ha scritto:
> >
> > Add the following Telit Cinterion FE990B40 compositions:
> >
> > 0x10b0: rmnet + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
> >         tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
> > T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  7 Spd=480  MxCh= 0
> > D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> > P:  Vendor=1bc7 ProdID=10b0 Rev=05.15
> > S:  Manufacturer=Telit Cinterion
> > S:  Product=FE990
> > S:  SerialNumber=28c2595e
> > C:  #Ifs= 9 Cfg#= 1 Atr=e0 MxPwr=500mA
> > I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
> > E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> > I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> > E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> > E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> > E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> > E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> > E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 6 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
> > E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
> > E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> > E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> >
> > 0x10b1: MBIM + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
> >         tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
> > T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  8 Spd=480  MxCh= 0
> > D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> > P:  Vendor=1bc7 ProdID=10b1 Rev=05.15
> > S:  Manufacturer=Telit Cinterion
> > S:  Product=FE990
> > S:  SerialNumber=28c2595e
> > C:  #Ifs=10 Cfg#= 1 Atr=e0 MxPwr=500mA
> > I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
> > E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
> > I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> > E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> > E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> > E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> > E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> > E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> > E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
> > E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 8 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
> > E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> > E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> >
> > 0x10b2: RNDIS + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
> >         tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
> > T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  9 Spd=480  MxCh= 0
> > D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> > P:  Vendor=1bc7 ProdID=10b2 Rev=05.15
> > S:  Manufacturer=Telit Cinterion
> > S:  Product=FE990
> > S:  SerialNumber=28c2595e
> > C:  #Ifs=10 Cfg#= 1 Atr=e0 MxPwr=500mA
> > I:  If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=rndis_host
> > E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> > I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
> > E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> > E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> > E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> > E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> > E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> > E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
> > E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 8 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
> > E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> > E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> >
> > 0x10d3: ECM + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
> >         tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
>
> Shouldn't this be 0x10b3 ?

Yes, I've sent a v2 to fix it.

Thanks,
Fabio

> The rest looks good to me.
>
> Regards,
> Daniele
>
> > T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 11 Spd=480  MxCh= 0
> > D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> > P:  Vendor=1bc7 ProdID=10b3 Rev=05.15
> > S:  Manufacturer=Telit Cinterion
> > S:  Product=FE990
> > S:  SerialNumber=28c2595e
> > C:  #Ifs=10 Cfg#= 1 Atr=e0 MxPwr=500mA
> > I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
> > E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
> > I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> > E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> > E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> > E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> > E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> > E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> > I:  If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> > E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
> > E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 8 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
> > E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> > E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> > ---
> >  drivers/usb/serial/option.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> > index 58bd54e8c483..8660f7a89b01 100644
> > --- a/drivers/usb/serial/option.c
> > +++ b/drivers/usb/serial/option.c
> > @@ -1388,6 +1388,22 @@ static const struct usb_device_id option_ids[] = {
> >           .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
> >         { USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),    /* Telit FN920C04 (MBIM) */
> >           .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
> > +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b0, 0x60) },       /* Telit FE990B (rmnet) */
> > +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b0, 0x40) },
> > +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b0, 0x30),
> > +         .driver_info = NCTRL(5) },
> > +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b1, 0x60) },       /* Telit FE990B (MBIM) */
> > +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b1, 0x40) },
> > +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b1, 0x30),
> > +         .driver_info = NCTRL(6) },
> > +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b2, 0x60) },       /* Telit FE990B (RNDIS) */
> > +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b2, 0x40) },
> > +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b2, 0x30),
> > +         .driver_info = NCTRL(6) },
> > +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b3, 0x60) },       /* Telit FE990B (ECM) */
> > +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b3, 0x40) },
> > +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b3, 0x30),
> > +         .driver_info = NCTRL(6) },
> >         { USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c0, 0xff),    /* Telit FE910C04 (rmnet) */
> >           .driver_info = RSVD(0) | NCTRL(3) },
> >         { USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c4, 0xff),    /* Telit FE910C04 (rmnet) */
> > --
> > 2.48.1
> >



-- 
Fabio Porcedda

