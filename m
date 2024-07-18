Return-Path: <stable+bounces-60533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEC6934C2B
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 13:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA6D1B21A23
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3606612A14C;
	Thu, 18 Jul 2024 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E0HjNKCh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA5823C8;
	Thu, 18 Jul 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300678; cv=none; b=rSwR22zMoBI490i3oSTU9HdzKVr/6TVpR+LYNvqxB8tRn5f1/rqCsJEo49PWBkmBHTNFZbJ+KRAE3wv12/k/PFzMpqll+StsgQ8BcPVh/ae9eeSidT8B2lzTHCy+3+DU5lxxewh80opLn1yufTOei7+U/DtYfx9LcZTUTX5QyHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300678; c=relaxed/simple;
	bh=d469z3VGydQXKn5f4NmC6XLhbPn9lCYH85f3aUqRXkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U3C4veiNPpWhywiZv50IDEadED4IfNLcFc2+lolDEy3F9FINxVHF8DYAha/fonFtseBKBqF9aPlUBrDfJl329/wefoxZmistHClKIzYmNSlkWRU+/zqQhh3Au6bHgfMoKj5U3f1G9Lc/EgYnB5WLSSsPGGjOFfjWVUy8sC6TQvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E0HjNKCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B16C4AF0B;
	Thu, 18 Jul 2024 11:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721300677;
	bh=d469z3VGydQXKn5f4NmC6XLhbPn9lCYH85f3aUqRXkE=;
	h=From:To:Cc:Subject:Date:From;
	b=E0HjNKChhrsbabSVop70ENE4sXSWfBrzSk5CYeR1w8qt1nZ4DD2v3XvEslolD5ogC
	 jad9QXbWsYvEl1jJG7uXQM705sHCpPJJ2IkQsSBYh0V10nBSbC35LIkkSzPQ0KEgW9
	 UA0TMF3Sc1yhW4dleXO2VjbR5Jk0TLaiVINl1zhc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.318
Date: Thu, 18 Jul 2024 13:04:27 +0200
Message-ID: <2024071828-zips-resemble-eea0@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.318 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 
 arch/arm/mach-davinci/pm.c                        |    2 
 arch/arm64/include/asm/compat.h                   |   20 --
 arch/mips/include/asm/compat.h                    |   22 ---
 arch/parisc/include/asm/compat.h                  |   18 --
 arch/powerpc/include/asm/compat.h                 |   18 --
 arch/powerpc/include/asm/io.h                     |    2 
 arch/powerpc/xmon/xmon.c                          |    6 
 arch/s390/include/asm/compat.h                    |   18 --
 arch/sparc/include/asm/compat.h                   |   19 --
 arch/x86/include/asm/compat.h                     |   19 --
 drivers/char/hpet.c                               |   34 ++++
 drivers/firmware/dmi_scan.c                       |   11 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c |    3 
 drivers/gpu/drm/amd/include/atomfirmware.h        |    2 
 drivers/gpu/drm/i915/intel_uncore.c               |   20 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c       |    3 
 drivers/i2c/busses/i2c-i801.c                     |    2 
 drivers/i2c/busses/i2c-pnx.c                      |   48 +-----
 drivers/i2c/busses/i2c-rcar.c                     |   17 +-
 drivers/infiniband/core/user_mad.c                |   21 ++
 drivers/input/ff-core.c                           |    7 
 drivers/media/dvb-frontends/as102_fe_types.h      |    2 
 drivers/media/dvb-frontends/tda10048.c            |    9 -
 drivers/media/dvb-frontends/tda18271c2dd.c        |    4 
 drivers/media/usb/dvb-usb/dib0700_devices.c       |   18 ++
 drivers/media/usb/dvb-usb/dw2102.c                |  120 ++++++++++------
 drivers/media/usb/s2255/s2255drv.c                |   20 +-
 drivers/net/bonding/bond_options.c                |    6 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  |    1 
 drivers/net/dsa/mv88e6xxx/chip.c                  |    4 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h       |    2 
 drivers/net/ethernet/lantiq_etop.c                |    5 
 drivers/net/ppp/ppp_generic.c                     |   15 ++
 drivers/s390/crypto/pkey_api.c                    |    4 
 drivers/usb/core/config.c                         |   18 ++
 drivers/usb/core/quirks.c                         |    3 
 drivers/usb/gadget/configfs.c                     |    3 
 drivers/usb/serial/option.c                       |   38 +++++
 fs/jffs2/super.c                                  |    1 
 fs/nilfs2/alloc.c                                 |   18 +-
 fs/nilfs2/alloc.h                                 |    4 
 fs/nilfs2/dat.c                                   |    2 
 fs/nilfs2/dir.c                                   |   38 +++++
 fs/nilfs2/ifile.c                                 |    7 
 fs/nilfs2/nilfs.h                                 |   10 +
 fs/nilfs2/the_nilfs.c                             |    6 
 fs/nilfs2/the_nilfs.h                             |    2 
 fs/orangefs/super.c                               |    3 
 include/asm-generic/compat.h                      |   24 +++
 include/linux/compat.h                            |    2 
 include/linux/fsnotify.h                          |    8 -
 include/linux/sunrpc/clnt.h                       |    1 
 kernel/exit.c                                     |    2 
 mm/page-writeback.c                               |    2 
 net/bluetooth/hci_event.c                         |    2 
 net/ceph/mon_client.c                             |   14 +
 net/ipv4/inet_diag.c                              |    2 
 net/ipv4/tcp_input.c                              |  158 +++++++++++-----------
 net/ipv4/tcp_metrics.c                            |    1 
 net/ipv4/tcp_timer.c                              |   45 +++++-
 net/sctp/socket.c                                 |    7 
 net/sunrpc/clnt.c                                 |    5 
 tools/testing/selftests/net/msg_zerocopy.c        |   14 +
 64 files changed, 579 insertions(+), 385 deletions(-)

