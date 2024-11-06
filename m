Return-Path: <stable+bounces-90122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 940899BE6CE
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CB81F2800B
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B7F1DF273;
	Wed,  6 Nov 2024 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LEK1B1RN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F3A1DF252;
	Wed,  6 Nov 2024 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894837; cv=none; b=QFlLuENuMw7ysetQuF94bDJzsPifVg6EFL+E8ELnCakki+8wKOgTkumTas1cbWcg6y+f5Z7ZYF3WizlofcAcyemXkwbIFTGnSDdvChW0JmpCUpWCWeJ+BHkgkCSuqIauIbUym0nGXf2TaSkDOs/kUkCbQ1+nykhGPH8ZlIqiffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894837; c=relaxed/simple;
	bh=y/jHSxM0uIQ1BmV3gb74lkAIhGt0ls3P5TKPZrj/1fY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=owZSo1ydf8U4p58F7DHsVfBA0+4bBlHE9wVbv+hnv5B8zCUq6RxkWZdhML6AN+Dh80pXsJYfPVOISiEw/FMYC0hWpqiq67pI4b+TKfZJkwIz/XzsCxHoVZvkdBtNIGRZl9zkcnwZf+FQiF8YdmBlMIZoQoMXqV93jO44oYVVuYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LEK1B1RN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315FFC4CED3;
	Wed,  6 Nov 2024 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730894836;
	bh=y/jHSxM0uIQ1BmV3gb74lkAIhGt0ls3P5TKPZrj/1fY=;
	h=From:To:Cc:Subject:Date:From;
	b=LEK1B1RNKzv6a64iicS7lFtwngREb2Rjvbv9OCbMbSRAyBN8l4VC9kW0AwWGIuBHD
	 u2RcMG+pJQKL30CqM1w61tc/yk61uRcl54WrasMTwe+KvifpAM2PrxCNsi7mdWPOD3
	 bHH0AzeW9mEdK5sGcFbRod9J5oM18TRTPxVVTTfA=
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
	hagar@microsoft.com,
	broonie@kernel.org
Subject: [PATCH 4.19 000/350] 4.19.323-rc1 review
Date: Wed,  6 Nov 2024 12:58:48 +0100
Message-ID: <20241106120320.865793091@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.323-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.323-rc1
X-KernelTest-Deadline: 2024-11-08T12:03+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 4.19.323 release.
There are 350 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.323-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.323-rc1

Jeongjun Park <aha310510@gmail.com>
    vt: prevent kernel-infoleak in con_font_get()

Jeongjun Park <aha310510@gmail.com>
    mm: shmem: fix data-race in shmem_getattr()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix kernel bug due to missing clearing of checked flag

Edward Adam Davis <eadavis@qq.com>
    ocfs2: pass u64 to ocfs2_truncate_inline maybe overflow

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix potential deadlock with newly created symlinks

Ville Syrjälä <ville.syrjala@linux.intel.com>
    wifi: iwlegacy: Clear stale interrupts before resuming device

Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
    wifi: ath10k: Fix memory leak in management tx

Felix Fietkau <nbd@nbd.name>
    wifi: mac80211: do not pass a stopped vif to the driver in .get_txpower

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "driver core: Fix uevent_show() vs driver detach race"

Faisal Hassan <quic_faisalh@quicinc.com>
    xhci: Fix Link TRB DMA in command ring stopped completion event

Zijun Hu <quic_zijuhu@quicinc.com>
    usb: phy: Fix API devm_usb_put_phy() can not release the phy

Zongmin Zhou <zhouzongmin@kylinos.cn>
    usbip: tools: Fix detach_port() invalid port error path

Dimitri Sivanich <sivanich@hpe.com>
    misc: sgi-gru: Don't disable preemption in GRU driver

Daniel Palmer <daniel@0x0f.com>
    net: amd: mvme147: Fix probe banner message

Xiongfeng Wang <wangxiongfeng2@huawei.com>
    firmware: arm_sdei: Fix the input parameter of cpuhp_remove_state()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_payload: sanitize offset and length before calling skb_checksum()

Benoît Monin <benoit.monin@gmx.fr>
    net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension

Xin Long <lucien.xin@gmail.com>
    net: support ip generic csum processing in skb_csum_hwoffload_help

Byeonguk Jeong <jungbu2855@gmail.com>
    bpf: Fix out-of-bounds write in trie_get_next_key()

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT

Pablo Neira Ayuso <pablo@netfilter.org>
    gtp: allow -1 to be specified as file description from userspace

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    gtp: simplify error handling code in 'gtp_encap_enable()'

Wander Lairson Costa <wander@redhat.com>
    igb: Disable threaded IRQ for igb_msix_other

Felix Fietkau <nbd@nbd.name>
    wifi: mac80211: skip non-uploaded keys in ieee80211_iter_keys

Xiu Jianfeng <xiujianfeng@huawei.com>
    cgroup: Fix potential overflow issue when checking max_depth

Selvarasu Ganesan <selvarasu.g@samsung.com>
    usb: dwc3: core: Stop processing of pending events if controller is halted

Yu Chen <chenyu56@huawei.com>
    usb: dwc3: Add splitdisable quirk for Hisilicon Kirin Soc

Marek Szyprowski <m.szyprowski@samsung.com>
    usb: dwc3: remove generic PHY calibrate() calls

Sabrina Dubroca <sd@queasysnail.net>
    xfrm: validate new SA's prefixlen using SA family when sel.family is unset

junhua huang <huang.junhua@zte.com.cn>
    arm64/uprobes: change the uprobe_opcode_t typedef to fix the sparse warning

Paul Moore <paul@paul-moore.com>
    selinux: improve error checking in sel_write_load()

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix kernel bug due to missing clearing of buffer delay flag

Shubham Panwar <shubiisp8@gmail.com>
    ACPI: button: Add DMI quirk for Samsung Galaxy Book2 to fix initial lid detection issue

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Guard against bad data for ATIF ACPI method

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek: Update default depop procedure

Jinjie Ruan <ruanjinjie@huawei.com>
    posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime()

Oliver Neukum <oneukum@suse.com>
    net: usb: usbnet: fix name regression

Biju Das <biju.das@bp.renesas.com>
    dt-bindings: power: Add r8a774b1 SYSC power domain definitions

Wang Hai <wanghai38@huawei.com>
    be2net: fix potential memory leak in be_xmit()

Wang Hai <wanghai38@huawei.com>
    net/sun3_82586: fix potential memory leak in sun3_82586_send_packet()

Dave Kleikamp <dave.kleikamp@oracle.com>
    jfs: Fix sanity check in dbMount

Gianfranco Trad <gianf.trad@gmail.com>
    udf: fix uninit-value use in udf_get_fileshortad

Nico Boehr <nrb@linux.ibm.com>
    KVM: s390: gaccess: Check if guest address is in memslot

Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    KVM: s390: gaccess: Cleanup access to guest pages

Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    KVM: s390: gaccess: Refactor access address range check

Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    KVM: s390: gaccess: Refactor gpa and length calculation

Mark Rutland <mark.rutland@arm.com>
    arm64: probes: Fix uprobes for big-endian kernels

junhua huang <huang.junhua@zte.com.cn>
    arm64:uprobe fix the uprobe SWBP_INSN in big-endian

