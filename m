Return-Path: <stable+bounces-87743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394E39AB146
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 16:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E64B24511
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9718A1A302E;
	Tue, 22 Oct 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VgHvqjwq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4A1A262A;
	Tue, 22 Oct 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608380; cv=none; b=QTu0GY0GMvYP5KV+N8GhRCKqMhijMIeMDtfVVErx7H3lkrrOK42FLCqnZ3AoCnhG9oCDzUAktNWeGaIfAQDHmk7tK3DlyAMPmnF3P5BG4PDVLT7sBsVXwvalITcMfhgR5SY3GS1X2/VMzem353DHG0j07Zs6Iw6PEZJwnknLDsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608380; c=relaxed/simple;
	bh=bvJct0mJ5ta5ZqRYy2p54JwF5TkkxvU990r7AjbCCC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pwZsbKmBqQxFbnu2lfqFHfsyXZYGB1GgqRrtTQ1uCuPqCrKk6NLB836krBn7HMn6WsGKTkbw8YT4VHlnC5yw18s3YvaXHUICe05uo1K2J+kCs0MAd0H6lEN/pgtjf+yLs6HS7Cfsl/Cqkqwcj6HNJSNhmnQaCLGjDUhp5WuqFRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VgHvqjwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8377C4CEE4;
	Tue, 22 Oct 2024 14:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729608380;
	bh=bvJct0mJ5ta5ZqRYy2p54JwF5TkkxvU990r7AjbCCC0=;
	h=From:To:Cc:Subject:Date:From;
	b=VgHvqjwqPKsxW2No4Q+zkCGq1a+EIAcQMlb1hCCN4P19xbtYFzBheNxt2XCyMyqLK
	 IFRQ2R8+7waXkdXCmyoe4cyvjmqzepG6aeMQnnIs5b1orPbNujpAaf9g3vzY89oi6u
	 gU9i8PUoQvJdwOYSHiGQGhojeBEcDbWBwx4NZLdA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.11.5
Date: Tue, 22 Oct 2024 16:46:08 +0200
Message-ID: <2024102209-scabby-decade-75b3@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.11.5 kernel.

All users of the 6.11 kernel series must upgrade.

