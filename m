Return-Path: <stable+bounces-247985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKwAF+tLB2qnxAIAu9opvQ
	(envelope-from <stable+bounces-247985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:38:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DAB5539F3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87445324A5FF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AA7305675;
	Fri, 15 May 2026 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J5Zvjigi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52647282F1A;
	Fri, 15 May 2026 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860575; cv=none; b=IT4r6N3hThpayMuwrnG2Yq58sb8Mq4oTkKdS5Fat5TVrbZIvThWYvjQEDzwuCWPQN1LvctSRP3KXQ/ZujkONLwNCKj67okdfvza+LpY28Oqo0VzvW+6x0LzBauWY0EOZI0lZrfunwHyHGlyLMBNLqLqnzL7K4pOKLarTHc1GEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860575; c=relaxed/simple;
	bh=5hJWP3YID+vi0QYbbhSs+uwcyddLNvcFV3499sbkAOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPfbSq02IIdA9crPWe9HsA48qOCkQS9SPHrCto3V+oRphmTqZv4HQm/0vrXKyMnqbI65hIlWt4gy5v1kpVWvV6FEIDshlsDB+aVd2Cdx0Xhs/TGX9d6FkrRD84KzAFDcEHxrmImvVERSNM69aNbjZrI3jlh8qS2OC8RS5vKjJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J5Zvjigi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7092C2BCB3;
	Fri, 15 May 2026 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860575;
	bh=5hJWP3YID+vi0QYbbhSs+uwcyddLNvcFV3499sbkAOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5ZvjigiopohKImvb1Y2I18Zj+2B8nWGeE4q6FNBUmNr4KoA/Pa92eI1LpNufKCnL
	 n++aYlectq/uXhkXP0jkblkYxzkIcbiN7ca0ExpCmix4/C5+DcrkBsbMExJHU3WWfd
	 4uED58cRBNadZ3eQKjmkVLB9uQC/jpSe5hA4NpAk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH 6.12 141/144] vsock/virtio: fix potential unbounded skb queue
Date: Fri, 15 May 2026 17:49:27 +0200
Message-ID: <20260515154656.794584978@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B3DAB5539F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247985-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sberdevices.ru:email,linux.dev:email,msgid.link:url,alibaba.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 059b7dbd20a6f0c539a45ddff1573cb8946685b5 upstream.

virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.

virtio_transport_recv_enqueue() skips coalescing for packets
with VIRTIO_VSOCK_SEQ_EOM.

If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
a very large number of packets can be queued
because vvs->rx_bytes stays at 0.

Fix this by estimating the skb metadata size:

	(Number of skbs in the queue) * SKB_TRUESIZE(0)

Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev
Link: https://patch.msgid.link/20260430122653.554058-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Cc: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/virtio_transport_common.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -430,7 +430,9 @@ static int virtio_transport_send_pkt_inf
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	if (vvs->buf_used + len > vvs->buf_alloc)
+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+
+	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
 		return false;
 
 	vvs->rx_bytes += len;



