Return-Path: <stable+bounces-121411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAB7A56D89
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E26C1778B8
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7CF23BCF6;
	Fri,  7 Mar 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oUCQAMKw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E6C21CC69;
	Fri,  7 Mar 2025 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364652; cv=none; b=ndJ6O39UHGyzVcehRyAEnMxBz/PtuS61Xm4xiD/P6XhPzoHiTZ6UPUhs7+uiWUZ8TftW3CvP7bKFZU/zT/Jur13Jwi1Nnm4p+x0rI1m3sJMbM3W9M0+u7V9d4/lc80rGVZ4CFbjpktJhi9J765SR898l5dL3wR55RwB2zO3vLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364652; c=relaxed/simple;
	bh=797fg6BNr1Cko5CYhRrTCZ9Ong9zVaIy5ldOleSRfMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h3aMY1GmfW+AEGGJZOcj7mVJJmcjLw7ODRVOG194wirejJzWsd27z6a/yyQodsvc+NBpeZITU6CRbedEsEl/0V47VX60njmWrWfeDKKo/nwzRyuWclS4kMAezsonTeNS+LTTlexzy+W0hG3hjOfoSbSOkK0wkCHGtRmJ/mpXmLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oUCQAMKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA41C4CED1;
	Fri,  7 Mar 2025 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741364652;
	bh=797fg6BNr1Cko5CYhRrTCZ9Ong9zVaIy5ldOleSRfMk=;
	h=From:To:Cc:Subject:Date:From;
	b=oUCQAMKwPCuWAqBPRDObZiVbO0i4FjPlPkj+AcXOhl/5Ix00n0+b49fEHxN1o3Ni2
	 +2Y+UBID8aF+PX3yX3MMKeYM2btNrYdcXM6DztyvRflLXqTblCN88gKdljls//gfFE
	 zDzjVB4kLzIz4C73GlwyOPIz6i4NvftCNnn16HPU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.130
