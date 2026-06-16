Return-Path: <stable+bounces-264279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F21/DnNxMWrBjQUAu9opvQ
	(envelope-from <stable+bounces-264279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:53:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B00B691785
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:53:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=QXn+kXR8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264279-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264279-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 948DF301F9AE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6E244D6AB;
	Tue, 16 Jun 2026 15:52:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED87344CAF9;
	Tue, 16 Jun 2026 15:52:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625127; cv=none; b=HbPffTOCbXn8CsHWS4Lxkrbe6fmnEmbFC+kplLWdHP5Efa3cm9EHny+jYP3NKJjIc+rOo7w9SQWZc5HrgapFHUjf7WNsH7migZ7SRZsAzC9z+95BNtJ6+WWRKEh7htPnGF0cP1c0VD22jjRJOpr8HUMZvDet0fa8yTnMvrZN7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625127; c=relaxed/simple;
	bh=NSajmNlIukvW/jt5wwdOefx+UiYpy8Q24FRHr+9uF8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NINEuimR7EN1xpOBOKEFsjx/Chj6JFdjTJVpf/BT4VN5OAk9h5SPViMlInyGqBSL8E7HoVAmMTeIR/LuzCbT45rNopefEw7zwl7ihIaSKsnIw+T2nj5HyWrlIVIMf/F9cEq89PtmzsKVMWKxcIBzF0W9kZ1Vqae52XDgYLCn+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QXn+kXR8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BB21F00A3D;
	Tue, 16 Jun 2026 15:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625125;
	bh=LYI1RWAX3TYGywvYd9uY2+Rp4ltaEqktm7m3iHI8As0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QXn+kXR8+PWx1UCRrzBos8enEsXlYZr2bMvEb3jirqjJ61P98j1GQmaT7dWuRutMl
	 kzYE/tLgBgxIdm5pf/TdRVRC1FHZjF4VnL7BMmNXe4Yy3Cn8m/Bx/zT2px0Z/G+yRj
	 bAADvJiHqDkfzVxkk0nrd/wq/599MmQ6JK9OZ0zo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 049/325] Bluetooth: ISO: Fix data-race on iso_pi fields in hci_get_route calls
Date: Tue, 16 Jun 2026 20:27:25 +0530
Message-ID: <20260616145100.165552872@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264279-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:suunj1331@gmail.com,m:luiz.von.dentz@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B00B691785

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeungJu Cheon <suunj1331@gmail.com>

[ Upstream commit 9ca7053d6215d89c33f28893bfd1625a32919d3f ]

iso_connect_bis(), iso_connect_cis(), iso_listen_bis(), and
iso_conn_big_sync() call hci_get_route() using iso_pi(sk)->dst,
iso_pi(sk)->src, and iso_pi(sk)->src_type without holding lock_sock().

These fields may be modified concurrently by connect() or setsockopt()
on the same socket, resulting in data-races reported by KCSAN.

Fix this by snapshotting the required fields under lock_sock() before
calling hci_get_route().

BUG: KCSAN: data-race in memcmp+0x45/0xb0

race at unknown origin, with read to 0xffff8880122135cf of 1 bytes
by task 333 on cpu 1:
 memcmp+0x45/0xb0
 hci_get_route+0x27e/0x490
 iso_connect_cis+0x4c/0xa10
 iso_sock_connect+0x60e/0xb30
 __sys_connect_file+0xbd/0xe0
 __sys_connect+0xe0/0x110
 __x64_sys_connect+0x40/0x50
 x64_sys_call+0xcad/0x1c60
 do_syscall_64+0x133/0x590
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 241f51931c35 ("Bluetooth: ISO: Avoid circular locking dependency")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/iso.c | 60 +++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 355487613c82a0..c1e3015a6630d5 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -336,12 +336,20 @@ static int iso_connect_bis(struct sock *sk)
 	struct iso_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev  *hdev;
+	bdaddr_t src, dst;
+	u8 src_type, bc_sid;
 	int err;
 
