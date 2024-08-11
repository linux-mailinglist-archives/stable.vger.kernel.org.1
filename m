Return-Path: <stable+bounces-66357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D8894E0F4
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 13:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8297B2102E
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 11:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52044436C;
	Sun, 11 Aug 2024 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jkAET4vJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883B1200CB;
	Sun, 11 Aug 2024 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723375382; cv=none; b=L6rFZpYYl6ZhxzBfcw9rSW8CZmcJRnRgYdtgpbUOUFbZh0VEnFvOajiwUqpEmPRgCnrs7qVizN659rl9j3YMwPclgqMvU6H/XxQWvHS41o+RMX7KFl11Ghgfuetb76F+g//XzPysaSWRD0odEWkLG4CjZz538T1U7wDnfDK0KPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723375382; c=relaxed/simple;
	bh=vzmv53yywXGJ+cP06Bjv0mvZDb9pLxf8Xg2kDHQgfSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=INMDFlAgUOHjPGBInqOTmPaP+5MDsCTpNVwryUtN1WHekYSFb8Rhbf53dqJ+u+AJbRdFshBeYoZqASUJEmcgHVhpTSQ5hKiTyl76dheR+NUgJX4S5OEcnDnd2hE+MuEQ9833sqoeThkinX/k5qPPRlu9ImDdM7anpDXIVs9PIQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jkAET4vJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17F3C32786;
	Sun, 11 Aug 2024 11:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723375382;
	bh=vzmv53yywXGJ+cP06Bjv0mvZDb9pLxf8Xg2kDHQgfSI=;
	h=From:To:Cc:Subject:Date:From;
	b=jkAET4vJIxChZbatJWzf+I9lhcgy6tKD/WWmiu2lV74/2g1730WZQ8e30lcg4Jgyd
	 pz8QoeYzMPqY4pxVBfhlnF+fcJa6VmLVQvErm6p9lXByzbxdZ0dgQl8bQiaQjnT8bv
	 AG5WhwQDTfLfRnR5LVMopCFOsy+p7A9FTSNQ7KJQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.45