Date: Fri,  7 Mar 2025 17:24:06 +0100
Message-ID: <2025030707-coaster-deferred-2234@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.130 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/core-api/pin_user_pages.rst                            |    6 
 Documentation/networking/strparser.rst                               |    9 
 Makefile                                                             |    2 
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                             |    1 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                 |    2 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                 |    4 
 arch/arm64/include/asm/mman.h                                        |    9 
 arch/mips/include/asm/ptrace.h                                       |    2 
 arch/mips/kernel/ptrace.c                                            |    7 
 arch/powerpc/include/asm/book3s/64/hash-4k.h                         |   28 +
 arch/powerpc/include/asm/book3s/64/pgtable.h                         |   26 -
 arch/powerpc/lib/code-patching.c                                     |    2 
 arch/riscv/include/asm/futex.h                                       |    2 
 arch/x86/Kconfig                                                     |    3 
 arch/x86/events/core.c                                               |    2 
 arch/x86/kernel/cpu/bugs.c                                           |   20 -
 arch/x86/kernel/cpu/cyrix.c                                          |    4 
 block/bfq-cgroup.c                                                   |   95 ++--
 block/bfq-iosched.c                                                  |  191 ++++++----
 block/bfq-iosched.h                                                  |   51 ++
 drivers/bluetooth/btqca.c                                            |  110 ++++-
 drivers/char/tpm/eventlog/acpi.c                                     |   16 
 drivers/char/tpm/eventlog/efi.c                                      |   13 
 drivers/char/tpm/eventlog/of.c                                       |    3 
 drivers/char/tpm/tpm-chip.c                                          |    1 
 drivers/clk/mediatek/clk-mt2701-bdp.c                                |    1 
 drivers/clk/mediatek/clk-mt2701-img.c                                |    1 
 drivers/clk/mediatek/clk-mt2701-vdec.c                               |    1 
 drivers/clk/mediatek/clk-mtk.c                                       |   16 
 drivers/clk/mediatek/clk-mtk.h                                       |   19 
 drivers/edac/qcom_edac.c                                             |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c                |   14 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c                |    3 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c                   |   16 
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c                           |   25 -
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c                       |    8 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                           |   26 +
 drivers/gpu/drm/i915/display/intel_display.c                         |   18 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                          |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c                           |    3 
 drivers/gpu/drm/nouveau/nouveau_svm.c                                |    9 
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c                              |    2 
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h                         |    1 
 drivers/gpu/drm/tidss/tidss_dispc.c                                  |   22 +
 drivers/gpu/drm/tidss/tidss_irq.c                                    |    2 
 drivers/i2c/busses/i2c-npcm7xx.c                                     |    7 
 drivers/idle/intel_idle.c                                            |    4 
 drivers/infiniband/hw/mlx5/counters.c                                |    8 
 drivers/infiniband/hw/mlx5/qp.c                                      |    4 
 drivers/md/md-bitmap.c                                               |   34 -
 drivers/md/md-bitmap.h                                               |    9 
 drivers/md/md-cluster.c                                              |   34 +
 drivers/md/md.c                                                      |   33 +
 drivers/media/cec/platform/stm32/stm32-cec.c                         |    9 
 drivers/media/i2c/ad5820.c                                           |   18 
 drivers/media/i2c/imx274.c                                           |    5 
 drivers/media/i2c/tc358743.c                                         |    9 
 drivers/media/platform/mediatek/mdp/mtk_mdp_comp.c                   |    5 
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c           |    2 
 drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c |    9 
 drivers/media/platform/samsung/exynos4-is/media-dev.c                |    4 
 drivers/media/platform/st/stm32/stm32-dcmi.c                         |   27 -
 drivers/media/platform/ti/omap3isp/isp.c                             |    3 
 drivers/media/platform/xilinx/xilinx-csi2rxss.c                      |    8 
 drivers/media/rc/gpio-ir-recv.c                                      |   10 
 drivers/media/rc/gpio-ir-tx.c                                        |    9 
 drivers/media/rc/ir-rx51.c                                           |    9 
 drivers/media/usb/uvc/uvc_ctrl.c                                     |   99 ++++-
 drivers/media/usb/uvc/uvc_driver.c                                   |   35 +
 drivers/media/usb/uvc/uvc_v4l2.c                                     |    2 
 drivers/media/usb/uvc/uvcvideo.h                                     |   10 
 drivers/mtd/nand/raw/cadence-nand-controller.c                       |   42 +-
 drivers/net/ethernet/cadence/macb.h                                  |    2 
 drivers/net/ethernet/cadence/macb_main.c                             |   12 
 drivers/net/ethernet/freescale/enetc/enetc.c                         |  100 +++--
 drivers/net/ethernet/ibm/ibmvnic.c                                   |   85 +++-
 drivers/net/ethernet/ibm/ibmvnic.h                                   |    3 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c                       |    2 
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c                    |    2 
 drivers/net/ethernet/netronome/nfp/bpf/cmsg.c                        |    2 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                    |    1 
 drivers/net/geneve.c                                                 |   16 
 drivers/net/gtp.c                                                    |    5 
 drivers/net/ipvlan/ipvlan_core.c                                     |   24 -
 drivers/net/loopback.c                                               |   14 
 drivers/net/usb/gl620a.c                                             |    4 
 drivers/nvme/host/ioctl.c                                            |    3 
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c                   |    5 
 drivers/phy/samsung/phy-exynos5-usbdrd.c                             |   12 
 drivers/phy/tegra/xusb-tegra186.c                                    |   11 
 drivers/power/supply/da9150-fg.c                                     |    4 
 drivers/scsi/scsi_lib.c                                              |   22 -
 drivers/scsi/sd.c                                                    |    4 
 drivers/soc/mediatek/mtk-devapc.c                                    |   36 -
 drivers/spi/atmel-quadspi.c                                          |  172 ++++++---
 drivers/tee/optee/supp.c                                             |   35 -
 drivers/usb/gadget/function/f_midi.c                                 |    2 
 drivers/usb/gadget/udc/core.c                                        |   11 
 fs/afs/cell.c                                                        |    1 
 fs/afs/internal.h                                                    |   23 -
 fs/afs/server.c                                                      |    1 
 fs/afs/server_list.c                                                 |  114 +++++
 fs/afs/vl_alias.c                                                    |    2 
 fs/afs/volume.c                                                      |   40 +-
 fs/overlayfs/copy_up.c                                               |    2 
 fs/smb/client/smb2ops.c                                              |    4 
 fs/squashfs/inode.c                                                  |    5 
 include/asm-generic/vmlinux.lds.h                                    |    2 
 include/linux/mm.h                                                   |   26 +
 include/linux/netdevice.h                                            |    2 
 include/linux/ptrace.h                                               |    4 
 include/linux/skmsg.h                                                |    2 
 include/linux/sunrpc/sched.h                                         |   17 
 include/net/dst.h                                                    |    9 
 include/net/ip.h                                                     |    5 
 include/net/netfilter/nf_conntrack_expect.h                          |    2 
 include/net/route.h                                                  |    5 
 include/net/strparser.h                                              |    2 
 include/net/tcp.h                                                    |   22 +
 include/trace/events/icmp.h                                          |   67 +++
 include/trace/events/oom.h                                           |   36 +
 include/trace/events/sunrpc.h                                        |    3 
 io_uring/net.c                                                       |    4 
 kernel/acct.c                                                        |  134 ++++---
 kernel/bpf/syscall.c                                                 |   18 
 kernel/events/core.c                                                 |   17 
 kernel/events/uprobes.c                                              |    5 
 kernel/sched/core.c                                                  |    2 
 kernel/trace/ftrace.c                                                |   30 -
 kernel/trace/trace_events_hist.c                                     |   30 -
 kernel/trace/trace_functions.c                                       |    6 
 mm/gup.c                                                             |   31 +
 mm/madvise.c                                                         |   11 
 mm/memcontrol.c                                                      |    7 
 mm/memory.c                                                          |    4 
 mm/oom_kill.c                                                        |   14 
 net/bluetooth/l2cap_core.c                                           |    9 
 net/bpf/test_run.c                                                   |    5 
 net/bridge/br_netfilter_hooks.c                                      |    8 
 net/core/dev.c                                                       |   37 +
 net/core/drop_monitor.c                                              |   29 -
 net/core/flow_dissector.c                                            |   49 +-
 net/core/gro.c                                                       |    1 
 net/core/skbuff.c                                                    |    2 
 net/core/skmsg.c                                                     |    7 
 net/core/sysctl_net_core.c                                           |    3 
 net/ipv4/arp.c                                                       |    2 
 net/ipv4/icmp.c                                                      |   24 -
 net/ipv4/ip_options.c                                                |    3 
 net/ipv4/tcp.c                                                       |   29 +
 net/ipv4/tcp_bpf.c                                                   |   36 +
 net/ipv4/tcp_fastopen.c                                              |    4 
 net/ipv4/tcp_input.c                                                 |    8 
 net/ipv4/tcp_ipv4.c                                                  |    2 
 net/ipv4/tcp_minisocks.c                                             |   10 
 net/ipv6/ip6_tunnel.c                                                |    4 
 net/ipv6/rpl_iptunnel.c                                              |   58 +--
 net/ipv6/seg6_iptunnel.c                                             |   97 +++--
 net/mptcp/pm_netlink.c                                               |    5 
 net/mptcp/subflow.c                                                  |   15 
 net/netfilter/nf_conntrack_core.c                                    |    2 
 net/netfilter/nf_conntrack_expect.c                                  |    4 
 net/netfilter/nft_ct.c                                               |    2 
 net/sched/sch_fifo.c                                                 |    3 
 net/strparser/strparser.c                                            |   11 
 net/sunrpc/cache.c                                                   |   10 
 net/sunrpc/sched.c                                                   |    2 
 sound/pci/hda/hda_codec.c                                            |    4 
 sound/pci/hda/patch_conexant.c                                       |    1 
 sound/pci/hda/patch_cs8409-tables.c                                  |    6 
 sound/pci/hda/patch_cs8409.c                                         |   20 -
 sound/pci/hda/patch_cs8409.h                                         |    5 
 sound/pci/hda/patch_realtek.c                                        |    1 
 sound/soc/codecs/es8328.c                                            |   15 
 sound/soc/fsl/fsl_micfil.c                                           |    2 
 sound/soc/rockchip/rockchip_i2s_tdm.c                                |    4 
 sound/soc/sh/rz-ssi.c                                                |    2 
 sound/usb/midi.c                                                     |    2 
 sound/usb/quirks.c                                                   |    1 
 179 files changed, 2149 insertions(+), 944 deletions(-)

