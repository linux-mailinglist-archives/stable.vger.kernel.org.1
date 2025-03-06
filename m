Return-Path: <stable+bounces-121213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86E9A5486E
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 11:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32F116B258
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A5A202F92;
	Thu,  6 Mar 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="sTUx4Gnv"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9753BE
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258405; cv=none; b=qwQRNl4FyMtEzVZ+K8yhX6f9FkKUUDBeITuOVS2y7/ijWyLV5F+vuoLRTxu8RpSP2Ghuq3l117BHStrCh5d2Ue6LldOPqfm0/u6sBm+QVTCh7ZN0raTHUsYsjQ+TEYyVd4kuPfpQ3ZuSYiufKEnl8InQWOOIdbPeiMPNIlwnX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258405; c=relaxed/simple;
	bh=zE8uPjO42R0wN6ZyyQ5DZstWneCaY2rPAjIz9/7G6n0=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=mP5UiFpcjDpRnGnO0vrEvDyL8EgQ0xXjiJqIMfO3uxNNfUn+nonUIGCFYKOS10onJu/WKP57WE/HgJhWxUme5qnrt4smZ0kZQrcZmyI9RW0OYUZ1ktpk6lUY5l/9dNGPbdXaEq9rmjKCK+bPCB1822S2AgujK/zPBdJQSE2bRHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=sTUx4Gnv; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e5dc299dee9so424223276.3
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 02:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1741258401; x=1741863201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xxd7J4esvrrh3In9iHdpshM1NR8t8AghXeERErFVtI0=;
        b=sTUx4GnvIH5YscPec4hQzhFzJBwDgoWiokfscWDiTF/EPlXnkaUF18AW8eGn0tBknn
         l4aSIL07okdf8WUMx6lCRQ3uQ+cmW6T8jO9bZJm00OKUtjwximylnYoJICeC+wNdNz2L
         OG/Oj5UAi5LrD73oMFF3P4NidihLfzB6as+14gfTV5q9g5obp+aqunneYvaqg8qZFaDO
         uZumzzbAYCrSwsPdpCbDE511xVE7jBRUTgYO+gdp70uT0czlWQ0Z160AqpXI+maHlAdw
         syVupVFZxrRNllVNq2qsH5d/hCEr5TsGP5hi93PdGkBWeqvIomuf+wE6mkYHc/GWFrFN
         YNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258401; x=1741863201;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xxd7J4esvrrh3In9iHdpshM1NR8t8AghXeERErFVtI0=;
        b=HwcOB0C9kDT5GoxH6T8Dhkl8BqpsDA0AUC7SjmVU+TKUsTvhcxFW/7jf7o+gE25YXQ
         b1vkBay25Bg71WLU2xWjhuH7OCGgA1ZMuQOzibQ9+XABaWotADxWOsjjf06wk8UxeQdf
         PtQ9aJtV3KSf33mXaO7skhMpjU47inkAb46Wjr1uOSOMgZzSSGhTWgZtkqGqHzuPScEE
         aQnHWR/EL0gpMET1lo/DKFTvS1lt9XCQe19uzyz08z/MBZlrLGLDK1cuxez3QvRD1/Yc
         ysuGR/7gVwO6E/OZvNOOU7u6Yul4mXmBv7B2aZZTdavXu9dHxD0UvHrGQ+d0FF3ult41
         dztg==
X-Forwarded-Encrypted: i=1; AJvYcCWGbTWObZ+nWT2PGokFLmz9vHhcBXdcqjRrDmoP0O9+m2aDCTJJVGVczoovjj9gye7h9Cg/tro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWWn2P0TjDScWyFGHl75B18Zigr0l5CTG0KEyX9go8uNiUqm0
	7frWF7nS/O1DijH6xKXBA5DN2oLFivScbDK0n2a83IS3XMlMd2RQc69Ljfm6xIeGtIAxGvz0MI5
	xhZOEqcMcV0XbuSakGWHUfoDcyxh+cphH+derfQ==
