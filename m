Return-Path: <stable+bounces-45381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3086F8C85EE
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 13:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543091C22121
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 11:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BE841A89;
	Fri, 17 May 2024 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gYqQwpLl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737333FBAF;
	Fri, 17 May 2024 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947085; cv=none; b=QnjuqYJ75+lVNc/FD4t1ptx+//LDsCJoBLtk5x7VfGq14HO147vrE13Kv0VZsBm4cN0ikzxmEVqFu8pfxSzXZi4tN4BNCSNQIFIZSTY3tQhyoyLUcDaVpUx4cP5oLaTX15QKyKaCdBvbTCrCWyRPSKLVTaizNixXcA0G10DZBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947085; c=relaxed/simple;
	bh=X0DoSeZNi9qdmXE+UEIUcu6kjp7pLIjupXs3SQMJ/fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p9KxRQoEBJ/1ZlTp7+QoHS2T+2K7Zq2gLnW3Y62USy6pemjGOBut6gpLd5s6Iod4o25A5RCy20h2QC9gOS8K3Xxwj8mUEaFDzcHd0GIUjy4RMXMN372N9jjmE9Nc0zhl1FtA+SeRTRTt184YiVI3Bm+r/coxHlZtGzYwSUyeB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gYqQwpLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B3AC4AF07;
	Fri, 17 May 2024 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715947085;
	bh=X0DoSeZNi9qdmXE+UEIUcu6kjp7pLIjupXs3SQMJ/fc=;
	h=From:To:Cc:Subject:Date:From;
	b=gYqQwpLlN/PsEpnS9TFhNRUGbX2ZSrMf/2ci0v4IT9SV+xglkI6VZ9IIXfrIT4kg/
	 yWzmWq56zrMLffybQc1r0Mj03aLVqobRJKovy53XZQXjl/0xwpWXUIE1FoBBW8PJBH
	 gqNt4d6wmVr1gRjgtbxBu7nTM84XOj9/PcVZ77kQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.276
