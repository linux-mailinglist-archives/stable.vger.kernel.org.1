Return-Path: <stable+bounces-52317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EE1909D56
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 14:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987011C20A1E
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 12:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC9718FC61;
	Sun, 16 Jun 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="waFppZYR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486B18F2FD;
	Sun, 16 Jun 2024 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718539469; cv=none; b=uUGVwXe5f79oB1zkQhjLM+py9ldHk6DtKWXI2KXSd7mWH2UyTqqVnayQ53pp8Q601Ly+XA9T9sxE1cg4f2nqUlvQzEWnWmGnK3u6X2RzfooDT35Sc7eTiO5qSA9ZnztHXbg1h7MB292UL18xUYXkQW4PSDVPMrCAgeWMjfZZKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718539469; c=relaxed/simple;
	bh=f8N1MXuzhKzgsINfDnH3PItutV8tODh7DAQc/Q/kGfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dqxjvkGfTCqYdQXIyN6Dt+//Jtziy8wTS5VUuGvxU5jBcwlZ+sEJ3OjkfgOJWKruqOE2jTfMPLJO3pGTxf8mhpjQ4wr4kvrIJlLS8qf/1vwBvKMpbqcoTfnS0NQkOi20HJf/nrAtKz95i7F0tHMvMlsAaomJfTN10292boKHFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=waFppZYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36319C4AF48;
	Sun, 16 Jun 2024 12:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718539468;
	bh=f8N1MXuzhKzgsINfDnH3PItutV8tODh7DAQc/Q/kGfU=;
	h=From:To:Cc:Subject:Date:From;
	b=waFppZYRjL5spZhaQvBuZWCspDe/5BmoDt9gq+6IOKhPJNws6ZNiiaNCd6eHvkUJY
	 Ir5FmYztzyVepp3zRGJk0ISNpMCbht6gCer6A2nu8y2o+Vllg6XtryYmCbAhdWOu8u
	 rXiiSO1uuLYgS27YKKGAKd9s8zM0vGciiloITjgU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.94
