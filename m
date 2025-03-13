Return-Path: <stable+bounces-124292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C711BA5F46F
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBA93BBF27
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3198E2676D0;
	Thu, 13 Mar 2025 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GQRHqgQo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2213267AFF;
	Thu, 13 Mar 2025 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868917; cv=none; b=HinF5UH1srivtNqT86czbqZXoeTdh6IVPmZEr6ME3lySr0DMsZmrcI2FBrWOUhd20Yn1yfN18vjEGFqQKvwCs64dgx4dVKPMAZ5FMZOxfVIWODg1q3SyD0VnVFfaMtpQulWXS9k8k+2oVrAnfuFyMWPC/FQdYLyTOaAC7Z3G96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868917; c=relaxed/simple;
	bh=WtYknXeotmqlbj2y1zfPXFmf7YM39B8dkws6cSYTvaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nP3IlKPhGpsIa6BtRi5jDG/O1HuDDRr12qXf9iK0+N0rxCGmT04pJMy8XE1q2KfG6grVnU5UsW0n2whkogj/Em2CYErzlsu4sU86xyXFxqc8gv6TdtcVflDlbZKNz3S9g3CRhbUUY4SBffo0P9kUSXo2a/P5QOOMfulrI1T/Ldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GQRHqgQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC59C4CEDD;
	Thu, 13 Mar 2025 12:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741868917;
	bh=WtYknXeotmqlbj2y1zfPXFmf7YM39B8dkws6cSYTvaM=;
	h=From:To:Cc:Subject:Date:From;
	b=GQRHqgQorU56TSST3GK5P046F95P4jB9vHmLQNScF2VCscxF5VXsZbkIdM5DHtNcJ
	 PL54YUXIAVcTt7u5Xh/i8w202Rf4g/b3VHc4oM3bbmJtlm4EYZRse7Xr9SRxTQUGC9
	 1ZZT8EiwycKWjT5jDi+To7iECd9p8Rxz+Kkvwn50=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.13.7
Date: Thu, 13 Mar 2025 13:28:28 +0100
Message-ID: <2025031329-macaw-unstable-669c@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.13.7 kernel.

All users of the 6.13 kernel series must upgrade.

