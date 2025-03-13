Return-Path: <stable+bounces-124287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1476BA5F463
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C4D17EFFA
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FFA2676F3;
	Thu, 13 Mar 2025 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IWoLh7j4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AFE2676E9;
	Thu, 13 Mar 2025 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868900; cv=none; b=umPbBtMccbYgu8FC0d1EJJ8VGkxY58uULND4aU/Rg6bPUfbXJAsbaTWEtyqBdZtQutnFSUPWvN7jOrcn/xq31sRO1bKTJCKoyh0sHPS5cPojmDq98DqwHszsmdljgIRDX38WA4JWuZF2z7b1Nrao8tNiINOHDEvg9Uc+GO69gFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868900; c=relaxed/simple;
	bh=XmhL4E6RkPTQCrOYnr2XLw+jDaQQWBwzCvaKTk4LxKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jPzFO2ISS7Zw6s26vs6XRNs4VIb95jcfRGFutD5lbc6eawDk5yUAvgXOhru7QKwnSUZpYbOkATiEbUWaBfj91s5qY2NyCkht0DvJpZteJwFbK3YQXePXoZ7xZoHqwPFbf8CyqfySbQ1OoBicYKmc6d8RT/wJVictO5gGnph5tmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IWoLh7j4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21E0C4CEDD;
	Thu, 13 Mar 2025 12:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741868899;
	bh=XmhL4E6RkPTQCrOYnr2XLw+jDaQQWBwzCvaKTk4LxKw=;
	h=From:To:Cc:Subject:Date:From;
	b=IWoLh7j4Pgx1tiNfa3j+jwL/KH1T3nRwPt7ThYV3lG4tYdL5iGFFSzb4gmw7Ybi1v
	 q5VcHRifca8nFCds0dpPQAhyj7EMPS9p6ShC+hotNMRxgcYRnN3zOMSZ28MdsbAHEA
	 QIsLHUXwrKSkDKUQnHIwE0M93sAI+ONOg0IJiCPU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.131
