Return-Path: <stable+bounces-55957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD6A91A60B
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 14:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A0428C5BC
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8AE14F136;
	Thu, 27 Jun 2024 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zgY6oAaL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6605D14F11C;
	Thu, 27 Jun 2024 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489721; cv=none; b=XWaEOiOCnI1xbZhps/5HLnE2bj7mk0nSaxgCIu4LBebW0WkrLTeXBa6R1hvLTWWXL6l0/CiDT2gSXLY7c1b1SEkCIunmkLehN3O3fS/6JkhD+7Bg1/jDQilOS9RoOL0QYxOjxElB1dyIgpaKfWgRqidTApKZ/d9WNg8sYHRwEs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489721; c=relaxed/simple;
	bh=tX9r8NdenwAaMKRBtZpJ06fzJefd6o3Msbo3IBH71rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RgwaBv8NeZT3VLbhjS59Wfu33PMcdFLC3IoY2+V9LRvQGxDMTKAt7fSbN6Y1EGahT5HjkC5WsfEb52rTkPikGE6K4vlvJHE8+iuQR+ETGtMcAzpSLBW+zO1GmMahkCMAoUkH0ULgXZlCCSl00IepjUn8VuIFdaEZSPWdMdDDoyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zgY6oAaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51680C2BBFC;
	Thu, 27 Jun 2024 12:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719489721;
	bh=tX9r8NdenwAaMKRBtZpJ06fzJefd6o3Msbo3IBH71rw=;
	h=From:To:Cc:Subject:Date:From;
	b=zgY6oAaLH9/gW+Xkmstxlj07UmEsrkhuHNgzS8CudzL8mUPa3ZGrN6XRJ7TNP3o3I
	 c5tc6TZaMD3jRFZJXFAq1CXMZGTJONSIAihyJf/djEBsxT1dQMNHAG6gPh9ig/PKPo
	 cVLCMf4+jDrRQz3kjxxrrb2f6qWdXd+VlX7KWO+g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.36
