Return-Path: <stable+bounces-59101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B80EE92E51E
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 12:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1C41C21BDA
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219D915920B;
	Thu, 11 Jul 2024 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eiXGB8O2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0153158DDD;
	Thu, 11 Jul 2024 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695244; cv=none; b=mb1DDh/VEK4xTNPYTaW5fwDRQQkUOPOMsQK+BzAnQv2ikRpDi00kzgWYNJ+4ebiFie8pa0ekOrIaUjsaYrICZN3eeCXHKZOroYJ1T8cHamo58yMY2Pa0sGzZ5uvr7xj08NRVsXEmC+xphTMEHMDaJogtYZj7L+KwOyQICPORxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695244; c=relaxed/simple;
	bh=tMP/C4FGYTzYv7xrxabjlLMsMku7VM42e3gtyCVjDKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OJZ9J62l5QllqtEkYrQWcVu4PpSFPiSwf6Ap4aW75iYxu4dBqldRgLizcnJiz+2zCc2uTFYStuD2G36QSztpwQ3RiEYA8r+qf9xc9TXY0HaQiyLRMMaCYmDHBsT4DQelzKlYdnFnuM2/jsJ3IdzmRyhEvzWYR6MXcJxR5humrh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eiXGB8O2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A7DC4AF07;
	Thu, 11 Jul 2024 10:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720695244;
	bh=tMP/C4FGYTzYv7xrxabjlLMsMku7VM42e3gtyCVjDKk=;
	h=From:To:Cc:Subject:Date:From;
	b=eiXGB8O27aqXq5hxCZeCOr9pvd6KuQ9MYOIoZpf67llxeiLoT2MHvOl+oLcQ0zuk8
	 lpIanD+qAv18tg/fpiayyA3s2QQacQuz9d5IQtwJui5cZEMip+LQfxahWdz690IP4d
	 Ci7aQBGmQ4/LTu7g2MExHoM3L+UJz3oONLDUEhN0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.39
