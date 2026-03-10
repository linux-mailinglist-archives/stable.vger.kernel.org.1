Return-Path: <stable+bounces-224074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBrqKfL8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6903D24A2AE
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AD2D3037273
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC70387589;
	Tue, 10 Mar 2026 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5Y7eGGz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5B38737C;
	Tue, 10 Mar 2026 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141208; cv=none; b=NWhwhsQ1FL7T2eZPNfOHtaCbr3XYAn4XMeUL6HGqCkBtwa3KioxgG8iopsAhnMNN6yuOKjkK2AesuoUg7f7kGqtCAUU52BipSvpQYDpnIS3kZeHeR0T5L0b3R+jU4GwpSxl3nCWm+R0AtnicHdtBdFamy5YbbQrCzCqQ65a3XVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141208; c=relaxed/simple;
	bh=AFESsPnfM+yWIReH2bQKE95p0RqShnKooOtQ0dts/mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdTMkYuxZL7IONJijchPGNnPKa7pSwLZHwCyoYo2l1+kCPrTdo4PhEo+pcKuvkaYN9u3mo0s7Jz95ag/IX0iMSM6krwYWsWWzA2t4rl0xVMqz+E+1D0QCFx2MCWiUVhI0QB5GwMF5QYT1nBRt8WFnu3gVJSNBcBRcn7Ji7ytaMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5Y7eGGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048EEC2BC9E;
	Tue, 10 Mar 2026 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141208;
	bh=AFESsPnfM+yWIReH2bQKE95p0RqShnKooOtQ0dts/mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5Y7eGGzp33V5dgAlctaDaqs7pvMO/niQxLM/24Qho61fAsxJ7SZ4yH5KwaEVQQaN
	 uv8O7w0MPyyTFlxAAbVpdW5JyB2jT8nrecRY88P6DaZMDIRo8VVyNIx/MJD2t0aWh/
	 jTqW3aL7yItVfTs57rF17BB0fy+weKPehgJbdo8Ag3wim142MNs1l0NZz2EISJ4CM2
	 W5wFnLcn4/dWQ4B5EIsMttCav4UjzeTTW5rUIfvpku/vtMhbljhxIRQV5a+kWewq/D
	 zD9qFJgLJmWi4uMaHLFhSfQjdnK4iXh8QDBDRwyaWAiMTOWZNuRxkHXWFle7ML2H7/
	 RDIh9i2fQ5KmQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 209/311] udp: Unhash auto-bound connected sk from 4-tuple hash table when disconnected.
Date: Tue, 10 Mar 2026 07:04:16 -0400
Message-ID: <a2ef001b2b2a6e7c321f9e272b537df397f20b60.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6903D24A2AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224074-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 6996a2d2d0a64808c19c98002aeb5d9d1b2df6a4 ]

Let's say we bind() an UDP socket to the wildcard address with a
non-zero port, connect() it to an address, and disconnect it from
the address.

bind() sets SOCK_BINDPORT_LOCK on sk->sk_userlocks (but not
SOCK_BINDADDR_LOCK), and connect() calls udp_lib_hash4() to put
the socket into the 4-tuple hash table.

Then, __udp_disconnect() calls sk->sk_prot->rehash(sk).

It computes a new hash based on the wildcard address and moves
the socket to a new slot in the 4-tuple hash table, leaving a
garbage in the chain that no packet hits.

Let's remove such a socket from 4-tuple hash table when disconnected.

Note that udp_sk(sk)->udp_portaddr_hash needs to be udpated after
udp_hash4_dec(hslot2) in udp_unhash4().

Fixes: 78c91ae2c6de ("ipv4/udp: Add 4-tuple hash for connected socket")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260227035547.3321327-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 37258b54a357e..fbdbb65676e0d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2268,7 +2268,6 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 				     udp_sk(sk)->udp_port_hash);
 		hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
 		nhslot2 = udp_hashslot2(udptable, newhash);
-		udp_sk(sk)->udp_portaddr_hash = newhash;
 
 		if (hslot2 != nhslot2 ||
 		    rcu_access_pointer(sk->sk_reuseport_cb)) {
@@ -2302,19 +2301,25 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 		if (udp_hashed4(sk)) {
 			spin_lock_bh(&hslot->lock);
 
-			udp_rehash4(udptable, sk, newhash4);
-			if (hslot2 != nhslot2) {
-				spin_lock(&hslot2->lock);
-				udp_hash4_dec(hslot2);
-				spin_unlock(&hslot2->lock);
-
-				spin_lock(&nhslot2->lock);
-				udp_hash4_inc(nhslot2);
-				spin_unlock(&nhslot2->lock);
+			if (inet_rcv_saddr_any(sk)) {
+				udp_unhash4(udptable, sk);
+			} else {
+				udp_rehash4(udptable, sk, newhash4);
+				if (hslot2 != nhslot2) {
+					spin_lock(&hslot2->lock);
+					udp_hash4_dec(hslot2);
+					spin_unlock(&hslot2->lock);
+
+					spin_lock(&nhslot2->lock);
+					udp_hash4_inc(nhslot2);
+					spin_unlock(&nhslot2->lock);
+				}
 			}
 
 			spin_unlock_bh(&hslot->lock);
 		}
+
+		udp_sk(sk)->udp_portaddr_hash = newhash;
 	}
 }
 EXPORT_IPV6_MOD(udp_lib_rehash);
-- 
2.51.0