Date: Fri, 17 May 2024 13:57:57 +0200
Message-ID: <2024051757-reliably-prudishly-a1cf@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.276 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                         |    2 
 arch/mips/include/asm/ptrace.h                   |    2 
 arch/mips/kernel/asm-offsets.c                   |    1 
 arch/mips/kernel/ptrace.c                        |   15 -
 arch/mips/kernel/scall32-o32.S                   |   23 +
 arch/mips/kernel/scall64-n32.S                   |    3 
 arch/mips/kernel/scall64-n64.S                   |    3 
 arch/mips/kernel/scall64-o32.S                   |   33 +-
 arch/s390/mm/gmap.c                              |    2 
 arch/s390/mm/hugetlbpage.c                       |    2 
 drivers/ata/sata_gemini.c                        |    5 
 drivers/clk/clk.c                                |   12 
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c             |   19 +
 drivers/firewire/nosy.c                          |    6 
 drivers/firewire/ohci.c                          |    6 
 drivers/gpio/gpio-crystalcove.c                  |    2 
 drivers/gpio/gpio-wcove.c                        |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c            |    2 
 drivers/gpu/host1x/bus.c                         |    8 
 drivers/net/dsa/mv88e6xxx/chip.c                 |   29 ++
 drivers/net/dsa/mv88e6xxx/chip.h                 |    6 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c   |   16 -
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c  |    4 
 drivers/net/ethernet/qlogic/qede/qede_filter.c   |   15 -
 drivers/net/usb/qmi_wwan.c                       |    1 
 drivers/pinctrl/core.c                           |    8 
 drivers/pinctrl/devicetree.c                     |   10 
 drivers/pinctrl/mediatek/pinctrl-mt6765.c        |   11 
 drivers/pinctrl/mediatek/pinctrl-mt8183.c        |    7 
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |  268 +++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h |   16 +
 drivers/pinctrl/mediatek/pinctrl-paris.c         |  281 +++++++++--------------
 drivers/power/supply/rt9455_charger.c            |    2 
 drivers/regulator/core.c                         |   27 +-
 drivers/scsi/bnx2fc/bnx2fc_tgt.c                 |    2 
 drivers/scsi/lpfc/lpfc.h                         |    1 
 drivers/scsi/lpfc/lpfc_scsi.c                    |   13 -
 drivers/target/target_core_configfs.c            |   12 
 drivers/usb/gadget/composite.c                   |    6 
 drivers/usb/gadget/function/f_fs.c               |    2 
 fs/9p/vfs_file.c                                 |    2 
 fs/9p/vfs_inode.c                                |    5 
 fs/9p/vfs_super.c                                |    1 
 fs/btrfs/inode.c                                 |    2 
 fs/btrfs/transaction.c                           |    2 
 fs/gfs2/bmap.c                                   |    5 
 fs/nfs/client.c                                  |    5 
 fs/nfs/inode.c                                   |   13 -
 fs/nfs/internal.h                                |    2 
 fs/nfs/netns.h                                   |    2 
 include/linux/skbuff.h                           |   15 +
 include/linux/sunrpc/clnt.h                      |    1 
 include/net/xfrm.h                               |    3 
 lib/dynamic_debug.c                              |    6 
 net/bluetooth/l2cap_core.c                       |    3 
 net/bluetooth/sco.c                              |    4 
 net/bridge/br_forward.c                          |    9 
 net/core/net_namespace.c                         |   13 -
 net/core/rtnetlink.c                             |    2 
 net/core/sock.c                                  |    4 
 net/ipv4/tcp.c                                   |    4 
 net/ipv4/tcp_input.c                             |    2 
 net/ipv4/tcp_ipv4.c                              |    8 
 net/ipv4/tcp_output.c                            |    4 
 net/ipv4/xfrm4_input.c                           |    6 
 net/ipv6/fib6_rules.c                            |    6 
 net/ipv6/xfrm6_input.c                           |    6 
 net/l2tp/l2tp_eth.c                              |    3 
 net/mac80211/ieee80211_i.h                       |    4 
 net/nsh/nsh.c                                    |   14 -
 net/phonet/pn_netlink.c                          |    2 
 net/sunrpc/clnt.c                                |    5 
 net/tipc/msg.c                                   |    8 
 net/wireless/nl80211.c                           |    2 
 net/wireless/trace.h                             |    2 
 net/xfrm/xfrm_input.c                            |    8 
 sound/usb/line6/driver.c                         |    6 
 tools/power/x86/turbostat/turbostat.8            |    2 
 tools/power/x86/turbostat/turbostat.c            |    7 
 tools/testing/selftests/timers/valid-adjtimex.c  |   73 ++---
 80 files changed, 762 insertions(+), 394 deletions(-)

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

Asbjørn Sloth Tønnesen (3):
      net: qede: use return from qede_parse_flow_attr() for flow_spec
      net: qede: sanitize 'rc' in qede_add_tc_flower_fltr()
      net: qede: use return from qede_parse_flow_attr() for flower

Boris Burkov (2):
      btrfs: make btrfs_clear_delalloc_extent() free delalloc reserve
      btrfs: always clear PERTRANS metadata during commit

Bui Quang Minh (1):
      bna: ensure the copied buf is NUL terminated

Bumyong Lee (1):
      dmaengine: pl330: issue_pending waits until WFP state

Chen Ni (1):
      ata: sata_gemini: Check clk_enable() result

Chen-Yu Tsai (4):
      pinctrl: mediatek: paris: Fix PIN_CONFIG_BIAS_* readback
      pinctrl: mediatek: paris: Rework mtk_pinconf_{get,set} switch/case logic
      pinctrl: mediatek: paris: Rework support for PIN_CONFIG_{INPUT,OUTPUT}_ENABLE
      pinctrl: mediatek: paris: Fix PIN_CONFIG_INPUT_SCHMITT_ENABLE readback

Chris Wulff (1):
      usb: gadget: f_fs: Fix a race condition when processing setup packets.

Claudio Imbrenda (2):
      s390/mm: Fix storage key clearing for guest huge pages
      s390/mm: Fix clearing storage keys for huge pages

Dan Carpenter (2):
      pinctrl: core: delete incorrect free in pinctrl_enable()
      pinctrl: mediatek: Fix some off by one bugs

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

Felix Fietkau (2):
      net: bridge: fix multicast-to-unicast with fraglist GSO
      net: bridge: fix corrupted ethernet header on multicast-to-unicast

Greg Kroah-Hartman (1):
      Linux 5.4.276