The updated 6.13.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.13.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/sysctl/kernel.rst               |   11 
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml |    1 
 Makefile                                                  |    7 
 arch/arm/mm/fault-armv.c                                  |   37 +-
 arch/arm64/include/asm/hugetlb.h                          |    4 
 arch/arm64/mm/hugetlbpage.c                               |   61 +---
 arch/loongarch/include/asm/bug.h                          |   13 
 arch/loongarch/include/asm/hugetlb.h                      |    6 
 arch/loongarch/kernel/machine_kexec.c                     |    4 
 arch/loongarch/kernel/setup.c                             |    3 
 arch/loongarch/kernel/smp.c                               |   47 +++
 arch/loongarch/kvm/exit.c                                 |    6 
 arch/loongarch/kvm/main.c                                 |    7 
 arch/loongarch/kvm/vcpu.c                                 |    2 
 arch/loongarch/kvm/vm.c                                   |    6 
 arch/loongarch/mm/mmap.c                                  |    6 
 arch/mips/include/asm/hugetlb.h                           |    6 
 arch/parisc/include/asm/hugetlb.h                         |    2 
 arch/parisc/mm/hugetlbpage.c                              |    2 
 arch/powerpc/include/asm/hugetlb.h                        |    6 
 arch/riscv/include/asm/hugetlb.h                          |    3 
 arch/riscv/mm/hugetlbpage.c                               |    2 
 arch/s390/include/asm/hugetlb.h                           |   18 -
 arch/s390/kernel/traps.c                                  |    6 
 arch/s390/mm/hugetlbpage.c                                |    4 
 arch/sparc/include/asm/hugetlb.h                          |    2 
 arch/sparc/mm/hugetlbpage.c                               |    2 
 arch/x86/boot/compressed/pgtable_64.c                     |    2 
 arch/x86/include/asm/kvm_host.h                           |    1 
 arch/x86/kernel/amd_nb.c                                  |    9 
 arch/x86/kernel/cpu/cacheinfo.c                           |    2 
 arch/x86/kernel/cpu/intel.c                               |   52 ++-
 arch/x86/kernel/cpu/microcode/amd.c                       |    6 
 arch/x86/kernel/cpu/sgx/ioctl.c                           |    7 
 arch/x86/kvm/cpuid.c                                      |    2 
 arch/x86/kvm/svm/sev.c                                    |   13 
 arch/x86/kvm/svm/svm.c                                    |   49 +++
 arch/x86/kvm/svm/svm.h                                    |    2 
 arch/x86/kvm/svm/vmenter.S                                |   10 
 arch/x86/kvm/vmx/vmx.c                                    |    8 
 arch/x86/kvm/vmx/vmx.h                                    |    2 
 arch/x86/kvm/x86.c                                        |    2 
 block/partitions/efi.c                                    |    2 
 drivers/base/core.c                                       |    1 
 drivers/block/ublk_drv.c                                  |    7 
 drivers/bluetooth/btusb.c                                 |    1 
 drivers/bus/mhi/host/pci_generic.c                        |    5 
 drivers/cdx/cdx.c                                         |    6 
 drivers/char/misc.c                                       |    2 
 drivers/gpio/gpio-aggregator.c                            |   20 +
 drivers/gpio/gpio-rcar.c                                  |   31 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                    |    4 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c         |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c            |   12 
 drivers/gpu/drm/imagination/pvr_fw_meta.c                 |    6 
 drivers/gpu/drm/imagination/pvr_fw_trace.c                |    4 
 drivers/gpu/drm/imagination/pvr_queue.c                   |   18 -
 drivers/gpu/drm/imagination/pvr_queue.h                   |    4 
 drivers/gpu/drm/imagination/pvr_vm.c                      |  134 +++++++--
 drivers/gpu/drm/imagination/pvr_vm.h                      |    3 
 drivers/gpu/drm/nouveau/Kconfig                           |    1 
 drivers/gpu/drm/radeon/r300.c                             |    3 
 drivers/gpu/drm/radeon/radeon_asic.h                      |    1 
 drivers/gpu/drm/radeon/rs400.c                            |   18 +
 drivers/gpu/drm/scheduler/gpu_scheduler_trace.h           |    4 
 drivers/gpu/drm/tiny/bochs.c                              |    5 
 drivers/gpu/drm/xe/display/xe_plane_initial.c             |   10 
 drivers/gpu/drm/xe/xe_gt.c                                |    4 
 drivers/gpu/drm/xe/xe_hmm.c                               |  188 +++++++++----
 drivers/gpu/drm/xe/xe_hmm.h                               |    7 
 drivers/gpu/drm/xe/xe_pt.c                                |   96 +++---
 drivers/gpu/drm/xe/xe_pt_walk.c                           |    3 
 drivers/gpu/drm/xe/xe_pt_walk.h                           |    4 
 drivers/gpu/drm/xe/xe_vm.c                                |  100 ++++---
 drivers/gpu/drm/xe/xe_vm.h                                |   10 
 drivers/gpu/drm/xe/xe_vm_types.h                          |    8 
 drivers/hid/hid-appleir.c                                 |    2 
 drivers/hid/hid-corsair-void.c                            |   83 +++--
 drivers/hid/hid-google-hammer.c                           |    2 
 drivers/hid/hid-steam.c                                   |    2 
 drivers/hid/intel-ish-hid/ishtp-hid-client.c              |    2 
 drivers/hid/intel-ish-hid/ishtp-hid.c                     |    4 
 drivers/hwmon/ad7314.c                                    |   10 
 drivers/hwmon/ntc_thermistor.c                            |   66 ++--
 drivers/hwmon/peci/dimmtemp.c                             |   10 
 drivers/hwmon/pmbus/pmbus.c                               |    2 
 drivers/hwmon/xgene-hwmon.c                               |    2 
 drivers/hwtracing/intel_th/pci.c                          |   15 +
 drivers/iio/adc/ad7192.c                                  |    2 
 drivers/iio/adc/ad7606.c                                  |    2 
 drivers/iio/adc/at91-sama5d2_adc.c                        |   68 ++--
 drivers/iio/dac/ad3552r.c                                 |    6 
 drivers/iio/filter/admv8818.c                             |   14 
 drivers/iio/light/apds9306.c                              |    4 
 drivers/iio/light/hid-sensor-prox.c                       |    7 
 drivers/misc/cardreader/rtsx_usb.c                        |   15 -
 drivers/misc/eeprom/digsy_mtc_eeprom.c                    |    2 
 drivers/misc/mei/hw-me-regs.h                             |    2 
 drivers/misc/mei/pci-me.c                                 |    2 
 drivers/misc/mei/vsc-tp.c                                 |    2 
 drivers/net/caif/caif_virtio.c                            |    2 
 drivers/net/dsa/mt7530.c                                  |    8 
 drivers/net/ethernet/emulex/benet/be.h                    |    2 
 drivers/net/ethernet/emulex/benet/be_cmds.c               |  197 ++++++--------
 drivers/net/ethernet/emulex/benet/be_main.c               |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c    |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c      |    6 
 drivers/net/ipa/data/ipa_data-v4.7.c                      |   18 -
 drivers/net/mctp/mctp-i3c.c                               |    3 
 drivers/net/phy/phy.c                                     |   43 +++
 drivers/net/phy/phy_device.c                              |    2 
 drivers/net/ppp/ppp_generic.c                             |   28 +
 drivers/net/wireless/intel/iwlwifi/fw/dump.c              |    3 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c              |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c               |   77 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c          |    7 
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c       |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h        |    5 
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c         |    6 
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c              |   23 -
 drivers/nvme/host/ioctl.c                                 |   12 
 drivers/nvme/host/tcp.c                                   |   81 +++++
 drivers/nvme/target/nvmet.h                               |    1 
 drivers/nvme/target/tcp.c                                 |   15 -
 drivers/of/of_reserved_mem.c                              |    4 
 drivers/platform/x86/thinkpad_acpi.c                      |    1 
 drivers/rapidio/devices/rio_mport_cdev.c                  |    3 
 drivers/rapidio/rio-scan.c                                |    5 
 drivers/slimbus/messaging.c                               |    5 
 drivers/usb/atm/cxacru.c                                  |   13 
 drivers/usb/core/hub.c                                    |   33 ++
 drivers/usb/core/quirks.c                                 |    4 
 drivers/usb/dwc3/core.c                                   |   85 +++---
 drivers/usb/dwc3/core.h                                   |    2 
 drivers/usb/dwc3/drd.c                                    |    4 
 drivers/usb/dwc3/gadget.c                                 |   10 
 drivers/usb/gadget/composite.c                            |   17 -
 drivers/usb/gadget/function/u_ether.c                     |    4 
 drivers/usb/host/xhci-hub.c                               |    8 
 drivers/usb/host/xhci-mem.c                               |    3 
 drivers/usb/host/xhci-pci.c                               |   10 
 drivers/usb/host/xhci.c                                   |    6 
 drivers/usb/host/xhci.h                                   |    2 
 drivers/usb/renesas_usbhs/common.c                        |    6 
 drivers/usb/renesas_usbhs/mod_gadget.c                    |    2 
 drivers/usb/typec/tcpm/tcpci_rt1711h.c                    |   11 
 drivers/usb/typec/ucsi/ucsi.c                             |   25 -
 drivers/usb/typec/ucsi/ucsi.h                             |    2 
 drivers/usb/typec/ucsi/ucsi_acpi.c                        |   21 -
 drivers/usb/typec/ucsi/ucsi_ccg.c                         |    1 
 drivers/usb/typec/ucsi/ucsi_glink.c                       |    1 
 drivers/usb/typec/ucsi/ucsi_stm32g0.c                     |    1 
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c                   |    1 
 drivers/virt/acrn/hsm.c                                   |    6 
 drivers/virt/coco/sev-guest/sev-guest.c                   |   24 +
 fs/btrfs/inode.c                                          |    9 
 fs/btrfs/volumes.c                                        |    1 
 fs/coredump.c                                             |   15 -
 fs/exfat/balloc.c                                         |   10 
 fs/exfat/exfat_fs.h                                       |    2 
 fs/exfat/fatent.c                                         |   11 
 fs/exfat/file.c                                           |    2 
 fs/exfat/namei.c                                          |    2 
 fs/nfs/file.c                                             |    3 
 fs/smb/client/cifsglob.h                                  |    6 
 fs/smb/client/inode.c                                     |    2 
 fs/smb/client/reparse.h                                   |   28 +
 fs/smb/client/smb1ops.c                                   |    4 
 fs/smb/client/smb2inode.c                                 |    4 
 fs/smb/client/smb2ops.c                                   |    3 
 fs/smb/server/smb2pdu.c                                   |    8 
 fs/smb/server/smbacl.c                                    |   16 +
 fs/smb/server/transport_ipc.c                             |    1 
 include/asm-generic/hugetlb.h                             |    2 
 include/linux/compaction.h                                |    5 
 include/linux/cred.h                                      |    9 
 include/linux/ethtool.h                                   |   23 +
 include/linux/hugetlb.h                                   |    4 
 include/linux/nvme-tcp.h                                  |    2 
 include/linux/phy.h                                       |   36 ++
 include/linux/phylib_stubs.h                              |   42 ++
 include/linux/sched.h                                     |    2 
 kernel/events/core.c                                      |    4 
 kernel/sched/fair.c                                       |    6 
 kernel/trace/trace_fprobe.c                               |   15 +
 kernel/trace/trace_probe.h                                |    2 
 mm/compaction.c                                           |    3 
 mm/hugetlb.c                                              |    4 
 mm/internal.h                                             |    5 
 mm/kmsan/hooks.c                                          |    1 
 mm/memory-failure.c                                       |   63 ++--
 mm/memory.c                                               |   21 -
 mm/memory_hotplug.c                                       |   26 -
 mm/page_alloc.c                                           |    4 
 mm/userfaultfd.c                                          |   17 +
 mm/vma.c                                                  |   12 
 mm/vmalloc.c                                              |    4 
 net/8021q/vlan.c                                          |    3 
 net/bluetooth/mgmt.c                                      |    5 
 net/ethtool/cabletest.c                                   |    8 
 net/ethtool/linkstate.c                                   |   26 +
 net/ethtool/netlink.c                                     |    6 
 net/ethtool/netlink.h                                     |    5 
 net/ethtool/phy.c                                         |    2 
 net/ethtool/plca.c                                        |    6 
 net/ethtool/pse-pd.c                                      |    4 
 net/ethtool/stats.c                                       |   18 +
 net/ethtool/strset.c                                      |    2 
 net/ipv4/tcp_offload.c                                    |   11 
 net/ipv4/udp_offload.c                                    |    8 
 net/ipv6/ila/ila_lwt.c                                    |    4 
 net/llc/llc_s_ac.c                                        |   49 +--
 net/mac80211/ieee80211_i.h                                |    2 
 net/mac80211/mlme.c                                       |    1 
 net/mac80211/parse.c                                      |  164 ++++++++---
 net/mptcp/pm_netlink.c                                    |   18 +
 net/wireless/nl80211.c                                    |    5 
 net/wireless/reg.c                                        |    3 
 rust/kernel/block/mq/gen_disk.rs                          |    6 
 sound/core/seq/seq_clientmgr.c                            |   46 ++-
 sound/pci/hda/Kconfig                                     |    1 
 sound/pci/hda/hda_intel.c                                 |    2 
 sound/pci/hda/patch_realtek.c                             |  107 ++++++-
 sound/usb/usx2y/usbusx2y.c                                |   11 
 sound/usb/usx2y/usbusx2y.h                                |   26 +
 sound/usb/usx2y/usbusx2yaudio.c                           |   27 -
 tools/testing/selftests/damon/damon_nr_regions.py         |    2 
 tools/testing/selftests/damon/damos_quota.py              |    9 
 tools/testing/selftests/damon/damos_quota_goal.py         |    3 
 tools/testing/selftests/mm/hugepage-mremap.c              |    2 
 tools/testing/selftests/mm/ksm_functional_tests.c         |    8 
 tools/testing/selftests/mm/memfd_secret.c                 |   14 
 tools/testing/selftests/mm/mkdirty.c                      |    8 
 tools/testing/selftests/mm/mlock2.h                       |    1 
 tools/testing/selftests/mm/protection_keys.c              |    2 
 tools/testing/selftests/mm/uffd-common.c                  |    4 
 tools/testing/selftests/mm/uffd-stress.c                  |   15 -
 tools/testing/selftests/mm/uffd-unit-tests.c              |   14 
 usr/include/Makefile                                      |    2 
 239 files changed, 2390 insertions(+), 1068 deletions(-)

