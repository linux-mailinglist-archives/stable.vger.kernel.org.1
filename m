Return-Path: <stable+bounces-124289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF3BA5F469
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20036188C9E2
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D00D267727;
	Thu, 13 Mar 2025 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ysLb3OCy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ACC267707;
	Thu, 13 Mar 2025 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868908; cv=none; b=UNmAHdwtlGdZT8vJPCtsuewrgh8T+ndOgD44AFC5g+8Dfdwm/VJDi6N3y7W4ePu60iA5gVvqgUNDTwSdiUoh/ZCzikofcqhSVamcSwR8xzuR0Ll9/LIx+Wg6BPr1Z/IlctJsw4oXdEpvS6FvDihArmoPkIQsgVkl58XJqKK2mIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868908; c=relaxed/simple;
	bh=QLxwjD8MWYHXQ3+D3/N7qhI6Gd7gzUkw7tcU+/Ow6rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZDd7VuMLcXs4HrMKLZJ/54LM/Ht9olLrcdXb2jMPg+r/a8lyb/QdADLDPsXPtQLxBDr3yjZ/rEv8LExsFdpsYtscGROQMaSfpKVjmmYUb8yGyxF9lYmaeKh/pvv8/8JAY/WbRGh0Q9ocyEnNJgnJ8EmcrmJa0yDKNsATuPvI5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ysLb3OCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4D7C4CEDD;
	Thu, 13 Mar 2025 12:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741868907;
	bh=QLxwjD8MWYHXQ3+D3/N7qhI6Gd7gzUkw7tcU+/Ow6rw=;
	h=From:To:Cc:Subject:Date:From;
	b=ysLb3OCya9D61GyMcvymok1s9/dOEDV0z23BlGX4P9amSzUSiFa4RR42yVLbEuSMB
	 A3bEVqM9SJbSxhcBUKME+hQqDWyVI4qjE+XoZOGTh6b1CcAbOdtXst5NfC94xehPgB
	 ulySQv2UrvsdHeuxjZHiMcQzAfumGPlB8y+CfMEI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.83
