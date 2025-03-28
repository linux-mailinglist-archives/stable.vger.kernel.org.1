Return-Path: <stable+bounces-126974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32952A751FC
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 22:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F056A1894970
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 21:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DBA1EF37E;
	Fri, 28 Mar 2025 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wg9W2lra"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C391EF372;
	Fri, 28 Mar 2025 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743196861; cv=none; b=EMiV+jeQCjic/7YLGOAavExRy7a1gqcE3AXjNjmjeeJDdvqQVC6WC7hfVHHBT4RwfHMFFgjRjZOOKANqW5ThUAB3YEJ/SAm3oGRaDXQoIZy8R/wU+jVdYCvOk1Ymop+Ib8Dzco8igOmvrsrS1/guOUyn7bquJl78dhZckV6FAu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743196861; c=relaxed/simple;
	bh=gO0ynvGKS39uIhoyud6PL7994MVIezWdUBfZOu/ANJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eh8Pm3+dJ+Kgt3cceHdTrx0chTibgiKBwAiJGexwU1JLDq48P10B+wa9GxUEOd/pvp/iewT/GDZqE69+JmCC5GQOMwvaOY2w+uDllNtoLT4Vi4NCMEAamx5M8L/14ReLypW1UI7ViPEs7E9x9w+tDWbcNVTbrK1LG/OJv9O23CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wg9W2lra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE5BC4CEE4;
	Fri, 28 Mar 2025 21:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743196860;
	bh=gO0ynvGKS39uIhoyud6PL7994MVIezWdUBfZOu/ANJI=;
	h=From:To:Cc:Subject:Date:From;
	b=Wg9W2lraGAaxvJvWqgIKxolMdLzYwgz2efT8tFYdQ12+6ptj7pqQawvQ/inG8EJtP
	 Dycz8GTu5uo9G6CSwgnwJ9j1nBAgzSirjqY86Edb54v46m+txOhHIfnqtvz7kWnong
	 O1jcZ5pjVujmWppRB6iqGcte0cTgv04AKaMq+OfU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.132
