Return-Path: <stable+bounces-93012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1199C8C54
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 15:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 156C2B34C12
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39D04D9FB;
	Thu, 14 Nov 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ESBWcPx+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279E2940F;
	Thu, 14 Nov 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592768; cv=none; b=W2zGUAK0xI2ehHMHWVZfJoJVwELRrAQdmxYVCY5Kd0PpIGmyEeITTXOEd+qia+revocYfShrRut1VB0v/XY2Lq6+At/vBkCD3W0QS8Tsk7KKxzgGxzjYkCZS8pt6Q1s22O19mFZQ65SFu+LOoKVVtzc66iHnBtZ6SuFZYXaO7gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592768; c=relaxed/simple;
	bh=bLCIKDD6FVfy4JyqFIKcOScrUR6dV+nIe8UPV51oVWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cFb22/a9iTMUfOZqrKsHKS0XWDgmnYNX2PVTmeGqM+cSsUo1tWKIOOC1azRvH1faA1fcfABD7+UfsiJCKfL/m4VG6wt7Tyhaz03YrRu7IfJ8qYdJslXl+BxpU3EJ+bHl2pM9VKQ9jzaBmdjqO39E7ED68t7woRFAweVWTGYotb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ESBWcPx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2827EC4CECD;
	Thu, 14 Nov 2024 13:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731592765;
	bh=bLCIKDD6FVfy4JyqFIKcOScrUR6dV+nIe8UPV51oVWk=;
	h=From:To:Cc:Subject:Date:From;
	b=ESBWcPx+MhvL7yiBMFSUOb6HcRazKN/fOXvpH9RP0g2Ujpdr4v1S9Jny0gswjSTOk
	 WnM8TR8tBV2DohmK6BtEpuobUhw8h+zatfLcst17b9z+gFJ10DaIjeZyAjlrvN/yhC
	 vowW14cy+0+G/J4tnUJxmiH7QInb3K4KSJXsqBI8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.11.8
Date: Thu, 14 Nov 2024 14:59:16 +0100
Message-ID: <2024111417-sabbath-enjoyer-f6d2@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.11.8 kernel.

All users of the 6.11 kernel series must upgrade.

