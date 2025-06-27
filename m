Return-Path: <stable+bounces-158761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 790F1AEB431
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 12:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A811C20E5A
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 10:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BA3298CB0;
	Fri, 27 Jun 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uEKgm+7y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800F71E493C;
	Fri, 27 Jun 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019477; cv=none; b=E+MtbTAsPJXtaTln3/H3pJmPAQU4OEGjT7EkScwYPtZQ/M87R6HUyVAPjDfRi2+dq74tblan4qIe2QliQ0hJU0cva1GX/thTdg4vIXb0NwbJYPKvtU18AFrYCBw6Y6PHH/A3fF3RQUbN5n68c/z9eEQj4o0HX/ynj60ZkVjLjok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019477; c=relaxed/simple;
	bh=FlfCS2h43fIY8mglxJxUfZupypuSmYgshCy+QPjwIB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tCWVtclQfR8qdztKnuGvvA/aj4jEKZFLVVB9yRWmTlkM725/yfvRO/UR6YcTuncvszyPTZznUIj9lRVVSPMfJPeCBszKAt13/zr77iRAJzTMBWIGYLwmv9pAe2v8lc0GMYO0EGprH6gYmV2A9eWg/tsZBcl3eq7d4desdZ1Mkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uEKgm+7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945D8C4CEE3;
	Fri, 27 Jun 2025 10:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751019477;
	bh=FlfCS2h43fIY8mglxJxUfZupypuSmYgshCy+QPjwIB0=;
	h=From:To:Cc:Subject:Date:From;
	b=uEKgm+7yjl9wWxg0LtkNr05dzY0DU5xUxEjAOevU/Y3j9CdR5RLfqGIVHMYmFKPm9
	 cE69Zak93z2ZkGQ9D+rnUdRC86iSESGWUrCQJMX1i4cyL3fFoBNxjzzwqwICMQdsLt
	 dorlJUe71haEsiM3vSuy5rTt0R+uns59ubUcr9fU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.295
