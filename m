Return-Path: <stable+bounces-52320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39F9909D60
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 14:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4AC1C20AEB
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 12:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85B6190045;
	Sun, 16 Jun 2024 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g/96pDDF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285E190040;
	Sun, 16 Jun 2024 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718539481; cv=none; b=HWTVHMWxHPunFTMBkihrWFALt6iy77EdIMwtHSPI/v83n4XceyWtqYZ3QxWJSLINOKoHuTqYA/+TIPzTNny1sPGhcXPz91c1JpbvHb7u9jc8mF83z31fC/GEauedJWFcX6GsB2q6d7NIvsC3iIVRfn60H0Pk6O28wTo6rZFqCzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718539481; c=relaxed/simple;
	bh=/LgjsKdNWqOc6vPJRpdY2mq8JQ5DCT5AaRjx3QVBqcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XGzlvD3+KgtnsFfeJuzTWBc+a8e5QMnnGjBIWEdvlvStnyfbrqARP+4NcNx9Yr6sOrmu6ZtY9gcCk/hYi1Ww4tbSHHX6uCOzWTZddaOWa3RYZfW9T7R0mPQr9ZIVBT5N/QnN436FTTHr+publVEgUgwrWeA2Cmqbkc/Lq7/BKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g/96pDDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40FCC2BBFC;
	Sun, 16 Jun 2024 12:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718539481;
	bh=/LgjsKdNWqOc6vPJRpdY2mq8JQ5DCT5AaRjx3QVBqcc=;
	h=From:To:Cc:Subject:Date:From;
	b=g/96pDDFgZycVd6fAS1eqM7L6hSMw3751dVGBvOLN9HoRLbA/ydnaTOGBYb0tHBKL
	 6JDPDqNjBZxqCDD86FwyRcXXJy/XJPwb5FuUFTU+i2+bwW9zbtaUqwnHp/WnNK0N6S
	 zaZVgq7xYN4vvjVMp9VqaJuXZqUzMC4T9KpY53Jo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.9.5
Date: Sun, 16 Jun 2024 14:04:29 +0200
Message-ID: <2024061629-napped-unruffled-40e9@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.9.5 kernel.

All users of the 6.9 kernel series must upgrade.

