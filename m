Return-Path: <stable+bounces-73842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E638970538
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 08:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65781F21350
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 06:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EA967A0D;
	Sun,  8 Sep 2024 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sfQaALV+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FF561FCE;
	Sun,  8 Sep 2024 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725776029; cv=none; b=RzT4kyqcES8s7zaUVIqOpAEcFuT0+ZCh7mLTD/opXuJcdAtNiHbWqr4gR1qpNfmjWaZSndm8EXG6zkWfdTS9o5tS4wNXnb4ADfd0ZyFA67ubYfGvVP8zH3agVhrwofCCELXX9O59pvkmZtGd1lypJKfYA6CCglcnYkS3Q4O7P5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725776029; c=relaxed/simple;
	bh=K0X2t5PBxb/sUJHRFwhf7wBhoEvbVU/cPYAbbK+8pK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jBmaGiVYterDKs2/UYvPDfFQ4hThOE7Zg9AW0GQskqDcHH2VQkLkCHq7U37/sourkNxELCFOKdUngBLvRxy2FVesd0GZ5cUl7RAh36iCytTsjTkUZC/1elMmOMaawjpTMAqzuz9oCAdcH6oxZmsZlzmhvnn/Rf0eT1v10ZFD+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sfQaALV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C5BC4CEC3;
	Sun,  8 Sep 2024 06:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725776028;
	bh=K0X2t5PBxb/sUJHRFwhf7wBhoEvbVU/cPYAbbK+8pK0=;
	h=From:To:Cc:Subject:Date:From;
	b=sfQaALV+e14ZlCTMTr5BB9kPJaocTapn4ZJhjA1J4Cxe9UCi4pnr1iQafGpNxRyax
	 dgBIrbvzZVNvsuEz2VvvBwoGwymSq/iv1iW8eU3urGRWASkIa6Oy8a5vjUgLdCyZ/F
	 U/pQjLcJJgUpBlhpTWlewElHoDfMjfFaP2FEmlEI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.10.9
Date: Sun,  8 Sep 2024 08:13:31 +0200
Message-ID: <2024090831-shrunk-scarecrow-67ad@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.10.9 kernel.

All users of the 6.10 kernel series must upgrade.

