Return-Path: <stable+bounces-80031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BCC98DB72
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA579280FA4
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54A41D0E27;
	Wed,  2 Oct 2024 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xbf9kSOs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3333232;
	Wed,  2 Oct 2024 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879183; cv=none; b=OKT0jBheViKjRPzwSMyjD8t1hbbW4H3pXyy5oBaTTNKGt3Qcd60aEgle3YUFCrDtriARps++x+JWdaKp7E5bDatxY+SXyDko3IuUdMz8o5KD+yxkF8qLdqQuDjgchDSeiH15yTp9DOmVYhcfh/42NDZjwMTONUkoFmzcKixZUa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879183; c=relaxed/simple;
	bh=pFQtK2uldGDLPyaaoLZCPKcIgqDu5sGB764uNt5m6+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WVcNifxOep7+t6WIbxWNKs56N2JYTS0DKDUL7W5ivIglkzqLEOC/RVw+lFp5zX2Bfr6IbLNSIBrBCFBcQgj0+8LomCJzanVset93CcLl0Yc6nUDjF6LdX8GcOi0KeiZCyXjYSXYP43faBdYmQDJDS/1PJS7rBQo0hNmI9gO+l/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xbf9kSOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48169C4CEC2;
	Wed,  2 Oct 2024 14:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879183;
	bh=pFQtK2uldGDLPyaaoLZCPKcIgqDu5sGB764uNt5m6+c=;
	h=From:To:Cc:Subject:Date:From;
	b=Xbf9kSOs6MyTpbrbrG2vYkkWV2q/HioGDSdFRk21S3ZSRAZqbbu2x9AE0T9yQnMcU
	 vQi5/u6Fk3Hb5NiPA/8Lil+HvBFZ3Mm52thyl9zQuupleilaPdH/+QSULGINQpLuHo
	 xp7pnwvMaYbwr3TYrHjoA4J01rKcML+TpKt/UIdQ=
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
	allen.lkml@gmail.com,
	broonie@kernel.org
Subject: [PATCH 6.6 000/538] 6.6.54-rc1 review
Date: Wed,  2 Oct 2024 14:53:59 +0200
Message-ID: <20241002125751.964700919@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.54-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.54-rc1
X-KernelTest-Deadline: 2024-10-04T12:58+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.54 release.
There are 538 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 04 Oct 2024 12:56:13 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.54-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.54-rc1

Alexey Gladkov (Intel) <legion@kernel.org>
    x86/tdx: Fix "in-kernel MMIO" check

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Fix NULL pointer dereference in tb_port_update_credits()

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Fix minimum allocated USB 3.x and PCIe bandwidth

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Send uevent after asymmetric/symmetric switch

Martin KaFai Lau <martin.lau@kernel.org>
    libbpf: Ensure undefined bpf_attr field stays 0

Arend van Spriel <arend.vanspriel@broadcom.com>
    wifi: brcmfmac: add linefeed at end of file

André Apitzsch <git@apitzsch.eu>
    iio: magnetometer: ak8975: Fix 'Unexpected device' error

Robin Murphy <robin.murphy@arm.com>
    perf/arm-cmn: Fail DTC counter allocation correctly

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    usb: yurex: Fix inconsistent locking bug in yurex_read()

Oleg Nesterov <oleg@redhat.com>
    bpf: Fix use-after-free in bpf_uprobe_multi_link_attach()

Paolo Bonzini <pbonzini@redhat.com>
    Documentation: KVM: fix warning in "make htmldocs"

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    i2c: isch: Add missed 'else'

Tommy Huang <tommy_huang@aspeedtech.com>
    i2c: aspeed: Update the stop sw state when the bus recovery occurs

Liam R. Howlett <Liam.Howlett@oracle.com>
    mm/damon/vaddr: protect vma traversal in __damon_va_thre_regions() with rcu read lock

Dmitry Vyukov <dvyukov@google.com>
    module: Fix KCOV-ignored file name

Haibo Chen <haibo.chen@nxp.com>
    spi: fspi: add support for imx8ulp

David Gow <davidgow@google.com>
    mm: only enforce minimum stack gap size if it's sensible

Zhiguo Niu <zhiguo.niu@unisoc.com>
    lockdep: fix deadlock issue between lockdep and rcu

Mikulas Patocka <mpatocka@redhat.com>
    dm-verity: restart or panic on an I/O error

Song Liu <song@kernel.org>
    bpf: lsm: Set bpf_lsm_blob_sizes.lbs_task to 0

Kairui Song <kasong@tencent.com>
    mm/filemap: optimize filemap folio adding

Kairui Song <kasong@tencent.com>
    lib/xarray: introduce a new helper xas_get_order

Kairui Song <kasong@tencent.com>
    mm/filemap: return early if failed to allocate memory for split

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Improve DisplayPort tunnel setup process to be more robust

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Configure asymmetric link if needed and bandwidth allows

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Add support for asymmetric link

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Introduce tb_switch_depth()

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Introduce tb_for_each_upstream_port_on_path()

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Introduce tb_port_path_direction_downstream()

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Change bandwidth reservations to comply USB4 v2

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Make is_gen4_link() available to the rest of the driver

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Use weight constants in tb_usb3_consumed_bandwidth()

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Use constants for path weight and priority

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Create multiple DisplayPort tunnels if there are more DP IN/OUT pairs

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Expose tb_tunnel_xxx() log macros to the rest of the driver

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Use tb_tunnel_dbg() where possible to make logging more consistent

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Fix debug log when DisplayPort adapter not available for pairing

Haibo Chen <haibo.chen@nxp.com>
    dt-bindings: spi: nxp-fspi: add imx8ulp support

Peng Fan <peng.fan@nxp.com>
    dt-bindings: spi: nxp-fspi: support i.MX93 and i.MX95

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race setting file private on concurrent lseek using same fd

Filipe Manana <fdmanana@suse.com>
    btrfs: update comment for struct btrfs_inode::lock

David Sterba <dsterba@suse.com>
    btrfs: reorder btrfs_inode to fill gaps

Qu Wenruo <wqu@suse.com>
    btrfs: subpage: fix the bitmap dump which can cause bitmap corruption

Syed Nayyar Waris <syednwaris@gmail.com>
    lib/bitmap: add bitmap_{read,write}()

Dmitry Vyukov <dvyukov@google.com>
    x86/entry: Remove unwanted instrumentation in common_interrupt()

Xin Li <xin3.li@intel.com>
    x86/idtentry: Incorporate definitions/declarations of the FRED entries

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    serial: don't use uninitialized value in uart_poll_init()

Michael Trimarchi <michael@amarulasolutions.com>
    tty: serial: kgdboc: Fix 8250_* kgdb over serial

Ma Ke <make24@iscas.ac.cn>
    pps: add an error check in parport_attach

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    pps: remove usage of the deprecated ida_simple_xx() API

Pawel Laszczak <pawell@cadence.com>
    usb: xhci: fix loss of data on Cadence xHC

Daehwan Jung <dh10.jung@samsung.com>
    xhci: Add a quirk for writing ERST in high-low order

Oliver Neukum <oneukum@suse.com>
    USB: misc: yurex: fix race between read and write

Lee Jones <lee@kernel.org>
    usb: yurex: Replace snprintf() with the safer scnprintf() variant

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soc: versatile: realview: fix soc_dev leak during device remove

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soc: versatile: realview: fix memory leak during device remove

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: imx6ul-geam: fix fsl,pins property in tscgrp pinctrl

Haibo Chen <haibo.chen@nxp.com>
    spi: fspi: involve lut_num for struct nxp_fspi_devtype_data

VanGiang Nguyen <vangiang.nguyen@rohde-schwarz.com>
    padata: use integer wrap around to prevent deadlock on seq_nr overflow

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    cpuidle: riscv-sbi: Use scoped device node handling to fix missing of_node_put

Eric Dumazet <edumazet@google.com>
    icmp: change the order of rate limits

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    EDAC/igen6: Fix conversion of system address to physical memory address

Li Lingfeng <lilingfeng3@huawei.com>
    nfs: fix memory leak in error path of nfs4_do_reclaim

Mickaël Salaün <mic@digikod.net>
    fs: Fix file_set_fowner LSM hook inconsistencies

Julian Sun <sunjunchao2870@gmail.com>
    vfs: fix race between evice_inodes() and find_inode()&iput()

Dragan Simic <dsimic@manjaro.org>
    arm64: dts: rockchip: Correct the Pinebook Pro battery design capacity

Qingqing Zhou <quic_qqzhou@quicinc.com>
    arm64: dts: qcom: sa8775p: Mark APPS and PCIe SMMUs as DMA coherent

Dragan Simic <dsimic@manjaro.org>
    arm64: dts: rockchip: Raise Pinebook Pro's panel backlight PWM frequency

D Scott Phillips <scott@os.amperecomputing.com>
    arm64: errata: Enable the AC03_CPU_38 workaround for ampere1a

Anastasia Belova <abelova@astralinux.ru>
    arm64: esr: Define ESR_ELx_EC_* constants as UL

Gaosheng Cui <cuigaosheng1@huawei.com>
    hwrng: cctrng - Add missing clk_disable_unprepare in cctrng_resume

Gaosheng Cui <cuigaosheng1@huawei.com>
    hwrng: bcm2835 - Add missing clk_disable_unprepare in bcm2835_rng_init

Guoqing Jiang <guoqing.jiang@canonical.com>
    hwrng: mtk - Use devm_pm_runtime_enable

Chao Yu <chao@kernel.org>
    f2fs: fix to check atomic_file in f2fs ioctl interfaces

Jann Horn <jannh@google.com>
    f2fs: Require FMODE_WRITE for atomic write ioctls

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    f2fs: avoid potential int overflow in sanity_check_area_boundary()

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    f2fs: prevent possible int overflow in dir_block_index()

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    f2fs: fix several potential integer overflows in file offsets

Luca Stefani <luca.stefani.ge1@gmail.com>
    btrfs: always update fstrim_range on failure in FITRIM ioctl

Qu Wenruo <wqu@suse.com>
    btrfs: tree-checker: fix the wrong output of data backref objectid

Zhen Lei <thunder.leizhen@huawei.com>
    debugobjects: Fix conditions in fill_pool()

Ma Ke <make24@iscas.ac.cn>
    wifi: mt76: mt7615: check devm_kasprintf() returned value

Bitterblue Smith <rtl8821cerfe2@gmail.com>
    wifi: rtw88: 8822c: Fix reported RX band width

Nick Morrow <morrownr@gmail.com>
    wifi: rtw88: 8821cu: Remove VID/PID 0bda:c82c

Ma Ke <make24@iscas.ac.cn>
    wifi: mt76: mt7996: fix NULL pointer dereference in mt7996_mcu_sta_bfer_he

Ma Ke <make24@iscas.ac.cn>
    wifi: mt76: mt7915: check devm_kasprintf() returned value

Ma Ke <make24@iscas.ac.cn>
    wifi: mt76: mt7921: Check devm_kasprintf() returned value

Adrian Hunter <adrian.hunter@intel.com>
    perf/x86/intel/pt: Fix sampling synchronization

