Return-Path: <stable+bounces-73839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B40997052D
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 08:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE47281D6A
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 06:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E0A535DC;
	Sun,  8 Sep 2024 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L4ENRdPH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B5E4DA14;
	Sun,  8 Sep 2024 06:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725776007; cv=none; b=YZy+Y8s5pVC9JHY1S0tFsoG7oU8FQINQhwM3zZE9pl32mdX2Nre3IaNto8WtAm47/IDsi43mnVj5gu8nspnNp6Wpf03f/VAqq4dx6rT7n4BPPoOfYcXwTPywS0d/JePf704Y3CxSsnSTNaAkpgwA8K7A6niZv1cJZkjTIUMF5Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725776007; c=relaxed/simple;
	bh=Whqa9a5+k4AlMt9Y1A1ZmW5YQkAamEJMA4mnyiuN2zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nNgJG3YwoZxCOFgbbYpQqz/My4H3LA0RU4ZCRkEPpM+fk0yAopm/SysqSnKxfX5TNfD69GGFE3PTarOW6VWknG8Rjlcz9TR236RCIpb5BtsV+q+O75ihX1Q4ONBdDG1u4sWQoB8ml8byRx3XJylWHB5PLJtfCZKfdpn0kQT3C8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L4ENRdPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6449DC4CEC3;
	Sun,  8 Sep 2024 06:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725776006;
	bh=Whqa9a5+k4AlMt9Y1A1ZmW5YQkAamEJMA4mnyiuN2zs=;
	h=From:To:Cc:Subject:Date:From;
	b=L4ENRdPHfwkI+6ewrQ7cTk+BazDNWsKK1SspMxsW0oCl2agzgV6WMN0jS31oU/r77
	 6gqOqzNcbPpgZmx0STS578Vfiai6+kuQbYApAiKZ4DSaUVnLsveXnz3AFkn+SZuQh7
	 SnMBO/NbFAL7BpVLbyqM6/GvDhT5Av3SX7c5EdwE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.50
