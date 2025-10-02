Return-Path: <stable+bounces-183054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A78E3BB40C6
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AD5188A67A
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4488931355A;
	Thu,  2 Oct 2025 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mvNNoygj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADE5312823;
	Thu,  2 Oct 2025 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411848; cv=none; b=E+GsiY7NWQhdV7bNqzsPDyZiRLgxQDreI1+iJHjJyJBGCc7Bxnbiib9WgO/szpzAsWykLxz23QFMGpfOU8SmsnGreACnjVgfkB1p2Aq5AkRj7ieugjPnDkjau4WRt0u6/2OR6G5zyrKKD2R1XGhK1ve9Kpt5/bVm0qeFZ26uJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411848; c=relaxed/simple;
	bh=0nbUliK/YhACs62clB27qs9DyRDH2x1jXEqIN5MQ+bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ImIGGyvO/ViDLx3DQEOXLFmLfUVP8O2xcx0mWY2xPzixYBaZxSlYdYJWiO6Azc6V5wY/II3jrIQoTfzm76/QtK8X6uVYraBoWi1f/E+QLO5N+gjcNkYohYag5iej24CXHSgVKCBx5pe9bW5hP2f0fmrDH4d9COAtLGHSqJYI70A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mvNNoygj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E62DC4CEFB;
	Thu,  2 Oct 2025 13:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759411847;
	bh=0nbUliK/YhACs62clB27qs9DyRDH2x1jXEqIN5MQ+bQ=;
	h=From:To:Cc:Subject:Date:From;
	b=mvNNoygj8dObz1KXY3ux/JY6oGcK/WFuxSyLwaK3l/fQaPGtGKRNhL4vd8Msoii4G
	 p7thYRRIiqCje99roHnHwwl13mGrqAen9l1lDTe+M8EeEhkGhdNcPYxhaSdHPIVQby
	 i1AVBEtI9LrnJSY6MfngUcsE2wtZkHXCFp41hhaw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.109