Ahmed S. Darwish (3):
      x86/cacheinfo: Validate CPUID leaf 0x2 EDX output
      x86/cpu: Validate CPUID leaf 0x2 EDX output
      x86/cpu: Properly parse CPUID leaf 0x2 TLB descriptor 0x63

Alessio Belle (1):
      drm/imagination: Fix timestamps in firmware traces

Alexander Shishkin (2):
      intel_th: pci: Add Panther Lake-H support
      intel_th: pci: Add Panther Lake-P/U support

Alexander Usyskin (1):
      mei: me: add panther lake P DID

Andrei Kuchynski (1):
      usb: typec: ucsi: Fix NULL pointer access

Andrew Cooper (1):
      x86/amd_nb: Use rdmsr_safe() in amd_get_mmconfig_range()

Andrew Martin (1):
      drm/amdkfd: Fix NULL Pointer Dereference in KFD queue

Andy Shevchenko (1):
      eeprom: digsy_mtc: Make GPIO lookup table match the device

Angelo Dureghello (3):
      iio: dac: ad3552r: clear reset status flag
      dt-bindings: iio: dac: adi-axi-adc: fix ad7606 pwm-names
      iio: adc: ad7606: fix wrong scale available

AngeloGioacchino Del Regno (1):
      usb: typec: tcpci_rt1711h: Unmask alert interrupts to fix functionality