Date: Thu, 27 Jun 2024 14:01:51 +0200
Message-ID: <2024062751-emote-concur-7c40@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.36 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/dma/fsl,edma.yaml                  |    4 
 Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml         |    2 
 Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml |    2 
 Makefile                                                             |    2 
 arch/alpha/kernel/setup.c                                            |    2 
 arch/alpha/kernel/sys_sio.c                                          |    2 
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi                     |    2 
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi                  |    4 
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi              |    2 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts                         |    2 
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts                    |    1 
 arch/arm64/configs/defconfig                                         |    1 
 arch/arm64/kvm/vgic/vgic-init.c                                      |    2 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                   |   15 
 arch/arm64/kvm/vgic/vgic.h                                           |    2 
 arch/csky/kernel/probes/ftrace.c                                     |    3 
 arch/ia64/kernel/setup.c                                             |    6 
 arch/loongarch/include/asm/efi.h                                     |    2 
 arch/loongarch/include/asm/hw_breakpoint.h                           |    4 
 arch/loongarch/kernel/ftrace_dyn.c                                   |    3 
 arch/loongarch/kernel/head.S                                         |    3 
 arch/loongarch/kernel/hw_breakpoint.c                                |   96 ++---
 arch/loongarch/kernel/image-vars.h                                   |    1 
 arch/loongarch/kernel/ptrace.c                                       |   47 +-
 arch/loongarch/kernel/setup.c                                        |    2 
 arch/loongarch/kernel/vmlinux.lds.S                                  |   11 
 arch/mips/bmips/setup.c                                              |    3 
 arch/mips/kernel/setup.c                                             |    2 
 arch/mips/pci/ops-rc32434.c                                          |    4 
 arch/mips/pci/pcie-octeon.c                                          |    6 
 arch/mips/sibyte/swarm/setup.c                                       |    2 
 arch/mips/sni/setup.c                                                |    2 
 arch/parisc/kernel/ftrace.c                                          |    3 
 arch/powerpc/include/asm/hvcall.h                                    |    8 
 arch/powerpc/include/asm/io.h                                        |   24 -
 arch/powerpc/kernel/kprobes-ftrace.c                                 |    3 
 arch/riscv/kernel/probes/ftrace.c                                    |    3 
 arch/riscv/kernel/setup.c                                            |   11 
 arch/riscv/mm/init.c                                                 |   13 
 arch/s390/kernel/ftrace.c                                            |    3 
 arch/x86/include/asm/cpu_device_id.h                                 |   98 +++++
 arch/x86/include/asm/efi.h                                           |    1 
 arch/x86/kernel/cpu/match.c                                          |    4 
 arch/x86/kernel/kprobes/ftrace.c                                     |    3 
 arch/x86/kvm/x86.c                                                   |    9 
 arch/x86/platform/efi/memmap.c                                       |   12 
 block/ioctl.c                                                        |    2 
 drivers/acpi/acpica/acevents.h                                       |    4 
 drivers/acpi/acpica/evregion.c                                       |    6 
 drivers/acpi/acpica/evxfregn.c                                       |   54 ++
 drivers/acpi/acpica/exregion.c                                       |   23 -
 drivers/acpi/ec.c                                                    |   28 -
 drivers/acpi/internal.h                                              |    1 
 drivers/acpi/video_detect.c                                          |    8 
 drivers/acpi/x86/utils.c                                             |   20 -
 drivers/block/nbd.c                                                  |   34 -
 drivers/bluetooth/ath3k.c                                            |   25 -
 drivers/cpufreq/amd-pstate.c                                         |    7 
 drivers/crypto/hisilicon/qm.c                                        |    5 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                           |    4 
 drivers/dma/Kconfig                                                  |    2 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                       |    6 
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h                                |    1 
 drivers/dma/idxd/irq.c                                               |    4 
 drivers/dma/ioat/init.c                                              |   55 +-
 drivers/firmware/efi/libstub/loongarch-stub.c                        |    9 
 drivers/firmware/efi/libstub/loongarch-stub.h                        |    4 
 drivers/firmware/efi/libstub/loongarch.c                             |    8 
 drivers/firmware/efi/memmap.c                                        |    9 
 drivers/firmware/psci/psci.c                                         |    4 
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c                           |    2 
 drivers/gpu/drm/i915/display/intel_dp.c                              |    4 
 drivers/gpu/drm/lima/lima_bcast.c                                    |   12 
 drivers/gpu/drm/lima/lima_bcast.h                                    |    3 
 drivers/gpu/drm/lima/lima_gp.c                                       |    8 
 drivers/gpu/drm/lima/lima_pp.c                                       |   18 
 drivers/gpu/drm/lima/lima_sched.c                                    |    7 
 drivers/gpu/drm/lima/lima_sched.h                                    |    1 
 drivers/gpu/drm/radeon/sumo_dpm.c                                    |    2 
 drivers/hid/hid-asus.c                                               |   51 +-
 drivers/hid/hid-ids.h                                                |    1 
 drivers/hid/hid-multitouch.c                                         |    6 
 drivers/i2c/busses/i2c-ocores.c                                      |    2 
 drivers/infiniband/hw/bnxt_re/bnxt_re.h                              |    4 
 drivers/infiniband/hw/mana/mr.c                                      |    1 
 drivers/infiniband/hw/mlx5/main.c                                    |    4 
 drivers/infiniband/hw/mlx5/mr.c                                      |    5 
 drivers/infiniband/hw/mlx5/srq.c                                     |   13 
 drivers/infiniband/sw/rxe/rxe_resp.c                                 |   13 
 drivers/infiniband/sw/rxe/rxe_verbs.c                                |    2 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                          |    2 
 drivers/media/pci/intel/ipu-bridge.c                                 |   66 ++-
 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c    |    2 
 drivers/net/dsa/realtek/rtl8366rb.c                                  |   87 +---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                            |    5 
 drivers/net/ethernet/intel/ice/ice_main.c                            |    7 
 drivers/net/ethernet/intel/ice/ice_switch.c                          |    6 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                      |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/Makefile                  |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c              |    7 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c            |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c               |    5 
 drivers/net/ethernet/microchip/lan743x_ethtool.c                     |   44 ++
 drivers/net/ethernet/microchip/lan743x_main.c                        |   48 ++
 drivers/net/ethernet/microchip/lan743x_main.h                        |   28 +
 drivers/net/ethernet/qualcomm/qca_debug.c                            |    6 
 drivers/net/ethernet/qualcomm/qca_spi.c                              |   16 
 drivers/net/ethernet/qualcomm/qca_spi.h                              |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c                |    6 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                      |   40 +-
 drivers/net/phy/mxl-gpy.c                                            |   58 +--
 drivers/net/phy/sfp.c                                                |    3 
 drivers/net/usb/ax88179_178a.c                                       |   18 
 drivers/net/usb/rtl8150.c                                            |    3 
 drivers/net/virtio_net.c                                             |   32 +
 drivers/net/wireless/ath/ath.h                                       |    6 
 drivers/net/wireless/ath/ath9k/main.c                                |    3 
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                      |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c                  |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c                 |    2 
 drivers/net/wireless/mediatek/mt76/sdio.c                            |    3 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h                     |    9 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c                |    7 
 drivers/pci/pci.c                                                    |   17 
 drivers/platform/x86/p2sb.c                                          |   29 -
 drivers/platform/x86/toshiba_acpi.c                                  |   36 +
 drivers/power/supply/cros_usbpd-charger.c                            |   11 
 drivers/ptp/ptp_sysfs.c                                              |    3 
 drivers/regulator/bd71815-regulator.c                                |    2 
 drivers/regulator/core.c                                             |    1 
 drivers/scsi/qedi/qedi_debugfs.c                                     |   12 
 drivers/spi/spi-cs42l43.c                                            |    2 
 drivers/spi/spi-imx.c                                                |   14 
 drivers/spi/spi-stm32-qspi.c                                         |   12 
 drivers/ssb/main.c                                                   |    4 
 drivers/thermal/mediatek/lvts_thermal.c                              |    6 
 drivers/tty/serial/8250/8250_dw.c                                    |   27 +
 drivers/tty/serial/8250/8250_dwlib.h                                 |   32 -
 drivers/tty/serial/8250/8250_exar.c                                  |   42 ++
 drivers/tty/serial/imx.c                                             |    7 
 drivers/tty/tty_ldisc.c                                              |    6 
 drivers/tty/vt/vt.c                                                  |   10 
 drivers/ufs/core/ufshcd.c                                            |    1 
 drivers/usb/dwc3/dwc3-pci.c                                          |    8 
 drivers/usb/gadget/function/f_hid.c                                  |    6 
 drivers/usb/gadget/function/f_printer.c                              |    6 
 drivers/usb/gadget/function/rndis.c                                  |    4 
 drivers/usb/gadget/function/uvc_configfs.c                           |   14 
 drivers/usb/misc/uss720.c                                            |   20 -
 drivers/usb/typec/ucsi/ucsi_glink.c                                  |    8 
 drivers/vfio/pci/vfio_pci_core.c                                     |   78 ++--
 fs/btrfs/bio.c                                                       |    4 
 fs/btrfs/block-group.c                                               |   11 
 fs/ext4/mballoc.c                                                    |    4 
 fs/ext4/super.c                                                      |   22 -
 fs/ext4/sysfs.c                                                      |   24 -
 fs/f2fs/super.c                                                      |   12 
 fs/fs-writeback.c                                                    |    7 
 fs/ocfs2/acl.c                                                       |    4 
 fs/ocfs2/alloc.c                                                     |    6 
 fs/ocfs2/aops.c                                                      |    6 
 fs/ocfs2/dir.c                                                       |    9 
 fs/ocfs2/dlmfs/dlmfs.c                                               |    4 
 fs/ocfs2/dlmglue.c                                                   |   29 -
 fs/ocfs2/file.c                                                      |   30 -
 fs/ocfs2/inode.c                                                     |   28 -
 fs/ocfs2/journal.c                                                   |  192 +++++-----
 fs/ocfs2/move_extents.c                                              |    4 
 fs/ocfs2/namei.c                                                     |   18 
 fs/ocfs2/ocfs2.h                                                     |   27 +
 fs/ocfs2/refcounttree.c                                              |   12 
 fs/ocfs2/super.c                                                     |    4 
 fs/ocfs2/xattr.c                                                     |    4 
 fs/overlayfs/export.c                                                |    6 
 fs/smb/client/cifsfs.c                                               |    2 
 fs/udf/udftime.c                                                     |   11 
 include/acpi/acpixf.h                                                |    4 
 include/linux/atomic/atomic-arch-fallback.h                          |    6 
 include/linux/atomic/atomic-instrumented.h                           |    8 
 include/linux/atomic/atomic-long.h                                   |    4 
 include/linux/kcov.h                                                 |    2 
 include/linux/kprobes.h                                              |    7 
 include/linux/mod_devicetable.h                                      |    2 
 include/linux/pci.h                                                  |    7 
 include/linux/tty_driver.h                                           |    8 
 include/net/netns/netfilter.h                                        |    3 
 include/net/sch_generic.h                                            |    1 
 io_uring/rsrc.c                                                      |    1 
 io_uring/sqpoll.c                                                    |    8 
 kernel/gcov/gcc_4_7.c                                                |    4 
 kernel/kcov.c                                                        |    1 
 kernel/kprobes.c                                                     |    6 
 kernel/padata.c                                                      |    8 
 kernel/rcu/rcutorture.c                                              |   16 
 kernel/trace/Kconfig                                                 |    4 
 kernel/trace/ftrace.c                                                |    1 
 kernel/trace/preemptirq_delay_test.c                                 |    1 
 mm/page_table_check.c                                                |   11 
 net/batman-adv/originator.c                                          |    2 
 net/core/drop_monitor.c                                              |   20 -
 net/core/filter.c                                                    |    5 
 net/core/net_namespace.c                                             |    9 
 net/core/netpoll.c                                                   |    2 
 net/core/sock.c                                                      |    3 
 net/ipv4/cipso_ipv4.c                                                |   12 
 net/ipv4/tcp_input.c                                                 |    1 
 net/ipv6/route.c                                                     |    4 
 net/ipv6/seg6_local.c                                                |    8 
 net/ipv6/xfrm6_policy.c                                              |    8 
 net/netfilter/core.c                                                 |   13 
 net/netfilter/ipset/ip_set_core.c                                    |   11 
 net/netfilter/nf_conntrack_standalone.c                              |   15 
 net/netfilter/nf_hooks_lwtunnel.c                                    |   67 +++
 net/netfilter/nf_internals.h                                         |    6 
 net/netrom/nr_timer.c                                                |    3 
 net/packet/af_packet.c                                               |   26 -
 net/sched/act_api.c                                                  |   66 ++-
 net/sched/act_ct.c                                                   |   16 
 net/sched/sch_api.c                                                  |    1 
 net/sched/sch_generic.c                                              |    4 
 net/sched/sch_htb.c                                                  |   22 -
 net/tipc/node.c                                                      |    1 
 scripts/atomic/kerneldoc/sub_and_test                                |    2 
 sound/core/seq/seq_ump_convert.c                                     |    2 
 sound/hda/intel-dsp-config.c                                         |    2 
 sound/pci/hda/cs35l41_hda.c                                          |    2 
 sound/pci/hda/cs35l56_hda.c                                          |    4 
 sound/pci/hda/patch_realtek.c                                        |   11 
 sound/pci/hda/tas2781_hda_i2c.c                                      |    4 
 sound/soc/intel/boards/sof_sdw.c                                     |   18 
 tools/perf/Documentation/perf-script.txt                             |    7 
 tools/perf/builtin-script.c                                          |   24 -
 tools/testing/selftests/arm64/tags/tags_test.c                       |    4 
 tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c              |   26 -
 tools/testing/selftests/bpf/test_tc_tunnel.sh                        |   13 
 tools/testing/selftests/net/openvswitch/openvswitch.sh               |    2 
 virt/kvm/kvm_main.c                                                  |    5 
 237 files changed, 1925 insertions(+), 992 deletions(-)