The updated 6.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.9.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/mm/arch_pgtable_helpers.rst                      |    6 
 Documentation/networking/af_xdp.rst                            |   33 +--
 Makefile                                                       |    7 
 arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts              |    2 
 arch/arm/boot/dts/samsung/exynos4412-origen.dts                |    2 
 arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts              |    2 
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi                 |    2 
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts                 |    4 
 arch/arm64/boot/dts/nvidia/tegra132.dtsi                       |    2 
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi                       |    2 
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                         |    5 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                     |    2 
 arch/arm64/kvm/guest.c                                         |    3 
 arch/arm64/kvm/hyp/aarch32.c                                   |   18 +
 arch/loongarch/include/asm/numa.h                              |    1 
 arch/loongarch/include/asm/stackframe.h                        |    2 
 arch/loongarch/kernel/head.S                                   |    2 
 arch/loongarch/kernel/setup.c                                  |    2 
 arch/loongarch/kernel/smp.c                                    |    5 
 arch/loongarch/kernel/vmlinux.lds.S                            |   10 
 arch/parisc/include/asm/page.h                                 |    1 
 arch/parisc/include/asm/signal.h                               |   12 -
 arch/parisc/include/uapi/asm/signal.h                          |   10 
 arch/powerpc/mm/book3s64/pgtable.c                             |    1 
 arch/powerpc/net/bpf_jit_comp32.c                              |   12 +
 arch/powerpc/net/bpf_jit_comp64.c                              |   42 ++-
 arch/riscv/Kconfig                                             |    2 
 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi |    1 
 arch/s390/include/asm/cpacf.h                                  |  109 ++++++++--
 arch/s390/include/asm/pgtable.h                                |    4 
 arch/sparc/include/asm/smp_64.h                                |    2 
 arch/sparc/include/uapi/asm/termbits.h                         |   10 
 arch/sparc/include/uapi/asm/termios.h                          |    9 
 arch/sparc/kernel/prom_64.c                                    |    4 
 arch/sparc/kernel/setup_64.c                                   |    1 
 arch/sparc/kernel/smp_64.c                                     |   14 -
 arch/sparc/mm/tlb.c                                            |    1 
 arch/x86/kernel/cpu/topology_amd.c                             |    4 
 arch/x86/kvm/svm/svm.c                                         |   27 +-
 arch/x86/mm/pgtable.c                                          |    2 
 crypto/ecdsa.c                                                 |    3 
 crypto/ecrdsa.c                                                |    1 
 drivers/acpi/apei/einj-core.c                                  |    2 
 drivers/acpi/resource.c                                        |   12 +
 drivers/ata/pata_legacy.c                                      |    8 
 drivers/char/tpm/tpm_tis_core.c                                |    3 
 drivers/clk/bcm/clk-bcm2711-dvp.c                              |    3 
 drivers/clk/bcm/clk-raspberrypi.c                              |    2 
 drivers/clk/qcom/apss-ipq-pll.c                                |   30 ++
 drivers/clk/qcom/clk-alpha-pll.c                               |    2 
 drivers/cpufreq/amd-pstate.c                                   |    2 
 drivers/crypto/intel/qat/qat_common/adf_aer.c                  |   19 -
 drivers/crypto/starfive/jh7110-rsa.c                           |    1 
 drivers/edac/amd64_edac.c                                      |    8 
 drivers/edac/igen6_edac.c                                      |    4 
 drivers/firmware/efi/libstub/loongarch.c                       |    2 
 drivers/firmware/qcom/qcom_scm.c                               |   18 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c               |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c               |   15 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                         |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                        |   11 -
 drivers/gpu/drm/amd/include/atomfirmware.h                     |   43 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c           |   20 +
 drivers/gpu/drm/drm_fbdev_generic.c                            |    1 
 drivers/gpu/drm/i915/i915_hwmon.c                              |   46 ++--
 drivers/gpu/drm/xe/xe_bb.c                                     |    3 
 drivers/hid/i2c-hid/i2c-hid-of-elan.c                          |   59 ++++-
 drivers/hwmon/ltc2992.c                                        |    4 
 drivers/hwtracing/intel_th/pci.c                               |    5 
 drivers/i2c/i2c-core-acpi.c                                    |   19 +
 drivers/i3c/master/svc-i3c-master.c                            |   16 +
 drivers/irqchip/irq-riscv-intc.c                               |    9 
 drivers/md/bcache/bset.c                                       |   44 ++--
 drivers/md/bcache/bset.h                                       |   28 +-
 drivers/md/bcache/btree.c                                      |   40 +--
 drivers/md/bcache/super.c                                      |    5 
 drivers/md/bcache/sysfs.c                                      |    2 
 drivers/md/bcache/writeback.c                                  |   10 
 drivers/md/raid5.c                                             |   15 -
 drivers/media/dvb-frontends/lgdt3306a.c                        |    5 
 drivers/media/dvb-frontends/mxl5xx.c                           |   22 +-
 drivers/media/i2c/ov2740.c                                     |   11 -
 drivers/media/mc/mc-devnode.c                                  |    5 
 drivers/media/mc/mc-entity.c                                   |    6 
 drivers/media/pci/mgb4/mgb4_core.c                             |    7 
 drivers/media/v4l2-core/v4l2-async.c                           |   12 -
 drivers/media/v4l2-core/v4l2-dev.c                             |    3 
 drivers/mmc/core/slot-gpio.c                                   |   20 +
 drivers/mmc/host/davinci_mmc.c                                 |    4 
 drivers/mmc/host/sdhci-acpi.c                                  |   61 +++++
 drivers/mmc/host/sdhci.c                                       |   10 
 drivers/mmc/host/sdhci.h                                       |    3 
 drivers/net/bonding/bond_main.c                                |   13 -
 drivers/net/vxlan/vxlan_core.c                                 |    8 
 drivers/net/wireless/ath/ath10k/Kconfig                        |    1 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h               |    9 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c          |   32 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c           |    4 
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c           |   21 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h           |   79 +------
 drivers/net/wireless/realtek/rtw89/mac80211.c                  |    2 
 drivers/net/wireless/realtek/rtw89/pci.c                       |    3 
 drivers/platform/chrome/cros_ec.c                              |   16 -
 drivers/s390/crypto/ap_bus.c                                   |    2 
 drivers/scsi/scsi.c                                            |    7 
 drivers/soc/qcom/cmd-db.c                                      |   32 ++
 drivers/soc/qcom/rpmh-rsc.c                                    |    3 
 drivers/thermal/qcom/lmh.c                                     |    3 
 drivers/video/fbdev/savage/savagefb_driver.c                   |    5 
 drivers/watchdog/rti_wdt.c                                     |   34 +--
 fs/9p/vfs_dentry.c                                             |    9 
 fs/afs/mntpt.c                                                 |    5 
 fs/btrfs/disk-io.c                                             |   10 
 fs/btrfs/extent_io.c                                           |   60 ++---
 fs/btrfs/qgroup.c                                              |   34 ++-
 fs/btrfs/super.c                                               |    8 
 fs/btrfs/tree-log.c                                            |   17 +
 fs/erofs/decompressor_deflate.c                                |   55 ++---
 fs/ext4/inode.c                                                |    2 
 fs/ext4/mballoc.h                                              |    2 
 fs/ext4/xattr.c                                                |    4 
 fs/f2fs/inode.c                                                |    6 
 fs/iomap/buffered-io.c                                         |    2 
 fs/nfs/internal.h                                              |    4 
 fs/nfs/nfs4proc.c                                              |    2 
 fs/nilfs2/dir.c                                                |    2 
 fs/nilfs2/segment.c                                            |    3 
 fs/proc/base.c                                                 |    2 
 fs/proc/fd.c                                                   |   42 +--
 fs/proc/task_mmu.c                                             |    9 
 fs/smb/client/cifspdu.h                                        |    2 
 fs/smb/client/inode.c                                          |    4 
 fs/smb/client/smb2ops.c                                        |    3 
 fs/smb/client/smb2transport.c                                  |    2 
 fs/tracefs/event_inode.c                                       |   13 -
 fs/tracefs/inode.c                                             |   33 +--
 fs/verity/init.c                                               |    7 
 include/linux/ksm.h                                            |   17 +
 include/linux/mm_types.h                                       |    2 
 include/linux/mmc/slot-gpio.h                                  |    1 
 include/linux/pagemap.h                                        |   34 +--
 include/net/tcp_ao.h                                           |    7 
 include/soc/qcom/cmd-db.h                                      |   10 
 io_uring/io_uring.h                                            |    2 
 io_uring/napi.c                                                |   24 +-
 kernel/debug/kdb/kdb_io.c                                      |   99 +++++----
 kernel/irq/irqdesc.c                                           |    5 
 kernel/trace/bpf_trace.c                                       |    8 
 mm/cma.c                                                       |    4 
 mm/huge_memory.c                                               |   49 ++--
 mm/hugetlb.c                                                   |   22 +-
 mm/kmsan/core.c                                                |   15 +
 mm/ksm.c                                                       |   17 -
 mm/memory-failure.c                                            |    4 
 mm/pgtable-generic.c                                           |    2 
 mm/vmalloc.c                                                   |    5 
 net/9p/client.c                                                |    2 
 net/ipv4/tcp_ao.c                                              |   13 -
 net/ipv6/route.c                                               |    5 
 net/xdp/xsk.c                                                  |    5 
 sound/core/seq/seq_ump_convert.c                               |    2 
 sound/core/ump.c                                               |    7 
 sound/core/ump_convert.c                                       |    1 
 sound/soc/sof/ipc4-topology.c                                  |    8 
 tools/perf/builtin-record.c                                    |    6 
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c     |    2 
 tools/testing/selftests/mm/compaction_test.c                   |   22 +-
 tools/testing/selftests/mm/gup_test.c                          |    1 
 tools/testing/selftests/mm/uffd-common.h                       |    1 
 tools/testing/selftests/net/lib.sh                             |   17 -
 tools/tracing/rtla/src/timerlat_hist.c                         |   60 +++--
 171 files changed, 1371 insertions(+), 794 deletions(-)

