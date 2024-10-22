Return-Path: <stable+bounces-87734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5949AB12A
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 16:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682342845FA
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D4419D089;
	Tue, 22 Oct 2024 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GQS6Ee3x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07FD7DA7C;
	Tue, 22 Oct 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608335; cv=none; b=S7OahKHBl/czY0inWqUhICBYv4v6UkNlsEMjQR4h7+4Qvc3TTly2+c8Mat+xLpnQRW4VV6Mv3FKMGdo7BARTW0dcX//+ph3hesIsqVVz4/rqBiKr9VFMxqIRBmBZLZglT6xvkRuyGgUD2ns+zaXoVzptMa6P51B/5M7NhjFsGT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608335; c=relaxed/simple;
	bh=8dw1hiQ0u7Oy3sa4M/iR3fwXrom58zBKrO67YiZdB0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TIWFpt+eyP7N+ya3yIZEAPqnPtEJpop45R6QNgN0oHibWJZCGVuHzRMLl4vfDTeYlflx96O9YUk4h3wj7MKOS001sFwiloKw2bzKSXUOWcpe5UglNZXbErgAQyytAQT3zgqvyVglSw9HSmKmwlJkXDhvYbz9yOAHe9wffSgHhP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GQS6Ee3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB223C4CEC3;
	Tue, 22 Oct 2024 14:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729608335;
	bh=8dw1hiQ0u7Oy3sa4M/iR3fwXrom58zBKrO67YiZdB0s=;
	h=From:To:Cc:Subject:Date:From;
	b=GQS6Ee3x3kAmacpVuQe4merR4RFkr9/tYoEvzIQURJYHNpaDijjEOwR8XvfpH+A+5
	 XLWgE/F+N885gmc0Ltcexo1TXoy0Md1bBU+wmHp8UH43huqEaRpBr83GE9xJGIHFbZ
	 gLJhplZ2FY7aDLxJxiy1eACbGbVBOJdKYZuLbOmA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.228
Date: Tue, 22 Oct 2024 16:45:30 +0200
Message-ID: <2024102230-surpass-uncloak-e888@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.228 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                            |    2 
 arch/arm64/kernel/probes/decode-insn.c              |   16 ++++--
 arch/arm64/kernel/probes/simulate-insn.c            |   18 ++-----
 arch/powerpc/mm/numa.c                              |    6 +-
 arch/s390/kvm/diag.c                                |    2 
 arch/x86/entry/entry.S                              |    5 ++
 arch/x86/entry/entry_32.S                           |    6 +-
 arch/x86/include/asm/cpufeatures.h                  |    5 +-
 arch/x86/kernel/apic/apic.c                         |   14 +++++
 arch/x86/kernel/cpu/bugs.c                          |   32 ++++++++++++
 arch/x86/kernel/cpu/common.c                        |    3 +
 arch/x86/kernel/cpu/resctrl/core.c                  |    4 -
 block/blk-rq-qos.c                                  |    2 
 drivers/bluetooth/btusb.c                           |   13 +++--
 drivers/gpu/drm/radeon/radeon_encoders.c            |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                 |    1 
 drivers/iio/adc/Kconfig                             |    4 +
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c |    2 
 drivers/iio/dac/Kconfig                             |    3 +
 drivers/iio/light/opt3001.c                         |    4 +
 drivers/iio/light/veml6030.c                        |    5 --
 drivers/iio/proximity/Kconfig                       |    2 
 drivers/irqchip/irq-gic-v3-its.c                    |   26 +++++++---
 drivers/net/ethernet/cadence/macb_main.c            |   14 ++++-
 drivers/parport/procfs.c                            |   22 ++++----
 drivers/s390/char/sclp_vt220.c                      |    4 -
 drivers/usb/host/xhci.h                             |    2 
 drivers/usb/serial/option.c                         |    8 +++
 fs/fat/namei_vfat.c                                 |    2 
 fs/nilfs2/dir.c                                     |   50 ++++++++++----------
 fs/nilfs2/namei.c                                   |   39 ++++++++++-----
 fs/nilfs2/nilfs.h                                   |    2 
 include/linux/fsl/enetc_mdio.h                      |    3 -
 include/linux/irqchip/arm-gic-v4.h                  |    4 +
 io_uring/io_uring.c                                 |   21 ++++++++
 kernel/time/posix-clock.c                           |    3 +
 mm/swapfile.c                                       |    2 
 net/bluetooth/af_bluetooth.c                        |    1 
 net/ipv4/tcp_output.c                               |    2 
 net/mac80211/cfg.c                                  |    3 +
 net/mac80211/key.c                                  |    2 
 net/mptcp/mib.c                                     |    2 
 net/mptcp/mib.h                                     |    2 
 net/mptcp/protocol.c                                |   26 ++++++++--
 net/mptcp/protocol.h                                |    1 
 net/mptcp/subflow.c                                 |    3 -
 sound/pci/hda/patch_conexant.c                      |   19 +++++++
 virt/kvm/kvm_main.c                                 |    5 +-
 48 files changed, 307 insertions(+), 112 deletions(-)

