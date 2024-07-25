Return-Path: <stable+bounces-61359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450F393BDC0
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 10:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6676B1C21A70
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 08:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E92172BC4;
	Thu, 25 Jul 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KpGfhY+Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A826101F2;
	Thu, 25 Jul 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721895260; cv=none; b=C2sebPmbkb+A8ED3tMCd5S8w1mIfJMgqz7iei0gkpWfP7uZuEmFBEYnBlNytuJ4XJ6BMgfyKztkBccreseKJ3K6n9abR4NOYQthbymTRLofPjdXn1sJLKln7iPUl/aK1BqGiTgGXLvA5yc8Jd0juspi5BsGEBXhEEaitLHjnanM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721895260; c=relaxed/simple;
	bh=vT29Cxjma1W2LtCp3lL5YqYW6QgHaYOTOssNaAixD/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pv0POny61uU1MRBDBzmlaxmdgLHl4NnIc7i0reZcb7cZG+eESq+wLpC2i89vJ/OEp/kFYSZF0p+jp8Uf5sMLGxHvV062yzIVq9jXSORpb+pIIIC1K+VU/L/a5iF7/L1tWj2W0NxnBqMU0oP80yLaD342V+cx28CYf+w95Gru7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KpGfhY+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B735CC116B1;
	Thu, 25 Jul 2024 08:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721895260;
	bh=vT29Cxjma1W2LtCp3lL5YqYW6QgHaYOTOssNaAixD/M=;
	h=From:To:Cc:Subject:Date:From;
	b=KpGfhY+YoU1+xdo6Zliq2XyokoMY/JIx/3Nmf3l96HrJb0OFk09eQKKLQs3eMh1d9
	 SBCkzxUnj9UjMLmwJOYFiVa8JVdWv0HJCq2Av8VZqToe9cnjJA2BUFBNYcwz0+e0if
	 HkhAQPLXXW+AieAxfjlKnCVRJZolZwYPc/zb5mu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.101