Alan Stern (1):
      USB: core: Fix duplicate endpoint bug by clearing reserved bits in the descriptor

Aleksander Jan Bajkowski (2):
      net: lantiq_etop: add blank line after declaration
      net: ethernet: lantiq_etop: fix double free in detach

Alex Deucher (1):
      drm/amdgpu/atomfirmware: silence UBSAN warning

Alex Hung (1):
      drm/amd/display: Skip finding free audio for unknown engine_id

Arnd Bergmann (1):
      asm-generic: Move common compat types to asm-generic/compat.h

Bjørn Mork (1):
      USB: serial: option: add Fibocom FM350-GL

Chen Ni (1):
      ARM: davinci: Convert comma to semicolon

Daniele Ceraolo Spurio (1):
      drm/i915: make find_fw_domain work on intel_uncore

Daniele Palmas (2):
      USB: serial: option: add Telit generic core-dump composition
      USB: serial: option: add Telit FN912 rmnet compositions

Dmitry Antipov (1):
      ppp: reject claimed-as-LCP but actually malformed packets

Eric Dumazet (4):
      tcp: take care of compressed acks in tcp_add_reno_sack()
      tcp: refactor tcp_retransmit_timer()
      tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()
      tcp: avoid too many retransmit packets

Erick Archer (2):
      sctp: prefer struct_size over open coded arithmetic
      Input: ff-core - prefer struct_size over open coded arithmetic

Ghadi Elie Rahme (1):
      bnx2x: Fix multiple UBSAN array-index-out-of-bounds

Greg Kroah-Hartman (1):
      Linux 4.19.318

Greg Kurz (1):
      powerpc/xmon: Check cpu id in commands "c#", "dp#" and "dx#"

He Zhe (1):
      hpet: Support 32-bit userspace

Heiner Kallweit (1):
      i2c: i801: Annotate apanel_addr as __ro_after_init

Holger Dengler (1):
      s390/pkey: Wipe sensitive data on failure

Ilya Dryomov (1):
      libceph: fix race between delayed_work() and ceph_monc_stop()

Jaganath Kanakkassery (1):
      Bluetooth: Fix incorrect pointer arithmatic in ext_adv_report_evt

Jakub Kicinski (1):
      tcp_metrics: validate source addr length

Jan Kara (2):
      fsnotify: Do not generate events for O_PATH file descriptors
      Revert "mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again"

Jean Delvare (1):
      firmware: dmi: Stop decoding on broken entry

Jimmy Assarsson (1):
      can: kvaser_usb: Explicitly initialize family in leafimx driver_info struct

Jinliang Zheng (1):
      mm: optimize the redundant loop of mm_update_owner_next()

Lee Jones (1):
      usb: gadget: configfs: Prevent OOB read/write in usb_string_copy()

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

Mike Marshall (1):
      orangefs: fix out-of-bounds fsid access

Neal Cardwell (2):
      UPSTREAM: tcp: fix DSACK undo in fast recovery to call tcp_try_to_open()
      tcp: fix incorrect undo caused by DSACK of TLP retransmit

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

zhang kai (1):
      tcp: tcp_mark_head_lost is only valid for sack-tcp


