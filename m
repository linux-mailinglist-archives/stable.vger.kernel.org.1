Return-Path: <stable+bounces-126976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D22BA75202
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 22:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9862516DD14
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 21:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A68C1F09BC;
	Fri, 28 Mar 2025 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H0u4CtKb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44E31F09AD;
	Fri, 28 Mar 2025 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743196868; cv=none; b=WmPwRE1UDRruUQejAcFN86SQ+6TEtHG1FIkDBjNjLZQn1LrrSQGxYgIkPuQgl2/Y0VwC3b9GYlL+egb17MhXt/oXA6/Ts+cHlHzEDkPMkG+s/S3z5hnO7eNgXKc/w7yYioK4PjXGTzsDQbjTuKQcL378KzX20qkNYVUaM+M2AxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743196868; c=relaxed/simple;
	bh=GXDeKvefWrODHscdt68hNAhIpvA4k7yM2TWPXCpBd6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=elUY+/l3LjTbBqFc2J9CEhqdqtLKyHkSiGuOK3J13aHPdEH3//gVBnLBBHBaQkGQCM2zVE3WH97ZHk4Fom0Z/dkTyom8pWLFmFZLUXhKVA86jkbHhCVilwafPzDsHTINw/9KC7y4P9FGg3sAKy8DjXaKM3YpxTnvuG69ELRLK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H0u4CtKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B61C4CEE4;
	Fri, 28 Mar 2025 21:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743196867;
	bh=GXDeKvefWrODHscdt68hNAhIpvA4k7yM2TWPXCpBd6I=;
	h=From:To:Cc:Subject:Date:From;
	b=H0u4CtKbQAhcUQyljjJSGks9acly4OUK8DlretT7e6AESxtNv9M2r4j1vDfAG4e+a
	 BVZ5YgyfdyW8x2/oRgn7reVfjZoSTN5Y1koNMqgprGbVgX0cOQFe0YVuFyl9/BExzo
	 fbru+u4bqeN/cHnubSTUUygamHylN6Iz8+SxyBsg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.21
