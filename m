Return-Path: <stable+bounces-191608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64D5C1ACD4
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 14:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76951460CE1
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 13:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146593346B1;
	Wed, 29 Oct 2025 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wKBgzdjF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB09033506D;
	Wed, 29 Oct 2025 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743724; cv=none; b=UsvgHIlLKBDxvepIZQLZNcPEVNgOQJ96rd+foPTOyQhWIPc7eQDSziVmaqUTpGVBu57fvX/3CUbVmXs3LjmUWlJfDJx4pfie36fctOB1EWWGo02j/vykWYp4185NKTfy9NryNwMalloXda8Oc181UfXsC9m2Lla+ObPRw0pkqGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743724; c=relaxed/simple;
	bh=2DDaUSFwWhPKJWgxjDG1/o7wTQmIP4YFpdqysQTO998=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nbde5EkGp/Y9R/1LKHvh0SO2bnc1UlZrR+p2jrfyJvV/Kv65NLQ+r0ZlGmFGWoiUN5YOc5npxY9DC+5jRPKNl1FjhyOYRG5l/gGEqpOd9wTRWqjIX5ojodkvEwZ9arHC9mgJNxyfBuu0UcccqnjzxWnWKz6HtpwU1DkGnqET/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wKBgzdjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894BCC4CEF7;
	Wed, 29 Oct 2025 13:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761743724;
	bh=2DDaUSFwWhPKJWgxjDG1/o7wTQmIP4YFpdqysQTO998=;
	h=From:To:Cc:Subject:Date:From;
	b=wKBgzdjFCPVbnlcVLqQrZnr89hGNyDj2N5y/mqcXXO1uwznmYtoHoEHe1ENYCdeAP
	 Po9ZkgcBboYqWhywB2uRfo1wq3IlJJ78CECCP+gV2V6kO+yw+E/gXFTFTUXjw9Tsw7
	 1N4TmjskjupQHswUgsMCGp/e1/5NZPDYvyzYhOfc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.301
