Return-Path: <stable+bounces-60545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C72C934C79
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 13:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E021C21E81
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B178213B2A4;
	Thu, 18 Jul 2024 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wqwblng4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1813B288;
	Thu, 18 Jul 2024 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302042; cv=none; b=a2p5Pm4LxRb7qO3evyWgkUlc5ndNiMw+jNRdpaJt13dV/Lo3J1rYx+RCYin+QCFyYBLMZrtcaEDwLEwE6mioD4XWafmWD98FX3YKWi7QAnlih1/rzV9DQpWYRczmO9IRlWZGzW2RoIBeIhPRTl4trMJ4SZgVua31WA5xC1a04Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302042; c=relaxed/simple;
	bh=YOHq89YysZxAfPBtrcr+IMAX3fK01jtPoMmfUAY4eBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BZMbwC1anX8G026Kz8bVvbHSavWjCJakDhFDfHdYQ/KabAabU6n8HuBmGNMDvJ5KqWLY1/YeYCaHxwiFcmC9EkosK38BQEulz9pimVpk2FLmfB0fV6neD8b4ufYMZlp4KlMglnJVpRGSYjMlcrv+eU0cDixl5/TUugHdHdj3+X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wqwblng4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9553EC116B1;
	Thu, 18 Jul 2024 11:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721302042;
	bh=YOHq89YysZxAfPBtrcr+IMAX3fK01jtPoMmfUAY4eBg=;
	h=From:To:Cc:Subject:Date:From;
	b=wqwblng48MO93rAiMdETk9smGb5OVqi6uWpTXHhl9UjH/elU1+iuCM3LLlx0zlWDl
	 +rBuN0MrKxs2sTlxn9VqU9T82cNdI/xljzYv6P3kVJpNt2ucuBBsjuxz21N5QujYj8
	 nxDF1kyG0vkgWTNXUaxu7kDF8jNi2roqFZ9cVlU0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.41
