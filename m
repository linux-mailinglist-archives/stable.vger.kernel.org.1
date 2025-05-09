Return-Path: <stable+bounces-142987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66747AB0C9F
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC280189C94B
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32EF274679;
	Fri,  9 May 2025 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fq+80FlV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88602272E6B;
	Fri,  9 May 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746777999; cv=none; b=I1Sz78xpk1EYfZSMgwNctNLvvj0JS8SA1YjkK9TCC16E3x86RIz5M7AluVslYfgH8snwWiNRQFPLScyTXZ/F0V5VlmhQtcnouGzO6kxJnRhh31zUKoBQsPV6RdAwtIQL/lkTng4eZprM6f1XygRfMU0Jh37KJq2igBzogCFty40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746777999; c=relaxed/simple;
	bh=A9eD+USnybD/5jSfdCHpk+rBZjTlivzR5uodwb3k0BM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=px4IL4EjHIugzyVcdKyCf3MTgQyO+xcW+yaMLT0vvfN9fR+UZDHQDSdi4ihxMkGH/emHqJ004OpeTmUmHm2c3ID1fqvLsXqBfSKqE0IaBH1FHcIRCbEx1zjAterHrPA6dc0EXo7WWVU2kZWGFz95o7rdAaqnioPGQmJ5NE5x7PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fq+80FlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEC5C4CEE9;
	Fri,  9 May 2025 08:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746777998;
	bh=A9eD+USnybD/5jSfdCHpk+rBZjTlivzR5uodwb3k0BM=;
	h=From:To:Cc:Subject:Date:From;
	b=Fq+80FlV2CKHT+a65MG8KtTBqe9SskOaurl1ERyXXa189rCTX54csv46ZYSbEp+/d
	 gkfUGQjyEwXD04/FkgaTqS/apGqzxHx3EYvxHyWVj37Plrkv28Bko9m3V0jFlFZOG5
	 Nz9Nhx/CfrLuYA0kJkzNnBboq6cYEMoTjVsiWcSk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.90