Date: Thu, 13 Mar 2025 13:28:12 +0100
Message-ID: <2025031313-grazing-unboxed-9a20@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.83 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                               |    7 
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts  |    1 
 arch/arm64/include/asm/hugetlb.h                       |    4 
 arch/arm64/mm/hugetlbpage.c                            |   61 ++---
 arch/loongarch/include/asm/hugetlb.h                   |    6 
 arch/loongarch/kernel/machine_kexec.c                  |    4 
 arch/loongarch/kernel/setup.c                          |    3 
 arch/loongarch/kernel/smp.c                            |   47 +++-
 arch/mips/include/asm/hugetlb.h                        |    6 
 arch/parisc/include/asm/hugetlb.h                      |    2 
 arch/parisc/mm/hugetlbpage.c                           |    2 
 arch/powerpc/include/asm/hugetlb.h                     |    6 
 arch/powerpc/kvm/e500_mmu_host.c                       |   21 +
 arch/riscv/include/asm/cpufeature.h                    |    1 
 arch/riscv/include/asm/csr.h                           |    3 
 arch/riscv/include/asm/hugetlb.h                       |    3 
 arch/riscv/include/asm/hwcap.h                         |   16 +
 arch/riscv/kernel/cacheinfo.c                          |   54 +++-
 arch/riscv/kernel/cpufeature.c                         |    6 
 arch/riscv/kernel/setup.c                              |    6 
 arch/riscv/kernel/smpboot.c                            |    4 
 arch/riscv/mm/hugetlbpage.c                            |    2 
 arch/s390/include/asm/hugetlb.h                        |   17 +
 arch/s390/kernel/traps.c                               |    6 
 arch/s390/mm/hugetlbpage.c                             |    4 
 arch/sparc/include/asm/hugetlb.h                       |    2 
 arch/sparc/mm/hugetlbpage.c                            |    2 
 arch/x86/boot/compressed/acpi.c                        |   14 -
 arch/x86/boot/compressed/cmdline.c                     |    4 
 arch/x86/boot/compressed/ident_map_64.c                |    7 
 arch/x86/boot/compressed/kaslr.c                       |   26 +-
 arch/x86/boot/compressed/mem.c                         |    6 
 arch/x86/boot/compressed/misc.c                        |   26 +-
 arch/x86/boot/compressed/misc.h                        |    1 
 arch/x86/boot/compressed/pgtable_64.c                  |   11 
 arch/x86/boot/compressed/sev.c                         |    2 
 arch/x86/include/asm/boot.h                            |    2 
 arch/x86/include/asm/spec-ctrl.h                       |   11 
 arch/x86/kernel/amd_nb.c                               |    9 
 arch/x86/kernel/cpu/cacheinfo.c                        |    2 
 arch/x86/kernel/cpu/intel.c                            |   52 +++-
 arch/x86/kernel/cpu/microcode/amd.c                    |    6 
 arch/x86/kernel/cpu/sgx/ioctl.c                        |    7 
 arch/x86/kvm/cpuid.c                                   |    2 
 arch/x86/kvm/svm/svm.c                                 |   21 +
 arch/x86/kvm/svm/svm.h                                 |    2 
 arch/x86/mm/init.c                                     |   23 +
 block/partitions/efi.c                                 |    2 
 drivers/base/core.c                                    |    1 
 drivers/block/ublk_drv.c                               |    7 
 drivers/bluetooth/btusb.c                              |    1 
 drivers/bus/mhi/host/pci_generic.c                     |    5 
 drivers/cdx/cdx.c                                      |    6 
 drivers/char/misc.c                                    |    2 
 drivers/firmware/efi/libstub/x86-stub.c                |    2 
 drivers/firmware/efi/libstub/x86-stub.h                |    2 
 drivers/firmware/efi/mokvar-table.c                    |   42 +--
 drivers/gpio/gpio-aggregator.c                         |   20 +
 drivers/gpio/gpio-rcar.c                               |   31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c             |   11 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c      |    3 
 drivers/gpu/drm/i915/display/icl_dsi.c                 |    4 
 drivers/gpu/drm/i915/display/intel_ddi.c               |   46 +++
 drivers/gpu/drm/i915/i915_reg.h                        |    4 
 drivers/gpu/drm/radeon/r300.c                          |    3 
 drivers/gpu/drm/radeon/radeon_asic.h                   |    1 
 drivers/gpu/drm/radeon/rs400.c                         |   18 +
 drivers/gpu/drm/scheduler/gpu_scheduler_trace.h        |    4 
 drivers/hid/hid-appleir.c                              |    2 
 drivers/hid/hid-google-hammer.c                        |    2 
 drivers/hid/hid-steam.c                                |    2 
 drivers/hid/intel-ish-hid/ishtp-hid.c                  |    4 
 drivers/hwmon/ad7314.c                                 |   10 
 drivers/hwmon/ntc_thermistor.c                         |   66 ++---
 drivers/hwmon/peci/dimmtemp.c                          |   10 
 drivers/hwmon/pmbus/pmbus.c                            |    2 
 drivers/hwmon/xgene-hwmon.c                            |    2 
 drivers/hwtracing/intel_th/pci.c                       |   15 +
 drivers/iio/adc/at91-sama5d2_adc.c                     |   68 +++--
 drivers/iio/dac/ad3552r.c                              |    6 
 drivers/iio/filter/admv8818.c                          |   14 -
 drivers/misc/cardreader/rtsx_usb.c                     |   15 -
 drivers/misc/eeprom/digsy_mtc_eeprom.c                 |    2 
 drivers/misc/mei/hw-me-regs.h                          |    2 
 drivers/misc/mei/pci-me.c                              |    2 
 drivers/net/caif/caif_virtio.c                         |    2 
 drivers/net/dsa/mt7530.c                               |    8 
 drivers/net/ethernet/emulex/benet/be.h                 |    2 
 drivers/net/ethernet/emulex/benet/be_cmds.c            |  197 ++++++++---------
 drivers/net/ethernet/emulex/benet/be_main.c            |    2 
 drivers/net/ethernet/freescale/enetc/enetc.c           |   25 +-
 drivers/net/ethernet/freescale/enetc/enetc.h           |    9 
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c   |   27 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |    2 
 drivers/net/ethernet/ibm/ibmvnic.c                     |   21 +
 drivers/net/ipa/data/ipa_data-v4.7.c                   |   18 -
 drivers/net/ppp/ppp_generic.c                          |   28 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c           |    2 
 drivers/nvme/target/tcp.c                              |   15 -
 drivers/of/of_reserved_mem.c                           |    4 
 drivers/platform/x86/thinkpad_acpi.c                   |    1 
 drivers/rapidio/devices/rio_mport_cdev.c               |    3 
 drivers/rapidio/rio-scan.c                             |    5 
 drivers/slimbus/messaging.c                            |    5 
 drivers/spi/spi-mxs.c                                  |    3 
 drivers/usb/atm/cxacru.c                               |   13 -
 drivers/usb/core/hub.c                                 |   33 ++
 drivers/usb/core/quirks.c                              |    4 
 drivers/usb/dwc3/core.c                                |   85 ++++---
 drivers/usb/dwc3/core.h                                |    2 
 drivers/usb/dwc3/drd.c                                 |    4 
 drivers/usb/dwc3/gadget.c                              |   10 
 drivers/usb/gadget/composite.c                         |   17 +
 drivers/usb/gadget/function/u_ether.c                  |    4 
 drivers/usb/host/xhci-mem.c                            |    3 
 drivers/usb/host/xhci-pci.c                            |   18 -
 drivers/usb/host/xhci.h                                |    2 
 drivers/usb/renesas_usbhs/common.c                     |    6 
 drivers/usb/renesas_usbhs/mod_gadget.c                 |    2 
 drivers/usb/typec/tcpm/tcpci_rt1711h.c                 |   11 
 drivers/usb/typec/ucsi/ucsi.c                          |   15 -
 drivers/virt/acrn/hsm.c                                |    6 
 fs/exfat/balloc.c                                      |   10 
 fs/exfat/exfat_fs.h                                    |    2 
 fs/exfat/fatent.c                                      |   11 
 fs/nfs/direct.c                                        |   19 +
 fs/nfs/file.c                                          |    3 
 fs/smb/client/inode.c                                  |    4 
 fs/smb/server/smb2pdu.c                                |    8 
 fs/smb/server/smbacl.c                                 |   16 +
 fs/smb/server/transport_ipc.c                          |    1 
 include/asm-generic/hugetlb.h                          |    2 
 include/linux/compaction.h                             |    5 
 include/linux/hugetlb.h                                |    4 
 include/linux/sched.h                                  |    2 
 kernel/events/core.c                                   |    4 
 kernel/events/uprobes.c                                |    2 
 kernel/sched/fair.c                                    |    6 
 kernel/trace/trace_fprobe.c                            |    2 
 kernel/trace/trace_probe.h                             |    1 
 mm/compaction.c                                        |    3 
 mm/hugetlb.c                                           |    4 
 mm/kmsan/hooks.c                                       |    1 
 mm/memory.c                                            |    6 
 mm/page_alloc.c                                        |    1 
 mm/vmalloc.c                                           |    4 
 net/8021q/vlan.c                                       |    3 
 net/bluetooth/mgmt.c                                   |    5 
 net/ipv4/tcp_offload.c                                 |   11 
 net/ipv4/udp_offload.c                                 |    8 
 net/ipv6/ila/ila_lwt.c                                 |    4 
 net/llc/llc_s_ac.c                                     |   49 ++--
 net/mptcp/pm_netlink.c                                 |   18 +
 net/sched/sch_fifo.c                                   |    3 
 net/wireless/nl80211.c                                 |    5 
 net/wireless/reg.c                                     |    3 
 security/integrity/ima/ima_main.c                      |    7 
 security/integrity/integrity.h                         |    3 
 sound/core/seq/seq_clientmgr.c                         |   46 ++-
 sound/pci/hda/Kconfig                                  |    1 
 sound/pci/hda/hda_intel.c                              |    2 
 sound/pci/hda/patch_realtek.c                          |   99 ++++++++
 sound/usb/usx2y/usbusx2y.c                             |   11 
 sound/usb/usx2y/usbusx2y.h                             |   26 ++
 sound/usb/usx2y/usbusx2yaudio.c                        |   27 --
 usr/include/Makefile                                   |    2 
 166 files changed, 1330 insertions(+), 707 deletions(-)

