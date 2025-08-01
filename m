Return-Path: <stable+bounces-165722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A4FB17F5E
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 11:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECAAA83E74
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5D422B8B5;
	Fri,  1 Aug 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nYfqJeZ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CEA22A4F1;
	Fri,  1 Aug 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040793; cv=none; b=Xrf2vWDzdFv5R+8wogBy31FwITUbBIrFQVyO/04wgLHJ+kXgFYpXxTre+1jp6U/x74cTWMMBqY0n3jwr5Ik4LQwnjFGl2o3Y0NLrx+NIliZPe7N9V6+FvogBTSHG+HJdxaxA6X8MqSBo41h2NKpm2kqW2B7P03o6dVm5wz0TlE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040793; c=relaxed/simple;
	bh=hsNEby4PH3KHCmrBApYHZ6gtv+SzaJD1diA1/dXQDHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iX3Rg0c8iymZfXIlu0SCmdln+pqOKH93LW8da3bUdUCCUAzoi0zTIurFOEo58Ik4Tph5yvwzh6ml03u6i2kfIl0gCnUBa3c7JbD0MCmyQqp5UE4iOWwnFlU2vsZVsnjaWrpz5NCCZlBaWIAEcpZorydNJTp0BqZjZU1ss0CBt+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nYfqJeZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032A2C4CEF6;
	Fri,  1 Aug 2025 09:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754040793;
	bh=hsNEby4PH3KHCmrBApYHZ6gtv+SzaJD1diA1/dXQDHo=;
	h=From:To:Cc:Subject:Date:From;
	b=nYfqJeZ8DceGtsYAOnpT8e09hL/80F/7heZEp22cnvU4mb5XQ0fuA+Ufd2mh58t6j
	 9uit79rwDn0GaLl6D0xtUpZR8qk2bwGro2zz0KHZ0SamtY7164jIFerE/m+RruazV4
	 vLlFVs8fwUhtVqG1Dt3kikKvLl8lNxUB1kQ2dBjM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.15.9
Date: Fri,  1 Aug 2025 10:32:56 +0100
Message-ID: <2025080157-pancreas-fleshed-73c0@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.15.9 kernel.

All users of the 6.15 kernel series must upgrade.