Ard Biesheuvel <ardb@kernel.org>
    efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption

Werner Sembach <wse@tuxedocomputers.com>
    ACPI: resource: Add another DMI match for the TongFang GMxXGxx

Thomas Weißschuh <linux@weissschuh.net>
    ACPI: sysfs: validate return type of _STR method

Mikhail Lobanov <m.lobanov@rosalinux.ru>
    drbd: Add NULL check for net_conf to prevent dereference in state validation

Qiu-ji Chen <chenqiuji666@gmail.com>
    drbd: Fix atomicity violation in drbd_uuid_set_bm()

Pavan Kumar Paluri <papaluri@amd.com>
    crypto: ccp - Properly unregister /dev/sev on sev PLATFORM_STATUS failure

Johan Hovold <johan+linaro@kernel.org>
    serial: qcom-geni: fix fifo polling timeout

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Set quirky xHC PCI hosts to D3 _after_ stopping and freeing them.

Florian Fainelli <florian.fainelli@broadcom.com>
    tty: rp2: Fix reset with non forgiving PCIe host bridges

Jann Horn <jannh@google.com>
    firmware_loader: Block path traversal

Fabio Porcedda <fabio.porcedda@gmail.com>
    bus: mhi: host: pci_generic: Fix the name for the Telit FE990A

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    bus: integrator-lm: fix OF node leak in probe()

Tomas Marek <tomas.marek@elrest.cz>
    usb: dwc2: drd: fix clock gating on USB role switch

Pawel Laszczak <pawell@cadence.com>
    usb: cdnsp: Fix incorrect usb_request status

Oliver Neukum <oneukum@suse.com>
    USB: class: CDC-ACM: fix race between get_serial and set_serial

Oliver Neukum <oneukum@suse.com>
    USB: misc: cypress_cy7c63: check for short transfer

Oliver Neukum <oneukum@suse.com>
    USB: appledisplay: close race between probe and completion handler

Chen-Yu Tsai <wenst@chromium.org>
    arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled

Oliver Neukum <oneukum@suse.com>
    usbnet: fix cyclical race on disconnect with work queue

Bitterblue Smith <rtl8821cerfe2@gmail.com>
    wifi: rtw88: Fix USB/SDIO devices not transmitting beacons

Stefan Mätje <stefan.maetje@esd.eu>
    can: esd_usb: Remove CAN_CTRLMODE_3_SAMPLES for CAN-USB/3-FD

Finn Thain <fthain@linux-m68k.org>
    scsi: mac_scsi: Disallow bus errors during PDMA send

Finn Thain <fthain@linux-m68k.org>
    scsi: mac_scsi: Refactor polling loop

Finn Thain <fthain@linux-m68k.org>
    scsi: mac_scsi: Revise printk(KERN_DEBUG ...) messages

Manish Pandey <quic_mapa@quicinc.com>
    scsi: ufs: qcom: Update MODE_MAX cfg_bw value

Martin Wilck <mwilck@suse.com>
    scsi: sd: Fix off-by-one error in sd_read_block_characteristics()

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-scsi: Fix ata_msense_control() CDL page reporting

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: handle caseless file creation

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: allow write with FILE_APPEND_DATA

Hobin Woo <hobin.woo@samsung.com>
    ksmbd: make __dir_empty() compatible with POSIX

Chuck Lever <chuck.lever@oracle.com>
    fs: Create a generic is_dot_dotdot() utility

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/atomic: Use YZ constraints for DS-form instructions

Roman Smirnov <r.smirnov@omp.ru>
    KEYS: prevent NULL pointer dereference in find_asymmetric_key()

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/display: Validate backlight caps are sane

Robin Chen <robin.chen@amd.com>
    drm/amd/display: Round calculated vtotal

Leo Ma <hanghong.ma@amd.com>
    drm/amd/display: Add HDMI DSC native YCbCr422 support

Fangzhi Zuo <Jerry.Zuo@amd.com>
    drm/amd/display: Skip Recompute DSC Params if no Stream on Link

Sean Christopherson <seanjc@google.com>
    KVM: Use dedicated mutex to protect kvm_usage_count to avoid deadlock

Sean Christopherson <seanjc@google.com>
    KVM: x86: Move x2APIC ICR helper above kvm_apic_write_nodecode()

Sean Christopherson <seanjc@google.com>
    KVM: x86: Enforce x2APIC's must-be-zero reserved ICR bits

Snehal Koukuntla <snehalreddy@google.com>
    KVM: arm64: Add memory length checks and remove inline in do_ffa_mem_xfer

Werner Sembach <wse@tuxedocomputers.com>
    Input: i8042 - add another board name for TUXEDO Stellaris Gen5 AMD line

Werner Sembach <wse@tuxedocomputers.com>
    Input: i8042 - add TUXEDO Stellaris 15 Slim Gen6 AMD to i8042 quirk table

Werner Sembach <wse@tuxedocomputers.com>
    Input: i8042 - add TUXEDO Stellaris 16 Gen5 AMD to i8042 quirk table

Nuno Sa <nuno.sa@analog.com>
    Input: adp5588-keys - fix check on return code

Jason Gunthorpe <jgg@ziepe.ca>
    iommufd: Protect against overflow of ALIGN() during iova allocation

Roman Smirnov <r.smirnov@omp.ru>
    Revert "media: tuners: fix error return code of hybrid_tuner_request_state()"

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soc: versatile: integrator: fix OF node leak in probe() error path

Herve Codina <herve.codina@bootlin.com>
    soc: fsl: cpm1: tsa: Fix tsa_write8()

Ma Ke <make24@iscas.ac.cn>
    ASoC: rt5682: Return devm_of_clk_add_hw_provider to transfer the error

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    Revert "soc: qcom: smd-rpm: Match rpmsg channel instead of compatible"

Sean Anderson <sean.anderson@linux.dev>
    PCI: xilinx-nwl: Fix off-by-one in INTx IRQ handler

Maciej W. Rozycki <macro@orcam.me.uk>
    PCI: Use an error code with PCIe failed link retraining

Maciej W. Rozycki <macro@orcam.me.uk>
    PCI: Correct error reporting with PCIe failed link retraining

Frank Li <Frank.Li@nxp.com>
    PCI: imx6: Fix missing call to phy_power_off() in error handling

Siddharth Vadapalli <s-vadapalli@ti.com>
    PCI: dra7xx: Fix threaded IRQ request for "dra7xx-pcie-main" IRQ

Maciej W. Rozycki <macro@orcam.me.uk>
    PCI: Clear the LBMS bit after a link retrain

Maciej W. Rozycki <macro@orcam.me.uk>
    PCI: Revert to the original speed after PCIe failed link retraining

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    Remove *.orig pattern from .gitignore

Felix Moessbauer <felix.moessbauer@siemens.com>
    io_uring/sqpoll: do not put cpumask on stack

Jens Axboe <axboe@kernel.dk>
    io_uring/sqpoll: retain test for whether the CPU is valid

Juergen Gross <jgross@suse.com>
    xen: allow mapping ACPI data using a different physical address

Juergen Gross <jgross@suse.com>
    xen: move checks for e820 conflicts further up

Duanqiang Wen <duanqiangwen@net-swift.com>
    Revert "net: libwx: fix alloc msix vectors failed"

Zack Rusin <zack.rusin@broadcom.com>
    drm/vmwgfx: Prevent unmapping active read buffers

Fangzhi Zuo <Jerry.Zuo@amd.com>
    drm/amd/display: Fix Synaptics Cascaded Panamera DSC Determination

Shu Han <ebpqwerty472123@gmail.com>
    mm: call the security_mmap_file() LSM hook in remap_file_pages()

Jens Axboe <axboe@kernel.dk>
    io_uring: check for presence of task_work rather than TIF_NOTIFY_SIGNAL

Felix Moessbauer <felix.moessbauer@siemens.com>
    io_uring/sqpoll: do not allow pinning outside of cpuset

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: use rcu chain hook list iterator from netlink dump path

Simon Horman <horms@kernel.org>
    netfilter: ctnetlink: compile ctnetlink_label_size with CONFIG_NF_CONNTRACK_EVENTS

Phil Sutter <phil@nwl.cc>
    netfilter: nf_tables: Keep deleted flowtable hooks until after RCU

Furong Xu <0x1207@gmail.com>
    net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled

Wenbo Li <liwenbo.martin@bytedance.com>
    virtio_net: Fix mismatched buf address when unmapping for small packets

Jiwon Kim <jiwonaid0@gmail.com>
    bonding: Fix unnecessary warnings and logs from bond_xdp_get_xmit_slave()

Youssef Samir <quic_yabdulra@quicinc.com>
    net: qrtr: Update packets cloning when broadcasting

Josh Hunt <johunt@akamai.com>
    tcp: check skb is non-NULL in tcp_rto_delta_us()

Thomas Weißschuh <thomas.weissschuh@linutronix.de>
    net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL

Kaixin Wang <kxwang23@m.fudan.edu.cn>
    net: seeq: Fix use after free vulnerability in ether3 Driver Due to Race Condition

Eric Dumazet <edumazet@google.com>
    netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()

Sean Anderson <sean.anderson@linux.dev>
    net: xilinx: axienet: Fix packet counting

Sean Anderson <sean.anderson@linux.dev>
    net: xilinx: axienet: Schedule NAPI in two steps

Mikulas Patocka <mpatocka@redhat.com>
    Revert "dm: requeue IO if mapping table not yet available"

Dan Carpenter <alexander.sverdlin@gmail.com>
    ep93xx: clock: Fix off by one in ep93xx_div_recalc_rate()

Jason Wang <jasowang@redhat.com>
    vhost_vdpa: assign irq bypass producer token correctly

Yanfei Xu <yanfei.xu@intel.com>
    cxl/pci: Fix to record only non-zero ranges

Kees Cook <kees@kernel.org>
    interconnect: icc-clk: Add missed num_nodes initialization

Suzuki K Poulose <suzuki.poulose@arm.com>
    coresight: tmc: sg: Do not leak sg_table

Markus Schneider-Pargmann <msp@baylibre.com>
    serial: 8250: omap: Cleanup on error in request_irq

Jinjie Ruan <ruanjinjie@huawei.com>
    driver core: Fix a potential null-ptr-deref in module_add_driver()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    dt-bindings: iio: asahi-kasei,ak8975: drop incorrect AK09116 compatible

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    iio: magnetometer: ak8975: drop incorrect AK09116 compatible

Biju Das <biju.das.jz@bp.renesas.com>
    iio: magnetometer: ak8975: Convert enum->pointer for data in the match tables

Vasileios Amoiridis <vassilisamir@gmail.com>
    iio: chemical: bme680: Fix read/write ops to device by adding mutexes

Antoniu Miclaus <antoniu.miclaus@analog.com>
    ABI: testing: fix admv8818 attr description

Zijun Hu <quic_zijuhu@quicinc.com>
    driver core: Fix error handling in driver API device_rename()

Guillaume Stols <gstols@baylibre.com>
    iio: adc: ad7606: fix standby gpio state to match the documentation

Guillaume Stols <gstols@baylibre.com>
    iio: adc: ad7606: fix oversampling gpio array

