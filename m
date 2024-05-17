Return-Path: <stable+bounces-45387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B506A8C85FB
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 13:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B05B2280E
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 11:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C714405FC;
	Fri, 17 May 2024 11:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hKsK+QKD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F304F8BC;
	Fri, 17 May 2024 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947112; cv=none; b=c/wBfQdfhFrnSH802W8DuaiUc0V+pX8svB211tvNJEzNrt32fug3/lBgJulzRvqT3XsA5bUw1O3fdTvcpdQfM4miXVU8exehLRE6urwlK21vzAoLyf4P+I46wggypmu5PSSRyV4eDj1kOd6/44rszQOD+VHUnSrNApb9tnrUFpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947112; c=relaxed/simple;
	bh=+zvpSF+B0ngfkJbmhwLLattnvGXXjIYMGtJEYDzwTxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BTzGDz5Mandi88AP5kSWb/Uhlrik/gMAkYtGmsD1q4GgnYkj3cljmwbkDX6aIMFcC81BkxnVhI/H9wUREtRpwDhZImu8qCL6Ky5CKczhyGjimJY0mDnb5XIpFgB1ESA1tPuetqoj4LnyYXOezJ2tpKq0gL6UFMYr7cptKFXWLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hKsK+QKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BEBC2BD11;
	Fri, 17 May 2024 11:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715947111;
	bh=+zvpSF+B0ngfkJbmhwLLattnvGXXjIYMGtJEYDzwTxY=;
	h=From:To:Cc:Subject:Date:From;
	b=hKsK+QKDy5ryVilI9yecFAsTBPq1/RTM40S/sbpFsyHtzV+PFJ3Vs5U0na7EJIOY8
	 QlOeR2ueSZEf6Zq1IAYRLbpMfeTtoMKTjJFwK4Ar+WlUUz5VnTYdxKumcN+lM8qnfn
	 J5HWRgn/DE9iz97r51ah2JvzIlk7MgaTKumP9HM8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.91