Date: Fri, 27 Jun 2025 11:17:52 +0100
Message-ID: <2025062753-heading-reacquire-60d2@gregkh>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.295 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt     |    2 
 MAINTAINERS                                         |    9 +
 Makefile                                            |    2 
 arch/arm/boot/dts/am335x-bone-common.dtsi           |    8 +
 arch/arm/boot/dts/at91sam9263ek.dts                 |    2 
 arch/arm/boot/dts/qcom-apq8064.dtsi                 |   13 -
 arch/arm/boot/dts/tny_a9263.dts                     |    2 
 arch/arm/boot/dts/usb_a9263.dts                     |    4 
 arch/arm/mach-omap2/clockdomain.h                   |    1 
 arch/arm/mach-omap2/clockdomains33xx_data.c         |    2 
 arch/arm/mach-omap2/cm33xx.c                        |   14 +-
 arch/arm/mm/ioremap.c                               |    4 
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |    8 -
 arch/arm64/kernel/ptrace.c                          |    2 
 arch/arm64/xen/hypercall.S                          |   21 ++-
 arch/m68k/mac/config.c                              |    2 
 arch/mips/Makefile                                  |    2 
 arch/mips/vdso/Makefile                             |    1 
 arch/nios2/include/asm/pgtable.h                    |   16 ++
 arch/parisc/boot/compressed/Makefile                |    1 
 arch/powerpc/kernel/eeh.c                           |    2 
 arch/s390/pci/pci_mmio.c                            |    2 
 arch/x86/boot/compressed/Makefile                   |    2 
 arch/x86/kernel/cpu/bugs.c                          |   10 -
 arch/x86/kernel/cpu/common.c                        |   17 +-
 arch/x86/kernel/cpu/mtrr/generic.c                  |    2 
 drivers/acpi/acpica/dsutils.c                       |    9 +
 drivers/acpi/acpica/psobject.c                      |   52 ++-----
 drivers/acpi/battery.c                              |   19 ++
 drivers/acpi/osi.c                                  |    1 
 drivers/ata/pata_via.c                              |    3 
 drivers/atm/atmtcp.c                                |    4 
 drivers/base/power/domain.c                         |    2 
 drivers/base/power/main.c                           |    3 
 drivers/base/power/runtime.c                        |    2 
 drivers/block/aoe/aoedev.c                          |    8 +
 drivers/bus/fsl-mc/fsl-mc-bus.c                     |    6 
 drivers/bus/fsl-mc/mc-io.c                          |   19 +-
 drivers/bus/fsl-mc/mc-sys.c                         |    2 
 drivers/bus/ti-sysc.c                               |   49 -------
 drivers/clk/rockchip/clk-rk3036.c                   |    1 
 drivers/cpufreq/cpufreq.c                           |    6 
 drivers/crypto/marvell/cipher.c                     |    3 
 drivers/crypto/marvell/hash.c                       |    2 
 drivers/edac/altera_edac.c                          |    6 
 drivers/edac/skx_common.c                           |    1 
 drivers/firmware/psci/psci.c                        |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c              |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c               |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c               |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c               |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c               |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c     |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |   18 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile       |    2 
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile       |    2 
 drivers/gpu/drm/amd/display/dc/dml/Makefile         |    3 
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c  |    5 
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c               |    2 
 drivers/gpu/drm/msm/hdmi/hdmi_i2c.c                 |   14 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c         |    2 
 drivers/gpu/drm/rcar-du/rcar_du_kms.c               |   10 -
 drivers/gpu/drm/tegra/rgb.c                         |   14 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                    |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c             |   26 +++
 drivers/hid/hid-hyperv.c                            |    5 
 drivers/hid/usbhid/hid-core.c                       |   25 ++-
 drivers/hwmon/occ/common.c                          |   28 +---
 drivers/i2c/busses/i2c-designware-slave.c           |    2 
 drivers/iio/adc/ad7606_spi.c                        |    2 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c          |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h          |    1 
 drivers/infiniband/hw/hns/hns_roce_restrack.c       |    1 
 drivers/input/misc/ims-pcu.c                        |    6 
 drivers/input/misc/sparcspkr.c                      |   22 ++-
 drivers/input/rmi4/rmi_f34.c                        |  137 +++++++++++---------
 drivers/md/dm-raid1.c                               |    5 
 drivers/media/i2c/tc358743.c                        |    4 
 drivers/media/platform/exynos4-is/fimc-is-regs.c    |    1 
 drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c      |    7 -
 drivers/media/v4l2-core/v4l2-dev.c                  |   14 +-
 drivers/mfd/exynos-lpass.c                          |    1 
 drivers/mfd/stmpe-spi.c                             |    2 
 drivers/mtd/nand/raw/sunxi_nand.c                   |    2 
 drivers/net/ethernet/cadence/macb_main.c            |    6 
 drivers/net/ethernet/dlink/dl2k.c                   |   14 +-
 drivers/net/ethernet/dlink/dl2k.h                   |    2 
 drivers/net/ethernet/emulex/benet/be_cmds.c         |    2 
 drivers/net/ethernet/intel/i40e/i40e_common.c       |    7 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c  |   11 +
 drivers/net/ethernet/intel/ice/ice_sched.c          |   11 -
 drivers/net/ethernet/mellanox/mlx4/en_clock.c       |    2 
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c     |    1 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c   |   13 +
 drivers/net/ethernet/microchip/lan743x_main.c       |    4 
 drivers/net/phy/mdio_bus.c                          |   16 ++
 drivers/net/usb/aqc111.c                            |   10 +
 drivers/net/usb/ch9200.c                            |    7 -
 drivers/net/vxlan.c                                 |    8 -
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c     |    3 
 drivers/net/wireless/ath/carl9170/usb.c             |   19 +-
 drivers/net/wireless/intersil/p54/fwio.c            |    2 
 drivers/net/wireless/intersil/p54/p54.h             |    1 
 drivers/net/wireless/intersil/p54/txrx.c            |   13 +
 drivers/net/wireless/realtek/rtlwifi/pci.c          |   10 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c       |    3 
 drivers/pci/pci.c                                   |    3 
 drivers/pci/quirks.c                                |   23 +++
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c         |   35 +++--
 drivers/pinctrl/pinctrl-at91.c                      |    6 
 drivers/platform/Kconfig                            |    2 
 drivers/platform/Makefile                           |    1 
 drivers/platform/surface/Kconfig                    |   14 ++
 drivers/platform/surface/Makefile                   |    5 
 drivers/platform/x86/dell_rbu.c                     |    2 
 drivers/power/supply/bq27xxx_battery.c              |    2 
 drivers/power/supply/bq27xxx_battery_i2c.c          |   13 +
 drivers/rapidio/rio_cm.c                            |    3 
 drivers/regulator/max14577-regulator.c              |    5 
 drivers/rpmsg/qcom_smd.c                            |    2 
 drivers/rtc/Kconfig                                 |   10 +
 drivers/rtc/Makefile                                |    1 
 drivers/rtc/class.c                                 |    2 
 drivers/rtc/lib.c                                   |  127 ++++++++++++++----
 drivers/rtc/lib_test.c                              |   79 +++++++++++
 drivers/rtc/rtc-sh.c                                |   12 +
 drivers/s390/scsi/zfcp_sysfs.c                      |    2 
 drivers/scsi/lpfc/lpfc_sli.c                        |    4 
 drivers/scsi/qedf/qedf_main.c                       |    2 
 drivers/scsi/scsi_transport_iscsi.c                 |   11 -
 drivers/scsi/storvsc_drv.c                          |   10 -
 drivers/soc/aspeed/aspeed-lpc-snoop.c               |   17 ++
 drivers/spi/spi-sh-msiof.c                          |   13 +
 drivers/staging/iio/impedance-analyzer/ad5933.c     |    2 
 drivers/tee/tee_core.c                              |   11 -
 drivers/thunderbolt/ctl.c                           |    5 
 drivers/tty/serial/milbeaut_usio.c                  |    5 
 drivers/tty/vt/vt_ioctl.c                           |    2 
 drivers/uio/uio_hv_generic.c                        |    4 
 drivers/usb/class/usbtmc.c                          |    4 
 drivers/usb/core/hub.c                              |   16 ++
 drivers/usb/core/quirks.c                           |    3 
 drivers/usb/gadget/function/f_hid.c                 |   12 -
 drivers/usb/renesas_usbhs/common.c                  |   50 +++++--
 drivers/usb/storage/unusual_uas.h                   |    7 +
 drivers/video/console/vgacon.c                      |    2 
 drivers/video/fbdev/core/fbcvt.c                    |    2 
 drivers/video/fbdev/core/fbmem.c                    |    4 
 drivers/watchdog/da9052_wdt.c                       |    1 
 fs/configfs/dir.c                                   |    2 
 fs/ext4/extents.c                                   |   11 -
 fs/ext4/inline.c                                    |    2 
 fs/f2fs/data.c                                      |    2 
 fs/f2fs/f2fs.h                                      |   10 +
 fs/f2fs/namei.c                                     |   19 ++
 fs/f2fs/super.c                                     |    4 
 fs/filesystems.c                                    |   14 +-
 fs/gfs2/inode.c                                     |    3 
 fs/gfs2/lock_dlm.c                                  |    3 
 fs/jbd2/transaction.c                               |    3 
 fs/jffs2/erase.c                                    |    4 
 fs/jffs2/scan.c                                     |    4 
 fs/jffs2/summary.c                                  |    7 -
 fs/jfs/jfs_discard.c                                |    3 
 fs/jfs/jfs_dtree.c                                  |   18 ++
 fs/namespace.c                                      |    4 
 fs/nfsd/nfs3xdr.c                                   |    2 
 fs/nfsd/nfs4proc.c                                  |    3 
 fs/nfsd/vfs.c                                       |    4 
 fs/nilfs2/btree.c                                   |    4 
 fs/nilfs2/direct.c                                  |    3 
 fs/squashfs/super.c                                 |    5 
 include/acpi/actypes.h                              |    2 
 include/linux/atmdev.h                              |    6 
 include/linux/hid.h                                 |    3 
 include/trace/events/erofs.h                        |   18 --
 include/uapi/linux/videodev2.h                      |    1 
 ipc/shm.c                                           |    5 
 kernel/events/core.c                                |   23 ++-
 kernel/exit.c                                       |   17 +-
 kernel/power/wakelock.c                             |    3 
 kernel/time/posix-cpu-timers.c                      |    9 +
 kernel/trace/bpf_trace.c                            |    2 
 kernel/trace/ftrace.c                               |   10 +
 kernel/trace/trace.c                                |    2 
 mm/huge_memory.c                                    |    2 
 mm/page-writeback.c                                 |    2 
 net/atm/common.c                                    |    1 
 net/atm/lec.c                                       |   12 +
 net/atm/raw.c                                       |    2 
 net/bluetooth/l2cap_core.c                          |    3 
 net/bridge/netfilter/nf_conntrack_bridge.c          |   12 -
 net/core/sock.c                                     |    4 
 net/ipv4/route.c                                    |    4 
 net/ipv4/tcp_input.c                                |   63 +++++----
 net/ipv6/calipso.c                                  |    8 +
 net/ipv6/netfilter.c                                |   12 -
 net/ipv6/netfilter/nft_fib_ipv6.c                   |   13 +
 net/mac80211/mesh_hwmp.c                            |    6 
 net/mpls/af_mpls.c                                  |    4 
 net/ncsi/internal.h                                 |   21 +--
 net/ncsi/ncsi-pkt.h                                 |   23 +--
 net/ncsi/ncsi-rsp.c                                 |   21 +--
 net/netfilter/nft_socket.c                          |    3 
 net/netlabel/netlabel_kapi.c                        |    5 
 net/nfc/nci/uart.c                                  |    8 -
 net/sched/sch_prio.c                                |    2 
 net/sched/sch_red.c                                 |    2 
 net/sched/sch_sfq.c                                 |    5 
 net/sched/sch_tbf.c                                 |    2 
 net/sctp/socket.c                                   |    3 
 net/sunrpc/cache.c                                  |    2 
 net/sunrpc/xprtrdma/verbs.c                         |    2 
 net/tipc/udp_media.c                                |    4 
 net/tls/tls_sw.c                                    |    7 +
 security/selinux/xfrm.c                             |    2 
 sound/pci/hda/hda_intel.c                           |    2 
 sound/pci/hda/patch_realtek.c                       |    1 
 tools/perf/builtin-record.c                         |    2 
 tools/perf/scripts/python/exported-sql-viewer.py    |    5 
 tools/perf/tests/switch-tracking.c                  |    2 
 tools/perf/ui/browsers/hists.c                      |    2 
 tools/testing/selftests/seccomp/seccomp_bpf.c       |    7 -
 223 files changed, 1298 insertions(+), 652 deletions(-)

