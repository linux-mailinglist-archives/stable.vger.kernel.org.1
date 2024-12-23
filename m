Return-Path: <stable+bounces-105948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A77779FB26E
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43D81885D21
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E23E1A8F80;
	Mon, 23 Dec 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OTj5uKx4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF571865EB;
	Mon, 23 Dec 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970683; cv=none; b=bFhlE0gLxkWRrnmuS4DiD6iAnFjwRIDeP9b3Nl1RAzo83ZGrW5mNgBdu+qz4AnRX6Cehvo4Lnjex2Pg3dODvKcntelFjBNWdphjEtXFsvFIevZvF+PQozWINHAZohqU4bjI7WVgTKutGGUJci7Uj6WyJP+HOONg+bWUINs46NJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970683; c=relaxed/simple;
	bh=mfk6rdMbFrexC3Azwz1Bf41DZjznECH4MvWtm+sqlfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A6PPm/zOE+QNv3Gs0pyBqlaFaNPLlzbzdZkFur0cNGkTzGaFGtCObidcf2nP/Ll6hXFl3edCcvkTjOeQdRmTP21Re9oAYXg534wemV4ZnmCkDO87ej4TJf8MZunWaWQaGVVE7FQFoDleMwphrlyuFNZN9iP6bwLJRPaJrqQMkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OTj5uKx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FC5C4CED3;
	Mon, 23 Dec 2024 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734970682;
	bh=mfk6rdMbFrexC3Azwz1Bf41DZjznECH4MvWtm+sqlfc=;
	h=From:To:Cc:Subject:Date:From;
	b=OTj5uKx4Gtuh0CbD48DWX2/rnPEl6SFGD1tTIk5PkB8sWu5t2jACvO40fZAmDtq65
	 GYRWgysoX7N0FGLO5wDRmrNxuqXZI1WgwQa8VZ8fiWxaLCbZlU5OqwBAEBEJcAqmAs
	 zTtsM96rlDLVasSoFIYpLMTtSZpWrAyZXnSBuwqQ=
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
Subject: [PATCH 6.1 00/83] 6.1.122-rc1 review
Date: Mon, 23 Dec 2024 16:58:39 +0100
Message-ID: <20241223155353.641267612@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.122-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.122-rc1
X-KernelTest-Deadline: 2024-12-25T15:53+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.122 release.
There are 83 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.122-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.122-rc1

Michel Dänzer <mdaenzer@redhat.com>
    drm/amdgpu: Handle NULL bo->tbo.resource (again) in amdgpu_vm_bo_update

Francesco Dolcini <francesco.dolcini@toradex.com>
    dt-bindings: net: fec: add pps channel property

Pavel Begunkov <asml.silence@gmail.com>
    io_uring/rw: avoid punting to io-wq directly

Jens Axboe <axboe@kernel.dk>
    io_uring/rw: treat -EOPNOTSUPP for IOCB_NOWAIT like -EAGAIN

Jens Axboe <axboe@kernel.dk>
    io_uring/rw: split io_read() into a helper

Xuewen Yan <xuewen.yan@unisoc.com>
    epoll: Add synchronous wakeup support for ep_poll_callback

Jan Kara <jack@suse.cz>
    udf: Fix directory iteration for longer tail extents

Ilya Dryomov <idryomov@gmail.com>
    ceph: validate snapdirname option length when mounting

Zijun Hu <quic_zijuhu@quicinc.com>
    of: Fix refcount leakage for OF node returned by __of_get_dma_parent()

Herve Codina <herve.codina@bootlin.com>
    of: Fix error path in of_parse_phandle_with_args_map()

Jann Horn <jannh@google.com>
    udmabuf: also check for F_SEAL_FUTURE_WRITE

Edward Adam Davis <eadavis@qq.com>
    nilfs2: prevent use of deleted inode

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix buffer head leaks in calls to truncate_inode_pages()

Zijun Hu <quic_zijuhu@quicinc.com>
    of/irq: Fix using uninitialized variable @addr_len in API of_irq_parse_one()

