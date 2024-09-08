Return-Path: <stable+bounces-73837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001AA97052A
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 08:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B83282F37
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 06:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248744879B;
	Sun,  8 Sep 2024 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D2gACJZz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F9CA93D;
	Sun,  8 Sep 2024 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725775992; cv=none; b=dCYec0xF2+hbkQ5P3i6Rw5ONd6l/gGTe8MYNFCCDuU3pp55le1KkvKUfEJjIWYqqjl6Nq3Q2DcS1jgG8bAXrNvLxf3KhdNN/i/vSK2rt2IvIBD1kBD+HYykqBdDghRCxYkDprZYE+kJb6ma2WAqJ2WVjOW6Jt/OrlU8dRdIAeFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725775992; c=relaxed/simple;
	bh=HsBFxnVWJWsBVUi0xU9Df//fHHTOOtUPtWLQcW3Hn4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AZKi+C8r2aR5PoQKv9fJi5u6go80CV8xNVQ/CTwwpZS+Cgt3+1wc63onTYnmtCRKbTO+pxY9YRjxhqblA0zeXCWDviygR/e+85PQqMl1BsdU2HW98USE1UFCmIvHfYTBgYUfCRg3pog3kWt2oUCOXXsgfyau5XKvG30xjSVDbxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D2gACJZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24C7C4CEC3;
	Sun,  8 Sep 2024 06:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725775992;
	bh=HsBFxnVWJWsBVUi0xU9Df//fHHTOOtUPtWLQcW3Hn4Q=;
	h=From:To:Cc:Subject:Date:From;
	b=D2gACJZz0HxQWdrYU43IUpfrn4HgptYIily1ym4aQhjmZlfZKgAQfdfoUu+J4Gkm3
	 qvaXkq9xXPnpKCf+9j6SeiXzV1DJZUKDdD8C0R0R4OAh2oZ3WbEdKh4kCKnr1Aoi3Z
	 tMVH3oJc8hKBP7URplZpdr+IPs6jNwOWXz5DEVXg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.109
Date: Sun,  8 Sep 2024 08:13:07 +0200
Message-ID: <2024090806-eleven-cubicle-5cbb@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.109 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/locking/hwspinlock.rst                      |   11 +
 Makefile                                                  |    2 
 block/blk-integrity.c                                     |    2 
 drivers/base/regmap/regmap-spi.c                          |    3 
 drivers/cpufreq/scmi-cpufreq.c                            |    4 
 drivers/dma/altera-msgdma.c                               |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c                  |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c              |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c                   |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c                |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h                |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                   |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                  |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                  |    2 
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c                      |    2 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c                    |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h                     |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                 |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h                 |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         |   19 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h         |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |    3 
 drivers/gpu/drm/amd/display/dc/core/dc.c                  |    1 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c         |    3 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c      |    3 
 drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c      |    7 
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c     |    7 
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c        |   17 +
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c            |   17 +
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c       |   28 ++
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c          |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c           |   13 -
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c       |    5 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c      |   29 ++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c       |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c       |   15 +
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c     |   60 ++++-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c     |   20 +
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c     |   31 ++
 drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c   |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c           |   27 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c          |   14 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c        |    3 
 drivers/gpu/drm/bridge/tc358767.c                         |    2 
 drivers/gpu/drm/drm_panel_orientation_quirks.c            |    6 
 drivers/gpu/drm/meson/meson_plane.c                       |   17 +
 drivers/hwmon/k10temp.c                                   |   36 ++-
 drivers/hwspinlock/hwspinlock_core.c                      |   28 ++
 drivers/hwspinlock/hwspinlock_internal.h                  |    3 
 drivers/iio/industrialio-core.c                           |    7 
 drivers/iio/industrialio-event.c                          |    9 
 drivers/iio/inkern.c                                      |   32 ++
 drivers/infiniband/hw/efa/efa_com.c                       |   30 +-
 drivers/media/usb/uvc/uvc_driver.c                        |   18 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c           |    3 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c           |    2 
 drivers/net/usb/qmi_wwan.c                                |    1 
 drivers/net/virtio_net.c                                  |    8 
 drivers/net/wireless/ath/ath11k/qmi.c                     |    2 
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c           |    3 
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h           |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c              |    6 
 drivers/net/wireless/realtek/rtw89/ser.c                  |    8 
 drivers/pci/controller/dwc/pcie-al.c                      |   16 +
 drivers/pci/msi/msi.c                                     |   10 
 drivers/ufs/core/ufshcd.c                                 |    3 
 drivers/usb/typec/ucsi/ucsi.h                             |    2 
 drivers/usb/usbip/stub_rx.c                               |   77 ++++---
 fs/ext4/extents.c                                         |    2 
 fs/ext4/inode.c                                           |    5 
 fs/ext4/page-io.c                                         |   14 +
 fs/f2fs/f2fs.h                                            |    1 
 fs/f2fs/file.c                                            |   42 +++
 fs/f2fs/inode.c                                           |    8 
 fs/notify/fsnotify.c                                      |   31 +-
 fs/notify/fsnotify.h                                      |    2 
 fs/notify/mark.c                                          |   32 ++
 fs/udf/super.c                                            |    9 
 include/clocksource/timer-xilinx.h                        |    2 
 include/linux/fsnotify_backend.h                          |    8 
 include/linux/hwspinlock.h                                |    6 
 include/linux/i2c.h                                       |    2 
 kernel/dma/debug.c                                        |    5 
 kernel/rcu/tree.h                                         |    1 
 kernel/rcu/tree_nocb.h                                    |   32 --
 net/bluetooth/sco.c                                       |   76 ++++---
 net/mptcp/options.c                                       |   50 ++--
 net/mptcp/pm.c                                            |   28 +-
 net/mptcp/pm_netlink.c                                    |  151 ++++++++------
 net/mptcp/protocol.c                                      |   58 ++---
 net/mptcp/protocol.h                                      |   10 
 net/mptcp/sockopt.c                                       |    4 
 net/mptcp/subflow.c                                       |   50 ++--
 net/wireless/scan.c                                       |   46 +++-
 security/apparmor/apparmorfs.c                            |    4 
 security/smack/smack_lsm.c                                |    2 
 sound/pci/hda/hda_generic.c                               |   63 +++++
 sound/pci/hda/hda_generic.h                               |    1 
 sound/pci/hda/patch_conexant.c                            |    2 
 sound/soc/amd/yc/acp6x-mach.c                             |    7 
 tools/testing/selftests/net/mptcp/mptcp_join.sh           |  136 ++++++++++--
 102 files changed, 1141 insertions(+), 489 deletions(-)