Date: Wed, 29 Oct 2025 14:15:15 +0100
Message-ID: <2025102916-unsaid-untruth-9073@gregkh>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.301 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt          |    3 
 Documentation/arm64/silicon-errata.rst                   |    2 
 Makefile                                                 |    2 
 arch/arm64/Kconfig                                       |    1 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                    |    2 
 arch/arm64/include/asm/cputype.h                         |    2 
 arch/arm64/include/asm/pgtable.h                         |    3 
 arch/arm64/kernel/cpu_errata.c                           |    1 
 arch/m68k/include/asm/bitops.h                           |   25 +
 arch/mips/mti-malta/malta-setup.c                        |    2 
 arch/parisc/include/uapi/asm/ioctls.h                    |    8 
 arch/sparc/kernel/of_device_32.c                         |    1 
 arch/sparc/kernel/of_device_64.c                         |    1 
 arch/sparc/lib/M7memcpy.S                                |   20 -
 arch/sparc/lib/Memcpy_utils.S                            |    9 
 arch/sparc/lib/NG4memcpy.S                               |    2 
 arch/sparc/lib/NGmemcpy.S                                |   29 +-
 arch/sparc/lib/U1memcpy.S                                |   19 -
 arch/sparc/lib/U3memcpy.S                                |    2 
 arch/sparc/mm/hugetlbpage.c                              |   20 +
 arch/x86/include/asm/kvm_emulate.h                       |    2 
 arch/x86/include/asm/segment.h                           |    8 
 arch/x86/kernel/umip.c                                   |   15 +
 arch/x86/kvm/emulate.c                                   |   10 
 arch/x86/kvm/x86.c                                       |    9 
 block/blk-mq-sysfs.c                                     |    6 
 block/blk-settings.c                                     |    3 
 crypto/essiv.c                                           |   14 -
 drivers/acpi/acpi_dbg.c                                  |   26 +-
 drivers/acpi/acpi_tad.c                                  |    3 
 drivers/acpi/processor_idle.c                            |    3 
 drivers/android/binder.c                                 |   11 
 drivers/base/node.c                                      |    4 
 drivers/base/regmap/regmap.c                             |    2 
 drivers/char/tpm/tpm_tis_core.c                          |   24 +
 drivers/clk/nxp/clk-lpc18xx-cgu.c                        |   20 -
 drivers/clocksource/clps711x-timer.c                     |   23 +
 drivers/cpufreq/intel_pstate.c                           |    8 
 drivers/cpuidle/governors/menu.c                         |   21 -
 drivers/crypto/atmel-tdes.c                              |    2 
 drivers/firmware/meson/meson_sm.c                        |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c         |    5 
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c                    |    7 
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c                    |    7 
 drivers/gpu/drm/exynos/exynos7_drm_decon.c               |   36 --
 drivers/gpu/drm/nouveau/nouveau_bo.c                     |    2 
 drivers/gpu/drm/radeon/r600_cs.c                         |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c               |    4 
 drivers/i2c/busses/i2c-designware-platdrv.c              |    1 
 drivers/i2c/busses/i2c-mt65xx.c                          |   17 -
 drivers/iio/dac/ad5360.c                                 |    2 
 drivers/iio/dac/ad5421.c                                 |    2 
 drivers/iio/frequency/adf4350.c                          |   20 +
 drivers/iio/inkern.c                                     |    2 
 drivers/infiniband/core/addr.c                           |   10 
 drivers/infiniband/core/sa_query.c                       |    6 
 drivers/infiniband/sw/siw/siw_verbs.c                    |   25 +
 drivers/input/misc/uinput.c                              |    1 
 drivers/mailbox/zynqmp-ipi-mailbox.c                     |    7 
 drivers/md/dm-integrity.c                                |    2 
 drivers/md/dm.c                                          |    7 
 drivers/media/i2c/mt9v111.c                              |    2 
 drivers/media/i2c/rj54n1cb0c.c                           |    9 
 drivers/media/i2c/tc358743.c                             |    4 
 drivers/media/mc/mc-devnode.c                            |    6 
 drivers/media/pci/b2c2/flexcop-pci.c                     |    2 
 drivers/media/pci/cx18/cx18-queue.c                      |   12 
 drivers/media/pci/ivtv/ivtv-driver.c                     |    2 
 drivers/media/pci/ivtv/ivtv-irq.c                        |    2 
 drivers/media/pci/ivtv/ivtv-queue.c                      |   18 -
 drivers/media/pci/ivtv/ivtv-streams.c                    |   22 -
 drivers/media/pci/ivtv/ivtv-udma.c                       |   19 -
 drivers/media/pci/ivtv/ivtv-yuv.c                        |   18 +
 drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c          |   35 +-
 drivers/media/rc/imon.c                                  |  189 +++++++++------
 drivers/media/rc/lirc_dev.c                              |   15 -
 drivers/media/rc/rc-main.c                               |    6 
 drivers/media/tuners/xc5000.c                            |   41 +--
 drivers/memory/samsung/exynos-srom.c                     |   32 +-
 drivers/mfd/intel_soc_pmic_chtdc_ti.c                    |    5 
 drivers/mfd/vexpress-sysreg.c                            |    6 
 drivers/misc/genwqe/card_ddcb.c                          |    2 
 drivers/mmc/core/sdio.c                                  |    6 
 drivers/mtd/nand/raw/fsmc_nand.c                         |    6 
 drivers/mtd/spi-nor/cadence-quadspi.c                    |    5 
 drivers/net/bonding/bond_main.c                          |   40 +--
 drivers/net/ethernet/amazon/ena/ena_ethtool.c            |    5 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                 |    1 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                |    1 
 drivers/net/ethernet/broadcom/tg3.c                      |    5 
 drivers/net/ethernet/dlink/dl2k.c                        |   99 ++++---
 drivers/net/ethernet/freescale/enetc/enetc.h             |    2 
 drivers/net/ethernet/freescale/fsl_pq_mdio.c             |    2 
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        |   17 -
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c     |    2 
 drivers/net/ethernet/renesas/ravb_main.c                 |    8 
 drivers/net/usb/rtl8150.c                                |   13 -
 drivers/net/wireless/marvell/mwifiex/cfg80211.c          |    7 
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c          |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c      |    1 
 drivers/pci/controller/dwc/pci-keystone.c                |    4 
 drivers/pci/controller/pci-tegra.c                       |    2 
 drivers/pci/iov.c                                        |    5 
 drivers/pci/pci-driver.c                                 |    1 
 drivers/perf/arm_spe_pmu.c                               |    3 
 drivers/pinctrl/meson/pinctrl-meson-gxl.c                |   10 
 drivers/pinctrl/pinmux.c                                 |    2 
 drivers/pps/kapi.c                                       |    5 
 drivers/pps/pps.c                                        |    5 
 drivers/pwm/pwm-berlin.c                                 |    4 
 drivers/pwm/pwm-tiehrpwm.c                               |    4 
 drivers/remoteproc/qcom_q6v5.c                           |    3 
 drivers/rtc/interface.c                                  |   27 ++
 drivers/rtc/rtc-x1205.c                                  |    2 
 drivers/scsi/hpsa.c                                      |   21 -
 drivers/scsi/mpt3sas/mpt3sas_transport.c                 |    8 
 drivers/scsi/mvsas/mv_defs.h                             |    1 
 drivers/scsi/mvsas/mv_init.c                             |   13 -
 drivers/scsi/mvsas/mv_sas.c                              |   42 +--
 drivers/scsi/mvsas/mv_sas.h                              |    8 
 drivers/scsi/myrs.c                                      |    8 
 drivers/scsi/pm8001/pm8001_sas.c                         |    9 
 drivers/soc/qcom/rpmh-rsc.c                              |    7 
 drivers/staging/axis-fifo/axis-fifo.c                    |   32 +-
 drivers/staging/comedi/comedi_buf.c                      |    2 
 drivers/target/target_core_configfs.c                    |    2 
 drivers/tty/serial/max310x.c                             |    2 
 drivers/uio/uio_hv_generic.c                             |    7 
 drivers/usb/core/quirks.c                                |    2 
 drivers/usb/gadget/configfs.c                            |    2 
 drivers/usb/host/max3421-hcd.c                           |    2 
 drivers/usb/host/xhci-dbgcap.c                           |    9 
 drivers/usb/phy/phy-twl6030-usb.c                        |    3 
 drivers/usb/serial/option.c                              |   16 +
 drivers/usb/usbip/vhci_hcd.c                             |   22 +
 drivers/watchdog/mpc8xxx_wdt.c                           |    2 
 drivers/xen/events/events_base.c                         |   25 +
 drivers/xen/manage.c                                     |    3 
 fs/btrfs/export.c                                        |    8 
 fs/cramfs/inode.c                                        |   11 
 fs/dcache.c                                              |    2 
 fs/dlm/lockspace.c                                       |    2 
 fs/exec.c                                                |    2 
 fs/ext4/fsmap.c                                          |   14 -
 fs/ext4/inode.c                                          |   18 +
 fs/ext4/super.c                                          |   10 
 fs/ext4/xattr.c                                          |   15 -
 fs/hfs/bfind.c                                           |    8 
 fs/hfs/brec.c                                            |   27 +-
 fs/hfs/mdb.c                                             |    2 
 fs/hfsplus/bfind.c                                       |    8 
 fs/hfsplus/bnode.c                                       |   41 ---
 fs/hfsplus/btree.c                                       |    6 
 fs/hfsplus/hfsplus_fs.h                                  |   42 +++
 fs/hfsplus/super.c                                       |   25 +
 fs/hfsplus/unicode.c                                     |   24 +
 fs/jbd2/transaction.c                                    |   13 -
 fs/minix/inode.c                                         |    8 
 fs/namespace.c                                           |   11 
 fs/nfs/nfs4proc.c                                        |    2 
 fs/nfsd/blocklayout.c                                    |    5 
 fs/nfsd/flexfilelayout.c                                 |    8 
 fs/nfsd/lockd.c                                          |   15 +
 fs/nfsd/nfs4proc.c                                       |   34 +-
 fs/ocfs2/move_extents.c                                  |    5 
 fs/ocfs2/stack_user.c                                    |    1 
 fs/squashfs/inode.c                                      |   31 ++
 fs/squashfs/squashfs_fs_i.h                              |    2 
 fs/udf/inode.c                                           |    3 
 include/linux/device.h                                   |    3 
 include/linux/iio/frequency/adf4350.h                    |    2 
 include/linux/netdevice.h                                |    9 
 include/net/ip_tunnels.h                                 |   15 +
 include/net/rtnetlink.h                                  |   16 +
 include/scsi/libsas.h                                    |   18 +
 include/uapi/linux/netlink.h                             |    1 
 kernel/padata.c                                          |    6 
 kernel/pid.c                                             |    2 
 kernel/sched/fair.c                                      |   38 +--
 kernel/sched/sched.h                                     |    4 
 kernel/trace/trace_kprobe.c                              |   11 
 kernel/trace/trace_probe.h                               |    9 
 kernel/trace/trace_uprobe.c                              |   12 
 lib/genalloc.c                                           |    5 
 mm/hugetlb.c                                             |    2 
 net/9p/trans_fd.c                                        |    8 
 net/core/filter.c                                        |   16 -
 net/core/rtnetlink.c                                     |   89 ++++---
 net/ipv4/ip_tunnel.c                                     |   14 -
 net/ipv4/tcp.c                                           |    9 
 net/ipv4/tcp_input.c                                     |    1 
 net/ipv4/tcp_output.c                                    |   19 +
 net/ipv4/udp.c                                           |   16 -
 net/ipv6/ip6_tunnel.c                                    |    3 
 net/netfilter/ipset/ip_set_hash_gen.h                    |    8 
 net/netfilter/ipvs/ip_vs_ftp.c                           |    4 
 net/sctp/inqueue.c                                       |   13 -
 net/sctp/sm_make_chunk.c                                 |    3 
 net/sctp/sm_statefuns.c                                  |    6 
 net/tls/tls_main.c                                       |    7 
 net/tls/tls_sw.c                                         |   13 +
 security/keys/trusted.c                                  |    7 
 sound/firewire/amdtp-stream.h                            |    2 
 sound/pci/lx6464es/lx_core.c                             |    4 
 sound/soc/intel/boards/bytcht_es8316.c                   |   20 +
 sound/soc/intel/boards/bytcr_rt5640.c                    |    7 
 sound/soc/intel/boards/bytcr_rt5651.c                    |   26 +-
 tools/build/feature/Makefile                             |    4 
 tools/lib/subcmd/help.c                                  |    3 
 tools/perf/util/lzma.c                                   |    2 
 tools/perf/util/session.c                                |    2 
 tools/perf/util/zlib.c                                   |    2 
 tools/testing/selftests/rseq/rseq.c                      |    8 
 tools/testing/selftests/watchdog/watchdog-test.c         |    6 
 216 files changed, 1509 insertions(+), 919 deletions(-)