Adrian Hunter (1):
      perf script: Show also errors for --insn-trace option

Ajrat Makhmutov (1):
      ALSA: hda/realtek: Enable headset mic on IdeaPad 330-17IKB 81DM

Aleksandr Aprelkov (1):
      iommu/arm-smmu-v3: Free MSIs in case of ENOMEM

Aleksandr Nogikh (1):
      kcov: don't lose track of remote references during softirqs

Alessandro Carminati (Red Hat) (1):
      selftests/bpf: Prevent client connect before server bind in test_tc_tunnel.sh

Alex Deucher (2):
      drm/radeon: fix UBSAN warning in kv_dpm.c
      drm/amdgpu: fix UBSAN warning in kv_dpm.c

Alex Henrie (1):
      usb: misc: uss720: check for incompatible versions of the Belkin F5U002

Alex Williamson (1):
      vfio/pci: Collect hot-reset devices to local buffer

Alexandre Ghiti (1):
      riscv: Don't use PGD entries for the linear mapping

Andrew Ballance (1):
      hid: asus: asus_report_fixup: fix potential read out of bounds

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for ProBook 445/465 G11.

Andy Shevchenko (1):
      serial: 8250_dw: Revert "Move definitions to the shared header"

Ard Biesheuvel (1):
      efi/x86: Free EFI memory map only when installing a new one.

