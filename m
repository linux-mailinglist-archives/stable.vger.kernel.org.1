Return-Path: <stable+bounces-236334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGODOTYY3WnNZwkAu9opvQ
	(envelope-from <stable+bounces-236334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:22:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCD83EEB94
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF3B2307EC95
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF07288C30;
	Mon, 13 Apr 2026 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="035F8/kF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D728628C2DD;
	Mon, 13 Apr 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096637; cv=none; b=PaFrqN1TlKTpSeILtQLNomNSP53LHawcYeB4Q5TLUPWhMAiBP1pEMUE/Hx50yoE2721M69gh4eyk3AmSc9/16kOQ0hmrtUdDd/544XCsm58pRGLtm52iFZewaACbfQL10X+OaKQi/bn1g1fO9Iadx4DCUmHQhiloK/9DCTPrUAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096637; c=relaxed/simple;
	bh=EF0fuT8uJuk+6SVSiCIa8p2r09glF9vsSHQnRuORiZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acuC96DUA2fyd1BjVjuO0CgeOvL3lyX8eN5mzH2uRB3uiVYwfbrwIieRGWuEoyLO61wLkzRxeaq3w7C91iLeO7AHDnfrQMAuAdd8BBJaa7cJeJLQyBiTYRMopqbffkRakPDbPPnf3hRcozpYNYLRH8kB8pmiGvjyCh3tLKklx2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=035F8/kF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D22C2BCAF;
	Mon, 13 Apr 2026 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096637;
	bh=EF0fuT8uJuk+6SVSiCIa8p2r09glF9vsSHQnRuORiZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=035F8/kFlS5qJADvyHtVjy2I/bGOWHY2QTuktT9G0b/p+LJFk8DWL8a8SSEGorNq9
	 81JgeWAkbChiBZ9T3S/jdAVy+zrK88vT2YNX0MB/GnqkgV6FE6W73etxoVBqUxw9U5
	 Q2gl6SSEEFQBSqUR8CY8/Dnex72RH2LynrWRPRvw=
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 81/83] rxrpc: only handle RESPONSE during service challenge
Date: Mon, 13 Apr 2026 18:00:49 +0200
Message-ID: <20260413155734.014725600@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.019638460@linuxfoundation.org>
References: <20260413155731.019638460@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236334-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,redhat.com,auristor.com,kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,msgid.link:url,auristor.com:email,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 6BCD83EEB94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Jie <jiewang2024@lzu.edu.cn>

commit c43ffdcfdbb5567b1f143556df8a04b4eeea041c upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/conn_event.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -247,6 +247,7 @@ static int rxrpc_process_event(struct rx
 			       struct sk_buff *skb)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	bool secured = false;
 	int ret;
 
 	if (conn->state == RXRPC_CONN_ABORTED)
@@ -262,6 +263,13 @@ static int rxrpc_process_event(struct rx
 		return ret;
 
 	case RXRPC_PACKET_TYPE_RESPONSE:
+		spin_lock_irq(&conn->state_lock);
+		if (conn->state != RXRPC_CONN_SERVICE_CHALLENGING) {
+			spin_unlock_irq(&conn->state_lock);
+			return 0;
+		}
+		spin_unlock_irq(&conn->state_lock);
+
 		ret = conn->security->verify_response(conn, skb);
 		if (ret < 0)
 			return ret;
@@ -272,11 +280,13 @@ static int rxrpc_process_event(struct rx
 			return ret;
 
 		spin_lock_irq(&conn->state_lock);
-		if (conn->state == RXRPC_CONN_SERVICE_CHALLENGING)
+		if (conn->state == RXRPC_CONN_SERVICE_CHALLENGING) {
 			conn->state = RXRPC_CONN_SERVICE;
+			secured = true;
+		}
 		spin_unlock_irq(&conn->state_lock);
 
-		if (conn->state == RXRPC_CONN_SERVICE) {
+		if (secured) {
 			/* Offload call state flipping to the I/O thread.  As
 			 * we've already received the packet, put it on the
 			 * front of the queue.



