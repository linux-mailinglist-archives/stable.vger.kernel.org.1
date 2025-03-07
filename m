Return-Path: <stable+bounces-121429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7DEA56FA4
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 18:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0D0176929
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE9623F413;
	Fri,  7 Mar 2025 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HZQjT15y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188B523E227;
	Fri,  7 Mar 2025 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369970; cv=none; b=ALZU7OPUi3I7XN3T20hnoslqUHPkYtlzvt/3mlObTtnskcihMTmbLzMQUkZNiN12rOph6OI4M4j++6Z2NKi3nmnvRqZZ7p2//wsR+GZxay/SHRL8KQevbFtCc9N4JrlHmeYw31jzttWp9Fue/oXqV55YXtRwOLsILy5ugKV3mdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369970; c=relaxed/simple;
	bh=x4p6TKIqFsULgnDCiePyUqZ5CgKOiW9C0Yy/o92VPro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dDbZdcE5gxGgAX4DPB0vIDN8ZgBmMq0q9vDUe3fSsEBCNWJYBe12L3mJQHwYL4+XD6fjSD9QM21On0oip+EQ1LFAEXDX59r6AqJjw5+rL5xvgNt+HLlpwqsXw+UEwxfabqOK15/dL4sy+uzq2xcZoo3xA7IYskgiw4TOlmzpjWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HZQjT15y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F388C4CED1;
	Fri,  7 Mar 2025 17:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741369969;
	bh=x4p6TKIqFsULgnDCiePyUqZ5CgKOiW9C0Yy/o92VPro=;
	h=From:To:Cc:Subject:Date:From;
	b=HZQjT15yJXW6dxQzVz8fpXn1BqmbDjoZORXdkABBABeGeMHploPOq4q8kLF+JYijC
	 yTtPvZzzk40fRghI16i4FXfLcP3JgyymSiUmAzcQzCNgpY6/xFr1QG6Es9ND9J0oxK
	 GaUvZB7cWT0tIbwYffNxBvadkIRs9oYCVjLSACL4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.18