Date: Sun, 11 Aug 2024 13:22:56 +0200
Message-ID: <2024081157-flammable-safely-7a20@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.45 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                         |    2 
 arch/arm/kernel/perf_callchain.c                                 |    3 
 arch/arm64/boot/dts/qcom/ipq8074.dtsi                            |    2 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                            |   36 -
 arch/arm64/boot/dts/qcom/sc7180.dtsi                             |   58 --
 arch/arm64/boot/dts/qcom/sc7280.dtsi                             |   60 --
 arch/arm64/boot/dts/qcom/sdm845.dtsi                             |   98 +---
 arch/arm64/include/asm/jump_label.h                              |    1 
 arch/arm64/kernel/jump_label.c                                   |   11 
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi               |   81 ++-
 arch/riscv/kernel/traps_misaligned.c                             |   46 --
 arch/riscv/mm/fault.c                                            |   17 
 arch/riscv/mm/init.c                                             |   15 
 arch/x86/include/asm/posted_intr.h                               |   88 ++++
 arch/x86/kvm/Makefile                                            |    4 
 arch/x86/kvm/vmx/hyperv.c                                        |  139 ------
 arch/x86/kvm/vmx/hyperv.h                                        |  217 ++++------
 arch/x86/kvm/vmx/nested.c                                        |   41 +
 arch/x86/kvm/vmx/posted_intr.h                                   |  101 ----
 arch/x86/kvm/vmx/vmx.c                                           |    2 
 arch/x86/kvm/vmx/vmx.h                                           |    2 
 arch/x86/kvm/vmx/vmx_onhyperv.c                                  |   36 +
 arch/x86/kvm/vmx/vmx_onhyperv.h                                  |  124 +++++
 arch/x86/kvm/vmx/vmx_ops.h                                       |    2 
 drivers/bluetooth/btintel.c                                      |    3 
 drivers/cpufreq/qcom-cpufreq-nvmem.c                             |   50 +-
 drivers/dma/fsl-edma-common.c                                    |   31 -
 drivers/dma/fsl-edma-common.h                                    |    6 
 drivers/dma/fsl-edma-main.c                                      |   25 -
 drivers/firmware/Kconfig                                         |    1 
 drivers/firmware/sysfb.c                                         |    2 
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c                    |    6 
 drivers/gpu/drm/i915/display/intel_hdcp_regs.h                   |    2 
 drivers/gpu/drm/i915/i915_perf.c                                 |   33 -
 drivers/gpu/drm/nouveau/nouveau_prime.c                          |    3 
 drivers/gpu/drm/virtio/virtgpu_submit.c                          |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c                            |   17 
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c                          |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c                             |   29 +
 drivers/hid/amd-sfh-hid/amd_sfh_client.c                         |   18 
 drivers/hid/wacom_wac.c                                          |    3 
 drivers/leds/led-triggers.c                                      |   32 -
 drivers/leds/trigger/ledtrig-timer.c                             |    5 
 drivers/net/ethernet/intel/ice/ice_txrx.c                        |    2 
 drivers/net/ethernet/intel/ice/ice_xsk.c                         |   19 
 drivers/net/ethernet/intel/igc/igc_main.c                        |   33 -
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                  |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c               |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c             |    7 
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c               |    5 
 drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c           |   10 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                |    2 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                   |    2 
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c          |    1 
 drivers/net/ethernet/realtek/r8169_main.c                        |    8 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                |    2 
 drivers/net/phy/micrel.c                                         |   34 -
 drivers/net/phy/realtek.c                                        |    7 
 drivers/net/usb/sr9700.c                                         |   11 
 drivers/pci/search.c                                             |   31 +
 drivers/perf/fsl_imx9_ddr_perf.c                                 |    6 
 drivers/perf/riscv_pmu_sbi.c                                     |    2 
 drivers/platform/chrome/cros_ec_proto.c                          |    2 
 drivers/thermal/broadcom/bcm2835_thermal.c                       |   25 -
 drivers/video/Kconfig                                            |    4 
 drivers/video/Makefile                                           |    4 
 drivers/video/fbdev/vesafb.c                                     |   66 +--
 drivers/video/screen_info_generic.c                              |  146 ++++++
 drivers/video/screen_info_pci.c                                  |  136 ++++++
 fs/btrfs/block-group.c                                           |   13 
 fs/btrfs/extent-tree.c                                           |    3 
 fs/btrfs/free-space-cache.c                                      |    4 
 fs/btrfs/space-info.c                                            |    5 
 fs/btrfs/space-info.h                                            |    1 
 fs/ext4/inode.c                                                  |   98 ++--
 fs/f2fs/segment.c                                                |    4 
 fs/file.c                                                        |    1 
 fs/proc/proc_sysctl.c                                            |    8 
 include/linux/leds.h                                             |   30 -
 include/linux/pci.h                                              |    5 
 include/linux/screen_info.h                                      |  136 ++++++
 include/linux/sysctl.h                                           |    1 
 include/trace/events/btrfs.h                                     |    8 
 include/trace/events/mptcp.h                                     |    2 
 init/Kconfig                                                     |    1 
 ipc/ipc_sysctl.c                                                 |   36 +
 ipc/mq_sysctl.c                                                  |   35 +
 mm/Kconfig                                                       |   11 
 mm/page_alloc.c                                                  |   19 
 net/bluetooth/hci_sync.c                                         |   21 
 net/core/rtnetlink.c                                             |    2 
 net/ipv4/netfilter/iptable_nat.c                                 |   18 
 net/ipv4/syncookies.c                                            |    3 
 net/ipv4/tcp.c                                                   |    8 
 net/ipv4/tcp_input.c                                             |   36 +
 net/ipv4/tcp_output.c                                            |   18 
 net/ipv6/ndisc.c                                                 |   34 -
 net/ipv6/netfilter/ip6table_nat.c                                |   14 
 net/ipv6/syncookies.c                                            |    2 
 net/iucv/af_iucv.c                                               |    4 
 net/mptcp/mib.c                                                  |    2 
 net/mptcp/mib.h                                                  |    2 
 net/mptcp/options.c                                              |    2 
 net/mptcp/pm_netlink.c                                           |   28 -
 net/mptcp/protocol.c                                             |   44 +-
 net/mptcp/protocol.h                                             |   21 
 net/mptcp/sockopt.c                                              |   46 ++
 net/mptcp/subflow.c                                              |   35 +
 net/sched/act_ct.c                                               |    4 
 net/sysctl_net.c                                                 |    1 
 net/wireless/sme.c                                               |    1 
 sound/core/seq/seq_ump_convert.c                                 |   37 +
 sound/firewire/amdtp-stream.c                                    |   38 +
 sound/firewire/amdtp-stream.h                                    |    1 
 sound/pci/hda/hda_controller.h                                   |    2 
 sound/pci/hda/hda_intel.c                                        |   10 
 sound/pci/hda/patch_conexant.c                                   |   54 --
 sound/pci/hda/patch_realtek.c                                    |    1 
 sound/usb/stream.c                                               |    4 
 tools/perf/util/callchain.c                                      |    2 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                |    8 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                  |   72 ++-
 123 files changed, 1918 insertions(+), 1113 deletions(-)

