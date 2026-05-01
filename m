Return-Path: <stable+bounces-242357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TjiVFaWW9GnTCgIAu9opvQ
	(envelope-from <stable+bounces-242357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:03:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA77E4AC2D7
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D8CD3017F84
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 12:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2898395D84;
	Fri,  1 May 2026 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RyZSmZgL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58C93890F3
	for <stable@vger.kernel.org>; Fri,  1 May 2026 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777637025; cv=none; b=Yr+PBgloKCuN1+k7LJgDzCZzaceQb4GFCTDE5GVC+0PcbfP9DojXucTzKUIyFcJ5tzUPQM3qgPNoJL/vlIUVm1WaRfwBJ9q8+/yrWLHj57SRnF5hk+GlxNcT7xq92uqoqpnWy7rmQReok6uZJQPEXvpqKijetkr5W+TDKEEypOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777637025; c=relaxed/simple;
	bh=i2lf1DN6NluUH/3WYdWtIdtEJVzkqKDdhwJpEzUZs0I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hcKTDJWylRI6VnhBqctlpcuysuJLL9bRXlB77+IpKie37qUP1hZFndcM/dGX0vr9aY76hzygugvwcb4dLzwr8eJpdzoHjrdCdL9pUcQBlrzlVRfKnkV6FcCjx6NUda+cyy1cl0KNzFd8jay28ZvA8EpK6InMMEXxZNwY8IVYrsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RyZSmZgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E726C2BCB4;
	Fri,  1 May 2026 12:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777637025;
	bh=i2lf1DN6NluUH/3WYdWtIdtEJVzkqKDdhwJpEzUZs0I=;
	h=Subject:To:Cc:From:Date:From;
	b=RyZSmZgL05Sy88zp0c68DIRldbeNi4wXTzJsVvGmtX2LaQNI8GJ/RQQe0cOqr265d
	 1jtoTz6ldYBT8CYwk4XzPDYO0em//IADIlkpz38GWvxE6u11nBDARv3WieqGifDEgA
	 WyZbxUQ2e0NXE/lKomEohJ0+VQHB8cOvl2dGHRf0=
Subject: FAILED: patch "[PATCH] rxrpc: Fix re-decryption of RESPONSE packets" failed to apply to 5.15-stable tree
To: dhowells@redhat.com,horms@kernel.org,jaltman@auristor.com,kuba@kernel.org,marc.dionne@auristor.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 14:03:42 +0200
Message-ID: <2026050142-sabotage-economist-a92e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA77E4AC2D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242357-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0422e7a4883f25101903f3e8105c0808aa5f4ce9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050142-sabotage-economist-a92e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0422e7a4883f25101903f3e8105c0808aa5f4ce9 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Thu, 23 Apr 2026 21:09:07 +0100
Subject: [PATCH] rxrpc: Fix re-decryption of RESPONSE packets

If a RESPONSE packet gets a temporary failure during processing, it may end
up in a partially decrypted state - and then get requeued for a retry.

Fix this by just discarding the packet; we will send another CHALLENGE
packet and thereby elicit a further response.  Similarly, discard an
incoming CHALLENGE packet if we get an error whilst generating a RESPONSE;
the server will send another CHALLENGE.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Closes: https://sashiko.dev/#/patchset/20260422161438.2593376-4-dhowells@redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260423200909.3049438-3-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 13b9d017f8e1..573f2df3a2c9 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -285,7 +285,6 @@
 	EM(rxrpc_conn_put_unidle,		"PUT unidle  ") \
 	EM(rxrpc_conn_put_work,			"PUT work    ") \
 	EM(rxrpc_conn_queue_challenge,		"QUE chall   ") \
-	EM(rxrpc_conn_queue_retry_work,		"QUE retry-wk") \
 	EM(rxrpc_conn_queue_rx_work,		"QUE rx-work ") \
 	EM(rxrpc_conn_see_new_service_conn,	"SEE new-svc ") \
 	EM(rxrpc_conn_see_reap_service,		"SEE reap-svc") \
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index aee977291d90..a2130d25aaa9 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -389,7 +389,6 @@ void rxrpc_process_delayed_final_acks(struct rxrpc_connection *conn, bool force)
 static void rxrpc_do_process_connection(struct rxrpc_connection *conn)
 {
 	struct sk_buff *skb;
-	int ret;
 
 	if (test_and_clear_bit(RXRPC_CONN_EV_CHALLENGE, &conn->events))
 		rxrpc_secure_connection(conn);
@@ -398,17 +397,8 @@ static void rxrpc_do_process_connection(struct rxrpc_connection *conn)
 	 * connection that each one has when we've finished with it */
 	while ((skb = skb_dequeue(&conn->rx_queue))) {
 		rxrpc_see_skb(skb, rxrpc_skb_see_conn_work);
-		ret = rxrpc_process_event(conn, skb);
-		switch (ret) {
-		case -ENOMEM:
-		case -EAGAIN:
-			skb_queue_head(&conn->rx_queue, skb);
-			rxrpc_queue_conn(conn, rxrpc_conn_queue_retry_work);
-			break;
-		default:
-			rxrpc_free_skb(skb, rxrpc_skb_put_conn_work);
-			break;
-		}
+		rxrpc_process_event(conn, skb);
+		rxrpc_free_skb(skb, rxrpc_skb_put_conn_work);
 	}
 }
 


