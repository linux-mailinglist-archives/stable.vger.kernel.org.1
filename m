Return-Path: <stable+bounces-171756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B83B2BE66
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 12:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E417BD46D
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257123451D3;
	Tue, 19 Aug 2025 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vissM5ZP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38747311C3B
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597777; cv=none; b=Q5+pCTMFHaKKwnR/K9QphpEGA/fLPAUQ4Dtz9L8iVaGJiEQQML90SoVIlniFFkxiEI6GqENpX+s+NC/yyIblNYyadJ8RiSe7CYcm5jSV17WKP5IOmSNw00GIBs6GlRqAyNH7V+HWJ9xEQMpHpm3lrFxFrwZBsi6k+XlkiIArt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597777; c=relaxed/simple;
	bh=fWvo5KjK2dJBbA14ZO9XS8ESyyjsJZdV9RN8NY+K3l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaBR528RJD1U4uDgOzq9GEYzGCLC/7PUV4D0idyrKuR3uIXkUPfnZBGYH7J2T3g53SLr84ANxwyVP0/TzRYvzIhOijzl+VUvHhiKXAxOFpUAWTN45t2Rr4iQuOGuO6KrWB1suYz4r5ppevznw8UFW0yFu+dC9IhhxKOCJ1MnmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vissM5ZP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445826fd9dso58836765ad.3
        for <stable@vger.kernel.org>; Tue, 19 Aug 2025 03:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755597775; x=1756202575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Tie29oHnSkpqRj0PkQrVbAiuDpnacf08DzUmAHW7uY=;
        b=vissM5ZPUHxWOYSkVYa8nT5m7B5MeTAaJzXQ4jG6421ZBpMuVrdiowyqV4M1AbHAon
         Mpup+1nADEojtSWQt6eK9iho3NcYtt/9RxVLEdgdivfTqi5kFhQUXW3476XqumEeLvg+
         VQBF+fwD/WIgbJ6qygVXLSWJtJjSQCjVt/XdFMqwmIMWFYs7p+JorK7mXv2+oH7Qw33U
         mYdc7I2/IpEPkx8o1IWBraoTofP1bPQ3DYGkQ1U/Z+EH24tdKQmEFzb29pAcBnZ2IwG8
         /aqM8XwWQGfhSUOB88NXFar1GzzB/gDgODRSuP7oHjunR1W/1EQBvs7v58NfqJFhQ5IM
         fWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597775; x=1756202575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Tie29oHnSkpqRj0PkQrVbAiuDpnacf08DzUmAHW7uY=;
        b=JY7U0Ir7vhs3rfPWBm/8dK275cJWyla14js9fynquzY4r5Y5WiXt+GW8cO2NZNBk/x
         TEgt4C38fNwIRICJJVbkbTmViRh7az2chQ9sXuOQoUvcwIU1eoonratVanhoUUQ7zetQ
         X5KfqGIEOOVZRqJMQSLrCzOr/szW8nEtab07hurBK7mrGgGZ9eX8xE6Zgb2B3sMoc66+
         teKtSafCTSdNM/TQxmW/utfTOGZMyZrbnAG8Yq/z3TQihA9c13oofb4TfzLD2CjRWGip
         GM1mreD8Qi/uBaYp3ZU06Vz84fY22nhUQQMxJzCyXbXVv72zg6N63uAA9UloZNBezIRI
         rBJA==
X-Gm-Message-State: AOJu0Yxzbl95D1uTt+IT2LN2Euxgr3LPRaMwS2aUsSaRyJ2/OwojjqH+
	vfddCbZ6vj1nt/4mtG3r0TWg7OHX+InAkggQPmHo0FaZWxSD4t9Pc7PrQpEUtsk33loGeRwV63K
	ncgUGy18GQslGrA25+QzAQgYQcqEyzeA1ggNS04JqWw==
X-Gm-Gg: ASbGncuK+yhgw1BcBroaoSYgHDc8C2w1YXdWkDCKgVv7wmaeasXyyGjSOl3JxRST1ET
	fUiSHUaUwW3giOtluJwY7YAGmUfQtn8Ns/ztnx32eEHGbQMYV3HsdTWxQ+7Keo9OLYIVaX5XRS1
	8mJO8nB2oGwZJG7+3zeIguabw5TJ4c6L7uIoOgVAXOOc3MvdJHW9/cR2qpFhXR5TUn6J6VAc1mV
	b5cCY5wkwhhg/+ZcKixO3odVtCbvdAUkr50EyFu
