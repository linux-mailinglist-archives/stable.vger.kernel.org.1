Return-Path: <stable+bounces-60539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA83934C66
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 13:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01964282A82
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 11:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A3D12F375;
	Thu, 18 Jul 2024 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NVux4lS6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D29E74429;
	Thu, 18 Jul 2024 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302008; cv=none; b=KFojeH2kUKuPFh3vFQgErMoAfLjJLygzCDpWBkm3QGOvS3DGC81rhN0ZATH4hOfZNHIc0h1JPxptYwgoSFxJpa8oPjMNzu9jhvVZAVmSSFRDkRqSF2OrUzgd7bQMnUp3AEjgoyU+/rd8TGldDuTIh9HroZp32K83kR6JEkOzgmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302008; c=relaxed/simple;
	bh=odjitOLWIYY2omSbJtApa+NMaFIyjSmI2YTA7fqhNik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W67p41qSROGZJAldPGMQjqzSLGzyMD6Fd+0SW3m7eOSYa3bD3hfY+TmGwZhVuWWcPmmOS8Hzv887piglpya8wkfOiLF6zprbqPgEVdm1u2Ja5BtKTA6/Sy63w7jBwXRA37pt06xnxhMUz69rR9SFVepiRSeOoHdr70ewEnFzhME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NVux4lS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253B6C4AF0B;
	Thu, 18 Jul 2024 11:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721302007;
	bh=odjitOLWIYY2omSbJtApa+NMaFIyjSmI2YTA7fqhNik=;
	h=From:To:Cc:Subject:Date:From;
	b=NVux4lS6nVlG1L1zbIzMHh1GUQ1KfYsJgfg/ame8+iprzbEK+RkIxD43UuExgRfrE
	 a/fs5iGi3yg4NLHECp4m1tr5m0rwsLpshiu0NI3aZq25+xnfp43C2M7NPpUSg4vlXT
	 LVcFOTkBp9VeiKgIdJN5ZPxR9bvUbgAlDHG1aeuY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.222
