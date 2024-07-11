Return-Path: <stable+bounces-59098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E6292E519
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 12:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E41B2099E
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 10:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C7D158206;
	Thu, 11 Jul 2024 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qkCxtGd0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E429CF0;
	Thu, 11 Jul 2024 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695225; cv=none; b=myNgdRggz4vbjy1JU8OWNrGKprOa8jzAqSy8kl5tp7rEIjRo4NjadIR8VLdda3LQhe8gTTGSiPCI/5A4rD4TYutuHMrA9f1zUbXK7W0Otw6HPGnEjFnYLhSdULzGOzbAVG06Z5hQ59uofeggrAsgyqYuSgvE4PpxDJUl8qOTJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695225; c=relaxed/simple;
	bh=MwNRzgSeC+O4fQ/IasayBvNxddoVJHOf+oAWl/g/vuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m7oWElvzOmgWjUigW6b4hyiytmF7s80KX1OhVwGwiB/KggbMro8/6kwfhuiEgQpaCO/RWz2zVsSquz1ykoFubqQs3Si0VKa6/COjyQ12kAzL1H8IMfAPXgkoN5/+AhTPG0PkBJ6AV/vlSZxNyQBaImEqHo11kTWnbRg3/LMStsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qkCxtGd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1793C116B1;
	Thu, 11 Jul 2024 10:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720695225;
	bh=MwNRzgSeC+O4fQ/IasayBvNxddoVJHOf+oAWl/g/vuk=;
	h=From:To:Cc:Subject:Date:From;
	b=qkCxtGd0b7sjIbT0FHyvy2dwdQnIqKdMri8USF1dnNiJdc75ptHuOuDyIYl0KVZID
	 iIwe3R4dIdKYcUvT35l2q3t041Brx/LVbDbPfnczZ82AO9UXO/VffNG50M8X/1Ed5w
	 taSZbdViomIkW8IeQ4lBwqWu6sEleCQjkoiL8bz4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.98
