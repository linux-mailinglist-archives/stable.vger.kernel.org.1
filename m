Return-Path: <stable+bounces-45383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4408C85F2
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 13:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC581C21AA4
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 11:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282EF40BFE;
	Fri, 17 May 2024 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X72ZrJ9E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D7D4597F;
	Fri, 17 May 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947091; cv=none; b=G9QnhvIEc9LnDDIXaHpJqDd6r4W9USIpySOLtfYo6vEsVUO032j37me0wGWOuqMGbB2iIaR6WfUTkUfHQ/rjiYSLl7Sup4u64wbemg6DOdbzi2kO4/DEoiiFjiao8EMKoy+JpfLyFwTJ9ciTr/h9U7jTgDZ3USzONOwHcpqoDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947091; c=relaxed/simple;
	bh=MKOJ5DA+zMjO65j2nGhEpKwY1Z1t9EHpzsI22IxgK34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Plw7Jlnoomzr6lgW6Fapir4umok3KMSyt+r81eUKh6nidqHA8HqmpYa2GmEF081UEnK3ulcMxhj7s7f9GCCrVncFw3f1QsompwbKnkhvjJW+J0YJdgCQP19dAwTeZTiWokUy1fzc8PvNlBxdJykyTWfO908pprCEt5i0rGoNa38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X72ZrJ9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A015C2BD11;
	Fri, 17 May 2024 11:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715947091;
	bh=MKOJ5DA+zMjO65j2nGhEpKwY1Z1t9EHpzsI22IxgK34=;
	h=From:To:Cc:Subject:Date:From;
	b=X72ZrJ9EQFWMT/vR+kUn66jPvXBp5dmoEbRQTlJOtHs+GZhXcZucVKAVhtP00RQLY
	 Ihw3xHktTbh+U3Og+xR47PFaJOzFNkih8Qzc+V5cEJsVQ3716c3GqAXI35KSgxDr7N
	 4HQh/2KlOJtJnXQm0twsmuLQnw6RtkOucOUIBJ2A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.217
