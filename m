Return-Path: <stable+bounces-185771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F285BDDF5C
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 12:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E5CE4F5CCF
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C1931B836;
	Wed, 15 Oct 2025 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QBR1a8eI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100433168F9;
	Wed, 15 Oct 2025 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523935; cv=none; b=Os//b7kt+6zPEqL7txsmeBihMi0p0PczRNff/6bJOX+2IbWHV36wJ+Lj3506XXCBNCbB4g6OthQfEou5PJdc2DWZWzq/Uy9TzROhtVqXXJ1QggaWFo4z0sWI7My8Ufc/OkOFC7e2pHXrq5xBIQ2oKtCB5sm+EkWoypmj/PKKeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523935; c=relaxed/simple;
	bh=Y8eaQxPswgaOyO3XfShlYIi1DlBQPsXcw/2cELyCrEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HHN7ZkRv4+j4lzici1fI/pn+GQuQTQ4pXpbg82Mwj1nro3YvyHwJT8JCuhSBCeNQEYXPgAIdmr6KTBPGInQXfTXUh56NkldckwJnjasDCJT5VBJVWTENrL7xnISCs+2ShO6XLMFi2+rZd9WieHUr+JhfI60kiJs5/Sd6EF+EAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QBR1a8eI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7183C4CEF8;
	Wed, 15 Oct 2025 10:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760523934;
	bh=Y8eaQxPswgaOyO3XfShlYIi1DlBQPsXcw/2cELyCrEM=;
	h=From:To:Cc:Subject:Date:From;
	b=QBR1a8eI4/c9uA+T+tXT+yypDVrLl4ECjZsavyCUTT64NbfcXVrT2lb8p/uCKNEFR
	 TLIROBhJ+hE/0p/cYsoGPjEDXRtdN0ySzqZ05O+t1C8BDIFsLT8SHj4Gs2b4kvmqtL
	 YP8XigHWPjQlSa04NTPoF8yjhkp9abFGnAYFdA98=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.156
