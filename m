Return-Path: <stable+bounces-144701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E4AABAE44
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 08:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B686C178841
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 06:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2306520012C;
	Sun, 18 May 2025 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FCHWv2AG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6F91FFC7B;
	Sun, 18 May 2025 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747550611; cv=none; b=L7QKuRmK314OVtc/m7ZYcjHYUI5QzZ8FVktaBCtb7HkzAdXLTaWDeTyUchO34YJlJiGYKMHdS4H4mEN+w8UcliMOgPEqwCTgLykoNJG8x4dfxmyAyHMmihfTJyTy42Hp9EbOr5DPfJoyuRNhTmxfRNP4YUKqcd1hxl78GowhV2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747550611; c=relaxed/simple;
	bh=9SCIQPviOXSzl6KQibm/x8drWmWU6VODVSvhP/lfFmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QH/hQhAx19x7AGxhkN+lwx3I6Rg78VJTkawGq2ERZi2k70q8jepoYKhViHEu1YsqtW2QSYhHrww26CZQTWFpzSdjTy5q8nzG7vlojY00NAYAoySNLKyVH3N80mVctWgktwUWoAeT/wBw9WLNLa39sgWR2VZ9DdRu5GyXSpmo304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FCHWv2AG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016E1C4CEE7;
	Sun, 18 May 2025 06:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747550611;
	bh=9SCIQPviOXSzl6KQibm/x8drWmWU6VODVSvhP/lfFmQ=;
	h=From:To:Cc:Subject:Date:From;
	b=FCHWv2AGijdQvXq5kGQ45s2qO4zmndAqdfRLwPG8B1SgWiqf3zH42h/nVzKLVNPzJ
	 PkpHJ5RB4mZt2dOt7kAq39IFXCv7URCSL7Pz1tNJzs70/kqB3LlQc3IsZNBIoaSKkJ
	 saO0j/JM0ODy92PB0YzNNblj1zfqQpIoq1PV9q/A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.139
