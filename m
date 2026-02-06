Return-Path: <stable+bounces-214683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKagMVsZhmktJwQAu9opvQ
	(envelope-from <stable+bounces-214683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:39:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBAE1006F2
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA12630773C8
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3864932C301;
	Fri,  6 Feb 2026 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ClxdeTO7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E625B329E75;
	Fri,  6 Feb 2026 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395292; cv=none; b=qU0vmzqAR5lLx2h8PHvVfnV6oHrR56oPVFmNy01jHN6TJM0L3O/QHboWrgt32wGjnh8VCLsYva2bGAeRpRjcl4t8og7l9wug3td70eyrP67DCWrAmMaII0iJzXIlDi+1Zv0M5til4gnD6an6CnWpwF1aYQrIpK64iLCvTYdOwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395292; c=relaxed/simple;
	bh=3/KQG5lXmqSfgz9e6PuLEFK+ZcPl9noxwoOHyaJvCVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j7C6Aekj7uVUOt7Nqd20nuX0icOiAa2WmnnfxmjRDUBdw+ynuaUid72WDlydrqzgFwqFRgU99NbSkA5RTP/qklx45QOcNQ3VsDoW3CgWcVT1FkzeF7TQbKM+ap9JHO10e9bd6KAlQvtklchPptVUNv65lI9pyFW08+BCK06Tnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ClxdeTO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A0EC116C6;
	Fri,  6 Feb 2026 16:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770395291;
	bh=3/KQG5lXmqSfgz9e6PuLEFK+ZcPl9noxwoOHyaJvCVc=;
	h=From:To:Cc:Subject:Date:From;
	b=ClxdeTO72bGRbdxUrILN0nYhVbmNkLMl0Q29BQKajUT+JlSqgv5dtkTlrctHA9oDf
	 ChhL/ZtfAb3w/l1pUZy52Sdl5QeUJ/id3QPJGg1ia0FdVSCDKLeh28RdiSU3hGafAY
	 u9Ke3vjfTTOmxA24b9SkpitoTNC4wftnHWIx2iRE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.69
Date: Fri,  6 Feb 2026 17:27:47 +0100
Message-ID: <2026020647-diabetes-playtime-ccee@gregkh>
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
	TAGGED_FROM(0.00)[bounces-214683-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 3DBAE1006F2
X-Rspamd-Action: no action

I'm announcing the release of the 6.12.69 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm64/configs/defconfig                                   |    1 
 arch/riscv/include/asm/compat.h                                |    2 
 arch/x86/Makefile                                              |    2 
 drivers/bluetooth/hci_ldisc.c                                  |    4 
 drivers/gpio/gpio-pca953x.c                                    |    2 
 drivers/gpio/gpio-rockchip.c                                   |    8 
 drivers/gpio/gpio-virtuser.c                                   |    8 
 drivers/gpio/gpiolib-acpi-core.c                               |   21 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                        |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c                         |    5 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                         |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                         |   47 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                         |    2 
 drivers/gpu/drm/amd/amdgpu/soc21.c                             |    8 
 drivers/gpu/drm/imx/ipuv3/imx-tve.c                            |   13 
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c                      |    2 
 drivers/gpu/drm/nouveau/nouveau_display.c                      |    2 
 drivers/infiniband/hw/mana/device.c                            |   54 ++
 drivers/infiniband/hw/mana/mana_ib.h                           |    2 
 drivers/md/bcache/bcache.h                                     |    9 
 drivers/md/bcache/request.c                                    |   80 +--
 drivers/md/bcache/super.c                                      |   12 
 drivers/net/bonding/bond_main.c                                |   18 
 drivers/net/bonding/bond_options.c                             |    8 
 drivers/net/can/at91_can.c                                     |    2 
 drivers/net/can/usb/gs_usb.c                                   |    4 
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c               |    5 
 drivers/net/ethernet/intel/ice/ice_lib.c                       |   10 
 drivers/net/ethernet/intel/ice/ice_main.c                      |    1 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c                 |    2 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/debugfs.c              |   16 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c       |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                |   19 
 drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c |    2 
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c               |    3 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                 |   36 +
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h            |    1 
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c        |    1 
 drivers/net/ethernet/microsoft/mana/mana_en.c                  |   22 -
 drivers/net/ethernet/rocker/rocker_main.c                      |    5 
 drivers/net/phy/micrel.c                                       |   17 
 drivers/net/wireless/ath/ath11k/dp_rx.c                        |   10 
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c                     |    9 
 drivers/nvme/target/io-cmd-bdev.c                              |    3 
 drivers/pinctrl/meson/pinctrl-meson.c                          |    2 
 drivers/pinctrl/pinctrl-rockchip.c                             |    9 
 drivers/pinctrl/qcom/Kconfig                                   |   15 
 drivers/pinctrl/qcom/Makefile                                  |    1 
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c                       |   17 
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c                |    3 
 drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c                |  151 -------
 drivers/scsi/be2iscsi/be_mgmt.c                                |    1 
 drivers/scsi/qla2xxx/qla_os.c                                  |    2 
 drivers/target/sbp/sbp_target.c                                |    4 
 fs/btrfs/relocation.c                                          |   14 
 fs/efivarfs/vars.c                                             |    2 
 fs/fs-writeback.c                                              |   14 
 fs/smb/server/transport_rdma.c                                 |   15 
 include/linux/kasan.h                                          |   14 
 include/linux/sched.h                                          |    5 
 include/net/bonding.h                                          |   13 
 include/net/mana/mana.h                                        |    4 
 include/net/nfc/nfc.h                                          |    2 
 kernel/cgroup/cgroup.c                                         |    2 
 kernel/dma/pool.c                                              |    7 
 kernel/events/callchain.c                                      |   20 
 kernel/events/core.c                                           |    6 
 kernel/sched/deadline.c                                        |  206 ++++++++++
 lib/flex_proportions.c                                         |    5 
 mm/kasan/common.c                                              |   21 +
 mm/kfence/core.c                                               |   23 -
 mm/memory-failure.c                                            |   99 ++--
 mm/shmem.c                                                     |   45 +-
 mm/vmalloc.c                                                   |    7 
 net/bluetooth/mgmt.c                                           |    3 
 net/bridge/br_input.c                                          |    2 
 net/core/filter.c                                              |    2 
 net/ipv4/tcp_offload.c                                         |    3 
 net/ipv4/udp_offload.c                                         |    3 
 net/ipv6/icmp.c                                                |    4 
 net/ipv6/tcpv6_offload.c                                       |    3 
 net/mptcp/protocol.c                                           |   13 
 net/nfc/core.c                                                 |   27 +
 net/nfc/llcp_commands.c                                        |   17 
 net/nfc/llcp_core.c                                            |    4 
 net/nfc/nci/core.c                                             |    4 
 net/rxrpc/ar-internal.h                                        |    9 
 net/rxrpc/conn_event.c                                         |    2 
 net/rxrpc/output.c                                             |   10 
 net/rxrpc/peer_event.c                                         |   17 
 net/rxrpc/proc.c                                               |    4 
 net/rxrpc/rxkad.c                                              |    4 
 net/sched/act_ife.c                                            |    6 
 rust/kernel/rbtree.rs                                          |    2 
 scripts/Makefile.build                                         |    2 
 scripts/generate_rust_analyzer.py                              |   34 +
 sound/soc/amd/yc/acp6x-mach.c                                  |    8 
 sound/soc/fsl/imx-card.c                                       |    1 
 sound/soc/intel/boards/sof_es8336.c                            |    2 
 tools/lib/bpf/libbpf.c                                         |    4 
 tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c |    1 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                |   81 +++
 104 files changed, 999 insertions(+), 496 deletions(-)

Aaron Ma (1):
      ice: Fix NULL pointer dereference in ice_vsi_set_napi_queues

Alex Deucher (6):
      drm/amdgpu/soc21: fix xclk for APUs
      drm/amdgpu/gfx10: fix wptr reset in KGQ init
      drm/amdgpu/gfx11: fix wptr reset in KGQ init
      drm/amdgpu/gfx12: fix wptr reset in KGQ init
      drm/amdgpu: Fix cond_exec handling in amdgpu_ib_schedule()
      drm/amdgpu/gfx11: adjust KGQ reset sequence

Alexis Lothoré (eBPF Foundation) (1):
      bpf/selftests: test_select_reuseport_kern: Remove unused header

Andrey Ryabinin (1):
      mm/kasan: fix KASAN poisoning in vrealloc()

Andy Shevchenko (1):
      gpiolib: acpi: Fix potential out-of-boundary left shift

Bartosz Golaszewski (2):
      pinctrl: meson: mark the GPIO controller as sleeping
      pinctrl: lpass-lpi: implement .get_direction() for the GPIO driver

Chen Ni (1):
      net/sched: act_ife: convert comma to semicolon

Cosmin Ratiu (1):
      net/mlx5: Initialize events outside devlink lock

David Howells (1):
      rxrpc: Fix data-race warning and potential load/store tearing

Denis Sergeev (1):
      gpiolib: acpi: use BIT_ULL() for u64 mask in address space handler

Eric Dumazet (1):
      bonding: annotate data-races around slave->last_rx

Fabio Estevam (1):
      ASoC: fsl: imx-card: Do not force slot width to sample width

Fernando Fernandez Mancera (1):
      ipv6: use the right ifindex when replying to icmpv6 from localhost

Greg Kroah-Hartman (1):
      Linux 6.12.69

Han Gao (1):
      riscv: compat: fix COMPAT_UTS_MACHINE definition

Hang Shu (1):
      rust: rbtree: fix documentation typo in CursorMut peek_next method

Haoxiang Li (1):
      scsi: be2iscsi: Fix a memory leak in beiscsi_boot_get_sinfo()

JP Kobryn (1):
      btrfs: prevent use-after-free on folio private data in btrfs_subpage_clear_uptodate()

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

Josh Poimboeuf (1):
      perf: Simplify get_perf_callchain() user logic

Justin Chen (1):
      net: bcmasp: fix early exit leak with fixed phy

Kairui Song (1):
      mm/shmem, swap: fix race of truncate and swap entry split

Kang Yang (1):
      wifi: ath11k: add srng->lock for ath11k_hal_srng_* in monitor mode

Kery Qi (3):
      net: wwan: t7xx: fix potential skb->frags overflow in RX path
      rocker: fix memory leak in rocker_world_port_post_fini()
      scsi: firewire: sbp-target: Fix overflow in sbp_make_tpg()

Kohei Enju (1):
      efivarfs: fix error propagation in efivar_entry_get()

Krzysztof Kozlowski (1):
      pinctrl: qcom: sm8350-lpass-lpi: Merge with SC7280 to fix I2S2 and SWR TX pins

Kuniyuki Iwashima (2):
      nfc: llcp: Fix memleak in nfc_llcp_send_ui_frame().
      nfc: nci: Fix race between rfkill and nci_unregister_device().

Laveesh Bansal (1):
      writeback: fix 100% CPU usage when dirtytime_expire_interval is 0

Long Li (2):
      net: mana: Change the function signature of mana_get_primary_netdev_rcu
      RDMA/mana_ib: Handle net event for pointing to the current netdev

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

Miguel Ojeda (2):
      rust: kbuild: give `--config-path` to `rustfmt` in `.rsi` target
      rust: kbuild: support `-Cjump-tables=n` for Rust 1.93.0

Mikhail Gavrilov (1):
      libbpf: Fix -Wdiscarded-qualifiers under C23

Ming Lei (1):
      nvmet: fix race in nvmet_bio_done() leading to NULL pointer dereference

Onur Özkan (1):
      scripts: generate_rust_analyzer: remove sysroot assertion

Parav Pandit (1):
      net/mlx5: Fix vhca_id access call trace use before alloc

Peter Zijlstra (2):
      sched/deadline: Document dl_server
      sched/deadline: Fix 'stuck' dl_server

Pimyn Girgis (1):
      mm/kfence: randomize the freelist on initialization

Robin Murphy (1):
      gpio: rockchip: Stop calling pinctrl for set_direction

Sai Sree Kartheek Adivi (1):
      dma/pool: distinguish between missing and exhausted atomic pools

Shay Drory (1):
      net/mlx5: fs, Fix inverted cap check in tx flow table root disconnect

Shida Zhang (3):
      bcache: fix improper use of bi_end_io
      bcache: use bio cloning for detached device requests
      bcache: fix I/O accounting leak in detached_dev_do_request

Steven Rostedt (1):
      perf: sched: Fix perf crash with new is_user_task() helper

T.J. Mercier (1):
      cgroup: Fix kernfs_node UAF in css_free_rwork_fn

Tagir Garaev (1):
      ASoC: Intel: sof_es8336: fix headphone GPIO logic inversion

Tamir Duberstein (2):
      scripts: generate_rust_analyzer: compile sysroot with correct edition
      scripts: generate_rust_analyzer: Add compiler_builtins -> core dep

Thomas Fourier (2):
      scsi: qla2xxx: edif: Fix dma_free_coherent() size
      ksmbd: smbd: fix dma_unmap_sg() nents

Wei Fang (1):
      net: phy: micrel: fix clk warning when removing the driver

Yuhao Huang (1):
      gpio: virtuser: fix UAF in configfs release path

Zhang Heng (1):
      ASoC: amd: yc: Add DMI quirk for Acer TravelMate P216-41-TCO

Zilin Guan (4):
      can: at91_can: Fix memory leak in at91_can_probe()
      net/mlx5: Fix memory leak in esw_acl_ingress_lgcy_setup()
      octeon_ep: Fix memory leak in octep_device_setup()
      net: mvpp2: cls: Fix memory leak in mvpp2_ethtool_cls_rule_ins()