Ye Bin <yebin10@huawei.com>
    Bluetooth: bnep: fix wild-memory-access in proto_unregister

Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
    usb: typec: altmode should keep reference to parent

Wang Hai <wanghai38@huawei.com>
    net: systemport: fix potential memory leak in bcm_sysport_xmit()

Wang Hai <wanghai38@huawei.com>
    net: ethernet: aeroflex: fix potential memory leak in greth_start_xmit_gbit()

Sabrina Dubroca <sd@queasysnail.net>
    macsec: don't increment counters for an unrelated SA

Jonathan Marek <jonathan@marek.ca>
    drm/msm/dsi: fix 32-bit signed integer extension in pclk_rate calculation

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Return more meaningful error

Anumula Murali Mohan Reddy <anumula@chelsio.com>
    RDMA/cxgb4: Fix RDMA_CM_EVENT_UNREACHABLE error for iWARP

Saravanan Vajravel <saravanan.vajravel@broadcom.com>
    RDMA/bnxt_re: Fix incorrect AVID type in WQE structure

Andrey Skvortsov <andrej.skvortzov@gmail.com>
    clk: Fix slab-out-of-bounds error in devm_clk_release()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    clk: Fix pointer casting to prevent oops in devm_clk_release()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: propagate directory read errors from nilfs_find_entry()

Zhang Rui <rui.zhang@intel.com>
    x86/apic: Always explicitly disarm TSC-deadline timer

Takashi Iwai <tiwai@suse.de>
    parport: Proper fix for array out-of-bounds access

Daniele Palmas <dnlplm@gmail.com>
    USB: serial: option: add Telit FN920C04 MBIM compositions

Benjamin B. Frost <benjamin@geanix.com>
    USB: serial: option: add support for Quectel EG916Q-GL

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix incorrect stream context type macro

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001

Aaron Thompson <dev@aaront.org>
    Bluetooth: Remove debugfs directory on module init failure

Emil Gedenryd <emil.gedenryd@axis.com>
    iio: light: opt3001: add missing full-scale range value

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    iio: hid-sensors: Fix an error handling path in _hid_sensor_set_report_latency()

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    iio: adc: ti-ads8688: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    iio: dac: stm32-dac-core: add missing select REGMAP_MMIO in Kconfig

Nikolay Kuratov <kniv@yandex-team.ru>
    drm/vmwgfx: Handle surface check failure correctly

Jim Mattson <jmattson@google.com>
    x86/cpufeatures: Define X86_FEATURE_AMD_IBPB_RET

Michael Mueller <mimu@linux.ibm.com>
    KVM: s390: Change virtual to physical address access in diag 0x258 handler

Thomas Weißschuh <thomas.weissschuh@linutronix.de>
    s390/sclp_vt220: Convert newlines to CRLF instead of LFCR

Joseph Huang <Joseph.Huang@garmin.com>
    net: dsa: mv88e6xxx: Fix out-of-bound access

Breno Leitao <leitao@debian.org>
    KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu_on_spin()

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
    fat: fix uninitialized variable

WangYuli <wangyuli@uniontech.com>
    PCI: Add function 0 DMA alias quirk for Glenfly Arise chip

Mark Rutland <mark.rutland@arm.com>
    arm64: probes: Fix simulate_ldr*_literal()

Mark Rutland <mark.rutland@arm.com>
    arm64: probes: Remove broken LDR (literal) uprobe support

Jinjie Ruan <ruanjinjie@huawei.com>
    posix-clock: Fix missing timespec64 check in pc_clock_settime()

Anastasia Kovaleva <a.kovaleva@yadro.com>
    net: Fix an unsafe loop on the list

Icenowy Zheng <uwu@icenowy.me>
    usb: storage: ignore bogus device raised by JieLi BR21 USB sound chip

Jose Alberto Reguero <jose.alberto.reguero@gmail.com>
    usb: xhci: Fix problem with xhci resume from suspend

Oliver Neukum <oneukum@suse.com>
    Revert "usb: yurex: Replace snprintf() with the safer scnprintf() variant"

Wade Wang <wade.wang@hp.com>
    HID: plantronics: Workaround for an unexcepted opposite volume key

Oliver Neukum <oneukum@suse.com>
    CDC-NCM: avoid overflow in sanity checking

j.nixdorf@avm.de <j.nixdorf@avm.de>
    net: ipv6: ensure we call ipv6_mc_down() at most once

Eric Dumazet <edumazet@google.com>
    ppp: fix ppp_async_encode() illegal access

Rosen Penev <rosenp@gmail.com>
    net: ibm: emac: mal: fix wrong goto

Mohamed Khalfella <mkhalfella@purestorage.com>
    igb: Do not bring the device up after non-fatal error

Billy Tsai <billy_tsai@aspeedtech.com>
    gpio: aspeed: Use devm_clk api to manage clock source

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    clk: Provide new devm_clk helpers for prepared and enabled clocks

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    clk: generalize devm_clk_get() a bit

Phil Edworthy <phil.edworthy@renesas.com>
    clk: Add (devm_)clk_get_optional() functions

Billy Tsai <billy_tsai@aspeedtech.com>
    gpio: aspeed: Add the flush write to ensure the write complete.

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change

Andy Roulin <aroulin@nvidia.com>
    netfilter: br_netfilter: fix panic with metadata_dst skb

Neal Cardwell <ncardwell@google.com>
    tcp: fix tcp_enter_recovery() to zero retrans_stamp when it's safe

Dan Carpenter <dan.carpenter@linaro.org>
    SUNRPC: Fix integer overflow in decode_rc_list()

Chuck Lever <chuck.lever@oracle.com>
    NFS: Remove print_overflow_msg()

Andrey Shumilin <shum.sdl@nppct.ru>
    fbdev: sisfb: Fix strbuf array overflow

Zijun Hu <quic_zijuhu@quicinc.com>
    driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute

Zhu Jun <zhujun2@cmss.chinamobile.com>
    tools/iio: Add memory allocation failure check for trigger_name

Xu Yang <xu.yang_2@nxp.com>
    usb: chipidea: udc: enable suspend interrupt after usb reset

Yunke Cao <yunkec@chromium.org>
    media: videobuf2-core: clear memory related fields in __vb2_plane_dmabuf_put()

Alex Williamson <alex.williamson@redhat.com>
    PCI: Mark Creative Labs EMU20k2 INTx masking as broken

Hans de Goede <hdegoede@redhat.com>
    i2c: i801: Use a different adapter-name for IDF adapters

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    clk: bcm: bcm53573: fix OF node leak in init

Daniel Jordan <daniel.m.jordan@oracle.com>
    ktest.pl: Avoid false positives with grub2 skip regex

Thomas Richter <tmricht@linux.ibm.com>
    s390/cpum_sf: Remove WARN_ON_ONCE statements

Wojciech Gładysz <wojciech.gladysz@infogain.com>
    ext4: nested locking for xattr inode

Gerald Schaefer <gerald.schaefer@linux.ibm.com>
    s390/mm: Add cond_resched() to cmm_alloc/free_pages()

Heiko Carstens <hca@linux.ibm.com>
    s390/facility: Disable compile time optimization for decompressor code

Tao Chen <chen.dylane@gmail.com>
    bpf: Check percpu map value size first

