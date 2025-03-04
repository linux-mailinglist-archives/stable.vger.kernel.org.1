Return-Path: <stable+bounces-120215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D2AA4D72D
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 10:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311A1170CC5
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 09:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6221FCD14;
	Tue,  4 Mar 2025 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjMfCPes"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA391FCCE1;
	Tue,  4 Mar 2025 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078585; cv=none; b=R5sHEWvXvpQceAUKb6Qhknm/rDV813yso+sz0VBfmcEwp4ngkYQDYe7y2mN7H0MS5CbCN3DdNpnySOD+nTtQSoPp1hgcrWlNv1k/tG8UGHQMkInIf90zuhPWoe/f7UaPXHs7pqzLC7P6tHPwpvagrskG6Yq+C6hMNEPisFFCjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078585; c=relaxed/simple;
	bh=CKZjE7gvecQipQZqqiZnA9aoDs4C1xYCOndRlXHrRs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oxo5Dt0XrbvwLYnkvaLQzJVgH1KXMfqxApAEpWUuxr6wIvi3W/cqeniHLXR7+qkkoY0LkSlWVgqrTXIuiQYXHsun3K7waLX3r7v7VFymVQZ7+KyFhSLArqHUOoE0cRfr6O2NEV1l/a3SOePvwukYAzSsB/2n3jpgvUC7qVM4RE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjMfCPes; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so36423385e9.0;
        Tue, 04 Mar 2025 00:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741078582; x=1741683382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DAA2oCjQsJ1OwAYpA2lDIDXoY4yqv0B3otPmLFsbx0U=;
        b=kjMfCPesTjp2XmxGeeRnyY3j7JbZP15GTU/PEtHD7i7gSogevrZyvL1+sEcLwAWiVw
         NpmjRCDeaXarYsmTvRiscsz73CLJFv/ROiatKKyw5jCkbaFNYIkLeSQKegWcLeRrz1LI
         k5JztGDafFhIAV0w96arUc2tTEvSkw8w5lf2GcWN8XH6ZuSbkfFOJrD6oSGYTiYpeDYn
         JyyrTpOFBTc8i+H9DxRVib1yF0y1SHrL92t1PD/rntegxGpByZCDbbdDTi7j32U0pwdv
         GO1I/2O5NG8DH1Y/gah1UIWCebykNcOtOCKfZt3fykMrw74h2H6APqMExWgE6ZtSyKvB
         foEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741078582; x=1741683382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAA2oCjQsJ1OwAYpA2lDIDXoY4yqv0B3otPmLFsbx0U=;
        b=pnAsdxdtzO2jBSyLtySVrX7Cv4WCfNXDaQz1qFINKMqGG4dhJCzscqmxXm+YvSBjgO
         p9Y/1moV3+UdczwQeCp2S/Eb1uFFgqrP73LdyYIt6TK7FUyyjnyHeHAnj9YwyF4lPE+A
         WGYkvfTgxH0RaSdL89I0a/HZs9dTDtmsTt7U3qeH55aJDhGQmr5hizF3KfU390JGME+S
         if2ZWZr0vxm2xRDbjaSw/8D+BYCc44XAJDxVmkupUfff/otunCYbxEofn8/B1OnK2x/V
         JpamVst5nmrx2LsY+Zv6z5DlfBTVHnc52DxGVW4l78gFYHjNNszOs+mVsPW46do3nrER
         tDrg==
X-Forwarded-Encrypted: i=1; AJvYcCWGdNzHiX0dZ22d11dJdRDSLsTB6NSBcwT8TRX3arjWnTB94RrWbRLszhKWy+OeIXEtNmTQxUS162A=@vger.kernel.org, AJvYcCXKxBf1JsrJ0bEdzn7mfn0q9IJHNNIxjyWGLrHg+A+kd27yqp6vXx/knn0Z13cocPDdnpa9dy2j@vger.kernel.org
X-Gm-Message-State: AOJu0Yzreag6/rEdSvxO/lSVO6a3tR5IBn9MsDic8v0Warbbi/3CpuV+
	2UHvTZZYoXAsG2i1YBGsIEOy5XrmafJ1a5cMjTxJsMvjyROLU37un94qakdc0qB/OwB2kuh5F4C
	ydAoulwHWo3Vbf8+NGqw4QB1DjAi7tA==