Date: Thu, 11 Jul 2024 12:53:48 +0200
Message-ID: <2024071149-paddle-jaws-6ed3@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.39 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                                  |    2 
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts                        |    2 
 arch/powerpc/include/asm/interrupt.h                                      |   10 
 arch/powerpc/include/asm/io.h                                             |    2 
 arch/powerpc/include/asm/percpu.h                                         |   10 
 arch/powerpc/kernel/head_64.S                                             |    5 
 arch/powerpc/kernel/setup_64.c                                            |    2 
 arch/powerpc/kexec/core_64.c                                              |   11 
 arch/powerpc/platforms/pseries/kexec.c                                    |    8 
 arch/powerpc/platforms/pseries/pseries.h                                  |    1 
 arch/powerpc/platforms/pseries/setup.c                                    |    1 
 arch/powerpc/xmon/xmon.c                                                  |    6 
 arch/riscv/include/asm/errata_list.h                                      |   12 
 arch/riscv/include/asm/tlbflush.h                                         |   19 +
 arch/riscv/kernel/machine_kexec.c                                         |   10 
 arch/riscv/kvm/vcpu_pmu.c                                                 |    2 
 arch/riscv/mm/tlbflush.c                                                  |   23 -
 arch/s390/include/asm/kvm_host.h                                          |    1 
 arch/s390/kvm/kvm-s390.c                                                  |    1 
 arch/s390/kvm/kvm-s390.h                                                  |   15 +
 arch/s390/kvm/priv.c                                                      |   32 ++
 crypto/aead.c                                                             |    3 
 crypto/cipher.c                                                           |    3 
 drivers/base/regmap/regmap-i2c.c                                          |    3 
 drivers/block/null_blk/zoned.c                                            |   11 
 drivers/bluetooth/hci_bcm4377.c                                           |    2 
 drivers/bluetooth/hci_qca.c                                               |   18 +
 drivers/cdrom/cdrom.c                                                     |    2 
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c                                  |    1 
 drivers/clk/mediatek/clk-mtk.c                                            |   24 +
 drivers/clk/mediatek/clk-mtk.h                                            |    2 
 drivers/clk/qcom/clk-alpha-pll.c                                          |    3 
 drivers/clk/qcom/gcc-ipq9574.c                                            |   10 
 drivers/clk/qcom/gcc-sm6350.c                                             |   10 
 drivers/clk/sunxi-ng/ccu_common.c                                         |   18 -
 drivers/crypto/hisilicon/debugfs.c                                        |   21 +
 drivers/firmware/dmi_scan.c                                               |   11 
 drivers/gpio/gpio-mmio.c                                                  |    2 
 drivers/gpio/gpiolib-of.c                                                 |   22 +
 drivers/gpu/drm/amd/amdgpu/aldebaran.c                                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                               |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                                   |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c                                   |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                                   |    3 
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c                               |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                         |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c                 |    4 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                         |    3 
 drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c            |    8 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c                       |    8 
 drivers/gpu/drm/amd/include/atomfirmware.h                                |    4 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                            |    7 
 drivers/gpu/drm/lima/lima_gp.c                                            |    2 
 drivers/gpu/drm/lima/lima_mmu.c                                           |    5 
 drivers/gpu/drm/lima/lima_pp.c                                            |    4 
 drivers/gpu/drm/nouveau/nouveau_connector.c                               |    3 
 drivers/i2c/busses/i2c-i801.c                                             |    2 
 drivers/i2c/busses/i2c-pnx.c                                              |   48 ---
 drivers/infiniband/core/user_mad.c                                        |   21 +
 drivers/input/ff-core.c                                                   |    7 
 drivers/leds/leds-an30259a.c                                              |   14 -
 drivers/media/dvb-frontends/as102_fe_types.h                              |    2 
 drivers/media/dvb-frontends/tda10048.c                                    |    9 
 drivers/media/dvb-frontends/tda18271c2dd.c                                |    4 
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c |   22 +
 drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c        |    5 
 drivers/media/usb/dvb-usb/dib0700_devices.c                               |   18 +
 drivers/media/usb/dvb-usb/dw2102.c                                        |  120 +++++----
 drivers/media/usb/s2255/s2255drv.c                                        |   20 -
 drivers/mtd/nand/raw/nand_base.c                                          |   66 +++--
 drivers/mtd/nand/raw/rockchip-nand-controller.c                           |    6 
 drivers/net/bonding/bond_options.c                                        |    6 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c                          |    1 
 drivers/net/dsa/mv88e6xxx/chip.c                                          |    4 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h                               |    2 
 drivers/net/ethernet/intel/e1000e/netdev.c                                |  132 +++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                         |    5 
 drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c            |   37 ++
 drivers/net/ethernet/mellanox/mlxsw/core_linecards.c                      |    1 
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c                   |    2 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                               |    1 
 drivers/net/ntb_netdev.c                                                  |    2 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                      |   10 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                           |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c                       |    5 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                           |    5 
 drivers/net/wireless/microchip/wilc1000/hif.c                             |    3 
 drivers/nfc/virtual_ncidev.c                                              |    4 
 drivers/nvme/host/multipath.c                                             |    2 
 drivers/nvme/host/pci.c                                                   |    3 
 drivers/nvme/target/core.c                                                |    9 
 drivers/platform/x86/toshiba_acpi.c                                       |   31 +-
 drivers/platform/x86/touchscreen_dmi.c                                    |   36 ++
 drivers/s390/crypto/pkey_api.c                                            |    4 
 drivers/scsi/mpi3mr/mpi3mr_transport.c                                    |   10 
 drivers/scsi/qedf/qedf_io.c                                               |    6 
 drivers/spi/spi-cadence-xspi.c                                            |   20 +
 drivers/thermal/mediatek/lvts_thermal.c                                   |    2 
 drivers/tty/serial/imx.c                                                  |    2 
 drivers/usb/host/xhci-ring.c                                              |    5 
 drivers/vhost/scsi.c                                                      |   17 -
 drivers/vhost/vhost.c                                                     |  114 ++++++--
 drivers/vhost/vhost.h                                                     |    2 
 fs/btrfs/block-group.c                                                    |   13 
 fs/btrfs/scrub.c                                                          |    2 
 fs/f2fs/f2fs.h                                                            |   12 
 fs/f2fs/super.c                                                           |   27 +-
 fs/f2fs/sysfs.c                                                           |   14 -
 fs/jffs2/super.c                                                          |    1 
 fs/nilfs2/alloc.c                                                         |   18 +
 fs/nilfs2/alloc.h                                                         |    4 
 fs/nilfs2/dat.c                                                           |    2 
 fs/nilfs2/dir.c                                                           |    6 
 fs/nilfs2/ifile.c                                                         |    7 
 fs/nilfs2/nilfs.h                                                         |   10 
 fs/nilfs2/the_nilfs.c                                                     |    6 
 fs/nilfs2/the_nilfs.h                                                     |    2 
 fs/ntfs3/xattr.c                                                          |    5 
 fs/orangefs/super.c                                                       |    3 
 include/linux/fsnotify.h                                                  |    8 
 include/linux/lsm_hook_defs.h                                             |    2 
 include/linux/mutex.h                                                     |   27 ++
 include/linux/phy.h                                                       |    2 
 include/linux/sched/vhost_task.h                                          |    3 
 include/linux/security.h                                                  |    5 
 include/uapi/linux/cn_proc.h                                              |    3 
 kernel/auditfilter.c                                                      |    5 
 kernel/cpu.c                                                              |    3 
 kernel/dma/map_benchmark.c                                                |    3 
 kernel/exit.c                                                             |    2 
 kernel/locking/mutex-debug.c                                              |   12 
 kernel/vhost_task.c                                                       |   53 ++--
 lib/kunit/try-catch.c                                                     |    3 
 mm/page-writeback.c                                                       |   32 ++
 net/bluetooth/hci_conn.c                                                  |   15 -
 net/bluetooth/hci_event.c                                                 |   26 +
 net/bluetooth/iso.c                                                       |    3 
 net/core/datagram.c                                                       |   19 -
 net/ipv4/inet_diag.c                                                      |    2 
 net/ipv4/tcp_input.c                                                      |    2 
 net/ipv4/tcp_metrics.c                                                    |    1 
 net/mac802154/main.c                                                      |   14 -
 net/netfilter/nf_tables_api.c                                             |    3 
 net/sctp/socket.c                                                         |    7 
 scripts/link-vmlinux.sh                                                   |    2 
 security/apparmor/audit.c                                                 |    6 
 security/apparmor/include/audit.h                                         |    2 
 security/integrity/ima/ima.h                                              |    2 
 security/integrity/ima/ima_policy.c                                       |   15 -
 security/security.c                                                       |    6 
 security/selinux/include/audit.h                                          |    4 
 security/selinux/ss/services.c                                            |    5 
 security/smack/smack_lsm.c                                                |    4 
 sound/core/ump.c                                                          |    8 
 sound/pci/hda/patch_realtek.c                                             |    9 
 tools/lib/bpf/bpf_core_read.h                                             |    1 
 tools/power/x86/turbostat/turbostat.c                                     |   10 
 tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c                     |   34 ++
 tools/testing/selftests/bpf/progs/dummy_st_ops_success.c                  |   15 -
 tools/testing/selftests/net/gro.c                                         |    3 
 tools/testing/selftests/net/ip_local_port_range.c                         |    2 
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c                             |    2 
 tools/testing/selftests/net/msg_zerocopy.c                                |   14 -
 163 files changed, 1253 insertions(+), 547 deletions(-)

