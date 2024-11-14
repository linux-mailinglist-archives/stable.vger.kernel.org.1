Return-Path: <stable+bounces-93008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC47B9C8C4A
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 14:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7588828670C
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F53D28E0F;
	Thu, 14 Nov 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rbyNckt5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71411CABA;
	Thu, 14 Nov 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592744; cv=none; b=pN8C4oXvUZEpNfvq6KZb42x8XRJrsdTNgTbEb+npnt8xwNAonlG0llM2fC5+DOnip9J3KZEQsO5iyW8NUeA1nvNt5reIDzk37W542u6L+n8LdVmMcdF9N5kd8UXMitq0rPTGzn5DqyhYpNOb/utrbfJFgslDAOg2DfQUudm/0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592744; c=relaxed/simple;
	bh=Hvd0xyhTjjH3q0FJ9prZB9gvJH3Sr4XaEzXOVUGcp2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EtMgQl5yp2o2iuDMWbKm/TZB+3BsH96vAOKqGwAP5pB9mi+XIfhvIBAXdMjh9N1Lfk6FO11rL/K4xbfr95HfPL3Qagrz6gz5FdM3GNoWcGP92ZSLllX7Jnq6xlfP268/0/R4+NPc6tj9F5F3m2S6kCHSU1KzhWbFZYwc6EtahGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rbyNckt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD54C4CED6;
	Thu, 14 Nov 2024 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731592743;
	bh=Hvd0xyhTjjH3q0FJ9prZB9gvJH3Sr4XaEzXOVUGcp2Y=;
	h=From:To:Cc:Subject:Date:From;
	b=rbyNckt5DytWXuCBruJXzZSQ076QOlcmq0hkVjd4JUwH4H3JSR5VkiNRRbE2alK9o
	 hbYCdxtNpT7XrmrI8cU4DexwzdJnZrkKw6egVjT6/VizI8cozkWe84SJGEjWBPnW6v
	 noDIKsr93WQXkcYb+nIxPjTQzj4xa+tXW2qHgp7Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.172
Date: Thu, 14 Nov 2024 14:58:57 +0100
Message-ID: <2024111458-wheat-worshiper-6e10@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.172 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/arm/boot/dts/rk3036-kylin.dts                         |    4 
 arch/arm/boot/dts/rk3036.dtsi                              |   14 -
 arch/arm64/boot/dts/freescale/imx8mp.dtsi                  |    6 
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts             |    4 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                   |    3 
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi              |    1 
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi           |    2 
 arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts |    2 
 drivers/acpi/prmt.c                                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                   |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                |    8 
 drivers/hid/hid-core.c                                     |    2 
 drivers/irqchip/irq-gic-v3.c                               |    7 
 drivers/md/dm-cache-target.c                               |   35 +-
 drivers/md/dm-unstripe.c                                   |    4 
 drivers/media/cec/usb/pulse8/pulse8-cec.c                  |    2 
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c              |    3 
 drivers/media/dvb-core/dvb_frontend.c                      |    4 
 drivers/media/dvb-core/dvbdev.c                            |   17 +
 drivers/media/dvb-frontends/cx24116.c                      |    7 
 drivers/media/dvb-frontends/stb0899_algo.c                 |    2 
 drivers/media/i2c/adv7604.c                                |   26 +
 drivers/media/platform/s5p-jpeg/jpeg-core.c                |   17 -
 drivers/media/usb/uvc/uvc_driver.c                         |    2 
 drivers/media/v4l2-core/v4l2-ctrls-api.c                   |   17 -
 drivers/net/can/c_can/c_can_main.c                         |    7 
 drivers/net/ethernet/arc/emac_main.c                       |   27 +-
 drivers/net/ethernet/freescale/enetc/enetc_vf.c            |    9 
 drivers/net/ethernet/hisilicon/hns3/hnae3.c                |    5 
 drivers/net/ethernet/intel/i40e/i40e.h                     |    1 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c             |    1 
 drivers/net/ethernet/intel/i40e/i40e_main.c                |   12 
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c          |    2 
 drivers/net/ethernet/intel/ice/ice_fdir.h                  |    3 
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c         |   16 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h         |    1 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c          |    1 
 drivers/net/phy/dp83848.c                                  |    2 
 drivers/pwm/pwm-imx-tpm.c                                  |    4 
 drivers/scsi/sd_zbc.c                                      |    3 
 drivers/thermal/qcom/lmh.c                                 |    7 
 drivers/usb/dwc3/core.c                                    |   25 -
 drivers/usb/musb/sunxi.c                                   |    2 
 drivers/usb/serial/io_edgeport.c                           |    8 
 drivers/usb/serial/option.c                                |    6 
 drivers/usb/serial/qcserial.c                              |    2 
 drivers/usb/typec/ucsi/ucsi_ccg.c                          |    2 
 fs/btrfs/delayed-ref.c                                     |    2 
 fs/nfs/inode.c                                             |  126 ++++++++-
 fs/nfs/nfstrace.h                                          |    1 
 fs/nfs/super.c                                             |   10 
 fs/ocfs2/xattr.c                                           |    3 
 fs/proc/vmcore.c                                           |    9 
 include/linux/fs.h                                         |   36 ++
 include/linux/nfs_fs.h                                     |   47 +++
 include/linux/tick.h                                       |    8 
 io_uring/io_uring.c                                        |   50 ++-
 kernel/fork.c                                              |    2 
 kernel/ucount.c                                            |    3 
 net/bridge/br_device.c                                     |    5 
 net/core/dst.c                                             |   17 -
 net/sctp/sm_statefuns.c                                    |    2 
 net/vmw_vsock/hyperv_transport.c                           |    1 
 net/vmw_vsock/virtio_transport_common.c                    |    1 
 security/keys/keyring.c                                    |    7 
 sound/firewire/tascam/amdtp-tascam.c                       |    2 
 sound/pci/hda/patch_conexant.c                             |    2 
 sound/soc/stm/stm32_spdifrx.c                              |    2 
 sound/usb/mixer.c                                          |    1 
 sound/usb/mixer_quirks.c                                   |  170 +++++++++++++
 sound/usb/quirks.c                                         |    2 
 72 files changed, 673 insertions(+), 179 deletions(-)