Date: Fri, 17 May 2024 13:58:03 +0200
Message-ID: <2024051704-sufferer-unviable-16bf@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.217 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                  |    2 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                     |    8 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                      |   16 -
 arch/arm64/kvm/vgic/vgic-kvm-device.c                     |   12 
 arch/mips/include/asm/ptrace.h                            |    2 
 arch/mips/kernel/asm-offsets.c                            |    1 
 arch/mips/kernel/ptrace.c                                 |   15 -
 arch/mips/kernel/scall32-o32.S                            |   23 +
 arch/mips/kernel/scall64-n32.S                            |    3 
 arch/mips/kernel/scall64-n64.S                            |    3 
 arch/mips/kernel/scall64-o32.S                            |   33 +-
 arch/s390/include/asm/dwarf.h                             |    1 
 arch/s390/kernel/vdso64/vdso_user_wrapper.S               |    2 
 arch/s390/mm/gmap.c                                       |    2 
 arch/s390/mm/hugetlbpage.c                                |    2 
 block/blk-iocost.c                                        |    7 
 drivers/ata/sata_gemini.c                                 |    5 
 drivers/clk/clk.c                                         |   12 
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c                      |   19 +
 drivers/firewire/nosy.c                                   |    6 
 drivers/firewire/ohci.c                                   |    6 
 drivers/gpio/gpio-crystalcove.c                           |    2 
 drivers/gpio/gpio-wcove.c                                 |    2 
 drivers/gpu/drm/nouveau/nouveau_dp.c                      |   13 -
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c                     |    2 
 drivers/gpu/host1x/bus.c                                  |    8 
 drivers/hwmon/corsair-cpro.c                              |   45 ++-
 drivers/hwmon/pmbus/ucd9000.c                             |    6 
 drivers/iio/accel/mxc4005.c                               |   24 +
 drivers/iio/imu/adis16475.c                               |    4 
 drivers/md/md.c                                           |    1 
 drivers/misc/eeprom/at24.c                                |   46 ++-
 drivers/misc/mei/hw-me-regs.h                             |    2 
 drivers/misc/mei/pci-me.c                                 |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                          |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c            |   20 +
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c           |    4 
 drivers/net/ethernet/chelsio/cxgb4/sge.c                  |    6 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c   |    4 
 drivers/net/ethernet/qlogic/qede/qede_filter.c            |   14 -
 drivers/net/usb/qmi_wwan.c                                |    1 
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c                |   34 +-
 drivers/pinctrl/core.c                                    |    8 
 drivers/pinctrl/devicetree.c                              |   10 
 drivers/pinctrl/mediatek/pinctrl-paris.c                  |  180 +++++---------
 drivers/pinctrl/meson/pinctrl-meson-a1.c                  |    6 
 drivers/power/supply/rt9455_charger.c                     |    2 
 drivers/regulator/core.c                                  |   27 +-
 drivers/regulator/mt6360-regulator.c                      |   32 +-
 drivers/scsi/bnx2fc/bnx2fc_tgt.c                          |    2 
 drivers/scsi/lpfc/lpfc.h                                  |    1 
 drivers/scsi/lpfc/lpfc_scsi.c                             |   13 -
 drivers/target/target_core_configfs.c                     |   12 
 drivers/usb/core/hub.c                                    |    5 
 drivers/usb/dwc3/core.c                                   |   90 ++-----
 drivers/usb/dwc3/core.h                                   |    1 
 drivers/usb/dwc3/gadget.c                                 |    2 
 drivers/usb/dwc3/host.c                                   |   27 ++
 drivers/usb/gadget/composite.c                            |    6 
 drivers/usb/gadget/function/f_fs.c                        |    2 
 drivers/usb/host/ohci-hcd.c                               |    8 
 drivers/usb/host/xhci-plat.h                              |    4 
 drivers/usb/typec/ucsi/ucsi.c                             |   12 
 drivers/usb/usbip/usbip_common.h                          |    1 
 fs/9p/vfs_file.c                                          |    2 
 fs/9p/vfs_inode.c                                         |    5 
 fs/9p/vfs_super.c                                         |    1 
 fs/btrfs/inode.c                                          |    2 
 fs/btrfs/send.c                                           |    4 
 fs/btrfs/transaction.c                                    |    2 
 fs/btrfs/volumes.c                                        |   17 -
 fs/gfs2/bmap.c                                            |    5 
 fs/nfs/client.c                                           |    5 
 fs/nfs/inode.c                                            |   13 -
 fs/nfs/internal.h                                         |    2 
 fs/nfs/netns.h                                            |    2 
 include/linux/kcov.h                                      |    1 
 include/linux/sched.h                                     |    1 
 include/linux/skbuff.h                                    |   15 +
 include/linux/sunrpc/clnt.h                               |    1 
 include/net/xfrm.h                                        |    3 
 lib/dynamic_debug.c                                       |    6 
 net/bluetooth/l2cap_core.c                                |    3 
 net/bluetooth/sco.c                                       |    4 
 net/bridge/br_forward.c                                   |    9 
 net/core/net_namespace.c                                  |   13 -
 net/core/rtnetlink.c                                      |    2 
 net/core/skbuff.c                                         |   28 +-
 net/core/sock.c                                           |    4 
 net/ipv4/tcp.c                                            |    4 
 net/ipv4/tcp_input.c                                      |    2 
 net/ipv4/tcp_ipv4.c                                       |    8 
 net/ipv4/tcp_output.c                                     |    4 
 net/ipv4/udp_offload.c                                    |   12 
 net/ipv4/xfrm4_input.c                                    |    6 
 net/ipv6/fib6_rules.c                                     |    6 
 net/ipv6/xfrm6_input.c                                    |    6 
 net/l2tp/l2tp_eth.c                                       |    3 
 net/mac80211/ieee80211_i.h                                |    4 
 net/mac80211/iface.c                                      |    1 
 net/mac80211/rx.c                                         |    1 
 net/nsh/nsh.c                                             |   14 -
 net/phonet/pn_netlink.c                                   |    2 
 net/sunrpc/clnt.c                                         |    5 
 net/tipc/msg.c                                            |    8 
 net/wireless/nl80211.c                                    |    2 
 net/wireless/trace.h                                      |    2 
 net/xfrm/xfrm_input.c                                     |    8 
 security/keys/key.c                                       |    3 
 sound/pci/hda/patch_realtek.c                             |    1 
 sound/soc/codecs/Kconfig                                  |   18 -
 sound/soc/generic/Kconfig                                 |    2 
 sound/soc/intel/boards/Kconfig                            |    2 
 sound/soc/meson/Kconfig                                   |    3 
 sound/soc/pxa/Kconfig                                     |   14 -
 sound/soc/tegra/tegra186_dspk.c                           |    7 
 sound/usb/line6/driver.c                                  |    6 
 tools/power/x86/turbostat/turbostat.8                     |    2 
 tools/power/x86/turbostat/turbostat.c                     |    7 
 tools/testing/selftests/timers/valid-adjtimex.c           |   73 ++---
 122 files changed, 757 insertions(+), 510 deletions(-)

