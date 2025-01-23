Return-Path: <stable+bounces-110307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418B1A1A8B3
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28663B1003
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA0313AA41;
	Thu, 23 Jan 2025 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j5shLkhU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909014D2BD;
	Thu, 23 Jan 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652338; cv=none; b=orRLlykNqBU3787qLrbZjg4aQ8Yr4DMvnZEwwTdDsfXnjqUhJ8hGthSa/yBxihlGBlk+tMvccp8ot8W28AgyooXQMXjmv/EA/AD7jlJMfPwJRe/kLr+wYUtjVM5DZGrGojaAfIe40fcLLewUUqI/FIEwG6k8yh595MWWMNuZ7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652338; c=relaxed/simple;
	bh=MEM+Tx7N75q3U8qP/HzO5u6OITxOALQ9EM2bKXiMRsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GjFGiggNGm1ZOkJ1umHqVPNJkN0uFbX3pH7dOQHO7HmeayPQlA0NITesB4UqIJr2/gOTfJd0XklunslfpaPF3HuLCfn7GQFl75k3uUcdrv6N1/xEpSPAyrRJQC+Il7LYCo2c5m6O13vCdS80t+qd2YBJGRJsigj5GqClkdmeQQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j5shLkhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762B3C4CED3;
	Thu, 23 Jan 2025 17:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737652337;
	bh=MEM+Tx7N75q3U8qP/HzO5u6OITxOALQ9EM2bKXiMRsc=;
	h=From:To:Cc:Subject:Date:From;
	b=j5shLkhU8gAT9Gyp171Khw+AwUQnQpq2HuBXv3ZaIQcQR3y/floA4W6+Y8w3vqIKT
	 7qw0TKNcJGlFn0c/tQUtT3c0uyIS++FUTxLusFP32P6aL1pj0+mKYT3QFiZQuZUiYI
	 L4B/oPZ9FPWS36+ChEZXXHGQG8M2whx9VCzmhJmY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.74