Date: Thu, 25 Jul 2024 10:14:14 +0200
Message-ID: <2024072515-unblessed-presoak-b81b@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.101 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm/include/asm/uaccess.h                                 |   14 
 arch/mips/kernel/syscalls/syscall_o32.tbl                      |    2 
 arch/powerpc/kernel/eeh_pe.c                                   |    7 
 arch/powerpc/kvm/book3s_64_vio.c                               |   18 -
 arch/powerpc/platforms/pseries/setup.c                         |    4 
 arch/riscv/kernel/stacktrace.c                                 |    3 
 drivers/acpi/ec.c                                              |    9 
 drivers/block/null_blk/main.c                                  |    4 
 drivers/firmware/efi/libstub/zboot.lds                         |    1 
 drivers/gpio/gpio-pca953x.c                                    |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c |    3 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                 |    6 
 drivers/gpu/drm/radeon/radeon_gem.c                            |    2 
 drivers/gpu/drm/vmwgfx/Kconfig                                 |    2 
 drivers/hid/hid-ids.h                                          |    2 
 drivers/hid/hid-input.c                                        |    4 
 drivers/input/mouse/elantech.c                                 |   31 ++
 drivers/input/serio/i8042-acpipnpio.h                          |   18 +
 drivers/input/touchscreen/silead.c                             |   19 -
 drivers/misc/mei/main.c                                        |    2 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c               |    2 
 drivers/net/ethernet/ibm/ibmvnic.c                             |   12 
 drivers/net/usb/qmi_wwan.c                                     |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                    |   16 -
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c              |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                  |    8 
 drivers/nvme/host/core.c                                       |    1 
 drivers/nvme/target/core.c                                     |    1 
 drivers/nvme/target/fabrics-cmd-auth.c                         |    3 
 drivers/nvme/target/fabrics-cmd.c                              |    6 
 drivers/of/irq.c                                               |  143 +++++-----
 drivers/of/of_private.h                                        |    3 
 drivers/perf/riscv_pmu_sbi.c                                   |    2 
 drivers/platform/mellanox/nvsw-sn2201.c                        |    5 
 drivers/platform/x86/lg-laptop.c                               |   89 ++----
 drivers/platform/x86/wireless-hotkey.c                         |    2 
 drivers/s390/char/sclp.c                                       |    1 
 drivers/scsi/device_handler/scsi_dh_alua.c                     |   31 +-
 drivers/scsi/libsas/sas_internal.h                             |   14 
 drivers/scsi/qedf/qedf.h                                       |    1 
 drivers/scsi/qedf/qedf_main.c                                  |   47 +++
 drivers/spi/spi-imx.c                                          |    2 
 drivers/spi/spi-mux.c                                          |    1 
 drivers/tee/optee/ffa_abi.c                                    |   12 
 fs/btrfs/qgroup.c                                              |    4 
 fs/cachefiles/cache.c                                          |   45 +++
 fs/cachefiles/ondemand.c                                       |   74 +++--
 fs/cachefiles/volume.c                                         |    1 
 fs/dcache.c                                                    |   31 --
 fs/erofs/zmap.c                                                |    2 
 fs/file.c                                                      |    4 
 fs/fscache/internal.h                                          |    2 
 fs/fscache/volume.c                                            |   14 
 fs/hfsplus/xattr.c                                             |    2 
 fs/iomap/buffered-io.c                                         |    3 
 fs/locks.c                                                     |    9 
 fs/nfs/dir.c                                                   |   27 -
 fs/nfs/nfs4proc.c                                              |    1 
 fs/nfs/symlink.c                                               |    2 
 fs/smb/client/cifsfs.c                                         |    2 
 fs/smb/common/smb2pdu.h                                        |   34 ++
 fs/smb/server/smb2pdu.c                                        |    9 
 include/linux/fscache-cache.h                                  |    6 
 include/linux/minmax.h                                         |   89 ++++--
 include/net/bluetooth/hci_sync.h                               |    2 
 include/sound/dmaengine_pcm.h                                  |    1 
 include/trace/events/fscache.h                                 |    4 
 mm/damon/core.c                                                |   21 +
 net/bluetooth/hci_core.c                                       |   76 +----
 net/bluetooth/hci_sync.c                                       |   13 
 net/bluetooth/l2cap_core.c                                     |    3 
 net/bluetooth/l2cap_sock.c                                     |   14 
 net/ipv6/ila/ila_lwt.c                                         |    7 
 net/ipv6/rpl_iptunnel.c                                        |   14 
 net/mac80211/cfg.c                                             |    5 
 net/mac80211/ieee80211_i.h                                     |    2 
 net/mac80211/main.c                                            |   11 
 net/mac80211/mesh.c                                            |    1 
 net/mac80211/scan.c                                            |   14 
 net/mac80211/util.c                                            |    4 
 net/mac802154/tx.c                                             |    8 
 net/wireless/rdev-ops.h                                        |    6 
 net/wireless/scan.c                                            |   59 ++--
 scripts/gcc-plugins/gcc-common.h                               |    4 
 scripts/kconfig/expr.c                                         |   29 --
 scripts/kconfig/expr.h                                         |    1 
 scripts/kconfig/gconf.c                                        |    3 
 scripts/kconfig/menu.c                                         |    2 
 sound/core/pcm_dmaengine.c                                     |   22 +
 sound/core/pcm_native.c                                        |    2 
 sound/pci/hda/patch_realtek.c                                  |    5 
 sound/soc/amd/yc/acp6x-mach.c                                  |    7 
 sound/soc/intel/boards/bytcr_rt5640.c                          |   11 
 sound/soc/soc-generic-dmaengine-pcm.c                          |    8 
 sound/soc/soc-topology.c                                       |   29 +-
 sound/soc/sof/sof-audio.c                                      |    2 
 sound/soc/ti/davinci-mcasp.c                                   |    9 
 sound/soc/ti/omap-hdmi.c                                       |    6 
 tools/power/cpupower/utils/helpers/amd.c                       |   26 +
 tools/testing/selftests/futex/functional/Makefile              |    2 
 tools/testing/selftests/openat2/openat2_test.c                 |    1 
 tools/testing/selftests/vDSO/parse_vdso.c                      |   16 -
 tools/testing/selftests/vDSO/vdso_standalone_test_x86.c        |   18 +
 104 files changed, 934 insertions(+), 456 deletions(-)

Aivaz Latypov (1):
      ALSA: hda/relatek: Enable Mute LED on HP Laptop 15-gw0xxx

Alexander Usyskin (1):
      mei: demote client disconnect warning on suspend to debug

Alexey Makhalov (1):
      drm/vmwgfx: Fix missing HYPERVISOR_GUEST dependency

