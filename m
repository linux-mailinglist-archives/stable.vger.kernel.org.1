Return-Path: <stable+bounces-163277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DCFB09291
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 19:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1CD1892AE4
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A000E2F6FBD;
	Thu, 17 Jul 2025 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="itO5kN+T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8DA93D;
	Thu, 17 Jul 2025 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771816; cv=none; b=ijeSMnM0KzuSFk/do7Tmp0il/aDqRZ9w6x2kk0/+0AQYdGD5JpSsUUPLNPZcBLW0twaXrIhZvzamWsGqDEX1Obru/JsZ13Pe4cXL27kteKBYFK/G4bHoC7IjqxONi7faERyuQPo8cHwt1y4ZmkKOnUxdWS1XoH440C3e3ApAcp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771816; c=relaxed/simple;
	bh=mm9/AsEGXsc5aSrQcNNL6Fr8iE+7w4UEnF1aHQCVVeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pk9Kv+lYGq0Ljr92vT4hHOVxwv3usUwj7UTB+pdkLM76TnyNO7oqsj9p2rsoUSl9ZpiH03UB++TS3GruLBvjlSvMyTf6CS3VpJcfp7aoI7SvmoEPRMB+yLEV0LBYIywDAGVGWlz6itmsvRm+9J/33Y70kOOFUBgI+mk3Vs4gC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=itO5kN+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427A0C4CEE3;
	Thu, 17 Jul 2025 17:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752771815;
	bh=mm9/AsEGXsc5aSrQcNNL6Fr8iE+7w4UEnF1aHQCVVeI=;
	h=From:To:Cc:Subject:Date:From;
	b=itO5kN+T96vzhYp7WihSJIWWdEJnZ84sqYkTSrQT4k1WEqyENAjuVk5vLcNafKzf+
	 aSs+C7rMgoLhOVmw0PrllnSsBZHvkas/OrTxrajxzEaTXVI8hejPPUiNrphsH8huP7
	 O8DdFs9UPlDjshmNpuxdRauWiT6FvDbP31nnrkbw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.296