The updated 6.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/locking/hwspinlock.rst                               |   11 
 Makefile                                                           |    2 
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts                          |   81 +++++
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                          |   81 +++++
 arch/x86/kernel/cpu/amd.c                                          |    2 
 block/blk-integrity.c                                              |    2 
 crypto/ecc.c                                                       |    2 
 drivers/base/regmap/regmap-spi.c                                   |    3 
 drivers/cpufreq/scmi-cpufreq.c                                     |    4 
 drivers/crypto/stm32/stm32-cryp.c                                  |    6 
 drivers/dma/altera-msgdma.c                                        |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c                           |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                   |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c                            |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                         |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c                         |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h                         |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c                           |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                            |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                            |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                            |   19 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h                            |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                           |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c                  |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                           |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                       |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c                           |    3 
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c                         |    6 
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c                           |    2 
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c                             |    3 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c                            |   19 -
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h                              |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c                             |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c                    |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c             |    9 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                          |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h                          |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                  |   49 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                  |    2 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c                  |   18 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                 |    7 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c          |    3 
 drivers/gpu/drm/amd/display/dc/core/dc.c                           |    1 
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c              |    3 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                  |    8 
 drivers/gpu/drm/amd/display/dc/core/dc_state.c                     |   10 
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c                  |    2 
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c                   |    3 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c               |    3 
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c                  |    2 
 drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c               |    7 
 drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c             |   10 
 drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c             |   10 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c               |   10 
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c             |   10 
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c              |    7 
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c                 |   17 -
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c                     |   17 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c          |    3 
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c            |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c            |    3 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c |   26 -
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c   |    4 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c          |    1 
 drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c     |    1 
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c     |    1 
 drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c   |    4 
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c     |    2 
 drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c   |    1 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c                  |    5 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c                |   28 +
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                   |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c                    |   13 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                |    5 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c               |   29 +
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c                |   15 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c              |   60 ++-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c              |   20 -
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c              |   31 +
 drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c            |    6 
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                       |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c                  |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c                    |   31 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c            |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c                   |   14 
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c                 |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                     |   55 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c               |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c               |   28 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c               |   28 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c               |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c               |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c               |   28 -
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c               |    5 
 drivers/gpu/drm/bridge/tc358767.c                                  |    2 
 drivers/gpu/drm/drm_bridge.c                                       |    5 
 drivers/gpu/drm/drm_fb_helper.c                                    |   11 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                     |    6 
 drivers/gpu/drm/meson/meson_plane.c                                |   17 -
 drivers/gpu/drm/xe/xe_force_wake.h                                 |   13 
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c                                |    4 
 drivers/gpu/drm/xe/xe_gt_topology.c                                |    4 
 drivers/gpu/drm/xe/xe_guc_relay.c                                  |    9 
 drivers/gpu/drm/xe/xe_guc_submit.c                                 |    5 
 drivers/gpu/drm/xe/xe_hwmon.c                                      |    9 
 drivers/gpu/drm/xe/xe_migrate.c                                    |   55 ++-
 drivers/gpu/drm/xe/xe_pcode.c                                      |    6 
 drivers/hwmon/k10temp.c                                            |   36 +-
 drivers/hwspinlock/hwspinlock_core.c                               |   28 +
 drivers/hwspinlock/hwspinlock_internal.h                           |    3 
 drivers/iio/industrialio-core.c                                    |    7 
 drivers/iio/industrialio-event.c                                   |    9 
 drivers/iio/inkern.c                                               |   32 +-
 drivers/infiniband/hw/efa/efa_com.c                                |   30 +
 drivers/media/usb/uvc/uvc_driver.c                                 |   18 -
 drivers/media/v4l2-core/v4l2-cci.c                                 |    9 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                    |    3 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c         |    2 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                    |    2 
 drivers/net/usb/qmi_wwan.c                                         |    1 
 drivers/net/virtio_net.c                                           |    6 
 drivers/net/wireless/ath/ath11k/qmi.c                              |    2 
 drivers/net/wireless/ath/ath12k/dp_rx.c                            |    2 
 drivers/net/wireless/ath/ath12k/qmi.c                              |    2 
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c                    |    3 
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h                    |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/link.c                      |   14 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                       |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c               |    1 
 drivers/net/wireless/realtek/rtw89/ser.c                           |    8 
 drivers/pci/controller/dwc/pcie-al.c                               |   16 -
 drivers/pinctrl/core.c                                             |    1 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                            |   12 
 drivers/platform/chrome/cros_ec_lpc_mec.c                          |   76 ++++
 drivers/platform/chrome/cros_ec_lpc_mec.h                          |   11 
 drivers/platform/x86/amd/pmf/core.c                                |    3 
 drivers/platform/x86/amd/pmf/pmf-quirks.c                          |    9 
 drivers/ras/amd/atl/dehash.c                                       |   43 --
 drivers/ras/amd/atl/map.c                                          |   77 ++++
 drivers/remoteproc/mtk_scp.c                                       |    2 
 drivers/remoteproc/qcom_q6v5_pas.c                                 |   11 
 drivers/soc/qcom/smem.c                                            |   26 +
 drivers/spi/spi-hisi-kunpeng.c                                     |    1 
 drivers/thermal/thermal_sysfs.c                                    |    6 
 drivers/thermal/thermal_trip.c                                     |    2 
 drivers/ufs/core/ufshcd.c                                          |   19 +
 drivers/usb/typec/ucsi/ucsi.h                                      |    2 
 drivers/usb/usbip/stub_rx.c                                        |   77 +++-
 fs/btrfs/inode.c                                                   |    3 
 fs/btrfs/scrub.c                                                   |   25 +
 fs/btrfs/tree-checker.c                                            |   47 ++
 fs/f2fs/f2fs.h                                                     |    2 
 fs/f2fs/inline.c                                                   |   20 +
 fs/f2fs/inode.c                                                    |    2 
 fs/gfs2/quota.c                                                    |   19 -
 fs/gfs2/util.c                                                     |    6 
 fs/notify/fsnotify.c                                               |   31 +
 fs/notify/fsnotify.h                                               |    2 
 fs/notify/mark.c                                                   |   32 +-
 fs/smb/client/smb2inode.c                                          |    6 
 include/clocksource/timer-xilinx.h                                 |    2 
 include/linux/fsnotify_backend.h                                   |    8 
 include/linux/hwspinlock.h                                         |    6 
 include/linux/i2c.h                                                |    2 
 include/linux/soc/qcom/smem.h                                      |    2 
 include/net/inet_timewait_sock.h                                   |    6 
 include/net/ip.h                                                   |    3 
 include/net/tcp.h                                                  |    2 
 include/sound/ump_convert.h                                        |    1 
 include/ufs/ufshcd.h                                               |    1 
 include/ufs/ufshci.h                                               |    1 
 kernel/dma/debug.c                                                 |    5 
 kernel/rcu/tree.h                                                  |    1 
 kernel/rcu/tree_nocb.h                                             |   32 --
 mm/filemap.c                                                       |    2 
 net/dccp/minisocks.c                                               |    3 
 net/ipv4/fib_semantics.c                                           |    5 
 net/ipv4/inet_timewait_sock.c                                      |   52 ++-
 net/ipv4/metrics.c                                                 |    8 
 net/ipv4/tcp_cong.c                                                |   11 
 net/ipv4/tcp_ipv4.c                                                |   14 
 net/ipv4/tcp_minisocks.c                                           |   25 -
 net/ipv6/route.c                                                   |    2 
 net/ipv6/tcp_ipv6.c                                                |    6 
 net/mac80211/main.c                                                |    3 
 net/wireless/ibss.c                                                |    5 
 net/wireless/mesh.c                                                |    5 
 net/wireless/nl80211.c                                             |   21 -
 net/wireless/scan.c                                                |   46 ++
 security/apparmor/apparmorfs.c                                     |    4 
 security/smack/smack_lsm.c                                         |    2 
 sound/core/seq/seq_ports.h                                         |   14 
 sound/core/seq/seq_ump_convert.c                                   |   95 +++--
 sound/core/ump_convert.c                                           |   60 ++-
 sound/pci/hda/hda_generic.c                                        |   63 +++
 sound/pci/hda/hda_generic.h                                        |    1 
 sound/pci/hda/patch_conexant.c                                     |    2 
 sound/soc/amd/yc/acp6x-mach.c                                      |   14 
 sound/soc/codecs/es8326.c                                          |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                    |  160 +++++++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh                     |    4 
 210 files changed, 2042 insertions(+), 693 deletions(-)

