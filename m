Return-Path: <stable+bounces-249276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAxCAqcPC2pN/gQAu9opvQ
	(envelope-from <stable+bounces-249276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:09:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 826AD56D55A
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D959303AF34
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BA5480949;
	Mon, 18 May 2026 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0SNH+my"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA29480946
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109513; cv=none; b=jpmXd4WPaz4nTnzw4sCmXpXaaBbgfL3uTs1qHSacvgMQbu/umuPfHsEqf32pYO3pGqSYjgNI4Ig/DqhTfpv7ZR5l/piqaZ9RiB1VDzdc78MHcRIoAQG+x1GWGVm3CNbGSRUgHmVccUB6dresnjTTwp+tGG/zF5pYjV0AmQsgLko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109513; c=relaxed/simple;
	bh=8BN0YY1glHtubrZGcjDiNGU56ffEiAJ0+exhqDrOfbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjKlMVH7DTNRXssFuitM+kkSZ9wA7bgHOPHZs/68Z8A6H4lcp6jOt/VpF4hWLK2/KXBvXA710xG//vddRzdaPCYOPTk4IAepHVQFpBWwKpyy5kDzTt8fKZcypwqOavkMSzQJk7BRq3IKKsY7/+nVxDiNlmrlkGb3LVimm0dNz7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0SNH+my; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D06C2BCC6;
	Mon, 18 May 2026 13:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109512;
	bh=8BN0YY1glHtubrZGcjDiNGU56ffEiAJ0+exhqDrOfbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0SNH+mynSLPlVU42twVIoWMeq4dp0/bPekHJZUqlVpWiv8PkunqNHKmpqSDkYErX
	 kwcsJ39EMx8jQdQjE4F5Y6L8njAlrKH46eqc7dqxSMrswRhIsI8NbkbLTUWfYNGFpZ
	 XieB9vuJ0KYRYoKdmwEgxR9VfrB7M8eLR6Ny8+nyB+5CIvkOEYcex7h4xBKErqr0ql
	 zo0t7JZVTqlgz2HPQKiN+9JbOH8NYQGZGn4OoD8uliXZfqs0IsPp1CYL17b4KQUTaO
	 CGHa9eJxfYVGrknExkPsBHs9ME3OdphJMDQPyfD8kgMdcS+/+bzHCSQdEkm28kW6vR
	 794L9FtXIzliQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] mptcp: fix rx timestamp corruption on fastopen
Date: Mon, 18 May 2026 09:05:09 -0400
Message-ID: <20260518130509.978083-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518130509.978083-1-sashal@kernel.org>
References: <2026051256-grime-usual-23e7@gregkh>
 <20260518130509.978083-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 826AD56D55A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249276-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
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