Date: Sun,  8 Sep 2024 08:13:21 +0200
Message-ID: <2024090821-starship-prone-1ff9@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.50 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/locking/hwspinlock.rst                               |   11 
 Makefile                                                           |    2 
 block/blk-integrity.c                                              |    2 
 drivers/base/regmap/regmap-spi.c                                   |    3 
 drivers/cpufreq/scmi-cpufreq.c                                     |    4 
 drivers/crypto/stm32/stm32-cryp.c                                  |    6 
 drivers/dma/altera-msgdma.c                                        |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c                           |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                   |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c                            |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                         |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c                         |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h                         |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c                           |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                            |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                           |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c                  |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                           |   11 
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c                         |    6 
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c                             |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h                              |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c                             |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c             |    9 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                          |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h                          |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                  |   19 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                  |    2 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c                  |   18 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                 |    7 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c          |    3 
 drivers/gpu/drm/amd/display/dc/core/dc.c                           |    1 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                  |    3 
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c                   |    3 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c               |    3 
 drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c               |    7 
 drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c             |   10 
 drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c             |   10 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c               |   10 
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c             |   10 
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c              |    7 
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c                 |   17 
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c                     |   17 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c |   26 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c   |    4 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c                |   28 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                   |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c                    |   13 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                |    5 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c               |   29 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c                |   15 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c              |   60 +
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c              |   20 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c              |   31 -
 drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c            |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c                    |   27 
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c                   |   14 
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c                 |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c               |    2 
 drivers/gpu/drm/bridge/tc358767.c                                  |    2 
 drivers/gpu/drm/drm_fb_helper.c                                    |   11 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                     |    6 
 drivers/gpu/drm/meson/meson_plane.c                                |   17 
 drivers/hwmon/k10temp.c                                            |   36 -
 drivers/hwspinlock/hwspinlock_core.c                               |   28 
 drivers/hwspinlock/hwspinlock_internal.h                           |    3 
 drivers/iio/industrialio-core.c                                    |    7 
 drivers/iio/industrialio-event.c                                   |    9 
 drivers/iio/inkern.c                                               |   32 -
 drivers/infiniband/hw/efa/efa_com.c                                |   30 
 drivers/media/usb/uvc/uvc_driver.c                                 |   18 
 drivers/media/v4l2-core/v4l2-cci.c                                 |    9 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                    |    3 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c         |    2 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                    |    2 
 drivers/net/usb/qmi_wwan.c                                         |    1 
 drivers/net/virtio_net.c                                           |    8 
 drivers/net/wireless/ath/ath11k/qmi.c                              |    2 
 drivers/net/wireless/ath/ath12k/qmi.c                              |    2 
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c                    |    3 
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h                    |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                       |    6 
 drivers/net/wireless/realtek/rtw89/ser.c                           |    8 
 drivers/pci/controller/dwc/pcie-al.c                               |   16 
 drivers/platform/chrome/cros_ec_lpc_mec.c                          |   76 ++
 drivers/platform/chrome/cros_ec_lpc_mec.h                          |   11 
 drivers/soc/qcom/smem.c                                            |   26 
 drivers/spi/spi-hisi-kunpeng.c                                     |    1 
 drivers/ufs/core/ufshcd.c                                          |   19 
 drivers/usb/typec/ucsi/ucsi.h                                      |    2 
 drivers/usb/usbip/stub_rx.c                                        |   77 +-
 fs/btrfs/tree-checker.c                                            |   47 +
 fs/f2fs/f2fs.h                                                     |    2 
 fs/f2fs/inline.c                                                   |   20 
 fs/f2fs/inode.c                                                    |    2 
 fs/gfs2/quota.c                                                    |   19 
 fs/gfs2/util.c                                                     |    6 
 fs/notify/fsnotify.c                                               |   31 -
 fs/notify/fsnotify.h                                               |    2 
 fs/notify/mark.c                                                   |   32 -
 fs/smb/client/smb2inode.c                                          |    6 
 include/clocksource/timer-xilinx.h                                 |    2 
 include/linux/fsnotify_backend.h                                   |    8 
 include/linux/hwspinlock.h                                         |    6 
 include/linux/i2c.h                                                |    2 
 include/linux/soc/qcom/smem.h                                      |    2 
 include/net/ip.h                                                   |    3 
 include/net/tcp.h                                                  |    2 
 include/sound/ump_convert.h                                        |    1 
 include/ufs/ufshcd.h                                               |    1 
 include/ufs/ufshci.h                                               |    1 
 kernel/dma/debug.c                                                 |    5 
 kernel/rcu/tree.h                                                  |    1 
 kernel/rcu/tree_nocb.h                                             |   32 -
 net/ipv4/fib_semantics.c                                           |    5 
 net/ipv4/metrics.c                                                 |    8 
 net/ipv4/tcp_cong.c                                                |   11 
 net/ipv6/route.c                                                   |    2 
 net/mac80211/main.c                                                |    3 
 net/mptcp/fastopen.c                                               |    4 
 net/mptcp/options.c                                                |   50 -
 net/mptcp/pm.c                                                     |   28 
 net/mptcp/pm_netlink.c                                             |   52 -
 net/mptcp/protocol.c                                               |   58 +
 net/mptcp/protocol.h                                               |    9 
 net/mptcp/sched.c                                                  |    4 
 net/mptcp/sockopt.c                                                |    4 
 net/mptcp/subflow.c                                                |   48 -
 net/wireless/scan.c                                                |   46 +
 security/apparmor/apparmorfs.c                                     |    4 
 security/smack/smack_lsm.c                                         |    2 
 sound/core/seq/seq_ports.h                                         |   14 
 sound/core/seq/seq_ump_convert.c                                   |   95 +--
 sound/core/ump_convert.c                                           |   60 +
 sound/pci/hda/hda_generic.c                                        |   63 ++
 sound/pci/hda/hda_generic.h                                        |    1 
 sound/pci/hda/patch_conexant.c                                     |    2 
 sound/soc/amd/yc/acp6x-mach.c                                      |   14 
 sound/soc/codecs/es8326.c                                          |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                    |  304 +++++++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh                     |   38 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh                  |   30 
 145 files changed, 1662 insertions(+), 571 deletions(-)

Abhishek Pandit-Subedi (1):
      usb: typec: ucsi: Fix null pointer dereference in trace

Aleksandr Mishin (1):
      PCI: al: Check IORESOURCE_BUS existence during probe