Mathias Krause <minipli@grsecurity.net>
    Input: synaptics-rmi4 - fix UAF of IRQ domain on driver removal

Michael S. Tsirkin <mst@redhat.com>
    virtio_console: fix misc probe bugs

Rob Clark <robdclark@chromium.org>
    drm/crtc: fix uninitialized variable use even harder

Sean Paul <seanpaul@chromium.org>
    drm: Move drm_mode_setcrtc() local re-init to failure path

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Remove precision vsnprintf() check from print event

Linus Walleij <linus.walleij@linaro.org>
    net: ethernet: cortina: Drop TSO support

zhanchengbin <zhanchengbin1@huawei.com>
    ext4: fix inode tree inconsistency caused by ENOMEM

Armin Wolf <W_Armin@gmx.de>
    ACPI: battery: Fix possible crash when unregistering a battery hook

Armin Wolf <W_Armin@gmx.de>
    ACPI: battery: Simplify battery hook locking

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    rtc: at91sam9: fix OF node leak in probe() error path

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: at91sam9: drop platform_data support

NeilBrown <neilb@suse.de>
    nfsd: fix delegation_blocked() to block correctly for at least 30 seconds

Arnd Bergmann <arnd@arndb.de>
    nfsd: use ktime_get_seconds() for timestamps

Oleg Nesterov <oleg@redhat.com>
    uprobes: fix kernel info leak via "[uprobes]" vma

Mark Rutland <mark.rutland@arm.com>
    arm64: errata: Expand speculative SSBS workaround once more

Mark Rutland <mark.rutland@arm.com>
    arm64: cputype: Add Neoverse-N3 definitions

Anshuman Khandual <anshuman.khandual@arm.com>
    arm64: Add Cortex-715 CPU part definition

Baokun Li <libaokun1@huawei.com>
    ext4: update orig_path in ext4_find_extent()

Baokun Li <libaokun1@huawei.com>
    ext4: fix slab-use-after-free in ext4_split_extent_at()

Theodore Ts'o <tytso@mit.edu>
    ext4: avoid ext4_error()'s caused by ENOMEM in the truncate path

Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
    gpio: davinci: fix lazy disable

Filipe Manana <fdmanana@suse.com>
    btrfs: wait for fixup workers before stopping cleaner kthread during umount

Nuno Sa <nuno.sa@analog.com>
    Input: adp5589-keys - fix adp5589_gpio_get_value()

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    tomoyo: fallback to realpath if symlink's pathname does not exist

Barnabás Czémán <barnabas.czeman@mainlining.org>
    iio: magnetometer: ak8975: Fix reading for ak099xx sensors

Zheng Wang <zyytlz.wz@163.com>
    media: venus: fix use after free bug in venus_remove due to race condition

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: uapi/linux/cec.h: cec_msg_set_reply_to: zero flags

Sebastian Reichel <sebastian.reichel@collabora.com>
    clk: rockchip: fix error for unknown clocks

Chun-Yi Lee <joeyli.kernel@gmail.com>
    aoe: fix the potential use-after-free problem in more places

Jisheng Zhang <jszhang@kernel.org>
    riscv: define ILLEGAL_POINTER_VALUE for 64bit

Lizhi Xu <lizhi.xu@windriver.com>
    ocfs2: fix possible null-ptr-deref in ocfs2_set_buffer_uptodate

Julian Sun <sunjunchao2870@gmail.com>
    ocfs2: fix null-ptr-deref when journal load failed.

Lizhi Xu <lizhi.xu@windriver.com>
    ocfs2: remove unreasonable unlock in ocfs2_read_blocks

Joseph Qi <joseph.qi@linux.alibaba.com>
    ocfs2: cancel dqi_sync_work before freeing oinfo

Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
    ocfs2: reserve space for inline xattr before attaching reflink tree

Joseph Qi <joseph.qi@linux.alibaba.com>
    ocfs2: fix uninit-value in ocfs2_get_block()

Heming Zhao <heming.zhao@suse.com>
    ocfs2: fix the la space leak when unmounting an ocfs2 volume

Baokun Li <libaokun1@huawei.com>
    jbd2: stop waiting for space when jbd2_cleanup_journal_tail() returns error

Andrew Jones <ajones@ventanamicro.com>
    of/irq: Support #msi-cells=<0> in of_msi_get_domain

Helge Deller <deller@kernel.org>
    parisc: Fix 64-bit userspace syscall path

Luis Henriques (SUSE) <luis.henriques@linux.dev>
    ext4: fix incorrect tid assumption in ext4_wait_for_tail_page_commit()

Baokun Li <libaokun1@huawei.com>
    ext4: fix double brelse() the buffer of the extents path

Baokun Li <libaokun1@huawei.com>
    ext4: aovid use-after-free in ext4_ext_insert_extent()

Luis Henriques (SUSE) <luis.henriques@linux.dev>
    ext4: fix incorrect tid assumption in __jbd2_log_wait_for_space()

Baokun Li <libaokun1@huawei.com>
    ext4: propagate errors from ext4_find_extent() in ext4_insert_range()

Edward Adam Davis <eadavis@qq.com>
    ext4: no need to continue when the number of entries is 1

Jaroslav Kysela <perex@perex.cz>
    ALSA: core: add isascii() check to card ID generator

Helge Deller <deller@gmx.de>
    parisc: Fix itlb miss handler for 64-bit programs

Luo Gengkun <luogengkun@huaweicloud.com>
    perf/core: Fix small negative period being ignored

Jinjie Ruan <ruanjinjie@huawei.com>
    spi: bcm63xx: Fix module autoloading

Robert Hancock <robert.hancock@calian.com>
    i2c: xiic: Wait for TX empty to avoid missed TX NAKs

Christophe Leroy <christophe.leroy@csgroup.eu>
    selftests: vDSO: fix vDSO symbols lookup for powerpc64

Yifei Liu <yifei.l.liu@oracle.com>
    selftests: breakpoints: use remaining time to check if suspend succeed

Ben Dooks <ben.dooks@codethink.co.uk>
    spi: s3c64xx: fix timeout counters in flush_fifo

Artem Sadovnikov <ancowi69@gmail.com>
    ext4: fix i_data_sem unlock order in ext4_ind_migrate()

Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
    ext4: ext4_search_dir should return a proper error

Geert Uytterhoeven <geert+renesas@glider.be>
    of/irq: Refer to actual buffer size in of_irq_parse_one()

Geert Uytterhoeven <geert+renesas@glider.be>
    drm/radeon/r100: Handle unknown family in r100_cp_init_microcode()

Kees Cook <kees@kernel.org>
    scsi: aacraid: Rearrange order of struct aac_srb_unit

Matthew Brost <matthew.brost@intel.com>
    drm/printer: Allow NULL data in devcoredump printer

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Fix index out of bounds in degamma hardware format translation

Alex Hung <alex.hung@amd.com>
    drm/amd/display: Check stream before comparing them

Zhao Mengmeng <zhaomengmeng@kylinos.cn>
    jfs: Fix uninit-value access of new_ea in ea_buffer

Edward Adam Davis <eadavis@qq.com>
    jfs: check if leafidx greater than num leaves per dmap tree

Edward Adam Davis <eadavis@qq.com>
    jfs: Fix uaf in dbFreeBits

