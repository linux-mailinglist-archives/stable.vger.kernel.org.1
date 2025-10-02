Return-Path: <stable+bounces-183055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962E0BB40D2
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1218F188F853
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA88313D73;
	Thu,  2 Oct 2025 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="llkuDytl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B633126C4;
	Thu,  2 Oct 2025 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411851; cv=none; b=Dx19JjLlBtaUZQ1rtbBn41f4GfzMA9HT2zOEcHsQjA+WZ8XOu5jfNaQ7BP9p0K2Mo/8Xvi2grqp/PcGVrNZ5DaKaKvVkaw1hrmhtdzmrR6jLYDCZLvx31+UOw2I/DUUUbZcu58yFHg74MVsvxBRZaO7D7agY+/6RU3SaPSbatlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411851; c=relaxed/simple;
	bh=J9HZfZj5CQ6JAOXrb5oMJJgYsEQwfHG5iNHiwz829OE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GnjeynjyRcsdyay6175DcNdoxXu4n/xoimigzbgsTZhZVCUy/e+j2ei4FpXwzXA8NCzuZmljMt76zem7oiAH7G8kazhbcT9pnnTKH3qiL2awCrVfQedkU3B7mP+6+yaqCne72OeyHG+pIWFkyWo3FR14Hpn0KqhkLRE60d851Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=llkuDytl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECA7C4CEFA;
	Thu,  2 Oct 2025 13:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759411851;
	bh=J9HZfZj5CQ6JAOXrb5oMJJgYsEQwfHG5iNHiwz829OE=;
	h=From:To:Cc:Subject:Date:From;
	b=llkuDytlaT7k4P2mk/MSfNj6R5RTpLQcSb+vfYDwl6GCohL9U9IvYmUCGpu6Io1ON
	 /sWoJL4MEEiEqXy2Ga+CzJqoiUnkSd+qFC1OMFhzSGVPgOJ9wgvr6qH/rR6StMyDSq
	 Ynlm8uaW7e7I3JhAL/skJH+NeU6QRoowqzAf6tDI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.50
