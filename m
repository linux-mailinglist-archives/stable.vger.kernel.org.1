Return-Path: <stable+bounces-247986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJemOdJFB2p6wAIAu9opvQ
	(envelope-from <stable+bounces-247986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:12:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A66CE552D0C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 821DB30A26C1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FC93FF1DE;
	Fri, 15 May 2026 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RZ2hKzDJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09DA22FF22;
	Fri, 15 May 2026 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860578; cv=none; b=HQ0a9Fycxv6GiYRpzhW0U8z1vTk44bbHCX92jLUd4iwILKsRihbUnf471trDgSduL3Olggt9iFWFz8l3Hc0JxID9rLs4yQ0F6qtBtc4JFu/kZFKE+B9mUYIv/H69MqqRM4zFUk8GuDsuKkropyjQrVwcMWb32nJiIdbYU6mcdx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860578; c=relaxed/simple;
	bh=hu4FeAUstoEbKfQGgfr1EpDWyKsN0w77ejAt+YhCios=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyyGRyDjfYbe+ozM/HJLPz3aAcIa3Oc8qMDyg4N783cnSz/5LhpQuOlSaLnRhvymMEiupFhQDX79G14VTmICAwETNCyP6/1jg667Dkul8jyOtTlZlcnIMt+b62AdwMT/QfmG+Or+d88EjRMqo7l+09GZTsp0kWzjN28+BLzVBPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RZ2hKzDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74729C2BCB0;
	Fri, 15 May 2026 15:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860577;
	bh=hu4FeAUstoEbKfQGgfr1EpDWyKsN0w77ejAt+YhCios=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZ2hKzDJFbU7N3UyYQTyoq2Q0wryrx7MlgWjBOdmJsHEW0tjU4nJC95YJHZ/TQ9B9
	 Ru450MRmoEtHWxx2ooc3sxhFY/BXHtuK3E2TezInctLaboUEQ+JFQyBXwiESYfAe8V
	 /snAqkJeFOm23KzQ62iii5ve5EfroRtNZRSSjXSU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dudu Lu <phx0fer@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Luigi Leonardi <leonardi@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12 142/144] vsock/virtio: fix accept queue count leak on transport mismatch
Date: Fri, 15 May 2026 17:49:28 +0200
Message-ID: <20260515154656.819394717@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A66CE552D0C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,meta.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-247986-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,meta.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dudu Lu <phx0fer@gmail.com>

commit 52bcb57a4e8a0865a76c587c2451906342ae1b2d upstream.

virtio_transport_recv_listen() calls sk_acceptq_added() before
vsock_assign_transport(). If vsock_assign_transport() fails or
selects a different transport, the error path returns without
calling sk_acceptq_removed(), permanently incrementing
sk_ack_backlog.

After approximately backlog+1 such failures, sk_acceptq_is_full()
returns true, causing the listener to reject all new connections.

Fix by moving sk_acceptq_added() to after the transport validation,
matching the pattern used by vmci_transport and hyperv_transport.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://patch.msgid.link/20260413131409.19022-1-phx0fer@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Cc: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/virtio_transport_common.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1548,8 +1548,6 @@ virtio_transport_recv_listen(struct sock
 		return -ENOMEM;
 	}
 
-	sk_acceptq_added(sk);
-
 	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
 
 	child->sk_state = TCP_ESTABLISHED;
@@ -1571,6 +1569,7 @@ virtio_transport_recv_listen(struct sock
 		return ret;
 	}
 
+	sk_acceptq_added(sk);
 	if (virtio_transport_space_update(child, skb))
 		child->sk_write_space(child);
 