Aditya Dutt (1):
      jfs: fix array-index-out-of-bounds read in add_missing_indices

Adrian Hunter (1):
      perf scripts python: exported-sql-viewer.py: Fix pattern matching with Python 3

Ahmed S. Darwish (1):
      x86/cpu: Sanitize CPUID(0x80000000) output

Ahmed Salem (1):
      ACPICA: Avoid sequence overread in call to strncmp()

Akhil P Oommen (1):
      drm/msm/a6xx: Increase HFI response timeout

Al Viro (1):
      do_change_type(): refuse to operate on unmounted/not ours mounts

Alex Deucher (5):
      drm/amdgpu/gfx6: fix CSIB handling
      drm/amdgpu/gfx10: fix CSIB handling
      drm/amdgpu/gfx7: fix CSIB handling
      drm/amdgpu/gfx8: fix CSIB handling
      drm/amdgpu/gfx9: fix CSIB handling

Alexander Aring (1):
      gfs2: move msleep to sleepable context

Alexander Sverdlin (1):
      Revert "bus: ti-sysc: Probe for l4_wkup and l4_cfg interconnect devices first"

Alexandre Mergnat (2):
      rtc: Fix offset calculation for .start_secs < 0
      rtc: Make rtc_time64_to_tm() support dates before 1970