Arnd Bergmann (3):
      wifi: ath9k: work around memset overflow warning
      dmaengine: fsl-edma: avoid linking both modules
      vgacon: rework screen_info #ifdef checks

Arvid Norlander (1):
      platform/x86: toshiba_acpi: Add quirk for buttons on Z830

Aryan Srivastava (1):
      net: mvpp2: use slab_build_skb for oversized frames

Baokun Li (3):
      ext4: fix uninitialized ratelimit_state->lock access in __ext4_fill_super()
      ext4: avoid overflow when setting values via sysfs
      ext4: fix slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists()

Bart Van Assche (2):
      nbd: Improve the documentation of the locking assumptions
      nbd: Fix signal handling

Ben Fradella (1):
      platform/x86: p2sb: Don't init until unassigned resources have been assigned

Biju Das (1):
      regulator: core: Fix modpost error "regulator_get_regmap" undefined

Boris Burkov (1):
      btrfs: retry block group reclaim without infinite loop

Breno Leitao (2):
      netpoll: Fix race condition in netpoll_owner_active
      KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu_on_spin()

Carlos Llamas (1):
      locking/atomic: scripts: fix ${atomic}_sub_and_test() kerneldoc

Changbin Du (1):
      perf: script: add raw|disasm arguments to --insn-trace option

