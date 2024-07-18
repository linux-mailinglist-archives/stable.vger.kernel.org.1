Return-Path: <stable+bounces-60541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21021934C6A
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 13:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70F2282C2E
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 11:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46856137905;
	Thu, 18 Jul 2024 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qFSh+JsM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA6136657;
	Thu, 18 Jul 2024 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302025; cv=none; b=GdrWx6Qw1If9YJW9dQ0XIM/iL04fDj7bhBXhGJtXDkDGMoE0hWnOOra1bh4YFS0RHvZ89n7pVBR1RPZBycgRywron68+KusaGrmuOY+1vXs4I5iy071ggkcgmt1ofiIePfsy4KS109s5ET8o+jumORtzR8ALVXu+kkysAtl8rPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302025; c=relaxed/simple;
	bh=BKS7qv8+0cV3e0LAeyxdD9MROZ9EHrmUz/bplsvkaYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hs3mD/1HVqUr/fv8MQJCq8wMKwDwpVpHZ8J22Y8CLO3UmJ0GlHM8SyL6sKHS4DYjYxDq+DHz9xIM7uiRL1O2PugLTmdo5ZKzUWqFcHBJl3taFH9fVMf3Gw9NexGzRB64cyt6GG86h9UvBUM3mKILUurz+NXJy9UdAcHN/kkv9Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qFSh+JsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D5DC116B1;
	Thu, 18 Jul 2024 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721302024;
	bh=BKS7qv8+0cV3e0LAeyxdD9MROZ9EHrmUz/bplsvkaYk=;
	h=From:To:Cc:Subject:Date:From;
	b=qFSh+JsM60rFnSE/3KhB22RQ3o9dwyB/V1deOhNFiS84o5gFxjTa7HL4F0DusjKd6
	 TZs9uQ4yFYUeiLi8GGrSzT2Y1yVWZ3FN2y62WjmZMP0Ghjz+bKFGayBbyW45MltY17
	 A8So0aI7yAiQi15j83dlXc9gyzAm9IuzdnAmrq2U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.163
