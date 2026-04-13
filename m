Return-Path: <stable+bounces-236062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FCjILHn3GmUYAkAu9opvQ
	(envelope-from <stable+bounces-236062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:55:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D283EC418
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A89F30724DA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1923C7E0C;
	Mon, 13 Apr 2026 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GaLWDcir"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934473C660A
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776084669; cv=none; b=Fquum293Orn6KvQ33X89DbS2hfkksAXgIqnQsPy0XNTzvS93UOa9WcKFJTe46lzsbJJWr9Kk3tUPp1g4OnGg9T6S1C5/pNWl7eGQ5qq+843LKiel5yflijffgl1Pldqjf8oT4zcw73D1zta8B6aUEzUdPMziIEVpNLIwnrSJwwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776084669; c=relaxed/simple;
	bh=HdIS3dFjunFSkGc/b3uVMxjksvQNV0E3VmE0iftLhOU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Kozh5RpbrvCxcAQWoCRD7YkJ2ODHMfUe1jlu7I1cE5eojPbwNeEyNsRjMjrmEK9owz+UjNUEmbMCvwnoKWc7diHbBxA1tdNMhDR3nkfq7oBaMc574Hce3dj4bxwWrhmjfn1zHway0RopomRfohoBvVpI2TCby2iozU3BJAyuv0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GaLWDcir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A368C2BCAF;
	Mon, 13 Apr 2026 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776084669;
	bh=HdIS3dFjunFSkGc/b3uVMxjksvQNV0E3VmE0iftLhOU=;
	h=Subject:To:Cc:From:Date:From;
	b=GaLWDcir52Ubz4SIP/aWHlDCgT2iSAjQ8W60N+/ckbYxlhglgGeOn4sGCaZGK2psj
	 4N8ABFWInC9Q6FhNOHyrYUDYz6FCrEQzJRfilsLb61rANGprlKnnb8nYLcp9yLNscr
	 lYMsIidfinhyzv7VWrwiiMZYLf7VViQa2yJ4iFBE=
Subject: FAILED: patch "[PATCH] rxrpc: only handle RESPONSE during service challenge" failed to apply to 6.12-stable tree
To: jiewang2024@lzu.edu.cn,bird@lzu.edu.cn,dhowells@redhat.com,horms@kernel.org,jaltman@auristor.com,kuba@kernel.org,marc.dionne@auristor.com,n05ec@lzu.edu.cn,tomapufckgml@gmail.com,yifanwucs@gmail.com,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Apr 2026 14:37:10 +0200
Message-ID: <2026041310-strung-among-c622@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236062-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lzu.edu.cn,redhat.com,kernel.org,auristor.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,auristor.com:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3D283EC418
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c43ffdcfdbb5567b1f143556df8a04b4eeea041c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041310-strung-among-c622@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c43ffdcfdbb5567b1f143556df8a04b4eeea041c Mon Sep 17 00:00:00 2001
From: Wang Jie <jiewang2024@lzu.edu.cn>
Date: Wed, 8 Apr 2026 13:12:48 +0100
Subject: [PATCH] rxrpc: only handle RESPONSE during service challenge

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

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index c50cbfc5a313..9a41ec708aeb 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -247,6 +247,7 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 			       struct sk_buff *skb)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	bool secured = false;
 	int ret;
 
 	if (conn->state == RXRPC_CONN_ABORTED)
@@ -262,6 +263,13 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
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
@@ -272,11 +280,13 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
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


