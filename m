Return-Path: <stable+bounces-128312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B27A7BDD1
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 15:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BCC3B8C36
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8AD1EF0AB;
	Fri,  4 Apr 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtXAdIaX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621911EF096;
	Fri,  4 Apr 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743773311; cv=none; b=d0uXDn+fNeB729XQOlnVil/mm71lVd+pclYN8rkE5vn0jm8fB2Cbov4aTq8MhkOqlQi8uJg0hAa8ZlU7wCAR3ORn4X27bkmv+9qlhEdpg1qpn0xeb9u3Qbw1mLqZuai3KY4M2s9lR6ygGTdSHSdq+4fY03oTPwm5veKG47h/8Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743773311; c=relaxed/simple;
	bh=8am3I0YCErYUO2PgNgYpMqXVi36aEv+QHl9QuGEDE0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYU9xxP4GFbH3j1/bPZK5YEVrCu4N6cZ7xUn7SE3yLwXhCYKQHbmmhno3wmPNDEy3HlDYcWJYA1pSQdAAWhFtW31+hRY9uRW0m204O+nSKvHuaFzBdBoEccawIkKKWLE7ULdxOLbsxgK83RNYCd61kRCDP5uSHb+jYXvnPQVyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtXAdIaX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so1931305a91.2;
        Fri, 04 Apr 2025 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743773308; x=1744378108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L1EvrIpOY5/BQY+g5/bXbxzle3Uu4BHi9J4gn0QSKck=;
        b=BtXAdIaXd9obJnvwBcE3BCtQwyqHt+JqfD315MptHeqe8jqweYo6iv9Imx8IQMytIO
         Csj2doRnas0fhftgQvxAYTVPBPil6RXB+j6DyqkN+lj+JGgtiv0ERqRMuyGsMKFhzyE2
         APV3FPCE3CMlHwj8eA9VTD0+wJvxs6nrKgn9BFl5vN2x4ixpO3b3DP/rAR+18wbt2Ulv
         jGcYpVW5mxpRypPiB84MWeLl4m1fB0EgE3Y5gvDZxt2QHk2mmAWVb43PUggtvqcUBOlb
         KXXyCqJKTiNTaKKlxsWj2pMKwcP3jOFXb3hDQLQY9eVzV/tA/62JgRIfJwnjf05corUR
         83Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743773308; x=1744378108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1EvrIpOY5/BQY+g5/bXbxzle3Uu4BHi9J4gn0QSKck=;
        b=oEFC4KdlioH745ySxkEHt0mYV5B2/rzWmeJoJs9hmPSF/dunLR8ru/QDarMG+bNxev
         I2ShDKr+7aoZLj8PzIlF0LSFBPIU0DVqppAmKEiOjTDA246L7mI9wlsV9JU60hQjaAoG
         glu1F5TYVxKBYQB8umoc7euFw6MCPhXRnuu2NBNJqXGXwMZoY3MR0ygXJVvMshmM/wa3
         mIGDEj7RnhuGv5W+Z5zZt63+Nc7qIA3S/2JGO/XEbcojbb4DLyDxZklKqPknDv/lAPXV
         oYTmjC2NlLhXJpkMfiXc2ldRavQOfuwOYw7G8NzFUYjqO8O71CIae9uR3vXNMfY/jm00
         34/A==
X-Forwarded-Encrypted: i=1; AJvYcCVw617jhxX9maWuvpe788Sv+2ULjqCowRrZnCr9zI9C/GPmK4hfuk9rP2mNyftDWj9JM5teFZex1mWAZWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJnEw60rnggP10D/9CvR2c1pnRhY1xS4aP3T4WCcIjVgY4+Mt
	fOXCSxU6J3ZKRmPJYLH47sCVoRhq8mUiwosIzLDkMWK8tM0JsctZD/bO4zGwqFgx9Zy6ijN9OQy
	5AxrEnAXkwfZzZEnzNWPWaEPD+OQ=
