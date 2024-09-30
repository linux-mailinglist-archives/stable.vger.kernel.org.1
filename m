Return-Path: <stable+bounces-78273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F389A98A769
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 16:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713351F222CF
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 14:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839BE1917E9;
	Mon, 30 Sep 2024 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dA6LixbV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310831917C9;
	Mon, 30 Sep 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707300; cv=none; b=CIjG/7ISEWr9rfBz2ZBt7k8SbKmPYqueCnCQzACBevO1xaRx0O3qkZM4VNx5yK55aRmMG3oAp7cwhcEzIswWlmG7maMuZ8C7khTYa0FOWPN8ggA648NlFHdRKACjCc3l6w2UoJcSimCY7nF2E/NFsYJPeT7uH0r1pigwRVBfNbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707300; c=relaxed/simple;
	bh=YkNk3xVUgt8Y25khm9Nl9/Xc10s+SIKyArHRUzaueDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ae16QI32P0BNkq3/pwe/pZ0FLmFTrXrZTIkt7EicyzfmivyoanFhSq8LBfZsOtGKuGVkrQXZQFEQrI/ibBqwP2vF9Nh0DNLoNO0cpSr9wEdSYiQeJADLw1hWfvaCneBMKvENx+kVYrU5obeVig08GdsGTZlbSlcRVuyO7xibJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dA6LixbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433EAC4CEC7;
	Mon, 30 Sep 2024 14:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727707299;
	bh=YkNk3xVUgt8Y25khm9Nl9/Xc10s+SIKyArHRUzaueDA=;
	h=From:To:Cc:Subject:Date:From;
	b=dA6LixbVfotQnV221KGCjvM4803yuXfmjArpbRkyogAE34HJPPzWHDGQcIOxNYbA3
	 ksKwnPp41ZNMPB4+XLhYG896LBsavu1Eu+Wm6szVY06vX0sKz1iqz3284LRiqcBA+2
	 J2w+9H3zG6ZzrumBNgy0odoZRuGIubdaQrgbyPAY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.112