Date: Wed, 15 Oct 2025 12:25:25 +0200
Message-ID: <2025101526-bobble-debate-c15d@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.156 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/trace/histogram-design.rst                          |    4 
 Makefile                                                          |    2 
 arch/arm/mach-at91/pm_suspend.S                                   |    4 
 arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts                   |    2 
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi                     |    5 
 arch/arm64/kernel/fpsimd.c                                        |    8 
 arch/sparc/lib/M7memcpy.S                                         |   20 
 arch/sparc/lib/Memcpy_utils.S                                     |    9 
 arch/sparc/lib/NG4memcpy.S                                        |    2 
 arch/sparc/lib/NGmemcpy.S                                         |   29 -
 arch/sparc/lib/U1memcpy.S                                         |   19 
 arch/sparc/lib/U3memcpy.S                                         |    2 
 arch/x86/include/asm/segment.h                                    |    8 
 block/blk-mq-sysfs.c                                              |    6 
 block/blk-settings.c                                              |    3 
 crypto/rng.c                                                      |    8 
 drivers/acpi/nfit/core.c                                          |    2 
 drivers/acpi/processor_idle.c                                     |    3 
 drivers/base/node.c                                               |    4 
 drivers/base/power/main.c                                         |   14 
 drivers/base/regmap/regmap.c                                      |    2 
 drivers/block/nbd.c                                               |    8 
 drivers/block/null_blk/main.c                                     |    2 
 drivers/bus/fsl-mc/fsl-mc-bus.c                                   |    3 
 drivers/char/hw_random/Kconfig                                    |    1 
 drivers/char/hw_random/ks-sa-rng.c                                |    4 
 drivers/cpufreq/scmi-cpufreq.c                                    |   10 
 drivers/cpuidle/cpuidle-qcom-spm.c                                |    7 
 drivers/crypto/hisilicon/debugfs.c                                |    1 
 drivers/crypto/hisilicon/hpre/hpre_main.c                         |    3 
 drivers/crypto/hisilicon/qm.c                                     |    3 
 drivers/crypto/hisilicon/sec2/sec_main.c                          |   80 +--
 drivers/crypto/hisilicon/zip/zip_main.c                           |   17 
 drivers/devfreq/mtk-cci-devfreq.c                                 |    3 
 drivers/firmware/meson/Kconfig                                    |    2 
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                             |   29 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                              |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c |    1 
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c                      |    7 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                        |   92 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                            |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c               |    2 
 drivers/gpu/drm/panel/panel-novatek-nt35560.c                     |    2 
 drivers/gpu/drm/radeon/r600_cs.c                                  |    4 
 drivers/hid/hid-mcp2221.c                                         |    4 
 drivers/hwmon/mlxreg-fan.c                                        |   24 -
 drivers/hwtracing/coresight/coresight-etm4x-core.c                |   11 
 drivers/hwtracing/coresight/coresight-etm4x.h                     |    2 
 drivers/hwtracing/coresight/coresight-trbe.c                      |    9 
 drivers/i2c/busses/i2c-designware-platdrv.c                       |    1 
 drivers/i2c/busses/i2c-mt65xx.c                                   |   17 
 drivers/i3c/master/svc-i3c-master.c                               |   31 +
 drivers/iio/inkern.c                                              |    2 
 drivers/infiniband/core/addr.c                                    |   10 
 drivers/infiniband/core/cm.c                                      |    4 
 drivers/infiniband/core/sa_query.c                                |    6 
 drivers/infiniband/sw/siw/siw_verbs.c                             |   25 -
 drivers/input/misc/uinput.c                                       |    1 
 drivers/input/touchscreen/atmel_mxt_ts.c                          |    2 
 drivers/input/touchscreen/cyttsp4_core.c                          |    2 
 drivers/irqchip/irq-sun6i-r.c                                     |    2 
 drivers/md/dm-core.h                                              |    1 
 drivers/md/dm-integrity.c                                         |    4 
 drivers/md/dm.c                                                   |   13 
 drivers/media/i2c/rj54n1cb0c.c                                    |    9 
 drivers/media/i2c/tc358743.c                                      |    4 
 drivers/media/pci/b2c2/flexcop-pci.c                              |    2 
 drivers/media/platform/st/sti/delta/delta-mjpeg-dec.c             |   20 
 drivers/media/rc/imon.c                                           |   27 -
 drivers/media/tuners/xc5000.c                                     |   41 -
 drivers/mfd/vexpress-sysreg.c                                     |    6 
 drivers/misc/fastrpc.c                                            |   62 +-
 drivers/misc/genwqe/card_ddcb.c                                   |    2 
 drivers/mtd/nand/raw/atmel/nand-controller.c                      |    4 
 drivers/net/can/rcar/rcar_canfd.c                                 |    7 
 drivers/net/can/spi/hi311x.c                                      |   33 -
 drivers/net/ethernet/amazon/ena/ena_ethtool.c                     |    5 
 drivers/net/ethernet/dlink/dl2k.c                                 |    7 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                     |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h          |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                 |   17 
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c                |   24 +
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c               |    7 
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c              |    2 
 drivers/net/usb/asix_devices.c                                    |   29 +
 drivers/net/usb/rtl8150.c                                         |    2 
 drivers/net/wireless/ath/ath10k/wmi.c                             |   39 -
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                   |    7 
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c                   |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c               |    1 
 drivers/net/wireless/realtek/rtw89/ser.c                          |    3 
 drivers/nvme/target/fc.c                                          |   19 
 drivers/pci/controller/dwc/pcie-tegra194.c                        |    4 
 drivers/pci/controller/pci-tegra.c                                |    2 
 drivers/perf/arm_spe_pmu.c                                        |    3 
 drivers/pinctrl/meson/pinctrl-meson-gxl.c                         |   10 
 drivers/pinctrl/pinmux.c                                          |    2 
 drivers/pinctrl/renesas/pinctrl.c                                 |    3 
 drivers/power/supply/cw2015_battery.c                             |    3 
 drivers/pps/kapi.c                                                |    5 
 drivers/pps/pps.c                                                 |    5 
 drivers/pwm/pwm-tiehrpwm.c                                        |    4 
 drivers/regulator/scmi-regulator.c                                |    3 
 drivers/remoteproc/qcom_q6v5.c                                    |    3 
 drivers/scsi/mpt3sas/mpt3sas_transport.c                          |    8 
 drivers/scsi/myrs.c                                               |    8 
 drivers/scsi/pm8001/pm8001_sas.c                                  |    9 
 drivers/scsi/qla2xxx/qla_edif.c                                   |    4 
 drivers/scsi/qla2xxx/qla_init.c                                   |    4 
 drivers/soc/qcom/rpmh-rsc.c                                       |    7 
 drivers/staging/axis-fifo/axis-fifo.c                             |   68 +--
 drivers/target/target_core_configfs.c                             |    2 
 drivers/thermal/qcom/Kconfig                                      |    3 
 drivers/thermal/qcom/lmh.c                                        |    2 
 drivers/tty/serial/Kconfig                                        |    2 
 drivers/tty/serial/max310x.c                                      |    2 
 drivers/uio/uio_hv_generic.c                                      |    7 
 drivers/usb/cdns3/cdnsp-pci.c                                     |    5 
 drivers/usb/gadget/configfs.c                                     |    2 
 drivers/usb/host/max3421-hcd.c                                    |    2 
 drivers/usb/host/xhci-ring.c                                      |   11 
 drivers/usb/phy/phy-twl6030-usb.c                                 |    3 
 drivers/usb/serial/option.c                                       |    6 
 drivers/usb/typec/tipd/core.c                                     |   24 -
 drivers/usb/usbip/vhci_hcd.c                                      |   22 
 drivers/vhost/vringh.c                                            |   14 
 drivers/watchdog/mpc8xxx_wdt.c                                    |    2 
 fs/btrfs/ref-verify.c                                             |    9 
 fs/btrfs/tree-checker.c                                           |    2 
 fs/ext4/ext4.h                                                    |   10 
 fs/ext4/file.c                                                    |    2 
 fs/ext4/inode.c                                                   |    2 
 fs/ext4/orphan.c                                                  |    6 
 fs/ext4/super.c                                                   |    4 
 fs/f2fs/data.c                                                    |    7 
 fs/nfs/nfs4proc.c                                                 |    2 
 fs/ntfs3/run.c                                                    |   12 
 fs/ocfs2/stack_user.c                                             |    1 
 fs/smb/server/smb2pdu.c                                           |    3 
 fs/smb/server/transport_rdma.c                                    |   99 +++-
 fs/squashfs/inode.c                                               |    7 
 fs/squashfs/squashfs_fs_i.h                                       |    2 
 fs/udf/inode.c                                                    |    3 
 include/crypto/sha256_base.h                                      |    2 
 include/linux/bpf.h                                               |    1 
 include/linux/compiler.h                                          |    9 
 include/linux/device.h                                            |    3 
 include/linux/minmax.h                                            |  222 +++++-----
 include/trace/events/filelock.h                                   |    3 
 init/Kconfig                                                      |    1 
 kernel/bpf/core.c                                                 |    5 
 kernel/seccomp.c                                                  |   12 
 kernel/smp.c                                                      |   11 
 kernel/trace/bpf_trace.c                                          |    9 
 lib/vsprintf.c                                                    |    2 
 mm/hugetlb.c                                                      |    2 
 net/9p/trans_fd.c                                                 |    8 
 net/bluetooth/hci_sync.c                                          |   10 
 net/bluetooth/iso.c                                               |    9 
 net/bluetooth/mgmt.c                                              |   10 
 net/core/filter.c                                                 |   16 
 net/ipv4/tcp.c                                                    |    9 
 net/mac80211/rx.c                                                 |   28 -
 net/netfilter/ipset/ip_set_hash_gen.h                             |    8 
 net/netfilter/ipvs/ip_vs_ftp.c                                    |    4 
 net/nfc/nci/ntf.c                                                 |  135 ++++--
 scripts/gcc-plugins/gcc-common.h                                  |    7 
 sound/pci/lx6464es/lx_core.c                                      |    4 
 sound/soc/codecs/rt5682s.c                                        |   17 
 sound/soc/intel/boards/bytcht_es8316.c                            |   20 
 sound/soc/intel/boards/bytcr_rt5640.c                             |    7 
 sound/soc/intel/boards/bytcr_rt5651.c                             |   26 -
 sound/soc/qcom/qdsp6/topology.c                                   |    4 
 tools/include/nolibc/std.h                                        |    2 
 tools/lib/bpf/libbpf.c                                            |   10 
 tools/lib/subcmd/help.c                                           |    3 
 tools/testing/nvdimm/test/ndtest.c                                |   13 
 tools/testing/selftests/arm64/pauth/exec_target.c                 |    7 
 tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c           |    1 
 tools/testing/selftests/bpf/test_tcpnotify_user.c                 |   20 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                 |    2 
 tools/testing/selftests/watchdog/watchdog-test.c                  |    6 
 182 files changed, 1363 insertions(+), 751 deletions(-)

