Return-Path: <stable+bounces-165719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E54B17F57
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 11:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AC51C8174C
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F7A22B8BD;
	Fri,  1 Aug 2025 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jy9PYMZV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FDA22652D;
	Fri,  1 Aug 2025 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040780; cv=none; b=h6DknpkJ+ZaRRpMxwu2QjA+DgngpNf1IouXld2B2x1INozgUYpngwFBbUCNgNHw1J7Fy8cOOqvrggil6tk4AtFl5E/JbPc6lElk1iE/4qSiC8Ys2ae06FGV93WSDEr7o4sbeyxrFUK79NuGaky8PbiOfFY+X8HkUccviqlGM9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040780; c=relaxed/simple;
	bh=w0b9A2//yHahjlvYwynAxN94tRgdlWGEYU/ewgKDmLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UtO7gVnPH1trBN8521jccTciYald1vGsKZAcd1D5Fc+FoqRMlff4nkviJOZRTKvp5XKRqKnZ/0SX8/Mo3/8kr82bCX8LJWqEsFsrGKyvhFgEl4zASK/Gtfb0RZLc3Ugm5kHV0twabkD7I/1ndsOUVJlsT4NN8WbQ/iU84lujr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jy9PYMZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010A9C4CEF8;
	Fri,  1 Aug 2025 09:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754040780;
	bh=w0b9A2//yHahjlvYwynAxN94tRgdlWGEYU/ewgKDmLs=;
	h=From:To:Cc:Subject:Date:From;
	b=jy9PYMZVWo6FQ6B/6tyOx8l7YnvnHI6Helq1ZS5HME34n5SqxV/nKNiSRW25HXTj4
	 jRJuadxaitORvI0Ie0ztcobLRRWdmpG1SsS5vAG6kX5lxqsYA2qlgoABLj3nXbnRe4
	 DW7gxojavhUo8TFgMdScWqF9kR8KQLFZsPGVnn9Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.41
