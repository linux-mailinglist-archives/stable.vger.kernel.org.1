Return-Path: <stable+bounces-91949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F719C2159
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 17:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CAF2818DE
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 16:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77CE21C17F;
	Fri,  8 Nov 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XlFbK+QC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01BB21B448;
	Fri,  8 Nov 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081592; cv=none; b=EiDvZEBVM0vDQrynWY5DhPsdxNBYWb3bjKyyaL0Q7Nr4pvFqHUdBNQU/WROnRLbQclYm+flGKtwjA8OyQtBbJzG2jN8erLyX12WRgsJDvxSCAQ4q2P16CKituG3GoHtGvZPHqR75nduwIK+x7hFE7XuG2kx87LTBAEIOoi+62c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081592; c=relaxed/simple;
	bh=TTvpH7HxU3J7nrnDI1wuUiF8g2sdn/L9Z+7EJ2RbvAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UkHubi0RWH68Wf/BGHR7bw2wdJrBdCeCUjFQLLR7kgMkd7JWo7EsUT9D8SRZ5M+0MMu6bxXh0QXwGW4zu4xRPcLNCD0F8QBRouCSSaCzR4iZ6K3EU1SpMzMOi7ei9kWI3pLcZpzZ8gKnltO4zwjqcuvQO+vDhQjc06p900nrcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XlFbK+QC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215D8C4CECD;
	Fri,  8 Nov 2024 15:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731081592;
	bh=TTvpH7HxU3J7nrnDI1wuUiF8g2sdn/L9Z+7EJ2RbvAI=;
	h=From:To:Cc:Subject:Date:From;
	b=XlFbK+QC0/fwOjaGd+Yuvf97Qc23o0XKtposU8vGZD8EKriOteABmUtVHWjJejqU8
	 C6VRC0iGnR1aA4ITtO/Hu3WaqKzkufFcQj5UyWUykq3XEZ/+7yHY0j5PRhLAKJGGWT
	 r3bl+KHGnKMpblwpWwNngcxt955GefNsAXnICTcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.229