Aaron Thompson (1):
      Bluetooth: Remove debugfs directory on module init failure

Aneesh Kumar K.V (1):
      powerpc/mm: Always update max/min_low_pfn in mem_topology_setup()

Benjamin B. Frost (1):
      USB: serial: option: add support for Quectel EG916Q-GL

Breno Leitao (1):
      KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu_on_spin()

Christophe JAILLET (1):
      iio: hid-sensors: Fix an error handling path in _hid_sensor_set_report_latency()

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 MBIM compositions

Emil Gedenryd (1):
      iio: light: opt3001: add missing full-scale range value

Felix Moessbauer (2):
      io_uring/sqpoll: do not allow pinning outside of cpuset
      io_uring/sqpoll: do not put cpumask on stack

Geliang Tang (1):
      mptcp: track and update contiguous data status

Greg Kroah-Hartman (1):
      Linux 5.10.228

Javier Carrasco (8):
      iio: dac: ad5770r: add missing select REGMAP_SPI in Kconfig
      iio: dac: ltc1660: add missing select REGMAP_SPI in Kconfig
      iio: dac: stm32-dac-core: add missing select REGMAP_MMIO in Kconfig
      iio: adc: ti-ads8688: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: light: veml6030: fix ALS sensor resolution
      iio: light: veml6030: fix IIO device retrieval from embedded device
      iio: proximity: mb1232: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ti-ads124s08: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig

Jens Axboe (2):
      io_uring/sqpoll: retain test for whether the CPU is valid
      io_uring/sqpoll: close race on waiting for sqring entries

Jim Mattson (1):
      x86/cpufeatures: Define X86_FEATURE_AMD_IBPB_RET

Jinjie Ruan (1):
      posix-clock: Fix missing timespec64 check in pc_clock_settime()

Johannes Berg (1):
      wifi: mac80211: fix potential key use-after-free

Johannes Wikner (4):
      x86/cpufeatures: Add a IBPB_NO_RET BUG flag
      x86/entry: Have entry_ibpb() invalidate return predictions
      x86/bugs: Skip RSB fill at VMEXIT
      x86/bugs: Do not use UNTRAIN_RET with IBPB on entry

Liu Shixin (1):
      mm/swapfile: skip HugeTLB pages for unuse_vma

Luiz Augusto von Dentz (1):
      Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001

Marc Zyngier (1):
      irqchip/gic-v4: Don't allow a VMOVP on a dying VPE

Mark Rutland (2):
      arm64: probes: Remove broken LDR (literal) uprobe support
      arm64: probes: Fix simulate_ldr*_literal()

Mathias Nyman (1):
      xhci: Fix incorrect stream context type macro

Michael Mueller (1):
      KVM: s390: Change virtual to physical address access in diag 0x258 handler

Nathan Chancellor (1):
      x86/resctrl: Annotate get_mem_config() functions as __init

Nianyao Tang (1):
      irqchip/gic-v3-its: Fix VSYNC referencing an unmapped VPE on GIC v4.1

Nikolay Kuratov (1):
      drm/vmwgfx: Handle surface check failure correctly

OGAWA Hirofumi (1):
      fat: fix uninitialized variable

Oleksij Rempel (1):
      net: macb: Avoid 20s boot delay by skipping MDIO bus registration for fixed-link PHY

Omar Sandoval (1):
      blk-rq-qos: fix crash on rq_qos_wait vs. rq_qos_wake_function race

Paolo Abeni (2):
      mptcp: handle consistently DSS corruption
      tcp: fix mptcp DSS corruption due to large pmtu xmit

Pawan Gupta (2):
      x86/entry_32: Do not clobber user EFLAGS.ZF
      x86/entry_32: Clear CPU buffers after register restore in NMI return

Ryusuke Konishi (1):
      nilfs2: propagate directory read errors from nilfs_find_entry()

Takashi Iwai (1):
      parport: Proper fix for array out-of-bounds access

Thomas Weißschuh (1):
      s390/sclp_vt220: Convert newlines to CRLF instead of LFCR

Vasiliy Kovalev (2):
      ALSA: hda/conexant - Fix audio routing for HP EliteOne 1000 G2
      ALSA: hda/conexant - Use cached pin control for Node 0x1d on HP EliteOne 1000 G2

Ville Syrjälä (1):
      drm/radeon: Fix encoder->possible_clones

Wei Fang (1):
      net: enetc: add missing static descriptor and inline keyword

Zhang Rui (1):
      x86/apic: Always explicitly disarm TSC-deadline timer