X-Gm-Gg: ASbGncuuJtYsaAWtrHsGw2f66CyuRoPqk96DP/uHTiM5po5+5cgy8SmWrZDUjvlmDBq
	PSgbjdMEoj44DY4ULhdxsAyGaBuwgjui5B3dSo8Iz3Yhf86ulD17eLFuAhsKZeOD9aI8/2VZrXy
	QjC3kVMs6S+AJXEX/XMCeryE0=
X-Google-Smtp-Source: AGHT+IEnW1inA27GX3wFgboQot/mXHUu8anzP9in5jqax7e5IX5G3fN1dviSykISTAgPnjpv8RTuD6aByLghfmXxDYU=
X-Received: by 2002:a05:600c:a01:b0:439:8a44:1e65 with SMTP id
 5b1f17b1804b1-43ba66e67b6mr142415755e9.7.1741078581640; Tue, 04 Mar 2025
 00:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227110655.3647028-1-fabio.porcedda@gmail.com> <20250227110655.3647028-2-fabio.porcedda@gmail.com>
In-Reply-To: <20250227110655.3647028-2-fabio.porcedda@gmail.com>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Tue, 4 Mar 2025 09:48:09 +0100
X-Gm-Features: AQ5f1JpLB9S1xGnltoHO4k82_F-dyrAiTpScweTXS6RXBzE_NvpZf32xPvOudkU
Message-ID: <CAGRyCJFA4zjYt-h7nDkL9VAfe3=TN9MytrmwU4bpLUTHWjnTmw@mail.gmail.com>
Subject: Re: [PATCH 1/2] USB: serial: option: add Telit Cinterion FE990B compositions
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Fabio,

Il giorno gio 27 feb 2025 alle ore 12:08 Fabio Porcedda
<fabio.porcedda@gmail.com> ha scritto:
>
> Add the following Telit Cinterion FE990B40 compositions:
>
> 0x10b0: rmnet + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
>         tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  7 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=10b0 Rev=05.15
> S:  Manufacturer=Telit Cinterion
> S:  Product=FE990
> S:  SerialNumber=28c2595e
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
> I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>
> 0x10b1: MBIM + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
>         tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  8 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=10b1 Rev=05.15
> S:  Manufacturer=Telit Cinterion
> S:  Product=FE990
> S:  SerialNumber=28c2595e
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
> I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>
> 0x10b2: RNDIS + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
>         tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  9 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=10b2 Rev=05.15
> S:  Manufacturer=Telit Cinterion
> S:  Product=FE990
> S:  SerialNumber=28c2595e
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
> I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>
> 0x10d3: ECM + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
>         tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb

Shouldn't this be 0x10b3 ?

The rest looks good to me.

Regards,
Daniele

> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 11 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=10b3 Rev=05.15
> S:  Manufacturer=Telit Cinterion
> S:  Product=FE990
> S:  SerialNumber=28c2595e
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
> I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
>  drivers/usb/serial/option.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 58bd54e8c483..8660f7a89b01 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -1388,6 +1388,22 @@ static const struct usb_device_id option_ids[] = {
>           .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
>         { USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),    /* Telit FN920C04 (MBIM) */
>           .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
> +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b0, 0x60) },       /* Telit FE990B (rmnet) */
> +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b0, 0x40) },
> +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b0, 0x30),
> +         .driver_info = NCTRL(5) },
> +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b1, 0x60) },       /* Telit FE990B (MBIM) */
> +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b1, 0x40) },
> +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b1, 0x30),
> +         .driver_info = NCTRL(6) },
> +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b2, 0x60) },       /* Telit FE990B (RNDIS) */
> +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b2, 0x40) },
> +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b2, 0x30),
> +         .driver_info = NCTRL(6) },
> +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b3, 0x60) },       /* Telit FE990B (ECM) */
> +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b3, 0x40) },
> +       { USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10b3, 0x30),
> +         .driver_info = NCTRL(6) },
>         { USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c0, 0xff),    /* Telit FE910C04 (rmnet) */
>           .driver_info = RSVD(0) | NCTRL(3) },
>         { USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c4, 0xff),    /* Telit FE910C04 (rmnet) */
> --
> 2.48.1
>

