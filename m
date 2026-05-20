Return-Path: <stable+bounces-251381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJaBMEYaDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:32:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 150BB599BB0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 311BB35F93B6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44D53FB07E;
	Wed, 20 May 2026 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zjH49C2A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49BE3F7A9C;
	Wed, 20 May 2026 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297831; cv=none; b=X2eiwT3fhg4edftlY6/T4+xNnoSOKuj+c60/DFnCmHFcdUwkNvONPHiLoX4wTTTbu9T20jpNt04Kse4P29Z+qeoM3mU2GJyooDu+CJemGCFdgllFozbOdILODBtBws3/QA7FmD50N8ydgIxx9g3AJp59urI4v/VStvjnOSjK2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297831; c=relaxed/simple;
	bh=34wNXaYvvlVGWQDdTAU/VPYjqfXlKw8rxT3hXsSw7/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qN4MUGnLZCpRl00jKy1pGOynmGcbRfdoqtjKDNS14jY7pZ9r0Yj094LX6dVtgMFae3I4Hd8tuxnZ9fNG7aocgVuOGD0nHFlY8JWpJ0/epu/YeQWtA84XpacILXLyzi21eM3VXtiDg2OGqm3+obMA+tnLp3XKKceF3J9RMCx2h1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zjH49C2A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158CD1F000E9;
	Wed, 20 May 2026 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297830;
	bh=4xCsEFBdidV/XO8an/McbsluK+tVw80dgxCcuE+zcZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zjH49C2ALCIAAZjnzjC9WYUbm2i/15J49DhKxZPnWN/lfCTVxqmcM/77fPTMtPyqk
	 bffDWaQ3ULDR+d5npV9qLRo888+7yWEv/t3MIEbh0s04CjlzB8FQOBQtugOYuaYJTx
	 02FE6m/bV1c1rqVCVeUR50lECkYuK6e6TEeTr9KQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 181/957] tcp: Dont set treq->req_usec_ts in cookie_tcp_reqsk_init().
Date: Wed, 20 May 2026 18:11:04 +0200
Message-ID: <20260520162138.479178995@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251381-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 150BB599BB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit c058bbf05b1197c33df7204842665bd8bc70b3a8 ]

Commit de5626b95e13 ("tcp: Factorise cookie-independent fields
initialisation in cookie_v[46]_check().") miscategorised
tcp_rsk(req)->req_usec_ts init to cookie_tcp_reqsk_init(),
which is used by both BPF/non-BPF SYN cookie reqsk.

Rather, it should have been moved to cookie_tcp_reqsk_alloc() by
commit 8e7bab6b9652 ("tcp: Factorise cookie-dependent fields
initialisation in cookie_v[46]_check()") so that only non-BPF SYN
cookie sets tcp_rsk(req)->req_usec_ts to false.

Let's move the initialisation to cookie_tcp_reqsk_alloc() to
respect bpf_tcp_req_attrs.usec_ts_ok.

Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260410235328.1773449-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/syncookies.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index fc3affd9c8014..b5f0a65c67864 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -286,7 +286,6 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 	treq->rcv_isn = ntohl(th->seq) - 1;
 	treq->snt_isn = ntohl(th->ack_seq) - 1;
 	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
-	treq->req_usec_ts = false;
 
 #if IS_ENABLED(CONFIG_MPTCP)
 	treq->is_mptcp = sk_is_mptcp(sk);
@@ -349,6 +348,7 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 	ireq->wscale_ok = tcp_opt->wscale_ok;
 	ireq->ecn_ok = !!(tcp_opt->rcv_tsecr & TS_OPT_ECN);
 
+	treq->req_usec_ts = false;
 	treq->ts_off = tsoff;
 
 	return req;
-- 
2.53.0