X-Gm-Gg: ASbGnctE83I1QlEgUZvoq6J6mVfhgmZCOUUCjLUiH/DkVeW2lDujqs1XSvjzjh0gbOQ
	vAUStZdEGdLA9Z2ofKdL0l0y+/BSDoviY0dxpsG/bw9qrUpF7SmhukFd8DOIauy0dp13f6f9n/j
	hXlTrXFp/VrGh+kdqXl/5vDwZW8ep9pi9InKI9DtCO
X-Google-Smtp-Source: AGHT+IEH3oSAaHUxdWxzytgERI3jEbHxHJwBXGrj94vlYzIgv60oEEOga0t/vF9UsR7u5ZJVVEVDpQRL1UPkN/SYW60=
X-Received: by 2002:a17:90a:d883:b0:2fe:a0ac:5fcc with SMTP id
 98e67ed59e1d1-306a6245becmr3055286a91.34.1743773308463; Fri, 04 Apr 2025
 06:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403151621.130541515@linuxfoundation.org> <CADo9pHjHSDjbGHrx1bY0JAxPRNWW63772wGt0e4wQ_kDq50JhA@mail.gmail.com>
In-Reply-To: <CADo9pHjHSDjbGHrx1bY0JAxPRNWW63772wGt0e4wQ_kDq50JhA@mail.gmail.com>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Fri, 4 Apr 2025 15:28:15 +0200
X-Gm-Features: ATxdqUGgEPhFd7pK9_-fqa9Wl-BBCEXuGiINgFnjtn_Peku-eWbJr_Dz5WTiQlg
Message-ID: <CADo9pHhFbPMfURmsAdxaUX0R9pp0aaPxD3KW3PEh2B5iT_YATg@mail.gmail.com>
Subject: Re: [PATCH 6.14 00/21] 6.14.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

Works good on my laptop too with the same OS

Dell Latitude 7390 Intel(R) Core(TM) i5-8350U (8) @ 3.60 GHz

