Return-Path: <stable+bounces-87741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC879AB13F
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 16:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14527B23DA8
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4B81A76B5;
	Tue, 22 Oct 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L42wvIDn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730021A2632;
	Tue, 22 Oct 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608372; cv=none; b=lU9PlL1cGLILpQ+Xh7Mq8WJFIklYGRfaUt45C5R+Zt4i8pJO43fk/6KR7mB2lYXmi841v3MMkW2LV/BMpv/LTE541OtABq16PHAbiDwPCE/zQ0hbQN3rmtUiAo6F/N0xWHCBTB+419eJhYTmGPQOEhbUu2ZSOyrdeVFW7TrUUew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608372; c=relaxed/simple;
	bh=Mq/pA/Y21Qvyp459nZTk2e/SYea9GMQtADdlcq89BQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b8hRTEH+rANiuN/tGeT9Bawi2r0IhOPuO/sBYckVVk2qYVLtJz6MK9/yZQ9eAsZu6ZL0zGIW3+WSjnXwpQn+MFqcoTdiTpZjZXowopavcjEP3TK4vfLmy4877U0iAleNjKjZyWVr4EzoinjTjqCSOHa2xcG7N1hsSnT+zkjH680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L42wvIDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21D6C4CEC3;
	Tue, 22 Oct 2024 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729608372;
	bh=Mq/pA/Y21Qvyp459nZTk2e/SYea9GMQtADdlcq89BQE=;
	h=From:To:Cc:Subject:Date:From;
	b=L42wvIDnI6FgcrQ9Qx6UzlelECwBSplq8My3GMHhtQLYPX1n7ut7xrHAEYV3tXWWN
	 ZCpuD1KdKBk9AaNeyzgtXChEDl/F3HrbKVKYdf2wzttZluIXTKsLCuaLI+Nc1gszT1
	 XLoBC4hDbg9OpgGHYQFRYoaxvQh528wNKexO6cLE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.58