Date: Fri, 28 Mar 2025 22:19:31 +0100
Message-ID: <2025032832-prissy-exact-e585@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.132 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/timers/no_hz.rst                                |    7 
 Makefile                                                      |   13 
 arch/alpha/include/asm/elf.h                                  |    6 
 arch/alpha/include/asm/pgtable.h                              |    2 
 arch/alpha/include/asm/processor.h                            |    8 
 arch/alpha/kernel/osf_sys.c                                   |   11 
 arch/arm/boot/dts/bcm2711.dtsi                                |   11 
 arch/arm/mach-omap1/Kconfig                                   |    1 
 arch/arm/mach-shmobile/headsmp.S                              |    1 
 arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi       |    6 
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi           |   16 
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts            |    2 
 arch/arm64/mm/mmu.c                                           |    5 
 arch/x86/events/intel/core.c                                  |   85 ++++
 arch/x86/kernel/cpu/microcode/amd.c                           |    2 
 arch/x86/kernel/cpu/mshyperv.c                                |   11 
 arch/x86/kernel/irq.c                                         |    2 
 block/bfq-cgroup.c                                            |    2 
 block/bio.c                                                   |    2 
 drivers/acpi/resource.c                                       |    6 
 drivers/clk/samsung/clk-pll.c                                 |    7 
 drivers/clocksource/i8253.c                                   |   36 +-
 drivers/firmware/efi/libstub/randomalloc.c                    |    4 
 drivers/firmware/imx/imx-scu.c                                |    1 
 drivers/firmware/iscsi_ibft.c                                 |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c                        |   20 -
 drivers/gpu/drm/amd/amdgpu/nv.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/soc15.c                            |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c             |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c        |    1 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c             |    7 
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c         |   12 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                 |   40 +-
 drivers/gpu/drm/drm_atomic_uapi.c                             |    4 
 drivers/gpu/drm/drm_connector.c                               |    4 
 drivers/gpu/drm/gma500/mid_bios.c                             |    5 
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c                       |    2 
 drivers/gpu/drm/mediatek/mtk_drm_gem.c                        |    9 
 drivers/gpu/drm/mediatek/mtk_drm_plane.c                      |   13 
 drivers/gpu/drm/nouveau/nouveau_connector.c                   |    1 
 drivers/gpu/drm/radeon/radeon_vce.c                           |    2 
 drivers/gpu/drm/v3d/v3d_sched.c                               |    9 
 drivers/hid/hid-apple.c                                       |   13 
 drivers/hid/hid-ids.h                                         |    2 
 drivers/hid/hid-quirks.c                                      |    1 
 drivers/hid/intel-ish-hid/ipc/ipc.c                           |   15 
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h                   |    2 
 drivers/hv/vmbus_drv.c                                        |   13 
 drivers/i2c/busses/i2c-ali1535.c                              |   12 
 drivers/i2c/busses/i2c-ali15x3.c                              |   12 
 drivers/i2c/busses/i2c-omap.c                                 |   26 -
 drivers/i2c/busses/i2c-sis630.c                               |   12 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                      |    2 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h                    |    3 
 drivers/infiniband/hw/hns/hns_roce_hem.c                      |   16 
 drivers/infiniband/hw/hns/hns_roce_main.c                     |    2 
 drivers/infiniband/hw/hns/hns_roce_qp.c                       |   10 
 drivers/input/serio/i8042-acpipnpio.h                         |  111 +++---
 drivers/leds/leds-mlxreg.c                                    |   16 
 drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c |   10 
 drivers/mmc/host/atmel-mci.c                                  |    4 
 drivers/mmc/host/sdhci-brcmstb.c                              |   10 
 drivers/net/bonding/bond_options.c                            |   55 ++-
 drivers/net/can/flexcan/flexcan-core.c                        |   18 -
 drivers/net/can/rcar/rcar_canfd.c                             |   28 -
 drivers/net/dsa/mv88e6xxx/chip.c                              |   59 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                     |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                 |   11 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h                 |    3 
 drivers/net/ethernet/intel/ice/ice_arfs.c                     |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c       |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c             |    6 
 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c       |    5 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c      |    8 
 drivers/net/mctp/mctp-i2c.c                                   |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                   |    9 
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c                  |   28 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h                  |    3 
 drivers/net/wwan/mhi_wwan_mbim.c                              |    2 
 drivers/nvme/host/core.c                                      |    2 
 drivers/nvme/host/fc.c                                        |    3 
 drivers/nvme/host/pci.c                                       |    2 
 drivers/nvme/host/tcp.c                                       |   43 ++
 drivers/nvme/target/rdma.c                                    |   33 +
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c                        |    2 
 drivers/platform/x86/thinkpad_acpi.c                          |   50 ++
 drivers/powercap/powercap_sys.c                               |    3 
 drivers/regulator/core.c                                      |   12 
 drivers/s390/cio/chp.c                                        |    3 
 drivers/scsi/qla1280.c                                        |    2 
 drivers/scsi/scsi_scan.c                                      |    2 
 drivers/soc/imx/soc-imx8m.c                                   |  149 +++-----
 drivers/soc/qcom/pdr_interface.c                              |    8 
 drivers/thermal/cpufreq_cooling.c                             |    2 
 drivers/usb/serial/ftdi_sio.c                                 |   14 
 drivers/usb/serial/ftdi_sio_ids.h                             |   13 
 drivers/usb/serial/option.c                                   |   48 +-
 drivers/video/fbdev/hyperv_fb.c                               |    2 
 drivers/xen/swiotlb-xen.c                                     |    2 
 fs/fuse/dir.c                                                 |    2 
 fs/namei.c                                                    |   24 +
 fs/ntfs3/attrib.c                                             |  176 ++++++----
 fs/ntfs3/file.c                                               |  151 +-------
 fs/ntfs3/frecord.c                                            |    2 
 fs/ntfs3/index.c                                              |    4 
 fs/ntfs3/inode.c                                              |   12 
 fs/ntfs3/ntfs_fs.h                                            |    9 
 fs/ntfs3/super.c                                              |   68 ++-
 fs/proc/base.c                                                |    9 
 fs/proc/generic.c                                             |   10 
 fs/proc/inode.c                                               |    6 
 fs/proc/internal.h                                            |   14 
 fs/select.c                                                   |   11 
 fs/smb/client/asn1.c                                          |    2 
 fs/smb/client/cifs_spnego.c                                   |    4 
 fs/smb/client/cifsglob.h                                      |    4 
 fs/smb/client/connect.c                                       |   16 
 fs/smb/client/fs_context.c                                    |   14 
 fs/smb/client/ioctl.c                                         |    6 
 fs/smb/client/sess.c                                          |    3 
 fs/smb/client/smb2pdu.c                                       |    4 
 fs/smb/server/smbacl.c                                        |    5 
 fs/vboxsf/super.c                                             |    3 
 fs/xfs/libxfs/xfs_ag.c                                        |   45 +-
 fs/xfs/libxfs/xfs_ag.h                                        |    3 
 fs/xfs/libxfs/xfs_alloc.c                                     |   77 ++--
 fs/xfs/libxfs/xfs_alloc.h                                     |   24 -
 fs/xfs/libxfs/xfs_attr.c                                      |    6 
 fs/xfs/libxfs/xfs_bmap.c                                      |  121 +++---
 fs/xfs/libxfs/xfs_bmap.h                                      |    5 
 fs/xfs/libxfs/xfs_bmap_btree.c                                |    8 
 fs/xfs/libxfs/xfs_btree_staging.c                             |    4 
 fs/xfs/libxfs/xfs_btree_staging.h                             |    6 
 fs/xfs/libxfs/xfs_da_btree.c                                  |    7 
 fs/xfs/libxfs/xfs_format.h                                    |    2 
 fs/xfs/libxfs/xfs_ialloc.c                                    |   24 -
 fs/xfs/libxfs/xfs_ialloc_btree.c                              |    6 
 fs/xfs/libxfs/xfs_log_recover.h                               |   22 +
 fs/xfs/libxfs/xfs_refcount.c                                  |  116 +++---
 fs/xfs/libxfs/xfs_refcount.h                                  |    4 
 fs/xfs/libxfs/xfs_refcount_btree.c                            |    9 
 fs/xfs/libxfs/xfs_rtbitmap.c                                  |    2 
 fs/xfs/libxfs/xfs_rtbitmap.h                                  |   83 ++++
 fs/xfs/libxfs/xfs_sb.c                                        |   20 +
 fs/xfs/libxfs/xfs_sb.h                                        |    2 
 fs/xfs/libxfs/xfs_types.h                                     |   13 
 fs/xfs/scrub/repair.c                                         |    3 
 fs/xfs/scrub/rtbitmap.c                                       |    3 
 fs/xfs/xfs_attr_item.c                                        |   16 
 fs/xfs/xfs_bmap_item.c                                        |   85 +---
 fs/xfs/xfs_buf.c                                              |   44 ++
 fs/xfs/xfs_buf.h                                              |    1 
 fs/xfs/xfs_extfree_item.c                                     |  144 ++++----
 fs/xfs/xfs_fsmap.c                                            |    2 
 fs/xfs/xfs_fsops.c                                            |    5 
 fs/xfs/xfs_inode_item.c                                       |    3 
 fs/xfs/xfs_refcount_item.c                                    |   68 +--
 fs/xfs/xfs_reflink.c                                          |    7 
 fs/xfs/xfs_rmap_item.c                                        |    6 
 fs/xfs/xfs_rtalloc.c                                          |   14 
 fs/xfs/xfs_rtalloc.h                                          |   73 ----
 fs/xfs/xfs_trace.h                                            |   15 
 include/linux/fs.h                                            |    2 
 include/linux/i8253.h                                         |    1 
 include/linux/io_uring_types.h                                |    5 
 include/linux/nvme-tcp.h                                      |    2 
 include/linux/proc_fs.h                                       |    7 
 include/net/bluetooth/hci_core.h                              |  108 ++----
 include/sound/soc.h                                           |    5 
 include/uapi/linux/io_uring.h                                 |    1 
 init/Kconfig                                                  |    2 
 io_uring/io_uring.c                                           |  163 +++++++--
 io_uring/io_uring.h                                           |    2 
 kernel/sched/core.c                                           |   13 
 kernel/sys.c                                                  |    2 
 kernel/time/hrtimer.c                                         |   40 --
 lib/buildid.c                                                 |    5 
 mm/migrate.c                                                  |   16 
 mm/nommu.c                                                    |    7 
 net/atm/lec.c                                                 |    3 
 net/batman-adv/bat_iv_ogm.c                                   |    3 
 net/batman-adv/bat_v_ogm.c                                    |    3 
 net/bluetooth/6lowpan.c                                       |    7 
 net/bluetooth/hci_core.c                                      |   10 
 net/bluetooth/hci_event.c                                     |   37 +-
 net/bluetooth/iso.c                                           |    6 
 net/bluetooth/l2cap_core.c                                    |   12 
 net/bluetooth/rfcomm/core.c                                   |    6 
 net/bluetooth/sco.c                                           |   12 
 net/core/lwtunnel.c                                           |   65 +++
 net/core/neighbour.c                                          |    1 
 net/core/netpoll.c                                            |    9 
 net/ipv4/tcp.c                                                |   19 -
 net/ipv6/route.c                                              |    5 
 net/mptcp/options.c                                           |    6 
 net/mptcp/protocol.h                                          |    2 
 net/netfilter/ipvs/ip_vs_ctl.c                                |    8 
 net/netfilter/nf_conncount.c                                  |    6 
 net/netfilter/nft_counter.c                                   |   90 ++---
 net/netfilter/nft_ct.c                                        |    6 
 net/netfilter/nft_exthdr.c                                    |   10 
 net/openvswitch/flow_netlink.c                                |   15 
 net/sched/sch_api.c                                           |    6 
 net/sched/sch_gred.c                                          |    3 
 net/sctp/stream.c                                             |    2 
 net/switchdev/switchdev.c                                     |   25 +
 net/wireless/core.c                                           |    7 
 net/xdp/xsk_buff_pool.c                                       |    2 
 net/xfrm/xfrm_output.c                                        |    2 
 rust/Makefile                                                 |    7 
 scripts/generate_rust_analyzer.py                             |   64 ++-
 sound/pci/hda/patch_realtek.c                                 |    1 
 sound/soc/amd/yc/acp6x-mach.c                                 |    7 
 sound/soc/codecs/arizona.c                                    |   14 
 sound/soc/codecs/madera.c                                     |   10 
 sound/soc/codecs/tas2764.c                                    |   10 
 sound/soc/codecs/tas2764.h                                    |    8 
 sound/soc/codecs/tas2770.c                                    |    2 
 sound/soc/codecs/wm0010.c                                     |   13 
 sound/soc/codecs/wm5110.c                                     |    8 
 sound/soc/sh/rcar/core.c                                      |   14 
 sound/soc/sh/rcar/rsnd.h                                      |    1 
 sound/soc/sh/rcar/src.c                                       |  116 +++++-
 sound/soc/soc-ops.c                                           |   15 
 sound/soc/sof/intel/hda-codec.c                               |    1 
 225 files changed, 2536 insertions(+), 1520 deletions(-)