Date: Sun, 16 Jun 2024 14:04:13 +0200
Message-ID: <2024061613-stoneware-kite-ee9e@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.94 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/mm/arch_pgtable_helpers.rst             |    6 
 Makefile                                              |    2 
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi        |    2 
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts        |    4 
 arch/arm64/boot/dts/nvidia/tegra132.dtsi              |    2 
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi              |    2 
 arch/arm64/kvm/guest.c                                |    3 
 arch/arm64/kvm/hyp/aarch32.c                          |   18 ++
 arch/parisc/include/asm/page.h                        |    1 
 arch/parisc/include/asm/signal.h                      |   12 -
 arch/parisc/include/uapi/asm/signal.h                 |   10 +
 arch/powerpc/mm/book3s64/pgtable.c                    |    1 
 arch/powerpc/net/bpf_jit_comp32.c                     |   12 +
 arch/powerpc/net/bpf_jit_comp64.c                     |   12 +
 arch/riscv/kernel/signal.c                            |   85 +++++-----
 arch/s390/include/asm/cpacf.h                         |  109 +++++++++++--
 arch/s390/include/asm/pgtable.h                       |    4 
 arch/sparc/include/asm/smp_64.h                       |    2 
 arch/sparc/include/uapi/asm/termbits.h                |   10 -
 arch/sparc/include/uapi/asm/termios.h                 |    9 +
 arch/sparc/kernel/prom_64.c                           |    4 
 arch/sparc/kernel/setup_64.c                          |    1 
 arch/sparc/kernel/smp_64.c                            |   14 -
 arch/sparc/mm/tlb.c                                   |    1 
 arch/x86/mm/pgtable.c                                 |    2 
 crypto/ecdsa.c                                        |    3 
 crypto/ecrdsa.c                                       |    1 
 drivers/acpi/resource.c                               |   12 +
 drivers/ata/pata_legacy.c                             |    8 -
 drivers/bluetooth/btrtl.c                             |   18 ++
 drivers/cpufreq/amd-pstate.c                          |    2 
 drivers/crypto/qat/qat_common/adf_aer.c               |   19 --
 drivers/edac/igen6_edac.c                             |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c      |   15 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                |    3 
 drivers/gpu/drm/amd/include/atomfirmware.h            |   43 +++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |   20 +-
 drivers/gpu/drm/drm_modeset_helper.c                  |   19 ++
 drivers/gpu/drm/drm_probe_helper.c                    |   15 +
 drivers/gpu/drm/i915/display/intel_audio.c            |  116 +-------------
 drivers/hwtracing/intel_th/pci.c                      |    5 
 drivers/i3c/master/svc-i3c-master.c                   |   16 +-
 drivers/md/bcache/bset.c                              |   44 ++---
 drivers/md/bcache/bset.h                              |   28 ++-
 drivers/md/bcache/btree.c                             |   40 ++---
 drivers/md/bcache/super.c                             |    5 
 drivers/md/bcache/sysfs.c                             |    2 
 drivers/md/bcache/writeback.c                         |   10 -
 drivers/md/raid5.c                                    |   15 -
 drivers/media/dvb-frontends/lgdt3306a.c               |    5 
 drivers/media/dvb-frontends/mxl5xx.c                  |   22 +-
 drivers/media/mc/mc-devnode.c                         |    5 
 drivers/media/mc/mc-entity.c                          |    6 
 drivers/media/v4l2-core/v4l2-dev.c                    |    3 
 drivers/mmc/core/host.c                               |    3 
 drivers/mmc/core/slot-gpio.c                          |   20 ++
 drivers/mmc/host/sdhci-acpi.c                         |   61 ++++++-
 drivers/mmc/host/sdhci.c                              |   10 +
 drivers/mmc/host/sdhci.h                              |    3 
 drivers/net/vxlan/vxlan_core.c                        |    4 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |   25 +--
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c  |    4 
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c  |   21 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h  |   79 ++--------
 drivers/net/wireless/realtek/rtw89/mac80211.c         |    2 
 drivers/net/wireless/realtek/rtw89/pci.c              |    3 
 drivers/s390/crypto/ap_bus.c                          |    2 
 drivers/scsi/scsi.c                                   |    7 
 drivers/soc/qcom/cmd-db.c                             |   32 +++-
 drivers/soc/qcom/rpmh-rsc.c                           |    3 
 drivers/thermal/qcom/lmh.c                            |    3 
 drivers/video/fbdev/savage/savagefb_driver.c          |    5 
 drivers/watchdog/rti_wdt.c                            |   34 +---
 fs/9p/vfs_dentry.c                                    |    9 -
 fs/afs/mntpt.c                                        |    5 
 fs/btrfs/tree-log.c                                   |   17 +-
 fs/ext4/mballoc.h                                     |    2 
 fs/ext4/xattr.c                                       |    4 
 fs/f2fs/inode.c                                       |    6 
 fs/nfs/internal.h                                     |    4 
 fs/nfs/nfs4proc.c                                     |    2 
 fs/nilfs2/segment.c                                   |   25 ++-
 fs/smb/client/smb2transport.c                         |    2 
 include/linux/mmc/slot-gpio.h                         |    1 
 include/linux/smp.h                                   |    2 
 include/net/dst_ops.h                                 |    2 
 include/net/sock.h                                    |   13 -
 include/soc/qcom/cmd-db.h                             |   10 +
 init/main.c                                           |    1 
 kernel/debug/kdb/kdb_io.c                             |   99 +++++++-----
 lib/maple_tree.c                                      |   55 +++---
 mm/cma.c                                              |    4 
 mm/huge_memory.c                                      |   49 +++---
 mm/hugetlb.c                                          |    6 
 mm/kmsan/core.c                                       |   15 +
 mm/pgtable-generic.c                                  |    2 
 net/9p/client.c                                       |    2 
 net/ipv4/route.c                                      |   22 +-
 net/ipv6/route.c                                      |   34 ++--
 net/mptcp/protocol.h                                  |    3 
 net/mptcp/sockopt.c                                   |  142 +++++++++++++-----
 net/xfrm/xfrm_policy.c                                |   11 -
 scripts/gdb/linux/constants.py.in                     |   12 -
 103 files changed, 1025 insertions(+), 689 deletions(-)

