Return-Path: <stable+bounces-54819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5370891264E
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 15:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07327B2CDF4
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 13:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A0615575C;
	Fri, 21 Jun 2024 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oUEEcEBS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBFA154C01;
	Fri, 21 Jun 2024 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974788; cv=none; b=sni31t3quKqGzBOeM17dYhIls3FlTO1mTFYZbuhCoJI38UKn5v8iLC+2Xtd03lL99n/6Nx6ej43cscIEHiP4ycnZxmCiML0IVWqjsjpr2ipDbaQEQU/BJtZmGclo/kqQQGNYJWqdFQ1i98xmKMOlN4eKXatPuv/6K1qDJ8nG58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974788; c=relaxed/simple;
	bh=ZvfYvU9gTQ9eTne6uHBT/Wc6I4SdjJe1LLmkPiYV+dY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W/65leJMQXbd9M+WfGTTTWz36SgkROj1VZeclRBXQPlpoD0QMejxYqXUUDrlfT3cuCKlzFgF5imzrA8bm+ZaA6AdzwW4Ct28LO3yD8DUoyOHLCu66MQaRfcdj3+9CLFZRK8SaxX6nGdcS+ZhqztTBZWAZCyyNmSxQNJkNFdsNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oUEEcEBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77C0C2BBFC;
	Fri, 21 Jun 2024 12:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718974787;
	bh=ZvfYvU9gTQ9eTne6uHBT/Wc6I4SdjJe1LLmkPiYV+dY=;
	h=From:To:Cc:Subject:Date:From;
	b=oUEEcEBSQmuTB1+axau+KCLpKN24WGJBPH8mxE7s992RpAuuu/UBD344nROSStAlY
	 XMNEf8B/Xmy0I+mY974nsSk7WLJPtLCbzf8oCyCwMBccNo8PVGCR36G+9O7mjVHqqF
	 kQvjpankhGCjCypaXekBf6xIi6SDE87mGCJP/+SQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.95
