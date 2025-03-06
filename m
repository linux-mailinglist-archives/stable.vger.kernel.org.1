Return-Path: <stable+bounces-121214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C939A5487B
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 11:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CF0170D82
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31D4202984;
	Thu,  6 Mar 2025 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="YFJIV5U6"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867251A76BC
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258550; cv=none; b=aYxy+G/X5akfNTwT9sv9R/rClQQ5AsHwV/Elf3/bSab2elEYWtBrigLPOVVYea2SNeY9EdTcTD2+GoLgbtdmmE3diEBjYb/zZY1B5QLi+rzJUM8WCFjVZAf8C8Rw/P7BlWZhF4NlPPXRiROR8jHf7AuKxD66XF2Q3YQADZAh4Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258550; c=relaxed/simple;
	bh=J0QW6Wq/T52HqkrkvEHVJgtipVyOUCVVq7rQaFWjafo=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=byZOTFxq8GGAJWR4muuH3RAhy00IQf3vx6EpUDCt79XRb/VqSBRE8MEzC1p8Y4kaNSPTUVrf9OFRKpkw75S2n/aCZAzGh0NS8ek0wJDzxjYhsAuj/fcNCjgkuJrwXNzE5TjUDAO9Unobnhszhosp1dWX9D66+JZS6JXCk9e/QGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=YFJIV5U6; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e461015fbd4so324480276.2
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 02:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1741258547; x=1741863347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3D8Ni+a+RUIMIKHVoWnreZRa0vTg62DmDFh2oqeGYs=;
        b=YFJIV5U6OWJr+ga7TaU9PZK0EzIIrQraUnnR2F5MPJEun6+d8ZXj5qqBTIgVrJ+B8o
         pR2SruBkuIEqh99Tb5wXZLNqUguduzYMG0teGrT2FKcsvUBlqk8HhfkDRPnhhC9zmuCV
         c76tzMIjjFTHAX5tu1QLioI1LlQKqTHsFZBPhAy1j4cpM26+JeUV0BEVjo8S8UHSy/8g
         OGD4yk9pvtNdiUnK9qJdWG3fbv9cAEp9K1k9hEznwAw736u88wdJKpp0RTzo+lYNB6/2
         0ob/87cYEBmITAuzryeKK0lQB0FOPcV+LPvweRtzoiPwgkCHaVOH2L1HXkhukxffeJwy
         rmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258547; x=1741863347;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3D8Ni+a+RUIMIKHVoWnreZRa0vTg62DmDFh2oqeGYs=;
        b=BPjd/Yc6Bq2NiXT1lA6eHTZjoE2XRR3mgMaAxex2WxVw8rZWl5a12XouvnipcM+mok
         We+TdC2l2oGAIDvp7uIshanQn4n6Qx4A7OCgNjfqR6cgYDwR693wyyhGemBCtKYa7qnt
         vl8rp8/2Od6CKjvdr+C0rrCkI5dSw3+TXRvaP8KoMugL2fpLA0XXNE2x7QnMkbrEOJJ5
         UiUSxNnMQX8aA5+FPCjFHe7xT922FhR/8HFDQKxCk2oKjkJxqoNOT2yAo+yHrwrV2WHO
         ceCukjKB6KEQwOqGuwwvayCgzEhu083tjAAuNJbYUtcOzwAnUf6vycH0tAVP0MFyfzVg
         gURw==
X-Forwarded-Encrypted: i=1; AJvYcCV1bfS6Qt2fvuTeXpMax0vERhF1lmU0XSM6WtsNtzQS2DVqa7cQRxzSQY1FbSLcBdRRu5xExhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+dca/+iJtodlLvc3X/2Sw6kjNkrHvW7VNTeZbsvbUsE32wQ9v
	UtyqUIgUvOOirevOOziKXYIupl4cve/I0ikv5cWEfrZaOpPbn6pKVKfUhmKrPqHaICcTZOX4CIM
	lxOTwS+dpJ8B4sNKfFfD908Y045c3++IDDTV2mA==
X-Gm-Gg: ASbGncvGHYNFbfAWiBShxE8wllMjD2RjJ/MLNcooqefmt09fV08hMx03DE2RRKz2gK/
	ZW2fx7Quc1QNZc0J7XGbwwlvm5g/eqhAN7e4QYPVbQLIdft+MS71w7X2jAJ0ymc4JdfotiEM+K0
	+Yq+z6sswfhwsVbXfA3uy7mr3tbe81Jdbxhv2+exhHfi79Ukt6rVVeQc8OAy8=