Abhishek Pandit-Subedi (1):
      usb: typec: ucsi: Fix null pointer dereference in trace

Aleksandr Mishin (1):
      PCI: al: Check IORESOURCE_BUS existence during probe

Alex Hung (6):
      drm/amd/display: Check gpio_id before used as array index
      drm/amd/display: Check num_valid_sets before accessing reader_wm_sets[]
      drm/amd/display: Check msg_id before processing transcation
      drm/amd/display: Spinlock before reading event
      drm/amd/display: Ensure index calculation will not overflow
      drm/amd/display: Skip wbscl_set_scaler_filter if filter is null

Alvin Lee (1):
      drm/amd/display: Assign linear_pitch_alignment even for VM

Amir Goldstein (1):
      fsnotify: clear PARENT_WATCHED flags lazily

Andy Shevchenko (1):
      regmap: spi: Fix potential off-by-one when calculating reserved size

Asad Kamal (1):
      drm/amd/amdgpu: Check tbo resource pointer

Breno Leitao (1):
      virtio_net: Fix napi_skb_cache_put warning

Casey Schaufler (1):
      smack: tcp: ipv4, fix incorrect labeling

Chao Yu (1):
      f2fs: fix to truncate preallocated blocks in f2fs_file_open()

Christoph Hellwig (1):
      block: remove the blk_flush_integrity call in blk_integrity_unregister

Dragos Tatulea (1):
      net/mlx5e: SHAMPO, Fix incorrect page release

Eric Biggers (1):
      ext4: reject casefold inode flag without casefold feature

Frederic Weisbecker (1):
      rcu/nocb: Remove buggy bypass lock contention mitigation

Geliang Tang (1):
      mptcp: make pm_remove_addrs_and_subflows static

Greg Kroah-Hartman (1):
      Linux 6.1.109

Haoran Liu (1):
      drm/meson: plane: Add error handling

Hersen Wu (4):
      drm/amd/display: Stop amdgpu_dm initialize when stream nums greater than 6
      drm/amd/display: Add array index check for hdcp ddc access
      drm/amd/display: Fix Coverity INTEGER_OVERFLOW within dal_gpio_service_create
      drm/amd/display: Skip inactive planes within ModeSupportAndSystemConfiguration

Jagadeesh Kona (1):
      cpufreq: scmi: Avoid overflow of target_freq in fast switch

Jan Kara (2):
      udf: Limit file size to 4TB
      ext4: handle redirtying in ext4_bio_write_page()

Jeff Johnson (1):
      wifi: ath11k: initialize 'ret' in ath11k_qmi_load_file_target_mem()

Jesse Zhang (9):
      drm/amd/pm: fix uninitialized variable warning
      drm/amd/pm: fix warning using uninitialized value of max_vid_step
      drm/amd/pm: Fix negative array index read
      drm/amd/pm: fix the Out-of-bounds read warning
      drm/amdgpu: fix dereference after null check
      drm/amdgpu: fix the waring dereferencing hive
      drm/amd/pm: check specific index for aldebaran
      drm/amdgpu: the warning dereferencing obj for nbio_v7_4
      drm/amd/pm: check negtive return for table entries

