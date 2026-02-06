Return-Path: <stable+bounces-214684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOGbKz8Yhmk1JgQAu9opvQ
	(envelope-from <stable+bounces-214684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:35:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11686100591
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 152853043D1F
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D3735CBB0;
	Fri,  6 Feb 2026 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E9LQBPY/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702D328B7A;
	Fri,  6 Feb 2026 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395295; cv=none; b=pMYG1jcnf1GsqgnAAHOTw/4WVgZabMbBf1fdHtFmJ5jzkUKhp0biPyBzXp7y7GU9b99j0zx82AL0gGxfoBwVAxCPz0WUrxlZS0LP8vaNGbEcOGHzidxagVXWibsY++gumpQLKR+YATJYkI1lF6w9hM2XryRZsNTr6kQONBZVB68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395295; c=relaxed/simple;
	bh=So6ZE5A45nDAl/L4SBfHTZHV5NBZxMmEkZXalXeUGo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BnNkEDzFxRGlGKP8vkA13uRBpkKa7vv6+cgwGgD+uyOBrxC3dHRNTQm4XyWJdBYnYjqRMDyvxvaTymTLhal7oQnGlXWnjQtOF6QfyhqQuwNgjusKfx2TqdbRAnOAkLCN/+K5Q9MTPtay/UgVtSuQ3C1G4LXQW900qLO1LJ0IZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E9LQBPY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AEDC19422;
	Fri,  6 Feb 2026 16:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770395295;
	bh=So6ZE5A45nDAl/L4SBfHTZHV5NBZxMmEkZXalXeUGo8=;
	h=From:To:Cc:Subject:Date:From;
	b=E9LQBPY/mgHjS5tkxE9+V7jPxzZyfcKROfYCZcJlXwnc+cGMvy1ViZrqvxLNRqv2i
	 VqoUYnjT9HgccrxLN+hkpt9wCW7fx2B6dlTRLwdZstresONpRTNXpkBGIuObfcOWhk
	 GFswzZnkyODwZDGUNhNg2VR4ICzzQ2qO6n8btRfA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.9
Date: Fri,  6 Feb 2026 17:27:54 +0100
Message-ID: <2026020654-lend-unequal-d3a5@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214684-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 11686100591
X-Rspamd-Action: no action

I'm announcing the release of the 6.18.9 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    5 
 arch/arm64/configs/defconfig                                   |    1 
 arch/riscv/include/asm/compat.h                                |    2 
 drivers/bluetooth/hci_ldisc.c                                  |    4 
 drivers/firewire/core-transaction.c                            |   19 
 drivers/gpio/gpio-brcmstb.c                                    |    8 
 drivers/gpio/gpio-pca953x.c                                    |    2 
 drivers/gpio/gpio-rockchip.c                                   |    8 
 drivers/gpio/gpio-virtuser.c                                   |    8 
 drivers/gpio/gpiolib-acpi-core.c                               |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                        |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c                         |    5 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                         |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                         |   25 -
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                         |   25 -
 drivers/gpu/drm/amd/amdgpu/soc21.c                             |    8 
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                            |    7 
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                   |    1 
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h                   |    1 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                 |    1 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c                 |    1 
 drivers/gpu/drm/drm_gem.c                                      |   18 
 drivers/gpu/drm/imx/ipuv3/imx-tve.c                            |   13 
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c                      |    2 
 drivers/gpu/drm/nouveau/nouveau_display.c                      |    2 
 drivers/gpu/drm/tyr/Kconfig                                    |    1 
 drivers/gpu/drm/xe/xe_configfs.c                               |    3 
 drivers/gpu/drm/xe/xe_device.c                                 |    2 
 drivers/gpu/drm/xe/xe_exec.c                                   |    6 
 drivers/gpu/drm/xe/xe_lrc.c                                    |    2 
 drivers/gpu/drm/xe/xe_nvm.c                                    |   55 +-
 drivers/gpu/drm/xe/xe_nvm.h                                    |    2 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                 |    3 
 drivers/md/bcache/bcache.h                                     |    9 
 drivers/md/bcache/request.c                                    |   80 +--
 drivers/md/bcache/super.c                                      |   12 
 drivers/net/bonding/bond_main.c                                |   28 -
 drivers/net/bonding/bond_options.c                             |    8 
 drivers/net/can/at91_can.c                                     |    2 
 drivers/net/can/usb/gs_usb.c                                   |    4 
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c               |    5 
 drivers/net/ethernet/intel/ice/ice_lib.c                       |   10 
 drivers/net/ethernet/intel/ice/ice_main.c                      |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                  |   26 -
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c                 |    2 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/debugfs.c              |   16 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c       |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c    |   17 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c              |   20 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                |   19 
 drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c |    2 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h              |    2 
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c               |    3 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                 |   36 -
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h            |    1 
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c        |    1 
 drivers/net/ethernet/rocker/rocker_main.c                      |    5 
 drivers/net/ethernet/sfc/mcdi_filters.c                        |    7 
 drivers/net/ethernet/spacemit/k1_emac.c                        |   34 +
 drivers/net/phy/micrel.c                                       |   17 
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c                     |    9 
 drivers/nvme/target/io-cmd-bdev.c                              |    3 
 drivers/of/of_reserved_mem.c                                   |   44 +-
 drivers/pinctrl/meson/pinctrl-meson.c                          |    2 
 drivers/pinctrl/pinctrl-rockchip.c                             |    9 
 drivers/pinctrl/qcom/Kconfig                                   |   15 
 drivers/pinctrl/qcom/Makefile                                  |    1 
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c                       |   17 
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c                |    3 
 drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c                |  151 ------
 drivers/scsi/be2iscsi/be_mgmt.c                                |    1 
 drivers/scsi/qla2xxx/qla_os.c                                  |    2 
 drivers/target/sbp/sbp_target.c                                |    4 
 fs/btrfs/disk-io.c                                             |   22 -
 fs/btrfs/extent_io.c                                           |    3 
 fs/btrfs/extent_io.h                                           |    3 
 fs/btrfs/zlib.c                                                |    1 
 fs/efivarfs/vars.c                                             |    2 
 fs/fs-writeback.c                                              |   14 
 fs/readdir.c                                                   |    3 
 include/linux/cma.h                                            |    9 
 include/linux/fs.h                                             |    6 
 include/linux/kasan.h                                          |   14 
 include/linux/sched.h                                          |    5 
 include/net/bonding.h                                          |   13 
 include/net/nfc/nfc.h                                          |    2 
 kernel/dma/contiguous.c                                        |   16 
 kernel/dma/pool.c                                              |    7 
 kernel/events/callchain.c                                      |    2 
 kernel/events/core.c                                           |    6 
 kernel/sched/deadline.c                                        |  206 +++++++++
 kernel/sched/ext.c                                             |   57 +-
 kernel/sched/ext_internal.h                                    |    6 
 lib/flex_proportions.c                                         |    5 
 mm/kasan/common.c                                              |   21 
 mm/kfence/core.c                                               |   23 -
 mm/memory-failure.c                                            |   99 ++--
 mm/shmem.c                                                     |   45 +-
 mm/swap.h                                                      |    2 
 mm/swap_state.c                                                |    3 
 mm/vmalloc.c                                                   |    7 
 net/bluetooth/mgmt.c                                           |    3 
 net/bridge/br_input.c                                          |    2 
 net/core/filter.c                                              |    2 
 net/ipv4/tcp_offload.c                                         |    3 
 net/ipv4/udp_offload.c                                         |    3 
 net/ipv6/icmp.c                                                |    4 
 net/ipv6/tcpv6_offload.c                                       |    3 
 net/mac80211/ieee80211_i.h                                     |    2 
 net/mac80211/mlme.c                                            |  217 +++++-----
 net/mptcp/pm_kernel.c                                          |   16 
 net/mptcp/protocol.c                                           |   13 
 net/nfc/core.c                                                 |   27 +
 net/nfc/llcp_commands.c                                        |   17 
 net/nfc/llcp_core.c                                            |    4 
 net/nfc/nci/core.c                                             |    4 
 net/sched/act_ife.c                                            |    6 
 rust/kernel/bits.rs                                            |    6 
 rust/kernel/rbtree.rs                                          |    2 
 rust/kernel/sync/atomic/predefine.rs                           |   11 
 rust/kernel/sync/refcount.rs                                   |    3 
 scripts/Makefile.build                                         |    2 
 scripts/Makefile.vmlinux                                       |    3 
 scripts/generate_rust_analyzer.py                              |   40 +
 scripts/package/kernel.spec                                    |   65 +-
 sound/hda/codecs/realtek/alc269.c                              |    1 
 sound/soc/amd/yc/acp6x-mach.c                                  |    8 
 sound/soc/fsl/imx-card.c                                       |    1 
 sound/soc/intel/boards/sof_es8336.c                            |    2 
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c              |    2 
 tools/lib/bpf/libbpf.c                                         |    7 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                |   81 +++
 133 files changed, 1283 insertions(+), 782 deletions(-)

Aaron Ma (1):
      ice: Fix NULL pointer dereference in ice_vsi_set_napi_queues

Alex Deucher (7):
      drm/amdgpu/soc21: fix xclk for APUs
      drm/amdgpu/gfx10: fix wptr reset in KGQ init
      drm/amdgpu/gfx11: fix wptr reset in KGQ init
      drm/amdgpu/gfx11: adjust KGQ reset sequence
      drm/amdgpu/gfx12: fix wptr reset in KGQ init
      drm/amdgpu/gfx12: adjust KGQ reset sequence
      drm/amdgpu: Fix cond_exec handling in amdgpu_ib_schedule()

Alexandre Courbot (2):
      rust: bits: always inline functions using build_assert with arguments
      rust: sync: refcount: always inline functions using build_assert with arguments

Amir Goldstein (1):
      readdir: require opt-in for d_type flags

Andrey Ryabinin (1):
      mm/kasan: fix KASAN poisoning in vrealloc()

Andy Shevchenko (1):
      gpiolib: acpi: Fix potential out-of-boundary left shift

Bard Liao (1):
      ASoC: soc-acpi-intel-ptl-match: fix name_prefix of rt1320-2

Bartosz Golaszewski (2):
      pinctrl: lpass-lpi: implement .get_direction() for the GPIO driver
      pinctrl: meson: mark the GPIO controller as sleeping

Benjamin Berg (3):
      wifi: mac80211: parse all TTLM entries
      wifi: mac80211: apply advertised TTLM from association response
      wifi: mac80211: correctly decode TTLM with default link map

Chen Miao (1):
      kbuild: rust: clean libpin_init_internal in mrproper

Chen Ni (1):
      net/sched: act_ife: convert comma to semicolon

Cosmin Ratiu (1):
      net/mlx5: Initialize events outside devlink lock

Daniel Zahka (1):
      net/mlx5e: don't assume psp tx skbs are ipv6 csum handling

Denis Sergeev (1):
      gpiolib: acpi: use BIT_ULL() for u64 mask in address space handler

Doug Berger (1):
      gpio: brcmstb: correct hwirq to bank map

Edward Cree (1):
      sfc: fix deadlock in RSS config read

Eric Dumazet (2):
      bonding: annotate data-races around slave->last_rx
      mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()

Ethan Zuo (1):
      kbuild: Fix permissions of modules.builtin.modinfo

Fabio Estevam (1):
      ASoC: fsl: imx-card: Do not force slot width to sample width

Fernando Fernandez Mancera (1):
      ipv6: use the right ifindex when replying to icmpv6 from localhost

Gal Pressman (1):
      net/mlx5e: Account for netdev stats in ndo_get_stats64

Greg Kroah-Hartman (1):
      Linux 6.18.9

Han Gao (1):
      riscv: compat: fix COMPAT_UTS_MACHINE definition

Hang Shu (1):
      rust: rbtree: fix documentation typo in CursorMut peek_next method

Haoxiang Li (1):
      scsi: be2iscsi: Fix a memory leak in beiscsi_boot_get_sinfo()

Jan Kara (1):
      flex_proportions: make fprop_new_period() hardirq safe

Jane Chu (2):
      mm/memory-failure: fix missing ->mf_stats count in hugetlb poison
      mm/memory-failure: teach kill_accessing_process to accept hugetlb tail page pfn

Jesse Brandeburg (1):
      ice: stop counting UDP csum mismatch as rx_errors

Jia-Hong Su (1):
      Bluetooth: hci_uart: fix null-ptr-deref in hci_uart_write_work

Jianbo Liu (1):
      net/mlx5e: Skip ESN replay window setup for IPsec crypto offload

Jianpeng Chang (1):
      Bluetooth: MGMT: Fix memory leak in set_ssp_complete

Jibin Zhang (1):
      net: fix segmentation of forwarding fraglist GRO

Johan Hovold (2):
      drm/msm/a6xx: fix bogus hwcg register updates
      drm/imx/tve: fix probe device leak

John Ogness (1):
      Revert "drm/nouveau/disp: Set drm_mode_config_funcs.atomic_(check|commit)"

Jon Doron (1):
      drm/amdgpu: fix NULL pointer dereference in amdgpu_gmc_filter_faults_remove

Justin Chen (1):
      net: bcmasp: fix early exit leak with fixed phy

Kairui Song (1):
      mm/shmem, swap: fix race of truncate and swap entry split

Kery Qi (3):
      net: wwan: t7xx: fix potential skb->frags overflow in RX path
      rocker: fix memory leak in rocker_world_port_post_fini()
      scsi: firewire: sbp-target: Fix overflow in sbp_make_tpg()

Kohei Enju (3):
      ixgbe: fix memory leaks in the ixgbe_recovery_probe() path
      ixgbe: don't initialize aci lock in ixgbe_recovery_probe()
      efivarfs: fix error propagation in efivar_entry_get()

Krzysztof Kozlowski (1):
      pinctrl: qcom: sm8350-lpass-lpi: Merge with SC7280 to fix I2S2 and SWR TX pins

Kuniyuki Iwashima (2):
      nfc: llcp: Fix memleak in nfc_llcp_send_ui_frame().
      nfc: nci: Fix race between rfkill and nci_unregister_device().

Laveesh Bansal (1):
      writeback: fix 100% CPU usage when dirtytime_expire_interval is 0

Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): fix error message