Ahmed S. Darwish (3):
      x86/cacheinfo: Validate CPUID leaf 0x2 EDX output
      x86/cpu: Validate CPUID leaf 0x2 EDX output
      x86/cpu: Properly parse CPUID leaf 0x2 TLB descriptor 0x63

Alex Deucher (1):
      drm/amdgpu: disable BAR resize on Dell G5 SE

Alexander Shishkin (2):
      intel_th: pci: Add Panther Lake-H support
      intel_th: pci: Add Panther Lake-P/U support

Alexander Usyskin (1):
      mei: me: add panther lake P DID

Andrei Kuchynski (1):
      usb: typec: ucsi: Fix NULL pointer access

Andrew Cooper (1):
      x86/amd_nb: Use rdmsr_safe() in amd_get_mmconfig_range()

Andrew Jones (1):
      RISC-V: Enable cbo.zero in usermode

Andy Shevchenko (2):
      xhci: pci: Fix indentation in the PCI device ID definitions
      eeprom: digsy_mtc: Make GPIO lookup table match the device

Angelo Dureghello (1):
      iio: dac: ad3552r: clear reset status flag

AngeloGioacchino Del Regno (1):
      usb: typec: tcpci_rt1711h: Unmask alert interrupts to fix functionality

Antoine Tenart (1):
      net: gso: fix ownership in __udp_gso_segment