Al Viro (1):
      protect the fetch of ->fd[fd] in do_dup2() from mispredictions

Alexandra Winter (1):
      net/iucv: fix use after free in iucv_sock_close()

Alexey Gladkov (2):
      sysctl: allow change system v ipc sysctls inside ipc namespace
      sysctl: allow to change limits for posix messages queues

Alice Ryhl (1):
      rust: SHADOW_CALL_STACK is incompatible with Rust

Andy Chiu (1):
      net: axienet: start napi before enabling Rx/Tx

Basavaraj Natikar (1):
      HID: amd_sfh: Move sensor discovery before HID device initialization

Casey Chen (1):
      perf tool: fix dereferencing NULL al->maps

Chris Mi (1):
      net/mlx5e: Fix CT entry update leaks of modify header context

Clément Léger (1):
      riscv: remove unused functions in traps_misaligned.c

Dan Carpenter (1):
      net: mvpp2: Don't re-use loop iterator

Danilo Krummrich (1):
      drm/nouveau: prime: fix refcount underflow

Dmitry Baryshkov (5):
      arm64: dts: qcom: sc7180: switch USB+DP QMP PHY to new style of bindings
      arm64: dts: qcom: sc7280: switch USB+DP QMP PHY to new style of bindings
      arm64: dts: qcom: msm8998: switch USB QMP PHY to new style of bindings
      arm64: dts: qcom: sdm845: switch USB+DP QMP PHY to new style of bindings
      arm64: dts: qcom: sdm845: switch USB QMP PHY to new style of bindings

Dmitry Osipenko (1):
      drm/virtio: Fix type of dma-fence context variable

Edmund Raile (2):
      Revert "ALSA: firewire-lib: obsolete workqueue for period update"
      Revert "ALSA: firewire-lib: operate for period elapse event in process context"

Eric Dumazet (2):
      sched: act_ct: take care of padding in struct zones_ht_key
      tcp: annotate data-races around tp->window_clamp

Faizal Rahim (1):
      igc: Fix double reset adapter triggered from a single taprio cmd

Frank Li (1):
      dmaengine: fsl-edma: add address for channel mux register in fsl_edma_chan

Greg Kroah-Hartman (1):
      Linux 6.6.45

Hans de Goede (1):
      leds: trigger: Call synchronize_rcu() before calling trig->activate()

Heiner Kallweit (3):
      leds: trigger: Remove unused function led_trigger_rename_static()
      leds: trigger: Store brightness set by led_trigger_event()
      r8169: don't increment tx_dropped in case of NETDEV_TX_BUSY

