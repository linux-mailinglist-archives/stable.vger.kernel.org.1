Return-Path: <stable+bounces-121413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B09A56D9A
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822B41895981
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 16:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C18C23C385;
	Fri,  7 Mar 2025 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e9c8haZj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504C23BF9B;
	Fri,  7 Mar 2025 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364748; cv=none; b=r8qexeeJ8eZLVy+TKFL1CZHDF+8TGYIL+pyUbbpaxI4uDI98wM2PUvLi1Fu1KXI+/DcAyv2GCBWtqq8D3U3dYflFMmIVgdwz/0OkMBkvZPHnYlVGUABwTM+gM1Vr/VcKNHb2PdMC3IpknYr16gHmh+YB8aQM8Rt3ynYI5Rjh0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364748; c=relaxed/simple;
	bh=UsZV0AolD/+FccDLn/0xyXNKUx4B8DSaspUvvDCME64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cdesv2v5WcJH8TMBKDnr0CA0rWaPu4j2cCfxCIEJE56UHF7+ee8+WEz8kfWVjFIr4mekWvGjaFXAMFYBhVujtUQhg+zu/ll+hiRjKttliN2pQOR6Gp84NjEyWOMudWAU5j3Qo1YkzX1aXBgheoZrwE1E+ALjzpxt9AyErI5YVoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e9c8haZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB75C4CEE2;
	Fri,  7 Mar 2025 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741364748;
	bh=UsZV0AolD/+FccDLn/0xyXNKUx4B8DSaspUvvDCME64=;
	h=From:To:Cc:Subject:Date:From;
	b=e9c8haZjj8e/VVTFtOZ4zmQR3r+1vW4apm+sgrpcQUpR4WHx7Ge7U1hXWyvQv/l1t
	 Uo0+HRfDX9D9Es3Je9314WyqYUKtxPaQ66b2aU0KjWaZmc6Lk9XJ/2XQV2OlA7rM4z
	 UjtWCmStTPYAqlcN/emHjQpcsrASRTPAvr2muZ4o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.81
Date: Fri,  7 Mar 2025 17:25:42 +0100
Message-ID: <2025030719-constrain-tinderbox-0271@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.81 kernel.

All users, EXCEPT i386 systems, of the 6.6 kernel series must upgrade.