Date: Thu, 18 Jul 2024 13:26:42 +0200
Message-ID: <2024071843-stretch-residual-1c28@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.222 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm/mach-davinci/pm.c                                     |    2 
 arch/ia64/include/asm/efi.h                                    |   13 
 arch/ia64/kernel/efi.c                                         |    1 
 arch/ia64/kernel/machine_kexec.c                               |    1 
 arch/ia64/kernel/mca.c                                         |    1 
 arch/ia64/kernel/smpboot.c                                     |    1 
 arch/ia64/kernel/time.c                                        |    1 
 arch/ia64/kernel/uncached.c                                    |    4 
 arch/ia64/mm/contig.c                                          |    1 
 arch/ia64/mm/discontig.c                                       |    1 
 arch/ia64/mm/init.c                                            |    1 
 arch/powerpc/include/asm/io.h                                  |    2 
 arch/powerpc/xmon/xmon.c                                       |    6 
 arch/s390/include/asm/processor.h                              |    2 
 arch/x86/lib/retpoline.S                                       |    2 
 crypto/aead.c                                                  |    3 
 crypto/cipher.c                                                |    3 
 drivers/bluetooth/hci_qca.c                                    |   18 
 drivers/char/hpet.c                                            |   34 +
 drivers/firmware/dmi_scan.c                                    |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c                        |    8 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c              |    3 
 drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c |    8 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c            |    8 
 drivers/gpu/drm/amd/include/atomfirmware.h                     |    2 
 drivers/gpu/drm/lima/lima_gp.c                                 |    2 
 drivers/gpu/drm/lima/lima_mmu.c                                |    5 
 drivers/gpu/drm/lima/lima_pp.c                                 |    4 
 drivers/gpu/drm/nouveau/nouveau_connector.c                    |    3 
 drivers/i2c/busses/i2c-i801.c                                  |    2 
 drivers/i2c/busses/i2c-pnx.c                                   |   48 --
 drivers/i2c/busses/i2c-rcar.c                                  |   66 +--
 drivers/i2c/i2c-core-base.c                                    |    1 
 drivers/infiniband/core/user_mad.c                             |   21 
 drivers/input/ff-core.c                                        |    7 
 drivers/media/dvb-frontends/as102_fe_types.h                   |    2 
 drivers/media/dvb-frontends/tda10048.c                         |    9 
 drivers/media/dvb-frontends/tda18271c2dd.c                     |    4 
 drivers/media/usb/dvb-usb/dib0700_devices.c                    |   18 
 drivers/media/usb/dvb-usb/dw2102.c                             |  120 +++--
 drivers/media/usb/s2255/s2255drv.c                             |   20 
 drivers/mtd/nand/raw/nand_base.c                               |   55 +-
 drivers/net/bonding/bond_options.c                             |    6 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c               |    1 
 drivers/net/dsa/mv88e6xxx/chip.c                               |    4 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h                    |    2 
 drivers/net/ethernet/lantiq_etop.c                             |    5 
 drivers/net/ethernet/marvell/octeontx2/af/npc.h                |    8 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                |    2 
 drivers/net/ethernet/micrel/ks8851_common.c                    |    2 
 drivers/net/ppp/ppp_generic.c                                  |   15 
 drivers/net/wireguard/allowedips.c                             |    4 
 drivers/net/wireguard/queueing.h                               |    4 
 drivers/net/wireguard/send.c                                   |    2 
 drivers/net/wireless/microchip/wilc1000/hif.c                  |    3 
 drivers/nvme/host/multipath.c                                  |    2 
 drivers/nvme/host/pci.c                                        |    3 
 drivers/nvme/target/core.c                                     |    9 
 drivers/nvmem/meson-efuse.c                                    |   14 
 drivers/platform/x86/touchscreen_dmi.c                         |   36 +
 drivers/s390/crypto/pkey_api.c                                 |    4 
 drivers/scsi/qedf/qedf_io.c                                    |    6 
 drivers/usb/core/config.c                                      |   18 
 drivers/usb/core/quirks.c                                      |    3 
 drivers/usb/gadget/configfs.c                                  |    3 
 drivers/usb/serial/mos7840.c                                   |   45 ++
 drivers/usb/serial/option.c                                    |   38 +
 fs/dcache.c                                                    |   12 
 fs/jffs2/super.c                                               |    1 
 fs/locks.c                                                     |    2 
 fs/nilfs2/alloc.c                                              |   18 
 fs/nilfs2/alloc.h                                              |    4 
 fs/nilfs2/dat.c                                                |    2 
 fs/nilfs2/dir.c                                                |   38 +
 fs/nilfs2/ifile.c                                              |    7 
 fs/nilfs2/nilfs.h                                              |   10 
 fs/nilfs2/the_nilfs.c                                          |    6 
 fs/nilfs2/the_nilfs.h                                          |    2 
 fs/orangefs/super.c                                            |    3 
 include/linux/bpf.h                                            |    1 
 include/linux/compiler_attributes.h                            |   12 
 include/linux/efi.h                                            |    6 
 include/linux/fsnotify.h                                       |    8 
 include/linux/lsm_hook_defs.h                                  |    2 
 include/linux/mmzone.h                                         |    3 
 include/linux/security.h                                       |    5 
 include/linux/skmsg.h                                          |    1 
 kernel/auditfilter.c                                           |    5 
 kernel/bpf/verifier.c                                          |   11 
 kernel/exit.c                                                  |    2 
 lib/kunit/try-catch.c                                          |    3 
 mm/page-writeback.c                                            |   32 +
 net/ceph/mon_client.c                                          |   14 
 net/core/skmsg.c                                               |    1 
 net/core/sock_map.c                                            |   22 +
 net/ethtool/linkstate.c                                        |   41 +
 net/ipv4/inet_diag.c                                           |    2 
 net/ipv4/tcp_bpf.c                                             |    1 
 net/ipv4/tcp_input.c                                           |   13 
 net/ipv4/tcp_metrics.c                                         |    1 
 net/ipv4/tcp_timer.c                                           |   31 +
 net/ipv4/udp.c                                                 |    4 
 net/ipv6/addrconf.c                                            |    9 
 net/ipv6/ip6_input.c                                           |    2 
 net/ipv6/ip6_output.c                                          |    2 
 net/sched/act_ct.c                                             |    8 
 net/sctp/socket.c                                              |    7 
 scripts/link-vmlinux.sh                                        |    2 
 security/apparmor/audit.c                                      |    6 
 security/apparmor/include/audit.h                              |    2 
 security/integrity/ima/ima.h                                   |    2 
 security/integrity/ima/ima_policy.c                            |   15 
 security/security.c                                            |    6 
 security/selinux/include/audit.h                               |    4 
 security/selinux/ss/services.c                                 |    5 
 security/smack/smack_lsm.c                                     |    4 
 sound/pci/hda/patch_realtek.c                                  |   12 
 tools/lib/bpf/bpf_core_read.h                                  |    1 
 tools/testing/selftests/bpf/progs/test_global_func10.c         |   31 +
 tools/testing/selftests/bpf/verifier/calls.c                   |   13 
 tools/testing/selftests/bpf/verifier/helper_access_var_len.c   |  104 +++-
 tools/testing/selftests/bpf/verifier/int_ptr.c                 |    9 
 tools/testing/selftests/bpf/verifier/search_pruning.c          |   13 
 tools/testing/selftests/bpf/verifier/sock.c                    |   27 -
 tools/testing/selftests/bpf/verifier/spill_fill.c              |  211 ++++++++++
 tools/testing/selftests/bpf/verifier/var_off.c                 |   52 --
 tools/testing/selftests/net/msg_zerocopy.c                     |   14 
 128 files changed, 1207 insertions(+), 445 deletions(-)