Zijun Hu <quic_zijuhu@quicinc.com>
    of/irq: Fix interrupt-map cell length check in of_irq_parse_imap_parent()

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS/pnfs: Fix a live lock between recalled layouts and layoutget

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: check if iowq is killed before queuing

Jann Horn <jannh@google.com>
    io_uring: Fix registered ring file refcount leak

Tiezhu Yang <yangtiezhu@loongson.cn>
    selftests/bpf: Use asm constraint "m" for LoongArch

Steven Rostedt <rostedt@goodmis.org>
    tracing: Add "%s" check in test_event_printk()

Steven Rostedt <rostedt@goodmis.org>
    tracing: Add missing helper functions in event pointer dereference check

Steven Rostedt <rostedt@goodmis.org>
    tracing: Fix test_event_printk() to process entire print argument

Sean Christopherson <seanjc@google.com>
    KVM: x86: Play nice with protected guests in complete_hypercall_exit()

Michael Kelley <mhklinux@outlook.com>
    Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet

Qu Wenruo <wqu@suse.com>
    btrfs: tree-checker: reject inline extent items with 0 ref count

Kairui Song <kasong@tencent.com>
    zram: fix uninitialized ZRAM not releasing backing device

Kairui Song <kasong@tencent.com>
    zram: refuse to use zero sized block device as backing device

Geert Uytterhoeven <geert+renesas@glider.be>
    sh: clk: Fix clk_enable() to return 0 on NULL clk

Murad Masimov <m.masimov@maxima.ru>
    hwmon: (tmp513) Fix interpretation of values of Temperature Result and Limit Registers

Murad Masimov <m.masimov@maxima.ru>
    hwmon: (tmp513) Fix Current Register value interpretation

Murad Masimov <m.masimov@maxima.ru>
    hwmon: (tmp513) Fix interpretation of values of Shunt Voltage and Limit Registers

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    hwmon: (tmp513) Use SI constants from units.h

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    hwmon: (tmp513) Simplify with dev_err_probe()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    hwmon: (tmp513) Don't use "proxy" headers

Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
    drm/amdgpu: don't access invalid sched

Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
    i915/guc: Accumulate active runtime on gt reset

Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
    i915/guc: Ensure busyness counter increases motonically

Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
    i915/guc: Reset engine utilization buffer before registration

Yang Yingliang <yangyingliang@huawei.com>
    drm/panel: novatek-nt35950: fix return value check in nt35950_probe()

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/modes: Avoid divide by zero harder in drm_mode_vrefresh()

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Improve redrive mode handling

Daniele Palmas <dnlplm@gmail.com>
    USB: serial: option: add Telit FE910C04 rmnet compositions

Jack Wu <wojackbb@gmail.com>
    USB: serial: option: add MediaTek T7XX compositions

Mank Wang <mank.wang@netprisma.com>
    USB: serial: option: add Netprisma LCUK54 modules for WWAN Ready

Michal Hrusecky <michal.hrusecky@turris.com>
    USB: serial: option: add MeiG Smart SLM770A

Daniel Swanemar <d.swanemar@gmail.com>
    USB: serial: option: add TCL IK512 MBIM & ECM

Nathan Chancellor <nathan@kernel.org>
    hexagon: Disable constant extender optimization for LLVM prior to 19.1.0

James Bottomley <James.Bottomley@HansenPartnership.com>
    efivarfs: Fix error on non-existent file

Geert Uytterhoeven <geert+renesas@glider.be>
    i2c: riic: Always round-up when calculating bus period

Dan Carpenter <dan.carpenter@linaro.org>
    chelsio/chtls: prevent potential integer overflow on 32bit

Sean Christopherson <seanjc@google.com>
    KVM: x86: Cache CPUID.0xD XSTATE offsets+sizes during module init

Prathamesh Shete <pshete@nvidia.com>
    mmc: sdhci-tegra: Remove SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk

Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
    net: mdiobus: fix an OF node reference leak