Date: Fri,  1 Aug 2025 10:32:50 +0100
Message-ID: <2025080151-frozen-sector-d28f@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.41 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 .clippy.toml                                                  |    2 
 Makefile                                                      |    2 
 arch/arm/Kconfig                                              |    2 
 arch/arm/Makefile                                             |    2 
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts    |    2 
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts                     |    4 
 arch/arm64/include/asm/assembler.h                            |    5 
 arch/arm64/kernel/entry.S                                     |    6 
 arch/powerpc/crypto/Kconfig                                   |    1 
 arch/x86/hyperv/hv_init.c                                     |   33 
 arch/x86/hyperv/hv_vtl.c                                      |   44 
 arch/x86/hyperv/irqdomain.c                                   |    4 
 arch/x86/hyperv/ivm.c                                         |   22 
 arch/x86/include/asm/debugreg.h                               |   19 
 arch/x86/include/asm/kvm_host.h                               |    2 
 arch/x86/include/asm/mshyperv.h                               |    6 
 arch/x86/kernel/cpu/amd.c                                     |    2 
 arch/x86/kernel/cpu/common.c                                  |    2 
 arch/x86/kernel/kgdb.c                                        |    2 
 arch/x86/kernel/process_32.c                                  |    2 
 arch/x86/kernel/process_64.c                                  |    2 
 arch/x86/kvm/cpuid.h                                          |    1 
 arch/x86/kvm/emulate.c                                        |   15 
 arch/x86/kvm/hyperv.c                                         |    3 
 arch/x86/kvm/kvm_emulate.h                                    |    5 
 arch/x86/kvm/mmu.h                                            |    1 
 arch/x86/kvm/mmu/mmu.c                                        |    2 
 arch/x86/kvm/mtrr.c                                           |    1 
 arch/x86/kvm/vmx/hyperv.c                                     |    1 
 arch/x86/kvm/vmx/nested.c                                     |   24 
 arch/x86/kvm/vmx/pmu_intel.c                                  |    2 
 arch/x86/kvm/vmx/sgx.c                                        |    5 
 arch/x86/kvm/vmx/vmx.c                                        |    4 
 arch/x86/kvm/x86.c                                            |   19 
 arch/x86/kvm/x86.h                                            |   48 
 drivers/base/regmap/regmap.c                                  |    2 
 drivers/bus/fsl-mc/fsl-mc-bus.c                               |   19 
 drivers/comedi/drivers/comedi_test.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h                       |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                  |   17 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                         |    2 
 drivers/gpu/drm/drm_buddy.c                                   |   43 
 drivers/gpu/drm/i915/display/intel_dp.c                       |    6 
 drivers/gpu/drm/scheduler/sched_entity.c                      |   21 
 drivers/gpu/drm/xe/tests/xe_mocs.c                            |   21 
 drivers/gpu/drm/xe/xe_devcoredump.c                           |   14 
 drivers/gpu/drm/xe/xe_force_wake.h                            |   16 
 drivers/gpu/drm/xe/xe_gt.c                                    |  105 --
 drivers/hv/vmbus_drv.c                                        |    2 
 drivers/i2c/busses/i2c-qup.c                                  |    4 
 drivers/i2c/busses/i2c-tegra.c                                |   24 
 drivers/i2c/busses/i2c-virtio.c                               |   15 
 drivers/iio/adc/ad7949.c                                      |    7 
 drivers/iio/light/hid-sensor-prox.c                           |    8 
 drivers/infiniband/core/cache.c                               |    4 
 drivers/input/keyboard/gpio_keys.c                            |    4 
 drivers/interconnect/qcom/sc7280.c                            |    1 
 drivers/mtd/nand/raw/qcom_nandc.c                             |   12 
 drivers/net/can/dev/dev.c                                     |   12 
 drivers/net/can/dev/netlink.c                                 |   12 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c              |   15 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c           |   15 
 drivers/net/ethernet/google/gve/gve_main.c                    |   67 -
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c               |   31 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h               |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c       |   36 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c        |    9 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c     |    6 
 drivers/net/ethernet/intel/e1000e/defines.h                   |    3 
 drivers/net/ethernet/intel/e1000e/ich8lan.c                   |    2 
 drivers/net/ethernet/intel/e1000e/nvm.c                       |    6 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c            |    6 
 drivers/net/ethernet/intel/ice/ice_ddp.c                      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                 |    4 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c    |  108 +-
 drivers/net/ethernet/ti/icssg/icssg_config.c                  |  158 ++-
 drivers/net/ethernet/ti/icssg/icssg_config.h                  |   80 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c                  |   20 
 drivers/net/ethernet/ti/icssg/icssg_prueth.h                  |    2 
 drivers/net/ethernet/ti/icssg/icssg_switch_map.h              |    3 
 drivers/net/virtio_net.c                                      |    6 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c              |   76 -
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c               |  106 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h               |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h            |    2 
 drivers/platform/mellanox/mlxbf-pmc.c                         |   25 
 drivers/platform/x86/Makefile                                 |    3 
 drivers/platform/x86/asus-nb-wmi.c                            |    9 
 drivers/platform/x86/ideapad-laptop.c                         |    4 
 drivers/regulator/core.c                                      |    1 
 drivers/s390/net/ism_drv.c                                    |    3 
 drivers/spi/spi-cadence-quadspi.c                             |    5 
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c |    3 
 drivers/usb/typec/tcpm/tcpm.c                                 |   64 -
 drivers/virtio/virtio_ring.c                                  |    8 
 fs/erofs/internal.h                                           |   13 
 fs/erofs/zdata.c                                              |    2 
 fs/erofs/zmap.c                                               |  246 +---
 fs/ext4/ext4.h                                                |    2 
 fs/ext4/extents.c                                             |  518 +++-------
 fs/ext4/inode.c                                               |  140 +-
 fs/jfs/jfs_imap.c                                             |   13 
 fs/nilfs2/inode.c                                             |    9 
 include/drm/drm_buddy.h                                       |    2 
 include/linux/ism.h                                           |    1 
 include/linux/sprintf.h                                       |    1 
 kernel/bpf/verifier.c                                         |    7 
 kernel/resource.c                                             |    5 
 kernel/time/timekeeping.c                                     |    2 
 mm/kasan/report.c                                             |    4 
 mm/khugepaged.c                                               |    4 
 mm/ksm.c                                                      |    6 
 mm/memory-failure.c                                           |    4 
 mm/vmscan.c                                                   |    8 
 mm/zsmalloc.c                                                 |    3 
 net/appletalk/aarp.c                                          |   24 
 net/ipv4/xfrm4_input.c                                        |    3 
 net/ipv6/xfrm6_input.c                                        |    3 
 net/sched/sch_qfq.c                                           |    7 
 net/xfrm/xfrm_interface_core.c                                |    7 
 net/xfrm/xfrm_state.c                                         |   23 
 sound/pci/hda/hda_tegra.c                                     |   51 
 sound/pci/hda/patch_hdmi.c                                    |   20 
 sound/pci/hda/patch_realtek.c                                 |    4 
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c                    |    3 
 tools/hv/hv_fcopy_uio_daemon.c                                |   37 
 tools/testing/selftests/bpf/progs/verifier_precision.c        |   53 +
 tools/testing/selftests/drivers/net/lib/py/load.py            |   23 
 tools/testing/selftests/net/mptcp/Makefile                    |    3 
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh   |    5 
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh       |    5 
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh   |    5 
 133 files changed, 1608 insertions(+), 1223 deletions(-)

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

