Return-Path: <stable+bounces-265508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 42r/C86LMWoYmQUAu9opvQ
	(envelope-from <stable+bounces-265508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:45:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C7269373F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:45:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=LwxUMN23;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265508-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265508-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 900E73217CE1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD7C47AF75;
	Tue, 16 Jun 2026 17:39:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6547AF5F;
	Tue, 16 Jun 2026 17:39:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631566; cv=none; b=fE3VC1X7oBaVCxVIBbbqjWJtIiPYmEQ1TjzKQTfSrNHSzyAD8XWOWuazymj/30bAO5fBbmJQTcw/4LI146MUFNC7QVqgsvgmhrbCFl9rSI7U/rCRe9afis/gNb0tWevMEkkHUaZAhZtxgnsYFyfen6Wp6fpZyWo4whoYbQm5qEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631566; c=relaxed/simple;
	bh=KN9ah7mvsKMfMNkgvzzde4T5L7ayWlpPfUNIjJg0tYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2eBDtYUiavvJKdA7b4aS+KvCibqpwVOdSo0vO6yupENgiCsONUf/BgLUrl44zwJmBbmTmggjAD31BjPD8HYUJSO0h26j8cGBUL1rmnazoJp0oSUJhfXs226cu9fiDAQLJBxcXshIP6E39vt7ts121NYIAgLVMK1UBseMr3Hh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LwxUMN23; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A40F1F000E9;
	Tue, 16 Jun 2026 17:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631564;
	bh=wT+CYkDKyfQDzcudA8eDnhZDWc/Q+IRFhlZ+MnEwuBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LwxUMN23C6CHZU49+FMzx7fJDMR1uUofUGj4nhDPBnQ1T+OqgeTOFr0KvCxNdpfce
	 Z/a6iBDpgpnN6zSunDJ64zyVsnEUcuYzR2noKQba6XrfvrGrb8KjAQYRkL2KU2pgF8
	 +2xX2iElvMwzaHr0WzbID1ry58Hsiq3calQFIOgA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Cen <rollkingzzc@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 212/522] Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
Date: Tue, 16 Jun 2026 20:25:59 +0530
Message-ID: <20260616145135.967815166@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265508-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:rollkingzzc@gmail.com,m:luiz.von.dentz@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5C7269373F

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index bc2b22c2b3aec7..d72cdcd2e2bb11 100644
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
@@ -941,6 +951,7 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 {
 	struct sock *sk, *parent;
 	bdaddr_t src, dst;
+	bool defer_setup = false;
 	int result = 0;
 
 	BT_DBG("session %p channel %d", s, channel);
@@ -954,6 +965,11 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 
 	lock_sock(parent);
 
+	if (parent->sk_state != BT_LISTEN)
+		goto done;
+
+	defer_setup = test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags);
+
 	/* Check for backlog size */
 	if (sk_acceptq_is_full(parent)) {
 		BT_DBG("backlog full %d", parent->sk_ack_backlog);
@@ -981,9 +997,11 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
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