Abdun Nihaal (1):
      wifi: mt76: fix potential memory leak in mt76_wmac_probe()

Ahmet Eray Karadag (1):
      ext4: guard against EA inode refcount underflow in xattr update

Akhilesh Patil (1):
      selftests: watchdog: skip ping loop if WDIOF_KEEPALIVEPING not supported

Alexander Aring (1):
      dlm: check for defined force value in dlm_lockspace_release

Alexandr Sapozhnikov (1):
      net/sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()

Alexey Simakov (2):
      tg3: prevent use of uninitialized remote_adv and local_adv variables
      sctp: avoid NULL dereference when chunk data buffer is missing

Alice Ryhl (1):
      binder: remove "invalid inc weak" check

Alok Tiwari (2):
      PCI: tegra: Fix devm_kcalloc() argument order for port->phys allocation
      clk: nxp: Fix pll0 rate check condition in LPC18xx CGU driver

Amir Mohammad Jahangirzad (1):
      ACPI: debug: fix signedness issues in read/write helpers

Anderson Nascimento (1):
      btrfs: avoid potential out-of-bounds in btrfs_encode_fh()

Andy Shevchenko (1):
      mfd: intel_soc_pmic_chtdc_ti: Drop unneeded assignment for cache_type

Anthony Iliopoulos (1):
      NFSv4.1: fix backchannel max_resp_sz verification check