Date: Fri,  7 Mar 2025 18:52:44 +0100
Message-ID: <2025030745-flaxseed-unsubtly-c5e3@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.18 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                              |    2 
 arch/arm64/include/asm/kvm_host.h                     |    2 
 arch/arm64/kvm/arm.c                                  |   22 
 arch/arm64/kvm/vmid.c                                 |   11 
 arch/arm64/mm/init.c                                  |    7 
 arch/riscv/include/asm/futex.h                        |    2 
 arch/riscv/kernel/cacheinfo.c                         |   12 
 arch/riscv/kernel/cpufeature.c                        |    2 
 arch/riscv/kernel/setup.c                             |    2 
 arch/riscv/kernel/signal.c                            |    6 
 arch/riscv/kvm/vcpu_sbi_hsm.c                         |   11 
 arch/riscv/kvm/vcpu_sbi_replace.c                     |   15 
 arch/x86/Kconfig                                      |    1 
 arch/x86/events/core.c                                |    2 
 arch/x86/kernel/cpu/cyrix.c                           |    4 
 arch/x86/kernel/cpu/microcode/amd.c                   |  283 +++++--
 arch/x86/kernel/cpu/microcode/amd_shas.c              |  444 ++++++++++++
 arch/x86/kernel/cpu/microcode/internal.h              |    2 
 block/blk-zoned.c                                     |   76 +-
 drivers/firmware/cirrus/cs_dsp.c                      |   24 
 drivers/firmware/efi/mokvar-table.c                   |   42 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c            |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c               |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c      |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c      |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c      |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c       |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     |   69 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   14 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |    3 
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c            |   25 
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c        |    8 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c            |   26 
 drivers/gpu/drm/xe/regs/xe_engine_regs.h              |    1 
 drivers/gpu/drm/xe/xe_oa.c                            |  657 ++++++++++--------
 drivers/gpu/drm/xe/xe_oa_types.h                      |    6 
 drivers/gpu/drm/xe/xe_vm.c                            |   40 -
 drivers/i2c/busses/i2c-ls2x.c                         |   16 
 drivers/i2c/busses/i2c-npcm7xx.c                      |    7 
 drivers/idle/intel_idle.c                             |    4 
 drivers/infiniband/hw/bnxt_re/bnxt_re.h               |   18 
 drivers/infiniband/hw/bnxt_re/hw_counters.c           |    4 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c              |   46 -
 drivers/infiniband/hw/bnxt_re/main.c                  |  153 ++--
 drivers/infiniband/hw/bnxt_re/qplib_res.c             |    7 
 drivers/infiniband/hw/bnxt_re/qplib_res.h             |   12 
 drivers/infiniband/hw/bnxt_re/qplib_sp.c              |    4 
 drivers/infiniband/hw/bnxt_re/qplib_sp.h              |    3 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c            |   64 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h            |    2 
 drivers/infiniband/hw/mana/main.c                     |    2 
 drivers/infiniband/hw/mlx5/ah.c                       |    3 
 drivers/infiniband/hw/mlx5/counters.c                 |    8 
 drivers/infiniband/hw/mlx5/mr.c                       |   16 
 drivers/infiniband/hw/mlx5/odp.c                      |    1 
 drivers/infiniband/hw/mlx5/qp.c                       |   10 
 drivers/infiniband/hw/mlx5/qp.h                       |    1 
 drivers/infiniband/hw/mlx5/umr.c                      |   83 +-
 drivers/iommu/intel/dmar.c                            |    1 
 drivers/iommu/intel/iommu.c                           |   10 
 drivers/md/dm-integrity.c                             |    8 
 drivers/md/dm-vdo/dedupe.c                            |    1 
 drivers/net/dsa/realtek/Kconfig                       |    6 
 drivers/net/dsa/realtek/Makefile                      |    3 
 drivers/net/dsa/realtek/rtl8366rb-leds.c              |  177 ++++
 drivers/net/dsa/realtek/rtl8366rb.c                   |  258 -------
 drivers/net/dsa/realtek/rtl8366rb.h                   |  107 ++
 drivers/net/ethernet/cadence/macb.h                   |    2 
 drivers/net/ethernet/cadence/macb_main.c              |   12 
 drivers/net/ethernet/freescale/enetc/enetc.c          |  103 ++
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c  |    7 
 drivers/net/ethernet/intel/ice/ice.h                  |    1 
 drivers/net/ethernet/intel/ice/ice_eswitch.c          |    3 
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h       |    3 
 drivers/net/ethernet/intel/ice/ice_lib.c              |    3 
 drivers/net/ethernet/intel/ice/ice_main.c             |   24 
 drivers/net/ethernet/intel/ice/ice_sriov.c            |    4 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c           |   34 
 drivers/net/ethernet/intel/ice/ice_vf_lib_private.h   |    1 
 drivers/net/ethernet/intel/ice/ice_vf_mbx.c           |   32 
 drivers/net/ethernet/intel/ice/ice_vf_mbx.h           |    9 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c         |    8 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c           |    3 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c     |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c  |   14 
 drivers/net/ethernet/ti/Kconfig                       |    1 
 drivers/net/ethernet/ti/icssg/icss_iep.c              |   21 
 drivers/net/ipvlan/ipvlan_core.c                      |   22 
 drivers/net/loopback.c                                |   14 
 drivers/net/phy/qcom/qca807x.c                        |    2 
 drivers/net/usb/gl620a.c                              |    4 
 drivers/phy/rockchip/Kconfig                          |    1 
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c    |    5 
 drivers/phy/samsung/phy-exynos5-usbdrd.c              |   25 
 drivers/phy/tegra/xusb-tegra186.c                     |   11 
 drivers/scsi/scsi_lib.c                               |   14 
 drivers/thermal/gov_bang_bang.c                       |   11 
 drivers/thermal/gov_fair_share.c                      |   16 
 drivers/thermal/gov_power_allocator.c                 |   71 +
 drivers/thermal/gov_step_wise.c                       |   16 
 drivers/thermal/thermal_core.c                        |   33 
 drivers/thermal/thermal_core.h                        |    5 
 drivers/thermal/thermal_helpers.c                     |    5 
 drivers/thermal/thermal_of.c                          |   53 -
 drivers/ufs/core/ufs_bsg.c                            |    6 
 drivers/ufs/core/ufshcd.c                             |   38 -
 fs/afs/server.c                                       |    3 
 fs/afs/server_list.c                                  |    4 
 fs/nfs/delegation.c                                   |   37 +
 fs/nfs/delegation.h                                   |    1 
 fs/nfs/direct.c                                       |   23 
 fs/nfs/nfs4proc.c                                     |    3 
 fs/overlayfs/copy_up.c                                |    2 
 include/asm-generic/vmlinux.lds.h                     |    2 
 include/linux/blkdev.h                                |    7 
 include/linux/compiler-gcc.h                          |   12 
 include/linux/compiler.h                              |   39 -
 include/linux/rcuref.h                                |    9 
 include/linux/socket.h                                |    2 
 include/linux/sunrpc/sched.h                          |    3 
 include/net/ip.h                                      |    5 
 include/net/route.h                                   |    5 
 include/sound/cs35l56.h                               |   31 
 include/trace/events/afs.h                            |    2 
 include/trace/events/sunrpc.h                         |    3 
 io_uring/net.c                                        |    4 
 kernel/events/core.c                                  |   31 
 kernel/events/uprobes.c                               |    5 
 kernel/sched/core.c                                   |    2 
 kernel/sched/ext.c                                    |   11 
 kernel/trace/ftrace.c                                 |   27 
 kernel/trace/trace_events_hist.c                      |   30 
 lib/rcuref.c                                          |    5 
 net/bluetooth/l2cap_core.c                            |    9 
 net/bridge/br_netfilter_hooks.c                       |    8 
 net/core/gro.c                                        |    1 
 net/core/scm.c                                        |   10 
 net/core/skbuff.c                                     |    2 
 net/core/sysctl_net_core.c                            |    3 
 net/ipv4/icmp.c                                       |   19 
 net/ipv4/ip_options.c                                 |    3 
 net/ipv4/tcp.c                                        |   26 
 net/ipv4/tcp_minisocks.c                              |   10 
 net/ipv6/ip6_tunnel.c                                 |    4 
 net/ipv6/rpl_iptunnel.c                               |   14 
 net/ipv6/seg6_iptunnel.c                              |   14 
 net/mptcp/pm_netlink.c                                |    5 
 net/mptcp/subflow.c                                   |   15 
 net/rxrpc/rxperf.c                                    |   12 
 net/sunrpc/cache.c                                    |   10 
 net/sunrpc/sched.c                                    |    2 
 net/sunrpc/xprtsock.c                                 |   10 
 security/integrity/ima/ima.h                          |    3 
 security/integrity/ima/ima_main.c                     |    7 
 security/landlock/net.c                               |    3 
 sound/pci/hda/cs35l56_hda_spi.c                       |    3 
 sound/pci/hda/patch_realtek.c                         |    2 
 sound/soc/codecs/cs35l56-shared.c                     |   80 ++
 sound/soc/codecs/cs35l56-spi.c                        |    3 
 sound/soc/codecs/es8328.c                             |   15 
 sound/soc/fsl/fsl_sai.c                               |    6 
 sound/soc/fsl/imx-audmix.c                            |    4 
 sound/usb/midi.c                                      |    2 
 sound/usb/quirks.c                                    |    1 
 tools/objtool/check.c                                 |   50 -
 tools/objtool/include/objtool/special.h               |    2 
 tools/testing/selftests/drivers/net/queues.py         |    7 
 tools/testing/selftests/landlock/common.h             |    1 
 tools/testing/selftests/landlock/config               |    2 
 tools/testing/selftests/landlock/net_test.c           |  124 +++
 tools/testing/selftests/rseq/rseq-riscv-bits.h        |    6 
 tools/testing/selftests/rseq/rseq-riscv.h             |    2 
 173 files changed, 2929 insertions(+), 1406 deletions(-)