Huang Ying (1):
      mm: restrict the pcp batch scale factor to avoid too long latency

Ian Forbes (2):
      drm/vmwgfx: Fix overlay when using Screen Targets
      drm/vmwgfx: Trigger a modeset when the screen moves

Jacob Pan (1):
      KVM: VMX: Move posted interrupt descriptor out of VMX code

Jaegeuk Kim (1):
      f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr is valid

Javier Carrasco (1):
      cpufreq: qcom-nvmem: fix memory leaks in probe error paths

Jiaxun Yang (3):
      MIPS: Loongson64: DTS: Fix PCIe port nodes for ls7a
      MIPS: dts: loongson: Fix liointc IRQ polarity
      MIPS: dts: loongson: Fix ls2k1000-rtc interrupt

Jinjie Ruan (1):
      ARM: 9406/1: Fix callchain_trace() return value

Joy Zou (3):
      dmaengine: fsl-edma: add i.MX8ULP edma support
      dmaengine: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible string
      dmaengine: fsl-edma: change the memory access from local into remote mode in i.MX 8QM

Kiran K (1):
      Bluetooth: btintel: Fail setup on error

Krishna Kurapati (5):
      arm64: dts: qcom: sc7180: Disable SuperSpeed instances in park mode
      arm64: dts: qcom: sc7280: Disable SuperSpeed instances in park mode
      arm64: dts: qcom: msm8998: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: ipq8074: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: sdm845: Disable SS instance in Parkmode for USB

Krzysztof Kozlowski (1):
      thermal/drivers/broadcom: Fix race between removal and clock disable

Kuniyuki Iwashima (3):
      rtnetlink: Don't ignore IFLA_TARGET_NETNSID when ifname is specified in rtnl_dellink().
      netfilter: iptables: Fix null-ptr-deref in iptable_nat_table_init().
      netfilter: iptables: Fix potential null-ptr-deref in ip6table_nat_table_init().

Li Zhijian (1):
      mm/page_alloc: fix pcp->count race between drain_pages_zone() vs __rmqueue_pcplist()

Liu Jing (1):
      selftests: mptcp: always close input's FD if opened

Lucas Stach (1):
      mm: page_alloc: control latency caused by zone PCP draining

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix suspending with wrong filter policy

Ma Ke (1):
      net: usb: sr9700: fix uninitialized variable use in sr_mdio_read

Maciej Fijalkowski (3):
      ice: don't busy wait for Rx queue disable in ice_qp_dis()
      ice: replace synchronize_rcu with synchronize_net
      ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog

Maciej Żenczykowski (1):
      ipv6: fix ndisc_is_useropt() handling for PIO

Mark Bloch (1):
      net/mlx5: Lag, don't use the hardcoded value of the first port

Mark Mentovai (1):
      net: phy: realtek: add support for RTL8366S Gigabit PHY

Matthieu Baerts (NGI0) (6):
      mptcp: sched: check both directions for backup
      mptcp: distinguish rcv vs sent backup flag in requests
      mptcp: mib: count MPJ with backup flag
      mptcp: pm: only set request_bkup flag when sending MP_PRIO
      selftests: mptcp: join: validate backup in MPJ
      selftests: mptcp: join: check backup support in signal endp

Mavroudis Chatzilazaridis (1):
      ALSA: hda/realtek: Add quirk for Acer Aspire E5-574G

Michal Kubiak (1):
      ice: respect netif readiness in AF_XDP ZC related ndo's

Moshe Shemesh (1):
      net/mlx5: Fix missing lock on sync reset reload

Naohiro Aota (2):
      btrfs: zoned: fix zone_unusable accounting on making block group read-write again
      btrfs: do not subtract delalloc from avail bytes

Nikita Zhandarovich (1):
      drm/i915: Fix possible int overflow in skl_ddi_calculate_wrpll()