Den fre 4 apr. 2025 kl 12:18 skrev Luna Jernberg <droidbittin@gmail.com>:
>
> Tested-by: Luna Jernberg <droidbittin@gmail.com>
>
> AMD Ryzen 5 5600 6-Core Processor:
> https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
> https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
> https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
> motherboard :)
>
> running Arch Linux with the testing repos enabled:
> https://archlinux.org/ https://archboot.com/
> https://wiki.archlinux.org/title/Arch_Testing_Team
>
> (still building on my Dell Latitude laptop)
>
> Den tors 3 apr. 2025 kl 17:25 skrev Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>:
> >
> > This is the start of the stable review cycle for the 6.14.1 release.
> > There are 21 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.1-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> > -------------
> > Pseudo-Shortlog of commits:
> >
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >     Linux 6.14.1-rc1
> >
> > John Keeping <jkeeping@inmusicbrands.com>
> >     serial: 8250_dma: terminate correct DMA in tx_dma_flush()
> >
> > Cheick Traore <cheick.traore@foss.st.com>
> >     serial: stm32: do not deassert RS485 RTS GPIO prematurely
> >
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >     perf tools: Fix up some comments and code to properly use the event_source bus
> >
> > Luo Qiu <luoqiu@kylinsec.com.cn>
> >     memstick: rtsx_usb_ms: Fix slab-use-after-free in rtsx_usb_ms_drv_remove
> >
> > Michal Pecio <michal.pecio@gmail.com>
> >     usb: xhci: Apply the link chain quirk on NEC isoc endpoints
> >
> > Michal Pecio <michal.pecio@gmail.com>
> >     usb: xhci: Don't skip on Stopped - Length Invalid
> >
> > Dominique Martinet <dominique.martinet@atmark-techno.com>
> >     net: usb: usbnet: restore usb%d name exception for local mac addresses
> >
> > Fabio Porcedda <fabio.porcedda@gmail.com>
> >     net: usb: qmi_wwan: add Telit Cinterion FE990B composition
> >
> > Fabio Porcedda <fabio.porcedda@gmail.com>
> >     net: usb: qmi_wwan: add Telit Cinterion FN990B composition
> >
> > Sherry Sun <sherry.sun@nxp.com>
> >     tty: serial: fsl_lpuart: disable transmitter before changing RS485 related registers
> >
> > Cameron Williams <cang1@live.co.uk>
> >     tty: serial: 8250: Add Brainboxes XC devices
> >
> > Cameron Williams <cang1@live.co.uk>
> >     tty: serial: 8250: Add some more device IDs
> >
> > William Breathitt Gray <wbg@kernel.org>
> >     counter: microchip-tcb-capture: Fix undefined counter channel state on probe
> >
> > Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> >     counter: stm32-lptimer-cnt: fix error handling when enabling
> >
> > Andres Traumann <andres.traumann.01@gmail.com>
> >     ALSA: hda/realtek: Bass speaker fixup for ASUS UM5606KA
> >
> > Dhruv Deshpande <dhrv.d@proton.me>
> >     ALSA: hda/realtek: Support mute LED on HP Laptop 15s-du3xxx
> >
> > Maxim Mikityanskiy <maxtram95@gmail.com>
> >     netfilter: socket: Lookup orig tuple for IPv6 SNAT
> >
> > Abel Wu <wuyun.abel@bytedance.com>
> >     cgroup/rstat: Fix forceidle time in cpu.stat
> >
> > Minjoong Kim <pwn9uin@gmail.com>
> >     atm: Fix NULL pointer dereference
> >
> > Terry Junge <linuxhid@cosmicgizmosystems.com>
> >     HID: hid-plantronics: Add mic mute mapping and generalize quirks
> >
> > Terry Junge <linuxhid@cosmicgizmosystems.com>
> >     ALSA: usb-audio: Add quirk for Plantronics headsets to fix control names
> >
> >
> > -------------
> >
> > Diffstat:
> >
> >  Makefile                                  |   4 +-
> >  drivers/counter/microchip-tcb-capture.c   |  19 ++++
> >  drivers/counter/stm32-lptimer-cnt.c       |  24 +++--
> >  drivers/hid/hid-plantronics.c             | 144 ++++++++++++++----------------
> >  drivers/memstick/host/rtsx_usb_ms.c       |   1 +
> >  drivers/net/usb/qmi_wwan.c                |   2 +
> >  drivers/net/usb/usbnet.c                  |  21 +++--
> >  drivers/tty/serial/8250/8250_dma.c        |   2 +-
> >  drivers/tty/serial/8250/8250_pci.c        |  46 ++++++++++
> >  drivers/tty/serial/fsl_lpuart.c           |  17 ++++
> >  drivers/tty/serial/stm32-usart.c          |   4 +-
> >  drivers/usb/host/xhci-ring.c              |   4 +
> >  drivers/usb/host/xhci.h                   |  13 ++-
> >  kernel/cgroup/rstat.c                     |  29 +++---
> >  net/atm/mpc.c                             |   2 +
> >  net/ipv6/netfilter/nf_socket_ipv6.c       |  23 +++++
> >  sound/pci/hda/patch_realtek.c             |   2 +
> >  sound/usb/mixer_quirks.c                  |  51 +++++++++++
> >  tools/perf/Documentation/intel-hybrid.txt |  12 +--
> >  tools/perf/Documentation/perf-list.txt    |   2 +-
> >  tools/perf/arch/x86/util/iostat.c         |   2 +-
> >  tools/perf/builtin-stat.c                 |   2 +-
> >  tools/perf/util/mem-events.c              |   2 +-
> >  tools/perf/util/pmu.c                     |   4 +-
> >  24 files changed, 304 insertions(+), 128 deletions(-)
> >
> >
> >