Date: Fri, 17 May 2024 13:58:27 +0200
Message-ID: <2024051728-hypocrisy-armband-32a1@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.91 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml |    2 
 MAINTAINERS                                                      |    1 
 Makefile                                                         |    2 
 arch/arm/kernel/sleep.S                                          |    4 
 arch/arm64/kvm/vgic/vgic-kvm-device.c                            |   12 
 arch/arm64/net/bpf_jit_comp.c                                    |    6 
 arch/mips/include/asm/ptrace.h                                   |    2 
 arch/mips/kernel/asm-offsets.c                                   |    1 
 arch/mips/kernel/ptrace.c                                        |   15 
 arch/mips/kernel/scall32-o32.S                                   |   23 
 arch/mips/kernel/scall64-n32.S                                   |    3 
 arch/mips/kernel/scall64-n64.S                                   |    3 
 arch/mips/kernel/scall64-o32.S                                   |   33 -
 arch/powerpc/platforms/pseries/iommu.c                           |    8 
 arch/powerpc/platforms/pseries/plpks.c                           |   62 --
 arch/powerpc/platforms/pseries/plpks.h                           |   35 +
 arch/s390/include/asm/dwarf.h                                    |    1 
 arch/s390/kernel/vdso64/vdso_user_wrapper.S                      |    2 
 arch/s390/mm/gmap.c                                              |    2 
 arch/s390/mm/hugetlbpage.c                                       |    2 
 block/blk-iocost.c                                               |    7 
 block/ioctl.c                                                    |    5 
 drivers/ata/sata_gemini.c                                        |    5 
 drivers/bluetooth/btqca.c                                        |  160 +++++
 drivers/bluetooth/btqca.h                                        |    6 
 drivers/bluetooth/hci_qca.c                                      |   11 
 drivers/char/tpm/tpm-dev-common.c                                |    4 
 drivers/clk/clk.c                                                |   12 
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c                             |   19 
 drivers/dma/idxd/cdev.c                                          |   77 ++
 drivers/dma/idxd/idxd.h                                          |    3 
 drivers/dma/idxd/init.c                                          |    4 
 drivers/dma/idxd/registers.h                                     |    3 
 drivers/dma/idxd/sysfs.c                                         |   27 
 drivers/firewire/nosy.c                                          |    6 
 drivers/firewire/ohci.c                                          |    6 
 drivers/gpio/gpio-crystalcove.c                                  |    2 
 drivers/gpio/gpio-wcove.c                                        |    2 
 drivers/gpio/gpiolib-cdev.c                                      |  183 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                          |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                       |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h                       |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                          |   48 -
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                         |    7 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c               |    1 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c             |    2 
 drivers/gpu/drm/drm_connector.c                                  |    2 
 drivers/gpu/drm/i915/display/intel_bios.c                        |   19 
 drivers/gpu/drm/i915/display/intel_vbt_defs.h                    |    5 
 drivers/gpu/drm/meson/meson_dw_hdmi.c                            |   70 +-
 drivers/gpu/drm/nouveau/nouveau_dp.c                             |   13 
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c                     |    8 
 drivers/gpu/drm/qxl/qxl_release.c                                |   50 -
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c                            |    2 
 drivers/gpu/host1x/bus.c                                         |    8 
 drivers/hv/channel.c                                             |   29 -
 drivers/hwmon/corsair-cpro.c                                     |   45 +
 drivers/hwmon/pmbus/ucd9000.c                                    |    6 
 drivers/iio/accel/mxc4005.c                                      |   24 
 drivers/iio/imu/adis16475.c                                      |    4 
 drivers/infiniband/hw/qib/qib_fs.c                               |    1 
 drivers/iommu/mtk_iommu.c                                        |    1 
 drivers/iommu/mtk_iommu_v1.c                                     |    1 
 drivers/md/md.c                                                  |    1 
 drivers/misc/eeprom/at24.c                                       |   46 +
 drivers/misc/mei/hw-me-regs.h                                    |    2 
 drivers/misc/mei/pci-me.c                                        |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                                 |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                   |   32 -
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                   |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c               |    8 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                     |   25 
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c                  |    4 
 drivers/net/ethernet/chelsio/cxgb4/sge.c                         |    6 
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                      |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c          |   52 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h          |    5 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c           |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c        |   20 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h        |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c          |    4 
 drivers/net/ethernet/micrel/ks8851_common.c                      |   16 
 drivers/net/ethernet/qlogic/qede/qede_filter.c                   |   14 
 drivers/net/usb/qmi_wwan.c                                       |    1 
 drivers/net/vxlan/vxlan_core.c                                   |   19 
 drivers/nvme/host/core.c                                         |    2 
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c                       |   34 -
 drivers/pinctrl/core.c                                           |    8 
 drivers/pinctrl/devicetree.c                                     |   10 
 drivers/pinctrl/intel/pinctrl-baytrail.c                         |   74 +-
 drivers/pinctrl/intel/pinctrl-intel.c                            |    6 
 drivers/pinctrl/intel/pinctrl-intel.h                            |   17 
 drivers/pinctrl/mediatek/pinctrl-paris.c                         |   40 -
 drivers/pinctrl/meson/pinctrl-meson-a1.c                         |    6 
 drivers/power/supply/mt6360_charger.c                            |    2 
 drivers/power/supply/rt9455_charger.c                            |    2 
 drivers/regulator/core.c                                         |   27 
 drivers/regulator/mt6360-regulator.c                             |   32 -
 drivers/s390/cio/cio_inject.c                                    |    2 
 drivers/s390/net/qeth_core_main.c                                |   61 --
 drivers/scsi/bnx2fc/bnx2fc_tgt.c                                 |    2 
 drivers/scsi/lpfc/lpfc.h                                         |    1 
 drivers/scsi/lpfc/lpfc_els.c                                     |   20 
 drivers/scsi/lpfc/lpfc_hbadisc.c                                 |    5 
 drivers/scsi/lpfc/lpfc_nvme.c                                    |    4 
 drivers/scsi/lpfc/lpfc_scsi.c                                    |   13 
 drivers/scsi/lpfc/lpfc_sli.c                                     |   14 
 drivers/scsi/lpfc/lpfc_vport.c                                   |    8 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                 |    2 
 drivers/slimbus/qcom-ngd-ctrl.c                                  |    6 
 drivers/spi/spi-axi-spi-engine.c                                 |  273 +++++-----
 drivers/spi/spi-hisi-kunpeng.c                                   |    2 
 drivers/spi/spi-microchip-core-qspi.c                            |    1 
 drivers/spi/spi.c                                                |   12 
 drivers/staging/wlan-ng/hfa384x_usb.c                            |    4 
 drivers/staging/wlan-ng/prism2usb.c                              |    6 
 drivers/target/target_core_configfs.c                            |   12 
 drivers/ufs/core/ufshcd.c                                        |    5 
 drivers/uio/uio_hv_generic.c                                     |   12 
 drivers/usb/core/hub.c                                           |    5 
 drivers/usb/core/port.c                                          |    8 
 drivers/usb/dwc3/core.c                                          |   90 +--
 drivers/usb/dwc3/core.h                                          |    1 
 drivers/usb/dwc3/gadget.c                                        |    2 
 drivers/usb/dwc3/host.c                                          |   27 
 drivers/usb/gadget/composite.c                                   |    6 
 drivers/usb/gadget/function/f_fs.c                               |    2 
 drivers/usb/host/ohci-hcd.c                                      |    8 
 drivers/usb/host/xhci-plat.h                                     |    4 
 drivers/usb/typec/tcpm/tcpm.c                                    |   35 -
 drivers/usb/typec/ucsi/ucsi.c                                    |   12 
 drivers/vfio/pci/vfio_pci.c                                      |    2 
 fs/9p/vfs_file.c                                                 |    2 
 fs/9p/vfs_inode.c                                                |    5 
 fs/9p/vfs_super.c                                                |    1 
 fs/btrfs/extent_io.c                                             |   19 
 fs/btrfs/inode.c                                                 |    2 
 fs/btrfs/send.c                                                  |    4 
 fs/btrfs/transaction.c                                           |    2 
 fs/btrfs/volumes.c                                               |   18 
 fs/gfs2/bmap.c                                                   |    5 
 fs/hugetlbfs/inode.c                                             |    8 
 fs/nfs/client.c                                                  |    5 
 fs/nfs/inode.c                                                   |   13 
 fs/nfs/internal.h                                                |    2 
 fs/nfs/netns.h                                                   |    2 
 fs/smb/client/transport.c                                        |   37 +
 fs/smb/server/oplock.c                                           |   35 -
 fs/smb/server/transport_tcp.c                                    |    4 
 include/linux/compiler_types.h                                   |   11 
 include/linux/dma-fence.h                                        |    7 
 include/linux/gfp_types.h                                        |    2 
 include/linux/hugetlb.h                                          |   53 +
 include/linux/hugetlb_cgroup.h                                   |   69 +-
 include/linux/hyperv.h                                           |    1 
 include/linux/mm_types.h                                         |   14 
 include/linux/pci_ids.h                                          |    2 
 include/linux/pinctrl/pinctrl.h                                  |   20 
 include/linux/regulator/consumer.h                               |    4 
 include/linux/skbuff.h                                           |   15 
 include/linux/skmsg.h                                            |    2 
 include/linux/slab.h                                             |    2 
 include/linux/spi/spi.h                                          |   51 +
 include/linux/sunrpc/clnt.h                                      |    1 
 include/linux/swapops.h                                          |  105 +--
 include/linux/timer.h                                            |   15 
 include/net/xfrm.h                                               |    3 
 include/uapi/scsi/scsi_bsg_mpi3mr.h                              |    2 
 kernel/bpf/bloom_filter.c                                        |   13 
 kernel/bpf/verifier.c                                            |    3 
 kernel/time/timer.c                                              |    8 
 lib/Kconfig.debug                                                |    5 
 lib/dynamic_debug.c                                              |    6 
 mm/hugetlb.c                                                     |   55 +-
 mm/hugetlb_cgroup.c                                              |   34 -
 mm/migrate.c                                                     |    2 
 mm/readahead.c                                                   |    4 
 net/bluetooth/hci_core.c                                         |    3 
 net/bluetooth/l2cap_core.c                                       |    3 
 net/bluetooth/msft.c                                             |    2 
 net/bluetooth/msft.h                                             |    4 
 net/bluetooth/sco.c                                              |    4 
 net/bridge/br_forward.c                                          |    9 
 net/bridge/br_netlink.c                                          |    3 
 net/core/filter.c                                                |   42 +
 net/core/link_watch.c                                            |    4 
 net/core/net-sysfs.c                                             |    4 
 net/core/net_namespace.c                                         |   13 
 net/core/rtnetlink.c                                             |    6 
 net/core/skbuff.c                                                |   27 
 net/core/skmsg.c                                                 |    5 
 net/core/sock.c                                                  |    4 
 net/hsr/hsr_device.c                                             |   31 -
 net/ipv4/tcp.c                                                   |    4 
 net/ipv4/tcp_input.c                                             |    2 
 net/ipv4/tcp_ipv4.c                                              |    8 
 net/ipv4/tcp_output.c                                            |    4 
 net/ipv4/udp_offload.c                                           |   12 
 net/ipv4/xfrm4_input.c                                           |    6 
 net/ipv6/addrconf.c                                              |   11 
 net/ipv6/fib6_rules.c                                            |    6 
 net/ipv6/ip6_input.c                                             |    4 
 net/ipv6/ip6_output.c                                            |    2 
 net/ipv6/xfrm6_input.c                                           |    6 
 net/l2tp/l2tp_eth.c                                              |    3 
 net/mac80211/ieee80211_i.h                                       |    4 
 net/mptcp/protocol.c                                             |    3 
 net/nsh/nsh.c                                                    |   14 
 net/phonet/pn_netlink.c                                          |    2 
 net/smc/smc_ib.c                                                 |   19 
 net/sunrpc/clnt.c                                                |    5 
 net/sunrpc/xprt.c                                                |    2 
 net/tipc/msg.c                                                   |    8 
 net/wireless/nl80211.c                                           |    2 
 net/wireless/trace.h                                             |    2 
 net/xfrm/xfrm_input.c                                            |    8 
 rust/Makefile                                                    |   11 
 rust/kernel/error.rs                                             |    2 
 rust/kernel/lib.rs                                               |    2 
 rust/macros/module.rs                                            |  185 ++++--
 scripts/Makefile.build                                           |   17 
 scripts/Makefile.host                                            |   27 
 scripts/Makefile.modfinal                                        |    4 
 scripts/is_rust_module.sh                                        |   16 
 security/keys/key.c                                              |    3 
 sound/hda/intel-sdw-acpi.c                                       |    2 
 sound/pci/hda/patch_realtek.c                                    |    1 
 sound/soc/meson/Kconfig                                          |    1 
 sound/soc/meson/axg-card.c                                       |    1 
 sound/soc/meson/axg-fifo.c                                       |   52 +
 sound/soc/meson/axg-fifo.h                                       |   12 
 sound/soc/meson/axg-frddr.c                                      |    5 
 sound/soc/meson/axg-tdm-interface.c                              |   34 -
 sound/soc/meson/axg-toddr.c                                      |   22 
 sound/soc/tegra/tegra186_dspk.c                                  |    7 
 sound/soc/ti/davinci-mcasp.c                                     |   12 
 sound/usb/line6/driver.c                                         |    6 
 tools/include/linux/kernel.h                                     |    1 
 tools/include/linux/mm.h                                         |    5 
 tools/include/linux/panic.h                                      |   19 
 tools/perf/util/unwind-libdw.c                                   |   21 
 tools/perf/util/unwind-libunwind-local.c                         |    2 
 tools/power/x86/turbostat/turbostat.8                            |    2 
 tools/power/x86/turbostat/turbostat.c                            |   30 -
 tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c        |    6 
 tools/testing/selftests/timers/valid-adjtimex.c                  |   73 +-
 247 files changed, 2505 insertions(+), 1391 deletions(-)

