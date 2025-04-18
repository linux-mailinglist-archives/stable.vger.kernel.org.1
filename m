Return-Path: <stable+bounces-134537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC5AA934BB
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 10:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4F919E2997
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 08:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA6A26E159;
	Fri, 18 Apr 2025 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqRffUjz"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7D26B2D2
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965597; cv=none; b=gO4h5zMau0h9bQG+dVCEFHiB5xUXJUi8zRQzhaIjaF6XwFDbCdPmxl0J71AjDTVa5TKHsXXsCrpSLMNlwAq38PrAi7M8Wm17Cap9BhK0qSnQECr7LWppScOJzaUloPL9hvr2mAWhIG4/YAoCx4IaR/sfTPIUTjQQUHlNIHtLLAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965597; c=relaxed/simple;
	bh=OiqGqWs8AWCn10UPsWCFhUhdnJ/S0hvbeYVsdLUaHDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q53jvehoTMbOGshaEHLz9JF+rWeTrkXQPCH3/S4El5XBCUX3DL3IhuEsR1zk90h6LLG/bQhzDaxy/SS0QFvdcvadOZUInFttgZ3GT9JY2Ok4nsCeM1FwcqUHASlEA/lZBHpeA5V4tc1wr9oS/hE4uIq5+2HyuXuEjcsbF3MazC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IqRffUjz; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-528ce9730cfso448835e0c.3
        for <stable@vger.kernel.org>; Fri, 18 Apr 2025 01:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744965593; x=1745570393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRvLcMNQNVWkd/6OrEU0UG9uuRp/Fmw1u7Ys7OYOt+M=;
        b=IqRffUjzBUl5zcPW3BWZFKaPawqW4MNPxwFTHai5wZSkKFcBi9tJaSbzfmX/wh04Vt
         2tdTwWw7Ble2nC1lk7vSfLT9clkV3QrXEKch820jpzIiXqLdVgy+Vmoc02T3YAe2ix1K
         xaeZgWMzIm7U0Tq+4+8uDpLbYhpsTJrFWCFgXmYcMuOTeiTDyB4kzPpVVonAEeK3VINZ
         ZkLsyvD3kmAQyx+7TRyOiP7eMV6wpIvTCSVQ1HwldpD8ydJK7hF31D6NWGLM/pLOYJFU
         d3PWRggc4ySKmEb4YIADv3+fhoAQgOiGIdtU2BsIh+ADz9LAJ3YaBUN/qcIELOzJkdEI
         9QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744965593; x=1745570393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRvLcMNQNVWkd/6OrEU0UG9uuRp/Fmw1u7Ys7OYOt+M=;
        b=uIkFneidjRLtLl2OOR0q8VUggpIxtGozI8EorQbQUFSAwqAZidN2LB93GRnInMkCFY
         Fh4Iisc4yNpTMAC/WJz4ujFd9NnCppIPLQic9FbJZV5D5DXOO9fqADQNOLIUrDeaxh4u
         oyuqk/hYOUxQou1MMpktSkGcoBhXTPt0KcLPYPfxbUPcr7bMapKy+077vfrOARa3PdOb
         gcG1Oh33JmWAbK7tC2u3O9eKTErJtz0SSY8orch9Ow9b2N0+QmogPGxPsL54o+7KZCf3
         09v6Dp26rf6ngtsNIamtwSWEVRoAj5fqnP9lX57jPmcMyPSom4CfXWIQXWJoDf13iFz8
         33GA==
X-Gm-Message-State: AOJu0YyrQaxk+AUvmuKNekoEOW8zWSptgkSfGCIGdWsxnuB0Quhafqf9
	BqatsFrY7Mz9WkREo/FMBWkCZqV/hVAkzqDdVHalCfPOozo3ei7m/81dKo+yevg7aQHaloWpfhR
	IQUyg1HICsBBRpskRfdvX361V1cxtf/ZGLF8OiQ==
X-Gm-Gg: ASbGncu7CyoszAUxl+tSxLrAiMjyYBFSGR2Xtqy6QCrBK91vEocsgabS1CmPgzgEkvQ
	MnRqcvRFe9fcH2GebKfSu0ej0iowBx/jMIaxr+rwVhUCsXVcWCBO1IzXE5B6o2+L/nOs9XYWcL2
	2DxQZ4lQ1poWNytok1+zYxJSTFztGggIBz+lSeINXZYXieqhJayaOFSw==