Date: Fri, 21 Jun 2024 14:59:33 +0200
Message-ID: <2024062133-frigidly-swimmable-1f17@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.95 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                          |    2 
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts                          |   86 -
 arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts         |    2 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                              |  376 +---
 arch/powerpc/include/asm/uaccess.h                                |   15 
 arch/riscv/mm/init.c                                              |   21 
 arch/riscv/mm/pageattr.c                                          |   28 
 arch/x86/boot/compressed/Makefile                                 |    4 
 arch/x86/kernel/amd_nb.c                                          |    9 
 arch/xtensa/include/asm/processor.h                               |    8 
 arch/xtensa/include/asm/ptrace.h                                  |    2 
 arch/xtensa/kernel/process.c                                      |    5 
 arch/xtensa/kernel/stacktrace.c                                   |    4 
 drivers/base/core.c                                               |    3 
 drivers/block/null_blk/zoned.c                                    |    2 
 drivers/bluetooth/btqca.c                                         |   46 
 drivers/bluetooth/btqca.h                                         |    2 
 drivers/bluetooth/hci_qca.c                                       |    2 
 drivers/clk/sifive/sifive-prci.c                                  |    8 
 drivers/dma/dma-axi-dmac.c                                        |    2 
 drivers/firmware/qcom_scm.c                                       |   18 
 drivers/gpio/Kconfig                                              |    2 
 drivers/gpio/gpio-tqmx86.c                                        |  136 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c         |  120 -
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c        |    2 
 drivers/gpu/drm/bridge/panel.c                                    |    7 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                          |    7 
 drivers/gpu/drm/exynos/exynos_hdmi.c                              |    7 
 drivers/gpu/drm/i915/gem/i915_gem_object.h                        |    4 
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c                       |   15 
 drivers/gpu/drm/vmwgfx/Kconfig                                    |    7 
 drivers/gpu/drm/vmwgfx/Makefile                                   |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                               |   65 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                               |   38 
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                                |  831 ----------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                               |  353 +---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                               |   13 
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                               |    5 
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c                              |    5 
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c                              |   47 
 drivers/greybus/interface.c                                       |    1 
 drivers/hid/hid-core.c                                            |    1 
 drivers/hid/hid-logitech-dj.c                                     |    4 
 drivers/hid/i2c-hid/i2c-hid-of-elan.c                             |  103 -
 drivers/hwtracing/intel_th/pci.c                                  |   25 
 drivers/i2c/busses/i2c-at91-slave.c                               |    3 
 drivers/i2c/busses/i2c-designware-slave.c                         |    2 
 drivers/i2c/i2c-core-acpi.c                                       |   30 
 drivers/i2c/i2c-core-base.c                                       |   98 +
 drivers/i2c/i2c-core-of.c                                         |   66 
 drivers/iio/accel/mxc4005.c                                       |   76 
 drivers/iio/adc/ad9467.c                                          |    4 
 drivers/iio/dac/ad5592r-base.c                                    |    2 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                 |    4 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                  |    4 
 drivers/input/input.c                                             |  104 +
 drivers/iommu/amd/init.c                                          |    9 
 drivers/irqchip/irq-gic-v3-its.c                                  |   44 
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c                     |    9 
 drivers/misc/mei/pci-me.c                                         |    4 
 drivers/misc/pvpanic/pvpanic-mmio.c                               |   58 
 drivers/misc/pvpanic/pvpanic-pci.c                                |   60 
 drivers/misc/pvpanic/pvpanic.c                                    |   76 
 drivers/misc/pvpanic/pvpanic.h                                    |   10 
 drivers/misc/vmw_vmci/vmci_event.c                                |    6 
 drivers/mmc/host/davinci_mmc.c                                    |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c                    |    2 
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c                 |   11 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                      |    8 
 drivers/net/ethernet/google/gve/gve_tx_dqo.c                      |   20 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                   |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h                   |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c           |   21 
 drivers/net/ethernet/intel/ice/ice.h                              |   32 
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h                   |    4 
 drivers/net/ethernet/intel/ice/ice_common.c                       |    9 
 drivers/net/ethernet/intel/ice/ice_controlq.c                     |    3 
 drivers/net/ethernet/intel/ice/ice_flow.c                         |   23 
 drivers/net/ethernet/intel/ice/ice_lib.c                          |   46 
 drivers/net/ethernet/intel/ice/ice_nvm.c                          |   28 
 drivers/net/ethernet/intel/ice/ice_sched.c                        |   90 -
 drivers/net/ethernet/intel/ice/ice_sched.h                        |   27 
 drivers/net/ethernet/intel/ice/ice_switch.c                       |   19 
 drivers/net/ethernet/intel/ice/ice_type.h                         |    8 
 drivers/net/ethernet/intel/ice/ice_xsk.c                          |   13 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c               |   33 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                 |    3 
 drivers/net/ethernet/mellanox/mlx5/core/fw.c                      |    4 
 drivers/net/ethernet/mellanox/mlx5/core/health.c                  |   12 
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c            |    8 
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c             |    4 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                    |   86 -
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                   |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                   |   25 
 drivers/net/geneve.c                                              |   10 
 drivers/net/phy/sfp.c                                             |    3 
 drivers/net/vxlan/vxlan_core.c                                    |    4 
 drivers/net/wireless/ath/ath10k/Kconfig                           |    1 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                      |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                       |   10 
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h                       |    9 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                     |    4 
 drivers/net/wwan/iosm/iosm_ipc_devlink.c                          |    2 
 drivers/nvme/target/passthru.c                                    |    6 
 drivers/pci/controller/pcie-rockchip-ep.c                         |    6 
 drivers/platform/x86/dell/dell-smbios-base.c                      |   92 -
 drivers/ptp/ptp_chardev.c                                         |    3 
 drivers/remoteproc/ti_k3_r5_remoteproc.c                          |   58 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                  |   62 
 drivers/scsi/mpt3sas/mpt3sas_base.c                               |   19 
 drivers/scsi/mpt3sas/mpt3sas_base.h                               |    3 
 drivers/scsi/mpt3sas/mpt3sas_ctl.c                                |    4 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                              |   23 
 drivers/scsi/scsi_transport_sas.c                                 |   23 
 drivers/scsi/sd.c                                                 |   17 
 drivers/spmi/hisi-spmi-controller.c                               |    1 
 drivers/thunderbolt/debugfs.c                                     |    5 
 drivers/tty/n_tty.c                                               |   22 
 drivers/tty/serial/8250/8250_dw.c                                 |    5 
 drivers/tty/serial/8250/8250_pxa.c                                |    1 
 drivers/tty/serial/sc16is7xx.c                                    |   25 
 drivers/usb/Makefile                                              |    1 
 drivers/usb/class/cdc-wdm.c                                       |    4 
 drivers/usb/gadget/function/f_fs.c                                |    9 
 drivers/usb/host/xhci-pci.c                                       |    7 
 drivers/usb/host/xhci-ring.c                                      |   59 
 drivers/usb/host/xhci.h                                           |    1 
 drivers/usb/storage/alauda.c                                      |    9 
 drivers/usb/typec/tcpm/tcpm.c                                     |    5 
 fs/btrfs/disk-io.c                                                |   26 
 fs/btrfs/extent_map.c                                             |    2 
 fs/btrfs/zoned.c                                                  |  330 ++-
 fs/cachefiles/daemon.c                                            |    4 
 fs/cachefiles/interface.c                                         |    7 
 fs/cachefiles/internal.h                                          |   52 
 fs/cachefiles/ondemand.c                                          |  320 ++-
 fs/jfs/xattr.c                                                    |    4 
 fs/nfs/dir.c                                                      |   47 
 fs/nfs/nfs4proc.c                                                 |   23 
 fs/nfsd/nfsfh.c                                                   |    4 
 fs/nilfs2/dir.c                                                   |   59 
 fs/nilfs2/segment.c                                               |    3 
 fs/ocfs2/file.c                                                   |    2 
 fs/ocfs2/namei.c                                                  |    2 
 fs/proc/vmcore.c                                                  |    2 
 include/linux/i2c.h                                               |   24 
 include/linux/pse-pd/pse.h                                        |    4 
 include/linux/serial_core.h                                       |    1 
 include/net/bluetooth/hci_core.h                                  |   36 
 include/net/ip_tunnels.h                                          |    5 
 include/scsi/scsi_transport_sas.h                                 |    2 
 include/trace/events/cachefiles.h                                 |    8 
 io_uring/kbuf.c                                                   |    3 
 kernel/events/core.c                                              |   13 
 kernel/fork.c                                                     |   18 
 kernel/pid_namespace.c                                            |    1 
 kernel/time/tick-common.c                                         |   42 
 mm/memory-failure.c                                               |   11 
 mm/vmalloc.c                                                      |   29 
 net/ax25/af_ax25.c                                                |    6 
 net/ax25/ax25_dev.c                                               |    2 
 net/bluetooth/l2cap_core.c                                        |    8 
 net/bpf/test_run.c                                                |    6 
 net/bridge/br_mst.c                                               |   13 
 net/core/sock_map.c                                               |   16 
 net/ipv4/tcp.c                                                    |    6 
 net/ipv6/ioam6_iptunnel.c                                         |    8 
 net/ipv6/ip6_fib.c                                                |    6 
 net/ipv6/route.c                                                  |    5 
 net/ipv6/seg6_iptunnel.c                                          |   14 
 net/ipv6/tcp_ipv6.c                                               |    3 
 net/mac80211/he.c                                                 |   10 
 net/mac80211/mesh_pathtbl.c                                       |   13 
 net/mac80211/sta_info.c                                           |    4 
 net/mptcp/pm_netlink.c                                            |   21 
 net/mptcp/protocol.c                                              |    1 
 net/ncsi/internal.h                                               |    2 
 net/ncsi/ncsi-manage.c                                            |   93 -
 net/ncsi/ncsi-rsp.c                                               |    4 
 net/netfilter/ipset/ip_set_core.c                                 |   81 
 net/netfilter/ipset/ip_set_list_set.c                             |   30 
 net/sched/sch_multiq.c                                            |    2 
 net/sched/sch_taprio.c                                            |   15 
 net/smc/af_smc.c                                                  |   22 
 net/sunrpc/auth_gss/auth_gss.c                                    |    4 
 net/unix/af_unix.c                                                |  109 -
 net/unix/diag.c                                                   |   12 
 net/wireless/core.c                                               |    2 
 net/wireless/pmsr.c                                               |    8 
 net/wireless/sysfs.c                                              |    4 
 net/wireless/util.c                                               |    7 
 security/landlock/fs.c                                            |   13 
 tools/testing/cxl/test/mem.c                                      |    1 
 tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc |    2 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc  |    3 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                   |    5 
 tools/testing/selftests/vm/compaction_test.c                      |  108 -
 197 files changed, 2924 insertions(+), 3011 deletions(-)

