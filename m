Return-Path: <stable+bounces-215845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKNqNWSQjGlQrAAAu9opvQ
	(envelope-from <stable+bounces-215845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 15:21:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 526D0125285
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 15:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 472113013A5D
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E5F260565;
	Wed, 11 Feb 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="un80NZVC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48725BEE8;
	Wed, 11 Feb 2026 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819678; cv=none; b=rDKlY2+gx92Db0ggmlUPEA12Bt1lZFdZeqhB3qMQP0qKRwxUzjO53faz1b7btyP8t748c5fJd+nQDcFctAsxhHSD2CMt7b4ZqhnLz8yh7uA9c7OYNrDISjOlSyW/Tiiscyuqp+oWTaNkac1seiVu9+F9NNPM+vSGsxmjhJ31Mwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819678; c=relaxed/simple;
	bh=lB554mX3+lpOIzZNgHqpeu1bDB6AJkxFBeWZf5J64Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KO0olrFQt0xPRhquXeQGjNkaR0SItG6OFr2+b0VAOAtNhEEEMIYRkpafxnnI8Yby5AZBP/wfqjlhEKstQgUeSNQ8akbDJCwqmr7jAy4L/oEGY62cxecX3TAgTG7wza01fYEoZd6IblTPaRwqp2TOa84se8k45nttxkpdKZCDsns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=un80NZVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C1AC4CEF7;
	Wed, 11 Feb 2026 14:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770819677;
	bh=lB554mX3+lpOIzZNgHqpeu1bDB6AJkxFBeWZf5J64Ew=;
	h=From:To:Cc:Subject:Date:From;
	b=un80NZVCWCtRMJtCGXOl1RMR/nmIEn72gjsIaJfjiH5pdiLwlQOG746XH/e7ybl+t
	 AZgSx/A0SJnZknsVaTlheQZ/1CxNBsVmw1O+1B6dR5wFv3j81Iss3mXQpmUOliZh+U
	 3Wary2xLVz1EmhB1/eXGFmz3AbIFs9l3FxipPyvo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.250
Date: Wed, 11 Feb 2026 15:21:11 +0100
Message-ID: <2026021112-turkey-paprika-17f0@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215845-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 526D0125285
X-Rspamd-Action: no action

I'm announcing the release of the 5.10.250 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                           |    2 
 arch/arm/include/asm/string.h                      |    5 -
 block/bfq-cgroup.c                                 |    2 
 drivers/android/binderfs.c                         |    8 -
 drivers/block/rbd.c                                |   33 ++++--
 drivers/hid/hid-ids.h                              |    4 
 drivers/hid/hid-multitouch.c                       |    1 
 drivers/hid/hid-quirks.c                           |    2 
 drivers/hid/intel-ish-hid/ishtp-hid-client.c       |    1 
 drivers/hwmon/occ/common.c                         |    1 
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |   39 ++++----
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c |    4 
 drivers/net/ethernet/google/gve/gve_ethtool.c      |   46 ++++++---
 drivers/net/ethernet/google/gve/gve_main.c         |    4 
 drivers/net/macvlan.c                              |    5 -
 drivers/net/usb/sr9700.c                           |    5 +
 drivers/net/wireless/ti/wlcore/tx.c                |    5 +
 drivers/nvme/target/tcp.c                          |  100 ++++++++++-----------
 drivers/platform/x86/intel_telemetry_debugfs.c     |    4 
 drivers/platform/x86/intel_telemetry_pltdrv.c      |    2 
 drivers/platform/x86/toshiba_haps.c                |    2 
 drivers/target/iscsi/iscsi_target_util.c           |   10 +-
 kernel/trace/ring_buffer.c                         |    2 
 kernel/trace/trace.h                               |    7 +
 kernel/trace/trace_entries.h                       |   14 +-
 kernel/trace/trace_export.c                        |   21 +++-
 net/mac80211/key.c                                 |    3 
 net/mac80211/ocb.c                                 |    3 
 net/mac80211/sta_info.c                            |    7 -
 net/netfilter/nft_set_pipapo.c                     |    8 +
 net/tipc/crypto.c                                  |    4 
 net/wireless/util.c                                |    8 +
 sound/pci/hda/patch_realtek.c                      |    1 
 sound/soc/amd/renoir/acp3x-pdm-dma.c               |    2 
 sound/soc/codecs/tlv320adcx140.c                   |    3 
 sound/soc/ti/davinci-evm.c                         |   39 ++++++--
 virt/kvm/eventfd.c                                 |   34 ++-----
 37 files changed, 271 insertions(+), 170 deletions(-)

Arnd Bergmann (1):
      hwmon: (occ) Mark occ_init_attribute() as __printf

Baochen Qiang (1):
      wifi: mac80211: collect station statistics earlier when disconnect

Carlos Llamas (1):
      binderfs: fix ida_alloc_max() upper bound

Chris Bainbridge (1):
      ASoC: amd: fix memory leak in acp3x pdm dma ops

Chris Chiu (1):
      HID: quirks: Add another Chicony HP 5MP Cameras to hid_ignore_list

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

Greg Kroah-Hartman (1):
      Linux 5.10.250

Ilya Dryomov (1):
      rbd: check for EOD after exclusive lock is ensured to be held

Kaushlendra Kumar (2):
      platform/x86: intel_telemetry: Fix PSS event register mask
      platform/x86: intel_telemetry: Fix swapped arrays in PSS output

Kery Qi (1):
      ASoC: davinci-evm: Fix reference leak in davinci_evm_probe

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

Peter Åstrand (1):
      wifi: wlcore: ensure skb headroom before skb_push

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

Steven Rostedt (1):
      tracing: Fix ftrace event field alignments

Thomas Weissschuh (1):
      ARM: 9468/1: fix memset64() on big-endian

Varun Prakash (1):
      nvmet-tcp: pass iov_len instead of sg->length to bvec_set_page()

Veerendranath Jakkam (1):
      wifi: cfg80211: Fix bitrate calculation overflow for HE rates

Wupeng Ma (1):
      ring-buffer: Avoid softlockup in ring_buffer_resize() during memory free

YunJe Shin (1):
      nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec

Zhang Lixu (1):
      HID: intel-ish-hid: Reset enum_devices_done before enumeration

Zilin Guan (3):
      net: liquidio: Initialize netdev pointer before queue setup
      net: liquidio: Fix off-by-one error in PF setup_nic_devices() cleanup
      net: liquidio: Fix off-by-one error in VF setup_nic_devices() cleanup

shechenglong (1):
      block,bfq: fix aux stat accumulation destination