Date: Thu, 13 Mar 2025 13:28:06 +0100
Message-ID: <2025031307-human-sphere-cd14@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.131 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                               |    7 
 arch/loongarch/kernel/machine_kexec.c                  |    4 
 arch/powerpc/kvm/e500_mmu_host.c                       |   21 +
 arch/s390/kernel/traps.c                               |    6 
 arch/x86/include/asm/spec-ctrl.h                       |   11 
 arch/x86/kernel/amd_nb.c                               |    9 
 arch/x86/kernel/cpu/bugs.c                             |    2 
 arch/x86/kernel/cpu/cacheinfo.c                        |    2 
 arch/x86/kernel/cpu/intel.c                            |   52 +++-
 arch/x86/kernel/cpu/sgx/ioctl.c                        |    7 
 arch/x86/kvm/svm/svm.c                                 |   12 +
 arch/x86/kvm/svm/svm.h                                 |    2 
 arch/x86/mm/init.c                                     |   23 +
 block/partitions/efi.c                                 |    2 
 drivers/base/core.c                                    |    1 
 drivers/block/ublk_drv.c                               |    7 
 drivers/bluetooth/btusb.c                              |    1 
 drivers/bus/mhi/host/pci_generic.c                     |    5 
 drivers/gpio/gpio-aggregator.c                         |   20 +
 drivers/gpio/gpio-rcar.c                               |   31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c             |   11 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c      |    3 
 drivers/gpu/drm/radeon/r300.c                          |    3 
 drivers/gpu/drm/radeon/radeon_asic.h                   |    1 
 drivers/gpu/drm/radeon/rs400.c                         |   18 +
 drivers/gpu/drm/scheduler/gpu_scheduler_trace.h        |    4 
 drivers/hid/hid-appleir.c                              |    2 
 drivers/hid/hid-google-hammer.c                        |    2 
 drivers/hid/intel-ish-hid/ishtp-hid.c                  |    4 
 drivers/hwmon/ad7314.c                                 |   10 
 drivers/hwmon/ntc_thermistor.c                         |   66 ++---
 drivers/hwmon/pmbus/pmbus.c                            |    2 
 drivers/hwmon/xgene-hwmon.c                            |    2 
 drivers/hwtracing/intel_th/pci.c                       |   15 +
 drivers/idle/intel_idle.c                              |    4 
 drivers/iio/adc/at91-sama5d2_adc.c                     |   68 +++--
 drivers/iio/dac/ad3552r.c                              |    6 
 drivers/iio/filter/admv8818.c                          |   14 -
 drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c   |    6 
 drivers/misc/cardreader/rtsx_usb.c                     |   15 -
 drivers/misc/eeprom/digsy_mtc_eeprom.c                 |    2 
 drivers/misc/mei/hw-me-regs.h                          |    2 
 drivers/misc/mei/pci-me.c                              |    2 
 drivers/net/caif/caif_virtio.c                         |    2 
 drivers/net/ethernet/emulex/benet/be.h                 |    2 
 drivers/net/ethernet/emulex/benet/be_cmds.c            |  197 ++++++++---------
 drivers/net/ethernet/emulex/benet/be_main.c            |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |    2 
 drivers/net/ethernet/ibm/ibmvnic.c                     |   21 +
 drivers/net/ppp/ppp_generic.c                          |   28 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c           |    2 
 drivers/nvme/target/tcp.c                              |   15 -
 drivers/of/of_reserved_mem.c                           |    4 
 drivers/platform/x86/thinkpad_acpi.c                   |    1 
 drivers/rapidio/devices/rio_mport_cdev.c               |    3 
 drivers/rapidio/rio-scan.c                             |    5 
 drivers/scsi/lpfc/lpfc_hbadisc.c                       |    2 
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
 drivers/usb/host/xhci-mem.c                            |    3 
 drivers/usb/host/xhci-pci.c                            |   18 -
 drivers/usb/host/xhci.h                                |    2 
 drivers/usb/renesas_usbhs/common.c                     |    6 
 drivers/usb/renesas_usbhs/mod_gadget.c                 |    2 
 drivers/usb/typec/tcpm/tcpci_rt1711h.c                 |   11 
 drivers/usb/typec/ucsi/ucsi.c                          |    2 
 drivers/virt/acrn/hsm.c                                |    6 
 fs/exfat/balloc.c                                      |   10 
 fs/exfat/exfat_fs.h                                    |    2 
 fs/exfat/fatent.c                                      |   11 
 fs/nilfs2/dir.c                                        |   24 --
 fs/nilfs2/namei.c                                      |   37 +--
 fs/nilfs2/nilfs.h                                      |   10 
 fs/ntfs3/record.c                                      |    3 
 fs/smb/server/smb2pdu.c                                |    8 
 fs/smb/server/transport_ipc.c                          |    1 
 kernel/events/uprobes.c                                |    2 
 kernel/sched/fair.c                                    |    6 
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
 net/vmw_vsock/af_vsock.c                               |   77 ++++--
 net/wireless/nl80211.c                                 |    5 
 net/wireless/reg.c                                     |    3 
 sound/pci/hda/Kconfig                                  |    1 
 sound/pci/hda/hda_intel.c                              |    2 
 sound/pci/hda/patch_realtek.c                          |   99 ++++++++
 sound/usb/usx2y/usbusx2y.c                             |   11 
 sound/usb/usx2y/usbusx2y.h                             |   26 ++
 sound/usb/usx2y/usbusx2yaudio.c                        |   27 --
 106 files changed, 968 insertions(+), 506 deletions(-)

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

Andrew Cooper (1):
      x86/amd_nb: Use rdmsr_safe() in amd_get_mmconfig_range()

Andy Shevchenko (2):
      xhci: pci: Fix indentation in the PCI device ID definitions
      eeprom: digsy_mtc: Make GPIO lookup table match the device

Angelo Dureghello (1):
      iio: dac: ad3552r: clear reset status flag

AngeloGioacchino Del Regno (1):
      usb: typec: tcpci_rt1711h: Unmask alert interrupts to fix functionality

Antoine Tenart (1):
      net: gso: fix ownership in __udp_gso_segment

Arnd Bergmann (1):
      ALSA: hda: realtek: fix incorrect IS_REACHABLE() usage

Badhri Jagan Sridharan (1):
      usb: dwc3: gadget: Prevent irq storm when TH re-executes

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

Fedor Pchelkin (1):
      usb: typec: ucsi: increase timeout for PPM reset operations

Greg Kroah-Hartman (5):
      Revert "KVM: e500: always restore irqs"
      Revert "KVM: PPC: e500: Use __kvm_faultin_pfn() to handle page faults"
      Revert "KVM: PPC: e500: Mark "struct page" pfn accessed before dropping mmu_lock"
      Revert "KVM: PPC: e500: Mark "struct page" dirty in kvmppc_e500_shadow_map()"
      Linux 6.1.131

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

Irui Wang (1):
      media: mediatek: vcodec: Handle invalid decoder vsi

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

Konstantin Komarov (1):
      fs/ntfs3: Add rough attr alloc_size check

Krister Johansen (1):
      mptcp: fix 'scheduling while atomic' in mptcp_pm_nl_append_new_local_addr

Luca Ceresoli (1):
      drivers: core: fix device leak in __fw_devlink_relax_cycles()