Aapo Vienamo (1):
      thunderbolt: debugfs: Fix margin debugfs node creation condition

Adam Miotk (1):
      drm/bridge/panel: Fix runtime warning on panel bridge release

Alan Stern (1):
      USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

Aleksandr Mishin (4):
      net/mlx5: Fix tainted pointer delete is case of flow rules creation fail
      net: wwan: iosm: Fix tainted pointer delete is case of region creation fail
      liquidio: Adjust a NULL pointer handling path in lio_vf_rep_copy_packet
      bnxt_en: Adjust logging of firmware messages in case of released token in __hwrm_send()

Alexander Shishkin (5):
      intel_th: pci: Add Granite Rapids support
      intel_th: pci: Add Granite Rapids SOC support
      intel_th: pci: Add Sapphire Rapids SOC support
      intel_th: pci: Add Meteor Lake-S support
      intel_th: pci: Add Lunar Lake support

Alexey Kodanev (1):
      drm/amd/display: drop unnecessary NULL checks in debugfs

Amit Sunil Dhamne (1):
      usb: typec: tcpm: fix use-after-free case in tcpm_register_source_caps

Amjad Ouled-Ameur (1):
      drm/komeda: check for error-valued pointer

Andrei Coardos (1):
      gpio: tqmx86: remove unneeded call to platform_set_drvdata()

