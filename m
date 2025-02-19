Return-Path: <stable+bounces-117514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A2CA3B6CB
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788A5189FD5E
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931F11DE8B0;
	Wed, 19 Feb 2025 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vn17b6Ac"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8ED1DE3AE;
	Wed, 19 Feb 2025 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955529; cv=none; b=fSikpWQzVgfMdlGYEIRNlo2JFSSVFW1efD/my5/X+9ULpiPUHmV5zyZQhLcEJ6CppS4ns57Rweomt4RcTv/XSJ59YxECkRnBuJuuu93DQWXAmyig0f1LWO6sizL8LvDGPiFoXz+mPxHG1FVtnm+66lwmZNeT4GPdvZaLs5oX9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955529; c=relaxed/simple;
	bh=fjqNolJ9hKC0Ou87z21TlACfCJG4Qu/hIt7VcgVeN7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L60pXrJUYGjbT/fIXqvpJprVVkNR4zxbt0HsZWtGoEZmTg8A7DOnbKhkUi8V/EmOexPN4dK21nzgmZBiCp6ltqmGJPXTu9Ho12au+ccayR3kdZV9VMUtZOwT37e8zINEoB3R0PqwBbInZbxFdi0cLvk7w/ThKasivmDY+cYrinc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vn17b6Ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33640C4CED1;
	Wed, 19 Feb 2025 08:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955528;
	bh=fjqNolJ9hKC0Ou87z21TlACfCJG4Qu/hIt7VcgVeN7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=Vn17b6Ac7Zn1+BlBQRWI3VN/oOAoyZpcLpzozDQVqSo86a3Z4DkuteEnWkd+MfDAC
	 zBSfRJfy8RijWlxBExv9HvnEkqKAci1pOQ6umVorbn+MrPKqJ9Ki/8Tt9V6FxnvmWe
	 s/MPFrfglpDchN+4O1+vT5m1aAbA3khTjrsVsQF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	hargar@microsoft.com,
	broonie@kernel.org
Subject: [PATCH 6.6 000/152] 6.6.79-rc1 review
Date: Wed, 19 Feb 2025 09:26:53 +0100
Message-ID: <20250219082550.014812078@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.79-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.79-rc1
X-KernelTest-Deadline: 2025-02-21T08:25+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.79 release.
There are 152 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.79-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.79-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "vfio/platform: check the bounds of read/write syscalls"

David Woodhouse <dwmw@amazon.co.uk>
    x86/i8253: Disable PIT timer 0 when not in use

Michal Luczaj <mhal@rbox.co>
    vsock: Orphan socket after transport release

Michal Luczaj <mhal@rbox.co>
    vsock: Keep the binding until socket destruction

Pavel Begunkov <asml.silence@gmail.com>
    io_uring/kbuf: reallocate buf lists on upgrade

Vicki Pfau <vi@endrift.com>
    HID: hid-steam: Don't use cancel_delayed_work_sync in IRQ context

Ivan Kokshaysky <ink@unseen.parts>
    alpha: replace hardcoded stack offsets with autogenerated ones

Zhaoyang Huang <zhaoyang.huang@unisoc.com>
    mm: gup: fix infinite loop within __get_longterm_locked

Marc Zyngier <maz@kernel.org>
    arm64: Filter out SVE hwcaps when FEAT_SVE isn't implemented

Yu Kuai <yukuai3@huawei.com>
    md/md-bitmap: move bitmap_{start, end}write to md upper layer

Yu Kuai <yukuai3@huawei.com>
    md/raid5: implement pers->bitmap_sector()

Yu Kuai <yukuai3@huawei.com>
    md: add a new callback pers->bitmap_sector()

Yu Kuai <yukuai3@huawei.com>
    md/md-bitmap: remove the last parameter for bimtap_ops->endwrite()

Yu Kuai <yukuai3@huawei.com>
    md/md-bitmap: factor behind write counters out from bitmap_{start/end}write()

Benjamin Marzinski <bmarzins@redhat.com>
    md/raid5: recheck if reshape has finished with device_lock held

Hangbin Liu <liuhangbin@gmail.com>
    selftests: rtnetlink: update netdevsim ipsec output format