Adrian Hunter (1):
      mmc: sdhci: Add support for "Tuning Error" interrupts

Alex Deucher (1):
      Revert "drm/amdkfd: fix gfx_target_version for certain 11.0.3 devices"

Alexander Potapenko (1):
      kmsan: do not wipe out origin when doing partial unpoisoning

Alexander Shishkin (1):
      intel_th: pci: Add Meteor Lake-S CPU support

Alexander Stein (1):
      media: v4l: async: Fix notifier list entry init

Andrii Nakryiko (1):
      bpf: fix multi-uprobe PID filtering logic

Anna Schumaker (1):
      NFS: Fix READ_PLUS when server doesn't support OP_READ_PLUS

Arnaldo Carvalho de Melo (1):
      Revert "perf record: Reduce memory for recording PERF_RECORD_LOST_SAMPLES event"

Ashutosh Dixit (1):
      drm/i915/hwmon: Get rid of devm

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

Boris Burkov (1):
      btrfs: qgroup: fix qgroup id collision across mounts

Cai Xinchen (1):
      fbdev: savage: Handle err return when savagefb_check_var failed

Chao Yu (1):
      f2fs: fix to do sanity check on i_xattr_nid in sanity_check_inode()

Chengming Zhou (2):
      mm/ksm: fix ksm_pages_scanned accounting
      mm/ksm: fix ksm_zero_pages accounting

