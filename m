Return-Path: <stable+bounces-183051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DFFBB40A7
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D73A7B4317
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A7E3115B1;
	Thu,  2 Oct 2025 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d/4UlcAC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE37F31281F;
	Thu,  2 Oct 2025 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411836; cv=none; b=CPlEV8R1CsH7Q/vnFgwju9mbjiP5WT6gVZlkVH/X2JXx+mK72sBQj0TLFIn8F6F3bc0DQNYf2aAUoIV9uJgnFtp4KCrdKxu9n3ExlP5xYjPfDSRd9wu6sQMOWjfGdM1DlGY2yTUBM3lbj43NWblxpIYl82SWWlDNZZWg7U4QVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411836; c=relaxed/simple;
	bh=iGZmuSwI7mRAUtLMjhPzzggzVs/lhK0bgUzhuioqrMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JL/Iicp9k3jNSSMVq/R1ozy0SmUPeP67XL301eglg3sZKYFBcguIw9rUk8GaPXiP5bNpWSc1XXtgLbeGrMOHRadS0n8bJgFE4PjiPM1qScJ4MUDb9Td6Sq8vdzRW33VjgDc5UUylODgO57vGTDKttnXmRT11LAmH0A/rKt4yP1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d/4UlcAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CFAC4CEF4;
	Thu,  2 Oct 2025 13:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759411835;
	bh=iGZmuSwI7mRAUtLMjhPzzggzVs/lhK0bgUzhuioqrMM=;
	h=From:To:Cc:Subject:Date:From;
	b=d/4UlcACXX+VZUfkM3FZHNFJH3DtjtrR/HlRySWRWEJYJjCJ2kWm4zFGqOt+BCrTl
	 /7/NxQoP6yKSqNsXxLIdNg5HXFTUJK6gukVHgKF7c0DPqIzns6+RMtKaFkonhxkRLL
	 ow+kuTHx08cpGW+/GvHZyjcIYWw97acrVixM47KQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.155
