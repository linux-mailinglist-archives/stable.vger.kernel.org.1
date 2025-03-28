Return-Path: <stable+bounces-126972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BBDA751F9
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 22:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196963B2DAF
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 21:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE89A1EDA33;
	Fri, 28 Mar 2025 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t6FJPBhf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B61E0E1A;
	Fri, 28 Mar 2025 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743196851; cv=none; b=hC2kayrbFA5xHnem8ZEQscY49fs6O8EJtiJjU6dU6QQAJnV9gKH1bKvfB6AKw+pl7atPTSdxMiqcEE6LOWpD8buzizEBmr0XMUpztElkINXJZTUybaWwTyOyjp+UMdmOCCoVqXrWQDHkrVi2ZHC42YkKSDcjso6DcNPhOMGjDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743196851; c=relaxed/simple;
	bh=57d3Kkq1WZrMQxYyL+X9oZk15CByN12WNMSlpW8Fw14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F7XCoa53Sjw/O03GE98O47qx8Ty5qCXkHpPUBkVVk6oWJRHCFSE0vN9fp15DIokEEkbv6vrkRTyWk5Ax5isKJRpF9szt4LZPui0CFmD+hb7RcvaZUrhd2dTsZEViKZ8jxgWUIHfXbJQqZQ6SxTHiDWY+ikwd482ocMCvqZ7Lqj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t6FJPBhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A47C4CEE4;
	Fri, 28 Mar 2025 21:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743196851;
	bh=57d3Kkq1WZrMQxYyL+X9oZk15CByN12WNMSlpW8Fw14=;
	h=From:To:Cc:Subject:Date:From;
	b=t6FJPBhf4e7M1G1XgUczDeq7TFg53lqG3DWBefuVwozC3IfK7UyShfrm2+S1BhBN3
	 6LZMVFS6cJNhq6XxGBYeL//UR64HmypKDiftwK9AyjThrb+wCt9yMC2xra/vUYaO3a
	 Fn+CmF7Vj2n4TIU52P/Ng6bkG2CsoGnzauykyMSo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.85
