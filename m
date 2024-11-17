Return-Path: <stable+bounces-93682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC9F9D0435
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 15:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFCF282DC2
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 14:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2941D89EF;
	Sun, 17 Nov 2024 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AUYsJsKz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9EF1D1E78;
	Sun, 17 Nov 2024 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731853097; cv=none; b=Ef1u+kA/oA/i1rn2Py4iM/NNRA3s9LI8RM8zEHvP4YeI8QP7jMUepngDZ8z7XgQP8X+zicWPOUHcj8LU7WvtD8zeBiKy3HeiiamhTXIj+VqgM3HEeHsRSF9ujpOXHEN7gsBBARdgeAulfqS3uY2zT1jmpb5FVOO/5RuhZo5JW44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731853097; c=relaxed/simple;
	bh=AgHS4S/NYhClSpMV7o8g/+hZ/L5iGGCSbdH/6v/FWvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GkREU9Eu+orFk88nzz5WzLyP7dS9BZ8BwavcKLd2muZlpXqj44ZFWETDG8M6JyGqUs/JtQ8LZHNWFVh6zXUxeT74sajdvD0xosUG0dEmsMklZUtQEzrI4uJOd/UjpvLGrPdkfyGrrG63vZUNlsMIHrJJSXFm5exa9PiZ1NhqX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AUYsJsKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D76C4CED7;
	Sun, 17 Nov 2024 14:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731853096;
	bh=AgHS4S/NYhClSpMV7o8g/+hZ/L5iGGCSbdH/6v/FWvk=;
	h=From:To:Cc:Subject:Date:From;
	b=AUYsJsKz/KGrfkC5jGzlnZxeLrr/8iyfNVfBuQ49K6q+GvxYklQKLNLbJK6JZ14U9
	 ch/BFPQwKewINhRxN4zxS3g9jDa03c5wSXrekrfXfkpwDg1deplclz/TD/Kp9XTq8+
	 4gpgTxb1ojjwy3a+zgmT57Zm6vJffUGHqqvAYAIc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.324
Date: Sun, 17 Nov 2024 15:17:51 +0100
Message-ID: <2024111751-reclusive-perennial-7b59@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.324 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/arm/boot/dts/rk3036-kylin.dts                         |    4 
 arch/arm/boot/dts/rk3036.dtsi                              |    8 
 arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts |    2 
 arch/powerpc/platforms/powernv/opal-irqchip.c              |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                   |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                |    2 
 drivers/hid/hid-core.c                                     |    2 
 drivers/hid/hid-multitouch.c                               |    5 
 drivers/irqchip/irq-gic-v3.c                               |    7 
 drivers/md/dm-cache-target.c                               |   35 
 drivers/md/dm-unstripe.c                                   |    4 
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c              |    3 
 drivers/media/dvb-core/dvb_frontend.c                      |    4 
 drivers/media/dvb-core/dvbdev.c                            |   17 
 drivers/media/dvb-frontends/cx24116.c                      |    7 
 drivers/media/dvb-frontends/stb0899_algo.c                 |    2 
 drivers/media/i2c/adv7604.c                                |   26 
 drivers/media/platform/s5p-jpeg/jpeg-core.c                |   17 
 drivers/media/usb/uvc/uvc_driver.c                         |    2 
 drivers/net/can/c_can/c_can.c                              |    7 
 drivers/net/ethernet/hisilicon/hns3/hnae3.c                |    5 
 drivers/net/usb/qmi_wwan.c                                 |    1 
 drivers/usb/musb/sunxi.c                                   |    2 
 drivers/usb/serial/io_edgeport.c                           |    8 
 drivers/usb/serial/option.c                                |    6 
 drivers/usb/serial/qcserial.c                              |    2 
 fs/btrfs/delayed-ref.c                                     |    2 
 fs/nfs/inode.c                                             |    1 
 fs/ocfs2/file.c                                            |    9 
 fs/ocfs2/xattr.c                                           |    3 
 fs/proc/vmcore.c                                           |    9 
 include/net/bond_alb.h                                     |    4 
 kernel/bpf/verifier.c                                      |    4 
 net/9p/client.c                                            |   12 
 net/bridge/br_device.c                                     |    5 
 net/sctp/sm_statefuns.c                                    |    2 
 net/vmw_vsock/hyperv_transport.c                           |    1 
 net/vmw_vsock/virtio_transport_common.c                    |    1 
 security/keys/keyring.c                                    |    7 
 sound/Kconfig                                              |    2 
 sound/core/pcm_lib.c                                       |   13 
 sound/firewire/tascam/amdtp-tascam.c                       |    2 
 sound/usb/mixer_quirks.c                                   |  551 +++++++++++++
 44 files changed, 725 insertions(+), 88 deletions(-)

Alessandro Zanni (1):
      fs: Fix uninitialized value issue in from_kuid and from_kgid

Alex Deucher (1):
      drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()

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

Dan Carpenter (1):
      USB: serial: io_edgeport: fix use after free in debug printk

Dario Binacchi (1):
      can: c_can: fix {rx,tx}_errors statistics

Filipe Manana (1):
      btrfs: reinitialize delayed ref list after deleting it from the list

Geert Uytterhoeven (1):
      arm64: dts: rockchip: Fix rt5651 compatible value on rk3399-sapphire-excavator

Greg Kroah-Hartman (1):
      Linux 4.19.324

Heiko Stuebner (3):
      ARM: dts: rockchip: fix rk3036 acodec node
      ARM: dts: rockchip: drop grf reference from rk3036 hdmi
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

Jiri Slaby (SUSE) (1):
      bonding (gcc13): synchronize bond_{a,t}lb_xmit() types

Julian Vetter (1):
      sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML

Jussi Laako (1):
      ALSA: usb-audio: Add custom mixer status quirks for RME CC devices

Linus Torvalds (1):
      9p: fix slab cache name creation for real

Marc Zyngier (1):
      irqchip/gic-v3: Force propagation of the active state with a read-back

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

Reinhard Speyerer (2):
      USB: serial: option: add Fibocom FG132 0x0112 composition
      net: usb: qmi_wwan: add Fibocom FG132 0x0112 composition

Ricardo Biehl Pasquali (1):
      ALSA: pcm: Return 0 when size < start_threshold in capture

Rik van Riel (1):
      bpf: use kvzmalloc to allocate BPF verifier environment

Roberto Sassu (1):
      nfs: Fix KMSAN warning in decode_getfattr_attrs()

WangYuli (1):
      HID: multitouch: Add quirk for HONOR MagicBook Art 14 touchpad

Xin Long (1):
      sctp: properly validate chunk size in sctp_sf_ootb()

Zichen Xie (1):
      dm-unstriped: cast an operand to sector_t to prevent potential uint32_t overflow

Zijun Hu (1):
      usb: musb: sunxi: Fix accessing an released usb phy


