Return-Path: <stable+bounces-263241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XAWCO5kLMGrCMQUAu9opvQ
	(envelope-from <stable+bounces-263241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:26:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9BD687227
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:26:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=xDdyuOTs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263241-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263241-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A577F307A3FB
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A7E3F7875;
	Mon, 15 Jun 2026 14:25:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0373F7A9A
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:25:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533552; cv=none; b=aosJBVKBckfa4vHl9D7fGCH9UtUETfHiFkRY0Kb6HWCL+rFVCZhtw9fEASt2OAXwnAdHXMDC50XZRYfuj29uA+QdIXc81cw7Kzwu4YlMee8h9yM5C4BU4TKkSmKqbv2P8qqxTU6uwMBeFO40DWZcJJ6dlOjI6xQDUAeDNF8ELMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533552; c=relaxed/simple;
	bh=2DAvHYGdfx2rrdUYYLBwln5LyZGi0OlPzo4W5O9BIA4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YUZOn6KBid74IwTvBDwXaJ5rGebQyKMz99HJ2IDDN+870CColNmSM5RrcYmDSZgjc+AeVburHQuRRvq5Fo+1PlEHGZgen+gMNFdlBmE6TdESr2uR2c7rSRIvFy9uBH+NMn2wi0JpEvz6m8eDs+kJTtaPnHAKy8STbinUfN8UPXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xDdyuOTs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF0D1F000E9;
	Mon, 15 Jun 2026 14:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533550;
	bh=/bjz9Q1zrKlXo4IVO4X7dQGXX/IkPUzyrtYQ5AY9tGM=;
	h=Subject:To:Cc:From:Date;
	b=xDdyuOTsRiLq7iNr0i1ZeqRpv1YlMtT/AQKPzIPnBsOBtAcLRiYxTlevYzmQlCAE3
	 fwQ7/l09MxWBf+wpWRIvHvIe97PUl15D/oe5B3zkEl/+7Z7kDYB3LSDIWAMBadhQFa
	 x4zgit7YW+Uly5EtYWvHIJuFwJOCSAjaqvYtpYCM=
Subject: FAILED: patch "[PATCH] mptcp: close TOCTOU race while computing rcv_wnd" failed to apply to 5.15-stable tree
To: pabeni@redhat.com,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:24:21 +0200
Message-ID: <2026061521-laborious-platinum-e85f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263241-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:kuba@kernel.org,m:matttbe@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F9BD687227


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8ab24fdebc369c0dfb90f82c1650b1e66662bb45
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061521-laborious-platinum-e85f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8ab24fdebc369c0dfb90f82c1650b1e66662bb45 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 2 Jun 2026 22:14:10 +1000
Subject: [PATCH] mptcp: close TOCTOU race while computing rcv_wnd

The MPTCP output path access locklessly the MPTCP-level ack_seq
in multiple times, using possibly different values for the data_ack
in the DSS option and to compute the announced rcv wnd for the same
packet.

Refactor the cote to avoid inconsistencies which may confuse the
peer. Also ensure that the MPTCP level rcv wnd is updated only when
the egress packet actually contains a DSS ack.

Fixes: fa3fe2b15031 ("mptcp: track window announced to peer")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-3-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1c5698983c..2d25f319f328 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -570,7 +570,6 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	struct mptcp_ext *mpext;
 	unsigned int ack_size;
 	bool ret = false;
-	u64 ack_seq;
 
 	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
@@ -601,14 +600,11 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 		return ret;
 	}
 
-	ack_seq = READ_ONCE(msk->ack_seq);
 	if (READ_ONCE(msk->use_64bit_ack)) {
 		ack_size = TCPOLEN_MPTCP_DSS_ACK64;
-		opts->ext_copy.data_ack = ack_seq;
 		opts->ext_copy.ack64 = 1;
 	} else {
 		ack_size = TCPOLEN_MPTCP_DSS_ACK32;
-		opts->ext_copy.data_ack32 = (uint32_t)ack_seq;
 		opts->ext_copy.ack64 = 0;
 	}
 	opts->ext_copy.use_ack = 1;
@@ -1297,19 +1293,14 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	return true;
 }
 
-static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
+static u64 mptcp_set_rwin(struct mptcp_sock *msk, struct tcp_sock *tp,
+			  struct tcphdr *th, u64 ack_seq)
 {
 	const struct sock *ssk = (const struct sock *)tp;
-	struct mptcp_subflow_context *subflow;
-	u64 ack_seq, rcv_wnd_old, rcv_wnd_new;
-	struct mptcp_sock *msk;
+	u64 rcv_wnd_old, rcv_wnd_new;
 	u32 new_win;
 	u64 win;
 
-	subflow = mptcp_subflow_ctx(ssk);
-	msk = mptcp_sk(subflow->conn);
-
-	ack_seq = READ_ONCE(msk->ack_seq);
 	rcv_wnd_new = ack_seq + tp->rcv_wnd;
 
 	rcv_wnd_old = atomic64_read(&msk->rcv_wnd_sent);
@@ -1362,7 +1353,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 
 update_wspace:
 	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
-	subflow->rcv_wnd_sent = rcv_wnd_new;
+	return rcv_wnd_new;
 }
 
 static void mptcp_track_rwin(struct tcp_sock *tp)
@@ -1474,13 +1465,25 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 		*ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
 
 		if (mpext->use_ack) {
+			struct mptcp_sock *msk;
+			u64 ack_seq;
+
+			/* DSS option is set only by mptcp_established_options,
+			 * the caller is __tcp_transmit_skb() and ssk is always
+			 * not NULL.
+			 */
+			subflow = mptcp_subflow_ctx(ssk);
+			msk = mptcp_sk(subflow->conn);
+			ack_seq = READ_ONCE(msk->ack_seq);
 			if (mpext->ack64) {
-				put_unaligned_be64(mpext->data_ack, ptr);
+				put_unaligned_be64(ack_seq, ptr);
 				ptr += 2;
 			} else {
-				put_unaligned_be32(mpext->data_ack32, ptr);
+				put_unaligned_be32(ack_seq, ptr);
 				ptr += 1;
 			}
+			subflow->rcv_wnd_sent = mptcp_set_rwin(msk, tp, th,
+							       ack_seq);
 		}
 
 		if (mpext->use_map) {
@@ -1708,9 +1711,6 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 			i += 4;
 		}
 	}
-
-	if (tp)
-		mptcp_set_rwin(tp, th);
 }
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb)


