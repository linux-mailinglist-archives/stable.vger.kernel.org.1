Return-Path: <stable+bounces-112130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C658A26F50
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 11:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F1A7A067C
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E4209668;
	Tue,  4 Feb 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ept8ne4U"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569B208989
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664940; cv=none; b=QCGcVs4Z4RN7T3oANf6IgRyNWLvuwe7CeO9Pzv8UpgVCCQqkbM+UPdiU16bMySsD2UejiApZsh1Ltzkc+EZxpK72YiVUkrOTv2KqlH7Imzm3Y06u5saw5kBrwHLqBWbyhpO3KZLv4WglqluGPYE1ytRGFJhVDCpLtHRj38N0xvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664940; c=relaxed/simple;
	bh=2LvEQ0wOTFaWhwa9DPu3nbG0sycZBiQlHMufDNDdkDo=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=b47y+We7oR8ybylDOPUA6e03mx+a/8LAuLWK1LPzWAoXNpgNcw+EhdrCu6l6G7LKf5pQAEWN45UV6ZsHmOrntjBI+Db6aMbtmIg32K1WS6RjEaD6fVjR9LN5J61BS/Uh3MvuncAyWDSphU9mFf/5gkcLAOTcyZ7F++vz8viLCEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ept8ne4U; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6f973c0808dso11000237b3.0
        for <stable@vger.kernel.org>; Tue, 04 Feb 2025 02:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1738664937; x=1739269737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ubwaL7oEStadrLkrpZmo0dMLzr7dWhUY7RZXXJTTuIo=;
        b=ept8ne4UmQ1b7dteke2OD6I1Qqm0tNidyPXt6PGdk5O2s78sOnZvMDLwiquo+MMbv9
         EhRWrXuH7tUW+6MwYG+wxh2gH801lFOLb0rRUnuFWgSRFP9R379mvLzb+jIWLoZu8PHV
         ql7ymPXZ+S+yHid9wE/SVMTY0nORTI3giKTmHTREXtqDgEk6e9okHcV4K2GxaFKylamk
         x0/2LTgzcuVNJflDYesIn1mFKYIcA061EwSZQhHgDz9c+RNagpn+pyiu5cMWOSOfaGFv
         5FcpRZnn7XcUSjcNRxKaUZQykJtr0oFKKjOhvPPvI5Vv6ZfW9W3oaqyTbqVsB93BwqHq
         amtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738664937; x=1739269737;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubwaL7oEStadrLkrpZmo0dMLzr7dWhUY7RZXXJTTuIo=;
        b=WRjpP0QNuoGZXu3jeh6NYWCPouPp080qB10FWmIY293GBBuoOIa3bfwVudacB4iTZ7
         fLMcZj+UmE8L2u+G/CMA7/060mdiDWQZsv3As6+qkYPEiZCiuxOnM++IqCmZb+lJlfh9
         79fFqhDwc/mTet7NxngJGLVQm7gAwV16t4hKqP9ZfVfnmcGAfEf6y/v3BzscJuKLt0bT
         QBiSRueLMzWy4wxiNL0wK6Oyw3WU/e4CQzc533pFRjz9G7OVWNN/IpDK3KV9EFLIc24K
         46PlUGSeMovN2QL4Gd1a2yw4N3qydPP1DotLKTURwjDETnuMLiHb137k3jcnDPRU0r7y
         4mLA==
X-Forwarded-Encrypted: i=1; AJvYcCVTq/c9kDBsKzIfNlulemFD3UYKLqupcfbDJ+gUci9HZsLu2+MKp+r0plXZZSy03X8WMFQp5i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAwv7IrRTLGWJctlXGMWgBLZnp1CNHH8cwI8ixz4Jmujifgg7K
	sYvjOnal8wjQA7UqSZ+mbJLDsGDR4EEZ4onqs/hFqge9fyJPOc0we/1OR/m7ZKeOykmmUBKwc91
	gM1rVr/rCfPpOwtPilxTCIUX9vrQhDvPRTbdILQ==
X-Gm-Gg: ASbGnct8E+ZphhnQ1xgTxshGX+EGjmaPExyuz1TJOybAk1BAcL/cenY/TdwUXQl31KS
	t5o1y2zHoZxVyyqD0yUka8ohduJR4JVjn+fT17C+eWKB1xq+5EKuxzxHHYdSGKiycX69WZDwEew
	awU6EE313vU22+RhvNUOVBt+7PwX3g2A==
X-Google-Smtp-Source: AGHT+IE20YsJ9l/I/Vf8+tKL5GPZ0CVAw4b57aNyNHBd9D0mmp7ibwy2keBz/4GBYIQsaECG87U3ZvGIxrQ/H6g/3cA=
X-Received: by 2002:a05:690c:3581:b0:6f6:7b02:2568 with SMTP id
 00721157ae682-6f7a8423943mr197974977b3.32.1738664936641; Tue, 04 Feb 2025
 02:28:56 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Feb 2025 02:28:55 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Feb 2025 02:28:55 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Tue, 4 Feb 2025 02:28:55 -0800
X-Gm-Features: AWEUYZlpyLHS3qo1FoXH1BvFz0_awCBmCa0lK_RPZeVVemzWUy05-RA8u8yPcD8
Message-ID: <CACo-S-1tnrMXPP4k=yKJe=nAFCEkd7-7jrUYV_s3nF3NRe92OA@mail.gmail.com>
Subject: stable-rc/linux-6.6.y: new boot regression: NULL pointer dereference
 at virtual address 000000000000...