Aleksandr Mishin (1):
      mlxsw: core_linecards: Fix double memory deallocation in case of invalid INI file

Alex Deucher (2):
      drm/amdgpu/atomfirmware: silence UBSAN warning
      drm/amdgpu: silence UBSAN warning

Alex Hung (4):
      drm/amd/display: Check index msg_id before read or write
      drm/amd/display: Check pipe offset before setting vblank
      drm/amd/display: Skip finding free audio for unknown engine_id
      drm/amd/display: Fix uninitialized variables in DM

Armin Wolf (1):
      platform/x86: toshiba_acpi: Fix quickstart quirk handling

Atish Patra (1):
      RISC-V: KVM: Fix the initial sample period value

Chao Yu (1):
      f2fs: check validation of fault attrs in f2fs_build_fault_attr()

Chenghai Huang (1):
      crypto: hisilicon/debugfs - Fix debugfs uninit process issue

Chris Mi (1):
      net/mlx5: E-switch, Create ingress ACL when needed

Christian Borntraeger (1):
      KVM: s390: fix LPSWEY handling

Corinna Vinschen (1):
      igc: fix a log entry using uninitialized netdev

Damien Le Moal (1):
      null_blk: Do not allow runt zone with zone capacity smaller then zone size

Dave Jiang (1):
      net: ntb_netdev: Move ntb_netdev_rx_handler() to call netif_rx() from __netif_rx()