Charles Keepax (1):
      spi: cs42l43: Correct SPI root clock speed

Chenghai Huang (2):
      crypto: hisilicon/sec - Fix memory leak for sec resource release
      crypto: hisilicon/qm - Add the err memory release process to qm uninit

Chenliang Li (1):
      io_uring/rsrc: fix incorrect assignment of iter->nr_segs in io_import_fixed

Christian Marangi (1):
      mips: bmips: BCM6358: make sure CBR is correctly set

Christophe JAILLET (1):
      usb: gadget: function: Remove usage of the deprecated ida_simple_xx() API

Dan Carpenter (1):
      ptp: fix integer overflow in max_vclocks_store

Daniel Golle (1):
      net: sfp: add quirk for ATS SFP-GE-T 1000Base-TX module

David Ruth (1):
      net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()

Davide Caratti (2):
      net/sched: fix false lockdep warning on qdisc root lock
      net/sched: unregister lockdep keys in qdisc_create/qdisc_alloc error path

Dmitry Baryshkov (1):
      usb: typec: ucsi_glink: drop special handling for CCI_BUSY

Dustin L. Howett (1):
      ALSA: hda/realtek: Remove Framework Laptop 16 from quirks

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on N14AP7

En-Wei Wu (1):
      ice: avoid IRQ collision to fix init failure on ACPI S3 resume

Eric Dumazet (6):
      batman-adv: bypass empty buckets in batadv_purge_orig_ref()
      af_packet: avoid a false positive warning in packet_setsockopt()
      ipv6: prevent possible NULL deref in fib6_nh_init()
      ipv6: prevent possible NULL dereference in rt6_probe()
      xfrm6: check ip6_dst_idev() return value in xfrm6_get_saddr()
      tcp: clear tp->retrans_stamp in tcp_rcv_fastopen_synack()

Erico Nunes (2):
      drm/lima: add mask irq callback to gp and pp
      drm/lima: mask irqs in timeout path before hard reset

Esben Haabendal (1):
      serial: imx: Introduce timeout when waiting on transmitter empty

Fabio Estevam (1):
      arm64: dts: imx93-11x11-evk: Remove the 'no-sdio' property

