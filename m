Return-Path: <stable+bounces-91955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADAB9C216C
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 17:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC091C23D61
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 16:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D17719342F;
	Fri,  8 Nov 2024 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b4HjXFqh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEA219309B;
	Fri,  8 Nov 2024 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081617; cv=none; b=fSyhEoYYVsVAFPeS/m02sBa1xIfMmVjXdQB8Zkd7nOdhqk9aKfqK1AI/eqTcbsK8Xg06Ff/3BD4bGVzJ8lg2k0Y2FIr8EPCleLGlDTA5Go9We3uly1gCXm1YkdA0Z2VchQ3cN2Oh5QFtBbPM2jTkJME08nwEQmUpZjf3aT8EJ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081617; c=relaxed/simple;
	bh=zrnjZvQ83d+SrlR/1iDLc5dVp1BjYsjleZASWj0c3xY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LgIx/gIfcDb6kpPsOXIHhEq92wSBVRmfwkJGIr0uqNOBa5DyoHuHopAL7cswH8T6J53mC+Xxax+HHyzGeZCcRnXldf3jRwwIggrCHpzBlKAkDkfYNHClsnZMN4R7gI/4A8Py4iTZU+EJaORS5tWGGjwfIebQgBFa9k/QTAO9hs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b4HjXFqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C541AC4CECF;
	Fri,  8 Nov 2024 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731081616;
	bh=zrnjZvQ83d+SrlR/1iDLc5dVp1BjYsjleZASWj0c3xY=;
	h=From:To:Cc:Subject:Date:From;
	b=b4HjXFqhCtEcY8QwFeX/BVRYzvmNUFaCx2l04R+xFnPyLZDmjKcHo0c8zyMkv6lXJ
	 eLSKBEdEeUSVk62QlOXvsiyK6kW8n3+9/XOImkqZSk73FVPeWyL99wmve1wnGPc8rH
	 aOGvd6jc5t2IcA3ptnXg2dwELfKA4zDb44EkJuRE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.11.7
Date: Fri,  8 Nov 2024 16:59:44 +0100
Message-ID: <2024110845-cattishly-matter-4f04@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.11.7 kernel.

All users of the 6.11 kernel series must upgrade.