Adrien Vergé (1):
      ALSA: hda/realtek: Fix microphone regression on ASUS N705UD

Alex Deucher (1):
      drm/amdgpu: disable BAR resize on Dell G5 SE

Andreas Schwab (1):
      riscv/futex: sign extend compare value in atomic cmpxchg

Andrew Jones (4):
      riscv: KVM: Fix hart suspend status check
      riscv: KVM: Fix hart suspend_type use
      riscv: KVM: Fix SBI IPI error generation
      riscv: KVM: Fix SBI TIME error generation

André Draszik (1):
      phy: exynos5-usbdrd: gs101: ensure power is gated to SS phy in phy_exit()

Ard Biesheuvel (2):
      objtool: Fix C jump table annotations for Clang
      vmlinux.lds: Ensure that const vars with relocations are mapped R/O

Arnd Bergmann (2):
      sunrpc: suppress warnings for unused procfs functions
      phy: rockchip: fix Kconfig dependency more

Arthur Simchaev (1):
      scsi: ufs: core: bsg: Fix crash when arpmb command fails

Ashutosh Dixit (4):
      drm/xe/oa: Signal output fences
      drm/xe/oa: Move functions up so they can be reused for config ioctl
      drm/xe/oa: Add syncs support to OA config ioctl
      drm/xe/oa: Allow only certain property changes from config