Abdun Nihaal (1):
      wifi: mt76: fix potential memory leak in mt76_wmac_probe()

Aditya Kumar Singh (1):
      wifi: mac80211: fix Rx packet handling when pubsta information is not available

Akhilesh Patil (1):
      selftests: watchdog: skip ping loop if WDIOF_KEEPALIVEPING not supported

Alok Tiwari (1):
      PCI: tegra: Fix devm_kcalloc() argument order for port->phys allocation

Andy Yan (1):
      power: supply: cw2015: Fix a alignment coding style issue

AngeloGioacchino Del Regno (1):
      arm64: dts: mediatek: mt8516-pumpkin: Fix machine compatible

Anthony Iliopoulos (1):
      NFSv4.1: fix backchannel max_resp_sz verification check

Arnaud Lecomte (1):
      hid: fix I2C read buffer overflow in raw_event() for mcp2221

Arnd Bergmann (2):
      hwrng: nomadik - add ARM_AMBA dependency
      media: st-delta: avoid excessive stack usage

Bagas Sanjaya (1):
      Documentation: trace: historgram-design: Separate sched_waking histogram section heading and the following diagram

Bala-Vignesh-Reddy (1):
      selftests: arm64: Check fread return value in exec_target

Baochen Qiang (1):
      wifi: ath10k: avoid unnecessary wait for service ready message