Hangbin Liu <liuhangbin@gmail.com>
    netdevsim: print human readable IP address

Alex Hung <alex.hung@amd.com>
    drm/amd/display: Pass non-null to dcn20_validate_apply_pipe_split_flags

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Add null check for head_pipe in dcn201_acquire_free_pipe_for_layer

Andrew Cooper <andrew.cooper3@citrix.com>
    x86/static-call: Remove early_boot_irqs_disabled check to fix Xen PVH dom0

Christian Gmeiner <cgmeiner@igalia.com>
    drm/v3d: Stop active perfmon if it is being destroyed

Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
    drm/rcar-du: dsi: Fix PHY lock bit check

Devarsh Thakkar <devarsht@ti.com>
    drm/tidss: Clear the interrupt status for interrupts being disabled

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/tidss: Fix issue in irq handling causing irq-flood issue

Eric Dumazet <edumazet@google.com>
    ipv6: mcast: add RCU protection to mld_newpack()

Eric Dumazet <edumazet@google.com>
    ipv6: mcast: extend RCU protection in igmp6_send()

Eric Dumazet <edumazet@google.com>
    ndisc: extend RCU protection in ndisc_send_skb()

Eric Dumazet <edumazet@google.com>
    openvswitch: use RCU protection in ovs_vport_cmd_fill_info()

Eric Dumazet <edumazet@google.com>
    arp: use RCU protection in arp_xmit()

Eric Dumazet <edumazet@google.com>
    neighbour: use RCU protection in __neigh_notify()

Li Zetao <lizetao1@huawei.com>
    neighbour: delete redundant judgment statements

Eric Dumazet <edumazet@google.com>
    ndisc: use RCU protection in ndisc_alloc_skb()

Vicki Pfau <vi@endrift.com>
    HID: hid-steam: Move hidraw input (un)registering to work

Vicki Pfau <vi@endrift.com>
    HID: hid-steam: Make sure rumble work is canceled on removal

Max Maisel <mmm-1@posteo.net>
    HID: hid-steam: Add Deck IMU support

Dan Carpenter <dan.carpenter@linaro.org>
    HID: hid-steam: Fix cleanup in probe()

Dan Carpenter <dan.carpenter@linaro.org>
    HID: hid-steam: remove pointless error message

Vicki Pfau <vi@endrift.com>
    HID: hid-steam: Add gamepad-only mode switched to by holding options

Vicki Pfau <vi@endrift.com>
    HID: hid-steam: Update list of identifiers from SDL

Vicki Pfau <vi@endrift.com>
    HID: hid-steam: Clean up locking

Vicki Pfau <vi@endrift.com>
    HID: hid-steam: Disable watchdog instead of using a heartbeat

Vicki Pfau <vi@endrift.com>
    HID: hid-steam: Avoid overwriting smoothing parameter

Eric Dumazet <edumazet@google.com>
    ipv6: icmp: convert to dev_net_rcu()

Eric Dumazet <edumazet@google.com>
    ipv6: use RCU protection in ip6_default_advmss()

Eric Dumazet <edumazet@google.com>
    flow_dissector: use RCU protection to fetch dev_net()

Eric Dumazet <edumazet@google.com>
    ipv4: icmp: convert to dev_net_rcu()

Eric Dumazet <edumazet@google.com>
    ipv4: use RCU protection in __ip_rt_update_pmtu()

Vladimir Vdovin <deliran@verdict.gg>
    net: ipv4: Cache pmtu for all packet paths if multipath enabled

Eric Dumazet <edumazet@google.com>
    ipv4: use RCU protection in inet_select_addr()

Eric Dumazet <edumazet@google.com>
    ipv4: use RCU protection in rt_is_expired()

Eric Dumazet <edumazet@google.com>
    ipv4: use RCU protection in ipv4_default_advmss()

Eric Dumazet <edumazet@google.com>
    net: add dev_net_rcu() helper

Jiri Pirko <jiri@resnulli.us>
    net: treat possible_net_t net pointer as an RCU one and add read_pnet_rcu()

Eric Dumazet <edumazet@google.com>
    ipv4: add RCU protection to ip4_dst_hoplimit()

