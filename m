Return-Path: <stable+bounces-114416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB65A2D895
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 21:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E164165ACB
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 20:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C970819DF75;
	Sat,  8 Feb 2025 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWKb3g21"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20C9243977;
	Sat,  8 Feb 2025 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739046566; cv=none; b=RaXoha/tv3yug+7tKVeQ9J3QZHvWu1NBSjnWingVVDk+x69kGmP1zl2E0rdRIeuYP24igD3YURxipUXoEUgWbAKdC29pANRmcK4FCQeJAhV+66lSRv6SqM82Wq97r6QnlptxmpcVypg8gPiCY0sDu+cEdJSM0+I8XKPKjwnCRw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739046566; c=relaxed/simple;
	bh=BuFfrICehAmNqMElVl1sQBfRxyGCnMePVyif3AQO10A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2MNhTGaBS34Vi/hRPgohnknmo7i5ey/5ULf5WxCO8CwTmY2n3G+izxzGNw7s3D2SP0pHmh1SpNW0jFJCMxysuYheep8PQgyadvhwUa32o57Kh2SUS3wrxdfVB4rsVf5eikkSpWkwfW2hEbWrvndoSmtHCIzrXpC9TVMiYjXVoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWKb3g21; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43618283dedso30651915e9.3;
        Sat, 08 Feb 2025 12:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739046563; x=1739651363; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fzNGhud87Y2IUxbA6ZwO4Q5SM3UBCTZy/XSQtgk0BSY=;
        b=XWKb3g21w+B2jVbD6cBcND1KRBYBPVlNSX3o8cvtf+3b35ZxNuc3U6VApF6CxEG54Y
         Ka4X3c6w9LKFu3xLXM4juxdxQ/b/GssXZOoDiGLq6NWWULUP06tHVp13SalhvK9ie4bF
         vk9yY5qRxrzVECzgySHZBlZ79H0uJi0usSVPWUqGPMBCWyBskWxpfzlE1fUxAPjW2zfK
         pvwotCP8fUy7DrfUpzvgtn2yj4khqnEMry8eFNeldP/mF8eKdrfPS2BVLkL/g6QQ5CrH
         2url+Hhd64S7p9V/p0BoFVEuvMzE2ff8DtyPX2czGE+Pkd0RsOz00BV7+r1/fUclx7r7
         iRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739046563; x=1739651363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzNGhud87Y2IUxbA6ZwO4Q5SM3UBCTZy/XSQtgk0BSY=;
        b=DeNaO2URRL8arwh9I8+2DvhXGV4k2OgzP9sVtqMhH4wobL8hcmhASeZJfIWKGD8gX2
         a2NNnb0LZuQp2viHdsYV1WnA9T+aDasTxtDoQVph6ox0WXHwzr+sMVMh/AQU0OThJwvm
         3Xvi+WIZdjD67u2eNxHW6NdZsCt1aEZ4C0BCR2ukLOHZEe8WyZK1RVKNT4T9H4MT4fna
         eI0rX8Vx5J/vqggSvj+jsXzAMiQ+cJ19XMuUXOXU45JT8nHyNjUvlDScRctMhRH4vO3c
         Y/7WR3jQCxriRw9Ghq/R1TdqjScrc5noAlpA5EyS5w2Gubjl7Dn0gUjxfwTX9uetzZGu
         q+7w==
X-Forwarded-Encrypted: i=1; AJvYcCVDQH6XA/hQ734gxyE7n6NjiOPHcMCtYSUBdOHcnR+O/TDcWMMS/kqE/XflF6UKhiYO8saTUefJHoM=@vger.kernel.org, AJvYcCWm+cYNmJdLmyX2fDzHHVQrg/qFt+noplJ4iupFqpze5ZeIGh47n+OsECqITwvFtUmDge6W8Atd@vger.kernel.org, AJvYcCX8u6ck2dGRt3WTHHEe7DhixxjdTwSDZkUFE++30WMK/M+nDfegB7BMQiGpsmZQBlkcz0O32bh2@vger.kernel.org
X-Gm-Message-State: AOJu0YwuwS+IHcg40d+0cc5GX8Qfuk1KKzfb1cK5Cap9Fygis+ypEL6J
	7zzwHDC98oG1zOqVmuMzh5wkGFvEzJtMDxbYl+PywpAjNc/FeI5iq/deOpV4p5cOwbdk7vJxXxp
	qU37AH6dqZsPNJdXd62wYJAYJtSY=
X-Gm-Gg: ASbGnctSP+Gi7e496WmrcHu3OtP6QYaE+R1r6mUqbPZRyC/nNtQz2C2hhTqatmq66uI
	nZl52P//7BIZTx7oIWZ2unLo1W3OyYCqd2sy15Mox/U7ZbIMvD11kVw8cg7aB0q8em2YR42bG
X-Google-Smtp-Source: AGHT+IHbfZ/veQuDAAt6CNQEESnDTJIDuxBcmoHU15JJsQfV7sbWPF62N9+BtZdCDfINotFN+GYVEmAc67VS4G8a//E=
X-Received: by 2002:a5d:6dae:0:b0:38d:b997:12ef with SMTP id
 ffacd0b85a97d-38dc8db15b5mr5921081f8f.13.1739046562575; Sat, 08 Feb 2025
 12:29:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205171649.618162-1-fabio.porcedda@gmail.com> <20250205171649.618162-2-fabio.porcedda@gmail.com>
In-Reply-To: <20250205171649.618162-2-fabio.porcedda@gmail.com>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Sat, 8 Feb 2025 21:29:11 +0100
X-Gm-Features: AWEUYZlLzmbHXb4Dl-s6G3wlGborZ5GbL9nFzxxQewxFZaH1ov7dLfGkYIAdEFc
Message-ID: <CAGRyCJFE3Gzs+tBrKA+PjXgmFfmZ9=6eOrr4VS6JMCsAPi8F-w@mail.gmail.com>
Subject: Re: [PATCH 1/5] USB: serial: option: add Telit Cinterion FN990B compositions
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
	Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno mer 5 feb 2025 alle ore 18:16 Fabio Porcedda
<fabio.porcedda@gmail.com> ha scritto:
>
> Add the following Telit Cinterion FN990B40 compositions:
>
> 0x10d0: rmnet + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
>         tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 17 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=10d0 Rev=05.15
> S:  Manufacturer=Telit Cinterion
> S:  Product=FN990
> S:  SerialNumber=43b38f19
> C:  #Ifs= 9 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 6 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
> E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
> E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>
> 0x10d1: MBIM + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
>         tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 16 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=10d1 Rev=05.15
> S:  Manufacturer=Telit Cinterion
> S:  Product=FN990
> S:  SerialNumber=43b38f19
> C:  #Ifs=10 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
> E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
> E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 8 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
> E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>
> 0x10d2: RNDIS + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
>         tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 18 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=10d2 Rev=05.15
> S:  Manufacturer=Telit Cinterion
> S:  Product=FN990
> S:  SerialNumber=43b38f19
> C:  #Ifs=10 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=rndis_host
> E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
> E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 8 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
> E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>
> 0x10d3: ECM + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
>         tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 20 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=10d3 Rev=05.15
> S:  Manufacturer=Telit Cinterion
> S:  Product=FN990
> S:  SerialNumber=43b38f19
> C:  #Ifs=10 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
> E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
> E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 8 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
> E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>

Reviewed-by: Daniele Palmas <dnlplm@gmail.com>

