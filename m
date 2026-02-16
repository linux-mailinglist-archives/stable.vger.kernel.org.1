Return-Path: <stable+bounces-216676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBoiHC7mkmlSzwEAu9opvQ
	(envelope-from <stable+bounces-216676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:41:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BF714204E
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37A7D3013277
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 09:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4D72DF6F6;
	Mon, 16 Feb 2026 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EU/gpfQj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C6E2E54BD;
	Mon, 16 Feb 2026 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771234767; cv=none; b=sR12H+2qmttLbRB+qWqzUGHUXF3yPzqVApLsWV3MGROkrhYEu99y6t/MPG1BGxpcTC9vElfAH8cD3+q1DdhOEwfdR6kSYt8qfzshgatM2gU/ccvXmKMbEGJl7wt9Zo5h2qifj6wErnH8KiRj1aaOxLIvc70BpkVJLxkPL0/s5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771234767; c=relaxed/simple;
	bh=9PF8IPfRLsmSt/Om1pxqZu6/yirSXEh9/dgHIIaiWOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVMYz0MK6v0v6zmC6mGPSH2zCEqwl+yVn/A1Ek4xALckhqxg2df+Z6uKHG/a7W3VfgAjETqmR4SmCyhEIYivX7VmTIbiNU7uiIvQHIavY/kyiuoYGT048Lzc4rigHK5qPO97Da9EUOviURLxp/zIPHHuid08op1rwbL/ktGBi8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EU/gpfQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065C2C116C6;
	Mon, 16 Feb 2026 09:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771234767;
	bh=9PF8IPfRLsmSt/Om1pxqZu6/yirSXEh9/dgHIIaiWOI=;
	h=From:To:Cc:Subject:Date:From;
	b=EU/gpfQjpEpSlcklKOIYtCkG6AhOQIG9qZ5HlV95++aNdhSoXFRIUKTapiTf7BC3W
	 bX3It3g/6D2I8nJGG21g4Hpl2OL9QWWN6CrTf14RnAZHqn3Y43sg1DfcdkPDxGveJi
	 Miupmgv+Y9ZQZdX3m756jmqP8RBcftlA1X5xbHNs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.11
Date: Mon, 16 Feb 2026 10:39:20 +0100
Message-ID: <2026021621-dicing-rudder-7078@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216676-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C9BF714204E
X-Rspamd-Action: no action

I'm announcing the release of the 6.18.11 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                            |    2 
 drivers/base/base.h                                 |    9 
 drivers/base/bus.c                                  |    2 
 drivers/base/dd.c                                   |    2 
 drivers/bluetooth/btusb.c                           |    2 
 drivers/bus/fsl-mc/fsl-mc-bus.c                     |    6 
 drivers/crypto/intel/iaa/iaa_crypto_main.c          |   12 
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c   |    2 
 drivers/crypto/omap-crypto.c                        |    2 
 drivers/crypto/virtio/virtio_crypto_core.c          |    5 
 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c |    2 
 drivers/gpio/gpio-omap.c                            |   22 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c            |   38 +
 drivers/net/wireless/realtek/rtl8xxxu/core.c        |    1 
 drivers/net/wireless/realtek/rtw88/main.c           |    4 
 drivers/pci/endpoint/pci-ep-cfs.c                   |   15 
 drivers/scsi/qla2xxx/qla_gs.c                       |   41 -
 drivers/scsi/qla2xxx/qla_init.c                     |   28 -
 drivers/scsi/qla2xxx/qla_isr.c                      |   19 
 drivers/scsi/qla2xxx/qla_os.c                       |    3 
 fs/erofs/fileio.c                                   |    7 
 fs/hfs/mdb.c                                        |   35 -
 fs/hfs/super.c                                      |   10 
 fs/nilfs2/sufile.c                                  |    4 
 fs/smb/client/cached_dir.h                          |    8 
 fs/smb/client/smbdirect.c                           |  523 +++++++++++++++-----
 fs/smb/common/smbdirect/smbdirect_socket.h          |   18 
 fs/smb/server/mgmt/user_session.c                   |    5 
 fs/smb/server/mgmt/user_session.h                   |    1 
 fs/smb/server/server.c                              |    6 
 fs/smb/server/smb2pdu.c                             |   12 
 fs/smb/server/transport_rdma.c                      |  147 +++++
 fs/smb/server/transport_tcp.c                       |    3 
 fs/xfs/scrub/btree.c                                |    7 
 io_uring/io-wq.c                                    |   27 -
 io_uring/io-wq.h                                    |    1 
 io_uring/tctx.c                                     |   11 
 sound/hda/codecs/conexant.c                         |    1 
 38 files changed, 798 insertions(+), 245 deletions(-)

Ali Tariq (1):
      wifi: rtl8xxxu: fix slab-out-of-bounds in rtl8xxxu_sta_add

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

Chao Yu (1):
      erofs: fix UAF issue for file-backed mounts w/ directio option

Danilo Krummrich (1):
      gpio: omap: do not register driver in probe()

Darrick J. Wong (1):
      xfs: fix UAF in xchk_btree_check_block_owner

Edward Adam Davis (1):
      nilfs2: Fix potential block overflow that cause system hang

Greg Kroah-Hartman (1):
      Linux 6.18.11

Gui-Dong Han (2):
      driver core: enforce device_lock for driver_match_device()
      bus: fsl-mc: fix use-after-free in driver_override_show()

Henrique Carvalho (2):
      smb: client: split cached_fid bitfields to avoid shared-byte RMW races
      smb: server: fix leak of active_num_conn in ksmbd_tcp_new_connection()

Jeongjun Park (1):
      drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free

Kees Cook (1):
      crypto: omap - Allocate OMAP_CRYPTO_FORCE_COPY scatterlists correctly

Li Chen (2):
      io_uring/io-wq: add exit-on-idle state
      io_uring: allow io-wq workers to exit when unused

Liu Song (1):
      PCI: endpoint: Avoid creating sub-groups asynchronously

Mehdi Ben Hadj Khelifa (1):
      hfs: ensure sb->s_fs_info is always cleaned up

Namjae Jeon (2):
      ksmbd: fix infinite loop caused by next_smb2_rcv_hdr_off reset in error paths
      ksmbd: add chann_lock to protect ksmbd_chann_list xarray

Shreyas Deodhar (1):
      scsi: qla2xxx: Allow recovery for tape devices

Stefan Metzmacher (20):
      smb: smbdirect: introduce smbdirect_socket.recv_io.credits.available
      smb: smbdirect: introduce smbdirect_socket.send_io.bcredits.*
      smb: server: make use of smbdirect_socket.recv_io.credits.available
      smb: server: let recv_done() queue a refill when the peer is low on credits
      smb: server: make use of smbdirect_socket.send_io.bcredits
      smb: server: fix last send credit problem causing disconnects
      smb: server: let send_done handle a completion without IB_SEND_SIGNALED
      smb: client: make use of smbdirect_socket.recv_io.credits.available
      smb: client: let recv_done() queue a refill when the peer is low on credits
      smb: client: let smbd_post_send() make use of request->wr
      smb: client: remove pointless sc->recv_io.credits.count rollback
      smb: client: remove pointless sc->send_io.pending handling in smbd_post_send_iter()
      smb: client: port and use the wait_for_credits logic used by server
      smb: client: split out smbd_ib_post_send()
      smb: client: introduce and use smbd_{alloc, free}_send_io()
      smb: client: use smbdirect_send_batch processing
      smb: client: make use of smbdirect_socket.send_io.bcredits
      smb: client: fix last send credit problem causing disconnects
      smb: client: let smbd_post_send_negotiate_req() use smbd_post_send()
      smb: client: let send_done handle a completion without IB_SEND_SIGNALED

Takashi Iwai (1):
      ALSA: hda/conexant: Add quirk for HP ZBook Studio G4

Thorsten Blum (2):
      crypto: iaa - Fix out-of-bounds index in find_empty_iaa_compression_mode
      crypto: octeontx - Fix length check to avoid truncation in ucode_load_store

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 7392:e611 for Edimax EW-7611UXB


