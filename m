Return-Path: <stable+bounces-116537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4EEA37DA3
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 09:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283A51896A1D
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 08:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191E81A83F4;
	Mon, 17 Feb 2025 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wMToFBk7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71551A3157;
	Mon, 17 Feb 2025 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782578; cv=none; b=ePzNdJIhYA/mBmWbkOxT6OIcQjUyL0D8HMkxHySLGkz/4NWsC6hArM0PvNVeLuTvquooV8V2mSMmnLSkf0384jMPw7/VADC3VdnLMWwPtva4Quq7KQ21EmMbamck9o+YAbIGXcaM68St2Rp5kHCkKkNoeuISYRLXRBCqjcmyppM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782578; c=relaxed/simple;
	bh=Q3V1GUYnmS835hF1flzkAr7nFeSxgKGtOVg6zfi8KJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bwoJ8G4erzLzfbbhfmN25gPw56skgaDtVxALPW9v+pxpIeOpFFwh0GmWlZ2B9ynA76b2JFIMxREhcLDHIZDzKGJGMq5C6qMZOY5Z6jnOzkxugy1xussRhHQULvpXLLNm4MuB3yDBl45IiYEVlFuJsmwo8fO6pBgahRNICnLd12A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wMToFBk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A862CC4CED1;
	Mon, 17 Feb 2025 08:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739782576;
	bh=Q3V1GUYnmS835hF1flzkAr7nFeSxgKGtOVg6zfi8KJk=;
	h=From:To:Cc:Subject:Date:From;
	b=wMToFBk7Ik0O2gqAbYYcetBfVo1JqabHOyX+5bufxcy2Q+4oERYOP6ZjfTigyvals
	 rRoLND7X9ACcbUpr0WaT9I/ZuloZI7lLkaNxCIFPWaDtfztXgZpECLA0pWzSd3cBk4
	 aAbBNk7mmKuY5jfDSPRr4JLKFt7bEu7nMdu2Jiak=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.78
