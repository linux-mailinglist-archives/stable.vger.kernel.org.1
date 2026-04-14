Return-Path: <stable+bounces-237685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF/3IbqH3WkgfQkAu9opvQ
	(envelope-from <stable+bounces-237685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 02:18:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EC83F4649
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 02:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6060B303FA95
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7CE175A6E;
	Tue, 14 Apr 2026 00:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1ViPXz+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EBDBA3D
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 00:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776125879; cv=none; b=OckUPvDoYGzQMCw+5mGrfUMDOaut9UnHnUCKJOSPVkQ7DpMCkfFc//yskRBKeObOOhZWWvln0wDutTLYrLm4QU/Ul2bme2oh7R9npGUqcPmhKP97VtB6nDV2mhAMbTCzja05EbqANnaZwolfb39xd7iMEjg4Yyx+8oQCXfDX1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776125879; c=relaxed/simple;
	bh=DTZUksY6EEFKZLKBt4Suu+f+ObaONVJ8HmiI+1SUrpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALNRplc4H6z9cNQ5qS80ikno0ZKV5mPV1mIAa2QEogV6XJ8mqKXw/JPSaC+pMJTE7x4gDZa1KKm1YZGX1rLCTbBr5Uc+rQM6gubd1xMt09BQyzLk8dyrx6pKUmvsLUqcgq9iy4sxpRhMtxdi52XSsAYSSc6wLDVo+i0yk4NbR1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1ViPXz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B068C2BCAF;
	Tue, 14 Apr 2026 00:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776125879;
	bh=DTZUksY6EEFKZLKBt4Suu+f+ObaONVJ8HmiI+1SUrpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1ViPXz+/wCfOoK8SY6zsOYzTJ/P9FSfm0xDhOey+csTlQWO/PRsNxZwmcn5cQtpo
	 1CgZcwAvpVR9lK8lA5a64080KaS6/rzmPP9O5NXZMf/79SFIQIzewbYNqkbMNTKIBc
	 PBRUobZdIK8gBeqShQfU9XuGsdIRAXlxlUlrav3xe791zd31VA0+MMFIzJ9IC8ai25
	 a0gkT9ILDwHxkoJP0Q5mvi9dyk+7Ae0pAKCOUyBNeBz3WSm/MkgJatt15l3bYXzNjg
	 V+a609UQCG4oaSGteX+/lveyjQXNdMjOQI3XDMXKFXsgL4ud+BZwdzS3jJcdJXmq6c
	 cgzFPar6jnVOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] rxrpc: Fix anonymous key handling
Date: Mon, 13 Apr 2026 20:17:56 -0400
Message-ID: <20260414001756.3797211-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041310-fox-finished-849e@gregkh>
References: <2026041310-fox-finished-849e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237685-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,infradead.org:email,auristor.com:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 13EC83F4649
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Howells <dhowells@redhat.com>

[ Upstream commit 6a59d84b4fc2f27f7b40e348506cc686712e260b ]

In rxrpc_new_client_call_for_sendmsg(), a key with no payload is meant to
be substituted for a NULL key pointer, but the variable this is done with
is subsequently not used.

Fix this by using "key" rather than "rx->key" when filling in the
connection parameters.

Note that this only affects direct use of AF_RXRPC; the kAFS filesystem
doesn't use sendmsg() directly and so bypasses the issue.  Further,
AF_RXRPC passes a NULL key in if no key is set, so using an anonymous key
in that manner works.  Since this hasn't been noticed to this point, it
might be better just to remove the "key" variable and the code that sets it
- and, arguably, rxrpc_init_client_call_security() would be a better place
to handle it.

Fixes: 19ffa01c9c45 ("rxrpc: Use structs to hold connection params and protocol info")
Closes: https://sashiko.dev/#/patchset/20260319150150.4189381-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-4-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/sendmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index b9f2f12281b33..6939617afc7bc 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -590,7 +590,7 @@ rxrpc_new_client_call_for_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg,
 
 	memset(&cp, 0, sizeof(cp));
 	cp.local		= rx->local;
-	cp.key			= rx->key;
+	cp.key			= key;
 	cp.security_level	= rx->min_sec_level;
 	cp.exclusive		= rx->exclusive | p->exclusive;
 	cp.upgrade		= p->upgrade;
-- 
2.53.0