X-Google-Smtp-Source: AGHT+IGFuPrltiP+2ziH4fTISJwFEPeAggDjJNjT/ozZziWj5TtqF1X0j1T7ygWisxLEQpOE/Mg4gByq4GRwpm1BpVc=
X-Received: by 2002:a05:6122:1791:b0:526:483:95fd with SMTP id
 71dfb90a1353d-529255099femr1352158e0c.10.1744965593284; Fri, 18 Apr 2025
 01:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417175111.386381660@linuxfoundation.org>
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 18 Apr 2025 14:09:41 +0530
X-Gm-Features: ATxdqUEDoqR8p1zJdruYCSbIfSEgIUwYLVEiH-a9YbJJCV6oX9DxN1sbjVENomg
Message-ID: <CA+G9fYstVDU_e27mkqEJC0O742zUb0A=wny59n2SiiH7Z_ouJg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/414] 6.13.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, Christian Eggers <ceggers@arri.de>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Apr 2025 at 23:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.12 release.
> There are 414 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 19 Apr 2025 17:49:48 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The following two regressions found on stable-rc 6.13.12-rc1 review,

1)
Regressions on arm64 allmodconfig and allyesconfig builds failed
on the stable rc 6.13.12-rc1.

2)
Regressions on arm64 dragonboard 410c boot failed with lkftconfig
on the stable rc 6.13.12-rc1.

First seen on the 6.13.12-rc1
Good: v6.13.11
Bad:  v6.13.11-415-gd973e9e70c8f

Regressions found on arm64:
- build/gcc-13-allmodconfig
- build/gcc-13-allyesconfig
- build/clang-20-allmodconfig
- build/clang-20-allyesconfig

Regressions found on arm64 dragonboard-410c:
- boot/clang-20-lkftconfig

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Build regression: arm64 ufs-qcom.c implicit declaration 'devm_of_qcom_ice_g=
et'

Boot regression: arm64 dragonboard 410c WARNING regulator core.c regulator_=
put

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log arm64
drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_ice_init':
drivers/ufs/host/ufs-qcom.c:121:15: error: implicit declaration of
function 'devm_of_qcom_ice_get'; did you mean 'of_qcom_ice_get'?
[-Werror=3Dimplicit-function-declaration]
121 |         ice =3D devm_of_qcom_ice_get(dev);
|               ^~~~~~~~~~~~~~~~~~~~
|               of_qcom_ice_get
drivers/ufs/host/ufs-qcom.c:121:13: error: assignment to 'struct
qcom_ice *' from 'int' makes pointer from integer without a cast
[-Werror=3Dint-conversion]
121 |         ice =3D devm_of_qcom_ice_get(dev);
|             ^
cc1: all warnings being treated as errors