Adam Goldman (1):
      firewire: ohci: mask bus reset interrupts between ISR and bottom half

Alan Stern (1):
      usb: Fix regression caused by invalid ep0 maxpacket in virtual SuperSpeed device

Aleksa Savic (3):
      hwmon: (corsair-cpro) Use a separate buffer for sending commands
      hwmon: (corsair-cpro) Use complete_all() instead of complete() in ccp_raw_event()
      hwmon: (corsair-cpro) Protect ccp->wait_input_report with a spinlock

Alexander Stein (1):
      eeprom: at24: Use dev_err_probe for nvmem register failure

Alexander Usyskin (1):
      mei: me: add lunar lake point M DID

Aman Dhoot (1):
      ALSA: hda/realtek: Fix mute led of HP Laptop 15-da3001TU

Anand Jain (1):
      btrfs: return accurate error code on open failure in open_fs_devices()

Andrew Price (1):
      gfs2: Fix invalid metadata access in punch_hole

Andy Shevchenko (2):
      gpio: wcove: Use -ENOTSUPP consistently
      gpio: crystalcove: Use -ENOTSUPP consistently

AngeloGioacchino Del Regno (1):
      regulator: mt6360: De-capitalize devicetree regulator subnodes

Arnd Bergmann (1):
      power: rt9455: hide unused rt9455_boost_voltage_values

Asbjørn Sloth Tønnesen (4):
      net: qede: sanitize 'rc' in qede_add_tc_flower_fltr()
      net: qede: use return from qede_parse_flow_attr() for flower
      net: qede: use return from qede_parse_flow_attr() for flow_spec
      net: qede: use return from qede_parse_actions()

Billy Tsai (1):
      pinctrl: pinctrl-aspeed-g6: Fix register offset for pinconf of GPIOR-T

Boris Burkov (2):
      btrfs: make btrfs_clear_delalloc_extent() free delalloc reserve
      btrfs: always clear PERTRANS metadata during commit

Bui Quang Minh (2):
      bna: ensure the copied buf is NUL terminated
      octeontx2-af: avoid off-by-one read from userspace

Bumyong Lee (1):
      dmaengine: pl330: issue_pending waits until WFP state

Chen Ni (1):
      ata: sata_gemini: Check clk_enable() result

Chen-Yu Tsai (3):
      pinctrl: mediatek: paris: Rework mtk_pinconf_{get,set} switch/case logic
      pinctrl: mediatek: paris: Fix PIN_CONFIG_INPUT_SCHMITT_ENABLE readback
      pinctrl: mediatek: paris: Rework support for PIN_CONFIG_{INPUT,OUTPUT}_ENABLE

Chris Wulff (1):
      usb: gadget: f_fs: Fix a race condition when processing setup packets.

Christian A. Ehrhardt (2):
      usb: typec: ucsi: Check for notifications after init
      usb: typec: ucsi: Fix connector check on init

Claudio Imbrenda (2):
      s390/mm: Fix storage key clearing for guest huge pages
      s390/mm: Fix clearing storage keys for huge pages

Dan Carpenter (1):
      pinctrl: core: delete incorrect free in pinctrl_enable()

Daniel Okazaki (1):
      eeprom: at24: fix memory corruption race condition

David Bauer (1):
      net l2tp: drop flow hash on forward

Dmitry Antipov (1):
      btrfs: fix kvcalloc() arguments order in btrfs_ioctl_send()