Abel Vesa (1):
      arm64: dts: qcom: x1e80100: Describe the PCIe 6a resources

Abhishek Pandit-Subedi (1):
      usb: typec: ucsi: Fix null pointer dereference in trace

Aleksandr Mishin (1):
      PCI: al: Check IORESOURCE_BUS existence during probe

Alex Hung (12):
      drm/amd/display: Ensure array index tg_inst won't be -1
      drm/amd/display: Check gpio_id before used as array index
      drm/amd/display: Fix incorrect size calculation for loop
      drm/amd/display: Check index for aux_rd_interval before using
      drm/amd/display: Check num_valid_sets before accessing reader_wm_sets[]
      drm/amd/display: Check msg_id before processing transcation
      drm/amd/display: Check link_index before accessing dc->links[]
      drm/amd/display: Spinlock before reading event
      drm/amd/display: Ensure index calculation will not overflow
      drm/amd/display: Avoid overflow from uint32_t to uint8_t
      drm/amd/display: Check BIOS images before it is used
      drm/amd/display: Skip wbscl_set_scaler_filter if filter is null

Alvin Lee (1):
      drm/amd/display: Assign linear_pitch_alignment even for VM

Amir Goldstein (1):
      fsnotify: clear PARENT_WATCHED flags lazily

Andreas Gruenbacher (1):
      gfs2: Revert "Add quota_change type"

Andy Shevchenko (1):
      regmap: spi: Fix potential off-by-one when calculating reserved size

AngeloGioacchino Del Regno (1):
      remoteproc: mediatek: Zero out only remaining bytes of IPI buffer

Asad Kamal (1):
      drm/amd/amdgpu: Check tbo resource pointer

Ben Walsh (1):
      platform/chrome: cros_ec_lpc: MEC access can use an AML mutex

Bob Zhou (1):
      drm/amdgpu: fix overflowed constant warning in mmhub_set_clockgating()

Boris Burkov (1):
      btrfs: fix qgroup reserve leaks in cow_file_range

Bruno Ancona (1):
      ASoC: amd: yc: Support mic on HP 14-em0002la

Casey Schaufler (1):
      smack: tcp: ipv4, fix incorrect labeling

Chao Yu (1):
      f2fs: fix to do sanity check on blocks for inline_data inode

Chris Lew (1):
      soc: qcom: smem: Add qcom_smem_bust_hwspin_lock_by_host()

Christoph Hellwig (1):
      block: remove the blk_flush_integrity call in blk_integrity_unregister

David (Ming Qiang) Wu (1):
      drm/amdgpu/vcn: remove irq disabling in vcn 5 suspend

David Howells (1):
      mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()