Note, the i386 arch is currently broken, please wait for the next
release before you upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt       |    5 
 Makefile                                              |    2 
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi       |    5 
 arch/riscv/include/asm/futex.h                        |    2 
 arch/riscv/include/asm/kvm_host.h                     |    8 
 arch/riscv/kernel/signal.c                            |    6 
 arch/riscv/kvm/vcpu.c                                 |   48 -
 arch/riscv/kvm/vcpu_sbi.c                             |    7 
 arch/riscv/kvm/vcpu_sbi_hsm.c                         |   45 -
 arch/riscv/kvm/vcpu_sbi_replace.c                     |   15 
 arch/x86/Kconfig                                      |   26 
 arch/x86/events/core.c                                |    2 
 arch/x86/include/asm/apic.h                           |    5 
 arch/x86/include/asm/cpu.h                            |   20 
 arch/x86/include/asm/microcode.h                      |   16 
 arch/x86/kernel/apic/apic_flat_64.c                   |    2 
 arch/x86/kernel/apic/ipi.c                            |    8 
 arch/x86/kernel/apic/x2apic_cluster.c                 |    1 
 arch/x86/kernel/apic/x2apic_phys.c                    |    1 
 arch/x86/kernel/cpu/common.c                          |   12 
 arch/x86/kernel/cpu/cyrix.c                           |    4 
 arch/x86/kernel/cpu/microcode/amd.c                   |  636 +++++++++++-----
 arch/x86/kernel/cpu/microcode/amd_shas.c              |  444 +++++++++++
 arch/x86/kernel/cpu/microcode/core.c                  |  685 +++++++++++-------
 arch/x86/kernel/cpu/microcode/intel.c                 |  670 +++++------------
 arch/x86/kernel/cpu/microcode/internal.h              |   49 -
 arch/x86/kernel/head32.c                              |    3 
 arch/x86/kernel/head_32.S                             |   10 
 arch/x86/kernel/nmi.c                                 |    9 
 arch/x86/kernel/smpboot.c                             |   12 
 drivers/firmware/cirrus/cs_dsp.c                      |   24 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   14 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |    3 
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c            |   25 
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c        |    8 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c            |   26 
 drivers/i2c/busses/i2c-ls2x.c                         |   16 
 drivers/i2c/busses/i2c-npcm7xx.c                      |    7 
 drivers/idle/intel_idle.c                             |    4 
 drivers/infiniband/core/sysfs.c                       |    4 
 drivers/infiniband/core/uverbs_std_types_device.c     |    3 
 drivers/infiniband/core/verbs.c                       |    3 
 drivers/infiniband/hw/mana/main.c                     |    2 
 drivers/infiniband/hw/mlx5/ah.c                       |    3 
 drivers/infiniband/hw/mlx5/counters.c                 |    8 
 drivers/infiniband/hw/mlx5/qp.c                       |   10 
 drivers/infiniband/hw/mlx5/qp.h                       |    1 
 drivers/net/ethernet/cadence/macb.h                   |    2 
 drivers/net/ethernet/cadence/macb_main.c              |   12 
 drivers/net/ethernet/freescale/enetc/enetc.c          |  100 +-
 drivers/net/ethernet/google/gve/gve.h                 |   10 
 drivers/net/ethernet/google/gve/gve_main.c            |    6 
 drivers/net/ethernet/intel/ice/ice.h                  |    1 
 drivers/net/ethernet/intel/ice/ice_common.c           |   71 +
 drivers/net/ethernet/intel/ice/ice_devids.h           |   10 
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c     |   24 
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h       |   55 +
 drivers/net/ethernet/intel/ice/ice_lib.c              |    3 
 drivers/net/ethernet/intel/ice/ice_main.c             |   37 
 drivers/net/ethernet/intel/ice/ice_sriov.c            |    4 
 drivers/net/ethernet/intel/ice/ice_type.h             |    3 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c           |   34 
 drivers/net/ethernet/intel/ice/ice_vf_lib_private.h   |    1 
 drivers/net/ethernet/intel/ice/ice_vf_mbx.c           |   32 
 drivers/net/ethernet/intel/ice/ice_vf_mbx.h           |    9 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c         |    8 
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c    |   29 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c     |    2 
 drivers/net/ethernet/ti/icssg/icss_iep.c              |   35 
 drivers/net/ipvlan/ipvlan_core.c                      |   24 
 drivers/net/loopback.c                                |   14 
 drivers/net/usb/gl620a.c                              |    4 
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c    |    5 
 drivers/phy/samsung/phy-exynos5-usbdrd.c              |   12 
 drivers/phy/tegra/xusb-tegra186.c                     |   11 
 drivers/platform/x86/intel/ifs/load.c                 |    8 
 drivers/scsi/scsi_lib.c                               |   14 
 drivers/ufs/core/ufs_bsg.c                            |    6 
 drivers/ufs/core/ufshcd-priv.h                        |    5 
 drivers/ufs/core/ufshcd.c                             |  122 ++-
 fs/afs/cell.c                                         |    1 
 fs/afs/internal.h                                     |   23 
 fs/afs/server.c                                       |    1 
 fs/afs/server_list.c                                  |  114 ++
 fs/afs/vl_alias.c                                     |    2 
 fs/afs/volume.c                                       |   36 
 fs/overlayfs/copy_up.c                                |    2 
 include/asm-generic/vmlinux.lds.h                     |    2 
 include/linux/rcuref.h                                |    9 
 include/linux/sunrpc/sched.h                          |   17 
 include/net/dst.h                                     |    9 
 include/net/ip.h                                      |    5 
 include/net/route.h                                   |    5 
 include/rdma/ib_verbs.h                               |    2 
 include/trace/events/icmp.h                           |   67 +
 include/trace/events/sunrpc.h                         |    3 
 include/uapi/rdma/ib_user_ioctl_verbs.h               |    3 
 include/ufs/ufs.h                                     |   13 
 include/ufs/ufshcd.h                                  |    4 
 io_uring/net.c                                        |    4 
 kernel/events/core.c                                  |   31 
 kernel/events/uprobes.c                               |    5 
 kernel/sched/core.c                                   |    2 
 kernel/trace/ftrace.c                                 |   27 
 kernel/trace/trace_events_hist.c                      |   30 
 lib/rcuref.c                                          |    5 
 net/bluetooth/l2cap_core.c                            |    9 
 net/bridge/br_netfilter_hooks.c                       |    8 
 net/core/gro.c                                        |    1 
 net/core/skbuff.c                                     |    2 
 net/core/sysctl_net_core.c                            |    3 
 net/ipv4/icmp.c                                       |   24 
 net/ipv4/ip_options.c                                 |    3 
 net/ipv4/tcp_minisocks.c                              |   10 
 net/ipv6/ip6_tunnel.c                                 |    4 
 net/ipv6/rpl_iptunnel.c                               |   58 -
 net/ipv6/seg6_iptunnel.c                              |   97 +-
 net/mptcp/pm_netlink.c                                |    5 
 net/mptcp/subflow.c                                   |   15 
 net/rxrpc/rxperf.c                                    |   12 
 net/sunrpc/cache.c                                    |   10 
 net/sunrpc/sched.c                                    |    2 
 net/sunrpc/xprtsock.c                                 |   10 
 sound/pci/hda/patch_realtek.c                         |   32 
 sound/soc/codecs/es8328.c                             |   15 
 sound/usb/midi.c                                      |    2 
 sound/usb/quirks.c                                    |    1 
 tools/testing/selftests/rseq/rseq-riscv-bits.h        |    6 
 tools/testing/selftests/rseq/rseq-riscv.h             |    2 
 tools/tracing/rtla/src/timerlat_hist.c                |    2 
 tools/tracing/rtla/src/timerlat_top.c                 |    2 
 132 files changed, 2867 insertions(+), 1524 deletions(-)

