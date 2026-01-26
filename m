Return-Path: <stable+bounces-211679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOSGESHMd2mxlQEAu9opvQ
	(envelope-from <stable+bounces-211679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:18:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D6B8CF71
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4CFD30177AC
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 20:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D332D5410;
	Mon, 26 Jan 2026 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gG1qDI4x"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706B2D5408
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458710; cv=none; b=CNwgCdfeEeCKDOGNJdBNbWSEhsuvb36bIc/z54xQIbH2ECcrEpnqHMZTmGuWsefbw7HJZ9a8Tzgem3gzGJ6gWnYmgEJ+bnETdX4RJTKDq+kjed/qPC41eBhheoIgyo0zfFsOoUEvYwJCVHH2hnuzrnKJXo8X5WytpE77NsThdA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458710; c=relaxed/simple;
	bh=883OQnrK3u4KkT2O3LdCEJZBt9hl5rjn6RdXH57LzF0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WisbYi9C6kfi2m6Wt4ZdmjZmgQwHFXbQfD3R7UUcMh9yCmNxVp7TwE7ysV/ecqJ72JM5qDKedcPy6GsIfoB4wXxtgJJB0vircZF43KoMhN1cU+h8SrvLWfaolslUA0LJQAFKfwqrp89jGa9qevu7QPoKlgpq4AdzEfZkrzK0lUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gG1qDI4x; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=D+m9Z9q6zpIF23wgUxajFToTj4vnZ9SP8J3X5KTTlcA=; b=gG1qDI4xQfc075KLktZ9uX0lsw
	ZDMLstx9uPo7EW9FDJm3ZwZvhd8pRh/hQsccWsWleDIANc5kSOZ6KbCrHjQhI3qNKtgwBK+1mQdGK
	a2QjNoRmOcnE7vPulHpzXzjADnX448QDkH4m+TwvsRLzRgofW3xtnnaTY3BQiyz3ha7E81ds7ZcOl
	9HIEtEV6silPbsQQV2MAFlNd6/QmghSop//TrNpU3v4Gye2f7eJXjnAvNl0sX/SjUfHZdc3k5psNk
	OpS5go8bfBGdAEXIcTG3QRvdqE8UYnj/HrnmTCjIWwujP+to+ctf5qewS3yeCICfmn6Dzqg+oWYCM
	+6gPxtIg==;
Received: from 189-14-88-37.vmaxnet.com.br ([189.14.88.37] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vkT2G-00ABzB-BB; Mon, 26 Jan 2026 21:18:08 +0100
From: Heitor Alves de Siqueira <halves@igalia.com>
Subject: [PATCH 6.12 0/8] vsock: Backport nonlinear SKB allocation from
 mainline
Date: Mon, 26 Jan 2026 17:16:51 -0300
Message-Id: <20260126-backport-vsock-nonlinear-skb-6-12-v1-0-ad5c34853a60@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NwQrCMAyA4VcZORtZqlT0VcRD22UaKulIZAhj7
 27x+F3+fwNnE3a4DRsYr+LStIMOA5RX0iejTN0QxhBHojPmVOrS7IOrt1JRm75FORl6zRiRAl5
 PmWK+TDOnAr2zGM/y/T/uEI8U4LHvP4rgwL55AAAA
X-Change-ID: 20260114-backport-vsock-nonlinear-skb-6-12-93b16b7dfeac
To: stable@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Will Deacon <will@kernel.org>
Cc: kernel-dev@igalia.com, Heitor Alves de Siqueira <halves@igalia.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211679-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[halves@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,b4d960daf7a3c7c2b7b1];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8D6B8CF71
X-Rspamd-Action: no action

Hi stable maintainers,

This series backports vsock nonlinear SKB allocation support to 6.12.
We've uncovered significant memory allocation failures on ChromiumOS
kernels for workloads that rely on ARCVM or crostini containers; e.g.
when running Android apps, games or other intensive graphical
applications.

The memory allocation issues can be reproduced by stressing host/guest
communication via vsock, and seems to have a bigger impact on low-memory
devices (we've seen it mostly on devices with 4GB of total RAM), or when
the system is under heavy memory pressure. A straightforward reproducer
for ChromiumOS uses iperf3-vsock [0] running between the host and a
Linux container setup via ChromiumOS' "Linux Developer environment",
where the client will quickly fail with the following message:
iperf3: error - unable to write to stream socket: Cannot allocate memory

Patches 0001 through 0004 are required for the main nonlinear SKB
allocation patches. Patches 0005 and 0006 introduce nonlinear SKB
allocation support for the receive and transmit paths, respectively.
Patches 0007 and 0008 fix a syzbot reported WARNING that was introduced
by these patches in the transmit path. Patches 0001-0007 apply cleanly,
and 0008 needed minor changes to one of the function signatures. All
patches are already present in mainline and future stable kernels (v6.18
at this time).

[0] https://github.com/stefano-garzarella/iperf-vsock

Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
Will Deacon (8):
      vsock/virtio: Move length check to callers of virtio_vsock_skb_rx_put()
      vsock/virtio: Rename virtio_vsock_alloc_skb()
      vsock/virtio: Move SKB allocation lower-bound check to callers
      vsock/virtio: Rename virtio_vsock_skb_rx_put()
      vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers
      vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
      net: Introduce skb_copy_datagram_from_iter_full()
      vsock/virtio: Fix message iterator handling on transmit path

 drivers/vhost/vsock.c                   | 11 +++++-----
 include/linux/skbuff.h                  |  2 ++
 include/linux/virtio_vsock.h            | 39 ++++++++++++++++++++++++---------
 net/core/datagram.c                     | 14 ++++++++++++
 net/vmw_vsock/virtio_transport.c        |  6 +++--
 net/vmw_vsock/virtio_transport_common.c |  9 +++++---
 6 files changed, 60 insertions(+), 21 deletions(-)
---
base-commit: abf529abd660d8ccad46dd8c8f20e93db6134f5f
change-id: 20260114-backport-vsock-nonlinear-skb-6-12-93b16b7dfeac

Best regards,
-- 
Heitor Alves de Siqueira <halves@igalia.com>


