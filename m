Return-Path: <stable+bounces-165717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E472B17F54
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 11:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153103B5FD5
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65192253A7;
	Fri,  1 Aug 2025 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S63z+e0D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2978F58;
	Fri,  1 Aug 2025 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040771; cv=none; b=Rlg4Szn6gnUlWte3DJUXtaTFVWD36teP+Rqif6LcDehBghSxzdIrLEsoeKUf7WxbdQ5r2kdHIEq9UAZqeMU733sLgqwVhpaXeNQjdZpyHvJ/9lxwHclRCqVyELBw/5IIqRk8cwMOcafp7iJwA+md3j1dO2sNCGB+u4pEkAvoDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040771; c=relaxed/simple;
	bh=eiqaLq3RtG+Ff+hrJ3FvvqiTG8TbnTbVBk9r1Wnw5Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jTEVeDfpI8+bRgu1UKLGxfBAtqQ0cjiOSHvfUQSjdNLyonIYthzEoQejtf6cXyD6AEsJYWZSZHQfW1kiGc9r1Ph4whbI8M5pmFBJOi7gGg/crnzKzABrznVtTRkNuEe+VeLGcUilZqzgxE/VElN8SjuC7GShFvyrtWfkh4khtNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S63z+e0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC4AC4CEE7;
	Fri,  1 Aug 2025 09:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754040770;
	bh=eiqaLq3RtG+Ff+hrJ3FvvqiTG8TbnTbVBk9r1Wnw5Q8=;
	h=From:To:Cc:Subject:Date:From;
	b=S63z+e0DX10h5g/gJHamYKYTpPEvQVHOKnL5cNZAv1MnMuiRqPWa/yGvia9WlsY6S
	 1ynTzCaXy8Z6aj5xqymF+vpjjkCq3EWnrWsQNISbL/VRO2MKbrbaWb1xJmx56D79CA
	 NCS0ygSOgRZxGyyAU+QgS0tZGeAhG4sdurEC12+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.101
Date: Fri,  1 Aug 2025 10:32:44 +0100
Message-ID: <2025080145-uncounted-decency-3943@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.101 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                      |    2 
 arch/arm/Makefile                                             |    2 
 arch/arm64/include/asm/assembler.h                            |    5 
 arch/arm64/kernel/cpufeature.c                                |    1 
 arch/arm64/kernel/entry.S                                     |    6 
 arch/powerpc/crypto/Kconfig                                   |    1 
 arch/x86/events/intel/core.c                                  |    2 
 arch/x86/hyperv/irqdomain.c                                   |    4 
 arch/x86/kernel/cpu/amd.c                                     |    2 
 drivers/base/regmap/regmap.c                                  |    2 
 drivers/bus/fsl-mc/fsl-mc-bus.c                               |   19 -
 drivers/comedi/drivers/comedi_test.c                          |    2 
 drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c               |    9 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                          |   47 ++--
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                         |    2 
 drivers/gpu/drm/i915/display/intel_dp.c                       |    6 
 drivers/gpu/drm/scheduler/sched_entity.c                      |   25 --
 drivers/i2c/busses/i2c-qup.c                                  |    4 
 drivers/i2c/busses/i2c-tegra.c                                |   24 --
 drivers/i2c/busses/i2c-virtio.c                               |   15 -
 drivers/iio/adc/ad7949.c                                      |    7 
 drivers/iio/light/hid-sensor-prox.c                           |    8 
 drivers/infiniband/core/cache.c                               |    4 
 drivers/input/keyboard/gpio_keys.c                            |    4 
 drivers/interconnect/qcom/sc7280.c                            |    1 
 drivers/mtd/nand/raw/qcom_nandc.c                             |   12 -
 drivers/net/can/dev/dev.c                                     |   31 +-
 drivers/net/can/dev/netlink.c                                 |   12 +
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c              |   15 +
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c           |   15 +
 drivers/net/ethernet/google/gve/gve_main.c                    |   67 +++---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c               |   31 ++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h               |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c       |   36 +--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c        |    9 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c     |    6 
 drivers/net/ethernet/intel/e1000e/defines.h                   |    3 
 drivers/net/ethernet/intel/e1000e/ich8lan.c                   |    2 
 drivers/net/ethernet/intel/e1000e/nvm.c                       |    6 
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                |    3 
 drivers/net/ethernet/intel/i40e/i40e_main.c                   |   18 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c            |    8 
 drivers/net/ethernet/intel/ice/ice_ddp.c                      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                 |    4 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c    |  108 +++++-----
 drivers/net/wireless/mediatek/mt76/mt7921/main.c              |    3 
 drivers/platform/x86/Makefile                                 |    3 
 drivers/platform/x86/ideapad-laptop.c                         |    2 
 drivers/regulator/core.c                                      |    1 
 drivers/s390/net/ism_drv.c                                    |    3 
 drivers/spi/spi-cadence-quadspi.c                             |    5 
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c |    3 
 drivers/usb/typec/tcpm/tcpm.c                                 |   64 +++--
 drivers/virtio/virtio_ring.c                                  |    8 
 fs/erofs/decompressor.c                                       |    6 
 fs/erofs/zdata.c                                              |   32 +-
 fs/jfs/jfs_imap.c                                             |   13 +
 fs/nilfs2/inode.c                                             |    9 
 fs/smb/server/connection.c                                    |    4 
 fs/smb/server/connection.h                                    |    1 
 fs/smb/server/transport_rdma.c                                |   10 
 fs/smb/server/transport_tcp.c                                 |   15 -
 fs/smb/server/transport_tcp.h                                 |    1 
 include/linux/ism.h                                           |    1 
 include/linux/sprintf.h                                       |    1 
 kernel/resource.c                                             |    5 
 mm/kasan/report.c                                             |    4 
 mm/khugepaged.c                                               |    4 
 mm/zsmalloc.c                                                 |    3 
 net/appletalk/aarp.c                                          |   24 +-
 net/mptcp/options.c                                           |    3 
 net/mptcp/pm.c                                                |    8 
 net/mptcp/protocol.c                                          |   58 ++++-
 net/mptcp/protocol.h                                          |   27 +-
 net/mptcp/subflow.c                                           |   30 +-
 net/sched/sch_qfq.c                                           |    7 
 net/xfrm/xfrm_interface_core.c                                |    7 
 sound/pci/hda/hda_tegra.c                                     |   51 ++++
 sound/pci/hda/patch_hdmi.c                                    |   20 +
 sound/pci/hda/patch_realtek.c                                 |    1 
 tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c  |   73 ------
 tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c  |    7 
 tools/testing/selftests/net/mptcp/Makefile                    |    3 
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh   |    5 
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh       |    5 
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh   |    5 
 86 files changed, 680 insertions(+), 449 deletions(-)