The updated 6.11.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.11.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml  |    2 
 Documentation/netlink/specs/mptcp_pm.yaml                     |    1 
 Makefile                                                      |    2 
 arch/arm/boot/dts/rockchip/rk3036-kylin.dts                   |    4 
 arch/arm/boot/dts/rockchip/rk3036.dtsi                        |   14 
 arch/arm64/Kconfig                                            |    1 
 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi                |    4 
 arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts  |   12 
 arch/arm64/boot/dts/freescale/imx8mp.dtsi                     |    6 
 arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi             |    8 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                          |    2 
 arch/arm64/boot/dts/rockchip/Makefile                         |    1 
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi               |    1 
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts                |    4 
 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts       |   30 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                      |    3 
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi                 |    1 
 arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts             |    2 
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts         |    2 
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi              |    2 
 arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts    |    2 
 arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg353p.dts       |    2 
 arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg353v.dts       |    2 
 arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts              |    6 
 arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts            |    1 
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi             |    6 
 arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi            |    2 
 arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts            |    1 
 arch/arm64/boot/dts/rockchip/rk3568-roc-pc.dts                |    3 
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                 |   20 -
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts               |    4 
 arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts           |    1 
 arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi           |    1 
 arch/arm64/kernel/fpsimd.c                                    |    1 
 arch/arm64/kernel/smccc-call.S                                |   35 --
 arch/powerpc/kvm/book3s_hv.c                                  |   12 
 arch/xtensa/Kconfig                                           |    1 
 arch/xtensa/include/asm/cmpxchg.h                             |    2 
 block/blk-map.c                                               |   56 +--
 block/blk-merge.c                                             |  146 +++-------
 block/blk-mq.c                                                |   11 
 block/blk.h                                                   |   63 +++-
 drivers/char/tpm/tpm-chip.c                                   |    4 
 drivers/char/tpm/tpm-interface.c                              |   32 +-
 drivers/clk/qcom/clk-alpha-pll.c                              |    2 
 drivers/clk/qcom/gcc-x1e80100.c                               |   12 
 drivers/clk/qcom/videocc-sm8350.c                             |    4 
 drivers/edac/qcom_edac.c                                      |    8 
 drivers/firmware/arm_scmi/bus.c                               |    7 
 drivers/firmware/qcom/Kconfig                                 |   11 
 drivers/firmware/qcom/qcom_scm.c                              |   77 ++++-
 drivers/firmware/smccc/smccc.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                      |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                   |   10 
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c                    |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c             |   15 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c            |    4 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                     |   49 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h                 |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c             |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c               |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c       |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c              |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c               |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c          |   20 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c          |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c          |   74 -----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                        |    8 
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h                        |    2 
 drivers/gpu/drm/imagination/pvr_context.c                     |   33 ++
 drivers/gpu/drm/imagination/pvr_context.h                     |   21 +
 drivers/gpu/drm/imagination/pvr_device.h                      |   10 
 drivers/gpu/drm/imagination/pvr_drv.c                         |    3 
 drivers/gpu/drm/imagination/pvr_vm.c                          |   22 +
 drivers/gpu/drm/imagination/pvr_vm.h                          |    1 
 drivers/gpu/drm/panthor/panthor_device.c                      |    4 
 drivers/gpu/drm/panthor/panthor_mmu.c                         |    2 
 drivers/gpu/drm/xe/regs/xe_gt_regs.h                          |    2 
 drivers/gpu/drm/xe/xe_device.h                                |   14 
 drivers/gpu/drm/xe/xe_exec.c                                  |   13 
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c                           |    6 
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c                   |    2 
 drivers/gpu/drm/xe/xe_guc_ct.c                                |    9 
 drivers/gpu/drm/xe/xe_wait_user_fence.c                       |    7 
 drivers/hid/hid-core.c                                        |    2 
 drivers/i2c/busses/i2c-designware-common.c                    |    6 
 drivers/i2c/busses/i2c-designware-core.h                      |    1 
 drivers/irqchip/irq-gic-v3.c                                  |    7 
 drivers/md/dm-cache-target.c                                  |   59 ++--
 drivers/md/dm-unstripe.c                                      |    4 
 drivers/md/dm.c                                               |    4 
 drivers/media/cec/usb/pulse8/pulse8-cec.c                     |    2 
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c                 |    3 
 drivers/media/dvb-core/dvb_frontend.c                         |    4 
 drivers/media/dvb-core/dvb_vb2.c                              |    8 
 drivers/media/dvb-core/dvbdev.c                               |   17 +
 drivers/media/dvb-frontends/cx24116.c                         |    7 
 drivers/media/dvb-frontends/stb0899_algo.c                    |    2 
 drivers/media/i2c/adv7604.c                                   |   26 +
 drivers/media/i2c/ar0521.c                                    |    4 
 drivers/media/pci/mgb4/mgb4_cmt.c                             |    2 
 drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c           |   17 -
 drivers/media/test-drivers/vivid/vivid-core.c                 |    2 
 drivers/media/test-drivers/vivid/vivid-core.h                 |    4 
 drivers/media/test-drivers/vivid/vivid-ctrls.c                |    2 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c              |    2 
 drivers/media/usb/uvc/uvc_driver.c                            |    2 
 drivers/media/v4l2-core/v4l2-ctrls-api.c                      |   17 -
 drivers/net/can/c_can/c_can_main.c                            |    7 
 drivers/net/can/cc770/Kconfig                                 |    2 
 drivers/net/can/m_can/m_can.c                                 |    3 
 drivers/net/can/sja1000/Kconfig                               |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c                |    8 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c                 |   10 
 drivers/net/ethernet/arc/emac_main.c                          |   27 +
 drivers/net/ethernet/arc/emac_mdio.c                          |    9 
 drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h          |    2 
 drivers/net/ethernet/freescale/enetc/enetc_pf.c               |   18 -
 drivers/net/ethernet/freescale/enetc/enetc_vf.c               |    9 
 drivers/net/ethernet/hisilicon/hns3/hnae3.c                   |    5 
 drivers/net/ethernet/intel/e1000e/ich8lan.c                   |   17 -
 drivers/net/ethernet/intel/i40e/i40e.h                        |    1 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c                |    1 
 drivers/net/ethernet/intel/i40e/i40e_main.c                   |   12 
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c             |    3 
 drivers/net/ethernet/intel/ice/ice_fdir.h                     |    4 
 drivers/net/ethernet/intel/idpf/idpf.h                        |    4 
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c                |   11 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                    |    5 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c               |    3 
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c           |    1 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c             |    1 
 drivers/net/ethernet/vertexcom/mse102x.c                      |    5 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c             |    4 
 drivers/net/phy/dp83848.c                                     |    2 
 drivers/net/virtio_net.c                                      |  119 ++++++--
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c                    |    2 
 drivers/platform/x86/amd/pmc/pmc.c                            |    5 
 drivers/platform/x86/amd/pmf/core.c                           |   21 -
 drivers/platform/x86/amd/pmf/pmf.h                            |   55 +++
 drivers/platform/x86/amd/pmf/spc.c                            |   52 ++-
 drivers/pwm/pwm-imx-tpm.c                                     |    4 
 drivers/regulator/rtq2208-regulator.c                         |    2 
 drivers/rpmsg/qcom_glink_native.c                             |   10 
 drivers/scsi/sd_zbc.c                                         |    3 
 drivers/soc/qcom/llcc-qcom.c                                  |    3 
 drivers/staging/media/av7110/av7110.h                         |    4 
 drivers/staging/media/av7110/av7110_ca.c                      |   25 +
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c |    6 
 drivers/thermal/qcom/lmh.c                                    |    7 
 drivers/thermal/thermal_of.c                                  |   21 -
 drivers/thunderbolt/retimer.c                                 |    2 
 drivers/thunderbolt/usb4.c                                    |    2 
 drivers/ufs/core/ufshcd.c                                     |   10 
 drivers/usb/dwc3/core.c                                       |   25 -
 drivers/usb/musb/sunxi.c                                      |    2 
 drivers/usb/serial/io_edgeport.c                              |    8 
 drivers/usb/serial/option.c                                   |    6 
 drivers/usb/serial/qcserial.c                                 |    2 
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c           |    8 
 drivers/usb/typec/ucsi/ucsi_ccg.c                             |    2 
 fs/btrfs/bio.c                                                |   30 +-
 fs/btrfs/delayed-ref.c                                        |    2 
 fs/btrfs/inode.c                                              |    2 
 fs/btrfs/super.c                                              |   25 -
 fs/nfs/inode.c                                                |   70 +++-
 fs/nfs/nfs4proc.c                                             |    4 
 fs/nfs/super.c                                                |   10 
 fs/ocfs2/xattr.c                                              |    3 
 fs/proc/vmcore.c                                              |    9 
 fs/smb/server/connection.c                                    |    1 
 fs/smb/server/connection.h                                    |    1 
 fs/smb/server/mgmt/user_session.c                             |   15 -
 fs/smb/server/server.c                                        |   20 -
 fs/smb/server/smb_common.c                                    |   10 
 fs/smb/server/smb_common.h                                    |    2 
 fs/tracefs/inode.c                                            |   12 
 include/linux/arm-smccc.h                                     |   32 --
 include/linux/bio.h                                           |    4 
 include/linux/soc/qcom/llcc-qcom.h                            |    2 
 include/linux/user_namespace.h                                |    3 
 include/net/netfilter/nf_tables.h                             |    4 
 include/trace/events/rxrpc.h                                  |    1 
 kernel/signal.c                                               |    3 
 kernel/ucount.c                                               |    9 
 lib/objpool.c                                                 |   18 -
 mm/damon/core.c                                               |   42 +-
 mm/filemap.c                                                  |    2 
 mm/huge_memory.c                                              |   35 +-
 mm/internal.h                                                 |   10 
 mm/memcontrol-v1.c                                            |   25 +
 mm/memcontrol.c                                               |    8 
 mm/migrate.c                                                  |    4 
 mm/mlock.c                                                    |    9 
 mm/page_alloc.c                                               |    1 
 mm/slab_common.c                                              |   31 +-
 mm/swap.c                                                     |    4 
 mm/vmscan.c                                                   |    4 
 net/mptcp/mptcp_pm_gen.c                                      |    1 
 net/mptcp/pm_userspace.c                                      |    3 
 net/netfilter/nf_tables_api.c                                 |   41 ++
 net/rxrpc/conn_client.c                                       |    4 
 net/sctp/sm_statefuns.c                                       |    2 
 net/smc/af_smc.c                                              |    4 
 net/sunrpc/xprtsock.c                                         |    1 
 net/vmw_vsock/hyperv_transport.c                              |    1 
 net/vmw_vsock/virtio_transport_common.c                       |    1 
 security/keys/keyring.c                                       |    7 
 security/keys/trusted-keys/trusted_dcp.c                      |    9 
 sound/firewire/tascam/amdtp-tascam.c                          |    2 
 sound/pci/hda/patch_conexant.c                                |    2 
 sound/soc/amd/yc/acp6x-mach.c                                 |    7 
 sound/soc/sof/sof-client-probes-ipc4.c                        |    1 
 sound/soc/stm/stm32_spdifrx.c                                 |    2 
 sound/usb/mixer.c                                             |    1 
 sound/usb/quirks.c                                            |    2 
 tools/lib/thermal/sampling.c                                  |    2 
 tools/testing/selftests/mm/hugetlb_dio.c                      |   19 -
 218 files changed, 1514 insertions(+), 861 deletions(-)

