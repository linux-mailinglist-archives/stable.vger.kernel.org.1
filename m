Return-Path: <stable+bounces-264282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KUnzE7hyMWpqjgUAu9opvQ
	(envelope-from <stable+bounces-264282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:58:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE82769195A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:58:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=cSnnEqXS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264282-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264282-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 230CA3009163
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA0A44CF40;
	Tue, 16 Jun 2026 15:52:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3C15B998;
	Tue, 16 Jun 2026 15:52:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625144; cv=none; b=BhqPewi+Gw1YuKmRmEbN67O5KnawgtJmrvJZkwSfkYJnWUGRzWJqEEmhQ9C6XTCa5NAaNc74zK+5UjoTZgPwLIzFgPu99epr3cnoOoiwxdq9L6HfCqSgz99/RsmggceMP/VUKECV3cgFNFgUZH0AEKUBM8VVXpvau4BG8Lw8oq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625144; c=relaxed/simple;
	bh=eXwjPPxdbZdO+PKe2+OCZaXiFzAL1+/z6Y7En9F/scI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pA5cEDGnMHeW1/m+aEgToGIVHpElPOyEYd3aOVcmXx/IeV3ZHeX6UX4gZFGCyE1gPfPr+JCyxOo7SEQTetcrABbl2actx+A06oOz1twKBflFx5muqwzAPNU72nAnrSMNlndtVoHwoCkgWB6ZWfI7CL5MCR1hSFLEXoQ23eHndX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cSnnEqXS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EDE1F000E9;
	Tue, 16 Jun 2026 15:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625142;
	bh=LVrcshrtwFWLNMav0HsKWO1ih+p3HrgE6RxN79MRcKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cSnnEqXSEnduGaGuKfeWZI8kCj/natvoTtKP0J7cyM1Cl039STrAezLjxwCJJBbgt
	 K0zM4ANmp/LepD+fbf092MaR5moWbNudV4j7eMQnsQnx9mSZxkaNLQ5B0dss5AR3JX
	 xe4UAAskzJ11sTbUhtx69pE8sv2mZmrctHIINaCM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Cen <rollkingzzc@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 042/325] Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
Date: Tue, 16 Jun 2026 20:27:18 +0530
Message-ID: <20260616145059.824204809@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264282-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:rollkingzzc@gmail.com,m:luiz.von.dentz@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE82769195A

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Cen <rollkingzzc@gmail.com>

[ Upstream commit 43c441edacf953b39517a44f5e5e10a93618b226 ]

rfcomm_get_sock_by_channel() scans rfcomm_sk_list under the list lock,
but returns the selected listener after dropping that lock without
taking a reference. rfcomm_connect_ind() then locks the listener,
queues a child socket on it, and may notify it after unlocking it.

The buggy scenario involves two paths, with each column showing the
order within that path:

rfcomm_connect_ind():            listener close:
  1. Find parent in              1. close() enters
     rfcomm_get_sock_by_channel()   rfcomm_sock_release().
  2. Drop rfcomm_sk_list.lock    2. rfcomm_sock_shutdown()
     without pinning parent.        closes the listener.
  3. Call lock_sock(parent) and  3. rfcomm_sock_kill()
     bt_accept_enqueue(parent,      unlinks and puts parent.
     sk, true).
  4. Read parent flags and may   4. parent can be freed.
     call sk_state_change().

If close wins the race, parent can be freed before
rfcomm_connect_ind() reaches lock_sock(), bt_accept_enqueue(), or the
deferred-setup callback.

Take a reference on the listener before leaving rfcomm_sk_list.lock.
After lock_sock() succeeds, recheck that it is still in BT_LISTEN
before queueing a child, cache the deferred-setup bit while the parent
is locked, and drop the reference after the last parent use.

KASAN reported a slab-use-after-free in lock_sock_nested() from
rfcomm_connect_ind(), with the freeing stack going through
rfcomm_sock_kill() and rfcomm_sock_release().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/rfcomm/sock.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 3052436e9c6de5..2286efef62f5b6 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -122,7 +122,7 @@ static struct sock *__rfcomm_get_listen_sock_by_addr(u8 channel, bdaddr_t *src)
 }
 
 /* Find socket with channel and source bdaddr.
- * Returns closest match.
+ * Returns closest match with an extra reference held.
  */
 static struct sock *rfcomm_get_sock_by_channel(int state, u8 channel, bdaddr_t *src)
 {
@@ -136,15 +136,25 @@ static struct sock *rfcomm_get_sock_by_channel(int state, u8 channel, bdaddr_t *
 
 		if (rfcomm_pi(sk)->channel == channel) {
 			/* Exact match. */
-			if (!bacmp(&rfcomm_pi(sk)->src, src))
+			if (!bacmp(&rfcomm_pi(sk)->src, src)) {
+				sock_hold(sk);
 				break;
+			}
 
 			/* Closest match */
-			if (!bacmp(&rfcomm_pi(sk)->src, BDADDR_ANY))
+			if (!bacmp(&rfcomm_pi(sk)->src, BDADDR_ANY)) {
+				if (sk1)
+					sock_put(sk1);
+
 				sk1 = sk;
+				sock_hold(sk1);
+			}
 		}
 	}
 
+	if (sk && sk1)
+		sock_put(sk1);
+
 	read_unlock(&rfcomm_sk_list.lock);
 
 	return sk ? sk : sk1;
@@ -940,6 +950,7 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 {
 	struct sock *sk, *parent;
 	bdaddr_t src, dst;
+	bool defer_setup = false;
 	int result = 0;
 
 	BT_DBG("session %p channel %d", s, channel);
@@ -953,6 +964,11 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 
 	lock_sock(parent);
 
+	if (parent->sk_state != BT_LISTEN)
+		goto done;
+
+	defer_setup = test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags);
+
 	/* Check for backlog size */
 	if (sk_acceptq_is_full(parent)) {
 		BT_DBG("backlog full %d", parent->sk_ack_backlog);
@@ -980,9 +996,11 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 done:
 	release_sock(parent);
 
-	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
+	if (defer_setup)
 		parent->sk_state_change(parent);
 
+	sock_put(parent);
+
 	return result;
 }
 
-- 
2.53.0