Mark Bloch (1):
      net/mlx5e: TC, delete flows only for existing peers

Martin Kaiser (1):
      net: bridge: fix static key check

Martin Larsson (1):
      gpio: pca953x: mask interrupts in irq shutdown

Matthieu Baerts (NGI0) (5):
      mptcp: only reset subflow errors when propagated
      selftests: mptcp: check no dup close events after error
      selftests: mptcp: check subflow errors in close events
      selftests: mptcp: join: fix local endp not being tracked
      mptcp: avoid dup SUB_CLOSED events after disconnect

Miguel Ojeda (3):
      rust: kbuild: give `--config-path` to `rustfmt` in `.rsi` target
      rust: sync: atomic: Provide stub for `rusttest` 32-bit hosts
      drm/tyr: depend on `COMMON_CLK` to fix build error

Mikhail Gavrilov (1):
      libbpf: Fix -Wdiscarded-qualifiers under C23

Ming Lei (1):
      nvmet: fix race in nvmet_bio_done() leading to NULL pointer dereference

Nathan Chancellor (1):
      kbuild: rpm-pkg: Generate debuginfo package manually

Nicolin Chen (1):
      iommu/tegra241-cmdqv: Reset VCMDQ in tegra241_vcmdq_hw_init_user()

Nikolay Aleksandrov (1):
      bonding: fix use-after-free due to enslave fail after slave array update

