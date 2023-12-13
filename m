Return-Path: <stable+bounces-4762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 182B5805E8E
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 20:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3F93B21039
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 19:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19366D1D9;
	Tue,  5 Dec 2023 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eksdIBaN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF236D1D4;
	Tue,  5 Dec 2023 19:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B431CC433C7;
	Tue,  5 Dec 2023 19:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701804154;
	bh=nrwPPBb23mGvYQXYCR/K4aUfIAPzghJLbp+uRncJ8NA=;
	h=From:To:Cc:Subject:Date:From;
	b=eksdIBaNjzaXA/RVowXtkd0KIfVkSR5JL9r+iEx2QqQkPfo4WfLgC2mcHklrSO6BG
	 Z6nJtwUpPZeFp8GuMvZf36wNTeQ0bXIQ671ayfhQ74p/cBx+Qyjn9m59ESK1E70xGT
	 sWbSoe+ZT1iNgjOpDUyfWgw0Kzql2dVewvBTMHpc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com
Subject: [PATCH 5.15 00/64] 5.15.142-rc2 review
Date: Wed,  6 Dec 2023 04:22:31 +0900
Message-ID: <20231205183238.954685317@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.142-rc2
X-KernelTest-Deadline: 2023-12-07T18:32+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.15.142 release.
There are 64 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.142-rc2

Christoph Hellwig <hch@lst.de>
    iomap: update ki_pos a little later in iomap_dio_complete

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix deadlock on RTL8125 in jumbo mtu mode

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: disable ASPM in case of tx timeout

Wenchao Chen <wenchao.chen@unisoc.com>
    mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulled

Heiner Kallweit <hkallweit1@gmail.com>
    mmc: core: add helpers mmc_regulator_enable/disable_vqmmc

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Make context clearing consistent with context mapping

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Omit devTLB invalidation requests when TES=0

Christoph Niedermaier <cniedermaier@dh-electronics.com>
    cpufreq: imx6q: Don't disable 792 Mhz OPP unnecessarily

Christoph Niedermaier <cniedermaier@dh-electronics.com>
    cpufreq: imx6q: don't warn for disabling a non-existing frequency

Steve French <stfrench@microsoft.com>
    smb3: fix caching of ctime on setxattr

Jeff Layton <jlayton@kernel.org>
    fs: add ctime accessors infrastructure

Helge Deller <deller@gmx.de>
    fbdev: stifb: Make the STI next font pointer a 32-bit signed offset

Mark Hasemeyer <markhas@chromium.org>
    ASoC: SOF: sof-pci-dev: Fix community key quirk detection

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: SOF: sof-pci-dev: don't use the community key on APL Chromebooks

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: SOF: sof-pci-dev: add parameter to override topology filename

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: SOF: sof-pci-dev: use community key on all Up boards

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: Move soc_intel_is_foo() helpers to a generic header

Steve French <stfrench@microsoft.com>
    smb3: fix touch -h of symlink

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Move _GNU_SOURCE define into Makefile

Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
    selftests/resctrl: Add missing SPDX license to Makefile

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix async branch flags

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Stop DMA in case of failures on ravb_open()

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Start TX queues after HW initialization succeeded

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Use pm_runtime_resume_and_get()

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Check return value of reset_control_deassert()

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    ravb: Fix races between ravb_tx_timeout_work() and net related ops

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: prevent potential deadlock in rtl8169_close

Andrey Grodzovsky <andrey.grodzovsky@amd.com>
    Revert "workqueue: remove unused cancel_work()"

Geetha sowjanya <gakula@marvell.com>
    octeontx2-pf: Fix adding mbox work queue entry when num_vfs > 64

Furong Xu <0x1207@gmail.com>
    net: stmmac: xgmac: Disable FPE MMC interrupts

Elena Salomatkina <elena.salomatkina.cmc@gmail.com>
    octeontx2-af: Fix possible buffer overflow

Willem de Bruijn <willemb@google.com>
    selftests/net: ipsec: fix constant out of range

Dmitry Antipov <dmantipov@yandex.ru>
    uapi: propagate __struct_group() attributes to the container union

Ioana Ciornei <ioana.ciornei@nxp.com>
    dpaa2-eth: increase the needed headroom to account for alignment

Zhengchao Shao <shaozhengchao@huawei.com>
    ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet

Niklas Neronin <niklas.neronin@linux.intel.com>
    usb: config: fix iteration issue in 'usb_get_bos_descriptor()'

Alan Stern <stern@rowland.harvard.edu>
    USB: core: Change configuration warnings to notices

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: fix race of netvsc and VF register_netdevice

Patrick Wang <patrick.wang.shcn@gmail.com>
    rcu: Avoid tracing a few functions executed in stop machine

Xin Long <lucien.xin@gmail.com>
    vlan: move dev_put into vlan_dev_uninit

Xin Long <lucien.xin@gmail.com>
    vlan: introduce vlan_dev_free_egress_priority

Max Nguyen <maxwell.nguyen@hp.com>
    Input: xpad - add HyperX Clutch Gladiate Support

Filipe Manana <fdmanana@suse.com>
    btrfs: make error messages more clear when getting a chunk map

Jann Horn <jannh@google.com>
    btrfs: send: ensure send_fd is writable

Filipe Manana <fdmanana@suse.com>
    btrfs: fix off-by-one when checking chunk map includes logical address

Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
    btrfs: ref-verify: fix memory leaks in btrfs_ref_tree_mod()