Date: Fri, 28 Mar 2025 22:19:24 +0100
Message-ID: <2025032825-smitten-cubbyhole-9969@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.85 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                |    2 
 arch/arm/boot/dts/broadcom/bcm2711.dtsi                 |   11 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi           |   10 -
 arch/arm/mach-davinci/Kconfig                           |    1 
 arch/arm/mach-omap1/Kconfig                             |    1 
 arch/arm/mach-shmobile/headsmp.S                        |    1 
 arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi |    6 
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi     |   16 -
 arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi |    6 
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts   |    2 
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts      |    2 
 arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts      |    1 
 arch/arm64/include/asm/kvm_host.h                       |    7 
 arch/arm64/include/asm/kvm_hyp.h                        |    1 
 arch/arm64/kernel/fpsimd.c                              |   25 --
 arch/arm64/kvm/arm.c                                    |    1 
 arch/arm64/kvm/fpsimd.c                                 |   89 +--------
 arch/arm64/kvm/hyp/entry.S                              |    5 
 arch/arm64/kvm/hyp/include/hyp/switch.h                 |  106 +++++++----
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                      |   15 -
 arch/arm64/kvm/hyp/nvhe/pkvm.c                          |   29 ---
 arch/arm64/kvm/hyp/nvhe/switch.c                        |  106 +++++++----
 arch/arm64/kvm/hyp/vhe/switch.c                         |   13 -
 arch/arm64/kvm/reset.c                                  |    3 
 arch/riscv/boot/dts/starfive/jh7110-pinfunc.h           |    2 
 drivers/accel/qaic/qaic_data.c                          |    9 
 drivers/firmware/efi/libstub/randomalloc.c              |    4 
 drivers/firmware/imx/imx-scu.c                          |    1 
 drivers/gpu/drm/amd/amdgpu/nv.c                         |   20 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                      |   20 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                         |   36 +--
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c   |   15 +
 drivers/gpu/drm/radeon/radeon_vce.c                     |    2 
 drivers/gpu/drm/scheduler/sched_entity.c                |   11 -
 drivers/gpu/drm/v3d/v3d_sched.c                         |    9 
 drivers/i2c/busses/i2c-omap.c                           |   26 --
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                |    2 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h              |    3 
 drivers/infiniband/hw/hns/hns_roce_hem.c                |   16 +
 drivers/infiniband/hw/hns/hns_roce_main.c               |    2 
 drivers/infiniband/hw/hns/hns_roce_qp.c                 |   10 -
 drivers/infiniband/hw/mlx5/ah.c                         |   14 -
 drivers/mmc/host/atmel-mci.c                            |    4 
 drivers/mmc/host/sdhci-brcmstb.c                        |   10 +
 drivers/net/can/flexcan/flexcan-core.c                  |   18 +
 drivers/net/can/rcar/rcar_canfd.c                       |   28 +--
 drivers/net/can/usb/ucan.c                              |   43 +---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c               |   10 -
 drivers/net/wireless/intel/iwlwifi/fw/file.h            |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c             |    9 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c             |   37 +++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c            |   28 +++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h            |    3 
 drivers/regulator/core.c                                |   12 +
 drivers/regulator/dummy.c                               |    2 
 drivers/soc/imx/soc-imx8m.c                             |  149 +++++++---------
 drivers/soc/qcom/pdr_interface.c                        |    8 
 fs/btrfs/tree-checker.c                                 |   30 +--
 fs/btrfs/tree-checker.h                                 |    1 
 fs/proc/generic.c                                       |   10 -
 fs/proc/inode.c                                         |    6 
 fs/proc/internal.h                                      |   14 +
 fs/smb/server/smbacl.c                                  |    5 
 include/linux/proc_fs.h                                 |    7 
 include/net/bluetooth/hci.h                             |    2 
 kernel/sched/core.c                                     |   22 --
 mm/filemap.c                                            |   13 +
 mm/migrate.c                                            |   10 -
 net/atm/lec.c                                           |    3 
 net/batman-adv/bat_iv_ogm.c                             |    3 
 net/batman-adv/bat_v_ogm.c                              |    3 
 net/bluetooth/6lowpan.c                                 |    7 
 net/core/lwtunnel.c                                     |   65 +++++-
 net/core/neighbour.c                                    |    1 
 net/ipv6/addrconf.c                                     |   15 -
 net/ipv6/route.c                                        |    5 
 net/mptcp/options.c                                     |    6 
 net/netfilter/nft_counter.c                             |   90 ++++-----
 net/xdp/xsk_buff_pool.c                                 |    2 
 net/xfrm/xfrm_output.c                                  |   43 ++++
 80 files changed, 794 insertions(+), 595 deletions(-)

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

Benjamin Berg (1):
      wifi: iwlwifi: mvm: ensure offloading TID queue exists

Biju Das (1):
      can: rcar_canfd: Fix page entries in the AFL list

Christian Eggers (2):
      regulator: dummy: force synchronous probing
      regulator: check that dummy regulator has been probed before using it

Cosmin Ratiu (1):
      xfrm_output: Force software GSO only in tunnel mode

Dan Carpenter (3):
      Bluetooth: Fix error code in chan_alloc_skb_cb()
      net: atm: fix use after free in lec_send()
      accel/qaic: Fix integer overflow in qaic_validate_req()

David Lechner (1):
      ARM: davinci: da850: fix selecting ARCH_DAVINCI_DA8XX

David Rosca (2):
      drm/amdgpu: Fix MPEG2, MPEG4 and VC1 video caps max size
      drm/amdgpu: Fix JPEG video caps max size for navi1x and raven

Dietmar Eggemann (1):
      Revert "sched/core: Reduce cost of sched_move_task when config autogroup"

E Shattow (1):
      riscv: dts: starfive: Fix a typo in StarFive JH7110 pin function definitions

Fuad Tabba (1):
      KVM: arm64: Calculate cptr_el2 traps on activating traps

Gavrilov Ilia (1):
      xsk: fix an integer overflow in xp_create_and_assign_umem()

Geert Uytterhoeven (1):
      ARM: shmobile: smp: Enforce shmobile_smp_* alignment