BH Hsieh (1):
      phy: tegra: xusb: reset VBUS & ID OVERRIDE

Bart Van Assche (1):
      scsi: ufs: core: Fix ufshcd_is_ufs_dev_busy() and ufshcd_eh_timed_out()

Benjamin Coddington (1):
      SUNRPC: Handle -ETIMEDOUT return from tlshd

Binbin Zhou (1):
      i2c: ls2x: Fix frequency division register access

Borislav Petkov (AMD) (7):
      x86/microcode/AMD: Have __apply_microcode_amd() return bool
      x86/microcode/AMD: Remove ugly linebreak in __verify_patch_section() signature
      x86/microcode/AMD: Remove unused save_microcode_in_initrd_amd() declarations
      x86/microcode/AMD: Merge early_apply_microcode() into its single callsite
      x86/microcode/AMD: Get rid of the _load_microcode_amd() forward declaration
      x86/microcode/AMD: Add get_patch_level()
      x86/microcode/AMD: Load only SHA256-checksummed patches

Breno Leitao (1):
      perf/core: Add RCU read lock protection to perf_iterate_ctx()

Chancel Liu (1):
      ASoC: fsl: Rename stream name of SAI DAI driver

Chukun Pan (1):
      phy: rockchip: naneng-combphy: compatible reset with old DT

Clément Léger (1):
      riscv: cpufeature: use bitmap_equal() instead of memcmp()

Damien Le Moal (1):
      block: Remove zone write plugs when handling native zone append writes

David Howells (3):
      rxrpc: rxperf: Fix missing decoding of terminal magic cookie
      afs: Fix the server_list to unuse a displaced server rather than putting it
      afs: Give an afs_server object a ref on the afs_cell object it points to

David Yat Sin (1):
      drm/amdkfd: Preserve cp_hqd_pq_control on update_mqd

Dmitry Panchenko (1):
      ALSA: usb-audio: Re-add sample rate quirk for Pioneer DJM-900NXS2

Eric Dumazet (2):
      ipvlan: ensure network headers are in skb linear part
      idpf: fix checksums set in idpf_rx_rsc()

George Moussalem (1):
      net: phy: qcom: qca807x fix condition for DAC_DSP_BIAS_CURRENT

Greg Kroah-Hartman (1):
      Linux 6.12.18

Guillaume Nault (3):
      ipv4: Convert icmp_route_lookup() to dscp_t.
      ipv4: Convert ip_route_input() to dscp_t.
      ipvlan: Prepare ipvlan_process_v4_outbound() to future .flowi4_tos conversion.

Harshal Chaudhari (1):
      net: mvpp2: cls: Fixed Non IP flow, with vlan tag flow defination.

Ido Schimmel (1):
      net: loopback: Avoid sending IP packets without an Ethernet header

Jerry Snitselaar (1):
      iommu/vt-d: Remove device comparison in context_setup_pass_through_cb

Jiri Slaby (SUSE) (1):
      net: set the minimum for net_hotdata.netdev_budget_usecs

Joe Damato (1):
      selftests: drv-net: Check if combined-count exists

Junxian Huang (1):
      RDMA/hns: Fix mbox timing out by adding retry mechanism

Justin Iurman (2):
      net: ipv6: fix dst ref loop on input in seg6 lwt
      net: ipv6: fix dst ref loop on input in rpl lwt