Anthony Yznaga (1):
      sparc64: fix hugetlb for sun4u

Arnd Bergmann (1):
      media: s5p-mfc: remove an unused/uninitialized variable

Barry Song (1):
      sched/fair: Trivial correction of the newidle_balance() comment

Bartosz Golaszewski (2):
      pinctrl: check the return value of pinmux_ops::get_function_name()
      mfd: vexpress-sysreg: Check the return value of devm_gpiochip_add_data()

Bernard Metzler (1):
      RDMA/siw: Always report immediate post SQ errors

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8192cu: Don't claim USB ID 07b8:8188

Brahmajit Das (1):
      drm/radeon/r600_cs: clean up of dead code in r600_cs

Brian Masney (1):
      clk: nxp: lpc18xx-cgu: convert from round_rate() to determine_rate()

Chen Yu (1):
      sched: Make newidle_balance() static again

Christophe JAILLET (2):
      media: pci/ivtv: switch from 'pci_' to 'dma_' API
      net: dl2k: switch from 'pci_' to 'dma_' API

Christophe Leroy (1):
      watchdog: mpc8xxx_wdt: Reload the watchdog timer when enabling the watchdog

Chuck Lever (1):
      NFSD: Define a proc_layoutcommit for the FlexFiles layout type

Colin Ian King (2):
      misc: genwqe: Fix incorrect cmd field being reported in error
      net: rtnetlink: remove redundant assignment to variable err

