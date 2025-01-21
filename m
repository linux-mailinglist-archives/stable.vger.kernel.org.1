Return-Path: <stable+bounces-109869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D63A1843A
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 505587A18B7
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C751A1F7547;
	Tue, 21 Jan 2025 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IanTBTv1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D381F7081;
	Tue, 21 Jan 2025 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482677; cv=none; b=l96Vj5QKG9O1OFcz3X83qMRud4QfQfBqnhjskTBj7LR1BWk1krPauJKbrCFWjaq2Kczl2sjD5T3qxzIbItcSzKLv78o+XEUqxg3lxluLgj1+BUDWO+Mk9OIL3v/WHJFu3fWZLFrSu9Dg6lm4txUNLBJcy68Lm0a4kGaUjGl61PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482677; c=relaxed/simple;
	bh=bnSsB/f9X6a1ITzPvPjyEaUJYb5n9eb7OSw/96vmuWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YGmEQeNO3QAk1UlyFgJzXzGypcaYdWM87XZiGM+E0m+x/YTG10pu0g/SS+bwmZ2PgbwjeNllHo7fvE4CgIUEifW0k/oYFt99XAEHOgsOUPgezoShbF0q8hHmCaHxdPgS1dO5Poe6KyRKI08xC8ObUqmA3OSDyaJbzxMGIOdlxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IanTBTv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8435C4CEDF;
	Tue, 21 Jan 2025 18:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482677;
	bh=bnSsB/f9X6a1ITzPvPjyEaUJYb5n9eb7OSw/96vmuWA=;
	h=From:To:Cc:Subject:Date:From;
	b=IanTBTv1ihUuLG7Oia1+gRDYgzakyd5w54irA6cTp/xVhQfpKfm8bYPgdckhStK9F
	 VIMs7wVfDrylo0iusSnfo6Eevik65RlXu1RycyNo4aOGW0pDlZezfRxxhwp3OXC1gb
	 2yrNGl2sMHiN9x7MEiwic/T32n0rA/FCkem40/9M=
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
Subject: [PATCH 6.1 00/64] 6.1.127-rc1 review
Date: Tue, 21 Jan 2025 18:51:59 +0100
Message-ID: <20250121174521.568417761@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.127-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.127-rc1
X-KernelTest-Deadline: 2025-01-23T17:45+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.127 release.
There are 64 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 23 Jan 2025 17:45:02 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.127-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.127-rc1

Wang Liang <wangliang74@huawei.com>
    net: fix data-races around sk->sk_forward_alloc

Juergen Gross <jgross@suse.com>
    x86/xen: fix SLS mitigation in xen_hypercall_iret()

Youzhong Yang <youzhong@gmail.com>
    nfsd: add list_head nf_gc to struct nfsd_file

Gao Xiang <xiang@kernel.org>
    erofs: handle NONHEAD !delta[1] lclusters gracefully

Gao Xiang <xiang@kernel.org>
    erofs: tidy up EROFS on-disk naming

Kang Yang <quic_kangyang@quicinc.com>
    wifi: ath10k: avoid NULL pointer error during sdio remove

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "regmap: detach regmap from dev on regmap_exit"

Suraj Sonawane <surajsonawane0215@gmail.com>
    scsi: sg: Fix slab-use-after-free read in sg_release()

Zhu Yanjun <yanjun.zhu@linux.dev>
    RDMA/rxe: Fix the qp flush warnings in req

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "drm/amdgpu: rework resume handling for display (v2)"

Yu Kuai <yukuai3@huawei.com>
    block: fix uaf for flush rq while iterating tags

Vitaly Prosyak <vitaly.prosyak@amd.com>
    drm/amdgpu: fix usage slab after free

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    iio: adc: rockchip_saradc: fix information leak in triggered buffer

Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
    iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on

Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
    iio: imu: inv_icm42600: fix spi burst write not supported

Terry Tritton <terry.tritton@linaro.org>
    Revert "PCI: Use preserve_config in place of pci_flags"

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/fb: Relax clear color alignment to 64 bytes

Koichiro Den <koichiro.den@canonical.com>
    hrtimers: Handle CPU state correctly on hotplug

Tomas Krcka <krckatom@amazon.de>
    irqchip/gic-v3-its: Don't enable interrupts in its_irq_set_vcpu_affinity()