Date: Sun, 18 May 2025 08:41:37 +0200
Message-ID: <2025051838-stew-basil-49f0@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.139 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu              |    1 
 Documentation/admin-guide/hw-vuln/index.rst                     |    1 
 Documentation/admin-guide/hw-vuln/indirect-target-selection.rst |  156 ++++++
 Documentation/admin-guide/kernel-parameters.txt                 |   15 
 Makefile                                                        |    2 
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi                |   25 -
 arch/arm64/include/asm/cputype.h                                |    2 
 arch/arm64/include/asm/insn.h                                   |    1 
 arch/arm64/include/asm/spectre.h                                |    3 
 arch/arm64/kernel/proton-pack.c                                 |   13 
 arch/arm64/lib/insn.c                                           |   60 +-
 arch/arm64/net/bpf_jit_comp.c                                   |   57 ++
 arch/mips/include/asm/ptrace.h                                  |    3 
 arch/x86/Kconfig                                                |   11 
 arch/x86/entry/entry_64.S                                       |   20 
 arch/x86/include/asm/alternative.h                              |   32 +
 arch/x86/include/asm/cpufeatures.h                              |    3 
 arch/x86/include/asm/msr-index.h                                |    8 
 arch/x86/include/asm/nospec-branch.h                            |   38 +
 arch/x86/kernel/alternative.c                                   |  248 +++++++++-
 arch/x86/kernel/cpu/bugs.c                                      |  144 +++++
 arch/x86/kernel/cpu/common.c                                    |   72 ++
 arch/x86/kernel/ftrace.c                                        |    2 
 arch/x86/kernel/module.c                                        |    7 
 arch/x86/kernel/static_call.c                                   |    2 
 arch/x86/kernel/vmlinux.lds.S                                   |   10 
 arch/x86/kvm/x86.c                                              |    4 
 arch/x86/lib/retpoline.S                                        |   39 +
 arch/x86/mm/tlb.c                                               |   23 
 arch/x86/net/bpf_jit_comp.c                                     |   60 ++
 drivers/base/cpu.c                                              |    8 
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c                           |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c               |   20 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c     |   28 -
 drivers/gpu/drm/panel/panel-simple.c                            |   25 -
 drivers/gpu/drm/v3d/v3d_sched.c                                 |   28 -
 drivers/iio/accel/adis16201.c                                   |    4 
 drivers/iio/accel/adxl355_core.c                                |    2 
 drivers/iio/accel/adxl367.c                                     |   10 
 drivers/iio/adc/ad7606_spi.c                                    |    2 
 drivers/iio/adc/dln2-adc.c                                      |    2 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c                  |    6 
 drivers/iio/temperature/maxim_thermocouple.c                    |    2 
 drivers/input/keyboard/mtk-pmic-keys.c                          |    4 
 drivers/input/mouse/synaptics.c                                 |    5 
 drivers/md/dm-table.c                                           |    3 
 drivers/net/can/m_can/m_can.c                                   |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c                  |   42 +
 drivers/net/dsa/b53/b53_common.c                                |   36 -
 drivers/net/phy/microchip.c                                     |   46 +
 drivers/nvme/host/core.c                                        |    3 
 drivers/staging/axis-fifo/axis-fifo.c                           |   14 
 drivers/staging/iio/adc/ad7816.c                                |    2 
 drivers/usb/cdns3/cdnsp-gadget.c                                |   31 +
 drivers/usb/cdns3/cdnsp-gadget.h                                |    6 
 drivers/usb/cdns3/cdnsp-pci.c                                   |   12 
 drivers/usb/cdns3/cdnsp-ring.c                                  |    3 
 drivers/usb/cdns3/core.h                                        |    3 
 drivers/usb/class/usbtmc.c                                      |   59 +-
 drivers/usb/gadget/udc/tegra-xudc.c                             |    4 
 drivers/usb/host/uhci-platform.c                                |    2 
 drivers/usb/host/xhci-tegra.c                                   |    3 
 drivers/usb/typec/tcpm/tcpm.c                                   |    2 
 drivers/usb/typec/ucsi/displayport.c                            |    2 
 drivers/xen/xenbus/xenbus.h                                     |    2 
 drivers/xen/xenbus/xenbus_comms.c                               |    9 
 drivers/xen/xenbus/xenbus_dev_frontend.c                        |    2 
 drivers/xen/xenbus/xenbus_xs.c                                  |   18 
 fs/namespace.c                                                  |    3 
 fs/ocfs2/journal.c                                              |   80 ++-
 fs/ocfs2/journal.h                                              |    1 
 fs/ocfs2/ocfs2.h                                                |   17 
 fs/ocfs2/quota_local.c                                          |    9 
 fs/ocfs2/super.c                                                |    3 
 fs/smb/server/oplock.c                                          |    7 
 fs/smb/server/vfs.c                                             |    7 
 include/linux/cpu.h                                             |    2 
 include/linux/module.h                                          |    5 
 include/linux/rcupdate.h                                        |    3 
 include/linux/types.h                                           |    3 
 include/net/flow.h                                              |    3 
 include/net/route.h                                             |    6 
 include/uapi/linux/types.h                                      |    1 
 io_uring/io_uring.c                                             |   61 --
 kernel/params.c                                                 |    4 
 net/can/gw.c                                                    |  149 +++---
 net/core/filter.c                                               |    1 
 net/ipv6/addrconf.c                                             |   15 
 net/netfilter/ipset/ip_set_hash_gen.h                           |    2 
 net/netfilter/ipvs/ip_vs_xmit.c                                 |   29 -
 net/openvswitch/actions.c                                       |    3 
 net/sched/sch_htb.c                                             |   15 
 net/sctp/protocol.c                                             |    4 
 93 files changed, 1571 insertions(+), 388 deletions(-)

