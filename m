Return-Path: <stable+bounces-60536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD76934C31
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 13:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09471C20DBD
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 11:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133D6135A79;
	Thu, 18 Jul 2024 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wT9O5zR+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B284A13213A;
	Thu, 18 Jul 2024 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300695; cv=none; b=W4Wu6rz3J7xX/uVYYjRaIWi7sOgalUOL2HRf9eph2p0uUEGMAKh8c31pPM7pa12vOEHB0GXR8jCRlsY86byB+WuozD9dMr9WnkEhkgnDhHC92EztQBMx+YyYQurlorLJb+oW0bT+Jgk0JhJLg47z/H2nsEZ/gc4LYFPa4DVGZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300695; c=relaxed/simple;
	bh=gsM8j3whUT6lFbAQHtP3P+13hvj3vxEF89622RWLD70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sup/AKBsGIxGL3UHXLXhD9lDQosukQ7ho6ZD5Hvor2Iw1HMgWIqp2ioP5YgWiETFKKoUHRgHWyji8wQSC46RcFP/n8jXrOd2F3wK9tUjUnu4OytRCiuYOJZktAhqZNxcjHEMEqSCfJKVBzP8YS4S7S7NB2927OJuZsEeQuwwDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wT9O5zR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56BEC116B1;
	Thu, 18 Jul 2024 11:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721300695;
	bh=gsM8j3whUT6lFbAQHtP3P+13hvj3vxEF89622RWLD70=;
	h=From:To:Cc:Subject:Date:From;
	b=wT9O5zR+pmXCF1+K0xYdl/HCF2wj/S9yW6+6inKcbxSXpLUNFyBZ/NFhu5UL3h2yi
	 h7P+o3Df0jbiHWCbN6QFM0FpoDH7Db2TEjxfV8MUCwXUs4D7z+k0P/1ucOjkHr0j39
	 AmETdR6HLBlLyDt96XvhdhSpnfe2Bw5cXnfUTKMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.280
Date: Thu, 18 Jul 2024 13:04:35 +0200
Message-ID: <2024071836-giddy-level-0a25@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.280 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 
 arch/arm/mach-davinci/pm.c                        |    2 
 arch/powerpc/include/asm/io.h                     |    2 
 arch/powerpc/xmon/xmon.c                          |    6 -
 arch/s390/include/asm/processor.h                 |    2 
 drivers/char/hpet.c                               |   34 +++++-
 drivers/firmware/dmi_scan.c                       |   11 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c           |    8 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c |    3 
 drivers/gpu/drm/amd/include/atomfirmware.h        |    2 
 drivers/gpu/drm/lima/lima_gp.c                    |    2 
 drivers/gpu/drm/lima/lima_mmu.c                   |    5 
 drivers/gpu/drm/lima/lima_pp.c                    |    4 
 drivers/gpu/drm/nouveau/nouveau_connector.c       |    3 
 drivers/i2c/busses/i2c-i801.c                     |    2 
 drivers/i2c/busses/i2c-pnx.c                      |   48 +-------
 drivers/i2c/busses/i2c-rcar.c                     |   17 ++-
 drivers/infiniband/core/user_mad.c                |   21 ++-
 drivers/input/ff-core.c                           |    7 -
 drivers/media/dvb-frontends/as102_fe_types.h      |    2 
 drivers/media/dvb-frontends/tda10048.c            |    9 +
 drivers/media/dvb-frontends/tda18271c2dd.c        |    4 
 drivers/media/usb/dvb-usb/dib0700_devices.c       |   18 ++-
 drivers/media/usb/dvb-usb/dw2102.c                |  120 +++++++++++++---------
 drivers/media/usb/s2255/s2255drv.c                |   20 +--
 drivers/net/bonding/bond_options.c                |    6 -
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  |    1 
 drivers/net/dsa/mv88e6xxx/chip.c                  |    4 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h       |    2 
 drivers/net/ethernet/lantiq_etop.c                |    5 
 drivers/net/ethernet/marvell/octeontx2/af/npc.h   |    8 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c   |    2 
 drivers/net/ppp/ppp_generic.c                     |   15 ++
 drivers/nvme/host/multipath.c                     |    2 
 drivers/nvmem/meson-efuse.c                       |   14 +-
 drivers/s390/crypto/pkey_api.c                    |    4 
 drivers/scsi/qedf/qedf_io.c                       |    6 -
 drivers/staging/wilc1000/wilc_hif.c               |    3 
 drivers/usb/core/config.c                         |   18 ++-
 drivers/usb/core/quirks.c                         |    3 
 drivers/usb/gadget/configfs.c                     |    3 
 drivers/usb/serial/option.c                       |   38 ++++++
 fs/dcache.c                                       |   12 +-
 fs/jffs2/super.c                                  |    1 
 fs/locks.c                                        |    2 
 fs/nilfs2/alloc.c                                 |   18 ++-
 fs/nilfs2/alloc.h                                 |    4 
 fs/nilfs2/dat.c                                   |    2 
 fs/nilfs2/dir.c                                   |   38 ++++++
 fs/nilfs2/ifile.c                                 |    7 -
 fs/nilfs2/nilfs.h                                 |   10 +
 fs/nilfs2/the_nilfs.c                             |    6 +
 fs/nilfs2/the_nilfs.h                             |    2 
 fs/orangefs/super.c                               |    3 
 include/linux/compiler_attributes.h               |   12 ++
 include/linux/fsnotify.h                          |    8 +
 include/linux/sunrpc/clnt.h                       |    1 
 include/linux/tcp.h                               |    2 
 include/uapi/linux/tcp.h                          |   10 +
 kernel/exit.c                                     |    2 
 mm/page-writeback.c                               |    2 
 net/ceph/mon_client.c                             |   14 ++
 net/ipv4/inet_diag.c                              |    2 
 net/ipv4/tcp.c                                    |    2 
 net/ipv4/tcp_fastopen.c                           |    5 
 net/ipv4/tcp_input.c                              |  112 ++++++++++----------
 net/ipv4/tcp_metrics.c                            |    1 
 net/ipv4/tcp_timer.c                              |   45 +++++++-
 net/ipv4/udp.c                                    |    4 
 net/sctp/socket.c                                 |    7 -
 net/sunrpc/clnt.c                                 |    5 
 sound/pci/hda/patch_realtek.c                     |   11 ++
 tools/testing/selftests/net/msg_zerocopy.c        |   14 ++
 73 files changed, 601 insertions(+), 251 deletions(-)