Bartosz Golaszewski (2):
      mfd: vexpress-sysreg: Check the return value of devm_gpiochip_add_data()
      pinctrl: check the return value of pinmux_ops::get_function_name()

Bernard Metzler (1):
      RDMA/siw: Always report immediate post SQ errors

Biju Das (1):
      arm64: dts: renesas: rzg2lc-smarc: Disable CAN-FD channel0

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8192cu: Don't claim USB ID 07b8:8188

Brahmajit Das (1):
      drm/radeon/r600_cs: clean up of dead code in r600_cs

Breno Leitao (1):
      crypto: sha256 - fix crash at kexec

Brigham Campbell (1):
      drm/panel: novatek-nt35560: Fix invalid return value

Chen Yufeng (1):
      can: hi311x: fix null pointer dereference when resuming from sleep before interface was enabled

Chenghai Huang (3):
      crypto: hisilicon/zip - remove unnecessary validation for high-performance mode configurations
      crypto: hisilicon - re-enable address prefetch after device resuming
      crypto: hisilicon/qm - set NULL to qm->debug.qm_diff_regs

Christophe Leroy (1):
      watchdog: mpc8xxx_wdt: Reload the watchdog timer when enabling the watchdog

Colin Ian King (2):
      misc: genwqe: Fix incorrect cmd field being reported in error
      ACPI: NFIT: Fix incorrect ndr_desc being reportedin dev_err message

Cristian Ciocaltea (1):
      usb: vhci-hcd: Prevent suspending virtually attached devices

Da Xue (1):
      pinctrl: meson-gxl: add missing i2c_d pinmux

Dan Carpenter (4):
      PM / devfreq: mtk-cci: Fix potential error pointer dereference in probe()
      usb: host: max3421-hcd: Fix error pointer dereference in probe cleanup
      serial: max310x: Add error checking in probe()
      ocfs2: fix double free in user_cluster_connect()

Daniel Borkmann (1):
      bpf: Enforce expected_attach_type for tailcall compatibility

Daniel Wagner (1):
      nvmet-fc: move lsop put work to nvmet_fc_ls_req_op

David Laight (7):
      minmax.h: add whitespace around operators and after commas
      minmax.h: update some comments
      minmax.h: reduce the #define expansion of min(), max() and clamp()
      minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
      minmax.h: move all the clamp() definitions after the min/max() ones
      minmax.h: simplify the variants of clamp()
      minmax.h: remove some #defines that are only expanded once

