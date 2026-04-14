Return-Path: <stable+bounces-237830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Np6I4Up3mmSoQkAu9opvQ
	(envelope-from <stable+bounces-237830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:48:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3703F9968
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5145130BEA30
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF323E1CFD;
	Tue, 14 Apr 2026 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2lOd7DQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAE83E1CEB
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167133; cv=none; b=H7LGUcIKdrDi+Y0IJdTl1+ouH1EZQDryJDEMHN5B/ZXXtd7HUH2zb19tutO2ORTAUNpo34dQUctqawrcS9AaCbWJnUizfsWG7V4v6JghVSjwTlyvx+sUriwA1nYoDBCSP9f/2BKbNodpqayIIK/QcdLWwEVrTR27gce5pBJE988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167133; c=relaxed/simple;
	bh=yV7k8BaLQHTvZnyy5R6NOwARz6C0CTCj7rFP+xzkRg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpkg4E4ZaNjdOxyZAMElS8YP3y42IH+aHg5WiGfu4um0GuVy2XmOhbVcXY+WOh3y0B2yyBj9ICA7bqhVf/RnUkgaX4DEJduoIAWA9phbhDk2RgJ1EaJa2fucxr87QY61kOC9hBBxxDh0GZLQqXiDXr1enzIZBHUROIQQ53RYXbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2lOd7DQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45558C19425;
	Tue, 14 Apr 2026 11:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776167132;
	bh=yV7k8BaLQHTvZnyy5R6NOwARz6C0CTCj7rFP+xzkRg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g2lOd7DQMUfwZePvwy39wmFBpUKyCcmmeYQsRP3kjEdinsuE7Kawc9eNDRSJPkNWQ
	 vQOW8AHLve3cjty1lcKQsh4W35fHVaIYZHReWQC1rwVqdP71MZy+neoan3g9/7vOvb
	 TKbt5XaHQRzEaSiEDE/++T094KNFQTM0YQCC3pVdgk9IgiL6TQE3kUI2xfrbIJWMME
	 ElpPKHz9bfTjVy6wRJnMY5qmoMJo9195+pepw8PgKnKxTSnfRIQ2TZZzwQAlJi5l7y
	 FLaCjM6mXd/8/leBx1uNV7Ccaj/1tmBM03/Ft3z+jpXVJ5EeO9aXceDjyqqd/5v58q
	 sbi2xlzj6g8Dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wang Jie <jiewang2024@lzu.edu.cn>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Yang Yang <n05ec@lzu.edu.cn>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] rxrpc: only handle RESPONSE during service challenge
Date: Tue, 14 Apr 2026 07:45:29 -0400
Message-ID: <20260414114529.521040-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041311-economy-duckling-8a60@gregkh>
References: <2026041311-economy-duckling-8a60@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_CC(0.00)[lzu.edu.cn,gmail.com,redhat.com,auristor.com,kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237830-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,auristor.com:email,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: DD3703F9968
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 net/rxrpc/conn_event.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 5d91ef562ff78..293922df2a891 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -293,6 +293,7 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 			       u32 *_abort_code)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	bool secured = false;
 	__be32 wtmp;
 	u32 abort_code;
 	int loop, ret;
@@ -337,6 +338,13 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
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
@@ -348,17 +356,18 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 
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
-- 
2.53.0