Date: Thu, 17 Jul 2025 19:03:30 +0200
Message-ID: <2025071731-commute-punisher-1648@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.296 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-driver-ufs          |    2 
 Makefile                                            |    2 
 arch/arm64/mm/mmu.c                                 |    3 
 arch/powerpc/include/uapi/asm/ioctls.h              |    8 
 arch/s390/Makefile                                  |    2 
 arch/s390/purgatory/Makefile                        |    2 
 arch/um/drivers/ubd_user.c                          |    2 
 arch/x86/Kconfig                                    |    2 
 arch/x86/kernel/cpu/mce/amd.c                       |   15 -
 arch/x86/kernel/cpu/mce/core.c                      |    8 
 arch/x86/kernel/cpu/mce/intel.c                     |    1 
 drivers/acpi/acpi_pad.c                             |    7 
 drivers/acpi/acpica/dsmethod.c                      |    7 
 drivers/acpi/battery.c                              |   19 -
 drivers/ata/pata_cs5536.c                           |    2 
 drivers/atm/idt77252.c                              |    5 
 drivers/dma-buf/dma-resv.c                          |    5 
 drivers/dma/xilinx/xilinx_dma.c                     |    2 
 drivers/gpu/drm/bridge/cdns-dsi.c                   |   11 
 drivers/gpu/drm/exynos/exynos7_drm_decon.c          |    4 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c            |   12 
 drivers/gpu/drm/i915/gt/intel_ringbuffer.c          |    3 
 drivers/gpu/drm/i915/selftests/i915_request.c       |   20 -
 drivers/gpu/drm/i915/selftests/mock_request.c       |    2 
 drivers/gpu/drm/tegra/dc.c                          |   12 
 drivers/gpu/drm/tegra/hub.c                         |    4 
 drivers/gpu/drm/tegra/hub.h                         |    3 
 drivers/gpu/drm/v3d/v3d_drv.h                       |    9 
 drivers/gpu/drm/v3d/v3d_gem.c                       |    2 
 drivers/gpu/drm/v3d/v3d_irq.c                       |   36 +-
 drivers/hid/hid-ids.h                               |    5 
 drivers/hid/hid-quirks.c                            |    3 
 drivers/hid/wacom_sys.c                             |    6 
 drivers/i2c/busses/i2c-robotfuzz-osif.c             |    6 
 drivers/i2c/busses/i2c-tiny-usb.c                   |    6 
 drivers/iio/pressure/zpa2326.c                      |    2 
 drivers/infiniband/core/device.c                    |    1 
 drivers/infiniband/core/iwcm.c                      |   38 +-
 drivers/infiniband/core/iwcm.h                      |    2 
 drivers/infiniband/core/uverbs_std_types_counters.c |   17 -
 drivers/infiniband/hw/mlx5/devx.c                   |    2 
 drivers/infiniband/hw/mlx5/main.c                   |   55 ++-
 drivers/input/joystick/xpad.c                       |    5 
 drivers/input/keyboard/atkbd.c                      |    3 
 drivers/mailbox/mailbox.c                           |    2 
 drivers/md/dm-raid.c                                |    2 
 drivers/md/md-bitmap.c                              |    2 
 drivers/md/raid1.c                                  |    1 
 drivers/media/platform/omap3isp/ispccdc.c           |    8 
 drivers/media/platform/omap3isp/ispstat.c           |    6 
 drivers/media/platform/vivid/vivid-vid-cap.c        |    2 
 drivers/media/usb/dvb-usb/cxusb.c                   |   36 +-
 drivers/media/usb/uvc/uvc_ctrl.c                    |   61 +++-
 drivers/mfd/max14577.c                              |    1 
 drivers/misc/vmw_vmci/vmci_host.c                   |    9 
 drivers/mmc/host/mtk-sd.c                           |   39 +-
 drivers/mmc/host/sdhci.c                            |    9 
 drivers/mmc/host/sdhci.h                            |   16 +
 drivers/net/can/m_can/m_can.c                       |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-common.h         |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c           |    9 
 drivers/net/ethernet/amd/xgbe/xgbe.h                |    4 
 drivers/net/ethernet/atheros/atlx/atl1.c            |   78 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c       |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c       |    2 
 drivers/net/ethernet/cisco/enic/enic_main.c         |    4 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c    |   26 +
 drivers/net/ethernet/freescale/enetc/enetc_hw.h     |    2 
 drivers/net/ethernet/sun/niu.c                      |   31 ++
 drivers/net/ethernet/sun/niu.h                      |    4 
 drivers/net/phy/microchip.c                         |    2 
 drivers/net/usb/qmi_wwan.c                          |    1 
 drivers/net/wireless/ath/ath6kl/bmi.c               |    4 
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c        |    6 
 drivers/pinctrl/qcom/pinctrl-msm.c                  |   20 +
 drivers/platform/mellanox/mlxbf-tmfifo.c            |    3 
 drivers/pwm/pwm-mediatek.c                          |   15 -
 drivers/regulator/gpio-regulator.c                  |   19 +
 drivers/scsi/qla4xxx/ql4_os.c                       |    2 
 drivers/scsi/ufs/ufs-sysfs.c                        |    4 
 drivers/spi/spi-fsl-dspi.c                          |   55 ++-
 drivers/staging/rtl8723bs/core/rtw_security.c       |   46 ---
 drivers/tty/serial/uartlite.c                       |   15 -
 drivers/tty/vt/vt.c                                 |    1 
 drivers/usb/class/cdc-wdm.c                         |   23 -
 drivers/usb/core/quirks.c                           |    3 
 drivers/usb/core/usb.c                              |   14 
 drivers/usb/gadget/function/f_tcm.c                 |    4 
 drivers/usb/gadget/function/u_serial.c              |    6 
 drivers/usb/typec/altmodes/displayport.c            |    5 
 fs/btrfs/inode.c                                    |   36 +-
 fs/btrfs/ioctl.c                                    |    3 
 fs/btrfs/tree-log.c                                 |    4 
 fs/ceph/file.c                                      |    2 
 fs/cifs/misc.c                                      |    8 
 fs/jfs/jfs_dmap.c                                   |   41 --
 fs/namespace.c                                      |    8 
 fs/nfs/flexfilelayout/flexfilelayout.c              |  144 +++++++--
 fs/nfs/inode.c                                      |   17 -
 fs/overlayfs/util.c                                 |    4 
 fs/proc/inode.c                                     |   16 -
 fs/proc/proc_sysctl.c                               |   18 -
 include/drm/spsc_queue.h                            |    4 
 include/linux/of.h                                  |  291 +++++++++-----------
 include/linux/regulator/gpio-regulator.h            |    2 
 include/linux/usb/typec_dp.h                        |    1 
 include/rdma/ib_verbs.h                             |    7 
 include/uapi/linux/vm_sockets.h                     |    4 
 init/Kconfig                                        |    4 
 lib/test_objagg.c                                   |    4 
 net/appletalk/ddp.c                                 |    1 
 net/atm/clip.c                                      |   64 +++-
 net/atm/resources.c                                 |    3 
 net/bluetooth/l2cap_core.c                          |    9 
 net/bpfilter/Makefile                               |    5 
 net/ipv6/route.c                                    |    3 
 net/mac80211/rx.c                                   |    4 
 net/mac80211/util.c                                 |    2 
 net/netlink/af_netlink.c                            |   82 +++--
 net/rose/rose_route.c                               |   15 -
 net/rxrpc/call_accept.c                             |    3 
 net/sched/sch_api.c                                 |   42 +-
 net/tipc/topsrv.c                                   |    2 
 net/vmw_vsock/vmci_transport.c                      |    4 
 scripts/Kbuild.include                              |    2 
 scripts/Makefile.host                               |    4 
 scripts/Makefile.lib                                |    8 
 sound/isa/sb/sb16_main.c                            |    4 
 sound/pci/hda/hda_bind.c                            |    2 
 sound/soc/meson/meson-card-utils.c                  |    2 
 sound/usb/stream.c                                  |    2 
 usr/include/Makefile                                |    6 
 132 files changed, 1178 insertions(+), 680 deletions(-)