Date: Mon, 17 Feb 2025 09:56:11 +0100
Message-ID: <2025021711-elephant-decathlon-9b66@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.78 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                     |    2 
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi                       |    2 
 arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi                   |   10 
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                     |    6 
 arch/arm64/boot/dts/qcom/sm6115.dtsi                         |    8 
 arch/arm64/boot/dts/qcom/sm6350.dtsi                         |    6 
 arch/arm64/boot/dts/qcom/sm6375.dtsi                         |   10 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                         |  492 +++++------
 arch/arm64/boot/dts/qcom/sm8450.dtsi                         |    4 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                         |    9 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                |    2 
 arch/arm64/kvm/arch_timer.c                                  |    4 
 arch/arm64/mm/hugetlbpage.c                                  |   12 
 arch/loongarch/include/uapi/asm/ptrace.h                     |   10 
 arch/loongarch/kernel/ptrace.c                               |    6 
 arch/m68k/include/asm/vga.h                                  |    8 
 arch/mips/kernel/ftrace.c                                    |    2 
 arch/mips/loongson64/boardinfo.c                             |    2 
 arch/mips/math-emu/cp1emu.c                                  |    2 
 arch/powerpc/kvm/e500_mmu_host.c                             |   21 
 arch/powerpc/platforms/pseries/eeh_pseries.c                 |    6 
 arch/s390/include/asm/futex.h                                |    2 
 arch/s390/include/asm/processor.h                            |    3 
 arch/s390/kvm/vsie.c                                         |   25 
 arch/x86/boot/compressed/Makefile                            |    1 
 arch/x86/include/asm/kexec.h                                 |   18 
 arch/x86/include/asm/kvm_host.h                              |    2 
 arch/x86/kernel/amd_nb.c                                     |    4 
 arch/x86/kernel/machine_kexec_64.c                           |   45 -
 arch/x86/kvm/lapic.c                                         |   66 +
 arch/x86/kvm/svm/svm.c                                       |    2 
 arch/x86/kvm/vmx/vmx.c                                       |    2 
 arch/x86/mm/ident_map.c                                      |   23 
 arch/x86/pci/fixup.c                                         |   30 
 arch/x86/xen/xen-head.S                                      |    5 
 block/blk-cgroup.c                                           |    1 
 block/fops.c                                                 |    5 
 drivers/acpi/apei/ghes.c                                     |   10 
 drivers/acpi/prmt.c                                          |    4 
 drivers/acpi/property.c                                      |   10 
 drivers/ata/libata-sff.c                                     |   18 
 drivers/char/misc.c                                          |   39 
 drivers/char/tpm/eventlog/acpi.c                             |   15 
 drivers/clk/mediatek/clk-mt2701-aud.c                        |   10 
 drivers/clk/mediatek/clk-mt2701-bdp.c                        |    1 
 drivers/clk/mediatek/clk-mt2701-img.c                        |    1 
 drivers/clk/mediatek/clk-mt2701-mm.c                         |    1 
 drivers/clk/mediatek/clk-mt2701-vdec.c                       |    1 
 drivers/clk/qcom/Kconfig                                     |    1 
 drivers/clk/qcom/clk-alpha-pll.c                             |    2 
 drivers/clk/qcom/clk-rpmh.c                                  |    2 
 drivers/clk/qcom/dispcc-sm6350.c                             |    7 
 drivers/clk/qcom/gcc-mdm9607.c                               |    2 
 drivers/clk/qcom/gcc-sm6350.c                                |   22 
 drivers/clk/qcom/gcc-sm8550.c                                |    8 
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c                       |    6 
 drivers/cpufreq/s3c64xx-cpufreq.c                            |   11 
 drivers/crypto/qce/aead.c                                    |    2 
 drivers/crypto/qce/core.c                                    |   13 
 drivers/crypto/qce/sha.c                                     |    2 
 drivers/crypto/qce/skcipher.c                                |    2 
 drivers/firmware/Kconfig                                     |    2 
 drivers/firmware/efi/libstub/Makefile                        |    2 
 drivers/gpio/gpio-pca953x.c                                  |   19 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c       |    7 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c            |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  |    6 
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c        |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c           |    1 
 drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c     |    4 
 drivers/gpu/drm/bridge/analogix/anx7625.c                    |    2 
 drivers/gpu/drm/bridge/ite-it6505.c                          |   83 +
 drivers/gpu/drm/bridge/ite-it66121.c                         |    2 
 drivers/gpu/drm/display/drm_dp_cec.c                         |   14 
 drivers/gpu/drm/drm_connector.c                              |    1 
 drivers/gpu/drm/drm_edid.c                                   |    6 
 drivers/gpu/drm/drm_fb_helper.c                              |   14 
 drivers/gpu/drm/exynos/exynos_hdmi.c                         |    2 
 drivers/gpu/drm/i915/display/skl_universal_plane.c           |    4 
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c                    |    6 
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c            |   20 
 drivers/gpu/drm/radeon/radeon_audio.c                        |    2 
 drivers/gpu/drm/rockchip/cdn-dp-core.c                       |    9 
 drivers/gpu/drm/sti/sti_hdmi.c                               |    2 
 drivers/gpu/drm/vc4/vc4_hdmi.c                               |    4 
 drivers/gpu/drm/virtio/virtgpu_drv.h                         |    7 
 drivers/gpu/drm/virtio/virtgpu_plane.c                       |   58 -
 drivers/hid/hid-sensor-hub.c                                 |   21 
 drivers/hid/wacom_wac.c                                      |    5 
 drivers/i2c/i2c-core-acpi.c                                  |   22 
 drivers/i3c/master.c                                         |    2 
 drivers/iio/light/as73211.c                                  |   24 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                  |   17 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                   |    1 
 drivers/irqchip/irq-apple-aic.c                              |    3 
 drivers/leds/leds-lp8860.c                                   |    2 
 drivers/mailbox/tegra-hsp.c                                  |    6 
 drivers/md/dm-crypt.c                                        |   27 
 drivers/media/i2c/ccs/ccs-core.c                             |    6 
 drivers/media/i2c/ccs/ccs-data.c                             |   14 
 drivers/media/i2c/ds90ub913.c                                |    1 
 drivers/media/i2c/ds90ub953.c                                |    1 
 drivers/media/i2c/ds90ub960.c                                |  123 +-
 drivers/media/i2c/imx296.c                                   |    2 
 drivers/media/i2c/ov5640.c                                   |    1 
 drivers/media/platform/marvell/mmp-driver.c                  |   21 
 drivers/media/usb/uvc/uvc_ctrl.c                             |    8 
 drivers/media/usb/uvc/uvc_driver.c                           |   98 +-
 drivers/media/usb/uvc/uvc_video.c                            |   21 
 drivers/media/usb/uvc/uvcvideo.h                             |    1 
 drivers/media/v4l2-core/v4l2-mc.c                            |    2 
 drivers/mfd/lpc_ich.c                                        |    3 
 drivers/misc/fastrpc.c                                       |    8 
 drivers/mmc/core/sdio.c                                      |    2 
 drivers/mmc/host/sdhci-msm.c                                 |   53 +
 drivers/mtd/nand/onenand/onenand_base.c                      |    1 
 drivers/mtd/ubi/build.c                                      |    2 
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c              |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c           |   16 
 drivers/net/ethernet/broadcom/tg3.c                          |   58 +
 drivers/net/ethernet/intel/ice/ice_devlink.c                 |    3 
 drivers/net/ethernet/intel/ice/ice_txrx.c                    |   79 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c          |   24 
 drivers/net/phy/nxp-c45-tja11xx.c                            |    2 
 drivers/net/tun.c                                            |    2 
 drivers/net/usb/ipheth.c                                     |   69 +
 drivers/net/vmxnet3/vmxnet3_xdp.c                            |   14 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c      |    5 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c        |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c |    3 
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                 |   13 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c           |   21 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c             |    4 
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c              |    3 
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h          |    4 
 drivers/net/wireless/realtek/rtw88/sdio.c                    |    2 
 drivers/net/wireless/realtek/rtw89/phy.c                     |   11 
 drivers/net/wireless/realtek/rtw89/phy.h                     |    2 
 drivers/net/wwan/iosm/iosm_ipc_pcie.c                        |   56 +
 drivers/nvme/host/core.c                                     |    8 
 drivers/nvme/host/fc.c                                       |    9 
 drivers/nvme/host/pci.c                                      |    4 
 drivers/nvmem/core.c                                         |    2 
 drivers/nvmem/imx-ocotp-ele.c                                |   16 
 drivers/nvmem/qcom-spmi-sdam.c                               |    1 
 drivers/of/base.c                                            |    8 
 drivers/of/of_reserved_mem.c                                 |    4 
 drivers/pci/endpoint/pci-epf-core.c                          |    1 
 drivers/pinctrl/samsung/pinctrl-samsung.c                    |    2 
 drivers/platform/x86/acer-wmi.c                              |    4 
 drivers/platform/x86/intel/int3472/discrete.c                |    3 
 drivers/platform/x86/intel/int3472/tps68470.c                |    3 
 drivers/ptp/ptp_clock.c                                      |    8 
 drivers/pwm/pwm-microchip-core.c                             |    2 
 drivers/rtc/rtc-zynqmp.c                                     |    4 
 drivers/scsi/qla2xxx/qla_def.h                               |    2 
 drivers/scsi/qla2xxx/qla_dfs.c                               |  124 ++
 drivers/scsi/qla2xxx/qla_gbl.h                               |    3 
 drivers/scsi/qla2xxx/qla_init.c                              |   28 
 drivers/scsi/st.c                                            |    6 
 drivers/scsi/st.h                                            |    1 
 drivers/scsi/storvsc_drv.c                                   |    1 
 drivers/soc/mediatek/mtk-devapc.c                            |   18 
 drivers/soc/qcom/smem_state.c                                |    3 
 drivers/soc/qcom/socinfo.c                                   |    2 
 drivers/spi/atmel-quadspi.c                                  |  118 +-
 drivers/tty/serial/sh-sci.c                                  |   25 
 drivers/tty/serial/xilinx_uartps.c                           |   10 
 drivers/ufs/host/ufs-qcom.c                                  |   18 
 drivers/usb/gadget/function/f_tcm.c                          |   54 -
 drivers/vfio/platform/vfio_platform_common.c                 |   10 
 fs/binfmt_flat.c                                             |    2 
 fs/btrfs/file.c                                              |    2 
 fs/btrfs/inode.c                                             |    4 
 fs/btrfs/ordered-data.c                                      |   12 
 fs/btrfs/relocation.c                                        |   14 
 fs/btrfs/transaction.c                                       |    4 
 fs/cachefiles/interface.c                                    |   14 
 fs/cachefiles/ondemand.c                                     |   30 
 fs/exec.c                                                    |   29 
 fs/nfs/flexfilelayout/flexfilelayout.c                       |   27 
 fs/nilfs2/inode.c                                            |    6 
 fs/ocfs2/dir.c                                               |   25 
 fs/ocfs2/super.c                                             |    2 
 fs/ocfs2/symlink.c                                           |    5 
 fs/proc/array.c                                              |    2 
 fs/smb/client/cifsglob.h                                     |   14 
 fs/smb/client/dir.c                                          |    6 
 fs/smb/client/smb1ops.c                                      |    2 
 fs/smb/client/smb2inode.c                                    |  108 +-
 fs/smb/client/smb2ops.c                                      |   18 
 fs/smb/client/smb2pdu.c                                      |    2 
 fs/smb/client/smb2proto.h                                    |    2 
 fs/smb/server/transport_ipc.c                                |    9 
 fs/xfs/xfs_inode.c                                           |    7 
 fs/xfs/xfs_iomap.c                                           |    6 
 include/drm/drm_connector.h                                  |    5 
 include/linux/binfmts.h                                      |    4 
 include/linux/kvm_host.h                                     |    9 
 include/linux/mlx5/driver.h                                  |    1 
 include/net/sch_generic.h                                    |    2 
 include/rv/da_monitor.h                                      |    4 
 include/trace/events/rxrpc.h                                 |    1 
 include/uapi/linux/input-event-codes.h                       |    1 
 include/ufs/ufs.h                                            |    4 
 io_uring/io_uring.c                                          |    5 
 io_uring/net.c                                               |    5 
 io_uring/poll.c                                              |    4 
 io_uring/rw.c                                                |   10 
 kernel/printk/printk.c                                       |    2 
 kernel/sched/core.c                                          |    6 
 kernel/trace/trace_osnoise.c                                 |   17 
 lib/Kconfig.debug                                            |    8 
 lib/maple_tree.c                                             |   23 
 mm/kfence/core.c                                             |    2 
 mm/kmemleak.c                                                |    2 
 net/bluetooth/l2cap_sock.c                                   |    7 
 net/bluetooth/mgmt.c                                         |   12 
 net/ipv4/udp.c                                               |    4 
 net/ipv6/udp.c                                               |    4 
 net/mptcp/pm_netlink.c                                       |    3 
 net/mptcp/protocol.c                                         |    1 
 net/ncsi/internal.h                                          |    2 
 net/ncsi/ncsi-cmd.c                                          |    3 
 net/ncsi/ncsi-manage.c                                       |   38 
 net/ncsi/ncsi-pkt.h                                          |   10 
 net/ncsi/ncsi-rsp.c                                          |   58 -
 net/nfc/nci/hci.c                                            |    2 
 net/rose/af_rose.c                                           |   24 
 net/rxrpc/ar-internal.h                                      |    2 
 net/rxrpc/call_object.c                                      |    6 
 net/rxrpc/conn_event.c                                       |   21 
 net/rxrpc/conn_object.c                                      |    1 
 net/rxrpc/input.c                                            |    2 
 net/rxrpc/sendmsg.c                                          |    2 
 net/sched/sch_netem.c                                        |    2 
 net/tipc/crypto.c                                            |    4 
 rust/kernel/init.rs                                          |    2 
 scripts/Makefile.extrawarn                                   |    5 
 scripts/gdb/linux/cpus.py                                    |    2 
 security/safesetid/securityfs.c                              |    3 
 security/tomoyo/common.c                                     |    2 
 sound/pci/hda/hda_auto_parser.c                              |    8 
 sound/pci/hda/hda_auto_parser.h                              |    1 
 sound/pci/hda/patch_realtek.c                                |    2 
 sound/soc/amd/Kconfig                                        |    2 
 sound/soc/amd/yc/acp6x-mach.c                                |   28 
 sound/soc/soc-pcm.c                                          |   32 
 tools/perf/bench/epoll-wait.c                                |    7 
 tools/testing/selftests/net/ipsec.c                          |    3 
 tools/testing/selftests/net/mptcp/mptcp_connect.c            |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh              |    2 
 tools/testing/selftests/net/udpgso.c                         |   26 
 tools/tracing/rtla/src/osnoise.c                             |    2 
 tools/tracing/rtla/src/timerlat_hist.c                       |   26 
 tools/tracing/rtla/src/timerlat_top.c                        |   27 
 tools/tracing/rtla/src/trace.c                               |    8 
 tools/tracing/rtla/src/trace.h                               |    1 
 258 files changed, 2394 insertions(+), 1205 deletions(-)