The updated 6.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                      |    2 
 arch/arm/Kconfig                                              |    2 
 arch/arm/Makefile                                             |    2 
 arch/arm64/include/asm/assembler.h                            |    5 
 arch/arm64/kernel/entry.S                                     |    6 
 arch/x86/hyperv/irqdomain.c                                   |    4 
 arch/x86/include/asm/debugreg.h                               |   19 -
 arch/x86/include/asm/kvm_host.h                               |    2 
 arch/x86/kernel/cpu/common.c                                  |    2 
 arch/x86/kernel/kgdb.c                                        |    2 
 arch/x86/kernel/process_32.c                                  |    2 
 arch/x86/kernel/process_64.c                                  |    2 
 arch/x86/kvm/x86.c                                            |    4 
 drivers/base/regmap/regmap.c                                  |    2 
 drivers/bus/fsl-mc/fsl-mc-bus.c                               |   19 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c                      |   44 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h                      |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h                       |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                  |   17 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c             |   12 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                         |    2 
 drivers/gpu/drm/drm_buddy.c                                   |   43 ++
 drivers/gpu/drm/drm_gem_dma_helper.c                          |    2 
 drivers/gpu/drm/drm_gem_framebuffer_helper.c                  |    8 
 drivers/gpu/drm/drm_gem_shmem_helper.c                        |   10 
 drivers/gpu/drm/drm_prime.c                                   |    8 
 drivers/gpu/drm/i915/display/intel_dp.c                       |    6 
 drivers/gpu/drm/scheduler/sched_entity.c                      |   21 -
 drivers/gpu/drm/xe/xe_lrc.c                                   |   37 +-
 drivers/gpu/drm/xe/xe_lrc_types.h                             |    3 
 drivers/i2c/busses/i2c-qup.c                                  |    4 
 drivers/i2c/busses/i2c-tegra.c                                |   24 -
 drivers/i2c/busses/i2c-virtio.c                               |   15 
 drivers/iio/adc/ad7949.c                                      |    7 
 drivers/iio/industrialio-core.c                               |    5 
 drivers/infiniband/core/cache.c                               |    4 
 drivers/interconnect/icc-clk.c                                |    2 
 drivers/interconnect/qcom/sc7280.c                            |    1 
 drivers/net/can/dev/dev.c                                     |   12 
 drivers/net/can/dev/netlink.c                                 |   12 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c              |   15 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c           |   15 
 drivers/net/ethernet/google/gve/gve_main.c                    |   67 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c               |   31 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h               |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c       |   36 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c        |    9 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c     |    6 
 drivers/net/ethernet/intel/e1000e/defines.h                   |    3 
 drivers/net/ethernet/intel/e1000e/ich8lan.c                   |    2 
 drivers/net/ethernet/intel/e1000e/nvm.c                       |    6 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c            |    6 
 drivers/net/ethernet/intel/ice/ice_ddp.c                      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                 |    4 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c    |  108 +++---
 drivers/net/ethernet/ti/icssg/icssg_config.c                  |  158 ++++++----
 drivers/net/ethernet/ti/icssg/icssg_config.h                  |   80 ++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c                  |   20 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.h                  |    2 
 drivers/net/ethernet/ti/icssg/icssg_switch_map.h              |    3 
 drivers/net/virtio_net.c                                      |    6 
 drivers/pci/probe.c                                           |    7 
 drivers/platform/mellanox/mlxbf-pmc.c                         |   25 +
 drivers/platform/x86/Makefile                                 |    3 
 drivers/platform/x86/asus-nb-wmi.c                            |    9 
 drivers/platform/x86/dell/alienware-wmi-wmax.c                |    1 
 drivers/platform/x86/ideapad-laptop.c                         |    4 
 drivers/regulator/core.c                                      |    1 
 drivers/s390/net/ism_drv.c                                    |    3 
 drivers/spi/spi-cadence-quadspi.c                             |    5 
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c |    3 
 drivers/usb/typec/tcpm/tcpm.c                                 |   64 ++--
 drivers/virtio/virtio_ring.c                                  |    8 
 fs/nilfs2/inode.c                                             |    9 
 include/drm/drm_buddy.h                                       |    2 
 include/linux/ism.h                                           |    1 
 include/linux/sprintf.h                                       |    1 
 include/net/xfrm.h                                            |    2 
 kernel/bpf/verifier.c                                         |    7 
 kernel/resource.c                                             |    5 
 kernel/time/timekeeping.c                                     |    2 
 mm/kasan/report.c                                             |    4 
 mm/ksm.c                                                      |    6 
 mm/memory-failure.c                                           |    4 
 mm/vmscan.c                                                   |    8 
 mm/zsmalloc.c                                                 |    3 
 net/appletalk/aarp.c                                          |   24 +
 net/ipv4/xfrm4_input.c                                        |    3 
 net/ipv6/xfrm6_input.c                                        |    3 
 net/sched/sch_qfq.c                                           |    7 
 net/xfrm/xfrm_device.c                                        |    1 
 net/xfrm/xfrm_interface_core.c                                |    7 
 net/xfrm/xfrm_ipcomp.c                                        |    2 
 net/xfrm/xfrm_state.c                                         |   29 -
 net/xfrm/xfrm_user.c                                          |    1 
 sound/pci/hda/hda_tegra.c                                     |   51 ++-
 sound/pci/hda/patch_hdmi.c                                    |   20 +
 sound/pci/hda/patch_realtek.c                                 |    4 
 sound/soc/mediatek/common/mtk-soundcard-driver.c              |    4 
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c                    |    3 
 tools/hv/hv_fcopy_uio_daemon.c                                |   37 --
 tools/testing/selftests/bpf/progs/verifier_precision.c        |   53 +++
 tools/testing/selftests/drivers/net/lib/py/load.py            |   23 +
 tools/testing/selftests/mm/split_huge_page_test.c             |    3 
 tools/testing/selftests/net/mptcp/Makefile                    |    3 
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh   |    5 
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh       |    5 
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh   |    5 
 109 files changed, 996 insertions(+), 450 deletions(-)

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