Cristian Ciocaltea (1):
      usb: vhci-hcd: Prevent suspending virtually attached devices

Da Xue (1):
      pinctrl: meson-gxl: add missing i2c_d pinmux

Dan Carpenter (4):
      usb: host: max3421-hcd: Fix error pointer dereference in probe cleanup
      serial: max310x: Add error checking in probe()
      ocfs2: fix double free in user_cluster_connect()
      net/mlx4: prevent potential use after free in mlx4_en_do_uc_filter()

Daniel Tang (1):
      ACPI: TAD: Add missing sysfs_remove_group() for ACPI_TAD_RT

Deepanshu Kartikey (3):
      ocfs2: clear extent cache after moving/defragmenting extents
      comedi: fix divide-by-zero in comedi_buf_munge()
      ext4: detect invalid INLINE_DATA + EXTENTS flag combination

Dmitry Safonov (1):
      net/ip6_tunnel: Prevent perpetual tunnel growth

Donet Tom (2):
      drivers/base/node: handle error properly in register_one_node()
      drivers/base/node: fix double free in register_one_node()

Duoming Zhou (4):
      media: b2c2: Fix use-after-free causing by irq_check_work in flexcop_pci_remove
      media: tuner: xc5000: Fix use-after-free in xc5000_release
      media: i2c: tc358743: Fix use-after-free bugs caused by orphan timer in probe
      scsi: mvsas: Fix use-after-free bugs in mvs_work_queue

Edward Adam Davis (1):
      media: mc: Clear minor number before put device

Eric Biggers (2):
      sctp: Fix MAC comparison to be constant-time
      KEYS: trusted_tpm1: Compare HMAC values in constant time

Eric Dumazet (2):
      tcp: fix __tcp_close() to only send RST when required
      tcp: fix tcp_tso_should_defer() vs large RTT

Erick Karanja (1):
      net: fsl_pq_mdio: Fix device node reference leak in fsl_pq_mdio_probe

Esben Haabendal (2):
      rtc: interface: Ensure alarm irq is enabled when UIE is enabled
      rtc: interface: Fix long-standing race when setting alarm

Flavius Georgescu (1):
      media: rc: Add support for another iMON 0xffdc device

Geert Uytterhoeven (2):
      regmap: Remove superfluous check for !config in __regmap_init()
      m68k: bitops: Fix find_*_bit() signatures

Greg Kroah-Hartman (1):
      Linux 5.4.301

Gui-Dong Han (1):
      drm/amdgpu: use atomic functions with memory barriers for vm fault info

Gunnar Kudrjavets (1):
      tpm_tis: Fix incorrect arguments in tpm_tis_probe_irq_single

Hans de Goede (3):
      iio: consumers: Fix offset handling in iio_convert_raw_to_processed()
      mfd: intel_soc_pmic_chtdc_ti: Fix invalid regmap-config max_register value
      mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag

Harini T (2):
      mailbox: zynqmp-ipi: Remove redundant mbox_controller_unregister() call
      mailbox: zynqmp-ipi: Remove dev.parent check in zynqmp_ipi_free_mboxes

Herbert Xu (1):
      crypto: essiv - Check ssize for decryption and in-place encryption

Huang Ying (1):
      arm64, mm: avoid always making PTE dirty in pte_mkwrite()

Huisong Li (1):
      ACPI: processor: idle: Fix memory leak when register cpuidle device failed

I Viswanath (1):
      net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast

Ian Forbes (1):
      drm/vmwgfx: Fix Use-after-free in validation

Ingo Molnar (1):
      sched/balancing: Rename newidle_balance() => sched_balance_newidle()

Jakub Kicinski (1):
      Revert "net/mlx5e: Update and set Xon/Xoff upon MTU set"

Jan Kara (1):
      vfs: Don't leak disconnected dentries on umount

Jason Andryuk (2):
      xen/events: Cleanup find_virq() return codes
      xen/events: Update virq_to_irq on migration

Jisheng Zhang (1):
      pwm: berlin: Fix wrong register in suspend/resume

Johan Hovold (2):
      firmware: meson_sm: fix device leak at probe
      lib/genalloc: fix device leak in of_gen_pool_get()

Johannes Wiesböck (1):
      rtnetlink: Allow deleting FDB entries in user namespace

John Garry (3):
      scsi: libsas: Add sas_task_find_rq()
      scsi: mvsas: Delete mvs_tag_init()
      scsi: mvsas: Use sas_task_find_rq() for tagging

Kaustabh Chakraborty (1):
      drm/exynos: exynos7_drm_decon: remove ctx->suspended

Kohei Enju (2):
      nfp: fix RSS hash key size when RSS is not supported
      net: ena: return 0 in ena_get_rxfh_key_size() when RSS hash key is not configurable

Krzysztof Kozlowski (1):
      memory: samsung: exynos-srom: Correct alignment

Kunihiko Hayashi (1):
      i2c: designware: Add disabling clocks when probe fails

Kuniyuki Iwashima (2):
      udp: Fix memory accounting leak.
      tcp: Don't call reqsk_fastopen_remove() in tcp_conn_request().

LI Qingwu (1):
      USB: serial: option: add Telit FN920C04 ECM compositions

Lad Prabhakar (1):
      net: ravb: Ensure memory write completes before ringing TX doorbell

Larshin Sergey (2):
      media: rc: fix races with imon_disconnect()
      fs: udf: fix OOB read in lengthAllocDescs handling

Leilk.Liu (1):
      i2c: mediatek: fix potential incorrect use of I2C_MASTER_WRRD

Leo Yan (3):
      perf: arm_spe: Prevent overflow in PERF_IDX2OFF()
      perf session: Fix handling when buffer exceeds 2 GiB
      tools build: Align warning options with perf

Li Nan (1):
      blk-mq: check kobject state_in_sysfs before deleting in blk_mq_unregister_hctx

Lichen Liu (1):
      fs: Add 'initramfs_options' to set initramfs mount options

Lino Sanfilippo (1):
      tpm, tpm_tis: Claim locality before writing interrupt registers

Linus Walleij (1):
      mtd: rawnand: fsmc: Default to autodetect buswidth

Lukas Wunner (1):
      xen/manage: Fix suspend error path

Ma Ke (2):
      sparc: fix error handling in scan_one_device()
      media: lirc: Fix error handling in lirc_register()

Maciej W. Rozycki (1):
      MIPS: Malta: Fix keyboard resource preventing i8042 driver from registering

Mark Rutland (2):
      arm64: cputype: Add Neoverse-V3AE definitions
      arm64: errata: Apply workarounds for Neoverse-V3AE

Mathias Nyman (1):
      xhci: dbc: enable back DbC in resume if it was enabled before suspend

Michael Hennerich (2):
      iio: frequency: adf4350: Fix ADF4350_REG3_12BIT_CLKDIV_MODE
      iio: frequency: adf4350: Fix prescaler usage.

Michael Karcher (5):
      sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC
      sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC III
      sparc: fix accurate exception reporting in copy_{from_to}_user for Niagara
      sparc: fix accurate exception reporting in copy_to_user for Niagara 4
      sparc: fix accurate exception reporting in copy_{from,to}_user for M7

Michal Pecio (1):
      net: usb: rtl8150: Fix frame padding

Mikulas Patocka (1):
      dm-integrity: limit MAX_TAG_SIZE to 255

Nalivayko Sergey (1):
      net/9p: fix double req put in p9_fd_cancelled

Naman Jain (1):
      uio_hv_generic: Let userspace take care of interrupt mask

Niklas Cassel (1):
      scsi: pm80xx: Fix array-index-out-of-of-bounds on rmmod