Alexander Dahl (2):
      spi: atmel-quadspi: Avoid overwriting delay register settings
      spi: atmel-quadspi: Fix wrong register value written to MR

Andreas Schwab (1):
      riscv/futex: sign extend compare value in atomic cmpxchg

Andrey Vatoropin (1):
      power: supply: da9150-fg: fix potential overflow

AngeloGioacchino Del Regno (2):
      clk: mediatek: clk-mtk: Add dummy clock ops
      soc: mediatek: mtk-devapc: Switch to devm_clk_get_enabled()

Ard Biesheuvel (1):
      vmlinux.lds: Ensure that const vars with relocations are mapped R/O

Arnd Bergmann (1):
      sunrpc: suppress warnings for unused procfs functions

BH Hsieh (1):
      phy: tegra: xusb: reset VBUS & ID OVERRIDE

Bence Csókás (1):
      spi: atmel-qspi: Memory barriers after memory-mapped I/O

Breno Leitao (2):
      net: Add non-RCU dev_getbyhwaddr() helper
      arp: switch to dev_getbyhwaddr() in arp_req_set_public()

Caleb Sander Mateos (1):
      nvme/ioctl: add missing space in err message

Carlos Galo (1):
      mm: update mark_victim tracepoints fields

Catalin Marinas (1):
      arm64: mte: Do not allow PROT_MTE on MAP_HUGETLB user mappings