Date: Thu, 23 Jan 2025 18:12:13 +0100
Message-ID: <2025012313-reunion-lifter-4211@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.74 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                         |    2 
 arch/x86/include/asm/special_insns.h                             |    2 
 arch/x86/xen/xen-asm.S                                           |    2 
 block/blk-sysfs.c                                                |    6 -
 block/genhd.c                                                    |    9 -
 drivers/acpi/resource.c                                          |    6 -
 drivers/block/zram/zram_drv.c                                    |    1 
 drivers/gpio/gpio-xilinx.c                                       |   32 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                       |   45 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c                           |    4 
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c            |    2 
 drivers/gpu/drm/i915/display/intel_fb.c                          |    2 
 drivers/gpu/drm/nouveau/nouveau_fence.c                          |    6 -
 drivers/gpu/drm/v3d/v3d_irq.c                                    |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                               |    3 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                               |    3 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                              |    7 -
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c                              |    1 
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c                           |    7 -
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c                       |    5 -
 drivers/hwmon/tmp513.c                                           |    7 -
 drivers/i2c/busses/i2c-rcar.c                                    |   20 +++-
 drivers/i2c/i2c-atr.c                                            |    2 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                            |    4 
 drivers/iio/imu/inv_icm42600/inv_icm42600.h                      |    1 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c                 |   11 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c                  |    3 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                         |    1 
 drivers/infiniband/hw/bnxt_re/ib_verbs.h                         |    4 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                         |    1 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                         |    1 
 drivers/irqchip/irq-gic-v3-its.c                                 |    2 
 drivers/irqchip/irq-gic-v3.c                                     |    2 
 drivers/irqchip/irqchip.c                                        |    4 
 drivers/mtd/spi-nor/core.c                                       |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c                      |   19 ---
 drivers/net/ethernet/freescale/fec_main.c                        |   19 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c         |   22 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c      |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c |   11 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c                |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c           |    4 
 drivers/net/ethernet/netronome/nfp/bpf/offload.c                 |    3 
 drivers/net/ethernet/ti/cpsw_ale.c                               |   14 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                |    6 +
 drivers/net/gtp.c                                                |   42 +++++---
 drivers/nvme/target/io-cmd-bdev.c                                |    2 
 drivers/pci/controller/pci-host-common.c                         |    4 
 drivers/pci/probe.c                                              |   20 ++--
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c                           |    2 
 drivers/ufs/core/ufshcd.c                                        |    9 +
 fs/cachefiles/daemon.c                                           |   14 +-
 fs/cachefiles/internal.h                                         |    3 
 fs/cachefiles/security.c                                         |    6 -
 fs/file.c                                                        |    1 
 fs/hfs/super.c                                                   |    4 
 fs/iomap/buffered-io.c                                           |    2 
 fs/nfsd/filecache.c                                              |   18 ++-
 fs/nfsd/filecache.h                                              |    1 
 fs/notify/fdinfo.c                                               |    4 
 fs/ocfs2/extent_map.c                                            |    8 +
 fs/overlayfs/copy_up.c                                           |   16 +--
 fs/overlayfs/export.c                                            |   49 +++++-----
 fs/overlayfs/namei.c                                             |    4 
 fs/overlayfs/overlayfs.h                                         |    2 
 fs/proc/vmcore.c                                                 |    2 
 fs/smb/client/connect.c                                          |    3 
 include/linux/hrtimer.h                                          |    1 
 include/linux/poll.h                                             |   10 +-
 include/linux/pruss_driver.h                                     |   12 +-
 include/net/net_namespace.h                                      |    3 
 kernel/cpu.c                                                     |    2 
 kernel/gen_kheaders.sh                                           |    1 
 kernel/time/hrtimer.c                                            |   11 ++
 mm/filemap.c                                                     |    2 
 net/core/filter.c                                                |   30 +++---
 net/core/net_namespace.c                                         |   31 ++++++
 net/core/pktgen.c                                                |    6 -
 net/dccp/ipv6.c                                                  |    2 
 net/ipv6/tcp_ipv6.c                                              |    4 
 net/mac802154/iface.c                                            |    4 
 net/mptcp/options.c                                              |    6 -
 net/mptcp/protocol.h                                             |    9 +
 net/openvswitch/actions.c                                        |    4 
 net/vmw_vsock/af_vsock.c                                         |   18 +++
 net/vmw_vsock/virtio_transport_common.c                          |   36 +++++--
 net/vmw_vsock/vsock_bpf.c                                        |    9 +
 sound/pci/hda/patch_realtek.c                                    |    1 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                |   43 ++++++--
 tools/testing/selftests/tc-testing/tc-tests/filters/flow.json    |    4 
 90 files changed, 477 insertions(+), 313 deletions(-)

Amir Goldstein (3):
      ovl: pass realinode to ovl_encode_real_fh() instead of realdentry
      ovl: support encoding fid from inode with no alias
      fs: relax assertions on failure to encode file handles

Artem Chernyshev (1):
      pktgen: Avoid out-of-bounds access in get_imix_entries

Christian König (1):
      drm/amdgpu: always sync the GFX pipe on ctx switch

Dan Carpenter (1):
      nfp: bpf: prevent integer overflow in nfp_bpf_event_output()

Dave Airlie (1):
      nouveau/fence: handle cross device fences properly

David Howells (1):
      kheaders: Ignore silly-rename files

David Lechner (1):
      hwmon: (tmp513) Fix division of negative numbers

Eric Dumazet (2):
      net: add exit_batch_rtnl() method
      gtp: use exit_batch_rtnl() method

Greg Kroah-Hartman (2):
      Revert "drm/amdgpu: rework resume handling for display (v2)"
      Linux 6.6.74

Hans de Goede (1):
      ACPI: resource: acpi_dev_irq_override(): Check DMI match last

Heiner Kallweit (1):
      net: ethernet: xgbe: re-add aneg to supported features in PHY quirks

Hongguang Gao (1):
      RDMA/bnxt_re: Fix to export port num to ib_query_qp

Ian Forbes (1):
      drm/vmwgfx: Add new keep_resv BO param

Ilya Maximets (1):
      openvswitch: fix lockup on tx to unregistering netdev with carrier

Jakub Kicinski (1):
      selftests: tc-testing: reduce rshift value

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: fix spi burst write not supported

Joe Hattori (1):
      irqchip: Plug a OF node reference leak in platform_irqchip_probe()

Juergen Gross (2):
      x86/asm: Make serialize() always_inline
      x86/xen: fix SLS mitigation in xen_hypercall_iret()

