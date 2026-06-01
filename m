Return-Path: <stable+bounces-259422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIM+GJr4HGqJUgkAu9opvQ
	(envelope-from <stable+bounces-259422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 05:12:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE97B61919E
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 05:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08BBF3049FDE
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 03:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BF0258EC1;
	Mon,  1 Jun 2026 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j90Ru5of"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E7425392A;
	Mon,  1 Jun 2026 03:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283436; cv=none; b=lYyVeFzUqz+rpCz2EigZzX+MOXXqtkRWIEIURJqYowhgCkwX+qEew+kWQlotHUm8IODxFAu3hDt3r92qp+ss9kYZpKPjxWUeODdQkN/4s3n4ZhOR1jG1QSfzqyahJcpZY1knKIvQ1NGPrl/DVT+7F7n+yKwqr6ss9i4FcSicxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283436; c=relaxed/simple;
	bh=rkQBiCaZv3FLsMCB1B/qXFTAapBqRO/jjIMFsa8uZvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vDrusjgbALcqF5wmQxJP3AGeCfNzxpslceJjDGpyiPZCXqoCkbo+66TJ2BH1WAvl4NskgjQrdQDQhsz4I4yHaNb8jgHb/rVEZTDzOPPI1PTR7T/pMr65Ux5KgDWmWJo1eNmwuYD/Omgw4F2eXUB88gZPOvmv2jKxV/ZOUcde3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j90Ru5of; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD781F00898;
	Mon,  1 Jun 2026 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780283434;
	bh=8up5MYwx4EhVVjUDefYI07aSVy3uzwumnDLm7oQTWB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=j90Ru5ofFQR6tfLeXt3M9QYttFUSXJDFzKu4LWxYyZolJuPboyLpZMpjpTrpkPpMx
	 NJDK18w6ZD68e5M1exaRHRdsgPBItBfdLsW1GoXtQo2KZq8LtzDsxj3Y47tKriKf2g
	 sDvWYY3T2LSREytYVeMJRdBWAXZnQfOgDkZmOAlzDYxHP2hcAqDF8Z5pHeMRBp6/GE
	 4KlkAc0UciW4dewva14nwI5HnkPhGO6lcND2vyIDsBFSCS6guxJ9xlRxrEFC8XamXZ
	 k09DQZbBt7uD08jTi/lIFlTMG0pUMymps/6hbiYvcCWPTHti7LdUI3JwPYqapSMpdL
	 gP2nZX84NRupQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 13:09:57 +1000
Subject: [PATCH net 01/10] mptcp: fix missing wakeups in edge scenarios
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-1-a5ae7791754b@kernel.org>
References: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
In-Reply-To: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8bYMyyvhQFOSZqNFT4QxJeSNWbzfPC95/VwNPuygVVk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHPgeZgFodtIontn8IIYicd3TfOUSdbzXDubYs
 PfRbYalSpGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahz4HgAKCRD2t4JPQmmg
 cy3ND/9DCCfRlf36Ay6eG+KHTojqRx8sQ23aUnz4q7wAxn1KUzCH+hxcq7fmb6TBtfYK4GUc2PH
 53B4D8AM5y6gNzLVOFLrfg2nQ0qlmvRhwhLbxKgum+KyqlfmX0dRRbrg/zaSVW43zw/kgipaTVK
 3418YYJc4dMgNaiscoQi85kW7Kw9O+O2J4ZHvkwW2uMVTF5Wb7yZ3l2Ji41lcaFD4xyz15gOSPc
 AFAEmu3BG5tkqbV6YNVhie8EI4KgDGtWnlFodL791qVkZ6KIU9g25/wDyVoIyTmi0QtOZR1fH4Q
 FkTXy+XtbjVS/hd6b+VNadn8AmooDZEcxi0ncofhk+o9mbCM2H4besACQuixpiwF5p0dOi6q4s4
 8XqC/ojf+7DH+EMl+p3/Sc1FYpLl0y8QlNRf5oXRqQ1MIsjIr7QO1CmE2lDgk7l3mQGypLXBGa6
 eR2Uf2b1J7ZLTBVIpPsKQtavh/B+qUf8UNLzEgmTFnI2pPUFmGJKdSZxIHPDiAnad2NrbsW270d
 4BfCTDsyZTQbnOIYuEioIxZFEd2hZdmUwO5T6sub3l3sE59Ne1J+iQsIBwJXgqIRhLrWHlaCseA
 JhcVGJbDtdDC2wl4K2eLmpwcT9Sxs3nOvMaV4LrnyYdD94OC1bUOPXFlEOtKjJKmtt6PdXPIOIN
 KFm0RfAtiET9+SA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259422-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AE97B61919E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paolo Abeni <pabeni@redhat.com>

The mptcp_recvmsg() can fill MPTCP socket receive queue via
mptcp_move_skbs(), but currently does not try to wakeup any listener,
because the same process is going to check the receive queue soon.

When multiple threads are reading from the same fd, the above can
cause stall. Add the missing wakeup.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a72a6ad6ee8b..5a20ab2789ae 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2276,6 +2276,10 @@ static bool mptcp_move_skbs(struct sock *sk)
 		mptcp_backlog_spooled(sk, moved, &skbs);
 	}
 	mptcp_data_unlock(sk);
+
+	if (enqueued && mptcp_epollin_ready(sk))
+		sk->sk_data_ready(sk);
+
 	return enqueued;
 }
 

-- 
2.53.0