David Sterba (1):
      btrfs: ref-verify: handle damaged extent root tree

Deepak Sharma (1):
      net: nfc: nci: Add parameter validation for packet data

Dmitry Baryshkov (2):
      thermal/drivers/qcom: Make LMH select QCOM_SCM
      thermal/drivers/qcom/lmh: Add missing IRQ includes

Donet Tom (2):
      drivers/base/node: handle error properly in register_one_node()
      drivers/base/node: fix double free in register_one_node()

Duoming Zhou (3):
      media: b2c2: Fix use-after-free causing by irq_check_work in flexcop_pci_remove
      media: tuner: xc5000: Fix use-after-free in xc5000_release
      media: i2c: tc358743: Fix use-after-free bugs caused by orphan timer in probe

Duy Nguyen (1):
      can: rcar_canfd: Fix controller mode setting

Eric Dumazet (2):
      nbd: restrict sockets to TCP and UDP
      tcp: fix __tcp_close() to only send RST when required

Erick Karanja (1):
      mtd: rawnand: atmel: Fix error handling path in atmel_nand_controller_add_nands

Fedor Pchelkin (1):
      wifi: rtw89: avoid circular locking dependency in ser_state_run()

Florian Fainelli (1):
      cpufreq: scmi: Account for malformed DT in scmi_dev_used_by_cpus()

Geert Uytterhoeven (2):
      init: INITRAMFS_PRESERVE_MTIME should depend on BLK_DEV_INITRD
      regmap: Remove superfluous check for !config in __regmap_init()

Genjian Zhang (1):
      null_blk: Fix the description of the cache_size module argument

Greg Kroah-Hartman (1):
      Linux 6.1.156

Guangshuo Li (1):
      nvdimm: ndtest: Return -ENOMEM if devm_kcalloc() fails in ndtest_probe()

Hans de Goede (1):
      iio: consumers: Fix offset handling in iio_convert_raw_to_processed()

Herbert Xu (1):
      crypto: rng - Ensure set_ent is always present

Huisong Li (1):
      ACPI: processor: idle: Fix memory leak when register cpuidle device failed

Håkon Bugge (1):
      RDMA/cm: Rate limit destroy CM ID timeout error message

I Viswanath (1):
      net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast

Jack Yu (1):
      ASoC: rt5682s: Adjust SAR ADC button mode to fix noise issue

Jakub Kicinski (1):
      Revert "net/mlx5e: Update and set Xon/Xoff upon MTU set"

Jan Kara (1):
      ext4: fix checks for orphan inodes

Jeff Layton (1):
      filelock: add FL_RECLAIM to show_fl_flags() macro

Johan Hovold (2):
      firmware: firmware: meson-sm: fix compile-test default
      cpuidle: qcom-spm: fix device and OF node leaks at probe

Johannes Nixdorf (1):
      seccomp: Fix a race with WAIT_KILLABLE_RECV if the tracer replies too fast

Kees Cook (1):
      gcc-plugins: Remove TODO_verify_il for GCC >= 16

Kenta Akagi (1):
      selftests: mptcp: connect: fix build regression caused by backport

Kohei Enju (2):
      nfp: fix RSS hash key size when RSS is not supported
      net: ena: return 0 in ena_get_rxfh_key_size() when RSS hash key is not configurable

Kunihiko Hayashi (1):
      i2c: designware: Add disabling clocks when probe fails

Larshin Sergey (2):
      media: rc: fix races with imon_disconnect()
      fs: udf: fix OOB read in lengthAllocDescs handling

Leilk.Liu (1):
      i2c: mediatek: fix potential incorrect use of I2C_MASTER_WRRD

Leo Yan (3):
      coresight: trbe: Prevent overflow in PERF_IDX2OFF()
      perf: arm_spe: Prevent overflow in PERF_IDX2OFF()
      coresight: trbe: Return NULL pointer for allocation failures

Li Nan (1):
      blk-mq: check kobject state_in_sysfs before deleting in blk_mq_unregister_hctx

Liao Yuanhong (1):
      drm/amd/display: Remove redundant semicolons

Ling Xu (3):
      misc: fastrpc: Fix fastrpc_map_lookup operation
      misc: fastrpc: fix possible map leak in fastrpc_put_args
      misc: fastrpc: Skip reference for DMA handles