Date: Mon, 30 Sep 2024 16:41:33 +0200
Message-ID: <2024093032-durable-dandelion-9d0a@gregkh>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.112 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                 |    2 
 arch/loongarch/include/asm/hw_irq.h                      |    2 
 arch/loongarch/kernel/irq.c                              |    3 
 arch/microblaze/mm/init.c                                |    5 
 arch/x86/kernel/cpu/mshyperv.c                           |    1 
 arch/x86/mm/init.c                                       |   16 
 block/blk-core.c                                         |   10 
 block/blk-mq.c                                           |   10 
 drivers/gpio/gpiolib-cdev.c                              |   12 
 drivers/gpio/gpiolib.c                                   |    3 
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c          |   10 
 drivers/hwmon/asus-ec-sensors.c                          |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c           |   42 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c           |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c         |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c           |   14 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c            |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c      |    7 
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h                |    1 
 drivers/net/ethernet/faraday/ftgmac100.c                 |   26 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c              |    2 
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h           |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c        |    9 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c             |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c            |   23 -
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c |    3 
 drivers/pinctrl/pinctrl-at91.c                           |    5 
 drivers/powercap/intel_rapl_msr.c                        |   12 
 drivers/scsi/lpfc/lpfc_bsg.c                             |    2 
 drivers/spi/spi-bcm63xx.c                                |    1 
 drivers/spi/spidev.c                                     |    2 
 drivers/usb/class/usbtmc.c                               |    2 
 drivers/usb/serial/pl2303.c                              |    1 
 drivers/usb/serial/pl2303.h                              |    4 
 fs/btrfs/block-rsv.c                                     |   14 
 fs/btrfs/block-rsv.h                                     |   12 
 fs/btrfs/delayed-ref.h                                   |   21 +
 fs/ocfs2/xattr.c                                         |   27 +
 fs/smb/client/connect.c                                  |   14 
 fs/xfs/libxfs/xfs_ag.c                                   |   19 -
 fs/xfs/libxfs/xfs_alloc.c                                |   69 +++
 fs/xfs/libxfs/xfs_bmap.c                                 |   16 
 fs/xfs/libxfs/xfs_bmap.h                                 |    2 
 fs/xfs/libxfs/xfs_bmap_btree.c                           |   19 -
 fs/xfs/libxfs/xfs_btree.c                                |   18 -
 fs/xfs/libxfs/xfs_fs.h                                   |    2 
 fs/xfs/libxfs/xfs_ialloc.c                               |   17 
 fs/xfs/libxfs/xfs_log_format.h                           |    9 
 fs/xfs/libxfs/xfs_sb.c                                   |   56 +++
 fs/xfs/libxfs/xfs_trans_inode.c                          |  113 ------
 fs/xfs/xfs_attr_inactive.c                               |    1 
 fs/xfs/xfs_bmap_util.c                                   |   18 -
 fs/xfs/xfs_buf_item.c                                    |   88 +++--
 fs/xfs/xfs_dquot.c                                       |    1 
 fs/xfs/xfs_export.c                                      |   14 
 fs/xfs/xfs_extent_busy.c                                 |    1 
 fs/xfs/xfs_fsmap.c                                       |    1 
 fs/xfs/xfs_fsops.c                                       |   13 
 fs/xfs/xfs_icache.c                                      |   58 ++-
 fs/xfs/xfs_icache.h                                      |    4 
 fs/xfs/xfs_inode.c                                       |  260 +++++++++++++--
 fs/xfs/xfs_inode.h                                       |   36 +-
 fs/xfs/xfs_inode_item.c                                  |  149 ++++++++
 fs/xfs/xfs_inode_item.h                                  |    1 
 fs/xfs/xfs_itable.c                                      |   11 
 fs/xfs/xfs_log.c                                         |   47 --
 fs/xfs/xfs_log_recover.c                                 |   19 -
 fs/xfs/xfs_mount.h                                       |   11 
 fs/xfs/xfs_notify_failure.c                              |   15 
 fs/xfs/xfs_qm.c                                          |   72 +++-
 fs/xfs/xfs_super.c                                       |    1 
 fs/xfs/xfs_trace.h                                       |   46 ++
 fs/xfs/xfs_trans.c                                       |    9 
 include/net/netfilter/nf_tables.h                        |   13 
 net/mac80211/tx.c                                        |    4 
 net/netfilter/nf_tables_api.c                            |    5 
 net/netfilter/nft_lookup.c                               |    1 
 net/netfilter/nft_set_pipapo.c                           |    6 
 net/netfilter/nft_socket.c                               |   41 ++
 net/wireless/core.h                                      |    8 
 sound/pci/hda/patch_realtek.c                            |   76 ++--
 sound/soc/amd/acp/acp-sof-mach.c                         |    2 
 sound/soc/au1x/db1200.c                                  |    1 
 sound/soc/codecs/tda7419.c                               |    1 
 sound/soc/intel/common/soc-acpi-intel-cht-match.c        |    1 
 sound/soc/intel/keembay/kmb_platform.c                   |    1 
 sound/soc/sof/mediatek/mt8195/mt8195.c                   |    3 
 tools/hv/Makefile                                        |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh          |    4 
 89 files changed, 1254 insertions(+), 461 deletions(-)

Albert Jakieła (1):
      ASoC: SOF: mediatek: Add missing board compatible

Benjamin Berg (1):
      wifi: iwlwifi: lower message level for FW buffer destination

Dan Carpenter (1):
      netfilter: nft_socket: Fix a NULL vs IS_ERR() bug in nft_socket_cgroup_subtree_level()

Daniel Gabay (1):
      wifi: iwlwifi: mvm: fix iwl_mvm_scan_fits() calculation

Darrick J. Wong (8):
      xfs: fix uninitialized variable access
      xfs: load uncached unlinked inodes into memory on demand
      xfs: fix negative array access in xfs_getbmap
      xfs: use i_prev_unlinked to distinguish inodes that are not on the unlinked list
      xfs: reload entire unlinked bucket lists
      xfs: make inode unlinked bucket recovery work with quotacheck
      xfs: fix reloading entire unlinked bucket lists
      xfs: set bnobt/cntbt numrecs correctly when formatting new AGs

Dave Chinner (13):
      xfs: dquot shrinker doesn't check for XFS_DQFLAG_FREEING
      xfs: don't use BMBT btree split workers for IO completion
      xfs: fix low space alloc deadlock
      xfs: prefer free inodes at ENOSPC over chunk allocation
      xfs: block reservation too large for minleft allocation
      xfs: quotacheck failure can race with background inode inactivation
      xfs: buffer pins need to hold a buffer reference
      xfs: defered work could create precommits
      xfs: fix AGF vs inode cluster buffer deadlock
      xfs: collect errors from inodegc for unlinked inode recovery
      xfs: remove WARN when dquot cache insertion fails
      xfs: fix unlink vs cluster buffer instantiation race
      xfs: journal geometry is not properly bounds checked