Devyn Liu (1):
      spi: hisi-kunpeng: Add validation for the minimum value of speed_hz

Dragos Tatulea (1):
      net/mlx5e: SHAMPO, Fix incorrect page release

Eric Dumazet (1):
      tcp: annotate data-races around tw->tw_ts_recent and tw->tw_ts_recent_stamp

Francois Dugast (1):
      drm/xe/gt: Fix assert in L3 bank mask generation

Frederic Weisbecker (1):
      rcu/nocb: Remove buggy bypass lock contention mitigation

Greg Kroah-Hartman (1):
      Linux 6.10.9

Haoran Liu (1):
      drm/meson: plane: Add error handling

Heng Qi (1):
      virtio-net: check feature before configuring the vq coalescing command

Hersen Wu (13):
      drm/amd/display: Stop amdgpu_dm initialize when stream nums greater than 6
      drm/amd/display: Stop amdgpu_dm initialize when link nums greater than max_links
      drm/amd/display: Add missing NULL pointer check within dpcd_extend_address_range
      drm/amd/display: Add array index check for hdcp ddc access
      drm/amd/display: Release state memory if amdgpu_dm_create_color_properties fail
      drm/amd/display: Add otg_master NULL check within resource_log_pipe_topology_update
      drm/amd/display: Fix Coverity INTERGER_OVERFLOW within construct_integrated_info
      drm/amd/display: Fix Coverity INTEGER_OVERFLOW within dal_gpio_service_create
      drm/amd/display: Release clck_src memory if clk_src_construct fails
      drm/amd/display: Fix Coverity INTEGER_OVERFLOW within decide_fallback_link_setting_max_bw_policy
      drm/amd/display: Skip inactive planes within ModeSupportAndSystemConfiguration
      drm/amd/display: Fix writeback job lock evasion within dm_crtc_high_irq
      drm/amd/display: Fix index may exceed array range within fpu_update_bw_bounding_box

Himal Prasad Ghimiray (3):
      drm/xe: Fix the warning conditions
      drm/xe: Ensure caller uses sole domain for xe_force_wake_assert_held
      drm/xe: Check valid domain is passed in xe_force_wake_ref

Jagadeesh Kona (1):
      cpufreq: scmi: Avoid overflow of target_freq in fast switch

Jason Xing (1):
      net: remove NULL-pointer net parameter in ip_metrics_convert

Jeff Johnson (3):
      wifi: ath12k: initialize 'ret' in ath12k_qmi_load_file_target_mem()
      wifi: ath11k: initialize 'ret' in ath11k_qmi_load_file_target_mem()
      wifi: ath12k: initialize 'ret' in ath12k_dp_rxdma_ring_sel_config_wcn7850()

Jesse Zhang (13):
      drm/amd/pm: fix uninitialized variable warning
      drm/amd/pm: fix warning using uninitialized value of max_vid_step
      drm/amd/pm: Fix negative array index read
      drm/amd/pm: fix the Out-of-bounds read warning
      drm/amdgpu: Fix the warning division or modulo by zero
      drm/amdgpu: fix dereference after null check
      drm/amdgpu: fix the waring dereferencing hive
      drm/amd/pm: check specific index for aldebaran
      drm/amd/pm: check specific index for smu13
      drm/amdgpu: the warning dereferencing obj for nbio_v7_4
      drm/amdgpu: fix the warning bad bit shift operation for aca_error_type type
      drm/amd/pm: check negtive return for table entries
      drm/amdgu: fix Unintentional integer overflow for mall size

Johan Hovold (4):
      arm64: dts: qcom: x1e80100-crd: fix up PCIe6a pinctrl node
      arm64: dts: qcom: x1e80100-crd: fix missing PCIe4 gpios
      arm64: dts: qcom: x1e80100-qcp: fix up PCIe6a pinctrl node
      arm64: dts: qcom: x1e80100-qcp: fix missing PCIe4 gpios

Johannes Berg (4):
      wifi: cfg80211: restrict operation during radar detection
      wifi: iwlwifi: mvm: use only beacon BSS load for active links
      wifi: mac80211: check ieee80211_bss_info_change_notify() against MLD
      wifi: cfg80211: make hash table duplicates more survivable

John Allen (1):
      RAS/AMD/ATL: Validate address map when information is gathered

Joshua Aberback (1):
      Revert "drm/amd/display: Fix incorrect pointer assignment"

Julien Stephan (1):
      driver: iio: add missing checks on iio_info's callback access

