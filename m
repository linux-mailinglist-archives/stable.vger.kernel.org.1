Return-Path: <stable+bounces-100127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18B59E90DD
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0024163636
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 10:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C39216E24;
	Mon,  9 Dec 2024 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j1H12ogl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E0521859C;
	Mon,  9 Dec 2024 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741316; cv=none; b=VNi0j13y02zIMuJGd+cy5TPkFwjxuJFq8B1rupK3Mo+brEjiRaqAQvFptudzJWXZEhi8eQ84tqpaXTX7GmJ9BWiGSymA4cTm9GL5TOnpfwHpzfS8qBEnehndF7Np3jggdiQivQxBGkokAMgWfkxoFeiqroU5/DISkGhrnGTx86M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741316; c=relaxed/simple;
	bh=dRWI9i8Nnx6uBSaUzJiDFG0anFwDCO6WxWGj8RnZ7bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yzo6CSOh77t/azsvgjQtch8z6+DyY6wEEo9anp2xFRNY6fS7NiAIZWCOZOS7AVibN0cZ0nD/6d6ykO38BwcZIpmbSxKPfqXWxrDgq/BjjFPDKMzyhdVx8hcNIz0LUL7CqxVZsU7en0Stgzgx0g4zHCbqB/aqhDiEmCXAF14W79A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j1H12ogl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0532DC4CEDE;
	Mon,  9 Dec 2024 10:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733741315;
	bh=dRWI9i8Nnx6uBSaUzJiDFG0anFwDCO6WxWGj8RnZ7bc=;
	h=From:To:Cc:Subject:Date:From;
	b=j1H12oglF/SWC/vt29qvzXKTuOj7Sgvv8xTyrzC4f8UmkefDUy4gq/7nalWmboN3h
	 Ybq7yfCLK4P/4AHZBsl7STsJYDb9TIfj/I7JfW4aSqkUECTvki+KkvOMHD/wYzPswL
	 yn4LdHiKMQoC2tAJzIVZFVrrlnvcaTIchfhMi08s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.4