Arunpravin Paneer Selvam (1):
      drm/amdgpu: Reset the clear flag in buddy during resume

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

Dmitry Osipenko (1):
      drm/shmem-helper: Remove obsoleted is_iomem test

Douglas Anderson (1):
      drm/bridge: ti-sn65dsi86: Remove extra semicolon in ti_sn_bridge_probe()

Edip Hazuri (1):
      ALSA: hda/realtek - Add mute LED support for HP Victus 15-fa0xxx

Eyal Birger (1):
      xfrm: interface: fix use-after-free after changing collect_md xfrm interface

Fernando Fernandez Mancera (1):
      xfrm: ipcomp: adjust transport header after decompressing

Gabor Juhos (1):
      interconnect: icc-clk: destroy nodes in case of memory allocation failures

Greg Kroah-Hartman (1):
      Linux 6.15.9

Guoqing Jiang (1):
      ASoC: mediatek: mt8365-dai-i2s: pass correct size to mt8365_dai_set_priv

Halil Pasic (1):
      s390/ism: fix concurrency management in ism_cmd()

Haoxiang Li (1):
      ice: Fix a null pointer dereference in ice_copy_and_init_pkg()

Harry Yoo (1):
      mm/zsmalloc: do not pass __GFP_MOVABLE if CONFIG_COMPACTION=n

Himanshu Mittal (1):
      net: ti: icssg-prueth: Fix buffer allocation for ICSSG

Jacek Kowalski (2):
      e1000e: disregard NVM checksum on tgp when valid checksum bit is not set
      e1000e: ignore uninitialized checksum word on tgp

Jamie Bainbridge (1):
      i40e: When removing VF MAC filters, only check PF-set MAC

Jesse Zhang (1):
      drm/amdgpu: Fix SDMA engine reset with logical instance ID

Jesse.zhang@amd.com (2):
      drm/amdgpu: Add the new sdma function pointers for amdgpu_sdma.h
      drm/amdgpu: Implement SDMA soft reset directly for v5.x

Jian Shen (2):
      net: hns3: fix concurrent setting vlan filter issue
      net: hns3: fixed vf get max channels bug

Jijie Shao (1):
      net: hns3: default enable tx bounce buffer when smmu enabled

Jinjiang Tu (1):
      mm/vmscan: fix hwpoisoned large folio handling in shrink_folio_list

Johan Hovold (1):
      ASoC: mediatek: common: fix device and OF node leak

Khairul Anuar Romli (1):
      spi: cadence-quadspi: fix cleanup of rx_chan on failure paths

Kito Xu (veritas501) (1):
      net: appletalk: Fix use-after-free in AARP proxy probe

Kurt Borja (1):
      platform/x86: alienware-wmi-wmax: Fix `dmi_system_id` array

Laurent Vivier (2):
      virtio_net: Enforce minimum TX ring size for reliability
      virtio_ring: Fix error reporting in virtqueue_resize

Leon Romanovsky (1):
      xfrm: always initialize offload path

Lin.Cao (1):
      drm/sched: Remove optimization that causes hang when killing dependent jobs

Ma Ke (3):
      bus: fsl-mc: Fix potential double device reference in fsl_mc_get_endpoint()
      dpaa2-eth: Fix device reference count leak in MAC endpoint handling
      dpaa2-switch: Fix device reference count leak in MAC endpoint handling

Manivannan Sadhasivam (1):
      PCI/pwrctrl: Create pwrctrl devices only when CONFIG_PCI_PWRCTRL is enabled