Al Viro (2):
      attach_recursive_mnt(): do not lock the covering tree when sliding something under it
      fix proc_sys_compare() handling of in-lookup dentries

Alok Tiwari (1):
      enic: fix incorrect MTU comparison in enic_change_mtu()

Andrei Kuchynski (1):
      usb: typec: displayport: Fix potential deadlock

Andy Shevchenko (1):
      usb: Add checks for snprintf() calls in usb_alloc_dev()

Aradhya Bhatia (3):
      drm/bridge: cdns-dsi: Fix the clock variable for mode_valid()
      drm/bridge: cdns-dsi: Fix connecting to next bridge
      drm/bridge: cdns-dsi: Check return value when getting default PHY config

Arnd Bergmann (1):
      kbuild: hdrcheck: fix cross build with clang

Bart Van Assche (1):
      scsi: ufs: core: Fix spelling of a sysfs attribute name

Bartosz Golaszewski (1):
      pinctrl: qcom: msm: mark certain pins as invalid for interrupts

Cezary Rojewski (1):
      ALSA: hda: Ignore unsol events for cards being shut down

Chen Yufeng (1):
      usb: potential integer overflow in usbg_make_tpg()

Chia-Lin Kao (AceLan) (1):
      HID: quirks: Add quirk for 2 Chicony Electronics HP 5MP Cameras

Christian König (1):
      dma-buf: fix timeout handling in dma_resv_wait_timeout v2

Dan Carpenter (2):
      lib: test_objagg: Set error message in check_expect_hints_stats()
      drm/i915/selftests: Change mock_request() to return error pointers