Date: Mon,  9 Dec 2024 11:48:17 +0100
Message-ID: <2024120917-vision-outcast-85f2@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.4 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/net/fsl,fec.yaml              |    7 
 Makefile                                                        |    2 
 arch/arm/kernel/entry-armv.S                                    |    8 
 arch/arm/mm/ioremap.c                                           |   35 ++-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi         |    3 
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi                |    2 
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi                |    2 
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi                |    6 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                      |    2 
 arch/powerpc/Kconfig                                            |    4 
 arch/powerpc/Makefile                                           |   13 -
 arch/powerpc/kernel/vdso/Makefile                               |    8 
 arch/s390/kernel/entry.S                                        |    4 
 arch/s390/kernel/kprobes.c                                      |    6 
 arch/s390/kernel/stacktrace.c                                   |    2 
 drivers/android/binder.c                                        |   64 ++++--
 drivers/base/core.c                                             |   55 ++---
 drivers/block/zram/zram_drv.c                                   |    7 
 drivers/clk/qcom/gcc-qcs404.c                                   |    1 
 drivers/cpufreq/scmi-cpufreq.c                                  |    4 
 drivers/firmware/efi/libstub/efi-stub.c                         |    2 
 drivers/gpu/drm/Kconfig                                         |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                         |    6 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c                         |    9 
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c                   |    2 
 drivers/gpu/drm/amd/display/dc/core/dc.c                        |    3 
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c          |   15 -
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c     |   23 ++
 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h  |    2 
 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h |   13 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                       |    8 
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h                    |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c               |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c            |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c                  |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c            |   33 ++-
 drivers/gpu/drm/bridge/ite-it6505.c                             |    8 
 drivers/gpu/drm/drm_atomic_helper.c                             |    2 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                        |    3 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                          |    4 
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c                |    1 
 drivers/gpu/drm/radeon/radeon_connectors.c                      |   10 
 drivers/gpu/drm/sti/sti_cursor.c                                |    3 
 drivers/gpu/drm/sti/sti_gdp.c                                   |    3 
 drivers/gpu/drm/sti/sti_hqvdp.c                                 |    3 
 drivers/gpu/drm/xe/xe_guc_submit.c                              |   17 +
 drivers/gpu/drm/xe/xe_migrate.c                                 |    6 
 drivers/gpu/drm/xlnx/zynqmp_kms.c                               |    4 
 drivers/i3c/master.c                                            |    2 
 drivers/i3c/master/svc-i3c-master.c                             |   39 ++-
 drivers/iio/accel/kionix-kx022a.c                               |    2 
 drivers/iio/adc/ad7780.c                                        |    2 
 drivers/iio/adc/ad7923.c                                        |    4 
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c          |    4 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c               |    2 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                |    3 
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c                   |    1 
 drivers/iio/industrialio-gts-helper.c                           |    2 
 drivers/iio/inkern.c                                            |    2 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                  |    2 
 drivers/iommu/arm/arm-smmu/arm-smmu.c                           |   11 +
 drivers/iommu/io-pgtable-arm.c                                  |   18 +
 drivers/leds/flash/leds-mt6360.c                                |    3 
 drivers/leds/leds-lp55xx-common.c                               |    3 
 drivers/md/dm-thin.c                                            |    1 
 drivers/md/md-bitmap.c                                          |    1 
 drivers/md/persistent-data/dm-space-map-common.c                |    2 
 drivers/md/raid5.c                                              |    4 
 drivers/media/dvb-frontends/ts2020.c                            |    8 
 drivers/media/i2c/dw9768.c                                      |   10 
 drivers/media/i2c/ov08x40.c                                     |   33 ++-
 drivers/media/i2c/tc358743.c                                    |    4 
 drivers/media/platform/allegro-dvt/allegro-core.c               |    4 
 drivers/media/platform/amphion/vpu_drv.c                        |    2 
 drivers/media/platform/amphion/vpu_v4l2.c                       |    2 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c            |   10 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c          |   11 -
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                  |    4 
 drivers/media/platform/qcom/camss/camss.c                       |   19 -
 drivers/media/platform/qcom/venus/core.c                        |    2 
 drivers/media/platform/rockchip/rga/rga.c                       |    2 
 drivers/media/platform/samsung/exynos4-is/media-dev.h           |    5 
 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c |    3 
 drivers/media/usb/gspca/ov534.c                                 |    2 
 drivers/media/usb/uvc/uvc_driver.c                              |  102 +++++++---
 drivers/mtd/nand/spi/winbond.c                                  |   16 -
 drivers/net/ethernet/freescale/fec_ptp.c                        |   11 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c               |    3 
 drivers/net/netkit.c                                            |   68 +++++-
 drivers/net/phy/dp83869.c                                       |   20 +
 drivers/nvmem/core.c                                            |    2 
 drivers/pci/controller/dwc/pci-imx6.c                           |   57 ++++-
 drivers/pci/controller/dwc/pci-keystone.c                       |   12 +
 drivers/pci/controller/dwc/pcie-designware-ep.c                 |    2 
 drivers/pci/controller/dwc/pcie-qcom.c                          |    2 
 drivers/pci/controller/pcie-rockchip-ep.c                       |   16 +
 drivers/pci/controller/pcie-rockchip.h                          |    4 
 drivers/pci/endpoint/pci-epc-core.c                             |   11 -
 drivers/pci/of_property.c                                       |    2 
 drivers/remoteproc/qcom_q6v5_pas.c                              |    2 
 drivers/spmi/spmi-pmic-arb.c                                    |    3 
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c         |    2 
 drivers/ufs/host/ufs-exynos.c                                   |   23 +-
 drivers/vfio/pci/qat/main.c                                     |    2 
 fs/btrfs/btrfs_inode.h                                          |   12 -
 fs/btrfs/ctree.c                                                |    6 
 fs/btrfs/extent-tree.c                                          |    2 
 fs/btrfs/inode.c                                                |   94 ++++-----
 fs/btrfs/ioctl.c                                                |   32 +++
 fs/btrfs/ref-verify.c                                           |    1 
 fs/btrfs/send.c                                                 |    2 
 fs/ceph/mds_client.c                                            |    7 
 fs/ceph/super.c                                                 |   10 
 fs/f2fs/segment.c                                               |   16 -
 fs/f2fs/super.c                                                 |   12 +
 fs/nfsd/export.c                                                |    5 
 fs/nfsd/nfs4state.c                                             |   19 +
 fs/overlayfs/inode.c                                            |    7 
 fs/overlayfs/util.c                                             |    3 
 fs/proc/kcore.c                                                 |    1 
 fs/quota/dquot.c                                                |    2 
 fs/xfs/libxfs/xfs_sb.c                                          |    7 
 include/drm/drm_panic.h                                         |   14 +
 include/linux/kasan.h                                           |   12 -
 include/linux/util_macros.h                                     |   56 +++--
 include/uapi/linux/if_link.h                                    |   15 +
 kernel/signal.c                                                 |    9 
 kernel/trace/ftrace.c                                           |    7 
 lib/kunit/debugfs.c                                             |    5 
 lib/kunit/kunit-test.c                                          |    2 
 lib/maple_tree.c                                                |   13 +
 mm/damon/tests/vaddr-kunit.h                                    |    1 
 mm/damon/vaddr.c                                                |    4 
 mm/kasan/shadow.c                                               |   14 -
 mm/slab.h                                                       |    5 
 mm/slab_common.c                                                |    2 
 mm/slub.c                                                       |    9 
 mm/vmalloc.c                                                    |   34 ++-
 mm/vmstat.c                                                     |    1 
 tools/perf/pmu-events/empty-pmu-events.c                        |   12 -
 tools/perf/pmu-events/jevents.py                                |   12 -
 142 files changed, 1054 insertions(+), 431 deletions(-)

