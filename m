Return-Path: <stable+bounces-123142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E23A5B791
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 04:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB69218948F7
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 03:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8BA1E9B1A;
	Tue, 11 Mar 2025 03:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFHAvO37"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFA61DFE22;
	Tue, 11 Mar 2025 03:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741665307; cv=none; b=V9bA/AdOkMTY3XsCFTsGMhQsxjm2QP4by2ruUD+wFtxaDhse+a7O7wiRl/TTK6n5bL59pM+fq5fvnpBPeSyk6ystx8Q74cPoO96RLc6fV8Oz4NSYRaKoj43pPATroa79QKASkGJWNld35m/6sem3jX4bnKwuxeYeLtgK4Cj9d1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741665307; c=relaxed/simple;
	bh=aZl4F3mWxPeYBX+lzGPPUXgqHxshh0zeDQfnvR7wkTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfofslfYJ7N6zIBAjXZ/roMmpu2e4KwMn688MkS5zbPciqCNH+pseJUQGCGprt+74+Fcj+ONfDRbtEnbRZlKL1az5tarcP56FSPIHOyoK1OvSYLEB5f7Bb8Nb8GlOiYN7rXdqywDrWNQii9AlcrLMefMDkvvCxt8qHFgY2JWZ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFHAvO37; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fef5c978ccso7451555a91.1;
        Mon, 10 Mar 2025 20:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741665303; x=1742270103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKgHko7LXHs4K1am04uF9IogKQS6sC+0t1gif1+Xz98=;
        b=mFHAvO37pObLT3JNrNLT+VZiZQ15iHZoGjgrWjcLYTdBJyoBDPu4Nz315mxhXAi78t
         TvA3ErR7SC511/odun9T2/ORB38ulu/toQ5IkmUz5O2FdkEn7ygsfxmf2ofp/lcAaRzx
         9rmlX5IHVAXIjSKtecu+n85jWK6xwlOPn9p4TtsMV6N5NuzLII3r53t8L+lTvg0CosIB
         SoVNGICWsG29CuWkHNDBERzaUCsKBcbonJAFy2jXAZ86h+L132PKLLh9/qXU82G6CQpC
         utiT2iQ2yE78VdIV3Vzbc7ouciULyJEoADJ1KJtOoqDOIHRoLqjcD7cwMV43XIgSMyhK
         cx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741665303; x=1742270103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKgHko7LXHs4K1am04uF9IogKQS6sC+0t1gif1+Xz98=;
        b=fo2zWyIGlFKaT3ufqxusD1eGst8TN0GR+nxoAntiZVaQWCO5rKXY68fB/DmPOL/0gi
         c9gWEpkYIVpSgyd5RIu96dCiAseOr3poLLOYUQDspBgil94cYWULLmFmrzweWrXF21fL
         mEWw6AdoD46YSZFT3QF04AxST9ZN++ur6KBFCCiZGr7And9j6O9qe7W/oyeyJFb38AnQ
         ndvg+4tiG+xj1SZt4zMMSKzSzwCkcUDyC7qKhc1TCfC+jQVGYDmktqIAwhD3QbrveHFP
         hVB288dpRh6NIEMurTAjgPlIR6uaqCyuVfp81bLRQNsjoorQonjqKwFq1FQ3dIfMGm3x
         cSIA==
X-Forwarded-Encrypted: i=1; AJvYcCVlHyLZ6LFQolRDlox5BRN1eWDJFyDZZe9gBl+bVLZg0Un3P7Y3e+xvBJ6JsdGNwqm8Q/RRfAJ2mDi3F2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxSRvXHKQAUmHnAUbcvPLRAi7ItPM8fd+aFitN9wSwApTNloAg
	jBc+5WKsaMt4e6XJmJl2P1WDov5OWORs2p0HPtJDknOd1heyYaNNo9261eLvpto1ViWQU5X6TDI
	jZHsjMa6JSXJJbw28Y8DMI+a2SUg=
X-Gm-Gg: ASbGncuRhduj+UEJCPm5kKrMxaj0vgtHJGgoUSIqMRgeb21PVf7uSAEQSDqP378Xssy
	AVzkz+tk35E96seYHH8+hYMiHPi3esWvz0PeX8/mVmPUZBRfFRP5Hywi+YJ9cXGNO/2bVUDVPst
	peKrRJOPkVqR2imYtVg+fAGsqDi7MWu7RR51Wt9Q==