Linus Torvalds (4):
      minmax: don't use max() in situations that want a C constant expression
      minmax: simplify min()/max()/clamp() implementation
      minmax: improve macro expansion and type checking
      minmax: fix up min3() and max3() too

Luiz Augusto von Dentz (3):
      Bluetooth: MGMT: Fix not exposing debug UUID on MGMT_OP_READ_EXP_FEATURES_INFO
      Bluetooth: ISO: Fix possible UAF on iso_conn_free
      Bluetooth: hci_sync: Fix using random address for BIG/PA advertisements

Marek Vasut (1):
      Input: atmel_mxt_ts - allow reset GPIO to sleep

Matt Bobrowski (1):
      bpf/selftests: Fix test_tcpnotify_user

Matvey Kovalev (1):
      ksmbd: fix error code overwriting in smb2_get_info_filesystem()

Miaoqian Lin (1):
      usb: cdns3: cdnsp-pci: remove redundant pci_disable_device() call

Michael Karcher (5):
      sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC
      sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC III
      sparc: fix accurate exception reporting in copy_{from_to}_user for Niagara
      sparc: fix accurate exception reporting in copy_to_user for Niagara 4
      sparc: fix accurate exception reporting in copy_{from,to}_user for M7

Michael S. Tsirkin (1):
      vhost: vringh: Fix copy_to_iter return value check

Michal Pecio (1):
      Revert "usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems Running"

Mikulas Patocka (1):
      dm-integrity: limit MAX_TAG_SIZE to 255

Moshe Shemesh (2):
      net/mlx5: Stop polling for command response if interface goes down
      net/mlx5: fw reset, add reset timeout work

Nagarjuna Kristam (1):
      PCI: tegra194: Fix duplicate PLL disable in pex_ep_event_pex_rst_assert()

Nalivayko Sergey (1):
      net/9p: fix double req put in p9_fd_cancelled

Naman Jain (1):
      uio_hv_generic: Let userspace take care of interrupt mask

Nicolas Ferre (1):
      ARM: at91: pm: fix MCKx restore routine

Niklas Cassel (1):
      scsi: pm80xx: Fix array-index-out-of-of-bounds on rmmod

Nishanth Menon (1):
      hwrng: ks-sa - fix division by zero in ks_sa_rng_init

Oleksij Rempel (1):
      net: usb: asix: hold PM usage ref to avoid PM/MDIO + RTNL deadlock

Ovidiu Panait (3):
      staging: axis-fifo: fix maximum TX packet length check
      staging: axis-fifo: fix TX handling on copy_from_user() failure
      staging: axis-fifo: flush RX FIFO on read errors

Parav Pandit (1):
      RDMA/core: Resolve MAC of next-hop device without ARP support

Paul Chaignon (1):
      bpf: Explicitly check accesses to bpf_sock_addr

Pauli Virtanen (1):
      Bluetooth: ISO: don't leak skb in ISO_CONT RX

Phillip Lougher (1):
      Squashfs: fix uninit-value in squashfs_get_parent

Qianfeng Rong (8):
      regulator: scmi: Use int type to store negative error codes
      block: use int to store blk_stack_limits() return value
      pinctrl: renesas: Use int type to store negative error codes
      ALSA: lx_core: use int type to store negative error codes
      drm/amdkfd: Fix error code sign for EINVAL in svm_ioctl()
      drm/msm/dpu: fix incorrect type for ret
      scsi: qla2xxx: edif: Fix incorrect sign of error code
      scsi: qla2xxx: Fix incorrect sign of error code in START_SP_W_RETRIES()

Rafael J. Wysocki (3):
      driver core/PM: Set power.no_callbacks along with power.no_pm
      PM: sleep: core: Clear power.must_resume in noirq suspend error path
      smp: Fix up and expand the smp_call_function_many() kerneldoc

Ranjan Kumar (1):
      scsi: mpt3sas: Fix crash in transport port remove by using ioc_info()

Raphael Gallais-Pou (1):
      serial: stm32: allow selecting console when the driver is module

Ricardo Ribalda (1):
      media: tunner: xc5000: Refactor firmware load

Salah Triki (1):
      bus: fsl-mc: Check return value of platform_get_resource()