The updated 6.11.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.11.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    2 
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi       |    2 
 arch/arm64/include/asm/uprobes.h                     |    8 -
 arch/arm64/kernel/probes/decode-insn.c               |   16 +-
 arch/arm64/kernel/probes/simulate-insn.c             |   18 +-
 arch/arm64/kernel/probes/uprobes.c                   |    4 
 arch/s390/kvm/diag.c                                 |    2 
 arch/s390/kvm/gaccess.c                              |    4 
 arch/s390/kvm/gaccess.h                              |   14 +-
 arch/x86/entry/entry.S                               |    5 
 arch/x86/entry/entry_32.S                            |    6 
 arch/x86/include/asm/cpufeatures.h                   |    4 
 arch/x86/include/asm/nospec-branch.h                 |   11 +
 arch/x86/kernel/apic/apic.c                          |   14 ++
 arch/x86/kernel/cpu/amd.c                            |    3 
 arch/x86/kernel/cpu/bugs.c                           |   32 +++++
 arch/x86/kernel/cpu/common.c                         |    3 
 arch/x86/kernel/cpu/resctrl/core.c                   |    4 
 block/blk-mq.c                                       |    8 -
 block/blk-rq-qos.c                                   |    2 
 drivers/block/ublk_drv.c                             |   11 +
 drivers/bluetooth/btusb.c                            |   27 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c               |    2 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c               |    4 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c |   22 +--
 drivers/gpu/drm/i915/display/intel_dp_mst.c          |   40 ++++--
 drivers/gpu/drm/radeon/radeon_encoders.c             |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                  |   30 ----
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c              |    9 -
 drivers/gpu/drm/xe/xe_sync.c                         |    2 
 drivers/gpu/drm/xe/xe_wait_user_fence.c              |    3 
 drivers/iio/accel/Kconfig                            |    2 
 drivers/iio/adc/Kconfig                              |    9 +
 drivers/iio/amplifiers/Kconfig                       |    1 
 drivers/iio/chemical/Kconfig                         |    2 
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c  |    2 
 drivers/iio/dac/Kconfig                              |    7 +
 drivers/iio/frequency/Kconfig                        |    1 
 drivers/iio/light/Kconfig                            |    2 
 drivers/iio/light/opt3001.c                          |    4 
 drivers/iio/light/veml6030.c                         |    5 
 drivers/iio/magnetometer/Kconfig                     |    2 
 drivers/iio/pressure/Kconfig                         |    3 
 drivers/iio/proximity/Kconfig                        |    2 
 drivers/iio/resolver/Kconfig                         |    3 
 drivers/input/joystick/xpad.c                        |    3 
 drivers/iommu/intel/iommu.c                          |    4 
 drivers/irqchip/irq-gic-v3-its.c                     |   18 +-
 drivers/irqchip/irq-sifive-plic.c                    |   29 ++--
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c    |    2 
 drivers/net/ethernet/cadence/macb_main.c             |   14 +-
 drivers/net/ethernet/freescale/enetc/enetc.c         |   56 +++++++--
 drivers/net/ethernet/freescale/enetc/enetc.h         |    1 
 drivers/net/ethernet/freescale/fec_ptp.c             |   58 ++++-----
 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c |    2 
 drivers/parport/procfs.c                             |   22 +--
 drivers/pinctrl/intel/pinctrl-intel-platform.c       |    3 
 drivers/pinctrl/nuvoton/pinctrl-ma35.c               |    2 
 drivers/pinctrl/pinctrl-apple-gpio.c                 |    3 
 drivers/pinctrl/pinctrl-ocelot.c                     |    8 -
 drivers/pinctrl/stm32/pinctrl-stm32.c                |    9 +
 drivers/s390/char/sclp.c                             |    3 
 drivers/s390/char/sclp_vt220.c                       |    4 
 drivers/scsi/mpi3mr/mpi3mr.h                         |    4 
 drivers/scsi/mpi3mr/mpi3mr_transport.c               |   42 ++++--
 drivers/tty/n_gsm.c                                  |    2 
 drivers/tty/serial/imx.c                             |   15 ++
 drivers/tty/serial/qcom_geni_serial.c                |   91 +++++++--------
 drivers/tty/vt/vt.c                                  |    2 
 drivers/ufs/core/ufs-mcq.c                           |   15 +-
 drivers/ufs/core/ufshcd.c                            |   24 +--
 drivers/usb/dwc3/core.c                              |   19 +++
 drivers/usb/dwc3/core.h                              |    3 
 drivers/usb/dwc3/gadget.c                            |   10 -
 drivers/usb/gadget/function/f_uac2.c                 |    6 
 drivers/usb/gadget/udc/dummy_hcd.c                   |   20 ++-
 drivers/usb/host/xhci-ring.c                         |    2 
 drivers/usb/host/xhci-tegra.c                        |    2 
 drivers/usb/host/xhci.h                              |    2 
 drivers/usb/serial/option.c                          |    8 +
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c   |    1 
 fs/btrfs/tree-log.c                                  |    6 
 fs/fat/namei_vfat.c                                  |    2 
 fs/nilfs2/dir.c                                      |   48 ++++---
 fs/nilfs2/namei.c                                    |   39 ++++--
 fs/nilfs2/nilfs.h                                    |    2 
 fs/smb/server/mgmt/user_session.c                    |   26 +++-
 fs/smb/server/mgmt/user_session.h                    |    4 
 fs/smb/server/server.c                               |    2 
 fs/smb/server/smb2pdu.c                              |    8 +
 include/linux/fsl/enetc_mdio.h                       |    3 
 include/linux/irqchip/arm-gic-v4.h                   |    4 
 include/trace/events/huge_memory.h                   |    4 
 include/uapi/linux/ublk_cmd.h                        |    8 +
 io_uring/io_uring.h                                  |   10 +
 kernel/time/posix-clock.c                            |    3 
 kernel/trace/fgraph.c                                |   28 +++-
 lib/maple_tree.c                                     |   12 -
 mm/damon/sysfs-test.h                                |    1 
 mm/khugepaged.c                                      |    2 
 mm/mremap.c                                          |   11 +
 mm/swapfile.c                                        |    2 
 mm/vmscan.c                                          |    6 
 net/bluetooth/af_bluetooth.c                         |    3 
 net/bluetooth/iso.c                                  |    6 
 net/ipv4/tcp_output.c                                |    4 
 net/ipv4/udp.c                                       |    4 
 net/ipv6/udp.c                                       |    4 
 net/mptcp/mib.c                                      |    1 
 net/mptcp/mib.h                                      |    1 
 net/mptcp/pm_netlink.c                               |    3 
 net/mptcp/protocol.h                                 |    1 
 net/mptcp/subflow.c                                  |   11 +
 sound/pci/hda/patch_conexant.c                       |   19 +++
 sound/usb/mixer_scarlett2.c                          |    2 
 tools/testing/selftests/hid/Makefile                 |    1 
 tools/testing/selftests/mm/uffd-common.c             |    5 
 tools/testing/selftests/mm/uffd-common.h             |    3 
 tools/testing/selftests/mm/uffd-unit-tests.c         |   21 ++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh      |  115 ++++++++++++++-----
 121 files changed, 858 insertions(+), 451 deletions(-)