Antheas Kapenekakis (1):
      ALSA: hda/realtek: Remove (revert) duplicate Ally X config

Antoine Tenart (1):
      net: gso: fix ownership in __udp_gso_segment

Ard Biesheuvel (1):
      x86/boot: Sanitize boot params before parsing command line

Arnd Bergmann (2):
      kbuild: hdrcheck: fix cross build with clang
      ALSA: hda: realtek: fix incorrect IS_REACHABLE() usage

Badhri Jagan Sridharan (1):
      usb: dwc3: gadget: Prevent irq storm when TH re-executes

Benjamin Berg (1):
      wifi: iwlwifi: mvm: log error for failures after D3

Bibo Mao (5):
      LoongArch: Set hugetlb mmap base address aligned with pmd size
      LoongArch: Set max_pfn with the PFN of the last page
      LoongArch: KVM: Add interrupt checking for AVEC
      LoongArch: KVM: Reload guest CSR registers after sleep
      LoongArch: KVM: Fix GPA size issue about VM

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Add some forgotten models to the SHA check

Brendan King (3):
      drm/imagination: avoid deadlock on fence release
      drm/imagination: Hold drm_gem_gpuva lock for unmap
      drm/imagination: only init job done fences once

Brian Geffon (1):
      mm: fix finish_fault() handling for large folios

