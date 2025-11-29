Return-Path: <stable+bounces-197646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED5CC944AA
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 17:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C78DC4E2FEF
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EE6310627;
	Sat, 29 Nov 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfwoyPns"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91493101DD;
	Sat, 29 Nov 2025 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435517; cv=none; b=fSmffaWb+u+105N8e/aWjy+sh8/mAh5kLz/jJoDczjOVum+sFxpw9jxqG5g3vJlgj4irElLHcIkqPbwpLmWkIC1HpNnh8VhfWdgoEP7AAGlnTiDQPaCArkb8BvDSqO4Udj8zoodFzy8s7D2w67N8mnqywWLvLPYwquwMIlO9+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435517; c=relaxed/simple;
	bh=elDwJpHpz1bLpslsH967109im7PCjXXy6vD9qVspJaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsmKKbf7POohZibuOi/BCo0MeMkbrQsz3jbiolsSEj3X9/TKfZ+0DY4hqKSFFD5enTr9ryzmF1byBFfF3ioNcMes7jkKWnSxbuApMHe7m3+koyJVPj+5Jd9eYCyZbW107F9RtXqgcTOlei/ezuj9VQp5CL7Xt2HOeAe6Zn5KoqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfwoyPns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6EBC113D0;
	Sat, 29 Nov 2025 16:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764435517;
	bh=elDwJpHpz1bLpslsH967109im7PCjXXy6vD9qVspJaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfwoyPnsHDy0Cn/zg6G08gRJJgVV7/AycCM2B9IO3P9Uc+kzfbrKPykOiGJyCtzzS
	 0zH9PPS1L2EF/o5+2sJn2pZNBy2d6imMpW8ouavjXwWDRsNBP/CmEAQJpLF54Dyhq8
	 GhEg5FHHTr7cOCaA05akmbLHItt0jvJ6EiqSaSTN0v4yAM4sWycvCkI/jsgikrRP6k
	 +1AAw5CJaNc39dDn6K+iBaS4gk/hbFxul8QNRbS4iNAMp4xCZZtTE3gyXXjH+GiLIb
	 IRaLib4hiYKGt/VjKKBDJPmR9Sr2jSRvNz82MuCCaGjh09NECPp17b9oZh3YOxB15u
	 /8oD1QPtxcoXw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: avoid unneeded subflow-level drops
Date: Sat, 29 Nov 2025 17:58:26 +0100
Message-ID: <20251129165825.2129168-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112459-askew-underhand-3094@gregkh>
References: <2025112459-askew-underhand-3094@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4617; i=matttbe@kernel.org; h=from:subject; bh=cP/691EF6+t9xoc9pUiAlAF/w/jLO77KEFaHHUUJxFQ=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK11YzMO03X/TG15rdR4Cj6PdVhaciE3rX7v21mXHGqI urar0X3OkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZy+h7Df/dVjuZ8C/b0Sddu 0Y3UvaY19YC3lEuiUXnKn9p3c8VUzBj+8ORs67v5atO3tPlyuotv3JPb/Mq86/71PbNvHL5z6Mf bCawA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 4f102d747cadd8f595f2b25882eed9bec1675fb1 upstream.

The rcv window is shared among all the subflows. Currently, MPTCP sync
the TCP-level rcv window with the MPTCP one at tcp_transmit_skb() time.

The above means that incoming data may sporadically observe outdated
TCP-level rcv window and being wrongly dropped by TCP.

Address the issue checking for the edge condition before queuing the
data at TCP level, and eventually syncing the rcv window as needed.

Note that the issue is actually present from the very first MPTCP
implementation, but backports older than the blamed commit below will
range from impossible to useless.

Before:

  $ nstat -n; sleep 1; nstat -z TcpExtBeyondWindow
  TcpExtBeyondWindow              14                 0.0

After:

  $ nstat -n; sleep 1; nstat -z TcpExtBeyondWindow
  TcpExtBeyondWindow              0                  0.0

Fixes: fa3fe2b15031 ("mptcp: track window announced to peer")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-2-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in options.c, because the new rwin_update() helper has been
  added after __mptcp_snd_una_update() which is not in this version --
  see commit -- and then causing conflicts in the context. There were
  also some conflicts in mptcp_set_rwin(), because commit f3589be0c420
  ("mptcp: never shrink offered window") is not in this version. Only
  the update of subflow->rcv_wnd_sent has been added. Also
  msk->rcv_wnd_sent is a u64 before this commit: in rwin_update(),
  READ_ONCE() is used instead of atomic64_read(&). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 32 ++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |  1 +
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b4237e50e23f..85fcc378c711 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1001,6 +1001,31 @@ u64 __mptcp_expand_seq(u64 old_seq, u64 cur_seq)
 	return cur_seq;
 }
 
+static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
+			struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct tcp_sock *tp = tcp_sk(ssk);
+	u64 mptcp_rcv_wnd;
+
+	/* Avoid touching extra cachelines if TCP is going to accept this
+	 * skb without filling the TCP-level window even with a possibly
+	 * outdated mptcp-level rwin.
+	 */
+	if (!skb->len || skb->len < tcp_receive_window(tp))
+		return;
+
+	mptcp_rcv_wnd = READ_ONCE(msk->rcv_wnd_sent);
+	if (!after64(mptcp_rcv_wnd, subflow->rcv_wnd_sent))
+		return;
+
+	/* Some other subflow grew the mptcp-level rwin since rcv_wup,
+	 * resync.
+	 */
+	tp->rcv_wnd += mptcp_rcv_wnd - subflow->rcv_wnd_sent;
+	subflow->rcv_wnd_sent = mptcp_rcv_wnd;
+}
+
 static void ack_update_msk(struct mptcp_sock *msk,
 			   struct sock *ssk,
 			   struct mptcp_options_received *mp_opt)
@@ -1160,6 +1185,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (mp_opt.use_ack)
 		ack_update_msk(msk, sk, &mp_opt);
+	rwin_update(msk, sk, skb);
 
 	/* Zero-data-length packets are dropped by the caller and not
 	 * propagated to the MPTCP layer, so the skb extension does not
@@ -1212,7 +1238,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 static void mptcp_set_rwin(const struct tcp_sock *tp)
 {
 	const struct sock *ssk = (const struct sock *)tp;
-	const struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk;
 	u64 ack_seq;
 
@@ -1221,8 +1247,10 @@ static void mptcp_set_rwin(const struct tcp_sock *tp)
 
 	ack_seq = READ_ONCE(msk->ack_seq) + tp->rcv_wnd;
 
-	if (after64(ack_seq, READ_ONCE(msk->rcv_wnd_sent)))
+	if (after64(ack_seq, READ_ONCE(msk->rcv_wnd_sent))) {
 		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
+		subflow->rcv_wnd_sent = ack_seq;
+	}
 }
 
 static void mptcp_track_rwin(const struct tcp_sock *tp)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c93399d11650..3450c3cd015a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -417,6 +417,7 @@ struct mptcp_subflow_context {
 	u64	remote_key;
 	u64	idsn;
 	u64	map_seq;
+	u64	rcv_wnd_sent;
 	u32	snd_isn;
 	u32	token;
 	u32	rel_write_seq;
-- 
2.51.0