Niklas Schnelle (2):
      PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV
      PCI/AER: Fix missing uevent on recovery when a reset is requested

Nikolay Aleksandrov (7):
      net: rtnetlink: add msg kind names
      net: rtnetlink: add helper to extract msg type's kind
      net: rtnetlink: use BIT for flag values
      net: netlink: add NLM_F_BULK delete request modifier
      net: rtnetlink: add bulk delete support flag
      net: add ndo_fdb_del_bulk
      net: rtnetlink: add NLM_F_BULK support to rtnl_fdb_del

Ojaswin Mujoo (1):
      ext4: correctly handle queries for metadata mappings

Olga Kornievskaia (1):
      nfsd: nfserr_jukebox in nlm_fopen should lead to a retry

Ovidiu Panait (2):
      staging: axis-fifo: fix maximum TX packet length check
      staging: axis-fifo: flush RX FIFO on read errors

Parav Pandit (1):
      RDMA/core: Resolve MAC of next-hop device without ARP support

Paul Chaignon (1):
      bpf: Explicitly check accesses to bpf_sock_addr

Phillip Lougher (3):
      Squashfs: fix uninit-value in squashfs_get_parent
      Squashfs: add additional inode sanity checking
      Squashfs: reject negative file sizes in squashfs_read_inode()

Pratyush Yadav (2):
      spi: cadence-quadspi: Flush posted register writes before INDAC access
      spi: cadence-quadspi: Flush posted register writes before DAC access

Qianfeng Rong (5):
      block: use int to store blk_stack_limits() return value
      ALSA: lx_core: use int type to store negative error codes
      media: i2c: mt9v111: fix incorrect type for ret
      iio: dac: ad5360: use int type to store negative error codes
      iio: dac: ad5421: use int type to store negative error codes

Rafael J. Wysocki (3):
      driver core/PM: Set power.no_callbacks along with power.no_pm
      cpufreq: intel_pstate: Fix object lifecycle issue in update_qos_request()
      Revert "cpuidle: menu: Avoid discarding useful information"

Raju Rangoju (1):
      amd-xgbe: Avoid spurious link down messages during interface toggle

Randy Dunlap (1):
      ALSA: firewire: amdtp-stream: fix enum kernel-doc warnings

Ranjan Kumar (1):
      scsi: mpt3sas: Fix crash in transport port remove by using ioc_info()

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RG255C

Renjun Wang (1):
      USB: serial: option: add UNISOC UIS7720

Rex Chen (1):
      mmc: core: SPI mode remove cmd7

Ricardo Ribalda (1):
      media: tunner: xc5000: Refactor firmware load

Rob Herring (Arm) (1):
      rtc: x1205: Fix Xicor X1205 vendor prefix

Sabrina Dubroca (2):
      tls: always set record_type in tls_process_cmsg
      tls: don't rely on tx_work during send()

Sam James (1):
      parisc: don't reference obsolete termio struct for TC* constants

Sean Christopherson (4):
      rseq/selftests: Use weak symbol reference, not definition, to link with glibc
      x86/umip: Check that the instruction opcode is at least two bytes
      x86/umip: Fix decoding of register forms of 0F 01 (SGDT and SIDT aliases)
      KVM: x86: Don't (re)check L1 intercepts when completing userspace I/O

Sergey Bashirov (2):
      NFSD: Minor cleanup in layoutcommit processing
      NFSD: Fix last write offset handling in layoutcommit

Shuhao Fu (1):
      drm/nouveau: fix bad ret code in nouveau_bo_move_prep

Siddharth Vadapalli (1):
      PCI: keystone: Use devm_request_irq() to free "ks-pcie-error-irq" on exit

Slavin Liu (1):
      ipvs: Defer ip_vs_ftp unregister during netns cleanup

Sneh Mankad (1):
      soc: qcom: rpmh-rsc: Unconditionally clear _TRIGGER bit for TCS

Stefan Kerkmann (1):
      wifi: mwifiex: send world regulatory domain to driver

Stephan Gerhold (2):
      remoteproc: qcom: q6v5: Avoid disabling handover IRQ twice
      arm64: dts: qcom: msm8916: Add missing MDSS reset

