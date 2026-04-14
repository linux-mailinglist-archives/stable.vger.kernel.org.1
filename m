Return-Path: <stable+bounces-237804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CD1HSgj3mk1ngkAu9opvQ
	(envelope-from <stable+bounces-237804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:21:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9423F9401
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 809B6300A8ED
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08B93909BC;
	Tue, 14 Apr 2026 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kREu64JM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653793016FC
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165669; cv=none; b=KINV1ekAiJ51ZysttERVX9UNgcHSoapAEK5dAVIG1c4GVj/eS85i9LnUDF4jLHp0YDQWyL5PIQFu13+YMMwkRkaYw15D/hjHEdbc1WRT9vNVhwTlDY2ZBgmh5FWSfimeQr/T98Fbik0nhVItMwldjdMR4N729ensT7TG1aQN6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165669; c=relaxed/simple;
	bh=KdByVNpXwoj8JCwHdD/Ndd3Y7TdG/8P5pYAQVFpoFsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJfvTpmv8Tum9FAmU/nctzUouhPd8M2OD9dsLpTMDY7RoekyVcKskZbbOFqda2ugeLjASy1oQmGg9FiIryDWevqwbsQa73yAb8LYAly4d3DuL0o5WehGB7/qVXkwQHMmN2ps5CB6lNjqZ+84EzUtUftQZxSSWDg7QbpMTPXMZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kREu64JM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A26C2BCB0;
	Tue, 14 Apr 2026 11:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776165669;
	bh=KdByVNpXwoj8JCwHdD/Ndd3Y7TdG/8P5pYAQVFpoFsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kREu64JMn7KLa23P2lGNy+dCv3xpGdv/z0wDqajRyj2oC3hcpeIMNoLfiobhzRq94
	 TX+0klFNzNiN9iyHycI/LKsRiw16MJLM9mWnDwc5HiS6WCBYKt48zVHAz5o6eEapoj
	 SusehaqDglIXAtmaLw5lOxuCjHYT2k9ww3vQTeWjXa7BnPSV/8H74kulJ4+el7q4rh
	 pTrwQMOpAcwUKG2o4wgcrT/cqNl8gemYFIqoJOYRJqVcMbx68cITFTCAJeFQPt5HXW
	 bp5uCo0T4vDPZhBf4wWO0QV62tD1BmwQ6VidgyQrY9RpO78Gcf6zGLbTTT98Xy1GH3
	 ++r253IUoxbvw==
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
Subject: [PATCH 6.12.y 2/2] rxrpc: only handle RESPONSE during service challenge
Date: Tue, 14 Apr 2026 07:21:03 -0400
Message-ID: <20260414112103.379483-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414112103.379483-1-sashal@kernel.org>
References: <2026041310-strung-among-c622@gregkh>
 <20260414112103.379483-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lzu.edu.cn,gmail.com,redhat.com,auristor.com,kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237804-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,infradead.org:email,lzu.edu.cn:email]
X-Rspamd-Queue-Id: DB9423F9401
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