X-Google-Smtp-Source: AGHT+IH1qxD/L9DxRM8R/fDvVjrbOUmUPO9iHU2aUwxAmMLh4FdPNuZ8L5bEMDEdaSHPM/UEntNsAe2gMB9oyWpHlZM=
X-Received: by 2002:a17:903:37ce:b0:240:4b3b:334f with SMTP id
 d9443c01a7336-245e04926b5mr28060595ad.34.1755597775110; Tue, 19 Aug 2025
 03:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818124458.334548733@linuxfoundation.org> <CA+G9fYt5sknJ3jbebYZrqMRhbcLZKLCvTDHfg5feNnOpj-j9Wg@mail.gmail.com>
In-Reply-To: <CA+G9fYt5sknJ3jbebYZrqMRhbcLZKLCvTDHfg5feNnOpj-j9Wg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 19 Aug 2025 15:32:42 +0530
X-Gm-Features: Ac12FXz6P-B_kAS475NZwJ3Ob5a2gv9_oBn8wEtJFzyE39LwJZxKuVFTST5CNfg
Message-ID: <CA+G9fYt6SAsPo6TvfgtnDWHPHO2q7xfppGbCaW0JxpL50zqWew@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/515] 6.15.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, 
	Ben Copeland <benjamin.copeland@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, srinivas.kandagatla@oss.qualcomm.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 00:18, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Mon, 18 Aug 2025 at 18:45, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.15.11 release.
> > There are 515 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 20 Aug 2025 12:43:43 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.11-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Boot regression occurs on the Qualcomm DragonBoard 410c (arm64) with
> stable-rc 6.15.11-rc1. The kernel crashes during early boot with a
> NULL pointer dereference in the Qualcomm SCM/TZMEM subsystem.
>
> The crash originates in qcom_scm_shm_bridge_enable()
> (drivers/firmware/qcom/qcom_scm.c:1618) and is invoked by
> qcom_tzmem_enable() (drivers/firmware/qcom/qcom_tzmem.c:97 and :474).
> This happens while probing SCM during platform initialization, preventing
> the board from reaching userspace due to kernel panic.
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> Boot regression: stable-rc 6.15.11-rc1 arm64 Qualcomm Dragonboard 410c
> Unable to handle kernel NULL pointer dereference
> qcom_scm_shm_bridge_enable

I have reverted the following patch and the regression got fixed.

firmware: qcom: scm: initialize tzmem before marking SCM as available
    [ Upstream commit 87be3e7a2d0030cda6314d2ec96b37991f636ccd ]