Andy Shevchenko (1):
      serial: core: Add UPIO_UNKNOWN constant for unknown port type

Apurva Nandan (1):
      remoteproc: k3-r5: Wait for core0 power-up before powering up core1

Armin Wolf (1):
      platform/x86: dell-smbios: Fix wrong token data in sysfs

Baokun Li (9):
      cachefiles: add output string to cachefiles_obj_[get|put]_ondemand_fd
      cachefiles: remove requests from xarray during flushing requests
      cachefiles: add spin_lock for cachefiles_ondemand_info
      cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
      cachefiles: fix slab-use-after-free in cachefiles_ondemand_daemon_read()
      cachefiles: remove err_put_fd label in cachefiles_ondemand_daemon_read()
      cachefiles: never get a new anonymous fd if ondemand_id is valid
      cachefiles: defer exposing anon_fd until after copy_to_user() succeeds
      cachefiles: flush all requests after setting CACHEFILES_DEAD

Beleswar Padhi (2):
      remoteproc: k3-r5: Do not allow core1 to power up before core0 via sysfs
      remoteproc: k3-r5: Jump to error handling labels in start/stop errors

Benjamin Segall (1):
      x86/boot: Don't add the EFI stub to targets, again

Breno Leitao (1):
      scsi: mpt3sas: Avoid test/set_bit() operating in non-allocated memory

Chen Hanxiao (1):
      SUNRPC: return proper error from gss_wrap_req_priv

Chris Wilson (1):
      drm/i915/gt: Disarm breadcrumbs if engines are already idle

