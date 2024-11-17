Return-Path: <stable+bounces-93684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C89A9D0439
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 15:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D20428367C
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 14:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACB11D9679;
	Sun, 17 Nov 2024 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wSZdjWfM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C331D8DF8;
	Sun, 17 Nov 2024 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731853108; cv=none; b=gAmDa8aLs47HW3Gwi4qVXzDzkGdPIFuu+iurApBBZ1DOhqW6haMHXD7Jo/m6xjk4HXKAlJo57GOmu7CUOs/IO5DQ1K2HP6Edhzq17D2CsXoCDODNDIRw0bjnXKr5facKXA0XbGTXmatSiQhX7rRHoeevdDFqmizDQfIRGoQILZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731853108; c=relaxed/simple;
	bh=qEgKNUecnjv2PMr5LFlKu/pZ1dI05wYwJ8rTTaLDPmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qMYqoGxL6bV6Cf5iqK0rVGFE5fd+AQk2r2U5f8nc9pI9P2JlMbFwGmaDlpgFjPsEfQt5a3G2rHBRuKJk67RfHegsyagxhTSLswgO8s9R1hTU2DkKFqPCHM/IyJTtdcuExr2vRqfPjMCwNMxOgYiv4cO9GPSWJyYest/eAC+lmL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wSZdjWfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B46C4CECD;
	Sun, 17 Nov 2024 14:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731853106;
	bh=qEgKNUecnjv2PMr5LFlKu/pZ1dI05wYwJ8rTTaLDPmY=;
	h=From:To:Cc:Subject:Date:From;
	b=wSZdjWfM3K6LsDOD23Ane2PVLBbajm9fm/Eu56ti53KKjlyKikt6XvRMd1YnGQoOM
	 9s/P0mCqighvaTSSC/mG+Bxk8JIZRDcH5dZKm8VJm1ZMHbJbpOgIqcViz+NtvYA1dE
	 aT7kT2dwq9T26AkBBqx6XDUgWjkfltgJKCdUzbAc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.286
Date: Sun, 17 Nov 2024 15:17:57 +0100
Message-ID: <2024111758-talisman-unsubtly-0bd8@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.286 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/arm/boot/dts/rk3036-kylin.dts                         |    4 
 arch/arm/boot/dts/rk3036.dtsi                              |   14 -
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                   |    3 
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi              |    1 
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi           |    2 
 arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts |    2 
 arch/powerpc/platforms/powernv/opal-irqchip.c              |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                   |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                |    2 
 drivers/hid/hid-core.c                                     |    2 
 drivers/hid/hid-multitouch.c                               |    5 
 drivers/irqchip/irq-gic-v3.c                               |    7 
 drivers/md/dm-cache-target.c                               |   35 +-
 drivers/md/dm-unstripe.c                                   |    4 
 drivers/md/raid10.c                                        |   23 -
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c              |    3 
 drivers/media/dvb-core/dvb_frontend.c                      |    4 
 drivers/media/dvb-core/dvbdev.c                            |   17 +
 drivers/media/dvb-frontends/cx24116.c                      |    7 
 drivers/media/dvb-frontends/stb0899_algo.c                 |    2 
 drivers/media/i2c/adv7604.c                                |   26 +
 drivers/media/platform/s5p-jpeg/jpeg-core.c                |   17 -
 drivers/media/usb/uvc/uvc_driver.c                         |    2 
 drivers/mtd/nand/raw/nand_base.c                           |   44 +--
 drivers/net/can/c_can/c_can.c                              |    7 
 drivers/net/ethernet/freescale/enetc/enetc_vf.c            |    2 
 drivers/net/ethernet/hisilicon/hns3/hnae3.c                |    5 
 drivers/net/usb/qmi_wwan.c                                 |    1 
 drivers/pwm/pwm-imx-tpm.c                                  |    4 
 drivers/spi/spi.c                                          |   27 --
 drivers/usb/musb/sunxi.c                                   |    2 
 drivers/usb/serial/io_edgeport.c                           |    8 
 drivers/usb/serial/option.c                                |    6 
 drivers/usb/serial/qcserial.c                              |    2 
 fs/btrfs/delayed-ref.c                                     |    2 
 fs/nfs/inode.c                                             |    1 
 fs/nfsd/nfs4xdr.c                                          |   10 
 fs/ocfs2/file.c                                            |    9 
 fs/ocfs2/xattr.c                                           |    3 
 fs/proc/vmcore.c                                           |    9 
 include/linux/mm.h                                         |    2 
 include/linux/mm_types.h                                   |    4 
 include/linux/mtd/rawnand.h                                |    2 
 include/linux/spi/spi.h                                    |    3 
 kernel/bpf/verifier.c                                      |    4 
 kernel/trace/ftrace.c                                      |   30 +-
 mm/memory.c                                                |   73 +++--
 net/9p/client.c                                            |   12 
 net/bridge/br_device.c                                     |    5 
 net/sctp/sm_statefuns.c                                    |    2 
 net/vmw_vsock/hyperv_transport.c                           |    1 
 net/vmw_vsock/virtio_transport_common.c                    |    1 
 security/keys/keyring.c                                    |    7 
 sound/Kconfig                                              |    2 
 sound/firewire/tascam/amdtp-tascam.c                       |    2 
 sound/usb/mixer_quirks.c                                   |  170 +++++++++++++
 57 files changed, 469 insertions(+), 182 deletions(-)