The updated 6.11.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.11.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml      |   21 
 Documentation/driver-api/dpll.rst                              |   21 
 Documentation/netlink/specs/dpll.yaml                          |   24 
 Documentation/rust/arch-support.rst                            |    2 
 Makefile                                                       |    2 
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi                     |    2 
 arch/arm64/boot/dts/qcom/msm8939.dtsi                          |    2 
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts        |    2 
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts                      |    2 
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts       |    2 
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                      |    2 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                         |   34 -
 arch/mips/kernel/cmpxchg.c                                     |    1 
 arch/riscv/Kconfig                                             |    2 
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi                |    2 
 arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts          |    3 
 arch/riscv/kernel/acpi.c                                       |    4 
 arch/riscv/kernel/asm-offsets.c                                |    2 
 arch/riscv/kernel/cacheinfo.c                                  |    7 
 arch/riscv/kernel/cpu-hotplug.c                                |    2 
 arch/riscv/kernel/efi-header.S                                 |    2 
 arch/riscv/kernel/traps_misaligned.c                           |    2 
 arch/riscv/kernel/vdso/Makefile                                |    1 
 arch/x86/include/asm/bug.h                                     |   12 
 arch/x86/kernel/traps.c                                        |   71 ++
 block/blk-map.c                                                |    4 
 drivers/accel/ivpu/ivpu_debugfs.c                              |    9 
 drivers/accel/ivpu/ivpu_hw.c                                   |    1 
 drivers/accel/ivpu/ivpu_hw.h                                   |    1 
 drivers/accel/ivpu/ivpu_hw_ip.c                                |    5 
 drivers/acpi/cppc_acpi.c                                       |    9 
 drivers/acpi/resource.c                                        |   18 
 drivers/base/core.c                                            |   48 +
 drivers/base/module.c                                          |    4 
 drivers/char/tpm/tpm-chip.c                                    |   10 
 drivers/char/tpm/tpm-dev-common.c                              |    3 
 drivers/char/tpm/tpm-interface.c                               |    6 
 drivers/char/tpm/tpm2-sessions.c                               |  100 ++-
 drivers/cxl/Kconfig                                            |    1 
 drivers/cxl/Makefile                                           |   20 
 drivers/cxl/acpi.c                                             |    7 
 drivers/cxl/core/hdm.c                                         |   50 +
 drivers/cxl/core/port.c                                        |   13 
 drivers/cxl/core/region.c                                      |   48 -
 drivers/cxl/core/trace.h                                       |   17 
 drivers/cxl/cxl.h                                              |    3 
 drivers/cxl/port.c                                             |   17 
 drivers/dpll/dpll_netlink.c                                    |  130 ++++
 drivers/dpll/dpll_nl.c                                         |    5 
 drivers/firmware/arm_sdei.c                                    |    2 
 drivers/firmware/microchip/mpfs-auto-update.c                  |   42 -
 drivers/gpio/gpio-sloppy-logic-analyzer.c                      |    4 
 drivers/gpio/gpiolib.c                                         |    4 
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c                         |    9 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c              |    1 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                      |   15 
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c               |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c           |    6 
 drivers/gpu/drm/i915/display/intel_alpm.c                      |    2 
 drivers/gpu/drm/i915/display/intel_backlight.c                 |   10 
 drivers/gpu/drm/i915/display/intel_display_device.c            |    5 
 drivers/gpu/drm/i915/display/intel_display_device.h            |    2 
 drivers/gpu/drm/i915/display/intel_display_power.c             |    8 
 drivers/gpu/drm/i915/display/intel_display_power_well.c        |    4 
 drivers/gpu/drm/i915/display/intel_display_types.h             |    1 
 drivers/gpu/drm/i915/display/intel_display_wa.h                |    8 
 drivers/gpu/drm/i915/display/intel_dp.c                        |   29 
 drivers/gpu/drm/i915/display/intel_dp.h                        |    1 
 drivers/gpu/drm/i915/display/intel_dp_aux.c                    |    4 
 drivers/gpu/drm/i915/display/intel_dp_hdcp.c                   |   11 
 drivers/gpu/drm/i915/display/intel_fbc.c                       |    6 
 drivers/gpu/drm/i915/display/intel_hdcp.c                      |    7 
 drivers/gpu/drm/i915/display/intel_pps.c                       |   14 
 drivers/gpu/drm/i915/display/intel_psr.c                       |    6 
 drivers/gpu/drm/i915/display/intel_tc.c                        |    3 
 drivers/gpu/drm/i915/display/intel_vrr.c                       |    3 
 drivers/gpu/drm/i915/display/skl_universal_plane.c             |    5 
 drivers/gpu/drm/i915/intel_device_info.c                       |    5 
 drivers/gpu/drm/i915/intel_device_info.h                       |    2 
 drivers/gpu/drm/mediatek/mtk_crtc.c                            |   47 -
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c                        |    9 
 drivers/gpu/drm/mediatek/mtk_dp.c                              |   85 ++
 drivers/gpu/drm/panthor/panthor_fw.c                           |    4 
 drivers/gpu/drm/panthor/panthor_gem.c                          |   11 
 drivers/gpu/drm/panthor/panthor_mmu.c                          |   16 
 drivers/gpu/drm/panthor/panthor_mmu.h                          |    1 
 drivers/gpu/drm/panthor/panthor_sched.c                        |   20 
 drivers/gpu/drm/tegra/drm.c                                    |    4 
 drivers/gpu/drm/tests/drm_connector_test.c                     |   24 
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c             |    8 
 drivers/gpu/drm/tests/drm_kunit_helpers.c                      |   42 +
 drivers/gpu/drm/xe/Makefile                                    |    1 
 drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h              |    1 
 drivers/gpu/drm/xe/display/xe_display_wa.c                     |   16 
 drivers/gpu/drm/xe/regs/xe_gt_regs.h                           |   17 
 drivers/gpu/drm/xe/regs/xe_regs.h                              |   10 
 drivers/gpu/drm/xe/regs/xe_sriov_regs.h                        |   23 
 drivers/gpu/drm/xe/xe_device_types.h                           |    6 
 drivers/gpu/drm/xe/xe_ggtt.c                                   |   10 
 drivers/gpu/drm/xe/xe_gt.c                                     |   10 
 drivers/gpu/drm/xe/xe_gt_sriov_pf.c                            |    2 
 drivers/gpu/drm/xe/xe_guc_submit.c                             |   18 
 drivers/gpu/drm/xe/xe_lmtt.c                                   |    2 
 drivers/gpu/drm/xe/xe_module.c                                 |   39 +
 drivers/gpu/drm/xe/xe_sriov.c                                  |    2 
 drivers/gpu/drm/xe/xe_tuning.c                                 |   21 
 drivers/gpu/drm/xe/xe_wa.c                                     |    4 
 drivers/iio/adc/ad7124.c                                       |    2 
 drivers/iio/industrialio-gts-helper.c                          |    4 
 drivers/iio/light/veml6030.c                                   |    2 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                       |    4 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                     |   38 -
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h                     |    2 
 drivers/infiniband/hw/cxgb4/provider.c                         |    1 
 drivers/infiniband/hw/mlx5/qp.c                                |    4 
 drivers/input/input.c                                          |  134 ++--
 drivers/input/touchscreen/edt-ft5x06.c                         |   19 
 drivers/misc/mei/client.c                                      |    4 
 drivers/misc/sgi-gru/grukservices.c                            |    2 
 drivers/misc/sgi-gru/grumain.c                                 |    4 
 drivers/misc/sgi-gru/grutlbpurge.c                             |    2 
 drivers/mmc/host/sdhci-pci-gli.c                               |   38 -
 drivers/net/ethernet/amd/mvme147.c                             |    7 
 drivers/net/ethernet/intel/ice/ice_dpll.c                      |  293 +++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h                      |    1 
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c                    |   21 
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h                    |    1 
 drivers/net/ethernet/mediatek/mtk_wed_wo.h                     |    4 
 drivers/net/ethernet/mellanox/mlxsw/pci.c                      |   25 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c            |   26 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c             |    7 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c               |    8 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h               |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c              |   22 
 drivers/net/gtp.c                                              |   22 
 drivers/net/macsec.c                                           |    3 
 drivers/net/mctp/mctp-i2c.c                                    |    3 
 drivers/net/netdevsim/fib.c                                    |    4 
 drivers/net/wireless/ath/ath10k/wmi-tlv.c                      |    7 
 drivers/net/wireless/ath/ath10k/wmi.c                          |    2 
 drivers/net/wireless/ath/ath11k/dp_rx.c                        |    7 
 drivers/net/wireless/broadcom/brcm80211/Kconfig                |    1 
 drivers/net/wireless/intel/iwlegacy/common.c                   |   15 
 drivers/net/wireless/intel/iwlegacy/common.h                   |   12 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                   |   28 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h                   |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                    |   10 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c              |   12 
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c          |   34 -
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                  |    6 
 drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c            |    1 
 drivers/net/wireless/realtek/rtw89/pci.c                       |   48 +
 drivers/nvme/host/core.c                                       |   19 
 drivers/nvme/host/ioctl.c                                      |    7 
 drivers/nvme/target/auth.c                                     |    1 
 drivers/pci/pci.c                                              |   14 
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c                     |   10 
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c                 |    1 
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c                        |    1 
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c                       |    1 
 drivers/powercap/intel_rapl_msr.c                              |    1 
 drivers/scsi/scsi_debug.c                                      |   10 
 drivers/scsi/scsi_transport_fc.c                               |    4 
 drivers/soc/qcom/pmic_glink.c                                  |   25 
 drivers/spi/spi-fsl-dspi.c                                     |    6 
 drivers/spi/spi-geni-qcom.c                                    |    8 
 drivers/staging/iio/frequency/ad9832.c                         |    7 
 drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c |   70 --
 drivers/thunderbolt/retimer.c                                  |    5 
 drivers/thunderbolt/tb.c                                       |   48 +
 drivers/ufs/core/ufshcd.c                                      |    2 
 drivers/usb/host/xhci-pci.c                                    |    6 
 drivers/usb/host/xhci-ring.c                                   |   16 
 drivers/usb/phy/phy.c                                          |    2 
 drivers/usb/typec/class.c                                      |    1 
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c                  |   10 
 drivers/usb/typec/tcpm/tcpm.c                                  |   10 
 fs/afs/dir.c                                                   |   25 
 fs/afs/dir_edit.c                                              |   91 +++
 fs/afs/internal.h                                              |    2 
 fs/btrfs/bio.c                                                 |   62 --
 fs/btrfs/bio.h                                                 |    3 
 fs/btrfs/defrag.c                                              |   10 
 fs/btrfs/extent_map.c                                          |    7 
 fs/btrfs/volumes.c                                             |    1 
 fs/dax.c                                                       |   45 -
 fs/iomap/buffered-io.c                                         |    7 
 fs/nfs/delegation.c                                            |    5 
 fs/nfsd/nfs4proc.c                                             |    8 
 fs/nilfs2/namei.c                                              |    3 
 fs/nilfs2/page.c                                               |    1 
 fs/ntfs3/file.c                                                |    9 
 fs/ntfs3/frecord.c                                             |    4 
 fs/ntfs3/inode.c                                               |   15 
 fs/ntfs3/lznt.c                                                |    3 
 fs/ntfs3/namei.c                                               |    2 
 fs/ntfs3/ntfs_fs.h                                             |    2 
 fs/ntfs3/record.c                                              |   31 -
 fs/ocfs2/file.c                                                |    8 
 fs/smb/client/cifs_unicode.c                                   |   17 
 fs/smb/client/reparse.c                                        |  174 +++++
 fs/smb/client/reparse.h                                        |    9 
 fs/smb/client/smb2inode.c                                      |    3 
 fs/smb/client/smb2proto.h                                      |    1 
 fs/userfaultfd.c                                               |   28 
 fs/xfs/xfs_filestream.c                                        |   23 
 fs/xfs/xfs_trace.h                                             |   15 
 include/acpi/cppc_acpi.h                                       |    2 
 include/drm/drm_kunit_helpers.h                                |    4 
 include/linux/bpf_mem_alloc.h                                  |    3 
 include/linux/compiler-gcc.h                                   |    4 
 include/linux/device.h                                         |    3 
 include/linux/dpll.h                                           |   15 
 include/linux/input.h                                          |   10 
 include/linux/iomap.h                                          |   19 
 include/linux/ksm.h                                            |   10 
 include/linux/mmzone.h                                         |    7 
 include/linux/rcutiny.h                                        |    5 
 include/linux/rcutree.h                                        |    1 
 include/linux/tick.h                                           |    8 
 include/linux/ubsan.h                                          |    5 
 include/linux/userfaultfd_k.h                                  |    5 
 include/net/ip_tunnels.h                                       |    2 
 include/trace/events/afs.h                                     |    7 
 include/uapi/linux/dpll.h                                      |    3 
 io_uring/rw.c                                                  |   23 
 kernel/bpf/cgroup.c                                            |   19 
 kernel/bpf/helpers.c                                           |   21 
 kernel/bpf/lpm_trie.c                                          |    2 
 kernel/bpf/memalloc.c                                          |   14 
 kernel/bpf/verifier.c                                          |    9 
 kernel/cgroup/cgroup.c                                         |    4 
 kernel/fork.c                                                  |   14 
 kernel/rcu/tree.c                                              |  118 +++-
 kernel/resource.c                                              |    4 
 kernel/sched/fair.c                                            |    4 
 lib/Kconfig.ubsan                                              |    4 
 lib/codetag.c                                                  |    3 
 lib/iov_iter.c                                                 |    6 
 lib/slub_kunit.c                                               |    2 
 mm/kasan/kasan_test.c                                          |   27 
 mm/migrate.c                                                   |    2 
 mm/mmap.c                                                      |    3 
 mm/page_alloc.c                                                |   10 
 mm/rmap.c                                                      |   24 
 mm/shmem.c                                                     |    2 
 mm/shrinker.c                                                  |    8 
 mm/vmscan.c                                                    |  109 ++-
 net/bluetooth/hci_sync.c                                       |   18 
 net/bpf/test_run.c                                             |    1 
 net/core/dev.c                                                 |    4 
 net/core/rtnetlink.c                                           |    4 
 net/core/sock_map.c                                            |    4 
 net/ipv4/ip_tunnel.c                                           |    2 
 net/ipv6/netfilter/nf_reject_ipv6.c                            |   15 
 net/mac80211/Kconfig                                           |    2 
 net/mac80211/cfg.c                                             |    3 
 net/mac80211/key.c                                             |   42 -
 net/mptcp/protocol.c                                           |    2 
 net/netfilter/nft_payload.c                                    |    3 
 net/netfilter/x_tables.c                                       |    2 
 net/sched/cls_api.c                                            |    1 
 net/sched/sch_api.c                                            |    2 
 net/sunrpc/xprtrdma/ib_client.c                                |    1 
 net/wireless/core.c                                            |    1 
 rust/kernel/device.rs                                          |   15 
 rust/kernel/firmware.rs                                        |    2 
 sound/pci/hda/patch_realtek.c                                  |   23 
 sound/soc/codecs/cs42l51.c                                     |    7 
 sound/soc/soc-dapm.c                                           |    2 
 sound/usb/mixer_quirks.c                                       |    3 
 tools/mm/page-types.c                                          |    9 
 tools/mm/slabinfo.c                                            |    4 
 tools/perf/util/python.c                                       |    3 
 tools/perf/util/syscalltbl.c                                   |   10 
 tools/testing/cxl/test/cxl.c                                   |   14 
 tools/testing/selftests/mm/uffd-common.c                       |    5 
 tools/testing/selftests/mm/uffd-common.h                       |    3 
 tools/testing/selftests/mm/uffd-unit-tests.c                   |   21 
 tools/usb/usbip/src/usbip_detach.c                             |    1 
 280 files changed, 2925 insertions(+), 1075 deletions(-)

