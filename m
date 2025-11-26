Return-Path: <stable+bounces-197025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA03C8A565
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 15:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACD33A96EF
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00573019A5;
	Wed, 26 Nov 2025 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7i3MhBg"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F63016E5
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167409; cv=none; b=mPSChvz/3rHHJ4LdDrVUVHPcJxxxwdOgUYAfsTZYndB2IF4J2vuwD19YNcczVtDtblbV7M1Wot/8w/M1dLGpwzd+b++HBXRA5z955dXhSHWRcqpVq9BH5cUavvGqeLYlONHkaZ+eTq3VeXBwwUChiXc31/AGBt1kaEzq6QSa7EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167409; c=relaxed/simple;
	bh=2pJ8SnmV70c+TMFli5Ai5Or6jf+BdtWDQjxtNl+Bhik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mas1kQyyZPPEiz8+05nn5iNW9y16yEhPS/ITHaKq+ePh/rvajJi+P5MHO6EeLROTRyLtqrDbIMBqLKaIBHpofwJtMMJsf12Cf8d+xoSFZb19h4QE6lzu0XE4+Z0N2kbw9c409YDRoqaA/LDceV58pFO+AA1hR7tPHPBR4O7WY8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7i3MhBg; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-4330ef18d8aso27961895ab.0
        for <stable@vger.kernel.org>; Wed, 26 Nov 2025 06:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764167407; x=1764772207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=seO8yROLj7+TZ5tQvNyKxgoZe2H0UiNB/Mluvl0b8gg=;
        b=g7i3MhBg2psGfy9kveSSJjSwAcmPCaQS2+0faaif/frBkylT4xcSCeJ0mUl/tMHUAI
         MVnsU1gjwNUmWPUnfr5KxlXPS/cSEE5fUDLb+WIYXTI9CcTldOkATKulWKxhODjMFikL
         3oxDlmP4sh3I9g5Bsi6GuDTXT9LulpI32D0TTD3/nPRXVwU1D5EP7rUb6kigEXlXYVws
         3abvOxhFX9lKMaj/b+G8XArKrWSTsoZRmWz/BlNlwR5Wv7m0OBxfLxJGIYh48DigYfxw
         2XvCqLzR/8YUIqt+oXUI81eyvWavCdKTNcLtw1fXXKoyy8xf0RMqkDBtChntPIPd7sYq
         4qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764167407; x=1764772207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seO8yROLj7+TZ5tQvNyKxgoZe2H0UiNB/Mluvl0b8gg=;
        b=CpKFwrC/wyUBr+qFMv6WZtEcJEtzFqTLyVw1uwGnh3IwXxYoYWf7+cafIBD68ViLiq
         jsDxm/FOf1MOv4KaYCjGF531xtoQ/lzjH3p4HwC2+W+LvT6fdSG6ixC+IZYX4ope+uun
         C2eBtCV2mU604C5n75fHnW7zJL1zvDzqe//9yNdg6TM0RP2AaMsD12PYrOu4Tw04+B/1
         6VAe4a1YsatH+NHyXujR3KbQDLO3xvBCNVNXaTMwskoY5rz2E4mRFnIJWbKSO2s6IXmT
         jF7e1TwYNWcuZTExwjx+TcThnve0BwAbQIsn+hzBcRZcOZPJrk0mZBGrZKAjYfQ7U4/W
         PMyg==
X-Forwarded-Encrypted: i=1; AJvYcCVJinmpAcHEhxzF8fMVGrQUADFq4oAl1+GJh+SmQD02qweDgkLmDxhKl5hq+40DQq0LzzCNBFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFfWVKJJNUGRVJLg+E8S8+ytxaEPad2TRGDthI4foG4sB62/hL
	IUsrJY5rfNKn1QWsBIlJBzEZZDlUWRnj5jB19+e2JozzLfE61my4QZ3Nv7da8vq2PTqUwm/Hl2s
	j8/gJyskEV0eihBTV+Q29kzN0+7bHEOQ=
X-Gm-Gg: ASbGncsAbMEmG4UWreYcwXpb0QCqf9sxHMI7dO3zHW6qgI4YWPMIgVmHYkq9ML2IAxq
	FkNqRHqKcAQI8RWMtBUUr0mVaVBxNCjgJGU3VgT2h6PIv9hQfJKL30nYMPEqabxpKhilRnW4pI9
	3LYl5RoDBpxYBnLx4zRSGW2QoO6MhH05ZAFzRwkEMDJ/r73NTYW4H+JyTEP/khjUS53UphWASsN
	XAG+csEdFAJif7OXa9tU5T63Zol1qbs6RR7UMWJbNvXTFQYnnjyOjLMUa7DRD/Sv5Fm8nwexDh+
	9hrpM8fxFUD6kk4plD5/1h4f6I9i5Oq5hQeDXPuik8LbNYicVis7cBDe4fatN9KXZPuv3JlOr60
	gAVCiI2tIbw==
X-Google-Smtp-Source: AGHT+IHI+ciJMg8aOEmbinYOstECuLA/3e/GbhhxuQDC0jNUfW/cZYRBveEzZd49KPLKgKjlVCV1OzfTn5p9FH9IaHE=
X-Received: by 2002:a05:6e02:339d:b0:434:96ea:ff63 with SMTP id
 e9e14a558f8ab-435b8e8d1a5mr135813675ab.36.1764167406387; Wed, 26 Nov 2025
 06:30:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764084304.git.fabio.porcedda@gmail.com>
 <3ef9bdaa5f76595d0a39b8fc1b1cebe29f69709c.1764084304.git.fabio.porcedda@gmail.com>
 <aSXYlqai4Q7CQCT5@hovoldconsulting.com>
In-Reply-To: <aSXYlqai4Q7CQCT5@hovoldconsulting.com>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Wed, 26 Nov 2025 15:29:29 +0100
X-Gm-Features: AWmQ_blNhKP_6sO0bZW5lfxCRF6g4woCI0YryHrKyhNpFuDdmIMbwQ5pq7XOigs
Message-ID: <CAHkwnC-Hurh1gp2_apb2yMGMQopBPsPt_-Pc+0eKS3QeXGWQMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] USB: serial: option: add Telit Cinterion FE910C04
 new compositions
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	Daniele Palmas <dnlplm@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno mar 25 nov 2025 alle ore 17:25 Johan Hovold
<johan@kernel.org> ha scritto:
>
> On Tue, Nov 25, 2025 at 04:27:33PM +0100, Fabio Porcedda wrote:
> > Add the following Telit Cinterion new compositions:
>
> > 0x10cb: RNDIS + tty (AT) + tty (diag) + DPL (Data Packet Logging) + adb
> > T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh=16
> > D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
> > P:  Vendor=1d6b ProdID=0002 Rev=06.18
> > S:  Manufacturer=Linux 6.18.0-rc3-usb+ xhci-hcd
> > S:  Product=xHCI Host Controller
> > S:  SerialNumber=0000:00:14.0
> > C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
> > I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> > E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms
> >
> > T:  Bus=01 Lev=01 Prnt=01 Port=11 Cnt=01 Dev#=  7 Spd=1.5 MxCh= 0
> > D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> > P:  Vendor=413c ProdID=2003 Rev=03.01
> > S:  Manufacturer=Dell
> > S:  Product=Dell USB Keyboard
> > C:  #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=70mA
> > I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
> > E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=24ms
> >
> > T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=10000 MxCh=10
> > D:  Ver= 3.10 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
> > P:  Vendor=1d6b ProdID=0003 Rev=06.18
> > S:  Manufacturer=Linux 6.18.0-rc3-usb+ xhci-hcd
> > S:  Product=xHCI Host Controller
> > S:  SerialNumber=0000:00:14.0
> > C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
> > I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> > E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms
>
> Looks like something went wrong when you generated the usb-devices
> output for the above composition.

I've sent an updated one.

Thanks

> Johan

Best regards
-- 
Fabio Porcedda