Date: Thu,  2 Oct 2025 15:30:26 +0200
Message-ID: <2025100226-custody-custody-a8f7@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.155 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                              |    2 
 arch/arm/mm/pageattr.c                                                |    6 
 arch/arm64/boot/dts/freescale/imx8mp.dtsi                             |    4 
 arch/s390/kernel/perf_cpum_cf.c                                       |    4 
 arch/um/drivers/mconsole_user.c                                       |    2 
 arch/x86/mm/pgtable.c                                                 |    2 
 drivers/cpufreq/cpufreq.c                                             |   20 
 drivers/edac/sb_edac.c                                                |    4 
 drivers/edac/skx_common.h                                             |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                                   |    2 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c                   |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h                    |   14 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c               |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                  |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                  |    3 
 drivers/gpu/drm/arm/display/include/malidp_utils.h                    |    2 
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c            |   24 
 drivers/gpu/drm/ast/ast_dp.c                                          |    2 
 drivers/gpu/drm/drm_color_mgmt.c                                      |    2 
 drivers/gpu/drm/gma500/oaktrail_hdmi.c                                |    2 
 drivers/gpu/drm/i915/display/intel_backlight.c                        |    5 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                 |    6 
 drivers/gpu/drm/radeon/evergreen_cs.c                                 |    2 
 drivers/hwmon/adt7475.c                                               |   24 
 drivers/infiniband/hw/mlx5/devx.c                                     |    1 
 drivers/md/dm-integrity.c                                             |    2 
 drivers/media/dvb-frontends/stv0367_priv.h                            |    3 
 drivers/net/can/rcar/rcar_can.c                                       |    8 
 drivers/net/can/spi/hi311x.c                                          |    1 
 drivers/net/can/sun4i_can.c                                           |    1 
 drivers/net/can/usb/etas_es58x/es581_4.c                              |    4 
 drivers/net/can/usb/etas_es58x/es58x_core.c                           |    7 
 drivers/net/can/usb/etas_es58x/es58x_core.h                           |    8 
 drivers/net/can/usb/etas_es58x/es58x_fd.c                             |    4 
 drivers/net/can/usb/mcba_usb.c                                        |    1 
 drivers/net/can/usb/peak_usb/pcan_usb_core.c                          |    2 
 drivers/net/dsa/lantiq_gswip.c                                        |   37 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c                          |    2 
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c                       |   18 
 drivers/net/ethernet/intel/i40e/i40e.h                                |    4 
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                        |   25 
 drivers/net/ethernet/intel/i40e/i40e_main.c                           |   26 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                    |  110 ++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h                    |    3 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                       |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c                  |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                     |    2 
 drivers/net/fjes/fjes_main.c                                          |    4 
 drivers/nfc/pn544/i2c.c                                               |    2 
 drivers/platform/x86/sony-laptop.c                                    |    1 
 drivers/scsi/isci/init.c                                              |    6 
 drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h |    5 
 drivers/usb/core/quirks.c                                             |    2 
 drivers/video/fbdev/core/fbcon.c                                      |   13 
 drivers/virt/acrn/ioreq.c                                             |    4 
 fs/afs/server.c                                                       |    3 
 fs/btrfs/misc.h                                                       |    2 
 fs/ext2/balloc.c                                                      |    2 
 fs/ext4/ext4.h                                                        |    2 
 fs/hugetlbfs/inode.c                                                  |   10 
 fs/smb/server/transport_rdma.c                                        |   18 
 fs/ufs/util.h                                                         |    6 
 include/crypto/if_alg.h                                               |    2 
 include/linux/minmax.h                                                |  122 +++-
 include/linux/mm.h                                                    |   54 +
 include/linux/pageblock-flags.h                                       |    2 
 include/linux/swap.h                                                  |   10 
 include/net/bluetooth/hci_core.h                                      |   21 
 kernel/bpf/verifier.c                                                 |    4 
 kernel/futex/requeue.c                                                |    6 
 kernel/trace/preemptirq_delay_test.c                                  |    2 
 kernel/trace/trace_dynevent.c                                         |    4 
 lib/btree.c                                                           |    1 
 lib/decompress_unlzma.c                                               |    2 
 lib/logic_pio.c                                                       |    3 
 mm/gup.c                                                              |   28 
 mm/kmsan/core.c                                                       |   10 
 mm/kmsan/kmsan_test.c                                                 |   16 
 mm/migrate_device.c                                                   |   42 -
 mm/mlock.c                                                            |    2 
 mm/swap.c                                                             |    4 
 mm/zsmalloc.c                                                         |    1 
 net/bluetooth/hci_event.c                                             |   26 
 net/bluetooth/hci_sync.c                                              |    7 
 net/ipv4/nexthop.c                                                    |    7 
 net/ipv4/proc.c                                                       |    2 
 net/ipv6/proc.c                                                       |    2 
 net/netfilter/nf_nat_core.c                                           |    6 
 net/tipc/core.h                                                       |    2 
 net/tipc/link.c                                                       |   10 
 sound/usb/mixer_quirks.c                                              |  295 +++++++++-
 sound/usb/quirks.c                                                    |   24 
 sound/usb/usbaudio.h                                                  |    4 
 tools/testing/selftests/bpf/progs/get_branch_snapshot.c               |    4 
 tools/testing/selftests/net/fib_nexthops.sh                           |   12 
 tools/testing/selftests/seccomp/seccomp_bpf.c                         |    2 
 tools/testing/selftests/vm/mremap_test.c                              |    2 
 97 files changed, 910 insertions(+), 325 deletions(-)

Alok Tiwari (1):
      bnxt_en: correct offset handling for IPv6 destination address

Andy Shevchenko (1):
      minmax: deduplicate __unconst_integer_typeof()

Chen Ni (1):
      ALSA: usb-audio: Convert comma to semicolon

Christian Loehle (1):
      cpufreq: Initialize cpufreq-based invariance before subsys

Cristian Ciocaltea (6):
      ALSA: usb-audio: Fix block comments in mixer_quirks
      ALSA: usb-audio: Drop unnecessary parentheses in mixer_quirks
      ALSA: usb-audio: Avoid multiple assignments in mixer_quirks
      ALSA: usb-audio: Simplify NULL comparison in mixer_quirks
      ALSA: usb-audio: Remove unneeded wmb() in mixer_quirks
      ALSA: usb-audio: Add mixer quirk for Sony DualSense PS5

Cryolitia PukNgae (1):
      ALSA: usb-audio: move mixer_quirks' min_mute into common quirk

Dan Carpenter (1):
      octeontx2-pf: Fix potential use after free in otx2_tc_add_flow()

David Hildenbrand (2):
      mm/gup: revert "mm: gup: fix infinite loop within __get_longterm_locked"
      mm/migrate_device: don't add folio to be freed to LRU in migrate_device_finalize()

David Laight (1):
      minmax: fix indentation of __cmp_once() and __clamp_once()