X-Google-Smtp-Source: AGHT+IF2JYmk07/H5J79cQ5t4c07z3scGn/nu9TZQtApFx2IO/+BsMcdrTAuAk6MoANx8TwFvLi06GGHG0H17DbFv9s=
X-Received: by 2002:a17:90b:48ce:b0:2ff:64c3:3bd9 with SMTP id
 98e67ed59e1d1-2ff7ceee4bdmr19758250a91.23.1741665302486; Mon, 10 Mar 2025
 20:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310170447.729440535@linuxfoundation.org>
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 11 Mar 2025 03:54:50 +0000
X-Gm-Features: AQ5f1JrAbHCmMSTWYQ9x2rTmhBN0E7QLGiwbN18FFKXkOGVJHzvgpMC2f5FXBjw
Message-ID: <CADo9pHjZwHh5t8VgBRE59_5Ax_-3on-85HZ1R1FNRA1kwMmY5g@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/207] 6.13.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Works fine on my Dell Latitude 7390 laptop with model name    :
Intel(R) Core(TM) i5-8350U CPU @ 1.70GHz
and Arch Linux with testing repos enabled

Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den m=C3=A5n 10 mars 2025 kl 17:18 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> This is the start of the stable review cycle for the 6.13.7 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
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
>     Linux 6.13.7-rc1
>
> Maurizio Lombardi <mlombard@redhat.com>
>     nvme-tcp: Fix a C2HTermReq error message
>
> Arnd Bergmann <arnd@arndb.de>
>     ALSA: hda: realtek: fix incorrect IS_REACHABLE() usage
>
> Steven Rostedt <rostedt@goodmis.org>
>     fprobe: Fix accounting of when to unregister from function graph
>
> Steven Rostedt <rostedt@goodmis.org>
>     fprobe: Always unregister fgraph function from ops
>
> Lukas Bulwahn <lukas.bulwahn@redhat.com>
>     arm64: Kconfig: Remove selecting replaced HAVE_FUNCTION_GRAPH_RETVAL
>
> Arnd Bergmann <arnd@arndb.de>
>     kbuild: hdrcheck: fix cross build with clang
>
> Angelo Dureghello <adureghello@baylibre.com>
>     iio: adc: ad7606: fix wrong scale available
>
> Angelo Dureghello <adureghello@baylibre.com>
>     dt-bindings: iio: dac: adi-axi-adc: fix ad7606 pwm-names
>
> Ricardo Ribalda <ribalda@chromium.org>
>     iio: hid-sensor-prox: Split difference from multiple channels
>
> Ryan Roberts <ryan.roberts@arm.com>
>     arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes
>
> Ryan Roberts <ryan.roberts@arm.com>
>     mm: hugetlb: Add huge page size param to huge_ptep_get_and_clear()
>
> Nayab Sayed <nayabbasha.sayed@microchip.com>
>     iio: adc: at91-sama5d2_adc: fix sama7g5 realbits value
>
> Markus Burri <markus.burri@mt.com>
>     iio: adc: ad7192: fix channel select
>
> Angelo Dureghello <adureghello@baylibre.com>
>     iio: dac: ad3552r: clear reset status flag
>
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
>     iio: light: apds9306: fix max_scale_nano values
>
> Sam Winchenbach <swinchenbach@arka.org>
>     iio: filter: admv8818: Force initialization of SDO
>
> Haoyu Li <lihaoyu499@gmail.com>
>     drivers: virt: acrn: hsm: Use kzalloc to avoid info leak in pmcmd_ioc=
tl
>
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     eeprom: digsy_mtc: Make GPIO lookup table match the device
>
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>     bus: mhi: host: pci_generic: Use pci_try_reset_function() to avoid de=
adlock
>
> Visweswara Tanuku <quic_vtanuku@quicinc.com>
>     slimbus: messaging: Free transaction ID in delayed interrupt scenario
>
> Luca Ceresoli <luca.ceresoli@bootlin.com>
>     drivers: core: fix device leak in __fw_devlink_relax_cycles()
>
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>     char: misc: deallocate static minor in error path
>
> Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     intel_th: pci: Add Panther Lake-P/U support
>
> Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     intel_th: pci: Add Panther Lake-H support
>
> Pawel Chmielewski <pawel.chmielewski@intel.com>
>     intel_th: pci: Add Arrow Lake support
>
> Hans de Goede <hdegoede@redhat.com>
>     mei: vsc: Use "wakeuphostint" when getting the host wakeup GPIO
>
> Alexander Usyskin <alexander.usyskin@intel.com>
>     mei: me: add panther lake P DID
>
> Qiu-ji Chen <chenqiuji666@gmail.com>
>     cdx: Fix possible UAF error in driver_override_show()
>
> Xiaoyao Li <xiaoyao.li@intel.com>
>     KVM: x86: Explicitly zero EAX and EBX when PERFMON_V2 isn't supported=
 by KVM
>
> Sean Christopherson <seanjc@google.com>
>     KVM: x86: Snapshot the host's DEBUGCTL after disabling IRQs
>
> Sean Christopherson <seanjc@google.com>
>     KVM: SVM: Manually context switch DEBUGCTL if LBR virtualization is d=
isabled
>
> Sean Christopherson <seanjc@google.com>
>     KVM: x86: Snapshot the host's DEBUGCTL in common x86
>
> Sean Christopherson <seanjc@google.com>
>     KVM: SVM: Suppress DEBUGCTL.BTF on AMD
>
> Sean Christopherson <seanjc@google.com>
>     KVM: SVM: Drop DEBUGCTL[5:2] from guest's effective value
>
> Sean Christopherson <seanjc@google.com>
>     KVM: SVM: Save host DR masks on CPUs with DebugSwap
>
> Sean Christopherson <seanjc@google.com>
>     KVM: SVM: Set RFLAGS.IF=3D1 in C code, to get VMRUN out of the STI sh=
adow
>
> Christian A. Ehrhardt <lk@c--e.de>
>     acpi: typec: ucsi: Introduce a ->poll_cci method
>
> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>     kbuild: userprogs: use correct lld when linking through clang
>
> Prashanth K <prashanth.k@oss.qualcomm.com>
>     usb: gadget: Check bmAttributes only if configuration is valid
>
> Marek Szyprowski <m.szyprowski@samsung.com>
>     usb: gadget: Fix setting self-powered state on suspend
>
> Prashanth K <prashanth.k@oss.qualcomm.com>
>     usb: gadget: Set self-powered based on MaxPower and bmAttributes
>
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>     usb: typec: tcpci_rt1711h: Unmask alert interrupts to fix functionali=
ty
>
> Fedor Pchelkin <boddah8794@gmail.com>
>     usb: typec: ucsi: increase timeout for PPM reset operations
>
> Badhri Jagan Sridharan <badhri@google.com>
>     usb: dwc3: gadget: Prevent irq storm when TH re-executes
>
> Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>     usb: dwc3: Set SUSPENDENABLE soon after phy init
>
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>     usb: atm: cxacru: fix a flaw in existing endpoint checks
>
> Prashanth K <prashanth.k@oss.qualcomm.com>
>     usb: gadget: u_ether: Set is_suspend flag if remote wakeup fails
>
> Michal Pecio <michal.pecio@gmail.com>
>     usb: xhci: Enable the TRB overfetch quirk on VIA VL805
>
> Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>     usb: renesas_usbhs: Flush the notify_hotplug_work
>
> Andrei Kuchynski <akuchynski@chromium.org>
>     usb: typec: ucsi: Fix NULL pointer access
>
> Michal Pecio <michal.pecio@gmail.com>
>     usb: xhci: Fix host controllers "dying" after suspend and resume
>
> Miao Li <limiao@kylinos.cn>
>     usb: quirks: Add DELAY_INIT and NO_LPM for Prolific Mass Storage Card=
 Reader