Daniil Dulov (1):
      wifi: zd1211rw: Fix potential NULL pointer dereference in zd_mac_tx_to_dev()

Dave Kleikamp (1):
      fs/jfs: consolidate sanity checking in dbMount

David Howells (1):
      rxrpc: Fix oops due to non-existence of prealloc backlog struct

David Thompson (1):
      platform/mellanox: mlxbf-tmfifo: fix vring_desc.len assignment

Denis Arefev (1):
      media: vivid: Change the siize of the composing

Dev Jain (1):
      arm64: Restrict pagetable teardown to avoid false warning

Dmitry Kandybka (1):
      ceph: fix possible integer overflow in ceph_zero_objects()

Edward Adam Davis (1):
      media: cxusb: no longer judge rbuf when the write fails

Eric W. Biederman (1):
      proc: Clear the pieces of proc_inode that proc_evict_inode cares about

Filipe Manana (3):
      btrfs: fix missing error handling when searching for inode refs during log replay
      btrfs: propagate last_unlink_trans earlier when doing a rmdir
      btrfs: use btrfs_record_snapshot_destroy() during rmdir

Frédéric Danis (1):
      Bluetooth: L2CAP: Fix L2CAP MTU negotiation

Fushuai Wang (1):
      dpaa2-eth: fix xdp_rxq_info leak

Georg Kohmann (1):
      net: ipv6: Discard next-hop MTU less than minimum link MTU

George Kennedy (1):
      VMCI: check context->notify_page after call to get_user_pages_fast() to avoid GPF

Greg Kroah-Hartman (1):
      Linux 5.4.296

Gustavo A. R. Silva (1):
      net: rose: Fix fall-through warnings for Clang

Hans de Goede (1):
      Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID

HarshaVardhana S A (1):
      vsock/vmci: Clear the vmci transport packet properly when initializing it

Heinz Mauelshagen (1):
      dm-raid: fix variable in journal device check

JP Kobryn (1):
      x86/mce: Make sure CMCI banks are cleared during shutdown on Intel

Jakub Kicinski (1):
      netlink: make sure we allow at least one dump skb

Jakub Lewalski (1):
      tty: serial: uartlite: register uart driver in init

James Clark (1):
      spi: spi-fsl-dspi: Clear completion counter before initiating transfer

Jann Horn (1):
      x86/mm: Disable hugetlb page table sharing on 32-bit

Janusz Krzysztofik (1):
      drm/i915/gt: Fix timeline left held on VMA alloc error

Jerome Neanne (1):
      regulator: gpio: Add input_supply support in gpio_regulator_config

Johannes Berg (3):
      ata: pata_cs5536: fix build on 32-bit UML
      wifi: mac80211: drop invalid source address OCB frames
      wifi: ath6kl: remove WARN on bad firmware input

Jonathan Cameron (1):
      iio: pressure: zpa2326: Use aligned_s64 for the timestamp

Jos Wang (1):
      usb: typec: displayport: Receive DP Status Update NAK request exit dp altmode

Kaustabh Chakraborty (1):
      drm/exynos: exynos7_drm_decon: add vblank check in IRQ handling

Kees Cook (1):
      ovl: Check for NULL d_inode() in ovl_dentry_upper()

Kito Xu (1):
      net: appletalk: Fix device refcount leak in atrtr_create()

Kohei Enju (1):
      rose: fix dangling neighbour pointers in rose_rt_device_down()

Krzysztof Kozlowski (1):
      mfd: max14577: Fix wakeup source leaks on device unbind

Kuen-Han Tsai (1):
      usb: gadget: u_serial: Fix race condition in TTY wakeup