Date: Thu, 18 Jul 2024 13:27:10 +0200
Message-ID: <2024071810-facility-unarmored-fd64@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.41 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/cifs/usage.rst                   |   36 --
 Makefile                                                   |    2 
 arch/arm/mach-davinci/pm.c                                 |    2 
 arch/arm64/boot/dts/qcom/sa8775p.dtsi                      |    2 
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                      |   11 
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts |   15 
 arch/s390/include/asm/processor.h                          |    2 
 arch/s390/mm/pgalloc.c                                     |    4 
 arch/x86/entry/entry_64.S                                  |   23 -
 arch/x86/entry/entry_64_compat.S                           |   14 
 arch/x86/include/asm/processor.h                           |    2 
 arch/x86/kernel/cpu/common.c                               |    2 
 drivers/acpi/processor_idle.c                              |   37 --
 drivers/char/hpet.c                                        |   34 +
 drivers/cpufreq/acpi-cpufreq.c                             |    4 
 drivers/cpufreq/cpufreq.c                                  |    3 
 drivers/firmware/cirrus/cs_dsp.c                           |  227 +++++++++----
 drivers/i2c/busses/i2c-rcar.c                              |   67 ++-
 drivers/i2c/i2c-core-base.c                                |    1 
 drivers/i2c/i2c-slave-testunit.c                           |    7 
 drivers/iio/industrialio-trigger.c                         |    2 
 drivers/misc/fastrpc.c                                     |   41 +-
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c          |    4 
 drivers/net/dsa/lan9303-core.c                             |   23 -
 drivers/net/ethernet/broadcom/asp2/bcmasp.c                |    1 
 drivers/net/ethernet/intel/i40e/i40e_adminq.h              |    4 
 drivers/net/ethernet/intel/i40e/i40e_main.c                |    9 
 drivers/net/ethernet/lantiq_etop.c                         |    4 
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h           |    2 
 drivers/net/ethernet/marvell/octeontx2/af/npc.h            |    8 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c            |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c        |   23 -
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c        |   12 
 drivers/net/ethernet/mediatek/mtk_star_emac.c              |    7 
 drivers/net/ethernet/micrel/ks8851_common.c                |   10 
 drivers/net/ethernet/micrel/ks8851_spi.c                   |    4 
 drivers/net/phy/microchip_t1.c                             |    2 
 drivers/net/ppp/ppp_generic.c                              |   15 
 drivers/net/wireguard/allowedips.c                         |    4 
 drivers/net/wireguard/queueing.h                           |    4 
 drivers/net/wireguard/send.c                               |    2 
 drivers/nvmem/core.c                                       |    5 
 drivers/nvmem/meson-efuse.c                                |   14 
 drivers/nvmem/rmem.c                                       |    5 
 drivers/platform/x86/toshiba_acpi.c                        |    1 
 drivers/pmdomain/qcom/rpmhpd.c                             |    7 
 drivers/tty/serial/ma35d1_serial.c                         |   13 
 drivers/ufs/core/ufs-mcq.c                                 |   11 
 drivers/ufs/core/ufshcd.c                                  |    2 
 drivers/usb/core/config.c                                  |   18 -
 drivers/usb/core/quirks.c                                  |    3 
 drivers/usb/dwc3/dwc3-pci.c                                |    8 
 drivers/usb/gadget/configfs.c                              |    3 
 drivers/usb/host/xhci.c                                    |   16 
 drivers/usb/serial/mos7840.c                               |   45 ++
 drivers/usb/serial/option.c                                |   38 ++
 drivers/vfio/pci/vfio_pci_core.c                           |    2 
 fs/btrfs/tree-checker.c                                    |   39 ++
 fs/cachefiles/daemon.c                                     |   14 
 fs/cachefiles/internal.h                                   |   15 
 fs/cachefiles/ondemand.c                                   |   52 ++
 fs/cachefiles/xattr.c                                      |    5 
 fs/dcache.c                                                |   12 
 fs/ext4/sysfs.c                                            |    2 
 fs/locks.c                                                 |    2 
 fs/nilfs2/dir.c                                            |   32 +
 fs/smb/client/cifsglob.h                                   |    4 
 fs/smb/server/smb2pdu.c                                    |   13 
 fs/userfaultfd.c                                           |    7 
 include/linux/compiler_attributes.h                        |   12 
 include/linux/mmzone.h                                     |    3 
 include/linux/pagemap.h                                    |   11 
 include/net/tcx.h                                          |   13 
 include/uapi/misc/fastrpc.h                                |    3 
 kernel/bpf/bpf_local_storage.c                             |    4 
 kernel/bpf/helpers.c                                       |  186 +++++++---
 kernel/sched/core.c                                        |    7 
 kernel/sched/fair.c                                        |   12 
 kernel/sched/psi.c                                         |   21 -
 kernel/sched/sched.h                                       |    1 
 kernel/sched/stats.h                                       |   11 
 mm/damon/core.c                                            |   23 +
 mm/filemap.c                                               |    2 
 mm/shmem.c                                                 |   15 
 mm/vmalloc.c                                               |   10 
 net/ceph/mon_client.c                                      |   14 
 net/core/datagram.c                                        |    3 
 net/core/skmsg.c                                           |    3 
 net/ethtool/linkstate.c                                    |   41 +-
 net/ipv4/tcp_input.c                                       |   11 
 net/ipv4/tcp_timer.c                                       |   31 +
 net/ipv4/udp.c                                             |    4 
 net/sched/act_ct.c                                         |    8 
 net/sched/sch_ingress.c                                    |   12 
 net/sunrpc/xprtsock.c                                      |    7 
 scripts/ld-version.sh                                      |    8 
 sound/pci/hda/patch_realtek.c                              |    4 
 sound/soc/sof/intel/hda-dai.c                              |   12 
 tools/testing/selftests/net/gro.c                          |    3 
 tools/testing/selftests/wireguard/qemu/Makefile            |    8 
 100 files changed, 1134 insertions(+), 435 deletions(-)

Alan Stern (1):
      USB: core: Fix duplicate endpoint bug by clearing reserved bits in the descriptor

Aleksander Jan Bajkowski (1):
      net: ethernet: lantiq_etop: fix double free in detach

Aleksandr Loktionov (1):
      i40e: fix: remove needless retries of NVM update

Aleksandr Mishin (1):
      octeontx2-af: Fix incorrect value output on error path in rvu_check_rsrc_availability()

Alexandre Chartre (1):
      x86/bhi: Avoid warning in #DB handler due to BHI mitigation

Armin Wolf (1):
      platform/x86: toshiba_acpi: Fix array out-of-bounds access

