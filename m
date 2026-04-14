Return-Path: <stable+bounces-237816-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPLQFSgl3mmMoAkAu9opvQ
	(envelope-from <stable+bounces-237816-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:29:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CB33F95C3
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C40D230920CF
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2193DBD66;
	Tue, 14 Apr 2026 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuG/rJyc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD16D3DE456
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165925; cv=none; b=EaS8q/SQ6iZDZhLdDUpbe8ZWYu2KIRas4qSPYZ2yYBZDGV9E37ooqvgBWZlhDE+4x1zCU184Rij3mYvhnbBbY9ScLhQQVqPpneXXb4HFeM2vvaV2l7FudTo2I7zlfIF2aSf6KQ0eiea75YVt86YfmboyN0tPqcqDfYGuPpQWXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165925; c=relaxed/simple;
	bh=KdByVNpXwoj8JCwHdD/Ndd3Y7TdG/8P5pYAQVFpoFsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWTKoeeClLDjPDCJ4VKqBUiX4K0V47tYW3ZQoXlYVPltv6nJA+xSHYNANOpY7vEJdehED+fuFlcXJG+rERiCZ2OBLC9T1V6TZaJew3pXIrUsZHs2gGSu4VK3xWP1hT6d42W3yp2rKQjBWPPXW/gNLwkuTGTQLQ1oDYRheX5InLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuG/rJyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C28C2BCB0;
	Tue, 14 Apr 2026 11:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776165925;
	bh=KdByVNpXwoj8JCwHdD/Ndd3Y7TdG/8P5pYAQVFpoFsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YuG/rJycVXxEsw8gNa7DFG0dfBNU2ycsIqm685YDwlB5PIOEjt6Yrks+EOux43YdV
	 6Bs9vH6+VgjPkX+vHIdCJWD+kKrEcfyBtiSVC0oSCN7XBGS0nc4FAIb/IiqzYtv0VJ
	 /vod7t4w4l1GL/WwNata2HXu4xLuCx4ADIa2A4u/q0uouVzVCpFVRsT3tc+x2mTDsz
	 Gb07gexNh3LLAIPtSxDTwy9oflWKzqNQW6vru2eLjunMpZejYZqH1souMU+Y8QHFg9
	 +MokuIjGKmtM2A3ZDu2bBmkXYsgcluMiTyRFoE/X+CTYOt7w5bnU8GDYMQSno4r40Z
	 wMfzdwhkF7wXA==
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
Subject: [PATCH 6.6.y 2/2] rxrpc: only handle RESPONSE during service challenge
Date: Tue, 14 Apr 2026 07:25:21 -0400
Message-ID: <20260414112521.410826-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414112521.410826-1-sashal@kernel.org>
References: <2026041311-bullion-gave-bf22@gregkh>
 <20260414112521.410826-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lzu.edu.cn,gmail.com,redhat.com,auristor.com,kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237816-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,auristor.com:email,infradead.org:email,lzu.edu.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1CB33F95C3
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
[ adapted spin_lock_irq/spin_unlock_irq calls to spin_lock/spin_unlock ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/conn_event.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index c8df12d80c7ce..6ef2dc1aa8cc2 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -233,6 +233,7 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 			       struct sk_buff *skb)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	bool secured = false;
 	int ret;
 
 	if (conn->state == RXRPC_CONN_ABORTED)
@@ -245,6 +246,13 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 		return conn->security->respond_to_challenge(conn, skb);
 
 	case RXRPC_PACKET_TYPE_RESPONSE:
+		spin_lock(&conn->state_lock);
+		if (conn->state != RXRPC_CONN_SERVICE_CHALLENGING) {
+			spin_unlock(&conn->state_lock);
+			return 0;
+		}
+		spin_unlock(&conn->state_lock);
+
 		ret = conn->security->verify_response(conn, skb);
 		if (ret < 0)
 			return ret;
@@ -255,11 +263,13 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 			return ret;
 
 		spin_lock(&conn->state_lock);
-		if (conn->state == RXRPC_CONN_SERVICE_CHALLENGING)
+		if (conn->state == RXRPC_CONN_SERVICE_CHALLENGING) {
 			conn->state = RXRPC_CONN_SERVICE;
+			secured = true;
+		}
 		spin_unlock(&conn->state_lock);
 
-		if (conn->state == RXRPC_CONN_SERVICE) {
+		if (secured) {
 			/* Offload call state flipping to the I/O thread.  As
 			 * we've already received the packet, put it on the
 			 * front of the queue.
-- 
2.53.0