Kalesh AP (5):
      RDMA/bnxt_re: Fail probe early when not enough MSI-x vectors are reserved
      RDMA/bnxt_re: Refactor NQ allocation
      RDMA/bnxt_re: Cache MSIx info to a local structure
      RDMA/bnxt_re: Add sanity checks on rdev validity
      RDMA/bnxt_re: Allocate dev_attr information dynamically

Kan Liang (2):
      perf/x86: Fix low freqency setting issue
      perf/core: Fix low freq setting via IOC_PERIOD

Kashyap Desai (1):
      RDMA/bnxt_re: Fix the page details for the srq created by kernel consumers

Kaustabh Chakraborty (1):
      phy: exynos5-usbdrd: fix MPLL_MULTIPLIER and SSC_REFCLKSEL masks in refclk

Ken Raeburn (1):
      dm vdo: add missing spin_lock_init

Konstantin Taranov (1):
      RDMA/mana_ib: Allocate PAGE aligned doorbell index

Krzysztof Kozlowski (1):
      thermal: of: Simplify thermal_of_should_bind with scoped for each OF child

Linus Walleij (1):
      net: dsa: rtl8366rb: Fix compilation problem

Lu Baolu (1):
      iommu/vt-d: Fix suspicious RCU usage

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response

Luo Gengkun (1):
      perf/core: Order the PMU list to fix warning about unordered pmu_ctx_list

Manivannan Sadhasivam (1):
      scsi: ufs: core: Set default runtime/system PM levels before ufshcd_hba_init()

Marcin Szycik (2):
      ice: Fix deinitializing VF in error path
      ice: Avoid setting default Rx VSI twice in switchdev setup

Mark Zhang (1):
      IB/mlx5: Set and get correct qp_num for a DCT QP

Matthew Auld (2):
      drm/xe/userptr: restore invalidation list on error
      drm/xe/userptr: fix EFAULT handling

Matthieu Baerts (NGI0) (1):
      mptcp: reset when MPTCP opts are dropped after join

Meghana Malladi (1):
      net: ti: icss-iep: Reject perout generation request

Mikhail Ivanov (3):
      landlock: Fix non-TCP sockets restriction
      selftests/landlock: Test that MPTCP actions are not restricted
      selftests/landlock: Test TCP accesses with protocol=IPPROTO_TCP

Milan Broz (1):
      dm-integrity: Avoid divide by zero in table status in Inline mode

Mingcong Bai (1):
      drm/xe/regs: remove a duplicate definition for RING_CTL_SIZE(size)

Mohammad Heib (1):
      net: Clear old fragment checksum value in napi_reuse_skb

Nicolas Frattaroli (1):
      ASoC: es8328: fix route from DAC to output

Nikita Zhandarovich (1):
      usbnet: gl620a: fix endpoint checking in genelink_bind()

Nikolay Borisov (1):
      x86/microcode/AMD: Return bool from find_blobs_in_containers()

Nikolay Kuratov (1):
      ftrace: Avoid potential division by zero in function_stat_show()

Oliver Upton (1):
      KVM: arm64: Ensure a VMID is allocated before programming VTTBR_EL2

Paolo Abeni (1):
      mptcp: always handle address removal under msk socket lock

Patrisious Haddad (2):
      RDMA/mlx5: Fix AH static rate parsing
      RDMA/mlx5: Fix bind QP error cleanup flow

Paul Greenwalt (1):
      ice: add E830 HW VF mailbox message limit support

Pavel Begunkov (1):
      io_uring/net: save msg_control for compat

Peter Jones (1):
      efi: Don't map the entire mokvar table to determine its size

Peter Zijlstra (2):
      unreachable: Unify
      objtool: Remove annotate_{,un}reachable()

Philo Lu (1):
      ipvs: Always clear ipvs_property flag in skb_scrub_packet()

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: init return value in amdgpu_ttm_clear_buffer

Qunqin Zhao (1):
      net: stmmac: dwmac-loongson: Add fix_soc_reset() callback

Rafael J. Wysocki (3):
      thermal/of: Fix cdev lookup in thermal_of_should_bind()
      thermal: core: Move lists of thermal instances to trip descriptors
      thermal: gov_power_allocator: Add missing NULL pointer check