Date: Fri,  8 Nov 2024 16:59:22 +0100
Message-ID: <2024110823-reprimand-undaunted-11c0@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.229 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                        |    2 
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts       |    2 
 arch/arm64/Makefile                             |    2 
 arch/arm64/include/asm/uprobes.h                |   12 -
 arch/arm64/kernel/probes/uprobes.c              |    4 
 arch/riscv/kernel/asm-offsets.c                 |    2 
 arch/riscv/kernel/cpu-hotplug.c                 |    2 
 arch/riscv/kernel/efi-header.S                  |    2 
 arch/riscv/kernel/traps_misaligned.c            |    2 
 arch/riscv/kernel/vdso/Makefile                 |    1 
 arch/s390/include/asm/perf_event.h              |    1 
 arch/s390/kvm/gaccess.c                         |  162 ++++++++++++++----------
 arch/s390/kvm/gaccess.h                         |   14 +-
 arch/x86/include/asm/nospec-branch.h            |   11 +
 arch/x86/kvm/svm/nested.c                       |    6 
 block/bfq-iosched.c                             |   33 ++--
 drivers/acpi/button.c                           |   11 +
 drivers/acpi/resource.c                         |    7 +
 drivers/base/core.c                             |   13 -
 drivers/base/module.c                           |    4 
 drivers/firmware/arm_sdei.c                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c        |   15 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c          |    5 
 drivers/gpu/drm/drm_mipi_dsi.c                  |    2 
 drivers/gpu/drm/msm/dsi/dsi_host.c              |    2 
 drivers/gpu/drm/vboxvideo/hgsmi_base.c          |   10 +
 drivers/gpu/drm/vboxvideo/vboxvideo.h           |    4 
 drivers/iio/light/veml6030.c                    |    2 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c        |    4 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h        |    2 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c      |   15 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h      |    2 
 drivers/infiniband/hw/bnxt_re/qplib_res.c       |   21 ---
 drivers/infiniband/hw/cxgb4/cm.c                |    9 -
 drivers/infiniband/hw/cxgb4/provider.c          |    1 
 drivers/infiniband/hw/mlx5/qp.c                 |    4 
 drivers/misc/sgi-gru/grukservices.c             |    2 
 drivers/misc/sgi-gru/grumain.c                  |    4 
 drivers/misc/sgi-gru/grutlbpurge.c              |    2 
 drivers/net/ethernet/aeroflex/greth.c           |    3 
 drivers/net/ethernet/amd/mvme147.c              |    7 -
 drivers/net/ethernet/broadcom/bcmsysport.c      |    1 
 drivers/net/ethernet/emulex/benet/be_main.c     |   10 -
 drivers/net/ethernet/i825xx/sun3_82586.c        |    1 
 drivers/net/ethernet/realtek/r8169_main.c       |    4 
 drivers/net/gtp.c                               |   22 +--
 drivers/net/hyperv/netvsc_drv.c                 |   30 ++++
 drivers/net/macsec.c                            |   18 --
 drivers/net/phy/dp83822.c                       |    4 
 drivers/net/usb/usbnet.c                        |    3 
 drivers/net/wireless/ath/ath10k/wmi-tlv.c       |    7 -
 drivers/net/wireless/ath/ath10k/wmi.c           |    2 
 drivers/net/wireless/broadcom/brcm80211/Kconfig |    1 
 drivers/net/wireless/intel/iwlegacy/common.c    |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c     |   22 ++-
 drivers/staging/iio/frequency/ad9832.c          |    7 -
 drivers/target/target_core_device.c             |    2 
 drivers/target/target_core_user.c               |    2 
 drivers/tty/serial/serial_core.c                |   16 +-
 drivers/tty/vt/vt.c                             |    2 
 drivers/usb/host/xhci-pci.c                     |    6 
 drivers/usb/host/xhci-ring.c                    |   16 +-
 drivers/usb/phy/phy.c                           |    2 
 drivers/usb/typec/class.c                       |    3 
 fs/cifs/smb2pdu.c                               |    9 +
 fs/exec.c                                       |   21 +--
 fs/iomap/direct-io.c                            |   18 +-
 fs/jfs/jfs_dmap.c                               |    2 
 fs/nfs/delegation.c                             |    5 
 fs/nilfs2/namei.c                               |    3 
 fs/nilfs2/page.c                                |    7 -
 fs/ocfs2/file.c                                 |    8 +
 fs/open.c                                       |    2 
 include/linux/compiler-gcc.h                    |   12 -
 include/linux/mm.h                              |    2 
 include/net/genetlink.h                         |    3 
 include/net/ip_tunnels.h                        |    2 
 include/net/mac80211.h                          |   10 +
 include/net/xfrm.h                              |   28 ++--
 kernel/bpf/lpm_trie.c                           |    2 
 kernel/cgroup/cgroup.c                          |    4 
 kernel/time/posix-clock.c                       |    6 
 kernel/trace/trace_probe.c                      |    2 
 mm/memory.c                                     |   70 +++++++---
 mm/shmem.c                                      |    2 
 net/bluetooth/bnep/core.c                       |    3 
 net/core/dev.c                                  |   17 ++
 net/ipv4/devinet.c                              |   35 +++--
 net/ipv4/xfrm4_policy.c                         |   40 ++---
 net/ipv6/xfrm6_policy.c                         |   31 ++--
 net/l2tp/l2tp_netlink.c                         |    4 
 net/mac80211/Kconfig                            |    2 
 net/mac80211/cfg.c                              |    3 
 net/mac80211/ieee80211_i.h                      |    3 
 net/mac80211/key.c                              |   42 +++---
 net/mac80211/mlme.c                             |   14 +-
 net/mac80211/util.c                             |   45 +++++-
 net/netfilter/nft_payload.c                     |    3 
 net/netlink/genetlink.c                         |   28 ++--
 net/sched/sch_api.c                             |    2 
 net/sched/sch_taprio.c                          |    3 
 net/smc/smc_pnet.c                              |    2 
 net/wireless/nl80211.c                          |    8 -
 net/xfrm/xfrm_device.c                          |   11 +
 net/xfrm/xfrm_policy.c                          |   50 +++++--
 net/xfrm/xfrm_user.c                            |    6 
 security/selinux/selinuxfs.c                    |   27 ++--
 sound/firewire/amdtp-stream.c                   |    3 
 sound/pci/hda/patch_realtek.c                   |   48 ++++---
 sound/soc/codecs/cs42l51.c                      |    7 -
 sound/soc/fsl/fsl_sai.c                         |    5 
 sound/soc/fsl/fsl_sai.h                         |    1 
 sound/soc/qcom/lpass-cpu.c                      |    2 
 tools/testing/selftests/vm/hmm-tests.c          |    2 
 tools/usb/usbip/src/usbip_detach.c              |    1 
 115 files changed, 789 insertions(+), 471 deletions(-)

Aleksa Sarai (1):
      openat2: explicitly return -E2BIG for (usize > PAGE_SIZE)

Alexandre Ghiti (1):
      riscv: vdso: Prevent the compiler from inserting calls to memset()

Andrey Shumilin (1):
      ALSA: firewire-lib: Avoid division by zero in apply_constraint_to_size()

Anumula Murali Mohan Reddy (1):
      RDMA/cxgb4: Fix RDMA_CM_EVENT_UNREACHABLE error for iWARP

