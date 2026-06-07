Return-Path: <stable+bounces-261219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a+mMMLtHJWqVFwIAu9opvQ
	(envelope-from <stable+bounces-261219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:28:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E6564FACB
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:28:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="vDg/2Z7D";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261219-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261219-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B66F3029772
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5646631E85C;
	Sun,  7 Jun 2026 10:21:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A28631F992;
	Sun,  7 Jun 2026 10:21:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827711; cv=none; b=aKJvZXEVlYIHrwrgk1W7spid3205x05zH+59GFtyv1jCsMQL4gUWFpRm5OstltwGzPHr6CHhWDuVYic8L9RSnDI/OmBurTRq3CUYmSpt8ovwmsVWxNXMWR+iRMJcGeF/intTAYUzJ7364XcnXd8T3d4zlXhnz+8yc6w9pMQwqyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827711; c=relaxed/simple;
	bh=aGJN/Gf7rpX4fAMN8+274qaJR4GOAcIM9RWqI3RC4Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGyc0Zb1Mumm6oV7DjD3nBf3LAJo5rb2EA5bsYwq+bR5x9nAtxyGMQRDrwrfK98nanHYe03hr15iu6o/Mvz1Rg7K3hkuIm6APjINrNXUOU234COpGacXLppoQQfcU0E4hWrnXqSmYMlZVykYBlS3iTEEO2MPrCUabSFupT51ayc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vDg/2Z7D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB7B1F00893;
	Sun,  7 Jun 2026 10:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827708;
	bh=Vmp15fYj6k0FTIUOXZVCvpkR8Fdm4CA56wuUPNU9mnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vDg/2Z7DFJbkkjuq94q5KfkTr6dlBP9mk2nKoGGwl7T4a/t1ea3fFmMzdZVFe94+5
	 ElVglkNKWs2bMeRQizwrtUISOsLHhhPA9J4f96SBUIuK0C2HCREDwx1Nqo5FSz4kbF
	 1w/CvQoKml2+LZbtsAXXFl7PYA+yj0cNL9IPg0c4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 080/307] net/handshake: Use spin_lock_bh for hn_lock
Date: Sun,  7 Jun 2026 11:57:57 +0200
Message-ID: <20260607095730.712963209@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261219-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:chuck.lever@oracle.com,m:hare@kernel.org,m:pabeni@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,oracle.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41E6564FACB

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit cc993e0927ec8bd98ea33377ada03295fcda0f24 ]

nvmet_tcp_state_change(), a socket callback that runs in BH context,
can reach handshake_req_cancel() via nvmet_tcp_schedule_release_queue()
and tls_handshake_cancel().  handshake_req_cancel() acquires
hn->hn_lock with plain spin_lock().  If a process-context thread on
the same CPU holds hn->hn_lock when a softirq invokes the cancel path,
the lock attempt deadlocks.  This is the only caller that invokes
tls_handshake_cancel() from BH context; every other consumer calls it
from process context.

Deferring the cancel to process context in the NVMe target is not
straightforward: nvmet_tcp_schedule_release_queue() must call
tls_handshake_cancel() atomically with its state transition to
DISCONNECTING.  If the cancel were deferred, the handshake completion
callback could fire in the window before the cancel runs, observe the
unexpected state, and return without dropping its kref on the queue.
Reworking that interlock is considerably more invasive than hardening
the handshake lock.  Convert all hn->hn_lock acquisitions from
spin_lock/spin_unlock to spin_lock_bh/spin_unlock_bh so the lock is
never taken with softirqs enabled.

Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260525-handshake-file-pin-v3-1-66c616906ead@oracle.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/handshake/netlink.c |  4 ++--
 net/handshake/request.c | 14 +++++++-------
 net/handshake/tlshd.c   |  2 ++
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 7e46d130dce2cd..394e270cc505cb 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -203,10 +203,10 @@ static void __net_exit handshake_net_exit(struct net *net)
 	 * accepted and are in progress will be destroyed when
 	 * the socket is closed.
 	 */
-	spin_lock(&hn->hn_lock);
+	spin_lock_bh(&hn->hn_lock);
 	set_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags);
 	list_splice_init(&requests, &hn->hn_requests);
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 
 	while (!list_empty(&requests)) {
 		req = list_first_entry(&requests, struct handshake_req, hr_list);
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 5df102534a596f..75562f6629e050 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -168,12 +168,12 @@ static bool remove_pending(struct handshake_net *hn, struct handshake_req *req)
 {
 	bool ret = false;
 
-	spin_lock(&hn->hn_lock);
+	spin_lock_bh(&hn->hn_lock);
 	if (!list_empty(&req->hr_list)) {
 		__remove_pending_locked(hn, req);
 		ret = true;
 	}
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 
 	return ret;
 }
@@ -183,7 +183,7 @@ struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 	struct handshake_req *req, *pos;
 
 	req = NULL;
-	spin_lock(&hn->hn_lock);
+	spin_lock_bh(&hn->hn_lock);
 	list_for_each_entry(pos, &hn->hn_requests, hr_list) {
 		if (pos->hr_proto->hp_handler_class != class)
 			continue;
@@ -191,7 +191,7 @@ struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 		req = pos;
 		break;
 	}
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 
 	return req;
 }
@@ -250,7 +250,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 	if (READ_ONCE(hn->hn_pending) >= hn->hn_pending_max)
 		goto out_err;
 
-	spin_lock(&hn->hn_lock);
+	spin_lock_bh(&hn->hn_lock);
 	ret = -EOPNOTSUPP;
 	if (test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags))
 		goto out_unlock;
@@ -259,7 +259,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 		goto out_unlock;
 	if (!__add_pending_locked(hn, req))
 		goto out_unlock;
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 
 	ret = handshake_genl_notify(net, req->hr_proto, flags);
 	if (ret) {
@@ -275,7 +275,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 	return 0;
 
 out_unlock:
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 out_err:
 	/* Restore original destructor so socket teardown still runs on failure */
 	req->hr_sk->sk_destruct = req->hr_odestruct;
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 822507b87447c0..fd71ef2d18ceb2 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -419,6 +419,8 @@ EXPORT_SYMBOL(tls_server_hello_psk);
  * Request cancellation races with request completion. To determine
  * who won, callers examine the return value from this function.
  *
+ * Context: May be called from process or softirq context.
+ *
  * Return values:
  *   %true - Uncompleted handshake request was canceled
  *   %false - Handshake request already completed or not found
-- 
2.53.0