Date: Tue, 22 Oct 2024 16:46:00 +0200
Message-ID: <2024102201-importer-suffice-6564@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.58 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    2 
 arch/arm64/include/asm/uprobes.h                     |    8 -
 arch/arm64/kernel/probes/decode-insn.c               |   16 +-
 arch/arm64/kernel/probes/simulate-insn.c             |   18 --
 arch/arm64/kernel/probes/uprobes.c                   |    4 
 arch/s390/kvm/diag.c                                 |    2 
 arch/s390/kvm/gaccess.c                              |    4 
 arch/s390/kvm/gaccess.h                              |   14 +
 arch/x86/entry/entry.S                               |    5 
 arch/x86/entry/entry_32.S                            |    6 
 arch/x86/include/asm/cpufeatures.h                   |    4 
 arch/x86/include/asm/nospec-branch.h                 |   11 +
 arch/x86/kernel/apic/apic.c                          |   14 +
 arch/x86/kernel/cpu/amd.c                            |    3 
 arch/x86/kernel/cpu/bugs.c                           |   32 ++++
 arch/x86/kernel/cpu/common.c                         |    3 
 arch/x86/kernel/cpu/resctrl/core.c                   |    4 
 block/blk-rq-qos.c                                   |    2 
 drivers/block/ublk_drv.c                             |   11 +
 drivers/bluetooth/btusb.c                            |   13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c               |    2 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            |    6 
 drivers/gpu/drm/radeon/radeon_encoders.c             |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                  |    1 
 drivers/iio/accel/Kconfig                            |    2 
 drivers/iio/adc/Kconfig                              |    5 
 drivers/iio/amplifiers/Kconfig                       |    1 
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c  |    2 
 drivers/iio/dac/Kconfig                              |    7 
 drivers/iio/frequency/Kconfig                        |    1 
 drivers/iio/light/Kconfig                            |    2 
 drivers/iio/light/opt3001.c                          |    4 
 drivers/iio/light/veml6030.c                         |    5 
 drivers/iio/proximity/Kconfig                        |    2 
 drivers/input/joystick/xpad.c                        |    2 
 drivers/iommu/intel/iommu.c                          |    4 
 drivers/irqchip/irq-gic-v3-its.c                     |   26 ++-
 drivers/irqchip/irq-sifive-plic.c                    |   21 +-
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c    |    2 
 drivers/net/ethernet/cadence/macb_main.c             |   14 +
 drivers/net/ethernet/freescale/enetc/enetc.c         |   56 ++++++-
 drivers/net/ethernet/freescale/enetc/enetc.h         |    1 
 drivers/net/ethernet/freescale/fec_ptp.c             |   58 +++-----
 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c |    2 
 drivers/parport/procfs.c                             |   22 +--
 drivers/pinctrl/pinctrl-apple-gpio.c                 |    3 
 drivers/pinctrl/pinctrl-ocelot.c                     |    8 -
 drivers/pinctrl/stm32/pinctrl-stm32.c                |    9 -
 drivers/s390/char/sclp.c                             |    3 
 drivers/s390/char/sclp_vt220.c                       |    4 
 drivers/tty/n_gsm.c                                  |    2 
 drivers/tty/serial/imx.c                             |   15 ++
 drivers/tty/serial/qcom_geni_serial.c                |   90 +++++-------
 drivers/tty/vt/vt.c                                  |    2 
 drivers/ufs/core/ufs-mcq.c                           |   15 +-
 drivers/ufs/core/ufshcd.c                            |    4 
 drivers/usb/dwc3/gadget.c                            |   10 -
 drivers/usb/host/xhci-ring.c                         |    2 
 drivers/usb/host/xhci-tegra.c                        |    2 
 drivers/usb/host/xhci.h                              |    2 
 drivers/usb/serial/option.c                          |    8 +
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c   |    1 
 fs/btrfs/tree-log.c                                  |    6 
 fs/fat/namei_vfat.c                                  |    2 
 fs/nilfs2/dir.c                                      |   50 +++----
 fs/nilfs2/namei.c                                    |   39 +++--
 fs/nilfs2/nilfs.h                                    |    2 
 fs/smb/server/mgmt/user_session.c                    |   26 ++-
 fs/smb/server/mgmt/user_session.h                    |    4 
 fs/smb/server/server.c                               |    2 
 fs/smb/server/smb2pdu.c                              |    8 -
 fs/xfs/libxfs/xfs_attr.c                             |   11 +
 fs/xfs/libxfs/xfs_attr.h                             |    4 
 fs/xfs/libxfs/xfs_attr_leaf.c                        |    6 
 fs/xfs/libxfs/xfs_attr_remote.c                      |    1 
 fs/xfs/libxfs/xfs_bmap.c                             |  130 +++++++++++++++---
 fs/xfs/libxfs/xfs_da_btree.c                         |   20 --
 fs/xfs/libxfs/xfs_da_format.h                        |    5 
 fs/xfs/libxfs/xfs_inode_buf.c                        |   47 +++++-
 fs/xfs/libxfs/xfs_sb.c                               |    7 
 fs/xfs/scrub/attr.c                                  |   47 +++---
 fs/xfs/scrub/common.c                                |   12 -
 fs/xfs/scrub/scrub.h                                 |    7 
 fs/xfs/xfs_aops.c                                    |   54 +------
 fs/xfs/xfs_attr_item.c                               |   98 +++++++++++--
 fs/xfs/xfs_attr_list.c                               |   11 -
 fs/xfs/xfs_bmap_util.c                               |   61 +++++---
 fs/xfs/xfs_bmap_util.h                               |    2 
 fs/xfs/xfs_dquot.c                                   |    1 
 fs/xfs/xfs_icache.c                                  |    2 
 fs/xfs/xfs_inode.c                                   |   37 +++--
 fs/xfs/xfs_iomap.c                                   |   81 ++++++-----
 fs/xfs/xfs_reflink.c                                 |   20 --
 fs/xfs/xfs_rtalloc.c                                 |    2 
 include/linux/fsl/enetc_mdio.h                       |    3 
 include/linux/irqchip/arm-gic-v4.h                   |    4 
 include/uapi/linux/ublk_cmd.h                        |    8 -
 io_uring/io_uring.h                                  |    9 +
 kernel/time/posix-clock.c                            |    3 
 lib/maple_tree.c                                     |   12 -
 mm/mremap.c                                          |   11 +
 mm/swapfile.c                                        |    2 
 mm/vmscan.c                                          |    4 
 net/bluetooth/af_bluetooth.c                         |    3 
 net/bluetooth/iso.c                                  |    6 
 net/ipv4/tcp_output.c                                |    4 
 net/mptcp/mib.c                                      |    1 
 net/mptcp/mib.h                                      |    1 
 net/mptcp/pm_netlink.c                               |    3 
 net/mptcp/protocol.h                                 |    1 
 net/mptcp/subflow.c                                  |   11 +
 sound/pci/hda/patch_conexant.c                       |   19 ++
 tools/testing/selftests/hid/Makefile                 |    1 
 tools/testing/selftests/mm/uffd-common.c             |    5 
 tools/testing/selftests/mm/uffd-common.h             |    3 
 tools/testing/selftests/mm/uffd-unit-tests.c         |   21 ++
 tools/testing/selftests/net/mptcp/mptcp_join.sh      |  135 +++++++++++++------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh       |   11 -
 118 files changed, 1122 insertions(+), 570 deletions(-)