Christian A. Ehrhardt (1):
      acpi: typec: ucsi: Introduce a ->poll_cci method

Christian Brauner (1):
      cred: return old creds from revert_creds_light()

Christian Heusel (1):
      Revert "drivers/card_reader/rtsx_usb: Restore interrupt based detection"

Claudiu Beznea (3):
      usb: renesas_usbhs: Call clk_put()
      usb: renesas_usbhs: Use devm_usb_get_phy()
      usb: renesas_usbhs: Flush the notify_hotplug_work

Dan Carpenter (1):
      nvme-tcp: fix signedness bug in nvme_tcp_init_connection()

Daniil Dulov (1):
      HID: appleir: Fix potential NULL dereference at raw event handle

Dave Airlie (1):
      drm/nouveau: select FW caching

Emmanuel Grumbach (2):
      wifi: iwlwifi: mvm: don't dump the firmware state upon RFKILL while suspend
      wifi: iwlwifi: mvm: don't try to talk to a dead firmware

Eric Dumazet (1):
      llc: do not use skb_get() before dev_queue_xmit()

Eric Sandeen (1):
      exfat: short-circuit zero-byte writes in exfat_file_write_iter

Erik Schumacher (1):
      hwmon: (ad7314) Validate leading zero bits and return error

Fabrizio Castro (1):
      gpio: rcar: Fix missing of_node_put() call

Fedor Pchelkin (1):
      usb: typec: ucsi: increase timeout for PPM reset operations

Gabriel Krisman Bertazi (1):
      Revert "mm/page_alloc.c: don't show protection in zone's ->lowmem_reserve[] for empty zone"

Greg Kroah-Hartman (1):
      Linux 6.13.7

Hans de Goede (1):
      mei: vsc: Use "wakeuphostint" when getting the host wakeup GPIO

Hao Zhang (1):
      mm/page_alloc: fix uninitialized variable

