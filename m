Return-Path: <stable+bounces-160281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B073FAFA3DD
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51499189FD84
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 09:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D363C1EFFA6;
	Sun,  6 Jul 2025 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="olL1ZK3M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098A1EEA5D;
	Sun,  6 Jul 2025 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751793212; cv=none; b=G3y0j0D9x84yNsfkuduF0VRv16CNByhALloHhrxcaYhaG5E/3QGBMLuQWsdGQEzHujEaeoLAz/38IPyJR0X3aIpsYm3VsP1Tsf/8MCoIWcEf2EJ7pQF2M9XJf/u79HyI7DlaOhj3GR6VbZp8LeXHJFAB0JdWOSCbIC71fJCY4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751793212; c=relaxed/simple;
	bh=049AuEMm6PalDY7ilexr/Lxx2QoKgjpxj2z1+6riz8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d02OepCGBWcFM62OTGyF8yf1vKbGux3mNQ2jmrhRvX0ZWTZmBMX8u6dDbG7FIUhx2Uov4uiMAXktU3lU9EeEtl+CitVJ0eLTPseECctIriCXA/Lia22Aq01I2auOehxI+ALWgRWdWZ2t74//9Y7uujrLqNaKW/h1bsLHXqwUsOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=olL1ZK3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2D4C4CEED;
	Sun,  6 Jul 2025 09:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751793212;
	bh=049AuEMm6PalDY7ilexr/Lxx2QoKgjpxj2z1+6riz8k=;
	h=From:To:Cc:Subject:Date:From;
	b=olL1ZK3MioUX9XYwO0YAz8Y6XMW3bfqmbbDJgslBkgPi32mMFdvGBwuJ2OSxOsfmx
	 9+gHf3XDNJ3F2mK9CzcBrY8XU6CgvASO+i0lu5GW/WlQdqwF/rY0vAzP3rKHdIoNO3
	 8hkZhSkOPimRAmqoiL2Gi48Ysg3mUhq68hQjiiaw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.143
Date: Sun,  6 Jul 2025 11:13:23 +0200
Message-ID: <2025070624-outright-rely-d710@gregkh>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.143 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/8250.yaml  |    2 
 Makefile                                            |    2 
 arch/arm/include/asm/ptrace.h                       |    5 
 arch/arm64/mm/mmu.c                                 |    3 
 arch/s390/kernel/entry.S                            |    2 
 arch/um/drivers/ubd_user.c                          |    2 
 arch/um/include/asm/asm-prototypes.h                |    5 
 arch/um/kernel/trap.c                               |  129 +++-
 arch/x86/tools/insn_decoder_test.c                  |    5 
 arch/x86/um/asm/checksum.h                          |    3 
 drivers/dma/xilinx/xilinx_dma.c                     |    2 
 drivers/firmware/arm_scmi/driver.c                  |   44 +
 drivers/firmware/arm_scmi/protocols.h               |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c           |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h           |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c        |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_events.c             |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c  |    2 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c |    3 
 drivers/gpu/drm/bridge/cdns-dsi.c                   |   32 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c               |  109 ++-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c             |    5 
 drivers/gpu/drm/msm/msm_gpu_devfreq.c               |    1 
 drivers/gpu/drm/tegra/dc.c                          |   17 
 drivers/gpu/drm/tegra/hub.c                         |    4 
 drivers/gpu/drm/tegra/hub.h                         |    3 
 drivers/gpu/drm/udl/udl_drv.c                       |    2 
 drivers/hid/hid-lenovo.c                            |   11 
 drivers/hid/wacom_sys.c                             |    6 
 drivers/hv/channel_mgmt.c                           |   15 
 drivers/hv/connection.c                             |  134 +---
 drivers/hv/hv.c                                     |   36 -
 drivers/hv/hv_common.c                              |  231 +++++++
 drivers/hv/hyperv_vmbus.h                           |    7 
 drivers/hv/vmbus_drv.c                              |  206 ------
 drivers/hwmon/pmbus/max34440.c                      |   48 +
 drivers/hwtracing/coresight/coresight-core.c        |    3 
 drivers/hwtracing/coresight/coresight-priv.h        |    2 
 drivers/i2c/busses/i2c-robotfuzz-osif.c             |    6 
 drivers/i2c/busses/i2c-tiny-usb.c                   |    6 
 drivers/iio/adc/ad_sigma_delta.c                    |    4 
 drivers/iio/pressure/zpa2326.c                      |    2 
 drivers/leds/led-class-multicolor.c                 |    3 
 drivers/mailbox/mailbox.c                           |    2 
 drivers/md/bcache/super.c                           |    7 
 drivers/md/dm-raid.c                                |    2 
 drivers/md/md-bitmap.c                              |    2 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h   |    1 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c      |  212 +++---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h      |    6 
 drivers/media/usb/uvc/uvc_ctrl.c                    |   40 -
 drivers/mfd/max14577.c                              |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c       |   26 
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h       |  644 ++------------------
 drivers/net/ethernet/freescale/enetc/enetc_hw.h     |    2 
 drivers/nvme/host/ioctl.c                           |   15 
 drivers/pci/controller/pcie-apple.c                 |    7 
 drivers/s390/crypto/pkey_api.c                      |    2 
 drivers/scsi/megaraid/megaraid_sas_base.c           |    6 
 drivers/staging/rtl8723bs/core/rtw_security.c       |   44 -
 drivers/tty/serial/imx.c                            |   17 
 drivers/tty/serial/uartlite.c                       |   25 
 drivers/tty/vt/vt.c                                 |   12 
 drivers/uio/uio_hv_generic.c                        |   10 
 drivers/usb/class/cdc-wdm.c                         |   23 
 drivers/usb/common/usb-conn-gpio.c                  |   25 
 drivers/usb/core/usb.c                              |   14 
 drivers/usb/dwc2/gadget.c                           |    6 
 drivers/usb/gadget/function/f_tcm.c                 |    4 
 drivers/usb/typec/altmodes/displayport.c            |    4 
 drivers/usb/typec/mux.c                             |    4 
 drivers/video/console/dummycon.c                    |   24 
 drivers/video/console/mdacon.c                      |   21 
 drivers/video/console/newport_con.c                 |   12 
 drivers/video/console/sticon.c                      |   14 
 drivers/video/console/vgacon.c                      |   34 -
 drivers/video/fbdev/core/fbcon.c                    |   40 -
 drivers/video/fbdev/core/fbmem.c                    |   18 
 drivers/video/fbdev/hyperv_fb.c                     |    8 
 fs/btrfs/disk-io.c                                  |    3 
 fs/btrfs/inode.c                                    |   81 +-
 fs/btrfs/volumes.c                                  |    6 
 fs/ceph/file.c                                      |    2 
 fs/f2fs/super.c                                     |   30 
 fs/jfs/jfs_dmap.c                                   |   41 -
 fs/namespace.c                                      |    8 
 fs/nfs/inode.c                                      |    2 
 fs/nfs/nfs4proc.c                                   |   17 
 fs/omfs/file.c                                      |   12 
 fs/omfs/omfs_fs.h                                   |    2 
 fs/overlayfs/util.c                                 |    4 
 fs/smb/client/cifsglob.h                            |    1 
 fs/smb/client/cifspdu.h                             |    6 
 fs/smb/client/cifssmb.c                             |    1 
 fs/smb/client/misc.c                                |    8 
 fs/smb/client/sess.c                                |    1 
 fs/smb/server/smb2pdu.c                             |   62 -
 include/asm-generic/mshyperv.h                      |    2 
 include/linux/console.h                             |   13 
 include/linux/hyperv.h                              |    2 
 include/linux/ipv6.h                                |    1 
 include/uapi/linux/vm_sockets.h                     |    4 
 io_uring/kbuf.c                                     |    2 
 lib/Kconfig.debug                                   |    9 
 lib/Makefile                                        |    2 
 lib/longest_symbol_kunit.c                          |   82 ++
 net/atm/clip.c                                      |   11 
 net/atm/resources.c                                 |    3 
 net/bluetooth/l2cap_core.c                          |    9 
 net/core/selftests.c                                |    5 
 net/ipv6/ip6_output.c                               |    9 
 net/mac80211/util.c                                 |    2 
 net/unix/af_unix.c                                  |   58 -
 net/unix/garbage.c                                  |   24 
 rust/macros/module.rs                               |    1 
 sound/pci/hda/hda_bind.c                            |    2 
 sound/pci/hda/hda_intel.c                           |    3 
 sound/pci/hda/patch_realtek.c                       |    1 
 sound/soc/amd/yc/acp6x-mach.c                       |    7 
 sound/soc/codecs/wcd9335.c                          |   62 -
 sound/usb/quirks.c                                  |    2 
 sound/usb/stream.c                                  |    2 
 tools/lib/bpf/btf_dump.c                            |    3 
 123 files changed, 1594 insertions(+), 1482 deletions(-)

