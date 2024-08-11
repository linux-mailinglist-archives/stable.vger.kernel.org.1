Return-Path: <stable+bounces-66354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEEE94E0E8
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 12:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD9F1F2172E
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 10:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80783EA83;
	Sun, 11 Aug 2024 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cOJOw2FW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1F41C62;
	Sun, 11 Aug 2024 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723373891; cv=none; b=aCHAI4l2a5hcvccVqQlojYIjvh3WMqukkD1epoNjkvXh2CRpJgufC1DuGYNPidzFlzHIALTSk1MOOdGwTful99jAa1aeUT53AOJ/Qr7bW6lsRgCDxwnXG8sptqbshIEZn2Xbk0GLXhOzdC5DyidlvRWRyIsSDC1dR4FuMjzimpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723373891; c=relaxed/simple;
	bh=QXxs+rBPKrFRmT930Lmc9nK3MhuISIJDJ+3d3lEbmw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rjy5N0yUl9JVk40rhLa8zGXnR6Ztz2wtZ8UtqWsdylpTVN8Mb9bSuZJDsyZ23/HOF8L55GwjGv2mSSNTvCdZh80DyQ1F8SeehDL89avLMH0Ni4vMxv3lI2mvmcF1A6yLzA6J/1FmXhOprAiIVZsZUKYUXPrvREXhUw0Gw34EwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cOJOw2FW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F54C32786;
	Sun, 11 Aug 2024 10:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723373891;
	bh=QXxs+rBPKrFRmT930Lmc9nK3MhuISIJDJ+3d3lEbmw0=;
	h=From:To:Cc:Subject:Date:From;
	b=cOJOw2FWKYGOBth4xTwWCv3yWCc6db3mJzl635eOA3mv8uLZV6ZEexEvi6iKzRxJE
	 bKrd/tuvFf0c92W97A+p6TsZhPpsZ5qyKj2tjMjMVs19MVplmz2Z7m6WsjoAq6ExCT
	 bKNDdM28u5ZwHjAkh+gVWB7aBXukKaqRcCXdkzYQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.104
Date: Sun, 11 Aug 2024 12:58:06 +0200
Message-ID: <2024081106-supper-yelling-eded@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.104 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                              |    2 
 arch/arm64/boot/dts/qcom/ipq8074.dtsi                 |    2 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                 |   36 +---
 arch/arm64/include/asm/jump_label.h                   |    1 
 arch/arm64/kernel/jump_label.c                        |   11 +
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi    |   84 +++++++---
 arch/riscv/mm/fault.c                                 |   17 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c                  |   56 +++----
 drivers/gpu/drm/i915/display/intel_dp_link_training.c |   54 ++++++
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c         |    6 
 drivers/gpu/drm/i915/display/intel_hdcp_regs.h        |    2 
 drivers/gpu/drm/nouveau/nouveau_prime.c               |    3 
 drivers/gpu/drm/udl/Makefile                          |    2 
 drivers/gpu/drm/udl/udl_connector.c                   |  139 ------------------
 drivers/gpu/drm/udl/udl_connector.h                   |   15 -
 drivers/gpu/drm/udl/udl_drv.h                         |   11 +
 drivers/gpu/drm/udl/udl_modeset.c                     |  135 +++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c                 |   17 --
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c               |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c                  |   29 +++
 drivers/hid/amd-sfh-hid/amd_sfh_client.c              |   55 ++-----
 drivers/hid/wacom_wac.c                               |    3 
 drivers/leds/led-triggers.c                           |   32 ++--
 drivers/leds/trigger/ledtrig-timer.c                  |    5 
 drivers/net/ethernet/intel/ice/ice_txrx.c             |    2 
 drivers/net/ethernet/intel/ice/ice_xsk.c              |   19 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c       |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c  |    7 
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c    |    5 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c     |    2 
 drivers/net/ethernet/realtek/r8169_main.c             |    8 -
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c     |    2 
 drivers/net/usb/sr9700.c                              |   11 +
 drivers/platform/chrome/cros_ec_proto.c               |    2 
 fs/btrfs/block-group.c                                |   13 +
 fs/btrfs/extent-tree.c                                |    3 
 fs/btrfs/free-space-cache.c                           |    4 
 fs/btrfs/space-info.c                                 |    2 
 fs/btrfs/space-info.h                                 |    1 
 fs/ext4/extents.c                                     |    5 
 fs/ext4/extents_status.c                              |   14 -
 fs/ext4/extents_status.h                              |    6 
 fs/ext4/inode.c                                       |  115 ++++++++------
 fs/f2fs/segment.c                                     |    4 
 fs/file.c                                             |    1 
 fs/proc/proc_sysctl.c                                 |    8 -
 include/linux/leds.h                                  |   30 +--
 include/linux/sysctl.h                                |    1 
 include/trace/events/btrfs.h                          |    8 +
 include/trace/events/mptcp.h                          |    2 
 init/Kconfig                                          |    1 
 ipc/ipc_sysctl.c                                      |   36 ++++
 ipc/mq_sysctl.c                                       |   35 ++++
 kernel/irq/irqdomain.c                                |    7 
 mm/Kconfig                                            |   11 +
 mm/page_alloc.c                                       |   19 +-
 net/bluetooth/hci_sync.c                              |   21 ++
 net/core/rtnetlink.c                                  |    2 
 net/ipv4/netfilter/iptable_nat.c                      |   18 +-
 net/ipv6/ndisc.c                                      |   34 ++--
 net/ipv6/netfilter/ip6table_nat.c                     |   14 +
 net/iucv/af_iucv.c                                    |    4 
 net/mptcp/options.c                                   |    2 
 net/mptcp/pm_netlink.c                                |   28 ++-
 net/mptcp/protocol.c                                  |   18 +-
 net/mptcp/protocol.h                                  |    1 
 net/mptcp/subflow.c                                   |   17 +-
 net/netfilter/ipset/ip_set_list_set.c                 |    3 
 net/sched/act_ct.c                                    |    4 
 net/sysctl_net.c                                      |    1 
 sound/firewire/amdtp-stream.c                         |   38 +++-
 sound/firewire/amdtp-stream.h                         |    1 
 sound/pci/hda/hda_controller.h                        |    2 
 sound/pci/hda/hda_intel.c                             |   10 +
 sound/pci/hda/patch_conexant.c                        |   54 +-----
 sound/pci/hda/patch_realtek.c                         |    1 
 sound/usb/stream.c                                    |    4 
 tools/testing/selftests/net/mptcp/mptcp_connect.c     |    8 -
 78 files changed, 812 insertions(+), 582 deletions(-)