Alex Hung (8):
      drm/amd/display: Check gpio_id before used as array index
      drm/amd/display: Check index for aux_rd_interval before using
      drm/amd/display: Check num_valid_sets before accessing reader_wm_sets[]
      drm/amd/display: Check msg_id before processing transcation
      drm/amd/display: Spinlock before reading event
      drm/amd/display: Ensure index calculation will not overflow
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

Asad Kamal (1):
      drm/amd/amdgpu: Check tbo resource pointer

Ben Walsh (1):
      platform/chrome: cros_ec_lpc: MEC access can use an AML mutex

Breno Leitao (1):
      virtio_net: Fix napi_skb_cache_put warning

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

Devyn Liu (1):
      spi: hisi-kunpeng: Add validation for the minimum value of speed_hz

Dragos Tatulea (1):
      net/mlx5e: SHAMPO, Fix incorrect page release

Frederic Weisbecker (1):
      rcu/nocb: Remove buggy bypass lock contention mitigation

Geliang Tang (6):
      mptcp: make pm_remove_addrs_and_subflows static
      selftests: mptcp: userspace pm create id 0 subflow
      selftests: mptcp: dump userspace addrs list
      selftests: mptcp: userspace pm get addr tests
      selftests: mptcp: declare event macros in mptcp_lib
      selftests: mptcp: add mptcp_lib_events helper

Greg Kroah-Hartman (1):
      Linux 6.6.50

Haoran Liu (1):
      drm/meson: plane: Add error handling

Hersen Wu (7):
      drm/amd/display: Stop amdgpu_dm initialize when stream nums greater than 6
      drm/amd/display: Add array index check for hdcp ddc access
      drm/amd/display: Fix Coverity INTERGER_OVERFLOW within construct_integrated_info
      drm/amd/display: Fix Coverity INTEGER_OVERFLOW within dal_gpio_service_create
      drm/amd/display: Fix Coverity INTEGER_OVERFLOW within decide_fallback_link_setting_max_bw_policy
      drm/amd/display: Skip inactive planes within ModeSupportAndSystemConfiguration
      drm/amd/display: Fix index may exceed array range within fpu_update_bw_bounding_box

Jagadeesh Kona (1):
      cpufreq: scmi: Avoid overflow of target_freq in fast switch

Jason Xing (1):
      net: remove NULL-pointer net parameter in ip_metrics_convert

Jeff Johnson (2):
      wifi: ath12k: initialize 'ret' in ath12k_qmi_load_file_target_mem()
      wifi: ath11k: initialize 'ret' in ath11k_qmi_load_file_target_mem()

Jesse Zhang (12):
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
      drm/amd/pm: check negtive return for table entries
      drm/amdgu: fix Unintentional integer overflow for mall size

Johannes Berg (2):
      wifi: mac80211: check ieee80211_bss_info_change_notify() against MLD
      wifi: cfg80211: make hash table duplicates more survivable

Julien Stephan (1):
      driver: iio: add missing checks on iio_info's callback access

Ken Sloat (1):
      pwm: xilinx: Fix u32 overflow issue in 32-bit width PWM mode.

Krzysztof Stępniak (1):
      ASoC: amd: yc: Support mic on Lenovo Thinkpad E14 Gen 6

Kyoungrul Kim (1):
      scsi: ufs: core: Check LSDBS cap when !mcq

Leesoo Ahn (1):
      apparmor: fix possible NULL pointer dereference

Lin.Cao (1):
      drm/amdkfd: Check debug trap enable before write dbg_ev_file

Ma Jun (8):
      drm/amdgpu: Fix uninitialized variable warning in amdgpu_afmt_acr
      drm/amdgpu/pm: Check the return value of smum_send_msg_to_smc
      drm/amdgpu/pm: Fix uninitialized variable warning for smu10
      drm/amdgpu/pm: Fix uninitialized variable agc_btc_response
      drm/amdgpu: Fix the uninitialized variable warning
      drm/amdgpu: Fix out-of-bounds write warning
      drm/amdgpu: Fix out-of-bounds read of df_v1_7_channel_number
      drm/amdgpu/pm: Check input value for CUSTOM profile mode setting on legacy SOCs

Marek Vasut (1):
      drm/bridge: tc358767: Check if fully initialized before signalling HPD event via IRQ