Onur Özkan (1):
      scripts: generate_rust_analyzer: remove sysroot assertion

Oreoluwa Babatunde (1):
      of: reserved_mem: Allow reserved_mem framework detect "cma=" kernel param

Parav Pandit (1):
      net/mlx5: Fix vhca_id access call trace use before alloc

Peter Zijlstra (2):
      sched/deadline: Document dl_server
      sched/deadline: Fix 'stuck' dl_server

Pimyn Girgis (1):
      mm/kfence: randomize the freelist on initialization

Qu Wenruo (2):
      btrfs: zlib: fix the folio leak on S390 hardware acceleration
      btrfs: do not strictly require dirty metadata threshold for metadata writepages

Robin Murphy (1):
      gpio: rockchip: Stop calling pinctrl for set_direction

Sai Sree Kartheek Adivi (1):
      dma/pool: distinguish between missing and exhausted atomic pools

SeungJong Ha (1):
      scripts: generate_rust_analyzer: fix resolution of #[pin_data] macros

Shay Drory (1):
      net/mlx5: fs, Fix inverted cap check in tx flow table root disconnect

Shida Zhang (3):
      bcache: fix improper use of bi_end_io
      bcache: use bio cloning for detached device requests
      bcache: fix I/O accounting leak in detached_dev_do_request