Alan Stern (1):
      USB: core: Fix duplicate endpoint bug by clearing reserved bits in the descriptor

Aleksander Jan Bajkowski (2):
      net: lantiq_etop: add blank line after declaration
      net: ethernet: lantiq_etop: fix double free in detach

Aleksandr Mishin (1):
      octeontx2-af: Fix incorrect value output on error path in rvu_check_rsrc_availability()

Alex Deucher (1):
      drm/amdgpu/atomfirmware: silence UBSAN warning

Alex Hung (1):
      drm/amd/display: Skip finding free audio for unknown engine_id

Bjørn Mork (1):
      USB: serial: option: add Fibocom FM350-GL

Brian Foster (1):
      vfs: don't mod negative dentry count when on shrinker list

Chen Ni (1):
      ARM: davinci: Convert comma to semicolon

Daniele Palmas (2):
      USB: serial: option: add Telit generic core-dump composition
      USB: serial: option: add Telit FN912 rmnet compositions

Dmitry Antipov (1):
      ppp: reject claimed-as-LCP but actually malformed packets

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on VAIO PRO PX

Eric Dumazet (3):
      tcp: refactor tcp_retransmit_timer()
      tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()
      tcp: avoid too many retransmit packets

Erick Archer (2):
      sctp: prefer struct_size over open coded arithmetic
      Input: ff-core - prefer struct_size over open coded arithmetic

Erico Nunes (1):
      drm/lima: fix shared irq handling on driver remove

Ghadi Elie Rahme (1):
      bnx2x: Fix multiple UBSAN array-index-out-of-bounds

Greg Kroah-Hartman (1):
      Linux 5.4.280

Greg Kurz (1):
      powerpc/xmon: Check cpu id in commands "c#", "dp#" and "dx#"

He Zhe (1):
      hpet: Support 32-bit userspace

Heiko Carstens (1):
      Compiler Attributes: Add __uninitialized macro

Heiner Kallweit (1):
      i2c: i801: Annotate apanel_addr as __ro_after_init

Holger Dengler (1):
      s390/pkey: Wipe sensitive data on failure

Ilya Dryomov (1):
      libceph: fix race between delayed_work() and ceph_monc_stop()

Jakub Kicinski (1):
      tcp_metrics: validate source addr length

Jan Kara (2):
      fsnotify: Do not generate events for O_PATH file descriptors
      Revert "mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again"