>
> Pawel Laszczak <pawell@cadence.com>
>     usb: hub: lack of clearing xHC resources
>
> Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>     usb: renesas_usbhs: Use devm_usb_get_phy()
>
> Marc Zyngier <maz@kernel.org>
>     xhci: Restrict USB4 tunnel detection for USB3 devices to Intel hosts
>
> Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>     usb: renesas_usbhs: Call clk_put()
>
> Christian Heusel <christian@heusel.eu>
>     Revert "drivers/card_reader/rtsx_usb: Restore interrupt based detecti=
on"
>
> Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>     gpio: rcar: Fix missing of_node_put() call
>
> Justin Iurman <justin.iurman@uliege.be>
>     net: ipv6: fix missing dst ref drop in ila lwtunnel
>
> Justin Iurman <justin.iurman@uliege.be>
>     net: ipv6: fix dst ref loop in ila lwtunnel
>
> Matt Johnston <matt@codeconstruct.com.au>
>     mctp i3c: handle NULL header address
>
> Takashi Iwai <tiwai@suse.de>
>     drm/bochs: Fix DPMS regression
>
> Lorenzo Bianconi <lorenzo@kernel.org>
>     net: dsa: mt7530: Fix traffic flooding for MMIO devices
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     nvme-tcp: fix signedness bug in nvme_tcp_init_connection()
>
> Zecheng Li <zecheng@google.com>
>     sched/fair: Fix potential memory corruption in child_cfs_rq_on_list
>
> Uday Shankar <ushankar@purestorage.com>
>     ublk: set_params: properly check if parameters can be applied
>
> Jason Xing <kerneljasonxing@gmail.com>
>     net-timestamp: support TCP GSO case for a few missing flags
>
> Eric Sandeen <sandeen@redhat.com>
>     exfat: short-circuit zero-byte writes in exfat_file_write_iter
>
> Namjae Jeon <linkinjeon@kernel.org>
>     exfat: fix soft lockup in exfat_clear_bitmap
>
> Yuezhang Mo <Yuezhang.Mo@sony.com>
>     exfat: fix just enough dentries but allocate a new cluster to dir
>
> Jarkko Sakkinen <jarkko@kernel.org>
>     x86/sgx: Fix size overflows in sgx_encl_create()
>
> Oscar Maes <oscmaes92@gmail.com>
>     vlan: enforce underlying device type
>
> Maxime Chevallier <maxime.chevallier@bootlin.com>
>     net: ethtool: netlink: Allow NULL nlattrs when getting a phy_device
>
> Jakub Kicinski <kuba@kernel.org>
>     net: ethtool: plumb PHY stats to PHY drivers
>
> Oleksij Rempel <o.rempel@pengutronix.de>
>     ethtool: linkstate: migrate linkstate functions to support multi-PHY =
setups
>
> Jiayuan Chen <jiayuan.chen@linux.dev>
>     ppp: Fix KMSAN uninit-value warning with bpf
>
> Luca Weiss <luca.weiss@fairphone.com>
>     net: ipa: Enable checksum for IPA_ENDPOINT_AP_MODEM_{RX,TX} for v4.7
>
> Luca Weiss <luca.weiss@fairphone.com>
>     net: ipa: Fix QSB data for v4.7
>
> Luca Weiss <luca.weiss@fairphone.com>
>     net: ipa: Fix v4.7 resource group names
>
> Vicki Pfau <vi@endrift.com>
>     HID: hid-steam: Fix use-after-free when detaching device
>
> Maarten Lankhorst <dev@lankhorst.se>
>     drm/xe: Remove double pageflip
>
> Peiyang Wang <wangpeiyang1@huawei.com>
>     net: hns3: make sure ptp clock is unregister and freed if hclge_ptp_g=
et_cycle returns an error
>
> Nikolay Aleksandrov <razor@blackwall.org>
>     be2net: fix sleeping while atomic bugs in be_ndo_bridge_getlink
>
> Philipp Stanner <phasta@kernel.org>
>     drm/sched: Fix preprocessor guard
>
> Xinghuo Chen <xinghuo.chen@foxmail.com>
>     hwmon: fix a NULL vs IS_ERR_OR_NULL() check in xgene_hwmon_probe()
>
> Eric Dumazet <edumazet@google.com>
>     llc: do not use skb_get() before dev_queue_xmit()
>
> Murad Masimov <m.masimov@mt-integration.ru>
>     ALSA: usx2y: validate nrpacks module parameter on probe
>
> Alessio Belle <alessio.belle@imgtec.com>
>     drm/imagination: Fix timestamps in firmware traces
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     tracing: probe-events: Remove unused MAX_ARG_BUF_LEN macro
>
> Erik Schumacher <erik.schumacher@iris-sensing.com>
>     hwmon: (ad7314) Validate leading zero bits and return error
>
> Maud Spierings <maudspierings@gocontroll.com>
>     hwmon: (ntc_thermistor) Fix the ncpXXxh103 sensor table
>
> Titus Rwantare <titusr@google.com>
>     hwmon: (pmbus) Initialise page count in pmbus_identify()
>
> Herbert Xu <herbert@gondor.apana.org.au>
>     cred: Fix RCU warnings in override/revert_creds
>
> Christian Brauner <brauner@kernel.org>
>     cred: return old creds from revert_creds_light()
>
> Peter Zijlstra <peterz@infradead.org>
>     perf/core: Fix pmus_lock vs. pmus_srcu ordering
>
> Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
>     caif_virtio: fix wrong pointer check in cfv_probe()
>
> Antoine Tenart <atenart@kernel.org>
>     net: gso: fix ownership in __udp_gso_segment
>
> Antheas Kapenekakis <lkml@antheas.dev>
>     ALSA: hda/realtek: Remove (revert) duplicate Ally X config
>
> Meir Elisha <meir.elisha@volumez.com>
>     nvmet-tcp: Fix a possible sporadic response drops in weakly ordered a=
rch
>
> Maurizio Lombardi <mlombard@redhat.com>
>     nvme-tcp: fix potential memory corruption in nvme_tcp_recv_pdu()
>
> Maurizio Lombardi <mlombard@redhat.com>
>     nvme-tcp: add basic support for the C2HTermReq PDU
>
> Maurizio Lombardi <mlombard@redhat.com>
>     nvmet: remove old function prototype
>
> Salah Triki <salah.triki@gmail.com>
>     bluetooth: btusb: Initialize .owner field of force_poll_sync_fops
>
> Dave Airlie <airlied@redhat.com>
>     drm/nouveau: select FW caching
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     tracing: fprobe-events: Log error for exceeding the number of entry a=
rgs
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     fprobe: Rewrite fprobe on function-graph tracer
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     tracing: Add ftrace_fill_perf_regs() for perf event
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_r=
egs
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     fprobe: Use ftrace_regs in fprobe exit handler
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     fprobe: Use ftrace_regs in fprobe entry handler
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     fgraph: Replace fgraph_ret_regs with ftrace_regs
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211: fix vendor-specific inheritance
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211: fix MLE non-inheritance parsing
>
> Ilan Peer <ilan.peer@intel.com>
>     wifi: mac80211: Support parsing EPCS ML element
>
> Keith Busch <kbusch@kernel.org>
>     nvme-ioctl: fix leaked requests on mapping error
>
> Kees Cook <kees@kernel.org>
>     coredump: Only sort VMAs when core_sort_vma sysctl is set
>
> Zhang Lixu <lixu.zhang@intel.com>
>     HID: intel-ish-hid: Fix use-after-free issue in ishtp_hid_remove()
>
> Zhang Lixu <lixu.zhang@intel.com>
>     HID: intel-ish-hid: Fix use-after-free issue in hid_ishtp_cl_remove()
>
> Yu-Chun Lin <eleanor15x@gmail.com>
>     HID: google: fix unused variable warning under !CONFIG_ACPI
>
> Ilan Peer <ilan.peer@intel.com>
>     wifi: iwlwifi: Fix A-MSDU TSO preparation
>
> Ilan Peer <ilan.peer@intel.com>
>     wifi: iwlwifi: Free pages allocated when failing to build A-MSDU
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: iwlwifi: limit printed string from FW file
>
> Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>     wifi: iwlwifi: mvm: don't try to talk to a dead firmware
>
> Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>     wifi: iwlwifi: mvm: don't dump the firmware state upon RFKILL while s=
uspend
>
> Benjamin Berg <benjamin.berg@intel.com>
>     wifi: iwlwifi: mvm: log error for failures after D3
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: iwlwifi: mvm: clean up ROC on failure
>
> Miri Korenblit <miriam.rachel.korenblit@intel.com>
>     wifi: iwlwifi: fw: avoid using an uninitialized variable
>
> Ma Wupeng <mawupeng1@huawei.com>
>     mm: memory-hotplug: check folio ref count first in do_migrate_range
>
> Ma Wupeng <mawupeng1@huawei.com>
>     hwpoison, memory_hotplug: lock folio before unmap hwpoisoned folio
>
> Brian Geffon <bgeffon@google.com>
>     mm: fix finish_fault() handling for large folios
>
> Ryan Roberts <ryan.roberts@arm.com>
>     mm: don't skip arch_sync_kernel_mappings() in error paths
>
> Ma Wupeng <mawupeng1@huawei.com>
>     mm: memory-failure: update ttu flag inside unmap_poisoned_folio
>
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>     mm: abort vma_modify() on merge out of memory failure
>
> Hao Zhang <zhanghao1@kylinos.cn>
>     mm/page_alloc: fix uninitialized variable
>
> Olivier Gayot <olivier.gayot@canonical.com>
>     block: fix conversion of GPT partition name to 7-bit
>
> Qi Zheng <zhengqi.arch@bytedance.com>
>     arm: pgtable: fix NULL pointer dereference issue
>
> Suren Baghdasaryan <surenb@google.com>
>     userfaultfd: do not block on locking a large folio with raised refcou=
nt
>
> Mike Snitzer <snitzer@kernel.org>
>     NFS: fix nfs_release_folio() to not deadlock via kcompactd writeback
>
> Heiko Carstens <hca@linux.ibm.com>
>     s390/traps: Fix test_monitor_call() inline assembly
>
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     dma: kmsan: export kmsan_handle_dma() for modules
>
> Haoxiang Li <haoxiang_li2024@163.com>
>     rapidio: fix an API misues when rio_add_net() fails
>
> Haoxiang Li <haoxiang_li2024@163.com>
>     rapidio: add check for rio_add_net() in rio_scan_alloc_net()
>
> SeongJae Park <sj@kernel.org>
>     selftests/damon/damon_nr_regions: sort collected regiosn before check=
ing with min/max boundaries
>
> SeongJae Park <sj@kernel.org>
>     selftests/damon/damon_nr_regions: set ops update for merge results ch=
eck to 100ms
>
> SeongJae Park <sj@kernel.org>
>     selftests/damon/damos_quota: make real expectation of quota exceeds
>
> SeongJae Park <sj@kernel.org>
>     selftests/damon/damos_quota_goal: handle minimum quota that cannot be=
 further reduced