Date: Thu, 11 Jul 2024 12:53:40 +0200
Message-ID: <2024071140-lushness-gone-f09b@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.98 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts             |    2 
 arch/powerpc/include/asm/interrupt.h                           |   10 
 arch/powerpc/include/asm/io.h                                  |    2 
 arch/powerpc/include/asm/percpu.h                              |   10 
 arch/powerpc/kernel/setup_64.c                                 |    2 
 arch/powerpc/kexec/core_64.c                                   |   11 
 arch/powerpc/platforms/pseries/kexec.c                         |    8 
 arch/powerpc/platforms/pseries/pseries.h                       |    1 
 arch/powerpc/platforms/pseries/setup.c                         |    1 
 arch/powerpc/xmon/xmon.c                                       |    6 
 arch/riscv/kernel/machine_kexec.c                              |   10 
 arch/s390/include/asm/kvm_host.h                               |    1 
 arch/s390/kvm/kvm-s390.c                                       |    1 
 arch/s390/kvm/kvm-s390.h                                       |   15 +
 arch/s390/kvm/priv.c                                           |   32 ++
 crypto/aead.c                                                  |    3 
 crypto/cipher.c                                                |    3 
 drivers/base/regmap/regmap-i2c.c                               |    3 
 drivers/block/null_blk/zoned.c                                 |   11 
 drivers/bluetooth/hci_qca.c                                    |   18 +
 drivers/cdrom/cdrom.c                                          |    2 
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c                       |    1 
 drivers/clk/mediatek/clk-mtk.c                                 |   32 +-
 drivers/clk/mediatek/clk-mtk.h                                 |    5 
 drivers/clk/qcom/gcc-sm6350.c                                  |   10 
 drivers/crypto/hisilicon/debugfs.c                             |   21 +
 drivers/firmware/dmi_scan.c                                    |   11 
 drivers/gpu/drm/amd/amdgpu/aldebaran.c                         |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c                        |    8 
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c                    |    2 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c              |    3 
 drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c |    8 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c            |    8 
 drivers/gpu/drm/amd/include/atomfirmware.h                     |    2 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                 |    7 
 drivers/gpu/drm/lima/lima_gp.c                                 |    2 
 drivers/gpu/drm/lima/lima_mmu.c                                |    5 
 drivers/gpu/drm/lima/lima_pp.c                                 |    4 
 drivers/gpu/drm/nouveau/nouveau_connector.c                    |    3 
 drivers/i2c/busses/i2c-i801.c                                  |    2 
 drivers/i2c/busses/i2c-pnx.c                                   |   48 ---
 drivers/infiniband/core/user_mad.c                             |   21 +
 drivers/input/ff-core.c                                        |    7 
 drivers/media/dvb-frontends/as102_fe_types.h                   |    2 
 drivers/media/dvb-frontends/tda10048.c                         |    9 
 drivers/media/dvb-frontends/tda18271c2dd.c                     |    4 
 drivers/media/usb/dvb-usb/dib0700_devices.c                    |   18 +
 drivers/media/usb/dvb-usb/dw2102.c                             |  120 +++++----
 drivers/media/usb/s2255/s2255drv.c                             |   20 -
 drivers/mtd/nand/raw/nand_base.c                               |   64 ++--
 drivers/mtd/nand/raw/rockchip-nand-controller.c                |    6 
 drivers/net/bonding/bond_options.c                             |    6 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c               |    1 
 drivers/net/dsa/mv88e6xxx/chip.c                               |    4 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h                    |    2 
 drivers/net/ethernet/intel/e1000e/netdev.c                     |  132 +++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c              |    5 
 drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c |   37 ++
 drivers/net/ethernet/mellanox/mlxsw/core_linecards.c           |    1 
 drivers/net/ntb_netdev.c                                       |    2 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c           |   10 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                |    2 
 drivers/net/wireless/microchip/wilc1000/hif.c                  |    3 
 drivers/nfc/virtual_ncidev.c                                   |    4 
 drivers/nvme/host/multipath.c                                  |    2 
 drivers/nvme/host/pci.c                                        |    3 
 drivers/nvme/target/core.c                                     |    9 
 drivers/platform/x86/toshiba_acpi.c                            |   31 +-
 drivers/platform/x86/touchscreen_dmi.c                         |   36 ++
 drivers/s390/crypto/pkey_api.c                                 |    4 
 drivers/scsi/mpi3mr/mpi3mr_transport.c                         |   10 
 drivers/scsi/qedf/qedf_io.c                                    |    6 
 drivers/spi/spi-cadence-xspi.c                                 |   20 +
 drivers/tty/serial/imx.c                                       |    2 
 drivers/usb/host/xhci-ring.c                                   |    5 
 fs/btrfs/block-group.c                                         |   13 
 fs/btrfs/scrub.c                                               |    2 
 fs/f2fs/f2fs.h                                                 |   12 
 fs/f2fs/super.c                                                |   27 +-
 fs/f2fs/sysfs.c                                                |   14 -
 fs/jffs2/super.c                                               |    1 
 fs/nilfs2/alloc.c                                              |   18 +
 fs/nilfs2/alloc.h                                              |    4 
 fs/nilfs2/dat.c                                                |    2 
 fs/nilfs2/dir.c                                                |    6 
 fs/nilfs2/ifile.c                                              |    7 
 fs/nilfs2/nilfs.h                                              |   10 
 fs/nilfs2/the_nilfs.c                                          |    6 
 fs/nilfs2/the_nilfs.h                                          |    2 
 fs/ntfs3/xattr.c                                               |    5 
 fs/orangefs/super.c                                            |    3 
 include/linux/fsnotify.h                                       |    8 
 include/linux/lsm_hook_defs.h                                  |    2 
 include/linux/mutex.h                                          |   27 ++
 include/linux/security.h                                       |    5 
 kernel/auditfilter.c                                           |    5 
 kernel/dma/map_benchmark.c                                     |    3 
 kernel/exit.c                                                  |    2 
 kernel/locking/mutex-debug.c                                   |   12 
 lib/kunit/try-catch.c                                          |    3 
 mm/page-writeback.c                                            |   32 ++
 net/core/datagram.c                                            |   19 -
 net/ipv4/inet_diag.c                                           |    2 
 net/ipv4/tcp_input.c                                           |    2 
 net/ipv4/tcp_metrics.c                                         |    1 
 net/mac802154/main.c                                           |   14 -
 net/netfilter/nf_tables_api.c                                  |    3 
 net/sctp/socket.c                                              |    7 
 scripts/link-vmlinux.sh                                        |    2 
 security/apparmor/audit.c                                      |    6 
 security/apparmor/include/audit.h                              |    2 
 security/integrity/ima/ima.h                                   |    2 
 security/integrity/ima/ima_policy.c                            |   15 -
 security/security.c                                            |    6 
 security/selinux/include/audit.h                               |    4 
 security/selinux/ss/services.c                                 |    5 
 security/smack/smack_lsm.c                                     |    4 
 sound/pci/hda/patch_realtek.c                                  |    9 
 tools/lib/bpf/bpf_core_read.h                                  |    1 
 tools/power/x86/turbostat/turbostat.c                          |   10 
 tools/testing/selftests/net/msg_zerocopy.c                     |   14 -
 123 files changed, 902 insertions(+), 406 deletions(-)

Aleksandr Mishin (1):
      mlxsw: core_linecards: Fix double memory deallocation in case of invalid INI file

Alex Deucher (1):
      drm/amdgpu/atomfirmware: silence UBSAN warning

Alex Hung (3):
      drm/amd/display: Check index msg_id before read or write
      drm/amd/display: Check pipe offset before setting vblank
      drm/amd/display: Skip finding free audio for unknown engine_id

AngeloGioacchino Del Regno (1):
      clk: mediatek: clk-mtk: Register MFG notifier in mtk_clk_simple_probe()

