Return-Path: <stable+bounces-254812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEAVK6oVGGprcwgAu9opvQ
	(envelope-from <stable+bounces-254812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:15:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C0C5F0631
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B62F53193B00
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691E038656D;
	Thu, 28 May 2026 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t7SKSPR0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099FC35B62C
	for <stable@vger.kernel.org>; Thu, 28 May 2026 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962565; cv=none; b=jkrQM1waNji+ebFjA+Faprt6T6mHs3jVjPldf61izjm8GMDlpMqvsCMelAzFgIPkFq1pE6uYe6n4wCckE9NoeiTtm4+wG3myPGK0rp+t2KCg0Lw4Az5FNmjPWYnNG/Pbpcd1jIYF5ggMAczubCZBi3e0r09yJXWEO4OUa+VKJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962565; c=relaxed/simple;
	bh=VNdfauwhLtDNUOaa+USzu0jD/TLoPj5etwC7PQ/v4c8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NBsWYJeA53C9WKGwNsxYhkAsL6/k7jjnAxi5RoaBMcVUoPppZhFfrmPeuPprfIHCXoyz1WJT3iimxLr81pkknRNw1rtswSm3BvIpuwAO+UGleGJONntIi0vXOCFO62Xao2XtQeFesC8NLk41dp+gTYu7DQJuLk6Q6tUQ3EBcQTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t7SKSPR0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6008F1F000E9;
	Thu, 28 May 2026 10:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779962563;
	bh=Q/6dILKNYMGqzOMgh8d6tv3lVVF0np3MceaewgED++w=;
	h=Subject:To:Cc:From:Date;
	b=t7SKSPR0WoisrFBQrzUbesUHTPWVnIyX8L3NVjWdMXzsFjzsVHJqF/zAweo9a6kaZ
	 bRtcwoRf6GlxAY7KYzksGcLesnmBt9pSm3NDg11sTkNeNPnQsVyylDqL3PrFpDKXZV
	 tw+BoB3ZSF++gzZPHtTGx0wk24/BwnQPI3zU1Q8U=
Subject: FAILED: patch "[PATCH] mptcp: do not drop partial packets" failed to apply to 5.10-stable tree
To: shardul.b@mpiricsoftware.com,matttbe@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 12:01:39 +0200
Message-ID: <2026052839-kudos-clear-0573@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254812-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 12C0C5F0631
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 50c2d91c5dfa0e465826ec1f8dbad9cdc254bd85
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052839-kudos-clear-0573@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 50c2d91c5dfa0e465826ec1f8dbad9cdc254bd85 Mon Sep 17 00:00:00 2001
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Fri, 15 May 2026 06:27:32 +0200
Subject: [PATCH] mptcp: do not drop partial packets

When a packet arrives with map_seq < ack_seq < end_seq, the beginning
of the packet has already been acknowledged but the end contains new
data. Currently the entire packet is dropped as "old data," forcing
the sender to retransmit.

Instead, skip the already-acked bytes by adjusting the skb offset and
enqueue only the new portion. Update bytes_received and ack_seq to
reflect the new data consumed.

A previous attempt at this fix has been sent by Paolo Abeni [1], but had
issues [2]: it also added a zero-window check and changed rcv_wnd_sent
initialization, which caused test regressions. This version addresses
only the partial packet handling without modifying receive window
accounting.

Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/c9b426a4e163aa3c4fe8b80c79f1a610f47ae7d8.1763075056.git.pabeni@redhat.com [1]
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/600 [2]
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
[pabeni@redhat.com: update map]
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260515-net-mptcp-misc-fixes-7-1-rc4-v2-1-701e96419f2f@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4546a8b09884..859df49e16dc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -397,12 +397,26 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		return false;
 	}
 
-	/* old data, keep it simple and drop the whole pkt, sender
-	 * will retransmit as needed, if needed.
+	/* Completely old data? */
+	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
+	/* Partial packet: map_seq < ack_seq < end_seq.
+	 * Skip the already-acked bytes and enqueue the new data.
 	 */
-	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
-	mptcp_drop(sk, skb);
-	return false;
+	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+	MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
+				      MPTCP_SKB_CB(skb)->map_seq;
+	msk->bytes_received += copy_len;
+	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
+
+	skb_set_owner_r(skb, sk);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	return true;
 }
 
 static void mptcp_stop_rtx_timer(struct sock *sk)