Basavaraj Natikar (1):
      xhci: Use pm_runtime_get to prevent RPM on unsupported systems

Benoît Monin (1):
      net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension

Bhargava Chenna Marreddy (1):
      RDMA/bnxt_re: Fix a bug while setting up Level-2 PBL pages

Byeonguk Jeong (1):
      bpf: Fix out-of-bounds write in trie_get_next_key()

Christian Heusel (1):
      ACPI: resource: Add LG 16T90SP to irq1_level_low_skip_override[]

Christoph Hellwig (2):
      iomap: update ki_pos a little later in iomap_dio_complete
      mm: add remap_pfn_range_notrack

Christophe JAILLET (1):
      ASoC: cs42l51: Fix some error handling paths in cs42l51_probe()

Chunyan Zhang (2):
      riscv: Remove unused GENERATING_ASM_OFFSETS
      riscv: Remove duplicated GET_RM

Dai Ngo (1):
      NFS: remove revoked delegation from server's delegation list

Daniel Gabay (1):
      wifi: iwlwifi: mvm: Fix response handling in iwl_mvm_send_recovery_cmd()

Daniel Palmer (1):
      net: amd: mvme147: Fix probe banner message

Dave Kleikamp (1):
      jfs: Fix sanity check in dbMount

Dimitri Sivanich (1):
      misc: sgi-gru: Don't disable preemption in GRU driver

Dmitry Antipov (1):
      net: sched: fix use-after-free in taprio_change()

Donet Tom (1):
      selftests/mm: fix incorrect buffer->mirror size in hmm2 double_map test

Edward Adam Davis (1):
      ocfs2: pass u64 to ocfs2_truncate_inline maybe overflow

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: disconnect station vifs if recovery failed

Eric Dumazet (1):
      genetlink: hold RCU in genlmsg_mcast()

Eyal Birger (2):
      xfrm: extract dst lookup parameters into a struct
      xfrm: respect ip protocols rules criteria when performing dst lookups

Faisal Hassan (1):
      xhci: Fix Link TRB DMA in command ring stopped completion event

Felix Fietkau (2):
      wifi: mac80211: skip non-uploaded keys in ieee80211_iter_keys
      wifi: mac80211: do not pass a stopped vif to the driver in .get_txpower

Florian Klink (1):
      ARM: dts: bcm2837-rpi-cm3-io3: Fix HDMI hpd-gpio pin

Geert Uytterhoeven (2):
      mac80211: MAC80211_MESSAGE_TRACING should depend on TRACING
      wifi: brcm80211: BRCM_TRACING should depend on TRACING

Greg Kroah-Hartman (2):
      Revert "driver core: Fix uevent_show() vs driver detach race"
      Linux 5.10.229

Haiyang Zhang (1):
      hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event

Hans de Goede (1):
      drm/vboxvideo: Replace fake VLA at end of vbva_mouse_pointer_shape with real VLA

Heiko Carstens (1):
      s390: Initialize psw mask in perf_arch_fetch_caller_regs()

Heiner Kallweit (1):
      r8169: avoid unsolicited interrupts

Heinrich Schuchardt (1):
      riscv: efi: Set NX compat flag in PE/COFF header

Ido Schimmel (1):
      ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_init_flow()

Janis Schoetterl-Glausch (3):
      KVM: s390: gaccess: Refactor gpa and length calculation
      KVM: s390: gaccess: Refactor access address range check
      KVM: s390: gaccess: Cleanup access to guest pages

Jason-JH.Lin (1):
      Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"

Javier Carrasco (1):
      iio: light: veml6030: fix microlux value calculation

Jeongjun Park (2):
      mm: shmem: fix data-race in shmem_getattr()
      vt: prevent kernel-infoleak in con_font_get()

Jinjie Ruan (1):
      posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime()

Jiri Slaby (SUSE) (1):
      serial: protect uart_port_dtr_rts() in uart_shutdown() too

Johannes Berg (2):
      mac80211: do drv_reconfig_complete() before restarting all
      mac80211: always have ieee80211_sta_restart()

Jonathan Marek (1):
      drm/msm/dsi: fix 32-bit signed integer extension in pclk_rate calculation

José Relvas (1):
      ALSA: hda/realtek: Add subwoofer quirk for Acer Predator G9-593

Kailang Yang (1):
      ALSA: hda/realtek: Update default depop procedure

Kalesh AP (2):
      RDMA/bnxt_re: Add a check for memory allocation
      RDMA/bnxt_re: Return more meaningful error

Leo Yan (1):
      tracing: Consider the NULL character when validating the event length

Leon Romanovsky (1):
      RDMA/cxgb4: Dump vendor specific QP details

