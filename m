Return-Path: <stable+bounces-269538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IUCcFkFKQWqznAkAu9opvQ
	(envelope-from <stable+bounces-269538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:22:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6B96D45A7
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:22:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=h4BHhPpA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269538-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269538-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2F82300E255
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18864146D5A;
	Sun, 28 Jun 2026 16:22:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF065BE63
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:22:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782663728; cv=none; b=q0ouGU2zN1hsH95jLT+oVp/kfoQT598apLLB8DYlQYi/7AoW/V+FhkCBcXG6m9bOt1Ew+C0rH9S9DdMCzLfTHpCLS6dU5z+EAjwN9r4iLEj18GDyAVFQfVhMv/H6KghfoePStjdAa8vEWcDFa9vGA5brD0rRZSlBklV2iSYnbCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782663728; c=relaxed/simple;
	bh=TNmVoCZVfV3mWRUgR5PwdDvvIwUcHPiBjgmekOnB4f8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U7XY9B29cKfiarrHh91jrx0BQin+ekun9TyXgpTtkAbDKuwUVqZL+ktZ0JMeX1q8D5FD9jnkpt4Zi6Ki0+Qp2gibaCTM48wvRk5v878nW+mVeR5is3+GdMFPxkT5qU5ud6Lu3jY/KmmXgc4wbfansT1kX5lxtvez5bg84q/N2j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=h4BHhPpA; arc=none smtp.client-ip=54.207.19.206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782663617;
	bh=86Up0/BWZkmDQ3XDXIezByXjxwQHj7cYHJWhgxbTOtE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=h4BHhPpAC+imPFR8KTc25U+nislxUltrRB616bK54BgH30hFdKgtUsMCNf5vNEHqD
	 18+xV2hZY36NX0PC4x/pTDb+5RZV/qsYcP8shBFG/R7mD2woi6ispPDxNig0ylxPWO
	 4WXfsIUo/fekRmZhHPzwek7x7RNH+3bNNLe9ncpw=
X-QQ-mid: esmtpgz10t1782663611t99899f62
X-QQ-Originating-IP: tu8L4pd4I+fLXHfnFqHr86rxKN4aYZdSeiFoYVsa9YU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 00:20:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11300607600349624124
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: carnil@debian.org
Cc: benh@debian.org,
	brauner@kernel.org,
	foss+kernel@0leil.net,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 6.1.y 3/9] eventpoll: use hlist_is_singular_node() in __ep_remove()