Abel Vesa (1):
      arm64: dts: qcom: x1e80100: Add Broadcast_AND region in LLCC block

Akshata Jahagirdar (1):
      drm/xe/xe2: Introduce performance changes

Aleksei Vetrov (1):
      ASoC: dapm: fix bounds checker error in dapm_widget_list_create

Alex Deucher (4):
      drm/amdgpu/smu13: fix profile reporting
      drm/amdgpu/swsmu: fix ordering for setting workload_mask
      drm/amdgpu/swsmu: default to fullscreen 3D profile for dGPUs
      drm/amdgpu: handle default profile on on devices without fullscreen 3D

Alexander Usyskin (1):
      mei: use kvmalloc for read buffer

Alexandre Ghiti (1):
      riscv: vdso: Prevent the compiler from inserting calls to memset()

Amit Cohen (3):
      mlxsw: spectrum_ptp: Add missing verification before pushing Tx header
      mlxsw: pci: Sync Rx buffers for CPU
      mlxsw: pci: Sync Rx buffers for device

Amit Sunil Dhamne (1):
      usb: typec: tcpm: restrict SNK_WAIT_CAPABILITIES_TIMEOUT transitions to non self-powered devices

Andrew Ballance (1):
      fs/ntfs3: Check if more than chunk-size bytes are written