Kairui Song (1):
      zram: fix potential UAF of zram table

Kevin Groeneveld (1):
      net: fec: handle page_pool_dev_alloc_pages error

Koichiro Den (1):
      hrtimers: Handle CPU state correctly on hotplug

Kuniyuki Iwashima (2):
      gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().
      gtp: Destroy device along with udp socket's netns dismantle.

Leo Stone (1):
      hfs: Sanity check the root record

Leon Romanovsky (3):
      net/mlx5e: Fix inversion dependency warning while enabling IPsec tunnel
      net/mlx5e: Rely on reqid in IPsec tunnel mode
      net/mlx5e: Always start IPsec sequence number from 1

Lizhi Xu (1):
      mac802154: check local interfaces before deleting sdata list

Luis Chamberlain (1):
      nvmet: propagate npwg topology

MD Danish Anwar (1):
      soc: ti: pruss: Fix pruss APIs

Manivannan Sadhasivam (1):
      scsi: ufs: core: Honor runtime/system PM levels if set by host controller drivers

Marco Nelissen (2):
      iomap: avoid avoid truncating 64-bit offset to 32 bits
      filemap: avoid truncating 64-bit offset to 32 bits

Mark Zhang (1):
      net/mlx5: Clear port select structure when fail to create

Max Kellermann (1):
      cachefiles: Parse the "secctx" immediately

Maíra Canal (1):
      drm/v3d: Ensure job pointer is set to NULL after job completion

Michal Luczaj (1):
      bpf: Fix bpf_sk_select_reuseport() memory leak

Mohammed Anees (1):
      ocfs2: fix deadlock in ocfs2_get_system_file_inode

Oleg Nesterov (1):
      poll_wait: add mb() to fix theoretical race between waitqueue_active() and .poll()

Paolo Abeni (3):
      mptcp: be sure to send ack when mptcp-level window re-opens
      mptcp: fix spurious wake-up on under memory pressure
      selftests: mptcp: avoid spurious errors on disconnect

Patrisious Haddad (1):
      net/mlx5: Fix RDMA TX steering prio

Paulo Alcantara (1):
      smb: client: fix double free of TCP_Server_Info::hostname

Pratyush Yadav (1):
      Revert "mtd: spi-nor: core: replace dummy buswidth from addr to data"

Rik van Riel (1):
      fs/proc: fix softlockup in __read_vmcore (part 2)

Sean Anderson (2):
      net: xilinx: axienet: Fix IRQ coalescing packet count overflow
      gpio: xilinx: Convert gpio_lock to raw spinlock

Srinivasan Shanmugam (1):
      drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'

Stefan Binding (1):
      ALSA: hda/realtek: Add support for Ayaneo System using CS35L41 HDA

Stefano Garzarella (5):
      vsock/bpf: return early if transport is not assigned
      vsock/virtio: discard packets if the transport changes
      vsock/virtio: cancel close work in the destructor
      vsock: reset socket state when de-assigning the transport
      vsock: prevent null-ptr-deref in vsock_*[has_data|has_space]

Sudheer Kumar Doredla (1):
      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()

Terry Tritton (1):
      Revert "PCI: Use preserve_config in place of pci_flags"

Tomas Krcka (1):
      irqchip/gic-v3-its: Don't enable interrupts in its_irq_set_vcpu_affinity()

Tomi Valkeinen (1):
      i2c: atr: Fix client detach

Ville Syrjälä (1):
      drm/i915/fb: Relax clear color alignment to 64 bytes

Wang Liang (1):
      net: fix data-races around sk->sk_forward_alloc

Wolfram Sang (2):
      i2c: mux: demux-pinctrl: check initial mux selection, too
      i2c: rcar: fix NACK handling when being a target

Xiaolei Wang (1):
      pmdomain: imx8mp-blk-ctrl: add missing loop break condition

Yogesh Lal (1):
      irqchip/gic-v3: Handle CPU_PM_ENTER_FAILED correctly

Youzhong Yang (1):
      nfsd: add list_head nf_gc to struct nfsd_file

Yu Kuai (1):
      block: fix uaf for flush rq while iterating tags

Zhang Kunbo (1):
      fs: fix missing declaration of init_files


