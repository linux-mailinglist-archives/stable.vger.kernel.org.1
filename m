Return-Path: <stable+bounces-126929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6178A74965
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 12:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39BA47A3F66
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 11:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045891DD877;
	Fri, 28 Mar 2025 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVvQgbpE"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C340A2135CE
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743162278; cv=none; b=Z16pbDb+TJeHSVPmTIz6m88XNCXRgpcj2ZwcK3nDmf33cAScLGooR4L/cnMiL2GiBBbG+3MQgsSJfG4QQUUxOKGn5ZVGsIB0x+9NUe2uB1k/ngQ7k/weR6Vj1dlQuOy9H1e2yVkFtRXeRPXTAX+lgsFRxut6+2IwfCJ86p6HwRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743162278; c=relaxed/simple;
	bh=YwgP5Lj6FSo3mHH2PjhycSpGK3t+yNjAzaGWz6a7Poc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYrLCJ7JBSRPbKwMHnIsY4nQdGQrISUAah4hMBx01dcfOOSm8EfLQesyWay7M79LWXYR1UW7nEXvfvpN+rih2e7tD5cVRJPktEgXdUwhWz2S1mpQu4ITXBJhHMg6AvbIO17p1Cj+GtuzwcztFQsBHGhyZskdz41FIXXLbxy/Jow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NVvQgbpE; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-523fa0df55dso2940025e0c.1
        for <stable@vger.kernel.org>; Fri, 28 Mar 2025 04:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743162275; x=1743767075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w2qqfblrO9ZiItp9BFItmCQdoEnMkY7wNDvK733cLvs=;
        b=NVvQgbpEZ4XLqLw50tPS1aSzIFEa1oqqFDAxw/2YQ6qczqpGrBShq1FFCgjVndbRq6
         PPNeQ9+yEFWqMborn60KtYSb+Wm4A5wW+eQ/I+BDur7Jxu/AeKfSUFxZ5kR+sX7Dz2FI
         wEj02X+D3K7F+MjEu0CX5bhYu1K+ET2H9WNnzH5AvnqD5LVRTZothW0L9Ni7JAh9UPBM
         HL7CcYxJrvdp2F0giShQxxe17P4XTg2CcnT8MXnnketP0709sUyUnHZOq7Cjr/DbXsCm
         +Fjbm9P0tiScs9ADB37Rhlat+0DN/xMZ/mX4AEvHZzEgvd84UmY/irG4+QtVnBisNbyP
         ALYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743162275; x=1743767075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2qqfblrO9ZiItp9BFItmCQdoEnMkY7wNDvK733cLvs=;
        b=aTl+pUkbn8GDogiUnPfNQc7bW9GSorVHZwSRgeqcXjLk3iIoiX6VvSPl5hl/2fXWwg
         G74D+/jPFfM/i2ZEnVAtT/nNOUXAkrk9uKe2wKcHQiOSOS+cfNqh1pRpfRz0JuXO7Y34
         un3xjY5gOgrxQRfwIjuaW2pKbj4zoEnTVySiNNKcrg044/+lsEeMLi6i6BC4m1qlvwIO
         Idl6yuvq9cbP1xid50p9Kf0tchpKZGF1hoz33l6Au6WPAFXP0o1aGFEZObFq0fPYi1ur
         wuDbEg1S7E//qQhYqnQ53dlB/dDCI6tF+hf/T9MOHmrHNcniwuAOjoyrhp2DthL6nr2J
         tULw==
X-Gm-Message-State: AOJu0YwVxtmn1pnxi8TFDr3uQqXSHvKgp916BIFfDQDmYJywvBg5A/dZ
	8iBWDPsk2AeYPl1519jjsvAMTiSuvc6QvTna6JzOTHDpdnQ2z/b3NFm8o+CqLaY22mpn6cKCZ3r
	SQzniG5qtZ+TWosx9fxwMd2qizoI2Q+fNlE0j6Q==
X-Gm-Gg: ASbGncsbgUptoBfJL9NkhWrm37ZorTUNFq1UjAnC4FeUeKy0QLf9qoADFJWTKQgNpLz
	6J58qCuZm50UEAqS6f9Kra2VIKvvzBW1bVwbPV2QLSJS/CkP4JLlaxU0DcoHQ5E/rNWQEXxAq+m
	V0KwobS6rTDLhz16sOGS8k/8Jilqxb4pivdcah3GYBub+jIUAdqTbzO6zuEJM=
X-Google-Smtp-Source: AGHT+IH5gt1g7W9zzSWKPRy+Vjm/b0NveXSpYYJFrnYWc6QvBz8Ch7D3H4qE7WYa/AwxnGF1KMNk7xnOtPg2RIJG4u0=
X-Received: by 2002:a67:ed0e:0:b0:4bd:379c:4037 with SMTP id
 ada2fe7eead31-4c6c280d38amr917768137.9.1743162275354; Fri, 28 Mar 2025
 04:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326154346.820929475@linuxfoundation.org>