To: kernelci-results@groups.io
Cc: gus@collabora.com, linux-mediatek@lists.infradead.org, 
	angelogioacchino.delregno@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New boot regression found on stable-rc/linux-6.6.y:

 NULL pointer dereference at virtual address 0000000000000030
[logspec:generic_linux_boot,linux.kernel.null_pointer_dereference]

- Dashboard: https://staging.dashboard.kernelci.org:9000/issue/maestro:295973ea60dd4385ec6b04faa6ddce9707f879a4
- Grafana: https://grafana.kernelci.org/d/issue/issue?var-id=maestro:295973ea60dd4385ec6b04faa6ddce9707f879a4


Log excerpt:
[    4.896353] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000030
[    4.896354] Mem abort info:
[    4.896355]   ESR = 0x0000000096000004
[    4.896356]   EC = 0x25: DABT (current EL), IL = 32 bits
[    4.896357]   SET = 0, FnV = 0
[    4.896358]   EA = 0, S1PTW = 0
[    4.896358]   FSC = 0x04: level 0 translation fault
[    4.896360] Data abort info:
[    4.896366]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    4.896367]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    4.896368]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    4.896369] user pgtable: 4k pages, 48-bit VAs, pgdp=00000001089d9000
[    4.896370] [0000000000000030] pgd=0000000000000000, p4d=0000000000000000
[    4.896374] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    4.896376] Modules linked in: mtk_mdp3(+) v4l2_mem2mem joydev ecc
pcie_mediatek_gen3(+) videobuf2_dma_contig elan_i2c mtk_svs
lvts_thermal r8152(+) mii cros_ec_rpmsg snd_sof_mt8195 mtk_adsp_common
snd_sof_xtensa_dsp mtk_scp snd_sof_of cros_ec_sensorhub
cros_kbd_led_backlight mtk_rpmsg snd_sof rpmsg_core mt6359_auxadc
snd_soc_mt8195_afe mt6577_auxadc snd_sof_utils mtk_scp_ipi mtk_wdt
mt8195_mt6359 uvcvideo videobuf2_vmalloc uvc videobuf2_v4l2
videobuf2_memops videobuf2_common
[    4.896396] CPU: 7 UID: 0 PID: 207 Comm: (udev-worker) Not tainted
6.13.2-rc1 #1 8f7a24f5cbfa3d4f7c9dce5f7e52657669893a6c
[    4.896399] Hardware name: Acer Tomato (rev2) board (DT)
[    4.896400] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.896402] pc : klist_put+0x28/0xf0
[    4.896410] lr : klist_iter_exit+0x24/0x38
[    4.896412] sp : ffff800080cab810
[    4.896412] x29: ffff800080cab810 x28: ffffc4e77c077518 x27: 0000000000000001
[    4.896415] x26: ffff800080cabb10 x25: ffffc4e79fb98a50 x24: ffff1beb48832bb8
[    4.896417] x23: ffffc4e79dedd540 x22: 0000000000000000 x21: ffffc4e79d6f8f00
[    4.896418] x20: 0000000000000000 x19: ffff1beb41095178 x18: ffffffffffffffff
[    4.896420] x17: 656469762f766564 x16: ffffc4e79d6fb3f0 x15: 2d35393138746d2c
[    4.896422] x14: ffffc4e79fe0e750 x13: 616964656d43746f x12: 0000000000000000
[    4.896424] x11: 00353639333d4d55 x10: 0000a8fc3b570378 x9 : ffffc4e79dd32458
[    4.896426] x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : 5c175b1c0b544003
[    4.896427] x5 : 0340540b1c5b175c x4 : 0000000000000000 x3 : 0000000014f08001
[    4.896429] x2 : 00000000dead4ead x1 : 0000000000000000 x0 : 0000000000000000
[    4.896431] Call trace:
[    4.896432]  klist_put+0x28/0xf0 (P)
[    4.896435]  klist_iter_exit+0x24/0x38
[    4.896436]  bus_for_each_dev+0x90/0xe8
[    4.896440]  driver_attach+0x2c/0x40
[    4.896442]  bus_add_driver+0xec/0x218
[    4.896443]  driver_register+0x68/0x138
[    4.896445]  __platform_driver_register+0x2c/0x40
[    4.896447]  mdp_driver_init+0x28/0xff8 [mtk_mdp3
368282916f4a555c99cbc06147f8cea6ac3d5634]
[    4.896452]  do_one_initcall+0x60/0x320
[    4.896455]  do_init_module+0x60/0x238
[    4.896458]  load_module+0x1cf8/0x1de8
[    4.896460]  init_module_from_file+0x8c/0xd8
[    4.896461]  __arm64_sys_finit_module+0x150/0x338
[    4.896463]  invoke_syscall+0x70/0x100
[    4.896466]  el0_svc_common.constprop.0+0x48/0xf0
[    4.896469]  do_el0_svc+0x24/0x38
[    4.896471]  el0_svc+0x34/0xf0
[    4.896473]  el0t_64_sync_handler+0x10c/0x138
[    4.896474]  el0t_64_sync+0x1b0/0x1b8
[    4.896477] Code: 12001c36 f9400014 927ffa94 aa1403e0 (f9401a95)



# Hardware platforms affected:

## mt8195-cherry-tomato-r2
- Compatibles: google,tomato-rev2 | google,tomato | mediatek,mt8195
- Dashboard: https://staging.dashboard.kernelci.org:9000/test/maestro:67a12193661a7bc87489fa91


#kernelci issue maestro:295973ea60dd4385ec6b04faa6ddce9707f879a4

Reported-by: kernelci.org bot <bot@kernelci.org>


--
This is an experimental report format. Please send feedback in!
Talk to us at kerneci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

