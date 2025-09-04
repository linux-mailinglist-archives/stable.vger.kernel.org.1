Return-Path: <stable+bounces-177757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC25B44026
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 17:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C650A0824C
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2A930DD3A;
	Thu,  4 Sep 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZU4QnYo5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D2830DEC9;
	Thu,  4 Sep 2025 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998681; cv=none; b=p9TvBIPalmddakF0zpQhAxInqwy0D5TjPQnLJvMQgcd4pRBMxaCzuqoiuBXqKE5yj7/I0cCnGOwNuNHiy7RZZCFbE0OcF5GjYGlRO9HrferpFj2inlZf11gPfkUiuagkCBd4i+r3b4RIcqelx68zEshKXFBgZweCt0HKbaNwmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998681; c=relaxed/simple;
	bh=NROqv7V5gtdLA+t6WTC/g2hCwEWa8VFwp0Mp/qvpiQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g1n/HJGsuJ7tdGxX/ppUlSHSBQQDzoopeiUumUAUhMFoO7g3m54LdEYXE9l+8c/UMQmh+AAgcaXUMC4YireQIbf790gGOhPTth2Li+QcoLP94CZeI6sSnH3gPb4a6kgUFiA1ZNcZBze/mTTFHxIY1wf3LmkoyZzmUaERb7YiNJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZU4QnYo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55679C4CEF0;
	Thu,  4 Sep 2025 15:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756998679;
	bh=NROqv7V5gtdLA+t6WTC/g2hCwEWa8VFwp0Mp/qvpiQY=;
	h=From:To:Cc:Subject:Date:From;
	b=ZU4QnYo5JpMNmPMO810qrMb6lEgpDHQWhJ7NHuQR6ZN/7IJfTIQCL0GQDALGgYZW0
	 GS4fK/TwwyyNVL0m+yvhj0Cr6ETTr+2H0+2CFCnIWBC1a5IVT9/vQ7dlfC69TaioQO
	 4XN6KBBmaEvCz7Sjc2TCXWbmpEG6dShRdGgX3Fkg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.16.5
Date: Thu,  4 Sep 2025 17:10:56 +0200
Message-ID: <2025090457-unsubtle-pulverize-1855@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.16.5 kernel.

All users of the 6.16 kernel series must upgrade.