Alex Williamson (1):
      vfio/platform: check the bounds of read/write syscalls

Alexander Sverdlin (1):
      leds: lp8860: Write full EEPROM, not only half of it

Anandu Krishnan E (1):
      misc: fastrpc: Deregister device nodes properly in error scenarios

Anastasia Belova (1):
      clk: qcom: clk-rpmh: prevent integer overflow in recalc_rate

Andreas Kemnade (1):
      ARM: dts: ti/omap: gta04: fix pm issues caused by spi module

Andy Shevchenko (1):
      ACPI: property: Fix return value for nval == 0 in acpi_data_prop_read()

Anshuman Khandual (1):
      arm64/mm: Ensure adequate HUGE_MAX_HSTATE

Armin Wolf (1):
      platform/x86: acer-wmi: Ignore AC events

Aubrey Li (1):
      ACPI: PRM: Remove unnecessary strict handler address checks

Bao D. Nguyen (1):
      scsi: ufs: core: Fix the HIGH/LOW_TEMP Bit Definitions

Bartosz Golaszewski (2):
      crypto: qce - fix goto jump in error path
      crypto: qce - unregister previously registered algos in error path

Bence Csókás (1):
      spi: atmel-qspi: Memory barriers after memory-mapped I/O

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8821ae: Fix media status report