Alexey Gladkov (1):
      mfd: stmpe-spi: Correct the name used in MODULE_DEVICE_TABLE

Alok Tiwari (2):
      scsi: iscsi: Fix incorrect error path labels for flashnode operations
      emulex/benet: correct command version selection in be_cmd_get_stats()

Amber Lin (1):
      drm/amdkfd: Set SDMA_RLCx_IB_CNTL/SWITCH_INSIDE_IB

Andreas Gruenbacher (1):
      gfs2: gfs2_create_inode error handling fix

Andrew Lunn (1):
      net: mdio: C22 is now optional, EOPNOTSUPP if not provided

Andrew Morton (1):
      drivers/rapidio/rio_cm.c: prevent possible heap overwrite

Andy Shevchenko (1):
      pinctrl: at91: Fix possible out-of-boundary access

Armin Wolf (1):
      ACPI: OSI: Stop advertising support for "3.0 _SCP Extensions"

Arnaldo Carvalho de Melo (1):
      perf ui browser hists: Set actions->thread before calling do_zoom_thread()

Arnd Bergmann (2):
      parisc: fix building with gcc-15
      hwmon: (occ) fix unaligned accesses

Artem Sadovnikov (1):
      jffs2: check that raw node were preallocated before writing summary

Benjamin Berg (1):
      wifi: mac80211: do not offer a mesh path if forwarding is disabled

