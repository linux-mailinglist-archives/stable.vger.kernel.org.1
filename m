Return-Path: <stable+bounces-161427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9261BAFE79E
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 13:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47AB7A112A
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 11:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA882918DE;
	Wed,  9 Jul 2025 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOEwEahg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE079291864;
	Wed,  9 Jul 2025 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060261; cv=none; b=X3gB9FNZ5rHF337hNSOMFeiS7B/oFRpMkTq0BxVNWdnRLIMod4T6gH+FtCPIpjZ0LrViLyNYI9o+O5pHiYKJ533+YecnwKkpxsaNnrgGQvOV2+74cOXOIQDZsIKrz+It4H7Apqh33WOwt3Iv4dPCKzUnSHGBbK334xYswk+mUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060261; c=relaxed/simple;
	bh=FahUOfhaYDKvbGWpjVVaU+ELz95UBThRMjTdPld8c+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mu6bchgZL7Q7g2IGtvm7GAF7RKA9EbCbjiBsDeph/q0DvCouBXK6NyajKxuwxHQCZ7f3SI/EsjCZ9XGmVTvdKNyIe182eGp5JBDGddTrC1DRVKjIOUc2BectVKbJAfC7dsjRTY8bc6bFC8n4mdKJ6ttw7ZKmFkRAaMO289mm9Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOEwEahg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2352400344aso55087015ad.2;
        Wed, 09 Jul 2025 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752060258; x=1752665058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDDtO3H8UKFgr2hgJKt1MU52cVxg5Qm2X95SKLn2M1U=;
        b=JOEwEahgEQu5vpKk9DTm0Dl22orPWG9s58b1SqD92G1odpT+zq26KPZ07mOP2ENoAS
         XPtanvzfnXA70LPL3wiPmgGQGsuplkLHhKNtcJPm0K5Do508usJRw5vtBbDXb3xETjXO
         Me9S85AUas4gKSZ1S0NytHtBj1DzQA+p/f6wKJWfj3L1lkWnrHNed8X91eokUUU5eBDU
         ts3EohMCM46VpFoahAnaTHRB6CvpD3Etg9A0JZxzsMS1o7/cBBXq5zqM2TF9nDP0TnD6
         F5vFqmrDcmFFYlbB8PZIe51VegogkZi8DvcB5KqCrfiiqYm7ScyLgrowETdeh9Zs7wNE
         280w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060258; x=1752665058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDDtO3H8UKFgr2hgJKt1MU52cVxg5Qm2X95SKLn2M1U=;
        b=bVJy7qJjsz3rNRbXvSyKC7cyKsrEUXj1mXmN6cVoaqy+Q+/0dXF9UhdjqrrHqm4lV5
         EFb096Dl6vjQmphsL3TvmkyITMsW//Zb4KsSIqMk484uxDlKB9K/PSDaipbf1YvbUs/U
         xXT1rG8NSVadqu4b5LbyD05YML+8/U7lQkL5ydmNkPOsT1kEXZ9Yys+t3paJ3q0lKQIg
         vu29d9U3b9o+hNkVazgMYMwWs0R0yQFidmeYnLIfX1n0ovqz4P0eKYeG+AvNiiLfW2h3
         h7MNLC36q/PFcRXmTe9ByfiJBuBrohVgB+nvTD16PneJc+hy3TeESoY0bzY1xLbfUrGV
         5jkw==
X-Forwarded-Encrypted: i=1; AJvYcCXj2aKF6C+fzMumIWCWdZHwLsqcVfIktSfEyqbdsrcGIXgeyokjj7geVgCaUKewg2N+LrjjlxNvyfkCWAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAS41YOgdPd1rus3I5QSmoT66CcEnOIY2wJO1/m0AeDG9Q+GqZ
	qGlShge2/u+xMOOt7rKRa5z8JgQNEw5//pYO6Ggmsl/0pdKFCqG360kJt4qk0wqh7QITaRhYVln
	V0mwUuwldA1jMfMCtkuxIMpwC++G0nN+Q0hR3dHnzFA==
X-Gm-Gg: ASbGncs75Jlkhs180tZGiFyX1MdCTHELKYkargvxMf0aB7gwFLgjYcznN1iS0Kaquxb
	9cCHBMIt/0iFs0J3VYlnJ5gEYFpM2VrBiPpj9jvPYokp4HhI+coq1YodQ7Dy06e2Et8SAjY7feP
	ft85l17kNStO9YLlZXYgHFP5OKrq8qH5tkJ7ZnM4vafCdPye2tk4nWL3h1Mg==
X-Google-Smtp-Source: AGHT+IEgZZ03W593QdqS/5MKbOwv+IG4ABH5EUT6RKcbGnaG0yvtBHnjVoMxqgrZBCfl0XOj0jeZbrSLwrdox3bj1co=
X-Received: by 2002:a17:902:d60d:b0:235:e76c:4353 with SMTP id
 d9443c01a7336-23ddb324c90mr33126265ad.51.1752060257608; Wed, 09 Jul 2025
 04:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708162236.549307806@linuxfoundation.org>
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Wed, 9 Jul 2025 13:24:02 +0200
X-Gm-Features: Ac12FXwTKbCx-7x38uiIVIgEcMzjYGaCxUaJC6WRGcxE5ewuMGfXaNlyWhxs57M
Message-ID: <CADo9pHhgoGj9ABToAEs0OSNc5yaTWvxRVv8g_AOgLiTKxof1nA@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/178] 6.15.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