The updated 6.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.16.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml   |    1 
 Makefile                                                       |    2 
 arch/arm64/include/asm/mmu.h                                   |    7 
 arch/arm64/kernel/cpufeature.c                                 |    5 
 arch/arm64/mm/mmu.c                                            |    7 
 arch/mips/boot/dts/lantiq/danube_easy50712.dts                 |    5 
 arch/mips/lantiq/xway/sysctrl.c                                |   10 
 arch/powerpc/kernel/kvm.c                                      |    8 
 arch/riscv/kvm/vcpu_vector.c                                   |    2 
 arch/x86/kernel/cpu/intel.c                                    |    2 
 arch/x86/kernel/cpu/microcode/amd.c                            |   22 
 arch/x86/kernel/cpu/topology_amd.c                             |   23 
 arch/x86/kvm/lapic.c                                           |    2 
 arch/x86/kvm/x86.c                                             |    7 
 block/blk-rq-qos.h                                             |   13 
 block/blk-zoned.c                                              |   11 
 drivers/atm/atmtcp.c                                           |   17 
 drivers/crypto/marvell/octeontx2/otx2_cpt_common.h             |    5 
 drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c             |   13 
 drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c            |    4 
 drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c             |    6 
 drivers/firmware/efi/stmm/tee_stmm_efi.c                       |   21 
 drivers/firmware/qcom/qcom_scm.c                               |   95 +-
 drivers/firmware/qcom/qcom_scm.h                               |    1 
 drivers/firmware/qcom/qcom_tzmem.c                             |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c                        |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c                      |    1 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                         |   14 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                         |    8 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                             |   18 
 drivers/gpu/drm/display/drm_dp_helper.c                        |    2 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                         |   21 
 drivers/gpu/drm/mediatek/mtk_hdmi.c                            |    8 
 drivers/gpu/drm/mediatek/mtk_plane.c                           |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                    |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c                      |    4 
 drivers/gpu/drm/msm/msm_gem_submit.c                           |   14 
 drivers/gpu/drm/msm/msm_kms.c                                  |   10 
 drivers/gpu/drm/msm/registers/display/dsi.xml                  |   28 
 drivers/gpu/drm/nouveau/dispnv50/wndw.c                        |    4 
 drivers/gpu/drm/nouveau/nvkm/falcon/gm200.c                    |   15 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c                |    5 
 drivers/gpu/drm/xe/xe_bo.c                                     |    8 
 drivers/gpu/drm/xe/xe_sync.c                                   |    2 
 drivers/gpu/drm/xe/xe_vm.c                                     |    8 
 drivers/gpu/drm/xe/xe_vm.h                                     |   15 
 drivers/hid/hid-asus.c                                         |    8 
 drivers/hid/hid-elecom.c                                       |    2 
 drivers/hid/hid-ids.h                                          |    4 
 drivers/hid/hid-input-test.c                                   |   10 
 drivers/hid/hid-input.c                                        |   51 -
 drivers/hid/hid-logitech-dj.c                                  |    4 
 drivers/hid/hid-logitech-hidpp.c                               |    2 
 drivers/hid/hid-multitouch.c                                   |    8 
 drivers/hid/hid-ntrig.c                                        |    3 
 drivers/hid/hid-quirks.c                                       |    3 
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c        |    1 
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h        |    2 
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c            |    4 
 drivers/hid/wacom_wac.c                                        |    1 
 drivers/isdn/hardware/mISDN/hfcpci.c                           |   12 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                      |   36 
 drivers/net/ethernet/cadence/macb_main.c                       |   11 
 drivers/net/ethernet/dlink/dl2k.c                              |    2 
 drivers/net/ethernet/intel/ice/ice.h                           |    1 
 drivers/net/ethernet/intel/ice/ice_adapter.c                   |   49 -
 drivers/net/ethernet/intel/ice/ice_adapter.h                   |    4 
 drivers/net/ethernet/intel/ice/ice_ddp.c                       |   44 -
 drivers/net/ethernet/intel/ice/ice_idc.c                       |   10 
 drivers/net/ethernet/intel/ice/ice_main.c                      |   16 
 drivers/net/ethernet/intel/ice/ice_txrx.c                      |    2 
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c            |   61 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                    |  403 +++++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                    |   38 
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c                  |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h             |    2 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                |    7 
 drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c         |    6 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                |   30 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                |   66 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c            |   68 -
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c          |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c            |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c        |   22 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c            |   54 -
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c            |    8 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c       |   16 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h       |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c            |   13 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c            |   10 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c         |    8 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c       |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h       |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c       |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h       |   12 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c           |   24 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h          |   30 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c           |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c           |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c               |   20 
 drivers/net/ethernet/marvell/octeontx2/nic/rep.h               |    1 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c              |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c       |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h       |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c              |   19 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c              |   15 
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c             |  126 +--
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h             |    1 
 drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c           |   10 
 drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h                |    6 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c  |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c |    6 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c    |    1 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c                 |    4 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c                    |    2 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c            |   13 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c             |    9 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c              |    6 
 drivers/net/hyperv/netvsc.c                                    |   17 
 drivers/net/hyperv/rndis_filter.c                              |   23 
 drivers/net/phy/mscc/mscc.h                                    |    4 
 drivers/net/phy/mscc/mscc_main.c                               |    4 
 drivers/net/phy/mscc/mscc_ptp.c                                |   34 
 drivers/net/usb/qmi_wwan.c                                     |    3 
 drivers/of/dynamic.c                                           |    9 
 drivers/of/of_reserved_mem.c                                   |   17 
 drivers/pinctrl/Kconfig                                        |    1 
 drivers/pinctrl/mediatek/pinctrl-airoha.c                      |    8 
 drivers/platform/x86/intel/int3472/discrete.c                  |    6 
 drivers/scsi/scsi_sysfs.c                                      |    4 
 drivers/thermal/mediatek/lvts_thermal.c                        |   74 +
 drivers/vhost/net.c                                            |    9 
 fs/efivarfs/super.c                                            |    4 
 fs/erofs/super.c                                               |   24 
 fs/erofs/zdata.c                                               |   13 
 fs/smb/client/cifsfs.c                                         |   14 
 fs/smb/client/inode.c                                          |   34 
 fs/smb/client/smb2inode.c                                      |    7 
 fs/xfs/libxfs/xfs_attr_remote.c                                |    7 
 fs/xfs/libxfs/xfs_da_btree.c                                   |    6 
 include/linux/atmdev.h                                         |    1 
 include/linux/dma-map-ops.h                                    |    3 
 include/linux/firmware/qcom/qcom_scm.h                         |    5 
 include/linux/platform_data/x86/int3472.h                      |    1 
 include/linux/soc/marvell/silicons.h                           |   25 
 include/linux/virtio_config.h                                  |    2 
 include/net/bluetooth/hci_sync.h                               |    2 
 include/net/rose.h                                             |   18 
 include/uapi/linux/vhost.h                                     |    4 
 io_uring/io-wq.c                                               |    8 
 io_uring/kbuf.c                                                |   20 
 kernel/dma/contiguous.c                                        |    2 
 kernel/dma/pool.c                                              |    4 
 kernel/events/core.c                                           |    6 
 kernel/trace/fgraph.c                                          |    1 
 kernel/trace/trace.c                                           |    4 
 kernel/trace/trace_functions_graph.c                           |   22 
 net/atm/common.c                                               |   15 
 net/bluetooth/hci_conn.c                                       |   58 +
 net/bluetooth/hci_event.c                                      |   25 
 net/bluetooth/hci_sync.c                                       |    6 
 net/bluetooth/mgmt.c                                           |    9 
 net/core/page_pool.c                                           |    6 
 net/ipv4/route.c                                               |   10 
 net/l2tp/l2tp_ppp.c                                            |   25 
 net/rose/af_rose.c                                             |   13 
 net/rose/rose_in.c                                             |   12 
 net/rose/rose_route.c                                          |   62 -
 net/rose/rose_timer.c                                          |    2 
 net/sctp/ipv6.c                                                |    2 
 sound/soc/codecs/lpass-tx-macro.c                              |    2 
 sound/soc/codecs/rt1320-sdw.c                                  |    3 
 sound/soc/codecs/rt721-sdca.c                                  |    2 
 sound/soc/codecs/rt721-sdca.h                                  |    4 
 tools/perf/util/symbol-minimal.c                               |   55 -
 tools/tracing/latency/Makefile.config                          |    8 
 tools/tracing/rtla/Makefile.config                             |    8 
 177 files changed, 1755 insertions(+), 977 deletions(-)