Adam Goldman (1):
      firewire: ohci: mask bus reset interrupts between ISR and bottom half

Al Viro (1):
      qibfs: fix dentry leak

Alan Stern (2):
      usb: Fix regression caused by invalid ep0 maxpacket in virtual SuperSpeed device
      USB: core: Fix access violation during port device removal

Aleksa Savic (3):
      hwmon: (corsair-cpro) Use a separate buffer for sending commands
      hwmon: (corsair-cpro) Use complete_all() instead of complete() in ccp_raw_event()
      hwmon: (corsair-cpro) Protect ccp->wait_input_report with a spinlock

Alex Deucher (1):
      drm/amdkfd: don't allow mapping the MMIO HDP page with large pages

Alexander Potapenko (1):
      kmsan: compiler_types: declare __no_sanitize_or_inline

Alexander Stein (1):
      eeprom: at24: Use dev_err_probe for nvmem register failure

Alexander Usyskin (1):
      mei: me: add lunar lake point M DID

Alexandra Winter (1):
      s390/qeth: Fix kernel panic after setting hsuid

Aman Dhoot (1):
      ALSA: hda/realtek: Fix mute led of HP Laptop 15-da3001TU

Amit Sunil Dhamne (1):
      usb: typec: tcpm: unregister existing source caps before re-registration