Karthik Poosa (1):
      drm/xe/hwmon: Remove unwanted write permission for currN_label

Ken Sloat (1):
      pwm: xilinx: Fix u32 overflow issue in 32-bit width PWM mode.

Krzysztof Stępniak (1):
      ASoC: amd: yc: Support mic on Lenovo Thinkpad E14 Gen 6

Kyoungrul Kim (1):
      scsi: ufs: core: Check LSDBS cap when !mcq

Lad Prabhakar (1):
      pinctrl: renesas: rzg2l: Validate power registers for SD and ETH

Leesoo Ahn (1):
      apparmor: fix possible NULL pointer dereference

Lin.Cao (1):
      drm/amdkfd: Check debug trap enable before write dbg_ev_file

Luke D. Jones (1):
      platform/x86/amd: pmf: Add quirk for ROG Ally X

Léo DUBOIN (1):
      pinctrl: core: reset gpio_device in loop in pinctrl_pins_show()

Ma Jun (10):
      drm/amdgpu: Fix uninitialized variable warning in amdgpu_afmt_acr
      drm/amdgpu/pm: Check the return value of smum_send_msg_to_smc
      drm/amdgpu/pm: Fix uninitialized variable warning for smu10
      drm/amdgpu/pm: Fix uninitialized variable agc_btc_response
      drm/amdgpu: Fix the uninitialized variable warning
      drm/amdgpu: Fix out-of-bounds write warning
      drm/amdgpu: Fix out-of-bounds read of df_v1_7_channel_number
      drm/amdgpu: Fix uninitialized variable warning in amdgpu_info_ioctl
      drm/amdgpu/pm: Check input value for CUSTOM profile mode setting on legacy SOCs
      drm/amdgpu/pm: Check input value for power profile setting on smu11, smu13 and smu14

Marek Vasut (1):
      drm/bridge: tc358767: Check if fully initialized before signalling HPD event via IRQ

Matthew Brost (2):
      drm/xe: Don't overmap identity VRAM mapping
      drm/xe: Add GuC state asserts to deregister_exec_queue

Matthieu Baerts (NGI0) (5):
      selftests: mptcp: join: check re-using ID of unused ADD_ADDR
      selftests: mptcp: join: check re-adding init endp with != id
      selftests: mptcp: join: validate event numbers
      selftests: mptcp: join: check re-re-adding ID 0 signal
      selftests: mptcp: join: test for flush/re-add endpoints

Maxime Méré (1):
      crypto: stm32/cryp - call finalize with bh disabled

Michael Chen (1):
      drm/amdkfd: Reconcile the definition and use of oem_id in struct kfd_topology_device

Michael Margolin (1):
      RDMA/efa: Properly handle unexpected AQ completions

Nicholas Kazlauskas (3):
      drm/amd/display: Don't use fsleep for PSR exit waits on dmub replay
      drm/amd/display: Remove register from DCN35 DMCUB diagnostic collection
      drm/amd/display: Disable DMCUB timeout for DCN35

Nicholas Susanto (1):
      drm/amd/display: Fix pipe addition logic in calc_blocks_to_ungate DCN35

Nirmoy Das (1):
      drm/xe: Use missing lock in relay_needs_worker

Olivier Dautricourt (2):
      dmaengine: altera-msgdma: use irq variant of spin_lock/unlock while invoking callbacks
      dmaengine: altera-msgdma: properly free descriptor in msgdma_free_descriptor

Paolo Abeni (1):
      selftests: mptcp: add explicit test case for remove/readd

Paulo Alcantara (1):
      smb: client: fix FSCTL_GET_REPARSE_POINT against NetApp

Perry Yuan (1):
      x86/CPU/AMD: Add models 0x60-0x6f to the Zen5 range

Peter Wang (1):
      scsi: ufs: core: Bypass quick recovery if force reset is needed

Philip Mueller (1):
      drm: panel-orientation-quirks: Add quirk for OrangePi Neo

Philip Yang (1):
      drm/amdgpu: Handle sg size limit for contiguous allocation

Qiuxu Zhuo (1):
      drm/fb-helper: Don't schedule_work() to flush frame buffer during panic()

Qu Wenruo (3):
      btrfs: tree-checker: validate dref root and objectid
      btrfs: factor out stripe length calculation into a helper
      btrfs: scrub: update last_physical after scrubbing one stripe

Rafael J. Wysocki (1):
      thermal: trip: Use READ_ONCE() for lockless access to trip properties

Ricardo Ribalda (1):
      media: uvcvideo: Enforce alignment of frame and interval