Al Viro (1):
      attach_recursive_mnt(): do not lock the covering tree when sliding something under it

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

Chen Ni (1):
      fbdev: hyperv_fb: Convert comma to semicolon

Chen Yu (1):
      scsi: megaraid_sas: Fix invalid node index

Chen Yufeng (1):
      usb: potential integer overflow in usbg_make_tpg()

Cristian Marussi (1):
      firmware: arm_scmi: Add a common helper to check if a message is supported

Dave Kleikamp (1):
      fs/jfs: consolidate sanity checking in dbMount

Dev Jain (1):
      arm64: Restrict pagetable teardown to avoid false warning

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

Greg Kroah-Hartman (1):
      Linux 6.1.143

Guilherme G. Piccoli (1):
      drivers: hv, hyperv_fb: Untangle and refactor Hyper-V panic notifiers

Gustavo A. R. Silva (1):
      fs: omfs: Use flexible-array member in struct omfs_extent

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

Jakub Kicinski (2):
      net: selftests: fix TCP packet checksum
      eth: bnxt: fix one of the W=1 warnings about fortified memcpy()

Jakub Lewalski (1):
      tty: serial: uartlite: register uart driver in init

James Clark (1):
      coresight: Only check bottom two claim bits

Janne Grunau (1):
      PCI: apple: Set only available ports up

Jason Wang (1):
      media: imx-jpeg: Remove unnecessary memset() after dma_alloc_coherent()

Jay Cornwall (1):
      drm/amdkfd: Fix race in GWS queue scheduling

Jayesh Choudhary (1):
      drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort connector type

Jens Axboe (1):
      nvme: always punt polled uring_cmd end_io work to task_work

Jiri Slaby (SUSE) (5):
      vgacon: switch vgacon_scrolldelta() and vgacon_restore_screen()
      vgacon: remove unneeded forward declarations
      tty: vt: make init parameter of consw::con_init() a bool
      tty: vt: sanitize arguments of consw::con_clear()
      tty: vt: make consw::con_switch() return a bool

John Olender (1):
      drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to total vram

Jonathan Cameron (1):
      iio: pressure: zpa2326: Use aligned_s64 for the timestamp

Joonas Lahtinen (1):
      Revert "drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1"

Jos Wang (1):
      usb: typec: displayport: Receive DP Status Update NAK request exit dp altmode

Kameron Carr (1):
      Drivers: hv: Change hv_free_hyperv_page() to take void * argument

Kees Cook (1):
      ovl: Check for NULL d_inode() in ovl_dentry_upper()

Krzysztof Kozlowski (3):
      mfd: max14577: Fix wakeup source leaks on device unbind
      ASoC: codecs: wcd9335: Handle nicer probe deferral and simplify with dev_err_probe()
      ASoC: codecs: wcd9335: Fix missing free of regulator supplies

Kuniyuki Iwashima (4):
      af_unix: Don't call skb_get() for OOB skb.
      af_unix: Don't leave consecutive consumed OOB skbs.
      af_unix: Don't set -ECONNRESET for consumed OOB skb.
      atm: Release atm_dev_mutex after removing procfs in atm_dev_deregister().

Lachlan Hodges (1):
      wifi: mac80211: fix beacon interval calculation overflow

Linggang Zeng (1):
      bcache: fix NULL pointer in cache_set_flush()

Long Li (3):
      Drivers: hv: move panic report code from vmbus to hv early init code
      Drivers: hv: Allocate interrupt and monitor pages aligned to system page boundary
      uio_hv_generic: Align ring size to system page

Mario Limonciello (1):
      ALSA: usb-audio: Add a quirk for Lenovo Thinkpad Thunderbolt 3 dock

Mark Harmstone (1):
      btrfs: update superblock's device bytes_used when dropping chunk

Maíra Canal (1):
      drm/etnaviv: Protect the scheduler's pending list with its lock

Michael Chan (2):
      bnxt_en: Fix W=1 warning in bnxt_dcb.c from fortify memcpy()
      bnxt_en: Fix W=stringop-overflow warning in bnxt_dcb.c

Michael Grzeschik (2):
      usb: dwc2: also exit clock_gating when stopping udc while suspended
      usb: typec: mux: do not return on EOPNOTSUPP in {mux, switch}_set

Michael Kelley (1):
      Drivers: hv: vmbus: Remove second mapping of VMBus monitor pages

Ming Qian (5):
      media: imx-jpeg: Add a timeout mechanism for each frame
      media: imx-jpeg: Support to assign slot for encoder/decoder
      media: imx-jpeg: Move mxc_jpeg_free_slot_data() ahead
      media: imx-jpeg: Reset slot data pointers when freed
      media: imx-jpeg: Cleanup after an allocation error

Murad Masimov (1):
      fbdev: Fix do_register_framebuffer to prevent null-ptr-deref in fb_videomode_to_var

Namjae Jeon (3):
      ksmbd: allow a filename to contain special characters on SMB3.1.1 posix extension
      ksmbd: Use unsafe_memcpy() for ntlm_negotiate
      ksmbd: remove unsafe_memcpy use in session setup

Nathan Chancellor (2):
      staging: rtl8723bs: Avoid memset() in aes_cipher() and aes_decipher()
      x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c

Olga Kornievskaia (1):
      NFSv4.2: fix listxattr to return selinux security label

Oliver Schramm (1):
      ASoC: amd: yc: Add DMI quirk for Lenovo IdeaPad Slim 5 15

Pali Rohár (2):
      cifs: Correctly set SMB1 SessionKey field in Session Setup Request
      cifs: Fix cifs_query_path_info() for Windows NT servers

Pavel Begunkov (1):
      io_uring/kbuf: account ring io_buffer_list memory

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

Rick Edgecombe (1):
      Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails

Robert Hodaszi (1):
      usb: cdc-wdm: avoid setting WDM_READ for ZLP-s

Salvatore Bonaccorso (1):
      ALSA: hda/realtek: Fix built-in mic on ASUS VivoBook X507UAR

Sami Tolvanen (1):
      um: Add cmpxchg8b_emu and checksum functions to asm-prototypes.h

Saurabh Sengar (2):
      Drivers: hv: vmbus: Add utility function for querying ring size
      uio_hv_generic: Query the ringbuffer size for device

Scott Mayhew (1):
      NFSv4: xattr handlers should check for absent nfs filehandles

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

Thomas Zimmermann (2):
      dummycon: Trigger redraw when switching consoles with deferred takeover
      drm/udl: Unregister device before cleaning up on disconnect

Tiwei Bie (1):
      um: ubd: Add missing error check in start_io_thread()

Vasiliy Kovalev (1):
      jfs: validate AG parameters in dbMount() to prevent crashes

Vijendar Mukunda (1):
      ALSA: hda: Add new pci id for AMD GPU display HD audio controller

Ville Syrjälä (1):
      drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1

Wentao Liang (1):
      drm/amd/display: Add null pointer check for get_first_active_display()

Wolfram Sang (3):
      i2c: tiny-usb: disable zero-length read messages
      i2c: robotfuzz-osif: disable zero-length read messages
      drm/bridge: ti-sn65dsi86: make use of debugfs_init callback

Yao Zi (1):
      dt-bindings: serial: 8250: Make clocks and clock-frequency exclusive

Yifan Zhang (1):
      amd/amdkfd: fix a kfd_process ref leak

Youngjun Lee (1):
      ALSA: usb-audio: Fix out-of-bounds read in snd_usb_get_audioformat_uac3()

Yu Kuai (1):
      md/md-bitmap: fix dm-raid max_write_behind setting

Yuan Chen (1):
      libbpf: Fix null pointer dereference in btf_dump__free on allocation failure

Zhang Zekun (1):
      PCI: apple: Use helper function for_each_child_of_node_scoped()