Dmitry Antipov (1):
      wifi: mac80211: free skb on error path in ieee80211_beacon_get_ap()

Edward Adam Davis (1):
      USB: usbtmc: prevent kernel-usb-infoleak

Emmanuel Grumbach (3):
      wifi: iwlwifi: mvm: pause TCM when the firmware is stopped
      wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead
      wifi: iwlwifi: clear trans->state earlier upon error

Fabio Estevam (1):
      spi: spidev: Add an entry for elgin,jg10309-01

Ferry Meng (2):
      ocfs2: add bounds checking to ocfs2_xattr_find_entry()
      ocfs2: strict bound check before memcmp in ocfs2_xattr_find_entry()

Filipe Manana (1):
      btrfs: calculate the right space for delayed refs when updating global reserve

Florian Westphal (1):
      netfilter: nft_socket: make cgroupsv2 matching work with namespaces

Geert Uytterhoeven (1):
      spi: spidev: Add missing spi_device_id for jg10309-01

Greg Kroah-Hartman (1):
      Linux 6.1.112

Hagar Hemdan (1):
      gpio: prevent potential speculation leaks in gpio_device_get_desc()

Hans de Goede (1):
      ASoC: Intel: soc-acpi-cht: Make Lenovo Yoga Tab 3 X90F DMI match less strict

Hongbo Li (2):
      ASoC: allow module autoloading for table db1200_pids
      ASoC: allow module autoloading for table board_ids

Hongyu Jin (1):
      block: Fix where bio IO priority gets set

Huacai Chen (1):
      LoongArch: Define ARCH_IRQ_INIT_FLAGS as IRQ_NOPROBE

Jacky Chou (1):
      net: ftgmac100: Ensure tx descriptor updates are visible

Junhao Xie (1):
      USB: serial: pl2303: add device id for Macrosilicon MS3020

Kailang Yang (2):
      ALSA: hda/realtek - Fixed ALC256 headphone no sound
      ALSA: hda/realtek - FIxed ALC285 headphone no sound

Kent Gibson (1):
      gpiolib: cdev: Ignore reconfiguration without direction

Liao Chen (3):
      ASoC: intel: fix module autoloading
      ASoC: tda7419: fix module autoloading
      spi: bcm63xx: Enable module autoloading

Long Li (1):
      xfs: fix ag count overflow during growfs

Marc Kleine-Budde (3):
      can: mcp251xfd: mcp251xfd_ring_init(): check TX-coalescing configuration
      can: mcp251xfd: properly indent labels
      can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: join: restrict fullmesh endp on 1st sf

Michael Kelley (1):
      x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides frequency

Mike Rapoport (1):
      microblaze: don't treat zero reserved memory regions as error

Pablo Neira Ayuso (2):
      netfilter: nft_set_pipapo: walk over current view on netlink dump
      netfilter: nf_tables: missing iterator type in lookup walk

Paulo Alcantara (1):
      smb: client: fix hang in wait_for_response() for negproto

Ping-Ke Shih (1):
      Revert "wifi: cfg80211: check wiphy mutex is held for wdev mutex"

Ross Brown (1):
      hwmon: (asus-ec-sensors) remove VRM temp X570-E GAMING

Sherry Yang (1):
      scsi: lpfc: Fix overflow build issue

Shiyang Ruan (2):
      xfs: fix the calculation for "end" and "length"
      xfs: correct calculation for agend and blockcount

Sumeet Pawnikar (1):
      powercap: RAPL: fix invalid initialization for pl4_supported field

Thomas Blocher (1):
      pinctrl: at91: make it work with current gpiolib

Tony Luck (1):
      x86/mm: Switch to new Intel CPU model defines

Wengang Wang (1):
      xfs: fix extent busy updating

Wu Guanghao (1):
      xfs: Fix deadlock on xfs_inodegc_worker

Ye Bin (1):
      xfs: fix BUG_ON in xfs_getbmap()

hongchi.peng (1):
      drm: komeda: Fix an issue related to normalized zpos

zhang jiao (1):
      tools: hv: rm .*.cmd when make clean