Date: Thu,  2 Oct 2025 15:30:32 +0200
Message-ID: <2025100233-prowess-expulsion-a8ce@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.109 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                              |    2 
 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts            |    6 
 arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts                  |    2 
 arch/arm/mach-bcm/Kconfig                                             |    1 
 arch/arm64/boot/dts/freescale/imx8mp.dtsi                             |    4 
 arch/s390/kernel/perf_cpum_cf.c                                       |    4 
 arch/um/drivers/mconsole_user.c                                       |    2 
 drivers/block/loop.c                                                  |   40 +
 drivers/cpufreq/cpufreq.c                                             |   20 
 drivers/edac/skx_common.h                                             |    1 
 drivers/firewire/core-cdev.c                                          |    2 
 drivers/gpio/gpiolib.c                                                |   19 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                                   |    2 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c                   |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h                    |   14 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c               |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                  |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                  |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                                |    2 
 drivers/gpu/drm/ast/ast_dp.c                                          |    2 
 drivers/gpu/drm/gma500/oaktrail_hdmi.c                                |    2 
 drivers/gpu/drm/i915/display/intel_backlight.c                        |    5 
 drivers/gpu/drm/radeon/evergreen_cs.c                                 |    2 
 drivers/hid/hid-asus.c                                                |    3 
 drivers/hwmon/adt7475.c                                               |   24 
 drivers/i2c/busses/i2c-designware-platdrv.c                           |    7 
 drivers/infiniband/hw/mlx5/devx.c                                     |    1 
 drivers/input/touchscreen/cyttsp4_core.c                              |    2 
 drivers/irqchip/irq-sun6i-r.c                                         |    2 
 drivers/media/dvb-frontends/stv0367_priv.h                            |    3 
 drivers/mmc/host/sdhci-cadence.c                                      |   11 
 drivers/net/can/rcar/rcar_can.c                                       |    8 
 drivers/net/can/spi/hi311x.c                                          |    1 
 drivers/net/can/sun4i_can.c                                           |    1 
 drivers/net/can/usb/etas_es58x/es58x_core.c                           |    3 
 drivers/net/can/usb/etas_es58x/es58x_devlink.c                        |    2 
 drivers/net/can/usb/mcba_usb.c                                        |    1 
 drivers/net/can/usb/peak_usb/pcan_usb_core.c                          |    2 
 drivers/net/dsa/lantiq_gswip.c                                        |   37 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c                          |    2 
 drivers/net/ethernet/intel/i40e/i40e.h                                |    4 
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                        |   25 
 drivers/net/ethernet/intel/i40e/i40e_main.c                           |   26 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                    |  110 ++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h                    |    3 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                       |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c                  |    2 
 drivers/net/fjes/fjes_main.c                                          |    4 
 drivers/net/wireless/virtual/virt_wifi.c                              |    4 
 drivers/nfc/pn544/i2c.c                                               |    2 
 drivers/platform/x86/sony-laptop.c                                    |    1 
 drivers/scsi/isci/init.c                                              |    6 
 drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h |    5 
 drivers/ufs/core/ufs-mcq.c                                            |    4 
 drivers/usb/core/quirks.c                                             |    2 
 drivers/video/fbdev/core/fbcon.c                                      |   13 
 fs/afs/server.c                                                       |    3 
 fs/btrfs/tree-checker.c                                               |    2 
 fs/hugetlbfs/inode.c                                                  |   10 
 fs/smb/client/smb2inode.c                                             |    2 
 fs/smb/server/transport_rdma.c                                        |   18 
 include/crypto/if_alg.h                                               |    2 
 include/linux/compiler.h                                              |    9 
 include/linux/minmax.h                                                |  220 ++++---
 include/linux/mm.h                                                    |   55 +
 include/linux/swap.h                                                  |   10 
 include/net/bluetooth/hci_core.h                                      |   21 
 kernel/bpf/verifier.c                                                 |    4 
 kernel/futex/requeue.c                                                |    6 
 kernel/trace/preemptirq_delay_test.c                                  |    2 
 kernel/trace/trace_dynevent.c                                         |    4 
 kernel/vhost_task.c                                                   |    3 
 lib/btree.c                                                           |    1 
 lib/decompress_unlzma.c                                               |    2 
 lib/vsprintf.c                                                        |    2 
 mm/gup.c                                                              |   28 
 mm/kmsan/core.c                                                       |   10 
 mm/kmsan/kmsan_test.c                                                 |   16 
 mm/migrate_device.c                                                   |   42 -
 mm/mlock.c                                                            |    6 
 mm/swap.c                                                             |    4 
 mm/zsmalloc.c                                                         |    2 
 net/bluetooth/hci_event.c                                             |   26 
 net/bluetooth/hci_sync.c                                              |    7 
 net/core/skbuff.c                                                     |    2 
 net/ipv4/nexthop.c                                                    |    7 
 net/xfrm/xfrm_state.c                                                 |    3 
 sound/usb/mixer_quirks.c                                              |  295 +++++++++-
 sound/usb/quirks.c                                                    |   24 
 sound/usb/usbaudio.h                                                  |    4 
 tools/testing/selftests/mm/mremap_test.c                              |    2 
 tools/testing/selftests/net/fib_nexthops.sh                           |   12 
 tools/testing/selftests/seccomp/seccomp_bpf.c                         |    2 
 93 files changed, 984 insertions(+), 350 deletions(-)

Alok Tiwari (2):
      scsi: ufs: mcq: Fix memory allocation checks for SQE and CQE
      bnxt_en: correct offset handling for IPv6 destination address

Amit Chaudhari (1):
      HID: asus: add support for missing PX series fn keys

Benoît Monin (1):
      mmc: sdhci-cadence: add Mobileye eyeQ support

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

David Laight (7):
      minmax.h: add whitespace around operators and after commas
      minmax.h: update some comments
      minmax.h: reduce the #define expansion of min(), max() and clamp()
      minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
      minmax.h: move all the clamp() definitions after the min/max() ones
      minmax.h: simplify the variants of clamp()
      minmax.h: remove some #defines that are only expanded once

Eric Biggers (2):
      crypto: af_alg - Fix incorrect boolean values in af_alg_ctx
      kmsan: fix out-of-bounds access to shadow memory

Florian Fainelli (1):
      ARM: bcm: Select ARM_GIC_V3 for ARCH_BRCMSTB

Geert Uytterhoeven (1):
      can: rcar_can: rcar_can_resume(): fix s2ram with PSCI