Richard Fitzgerald (2):
      i2c: Fix conditional for substituting empty ACPI functions
      i2c: Use IS_REACHABLE() for substituting empty ACPI functions

Richard Maina (2):
      hwspinlock: Introduce hwspin_lock_bust()
      remoteproc: qcom_q6v5_pas: Add hwspinlock bust on stop

Rik van Riel (1):
      dma-debug: avoid deadlock between dma debug vs printk and netconsole

Rodrigo Siqueira (1):
      drm/amd/display: Handle the case which quad_part is equal 0

Rodrigo Vivi (1):
      drm/xe: Demote CCS_MODE info to debug only

Sakari Ailus (1):
      media: v4l2-cci: Always assign *val

Shahar S Matityahu (1):
      wifi: iwlwifi: remove fw_running op

Shannon Nelson (1):
      ionic: fix potential irq name truncation

Shyam Sundar S K (1):
      platform/x86/amd/pmf: Add new ACPI ID AMDI0107

Simon Holesch (1):
      usbip: Don't submit special requests twice

Stefan Berger (1):
      crypto: ecc - Fix off-by-one missing to clear most significant digit

Sui Jingfeng (1):
      drm/drm-bridge: Drop conditionals around of_node pointers

Takashi Iwai (7):
      ALSA: hda/generic: Add a helper to mute speakers at suspend/shutdown
      ALSA: hda/conexant: Mute speakers at suspend / shutdown
      ALSA: ump: Transmit RPN/NRPN message at each MSB/LSB data reception
      ALSA: ump: Explicitly reset RPN with Null RPN
      ALSA: seq: ump: Use the common RPN/bank conversion context
      ALSA: seq: ump: Transmit RPN/NRPN message at each MSB/LSB data reception
      ALSA: seq: ump: Explicitly reset RPN with Null RPN

Tao Zhou (3):
      drm/amdgpu: update type of buf size to u32 for eeprom functions
      drm/amdgpu: set RAS fed status for more cases
      drm/amdkfd: use mode1 reset for RAS poison consumption

Tim Huang (10):
      drm/amdgpu: fix overflowed array index read warning
      drm/amd/pm: fix uninitialized variable warning for smu8_hwmgr
      drm/amd/pm: fix uninitialized variable warning for smu_v13
      drm/amdgpu: fix uninitialized scalar variable warning
      drm/amd/pm: fix uninitialized variable warnings for vega10_hwmgr
      drm/amd/pm: fix uninitialized variable warnings for vangogh_ppt
      drm/amdgpu: fix uninitialized variable warning for amdgpu_xgmi
      drm/amdgpu: fix uninitialized variable warning for jpeg_v4
      drm/amdgpu: fix ucode out-of-bounds read warning
      drm/amdgpu: fix mc_data out-of-bounds read warning

Valentin Schneider (1):
      net: tcp/dccp: prepare for tw_timer un-pinning

Victor Skvortsov (1):
      drm/amdgpu: Queue KFD reset workitem in VF FED

Wayne Lin (1):
      drm/amd/display: Correct the defined value for AMDGPU_DMUB_NOTIFICATION_MAX

Wenjing Liu (1):
      drm/amd/display: use preferred link settings for dp signal only

Xiaogang Chen (1):
      drm/kfd: Correct pinned buffer handling at kfd restore and validate process

Yang Wang (2):
      drm/amdgpu: fix compiler 'side-effect' check issue for RAS_EVENT_LOG()
      drm/amdgpu: remove redundant semicolons in RAS_EVENT_LOG

Yazen Ghannam (1):
      hwmon: (k10temp) Check return value of amd_smn_read()

Yevgeny Kliteynik (1):
      net/mlx5: DR, Fix 'stack guard page was hit' error in dr_rule

Yunxiang Li (3):
      drm/amdgpu: add skip_hw_access checks for sriov
      drm/amdgpu: add lock in amdgpu_gart_invalidate_tlb
      drm/amdgpu: add lock in kfd_process_dequeue_from_device

ZHANG Yuntian (1):
      net: usb: qmi_wwan: add MeiG Smart SRM825L

Zhang Yi (1):
      ASoC: codecs: ES8326: button detect issue

Zhigang Luo (1):
      drm/amdgpu: avoid reading vf2pf info size from FB

Zong-Zhe Yang (1):
      wifi: rtw89: ser: avoid multiple deinit on same CAM

winstang (1):
      drm/amd/display: added NULL check at start of dc_validate_stream