Anand Jain (1):
      btrfs: return accurate error code on open failure in open_fs_devices()

Andrea Righi (2):
      rust: fix regexp in scripts/is_rust_module.sh
      btf, scripts: rust: drop is_rust_module.sh

Andrei Matei (1):
      bpf: Check bloom filter map value size

Andrew Price (1):
      gfs2: Fix invalid metadata access in punch_hole

Andrii Nakryiko (1):
      bpf, kconfig: Fix DEBUG_INFO_BTF_MODULES Kconfig definition

Andy Shevchenko (7):
      pinctrl: Introduce struct pinfunction and PINCTRL_PINFUNCTION() macro
      pinctrl: intel: Make use of struct pinfunction and PINCTRL_PINFUNCTION()
      drm/panel: ili9341: Respect deferred probe
      drm/panel: ili9341: Use predefined error codes
      gpio: wcove: Use -ENOTSUPP consistently
      gpio: crystalcove: Use -ENOTSUPP consistently
      gpiolib: cdev: Add missing header(s)

AngeloGioacchino Del Regno (2):
      power: supply: mt6360_charger: Fix of_match for usb-otg-vbus regulator
      regulator: mt6360: De-capitalize devicetree regulator subnodes

Anton Protopopov (1):
      bpf: Fix a verifier verbose message