Andrey Konovalov (1):
      kasan: remove vmalloc_percpu test

Andrzej Kacprowski (1):
      accel/ivpu: Fix NOC firewall interrupt handling

Andy Shevchenko (1):
      gpio: sloppy-logic-analyzer: Check for error code from devm_mutex_init() call

Arkadiusz Kubalewski (3):
      dpll: add Embedded SYNC feature for a pin
      ice: add callbacks for Embedded SYNC enablement on dpll pins
      ice: fix crash on probe for DPLL enabled E810 LOM

Arnaldo Carvalho de Melo (1):
      perf python: Fix up the build on architectures without HAVE_KVM_STAT_SUPPORT

Basavaraj Natikar (1):
      xhci: Use pm_runtime_get to prevent RPM on unsupported systems

Ben Chuang (2):
      mmc: sdhci-pci-gli: GL9767: Fix low power mode on the set clock function
      mmc: sdhci-pci-gli: GL9767: Fix low power mode in the SD Express process

Ben Hutchings (1):
      wifi: iwlegacy: Fix "field-spanning write" warning in il_enqueue_hcmd()

Benjamin Marzinski (1):
      scsi: scsi_transport_fc: Allow setting rport state to current state

Benjamin Segall (1):
      posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER on clone

Benoît Monin (1):
      net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8192du: Don't claim USB ID 0bda:8171