Aditya Garg (3):
      Input: synaptics - enable InterTouch on Dynabook Portege X30L-G
      Input: synaptics - enable InterTouch on Dell Precision M3800
      Input: synaptics - enable InterTouch on TUXEDO InfinityBook Pro 14 v5

Al Viro (1):
      do_umount(): add missing barrier before refcount checks in sync case

Alex Deucher (1):
      drm/amdgpu/hdp5.2: use memcfg register to post the write for HDP flush

Alexey Charkov (1):
      usb: uhci-platform: Make the clock really optional

Andrei Kuchynski (1):
      usb: typec: ucsi: displayport: Fix NULL pointer access

Andy Shevchenko (1):
      types: Complement the aligned types with signed 64-bit one

Angelo Dureghello (1):
      iio: adc: ad7606: fix serial register access

Borislav Petkov (AMD) (1):
      x86/alternative: Optimize returns patching

Cong Wang (1):
      sch_htb: make htb_deactivate() idempotent

Dan Carpenter (1):
      dm: add missing unlock on in dm_keyslot_evict()

Daniel Sneddon (2):
      x86/bpf: Call branch history clearing sequence on exit
      x86/bpf: Add IBHF call at end of classic BPF

Daniel Wagner (1):
      nvme: unblock ctrl state transition for firmware update

Dave Hansen (1):
      x86/mm: Eliminate window where TLB flushes may be inadvertently skipped

Dave Penkler (3):
      usb: usbtmc: Fix erroneous get_stb ioctl error returns
      usb: usbtmc: Fix erroneous wait_srq ioctl return
      usb: usbtmc: Fix erroneous generic_read ioctl return

Dmitry Antipov (1):
      module: ensure that kobject_put() is safe for module type kobjects

Dmitry Torokhov (1):
      Input: synaptics - enable SMBus for HP Elitebook 850 G1

Eelco Chaudron (1):
      openvswitch: Fix unsafe attribute parsing in output_userspace()

Eric Biggers (1):
      x86/its: Fix build errors when CONFIG_MODULES=n

Gabriel Shahrouzi (4):
      staging: iio: adc: ad7816: Correct conditional logic for store mode
      staging: axis-fifo: Remove hardware resets for user errors
      staging: axis-fifo: Correct handling of tx_fifo_depth for size validation
      iio: adis16201: Correct inclinometer channel resolution

Gary Bisson (1):
      Input: mtk-pmic-keys - fix possible null pointer dereference

Greg Kroah-Hartman (2):
      Revert "net: phy: microchip: force IRQ polling mode for lan88xx"
      Linux 6.1.139

Guillaume Nault (2):
      gre: Fix again IPv6 link-local address generation.
      ipv4: Drop tos parameter from flowi4_update_output()

James Morse (6):
      arm64: insn: Add support for encoding DSB
      arm64: proton-pack: Expose whether the platform is mitigated by firmware
      arm64: proton-pack: Expose whether the branchy loop k value
      arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs
      arm64: bpf: Only mitigate cBPF programs loaded by unprivileged users
      arm64: proton-pack: Add new CPUs 'k' values for branch mitigation

Jan Kara (3):
      ocfs2: switch osb->disable_recovery to enum
      ocfs2: implement handshaking with ocfs2 recovery thread
      ocfs2: stop quota recovery before disabling quotas

Jason Andryuk (1):
      xenbus: Use kref to track req lifetime

Jens Axboe (2):
      io_uring: always arm linked timeouts prior to issue
      io_uring: ensure deferred completions are posted for multishot

Jim Lin (1):
      usb: host: tegra: Prevent host controller crash when OTG port is used

Jonas Gorski (6):
      net: dsa: b53: allow leaky reserved multicast
      net: dsa: b53: fix clearing PVID of a port
      net: dsa: b53: fix flushing old pvid VLAN on pvid change
      net: dsa: b53: fix VLAN ID for untagged vlan on bridge leave
      net: dsa: b53: always rejoin default untagged VLAN on bridge leave
      net: dsa: b53: fix learning on VLAN unaware bridges