Alessandro Zanni (1):
      fs: Fix uninitialized value issue in from_kuid and from_kgid

Alex Deucher (1):
      drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()

Alex Zhang (1):
      mm/memory.c: make remap_pfn_range() reject unaligned addr

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

Christoph Hellwig (1):
      mm: add remap_pfn_range_notrack

Chuck Lever (1):
      NFSD: Fix NFSv4's PUTPUBFH operation

Dan Carpenter (1):
      USB: serial: io_edgeport: fix use after free in debug printk

Dario Binacchi (1):
      can: c_can: fix {rx,tx}_errors statistics

Diederik de Haas (1):
      arm64: dts: rockchip: Remove hdmi's 2nd interrupt on rk3328

Erik Schumacher (1):
      pwm: imx-tpm: Use correct MODULO value for EPWM mode

Filipe Manana (1):
      btrfs: reinitialize delayed ref list after deleting it from the list

Geert Uytterhoeven (1):
      arm64: dts: rockchip: Fix rt5651 compatible value on rk3399-sapphire-excavator

Greg Kroah-Hartman (1):
      Linux 5.4.286

Heiko Stuebner (6):
      arm64: dts: rockchip: Fix bluetooth properties on Rock960 boards
      arm64: dts: rockchip: Remove #cooling-cells from fan on Theobroma lion
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

Jiri Kosina (1):
      HID: core: zero-initialize the report buffer

Julian Vetter (1):
      sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML

Li Nan (1):
      md/raid10: improve code of mrdev in raid10_sync_request

Linus Torvalds (2):
      9p: fix slab cache name creation for real
      mm: avoid leaving partial pfn mappings around in error case

Marc Zyngier (1):
      irqchip/gic-v3: Force propagation of the active state with a read-back

Mark Brown (1):
      spi: Fix deadlock when adding SPI controllers on SPI buses

Mauro Carvalho Chehab (7):
      media: stb0899_algo: initialize cfr before using it
      media: dvbdev: prevent the risk of out of memory access
      media: dvb_frontend: don't play tricks with underflow values
      media: adv7604: prevent underflow condition when reporting colorspace
      media: s5p-jpeg: prevent buffer overflows
      media: cx24116: prevent overflows on SNR calculus
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

Pedro Falcato (1):
      9p: Avoid creating multiple slab caches with the same name

Peiyang Wang (1):
      net: hns3: fix kernel crash when uninstalling driver

Qi Xi (1):
      fs/proc: fix compile warning about variable 'vmcore_mmap_ops'

Qinglang Miao (1):
      enetc: simplify the return expression of enetc_vf_set_mac_addr()

Reinhard Speyerer (2):
      USB: serial: option: add Fibocom FG132 0x0112 composition
      net: usb: qmi_wwan: add Fibocom FG132 0x0112 composition

Rik van Riel (1):
      bpf: use kvzmalloc to allocate BPF verifier environment

Roberto Sassu (1):
      nfs: Fix KMSAN warning in decode_getfattr_attrs()

Sean Nyekjaer (1):
      mtd: rawnand: protect access to rawnand devices while in suspend

WANG Wenhu (1):
      mm: clarify a confusing comment for remap_pfn_range()

WangYuli (1):
      HID: multitouch: Add quirk for HONOR MagicBook Art 14 touchpad

Wei Fang (1):
      net: enetc: set MAC address to the VF net_device

Xin Long (1):
      sctp: properly validate chunk size in sctp_sf_ootb()

Zheng Yejian (1):
      ftrace: Fix possible use-after-free issue in ftrace_location()

Zichen Xie (1):
      dm-unstriped: cast an operand to sector_t to prevent potential uint32_t overflow

Zijun Hu (1):
      usb: musb: sunxi: Fix accessing an released usb phy

chenqiwu (1):
      mm: fix ambiguous comments for better code readability


