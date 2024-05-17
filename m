Return-Path: <stable+bounces-45379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5336B8C85EB
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 13:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A33285F25
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 11:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448CF3FB89;
	Fri, 17 May 2024 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YZOkO9KC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6326AFF;
	Fri, 17 May 2024 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947076; cv=none; b=MWER0fyy6Xr29S54qQAGeSNryzNCPV7+uRGO1UTjiXEKLcl6bK5mX5hVOeElljJw/P55g1zJsvnE/SC/DuweSFbRehDRElGi0he88zsN9yUCO9j8A56kx3Il7z+OA4KplUmd96yyIO0RKi343Lf9ITElsy6pVuzcGEzYrNX2PuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947076; c=relaxed/simple;
	bh=QwaETOEYUiNejsIl/KRo0Nw0ymsCqN+bO0be6shKLEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rnQmvmUif5vfQmWKk/2SIxumqOhMo3++w0G0f8q75bLya4i9DGtU0FGUsS5ibbCA46nwhcUvrCxejrdQOAC9EASohniEnYoR3QDiMNDTDS+mILavio3Av/En2bwPxMDixYLDcdY6TBuKayURVySgcXfI48orzHstNlBBpwl7BTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YZOkO9KC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF76C2BD10;
	Fri, 17 May 2024 11:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715947075;
	bh=QwaETOEYUiNejsIl/KRo0Nw0ymsCqN+bO0be6shKLEI=;
	h=From:To:Cc:Subject:Date:From;
	b=YZOkO9KCCynlfVyLPtvAuG+x25FU2hs0F/l8nfazJzmu85PVqCed6yx7m0JyUvJdw
	 NGvPUWvUlMSsQYV8gE6oZPBYuR5BYmd+y6GwfCjv2FbaBzKS7RCfUrrtlSeaevZMCD
	 2eWr+ryt3fRQOzDfyYgqfTrEsUCQGdVq/woUyPN0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.314
Date: Fri, 17 May 2024 13:57:50 +0200
Message-ID: <2024051751-exclusion-exorcist-9bbb@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.314 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                         |    2 
 arch/s390/mm/gmap.c                              |    2 
 arch/s390/mm/hugetlbpage.c                       |    2 
 drivers/ata/sata_gemini.c                        |    5 -
 drivers/firewire/nosy.c                          |    6 -
 drivers/firewire/ohci.c                          |    6 +
 drivers/gpio/gpio-crystalcove.c                  |    2 
 drivers/gpio/gpio-wcove.c                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  100 +++++++++++++----------
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c            |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                 |   29 ++++++
 drivers/net/dsa/mv88e6xxx/chip.h                 |    6 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c   |   16 ++-
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c  |    4 
 drivers/net/usb/qmi_wwan.c                       |    1 
 drivers/pinctrl/core.c                           |    8 -
 drivers/pinctrl/devicetree.c                     |   10 +-
 drivers/power/supply/rt9455_charger.c            |    2 
 drivers/scsi/bnx2fc/bnx2fc_tgt.c                 |    2 
 drivers/scsi/lpfc/lpfc.h                         |    1 
 drivers/scsi/lpfc/lpfc_scsi.c                    |   13 --
 drivers/target/target_core_configfs.c            |   12 ++
 drivers/usb/gadget/composite.c                   |    6 -
 drivers/usb/gadget/function/f_fs.c               |    2 
 fs/9p/vfs_file.c                                 |    2 
 fs/9p/vfs_inode.c                                |    5 -
 fs/9p/vfs_super.c                                |    1 
 fs/btrfs/inode.c                                 |    2 
 fs/btrfs/transaction.c                           |    2 
 fs/gfs2/bmap.c                                   |    5 -
 include/linux/etherdevice.h                      |   46 ++++++++++
 include/net/af_unix.h                            |    5 -
 lib/dynamic_debug.c                              |    6 +
 net/bluetooth/l2cap_core.c                       |    3 
 net/bluetooth/sco.c                              |    4 
 net/bridge/br_forward.c                          |    9 +-
 net/core/net_namespace.c                         |   13 ++
 net/core/rtnetlink.c                             |    2 
 net/core/sock.c                                  |    4 
 net/ethernet/eth.c                               |   10 --
 net/ipv4/tcp.c                                   |    4 
 net/ipv4/tcp_input.c                             |    2 
 net/ipv4/tcp_ipv4.c                              |    8 +
 net/ipv4/tcp_output.c                            |   11 +-
 net/ipv6/fib6_rules.c                            |    6 +
 net/l2tp/l2tp_eth.c                              |    3 
 net/mac80211/ieee80211_i.h                       |    4 
 net/nsh/nsh.c                                    |   14 +--
 net/phonet/pn_netlink.c                          |    2 
 net/tipc/msg.c                                   |    8 +
 net/unix/af_unix.c                               |    4 
 net/unix/garbage.c                               |   35 +++++---
 net/unix/scm.c                                   |    8 +
 net/wireless/nl80211.c                           |    2 
 sound/usb/line6/driver.c                         |    6 -
 tools/power/x86/turbostat/turbostat.8            |    2 
 tools/power/x86/turbostat/turbostat.c            |    7 -
 tools/testing/selftests/timers/valid-adjtimex.c  |   73 ++++++++--------
 58 files changed, 369 insertions(+), 190 deletions(-)