Remington Brasga <rbrasga@uci.edu>
    jfs: UBSAN: shift-out-of-bounds in dbFindBits

Damien Le Moal <dlemoal@kernel.org>
    ata: sata_sil: Rename sil_blacklist to sil_quirks

Andrew Davis <afd@ti.com>
    power: reset: brcmstb: Do not go into infinite loop if reset fails

Kaixin Wang <kxwang23@m.fudan.edu.cn>
    fbdev: pxafb: Fix possible use after free in pxafb_task()

Takashi Iwai <tiwai@suse.de>
    ALSA: hdsp: Break infinite MIDI input flush loop

Takashi Iwai <tiwai@suse.de>
    ALSA: asihpi: Fix potential OOB array access

Thomas Gleixner <tglx@linutronix.de>
    signal: Replace BUG_ON()s

Gustavo A. R. Silva <gustavoars@kernel.org>
    wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_cmd_802_11_scan_ext()

Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
    ACPICA: iasl: handle empty connection_node

Jason Xing <kernelxing@tencent.com>
    tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process

Ido Schimmel <idosch@nvidia.com>
    ipv4: Mask upper DSCP bits and ECN bits in NETLINK_FIB_LOOKUP family

Kuniyuki Iwashima <kuniyu@amazon.com>
    ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).

Simon Horman <horms@kernel.org>
    net: mvpp2: Increase size of queue_name buffer

Simon Horman <horms@kernel.org>
    tipc: guard against string buffer overrun

Pei Xiao <xiaopei01@kylinos.cn>
    ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in acpi_db_convert_to_package()

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI: EC: Do not release locks during operation region accesses

Armin Wolf <W_Armin@gmx.de>
    ACPICA: Fix memory leak if acpi_ps_get_next_field() fails

Armin Wolf <W_Armin@gmx.de>
    ACPICA: Fix memory leak if acpi_ps_get_next_namepath() fails

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    net: hisilicon: hns_mdio: fix OF node leak in probe()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    net: hisilicon: hip04: fix OF node leak in probe()

Toke Høiland-Jørgensen <toke@redhat.com>
    wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit

Dmitry Kandybka <d.kandybka@gmail.com>
    wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()

Jann Horn <jannh@google.com>
    f2fs: Require FMODE_WRITE for atomic write ioctls

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/conexant: Fix conflicting quirk for System76 Pangolin

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/generic: Unconditionally prefer preferred_dacs pairs

Xin Long <lucien.xin@gmail.com>
    sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_start

Anton Danilov <littlesmilingcloud@gmail.com>
    ipv4: ip_gre: Fix drops of small packets in ipgre_xmit

Eric Dumazet <edumazet@google.com>
    net: add more sanity checks to qdisc_pkt_len_init()

Eric Dumazet <edumazet@google.com>
    net: avoid potential underflow in qdisc_pkt_len_init() with UFO

Aleksander Jan Bajkowski <olek2@wp.pl>
    net: ethernet: lantiq_etop: fix memory disclosure

Prashant Malani <pmalani@chromium.org>
    r8152: Factor out OOB link list waits

Eric Dumazet <edumazet@google.com>
    netfilter: nf_tables: prevent nf_skb_duplicated corruption

Phil Sutter <phil@nwl.cc>
    netfilter: uapi: NFTA_FLOWTABLE_HOOK is NLA_NESTED

Xiubo Li <xiubli@redhat.com>
    ceph: remove the incorrect Fw reference check when dirtying pages

Stefan Wahren <wahrenst@gmx.net>
    mailbox: bcm2835: Fix timeout during suspend mode

Liao Chen <liaochen4@huawei.com>
    mailbox: rockchip: fix a typo in module autoloading

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    usb: yurex: Fix inconsistent locking bug in yurex_read()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    i2c: isch: Add missed 'else'

Tommy Huang <tommy_huang@aspeedtech.com>
    i2c: aspeed: Update the stop sw state when the bus recovery occurs

Ma Ke <make24@iscas.ac.cn>
    pps: add an error check in parport_attach

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    pps: remove usage of the deprecated ida_simple_xx() API

Oliver Neukum <oneukum@suse.com>
    USB: misc: yurex: fix race between read and write

Lee Jones <lee@kernel.org>
    usb: yurex: Replace snprintf() with the safer scnprintf() variant

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soc: versatile: realview: fix soc_dev leak during device remove

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soc: versatile: realview: fix memory leak during device remove

Sean Anderson <sean.anderson@linux.dev>
    PCI: xilinx-nwl: Fix off-by-one in INTx IRQ handler

Thomas Gleixner <tglx@linutronix.de>
    PCI: xilinx-nwl: Use irq_data_get_irq_chip_data()

Li Lingfeng <lilingfeng3@huawei.com>
    nfs: fix memory leak in error path of nfs4_do_reclaim

Mickaël Salaün <mic@digikod.net>
    fs: Fix file_set_fowner LSM hook inconsistencies

Julian Sun <sunjunchao2870@gmail.com>
    vfs: fix race between evice_inodes() and find_inode()&iput()

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    f2fs: avoid potential int overflow in sanity_check_area_boundary()

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    f2fs: prevent possible int overflow in dir_block_index()

Thomas Weißschuh <linux@weissschuh.net>
    ACPI: sysfs: validate return type of _STR method

Mikhail Lobanov <m.lobanov@rosalinux.ru>
    drbd: Add NULL check for net_conf to prevent dereference in state validation

Qiu-ji Chen <chenqiuji666@gmail.com>
    drbd: Fix atomicity violation in drbd_uuid_set_bm()

Florian Fainelli <florian.fainelli@broadcom.com>
    tty: rp2: Fix reset with non forgiving PCIe host bridges

Jann Horn <jannh@google.com>
    firmware_loader: Block path traversal

Oliver Neukum <oneukum@suse.com>
    USB: misc: cypress_cy7c63: check for short transfer

Oliver Neukum <oneukum@suse.com>
    USB: appledisplay: close race between probe and completion handler

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soc: versatile: integrator: fix OF node leak in probe() error path

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    Remove *.orig pattern from .gitignore

Hailey Mothershead <hailmo@amazon.com>
    crypto: aead,cipher - zeroize key buffer after use

Simon Horman <horms@kernel.org>
    netfilter: ctnetlink: compile ctnetlink_label_size with CONFIG_NF_CONNTRACK_EVENTS

Youssef Samir <quic_yabdulra@quicinc.com>
    net: qrtr: Update packets cloning when broadcasting

Josh Hunt <johunt@akamai.com>
    tcp: check skb is non-NULL in tcp_rto_delta_us()

Eric Dumazet <edumazet@google.com>
    tcp: introduce tcp_skb_timestamp_us() helper

Kaixin Wang <kxwang23@m.fudan.edu.cn>
    net: seeq: Fix use after free vulnerability in ether3 Driver Due to Race Condition

Eric Dumazet <edumazet@google.com>
    netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()

Suzuki K Poulose <suzuki.poulose@arm.com>
    coresight: tmc: sg: Do not leak sg_table

Chao Yu <chao@kernel.org>
    f2fs: reduce expensive checkpoint trigger frequency

Chao Yu <chao@kernel.org>
    f2fs: remove unneeded check condition in __f2fs_setxattr()

Chao Yu <chao@kernel.org>
    f2fs: fix to update i_ctime in __f2fs_setxattr()