Borislav Petkov (1):
      APEI: GHES: Have GHES honor the panic= setting

Brad Griffis (1):
      arm64: tegra: Fix Tegra234 PCIe interrupt-map

Brian Geffon (1):
      drm/i915: Fix page cleanup on DMA remap failure

Carlos Llamas (1):
      lockdep: Fix upper limit for LOCKDEP_*_BITS configs

Catalin Marinas (1):
      mm: kmemleak: fix upper boundary check for physical address objects

Chih-Kang Chang (1):
      wifi: rtw89: add crystal_cap check to avoid setting as overflow value

Claudiu Beznea (2):
      serial: sh-sci: Drop __initdata macro for port_cfg
      serial: sh-sci: Do not probe the serial port if its slot in sci_ports[] is in use

Cody Eksal (1):
      clk: sunxi-ng: a100: enable MMC clock reparenting

Cong Wang (1):
      netem: Update sch->q.qlen before qdisc_tree_reduce_backlog()

Conor Dooley (1):
      pwm: microchip-core: fix incorrect comparison with max period

Cosmin Tanislav (1):
      media: mc: fix endpoint iteration

Csókás, Bence (1):
      spi: atmel-quadspi: Create `atmel_qspi_ops` to support newer SoC families

Dan Carpenter (4):
      tipc: re-order conditions in tipc_crypto_key_rcv()
      binfmt_flat: Fix integer overflow bug on 32 bit systems
      ksmbd: fix integer overflows on 32 bit systems
      NFC: nci: Add bounds checking in nci_hci_create_pipe()