Biju Das (2):
      drm: rcar-du: Fix memory leak in rcar_du_vsps_init()
      drm/tegra: rgb: Fix the unbound reference count

Breno Leitao (1):
      Revert "x86/bugs: Make spectre user default depend on MITIGATION_SPECTRE_V2" on v6.6 and older

Cassio Neri (1):
      rtc: Improve performance of rtc_time64_to_tm(). Add tests.

Chao Yu (2):
      f2fs: fix to do sanity check on sbi->total_valid_block_count
      f2fs: clean up w/ fscrypt_is_bounce_page()

Charan Teja Kalla (1):
      PM: runtime: fix denying of auto suspend in pm_suspend_timer_fn()

Christian Lamparter (1):
      wifi: p54: prevent buffer-overflow in p54_rx_eeprom_readback()

Christophe JAILLET (1):
      mfd: exynos-lpass: Avoid calling exynos_lpass_disable() twice in exynos_lpass_remove()

Chuck Lever (2):
      NFSD: Fix ia_size underflow
      NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes

Colin Foster (1):
      ARM: dts: am335x-bone-common: Increase MDIO reset deassert time

Damon Ding (1):
      drm/bridge: analogix_dp: Add irq flag IRQF_NO_AUTOEN instead of calling disable_irq()

Dan Aloni (1):
      xprtrdma: fix pointer derefs in error cases of rpcrdma_ep_create

Dan Carpenter (4):
      rpmsg: qcom_smd: Fix uninitialized return variable in __qcom_smd_send()
      net/mlx4_en: Prevent potential integer overflow calculating Hz
      pmdomain: core: Fix error checking in genpd_dev_pm_attach_by_id()
      Input: ims-pcu - check record size in ims_pcu_flash_firmware()

Daniel Wagner (1):
      scsi: lpfc: Use memcpy() for BIOS version

Dapeng Mi (1):
      perf record: Fix incorrect --user-regs comments

Dave Penkler (1):
      usb: usbtmc: Fix timeout value in get_stb

David Gow (1):
      rtc: test: Fix invalid format specifier.

David Lechner (1):
      iio: adc: ad7606_spi: fix reg write value mask

Dexuan Cui (1):
      scsi: storvsc: Increase the timeouts to storvsc_timeout

Dmitry Antipov (2):
      wifi: rtw88: do not ignore hardware read error during DPK
      wifi: carl9170: do not ping device which has failed to load firmware

Dmitry Baryshkov (2):
      ARM: dts: qcom: apq8064 merge hw splinlock into corresponding syscon device
      drm/msm/hdmi: add runtime PM calls to DDC transfer function

Dmitry Torokhov (1):
      Input: synaptics-rmi - fix crash with unsupported versions of F34

Dylan Wolff (1):
      jfs: Fix null-ptr-deref in jfs_ioc_trim

Eric Dumazet (9):
      net_sched: sch_sfq: fix a potential crash on gso_skb handling
      net_sched: prio: fix a race in prio_tune()
      net_sched: red: fix a race in __red_change()
      net_sched: tbf: fix a race in tbf_change()
      calipso: unlock rcu before returning -EAFNOSUPPORT
      tcp: always seek for minimal rtt in tcp_rcv_rtt_update()
      tcp: fix initial tp->rcvq_space.space value for passive TS enabled flows
      net: atm: add lec_mutex
      net: atm: fix /proc/net/atm/lec handling

Fedor Pchelkin (1):
      jffs2: check jffs2_prealloc_raw_node_refs() result in few other places

Finn Thain (1):
      m68k: mac: Fix macintosh_config for Mac II

Florian Westphal (2):
      netfilter: nft_socket: fix sk refcount leaks
      netfilter: nf_tables: nft_fib_ipv6: fix VRF ipv4/ipv6 result discrepancy

GONG Ruiqi (1):
      vgacon: Add check for vc_origin address range in vgacon_scroll()

Gabor Juhos (6):
      pinctrl: armada-37xx: use correct OUTPUT_VAL register for GPIOs > 31
      pinctrl: armada-37xx: set GPIO output value before setting direction
      pinctrl: armada-37xx: propagate error from armada_37xx_pmx_set_by_name()
      pinctrl: armada-37xx: propagate error from armada_37xx_gpio_get_direction()
      pinctrl: armada-37xx: propagate error from armada_37xx_pmx_gpio_set_direction()
      pinctrl: armada-37xx: propagate error from armada_37xx_gpio_get()

