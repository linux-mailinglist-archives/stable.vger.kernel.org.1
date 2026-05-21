Return-Path: <stable+bounces-253437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE5oIZx3DmrK+wUAu9opvQ
	(envelope-from <stable+bounces-253437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 05:10:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CBF59E4DC
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 05:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FD913009F54
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 03:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D187A366836;
	Thu, 21 May 2026 03:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrDqauQn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908D131ED81;
	Thu, 21 May 2026 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333018; cv=none; b=Umk/Uqfp+kgIuvW/qUhaNJpc6p3MF1xOeryHSp7r1wsNu9UxRqizmW0NtxqsVIHNTFsaNt1OqwDdj2U76zYxBxF1PYLyD+Tq+jOuW4wD3NEoSOPda/KktvT0ia1d/+8x+miVICEwO0kxJX1DRuld/7AEyx0AZ0kYAr8FQXe4SE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333018; c=relaxed/simple;
	bh=OPiUOJp9VtmPav65wfzceFlbz/K62XDBrUfEsK39OmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQMAJUDxLe7rcwv+d5cemgSE95oli/3ebudMa05wPXSEP/xI2Yps8ktjuJTaEzGlJNbVHO0vhNxGXQhEQ5CpLE2mP+RpSWwGlP2wy/8x+q1Or1O3kQl2TbyoNJkhBHKHPcbJ9u8Tr3moH7tv49TSaFrV3rAqq6U+v3RiZ9ILCH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrDqauQn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55AB1F000E9;
	Thu, 21 May 2026 03:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779333017;
	bh=rxCJP2EMvJUeKzUukp43M7FHhKUyvcMIjcfLX0PmJ3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XrDqauQnD/p9JHpGYM/zz30uMwId5yCpuTlk/rT2kHvqqJF5p+dpuMPM59TaAvn0K
	 zHF6CIy20MXh74uF/qvwdSrJ0UnOgg8XB/Tl9YTBeOKCLk3MfRSsSSapXHMh0gunWh
	 UL2miRCNSAXsvDQ+5tacjK9zEYsImd+QArBYidI2FD0raDmrwlHEYyv80aRDDxAZwk
	 AdiPg/z6ntIWQKC/y/4mx2xPK4zsQWsZRvS0DSxyg81aHLnKxoIF7lXcy63u2UdfIn
	 u47LGW8KNg+rVw94KWwWJM2al9drRIRoqff4tfy6jIG5HZyd4BLuRDZiGUyzs8EiiU
	 fGbaSViCJEQfA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y 2/4] mptcp: pm: ADD_ADDR rtx: allow ID 0
Date: Thu, 21 May 2026 05:08:48 +0200
Message-ID: <20260521030845.723267-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521030845.723267-6-matttbe@kernel.org>
References: <20260521030845.723267-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332; i=matttbe@kernel.org; h=from:subject; bh=OPiUOJp9VtmPav65wfzceFlbz/K62XDBrUfEsK39OmY=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLL4yqPnBdxr/tsnv9DT7/yPm096fazKH7+btH/jo5+3b fz3M5cEd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExEuIaRobGFr/bFD2n1Od4P OBvnvRQN3ea8VT0w8LdQVI6LVvUkb4b/bnf2Vy0ViLZRNeHsyFle//+6ERuPNM/MnL8fb/ex7Y7 lBQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253437-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url]
X-Rspamd-Queue-Id: 27CBF59E4DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 03f324f3f1f7619a47b9c91282cb12775ab0a2f1 upstream.

ADD_ADDR can be sent for the ID 0, which corresponds to the local
address and port linked to the initial subflow.

Indeed, this address could be removed, and re-added later on, e.g. what
is done in the "delete re-add signal" MPTCP Join selftests. So no reason
to ignore it.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-2-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ applied to net/mptcp/pm_netlink.c instead of upstream's pm_kernel.c ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5d892583ab4e..857e8db670a7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -304,9 +304,6 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (inet_sk_state_load(sk) == TCP_CLOSE)
 		return;
 
-	if (!entry->addr.id)
-		return;
-
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
 		/* Try again later. */
-- 
2.53.0