Richard Fitzgerald (2):
      firmware: cs_dsp: Remove async regmap writes
      ASoC: cs35l56: Prevent races when soft-resetting using SPI control

Rob Herring (1):
      riscv: cacheinfo: Use of_property_present() for non-boolean properties

Roberto Sassu (1):
      ima: Reset IMA_NONACTION_RULE_FLAGS after post_setattr

Roman Li (1):
      drm/amd/display: Fix HPD after gpu reset

Russell Senior (1):
      x86/CPU: Fix warm boot hang regression on AMD SC1100 SoC systems

Ryan Roberts (1):
      arm64/mm: Fix Boot panic on Ampere Altra

Sascha Hauer (1):
      net: ethernet: ti: am65-cpsw: select PAGE_POOL

Sean Anderson (1):
      net: cadence: macb: Synchronize stats calculations

Selvin Xavier (1):
      RDMA/bnxt_re: Fix the statistics for Gen P7 VF

Shay Drory (1):
      net/mlx5: IRQ, Fix null string in debug print

Stafford Horne (1):
      rseq/selftests: Fix riscv rseq_offset_deref_addv inline asm

Stanislav Fomichev (1):
      tcp: devmem: don't write truncated dmabuf CMSGs to userspace

Steven Rostedt (1):
      tracing: Fix bad hist from corrupting named_triggers list

Takashi Iwai (2):
      ALSA: usb-audio: Avoid dropping MIDI events at closing multiple ports
      ALSA: hda/realtek: Fix wrong mic setup for ASUS VivoBook 15

Tejun Heo (1):
      sched_ext: Fix pick_task_scx() picking non-queued tasks when it's called without balance()

Thomas Gleixner (3):
      intel_idle: Handle older CPUs, which stop the TSC in deeper C states, correctly
      rcuref: Plug slowpath race in rcuref_put()
      sched/core: Prevent rescheduling when interrupts are disabled

Tom Chung (1):
      drm/amd/display: Disable PSR-SU on eDP panels

Tong Tiangen (1):
      uprobes: Reject the shared zeropage in uprobe_write_opcode()

Trond Myklebust (4):
      NFS: O_DIRECT writes must check and adjust the file length
      NFS: Adjust delegated timestamps for O_DIRECT reads and writes
      SUNRPC: Prevent looping due to rpc_signal_task() races
      NFSv4: Fix a deadlock when recovering state on a sillyrenamed file

Tyrone Ting (1):
      i2c: npcm: disable interrupt enable bit before devm_request_irq

Umesh Nerlige Ramappa (1):
      drm/xe/oa: Allow oa_exponent value of 0

Vasiliy Kovalev (1):
      ovl: fix UAF in ovl_dentry_update_reval by moving dput() in ovl_link_up

Wang Hai (1):
      tcp: Defer ts_recent changes until req is owned

Wei Fang (6):
      net: enetc: fix the off-by-one issue in enetc_map_tx_buffs()
      net: enetc: keep track of correct Tx BD count in enetc_map_tx_tso_buffs()
      net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC
      net: enetc: update UDP checksum when updating originTimestamp field
      net: enetc: correct the xdp_tx statistics
      net: enetc: fix the off-by-one issue in enetc_map_tx_tso_buffs()

Ye Bin (1):
      scsi: core: Clear driver private data when retrying request

Yilin Chen (1):
      drm/amd/display: add a quirk to enable eDP0 on DP1

Yishai Hadas (4):
      RDMA/mlx5: Fix the recovery flow of the UMR QP
      RDMA/mlx5: Fix a race for DMABUF MR which can lead to CQE with error
      RDMA/mlx5: Fix a WARN during dereg_mr for DM type
      RDMA/mlx5: Fix implicit ODP hang on parent deregistration

Yong-Xuan Wang (2):
      riscv: signal: fix signal frame size
      riscv: signal: fix signal_minsigstksz

Yu-Che Cheng (2):
      thermal: gov_power_allocator: Fix incorrect calculation in divvy_up_power()
      thermal: gov_power_allocator: Update total_weight on bind and cdev updates

chr[] (1):
      amdgpu/pm/legacy: fix suspend/resume issues


