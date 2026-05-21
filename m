Return-Path: <stable+bounces-253436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMorD6B3DmrK+wUAu9opvQ
	(envelope-from <stable+bounces-253436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 05:10:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A245A59E4E5
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 05:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 808003029E62
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 03:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF38360EC2;
	Thu, 21 May 2026 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBMz5IOA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16E831ED81;
	Thu, 21 May 2026 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333017; cv=none; b=M3YvaNb3PxscTtF173YhAZ4k2z/L6K3+AmBNH3z1OfBPKVRBYXrAI/OmTXrcQQIJu1otNjnZnfZohZXboLLIvAbA5rjt3DNn6eCTj/Af3qYUkiEZedybULqS+EsblJ19aum3OXmJubIndyWSWUV4FZVWD8OSM7QC8xqGzc48rlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333017; c=relaxed/simple;
	bh=URxeR5p80vIacR8K9TNWnsdP2ESWb8SKRcC54sCAElM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRDiuyRV9DuthfAWNoNLBrtc5w/GjXKE7297BO8uJls0xyytryxwmec7J/jBlP5E62kESgHC101l1CEeuROUBpCwPkceVucUdc0ZA5hZrPEcADGvd1JfqH7yY6j3BDcixNPHYv5Pms6YVz/UCf/H7igsQsk7uNBiilgu3DNERbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBMz5IOA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238BA1F00A3C;
	Thu, 21 May 2026 03:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779333015;
	bh=3SwOIApy4Ywfvh2YktSUdrEvcUgi19aX6QruE2QI2F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZBMz5IOAXpyPQNDizFI5Z5zvXpJK+UM3OHwDwHSTCVy3N9twG8XfAjeX7q+eeYD/B
	 aaWR6adQvjLQbo6Dotv12vqTa2HrWExZFwBZZJ9in6o165agnlmLPKrBAA2zL2VOVR
	 nC8wv17cQ3bg/LIt5p+ra8Td+/wwKAMbj9SgySJI/k+FqCY2hr52Kj/HviMXbPcEGP
	 7h5ejVVyk9sUZuDEmY5J3p7uBQHsX8H2qjSO15S5DC6bidF3y6WLwiivDx+gqvZ5xi
	 GHIleLwNWDzsVZXVedKGBZ6rTq+U6KAQ07IN28kJXh4B8NeJFdMPIvQBVJ6h69oXk7
	 LcSYPGquSeI5A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Gang Yan <yangang@kylinos.cn>,
	sashal@kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.12.y 1/4] mptcp: sync the msk->sndbuf at accept() time
Date: Thu, 21 May 2026 05:08:47 +0200
Message-ID: <20260521030845.723267-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521030845.723267-6-matttbe@kernel.org>
References: <20260521030845.723267-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2562; i=matttbe@kernel.org; h=from:subject; bh=Z1WmgW/XUwdgdszC3CBMFu/v914ILVv5o7ffFe9nHvw=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLL4ygPsfpxfE1K9tSPpbsP1GQf4PsrureWddcGziW9xa 7+L9syTHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABP5a87wVyLP6Xvz8ismC69n Gvacd7p8Mobt7jnunQ1LWlZz2Ff+Os/I8NBhZrLEy5Y5wac4alznf5izp7rg0+GFqX2dsf79q2T 6eAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253436-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,msgid.link:url]
X-Rspamd-Queue-Id: A245A59E4E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 7dbb666c72c3..c1b1fb0fe8bc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3493,7 +3493,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	 * uses the correct data
 	 */
 	mptcp_copy_inaddrs(nsk, ssk);
-	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
 	msk->rcvq_space.time = mptcp_stamp();
@@ -4101,6 +4100,8 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		msk = mptcp_sk(newsk);
 		msk->in_accept_queue = 0;
 
+		__mptcp_propagate_sndbuf(newsk, mptcp_subflow_tcp_sock(subflow));
+
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
 		 */
-- 
2.53.0