Arjan van de Ven (2):
      VFIO: Add the SPR_DSA and SPR_IAX devices to the denylist
      dmaengine: idxd: add a new security check to deal with a hardware erratum

Arnd Bergmann (1):
      power: rt9455: hide unused rt9455_boost_voltage_values

Asahi Lina (1):
      rust: error: Rename to_kernel_errno() -> to_errno()

Asbjørn Sloth Tønnesen (4):
      net: qede: sanitize 'rc' in qede_add_tc_flower_fltr()
      net: qede: use return from qede_parse_flow_attr() for flower
      net: qede: use return from qede_parse_flow_attr() for flow_spec
      net: qede: use return from qede_parse_actions()

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Check for port partner validity before consuming it

Benno Lossin (1):
      rust: macros: fix soundness issue in `module!` macro

Billy Tsai (1):
      pinctrl: pinctrl-aspeed-g6: Fix register offset for pinconf of GPIOR-T

Boris Burkov (2):
      btrfs: make btrfs_clear_delalloc_extent() free delalloc reserve
      btrfs: always clear PERTRANS metadata during commit

Borislav Petkov (AMD) (1):
      kbuild: Disable KCSAN for autogenerated *.mod.c intermediaries

Boy.Wu (1):
      ARM: 9381/1: kasan: clear stale stack poison

Bui Quang Minh (3):
      bna: ensure the copied buf is NUL terminated
      octeontx2-af: avoid off-by-one read from userspace
      s390/cio: Ensure the copied buf is NUL terminated

Bumyong Lee (1):
      dmaengine: pl330: issue_pending waits until WFP state

Chen Ni (1):
      ata: sata_gemini: Check clk_enable() result

Chen-Yu Tsai (2):
      pinctrl: mediatek: paris: Fix PIN_CONFIG_INPUT_SCHMITT_ENABLE readback
      pinctrl: mediatek: paris: Rework support for PIN_CONFIG_{INPUT,OUTPUT}_ENABLE

Chris Wulff (1):
      usb: gadget: f_fs: Fix a race condition when processing setup packets.

Christian A. Ehrhardt (2):
      usb: typec: ucsi: Check for notifications after init
      usb: typec: ucsi: Fix connector check on init

Christian König (1):
      drm/amdgpu: once more fix the call oder in amdgpu_ttm_move() v2

Claudio Imbrenda (2):
      s390/mm: Fix storage key clearing for guest huge pages
      s390/mm: Fix clearing storage keys for huge pages

Conor Dooley (1):
      spi: microchip-core-qspi: fix setting spi bus clock rate

Dan Carpenter (2):
      pinctrl: core: delete incorrect free in pinctrl_enable()
      mm/slab: make __free(kfree) accept error pointers

Daniel Okazaki (1):
      eeprom: at24: fix memory corruption race condition

David Bauer (1):
      net l2tp: drop flow hash on forward

David Lechner (5):
      spi: axi-spi-engine: simplify driver data allocation
      spi: axi-spi-engine: use devm_spi_alloc_host()
      spi: axi-spi-engine: move msg state to new struct
      spi: axi-spi-engine: use common AXI macros
      spi: axi-spi-engine: fix version format string

Devyn Liu (1):
      spi: hisi-kunpeng: Delete the dump interface of data registers in debugfs

Dmitry Antipov (1):
      btrfs: fix kvcalloc() arguments order in btrfs_ioctl_send()

Dominique Martinet (1):
      btrfs: add missing mutex_unlock in btrfs_relocate_sys_chunks()

Doug Berger (3):
      net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
      net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
      net: bcmgenet: synchronize UMAC_CMD access

Doug Smythies (1):
      tools/power turbostat: Fix added raw MSR output

Douglas Anderson (1):
      drm/connector: Add \n to message about demoting connector force-probes

Duoming Zhou (2):
      Bluetooth: Fix use-after-free bugs caused by sco_sock_timeout
      Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout

Eric Dumazet (6):
      tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets
      phonet: fix rtm_phonet_notify() skb allocation
      ipv6: fib6_rules: avoid possible NULL dereference in fib6_rule_action()
      net-sysfs: convert dev->operstate reads to lockless ones
      ipv6: annotate data-races around cnf.disable_ipv6
      ipv6: prevent NULL dereference in ip6_output()

