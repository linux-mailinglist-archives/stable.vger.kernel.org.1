Return-Path: <stable+bounces-4985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BA9809DAD
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 08:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BE01C20B05
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5542E1094F;
	Fri,  8 Dec 2023 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JbVgm3H7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737B5398
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 07:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80ED8C433CA;
	Fri,  8 Dec 2023 07:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702022217;
	bh=6mhDWfrYJ/SVCtEVwKiEX/YjQFofqDrCf2NOHFrauZA=;
	h=From:To:Cc:Subject:Date:From;
	b=JbVgm3H7ZiLOtnZA6WKCaeg7QxEskI9KrkTqVnMph2I2+2gjTrZvxzUjIhEYwlQG0
	 ojRPAzrOXnAc5jBLzFjQzVkjdUXtnLr9M+cJGcevu9opoTCzC3690xmz43nf67SzWk
	 eAlpCNxz0hCiUspzNfo8yaojfSQdA4RCDg7W0qBQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.142
Date: Fri,  8 Dec 2023 08:56:48 +0100
Message-ID: <2023120848-coping-hydrogen-d258@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.142 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    2 
 arch/parisc/include/uapi/asm/errno.h                 |    2 
 arch/powerpc/kernel/fpu.S                            |   13 ++
 arch/powerpc/kernel/vector.S                         |    2 
 drivers/cpufreq/imx6q-cpufreq.c                      |   32 +++----
 drivers/firewire/core-device.c                       |   11 --
 drivers/input/joystick/xpad.c                        |    2 
 drivers/iommu/intel/dmar.c                           |   18 ++++
 drivers/iommu/intel/iommu.c                          |    6 -
 drivers/md/bcache/btree.c                            |    2 
 drivers/md/dm-verity-fec.c                           |    3 
 drivers/md/dm-verity-target.c                        |    4 
 drivers/md/dm-verity.h                               |    6 -
 drivers/mmc/core/block.c                             |    2 
 drivers/mmc/core/core.c                              |    9 +-
 drivers/mmc/core/regulator.c                         |   41 +++++++++
 drivers/mmc/host/cqhci-core.c                        |   44 ++++-----
 drivers/mmc/host/sdhci-sprd.c                        |   25 +++++
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c     |    8 -
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h     |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c  |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c |    7 +
 drivers/net/ethernet/realtek/r8169_main.c            |   23 ++++-
 drivers/net/ethernet/renesas/ravb_main.c             |   30 +++++-
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c       |    4 
 drivers/net/hyperv/netvsc_drv.c                      |   25 +++--
 drivers/pinctrl/core.c                               |    6 -
 drivers/usb/core/config.c                            |   85 +++++++++----------
 drivers/video/fbdev/sticore.h                        |    2 
 fs/btrfs/disk-io.c                                   |    1 
 fs/btrfs/ref-verify.c                                |    2 
 fs/btrfs/send.c                                      |    2 
 fs/btrfs/super.c                                     |    5 -
 fs/btrfs/volumes.c                                   |    9 +-
 fs/cifs/cifsfs.c                                     |    1 
 fs/cifs/xattr.c                                      |    5 -
 fs/inode.c                                           |   16 +++
 fs/iomap/direct-io.c                                 |   22 ++--
 include/linux/fs.h                                   |   45 +++++++++-
 include/linux/mmc/host.h                             |    3 
 include/linux/platform_data/x86/soc.h                |   65 ++++++++++++++
 include/linux/workqueue.h                            |    1 
 include/uapi/linux/stddef.h                          |    2 
 kernel/rcu/tree_plugin.h                             |    8 -
 kernel/workqueue.c                                   |    9 ++
 lib/errname.c                                        |    6 -
 net/8021q/vlan.h                                     |    2 
 net/8021q/vlan_dev.c                                 |   15 ++-
 net/8021q/vlan_netlink.c                             |    7 -
 net/ipv4/igmp.c                                      |    6 -
 sound/pci/hda/hda_intel.c                            |    2 
 sound/pci/hda/patch_realtek.c                        |   12 ++
 sound/soc/intel/common/soc-intel-quirks.h            |   51 -----------
 sound/soc/sof/sof-pci-dev.c                          |   62 ++++++++++---
 tools/arch/parisc/include/uapi/asm/errno.h           |    2 
 tools/perf/util/intel-pt.c                           |    2 
 tools/testing/selftests/net/ipsec.c                  |    4 
 tools/testing/selftests/resctrl/Makefile             |    4 
 tools/testing/selftests/resctrl/resctrl.h            |    1 
 59 files changed, 549 insertions(+), 243 deletions(-)

Abdul Halim, Mohd Syazwan (1):
      iommu/vt-d: Add MTL to quirk list to skip TE disabling

Adrian Hunter (7):
      mmc: cqhci: Increase recovery halt timeout
      mmc: cqhci: Warn of halt or task clear failure
      mmc: cqhci: Fix task clearing in CQE error recovery
      mmc: block: Retry commands in CQE error recovery
      mmc: block: Do not lose cache flush during CQE error recovery
      mmc: block: Be sure to wait while busy in CQE error recovery
      perf intel-pt: Fix async branch flags