Shuicheng Lin (4):
      drm/xe: Skip address copy for sync-only execs
      drm/xe/configfs: Fix is_bound() pci_dev lifetime
      drm/xe/nvm: Manage nvm aux cleanup with devres
      drm/xe/nvm: Fix double-free on aux add failure

Steven Rostedt (1):
      perf: sched: Fix perf crash with new is_user_task() helper

Tagir Garaev (1):
      ASoC: Intel: sof_es8336: fix headphone GPIO logic inversion

Takashi Sakamoto (1):
      firewire: core: fix race condition against transaction list

Tamir Duberstein (4):
      scripts: generate_rust_analyzer: Add pin_init -> compiler_builtins dep
      scripts: generate_rust_analyzer: Add pin_init_internal deps
      scripts: generate_rust_analyzer: compile sysroot with correct edition
      scripts: generate_rust_analyzer: Add compiler_builtins -> core dep

Tejun Heo (2):
      sched_ext: Don't kick CPUs running higher classes
      sched_ext: Fix SCX_KICK_WAIT to work reliably

Thomas Fourier (1):
      scsi: qla2xxx: edif: Fix dma_free_coherent() size

Tvrtko Ursulin (2):
      drm: Do not allow userspace to trigger kernel warnings in drm_gem_change_handle_ioctl()
      drm/xe/xelp: Fix Wa_18022495364