Ahmed Zaki (1):
      ice: Add a per-VF limit on number of FDIR filters

Aleksandr Loktionov (1):
      i40e: fix race condition by adding filter's intermediate sync state

Alex Deucher (2):
      drm/amdgpu: Adjust debugfs eviction and IB access permissions
      drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()

Amelie Delaunay (1):
      ASoC: stm32: spdifrx: fix dma channel release in stm32_spdifrx_remove

Amir Goldstein (3):
      io_uring: rename kiocb_end_write() local helper
      fs: create kiocb_{start,end}_write() helpers
      io_uring: use kiocb_{start,end}_write() helpers

Andrei Vagin (1):
      ucounts: fix counter leak in inc_rlimit_get_ucounts()

Andrew Kanner (1):
      ocfs2: remove entry once instead of null-ptr-dereference in ocfs2_xa_remove()

Antonio Quartulli (1):
      drm/amdgpu: prevent NULL pointer dereference if ATIF is not supported

Benjamin Coddington (1):
      NFS: Add a tracepoint to show the results of nfs_set_cache_invalid()

Benjamin Segall (1):
      posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER on clone

Benoit Sevens (1):
      media: uvcvideo: Skip parsing frames of type UVC_VS_UNDEFINED in uvc_parse_format

Benoît Monin (1):
      USB: serial: option: add Quectel RG650V

Chen Ridong (1):
      security/keys: fix slab-out-of-bounds in key_task_permission

Dan Carpenter (3):
      usb: typec: fix potential out of bounds in ucsi_ccg_update_set_new_cam_cmd()
      USB: serial: io_edgeport: fix use after free in debug printk
      ACPI: PRM: Clean up guid type in struct prm_handler_info

Dario Binacchi (1):
      can: c_can: fix {rx,tx}_errors statistics

Diederik de Haas (1):
      arm64: dts: rockchip: Remove hdmi's 2nd interrupt on rk3328

Diogo Silva (1):
      net: phy: ti: add PHY_RST_AFTER_CLK_EN flag

Dmitry Baryshkov (1):
      thermal/drivers/qcom/lmh: Remove false lockdep backtrace

Eric Dumazet (1):
      net: do not delay dst_entries_add() in dst_release()

Erik Schumacher (1):
      pwm: imx-tpm: Use correct MODULO value for EPWM mode

Filipe Manana (1):
      btrfs: reinitialize delayed ref list after deleting it from the list

Geert Uytterhoeven (1):
      arm64: dts: rockchip: Fix rt5651 compatible value on rk3399-sapphire-excavator