Alan Stern (1):
      USB: core: Change configuration warnings to notices

Andrey Grodzovsky (1):
      Revert "workqueue: remove unused cancel_work()"

Bragatheswaran Manickavel (1):
      btrfs: ref-verify: fix memory leaks in btrfs_ref_tree_mod()

Christoph Hellwig (1):
      iomap: update ki_pos a little later in iomap_dio_complete

Christoph Niedermaier (2):
      cpufreq: imx6q: don't warn for disabling a non-existing frequency
      cpufreq: imx6q: Don't disable 792 Mhz OPP unnecessarily

Claudiu Beznea (4):
      net: ravb: Check return value of reset_control_deassert()
      net: ravb: Use pm_runtime_resume_and_get()
      net: ravb: Start TX queues after HW initialization succeeded
      net: ravb: Stop DMA in case of failures on ravb_open()

Dmitry Antipov (1):
      uapi: propagate __struct_group() attributes to the container union

Elena Salomatkina (1):
      octeontx2-af: Fix possible buffer overflow

Filipe Manana (2):
      btrfs: fix off-by-one when checking chunk map includes logical address
      btrfs: make error messages more clear when getting a chunk map

Furong Xu (1):
      net: stmmac: xgmac: Disable FPE MMC interrupts

Geetha sowjanya (1):
      octeontx2-pf: Fix adding mbox work queue entry when num_vfs > 64

Greg Kroah-Hartman (1):
      Linux 5.15.142

Haiyang Zhang (1):
      hv_netvsc: fix race of netvsc and VF register_netdevice

Hans de Goede (1):
      ASoC: Intel: Move soc_intel_is_foo() helpers to a generic header

Heiner Kallweit (4):
      r8169: prevent potential deadlock in rtl8169_close
      mmc: core: add helpers mmc_regulator_enable/disable_vqmmc
      r8169: disable ASPM in case of tx timeout
      r8169: fix deadlock on RTL8125 in jumbo mtu mode

Helge Deller (2):
      parisc: Drop the HP-UX ENOSYM and EREMOTERELEASE error codes
      fbdev: stifb: Make the STI next font pointer a 32-bit signed offset

Ilpo Järvinen (1):
      selftests/resctrl: Move _GNU_SOURCE define into Makefile

Ioana Ciornei (1):
      dpaa2-eth: increase the needed headroom to account for alignment

Jann Horn (1):
      btrfs: send: ensure send_fd is writable

Jeff Layton (1):
      fs: add ctime accessors infrastructure

Kailang Yang (2):
      ALSA: hda/realtek: Headset Mic VREF to 100%
      ALSA: hda/realtek: Add supported ALC257 for ChromeOS

Lu Baolu (2):
      iommu/vt-d: Omit devTLB invalidation requests when TES=0
      iommu/vt-d: Make context clearing consistent with context mapping

Maria Yu (1):
      pinctrl: avoid reload of p state in list iteration

Mark Hasemeyer (1):
      ASoC: SOF: sof-pci-dev: Fix community key quirk detection

Markus Weippert (1):
      bcache: revert replacing IS_ERR_OR_NULL with IS_ERR

Max Nguyen (1):
      Input: xpad - add HyperX Clutch Gladiate Support

Mikulas Patocka (1):
      dm-verity: align struct dm_verity_fec_io properly

Niklas Neronin (1):
      usb: config: fix iteration issue in 'usb_get_bos_descriptor()'

Patrick Wang (1):
      rcu: Avoid tracing a few functions executed in stop machine

Pierre-Louis Bossart (3):
      ASoC: SOF: sof-pci-dev: use community key on all Up boards
      ASoC: SOF: sof-pci-dev: add parameter to override topology filename
      ASoC: SOF: sof-pci-dev: don't use the community key on APL Chromebooks

Qu Wenruo (1):
      btrfs: add dmesg output for first mount and last unmount of a filesystem

Shaopeng Tan (1):
      selftests/resctrl: Add missing SPDX license to Makefile

Steve French (2):
      smb3: fix touch -h of symlink
      smb3: fix caching of ctime on setxattr

Takashi Iwai (1):
      ALSA: hda: Disable power-save on KONTRON SinglePC

Timothy Pearson (1):
      powerpc: Don't clobber f0/vs0 during fp|altivec register save

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulled

Willem de Bruijn (1):
      selftests/net: ipsec: fix constant out of range

Wu Bo (1):
      dm verity: don't perform FEC for failed readahead IO

Xin Long (2):
      vlan: introduce vlan_dev_free_egress_priority
      vlan: move dev_put into vlan_dev_uninit

Yang Yingliang (1):
      firewire: core: fix possible memory leak in create_units()

Yoshihiro Shimoda (1):
      ravb: Fix races between ravb_tx_timeout_work() and net related ops

Zhengchao Shao (1):
      ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet


