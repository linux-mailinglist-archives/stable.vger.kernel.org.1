Return-Path: <stable+bounces-160282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBBFAFA3DF
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A96189FE48
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4972E1F5828;
	Sun,  6 Jul 2025 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XYr15+0x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0248D1F4C99;
	Sun,  6 Jul 2025 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751793218; cv=none; b=TWsXgn22Pv+M9TtAma5raBK024y0OkJ4v8AUmmaseDHp4IxIYu9xmTkWFB64CrB5NsCePA5Uxigq5svbVcdZOq9nmZ2brLjqw+L6SgxApF5MTrIwhpJnJlgvSTURXUMonoPYgdFkVZRGgD/oecy1o378YHTK32y0C6fQFo7zWzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751793218; c=relaxed/simple;
	bh=+3axTVYKdYzlXKbgQytwDGVjP1opz8zCSepUzuI/T+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fK6ISZAEyDJP5FQzmgPZhlQiwoi+9JDaNrwAZobM93LJmeYVg7cIlSp4+Xb2lC07348AprzcX4FAH9diGuDWERZPVumdosKuuDfR5ooIL+zrQ4E7ezbDHXwnsa16KZ2My2t1PTXlbLk5Lht9wLOjSRTDq/876Q/AJFg3UBhHZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XYr15+0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C4EC4CEED;
	Sun,  6 Jul 2025 09:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751793215;
	bh=+3axTVYKdYzlXKbgQytwDGVjP1opz8zCSepUzuI/T+s=;
	h=From:To:Cc:Subject:Date:From;
	b=XYr15+0xKDWG9eZRNkBd6gYCJwgv8KMG/kczN/+mPRsRtuNlozsW6qNBzTDZ21ZBB
	 JPd2gzsrASz2xkaH/AeLkJCdE14Oe5S9sayo40oRBW+I3x46S6kkf3x9Ml/2y5dYi5
	 9mIhzy2VMj+JCotZpdH7U99VL1Nm/VJmnPwT6B98=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.96