Acs, Jakub (1):
      block, bfq: fix re-introduced UAF in bic_set_bfqq()

Alex Henrie (2):
      HID: apple: fix up the F6 key on the Omoton KB066 keyboard
      HID: apple: disable Fn key handling on the Omoton KB066

Alex Hung (1):
      drm/amd/display: Assign normalized_pix_clk when color depth = 14

Alexander Stein (1):
      arm64: dts: freescale: tqma8mpql: Fix vqmmc-supply

Alexey Kashavkin (1):
      netfilter: nft_exthdr: fix offset with ipv4_find_option()

Amit Cohen (1):
      net: switchdev: Convert blocking notification chain to a raw one

Andreas Kemnade (1):
      i2c: omap: fix IRQ storms

Andrey Albershteyn (1):
      xfs: reset XFS_ATTR_INCOMPLETE filter on node removal

Andrii Nakryiko (1):
      lib/buildid: Handle memfd_secret() files in build_id_parse()

Andy Shevchenko (1):
      hrtimers: Mark is_migration_base() with __always_inline

Ard Biesheuvel (1):
      efi/libstub: Avoid physical address 0x0 when doing random allocation

Arnd Bergmann (2):
      x86/irq: Define trace events conditionally
      ARM: OMAP1: select CONFIG_GENERIC_IRQ_CHIP