Ard Biesheuvel (2):
      x86/boot: Rename conflicting 'boot_params' pointer to 'boot_params_ptr'
      x86/boot: Sanitize boot params before parsing command line

Arnd Bergmann (2):
      kbuild: hdrcheck: fix cross build with clang
      ALSA: hda: realtek: fix incorrect IS_REACHABLE() usage

Badhri Jagan Sridharan (1):
      usb: dwc3: gadget: Prevent irq storm when TH re-executes

Bibo Mao (1):
      LoongArch: Set max_pfn with the PFN of the last page

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Add some forgotten models to the SHA check

Christian Heusel (1):
      Revert "drivers/card_reader/rtsx_usb: Restore interrupt based detection"

Claudiu Beznea (3):
      usb: renesas_usbhs: Call clk_put()
      usb: renesas_usbhs: Use devm_usb_get_phy()
      usb: renesas_usbhs: Flush the notify_hotplug_work

Daniil Dulov (1):
      HID: appleir: Fix potential NULL dereference at raw event handle

Eric Dumazet (1):
      llc: do not use skb_get() before dev_queue_xmit()

Erik Schumacher (1):
      hwmon: (ad7314) Validate leading zero bits and return error

Fabrizio Castro (1):
      gpio: rcar: Fix missing of_node_put() call

Farouk Bouabid (1):
      arm64: dts: rockchip: add rs485 support on uart5 of px30-ringneck-haikou

Fedor Pchelkin (1):
      usb: typec: ucsi: increase timeout for PPM reset operations

Gal Pressman (1):
      net: enetc: Remove setting of RX software timestamp

Greg Kroah-Hartman (5):
      Revert "KVM: e500: always restore irqs"
      Revert "KVM: PPC: e500: Use __kvm_faultin_pfn() to handle page faults"
      Revert "KVM: PPC: e500: Mark "struct page" pfn accessed before dropping mmu_lock"
      Revert "KVM: PPC: e500: Mark "struct page" dirty in kvmppc_e500_shadow_map()"
      Linux 6.6.83

Hao Zhang (1):
      mm/page_alloc: fix uninitialized variable

Haoxiang Li (4):
      Bluetooth: Add check for mgmt_alloc_skb() in mgmt_remote_name()
      Bluetooth: Add check for mgmt_alloc_skb() in mgmt_device_connected()
      rapidio: add check for rio_add_net() in rio_scan_alloc_net()
      rapidio: fix an API misues when rio_add_net() fails

Haoyu Li (1):
      drivers: virt: acrn: hsm: Use kzalloc to avoid info leak in pmcmd_ioctl

Heiko Carstens (1):
      s390/traps: Fix test_monitor_call() inline assembly

Hoku Ishibe (1):
      ALSA: hda: intel: Add Dell ALC3271 to power_save denylist

Huacai Chen (1):
      LoongArch: Use polling play_dead() when resuming from hibernation

Imre Deak (2):
      drm/i915/ddi: Fix HDMI port width programming in DDI_BUF_CTL
      drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro

Jarkko Sakkinen (1):
      x86/sgx: Fix size overflows in sgx_encl_create()

Jason Xing (1):
      net-timestamp: support TCP GSO case for a few missing flags

Jiayuan Chen (1):
      ppp: Fix KMSAN uninit-value warning with bpf

Jiri Olsa (1):
      uprobes: Fix race in uprobe_free_utask