>
> Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
>     wifi: nl80211: reject cooked mode if it is set along with other flags
>
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>     wifi: cfg80211: regulatory: improve invalid hints checking
>
> Haoxiang Li <haoxiang_li2024@163.com>
>     Bluetooth: Add check for mgmt_alloc_skb() in mgmt_device_connected()
>
> Haoxiang Li <haoxiang_li2024@163.com>
>     Bluetooth: Add check for mgmt_alloc_skb() in mgmt_remote_name()
>
> Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>     drm/xe/userptr: Unmap userptrs in the mmu notifier
>
> Matthew Auld <matthew.auld@intel.com>
>     drm/xe/userptr: properly setup pfn_flags_mask
>
> Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>     drm/xe: Fix fault mode invalidation with unbind
>
> Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>     drm/xe: Fix GT "for each engine" workarounds
>
> Krister Johansen <kjlx@templeofstupid.com>
>     mptcp: fix 'scheduling while atomic' in mptcp_pm_nl_append_new_local_=
addr
>
> Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>     drm/xe/vm: Validate userptr during gpu vma prefetching
>
> Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>     drm/xe/vm: Fix a misplaced #endif
>
> Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>     drm/xe/hmm: Don't dereference struct page pointers without notifier l=
ock
>
> Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>     drm/xe/hmm: Style- and include fixes
>
> Matthew Brost <matthew.brost@intel.com>
>     drm/xe: Add staging tree for VM binds
>
> Ahmed S. Darwish <darwi@linutronix.de>
>     x86/cpu: Properly parse CPUID leaf 0x2 TLB descriptor 0x63
>
> Ahmed S. Darwish <darwi@linutronix.de>
>     x86/cpu: Validate CPUID leaf 0x2 EDX output
>
> Ahmed S. Darwish <darwi@linutronix.de>
>     x86/cacheinfo: Validate CPUID leaf 0x2 EDX output
>
> Ard Biesheuvel <ardb@kernel.org>
>     x86/boot: Sanitize boot params before parsing command line
>
> Mingcong Bai <jeffbai@aosc.io>
>     platform/x86: thinkpad_acpi: Add battery quirk for ThinkPad X131e
>
> John Hubbard <jhubbard@nvidia.com>
>     Revert "selftests/mm: remove local __NR_* definitions"
>
> Gabriel Krisman Bertazi <krisman@suse.de>
>     Revert "mm/page_alloc.c: don't show protection in zone's ->lowmem_res=
erve[] for empty zone"
>
> Richard Thier <u9vata@gmail.com>
>     drm/radeon: Fix rs400_gpu_init for ATI mobility radeon Xpress 200M
>
> Brendan King <Brendan.King@imgtec.com>
>     drm/imagination: only init job done fences once
>
> Brendan King <Brendan.King@imgtec.com>
>     drm/imagination: Hold drm_gem_gpuva lock for unmap
>
> Brendan King <Brendan.King@imgtec.com>
>     drm/imagination: avoid deadlock on fence release
>
> Kenneth Feng <kenneth.feng@amd.com>
>     drm/amd/pm: always allow ih interrupt from fw
>
> Andrew Martin <Andrew.Martin@amd.com>
>     drm/amdkfd: Fix NULL Pointer Dereference in KFD queue
>
> Ma Ke <make24@iscas.ac.cn>
>     drm/amd/display: Fix null check for pipe_ctx->plane_state in resource=
_build_scaling_params
>
> Paul Fertser <fercerpav@gmail.com>
>     hwmon: (peci/dimmtemp) Do not provide fake thresholds data
>
> Nikunj A Dadhania <nikunj@amd.com>
>     virt: sev-guest: Allocate request data dynamically
>
> Haoxiang Li <haoxiang_li2024@163.com>
>     btrfs: fix a leaked chunk map issue in read_one_chunk()
>
> Naohiro Aota <naohiro.aota@wdc.com>
>     btrfs: zoned: fix extent range end unlock in cow_file_range()
>
> Kailang Yang <kailang@realtek.com>
>     ALSA: hda/realtek: update ALC222 depop optimize
>
> Kailang Yang <kailang@realtek.com>
>     ALSA: hda/realtek - add supported Mic Mute LED for Lenovo platform
>
> Hoku Ishibe <me@hokuishi.be>
>     ALSA: hda: intel: Add Dell ALC3271 to power_save denylist
>
> Takashi Iwai <tiwai@suse.de>
>     ALSA: seq: Avoid module auto-load handling at event delivery
>
> Koichiro Den <koichiro.den@canonical.com>
>     gpio: aggregator: protect driver attr handlers against module unload
>
> Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
>     gpio: rcar: Use raw_spinlock to protect register access
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: fix bug on trap in smb2_lock
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: fix use-after-free in smb2_lock
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: fix out-of-bounds in parse_sec_desc()
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: fix type confusion via race condition when using ipc_msg_send_=
request
>
> Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
>     HID: corsair-void: Update power supply values with a unified work han=
dler
>
> Daniil Dulov <d.dulov@aladdin.ru>
>     HID: appleir: Fix potential NULL dereference at raw event handle
>
> Bibo Mao <maobibo@loongson.cn>
>     LoongArch: KVM: Fix GPA size issue about VM
>
> Bibo Mao <maobibo@loongson.cn>
>     LoongArch: KVM: Reload guest CSR registers after sleep
>
> Bibo Mao <maobibo@loongson.cn>
>     LoongArch: KVM: Add interrupt checking for AVEC
>
> Bibo Mao <maobibo@loongson.cn>
>     LoongArch: Set max_pfn with the PFN of the last page
>
> Bibo Mao <maobibo@loongson.cn>
>     LoongArch: Set hugetlb mmap base address aligned with pmd size
>
> Huacai Chen <chenhuacai@kernel.org>
>     LoongArch: Use polling play_dead() when resuming from hibernation
>
> Tiezhu Yang <yangtiezhu@loongson.cn>
>     LoongArch: Convert unreachable() to BUG()
>
> Philipp Stanner <phasta@kernel.org>
>     stmmac: loongson: Pass correct arg to PCI function
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     tracing: tprobe-events: Reject invalid tracepoint name
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     tracing: tprobe-events: Fix a memory leak when tprobe with $retval
>
> Rob Herring (Arm) <robh@kernel.org>
>     Revert "of: reserved-memory: Fix using wrong number of cells to get p=
roperty 'alignment'"
>
> Peter Zijlstra <peterz@infradead.org>
>     loongarch: Use ASM_REACHABLE
>
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/microcode/AMD: Add some forgotten models to the SHA check
>
> Steve French <stfrench@microsoft.com>
>     smb311: failure to open files of length 1040 when mounting with SMB3.=
1.1 POSIX extensions
>
> Pali Roh=C3=A1r <pali@kernel.org>
>     cifs: Remove symlink member from cifs_open_info_data union
>
> Yutaro Ohno <yutaro.ono.418@gmail.com>
>     rust: block: fix formatting in GenDisk doc
>
> Andrew Cooper <andrew.cooper3@citrix.com>
>     x86/amd_nb: Use rdmsr_safe() in amd_get_mmconfig_range()
>
>
> -------------
>
> Diffstat:
>
>  Documentation/admin-guide/sysctl/kernel.rst        |  11 +
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |   1 +
>  Makefile                                           |   9 +-
>  arch/arm/mm/fault-armv.c                           |  37 +-
>  arch/arm64/Kconfig                                 |   2 +-
>  arch/arm64/include/asm/ftrace.h                    |  49 +-
>  arch/arm64/include/asm/hugetlb.h                   |   4 +-
>  arch/arm64/kernel/asm-offsets.c                    |  12 -
>  arch/arm64/kernel/entry-ftrace.S                   |  32 +-
>  arch/arm64/mm/hugetlbpage.c                        |  59 +-
>  arch/loongarch/Kconfig                             |   3 +-
>  arch/loongarch/include/asm/bug.h                   |  13 +-
>  arch/loongarch/include/asm/ftrace.h                |  32 +-
>  arch/loongarch/include/asm/hugetlb.h               |   6 +-
>  arch/loongarch/kernel/asm-offsets.c                |  12 -
>  arch/loongarch/kernel/machine_kexec.c              |   4 +-
>  arch/loongarch/kernel/mcount.S                     |  17 +-
>  arch/loongarch/kernel/mcount_dyn.S                 |  14 +-
>  arch/loongarch/kernel/setup.c                      |   3 +
>  arch/loongarch/kernel/smp.c                        |  47 +-
>  arch/loongarch/kvm/exit.c                          |   6 +
>  arch/loongarch/kvm/main.c                          |   7 +
>  arch/loongarch/kvm/vcpu.c                          |   2 +-
>  arch/loongarch/kvm/vm.c                            |   6 +-
>  arch/loongarch/mm/mmap.c                           |   6 +-
>  arch/mips/include/asm/hugetlb.h                    |   6 +-
>  arch/parisc/include/asm/hugetlb.h                  |   2 +-
>  arch/parisc/mm/hugetlbpage.c                       |   2 +-
>  arch/powerpc/include/asm/ftrace.h                  |  13 +
>  arch/powerpc/include/asm/hugetlb.h                 |   6 +-
>  arch/riscv/Kconfig                                 |   2 +-
>  arch/riscv/include/asm/ftrace.h                    |  45 +-
>  arch/riscv/include/asm/hugetlb.h                   |   3 +-
>  arch/riscv/kernel/mcount.S                         |  24 +-
>  arch/riscv/mm/hugetlbpage.c                        |   2 +-
>  arch/s390/Kconfig                                  |   3 +-
>  arch/s390/include/asm/ftrace.h                     |  36 +-
>  arch/s390/include/asm/hugetlb.h                    |  18 +-
>  arch/s390/kernel/asm-offsets.c                     |   6 -
>  arch/s390/kernel/mcount.S                          |  12 +-
>  arch/s390/kernel/traps.c                           |   6 +-
>  arch/s390/mm/hugetlbpage.c                         |   4 +-
>  arch/sparc/include/asm/hugetlb.h                   |   2 +-
>  arch/sparc/mm/hugetlbpage.c                        |   2 +-
>  arch/x86/Kconfig                                   |   3 +-
>  arch/x86/boot/compressed/pgtable_64.c              |   2 +
>  arch/x86/include/asm/ftrace.h                      |  33 +-
>  arch/x86/include/asm/kvm_host.h                    |   1 +
>  arch/x86/kernel/amd_nb.c                           |   9 +-
>  arch/x86/kernel/cpu/cacheinfo.c                    |   2 +-
>  arch/x86/kernel/cpu/intel.c                        |  52 +-
>  arch/x86/kernel/cpu/microcode/amd.c                |   6 +
>  arch/x86/kernel/cpu/sgx/ioctl.c                    |   7 +
>  arch/x86/kernel/ftrace_32.S                        |  13 +-
>  arch/x86/kernel/ftrace_64.S                        |  17 +-
>  arch/x86/kvm/cpuid.c                               |   2 +-
>  arch/x86/kvm/svm/sev.c                             |  13 +-
>  arch/x86/kvm/svm/svm.c                             |  49 ++
>  arch/x86/kvm/svm/svm.h                             |   2 +-
>  arch/x86/kvm/svm/vmenter.S                         |  10 +-
>  arch/x86/kvm/vmx/vmx.c                             |   8 +-
>  arch/x86/kvm/vmx/vmx.h                             |   2 -
>  arch/x86/kvm/x86.c                                 |   2 +
>  block/partitions/efi.c                             |   2 +-
>  drivers/base/core.c                                |   1 +
>  drivers/block/ublk_drv.c                           |   7 +-
>  drivers/bluetooth/btusb.c                          |   1 +
>  drivers/bus/mhi/host/pci_generic.c                 |   5 +-
>  drivers/cdx/cdx.c                                  |   6 +-
>  drivers/char/misc.c                                |   2 +-
>  drivers/gpio/gpio-aggregator.c                     |  20 +-
>  drivers/gpio/gpio-rcar.c                           |  31 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |   4 +-
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   3 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |  12 +-
>  drivers/gpu/drm/imagination/pvr_fw_meta.c          |   6 +-
>  drivers/gpu/drm/imagination/pvr_fw_trace.c         |   4 +-
>  drivers/gpu/drm/imagination/pvr_queue.c            |  18 +-
>  drivers/gpu/drm/imagination/pvr_queue.h            |   4 +
>  drivers/gpu/drm/imagination/pvr_vm.c               | 134 ++++-
>  drivers/gpu/drm/imagination/pvr_vm.h               |   3 +
>  drivers/gpu/drm/nouveau/Kconfig                    |   1 +
>  drivers/gpu/drm/radeon/r300.c                      |   3 +-
>  drivers/gpu/drm/radeon/radeon_asic.h               |   1 +
>  drivers/gpu/drm/radeon/rs400.c                     |  18 +-
>  drivers/gpu/drm/scheduler/gpu_scheduler_trace.h    |   4 +-
>  drivers/gpu/drm/tiny/bochs.c                       |   5 +-
>  drivers/gpu/drm/xe/display/xe_plane_initial.c      |  10 -
>  drivers/gpu/drm/xe/xe_gt.c                         |   4 +-
>  drivers/gpu/drm/xe/xe_hmm.c                        | 194 ++++--
>  drivers/gpu/drm/xe/xe_hmm.h                        |   7 +
>  drivers/gpu/drm/xe/xe_pt.c                         |  96 +--
>  drivers/gpu/drm/xe/xe_pt_walk.c                    |   3 +-
>  drivers/gpu/drm/xe/xe_pt_walk.h                    |   4 +
>  drivers/gpu/drm/xe/xe_vm.c                         | 100 +++-
>  drivers/gpu/drm/xe/xe_vm.h                         |  10 +-
>  drivers/gpu/drm/xe/xe_vm_types.h                   |   8 +-
>  drivers/hid/hid-appleir.c                          |   2 +-
>  drivers/hid/hid-corsair-void.c                     |  83 +--
>  drivers/hid/hid-google-hammer.c                    |   2 +
>  drivers/hid/hid-steam.c                            |   2 +-
>  drivers/hid/intel-ish-hid/ishtp-hid-client.c       |   2 +-
>  drivers/hid/intel-ish-hid/ishtp-hid.c              |   4 +-
>  drivers/hwmon/ad7314.c                             |  10 +
>  drivers/hwmon/ntc_thermistor.c                     |  66 +--
>  drivers/hwmon/peci/dimmtemp.c                      |  10 +-
>  drivers/hwmon/pmbus/pmbus.c                        |   2 +
>  drivers/hwmon/xgene-hwmon.c                        |   2 +-
>  drivers/hwtracing/intel_th/pci.c                   |  15 +
>  drivers/iio/adc/ad7192.c                           |   2 +-
>  drivers/iio/adc/ad7606.c                           |   2 +-
>  drivers/iio/adc/at91-sama5d2_adc.c                 |  68 ++-
>  drivers/iio/dac/ad3552r.c                          |   6 +
>  drivers/iio/filter/admv8818.c                      |  14 +-
>  drivers/iio/light/apds9306.c                       |   4 +-
>  drivers/iio/light/hid-sensor-prox.c                |   7 +-
>  drivers/misc/cardreader/rtsx_usb.c                 |  15 -
>  drivers/misc/eeprom/digsy_mtc_eeprom.c             |   2 +-
>  drivers/misc/mei/hw-me-regs.h                      |   2 +
>  drivers/misc/mei/pci-me.c                          |   2 +
>  drivers/misc/mei/vsc-tp.c                          |   2 +-
>  drivers/net/caif/caif_virtio.c                     |   2 +-
>  drivers/net/dsa/mt7530.c                           |   8 +-
>  drivers/net/ethernet/emulex/benet/be.h             |   2 +-
>  drivers/net/ethernet/emulex/benet/be_cmds.c        | 197 ++++---
>  drivers/net/ethernet/emulex/benet/be_main.c        |   2 +-
>  .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |   2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   6 +-
>  drivers/net/ipa/data/ipa_data-v4.7.c               |  18 +-
>  drivers/net/mctp/mctp-i3c.c                        |   3 +
>  drivers/net/phy/phy.c                              |  43 ++
>  drivers/net/phy/phy_device.c                       |   2 +
>  drivers/net/ppp/ppp_generic.c                      |  28 +-
>  drivers/net/wireless/intel/iwlwifi/fw/dump.c       |   3 +
>  drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  77 ++-
>  drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   7 +
>  .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   2 +
>  drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   5 +-
>  drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |   6 +-
>  drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |  20 +-
>  drivers/nvme/host/ioctl.c                          |  12 +-
>  drivers/nvme/host/tcp.c                            |  81 ++-
>  drivers/nvme/target/nvmet.h                        |   1 -
>  drivers/nvme/target/tcp.c                          |  15 +-
>  drivers/of/of_reserved_mem.c                       |   4 +-
>  drivers/platform/x86/thinkpad_acpi.c               |   1 +
>  drivers/rapidio/devices/rio_mport_cdev.c           |   3 +-
>  drivers/rapidio/rio-scan.c                         |   5 +-
>  drivers/slimbus/messaging.c                        |   5 +-
>  drivers/usb/atm/cxacru.c                           |  13 +-
>  drivers/usb/core/hub.c                             |  33 ++
>  drivers/usb/core/quirks.c                          |   4 +
>  drivers/usb/dwc3/core.c                            |  85 +--
>  drivers/usb/dwc3/core.h                            |   2 +-
>  drivers/usb/dwc3/drd.c                             |   4 +-
>  drivers/usb/dwc3/gadget.c                          |  10 +-
>  drivers/usb/gadget/composite.c                     |  17 +-
>  drivers/usb/gadget/function/u_ether.c              |   4 +-
>  drivers/usb/host/xhci-hub.c                        |   8 +
>  drivers/usb/host/xhci-mem.c                        |   3 +-
>  drivers/usb/host/xhci-pci.c                        |  10 +-
>  drivers/usb/host/xhci.c                            |   6 +-
>  drivers/usb/host/xhci.h                            |   2 +-
>  drivers/usb/renesas_usbhs/common.c                 |   6 +-
>  drivers/usb/renesas_usbhs/mod_gadget.c             |   2 +-
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c             |  11 +
>  drivers/usb/typec/ucsi/ucsi.c                      |  25 +-
>  drivers/usb/typec/ucsi/ucsi.h                      |   2 +
>  drivers/usb/typec/ucsi/ucsi_acpi.c                 |  21 +-
>  drivers/usb/typec/ucsi/ucsi_ccg.c                  |   1 +
>  drivers/usb/typec/ucsi/ucsi_glink.c                |   1 +
>  drivers/usb/typec/ucsi/ucsi_stm32g0.c              |   1 +
>  drivers/usb/typec/ucsi/ucsi_yoga_c630.c            |   1 +
>  drivers/virt/acrn/hsm.c                            |   6 +-
>  drivers/virt/coco/sev-guest/sev-guest.c            |  24 +-
>  fs/btrfs/inode.c                                   |   9 +-
>  fs/btrfs/volumes.c                                 |   1 +
>  fs/coredump.c                                      |  15 +-
>  fs/exfat/balloc.c                                  |  10 +-
>  fs/exfat/exfat_fs.h                                |   2 +-
>  fs/exfat/fatent.c                                  |  11 +-
>  fs/exfat/file.c                                    |   2 +-
>  fs/exfat/namei.c                                   |   2 +-
>  fs/nfs/file.c                                      |   3 +-
>  fs/smb/client/cifsglob.h                           |   6 +-
>  fs/smb/client/inode.c                              |   2 +-
>  fs/smb/client/reparse.h                            |  28 +-
>  fs/smb/client/smb1ops.c                            |   4 +-
>  fs/smb/client/smb2inode.c                          |   4 +
>  fs/smb/client/smb2ops.c                            |   3 +-
>  fs/smb/server/smb2pdu.c                            |   8 +-
>  fs/smb/server/smbacl.c                             |  16 +
>  fs/smb/server/transport_ipc.c                      |   1 +
>  include/asm-generic/hugetlb.h                      |   2 +-
>  include/linux/compaction.h                         |   5 +
>  include/linux/cred.h                               |   9 +-
>  include/linux/ethtool.h                            |  23 +
>  include/linux/fprobe.h                             |  62 +-
>  include/linux/ftrace.h                             |  66 ++-
>  include/linux/ftrace_regs.h                        |   2 +
>  include/linux/hugetlb.h                            |   4 +-
>  include/linux/nvme-tcp.h                           |   2 +
>  include/linux/phy.h                                |  36 ++
>  include/linux/phylib_stubs.h                       |  42 ++
>  include/linux/sched.h                              |   2 +-
>  kernel/events/core.c                               |   4 +-
>  kernel/sched/fair.c                                |   6 +-
>  kernel/trace/Kconfig                               |  18 +-
>  kernel/trace/bpf_trace.c                           |  16 +-
>  kernel/trace/fgraph.c                              |  21 +-
>  kernel/trace/fprobe.c                              | 653 +++++++++++++++=
------
>  kernel/trace/trace_fprobe.c                        |  37 +-
>  kernel/trace/trace_probe.h                         |   5 +-
>  lib/test_fprobe.c                                  |  51 +-
>  mm/compaction.c                                    |   3 +
>  mm/hugetlb.c                                       |   4 +-
>  mm/internal.h                                      |   5 +-
>  mm/kmsan/hooks.c                                   |   1 +
>  mm/memory-failure.c                                |  63 +-
>  mm/memory.c                                        |  21 +-
>  mm/memory_hotplug.c                                |  28 +-
>  mm/page_alloc.c                                    |   4 +-
>  mm/userfaultfd.c                                   |  17 +-
>  mm/vma.c                                           |  12 +-
>  mm/vmalloc.c                                       |   4 +-
>  net/8021q/vlan.c                                   |   3 +-
>  net/bluetooth/mgmt.c                               |   5 +
>  net/ethtool/cabletest.c                            |   8 +-
>  net/ethtool/linkstate.c                            |  26 +-
>  net/ethtool/netlink.c                              |   6 +-
>  net/ethtool/netlink.h                              |   5 +-
>  net/ethtool/phy.c                                  |   2 +-
>  net/ethtool/plca.c                                 |   6 +-
>  net/ethtool/pse-pd.c                               |   4 +-
>  net/ethtool/stats.c                                |  18 +
>  net/ethtool/strset.c                               |   2 +-
>  net/ipv4/tcp_offload.c                             |  11 +-
>  net/ipv4/udp_offload.c                             |   8 +-
>  net/ipv6/ila/ila_lwt.c                             |   4 +-
>  net/llc/llc_s_ac.c                                 |  49 +-
>  net/mac80211/ieee80211_i.h                         |   2 +
>  net/mac80211/mlme.c                                |   1 +
>  net/mac80211/parse.c                               | 164 ++++--
>  net/mptcp/pm_netlink.c                             |  18 +-
>  net/wireless/nl80211.c                             |   5 +
>  net/wireless/reg.c                                 |   3 +-
>  rust/kernel/block/mq/gen_disk.rs                   |   6 +-
>  samples/fprobe/fprobe_example.c                    |   4 +-
>  sound/core/seq/seq_clientmgr.c                     |  46 +-
>  sound/pci/hda/Kconfig                              |   1 +
>  sound/pci/hda/hda_intel.c                          |   2 +
>  sound/pci/hda/patch_realtek.c                      | 107 +++-
>  sound/usb/usx2y/usbusx2y.c                         |  11 +
>  sound/usb/usx2y/usbusx2y.h                         |  26 +
>  sound/usb/usx2y/usbusx2yaudio.c                    |  27 -
>  tools/testing/selftests/damon/damon_nr_regions.py  |   2 +
>  tools/testing/selftests/damon/damos_quota.py       |   9 +-
>  tools/testing/selftests/damon/damos_quota_goal.py  |   3 +
>  tools/testing/selftests/mm/hugepage-mremap.c       |   2 +-
>  tools/testing/selftests/mm/ksm_functional_tests.c  |   8 +-
>  tools/testing/selftests/mm/memfd_secret.c          |  14 +-
>  tools/testing/selftests/mm/mkdirty.c               |   8 +-
>  tools/testing/selftests/mm/mlock2.h                |   1 -
>  tools/testing/selftests/mm/protection_keys.c       |   2 +-
>  tools/testing/selftests/mm/uffd-common.c           |   4 +
>  tools/testing/selftests/mm/uffd-stress.c           |  15 +-
>  tools/testing/selftests/mm/uffd-unit-tests.c       |  14 +-
>  usr/include/Makefile                               |   2 +-
>  269 files changed, 3214 insertions(+), 1547 deletions(-)
>
>
>