Chen Ridong (1):
      memcg: fix soft lockup in the OOM process

Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8183: Disable DSI display output by default

Cheng Jiang (1):
      Bluetooth: qca: Update firmware-name to support board specific nvm

Christian Brauner (2):
      acct: perform last write from workqueue
      acct: block access to kernel internal filesystems

Christophe Leroy (2):
      powerpc/64s: Rewrite __real_pte() and __rpte_to_hidx() as static inline
      powerpc/code-patching: Fix KASAN hit by not flagging text patching area as VM_ALLOC

Chukun Pan (1):
      phy: rockchip: naneng-combphy: compatible reset with old DT

Colin Ian King (1):
      afs: remove variable nr_servers

Cong Wang (2):
      flow_dissector: Fix handling of mixed port and port-range keys
      flow_dissector: Fix port range key handling in BPF conversion

Csókás, Bence (1):
      spi: atmel-quadspi: Create `atmel_qspi_ops` to support newer SoC families

Dan Carpenter (1):
      ASoC: renesas: rz-ssi: Add a check for negative sample_space

Daniel Golle (3):
      clk: mediatek: mt2701-vdec: fix conversion to mtk_clk_simple_probe
      clk: mediatek: mt2701-bdp: add missing dummy clk
      clk: mediatek: mt2701-img: add missing dummy clk

David Hildenbrand (1):
      nouveau/svm: fix missing folio unlock + put after make_device_exclusive_range()

David Howells (3):
      afs: Make it possible to find the volumes that are using a server
      afs: Fix the server_list to unuse a displaced server rather than putting it
      mm: Don't pin ZERO_PAGE in pin_user_pages()

Devarsh Thakkar (1):
      drm/tidss: Fix race condition while handling interrupt registers

Dmitry Panchenko (1):
      ALSA: usb-audio: Re-add sample rate quirk for Pioneer DJM-900NXS2

Douglas Gilbert (1):
      scsi: core: Handle depopulation and restoration in progress

Eddie James (1):
      tpm: Use managed allocation for bios event log

Eric Dumazet (1):
      ipvlan: ensure network headers are in skb linear part

Fullway Wang (1):
      media: mtk-vcodec: potential null pointer deference in SCP

Gavrilov Ilia (1):
      drop_monitor: fix incorrect initialization order

Greg Kroah-Hartman (1):
      Linux 6.1.130

Guillaume Nault (3):
      ipv4: Convert icmp_route_lookup() to dscp_t.
      ipv4: Convert ip_route_input() to dscp_t.
      ipvlan: Prepare ipvlan_process_v4_outbound() to future .flowi4_tos conversion.

Haoxiang Li (2):
      nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
      smb: client: Add check for next_buffer in receive_encrypted_standard()

Harshal Chaudhari (1):
      net: mvpp2: cls: Fixed Non IP flow, with vlan tag flow defination.

Ido Schimmel (4):
      net: loopback: Avoid sending IP packets without an Ethernet header
      ipv4: icmp: Pass full DS field to ip_route_input()
      ipv4: icmp: Unmask upper DSCP bits in icmp_route_lookup()
      ipvlan: Unmask upper DSCP bits in ipvlan_process_v4_outbound()

Igor Pylypiv (1):
      scsi: core: Do not retry I/Os during depopulation

Jarkko Sakkinen (1):
      tpm: Change to kvalloc() in eventlog/acpi.c

Jessica Zhang (1):
      drm/msm/dpu: Disable dither in phys encoder cleanup

Jiaxun Yang (2):
      ptrace: Introduce exception_ip arch hook
      mm/memory: Use exception ip to search exception tables

Jiayuan Chen (2):
      strparser: Add read_sock callback
      bpf: Fix wrong copied_seq calculation