Haoxiang Li (5):
      btrfs: fix a leaked chunk map issue in read_one_chunk()
      Bluetooth: Add check for mgmt_alloc_skb() in mgmt_remote_name()
      Bluetooth: Add check for mgmt_alloc_skb() in mgmt_device_connected()
      rapidio: add check for rio_add_net() in rio_scan_alloc_net()
      rapidio: fix an API misues when rio_add_net() fails

Haoyu Li (1):
      drivers: virt: acrn: hsm: Use kzalloc to avoid info leak in pmcmd_ioctl

Heiko Carstens (1):
      s390/traps: Fix test_monitor_call() inline assembly

Herbert Xu (1):
      cred: Fix RCU warnings in override/revert_creds

Hoku Ishibe (1):
      ALSA: hda: intel: Add Dell ALC3271 to power_save denylist

Huacai Chen (1):
      LoongArch: Use polling play_dead() when resuming from hibernation

Ilan Peer (4):
      wifi: iwlwifi: Free pages allocated when failing to build A-MSDU
      wifi: iwlwifi: Fix A-MSDU TSO preparation
      wifi: mac80211: Support parsing EPCS ML element
      wifi: iwlwifi: pcie: Fix TSO preparation

Jakub Kicinski (1):
      net: ethtool: plumb PHY stats to PHY drivers

Jarkko Sakkinen (1):
      x86/sgx: Fix size overflows in sgx_encl_create()

Jason Xing (1):
      net-timestamp: support TCP GSO case for a few missing flags

Javier Carrasco (1):
      iio: light: apds9306: fix max_scale_nano values

Jiayuan Chen (1):
      ppp: Fix KMSAN uninit-value warning with bpf

Johannes Berg (4):
      wifi: iwlwifi: mvm: clean up ROC on failure
      wifi: iwlwifi: limit printed string from FW file
      wifi: mac80211: fix MLE non-inheritance parsing
      wifi: mac80211: fix vendor-specific inheritance

John Hubbard (1):
      Revert "selftests/mm: remove local __NR_* definitions"

Justin Iurman (2):
      net: ipv6: fix dst ref loop in ila lwtunnel
      net: ipv6: fix missing dst ref drop in ila lwtunnel

Kailang Yang (2):
      ALSA: hda/realtek - add supported Mic Mute LED for Lenovo platform
      ALSA: hda/realtek: update ALC222 depop optimize

Kees Cook (1):
      coredump: Only sort VMAs when core_sort_vma sysctl is set

Keith Busch (1):
      nvme-ioctl: fix leaked requests on mapping error

Kenneth Feng (1):
      drm/amd/pm: always allow ih interrupt from fw

Koichiro Den (1):
      gpio: aggregator: protect driver attr handlers against module unload

Krister Johansen (1):
      mptcp: fix 'scheduling while atomic' in mptcp_pm_nl_append_new_local_addr

Lorenzo Bianconi (1):
      net: dsa: mt7530: Fix traffic flooding for MMIO devices

Lorenzo Stoakes (1):
      mm: abort vma_modify() on merge out of memory failure

Luca Ceresoli (1):
      drivers: core: fix device leak in __fw_devlink_relax_cycles()

Luca Weiss (3):
      net: ipa: Fix v4.7 resource group names
      net: ipa: Fix QSB data for v4.7
      net: ipa: Enable checksum for IPA_ENDPOINT_AP_MODEM_{RX,TX} for v4.7

Ma Ke (1):
      drm/amd/display: Fix null check for pipe_ctx->plane_state in resource_build_scaling_params

Ma Wupeng (3):
      mm: memory-failure: update ttu flag inside unmap_poisoned_folio
      hwpoison, memory_hotplug: lock folio before unmap hwpoisoned folio
      mm: memory-hotplug: check folio ref count first in do_migrate_range

Maarten Lankhorst (1):
      drm/xe: Remove double pageflip

Manivannan Sadhasivam (1):
      bus: mhi: host: pci_generic: Use pci_try_reset_function() to avoid deadlock

Marc Zyngier (1):
      xhci: Restrict USB4 tunnel detection for USB3 devices to Intel hosts

Marek Szyprowski (1):
      usb: gadget: Fix setting self-powered state on suspend

Markus Burri (1):
      iio: adc: ad7192: fix channel select

Masami Hiramatsu (Google) (3):
      tracing: tprobe-events: Fix a memory leak when tprobe with $retval
      tracing: tprobe-events: Reject invalid tracepoint name
      tracing: probe-events: Remove unused MAX_ARG_BUF_LEN macro