Date: Sun,  6 Jul 2025 11:13:31 +0200
Message-ID: <2025070631-dragonish-dallying-95aa@gregkh>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.96 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/8250.yaml         |    2 
 Makefile                                                   |    2 
 arch/arm/include/asm/ptrace.h                              |    5 
 arch/s390/kernel/entry.S                                   |    2 
 arch/um/drivers/ubd_user.c                                 |    2 
 arch/um/include/asm/asm-prototypes.h                       |    5 
 arch/um/kernel/trap.c                                      |  129 ++++++-
 arch/x86/tools/insn_decoder_test.c                         |    5 
 arch/x86/um/asm/checksum.h                                 |    3 
 drivers/cxl/core/region.c                                  |    7 
 drivers/dma/idxd/cdev.c                                    |    4 
 drivers/dma/xilinx/xilinx_dma.c                            |    2 
 drivers/edac/amd64_edac.c                                  |   57 +--
 drivers/firmware/arm_scmi/driver.c                         |   44 ++
 drivers/firmware/arm_scmi/protocols.h                      |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                 |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c                  |   30 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                    |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h                   |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c                  |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h                  |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c               |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_events.c                    |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c         |    2 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c        |    3 
 drivers/gpu/drm/ast/ast_mode.c                             |    6 
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c             |   32 +
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                      |  109 +++--
 drivers/gpu/drm/etnaviv/etnaviv_sched.c                    |    5 
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c             |    2 
 drivers/gpu/drm/i915/i915_pmu.c                            |    2 
 drivers/gpu/drm/msm/msm_gpu_devfreq.c                      |    1 
 drivers/gpu/drm/scheduler/sched_entity.c                   |    1 
 drivers/gpu/drm/tegra/dc.c                                 |   17 
 drivers/gpu/drm/tegra/hub.c                                |    4 
 drivers/gpu/drm/tegra/hub.h                                |    3 
 drivers/gpu/drm/tiny/cirrus.c                              |    1 
 drivers/gpu/drm/udl/udl_drv.c                              |    2 
 drivers/hid/hid-lenovo.c                                   |   11 
 drivers/hid/wacom_sys.c                                    |    6 
 drivers/hv/channel_mgmt.c                                  |   15 
 drivers/hv/hyperv_vmbus.h                                  |    5 
 drivers/hwmon/pmbus/max34440.c                             |   48 ++
 drivers/hwtracing/coresight/coresight-core.c               |    3 
 drivers/hwtracing/coresight/coresight-priv.h               |    1 
 drivers/i2c/busses/i2c-robotfuzz-osif.c                    |    6 
 drivers/i2c/busses/i2c-tiny-usb.c                          |    6 
 drivers/iio/adc/ad_sigma_delta.c                           |    4 
 drivers/iio/pressure/zpa2326.c                             |    2 
 drivers/leds/led-class-multicolor.c                        |    3 
 drivers/mailbox/mailbox.c                                  |    2 
 drivers/md/bcache/super.c                                  |    7 
 drivers/md/dm-raid.c                                       |    2 
 drivers/md/md-bitmap.c                                     |    2 
 drivers/media/usb/uvc/uvc_ctrl.c                           |   39 +-
 drivers/mfd/max14577.c                                     |    1 
 drivers/misc/tps6594-pfsm.c                                |    3 
 drivers/net/ethernet/freescale/enetc/enetc_hw.h            |    2 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                |    2 
 drivers/nvme/host/ioctl.c                                  |   16 
 drivers/pci/controller/dwc/pcie-designware.c               |    5 
 drivers/pci/controller/pcie-apple.c                        |    7 
 drivers/platform/x86/Kconfig                               |    1 
 drivers/platform/x86/ideapad-laptop.c                      |  237 +++++++++++++
 drivers/platform/x86/ideapad-laptop.h                      |  142 -------
 drivers/platform/x86/lenovo-ymc.c                          |   60 ---
 drivers/s390/crypto/pkey_api.c                             |    2 
 drivers/scsi/megaraid/megaraid_sas_base.c                  |    6 
 drivers/spi/spi-cadence-quadspi.c                          |   11 
 drivers/staging/rtl8723bs/core/rtw_security.c              |   44 --
 drivers/tty/serial/imx.c                                   |   17 
 drivers/tty/serial/uartlite.c                              |   25 -
 drivers/tty/vt/vt.c                                        |   12 
 drivers/ufs/core/ufshcd.c                                  |    3 
 drivers/uio/uio_hv_generic.c                               |   10 
 drivers/usb/class/cdc-wdm.c                                |   23 -
 drivers/usb/common/usb-conn-gpio.c                         |   25 +
 drivers/usb/core/usb.c                                     |   14 
 drivers/usb/dwc2/gadget.c                                  |    6 
 drivers/usb/gadget/function/f_tcm.c                        |    4 
 drivers/usb/typec/altmodes/displayport.c                   |    4 
 drivers/usb/typec/mux.c                                    |    4 
 drivers/video/console/dummycon.c                           |   24 -
 drivers/video/console/mdacon.c                             |   21 -
 drivers/video/console/newport_con.c                        |   12 
 drivers/video/console/sticon.c                             |   14 
 drivers/video/console/vgacon.c                             |   12 
 drivers/video/fbdev/core/fbcon.c                           |   40 +-
 fs/btrfs/disk-io.c                                         |    3 
 fs/btrfs/inode.c                                           |   81 +++-
 fs/btrfs/volumes.c                                         |    6 
 fs/ceph/file.c                                             |    2 
 fs/f2fs/super.c                                            |   30 -
 fs/fuse/dir.c                                              |   11 
 fs/jfs/jfs_dmap.c                                          |   41 --
 fs/namespace.c                                             |    8 
 fs/nfs/inode.c                                             |    2 
 fs/nfs/nfs4proc.c                                          |   17 
 fs/overlayfs/util.c                                        |    4 
 fs/smb/client/cifsglob.h                                   |    2 
 fs/smb/client/cifspdu.h                                    |    6 
 fs/smb/client/cifssmb.c                                    |    1 
 fs/smb/client/connect.c                                    |   58 +--
 fs/smb/client/misc.c                                       |    8 
 fs/smb/client/sess.c                                       |   21 -
 fs/smb/server/connection.h                                 |    1 
 fs/smb/server/smb2pdu.c                                    |   81 ++--
 fs/smb/server/smb2pdu.h                                    |    3 
 include/linux/console.h                                    |   13 
 include/linux/hyperv.h                                     |    2 
 include/linux/ipv6.h                                       |    1 
 include/uapi/linux/vm_sockets.h                            |    4 
 lib/Kconfig.debug                                          |    9 
 lib/Makefile                                               |    2 
 lib/group_cpus.c                                           |    9 
 lib/longest_symbol_kunit.c                                 |   82 ++++
 mm/damon/sysfs-schemes.c                                   |    1 
 net/atm/clip.c                                             |   11 
 net/atm/resources.c                                        |    3 
 net/bluetooth/l2cap_core.c                                 |    9 
 net/core/selftests.c                                       |    5 
 net/ipv6/ip6_output.c                                      |    9 
 net/mac80211/util.c                                        |    2 
 net/sunrpc/clnt.c                                          |    9 
 net/unix/af_unix.c                                         |  107 ++++-
 net/unix/garbage.c                                         |   24 -
 rust/macros/module.rs                                      |    1 
 scripts/checkstack.pl                                      |    3 
 scripts/gdb/linux/tasks.py                                 |   15 
 scripts/head-object-list.txt                               |    1 
 scripts/kconfig/mconf.c                                    |    2 
 scripts/kconfig/nconf.c                                    |    2 
 scripts/package/kernel.spec                                |   28 -
 scripts/package/mkdebian                                   |    2 
 scripts/recordmcount.c                                     |    1 
 scripts/recordmcount.pl                                    |    7 
 scripts/xz_wrap.sh                                         |    1 
 sound/pci/hda/hda_bind.c                                   |    2 
 sound/pci/hda/hda_intel.c                                  |    3 
 sound/pci/hda/patch_realtek.c                              |    1 
 sound/soc/amd/yc/acp6x-mach.c                              |    7 
 sound/soc/codecs/wcd9335.c                                 |   62 +--
 sound/usb/quirks.c                                         |    2 
 sound/usb/stream.c                                         |    2 
 tools/lib/bpf/btf_dump.c                                   |    3 
 tools/lib/bpf/libbpf.c                                     |   10 
 tools/testing/selftests/bpf/progs/test_global_map_resize.c |   16 
 149 files changed, 1557 insertions(+), 828 deletions(-)