X-Gm-Gg: ASbGncs/tFX/w3vt5xfL0UR+HRByNZAasNajLvQcYSYAo13EO0uTEU/bggfdlyig4LP
	dtEbe/gnWZBMhvJ4/Sq3mMBuqmR4rnQfaYQqEhbffv1oqT4YSOvRgqJHBzHCqu4F2N2U59EaEFe
	V77lWO64HQ/3GcZL8aDMWxc5dCa7GGKnXWKSWJvpS0Yl8KdR9tXl4OQMxAWhA=
X-Google-Smtp-Source: AGHT+IFm4I+xC4xk2+kOKFh3sRjxm2UPCmur3zeU22Dkh9W70ZBWKabdLeDwO4KKMRkqHFOdE09Q/hZTdE8CW220W6I=
X-Received: by 2002:a05:6902:2a4a:b0:e60:9f50:ec76 with SMTP id
 3f1490d57ef6-e611e319621mr8973703276.38.1741258400938; Thu, 06 Mar 2025
 02:53:20 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 10:53:19 +0000
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 10:53:19 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Thu, 6 Mar 2025 10:53:19 +0000
X-Gm-Features: AQ5f1JpJiqtnfbUXOhp1ewndoAha8DUOU4nJ53ktDG2g8HSJhRKAWx0ytkoppb4
Message-ID: <CACo-S-1H09o2zBiUs+fJRXXoZOTBS5S+QE0rz6-nLvsttSbWAQ@mail.gmail.com>
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

- dashboard: https://d.kernelci.org/issue/maestro:5a856af05fecdebd3b9507ff4ed4d0b5b6a54b63
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  43639cc57b2273fce42874dd7f6e0b872f4984c5