Daniel Golle (5):
      clk: mediatek: mt2701-vdec: fix conversion to mtk_clk_simple_probe
      clk: mediatek: mt2701-aud: fix conversion to mtk_clk_simple_probe
      clk: mediatek: mt2701-bdp: add missing dummy clk
      clk: mediatek: mt2701-img: add missing dummy clk
      clk: mediatek: mt2701-mm: add missing dummy clk

Daniel Wagner (2):
      nvme: handle connectivity loss in nvme_set_queue_count
      nvme-fc: use ctrl state getter

Daniele Ceraolo Spurio (1):
      drm/i915/guc: Debug print LRC state entries only if the context is pinned

David Hildenbrand (1):
      KVM: s390: vsie: fix some corner-cases when grabbing vsie pages

David Howells (2):
      rxrpc: Fix the rxrpc_connection attend queue handling
      rxrpc: Fix call state set to not include the SERVER_SECURING state

David Woodhouse (1):
      x86/kexec: Allocate PGD for x86_64 transition page tables separately

Denis Arefev (1):
      ubi: Add a check for ubi_num

Dmitry Antipov (1):
      wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()

Dmitry Baryshkov (9):
      drm/connector: add mutex to protect ELD from concurrent access
      drm/bridge: anx7625: use eld_mutex to protect access to connector->eld
      drm/bridge: ite-it66121: use eld_mutex to protect access to connector->eld
      drm/amd/display: use eld_mutex to protect access to connector->eld
      drm/exynos: hdmi: use eld_mutex to protect access to connector->eld
      drm/radeon: use eld_mutex to protect access to connector->eld
      drm/sti: hdmi: use eld_mutex to protect access to connector->eld
      drm/vc4: hdmi: use eld_mutex to protect access to connector->eld
      arm64: dts: qcom: sm8550: correct MDSS interconnects

Dongwon Kim (1):
      drm/virtio: New fence for every plane update

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset mic on Positivo C6400

Ekansh Gupta (2):
      misc: fastrpc: Fix registered buffer page address
      misc: fastrpc: Fix copy buffer page size

Eric Biggers (2):
      scsi: ufs: qcom: Fix crypto key eviction
      crypto: qce - fix priority to be less than ARMv8 CE

Eric Dumazet (1):
      net: rose: lock the socket in rose_bind()

Even Xu (1):
      HID: Wacom: Add PCI Wacom device support

Fangzhi Zuo (1):
      drm/amd/display: Fix Mode Cutoff in DSC Passthrough to DP2.1 Monitor

Fedor Pchelkin (2):
      Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc
      Bluetooth: L2CAP: accept zero as a special value for MTU auto-selection

Filipe Manana (3):
      btrfs: fix assertion failure when splitting ordered extent after transaction abort
      btrfs: fix use-after-free when attempting to join an aborted transaction
      btrfs: avoid monopolizing a core when activating a swap file

Fiona Klute (1):
      wifi: rtw88: sdio: Fix disconnection after beacon loss

Florian Fainelli (1):
      net: bcmgenet: Correct overlaying of PHY and MAC Wake-on-LAN

Foster Snowhill (7):
      usbnet: ipheth: fix possible overflow in DPE length check
      usbnet: ipheth: use static NDP16 location in URB
      usbnet: ipheth: check that DPE points past NCM header
      usbnet: ipheth: refactor NCM datagram loop
      usbnet: ipheth: break up NCM header size computation
      usbnet: ipheth: fix DPE OoB read
      usbnet: ipheth: document scope of NCM implementation

Frank Li (1):
      i3c: master: Fix missing 'ret' assignment in set_speed()

Gabor Juhos (1):
      clk: qcom: clk-alpha-pll: fix alpha mode configuration

Gabriele Monaco (1):
      rv: Reset per-task monitors also for idle tasks

Georg Gottleuber (2):
      nvme-pci: Add TUXEDO InfinityFlex to Samsung sleep quirk
      nvme-pci: Add TUXEDO IBP Gen9 to Samsung sleep quirk

Greg Kroah-Hartman (1):
      Linux 6.6.78

Hans Verkuil (1):
      gpu: drm_dp_cec: fix broken CEC adapter properties check

Hans de Goede (2):
      mfd: lpc_ich: Add another Gemini Lake ISA bridge PCI device-id
      platform/x86: int3472: Check for adev == NULL

Hao-ran Zheng (1):
      btrfs: fix data race when accessing the inode's disk_i_size at btrfs_drop_extents()

Haoxiang Li (1):
      drm/komeda: Add check for komeda_get_layer_fourcc_list()

Heiko Carstens (1):
      s390/futex: Fix FUTEX_OP_ANDN implementation

Heiko Stuebner (1):
      HID: hid-sensor-hub: don't use stale platform-data on remove

Heming Zhao (1):
      ocfs2: fix incorrect CPU endianness conversion causing mount failure

Hermes Wu (5):
      drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
      drm/bridge: it6505: fix HDCP Bstatus check
      drm/bridge: it6505: fix HDCP encryption when R0 ready
      drm/bridge: it6505: fix HDCP CTS compare V matching
      drm/bridge: it6505: fix HDCP CTS KSV list wait timer