Al Viro (1):
      protect the fetch of ->fd[fd] in do_dup2() from mispredictions

Alexander Maltsev (1):
      netfilter: ipset: Add list flush to cancel_gc

Alexandra Winter (1):
      net/iucv: fix use after free in iucv_sock_close()

Alexey Gladkov (2):
      sysctl: allow change system v ipc sysctls inside ipc namespace
      sysctl: allow to change limits for posix messages queues

Alice Ryhl (1):
      rust: SHADOW_CALL_STACK is incompatible with Rust

Andy Chiu (1):
      net: axienet: start napi before enabling Rx/Tx

Baokun Li (1):
      ext4: make ext4_es_insert_extent() return void

Basavaraj Natikar (3):
      HID: amd_sfh: Remove duplicate cleanup
      HID: amd_sfh: Split sensor and HID initialization
      HID: amd_sfh: Move sensor discovery before HID device initialization

Binbin Zhou (1):
      MIPS: Loongson64: DTS: Add RTC support to Loongson-2K1000

Dan Carpenter (1):
      net: mvpp2: Don't re-use loop iterator

Danilo Krummrich (1):
      drm/nouveau: prime: fix refcount underflow

Dmitry Baryshkov (1):
      arm64: dts: qcom: msm8998: switch USB QMP PHY to new style of bindings

Edmund Raile (2):
      Revert "ALSA: firewire-lib: obsolete workqueue for period update"
      Revert "ALSA: firewire-lib: operate for period elapse event in process context"

Eric Dumazet (1):
      sched: act_ct: take care of padding in struct zones_ht_key

Greg Kroah-Hartman (1):
      Linux 6.1.104

Hans de Goede (1):
      leds: trigger: Call synchronize_rcu() before calling trig->activate()

Heiner Kallweit (3):
      leds: trigger: Remove unused function led_trigger_rename_static()
      leds: trigger: Store brightness set by led_trigger_event()
      r8169: don't increment tx_dropped in case of NETDEV_TX_BUSY

Herve Codina (1):
      irqdomain: Fixed unbalanced fwnode get and put

Huang Ying (1):
      mm: restrict the pcp batch scale factor to avoid too long latency

Ian Forbes (2):
      drm/vmwgfx: Fix overlay when using Screen Targets
      drm/vmwgfx: Trigger a modeset when the screen moves

Imre Deak (1):
      drm/i915/dp: Don't switch the LTTPR mode on an active link

Jaegeuk Kim (1):
      f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr is valid

Javier Carrasco (1):
      cpufreq: qcom-nvmem: fix memory leaks in probe error paths

