Return-Path: <stable+bounces-125814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D971DA6CC0A
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 21:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A14117E435
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 20:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025F419007D;
	Sat, 22 Mar 2025 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Drp8Z7WY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836229CEB;
	Sat, 22 Mar 2025 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742673677; cv=none; b=JX4KbxCvAu4/oEcCbkrWj4pLAfFHIAKPKTrZI35+mjRrm+FWaWAZD7g85SpmG5xGPDoqGvP4jB0dQtpIlWcILOuk/H9buIGilcUneqv4ttx3KE3gxlPCKrLKMiPaiixBvoqkBPqSsuPW9ylxWZXKfXX680JDDK6KQsVdsk4Bp04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742673677; c=relaxed/simple;
	bh=oLT0aW3DNtmM6nu18bKSKPp8Ac898M3ZQ9Jlzbv/7G0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oh1cI5g3iVxl0R/L5NyUp0VynGvQfZDI2qGvKz/QY4MbaQHfg2HBHrARJD/G2T8spQi9BKq3Wz85cH6dKbai+uLbhf1q/mPvO2kH3f7znHVDv1s6E++bWwuBr0ap6eRq5bR9Om+CtoRy6wwN5yyIwVEsL2iiJRKy+oBmFeiRoDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Drp8Z7WY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA7DC4CEDD;
	Sat, 22 Mar 2025 20:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742673676;
	bh=oLT0aW3DNtmM6nu18bKSKPp8Ac898M3ZQ9Jlzbv/7G0=;
	h=From:To:Cc:Subject:Date:From;
	b=Drp8Z7WYWsyGljcYy7lt5zhzj5hZa2aLJpQKK1bhthSnNwxJIoP5zg5GYt8T8zTOe
	 G3HlFr9vTPrzQTy7EPJLg2dsAzb89q4OyAa+NPkgDADk0xGgZ+lMXdzruAZowYqm9e
	 d+9lPkHs4If5RU2yoZ3purX2qChR2r4f0KAoAC30=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.84