Dima Ruinskiy (1):
      e1000e: Fix S0ix residency on corporate systems

Dmitry Antipov (1):
      mac802154: fix time calculation in ieee802154_configure_durations()

Dmitry Torokhov (2):
      gpiolib: of: fix lookup quirk for MIPS Lantiq
      gpiolib: of: add polarity quirk for TSC2005

Dragan Simic (1):
      arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage on Quartz64 Model B

Eduard Zingerman (3):
      selftests/bpf: adjust dummy_st_ops_success to detect additional error
      selftests/bpf: do not pass NULL for non-nullable params in dummy_st_ops
      selftests/bpf: dummy_st_ops should reject 0 for non-nullable params

Edward Adam Davis (2):
      Bluetooth: Ignore too large handle values in BIG
      nfc/nci: Add the inconsistency check between the input data length and count

Erick Archer (2):
      sctp: prefer struct_size over open coded arithmetic
      Input: ff-core - prefer struct_size over open coded arithmetic

Erico Nunes (1):
      drm/lima: fix shared irq handling on driver remove

Fedor Pchelkin (1):
      dma-mapping: benchmark: avoid needless copy_to_user if benchmark fails

Fei Shao (1):
      media: mediatek: vcodec: Only free buffer VA that is not NULL

Felix Fietkau (1):
      wifi: mt76: replace skb_put with skb_put_zero

Florian Westphal (1):
      netfilter: nf_tables: unconditionally flush pending work before notifier

Frank Oltmanns (1):
      clk: sunxi-ng: common: Don't call hw_to_ccu_common on hw without common

GUO Zihua (1):
      ima: Avoid blocking in RCU read-side critical section

Gabor Juhos (1):
      clk: qcom: clk-alpha-pll: set ALPHA_EN bit for Stromer Plus PLLs

George Stark (2):
      locking/mutex: Introduce devm_mutex_init()
      leds: an30259a: Use devm_mutex_init() for mutex initialization

Ghadi Elie Rahme (1):
      bnx2x: Fix multiple UBSAN array-index-out-of-bounds

Greg Kroah-Hartman (1):
      Linux 6.6.39

Greg Kurz (1):
      powerpc/xmon: Check cpu id in commands "c#", "dp#" and "dx#"

Hailey Mothershead (1):
      crypto: aead,cipher - zeroize key buffer after use

Hector Martin (1):
      Bluetooth: hci_bcm4377: Fix msgid release

Heiner Kallweit (1):
      i2c: i801: Annotate apanel_addr as __ro_after_init

Holger Dengler (1):
      s390/pkey: Wipe sensitive data on failure

Huacai Chen (1):
      cpu: Fix broken cmdline "nosmp" and "maxcpus=0"

Iulia Tanasescu (1):
      Bluetooth: ISO: Check socket flag instead of hcon

Jakub Kicinski (1):
      tcp_metrics: validate source addr length