Phil Sutter <phil@nwl.cc>
    netfilter: ipset: Fix for recursive locking warning

Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
    net: ethernet: bgmac-platform: fix an OF node reference leak

Dan Carpenter <dan.carpenter@linaro.org>
    net: hinic: Fix cleanup in create_rxqs/txqs()

Shannon Nelson <shannon.nelson@amd.com>
    ionic: use ee->offset when returning sprom data

Brett Creeley <brett.creeley@amd.com>
    ionic: Fix netdev notifier unregister on failure

Eric Dumazet <edumazet@google.com>
    netdevsim: prevent bad user input in nsim_dev_health_break_write()

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: mscc: ocelot: fix incorrect IFH SRC_PORT field in ocelot_ifh_set_basic()

Guangguan Wang <guangguan.wang@linux.alibaba.com>
    net/smc: check return value of sock_recvmsg when draining clc data

Guangguan Wang <guangguan.wang@linux.alibaba.com>
    net/smc: check smcd_v2_ext_offset when receiving proposal msg

Guangguan Wang <guangguan.wang@linux.alibaba.com>
    net/smc: check iparea_offset and ipv6_prefixes_cnt when receiving proposal msg

Guangguan Wang <guangguan.wang@linux.alibaba.com>
    net/smc: check sndbuf_space again after NOSPACE flag is set in smc_poll

Guangguan Wang <guangguan.wang@linux.alibaba.com>
    net/smc: protect link down work from execute after lgr freed

Huaisheng Ye <huaisheng.ye@intel.com>
    cxl/region: Fix region creation for greater than x2 switches

Vladimir Riabchun <ferr.lambarginio@gmail.com>
    i2c: pnx: Fix timeout in wait functions

Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
    p2sb: Do not scan and remove the P2SB device when it is unhidden

Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
    p2sb: Move P2SB hide and unhide code to p2sb_scan_and_cache()

Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
    p2sb: Introduce the global flag p2sb_hidden_by_bios

Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
    p2sb: Factor out p2sb_read_from_cache()

Hans de Goede <hdegoede@redhat.com>
    platform/x86: p2sb: Make p2sb_get_devfn() return void

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    PCI: Introduce pci_resource_n()

Peng Hongchi <hongchi.peng@siengine.com>
    usb: dwc2: gadget: Don't write invalid mapped sg entries into dma_desc with iommu enabled

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: Loongson64: DTS: Fix msi node for ls7a

Ajit Khaparde <ajit.khaparde@broadcom.com>
    PCI: Add ACS quirk for Broadcom BCM5760X NIC

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: Intel: sof_sdw: add quirk for Dell SKU 0B8C

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: Intel: sof_sdw: fix jack detection on ADL-N variant RVP

Roger Quadros <rogerq@kernel.org>
    usb: cdns3: Add quirk flag to enable suspend residency

Jiwei Sun <sunjw10@lenovo.com>
    PCI: vmd: Create domain symlink before pci_bus_add_devices()

Vidya Sagar <vidyas@nvidia.com>
    PCI: Use preserve_config in place of pci_flags

Kai-Heng Feng <kai.heng.feng@canonical.com>
    PCI/AER: Disable AER service on suspend

Lion Ackermann <nnamrec@gmail.com>
    net: sched: fix ordering of qlen adjustment


-------------