Takashi Iwai (3):
      ASoC: Intel: bytcht_es8316: Fix invalid quirk input mapping
      ASoC: Intel: bytcr_rt5640: Fix invalid quirk input mapping
      ASoC: Intel: bytcr_rt5651: Fix invalid quirk input mapping

Tetsuo Handa (4):
      media: imon: reorganize serialization
      media: imon: grab lock earlier in imon_ir_change_protocol()
      minixfs: Verify inode mode when loading from disk
      cramfs: Verify inode mode when loading from disk

Theodore Ts'o (1):
      ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()

Thomas Fourier (4):
      scsi: myrs: Fix dma_alloc_coherent() error check
      crypto: atmel - Fix dma_unmap_sg() direction
      media: cx18: Add missing check after DMA map
      media: pci: ivtv: Add missing check after DMA map

Thorsten Blum (1):
      scsi: hpsa: Fix potential memory leak in hpsa_big_passthru_ioctl()

Tim Guttzeit (1):
      usb/core/quirks: Add Huawei ME906S to wakeup quirk

Tonghao Zhang (1):
      net: bonding: fix possible peer notify event loss or dup issue

Uros Bizjak (1):
      x86/vdso: Fix output operand size of RDPID

Uwe Kleine-König (1):
      pwm: tiehrpwm: Fix corner case in clock divisor calculation

Viacheslav Dubeyko (6):
      hfsplus: fix slab-out-of-bounds read in hfsplus_strcasecmp()
      hfs: clear offset and space out of valid records in b-tree node
      hfs: make proper initalization of struct hfs_find_data
      hfsplus: fix KMSAN uninit-value issue in __hfsplus_ext_cache_extent()
      hfsplus: fix KMSAN uninit-value issue in hfsplus_delete_cat()
      hfs: fix KMSAN uninit-value issue in hfs_find_set_zero_bits()

Vincent Guittot (1):
      sched/fair: Fix pelt lost idle time detection

Vlad Dumitrescu (1):
      IB/sa: Fix sa_local_svc_timeout_ms read race

Wang Haoran (1):
      scsi: target: target_core_configfs: Add length check to avoid buffer overflow

Wang Liang (1):
      pps: fix warning in pps_register_cdev when register device fail

Wei Fang (1):
      net: enetc: correct the value of ENETC_RXB_TRUESIZE

William Wu (1):
      usb: gadget: configfs: Correctly set use_os_string at bind

Xiao Liang (1):
      padata: Reset next CPU when reorder sequence wraps around

Xiaowei Li (1):
      USB: serial: option: add SIMCom 8230C compositions

Xichao Zhao (2):
      usb: phy: twl6030: Fix incorrect type for ret
      exec: Fix incorrect type for ret

Yang Chenzhi (1):
      hfs: validate record offset in hfsplus_bmap_alloc

Yang Shi (1):
      mm: hugetlb: avoid soft lockup when mprotect to large memory area

Yangtao Li (1):
      hfsplus: return EIO when type of hidden directory mismatch in hfsplus_fill_super()

Yeounsu Moon (1):
      net: dlink: handle dma_map_single() failure properly

Yongjian Sun (1):
      ext4: increase i_disksize to offset + len in ext4_update_disksize_before_punch()

Yuan Chen (1):
      tracing: Fix race condition in kprobe initialization causing NULL pointer dereference

Yunseong Kim (1):
      perf util: Fix compression checks returning -1 as bool

Zhang Shurong (1):
      media: rj54n1cb0c: Fix memleak in rj54n1_probe()

Zhang Yi (1):
      jbd2: ensure that all ongoing I/O complete before freeing blocks

Zhen Ni (4):
      netfilter: ipset: Remove unused htable_bits in macro ahash_region
      Input: uinput - zero-initialize uinput_ff_upload_compat to avoid info leak
      clocksource/drivers/clps711x: Fix resource leaks in error paths
      memory: samsung: exynos-srom: Fix of_iomap leak in exynos_srom_probe

Zheng Qixing (1):
      dm: fix NULL pointer dereference in __dm_suspend()

Zhengchao Shao (1):
      net: rtnetlink: fix module reference count leak issue in rtnetlink_rcv_msg

gaoxiang17 (1):
      pid: Add a judgment for ns null in pid_nr_ns

hupu (1):
      perf subcmd: avoid crash in exclude_cmds when excludes is empty

keliu (1):
      media: rc: Directly use ida_free()