Christoffer Sandberg (1):
      ACPI: resource: Do IRQ override on TongFang GXxHRXx and GMxHGxx

Dan Carpenter (1):
      btrfs: qgroup: fix initialization of auto inherit array

Dan Williams (1):
      ACPI: APEI: EINJ: Fix einj_dev release leak

Daniel Borkmann (1):
      vxlan: Fix regression when dropping packets due to invalid src addresses

Daniel Thompson (5):
      kdb: Fix buffer overflow during tab-complete
      kdb: Use format-strings rather than '\0' injection in kdb_read()
      kdb: Fix console handling when editing and tab-completing commands
      kdb: Merge identical case statements in kdb_read()
      kdb: Use format-specifiers rather than memset() for padding in kdb_read()

David Sterba (1):
      btrfs: qgroup: update rescan message levels and error codes

Dev Jain (2):
      selftests/mm: compaction_test: fix incorrect write of zero to nr_hugepages
      selftests/mm: compaction_test: fix bogus test success on Aarch64

Dhananjay Ugwekar (1):
      cpufreq: amd-pstate: Fix the inconsistency in max frequency units

Dmitry Baryshkov (1):
      wifi: ath10k: fix QCOM_RPROC_COMMON dependency

Dmitry Safonov (1):
      net/tcp: Don't consider TCP_CLOSE in TCP_AO_ESTABLISHED

Dominique Martinet (1):
      9p: add missing locking around taking dentry fid list

Enzo Matsumiya (1):
      smb: client: fix deadlock in smb2_find_smb_tcon()

Eric Biggers (1):
      fsverity: use register_sysctl_init() to avoid kmemleak warning

Filipe Manana (1):
      btrfs: fix leak of qgroup extent records after transaction abort

Frank Li (1):
      i3c: master: svc: fix invalidate IBI type and miss call client IBI handler

Frank van der Linden (2):
      mm/cma: drop incorrect alignment check in cma_init_reserved_mem
      mm/hugetlb: pass correct order_per_bit to cma_declare_contiguous_nid

Gabor Juhos (3):
      firmware: qcom_scm: disable clocks if qcom_scm_bw_enable() fails
      clk: qcom: clk-alpha-pll: fix rate setting for Stromer PLLs
      clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to fix boot failure

Gao Xiang (1):
      erofs: avoid allocating DEFLATE streams before mounting

Greg Kroah-Hartman (1):
      Linux 6.9.5

Hailong.Liu (1):
      mm/vmalloc: fix vmalloc which may return null if called with __GFP_NOFAIL

Hamish Martin (1):
      i2c: acpi: Unbind mux adapters before delete

Hans Verkuil (2):
      media: mc: mark the media devnode as registered from the, start
      media: v4l2-core: hold videodev_lock until dev reg, finishes

Hans de Goede (5):
      mmc: core: Add mmc_gpiod_set_cd_config() function
      mmc: sdhci-acpi: Sort DMI quirks alphabetically
      mmc: sdhci-acpi: Fix Lenovo Yoga Tablet 2 Pro 1380 sdcard slot not working
      mmc: sdhci-acpi: Disable write protect detection on Toshiba WT10-A
      mmc: sdhci-acpi: Add quirk to enable pull-up on the card-detect GPIO on Asus T100TA