Arthur Mongodin (1):
      mptcp: Fix data stream corruption in the address announcement

Artur Weber (1):
      pinctrl: bcm281xx: Fix incorrect regmap max_registers value

Asahi Lina (1):
      scripts: generate_rust_analyzer: Handle sub-modules with no Makefile

Benjamin Berg (1):
      wifi: iwlwifi: mvm: ensure offloading TID queue exists

Biju Das (1):
      can: rcar_canfd: Fix page entries in the AFL list

Boon Khai Ng (1):
      USB: serial: ftdi_sio: add support for Altera USB Blaster 3

Brahmajit Das (1):
      vboxsf: fix building with GCC 15

Breno Leitao (1):
      netpoll: hold rcu read lock in __netpoll_send_skb()

Carolina Jubran (1):
      net/mlx5e: Prevent bridge link show failure for non-eswitch-allowed devices

Charles Keepax (1):
      ASoC: ops: Consistently treat platform_max as control value

Chengen Du (1):
      iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in ibft_attr_show_nic()

Chia-Lin Kao (AceLan) (1):
      HID: ignore non-functional sensor in HP 5MP Camera

Christian Eggers (1):
      regulator: check that dummy regulator has been probed before using it

Christoph Hellwig (1):
      xfs: consider minlen sized extents in xfs_rtallocate_extent_block