Abel Vesa (1):
      clk: qcom: gcc-x1e80100: Fix USB MP SS1 PHY GDSC pwrsts flags

Aleksandr Loktionov (1):
      i40e: fix race condition by adding filter's intermediate sync state

Alex Deucher (3):
      drm/amdgpu: Adjust debugfs eviction and IB access permissions
      drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()
      drm/amdgpu: Adjust debugfs register access permissions

Alexander Stein (1):
      arm64: dts: imx8-ss-vpu: Fix imx8qm VPU IRQs

Amelie Delaunay (1):
      ASoC: stm32: spdifrx: fix dma channel release in stm32_spdifrx_remove

Andrei Vagin (1):
      ucounts: fix counter leak in inc_rlimit_get_ucounts()

Andrew Kanner (1):
      ocfs2: remove entry once instead of null-ptr-dereference in ocfs2_xa_remove()

Antonio Quartulli (1):
      drm/amdgpu: prevent NULL pointer dereference if ATIF is not supported

Aurabindo Pillai (1):
      drm/amd/display: parse umc_info or vram_info based on ASIC

Badal Nilawar (1):
      drm/xe/guc/ct: Flush g2h worker in case of g2h response timeout

Balasubramani Vivekanandan (1):
      drm/xe: Set mask bits for CCS_MODE register