Yonggil Song <yonggil.song@samsung.com>
    f2fs: fix typo

Chao Yu <yuchao0@huawei.com>
    f2fs: enhance to update i_mode and acl atomically in f2fs_setattr()

Guoqing Jiang <guoqing.jiang@linux.dev>
    nfsd: call cache_put if xdr_reserve_space returns NULL

Jinjie Ruan <ruanjinjie@huawei.com>
    ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()

Mikhail Lobanov <m.lobanov@rosalinux.ru>
    RDMA/cxgb4: Added NULL check for lookup_atid

Wang Jianzheng <wangjianzheng@vivo.com>
    pinctrl: mvebu: Fix devinit_dove_pinctrl_probe function

Yangtao Li <frank.li@vivo.com>
    pinctrl: mvebu: Use devm_platform_get_and_ioremap_resource()

David Lechner <dlechner@baylibre.com>
    clk: ti: dra7-atl: Fix leak of of_nodes

Yang Yingliang <yangyingliang@huawei.com>
    pinctrl: single: fix missing error code in pcs_probe()

Zhu Yanjun <yanjun.zhu@linux.dev>
    RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check_flush_dependency

Sean Anderson <sean.anderson@linux.dev>
    PCI: xilinx-nwl: Fix register misspelling

Junlin Li <make24@iscas.ac.cn>
    drivers: media: dvb-frontends/rtl2830: fix an out-of-bounds write error

Junlin Li <make24@iscas.ac.cn>
    drivers: media: dvb-frontends/rtl2832: fix an out-of-bounds write error

Jonas Karlman <jonas@kwiboo.se>
    clk: rockchip: Set parent rate for DCLK_VOP clock on RK3228

Ian Rogers <irogers@google.com>
    perf time-utils: Fix 32-bit nsec parsing

Yang Jihong <yangjihong@bytedance.com>
    perf sched timehist: Fixed timestamp error when unable to confirm event sched_in time

Yang Jihong <yangjihong@bytedance.com>
    perf sched timehist: Fix missing free of session in perf_sched__timehist()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix potential oob read in nilfs_btree_check_delete()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: determine empty node blocks as corrupted

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix potential null-ptr-deref in nilfs_btree_insert()

Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
    ext4: avoid OOB when system.data xattr changes underneath the filesystem

Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
    ext4: return error on ext4_find_inline_entry

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: avoid negative min_clusters in find_group_orlov()

Jiawei Ye <jiawei.ye@foxmail.com>
    smackfs: Use rcu_assign_pointer() to ensure safe assignment in smk_set_cipso

yangerkun <yangerkun@huawei.com>
    ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount with discard

Mauricio Faria de Oliveira <mfo@canonical.com>
    jbd2: introduce/export functions jbd2_journal_submit|finish_inode_data_buffers()

Chen Yu <yu.c.chen@intel.com>
    kthread: fix task state in kthread worker if being frozen

Rob Clark <robdclark@chromium.org>
    kthread: add kthread_work tracepoints

Lasse Collin <lasse.collin@tukaani.org>
    xz: cleanup CRC32 edits from 2018

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix error compiling test_lru_map.c

Juergen Gross <jgross@suse.com>
    xen/swiotlb: add alignment check for dma buffers

Juergen Gross <jgross@suse.com>
    xen/swiotlb: simplify range_straddles_page_boundary()

Juergen Gross <jgross@suse.com>
    xen: use correct end address of kernel for conflict checking

Sherry Yang <sherry.yang@oracle.com>
    drm/msm: fix %s null argument error

Wolfram Sang <wsa+renesas@sang-engineering.com>
    ipmi: docs: don't advertise deprecated sysfs entries

Vladimir Lypak <vladimir.lypak@gmail.com>
    drm/msm/a5xx: fix races in preemption evaluation stage

Vladimir Lypak <vladimir.lypak@gmail.com>
    drm/msm/a5xx: properly clear preemption records on resume

Jeongjun Park <aha310510@gmail.com>
    jfs: fix out-of-bounds in dbNextAG() and diAlloc()

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    drm/radeon/evergreen_cs: fix int overflow errors in cs track offsets

Alex Bee <knaerzche@gmail.com>
    drm/rockchip: vop: Allow 4096px width scaling

Alex Deucher <alexander.deucher@amd.com>
    drm/radeon: properly handle vbios fake edid sizing

Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
    drm/radeon: Replace one-element array with flexible-array member

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: properly handle vbios fake edid sizing

Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
    drm/amdgpu: Replace one-element array with flexible-array member

Matteo Croce <mcroce@redhat.com>
    drm/amd: fix typo

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/stm: Fix an error handling path in stm_drm_platform_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    fbdev: hpfb: Fix an error handling path in hpfb_dio_probe()

Artur Weber <aweber.kernel@gmail.com>
    power: supply: max17042_battery: Fix SOC threshold calc w/ no current sense

Yuntao Liu <liuyuntao12@huawei.com>
    hwmon: (ntc_thermistor) fix module autoloading

Mirsad Todorovac <mtodorovac69@gmail.com>
    mtd: slram: insert break after errors in parsing the map

Guenter Roeck <linux@roeck-us.net>
    hwmon: (max16065) Fix overflows seen when writing limits

Ankit Agrawal <agrawal.ag.ankit@gmail.com>
    clocksource/drivers/qcom: Add missing iounmap() on errors in msm_dt_timer_init()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    reset: berlin: fix OF node leak in probe() error path

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: versatile: fix OF node leak in CPUs prepare

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ

Ma Ke <make24@iscas.ac.cn>
    spi: ppc4xx: handle irq_of_parse_and_map() errors

Yu Kuai <yukuai3@huawei.com>
    block, bfq: don't break merge chain in bfq_split_bfqq()

Yu Kuai <yukuai3@huawei.com>
    block, bfq: choose the last bfqq from merge chain in bfq_setup_cooperator()

Yu Kuai <yukuai3@huawei.com>
    block, bfq: fix possible UAF for bfqq->bic with merge chain

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: btusb: Fix not handling ZPL/short-transfer

Kuniyuki Iwashima <kuniyu@amazon.com>
    can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mac80211: use two-phase skb reclamation in ieee80211_do_stop()

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: cfg80211: fix two more possible UBSAN-detected off-by-one errors

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: cfg80211: fix UBSAN noise in cfg80211_wext_siwscan()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: elements with timeout below CONFIG_HZ never expire

Toke Høiland-Jørgensen <toke@redhat.com>
    wifi: ath9k: Remove error checks when creating debugfs entries

Minjie Du <duminjie@vivo.com>
    wifi: ath9k: fix parameter check in ath9k_init_debug()

Aleksandr Mishin <amishin@t-argos.ru>
    ACPI: PMIC: Remove unneeded check in tps68470_pmic_opregion_probe()

Junhao Xie <bigfoot@classfun.cn>
    USB: serial: pl2303: add device id for Macrosilicon MS3020

Hagar Hemdan <hagarhem@amazon.com>
    gpio: prevent potential speculation leaks in gpio_device_get_desc()

Ferry Meng <mengferry@linux.alibaba.com>
    ocfs2: strict bound check before memcmp in ocfs2_xattr_find_entry()

Ferry Meng <mengferry@linux.alibaba.com>
    ocfs2: add bounds checking to ocfs2_xattr_find_entry()

