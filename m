Return-Path: <stable+bounces-244366-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHAOOyok+2mQWwMAu9opvQ
	(envelope-from <stable+bounces-244366-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 13:21:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5134D9AD7
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 13:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C8EF3014575
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 11:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A3C3E8C61;
	Wed,  6 May 2026 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt3EbMvp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132E3A3E67;
	Wed,  6 May 2026 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778066471; cv=none; b=oHsorOTub3879H2RyD233xW1T+vJpDrN7pTp+PlHMlKghRM3RtAJbI4Fc13fqgX+oJ+8AwO3JdgATrmR/9HsfzUNr/qlxHoyMd+iIakV99uxgyVMixmq9E/qbphacu7CLZ503A7GjgKKO/scG+3PesI8OjzMBT9PoZFe/rbtdgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778066471; c=relaxed/simple;
	bh=t8pAfFxbETZk+L6nG5wrJEImgnRQ7kft/H+f7Nkt/ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qIR6RUJxkGaBZ06z/r7T1wAym8V/k1BXHFxFl8c1jcfwp77KQFSU0nH5TOCFVosyf6oSLJ8R/xF5a0at+W5tpQV8tIDbin17QK0WiMOpMnHWOSxPAvhH3WJmuZrVczVLwVIng6E7I3SWxjKyw6bKiIdMVWWrDNUiKWqbXDeeHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt3EbMvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D38AC2BCB8;
	Wed,  6 May 2026 11:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778066470;
	bh=t8pAfFxbETZk+L6nG5wrJEImgnRQ7kft/H+f7Nkt/ao=;
	h=From:To:Cc:Subject:Date:From;
	b=Qt3EbMvpi+yqn36ygSRnOcoR3iAOCw+/CUWshY2WmMJS/pvpvIwFqnPHCM6+l3D7u
	 6r0DU/wkzllety+5i2sdnNyFBgt9GqROby3tjwIWG5Z51i2czIZJR6ivvFWfIFsrDe
	 Zg+DSSI95mIDGRKaaI0afG4cIDzih08or4+7HTjzGIZAWicHD2TJRbJwPFK5lhmA6N
	 R74LuY0JyZyYorcG8yQ8B3pJEhYN2ENo0uDzm3miXi8MpBPXIGLJ8PL/HZKK2Ncnua
	 MCbXzGlqfBjv103GoAelaMf1ys9PODgvZgdC6kNB/khpac5s03wk6L3fnp3+bmwK6b
	 XGAPtTzXfQVrQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Gang Yan <yangang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.18.y] mptcp: sync the msk->sndbuf at accept() time
Date: Wed,  6 May 2026 13:20:41 +0200
Message-ID: <20260506112040.3503275-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2562; i=matttbe@kernel.org; h=from:subject; bh=BEaBaPBycOtz3qPcGxLrqt/+6Rdvbe/eSge+OnR3do0=; b=kA0DAAoWfCLwwvNHCpcByyZiAGn7JAnIoee95nSGgQiUt2HCyEkSz0B0gn2+2RUnHINB5V+B5 oh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmn7JAkACgkQfCLwwvNHCpeFSQEAkw6b OLP+ZCaA2uxVh4stcM10u2771uDgnZTnXSZQBhABAPv9gBWIVKNqPd4AqiWIQd98eOP+NiDLDsK SYReva3IE
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C5134D9AD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244366-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,kylinos.cn:email]

From: Gang Yan <yangang@kylinos.cn>

commit fcf04b14334641f4b0b8647824480935e9416d52 upstream.

On passive MPTCP connections, the msk sndbuf is not updated correctly.

The root cause is an order issue in the accept path:

- tcp_check_req() -> subflow_syn_recv_sock() -> mptcp_sk_clone_init()
  calls __mptcp_propagate_sndbuf() to copy the ssk sndbuf into msk

- Later, tcp_child_process() -> tcp_init_transfer() ->
  tcp_sndbuf_expand() grows the ssk sndbuf.

So __mptcp_propagate_sndbuf() runs before the ssk sndbuf has been
expanded and the msk ends up with a much smaller sndbuf than the
subflow:

  MPTCP: msk->sndbuf:20480, msk->first->sndbuf:2626560

Fix this by moving the __mptcp_propagate_sndbuf() call from
mptcp_sk_clone_init() -- the ssk sndbuf is not yet finalized there -- to
__mptcp_propagate_sndbuf() at accept() time, when the ssk sndbuf has
been fully expanded by tcp_sndbuf_expand().

Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/602
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260420-net-mptcp-sync-sndbuf-accept-v1-1-e3523e3aeb44@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ No conflicts, but move __mptcp_propagate_sndbuf() above the for-loop
  (mptcp_for_each_subflow()) present in this version, which will modify
  'subflow' used by __mptcp_propagate_sndbuf() in this new patch. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 09e1a93b7daa..c805d36fe50d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3428,7 +3428,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	 * uses the correct data
 	 */
 	mptcp_copy_inaddrs(nsk, ssk);
-	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
 	msk->rcvq_space.time = mptcp_stamp();
@@ -4027,6 +4026,8 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		msk = mptcp_sk(newsk);
 		msk->in_accept_queue = 0;
 
+		__mptcp_propagate_sndbuf(newsk, mptcp_subflow_tcp_sock(subflow));
+
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
 		 */
-- 
2.53.0