Barnabás Czémán (1):
      clk: qcom: clk-alpha-pll: Fix pll post div mask when width is not set

Bart Van Assche (1):
      scsi: ufs: core: Start the RTC update work later

Bartosz Golaszewski (1):
      firmware: qcom: scm: fix a NULL-pointer dereference

Benoit Sevens (1):
      media: uvcvideo: Skip parsing frames of type UVC_VS_UNDEFINED in uvc_parse_format

Benoît Monin (1):
      USB: serial: option: add Quectel RG650V

Bjorn Andersson (1):
      rpmsg: glink: Handle rejected intent request better

Brendan King (2):
      drm/imagination: Add a per-file PVR context list
      drm/imagination: Break an object reference loop

Chen Ridong (1):
      security/keys: fix slab-out-of-bounds in key_task_permission

ChiYuan Huang (1):
      regulator: rtq2208: Fix uninitialized use of regulator_config

Christoph Hellwig (2):
      block: rework bio splitting
      block: fix queue limits checks in blk_rq_map_user_bvec for real

Corey Hickey (1):
      platform/x86/amd/pmc: Detect when STB is not available

Dan Carpenter (2):
      usb: typec: fix potential out of bounds in ucsi_ccg_update_set_new_cam_cmd()
      USB: serial: io_edgeport: fix use after free in debug printk

Dario Binacchi (1):
      can: c_can: fix {rx,tx}_errors statistics

David Gstir (1):
      KEYS: trusted: dcp: fix NULL dereference in AEAD crypto operation

David Howells (1):
      rxrpc: Fix missing locking causing hanging calls

Diederik de Haas (4):
      arm64: dts: rockchip: Remove hdmi's 2nd interrupt on rk3328
      arm64: dts: rockchip: Fix wakeup prop names on PineNote BT node
      arm64: dts: rockchip: Fix reset-gpios property on brcm BT nodes
      arm64: dts: rockchip: Correct GPIO polarity on brcm BT nodes

Diogo Silva (1):
      net: phy: ti: add PHY_RST_AFTER_CLK_EN flag

Dmitry Baryshkov (2):
      arm64: dts: qcom: sm8450 fix PIPE clock specification for pcie1
      thermal/drivers/qcom/lmh: Remove false lockdep backtrace