Vivian Wang (1):
      net: spacemit: Check for netif_carrier_ok() in emac_stats_update()

Wei Fang (1):
      net: phy: micrel: fix clk warning when removing the driver

Yang Wang (3):
      drm/amd/pm: fix race in power state check before mutex lock
      drm/amd/pm: fix smu v13 soft clock frequency setting issue
      drm/amd/pm: fix smu v14 soft clock frequency setting issue

Yuhao Huang (1):
      gpio: virtuser: fix UAF in configfs release path

Yuntao Wang (1):
      of/reserved_mem: Simplify the logic of fdt_scan_reserved_mem_reg_nodes()

Zeng Chi (1):
      net/mlx5: Fix return type mismatch in mlx5_esw_vport_vhca_id()

Zhang Heng (2):
      ASoC: amd: yc: Add DMI quirk for Acer TravelMate P216-41-TCO
      ALSA: hda/realtek: fix right sounds and mute/micmute LEDs for HP machine

Zilin Guan (4):
      can: at91_can: Fix memory leak in at91_can_probe()
      net/mlx5: Fix memory leak in esw_acl_ingress_lgcy_setup()
      octeon_ep: Fix memory leak in octep_device_setup()
      net: mvpp2: cls: Fix memory leak in mvpp2_ethtool_cls_rule_ins()

robin.kuo (1):
      mm, swap: restore swap_space attr aviod kernel panic