Date: Sat, 22 Mar 2025 12:59:49 -0700
Message-ID: <2025032250-corral-vastly-e81d@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.84 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/timers/no_hz.rst                           |    7 
 Makefile                                                 |    2 
 arch/alpha/include/asm/elf.h                             |    6 
 arch/alpha/include/asm/pgtable.h                         |    2 
 arch/alpha/include/asm/processor.h                       |    8 
 arch/alpha/kernel/osf_sys.c                              |   11 
 arch/arm64/mm/mmu.c                                      |    5 
 arch/x86/events/intel/core.c                             |   85 +++++
 arch/x86/kernel/cpu/microcode/amd.c                      |    2 
 arch/x86/kernel/cpu/mshyperv.c                           |   11 
 arch/x86/kernel/irq.c                                    |    2 
 block/bio.c                                              |    2 
 drivers/acpi/resource.c                                  |    6 
 drivers/block/zram/zram_drv.c                            |    4 
 drivers/clk/samsung/clk-pll.c                            |    7 
 drivers/clocksource/i8253.c                              |   36 +-
 drivers/firmware/iscsi_ibft.c                            |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c        |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c   |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c    |   64 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c        |    7 
 drivers/gpu/drm/display/drm_dp_mst_topology.c            |   40 +-
 drivers/gpu/drm/drm_atomic_uapi.c                        |    4 
 drivers/gpu/drm/drm_connector.c                          |    4 
 drivers/gpu/drm/gma500/mid_bios.c                        |    5 
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c                  |    2 
 drivers/gpu/drm/i915/display/intel_display.c             |    5 
 drivers/gpu/drm/nouveau/nouveau_connector.c              |    1 
 drivers/gpu/drm/vkms/vkms_composer.c                     |    2 
 drivers/hid/Kconfig                                      |    3 
 drivers/hid/hid-apple.c                                  |   13 
 drivers/hid/hid-ids.h                                    |    3 
 drivers/hid/hid-quirks.c                                 |    1 
 drivers/hid/hid-topre.c                                  |    7 
 drivers/hid/intel-ish-hid/ipc/ipc.c                      |   15 
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h              |    2 
 drivers/hv/vmbus_drv.c                                   |   13 
 drivers/i2c/busses/i2c-ali1535.c                         |   12 
 drivers/i2c/busses/i2c-ali15x3.c                         |   12 
 drivers/i2c/busses/i2c-sis630.c                          |   12 
 drivers/input/joystick/xpad.c                            |   39 +-
 drivers/input/misc/iqs7222.c                             |   50 +--
 drivers/input/serio/i8042-acpipnpio.h                    |  111 +++---
 drivers/input/touchscreen/ads7846.c                      |    2 
 drivers/md/dm-flakey.c                                   |    2 
 drivers/net/bonding/bond_options.c                       |   55 ++-
 drivers/net/dsa/mv88e6xxx/chip.c                         |   59 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c            |   11 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h            |    3 
 drivers/net/ethernet/intel/ice/ice_arfs.c                |    2 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c        |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c  |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        |    6 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c        |    4 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h        |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c      |    3 
 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c  |    5 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c |    8 
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c     |    7 
 drivers/net/mctp/mctp-i2c.c                              |    5 
 drivers/net/wwan/mhi_wwan_mbim.c                         |    2 
 drivers/nvme/host/apple.c                                |    2 
 drivers/nvme/host/core.c                                 |    2 
 drivers/nvme/host/fc.c                                   |   59 ---
 drivers/nvme/host/pci.c                                  |    2 
 drivers/nvme/host/tcp.c                                  |   43 ++
 drivers/nvme/target/rdma.c                               |   33 +
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c                   |    2 
 drivers/platform/x86/intel/pmc/core.c                    |    4 
 drivers/platform/x86/thinkpad_acpi.c                     |   50 ++-
 drivers/powercap/powercap_sys.c                          |    3 
 drivers/s390/cio/chp.c                                   |    3 
 drivers/scsi/qla1280.c                                   |    2 
 drivers/scsi/scsi_scan.c                                 |    2 
 drivers/thermal/cpufreq_cooling.c                        |    2 
 drivers/ufs/core/ufshcd.c                                |    7 
 drivers/usb/phy/phy-generic.c                            |    2 
 drivers/usb/serial/ftdi_sio.c                            |   14 
 drivers/usb/serial/ftdi_sio_ids.h                        |   13 
 drivers/usb/serial/option.c                              |   48 +-
 drivers/video/fbdev/hyperv_fb.c                          |    2 
 drivers/xen/swiotlb-xen.c                                |    2 
 fs/fuse/dir.c                                            |    2 
 fs/namei.c                                               |   24 +
 fs/proc/base.c                                           |    9 
 fs/select.c                                              |   11 
 fs/smb/client/asn1.c                                     |    2 
 fs/smb/client/cifs_spnego.c                              |    4 
 fs/smb/client/cifsglob.h                                 |    4 
 fs/smb/client/connect.c                                  |   16 
 fs/smb/client/fs_context.c                               |   18 -
 fs/smb/client/inode.c                                    |   13 
 fs/smb/client/reparse.c                                  |   10 
 fs/smb/client/sess.c                                     |    3 
 fs/smb/client/smb2pdu.c                                  |    4 
 fs/smb/common/smbfsctl.h                                 |    3 
 fs/smb/server/connection.c                               |   20 +
 fs/smb/server/connection.h                               |    2 
 fs/smb/server/ksmbd_work.c                               |    3 
 fs/smb/server/ksmbd_work.h                               |    1 
 fs/smb/server/oplock.c                                   |   43 +-
 fs/smb/server/oplock.h                                   |    1 
 fs/smb/server/server.c                                   |   14 
 fs/vboxsf/super.c                                        |    3 
 include/linux/fs.h                                       |    2 
 include/linux/i8253.h                                    |    1 
 include/linux/io_uring_types.h                           |    3 
 include/linux/nvme-tcp.h                                 |    2 
 include/net/bluetooth/hci_core.h                         |  108 ++----
 include/net/bluetooth/l2cap.h                            |    3 
 include/net/netfilter/nf_tables.h                        |   20 -
 include/sound/soc.h                                      |    5 
 init/Kconfig                                             |    2 
 io_uring/io-wq.c                                         |   23 +
 io_uring/io_uring.c                                      |  250 ++++++++++-----
 io_uring/io_uring.h                                      |    8 
 io_uring/kbuf.c                                          |  173 ++--------
 io_uring/kbuf.h                                          |    3 
 io_uring/rsrc.c                                          |   39 --
 kernel/bpf/ringbuf.c                                     |   12 
 kernel/sched/core.c                                      |   13 
 kernel/sched/debug.c                                     |    2 
 kernel/sys.c                                             |    2 
 kernel/time/hrtimer.c                                    |   40 --
 lib/buildid.c                                            |    5 
 mm/mmap.c                                                |   69 +++-
 mm/nommu.c                                               |    7 
 net/bluetooth/hci_core.c                                 |   10 
 net/bluetooth/hci_event.c                                |   37 +-
 net/bluetooth/iso.c                                      |    6 
 net/bluetooth/l2cap_core.c                               |  181 +++++-----
 net/bluetooth/l2cap_sock.c                               |   15 
 net/bluetooth/rfcomm/core.c                              |    6 
 net/bluetooth/sco.c                                      |   12 
 net/core/dev.c                                           |    2 
 net/core/netpoll.c                                       |    9 
 net/ipv4/tcp.c                                           |   20 -
 net/ipv6/addrconf.c                                      |   15 
 net/mptcp/protocol.h                                     |    2 
 net/netfilter/ipvs/ip_vs_ctl.c                           |    8 
 net/netfilter/nf_conncount.c                             |    6 
 net/netfilter/nf_tables_api.c                            |   25 -
 net/netfilter/nft_connlimit.c                            |    4 
 net/netfilter/nft_counter.c                              |    4 
 net/netfilter/nft_ct.c                                   |    6 
 net/netfilter/nft_dynset.c                               |    2 
 net/netfilter/nft_exthdr.c                               |   10 
 net/netfilter/nft_last.c                                 |    4 
 net/netfilter/nft_limit.c                                |   14 
 net/netfilter/nft_quota.c                                |    4 
 net/netfilter/nft_set_hash.c                             |    8 
 net/netfilter/nft_set_pipapo.c                           |   18 -
 net/netfilter/nft_set_rbtree.c                           |   11 
 net/openvswitch/flow_netlink.c                           |   15 
 net/sched/sch_api.c                                      |    6 
 net/sched/sch_gred.c                                     |    3 
 net/sctp/stream.c                                        |    2 
 net/switchdev/switchdev.c                                |   25 +
 net/wireless/core.c                                      |    7 
 rust/kernel/error.rs                                     |    2 
 rust/kernel/init.rs                                      |   23 -
 rust/kernel/init/macros.rs                               |    6 
 rust/kernel/sync.rs                                      |   10 
 scripts/generate_rust_analyzer.py                        |   30 +
 sound/pci/hda/patch_realtek.c                            |    1 
 sound/soc/amd/yc/acp6x-mach.c                            |    7 
 sound/soc/codecs/arizona.c                               |   14 
 sound/soc/codecs/cs42l43.c                               |    2 
 sound/soc/codecs/madera.c                                |   10 
 sound/soc/codecs/rt722-sdca-sdw.c                        |    4 
 sound/soc/codecs/tas2764.c                               |   10 
 sound/soc/codecs/tas2764.h                               |    8 
 sound/soc/codecs/tas2770.c                               |    2 
 sound/soc/codecs/wm0010.c                                |   13 
 sound/soc/codecs/wm5110.c                                |    8 
 sound/soc/generic/simple-card-utils.c                    |    1 
 sound/soc/sh/rcar/core.c                                 |   14 
 sound/soc/sh/rcar/rsnd.h                                 |    1 
 sound/soc/sh/rcar/src.c                                  |  116 +++++-
 sound/soc/sh/rcar/ssi.c                                  |    3 
 sound/soc/soc-ops.c                                      |   15 
 sound/soc/sof/amd/acp-ipc.c                              |   23 -
 sound/soc/sof/intel/hda-codec.c                          |    1 
 tools/objtool/check.c                                    |    9 
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c   |    6 
 186 files changed, 1802 insertions(+), 1165 deletions(-)