Christoph Hellwig (4):
      btrfs: zoned: introduce a zone_info struct in btrfs_load_block_group_zone_info
      btrfs: zoned: factor out per-zone logic from btrfs_load_block_group_zone_info
      btrfs: zoned: factor out single bg handling from btrfs_load_block_group_zone_info
      btrfs: zoned: factor out DUP bg handling from btrfs_load_block_group_zone_info

Cong Yang (1):
      HID: i2c-hid: elan: Add ili9882t timing

Csókás, Bence (1):
      net: sfp: Always call `sfp_sm_mod_remove()` on remove

Damien Le Moal (2):
      scsi: mpi3mr: Fix ATA NCQ priority support
      null_blk: Print correct max open zones limit in null_init_zoned_dev()

Daniel Borkmann (1):
      vxlan: Fix regression when dropping packets due to invalid src addresses

Daniel Wagner (1):
      nvmet-passthru: propagate status from id override functions

Dave Jiang (1):
      cxl/test: Add missing vmalloc.h for tools/testing/cxl/test/mem.c

David Howells (1):
      cachefiles, erofs: Fix NULL deref in when cachefiles is not doing ondemand-mode

David Lechner (1):
      iio: adc: ad9467: fix scan type sign

DelphineCCChiu (1):
      net/ncsi: Fix the multi thread manner of NCSI driver

Dev Jain (2):
      selftests/mm: compaction_test: fix incorrect write of zero to nr_hugepages
      selftests/mm: compaction_test: fix bogus test success on Aarch64

Dirk Behme (1):
      drivers: core: synchronize really_probe() and dev_uevent()

Dmitry Baryshkov (1):
      wifi: ath10k: fix QCOM_RPROC_COMMON dependency

Dmitry Torokhov (1):
      Input: try trimming too long modalias strings

Doug Brown (1):
      serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level

Duoming Zhou (1):
      ax25: Replace kfree() in ax25_dev_free() with ax25_dev_put()

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: don't read past the mfuart notifcation

Eric Dumazet (6):
      ipv6: ioam: block BH from ioam6_output()
      ipv6: sr: block BH in seg6_output_core() and seg6_input_core()
      net/sched: taprio: always validate TCA_TAPRIO_ATTR_PRIOMAP
      af_unix: annotate lockless accesses to sk->sk_err
      ipv6: fix possible race in __fib6_drop_pcpu_from()
      tcp: fix race in tcp_v6_syn_recv_sock()

Filipe Manana (4):
      btrfs: remove unnecessary prototype declarations at disk-io.c
      btrfs: make btrfs_destroy_delayed_refs() return void
      btrfs: fix leak of qgroup extent records after transaction abort
      btrfs: zoned: fix use-after-free due to race with dev replace

Gabor Juhos (1):
      firmware: qcom_scm: disable clocks if qcom_scm_bw_enable() fails

Gal Pressman (2):
      geneve: Fix incorrect inner network header offset when innerprotoinherit is set
      net/mlx5e: Fix features validation check for tunneled UDP (non-VXLAN) packets

Greg Kroah-Hartman (2):
      jfs: xattr: fix buffer overflow for invalid xattr
      Linux 6.1.95

Gregor Herburger (1):
      gpio: tqmx86: fix typo in Kconfig label

Hagar Gamal Halim Hemdan (1):
      vmci: prevent speculation leaks by sanitizing event in event_deliver()

Hagar Hemdan (1):
      irqchip/gic-v3-its: Fix potential race condition in its_vlpi_prop_update()

Haifeng Xu (1):
      perf/core: Fix missing wakeup when waiting for context reference

Hailong.Liu (1):
      mm/vmalloc: fix vmalloc which may return null if called with __GFP_NOFAIL

Hamish Martin (1):
      i2c: acpi: Unbind mux adapters before delete

Hangyu Hua (1):
      net: sched: sch_multiq: fix possible OOB write in multiq_tune()

Hans de Goede (1):
      iio: accel: mxc4005: Reset chip on probe() and resume()

Hector Martin (1):
      xhci: Handle TD clearing for multiple streams case

Hersen Wu (1):
      drm/amd/display: Fix incorrect DSC instance for MST