Dmitry Antipov (1):
      jfs: reject on-disk inodes of an unsupported type

Douglas Anderson (1):
      drm/bridge: ti-sn65dsi86: Remove extra semicolon in ti_sn_bridge_probe()

Edip Hazuri (1):
      ALSA: hda/realtek - Add mute LED support for HP Victus 15-fa0xxx

Eric Biggers (1):
      crypto: powerpc/poly1305 - add depends on BROKEN for now

Eyal Birger (1):
      xfrm: interface: fix use-after-free after changing collect_md xfrm interface

Fabrice Gasnier (1):
      Input: gpio-keys - fix a sleep while atomic with PREEMPT_RT

Gao Xiang (5):
      erofs: simplify z_erofs_load_compact_lcluster()
      erofs: refine z_erofs_get_extent_compressedlen()
      erofs: simplify tail inline pcluster handling
      erofs: clean up header parsing for ztailpacking and fragments
      erofs: fix large fragment handling

Greg Kroah-Hartman (1):
      Linux 6.12.41

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

Hongzhen Luo (1):
      erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify switches

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

Jinjiang Tu (1):
      mm/vmscan: fix hwpoisoned large folio handling in shrink_folio_list

Johan Hovold (1):
      arm64: dts: qcom: x1e78100-t14s: mark l12b and l15b always-on

Khairul Anuar Romli (1):
      spi: cadence-quadspi: fix cleanup of rx_chan on failure paths

Kito Xu (veritas501) (1):
      net: appletalk: Fix use-after-free in AARP proxy probe

Laurent Vivier (2):
      virtio_net: Enforce minimum TX ring size for reliability
      virtio_ring: Fix error reporting in virtqueue_resize

Lin.Cao (1):
      drm/sched: Remove optimization that causes hang when killing dependent jobs

Liu Shixin (1):
      mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma

Ma Ke (3):
      bus: fsl-mc: Fix potential double device reference in fsl_mc_get_endpoint()
      dpaa2-eth: Fix device reference count leak in MAC endpoint handling
      dpaa2-switch: Fix device reference count leak in MAC endpoint handling

Manuel Andreas (1):
      KVM: x86/hyper-v: Skip non-canonical addresses during PV TLB flush

