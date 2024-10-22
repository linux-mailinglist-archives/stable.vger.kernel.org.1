Return-Path: <stable+bounces-87739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B899AB139
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 16:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE97D1C227F8
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F2E1A3BC3;
	Tue, 22 Oct 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qKQq6byW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719E81A2630;
	Tue, 22 Oct 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608363; cv=none; b=dprny85IHaz0seAB4oBfe442HwTZ9BoBx3+AVUdAia2iCHL6JsrMdtSHsebNVT/dCNhQir6/OlOkfbdW0CU2cLFgowxoDKXcsVn4CISBktDLHdvsbhH12FoGxgrlIRqTRKzZx2fx+6yfNIrccsLPZ2YFL31yg81in/Nsd9H9zhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608363; c=relaxed/simple;
	bh=wszLduClCPjWMRt7+dfd+Lw+HZ2n8N8Nn/Xwa0fOBjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TnHb4O4b1doaFH/uA38ycHjORvPlZN7KfkK93xOCSGghm73Hf/jjNC5rRqEOpJRt1lJ1woTzLYyjPWlXMy8Ic4pw5QQ501rlYGi2rHEZzxWe/nQtL3sQ4m1x7KJrND5RU1q+uVpXPjk9n3XXd/UixRX9GyDntEEtsdVUaU0aTUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qKQq6byW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BDEC4CEC3;
	Tue, 22 Oct 2024 14:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729608363;
	bh=wszLduClCPjWMRt7+dfd+Lw+HZ2n8N8Nn/Xwa0fOBjc=;
	h=From:To:Cc:Subject:Date:From;
	b=qKQq6byWEXfMAkyDS0o/do1QEx1zeYWZk7tckDiLEvZs98q3STsudN3Yt78wfdBQ2
	 yWqK9caMoObcu+8TK0ozUB57oz4CGjPMikZqUg433TC0+H0THXTnvZnndZu5PnEgB0
	 FlRcumEcSNsPnZJmmUNP2QEcoQpUB6WxMYGGA4dc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.114
Date: Tue, 22 Oct 2024 16:45:47 +0200
Message-ID: <2024102248-reps-broaden-3e4a@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.114 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                            |    2 
 arch/arm64/kernel/probes/decode-insn.c              |   16 
 arch/arm64/kernel/probes/simulate-insn.c            |   18 
 arch/s390/kvm/diag.c                                |    2 
 arch/s390/kvm/gaccess.c                             |    4 
 arch/s390/kvm/gaccess.h                             |   14 
 arch/x86/entry/entry.S                              |    5 
 arch/x86/entry/entry_32.S                           |    6 
 arch/x86/include/asm/cpufeatures.h                  |    4 
 arch/x86/kernel/apic/apic.c                         |   14 
 arch/x86/kernel/cpu/bugs.c                          |   32 
 arch/x86/kernel/cpu/common.c                        |    3 
 arch/x86/kernel/cpu/resctrl/core.c                  |    4 
 block/blk-rq-qos.c                                  |    2 
 drivers/bluetooth/btusb.c                           |   13 
 drivers/crypto/vmx/Makefile                         |   12 
 drivers/crypto/vmx/ppc-xlate.pl                     |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c              |    2 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c           |    6 
 drivers/gpu/drm/drm_gem_shmem_helper.c              |    3 
 drivers/gpu/drm/radeon/radeon_encoders.c            |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                 |    1 
 drivers/iio/adc/Kconfig                             |    4 
 drivers/iio/amplifiers/Kconfig                      |    1 
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c |    2 
 drivers/iio/dac/Kconfig                             |    7 
 drivers/iio/light/opt3001.c                         |    4 
 drivers/iio/light/veml6030.c                        |    5 
 drivers/iio/proximity/Kconfig                       |    2 
 drivers/iommu/intel/iommu.c                         |    4 
 drivers/irqchip/irq-gic-v3-its.c                    |   26 
 drivers/irqchip/irq-sifive-plic.c                   |   21 
 drivers/net/ethernet/cadence/macb_main.c            |   14 
 drivers/net/ethernet/freescale/enetc/enetc.c        |    2 
 drivers/parport/procfs.c                            |   22 
 drivers/pinctrl/pinctrl-apple-gpio.c                |    3 
 drivers/pinctrl/pinctrl-ocelot.c                    |    8 
 drivers/s390/char/sclp.c                            |    3 
 drivers/s390/char/sclp_vt220.c                      |    4 
 drivers/tty/n_gsm.c                                 |    2 
 drivers/ufs/core/ufshcd.c                           |    4 
 drivers/usb/dwc3/gadget.c                           |   10 
 drivers/usb/host/xhci-ring.c                        |    2 
 drivers/usb/host/xhci.h                             |    2 
 drivers/usb/serial/option.c                         |    8 
 fs/btrfs/tree-log.c                                 |    6 
 fs/fat/namei_vfat.c                                 |    2 
 fs/nilfs2/dir.c                                     |   50 
 fs/nilfs2/namei.c                                   |   39 
 fs/nilfs2/nilfs.h                                   |    2 
 fs/smb/server/mgmt/user_session.c                   |   26 
 fs/smb/server/mgmt/user_session.h                   |    4 
 fs/smb/server/server.c                              |    2 
 fs/smb/server/smb2pdu.c                             |    8 
 fs/udf/dir.c                                        |  148 --
 fs/udf/directory.c                                  |  570 ++++++++--
 fs/udf/inode.c                                      |   90 -
 fs/udf/namei.c                                      | 1049 ++++++--------------
 fs/udf/udfdecl.h                                    |   45 
 include/linux/fsl/enetc_mdio.h                      |    3 
 include/linux/irqchip/arm-gic-v4.h                  |    4 
 io_uring/io_uring.h                                 |    9 
 kernel/time/posix-clock.c                           |    3 
 lib/maple_tree.c                                    |   12 
 mm/swapfile.c                                       |    2 
 net/bluetooth/af_bluetooth.c                        |    3 
 net/bluetooth/iso.c                                 |    6 
 net/devlink/leftover.c                              |   40 
 net/ipv4/tcp_output.c                               |    4 
 net/mptcp/mib.c                                     |    1 
 net/mptcp/mib.h                                     |    1 
 net/mptcp/pm_netlink.c                              |    3 
 net/mptcp/protocol.h                                |    1 
 net/mptcp/subflow.c                                 |   11 
 sound/pci/hda/patch_conexant.c                      |   19 
 75 files changed, 1235 insertions(+), 1263 deletions(-)