Log excerpt:
=====================================================
[    2.221462] Unable to handle kernel NULL pointer dereference at
virtual address 00000000000000d0
[    2.223502] Key type fscrypt-provisioning registered
[    2.223634] Key type encrypted registered
[    2.232290] Mem abort info:
[    2.244067]   ESR = 0x0000000096000004
[    2.247839]   EC = 0x25: DABT (current EL), IL = 32 bits
[    2.253175]   SET = 0, FnV = 0
[    2.253596] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/ovl@14005000
[    2.253665] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/ovl@14006000
[    2.253698] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/rdma@14007000
[    2.253730] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/color@14009000
[    2.253774] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/ccorr@1400b000
[    2.253806] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/aal@1400c000
[    2.253839] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/gamma@1400d000
[    2.253958] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/dsi@14013000
[    2.254004] mediatek-drm mediatek-drm.15.auto: Adding component
match for /soc/rdma@1401f000
[    2.256239]   EA = 0, S1PTW = 0
[    2.263379] reg-fixed-voltage regulator-pp3300-disp-x: using DT
'/regulator-pp3300-disp-x' for '(default)' GPIO lookup
[    2.263399] of_get_named_gpiod_flags: parsed 'gpios' property of
node '/regulator-pp3300-disp-x[0]' - status (0)
[    2.263418] gpio gpiochip0: Persistence not supported for GPIO 153
[    2.263517] reg-fixed-voltage regulator-pp3300-s3: using DT
'/regulator-pp3300-s3' for '(default)' GPIO lookup
[    2.263529] of_get_named_gpiod_flags: can't parse 'gpios' property
of node '/regulator-pp3300-s3[0]'
[    2.263539] of_get_named_gpiod_flags: can't parse 'gpio' property
of node '/regulator-pp3300-s3[0]'
[    2.263549] reg-fixed-voltage regulator-pp3300-s3: using lookup
tables for GPIO lookup
[    2.263553] reg-fixed-voltage regulator-pp3300-s3: No GPIO consumer
(default) found
[    2.263728] reg-fixed-voltage regulator-usb-p1-vbus: using DT
'/regulator-usb-p1-vbus' for '(default)' GPIO lookup
[    2.263742] of_get_named_gpiod_flags: can't parse 'gpios' property
of node '/regulator-usb-p1-vbus[0]'
[    2.263763] of_get_named_gpiod_flags: parsed 'gpio' property of
node '/regulator-usb-p1-vbus[0]' - status (0)
[    2.263780] gpio gpiochip0: Persistence not supported for GPIO 148
[    2.264577] of_get_named_gpiod_flags: can't parse 'gpio' property
of node '/regulator-pp3300-ldo-z5[0]'
[    2.272938]   FSC = 0x04: level 0 translation fault
[    2.273171] cpufreq: cpufreq_online: CPU0: Running at unlisted
initial frequency: 1999998 KHz, changing to: 2000000 KHz
[    2.273574] cpu cpu0: EM: created perf domain
[    2.273669] pp3300_vcn33_x: Bringing 3500000uV into 3300000-3300000uV
[    2.274033] cpufreq: cpufreq_online: CPU6: Running at unlisted
initial frequency: 1084999 KHz, changing to: 1085000 KHz
[    2.274430] cpu cpu6: EM: created perf domain
[    2.274852] pp2760_vsim2_x: Bringing 1860000uV into 2700000-2700000uV
[    2.275758] i2c_hid_of 2-002c: using DT
'/soc/i2c@11009000/trackpad@2c' for 'reset' GPIO lookup
[    2.275812] of_get_named_gpiod_flags: can't parse 'reset-gpios'
property of node '/soc/i2c@11009000/trackpad@2c[0]'
[    2.275879] of_get_named_gpiod_flags: can't parse 'reset-gpio'
property of node '/soc/i2c@11009000/trackpad@2c[0]'
[    2.275910] i2c_hid_of 2-002c: using lookup tables for GPIO lookup
[    2.275914] i2c_hid_of 2-002c: No GPIO consumer reset found
[    2.275970] i2c_hid_of_goodix 1-005d: using DT
'/soc/i2c@11008000/touchscreen@5d' for 'reset' GPIO lookup
[    2.276063] i2c_hid_of 2-002c: supply vddl not found, using dummy regulator
[    2.276059] of_get_named_gpiod_flags: parsed 'reset-gpios' property
of node '/soc/i2c@11008000/touchscreen@5d[0]' - status (0)
[    2.276099] gpio gpiochip0: Persistence not supported for GPIO 60
[    2.276212] i2c_hid_of_goodix 1-005d: supply mainboard-vddio not
found, using dummy regulator
[    2.279909] mt6358-sound mt6358-sound:
mt6358_platform_driver_probe(), dev name mt6358-sound
[    2.280156] rt5682s 5-001a: Using default DAI clk names:
rt5682-dai-wclk, rt5682-dai-bclk
[    2.281342] reg-fixed-voltage regulator-pp3300-ldo-z5: using lookup
tables for GPIO lookup
[    2.281345] reg-fixed-voltage regulator-pp3300-ldo-z5: No GPIO
consumer (default) found
[    2.281559] reg-fixed-voltage regulator-pp1800-dpbrdg-dx: using DT
'/regulator-pp1800-dpbrdg-dx' for '(default)' GPIO lookup
[    2.281715] reg-fixed-voltage regulator-pp1800-edpbrdg-dx: using DT
'/regulator-pp1800-edpbrdg-dx' for '(default)' GPIO lookup
[    2.281722] of_get_named_gpiod_flags: can't parse 'gpios' property
of node '/regulator-pp1800-edpbrdg-dx[0]'
[    2.281734] of_get_named_gpiod_flags: parsed 'gpio' property of
node '/regulator-pp1800-edpbrdg-dx[0]' - status (0)
[    2.281743] gpio gpiochip0: Persistence not supported for GPIO 30
[    2.281986] rt5682s 5-001a: using DT '/soc/i2c@11016000/codec@1a'
for 'realtek,ldo1-en' GPIO lookup
[    2.282002] of_get_named_gpiod_flags: can't parse
'realtek,ldo1-en-gpios' property of node
'/soc/i2c@11016000/codec@1a[0]'
[    2.282014] of_get_named_gpiod_flags: can't parse
'realtek,ldo1-en-gpio' property of node
'/soc/i2c@11016000/codec@1a[0]'
[    2.282022] rt5682s 5-001a: using lookup tables for GPIO lookup
[    2.282026] rt5682s 5-001a: No GPIO consumer realtek,ldo1-en found
[    2.286514] panfrost 13040000.gpu: clock rate = 249999863
[    2.288872] panfrost 13040000.gpu: [drm:panfrost_devfreq_init]
Failed to register cooling device
[    2.289521] panfrost 13040000.gpu: mali-g52 id 0x7402 major 0x1
minor 0x0 status 0x0
[    2.289527] panfrost 13040000.gpu: features: 00000000,00000cf7,
issues: 00000000,00000400
[    2.289532] panfrost 13040000.gpu: Features: L2:0x07120206
Shader:0x00000002 Tiler:0x00000209 Mem:0x1 MMU:0x00002823 AS:0xff
JS:0x7
[    2.289538] panfrost 13040000.gpu: shader_present=0x3 l2_present=0x1
[    2.290073] Data abort info:
[    2.291102] [drm] Initialized panfrost 1.2.0 for 13040000.gpu on minor 0
[    2.291640] mtu3 11201000.usb: supply vusb33 not found, using dummy regulator
[    2.291905] mtu3 11201000.usb: uwk - reg:0x420, version:2
[    2.291982] mtu3 11201000.usb: dr_mode: 3, drd: auto
[    2.291987] mtu3 11201000.usb: u2p_dis_msk: 0, u3p_dis_msk: 0
[    2.292141] mtu3 11201000.usb: usb3-drd: 0
[    2.292911] xhci-mtk 11200000.usb: supply vusb33 not found, using
dummy regulator
[    2.293231] xhci-mtk 11200000.usb: xHCI Host Controller
[    2.293400] xhci-mtk 11200000.usb: new USB bus registered, assigned
bus number 1
[    2.293469] xhci-mtk 11200000.usb: USB3 root hub has no ports
[    2.293474] xhci-mtk 11200000.usb: hcc params 0x01400f99 hci
version 0x110 quirks 0x0000000000200010
[    2.293501] xhci-mtk 11200000.usb: irq 269, io mem 0x11200000
[    2.293704] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.12
[    2.293711] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.293715] usb usb1: Product: xHCI Host Controller
[    2.293718] usb usb1: Manufacturer: Linux 6.12.18-rc1 xhci-hcd
[    2.293722] usb usb1: SerialNumber: 11200000.usb
[    2.294096] hub 1-0:1.0: USB hub found
[    2.294119] hub 1-0:1.0: 1 port detected
[    2.294373] mtu3 11201000.usb: xHCI platform device register success...
[    2.294941] mtu3 11281000.usb: supply vusb33 not found, using dummy regulator
[    2.295211] mtu3 11281000.usb: uwk - reg:0x424, version:2
[    2.295298] mtu3 11281000.usb: dr_mode: 3, drd: auto
[    2.295303] mtu3 11281000.usb: u2p_dis_msk: 0, u3p_dis_msk: 0
[    2.295449] mtu3 11281000.usb: usb3-drd: 1
[    2.297623] xhci-mtk 11280000.usb: supply vusb33 not found, using
dummy regulator
[    2.297959] xhci-mtk 11280000.usb: xHCI Host Controller
[    2.298124] xhci-mtk 11280000.usb: new USB bus registered, assigned
bus number 2
[    2.298410] of_get_named_gpiod_flags: parsed 'gpios' property of
node '/regulator-pp1800-dpbrdg-dx[0]' - status (0)
[    2.299642] xhci-mtk 11280000.usb: hcc params 0x01400f99 hci
version 0x110 quirks 0x0000000000200010
[    2.299676] xhci-mtk 11280000.usb: irq 270, io mem 0x11280000
[    2.299776] xhci-mtk 11280000.usb: xHCI Host Controller
[    2.299928] xhci-mtk 11280000.usb: new USB bus registered, assigned
bus number 3
[    2.299943] xhci-mtk 11280000.usb: Host supports USB 3.2 Enhanced SuperSpeed
[    2.300053] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.12
[    2.300059] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.300063] usb usb2: Product: xHCI Host Controller
[    2.300066] usb usb2: Manufacturer: Linux 6.12.18-rc1 xhci-hcd
[    2.300070] usb usb2: SerialNumber: 11280000.usb
[    2.300411] hub 2-0:1.0: USB hub found
[    2.300433] hub 2-0:1.0: 1 port detected
[    2.300684] usb usb3: We don't know the algorithms for LPM for this
host, disabling LPM.
[    2.300753] usb usb3: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.12
[    2.300759] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.300763] usb usb3: Product: xHCI Host Controller
[    2.300766] usb usb3: Manufacturer: Linux 6.12.18-rc1 xhci-hcd
[    2.300770] usb usb3: SerialNumber: 11280000.usb
[    2.301070] hub 3-0:1.0: USB hub found
[    2.301090] hub 3-0:1.0: 1 port detected
[    2.301348] mtu3 11281000.usb: xHCI platform device register success...
[    2.301983] anx7625 0-0058: using DT '/soc/i2c@11007000/anx7625@58'
for 'enable' GPIO lookup
[    2.301999] of_get_named_gpiod_flags: parsed 'enable-gpios'
property of node '/soc/i2c@11007000/anx7625@58[0]' - status (0)
[    2.302020] gpio gpiochip0: Persistence not supported for GPIO 96
[    2.302033] anx7625 0-0058: using DT '/soc/i2c@11007000/anx7625@58'
for 'reset' GPIO lookup
[    2.302045] of_get_named_gpiod_flags: parsed 'reset-gpios' property
of node '/soc/i2c@11007000/anx7625@58[0]' - status (0)
[    2.302058] gpio gpiochip0: Persistence not supported for GPIO 98
[    2.306779]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    2.315334] gpio gpiochip0: Persistence not supported for GPIO 39
[    2.323615]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    2.323617]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    2.323619] [00000000000000d0] user address but active_mm is swapper
[    2.323622] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    2.359334] panel-simple-dp-aux aux-0-0058: using DT
'/soc/i2c@11007000/anx7625@58/aux-bus/panel' for 'hpd' GPIO lookup
[    2.362170] Modules linked in:
[    2.362174] CPU: 6 UID: 0 PID: 81 Comm: kworker/u32:4 Not tainted
6.12.18-rc1 #1 3a46926a83206508ac114c105c0e62582044df70
[    2.362179] Hardware name: Google Steelix board (DT)
[    2.362181] Workqueue: async async_run_entry_fn
[    2.372178] of_get_named_gpiod_flags: can't parse 'hpd-gpios'
property of node '/soc/i2c@11007000/anx7625@58/aux-bus/panel[0]'
[    2.381277]
[    2.381278] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.381281] pc : power_allocator_bind+0xd0/0x2e0
[    2.390318] of_get_named_gpiod_flags: can't parse 'hpd-gpio'
property of node '/soc/i2c@11007000/anx7625@58/aux-bus/panel[0]'
[    2.398210] lr : power_allocator_bind+0x34/0x2e0
[    2.398212] sp : ffff8000808e3010
[    2.398213] x29: ffff8000808e3010 x28: ffff77e38090f000 x27: ffffc2d32b3b02d0
[    2.398217] x26: ffffc2d32c6b1c18 x25: 0000000000000000 x24: ffff77e38090e800
[    2.398220] x23: 0000000000000000
[    2.405877] panel-simple-dp-aux aux-0-0058: using lookup tables for
GPIO lookup
[    2.416187]  x22: ffff77e38090f000 x21: ffffc2d32b799440
[    2.416189] x20: ffff77e380e16fc0 x19: 0000000000000000 x18: ffffffffffffffff
[    2.416192] x17: 000000040044ffff x16: 005000f2b5503510 x15: ffff8000808e2e30
[    2.416195] x14: ffff77e3801dea1c x13: ffff77e3801de26f x12: 0000000000000001
[    2.416198] x11: 0000000084683902 x10: 0000000000000000 x9 : ffffc2d3298f13c8
[    2.416201] x8 : ffff77e380e17000
[    2.425498] panel-simple-dp-aux aux-0-0058: No GPIO consumer hpd found
[    2.435385]  x7 : 0000000000000000 x6 : 0000000000000000
[    2.435387] x5 : 0000000000000000 x4 : 0000000000000040 x3 : 0000000000000000
[    2.435390] x2 : ffffffffffffffc0 x1 : 0000000000000000 x0 : ffff77e38090f578
[    2.435393] Call trace:
[    2.435394]  power_allocator_bind+0xd0/0x2e0
[    2.441647] panel-simple-dp-aux aux-0-0058: using DT
'/soc/i2c@11007000/anx7625@58/aux-bus/panel' for 'enable' GPIO lookup
[    2.450933]  thermal_set_governor+0x48/0xc0
[    2.450937]  thermal_zone_device_register_with_trips+0x3ec/0x5a0
[    2.450941]  thermal_tripless_zone_device_register+0x30/0x40
[    2.450945]  __power_supply_register.part.0+0x358/0x4b0
[    2.455820] of_get_named_gpiod_flags: can't parse 'enable-gpios'
property of node '/soc/i2c@11007000/anx7625@58/aux-bus/panel[0]'
[    2.466571]  __power_supply_register+0x60/0xb0
[    2.466574]  devm_power_supply_register+0x60/0xb0
[    2.466578]  sbs_probe+0x288/0x398
[    2.466580]  i2c_device_probe+0x14c/0x290
[    2.470942] of_get_named_gpiod_flags: can't parse 'enable-gpio'
property of node '/soc/i2c@11007000/anx7625@58/aux-bus/panel[0]'
[    2.477345]  really_probe+0xc0/0x2a0
[    2.477349]  __driver_probe_device+0x7c/0x138
[    2.477352]  driver_probe_device+0x40/0x118
[    2.477355]  __device_attach_driver+0xb4/0xf8
[    2.477358]  bus_for_each_drv+0x88/0xe8
[    2.477360]  __device_attach+0xa0/0x190
[    2.488134] panel-simple-dp-aux aux-0-0058: using lookup tables for
GPIO lookup
[    2.492463]  device_initial_probe+0x18/0x28
[    2.492466]  bus_probe_device+0xa8/0xb8
[    2.492469]  device_add+0x568/0x738
[    2.492471]  device_register+0x24/0x38
[    2.492473]  i2c_new_client_device+0x198/0x370
[    2.498909] panel-simple-dp-aux aux-0-0058: No GPIO consumer enable found
[    2.507579]  of_i2c_register_devices+0x114/0x198
[    2.507581]  i2c_register_adapter+0x200/0x670
[    2.507584]  i2c_add_adapter+0x7c/0xd8
[    2.604977] panel-simple-dp-aux aux-0-0058: Detected AUO B116XAN06.3 (0x635c)
[    2.607331]  ec_i2c_probe+0xdc/0x158
[    2.607334]  platform_probe+0x6c/0xc8
[    2.607337]  really_probe+0xc0/0x2a0
[    2.607340]  __driver_probe_device+0x7c/0x138
[    2.615592] it6505 3-005c: can not get extcon device!
[    2.626524]  driver_probe_device+0x40/0x118
[    2.626527]  __device_attach_driver+0xb4/0xf8
[    2.626530]  bus_for_each_drv+0x88/0xe8
[    2.639217] mtk-msdc 11230000.mmc: using DT '/soc/mmc@11230000' for
'wp' GPIO lookup
[    2.639300] mtk-msdc 11240000.mmc: using DT '/soc/mmc@11240000' for
'wp' GPIO lookup
[    2.639314] of_get_named_gpiod_flags: can't parse 'wp-gpios'
property of node '/soc/mmc@11240000[0]'
[    2.639326] of_get_named_gpiod_flags: can't parse 'wp-gpio'
property of node '/soc/mmc@11240000[0]'
[    2.639334] mtk-msdc 11240000.mmc: using lookup tables for GPIO lookup
[    2.639338] mtk-msdc 11240000.mmc: No GPIO consumer wp found
[    2.639364] mtk-msdc 11240000.mmc: allocated mmc-pwrseq
[    2.643184] mtk-iommu 14016000.iommu: bound 14003000.smi (ops
0xffffc2d32b3d3ca8)
[    2.643191] mtk-iommu 14016000.iommu: bound 14004000.smi (ops
0xffffc2d32b3d3ca8)
[    2.643193] mtk-iommu 14016000.iommu: bound 1b002000.smi (ops
0xffffc2d32b3d3ca8)
[    2.643196] mtk-iommu 14016000.iommu: bound 1602e000.smi (ops
0xffffc2d32b3d3ca8)
[    2.643198] mtk-iommu 14016000.iommu: bound 17010000.smi (ops
0xffffc2d32b3d3ca8)
[    2.643201] mtk-iommu 14016000.iommu: bound 14023000.smi (ops
0xffffc2d32b3d3ca8)
[    2.643204] mtk-iommu 14016000.iommu: bound 1502e000.smi (ops
0xffffc2d32b3d3ca8)
[    2.643206] mtk-iommu 14016000.iommu: bound 1582e000.smi (ops
0xffffc2d32b3d3ca8)
[    2.643208] mtk-iommu 14016000.iommu: bound 1a001000.smi (ops
0xffffc2d32b3d3ca8)
[    2.643211] mtk-iommu 14016000.iommu: bound 1a002000.smi (ops
0xffffc2d32b3d3ca8)
[    2.643214] mtk-iommu 14016000.iommu: bound 1a00f000.smi (ops
0xffffc2d32b3d3ca8)
[    2.643216] mtk-iommu 14016000.iommu: bound 1a010000.smi (ops
0xffffc2d32b3d3ca8)
[    2.643218] mtk-iommu 14016000.iommu: bound 1c10f000.smi (ops
0xffffc2d32b3d3ca8)
[    2.643221] mtk-iommu 14016000.iommu: bound 1c00f000.smi (ops
0xffffc2d32b3d3ca8)
[    2.643357] mediatek-disp-ovl 14005000.ovl: Adding to iommu group 0
[    2.643682] mediatek-disp-ovl 14006000.ovl: Adding to iommu group 0
[    2.643856] mediatek-disp-rdma 14007000.rdma: Adding to iommu group 0
[    2.644010] mediatek-disp-rdma 1401f000.rdma: Adding to iommu group 0
[    2.644240] mediatek-drm mediatek-drm.15.auto: bound 14005000.ovl
(ops 0xffffc2d32a886270)
[    2.644245] mediatek-drm mediatek-drm.15.auto: bound 14006000.ovl
(ops 0xffffc2d32a886270)
[    2.644248] mediatek-drm mediatek-drm.15.auto: bound 14007000.rdma
(ops 0xffffc2d32a887478)
[    2.644250] mediatek-drm mediatek-drm.15.auto: bound 14009000.color
(ops 0xffffc2d32a885a20)
[    2.644253] mediatek-drm mediatek-drm.15.auto: bound 1400b000.ccorr
(ops 0xffffc2d32a8857a8)
[    2.644256] mediatek-drm mediatek-drm.15.auto: bound 1400c000.aal
(ops 0xffffc2d32a885538)
[    2.644259] mediatek-drm mediatek-drm.15.auto: bound 1400d000.gamma
(ops 0xffffc2d32a885d68)
[    2.645595] mediatek-drm mediatek-drm.15.auto: bound 14013000.dsi
(ops 0xffffc2d32a88bc48)
[    2.645600] mediatek-drm mediatek-drm.15.auto: bound 1401f000.rdma
(ops 0xffffc2d32a887478)
[    2.645640] mediatek-drm mediatek-drm.15.auto: Not creating crtc 1
because component 10 is disabled or missing
[    2.646204] [drm] Initialized mediatek 1.0.0 for
mediatek-drm.15.auto on minor 1
[    2.647659] gpio-keys gpio-keys: using DT
'/gpio-keys/pen-insert-switch' for '(default)' GPIO lookup
[    2.647679] of_get_named_gpiod_flags: parsed 'gpios' property of
node '/gpio-keys/pen-insert-switch[0]' - status (0)
[    2.647699] gpio gpiochip0: Persistence not supported for GPIO 18
[    2.647707]  __device_attach+0xa0/0x190
[    2.647710]  device_initial_probe+0x18/0x28
[    2.647713]  bus_probe_device+0xa8/0xb8
[    2.647715]  device_add+0x568/0x738
[    2.647717]  of_device_add+0x54/0x68
[    2.647721]  of_platform_device_create_pdata+0x94/0x130
[    2.647723]  of_platform_bus_create+0x154/0x390
[    2.647726]  of_platform_populate+0x54/0x100
[    2.647728]  devm_of_platform_populate+0x5c/0xc0
[    2.647840] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    2.648296] gpio-keys wifi-wakeup: using DT
'/wifi-wakeup/wowlan-event' for '(default)' GPIO lookup
[    2.648307] of_get_named_gpiod_flags: parsed 'gpios' property of
node '/wifi-wakeup/wowlan-event[0]' - status (0)
[    2.648317] gpio gpiochip0: Persistence not supported for GPIO 7
[    2.648375] input: wifi-wakeup as /devices/platform/wifi-wakeup/input/input1
[    2.658162] of_get_named_gpiod_flags: can't parse 'wp-gpios'
property of node '/soc/mmc@11230000[0]'
[    2.664222]  cros_ec_register+0x188/0x368
[    2.664226]  cros_ec_spi_probe+0x178/0x248
[    2.664228]  spi_probe+0x88/0xe8
[    2.671184] clk: Disabling unused clocks
[    2.671423] PM: genpd: Disabling unused power domains
[    2.671491] ALSA device list:
[    2.671494]   No soundcards found.
[    2.673266] of_get_named_gpiod_flags: can't parse 'wp-gpio'
property of node '/soc/mmc@11230000[0]'
[    2.684279]  really_probe+0xc0/0x2a0
[    2.684282]  __driver_probe_device+0x7c/0x138
[    2.684285]  driver_probe_device+0x40/0x118
[    2.695228] mtk-msdc 11230000.mmc: using lookup tables for GPIO lookup
[    2.701124]  __driver_attach_async_helper+0x50/0xb8
[    2.701127]  async_run_entry_fn+0x3c/0x158
[    2.701129]  process_one_work+0x188/0x438
[    2.707300] mtk-msdc 11230000.mmc: No GPIO consumer wp found
[    2.712677]  worker_thread+0x304/0x410
[    2.712680]  kthread+0x124/0x130
[    2.849438] hid-multitouch 0018:27C6:0EAA.0001: unknown main item tag 0x0
[    2.853240]  ret_from_fork+0x10/0x20
[    2.853246] Code: b4000b47 aa0703e5 a9019e86 52800013 (f84d0ca0)

=====================================================


# Hardware platforms affected:

## mt8186-corsola-steelix-sku131072
- dashboard: https://d.kernelci.org/test/maestro:67c8c8c618018371956e15b6
- compatibles: google,steelix-sku131072 | google,steelix
- 1 fails since 2025-03-05 22:20 UTC
- test path: boot.nfs
- last pass: https://d.kernelci.org/test/maestro:67bd7856323b35c54a886f0c
    - on 2025-02-25 07:59 UTC
    - commit hash:  f5c37852dffd24f66248b4086ea594060f3299a4
    - test id:  maestro:67bd7856323b35c54a886f0c


#kernelci issue maestro:5a856af05fecdebd3b9507ff4ed4d0b5b6a54b63

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