Alan Stern (1):
      USB: core: Fix duplicate endpoint bug by clearing reserved bits in the descriptor

Aleksander Jan Bajkowski (2):
      net: lantiq_etop: add blank line after declaration
      net: ethernet: lantiq_etop: fix double free in detach

Aleksandr Mishin (1):
      octeontx2-af: Fix incorrect value output on error path in rvu_check_rsrc_availability()

Alex Deucher (1):
      drm/amdgpu/atomfirmware: silence UBSAN warning

Alex Hung (3):
      drm/amd/display: Check index msg_id before read or write
      drm/amd/display: Check pipe offset before setting vblank
      drm/amd/display: Skip finding free audio for unknown engine_id

Ard Biesheuvel (1):
      efi: ia64: move IA64-only declarations to new asm/efi.h header

Bjørn Mork (1):
      USB: serial: option: add Fibocom FM350-GL

Brian Foster (1):
      vfs: don't mod negative dentry count when on shrinker list

Chen Ni (1):
      ARM: davinci: Convert comma to semicolon

Chengen Du (1):
      net/sched: Fix UAF when resolving a clash

Dan Carpenter (1):
      i2c: rcar: fix error code in probe()

Daniele Palmas (2):
      USB: serial: option: add Telit generic core-dump composition
      USB: serial: option: add Telit FN912 rmnet compositions

Dmitry Antipov (1):
      ppp: reject claimed-as-LCP but actually malformed packets

Dmitry Smirnov (1):
      USB: serial: mos7840: fix crash on resume

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on VAIO PRO PX

Eduard Zingerman (1):
      bpf: Allow reads from uninit stack

Eric Dumazet (4):
      tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()
      tcp: avoid too many retransmit packets
      ipv6: annotate data-races around cnf.disable_ipv6
      ipv6: prevent NULL dereference in ip6_output()

Erick Archer (2):
      sctp: prefer struct_size over open coded arithmetic
      Input: ff-core - prefer struct_size over open coded arithmetic

Erico Nunes (1):
      drm/lima: fix shared irq handling on driver remove

GUO Zihua (1):
      ima: Avoid blocking in RCU read-side critical section

Geert Uytterhoeven (1):
      i2c: rcar: Add R-Car Gen4 support

Ghadi Elie Rahme (1):
      bnx2x: Fix multiple UBSAN array-index-out-of-bounds

Greg Kroah-Hartman (1):
      Linux 5.10.222

Greg Kurz (1):
      powerpc/xmon: Check cpu id in commands "c#", "dp#" and "dx#"

Hailey Mothershead (1):
      crypto: aead,cipher - zeroize key buffer after use

He Zhe (1):
      hpet: Support 32-bit userspace

Heiko Carstens (1):
      Compiler Attributes: Add __uninitialized macro

Heiner Kallweit (1):
      i2c: i801: Annotate apanel_addr as __ro_after_init

Helge Deller (1):
      wireguard: allowedips: avoid unaligned 64-bit memory accesses

Holger Dengler (1):
      s390/pkey: Wipe sensitive data on failure

Ilya Dryomov (1):
      libceph: fix race between delayed_work() and ceph_monc_stop()

Jakub Kicinski (1):
      tcp_metrics: validate source addr length

Jan Kara (3):
      mm: avoid overflows in dirty throttling logic
      fsnotify: Do not generate events for O_PATH file descriptors
      Revert "mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again"

Jason A. Donenfeld (2):
      wireguard: queueing: annotate intentional data race in cpu round robin
      wireguard: send: annotate intentional data race in checking empty queue

Jean Delvare (1):
      firmware: dmi: Stop decoding on broken entry

Jeff Layton (1):
      filelock: fix potential use-after-free in posix_lock_inode

