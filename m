Return-Path: <stable+bounces-136552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D8FA9A9DF
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 12:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B415189AFD2
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12D021D591;
	Thu, 24 Apr 2025 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="giYjCGgd"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B561E9B32
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489855; cv=none; b=RP+MyjfiwUAbhA02WM70haWVm8szUdHHXXReYKeaqYCjCYXq8R47MQ9XxQpzjkJ7cMiTUAzEQX0ixHfS9fchjeykquddOLvgRBkVFHEup20VThMOv1GEaxnkykNdxB/jF+XiFa+s1A1I0/UUWWuOb01TkEpb9NTSbGTHFrgTZqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489855; c=relaxed/simple;
	bh=4kWTuSimUr1pYZh+WfiFm80hj0CVGThj3XOhNiJmo8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKMVU9ZQFTqz4o7yO+wi09qDtfN/o34asVLx/m+XgyVytPLqB/dFXGGYy17lv9bdUzTNxyfWnJQf0miSphPL3D5UExJ1OP9GNCi5e8+lkwYXKIihTWHemLEnuJd5rn2riEj0MOvLca7IDE083L0d4Kg9eo1YIXH86TdqKmGnaNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=giYjCGgd; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-527b70bd90dso414767e0c.3
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745489852; x=1746094652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd8dX3L8McnJnzG1kvO6TAZzdRIThdzIaWgli/YUdKM=;
        b=giYjCGgdECVej30OmLJlBvsMDI22bNMmhlLfN/JAXMeDfnWTqC/A692vNnB9ehDGeN
         gvr0Y9T5JK2TTkCqkHtzB52/LabQVIOzbSzxmrwQpxWzQLGEPwjcU+VUFDif28PDpJ9u
         KcEGOJUzi8yfyjbofJednuB1uhTY9fmvp5WenNQBTfqqaRzvljQhCsfz5Jhh1EO6kq/m
         PskU49TGBSL0xEpS331fNOXelAu3aO6/zf17JzwUNXwFQKlwIkbBpXTgqhN0YTS2Jqvm
         pBP/1oVEvQPFiMOGpVMlqRQtpyiuiNOYn0FGraw/si+VxxFUhoZTYde3zSbIjs6vkZba
         75Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745489852; x=1746094652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qd8dX3L8McnJnzG1kvO6TAZzdRIThdzIaWgli/YUdKM=;
        b=hw3nW9JF5cD0rdP7jQRcSVm9uuQ2ZgTJKumh6+443bmbAhfZ/tq6/rmprnffw1yYiN
         tHcQiy4gMrPIdRWB9JX6P+Cjc/UAD6mDF2IqDj+Y40ASK+AYsiJXgIRiXdOQugFKHD/N
         cU7NkdWJG+JRyQ6F7Ia25eF+8svujVpK5im+trB2BZjuv1AM+8gtu49W/6cqkN4fa+5U
         qxuhiDUigDDhcYa0QvXdeuDizSczU+bXlIG5l/AMlOuGNMvXT6DmrceVtfqMCwheBgFz
         gjnEXxmh7dlGbDccgY58Ma3mlFVTkE0i/gnfi2e4NQCReGue2xkNUGj17G3i8JD82M8J
         Y4fg==
X-Forwarded-Encrypted: i=1; AJvYcCWh8wu5TSe7rG1Hsn9QRMfVIy5ceU3nCveCUmjtqxtuIfTY+OrAYebpGqssM7lH+j4sTjLe5ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXCWttecheNOdeKcYFIpppzY7D8b1C5CKiUX3k1stfcEbC7Y0z
	CG9LqPOoqXzwLbVy2r31/evLGmQuMT6st+F0R2HmEZaWA3MGjH/fBOD0aFitHwVDgVwvBVsSxxy
	hQ6nksELpzn/fBI+22W2+fTq7p4wP5koASVVTgg==
X-Gm-Gg: ASbGncvRKEwLP2Kton9yDOLD96xtA0rWV7L0ALNORQIpXtTdXv33qAn60FC9z1pXmtM
	ABjjf9MK6Xxk2cMksQ7+1d9tL+6qkNe45jQYYCtqpIWO8aeBFnp/mgqvlD04yxMbpgO6E7dqwUO
	s5AVuh4NAvcPT8ypdSz5rlbr8rEhSibR+WvZWz8re8FuY9qSX+ZivNn+zF