Dragan Simic (2):
      arm64: dts: rockchip: Move L3 cache outside CPUs in RK3588(S) SoC dtsi
      arm64: dts: rockchip: Start cooling maps numbering from zero on ROCK 5B

Emil Dahl Juhl (1):
      tools/lib/thermal: Fix sampling handler context ptr

Eric Dumazet (1):
      net/smc: do not leave a dangling sk pointer in __smc_create()

Erik Schumacher (1):
      pwm: imx-tpm: Use correct MODULO value for EPWM mode

Filipe Manana (1):
      btrfs: reinitialize delayed ref list after deleting it from the list

Gautam Menghani (1):
      KVM: PPC: Book3S HV: Mask off LPCR_MER for a vCPU before running it to avoid spurious interrupts

Geert Uytterhoeven (2):
      arm64: dts: rockchip: Fix rt5651 compatible value on rk3399-eaidk-610
      arm64: dts: rockchip: Fix rt5651 compatible value on rk3399-sapphire-excavator

Geliang Tang (1):
      mptcp: use sock_kfree_s instead of kfree

Greg Kroah-Hartman (1):
      Linux 6.11.8

Haisu Wang (1):
      btrfs: fix the length of reserved qgroup to free

Hans Verkuil (2):
      media: dvb-core: add missing buffer index check
      media: vivid: fix buffer overwrite when using > 32 buffers

Heiko Stuebner (13):
      arm64: dts: rockchip: fix i2c2 pinctrl-names property on anbernic-rg353p/v
      arm64: dts: rockchip: Drop regulator-init-microvolt from two boards
      arm64: dts: rockchip: Fix bluetooth properties on rk3566 box demo
      arm64: dts: rockchip: Fix bluetooth properties on Rock960 boards
      arm64: dts: rockchip: Remove undocumented supports-emmc property
      arm64: dts: rockchip: Remove #cooling-cells from fan on Theobroma lion
      arm64: dts: rockchip: Fix LED triggers on rk3308-roc-cc
      arm64: dts: rockchip: remove num-slots property from rk3328-nanopi-r2s-plus
      arm64: dts: rockchip: remove orphaned pinctrl-names from pinephone pro
      ARM: dts: rockchip: fix rk3036 acodec node
      ARM: dts: rockchip: drop grf reference from rk3036 hdmi
      ARM: dts: rockchip: Fix the spi controller on rk3036
      ARM: dts: rockchip: Fix the realtek audio codec on rk3036-kylin

Hugh Dickins (1):
      mm/thp: fix deferred split unqueue naming and locking

Hyunwoo Kim (2):
      hv_sock: Initializing vsk->trans to NULL to prevent a dangling pointer
      vsock/virtio: Initialization of the dangling pointer occurring in vsk->trans

Icenowy Zheng (1):
      thermal/of: support thermal zones w/o trips subnode

Jack Wu (1):
      USB: serial: qcserial: add support for Sierra Wireless EM86xx

Jann Horn (1):
      drm/panthor: Be stricter about IO mapping flags

Jarkko Sakkinen (1):
      tpm: Lock TPM chip in tpm_pm_suspend() first

Jarosław Janik (1):
      Revert "ALSA: hda/conexant: Mute speakers at suspend / shutdown"

Jinjie Ruan (2):
      ksmbd: Fix the missing xa_store error check
      net: wwan: t7xx: Fix off-by-one error in t7xx_dpmaif_rx_buf_alloc()

Jiri Kosina (1):
      HID: core: zero-initialize the report buffer

Johan Hovold (2):
      clk: qcom: videocc-sm8350: use HW_CTRL_TRIGGER for vcodec GDSCs
      firmware: qcom: scm: suppress download mode error

Johan Jonker (2):
      net: arc: fix the device for dma_map_single/dma_unmap_single
      net: arc: rockchip: fix emac mdio node support

Johannes Thumshirn (1):
      scsi: sd_zbc: Use kvzalloc() to allocate REPORT ZONES buffer

Jyri Sarha (1):
      ASoC: SOF: sof-client-probes-ipc4: Set param_size extension bits

Kalesh Singh (1):
      tracing: Fix tracefs mount options

Kenneth Feng (2):
      drm/amd/pm: always pick the pptable from IFWI
      drm/amd/pm: correct the workload setting

Koichiro Den (1):
      mm/slab: fix warning caused by duplicate kmem_cache creation in kmem_buckets_create

Lijo Lazar (1):
      drm/amdgpu: Fix DPX valid mode check on GC 9.4.3

