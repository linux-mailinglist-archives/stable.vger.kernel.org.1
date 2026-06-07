Return-Path: <stable+bounces-261860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9zjXOSpSJWrHGwIAu9opvQ
	(envelope-from <stable+bounces-261860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:12:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 799566505BB
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:12:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="V5rL/OWv";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261860-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261860-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CC483065DFE
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 11:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AF331ED80;
	Sun,  7 Jun 2026 11:02:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51CF3164A1;
	Sun,  7 Jun 2026 11:02:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830133; cv=none; b=nRsPz6uYG+ndGcGQLgLRtCvFNdGkbJ35ci2D4A9cKPv1deWMClvJaVrNYubtTBYXGOChtxr2tOX9InPc72FY10j6rrVJprWtpMaYk2Shx7o2Ejall1yQF0An06JODvtUBv7mX+avi4YWjgwVduS3bcU/Puib9jJqz9B4YlyvgI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830133; c=relaxed/simple;
	bh=9bueCvS5D4PaZQfT5FdIuJQeHt2MHOZ9Bv/qUQdvy6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTK3PwOlH/iJM8lUnGIuw8zDaiXnNSngaVYU1+qGh9J6bwHE2tDFrqA+kVyX0TSVJHLP5BkxAzmH1kc0Rm7tcDBiJrMcFNgX9N/5HC+hCSTC0XSFV+az/XRVu5R5Yv0u374p6KvYtIvm9z72RllQ/tVFRraJ8K5POW7eK+6HfW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V5rL/OWv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E231F00893;
	Sun,  7 Jun 2026 11:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780830132;
	bh=ts+/9sQdbTherPFetAYtw08TjzhLY7WVA1HWxHXIFrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V5rL/OWvGwM3o2yU4GPcMEfIwMR7BoVGqKGpkcS3Nj7i1kv98xbbypJMsnryiVvXz
	 scVPK2+KvKlTGn99F/ZDKkjr5XWrX65h6ar+wLs5lMhpMYxBwDsPoQM7lOeWqY7EHQ
	 wUNdkYx9+EbBo8NaDIDrEPM5B/0Y+Awmb5UfPkrM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 286/307] mptcp: introduce the mptcp_init_skb helper
Date: Sun,  7 Jun 2026 12:01:23 +0200
Message-ID: <20260607095738.238180170@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261860-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:matttbe@kernel.org,m:pabeni@redhat.com,m:geliang@kernel.org,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 799566505BB

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 9a0afe0db46720ce1a009c7dac168aa0584bd732 ]

Factor out all the skb initialization step in a new helper and
use it. Note that this change moves the MPTCP CB initialization
earlier: we can do such step as soon as the skb leaves the
subflow socket receive queues.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250927-net-next-mptcp-rcv-path-imp-v1-4-5da266aa9c1a@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 50c2d91c5dfa ("mptcp: do not drop partial packets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |   50 +++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -321,7 +321,7 @@ end:
 	mptcp_set_owner_r(skb, sk);
 }
 
-static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
+static bool mptcp_rmem_schedule(struct sock *sk, int size)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	int amt, amount;
@@ -339,27 +339,11 @@ static bool mptcp_rmem_schedule(struct s
 	return true;
 }
 
-static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
-			     struct sk_buff *skb, unsigned int offset,
-			     size_t copy_len)
+static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
+			   int copy_len)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-	struct sock *sk = (struct sock *)msk;
-	struct sk_buff *tail;
-	bool has_rxtstamp;
-
-	__skb_unlink(skb, &ssk->sk_receive_queue);
-
-	skb_ext_reset(skb);
-	skb_orphan(skb);
-
-	/* try to fetch required memory from subflow */
-	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
-		goto drop;
-	}
-
-	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	/* the skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
@@ -371,6 +355,25 @@ static bool __mptcp_move_skb(struct mptc
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
+	__skb_unlink(skb, &ssk->sk_receive_queue);
+
+	skb_ext_reset(skb);
+	skb_dst_drop(skb);
+}
+
+static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
+{
+	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *tail;
+
+	/* try to fetch required memory from subflow */
+	if (!mptcp_rmem_schedule(sk, skb->truesize)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
 		msk->bytes_received += copy_len;
@@ -391,7 +394,6 @@ static bool __mptcp_move_skb(struct mptc
 	 * will retransmit as needed, if needed.
 	 */
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
-drop:
 	mptcp_drop(sk, skb);
 	return false;
 }
@@ -720,7 +722,9 @@ static bool __mptcp_move_skbs_from_subfl
 			if (tp->urg_data)
 				done = true;
 
-			if (__mptcp_move_skb(msk, ssk, skb, offset, len))
+			mptcp_init_skb(ssk, skb, offset, len);
+			skb_orphan(skb);
+			if (__mptcp_move_skb(sk, skb))
 				moved += len;
 			seq += len;
 


t t;
 
-	if (!chan || !chan->cl)
+	if (!chan || !chan->cl || mssg == MBOX_NO_MSG)
 		return -EINVAL;
 
 	t = add_to_rbuf(chan, mssg);
@@ -319,7 +319,7 @@ static int __mbox_bind_client(struct mbo
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		chan->msg_free = 0;
 		chan->msg_count = 0;
-		chan->active_req = NULL;
+		chan->active_req = MBOX_NO_MSG;
 		chan->cl = cl;
 		init_completion(&chan->tx_complete);
 
@@ -477,7 +477,7 @@ void mbox_free_channel(struct mbox_chan
 	/* The queued TX requests are simply aborted, no callbacks are made */
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		chan->cl = NULL;
-		chan->active_req = NULL;
+		chan->active_req = MBOX_NO_MSG;
 		if (chan->txdone_method == TXDONE_BY_ACK)
 			chan->txdone_method = TXDONE_BY_POLL;
 	}
@@ -531,6 +531,7 @@ int mbox_controller_register(struct mbox
 
 		chan->cl = NULL;
 		chan->mbox = mbox;
+		chan->active_req = MBOX_NO_MSG;
 		chan->txdone_method = txdone;
 		spin_lock_init(&chan->lock);
 	}
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -497,7 +497,7 @@ static int tegra_hsp_mailbox_flush(struc
 			mbox_chan_txdone(chan, 0);
 
 			/* Wait until channel is empty */
-			if (chan->active_req != NULL)
+			if (chan->active_req != MBOX_NO_MSG)
 				continue;
 
 			return 0;
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -11,6 +11,9 @@
 
 struct mbox_chan;
 
+/* Sentinel value distinguishing "no active request" from "NULL message data" */
+#define MBOX_NO_MSG	((void *)-1)
+
 /**
  * struct mbox_chan_ops - methods to control mailbox channels
  * @send_data:	The API asks the MBOX controller driver, in atomic



