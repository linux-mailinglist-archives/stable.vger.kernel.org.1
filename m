Return-Path: <stable+bounces-242501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK0bKvIA9WmYHAIAu9opvQ
	(envelope-from <stable+bounces-242501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:37:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E54AF314
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE7F23036749
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 19:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187504219F9;
	Fri,  1 May 2026 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1gCfSix"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC61D313E03;
	Fri,  1 May 2026 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664174; cv=none; b=klET86R8Q+LAO90DMUrRiFOz/nSYic3ZMaHJTxSIDBzHzZBfWz2k1ADDtRAzzWDzpvvTWdV+n1uUkxkbds7YbC5qoOa4rE8vxQ/lMMWEtehmIpd0OKLToyiaGNSUaqnpHKo/V5FscElDnOnuLxCb6cpcCWN/OAHebSfbUSXyVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664174; c=relaxed/simple;
	bh=CQeKDnYHzNPI+8C7OhbDrXambHWvhF+m7w0D0trjZl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=POoGR9kSGunNxnCji8GhJ0W/5QzqB6fa69xDsvwSNCcm8Hl5Mj5CSf6JZFcBgPD43khQhCn3XvfFs0UHbr6VOOWqLaXIQpIs3BYcT4z3okalC5CqRlPdT7U6JqnshjeHN3rJLJxzuALVlcnLWLpQyhfvOeaayTaskhG+xqMHRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1gCfSix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EE2C2BCC4;
	Fri,  1 May 2026 19:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777664174;
	bh=CQeKDnYHzNPI+8C7OhbDrXambHWvhF+m7w0D0trjZl8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T1gCfSixFK2RXXrkTgYrFx3MZRiOvOxB6efXmuIgUZsD4CffpIRD2ag2U/oXa2qDT
	 tPuxGAXsZ1HqT6s+S/TWMEyUx5wnC1QNh8VdHLsvDQFElg8pbY8nTRCrUpafkKhIWu
	 OO6E8GuhWel8Zj825eDmsBxNrVrlGadH6kBSNvAT2FCMp1W2ind1zO1g0CJa9+UkiY
	 Z+GDAgNM3g8TN7pTM/lLM9QuUKI6Kb4Y2jR3mSEIEWTDJdQQzXAHGzSgIKL+xSDgWP
	 MMEMSunTscSFNJ5TeJ4nNKuP3vsVlqw62i78tNTaG+BNqKJtoD13oILuhbkMOaVACw
	 ao57+EtVktbkA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 May 2026 21:35:34 +0200
Subject: [PATCH net 1/4] mptcp: use MPJoinSynAckHMacFailure for SynAck HMAC
 failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-net-mptcp-misc-fixes-7-1-rc3-v1-1-b70118df778e@kernel.org>
References: <20260501-net-mptcp-misc-fixes-7-1-rc3-v1-0-b70118df778e@kernel.org>
In-Reply-To: <20260501-net-mptcp-misc-fixes-7-1-rc3-v1-0-b70118df778e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Gang Yan <yangang@kylinos.cn>, Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S3NhcQVoid/E4etRupkhrJemAOUzbf6PWUYaWnK4HP8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK/Mixtu3j06MkokcuC66z3+eqJHNZpNW280/ZjwqWqi
 us+Lc9Wd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwkKJuR4bBbdeb7H73bysLV
 o/kOTW9Lb+z7vPbeRrFfTF3ODDN5MhgZnlz6uCUrvVzn1ooDaVlZ2y9MmXH/HsursvPpq79whVf
 m8AEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 546E54AF314
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242501-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpiricsoftware.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Shardul Bankar <shardul.b@mpiricsoftware.com>

In subflow_finish_connect(), HMAC validation of the server's HMAC
in SYN/ACK + MP_JOIN increments MPTCP_MIB_JOINACKMAC ("HMAC was
wrong on ACK + MP_JOIN") on failure. The function processes the
SYN/ACK, not the ACK; the matching MPTCP_MIB_JOINSYNACKMAC counter
("HMAC was wrong on SYN/ACK + MP_JOIN") exists but is not
incremented anywhere in the tree.

The mirror site on the server, subflow_syn_recv_sock(), already
uses JOINACKMAC correctly for ACK HMAC failure. Use JOINSYNACKMAC
at the SYN/ACK validation site so each counter reflects the packet
whose HMAC actually failed.

Suggested-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Fixes: fc518953bc9c ("mptcp: add and use MIB counter infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e2cb9d23e4a0..bda6862264ca 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -581,7 +581,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			 subflow->backup);
 
 		if (!subflow_thmac_valid(subflow)) {
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINACKMAC);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKMAC);
 			subflow->reset_reason = MPTCP_RST_EMPTCP;
 			goto do_reset;
 		}

-- 
2.53.0