Jill Donahue (1):
      USB: gadget: f_midi: f_midi_complete to call queue_work

Jiri Slaby (SUSE) (1):
      net: set the minimum for net_hotdata.netdev_budget_usecs

John Keeping (1):
      ASoC: rockchip: i2s-tdm: fix shift config for SND_SOC_DAIFMT_DSP_[AB]

John Veness (1):
      ALSA: hda/conexant: Add quirk for HP ProBook 450 G4 mute LED

Justin Iurman (5):
      include: net: add static inline dst_dev_overhead() to dst.h
      net: ipv6: seg6_iptunnel: mitigate 2-realloc issue
      net: ipv6: fix dst ref loop on input in seg6 lwt
      net: ipv6: rpl_iptunnel: mitigate 2-realloc issue
      net: ipv6: fix dst ref loop on input in rpl lwt

Kailang Yang (1):
      ALSA: hda/realtek: Fixup ALC225 depop procedure

Kan Liang (2):
      perf/x86: Fix low freqency setting issue
      perf/core: Fix low freq setting via IOC_PERIOD

Kaustabh Chakraborty (1):
      phy: exynos5-usbdrd: fix MPLL_MULTIPLIER and SSC_REFCLKSEL masks in refclk

Komal Bajaj (1):
      EDAC/qcom: Correct interrupt enable register configuration

Krzysztof Kozlowski (4):
      arm64: dts: qcom: trim addresses to 8 digits
      arm64: dts: qcom: sm8450: Fix CDSP memory length
      soc: mediatek: mtk-devapc: Fix leaking IO map on error paths
      soc: mediatek: mtk-devapc: Fix leaking IO map on driver remove

Kuniyuki Iwashima (3):
      geneve: Fix use-after-free in geneve_find_dev().
      gtp: Suppress list corruption splat in gtp_net_exit_batch_rtnl().
      geneve: Suppress list corruption splat in geneve_destroy_tunnels().

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response

Marijn Suijten (1):
      drm/msm/dpu: Don't leak bits_per_component into random DSC_ENC fields

Mark Zhang (1):
      IB/mlx5: Set and get correct qp_num for a DCT QP

Matthieu Baerts (NGI0) (1):
      mptcp: reset when MPTCP opts are dropped after join

Michael Ellerman (1):
      powerpc/64s/mm: Move __real_pte stubs into hash-4k.h

Mohammad Heib (1):
      net: Clear old fragment checksum value in napi_reuse_skb

Nick Child (4):
      ibmvnic: Return error code on TX scrq flush fail
      ibmvnic: Introduce send sub-crq direct
      ibmvnic: Add stat for tx direct vs tx batched
      ibmvnic: Don't reference skb after sending to VIOS

Nick Hu (1):
      net: axienet: Set mac_managed_pm

Nicolas Frattaroli (1):
      ASoC: es8328: fix route from DAC to output

Nikita Zhandarovich (2):
      ASoC: fsl_micfil: Enable default case in micfil_set_quality()
      usbnet: gl620a: fix endpoint checking in genelink_bind()

Nikolay Kuratov (1):
      ftrace: Avoid potential division by zero in function_stat_show()

Niravkumar L Rabara (3):
      mtd: rawnand: cadence: fix error code in cadence_nand_init()
      mtd: rawnand: cadence: use dma_map_resource for sdma address
      mtd: rawnand: cadence: fix incorrect device in dma_unmap_single

Paolo Abeni (1):
      mptcp: always handle address removal under msk socket lock

Paolo Valente (1):
      block, bfq: split sync bfq_queues on a per-actuator basis

Patrick Bellasi (1):
      x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit

Patrisious Haddad (1):
      RDMA/mlx5: Fix bind QP error cleanup flow

Pavel Begunkov (1):
      io_uring/net: save msg_control for compat

Peilin He (1):
      net/ipv4: add tracepoint for icmp_send

Phillip Lougher (1):
      Squashfs: check the inode number is not the invalid value of zero

Philo Lu (1):
      ipvs: Always clear ipvs_property flag in skb_scrub_packet()

Quang Le (1):
      pfifo_tail_enqueue: Drop new packet when sch->limit == 0

Ricardo Cañuelo Navarro (1):
      mm,madvise,hugetlb: check for 0-length range after end address adjustment

Ricardo Ribalda (4):
      media: uvcvideo: Fix crash during unbind if gpio unit is in use
      media: uvcvideo: Refactor iterators
      media: uvcvideo: Only save async fh if success
      media: uvcvideo: Remove dangling pointers