Jason Baron (1):
      tcp: add TCP_INFO status for failed client TFO

Jean Delvare (1):
      firmware: dmi: Stop decoding on broken entry

Jeff Layton (1):
      filelock: fix potential use-after-free in posix_lock_inode

Jian-Hong Pan (1):
      ALSA: hda/realtek: Enable headset mic of JP-IK LEAP W502 with ALC897

Jimmy Assarsson (1):
      can: kvaser_usb: Explicitly initialize family in leafimx driver_info struct

Jinliang Zheng (1):
      mm: optimize the redundant loop of mm_update_owner_next()

John Meneghini (1):
      scsi: qedf: Make qedf_execute_tmf() non-preemptible

Joy Chakraborty (1):
      nvmem: meson-efuse: Fix return value of nvmem callbacks

Jozef Hopko (1):
      wifi: wilc1000: fix ies_len type in connect path

Kuniyuki Iwashima (1):
      udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().

Lee Jones (1):
      usb: gadget: configfs: Prevent OOB read/write in usb_string_copy()

Ma Jun (1):
      drm/amdgpu: Initialize timestamp for some legacy SOCs

Ma Ke (1):
      drm/nouveau: fix null pointer dereference in nouveau_connector_get_modes

Mank Wang (1):
      USB: serial: option: add Netprisma LCUK54 series modules

Mauro Carvalho Chehab (1):
      media: dw2102: fix a potential buffer overflow

Menglong Dong (1):
      net: tcp: fix unexcepted socket die when snd_wnd is 0

Michael Bunk (1):
      media: dw2102: Don't translate i2c read into write

Michael Ellerman (1):
      powerpc/64: Set _IO_BASE to POISON_POINTER_DELTA not 0 for CONFIG_PCI=n

Michael Guralnik (1):
      IB/core: Implement a limit on UMAD receive List

Michal Mazur (1):
      octeontx2-af: fix detection of IP layer

Mike Marshall (1):
      orangefs: fix out-of-bounds fsid access

Neal Cardwell (2):
      UPSTREAM: tcp: fix DSACK undo in fast recovery to call tcp_try_to_open()
      tcp: fix incorrect undo caused by DSACK of TLP retransmit

Nilay Shroff (1):
      nvme-multipath: find NUMA path only for online numa-node

Piotr Wojtaszczyk (1):
      i2c: pnx: Fix potential deadlock warning from del_timer_sync() call in isr

Ricardo Ribalda (5):
      media: dvb: as102-fe: Fix as10x_register_addr packing
      media: dvb-usb: dib0700_devices: Add missing release_firmware()
      media: dvb-frontends: tda18271c2dd: Remove casting during div
      media: s2255: Use refcount_t instead of atomic_t for num_channels
      media: dvb-frontends: tda10048: Fix integer overflow

Ryusuke Konishi (4):
      nilfs2: fix inode number range checks
      nilfs2: add missing check for inode numbers on directory entries
      nilfs2: fix incorrect inode allocation from reserved inodes
      nilfs2: fix kernel bug on rename operation of broken directory

Sam Sun (1):
      bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()

Shigeru Yoshida (1):
      inet_diag: Initialize pad field in struct inet_diag_req_v2

Simon Horman (1):
      net: dsa: mv88e6xxx: Correct check for empty list

Slark Xiao (1):
      USB: serial: option: add support for Foxconn T99W651

Sven Schnelle (1):
      s390: Mark psw in __load_psw_mask() as __unitialized

Vanillan Wang (1):
      USB: serial: option: add Rolling RW350-GL variants

Wang Yong (1):
      jffs2: Fix potential illegal address access in jffs2_free_inode

WangYuli (1):
      USB: Add USB_QUIRK_NO_SET_INTF quirk for START BP-850k

Wolfram Sang (1):
      i2c: rcar: bring hardware to known state when probing

Yousuk Seung (1):
      tcp: add ece_ack flag to reno sack functions

Yuchung Cheng (1):
      net: tcp better handling of reordering then loss cases

Zijian Zhang (2):
      selftests: fix OOM in msg_zerocopy selftest
      selftests: make order checking verbose in msg_zerocopy selftest

felix (1):
      SUNRPC: Fix RPC client cleaned up the freed pipefs dentries

linke li (1):
      fs/dcache: Re-use value stored to dentry->d_flags instead of re-reading

zhang kai (1):
      tcp: tcp_mark_head_lost is only valid for sack-tcp


