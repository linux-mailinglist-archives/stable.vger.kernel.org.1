Return-Path: <stable+bounces-265125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h/OlDNqDMWpzlQUAu9opvQ
	(envelope-from <stable+bounces-265125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:11:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1301692D73
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:11:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=BUTxiYpj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265125-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265125-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1FC3308F504
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0743247884F;
	Tue, 16 Jun 2026 17:06:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121A376A19;
	Tue, 16 Jun 2026 17:06:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629594; cv=none; b=mlLGmbqzP2fGtO9Bnjm+1nxHiav4Gk+Am0cn7e1DCufsfcGIJlGi4wqHWJ3QSXr0Q31uNt+VNB+vag8/Xm1St83d2exPFaRVgSagu/v6gNo77RQztAwaomtzTS7t9Ngl99MbHc2PRGvo0muXzaaiJVvicJoM67WwXR3dEehoiIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629594; c=relaxed/simple;
	bh=KnxBCwMNateH4z7wcDQxseGTp2hf+aL3BJEPRyFje7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieq4LeEtpMiieKjj+84aMFd+P3ct0CrkdeLbfG7bAzrf+LLLWS3ZbAGygRRpo8eot27x724ApJFWKZf82Hw4pXE+0mPhIuaALz0LBfWlh/iIg8RDngRUcBbt7BZ3flVACqm2sfQAxnpnTKM0FCL7bF707WDAdfdVlzBWm2HkMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BUTxiYpj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81DB1F000E9;
	Tue, 16 Jun 2026 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629593;
	bh=W21VEAvTSxDwLzMi2A0AJ/YbrN3YKzjaaqTLliqFUu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BUTxiYpjDU90MoLbVpWzGYpglb1j6YyMggnkNZcGOH3MMmQ/cruloOVUaDjqLpWOw
	 TiJxl/4y1PYyjnXy1X77GxEcG4ZlcLftctiNa91QKKNq/zhnJPA90B6hNzWaIjRxrg
	 8OD1zJbHqYOWvDko+mX6RZOnglgILtdxrAhRpXeU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 316/452] mptcp: allow subflow rcv wnd to shrink
Date: Tue, 16 Jun 2026 20:29:03 +0530
Message-ID: <20260616145134.087017607@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265125-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:pabeni@redhat.com,m:matttbe@kernel.org,m:kuba@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1301692D73

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit da23be77e1292cd611e736c3aa17da633d7ddce7 upstream.

In MPTCP connection, the `window` field in the TCP header refers to the
MPTCP-level rcv_nxt and it's right edge should not move backward. Such
constraint is enforced at DSS option generation time.

At the same time, the TCP stack ensures independently that the TCP-level
rcv wnd right's edge does not move backward. That in turn causes artificial
inflating of the MPTCP rcv window when the incoming data is acked at the
TCP level and is OoO in the MPTCP sequence space (or lands in the backlog).

As a consequence, the incoming traffic can exceed the receiver rcvbuf size
even when the sender is not misbehaving.

Prevent such scenario forcibly allowing the TCP subflow to shrink the
TCP-level rcv wnd regardless of the current netns setting.

Fixes: f3589be0c420 ("mptcp: never shrink offered window")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-4-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/options.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -567,6 +567,7 @@ static bool mptcp_established_options_ds
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned int dss_size = 0;
 	struct mptcp_ext *mpext;
 	unsigned int ack_size;
@@ -615,6 +616,12 @@ static bool mptcp_established_options_ds
 	if (dss_size == 0)
 		ack_size += TCPOLEN_MPTCP_DSS_BASE;
 
+	/* The caller is __tcp_transmit_skb(), and will compute the new rcv
+	 * wnd soon: ensure that the window can shrink.
+	 */
+	if (skb)
+		tp->rcv_wnd = tp->rcv_nxt - tp->rcv_wup;
+
 	dss_size += ack_size;
 
 	*size = ALIGN(dss_size, 4);