Adrian Huang (1):
      mm/vmalloc: combine all TLB flush operations of KASAN shadow virtual address into one operation

Alex Deucher (1):
      Revert "drm/radeon: Delay Connector detecting when HPD singals is unstable"

Alexander Shiyan (1):
      media: i2c: tc358743: Fix crash in the probe error path when using polling

Alexandru Ardelean (1):
      util_macros.h: fix/rework find_closest() macros

Andrea della Porta (1):
      PCI: of_property: Assign PCI instead of CPU bus address to dynamic PCI nodes

Ard Biesheuvel (1):
      efi/libstub: Free correct pointer on failure

Ashutosh Dixit (1):
      Revert "drm/xe/xe_guc_ads: save/restore OA registers and allowlist regs"

Balaji Pothunoori (1):
      remoteproc: qcom_q6v5_pas: disable auto boot for wpss

Benjamin Gaignard (1):
      media: verisilicon: av1: Fix reference video buffer pointer assignment

Bryan O'Donoghue (1):
      media: ov08x40: Fix burst write sequence

Carlos Llamas (8):
      binder: fix node UAF in binder_add_freeze_work()
      binder: fix OOB in binder_add_freeze_work()
      binder: fix freeze UAF in binder_release_work()
      binder: fix BINDER_WORK_FROZEN_BINDER debug logs
      binder: fix BINDER_WORK_CLEAR_FREEZE_NOTIFICATION debug logs
      binder: allow freeze notification for dead nodes
      binder: fix memleak of proc->delivered_freeze
      binder: add delivered_freeze to debugfs output

Chao Yu (1):
      f2fs: fix to drop all discards after creating snapshot on lvm device