Hou Tao (2):
      dm-crypt: don't update io->sector after kcryptd_crypt_write_io_submit()
      dm-crypt: track tag_offset in convert_context

Ido Schimmel (1):
      net: sched: Fix truncation of offloaded action statistics

Illia Ostapyshyn (1):
      Input: allocate keycode for phone linking

Ivan Stepchenko (1):
      mtd: onenand: Fix uninitialized retlen in do_otp_read()

Jacob Moroni (1):
      net: atlantic: fix warning during hot unplug

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: increase gmac rx_delay on rk3399-puma

Jan Kiszka (1):
      scripts/gdb: fix aarch64 userspace detection in get_current_task

Jarkko Sakkinen (1):
      tpm: Change to kvalloc() in eventlog/acpi.c

Javier Carrasco (2):
      iio: light: as73211: fix channel handling in only-color triggered buffer
      pinctrl: samsung: fix fwnode refcount cleanup if platform_get_irq_optional() fails

Jennifer Berringer (1):
      nvmem: core: improve range check for nvmem_cell_write()

Jens Axboe (2):
      block: don't revert iter for -EIOCBQUEUED
      io_uring/net: don't retry connect operation on EPOLLERR

Jiasheng Jiang (1):
      ice: Add check for devm_kzalloc()

Josef Bacik (1):
      btrfs: convert BUG_ON in btrfs_reloc_cow_block() to proper error handling

Juergen Gross (2):
      x86/xen: fix xen_hypercall_hvm() to not clobber %rbx
      x86/xen: add FRAME_END to xen_hypercall_hvm()

Kai Mäkisara (1):
      scsi: st: Don't set pos_unknown just after device recognition

Kees Cook (1):
      exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case

Kexy Biscuit (1):
      MIPS: Loongson64: remove ROM Size unit in boardinfo

Koichiro Den (1):
      Revert "btrfs: avoid monopolizing a core when activating a swap file"

Konrad Dybcio (1):
      clk: qcom: Make GCC_8150 depend on QCOM_GDSC

Krzysztof Kozlowski (17):
      arm64: dts: qcom: sm6115: Fix MPSS memory length
      arm64: dts: qcom: sm6115: Fix CDSP memory length
      arm64: dts: qcom: sm6115: Fix ADSP memory base and length
      arm64: dts: qcom: sm6350: Fix ADSP memory length
      arm64: dts: qcom: sm6350: Fix MPSS memory length
      arm64: dts: qcom: sm6375: Fix ADSP memory length
      arm64: dts: qcom: sm6375: Fix CDSP memory base and length
      arm64: dts: qcom: sm6375: Fix MPSS memory base and length
      arm64: dts: qcom: sm8350: Fix ADSP memory base and length
      arm64: dts: qcom: sm8350: Fix CDSP memory base and length
      arm64: dts: qcom: sm8350: Fix MPSS memory length
      arm64: dts: qcom: sm8450: Fix CDSP memory length
      arm64: dts: qcom: sm8450: Fix MPSS memory length
      arm64: dts: qcom: sm8550: Fix CDSP memory length
      arm64: dts: qcom: sm8550: Fix MPSS memory length
      soc: mediatek: mtk-devapc: Fix leaking IO map on error paths
      soc: qcom: smem_state: fix missing of_node_put in error path

Kuan-Wei Chiu (3):
      printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
      perf bench: Fix undefined behavior in cmpworker()
      ALSA: hda: Fix headset detection failure due to unstable sort

Kuninori Morimoto (1):
      ASoC: soc-pcm: don't use soc_pcm_ret() on .prepare callback

Lenny Szubowicz (1):
      tg3: Disable tg3 PCIe AER on system reboot

Leo Stone (1):
      safesetid: check size of policy writes

Lijo Lazar (1):
      drm/amd/pm: Mark MM activity as unsupported

Liu Ye (1):
      selftests/net/ipsec: Fix Null pointer dereference in rtattr_pack()

Long Li (1):
      scsi: storvsc: Set correct data length for sending SCSI command without payload

Lubomir Rintel (1):
      media: mmp: Bring back registration of the device

Luca Weiss (4):
      clk: qcom: gcc-sm6350: Add missing parent_map for two clocks
      clk: qcom: dispcc-sm6350: Add missing parent_map for a clock
      arm64: dts: qcom: sm6350: Fix uart1 interconnect path
      nvmem: qcom-spmi-sdam: Set size in struct nvmem_config

Maarten Lankhorst (1):
      drm/modeset: Handle tiled displays in pan_display_atomic.

Maciej Fijalkowski (1):
      ice: put Rx buffers after being done with current frame

Maciej S. Szmigiero (1):
      net: wwan: iosm: Fix hibernation by re-binding the driver around it

Manivannan Sadhasivam (1):
      clk: qcom: gcc-sm8550: Do not turn off PCIe GDSCs during gdsc_disable()

Marc Zyngier (1):
      KVM: arm64: timer: Always evaluate the need for a soft timer

Marcel Hamer (1):
      wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize()

Marco Elver (1):
      kfence: skip __GFP_THISNODE allocations on NUMA systems

