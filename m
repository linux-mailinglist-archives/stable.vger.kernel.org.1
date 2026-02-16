Return-Path: <stable+bounces-216674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPHlNenlkmlSzwEAu9opvQ
	(envelope-from <stable+bounces-216674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:39:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46407142029
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F9A33024103
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 09:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C52E5D17;
	Mon, 16 Feb 2026 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Rl0v5xR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8CC2E541F;
	Mon, 16 Feb 2026 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771234760; cv=none; b=bFNN4AgJDROD5wBztBVVowMzLUEYpi3AqZMIWB2yfx16Hbx/AgqpqUdOKCLR3p+4Y1KERv+27eLffPT//mtuKe9TDUdAayUen+Hyj+nUg7cq6tf/vD1yes53fiy0alfIc/P3NtCapNZpyU8qd3gCTcIC6Vmv8fjBBo5vf7VyQpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771234760; c=relaxed/simple;
	bh=BF6CcYDyn/sKjLg1pRrL0kzl8LdI5PrDDpHPT91sSWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gml6DzO/rGcaCcNexSOzfwHhEijSrjq8TtzVInQc5VjvTE6Fr15T9buRJ43BV0wiZ+xQi5+YCc0RkTRjfFwNXONF4LR63EclsU2Ljptut7dXMsYvM/LxStV+41ZDqMKZBCQsYD6Mmcj3SI4+4KWJC26hH/QKPL5u8szpmWMr3Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Rl0v5xR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FACAC19422;
	Mon, 16 Feb 2026 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771234760;
	bh=BF6CcYDyn/sKjLg1pRrL0kzl8LdI5PrDDpHPT91sSWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=0Rl0v5xRgatSeT4LbtfWU/+BYGRfLaFJa6RLqnkNFtex6IN6EU5wZsQH66wG6rwGj
	 QKFgVP1JLfvaHz5LbozZiJ74xFuwTFOjBFC97GjqwLlvd+PQhnXlTmnYhFg758VLNR
	 +rPSyg3fDKy6TxJotaYFUvpLoPFvhcrS7MaDP1RU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.125
Date: Mon, 16 Feb 2026 10:39:13 +0100
Message-ID: <2026021613-rescuer-encroach-5787@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216674-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 46407142029
X-Rspamd-Action: no action

I'm announcing the release of the 6.6.125 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                            |    2 
 drivers/base/base.h                                 |    9 +
 drivers/base/bus.c                                  |    2 
 drivers/base/dd.c                                   |    2 
 drivers/bluetooth/btusb.c                           |    2 
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c   |    2 
 drivers/crypto/omap-crypto.c                        |    2 
 drivers/crypto/virtio/virtio_crypto_core.c          |    5 
 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c |    2 
 drivers/gpio/gpio-omap.c                            |   22 ++-
 drivers/net/phy/sfp.c                               |    2 
 drivers/net/wireless/realtek/rtw88/main.c           |    4 
 drivers/scsi/qla2xxx/qla_gs.c                       |   41 ++---
 drivers/scsi/qla2xxx/qla_init.c                     |   28 ++-
 drivers/scsi/qla2xxx/qla_isr.c                      |   19 ++
 drivers/scsi/qla2xxx/qla_os.c                       |    3 
 drivers/spi/spi-cadence-quadspi.c                   |   34 ++++
 fs/nfsd/nfsctl.c                                    |    9 +
 fs/nfsd/stats.c                                     |    4 
 fs/nfsd/stats.h                                     |    2 
 fs/nilfs2/sufile.c                                  |    4 
 fs/smb/client/cached_dir.h                          |    8 -
 fs/smb/server/server.c                              |    6 
 fs/smb/server/transport_tcp.c                       |    3 
 net/mptcp/pm_netlink.c                              |   16 +-
 net/netfilter/nf_tables_api.c                       |    2 
 net/netfilter/nft_compat.c                          |    6 
 net/netfilter/nft_log.c                             |    2 
 net/netfilter/nft_meta.c                            |    2 
 net/netfilter/nft_numgen.c                          |    2 
 net/netfilter/nft_set_pipapo.c                      |   64 ++++++--
 net/netfilter/nft_tunnel.c                          |    5 
 tools/testing/selftests/net/mptcp/pm_netlink.sh     |    4 
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c       |   11 +
 tools/testing/vsock/control.c                       |    9 -
 tools/testing/vsock/util.c                          |  143 ++++++++++++++++++++
 tools/testing/vsock/util.h                          |    7 
 tools/testing/vsock/vsock_test.c                    |   29 +---
 38 files changed, 405 insertions(+), 114 deletions(-)

Anil Gurumurthy (4):
      scsi: qla2xxx: Validate sp before freeing associated memory
      scsi: qla2xxx: Delay module unload while fabric scan in progress
      scsi: qla2xxx: Free sp in error path to fix system crash
      scsi: qla2xxx: Query FW again before proceeding with login

Bibo Mao (2):
      crypto: virtio - Add spinlock protection with virtqueue notification
      crypto: virtio - Remove duplicated virtqueue_kick in virtio_crypto_skcipher_crypt_req

Bitterblue Smith (1):
      wifi: rtw88: Fix alignment fault in rtw_core_enable_beacon()

Danilo Krummrich (1):
      gpio: omap: do not register driver in probe()

Edward Adam Davis (1):
      nilfs2: Fix potential block overflow that cause system hang

Eric Dumazet (1):
      mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()

Greg Kroah-Hartman (1):
      Linux 6.6.125

Gui-Dong Han (1):
      driver core: enforce device_lock for driver_match_device()

Henrique Carvalho (2):
      smb: client: split cached_fid bitfields to avoid shared-byte RMW races
      smb: server: fix leak of active_num_conn in ksmbd_tcp_new_connection()

Jeff Layton (1):
      nfsd: don't ignore the return code of svc_proc_register()

Kees Cook (1):
      crypto: omap - Allocate OMAP_CRYPTO_FORCE_COPY scatterlists correctly

Khairul Anuar Romli (1):
      spi: cadence-quadspi: Implement refcount to handle unbind during busy

Konstantin Shkolnyy (1):
      vsock/test: verify socket options after setting them

Marek Behún (1):
      net: sfp: Fix quirk for Ubiquiti U-Fiber Instant SFP module

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: pm: ensure unknown flags are ignored

Namjae Jeon (1):
      ksmbd: fix infinite loop caused by next_smb2_rcv_hdr_off reset in error paths

Pablo Neira Ayuso (2):
      netfilter: nf_tables: missing objects with no memcg accounting
      netfilter: nft_set_pipapo: prevent overflow in lookup table allocation

Shreyas Deodhar (1):
      scsi: qla2xxx: Allow recovery for tape devices

Thorsten Blum (1):
      crypto: octeontx - Fix length check to avoid truncation in ucode_load_store

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 7392:e611 for Edimax EW-7611UXB