Hugo Villeneuve (2):
      serial: sc16is7xx: replace hardcoded divisor value with BIT() macro
      serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when using prescaler

Ian Forbes (3):
      drm/vmwgfx: Filter modes which exceed graphics memory
      drm/vmwgfx: 3D disabled should not effect STDU memory limits
      drm/vmwgfx: Remove STDU logic from generic mode_valid function

Ilpo Järvinen (1):
      tty: n_tty: Fix buffer offsets when lookahead is used

Jacob Keller (1):
      ice: fix iteration of TLVs in Preserved Fields Area

Jani Nikula (1):
      drm/exynos/vidi: fix memory leak in .get_modes()

Jason Xing (1):
      tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB

Jean Delvare (2):
      i2c: at91: Fix the functionality flags of the slave-only interface
      i2c: designware: Fix the functionality flags of the slave-only interface

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: delete unneeded update watermark call

Jens Axboe (1):
      io_uring: check for non-NULL file pointer in io_file_can_poll()

Jia Zhu (4):
      cachefiles: introduce object ondemand state
      cachefiles: extract ondemand info field from cachefiles_object
      cachefiles: resend an open request if the read request's object is closed
      cachefiles: add restore command to recover inflight ondemand read requests

Jie Wang (1):
      net: hns3: add cond_resched() to hns3 ring buffer init process

Jiri Olsa (1):
      bpf: Set run context for rawtp test_run callback

Jisheng Zhang (1):
      serial: 8250_dw: fall back to poll if there's no interrupt

Johan Hovold (4):
      Bluetooth: qca: fix invalid device address check
      HID: i2c-hid: elan: fix reset suspend current leakage
      Bluetooth: qca: fix wcn3991 device address check
      Bluetooth: qca: generalise device address check

Johannes Berg (2):
      wifi: cfg80211: fully move wiphy work to unbound workqueue
      wifi: iwlwifi: mvm: revert gen2 TX A-MPDU size to 64

John Ernberg (1):
      USB: xen-hcd: Traverse host/ when CONFIG_USB_XEN_HCD is selected

John Keeping (1):
      usb: gadget: f_fs: use io_data->status consistently

Joshua Washington (1):
      gve: ignore nonrelevant GSO type bits when processing TSO headers

José Expósito (1):
      HID: logitech-dj: Fix memory leak in logi_dj_recv_switch_to_dj_mode()

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix race between namespace cleanup and gc in the list:set type

Karol Kolacinski (1):
      ptp: Fix error message on failed pin verification

Kory Maincent (1):
      net: pse-pd: Use EOPNOTSUPP error code instead of ENOTSUPP

Krzysztof Kozlowski (1):
      arm64: dts: qcom: sm8150: align TLMM pin configuration with DT schema

Kuangyi Chiang (2):
      xhci: Apply reset resume quirk to Etron EJ188 xHCI host
      xhci: Apply broken streams quirk to Etron EJ188 xHCI host

Kun(llfl) (1):
      iommu/amd: Fix sysfs leak in iommu init

Kuniyuki Iwashima (13):
      af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
      af_unix: Annodate data-races around sk->sk_state for writers.
      af_unix: Annotate data-race of sk->sk_state in unix_inq_len().
      af_unix: Annotate data-races around sk->sk_state in unix_write_space() and poll().
      af_unix: Annotate data-race of sk->sk_state in unix_stream_connect().
      af_unix: Annotate data-races around sk->sk_state in sendmsg() and recvmsg().
      af_unix: Annotate data-race of sk->sk_state in unix_stream_read_skb().
      af_unix: Annotate data-races around sk->sk_state in UNIX_DIAG.
      af_unix: Annotate data-race of net->unx.sysctl_max_dgram_qlen.
      af_unix: Use unix_recvq_full_lockless() in unix_stream_connect().
      af_unix: Use skb_queue_empty_lockless() in unix_release_sock().
      af_unix: Use skb_queue_len_lockless() in sk_diag_show_rqlen().
      af_unix: Annotate data-race of sk->sk_shutdown in sk_diag_fill().