Gabriel Shahrouzi (1):
      staging: iio: ad5933: Correct settling cycles encoding per datasheet

Gao Xiang (1):
      erofs: remove unused trace event erofs_destroy_inode

Gavin Guo (1):
      mm/huge_memory: fix dereferencing invalid pmd migration entry

Geert Uytterhoeven (2):
      spi: sh-msiof: Fix maximum DMA transfer size
      ARM: dts: am335x-bone-common: Increase MDIO reset deassert delay to 50ms

Greg Kroah-Hartman (1):
      Linux 5.4.295

Haixia Qu (1):
      tipc: fix null-ptr-deref when acquiring remote ip of ethernet bearer

Hans Verkuil (1):
      media: tc358743: ignore video while HPD is low

Hari Kalavakunta (1):
      net: ncsi: Fix GCPS 64-bit member variables

Heiko Carstens (1):
      s390/pci: Fix __pcilg_mio_inuser() inline assembly

Heiko Stuebner (1):
      clk: rockchip: rk3036: mark ddrphy as critical

Henry Martin (2):
      soc: aspeed: Add NULL check in aspeed_lpc_enable_snoop()
      serial: Fix potential null-ptr-deref in mlb_usio_probe()

Herbert Xu (2):
      crypto: marvell/cesa - Handle zero-length skcipher requests
      crypto: marvell/cesa - Avoid empty transfer descriptor

Hongyu Xie (1):
      usb: storage: Ignore UAS driver for SanDisk 3.2 Gen2 storage device

Huacai Chen (1):
      PCI: Add ACS quirk for Loongson PCIe

Huajian Yang (1):
      netfilter: bridge: Move specific fragmented packet to slow_path instead of dropping it

Ian Forbes (1):
      drm/vmwgfx: Add seqno waiter for sync_files

Ido Schimmel (1):
      vxlan: Do not treat dst cache initialization errors as fatal

Ilpo Järvinen (1):
      PCI: Fix lock symmetry in pci_slot_unlock()

Ioana Ciornei (2):
      bus: fsl-mc: fix double-free on mc_dev
      bus: fsl-mc: do not add a device-link for the UAPI used DPMCP device

Jacob Keller (1):
      drm/nouveau/bl: increase buffer size to avoid truncate warning

Jaegeuk Kim (1):
      f2fs: prevent kernel warning due to negative i_nlink from corrupted image

Jakub Raczynski (1):
      net/mdiobus: Fix potential out-of-bounds read/write access

Jan Kara (1):
      ext4: fix calculation of credits for extent tree modification

Jann Horn (1):
      tee: Prevent size calculation wraparound on 32-bit kernels

Jason Xing (1):
      net: mlx4: add SOF_TIMESTAMPING_TX_SOFTWARE flag when getting ts info

Jeongjun Park (2):
      ipc: fix to protect IPCS lookups using RCU
      jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()

Jerry Lv (1):
      power: supply: bq27xxx: Retrieve again when busy

Jiaqing Zhao (1):
      x86/mtrr: Check if fixed-range MTRRs exist in mtrr_save_fixed_ranges()

Jiayi Li (1):
      usb: quirks: Add NO_LPM quirk for SanDisk Extreme 55AE

Jiayuan Chen (1):
      ktls, sockmap: Fix missing uncharge operation

Jinliang Zheng (1):
      mm: fix ratelimit_pages update error in dirty_ratio_handler()

Jonathan Lane (1):
      ALSA: hda/realtek: enable headset mic on Latitude 5420 Rugged

Junxian Huang (1):
      RDMA/hns: Include hnae3.h in hns_roce_hw_v2.h

Justin Sanders (1):
      aoe: clean device rq_list in aoedev_downdev()

Kees Cook (2):
      drm/vkms: Adjust vkms_state->active_planes allocation type
      scsi: qedf: Use designated initializer for struct qed_fcoe_cb_ops

Khem Raj (1):
      mips: Add -std= flag specified in KBUILD_CFLAGS to vdso CFLAGS

Krzysztof Kozlowski (1):
      NFC: nci: uart: Set tty->disc_data only in success path