Alban Kurti (2):
      rust: error: add missing newline to pr_warn! calls
      rust: init: add missing newline to pr_info! calls

Alex Henrie (2):
      HID: apple: fix up the F6 key on the Omoton KB066 keyboard
      HID: apple: disable Fn key handling on the Omoton KB066

Alex Hung (1):
      drm/amd/display: Assign normalized_pix_clk when color depth = 14

Alexander Stein (1):
      usb: phy: generic: Use proper helper for property detection

Alexey Kashavkin (1):
      netfilter: nft_exthdr: fix offset with ipv4_find_option()

Amit Cohen (1):
      net: switchdev: Convert blocking notification chain to a raw one

Andrii Nakryiko (1):
      lib/buildid: Handle memfd_secret() files in build_id_parse()

Andy Shevchenko (1):
      hrtimers: Mark is_migration_base() with __always_inline

Antheas Kapenekakis (3):
      Input: xpad - add support for ZOTAC Gaming Zone
      Input: xpad - add support for TECNO Pocket Go
      Input: xpad - rename QH controller to Legion Go S

Arnd Bergmann (1):
      x86/irq: Define trace events conditionally

Artur Weber (1):
      pinctrl: bcm281xx: Fix incorrect regmap max_registers value

Bard Liao (1):
      ASoC: rt722-sdca: add missing readable registers