Kyle Tso (1):
      usb: typec: tcpm: Ignore received Hard Reset in TOGGLING state

Lars Kellogg-Stedman (1):
      ax25: Fix refcount imbalance on inbound connections

Larysa Zaremba (1):
      ice: remove af_xdp_zc_qps bitmap

Lin Ma (1):
      wifi: cfg80211: pmsr: use correct nla_get_uX functions

Lingbo Kong (1):
      wifi: mac80211: correctly parse Spatial Reuse Parameter Set element

Linus Walleij (1):
      gpio: tqmx86: Convert to immutable irq_chip

Luca Ceresoli (1):
      iio: accel: mxc4005: allow module autoloading via OF compatible

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ

Marc Ferland (1):
      iio: dac: ad5592r: fix temperature channel scaling value

Marek Szyprowski (1):
      drm/exynos: hdmi: report safe 640x480 mode as a fallback when no EDID found

Mark Brown (1):
      selftests/mm: log a consistent test name for check_compaction

Martin K. Petersen (1):
      scsi: sd: Use READ(16) when reading block zero on large capacity disks

Martin Krastev (1):
      drm/vmwgfx: Refactor drm connector probing for display modes

Masami Hiramatsu (Google) (1):
      selftests/ftrace: Fix to check required event file

Mathias Nyman (1):
      xhci: Set correct transferred length for cancelled bulk transfers

Matthew Wilcox (Oracle) (1):
      nilfs2: return the mapped address from nilfs_get_page()

Matthias Schiffer (3):
      gpio: tqmx86: introduce shadow register for GPIO output value
      gpio: tqmx86: store IRQ trigger type and unmask status separately
      gpio: tqmx86: fix broken IRQ_TYPE_EDGE_BOTH interrupt type

Max Filippov (1):
      xtensa: fix MAKE_PC_FROM_RA second argument

Miaohe Lin (2):
      mm/huge_memory: don't unpoison huge_zero_folio
      mm/memory-failure: fix handling of dissolved but not taken off from buddy pages

Michael Ellerman (1):
      powerpc/uaccess: Fix build errors seen with GCC 13/14

Michal Hocko (1):
      mm, vmalloc: fix high order __GFP_NOFAIL allocations

Michal Wilczynski (1):
      ice: Introduce new parameters in ice_sched_node

Mickaël Salaün (1):
      landlock: Fix d_parent walk

Miri Korenblit (1):
      wifi: iwlwifi: mvm: check n_ssids before accessing the ssids

Moshe Shemesh (2):
      net/mlx5: Stop waiting for PCI up if teardown was triggered
      net/mlx5: Stop waiting for PCI if pci channel is offline

Muhammad Usama Anjum (1):
      selftests/mm: conform test to TAP format output

Nam Cao (2):
      riscv: fix overlap of allocated page and PTR_ERR
      riscv: rewrite __kernel_map_pages() to fix sleeping in invalid context

NeilBrown (1):
      NFS: add barriers when testing for NFS_FSDATA_BLOCKED

Nicolas Escande (1):
      wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects

Nikita Zhandarovich (1):
      HID: core: remove unnecessary WARN_ON() in implement()

Nikolay Aleksandrov (2):
      net: bridge: mst: pass vlan group directly to br_mst_vlan_set_state
      net: bridge: mst: fix suspicious rcu usage in br_mst_set_state

Nuno Sa (1):
      dmaengine: axi-dmac: fix possible race in remove()

Oleg Nesterov (2):
      tick/nohz_full: Don't abuse smp_call_function_single() in tick_setup_device()
      zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING

Olga Kornievskaia (1):
      NFSv4.1 enforce rootpath check in fs_location query

Paolo Abeni (1):
      mptcp: ensure snd_una is properly initialized on connect

Peter Delevoryas (1):
      net/ncsi: Simplify Kconfig/dts control flow

Petr Pavlu (1):
      net/ipv6: Fix the RT cache flush via sysctl using a previous delay