Aaron Thompson (3):
      Bluetooth: Call iso_exit() on module unload
      Bluetooth: Remove debugfs directory on module init failure
      Bluetooth: ISO: Fix multiple init when debugfs is disabled

Alan Stern (1):
      USB: gadget: dummy-hcd: Fix "task hung" problem

Alex Deucher (2):
      drm/amdgpu/smu13: always apply the powersave optimization
      drm/amdgpu/swsmu: Only force workload setup on init

Benjamin B. Frost (1):
      USB: serial: option: add support for Quectel EG916Q-GL

Charlie Jenkins (1):
      irqchip/sifive-plic: Return error code on failure

Chris Li (1):
      mm: vmscan.c: fix OOM on swap stress test

Christophe JAILLET (1):
      iio: hid-sensors: Fix an error handling path in _hid_sensor_set_report_latency()

Csókás, Bence (2):
      net: fec: Move `fec_ptp_read()` to the top of the file
      net: fec: Remove duplicated code

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 MBIM compositions

Edward Liaw (2):
      selftests/mm: replace atomic_bool with pthread_barrier_t
      selftests/mm: fix deadlock for fork after pthread_create on ARM

Emil Gedenryd (1):
      iio: light: opt3001: add missing full-scale range value

Greg Kroah-Hartman (1):
      Linux 6.11.5

Harshit Mogalapalli (1):
      pinctrl: nuvoton: fix a double free in ma35_pinctrl_dt_node_to_map_func()

Heiko Thiery (2):
      misc: microchip: pci1xxxx: add support for NVMEM_DEVID_AUTO for EEPROM device
      misc: microchip: pci1xxxx: add support for NVMEM_DEVID_AUTO for OTP device

Henry Lin (1):
      xhci: tegra: fix checked USB2 port number

Imre Deak (2):
      drm/i915/dp_mst: Handle error during DSC BW overhead/slice calculation
      drm/i915/dp_mst: Don't require DSC hblank quirk for a non-DSC compatible mode

Jakub Sitnicki (1):
      udp: Compute L4 checksum as usual when not segmenting the skb

Jann Horn (1):
      mm/mremap: fix move_normal_pmd/retract_page_tables race

Javier Carrasco (23):
      iio: dac: ad5770r: add missing select REGMAP_SPI in Kconfig
      iio: dac: ltc1660: add missing select REGMAP_SPI in Kconfig
      iio: dac: stm32-dac-core: add missing select REGMAP_MMIO in Kconfig
      iio: adc: ti-ads8688: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: light: veml6030: fix ALS sensor resolution
      iio: light: veml6030: fix IIO device retrieval from embedded device
      iio: amplifiers: ada4250: add missing select REGMAP_SPI in Kconfig
      iio: frequency: adf4377: add missing select REMAP_SPI in Kconfig
      iio: chemical: ens160: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: light: bu27008: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: magnetometer: af8133j: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: resolver: ad2s1210 add missing select REGMAP in Kconfig
      iio: pressure: bm1390: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: dac: ad5766: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: proximity: mb1232: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: dac: ad3552r: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ti-lmp92064: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ti-lmp92064: add missing select REGMAP_SPI in Kconfig
      iio: adc: ti-ads124s08: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: resolver: ad2s1210: add missing select (TRIGGERED_)BUFFER in Kconfig
      iio: adc: ad7944: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: accel: kx022a: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      pinctrl: intel: platform: fix error path in device_for_each_child_node()

Jens Axboe (2):
      io_uring/sqpoll: close race on waiting for sqring entries
      io_uring/sqpoll: ensure task state is TASK_RUNNING when running task_work

Jeongjun Park (1):
      vt: prevent kernel-infoleak in con_font_get()

Jim Mattson (1):
      x86/cpufeatures: Define X86_FEATURE_AMD_IBPB_RET

Jinjie Ruan (3):
      posix-clock: Fix missing timespec64 check in pc_clock_settime()
      net: microchip: vcap api: Fix memory leaks in vcap_api_encode_rule_test()
      mm/damon/tests/sysfs-kunit.h: fix memory leak in damon_sysfs_test_add_targets()