Adin Scannell (1):
      libbpf: Fix possible use-after-free for externs

Al Viro (1):
      attach_recursive_mnt(): do not lock the covering tree when sliding something under it

Alex Deucher (1):
      drm/amdgpu: switch job hw_fence to amdgpu_fence

Alexis Czezar Torreno (1):
      hwmon: (pmbus/max34440) Fix support for max34451

Andy Shevchenko (1):
      usb: Add checks for snprintf() calls in usb_alloc_dev()

Aradhya Bhatia (5):
      drm/bridge: cdns-dsi: Fix the clock variable for mode_valid()
      drm/bridge: cdns-dsi: Fix phy de-init and flag it so
      drm/bridge: cdns-dsi: Fix connecting to next bridge
      drm/bridge: cdns-dsi: Check return value when getting default PHY config
      drm/bridge: cdns-dsi: Wait for Clk and Data Lanes to be ready

Arnd Bergmann (1):
      drm/i915: fix build error some more

Avadhut Naik (1):
      EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs

Benjamin Berg (1):
      um: use proper care when taking mmap lock during segfault

Brett A C Sheffield (Librecast) (1):
      Revert "ipv6: save dontfrag in cork"

Cezary Rojewski (1):
      ALSA: hda: Ignore unsol events for cards being shut down

Chance Yang (1):
      usb: common: usb-conn-gpio: use a unique name for usb connector device

Chao Yu (1):
      f2fs: don't over-report free space or inodes in statvfs

Chen Yu (1):
      scsi: megaraid_sas: Fix invalid node index

Chen Yufeng (1):
      usb: potential integer overflow in usbg_make_tpg()

Chenyuan Yang (1):
      misc: tps6594-pfsm: Add NULL pointer check in tps6594_pfsm_probe()

Cristian Marussi (1):
      firmware: arm_scmi: Add a common helper to check if a message is supported

Dave Kleikamp (1):
      fs/jfs: consolidate sanity checking in dbMount

Dmitry Kandybka (1):
      ceph: fix possible integer overflow in ceph_zero_objects()

Eric Dumazet (1):
      atm: clip: prevent NULL deref in clip_push()

FUJITA Tomonori (1):
      rust: module: place cleanup_module() in .exit.text section

Fabio Estevam (1):
      serial: imx: Restore original RXTL for console to fix data loss

Fedor Pchelkin (1):
      s390/pkey: Prevent overflow in size calculation for memdup_user()

Filipe Manana (1):
      btrfs: fix a race between renames and directory logging

Frank Min (1):
      drm/amdgpu: Add kicker device detection

Frédéric Danis (1):
      Bluetooth: L2CAP: Fix L2CAP MTU negotiation

Geert Uytterhoeven (1):
      ARM: 9354/1: ptrace: Use bitfield helpers

Gergo Koteles (3):
      platform/x86: ideapad-laptop: introduce a generic notification chain
      platform/x86: ideapad-laptop: move ymc_trigger_ec from lenovo-ymc
      platform/x86: ideapad-laptop: move ACPI helpers from header to source file

Greg Kroah-Hartman (1):
      Linux 6.6.96

Guang Yuan Wu (1):
      fuse: fix race between concurrent setattrs from multiple nodes