-	BT_DBG("%pMR (SID 0x%2.2x)", &iso_pi(sk)->src, iso_pi(sk)->bc_sid);
+	lock_sock(sk);
+	bacpy(&src, &iso_pi(sk)->src);
+	bacpy(&dst, &iso_pi(sk)->dst);
+	src_type = iso_pi(sk)->src_type;
+	bc_sid = iso_pi(sk)->bc_sid;
+	release_sock(sk);
 
-	hdev = hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
-			     iso_pi(sk)->src_type);
+	BT_DBG("%pMR (SID 0x%2.2x)", &src, bc_sid);
+
+	hdev = hci_get_route(&dst, &src, src_type);
 	if (!hdev)
 		return -EHOSTUNREACH;
 
@@ -433,12 +441,19 @@ static int iso_connect_cis(struct sock *sk)
 	struct iso_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev  *hdev;
+	bdaddr_t src, dst;
+	u8 src_type;
 	int err;
 
-	BT_DBG("%pMR -> %pMR", &iso_pi(sk)->src, &iso_pi(sk)->dst);
+	lock_sock(sk);
+	bacpy(&src, &iso_pi(sk)->src);
+	bacpy(&dst, &iso_pi(sk)->dst);
+	src_type = iso_pi(sk)->src_type;
+	release_sock(sk);
+
+	BT_DBG("%pMR -> %pMR", &src, &dst);
 
-	hdev = hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
-			     iso_pi(sk)->src_type);
+	hdev = hci_get_route(&dst, &src, src_type);
 	if (!hdev)
 		return -EHOSTUNREACH;
 
@@ -1138,18 +1153,25 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr *addr,
 
 static int iso_listen_bis(struct sock *sk)
 {
-	struct hci_dev *hdev;
-	int err = 0;
 	struct iso_conn *conn;
 	struct hci_conn *hcon;
+	struct hci_dev *hdev;
+	bdaddr_t src, dst;
+	u8 src_type, bc_sid;
+	int err = 0;
+
+	lock_sock(sk);
+	bacpy(&src, &iso_pi(sk)->src);
+	bacpy(&dst, &iso_pi(sk)->dst);
+	src_type = iso_pi(sk)->src_type;
+	bc_sid = iso_pi(sk)->bc_sid;
+	release_sock(sk);
 
-	BT_DBG("%pMR -> %pMR (SID 0x%2.2x)", &iso_pi(sk)->src,
-	       &iso_pi(sk)->dst, iso_pi(sk)->bc_sid);
+	BT_DBG("%pMR -> %pMR (SID 0x%2.2x)", &src, &dst, bc_sid);
 
 	write_lock(&iso_sk_list.lock);
 
-	if (__iso_get_sock_listen_by_sid(&iso_pi(sk)->src, &iso_pi(sk)->dst,
-					 iso_pi(sk)->bc_sid))
+	if (__iso_get_sock_listen_by_sid(&src, &dst, bc_sid))
 		err = -EADDRINUSE;
 
 	write_unlock(&iso_sk_list.lock);
@@ -1157,8 +1179,7 @@ static int iso_listen_bis(struct sock *sk)
 	if (err)
 		return err;
 
-	hdev = hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
-			     iso_pi(sk)->src_type);
+	hdev = hci_get_route(&dst, &src, src_type);
 	if (!hdev)
 		return -EHOSTUNREACH;
 
@@ -1494,9 +1515,16 @@ static void iso_conn_big_sync(struct sock *sk)
 {
 	int err;
 	struct hci_dev *hdev;
+	bdaddr_t src, dst;
+	u8 src_type;
+
+	lock_sock(sk);
+	bacpy(&src, &iso_pi(sk)->src);
+	bacpy(&dst, &iso_pi(sk)->dst);
+	src_type = iso_pi(sk)->src_type;
+	release_sock(sk);
 
-	hdev = hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
-			     iso_pi(sk)->src_type);
+	hdev = hci_get_route(&dst, &src, src_type);
 
 	if (!hdev)
 		return;
-- 
2.53.0