In-Reply-To: <20250326154346.820929475@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 28 Mar 2025 17:14:23 +0530
X-Gm-Features: AQ5f1JrEMR3q_aVnbCTb0wQN7NNnYC69mmmv8o9OofjDoV25fDlFoUyGvppLF6I
Message-ID: <CA+G9fYuY7iX+3=Yn77JjgiDiZAZNcpe0cW-y_M3sazhFN7dGLw@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/76] 6.6.85-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Cgroups <cgroups@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 21:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.85 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 28 Mar 2025 15:43:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.85-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm64 devices cpu hotplug tests failed with gcc-13 and
clang-20 the stable-rc 6.6.85-rc2

These regressions are the same as stable-rc 6.1 cpu hotplug regressions.

First seen on the 6.6.85-rc2
Good: v6.6.83
Bad: 6.6.85-rc2

* dragonboard 845c
- selftests: cpu-hotplug: cpu-on-off-test.sh
- rseq_basic_percpu_ops_mm_cid_test
- rseq_basic_percpu_ops_test
- ltp-controllers: cpuset_hotplug_test.sh

Regression Analysis:
- New regression? yes
- Reproducibility? Yes

Test regression: arm64 arm cpuhotplug kernel NULL pointer dereference
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log
command: cpuset_hotplug_test.sh
cpuset_hotplug 1 TINFO: CPUs are numbered continuously starting at 0 (0-7)
cpuset_hotplug 1 TINFO: Nodes are numbered continuously starting at 0 (0)
[  607.606520] IRQ118: set affinity failed(-22).
[  607.606657] IRQ165: set affinity failed(-22).
[  607.606670] IRQ167: set affinity failed(-22).
[  607.606764] IRQ206: set affinity failed(-22).
[  607.606775] IRQ207: set affinity failed(-22).
[  607.606786] IRQ208: set affinity failed(-22).
[  607.606797] IRQ209: set affinity failed(-22).
[  607.606807] IRQ210: set affinity failed(-22).
[  607.606816] IRQ211: set affinity failed(-22).
[  607.606825] IRQ212: set affinity failed(-22).
[  607.610148] psci: CPU1 killed (polled 0 ms)
cpuset_hotplug 1 TPASS: Cpuset vs CPU hotplug test succeeded.
[  608.845868] Detected VIPT I-cache on CPU1
[  608.845955] GICv3: CPU1: found redistributor 100 region 0:0x0000000017a80000
[  608.846049] CPU1: Booted secondary processor 0x0000000100 [0x517f803c]
[  609.103460] psci: CPU1 killed (polled 0 ms)
[  609.149280] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[  609.162506] Mem abort info:
[  609.170513]   ESR = 0x0000000096000004
[  609.177143]   EC = 0x25: DABT (current EL), IL = 32 bits
[  609.184803]   SET = 0, FnV = 0
[  609.190745]   EA = 0, S1PTW = 0
[  609.196414]   FSC = 0x04: level 0 translation fault
[  609.202957] Data abort info:
[  609.208001]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  609.215282]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  609.221926]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  609.229042] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000108ec5000
[  609.238062] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  609.246582] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[  609.254427] Modules linked in: ax88179_178a usbnet fuse ip_tables
x_tables snd_soc_hdmi_codec venus_enc venus_dec videobuf2_dma_contig
mcp251xfd xhci_pci xhci_pci_renesas lontium_lt9611 can_dev qcom_pon
qcom_spmi_adc5 snd_soc_sdm845 rtc_pm8xxx ath10k_snoc leds_qcom_lpg
snd_soc_rt5663 qcom_vadc_common venus_core ath10k_core
snd_soc_qcom_common snd_soc_rl6231 led_class_multicolor
qcom_spmi_temp_alarm ath crct10dif_ce qcom_stats v4l2_mem2mem
soundwire_bus msm qcom_camss videobuf2_dma_sg videobuf2_v4l2
videobuf2_memops mac80211 ocmem hci_uart gpu_sched phy_qcom_qmp_combo
btqca drm_dp_aux_bus btbcm reset_qcom_pdc drm_display_helper
camcc_sdm845 bluetooth qcom_q6v5_mss spi_geni_qcom i2c_qcom_geni typec
gpi videobuf2_common qcom_rng phy_qcom_qmp_usb coresight_stm stm_core
qrtr qcrypto cfg80211 qcom_q6v5_pas ufs_qcom phy_qcom_qmp_ufs
phy_qcom_qmp_pcie lmh rfkill slim_qcom_ngd_ctrl icc_osm_l3
qcom_pil_info slimbus qcom_wdt qcom_q6v5 pdr_interface
display_connector llcc_qcom drm_kms_helper qcom_sysmon qcom_common
[  609.254673]  qcom_glink_smem mdt_loader icc_bwmon drm qmi_helpers
socinfo backlight rmtfs_mem
[  609.364260] CPU: 0 PID: 388 Comm: kworker/0:3 Not tainted 6.6.85-rc2 #1
[  609.373013] Hardware name: Thundercomm Dragonboard 845c (DT)
[  609.380818] Workqueue: events work_for_cpu_fn
[  609.387320] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  609.396471] pc : memcg_hotplug_cpu_dead
(include/linux/percpu-refcount.h:174
include/linux/percpu-refcount.h:332
include/linux/percpu-refcount.h:351 include/linux/memcontrol.h:809
mm/memcontrol.c:2392)
[  609.403452] lr : memcg_hotplug_cpu_dead
(include/linux/percpu-refcount.h:174
include/linux/percpu-refcount.h:332
include/linux/percpu-refcount.h:351 include/linux/memcontrol.h:809
mm/memcontrol.c:2392)
[  609.410429] sp : ffff80008107bc50
[  609.415903] x29: ffff80008107bc50 x28: 0000000000000000 x27: ffffad8428896ad8
[  609.425251] x26: 0000000000000028 x25: ffff60fdbd4a1a58 x24: ffffad842887eb00
[  609.434605] x23: 0000000000000000 x22: ffffad84288329c0 x21: 0000000000000000
[  609.443957] x20: ffffb37994c7e000 x19: 0000000000000000 x18: 00000000b8fbaf46
[  609.453329] x17: 0000000000000000 x16: 000000000000030d x15: 0000000000000049
[  609.462707] x14: 0000000000000197 x13: ffff800081078000 x12: ffff80008107c000
[  609.472102] x11: abc96095bed38f00 x10: 0000000000000000 x9 : 0000000000000001
[  609.481495] x8 : ffff60fd47b4d280 x7 : 000000f2b5503510 x6 : 0000000000300000
[  609.490872] x5 : 00000000801c0011 x4 : 0000000000000000 x3 : ffff80008107bc00
[  609.500269] x2 : ffff60fd47b4d280 x1 : ffffad84264a670c x0 : ffff60fdbd4b09c0
[  609.509655] Call trace:
[  609.514295] memcg_hotplug_cpu_dead
(include/linux/percpu-refcount.h:174
include/linux/percpu-refcount.h:332
include/linux/percpu-refcount.h:351 include/linux/memcontrol.h:809
mm/memcontrol.c:2392)
[  609.520968] cpuhp_invoke_callback (kernel/cpu.c:196)
[  609.527648] _cpu_down (kernel/cpu.c:0 kernel/cpu.c:980
kernel/cpu.c:1415 kernel/cpu.c:1476)
[  609.533283] __cpu_down_maps_locked (kernel/cpu.c:1507)
[  609.539889] work_for_cpu_fn (kernel/workqueue.c:5644)
[  609.545882] process_scheduled_works (kernel/workqueue.c:2639
kernel/workqueue.c:2711)
[  609.552752] worker_thread (include/linux/list.h:373
kernel/workqueue.c:841 kernel/workqueue.c:2793)
[  609.558741] kthread (kernel/kthread.c:390)
[  609.564193] ret_from_fork (arch/arm64/kernel/entry.S:862)
[ 609.570006] Code: d51b4235 8b160280 97ffebe0 97f694b5 (f9400269)
All code
========