Jonathan Cameron (3):
      iio: temp: maxim-thermocouple: Fix potential lack of DMA safe buffer.
      iio: accel: adxl355: Make timestamp 64-bit aligned using aligned_s64
      iio: adc: dln2: Use aligned_s64 for timestamp

Josh Poimboeuf (1):
      x86/alternatives: Remove faulty optimization

Jozsef Kadlecsik (1):
      netfilter: ipset: fix region locking in hash types

Julian Anastasov (1):
      ipvs: fix uninit-value for saddr in do_output_route4

Kelsey Maes (1):
      can: mcp251xfd: fix TDC setting for low data bit rates

Kevin Baker (1):
      drm/panel: simple: Update timings for AUO G101EVN010

Lothar Rubusch (1):
      iio: accel: adxl367: fix setting odr for activity time update

Manuel Fombuena (1):
      Input: synaptics - enable InterTouch on Dynabook Portege X30-D

Marc Kleine-Budde (2):
      can: mcan: m_can_class_unregister(): fix order of unregistration calls
      can: mcp251xfd: mcp251xfd_remove(): fix order of unregistration calls

Maíra Canal (1):
      drm/v3d: Add job to pending list if the reset was skipped

Norbert Szetei (1):
      ksmbd: prevent out-of-bounds stream writes by validating *pos

Oliver Hartkopp (1):
      can: gw: fix RCU/BH usage in cgw_create_job()

Oliver Neukum (1):
      USB: usbtmc: use interruptible sleep in usbtmc_read

Paul Chaignon (1):
      bpf: Scrub packet on bpf_redirect_peer

Pawan Gupta (12):
      x86/bhi: Do not set BHI_DIS_S in 32-bit mode
      x86/speculation: Simplify and make CALL_NOSPEC consistent
      x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
      x86/speculation: Remove the extra #ifdef around CALL_NOSPEC
      Documentation: x86/bugs/its: Add ITS documentation
      x86/its: Enumerate Indirect Target Selection (ITS) bug
      x86/its: Add support for ITS-safe indirect thunk
      x86/its: Add support for ITS-safe return thunk
      x86/its: Enable Indirect Target Selection mitigation
      x86/its: Add "vmexit" option to skip mitigation on some CPUs
      x86/its: Align RETs in BHB clear sequence to avoid thunking
      x86/ibt: Keep IBT disabled during alternative patching

Pawel Laszczak (2):
      usb: cdnsp: Fix issue with resuming from L1
      usb: cdnsp: fix L1 resume issue for RTL_REVISION_NEW_LPM version

Peter Zijlstra (2):
      x86/its: Use dynamic thunks for indirect branches
      x86/its: FineIBT-paranoid vs ITS

RD Babiera (1):
      usb: typec: tcpm: delay SNK_TRY_WAIT_DEBOUNCE to SRC_TRYWAIT transition

Silvano Seva (2):
      iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_fifo
      iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_tagged_fifo

Thorsten Blum (1):
      MIPS: Fix MAX_REG_OFFSET

Uladzislau Rezki (Sony) (1):
      rcu/kvfree: Add kvfree_rcu_mightsleep() and kfree_rcu_mightsleep()

Wang Zhaolong (1):
      ksmbd: fix memory leak in parse_lease_state()

Wayne Chang (1):
      usb: gadget: tegra-xudc: ACK ST_RC after clearing CTRL_RUN

Wayne Lin (5):
      drm/amd/display: Shift DMUB AUX reply command if necessary
      drm/amd/display: Fix the checking condition in dmub aux handling
      drm/amd/display: Remove incorrect checking in dmub aux handler
      drm/amd/display: Fix wrong handling for AUX_DEFER case
      drm/amd/display: Copy AUX read reply data whenever length > 0

Wojciech Dubowik (1):
      arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to usdhc2