Aaron Thompson (3):
      Bluetooth: Call iso_exit() on module unload
      Bluetooth: Remove debugfs directory on module init failure
      Bluetooth: ISO: Fix multiple init when debugfs is disabled

Alex Deucher (1):
      drm/amdgpu/swsmu: Only force workload setup on init

Benjamin B. Frost (1):
      USB: serial: option: add support for Quectel EG916Q-GL

Christoph Hellwig (4):
      xfs: fix error returns from xfs_bmapi_write
      xfs: fix xfs_bmap_add_extent_delay_real for partial conversions
      xfs: remove a racy if_bytes check in xfs_reflink_end_cow_extent
      xfs: fix freeing speculative preallocations for preallocated files

Christophe JAILLET (1):
      iio: hid-sensors: Fix an error handling path in _hid_sensor_set_report_latency()

Csókás, Bence (2):
      net: fec: Move `fec_ptp_read()` to the top of the file
      net: fec: Remove duplicated code

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 MBIM compositions

Darrick J. Wong (11):
      xfs: require XFS_SB_FEAT_INCOMPAT_LOG_XATTRS for attr log intent item recovery
      xfs: check opcode and iovec count match in xlog_recover_attri_commit_pass2
      xfs: fix missing check for invalid attr flags
      xfs: check shortform attr entry flags specifically
      xfs: validate recovered name buffers when recovering xattr items
      xfs: enforce one namespace per attribute
      xfs: revert commit 44af6c7e59b12
      xfs: use dontcache for grabbing inodes during scrub
      xfs: allow symlinks with short remote targets
      xfs: allow unlinked symlinks and dirs with zero size
      xfs: restrict when we try to align cow fork delalloc to cowextsz hints

Dave Chinner (1):
      xfs: fix unlink vs cluster buffer instantiation race

Edward Liaw (2):
      selftests/mm: replace atomic_bool with pthread_barrier_t
      selftests/mm: fix deadlock for fork after pthread_create on ARM

Emil Gedenryd (1):
      iio: light: opt3001: add missing full-scale range value

Geliang Tang (1):
      selftests: mptcp: join: change capture/checksum as bool

Greg Kroah-Hartman (1):
      Linux 6.6.58

Heiko Thiery (2):
      misc: microchip: pci1xxxx: add support for NVMEM_DEVID_AUTO for EEPROM device
      misc: microchip: pci1xxxx: add support for NVMEM_DEVID_AUTO for OTP device

Henry Lin (1):
      xhci: tegra: fix checked USB2 port number

Jann Horn (1):
      mm/mremap: fix move_normal_pmd/retract_page_tables race

Javier Carrasco (15):
      iio: dac: ad5770r: add missing select REGMAP_SPI in Kconfig
      iio: dac: ltc1660: add missing select REGMAP_SPI in Kconfig
      iio: dac: stm32-dac-core: add missing select REGMAP_MMIO in Kconfig
      iio: adc: ti-ads8688: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: light: veml6030: fix ALS sensor resolution
      iio: light: veml6030: fix IIO device retrieval from embedded device
      iio: amplifiers: ada4250: add missing select REGMAP_SPI in Kconfig
      iio: frequency: adf4377: add missing select REMAP_SPI in Kconfig
      iio: light: bu27008: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: dac: ad5766: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: proximity: mb1232: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: dac: ad3552r: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ti-lmp92064: add missing select REGMAP_SPI in Kconfig
      iio: adc: ti-ads124s08: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: accel: kx022a: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig

Jens Axboe (1):
      io_uring/sqpoll: close race on waiting for sqring entries

Jeongjun Park (1):
      vt: prevent kernel-infoleak in con_font_get()

Jim Mattson (1):
      x86/cpufeatures: Define X86_FEATURE_AMD_IBPB_RET

Jinjie Ruan (2):
      posix-clock: Fix missing timespec64 check in pc_clock_settime()
      net: microchip: vcap api: Fix memory leaks in vcap_api_encode_rule_test()

Johan Hovold (4):
      serial: qcom-geni: fix polled console initialisation
      serial: qcom-geni: revert broken hibernation support
      serial: qcom-geni: fix dma rx cancellation
      serial: qcom-geni: fix receiver enable

Johannes Wikner (4):
      x86/cpufeatures: Add a IBPB_NO_RET BUG flag
      x86/entry: Have entry_ibpb() invalidate return predictions
      x86/bugs: Skip RSB fill at VMEXIT
      x86/bugs: Do not use UNTRAIN_RET with IBPB on entry

John Allen (1):
      x86/CPU/AMD: Only apply Zenbleed fix for Zen2 during late microcode load

John Edwards (1):
      Input: xpad - add support for MSI Claw A1M

Jonathan Marek (1):
      usb: typec: qcom-pmic-typec: fix sink status being overwritten with RP_DEF

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

Ma Ke (2):
      pinctrl: stm32: check devm_kasprintf() returned value
      pinctrl: apple: check devm_kasprintf() returned value

Marc Zyngier (1):
      irqchip/gic-v4: Don't allow a VMOVP on a dying VPE

Marek Vasut (1):
      serial: imx: Update mctrl old_status on RTSD interrupt

Mark Rutland (3):
      arm64: probes: Remove broken LDR (literal) uprobe support
      arm64: probes: Fix simulate_ldr*_literal()
      arm64: probes: Fix uprobes for big-endian kernels

Mathias Nyman (2):
      xhci: Fix incorrect stream context type macro
      xhci: Mitigate failed set dequeue pointer commands

Matthieu Baerts (NGI0) (2):
      mptcp: pm: fix UaF read in mptcp_pm_nl_rm_addr_or_subflow
      selftests: mptcp: remove duplicated variables

Michael Mueller (1):
      KVM: s390: Change virtual to physical address access in diag 0x258 handler

Ming Lei (1):
      ublk: don't allow user copy for unprivileged device

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

Paolo Abeni (3):
      mptcp: prevent MPC handshake on port-based signal endpoints
      tcp: fix mptcp DSS corruption due to large pmtu xmit
      selftests: mptcp: join: test for prohibited MPC to port-based endp

Pawan Gupta (3):
      x86/entry_32: Do not clobber user EFLAGS.ZF
      x86/entry_32: Clear CPU buffers after register restore in NMI return
      x86/bugs: Use code segment selector for VERW operand

Peter Wang (1):
      scsi: ufs: core: Fix the issue of ICU failure

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

Wei Fang (5):
      net: enetc: remove xdp_drops statistic from enetc_xdp_drop()
      net: enetc: block concurrent XDP transmissions during ring reconfiguration
      net: enetc: disable Tx BD rings after they are empty
      net: enetc: disable NAPI after all rings are disabled
      net: enetc: add missing static descriptor and inline keyword

Wei Xu (1):
      mm/mglru: only clear kswapd_failures if reclaimable

Wengang Wang (1):
      xfs: make sure sb_fdblocks is non-negative

Yun Lu (1):
      selftest: hid: add the missing tests directory

Zhang Rui (1):
      x86/apic: Always explicitly disarm TSC-deadline timer

Zhang Yi (4):
      xfs: match lock mode in xfs_buffered_write_iomap_begin()
      xfs: make the seq argument to xfs_bmapi_convert_delalloc() optional
      xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
      xfs: convert delayed extents to unwritten when zeroing post eof blocks