Adrian Hunter (1):
      mmc: sdhci: Add support for "Tuning Error" interrupts

Alexander Potapenko (1):
      kmsan: do not wipe out origin when doing partial unpoisoning

Alexander Shishkin (1):
      intel_th: pci: Add Meteor Lake-S CPU support

Anna Schumaker (1):
      NFS: Fix READ_PLUS when server doesn't support OP_READ_PLUS

Baokun Li (2):
      ext4: set type of ac_groups_linear_remaining to __u32 to avoid overflow
      ext4: fix mb_cache_entry's e_refcnt leak in ext4_xattr_block_cache_find()

Bitterblue Smith (4):
      wifi: rtl8xxxu: Fix the TX power of RTL8192CU, RTL8723AU
      wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
      wifi: rtlwifi: rtl8192de: Fix low speed with WPA3-SAE
      wifi: rtlwifi: rtl8192de: Fix endianness issue in RX path

Bob Zhou (1):
      drm/amdgpu: add error handle to avoid out-of-bounds

Cai Xinchen (1):
      fbdev: savage: Handle err return when savagefb_check_var failed

Chaitanya Kumar Borah (1):
      drm/i915/audio: Fix audio time stamp programming for DP

Chao Yu (1):
      f2fs: fix to do sanity check on i_xattr_nid in sanity_check_inode()

Christoffer Sandberg (1):
      ACPI: resource: Do IRQ override on TongFang GXxHRXx and GMxHGxx

Dan Gora (1):
      Bluetooth: btrtl: Add missing MODULE_FIRMWARE declarations

Daniel Borkmann (1):
      vxlan: Fix regression when dropping packets due to invalid src addresses

Daniel Thompson (5):
      kdb: Fix buffer overflow during tab-complete
      kdb: Use format-strings rather than '\0' injection in kdb_read()
      kdb: Fix console handling when editing and tab-completing commands
      kdb: Merge identical case statements in kdb_read()
      kdb: Use format-specifiers rather than memset() for padding in kdb_read()

Dhananjay Ugwekar (1):
      cpufreq: amd-pstate: Fix the inconsistency in max frequency units

Dominique Martinet (1):
      9p: add missing locking around taking dentry fid list

Enzo Matsumiya (1):
      smb: client: fix deadlock in smb2_find_smb_tcon()

Eric Dumazet (1):
      net: fix __dst_negative_advice() race

Florian Fainelli (1):
      scripts/gdb: fix SB_* constants parsing

Frank Li (1):
      i3c: master: svc: fix invalidate IBI type and miss call client IBI handler

Frank van der Linden (2):
      mm/cma: drop incorrect alignment check in cma_init_reserved_mem
      mm/hugetlb: pass correct order_per_bit to cma_declare_contiguous_nid

Greg Kroah-Hartman (1):
      Linux 6.1.94

Hans Verkuil (2):
      media: mc: mark the media devnode as registered from the, start
      media: v4l2-core: hold videodev_lock until dev reg, finishes

Hans de Goede (5):
      mmc: core: Add mmc_gpiod_set_cd_config() function
      mmc: sdhci-acpi: Sort DMI quirks alphabetically
      mmc: sdhci-acpi: Fix Lenovo Yoga Tablet 2 Pro 1380 sdcard slot not working
      mmc: sdhci-acpi: Disable write protect detection on Toshiba WT10-A
      mmc: sdhci-acpi: Add quirk to enable pull-up on the card-detect GPIO on Asus T100TA

Haorong Lu (1):
      riscv: signal: handle syscall restart before get_signal

Harald Freudenberger (3):
      s390/ap: Fix crash in AP internal function modify_bitmap()
      s390/cpacf: Split and rework cpacf query functions
      s390/cpacf: Make use of invalid opcode produce a link error

Helge Deller (2):
      parisc: Define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
      parisc: Define sigset_t in parisc uapi header