Bjorn Andersson (1):
      soc: qcom: pmic_glink: Handle GLINK intent allocation rejections

Boris Brezillon (3):
      drm/panthor: Fix firmware initialization on systems with a page size > 4k
      drm/panthor: Fail job creation when the group is dead
      drm/panthor: Report group as timedout when we fail to properly suspend

Byeonguk Jeong (1):
      bpf: Fix out-of-bounds write in trie_get_next_key()

Chen Ridong (2):
      mm: shrinker: avoid memleak in alloc_shrinker_info
      cgroup/bpf: use a dedicated workqueue for cgroup bpf destruction

Christoffer Sandberg (2):
      ALSA: hda/realtek: Fix headset mic on TUXEDO Gemini 17 Gen3
      ALSA: hda/realtek: Fix headset mic on TUXEDO Stellaris 16 Gen6 mb1

Christoph Hellwig (3):
      iomap: improve shared block detection in iomap_unshare_iter
      iomap: turn iomap_want_unshare_iter into an inline function
      xfs: fix finding a last resort AG in xfs_filestream_pick_ag

Christophe JAILLET (1):
      ASoC: cs42l51: Fix some error handling paths in cs42l51_probe()

Chuck Lever (3):
      NFSD: Initialize struct nfsd4_copy earlier
      NFSD: Never decrement pending_async_copies on error
      rpcrdma: Always release the rpcrdma_device's xa_array

Chun-Kuang Hu (1):
      drm/mediatek: Use cmdq_pkt_create() and cmdq_pkt_destroy()

Chunyan Zhang (2):
      riscv: Remove unused GENERATING_ASM_OFFSETS
      riscv: Remove duplicated GET_RM

Cong Wang (1):
      sock_map: fix a NULL pointer dereference in sock_map_link_update_prog()

Conor Dooley (3):
      firmware: microchip: auto-update: fix poll_complete() to not report spurious timeout errors
      riscv: dts: starfive: disable unused csi/camss nodes
      RISC-V: disallow gcc + rust builds

Dai Ngo (1):
      NFS: remove revoked delegation from server's delegation list

Dan Carpenter (2):
      drm/mediatek: Fix potential NULL dereference in mtk_crtc_destroy()
      drm/tegra: Fix NULL vs IS_ERR() check in probe()

Dan Williams (4):
      cxl/port: Fix use-after-free, permit out-of-order decoder shutdown
      cxl/port: Fix CXL port initialization order when the subsystem is built-in
      cxl/port: Fix cxl_bus_rescan() vs bus_rescan_devices()
      cxl/acpi: Ensure ports ready at cxl_acpi_probe() return

Daniel Gabay (1):
      wifi: iwlwifi: mvm: Fix response handling in iwl_mvm_send_recovery_cmd()

Daniel Golle (1):
      net: ethernet: mtk_wed: fix path of MT7988 WO firmware

Daniel Palmer (1):
      net: amd: mvme147: Fix probe banner message

Darrick J. Wong (4):
      iomap: don't bother unsharing delalloc extents
      iomap: share iomap_unshare_iter predicate code with fsdax
      fsdax: remove zeroing code from dax_unshare_iter
      fsdax: dax_unshare_iter needs to copy entire blocks

David Howells (1):
      afs: Fix missing subdir edit when renamed between parent dirs

David Sterba (1):
      MIPS: export __cmpxchg_small()

Dimitri Sivanich (1):
      misc: sgi-gru: Don't disable preemption in GRU driver

Dmitry Torokhov (2):
      Input: edt-ft5x06 - fix regmap leak when probe fails
      Input: fix regression when re-registering input handlers

Dong Chenchen (1):
      netfilter: Fix use-after-free in get_info()

E Shattow (1):
      riscv: dts: starfive: Update ethernet phy0 delay parameter values for Star64

Eduard Zingerman (1):
      bpf: Force checkpoint when jmp history is too long

Edward Adam Davis (1):
      ocfs2: pass u64 to ocfs2_truncate_inline maybe overflow

Edward Liaw (2):
      Revert "selftests/mm: fix deadlock for fork after pthread_create on ARM"
      Revert "selftests/mm: replace atomic_bool with pthread_barrier_t"

Emmanuel Grumbach (3):
      wifi: iwlwifi: mvm: don't leak a link on AP removal
      wifi: iwlwifi: mvm: don't add default link in fw restart flow
      Revert "wifi: iwlwifi: remove retry loops in start"