Abdun Nihaal (1):
      regmap: fix potential memory leak of regmap_bus

Ada Couprie Diaz (1):
      arm64/entry: Mask DAIF in cpu_switch_to(), call_on_irq_stack()

Akhil R (1):
      i2c: tegra: Fix reset error handling with ACPI

Akinobu Mita (1):
      resource: fix false warning in __request_region()

Alessandro Carminati (1):
      regulator: core: fix NULL dereference on unbind due to stale coupling data

Chiara Meiohas (1):
      net/mlx5: Fix memory leak in cmd_exec()

Daniel Dadap (1):
      ALSA: hda: Add missing NVIDIA HDA codec IDs

David Lechner (1):
      iio: adc: ad7949: use spi_is_bpw_supported()

Dawid Rezler (1):
      ALSA: hda/realtek - Add mute LED support for HP Pavilion 15-eg0xxx

Dennis Chen (1):
      i40e: report VF tx_dropped with tx_errors instead of tx_discards

Deren Wu (1):
      wifi: mt76: mt7921: prevent decap offload config before STA initialization

Dmitry Antipov (1):
      jfs: reject on-disk inodes of an unsupported type

Douglas Anderson (1):
      drm/bridge: ti-sn65dsi86: Remove extra semicolon in ti_sn_bridge_probe()

Eric Biggers (1):
      crypto: powerpc/poly1305 - add depends on BROKEN for now

Eyal Birger (1):
      xfrm: interface: fix use-after-free after changing collect_md xfrm interface

Fabrice Gasnier (1):
      Input: gpio-keys - fix a sleep while atomic with PREEMPT_RT

Gao Xiang (1):
      erofs: address D-cache aliasing

Giovanni Cabiddu (1):
      crypto: qat - add shutdown handler to qat_dh895xcc

Greg Kroah-Hartman (1):
      Linux 6.6.101

Halil Pasic (1):
      s390/ism: fix concurrency management in ism_cmd()

Haoxiang Li (1):
      ice: Fix a null pointer dereference in ice_copy_and_init_pkg()

Harry Yoo (1):
      mm/zsmalloc: do not pass __GFP_MOVABLE if CONFIG_COMPACTION=n

Ian Abbott (1):
      comedi: comedi_test: Fix possible deletion of uninitialized timers

Jacek Kowalski (2):
      e1000e: disregard NVM checksum on tgp when valid checksum bit is not set
      e1000e: ignore uninitialized checksum word on tgp