Waiman Long <longman@redhat.com>
    clocksource: Use migrate_disable() to avoid calling get_random_u32() in atomic context

Waiman Long <longman@redhat.com>
    clocksource: Use pr_info() for "Checking clocksource synchronization" message

Filipe Manana <fdmanana@suse.com>
    btrfs: fix hole expansion when writing at an offset beyond EOF

Wentao Liang <vulab@iscas.ac.cn>
    mlxsw: Add return value check for mlxsw_sp_port_get_stats_raw()

Song Yoong Siang <yoong.siang.song@intel.com>
    igc: Set buffer type for empty frames in igc_init_empty_frame

Andy-ld Lu <andy-ld.lu@mediatek.com>
    mmc: mtk-sd: Fix register settings for hs400(es) mode

Nathan Chancellor <nathan@kernel.org>
    arm64: Handle .ARM.attributes section in linker scripts

Jiasheng Jiang <jiashengjiangcool@gmail.com>
    regmap-irq: Add missing kfree()

Varadarajan Narayanan <quic_varada@quicinc.com>
    regulator: qcom_smd: Add l2, l5 sub-node to mp5496 regulator

Jann Horn <jannh@google.com>
    partitions: mac: fix handling of bogus partition table

Wentao Liang <vulab@iscas.ac.cn>
    gpio: stmpe: Check return value of stmpe_reg_read in stmpe_gpio_irq_sync_unlock

Mario Limonciello <mario.limonciello@amd.com>
    gpiolib: acpi: Add a quirk for Acer Nitro ANV14

Ivan Kokshaysky <ink@unseen.parts>
    alpha: align stack for page fault and user unaligned trap handlers

John Keeping <jkeeping@inmusicbrands.com>
    serial: 8250: Fix fifo underflow on flush

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: port: Always update ->iotype in __uart_read_properties()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: port: Assign ->iotype correctly when ->iobase is set

Shakeel Butt <shakeel.butt@linux.dev>
    cgroup: fix race between fork and cgroup.kill

Ard Biesheuvel <ardb@kernel.org>
    efi: Avoid cold plugged memory for placing the kernel

Thomas Weißschuh <thomas.weissschuh@linutronix.de>
    kbuild: userprogs: fix bitsize and target detection on clang

Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
    wifi: ath12k: fix handling of 6 GHz rules

Ivan Kokshaysky <ink@unseen.parts>
    alpha: make stack 16-byte aligned (most cases)

Vincent Mailhol <mailhol.vincent@wanadoo.fr>
    can: etas_es58x: fix potential NULL pointer dereference on udev->serial

Alexander Hölzl <alexander.hoelzl@gmx.net>
    can: j1939: j1939_sk_send_loop(): fix unable to send messages with data length zero

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    can: c_can: fix unbalanced runtime PM disable in error path

Fedor Pchelkin <pchelkin@ispras.ru>
    can: ctucanfd: handle skb allocation failure

Johan Hovold <johan@kernel.org>
    USB: serial: option: drop MeiG Smart defines

Fabio Porcedda <fabio.porcedda@gmail.com>
    USB: serial: option: fix Telit Cinterion FN990A name

Fabio Porcedda <fabio.porcedda@gmail.com>
    USB: serial: option: add Telit Cinterion FN990B compositions

Chester A. Unal <chester.a.unal@arinc9.com>
    USB: serial: option: add MeiG Smart SLM828

Jann Horn <jannh@google.com>
    usb: cdc-acm: Fix handling of oversized fragments

Jann Horn <jannh@google.com>
    usb: cdc-acm: Check control transfer buffer size before access

Marek Vasut <marek.vasut+renesas@mailbox.org>
    USB: cdc-acm: Fill in Renesas R-Car D3 USB Download mode quirk

Alan Stern <stern@rowland.harvard.edu>
    USB: hub: Ignore non-compliant devices with too many configs or interfaces

John Keeping <jkeeping@inmusicbrands.com>
    usb: gadget: f_midi: fix MIDI Streaming descriptor lengths

Mathias Nyman <mathias.nyman@linux.intel.com>
    USB: Add USB_QUIRK_NO_LPM quirk for sony xperia xz1 smartphone

Lei Huang <huanglei@kylinos.cn>
    USB: quirks: add USB_QUIRK_NO_LPM quirk for Teclast dist