Greg Kroah-Hartman (1):
      Linux 6.6.109

Guenter Roeck (1):
      drm/i915/backlight: Return immediately when scale() finds invalid parameters

Hans de Goede (1):
      gpiolib: Extend software-node support to support secondary software-nodes

Heikki Krogerus (1):
      i2c: designware: Add quirk for Intel Xe

Hugh Dickins (3):
      mm/gup: check ref_count instead of lru before migration
      mm/gup: local lru_add_drain() to avoid lru_add_drain_all()
      mm: folio_may_be_lru_cached() unless folio_test_large()

Ido Schimmel (2):
      nexthop: Forbid FDB status change while nexthop is in a group
      selftests: fib_nexthops: Fix creation of non-FDB nexthops

James Guan (1):
      wifi: virt_wifi: Fix page fault on connect

Jan Kara (1):
      loop: Avoid updating block size under exclusive owner

Jason Baron (1):
      net: allow alloc_skb_with_frags() to use MAX_SKB_FRAGS

Jiayi Li (1):
      usb: core: Add 0x prefix to quirks debug output

Jihed Chaibi (1):
      ARM: dts: kirkwood: Fix sound DAI cells for OpenRD clients

Jinjiang Tu (1):
      mm/hugetlb: fix folio is still mapped when deleted

Justin Bronder (1):
      i40e: increase max descriptors for XL710

Kefeng Wang (1):
      mm: migrate_device: use more folio in migrate_device_finalize()

Leon Hwang (1):
      bpf: Reject bpf_timer for PREEMPT_RT

Linus Torvalds (5):
      minmax: make generic MIN() and MAX() macros available everywhere
      minmax: simplify min()/max()/clamp() implementation
      minmax: don't use max() in situations that want a C constant expression
      minmax: improve macro expansion and type checking
      minmax: fix up min3() and max3() too

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix hci_resume_advertising_sync
      Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync

Lukasz Czapnik (8):
      i40e: fix idx validation in i40e_validate_queue_map
      i40e: fix idx validation in config queues msg
      i40e: fix input validation logic for action_meta
      i40e: fix validation of VF state in get resources
      i40e: add max boundary check for VF filters
      i40e: add mask to apply valid bits for itr_idx
      i40e: improve VF MAC filters accounting
      i40e: add validation for ring_len param

Martin Schiller (1):
      net: dsa: lantiq_gswip: do also enable or disable cpu port

Masami Hiramatsu (Google) (1):
      tracing: dynevent: Add a missing lockdown check on dynevent

Nathan Chancellor (1):
      s390/cpum_cf: Fix uninitialized warning after backport of ce971233242b

Nirmoy Das (1):
      drm/ast: Use msleep instead of mdelay for edid read

Nobuhiro Iwamatsu (1):
      ARM: dts: socfpga: sodia: Fix mdio bus probe and PHY address

Or Har-Toov (1):
      IB/mlx5: Fix obj_type mismatch for SRQ event subscriptions

Peng Fan (1):
      arm64: dts: imx8mp: Correct thermal sensor index

Petr Malat (1):
      ethernet: rvu-af: Remove slash from the driver name

Sabrina Dubroca (1):
      xfrm: xfrm_alloc_spi shouldn't use 0 as SPI

Samasth Norway Ananda (1):
      fbcon: fix integer overflow in fbcon_do_set_font

Sang-Heon Jeon (1):
      smb: client: fix wrong index reference in smb2_compound_op()

Sebastian Andrzej Siewior (2):
      vhost: Take a reference on the task in struct vhost_task.
      futex: Prevent use-after-free during requeue-PI

Shivank Garg (1):
      mm: add folio_expected_ref_count() for reference count calculation

Stefan Metzmacher (1):
      smb: server: don't use delayed_work for post_recv_credits_work

Stéphane Grosjean (1):
      can: peak_usb: fix shift-out-of-bounds issue

Takashi Iwai (1):
      ALSA: usb-audio: Fix build with CONFIG_INPUT=n

Takashi Sakamoto (1):
      firewire: core: fix overlooked update of subsystem ABI version

Thomas Zimmermann (1):
      fbcon: Fix OOB access in font allocation

Vincent Mailhol (4):
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