Johan Hovold (5):
      serial: qcom-geni: fix polled console initialisation
      serial: qcom-geni: revert broken hibernation support
      serial: qcom-geni: fix shutdown race
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

Josua Mayer (1):
      arm64: dts: marvell: cn9130-sr-som: fix cp0 mdio pin numbers

Kevin Groeneveld (1):
      usb: gadget: f_uac2: fix return value for UAC2_ATTRIBUTE_STRING store

Liu Shixin (1):
      mm/swapfile: skip HugeTLB pages for unuse_vma

Longlong Xia (1):
      tty: n_gsm: Fix use-after-free in gsm_cleanup_mux

Lorenzo Stoakes (1):
      maple_tree: correct tree corruption on spanning store

Lu Baolu (1):
      iommu/vt-d: Fix incorrect pci_for_each_dma_alias() for non-PCI devices

Luiz Augusto von Dentz (2):
      Bluetooth: btusb: Fix not being able to reconnect after suspend
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

Matthew Auld (1):
      drm/xe/xe_sync: initialise ufence.signalled

Matthieu Baerts (NGI0) (1):
      mptcp: pm: fix UaF read in mptcp_pm_nl_rm_addr_or_subflow

Michael Chen (1):
      drm/amdgpu/mes: fix issue of writing to the same log buffer from 2 MES pipes

Michael Mueller (1):
      KVM: s390: Change virtual to physical address access in diag 0x258 handler

Ming Lei (2):
      blk-mq: setup queue ->tag_set before initializing hctx
      ublk: don't allow user copy for unprivileged device

Mohammed Anees (1):
      drm/amdgpu: prevent BO_HANDLES error from being overwritten

Nam Cao (1):
      irqchip/sifive-plic: Unmask interrupt in plic_irq_enable()

Namjae Jeon (1):
      ksmbd: fix user-after-free from session log off

Nathan Chancellor (1):
      x86/resctrl: Annotate get_mem_config() functions as __init

Nico Boehr (1):
      KVM: s390: gaccess: Check if guest address is in memslot

Nikolay Kuratov (1):
      drm/vmwgfx: Handle surface check failure correctly

Nirmoy Das (1):
      drm/xe/ufence: ufence can be signaled right after wait_woken

OGAWA Hirofumi (1):
      fat: fix uninitialized variable

Oleksij Rempel (1):
      net: macb: Avoid 20s boot delay by skipping MDIO bus registration for fixed-link PHY

Omar Sandoval (1):
      blk-rq-qos: fix crash on rq_qos_wait vs. rq_qos_wake_function race

Paolo Abeni (3):
      selftests: mptcp: join: test for prohibited MPC to port-based endp
      tcp: fix mptcp DSS corruption due to large pmtu xmit
      mptcp: prevent MPC handshake on port-based signal endpoints

Pawan Gupta (3):
      x86/entry_32: Do not clobber user EFLAGS.ZF
      x86/entry_32: Clear CPU buffers after register restore in NMI return
      x86/bugs: Use code segment selector for VERW operand

Peter Wang (2):
      scsi: ufs: core: Fix the issue of ICU failure
      scsi: ufs: core: Requeue aborted request

Prashanth K (1):
      usb: dwc3: Wait for EndXfer completion before restoring GUSB2PHYCFG

Ranjan Kumar (1):
      scsi: mpi3mr: Validate SAS port assignments

Roger Quadros (1):
      usb: dwc3: core: Fix system suspend on TI AM62 platforms

Roi Martin (2):
      btrfs: fix uninitialized pointer free in add_inode_ref()
      btrfs: fix uninitialized pointer free on read_alloc_one_name() error

Ryusuke Konishi (1):
      nilfs2: propagate directory read errors from nilfs_find_entry()

Sergey Matsievskiy (1):
      pinctrl: ocelot: fix system hang on level based interrupts

Seunghwan Baek (1):
      scsi: ufs: core: Set SDEV_OFFLINE when UFS is shut down

Stefan Kerkmann (1):
      Input: xpad - add support for 8BitDo Ultimate 2C Wireless Controller

Steven Rostedt (1):
      fgraph: Use CPU hotplug mechanism to initialize idle shadow stacks

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

Yang Shi (1):
      mm: khugepaged: fix the arguments order in khugepaged_collapse_file trace point

Yun Lu (1):
      selftest: hid: add the missing tests directory

Zack Rusin (1):
      drm/vmwgfx: Cleanup kms setup without 3d

Zhang Rui (1):
      x86/apic: Always explicitly disarm TSC-deadline timer

Zhu Jun (1):
      ALSA: scarlett2: Add error check after retrieving PEQ filter values