Eric Biggers (2):
      crypto: af_alg - Fix incorrect boolean values in af_alg_ctx
      kmsan: fix out-of-bounds access to shadow memory

Geert Uytterhoeven (1):
      can: rcar_can: rcar_can_resume(): fix s2ram with PSCI

Greg Kroah-Hartman (1):
      Linux 6.1.155

Guenter Roeck (1):
      drm/i915/backlight: Return immediately when scale() finds invalid parameters

Herve Codina (1):
      minmax: Introduce {min,max}_array()

Hugh Dickins (3):
      mm/gup: check ref_count instead of lru before migration
      mm/gup: local lru_add_drain() to avoid lru_add_drain_all()
      mm: folio_may_be_lru_cached() unless folio_test_large()

Ido Schimmel (2):
      nexthop: Forbid FDB status change while nexthop is in a group
      selftests: fib_nexthops: Fix creation of non-FDB nexthops

Jiayi Li (1):
      usb: core: Add 0x prefix to quirks debug output

Jinjiang Tu (1):
      mm/hugetlb: fix folio is still mapped when deleted

Justin Bronder (1):
      i40e: increase max descriptors for XL710

Kefeng Wang (1):
      mm: migrate_device: use more folio in migrate_device_finalize()

Leon Hwang (1):
      bpf: Reject bpf_timer for PREEMPT_RT

Linus Torvalds (4):
      minmax: avoid overly complicated constant expressions in VM code
      minmax: make generic MIN() and MAX() macros available everywhere
      minmax: add a few more MIN_T/MAX_T users
      minmax: simplify and clarify min_t()/max_t() implementation

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix hci_resume_advertising_sync
      Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync

Lukasz Czapnik (8):
      i40e: fix idx validation in i40e_validate_queue_map
      i40e: fix input validation logic for action_meta
      i40e: add max boundary check for VF filters
      i40e: add mask to apply valid bits for itr_idx
      i40e: improve VF MAC filters accounting
      i40e: fix validation of VF state in get resources
      i40e: fix idx validation in config queues msg
      i40e: add validation for ring_len param

Martin Schiller (1):
      net: dsa: lantiq_gswip: do also enable or disable cpu port

Masami Hiramatsu (Google) (1):
      tracing: dynevent: Add a missing lockdown check on dynevent

Matthew Wilcox (Oracle) (1):
      minmax: add in_range() macro

Nathan Chancellor (1):
      s390/cpum_cf: Fix uninitialized warning after backport of ce971233242b

Nirmoy Das (1):
      drm/ast: Use msleep instead of mdelay for edid read

Or Har-Toov (1):
      IB/mlx5: Fix obj_type mismatch for SRQ event subscriptions

Peng Fan (1):
      arm64: dts: imx8mp: Correct thermal sensor index

Petr Malat (1):
      ethernet: rvu-af: Remove slash from the driver name

Samasth Norway Ananda (1):
      fbcon: fix integer overflow in fbcon_do_set_font

Sebastian Andrzej Siewior (1):
      futex: Prevent use-after-free during requeue-PI

Shivank Garg (1):
      mm: add folio_expected_ref_count() for reference count calculation

Stefan Metzmacher (1):
      smb: server: don't use delayed_work for post_recv_credits_work

Stéphane Grosjean (1):
      can: peak_usb: fix shift-out-of-bounds issue

Takashi Iwai (1):
      ALSA: usb-audio: Fix build with CONFIG_INPUT=n

Thomas Zimmermann (1):
      fbcon: Fix OOB access in font allocation

Vincent Mailhol (5):
      can: etas_es58x: sort the includes by alphabetic order
      can: etas_es58x: populate ndo_change_mtu() to prevent buffer overflow
      can: hi311x: populate ndo_change_mtu() to prevent buffer overflow
      can: sun4i_can: populate ndo_change_mtu() to prevent buffer overflow
      can: mcba_usb: populate ndo_change_mtu() to prevent buffer overflow

Vladimir Oltean (2):
      net: dsa: lantiq_gswip: move gswip_add_single_port_br() call to port_setup()
      net: dsa: lantiq_gswip: suppress -EINVAL errors for bridge FDB entries added to the CPU port

Zabelin Nikita (1):
      drm/gma500: Fix null dereference in hdmi teardown

Zhen Ni (1):
      afs: Fix potential null pointer dereference in afs_put_server

noble.yang (1):
      ALSA: usb-audio: Add DSD support for Comtrue USB Audio device

qaqland (1):
      ALSA: usb-audio: Add mute TLV for playback volumes on more devices


