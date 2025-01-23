Return-Path: <stable+bounces-110306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9105DA1A899
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A38188EFDA
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6409815383E;
	Thu, 23 Jan 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GoUr+0gy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C91150981;
	Thu, 23 Jan 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652201; cv=none; b=KCNv0Drc7OqKzzzBP7L3BrB07jNIzJffzHPHiOrDLhEeq5oGj7AJM3/3RdAeefu9QIVQs7iY+A3FSFotykZ8R2ffgb1r3BW3RFWLNqT0oeJh1IObsZbl5owb5ipaXwvXmGeSYQU5untF+ktBzaTuP5KJ5dt+eAfINZ4O8NRaec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652201; c=relaxed/simple;
	bh=KdpMd7wLezc3KqAi+7YyZkD2CKEWZBFQK9iXrdjIuC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ffh+Si+8Cpi4GTZkbfq/hIUdiVrrE7nEWGCItFe3sq/tq32UA+nTNLMSDZ4yDlJmd2HN0pX99kffzdvxihMdeBh+kvbiMLWAxyS+eCDgKwyVUYsFvCjrTbBtD3nEr12HECVyjVS8GhZkiZ58krjU0UWUAMbnE8F/NUq14bRmkI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GoUr+0gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894F0C4CEE0;
	Thu, 23 Jan 2025 17:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737652200;
	bh=KdpMd7wLezc3KqAi+7YyZkD2CKEWZBFQK9iXrdjIuC0=;
	h=From:To:Cc:Subject:Date:From;
	b=GoUr+0gy4SWZ8B0XVvjdZPXSIerMVer/9ZFRoekLBDmJOEeZ/keQEVc0nF28nACwA
	 fdyH8H6H83U/1/sETdCEnXzM6FWZGlo8SlojlIn5D8GZf7hwldXhly7PNJ8H2bsNiE
	 t2BfZWDP+czhkO9V+uOz+1oC5ZFRNetxApuYTEaQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.127
Date: Thu, 23 Jan 2025 18:09:44 +0100
Message-ID: <2025012345-prize-despise-fe89@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.127 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                      |    2 
 arch/x86/include/asm/special_insns.h                          |    2 
 arch/x86/xen/xen-asm.S                                        |    2 
 block/blk-sysfs.c                                             |    6 
 block/genhd.c                                                 |    9 
 drivers/acpi/resource.c                                       |    6 
 drivers/base/regmap/regmap.c                                  |   12 
 drivers/block/zram/zram_drv.c                                 |    1 
 drivers/gpio/gpiolib-cdev.c                                   |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                    |   47 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                       |    6 
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c         |    2 
 drivers/gpu/drm/i915/display/intel_fb.c                       |    2 
 drivers/gpu/drm/v3d/v3d_irq.c                                 |    4 
 drivers/hwmon/tmp513.c                                        |    7 
 drivers/i2c/busses/i2c-rcar.c                                 |   20 +
 drivers/i2c/muxes/i2c-demux-pinctrl.c                         |    4 
 drivers/iio/adc/rockchip_saradc.c                             |    2 
 drivers/iio/imu/inv_icm42600/inv_icm42600.h                   |    1 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c              |   18 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c               |    3 
 drivers/infiniband/sw/rxe/rxe_req.c                           |    6 
 drivers/irqchip/irq-gic-v3-its.c                              |    2 
 drivers/irqchip/irq-gic-v3.c                                  |    2 
 drivers/irqchip/irqchip.c                                     |    4 
 drivers/mtd/spi-nor/core.c                                    |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c                   |   19 -
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c             |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c        |    4 
 drivers/net/ethernet/netronome/nfp/bpf/offload.c              |    3 
 drivers/net/ethernet/ti/cpsw_ale.c                            |   14 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c             |    6 
 drivers/net/gtp.c                                             |   42 +-
 drivers/net/wireless/ath/ath10k/sdio.c                        |    4 
 drivers/nvme/target/io-cmd-bdev.c                             |    2 
 drivers/pci/controller/pci-host-common.c                      |    4 
 drivers/pci/probe.c                                           |   20 -
 drivers/scsi/sg.c                                             |    2 
 drivers/soc/imx/imx8mp-blk-ctrl.c                             |    2 
 drivers/ufs/core/ufshcd.c                                     |    9 
 fs/cachefiles/daemon.c                                        |   14 
 fs/cachefiles/internal.h                                      |    3 
 fs/cachefiles/security.c                                      |    6 
 fs/erofs/erofs_fs.h                                           |  145 ++++------
 fs/erofs/zmap.c                                               |  133 ++++-----
 fs/file.c                                                     |    1 
 fs/hfs/super.c                                                |    4 
 fs/iomap/buffered-io.c                                        |    2 
 fs/nfsd/filecache.c                                           |   18 -
 fs/nfsd/filecache.h                                           |    1 
 fs/proc/vmcore.c                                              |    2 
 include/linux/hrtimer.h                                       |    1 
 include/linux/poll.h                                          |   10 
 include/net/net_namespace.h                                   |    3 
 kernel/cpu.c                                                  |    2 
 kernel/gen_kheaders.sh                                        |    1 
 kernel/time/hrtimer.c                                         |   11 
 mm/filemap.c                                                  |    2 
 net/core/filter.c                                             |   30 +-
 net/core/net_namespace.c                                      |   31 ++
 net/core/pktgen.c                                             |    6 
 net/dccp/ipv6.c                                               |    2 
 net/ipv6/tcp_ipv6.c                                           |    4 
 net/mac802154/iface.c                                         |    4 
 net/mptcp/options.c                                           |    6 
 net/openvswitch/actions.c                                     |    4 
 net/vmw_vsock/af_vsock.c                                      |   18 +
 net/vmw_vsock/virtio_transport_common.c                       |   36 +-
 sound/pci/hda/patch_realtek.c                                 |    1 
 tools/testing/selftests/net/mptcp/mptcp_connect.c             |   43 ++
 tools/testing/selftests/tc-testing/tc-tests/filters/flow.json |    4 
 71 files changed, 476 insertions(+), 378 deletions(-)