Stefan Eichenberger <stefan.eichenberger@toradex.com>
    usb: core: fix pipe creation for get_bMaxPacketSize0

Huacai Chen <chenhuacai@kernel.org>
    USB: pci-quirks: Fix HCCPARAMS register error for LS7A EHCI

Fabrice Gasnier <fabrice.gasnier@foss.st.com>
    usb: dwc2: gadget: remove of_node reference upon udc_stop

Guo Ren <guoren@kernel.org>
    usb: gadget: udc: renesas_usb3: Fix compiler warning

Elson Roy Serrao <quic_eserrao@quicinc.com>
    usb: roles: set switch registered flag early on

Selvarasu Ganesan <selvarasu.g@samsung.com>
    usb: dwc3: Fix timeout issue during controller enter/exit from halt state

Selvarasu Ganesan <selvarasu.g@samsung.com>
    usb: gadget: f_midi: Fixing wMaxPacketSize exceeded issue during MIDI bind retries

Sean Christopherson <seanjc@google.com>
    perf/x86/intel: Ensure LBRs are disabled when a CPU is starting

Sean Christopherson <seanjc@google.com>
    KVM: nSVM: Enter guest mode before initializing nested NPT MMU

Sean Christopherson <seanjc@google.com>
    KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if local APIC isn't in-kernel

Jiang Liu <gerry@linux.alibaba.com>
    drm/amdgpu: avoid buffer overflow attach in smu_sys_set_pp_table()

Sven Eckelmann <sven@narfation.org>
    batman-adv: Drop unmanaged ELP metric worker

Sven Eckelmann <sven@narfation.org>
    batman-adv: Ignore neighbor throughput metrics in error case

Andy Strohman <andrew@andrewstrohman.com>
    batman-adv: fix panic during interface removal

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet 5V

Mike Marshall <hubcap@omnibond.com>
    orangefs: fix a oob in orangefs_debug_write

Rik van Riel <riel@fb.com>
    x86/mm/tlb: Only trim the mm_cpumask once a second

Hans de Goede <hdegoede@redhat.com>
    ACPI: x86: Add skip i2c clients quirk for Vexia EDU ATLA 10 tablet 5V

Koichiro Den <koichiro.den@canonical.com>
    selftests: gpio: gpio-sim: Fix missing chip disablements

Maksym Planeta <maksym@exostellar.io>
    Grab mm lock before grabbing pt lock

Zichen Xie <zichenxie0106@gmail.com>
    NFS: Fix potential buffer overflowin nfs_sysfs_link_rpc_client()

Ramesh Thomas <ramesh.thomas@intel.com>
    vfio/pci: Enable iowrite64 and ioread64 for vfio pci

Tomas Glozar <tglozar@redhat.com>
    rtla/timerlat_top: Abort event processing on second signal

Tomas Glozar <tglozar@redhat.com>
    rtla/timerlat_hist: Abort event processing on second signal

Guixin Liu <kanie@linux.alibaba.com>
    scsi: ufs: bsg: Set bsg_queue to NULL after removal

Rakesh Babu Saladi <Saladi.Rakeshbabu@microchip.com>
    PCI: switchtec: Add Microchip PCI100X device IDs

Takashi Iwai <tiwai@suse.de>
    PCI/DPC: Quirk PIO log size for Intel Raptor Lake-P

Edward Adam Davis <eadavis@qq.com>
    media: vidtv: Fix a null-ptr-deref in vidtv_mux_stop_thread

Isaac Scott <isaac.scott@ideasonboard.com>
    media: uvcvideo: Add Kurokesu C1 PRO camera

Isaac Scott <isaac.scott@ideasonboard.com>
    media: uvcvideo: Add new quirk definition for the Sonix Technology Co. 292a camera

Isaac Scott <isaac.scott@ideasonboard.com>
    media: uvcvideo: Implement dual stream quirk to fix loss of usb packets

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    media: i2c: ds90ub953: Add error handling for i2c reads/writes

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    media: i2c: ds90ub913: Add error handling to ub913_hw_init()

Arnd Bergmann <arnd@arndb.de>
    media: cxd2841er: fix 64-bit division on gcc-9