Greg Kroah-Hartman (1):
      Linux 6.6.85

Gu Bowen (1):
      mmc: atmel-mci: Add missing clk_disable_unprepare()

Guillaume Nault (1):
      Revert "gre: Fix IPv6 link-local address generation."

Haibo Chen (2):
      can: flexcan: only change CAN state when link up in system PM
      can: flexcan: disable transceiver during system PM

Jeffrey Hugo (1):
      accel/qaic: Fix possible data corruption in BOs > 2G

Joe Hattori (1):
      firmware: imx-scu: fix OF node leak in .probe()

Josef Bacik (1):
      btrfs: make sure that WRITTEN is set on all metadata blocks

Junxian Huang (4):
      RDMA/hns: Fix soft lockup during bt pages loop
      RDMA/hns: Fix unmatched condition in error path of alloc_user_qp_db()
      RDMA/hns: Fix a missing rollback in error path of hns_roce_create_qp_common()
      RDMA/hns: Fix wrong value of max_sge_rd

Justin Iurman (1):
      net: lwtunnel: fix recursion loops

Justin Klaassen (1):
      arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S

Kamal Dasu (1):
      mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops

Kashyap Desai (1):
      RDMA/bnxt_re: Add missing paranthesis in map_qp_id_to_tbl_indx

Kuniyuki Iwashima (2):
      ipv6: Fix memleak of nhc_pcpu_rth_output in fib_check_nh_v6_gw().
      ipv6: Set errno after ip_fib_metrics_init() in ip6_route_info_create().

Lin Ma (1):
      net/neighbor: add missing policy for NDTPA_QUEUE_LENBYTES

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

Martin Tsai (1):
      drm/amd/display: should support dmub hw lock on Replay

Maíra Canal (1):
      drm/v3d: Don't run jobs that have errors flagged in its fence

Miri Korenblit (1):
      wifi: iwlwifi: support BIOS override for 5G9 in CA also in LARI version 8

Namjae Jeon (1):
      ksmbd: fix incorrect validation for num_aces field of smb_acl

Nikita Zhandarovich (1):
      drm/radeon: fix uninitialized size issue in radeon_vce_cs_parse()

Peng Fan (1):
      soc: imx8m: Unregister cpufreq and soc dev in cleanup path

Phil Elwell (2):
      ARM: dts: bcm2711: PL011 UARTs are actually r1p5
      ARM: dts: bcm2711: Don't mark timer regs unconfigured

Qasim Ijaz (1):
      RDMA/mlx5: Handle errors returned from mlx5r_ib_rate()

Quentin Schulz (1):
      arm64: dts: rockchip: fix pinmux of UART0 for PX30 Ringneck on Haikou

Raphael S. Carvalho (1):
      mm: fix error handling in __filemap_get_folio() with FGP_NOWAIT

Saranya R (1):
      soc: qcom: pdr: Fix the potential deadlock

Saravanan Vajravel (1):
      RDMA/bnxt_re: Avoid clearing VLAN_ID mask in modify qp path

Sebastian Andrzej Siewior (1):
      netfilter: nft_counter: Use u64_stats_t for statistic.

Shravya KN (1):
      bnxt_en: Fix receive ring space parameters when XDP is active

Stefan Eichenberger (3):
      arm64: dts: freescale: imx8mp-verdin-dahlia: add Microphone Jack to sound card
      arm64: dts: freescale: imx8mm-verdin-dahlia: add Microphone Jack to sound card
      ARM: dts: imx6qdl-apalis: Fix poweroff on Apalis iMX6

Sven Eckelmann (1):
      batman-adv: Ignore own maximum aggregation size during RX

Vincent Mailhol (1):
      can: ucan: fix out of bound read in strscpy() source

Yao Zi (1):
      arm64: dts: rockchip: Remove undocumented sdmmc property from lubancat-1

Ye Bin (1):
      proc: fix UAF in proc_get_inode()

Zi Yan (1):
      mm/migrate: fix shmem xarray update during migration

qianyi liu (1):
      drm/sched: Fix fence reference count leak