Michael Kelley <mhklinux@outlook.com>
    x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides frequency

Liao Chen <liaochen4@huawei.com>
    spi: bcm63xx: Enable module autoloading

Liao Chen <liaochen4@huawei.com>
    ASoC: tda7419: fix module autoloading

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead

Daniel Gabay <daniel.gabay@intel.com>
    wifi: iwlwifi: mvm: fix iwl_mvm_max_scan_ie_fw_cmd_room()

Jacky Chou <jacky_chou@aspeedtech.com>
    net: ftgmac100: Ensure tx descriptor updates are visible

Mike Rapoport <rppt@kernel.org>
    microblaze: don't treat zero reserved memory regions as error

Thomas Blocher <thomas.blocher@ek-dev.de>
    pinctrl: at91: make it work with current gpiolib

Hongbo Li <lihongbo22@huawei.com>
    ASoC: allow module autoloading for table db1200_pids

Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
    selftests/kcmp: remove call to ksft_set_plan()

Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
    selftests/vm: remove call to ksft_set_plan()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: stream: Revert "soundwire: stream: fix programming slave ports for non-continous port maps"

Sean Anderson <sean.anderson@linux.dev>
    net: dpaa: Pad packets to ETH_ZLEN

Jacky Chou <jacky_chou@aspeedtech.com>
    net: ftgmac100: Enable TX interrupt to avoid TX timeout

Eran Ben Elisha <eranbe@mellanox.com>
    net/mlx5: Update the list of the PCI supported devices

Quentin Schulz <quentin.schulz@cherry.de>
    arm64: dts: rockchip: override BIOS_DISABLE signal via GPIO hog on RK3399 Puma

Anders Roxell <anders.roxell@linaro.org>
    scripts: kconfig: merge_config: config files: add a trailing newline

Pawel Dembicki <paweldembicki@gmail.com>
    net: phy: vitesse: repair vsc73xx autonegotiation

Moon Yeounsu <yyyynoom@gmail.com>
    net: ethernet: use ip_hdrlen() instead of bit shift

Foster Snowhill <forst@pen.gy>
    usbnet: ipheth: fix carrier detection in modes 1 and 4

Aleksandr Mishin <amishin@t-argos.ru>
    staging: iio: frequency: ad9834: Validate frequency parameter value

Beniamin Bia <biabeniamin@gmail.com>
    staging: iio: frequency: ad9833: Load clock using clock framework

Beniamin Bia <biabeniamin@gmail.com>
    staging: iio: frequency: ad9833: Get frequency value statically


-------------