Adrien Vergé (1):
      ALSA: hda/realtek: Fix microphone regression on ASUS N705UD

Andreas Schwab (1):
      riscv/futex: sign extend compare value in atomic cmpxchg

Andrew Jones (3):
      riscv: KVM: Fix hart suspend status check
      riscv: KVM: Fix SBI IPI error generation
      riscv: KVM: Fix SBI TIME error generation

Ard Biesheuvel (1):
      vmlinux.lds: Ensure that const vars with relocations are mapped R/O

Arnd Bergmann (1):
      sunrpc: suppress warnings for unused procfs functions

Arthur Simchaev (1):
      scsi: ufs: core: bsg: Fix crash when arpmb command fails

Ashok Raj (1):
      x86/microcode/intel: Rip out mixed stepping support for Intel CPUs

Avri Altman (2):
      scsi: ufs: core: Introduce ufshcd_has_pending_tasks()
      scsi: ufs: core: Prepare to introduce a new clock_gating lock

BH Hsieh (1):
      phy: tegra: xusb: reset VBUS & ID OVERRIDE

Bart Van Assche (2):
      scsi: ufs: core: Fix ufshcd_is_ufs_dev_busy() and ufshcd_eh_timed_out()
      scsi: ufs: core: Start the RTC update work later

Bean Huo (2):
      scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()
      scsi: ufs: core: Add UFS RTC support

Benjamin Coddington (1):
      SUNRPC: Handle -ETIMEDOUT return from tlshd

Binbin Zhou (1):
      i2c: ls2x: Fix frequency division register access

Borislav Petkov (1):
      x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID

Borislav Petkov (AMD) (11):
      x86/microcode: Rework early revisions reporting
      x86/microcode/intel: Set new revision only after a successful update
      x86/microcode/AMD: Pay attention to the stepping dynamically
      x86/microcode/AMD: Split load_microcode_amd()
      x86/microcode/AMD: Flush patch buffer mapping after application
      x86/microcode/AMD: Have __apply_microcode_amd() return bool
      x86/microcode/AMD: Merge early_apply_microcode() into its single callsite
      x86/microcode/AMD: Get rid of the _load_microcode_amd() forward declaration
      x86/microcode/AMD: Add get_patch_level()
      x86/microcode/AMD: Load only SHA256-checksummed patches
      x86/microcode/AMD: Fix a -Wsometimes-uninitialized clang false positive

Breno Leitao (1):
      perf/core: Add RCU read lock protection to perf_iterate_ctx()

Chang S. Bae (1):
      x86/microcode/intel: Remove unnecessary cache writeback and invalidation

Chukun Pan (1):
      phy: rockchip: naneng-combphy: compatible reset with old DT

David Howells (3):
      rxrpc: rxperf: Fix missing decoding of terminal magic cookie
      afs: Make it possible to find the volumes that are using a server
      afs: Fix the server_list to unuse a displaced server rather than putting it