Code starting with the faulting instruction
===========================================
[  609.578382] ---[ end trace 0000000000000000 ]---

## Test log 2
kselftest: Running tests in rseq
TAP version 13
1..9
# timeout set to 0
# selftests: rseq: basic_test
# testing current cpu
# basic_test: basic_test.c:30: test_cpu_pointer: Assertion
`sched_getcpu() == i' failed.
# Aborted
not ok 1 selftests: rseq: basic_test # exit=134
# timeout set to 0
# selftests: rseq: basic_percpu_ops_test
# spinlock
# Segmentation fault
not ok 2 selftests: rseq: basic_percpu_ops_test # exit=139
# timeout set to 0
# selftests: rseq: basic_percpu_ops_mm_cid_test
# spinlock
# Segmentation fault
not ok 3 selftests: rseq: basic_percpu_ops_mm_cid_test # exit=139


## Source
* Kernel version: 6.6.85-rc2
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 0bf29b955eacbaba63be87642f2b48f8a7c45055
* Git describe: v6.6.83-244-g0bf29b955eac
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-244-g0bf29b955eac

## Test
* Test log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-244-g0bf29b955eac/testrun/27798819/suite/log-parser-test/test/internal-error-oops-oops-preempt-smp-ada4e7ef482d5d7749a545db62c1f4c97ae5ba4633a23ce654828f2d2e816088/log
* Test history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-244-g0bf29b955eac/testrun/27798819/suite/log-parser-test/test/internal-error-oops-oops-preempt-smp-ada4e7ef482d5d7749a545db62c1f4c97ae5ba4633a23ce654828f2d2e816088/history/
* Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-244-g0bf29b955eac/testrun/27798819/suite/log-parser-test/test/internal-error-oops-oops-preempt-smp-ada4e7ef482d5d7749a545db62c1f4c97ae5ba4633a23ce654828f2d2e816088/
* Test link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2urSrAikljwhAncEhDz6bSva1iJ/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2urSrAikljwhAncEhDz6bSva1iJ/config


--
Linaro LKFT
https://lkft.linaro.org