Jiaxun Yang (3):
      MIPS: Loongson64: DTS: Fix PCIe port nodes for ls7a
      MIPS: dts: loongson: Fix liointc IRQ polarity
      MIPS: dts: loongson: Fix ls2k1000-rtc interrupt

Krishna Kurapati (2):
      arm64: dts: qcom: msm8998: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: ipq8074: Disable SS instance in Parkmode for USB

Kuniyuki Iwashima (3):
      rtnetlink: Don't ignore IFLA_TARGET_NETNSID when ifname is specified in rtnl_dellink().
      netfilter: iptables: Fix null-ptr-deref in iptable_nat_table_init().
      netfilter: iptables: Fix potential null-ptr-deref in ip6table_nat_table_init().

Li Zhijian (1):
      mm/page_alloc: fix pcp->count race between drain_pages_zone() vs __rmqueue_pcplist()

Liu Jing (1):
      selftests: mptcp: always close input's FD if opened

Lucas Stach (1):
      mm: page_alloc: control latency caused by zone PCP draining

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix suspending with wrong filter policy

Ma Ke (1):
      net: usb: sr9700: fix uninitialized variable use in sr_mdio_read

Maciej Fijalkowski (3):
      ice: don't busy wait for Rx queue disable in ice_qp_dis()
      ice: replace synchronize_rcu with synchronize_net
      ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog

Maciej Żenczykowski (1):
      ipv6: fix ndisc_is_useropt() handling for PIO

Mark Bloch (1):
      net/mlx5: Lag, don't use the hardcoded value of the first port

Matthieu Baerts (NGI0) (3):
      mptcp: sched: check both directions for backup
      mptcp: distinguish rcv vs sent backup flag in requests
      mptcp: pm: only set request_bkup flag when sending MP_PRIO

Mavroudis Chatzilazaridis (1):
      ALSA: hda/realtek: Add quirk for Acer Aspire E5-574G

Michal Kubiak (1):
      ice: respect netif readiness in AF_XDP ZC related ndo's

Moshe Shemesh (1):
      net/mlx5: Fix missing lock on sync reset reload

Naohiro Aota (1):
      btrfs: zoned: fix zone_unusable accounting on making block group read-write again

Nikita Zhandarovich (1):
      drm/i915: Fix possible int overflow in skl_ddi_calculate_wrpll()

Paolo Abeni (4):
      mptcp: fix user-space PM announced address accounting
      mptcp: fix NL PM announced address accounting
      mptcp: fix bad RCVPRUNED mib accounting
      mptcp: fix duplicate data handling

Patryk Duda (1):
      platform/chrome: cros_ec_proto: Lock device when updating MKBP version

Shahar Shitrit (1):
      net/mlx5e: Add a check for the return value from mlx5_port_set_eth_ptys

Stephan Gerhold (1):
      cpufreq: qcom-nvmem: Simplify driver data allocation

Suraj Kandpal (1):
      drm/i915/hdcp: Fix HDCP2_STREAM_STATUS macro

Takashi Iwai (2):
      ALSA: hda: Conditionally use snooping for AMD HDMI
      ALSA: usb-audio: Correct surround channels in UAC1 channel map

Tatsunosuke Tobita (1):
      HID: wacom: Modify pen IDs

Thomas Weißschuh (3):
      sysctl: treewide: drop unused argument ctl_table_root::set_ownership(table)
      sysctl: always initialize i_uid/i_gid
      leds: triggers: Flush pending brightness before activating trigger

Thomas Zimmermann (6):
      drm/udl: Rename struct udl_drm_connector to struct udl_connector
      drm/udl: Test pixel limit in mode-config's mode-valid function
      drm/udl: Use USB timeout constant when reading EDID
      drm/udl: Various improvements to the connector
      drm/udl: Move connector to modesetting code
      drm/udl: Remove DRM_CONNECTOR_POLL_HPD

Will Deacon (1):
      arm64: jump_label: Ensure patched jump_labels are visible to all CPUs

Yangtao Li (1):
      cpufreq: qcom-nvmem: Convert to platform remove callback returning void

Zack Rusin (1):
      drm/vmwgfx: Fix a deadlock in dma buf fence polling

Zhang Yi (4):
      ext4: refactor ext4_da_map_blocks()
      ext4: convert to exclusive lock while inserting delalloc extents
      ext4: factor out a common helper to query extent map
      ext4: check the extent status again before inserting delalloc block

Zhe Qiao (1):
      riscv/mm: Add handling for VM_FAULT_SIGSEGV in mm_fault_error()

Zhiguo Niu (1):
      f2fs: fix to avoid use SSR allocate when do defragment

songxiebing (1):
      ALSA: hda: conexant: Fix headset auto detect fail in the polling mode