Diffstat:

 .gitignore                                         |   1 -
 Documentation/IPMI.txt                             |   2 +-
 Documentation/arm64/silicon-errata.txt             |   2 +
 Documentation/driver-model/devres.txt              |   1 +
 Makefile                                           |   4 +-
 arch/arm/mach-realview/platsmp-dt.c                |   1 +
 arch/arm64/Kconfig                                 |   2 +
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |  23 +-
 arch/arm64/include/asm/cputype.h                   |   4 +
 arch/arm64/include/asm/uprobes.h                   |  12 +-
 arch/arm64/kernel/cpu_errata.c                     |   2 +
 arch/arm64/kernel/probes/decode-insn.c             |  16 +-
 arch/arm64/kernel/probes/simulate-insn.c           |  18 +-
 arch/arm64/kernel/probes/uprobes.c                 |   4 +-
 arch/microblaze/mm/init.c                          |   5 -
 arch/parisc/kernel/entry.S                         |   6 +-
 arch/parisc/kernel/syscall.S                       |  14 +-
 arch/riscv/Kconfig                                 |   5 +
 arch/s390/include/asm/facility.h                   |   6 +-
 arch/s390/kernel/perf_cpum_sf.c                    |  12 +-
 arch/s390/kvm/diag.c                               |   2 +-
 arch/s390/kvm/gaccess.c                            | 162 +++++---
 arch/s390/kvm/gaccess.h                            |  14 +-
 arch/s390/mm/cmm.c                                 |  18 +-
 arch/x86/include/asm/cpufeatures.h                 |   3 +-
 arch/x86/kernel/apic/apic.c                        |  14 +-
 arch/x86/kernel/cpu/mshyperv.c                     |   1 +
 arch/x86/xen/setup.c                               |   2 +-
 block/bfq-iosched.c                                |  13 +-
 crypto/aead.c                                      |   3 +-
 crypto/cipher.c                                    |   3 +-
 drivers/acpi/acpica/dbconvert.c                    |   2 +
 drivers/acpi/acpica/exprep.c                       |   3 +
 drivers/acpi/acpica/psargs.c                       |  47 +++
 drivers/acpi/battery.c                             |  28 +-
 drivers/acpi/button.c                              |  11 +
 drivers/acpi/device_sysfs.c                        |   5 +-
 drivers/acpi/ec.c                                  |  55 ++-
 drivers/acpi/pmic/tps68470_pmic.c                  |   6 +-
 drivers/ata/sata_sil.c                             |  12 +-
 drivers/base/bus.c                                 |   6 +-
 drivers/base/core.c                                |  13 +-
 drivers/base/firmware_loader/main.c                |  30 ++
 drivers/base/module.c                              |   4 -
 drivers/block/aoe/aoecmd.c                         |  13 +-
 drivers/block/drbd/drbd_main.c                     |   8 +-
 drivers/block/drbd/drbd_state.c                    |   2 +-
 drivers/bluetooth/btusb.c                          |  10 +-
 drivers/char/virtio_console.c                      |  18 +-
 drivers/clk/bcm/clk-bcm53573-ilp.c                 |   2 +-
 drivers/clk/clk-devres.c                           | 115 +++++-
 drivers/clk/rockchip/clk-rk3228.c                  |   2 +-
 drivers/clk/rockchip/clk.c                         |   3 +-
 drivers/clk/ti/clk-dra7-atl.c                      |   1 +
 drivers/clocksource/timer-qcom.c                   |   7 +-
 drivers/firmware/arm_sdei.c                        |   2 +-
 drivers/gpio/gpio-aspeed.c                         |   4 +-
 drivers/gpio/gpio-davinci.c                        |   8 +-
 drivers/gpio/gpiolib.c                             |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |  15 +-
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     |  26 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c |   2 +
 drivers/gpu/drm/amd/include/atombios.h             |   4 +-
 drivers/gpu/drm/drm_crtc.c                         |  17 +-
 drivers/gpu/drm/drm_print.c                        |  13 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h              |   1 +
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c          |  26 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c           |   2 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |   2 +-
 drivers/gpu/drm/radeon/atombios.h                  |   2 +-
 drivers/gpu/drm/radeon/evergreen_cs.c              |  62 +--
 drivers/gpu/drm/radeon/r100.c                      |  70 ++--
 drivers/gpu/drm/radeon/radeon_atombios.c           |  26 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   4 +-
 drivers/gpu/drm/stm/drv.c                          |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   1 +
 drivers/hid/hid-ids.h                              |   2 +
 drivers/hid/hid-plantronics.c                      |  23 ++
 drivers/hwmon/max16065.c                           |   5 +-
 drivers/hwmon/ntc_thermistor.c                     |   1 +
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   2 +-
 drivers/i2c/busses/i2c-aspeed.c                    |  16 +-
 drivers/i2c/busses/i2c-i801.c                      |   9 +-
 drivers/i2c/busses/i2c-isch.c                      |   3 +-
 drivers/i2c/busses/i2c-xiic.c                      |  19 +-
 drivers/iio/adc/Kconfig                            |   2 +
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   2 +-
 drivers/iio/dac/Kconfig                            |   1 +
 drivers/iio/light/opt3001.c                        |   4 +
 drivers/iio/magnetometer/ak8975.c                  |  32 +-
 drivers/infiniband/core/iwcm.c                     |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |   2 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |  14 +-
 drivers/input/keyboard/adp5589-keys.c              |  13 +-
 drivers/input/rmi4/rmi_driver.c                    |   6 +-
 drivers/mailbox/bcm2835-mailbox.c                  |   3 +-
 drivers/mailbox/rockchip-mailbox.c                 |   2 +-
 drivers/media/common/videobuf2/videobuf2-core.c    |   8 +-
 drivers/media/dvb-frontends/rtl2830.c              |   2 +-
 drivers/media/dvb-frontends/rtl2832.c              |   2 +-
 drivers/media/platform/qcom/venus/core.c           |   1 +
 drivers/misc/sgi-gru/grukservices.c                |   2 -
 drivers/misc/sgi-gru/grumain.c                     |   4 -
 drivers/misc/sgi-gru/grutlbpurge.c                 |   2 -
 drivers/mtd/devices/slram.c                        |   2 +
 drivers/net/dsa/mv88e6xxx/global1_atu.c            |   3 +-
 drivers/net/ethernet/aeroflex/greth.c              |   3 +-
 drivers/net/ethernet/amd/mvme147.c                 |   7 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |   1 +
 drivers/net/ethernet/cortina/gemini.c              |  15 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |  10 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |  26 +-
 drivers/net/ethernet/faraday/ftgmac100.h           |   2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   9 +-
 drivers/net/ethernet/hisilicon/hip04_eth.c         |   1 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |   1 +
 drivers/net/ethernet/hisilicon/hns_mdio.c          |   1 +
 drivers/net/ethernet/i825xx/sun3_82586.c           |   1 +
 drivers/net/ethernet/ibm/emac/mal.c                |   2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   6 +-
 drivers/net/ethernet/jme.c                         |  10 +-
 drivers/net/ethernet/lantiq_etop.c                 |   4 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h         |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   2 +
 drivers/net/ethernet/seeq/ether3.c                 |   2 +
 drivers/net/gtp.c                                  |  27 +-
 drivers/net/hyperv/netvsc_drv.c                    |  30 ++
 drivers/net/macsec.c                               |  18 -
 drivers/net/phy/vitesse.c                          |  14 -
 drivers/net/ppp/ppp_async.c                        |   2 +-
 drivers/net/usb/cdc_ncm.c                          |   8 +-
 drivers/net/usb/ipheth.c                           |   5 +-
 drivers/net/usb/r8152.c                            |  73 +---
 drivers/net/usb/usbnet.c                           |   3 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c          |   7 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |   2 +
 drivers/net/wireless/ath/ath9k/debug.c             |   6 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |   6 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |   2 -
 drivers/net/wireless/intel/iwlegacy/common.c       |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   8 +-
 drivers/net/wireless/marvell/mwifiex/fw.h          |   2 +-
 drivers/net/wireless/marvell/mwifiex/scan.c        |   3 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c                 |   2 +-
 drivers/of/irq.c                                   |  38 +-
 drivers/parport/procfs.c                           |  22 +-
 drivers/pci/controller/pcie-xilinx-nwl.c           |  24 +-
 drivers/pci/quirks.c                               |   6 +
 drivers/pinctrl/mvebu/pinctrl-dove.c               |  45 +-
 drivers/pinctrl/pinctrl-at91.c                     |   5 +-
 drivers/pinctrl/pinctrl-single.c                   |   3 +-
 drivers/power/reset/brcmstb-reboot.c               |   3 -
 drivers/power/supply/max17042_battery.c            |   5 +-
 drivers/pps/clients/pps_parport.c                  |  14 +-
 drivers/reset/reset-berlin.c                       |   3 +-
 drivers/rtc/Kconfig                                |   2 +-
 drivers/rtc/rtc-at91sam9.c                         |  45 +-
 drivers/s390/char/sclp_vt220.c                     |   4 +-
 drivers/scsi/aacraid/aacraid.h                     |   2 +-
 drivers/soc/versatile/soc-integrator.c             |   1 +
 drivers/soc/versatile/soc-realview.c               |  20 +-
 drivers/soundwire/stream.c                         |   8 +-
 drivers/spi/spi-bcm63xx.c                          |   2 +
 drivers/spi/spi-ppc4xx.c                           |   7 +-
 drivers/spi/spi-s3c64xx.c                          |   4 +-
 drivers/staging/iio/frequency/ad9834.c             |  54 +--
 drivers/staging/iio/frequency/ad9834.h             |  28 --
 drivers/tty/serial/rp2.c                           |   2 +-
 drivers/tty/vt/vt.c                                |   2 +-
 drivers/usb/chipidea/udc.c                         |   8 +-
 drivers/usb/dwc3/core.c                            |  49 ++-
 drivers/usb/dwc3/core.h                            |  11 +-
 drivers/usb/dwc3/gadget.c                          |  11 -
 drivers/usb/host/xhci-pci.c                        |   5 +
 drivers/usb/host/xhci-ring.c                       |  16 +-
 drivers/usb/host/xhci.h                            |   2 +-
 drivers/usb/misc/appledisplay.c                    |  15 +-
 drivers/usb/misc/cypress_cy7c63.c                  |   4 +
 drivers/usb/misc/yurex.c                           |   5 +-
 drivers/usb/phy/phy.c                              |   2 +-
 drivers/usb/serial/option.c                        |   8 +
 drivers/usb/serial/pl2303.c                        |   1 +
 drivers/usb/serial/pl2303.h                        |   4 +
 drivers/usb/storage/unusual_devs.h                 |  11 +
 drivers/usb/typec/class.c                          |   3 +
 drivers/video/fbdev/hpfb.c                         |   1 +
 drivers/video/fbdev/pxafb.c                        |   1 +
 drivers/video/fbdev/sis/sis_main.c                 |   2 +-
 drivers/xen/swiotlb-xen.c                          |  40 +-
 fs/btrfs/disk-io.c                                 |  11 +
 fs/ceph/addr.c                                     |   1 -
 fs/ext4/ext4.h                                     |   1 +
 fs/ext4/extents.c                                  |  70 +++-
 fs/ext4/ialloc.c                                   |   2 +
 fs/ext4/inline.c                                   |  35 +-
 fs/ext4/inode.c                                    |  11 +-
 fs/ext4/mballoc.c                                  |  10 +-
 fs/ext4/migrate.c                                  |   2 +-
 fs/ext4/move_extent.c                              |   1 -
 fs/ext4/namei.c                                    |  14 +-
 fs/ext4/xattr.c                                    |   4 +-
 fs/f2fs/acl.c                                      |  23 +-
 fs/f2fs/dir.c                                      |   3 +-
 fs/f2fs/f2fs.h                                     |   4 +-
 fs/f2fs/file.c                                     |  24 +-
 fs/f2fs/super.c                                    |   4 +-
 fs/f2fs/xattr.c                                    |  29 +-
 fs/fat/namei_vfat.c                                |   2 +-
 fs/fcntl.c                                         |  14 +-
 fs/inode.c                                         |   4 +
 fs/jbd2/checkpoint.c                               |  14 +-
 fs/jbd2/commit.c                                   |  36 +-
 fs/jbd2/journal.c                                  |   2 +
 fs/jfs/jfs_discard.c                               |  11 +-
 fs/jfs/jfs_dmap.c                                  |  11 +-
 fs/jfs/jfs_imap.c                                  |   2 +-
 fs/jfs/xattr.c                                     |   2 +
 fs/lockd/clnt4xdr.c                                |  14 -
 fs/lockd/clntxdr.c                                 |  14 -
 fs/nfs/callback_xdr.c                              |  61 ++-
 fs/nfs/nfs2xdr.c                                   |  84 ++--
 fs/nfs/nfs3xdr.c                                   | 163 +++-----
 fs/nfs/nfs42xdr.c                                  |  21 +-
 fs/nfs/nfs4state.c                                 |   1 +
 fs/nfs/nfs4xdr.c                                   | 451 ++++++---------------
 fs/nfsd/nfs4callback.c                             |  13 -
 fs/nfsd/nfs4idmap.c                                |  13 +-
 fs/nfsd/nfs4state.c                                |  15 +-
 fs/nilfs2/btree.c                                  |  12 +-
 fs/nilfs2/dir.c                                    |  50 +--
 fs/nilfs2/namei.c                                  |  42 +-
 fs/nilfs2/nilfs.h                                  |   2 +-
 fs/nilfs2/page.c                                   |   7 +-
 fs/ocfs2/aops.c                                    |   5 +-
 fs/ocfs2/buffer_head_io.c                          |   4 +-
 fs/ocfs2/file.c                                    |   8 +
 fs/ocfs2/journal.c                                 |   7 +-
 fs/ocfs2/localalloc.c                              |  19 +
 fs/ocfs2/quota_local.c                             |   8 +-
 fs/ocfs2/refcounttree.c                            |  26 +-
 fs/ocfs2/xattr.c                                   |  38 +-
 fs/udf/inode.c                                     |   9 +-
 include/drm/drm_print.h                            |  54 ++-
 include/dt-bindings/power/r8a774b1-sysc.h          |  26 ++
 include/linux/clk.h                                | 145 +++++++
 include/linux/jbd2.h                               |   4 +
 include/linux/pci_ids.h                            |   2 +
 include/net/sock.h                                 |   2 +
 include/net/tcp.h                                  |  27 +-
 include/trace/events/f2fs.h                        |   3 +-
 include/trace/events/sched.h                       |  84 ++++
 include/uapi/linux/cec.h                           |   6 +-
 include/uapi/linux/netfilter/nf_tables.h           |   2 +-
 kernel/bpf/arraymap.c                              |   3 +
 kernel/bpf/hashtab.c                               |   3 +
 kernel/bpf/lpm_trie.c                              |   2 +-
 kernel/cgroup/cgroup.c                             |   4 +-
 kernel/events/core.c                               |   6 +-
 kernel/events/uprobes.c                            |   2 +-
 kernel/kthread.c                                   |  19 +-
 kernel/signal.c                                    |  11 +-
 kernel/time/posix-clock.c                          |   3 +
 kernel/trace/trace_output.c                        |   6 +-
 lib/xz/xz_crc32.c                                  |   2 +-
 lib/xz/xz_private.h                                |   4 -
 mm/shmem.c                                         |   2 +
 net/bluetooth/af_bluetooth.c                       |   1 +
 net/bluetooth/bnep/core.c                          |   3 +-
 net/bluetooth/rfcomm/sock.c                        |   2 -
 net/bridge/br_netfilter_hooks.c                    |   5 +
 net/can/bcm.c                                      |   4 +-
 net/core/dev.c                                     |  29 +-
 net/ipv4/devinet.c                                 |   6 +-
 net/ipv4/fib_frontend.c                            |   2 +-
 net/ipv4/ip_gre.c                                  |   6 +-
 net/ipv4/netfilter/nf_dup_ipv4.c                   |   7 +-
 net/ipv4/tcp_input.c                               |  24 +-
 net/ipv4/tcp_ipv4.c                                |   5 +-
 net/ipv4/tcp_output.c                              |   2 +-
 net/ipv4/tcp_rate.c                                |  17 +-
 net/ipv4/tcp_recovery.c                            |   5 +-
 net/ipv6/addrconf.c                                |   8 +-
 net/ipv6/netfilter/nf_dup_ipv6.c                   |   7 +-
 net/ipv6/netfilter/nf_reject_ipv6.c                |  14 +-
 net/mac80211/cfg.c                                 |   3 +-
 net/mac80211/iface.c                               |  17 +-
 net/mac80211/key.c                                 |  42 +-
 net/netfilter/nf_conntrack_netlink.c               |   7 +-
 net/netfilter/nf_tables_api.c                      |   2 +-
 net/netfilter/nft_payload.c                        |   3 +
 net/netlink/af_netlink.c                           |   3 +-
 net/qrtr/qrtr.c                                    |   2 +-
 net/sched/sch_api.c                                |   2 +-
 net/sctp/socket.c                                  |   4 +-
 net/tipc/bearer.c                                  |   8 +-
 net/wireless/nl80211.c                             |   3 +-
 net/wireless/scan.c                                |   6 +-
 net/wireless/sme.c                                 |   3 +-
 net/xfrm/xfrm_user.c                               |   6 +-
 scripts/kconfig/merge_config.sh                    |   2 +
 security/selinux/selinuxfs.c                       |  31 +-
 security/smack/smackfs.c                           |   2 +-
 security/tomoyo/domain.c                           |   9 +-
 sound/core/init.c                                  |  14 +-
 sound/pci/asihpi/hpimsgx.c                         |   2 +-
 sound/pci/hda/hda_generic.c                        |   4 +-
 sound/pci/hda/patch_conexant.c                     |  24 +-
 sound/pci/hda/patch_realtek.c                      |  38 +-
 sound/pci/rme9652/hdsp.c                           |   6 +-
 sound/pci/rme9652/hdspm.c                          |   6 +-
 sound/soc/au1x/db1200.c                            |   1 +
 sound/soc/codecs/tda7419.c                         |   1 +
 tools/iio/iio_generic_buffer.c                     |   4 +
 tools/perf/builtin-sched.c                         |   8 +-
 tools/perf/util/time-utils.c                       |   4 +-
 tools/testing/ktest/ktest.pl                       |   2 +-
 tools/testing/selftests/bpf/test_lru_map.c         |   3 +-
 .../breakpoints/step_after_suspend_test.c          |   5 +-
 tools/testing/selftests/kcmp/kcmp_test.c           |   1 -
 tools/testing/selftests/vDSO/parse_vdso.c          |   3 +-
 tools/testing/selftests/vm/compaction_test.c       |   2 -
 tools/usb/usbip/src/usbip_detach.c                 |   1 +
 virt/kvm/kvm_main.c                                |   5 +-
 326 files changed, 2648 insertions(+), 1791 deletions(-)