Hannes Reinecke <hare@kernel.org>
    nvme-multipath: system fails to create generic nvme device

Alexander Dahl <ada@thorsis.com>
    spi: atmel-quadspi: Avoid overwriting delay register settings

Ming Lei <ming.lei@redhat.com>
    lib/sbitmap: define swap_lock as raw_spinlock_t

Jinjie Ruan <ruanjinjie@huawei.com>
    spi: spi-fsl-lpspi: Undo runtime PM changes at driver exit time

Jinjie Ruan <ruanjinjie@huawei.com>
    spi: atmel-quadspi: Undo runtime PM changes at driver exit time

Chao Yu <chao@kernel.org>
    f2fs: fix to don't set SB_RDONLY in f2fs_handle_critical_error()

Chao Yu <chao@kernel.org>
    f2fs: get rid of online repaire on corrupted directory

Chao Yu <chao@kernel.org>
    f2fs: clean up w/ dotdot_name

Daeho Jeong <daehojeong@google.com>
    f2fs: prevent atomic file from being dirtied before commit

Yeongjin Gil <youngjin.gil@samsung.com>
    f2fs: compress: don't redirty sparse cluster during {,de}compress

Chao Yu <chao@kernel.org>
    f2fs: compress: do sanity check on cluster when CONFIG_F2FS_CHECK_FS is on

Chao Yu <chao@kernel.org>
    f2fs: fix to avoid use-after-free in f2fs_stop_gc_thread()

Chao Yu <chao@kernel.org>
    f2fs: support .shutdown in f2fs_sops

Chao Yu <chao@kernel.org>
    f2fs: atomic: fix to truncate pagecache before on-disk metadata truncation

Chao Yu <chao@kernel.org>
    f2fs: fix to wait page writeback before setting gcing flag

Yeongjin Gil <youngjin.gil@samsung.com>
    f2fs: Create COW inode from parent dentry for atomic write

Chao Yu <chao@kernel.org>
    f2fs: fix to avoid racing in between read and OPU dio write

Chao Yu <chao@kernel.org>
    f2fs: reduce expensive checkpoint trigger frequency

Chao Yu <chao@kernel.org>
    f2fs: atomic: fix to avoid racing w/ GC

Danny Tsen <dtsen@linux.ibm.com>
    crypto: powerpc/p10-aes-gcm - Disable CRYPTO_AES_GCM_P10

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: caam - Pad SG length when allocating hash edesc

Li Lingfeng <lilingfeng3@huawei.com>
    nfsd: return -EINVAL when namelen is 0

Guoqing Jiang <guoqing.jiang@linux.dev>
    nfsd: call cache_put if xdr_reserve_space returns NULL

Dave Jiang <dave.jiang@intel.com>
    ntb: Force physically contiguous allocation of rx ring buffers

Max Hawking <maxahawking@sonnenkinder.org>
    ntb_perf: Fix printk format

Jinjie Ruan <ruanjinjie@huawei.com>
    ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()

Vitaliy Shevtsov <v.shevtsov@maxima.ru>
    RDMA/irdma: fix error message in irdma_modify_qp_roce()

Mikhail Lobanov <m.lobanov@rosalinux.ru>
    RDMA/cxgb4: Added NULL check for lookup_atid

Jinjie Ruan <ruanjinjie@huawei.com>
    riscv: Fix fp alignment bug in perf_callchain_user()

Mark Bloch <mbloch@nvidia.com>
    RDMA/mlx5: Obtain upper net device only when needed

Junxian Huang <huangjunxian6@hisilicon.com>
    RDMA/hns: Fix restricted __le16 degrades to integer issue

Junxian Huang <huangjunxian6@hisilicon.com>
    RDMA/hns: Optimize hem allocation performance

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix 1bit-ECC recovery address in non-4K OS

Junxian Huang <huangjunxian6@hisilicon.com>
    RDMA/hns: Fix VF triggering PF reset in abnormal interrupt handler

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix spin_unlock_irqrestore() called with IRQs enabled

wenglianfa <wenglianfa@huawei.com>
    RDMA/hns: Fix the overflow risk of hem_list_calc_ba_range()

wenglianfa <wenglianfa@huawei.com>
    RDMA/hns: Fix Use-After-Free of rsv_qp on HIP08

Junxian Huang <huangjunxian6@hisilicon.com>
    RDMA/hns: Don't modify rq next block addr in HIP09 QPC

Jonas Blixt <jonas.blixt@actia.se>
    watchdog: imx_sc_wdt: Don't disable WDT in suspend

Michael Guralnik <michaelgur@nvidia.com>
    RDMA/mlx5: Limit usage of over-sized mkeys from the MR cache

Cheng Xu <chengyou@linux.alibaba.com>
    RDMA/erdma: Return QP state in erdma_query_qp

Alexandra Diupina <adiupina@astralinux.ru>
    PCI: kirin: Fix buffer overflow in kirin_pcie_parse_port()

Patrisious Haddad <phaddad@nvidia.com>
    IB/core: Fix ib_cache_setup_one error flow cleanup

Wang Jianzheng <wangjianzheng@vivo.com>
    pinctrl: mvebu: Fix devinit_dove_pinctrl_probe function

Jeff Layton <jlayton@kernel.org>
    nfsd: fix refcount leak when file is unhashed after being found

Jeff Layton <jlayton@kernel.org>
    nfsd: remove unneeded EEXIST error check in nfsd_do_file_acquire

Alexander Shiyan <eagle.alexander923@gmail.com>
    clk: rockchip: rk3588: Fix 32k clock name for pmu_24m_32k_100m_src_p

Yuntao Liu <liuyuntao12@huawei.com>
    clk: starfive: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage

David Lechner <dlechner@baylibre.com>
    clk: ti: dra7-atl: Fix leak of of_nodes

Md Haris Iqbal <haris.iqbal@ionos.com>
    RDMA/rtrs-clt: Reset cid to con_num - 1 to stay in bounds

Jack Wang <jinpu.wang@ionos.com>
    RDMA/rtrs: Reset hb_missed_cnt after receiving other traffic from peer

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: Fix H264 stateless decoder smatch warning

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: Fix VP8 stateless decoder smatch warning

Yunfei Dong <yunfei.dong@mediatek.com>
    media: mediatek: vcodec: Fix H264 multi stateless decoder smatch warning

Claudiu Beznea <claudiu.beznea@tuxon.dev>
    clk: at91: sama7g5: Allocate only the needed amount of memory for PLLs

Yang Yingliang <yangyingliang@huawei.com>
    pinctrl: single: fix missing error code in pcs_probe()

Zhu Yanjun <yanjun.zhu@linux.dev>
    RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check_flush_dependency

Biju Das <biju.das.jz@bp.renesas.com>
    media: platform: rzg2l-cru: rzg2l-csi2: Add missing MODULE_DEVICE_TABLE

Sean Anderson <sean.anderson@linux.dev>
    PCI: xilinx-nwl: Clean up clock on probe failure/removal

Sean Anderson <sean.anderson@linux.dev>
    PCI: xilinx-nwl: Fix register misspelling

Li Zhijian <lizhijian@fujitsu.com>
    nvdimm: Fix devs leaks in scan_labels()

Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
    x86/PCI: Check pcie_find_root_port() return for NULL

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    leds: pca995x: Fix device child node usage in pca995x_probe()

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    leds: pca995x: Use device_for_each_child_node() to access device child nodes

Pieterjan Camerlynck <pieterjanca@gmail.com>
    leds: leds-pca995x: Add support for NXP PCA9956B

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: dispcc-sm8250: use special function for Lucid 5LPE PLL

Varadarajan Narayanan <quic_varada@quicinc.com>
    clk: qcom: ipq5332: Register gcc_qdss_tsctr_clk_src

Dan Carpenter <dan.carpenter@linaro.org>
    PCI: keystone: Fix if-statement expression in ks_pcie_quirk()

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: core: correct range of block for case of switch statement

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: Wait for Link before restoring Downstream Buses

Junlin Li <make24@iscas.ac.cn>
    drivers: media: dvb-frontends/rtl2830: fix an out-of-bounds write error

Junlin Li <make24@iscas.ac.cn>
    drivers: media: dvb-frontends/rtl2832: fix an out-of-bounds write error

Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
    Input: ilitek_ts_i2c - add report id message validation

Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
    Input: ilitek_ts_i2c - avoid wrong input subsystem sync

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    pinctrl: ti: ti-iodelay: Fix some error handling paths

Peng Fan <peng.fan@nxp.com>
    pinctrl: ti: iodelay: Use scope based of_node_put() cleanups

Rob Herring <robh@kernel.org>
    pinctrl: Use device_get_match_data()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    pinctrl: ti: ti-iodelay: Convert to platform remove callback returning void

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    leds: bd2606mvv: Fix device child node usage in bd2606mvv_probe()

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: dispcc-sm8550: use rcg2_shared_ops for ESC RCGs

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: dispcc-sm8650: Update the GDSC flags

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: dispcc-sm8550: use rcg2_ops for mdss_dptx1_aux_clk_src

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: dispcc-sm8550: fix several supposed typos

Jonas Karlman <jonas@kwiboo.se>
    clk: rockchip: Set parent rate for DCLK_VOP clock on RK3228

Peng Fan <peng.fan@nxp.com>
    remoteproc: imx_rproc: Initialize workqueue earlier

Peng Fan <peng.fan@nxp.com>
    remoteproc: imx_rproc: Correct ddr alias for i.MX8M

Peng Fan <peng.fan@nxp.com>
    clk: imx: imx8qxp: Parent should be initialized earlier than the clock

Peng Fan <peng.fan@nxp.com>
    clk: imx: imx8qxp: Register dc0_bypass0_clk before disp clk

Zhipeng Wang <zhipeng.wang_1@nxp.com>
    clk: imx: imx8mp: fix clock tree update of TF-A managed clocks

Pengfei Li <pengfei.li_1@nxp.com>
    clk: imx: fracn-gppll: fix fractional part of PLL getting lost

Ye Li <ye.li@nxp.com>
    clk: imx: composite-7ulp: Check the PCC present bit

Jacky Bai <ping.bai@nxp.com>
    clk: imx: composite-93: keep root clock on when mcore enabled

Peng Fan <peng.fan@nxp.com>
    clk: imx: composite-8m: Enable gate clk with mcore_booted

Markus Elfring <elfring@users.sourceforge.net>
    clk: imx: composite-8m: Less function calls in __imx8m_clk_hw_composite() after error detection

Sebastien Laveze <slaveze@smartandconnective.com>
    clk: imx: imx6ul: fix default parent for enet*_ref_sel

Shengjiu Wang <shengjiu.wang@nxp.com>
    clk: imx: clk-audiomix: Correct parent clock for earc_phy and audpll

Ian Rogers <irogers@google.com>
    perf time-utils: Fix 32-bit nsec parsing

Yang Jihong <yangjihong@bytedance.com>
    perf sched timehist: Fixed timestamp error when unable to confirm event sched_in time

Yicong Yang <yangyicong@hisilicon.com>
    perf stat: Display iostat headers correctly