Date: Fri, 28 Mar 2025 22:19:38 +0100
Message-ID: <2025032838-studio-keg-302e@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.21 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml |    2 
 Makefile                                                          |    2 
 arch/arm/boot/dts/broadcom/bcm2711-rpi.dtsi                       |    5 
 arch/arm/boot/dts/broadcom/bcm2711.dtsi                           |   12 
 arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts             |    8 
 arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts            |    8 
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi                     |   10 
 arch/arm/mach-davinci/Kconfig                                     |    1 
 arch/arm/mach-omap1/Kconfig                                       |    1 
 arch/arm/mach-shmobile/headsmp.S                                  |    1 
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi                         |    2 
 arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi           |    6 
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi               |   16 -
 arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi           |    6 
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts             |   12 
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts                |    2 
 arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts                |    1 
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts                    |    1 
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi                    |    1 
 arch/arm64/include/asm/kvm_host.h                                 |   25 -
 arch/arm64/kernel/fpsimd.c                                        |   25 -
 arch/arm64/kvm/arm.c                                              |    9 
 arch/arm64/kvm/fpsimd.c                                           |  100 ------
 arch/arm64/kvm/hyp/entry.S                                        |    5 
 arch/arm64/kvm/hyp/include/hyp/switch.h                           |  133 ++++++--
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                                |   11 
 arch/arm64/kvm/hyp/nvhe/pkvm.c                                    |   29 -
 arch/arm64/kvm/hyp/nvhe/switch.c                                  |  134 ++++----
 arch/arm64/kvm/hyp/vhe/switch.c                                   |   21 -
 arch/riscv/boot/dts/starfive/jh7110-pinfunc.h                     |    2 
 drivers/accel/qaic/qaic_data.c                                    |    9 
 drivers/ata/libata-core.c                                         |   14 
 drivers/dpll/dpll_core.c                                          |    2 
 drivers/firmware/efi/libstub/randomalloc.c                        |    4 
 drivers/firmware/imx/imx-scu.c                                    |    1 
 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c                   |   18 -
 drivers/firmware/qcom/qcom_scm.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c                            |   22 -
 drivers/gpu/drm/amd/amdgpu/nv.c                                   |   20 -
 drivers/gpu/drm/amd/amdgpu/soc15.c                                |   21 -
 drivers/gpu/drm/amd/amdgpu/vi.c                                   |   43 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                            |   12 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                              |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                 |    2 
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c             |   11 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                                |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c              |   94 +++---
 drivers/gpu/drm/radeon/radeon_vce.c                               |    2 
 drivers/gpu/drm/scheduler/sched_entity.c                          |   11 
 drivers/gpu/drm/v3d/v3d_sched.c                                   |    9 
 drivers/gpu/drm/xe/xe_bo.h                                        |    2 
 drivers/gpu/drm/xe/xe_dma_buf.c                                   |    2 
 drivers/gpu/host1x/dev.c                                          |    6 
 drivers/i2c/busses/i2c-omap.c                                     |   26 -
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                          |    2 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h                        |    3 
 drivers/infiniband/hw/hns/hns_roce_alloc.c                        |    4 
 drivers/infiniband/hw/hns/hns_roce_cq.c                           |    1 
 drivers/infiniband/hw/hns/hns_roce_hem.c                          |   16 +
 drivers/infiniband/hw/hns/hns_roce_main.c                         |    2 
 drivers/infiniband/hw/hns/hns_roce_qp.c                           |   20 -
 drivers/infiniband/hw/mlx5/ah.c                                   |   14 
 drivers/infiniband/sw/rxe/rxe.c                                   |   25 -
 drivers/mmc/host/atmel-mci.c                                      |    4 
 drivers/mmc/host/sdhci-brcmstb.c                                  |   10 
 drivers/net/can/flexcan/flexcan-core.c                            |   18 +
 drivers/net/can/rcar/rcar_canfd.c                                 |   28 -
 drivers/net/can/usb/ucan.c                                        |   43 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c                   |   14 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                          |   32 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c                      |    1 
 drivers/net/ethernet/ti/icssg/icssg_prueth.h                      |    2 
 drivers/net/ethernet/ti/icssg/icssg_stats.c                       |    4 
 drivers/net/phy/phy_link_topology.c                               |    2 
 drivers/pmdomain/amlogic/meson-secure-pwrc.c                      |    2 
 drivers/regulator/core.c                                          |   12 
 drivers/regulator/dummy.c                                         |    2 
 drivers/soc/imx/soc-imx8m.c                                       |  149 ++++------
 drivers/soc/qcom/pdr_interface.c                                  |    8 
 fs/libfs.c                                                        |    2 
 fs/netfs/write_collect.c                                          |    3 
 fs/proc/generic.c                                                 |   10 
 fs/proc/inode.c                                                   |    6 
 fs/proc/internal.h                                                |   14 
 fs/smb/server/smbacl.c                                            |    5 
 include/linux/key.h                                               |    1 
 include/linux/libata.h                                            |    2 
 include/linux/proc_fs.h                                           |    7 
 include/net/bluetooth/hci.h                                       |    2 
 include/net/mana/gdma.h                                           |   11 
 io_uring/net.c                                                    |    5 
 kernel/dma/direct.c                                               |   28 +
 kernel/sched/core.c                                               |   21 -
 kernel/trace/trace_fprobe.c                                       |   30 --
 mm/filemap.c                                                      |   13 
 mm/huge_memory.c                                                  |    2 
 mm/memcontrol.c                                                   |    9 
 mm/migrate.c                                                      |   10 
 mm/page_alloc.c                                                   |   14 
 net/atm/lec.c                                                     |    3 
 net/batman-adv/bat_iv_ogm.c                                       |    3 
 net/batman-adv/bat_v_ogm.c                                        |    3 
 net/bluetooth/6lowpan.c                                           |    7 
 net/core/lwtunnel.c                                               |   65 +++-
 net/core/neighbour.c                                              |    1 
 net/devlink/core.c                                                |    2 
 net/ipv6/addrconf.c                                               |   15 -
 net/ipv6/ioam6_iptunnel.c                                         |    8 
 net/ipv6/route.c                                                  |    5 
 net/ipv6/tcpv6_offload.c                                          |   21 +
 net/mptcp/options.c                                               |    6 
 net/xdp/xsk_buff_pool.c                                           |    2 
 net/xfrm/xfrm_output.c                                            |   43 ++
 security/keys/gc.c                                                |    4 
 security/keys/key.c                                               |    2 
 tools/lib/subcmd/parse-options.c                                  |    2 
 tools/testing/selftests/mm/run_vmtests.sh                         |    4 
 118 files changed, 935 insertions(+), 812 deletions(-)

Alex Deucher (1):
      drm/amdgpu/pm: wire up hwmon fan speed for smu 14.0.2

Alexander Stein (1):
      arm64: dts: freescale: tqma8mpql: Fix vqmmc-supply

Alexandre Cassen (1):
      xfrm: fix tunnel mode TX datapath in packet offload mode

Andreas Kemnade (1):
      i2c: omap: fix IRQ storms

Ard Biesheuvel (1):
      efi/libstub: Avoid physical address 0x0 when doing random allocation

Arkadiusz Bokowy (1):
      Bluetooth: hci_event: Fix connection regression between LE and non-LE adapters

Arnd Bergmann (1):
      ARM: OMAP1: select CONFIG_GENERIC_IRQ_CHIP

Arthur Mongodin (1):
      mptcp: Fix data stream corruption in the address announcement