Yogesh Lal <quic_ylal@quicinc.com>
    irqchip/gic-v3: Handle CPU_PM_ENTER_FAILED correctly

Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
    irqchip: Plug a OF node reference leak in platform_irqchip_probe()

Xiaolei Wang <xiaolei.wang@windriver.com>
    pmdomain: imx8mp-blk-ctrl: add missing loop break condition

Zhongqiu Han <quic_zhonhan@quicinc.com>
    gpiolib: cdev: Fix use after free in lineinfo_changed_notify

Rik van Riel <riel@surriel.com>
    fs/proc: fix softlockup in __read_vmcore (part 2)

Marco Nelissen <marco.nelissen@gmail.com>
    filemap: avoid truncating 64-bit offset to 32 bits

Stefano Garzarella <sgarzare@redhat.com>
    vsock: prevent null-ptr-deref in vsock_*[has_data|has_space]

Stefano Garzarella <sgarzare@redhat.com>
    vsock: reset socket state when de-assigning the transport

Stefano Garzarella <sgarzare@redhat.com>
    vsock/virtio: cancel close work in the destructor

Stefano Garzarella <sgarzare@redhat.com>
    vsock/virtio: discard packets if the transport changes

Heiner Kallweit <hkallweit1@gmail.com>
    net: ethernet: xgbe: re-add aneg to supported features in PHY quirks

Paolo Abeni <pabeni@redhat.com>
    selftests: mptcp: avoid spurious errors on disconnect

Paolo Abeni <pabeni@redhat.com>
    mptcp: be sure to send ack when mptcp-level window re-opens

Kairui Song <kasong@tencent.com>
    zram: fix potential UAF of zram table

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda/realtek: Add support for Ayaneo System using CS35L41 HDA

Juergen Gross <jgross@suse.com>
    x86/asm: Make serialize() always_inline

Oleg Nesterov <oleg@redhat.com>
    poll_wait: add mb() to fix theoretical race between waitqueue_active() and .poll()

Marco Nelissen <marco.nelissen@gmail.com>
    iomap: avoid avoid truncating 64-bit offset to 32 bits

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: acpi_dev_irq_override(): Check DMI match last

Jakub Kicinski <kuba@kernel.org>
    selftests: tc-testing: reduce rshift value

Manivannan Sadhasivam <mani@kernel.org>
    scsi: ufs: core: Honor runtime/system PM levels if set by host controller drivers

Max Kellermann <max.kellermann@ionos.com>
    cachefiles: Parse the "secctx" immediately

David Howells <dhowells@redhat.com>
    kheaders: Ignore silly-rename files

Zhang Kunbo <zhangkunbo@huawei.com>
    fs: fix missing declaration of init_files

Leo Stone <leocstone@gmail.com>
    hfs: Sanity check the root record

Lizhi Xu <lizhi.xu@windriver.com>
    mac802154: check local interfaces before deleting sdata list

Luis Chamberlain <mcgrof@kernel.org>
    nvmet: propagate npwg topology

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: rcar: fix NACK handling when being a target

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: mux: demux-pinctrl: check initial mux selection, too

Pratyush Yadav <pratyush@kernel.org>
    Revert "mtd: spi-nor: core: replace dummy buswidth from addr to data"

David Lechner <dlechner@baylibre.com>
    hwmon: (tmp513) Fix division of negative numbers

Maíra Canal <mcanal@igalia.com>
    drm/v3d: Ensure job pointer is set to NULL after job completion

Mark Zhang <markzhang@nvidia.com>
    net/mlx5: Clear port select structure when fail to create

Patrisious Haddad <phaddad@nvidia.com>
    net/mlx5: Fix RDMA TX steering prio

Sean Anderson <sean.anderson@linux.dev>
    net: xilinx: axienet: Fix IRQ coalescing packet count overflow

Dan Carpenter <dan.carpenter@linaro.org>
    nfp: bpf: prevent integer overflow in nfp_bpf_event_output()

Kuniyuki Iwashima <kuniyu@amazon.com>
    gtp: Destroy device along with udp socket's netns dismantle.

Kuniyuki Iwashima <kuniyu@amazon.com>
    gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().

Eric Dumazet <edumazet@google.com>
    gtp: use exit_batch_rtnl() method

Eric Dumazet <edumazet@google.com>
    net: add exit_batch_rtnl() method