X-Google-Smtp-Source: AGHT+IGVSizdqawS1tCjyBqfom4q0F8Mku5XdeXqlXUAz8ahiFmvMLZ8o7KFVmGrf/w1viW8fzU4/G3FUBkXUZug5ZY=
X-Received: by 2002:a05:6902:2882:b0:e57:4226:8ae0 with SMTP id
 3f1490d57ef6-e611e1b0720mr7964881276.18.1741258547323; Thu, 06 Mar 2025
 02:55:47 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 02:55:46 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 02:55:46 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Thu, 6 Mar 2025 02:55:46 -0800
X-Gm-Features: AQ5f1JqjCqm16o35BwHNzne1MypBEUFVW0LjrHmX80WQD1kaL7X_cGMCN1KRHv8
Message-ID: <CACo-S-32kmDNUd_GBoTiCu6LDDgMVoaLLU2mVcS3q5EOruiKog@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.12.y: (boot) NULL pointer dereference
 at virtual address 00000000000000d0 [logs...
To: kernelci-results@groups.io
Cc: gus@collabora.com, laura.nao@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New boot regression found on stable-rc/linux-6.12.y:

---
 NULL pointer dereference at virtual address 00000000000000d0
[logspec:generic_linux_boot,linux.kernel.null_pointer_dereference]
---

- dashboard: https://d.kernelci.org/issue/maestro:e301e9dec14c72112ac560e4ba2548ec434c9e20
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  43639cc57b2273fce42874dd7f6e0b872f4984c5


Log excerpt:
=====================================================
[    2.402363] Unable to handle kernel NULL pointer dereference at
virtual address 00000000000000d0
[    2.406659] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/ovl@14005000
[    2.406736] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/ovl@14006000
[    2.406755] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/rdma@14007000
[    2.406768] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/color@14009000
[    2.406779] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/ccorr@1400a000
[    2.406793] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/aal@1400b000
[    2.406806] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/gamma@1400c000
[    2.406866] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/dsi@14010000
[    2.406878] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/ovl@14014000
[    2.406892] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/rdma@14015000
[    2.411531] panfrost 13000000.gpu: clock rate = 357999878
[    2.412537] panfrost 13000000.gpu: [drm:panfrost_devfreq_init]
Failed to register cooling device
[    2.412827] panfrost 13000000.gpu: mali-g57 id 0x9093 major 0x0
minor 0x0 status 0x0
[    2.412830] panfrost 13000000.gpu: features: 00000000,000019f7,
issues: 00000003,80000400
[    2.412832] panfrost 13000000.gpu: Features: L2:0x07130206
Shader:0x00000000 Tiler:0x00000809 Mem:0x101 MMU:0x00002830 AS:0xff
JS:0x7
[    2.412835] panfrost 13000000.gpu: shader_present=0x50045 l2_present=0x1
[    2.412900] Mem abort info:
[    2.414378] [drm] Initialized panfrost 1.2.0 for 13000000.gpu on minor 0
[    2.414747] xhci-mtk 11200000.usb: uwk - reg:0x420, version:102
[    2.415395] xhci-mtk 11200000.usb: xHCI Host Controller
[    2.415505] xhci-mtk 11200000.usb: new USB bus registered, assigned
bus number 1
[    2.415720] xhci-mtk 11200000.usb: hcc params 0x01400f99 hci
version 0x110 quirks 0x0000000000200010
[    2.415751] xhci-mtk 11200000.usb: irq 275, io mem 0x11200000
[    2.415804] xhci-mtk 11200000.usb: xHCI Host Controller
[    2.415933] xhci-mtk 11200000.usb: new USB bus registered, assigned
bus number 2
[    2.415940] xhci-mtk 11200000.usb: Host supports USB 3.1 Enhanced SuperSpeed
[    2.416011] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.12
[    2.416014] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.416016] usb usb1: Product: xHCI Host Controller
[    2.416017] usb usb1: Manufacturer: Linux 6.12.18-rc1 xhci-hcd
[    2.416019] usb usb1: SerialNumber: 11200000.usb
[    2.416274] hub 1-0:1.0: USB hub found
[    2.416285] hub 1-0:1.0: 1 port detected
[    2.416394] usb usb2: We don't know the algorithms for LPM for this
host, disabling LPM.
[    2.416418] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.12
[    2.416420] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.416421] usb usb2: Product: xHCI Host Controller
[    2.416423] usb usb2: Manufacturer: Linux 6.12.18-rc1 xhci-hcd
[    2.416424] usb usb2: SerialNumber: 11200000.usb
[    2.416785] hub 2-0:1.0: USB hub found
[    2.416795] hub 2-0:1.0: 1 port detected
[    2.419750] rt5682 1-001a: Using default DAI clk names:
rt5682-dai-wclk, rt5682-dai-bclk
[    2.420524] reg-fixed-voltage regulator-1v8-g: using DT
'/regulator-1v8-g' for '(default)' GPIO lookup
[    2.420541] of_get_named_gpiod_flags: can't parse 'gpios' property
of node '/regulator-1v8-g[0]'
[    2.420546] of_get_named_gpiod_flags: can't parse 'gpio' property
of node '/regulator-1v8-g[0]'
[    2.420552] reg-fixed-voltage regulator-1v8-g: using lookup tables
for GPIO lookup
[    2.420555] reg-fixed-voltage regulator-1v8-g: No GPIO consumer
(default) found
[    2.420761] reg-fixed-voltage regulator-3v3-dpbrdg: using DT
'/regulator-3v3-dpbrdg' for '(default)' GPIO lookup
[    2.420774] of_get_named_gpiod_flags: can't parse 'gpios' property
of node '/regulator-3v3-dpbrdg[0]'
[    2.420791] of_get_named_gpiod_flags: parsed 'gpio' property of
node '/regulator-3v3-dpbrdg[0]' - status (0)
[    2.420834] gpio gpiochip0: Persistence not supported for GPIO 26
[    2.420882] rt5682 1-001a: using DT
'/soc/i2c@11d20000/audio-codec@1a' for 'realtek,ldo1-en' GPIO lookup
[    2.420899] of_get_named_gpiod_flags: can't parse
'realtek,ldo1-en-gpios' property of node
'/soc/i2c@11d20000/audio-codec@1a[0]'
[    2.420911] of_get_named_gpiod_flags: can't parse
'realtek,ldo1-en-gpio' property of node
'/soc/i2c@11d20000/audio-codec@1a[0]'
[    2.420920] rt5682 1-001a: using lookup tables for GPIO lookup
[    2.420923] rt5682 1-001a: No GPIO consumer realtek,ldo1-en found
[    2.421046] mtk-iommu 1401d000.m4u: bound 14003000.larb (ops
0xffffb67e921d3ca8)
[    2.421060] mtk-iommu 1401d000.m4u: bound 14004000.larb (ops
0xffffb67e921d3ca8)
[    2.421064] mtk-iommu 1401d000.m4u: bound 1f002000.larb (ops
0xffffb67e921d3ca8)
[    2.421066] mtk-iommu 1401d000.m4u: bound 1602e000.larb (ops
0xffffb67e921d3ca8)
[    2.421076] mtk-iommu 1401d000.m4u: bound 1600d000.larb (ops
0xffffb67e921d3ca8)
[    2.421078] mtk-iommu 1401d000.m4u: bound 17010000.larb (ops
0xffffb67e921d3ca8)
[    2.421081] mtk-iommu 1401d000.m4u: bound 1502e000.larb (ops
0xffffb67e921d3ca8)
[    2.421084] mtk-iommu 1401d000.m4u: bound 1582e000.larb (ops
0xffffb67e921d3ca8)
[    2.421087] mtk-iommu 1401d000.m4u: bound 1a001000.larb (ops
0xffffb67e921d3ca8)
[    2.421089] mtk-iommu 1401d000.m4u: bound 1a002000.larb (ops
0xffffb67e921d3ca8)
[    2.421091] mtk-iommu 1401d000.m4u: bound 1a00f000.larb (ops
0xffffb67e921d3ca8)
[    2.421093] mtk-iommu 1401d000.m4u: bound 1a010000.larb (ops
0xffffb67e921d3ca8)
[    2.421095] mtk-iommu 1401d000.m4u: bound 1a011000.larb (ops
0xffffb67e921d3ca8)
[    2.421097] mtk-iommu 1401d000.m4u: bound 1b10f000.larb (ops
0xffffb67e921d3ca8)
[    2.421102] mtk-iommu 1401d000.m4u: bound 1b00f000.larb (ops
0xffffb67e921d3ca8)
[    2.421248] gpio gpiochip0: Persistence not supported for GPIO 128
[    2.421266] mediatek-disp-ovl 14005000.ovl: Adding to iommu group 0
[    2.421694] mediatek-disp-ovl 14006000.ovl: Adding to iommu group 0
[    2.421841] mediatek-disp-ovl 14014000.ovl: Adding to iommu group 0
[    2.421979] mediatek-disp-rdma 14007000.rdma: Adding to iommu group 0
[    2.422135] mediatek-disp-rdma 14015000.rdma: Adding to iommu group 0
[    2.429607]   ESR = 0x0000000096000004
[    2.429624]   EC = 0x25: DABT (current EL), IL = 32 bits
[    2.429631]   SET = 0, FnV = 0
[    2.444848] anx7625 3-0058: using DT '/soc/i2c@11cb0000/anx7625@58'
for 'enable' GPIO lookup
[    2.446610]   EA = 0, S1PTW = 0
[    2.456189] of_get_named_gpiod_flags: parsed 'enable-gpios'
property of node '/soc/i2c@11cb0000/anx7625@58[0]' - status (0)
[    2.464133]   FSC = 0x04: level 0 translation fault
[    2.472625] gpio gpiochip0: Persistence not supported for GPIO 41
[    2.480586] Data abort info:
[    2.480594]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    2.480601]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    2.480607]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    2.480616] [00000000000000d0] user address but active_mm is swapper
[    2.480647] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    2.489107] anx7625 3-0058: using DT '/soc/i2c@11cb0000/anx7625@58'
for 'reset' GPIO lookup
[    2.497405] Modules linked in:
[    2.497434] CPU: 4 UID: 0 PID: 11 Comm: kworker/u32:0 Not tainted
6.12.18-rc1 #1 3a46926a83206508ac114c105c0e62582044df70
[    2.503025] of_get_named_gpiod_flags: parsed 'reset-gpios' property
of node '/soc/i2c@11cb0000/anx7625@58[0]' - status (0)
[    2.509098] clk: Disabling unused clocks
[    2.509736] PM: genpd: Disabling unused power domains
[    2.509759] ALSA device list:
[    2.509761]   No soundcards found.
[    2.511584] Hardware name: Google Spherion (rev0 - 3) (DT)
[    2.511586] Workqueue: async async_run_entry_fn
[    2.519348] gpio gpiochip0: Persistence not supported for GPIO 42
[    2.527478]
[    2.527480] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.527483] pc : power_allocator_bind+0xd0/0x2e0
[    2.599906] panel-simple-dp-aux aux-3-0058: using DT
'/soc/i2c@11cb0000/anx7625@58/aux-bus/panel' for 'hpd' GPIO lookup
[    2.601559] lr : power_allocator_bind+0x34/0x2e0
[    2.601561] sp : ffff8000800db010
[    2.601562] x29: ffff8000800db010 x28: ffff0f7000a55000 x27: ffffb67e921b02d0
[    2.601566] x26: ffffb67e934b1c18 x25: 0000000000000000 x24: ffff0f7000a56800
[    2.601570] x23: 0000000000000000 x22: ffff0f7000a55000 x21: ffffb67e92599440
[    2.601573] x20: ffff0f70009b0500 x19: 0000000000000000 x18: ffffffffffffffff
[    2.608613] of_get_named_gpiod_flags: can't parse 'hpd-gpios'
property of node '/soc/i2c@11cb0000/anx7625@58/aux-bus/panel[0]'
[    2.616853] x17: 000000040044ffff x16: 005000f2b5503510 x15: ffff8000800dae30
[    2.616857] x14: ffff0f7000a58a1c
[    2.624066] of_get_named_gpiod_flags: can't parse 'hpd-gpio'
property of node '/soc/i2c@11cb0000/anx7625@58/aux-bus/panel[0]'
[    2.628926]  x13: ffff0f7000a5826f x12: 0101010101010101
[    2.628928] x11: 7f7f7f7f7f7f7f7f
[    2.634749] panel-simple-dp-aux aux-3-0058: using lookup tables for
GPIO lookup
[    2.639348]  x10: 0000000000000000 x9 : ffffb67e906f13c8
[    2.639350] x8 : ffff0f70009b0540
[    2.643087] panel-simple-dp-aux aux-3-0058: No GPIO consumer hpd found
[    2.646992]  x7 : 0000000000000000 x6 : 0000000000000000
[    2.655201] panel-simple-dp-aux aux-3-0058: using DT
'/soc/i2c@11cb0000/anx7625@58/aux-bus/panel' for 'enable' GPIO lookup
[    2.663315] x5 : 0000000000000000 x4 : 0000000000000040 x3 : 0000000000000000
[    2.663318] x2 : ffffffffffffffc0 x1 : 0000000000000000
[    2.670529] of_get_named_gpiod_flags: can't parse 'enable-gpios'
property of node '/soc/i2c@11cb0000/anx7625@58/aux-bus/panel[0]'
[    2.675388]  x0 : ffff0f7000a55578
[    2.675391] Call trace:
[    2.681210] of_get_named_gpiod_flags: can't parse 'enable-gpio'
property of node '/soc/i2c@11cb0000/anx7625@58/aux-bus/panel[0]'
[    2.685811]  power_allocator_bind+0xd0/0x2e0
[    2.689548] panel-simple-dp-aux aux-3-0058: using lookup tables for
GPIO lookup
[    2.693455]  thermal_set_governor+0x48/0xc0
[    2.701537] panel-simple-dp-aux aux-3-0058: No GPIO consumer enable found
[    2.710823]  thermal_zone_device_register_with_trips+0x3ec/0x5a0
[    2.813506] panel-simple-dp-aux aux-3-0058: Detected IVO R140NWF5 RH (0x057d)
[    2.816653]  thermal_tripless_zone_device_register+0x30/0x40
[    2.816657]  __power_supply_register.part.0+0x358/0x4b0
[    2.816667]  __power_supply_register+0x60/0xb0
[    2.823088] mediatek-drm mediatek-drm.15.auto: bound 14005000.ovl
(ops 0xffffb67e91686270)
[    2.830124]  devm_power_supply_register+0x60/0xb0
[    2.830128]  sbs_probe+0x288/0x398
[    2.830130]  i2c_device_probe+0x14c/0x290
[    2.837595] mediatek-drm mediatek-drm.15.auto: bound 14006000.ovl
(ops 0xffffb67e91686270)
[    2.844896]  really_probe+0xc0/0x2a0
[    2.852450] mediatek-drm mediatek-drm.15.auto: bound 14007000.rdma
(ops 0xffffb67e91687478)
[    2.859659]  __driver_probe_device+0x7c/0x138
[    2.859663]  driver_probe_device+0x40/0x118
[    2.859667]  __device_attach_driver+0xb4/0xf8
[    2.859670]  bus_for_each_drv+0x88/0xe8
[    2.859673]  __device_attach+0xa0/0x190
[    2.859675]  device_initial_probe+0x18/0x28
[    2.859679]  bus_probe_device+0xa8/0xb8
[    2.859682]  device_add+0x568/0x738
[    2.867065] mediatek-drm mediatek-drm.15.auto: bound 14009000.color
(ops 0xffffb67e91685a20)
[    2.874440]  device_register+0x24/0x38
[    2.874442]  i2c_new_client_device+0x198/0x370
[    2.881825] mediatek-drm mediatek-drm.15.auto: bound 1400a000.ccorr
(ops 0xffffb67e916857a8)
[    2.889201]  of_i2c_register_devices+0x114/0x198
[    2.896585] mediatek-drm mediatek-drm.15.auto: bound 1400b000.aal
(ops 0xffffb67e91685538)
[    2.903961]  i2c_register_adapter+0x200/0x670
[    2.911345] mediatek-drm mediatek-drm.15.auto: bound 1400c000.gamma
(ops 0xffffb67e91685d68)
[    2.918721]  i2c_add_adapter+0x7c/0xd8
[    2.927700] mediatek-drm mediatek-drm.15.auto: bound 14010000.dsi
(ops 0xffffb67e9168bc48)
[    2.933482]  ec_i2c_probe+0xdc/0x158
[    2.933485]  platform_probe+0x6c/0xc8
[    2.939655] mediatek-drm mediatek-drm.15.auto: bound 14014000.ovl
(ops 0xffffb67e91686270)
[    2.945902]  really_probe+0xc0/0x2a0
[    2.945904]  __driver_probe_device+0x7c/0x138
[    2.952175] mediatek-drm mediatek-drm.15.auto: bound 14015000.rdma
(ops 0xffffb67e91687478)
[    2.958406]  driver_probe_device+0x40/0x118
[    2.964931] mediatek-drm mediatek-drm.15.auto: Not creating crtc 1
because component 10 is disabled or missing
[    2.971257]  __device_attach_driver+0xb4/0xf8
[    2.971260]  bus_for_each_drv+0x88/0xe8
[    2.976297] [drm] Initialized mediatek 1.0.0 for
mediatek-drm.15.auto on minor 1
[    2.980291]  __device_attach+0xa0/0x190
[    2.980294]  device_initial_probe+0x18/0x28
[    2.980297]  bus_probe_device+0xa8/0xb8
[    2.980299]  device_add+0x568/0x738
[    2.980301]  of_device_add+0x54/0x68
[    2.980309]  of_platform_device_create_pdata+0x94/0x130
[    3.566249]  of_platform_bus_create+0x154/0x390
[    3.566251]  of_platform_populate+0x54/0x100
[    3.566253]  devm_of_platform_populate+0x5c/0xc0
[    3.566255]  cros_ec_register+0x188/0x368
[    3.566261]  cros_ec_spi_probe+0x178/0x248
[    3.566264]  spi_probe+0x88/0xe8
[    3.566273]  really_probe+0xc0/0x2a0
[    3.566276]  __driver_probe_device+0x7c/0x138
[    3.566278]  driver_probe_device+0x40/0x118
[    3.566281]  __driver_attach_async_helper+0x50/0xb8
[    3.566284]  async_run_entry_fn+0x3c/0x158
[    3.566286]  process_one_work+0x188/0x438
[    3.566293]  worker_thread+0x304/0x410
[    3.566296]  kthread+0x124/0x130
[    3.566299]  ret_from_fork+0x10/0x20
[    3.566307] Code: b4000b47 aa0703e5 a9019e86 52800013 (f84d0ca0)

