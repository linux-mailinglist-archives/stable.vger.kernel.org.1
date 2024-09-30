Return-Path: <stable+bounces-78275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8168D98A76D
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 16:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5962B23B18
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E46191F85;
	Mon, 30 Sep 2024 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zueSG4ia"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D5D191F7B;
	Mon, 30 Sep 2024 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707322; cv=none; b=dgEfrfJLtHX+l4i0GKIg6PM9bBbPk95CMOsn5lPTSTq/c8P+ZiHQ2qliHAHbGqWFS7qS1v0x2dCm5tsnyMF7575fbwPc2FVJRscOkF89lMzyG/CbjJm6YMQlGb9AaZ4rm4b+BVpfxuBKhUmU0KszwO4Tg9VuO6IINmu9S5HQZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707322; c=relaxed/simple;
	bh=xQqqYDc2alcfGoTb9nqasrPw+VNKehr6TaGH19vHziE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rh2hz4QAmC+aAizISW6x61zsVx/cc7vp20HGYuvtZLNfX/dUjEC1AW7bT53PbKis0V2eUFBFkbLZN6AOdkuFFn+RBEn9J2nbm5n97BrpvDp3av4MrwnTQ6GrA4CEa07INDvaS34K53b7DtWT24dYv2tdzOaL1Gz7oDTkOKSktfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zueSG4ia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCB8C4CEC7;
	Mon, 30 Sep 2024 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727707321;
	bh=xQqqYDc2alcfGoTb9nqasrPw+VNKehr6TaGH19vHziE=;
	h=From:To:Cc:Subject:Date:From;
	b=zueSG4ia3FpSsEn4oQMsw4VQSYeO3GG7wA89/bwXJWody63RaZ0KQoMN+RH00tkNh
	 so4Wv1Xr4LPoS804+83jlv+9VimT+dpBGEeEr6tlarSx35X85EdVCHJ1ojTBnpkah7
	 biDJh5opWM+QwTIqXjE6U7byA+i55poeVqlv7hEM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.53
Date: Mon, 30 Sep 2024 16:41:49 +0200
Message-ID: <2024093048-fringe-mouth-fa43@gregkh>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.53 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
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
 arch/x86/mm/init.c                                       |   16 --
 block/blk-core.c                                         |   10 +
 block/blk-mq.c                                           |   10 -
 drivers/accel/drm_accel.c                                |  110 ---------------
 drivers/gpio/gpiolib-cdev.c                              |   12 -
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c          |   10 -
 drivers/gpu/drm/drm_drv.c                                |   97 ++++++-------
 drivers/gpu/drm/drm_file.c                               |    2 
 drivers/gpu/drm/drm_internal.h                           |    4 
 drivers/hwmon/asus-ec-sensors.c                          |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c           |   42 +++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c           |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c         |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c           |   14 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c            |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c      |    7 
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h                |    1 
 drivers/net/ethernet/faraday/ftgmac100.c                 |   26 ++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c              |    2 
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h           |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c        |    9 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c             |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c            |   31 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c |    3 
 drivers/nvme/host/nvme.h                                 |    5 
 drivers/nvme/host/pci.c                                  |   18 +-
 drivers/pinctrl/pinctrl-at91.c                           |    5 
 drivers/platform/x86/x86-android-tablets/dmi.c           |    1 
 drivers/powercap/intel_rapl_common.c                     |    1 
 drivers/scsi/lpfc/lpfc_bsg.c                             |    2 
 drivers/spi/spi-bcm63xx.c                                |    1 
 drivers/spi/spidev.c                                     |    2 
 drivers/usb/class/usbtmc.c                               |    2 
 drivers/usb/serial/pl2303.c                              |    1 
 drivers/usb/serial/pl2303.h                              |    4 
 fs/ocfs2/xattr.c                                         |   27 ++-
 fs/smb/client/connect.c                                  |   14 +
 include/drm/drm_accel.h                                  |   18 --
 include/drm/drm_file.h                                   |    5 
 include/net/netfilter/nf_tables.h                        |   13 +
 net/mac80211/tx.c                                        |    4 
 net/netfilter/nf_tables_api.c                            |    5 
 net/netfilter/nft_lookup.c                               |    1 
 net/netfilter/nft_set_pipapo.c                           |    6 
 net/netfilter/nft_socket.c                               |   41 +++++
 net/wireless/core.h                                      |    8 -
 sound/pci/hda/patch_hdmi.c                               |    1 
 sound/pci/hda/patch_realtek.c                            |   76 ++++++----
 sound/soc/amd/acp/acp-sof-mach.c                         |    2 
 sound/soc/amd/yc/acp6x-mach.c                            |    7 
 sound/soc/au1x/db1200.c                                  |    1 
 sound/soc/codecs/chv3-codec.c                            |    1 
 sound/soc/codecs/tda7419.c                               |    1 
 sound/soc/google/chv3-i2s.c                              |    1 
 sound/soc/intel/common/soc-acpi-intel-cht-match.c        |    1 
 sound/soc/intel/keembay/kmb_platform.c                   |    1 
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c               |    1 
 sound/soc/sof/mediatek/mt8195/mt8195.c                   |    3 
 tools/hv/Makefile                                        |    2 
 64 files changed, 383 insertions(+), 330 deletions(-)