Diffstat:

 Documentation/devicetree/bindings/net/fsl,fec.yaml |   7 +
 Makefile                                           |   4 +-
 arch/hexagon/Makefile                              |   6 +
 .../boot/dts/loongson/loongson64g_4core_ls7a.dts   |   1 +
 arch/x86/kvm/cpuid.c                               |  31 +++-
 arch/x86/kvm/cpuid.h                               |   1 +
 arch/x86/kvm/x86.c                                 |   4 +-
 drivers/block/zram/zram_drv.c                      |  15 +-
 drivers/cxl/core/region.c                          |  25 ++-
 drivers/dma-buf/udmabuf.c                          |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   7 +-
 drivers/gpu/drm/drm_modes.c                        |  11 +-
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |   5 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |  41 ++++-
 drivers/gpu/drm/panel/panel-novatek-nt35950.c      |   4 +-
 drivers/hv/hv_kvp.c                                |   6 +
 drivers/hv/hv_snapshot.c                           |   6 +
 drivers/hv/hv_util.c                               |   9 +
 drivers/hv/hyperv_vmbus.h                          |   2 +
 drivers/hwmon/tmp513.c                             |  74 ++++----
 drivers/i2c/busses/i2c-pnx.c                       |   4 +-
 drivers/i2c/busses/i2c-riic.c                      |   2 +-
 drivers/mmc/host/sdhci-tegra.c                     |   1 -
 drivers/net/ethernet/broadcom/bgmac-platform.c     |   5 +-
 .../chelsio/inline_crypto/chtls/chtls_main.c       |   5 +-
 drivers/net/ethernet/huawei/hinic/hinic_main.c     |   2 +
 drivers/net/ethernet/mscc/ocelot.c                 |   2 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |   4 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   4 +-
 drivers/net/mdio/fwnode_mdio.c                     |  13 +-
 drivers/net/netdevsim/health.c                     |   2 +
 drivers/of/address.c                               |   2 +-
 drivers/of/base.c                                  |  15 +-
 drivers/of/irq.c                                   |   2 +
 drivers/pci/controller/pci-host-common.c           |   4 -
 drivers/pci/controller/vmd.c                       |   8 +-
 drivers/pci/pcie/aer.c                             |  18 ++
 drivers/pci/probe.c                                |  22 ++-
 drivers/pci/quirks.c                               |   4 +
 drivers/platform/x86/p2sb.c                        |  94 ++++++----
 drivers/sh/clk/core.c                              |   2 +-
 drivers/thunderbolt/tb.c                           |  41 +++++
 drivers/usb/cdns3/core.h                           |   1 +
 drivers/usb/cdns3/drd.c                            |  10 +-
 drivers/usb/cdns3/drd.h                            |   3 +
 drivers/usb/dwc2/gadget.c                          |   4 +-
 drivers/usb/serial/option.c                        |  27 +++
 fs/btrfs/tree-checker.c                            |  27 ++-
 fs/ceph/super.c                                    |   2 +
 fs/efivarfs/inode.c                                |   2 +-
 fs/efivarfs/internal.h                             |   1 -
 fs/efivarfs/super.c                                |   3 -
 fs/eventpoll.c                                     |   5 +-
 fs/nfs/pnfs.c                                      |   2 +-
 fs/nilfs2/btnode.c                                 |   1 +
 fs/nilfs2/gcinode.c                                |   2 +-
 fs/nilfs2/inode.c                                  |  13 +-
 fs/nilfs2/namei.c                                  |   5 +
 fs/nilfs2/nilfs.h                                  |   1 +
 fs/udf/directory.c                                 |   2 +-
 include/linux/hyperv.h                             |   1 +
 include/linux/io_uring.h                           |   4 +-
 include/linux/pci.h                                |  15 +-
 include/linux/wait.h                               |   1 +
 io_uring/io_uring.c                                |  13 +-
 io_uring/io_uring.h                                |   1 -
 io_uring/rw.c                                      |  31 +++-
 kernel/trace/trace_events.c                        | 199 ++++++++++++++++-----
 net/netfilter/ipset/ip_set_list_set.c              |   3 +
 net/sched/sch_cake.c                               |   2 +-
 net/sched/sch_choke.c                              |   2 +-
 net/smc/af_smc.c                                   |  15 +-
 net/smc/smc_clc.c                                  |   9 +
 net/smc/smc_clc.h                                  |  14 +-
 net/smc/smc_core.c                                 |   9 +-
 sound/soc/intel/boards/sof_sdw.c                   |  18 ++
 tools/testing/selftests/bpf/sdt.h                  |   2 +
 78 files changed, 734 insertions(+), 236 deletions(-)