Audra Mitchell (1):
      Fix userfaultfd_api to return EINVAL as expected

Baokun Li (5):
      cachefiles: propagate errors from vfs_getxattr() to avoid infinite loop
      cachefiles: stop sending new request when dropping object
      cachefiles: cancel all requests for the object that is being dropped
      cachefiles: cyclic allocation of msg_id to avoid reuse
      ext4: avoid ptr null pointer dereference

Benjamin Tissoires (2):
      bpf: make timer data struct more generic
      bpf: replace bpf_timer_init with a generic helper

Bjorn Andersson (1):
      arm64: dts: qcom: sc8180x: Fix LLCC reg property again

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

Christian Eggers (1):
      dsa: lan9303: Fix mapping between DSA port number and PHY address

Cong Zhang (1):
      arm64: dts: qcom: sa8775p: Correct IRQ number of EL2 non-secure physical timer

Dan Carpenter (2):
      net: bcmasp: Fix error code in probe()
      i2c: rcar: fix error code in probe()

Daniel Borkmann (2):
      bpf: Fix too early release of tcx_entry
      net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket

Daniele Palmas (2):
      USB: serial: option: add Telit generic core-dump composition
      USB: serial: option: add Telit FN912 rmnet compositions

Dmitry Antipov (1):
      ppp: reject claimed-as-LCP but actually malformed packets

Dmitry Smirnov (1):
      USB: serial: mos7840: fix crash on resume

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on VAIO PRO PX

Ekansh Gupta (6):
      misc: fastrpc: Fix DSP capabilities request
      misc: fastrpc: Avoid updating PD type for capability request
      misc: fastrpc: Copy the complete capability structure to user
      misc: fastrpc: Fix memory leak in audio daemon attach operation
      misc: fastrpc: Fix ownership reassignment of remote heap
      misc: fastrpc: Restrict untrusted app to attach to privileged PD

Eric Dumazet (2):
      tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()
      tcp: avoid too many retransmit packets

Gavin Shan (3):
      mm/filemap: skip to create PMD-sized page cache if needed
      mm/filemap: make MAX_PAGECACHE_ORDER acceptable to xarray
      mm/shmem: disable PMD-sized page cache if needed

Geliang Tang (1):
      skmsg: Skip zero length skb in sk_msg_recvmsg

Greg Kroah-Hartman (1):
      Linux 6.6.41

He Zhe (1):
      hpet: Support 32-bit userspace

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Panther Lake

Heiko Carstens (2):
      Compiler Attributes: Add __uninitialized macro
      s390/mm: Add NULL pointer check to crst_table_free() base_crst_free()

Helge Deller (1):
      wireguard: allowedips: avoid unaligned 64-bit memory accesses

Hobin Woo (1):
      ksmbd: discard write access to the directory open

Hou Tao (1):
      cachefiles: wait for ondemand_object_worker to finish when dropping object

Hugh Dickins (1):
      net: fix rc7's __skb_datagram_iter()

Ilya Dryomov (1):
      libceph: fix race between delayed_work() and ceph_monc_stop()

Jacky Huang (1):
      tty: serial: ma35d1: Add a NULL check for of_node

Jason A. Donenfeld (3):
      wireguard: selftests: use acpi=off instead of -no-acpi for recent QEMU
      wireguard: queueing: annotate intentional data race in cpu round robin
      wireguard: send: annotate intentional data race in checking empty queue

Jeff Layton (1):
      filelock: fix potential use-after-free in posix_lock_inode

Jia Zhu (1):
      cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode

Jian Hui Lee (1):
      net: ethernet: mtk-star-emac: set mac_managed_pm when probing

Jingbo Xu (1):
      cachefiles: add missing lock protection when polling

Johan Hovold (1):
      arm64: dts: qcom: sc8280xp-x13s: fix touchscreen power on

John Hubbard (1):
      selftests/net: fix gro.c compilation failure due to non-existent opt_ipproto_off

John Stultz (1):
      sched: Move psi_account_irqtime() out of update_rq_clock_task() hotpath

Josh Don (1):
      Revert "sched/fair: Make sure to try to detach at least one movable task"

Joy Chakraborty (3):
      misc: microchip: pci1xxxx: Fix return value of nvmem callbacks
      nvmem: rmem: Fix return value of rmem_read()
      nvmem: meson-efuse: Fix return value of nvmem callbacks

