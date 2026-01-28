Return-Path: <stable+bounces-212474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AKsBW83eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:21:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 45001A5754
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02ECC30EE9AA
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B14F305E2E;
	Wed, 28 Jan 2026 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rnvg7eel"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE02E2DF4;
	Wed, 28 Jan 2026 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615640; cv=none; b=Bfw/H9qvFZFCDBQkbPlhkt9ngo5jPfygLrxHrQhG/LrXRLE7vKhL8SZ1h9/FQXIfqpWXn1PNYB1UuG8eZdG3ULPzQwDA2ko1YmaxAg3EC3mKlXcnDiUGyrsxeI/ZjX9SVoDS4x3GDTN2qntLTLPjPEPdYKVrAkOkAitgFJib7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615640; c=relaxed/simple;
	bh=pzrdnueCqbSOy+/PJbIMn1JgSrJ5z9RxPWFdgpkJeZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dais1VerqOK1nC8BXYhb565O6JGWDGWrL/83xjSOIZ2bwrbAmwQlcs5AuYx9mvAxtCfJ54Re1rlLOnHIWgcw1cuTr5xO6aYtdvrqMsNwhLAkPCPxkajiXggcn/TdHYvnmrJkERm6mafV6QHUy4iF4ecFqEmJMKFgp7wOuX4R21c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rnvg7eel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F285C4CEF1;
	Wed, 28 Jan 2026 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615640;
	bh=pzrdnueCqbSOy+/PJbIMn1JgSrJ5z9RxPWFdgpkJeZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rnvg7eelWOmjcx08QQ63TQm2jsUSIhCDBJ0WcCWiDVSFX89BNwNsiFhbYykvRhY9K
	 iFeuMqzBwM7Gj0oTkNYgpgNB8gIufhxmOnN8tNQ/uj9QxMxSTPqW6BQPtMOyQtU85/
	 X1Y2IPFX6KyrmNUnJdI8NPZfOlaxKK0gyPGW/pns=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Luczaj <mhal@rbox.co>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 027/227] vsock/virtio: Coalesce only linear skb
Date: Wed, 28 Jan 2026 16:21:12 +0100
Message-ID: <20260128145345.322972691@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212474-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,rbox.co:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 45001A5754
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit 0386bd321d0f95d041a7b3d7b07643411b044a96 ]

vsock/virtio common tries to coalesce buffers in rx queue: if a linear skb
(with a spare tail room) is followed by a small skb (length limited by
GOOD_COPY_LEN = 128), an attempt is made to join them.

Since the introduction of MSG_ZEROCOPY support, assumption that a small skb
will always be linear is incorrect. In the zerocopy case, data is lost and
the linear skb is appended with uninitialized kernel memory.

Of all 3 supported virtio-based transports, only loopback-transport is
affected. G2H virtio-transport rx queue operates on explicitly linear skbs;
see virtio_vsock_alloc_linear_skb() in virtio_vsock_rx_fill(). H2G
vhost-transport may allocate non-linear skbs, but only for sizes that are
not considered for coalescence; see PAGE_ALLOC_COSTLY_ORDER in
virtio_vsock_alloc_skb().

Ensure only linear skbs are coalesced. Note that skb_tailroom(last_skb) > 0
guarantees last_skb is linear.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://patch.msgid.link/20260113-vsock-recv-coalescence-v2-1-552b17837cf4@rbox.co
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/virtio_transport_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e6..26b979ad71f09 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1359,9 +1359,11 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 
 	/* Try to copy small packets into the buffer of last packet queued,
 	 * to avoid wasting memory queueing the entire buffer with a small
-	 * payload.
+	 * payload. Skip non-linear (e.g. zerocopy) skbs; these carry payload
+	 * in skb_shinfo.
 	 */
-	if (len <= GOOD_COPY_LEN && !skb_queue_empty(&vvs->rx_queue)) {
+	if (len <= GOOD_COPY_LEN && !skb_queue_empty(&vvs->rx_queue) &&
+	    !skb_is_nonlinear(skb)) {
 		struct virtio_vsock_hdr *last_hdr;
 		struct sk_buff *last_skb;
 
-- 
2.51.0




