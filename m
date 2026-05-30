Return-Path: <stable+bounces-258654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HyTD6gqG2ra/ggAu9opvQ
	(envelope-from <stable+bounces-258654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:21:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F7A611908
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 415843090AAB
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E142D32F770;
	Sat, 30 May 2026 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IuaTecTq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4984233D9E;
	Sat, 30 May 2026 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165080; cv=none; b=VMBwv6RNkZY5JUxXe8Gkrwksylncj4j3RsokULRfS43HBBvj0Gvfk8v4rPDtNdE1Ur5kGfrd7QX05hYYgm0f23AR7xT7KXZ+A77owJPrd1mhhr+kUwiibA1osR4WVOBS24xE281lorlZCpWc3y//rNwXn7vJzJtF5ZBDTcIr5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165080; c=relaxed/simple;
	bh=ShzPnE/oPSIt6uY1aW/7JutV1kCtKshGNCbR/WhPuq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3zNQ4CcafhqeG7kzkmTQYilApNk3kqt/kBVFIYcN2A3GCoEDJoexUiXXC3cH95XEFCxsY7CJqhdc9oBTgZipyB+nwNgONSlTqEZyOoyaFu6oR0ns6j8UjOY2mvC1Te1+wFMTne2KEtmBnwFXPJI8lnBSv2i1zR8TaoiQLSTYoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IuaTecTq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17841F00893;
	Sat, 30 May 2026 18:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165079;
	bh=SVrbcRVimrd/OX2MdRVncMMpPHO6pnAQDkDbT1u3h+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IuaTecTq7f4cnSeQETMzpO6+GJwkBhLG4e7oGWXGCc6Au1xVeRhge1NaCLS7YQoWP
	 P5o+XnyW/Ap/mtsaNylEhbxb9f+qedZboxQ9AfoJ/IMaXpk95mEN0cWlsY5xA6U5WZ
	 3LA7F1Z8JgRUXVcFb6Em45+to1y4UMzgip0Ybs+M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damiano Melotti <melotti@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 744/776] tcp: Fix imbalanced icsk_accept_queue count.
Date: Sat, 30 May 2026 18:07:38 +0200
Message-ID: <20260530160259.008479322@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258654-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B5F7A611908
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 7eca3292cac7c26dad4c236f51ba225c39a0523f ]

When TCP socket migration happens in reqsk_timer_handler(),
@sk_listener will be updated with the new listener.

When we call __inet_csk_reqsk_queue_drop(), the listener must
be the one stored in req->rsk_listener.

The cited commit accidentally replaced oreq->rsk_listener with
sk_listener, leading to imbalanced icsk_accept_queue count.

Let's pass the correct listener to __inet_csk_reqsk_queue_drop().

Fixes: e8c526f2bdf1 ("tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().")
Reported-by: Damiano Melotti <melotti@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260506035954.1563147-3-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_connection_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 412c06bf60362..d99fed07b024f 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -934,7 +934,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 	}
 
 drop:
-	__inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
+	__inet_csk_reqsk_queue_drop(oreq->rsk_listener, oreq, true);
 	reqsk_put(oreq);
 }
 
-- 
2.53.0