Aaron Ma (2):
      HID: intel-thc-hid: intel-quicki2c: Fix ACPI dsd ICRS/ISUB length
      HID: intel-thc-hid: intel-thc: Fix incorrect pointer arithmetic in I2C regs save

Aleksander Jan Bajkowski (2):
      mips: dts: lantiq: danube: add missing burst length property
      mips: lantiq: xway: sysctrl: rename the etop node

Alex Deucher (4):
      Revert "drm/amdgpu: fix incorrect vm flags to map bo"
      drm/amdgpu/userq: fix error handling of invalid doorbell
      drm/amdgpu/gfx11: set MQD as appriopriate for queue types
      drm/amdgpu/gfx12: set MQD as appriopriate for queue types

Alexander Duyck (1):
      fbnic: Move phylink resume out of service_task and into open/close

Alexei Lazar (3):
      net/mlx5e: Update and set Xon/Xoff upon MTU set
      net/mlx5e: Update and set Xon/Xoff upon port speed set
      net/mlx5e: Set local Xoff after FW update

Alexey Klimov (1):
      ASoC: codecs: tx-macro: correct tx_macro_component_drv name

Antheas Kapenekakis (1):
      HID: quirks: add support for Legion Go dual dinput modes

Ayushi Makhija (1):
      drm/msm: update the high bitfield of certain DSI registers