Christophe JAILLET (4):
      ASoC: codecs: wm0010: Fix error handling path in wm0010_spi_probe()
      i2c: ali1535: Fix an error handling path in ali1535_probe()
      i2c: ali15x3: Fix an error handling path in ali15x3_probe()
      i2c: sis630: Fix an error handling path in sis630_probe()

Christopher Lentocha (1):
      nvme-pci: quirk Acer FA100 for non-uniqueue identifiers

Cong Wang (1):
      net_sched: Prevent creation of classes with TC_H_ROOT

Cosmin Ratiu (1):
      xfrm_output: Force software GSO only in tunnel mode

Dan Carpenter (3):
      ipvs: prevent integer overflow in do_ip_vs_get_ctl()
      Bluetooth: Fix error code in chan_alloc_skb_cb()
      net: atm: fix use after free in lec_send()

Daniel Lezcano (1):
      thermal/cpufreq_cooling: Remove structure member documentation

Daniel Wagner (2):
      nvme-fc: go straight to connecting state when initializing
      nvme: only allow entering LIVE from CONNECTING state

Darrick J. Wong (17):
      xfs: pass refcount intent directly through the log intent code
      xfs: pass xfs_extent_free_item directly through the log intent code
      xfs: fix confusing xfs_extent_item variable names
      xfs: pass the xfs_bmbt_irec directly through the log intent code
      xfs: pass per-ag references to xfs_free_extent
      xfs: reserve less log space when recovering log intent items
      xfs: move the xfs_rtbitmap.c declarations to xfs_rtbitmap.h
      xfs: convert rt bitmap extent lengths to xfs_rtbxlen_t
      xfs: don't leak recovered attri intent items
      xfs: make rextslog computation consistent with mkfs
      xfs: fix 32-bit truncation in xfs_compute_rextslog
      xfs: don't allow overly small or large realtime volumes
      xfs: remove unused fields from struct xbtree_ifakeroot
      xfs: recompute growfsrtfree transaction reservation while growing rt volume
      xfs: force all buffers to be written during btree bulk load
      xfs: remove conditional building of rt geometry validator functions
      xfs: give xfs_extfree_intent its own perag reference