## Boot log arm64 dragonboard 410c:
[    3.863371]  remoteproc:smd-edge: failed to parse smd edge
[    3.989304] msm_hsusb 78d9000.usb: Failed to create device link
(0x180) with supplier remoteproc for /soc@0/usb@78d9000/ulpi/phy
[    3.993079] qcom-clk-smd-rpm
remoteproc:smd-edge:rpm-requests:clock-controller: Error registering
SMD clock driver (-1431655766)
[    4.000071] qcom-clk-smd-rpm
remoteproc:smd-edge:rpm-requests:clock-controller: probe with driver
qcom-clk-smd-rpm failed with error -1431655766
[    4.028243] sdhci_msm 7864900.mmc: Got CD GPIO
[    4.039730] s3: Bringing 0uV into 1250000-1250000uV
[    4.039886] s3: failed to enable: (____ptrval____)
[    4.043538] ------------[ cut here ]------------
[    4.048299] WARNING: CPU: 0 PID: 46 at
drivers/regulator/core.c:2396 regulator_put
(drivers/regulator/core.c:2419 drivers/regulator/core.c:2417)
[    4.053085] Modules linked in:
[    4.053087] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    4.060581] sdhci_msm 7864900.mmc: Got CD GPIO
[    4.061476]
[    4.061484] CPU: 0 UID: 0 PID: 46 Comm: kworker/u16:2 Not tainted
6.13.12-rc1 #1
[    4.061495] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    4.061501] Workqueue: async async_run_entry_fn
[    4.069821] clk: Disabling unused clocks
[    4.071199]
[    4.071204] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    4.076270] PM: genpd: Disabling unused power domains
[    4.077108] pc : regulator_put (drivers/regulator/core.c:2419
drivers/regulator/core.c:2417)
[    4.084640] qcom-rpmpd
remoteproc:smd-edge:rpm-requests:power-controller: failed to sync cx:
-1431655766
[    4.091163] lr : regulator_put (drivers/regulator/core.c:2390
drivers/regulator/core.c:2417)
[    4.091174] sp : ffff8000832eba50
[    4.091178] x29: ffff8000832eba50
[    4.095545] qcom-rpmpd
remoteproc:smd-edge:rpm-requests:power-controller: failed to sync
cx_ao: -1431655766
[    4.099579]  x28: 0000000000000000 x27: ffff800081b54020
[    4.099592] x26: ffff800081b53fe0 x25: 0000000000000001
[    4.101088] qcom-rpmpd
remoteproc:smd-edge:rpm-requests:power-controller: failed to sync
cx_vfc: -1431655766
[    4.107745]  x24: 00000000aaaaaaaa
[    4.107752] x23: ffff000004362a80 x22: ffff0000045fa800
[    4.112988] qcom-rpmpd
remoteproc:smd-edge:rpm-requests:power-controller: failed to sync mx:
-1431655766
[    4.116953]  x21: ffff0000045fa800
[    4.116961] x20: ffff0000038dfcc0 x19: ffff000003885d80 x18: 00000000000=
00068
[    4.126432] qcom-rpmpd
remoteproc:smd-edge:rpm-requests:power-controller: failed to sync
mx_ao: -1431655766
[    4.130312]
[    4.130315] x17: 0000000000000000 x16: 0000000000000001 x15: 00000000000=
00003
[    4.133541] ALSA device list:
[    4.136833]
[    4.136836] x14: ffff80008284e1f0 x13: 0000000000000003 x12: 00000000000=
00003
[    4.146411]   No soundcards found.
[    4.151929]
[    4.151933] x11: 0000000000000000 x10: 0000000000000000 x9 : 00000000000=
00000
[    4.230459] x8 : 0000000000000001 x7 : 0720072007200720 x6 : 07200720072=
00720
[    4.230478] x5 : ffff000003201f00 x4 : 0000000000000000 x3 : 00000000000=
00000
[    4.230491] x2 : 0000000000000000 x1 : ffff8000801fe6e4 x0 : ffff0000038=
85d80
[    4.230506] Call trace:
[    4.230512] regulator_put (drivers/regulator/core.c:2419
drivers/regulator/core.c:2417) (P)
[    4.230529] regulator_register (drivers/regulator/core.c:5823)
[    4.230543] devm_regulator_register (drivers/regulator/devres.c:477)
[    4.230554] rpm_reg_probe
(drivers/regulator/qcom_smd-regulator.c:1425
drivers/regulator/qcom_smd-regulator.c:1462)
[    4.230569] platform_probe (drivers/base/platform.c:1405)
[    4.230583] really_probe (drivers/base/dd.c:581 drivers/base/dd.c:658)
[    4.280941] __driver_probe_device (drivers/base/dd.c:0)
[    4.284581] driver_probe_device (drivers/base/dd.c:830)
[    4.288919] __device_attach_driver (drivers/base/dd.c:959)
[    4.292911] bus_for_each_drv (drivers/base/bus.c:459)
[    4.297426] __device_attach_async_helper
(arch/arm64/include/asm/jump_label.h:36 drivers/base/dd.c:988)
[    4.301593] async_run_entry_fn
(arch/arm64/include/asm/jump_label.h:36 kernel/async.c:131)
[    4.306626] process_scheduled_works (kernel/workqueue.c:3241
kernel/workqueue.c:3317)
[    4.310533] worker_thread (include/linux/list.h:373
kernel/workqueue.c:946 kernel/workqueue.c:3399)
[    4.315305] kthread (kernel/kthread.c:391)
[    4.318863] ret_from_fork (arch/arm64/kernel/entry.S:863)
[    4.322250] ---[ end trace 0000000000000=C3=AF=C2=BF=C2=BD[    4.330596]=
 s4:
failed to enable: (____ptrval____)
[    4.330739] ------------[ cut here ]------------
[    4.334298] WARNING: CPU: 3 PID: 46 at
drivers/regulator/core.c:2396 regulator_put
(drivers/regulator/core.c:2419 drivers/regulator/core.c:2417)
[    4.339086] Modules linked in:
[    4.347491] CPU: 3 UID: 0 PID: 46 Comm: kworker/u16:2 Tainted: G
    W          6.13.12-rc1 #1
[    4.350372] Tainted: [W]=3DWARN
[    4.359293] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    4.360333] sdhci_msm 7864900.mmc: Got CD GPIO
[    4.362242] Workqueue: async async_run_entry_fn
[    4.373272] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    4.377705] pc : regulator_put (drivers/regulator/core.c:2419
drivers/regulator/core.c:2417)
[    4.384641] lr : regulator_put (drivers/regulator/core.c:2390
drivers/regulator/core.c:2417)
[    4.388807] sp : ffff8000832eba50
[    4.392711] x29: ffff8000832eba50 x28: 0000000000000000 x27: ffff800081b=
54040
[    4.395934] x26: ffff800081b53fe0 x25: 0000000000000001 x24: 00000000aaa=
aaaaa
[    4.403052] x23: ffff000009d10c80 x22: ffff000009c48800 x21: ffff000009c=
48800
[    4.410170] x20: ffff0000044e2900 x19: ffff000003f90840 x18: ffff8000817=
025c0
[    4.417287] x17: 0000000000000000 x16: 0000000000000001 x15: 00000000000=
00003
[    4.424405] x14: ffff80008284e1f0 x13: 0000000000000003 x12: 00000000000=
00003
[    4.431524] x11: 0000000000000000 x10: 0000000000000000 x9 : 00000000000=
00000
[    4.438642] x8 : 0000000000000001 x7 : 0720072007200720 x6 : 07200720072=
00720
[    4.445760] x5 : ffff000003201f00 x4 : 0000000000000000 x3 : 00000000000=
00000
[    4.452878] x2 : 0000000000000000 x1 : ffff8000801fe6e4 x0 : ffff000003f=
90840
[    4.459997] Call trace:
[    4.467103] regulator_put (drivers/regulator/core.c:2419
drivers/regulator/core.c:2417) (P)
[    4.469364] regulator_register (drivers/regulator/core.c:5823)
[    4.473530] devm_regulator_register (drivers/regulator/devres.c:477)
[    4.477437] rpm_reg_probe
(drivers/regulator/qcom_smd-regulator.c:1425
drivers/regulator/qcom_smd-regulator.c:1462)
[    4.481948] platform_probe (drivers/base/platform.c:1405)
[    4.485681] really_probe (drivers/base/dd.c:581 drivers/base/dd.c:658)
[    4.489415] __driver_probe_device (drivers/base/dd.c:0)
[    4.493062] driver_probe_device (drivers/base/dd.c:830)
[    4.497401] __device_attach_driver (drivers/base/dd.c:959)
[    4.501396] bus_for_each_drv (drivers/base/bus.c:459)
[    4.505908] __device_attach_async_helper
(arch/arm64/include/asm/jump_label.h:36 drivers/base/dd.c:988)
[    4.510078] async_run_entry_fn
(arch/arm64/include/asm/jump_label.h:36 kernel/async.c:131)
[    4.515109] process_scheduled_works (kernel/workqueue.c:3241
kernel/workqueue.c:3317)
[    4.519017] worker_thread (include/linux/list.h:373
kernel/workqueue.c:946 kernel/workqueue.c:3399)
[    4.523790] kthread (kernel/kthread.c:391)
[    4.527347] ret_from_fork (arch/arm64/kernel/entry.S:863)
[    4.530735] ---[ end trace 0000000000000000 ]---
[    4.535440] l2: Bringing 0uV into 1200000-1200000uV
[    4.539050] qcom_rpm_smd_regulator
remoteproc:smd-edge:rpm-requests:regulators: l2:
devm_regulator_register() failed, ret=3D-517
[    4.544075] Unable to handle kernel paging request at virtual
address ffffffffaaaaae6a
[    4.554991] Mem abort info:
[    4.562869]   ESR =3D 0x0000000096000005
[    4.565560]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    4.569384]   SET =3D 0, FnV =3D 0
[    4.574846]   EA =3D 0, S1PTW =3D 0
[    4.577710]   FSC =3D 0x05: level 1 translation fault
[    4.580755] Data abort info:
[    4.585612]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
[    4.588742]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[    4.594036]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[    4.599158] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000824a40=
00
[    4.604544] [ffffffffaaaaae6a] pgd=3D0000000000000000,
p4d=3D0000000082e7d403, pud=3D0000000000000000
[    4.611238] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
[    4.619631] Modules linked in:
[    4.625875] CPU: 3 UID: 0 PID: 46 Comm: kworker/u16:2 Tainted: G
    W          6.13.12-rc1 #1
