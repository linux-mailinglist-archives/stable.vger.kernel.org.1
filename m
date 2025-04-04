Return-Path: <stable+bounces-128288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 121E6A7BA82
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 12:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E76E7A5323
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83D418E750;
	Fri,  4 Apr 2025 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRwy/3tv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7794910E9;
	Fri,  4 Apr 2025 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743761913; cv=none; b=b3dxePJukWtEzVMXx+3/sqUsxND++7rIZW7Z23xfVdhTwcNoI3lNWEt2D1acgm3Ziohx7nrMWfhBhBErLbVTVKFlfzZPvTDmr1sHcGmrwEvN/4gdMjR0nZPHtH6fIubjwQyJyXJoCwFIhQxsGoDNn5py0a/Ct3Yoq7n9dR8s28k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743761913; c=relaxed/simple;
	bh=80splu1n8pOU1KBBOO6Kic2gl/SyiEiRofLtsBPJG04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNCWtRk8mQE82pzAe0gkdpsVI7qNn6dA7fTyLlKFaiLmDtG4vi+3d/7l/Y1IkJV6fA8SIhy518XHTbiJKKDTdivQN0hmZzammNBFHY9OoRfw5ZET1ZYvqXivR0kj1c5ha2maPH4+IA8lx8lPQsc9YuSl0pKCD3KpQT4aV5XJeMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRwy/3tv; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af519c159a8so1671555a12.3;
        Fri, 04 Apr 2025 03:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743761911; x=1744366711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kk2+ssM+Oku3Smc5VL3MHZ4lXHAgsUA/66b+AhTOPFU=;
        b=kRwy/3tv5u/qNkJNnlngkTvywHIFo4oeaJq7MAipJ1r9HWLiJaI2YnPbnlUA+tSqZP
         jmfpvaXRWHk7p2WagqG5XhUMFBHvF1g8Ktgw3qSzpuJNnAaT/gxtOREu44gmUHFaXKQn
         nPDn8/kVzMPTIoPHuBesmG3AE/b1XLDjeo2LHdkgUEGHSgW1RbwhnGJIraH3HNnw3YvU
         pah5ofNaIM2HRknkNak3bXsWjnGG57jtljGJJpqm7WJvNfUu3PsPsttaW8PCzJGEfQqr
         QEnCvpkNdOTpU2pm2T0IR5YDm13mXE2HngsF1tkKwCA3auUkFUTaHS3pUQb8uAjAGk1l
         DiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743761911; x=1744366711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kk2+ssM+Oku3Smc5VL3MHZ4lXHAgsUA/66b+AhTOPFU=;
        b=HQgr7S6FL9WdDbuQPySEqX8rwayXmkMY/obD2TbZRf5rTdWWpscTt4FsFxK56osGiF
         gfu88cpBurqpLqlFCnw+f3hvMaUSXnHVm2kAe7NFu/0/L+N13VN6PoddfyRAW6X7S/vb
         OCHsh7XscG0Lei6H8U4CvY9z8ZccSBH/v35XEvthD7wJpBfTPk77uHWBKNCN1ABZ7Atm
         9+hH7A/TMDcL466bHBixrI7CC7eBK3Ejl+3SplxpTRPo/dOuVrRvUfyOodze7v1lT6JH
         WEF6e32y2mBFKTuONT2QVXwiEsQKDwnQ6Z7VS6SUwKEqbkTVvSKxXHPJbebx2zsKedv/
         rXrw==
X-Forwarded-Encrypted: i=1; AJvYcCWECdpNu8FbKIQsMyNNa6gcROaHHyG2g3NkVphMfrYfZJnNwx7iYI0qigC+puWQal6T6v50WflbG/xgqa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7QZV3RdaLMRy9NduiUQfeFVzMse6rbH04/wmHogkZ16Q4FMJm
	rio0PeXT28eOEBRZElI/RcjpiOYdHPUSCJggM5umNn3BvNN0hTQ3bqxnU/qNRFVoXFWY7WG1XuS
	sebSc9cigtjOs7tTMSt2wFvsIrK0qtchWEsp5yA==
X-Gm-Gg: ASbGnctyJiLQmAyr0GmRNU27qZqwx25knysVRk0w7/q4DmZhJTZoqNe8Jli5Plzt0Mc
	uGWa8UIcJmRhoTBCdkbLnmT0egyvmMYZUXyD37yLEIUFQUb+ADN+rfni130zZklusnw84wjh6TI
	CMfyyhNXo9QFUKDK5MI/oiWAdObHwi1QbBaxkW4K+R
X-Google-Smtp-Source: AGHT+IF5qLApiWtmfEDZpNEBNfwwjniKGCedGrVsIBSll8ZYZ6bWrMHRGsz5hNK6ku+PeSNjXvg1TdI1HKVtH14YtJA=
X-Received: by 2002:a17:90b:254c:b0:2ee:aed6:9ec2 with SMTP id
 98e67ed59e1d1-306a6159281mr3617039a91.14.1743761910715; Fri, 04 Apr 2025
 03:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403151621.130541515@linuxfoundation.org>