Dave Chinner (4):
      xfs: validate block number being freed before adding to xefi
      xfs: fix bounds check in xfs_defer_agfl_block()
      xfs: use deferred frees for btree block freeing
      xfs: initialise di_crc in xfs_log_dinode

David Rosca (1):
      drm/amdgpu: Fix JPEG video caps max size for navi1x and raven

David Woodhouse (1):
      clockevents/drivers/i8253: Fix stop sequence for timer 0

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on Positivo ARN50

Eric Dumazet (1):
      tcp: fix races in tcp_abort()

Eric W. Biederman (1):
      alpha/elf: Fix misc/setarch test of util-linux by removing 32bit support

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FE990B compositions
      USB: serial: option: fix Telit Cinterion FE990A name

Felix Moessbauer (1):
      hrtimer: Use and report correct timerslack values for realtime tasks

Florent Revest (1):
      x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA nodes

Gannon Kolding (1):
      ACPI: resource: IRQ override for Eluktronics MECH-17

Gavrilov Ilia (1):
      xsk: fix an integer overflow in xp_create_and_assign_umem()

Geert Uytterhoeven (1):
      ARM: shmobile: smp: Enforce shmobile_smp_* alignment

George Stark (1):
      leds: mlxreg: Use devm_mutex_init() for mutex initialization

Greg Kroah-Hartman (1):
      Linux 6.1.132

Grzegorz Nitka (1):
      ice: fix memory leak in aRFS after reset

Gu Bowen (1):
      mmc: atmel-mci: Add missing clk_disable_unprepare()

Guillaume Nault (2):
      gre: Fix IPv6 link-local address generation.
      Revert "gre: Fix IPv6 link-local address generation."

Haibo Chen (2):
      can: flexcan: only change CAN state when link up in system PM
      can: flexcan: disable transceiver during system PM

Hangbin Liu (1):
      bonding: fix incorrect MAC address setting to receive NS messages

Haoxiang Li (1):
      qlcnic: fix memory leak issues in qlcnic_sriov_common.c

Hector Martin (3):
      ASoC: tas2770: Fix volume scale
      ASoC: tas2764: Fix power control mask
      ASoC: tas2764: Set the SDOUT polarity correctly

Henrique Carvalho (1):
      smb: client: Fix match_session bug preventing session reuse

Ievgen Vovk (1):
      HID: hid-apple: Apple Magic Keyboard a3203 USB-C support

Ilya Maximets (1):
      net: openvswitch: remove misbehaving actions length check

Imre Deak (1):
      drm/dp_mst: Fix locking when skipping CSN before topology probing

Ivan Abramov (1):
      drm/gma500: Add NULL check for pci_gfx_root in mid_get_vbt_data()

Jan Beulich (1):
      Xen/swiotlb: mark xen_swiotlb_fixup() __init

Jann Horn (1):
      sched: Clarify wake_up_q()'s write to task->wake_q.next

Jason-JH.Lin (1):
      drm/mediatek: Fix coverity issue with unintentional integer overflow

Jens Axboe (5):
      io_uring: return error pointer from io_mem_alloc()
      io_uring: add ring freeing helper
      mm: add nommu variant of vm_insert_pages()
      io_uring: get rid of remap_pfn_range() for mapping rings/sqes
      io_uring: don't attempt to mmap larger than what the user asks for

Jiachen Zhang (1):
      xfs: ensure logflagsp is initialized in xfs_bmap_del_extent_real

Jianbo Liu (1):
      net/mlx5: Bridge, fix the crash caused by LAG state check

Joe Hattori (2):
      powercap: call put_device() on an error path in powercap_register_control_type()
      firmware: imx-scu: fix OF node leak in .probe()

Johan Hovold (1):
      USB: serial: option: match on interface class for Telit FN990B

Joseph Huang (1):
      net: dsa: mv88e6xxx: Verify after ATU Load ops

Jun Yang (1):
      sched: address a potential NULL pointer dereference in the GRED scheduler.