Han Young (1):
      NFSv4: Always set NLINK even if the server doesn't support it

Hector Martin (1):
      PCI: apple: Fix missing OF node reference in apple_pcie_setup_port

Heiko Carstens (1):
      s390/entry: Fix last breaking event handling in case of stack corruption

Heinz Mauelshagen (1):
      dm-raid: fix variable in journal device check

Iusico Maxim (1):
      HID: lenovo: Restrict F7/9/11 mode to compact keyboards only

Jakub Kicinski (1):
      net: selftests: fix TCP packet checksum

Jakub Lewalski (1):
      tty: serial: uartlite: register uart driver in init

James Clark (1):
      coresight: Only check bottom two claim bits

Janne Grunau (1):
      PCI: apple: Set only available ports up

Jay Cornwall (1):
      drm/amdkfd: Fix race in GWS queue scheduling

Jayesh Choudhary (1):
      drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort connector type

Jens Axboe (1):
      nvme: always punt polled uring_cmd end_io work to task_work

Jiawen Wu (1):
      net: libwx: fix the creation of page_pool

Jiri Slaby (SUSE) (3):
      tty: vt: make init parameter of consw::con_init() a bool
      tty: vt: sanitize arguments of consw::con_clear()
      tty: vt: make consw::con_switch() return a bool

John Olender (1):
      drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to total vram

Jonathan Cameron (1):
      iio: pressure: zpa2326: Use aligned_s64 for the timestamp

Jos Wang (1):
      usb: typec: displayport: Receive DP Status Update NAK request exit dp altmode

Jose Ignacio Tornos Martinez (1):
      kbuild: rpm-pkg: simplify installkernel %post

Kees Cook (1):
      ovl: Check for NULL d_inode() in ovl_dentry_upper()

Khairul Anuar Romli (1):
      spi: spi-cadence-quadspi: Fix pm runtime unbalance

Krzysztof Kozlowski (3):
      mfd: max14577: Fix wakeup source leaks on device unbind
      ASoC: codecs: wcd9335: Handle nicer probe deferral and simplify with dev_err_probe()
      ASoC: codecs: wcd9335: Fix missing free of regulator supplies

Kuniyuki Iwashima (7):
      af_unix: Define locking order for unix_table_double_lock().
      af_unix: Define locking order for U_LOCK_SECOND in unix_state_double_lock().
      af_unix: Define locking order for U_RECVQ_LOCK_EMBRYO in unix_collect_skb().
      af_unix: Don't call skb_get() for OOB skb.
      af_unix: Don't leave consecutive consumed OOB skbs.
      af_unix: Don't set -ECONNRESET for consumed OOB skb.
      atm: Release atm_dev_mutex after removing procfs in atm_dev_deregister().

Lachlan Hodges (1):
      wifi: mac80211: fix beacon interval calculation overflow

Lin.Cao (1):
      drm/scheduler: signal scheduled fence when kill job

Linggang Zeng (1):
      bcache: fix NULL pointer in cache_set_flush()

Long Li (1):
      uio_hv_generic: Align ring size to system page

Mario Limonciello (1):
      ALSA: usb-audio: Add a quirk for Lenovo Thinkpad Thunderbolt 3 dock

Mark Harmstone (1):
      btrfs: update superblock's device bytes_used when dropping chunk

Masahiro Yamada (1):
      scripts: clean up IA-64 code

Maíra Canal (1):
      drm/etnaviv: Protect the scheduler's pending list with its lock

Michael Grzeschik (2):
      usb: dwc2: also exit clock_gating when stopping udc while suspended
      usb: typec: mux: do not return on EOPNOTSUPP in {mux, switch}_set

Namjae Jeon (4):
      ksmbd: allow a filename to contain special characters on SMB3.1.1 posix extension
      ksmbd: provide zero as a unique ID to the Mac client
      ksmbd: Use unsafe_memcpy() for ntlm_negotiate
      ksmbd: remove unsafe_memcpy use in session setup

Nathan Chancellor (2):
      staging: rtl8723bs: Avoid memset() in aes_cipher() and aes_decipher()
      x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c

Nikhil Jha (1):
      sunrpc: don't immediately retransmit on seqno miss

Olga Kornievskaia (1):
      NFSv4.2: fix listxattr to return selinux security label

Oliver Schramm (1):
      ASoC: amd: yc: Add DMI quirk for Lenovo IdeaPad Slim 5 15

Pali Rohár (3):
      cifs: Correctly set SMB1 SessionKey field in Session Setup Request
      cifs: Fix cifs_query_path_info() for Windows NT servers
      cifs: Fix encoding of SMB1 Session Setup NTLMSSP Request in non-UNICODE mode