Felix Fietkau (3):
      net: bridge: fix multicast-to-unicast with fraglist GSO
      net: core: reject skb_copy(_expand) for fraglist GSO skbs
      net: bridge: fix corrupted ethernet header on multicast-to-unicast

Florian Fainelli (1):
      net: bcmgenet: Clear RGMII_LINK upon link down

Gabe Teeger (1):
      drm/amd/display: Atom Integrated System Info v2_2 for DCN35

Gaurav Batra (1):
      powerpc/pseries/iommu: LPAR panics during boot up with a frozen PE

Geert Uytterhoeven (1):
      spi: Merge spi_controller.{slave,target}_abort()

George Shen (1):
      drm/amd/display: Handle Y carry-over in VCP X.Y calculation

Greg Kroah-Hartman (1):
      Linux 6.1.91

Guenter Roeck (1):
      usb: ohci: Prevent missed ohci interrupts

Guillaume Nault (1):
      vxlan: Pull inner IP header in vxlan_rcv().

Hans de Goede (2):
      pinctrl: baytrail: Fix selecting gpio pinctrl state
      iio: accel: mxc4005: Interrupt handling fixes

Heiner Kallweit (1):
      eeprom: at24: Probe for DDR3 thermal sensor in the SPD case

Igor Artemiev (1):
      wifi: cfg80211: fix rdev_dump_mpp() arguments order

Jan Dakinevich (1):
      pinctrl/meson: fix typo in PDM's pin name

Jason Xing (1):
      bpf, skmsg: Fix NULL pointer dereference in sk_psock_skb_ingress_enqueue

Javier Carrasco (1):
      dt-bindings: iio: health: maxim,max30102: fix compatible check

Jeff Johnson (1):
      wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc

Jeff Layton (1):
      9p: explicitly deny setlease attempts

Jens Remus (1):
      s390/vdso: Add CFI for RA register to asm macro vdso_func

Jernej Skrabec (1):
      clk: sunxi-ng: h6: Reparent CPUX during PLL CPUX rate change

Jerome Brunet (7):
      ASoC: meson: axg-fifo: use FIELD helpers
      ASoC: meson: axg-fifo: use threaded irq to check periods
      ASoC: meson: axg-card: make links nonatomic
      ASoC: meson: axg-tdm-interface: manage formatters in trigger
      ASoC: meson: cards: select SND_DYNAMIC_MINORS
      drm/meson: dw-hdmi: power up phy on device init
      drm/meson: dw-hdmi: add bandgap setting for g12

Jian Shen (1):
      net: hns3: direct return when receive a unknown mailbox message

Jiaxun Yang (1):
      MIPS: scall: Save thread_info.syscall unconditionally on entry

Jim Cromie (1):
      dyndbg: fix old BUG_ON in >control parser

Joakim Sindholt (3):
      fs/9p: only translate RWX permissions for plain 9P2000
      fs/9p: translate O_TRUNC into OTRUNC
      fs/9p: drop inodes immediately on non-.L too

Joao Paulo Goncalves (1):
      ASoC: ti: davinci-mcasp: Fix race condition during probe

Johan Hovold (6):
      regulator: core: fix debugfs creation regression
      Bluetooth: qca: add missing firmware sanity checks
      Bluetooth: qca: fix NVM configuration parsing
      Bluetooth: qca: fix info leak when fetching board id
      Bluetooth: qca: fix info leak when fetching fw build id
      Bluetooth: qca: fix firmware check error path

Johannes Berg (1):
      wifi: nl80211: don't free NULL coalescing rule

John Stultz (1):
      selftests: timers: Fix valid-adjtimex signed left-shift undefined behavior

Josef Bacik (3):
      sunrpc: add a struct rpc_stats arg to rpc_create_args
      nfs: expose /proc/net/sunrpc/nfs in net namespaces
      nfs: make the rpc_stat per net namespace

Justin Ernst (1):
      tools/power/turbostat: Fix uncore frequency file string

Justin Tee (4):
      scsi: lpfc: Move NPIV's transport unregistration to after resource clean up
      scsi: lpfc: Update lpfc_ramp_down_queue_handler() logic
      scsi: lpfc: Replace hbalock with ndlp lock in lpfc_nvme_unregister_port()
      scsi: lpfc: Release hbalock before calling lpfc_worker_wake_up()

Karthikeyan Ramasubramanian (1):
      drm/i915/bios: Fix parsing backlight BDB data

Kefeng Wang (1):
      mm: use memalloc_nofs_save() in page_cache_ra_order()

Kent Gibson (2):
      gpiolib: cdev: relocate debounce_period_us from struct gpio_desc
      gpiolib: cdev: fix uninitialised kfifo