Diogo Ivo (1):
      net: ti: icss-iep: Remove spinlock-based synchronization

Dmitry Panchenko (1):
      ALSA: usb-audio: Re-add sample rate quirk for Pioneer DJM-900NXS2

Eric Dumazet (1):
      ipvlan: ensure network headers are in skb linear part

Greg Kroah-Hartman (1):
      Linux 6.6.81

Guillaume Nault (3):
      ipv4: Convert icmp_route_lookup() to dscp_t.
      ipv4: Convert ip_route_input() to dscp_t.
      ipvlan: Prepare ipvlan_process_v4_outbound() to future .flowi4_tos conversion.

Harshal Chaudhari (1):
      net: mvpp2: cls: Fixed Non IP flow, with vlan tag flow defination.

Ido Schimmel (4):
      net: loopback: Avoid sending IP packets without an Ethernet header
      ipv4: icmp: Pass full DS field to ip_route_input()
      ipv4: icmp: Unmask upper DSCP bits in icmp_route_lookup()
      ipvlan: Unmask upper DSCP bits in ipvlan_process_v4_outbound()

Jiri Slaby (SUSE) (1):
      net: set the minimum for net_hotdata.netdev_budget_usecs

Joshua Washington (1):
      gve: set xdp redirect target only when it is available

Justin Iurman (5):
      include: net: add static inline dst_dev_overhead() to dst.h
      net: ipv6: seg6_iptunnel: mitigate 2-realloc issue
      net: ipv6: fix dst ref loop on input in seg6 lwt
      net: ipv6: rpl_iptunnel: mitigate 2-realloc issue
      net: ipv6: fix dst ref loop on input in rpl lwt

Kan Liang (2):
      perf/x86: Fix low freqency setting issue
      perf/core: Fix low freq setting via IOC_PERIOD

Kaustabh Chakraborty (1):
      phy: exynos5-usbdrd: fix MPLL_MULTIPLIER and SSC_REFCLKSEL masks in refclk

Konstantin Taranov (1):
      RDMA/mana_ib: Allocate PAGE aligned doorbell index

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response

Lukasz Czechowski (1):
      arm64: dts: rockchip: Disable DMA for uart5 on px30-ringneck

Luo Gengkun (1):
      perf/core: Order the PMU list to fix warning about unordered pmu_ctx_list

Manivannan Sadhasivam (1):
      scsi: ufs: core: Cancel RTC work during ufshcd_remove()

Marcin Szycik (1):
      ice: Fix deinitializing VF in error path

Mark Zhang (1):
      IB/mlx5: Set and get correct qp_num for a DCT QP

Matthieu Baerts (NGI0) (1):
      mptcp: reset when MPTCP opts are dropped after join

Meghana Malladi (1):
      net: ti: icss-iep: Reject perout generation request

Mohammad Heib (1):
      net: Clear old fragment checksum value in napi_reuse_skb

Nicolas Frattaroli (1):
      ASoC: es8328: fix route from DAC to output

Nikita Zhandarovich (1):
      usbnet: gl620a: fix endpoint checking in genelink_bind()

Nikolay Borisov (2):
      x86/microcode/AMD: Return bool from find_blobs_in_containers()
      x86/microcode/AMD: Make __verify_patch_size() return bool

Nikolay Kuratov (1):
      ftrace: Avoid potential division by zero in function_stat_show()

Or Har-Toov (1):
      IB/core: Add support for XDR link speed

Paolo Abeni (1):
      mptcp: always handle address removal under msk socket lock

Patrisious Haddad (2):
      RDMA/mlx5: Fix AH static rate parsing
      RDMA/mlx5: Fix bind QP error cleanup flow

Paul Greenwalt (2):
      ice: Add E830 device IDs, MAC type and registers
      ice: add E830 HW VF mailbox message limit support

Pavel Begunkov (1):
      io_uring/net: save msg_control for compat

Peilin He (1):
      net/ipv4: add tracepoint for icmp_send

Peter Wang (2):
      scsi: ufs: core: Fix deadlock during RTC update
      scsi: ufs: core: Fix another deadlock during RTC update

Philo Lu (1):
      ipvs: Always clear ipvs_property flag in skb_scrub_packet()

Richard Fitzgerald (1):
      firmware: cs_dsp: Remove async regmap writes