Florian Westphal (1):
      bpf: Avoid splat in pskb_pull_reason

Frank Li (1):
      arm64: dts: imx8qm-mek: fix gpio number for reg_usdhc2_vmmc

Fullway Wang (1):
      media: mtk-vcodec: potential null pointer deference in SCP

Gavrilov Ilia (1):
      netrom: Fix a memory leak in nr_heartbeat_expiry()

Geetha sowjanya (1):
      octeontx2-pf: Fix linking objects into multiple modules

Greg Kroah-Hartman (1):
      Linux 6.6.36

Grygorii Tertychnyi (1):
      i2c: ocores: set IACK bit after core is enabled

Hans de Goede (2):
      ACPI: x86: Add PNP_UART1_SKIP quirk for Lenovo Blade2 tablets
      usb: dwc3: pci: Don't set "linux,phy_charger_detect" property on Lenovo Yoga Tab2 1380

Heng Qi (2):
      virtio_net: checksum offloading handling fix
      virtio_net: fixing XDP for fully checksummed packets handling

Herbert Xu (1):
      padata: Disable BH when taking works lock on MT path

Honggang LI (2):
      RDMA/rxe: Fix responder length checking for UD request packets
      RDMA/rxe: Fix data copy for IB_SEND_INLINE

Hui Li (3):
      LoongArch: Fix watchpoint setting error
      LoongArch: Trigger user-space watchpoints correctly
      LoongArch: Fix multiple hardware watchpoint issues

Ignat Korchagin (1):
      net: do not leave a dangling sk pointer, when socket creation fails

Ilpo Järvinen (2):
      PCI: Do not wait for disconnected devices when resuming
      MIPS: Routerboard 532: Fix vendor retry check code

Jaegeuk Kim (1):
      f2fs: don't set RO when shutting down f2fs

Jani Nikula (1):
      drm/i915/mso: using joiner is not possible with eDP MSO

Jason Gunthorpe (2):
      RDMA/mlx5: Remove extra unlock on error path
      RDMA/mlx5: Follow rb_key.ats when creating new mkeys

Jeff Johnson (1):
      tracing: Add MODULE_DESCRIPTION() to preemptirq_delay_test

Jeff Layton (1):
      ocfs2: convert to new timestamp accessors

Jens Axboe (1):
      io_uring/sqpoll: work around a potential audit memory leak

Jianguo Wu (2):
      seg6: fix parameter passing when calling NF_HOOK() in End.DX4 and End.DX6 behaviors
      netfilter: move the sysctl nf_hooks_lwtunnel into the netfilter core

Jiaxun Yang (1):
      LoongArch: Fix entry point in kernel image header

Joao Pinto (1):
      Avoid hw_desc array overrun in dw-axi-dmac

Joel Slebodnick (1):
      scsi: ufs: core: Free memory allocated for model before reinit

Johannes Thumshirn (1):
      btrfs: zoned: allocate dummy checksums for zoned NODATASUM writes

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: improve reset check

Joseph Qi (2):
      ocfs2: fix NULL pointer dereference in ocfs2_journal_dirty()
      ocfs2: fix NULL pointer dereference in ocfs2_abort_trigger()

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix suspicious rcu_dereference_protected()

Julien Panis (1):
      thermal/drivers/mediatek/lvts_thermal: Return error in case of invalid efuse data

Justin Stitt (1):
      block/ioctl: prefer different overflow check

Kalle Niemi (1):
      regulator: bd71815: fix ramp values

Kemeng Shi (1):
      fs/writeback: bail out if there is no more inodes for IO and queued once

Konstantin Taranov (1):
      RDMA/mana_ib: Ignore optional access flags for MRs

Krzysztof Kozlowski (3):
      dt-bindings: dma: fsl-edma: fix dma-channels constraints
      dt-bindings: i2c: atmel,at91sam: correct path to i2c-controller schema
      dt-bindings: i2c: google,cros-ec-i2c-tunnel: correct path to i2c-controller schema

Kunwu Chan (1):
      kselftest: arm64: Add a null pointer check

Leon Yen (1):
      wifi: mt76: mt7921s: fix potential hung tasks during chip recovery

Li RongQing (1):
      dmaengine: idxd: Fix possible Use-After-Free in irq_process_work_list