Johannes Berg (1):
      wifi: iwlwifi: limit printed string from FW file

Justin Iurman (2):
      net: ipv6: fix dst ref loop in ila lwtunnel
      net: ipv6: fix missing dst ref drop in ila lwtunnel

Kailang Yang (2):
      ALSA: hda/realtek - add supported Mic Mute LED for Lenovo platform
      ALSA: hda/realtek: update ALC222 depop optimize

Koichiro Den (1):
      gpio: aggregator: protect driver attr handlers against module unload

Krister Johansen (1):
      mptcp: fix 'scheduling while atomic' in mptcp_pm_nl_append_new_local_addr

Lorenzo Bianconi (1):
      net: dsa: mt7530: Fix traffic flooding for MMIO devices

Luca Ceresoli (1):
      drivers: core: fix device leak in __fw_devlink_relax_cycles()

Luca Weiss (3):
      net: ipa: Fix v4.7 resource group names
      net: ipa: Fix QSB data for v4.7
      net: ipa: Enable checksum for IPA_ENDPOINT_AP_MODEM_{RX,TX} for v4.7

Lucas De Marchi (1):
      drm/i915/xe2lpd: Move D2D enable/disable

Ma Jun (1):
      drm/amdgpu: Check extended configuration space register when system uses large bar

Ma Ke (1):
      drm/amd/display: Fix null check for pipe_ctx->plane_state in resource_build_scaling_params

Manivannan Sadhasivam (1):
      bus: mhi: host: pci_generic: Use pci_try_reset_function() to avoid deadlock

Marek Szyprowski (1):
      usb: gadget: Fix setting self-powered state on suspend

Martyn Welch (1):
      net: enetc: Replace ifdef with IS_ENABLED

Masami Hiramatsu (Google) (2):
      tracing: tprobe-events: Fix a memory leak when tprobe with $retval
      tracing: probe-events: Remove unused MAX_ARG_BUF_LEN macro

Maud Spierings (1):
      hwmon: (ntc_thermistor) Fix the ncpXXxh103 sensor table

Meir Elisha (1):
      nvmet-tcp: Fix a possible sporadic response drops in weakly ordered arch

Miao Li (1):
      usb: quirks: Add DELAY_INIT and NO_LPM for Prolific Mass Storage Card Reader

Michal Pecio (1):
      usb: xhci: Enable the TRB overfetch quirk on VIA VL805

Mike Snitzer (1):
      NFS: fix nfs_release_folio() to not deadlock via kcompactd writeback

Mingcong Bai (1):
      platform/x86: thinkpad_acpi: Add battery quirk for ThinkPad X131e

Miquel Sabaté Solà (1):
      riscv: Prevent a bad reference count on CPU nodes

Murad Masimov (1):
      ALSA: usx2y: validate nrpacks module parameter on probe

Namjae Jeon (5):
      ksmbd: fix type confusion via race condition when using ipc_msg_send_request
      ksmbd: fix out-of-bounds in parse_sec_desc()
      ksmbd: fix use-after-free in smb2_lock
      ksmbd: fix bug on trap in smb2_lock
      exfat: fix soft lockup in exfat_clear_bitmap

Nayab Sayed (1):
      iio: adc: at91-sama5d2_adc: fix sama7g5 realbits value

Nick Child (2):
      ibmvnic: Perform tx CSO during send scrq direct
      ibmvnic: Inspect header requirements before using scrq direct

Nikita Zhandarovich (2):
      wifi: cfg80211: regulatory: improve invalid hints checking
      usb: atm: cxacru: fix a flaw in existing endpoint checks

Niklas Söderlund (1):
      gpio: rcar: Use raw_spinlock to protect register access

Nikolay Aleksandrov (1):
      be2net: fix sleeping while atomic bugs in be_ndo_bridge_getlink

Olivier Gayot (1):
      block: fix conversion of GPT partition name to 7-bit

Oscar Maes (1):
      vlan: enforce underlying device type

Paul Fertser (1):
      hwmon: (peci/dimmtemp) Do not provide fake thresholds data

Paulo Alcantara (1):
      smb: client: fix chmod(2) regression with ATTR_READONLY

Pawel Chmielewski (1):
      intel_th: pci: Add Arrow Lake support

Pawel Laszczak (1):
      usb: hub: lack of clearing xHC resources