Kuniyuki Iwashima (5):
      calipso: Don't call calipso functions for AF_INET sk.
      atm: Revert atm_account_tx() if copy_from_iter_full() fails.
      mpls: Use rcu_dereference_rtnl() in mpls_route_input_rcu().
      atm: atmtcp: Free invalid length skb in atmtcp_c_send().
      calipso: Fix null-ptr-deref in calipso_req_{set,del}attr().

Kyungwook Boo (1):
      i40e: fix MMIO write access to an invalid page in i40e_clear_hw

Lad Prabhakar (1):
      usb: renesas_usbhs: Reorder clock handling and power management in probe

Laurentiu Tudor (1):
      bus: fsl-mc: increase MC_CMD_COMPLETION_TIMEOUT_MS value

Leo Yan (1):
      perf tests switch-tracking: Fix timestamp comparison

Long Li (2):
      uio_hv_generic: Use correct size for interrupt and monitor pages
      sunrpc: update nextcheck time when adding new cache entries

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix not responding with L2CAP_CR_LE_ENCRYPTION

Ma Ke (1):
      media: v4l2-dev: fix error handling in __video_register_device()

Marcus Folkesson (1):
      watchdog: da9052_wdt: respect TWDMIN

Mathias Nyman (1):
      usb: Flush altsetting 0 endpoints before reinitializating them after reset.

Maximilian Luz (1):
      platform: Add Surface platform directory

Miaoqian Lin (1):
      firmware: psci: Fix refcount leak in psci_dt_init

Michal Kubiak (1):
      ice: create new Tx scheduler nodes for new queues only

Mikulas Patocka (1):
      dm-mirror: fix a tiny race condition

Mingcong Bai (1):
      wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723

Moon Yeounsu (1):
      net: dlink: add synchronization for stats update

Murad Masimov (1):
      fbdev: Fix fb_set_var to prevent null-ptr-deref in fb_videomode_to_var

Narayana Murty N (1):
      powerpc/eeh: Fix missing PE bridge reconfiguration during VFIO EEH recovery

Nas Chung (1):
      media: uapi: v4l: Fix V4L2_TYPE_IS_OUTPUT condition

Nathan Chancellor (3):
      MIPS: Move '-Wa,-msoft-float' check from as-option to cc-option
      drm/amd/display: Do not add '-mhard-float' to dml_ccflags for clang
      drm/amd/display: Do not add '-mhard-float' to dcn2{1,0}_resource.o for clang

Neal Cardwell (1):
      tcp: fix tcp_packet_delayed() for tcp_is_non_sack_preventing_reopen() behavior

NeilBrown (1):
      nfsd: nfsd4_spo_must_allow() must check this is a v4 compound request

Neill Kapron (1):
      selftests/seccomp: fix syscall_restart test for arm compat

Nick Desaulniers (1):
      x86/boot/compressed: prefer cc-option for CFLAGS additions

Nicolas Pitre (1):
      vt: remove VT_RESIZE and VT_RESIZEX from vt_compat_ioctl()

Nikita Zhandarovich (1):
      net: usb: aqc111: fix error handling of usbnet read calls

Niravkumar L Rabara (1):
      EDAC/altera: Use correct write width with the INTTEST register

Oleg Nesterov (1):
      posix-cpu-timers: fix race between handle_posix_cpu_timers() and posix_cpu_timer_del()

Oliver Neukum (1):
      net: usb: aqc111: debug info before sanitation

Pan Taixi (1):
      tracing: Fix compilation warning on arm32

Patrisious Haddad (1):
      net/mlx5: Fix return value when searching for existing flow group

Paul Blakey (1):
      net/mlx5: Wait for inactive autogroups

Peter Marheine (1):
      ACPI: battery: negate current when discharging

Peter Oberparleiter (1):
      scsi: s390: zfcp: Ensure synchronous unit_add

Peter Zijlstra (1):
      perf: Fix sample vs do_exit()

Petr Malat (1):
      sctp: Do not wake readers in __sctp_write_space()

Phillip Lougher (1):
      Squashfs: check return result of sb_min_blocksize

Qasim Ijaz (1):
      net: ch9200: fix uninitialised access during mii_nway_restart

Qing Wang (1):
      perf/core: Fix broken throttling when max_samples_per_tick=1

Qiuxu Zhuo (1):
      EDAC/skx_common: Fix general protection fault

Quentin Schulz (1):
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma with Haikou