Liu Peibao (1):
      i2c: designware: do not hold SCL low when I2C_DYNAMIC_TAR_UPDATE is not set

Liviu Dudau (1):
      drm/panthor: Lock XArray when getting entries for the VM

Marc Kleine-Budde (3):
      can: m_can: m_can_close(): don't call free_irq() for IRQ-less devices
      can: mcp251xfd: mcp251xfd_get_tef_len(): fix length calculation
      can: mcp251xfd: mcp251xfd_ring_alloc(): fix coalescing configuration when switching CAN modes

Marc Zyngier (1):
      irqchip/gic-v3: Force propagation of the active state with a read-back

Marek Vasut (1):
      arm64: dts: imx8mp-phyboard-pollux: Set Video PLL1 frequency to 506.8 MHz

Mark Brown (1):
      arm64/sve: Discard stale CPU state when handling SVE traps

Mark Rutland (2):
      arm64: Kconfig: Make SME depend on BROKEN for now
      arm64: smccc: Remove broken support for SMCCCv1.3 SVE discard hint

Masami Hiramatsu (Google) (1):
      objpool: fix to make percpu slot allocation more robust

Mateusz Polchlopek (1):
      ice: change q_index variable type to s16 to store -1 value

Matthew Brost (2):
      drm/xe: Fix possible exec queue leak in exec IOCTL
      drm/xe: Drop VM dma-resv lock on xe_sync_in_fence_get failure in exec IOCTL

Matthieu Baerts (NGI0) (1):
      mptcp: no admin perm to list endpoints

Mauro Carvalho Chehab (12):
      media: stb0899_algo: initialize cfr before using it
      media: dvbdev: prevent the risk of out of memory access
      media: dvb_frontend: don't play tricks with underflow values
      media: adv7604: prevent underflow condition when reporting colorspace
      media: mgb4: protect driver against spectre
      media: ar0521: don't overflow when checking PLL values
      media: s5p-jpeg: prevent buffer overflows
      media: cx24116: prevent overflows on SNR calculus
      media: av7110: fix a spectre vulnerability
      media: pulse8-cec: fix data timestamp at pulse8_setup()
      media: v4l2-tpg: prevent the risk of a division by zero
      media: v4l2-ctrls-api: fix error handling for v4l2_g_ctrl()

Mika Westerberg (2):
      thunderbolt: Add only on-board retimers when !CONFIG_USB4_DEBUGFS_MARGINING
      thunderbolt: Fix connection issue with Pluggable UD-4VPD dock

Mike Snitzer (1):
      nfs: avoid i_lock contention in nfs_clear_invalid_mapping

Mikulas Patocka (1):
      dm: fix a crash if blk_alloc_disk fails

Ming-Hung Tsai (5):
      dm cache: correct the number of origin blocks to match the target length
      dm cache: fix flushing uninitialized delayed_work on cache_ctr error
      dm cache: fix out-of-bounds access to the dirty bitset when resizing
      dm cache: optimize dirty bit checking with find_next_bit when resizing
      dm cache: fix potential out-of-bounds access on the first resume

Mingcong Bai (1):
      ASoC: amd: yc: fix internal mic on Xiaomi Book Pro 14 2022

Muhammad Usama Anjum (1):
      selftests: hugetlb_dio: check for initial conditions to skip in the start

Mukesh Ojha (1):
      firmware: qcom: scm: Refactor code to support multiple dload mode

Murad Masimov (1):
      ALSA: firewire-lib: fix return value on fail in amdtp_tscm_init()

Namjae Jeon (3):
      ksmbd: fix slab-use-after-free in ksmbd_smb2_session_create
      ksmbd: check outstanding simultaneous SMB operations
      ksmbd: fix slab-use-after-free in smb3_preauth_hash_rsp

NeilBrown (2):
      sunrpc: handle -ENOTCONN in xs_tcp_setup_socket()
      NFSv3: only use NFS timeout for MOUNT when protocols are compatible

Nirmoy Das (3):
      drm/xe: Move LNL scheduling WA to xe_device.h
      drm/xe/ufence: Flush xe ordered_wq in case of ufence timeout
      drm/xe/guc/tlb: Flush g2h worker in case of tlb timeout

Nícolas F. R. A. Prado (1):
      net: stmmac: Fix unbalanced IRQ wake disable warning on single irq case

Pablo Neira Ayuso (1):
      netfilter: nf_tables: wait for rcu grace period on net_device removal