Paolo Abeni (6):
      mptcp: give rcvlowat some love
      mptcp: fix user-space PM announced address accounting
      mptcp: fix NL PM announced address accounting
      mptcp: fix bad RCVPRUNED mib accounting
      mptcp: fix duplicate data handling
      mptcp: prevent BPF accessing lowat from a subflow socket.

Patryk Duda (1):
      platform/chrome: cros_ec_proto: Lock device when updating MKBP version

Rahul Rameshbabu (1):
      net/mlx5e: Require mlx5 tc classifier action support for IPsec prio capability

Raju Lakkaraju (1):
      net: phy: micrel: Fix the KSZ9131 MDI-X status issue

Sean Christopherson (2):
      KVM: nVMX: Add a helper to get highest pending from Posted Interrupt vector
      KVM: nVMX: Check for pending posted interrupts when looking for nested events

Shahar Shitrit (1):
      net/mlx5e: Add a check for the return value from mlx5_port_set_eth_ptys

Shay Drory (2):
      net/mlx5: Always drain health in shutdown callback
      net/mlx5: Fix error handling in irq_pool_request_irq

Shifrin Dmitry (1):
      perf: riscv: Fix selecting counters in legacy mode

Stephan Gerhold (1):
      cpufreq: qcom-nvmem: Simplify driver data allocation

Stuart Menefy (1):
      riscv: Fix linear mapping checks for non-contiguous memory regions

Subash Abhinov Kasiviswanathan (1):
      tcp: Adjust clamping window for applications specifying SO_RCVBUF

Sui Jingfeng (1):
      PCI: Add pci_get_base_class() helper

Suraj Kandpal (1):
      drm/i915/hdcp: Fix HDCP2_STREAM_STATUS macro

Takashi Iwai (3):
      ALSA: hda: Conditionally use snooping for AMD HDMI
      ALSA: usb-audio: Correct surround channels in UAC1 channel map
      ALSA: seq: ump: Optimize conversions from SysEx to UMP

Tatsunosuke Tobita (1):
      HID: wacom: Modify pen IDs

Thomas Weißschuh (3):
      sysctl: treewide: drop unused argument ctl_table_root::set_ownership(table)
      sysctl: always initialize i_uid/i_gid
      leds: triggers: Flush pending brightness before activating trigger

Thomas Zimmermann (5):
      fbdev/vesafb: Replace references to global screen_info by local pointer
      video: Add helpers for decoding screen_info
      video: Provide screen_info_get_pci_dev() to find screen_info's PCI device
      firmware/sysfb: Update screen_info for relocated EFI framebuffers
      fbdev: vesafb: Detect VGA compatibility from screen info's VESA attributes

Umesh Nerlige Ramappa (1):
      i915/perf: Remove code to update PWR_CLK_STATE for gen12

Uwe Kleine-König (1):
      thermal: bcm2835: Convert to platform remove callback returning void

Veerendranath Jakkam (1):
      wifi: cfg80211: fix reporting failed MLO links status with cfg80211_connect_done

Vitaly Kuznetsov (1):
      KVM: VMX: Split off vmx_onhyperv.{ch} from hyperv.{ch}

Will Deacon (1):
      arm64: jump_label: Ensure patched jump_labels are visible to all CPUs

Xu Yang (1):
      perf: imx_perf: fix counter start and config sequence

Zack Rusin (1):
      drm/vmwgfx: Fix a deadlock in dma buf fence polling

Zhang Yi (4):
      ext4: refactor ext4_da_map_blocks()
      ext4: convert to exclusive lock while inserting delalloc extents
      ext4: factor out a common helper to query extent map
      ext4: check the extent status again before inserting delalloc block

Zhe Qiao (1):
      riscv/mm: Add handling for VM_FAULT_SIGSEGV in mm_fault_error()

Zhiguo Niu (1):
      f2fs: fix to avoid use SSR allocate when do defragment

songxiebing (1):
      ALSA: hda: conexant: Fix headset auto detect fail in the polling mode