Matthieu Baerts (NGI0) (11):
      mptcp: pm: fix RM_ADDR ID for the initial subflow
      selftests: mptcp: join: cannot rm sf if closed
      selftests: mptcp: join: check re-using ID of unused ADD_ADDR
      selftests: mptcp: join: check re-adding init endp with != id
      selftests: mptcp: join: validate event numbers
      selftests: mptcp: join: check re-re-adding ID 0 signal
      selftests: mptcp: join: test for flush/re-add endpoints
      selftests: mptcp: join: disable get and dump addr checks
      selftests: mptcp: join: stop transfer when check is done (part 2.2)
      mptcp: avoid duplicated SUB_CLOSED events
      mptcp: pr_debug: add missing \n at the end

Maxime Méré (1):
      crypto: stm32/cryp - call finalize with bh disabled

Michael Chen (1):
      drm/amdkfd: Reconcile the definition and use of oem_id in struct kfd_topology_device

Michael Margolin (1):
      RDMA/efa: Properly handle unexpected AQ completions

Nicholas Kazlauskas (1):
      drm/amd/display: Don't use fsleep for PSR exit waits on dmub replay

Olivier Dautricourt (2):
      dmaengine: altera-msgdma: use irq variant of spin_lock/unlock while invoking callbacks
      dmaengine: altera-msgdma: properly free descriptor in msgdma_free_descriptor

Paolo Abeni (1):
      selftests: mptcp: add explicit test case for remove/readd

Paulo Alcantara (1):
      smb: client: fix FSCTL_GET_REPARSE_POINT against NetApp

Peter Wang (1):
      scsi: ufs: core: Bypass quick recovery if force reset is needed

Philip Mueller (1):
      drm: panel-orientation-quirks: Add quirk for OrangePi Neo

Qiuxu Zhuo (1):
      drm/fb-helper: Don't schedule_work() to flush frame buffer during panic()

Qu Wenruo (1):
      btrfs: tree-checker: validate dref root and objectid

Ricardo Ribalda (1):
      media: uvcvideo: Enforce alignment of frame and interval

Richard Fitzgerald (2):
      i2c: Fix conditional for substituting empty ACPI functions
      i2c: Use IS_REACHABLE() for substituting empty ACPI functions

Richard Maina (1):
      hwspinlock: Introduce hwspin_lock_bust()

Rik van Riel (1):
      dma-debug: avoid deadlock between dma debug vs printk and netconsole

Sakari Ailus (1):
      media: v4l2-cci: Always assign *val

Shahar S Matityahu (1):
      wifi: iwlwifi: remove fw_running op

Shannon Nelson (1):
      ionic: fix potential irq name truncation

Simon Holesch (1):
      usbip: Don't submit special requests twice

Takashi Iwai (7):
      ALSA: hda/generic: Add a helper to mute speakers at suspend/shutdown
      ALSA: hda/conexant: Mute speakers at suspend / shutdown
      ALSA: ump: Transmit RPN/NRPN message at each MSB/LSB data reception
      ALSA: ump: Explicitly reset RPN with Null RPN
      ALSA: seq: ump: Use the common RPN/bank conversion context
      ALSA: seq: ump: Transmit RPN/NRPN message at each MSB/LSB data reception
      ALSA: seq: ump: Explicitly reset RPN with Null RPN

Tao Zhou (1):
      drm/amdgpu: update type of buf size to u32 for eeprom functions

Tim Huang (6):
      drm/amdgpu: fix overflowed array index read warning
      drm/amd/pm: fix uninitialized variable warning for smu8_hwmgr
      drm/amd/pm: fix uninitialized variable warnings for vega10_hwmgr
      drm/amd/pm: fix uninitialized variable warnings for vangogh_ppt
      drm/amdgpu: fix ucode out-of-bounds read warning
      drm/amdgpu: fix mc_data out-of-bounds read warning

Wayne Lin (1):
      drm/amd/display: Correct the defined value for AMDGPU_DMUB_NOTIFICATION_MAX

Wenjing Liu (1):
      drm/amd/display: use preferred link settings for dp signal only

Xiaogang Chen (1):
      drm/kfd: Correct pinned buffer handling at kfd restore and validate process

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