Maor Gottlieb (1):
      RDMA/core: Rate limit GID cache warning messages

Marc Kleine-Budde (1):
      can: netlink: can_changelink(): fix NULL pointer deref of struct can_priv::do_set_mode

Marco Elver (1):
      kasan: use vmalloc_dump_obj() for vmalloc error reports

Markus Blöchl (1):
      timekeeping: Zero initialize system_counterval when querying time from phc drivers

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: connect: also cover alt modes
      selftests: mptcp: connect: also cover checksum

Maxim Levitsky (4):
      KVM: x86: drop x86.h include from cpuid.h
      KVM: x86: Route non-canonical checks in emulator through emulate_ops
      KVM: x86: Add X86EMUL_F_MSR and X86EMUL_F_DT_LOAD to aid canonical checks
      KVM: x86: model canonical checks more precisely

Md Sadre Alam (1):
      mtd: rawnand: qcom: Fix last codeword read in qcom_param_page_type_exec()

Michael Grzeschik (2):
      usb: typec: tcpm: allow to use sink in accessory mode
      usb: typec: tcpm: allow switching to mode accessory to mux properly

Michael Zhivich (1):
      x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()

Miguel Ojeda (1):
      rust: give Clippy the minimum supported Rust version

Ming Yen Hsieh (1):
      wifi: mt76: mt7925: adjust rm BSS flow to prevent next connection failure

Mohan Kumar D (1):
      ALSA: hda/tegra: Add Tegra264 support

Naman Jain (1):
      Drivers: hv: Make the sysfs node size for the ring buffer dynamic

Nathan Chancellor (3):
      mm/ksm: fix -Wsometimes-uninitialized from clang-21 in advisor_mode_show()
      ARM: 9450/1: Fix allowing linker DCE with binutils < 2.36
      ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS

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

Roman Kisel (1):
      x86/hyperv: Fix APIC ID and VP index confusion in hv_snp_boot_ap()

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

Sean Christopherson (1):
      KVM: x86: Free vCPUs before freeing VM state

Sean Wang (1):
      Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO"

Shahar Shitrit (1):
      net/mlx5: E-Switch, Fix peer miss rules to use peer eswitch

Shravan Kumar Ramani (3):
      platform/mellanox: mlxbf-pmc: Remove newline char from event name input
      platform/mellanox: mlxbf-pmc: Validate event/enable input
      platform/mellanox: mlxbf-pmc: Use kstrtobool() to check 0/1 input

Stefan Wahren (1):
      staging: vchiq_arm: Make vchiq_shutdown never fail

Stephan Gerhold (1):
      arm64: dts: qcom: x1-crd: Fix vreg_l2j_1p2 voltage

Stephen Rothwell (1):
      sprintf.h requires stdarg.h

Tobias Brunner (1):
      xfrm: Set transport header to fix UDP GRO handling

Tomita Moeko (4):
      Revert "drm/xe/gt: Update handling of xe_force_wake_get return"
      Revert "drm/xe/tests/mocs: Update xe_force_wake_get() return handling"
      Revert "drm/xe/devcoredump: Update handling of xe_force_wake_get return"
      Revert "drm/xe/forcewake: Add a helper xe_force_wake_ref_has_domain()"

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

Zhang Lixu (2):
      iio: hid-sensor-prox: Restore lost scale assignments
      iio: hid-sensor-prox: Fix incorrect OFFSET calculation

Zhang Yi (11):
      ext4: don't explicit update times in ext4_fallocate()
      ext4: refactor ext4_punch_hole()
      ext4: refactor ext4_zero_range()
      ext4: refactor ext4_collapse_range()
      ext4: refactor ext4_insert_range()
      ext4: factor out ext4_do_fallocate()
      ext4: move out inode_lock into ext4_fallocate()
      ext4: move out common parts into ext4_fallocate()
      ext4: fix incorrect punch max_end
      ext4: correct the error handle in ext4_fallocate()
      ext4: fix out of bounds punch offset