Matt Johnston (1):
      mctp i3c: handle NULL header address

Matthew Auld (1):
      drm/xe/userptr: properly setup pfn_flags_mask

Matthew Brost (1):
      drm/xe: Add staging tree for VM binds

Maud Spierings (1):
      hwmon: (ntc_thermistor) Fix the ncpXXxh103 sensor table

Maurizio Lombardi (4):
      nvmet: remove old function prototype
      nvme-tcp: add basic support for the C2HTermReq PDU
      nvme-tcp: fix potential memory corruption in nvme_tcp_recv_pdu()
      nvme-tcp: Fix a C2HTermReq error message

Maxime Chevallier (1):
      net: ethtool: netlink: Allow NULL nlattrs when getting a phy_device

Meir Elisha (1):
      nvmet-tcp: Fix a possible sporadic response drops in weakly ordered arch

Miao Li (1):
      usb: quirks: Add DELAY_INIT and NO_LPM for Prolific Mass Storage Card Reader

Michal Pecio (2):
      usb: xhci: Fix host controllers "dying" after suspend and resume
      usb: xhci: Enable the TRB overfetch quirk on VIA VL805

Mike Snitzer (1):
      NFS: fix nfs_release_folio() to not deadlock via kcompactd writeback

Mingcong Bai (1):
      platform/x86: thinkpad_acpi: Add battery quirk for ThinkPad X131e

Miri Korenblit (1):
      wifi: iwlwifi: fw: avoid using an uninitialized variable

Murad Masimov (1):
      ALSA: usx2y: validate nrpacks module parameter on probe

Namjae Jeon (5):
      ksmbd: fix type confusion via race condition when using ipc_msg_send_request
      ksmbd: fix out-of-bounds in parse_sec_desc()
      ksmbd: fix use-after-free in smb2_lock
      ksmbd: fix bug on trap in smb2_lock
      exfat: fix soft lockup in exfat_clear_bitmap

Naohiro Aota (1):
      btrfs: zoned: fix extent range end unlock in cow_file_range()

Nayab Sayed (1):
      iio: adc: at91-sama5d2_adc: fix sama7g5 realbits value

Nikita Zhandarovich (2):
      wifi: cfg80211: regulatory: improve invalid hints checking
      usb: atm: cxacru: fix a flaw in existing endpoint checks

Niklas Söderlund (1):
      gpio: rcar: Use raw_spinlock to protect register access

Nikolay Aleksandrov (1):
      be2net: fix sleeping while atomic bugs in be_ndo_bridge_getlink

Nikunj A Dadhania (1):
      virt: sev-guest: Allocate request data dynamically

Oleksij Rempel (1):
      ethtool: linkstate: migrate linkstate functions to support multi-PHY setups

Olivier Gayot (1):
      block: fix conversion of GPT partition name to 7-bit

Oscar Maes (1):
      vlan: enforce underlying device type

Pali Rohár (1):
      cifs: Remove symlink member from cifs_open_info_data union

Paul Fertser (1):
      hwmon: (peci/dimmtemp) Do not provide fake thresholds data

Pawel Chmielewski (1):
      intel_th: pci: Add Arrow Lake support

Pawel Laszczak (1):
      usb: hub: lack of clearing xHC resources

Peiyang Wang (1):
      net: hns3: make sure ptp clock is unregister and freed if hclge_ptp_get_cycle returns an error

Peter Zijlstra (2):
      loongarch: Use ASM_REACHABLE
      perf/core: Fix pmus_lock vs. pmus_srcu ordering

Philipp Stanner (2):
      stmmac: loongson: Pass correct arg to PCI function
      drm/sched: Fix preprocessor guard

Prashanth K (3):
      usb: gadget: u_ether: Set is_suspend flag if remote wakeup fails
      usb: gadget: Set self-powered based on MaxPower and bmAttributes
      usb: gadget: Check bmAttributes only if configuration is valid

Qi Zheng (1):
      arm: pgtable: fix NULL pointer dereference issue

Qiu-ji Chen (1):
      cdx: Fix possible UAF error in driver_override_show()

Ricardo Ribalda (1):
      iio: hid-sensor-prox: Split difference from multiple channels

Richard Thier (1):
      drm/radeon: Fix rs400_gpu_init for ATI mobility radeon Xpress 200M

