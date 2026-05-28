Return-Path: <stable+bounces-255341-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPWHEjGhGGqnlggAu9opvQ
	(envelope-from <stable+bounces-255341-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:10:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B664F5F7F97
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5E9F3155685
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD17D2F691F;
	Thu, 28 May 2026 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f0f46G4d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20324677F;
	Thu, 28 May 2026 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998638; cv=none; b=XgYuUmfv2aSMyHniGr1rFKaZZFR5eBk3bJdROVrXl2bfayUvuAx1vDt/kPiw6jlrf0Vyu7UXe78M2yVcUbS2U1tEiimquoo/GE4gsU/8tyo+Qgi7FsYvDvWazvxFD8SMGAVXeWR/OEP/TTEIrgoBLDrGT7ATZQwCiqmpZyeq8Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998638; c=relaxed/simple;
	bh=/6wJ8jSJbX9ZWMIL5vPuHagKVimGTdh2LgsJWsdkDf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUT9FbykTZRU7ce+ndSpZlzkeXdOOHVYwiilbXdNCgILF2QUAiaEGibFWsKpezfIUVM5k4A3hJ2/fe5pZAncGwRGVtkjREtPw6N6Jp54LGmJ8DLE3M+9I3sgJ0jJ/RESOCIZaWby25ktoxWHef5pbVkfOjUoIB+XzeiAdLR2aAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f0f46G4d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85D51F000E9;
	Thu, 28 May 2026 20:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998637;
	bh=pdUmSY8ylrGkuH2LUsfkh95RWr6YdxOm8n99W58tjU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f0f46G4db+ubyfNbHPP3VT0XyrbJ0xrX5qSegmmmiuIjVl4LvYxxC8ONzFesOJI27
	 MVS7JtKVEGAOOhaJyHYG39mAqPvq0Nu1lmPv0bCXj5LFNROglydd/sRRr079b1pdV+
	 If2Jpfk+qHNC5RkgFIT3Mx+lwWjT0mjMuhoMQI08=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damiano Melotti <melotti@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 245/461] tcp: Fix out-of-bounds access for twsk in tcp_ao_established_key().
Date: Thu, 28 May 2026 21:46:14 +0200
Message-ID: <20260528194654.238375768@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255341-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: B664F5F7F97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 03cb001ef87b3f8d859cf7f96329acf3d6235d29 ]

lockdep_sock_is_held() was added in tcp_ao_established_key()
by the cited commit.

It can be called from tcp_v[46]_timewait_ack() with twsk.

Since it does not have sk->sk_lock, the lockdep annotation
results in out-of-bound access.

  $ pahole -C tcp_timewait_sock vmlinux | grep size
  	/* size: 288, cachelines: 5, members: 8 */
  $ pahole -C sock vmlinux | grep sk_lock
  	socket_lock_t              sk_lock;              /*   440   192 */

Let's not use lockdep_sock_is_held() for TCP_TIME_WAIT.

Fixes: 6b2d11e2d8fc ("net/tcp: Add missing lockdep annotations for TCP-AO hlist traversals")
Reported-by: Damiano Melotti <melotti@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260508120853.4098365-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_ao.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index a97cdf3e6af4c..0a4b38b315fed 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -116,7 +116,8 @@ struct tcp_ao_key *tcp_ao_established_key(const struct sock *sk,
 {
 	struct tcp_ao_key *key;
 
-	hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_held(sk)) {
+	hlist_for_each_entry_rcu(key, &ao->head, node,
+				 sk_fullsock(sk) && lockdep_sock_is_held(sk)) {
 		if ((sndid >= 0 && key->sndid != sndid) ||
 		    (rcvid >= 0 && key->rcvid != rcvid))
 			continue;
-- 
2.53.0