Date: Thu,  2 Oct 2025 15:30:38 +0200
Message-ID: <2025100239-remote-sabotage-da09@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.50 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/laptops/lg-laptop.rst            |    4 
 Makefile                                                   |    2 
 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts |    6 
 arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts       |    2 
 arch/arm64/boot/dts/freescale/imx8mp.dtsi                  |    4 
 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts            |   16 
 arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi            |    8 
 drivers/cpufreq/cpufreq.c                                  |   20 
 drivers/firewire/core-cdev.c                               |    2 
 drivers/gpio/gpiolib.c                                     |   21 
 drivers/gpu/drm/ast/ast_dp.c                               |    2 
 drivers/gpu/drm/gma500/oaktrail_hdmi.c                     |    2 
 drivers/gpu/drm/i915/display/intel_backlight.c             |    5 
 drivers/gpu/drm/panthor/panthor_sched.c                    |    8 
 drivers/hid/amd-sfh-hid/amd_sfh_client.c                   |   12 
 drivers/hid/amd-sfh-hid/amd_sfh_common.h                   |    3 
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c                     |    4 
 drivers/hid/hid-asus.c                                     |    3 
 drivers/i2c/busses/i2c-designware-platdrv.c                |    7 
 drivers/infiniband/hw/mlx5/devx.c                          |    1 
 drivers/iommu/iommufd/fault.c                              |    4 
 drivers/iommu/iommufd/main.c                               |   34 
 drivers/mmc/host/sdhci-cadence.c                           |   11 
 drivers/net/can/rcar/rcar_can.c                            |    8 
 drivers/net/can/spi/hi311x.c                               |    1 
 drivers/net/can/sun4i_can.c                                |    1 
 drivers/net/can/usb/etas_es58x/es58x_core.c                |    3 
 drivers/net/can/usb/mcba_usb.c                             |    1 
 drivers/net/can/usb/peak_usb/pcan_usb_core.c               |    2 
 drivers/net/dsa/lantiq_gswip.c                             |   21 
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c               |    2 
 drivers/net/ethernet/freescale/fec_main.c                  |    4 
 drivers/net/ethernet/intel/i40e/i40e.h                     |    3 
 drivers/net/ethernet/intel/i40e/i40e_main.c                |   26 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c         |  110 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h         |    3 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c            |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c       |    2 
 drivers/net/phy/sfp.c                                      |   24 
 drivers/net/tun.c                                          |    3 
 drivers/net/wireless/virtual/virt_wifi.c                   |    4 
 drivers/platform/x86/lg-laptop.c                           |   34 
 drivers/ufs/core/ufs-mcq.c                                 |    4 
 drivers/usb/core/quirks.c                                  |    2 
 drivers/usb/host/xhci-dbgcap.c                             |    2 
 drivers/usb/host/xhci-mem.c                                |   50 -
 drivers/usb/host/xhci.c                                    |    2 
 drivers/usb/host/xhci.h                                    |    6 
 drivers/video/fbdev/core/fbcon.c                           |   13 
 fs/afs/server.c                                            |    3 
 fs/btrfs/volumes.c                                         |    5 
 fs/hugetlbfs/inode.c                                       |   10 
 fs/proc/task_mmu.c                                         |    3 
 fs/smb/client/smb2inode.c                                  |    2 
 fs/smb/server/transport_rdma.c                             |   22 
 include/crypto/if_alg.h                                    |    2 
 include/linux/firmware/imx/sm.h                            |   12 
 include/linux/swap.h                                       |   10 
 include/net/bluetooth/hci_core.h                           |   21 
 kernel/bpf/core.c                                          |    5 
 kernel/bpf/verifier.c                                      |    6 
 kernel/futex/requeue.c                                     |    6 
 kernel/trace/trace_dynevent.c                              |    4 
 kernel/vhost_task.c                                        |    3 
 mm/gup.c                                                   |   15 
 mm/kmsan/core.c                                            |   10 
 mm/kmsan/kmsan_test.c                                      |   16 
 mm/mlock.c                                                 |    6 
 mm/swap.c                                                  |   51 -
 net/bluetooth/hci_event.c                                  |   26 
 net/bluetooth/hci_sync.c                                   |    7 
 net/core/skbuff.c                                          |    2 
 net/ipv4/nexthop.c                                         |    7 
 net/smc/smc_loopback.c                                     |   14 
 net/xfrm/xfrm_state.c                                      |    3 
 sound/pci/hda/patch_realtek.c                              |   11 
 sound/usb/mixer_quirks.c                                   |  545 +++++++++----
 sound/usb/quirks.c                                         |   24 
 sound/usb/usbaudio.h                                       |    4 
 tools/testing/selftests/net/fib_nexthops.sh                |   12 
 80 files changed, 999 insertions(+), 383 deletions(-)

Adrián Larumbe (1):
      drm/panthor: Defer scheduler entitiy destruction to queue release

Aleksander Jan Bajkowski (1):
      net: sfp: add quirk for FLYPRO copper SFP+ module

Alok Tiwari (2):
      scsi: ufs: mcq: Fix memory allocation checks for SQE and CQE
      bnxt_en: correct offset handling for IPv6 destination address

Amit Chaudhari (1):
      HID: asus: add support for missing PX series fn keys

Basavaraj Natikar (1):
      HID: amd_sfh: Add sync across amd sfh work functions

Benoît Monin (1):
      mmc: sdhci-cadence: add Mobileye eyeQ support

Chen Ni (1):
      ALSA: usb-audio: Convert comma to semicolon

Chris Morgan (1):
      net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick

Christian Loehle (1):
      cpufreq: Initialize cpufreq-based invariance before subsys

Cristian Ciocaltea (7):
      ALSA: usb-audio: Fix code alignment in mixer_quirks
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

Daniel Lee (1):
      platform/x86: lg-laptop: Fix WMAB call in fan_mode_store()

Eric Biggers (2):
      crypto: af_alg - Fix incorrect boolean values in af_alg_ctx
      kmsan: fix out-of-bounds access to shadow memory