Date: Thu, 18 Jul 2024 13:26:52 +0200
Message-ID: <2024071852-daybreak-levitate-b328@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.163 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm/mach-davinci/pm.c                                     |    2 
 arch/powerpc/include/asm/io.h                                  |    2 
 arch/powerpc/xmon/xmon.c                                       |    6 
 arch/riscv/kernel/machine_kexec.c                              |   10 
 arch/s390/include/asm/kvm_host.h                               |    1 
 arch/s390/include/asm/processor.h                              |    2 
 arch/s390/kvm/kvm-s390.c                                       |    1 
 arch/s390/kvm/kvm-s390.h                                       |   15 
 arch/s390/kvm/priv.c                                           |   32 +
 arch/x86/entry/entry_64.S                                      |   19 
 arch/x86/entry/entry_64_compat.S                               |   14 
 crypto/aead.c                                                  |    3 
 crypto/cipher.c                                                |    3 
 drivers/base/regmap/regmap-i2c.c                               |    3 
 drivers/block/null_blk/zoned.c                                 |   11 
 drivers/bluetooth/hci_qca.c                                    |   18 
 drivers/char/hpet.c                                            |   34 +
 drivers/clk/qcom/gcc-sm6350.c                                  |   10 
 drivers/firmware/dmi_scan.c                                    |   11 
 drivers/gpio/gpiolib-of.c                                      |   92 +++-
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
 drivers/i2c/i2c-slave-testunit.c                               |    7 
 drivers/infiniband/core/user_mad.c                             |   21 
 drivers/input/ff-core.c                                        |    7 
 drivers/media/dvb-frontends/as102_fe_types.h                   |    2 
 drivers/media/dvb-frontends/tda10048.c                         |    9 
 drivers/media/dvb-frontends/tda18271c2dd.c                     |    4 
 drivers/media/usb/dvb-usb/dib0700_devices.c                    |   18 
 drivers/media/usb/dvb-usb/dw2102.c                             |  120 +++--
 drivers/media/usb/s2255/s2255drv.c                             |   20 
 drivers/mtd/nand/raw/nand_base.c                               |   64 +--
 drivers/mtd/nand/raw/rockchip-nand-controller.c                |    6 
 drivers/net/bonding/bond_options.c                             |    6 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c               |    1 
 drivers/net/dsa/mv88e6xxx/chip.c                               |    4 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h                    |    2 
 drivers/net/ethernet/intel/e1000e/netdev.c                     |  132 +++---
 drivers/net/ethernet/intel/i40e/i40e_main.c                    |    9 
 drivers/net/ethernet/lantiq_etop.c                             |    5 
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h               |   10 
 drivers/net/ethernet/marvell/octeontx2/af/npc.h                |    8 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c            |   33 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c            |   67 +++
 drivers/net/ethernet/mediatek/mtk_star_emac.c                  |    7 
 drivers/net/ethernet/micrel/ks8851_common.c                    |    2 
 drivers/net/ppp/ppp_generic.c                                  |   15 
 drivers/net/wireguard/allowedips.c                             |    4 
 drivers/net/wireguard/queueing.h                               |    4 
 drivers/net/wireguard/send.c                                   |    2 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c           |   10 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                |    2 
 drivers/net/wireless/microchip/wilc1000/hif.c                  |    3 
 drivers/nfc/virtual_ncidev.c                                   |    4 
 drivers/nvme/host/multipath.c                                  |    2 
 drivers/nvme/host/pci.c                                        |    3 
 drivers/nvme/target/core.c                                     |    9 
 drivers/nvmem/core.c                                           |    5 
 drivers/nvmem/meson-efuse.c                                    |   14 
 drivers/nvmem/rmem.c                                           |    5 
 drivers/platform/x86/touchscreen_dmi.c                         |   36 +
 drivers/s390/crypto/pkey_api.c                                 |    4 
 drivers/scsi/qedf/qedf_io.c                                    |    6 
 drivers/usb/core/config.c                                      |   18 
 drivers/usb/core/quirks.c                                      |    3 
 drivers/usb/gadget/configfs.c                                  |    3 
 drivers/usb/serial/mos7840.c                                   |   45 ++
 drivers/usb/serial/option.c                                    |   38 +
 fs/btrfs/block-group.c                                         |   13 
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
 fs/ntfs3/xattr.c                                               |    5 
 fs/orangefs/super.c                                            |    3 
 fs/userfaultfd.c                                               |    7 
 include/linux/compiler_attributes.h                            |   12 
 include/linux/fsnotify.h                                       |    8 
 include/linux/lsm_hook_defs.h                                  |    2 
 include/linux/mmzone.h                                         |    3 
 include/linux/mutex.h                                          |   27 +
 include/linux/security.h                                       |    5 
 kernel/auditfilter.c                                           |    5 
 kernel/bpf/verifier.c                                          |   11 
 kernel/dma/map_benchmark.c                                     |    3 
 kernel/exit.c                                                  |    2 
 kernel/locking/mutex-debug.c                                   |   12 
 lib/kunit/try-catch.c                                          |    3 
 mm/page-writeback.c                                            |   32 +
 net/ceph/mon_client.c                                          |   14 
 net/core/datagram.c                                            |   20 
 net/core/skmsg.c                                               |    3 
 net/ethtool/linkstate.c                                        |   41 +
 net/ipv4/inet_diag.c                                           |    2 
 net/ipv4/tcp_input.c                                           |   13 
 net/ipv4/tcp_metrics.c                                         |    1 
 net/ipv4/tcp_timer.c                                           |   31 +
 net/ipv4/udp.c                                                 |    4 
 net/ipv6/addrconf.c                                            |    9 
 net/ipv6/ip6_input.c                                           |    2 
 net/ipv6/ip6_output.c                                          |    2 
 net/netfilter/nf_tables_api.c                                  |    3 
 net/sched/act_ct.c                                             |    8 
 net/sctp/socket.c                                              |    7 
 scripts/ld-version.sh                                          |    8 
 scripts/link-vmlinux.sh                                        |    2 
 security/apparmor/audit.c                                      |    6 
 security/apparmor/include/audit.h                              |    2 
 security/integrity/ima/ima.h                                   |    2 
 security/integrity/ima/ima_policy.c                            |   15 
 security/security.c                                            |    6 
 security/selinux/include/audit.h                               |    4 
 security/selinux/ss/services.c                                 |    5 
 security/smack/smack_lsm.c                                     |    4 
 sound/pci/hda/patch_realtek.c                                  |   13 
 tools/lib/bpf/bpf_core_read.h                                  |    1 
 tools/power/x86/turbostat/turbostat.c                          |   10 
 tools/testing/selftests/bpf/progs/test_global_func10.c         |    9 
 tools/testing/selftests/bpf/verifier/calls.c                   |   13 
 tools/testing/selftests/bpf/verifier/helper_access_var_len.c   |  104 +++-
 tools/testing/selftests/bpf/verifier/int_ptr.c                 |    9 
 tools/testing/selftests/bpf/verifier/search_pruning.c          |   13 
 tools/testing/selftests/bpf/verifier/sock.c                    |   27 -
 tools/testing/selftests/bpf/verifier/spill_fill.c              |  211 ++++++++++
 tools/testing/selftests/bpf/verifier/var_off.c                 |   52 --
 tools/testing/selftests/net/msg_zerocopy.c                     |   14 
 146 files changed, 1583 insertions(+), 614 deletions(-)

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