X-Google-Smtp-Source: AGHT+IHQmArbDwQam2sWEQKw6pbqXdNil5MR8eQL6AdbVtr0QFMFFp3md/kIphk9kqhOb8uf4oWAI1RyOhRl8fNdoJ4=
X-Received: by 2002:a05:6122:1e07:b0:529:2644:76bf with SMTP id
 71dfb90a1353d-52a783c99f0mr1174387e0c.9.1745489851657; Thu, 24 Apr 2025
 03:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417175111.386381660@linuxfoundation.org> <CA+G9fYstVDU_e27mkqEJC0O742zUb0A=wny59n2SiiH7Z_ouJg@mail.gmail.com>
 <2176888.9o76ZdvQCi@n9w6sw14>
In-Reply-To: <2176888.9o76ZdvQCi@n9w6sw14>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 24 Apr 2025 15:47:20 +0530
X-Gm-Features: ATxdqUGDEnTdSBrRVMt156QB4SDgoFuxTxkyO3uYFz6_81C_JLQx6gbJz1oMvs0
Message-ID: <CA+G9fYurAWoKRTxUrGMEUfaU-GBdRQc5AHUSHPESq8k4Tp=9gg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/414] 6.13.12-rc1 review
To: Christian Eggers <ceggers@arri.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Thu, 24 Apr 2025 at 15:15, Christian Eggers <ceggers@arri.de> wrote:
>
> Hi all,
>
> unfortunately I was away and couldn't look on this in time. Meanwhile
> the git trees have been rebased, so I am unsure whether patches have
> been dropped of other work is left.
>
> @Naresh: Can you please provide a pointer to the offending commit?

The build regressions have been fixed by dropping the problematic patches.

The open issue is on arm64 Dragonboard 410c boot warning and internal oops
and followed by boot failures.

 WARNING drivers/regulator/core.c:2396 regulator_put
 (drivers/regulator/core.c:2419 drivers/regulator/core.c:2417)

Tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
Bad: v6.14.3
Good: v6.14.2

- Naresh