Hao Ge (1):
      eventfs: Fix a possible null pointer dereference in eventfs_find_events()

Harald Freudenberger (3):
      s390/ap: Fix crash in AP internal function modify_bitmap()
      s390/cpacf: Split and rework cpacf query functions
      s390/cpacf: Make use of invalid opcode produce a link error

Hari Bathini (1):
      powerpc/64/bpf: fix tail calls for PCREL addressing

Helge Deller (2):
      parisc: Define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
      parisc: Define sigset_t in parisc uapi header

Herbert Xu (1):
      crypto: qat - Fix ADF_DEV_RESET_SYNC memory leak

Ilpo Järvinen (2):
      EDAC/amd64: Convert PCIBIOS_* return codes to errnos
      EDAC/igen6: Convert PCIBIOS_* return codes to errnos

Jan Beulich (1):
      tpm_tis: Do *not* flush uninitialized work

Javier Carrasco (1):
      hwmon: (ltc2992) Fix memory leak in ltc2992_parse_dt()

Jens Axboe (2):
      io_uring/napi: fix timeout calculation
      io_uring: check for non-NULL file pointer in io_file_can_poll()

Jia Jie Ho (1):
      crypto: starfive - Do not free stack buffer

Jiaxun Yang (4):
      LoongArch: Add all CPUs enabled by fdt to NUMA node 0
      LoongArch: Fix built-in DTB detection
      LoongArch: Override higher address bits in JUMP_VIRT_ADDR
      LoongArch: Fix entry point in kernel image header

Johan Hovold (3):
      arm64: dts: qcom: qcs404: fix bluetooth device address
      arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
      HID: i2c-hid: elan: fix reset suspend current leakage

John Kacur (1):
      rtla/timerlat: Fix histogram report when a cpu count is 0

Judith Mendez (1):
      watchdog: rti_wdt: Set min_hw_heartbeat_ms to accommodate a safety margin

Karthikeyan Ramasubramanian (1):
      platform/chrome: cros_ec: Handle events during suspend after resume completion

Konrad Dybcio (1):
      thermal/drivers/qcom/lmh: Check for SCM availability at probe

Krzysztof Kozlowski (4):
      arm64: tegra: Correct Tegra132 I2C alias
      ARM: dts: samsung: smdkv310: fix keypad no-autorepeat
      ARM: dts: samsung: smdk4412: fix keypad no-autorepeat
      ARM: dts: samsung: exynos4412-origen: fix keypad no-autorepeat

Lang Yu (1):
      drm/amdkfd: handle duplicate BOs in reserve_bo_and_cond_vms

Li Ma (1):
      drm/amdgpu/atomfirmware: add intergrated info v2.3 table

Magnus Karlsson (2):
      Revert "xsk: Support redirect to any socket bound to the same umem"
      Revert "xsk: Document ability to redirect to any socket bound to the same umem"

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

Martin Kaistra (1):
      wifi: rtl8xxxu: enable MFP support with security flag of RX descriptor

Martin Tůma (1):
      media: mgb4: Fix double debugfs remove

Matthew Auld (1):
      drm/xe/bb: assert width in xe_bb_create_job()

Matthew Mirvish (1):
      bcache: fix variable length array abuse in btree_iter

Matthieu Baerts (NGI0) (2):
      selftests: net: lib: support errexit with busywait
      selftests: net: lib: avoid error removing empty netns name

Maulik Shah (1):
      soc: qcom: rpmh-rsc: Enhance check for VRM in-flight request

Max Krummenacher (1):
      arm64: dts: ti: verdin-am62: Set memory size to 2gb

Miaohe Lin (1):
      mm/memory-failure: fix handling of dissolved but not taken off from buddy pages

Michael Ellerman (1):
      selftests/mm: fix build warnings on ppc64

Mike Gilbert (1):
      sparc: move struct termio to asm/termios.h

Nam Cao (1):
      riscv: enable HAVE_ARCH_HUGE_VMAP for XIP kernel

Nathan Chancellor (4):
      media: mxl5xx: Move xpt structures off stack
      clk: bcm: dvp: Assign ->num before accessing ->hws
      clk: bcm: rpi: Assign ->num before accessing ->hws
      kbuild: Remove support for Clang's ThinLTO caching

