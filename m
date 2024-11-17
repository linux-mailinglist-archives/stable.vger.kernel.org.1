Return-Path: <stable+bounces-93687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 437899D043E
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 15:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D8C1F219F6
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366531D9A6F;
	Sun, 17 Nov 2024 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c4rkI3BB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22321D9A6A;
	Sun, 17 Nov 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731853124; cv=none; b=CFu1TYb3TR+fAz8aTBbDrsrfsR4YylR82zsfHLcTGzfHhJXrhQxWwl/bSxRXP4avpmqToL1Wu/Brqm61UkQrhRrtsjnM3CFcxowpjZ9l2MldGm+WMXoGbDwIJbySEGyx3Vitaw0MRTmtnsE8+ujlyicOskKsGi9uOyzn0ctKc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731853124; c=relaxed/simple;
	bh=EigfuOGw7jjqQDvWSvW8+DMlOhAV1EvWk/S3Kr7eEo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a1rfEPL5oaghVwgUXVic7R3wWdCNiHj1kghxaK7Zin9/yAOcq0p6NQEuJuHiGufnFVGAwD/IFI/Vep5Ar1hG8g8H7UaUbUdpAr6lep/8BcXY1C2lpWFJtac8IuNbBW+6SKP/KS2MUWUD1xYqGmu+sLPlgbGzuf8MGlnaJmncS8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c4rkI3BB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F05C4CECD;
	Sun, 17 Nov 2024 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731853123;
	bh=EigfuOGw7jjqQDvWSvW8+DMlOhAV1EvWk/S3Kr7eEo4=;
	h=From:To:Cc:Subject:Date:From;
	b=c4rkI3BBVy0rDTtFZ46c0pKYAdeOzt3R+t8NnGmqnUrWU2hrvv6MT5jUOVarVX+At
	 qNGfo5MO40KSntBxzjUiUeTkfTBzepfBMCBlvQpVdiu2V9FaYWLP0x7Ilr9wXe2yEl
	 wE4m+z3xupKObPq6dnRNJioLN63vZwYfmsX0ozEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.230
Date: Sun, 17 Nov 2024 15:18:08 +0100
Message-ID: <2024111709-chafe-irrigate-6bcb@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.230 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
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
 arch/powerpc/platforms/powernv/opal-irqchip.c              |    1 
 drivers/crypto/marvell/cesa/hash.c                         |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                   |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                |    2 
 drivers/hid/hid-core.c                                     |    2 
 drivers/hid/hid-multitouch.c                               |    5 
 drivers/irqchip/irq-gic-v3.c                               |    7 
 drivers/md/dm-cache-target.c                               |   35 +-
 drivers/md/dm-unstripe.c                                   |    4 
 drivers/md/raid10.c                                        |   23 -
 drivers/media/cec/usb/pulse8/pulse8-cec.c                  |    2 
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c              |    3 
 drivers/media/dvb-core/dvb_frontend.c                      |    4 
 drivers/media/dvb-core/dvbdev.c                            |   17 +
 drivers/media/dvb-frontends/cx24116.c                      |    7 
 drivers/media/dvb-frontends/stb0899_algo.c                 |    2 
 drivers/media/i2c/adv7604.c                                |   26 +
 drivers/media/platform/s5p-jpeg/jpeg-core.c                |   17 -
 drivers/media/usb/uvc/uvc_driver.c                         |    2 
 drivers/net/can/c_can/c_can.c                              |    7 
 drivers/net/ethernet/arc/emac_main.c                       |   27 +-
 drivers/net/ethernet/freescale/enetc/enetc_vf.c            |    9 
 drivers/net/ethernet/hisilicon/hns3/hnae3.c                |    5 
 drivers/net/phy/dp83640.c                                  |   27 ++
 drivers/net/phy/dp83822.c                                  |   38 ++
 drivers/net/phy/dp83848.c                                  |   35 ++
 drivers/net/phy/dp83867.c                                  |   25 +
 drivers/net/phy/dp83869.c                                  |   25 +
 drivers/net/phy/dp83tc811.c                                |   45 +++
 drivers/net/phy/phy.c                                      |    6 
 drivers/net/usb/qmi_wwan.c                                 |    1 
 drivers/pwm/pwm-imx-tpm.c                                  |    4 
 drivers/scsi/sd_zbc.c                                      |    3 
 drivers/spi/spi.c                                          |   27 --
 drivers/usb/musb/sunxi.c                                   |    2 
 drivers/usb/serial/io_edgeport.c                           |    8 
 drivers/usb/serial/option.c                                |    6 
 drivers/usb/serial/qcserial.c                              |    2 
 drivers/usb/typec/ucsi/ucsi_ccg.c                          |    2 
 drivers/vdpa/ifcvf/ifcvf_base.c                            |    2 
 fs/btrfs/delayed-ref.c                                     |    2 
 fs/nfs/inode.c                                             |    1 
 fs/ocfs2/file.c                                            |    9 
 fs/ocfs2/xattr.c                                           |    3 
 fs/proc/vmcore.c                                           |    9 
 fs/splice.c                                                |    9 
 include/linux/fs.h                                         |   35 ++
 include/linux/phy.h                                        |    2 
 include/linux/spi/spi.h                                    |    3 
 io_uring/io_uring.c                                        |   55 ++--
 kernel/bpf/verifier.c                                      |    4 
 mm/slab_common.c                                           |    2 
 net/9p/client.c                                            |   12 
 net/bridge/br_device.c                                     |    5 
 net/core/dst.c                                             |   17 -
 net/sctp/sm_statefuns.c                                    |    2 
 net/vmw_vsock/hyperv_transport.c                           |    1 
 net/vmw_vsock/virtio_transport_common.c                    |    1 
 security/keys/keyring.c                                    |    7 
 sound/Kconfig                                              |    2 
 sound/firewire/tascam/amdtp-tascam.c                       |    2 
 sound/pci/hda/patch_conexant.c                             |    2 
 sound/soc/stm/stm32_spdifrx.c                              |    2 
 sound/usb/mixer_quirks.c                                   |  170 +++++++++++++
 tools/perf/util/hist.c                                     |   10 
 tools/perf/util/session.c                                  |    5 
 75 files changed, 702 insertions(+), 189 deletions(-)