Roman Li (1):
      drm/amd/display: Fix HPD after gpu reset

Roy Luo (2):
      USB: gadget: core: create sysfs link between udc and gadget
      usb: gadget: core: flush gadget workqueue after device removal

Russell Senior (1):
      x86/CPU: Fix warm boot hang regression on AMD SC1100 SoC systems

Sabrina Dubroca (1):
      tcp: drop secpath at the same time as we currently drop dst

Sean Anderson (1):
      net: cadence: macb: Synchronize stats calculations

Sebastian Andrzej Siewior (1):
      ftrace: Correct preemption accounting for function tracing.

Shay Drory (1):
      net/mlx5: IRQ, Fix null string in debug print

Shigeru Yoshida (1):
      bpf, test_run: Fix use-after-free issue in eth_skb_pkt_type()

Sohaib Nadeem (1):
      drm/amd/display: fixed integer types and null check locations

Stephen Brennan (1):
      SUNRPC: convert RPC_TASK_* constants to enum

Steven Rostedt (2):
      ftrace: Do not add duplicate entries in subops manager ops
      tracing: Fix bad hist from corrupting named_triggers list

Sumit Garg (1):
      tee: optee: Fix supplicant wait loop

Takashi Iwai (1):
      ALSA: usb-audio: Avoid dropping MIDI events at closing multiple ports

Thomas Gleixner (2):
      sched/core: Prevent rescheduling when interrupts are disabled
      intel_idle: Handle older CPUs, which stop the TSC in deeper C states, correctly

Tom Chung (1):
      drm/amd/display: Disable PSR-SU on eDP panels

Tomi Valkeinen (2):
      drm/tidss: Add simple K2G manual reset
      drm/rcar-du: dsi: Fix PHY lock bit check

Tong Tiangen (1):
      uprobes: Reject the shared zeropage in uprobe_write_opcode()

Trond Myklebust (1):
      SUNRPC: Prevent looping due to rpc_signal_task() races

Tudor Ambarus (1):
      spi: atmel-quadspi: Add support for configuring CS timing

Tyrone Ting (1):
      i2c: npcm: disable interrupt enable bit before devm_request_irq

Uwe Kleine-König (1):
      soc/mediatek: mtk-devapc: Convert to platform remove callback returning void

Vasiliy Kovalev (1):
      ovl: fix UAF in ovl_dentry_update_reval by moving dput() in ovl_link_up

Ville Syrjälä (1):
      drm/i915: Make sure all planes in use by the joiner have their crtc included

Vitaly Rodionov (1):
      ALSA: hda/cirrus: Correct the full scale volume set logic

Wang Hai (1):
      tcp: Defer ts_recent changes until req is owned

Wei Fang (5):
      net: enetc: fix the off-by-one issue in enetc_map_tx_buffs()
      net: enetc: keep track of correct Tx BD count in enetc_map_tx_tso_buffs()
      net: enetc: update UDP checksum when updating originTimestamp field
      net: enetc: correct the xdp_tx statistics
      net: enetc: fix the off-by-one issue in enetc_map_tx_tso_buffs()

Wentao Liang (1):
      ALSA: hda: Add error check for snd_ctl_rename_id() in snd_hda_create_dig_out_ctls()

Xin Long (1):
      netfilter: allow exp not to be removed in nf_ct_find_expectation

Yan Zhai (1):
      bpf: skip non exist keys in generic_map_lookup_batch

Yang Yingliang (2):
      spi: atmel-quadspi: switch to use modern name
      media: Switch to use dev_err_probe() helper

Ye Bin (1):
      scsi: core: Clear driver private data when retrying request

Yu Kuai (5):
      md/md-bitmap: replace md_bitmap_status() with a new helper md_bitmap_get_stats()
      md/md-cluster: fix spares warnings for __le64
      md/md-bitmap: add 'sync_size' into struct md_bitmap_stats
      md/md-bitmap: Synchronize bitmap_get_stats() with bitmap lifetime
      block, bfq: fix bfqq uaf in bfq_limit_depth()

Yunfei Dong (1):
      media: mediatek: vcodec: Fix H264 multi stateless decoder smatch warning

Zijun Hu (2):
      Bluetooth: qca: Support downloading board id specific NVM for WCN7850
      Bluetooth: qca: Fix poor RF performance for WCN6855

chr[] (1):
      amdgpu/pm/legacy: fix suspend/resume issues


