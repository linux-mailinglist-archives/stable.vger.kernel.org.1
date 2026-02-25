Return-Path: <stable+bounces-218693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGo0EodYnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:03:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A452519074A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7501930EE0F9
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF48256C84;
	Wed, 25 Feb 2026 01:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H2KS8WIR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A02494FE;
	Wed, 25 Feb 2026 01:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983551; cv=none; b=S27BItJJKZ2MgBCOWbn4nW8fGzcbdv8f471nVTRsMTV1CfCeyS8HWVPHpR4oZ8oSXXjKdkLI8ubOAWxMASz/ZIE8gh2ACSiIKTkI8gRo+mSK8R5xLH4fp4c2A1QkKk+DX/7a1+JvYPnzvriZ08AXkwc4Hj/qMD5mQobrP4QMOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983551; c=relaxed/simple;
	bh=wsg4bld1gZkr04FZgRjj0OzXqESvndAcQ4qloLNy23Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyO0cFHC2I9KFzVU6It69z5DRLb57xjM1vE7+xlYL7TDHWtqqJlhMIc3nCZT9sB975CnP30zTvdXzwLk3f3FHxkzWbtB/Uc31AS1sHoSt+2nhpSigRLCziGtgoEYi/kgvcd+/RWci+P660cVqCLXtPT/zBi5M+/EkLQkNpBM21o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H2KS8WIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B32BC116D0;
	Wed, 25 Feb 2026 01:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983551;
	bh=wsg4bld1gZkr04FZgRjj0OzXqESvndAcQ4qloLNy23Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H2KS8WIRZbNqlXAdpLQ4UxDCiQVYH8pPUN9UCksogpjVuzVomBFN6JVJncuxQi06J
	 TTMOTlhthExYve4NudCZYYnMwnhr2f8bhjK7zOWKp8rib3PY2kY9LalklCjkTRAAp6
	 002IFGhge08NPlbHVA0c+uoQl9UwrP6flrXgt27Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antonio Quartulli <antonio@openvpn.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 653/781] ovpn: tcp - dont deref NULL sk_socket member after tcp_close()
Date: Tue, 24 Feb 2026 17:22:42 -0800
Message-ID: <20260225012415.807844492@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218693-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:email]
X-Rspamd-Queue-Id: A452519074A
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antonio Quartulli <antonio@openvpn.net>

[ Upstream commit 94560267d6c41b1ff3fafbab726e3f8a55a6af34 ]

When deleting a peer in case of keepalive expiration, the peer is
removed from the OpenVPN hashtable and is temporary inserted in a
"release list" for further processing.

This happens in:
ovpn_peer_keepalive_work()
  unlock_ovpn(release_list)

This processing includes detaching from the socket being used to
talk to this peer, by restoring its original proto and socket
ops/callbacks.

In case of TCP it may happen that, while the peer is sitting in
the release list, userspace decides to close the socket.
This will result in a concurrent execution of:

tcp_close(sk)
  __tcp_close(sk)
    sock_orphan(sk)
      sk_set_socket(sk, NULL)

The last function call will set sk->sk_socket to NULL.

When the releasing routine is resumed, ovpn_tcp_socket_detach()
will attempt to dereference sk->sk_socket to restore its original
ops member. This operation will crash due to sk->sk_socket being NULL.

Fix this race condition by testing-and-accessing
sk->sk_socket atomically under sk->sk_callback_lock.

Link: https://lore.kernel.org/netdev/176996279620.3109699.15382994681575380467@eldamar.lan/
Link: https://github.com/OpenVPN/ovpn-net-next/issues/29
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Link: https://patch.msgid.link/20260212213130.11497-1-antonio@openvpn.net
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ovpn/tcp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index f0b4e07ba9245..ec2bbc28c1966 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -199,7 +199,19 @@ void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock)
 	sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
 	sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
 	sk->sk_prot = peer->tcp.sk_cb.prot;
-	sk->sk_socket->ops = peer->tcp.sk_cb.ops;
+
+	/* tcp_close() may race this function and could set
+	 * sk->sk_socket to NULL. It does so by invoking
+	 * sock_orphan(), which holds sk_callback_lock before
+	 * doing the assignment.
+	 *
+	 * For this reason we acquire the same lock to avoid
+	 * sk_socket to disappear under our feet
+	 */
+	write_lock_bh(&sk->sk_callback_lock);
+	if (sk->sk_socket)
+		sk->sk_socket->ops = peer->tcp.sk_cb.ops;
+	write_unlock_bh(&sk->sk_callback_lock);
 
 	rcu_assign_sk_user_data(sk, NULL);
 }
-- 
2.51.0