Alessandro Zanni (1):
      fs: Fix uninitialized value issue in from_kuid and from_kgid

Alex Deucher (1):
      drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()

Amelie Delaunay (1):
      ASoC: stm32: spdifrx: fix dma channel release in stm32_spdifrx_remove

Amir Goldstein (3):
      io_uring: rename kiocb_end_write() local helper
      fs: create kiocb_{start,end}_write() helpers
      io_uring: use kiocb_{start,end}_write() helpers

Andrew Kanner (1):
      ocfs2: remove entry once instead of null-ptr-dereference in ocfs2_xa_remove()

Antonio Quartulli (1):
      drm/amdgpu: prevent NULL pointer dereference if ATIF is not supported

Benoit Sevens (1):
      media: uvcvideo: Skip parsing frames of type UVC_VS_UNDEFINED in uvc_parse_format

Benoît Monin (1):
      USB: serial: option: add Quectel RG650V

Chen Ridong (1):
      security/keys: fix slab-out-of-bounds in key_task_permission

Dan Carpenter (2):
      usb: typec: fix potential out of bounds in ucsi_ccg_update_set_new_cam_cmd()
      USB: serial: io_edgeport: fix use after free in debug printk

Dario Binacchi (1):
      can: c_can: fix {rx,tx}_errors statistics

Diederik de Haas (1):
      arm64: dts: rockchip: Remove hdmi's 2nd interrupt on rk3328

Diogo Silva (1):
      net: phy: ti: add PHY_RST_AFTER_CLK_EN flag

Eric Dumazet (1):
      net: do not delay dst_entries_add() in dst_release()

Erik Schumacher (1):
      pwm: imx-tpm: Use correct MODULO value for EPWM mode

Filipe Manana (1):
      btrfs: reinitialize delayed ref list after deleting it from the list

Geert Uytterhoeven (1):
      arm64: dts: rockchip: Fix rt5651 compatible value on rk3399-sapphire-excavator

Greg Kroah-Hartman (1):
      Linux 5.10.230

Hagar Hemdan (1):
      io_uring: fix possible deadlock in io_register_iowq_max_workers()