Maor Gottlieb (1):
      RDMA/core: Rate limit GID cache warning messages

Marc Kleine-Budde (1):
      can: netlink: can_changelink(): fix NULL pointer deref of struct can_priv::do_set_mode

Marco Elver (1):
      kasan: use vmalloc_dump_obj() for vmalloc error reports

Mario Limonciello (1):
      drm/amd/display: Don't allow OLED to go down to fully off

Markus Blöchl (1):
      timekeeping: Zero initialize system_counterval when querying time from phc drivers

Markus Burri (1):
      iio: fix potential out-of-bound write

Matthew Brost (1):
      drm/xe: Make WA BB part of LRC BO

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: connect: also cover alt modes
      selftests: mptcp: connect: also cover checksum

Michael Grzeschik (2):
      usb: typec: tcpm: allow to use sink in accessory mode
      usb: typec: tcpm: allow switching to mode accessory to mux properly

Mohan Kumar D (1):
      ALSA: hda/tegra: Add Tegra264 support

Nathan Chancellor (3):
      mm/ksm: fix -Wsometimes-uninitialized from clang-21 in advisor_mode_show()
      ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS
      ARM: 9450/1: Fix allowing linker DCE with binutils < 2.36

Nimrod Oren (1):
      selftests: drv-net: wait for iperf client to stop sending

Nuno Das Neves (1):
      x86/hyperv: Fix usage of cpu_online_mask to get valid cpu

Praveen Kaligineedi (1):
      gve: Fix stuck TX queue for DQ queue format

RD Babiera (1):
      usb: typec: tcpm: apply vbus before data bringup in tcpm_src_attach

Rahul Chandra (1):
      platform/x86: asus-nb-wmi: add DMI quirk for ASUS Zenbook Duo UX8406CA

Rong Zhang (2):
      platform/x86: ideapad-laptop: Fix FnLock not remembered among boots
      platform/x86: ideapad-laptop: Fix kbd backlight not remembered among boots

Ryusuke Konishi (1):
      nilfs2: reject invalid file types when reading inodes

SHARAN KUMAR M (1):
      ALSA: hda/realtek: Fix mute LED mask on HP OMEN 16 laptop

Sabrina Dubroca (2):
      xfrm: state: initialize state_ptrs earlier in xfrm_state_find
      xfrm: state: use a consistent pcpu_id in xfrm_state_find

Shahar Shitrit (1):
      net/mlx5: E-Switch, Fix peer miss rules to use peer eswitch

Shravan Kumar Ramani (3):
      platform/mellanox: mlxbf-pmc: Remove newline char from event name input
      platform/mellanox: mlxbf-pmc: Validate event/enable input
      platform/mellanox: mlxbf-pmc: Use kstrtobool() to check 0/1 input

Stefan Wahren (1):
      staging: vchiq_arm: Make vchiq_shutdown never fail

Stephen Rothwell (1):
      sprintf.h requires stdarg.h

Thomas Zimmermann (4):
      Revert "drm/prime: Use dma_buf from GEM object instance"
      Revert "drm/gem-framebuffer: Use dma_buf from GEM object instance"
      Revert "drm/gem-dma: Use dma_buf from GEM object instance"
      Revert "drm/gem-shmem: Use dma_buf from GEM object instance"

Tobias Brunner (1):
      xfrm: Set transport header to fix UDP GRO handling

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

Xin Li (Intel) (1):
      x86/traps: Initialize DR7 by writing its architectural reset value

Yang Xiwen (1):
      i2c: qup: jump out of the loop in case of timeout

Yasumasa Suenaga (1):
      tools/hv: fcopy: Fix incorrect file path conversion

Yonghong Song (1):
      selftests/bpf: Add tests with stack ptr register in conditional jmp

Yonglong Liu (1):
      net: hns3: disable interrupt when ptp init failed

Zi Yan (1):
      selftests/mm: fix split_huge_page_test for folio_split() tests