Artem Chernyshev (1):
      pktgen: Avoid out-of-bounds access in get_imix_entries

Dan Carpenter (1):
      nfp: bpf: prevent integer overflow in nfp_bpf_event_output()

David Howells (1):
      kheaders: Ignore silly-rename files

David Lechner (1):
      hwmon: (tmp513) Fix division of negative numbers

Eric Dumazet (2):
      net: add exit_batch_rtnl() method
      gtp: use exit_batch_rtnl() method

Gao Xiang (2):
      erofs: tidy up EROFS on-disk naming
      erofs: handle NONHEAD !delta[1] lclusters gracefully

Greg Kroah-Hartman (3):
      Revert "drm/amdgpu: rework resume handling for display (v2)"
      Revert "regmap: detach regmap from dev on regmap_exit"
      Linux 6.1.127

Hans de Goede (1):
      ACPI: resource: acpi_dev_irq_override(): Check DMI match last

Heiner Kallweit (1):
      net: ethernet: xgbe: re-add aneg to supported features in PHY quirks

Ilya Maximets (1):
      openvswitch: fix lockup on tx to unregistering netdev with carrier

Jakub Kicinski (1):
      selftests: tc-testing: reduce rshift value

Javier Carrasco (1):
      iio: adc: rockchip_saradc: fix information leak in triggered buffer

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_icm42600: fix spi burst write not supported
      iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on

Joe Hattori (1):
      irqchip: Plug a OF node reference leak in platform_irqchip_probe()

Juergen Gross (2):
      x86/asm: Make serialize() always_inline
      x86/xen: fix SLS mitigation in xen_hypercall_iret()

Kairui Song (1):
      zram: fix potential UAF of zram table

Kang Yang (1):
      wifi: ath10k: avoid NULL pointer error during sdio remove

Koichiro Den (1):
      hrtimers: Handle CPU state correctly on hotplug

Kuniyuki Iwashima (2):
      gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().
      gtp: Destroy device along with udp socket's netns dismantle.

Leo Stone (1):
      hfs: Sanity check the root record

Lizhi Xu (1):
      mac802154: check local interfaces before deleting sdata list

Luis Chamberlain (1):
      nvmet: propagate npwg topology

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

Oleg Nesterov (1):
      poll_wait: add mb() to fix theoretical race between waitqueue_active() and .poll()

Paolo Abeni (2):
      mptcp: be sure to send ack when mptcp-level window re-opens
      selftests: mptcp: avoid spurious errors on disconnect

Patrisious Haddad (1):
      net/mlx5: Fix RDMA TX steering prio

Pratyush Yadav (1):
      Revert "mtd: spi-nor: core: replace dummy buswidth from addr to data"

Rik van Riel (1):
      fs/proc: fix softlockup in __read_vmcore (part 2)

Sean Anderson (1):
      net: xilinx: axienet: Fix IRQ coalescing packet count overflow

Srinivasan Shanmugam (1):
      drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'

Stefan Binding (1):
      ALSA: hda/realtek: Add support for Ayaneo System using CS35L41 HDA

Stefano Garzarella (4):
      vsock/virtio: discard packets if the transport changes
      vsock/virtio: cancel close work in the destructor
      vsock: reset socket state when de-assigning the transport
      vsock: prevent null-ptr-deref in vsock_*[has_data|has_space]

Sudheer Kumar Doredla (1):
      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()

Suraj Sonawane (1):
      scsi: sg: Fix slab-use-after-free read in sg_release()

Terry Tritton (1):
      Revert "PCI: Use preserve_config in place of pci_flags"

Tomas Krcka (1):
      irqchip/gic-v3-its: Don't enable interrupts in its_irq_set_vcpu_affinity()

Ville Syrjälä (1):
      drm/i915/fb: Relax clear color alignment to 64 bytes

Vitaly Prosyak (1):
      drm/amdgpu: fix usage slab after free

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

Zhongqiu Han (1):
      gpiolib: cdev: Fix use after free in lineinfo_changed_notify

Zhu Yanjun (1):
      RDMA/rxe: Fix the qp flush warnings in req