Linus Torvalds (3):
      tty: add the option to have a tty reject a new ldisc
      kprobe/ftrace: fix build error due to bad function definition
      Revert "mm: mmap: allow for the maximum number of bits for randomizing mmap_base by default"

Luiz Angelo Daros de Luca (1):
      net: dsa: realtek: keep default LED state in rtl8366rb

Luke D. Jones (1):
      HID: asus: fix more n-key report descriptors if n-key quirked

Manish Rangankar (1):
      scsi: qedi: Fix crash while reading debugfs attribute

Marc Kleine-Budde (1):
      spi: spi-imx: imx51: revert burst length calculation back to bits_per_word

Marc Zyngier (1):
      KVM: arm64: Disassociate vcpus from redistributor region on teardown

Marcin Szycik (1):
      ice: Fix VSI list rule with ICE_SW_LKUP_LAST type

Marek Vasut (2):
      arm64: dts: imx8mp: Fix TC9595 reset GPIO on DH i.MX8M Plus DHCOM SoM
      arm64: dts: imx8mp: Fix TC9595 input clock on DH i.MX8M Plus DHCOM SoM

Mario Limonciello (1):
      PCI/PM: Avoid D3cold for HP Pavilion 17 PC/1972 PCIe Ports

Martin Kaiser (1):
      arm64: defconfig: enable the vf610 gpio driver

Martin Kaistra (1):
      wifi: rtl8xxxu: enable MFP support with security flag of RX descriptor

Martin Leung (1):
      drm/amd/display: revert Exit idle optimizations before HDCP execution

Masami Hiramatsu (Google) (1):
      tracing: Build event generation tests only as modules

Max Krummenacher (1):
      arm64: dts: freescale: imx8mm-verdin: enable hysteresis on slow input pin

Michael Ellerman (1):
      powerpc/io: Avoid clang null pointer arithmetic warnings

Michael Grzeschik (1):
      usb: gadget: uvc: configfs: ensure guid to be valid before set

Miklos Szeredi (1):
      ovl: fix encoding fid for lower only root

Nam Cao (1):
      riscv: force PAGE_SIZE linear mapping if debug_pagealloc is enabled

Nathan Lynch (1):
      powerpc/pseries: Enforce hcall result buffer validity and size

Nicholas Kazlauskas (1):
      drm/amd/display: Exit idle optimizations before HDCP execution

Nikita Shubin (4):
      dmaengine: ioatdma: Fix leaking on version mismatch
      dmaengine: ioatdma: Fix error path in ioat3_dma_probe()
      dmaengine: ioatdma: Fix kmemleak in ioat_pci_probe()
      dmaengine: ioatdma: Fix missing kmem_cache_destroy()

Oleksij Rempel (1):
      net: stmmac: Assign configured channel value to EXTTS event

Oliver Neukum (1):
      net: usb: rtl8150 fix unintiatilzed variables in rtl8150_get_link_ksettings

Ondrej Mosnacek (1):
      cipso: fix total option length computation