Eric Dumazet (1):
      netfilter: nf_reject_ipv6: fix potential crash in nf_send_reset6()

Fabien Parent (1):
      arm64: dts: qcom: msm8939: revert use of APCS mbox for RPM

Faisal Hassan (1):
      xhci: Fix Link TRB DMA in command ring stopped completion event

Felix Fietkau (2):
      wifi: mac80211: skip non-uploaded keys in ieee80211_iter_keys
      wifi: mac80211: do not pass a stopped vif to the driver in .get_txpower

Filipe Manana (2):
      btrfs: fix extent map merging not happening for adjacent extents
      btrfs: fix defrag not merging contiguous extents due to merged extent maps

Florian Westphal (1):
      lib: alloc_tag_module_unload must wait for pending kfree_rcu calls

Frank Li (1):
      spi: spi-fsl-dspi: Fix crash when not using GPIO chip select

Frank Min (1):
      drm/amdgpu: fix random data corruption for sdma 7

Furong Xu (1):
      net: stmmac: TSO: Fix unbalanced DMA map/unmap for non-paged SKB data

Gatlin Newhouse (1):
      x86/traps: Enable UBSAN traps on x86

Geert Uytterhoeven (2):
      mac80211: MAC80211_MESSAGE_TRACING should depend on TRACING
      wifi: brcm80211: BRCM_TRACING should depend on TRACING

Georgi Djakov (1):
      spi: geni-qcom: Fix boot warning related to pm_runtime and devres

Gil Fine (1):
      thunderbolt: Honor TMU requirements in the domain when setting TMU mode

Greg Kroah-Hartman (2):
      Revert "driver core: Fix uevent_show() vs driver detach race"
      Linux 6.11.7

Gregory Price (2):
      resource,kexec: walk_system_ram_res_rev must retain resource flags
      vmscan,migrate: fix page count imbalance on node stats when demoting pages

Guilherme Giacomo Simoes (1):
      rust: device: change the from_raw() function

Gustavo Sousa (1):
      drm/i915: Skip programming FIA link enable bits for MTL+

Haibo Chen (1):
      arm64: dts: imx8ulp: correct the flexspi compatible string

Hans de Goede (1):
      ACPI: resource: Fold Asus Vivobook Pro N6506M* DMI quirks together

Heinrich Schuchardt (1):
      riscv: efi: Set NX compat flag in PE/COFF header

Hou Tao (3):
      bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
      bpf: Add bpf_mem_alloc_check_size() helper
      bpf: Check the validity of nr_words in bpf_iter_bits_new()

Hsin-Te Yuan (1):
      drm/mediatek: Fix color format MACROs in OVL

Hugh Dickins (1):
      iov_iter: fix copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP

Ido Schimmel (3):
      ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_init_flow()
      ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
      mlxsw: spectrum_ipip: Fix memory leak when changing remote IPv6 address

Jan Schär (1):
      ALSA: usb-audio: Add quirks for Dell WD19 dock

Jani Nikula (2):
      drm/i915: move rawclk from runtime to display runtime info
      drm/xe/display: drop unused rawclk_freq and RUNTIME_INFO()

Jarkko Sakkinen (3):
      tpm: Return tpm2_sessions_init() when null key creation fails
      tpm: Rollback tpm2_load_null()
      tpm: Lazily flush the auth session

Jason Gunthorpe (1):
      PCI: Fix pci_enable_acs() support for the ACS quirks

Jason-JH.Lin (1):
      drm/mediatek: ovl: Remove the color format comment for ovl_fmt_convert()

Javier Carrasco (4):
      usb: typec: fix unreleased fwnode_handle in typec_port_register_altmodes()
      usb: typec: qcom-pmic-typec: use fwnode_handle_put() to release fwnodes
      usb: typec: qcom-pmic-typec: fix missing fwnode removal in error path
      iio: light: veml6030: fix microlux value calculation

Jens Axboe (1):
      io_uring/rw: fix missing NOWAIT check for O_DIRECT start write

Jeongjun Park (1):
      mm: shmem: fix data-race in shmem_getattr()

Jianbo Liu (1):
      macsec: Fix use-after-free while sending the offloading packet

Jinjie Ruan (5):
      iio: gts-helper: Fix memory leaks for the error path of iio_gts_build_avail_scale_table()
      iio: gts-helper: Fix memory leaks in iio_gts_build_avail_scale_table()
      drm/tests: helpers: Add helper for drm_display_mode_from_cea_vic()
      drm/connector: hdmi: Fix memory leak in drm_display_mode_from_cea_vic()
      drm/tests: hdmi: Fix memory leaks in drm_display_mode_from_cea_vic()

Jiri Slaby (1):
      perf trace: Fix non-listed archs in the syscalltbl routines