Kartik Rajput <kkartik@nvidia.com>
    soc/tegra: fuse: Update Tegra234 nvmem keepout list

Aaro Koskinen <aaro.koskinen@iki.fi>
    fbdev: omap: use threaded IRQ for LCD DMA

Michael Margolin <mrgolin@amazon.com>
    RDMA/efa: Reset device on probe failure

Masahiro Yamada <masahiroy@kernel.org>
    tools: fix annoying "mkdir -p ..." logs when building tools in parallel

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpiolib: Fix crash on error in gpiochip_get_ngpios()

Jens Axboe <axboe@kernel.dk>
    block: cleanup and fix batch completion adding conditions

Juergen Gross <jgross@suse.com>
    x86/xen: allow larger contiguous memory regions in PV guests

Juergen Gross <jgross@suse.com>
    xen/swiotlb: relax alignment requirements

Jiang Liu <gerry@linux.alibaba.com>
    drm/amdgpu: bail out when failed to load fw in psp_init_cap_microcode()

Artur Weber <aweber.kernel@gmail.com>
    gpio: bcm-kona: Add missing newline to dev_err format string

Artur Weber <aweber.kernel@gmail.com>
    gpio: bcm-kona: Make sure GPIO bits are unlocked when requesting IRQ

Artur Weber <aweber.kernel@gmail.com>
    gpio: bcm-kona: Fix GPIO lock/unlock for banks above bank 0

Krzysztof Karas <krzysztof.karas@intel.com>
    drm/i915/selftests: avoid using uninitialized context

Muhammad Adeel <Muhammad.Adeel@ibm.com>
    cgroup: Remove steal time from usage_usec

Radu Rendec <rrendec@redhat.com>
    arm64: cacheinfo: Avoid out-of-bounds write to cacheinfo array

Eric Dumazet <edumazet@google.com>
    team: better TEAM_OPTION_TYPE_STRING validation

Yuli Wang <wangyuli@uniontech.com>
    LoongArch: csum: Fix OoB access in IP checksum code for negative lengths

Marco Crivellari <marco.crivellari@suse.com>
    LoongArch: Fix idle VS timer enqueue

Eric Dumazet <edumazet@google.com>
    vxlan: check vxlan_vnigroup_init() return value

Eric Dumazet <edumazet@google.com>
    vrf: use RCU protection in l3mdev_l3_out()

Eric Dumazet <edumazet@google.com>
    ndisc: ndisc_send_redirect() must use dev_get_by_index_rcu()

Murad Masimov <m.masimov@mt-integration.ru>
    ax25: Fix refcount leak caused by setting SO_BINDTODEVICE sockopt

Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
    spi: sn-f-ospi: Fix division by zero

Tulio Fernandes <tuliomf09@gmail.com>
    HID: hid-thrustmaster: fix stack-out-of-bounds read in usb_check_int_endpoints()

Charles Han <hanchunchao@inspur.com>
    HID: multitouch: Add NULL check in mt_input_configured

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: cy8c95x0: Respect IRQ trigger settings from firmware

Dai Ngo <dai.ngo@oracle.com>
    NFSD: fix hang in nfsd4_shutdown_callback

Li Lingfeng <lilingfeng3@huawei.com>
    nfsd: clear acl_access/acl_default after releasing them


-------------