Doug Berger (1):
      net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()

Doug Smythies (1):
      tools/power turbostat: Fix added raw MSR output

Duoming Zhou (2):
      Bluetooth: Fix use-after-free bugs caused by sco_sock_timeout
      Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout

Eric Dumazet (3):
      tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets
      phonet: fix rtm_phonet_notify() skb allocation
      ipv6: fib6_rules: avoid possible NULL dereference in fib6_rule_action()

Felix Fietkau (3):
      net: bridge: fix multicast-to-unicast with fraglist GSO
      net: core: reject skb_copy(_expand) for fraglist GSO skbs
      net: bridge: fix corrupted ethernet header on multicast-to-unicast

Geert Uytterhoeven (1):
      ASoC: Fix 7/8 spaces indentation in Kconfig

Greg Kroah-Hartman (1):
      Linux 5.10.217

Guenter Roeck (1):
      usb: ohci: Prevent missed ohci interrupts

Hans de Goede (1):
      iio: accel: mxc4005: Interrupt handling fixes

Heiner Kallweit (1):
      eeprom: at24: Probe for DDR3 thermal sensor in the SPD case

Igor Artemiev (1):
      wifi: cfg80211: fix rdev_dump_mpp() arguments order

Jan Dakinevich (1):
      pinctrl/meson: fix typo in PDM's pin name

Jeff Johnson (1):
      wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc

Jeff Layton (1):
      9p: explicitly deny setlease attempts

Jens Remus (1):
      s390/vdso: Add CFI for RA register to asm macro vdso_func

Jernej Skrabec (1):
      clk: sunxi-ng: h6: Reparent CPUX during PLL CPUX rate change

Jerome Brunet (1):
      ASoC: meson: cards: select SND_DYNAMIC_MINORS

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

Lakshmi Yadlapati (1):
      hwmon: (pmbus/ucd9000) Increase delay from 250 to 500us

Li Nan (1):
      md: fix kmemleak of rdev->serial

Lyude Paul (1):
      drm/nouveau/dp: Don't probe eDP ports twice harder

Marc Zyngier (1):
      KVM: arm64: vgic-v2: Use cpuid from userspace as vcpu_id

Marek Behún (1):
      net: dsa: mv88e6xxx: Fix number of databases for 88E6141 / 88E6341

Maurizio Lombardi (1):
      scsi: target: Fix SELinux error when systemd-modules loads the target module

Oliver Upton (1):
      KVM: arm64: vgic-v2: Check for non-NULL vCPU in vgic_v2_parse_attr()

Paolo Abeni (1):
      tipc: fix UAF in error path

Paul Davey (1):
      xfrm: Preserve vlan tags for transport mode software GRO

Peiyang Wang (1):
      net: hns3: use appropriate barrier function after setting a bit value

Peng Liu (1):
      tools/power turbostat: Fix Bzy_MHz documentation typo

Peter Korsgaard (1):
      usb: gadget: composite: fix OS descriptors w_value logic

Phil Elwell (1):
      net: bcmgenet: Reset RBUF on first open

Ramona Gradinariu (1):
      iio:imu: adis16475: Fix sync mode setting

Richard Gobert (1):
      net: gro: add flush check in udp_gro_receive_segment

Rik van Riel (1):
      blk-iocost: avoid out of bounds shift

Rob Herring (1):
      arm64: dts: qcom: Fix 'interrupt-map' parent address cells

Roded Zats (1):
      rtnetlink: Correct nested IFLA_VF_VLAN_LIST attribute validation

Sameer Pujar (1):
      ASoC: tegra: Fix DSPK 16-bit playback

Saurav Kashyap (1):
      scsi: bnx2fc: Remove spin_lock_bh while releasing resources after upload

Sebastian Andrzej Siewior (2):
      cxgb4: Properly lock TX queue for the selftest.
      kcov: Remove kcov include from sched.h and move it to its users.

Silvio Gissi (1):
      keys: Fix overwrite of key expiration on instantiation

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

Thinh Nguyen (2):
      usb: xhci-plat: Don't include xhci.h
      usb: dwc3: core: Prevent phy suspend during init

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