Greg Kroah-Hartman (1):
      Linux 5.15.172

Heiko Stuebner (7):
      arm64: dts: rockchip: Fix bluetooth properties on Rock960 boards
      arm64: dts: rockchip: Remove #cooling-cells from fan on Theobroma lion
      arm64: dts: rockchip: Fix LED triggers on rk3308-roc-cc
      ARM: dts: rockchip: fix rk3036 acodec node
      ARM: dts: rockchip: drop grf reference from rk3036 hdmi
      ARM: dts: rockchip: Fix the spi controller on rk3036
      ARM: dts: rockchip: Fix the realtek audio codec on rk3036-kylin

Hyunwoo Kim (2):
      hv_sock: Initializing vsk->trans to NULL to prevent a dangling pointer
      vsock/virtio: Initialization of the dangling pointer occurring in vsk->trans

Jack Wu (1):
      USB: serial: qcserial: add support for Sierra Wireless EM86xx

Jan Schär (3):
      ALSA: usb-audio: Support jack detection on Dell dock
      ALSA: usb-audio: Add quirks for Dell WD19 dock
      ALSA: usb-audio: Add endianness annotations

Jarosław Janik (1):
      Revert "ALSA: hda/conexant: Mute speakers at suspend / shutdown"

Jens Axboe (1):
      io_uring/rw: fix missing NOWAIT check for O_DIRECT start write

Jiri Kosina (1):
      HID: core: zero-initialize the report buffer

Johan Jonker (1):
      net: arc: fix the device for dma_map_single/dma_unmap_single

Johannes Thumshirn (1):
      scsi: sd_zbc: Use kvzalloc() to allocate REPORT ZONES buffer

Marc Zyngier (1):
      irqchip/gic-v3: Force propagation of the active state with a read-back

Mauro Carvalho Chehab (9):
      media: stb0899_algo: initialize cfr before using it
      media: dvbdev: prevent the risk of out of memory access
      media: dvb_frontend: don't play tricks with underflow values
      media: adv7604: prevent underflow condition when reporting colorspace
      media: s5p-jpeg: prevent buffer overflows
      media: cx24116: prevent overflows on SNR calculus
      media: pulse8-cec: fix data timestamp at pulse8_setup()
      media: v4l2-tpg: prevent the risk of a division by zero
      media: v4l2-ctrls-api: fix error handling for v4l2_g_ctrl()

Mike Snitzer (1):
      nfs: avoid i_lock contention in nfs_clear_invalid_mapping

Ming-Hung Tsai (4):
      dm cache: correct the number of origin blocks to match the target length
      dm cache: fix out-of-bounds access to the dirty bitset when resizing
      dm cache: optimize dirty bit checking with find_next_bit when resizing
      dm cache: fix potential out-of-bounds access on the first resume

Murad Masimov (1):
      ALSA: firewire-lib: fix return value on fail in amdtp_tscm_init()

NeilBrown (2):
      NFSv3: only use NFS timeout for MOUNT when protocols are compatible
      NFSv3: handle out-of-order write replies.

Nikolay Aleksandrov (1):
      net: bridge: xmit: make sure we have at least eth header len bytes

Nícolas F. R. A. Prado (1):
      net: stmmac: Fix unbalanced IRQ wake disable warning on single irq case

Peiyang Wang (1):
      net: hns3: fix kernel crash when uninstalling driver

Peng Fan (1):
      arm64: dts: imx8mp: correct sdhc ipg clk

Qi Xi (1):
      fs/proc: fix compile warning about variable 'vmcore_mmap_ops'

Reinhard Speyerer (1):
      USB: serial: option: add Fibocom FG132 0x0112 composition

Roberto Sassu (1):
      nfs: Fix KMSAN warning in decode_getfattr_attrs()

Roger Quadros (1):
      usb: dwc3: fix fault at system suspend if device was already runtime suspended

Takashi Iwai (1):
      ALSA: usb-audio: Add quirk for HP 320 FHD Webcam

Wei Fang (1):
      net: enetc: set MAC address to the VF net_device

Xin Long (1):
      sctp: properly validate chunk size in sctp_sf_ootb()

Zichen Xie (1):
      dm-unstriped: cast an operand to sector_t to prevent potential uint32_t overflow

Zijun Hu (1):
      usb: musb: sunxi: Fix accessing an released usb phy