Armin Wolf (1):
      platform/x86: toshiba_acpi: Fix quickstart quirk handling

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

Dragan Simic (1):
      arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage on Quartz64 Model B

Edward Adam Davis (1):
      nfc/nci: Add the inconsistency check between the input data length and count

Erick Archer (2):
      sctp: prefer struct_size over open coded arithmetic
      Input: ff-core - prefer struct_size over open coded arithmetic

Erico Nunes (1):
      drm/lima: fix shared irq handling on driver remove

Fedor Pchelkin (1):
      dma-mapping: benchmark: avoid needless copy_to_user if benchmark fails

Felix Fietkau (1):
      wifi: mt76: replace skb_put with skb_put_zero

Florian Westphal (1):
      netfilter: nf_tables: unconditionally flush pending work before notifier

GUO Zihua (1):
      ima: Avoid blocking in RCU read-side critical section

George Stark (1):
      locking/mutex: Introduce devm_mutex_init()

Ghadi Elie Rahme (1):
      bnx2x: Fix multiple UBSAN array-index-out-of-bounds

Greg Kroah-Hartman (1):
      Linux 6.1.98

Greg Kurz (1):
      powerpc/xmon: Check cpu id in commands "c#", "dp#" and "dx#"

Hailey Mothershead (1):
      crypto: aead,cipher - zeroize key buffer after use

Heiner Kallweit (1):
      i2c: i801: Annotate apanel_addr as __ro_after_init

Holger Dengler (1):
      s390/pkey: Wipe sensitive data on failure

Jakub Kicinski (1):
      tcp_metrics: validate source addr length

Jan Kara (3):
      mm: avoid overflows in dirty throttling logic
      fsnotify: Do not generate events for O_PATH file descriptors
      Revert "mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again"

Jean Delvare (1):
      firmware: dmi: Stop decoding on broken entry

Jian-Hong Pan (1):
      ALSA: hda/realtek: Enable headset mic of JP-IK LEAP W502 with ALC897

Jianbo Liu (1):
      net/mlx5e: Add mqprio_rl cleanup and free in mlx5e_priv_cleanup()

Jim Wylder (1):
      regmap-i2c: Subtract reg size from max_write

Jimmy Assarsson (1):
      can: kvaser_usb: Explicitly initialize family in leafimx driver_info struct

Jinliang Zheng (1):
      mm: optimize the redundant loop of mm_update_owner_next()

John Meneghini (1):
      scsi: qedf: Make qedf_execute_tmf() non-preemptible

John Schoenick (1):
      drm: panel-orientation-quirks: Add quirk for Valve Galileo

Jose E. Marchesi (1):
      bpf: Avoid uninitialized value in BPF_CORE_READ_BITFIELD

Jozef Hopko (1):
      wifi: wilc1000: fix ies_len type in connect path

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

Ma Jun (2):
      drm/amdgpu: Fix uninitialized variable warnings
      drm/amdgpu: Initialize timestamp for some legacy SOCs

Ma Ke (1):
      drm/nouveau: fix null pointer dereference in nouveau_connector_get_modes

Mahesh Salgaonkar (1):
      powerpc: Avoid nmi_enter/nmi_exit in real mode interrupt.

Masahiro Yamada (1):
      kbuild: fix short log for AS in link-vmlinux.sh

Matthias Schiffer (1):
      serial: imx: Raise TX trigger level to 8

Mauro Carvalho Chehab (1):
      media: dw2102: fix a potential buffer overflow

Michael Bunk (1):
      media: dw2102: Don't translate i2c read into write

Michael Ellerman (1):
      powerpc/64: Set _IO_BASE to POISON_POINTER_DELTA not 0 for CONFIG_PCI=n

Michael Guralnik (1):
      IB/core: Implement a limit on UMAD receive List

Mickaël Salaün (1):
      kunit: Fix timeout message

Mike Marshall (1):
      orangefs: fix out-of-bounds fsid access

Miquel Raynal (2):
      mtd: rawnand: Ensure ECC configuration is propagated to upper layers
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

Sasha Neftin (1):
      Revert "igc: fix a log entry using uninitialized netdev"

Shigeru Yoshida (1):
      inet_diag: Initialize pad field in struct inet_diag_req_v2

Simon Horman (1):
      net: dsa: mv88e6xxx: Correct check for empty list

Song Shuai (1):
      riscv: kexec: Avoid deadlock in kexec crash path

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

Zijian Zhang (2):
      selftests: fix OOM in msg_zerocopy selftest
      selftests: make order checking verbose in msg_zerocopy selftest

Zijun Hu (1):
      Bluetooth: qca: Fix BT enable failure again for QCA6390 after warm reboot

hmtheboy154 (2):
      platform/x86: touchscreen_dmi: Add info for GlobalSpace SolT IVW 11.6" tablet
      platform/x86: touchscreen_dmi: Add info for the EZpad 6s Pro