Junxian Huang (4):
      RDMA/hns: Fix soft lockup during bt pages loop
      RDMA/hns: Fix unmatched condition in error path of alloc_user_qp_db()
      RDMA/hns: Fix a missing rollback in error path of hns_roce_create_qp_common()
      RDMA/hns: Fix wrong value of max_sge_rd

Justin Iurman (1):
      net: lwtunnel: fix recursion loops

Justin Klaassen (1):
      arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S

Kamal Dasu (1):
      mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops

Kan Liang (1):
      perf/x86/intel: Use better start period for frequency mode

Kashyap Desai (1):
      RDMA/bnxt_re: Add missing paranthesis in map_qp_id_to_tbl_indx

Kohei Enju (1):
      netfilter: nf_conncount: Fully initialize struct nf_conncount_tuple in insert_tree()

Konstantin Komarov (2):
      fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
      fs/ntfs3: Change new sparse cluster processing

Kuninori Morimoto (2):
      ASoC: rsnd: don't indicate warning on rsnd_kctrl_accept_runtime()
      ASoC: rsnd: adjust convert rate limitation

Kuniyuki Iwashima (2):
      ipv6: Fix memleak of nhc_pcpu_rth_output in fib_check_nh_v6_gw().
      ipv6: Set errno after ip_fib_metrics_init() in ip6_route_info_create().

Lin Ma (1):
      net/neighbor: add missing policy for NDTPA_QUEUE_LENBYTES

Long Li (2):
      xfs: add lock protection when remove perag from radix tree
      xfs: fix perag leak when growfs fails

Luiz Augusto von Dentz (2):
      Bluetooth: hci_event: Fix enabling passive scanning
      Revert "Bluetooth: hci_core: Fix sleeping function called from invalid context"

Magnus Lindholm (1):
      scsi: qla1280: Fix kernel oops when debug level > 2

Marek Vasut (2):
      soc: imx8m: Remove global soc_uid
      soc: imx8m: Use devm_* to simplify probe failure handling

Mario Limonciello (3):
      drm/amd/display: Restore correct backlight brightness after a GPU reset
      drm/amd/display: Fix slab-use-after-free on hdcp_work
      drm/amd/display: Use HW lock mgr for PSR1 when only one eDP

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Support for V9 DYTC platform profiles

Martin Rodriguez Reboredo (1):
      scripts: generate_rust_analyzer: provide `cfg`s for `core` and `alloc`

Matt Johnston (1):
      net: mctp i2c: Copy headers if cloned

Matthew Maurer (1):
      rust: Disallow BTF generation with Rust + LTO

Matthieu Baerts (NGI0) (1):
      mptcp: safety check before fallback

Maurizio Lombardi (2):
      nvme-tcp: add basic support for the C2HTermReq PDU
      nvme-tcp: Fix a C2HTermReq error message

Maíra Canal (1):
      drm/v3d: Don't run jobs that have errors flagged in its fence

Michael Kelley (3):
      fbdev: hyperv_fb: iounmap() the correct memory when removing a device
      drm/hyperv: Fix address space leak when Hyper-V DRM device is removed
      Drivers: hv: vmbus: Don't release fb_mmio resource in vmbus_free_mmio()

Miklos Szeredi (1):
      fuse: don't truncate cached, mutated symlink

Ming Lei (1):
      block: fix 'kmem_cache of name 'bio-108' already exists'

Miri Korenblit (1):
      wifi: cfg80211: cancel wiphy_work before freeing wiphy

Murad Masimov (4):
      cifs: Fix integer overflow while processing acregmax mount option
      cifs: Fix integer overflow while processing acdirmax mount option
      cifs: Fix integer overflow while processing actimeo mount option
      cifs: Fix integer overflow while processing closetimeo mount option

Namjae Jeon (1):
      ksmbd: fix incorrect validation for num_aces field of smb_acl

Nicklas Bo Jensen (1):
      netfilter: nf_conncount: garbage collection is not skipped when jiffies wrap around

Nikita Zhandarovich (1):
      drm/radeon: fix uninitialized size issue in radeon_vce_cs_parse()

Oleg Nesterov (1):
      sched/isolation: Prevent boot crash when the boot CPU is nohz_full

