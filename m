Return-Path: <stable+bounces-214681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLGJBRIYhmk1JgQAu9opvQ
	(envelope-from <stable+bounces-214681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:34:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9374710056B
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF22030BD7AE
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874CD330B3A;
	Fri,  6 Feb 2026 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v8eExDRD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E232B9B7;
	Fri,  6 Feb 2026 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395284; cv=none; b=Zxu1Rxi11lOXxAXjBP7uIa+UhV/h+Wbb/+fEdzFP/NhFgnq4mX4dWUekGj5IOLmHFX5klihXoLTxl3HErsXNiT2npMtHyAje0J91pDhH7y6TaEWZ5k8yzUdzbF54krecYcPHzHvZS+zlm907DgR8/MJljxG1uIs9oWCwteON8rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395284; c=relaxed/simple;
	bh=FIwXIkYptsPnODYqD61tvWRTizvLVk6IESBwgEkxL+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k9PPdh0hull1cYLWU6TMnluUXf79PrYt8RwFaBozzpmry3FLLvXgHOLKTMcA/2fMF7YhiZSJWprAnwLCIY85+EOK2KdDcPMe5/pH1Y4F+HBRSzWYCJ+F3/4YxGM9IRnHQ7CIaHpJcclnvatTZxrHeZTQDjIUQfnh/BTRY3YdjRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v8eExDRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50419C2BCAF;
	Fri,  6 Feb 2026 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770395283;
	bh=FIwXIkYptsPnODYqD61tvWRTizvLVk6IESBwgEkxL+0=;
	h=From:To:Cc:Subject:Date:From;
	b=v8eExDRDrLAJaPIycGcVI5g3DGNjMikzPnP3O3a8YEaWJPI1pF1OXI6i7Ns/xByhu
	 cE/OOUrnP4JYM39Ysa2WWE0euXuyflCTJNyelofDBCwvtxta8t/rXfqM+hkmcKQdb+
	 0LsZo168Bgfow6zRccy9NGuwwsrqUql1RPTDDD10=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.123
Date: Fri,  6 Feb 2026 17:27:41 +0100
Message-ID: <2026020642-privacy-cabana-23a4@gregkh>
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
	TAGGED_FROM(0.00)[bounces-214681-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 9374710056B
X-Rspamd-Action: no action

I'm announcing the release of the 6.6.123 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm64/kernel/signal.c                                     |   92 +++--
 arch/riscv/include/asm/compat.h                                |    2 
 drivers/bluetooth/hci_ldisc.c                                  |    4 
 drivers/gpio/gpio-pca953x.c                                    |    2 
 drivers/gpio/gpio-rockchip.c                                   |    8 
 drivers/gpio/gpiolib-acpi.c                                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                        |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                       |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h                       |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                         |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                         |    2 
 drivers/gpu/drm/amd/amdgpu/soc21.c                             |    8 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c             |    2 
 drivers/gpu/drm/imx/ipuv3/imx-tve.c                            |   13 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                          |    2 
 drivers/gpu/drm/radeon/radeon_fence.c                          |    8 
 drivers/misc/mei/mei-trace.h                                   |   18 -
 drivers/net/bonding/bond_main.c                                |   18 -
 drivers/net/bonding/bond_options.c                             |    8 
 drivers/net/can/usb/gs_usb.c                                   |    4 
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c               |    5 
 drivers/net/ethernet/intel/ice/ice_main.c                      |    1 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c                 |    2 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c       |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c              |   19 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                |   19 -
 drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c |    2 
 drivers/net/ethernet/rocker/rocker_main.c                      |    5 
 drivers/net/tap.c                                              |    6 
 drivers/net/team/team.c                                        |   23 -
 drivers/net/tun.c                                              |    6 
 drivers/net/wireless/ath/ath11k/dp_rx.c                        |   10 
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c                     |    9 
 drivers/pinctrl/meson/pinctrl-meson.c                          |    2 
 drivers/pinctrl/pinctrl-rockchip.c                             |    9 
 drivers/pinctrl/qcom/Kconfig                                   |   15 
 drivers/pinctrl/qcom/Makefile                                  |    1 
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c                       |   17 +
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c                |    3 
 drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c                |  167 ----------
 drivers/scsi/be2iscsi/be_mgmt.c                                |    1 
 drivers/scsi/qla2xxx/qla_os.c                                  |    2 
 drivers/target/sbp/sbp_target.c                                |    4 
 fs/btrfs/relocation.c                                          |   13 
 fs/efivarfs/vars.c                                             |    2 
 fs/fs-writeback.c                                              |   14 
 fs/smb/server/mgmt/user_session.c                              |   21 -
 fs/smb/server/smb2pdu.c                                        |    9 
 fs/smb/server/transport_ipc.c                                  |   12 
 fs/smb/server/transport_rdma.c                                 |   15 
 include/linux/ptr_ring.h                                       |   17 -
 include/linux/sched.h                                          |    5 
 include/linux/skb_array.h                                      |   14 
 include/net/bonding.h                                          |   13 
 include/net/nfc/nfc.h                                          |    2 
 include/net/xdp_sock.h                                         |    3 
 include/net/xsk_buff_pool.h                                    |    2 
 kernel/dma/pool.c                                              |    7 
 kernel/events/callchain.c                                      |    2 
 kernel/events/core.c                                           |    6 
 lib/flex_proportions.c                                         |    5 
 mm/kfence/core.c                                               |   23 +
 net/bridge/br_input.c                                          |    2 
 net/core/dev.c                                                 |  162 ++-------
 net/ipv6/icmp.c                                                |    4 
 net/mac80211/ieee80211_i.h                                     |    4 
 net/mac80211/mlme.c                                            |    7 
 net/mac80211/tdls.c                                            |   11 
 net/mptcp/protocol.c                                           |   13 
 net/nfc/core.c                                                 |   27 +
 net/nfc/llcp_commands.c                                        |   17 -
 net/nfc/llcp_core.c                                            |    4 
 net/nfc/nci/core.c                                             |    4 
 net/sched/act_ife.c                                            |    6 
 net/sched/sch_generic.c                                        |    4 
 net/xdp/xsk.c                                                  |    6 
 net/xdp/xsk_buff_pool.c                                        |    1 
 scripts/Makefile.build                                         |    2 
 scripts/generate_rust_analyzer.py                              |    2 
 sound/soc/amd/yc/acp6x-mach.c                                  |    8 
 sound/soc/fsl/imx-card.c                                       |    1 
 sound/soc/intel/boards/sof_es8336.c                            |    2 
 sound/usb/endpoint.c                                           |    3 
 tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c |    1 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                |   81 ++++
 88 files changed, 570 insertions(+), 537 deletions(-)

Alex Deucher (4):
      drm/amdgpu/soc21: fix xclk for APUs
      drm/amdgpu/gfx10: fix wptr reset in KGQ init
      drm/amdgpu/gfx11: fix wptr reset in KGQ init
      drm/amd/display: use udelay rather than fsleep

Alexander Usyskin (1):
      mei: trace: treat reg parameter as string

Alexis Lothoré (eBPF Foundation) (1):
      bpf/selftests: test_select_reuseport_kern: Remove unused header

Bartosz Golaszewski (2):
      pinctrl: meson: mark the GPIO controller as sleeping
      pinctrl: lpass-lpi: implement .get_direction() for the GPIO driver

Chen Ni (1):
      net/sched: act_ife: convert comma to semicolon

Denis Sergeev (1):
      gpiolib: acpi: use BIT_ULL() for u64 mask in address space handler

Eric Dumazet (2):
      bonding: annotate data-races around slave->last_rx
      ptr_ring: do not block hard interrupts in ptr_ring_resize_multiple()

Fabio Estevam (1):
      ASoC: fsl: imx-card: Do not force slot width to sample width

Fernando Fernandez Mancera (1):
      ipv6: use the right ifindex when replying to icmpv6 from localhost

Gal Pressman (1):
      net/mlx5e: Account for netdev stats in ndo_get_stats64

Greg Kroah-Hartman (3):
      Revert "net: Allow to use SMP threads for backlog NAPI."
      Revert "net: Remove conditional threaded-NAPI wakeup based on task state."
      Linux 6.6.123

Han Gao (1):
      riscv: compat: fix COMPAT_UTS_MACHINE definition

Haoxiang Li (1):
      scsi: be2iscsi: Fix a memory leak in beiscsi_boot_get_sinfo()

JP Kobryn (1):
      btrfs: prevent use-after-free on page private data in btrfs_subpage_clear_uptodate()

Jan Kara (1):
      flex_proportions: make fprop_new_period() hardirq safe

Jesse Brandeburg (1):
      ice: stop counting UDP csum mismatch as rx_errors

Jia-Hong Su (1):
      Bluetooth: hci_uart: fix null-ptr-deref in hci_uart_write_work

Jianbo Liu (1):
      net/mlx5e: Skip ESN replay window setup for IPsec crypto offload

Johan Hovold (2):
      drm/imx/tve: fix probe device leak
      drm/msm/a6xx: fix bogus hwcg register updates

Johannes Berg (1):
      wifi: mac80211: move TDLS work to wiphy work

Jon Doron (1):
      drm/amdgpu: fix NULL pointer dereference in amdgpu_gmc_filter_faults_remove

Justin Chen (1):
      net: bcmasp: fix early exit leak with fixed phy

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

Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): fix error message

Marios Makassikis (1):
      ksmbd: fix recursive locking in RPC handle list access

Mark Bloch (1):
      net/mlx5e: TC, delete flows only for existing peers

Mark Rutland (3):
      arm64/fpsimd: signal: Mandate SVE payload for streaming-mode state
      arm64/fpsimd: signal: Consistently read FPSIMD context
      arm64/fpsimd: signal: Fix restoration of SVE context

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

Miguel Ojeda (1):
      rust: kbuild: give `--config-path` to `rustfmt` in `.rsi` target

Nikola Z. Ivanov (1):
      team: Move team device type change at the end of team_port_add

Philip Yang (1):
      drm/amdkfd: Don't use sw fault filter if retry cam enabled

Pimyn Girgis (1):
      mm/kfence: randomize the freelist on initialization

Robert McClinton (1):
      drm/radeon: delete radeon_fence_process in is_signaled, no deadlock

Robin Murphy (1):
      gpio: rockchip: Stop calling pinctrl for set_direction

Sai Sree Kartheek Adivi (1):
      dma/pool: distinguish between missing and exhausted atomic pools

Srinivasan Shanmugam (1):
      drm/amdgpu: Replace Mutex with Spinlock for RLCG register access to avoid Priority Inversion in SRIOV

Steven Rostedt (1):
      perf: sched: Fix perf crash with new is_user_task() helper

Tagir Garaev (1):
      ASoC: Intel: sof_es8336: fix headphone GPIO logic inversion

Takashi Iwai (1):
      ALSA: usb-audio: Fix missing unlock at error path of maxpacksize check

Tamir Duberstein (1):
      scripts: generate_rust_analyzer: Add compiler_builtins -> core dep

Thomas Fourier (2):
      scsi: qla2xxx: edif: Fix dma_free_coherent() size
      ksmbd: smbd: fix dma_unmap_sg() nents

Yafang Shao (1):
      net/mlx5e: Report rx_discards_phy via rx_dropped

Yunseong Kim (1):
      ksmbd: Fix race condition in RPC handle list access

Zhang Heng (1):
      ASoC: amd: yc: Add DMI quirk for Acer TravelMate P216-41-TCO

Zilin Guan (3):
      net/mlx5: Fix memory leak in esw_acl_ingress_lgcy_setup()
      octeon_ep: Fix memory leak in octep_device_setup()
      net: mvpp2: cls: Fix memory leak in mvpp2_ethtool_cls_rule_ins()

e.kubanski (1):
      xsk: Fix race condition in AF_XDP generic RX path


