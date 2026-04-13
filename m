Return-Path: <stable+bounces-236315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCp/IXYY3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:23:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C9E3EEC45
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFE64304893B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BF12C11CA;
	Mon, 13 Apr 2026 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GJjL0o3h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEE2279334;
	Mon, 13 Apr 2026 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096591; cv=none; b=J1QPGwbksZQVXZ97QWlB8cYWUqgI2osDxgoWXuLPvoizAKO23hnc65Va8xlVswZaBi+z5sYzszpD73QkNP3LYP3Qc4OZA/5qC6Z3fbi1CnASP3R1707ia/Bb41ycJbLaKjJi5hEx0yaA10XZ+s/e8NkPigp21tYwbg/2NSinf5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096591; c=relaxed/simple;
	bh=vwt5e78N9D8oOyujM3am7PBIt+zBlBlJaNvgO3JNPnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koALYaNdMkxEfuqlWnjDN+IrBPbucnhI9dZkRT5A2FNKKdaOcQ3r+vUDRpFgSAM4F9YBxJwzHwzFcBe5dDx9ZqWlpJxVJBzj40+5nXJqQ53zpvCtIzzuc8vTJjaIdZRS5HpDcbOId40L92jxzETQZJ2Zi01iqvs6YjgPrRku5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GJjL0o3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06611C2BCAF;
	Mon, 13 Apr 2026 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096591;
	bh=vwt5e78N9D8oOyujM3am7PBIt+zBlBlJaNvgO3JNPnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJjL0o3hQA6dwkK6Vz2kHXAru/vn/JHuyFUb9NLUGaJgolRyp/iMxzawp+LOtyeeC
	 OoFjnmSQnR0smkniGB82tgHx1RFZYz3TlMxDUqpkXjx14X1WI/4xZO2GXFxadYqBYx
	 ZzTERkQY4bkMlw9jiqfIRUe4QThalAMyvSfgobPo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Dionne <marc.dionne@auristor.com>,
	David Howells <dhowells@redhat.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 70/83] rxrpc: Fix to request an ack if window is limited
Date: Mon, 13 Apr 2026 18:00:38 +0200
Message-ID: <20260413155733.617195622@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236315-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,msgid.link:url,infradead.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85C9E3EEC45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Dionne <marc.c.dionne@gmail.com>

commit 0cd3e3f3f2ec1a45aa559e2c0f3d57fac5eb3c25 upstream.

Peers may only send immediate acks for every 2 UDP packets received.
When sending a jumbogram, it is important to check that there is
sufficient window space to send another same sized jumbogram following
the current one, and request an ack if there isn't.  Failure to do so may
cause the call to stall waiting for an ack until the resend timer fires.

Where jumbograms are in use this causes a very significant drop in
performance.

Fixes: fe24a5494390 ("rxrpc: Send jumbo DATA packets")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-10-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/trace/events/rxrpc.h |    1 +
 net/rxrpc/ar-internal.h      |    2 +-
 net/rxrpc/output.c           |    2 ++
 net/rxrpc/proc.c             |    5 +++--
 4 files changed, 7 insertions(+), 3 deletions(-)

--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -521,6 +521,7 @@
 #define rxrpc_req_ack_traces \
 	EM(rxrpc_reqack_ack_lost,		"ACK-LOST  ")	\
 	EM(rxrpc_reqack_app_stall,		"APP-STALL ")	\
+	EM(rxrpc_reqack_jumbo_win,		"JUMBO-WIN ")	\
 	EM(rxrpc_reqack_more_rtt,		"MORE-RTT  ")	\
 	EM(rxrpc_reqack_no_srv_last,		"NO-SRVLAST")	\
 	EM(rxrpc_reqack_old_rtt,		"OLD-RTT   ")	\
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -117,7 +117,7 @@ struct rxrpc_net {
 	atomic_t		stat_tx_jumbo[10];
 	atomic_t		stat_rx_jumbo[10];
 
-	atomic_t		stat_why_req_ack[8];
+	atomic_t		stat_why_req_ack[9];
 
 	atomic_t		stat_io_loop;
 };
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -479,6 +479,8 @@ static size_t rxrpc_prepare_data_subpack
 		why = rxrpc_reqack_old_rtt;
 	else if (!last && !after(READ_ONCE(call->send_top), txb->seq))
 		why = rxrpc_reqack_app_stall;
+	else if (call->tx_winsize <= (2 * req->n) || call->cong_cwnd <= (2 * req->n))
+		why = rxrpc_reqack_jumbo_win;
 	else
 		goto dont_set_request_ack;
 
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -518,11 +518,12 @@ int rxrpc_stats_show(struct seq_file *se
 		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_IDLE]),
 		   atomic_read(&rxnet->stat_rx_acks[0]));
 	seq_printf(seq,
-		   "Why-Req-A: acklost=%u mrtt=%u ortt=%u stall=%u\n",
+		   "Why-Req-A: acklost=%u mrtt=%u ortt=%u stall=%u jwin=%u\n",
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_ack_lost]),
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_more_rtt]),
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_old_rtt]),
-		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_app_stall]));
+		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_app_stall]),
+		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_jumbo_win]));
 	seq_printf(seq,
 		   "Why-Req-A: nolast=%u retx=%u slows=%u smtxw=%u\n",
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_no_srv_last]),