Li RongQing (1):
      net/smc: Fix searching in list of known pnetids in smc_pnet_add_pnetid

Linus Torvalds (1):
      mm: avoid leaving partial pfn mappings around in error case

Manikanta Pubbisetty (1):
      wifi: ath10k: Fix memory leak in management tx

Marco Elver (1):
      kasan: Fix Software Tag-Based KASAN with GCC

Mario Limonciello (1):
      drm/amd: Guard against bad data for ATIF ACPI method

Mark Rutland (2):
      arm64: probes: Fix uprobes for big-endian kernels
      arm64: Force position-independent veneers

Mateusz Guzik (1):
      exec: don't WARN for racy path_noexec check

Michel Alex (1):
      net: phy: dp83822: Fix reset pin definitions

Miguel Ojeda (2):
      compiler-gcc: be consistent with underscores use for `no_sanitize`
      compiler-gcc: remove attribute support check for `__no_sanitize_address__`

Nico Boehr (1):
      KVM: s390: gaccess: Check if guest address is in memslot

Oliver Neukum (1):
      net: usb: usbnet: fix name regression

Pablo Neira Ayuso (2):
      gtp: allow -1 to be specified as file description from userspace
      netfilter: nft_payload: sanitize offset and length before calling skb_checksum()

Patrisious Haddad (1):
      RDMA/mlx5: Round max_rd_atomic/max_dest_rd_atomic up instead of down

Paul Moore (1):
      selinux: improve error checking in sel_write_load()

Paulo Alcantara (1):
      smb: client: fix OOBs when building SMB2_IOCTL request

Pawan Gupta (1):
      x86/bugs: Use code segment selector for VERW operand

Pedro Tammela (1):
      net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT

Ryusuke Konishi (3):
      nilfs2: fix kernel bug due to missing clearing of buffer delay flag
      nilfs2: fix potential deadlock with newly created symlinks
      nilfs2: fix kernel bug due to missing clearing of checked flag

Sabrina Dubroca (2):
      macsec: don't increment counters for an unrelated SA
      xfrm: validate new SA's prefixlen using SA family when sel.family is unset

Saravanan Vajravel (1):
      RDMA/bnxt_re: Fix incorrect AVID type in WQE structure

Sean Christopherson (1):
      KVM: nSVM: Ignore nCR3[4:0] when loading PDPTEs from memory

Selvin Xavier (1):
      RDMA/bnxt_re: synchronize the qp-handle table array

Shengjiu Wang (1):
      ASoC: fsl_sai: Enable 'FIFO continue on error' FCONT bit

Shubham Panwar (1):
      ACPI: button: Add DMI quirk for Samsung Galaxy Book2 to fix initial lid detection issue

Thadeu Lima de Souza Cascardo (1):
      usb: typec: altmode should keep reference to parent

Ville Syrjälä (1):
      wifi: iwlegacy: Clear stale interrupts before resuming device

Wachowski, Karol (1):
      drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE, MAP_PRIVATE)

Wang Hai (5):
      net: ethernet: aeroflex: fix potential memory leak in greth_start_xmit_gbit()
      net: systemport: fix potential memory leak in bcm_sysport_xmit()
      scsi: target: core: Fix null-ptr-deref in target_alloc_device()
      net/sun3_82586: fix potential memory leak in sun3_82586_send_packet()
      be2net: fix potential memory leak in be_xmit()

WangYuli (1):
      riscv: Use '%u' to format the output of 'cpu'

Xin Long (2):
      ipv4: give an IPv4 dev to blackhole_netdev
      net: support ip generic csum processing in skb_csum_hwoffload_help

Xiongfeng Wang (1):
      firmware: arm_sdei: Fix the input parameter of cpuhp_remove_state()

Xiu Jianfeng (1):
      cgroup: Fix potential overflow issue when checking max_depth

Ye Bin (1):
      Bluetooth: bnep: fix wild-memory-access in proto_unregister

Youghandhar Chintala (1):
      mac80211: Add support to trigger sta disconnect on hardware restart

Yu Kuai (1):
      block, bfq: fix procress reference leakage for bfqq in merge chain

Zichen Xie (1):
      ASoC: qcom: Fix NULL Dereference in asoc_qcom_lpass_cpu_platform_probe()

Zicheng Qu (1):
      staging: iio: frequency: ad9832: fix division by zero in ad9832_calc_freqreg()

Zijun Hu (1):
      usb: phy: Fix API devm_usb_put_phy() can not release the phy

Zongmin Zhou (1):
      usbip: tools: Fix detach_port() invalid port error path

junhua huang (2):
      arm64:uprobe fix the uprobe SWBP_INSN in big-endian
      arm64/uprobes: change the uprobe_opcode_t typedef to fix the sparse warning