Jan Kara (3):
      mm: avoid overflows in dirty throttling logic
      fsnotify: Do not generate events for O_PATH file descriptors
      Revert "mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again"

Jean Delvare (1):
      firmware: dmi: Stop decoding on broken entry

Jesse Zhang (2):
      drm/amdgpu: Using uninitialized value *size when calling amdgpu_vce_cs_reloc
      drm/amdgpu: fix the warning about the expression (int)size - len

Jian-Hong Pan (1):
      ALSA: hda/realtek: Enable headset mic of JP-IK LEAP W502 with ALC897

Jianbo Liu (1):
      net/mlx5e: Add mqprio_rl cleanup and free in mlx5e_priv_cleanup()

Jiawen Wu (1):
      net: txgbe: initialize num_q_vectors for MSI/INTx interrupts

Jim Wylder (1):
      regmap-i2c: Subtract reg size from max_write

Jimmy Assarsson (1):
      can: kvaser_usb: Explicitly initialize family in leafimx driver_info struct

Jinglin Wen (1):
      powerpc/64s: Fix unnecessary copy to 0 when kernel is booted at address 0

Jinliang Zheng (1):
      mm: optimize the redundant loop of mm_update_owner_next()

John Hubbard (1):
      selftests/net: fix uninitialized variables

John Meneghini (1):
      scsi: qedf: Make qedf_execute_tmf() non-preemptible

John Schoenick (1):
      drm: panel-orientation-quirks: Add quirk for Valve Galileo

Jose E. Marchesi (1):
      bpf: Avoid uninitialized value in BPF_CORE_READ_BITFIELD

Jozef Hopko (1):
      wifi: wilc1000: fix ies_len type in connect path

Julien Panis (1):
      thermal/drivers/mediatek/lvts_thermal: Check NULL ptr on lvts_data

Justin Stitt (1):
      cdrom: rearrange last_media_change check to avoid unintentional overflow

Konstantin Komarov (1):
      fs/ntfs3: Mark volume as dirty if xattr is broken

Kundan Kumar (1):
      nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset

Len Brown (1):
      tools/power turbostat: Remember global max_die_id

Lu Yao (1):
      btrfs: scrub: initialize ret in scrub_simple_mirror() to fix compilation warning

Luca Weiss (1):
      clk: qcom: gcc-sm6350: Fix gpll6* & gpll7 parents

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix setting of unicast qos interval

Ma Jun (2):
      drm/amdgpu: Fix uninitialized variable warnings
      drm/amdgpu: Initialize timestamp for some legacy SOCs

Ma Ke (1):
      drm/nouveau: fix null pointer dereference in nouveau_connector_get_modes

Mahesh Salgaonkar (1):
      powerpc: Avoid nmi_enter/nmi_exit in real mode interrupt.

Marek Vasut (1):
      net: phy: phy_device: Fix PHY LED blinking code comment

Masahiro Yamada (1):
      kbuild: fix short log for AS in link-vmlinux.sh

Matt Jan (1):
      connector: Fix invalid conversion in cn_proc.h

Matthias Schiffer (1):
      serial: imx: Raise TX trigger level to 8

Mauro Carvalho Chehab (1):
      media: dw2102: fix a potential buffer overflow

Md Sadre Alam (1):
      clk: qcom: gcc-ipq9574: Add BRANCH_HALT_VOTED flag

Michael Bunk (1):
      media: dw2102: Don't translate i2c read into write

Michael Ellerman (1):
      powerpc/64: Set _IO_BASE to POISON_POINTER_DELTA not 0 for CONFIG_PCI=n

Michael Guralnik (1):
      IB/core: Implement a limit on UMAD receive List

Mickaël Salaün (1):
      kunit: Fix timeout message

Mike Christie (4):
      vhost: Use virtqueue mutex for swapping worker
      vhost: Release worker mutex during flushes
      vhost_task: Handle SIGKILL by flushing work and exiting
      vhost-scsi: Handle vhost_vq_work_queue failures for events

Mike Marshall (1):
      orangefs: fix out-of-bounds fsid access