Przemek Kitszel (1):
      ice: remove null checks before devm_kfree() calls

Qu Wenruo (1):
      btrfs: fix wrong block_start calculation for btrfs_drop_extent_map_range()

Randy Dunlap (1):
      xtensa: stacktrace: include <asm/ftrace.h> for prototype

Rao Shoaib (1):
      af_unix: Read with MSG_PEEK loops if the first unread byte is OOB

Remi Pommarel (2):
      wifi: mac80211: Fix deadlock in ieee80211_sta_ps_deliver_wakeup()
      wifi: cfg80211: Lock wiphy in cfg80211_get_station

Rick Wertenbroek (1):
      PCI: rockchip-ep: Remove wrong mask on subsys_vendor_id

Rik van Riel (1):
      fs/proc: fix softlockup in __read_vmcore

Russell King (Oracle) (1):
      i2c: add fwnode APIs

Ryusuke Konishi (2):
      nilfs2: fix nilfs_empty_dir() misjudgment and long loop on I/O errors
      nilfs2: fix potential kernel bug due to lack of writeback flag waiting

Sam James (1):
      Revert "fork: defer linking file vma until vma is fully initialized"

Samuel Holland (1):
      clk: sifive: Do not register clkdevs for PRCI clocks

Shahar S Matityahu (1):
      wifi: iwlwifi: dbg_ini: move iwl_dbg_tlv_free outside of debugfs ifdef

Shay Drory (2):
      net/mlx5: Split function_setup() to enable and open functions
      net/mlx5: Always stop health timer during driver removal

Shichao Lai (1):
      usb-storage: alauda: Check whether the media is initialized

Sicong Huang (1):
      greybus: Fix use-after-free bug in gb_interface_release due to race condition.

Steven Rostedt (Google) (1):
      tracing/selftests: Fix kprobe event name test for .isra. functions

Su Yue (2):
      ocfs2: use coarse time for new created files
      ocfs2: fix races between hole punching and AIO+DIO

Subbaraya Sundeep (1):
      octeontx2-af: Always allocate PF entries from low prioriy zone

Taehee Yoo (1):
      ionic: fix use after netif_napi_del()

Thadeu Lima de Souza Cascardo (1):
      sock_map: avoid race between sock_map_close and sk_psock_put

Thomas Weißschuh (2):
      misc/pvpanic: deduplicate common code
      misc/pvpanic-pci: register attributes via pci_driver

Tomas Winkler (1):
      mei: me: release irq in mei_me_pci_resume error path

Trond Myklebust (1):
      knfsd: LOOKUP can return an illegal error value

Uwe Kleine-König (1):
      mmc: davinci: Don't strip remove function when driver is builtin

Vamshi Gajjela (1):
      spmi: hisi-spmi-controller: Do not override device identifier

Vidya Srinivas (1):
      drm/i915/dpt: Make DPT object unshrinkable

Volodymyr Babchuk (1):
      arm64: dts: qcom: sa8155p-adp: fix SDHC2 CD pin configuration

Wen Gu (1):
      net/smc: avoid overwriting when adjusting sock bufsizes

Wesley Cheng (1):
      usb: gadget: f_fs: Fix race between aio_cancel() and AIO request complete

Xiaolei Wang (1):
      net: stmmac: replace priv->speed with the portTransmitRate from the tc-cbs parameters

Yazen Ghannam (1):
      x86/amd_nb: Check for invalid SMN reads

Yonglong Liu (1):
      net: hns3: fix kernel crash problem in concurrent scenario

YonglongLi (2):
      mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID
      mptcp: pm: update add_addr counters after connect

Yongzhi Liu (2):
      misc: microchip: pci1xxxx: fix double free in the error handling of gp_aux_bus_probe()
      misc: microchip: pci1xxxx: Fix a memory leak in the error handling of gp_aux_bus_probe()

Zack Rusin (1):
      drm/vmwgfx: Port the framebuffer code to drm fb helpers

Ziwei Xiao (1):
      gve: Clear napi->skb before dev_kfree_skb_any()