Date: Fri,  9 May 2025 10:06:30 +0200
Message-ID: <2025050930-scored-aerospace-0012@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.90 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6ul.dtsi          |    3 
 arch/arm64/boot/dts/st/stm32mp251.dtsi                         |    9 
 arch/arm64/kernel/proton-pack.c                                |    2 
 arch/parisc/math-emu/driver.c                                  |   16 
 arch/powerpc/boot/wrapper                                      |    6 
 arch/powerpc/mm/book3s64/radix_pgtable.c                       |   17 
 arch/riscv/include/asm/patch.h                                 |    2 
 arch/riscv/kernel/patch.c                                      |   14 
 arch/riscv/kernel/probes/kprobes.c                             |   18 
 arch/riscv/net/bpf_jit_comp64.c                                |    7 
 arch/x86/events/intel/core.c                                   |    2 
 arch/x86/include/asm/kvm-x86-ops.h                             |    1 
 arch/x86/include/asm/kvm_host.h                                |    1 
 arch/x86/kvm/svm/svm.c                                         |   13 
 arch/x86/kvm/vmx/vmx.c                                         |   11 
 arch/x86/kvm/x86.c                                             |    3 
 drivers/base/module.c                                          |   13 
 drivers/bluetooth/btusb.c                                      |  101 +++--
 drivers/cpufreq/cpufreq.c                                      |   42 +-
 drivers/cpufreq/cpufreq_ondemand.c                             |    3 
 drivers/cpufreq/freq_table.c                                   |    6 
 drivers/edac/altera_edac.c                                     |    9 
 drivers/edac/altera_edac.h                                     |    2 
 drivers/firmware/arm_ffa/driver.c                              |    3 
 drivers/firmware/arm_scmi/bus.c                                |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c         |   56 +-
 drivers/gpu/drm/drm_file.c                                     |    6 
 drivers/gpu/drm/i915/pxp/intel_pxp_gsccs.h                     |    8 
 drivers/gpu/drm/meson/meson_vclk.c                             |    6 
 drivers/gpu/drm/nouveau/nouveau_fence.c                        |    2 
 drivers/i2c/busses/i2c-imx-lpi2c.c                             |    4 
 drivers/iommu/amd/init.c                                       |    8 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                    |   79 ++--
 drivers/iommu/intel/iommu.c                                    |    4 
 drivers/iommu/iommu.c                                          |   18 
 drivers/irqchip/irq-qcom-mpm.c                                 |    3 
 drivers/md/dm-bufio.c                                          |    9 
 drivers/md/dm-integrity.c                                      |    2 
 drivers/md/dm-table.c                                          |    5 
 drivers/mmc/host/renesas_sdhi_core.c                           |   10 
 drivers/net/dsa/ocelot/felix_vsc9959.c                         |    5 
 drivers/net/ethernet/amd/pds_core/auxbus.c                     |   49 +-
 drivers/net/ethernet/amd/pds_core/core.h                       |    7 
 drivers/net/ethernet/amd/pds_core/dev.c                        |   11 
 drivers/net/ethernet/amd/pds_core/devlink.c                    |    7 
 drivers/net/ethernet/amd/pds_core/main.c                       |   23 +
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c                      |    9 
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c                       |   24 +
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                       |   11 
 drivers/net/ethernet/amd/xgbe/xgbe.h                           |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c             |   20 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c              |   38 +
 drivers/net/ethernet/dlink/dl2k.c                              |    2 
 drivers/net/ethernet/dlink/dl2k.h                              |    2 
 drivers/net/ethernet/freescale/fec_main.c                      |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c             |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                |   82 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c         |   13 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c      |   25 -
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h      |    1 
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c             |    5 
 drivers/net/ethernet/intel/igc/igc_ptp.c                       |    6 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c            |    2 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                    |   14 
 drivers/net/ethernet/mediatek/mtk_star_emac.c                  |   13 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c     |    5 
 drivers/net/ethernet/mellanox/mlx5/core/rdma.c                 |   11 
 drivers/net/ethernet/mellanox/mlx5/core/rdma.h                 |    4 
 drivers/net/ethernet/microchip/lan743x_main.c                  |    8 
 drivers/net/ethernet/microchip/lan743x_main.h                  |    1 
 drivers/net/ethernet/mscc/ocelot.c                             |  194 +++++++++-
 drivers/net/ethernet/mscc/ocelot_vcap.c                        |    1 
 drivers/net/ethernet/vertexcom/mse102x.c                       |   36 +
 drivers/net/mdio/mdio-mux-meson-gxl.c                          |    3 
 drivers/net/usb/rndis_host.c                                   |   16 
 drivers/net/vxlan/vxlan_vnifilter.c                            |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c         |    6 
 drivers/net/wireless/purelifi/plfxlc/mac.c                     |    1 
 drivers/nvme/host/pci.c                                        |    2 
 drivers/nvme/host/tcp.c                                        |   31 +
 drivers/pci/controller/dwc/pci-imx6.c                          |    3 
 drivers/platform/x86/amd/pmc/pmc.c                             |    7 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c |   13 
 drivers/spi/spi-tegra114.c                                     |    6 
 drivers/usb/host/xhci-debugfs.c                                |    2 
 drivers/usb/host/xhci-hub.c                                    |   30 -
 drivers/usb/host/xhci-mem.c                                    |  175 +++++++--
 drivers/usb/host/xhci-ring.c                                   |    4 
 drivers/usb/host/xhci.c                                        |   80 ++--
 drivers/usb/host/xhci.h                                        |   20 -
 fs/btrfs/inode.c                                               |    9 
 fs/smb/client/smb2pdu.c                                        |    1 
 fs/smb/server/auth.c                                           |   14 
 fs/smb/server/smb2pdu.c                                        |    5 
 include/linux/bpf.h                                            |    1 
 include/linux/bpf_verifier.h                                   |    1 
 include/linux/cpufreq.h                                        |   83 ++--
 include/linux/filter.h                                         |    2 
 include/linux/module.h                                         |    2 
 include/linux/pds/pds_core_if.h                                |    1 
 include/linux/skbuff.h                                         |   52 ++
 include/net/inet_frag.h                                        |    4 
 include/soc/mscc/ocelot_vcap.h                                 |    2 
 include/sound/ump_convert.h                                    |    2 
 kernel/bpf/core.c                                              |    2 
 kernel/bpf/verifier.c                                          |   81 +++-
 kernel/params.c                                                |    6 
 kernel/trace/trace.c                                           |    5 
 kernel/trace/trace_output.c                                    |    4 
 mm/memblock.c                                                  |   12 
 net/bluetooth/l2cap_core.c                                     |    3 
 net/bridge/netfilter/nf_conntrack_bridge.c                     |    6 
 net/core/dev.c                                                 |    2 
 net/core/filter.c                                              |   75 +--
 net/ieee802154/6lowpan/reassembly.c                            |    2 
 net/ipv4/inet_fragment.c                                       |    2 
 net/ipv4/ip_fragment.c                                         |    2 
 net/ipv4/ip_output.c                                           |    9 
 net/ipv4/tcp_output.c                                          |   14 
 net/ipv4/udp_offload.c                                         |   61 +++
 net/ipv6/ip6_output.c                                          |    6 
 net/ipv6/netfilter.c                                           |    6 
 net/ipv6/netfilter/nf_conntrack_reasm.c                        |    2 
 net/ipv6/reassembly.c                                          |    2 
 net/ipv6/tcp_ipv6.c                                            |    2 
 net/sched/act_bpf.c                                            |    4 
 net/sched/cls_bpf.c                                            |    4 
 net/sched/sch_drr.c                                            |   16 
 net/sched/sch_ets.c                                            |   17 
 net/sched/sch_hfsc.c                                           |   10 
 net/sched/sch_htb.c                                            |    2 
 net/sched/sch_qfq.c                                            |   18 
 sound/soc/codecs/ak4613.c                                      |    4 
 sound/soc/soc-core.c                                           |   36 -
 sound/soc/soc-pcm.c                                            |    5 
 sound/usb/endpoint.c                                           |    7 
 sound/usb/format.c                                             |    3 
 tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c      |  107 +++++
 tools/testing/selftests/bpf/progs/changes_pkt_data.c           |   39 ++
 tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c  |   18 
 tools/testing/selftests/bpf/progs/verifier_sock.c              |   56 ++
 142 files changed, 1757 insertions(+), 650 deletions(-)