Yang Jihong <yangjihong@bytedance.com>
    perf sched timehist: Fix missing free of session in perf_sched__timehist()

Kan Liang <kan.liang@linux.intel.com>
    perf report: Fix --total-cycles --stdio output error

Namhyung Kim <namhyung@kernel.org>
    perf ui/browser/annotate: Use global annotation_options

Namhyung Kim <namhyung@kernel.org>
    perf annotate: Move some source code related fields from 'struct annotation' to 'struct annotated_source'

Namhyung Kim <namhyung@kernel.org>
    perf annotate: Split branch stack cycles info from 'struct annotation'

Ian Rogers <irogers@google.com>
    perf inject: Fix leader sampling inserting additional samples

Ian Rogers <irogers@google.com>
    perf callchain: Fix stitch LBR memory leaks

Namhyung Kim <namhyung@kernel.org>
    perf mem: Free the allocated sort string, fixing a leak

Daniel Borkmann <daniel@iogearbox.net>
    bpf: Zero former ARG_PTR_TO_{LONG,INT} args in case of error

Daniel Borkmann <daniel@iogearbox.net>
    bpf: Improve check_raw_mode_ok test for MEM_UNINIT-tagged types

Daniel Borkmann <daniel@iogearbox.net>
    bpf: Fix helper writes to read-only maps

Daniel Borkmann <daniel@iogearbox.net>
    bpf: Fix bpf_strtol and bpf_strtoul helpers for 32bit

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix potential oob read in nilfs_btree_check_delete()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: determine empty node blocks as corrupted

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix potential null-ptr-deref in nilfs_btree_insert()

Yujie Liu <yujie.liu@intel.com>
    sched/numa: Fix the vma scan starving issue

Mel Gorman <mgorman@techsingularity.net>
    sched/numa: Complete scanning of inactive VMAs when there is no alternative

Mel Gorman <mgorman@techsingularity.net>
    sched/numa: Complete scanning of partial VMAs regardless of PID activity

Raghavendra K T <raghavendra.kt@amd.com>
    sched/numa: Move up the access pid reset logic

Mel Gorman <mgorman@techsingularity.net>
    sched/numa: Trace decisions related to skipping VMAs

Mel Gorman <mgorman@techsingularity.net>
    sched/numa: Rename vma_numab_state::access_pids[] => ::pids_active[], ::next_pid_reset => ::pids_active_reset

Mel Gorman <mgorman@techsingularity.net>
    sched/numa: Document vma_numab_state fields

Ojaswin Mujoo <ojaswin@linux.ibm.com>
    ext4: check stripe size compatibility on remount as well

Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
    ext4: avoid OOB when system.data xattr changes underneath the filesystem

Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
    ext4: return error on ext4_find_inline_entry

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: avoid negative min_clusters in find_group_orlov()

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: avoid potential buffer_head leak in __ext4_new_inode()

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: avoid buffer_head leak in ext4_mark_inode_used()

Jiawei Ye <jiawei.ye@foxmail.com>
    smackfs: Use rcu_assign_pointer() to ensure safe assignment in smk_set_cipso

yangerkun <yangerkun@huawei.com>
    ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount with discard

Chen Yu <yu.c.chen@intel.com>
    kthread: fix task state in kthread worker if being frozen

Lasse Collin <lasse.collin@tukaani.org>
    xz: cleanup CRC32 edits from 2018

Eduard Zingerman <eddyz87@gmail.com>
    bpf: correctly handle malformed BPF_CORE_TYPE_ID_LOCAL relos

Jiangshan Yi <yijiangshan@kylinos.cn>
    samples/bpf: Fix compilation errors with cf-protection option

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix error compiling tc_redirect.c with musl libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix compile if backtrace support missing in libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix redefinition errors compiling lwt_reroute.c

Yonghong Song <yonghong.song@linux.dev>
    selftests/bpf: Fix flaky selftest lwt_redirect/lwt_reroute

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix C++ compile error from missing _Bool type

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix error compiling test_lru_map.c

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix arg parsing in veristat, test_progs

David Vernet <void@manifault.com>
    libbpf: Don't take direct pointers into BTF data from st_ops

Eduard Zingerman <eddyz87@gmail.com>
    libbpf: Sync progs autoload with maps autocreate for struct_ops maps

Kui-Feng Lee <thinker.li@gmail.com>
    libbpf: Convert st_ops->data to shadow type.

Kui-Feng Lee <thinker.li@gmail.com>
    libbpf: Find correct module BTFs for struct_ops maps and progs.

Andrii Nakryiko <andrii@kernel.org>
    libbpf: use stable map placeholder FDs

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix errors compiling cg_storage_multi.h with musl libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix errors compiling decap_sanity.c with musl libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix errors compiling lwt_redirect.c with musl libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix compiling core_reloc.c with musl-libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix compiling tcp_rtt.c with musl-libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix compiling flow_dissector.c with musl-libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix compiling kfree_skb.c with musl-libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix compiling parse_tcp_hdr_opt.c with musl-libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix include of <sys/fcntl.h>

Yonghong Song <yonghong.song@linux.dev>
    selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid() test

Yonghong Song <yonghong.song@linux.dev>
    selftests/bpf: Refactor out some functions in ns_current_pid_tgid test

Yonghong Song <yonghong.song@linux.dev>
    selftests/bpf: Replace CHECK with ASSERT_* in ns_current_pid_tgid test

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix missing BUILD_BUG_ON() declaration

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix missing UINT_MAX definitions in benchmarks

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix missing ARRAY_SIZE() definition in bench.c

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Drop unneeded error.h includes

Tushar Vyavahare <tushar.vyavahare@intel.com>
    selftests/bpf: Implement get_hw_ring_size function to retrieve current and max interface size

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix error compiling bpf_iter_setsockopt.c with musl libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix compile error from rlim_t in sk_storage_map.c

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Use pid_t consistently in test_progs.c

Tony Ambardar <tony.ambardar@gmail.com>
    tools/runqslower: Fix LDFLAGS and add LDLIBS support

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix wrong binary in Makefile log output

Cupertino Miranda <cupertino.miranda@oracle.com>
    selftests/bpf: Add CFLAGS per source file and runner

Jose E. Marchesi <jose.marchesi@oracle.com>
    bpf: Temporarily define BPF_NO_PRESEVE_ACCESS_INDEX for GCC

Jose E. Marchesi <jose.marchesi@oracle.com>
    bpf: Disable some `attribute ignored' warnings in GCC

Jose E. Marchesi <jose.marchesi@oracle.com>
    bpf: Use -Wno-error in certain tests when building with GCC

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix error linking uprobe_multi on mips

Alexei Starovoitov <ast@kernel.org>
    selftests/bpf: Workaround strict bpf_lsm return value check.

Tianchen Ding <dtcccc@linux.alibaba.com>
    sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy

Jonathan McDowell <noodles@meta.com>
    tpm: Clean up TPM space after command failure

Juergen Gross <jgross@suse.com>
    xen/swiotlb: fix allocated size

Juergen Gross <jgross@suse.com>
    xen/swiotlb: add alignment check for dma buffers

Juergen Gross <jgross@suse.com>
    xen: tolerate ACPI NVS memory overlapping with Xen allocated memory

Juergen Gross <jgross@suse.com>
    xen: add capability to remap non-RAM pages to different PFNs

Juergen Gross <jgross@suse.com>
    xen: move max_pfn in xen_memory_setup() out of function scope

Juergen Gross <jgross@suse.com>
    xen: introduce generic helper checking for memory map conflicts

Linus Torvalds <torvalds@linux-foundation.org>
    minmax: avoid overly complex min()/max() macro arguments in xen

Niklas Cassel <cassel@kernel.org>
    ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data

Jason Gerecke <jason.gerecke@wacom.com>
    HID: wacom: Do not warn about dropped packets for first packet

Jason Gerecke <jason.gerecke@wacom.com>
    HID: wacom: Support sequence numbers smaller than 16-bit

Juergen Gross <jgross@suse.com>
    xen: use correct end address of kernel for conflict checking

Yuesong Li <liyuesong@vivo.com>
    drivers:drm:exynos_drm_gsc:Fix wrong assignment in gsc_bind()

Sherry Yang <sherry.yang@oracle.com>
    drm/msm: fix %s null argument error

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dsi: correct programming sequence for SM8350 / SM8450

Wolfram Sang <wsa+renesas@sang-engineering.com>
    ipmi: docs: don't advertise deprecated sysfs entries

Vladimir Lypak <vladimir.lypak@gmail.com>
    drm/msm/a5xx: workaround early ring-buffer emptiness check

Vladimir Lypak <vladimir.lypak@gmail.com>
    drm/msm/a5xx: fix races in preemption evaluation stage

Vladimir Lypak <vladimir.lypak@gmail.com>
    drm/msm/a5xx: properly clear preemption records on resume

Vladimir Lypak <vladimir.lypak@gmail.com>
    drm/msm/a5xx: disable preemption in submits by default

Aleksandr Mishin <amishin@t-argos.ru>
    drm/msm: Fix incorrect file name output in adreno_request_fw()

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/vdso: Inconditionally use CFUNC macro

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/8xx: Fix kernel vs user address comparison

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/8xx: Fix initial memory mapping

Fei Shao <fshao@chromium.org>
    drm/mediatek: Use spin_lock_irqsave() for CRTC event lock

Jason-JH.Lin <jason-jh.lin@mediatek.com>
    drm/mediatek: Fix missing configuration flags in mtk_crtc_ddp_config()

Jeongjun Park <aha310510@gmail.com>
    jfs: fix out-of-bounds in dbNextAG() and diAlloc()

Dan Carpenter <dan.carpenter@linaro.org>
    scsi: elx: libefc: Fix potential use after free in efc_nport_vport_del()

Stefan Wahren <wahrenst@gmx.net>
    drm/vc4: hdmi: Handle error case of pm_runtime_resume_and_get

Liu Ying <victor.liu@nxp.com>
    drm/bridge: lontium-lt8912b: Validate mode in drm_bridge_funcs::mode_valid()

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    drm/radeon/evergreen_cs: fix int overflow errors in cs track offsets

Jonas Karlman <jonas@kwiboo.se>
    drm/rockchip: dw_hdmi: Fix reading EDID when using a forced mode

Alex Bee <knaerzche@gmail.com>
    drm/rockchip: vop: Allow 4096px width scaling

WangYuli <wangyuli@uniontech.com>
    drm/amd/amdgpu: Properly tune the size of struct

Finn Thain <fthain@linux-m68k.org>
    scsi: NCR5380: Check for phase match during PDMA fixup

Gilbert Wu <Gilbert.Wu@microchip.com>
    scsi: smartpqi: revert propagate-the-multipath-failure-to-SML-quickly

Alex Deucher <alexander.deucher@amd.com>
    drm/radeon: properly handle vbios fake edid sizing

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: properly handle vbios fake edid sizing

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Add null check for set_output_gamma in dcn30_set_output_transfer_func

Claudiu Beznea <claudiu.beznea@microchip.com>
    drm/stm: ltdc: check memory returned by devm_kzalloc()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/stm: Fix an error handling path in stm_drm_platform_probe()

Geert Uytterhoeven <geert+renesas@glider.be>
    pmdomain: core: Harden inter-column space in debug summary

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    iommu/arm-smmu-qcom: apply num_context_bank fixes for SDM630 / SDM660

Konrad Dybcio <konrad.dybcio@linaro.org>
    iommu/arm-smmu-qcom: Work around SDM845 Adreno SMMU w/ 16K pages

Marc Gonzalez <mgonzalez@freebox.fr>
    iommu/arm-smmu-qcom: hide last LPASS SMMU context bank from linux

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: mtk: Fix init error path

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: mtk: Factorize out the logic cleaning mtk chips

Jinjie Ruan <ruanjinjie@huawei.com>
    mtd: rawnand: mtk: Use for_each_child_of_node_scoped()

Frederic Weisbecker <frederic@kernel.org>
    rcu/nocb: Fix RT throttling hrtimer armed from offline CPU

Charles Han <hanchunchao@inspur.com>
    mtd: powernv: Add check devm_kasprintf() returned value

Jason Gunthorpe <jgg@ziepe.ca>
    iommu/amd: Do not set the D bit on AMD v2 table entries

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    fbdev: hpfb: Fix an error handling path in hpfb_dio_probe()

Artur Weber <aweber.kernel@gmail.com>
    power: supply: max17042_battery: Fix SOC threshold calc w/ no current sense

Chris Morgan <macromorgan@hotmail.com>
    power: supply: axp20x_battery: Remove design from min and max voltage

Yuntao Liu <liuyuntao12@huawei.com>
    hwmon: (ntc_thermistor) fix module autoloading

Mirsad Todorovac <mtodorovac69@gmail.com>
    mtd: slram: insert break after errors in parsing the map

Guenter Roeck <linux@roeck-us.net>
    hwmon: (max16065) Fix alarm attributes

Andrew Davis <afd@ti.com>
    hwmon: (max16065) Remove use of i2c_match_id()

Guenter Roeck <linux@roeck-us.net>
    hwmon: (max16065) Fix overflows seen when writing limits

tangbin <tangbin@cmss.chinamobile.com>
    ASoC: loongson: fix error release

Finn Thain <fthain@linux-m68k.org>
    m68k: Fix kernel_clone_args.flags in m68k_clone()

Yuntao Liu <liuyuntao12@huawei.com>
    ALSA: hda: cs35l41: fix module autoloading

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    selftests/ftrace: Add required dependency for kprobe tests

Linus Walleij <linus.walleij@linaro.org>
    ASoC: tas2781-i2c: Get the right GPIO line

Linus Walleij <linus.walleij@linaro.org>
    ASoC: tas2781-i2c: Drop weird GPIO code

Rob Herring (Arm) <robh@kernel.org>
    ASoC: tas2781: Use of_property_read_reg()

Gergo Koteles <soyer@irl.hu>
    ASoC: tas2781: remove unused acpi_subysystem_id

Ma Ke <make24@iscas.ac.cn>
    ASoC: rt5682s: Return devm_of_clk_add_hw_provider to transfer the error

Yosry Ahmed <yosryahmed@google.com>
    x86/mm: Use IPIs to synchronize LAM enablement

Chen-Yu Tsai <wenst@chromium.org>
    arm64: dts: mediatek: mt8195: Correct clock order for dp_intf*

Ankit Agrawal <agrawal.ag.ankit@gmail.com>
    clocksource/drivers/qcom: Add missing iounmap() on errors in msm_dt_timer_init()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    reset: k210: fix OF node leak in probe() error path

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    reset: berlin: fix OF node leak in probe() error path

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: versatile: fix OF node leak in CPUs prepare

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: imx7d-zii-rmu2: fix Ethernet PHY pinctrl property

Claudiu Beznea <claudiu.beznea@tuxon.dev>
    ARM: dts: microchip: sama7g5: Fix RTT clock

Jinjie Ruan <ruanjinjie@huawei.com>
    spi: bcmbca-hsspi: Fix missing pm_runtime_disable()

Andrew Davis <afd@ti.com>
    arm64: dts: ti: k3-j721e-beagleboneai64: Fix reversed C6x carveout locations

Andrew Davis <afd@ti.com>
    arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout locations

Jonas Karlman <jonas@kwiboo.se>
    arm64: dts: rockchip: Correct vendor prefix for Hardkernel ODROID-M1

Alexander Dahl <ada@thorsis.com>
    ARM: dts: microchip: sam9x60: Fix rtc/rtt clocks

Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
    arm64: dts: renesas: r9a07g044: Correct GICD and GICR sizes

Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
    arm64: dts: renesas: r9a07g054: Correct GICD and GICR sizes

Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
    arm64: dts: renesas: r9a07g043u: Correct GICD and GICR sizes

Chen-Yu Tsai <wenst@chromium.org>
    regulator: Return actual error in of_regulator_bulk_get_all()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ

Cristian Marussi <cristian.marussi@arm.com>
    firmware: arm_scmi: Fix double free in OPTEE transport

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: mt8186: Fix supported-hw mask for GPU OPPs

David Virag <virag.david003@gmail.com>
    arm64: dts: exynos: exynos7885-jackpotlte: Correct RAM amount to 4GB

Ma Ke <make24@iscas.ac.cn>
    spi: ppc4xx: handle irq_of_parse_and_map() errors

Riyan Dhiman <riyandhiman14@gmail.com>
    block: fix potential invalid pointer dereference in blk_add_partition

Christian Heusel <christian@heusel.eu>
    block: print symbolic error name instead of error code

Felix Moessbauer <felix.moessbauer@siemens.com>
    io_uring/io-wq: inherit cpuset of cgroup in io worker

Felix Moessbauer <felix.moessbauer@siemens.com>
    io_uring/io-wq: do not allow pinning outside of cpuset

Yu Kuai <yukuai3@huawei.com>
    block, bfq: fix procress reference leakage for bfqq in merge chain

Yu Kuai <yukuai3@huawei.com>
    block, bfq: fix uaf for accessing waker_bfqq after splitting

Gao Xiang <xiang@kernel.org>
    erofs: fix incorrect symlink detection in fast symlink

David Howells <dhowells@redhat.com>
    cachefiles: Fix non-taking of sb_writers around set/removexattr

Yu Kuai <yukuai3@huawei.com>
    block, bfq: don't break merge chain in bfq_split_bfqq()

Yu Kuai <yukuai3@huawei.com>
    block, bfq: choose the last bfqq from merge chain in bfq_setup_cooperator()

Yu Kuai <yukuai3@huawei.com>
    block, bfq: fix possible UAF for bfqq->bic with merge chain

Ming Lei <ming.lei@redhat.com>
    nbd: fix race between timeout and normal completion

Ming Lei <ming.lei@redhat.com>
    ublk: move zone report data out of request pdu

Eric Dumazet <edumazet@google.com>
    ipv6: avoid possible NULL deref in rt6_uncached_list_flush_dev()

Su Hui <suhui@nfschina.com>
    net: tipc: avoid possible garbage value

Justin Iurman <justin.iurman@uliege.be>
    net: ipv6: rpl_iptunnel: Fix memory leak in rpl_input

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: disable ALDPS per default for RTL8125

Jinjie Ruan <ruanjinjie@huawei.com>
    net: enetc: Use IRQF_NO_AUTOEN flag in request_irq()

Guillaume Nault <gnault@redhat.com>
    bareudp: Pull inner IP header on xmit.

Guillaume Nault <gnault@redhat.com>
    bareudp: Pull inner IP header in bareudp_udp_encap_recv().

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: btusb: Fix not handling ZPL/short-transfer

Marc Kleine-Budde <mkl@pengutronix.de>
    can: m_can: m_can_close(): stop clocks after device has been shut down

Jake Hamby <Jake.Hamby@Teledyne.com>
    can: m_can: enable NAPI before enabling interrupts

Kuniyuki Iwashima <kuniyu@amazon.com>
    can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().

Eric Dumazet <edumazet@google.com>
    sock_map: Add a cond_resched() in sock_hash_free()

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sync: Ignore errors from HCI_OP_REMOTE_NAME_REQ_CANCEL

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_core: Fix sending MGMT_EV_CONNECT_FAILED

Jiawei Ye <jiawei.ye@foxmail.com>
    wifi: wilc1000: fix potential RCU dereference issue in wilc_parse_join_bss_param

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mac80211: use two-phase skb reclamation in ieee80211_do_stop()

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: cfg80211: fix two more possible UBSAN-detected off-by-one errors

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: mt7996: fix uninitialized TLV data

Benjamin Lin <benjamin-jw.lin@mediatek.com>
    wifi: mt76: mt7996: ensure 4-byte alignment for beacon commands

Howard Hsu <howard-yh.hsu@mediatek.com>
    wifi: mt76: mt7915: fix rx filter setting for bfee functionality

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: cfg80211: fix UBSAN noise in cfg80211_wext_siwscan()

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: mt7603: fix mixed declarations and code

Weili Qian <qianweili@huawei.com>
    crypto: hisilicon/qm - inject error before stopping queue

Weili Qian <qianweili@huawei.com>
    crypto: hisilicon/qm - reset device before enabling it

Weili Qian <qianweili@huawei.com>
    crypto: hisilicon/hpre - mask cluster timeout error

John B. Wyatt IV <jwyatt@redhat.com>
    pm:cpupower: Add missing powercap_set_enabled() stub function

Aaron Lu <aaron.lu@intel.com>
    x86/sgx: Fix deadlock in SGX NUMA node search

Howard Hsu <howard-yh.hsu@mediatek.com>
    wifi: mt76: mt7996: fix EHT beamforming capability check

Howard Hsu <howard-yh.hsu@mediatek.com>
    wifi: mt76: mt7996: fix HE and EHT beamforming capabilities

Peter Chiu <chui-hao.chiu@mediatek.com>
    wifi: mt76: mt7996: fix wmm set of station interface to 3

Peter Chiu <chui-hao.chiu@mediatek.com>
    wifi: mt76: mt7996: fix traffic delay when switching back to working channel

Peter Chiu <chui-hao.chiu@mediatek.com>
    wifi: mt76: mt7996: use hweight16 to get correct tx antenna

Bjørn Mork <bjorn@mork.no>
    wifi: mt76: mt7915: fix oops on non-dbdc mt7986

Nishanth Menon <nm@ti.com>
    cpufreq: ti-cpufreq: Introduce quirks to handle syscon fails appropriately

Robin Murphy <robin.murphy@arm.com>
    perf/arm-cmn: Ensure dtm_idx is big enough

Robin Murphy <robin.murphy@arm.com>
    perf/arm-cmn: Fix CCLA register offset

Robin Murphy <robin.murphy@arm.com>
    perf/arm-cmn: Refactor node ID handling. Again.

Robin Murphy <robin.murphy@arm.com>
    perf/arm-cmn: Improve debugfs pretty-printing for large configs

Robin Murphy <robin.murphy@arm.com>
    perf/arm-cmn: Rework DTC counters (again)

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: remove annotation to access set timeout while holding lock

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject expiration higher than timeout

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject element expiration with no timeout

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: elements with timeout below CONFIG_HZ never expire

Clément Léger <cleger@rivosinc.com>
    ACPI: CPPC: Fix MASK_VAL() usage

Zhang Changzhong <zhangchangzhong@huawei.com>
    can: j1939: use correct function name in comment

Mark Brown <broonie@kernel.org>
    kselftest/arm64: Actually test SME vector length changes via sigreturn

Yicong Yang <yangyicong@hisilicon.com>
    drivers/perf: hisi_pcie: Fix TLP headers bandwidth counting

Yicong Yang <yangyicong@hisilicon.com>
    drivers/perf: hisi_pcie: Record hardware counts correctly

Kamlesh Gurudasani <kamlesh@ti.com>
    padata: Honor the caller's alignment in case of chunk_size 0

Avraham Stern <avraham.stern@intel.com>
    wifi: iwlwifi: mvm: increase the time between ranging measurements

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: config: label 'gl' devices as discrete

Golan Ben Ami <golan.ben.ami@intel.com>
    wifi: iwlwifi: remove AX101, AX201 and AX203 support from LNL

Ping-Ke Shih <pkshih@realtek.com>
    wifi: mac80211: don't use rate mask for offchannel TX either

Jing Zhang <renyu.zj@linux.alibaba.com>
    drivers/perf: Fix ali_drw_pmu driver interrupt status clearing

Andre Przywara <andre.przywara@arm.com>
    kselftest/arm64: signal: fix/refactor SVE vector length enumeration

Dan Carpenter <dan.carpenter@linaro.org>
    powercap: intel_rapl: Fix off by one in get_rpi()

Calvin Owens <calvin@wbinvd.org>
    ARM: 9410/1: vfp: Use asm volatile in fmrx/fmxr macros

Olaf Hering <olaf@aepfle.de>
    mount: handle OOM on mnt_warn_timestamp_expiry

Atish Patra <atishp@rivosinc.com>
    RISC-V: KVM: Fix to allow hpmcounter31 from the guest

Atish Patra <atishp@rivosinc.com>
    RISC-V: KVM: Allow legacy PMU access from guest

Andrew Jones <ajones@ventanamicro.com>
    RISC-V: KVM: Fix sbiret init before forwarding to userspace

Dmitry Kandybka <d.kandybka@gmail.com>
    wifi: rtw88: remove CPT execution branch never used

Dave Martin <Dave.Martin@arm.com>
    arm64: signal: Fix some under-bracketed UAPI macros

Yanteng Si <siyanteng@loongson.cn>
    net: stmmac: dwmac-loongson: Init ref and PTP clocks rate

Baochen Qiang <quic_bqiang@quicinc.com>
    wifi: ath12k: fix invalid AMPDU factor calculation in ath12k_peer_assoc_h_he()

P Praneesh <quic_ppranees@quicinc.com>
    wifi: ath12k: match WMI BSS chan info structure with firmware definition

P Praneesh <quic_ppranees@quicinc.com>
    wifi: ath12k: fix BSS chan info request WMI command

Toke Høiland-Jørgensen <toke@redhat.com>
    wifi: ath9k: Remove error checks when creating debugfs entries

Arend van Spriel <arend.vanspriel@broadcom.com>
    wifi: brcmfmac: introducing fwil query functions

Arend van Spriel <arend.vanspriel@broadcom.com>
    wifi: brcmfmac: export firmware interface functions

Aleksandr Mishin <amishin@t-argos.ru>
    ACPI: PMIC: Remove unneeded check in tps68470_pmic_opregion_probe()

Helge Deller <deller@kernel.org>
    crypto: xor - fix template benchmarking

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: rtw88: always wait for both firmware loading attempts

Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
    EDAC/synopsys: Fix error injection on Zynq UltraScale+

Serge Semin <fancer.lancer@gmail.com>
    EDAC/synopsys: Fix ECC status and IRQ control race condition


-------------

Diffstat:

 .gitignore                                         |   1 -
 .../ABI/testing/sysfs-bus-iio-filter-admv8818      |   2 +-
 Documentation/arch/arm64/silicon-errata.rst        |   2 +
 .../iio/magnetometer/asahi-kasei,ak8975.yaml       |   1 -
 .../devicetree/bindings/spi/spi-nxp-fspi.yaml      |  19 +-
 Documentation/driver-api/ipmi.rst                  |   2 +-
 Documentation/virt/kvm/locking.rst                 |  33 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/microchip/sam9x60.dtsi           |   4 +-
 arch/arm/boot/dts/microchip/sama7g5.dtsi           |   2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts          |   2 +-
 arch/arm/boot/dts/nxp/imx/imx7d-zii-rmu2.dts       |   2 +-
 arch/arm/mach-ep93xx/clock.c                       |   2 +-
 arch/arm/mach-versatile/platsmp-realview.c         |   1 +
 arch/arm/vfp/vfpinstr.h                            |  44 +-
 arch/arm64/Kconfig                                 |   2 +-
 .../boot/dts/exynos/exynos7885-jackpotlte.dts      |   2 +-
 arch/arm64/boot/dts/mediatek/mt8186.dtsi           |  12 +-
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi    |   1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           |  12 +-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              |   2 +
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi        |   4 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi         |   4 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi         |   4 +-
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |   4 +-
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts  |   2 +-
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts |   4 +-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             |   4 +-
 arch/arm64/include/asm/cputype.h                   |   2 +
 arch/arm64/include/asm/esr.h                       |  88 +--
 arch/arm64/include/uapi/asm/sigcontext.h           |   6 +-
 arch/arm64/kernel/cpu_errata.c                     |  10 +-
 arch/arm64/kvm/hyp/nvhe/ffa.c                      |  21 +-
 arch/m68k/kernel/process.c                         |   2 +-
 arch/powerpc/crypto/Kconfig                        |   1 +
 arch/powerpc/include/asm/asm-compat.h              |   6 +
 arch/powerpc/include/asm/atomic.h                  |   5 +-
 arch/powerpc/include/asm/uaccess.h                 |   7 +-
 arch/powerpc/kernel/head_8xx.S                     |   6 +-
 arch/powerpc/kernel/vdso/gettimeofday.S            |   4 -
 arch/powerpc/mm/nohash/8xx.c                       |   4 +-
 arch/riscv/include/asm/kvm_vcpu_pmu.h              |  21 +-
 arch/riscv/kernel/perf_callchain.c                 |   2 +-
 arch/riscv/kvm/vcpu_sbi.c                          |   4 +-
 arch/x86/coco/tdx/tdx.c                            |   6 +
 arch/x86/events/intel/pt.c                         |  15 +-
 arch/x86/include/asm/acpi.h                        |   8 +
 arch/x86/include/asm/hardirq.h                     |   8 +-
 arch/x86/include/asm/idtentry.h                    |  73 +-
 arch/x86/kernel/acpi/boot.c                        |  11 +
 arch/x86/kernel/cpu/sgx/main.c                     |  27 +-
 arch/x86/kernel/jailhouse.c                        |   1 +
 arch/x86/kernel/mmconf-fam10h_64.c                 |   1 +
 arch/x86/kernel/process_64.c                       |  29 +-
 arch/x86/kernel/smpboot.c                          |   1 +
 arch/x86/kernel/x86_init.c                         |   1 +
 arch/x86/kvm/lapic.c                               |  35 +-
 arch/x86/mm/tlb.c                                  |   7 +-
 arch/x86/pci/fixup.c                               |   4 +-
 arch/x86/xen/mmu_pv.c                              |   5 +-
 arch/x86/xen/p2m.c                                 |  98 +++
 arch/x86/xen/setup.c                               | 203 ++++--
 arch/x86/xen/xen-ops.h                             |   6 +-
 block/bfq-iosched.c                                |  81 +-
 block/partitions/core.c                            |   8 +-
 crypto/asymmetric_keys/asymmetric_type.c           |   7 +-
 crypto/xor.c                                       |  31 +-
 drivers/acpi/cppc_acpi.c                           |  43 +-
 drivers/acpi/device_sysfs.c                        |   5 +-
 drivers/acpi/pmic/tps68470_pmic.c                  |   6 +-
 drivers/acpi/resource.c                            |   6 +
 drivers/ata/libata-eh.c                            |   8 +
 drivers/ata/libata-scsi.c                          |   5 +-
 drivers/base/core.c                                |  15 +-
 drivers/base/firmware_loader/main.c                |  30 +
 drivers/base/module.c                              |  14 +-
 drivers/base/power/domain.c                        |   2 +-
 drivers/block/drbd/drbd_main.c                     |   8 +-
 drivers/block/drbd/drbd_state.c                    |   2 +-
 drivers/block/nbd.c                                |  13 +-
 drivers/block/ublk_drv.c                           |  62 +-
 drivers/bluetooth/btusb.c                          |   5 +-
 drivers/bus/arm-integrator-lm.c                    |   1 +
 drivers/bus/mhi/host/pci_generic.c                 |  13 +-
 drivers/char/hw_random/bcm2835-rng.c               |   4 +-
 drivers/char/hw_random/cctrng.c                    |   1 +
 drivers/char/hw_random/mtk-rng.c                   |   2 +-
 drivers/char/tpm/tpm-dev-common.c                  |   2 +
 drivers/char/tpm/tpm2-space.c                      |   3 +
 drivers/clk/at91/sama7g5.c                         |   5 +-
 drivers/clk/imx/clk-composite-7ulp.c               |   7 +
 drivers/clk/imx/clk-composite-8m.c                 |  61 +-
 drivers/clk/imx/clk-composite-93.c                 |  15 +-
 drivers/clk/imx/clk-fracn-gppll.c                  |   4 +
 drivers/clk/imx/clk-imx6ul.c                       |   4 +-
 drivers/clk/imx/clk-imx8mp-audiomix.c              |  13 +-
 drivers/clk/imx/clk-imx8mp.c                       |   4 +-
 drivers/clk/imx/clk-imx8qxp.c                      |  10 +-
 drivers/clk/qcom/clk-alpha-pll.c                   |  52 ++
 drivers/clk/qcom/clk-alpha-pll.h                   |   2 +
 drivers/clk/qcom/dispcc-sm8250.c                   |   9 +-
 drivers/clk/qcom/dispcc-sm8550.c                   |  14 +-
 drivers/clk/qcom/gcc-ipq5332.c                     |   1 +
 drivers/clk/rockchip/clk-rk3228.c                  |   2 +-
 drivers/clk/rockchip/clk-rk3588.c                  |   2 +-
 drivers/clk/starfive/clk-starfive-jh7110-vout.c    |   2 +-
 drivers/clk/ti/clk-dra7-atl.c                      |   1 +
 drivers/clocksource/timer-qcom.c                   |   7 +-
 drivers/cpufreq/ti-cpufreq.c                       |  10 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c                |  21 +-
 drivers/crypto/caam/caamhash.c                     |   1 +
 drivers/crypto/ccp/sev-dev.c                       |   2 +
 drivers/crypto/hisilicon/hpre/hpre_main.c          |  54 +-
 drivers/crypto/hisilicon/qm.c                      | 151 ++--
 drivers/crypto/hisilicon/sec2/sec_main.c           |  16 +-
 drivers/crypto/hisilicon/zip/zip_main.c            |  23 +-
 drivers/cxl/core/pci.c                             |   8 +-
 drivers/edac/igen6_edac.c                          |   2 +-
 drivers/edac/synopsys_edac.c                       |  85 ++-
 drivers/firewire/core-cdev.c                       |   2 +-
 drivers/firmware/arm_scmi/optee.c                  |   7 +
 drivers/firmware/efi/libstub/tpm.c                 |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h        |   4 +-
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     |  29 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  16 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h            |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |   6 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |   5 +-
 .../drm/amd/display/modules/freesync/freesync.c    |   2 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |  35 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  32 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |  12 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h              |   2 +
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c          |  30 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c           |   2 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |  12 +-
 drivers/gpu/drm/radeon/evergreen_cs.c              |  62 +-
 drivers/gpu/drm/radeon/radeon_atombios.c           |  29 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   4 +-
 drivers/gpu/drm/stm/drv.c                          |   4 +-
 drivers/gpu/drm/stm/ltdc.c                         |   2 +
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |  13 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                 |   3 +
 drivers/hid/wacom_wac.c                            |  13 +-
 drivers/hid/wacom_wac.h                            |   2 +-
 drivers/hwmon/max16065.c                           |  27 +-
 drivers/hwmon/ntc_thermistor.c                     |   1 +
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   2 +-
 drivers/i2c/busses/i2c-aspeed.c                    |  16 +-
 drivers/i2c/busses/i2c-isch.c                      |   3 +-
 drivers/iio/adc/ad7606.c                           |   8 +-
 drivers/iio/adc/ad7606_spi.c                       |   5 +-
 drivers/iio/chemical/bme680_core.c                 |   7 +
 drivers/iio/magnetometer/ak8975.c                  |  85 +--
 drivers/infiniband/core/cache.c                    |   4 +-
 drivers/infiniband/core/iwcm.c                     |   2 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |   5 +
 drivers/infiniband/hw/erdma/erdma_verbs.c          |  25 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |  22 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  33 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |  16 +-
 drivers/infiniband/hw/irdma/verbs.c                |   2 +-
 drivers/infiniband/hw/mlx5/main.c                  |   2 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  14 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |   9 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |   1 +
 drivers/input/keyboard/adp5588-keys.c              |   2 +-
 drivers/input/serio/i8042-acpipnpio.h              |  37 +
 drivers/input/touchscreen/ilitek_ts_i2c.c          |  18 +-
 drivers/interconnect/icc-clk.c                     |   3 +-
 drivers/iommu/amd/io_pgtable_v2.c                  |   2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  28 +
 drivers/iommu/iommufd/io_pagetable.c               |   8 +
 drivers/leds/leds-bd2606mvv.c                      |  23 +-
 drivers/leds/leds-pca995x.c                        |  78 +-
 drivers/md/dm-rq.c                                 |   4 +-
 drivers/md/dm-verity-target.c                      |  23 +-
 drivers/md/dm.c                                    |  11 +-
 drivers/media/dvb-frontends/rtl2830.c              |   2 +-
 drivers/media/dvb-frontends/rtl2832.c              |   2 +-
 .../vcodec/decoder/vdec/vdec_h264_req_if.c         |   9 +-
 .../vcodec/decoder/vdec/vdec_h264_req_multi_if.c   |   9 +-
 .../mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c |  10 +-
 .../media/platform/renesas/rzg2l-cru/rzg2l-csi2.c  |   1 +
 drivers/media/tuners/tuner-i2c.h                   |   4 +-
 drivers/mtd/devices/powernv_flash.c                |   3 +
 drivers/mtd/devices/slram.c                        |   2 +
 drivers/mtd/nand/raw/mtk_nand.c                    |  36 +-
 drivers/net/bareudp.c                              |  26 +-
 drivers/net/bonding/bond_main.c                    |   6 +-
 drivers/net/can/m_can/m_can.c                      |  14 +-
 drivers/net/can/usb/esd_usb.c                      |   6 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |   3 +-
 drivers/net/ethernet/realtek/r8169_phy_config.c    |   2 +
 drivers/net/ethernet/seeq/ether3.c                 |   2 +
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   3 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  37 +-
 drivers/net/usb/usbnet.c                           |  37 +-
 drivers/net/virtio_net.c                           |  10 +-
 drivers/net/wireless/ath/ath12k/mac.c              |   5 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   1 +
 drivers/net/wireless/ath/ath12k/wmi.h              |   3 +-
 drivers/net/wireless/ath/ath9k/debug.c             |   2 -
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |   2 -
 .../wireless/broadcom/brcm80211/brcmfmac/btcoex.c  |   2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  26 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwil.c    | 115 +--
 .../wireless/broadcom/brcm80211/brcmfmac/fwil.h    | 145 +++-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |  11 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |  36 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |   3 +
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  65 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  23 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |   4 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |   4 +-
 drivers/net/wireless/realtek/rtw88/coex.c          |  38 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |  13 +-
 drivers/net/wireless/realtek/rtw88/main.c          |   7 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c     |   2 -
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |  12 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c                 |   2 +-
 drivers/ntb/ntb_transport.c                        |  23 +-
 drivers/ntb/test/ntb_perf.c                        |   2 +-
 drivers/nvdimm/namespace_devs.c                    |  34 +-
 drivers/nvme/host/multipath.c                      |   2 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |   3 +-
 drivers/pci/controller/dwc/pci-imx6.c              |   7 +-
 drivers/pci/controller/dwc/pci-keystone.c          |   2 +-
 drivers/pci/controller/dwc/pcie-kirin.c            |   4 +-
 drivers/pci/controller/pcie-xilinx-nwl.c           |  39 +-
 drivers/pci/pci.c                                  |  20 +-
 drivers/pci/pci.h                                  |   6 +-
 drivers/pci/quirks.c                               |  31 +-
 drivers/perf/alibaba_uncore_drw_pmu.c              |   2 +-
 drivers/perf/arm-cmn.c                             | 242 +++---
 drivers/perf/hisilicon/hisi_pcie_pmu.c             |  16 +-
 drivers/pinctrl/bcm/pinctrl-ns.c                   |   8 +-
 drivers/pinctrl/berlin/berlin-bg2.c                |   8 +-
 drivers/pinctrl/berlin/berlin-bg2cd.c              |   8 +-
 drivers/pinctrl/berlin/berlin-bg2q.c               |   8 +-
 drivers/pinctrl/berlin/berlin-bg4ct.c              |   9 +-
 drivers/pinctrl/berlin/pinctrl-as370.c             |   9 +-
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c         |   9 +-
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c         |   9 +-
 drivers/pinctrl/mvebu/pinctrl-armada-ap806.c       |   5 +-
 drivers/pinctrl/mvebu/pinctrl-armada-cp110.c       |   6 +-
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c          |   9 +-
 drivers/pinctrl/mvebu/pinctrl-dove.c               |  48 +-
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c           |   7 +-
 drivers/pinctrl/mvebu/pinctrl-orion.c              |   7 +-
 drivers/pinctrl/nomadik/pinctrl-abx500.c           |   9 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |  10 +-
 drivers/pinctrl/pinctrl-at91.c                     |  11 +-
 drivers/pinctrl/pinctrl-single.c                   |   3 +-
 drivers/pinctrl/pinctrl-xway.c                     |  11 +-
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c            | 113 ++-
 drivers/power/supply/axp20x_battery.c              |  16 +-
 drivers/power/supply/max17042_battery.c            |   5 +-
 drivers/powercap/intel_rapl_common.c               |   2 +-
 drivers/pps/clients/pps_parport.c                  |  14 +-
 drivers/regulator/of_regulator.c                   |   2 +-
 drivers/remoteproc/imx_rproc.c                     |   6 +-
 drivers/reset/reset-berlin.c                       |   3 +-
 drivers/reset/reset-k210.c                         |   3 +-
 drivers/scsi/NCR5380.c                             |  78 +-
 drivers/scsi/elx/libefc/efc_nport.c                |   2 +-
 drivers/scsi/mac_scsi.c                            | 166 ++---
 drivers/scsi/sd.c                                  |   2 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |  20 +-
 drivers/soc/fsl/qe/tsa.c                           |   2 +-
 drivers/soc/qcom/smd-rpm.c                         |  35 +-
 drivers/soc/versatile/soc-integrator.c             |   1 +
 drivers/soc/versatile/soc-realview.c               |  20 +-
 drivers/spi/atmel-quadspi.c                        |  15 +-
 drivers/spi/spi-bcmbca-hsspi.c                     |   8 +-
 drivers/spi/spi-fsl-lpspi.c                        |   1 +
 drivers/spi/spi-nxp-fspi.c                         |  54 +-
 drivers/spi/spi-ppc4xx.c                           |   7 +-
 drivers/thunderbolt/switch.c                       | 331 +++++++--
 drivers/thunderbolt/tb.c                           | 812 ++++++++++++++++-----
 drivers/thunderbolt/tb.h                           |  56 +-
 drivers/thunderbolt/tb_regs.h                      |   9 +-
 drivers/thunderbolt/tunnel.c                       | 217 ++++--
 drivers/thunderbolt/tunnel.h                       |  26 +-
 drivers/thunderbolt/usb4.c                         | 116 ++-
 drivers/tty/serial/8250/8250_omap.c                |   2 +-
 drivers/tty/serial/qcom_geni_serial.c              |  31 +-
 drivers/tty/serial/rp2.c                           |   2 +-
 drivers/tty/serial/serial_core.c                   |  14 +-
 drivers/ufs/host/ufs-qcom.c                        |   2 +-
 drivers/usb/cdns3/cdnsp-ring.c                     |   6 +-
 drivers/usb/cdns3/host.c                           |   4 +-
 drivers/usb/class/cdc-acm.c                        |   2 +
 drivers/usb/dwc2/drd.c                             |   9 +
 drivers/usb/host/xhci-mem.c                        |   5 +-
 drivers/usb/host/xhci-pci.c                        |  17 +-
 drivers/usb/host/xhci-ring.c                       |  14 +
 drivers/usb/host/xhci.h                            |   3 +
 drivers/usb/misc/appledisplay.c                    |  15 +-
 drivers/usb/misc/cypress_cy7c63.c                  |   4 +
 drivers/usb/misc/yurex.c                           |  24 +-
 drivers/vhost/vdpa.c                               |  16 +-
 drivers/video/fbdev/hpfb.c                         |   1 +
 drivers/watchdog/imx_sc_wdt.c                      |  24 -
 drivers/xen/swiotlb-xen.c                          |  10 +-
 fs/btrfs/btrfs_inode.h                             |  47 +-
 fs/btrfs/ctree.h                                   |   2 +
 fs/btrfs/extent-tree.c                             |   4 +-
 fs/btrfs/file.c                                    |  34 +-
 fs/btrfs/ioctl.c                                   |   4 +-
 fs/btrfs/subpage.c                                 |  10 +-
 fs/btrfs/tree-checker.c                            |   2 +-
 fs/cachefiles/xattr.c                              |  34 +-
 fs/crypto/fname.c                                  |   8 +-
 fs/ecryptfs/crypto.c                               |  10 -
 fs/erofs/inode.c                                   |  20 +-
 fs/ext4/ialloc.c                                   |  14 +-
 fs/ext4/inline.c                                   |  35 +-
 fs/ext4/mballoc.c                                  |  10 +-
 fs/ext4/super.c                                    |  29 +-
 fs/f2fs/compress.c                                 |  87 ++-
 fs/f2fs/data.c                                     |  14 +-
 fs/f2fs/dir.c                                      |   3 +-
 fs/f2fs/extent_cache.c                             |   4 +-
 fs/f2fs/f2fs.h                                     |  48 +-
 fs/f2fs/file.c                                     | 167 +++--
 fs/f2fs/inode.c                                    |   5 +
 fs/f2fs/namei.c                                    |  69 --
 fs/f2fs/segment.c                                  |   8 +
 fs/f2fs/super.c                                    |  20 +-
 fs/f2fs/xattr.c                                    |  14 +-
 fs/fcntl.c                                         |  14 +-
 fs/inode.c                                         |   4 +
 fs/jfs/jfs_dmap.c                                  |   4 +-
 fs/jfs/jfs_imap.c                                  |   2 +-
 fs/namei.c                                         |   6 +-
 fs/namespace.c                                     |  14 +-
 fs/nfs/nfs4state.c                                 |   1 +
 fs/nfsd/filecache.c                                |   3 +-
 fs/nfsd/nfs4idmap.c                                |  13 +-
 fs/nfsd/nfs4recover.c                              |   8 +
 fs/nilfs2/btree.c                                  |  12 +-
 fs/smb/server/vfs.c                                |  19 +-
 include/acpi/cppc_acpi.h                           |   2 +
 include/linux/bitmap.h                             |  77 ++
 include/linux/bpf.h                                |   7 +-
 include/linux/f2fs_fs.h                            |   2 +-
 include/linux/fs.h                                 |  11 +
 include/linux/mm.h                                 |   4 +-
 include/linux/mm_types.h                           |  31 +-
 include/linux/sbitmap.h                            |   2 +-
 include/linux/sched/numa_balancing.h               |  10 +
 include/linux/usb/usbnet.h                         |  15 +
 include/linux/xarray.h                             |   6 +
 include/net/bluetooth/hci_core.h                   |   4 +-
 include/net/ip.h                                   |   2 +
 include/net/mac80211.h                             |   7 +-
 include/net/tcp.h                                  |  21 +-
 include/sound/tas2781.h                            |   8 +-
 include/trace/events/f2fs.h                        |   3 +-
 include/trace/events/sched.h                       |  52 ++
 io_uring/io-wq.c                                   |  25 +-
 io_uring/io_uring.c                                |   4 +-
 io_uring/sqpoll.c                                  |  12 +
 kernel/bpf/btf.c                                   |   8 +
 kernel/bpf/helpers.c                               |  12 +-
 kernel/bpf/syscall.c                               |   4 +-
 kernel/bpf/verifier.c                              |  57 +-
 kernel/kthread.c                                   |  10 +-
 kernel/locking/lockdep.c                           |  50 +-
 kernel/module/Makefile                             |   2 +-
 kernel/padata.c                                    |   6 +-
 kernel/rcu/tree_nocb.h                             |   5 +-
 kernel/sched/fair.c                                | 134 +++-
 kernel/trace/bpf_trace.c                           |  15 +-
 lib/debugobjects.c                                 |   5 +-
 lib/sbitmap.c                                      |   4 +-
 lib/test_xarray.c                                  |  93 +++
 lib/xarray.c                                       |  53 +-
 lib/xz/xz_crc32.c                                  |   2 +-
 lib/xz/xz_private.h                                |   4 -
 mm/damon/vaddr.c                                   |   2 +
 mm/filemap.c                                       |  50 +-
 mm/mmap.c                                          |   4 +
 mm/util.c                                          |   2 +-
 net/bluetooth/hci_conn.c                           |   6 +-
 net/bluetooth/hci_sync.c                           |   5 +-
 net/bluetooth/mgmt.c                               |  13 +-
 net/can/bcm.c                                      |   4 +-
 net/can/j1939/transport.c                          |   8 +-
 net/core/filter.c                                  |  50 +-
 net/core/sock_map.c                                |   1 +
 net/ipv4/icmp.c                                    | 103 +--
 net/ipv6/Kconfig                                   |   1 +
 net/ipv6/icmp.c                                    |  28 +-
 net/ipv6/netfilter/nf_reject_ipv6.c                |  14 +-
 net/ipv6/route.c                                   |   2 +-
 net/ipv6/rpl_iptunnel.c                            |  12 +-
 net/mac80211/iface.c                               |  17 +-
 net/mac80211/offchannel.c                          |   1 +
 net/mac80211/rate.c                                |   2 +-
 net/mac80211/scan.c                                |   2 +-
 net/mac80211/tx.c                                  |   2 +-
 net/netfilter/nf_conntrack_netlink.c               |   7 +-
 net/netfilter/nf_tables_api.c                      |  16 +-
 net/qrtr/af_qrtr.c                                 |   2 +-
 net/tipc/bcast.c                                   |   2 +-
 net/wireless/nl80211.c                             |   3 +-
 net/wireless/scan.c                                |   6 +-
 net/wireless/sme.c                                 |   3 +-
 samples/bpf/Makefile                               |   6 +-
 security/bpf/hooks.c                               |   1 -
 security/smack/smackfs.c                           |   2 +-
 sound/pci/hda/cs35l41_hda_spi.c                    |   1 +
 sound/pci/hda/tas2781_hda_i2c.c                    |  14 +-
 sound/soc/codecs/rt5682.c                          |   4 +-
 sound/soc/codecs/rt5682s.c                         |   4 +-
 sound/soc/codecs/tas2781-comlib.c                  |   4 -
 sound/soc/codecs/tas2781-fmwlib.c                  |   1 -
 sound/soc/codecs/tas2781-i2c.c                     |  56 +-
 sound/soc/loongson/loongson_card.c                 |   4 +-
 tools/bpf/runqslower/Makefile                      |   3 +-
 tools/lib/bpf/bpf.c                                |   4 +-
 tools/lib/bpf/bpf.h                                |   4 +-
 tools/lib/bpf/libbpf.c                             | 246 +++++--
 tools/lib/bpf/libbpf_internal.h                    |  14 +
 tools/lib/bpf/libbpf_probes.c                      |   1 +
 tools/perf/builtin-annotate.c                      |   2 +-
 tools/perf/builtin-inject.c                        |   1 +
 tools/perf/builtin-mem.c                           |   1 +
 tools/perf/builtin-report.c                        |  11 +-
 tools/perf/builtin-sched.c                         |   8 +-
 tools/perf/builtin-top.c                           |   3 +-
 tools/perf/ui/browsers/annotate.c                  |  77 +-
 tools/perf/ui/browsers/hists.c                     |  34 +-
 tools/perf/ui/browsers/hists.h                     |   2 -
 tools/perf/util/annotate.c                         | 118 +--
 tools/perf/util/annotate.h                         |  39 +-
 tools/perf/util/block-info.c                       |  10 +-
 tools/perf/util/block-info.h                       |   3 +-
 tools/perf/util/hist.h                             |  25 +-
 tools/perf/util/machine.c                          |  17 +-
 tools/perf/util/session.c                          |   3 +
 tools/perf/util/sort.c                             |  14 +-
 tools/perf/util/stat-display.c                     |   3 +-
 tools/perf/util/thread.c                           |   4 +
 tools/perf/util/thread.h                           |   1 +
 tools/perf/util/time-utils.c                       |   4 +-
 tools/perf/util/tool.h                             |   1 +
 tools/power/cpupower/lib/powercap.c                |   8 +
 tools/testing/selftests/arm64/signal/Makefile      |   2 +-
 tools/testing/selftests/arm64/signal/sve_helpers.c |  56 ++
 tools/testing/selftests/arm64/signal/sve_helpers.h |  21 +
 .../testcases/fake_sigreturn_sme_change_vl.c       |  46 +-
 .../testcases/fake_sigreturn_sve_change_vl.c       |  30 +-
 .../selftests/arm64/signal/testcases/ssve_regs.c   |  36 +-
 .../arm64/signal/testcases/ssve_za_regs.c          |  36 +-
 .../selftests/arm64/signal/testcases/sve_regs.c    |  32 +-
 .../selftests/arm64/signal/testcases/za_no_regs.c  |  32 +-
 .../selftests/arm64/signal/testcases/za_regs.c     |  36 +-
 tools/testing/selftests/bpf/Makefile               |  30 +-
 tools/testing/selftests/bpf/bench.c                |   1 +
 tools/testing/selftests/bpf/bench.h                |   1 +
 .../selftests/bpf/map_tests/sk_storage_map.c       |   2 +-
 tools/testing/selftests/bpf/network_helpers.c      |  24 +
 tools/testing/selftests/bpf/network_helpers.h      |   4 +
 .../selftests/bpf/prog_tests/bpf_iter_setsockopt.c |   2 +-
 .../testing/selftests/bpf/prog_tests/core_reloc.c  |   1 +
 .../selftests/bpf/prog_tests/decap_sanity.c        |   1 -
 .../selftests/bpf/prog_tests/flow_dissector.c      |   3 +-
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c |   1 +
 .../testing/selftests/bpf/prog_tests/lwt_helpers.h |   2 -
 .../selftests/bpf/prog_tests/lwt_redirect.c        |   2 +-
 .../testing/selftests/bpf/prog_tests/lwt_reroute.c |   2 +
 .../selftests/bpf/prog_tests/ns_current_pid_tgid.c | 156 +++-
 .../selftests/bpf/prog_tests/parse_tcp_hdr_opt.c   |   1 +
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c |   1 -
 .../testing/selftests/bpf/prog_tests/tc_redirect.c |  12 +-
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c   |   1 +
 .../selftests/bpf/prog_tests/user_ringbuf.c        |   1 +
 .../testing/selftests/bpf/progs/cg_storage_multi.h |   2 -
 .../bpf/progs/test_libbpf_get_fd_by_id_opts.c      |   1 +
 .../selftests/bpf/progs/test_ns_current_pid_tgid.c |  17 +-
 tools/testing/selftests/bpf/test_cpp.cpp           |   4 +
 tools/testing/selftests/bpf/test_lru_map.c         |   3 +-
 tools/testing/selftests/bpf/test_progs.c           |  18 +-
 tools/testing/selftests/bpf/testing_helpers.c      |   4 +-
 tools/testing/selftests/bpf/unpriv_helpers.c       |   1 -
 tools/testing/selftests/bpf/veristat.c             |   8 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |  14 -
 .../ftrace/test.d/kprobe/kprobe_args_char.tc       |   2 +-
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   2 +-
 virt/kvm/kvm_main.c                                |  31 +-
 508 files changed, 6523 insertions(+), 3354 deletions(-)