Aaron Thompson (3):
      Bluetooth: Call iso_exit() on module unload
      Bluetooth: Remove debugfs directory on module init failure
      Bluetooth: ISO: Fix multiple init when debugfs is disabled

Alex Deucher (1):
      drm/amdgpu/swsmu: Only force workload setup on init

Benjamin B. Frost (1):
      USB: serial: option: add support for Quectel EG916Q-GL

Christophe JAILLET (1):
      iio: hid-sensors: Fix an error handling path in _hid_sensor_set_report_latency()

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 MBIM compositions

Emil Gedenryd (1):
      iio: light: opt3001: add missing full-scale range value

Greg Kroah-Hartman (1):
      Linux 6.1.114

Jakub Kicinski (2):
      devlink: drop the filter argument from devlinks_xa_find_get
      devlink: bump the instance index directly when iterating

Jan Kara (21):
      udf: New directory iteration code
      udf: Convert udf_expand_dir_adinicb() to new directory iteration
      udf: Move udf_expand_dir_adinicb() to its callsite
      udf: Implement searching for directory entry using new iteration code
      udf: Provide function to mark entry as deleted using new directory iteration code
      udf: Convert udf_rename() to new directory iteration code
      udf: Convert udf_readdir() to new directory iteration
      udf: Convert udf_lookup() to use new directory iteration code
      udf: Convert udf_get_parent() to new directory iteration code
      udf: Convert empty_dir() to new directory iteration code
      udf: Convert udf_rmdir() to new directory iteration code
      udf: Convert udf_unlink() to new directory iteration code
      udf: Implement adding of dir entries using new iteration code
      udf: Convert udf_add_nondir() to new directory iteration
      udf: Convert udf_mkdir() to new directory iteration code
      udf: Convert udf_link() to new directory iteration code
      udf: Remove old directory iteration code
      udf: Handle error when expanding directory
      udf: Don't return bh from udf_expand_dir_adinicb()
      udf: Allocate name buffer in directory iterator on heap
      udf: Avoid directory type conversion failure due to ENOMEM

Javier Carrasco (11):
      iio: dac: ad5770r: add missing select REGMAP_SPI in Kconfig
      iio: dac: ltc1660: add missing select REGMAP_SPI in Kconfig
      iio: dac: stm32-dac-core: add missing select REGMAP_MMIO in Kconfig
      iio: adc: ti-ads8688: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: light: veml6030: fix ALS sensor resolution
      iio: light: veml6030: fix IIO device retrieval from embedded device
      iio: amplifiers: ada4250: add missing select REGMAP_SPI in Kconfig
      iio: dac: ad5766: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: proximity: mb1232: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: dac: ad3552r: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ti-ads124s08: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig

Jens Axboe (1):
      io_uring/sqpoll: close race on waiting for sqring entries