Qu Wenruo <wqu@suse.com>
    btrfs: add dmesg output for first mount and last unmount of a filesystem

Helge Deller <deller@gmx.de>
    parisc: Drop the HP-UX ENOSYM and EREMOTERELEASE error codes

Timothy Pearson <tpearson@raptorengineering.com>
    powerpc: Don't clobber f0/vs0 during fp|altivec register save

Abdul Halim, Mohd Syazwan <mohd.syazwan.abdul.halim@intel.com>
    iommu/vt-d: Add MTL to quirk list to skip TE disabling

Markus Weippert <markus@gekmihesg.de>
    bcache: revert replacing IS_ERR_OR_NULL with IS_ERR

Wu Bo <bo.wu@vivo.com>
    dm verity: don't perform FEC for failed readahead IO

Mikulas Patocka <mpatocka@redhat.com>
    dm-verity: align struct dm_verity_fec_io properly

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek: Add supported ALC257 for ChromeOS

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek: Headset Mic VREF to 100%

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Disable power-save on KONTRON SinglePC

Adrian Hunter <adrian.hunter@intel.com>
    mmc: block: Be sure to wait while busy in CQE error recovery

Adrian Hunter <adrian.hunter@intel.com>
    mmc: block: Do not lose cache flush during CQE error recovery

Adrian Hunter <adrian.hunter@intel.com>
    mmc: block: Retry commands in CQE error recovery

Adrian Hunter <adrian.hunter@intel.com>
    mmc: cqhci: Fix task clearing in CQE error recovery

Adrian Hunter <adrian.hunter@intel.com>
    mmc: cqhci: Warn of halt or task clear failure

Adrian Hunter <adrian.hunter@intel.com>
    mmc: cqhci: Increase recovery halt timeout

Yang Yingliang <yangyingliang@huawei.com>
    firewire: core: fix possible memory leak in create_units()

Maria Yu <quic_aiquny@quicinc.com>
    pinctrl: avoid reload of p state in list iteration


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/parisc/include/uapi/asm/errno.h               |  2 -
 arch/powerpc/kernel/fpu.S                          | 13 ++++
 arch/powerpc/kernel/vector.S                       |  2 +
 drivers/cpufreq/imx6q-cpufreq.c                    | 32 ++++----
 drivers/firewire/core-device.c                     | 11 +--
 drivers/input/joystick/xpad.c                      |  2 +
 drivers/iommu/intel/dmar.c                         | 18 +++++
 drivers/iommu/intel/iommu.c                        |  6 +-
 drivers/md/bcache/btree.c                          |  2 +-
 drivers/md/dm-verity-fec.c                         |  3 +-
 drivers/md/dm-verity-target.c                      |  4 +-
 drivers/md/dm-verity.h                             |  6 --
 drivers/mmc/core/block.c                           |  2 +
 drivers/mmc/core/core.c                            |  9 ++-
 drivers/mmc/core/regulator.c                       | 41 +++++++++++
 drivers/mmc/host/cqhci-core.c                      | 44 +++++------
 drivers/mmc/host/sdhci-sprd.c                      | 25 +++++++
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |  8 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |  2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  4 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  7 +-
 drivers/net/ethernet/realtek/r8169_main.c          | 23 +++++-
 drivers/net/ethernet/renesas/ravb_main.c           | 30 ++++++--
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c     |  4 +
 drivers/net/hyperv/netvsc_drv.c                    | 25 ++++---
 drivers/pinctrl/core.c                             |  6 +-
 drivers/usb/core/config.c                          | 85 +++++++++++-----------
 drivers/video/fbdev/sticore.h                      |  2 +-
 fs/btrfs/disk-io.c                                 |  1 +
 fs/btrfs/ref-verify.c                              |  2 +
 fs/btrfs/send.c                                    |  2 +-
 fs/btrfs/super.c                                   |  5 +-
 fs/btrfs/volumes.c                                 |  9 ++-
 fs/cifs/cifsfs.c                                   |  1 +
 fs/cifs/xattr.c                                    |  5 +-
 fs/inode.c                                         | 16 ++++
 fs/iomap/direct-io.c                               | 22 +++---
 include/linux/fs.h                                 | 45 +++++++++++-
 include/linux/mmc/host.h                           |  3 +
 include/linux/platform_data/x86/soc.h              | 65 +++++++++++++++++
 include/linux/workqueue.h                          |  1 +
 include/uapi/linux/stddef.h                        |  2 +-
 kernel/rcu/tree_plugin.h                           |  8 +-
 kernel/workqueue.c                                 |  9 +++
 lib/errname.c                                      |  6 --
 net/8021q/vlan.h                                   |  2 +-
 net/8021q/vlan_dev.c                               | 15 +++-
 net/8021q/vlan_netlink.c                           |  7 +-
 net/ipv4/igmp.c                                    |  6 +-
 sound/pci/hda/hda_intel.c                          |  2 +
 sound/pci/hda/patch_realtek.c                      | 12 +++
 sound/soc/intel/common/soc-intel-quirks.h          | 51 +------------
 sound/soc/sof/sof-pci-dev.c                        | 62 ++++++++++++----
 tools/arch/parisc/include/uapi/asm/errno.h         |  2 -
 tools/perf/util/intel-pt.c                         |  2 +
 tools/testing/selftests/net/ipsec.c                |  4 +-
 tools/testing/selftests/resctrl/Makefile           |  4 +-
 tools/testing/selftests/resctrl/resctrl.h          |  1 -
 59 files changed, 550 insertions(+), 244 deletions(-)



