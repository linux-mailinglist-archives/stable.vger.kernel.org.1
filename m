Return-Path: <stable+bounces-121407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0545BA56C76
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 16:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4339F3B17B4
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD55204C0E;
	Fri,  7 Mar 2025 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StclEmU6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0821CA1A;
	Fri,  7 Mar 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362348; cv=none; b=YjFZnmsjXd9wp/7zB1j3ClBzGrmrH9DYilQ+ta2HjXttMaGO7HFQ31K5FozzSBerCECBVZHKZR0d7g4XSeK1RuRfOG6UvZ7Dc9qRNpGHuUJ4ukbx3Jb/W/V7vENn/908B1U2pxHCLx02+K8u09+VZtcBftLVsBT49zUArkmOsy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362348; c=relaxed/simple;
	bh=ZpBOqPvPpg4k+GwFKkbvTJnOE4LZ2+Rh5edulRy7JRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cf1HwSF4NjLnzWEULcliKrH6UaA9cO77WZn2jM05DhkuyC4FsYVI46KVF2Cm5gdto9mjUJFQl1Yb9o5a/O977ABr5Nt9flikhhS6E+DGi3AwriRNpN7VVQe2r5JkEY/ykV6ly/WNMl0MbSI3tj0o7odYKiYIHF/aOxG7AJmCids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StclEmU6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso404154866b.3;
        Fri, 07 Mar 2025 07:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741362344; x=1741967144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cTClkgx+OHCu7CHEL4QgdX7j7z63TsB2DtVNGQ6gRoQ=;
        b=StclEmU62JCYl6gd7ULS5RX83XPi68TKRBqRVgyXQjY1GW4vcuux+Y+sv4UZa+k8lp
         7fH1ysDHk4vUr5SlhaW02L3WrKS5tXpcFayE57EIfVua16Ye/g2n1S0NEPP0bKX9dO7T
         GWTxsUXLH0ZNi3X5glE19+PnvqRk24aCUERXVDNq8VZ/O23sa1JgkmKkqpKSiS/JhMHU
         CEbMAaPQkd4prQOL4vLPway149aktYcd3QLmh/0PRKna3QQTlbWK2U39pf0fNOcaNPw8
         FyUcn1Pp99UFeMvsqx7Vvzsd2kCST7qjkC+5ztWxa8SlMEkIbI6VAiGjabFJG84HG1wz
         V+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362344; x=1741967144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTClkgx+OHCu7CHEL4QgdX7j7z63TsB2DtVNGQ6gRoQ=;
        b=VNVsApru0TYThRY9VS8av9bso4xFADAlHozw9MINhXPnmZz7ahshYjcLHVJiXo1Nn9
         aJXCpVk6zLWkhg2WMZByxE0allYfW72L/YtrOhytDu72pXPPXSccn224WHvPrRmiB/kG
         MV9hRBi2gq5FvdVccNOj12IHv0UTx+nHDivXVXF471ZD2nSOWKbuIAkmWhSkfAisAHd+
         5yqWzcCH4Ek8gFJ72LrvBNWZtU1C6uUqiswDGABPn23p/wiU4opwecXlUFA2YKUhTr3A
         kvGdU5mq+aodeHrCIllzAz3ZqbT1NfNTnUssxTT63Z1oWofPUWHMUn8/Gy2ttvXwugV6
         J6Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVU2hEvKy7RqMmrKhMFj0xV7XEVOoWOVCFUTkOo4az8eAZeUNy/YGjw87RmOJVjuItL5Euek+V+vHnn2Ws=@vger.kernel.org, AJvYcCVrIxro871RqiK+p7dO1czDnUOSjQ6xCAiR1S0hPF2oSaQz8V+7KxYubgJaTzMYMKQq4eA3ObSt@vger.kernel.org
X-Gm-Message-State: AOJu0YwbHWVsl5vVFFeHuh7q7ygOngYXB1QqqAMAdcMWO8/4gJfX8n5M
	89/L/xbQ4WtII9YZCXOt5lry/SmAQ7VhBUcngY6lTJJa6CWF/vg2DllmFOi1H8ieDCTA5tz7NSY
	oSNZMr9VBMGjXJuGePhrrmNYS+oBqrwU9/rG1Xtm/
X-Gm-Gg: ASbGnct1oZ3//HcqOx2qLwqjtRglGMivBzGEHMceRi3/RLmJDcJoLc1x6qIGZiu/rGy
	rR+cPMVDp/wLPKRDmvXH4pA21jrd4H3MMiX8M277VeD4G+qw1Yz8ba9i3cG4VsoLTV7yr+auMrS
	6R0Lk7Fii2Q83giMrcfHKLAWr1
X-Google-Smtp-Source: AGHT+IFlypVhoPatyG1S41ARRN9VafZA5suTA50Nl4KHnRzPgisegFr5nMPXUcbEavl64mUeZqkyzMjq0vmoau6IOKc=
X-Received: by 2002:a17:907:82a3:b0:abf:5dd3:bb29 with SMTP id
 a640c23a62f3a-ac25264fab8mr354322566b.15.1741362344149; Fri, 07 Mar 2025
 07:45:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMpRfLORiuJOgUmpmjgCC1LZC1Kp0KFzPGXd9KQZELtr35P+eQ@mail.gmail.com>
 <2025030559-radiated-reviver-eebb@gregkh> <CAMpRfLMQ=rWBpYCaco5X4Sh1ecHuiqa91TwsBo6m2MA_UMKM+g@mail.gmail.com>
 <CAMpRfLMakzeazr91DBVyZQnin7y6L9RB+sPFb59U1QZvY3+KBQ@mail.gmail.com> <2025030718-dwindle-degrading-94d3@gregkh>
In-Reply-To: <2025030718-dwindle-degrading-94d3@gregkh>
From: =?UTF-8?Q?Se=C3=AFfane_Idouchach?= <seifane53@gmail.com>
Date: Fri, 7 Mar 2025 23:45:27 +0800
X-Gm-Features: AQ5f1JrD13VtvoNkOtbz2uR8YGz8hRWTTp6AyKcLBEqS-dprw-ibk2WnFv0PJks
Message-ID: <CAMpRfLPLJA4TaJQCeYfn5XRFnVdqJ36yv-1LL7o=kjYOAj9u1Q@mail.gmail.com>
Subject: Re: [REGRESSION] Long boot times due to USB enumeration
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dirk.behme@de.bosch.com, rafael@kernel.org, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> That is a totally different change, I think you have something odd here
> as these bisection points are very confusing.

I can only agree. I was skeptical that reverting this commit would fix
the issue but it does.

> I think you have a mix of problems here.  Let's fix up all of those
> error messages in the log first.  Dan's fix has nothing to do with that
> at all, once the USB bus connection stuff is resolved, then it should be
> ok.

Are you suggesting you want to fix those messages ? I am sorry if I
was not clear before, those messages are always present even on a
"good" build.
The issue is that on a "bad" build they hold back the boot process
from continuing. USB functionality is never affected.

> As that xhci commit you point at is showing an issue, are you sure that
> you are properly building the right xhci driver into the system?  Do you
> have a Renesas xhci controller?  What is the output of 'lspci'?

I am building with a config based on my current distribution, Arch
Linux, with olddefconfig. A quick grep for the values found in the
commit returns the following :
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PCI_RENESAS=m

lspci as requested:
00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Root Complex [1022:1480]
00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse IOMMU [1022:1481]
00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse GPP Bridge [1022:1483]
00:01.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse GPP Bridge [1022:1483]
00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse GPP Bridge [1022:1483]
00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
00:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
00:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
00:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus
Controller [1022:790b] (rev 61)
00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC
Bridge [1022:790e] (rev 51)
00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 0 [1022:1440]
00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 1 [1022:1441]
00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 2 [1022:1442]
00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 3 [1022:1443]
00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 4 [1022:1444]
00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 5 [1022:1445]
00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 6 [1022:1446]
00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 7 [1022:1447]
01:00.0 Non-Volatile memory controller [0108]: Kingston Technology
Company, Inc. A2000 NVMe SSD [SM2263EN] [2646:2263] (rev 03)
02:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 500
Series Chipset USB 3.1 XHCI Controller [1022:43ee]
02:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 500
Series Chipset SATA Controller [1022:43eb]
02:00.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 500
Series Chipset Switch Upstream Port [1022:43e9]
03:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:43ea]
03:09.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:43ea]
04:00.0 Ethernet controller [0200]: Intel Corporation 82599ES
10-Gigabit SFI/SFP+ Network Connection [8086:10fb] (rev 01)
2a:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8125 2.5GbE Controller [10ec:8125] (rev 05)
2b:00.0 VGA compatible controller [0300]: NVIDIA Corporation TU106
[GeForce RTX 2070 Rev. A] [10de:1f07] (rev a1)
2b:00.1 Audio device [0403]: NVIDIA Corporation TU106 High Definition
Audio Controller [10de:10f9] (rev a1)
2b:00.2 USB controller [0c03]: NVIDIA Corporation TU106 USB 3.1 Host
Controller [10de:1ada] (rev a1)
2b:00.3 Serial bus controller [0c80]: NVIDIA Corporation TU106 USB
Type-C UCSI Controller [10de:1adb] (rev a1)
2c:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices,
Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
2d:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices,
Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
2d:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc.
[AMD] Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
2d:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD]
Matisse USB 3.0 Host Controller [1022:149c]
2d:00.4 Audio device [0403]: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse HD Audio Controller [1022:1487]

Thanks for your time