Nikita Zhandarovich (1):
      net/9p: fix uninit-value in p9_client_rpc()

Omar Sandoval (1):
      btrfs: fix crash on racing fsync and size-extending write into prealloc

Oscar Salvador (1):
      mm/hugetlb: do not call vma_add_reservation upon ENOMEM

Peter Ujfalusi (1):
      ASoC: SOF: ipc4-topology: Fix input format query of process modules without base extension

Ping-Ke Shih (2):
      wifi: rtw89: correct aSIFSTime for 6GHz band
      wifi: rtw89: pci: correct TX resource checking for PCI DMA channel of firmware command

Puranjay Mohan (1):
      powerpc/bpf: enforce full ordering for ATOMIC operations with BPF_FETCH

Qu Wenruo (2):
      btrfs: protect folio::private when attaching extent buffer folios
      btrfs: re-introduce 'norecovery' mount option

Ritesh Harjani (IBM) (1):
      ext4: Fixes len calculation in mpage_journal_page_buffers

Ryan Roberts (1):
      mm: fix race between __split_huge_pmd_locked() and GUP-fast

Ryusuke Konishi (2):
      nilfs2: fix potential kernel bug due to lack of writeback flag waiting
      nilfs2: fix nilfs_empty_dir() misjudgment and long loop on I/O errors

Sakari Ailus (3):
      media: ov2740: Fix LINK_FREQ and PIXEL_RATE control value reporting
      media: v4l: async: Properly re-initialise notifier entry in unregister
      media: v4l: async: Don't set notifier's V4L2 device if registering fails

Sam Ravnborg (1):
      sparc64: Fix number of online CPUs

Sean Christopherson (1):
      KVM: SVM: WARN on vNMI + NMI window iff NMIs are outright masked

Sergey Shtylyov (2):
      ata: pata_legacy: make legacy_exit() work again
      nfs: fix undefined behavior in nfs_block_bits()

Shengyu Qu (1):
      riscv: dts: starfive: Remove PMIC interrupt info for Visionfive 2 board

Stefan Berger (1):
      crypto: ecdsa - Fix module auto-load on add-key

Steve French (1):
      cifs: fix creating sockets when using sfu mount options

Steven Rostedt (Google) (2):
      eventfs: Keep the directories from having the same inode number as files
      tracefs: Clear EVENT_INODE flag in tracefs_drop_inode()

Sunil V L (1):
      irqchip/riscv-intc: Prevent memory leak when riscv_intc_init_common() fails

Takashi Iwai (3):
      ALSA: ump: Don't clear bank selection after sending a program change
      ALSA: ump: Don't accept an invalid UMP protocol number
      ALSA: seq: Fix incorrect UMP type for system messages

Thomas Gleixner (1):
      x86/topology/amd: Evaluate SMT in CPUID leaf 0x8000001e only on family 0x17 and greater

Thomas Zimmermann (1):
      drm/fbdev-generic: Do not set physical framebuffer address

Tomi Valkeinen (1):
      media: mc: Fix graph walk in media_pipeline_start

Tony Battersby (1):
      bonding: fix oops during rmmod

Tyler Hicks (Microsoft) (1):
      proc: Move fdinfo PTRACE_MODE_READ check into the inode .permission operation

Uwe Kleine-König (1):
      mmc: davinci: Don't strip remove function when driver is builtin

Vitaly Chikunov (1):
      crypto: ecrdsa - Fix module auto-load on add_key

Xu Yang (2):
      filemap: add helper mapping_max_folio_size()
      iomap: fault in smaller chunks for non-large folio mappings

Yang Xiwen (1):
      arm64: dts: hi3798cv200: fix the size of GICR

Yu Kuai (1):
      md/raid5: fix deadlock that raid5d() wait for itself to clear MD_SB_CHANGE_PENDING

Yuanyuan Zhong (1):
      mm: /proc/pid/smaps_rollup: avoid skipping vma after getting mmap_lock again

Zheyu Ma (1):
      media: lgdt3306a: Add a check against null-pointer-def

dicken.ding (1):
      genirq/irqdesc: Prevent use-after-free in irq_find_at_or_after()

xu xin (1):
      net/ipv6: Fix route deleting failure when metric equals 0