Date: Mon, 29 Jun 2026 00:19:31 +0800
Message-Id: <20260628161933.532572-4-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <akEtsUNOcuws0xPC@eldamar.lan>
References: <akEtsUNOcuws0xPC@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NnCDXGebndsA8R0oWsRdR/8ecWnJWo6Y4i9rtiWMCHbQCnzMCARcpK+N
	iHoapzpdT0kdlUyj+bdDfqDZ3xmHoZY66yK4DA0nIfj5SYGOGmvuN6zQNjz0TlKxAruNKYt
	JkIqURFqML34BTUwyQ9Fe2GBnURW/1qOJiVdO3vdnK50SDn0vi1wKdmakni4SnbO3P8JptP
	aA48JMDCzxV5J3bpjOtB4ihBdDTGLbm1h3BikuNWG9mqw59UymhkKOVveaBglKYYE5542ZK
	ldvsx7HB7rUOLIbxTzcJU+SYwhGVa6DZlgVtcVqR6BlTat/YfcclnfrSxLQg267G/y4QBg3
	mnTA8N8WAtirp0ySOZce93RPvykNAXN8En48Bm9j9oy6+Kh6o1wQQE+nEi15g+2304JxWnv
	PZ2g9bcIiiBB6E7D3pcrZgftf9RbltbYwEulw/SBo10IOu5Q8L3NEYXZ+nO5L4OrEbpRHZ+
	eo8uXJ5Eq3DU+CRCMCOTzOGpRw96AHOCvCrZrwt8vrk52KdctUYxa7zFdLo0SP8HGLfPoYM
	RiXQc9EOEre01gFpfsGndbjN5QmNq6xLNfOBRs3LMQyly5yP0IgrgXEPPCwLB1Q0ON6eCvh
	aLUhc/9XPZtGo8+1USbzOLwId3lkOexLltMRY2/ifRc0He8OmNuyHgOaeX06ZbRu3nyrjmR
	cjHeTOojfFM1HSeP71mNZodEDWtiXS8gRm0DHvuodmH0iC4PdMatuq6SNB7a/YAlX5gvyI7
	OlJQQwQyPa4k+sf9cYQMeSdQIjojCKtRgRQMWytxX/h5OlVEzW3J86PZeNUybrT62ntmpe8
	KxzXEix6L0OHJzSXXWFv24CPEnc1LPnmCxQ7gfCeY3yYxjl9l2BGw1i+CVTaYrwp+ZT0xoL
	MlFg1bLLnMERdexoVy/H4D3Ss5y6CzSHF645fzQia2Mnmz5QfXCjEaCUVZqQvPgbBJsmuEL
	yCuSVUuyKmrsKrmnXzIc19NPBYhZrJxrkBjVDghVotBeWqWjbDpelRsZUeahyeA7bg53+CE
	2/zmZazgGCl0zROhrpAwbzV9ewTdkMfG4sy+94ZJhiAqPWKRJjdfsgbPdlPgKWD7saCdVkM
	PlLY4CwV7aHuTtIsBKWqs7SkdDZrn7LxSa0NXx/PmrEICD2G4Qzm+szCU5WnRpxSw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	HFILTER_HELO_IP_A(1.00)[sea.lore.kernel.org];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[sea.lore.kernel.org];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:query timed out];
	TAGGED_FROM(0.00)[bounces-269538-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:carnil@debian.org,m:benh@debian.org,m:brauner@kernel.org,m:foss+kernel@0leil.net,m:gregkh@linuxfoundation.org,m:guanwentao@uniontech.com,m:sashal@kernel.org,m:stable@vger.kernel.org,m:quentin.schulz@cherry.de,m:foss@0leil.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[uniontech.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[guanwentao@uniontech.com:query timed out];
	TO_DN_SOME(0.00)[];
	MSBL_EBL_FAIL(0.00)[stable@vger.kernel.org:query timed out];
	SURBL_MULTI_FAIL(0.00)[patch.msgid.link:query timed out,uniontech.com:query timed out];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[msgid.link:query timed out,uniontech.com:query timed out];
	ALIAS_RESOLVED(0.00)[];
	SURBL_HASHBL_FAIL(0.00)[patch.msgid.link/20260423-work-epoll-uaf-v1-1-2470f9eec0f5@kernel.org:query timed out];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_FAIL(0.00)[uniontech.com:query timed out];
	TAGGED_RCPT(0.00)[stable,kernel];
	RCPT_COUNT_SEVEN(0.00)[9];
	BLOCKLISTDE_FAIL(0.00)[113.57.152.160:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cherry.de:email,vger.kernel.org:from_smtp,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F6B96D45A7

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 3d9fd0abc94d8cd430cc7cd7d37ce5e5aae2cd2b ]

Replace the open-coded "epi is the only entry in file->f_ep" check
with hlist_is_singular_node(). Same semantics, and the helper avoids
the head-cacheline access in the common false case.

Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-1-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 fs/eventpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 7ca1b5931480c..bc605ad291499 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -745,7 +745,7 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 
 	to_free = NULL;
 	head = file->f_ep;
-	if (head->first == &epi->fllink && !epi->fllink.next) {
+	if (hlist_is_singular_node(&epi->fllink, head)) {
 		/* See eventpoll_release() for details. */
 		WRITE_ONCE(file->f_ep, NULL);
 		if (!is_file_epoll(file)) {
-- 
2.30.2


