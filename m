Return-Path: <stable+bounces-78277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ED698A772
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 16:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22FA0B22C77
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 14:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17805191F77;
	Mon, 30 Sep 2024 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VxA4SpGw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67331922CB;
	Mon, 30 Sep 2024 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707341; cv=none; b=i0lkaWLVCv4oLTepbgi/23BiSKEZPB0O4BePWRZRsXhJolh1p68njbkQuQpHRb4PpY1/1n2TDmZt5txqZnyfgcwqWudMGZY4gMlJU3xnqdBgrCxc1mgi/BqpTu7yTgRT32bodXDQUKjSkBG1O3GSPs3i9GjGnN0BEAGuxmULLEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707341; c=relaxed/simple;
	bh=UYdgk9KOentbK21EJhhIj3MN00PbUA5HXv7IR0rAoL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pCyCsVQzeyD2Ce23W9vuUnUs9TDulkujnf9vTTb6gbuGAx8rveCXBDZcifEjounhJzGk/D2J5zL8WOEb9i4lIibgARXHAGY2kYP37zsUnzN+7zSNJXIfanLQq2cU4kBuP4AGbV+ArOfa/5TZk2bhJYyYNUPExOrgkoFzZsk5XsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VxA4SpGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DCBC4CEC7;
	Mon, 30 Sep 2024 14:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727707341;
	bh=UYdgk9KOentbK21EJhhIj3MN00PbUA5HXv7IR0rAoL8=;
	h=From:To:Cc:Subject:Date:From;
	b=VxA4SpGw7Ps0wkPQfrUbTJuPANm3yESeGIx6ekYtWrVTTEstaUN8tnJvHVBvhptKS
	 YtQLhaSpmvfRSbVqdzvRky8oSxxGFRRWZsISui+BZHLFJ9uYb8JIG4rqp5xp7UTHtt
	 rKXdWr1GG7XWsepv/hB8w2JtFEDYGghZ9vJ4X+CM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.10.12
Date: Mon, 30 Sep 2024 16:42:16 +0200
Message-ID: <2024093015-imaging-drainer-82ac@gregkh>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.10.12 kernel.

All users of the 6.10 kernel series must upgrade.

The updated 6.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                 |    2 
 arch/loongarch/include/asm/hw_irq.h                      |    2 
 arch/loongarch/include/asm/kvm_vcpu.h                    |    1 
 arch/loongarch/kernel/irq.c                              |    3 
 arch/loongarch/kvm/timer.c                               |    7 
 arch/loongarch/kvm/vcpu.c                                |    2 
 arch/microblaze/mm/init.c                                |    5 
 arch/x86/kernel/cpu/mshyperv.c                           |    1 
 drivers/accel/drm_accel.c                                |  110 ---------------
 drivers/bluetooth/btintel_pcie.c                         |    2 
 drivers/clk/qcom/gcc-sm8650.c                            |   56 +++----
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c     |    3 
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c          |   10 -
 drivers/gpu/drm/drm_drv.c                                |   97 ++++++-------
 drivers/gpu/drm/drm_file.c                               |    2 
 drivers/gpu/drm/drm_internal.h                           |    4 
 drivers/hwmon/asus-ec-sensors.c                          |    2 
 drivers/net/can/m_can/m_can.c                            |   16 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c           |   42 +++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c           |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c         |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c           |   14 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c            |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c      |    7 
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h                |    1 
 drivers/net/ethernet/faraday/ftgmac100.c                 |   26 ++-
 drivers/net/ethernet/intel/ice/ice_lib.c                 |    4 
 drivers/net/ethernet/intel/ice/ice_main.c                |    4 
 drivers/net/ethernet/intel/ice/ice_xsk.c                 |    6 
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c              |    2 
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h           |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c        |    9 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c             |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c            |   31 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c |    3 
 drivers/nvme/host/nvme.h                                 |    5 
 drivers/nvme/host/pci.c                                  |   18 +-
 drivers/pinctrl/pinctrl-at91.c                           |    5 
 drivers/platform/x86/amd/pmf/pmf-quirks.c                |    2 
 drivers/platform/x86/asus-nb-wmi.c                       |   20 ++
 drivers/platform/x86/asus-wmi.h                          |    1 
 drivers/platform/x86/x86-android-tablets/dmi.c           |    1 
 drivers/powercap/intel_rapl_common.c                     |   35 ++++
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
 net/mac80211/tx.c                                        |    4 
 net/netfilter/nft_socket.c                               |   41 +++++
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
 sound/soc/mediatek/mt8188/mt8188-mt6359.c                |   17 +-
 sound/soc/sof/mediatek/mt8195/mt8195.c                   |    3 
 tools/hv/Makefile                                        |    2 
 69 files changed, 449 insertions(+), 358 deletions(-)