Baochen Qiang (1):
      dma-mapping: fix missing clear bdr in check_ram_in_range_map()

Biju Das (2):
      dt-bindings: can: renesas,rcar-canfd: Fix typo in pattern properties for R-Car V4M
      can: rcar_canfd: Fix page entries in the AFL list

Chester A. Unal (2):
      ARM: dts: BCM5301X: Fix switch port labels of ASUS RT-AC5300
      ARM: dts: BCM5301X: Fix switch port labels of ASUS RT-AC3200

Christian Eggers (2):
      regulator: dummy: force synchronous probing
      regulator: check that dummy regulator has been probed before using it

Cosmin Ratiu (1):
      xfrm_output: Force software GSO only in tunnel mode

Dan Carpenter (4):
      firmware: qcom: scm: Fix error code in probe()
      Bluetooth: Fix error code in chan_alloc_skb_cb()
      net: atm: fix use after free in lec_send()
      accel/qaic: Fix integer overflow in qaic_validate_req()

David Belanger (1):
      drm/amdgpu: Restore uncached behaviour on GFX12

David Howells (1):
      keys: Fix UAF in key_put()

David Lechner (1):
      ARM: davinci: da850: fix selecting ARCH_DAVINCI_DA8XX

David Rosca (3):
      drm/amdgpu: Remove JPEG from vega and carrizo video caps
      drm/amdgpu: Fix MPEG2, MPEG4 and VC1 video caps max size
      drm/amdgpu: Fix JPEG video caps max size for navi1x and raven

Dietmar Eggemann (1):
      Revert "sched/core: Reduce cost of sched_move_task when config autogroup"

E Shattow (1):
      riscv: dts: starfive: Fix a typo in StarFive JH7110 pin function definitions

Eder Zulian (1):
      libsubcmd: Silence compiler warning

Felix Fietkau (1):
      net: ipv6: fix TCP GSO segmentation with NAT

Fuad Tabba (1):
      KVM: arm64: Calculate cptr_el2 traps on activating traps

Gavrilov Ilia (1):
      xsk: fix an integer overflow in xp_create_and_assign_umem()

Geert Uytterhoeven (1):
      ARM: shmobile: smp: Enforce shmobile_smp_* alignment

Greg Kroah-Hartman (1):
      Linux 6.12.21

Gu Bowen (1):
      mmc: atmel-mci: Add missing clk_disable_unprepare()

Guillaume Nault (1):
      Revert "gre: Fix IPv6 link-local address generation."

Haibo Chen (2):
      can: flexcan: only change CAN state when link up in system PM
      can: flexcan: disable transceiver during system PM

Haiyang Zhang (1):
      net: mana: Support holes in device list reply msg

Harish Kasiviswanathan (1):
      drm/amd/pm: add unique_id for gfx12

Heiko Stuebner (2):
      arm64: dts: rockchip: remove supports-cqe from rk3588 jaguar
      arm64: dts: rockchip: remove supports-cqe from rk3588 tiger

Jason Gunthorpe (1):
      gpu: host1x: Do not assume that a NULL domain means no DMA IOMMU

Jeffrey Hugo (1):
      accel/qaic: Fix possible data corruption in BOs > 2G

Jens Axboe (1):
      io_uring/net: don't clear REQ_F_NEED_CLEANUP unconditionally

Joe Hattori (1):
      firmware: imx-scu: fix OF node leak in .probe()

Johan Hovold (1):
      firmware: qcom: uefisecapp: fix efivars registration race

Junxian Huang (6):
      RDMA/hns: Fix soft lockup during bt pages loop
      RDMA/hns: Fix unmatched condition in error path of alloc_user_qp_db()
      RDMA/hns: Fix invalid sq params not being blocked
      RDMA/hns: Fix a missing rollback in error path of hns_roce_create_qp_common()
      RDMA/hns: Fix missing xa_destroy()
      RDMA/hns: Fix wrong value of max_sge_rd

Justin Iurman (2):
      net: lwtunnel: fix recursion loops
      net: ipv6: ioam6: fix lwtunnel_output() loop

Justin Klaassen (1):
      arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S

Kamal Dasu (1):
      mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops

Kashyap Desai (1):
      RDMA/bnxt_re: Add missing paranthesis in map_qp_id_to_tbl_indx

Kirill A. Shutemov (1):
      mm/page_alloc: fix memory accept before watermarks gets initialized

Kuniyuki Iwashima (2):
      ipv6: Fix memleak of nhc_pcpu_rth_output in fib_check_nh_v6_gw().
      ipv6: Set errno after ip_fib_metrics_init() in ip6_route_info_create().

Lin Ma (1):
      net/neighbor: add missing policy for NDTPA_QUEUE_LENBYTES

MD Danish Anwar (1):
      net: ti: icssg-prueth: Add lock to stats