Ma Jun (1):
      drm/amdgpu: Check extended configuration space register when system uses large bar

Ma Ke (1):
      drm/amd/display: Fix null check for pipe_ctx->plane_state in resource_build_scaling_params

Manivannan Sadhasivam (1):
      bus: mhi: host: pci_generic: Use pci_try_reset_function() to avoid deadlock

Marek Szyprowski (1):
      usb: gadget: Fix setting self-powered state on suspend

Maud Spierings (1):
      hwmon: (ntc_thermistor) Fix the ncpXXxh103 sensor table

Meir Elisha (1):
      nvmet-tcp: Fix a possible sporadic response drops in weakly ordered arch

Miao Li (1):
      usb: quirks: Add DELAY_INIT and NO_LPM for Prolific Mass Storage Card Reader

Michal Luczaj (3):
      bpf, vsock: Invoke proto::close on close()
      vsock: Keep the binding until socket destruction
      vsock: Orphan socket after transport release

Michal Pecio (1):
      usb: xhci: Enable the TRB overfetch quirk on VIA VL805

Mingcong Bai (1):
      platform/x86: thinkpad_acpi: Add battery quirk for ThinkPad X131e

Murad Masimov (1):
      ALSA: usx2y: validate nrpacks module parameter on probe

Namjae Jeon (4):
      ksmbd: fix type confusion via race condition when using ipc_msg_send_request
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

Pawel Chmielewski (1):
      intel_th: pci: Add Arrow Lake support

Pawel Laszczak (1):
      usb: hub: lack of clearing xHC resources

Peiyang Wang (1):
      net: hns3: make sure ptp clock is unregister and freed if hclge_ptp_get_cycle returns an error

Peter Zijlstra (1):
      cpuidle, intel_idle: Fix CPUIDLE_FLAG_IBRS

Philipp Stanner (1):
      drm/sched: Fix preprocessor guard

Prashanth K (2):
      usb: gadget: Set self-powered based on MaxPower and bmAttributes
      usb: gadget: Check bmAttributes only if configuration is valid

Ralf Schlatterbeck (1):
      spi-mxs: Fix chipselect glitch

Richard Thier (1):
      drm/radeon: Fix rs400_gpu_init for ATI mobility radeon Xpress 200M

Rob Herring (Arm) (1):
      Revert "of: reserved-memory: Fix using wrong number of cells to get property 'alignment'"

Ryan Roberts (1):
      mm: don't skip arch_sync_kernel_mappings() in error paths

Ryusuke Konishi (3):
      nilfs2: move page release outside of nilfs_delete_entry and nilfs_set_link
      nilfs2: eliminate staggered calls to kunmap in nilfs_rename
      nilfs2: handle errors that nilfs_prepare_chunk() may return

Salah Triki (1):
      bluetooth: btusb: Initialize .owner field of force_poll_sync_fops

Sam Winchenbach (1):
      iio: filter: admv8818: Force initialization of SDO

Sean Christopherson (1):
      KVM: SVM: Drop DEBUGCTL[5:2] from guest's effective value

Sebastian Andrzej Siewior (1):
      dma: kmsan: export kmsan_handle_dma() for modules

Thinh Nguyen (1):
      usb: dwc3: Set SUSPENDENABLE soon after phy init

Thomas Weißschuh (1):
      kbuild: userprogs: use correct lld when linking through clang

Tiezhu Yang (1):
      LoongArch: Convert unreachable() to BUG()

Titus Rwantare (1):
      hwmon: (pmbus) Initialise page count in pmbus_identify()

Tuo Li (1):
      scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()

Uday Shankar (1):
      ublk: set_params: properly check if parameters can be applied

Visweswara Tanuku (1):
      slimbus: messaging: Free transaction ID in delayed interrupt scenario

Vitaliy Shevtsov (2):
      wifi: nl80211: reject cooked mode if it is set along with other flags
      caif_virtio: fix wrong pointer check in cfv_probe()

Waiman Long (1):
      x86/speculation: Add __update_spec_ctrl() helper

Xi Ruoyao (1):
      x86/mm: Don't disable PCID when INVLPG has been fixed by microcode

Xinghuo Chen (1):
      hwmon: fix a NULL vs IS_ERR_OR_NULL() check in xgene_hwmon_probe()

Yu-Chun Lin (1):
      HID: google: fix unused variable warning under !CONFIG_ACPI

Zecheng Li (1):
      sched/fair: Fix potential memory corruption in child_cfs_rq_on_list

Zhang Lixu (1):
      HID: intel-ish-hid: Fix use-after-free issue in ishtp_hid_remove()