Chen-Yu Tsai (3):
      arm64: dts: mediatek: mt8186-corsola: Fix GPU supply coupling max-spread
      arm64: dts: mediatek: mt8186-corsola: Fix IT6505 reset line polarity
      drm/bridge: it6505: Fix inverted reset polarity

Choong Yong Liang (1):
      net: stmmac: set initial EEE policy configuration

Damien Le Moal (1):
      PCI: rockchip-ep: Fix address translation unit programming

Daniel Borkmann (1):
      netkit: Add option for scrubbing skb meta data

David Sterba (1):
      btrfs: drop unused parameter file_offset from btrfs_encoded_read_regular_fill_pages()

Dragan Simic (1):
      arm64: dts: allwinner: pinephone: Add mount matrix to accelerometer

Filipe Manana (2):
      btrfs: don't loop for nowait writes when checking for cross references
      btrfs: ref-verify: fix use-after-free after invalid ref action

Francesco Dolcini (6):
      arm64: dts: freescale: imx8mm-verdin: Fix SD regulator startup delay
      arm64: dts: ti: k3-am62-verdin: Fix SD regulator startup delay
      arm64: dts: freescale: imx8mp-verdin: Fix SD regulator startup delay
      dt-bindings: net: fec: add pps channel property
      net: fec: refactor PPS channel configuration
      net: fec: make PPS channel configurable

Frank Li (3):
      i3c: master: Fix miss free init_dyn_addr at i3c_master_put_i3c_addrs()
      i3c: master: svc: fix possible assignment of the same address to two devices
      i3c: master: svc: Modify enabled_events bit 7:0 to act as IBI enable counter

Frederic Weisbecker (1):
      posix-timers: Target group sigqueue to current task only if not exiting

Gabor Juhos (1):
      clk: qcom: gcc-qcs404: fix initial rate of GPLL3

Gaosheng Cui (1):
      media: platform: allegro-dvt: Fix possible memory leak in allocate_buffers_internal()

Geert Uytterhoeven (1):
      slab: Fix too strict alignment check in create_cache()

Giovanni Cabiddu (1):
      vfio/qat: fix overflow check in qat_vf_resume_write()

Greg Kroah-Hartman (1):
      Linux 6.12.4

Guoqing Jiang (1):
      media: mtk-jpeg: Fix null-ptr-deref during unload module

Heiko Carstens (1):
      s390/stacktrace: Use break instead of return statement

Hugo Villeneuve (1):
      drm: panel: jd9365da-h3: Remove unused num_init_cmds structure member

Javier Carrasco (3):
      spmi: pmic-arb: fix return path in for_each_available_child_of_node()
      leds: flash: mt6360: Fix device_for_each_child_node() refcounting in error paths
      drm/mediatek: Fix child node refcount handling in early exit

Jean-Baptiste Maneyrol (1):
      iio: invensense: fix multiple odr switch when FIFO is off

Jinjie Ruan (6):
      media: i2c: dw9768: Fix pm_runtime_set_suspended() with runtime pm enabled
      media: amphion: Fix pm_runtime_set_suspended() with runtime pm enabled
      media: venus: Fix pm_runtime_set_suspended() with runtime pm enabled
      media: gspca: ov534-ov772x: Fix off-by-one error in set_frame_rate()
      kunit: string-stream: Fix a UAF bug in kunit_init_suite()
      i3c: master: svc: Fix pm_runtime_set_suspended() with runtime pm enabled

Jiri Olsa (1):
      fs/proc/kcore.c: Clear ret value in read_kcore_iter after successful iov_iter_zero

Joe Hattori (1):
      media: platform: exynos4-is: Fix an OF node reference leak in fimc_md_is_isp_available

Johannes Thumshirn (1):
      btrfs: fix use-after-free in btrfs_encoded_read_endio()

John Keeping (1):
      media: platform: rga: fix 32-bit DMA limitation

Jonathan Cavitt (1):
      drm/xe/xe_guc_ads: save/restore OA registers and allowlist regs

Joshua Aberback (1):
      drm/amd/display: Fix handling of plane refcount