Jian-Hong Pan (1):
      ALSA: hda/realtek: Enable headset mic of JP-IK LEAP W502 with ALC897

Jim Mattson (1):
      x86/retpoline: Move a NOENDBR annotation to the SRSO dummy return thunk

Jimmy Assarsson (1):
      can: kvaser_usb: Explicitly initialize family in leafimx driver_info struct

Jinliang Zheng (1):
      mm: optimize the redundant loop of mm_update_owner_next()

John Meneghini (1):
      scsi: qedf: Make qedf_execute_tmf() non-preemptible

Jose E. Marchesi (1):
      bpf: Avoid uninitialized value in BPF_CORE_READ_BITFIELD

Joy Chakraborty (1):
      nvmem: meson-efuse: Fix return value of nvmem callbacks

Jozef Hopko (1):
      wifi: wilc1000: fix ies_len type in connect path

Kundan Kumar (1):
      nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset

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

Masahiro Yamada (1):
      kbuild: fix short log for AS in link-vmlinux.sh

Mauro Carvalho Chehab (1):
      media: dw2102: fix a potential buffer overflow

Michael Bunk (1):
      media: dw2102: Don't translate i2c read into write

Michael Ellerman (1):
      powerpc/64: Set _IO_BASE to POISON_POINTER_DELTA not 0 for CONFIG_PCI=n

Michael Guralnik (1):
      IB/core: Implement a limit on UMAD receive List

Michal Mazur (1):
      octeontx2-af: fix detection of IP layer

Mickaël Salaün (1):
      kunit: Fix timeout message

Mike Marshall (1):
      orangefs: fix out-of-bounds fsid access

Miquel Raynal (1):
      mtd: rawnand: Bypass a couple of sanity checks during NAND identification

Nazar Bilinskyi (1):
      ALSA: hda/realtek: Enable Mute LED on HP 250 G7

Neal Cardwell (2):
      UPSTREAM: tcp: fix DSACK undo in fast recovery to call tcp_try_to_open()
      tcp: fix incorrect undo caused by DSACK of TLP retransmit

Nilay Shroff (1):
      nvme-multipath: find NUMA path only for online numa-node

Oleksij Rempel (1):
      ethtool: netlink: do not return SQI value if link is down

Piotr Wojtaszczyk (1):
      i2c: pnx: Fix potential deadlock warning from del_timer_sync() call in isr

Ricardo Ribalda (5):
      media: dvb: as102-fe: Fix as10x_register_addr packing
      media: dvb-usb: dib0700_devices: Add missing release_firmware()
      media: dvb-frontends: tda18271c2dd: Remove casting during div
      media: s2255: Use refcount_t instead of atomic_t for num_channels
      media: dvb-frontends: tda10048: Fix integer overflow

Ronald Wahl (1):
      net: ks8851: Fix potential TX stall after interface reopen

Ryusuke Konishi (4):
      nilfs2: fix inode number range checks
      nilfs2: add missing check for inode numbers on directory entries
      nilfs2: fix incorrect inode allocation from reserved inodes
      nilfs2: fix kernel bug on rename operation of broken directory

Sagi Grimberg (1):
      nvmet: fix a possible leak when destroy a ctrl during qp establishment

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

Waiman Long (1):
      mm: prevent derefencing NULL ptr in pfn_section_valid()

Wang Yong (1):
      jffs2: Fix potential illegal address access in jffs2_free_inode

Wang Yufen (1):
      bpf, sockmap: Fix sk->sk_forward_alloc warn_on in sk_stream_kill_queues

WangYuli (1):
      USB: Add USB_QUIRK_NO_SET_INTF quirk for START BP-850k

Wolfram Sang (6):
      i2c: rcar: bring hardware to known state when probing
      i2c: mark HostNotify target address as used
      i2c: rcar: reset controller is mandatory for Gen3+
      i2c: rcar: introduce Gen4 devices
      i2c: rcar: ensure Gen3+ reset does not disturb local targets
      i2c: rcar: clear NO_RXDMA flag after resetting

Zijian Zhang (2):
      selftests: fix OOM in msg_zerocopy selftest
      selftests: make order checking verbose in msg_zerocopy selftest

Zijun Hu (1):
      Bluetooth: qca: Fix BT enable failure again for QCA6390 after warm reboot

hmtheboy154 (2):
      platform/x86: touchscreen_dmi: Add info for GlobalSpace SolT IVW 11.6" tablet
      platform/x86: touchscreen_dmi: Add info for the EZpad 6s Pro

linke li (1):
      fs/dcache: Re-use value stored to dentry->d_flags instead of re-reading