Bart Van Assche (1):
      blk-zoned: Fix a lockdep complaint about recursive locking

Bartosz Golaszewski (4):
      firmware: qcom: scm: remove unused arguments from SHM bridge routines
      firmware: qcom: scm: take struct device as argument in SHM bridge enable
      firmware: qcom: scm: initialize tzmem before marking SCM as available
      firmware: qcom: scm: request the waitqueue irq *after* initializing SCM

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Handle the case of no BIOS microcode

Chenyuan Yang (1):
      drm/msm/dpu: Add a null ptr check for dpu_encoder_needs_modeset

Damien Le Moal (1):
      scsi: core: sysfs: Correct sysfs attributes access rights

Dan Carpenter (1):
      of: dynamic: Fix use after free in of_changeset_add_prop_helper()

Dipayaan Roy (1):
      net: hv_netvsc: fix loss of early receive events from host during channel open.

Dmitry Baryshkov (3):
      drm/msm/kms: move snapshot init earlier in KMS init
      drm/msm/dpu: correct dpu_plane_virtual_atomic_check()
      dt-bindings: display/msm: qcom,mdp5: drop lut clock

Dongcheng Yan (1):
      platform/x86: int3472: add hpd pin support

Emil Tantilov (1):
      ice: fix NULL pointer dereference in ice_unplug_aux_dev() on reset

Eric Dumazet (3):
      sctp: initialize more fields in sctp_v6_from_sk()
      l2tp: do not use sock_hold() in pppol2tp_session_get_sock()
      net: rose: fix a typo in rose_clear_routes()

Eric Sandeen (1):
      xfs: do not propagate ENODATA disk errors into xattr code

Even Xu (1):
      HID: intel-thc-hid: Intel-quicki2c: Enhance driver re-install flow

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion LE910C4-WWX new compositions

Fengnan Chang (1):
      io_uring/io-wq: add check free worker before create new worker

Greg Kroah-Hartman (1):
      Linux 6.16.5

Hariprasad Kelam (2):
      Octeontx2-vf: Fix max packet length errors
      Octeontx2-af: Fix NIX X2P calibration failures

Horatiu Vultur (1):
      phy: mscc: Fix when PTP clock is register and unregister

Ian Rogers (1):
      perf symbol-minimal: Fix ehdr reading in filename__read_build_id

Igor Torrente (1):
      Revert "virtio: reject shm region if length is zero"

Imre Deak (1):
      Revert "drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS"

Jacob Keller (2):
      ice: don't leave device non-functional if Tx scheduler config fails
      ice: use fixed adapter index for E825C embedded devices

James Jones (1):
      drm/nouveau/disp: Always accept linear modifier

Jan Kiszka (1):
      efi: stmm: Fix incorrect buffer allocation method

Jason-JH Lin (1):
      drm/mediatek: Add error handling for old state CRTC in atomic_disable

Jedrzej Jagielski (1):
      ixgbe: fix ixgbe_orom_civd_info struct layout

Jens Axboe (1):
      io_uring/kbuf: always use READ_ONCE() to read ring provided buffer lengths

Jesse.Zhang (1):
      drm/amdgpu: update firmware version checks for user queue support

Joshua Hay (4):
      idpf: add support for Tx refillqs in flow scheduling mode
      idpf: simplify and fix splitq Tx packet rollback error path
      idpf: replace flow scheduling buffer ring with buffer pool
      idpf: stop Tx if there are insufficient buffer resources