Mario Limonciello (1):
      ASoC: acp: Support microphone from Lenovo Go S

Mark Tomlinson (1):
      gpio: pca953x: Improve interrupt support

Mateusz Jończyk (1):
      mips/math-emu: fix emulation of the prefx instruction

Matthew Wilcox (Oracle) (1):
      ocfs2: handle a symlink read error correctly

Matthieu Baerts (NGI0) (3):
      selftests: mptcp: connect: -f: no reconnect
      mptcp: pm: only set fullmesh for subflow endp
      selftests: mptcp: join: fix AF_INET6 variable

Mazin Al Haddad (1):
      Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt_remove_adv_monitor_sync

Meetakshi Setiya (1):
      smb: client: change lease epoch type from unsigned int to __u16

Mehdi Djait (1):
      media: ccs: Fix cleanup order in ccs_probe()

Michal Simek (1):
      rtc: zynqmp: Fix optional clock name property

Miguel Ojeda (1):
      rust: init: use explicit ABI to clean warning in future compilers

Mike Snitzer (1):
      pnfs/flexfiles: retry getting layout segment for reads

Milos Reljin (1):
      net: phy: c45-tjaxx: add delay between MDIO write and read in soft_reset

Miri Korenblit (1):
      wifi: iwlwifi: avoid memory leak

Nam Cao (1):
      fs/proc: do_task_stat: Fix ESP not readable during coredump

Narayana Murty N (1):
      powerpc/pseries/eeh: Fix get PE state translation

Nathan Chancellor (3):
      efi: libstub: Use '-std=gnu11' to fix build with GCC 15
      kbuild: Move -Wenum-enum-conversion to W=2
      x86/boot: Use '-std=gnu11' to fix build with GCC 15

Naushir Patuck (1):
      media: imx296: Add standby delay during probe

Nick Chan (1):
      irqchip/apple-aic: Only handle PMC interrupt as FIQ when configured so

Nick Morrow (1):
      wifi: mt76: mt7921u: Add VID/PID for TP-Link TXE50UH

Nikita Zhandarovich (1):
      nilfs2: fix possible int overflows in nilfs_fiemap()

Niklas Cassel (1):
      ata: libata-sff: Ensure that we cannot write outside the allocated buffer

Paolo Abeni (1):
      mptcp: prevent excessive coalescing on receive

Paolo Bonzini (1):
      KVM: e500: always restore irqs

Paul Fertser (3):
      net/ncsi: fix locking in Get MAC Address handling
      net/ncsi: wait for the last response to Deselect Package before configuring channel
      net/ncsi: use dev_set_mac_address() for Get MC MAC Address handling

Pavel Begunkov (3):
      io_uring: fix multishots with selected buffers
      io_uring: fix io_req_prep_async with provided buffers
      io_uring/rw: commit provided buffer state on async

Pekka Pessi (1):
      mailbox: tegra-hsp: Clear mailbox before using message

Peter Delevoryas (1):
      net/ncsi: Add NC-SI 1.2 Get MC MAC Address command

Prasad Pandit (1):
      firmware: iscsi_ibft: fix ISCSI_IBFT Kconfig entry

Prike Liang (1):
      drm/amdkfd: only flush the validate MES contex

Quinn Tran (1):
      scsi: qla2xxx: Move FCE Trace buffer allocation to user control

Randolph Ha (1):
      i2c: Force ELAN06FA touchpad I2C bus freq to 100KHz

Ricardo Ribalda (4):
      media: uvcvideo: Fix crash during unbind if gpio unit is in use
      media: uvcvideo: Fix event flags in uvc_ctrl_send_events
      media: uvcvideo: Support partial control reads
      media: uvcvideo: Remove redundant NULL assignment

Richard Acayan (1):
      iommu/arm-smmu-qcom: add sdm670 adreno iommu compatible

Robin Murphy (1):
      iommu/arm-smmu-v3: Clean up more on probe failure

Romain Naour (1):
      ARM: dts: dra7: Add bus_dma_limit for l4 cfg bus

Ruben Devos (1):
      smb: client: fix order of arguments of tracepoints

Sakari Ailus (2):
      media: ccs: Clean up parsed CCS static data on parse failure
      media: ccs: Fix CCS static data parsing for large block sizes

Sam Bobrowicz (1):
      media: ov5640: fix get_light_freq on auto

Sankararaman Jayaraman (1):
      vmxnet3: Fix tx queue race condition with XDP

Sascha Hauer (3):
      nvmem: imx-ocotp-ele: simplify read beyond device check
      nvmem: imx-ocotp-ele: fix reading from non zero offset
      nvmem: imx-ocotp-ele: set word length to 1

Satya Priya Kakitapalli (1):
      clk: qcom: gcc-mdm9607: Fix cmd_rcgr offset for blsp1_uart6 rcg

Sean Anderson (1):
      tty: xilinx_uartps: split sysrq handling