>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ## Test log oom03
> [    1.191790] scmi_core: SCMI protocol bus registered
> [    1.194074] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [    1.198306] Mem abort info:
> [    1.207295]   ESR = 0x0000000096000004
> [    1.209796]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    1.213635]   SET = 0, FnV = 0
> [    1.219095]   EA = 0, S1PTW = 0
> [    1.221945]   FSC = 0x04: level 0 translation fault
> [    1.225004] Data abort info:
> [    1.229874]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    1.232977]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    1.238286]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    1.243409] [0000000000000000] user address but active_mm is swapper
> [    1.248798] Internal error: Oops: 0000000096000004 [#1]  SMP
> [    1.255110] Modules linked in:
> [    1.260744] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.15.11-rc1 #1 PREEMPT
> [    1.263622] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> [    1.271517] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    1.278199] pc : qcom_scm_shm_bridge_enable
> (drivers/firmware/qcom/qcom_scm.c:1618)
> [    1.284878] lr : qcom_tzmem_enable
> (drivers/firmware/qcom/qcom_tzmem.c:97
> drivers/firmware/qcom/qcom_tzmem.c:474)
> [    1.290085] sp : ffff80008002b720
> [    1.294508] x29: ffff80008002b7b0 x28: 0000000000000000 x27: 0000000000000000
> [    1.297819] x26: 0000000000000000 x25: 0000000000000000 x24: ffff00003faf6128
> [    1.304937] x23: ffff00003fac6c68 x22: 0000000000000000 x21: ffff0000036ba410
> [    1.312055] x20: ffff0000036ba400 x19: ffff8000831a4000 x18: 0000000000000352
> [    1.319173] x17: 0000000000000000 x16: 0000000000000001 x15: 0000000000000002
> [    1.326292] x14: ffffffffffffffff x13: 0000000000000000 x12: 0000000000000002
> [    1.333410] x11: 0000000000000000 x10: 0000000000000019 x9 : ffff8000813e6d74
> [    1.340527] x8 : 0000000000000000 x7 : 7f7f7f7f7f7f7f7f x6 : fefefeff35302f37
> [    1.347645] x5 : 8080808000000000 x4 : 0000000000000020 x3 : 0000000000000010
> [    1.354763] x2 : 000000000000001c x1 : 000000000000000c x0 : 0000000000000000
> [    1.361882] Call trace:
> [    1.368986] qcom_scm_shm_bridge_enable
> (drivers/firmware/qcom/qcom_scm.c:1618) (P)
> [    1.371251] qcom_tzmem_enable
> (drivers/firmware/qcom/qcom_tzmem.c:97
> drivers/firmware/qcom/qcom_tzmem.c:474)
> [    1.376455] qcom_scm_probe (drivers/firmware/qcom/qcom_scm.c:2256)
> [    1.380534] platform_probe (drivers/base/platform.c:1405)
> [    1.384180] really_probe (drivers/base/dd.c:581)
> [    1.387998] __driver_probe_device (drivers/base/dd.c:?)
> [    1.391647] driver_probe_device (drivers/base/dd.c:829)
> [    1.395987] __driver_attach (drivers/base/dd.c:1216)
> [    1.399978] bus_for_each_dev (drivers/base/bus.c:369)
> [    1.403798] driver_attach (drivers/base/dd.c:1233)
> [    1.407965] bus_add_driver (drivers/base/bus.c:679)
> [    1.411523] driver_register (drivers/base/driver.c:250)
> [    1.415083] __platform_driver_register (drivers/base/platform.c:867)
> [    1.418905] qcom_scm_init (drivers/firmware/qcom/qcom_scm.c:2362)
> [    1.423763] do_one_initcall (init/main.c:1257)
> [    1.427409] do_initcall_level (init/main.c:1318)
> [    1.430969] do_initcalls (init/main.c:1332)
> [    1.435134] do_basic_setup (init/main.c:1355)
> [    1.438434] kernel_init_freeable (init/main.c:1571)
> [    1.442254] kernel_init (init/main.c:1459)
> [    1.446593] ret_from_fork (arch/arm64/kernel/entry.S:865)
> [ 1.449810] Code: a905ffff a904ffff a903ffff f9001bff (f9400100)
> All code
> ========
>    0: a905ffff stp xzr, xzr, [sp, #88]
>    4: a904ffff stp xzr, xzr, [sp, #72]
>    8: a903ffff stp xzr, xzr, [sp, #56]
>    c: f9001bff str xzr, [sp, #48]
>   10:* f9400100 ldr x0, [x8] <-- trapping instruction
>
> Code starting with the faulting instruction
> ===========================================
>    0: f9400100 ldr x0, [x8]
> [    1.453637] ---[ end trace 0000000000000000 ]---
> [    1.459661] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    1.464318] SMP: stopping secondary CPUs
> [    1.471696] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x0000000b ]---
>
> Please refer full test log information in the below links.
>
> ## Source
> * Kernel version: 6.15.11-rc1
> * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> * Git describe: v6.15.9-993-g1cf711608500
> * Git commit: 1cf71160850064e9e506eda37e0386948bedd6b4
> * Architectures: arm64 Dragonboard 410c
> * Toolchains: gcc-13, clang-20
> * Kconfigs: defconfig+lkft
>
> ## Test
> * Boot log: https://qa-reports.linaro.org/api/testruns/29589408/log_file/
> * Boot lava log: https://lkft.validation.linaro.org/scheduler/job/8407660#L2708
> * Boot details:
> https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.15.y/v6.15.9-993-g1cf711608500/log-parser-boot/panic-multiline-kernel-panic-not-syncing-attempted-to-kill-init-exitcode/
> * Boot plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/31SjnwYvj7Mmcay6Qa54CFbNfP9
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31SjkxSlW3Ssjf1eGdFHJPPU4Yw/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/31SjkxSlW3Ssjf1eGdFHJPPU4Yw/config
>
> --
> Linaro LKFT
> https://lkft.linaro.org

- Naresh