Alvin Lee (1):
      drm/amd/display: Account for cursor prefetch BW in DML1 mode support

Amadeusz Sławiński (2):
      ASoC: topology: Fix references to freed memory
      ASoC: topology: Do not assign fields that are already set

Andreas Hindborg (1):
      null_blk: fix validation of block size

Andy Shevchenko (1):
      minmax: fix header inclusions

Anjali K (1):
      powerpc/pseries: Whitelist dtl slub object for copying to userspace

Armin Wolf (6):
      ACPI: EC: Abort address space access upon error
      ACPI: EC: Avoid returning AE_OK on errors in address space handler
      platform/x86: wireless-hotkey: Add support for LG Airplane Button
      platform/x86: lg-laptop: Remove LGEX0815 hotkey handling
      platform/x86: lg-laptop: Change ACPI device id
      platform/x86: lg-laptop: Use ACPI device handle when evaluating WMAB/WMBB

Arnd Bergmann (1):
      mips: fix compat_sys_lseek syscall

Ayala Beker (1):
      wifi: iwlwifi: mvm: properly set 6 GHz channel direct probe option

Baokun Li (5):
      cachefiles: add consistency check for copen/cread
      cachefiles: make on-demand read killable
      netfs, fscache: export fscache_put_volume() and add fscache_try_get_volume()
      cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
      cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()

Chen Ni (2):
      can: kvaser_usb: fix return value for hif_usb_send_regout
      platform/mellanox: nvsw-sn2201: Add check for platform_device_add_resources

Christian Brauner (1):
      fs: better handle deep ancestor chains in is_subdir()

Chunguang Xu (1):
      nvme: avoid double free special payload

Daniel Gabay (1):
      wifi: iwlwifi: properly set WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK

Daniel Wagner (1):
      nvmet: always initialize cqe.result

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FN912 compositions

David Laight (3):
      minmax: allow min()/max()/clamp() if the arguments have the same signedness.
      minmax: allow comparisons of 'int' against 'unsigned char/short'
      minmax: relax check to allow comparison between unsigned arguments and signed constants

David Lechner (1):
      spi: mux: set ctlr->bits_per_word_mask

Dhananjay Ugwekar (1):
      tools/power/cpupower: Fix Pstate frequency reporting on AMD Family 1Ah CPUs

Dmitry Antipov (2):
      wifi: mac80211: fix UBSAN noise in ieee80211_prep_hw_scan()
      wifi: cfg80211: wext: add extra SIOCSIWSCAN data check

Dmitry Mastykin (1):
      NFSv4: Fix memory leak in nfs4_set_security_label

Edward Adam Davis (2):
      bluetooth/l2cap: sync sock recv cb and release
      hfsplus: fix uninit-value in copy_name

Eric Dumazet (2):
      net: ipv6: rpl_iptunnel: block BH in rpl_output() and rpl_input()
      ila: block BH in ila_output()

Filipe Manana (1):
      btrfs: qgroup: fix quota root leak after quota disable failure

Ganesh Goudar (1):
      powerpc/eeh: avoid possible crash when edev->pdev changes

Gao Xiang (1):
      erofs: ensure m_llen is reset to 0 if metadata is invalid

Greg Kroah-Hartman (1):
      Linux 6.1.101

Hans de Goede (1):
      Input: silead - Always support 10 fingers

Heiko Carstens (1):
      s390/sclp: Fix sclp_init() cleanup on failure

Ian Ray (1):
      gpio: pca953x: fix pca953x_irq_bus_sync_unlock race

Ilan Peer (1):
      wifi: iwlwifi: mvm: Fix scan abort handling with HW rfkill

Jai Luthra (2):
      ALSA: dmaengine: Synchronize dma channel after drop()
      ASoC: ti: davinci-mcasp: Set min period size using FIFO config

Jann Horn (1):
      filelock: Remove locks reliably when fcntl/close race is detected

Jason A. Donenfeld (2):
      minmax: sanity check constant bounds when clamping
      minmax: clamp more efficiently by avoiding extra comparison

Johannes Berg (5):
      wifi: mac80211: apply mcast rate only if interface is up
      wifi: mac80211: handle tasklet frames before stopping
      wifi: cfg80211: fix 6 GHz scan request building
      wifi: cfg80211: wext: set ssids=NULL for passive scans
      wifi: mac80211: disable softirqs for queued frame handling