In-Reply-To: <20250403151621.130541515@linuxfoundation.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Fri, 4 Apr 2025 12:18:18 +0200
X-Gm-Features: ATxdqUGBb48kNnIvxkBjFnEnOVymJCkadN_wHW90QF4tTA66dTROAv5n4CAYZjs
Message-ID: <CADo9pHjHSDjbGHrx1bY0JAxPRNWW63772wGt0e4wQ_kDq50JhA@mail.gmail.com>
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

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

(still building on my Dell Latitude laptop)

Den tors 3 apr. 2025 kl 17:25 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> This is the start of the stable review cycle for the 6.14.1 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.14.1-rc1
>
> John Keeping <jkeeping@inmusicbrands.com>
>     serial: 8250_dma: terminate correct DMA in tx_dma_flush()
>
> Cheick Traore <cheick.traore@foss.st.com>
>     serial: stm32: do not deassert RS485 RTS GPIO prematurely
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     perf tools: Fix up some comments and code to properly use the event_source bus
>
> Luo Qiu <luoqiu@kylinsec.com.cn>
>     memstick: rtsx_usb_ms: Fix slab-use-after-free in rtsx_usb_ms_drv_remove
>
> Michal Pecio <michal.pecio@gmail.com>
>     usb: xhci: Apply the link chain quirk on NEC isoc endpoints
>
> Michal Pecio <michal.pecio@gmail.com>
>     usb: xhci: Don't skip on Stopped - Length Invalid
>
> Dominique Martinet <dominique.martinet@atmark-techno.com>
>     net: usb: usbnet: restore usb%d name exception for local mac addresses
>
> Fabio Porcedda <fabio.porcedda@gmail.com>
>     net: usb: qmi_wwan: add Telit Cinterion FE990B composition
>
> Fabio Porcedda <fabio.porcedda@gmail.com>
>     net: usb: qmi_wwan: add Telit Cinterion FN990B composition
>
> Sherry Sun <sherry.sun@nxp.com>
>     tty: serial: fsl_lpuart: disable transmitter before changing RS485 related registers
>
> Cameron Williams <cang1@live.co.uk>
>     tty: serial: 8250: Add Brainboxes XC devices
>
> Cameron Williams <cang1@live.co.uk>
>     tty: serial: 8250: Add some more device IDs
>
> William Breathitt Gray <wbg@kernel.org>
>     counter: microchip-tcb-capture: Fix undefined counter channel state on probe
>
> Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>     counter: stm32-lptimer-cnt: fix error handling when enabling
>
> Andres Traumann <andres.traumann.01@gmail.com>
>     ALSA: hda/realtek: Bass speaker fixup for ASUS UM5606KA
>
> Dhruv Deshpande <dhrv.d@proton.me>
>     ALSA: hda/realtek: Support mute LED on HP Laptop 15s-du3xxx
>
> Maxim Mikityanskiy <maxtram95@gmail.com>
>     netfilter: socket: Lookup orig tuple for IPv6 SNAT
>
> Abel Wu <wuyun.abel@bytedance.com>
>     cgroup/rstat: Fix forceidle time in cpu.stat
>
> Minjoong Kim <pwn9uin@gmail.com>
>     atm: Fix NULL pointer dereference
>
> Terry Junge <linuxhid@cosmicgizmosystems.com>
>     HID: hid-plantronics: Add mic mute mapping and generalize quirks
>
> Terry Junge <linuxhid@cosmicgizmosystems.com>
>     ALSA: usb-audio: Add quirk for Plantronics headsets to fix control names
>
>
> -------------
>
> Diffstat:
>
>  Makefile                                  |   4 +-
>  drivers/counter/microchip-tcb-capture.c   |  19 ++++
>  drivers/counter/stm32-lptimer-cnt.c       |  24 +++--
>  drivers/hid/hid-plantronics.c             | 144 ++++++++++++++----------------
>  drivers/memstick/host/rtsx_usb_ms.c       |   1 +
>  drivers/net/usb/qmi_wwan.c                |   2 +
>  drivers/net/usb/usbnet.c                  |  21 +++--
>  drivers/tty/serial/8250/8250_dma.c        |   2 +-
>  drivers/tty/serial/8250/8250_pci.c        |  46 ++++++++++
>  drivers/tty/serial/fsl_lpuart.c           |  17 ++++
>  drivers/tty/serial/stm32-usart.c          |   4 +-
>  drivers/usb/host/xhci-ring.c              |   4 +
>  drivers/usb/host/xhci.h                   |  13 ++-
>  kernel/cgroup/rstat.c                     |  29 +++---
>  net/atm/mpc.c                             |   2 +
>  net/ipv6/netfilter/nf_socket_ipv6.c       |  23 +++++
>  sound/pci/hda/patch_realtek.c             |   2 +
>  sound/usb/mixer_quirks.c                  |  51 +++++++++++
>  tools/perf/Documentation/intel-hybrid.txt |  12 +--
>  tools/perf/Documentation/perf-list.txt    |   2 +-
>  tools/perf/arch/x86/util/iostat.c         |   2 +-
>  tools/perf/builtin-stat.c                 |   2 +-
>  tools/perf/util/mem-events.c              |   2 +-
>  tools/perf/util/pmu.c                     |   4 +-
>  24 files changed, 304 insertions(+), 128 deletions(-)
>
>
>