Heiko Stuebner (7):
      arm64: dts: rockchip: Fix bluetooth properties on Rock960 boards
      arm64: dts: rockchip: Remove #cooling-cells from fan on Theobroma lion
      arm64: dts: rockchip: Fix LED triggers on rk3308-roc-cc
      ARM: dts: rockchip: fix rk3036 acodec node
      ARM: dts: rockchip: drop grf reference from rk3036 hdmi
      ARM: dts: rockchip: Fix the spi controller on rk3036
      ARM: dts: rockchip: Fix the realtek audio codec on rk3036-kylin

Herbert Xu (1):
      crypto: marvell/cesa - Disable hash algorithms

Hyunwoo Kim (2):
      hv_sock: Initializing vsk->trans to NULL to prevent a dangling pointer
      vsock/virtio: Initialization of the dangling pointer occurring in vsk->trans

Ioana Ciornei (3):
      net: phy: export phy_error and phy_trigger_machine
      net: phy: ti: implement generic .handle_interrupt() callback
      net: phy: ti: take into account all possible interrupt sources

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

Julian Vetter (1):
      sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML

Li Nan (1):
      md/raid10: improve code of mrdev in raid10_sync_request

Linus Torvalds (1):
      9p: fix slab cache name creation for real

Marc Zyngier (1):
      irqchip/gic-v3: Force propagation of the active state with a read-back

Mark Brown (1):
      spi: Fix deadlock when adding SPI controllers on SPI buses

Mauro Carvalho Chehab (8):
      media: stb0899_algo: initialize cfr before using it
      media: dvbdev: prevent the risk of out of memory access
      media: dvb_frontend: don't play tricks with underflow values
      media: adv7604: prevent underflow condition when reporting colorspace
      media: s5p-jpeg: prevent buffer overflows
      media: cx24116: prevent overflows on SNR calculus
      media: pulse8-cec: fix data timestamp at pulse8_setup()
      media: v4l2-tpg: prevent the risk of a division by zero

Michael Ellerman (1):
      powerpc/powernv: Free name on error in opal_event_init()

Michael Walle (1):
      spi: fix use-after-free of the add_lock mutex

Ming-Hung Tsai (4):
      dm cache: correct the number of origin blocks to match the target length
      dm cache: fix out-of-bounds access to the dirty bitset when resizing
      dm cache: optimize dirty bit checking with find_next_bit when resizing
      dm cache: fix potential out-of-bounds access on the first resume

Murad Masimov (1):
      ALSA: firewire-lib: fix return value on fail in amdtp_tscm_init()

Nikolay Aleksandrov (1):
      net: bridge: xmit: make sure we have at least eth header len bytes

Pavel Begunkov (1):
      splice: don't generate zero-len segement bvecs

Pedro Falcato (1):
      9p: Avoid creating multiple slab caches with the same name

Peiyang Wang (1):
      net: hns3: fix kernel crash when uninstalling driver

Peng Fan (1):
      arm64: dts: imx8mp: correct sdhc ipg clk

Qi Xi (1):
      fs/proc: fix compile warning about variable 'vmcore_mmap_ops'

Qun-Wei Lin (1):
      mm: krealloc: Fix MTE false alarm in __do_krealloc

Reinhard Speyerer (2):
      USB: serial: option: add Fibocom FG132 0x0112 composition
      net: usb: qmi_wwan: add Fibocom FG132 0x0112 composition

Riccardo Mancini (1):
      perf session: Add missing evlist__delete when deleting a session

Rik van Riel (1):
      bpf: use kvzmalloc to allocate BPF verifier environment

Roberto Sassu (1):
      nfs: Fix KMSAN warning in decode_getfattr_attrs()

Shuai Xue (1):
      Revert "perf hist: Add missing puts to hist__account_cycles"

WangYuli (1):
      HID: multitouch: Add quirk for HONOR MagicBook Art 14 touchpad

Wei Fang (1):
      net: enetc: set MAC address to the VF net_device

Xin Long (1):
      sctp: properly validate chunk size in sctp_sf_ootb()

Yuan Can (1):
      vDPA/ifcvf: Fix pci_read_config_byte() return code handling

Zichen Xie (1):
      dm-unstriped: cast an operand to sector_t to prevent potential uint32_t overflow

Zijun Hu (1):
      usb: musb: sunxi: Fix accessing an released usb phy