Adam Goldman (1):
      firewire: ohci: mask bus reset interrupts between ISR and bottom half

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Add number of MACs in the ATU

Andrew Price (1):
      gfs2: Fix invalid metadata access in punch_hole

Andy Shevchenko (2):
      gpio: wcove: Use -ENOTSUPP consistently
      gpio: crystalcove: Use -ENOTSUPP consistently

Arnd Bergmann (1):
      power: rt9455: hide unused rt9455_boost_voltage_values

Boris Burkov (2):
      btrfs: make btrfs_clear_delalloc_extent() free delalloc reserve
      btrfs: always clear PERTRANS metadata during commit

Bui Quang Minh (1):
      bna: ensure the copied buf is NUL terminated

Bumyong Lee (1):
      dmaengine: pl330: issue_pending waits until WFP state

Chen Ni (1):
      ata: sata_gemini: Check clk_enable() result

Chris Wulff (1):
      usb: gadget: f_fs: Fix a race condition when processing setup packets.

Claudio Imbrenda (2):
      s390/mm: Fix storage key clearing for guest huge pages
      s390/mm: Fix clearing storage keys for huge pages

Colin Ian King (1):
      tcp: remove redundant check on tskb

Dan Carpenter (1):
      pinctrl: core: delete incorrect free in pinctrl_enable()

David Bauer (1):
      net l2tp: drop flow hash on forward

Doug Smythies (1):
      tools/power turbostat: Fix added raw MSR output

Duoming Zhou (2):
      Bluetooth: Fix use-after-free bugs caused by sco_sock_timeout
      Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout

Eric Dumazet (3):
      tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets
      phonet: fix rtm_phonet_notify() skb allocation
      ipv6: fib6_rules: avoid possible NULL dereference in fib6_rule_action()

Eric Huang (1):
      drm/amdkfd: change system memory overcommit limit

Felix Fietkau (2):
      net: bridge: fix multicast-to-unicast with fraglist GSO
      net: bridge: fix corrupted ethernet header on multicast-to-unicast

Greg Kroah-Hartman (1):
      Linux 4.19.314

Jakub Kicinski (1):
      ethernet: add a helper for assigning port addresses

Jeff Johnson (1):
      wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc

Jeff Layton (1):
      9p: explicitly deny setlease attempts

Jim Cromie (1):
      dyndbg: fix old BUG_ON in >control parser

Joakim Sindholt (3):
      fs/9p: only translate RWX permissions for plain 9P2000
      fs/9p: translate O_TRUNC into OTRUNC
      fs/9p: drop inodes immediately on non-.L too

Johannes Berg (1):
      wifi: nl80211: don't free NULL coalescing rule

John Stultz (1):
      selftests: timers: Fix valid-adjtimex signed left-shift undefined behavior

Justin Tee (1):
      scsi: lpfc: Update lpfc_ramp_down_queue_handler() logic

Kuniyuki Iwashima (4):
      nsh: Restore skb->{protocol,data,mac_header} for outer header in nsh_gso_segment().
      tcp: Use refcount_inc_not_zero() in tcp_twsk_unique().
      af_unix: Do not use atomic ops for unix_sk(sk)->inflight.
      af_unix: Suppress false-positive lockdep splat for spin_lock() in __unix_gc().

Li RongQing (1):
      net: slightly optimize eth_type_trans

Marek Behún (1):
      net: dsa: mv88e6xxx: Fix number of databases for 88E6141 / 88E6341

Maurizio Lombardi (1):
      scsi: target: Fix SELinux error when systemd-modules loads the target module

Michal Luczaj (1):
      af_unix: Fix garbage collector racing against connect()

Mukul Joshi (1):
      drm/amdgpu: Fix leak when GPU memory allocation fails

Paolo Abeni (1):
      tipc: fix UAF in error path

Peng Liu (1):
      tools/power turbostat: Fix Bzy_MHz documentation typo

Peter Korsgaard (1):
      usb: gadget: composite: fix OS descriptors w_value logic

Phil Elwell (1):
      net: bcmgenet: Reset RBUF on first open

Rahul Rameshbabu (1):
      ethernet: Add helper for assigning packet type when dest address does not match device address

Roded Zats (1):
      rtnetlink: Correct nested IFLA_VF_VLAN_LIST attribute validation

Saurav Kashyap (1):
      scsi: bnx2fc: Remove spin_lock_bh while releasing resources after upload

Takashi Iwai (1):
      ALSA: line6: Zero-initialize message buffers

Thadeu Lima de Souza Cascardo (1):
      net: fix out-of-bounds access in ops_init

Thanassis Avgerinos (1):
      firewire: nosy: ensure user_length is taken into account when fetching packet contents

Vanillan Wang (1):
      net:usb:qmi_wwan: support Rolling modules

Vinod Koul (1):
      dmaengine: Revert "dmaengine: pl330: issue_pending waits until WFP state"

Xin Long (1):
      tipc: fix a possible memleak in tipc_buf_append

Zack Rusin (1):
      drm/vmwgfx: Fix invalid reads in fence signaled events

Zeng Heng (1):
      pinctrl: devicetree: fix refcount leak in pinctrl_dt_to_map()

linke li (1):
      net: mark racy access on sk->sk_rcvbuf