Geert Uytterhoeven (1):
      can: rcar_can: rcar_can_resume(): fix s2ram with PSCI

Greg Kroah-Hartman (1):
      Linux 6.12.50

Guenter Roeck (1):
      drm/i915/backlight: Return immediately when scale() finds invalid parameters

Hans de Goede (1):
      gpiolib: Extend software-node support to support secondary software-nodes

Heikki Krogerus (1):
      i2c: designware: Add quirk for Intel Xe

Hugh Dickins (3):
      mm/gup: local lru_add_drain() to avoid lru_add_drain_all()
      mm: revert "mm/gup: clear the LRU flag of a page before adding to LRU batch"
      mm: folio_may_be_lru_cached() unless folio_test_large()

Ido Schimmel (2):
      nexthop: Forbid FDB status change while nexthop is in a group
      selftests: fib_nexthops: Fix creation of non-FDB nexthops

Jakub Acs (1):
      fs/proc/task_mmu: check p->vec_buf for NULL

James Guan (1):
      wifi: virt_wifi: Fix page fault on connect

Jason Baron (1):
      net: allow alloc_skb_with_frags() to use MAX_SKB_FRAGS

Jason Gunthorpe (1):
      iommufd: Fix race during abort for file descriptors

Jiayi Li (1):
      usb: core: Add 0x prefix to quirks debug output

Jihed Chaibi (1):
      ARM: dts: kirkwood: Fix sound DAI cells for OpenRD clients

Jinjiang Tu (1):
      mm/hugetlb: fix folio is still mapped when deleted

Jiri Olsa (1):
      bpf: Check the helper function is valid in get_helper_proto

Josua Mayer (2):
      arm64: dts: marvell: cn9132-clearfog: disable eMMC high-speed modes
      arm64: dts: marvell: cn9132-clearfog: fix multi-lane pci x2 and x4 ports

Leon Hwang (1):
      bpf: Reject bpf_timer for PREEMPT_RT

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix hci_resume_advertising_sync
      Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync

Lukasz Czapnik (8):
      i40e: add validation for ring_len param
      i40e: fix idx validation in i40e_validate_queue_map
      i40e: fix idx validation in config queues msg
      i40e: fix input validation logic for action_meta
      i40e: fix validation of VF state in get resources
      i40e: add max boundary check for VF filters
      i40e: add mask to apply valid bits for itr_idx
      i40e: improve VF MAC filters accounting

Marc Kleine-Budde (1):
      net: fec: rename struct fec_devinfo fec_imx6x_info -> fec_imx6sx_info

Mark Harmstone (1):
      btrfs: don't allow adding block device of less than 1 MB

Masami Hiramatsu (Google) (1):
      tracing: dynevent: Add a missing lockdown check on dynevent

Niklas Neronin (1):
      Revert "usb: xhci: remove option to change a default ring's TRB cycle bit"

Nirmoy Das (1):
      drm/ast: Use msleep instead of mdelay for edid read

Nobuhiro Iwamatsu (1):
      ARM: dts: socfpga: sodia: Fix mdio bus probe and PHY address

Or Har-Toov (1):
      IB/mlx5: Fix obj_type mismatch for SRQ event subscriptions

Peng Fan (2):
      firmware: imx: Add stub functions for SCMI MISC API
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

Sidraya Jayagond (1):
      net/smc: fix warning in smc_rx_splice() when calling get_page()

Stefan Binding (1):
      ALSA: hda/realtek: Add support for ASUS NUC using CS35L41 HDA

Stefan Metzmacher (2):
      smb: server: don't use delayed_work for post_recv_credits_work
      smb: server: use disable_work_sync in transport_rdma.c

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

Wang Liang (1):
      net: tun: Update napi->skb after XDP process

Zabelin Nikita (1):
      drm/gma500: Fix null dereference in hdmi teardown

Zhen Ni (1):
      afs: Fix potential null pointer dereference in afs_put_server

noble.yang (1):
      ALSA: usb-audio: Add DSD support for Comtrue USB Audio device

qaqland (1):
      ALSA: usb-audio: Add mute TLV for playback volumes on more devices