Sean Christopherson (6):
      KVM: PPC: e500: Mark "struct page" dirty in kvmppc_e500_shadow_map()
      KVM: PPC: e500: Mark "struct page" pfn accessed before dropping mmu_lock
      KVM: PPC: e500: Use __kvm_faultin_pfn() to handle page faults
      KVM: Explicitly verify target vCPU is online in kvm_get_vcpu()
      KVM: x86: Make x2APIC ID 100% readonly
      KVM: x86: Re-split x2APIC ICR into ICR+ICR2 for AMD (x2AVIC)

Sebastian Wiese-Wagner (1):
      ALSA: hda/realtek: Enable Mute LED on HP Laptop 14s-fq1xxx

Shawn Lin (1):
      mmc: core: Respect quirk_max_rate for non-UHS SDIO card

Shayne Chen (1):
      wifi: mt76: mt7915: add module param to select 5 GHz or 6 GHz on MT7916

Stas Sergeev (1):
      tun: fix group permission check

Stefan Dösinger (1):
      wifi: brcmfmac: Check the return value of of_property_read_string_index()

Stephan Gerhold (1):
      soc: qcom: socinfo: Avoid out of bounds read of serial number

Steve Wahl (1):
      x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

Steven Rostedt (1):
      tracing/osnoise: Fix resetting of tracepoints

Su Yue (1):
      ocfs2: check dir i_size in ocfs2_find_entry

Suleiman Souhlal (1):
      sched: Don't try to catch up excess steal time.

Sumit Gupta (2):
      arm64: tegra: Fix typo in Tegra234 dce-fabric compatible
      arm64: tegra: Disable Tegra234 sce-fabric node

Sven Schnelle (1):
      s390/stackleak: Use exrl instead of ex in __stackleak_poison()

Tetsuo Handa (1):
      tomoyo: don't emit warning in tomoyo_write_control()

Thadeu Lima de Souza Cascardo (1):
      Revert "media: uvcvideo: Require entities to have a non-zero unique ID"

Thinh Nguyen (4):
      usb: gadget: f_tcm: Translate error to sense
      usb: gadget: f_tcm: Decrement command ref count on cleanup
      usb: gadget: f_tcm: ep_autoconfig with fullspeed endpoint
      usb: gadget: f_tcm: Don't prepare BOT write request twice

Thomas Weißschuh (1):
      ptp: Ensure info->enable callback is always set

Thomas Zimmermann (2):
      m68k: vga: Fix I/O defines
      drm/rockchip: cdn-dp: Use drm_connector_helper_hpd_irq_event()

Tiezhu Yang (1):
      LoongArch: Extend the maximum number of watchpoints

Tom Chung (1):
      Revert "drm/amd/display: Use HW lock mgr for PSR1"

Tomas Glozar (6):
      rtla/osnoise: Distinguish missing workload option
      rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
      rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads
      rtla: Add trace_instance_stop
      rtla/timerlat_hist: Stop timerlat tracer on signal
      rtla/timerlat_top: Stop timerlat tracer on signal

Tomi Valkeinen (5):
      media: i2c: ds90ub960: Fix UB9702 refclk register access
      media: i2c: ds90ub9x3: Fix extra fwnode_handle_put()
      media: i2c: ds90ub960: Fix use of non-existing registers on UB9702
      media: i2c: ds90ub960: Fix UB9702 VC map
      media: i2c: ds90ub960: Fix logging SP & EQ status only for UB9702

Vadim Fedorenko (1):
      net/mlx5: use do_aux_work for PHC overflow checks

Ville Syrjälä (1):
      drm/i915: Drop 64bpp YUV formats from ICL+ SDR planes

Vimal Agrawal (1):
      misc: misc_minor_alloc to use ida for all dynamic/misc dynamic minors

Viresh Kumar (1):
      cpufreq: s3c64xx: Fix compilation warning

WangYuli (1):
      MIPS: ftrace: Declare ftrace_get_parent_ra_addr() as static

Wei Yang (1):
      maple_tree: simplify split calculation

Wentao Liang (2):
      xfs: Propagate errors from xfs_reflink_cancel_cow_range in xfs_dax_write_iomap_end
      xfs: Add error handling for xfs_reflink_cancel_cow_range

Werner Sembach (1):
      PCI: Avoid putting some root ports into D3 on TUXEDO Sirius Gen1

Willem de Bruijn (1):
      tun: revert fix group permission check

Yan Zhai (1):
      udp: gso: do not drop small packets when PMTU reduces

Yazen Ghannam (1):
      x86/amd_nb: Restrict init function to AMD-based systems

Yu-Chun Lin (1):
      ASoC: amd: Add ACPI dependency to fix build error

Yuanjie Yang (1):
      mmc: sdhci-msm: Correctly set the load for the regulator

Zijun Hu (5):
      blk-cgroup: Fix class @block_class's subsystem refcount leakage
      of: Correct child specifier used as input of the 2nd nexus node
      of: Fix of_find_node_opts_by_path() handling of alias+path+options
      of: reserved-memory: Fix using wrong number of cells to get property 'alignment'
      PCI: endpoint: Finish virtual EP removal in pci_epf_remove_vepf()

Zizhi Wo (1):
      cachefiles: Fix NULL pointer dereference in object->file