Roman Li (1):
      drm/amd/display: Fix HPD after gpu reset

Russell Senior (1):
      x86/CPU: Fix warm boot hang regression on AMD SC1100 SoC systems

Sean Anderson (1):
      net: cadence: macb: Synchronize stats calculations

Shay Drory (1):
      net/mlx5: IRQ, Fix null string in debug print

Stafford Horne (1):
      rseq/selftests: Fix riscv rseq_offset_deref_addv inline asm

Stefan Binding (1):
      ALSA: hda/realtek: Add quirks for ASUS ROG 2023 models

Stephen Brennan (1):
      SUNRPC: convert RPC_TASK_* constants to enum

Steven Rostedt (1):
      tracing: Fix bad hist from corrupting named_triggers list

Takashi Iwai (2):
      ALSA: usb-audio: Avoid dropping MIDI events at closing multiple ports
      ALSA: hda/realtek: Fix wrong mic setup for ASUS VivoBook 15

Thomas Gleixner (34):
      rcuref: Plug slowpath race in rcuref_put()
      sched/core: Prevent rescheduling when interrupts are disabled
      intel_idle: Handle older CPUs, which stop the TSC in deeper C states, correctly
      x86/microcode/32: Move early loading after paging enable
      x86/microcode/intel: Simplify scan_microcode()
      x86/microcode/intel: Simplify and rename generic_load_microcode()
      x86/microcode/intel: Cleanup code further
      x86/microcode/intel: Simplify early loading
      x86/microcode/intel: Save the microcode only after a successful late-load
      x86/microcode/intel: Switch to kvmalloc()
      x86/microcode/intel: Unify microcode apply() functions
      x86/microcode/intel: Rework intel_cpu_collect_info()
      x86/microcode/intel: Reuse intel_cpu_collect_info()
      x86/microcode/intel: Rework intel_find_matching_signature()
      x86/microcode: Remove pointless apply() invocation
      x86/microcode/amd: Use correct per CPU ucode_cpu_info
      x86/microcode/amd: Cache builtin microcode too
      x86/microcode/amd: Cache builtin/initrd microcode early
      x86/microcode/amd: Use cached microcode for AP load
      x86/microcode: Mop up early loading leftovers
      x86/microcode: Get rid of the schedule work indirection
      x86/microcode: Clean up mc_cpu_down_prep()
      x86/microcode: Handle "nosmt" correctly
      x86/microcode: Clarify the late load logic
      x86/microcode: Sanitize __wait_for_cpus()
      x86/microcode: Add per CPU result state
      x86/microcode: Add per CPU control field
      x86/microcode: Provide new control functions
      x86/microcode: Replace the all-in-one rendevous handler
      x86/microcode: Rendezvous and load in NMI
      x86/microcode: Protect against instrumentation
      x86/apic: Provide apic_force_nmi_on_cpu()
      x86/microcode: Handle "offline" CPUs correctly
      x86/microcode: Prepare for minimal revision check

Tom Chung (1):
      drm/amd/display: Disable PSR-SU on eDP panels

Tomas Glozar (4):
      Revert "rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads"
      Revert "rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads"
      rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
      rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads

Tong Tiangen (1):
      uprobes: Reject the shared zeropage in uprobe_write_opcode()

Trond Myklebust (1):
      SUNRPC: Prevent looping due to rpc_signal_task() races

Tyrone Ting (1):
      i2c: npcm: disable interrupt enable bit before devm_request_irq

Vasiliy Kovalev (1):
      ovl: fix UAF in ovl_dentry_update_reval by moving dput() in ovl_link_up

Wang Hai (1):
      tcp: Defer ts_recent changes until req is owned

Wei Fang (5):
      net: enetc: fix the off-by-one issue in enetc_map_tx_buffs()
      net: enetc: keep track of correct Tx BD count in enetc_map_tx_tso_buffs()
      net: enetc: update UDP checksum when updating originTimestamp field
      net: enetc: correct the xdp_tx statistics
      net: enetc: fix the off-by-one issue in enetc_map_tx_tso_buffs()

Ye Bin (1):
      scsi: core: Clear driver private data when retrying request

Yong-Xuan Wang (2):
      RISCV: KVM: Introduce mp_state_lock to avoid lock inversion
      riscv: signal: fix signal frame size

chr[] (1):
      amdgpu/pm/legacy: fix suspend/resume issues