Kuniyuki Iwashima (8):
      atm: Release atm_dev_mutex after removing procfs in atm_dev_deregister().
      nfs: Clean up /proc/net/rpc/nfs when nfs_fs_proc_net_init() fails.
      netlink: Fix wraparounds of sk->sk_rmem_alloc.
      tipc: Fix use-after-free in tipc_conn_close().
      atm: clip: Fix potential null-ptr-deref in to_atmarpd().
      atm: clip: Fix memory leak of struct clip_vcc.
      atm: clip: Fix infinite recursive call of clip_push().
      netlink: Fix rmem check in netlink_broadcast_deliver().

Lachlan Hodges (1):
      wifi: mac80211: fix beacon interval calculation overflow

Leon Romanovsky (1):
      RDMA/core: Create and destroy counters in the ib_core

Lion Ackermann (1):
      net/sched: Always pass notifications when child class becomes empty

Madhavan Srinivasan (1):
      powerpc: Fix struct termio related ioctl macros

Manivannan Sadhasivam (1):
      regulator: gpio: Fix the out-of-bounds access to drvdata::gpiods

Marek Szyprowski (2):
      media: omap3isp: use sgtable-based scatterlist wrappers
      drm/exynos: fimd: Guard display clock control with runtime PM calls

Mark Zhang (1):
      RDMA/mlx5: Initialize obj_event->obj_sub_list before xa_insert

Martin Blumenstingl (1):
      ASoC: meson: meson-card-utils: use of_property_present() for DT parsing

Masahiro Yamada (3):
      kbuild: use -MMD instead of -MD to exclude system headers from dependency
      bpfilter: match bit size of bpfilter_umh to that of the kernel
      kbuild: add --target to correctly cross-compile UAPI headers with Clang

Masami Hiramatsu (Google) (2):
      mtk-sd: Fix a pagefault in dma_unmap_sg() for not prepared data
      mtk-sd: Prevent memory corruption from DMA map failure

Matt Reynolds (1):
      Input: xpad - add support for Amazon Game Controller

Matthew Brost (1):
      drm/sched: Increment job count before swapping tail spsc queue

Maíra Canal (1):
      drm/v3d: Disable interrupts before resetting the GPU

Michael Walle (1):
      of: property: define of_property_read_u{8,16,32,64}_array() unconditionally

Nathan Chancellor (2):
      s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS
      staging: rtl8723bs: Avoid memset() in aes_cipher() and aes_decipher()

Nicolas Pitre (1):
      vt: add missing notification when switching back to text mode

Nilton Perim Neto (1):
      Input: xpad - support Acer NGR 200 Controller

Oleksij Rempel (1):
      net: phy: microchip: limit 100M workaround to link-down events on LAN88xx

Oliver Neukum (1):
      Logitech C-270 even more broken

Omar Sandoval (1):
      btrfs: don't abort filesystem when attempting to snapshot deleted subvolume

Pali Rohár (1):
      cifs: Fix cifs_query_path_info() for Windows NT servers

Patrisious Haddad (2):
      RDMA/mlx5: Fix CC counters query for MPV
      RDMA/mlx5: Fix vport loopback for MPV device

Peng Fan (1):
      mailbox: Not protect module_put with spin_lock_irqsave

Qasim Ijaz (3):
      HID: wacom: fix memory leak on kobject creation failure
      HID: wacom: fix memory leak on sysfs attribute creation failure
      HID: wacom: fix kobject reference count leak

RD Babiera (1):
      usb: typec: altmodes/displayport: do not index invalid pin_assignments

Rafael J. Wysocki (2):
      ACPICA: Refuse to evaluate a method if arguments are missing
      Revert "ACPI: battery: negate current when discharging"

Raju Rangoju (1):
      amd-xgbe: align CL37 AN sequence as per databook

Ricardo Ribalda (3):
      media: uvcvideo: Return the number of processed controls
      media: uvcvideo: Send control events for partial succeeds
      media: uvcvideo: Rollback non processed entities on error

Rob Herring (1):
      of: Add of_property_present() helper

Robert Hodaszi (1):
      usb: cdc-wdm: avoid setting WDM_READ for ZLP-s