Benno Lossin (1):
      rust: init: fix `Zeroable` implementation for `Option<NonNull<T>>` and `Option<KBox<T>>`

Boon Khai Ng (1):
      USB: serial: ftdi_sio: add support for Altera USB Blaster 3

Brahmajit Das (1):
      vboxsf: fix building with GCC 15

Breno Leitao (1):
      netpoll: hold rcu read lock in __netpoll_send_skb()

Carolina Jubran (1):
      net/mlx5e: Prevent bridge link show failure for non-eswitch-allowed devices

Charles Keepax (2):
      ASoC: ops: Consistently treat platform_max as control value
      ASoC: cs42l43: Fix maximum ADC Volume

Chengen Du (1):
      iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in ibft_attr_show_nic()

Chia-Lin Kao (AceLan) (1):
      HID: ignore non-functional sensor in HP 5MP Camera

Christian Loehle (1):
      sched/debug: Provide slice length for fair tasks

Christophe JAILLET (4):
      ASoC: codecs: wm0010: Fix error handling path in wm0010_spi_probe()
      i2c: ali1535: Fix an error handling path in ali1535_probe()
      i2c: ali15x3: Fix an error handling path in ali15x3_probe()
      i2c: sis630: Fix an error handling path in sis630_probe()

Christopher Lentocha (1):
      nvme-pci: quirk Acer FA100 for non-uniqueue identifiers

Cong Wang (1):
      net_sched: Prevent creation of classes with TC_H_ROOT

Cristian Ciocaltea (1):
      ASoC: SOF: amd: Handle IPC replies before FW_BOOT_COMPLETE

Dan Carpenter (1):
      ipvs: prevent integer overflow in do_ip_vs_get_ctl()

Daniel Brackenbury (1):
      HID: topre: Fix n-key rollover on Realforce R3S TKL boards

Daniel Lezcano (1):
      thermal/cpufreq_cooling: Remove structure member documentation

Daniel Wagner (4):
      nvme-fc: go straight to connecting state when initializing
      nvme-fc: do not ignore connectivity loss during connecting
      nvme: only allow entering LIVE from CONNECTING state
      nvme-fc: rely on state transitions to handle connectivity loss

David Woodhouse (1):
      clockevents/drivers/i8253: Fix stop sequence for timer 0

Dmitry Kandybka (1):
      platform/x86/intel: pmc: fix ltr decode in pmc_core_ltr_show()

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on Positivo ARN50

Eric Dumazet (1):
      tcp: fix races in tcp_abort()

Eric W. Biederman (1):
      alpha/elf: Fix misc/setarch test of util-linux by removing 32bit support

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FE990B compositions
      USB: serial: option: fix Telit Cinterion FE990A name

Felix Moessbauer (1):
      hrtimer: Use and report correct timerslack values for realtime tasks

Florent Revest (1):
      x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA nodes

Florian Westphal (1):
      netfilter: nf_tables: allow clone callbacks to sleep

Frederic Weisbecker (1):
      net: Handle napi_schedule() calls from non-interrupt

Gannon Kolding (1):
      ACPI: resource: IRQ override for Eluktronics MECH-17

Greg Kroah-Hartman (1):
      Linux 6.6.84

Grzegorz Nitka (1):
      ice: fix memory leak in aRFS after reset

Guillaume Nault (1):
      gre: Fix IPv6 link-local address generation.

H. Nikolaus Schaller (1):
      Input: ads7846 - fix gpiod allocation

Hangbin Liu (1):
      bonding: fix incorrect MAC address setting to receive NS messages

Haoxiang Li (1):
      qlcnic: fix memory leak issues in qlcnic_sriov_common.c

Harry Wentland (1):
      drm/vkms: Round fixp2int conversion in lerp_u16

Hector Martin (4):
      apple-nvme: Release power domains when probe fails
      ASoC: tas2770: Fix volume scale
      ASoC: tas2764: Fix power control mask
      ASoC: tas2764: Set the SDOUT polarity correctly

Henrique Carvalho (1):
      smb: client: Fix match_session bug preventing session reuse

Ievgen Vovk (1):
      HID: hid-apple: Apple Magic Keyboard a3203 USB-C support