Paulo Alcantara (2):
      smb: client: fix noisy when tree connecting to DFS interlink targets
      smb: client: fix potential UAF in cifs_dump_full_key()

Pavel Begunkov (1):
      io_uring: fix corner case forgetting to vunmap

Peng Fan (1):
      soc: imx8m: Unregister cpufreq and soc dev in cleanup path

Peter Oberparleiter (1):
      s390/cio: Fix CHPID "configure" attribute caching

Phil Elwell (2):
      ARM: dts: bcm2711: PL011 UARTs are actually r1p5
      ARM: dts: bcm2711: Don't mark timer regs unconfigured

Rik van Riel (1):
      scsi: core: Use GFP_NOIO to avoid circular locking dependency

Ruozhu Li (1):
      nvmet-rdma: recheck queue state is LIVE in state lock in recv done

Saranya R (1):
      soc: qcom: pdr: Fix the potential deadlock

Saravanan Vajravel (1):
      RDMA/bnxt_re: Avoid clearing VLAN_ID mask in modify qp path

Sebastian Andrzej Siewior (2):
      netfilter: nft_ct: Use __refcount_inc() for per-CPU nft_ct_pcpu_template.
      netfilter: nft_counter: Use u64_stats_t for statistic.

Stefan Eichenberger (1):
      arm64: dts: freescale: imx8mm-verdin-dahlia: add Microphone Jack to sound card

Stephan Gerhold (1):
      net: wwan: mhi_wwan_mbim: Silence sequence number glitch errors

Steve French (1):
      smb3: add support for IAKerb

Sven Eckelmann (1):
      batman-adv: Ignore own maximum aggregation size during RX

Sybil Isabel Dorsett (1):
      platform/x86: thinkpad_acpi: Fix invalid fan speed on ThinkPad X120e

Taehee Yoo (1):
      eth: bnxt: do not update checksum in bnxt_xdp_build_skb()

Tamir Duberstein (1):
      scripts: generate_rust_analyzer: add missing macros deps

Terry Cheong (1):
      ASoC: SOF: Intel: hda: add softdep pre to snd-hda-codec-hdmi module

Thomas Mizrahi (1):
      ASoC: amd: yc: Support mic on another Lenovo ThinkPad E16 Gen 2 model

Thomas Zimmermann (1):
      drm/nouveau: Do not override forced connector status

Varada Pavani (1):
      clk: samsung: update PLL locktime for PLL142XX used on FSD platform

Ville Syrjälä (1):
      drm/atomic: Filter out redundant DPMS calls

Vinay Varma (1):
      scripts: `make rust-analyzer` for out-of-tree modules

Vitaly Prosyak (1):
      drm/amdgpu: fix use-after-free bug

Vitaly Rodionov (1):
      ASoC: arizona/madera: use fsleep() in up/down DAPM event delays.

Wentao Liang (1):
      net/mlx5: handle errors in mlx5_chains_create_table()

Werner Sembach (4):
      Input: i8042 - swap old quirk combination with new quirk for NHxxRZQ
      Input: i8042 - add required quirks for missing old boardnames
      Input: i8042 - swap old quirk combination with new quirk for several devices
      Input: i8042 - swap old quirk combination with new quirk for more devices

Xueming Feng (1):
      tcp: fix forever orphan socket caused by tcp_abort

Ye Bin (1):
      proc: fix UAF in proc_get_inode()

Yu-Chun Lin (1):
      sctp: Fix undefined behavior in left shift operation

Yunfei Dong (1):
      media: mediatek: vcodec: Fix VP8 stateless decoder smatch warning

Zhang Lixu (2):
      HID: intel-ish-hid: fix the length of MNG_SYNC_FW_CLOCK in doorbell
      HID: intel-ish-hid: Send clock sync message immediately after reset

Zhang Tianci (1):
      xfs: update dir3 leaf block metadata after swap

Zhenhua Huang (1):
      arm64: mm: Populate vmemmap at the page level if not section aligned

Zi Yan (1):
      mm/migrate: fix shmem xarray update during migration


