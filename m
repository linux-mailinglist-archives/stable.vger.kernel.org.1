Return-Path: <stable+bounces-211887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OId1EXASeWktvAEAu9opvQ
	(envelope-from <stable+bounces-211887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 20:30:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FFE99E0D
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 20:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7CDD3078623
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 19:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D675C36CDF7;
	Tue, 27 Jan 2026 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIqNddeM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4B36E492;
	Tue, 27 Jan 2026 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542061; cv=none; b=mYenwaJ6x4QsCsH39BNDYi/Aj7YiSaLYFL1CXn5m2X2HhlZisfAwpYzFF9IXGCwb9DxcS+HXkv3+xUt18IZt8YpoMUMsye+z8yFIS1mn+FeQxv++/2V9HDeVx8jyNDVJy/lHcqwbpPYAnv44RphjejoR1jS91PIqQZz6RmkTcpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542061; c=relaxed/simple;
	bh=6TBsH+0MeO9zZb+OSXn43HSgwIckc2zzJ0HWt3vvoqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtbP1TJOzPO+uOKN1NetjWBRKc+HBsZVCqXNqdB2ADyB22Acv8+dJ4NOKWAwtm3iEmm2NXE3sRt+WLQT0bkMRLAKkYVr6t8vB30ga5/reB8NZ6A+YUlcPEIvGAb+xu1Zukpq/evMPo2VZV6mTHPOiC5XoKESl8kgd1uVZgkobyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIqNddeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6695C2BC86;
	Tue, 27 Jan 2026 19:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769542061;
	bh=6TBsH+0MeO9zZb+OSXn43HSgwIckc2zzJ0HWt3vvoqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WIqNddeM/ACOkmOiPlJtEErlfxv/N4ax/MpyfMXgIC+IhB+B0jScuI2qYIud+xQSG
	 GepujlX0F8gjwsZ498+fqZJfryHrgpFR48bhSQwq3UGZUc8i+Bw0yIYxPRqLr4B//U
	 i6mlijdnGnaG219umF5k8uIg1iUHoED1XuMXtYTKVCh3MLyHizkIXg5m2HMw6Ojncu
	 +7keJKvBUuiNU1VwJRtgaKyu9IImu0Q48KRdgJre4J0r+23Eg8IFuL6vln+qNMGlC2
	 yIqSX+cKn0MlDGLZFe0DnzkaQyqiMsZ03Yo1lDoNKaBRu1P2ex19CmhkEww3+BZ/8A
	 2+yMpJ58fI8zg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 27 Jan 2026 20:27:23 +0100
Subject: [PATCH net 1/5] mptcp: avoid dup SUB_CLOSED events after
 disconnect
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-net-mptcp-dup-nl-events-v1-1-7f71e1bc4feb@kernel.org>
References: <20260127-net-mptcp-dup-nl-events-v1-0-7f71e1bc4feb@kernel.org>
In-Reply-To: <20260127-net-mptcp-dup-nl-events-v1-0-7f71e1bc4feb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Marco Angaroni <marco.angaroni@italtel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6TBsH+0MeO9zZb+OSXn43HSgwIckc2zzJ0HWt3vvoqc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIrBZeaa2dJ1/b2LP8cZH829rK5MVP5poCqtuWTX9vNX
 WC9QUamo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJHNzH8zzzUN5dv7/tvXQ/C
 AzrbT+UUfurnOs+zZfn+yT18DPyzjzMynGKSuVWwMeniWZ+ZOZ6ZgtcqlYIYRB8fiWwNut/Uzna
 fEQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211887-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F0FFE99E0D
X-Rspamd-Action: no action

In case of subflow disconnect(), which can also happen with the first
subflow in case of errors like timeout or reset, mptcp_subflow_ctx_reset
will reset most fields from the mptcp_subflow_context structure,
including close_event_done. Then, when another subflow is closed, yet
another SUB_CLOSED event for the disconnected initial subflow is sent.
Because of the previous reset, there are no source address and
destination port.

A solution is then to also check the subflow's local id: it shouldn't be
negative anyway.

Another solution would be not to reset subflow->close_event_done at
disconnect time, but when reused. But then, probably the whole reset
could be done when being reused. Let's not change this logic, similar
to TCP with tcp_disconnect().

Fixes: d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events")
Cc: stable@vger.kernel.org
Reported-by: Marco Angaroni <marco.angaroni@italtel.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/603
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f505b780f713..e32ae594b4ef 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2598,8 +2598,8 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb;
 
-	/* The first subflow can already be closed and still in the list */
-	if (subflow->close_event_done)
+	/* The first subflow can already be closed or disconnected */
+	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
 		return;
 
 	subflow->close_event_done = true;

-- 
2.51.0