João Paulo Gonçalves (1):
      iio: trigger: Fix condition for own trigger

Kai Vehmanen (1):
      ASoC: SOF: Intel: hda: fix null deref on system suspend entry

Kiran Kumar K (1):
      octeontx2-af: fix issue with IPv6 ext match for RSS

Kuan-Wei Chiu (1):
      ACPI: processor_idle: Fix invalid comparison with insertion sort for latency

Kumar Kartikeya Dwivedi (1):
      bpf: Fail bpf_timer_cancel when callback is being cancelled

Kuniyuki Iwashima (1):
      udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().

Lee Jones (1):
      usb: gadget: configfs: Prevent OOB read/write in usb_string_copy()

Mank Wang (1):
      USB: serial: option: add Netprisma LCUK54 series modules

Mario Limonciello (2):
      cpufreq: ACPI: Mark boost policy as enabled when setting boost
      cpufreq: Allow drivers to advertise boost enabled

Mathias Nyman (1):
      xhci: always resume roothubs if xHC was reset during resume

Michal Kubiak (1):
      i40e: Fix XDP program unloading while removing the driver

Michal Mazur (1):
      octeontx2-af: fix detection of IP layer

Michał Kopeć (1):
      ALSA: hda/realtek: add quirk for Clevo V5[46]0TU

Mohammad Shehar Yaar Tausif (1):
      bpf: fix order of args in call to bpf_map_kvcalloc

Nathan Chancellor (1):
      kbuild: Make ld-version.sh more robust against version string changes

Nazar Bilinskyi (1):
      ALSA: hda/realtek: Enable Mute LED on HP 250 G7

Neal Cardwell (1):
      tcp: fix incorrect undo caused by DSACK of TLP retransmit

Nikolay Borisov (1):
      x86/entry: Rename ignore_sysret()

Nithin Dabilpuram (1):
      octeontx2-af: replace cpt slot with lf id on reg write

Oleksij Rempel (2):
      net: phy: microchip: lan87xx: reinit PHY after cable test
      ethtool: netlink: do not return SQI value if link is down

Peter Wang (2):
      scsi: ufs: core: Fix ufshcd_clear_cmd racing issue
      scsi: ufs: core: Fix ufshcd_abort_one racing issue

Qu Wenruo (1):
      btrfs: tree-checker: add type and sequence check for inline backrefs

Richard Fitzgerald (5):
      firmware: cs_dsp: Fix overflow checking of wmfw header
      firmware: cs_dsp: Return error if block header overflows file
      firmware: cs_dsp: Validate payload length before processing block
      firmware: cs_dsp: Prevent buffer overrun when processing V2 alg headers
      firmware: cs_dsp: Use strnlen() on name fields in V1 wmfw files

Ronald Wahl (2):
      net: ks8851: Fix deadlock with the SPI chip variant
      net: ks8851: Fix potential TX stall after interface reopen

Ryusuke Konishi (1):
      nilfs2: fix kernel bug on rename operation of broken directory

Satheesh Paul (1):
      octeontx2-af: fix issue with IPv4 match for RSS

SeongJae Park (1):
      mm/damon/core: merge regions aggressively when max_nr_regions is unmet

Slark Xiao (1):
      USB: serial: option: add support for Foxconn T99W651

Srujana Challa (1):
      octeontx2-af: fix a issue with cpt_lf_alloc mailbox

Steve French (1):
      cifs: fix setting SecurityFlags to true

Sven Schnelle (1):
      s390: Mark psw in __load_psw_mask() as __unitialized

Taniya Das (1):
      pmdomain: qcom: rpmhpd: Skip retention level for Power Domains

Thomas Weißschuh (1):
      nvmem: core: only change name to fram for current attribute

Uladzislau Rezki (Sony) (1):
      mm: vmalloc: check if a hash-index is in cpu_possible_mask

Vanillan Wang (1):
      USB: serial: option: add Rolling RW350-GL variants

Waiman Long (1):
      mm: prevent derefencing NULL ptr in pfn_section_valid()

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

Yi Liu (1):
      vfio/pci: Init the count variable in collecting hot-reset devices

linke li (1):
      fs/dcache: Re-use value stored to dentry->d_flags instead of re-reading