Herbert Xu (1):
      crypto: qat - Fix ADF_DEV_RESET_SYNC memory leak

Ilpo Järvinen (1):
      EDAC/igen6: Convert PCIBIOS_* return codes to errnos

Ingo Molnar (1):
      smp: Provide 'setup_max_cpus' definition on UP too

Johan Hovold (1):
      arm64: dts: qcom: qcs404: fix bluetooth device address

Jorge Ramirez-Ortiz (1):
      mmc: core: Do not force a retune before RPMB switch

Judith Mendez (1):
      watchdog: rti_wdt: Set min_hw_heartbeat_ms to accommodate a safety margin

Konrad Dybcio (1):
      thermal/drivers/qcom/lmh: Check for SCM availability at probe

Krzysztof Kozlowski (1):
      arm64: tegra: Correct Tegra132 I2C alias

Li Ma (1):
      drm/amdgpu/atomfirmware: add intergrated info v2.3 table

Liam R. Howlett (1):
      maple_tree: fix mas_empty_area_rev() null pointer dereference

Marc Dionne (1):
      afs: Don't cross .backup mountpoint from backup volume

Marc Zyngier (3):
      KVM: arm64: Fix AArch32 register narrowing on userspace write
      KVM: arm64: Allow AArch32 PSTATE.M to be restored as System mode
      KVM: arm64: AArch32: Fix spurious trapping of conditional instructions

Mario Limonciello (1):
      drm/amd: Fix shutdown (again) on some SMU v13.0.4/11 platforms

Martin K. Petersen (1):
      scsi: core: Handle devices which return an unusually large VPD page count

Matthew Mirvish (1):
      bcache: fix variable length array abuse in btree_iter

Matthieu Baerts (NGI0) (1):
      mptcp: fix full TCP keep-alive support

Maulik Shah (1):
      soc: qcom: rpmh-rsc: Enhance check for VRM in-flight request

Mike Gilbert (1):
      sparc: move struct termio to asm/termios.h

Nathan Chancellor (1):
      media: mxl5xx: Move xpt structures off stack

Nikita Zhandarovich (1):
      net/9p: fix uninit-value in p9_client_rpc()

Omar Sandoval (1):
      btrfs: fix crash on racing fsync and size-extending write into prealloc

Paolo Abeni (2):
      mptcp: avoid some duplicate code in socket option handling
      mptcp: cleanup SOL_TCP handling

Peng Zhang (1):
      maple_tree: fix allocation in mas_sparse_area()

Ping-Ke Shih (2):
      wifi: rtw89: correct aSIFSTime for 6GHz band
      wifi: rtw89: pci: correct TX resource checking for PCI DMA channel of firmware command

Puranjay Mohan (1):
      powerpc/bpf: enforce full ordering for ATOMIC operations with BPF_FETCH

Ryan Roberts (1):
      mm: fix race between __split_huge_pmd_locked() and GUP-fast

Ryusuke Konishi (1):
      nilfs2: fix use-after-free of timer for log writer thread

Sam Ravnborg (1):
      sparc64: Fix number of online CPUs

Sergey Shtylyov (2):
      ata: pata_legacy: make legacy_exit() work again
      nfs: fix undefined behavior in nfs_block_bits()

Shradha Gupta (2):
      drm: Check output polling initialized before disabling
      drm: Check polling initialized before enabling in drm_helper_probe_single_connector_modes

Stefan Berger (1):
      crypto: ecdsa - Fix module auto-load on add-key

Tomi Valkeinen (1):
      media: mc: Fix graph walk in media_pipeline_start

Vitaly Chikunov (1):
      crypto: ecrdsa - Fix module auto-load on add_key

Yang Xiwen (1):
      arm64: dts: hi3798cv200: fix the size of GICR

Yu Kuai (1):
      md/raid5: fix deadlock that raid5d() wait for itself to clear MD_SB_CHANGE_PENDING

Zheyu Ma (1):
      media: lgdt3306a: Add a check against null-pointer-def

xu xin (1):
      net/ipv6: Fix route deleting failure when metric equals 0