[    4.629015] Tainted: [W]=3DWARN
[    4.637936] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    4.640900] Workqueue: async async_run_entry_fn
[    4.647664] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    4.651924] pc : regulator_unregister (drivers/regulator/core.c:5850)
[    4.658861] lr : devm_rdev_release (drivers/regulator/devres.c:453)
[    4.663721] sp : ffff8000832ebaf0
[    4.667974] x29: ffff8000832ebb10 x28: ffff000004520000 x27: 00000000000=
001c8
[    4.671195] x26: ffff0000042c6040 x25: ffff000009d10c00 x24: ffff0000045=
20000
[    4.678311] x23: ffff80008280ed00 x22: ffff8000823b07cd x21: ffff000003f=
90780
[    4.685431] x20: ffff000009c7b810 x19: ffff8000832ebbb8 x18: 00000000000=
00068
[    4.692548] x17: 6f74616c75676572 x16: 3a73747365757165 x15: 00000ff0000=
3fd3a
[    4.699666] x14: 000000000000ffff x13: 0000000000000020 x12: 00000000000=
00003
[    4.706784] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff800080b=
52bb0
[    4.713901] x8 : 50dfedbf8d5fec00 x7 : 3d4e5f454c424954 x6 : 000000004e5=
14553
[    4.721021] x5 : 0000000000000008 x4 : ffff80008222c178 x3 : 00000000000=
00010
[    4.728139] x2 : ffff8000832eba70 x1 : ffff000003f90800 x0 : ffffffffaaa=
aaaaa
[    4.735257] Call trace:
[    4.742362] regulator_unregister (drivers/regulator/core.c:5850) (P)
[    4.744625] devm_rdev_release (drivers/regulator/devres.c:453)
[    4.749484] release_nodes (drivers/base/devres.c:506)
[    4.753388] devres_release_all (drivers/base/devres.c:0)
[    4.756950] really_probe (drivers/base/dd.c:551 drivers/base/dd.c:724)
[    4.760941] __driver_probe_device (drivers/base/dd.c:0)
[    4.764588] driver_probe_device (drivers/base/dd.c:830)
[    4.768842] __device_attach_driver (drivers/base/dd.c:959)
[    4.772836] bus_for_each_drv (drivers/base/bus.c:459)
[    4.777348] __device_attach_async_helper
(arch/arm64/include/asm/jump_label.h:36 drivers/base/dd.c:988)
[    4.781518] async_run_entry_fn
(arch/arm64/include/asm/jump_label.h:36 kernel/async.c:131)
[    4.786552] process_scheduled_works (kernel/workqueue.c:3241
kernel/workqueue.c:3317)
[    4.790458] worker_thread (include/linux/list.h:373
kernel/workqueue.c:946 kernel/workqueue.c:3399)
[    4.795229] kthread (kernel/kthread.c:391)
[    4.798788] ret_from_fork (arch/arm64/kernel/entry.S:863)
[ 4.802179] Code: d5384108 f9430508 f81f83a8 b4000bc0 (f941e014)
All code
=3D=3D=3D=3D=3D=3D=3D=3D

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    4.805745] ---[ end trace 0000000000000000 ]---
[   14.254255] platform ci_hdrc.0: deferred probe pending: (reason unknown)