Johannes Berg (1):
      wifi: cfg80211: make hash table duplicates more survivable

Julien Stephan (1):
      driver: iio: add missing checks on iio_info's callback access

Ken Sloat (1):
      pwm: xilinx: Fix u32 overflow issue in 32-bit width PWM mode.

Krzysztof Stępniak (1):
      ASoC: amd: yc: Support mic on Lenovo Thinkpad E14 Gen 6

Leesoo Ahn (1):
      apparmor: fix possible NULL pointer dereference

Luiz Augusto von Dentz (1):
      Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm

Ma Jun (7):
      drm/amdgpu: Fix uninitialized variable warning in amdgpu_afmt_acr
      drm/amdgpu/pm: Check the return value of smum_send_msg_to_smc
      drm/amdgpu/pm: Fix uninitialized variable warning for smu10
      drm/amdgpu/pm: Fix uninitialized variable agc_btc_response
      drm/amdgpu: Fix out-of-bounds write warning
      drm/amdgpu: Fix out-of-bounds read of df_v1_7_channel_number
      drm/amdgpu/pm: Check input value for CUSTOM profile mode setting on legacy SOCs

Marek Vasut (1):
      drm/bridge: tc358767: Check if fully initialized before signalling HPD event via IRQ

Matthieu Baerts (NGI0) (17):
      mptcp: pm: fix RM_ADDR ID for the initial subflow
      mptcp: pm: fullmesh: select the right ID later
      mptcp: pm: avoid possible UaF when selecting endp
      mptcp: pm: reuse ID 0 after delete and re-add
      mptcp: pm: fix ID 0 endp usage after multiple re-creations
      selftests: mptcp: join: validate fullmesh endp on 1st sf
      selftests: mptcp: join: check re-using ID of closed subflow
      selftests: mptcp: add explicit test case for remove/readd
      selftests: mptcp: join: test for flush/re-add endpoints
      selftests: mptcp: join: check re-using ID of unused ADD_ADDR
      selftests: mptcp: join: check re-adding init endp with != id
      mptcp: pr_debug: add missing \n at the end
      mptcp: avoid duplicated SUB_CLOSED events
      selftests: mptcp: join: check removing ID 0 endpoint
      selftests: mptcp: join: no extra msg if no counter
      selftests: mptcp: join: check re-re-adding ID 0 endp
      selftests: mptcp: join: cannot rm sf if closed

Michael Chen (1):
      drm/amdkfd: Reconcile the definition and use of oem_id in struct kfd_topology_device

Michael Margolin (1):
      RDMA/efa: Properly handle unexpected AQ completions

Mostafa Saleh (1):
      PCI/MSI: Fix UAF in msi_capability_init

Olivier Dautricourt (2):
      dmaengine: altera-msgdma: use irq variant of spin_lock/unlock while invoking callbacks
      dmaengine: altera-msgdma: properly free descriptor in msgdma_free_descriptor

Pauli Virtanen (1):
      Bluetooth: SCO: fix sco_conn related locking and validity issues

Peter Wang (1):
      scsi: ufs: core: Bypass quick recovery if force reset is needed

Philip Mueller (1):
      drm: panel-orientation-quirks: Add quirk for OrangePi Neo

Ricardo Ribalda (1):
      media: uvcvideo: Enforce alignment of frame and interval

Richard Fitzgerald (2):
      i2c: Fix conditional for substituting empty ACPI functions
      i2c: Use IS_REACHABLE() for substituting empty ACPI functions

Richard Maina (1):
      hwspinlock: Introduce hwspin_lock_bust()

Rik van Riel (1):
      dma-debug: avoid deadlock between dma debug vs printk and netconsole

Shahar S Matityahu (1):
      wifi: iwlwifi: remove fw_running op

Shannon Nelson (1):
      ionic: fix potential irq name truncation

Simon Holesch (1):
      usbip: Don't submit special requests twice

Takashi Iwai (2):
      ALSA: hda/generic: Add a helper to mute speakers at suspend/shutdown
      ALSA: hda/conexant: Mute speakers at suspend / shutdown

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

Yazen Ghannam (1):
      hwmon: (k10temp) Check return value of amd_smn_read()

ZHANG Yuntian (1):
      net: usb: qmi_wwan: add MeiG Smart SRM825L

Zhigang Luo (1):
      drm/amdgpu: avoid reading vf2pf info size from FB

Zong-Zhe Yang (1):
      wifi: rtw89: ser: avoid multiple deinit on same CAM

winstang (1):
      drm/amd/display: added NULL check at start of dc_validate_stream

zhanchengbin (1):
      ext4: fix inode tree inconsistency caused by ENOMEM