Miquel Raynal (3):
      mtd: rawnand: Ensure ECC configuration is propagated to upper layers
      mtd: rawnand: Fix the nand_read_data_op() early check
      mtd: rawnand: Bypass a couple of sanity checks during NAND identification

Naohiro Aota (1):
      btrfs: fix adding block group to a reclaim list and the unused list during reclaim

Nathan Chancellor (2):
      f2fs: Add inline to f2fs_build_fault_attr() stub
      scsi: mpi3mr: Use proper format specifier in mpi3mr_sas_port_add()

Neal Cardwell (1):
      UPSTREAM: tcp: fix DSACK undo in fast recovery to call tcp_try_to_open()

Nicholas Piggin (1):
      powerpc/pseries: Fix scv instruction crash with kexec

Niklas Neronin (1):
      usb: xhci: prevent potential failure in handle_tx_event() for Transfer events without TRB

Nilay Shroff (1):
      nvme-multipath: find NUMA path only for online numa-node

Pavel Skripkin (1):
      bluetooth/hci: disallow setting handle bigger than HCI_CONN_HANDLE_MAX

Pin-yen Lin (1):
      clk: mediatek: mt8183: Only enable runtime PM on mt8183-mfgcfg

Piotr Wojtaszczyk (1):
      i2c: pnx: Fix potential deadlock warning from del_timer_sync() call in isr

Ricardo Ribalda (5):
      media: dvb: as102-fe: Fix as10x_register_addr packing
      media: dvb-usb: dib0700_devices: Add missing release_firmware()
      media: dvb-frontends: tda18271c2dd: Remove casting during div
      media: s2255: Use refcount_t instead of atomic_t for num_channels
      media: dvb-frontends: tda10048: Fix integer overflow

Ryusuke Konishi (3):
      nilfs2: fix inode number range checks
      nilfs2: add missing check for inode numbers on directory entries
      nilfs2: fix incorrect inode allocation from reserved inodes

Sagi Grimberg (2):
      net: allow skb_datagram_iter to be called from any context
      nvmet: fix a possible leak when destroy a ctrl during qp establishment

Sam Sun (1):
      bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()

Samuel Holland (1):
      riscv: Apply SiFive CIP-1200 workaround to single-ASID sfence.vma

Sasha Neftin (1):
      Revert "igc: fix a log entry using uninitialized netdev"

Shigeru Yoshida (1):
      inet_diag: Initialize pad field in struct inet_diag_req_v2

Shiji Yang (1):
      gpio: mmio: do not calculate bgpio_bits via "ngpios"

Simon Horman (1):
      net: dsa: mv88e6xxx: Correct check for empty list

Song Shuai (1):
      riscv: kexec: Avoid deadlock in kexec crash path

StanleyYP Wang (1):
      wifi: mt76: mt7996: add sanity checks for background radar trigger

Takashi Iwai (1):
      ALSA: ump: Set default protocol when not given explicitly

Tim Huang (1):
      drm/amdgpu: fix uninitialized scalar variable warning

Tomas Henzl (1):
      scsi: mpi3mr: Sanitise num_phys

Val Packett (1):
      mtd: rawnand: rockchip: ensure NVDDR timings are rejected

Wang Yong (1):
      jffs2: Fix potential illegal address access in jffs2_free_inode

Witold Sadowski (1):
      spi: cadence: Ensure data lines set to low during dummy-cycle period

Yijie Yang (1):
      net: stmmac: dwmac-qcom-ethqos: fix error array size

Zijian Zhang (2):
      selftests: fix OOM in msg_zerocopy selftest
      selftests: make order checking verbose in msg_zerocopy selftest

Zijun Hu (1):
      Bluetooth: qca: Fix BT enable failure again for QCA6390 after warm reboot

hmtheboy154 (2):
      platform/x86: touchscreen_dmi: Add info for GlobalSpace SolT IVW 11.6" tablet
      platform/x86: touchscreen_dmi: Add info for the EZpad 6s Pro