José Expósito (2):
      HID: input: rename hidinput_set_battery_charge_status()
      HID: input: report battery status changes immediately

Junli Liu (1):
      erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC

K Prateek Nayak (1):
      x86/cpu/topology: Use initial APIC ID from XTOPOLOGY leaf on AMD/HYGON

Kees Cook (1):
      arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc function signature

Kuniyuki Iwashima (1):
      atm: atmtcp: Prevent arbitrary write in atmtcp_recv_control().

Lama Kayal (4):
      net/mlx5: HWS, Fix memory leak in hws_pool_buddy_init error path
      net/mlx5: HWS, Fix memory leak in hws_action_get_shared_stc_nic error flow
      net/mlx5: HWS, Fix uninitialized variables in mlx5hws_pat_calc_nop error flow
      net/mlx5: HWS, Fix pattern destruction in mlx5hws_pat_get_pattern error path

Li Nan (1):
      efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare

Lizhi Hou (1):
      of: dynamic: Fix memleak when of_pci_add_properties() failed

Lorenzo Bianconi (1):
      pinctrl: airoha: Fix return value in pinconf callbacks

Louis-Alexis Eyraud (1):
      drm/mediatek: mtk_hdmi: Fix inverted parameters in some regmap_update_bits calls

Ludovico de Nittis (2):
      Bluetooth: hci_event: Treat UNKNOWN_CONN_ID on disconnect as success
      Bluetooth: hci_event: Mark connection as closed during suspend disconnect

Luiz Augusto von Dentz (2):
      Bluetooth: hci_conn: Make unacked packet handling more robust
      Bluetooth: hci_event: Detect if HCI_EV_NUM_COMP_PKTS is unbalanced

Ma Ke (1):
      drm/mediatek: Fix device/node reference count leaks in mtk_drm_get_all_drm_priv

Madhavan Srinivasan (1):
      powerpc/kvm: Fix ifdef to remove build warning

Martin Hilgendorf (1):
      HID: elecom: add support for ELECOM M-DT2DRBK

Mason Chang (3):
      thermal/drivers/mediatek/lvts_thermal: Change lvts commands array to static const
      thermal/drivers/mediatek/lvts_thermal: Add lvts commands and their sizes to driver data
      thermal/drivers/mediatek/lvts_thermal: Add mt7988 lvts commands

Matt Coffin (1):
      HID: logitech: Add ids for G PRO 2 LIGHTSPEED

Matthew Brost (1):
      drm/xe: Don't trigger rebind on initial dma-buf validation

Michael Chan (2):
      bnxt_en: Adjust TX rings if reservation is less than requested
      bnxt_en: Fix stats context reservation logic

Michal Kubiak (1):
      ice: fix incorrect counter for buffer allocation failures

Mina Almasry (1):
      page_pool: fix incorrect mp_ops error handling

Minjong Kim (1):
      HID: hid-ntrig: fix unable to handle page fault in ntrig_report_version()

Moshe Shemesh (4):
      net/mlx5: Reload auxiliary drivers on fw_activate
      net/mlx5: Fix lockdep assertion on sync reset unload event
      net/mlx5: Nack sync reset when SFs are present
      net/mlx5: Prevent flow steering mode changes in switchdev mode

Namhyung Kim (1):
      vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER

Nathan Chancellor (1):
      drm/msm/dpu: Initialize crtc_state to NULL in dpu_plane_virtual_atomic_check()

Neil Mandir (1):
      net: macb: Disable clocks once

Nikolay Kuratov (1):
      vhost/net: Protect ubufs with rcu read lock in vhost_net_ubuf_put()

Nilay Shroff (1):
      block: validate QoS before calling __rq_qos_done_bio()

Oreoluwa Babatunde (1):
      of: reserved_mem: Restructure call site for dma_contiguous_early_fixup()

Oscar Maes (1):
      net: ipv4: fix regression in local-broadcast routes