Ilya Maximets (1):
      net: openvswitch: remove misbehaving actions length check

Imre Deak (1):
      drm/dp_mst: Fix locking when skipping CSN before topology probing

Ivan Abramov (1):
      drm/gma500: Add NULL check for pci_gfx_root in mid_get_vbt_data()

Jan Beulich (1):
      Xen/swiotlb: mark xen_swiotlb_fixup() __init

Jann Horn (1):
      sched: Clarify wake_up_q()'s write to task->wake_q.next

Jeff LaBundy (1):
      Input: iqs7222 - preserve system status register

Jens Axboe (8):
      mm: add nommu variant of vm_insert_pages()
      io_uring: get rid of remap_pfn_range() for mapping rings/sqes
      io_uring: don't attempt to mmap larger than what the user asks for
      io_uring: use vmap() for ring mapping
      io_uring: unify io_pin_pages()
      io_uring/kbuf: vmap pinned buffer ring
      io_uring/kbuf: use vm_insert_pages() for mmap'ed pbuf ring
      io_uring: use unpin_user_pages() where appropriate

Jianbo Liu (1):
      net/mlx5: Bridge, fix the crash caused by LAG state check

Jiayuan Chen (1):
      selftests/bpf: Fix invalid flag of recv()

Jiri Pirko (1):
      net/mlx5: Fill out devlink dev info only for PFs

Joe Hattori (1):
      powercap: call put_device() on an error path in powercap_register_control_type()

Johan Hovold (1):
      USB: serial: option: match on interface class for Telit FN990B

Joseph Huang (1):
      net: dsa: mv88e6xxx: Verify after ATU Load ops

Josh Poimboeuf (1):
      objtool: Ignore dangling jump table entries

Jun Yang (1):
      sched: address a potential NULL pointer dereference in the GRED scheduler.

Kan Liang (1):
      perf/x86/intel: Use better start period for frequency mode

Kent Overstreet (1):
      dm-flakey: Fix memory corruption in optional corrupt_bio_byte feature

Kirill A. Shutemov (1):
      mm: split critical region in remap_file_pages() and invoke LSMs in between

Kohei Enju (1):
      netfilter: nf_conncount: Fully initialize struct nf_conncount_tuple in insert_tree()

Kuninori Morimoto (4):
      ASoC: simple-card-utils.c: add missing dlc->of_node
      ASoC: rsnd: indicate unsupported clock rate
      ASoC: rsnd: don't indicate warning on rsnd_kctrl_accept_runtime()
      ASoC: rsnd: adjust convert rate limitation

Leo Li (1):
      drm/amd/display: Disable unneeded hpd interrupts during dm_init

Liu Shixin (1):
      zram: fix NULL pointer in comp_algorithm_show()

Luiz Augusto von Dentz (4):
      Bluetooth: hci_event: Fix enabling passive scanning
      Revert "Bluetooth: hci_core: Fix sleeping function called from invalid context"
      Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
      Bluetooth: L2CAP: Fix corrupted list in hci_chan_del

Magnus Lindholm (1):
      scsi: qla1280: Fix kernel oops when debug level > 2

Mario Limonciello (2):
      drm/amd/display: Restore correct backlight brightness after a GPU reset
      drm/amd/display: Fix slab-use-after-free on hdcp_work

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Support for V9 DYTC platform profiles

Matt Johnston (1):
      net: mctp i2c: Copy headers if cloned

Matthew Maurer (1):
      rust: Disallow BTF generation with Rust + LTO

Matthieu Baerts (NGI0) (1):
      mptcp: safety check before fallback

Maurizio Lombardi (2):
      nvme-tcp: add basic support for the C2HTermReq PDU
      nvme-tcp: Fix a C2HTermReq error message

Michael Kelley (3):
      fbdev: hyperv_fb: iounmap() the correct memory when removing a device
      drm/hyperv: Fix address space leak when Hyper-V DRM device is removed
      Drivers: hv: vmbus: Don't release fb_mmio resource in vmbus_free_mmio()

Miklos Szeredi (1):
      fuse: don't truncate cached, mutated symlink

Ming Lei (1):
      block: fix 'kmem_cache of name 'bio-108' already exists'

Miri Korenblit (1):
      wifi: cfg80211: cancel wiphy_work before freeing wiphy

Mitchell Levy (1):
      rust: lockdep: Remove support for dynamically allocated LockClassKeys