>
> regards,
> Christian
>
>
> On Friday, 18 April 2025, 10:39:41 CEST, Naresh Kamboju wrote:
> > On Thu, 17 Apr 2025 at 23:47, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.13.12 release.
> > > There are 414 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Sat, 19 Apr 2025 17:49:48 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/pa=
tch-6.13.12-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-6.13.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> >
> > The following two regressions found on stable-rc 6.13.12-rc1 review,
> >
> > 1)
> > Regressions on arm64 allmodconfig and allyesconfig builds failed
> > on the stable rc 6.13.12-rc1.
> >
> > 2)
> > Regressions on arm64 dragonboard 410c boot failed with lkftconfig
> > on the stable rc 6.13.12-rc1.
> >
> > First seen on the 6.13.12-rc1
> > Good: v6.13.11
> > Bad:  v6.13.11-415-gd973e9e70c8f
> >
> > Regressions found on arm64:
> > - build/gcc-13-allmodconfig
> > - build/gcc-13-allyesconfig
> > - build/clang-20-allmodconfig
> > - build/clang-20-allyesconfig
> >
> > Regressions found on arm64 dragonboard-410c:
> > - boot/clang-20-lkftconfig
> >
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? Yes
> >
> > Build regression: arm64 ufs-qcom.c implicit declaration 'devm_of_qcom_i=
ce_get'
> >
> > Boot regression: arm64 dragonboard 410c WARNING regulator core.c regula=
tor_put
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > ## Build log arm64
> > drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_ice_init':
> > drivers/ufs/host/ufs-qcom.c:121:15: error: implicit declaration of
> > function 'devm_of_qcom_ice_get'; did you mean 'of_qcom_ice_get'?
> > [-Werror=3Dimplicit-function-declaration]
> > 121 |         ice =3D devm_of_qcom_ice_get(dev);
> > |               ^~~~~~~~~~~~~~~~~~~~
> > |               of_qcom_ice_get
> > drivers/ufs/host/ufs-qcom.c:121:13: error: assignment to 'struct
> > qcom_ice *' from 'int' makes pointer from integer without a cast
> > [-Werror=3Dint-conversion]
> > 121 |         ice =3D devm_of_qcom_ice_get(dev);
> > |             ^
> > cc1: all warnings being treated as errors
> >
> >
> > ## Boot log arm64 dragonboard 410c:
> > [    3.863371]  remoteproc:smd-edge: failed to parse smd edge
> > [    3.989304] msm_hsusb 78d9000.usb: Failed to create device link
> > (0x180) with supplier remoteproc for /soc@0/usb@78d9000/ulpi/phy
> > [    3.993079] qcom-clk-smd-rpm
> > remoteproc:smd-edge:rpm-requests:clock-controller: Error registering
> > SMD clock driver (-1431655766)
> > [    4.000071] qcom-clk-smd-rpm
> > remoteproc:smd-edge:rpm-requests:clock-controller: probe with driver
> > qcom-clk-smd-rpm failed with error -1431655766
> > [    4.028243] sdhci_msm 7864900.mmc: Got CD GPIO
> > [    4.039730] s3: Bringing 0uV into 1250000-1250000uV
> > [    4.039886] s3: failed to enable: (____ptrval____)
> > [    4.043538] ------------[ cut here ]------------
> > [    4.048299] WARNING: CPU: 0 PID: 46 at
> > drivers/regulator/core.c:2396 regulator_put
> > (drivers/regulator/core.c:2419 drivers/regulator/core.c:2417)
> > [    4.053085] Modules linked in:
> > [    4.053087] input: gpio-keys as /devices/platform/gpio-keys/input/in=
put0
> > [    4.060581] sdhci_msm 7864900.mmc: Got CD GPIO
> > [    4.061476]
> > [    4.061484] CPU: 0 UID: 0 PID: 46 Comm: kworker/u16:2 Not tainted
> > 6.13.12-rc1 #1
> > [    4.061495] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC =
(DT)
> > [    4.061501] Workqueue: async async_run_entry_fn
> > [    4.069821] clk: Disabling unused clocks
> > [    4.071199]
> > [    4.071204] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [    4.076270] PM: genpd: Disabling unused power domains
> > [    4.077108] pc : regulator_put (drivers/regulator/core.c:2419
> > drivers/regulator/core.c:2417)
> > [    4.084640] qcom-rpmpd
> > remoteproc:smd-edge:rpm-requests:power-controller: failed to sync cx:
> > -1431655766
> > [    4.091163] lr : regulator_put (drivers/regulator/core.c:2390
> > drivers/regulator/core.c:2417)
> > [    4.091174] sp : ffff8000832eba50
> > [    4.091178] x29: ffff8000832eba50
> > [    4.095545] qcom-rpmpd
> > remoteproc:smd-edge:rpm-requests:power-controller: failed to sync
> > cx_ao: -1431655766
> > [    4.099579]  x28: 0000000000000000 x27: ffff800081b54020
> > [    4.099592] x26: ffff800081b53fe0 x25: 0000000000000001
> > [    4.101088] qcom-rpmpd
> > remoteproc:smd-edge:rpm-requests:power-controller: failed to sync
> > cx_vfc: -1431655766
> > [    4.107745]  x24: 00000000aaaaaaaa
> > [    4.107752] x23: ffff000004362a80 x22: ffff0000045fa800
> > [    4.112988] qcom-rpmpd
> > remoteproc:smd-edge:rpm-requests:power-controller: failed to sync mx:
> > -1431655766
> > [    4.116953]  x21: ffff0000045fa800
> > [    4.116961] x20: ffff0000038dfcc0 x19: ffff000003885d80 x18: 0000000=
000000068
> > [    4.126432] qcom-rpmpd
> > remoteproc:smd-edge:rpm-requests:power-controller: failed to sync
> > mx_ao: -1431655766
> > [    4.130312]
> > [    4.130315] x17: 0000000000000000 x16: 0000000000000001 x15: 0000000=
000000003
> > [    4.133541] ALSA device list:
> > [    4.136833]
> > [    4.136836] x14: ffff80008284e1f0 x13: 0000000000000003 x12: 0000000=
000000003
> > [    4.146411]   No soundcards found.
> > [    4.151929]
> > [    4.151933] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000=
000000000
> > [    4.230459] x8 : 0000000000000001 x7 : 0720072007200720 x6 : 0720072=
007200720
> > [    4.230478] x5 : ffff000003201f00 x4 : 0000000000000000 x3 : 0000000=
000000000
> > [    4.230491] x2 : 0000000000000000 x1 : ffff8000801fe6e4 x0 : ffff000=
003885d80
> > [    4.230506] Call trace:
> > [    4.230512] regulator_put (drivers/regulator/core.c:2419
> > drivers/regulator/core.c:2417) (P)
> > [    4.230529] regulator_register (drivers/regulator/core.c:5823)
> > [    4.230543] devm_regulator_register (drivers/regulator/devres.c:477)
> > [    4.230554] rpm_reg_probe
> > (drivers/regulator/qcom_smd-regulator.c:1425
> > drivers/regulator/qcom_smd-regulator.c:1462)
> > [    4.230569] platform_probe (drivers/base/platform.c:1405)
> > [    4.230583] really_probe (drivers/base/dd.c:581 drivers/base/dd.c:65=
8)
> > [    4.280941] __driver_probe_device (drivers/base/dd.c:0)
> > [    4.284581] driver_probe_device (drivers/base/dd.c:830)
> > [    4.288919] __device_attach_driver (drivers/base/dd.c:959)
> > [    4.292911] bus_for_each_drv (drivers/base/bus.c:459)
> > [    4.297426] __device_attach_async_helper
> > (arch/arm64/include/asm/jump_label.h:36 drivers/base/dd.c:988)
> > [    4.301593] async_run_entry_fn
> > (arch/arm64/include/asm/jump_label.h:36 kernel/async.c:131)
> > [    4.306626] process_scheduled_works (kernel/workqueue.c:3241
> > kernel/workqueue.c:3317)
> > [    4.310533] worker_thread (include/linux/list.h:373
> > kernel/workqueue.c:946 kernel/workqueue.c:3399)
> > [    4.315305] kthread (kernel/kthread.c:391)
> > [    4.318863] ret_from_fork (arch/arm64/kernel/entry.S:863)
> > [    4.322250] ---[ end trace 0000000000000=C3=AF=C2=BF=C2=BD[    4.330=
596] s4:
> > failed to enable: (____ptrval____)
> > [    4.330739] ------------[ cut here ]------------
> > [    4.334298] WARNING: CPU: 3 PID: 46 at
> > drivers/regulator/core.c:2396 regulator_put
> > (drivers/regulator/core.c:2419 drivers/regulator/core.c:2417)
> > [    4.339086] Modules linked in:
> > [    4.347491] CPU: 3 UID: 0 PID: 46 Comm: kworker/u16:2 Tainted: G
> >     W          6.13.12-rc1 #1
> > [    4.350372] Tainted: [W]=3DWARN
> > [    4.359293] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC =
(DT)
> > [    4.360333] sdhci_msm 7864900.mmc: Got CD GPIO
> > [    4.362242] Workqueue: async async_run_entry_fn
> > [    4.373272] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [    4.377705] pc : regulator_put (drivers/regulator/core.c:2419
> > drivers/regulator/core.c:2417)
> > [    4.384641] lr : regulator_put (drivers/regulator/core.c:2390
> > drivers/regulator/core.c:2417)
> > [    4.388807] sp : ffff8000832eba50
> > [    4.392711] x29: ffff8000832eba50 x28: 0000000000000000 x27: ffff800=
081b54040
> > [    4.395934] x26: ffff800081b53fe0 x25: 0000000000000001 x24: 0000000=
0aaaaaaaa
> > [    4.403052] x23: ffff000009d10c80 x22: ffff000009c48800 x21: ffff000=
009c48800
> > [    4.410170] x20: ffff0000044e2900 x19: ffff000003f90840 x18: ffff800=
0817025c0
> > [    4.417287] x17: 0000000000000000 x16: 0000000000000001 x15: 0000000=
000000003
> > [    4.424405] x14: ffff80008284e1f0 x13: 0000000000000003 x12: 0000000=
000000003
> > [    4.431524] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000=
000000000
> > [    4.438642] x8 : 0000000000000001 x7 : 0720072007200720 x6 : 0720072=
007200720
> > [    4.445760] x5 : ffff000003201f00 x4 : 0000000000000000 x3 : 0000000=
000000000
> > [    4.452878] x2 : 0000000000000000 x1 : ffff8000801fe6e4 x0 : ffff000=
003f90840
> > [    4.459997] Call trace:
> > [    4.467103] regulator_put (drivers/regulator/core.c:2419
> > drivers/regulator/core.c:2417) (P)
> > [    4.469364] regulator_register (drivers/regulator/core.c:5823)
> > [    4.473530] devm_regulator_register (drivers/regulator/devres.c:477)
> > [    4.477437] rpm_reg_probe
> > (drivers/regulator/qcom_smd-regulator.c:1425
> > drivers/regulator/qcom_smd-regulator.c:1462)
> > [    4.481948] platform_probe (drivers/base/platform.c:1405)
> > [    4.485681] really_probe (drivers/base/dd.c:581 drivers/base/dd.c:65=
8)
> > [    4.489415] __driver_probe_device (drivers/base/dd.c:0)
> > [    4.493062] driver_probe_device (drivers/base/dd.c:830)
> > [    4.497401] __device_attach_driver (drivers/base/dd.c:959)
> > [    4.501396] bus_for_each_drv (drivers/base/bus.c:459)
> > [    4.505908] __device_attach_async_helper
> > (arch/arm64/include/asm/jump_label.h:36 drivers/base/dd.c:988)
> > [    4.510078] async_run_entry_fn
> > (arch/arm64/include/asm/jump_label.h:36 kernel/async.c:131)
> > [    4.515109] process_scheduled_works (kernel/workqueue.c:3241
> > kernel/workqueue.c:3317)
> > [    4.519017] worker_thread (include/linux/list.h:373
> > kernel/workqueue.c:946 kernel/workqueue.c:3399)
> > [    4.523790] kthread (kernel/kthread.c:391)
> > [    4.527347] ret_from_fork (arch/arm64/kernel/entry.S:863)
> > [    4.530735] ---[ end trace 0000000000000000 ]---
> > [    4.535440] l2: Bringing 0uV into 1200000-1200000uV
> > [    4.539050] qcom_rpm_smd_regulator
> > remoteproc:smd-edge:rpm-requests:regulators: l2:
> > devm_regulator_register() failed, ret=3D-517
> > [    4.544075] Unable to handle kernel paging request at virtual
> > address ffffffffaaaaae6a
> > [    4.554991] Mem abort info:
> > [    4.562869]   ESR =3D 0x0000000096000005
> > [    4.565560]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [    4.569384]   SET =3D 0, FnV =3D 0
> > [    4.574846]   EA =3D 0, S1PTW =3D 0
> > [    4.577710]   FSC =3D 0x05: level 1 translation fault
> > [    4.580755] Data abort info:
> > [    4.585612]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
> > [    4.588742]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > [    4.594036]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > [    4.599158] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000082=
4a4000
> > [    4.604544] [ffffffffaaaaae6a] pgd=3D0000000000000000,
> > p4d=3D0000000082e7d403, pud=3D0000000000000000
> > [    4.611238] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> > [    4.619631] Modules linked in:
> > [    4.625875] CPU: 3 UID: 0 PID: 46 Comm: kworker/u16:2 Tainted: G
> >     W          6.13.12-rc1 #1
> > [    4.629015] Tainted: [W]=3DWARN
> > [    4.637936] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC =
(DT)
> > [    4.640900] Workqueue: async async_run_entry_fn
> > [    4.647664] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [    4.651924] pc : regulator_unregister (drivers/regulator/core.c:5850=
)
> > [    4.658861] lr : devm_rdev_release (drivers/regulator/devres.c:453)
> > [    4.663721] sp : ffff8000832ebaf0
> > [    4.667974] x29: ffff8000832ebb10 x28: ffff000004520000 x27: 0000000=
0000001c8
> > [    4.671195] x26: ffff0000042c6040 x25: ffff000009d10c00 x24: ffff000=
004520000
> > [    4.678311] x23: ffff80008280ed00 x22: ffff8000823b07cd x21: ffff000=
003f90780
> > [    4.685431] x20: ffff000009c7b810 x19: ffff8000832ebbb8 x18: 0000000=
000000068
> > [    4.692548] x17: 6f74616c75676572 x16: 3a73747365757165 x15: 00000ff=
00003fd3a
> > [    4.699666] x14: 000000000000ffff x13: 0000000000000020 x12: 0000000=
000000003
> > [    4.706784] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff800=
080b52bb0
> > [    4.713901] x8 : 50dfedbf8d5fec00 x7 : 3d4e5f454c424954 x6 : 0000000=
04e514553
> > [    4.721021] x5 : 0000000000000008 x4 : ffff80008222c178 x3 : 0000000=
000000010
> > [    4.728139] x2 : ffff8000832eba70 x1 : ffff000003f90800 x0 : fffffff=
faaaaaaaa
> > [    4.735257] Call trace:
> > [    4.742362] regulator_unregister (drivers/regulator/core.c:5850) (P)
> > [    4.744625] devm_rdev_release (drivers/regulator/devres.c:453)
> > [    4.749484] release_nodes (drivers/base/devres.c:506)
> > [    4.753388] devres_release_all (drivers/base/devres.c:0)
> > [    4.756950] really_probe (drivers/base/dd.c:551 drivers/base/dd.c:72=
4)
> > [    4.760941] __driver_probe_device (drivers/base/dd.c:0)
> > [    4.764588] driver_probe_device (drivers/base/dd.c:830)
> > [    4.768842] __device_attach_driver (drivers/base/dd.c:959)
> > [    4.772836] bus_for_each_drv (drivers/base/bus.c:459)
> > [    4.777348] __device_attach_async_helper
> > (arch/arm64/include/asm/jump_label.h:36 drivers/base/dd.c:988)
> > [    4.781518] async_run_entry_fn
> > (arch/arm64/include/asm/jump_label.h:36 kernel/async.c:131)
> > [    4.786552] process_scheduled_works (kernel/workqueue.c:3241
> > kernel/workqueue.c:3317)
> > [    4.790458] worker_thread (include/linux/list.h:373
> > kernel/workqueue.c:946 kernel/workqueue.c:3399)
> > [    4.795229] kthread (kernel/kthread.c:391)
> > [    4.798788] ret_from_fork (arch/arm64/kernel/entry.S:863)
> > [ 4.802179] Code: d5384108 f9430508 f81f83a8 b4000bc0 (f941e014)
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [    4.805745] ---[ end trace 0000000000000000 ]---
> > [   14.254255] platform ci_hdrc.0: deferred probe pending: (reason unkn=
own)
> >
> > ## Source
> > * Kernel version: 6.13.12-rc1
> > * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x-stable-rc.git
> > * Git sha: d973e9e70c8f0ad1a53a96ce48db9f3f882db4a8
> > * Git describe: v6.13.11-415-gd973e9e70c8f
> > * Project details:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v=
6.13.11-415-gd973e9e70c8f/
> > * Architectures: arm64
> > * Toolchains: clang-20, gcc-13
> > * Kconfigs: allmodconfig, allyesconfig
> >
> > ## Build arm64
> > * Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6=
.13.y/build/v6.13.11-415-gd973e9e70c8f/testrun/28151211/suite/build/test/gc=
c-13-allmodconfig/log
> > * Build history:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v=
6.13.11-415-gd973e9e70c8f/testrun/28151211/suite/build/test/gcc-13-allmodco=
nfig/history/
> > * Build details:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v=
6.13.11-415-gd973e9e70c8f/testrun/28151211/suite/build/test/gcc-13-allmodco=
nfig/details/
> > * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2v=
rtUC0M5hDCMYsjZId4uKICXy7/
> > * Kernel config:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2vrtUC0M5hDCMYsj=
ZId4uKICXy7/config
> >
> > ## Steps to reproduce on arm64
> > - tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
> > --kconfig allmodconfig
> >
> >
> > ## Boot arm64 dragonboard-410c
> > * Boot log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.=
13.y/build/v6.13.11-415-gd973e9e70c8f/testrun/28155237/suite/boot/test/clan=
g-20-lkftconfig/log
> > * Boot history:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v=
6.13.11-415-gd973e9e70c8f/testrun/28149517/suite/boot/test/clang-20-lkftcon=
fig/history/
> > * Boot details:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v=
6.13.11-415-gd973e9e70c8f/testrun/28151170/suite/boot/test/clang-20-lkftcon=
fig/details/
> > * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2v=
rtSg9ngthHYlLhDI9xR3a2T5K/
> > * Kernel config:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2vrtSg9ngthHYlLh=
DI9xR3a2T5K/config
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
> >
>
>
>
>