Peiyang Wang (1):
      net: hns3: make sure ptp clock is unregister and freed if hclge_ptp_get_cycle returns an error

Peter Jones (1):
      efi: Don't map the entire mokvar table to determine its size

Peter Zijlstra (1):
      perf/core: Fix pmus_lock vs. pmus_srcu ordering

Philipp Stanner (1):
      drm/sched: Fix preprocessor guard

Prashanth K (3):
      usb: gadget: u_ether: Set is_suspend flag if remote wakeup fails
      usb: gadget: Set self-powered based on MaxPower and bmAttributes
      usb: gadget: Check bmAttributes only if configuration is valid

Qiu-ji Chen (1):
      cdx: Fix possible UAF error in driver_override_show()

Quang Le (1):
      pfifo_tail_enqueue: Drop new packet when sch->limit == 0

Ralf Schlatterbeck (1):
      spi-mxs: Fix chipselect glitch

Richard Thier (1):
      drm/radeon: Fix rs400_gpu_init for ATI mobility radeon Xpress 200M

Rob Herring (1):
      riscv: cacheinfo: Use of_property_present() for non-boolean properties

Rob Herring (Arm) (1):
      Revert "of: reserved-memory: Fix using wrong number of cells to get property 'alignment'"

Roberto Sassu (1):
      ima: Reset IMA_NONACTION_RULE_FLAGS after post_setattr

Ryan Roberts (3):
      mm: don't skip arch_sync_kernel_mappings() in error paths
      mm: hugetlb: Add huge page size param to huge_ptep_get_and_clear()
      arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes

Salah Triki (1):
      bluetooth: btusb: Initialize .owner field of force_poll_sync_fops

Sam Winchenbach (1):
      iio: filter: admv8818: Force initialization of SDO

Samuel Holland (1):
      riscv: Fix enabling cbo.zero when running in M-mode

Sean Christopherson (2):
      KVM: SVM: Drop DEBUGCTL[5:2] from guest's effective value
      KVM: SVM: Suppress DEBUGCTL.BTF on AMD

Sebastian Andrzej Siewior (1):
      dma: kmsan: export kmsan_handle_dma() for modules

Takashi Iwai (1):
      ALSA: seq: Avoid module auto-load handling at event delivery

Thadeu Lima de Souza Cascardo (1):
      char: misc: deallocate static minor in error path

Thinh Nguyen (1):
      usb: dwc3: Set SUSPENDENABLE soon after phy init

Thomas Weißschuh (1):
      kbuild: userprogs: use correct lld when linking through clang

Tiezhu Yang (1):
      LoongArch: Convert unreachable() to BUG()

Titus Rwantare (1):
      hwmon: (pmbus) Initialise page count in pmbus_identify()

Trond Myklebust (1):
      NFS: O_DIRECT writes must check and adjust the file length

Uday Shankar (1):
      ublk: set_params: properly check if parameters can be applied

Vicki Pfau (1):
      HID: hid-steam: Fix use-after-free when detaching device

Visweswara Tanuku (1):
      slimbus: messaging: Free transaction ID in delayed interrupt scenario

Vitaliy Shevtsov (2):
      wifi: nl80211: reject cooked mode if it is set along with other flags
      caif_virtio: fix wrong pointer check in cfv_probe()

Waiman Long (1):
      x86/speculation: Add __update_spec_ctrl() helper

Wei Fang (1):
      net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC

Xi Ruoyao (1):
      x86/mm: Don't disable PCID when INVLPG has been fixed by microcode

Xiaoyao Li (1):
      KVM: x86: Explicitly zero EAX and EBX when PERFMON_V2 isn't supported by KVM

Xinghuo Chen (1):
      hwmon: fix a NULL vs IS_ERR_OR_NULL() check in xgene_hwmon_probe()

Yong-Xuan Wang (1):
      riscv: signal: fix signal_minsigstksz

Yu-Chun Lin (1):
      HID: google: fix unused variable warning under !CONFIG_ACPI

Yunhui Cui (2):
      riscv: cacheinfo: remove the useless input parameter (node) of ci_leaf_init()
      riscv: cacheinfo: initialize cacheinfo's level and type from ACPI PPTT

Zecheng Li (1):
      sched/fair: Fix potential memory corruption in child_cfs_rq_on_list

Zhang Lixu (1):
      HID: intel-ish-hid: Fix use-after-free issue in ishtp_hid_remove()


