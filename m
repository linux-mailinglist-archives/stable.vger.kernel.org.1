Return-Path: <stable+bounces-233696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBEeOoY81WlY3AcAu9opvQ
	(envelope-from <stable+bounces-233696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:19:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B173B246C
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AEB73015C9D
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 17:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FE233970F;
	Tue,  7 Apr 2026 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DdJZOZLR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aoAPW8TN"
X-Original-To: stable@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D4282F3C;
	Tue,  7 Apr 2026 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582215; cv=none; b=jeIp5Q6ofm2WHegAnTNoY2Web8q91qEAkm4Z9KowBc2+h96qJzrSGKnPDRylk7FmqR5WclBuu5NwNzuqhlntJOrggBvRstAUMGpmtKpvJH1WEthfmyKfV+Dp3sXiDiYCnm3bCiuoR0D8VAh+/7Io8fBIeTS6U+xPMw9zj0iSfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582215; c=relaxed/simple;
	bh=lNbAbHwxHKZFHHrzTeI0AeLDz4Y8BZYZmp3wCUkMGII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPUZk/9jgYrs0KGvetefEjuiG+ECkFy+RMlGl2y3ULkwlzevIQc0BehH3Aq0XwjivHWaDgMcgIV9kqetZp1f1exUpS8sjyRrmrh6J7DESPwCjR7c7pWueDkJ34J3TumHva5c/XkjIVqj3nUkHzXIiGsaOG52NqV4VFbjVXjRgDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DdJZOZLR; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aoAPW8TN; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4fqtCd3sN0z9yfX;
	Tue,  7 Apr 2026 19:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775582205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0fYS6IEnQ+3QYHVXEGJ74yFJNn8NjKjbrhRrRsTc6c8=;
	b=DdJZOZLRoGpnR3XJjtT46qvHNiI+NnaH9vAf0v7k/9qq4CIWPzWMp4zHLvODPXD/JbttAn
	3NpXbezOVcCaoqUbNGbzLhhVKd+wjbGdMt2qmOKf9SK30GcfHyFCNKk60hhaykRILJk1f8
	cqXDNY74R3sAaL9rPRX+68LbvS4UoaAQo0yiGv8GOo+gQWQ8SxCl10aaA5Ld5Us3kBRr1b
	aOZxhWjM6aFWcL1BZsjPGRFIgSFB3/IJaP0tjnI6hsr0abl7EpCDRhcFfoa2cHCusHxN+f
	9TL591KgKGNgR0vd/Wf9j7DJGpGba0OOZGX1wy/3/iiB5vzT26pw4iGrFIXr/A==
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775582203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0fYS6IEnQ+3QYHVXEGJ74yFJNn8NjKjbrhRrRsTc6c8=;
	b=aoAPW8TNEbSIOUcedqMV4bgL0T+tfpBed/slHMOCUPfnbQWQZfVKee0NeaGQ+z4fzfEEPH
	uMgGN4aY9INqa2zfVUzKg1yXDJYVuSDOxGM7coltljedPHyw4ObdPOjdGMw5eUIkqugf5d
	shkCGZirQ8o2PP70l3/I+Q7FRkQs1uty8fjSedAQRVlEH9uO3nstzQUNNRQHbUllYikuIe
	Gsh6QZgeeKan1NvNLM3k580fPkTYnMOiUfbtjutpbGwCIeoLWvunQL04XuDiREUXOIB/HL
	Bb/euXMvHR0beL7YLzSYB68LSbkES7V3tYnnBsgj3egFynwh7xLJI0Z9zOH06g==
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	gregkh@linuxfoundation.org,
	ben@decadent.org.uk,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH 2/3] net: netrom: validate source address in nr_find_socket()
Date: Wed,  8 Apr 2026 01:15:59 +0800
Message-ID: <20260407171600.102988-3-mashiro.chen@mailbox.org>
In-Reply-To: <20260407171600.102988-1-mashiro.chen@mailbox.org>
References: <20260407171600.102988-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5eqrh6rnt6ixrryjpyx4pdcrpgb1utua
X-MBO-RS-ID: 9fb3265130a864cf652
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233696-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53B173B246C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nr_find_socket() dispatches incoming NR_INFO frames into a connected
socket by matching the frame's circuit index/id pair (bytes[15-16])
against the socket's my_index/my_id.  It performs no validation of
the frame's source callsign against the socket's dest_addr.

This means any node on the network can craft an NR_INFO frame with
a guessed or brute-forced circuit index/id pair and have it accepted
into an arbitrary STATE_3 connection as if it came from the legitimate
peer.  Circuit IDs are assigned sequentially starting at (1,1), making
them predictable in practice.

This is exploited in concert with CVE-XXXX-XXXXX (nr_queue_rx_frame
fraglen overflow): an attacker can inject NR_INFO | NR_MORE_FLAG frames
into an existing connection without owning a connection themselves,
driving the victim socket's fraglen to wrap and triggering the heap
overflow entirely unauthenticated (CVSS PR:N).

Fix by adding a source address parameter to nr_find_socket() and
requiring it to match the socket's recorded dest_addr for all
frame-dispatch lookups.  The internal nr_find_next_circuit() caller,
which only checks for circuit ID availability, passes NULL to skip
the source check.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 net/netrom/af_netrom.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index b605891bf86e4..73742cc9e9e42 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -162,7 +162,8 @@ static struct sock *nr_find_listener(ax25_address *addr)
 /*
  *	Find a connected NET/ROM socket given my circuit IDs.
  */
-static struct sock *nr_find_socket(unsigned char index, unsigned char id)
+static struct sock *nr_find_socket(unsigned char index, unsigned char id,
+				   const ax25_address *src)
 {
 	struct sock *s;
 
@@ -170,7 +171,8 @@ static struct sock *nr_find_socket(unsigned char index, unsigned char id)
 	sk_for_each(s, &nr_list) {
 		struct nr_sock *nr = nr_sk(s);
 
-		if (nr->my_index == index && nr->my_id == id) {
+		if (nr->my_index == index && nr->my_id == id &&
+		    (!src || !ax25cmp(&nr->dest_addr, src))) {
 			sock_hold(s);
 			goto found;
 		}
@@ -219,7 +221,8 @@ static unsigned short nr_find_next_circuit(void)
 		j = id % 256;
 
 		if (i != 0 && j != 0) {
-			if ((sk=nr_find_socket(i, j)) == NULL)
+			sk = nr_find_socket(i, j, NULL);
+			if (!sk)
 				break;
 			sock_put(sk);
 		}
@@ -926,7 +929,7 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 		if (frametype == NR_CONNREQ)
 			sk = nr_find_peer(circuit_index, circuit_id, src);
 		else
-			sk = nr_find_socket(circuit_index, circuit_id);
+			sk = nr_find_socket(circuit_index, circuit_id, src);
 	}
 
 	if (sk != NULL) {
-- 
2.53.0