Alexandre Chartre (1):
      x86/bhi: Avoid warning in #DB handler due to BHI mitigation

Audra Mitchell (1):
      Fix userfaultfd_api to return EINVAL as expected

Bjørn Mork (1):
      USB: serial: option: add Fibocom FM350-GL

Brian Foster (1):
      vfs: don't mod negative dentry count when on shrinker list

Brian Gerst (1):
      x86/entry/64: Remove obsolete comment on tracing vs. SYSRET

Chen Ni (1):
      ARM: davinci: Convert comma to semicolon

Chengen Du (1):
      net/sched: Fix UAF when resolving a clash

Christian Borntraeger (1):
      KVM: s390: fix LPSWEY handling

Corinna Vinschen (1):
      igc: fix a log entry using uninitialized netdev

Damien Le Moal (1):
      null_blk: Do not allow runt zone with zone capacity smaller then zone size

Dan Carpenter (1):
      i2c: rcar: fix error code in probe()

Daniele Palmas (2):
      USB: serial: option: add Telit generic core-dump composition
      USB: serial: option: add Telit FN912 rmnet compositions

Dima Ruinskiy (1):
      e1000e: Fix S0ix residency on corporate systems

Dmitry Antipov (1):
      ppp: reject claimed-as-LCP but actually malformed packets

Dmitry Smirnov (1):
      USB: serial: mos7840: fix crash on resume

Dmitry Torokhov (3):
      gpiolib: of: factor out code overriding gpio line polarity
      gpiolib: of: add a quirk for reset line polarity for Himax LCDs
      gpiolib: of: add polarity quirk for TSC2005

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on VAIO PRO PX

Eduard Zingerman (1):
      bpf: Allow reads from uninit stack

Edward Adam Davis (1):
      nfc/nci: Add the inconsistency check between the input data length and count

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

Fedor Pchelkin (1):
      dma-mapping: benchmark: avoid needless copy_to_user if benchmark fails

Felix Fietkau (1):
      wifi: mt76: replace skb_put with skb_put_zero

Florian Westphal (1):
      netfilter: nf_tables: unconditionally flush pending work before notifier

GUO Zihua (1):
      ima: Avoid blocking in RCU read-side critical section

Geert Uytterhoeven (1):
      i2c: rcar: Add R-Car Gen4 support

Geliang Tang (1):
      skmsg: Skip zero length skb in sk_msg_recvmsg

George Stark (1):
      locking/mutex: Introduce devm_mutex_init()

Ghadi Elie Rahme (1):
      bnx2x: Fix multiple UBSAN array-index-out-of-bounds

Greg Kroah-Hartman (1):
      Linux 5.15.163

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

Hugh Dickins (1):
      net: fix rc7's __skb_datagram_iter()

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

Jian Hui Lee (1):
      net: ethernet: mtk-star-emac: set mac_managed_pm when probing

Jian-Hong Pan (1):
      ALSA: hda/realtek: Enable headset mic of JP-IK LEAP W502 with ALC897

Jim Wylder (1):
      regmap-i2c: Subtract reg size from max_write

Jimmy Assarsson (1):
      can: kvaser_usb: Explicitly initialize family in leafimx driver_info struct

Jinliang Zheng (1):
      mm: optimize the redundant loop of mm_update_owner_next()

John Meneghini (1):
      scsi: qedf: Make qedf_execute_tmf() non-preemptible