Albert Jakieła (1):
      ASoC: SOF: mediatek: Add missing board compatible

Benjamin Berg (1):
      wifi: iwlwifi: lower message level for FW buffer destination

Dan Carpenter (1):
      netfilter: nft_socket: Fix a NULL vs IS_ERR() bug in nft_socket_cgroup_subtree_level()

Daniel Gabay (2):
      wifi: iwlwifi: mvm: fix iwl_mvm_scan_fits() calculation
      wifi: iwlwifi: mvm: fix iwl_mvm_max_scan_ie_fw_cmd_room()

Dhananjay Ugwekar (1):
      powercap/intel_rapl: Add support for AMD family 1Ah

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

Florian Westphal (1):
      netfilter: nft_socket: make cgroupsv2 matching work with namespaces

Geert Uytterhoeven (1):
      spi: spidev: Add missing spi_device_id for jg10309-01

Greg Kroah-Hartman (1):
      Linux 6.6.53

Hans de Goede (2):
      platform/x86: x86-android-tablets: Make Lenovo Yoga Tab 3 X90F DMI match less strict
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

Kai Vehmanen (1):
      ALSA: hda: add HDMI codec ID for Intel PTL

Kailang Yang (2):
      ALSA: hda/realtek - Fixed ALC256 headphone no sound
      ALSA: hda/realtek - FIxed ALC285 headphone no sound

Keith Busch (1):
      nvme-pci: qdepth 1 quirk

Kent Gibson (1):
      gpiolib: cdev: Ignore reconfiguration without direction

Liao Chen (5):
      ASoC: intel: fix module autoloading
      ASoC: google: fix module autoloading
      ASoC: tda7419: fix module autoloading
      ASoC: fix module autoloading
      spi: bcm63xx: Enable module autoloading

Marc Kleine-Budde (3):
      can: mcp251xfd: mcp251xfd_ring_init(): check TX-coalescing configuration
      can: mcp251xfd: properly indent labels
      can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()

Markuss Broks (1):
      ASoC: amd: yc: Add a quirk for MSI Bravo 17 (D7VEK)

Michael Kelley (1):
      x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides frequency

Michał Winiarski (3):
      drm: Use XArray instead of IDR for minors
      accel: Use XArray instead of IDR for minors
      drm: Expand max DRM device number to full MINORBITS

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

Thomas Blocher (1):
      pinctrl: at91: make it work with current gpiolib

Tony Luck (1):
      x86/mm: Switch to new Intel CPU model defines

YR Yang (1):
      ASoC: mediatek: mt8188: Mark AFE_DAC_CON0 register as volatile

hongchi.peng (1):
      drm: komeda: Fix an issue related to normalized zpos

zhang jiao (1):
      tools: hv: rm .*.cmd when make clean


