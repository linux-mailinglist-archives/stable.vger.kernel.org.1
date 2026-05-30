Return-Path: <stable+bounces-258109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPJmHbciG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-258109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:47:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7AF610646
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 828C13001187
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751EB261B9E;
	Sat, 30 May 2026 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fBItL4pL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D123D351C2F;
	Sat, 30 May 2026 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163248; cv=none; b=j10rJtzl3L8uE8f4cSicz78Zi9tPd0tbPZoFoMZIbs342xq0/aiFwHPiAn+Ce5/H4vfeJzDTTYtGInP2ZiBbvxEGX71YLQ1UUCjO7n3TqOUr2M3flghPfAR59kQYatE6w/BboaJ57z+A0dclVHxGX7bPeUHkVEG+DtAdfOXBBK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163248; c=relaxed/simple;
	bh=qR11z5JInM2ZOD/PGXkY3hGi/JzW1UwS4FRlwTRab0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKc2p+SA0hKmYMbpXIehIBGpa/X0oKJv6DBfQP1kYGVwIH9NpTJh4B8ArUmzaIu2/FGZtFahcZNMe8UbppXET4Nf849Corf/1lav0mJv7D+XEm07lA3l6riRL8x0UzPDZu+xAHEqXnZ1Xf/x8XPEdG5g0CT+jH9E4sRYwlR77C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fBItL4pL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958C21F00893;
	Sat, 30 May 2026 17:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163245;
	bh=lgyQMrFzc6SFmUw6gMYN+nZQGOSBqy/82pZiYYTQMXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fBItL4pLiwtrLU/rjGIXhSk/GyUfGP72M6/J2x/0O/KDEmYQeHLcLY3JJIj8ZpTKi
	 Zl7qJ+y8TAXvTvYp6q/rFQhnZzCnsmWe1PJCwCwFQ+enFYmnb7OUMecRyrWCJN18bk
	 uFL4WdDMJIc5SowAiA6sWWq/BoD/kI9Lp8j0KcVE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Jie Wang <jiewang2024@lzu.edu.cn>,
	Yang Yang <n05ec@lzu.edu.cn>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 167/776] rxrpc: only handle RESPONSE during service challenge
Date: Sat, 30 May 2026 17:58:01 +0200
Message-ID: <20260530160244.807884881@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258109-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,redhat.com,auristor.com,kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,lzu.edu.cn:email,infradead.org:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7A7AF610646
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Jie <jiewang2024@lzu.edu.cn>

[ Upstream commit c43ffdcfdbb5567b1f143556df8a04b4eeea041c ]

Only process RESPONSE packets while the service connection is still in
RXRPC_CONN_SERVICE_CHALLENGING. Check that state under state_lock before
running response verification and security initialization, then use a local
secured flag to decide whether to queue the secured-connection work after
the state transition. This keeps duplicate or late RESPONSE packets from
re-running the setup path and removes the unlocked post-transition state
test.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Jie Wang <jiewang2024@lzu.edu.cn>
Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-21-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adapted to spin_lock_bh usage, 3-arg verify_response(), and direct rxrpc_call_is_secure() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/conn_event.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -293,6 +293,7 @@ static int rxrpc_process_event(struct rx
 			       u32 *_abort_code)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	bool secured = false;
 	__be32 wtmp;
 	u32 abort_code;
 	int loop, ret;
@@ -337,6 +338,13 @@ static int rxrpc_process_event(struct rx
 							    _abort_code);
 
 	case RXRPC_PACKET_TYPE_RESPONSE:
+		spin_lock_bh(&conn->state_lock);
+		if (conn->state != RXRPC_CONN_SERVICE_CHALLENGING) {
+			spin_unlock_bh(&conn->state_lock);
+			return 0;
+		}
+		spin_unlock_bh(&conn->state_lock);
+
 		ret = conn->security->verify_response(conn, skb, _abort_code);
 		if (ret < 0)
 			return ret;
@@ -348,17 +356,18 @@ static int rxrpc_process_event(struct rx
 
 		spin_lock(&conn->bundle->channel_lock);
 		spin_lock_bh(&conn->state_lock);
-
 		if (conn->state == RXRPC_CONN_SERVICE_CHALLENGING) {
 			conn->state = RXRPC_CONN_SERVICE;
-			spin_unlock_bh(&conn->state_lock);
+			secured = true;
+		}
+		spin_unlock_bh(&conn->state_lock);
+
+		if (secured) {
 			for (loop = 0; loop < RXRPC_MAXCALLS; loop++)
 				rxrpc_call_is_secure(
 					rcu_dereference_protected(
 						conn->channels[loop].call,
 						lockdep_is_held(&conn->bundle->channel_lock)));
-		} else {
-			spin_unlock_bh(&conn->state_lock);
 		}
 
 		spin_unlock(&conn->bundle->channel_lock);



