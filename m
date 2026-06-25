Return-Path: <stable+bounces-268649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oP83Hc9xPWrh3AgAu9opvQ
	(envelope-from <stable+bounces-268649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 20:22:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F38986C8294
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 20:22:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Gw00Nwie;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268649-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268649-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EE99301FF1E
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 18:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F181031E84B;
	Thu, 25 Jun 2026 18:22:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7CD1A9F87;
	Thu, 25 Jun 2026 18:22:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411723; cv=none; b=JvvYgKGqQDCvFu5FP5xj9mS8G6DKkGRzsyBN2Fg0zF0MgCRPwITck4/ibFeNu/H4BSyKEPJmoVaZ9YtqLcETY8/SnfBn4mK4MDEOeVKrGx186iomk81bbQWryKIZXWvTUMJ+2bIHsv6PWI3iGg+ZTPK8kzKc80F36GmJK+APZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411723; c=relaxed/simple;
	bh=4kcohas5CotEUtuW1XN3cQnyi/ZXv7ymOPLjK33VnLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A5FQnE38fELWzDzFWpQcsUKgPRVi1RHkZOleVmLm2eN44HZ5hya0n2wC+H4goHoWKmLdwNz5roB7sknP2CTNtjP1i7MRz5MnY81+ceMB6/wPt2zK8A9/YfvYxRjGnLIt80FlzyjylZutQuvAW109n67vek0+SsQupo3+brRKDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw00Nwie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7ED38C2BCF5;
	Thu, 25 Jun 2026 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782411723;
	bh=4kcohas5CotEUtuW1XN3cQnyi/ZXv7ymOPLjK33VnLk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Gw00NwiePhxGqj93/zs7gmQ7fUk5KDFgNn6JmCojEw7JsbzPhdWwvgUDp418UyoG4
	 wdI6qO8BAUooBerF7oh8IFZ4Y3VCB7xzUINeett+wWy/rLY8Kepc5HQFA08A9qV4G7
	 ldATv5EIbU7lzucvwPChXn97ponDYLPC4LUk/R4rEHu3rstxzX2B1rtsHrzTMJFtbW
	 H+/O1ckHeKTjMkkdxA0iKbAYf3IC0R7dyAnPW6zw0dbAiJDZR5Y6VJwz0Zm7P/tSMY
	 eKke1mXr+AEWSTWTSFCItR9AGM2RtS0ft3jd7KFlhumiQxlpiQCyFy2tU3NvhxhcIs
	 Vfn5FXEZxjFXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BBCCDE000;
	Thu, 25 Jun 2026 18:22:03 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Thu, 25 Jun 2026 19:21:41 +0100
Subject: [PATCH net v3 3/3] tcp: Decrement tcp_md5_needed static branch
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-tcp-md5-connect-v3-3-1fd313d6c1e0@gmail.com>
References: <20260625-tcp-md5-connect-v3-0-1fd313d6c1e0@gmail.com>
In-Reply-To: <20260625-tcp-md5-connect-v3-0-1fd313d6c1e0@gmail.com>
To: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Salam Noureddine <noureddine@arista.com>
Cc: Michael Bommarito <michael.bommarito@gmail.com>, 
 Qihang <q.h.hack.winter@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782411722; l=1079;
 i=0x7f454c46@gmail.com; s=20260625; h=from:subject:message-id;
 bh=3nejDl07SxPQHPLWOUILyQffd40iVMwRdwvbto6+Q+g=;
 b=1z/VwT3MAPmFWz84HE6RimvnKtCVahxfjaRzbgTMqNxF5IGu7IsK/61L8Hc2WaP41sdb9eXS3
 WjExpgfhfjkAhtHHXccinyLQdcJpeswDO1XIjDX07Uss+c3E7Lb+yX0
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=clHVGbfKfZMeCUp+xCL/096jI68XK5EZLytgy6lSyrc=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20260625 with
 auth_id=841
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268649-lists,stable=lfdr.de,0x7f454c46.gmail.com];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:noureddine@arista.com,m:michael.bommarito@gmail.com,m:q.h.hack.winter@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:0x7f454c46@gmail.com,m:stable@vger.kernel.org,m:michaelbommarito@gmail.com,m:qhhackwinter@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[0x7f454c46@gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F38986C8294

From: Dmitry Safonov <0x7f454c46@gmail.com>

In case of early freeing an unwanted TCP-MD5 key on TCP-AO connect(),
md5sig_info is freed right away (and set to NULL). Later, at
the moment of socket destruction, the static branch counter
is not getting decremented.

Add a missing decrement for TCP-MD5 static branch.

Reported-by: Qihang <q.h.hack.winter@gmail.com>
Fixes: 0aadc73995d0 ("net/tcp: Prevent TCP-MD5 with TCP-AO being set")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 net/ipv4/tcp_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bc03809ca3af..d7c1444b5e30 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4334,8 +4334,8 @@ int tcp_connect(struct sock *sk)
 			tcp_clear_md5_list(sk);
 			md5sig = rcu_replace_pointer(tp->md5sig_info, NULL,
 						     lockdep_sock_is_held(sk));
-			if (md5sig)
-				kfree_rcu(md5sig, rcu);
+			kfree_rcu(md5sig, rcu);
+			static_branch_slow_dec_deferred(&tcp_md5_needed);
 		}
 	}
 #endif

-- 
2.51.2