Albert Jakieła (1):
      ASoC: SOF: mediatek: Add missing board compatible

Benjamin Berg (1):
      wifi: iwlwifi: lower message level for FW buffer destination

Bibo Mao (1):
      LoongArch: KVM: Invalidate guest steal time address on vCPU reset

Dan Carpenter (2):
      netfilter: nft_socket: Fix a NULL vs IS_ERR() bug in nft_socket_cgroup_subtree_level()
      powercap: intel_rapl: Change an error pointer to NULL

Daniel Gabay (2):
      wifi: iwlwifi: mvm: fix iwl_mvm_scan_fits() calculation
      wifi: iwlwifi: mvm: fix iwl_mvm_max_scan_ie_fw_cmd_room()

Dhananjay Ugwekar (2):
      powercap/intel_rapl: Add support for AMD family 1Ah
      powercap/intel_rapl: Fix the energy-pkg event for AMD CPUs

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
      Linux 6.10.12

Hans de Goede (2):
      platform/x86: x86-android-tablets: Make Lenovo Yoga Tab 3 X90F DMI match less strict
      ASoC: Intel: soc-acpi-cht: Make Lenovo Yoga Tab 3 X90F DMI match less strict

Hongbo Li (2):
      ASoC: allow module autoloading for table db1200_pids
      ASoC: allow module autoloading for table board_ids

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

Kenneth Feng (1):
      drm/amd/pm: fix the pp_dpm_pcie issue on smu v14.0.2/3

Kiran K (1):
      Bluetooth: btintel_pcie: Allocate memory for driver private data

Larysa Zaremba (1):
      ice: check for XDP rings instead of bpf program when unconfiguring

Liao Chen (5):
      ASoC: intel: fix module autoloading
      ASoC: google: fix module autoloading
      ASoC: tda7419: fix module autoloading
      ASoC: fix module autoloading
      spi: bcm63xx: Enable module autoloading

Luke D. Jones (1):
      platform/x86/amd: pmf: Make ASUS GA403 quirk generic

Marc Kleine-Budde (3):
      can: mcp251xfd: mcp251xfd_ring_init(): check TX-coalescing configuration
      can: mcp251xfd: properly indent labels
      can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()

Markus Schneider-Pargmann (1):
      can: m_can: Limit coalescing to peripheral instances

Markuss Broks (1):
      ASoC: amd: yc: Add a quirk for MSI Bravo 17 (D7VEK)

Mathieu Fenniak (1):
      platform/x86: asus-wmi: Fix spurious rfkill on UX8406MA

Michael Kelley (1):
      x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides frequency

Michał Winiarski (3):
      drm: Use XArray instead of IDR for minors
      accel: Use XArray instead of IDR for minors
      drm: Expand max DRM device number to full MINORBITS

Mike Rapoport (1):
      microblaze: don't treat zero reserved memory regions as error

Neil Armstrong (1):
      clk: qcom: gcc-sm8650: Don't use shared clk_ops for QUPs

Paulo Alcantara (1):
      smb: client: fix hang in wait_for_response() for negproto

Ross Brown (1):
      hwmon: (asus-ec-sensors) remove VRM temp X570-E GAMING

Sherry Yang (1):
      scsi: lpfc: Fix overflow build issue

Thomas Blocher (1):
      pinctrl: at91: make it work with current gpiolib

YR Yang (1):
      ASoC: mediatek: mt8188: Mark AFE_DAC_CON0 register as volatile

Zhang Yi (1):
      ASoC: mediatek: mt8188-mt6359: Modify key

hongchi.peng (1):
      drm: komeda: Fix an issue related to normalized zpos

zhang jiao (1):
      tools: hv: rm .*.cmd when make clean