=====================================================


# Hardware platforms affected:

## mt8186-corsola-steelix-sku131072
- dashboard: https://d.kernelci.org/test/maestro:67c8c8c418018371956e1594
- compatibles: google,steelix-sku131072 | google,steelix
- 2 fails since 2025-03-05 22:20 UTC
- test path: boot
- last pass: https://d.kernelci.org/test/maestro:67bd7853323b35c54a886efc
    - on 2025-02-25 07:59 UTC
    - commit hash:  f5c37852dffd24f66248b4086ea594060f3299a4
    - test id:  maestro:67bd7853323b35c54a886efc

## mt8192-asurada-spherion-r0
- dashboard: https://d.kernelci.org/test/maestro:67c8c8c718018371956e15b9
- compatibles: google,spherion-rev3 | google,spherion-rev2
- 2 fails since 2025-03-05 22:21 UTC
- test path: boot.nfs
- last pass: https://d.kernelci.org/test/maestro:67bd7857323b35c54a886f13
    - on 2025-02-25 07:59 UTC
    - commit hash:  f5c37852dffd24f66248b4086ea594060f3299a4
    - test id:  maestro:67bd7857323b35c54a886f13

## mt8195-cherry-tomato-r2
- dashboard: https://d.kernelci.org/test/maestro:67c8c8c818018371956e15bc
- compatibles: google,tomato-rev2 | google,tomato | mediatek,mt8195
- 2 fails since 2025-03-05 22:20 UTC
- test path: boot.nfs
- last pass: https://d.kernelci.org/test/maestro:67bd7857323b35c54a886f16
    - on 2025-02-25 07:59 UTC
    - commit hash:  f5c37852dffd24f66248b4086ea594060f3299a4
    - test id:  maestro:67bd7857323b35c54a886f16


#kernelci issue maestro:e301e9dec14c72112ac560e4ba2548ec434c9e20

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