Kenneth Feng (3):
      drm/amdgpu/pm: add gen5 display to the user on smu v14.0.2/3
      drm/amd/pm: skip setting the power source on smu v14.0.2/3
      drm/amd/pm: disable pcie speed switching on Intel platform for smu v14.0.2/3

Kishon Vijay Abraham I (2):
      PCI: keystone: Set mode as Root Complex for "ti,keystone-pcie" compatible
      PCI: keystone: Add link up check to ks_pcie_other_map_bus()

Li Zetao (1):
      media: ts2020: fix null-ptr-deref in ts2020_probe()

Lijo Lazar (2):
      drm/amdkfd: Use the correct wptr size
      drm/amd/pm: Remove arcturus min power limit

Linus Walleij (3):
      ARM: 9429/1: ioremap: Sync PGDs for VMALLOC shadow
      ARM: 9430/1: entry: Do a dummy read from VMAP shadow
      ARM: 9431/1: mm: Pair atomic_set_release() with _read_acquire()

Lizhi Xu (1):
      btrfs: add a sanity check for btrfs root in btrfs_search_slot()

Long Li (1):
      xfs: remove unknown compat feature check in superblock write validation

Lucas Stach (1):
      drm/etnaviv: flush shader L1 cache after user commandstream

Lyude Paul (1):
      drm/panic: Fix uninitialized spinlock acquisition with CONFIG_DRM_PANIC=n

Ma Ke (3):
      drm/sti: avoid potential dereference of error pointers in sti_hqvdp_atomic_check
      drm/sti: avoid potential dereference of error pointers in sti_gdp_atomic_check
      drm/sti: avoid potential dereference of error pointers

Marek Vasut (1):
      nvmem: core: Check read_only flag for force_ro in bin_attr_nvmem_write()

Mario Limonciello (2):
      drm/amd: Add some missing straps from NBIO 7.11.0
      drm/amd: Fix initialization mistake for NBIO 7.11 devices

Mark Harmstone (2):
      btrfs: change btrfs_encoded_read() so that reading of extent is done by caller
      btrfs: move priv off stack in btrfs_encoded_read_regular_fill_pages()

Masami Hiramatsu (Google) (1):
      tracing: Fix function timing profiler to initialize hashtable

Matthew Auld (3):
      drm/xe/migrate: fix pat index usage
      drm/xe/migrate: use XE_BO_FLAG_PAGETABLE
      drm/xe/guc_submit: fix race around suspend_pending

Matti Vaittinen (1):
      iio: accel: kx022a: Fix raw read format

Max Kellermann (2):
      ceph: pass cred pointer to ceph_mds_auth_match()
      ceph: fix cred leak in ceph_mds_check_access()

MengEn Sun (1):
      vmstat: call fold_vm_zone_numa_events() before show per zone NUMA event

Michal Vokáč (1):
      leds: lp55xx: Remove redundant test for invalid channel number

Ming Qian (3):
      media: amphion: Set video drvdata before register video device
      media: imx-jpeg: Set video drvdata before register video device
      media: imx-jpeg: Ensure power suppliers be suspended before detach them

Miquel Raynal (2):
      mtd: spinand: winbond: Fix 512GW and 02JW OOB layout
      mtd: spinand: winbond: Fix 512GW, 01GW, 01JW and 02JW ECC information

Mostafa Saleh (1):
      iommu/io-pgtable-arm: Fix stage-2 map/unmap for concatenated tables

Nathan Chancellor (3):
      powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit files with clang
      powerpc: Fix stack protector Kconfig test for clang
      powerpc: Adjust adding stack protector flags to KBUILD_CLAGS for clang

Niklas Cassel (1):
      PCI: dwc: ep: Fix advertised resizable BAR size regression

Nuno Sa (1):
      iio: adc: ad7923: Fix buffer overflow for tx_buf and ring_xfer