Pablo Caño (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14AHP9

Parker Newman (1):
      serial: exar: adding missing CTI and Exar PCI ids

Patrice Chotard (2):
      spi: stm32: qspi: Fix dual flash mode sanity test in stm32_qspi_setup()
      spi: stm32: qspi: Clamp stm32_qspi_get_mode() output to CCR_BUSWIDTH_4

Patrisious Haddad (1):
      RDMA/mlx5: Add check for srq max_sge attribute

Paul E. McKenney (1):
      rcutorture: Fix rcu_torture_one_read() pipe_count overflow comment

Pavan Chebbi (1):
      bnxt_en: Restore PTP tx_avail count in case of skb_pad() error

Pedro Tammela (1):
      net/sched: act_api: rely on rcu in tcf_idr_check_alloc

Peng Ma (1):
      cpufreq: amd-pstate: fix memory leak on CPU EPP exit

Peter Oberparleiter (1):
      gcov: add support for GCC 14

Peter Ujfalusi (1):
      ALSA/hda: intel-dsp-config: Document AVS as dsp_driver option

Peter Xu (1):
      mm/page_table_check: fix crash on ZONE_DEVICE

Pierre-Louis Bossart (3):
      ASoC: Intel: sof_sdw: add JD2 quirk for HP Omen 14
      ASoC: Intel: sof_sdw: add quirk for Dell SKU 0C0F
      ASoC: Intel: sof-sdw: really remove FOUR_SPEAKER quirk

Rafael Aquini (1):
      mm: mmap: allow for the maximum number of bits for randomizing mmap_base by default

Rafael J. Wysocki (2):
      ACPI: EC: Install address space handler at the namespace root
      ACPI: EC: Evaluate orphan _REG under EC device

Raju Lakkaraju (3):
      net: lan743x: disable WOL upon resume to restore full data path operation
      net: lan743x: Support WOL at both the PHY and MAC appropriately
      net: phy: mxl-gpy: Remove interrupt mask clearing from config_init

Raju Rangoju (1):
      ACPICA: Revert "ACPICA: avoid Info: mapping multiple BARs. Your kernel is fine."

Rand Deeb (1):
      ssb: Fix potential NULL pointer dereference in ssb_device_uevent()

Ricardo Ribalda (1):
      media: intel/ipu6: Fix build with !ACPI

Roman Smirnov (1):
      udf: udftime: prevent overflow in udf_disk_stamp_to_time()

Sean Christopherson (1):
      KVM: x86: Always sync PIR to IRR prior to scanning I/O APIC routes

Sean O'Brien (1):
      HID: Add quirk for Logitech Casa touchpad

Selvin Xavier (1):
      RDMA/bnxt_re: Fix the max msix vectors macro

Simon Horman (2):
      selftests: openvswitch: Use bash as interpreter
      octeontx2-pf: Add error handling to VLAN unoffload handling

Simon Trimmer (3):
      ALSA: hda: cs35l41: Possible null pointer dereference in cs35l41_hda_unbind()
      ALSA: hda: cs35l56: Component should be unbound before deconstruction
      ALSA: hda: tas2781: Component should be unbound before deconstruction

Songyang Li (1):
      MIPS: Octeon: Add PCIe link status check

Stefan Binding (1):
      ALSA: hda/realtek: Add quirks for Lenovo 13X

Stefan Wahren (1):
      qca_spi: Make interrupt remembering atomic

Stephen Brennan (1):
      kprobe/ftrace: bail out if ftrace was killed

Steve French (1):
      cifs: fix typo in module parameter enable_gcm_256

Su Yue (1):
      ocfs2: update inode fsync transaction id in ocfs2_unlink and ocfs2_link

Sudeep Holla (1):
      firmware: psci: Fix return value from psci_system_suspend()

Takashi Iwai (2):
      ACPI: video: Add backlight=native quirk for Lenovo Slim 7 16ARH7
      ALSA: seq: ump: Fix missing System Reset message handling

Tim Harvey (1):
      arm64: dts: freescale: imx8mp-venice-gw73xx-2x: fix BT shutdown GPIO

Tony Luck (2):
      x86/cpu/vfm: Add new macros to work with (vendor/family/model) values
      x86/cpu: Fix x86_match_cpu() to match just X86_VENDOR_INTEL

Tzung-Bi Shih (1):
      power: supply: cros_usbpd: provide ID table for avoiding fallback match

Uri Arev (1):
      Bluetooth: ath3k: Fix multiple issues reported by checkpatch.pl

Wander Lairson Costa (1):
      drop_monitor: replace spin_lock by raw_spin_lock

Wang Yao (1):
      efi/loongarch: Directly position the loaded image file

Xiaolei Wang (1):
      net: stmmac: No need to calculate speed divider when offload is disabled

Xin Long (2):
      tipc: force a dst refcount before doing decryption
      sched: act_ct: add netns into the key of tcf_ct_flow_table

Yishai Hadas (1):
      RDMA/mlx5: Fix unwind flow as part of mlx5_ib_stage_init_init

Yonghong Song (1):
      selftests/bpf: Fix flaky test btf_map_in_map/lookup_update

Yue Haibing (1):
      netns: Make get_net_ns() handle zero refcount net

Yunlei He (1):
      f2fs: remove clear SB_INLINECRYPT flag in default_options

Zqiang (2):
      rcutorture: Make stall-tasks directly exit when rcutorture tests end
      rcutorture: Fix invalid context warning when enable srcu barrier testing