Paul E. McKenney (1):
      xtensa: Emulate one-byte cmpxchg

Pavan Kumar Linga (2):
      idpf: avoid vport access in idpf_get_link_ksettings
      idpf: fix idpf_vc_core_init error path

Peiyang Wang (1):
      net: hns3: fix kernel crash when uninstalling driver

Peng Fan (1):
      arm64: dts: imx8mp: correct sdhc ipg clk

Philo Lu (4):
      virtio_net: Support dynamic rss indirection table size
      virtio_net: Add hash_key_length check
      virtio_net: Sync rss config to device when virtnet_probe
      virtio_net: Update rss when set queue

Qi Xi (1):
      fs/proc: fix compile warning about variable 'vmcore_mmap_ops'

Qiang Yu (1):
      clk: qcom: gcc-x1e80100: Fix halt_check for pipediv2 clocks

Qingqing Zhou (1):
      firmware: qcom: scm: Return -EOPNOTSUPP for unsupported SHM bridge enabling

Qu Wenruo (1):
      btrfs: fix per-subvolume RO/RW flags with new mount API

Rajendra Nayak (1):
      EDAC/qcom: Make irq configuration optional

Reinhard Speyerer (1):
      USB: serial: option: add Fibocom FG132 0x0112 composition

Rex Nie (1):
      usb: typec: qcom-pmic: init value of hdr_len/txbuf_len earlier

Roberto Sassu (1):
      nfs: Fix KMSAN warning in decode_getfattr_attrs()

Roger Quadros (1):
      usb: dwc3: fix fault at system suspend if device was already runtime suspended

Roman Gushchin (1):
      signal: restore the override_rlimit logic

Sam Edwards (1):
      arm64: dts: rockchip: Designate Turing RK1's system power controller

SeongJae Park (3):
      mm/damon/core: avoid overflow in damon_feed_loop_next_input()
      mm/damon/core: handle zero {aggregation,ops_update} intervals
      mm/damon/core: handle zero schemes apply interval

Sergey Bostandzhyan (1):
      arm64: dts: rockchip: Add DTS for FriendlyARM NanoPi R2S Plus

Shyam Sundar S K (3):
      platform/x86/amd/pmf: Relocate CPU ID macros to the PMF header
      platform/x86/amd/pmf: Update SMU metrics table for 1AH family series
      platform/x86/amd/pmf: Add SMU metrics table support for 1Ah family 60h model

Stefan Wahren (1):
      net: vertexcom: mse102x: Fix possible double free of TX skb

Suraj Gupta (2):
      dt-bindings: net: xlnx,axi-ethernet: Correct phy-mode property value
      net: xilinx: axienet: Enqueue Tx packets in dql before dmaengine starts

Takashi Iwai (1):
      ALSA: usb-audio: Add quirk for HP 320 FHD Webcam

Thomas Mühlbacher (1):
      can: {cc770,sja1000}_isa: allow building on x86_64

Tom Chung (1):
      drm/amd/display: Fix brightness level not retained over reboot

Trond Myklebust (3):
      NFS: Fix attribute delegation behaviour on exclusive create
      NFS: Further fixes to attribute delegation a/mtime changes
      filemap: Fix bounds checking in filemap_read()

Umang Jain (2):
      staging: vchiq_arm: Use devm_kzalloc() for drv_mgmt allocation
      staging: vchiq_arm: Use devm_kzalloc() for vchiq_arm_state allocation

Vitaly Lifshits (1):
      e1000e: Remove Meteor Lake SMBUS workarounds

Vladimir Oltean (1):
      net: dpaa_eth: print FD status in CPU endianness in dpaa_eth_fd tracepoint

Wei Fang (2):
      net: enetc: set MAC address to the VF net_device
      net: enetc: allocate vf_state during PF probes

Wei Yang (1):
      mm/mlock: set the correct prev on failure

Wentao Liang (1):
      drivers: net: ionic: add missed debugfs cleanup to ionic_probe() error path

Xin Long (1):
      sctp: properly validate chunk size in sctp_sf_ootb()

Xinqi Zhang (1):
      firmware: arm_scmi: Fix slab-use-after-free in scmi_bus_notifier()

Zichen Xie (1):
      dm-unstriped: cast an operand to sector_t to prevent potential uint32_t overflow

Zijun Hu (1):
      usb: musb: sunxi: Fix accessing an released usb phy