Diffstat:

 Documentation/arch/arm64/elf_hwcaps.rst            |  36 +-
 .../bindings/regulator/qcom,smd-rpm-regulator.yaml |   2 +-
 Makefile                                           |  17 +-
 arch/alpha/include/uapi/asm/ptrace.h               |   2 +
 arch/alpha/kernel/asm-offsets.c                    |   2 +
 arch/alpha/kernel/entry.S                          |  24 +-
 arch/alpha/kernel/traps.c                          |   2 +-
 arch/alpha/mm/fault.c                              |   4 +-
 arch/arm64/kernel/cacheinfo.c                      |  12 +-
 arch/arm64/kernel/cpufeature.c                     |  38 +-
 arch/arm64/kernel/vdso/vdso.lds.S                  |   1 +
 arch/arm64/kernel/vmlinux.lds.S                    |   1 +
 arch/loongarch/kernel/genex.S                      |  28 +-
 arch/loongarch/kernel/idle.c                       |   3 +-
 arch/loongarch/kernel/reset.c                      |   6 +-
 arch/loongarch/lib/csum.c                          |   2 +-
 arch/x86/events/intel/core.c                       |   5 +-
 arch/x86/include/asm/mmu.h                         |   2 +
 arch/x86/include/asm/mmu_context.h                 |   1 +
 arch/x86/include/asm/msr-index.h                   |   3 +-
 arch/x86/include/asm/tlbflush.h                    |   1 +
 arch/x86/kernel/i8253.c                            |  11 +-
 arch/x86/kernel/static_call.c                      |   1 -
 arch/x86/kvm/hyperv.c                              |   6 +-
 arch/x86/kvm/mmu/mmu.c                             |   2 +-
 arch/x86/kvm/svm/nested.c                          |  10 +-
 arch/x86/mm/tlb.c                                  |  35 +-
 arch/x86/xen/mmu_pv.c                              |  75 ++-
 block/partitions/mac.c                             |  18 +-
 drivers/acpi/x86/utils.c                           |  13 +
 drivers/base/regmap/regmap-irq.c                   |   2 +
 drivers/clocksource/i8253.c                        |  13 +-
 drivers/firmware/efi/efi.c                         |   6 +-
 drivers/firmware/efi/libstub/randomalloc.c         |   3 +
 drivers/firmware/efi/libstub/relocate.c            |   3 +
 drivers/gpio/gpio-bcm-kona.c                       |  71 +-
 drivers/gpio/gpio-stmpe.c                          |  15 +-
 drivers/gpio/gpiolib-acpi.c                        |  14 +
 drivers/gpio/gpiolib.c                             |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   5 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |   3 +-
 .../drm/amd/display/dc/dcn201/dcn201_resource.c    |   4 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   3 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |   4 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c    |   2 +-
 .../gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h   |   1 -
 drivers/gpu/drm/tidss/tidss_dispc.c                |  22 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c                  |   5 +
 drivers/hid/hid-multitouch.c                       |   5 +-
 drivers/hid/hid-steam.c                            | 738 ++++++++++++++++-----
 drivers/hid/hid-thrustmaster.c                     |   2 +-
 drivers/infiniband/hw/efa/efa_main.c               |   9 +-
 drivers/md/md-bitmap.c                             |  75 ++-
 drivers/md/md-bitmap.h                             |   6 +-
 drivers/md/md.c                                    |  26 +
 drivers/md/md.h                                    |   5 +
 drivers/md/raid1.c                                 |  35 +-
 drivers/md/raid1.h                                 |   1 -
 drivers/md/raid10.c                                |  26 +-
 drivers/md/raid10.h                                |   1 -
 drivers/md/raid5-cache.c                           |   4 -
 drivers/md/raid5.c                                 | 174 ++---
 drivers/md/raid5.h                                 |   4 -
 drivers/media/dvb-frontends/cxd2841er.c            |   8 +-
 drivers/media/i2c/ds90ub913.c                      |  25 +-
 drivers/media/i2c/ds90ub953.c                      |  46 +-
 drivers/media/test-drivers/vidtv/vidtv_bridge.c    |   8 +-
 drivers/media/usb/uvc/uvc_driver.c                 |  18 +
 drivers/media/usb/uvc/uvc_video.c                  |  27 +-
 drivers/media/usb/uvc/uvcvideo.h                   |   1 +
 drivers/mmc/host/mtk-sd.c                          |  31 +-
 drivers/net/can/c_can/c_can_platform.c             |   5 +-
 drivers/net/can/ctucanfd/ctucanfd_base.c           |  10 +-
 drivers/net/can/usb/etas_es58x/es58x_devlink.c     |   6 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   1 +
 .../net/ethernet/mellanox/mlxsw/spectrum_ethtool.c |   4 +-
 drivers/net/netdevsim/ipsec.c                      |  12 +-
 drivers/net/team/team.c                            |   4 +-
 drivers/net/vxlan/vxlan_core.c                     |   7 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  61 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   1 -
 drivers/pci/quirks.c                               |  12 +
 drivers/pci/switch/switchtec.c                     |  26 +
 drivers/pinctrl/pinctrl-cy8c95x0.c                 |   2 +-
 drivers/soc/tegra/fuse/fuse-tegra30.c              |  17 +-
 drivers/spi/spi-sn-f-ospi.c                        |   3 +
 drivers/tty/serial/8250/8250.h                     |   2 +
 drivers/tty/serial/8250/8250_dma.c                 |  16 +
 drivers/tty/serial/8250/8250_port.c                |   9 +
 drivers/tty/serial/serial_port.c                   |   5 +-
 drivers/ufs/core/ufs_bsg.c                         |   1 +
 drivers/usb/class/cdc-acm.c                        |  28 +-
 drivers/usb/core/hub.c                             |  14 +-
 drivers/usb/core/quirks.c                          |   6 +
 drivers/usb/dwc2/gadget.c                          |   1 +
 drivers/usb/dwc3/gadget.c                          |  34 +
 drivers/usb/gadget/function/f_midi.c               |  17 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |   2 +-
 drivers/usb/host/pci-quirks.c                      |   9 +
 drivers/usb/roles/class.c                          |   5 +-
 drivers/usb/serial/option.c                        |  49 +-
 drivers/vfio/pci/vfio_pci_rdwr.c                   |   1 +
 drivers/vfio/platform/vfio_platform_common.c       |  10 -
 drivers/video/fbdev/omap/lcd_dma.c                 |   4 +-
 drivers/xen/swiotlb-xen.c                          |  20 +-
 fs/btrfs/file.c                                    |   4 +-
 fs/nfs/sysfs.c                                     |   6 +-
 fs/nfsd/nfs2acl.c                                  |   2 +
 fs/nfsd/nfs3acl.c                                  |   2 +
 fs/nfsd/nfs4callback.c                             |   7 +-
 fs/orangefs/orangefs-debugfs.c                     |   4 +-
 include/linux/blk-mq.h                             |  18 +-
 include/linux/cgroup-defs.h                        |   6 +-
 include/linux/efi.h                                |   1 +
 include/linux/i8253.h                              |   1 +
 include/linux/netdevice.h                          |   6 +
 include/linux/sched/task.h                         |   1 +
 include/net/l3mdev.h                               |   2 +
 include/net/net_namespace.h                        |  15 +-
 include/net/route.h                                |   9 +-
 io_uring/kbuf.c                                    |  15 +-
 kernel/cgroup/cgroup.c                             |  20 +-
 kernel/cgroup/rstat.c                              |   1 -
 kernel/time/clocksource.c                          |   9 +-
 mm/gup.c                                           |  14 +-
 net/ax25/af_ax25.c                                 |  11 +
 net/batman-adv/bat_v.c                             |   2 -
 net/batman-adv/bat_v_elp.c                         | 122 +++-
 net/batman-adv/bat_v_elp.h                         |   2 -
 net/batman-adv/types.h                             |   3 -
 net/can/j1939/socket.c                             |   4 +-
 net/can/j1939/transport.c                          |   5 +-
 net/core/flow_dissector.c                          |  21 +-
 net/core/neighbour.c                               |  11 +-
 net/ipv4/arp.c                                     |   4 +-
 net/ipv4/devinet.c                                 |   3 +-
 net/ipv4/icmp.c                                    |  31 +-
 net/ipv4/route.c                                   |  39 +-
 net/ipv6/icmp.c                                    |  42 +-
 net/ipv6/mcast.c                                   |  45 +-
 net/ipv6/ndisc.c                                   |  28 +-
 net/ipv6/route.c                                   |   7 +-
 net/openvswitch/datapath.c                         |  12 +-
 net/vmw_vsock/af_vsock.c                           |  12 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |  17 +-
 tools/testing/selftests/gpio/gpio-sim.sh           |  31 +-
 tools/testing/selftests/net/pmtu.sh                | 112 +++-
 tools/testing/selftests/net/rtnetlink.sh           |   4 +-
 tools/tracing/rtla/src/timerlat_hist.c             |   8 +
 tools/tracing/rtla/src/timerlat_top.c              |   8 +
 151 files changed, 2108 insertions(+), 846 deletions(-)