Rob Herring (Arm) (1):
      Revert "of: reserved-memory: Fix using wrong number of cells to get property 'alignment'"

Ryan Roberts (3):
      mm: don't skip arch_sync_kernel_mappings() in error paths
      mm: hugetlb: Add huge page size param to huge_ptep_get_and_clear()
      arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes

Salah Triki (1):
      bluetooth: btusb: Initialize .owner field of force_poll_sync_fops

Sam Winchenbach (1):
      iio: filter: admv8818: Force initialization of SDO

Sean Christopherson (7):
      KVM: SVM: Set RFLAGS.IF=1 in C code, to get VMRUN out of the STI shadow
      KVM: SVM: Save host DR masks on CPUs with DebugSwap
      KVM: SVM: Drop DEBUGCTL[5:2] from guest's effective value
      KVM: SVM: Suppress DEBUGCTL.BTF on AMD
      KVM: x86: Snapshot the host's DEBUGCTL in common x86
      KVM: SVM: Manually context switch DEBUGCTL if LBR virtualization is disabled
      KVM: x86: Snapshot the host's DEBUGCTL after disabling IRQs

Sebastian Andrzej Siewior (1):
      dma: kmsan: export kmsan_handle_dma() for modules

SeongJae Park (4):
      selftests/damon/damos_quota_goal: handle minimum quota that cannot be further reduced
      selftests/damon/damos_quota: make real expectation of quota exceeds
      selftests/damon/damon_nr_regions: set ops update for merge results check to 100ms
      selftests/damon/damon_nr_regions: sort collected regiosn before checking with min/max boundaries

Steve French (1):
      smb311: failure to open files of length 1040 when mounting with SMB3.1.1 POSIX extensions

Stuart Hayhurst (1):
      HID: corsair-void: Update power supply values with a unified work handler

Suren Baghdasaryan (1):
      userfaultfd: do not block on locking a large folio with raised refcount

Takashi Iwai (2):
      ALSA: seq: Avoid module auto-load handling at event delivery
      drm/bochs: Fix DPMS regression

Thadeu Lima de Souza Cascardo (1):
      char: misc: deallocate static minor in error path

Thinh Nguyen (1):
      usb: dwc3: Set SUSPENDENABLE soon after phy init

Thomas Hellström (6):
      drm/xe/hmm: Style- and include fixes
      drm/xe/hmm: Don't dereference struct page pointers without notifier lock
      drm/xe/vm: Fix a misplaced #endif
      drm/xe/vm: Validate userptr during gpu vma prefetching
      drm/xe: Fix fault mode invalidation with unbind
      drm/xe/userptr: Unmap userptrs in the mmu notifier

Thomas Weißschuh (1):
      kbuild: userprogs: use correct lld when linking through clang

Tiezhu Yang (1):
      LoongArch: Convert unreachable() to BUG()

Titus Rwantare (1):
      hwmon: (pmbus) Initialise page count in pmbus_identify()

Tvrtko Ursulin (1):
      drm/xe: Fix GT "for each engine" workarounds

Uday Shankar (1):
      ublk: set_params: properly check if parameters can be applied

Vicki Pfau (1):
      HID: hid-steam: Fix use-after-free when detaching device

Visweswara Tanuku (1):
      slimbus: messaging: Free transaction ID in delayed interrupt scenario

Vitaliy Shevtsov (2):
      wifi: nl80211: reject cooked mode if it is set along with other flags
      caif_virtio: fix wrong pointer check in cfv_probe()

Xiaoyao Li (1):
      KVM: x86: Explicitly zero EAX and EBX when PERFMON_V2 isn't supported by KVM

Xinghuo Chen (1):
      hwmon: fix a NULL vs IS_ERR_OR_NULL() check in xgene_hwmon_probe()

Yu-Chun Lin (1):
      HID: google: fix unused variable warning under !CONFIG_ACPI

Yuezhang Mo (1):
      exfat: fix just enough dentries but allocate a new cluster to dir

Yutaro Ohno (1):
      rust: block: fix formatting in GenDisk doc

Zecheng Li (1):
      sched/fair: Fix potential memory corruption in child_cfs_rq_on_list

Zhang Lixu (2):
      HID: intel-ish-hid: Fix use-after-free issue in hid_ishtp_cl_remove()
      HID: intel-ish-hid: Fix use-after-free issue in ishtp_hid_remove()