Krzysztof Kozlowski (1):
      iommu: mtk: fix module autoloading

Kuniyuki Iwashima (3):
      nfs: Handle error of rpc_proc_register() in nfs_net_init().
      nsh: Restore skb->{protocol,data,mac_header} for outer header in nsh_gso_segment().
      tcp: Use refcount_inc_not_zero() in tcp_twsk_unique().

Lakshmi Yadlapati (1):
      hwmon: (pmbus/ucd9000) Increase delay from 250 to 500us

Leah Rumancik (1):
      MAINTAINERS: add leah to 6.1 MAINTAINERS file

Li Nan (2):
      block: fix overflow in blk_ioctl_discard()
      md: fix kmemleak of rdev->serial

Li Zetao (1):
      spi: spi-axi-spi-engine: Use helper function devm_clk_get_enabled()

Lijo Lazar (1):
      drm/amdgpu: Refine IB schedule error logging

Linus Torvalds (1):
      Reapply "drm/qxl: simplify qxl_fence_wait"

Lukasz Majewski (1):
      hsr: Simplify code for announcing HSR nodes timer setup

Lyude Paul (1):
      drm/nouveau/dp: Don't probe eDP ports twice harder

Mans Rullgard (1):
      spi: fix null pointer dereference within spi_sync

Marc Zyngier (1):
      KVM: arm64: vgic-v2: Use cpuid from userspace as vcpu_id

Marek Behún (1):
      net: dsa: mv88e6xxx: Fix number of databases for 88E6141 / 88E6341

Marek Vasut (1):
      net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs

Mario Limonciello (1):
      dm/amd/pm: Fix problems with reboot/shutdown for some SMU 13.0.4/13.0.11 users

Masahiro Yamada (2):
      kbuild: refactor host*_flags
      kbuild: specify output names separately for each emission type from rustc

Matti Vaittinen (2):
      regulator: change stubbed devm_regulator_get_enable to return Ok
      regulator: change devm_regulator_get_enable_optional() stub to return Ok

Maurizio Lombardi (1):
      scsi: target: Fix SELinux error when systemd-modules loads the target module

Miaohe Lin (1):
      mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when dissolve_free_hugetlb_folio()

Michael Kelley (1):
      Drivers: hv: vmbus: Don't free ring buffers that couldn't be re-encrypted

Miguel Ojeda (1):
      kbuild: rust: avoid creating temporary files

Namhyung Kim (2):
      perf unwind-libunwind: Fix base address for .eh_frame
      perf unwind-libdw: Handle JIT-generated DSOs properly

Namjae Jeon (3):
      ksmbd: off ipv6only for both ipv4/ipv6 binding
      ksmbd: avoid to send duplicate lease break notifications
      ksmbd: do not grant v2 lease if parent lease key and epoch are not set

Nayna Jain (2):
      powerpc/pseries: replace kmalloc with kzalloc in PLPKS driver
      powerpc/pseries: make max polling consistent for longer H_CALLs

Nikhil Rao (1):
      dmaengine: idxd: add a write() method for applications to submit work

Oliver Upton (1):
      KVM: arm64: vgic-v2: Check for non-NULL vCPU in vgic_v2_parse_attr()

Oscar Salvador (1):
      mm,swapops: update check in is_pfn_swap_entry for hwpoison entries

Paolo Abeni (2):
      mptcp: ensure snd_nxt is properly initialized on connect
      tipc: fix UAF in error path

Paul Davey (1):
      xfrm: Preserve vlan tags for transport mode software GRO

Peiyang Wang (4):
      net: hns3: using user configure after hardware reset
      net: hns3: change type of numa_node_mask as nodemask_t
      net: hns3: release PTP resources if pf initialization failed
      net: hns3: use appropriate barrier function after setting a bit value

Peng Liu (1):
      tools/power turbostat: Fix Bzy_MHz documentation typo

Peter Korsgaard (1):
      usb: gadget: composite: fix OS descriptors w_value logic

Peter Wang (1):
      scsi: ufs: core: WLUN suspend dev/link state error recovery

Peter Xu (1):
      mm/hugetlb: fix missing hugetlb_lock for resv uncharge

Phil Elwell (1):
      net: bcmgenet: Reset RBUF on first open

Pierre-Louis Bossart (1):
      ALSA: hda: intel-sdw-acpi: fix usage of device_get_named_child_node()

Qu Wenruo (1):
      btrfs: do not wait for short bulk allocation

Ramona Gradinariu (1):
      iio:imu: adis16475: Fix sync mode setting