## Source
* Kernel version: 6.13.12-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
* Git sha: d973e9e70c8f0ad1a53a96ce48db9f3f882db4a8
* Git describe: v6.13.11-415-gd973e9e70c8f
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.13=
.11-415-gd973e9e70c8f/
* Architectures: arm64
* Toolchains: clang-20, gcc-13
* Kconfigs: allmodconfig, allyesconfig

## Build arm64
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.=
y/build/v6.13.11-415-gd973e9e70c8f/testrun/28151211/suite/build/test/gcc-13=
-allmodconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.11-415-gd973e9e70c8f/testrun/28151211/suite/build/test/gcc-13-allmodconfig=
/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.11-415-gd973e9e70c8f/testrun/28151211/suite/build/test/gcc-13-allmodconfig=
/details/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2vrtUC=
0M5hDCMYsjZId4uKICXy7/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2vrtUC0M5hDCMYsjZId4=
uKICXy7/config

## Steps to reproduce on arm64
- tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig allmodconfig


## Boot arm64 dragonboard-410c
* Boot log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y=
/build/v6.13.11-415-gd973e9e70c8f/testrun/28155237/suite/boot/test/clang-20=
-lkftconfig/log
* Boot history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.11-415-gd973e9e70c8f/testrun/28149517/suite/boot/test/clang-20-lkftconfig/=
history/
* Boot details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.11-415-gd973e9e70c8f/testrun/28151170/suite/boot/test/clang-20-lkftconfig/=
details/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2vrtSg=
9ngthHYlLhDI9xR3a2T5K/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2vrtSg9ngthHYlLhDI9x=
R3a2T5K/config

--
Linaro LKFT
https://lkft.linaro.org

