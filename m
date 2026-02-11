Return-Path: <stable+bounces-215847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJuzJmyQjGlQrAAAu9opvQ
	(envelope-from <stable+bounces-215847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 15:21:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 587F6125293
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 15:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCAEF30090B9
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD892BCF43;
	Wed, 11 Feb 2026 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A9livJkc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39EC27B34D;
	Wed, 11 Feb 2026 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819686; cv=none; b=TD2wrDSKnGZk7vNZaB2wdkXptAdV3nhLvGY4WCucho2ArIzs1ntXLCmtZdAVzLJvCRL1MV1Hs9WpJmi15U2LiEn4yfAvpFycBoyKH0dEsUCX45VqSUVY8h4fguEUVzBrac4NrBXkJlU7hOMEi3o9bVjro/U5KqodYf985BywjQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819686; c=relaxed/simple;
	bh=6Q/k3/5UONk5Ceh4SUBCqhmyILhYWoEUeG6/dazpntU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2A7Sav2Bum+BSUeP72aUp9nK3ManEG1UV1UnB4oVLk6FVBl9JZg+BtmSnay2TmIvhHEdbu4Kk2QNploa9wIxfv+JD15CzB7Gk5FSapHRTlYZfayvRfmpN4uL/zxB20Qp59Uy5Qow4GxghCabPq/7t4yWMOwYor1lSWgF7ruZlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A9livJkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127EFC4CEF7;
	Wed, 11 Feb 2026 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770819686;
	bh=6Q/k3/5UONk5Ceh4SUBCqhmyILhYWoEUeG6/dazpntU=;
	h=From:To:Cc:Subject:Date:From;
	b=A9livJkcLBYXI5q5RvglZm596AxjVmSxwkMNCeUOzuM2dKbEgtZiBcKb6tntVJBnZ
	 vryHYTg0vE6kobykydJ1GqCMrd25HrbnkVp7SQR9JtGw8rNHTmR35FN+kenanLXEYw
	 THGmApLVqDcu1AFYlVSxtxgEyt0SU9OFRmHpJhc0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.200
Date: Wed, 11 Feb 2026 15:21:18 +0100
Message-ID: <2026021119-approval-situated-ff5e@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215847-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 587F6125293
X-Rspamd-Action: no action

I'm announcing the release of the 5.15.200 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/RCU/Design/Requirements/Requirements.rst      |    2 
 Documentation/core-api/local_ops.rst                        |    2 
 Documentation/kernel-hacking/locking.rst                    |   17 
 Documentation/timers/hrtimers.rst                           |    2 
 Documentation/translations/it_IT/kernel-hacking/locking.rst |   14 
 Documentation/translations/zh_CN/core-api/local_ops.rst     |    2 
 Makefile                                                    |    2 
 arch/arm/include/asm/string.h                               |    5 
 arch/arm/mach-spear/time.c                                  |    8 
 arch/riscv/include/asm/cacheflush.h                         |   15 
 arch/riscv/kernel/probes/uprobes.c                          |   10 
 arch/x86/include/asm/kfence.h                               |    7 
 block/bfq-cgroup.c                                          |    2 
 drivers/android/binderfs.c                                  |    8 
 drivers/block/rbd.c                                         |   33 -
 drivers/bluetooth/hci_qca.c                                 |   10 
 drivers/char/tpm/tpm-dev-common.c                           |    4 
 drivers/clocksource/arm_arch_timer.c                        |   12 
 drivers/clocksource/timer-sp804.c                           |    6 
 drivers/hid/hid-ids.h                                       |    4 
 drivers/hid/hid-multitouch.c                                |    1 
 drivers/hid/hid-playstation.c                               |    5 
 drivers/hid/hid-quirks.c                                    |    2 
 drivers/hid/intel-ish-hid/ishtp-hid-client.c                |    1 
 drivers/hwmon/occ/common.c                                  |    1 
 drivers/iommu/iommu.c                                       |    3 
 drivers/net/ethernet/cavium/liquidio/lio_main.c             |   39 -
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c          |    4 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c         |   10 
 drivers/net/ethernet/google/gve/gve_ethtool.c               |   46 +
 drivers/net/ethernet/google/gve/gve_main.c                  |    4 
 drivers/net/macvlan.c                                       |    5 
 drivers/net/usb/sr9700.c                                    |    5 
 drivers/net/wireless/ti/wlcore/tx.c                         |    5 
 drivers/nvme/target/tcp.c                                   |  100 +--
 drivers/platform/x86/intel/telemetry/debugfs.c              |    4 
 drivers/platform/x86/intel/telemetry/pltdrv.c               |    2 
 drivers/platform/x86/toshiba_haps.c                         |    2 
 drivers/spi/spi-tegra20-slink.c                             |    6 
 drivers/spi/spi-tegra210-quad.c                             |   36 +
 drivers/staging/wlan-ng/hfa384x_usb.c                       |    4 
 drivers/staging/wlan-ng/prism2usb.c                         |    6 
 drivers/target/iscsi/iscsi_target_util.c                    |   10 
 fs/gfs2/log.c                                               |    3 
 fs/gfs2/super.c                                             |    4 
 fs/hfsplus/dir.c                                            |    2 
 fs/hfsplus/hfsplus_fs.h                                     |    8 
 fs/hfsplus/unicode.c                                        |   24 
 fs/hfsplus/xattr.c                                          |    6 
 fs/ksmbd/smb2pdu.c                                          |    5 
 include/linux/timer.h                                       |   17 
 kernel/time/timer.c                                         |  318 +++++++++---
 kernel/trace/ring_buffer.c                                  |    2 
 kernel/trace/trace.h                                        |    7 
 kernel/trace/trace_entries.h                                |   14 
 kernel/trace/trace_export.c                                 |   21 
 mm/kfence/core.c                                            |   25 
 net/bluetooth/hci_event.c                                   |    3 
 net/bridge/netfilter/ebtables.c                             |    2 
 net/mac80211/key.c                                          |    3 
 net/mac80211/ocb.c                                          |    3 
 net/mac80211/sta_info.c                                     |    7 
 net/netfilter/nf_log.c                                      |    4 
 net/netfilter/nf_tables_api.c                               |    2 
 net/netfilter/nft_set_pipapo.c                              |    8 
 net/netfilter/x_tables.c                                    |    2 
 net/sunrpc/xprt.c                                           |    2 
 net/tipc/crypto.c                                           |    4 
 net/wireless/util.c                                         |    8 
 sound/pci/hda/patch_realtek.c                               |    1 
 sound/soc/amd/renoir/acp3x-pdm-dma.c                        |    2 
 sound/soc/codecs/tlv320adcx140.c                            |    3 
 sound/soc/ti/davinci-evm.c                                  |   39 +
 virt/kvm/eventfd.c                                          |   44 -
 74 files changed, 743 insertions(+), 316 deletions(-)

Andreas Gruenbacher (1):
      gfs2: Fix NULL pointer dereference in gfs2_log_flush

Andrew Cooper (1):
      x86/kfence: fix booting on 32bit non-PAE systems

Andrew Fasano (1):
      netfilter: nf_tables: fix inverted genmask check in nft_map_catchall_activate()

Arnd Bergmann (1):
      hwmon: (occ) Mark occ_init_attribute() as __printf

Baochen Qiang (1):
      wifi: mac80211: collect station statistics earlier when disconnect

Björn Töpel (2):
      riscv: uprobes: Add missing fence.i after building the XOL buffer
      riscv: Replace function-like macro by static inline function

Breno Leitao (5):
      spi: tegra210-quad: Return IRQ_HANDLED when timeout already processed transfer
      spi: tegra210-quad: Move curr_xfer read inside spinlock
      spi: tegra210-quad: Protect curr_xfer assignment in tegra_qspi_setup_transfer_one
      spi: tegra210-quad: Protect curr_xfer in tegra_qspi_combined_seq_xfer
      spi: tegra210-quad: Protect curr_xfer clearing in tegra_qspi_non_combined_seq_xfer

Carlos Llamas (1):
      binderfs: fix ida_alloc_max() upper bound

Chris Bainbridge (1):
      ASoC: amd: fix memory leak in acp3x pdm dma ops

Chris Chiu (1):
      HID: quirks: Add another Chicony HP 5MP Cameras to hid_ignore_list

Daniel Gomez (1):
      netfilter: replace -EEXIST with -EBUSY

Daniel Hodges (1):
      tipc: use kfree_sensitive() for session key material

DaytonCL (1):
      HID: multitouch: add MT_QUIRK_STICKY_FINGERS to MT_CLS_VTL

Debarghya Kundu (1):
      gve: Fix stats report corruption on queue count change

Dimitrios Katsaros (1):
      ASoC: tlv320adcx140: Propagate error codes during probe

Eric Dumazet (1):
      macvlan: fix error recovery in macvlan_common_newlink()

Ethan Nelson-Moore (1):
      net: usb: sr9700: support devices with virtual driver CD

Fabio M. De Francesco (1):
      nvmet-tcp: don't map pages which can't come from HIGHMEM

Felix Gu (1):
      spi: tegra: Fix a memory leak in tegra_slink_probe()

Greg Kroah-Hartman (1):
      Linux 5.15.200

Ilya Dryomov (1):
      rbd: check for EOD after exclusive lock is ensured to be held

Junrui Luo (2):
      dpaa2-switch: prevent ZERO_SIZE_PTR dereference when num_ifs is zero
      dpaa2-switch: add bounds check for if_id in IRQ handler

Kang Chen (1):
      hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()

Kaushlendra Kumar (2):
      platform/x86: intel_telemetry: Fix swapped arrays in PSS output
      platform/x86: intel_telemetry: Fix PSS event register mask

Kery Qi (1):
      ASoC: davinci-evm: Fix reference leak in davinci_evm_probe

Lu Baolu (1):
      iommu: disable SVA when CONFIG_X86 is set

Maurizio Lombardi (4):
      scsi: target: iscsi: Fix use-after-free in iscsit_dec_session_usage_count()
      scsi: target: iscsi: Fix use-after-free in iscsit_dec_conn_usage_count()
      nvmet-tcp: add an helper to free the cmd buffers
      nvmet-tcp: fix memory leak when performing a controller reset

Max Yuan (1):
      gve: Correct ethtool rx_dropped calculation

Miri Korenblit (1):
      wifi: mac80211: don't increment crypto_tx_tailroom_needed_cnt twice

Moon Hee Lee (1):
      wifi: mac80211: ocb: skip rx_no_sta when interface is not joined

Pablo Neira Ayuso (1):
      netfilter: nft_set_pipapo: clamp maximum map bucket size to INT_MAX

Pauli Virtanen (1):
      Bluetooth: hci_event: call disconnect callback before deleting conn

Peter Åstrand (1):
      wifi: wlcore: ensure skb headroom before skb_push

Pimyn Girgis (1):
      mm/kfence: randomize the freelist on initialization

Rafael J. Wysocki (1):
      platform/x86: toshiba_haps: Fix memory leaks in add/remove routines

Rodrigo Lugathe da Conceição Alves (1):
      HID: Apply quirk HID_QUIRK_ALWAYS_POLL to Edifier QR30 (2d99:a101)

Ruslan Krupitsa (1):
      ALSA: hda/realtek: add HP Laptop 15s-eq1xxx mute LED quirk

Sagi Grimberg (1):
      nvmet-tcp: fix regression in data_digest calculation

Sean Christopherson (1):
      KVM: Don't clobber irqfd routing type when deassigning irqfd

Siarhei Vishniakou (1):
      HID: playstation: Center initial joystick axes to prevent spurious events

Steven Rostedt (1):
      tracing: Fix ftrace event field alignments

Steven Rostedt (Google) (4):
      ARM: spear: Do not use timer namespace for timer_shutdown() function
      clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function
      clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function
      timers: Update the documentation to reflect on the new timer_shutdown() API

Thomas Gleixner (10):
      Documentation: Remove bogus claim about del_timer_sync()
      timers: Get rid of del_singleshot_timer_sync()
      timers: Replace BUG_ON()s
      timers: Rename del_timer() to timer_delete()
      Documentation: Replace del_timer/del_timer_sync()
      timers: Silently ignore timers with a NULL function
      timers: Split [try_to_]del_timer[_sync]() to prepare for shutdown mode
      timers: Add shutdown mechanism to the internal functions
      timers: Provide timer_shutdown[_sync]()
      Bluetooth: hci_qca: Fix the teardown problem for real

Thomas Weissschuh (1):
      ARM: 9468/1: fix memset64() on big-endian

Varun Prakash (1):
      nvmet-tcp: pass iov_len instead of sg->length to bvec_set_page()

Veerendranath Jakkam (1):
      wifi: cfg80211: Fix bitrate calculation overflow for HE rates

Wupeng Ma (1):
      ring-buffer: Avoid softlockup in ring_buffer_resize() during memory free

Yipeng Zou (1):
      timers: Fix NULL function pointer race in timer_shutdown_sync()

YunJe Shin (1):
      nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec

Zhang Lixu (1):
      HID: intel-ish-hid: Reset enum_devices_done before enumeration

ZhangGuoDong (1):
      smb/server: call ksmbd_session_rpc_close() on error path in create_smb2_pipe()

Zilin Guan (3):
      net: liquidio: Initialize netdev pointer before queue setup
      net: liquidio: Fix off-by-one error in PF setup_nic_devices() cleanup
      net: liquidio: Fix off-by-one error in VF setup_nic_devices() cleanup

shechenglong (1):
      block,bfq: fix aux stat accumulation destination