Sean Nyekjaer (1):
      can: m_can: m_can_handle_lost_msg(): downgrade msg lost in rx message to debug level

Sean Young (1):
      media: cxusb: use dev_dbg() rather than hand-rolled debug

Seiji Nishikawa (1):
      ACPI: PAD: fix crash in exit_round_robin()

Sergey Senozhatsky (1):
      mtk-sd: reset host->mrq on prepare_data() error

Shin'ichiro Kawasaki (1):
      RDMA/iwcm: Fix use-after-free of work objects after cm_id destruction

Shravya KN (1):
      bnxt_en: Fix DCB ETS validation

Simon Horman (1):
      net: enetc: Correct endianness handling in _enetc_rd_reg64

Somnath Kotur (1):
      bnxt_en: Set DMA unmap len correctly for XDP_REDIRECT

Stefano Garzarella (1):
      vsock/uapi: fix linux/vm_sockets.h userspace compilation errors

Takashi Iwai (1):
      ALSA: sb: Force to disable DMAs once when DMA mode is changed

Thierry Reding (1):
      drm/tegra: Assign plane type before registration

Thomas Fourier (4):
      scsi: qla4xxx: Fix missing DMA mapping error in qla4xxx_alloc_pdu()
      nui: Fix dma_mapping_error() check
      ethernet: atl1: Add missing DMA mapping error checks and count errors
      atm: idt77252: Add missing `dma_map_error()`

Thomas Gessler (1):
      dmaengine: xilinx_dma: Set dma_device directions

Tigran Mkrtchyan (1):
      flexfiles/pNFS: update stats on NFS4ERR_DELAY for v4.1 DSes

Tiwei Bie (1):
      um: ubd: Add missing error check in start_io_thread()

Trond Myklebust (1):
      NFSv4/flexfiles: Fix handling of NFS level errors in I/O

Ulf Hansson (1):
      Revert "mmc: sdhci: Disable SD card clock before changing parameters"

Uwe Kleine-König (1):
      pwm: mediatek: Ensure to disable clocks in error path

Vasiliy Kovalev (1):
      jfs: validate AG parameters in dbMount() to prevent crashes

Vicki Pfau (1):
      Input: xpad - add VID for Turtle Beach controllers

Victor Nogueira (1):
      net/sched: Abort __tc_modify_qdisc if parent class does not exist

Victor Shih (1):
      mmc: sdhci: Add a helper function for dump register in dynamic debug mode

Vladimir Oltean (2):
      spi: spi-fsl-dspi: Rename fifo_{read,write} and {tx,cmd}_fifo_write
      spi: spi-fsl-dspi: Fix interrupt-less DMA mode taking an XSPI code path

Wang Jinchao (1):
      md/raid1: Fix stack memory use after return in raid1_reshape

Weihang Li (1):
      RDMA/core: Use refcount_t instead of atomic_t on refcount of iwcm_id_private

Wolfram Sang (2):
      i2c: tiny-usb: disable zero-length read messages
      i2c: robotfuzz-osif: disable zero-length read messages

Wupeng Ma (1):
      VMCI: fix race between vmci_host_setup_notify and vmci_ctx_unset_notify

Xiaowei Li (1):
      net: usb: qmi_wwan: add SIMCom 8230C composition

Yazen Ghannam (2):
      x86/mce/amd: Fix threshold limit reset
      x86/mce: Don't remove sysfs if thresholding sysfs init fails

Youngjun Lee (1):
      ALSA: usb-audio: Fix out-of-bounds read in snd_usb_get_audioformat_uac3()

Yu Kuai (1):
      md/md-bitmap: fix dm-raid max_write_behind setting

Yue Haibing (1):
      atm: clip: Fix NULL pointer dereference in vcc_sendmsg()

Yue Hu (1):
      mmc: mediatek: use data instead of mrq parameter from msdc_{un}prepare_data()

Zhang Heng (1):
      HID: Add IGNORE quirk for SMARTLINKTECHNOLOGY