Artem Chernyshev <artem.chernyshev@red-soft.ru>
    pktgen: Avoid out-of-bounds access in get_imix_entries

Ilya Maximets <i.maximets@ovn.org>
    openvswitch: fix lockup on tx to unregistering netdev with carrier

Michal Luczaj <mhal@rbox.co>
    bpf: Fix bpf_sk_select_reuseport() memory leak

Sudheer Kumar Doredla <s-doredla@ti.com>
    net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/x86/include/asm/special_insns.h               |   2 +-
 arch/x86/xen/xen-asm.S                             |   2 +-
 block/blk-sysfs.c                                  |   6 +-
 block/genhd.c                                      |   9 +-
 drivers/acpi/resource.c                            |   6 +-
 drivers/base/regmap/regmap.c                       |  12 --
 drivers/block/zram/zram_drv.c                      |   1 +
 drivers/gpio/gpiolib-cdev.c                        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  47 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   6 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |   2 +-
 drivers/gpu/drm/i915/display/intel_fb.c            |   2 +-
 drivers/gpu/drm/v3d/v3d_irq.c                      |   4 +
 drivers/hwmon/tmp513.c                             |   7 +-
 drivers/i2c/busses/i2c-rcar.c                      |  20 ++-
 drivers/i2c/muxes/i2c-demux-pinctrl.c              |   4 +-
 drivers/iio/adc/rockchip_saradc.c                  |   2 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |   1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  18 ++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |   3 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |   6 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +-
 drivers/irqchip/irq-gic-v3.c                       |   2 +-
 drivers/irqchip/irqchip.c                          |   4 +-
 drivers/mtd/spi-nor/core.c                         |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        |  19 +--
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   1 +
 .../net/ethernet/mellanox/mlx5/core/lag/port_sel.c |   4 +-
 drivers/net/ethernet/netronome/nfp/bpf/offload.c   |   3 +-
 drivers/net/ethernet/ti/cpsw_ale.c                 |  14 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   6 +
 drivers/net/gtp.c                                  |  42 +++---
 drivers/net/wireless/ath/ath10k/sdio.c             |   4 +-
 drivers/nvme/target/io-cmd-bdev.c                  |   2 +-
 drivers/pci/controller/pci-host-common.c           |   4 +
 drivers/pci/probe.c                                |  20 +--
 drivers/scsi/sg.c                                  |   2 +-
 drivers/soc/imx/imx8mp-blk-ctrl.c                  |   2 +-
 drivers/ufs/core/ufshcd.c                          |   9 +-
 fs/cachefiles/daemon.c                             |  14 +-
 fs/cachefiles/internal.h                           |   3 +-
 fs/cachefiles/security.c                           |   6 +-
 fs/erofs/erofs_fs.h                                | 143 +++++++++------------
 fs/erofs/zmap.c                                    | 133 ++++++++++---------
 fs/file.c                                          |   1 +
 fs/hfs/super.c                                     |   4 +-
 fs/iomap/buffered-io.c                             |   2 +-
 fs/nfsd/filecache.c                                |  18 +--
 fs/nfsd/filecache.h                                |   1 +
 fs/proc/vmcore.c                                   |   2 +
 include/linux/hrtimer.h                            |   1 +
 include/linux/poll.h                               |  10 +-
 include/net/net_namespace.h                        |   3 +
 kernel/cpu.c                                       |   2 +-
 kernel/gen_kheaders.sh                             |   1 +
 kernel/time/hrtimer.c                              |  11 +-
 mm/filemap.c                                       |   2 +-
 net/core/filter.c                                  |  30 +++--
 net/core/net_namespace.c                           |  31 ++++-
 net/core/pktgen.c                                  |   6 +-
 net/dccp/ipv6.c                                    |   2 +-
 net/ipv6/tcp_ipv6.c                                |   4 +-
 net/mac802154/iface.c                              |   4 +
 net/mptcp/options.c                                |   6 +-
 net/openvswitch/actions.c                          |   4 +-
 net/vmw_vsock/af_vsock.c                           |  18 +++
 net/vmw_vsock/virtio_transport_common.c            |  38 ++++--
 sound/pci/hda/patch_realtek.c                      |   1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |  43 +++++--
 .../tc-testing/tc-tests/filters/flow.json          |   4 +-
 71 files changed, 477 insertions(+), 379 deletions(-)