Richard Gobert (1):
      net: gro: add flush check in udp_gro_receive_segment

Rick Edgecombe (2):
      Drivers: hv: vmbus: Track decrypted status in vmbus_gpadl
      uio_hv_generic: Don't free decrypted memory

Rik van Riel (1):
      blk-iocost: avoid out of bounds shift

Roded Zats (1):
      rtnetlink: Correct nested IFLA_VF_VLAN_LIST attribute validation

Russell Currey (1):
      powerpc/pseries: Move PLPKS constants to header file

Sameer Pujar (1):
      ASoC: tegra: Fix DSPK 16-bit playback

Saurav Kashyap (1):
      scsi: bnx2fc: Remove spin_lock_bh while releasing resources after upload

Sebastian Andrzej Siewior (1):
      cxgb4: Properly lock TX queue for the selftest.

Shin'ichiro Kawasaki (1):
      scsi: mpi3mr: Avoid memcpy field-spanning write WARNING

Shyam Prasad N (1):
      cifs: use the least loaded channel for sending requests

Sidhartha Kumar (8):
      mm/hugetlb: add folio support to hugetlb specific flag macros
      mm: add private field of first tail to struct page and struct folio
      mm/hugetlb: add hugetlb_folio_subpool() helpers
      mm/hugetlb: add folio_hstate()
      mm/hugetlb_cgroup: convert __set_hugetlb_cgroup() to folios
      mm/hugetlb_cgroup: convert hugetlb_cgroup_from_page() to folios
      mm/hugetlb: convert free_huge_page to folios
      mm/hugetlb_cgroup: convert hugetlb_cgroup_uncharge_page() to folios

Silvio Gissi (1):
      keys: Fix overwrite of key expiration on instantiation

Stephen Boyd (1):
      clk: Don't hold prepare_lock when calling kref_put()

Steve French (1):
      smb3: missing lock when picking channel

Sungwoo Kim (1):
      Bluetooth: msft: fix slab-use-after-free in msft_do_close()

Takashi Iwai (1):
      ALSA: line6: Zero-initialize message buffers

Thadeu Lima de Souza Cascardo (1):
      net: fix out-of-bounds access in ops_init

Thanassis Avgerinos (1):
      firewire: nosy: ensure user_length is taken into account when fetching packet contents

Thierry Reding (1):
      gpu: host1x: Do not setup DMA for virtual devices

Thinh Nguyen (2):
      usb: xhci-plat: Don't include xhci.h
      usb: dwc3: core: Prevent phy suspend during init

Thomas Bertschinger (1):
      rust: module: place generated init_module() function in .init.text

Thomas Gleixner (2):
      timers: Get rid of del_singleshot_timer_sync()
      timers: Rename del_timer() to timer_delete()

Tim Jiang (1):
      Bluetooth: qca: add support for QCA2066

Toke Høiland-Jørgensen (1):
      xdp: use flags field to disambiguate broadcast redirect

Uwe Kleine-König (1):
      spi: axi-spi-engine: Convert to platform remove callback returning void

Vanillan Wang (1):
      net:usb:qmi_wwan: support Rolling modules

Viken Dadhaniya (1):
      slimbus: qcom-ngd-ctrl: Add timeout for wait operation

Vinod Koul (1):
      dmaengine: Revert "dmaengine: pl330: issue_pending waits until WFP state"

Wedson Almeida Filho (1):
      rust: kernel: require `Send` for `Module` implementations

Wei Yang (3):
      memblock tests: fix undefined reference to `early_pfn_to_nid'
      memblock tests: fix undefined reference to `panic'
      memblock tests: fix undefined reference to `BIT'

Wen Gu (1):
      net/smc: fix neighbour and rtable leak in smc_ib_find_route()

Wyes Karny (1):
      tools/power turbostat: Increase the limit for fd opened

Xin Long (1):
      tipc: fix a possible memleak in tipc_buf_append

Xu Kuohai (1):
      bpf, arm64: Fix incorrect runtime stats

Yang Yingliang (2):
      spi: introduce new helpers with using modern naming
      spi: spi-axi-spi-engine: switch to use modern name

Yi Zhang (1):
      nvme: fix warn output about shared namespaces without CONFIG_NVME_MULTIPATH

Yonglong Liu (2):
      net: hns3: fix port vlan filter not disabled issue
      net: hns3: fix kernel crash when devlink reload during initialization

Zack Rusin (1):
      drm/vmwgfx: Fix invalid reads in fence signaled events

Zeng Heng (1):
      pinctrl: devicetree: fix refcount leak in pinctrl_dt_to_map()

linke li (1):
      net: mark racy access on sk->sk_rcvbuf