Jose E. Marchesi (1):
      bpf: Avoid uninitialized value in BPF_CORE_READ_BITFIELD

Joy Chakraborty (2):
      nvmem: rmem: Fix return value of rmem_read()
      nvmem: meson-efuse: Fix return value of nvmem callbacks

Jozef Hopko (1):
      wifi: wilc1000: fix ies_len type in connect path

Kiran Kumar K (2):
      octeontx2-af: extend RSS supported offload types
      octeontx2-af: fix issue with IPv6 ext match for RSS

Konstantin Komarov (1):
      fs/ntfs3: Mark volume as dirty if xattr is broken

Kundan Kumar (1):
      nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset

Kuniyuki Iwashima (1):
      udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().

Lee Jones (1):
      usb: gadget: configfs: Prevent OOB read/write in usb_string_copy()

Len Brown (1):
      tools/power turbostat: Remember global max_die_id

Luca Weiss (1):
      clk: qcom: gcc-sm6350: Fix gpll6* & gpll7 parents

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

Michal Kubiak (1):
      i40e: Fix XDP program unloading while removing the driver

Michal Mazur (1):
      octeontx2-af: fix detection of IP layer

Michał Kopeć (1):
      ALSA: hda/realtek: add quirk for Clevo V5[46]0TU

Mickaël Salaün (1):
      kunit: Fix timeout message

Mike Marshall (1):
      orangefs: fix out-of-bounds fsid access

Miquel Raynal (2):
      mtd: rawnand: Ensure ECC configuration is propagated to upper layers
      mtd: rawnand: Bypass a couple of sanity checks during NAND identification

Naohiro Aota (1):
      btrfs: fix adding block group to a reclaim list and the unused list during reclaim

Nathan Chancellor (1):
      kbuild: Make ld-version.sh more robust against version string changes

Nazar Bilinskyi (1):
      ALSA: hda/realtek: Enable Mute LED on HP 250 G7

Neal Cardwell (2):
      UPSTREAM: tcp: fix DSACK undo in fast recovery to call tcp_try_to_open()
      tcp: fix incorrect undo caused by DSACK of TLP retransmit

Nilay Shroff (1):
      nvme-multipath: find NUMA path only for online numa-node

Nithin Dabilpuram (1):
      octeontx2-af: replace cpt slot with lf id on reg write

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

Sagi Grimberg (2):
      net: allow skb_datagram_iter to be called from any context
      nvmet: fix a possible leak when destroy a ctrl during qp establishment

Sam Sun (1):
      bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()

Sasha Neftin (1):
      Revert "igc: fix a log entry using uninitialized netdev"

Satheesh Paul (1):
      octeontx2-af: fix issue with IPv4 match for RSS

Shigeru Yoshida (1):
      inet_diag: Initialize pad field in struct inet_diag_req_v2

Simon Horman (1):
      net: dsa: mv88e6xxx: Correct check for empty list

Slark Xiao (1):
      USB: serial: option: add support for Foxconn T99W651

Song Shuai (1):
      riscv: kexec: Avoid deadlock in kexec crash path

Srujana Challa (2):
      octeontx2-af: update cpt lf alloc mailbox
      octeontx2-af: fix a issue with cpt_lf_alloc mailbox

Sven Schnelle (1):
      s390: Mark psw in __load_psw_mask() as __unitialized

Thomas Weißschuh (1):
      nvmem: core: only change name to fram for current attribute

Val Packett (1):
      mtd: rawnand: rockchip: ensure NVDDR timings are rejected

Vanillan Wang (1):
      USB: serial: option: add Rolling RW350-GL variants

Waiman Long (1):
      mm: prevent derefencing NULL ptr in pfn_section_valid()

Wang Yong (1):
      jffs2: Fix potential illegal address access in jffs2_free_inode

WangYuli (1):
      USB: Add USB_QUIRK_NO_SET_INTF quirk for START BP-850k

Wolfram Sang (7):
      i2c: rcar: bring hardware to known state when probing
      i2c: mark HostNotify target address as used
      i2c: rcar: reset controller is mandatory for Gen3+
      i2c: rcar: introduce Gen4 devices
      i2c: rcar: ensure Gen3+ reset does not disturb local targets
      i2c: testunit: avoid re-issued work after read message
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