Den tis 8 juli 2025 kl 18:23 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> This is the start of the stable review cycle for the 6.15.6 release.
> There are 178 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
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
>     Linux 6.15.6-rc1
>
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/process: Move the buffer clearing before MONITOR
>
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/microcode/AMD: Add TSA microcode SHAs
>
> Borislav Petkov (AMD) <bp@alien8.de>
>     KVM: SVM: Advertise TSA CPUID bits to guests
>
> Borislav Petkov <bp@alien8.de>
>     KVM: x86: Sort CPUID_8000_0021_EAX leaf bits properly
>
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/bugs: Add a Transient Scheduler Attacks mitigation
>
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/bugs: Rename MDS machinery to something more generic
>
> Jeongjun Park <aha310510@gmail.com>
>     mm/vmalloc: fix data race in show_numa_info()
>
> Andrei Kuchynski <akuchynski@chromium.org>
>     usb: typec: displayport: Fix potential deadlock
>
> Kurt Borja <kuurtb@gmail.com>
>     platform/x86: think-lmi: Fix sysfs group cleanup
>
> Kurt Borja <kuurtb@gmail.com>
>     platform/x86: think-lmi: Fix kobject cleanup
>
> Kurt Borja <kuurtb@gmail.com>
>     platform/x86: think-lmi: Create ksets consecutively
>
> Vivian Wang <wangruikang@iscas.ac.cn>
>     riscv: cpu_ops_sbi: Use static array for boot_data
>
> Zhang Rui <rui.zhang@intel.com>
>     powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit cannot=
 be changed