Jamie Bainbridge (1):
      i40e: When removing VF MAC filters, only check PF-set MAC

Jian Shen (2):
      net: hns3: fix concurrent setting vlan filter issue
      net: hns3: fixed vf get max channels bug

Jijie Shao (1):
      net: hns3: default enable tx bounce buffer when smmu enabled

Kan Liang (1):
      perf/x86/intel: Fix crash in icl_update_topdown_event()

Khairul Anuar Romli (1):
      spi: cadence-quadspi: fix cleanup of rx_chan on failure paths

Kito Xu (veritas501) (1):
      net: appletalk: Fix use-after-free in AARP proxy probe

Laurent Vivier (1):
      virtio_ring: Fix error reporting in virtqueue_resize

Lin.Cao (1):
      drm/sched: Remove optimization that causes hang when killing dependent jobs

Liu Shixin (1):
      mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma

Ma Ke (3):
      bus: fsl-mc: Fix potential double device reference in fsl_mc_get_endpoint()
      dpaa2-eth: Fix device reference count leak in MAC endpoint handling
      dpaa2-switch: Fix device reference count leak in MAC endpoint handling

Maor Gottlieb (1):
      RDMA/core: Rate limit GID cache warning messages

Marc Kleine-Budde (3):
      can: dev: can_restart(): reverse logic to remove need for goto
      can: dev: can_restart(): move debug message and stats after successful restart
      can: netlink: can_changelink(): fix NULL pointer deref of struct can_priv::do_set_mode

Marco Elver (1):
      kasan: use vmalloc_dump_obj() for vmalloc error reports

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: connect: also cover alt modes
      selftests: mptcp: connect: also cover checksum

Md Sadre Alam (1):
      mtd: rawnand: qcom: Fix last codeword read in qcom_param_page_type_exec()

Michael Grzeschik (2):
      usb: typec: tcpm: allow to use sink in accessory mode
      usb: typec: tcpm: allow switching to mode accessory to mux properly

Michael Zhivich (1):
      x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()

Mohan Kumar D (1):
      ALSA: hda/tegra: Add Tegra264 support

Namjae Jeon (2):
      ksmbd: fix use-after-free in __smb2_lease_break_noti()
      ksmbd: add free_transport ops in ksmbd connection

Nathan Chancellor (1):
      ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS

Nianyao Tang (1):
      arm64/cpufeatures/kvm: Add ARMv8.9 FEAT_ECBHB bits in ID_AA64MMFR1 register

Nuno Das Neves (1):
      x86/hyperv: Fix usage of cpu_online_mask to get valid cpu

Paolo Abeni (3):
      mptcp: make fallback action and fallback decision atomic
      mptcp: plug races between subflow fail and subflow creation
      mptcp: reset fallback status gracefully at disconnect() time

Philip Yang (1):
      drm/amdkfd: Don't call mmput from MMU notifier callback

Praveen Kaligineedi (1):
      gve: Fix stuck TX queue for DQ queue format

RD Babiera (1):
      usb: typec: tcpm: apply vbus before data bringup in tcpm_src_attach

Rong Zhang (1):
      platform/x86: ideapad-laptop: Fix kbd backlight not remembered among boots

Ryusuke Konishi (1):
      nilfs2: reject invalid file types when reading inodes

Shahar Shitrit (1):
      net/mlx5: E-Switch, Fix peer miss rules to use peer eswitch

Shung-Hsi Yu (1):
      Revert "selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid() test"

Stefan Wahren (1):
      staging: vchiq_arm: Make vchiq_shutdown never fail

Stephen Rothwell (1):
      sprintf.h requires stdarg.h

Torsten Hilbrich (1):
      platform/x86: Fix initialization order for firmware_attributes_class

Ville Syrjälä (1):
      drm/i915/dp: Fix 2.7 Gbps DP_LINK_BW value on g4x

Viresh Kumar (1):
      i2c: virtio: Avoid hang by using interruptible completion wait

Xiang Mei (1):
      net/sched: sch_qfq: Avoid triggering might_sleep in atomic context in qfq_delete_class

Xilin Wu (1):
      interconnect: qcom: sc7280: Add missing num_links to xm_pcie3_1 node

Yajun Deng (1):
      i40e: Add rx_missed_errors for buffer exhaustion

Yang Xiwen (1):
      i2c: qup: jump out of the loop in case of timeout

Yonglong Liu (1):
      net: hns3: disable interrupt when ptp init failed

Zhang Lixu (2):
      iio: hid-sensor-prox: Fix incorrect OFFSET calculation
      iio: hid-sensor-prox: Restore lost scale assignments