Hsin-Yi Wang (2):
      pinctrl: mediatek: Fix fallback call path
      pinctrl: mediatek: Fix fallback behavior for bias_set_combo

Igor Artemiev (1):
      wifi: cfg80211: fix rdev_dump_mpp() arguments order

Jeff Johnson (1):
      wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc

Jeff Layton (1):
      9p: explicitly deny setlease attempts

Jernej Skrabec (1):
      clk: sunxi-ng: h6: Reparent CPUX during PLL CPUX rate change

Jiaxun Yang (1):
      MIPS: scall: Save thread_info.syscall unconditionally on entry

Jim Cromie (1):
      dyndbg: fix old BUG_ON in >control parser

Joakim Sindholt (3):
      fs/9p: only translate RWX permissions for plain 9P2000
      fs/9p: translate O_TRUNC into OTRUNC
      fs/9p: drop inodes immediately on non-.L too

Johan Hovold (1):
      regulator: core: fix debugfs creation regression

Johannes Berg (1):
      wifi: nl80211: don't free NULL coalescing rule

John Stultz (1):
      selftests: timers: Fix valid-adjtimex signed left-shift undefined behavior

Josef Bacik (3):
      sunrpc: add a struct rpc_stats arg to rpc_create_args
      nfs: expose /proc/net/sunrpc/nfs in net namespaces
      nfs: make the rpc_stat per net namespace

Justin Tee (1):
      scsi: lpfc: Update lpfc_ramp_down_queue_handler() logic

Kuniyuki Iwashima (3):
      nfs: Handle error of rpc_proc_register() in nfs_net_init().
      nsh: Restore skb->{protocol,data,mac_header} for outer header in nsh_gso_segment().
      tcp: Use refcount_inc_not_zero() in tcp_twsk_unique().

Light Hsieh (6):
      pinctrl: mediatek: Check gpio pin number and use binary search in mtk_hw_pin_field_lookup()
      pinctrl: mediatek: Supporting driving setting without mapping current to register value
      pinctrl: mediatek: Refine mtk_pinconf_get() and mtk_pinconf_set()
      pinctrl: mediatek: Refine mtk_pinconf_get()
      pinctrl: mediatek: Backward compatible to previous Mediatek's bias-pull usage
      pinctrl: mediatek: remove shadow variable declaration

Marek Behún (1):
      net: dsa: mv88e6xxx: Fix number of databases for 88E6141 / 88E6341

Maurizio Lombardi (1):
      scsi: target: Fix SELinux error when systemd-modules loads the target module

Paolo Abeni (1):
      tipc: fix UAF in error path

Paul Davey (1):
      xfrm: Preserve vlan tags for transport mode software GRO

Peng Liu (1):
      tools/power turbostat: Fix Bzy_MHz documentation typo

Peter Korsgaard (1):
      usb: gadget: composite: fix OS descriptors w_value logic

Phil Elwell (1):
      net: bcmgenet: Reset RBUF on first open

Roded Zats (1):
      rtnetlink: Correct nested IFLA_VF_VLAN_LIST attribute validation

Saurav Kashyap (1):
      scsi: bnx2fc: Remove spin_lock_bh while releasing resources after upload

Stephen Boyd (1):
      clk: Don't hold prepare_lock when calling kref_put()

Takashi Iwai (1):
      ALSA: line6: Zero-initialize message buffers

Thadeu Lima de Souza Cascardo (1):
      net: fix out-of-bounds access in ops_init

Thanassis Avgerinos (1):
      firewire: nosy: ensure user_length is taken into account when fetching packet contents

Thierry Reding (1):
      gpu: host1x: Do not setup DMA for virtual devices

Vanillan Wang (1):
      net:usb:qmi_wwan: support Rolling modules

Vinod Koul (1):
      dmaengine: Revert "dmaengine: pl330: issue_pending waits until WFP state"

Xin Long (1):
      tipc: fix a possible memleak in tipc_buf_append

YueHaibing (1):
      pinctrl: mediatek: remove set but not used variable 'e'

Zack Rusin (1):
      drm/vmwgfx: Fix invalid reads in fence signaled events

Zeng Heng (1):
      pinctrl: devicetree: fix refcount leak in pinctrl_dt_to_map()

linke li (1):
      net: mark racy access on sk->sk_rcvbuf