>
> Lu Baolu <baolu.lu@linux.intel.com>
>     iommu/vt-d: Assign devtlb cache tag on ATS enablement
>
> Simon Xue <xxm@rock-chips.com>
>     iommu/rockchip: prevent iommus dead loop when two masters share one I=
OMMU
>
> Jens Wiklander <jens.wiklander@linaro.org>
>     optee: ffa: fix sleep in atomic context
>
> Oliver Neukum <oneukum@suse.com>
>     Logitech C-270 even more broken
>
> Michael J. Ruhl <michael.j.ruhl@intel.com>
>     i2c/designware: Fix an initialization issue
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     dt-bindings: i2c: realtek,rtl9301: Fix missing 'reg' constraint
>
> Qasim Ijaz <qasdev00@gmail.com>
>     HID: appletb-kbd: fix slab use-after-free bug in appletb_kbd_probe
>
> Christian K=C3=B6nig <christian.koenig@amd.com>
>     dma-buf: fix timeout handling in dma_resv_wait_timeout v2
>
> Shyam Prasad N <sprasad@microsoft.com>
>     cifs: all initializations for tcon should happen in tcon_info_alloc
>
> Philipp Kerling <pkerling@casix.org>
>     smb: client: fix readdir returning wrong type with POSIX extensions
>
> Heikki Krogerus <heikki.krogerus@linux.intel.com>
>     usb: acpi: fix device link removal
>
> Xu Yang <xu.yang_2@nxp.com>
>     usb: chipidea: udc: disconnect/reconnect from host when do suspend/re=
sume
>
> SCHNEIDER Johannes <johannes.schneider@leica-geosystems.com>
>     usb: dwc3: gadget: Fix TRB reclaim logic for short transfers and ZLPs
>
> Kuen-Han Tsai <khtsai@google.com>
>     usb: dwc3: Abort suspend on soft disconnect failure
>
> Pawel Laszczak <pawell@cadence.com>
>     usb: cdnsp: Fix issue with CV Bad Descriptor test
>
> Peter Chen <peter.chen@cixtech.com>
>     usb: cdnsp: do not disable slot for disabled slot
>
> Jeff LaBundy <jeff@labundy.com>
>     Input: iqs7222 - explicitly define number of external channels
>
> Nilton Perim Neto <niltonperimneto@gmail.com>
>     Input: xpad - support Acer NGR 200 Controller
>
> Qasim Ijaz <qasdev00@gmail.com>
>     HID: appletb-kbd: fix memory corruption of input_handler_list
>
> Hongyu Xie <xiehongyu1@kylinos.cn>
>     xhci: Disable stream for xHC controller with XHCI_BROKEN_STREAMS
>
> Mathias Nyman <mathias.nyman@linux.intel.com>
>     xhci: dbc: Flush queued requests before stopping dbc
>
> =C5=81ukasz Bartosik <ukaszb@chromium.org>
>     xhci: dbctty: disable ECHO flag by default
>
> Raju Rangoju <Raju.Rangoju@amd.com>
>     usb: xhci: quirk for data loss in ISOC transfers
>
> Roy Luo <royluo@google.com>
>     Revert "usb: xhci: Implement xhci_handshake_check_state() helper"
>
> Roy Luo <royluo@google.com>
>     usb: xhci: Skip xhci_reset in xhci_resume if xhci is being removed
>
> Uladzislau Rezki (Sony) <urezki@gmail.com>
>     rcu: Return early if callback is not specified
>
> Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
>     mtd: spinand: fix memory leak of ECC engine conf
>
> Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     ACPICA: Refuse to evaluate a method if arguments are missing
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: ath6kl: remove WARN on bad firmware input
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211: drop invalid source address OCB frames
>
> Justin Sanders <jsanders.devel@gmail.com>
>     aoe: defer rexmit timer downdev work to workqueue
>
> Maurizio Lombardi <mlombard@redhat.com>
>     scsi: target: Fix NULL pointer dereference in core_scsi3_decode_spec_=
i_port()
>
> Heiko Stuebner <heiko@sntech.de>
>     regulator: fan53555: add enable_time support and soft-start times
>
> Raven Black <ravenblack@gmail.com>
>     ASoC: amd: yc: update quirk data for HP Victus
>
> Madhavan Srinivasan <maddy@linux.ibm.com>
>     powerpc: Fix struct termio related ioctl macros
>
> Gyeyoung Baek <gye976@gmail.com>
>     genirq/irq_sim: Initialize work context pointers properly
>
> Mario Limonciello <mario.limonciello@amd.com>
>     platform/x86/amd/pmc: Add PCSpecialist Lafite Pro V 14M to 8042 quirk=
s list
>
> Gabriel Santese <santesegabriel@gmail.com>
>     ASoC: amd: yc: Add quirk for MSI Bravo 17 D7VF internal mic
>
> Johannes Berg <johannes.berg@intel.com>
>     ata: pata_cs5536: fix build on 32-bit UML
>
> Tasos Sahanidis <tasos@tasossah.com>
>     ata: libata-acpi: Do not assume 40 wire cable if no devices are enabl=
ed
>
> Takashi Iwai <tiwai@suse.de>
>     ALSA: sb: Force to disable DMAs once when DMA mode is changed
>
> Takashi Iwai <tiwai@suse.de>
>     ALSA: sb: Don't allow changing the DMA mode during operations
>
> Rob Clark <robdclark@chromium.org>
>     drm/msm: Fix another leak in the submit error path
>
> Rob Clark <robdclark@chromium.org>
>     drm/msm: Fix a fence leak in submit error path
>
> Jake Hillion <jake@hillion.co.uk>
>     x86/platform/amd: move final timeout check to after final sleep
>
> Harry Austen <hpausten@protonmail.com>
>     drm/xe: Allow dropping kunit dependency as built-in
>
> David Howells <dhowells@redhat.com>
>     netfs: Fix double put of request
>
> Paulo Alcantara <pc@manguebit.org>
>     smb: client: fix native SMB symlink traversal
>
> Wang Zhaolong <wangzhaolong@huaweicloud.com>
>     smb: client: fix race condition in negotiate timeout by using more pr=
ecise timing
>
> Antoine Tenart <atenart@kernel.org>
>     net: ipv4: fix stat increase when udp early demux drops the packet
>
> Raju Rangoju <Raju.Rangoju@amd.com>
>     amd-xgbe: do not double read link status
>
> Lion Ackermann <nnamrec@gmail.com>
>     net/sched: Always pass notifications when child class becomes empty
>
> Thomas Fourier <fourier.thomas@gmail.com>
>     nui: Fix dma_mapping_error() check
>
> Kohei Enju <enjuk@amazon.com>
>     rose: fix dangling neighbour pointers in rose_rt_device_down()
>
> Alok Tiwari <alok.a.tiwari@oracle.com>
>     enic: fix incorrect MTU comparison in enic_change_mtu()
>
> Raju Rangoju <Raju.Rangoju@amd.com>
>     amd-xgbe: align CL37 AN sequence as per databook
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     lib: test_objagg: Set error message in check_expect_hints_stats()
>
> Vinay Belgaumkar <vinay.belgaumkar@intel.com>
>     drm/xe/bmg: Update Wa_22019338487
>
> Vinay Belgaumkar <vinay.belgaumkar@intel.com>
>     drm/xe/bmg: Update Wa_14022085890
>
> Lucas De Marchi <lucas.demarchi@intel.com>
>     drm/xe: Split xe_device_td_flush()
>
> Lucas De Marchi <lucas.demarchi@intel.com>
>     drm/xe/guc_pc: Add _locked variant for min/max freq
>
> John Harrison <John.C.Harrison@Intel.com>
>     drm/xe/guc: Enable w/a 16026508708
>
> David Howells <dhowells@redhat.com>
>     netfs: Fix i_size updating
>
> Paulo Alcantara <pc@manguebit.org>
>     smb: client: set missing retry flag in cifs_writev_callback()
>
> Paulo Alcantara <pc@manguebit.org>
>     smb: client: set missing retry flag in cifs_readv_callback()
>
> Paulo Alcantara <pc@manguebit.org>
>     smb: client: set missing retry flag in smb2_writev_callback()
>
> David Howells <dhowells@redhat.com>
>     netfs: Fix ref leak on inserted extra subreq in write retry
>
> David Howells <dhowells@redhat.com>
>     netfs: Fix looping in wait functions
>
> David Howells <dhowells@redhat.com>
>     netfs: Fix hang due to missing case in final DIO read result collecti=
on
>
> Jia Yao <jia.yao@intel.com>
>     drm/xe: Fix out-of-bounds field write in MI_STORE_DATA_IMM
>
> Vitaly Lifshits <vitaly.lifshits@intel.com>
>     igc: disable L1.2 PCI-E link substate to avoid performance issue
>
> Ahmed Zaki <ahmed.zaki@intel.com>
>     idpf: convert control queue mutex to a spinlock
>
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>     idpf: return 0 size for RSS key if not supported
>
> Geliang Tang <geliang@kernel.org>
>     nvme-multipath: fix suspicious RCU usage warning
>
> Junxiao Chang <junxiao.chang@intel.com>
>     drm/i915/gsc: mei interrupt top half should be in irq disabled contex=
t
>
> Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
>     drm/i915/gt: Fix timeline left held on VMA alloc error
>
> Marko Kiiskila <marko.kiiskila@broadcom.com>
>     drm/vmwgfx: Fix guests running with TDX/SEV
>
> Oleksij Rempel <o.rempel@pengutronix.de>
>     net: usb: lan78xx: fix WARN in __netif_napi_del_locked on disconnect
>
> Paulo Alcantara <pc@manguebit.org>
>     smb: client: fix warning when reconnecting channel
>
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>     drm/bridge: aux-hpd-bridge: fix assignment of the of_node
>
> Dmitry Baryshkov <lumag@kernel.org>
>     drm/bridge: panel: move prepare_prev_first handling to drm_panel_brid=
ge_add_typed
>
> Alok Tiwari <alok.a.tiwari@oracle.com>
>     platform/mellanox: mlxreg-lc: Fix logic error in power state check
>
> Kurt Borja <kuurtb@gmail.com>
>     platform/x86: dell-wmi-sysman: Fix class device unregistration
>
> Kurt Borja <kuurtb@gmail.com>
>     platform/x86: think-lmi: Fix class device unregistration
>
> Kurt Borja <kuurtb@gmail.com>
>     platform/x86: hp-bioscfg: Fix class device unregistration
>
> Kurt Borja <kuurtb@gmail.com>
>     platform/x86: dell-wmi-sysman: Fix WMI data block retrieval in sysfs =
callbacks
>
> Eugen Hristev <eugen.hristev@linaro.org>
>     nvme-pci: refresh visible attrs after being checked
>
> Dmitry Bogdanov <d.bogdanov@yadro.com>
>     nvmet: fix memory leak of bio integrity
>
> Alok Tiwari <alok.a.tiwari@oracle.com>
>     nvme: Fix incorrect cdw15 value in passthru error logging
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     drm/i915/selftests: Change mock_request() to return error pointers
>
> James Clark <james.clark@linaro.org>
>     spi: spi-fsl-dspi: Clear completion counter before initiating transfe=
r
>
> Gabor Juhos <j4g8y7@gmail.com>
>     spi: spi-qpic-snand: reallocate BAM transactions
>
> Marek Szyprowski <m.szyprowski@samsung.com>
>     drm/exynos: fimd: Guard display clock control with runtime PM calls
>
> Fushuai Wang <wangfushuai@baidu.com>
>     dpaa2-eth: fix xdp_rxq_info leak
>
> Thomas Fourier <fourier.thomas@gmail.com>
>     ethernet: atl1: Add missing DMA mapping error checks and count errors
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: use btrfs_record_snapshot_destroy() during rmdir
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: propagate last_unlink_trans earlier when doing a rmdir
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: record new subvolume in parent dir earlier to avoid dir loggin=
g races
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: fix inode lookup error handling during log replay
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: fix iteration of extrefs during log replay
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: fix missing error handling when searching for inode refs durin=
g log replay
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: fix failure to rebuild free space tree using multiple transact=
ions
>
> Yang Li <yang.li@amlogic.com>
>     Bluetooth: Prevent unintended pause by checking if advertising is act=
ive
>
> Trond Myklebust <trond.myklebust@hammerspace.com>
>     NFSv4/flexfiles: Fix handling of NFS level errors in I/O
>
> Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
>     flexfiles/pNFS: update stats on NFS4ERR_DELAY for v4.1 DSes
>
> Armin Wolf <W_Armin@gmx.de>
>     platform/x86: wmi: Fix WMI event enablement
>
> Alok Tiwari <alok.a.tiwari@oracle.com>
>     platform/mellanox: nvsw-sn2201: Fix bus number in adapter error messa=
ge
>
> Alok Tiwari <alok.a.tiwari@oracle.com>
>     platform/mellanox: mlxbf-pmc: Fix duplicate event ID for CACHE_DATA1
>
> Patrisious Haddad <phaddad@nvidia.com>
>     RDMA/mlx5: Fix vport loopback for MPV device
>
> Patrisious Haddad <phaddad@nvidia.com>
>     RDMA/mlx5: Fix CC counters query for MPV
>
> Patrisious Haddad <phaddad@nvidia.com>
>     RDMA/mlx5: Fix HW counters query for non-representor devices
>
> Or Har-Toov <ohartoov@nvidia.com>
>     IB/mlx5: Fix potential deadlock in MR deregistration
>
> Bart Van Assche <bvanassche@acm.org>
>     scsi: ufs: core: Fix spelling of a sysfs attribute name
>
> Christoph Hellwig <hch@lst.de>
>     scsi: core: Enforce unlimited max_segment_size when virt_boundary_mas=
k is set
>
> jackysliu <1972843537@qq.com>
>     scsi: sd: Fix VPD page 0xb7 length check
>
> Thomas Fourier <fourier.thomas@gmail.com>
>     scsi: qla4xxx: Fix missing DMA mapping error in qla4xxx_alloc_pdu()
>
> Thomas Fourier <fourier.thomas@gmail.com>
>     scsi: qla2xxx: Fix DMA mapping test in qla24xx_get_port_database()
>
> Benjamin Coddington <bcodding@redhat.com>
>     NFSv4/pNFS: Fix a race to wake on NFS_LAYOUT_DRAIN
>
> Kuniyuki Iwashima <kuniyu@google.com>
>     nfs: Clean up /proc/net/rpc/nfs when nfs_fs_proc_net_init() fails.
>
> Shivank Garg <shivankg@amd.com>
>     fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypas=
s
>
> Peter Zijlstra <peterz@infradead.org>
>     module: Provide EXPORT_SYMBOL_GPL_FOR_MODULES() helper
>
> Mark Zhang <markzhang@nvidia.com>
>     RDMA/mlx5: Initialize obj_event->obj_sub_list before xa_insert
>
> Or Har-Toov <ohartoov@nvidia.com>
>     RDMA/mlx5: Fix unsafe xarray access in implicit ODP handling
>
> David Thompson <davthompson@nvidia.com>
>     platform/mellanox: mlxbf-tmfifo: fix vring_desc.len assignment
>
> Sven Peter <sven@kernel.org>
>     arm64: dts: apple: Move touchbar mipi {address,size}-cells from dtsi =
to dts
>
> Sven Peter <sven@kernel.org>
>     arm64: dts: apple: Drop {address,size}-cells from SPI NOR
>
> Janne Grunau <j@jannau.net>
>     arm64: dts: apple: t8103: Fix PCIe BCM4377 nodename
>
> Arnd Bergmann <arnd@arndb.de>
>     RDMA/mlx5: reduce stack usage in mlx5_ib_ufile_hw_cleanup
>
> Tudor Ambarus <tudor.ambarus@linaro.org>
>     firmware: exynos-acpm: fix timeouts on xfers handling
>
> Viresh Kumar <viresh.kumar@linaro.org>
>     firmware: arm_ffa: Fix the missing entry in struct ffa_indirect_msg_h=
dr
>
> Sudeep Holla <sudeep.holla@arm.com>
>     firmware: arm_ffa: Replace mutex with rwlock to avoid sleep in atomic=
 context