Ojaswin Mujoo (1):
      quota: flush quota_release_work upon quota writeback

Oleksandr Tymoshenko (1):
      ovl: properly handle large files in ovl_security_fileattr

Ovidiu Bunea (1):
      drm/amd/display: Remove PIPE_DTO_SRC_SEL programming from set_dtbclk_dto

Patrick Donnelly (1):
      ceph: extract entity name from device id

Peter Griffin (2):
      scsi: ufs: exynos: Add check inside exynos_ufs_config_smu()
      scsi: ufs: exynos: Fix hibern8 notify callbacks

Pratyush Brahma (1):
      iommu/arm-smmu: Defer probe of clients after smmu device bound

Qiang Yu (1):
      PCI: qcom: Disable ASPM L0s for X1E80100

Ricardo Ribalda (1):
      media: uvcvideo: Stop stream during unregister

Romain Gantois (1):
      net: phy: dp83869: fix status reporting for 1000base-x autonegotiation

Saravana Kannan (1):
      driver core: fw_devlink: Stop trying to optimize cycle detection logic

Sergey Senozhatsky (1):
      zram: clear IDLE flag after recompression

Sibi Sankar (1):
      cpufreq: scmi: Fix cleanup path when boost enablement fails

Srinivas Pandruvada (1):
      thermal: int3400: Fix reading of current_uuid for active policy

Ssuhung Yeh (1):
      dm: Fix typo in error message

Stefan Eichenberger (1):
      PCI: imx6: Fix suspend/resume support on i.MX6QDL

Steffen Dirkwinkel (1):
      drm: xlnx: zynqmp_dpsub: fix hotplug detection

Thadeu Lima de Souza Cascardo (1):
      media: uvcvideo: Require entities to have a non-zero unique ID

Thomas Zimmermann (1):
      drm/fbdev-dma: Select FB_DEFERRED_IO

Umio Yasuno (1):
      drm/amd/pm: update current_socclk and current_uclk in gpu_metrics on smu v13.0.7

Vasiliy Kovalev (1):
      ovl: Filter invalid inodes with missing lookup function

Vasily Gorbik (1):
      s390/entry: Mark IRQ entries to fix stack depot warnings

Vitaly Prosyak (1):
      drm/amdgpu: fix usage slab after free

Vladimir Zapolskiy (1):
      media: qcom: camss: fix error path on configuration of power domains

Wei Yang (1):
      maple_tree: refine mas_store_root() on storing NULL

Will Deacon (1):
      iommu/tegra241-cmdqv: Fix unused variable warning

Xiao Ni (1):
      md/raid5: Wait sync io to finish before changing group cnt

Xu Yang (1):
      perf jevents: fix breakage when do perf stat on system metric

Yang Erkun (2):
      nfsd: make sure exp active before svc_export_show
      nfsd: fix nfs4_openowner leak when concurrent nfsd4_open occur

Yihan Zhu (1):
      drm/amd/display: update pipe selection policy to check head pipe

Yuan Can (2):
      md/md-bitmap: Add missing destroy_work_on_stack()
      dm thin: Add missing destroy_work_on_stack()

Zheng Yejian (1):
      mm/damon/vaddr: fix issue in damon_va_evenly_split_region()

Zichen Xie (1):
      kunit: Fix potential null dereference in kunit_device_driver_test()

Zicheng Qu (3):
      ad7780: fix division by zero in ad7780_write_raw()
      iio: Fix fwnode_handle in __fwnode_iio_channel_get_by_name()
      iio: gts: fix infinite loop for gain_to_scaletables()

Zijun Hu (2):
      PCI: endpoint: Fix PCI domain ID release in pci_epc_destroy()
      PCI: endpoint: Clear secondary (not primary) EPC in pci_epc_remove_epf()

guoweikang (1):
      ftrace: Fix regression with module command in stack_trace_filter

yuan.gao (1):
      mm/slub: Avoid list corruption when removing a slab from the full list