Rafael J. Wysocki (1):
      PM: sleep: Fix power.is_suspended cleanup for direct-complete devices

Robert Malz (2):
      i40e: return false from i40e_reset_vf if reset is in progress
      i40e: retry VFLR handling if there is ongoing VF reset

Ross Stutterheim (1):
      ARM: 9447/1: arm/memremap: fix arch_memremap_can_ram_remap()

Ryusuke Konishi (1):
      nilfs2: do not propagate ENOENT error from nilfs_btree_propagate()

Sebastian Andrzej Siewior (1):
      ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT

Sergey Senozhatsky (1):
      thunderbolt: Do not double dequeue a configuration request

Sergey Shtylyov (1):
      fbdev: core: fbcvt: avoid division by 0 in fb_cvt_hperiod()

Sergio Perez Gonzalez (1):
      net: macb: Check return value of dma_set_mask_and_coherent()

Seunghun Han (2):
      ACPICA: fix acpi operand cache leak in dswstate.c
      ACPICA: fix acpi parse and parseext cache leaks

Shengyu Qu (1):
      ARM: dts: am335x-bone-common: Add GPIO PHY reset on revision C3 board

Simon Schuster (1):
      nios2: force update_mmu_cache on spurious tlb-permission--related pagefaults

Srinivasan Shanmugam (1):
      drm/amd/display: Add NULL pointer checks in dm_force_atomic_commit()

Stefano Stabellini (1):
      xen/arm: call uaccess_ttbr0_enable for dm_op hypercall

Stephen Smalley (1):
      selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len

Stuart Hayes (1):
      platform/x86: dell_rbu: Stop overwriting data buffer

Su Hui (1):
      soc: aspeed: lpc: Fix impossible judgment condition

Sukrut Bellary (1):
      ARM: OMAP2+: Fix l4ls clk domain handling in STANDBY

Takashi Iwai (1):
      ALSA: hda/intel: Add Thinkpad E15 to PM deny list

Tan En De (1):
      i2c: designware: Invoke runtime suspend on quick slave re-registration

Tao Chen (1):
      bpf: Fix WARN() in get_bpf_raw_tp_regs

Tasos Sahanidis (1):
      ata: pata_via: Force PIO for ATAPI devices on VT6415/VT6330

Tengda Wu (1):
      arm64/ptrace: Fix stack-out-of-bounds read in regs_get_kernel_stack_nth()

Terry Junge (1):
      HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()

Thadeu Lima de Souza Cascardo (1):
      ext4: inline: fix len overflow in ext4_prepare_inline_data

Thangaraj Samynathan (1):
      net: lan743x: rename lan743x_reset_phy to lan743x_hw_reset_phy

Toke Høiland-Jørgensen (1):
      wifi: ath9k_htc: Abort software beacon handling if disabled

Viresh Kumar (1):
      cpufreq: Force sync policy boost with global boost on sysfs update

WangYuli (1):
      Input: sparcspkr - avoid unannotated fall-through

Wentao Liang (6):
      nilfs2: add pointer check for nilfs_direct_propagate()
      media: gspca: Add error handling for stv06xx_read_sensor()
      mtd: rawnand: sunxi: Add randomizer configuration in sunxi_nfc_hw_ecc_write_chunk
      mtd: nand: sunxi: Add randomizer configuration before randomizer enable
      regulator: max14577: Add error check for max14577_read_reg()
      media: platform: exynos4-is: Add hardware sync wait to fimc_is_hw_change_mode()

Wolfram Sang (3):
      ARM: dts: at91: usb_a9263: fix GPIO for Dataflash chip select
      ARM: dts: at91: at91sam9263: fix NAND chip selects
      rtc: sh: assign correct interrupts with DT

Ye Bin (1):
      ftrace: Fix UAF when lookup kallsym after ftrace disabled

Zhiguo Niu (2):
      f2fs: use d_inode(dentry) cleanup dentry->d_inode
      f2fs: fix to correct check conditions in f2fs_cross_rename

Zijun Hu (4):
      PM: wakeup: Delete space in the end of string shown by pm_show_wakelocks()
      fs/filesystems: Fix potential unsigned integer underflow in fs_name()
      configfs: Do not override creating attribute file failure in populate_attrs()
      sock: Correct error checking condition for (assign|release)_proto_idx()

zhang songyi (1):
      Input: synaptics-rmi4 - convert to use sysfs_emit() APIs