John Hubbard (2):
      selftests/futex: pass _GNU_SOURCE without a value to the compiler
      selftests/vDSO: fix clang build errors and warnings

Jonathan Denose (1):
      Input: elantech - fix touchpad state on resume for Lenovo N24

Kailang Yang (1):
      ALSA: hda/realtek: Add more codec ID to no shutup pins list

Kees Cook (1):
      gcc-plugins: Rename last_stmt() for GCC 14+

Louis Dalibard (1):
      HID: Ignore battery for ELAN touchscreens 2F2C and 4116

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix deadlock

Marc Zyngier (1):
      of/irq: Disable "interrupt-map" parsing for PASEMI Nemo

Mark-PK Tsai (1):
      tee: optee: ffa: Fix missing-field-initializers warning

Martin Wilck (1):
      scsi: core: alua: I/O errors for ALUA state transitions

Masahiro Yamada (3):
      kconfig: gconf: give a proper initial state to the Save button
      kconfig: remove wrong expr_trans_bool()
      ARM: 9324/1: fix get_user() broken with veneer

Michael Ellerman (2):
      selftests/openat2: Fix build warnings on ppc64
      KVM: PPC: Book3S HV: Prevent UAF in kvm_spapr_tce_attach_iommu_group()

Namjae Jeon (1):
      ksmbd: return FILE_DEVICE_DISK instead of super magic

Nathan Chancellor (1):
      efi/libstub: zboot.lds: Discard .discard sections

Nick Child (1):
      ibmvnic: Add tx check to prevent skb leak

Nicolas Escande (1):
      wifi: mac80211: mesh: init nonpeer_pm to active by default in mesh sdata

Peter Ujfalusi (1):
      ASoC: SOF: sof-audio: Skip unprepare for in-use widgets on error rollback

Pierre-Eric Pelloux-Prayer (1):
      drm/radeon: check bo_va->bo is non-NULL before using it

Primoz Fiser (1):
      ASoC: ti: omap-hdmi: Fix too long driver name

Puranjay Mohan (1):
      riscv: stacktrace: fix usage of ftrace_graph_ret_addr()

Ritesh Harjani (IBM) (1):
      iomap: Fix iomap_adjust_read_range for plen calculation

Rob Herring (Arm) (1):
      of/irq: Factor out parsing of interrupt-map parent phandle+args from of_irq_parse_raw()

Sagi Grimberg (1):
      nfs: propagate readlink errors in nfs_symlink_filler

Samuel Holland (1):
      drivers/perf: riscv: Reset the counter to hpmevent mapping while starting cpus

Saurav Kashyap (3):
      scsi: qedf: Don't process stag work during unload and recovery
      scsi: qedf: Wait for stag work during unload
      scsi: qedf: Set qed_slowpath_params to zero before use

Scott Mayhew (1):
      nfs: don't invalidate dentries on transient errors

SeongJae Park (1):
      mm/damon/core: merge regions aggressively when max_nr_regions is unmet

Shengjiu Wang (1):
      ALSA: dmaengine_pcm: terminate dmaengine before synchronize

Steve French (1):
      cifs: fix noisy message on copy_file_range

Takashi Iwai (1):
      ALSA: PCM: Allow resume only for suspended streams

Tetsuo Handa (1):
      Bluetooth: hci_core: cancel all works upon hci_unregister_dev()

Thomas GENTY (1):
      bytcr_rt5640 : inverse jack detect for Archos 101 cesium

Tobias Jakobi (2):
      drm: panel-orientation-quirks: Add quirk for Aya Neo KUN
      Input: i8042 - add Ayaneo Kun to i8042 quirk table

Uwe Kleine-König (1):
      spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices

Vyacheslav Frantsishko (1):
      ASoC: amd: yc: Fix non-functional mic on ASUS M5602RA

Xingui Yang (1):
      scsi: libsas: Fix exp-attached device scan after probe failure scanned in again after probe failed

Yedidya Benshimol (2):
      wifi: iwlwifi: mvm: d3: fix WoWLAN command version lookup
      wifi: iwlwifi: mvm: Handle BIGTK cipher in kek_kck cmd

Yunshui Jiang (1):
      net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD()

Yuntao Wang (1):
      fs/file: fix the check in find_next_fd()

Zizhi Wo (1):
      cachefiles: Set object to close if ondemand_id < 0 in copen