Paulo Alcantara (1):
      smb: client: fix potential deadlock when reconnecting channels

Peng Fan (2):
      mailbox: Not protect module_put with spin_lock_irqsave
      ASoC: codec: wcd9335: Convert to GPIO descriptors

Purva Yeshi (1):
      iio: adc: ad_sigma_delta: Fix use of uninitialized status_pos

Qasim Ijaz (3):
      HID: wacom: fix memory leak on kobject creation failure
      HID: wacom: fix memory leak on sysfs attribute creation failure
      HID: wacom: fix kobject reference count leak

Qiu-ji Chen (1):
      drm/tegra: Fix a possible null pointer dereference

Qu Wenruo (1):
      btrfs: handle csum tree error with rescue=ibadroots correctly

Ricardo Ribalda (1):
      media: uvcvideo: Rollback non processed entities on error

Robert Hodaszi (1):
      usb: cdc-wdm: avoid setting WDM_READ for ZLP-s

Robert Richter (1):
      cxl/region: Add a dev_err() on missing target list entries

Rong Zhang (1):
      platform/x86: ideapad-laptop: use usleep_range() for EC polling

Salvatore Bonaccorso (1):
      ALSA: hda/realtek: Fix built-in mic on ASUS VivoBook X507UAR

Sami Tolvanen (1):
      um: Add cmpxchg8b_emu and checksum functions to asm-prototypes.h

Saurabh Sengar (2):
      Drivers: hv: vmbus: Add utility function for querying ring size
      uio_hv_generic: Query the ringbuffer size for device

Scott Mayhew (1):
      NFSv4: xattr handlers should check for absent nfs filehandles

SeongJae Park (1):
      mm/damon/sysfs-schemes: free old damon_sysfs_scheme_filter->memcg_path on write

Sergio González Collado (1):
      Kunit to check the longest symbol length

Sibi Sankar (1):
      firmware: arm_scmi: Ensure that the message-id supports fastchannel

Simon Horman (1):
      net: enetc: Correct endianness handling in _enetc_rd_reg64

Stefano Garzarella (1):
      vsock/uapi: fix linux/vm_sockets.h userspace compilation errors

Stephan Gerhold (1):
      drm/msm/gpu: Fix crash when throttling GPU immediately during boot

Sven Schwermer (1):
      leds: multicolor: Fix intensity setting while SW blinking

Thierry Reding (1):
      drm/tegra: Assign plane type before registration

Thomas Gessler (1):
      dmaengine: xilinx_dma: Set dma_device directions

Thomas Zimmermann (4):
      dummycon: Trigger redraw when switching consoles with deferred takeover
      drm/ast: Fix comment on modeset lock
      drm/cirrus-qemu: Fix pitch programming
      drm/udl: Unregister device before cleaning up on disconnect

Tiwei Bie (1):
      um: ubd: Add missing error check in start_io_thread()

Vasiliy Kovalev (1):
      jfs: validate AG parameters in dbMount() to prevent crashes

Vijendar Mukunda (1):
      ALSA: hda: Add new pci id for AMD GPU display HD audio controller

Ville Syrjälä (1):
      drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1

Wenbin Yao (1):
      PCI: dwc: Make link training more robust by setting PORT_LOGIC_LINK_WIDTH to one lane

Wentao Liang (1):
      drm/amd/display: Add null pointer check for get_first_active_display()

Wolfram Sang (3):
      i2c: tiny-usb: disable zero-length read messages
      i2c: robotfuzz-osif: disable zero-length read messages
      drm/bridge: ti-sn65dsi86: make use of debugfs_init callback

Yao Zi (1):
      dt-bindings: serial: 8250: Make clocks and clock-frequency exclusive

Yi Sun (1):
      dmaengine: idxd: Check availability of workqueue allocated by idxd wq driver before using

Yifan Zhang (1):
      amd/amdkfd: fix a kfd_process ref leak

Youngjun Lee (1):
      ALSA: usb-audio: Fix out-of-bounds read in snd_usb_get_audioformat_uac3()

Yu Kuai (2):
      md/md-bitmap: fix dm-raid max_write_behind setting
      lib/group_cpus: fix NULL pointer dereference from group_cpus_evenly()

Yuan Chen (1):
      libbpf: Fix null pointer dereference in btf_dump__free on allocation failure

Zhang Zekun (1):
      PCI: apple: Use helper function for_each_child_of_node_scoped()

Ziqi Chen (1):
      scsi: ufs: core: Don't perform UFS clkscaling during host async scan