Marek Vasut (2):
      soc: imx8m: Remove global soc_uid
      soc: imx8m: Use devm_* to simplify probe failure handling

Mario Limonciello (1):
      drm/amd/display: Use HW lock mgr for PSR1 when only one eDP

Mark Rutland (7):
      KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
      KVM: arm64: Remove host FPSIMD saving for non-protected KVM
      KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
      KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
      KVM: arm64: Refactor exit handlers
      KVM: arm64: Mark some header functions as inline
      KVM: arm64: Eagerly switch ZCR_EL{1,2}

Masami Hiramatsu (Google) (2):
      tracing: tprobe-events: Fix to clean up tprobe correctly when module unload
      tracing: tprobe-events: Fix leakage of module refcount

Max Kellermann (1):
      netfs: Call `invalidate_cache` only if implemented

Maíra Canal (1):
      drm/v3d: Don't run jobs that have errors flagged in its fence

Michal Swiatkowski (3):
      devlink: fix xa_alloc_cyclic() error handling
      dpll: fix xa_alloc_cyclic() error handling
      phy: fix xa_alloc_cyclic() error handling

Namjae Jeon (1):
      ksmbd: fix incorrect validation for num_aces field of smb_acl

Nikita Zhandarovich (1):
      drm/radeon: fix uninitialized size issue in radeon_vce_cs_parse()

Niklas Cassel (1):
      ata: libata-core: Add ATA_QUIRK_NO_LPM_ON_ATI for certain Samsung SSDs

Pavel Begunkov (1):
      io_uring/net: fix sendzc double notif flush

Peng Fan (1):
      soc: imx8m: Unregister cpufreq and soc dev in cleanup path

Phil Elwell (3):
      ARM: dts: bcm2711: PL011 UARTs are actually r1p5
      arm64: dts: bcm2712: PL011 UARTs are actually r1p5
      ARM: dts: bcm2711: Don't mark timer regs unconfigured

Philip Yang (1):
      drm/amdkfd: Fix user queue validation on Gfx7/8

Qasim Ijaz (1):
      RDMA/mlx5: Handle errors returned from mlx5r_ib_rate()

Quentin Schulz (2):
      arm64: dts: rockchip: fix pinmux of UART0 for PX30 Ringneck on Haikou
      arm64: dts: rockchip: fix pinmux of UART5 for PX30 Ringneck on Haikou

Rafael Aquini (1):
      selftests/mm: run_vmtests.sh: fix half_ufd_size_MB calculation

Raphael S. Carvalho (1):
      mm: fix error handling in __filemap_get_folio() with FGP_NOWAIT

Saranya R (1):
      soc: qcom: pdr: Fix the potential deadlock

Saravanan Vajravel (1):
      RDMA/bnxt_re: Avoid clearing VLAN_ID mask in modify qp path

Shakeel Butt (1):
      memcg: drain obj stock on cpu hotplug teardown

Stefan Eichenberger (3):
      arm64: dts: freescale: imx8mp-verdin-dahlia: add Microphone Jack to sound card
      arm64: dts: freescale: imx8mm-verdin-dahlia: add Microphone Jack to sound card
      ARM: dts: imx6qdl-apalis: Fix poweroff on Apalis iMX6

Stefan Wahren (1):
      ARM: dts: bcm2711: Fix xHCI power-domain

Sven Eckelmann (1):
      batman-adv: Ignore own maximum aggregation size during RX

Tomasz Pakuła (1):
      drm/amdgpu/pm: Handle SCLK offset correctly in overdrive for smu 14.0.2

Tomasz Rusinowicz (1):
      drm/xe: Fix exporting xe buffers multiple times

Vignesh Raghavendra (1):
      net: ethernet: ti: am65-cpsw: Fix NAPI registration sequence

Vincent Mailhol (1):
      can: ucan: fix out of bound read in strscpy() source

Wentao Liang (1):
      drm/amdgpu/gfx12: correct cleanup of 'me' field with gfx_v12_0_me_fini()

Xianwei Zhao (1):
      pmdomain: amlogic: fix T7 ISP secpower

Yao Zi (1):
      arm64: dts: rockchip: Remove undocumented sdmmc property from lubancat-1

Ye Bin (1):
      proc: fix UAF in proc_get_inode()

Yilin Chen (1):
      drm/amd/display: Fix message for support_edp0_on_dp1

Yongjian Sun (1):
      libfs: Fix duplicate directory entry in offset_dir_lookup

Zhu Yanjun (1):
      RDMA/rxe: Fix the failure of ibv_query_device() and ibv_query_device_ex() tests

Zi Yan (2):
      mm/migrate: fix shmem xarray update during migration
      mm/huge_memory: drop beyond-EOF folios with the right number of refs

qianyi liu (1):
      drm/sched: Fix fence reference count leak