Paulo Alcantara (2):
      smb: client: fix race with concurrent opens in unlink(2)
      smb: client: fix race with concurrent opens in rename(2)

Pavel Shpakovskiy (1):
      Bluetooth: hci_sync: fix set_local_name race condition

Ping Cheng (1):
      HID: wacom: Add a new Art Pen 2

Qasim Ijaz (2):
      HID: asus: fix UAF via HID_CLAIMED_INPUT validation
      HID: multitouch: fix slab out-of-bounds access in mt_report_fixup()

Qingyue Zhang (1):
      io_uring/kbuf: fix signedness in this_len calculation

Radim Krčmář (1):
      RISC-V: KVM: fix stack overrun when loading vlenb

Randy Dunlap (1):
      pinctrl: STMFX: add missing HAS_IOMEM dependency

Rob Clark (1):
      drm/msm: Defer fd_install in SUBMIT ioctl

Rob Herring (Arm) (1):
      of: reserved_mem: Add missing IORESOURCE_MEM flag on resources

Rohan G Thomas (3):
      net: stmmac: xgmac: Do not enable RX FIFO Overflow interrupts
      net: stmmac: xgmac: Correct supported speed modes
      net: stmmac: Set CIC bit only for TX queues with COE

Sean Anderson (1):
      net: macb: Fix offset error in gem_update_stats

Shanker Donthineni (1):
      dma/pool: Ensure DMA_DIRECT_REMAP allocations are decrypted

Shuhao Fu (1):
      fs/smb: Fix inconsistent refcnt update

Shuming Fan (2):
      ASoC: rt721: fix FU33 Boost Volume control not working
      ASoC: rt1320: fix random cycle mute issue

Sreekanth Reddy (1):
      bnxt_en: Fix memory corruption when FW resources change during ifdown

Steve French (1):
      smb3 client: fix return code mapping of remap_file_range

Steven Rostedt (1):
      fgraph: Copy args in intermediate storage with entry

Subbaraya Sundeep (1):
      octeontx2: Set appropriate PF, VF masks and shifts based on silicon

Suchit Karunakaran (1):
      x86/cpu/intel: Fix the constant_tsc model check for Pentium 4

Takamitsu Iwai (3):
      net: rose: split remove and free operations in rose_remove_neigh()
      net: rose: convert 'use' field to refcount_t
      net: rose: include node references in rose_neigh refcount

Tao Chen (2):
      tools/latency-collector: Check pkg-config install
      rtla: Check pkg-config install

Tengda Wu (1):
      ftrace: Fix potential warning in trace_printk_seq during ftrace_dump

Thijs Raymakers (1):
      KVM: x86: use array_index_nospec with indices that come from guest

Thomas Hellström (2):
      drm/xe/vm: Don't pin the vm_resv during validation
      drm/xe/vm: Clear the scratch_pt pointer on error

Timur Tabi (3):
      drm/nouveau: remove unused increment in gm200_flcn_pio_imem_wr
      drm/nouveau: remove unused memory target test
      drm/nouveau: fix error path in nvkm_gsp_fwsec_v2

Vladimir Riabchun (1):
      mISDN: hfcpci: Fix warning when deleting uninitialized timer

Yang Li (1):
      Bluetooth: hci_event: Disconnect device when BIG sync is lost

Yang Wang (1):
      drm/amd/amdgpu: disable hwmon power1_cap* for gfx 11.0.3 on vf mode

Ye Weihua (1):
      trace/fgraph: Fix the warning caused by missing unregister notifier

Yeounsu Moon (1):
      net: dlink: fix multicast stats being counted incorrectly

Yuezhang Mo (1):
      erofs: Fallback to normal access if DAX is not supported on extra device

Yunseong Kim (1):
      perf: Avoid undefined behavior from stopping/starting inactive events

Zbigniew Kempczyński (1):
      drm/xe/xe_sync: avoid race during ufence signaling

luoguangfei (1):
      net: macb: fix unregister_netdev call order in macb_remove()