>
> Sudeep Holla <sudeep.holla@arm.com>
>     firmware: arm_ffa: Move memory allocation outside the mutex locking
>
> Sudeep Holla <sudeep.holla@arm.com>
>     firmware: arm_ffa: Fix memory leak by freeing notifier callback node
>
> Ma=C3=ADra Canal <mcanal@igalia.com>
>     drm/v3d: Disable interrupts before resetting the GPU
>
> Sergey Senozhatsky <senozhatsky@chromium.org>
>     mtk-sd: reset host->mrq on prepare_data() error
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     mtk-sd: Prevent memory corruption from DMA map failure
>
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>     mtk-sd: Fix a pagefault in dma_unmap_sg() for not prepared data
>
> RD Babiera <rdbabiera@google.com>
>     usb: typec: altmodes/displayport: do not index invalid pin_assignment=
s
>
> Christian Brauner <brauner@kernel.org>
>     anon_inode: rework assertions
>
> Yunshui Jiang <jiangyunshui@kylinos.cn>
>     Input: cs40l50-vibra - fix potential NULL dereference in cs40l50_uplo=
ad_owt()
>
> Manivannan Sadhasivam <mani@kernel.org>
>     regulator: gpio: Fix the out-of-bounds access to drvdata::gpiods
>
> Nicolin Chen <nicolinc@nvidia.com>
>     iommufd/selftest: Fix iommufd_dirty_tracking with large hugepage size=
s
>
> Christian Eggers <ceggers@arri.de>
>     Bluetooth: MGMT: mesh_send: check instances prior disabling advertisi=
ng
>
> Christian Eggers <ceggers@arri.de>
>     Bluetooth: MGMT: set_mesh: update LE scan interval and window
>
> Christian Eggers <ceggers@arri.de>
>     Bluetooth: hci_sync: revert some mesh modifications
>
> Christian Eggers <ceggers@arri.de>
>     Bluetooth: HCI: Set extended advertising data synchronously
>
> Victor Shih <victor.shih@genesyslogic.com.tw>
>     mmc: core: Adjust some error messages for SD UHS-II cards
>
> Avri Altman <avri.altman@sandisk.com>
>     mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier
>
> Victor Shih <victor.shih@genesyslogic.com.tw>
>     mmc: sdhci-uhs2: Adjust some error messages and register dump for SD =
UHS-II card
>
> Ulf Hansson <ulf.hansson@linaro.org>
>     Revert "mmc: sdhci: Disable SD card clock before changing parameters"
>
> Darrick J. Wong <djwong@kernel.org>
>     xfs: actually use the xfs_growfs_check_rtgeom tracepoint
>
> Victor Shih <victor.shih@genesyslogic.com.tw>
>     mmc: sdhci: Add a helper function for dump register in dynamic debug =
mode
>
> Jiawen Wu <jiawenwu@trustnetic.com>
>     net: libwx: fix the incorrect display of the queue number
>
> Nicolin Chen <nicolinc@nvidia.com>
>     iommufd/selftest: Add asserts testing global mfd
>
> Nicolin Chen <nicolinc@nvidia.com>
>     iommufd/selftest: Add missing close(mfd) in memfd_mmap()
>
> HarshaVardhana S A <harshavardhana.sa@broadcom.com>
>     vsock/vmci: Clear the vmci transport packet properly when initializin=
g it
>
> Jiawen Wu <jiawenwu@trustnetic.com>
>     net: txgbe: request MISC IRQ in ndo_open
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     dt-bindings: net: sophgo,sg2044-dwmac: Drop status from the example
>
> Niklas Schnelle <schnelle@linux.ibm.com>
>     s390/pci: Do not try re-enabling load/store if device is disabled
>
> Niklas Schnelle <schnelle@linux.ibm.com>
>     s390/pci: Fix stale function handles in error handling
>
> Bui Quang Minh <minhquangbui99@gmail.com>
>     virtio-net: ensure the received length does not exceed allocated size
>
> Bui Quang Minh <minhquangbui99@gmail.com>
>     virtio-net: xsk: rx: fix the frame's length check
>
> Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
>     rtc: cmos: use spin_lock_irqsave in cmos_interrupt
>
> Elena Popa <elena.popa@nxp.com>
>     rtc: pcf2127: fix SPI command byte for PCF2131
>
> Hugo Villeneuve <hvilleneuve@dimonoff.com>
>     rtc: pcf2127: add missing semicolon after statement
>
>
> -------------
>
> Diffstat:
>
>  Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
>  Documentation/ABI/testing/sysfs-driver-ufs         |   2 +-
>  .../hw-vuln/processor_mmio_stale_data.rst          |   4 +-
>  Documentation/admin-guide/kernel-parameters.txt    |  13 ++
>  Documentation/arch/x86/mds.rst                     |   8 +-
>  Documentation/core-api/symbol-namespaces.rst       |  22 ++
>  .../bindings/i2c/realtek,rtl9301-i2c.yaml          |   3 +-
>  .../bindings/net/sophgo,sg2044-dwmac.yaml          |   3 +-
>  Makefile                                           |   4 +-
>  arch/arm64/boot/dts/apple/spi1-nvram.dtsi          |   2 -
>  arch/arm64/boot/dts/apple/t8103-j293.dts           |   2 +
>  arch/arm64/boot/dts/apple/t8103-jxxx.dtsi          |   2 +-
>  arch/arm64/boot/dts/apple/t8103.dtsi               |   2 -
>  arch/arm64/boot/dts/apple/t8112-j493.dts           |   2 +
>  arch/arm64/boot/dts/apple/t8112.dtsi               |   2 -
>  arch/powerpc/include/uapi/asm/ioctls.h             |   8 +-
>  arch/riscv/kernel/cpu_ops_sbi.c                    |   6 +-
>  arch/s390/pci/pci_event.c                          |  15 ++
>  arch/x86/Kconfig                                   |   9 +
>  arch/x86/entry/entry.S                             |   8 +-
>  arch/x86/include/asm/cpufeatures.h                 |   5 +
>  arch/x86/include/asm/irqflags.h                    |   4 +-
>  arch/x86/include/asm/kvm_host.h                    |   1 +
>  arch/x86/include/asm/mwait.h                       |  28 ++-
>  arch/x86/include/asm/nospec-branch.h               |  37 +--
>  arch/x86/kernel/cpu/amd.c                          |  44 ++++
>  arch/x86/kernel/cpu/bugs.c                         | 133 ++++++++++-
>  arch/x86/kernel/cpu/common.c                       |  14 +-
>  arch/x86/kernel/cpu/microcode/amd_shas.c           | 112 +++++++++
>  arch/x86/kernel/cpu/scattered.c                    |   2 +
>  arch/x86/kernel/process.c                          |  16 +-
>  arch/x86/kvm/cpuid.c                               |  15 +-
>  arch/x86/kvm/reverse_cpuid.h                       |   7 +
>  arch/x86/kvm/svm/vmenter.S                         |   6 +
>  arch/x86/kvm/vmx/vmx.c                             |   2 +-
>  drivers/acpi/acpica/dsmethod.c                     |   7 +
>  drivers/ata/libata-acpi.c                          |  24 +-
>  drivers/ata/pata_cs5536.c                          |   2 +-
>  drivers/ata/pata_via.c                             |   6 +-
>  drivers/base/cpu.c                                 |   3 +
>  drivers/block/aoe/aoe.h                            |   1 +
>  drivers/block/aoe/aoecmd.c                         |   8 +-
>  drivers/block/aoe/aoedev.c                         |   5 +-
>  drivers/dma-buf/dma-resv.c                         |  12 +-
>  drivers/firmware/arm_ffa/driver.c                  |  71 +++---
>  drivers/firmware/samsung/exynos-acpm.c             |  27 +--
>  drivers/gpu/drm/bridge/aux-hpd-bridge.c            |   3 +-
>  drivers/gpu/drm/bridge/panel.c                     |   5 +-
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c           |  12 +
>  drivers/gpu/drm/i915/gt/intel_gsc.c                |   2 +-
>  drivers/gpu/drm/i915/gt/intel_ring_submission.c    |   3 +-
>  drivers/gpu/drm/i915/selftests/i915_request.c      |  20 +-
>  drivers/gpu/drm/i915/selftests/mock_request.c      |   2 +-
>  drivers/gpu/drm/msm/msm_gem_submit.c               |  17 +-
>  drivers/gpu/drm/v3d/v3d_drv.h                      |   8 +
>  drivers/gpu/drm/v3d/v3d_gem.c                      |   2 +
>  drivers/gpu/drm/v3d/v3d_irq.c                      |  37 ++-
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   2 +-
>  drivers/gpu/drm/xe/Kconfig                         |   3 +-
>  drivers/gpu/drm/xe/abi/guc_klvs_abi.h              |   1 +
>  drivers/gpu/drm/xe/xe_device.c                     |  72 +++---
>  drivers/gpu/drm/xe/xe_guc_ads.c                    |   5 +
>  drivers/gpu/drm/xe/xe_guc_pc.c                     | 249 +++++++++++++++=
+-----
>  drivers/gpu/drm/xe/xe_guc_pc.h                     |   2 +
>  drivers/gpu/drm/xe/xe_guc_pc_types.h               |   2 +
>  drivers/gpu/drm/xe/xe_migrate.c                    |  18 +-
>  drivers/gpu/drm/xe/xe_wa_oob.rules                 |   6 +
>  drivers/hid/hid-appletb-kbd.c                      |  14 +-
>  drivers/i2c/busses/i2c-designware-master.c         |   1 +
>  drivers/infiniband/hw/mlx5/counters.c              |   4 +-
>  drivers/infiniband/hw/mlx5/devx.c                  |  10 +-
>  drivers/infiniband/hw/mlx5/main.c                  |  33 +++
>  drivers/infiniband/hw/mlx5/mr.c                    |  61 +++--
>  drivers/infiniband/hw/mlx5/odp.c                   |   8 +-
>  drivers/input/joystick/xpad.c                      |   2 +
>  drivers/input/misc/cs40l50-vibra.c                 |   2 +
>  drivers/input/misc/iqs7222.c                       |   7 +-
>  drivers/iommu/intel/cache.c                        |   5 +-
>  drivers/iommu/intel/iommu.c                        |  11 +-
>  drivers/iommu/intel/iommu.h                        |   2 +
>  drivers/iommu/rockchip-iommu.c                     |   3 +-
>  drivers/mmc/core/quirks.h                          |  12 +-
>  drivers/mmc/core/sd_uhs2.c                         |   4 +-
>  drivers/mmc/host/mtk-sd.c                          |  21 +-
>  drivers/mmc/host/sdhci-uhs2.c                      |  20 +-
>  drivers/mmc/host/sdhci.c                           |   9 +-
>  drivers/mmc/host/sdhci.h                           |  16 ++
>  drivers/mtd/nand/spi/core.c                        |   1 +
>  drivers/net/ethernet/amd/xgbe/xgbe-common.h        |   2 +
>  drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  13 ++
>  drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        |  24 +-
>  drivers/net/ethernet/amd/xgbe/xgbe.h               |   4 +-
>  drivers/net/ethernet/atheros/atlx/atl1.c           |  79 +++++--
>  drivers/net/ethernet/cisco/enic/enic_main.c        |   4 +-
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |  26 ++-
>  drivers/net/ethernet/intel/idpf/idpf_controlq.c    |  23 +-
>  .../net/ethernet/intel/idpf/idpf_controlq_api.h    |   2 +-
>  drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |   4 +-
>  drivers/net/ethernet/intel/idpf/idpf_lib.c         |  12 +-
>  drivers/net/ethernet/intel/igc/igc_main.c          |  10 +
>  drivers/net/ethernet/sun/niu.c                     |  31 ++-
>  drivers/net/ethernet/sun/niu.h                     |   4 +
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   1 +
>  drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c     |   2 +-
>  drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |  22 +-
>  drivers/net/usb/lan78xx.c                          |   2 -
>  drivers/net/virtio_net.c                           |  60 ++++-
>  drivers/net/wireless/ath/ath6kl/bmi.c              |   4 +-
>  drivers/nvme/host/core.c                           |   2 +-
>  drivers/nvme/host/multipath.c                      |   3 +-
>  drivers/nvme/host/pci.c                            |   6 +-
>  drivers/nvme/target/nvmet.h                        |   2 +
>  drivers/platform/mellanox/mlxbf-pmc.c              |   2 +-
>  drivers/platform/mellanox/mlxbf-tmfifo.c           |   3 +-
>  drivers/platform/mellanox/mlxreg-lc.c              |   2 +-
>  drivers/platform/mellanox/nvsw-sn2201.c            |   2 +-
>  drivers/platform/x86/amd/hsmp/hsmp.c               |   6 +-
>  drivers/platform/x86/amd/pmc/pmc-quirks.c          |   9 +
>  .../x86/dell/dell-wmi-sysman/dell-wmi-sysman.h     |   5 +
>  .../x86/dell/dell-wmi-sysman/enum-attributes.c     |   5 +-
>  .../x86/dell/dell-wmi-sysman/int-attributes.c      |   5 +-
>  .../x86/dell/dell-wmi-sysman/passobj-attributes.c  |   5 +-
>  .../x86/dell/dell-wmi-sysman/string-attributes.c   |   5 +-
>  drivers/platform/x86/dell/dell-wmi-sysman/sysman.c |  12 +-
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c       |   4 +-
>  drivers/platform/x86/think-lmi.c                   |  94 +++-----
>  drivers/platform/x86/wmi.c                         |  16 +-
>  drivers/powercap/intel_rapl_common.c               |  18 +-
>  drivers/regulator/fan53555.c                       |  14 ++
>  drivers/regulator/gpio-regulator.c                 |   8 +-
>  drivers/rtc/rtc-cmos.c                             |  10 +-
>  drivers/rtc/rtc-pcf2127.c                          |   7 +-
>  drivers/scsi/hosts.c                               |  18 +-
>  drivers/scsi/qla2xxx/qla_mbx.c                     |   2 +-
>  drivers/scsi/qla4xxx/ql4_os.c                      |   2 +
>  drivers/scsi/sd.c                                  |   2 +-
>  drivers/spi/spi-fsl-dspi.c                         |  11 +-
>  drivers/spi/spi-qpic-snand.c                       |  16 ++
>  drivers/target/target_core_pr.c                    |   4 +-
>  drivers/tee/optee/ffa_abi.c                        |  41 +++-
>  drivers/tee/optee/optee_private.h                  |   2 +
>  drivers/ufs/core/ufs-sysfs.c                       |   4 +-
>  drivers/usb/cdns3/cdnsp-debug.h                    |   5 +-
>  drivers/usb/cdns3/cdnsp-ep0.c                      |  18 +-
>  drivers/usb/cdns3/cdnsp-gadget.h                   |   6 +
>  drivers/usb/cdns3/cdnsp-ring.c                     |   7 +-
>  drivers/usb/chipidea/udc.c                         |   7 +
>  drivers/usb/core/hub.c                             |   3 +
>  drivers/usb/core/quirks.c                          |   3 +-
>  drivers/usb/core/usb-acpi.c                        |   4 +-
>  drivers/usb/dwc3/core.c                            |   9 +-
>  drivers/usb/dwc3/gadget.c                          |  24 +-
>  drivers/usb/host/xhci-dbgcap.c                     |   4 +
>  drivers/usb/host/xhci-dbgtty.c                     |   1 +
>  drivers/usb/host/xhci-mem.c                        |   4 +
>  drivers/usb/host/xhci-pci.c                        |  25 +++
>  drivers/usb/host/xhci-plat.c                       |   3 +-
>  drivers/usb/host/xhci-ring.c                       |   5 +-
>  drivers/usb/host/xhci.c                            |  31 +--
>  drivers/usb/host/xhci.h                            |   3 +-
>  drivers/usb/typec/altmodes/displayport.c           |   5 +-
>  fs/anon_inodes.c                                   |  23 +-
>  fs/btrfs/block-group.h                             |   2 +
>  fs/btrfs/free-space-tree.c                         |  40 ++++
>  fs/btrfs/inode.c                                   |  36 +--
>  fs/btrfs/ioctl.c                                   |   4 +-
>  fs/btrfs/tree-log.c                                | 137 ++++++------
>  fs/exec.c                                          |   9 +-
>  fs/libfs.c                                         |   8 +-
>  fs/namei.c                                         |   2 +-
>  fs/netfs/buffered_write.c                          |   2 +
>  fs/netfs/direct_write.c                            |   8 +-
>  fs/netfs/misc.c                                    |  26 ++-
>  fs/netfs/write_retry.c                             |   2 +-
>  fs/nfs/flexfilelayout/flexfilelayout.c             | 120 +++++++---
>  fs/nfs/inode.c                                     |  17 +-
>  fs/nfs/pnfs.c                                      |   4 +-
>  fs/smb/client/cifsglob.h                           |   2 +
>  fs/smb/client/cifsproto.h                          |   1 +
>  fs/smb/client/cifssmb.c                            |   2 +
>  fs/smb/client/connect.c                            |  15 +-
>  fs/smb/client/fs_context.c                         |  17 +-
>  fs/smb/client/misc.c                               |   6 +
>  fs/smb/client/readdir.c                            |   2 +-
>  fs/smb/client/reparse.c                            |  22 +-
>  fs/smb/client/smb2pdu.c                            |  11 +-
>  fs/xfs/xfs_rtalloc.c                               |   2 +
>  include/linux/arm_ffa.h                            |   1 +
>  include/linux/cpu.h                                |   1 +
>  include/linux/export.h                             |  12 +-
>  include/linux/fs.h                                 |   2 +
>  include/linux/libata.h                             |   7 +-
>  include/linux/usb.h                                |   2 +
>  include/linux/usb/typec_dp.h                       |   1 +
>  include/trace/events/netfs.h                       |   1 +
>  kernel/irq/irq_sim.c                               |   2 +-
>  kernel/rcu/tree.c                                  |   4 +
>  lib/test_objagg.c                                  |   4 +-
>  mm/secretmem.c                                     |   9 +-
>  mm/vmalloc.c                                       |  63 +++---
>  net/bluetooth/hci_event.c                          |  36 ---
>  net/bluetooth/hci_sync.c                           | 227 +++++++++++----=
----
>  net/bluetooth/mgmt.c                               |  25 ++-
>  net/ipv4/ip_input.c                                |   7 +-
>  net/mac80211/rx.c                                  |   4 +
>  net/rose/rose_route.c                              |  15 +-
>  net/sched/sch_api.c                                |  19 +-
>  net/vmw_vsock/vmci_transport.c                     |   4 +-
>  sound/isa/sb/sb16_main.c                           |   7 +
>  sound/soc/amd/yc/acp6x-mach.c                      |  14 ++
>  tools/testing/selftests/iommu/iommufd.c            |  32 ++-
>  tools/testing/selftests/iommu/iommufd_utils.h      |   9 +-
>  212 files changed, 2312 insertions(+), 986 deletions(-)
>
>
>