Aaron Kling (1):
      spi: tegra114: Don't fail set_cs_timing when delays are zero

Abhishek Chauhan (1):
      net: Rename mono_delivery_time to tstamp_type for scalabilty

Benjamin Marzinski (1):
      dm: always update the array size in realloc_argv on success

Chad Monroe (1):
      net: ethernet: mtk_eth_soc: fix SER panic with 4GB+ RAM

Chen Linxuan (1):
      drm/i915/pxp: fix undefined reference to `intel_pxp_gsccs_is_ready_for_sessions'

Chris Bainbridge (1):
      drm/amd/display: Fix slab-use-after-free in hdcp

Chris Mi (1):
      net/mlx5: E-switch, Fix error handling for enabling roce

Christian Bruel (2):
      arm64: dts: st: Adjust interrupt-controller for stm32mp25 SoCs
      arm64: dts: st: Use 128kB size for aliased GIC400 register access on stm32mp25 SoCs

Christian Heusel (1):
      Revert "rndis_host: Flag RNDIS modems as WWAN devices"

Christian Hewitt (1):
      Revert "drm/meson: vclk: fix calculation of 59.94 fractional rates"

Clark Wang (1):
      i2c: imx-lpi2c: Fix clock count when probe defers

Cong Wang (5):
      sch_htb: make htb_qlen_notify() idempotent
      sch_drr: make drr_qlen_notify() idempotent
      sch_hfsc: make hfsc_qlen_notify() idempotent
      sch_qfq: make qfq_qlen_notify() idempotent
      sch_ets: make est_qlen_notify() idempotent

Cristian Marussi (1):
      firmware: arm_scmi: Balance device refcount when destroying devices

Da Xue (1):
      net: mdio: mux-meson-gxl: set reversed bit when using internal phy

Dave Chen (1):
      btrfs: fix COW handling in run_delalloc_nocow()

Donet Tom (1):
      book3s64/radix : Align section vmemmap start address to PAGE_SIZE

Eduard Zingerman (10):
      bpf: add find_containing_subprog() utility function
      bpf: refactor bpf_helper_changes_pkt_data to use helper number
      bpf: track changes_pkt_data property for global functions
      selftests/bpf: test for changing packet data from global functions
      bpf: check changes_pkt_data property for extension programs
      selftests/bpf: freplace tests for tracking of changes_packet_data
      bpf: consider that tail calls invalidate packet pointers
      selftests/bpf: validate that tail call invalidates packet pointers
      bpf: fix null dereference when computing changes_pkt_data of prog w/o subprogs
      selftests/bpf: extend changes_pkt_data with cases w/o subprograms

En-Wei Wu (1):
      Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()

Felix Fietkau (1):
      net: ipv6: fix UDPv6 GSO segmentation with NAT

Geert Uytterhoeven (1):
      ASoC: soc-core: Stop using of_property_read_bool() for non-boolean properties

Geoffrey D. Bennett (1):
      ALSA: usb-audio: Add retry on -EPROTO from usb_set_interface()

Greg Kroah-Hartman (1):
      Linux 6.6.90

Hao Lan (1):
      net: hns3: fixed debugfs tm_qset size

Helge Deller (1):
      parisc: Fix double SIGFPE crash

Ido Schimmel (1):
      vxlan: vnifilter: Fix unlocked deletion of default FDB entry

Jacob Keller (1):
      igc: fix lock order in igc_ptp_reset

Jason Gunthorpe (1):
      iommu/arm-smmu-v3: Use the new rb tree helpers

Jeongjun Park (1):
      tracing: Fix oob write in trace_seq_to_buffer()

Jethro Donaldson (1):
      smb: client: fix zero length for mkdir POSIX create context

Jian Shen (2):
      net: hns3: store rx VLAN tag offload state for VF
      net: hns3: defer calling ptp_clock_register()

Joachim Priesner (1):
      ALSA: usb-audio: Add second USB ID for Jabra Evolve 65 headset

Jonathan Bell (1):
      xhci: Use more than one Event Ring segment

Keith Busch (1):
      nvme-pci: fix queue unquiesce check on slot_reset

LongPing Wei (1):
      dm-bufio: don't schedule in atomic context

Louis-Alexis Eyraud (2):
      net: ethernet: mtk-star-emac: fix spinlock recursion issues on rx/tx poll
      net: ethernet: mtk-star-emac: rearm interrupts in rx_poll only when advised

Lukas Wunner (2):
      xhci: Set DESI bits in ERDP register correctly
      xhci: Clean up stale comment on ERST_SIZE macro

Madhavan Srinivasan (2):
      powerpc/boot: Check for ld-option support
      powerpc/boot: Fix dash warning

Maor Gottlieb (1):
      net/mlx5: E-Switch, Initialize MAC Address for Default GID

Marc Zyngier (1):
      usb: xhci: Check for xhci->interrupters being allocated in xhci_mem_clearup()

Mario Limonciello (2):
      platform/x86/amd: pmc: Require at least 2.5 seconds between HW sleep cycles
      drm/amd/display: Add scoped mutexes for amdgpu_dm_dhcp

Mathias Nyman (6):
      xhci: split free interrupter into separate remove and free parts
      xhci: add support to allocate several interrupters
      xhci: Add helper to set an interrupters interrupt moderation interval
      xhci: support setting interrupt moderation IMOD for secondary interrupters
      xhci: Limit time spent with xHC interrupts disabled during bus resume
      xhci: fix possible null pointer dereference at secondary interrupter removal

Mattias Barthel (1):
      net: fec: ERR007885 Workaround for conventional TX

Michael Chan (1):
      bnxt_en: Fix ethtool -d byte order for 32-bit values

Michael Liang (1):
      nvme-tcp: fix premature queue removal and I/O failover

Mikulas Patocka (1):
      dm-integrity: fix a warning on invalid table line

Mingcong Bai (1):
      iommu/vt-d: Apply quirk_iommu_igfx for 8086:0044 (QM57/QS57)

Murad Masimov (1):
      wifi: plfxlc: Remove erroneous assert in plfxlc_mac_release

Nicolin Chen (1):
      iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids

Niklas Neronin (1):
      usb: xhci: check if 'requested segments' exceeds ERST capacity

Niravkumar L Rabara (2):
      EDAC/altera: Test the correct error reg offset
      EDAC/altera: Set DDR and SDMMC interrupt mask before registration

Pauli Virtanen (1):
      Bluetooth: L2CAP: copy RX timestamp to new fragments

Pavel Paklov (1):
      iommu/amd: Fix potential buffer overflow in parse_ivrs_acpihid

Philipp Stanner (1):
      drm/nouveau: Fix WARN_ON in nouveau_fence_context_kill()

Rafael J. Wysocki (2):
      cpufreq: Avoid using inconsistent policy->min and policy->max
      cpufreq: Fix setting policy limits when frequency tables are used

Richard Zhu (1):
      PCI: imx6: Skip controller_id generation logic for i.MX7D

Rob Herring (Arm) (1):
      ASoC: Use of_property_read_bool()

Robin Murphy (1):
      iommu: Handle race with default domain setup

Ruslan Piasetskyi (1):
      mmc: renesas_sdhi: Fix error handling in renesas_sdhi_probe

Ryan Matthews (1):
      Revert "PCI: imx6: Skip controller_id generation logic for i.MX7D"

Samuel Holland (1):
      riscv: Pass patch_text() the length in bytes

Sathesh B Edara (1):
      octeon_ep: Fix host hang issue during device reboot

Sean Christopherson (2):
      perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest with vCPU's value.
      KVM: x86: Load DR6 with guest value only before entering .vcpu_run() loop

Sean Heelan (1):
      ksmbd: fix use-after-free in kerberos authentication

Shannon Nelson (5):
      pds_core: check health in devcmd wait
      pds_core: delete VF dev on reset
      pds_core: make pdsc_auxbus_dev_del() void
      pds_core: specify auxiliary_device to be created
      pds_core: remove write-after-free of client_id

Sheetal (1):
      ASoC: soc-pcm: Fix hw_params() and DAPM widget sequence

Shouye Liu (1):
      platform/x86/intel-uncore-freq: Fix missing uncore sysfs during CPU hotplug

Shruti Parab (2):
      bnxt_en: Fix coredump logic to free allocated buffer
      bnxt_en: Fix out-of-bound memcpy() during ethtool -w

Shyam Saini (3):
      kernel: param: rename locate_module_kobject
      kernel: globalize lookup_or_create_module_kobject()
      drivers: base: handle module_kobject creation

Simon Horman (1):
      net: dlink: Correct endianness handling of led_mode

Stefan Wahren (4):
      net: vertexcom: mse102x: Fix possible stuck of SPI interrupt
      net: vertexcom: mse102x: Fix LEN_MASK
      net: vertexcom: mse102x: Add range check for CMD_RTS
      net: vertexcom: mse102x: Fix RX error handling

Stephan Gerhold (1):
      irqchip/qcom-mpm: Prevent crash when trying to handle non-wake GPIOs

Steven Rostedt (1):
      tracing: Do not take trace_event_sem in print_event_fields()

Sudeep Holla (1):
      firmware: arm_ffa: Skip Rx buffer ownership release if not acquired

Sébastien Szymanski (1):
      ARM: dts: opos6ul: add ksz8081 phy properties

Takashi Iwai (1):
      ALSA: ump: Fix buffer overflow at UMP SysEx message conversion

Thangaraj Samynathan (1):
      net: lan743x: Fix memleak issue when GSO enabled

Tudor Ambarus (1):
      dm: fix copying after src array boundaries

Tvrtko Ursulin (1):
      drm/fdinfo: Protect against driver unbind

Victor Nogueira (4):
      net_sched: drr: Fix double list add in class with netem as child qdisc
      net_sched: hfsc: Fix a UAF vulnerability in class with netem as child qdisc
      net_sched: ets: Fix double list add in class with netem as child qdisc
      net_sched: qfq: Fix double list add in class with netem as child qdisc

Vishal Badole (1):
      amd-xgbe: Fix to ensure dependent features are toggled with RX checksum offload

Vladimir Oltean (3):
      net: mscc: ocelot: treat 802.1ad tagged traffic as 802.1Q-untagged
      net: mscc: ocelot: delete PVID VLAN when readding it as non-PVID
      net: dsa: felix: fix broken taprio gate states after clock jump

Wei Yang (2):
      mm/memblock: pass size instead of end to memblock_set_node()
      mm/memblock: repeat setting reserved region nid if array is doubled

Wentao Liang (1):
      wifi: brcm80211: fmac: Add error handling for brcmf_usb_dl_writeimage()

Will Deacon (1):
      arm64: errata: Add missing sentinels to Spectre-BHB MIDR arrays

Xuanqiang Luo (1):
      ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()

Yonglong Liu (1):
      net: hns3: fix an interrupt residual problem


