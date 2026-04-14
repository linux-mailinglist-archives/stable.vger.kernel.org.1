Return-Path: <stable+bounces-237841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CP5IlEt3mnxogkAu9opvQ
	(envelope-from <stable+bounces-237841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:04:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1513D3F9C39
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BF1B30C4EBF
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CF2245008;
	Tue, 14 Apr 2026 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX66sL2V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1207260D
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167776; cv=none; b=mkpb4wGGKAISfvP8KD8FtSYecfXWKChdL7gbT4IS+KJiGxFdrSZZiA0P+qHu6wKcoZPsP9Q/5pJkxmlSAI5KHajhJZkNEJEvXQApLp5DvBFmN+dBKlSWfyldeVbZTNHLMm7smQyUJPI2hKgPf2IxfSs5NXOCKU20gwLZWkpR0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167776; c=relaxed/simple;
	bh=/4cU0+pGzF4B0I49PKRp/X5JHOAQxm1NqY7zxqUugB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aN6Do1GPPkTrX4K97ZepPrhU7XL3K1woFWdnBN9X3pb/LsL7oQIkdc7Idjqq7KFulwueXdZTIkZ1YUgpasON5Iqr2nGgWfSXrAytH+jFWFYZMl9W71oAm37EZkLzpINEpm9KDSb5MFWwqzgnTqNRC01p8qECLJ0zRsJL1vxzr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UX66sL2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08100C19425;
	Tue, 14 Apr 2026 11:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776167776;
	bh=/4cU0+pGzF4B0I49PKRp/X5JHOAQxm1NqY7zxqUugB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UX66sL2VmKPi3kpkqkAzNGSMTPxkOuRGP1U2FlQjyg/vfNm1Lwl5FjYWXGQRNyboM
	 gksLuwKMS3iLzuhIzkKTgmkBv//0UN81kZJ+wowdZv9ZxAuTzZAlOaPww3Ip5WVbD9
	 Br/nNX8LoGS1fKQ/EN3/fQ6t0x7AQS57ZOS1l6k+ZQQaK2jfel+CsmICOumiGp9nVB
	 /mjG93zIDCTgP0VLu0mjIil1Ck6AR53E87ik1E656JXFvlAT4rIVknQO3P2p7eQK8H
	 yWSJx3C0Cc4sP79smAL3W1MikCUBYwfScEEtWnCddjmMkbQAvDlGl68FSmJabGxaOp
	 8HligEAhVpDIA==
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
Subject: [PATCH 5.10.y] rxrpc: only handle RESPONSE during service challenge
Date: Tue, 14 Apr 2026 07:56:13 -0400
Message-ID: <20260414115613.548439-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041312-chirping-bling-3a09@gregkh>
References: <2026041312-chirping-bling-3a09@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,msgid.link:server fail];
	FREEMAIL_CC(0.00)[lzu.edu.cn,gmail.com,redhat.com,auristor.com,kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237841-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,auristor.com:email,lzu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 1513D3F9C39
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
index 9081e84295844..205d2e4942389 100644
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
@@ -351,17 +359,18 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 
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