Johan Hovold (11):
      phy: qcom: qmp-usb: fix NULL-deref on runtime suspend
      phy: qcom: qmp-usb-legacy: fix NULL-deref on runtime suspend
      phy: qcom: qmp-usbc: fix NULL-deref on runtime suspend
      gpiolib: fix debugfs newline separators
      gpiolib: fix debugfs dangling chip separator
      arm64: dts: qcom: x1e80100-yoga-slim7x: fix nvme regulator boot glitch
      arm64: dts: qcom: x1e80100-vivobook-s15: fix nvme regulator boot glitch
      arm64: dts: qcom: x1e80100: fix PCIe4 interconnect
      arm64: dts: qcom: x1e80100-qcp: fix nvme regulator boot glitch
      arm64: dts: qcom: x1e80100-crd: fix nvme regulator boot glitch
      arm64: dts: qcom: x1e80100: fix PCIe4 and PCIe6a PHY clocks

Johannes Berg (2):
      wifi: cfg80211: clear wdev->cqm_config pointer on free
      wifi: iwlwifi: mvm: fix 6 GHz scan construction

John Garry (1):
      scsi: scsi_debug: Fix do_device_access() handling of unexpected SG copy length

Jouni Högander (1):
      drm/i915/psr: Prevent Panel Replay if CRC calculation is enabled

Juha-Pekka Heikkila (1):
      drm/i915/display: Don't enable decompression on Xe2 with Tile4

Julien Stephan (1):
      dt-bindings: iio: adc: ad7380: fix ad7380-4 reference supply

Kailang Yang (1):
      ALSA: hda/realtek: Limit internal Mic boost on Dell platform

Keith Busch (2):
      nvme: module parameter to disable pi with offsets
      nvme: re-fix error-handling for io_uring nvme-passthrough

Konrad Dybcio (1):
      arm64: dts: qcom: x1e80100: Fix up BAR spaces

Konstantin Komarov (8):
      fs/ntfs3: Fix warning possible deadlock in ntfs_set_state
      fs/ntfs3: Stale inode instead of bad
      fs/ntfs3: Add rough attr alloc_size check
      fs/ntfs3: Fix possible deadlock in mi_read
      fs/ntfs3: Additional check in ni_clear()
      fs/ntfs3: Fix general protection fault in run_is_mapped_full
      fs/ntfs3: Additional check in ntfs_file_release
      fs/ntfs3: Sequential field availability check in mi_enum_attr()

Leon Romanovsky (1):
      RDMA/cxgb4: Dump vendor specific QP details

Ley Foon Tan (1):
      net: stmmac: dwmac4: Fix high address display by updating reg_space[] from register values

Liankun Yang (1):
      drm/mediatek: Fix get efuse issue for MT8188 DPTX

Lorenzo Stoakes (2):
      fork: do not invoke uffd on fork if error occurs
      fork: only invoke khugepaged, ksm hooks if no error

Manikanta Pubbisetty (1):
      wifi: ath10k: Fix memory leak in management tx

Marco Elver (1):
      kasan: Fix Software Tag-Based KASAN with GCC

Matt Fleming (1):
      mm/page_alloc: let GFP_ATOMIC order-0 allocs access highatomic reserves

Matt Johnston (1):
      mctp i2c: handle NULL header address

Matthew Auld (1):
      drm/i915: disable fbc due to Wa_16023588340

Matthew Brost (2):
      drm/xe: Add mmio read before GGTT invalidate
      drm/xe: Don't short circuit TDR on jobs not started

Matthieu Baerts (NGI0) (1):
      mptcp: init: protect sched with rcu_read_lock

Michal Wajdeczko (2):
      drm/xe: Fix register definition order in xe_regs.h
      drm/xe: Kill regs/xe_sriov_regs.h

Mika Westerberg (1):
      thunderbolt: Fix KASAN reported stack out-of-bounds read in tb_retimer_scan()

Miquel Sabaté Solà (1):
      riscv: Prevent a bad reference count on CPU nodes

Miri Korenblit (1):
      wifi: iwlwifi: mvm: really send iwl_txpower_constraints_cmd

Mitul Golani (3):
      drm/i915/display: Cache adpative sync caps to use it later
      drm/i915/display: WA for Re-initialize dispcnlunitt1 xosc clock
      drm/i915/display/dp: Compute AS SDP when vrr is also enabled

Naohiro Aota (1):
      btrfs: fix error propagation of split bios

Ovidiu Bunea (1):
      Revert "drm/amd/display: update DML2 policy EnhancedPrefetchScheduleAccelerationFinal DCN35"

Pablo Neira Ayuso (2):
      gtp: allow -1 to be specified as file description from userspace
      netfilter: nft_payload: sanitize offset and length before calling skb_checksum()

Pali Rohár (2):
      cifs: Improve creating native symlinks pointing to directory
      cifs: Fix creating native symlinks pointing to current or parent directory

Patrisious Haddad (1):
      RDMA/mlx5: Round max_rd_atomic/max_dest_rd_atomic up instead of down

Paulo Alcantara (2):
      smb: client: fix parsing of device numbers
      smb: client: set correct device number on nfs reparse points

Pedro Tammela (1):
      net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT

Pei Xiao (1):
      slub/kunit: fix a WARNING due to unwrapped __kmalloc_cache_noprof

Peter Wang (1):
      scsi: ufs: core: Fix another deadlock during RTC update

Pierre Gondois (1):
      ACPI: CPPC: Make rmw_lock a raw_spin_lock