Shay Drory (1):
      net/mlx5: pagealloc: Fix reclaim race during command interface teardown

Slavin Liu (1):
      ipvs: Defer ip_vs_ftp unregister during netns cleanup

Sneh Mankad (1):
      soc: qcom: rpmh-rsc: Unconditionally clear _TRIGGER bit for TCS

Srinivas Kandagatla (1):
      ASoC: qcom: audioreach: fix potential null pointer dereference

Stanley Chu (2):
      i3c: master: svc: Use manual response for IBI events
      i3c: master: svc: Recycle unused IBI slot

Stefan Kerkmann (1):
      wifi: mwifiex: send world regulatory domain to driver

Stefan Metzmacher (1):
      smb: server: fix IRD/ORD negotiation with the client

Stephan Gerhold (1):
      remoteproc: qcom: q6v5: Avoid disabling handover IRQ twice

Sven Peter (1):
      usb: typec: tipd: Clear interrupts first

Takashi Iwai (3):
      ASoC: Intel: bytcht_es8316: Fix invalid quirk input mapping
      ASoC: Intel: bytcr_rt5640: Fix invalid quirk input mapping
      ASoC: Intel: bytcr_rt5651: Fix invalid quirk input mapping

Tao Chen (1):
      bpf: Remove migrate_disable in kprobe_multi_link_prog_run

Thomas Fourier (1):
      scsi: myrs: Fix dma_alloc_coherent() error check

Timur Kristóf (7):
      drm/amdgpu: Power up UVD 3 for FW validation (v2)
      drm/amd/pm: Disable ULV even if unsupported (v3)
      drm/amd/pm: Fix si_upload_smc_data (v3)
      drm/amd/pm: Adjust si_upload_smc_data register programming (v3)
      drm/amd/pm: Treat zero vblank time as too short in si_dpm (v3)
      drm/amd/pm: Disable MCLK switching with non-DC at 120 Hz+ (v2)
      drm/amd/pm: Disable SCLK switching on Oland with high pixel clocks (v3)

Uros Bizjak (1):
      x86/vdso: Fix output operand size of RDPID

Uwe Kleine-König (1):
      pwm: tiehrpwm: Fix corner case in clock divisor calculation

Vadim Pasternak (1):
      hwmon: (mlxreg-fan) Separate methods of fan setting coming from different subsystems

Vitaly Grigoryev (1):
      fs: ntfs3: Fix integer overflow in run_unpack()

Vlad Dumitrescu (1):
      IB/sa: Fix sa_local_svc_timeout_ms read race

Wang Haoran (1):
      scsi: target: target_core_configfs: Add length check to avoid buffer overflow

Wang Liang (1):
      pps: fix warning in pps_register_cdev when register device fail

Will Deacon (1):
      KVM: arm64: Fix softirq masking in FPSIMD register saving sequence

William Wu (1):
      usb: gadget: configfs: Correctly set use_os_string at bind

Xiaowei Li (1):
      USB: serial: option: add SIMCom 8230C compositions

Xichao Zhao (1):
      usb: phy: twl6030: Fix incorrect type for ret

Yang Shi (1):
      mm: hugetlb: avoid soft lockup when mprotect to large memory area

Yeounsu Moon (1):
      net: dlink: handle copy_thresh allocation failure

Yuanfang Zhang (1):
      coresight-etm4x: Conditionally access register TRCEXTINSELR

Yureka Lilian (1):
      libbpf: Fix reuse of DEVMAP

Zhang Shurong (1):
      media: rj54n1cb0c: Fix memleak in rj54n1_probe()

Zhen Ni (2):
      netfilter: ipset: Remove unused htable_bits in macro ahash_region
      Input: uinput - zero-initialize uinput_ff_upload_compat to avoid info leak

Zheng Qixing (2):
      dm: fix queue start/stop imbalance under suspend/load/resume races
      dm: fix NULL pointer dereference in __dm_suspend()

Zhouyi Zhou (1):
      tools/nolibc: make time_t robust if __kernel_old_time_t is missing in host headers

hupu (1):
      perf subcmd: avoid crash in exclude_cmds when excludes is empty

wangzijie (1):
      f2fs: fix zero-sized extent for precache extents

zhang jiao (1):
      vhost: vringh: Modify the return value check