Jim Mattson (1):
      x86/cpufeatures: Define X86_FEATURE_AMD_IBPB_RET

Jinjie Ruan (1):
      posix-clock: Fix missing timespec64 check in pc_clock_settime()

Johannes Wikner (4):
      x86/cpufeatures: Add a IBPB_NO_RET BUG flag
      x86/entry: Have entry_ibpb() invalidate return predictions
      x86/bugs: Skip RSB fill at VMEXIT
      x86/bugs: Do not use UNTRAIN_RET with IBPB on entry

Liu Shixin (1):
      mm/swapfile: skip HugeTLB pages for unuse_vma

Longlong Xia (1):
      tty: n_gsm: Fix use-after-free in gsm_cleanup_mux

Lorenzo Stoakes (1):
      maple_tree: correct tree corruption on spanning store

Lu Baolu (1):
      iommu/vt-d: Fix incorrect pci_for_each_dma_alias() for non-PCI devices

Luiz Augusto von Dentz (1):
      Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001

Ma Ke (1):
      pinctrl: apple: check devm_kasprintf() returned value

Marc Zyngier (1):
      irqchip/gic-v4: Don't allow a VMOVP on a dying VPE

Mark Rutland (2):
      arm64: probes: Remove broken LDR (literal) uprobe support
      arm64: probes: Fix simulate_ldr*_literal()

Mathias Nyman (2):
      xhci: Fix incorrect stream context type macro
      xhci: Mitigate failed set dequeue pointer commands

Matthieu Baerts (NGI0) (1):
      mptcp: pm: fix UaF read in mptcp_pm_nl_rm_addr_or_subflow

Michael Mueller (1):
      KVM: s390: Change virtual to physical address access in diag 0x258 handler

Mohammed Anees (1):
      drm/amdgpu: prevent BO_HANDLES error from being overwritten

Nam Cao (1):
      irqchip/sifive-plic: Unmask interrupt in plic_irq_enable()

Namjae Jeon (1):
      ksmbd: fix user-after-free from session log off

Nathan Chancellor (1):
      x86/resctrl: Annotate get_mem_config() functions as __init

Nianyao Tang (1):
      irqchip/gic-v3-its: Fix VSYNC referencing an unmapped VPE on GIC v4.1

Nicholas Piggin (1):
      powerpc/64: Add big-endian ELFv2 flavour to crypto VMX asm generation

Nico Boehr (1):
      KVM: s390: gaccess: Check if guest address is in memslot

Nikolay Kuratov (1):
      drm/vmwgfx: Handle surface check failure correctly

OGAWA Hirofumi (1):
      fat: fix uninitialized variable

Oleksij Rempel (1):
      net: macb: Avoid 20s boot delay by skipping MDIO bus registration for fixed-link PHY

Omar Sandoval (1):
      blk-rq-qos: fix crash on rq_qos_wait vs. rq_qos_wake_function race

Paolo Abeni (2):
      tcp: fix mptcp DSS corruption due to large pmtu xmit
      mptcp: prevent MPC handshake on port-based signal endpoints

Pawan Gupta (2):
      x86/entry_32: Do not clobber user EFLAGS.ZF
      x86/entry_32: Clear CPU buffers after register restore in NMI return

Prashanth K (1):
      usb: dwc3: Wait for EndXfer completion before restoring GUSB2PHYCFG

Roi Martin (2):
      btrfs: fix uninitialized pointer free in add_inode_ref()
      btrfs: fix uninitialized pointer free on read_alloc_one_name() error

Ryusuke Konishi (1):
      nilfs2: propagate directory read errors from nilfs_find_entry()

Sergey Matsievskiy (1):
      pinctrl: ocelot: fix system hang on level based interrupts

Seunghwan Baek (1):
      scsi: ufs: core: Set SDEV_OFFLINE when UFS is shut down

Takashi Iwai (1):
      parport: Proper fix for array out-of-bounds access

Thomas Weißschuh (2):
      s390/sclp: Deactivate sclp after all its users
      s390/sclp_vt220: Convert newlines to CRLF instead of LFCR

Vasiliy Kovalev (2):
      ALSA: hda/conexant - Fix audio routing for HP EliteOne 1000 G2
      ALSA: hda/conexant - Use cached pin control for Node 0x1d on HP EliteOne 1000 G2

Ville Syrjälä (1):
      drm/radeon: Fix encoder->possible_clones

Wachowski, Karol (1):
      drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE, MAP_PRIVATE)

Wei Fang (2):
      net: enetc: remove xdp_drops statistic from enetc_xdp_drop()
      net: enetc: add missing static descriptor and inline keyword

Zhang Rui (1):
      x86/apic: Always explicitly disarm TSC-deadline timer


