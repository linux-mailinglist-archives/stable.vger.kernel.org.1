Return-Path: <stable+bounces-196732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60697C80D83
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CF314E217B
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BECF30B51A;
	Mon, 24 Nov 2025 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="upSWUKoK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E530B514
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992202; cv=none; b=ERYVTvEZGmqER8v15Hwzj+WriKPfb8K0ifs/EV+ZGBu/ITjs4ah0HfmA9ZQp+E14sgse4H6y/f6wNu9q7xOpWuewKYtjFE31zHXqgYigYJX0P6BlEGD5kA+xN78ogCpZ1R5QRbXl1Cnc2QGeo0PR9SCp0rW/CpWyCWhJUGb9OZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992202; c=relaxed/simple;
	bh=Vm3wp5JyDvMz3GYzleeDg2OnIDUcDw3b2WPguG0HAr8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cAHOONJ/SdXhpKY2Uq2u6I7nkI3fJQs1ayNHVmN+0ZExVbaJow5mjGCBEXRkaRu8kaRmXufWDMT1HGP/PT/gne0bmxdqiR7wO5YgY4avL2OTBW5lHP1WHnL6T3ZphLijarIoaECFaLIfDfoa3uBHNwGI9kovKZy7e/6ofjO1qiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=upSWUKoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8A6C4CEF1;
	Mon, 24 Nov 2025 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763992202;
	bh=Vm3wp5JyDvMz3GYzleeDg2OnIDUcDw3b2WPguG0HAr8=;
	h=Subject:To:Cc:From:Date:From;
	b=upSWUKoK+4a3PqSQ5m57s81WLGsCQck7S7QuT6YSJ0ohe0UtdIEBQ8rphzSvRU52z
	 pZgKTbkSRdYYplzDB79Wke21a/L73pAi5vIaEVIo1vLDoyQCZmPGAtk+VMY4ngRp41
	 WPwRkfazUCunNfTL9IY8sQVhedQWNbMUuwdJ+Q1E=
Subject: FAILED: patch "[PATCH] mptcp: avoid unneeded subflow-level drops" failed to apply to 5.15-stable tree
To: pabeni@redhat.com,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:49:59 +0100
Message-ID: <2025112459-askew-underhand-3094@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4f102d747cadd8f595f2b25882eed9bec1675fb1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112459-askew-underhand-3094@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f102d747cadd8f595f2b25882eed9bec1675fb1 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 18 Nov 2025 08:20:20 +0100
Subject: [PATCH] mptcp: avoid unneeded subflow-level drops

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

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a63bd00807d..f24ae7d40e88 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1044,6 +1044,31 @@ static void __mptcp_snd_una_update(struct mptcp_sock *msk, u64 new_snd_una)
 	WRITE_ONCE(msk->snd_una, new_snd_una);
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
+	mptcp_rcv_wnd = atomic64_read(&msk->rcv_wnd_sent);
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
@@ -1211,6 +1236,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (mp_opt.use_ack)
 		ack_update_msk(msk, sk, &mp_opt);
+	rwin_update(msk, sk, skb);
 
 	/* Zero-data-length packets are dropped by the caller and not
 	 * propagated to the MPTCP layer, so the skb extension does not
@@ -1297,6 +1323,10 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 
 	if (rcv_wnd_new != rcv_wnd_old) {
 raise_win:
+		/* The msk-level rcv wnd is after the tcp level one,
+		 * sync the latter.
+		 */
+		rcv_wnd_new = rcv_wnd_old;
 		win = rcv_wnd_old - ack_seq;
 		tp->rcv_wnd = min_t(u64, win, U32_MAX);
 		new_win = tp->rcv_wnd;
@@ -1320,6 +1350,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 
 update_wspace:
 	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
+	subflow->rcv_wnd_sent = rcv_wnd_new;
 }
 
 static void mptcp_track_rwin(struct tcp_sock *tp)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 379a88e14e8d..5575ef64ea31 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -509,6 +509,7 @@ struct mptcp_subflow_context {
 	u64	remote_key;
 	u64	idsn;
 	u64	map_seq;
+	u64	rcv_wnd_sent;
 	u32	snd_isn;
 	u32	token;
 	u32	rel_write_seq;


