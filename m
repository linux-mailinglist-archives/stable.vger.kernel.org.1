Return-Path: <stable+bounces-218438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EaBCORTnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:44:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A83918FAAD
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5377F305A0EB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1371EB5E1;
	Wed, 25 Feb 2026 01:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O4fxC4tQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F5C18B0A;
	Wed, 25 Feb 2026 01:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983259; cv=none; b=JkWxx9wYaJ6WwHvp4q2vYGoo1J3dpqMZrP/i9QPOPUS45WzwsZNYrn4gYlvv3s5fXDxtghZWj7SNtLYnDdZfr1K/Vz0ExlY8uWNPA95lgvNM4/BRbB16/nD5ztTPv/DiranF4VkB7XrBB6WLOdpLJGCGxG+VZGSMxO8DHEs9pBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983259; c=relaxed/simple;
	bh=ab0W3OyWZ3vste0zexbKdaEUDEXdPs76hWEk8YuMCLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRtoK2/y2uJYdEDjZYhrxa3VgRDj0TnZy/HjIgXVmZmy0HwYHXRUr//Igms0PJBtEkVpHLcchft5s94r69oWemgKjm8CNNDs7AN+pEorjzJJIcad7OcapfTN36ZYtm1MevotjEEUkt4G9d1ttQ7sedHijx3o8imbVlZTO0PdWwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O4fxC4tQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F29EC116D0;
	Wed, 25 Feb 2026 01:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983259;
	bh=ab0W3OyWZ3vste0zexbKdaEUDEXdPs76hWEk8YuMCLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4fxC4tQv+hc6Ymq93EY8cum+aRSythrZT6Cf31DCbX8+EerUeW34ESodtOdvfYB6
	 MVUEsVgD3JXlkOBVIYWMF5mVHGm4QRyHkTalGa03+8LTJX77U29mUyofFchGUaN2Zg
	 zpoBKRgbTxQls/klb8wq1IX5wNUG2bN00P6SdvWo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 401/781] mptcp: do not account for OoO in mptcp_rcvbuf_grow()
Date: Tue, 24 Feb 2026 17:18:30 -0800
Message-ID: <20260225012409.541414423@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218438-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4A83918FAAD
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 6b329393502e5857662b851a13f947209c588587 ]

MPTCP-level OoOs are physiological when multiple subflows are active
concurrently and will not cause retransmissions nor are caused by
drops.

Accounting for them in mptcp_rcvbuf_grow() causes the rcvbuf slowly
drifting towards tcp_rmem[2].

Remove such accounting. Note that subflows will still account for TCP-level
OoO when the MPTCP-level rcvbuf is propagated.

This also closes a subtle and very unlikely race condition with rcvspace
init; active sockets with user-space holding the msk-level socket lock,
could complete such initialization in the receive callback, after that the
first OoO data reaches the rcvbuf and potentially triggering a divide by
zero Oops.

Fixes: e118cdc34dd1 ("mptcp: rcvbuf auto-tuning improvement")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260203-net-next-mptcp-misc-feat-6-20-v1-1-31ec8bfc56d1@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8d32336674181..cfa38bdaf2a92 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -224,9 +224,6 @@ static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
 	do_div(grow, oldval);
 	rcvwin += grow << 1;
 
-	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
-		rcvwin += MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq - msk->ack_seq;
-
 	cap = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
 
 	rcvbuf = min_t(u32, mptcp_space_from_win(sk, rcvwin), cap);
@@ -350,9 +347,6 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 end:
 	skb_condense(skb);
 	skb_set_owner_r(skb, sk);
-	/* do not grow rcvbuf for not-yet-accepted or orphaned sockets. */
-	if (sk->sk_socket)
-		mptcp_rcvbuf_grow(sk, msk->rcvq_space.space);
 }
 
 static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
-- 
2.51.0