Ping-Ke Shih (1):
      wifi: rtw89: pci: early chips only enable 36-bit DMA on specific PCI hosts

Qu Wenruo (1):
      btrfs: merge btrfs_orig_bbio_end_io() into btrfs_bio_end_io()

Remi Pommarel (1):
      wifi: ath11k: Fix invalid ring usage in full monitor mode

Richard Zhu (1):
      phy: freescale: imx8m-pcie: Do CMN_RST just before PHY PLL lock check

Ryusuke Konishi (2):
      nilfs2: fix kernel bug due to missing clearing of checked flag
      nilfs2: fix potential deadlock with newly created symlinks

Sabyrzhan Tasbolatov (1):
      x86/traps: move kmsan check after instrumentation_begin

Sai Teja Pottumuttu (1):
      drm/xe/xe2hpg: Introduce performance tuning changes for Xe2_HPG

Selvin Xavier (2):
      RDMA/bnxt_re: Fix the usage of control path spin locks
      RDMA/bnxt_re: synchronize the qp-handle table array

Shawn Wang (1):
      sched/numa: Fix the potential null pointer dereference in task_numa_work()

Shekhar Chauhan (1):
      drm/xe/xe2: Add performance turning changes

Shiju Jose (1):
      cxl/events: Fix Trace DRAM Event Record

Sumeet Pawnikar (1):
      powercap: intel_rapl_msr: Add PL4 support for Arrowlake-U

Sungwoo Kim (1):
      Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs

Suraj Kandpal (4):
      drm/i915/hdcp: Add encoder check in intel_hdcp_get_capability
      drm/i915/hdcp: Add encoder check in hdcp2_get_capability
      drm/i915/dp: Clear VSC SDP during post ddi disable routine
      drm/i915/pps: Disable DPLS_GATING around pps sequence

Tejas Upadhyay (4):
      drm/xe/xe2hpg: Add Wa_15016589081
      drm/xe: Move enable host l2 VRAM post MCR init
      drm/xe: Define STATELESS_COMPRESSION_CTRL as mcr register
      drm/xe: Write all slices if its mcr register

Thomas Zimmermann (1):
      drm/xe: Support 'nomodeset' kernel command-line option

Toke Høiland-Jørgensen (1):
      bpf, test_run: Fix LIVE_FRAME frame update after a page has been recycled

Tvrtko Ursulin (1):
      drm/amd/pm: Vangogh: Fix kernel memory out of bounds write

Uladzislau Rezki (Sony) (2):
      rcu/kvfree: Add kvfree_rcu_barrier() API
      rcu/kvfree: Refactor kvfree_rcu_queue_batch()

Ville Syrjälä (1):
      wifi: iwlegacy: Clear stale interrupts before resuming device

Vitaliy Shevtsov (1):
      nvmet-auth: assign dh_key to NULL after kfree_sensitive

Vladimir Oltean (1):
      net/sched: sch_api: fix xa_insert() error path in tcf_block_get_ext()

Vlastimil Babka (1):
      mm, mmap: limit THP alignment of anonymous mappings to PMD-aligned sizes

Wang Liang (1):
      net: fix crash when config small gso_max_size/gso_ipv4_max_size

WangYuli (1):
      riscv: Use '%u' to format the output of 'cpu'

Wladislav Wiebe (1):
      tools/mm: -Werror fixes in page-types/slabinfo

Xinyu Zhang (1):
      block: fix sanity checks in blk_rq_map_user_bvec

Xiongfeng Wang (1):
      firmware: arm_sdei: Fix the input parameter of cpuhp_remove_state()

Xiu Jianfeng (1):
      cgroup: Fix potential overflow issue when checking max_depth

Yu Zhao (2):
      mm: multi-gen LRU: remove MM_LEAF_OLD and MM_NONLEAF_TOTAL stats
      mm: multi-gen LRU: use {ptep,pmdp}_clear_young_notify()

Yuanchu Xie (1):
      mm: multi-gen LRU: ignore non-leaf pmd_young for force_scan=true

Yunhui Cui (1):
      RISC-V: ACPI: fix early_ioremap to early_memremap

Zhang Rui (2):
      thermal: intel: int340x: processor: Remove MMIO RAPL CPU hotplug support
      thermal: intel: int340x: processor: Add MMIO RAPL PL4 support

Zhiguo Jiang (1):
      mm: shrink skip folio mapped by an exiting process

Zhihao Cheng (1):
      btrfs: fix use-after-free of block device file in __btrfs_free_extra_devids()

Zichen Xie (1):
      netdevsim: Add trailing zero to terminate the string in nsim_nexthop_bucket_activity_write()

Zicheng Qu (2):
      staging: iio: frequency: ad9832: fix division by zero in ad9832_calc_freqreg()
      iio: adc: ad7124: fix division by zero in ad7124_set_channel_odr()

Zijun Hu (1):
      usb: phy: Fix API devm_usb_put_phy() can not release the phy

Zongmin Zhou (1):
      usbip: tools: Fix detach_port() invalid port error path

lei lu (1):
      ntfs3: Add bounds checking to mi_enum_attr()