Murad Masimov (4):
      cifs: Fix integer overflow while processing acregmax mount option
      cifs: Fix integer overflow while processing acdirmax mount option
      cifs: Fix integer overflow while processing actimeo mount option
      cifs: Fix integer overflow while processing closetimeo mount option

Namjae Jeon (2):
      ksmbd: fix use-after-free in ksmbd_free_work_struct
      ksmbd: prevent connection release during oplock break notification

Nicklas Bo Jensen (1):
      netfilter: nf_conncount: garbage collection is not skipped when jiffies wrap around

Nilton Perim Neto (1):
      Input: xpad - add 8BitDo SN30 Pro, Hyperkin X91 and Gamesir G7 SE controllers

Oleg Nesterov (1):
      sched/isolation: Prevent boot crash when the boot CPU is nohz_full

Pablo Neira Ayuso (2):
      netfilter: nf_tables: use timestamp to check for set element timeout
      netfilter: nf_tables: bail out if stateful expression provides no .clone

Pali Rohár (3):
      cifs: Treat unhandled directory name surrogate reparse points as mount directory nodes
      cifs: Validate content of WSL reparse point buffers
      cifs: Throw -EOPNOTSUPP error on unsupported reparse point type from parse_reparse_point()

Paulo Alcantara (2):
      smb: client: fix noisy when tree connecting to DFS interlink targets
      smb: client: fix regression with guest option

Pavel Begunkov (2):
      io_uring: fix corner case forgetting to vunmap
      io_uring: fix error pbuf checking

Pavel Rojtberg (1):
      Input: xpad - add multiple supported devices

Peter Oberparleiter (1):
      s390/cio: Fix CHPID "configure" attribute caching

Philipp Stanner (1):
      stmmac: loongson: Pass correct arg to PCI function

Rik van Riel (1):
      scsi: core: Use GFP_NOIO to avoid circular locking dependency

Ruozhu Li (1):
      nvmet-rdma: recheck queue state is LIVE in state lock in recv done

Sebastian Andrzej Siewior (1):
      netfilter: nft_ct: Use __refcount_inc() for per-CPU nft_ct_pcpu_template.

Seunghui Lee (1):
      scsi: ufs: core: Fix error return with query response

Shay Drory (1):
      net/mlx5: Lag, Check shared fdb before creating MultiPort E-Switch

Stephan Gerhold (1):
      net: wwan: mhi_wwan_mbim: Silence sequence number glitch errors

Steve French (1):
      smb3: add support for IAKerb

Sybil Isabel Dorsett (1):
      platform/x86: thinkpad_acpi: Fix invalid fan speed on ThinkPad X120e

Taehee Yoo (1):
      eth: bnxt: do not update checksum in bnxt_xdp_build_skb()

Tamir Duberstein (1):
      scripts: generate_rust_analyzer: add missing macros deps

Terry Cheong (1):
      ASoC: SOF: Intel: hda: add softdep pre to snd-hda-codec-hdmi module

Thomas Mizrahi (1):
      ASoC: amd: yc: Support mic on another Lenovo ThinkPad E16 Gen 2 model

Thomas Zimmermann (1):
      drm/nouveau: Do not override forced connector status

Uday Shankar (1):
      io-wq: backoff when retrying worker creation

Varada Pavani (1):
      clk: samsung: update PLL locktime for PLL142XX used on FSD platform

Ville Syrjälä (2):
      drm/i915/cdclk: Do cdclk post plane programming later
      drm/atomic: Filter out redundant DPMS calls

Vitaly Rodionov (1):
      ASoC: arizona/madera: use fsleep() in up/down DAPM event delays.

Wander Lairson Costa (1):
      bpf: Use raw_spinlock_t in ringbuf

Wentao Liang (1):
      net/mlx5: handle errors in mlx5_chains_create_table()

Werner Sembach (4):
      Input: i8042 - swap old quirk combination with new quirk for NHxxRZQ
      Input: i8042 - add required quirks for missing old boardnames
      Input: i8042 - swap old quirk combination with new quirk for several devices
      Input: i8042 - swap old quirk combination with new quirk for more devices

Xueming Feng (1):
      tcp: fix forever orphan socket caused by tcp_abort

Yu-Chun Lin (1):
      sctp: Fix undefined behavior in left shift operation

Zhang Lixu (2):
      HID: intel-ish-hid: fix the length of MNG_SYNC_FW_CLOCK in doorbell
      HID: intel-ish-hid: Send clock sync message immediately after reset

Zhenhua Huang (1):
      arm64: mm: Populate vmemmap at the page level if not section aligned


