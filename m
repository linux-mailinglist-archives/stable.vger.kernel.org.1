Return-Path: <stable+bounces-249260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG4tFSYAC2oH/QQAu9opvQ
	(envelope-from <stable+bounces-249260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:03:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DED656C2E5
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A7B030788F3
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E4B3F86E8;
	Mon, 18 May 2026 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4PvD4Uj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCED3F6C4C
	for <stable@vger.kernel.org>; Mon, 18 May 2026 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104905; cv=none; b=stpnVwYWn4TPh7bqzrz+a2R0rGtFkcZIBdnn4qIrJK6bM+oTalIB2HvV4yah8Tuv2UtcG1+DxaUxYRJSAaGY1TBUSrEhCLnOAHPVl3Bg4b1oe6pR9ZRyc2FsAkJt6F1B8igo/FBzFUkONgxrXldgnkUX7hxGc936KORqUOSVdVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104905; c=relaxed/simple;
	bh=8BN0YY1glHtubrZGcjDiNGU56ffEiAJ0+exhqDrOfbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMmCuMBSkLpvbGO0S2Uq90pE+ojlnjuUt5UGPmccnReITVSWLePgh4AzBGmKjbQUvKICp7Fq20MhJ8u+7gaq4hyw2fsk89ovEQP6JEbYjUa4IyJPekx8h/n8nFKTE3cFwuEEdVGfyRedVpcroEl9bhlrJSZFH1HyRWPjbvxwvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4PvD4Uj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB5EC2BCC7;
	Mon, 18 May 2026 11:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104905;
	bh=8BN0YY1glHtubrZGcjDiNGU56ffEiAJ0+exhqDrOfbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G4PvD4UjDj+F0OTTZx/uXiWTCSw6VrNysRrd63kKvJf806ZKKOq+uDsfsrE7HgR9G
	 Uv+EY9EMP2HzkMgakPNQk10qx+tLdpLhE3wAT3ccekJRVVrXcitfGvbrHSJW2bUX07
	 sNx6Qhw0oWgJOheFQBGBL1dqDz+dNkJ6BVHituc0B+o54ZIylEddCDUbAIDV4yah1v
	 3qYmsqVyKw63zAoJ+saKol6t1SzvMKPOZJFw2xte4vNtFDBB+GVomD3QAl5Rt8lTb8
	 tnC4WrnoGBAamwMI0bv2ikIKO/Jrq4cBKisSyi5RTuU8/XnRxI7dkGnRZPqyP7Wrxh
	 Db2IBXEtI0wsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] mptcp: fix rx timestamp corruption on fastopen
Date: Mon, 18 May 2026 07:48:22 -0400
Message-ID: <20260518114822.789572-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518114822.789572-1-sashal@kernel.org>
References: <2026051256-flinch-galley-b789@gregkh>
 <20260518114822.789572-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4DED656C2E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249260-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 6254a16d6f0c672e3809ca5d7c9a28a55d71f764 ]

The skb cb offset containing the timestamp presence flag is cleared
before loading such information. Cache such value before MPTCP CB
initialization.

Fixes: 36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260501-net-mptcp-misc-fixes-7-1-rc3-v1-3-b70118df778e@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/fastopen.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 7777f5a2d1437..d4dbdd3d5679d 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -12,6 +12,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	struct sock *sk, *ssk;
 	struct sk_buff *skb;
 	struct tcp_sock *tp;
+	bool has_rxtstamp;
 
 	/* on early fallback the subflow context is deleted by
 	 * subflow_syn_recv_sock()
@@ -39,12 +40,13 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	 */
 	tp->copied_seq += skb->len;
 	subflow->ssn_offset += skb->len;
+	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	/* Only the sequence delta is relevant */
 	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->offset = 0;
-	MPTCP_SKB_CB(skb)->has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
 
 	mptcp_data_lock(sk);
-- 
2.53.0


