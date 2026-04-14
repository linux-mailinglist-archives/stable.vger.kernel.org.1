Return-Path: <stable+bounces-237688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCmPNgWM3Wn5fQkAu9opvQ
	(envelope-from <stable+bounces-237688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 02:36:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4294F3F4917
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 02:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F11830EC4ED
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213EF256C61;
	Tue, 14 Apr 2026 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upKsnv6a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A9C224AF1
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126590; cv=none; b=g86BeqQJwKsL2tSqGAZ476ybyrVIPjtML3Ok+hYlagy73Atigk399eMkVniOwiQdST9i5bZau6Uq3wde2TMR+McrAmy1MgSKOv8p+cz696Faq6On+kSwvCY+aW0bWqBgGtgxpPp8zYiBxJHwpIRqD5p9AQm+zkqZNodnNsBYplo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126590; c=relaxed/simple;
	bh=i3IvQ5y1Zc2KQc4bJ28xi7r0nHVoKCh0w5KVhEXUom4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2qw5zbUEz2ZaB7sMgEyT8ZexjUeJPqyNTgwIkj7REeeyYUPTgNfEE5DdFIRoRQUapRqJKTYMQTF2yG+jZwExGSx/0PmxT9bZL1sSktglSDzNM8awd49Oh0nePDVVazNQLpvJWVSmIon9k/+e7WneJVoZO2BLk+eKl0QzgSubxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upKsnv6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26DDC2BCAF;
	Tue, 14 Apr 2026 00:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126590;
	bh=i3IvQ5y1Zc2KQc4bJ28xi7r0nHVoKCh0w5KVhEXUom4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=upKsnv6a3myqmZTeFXhgLJ4gVDxNkgg67eoi62dP6ga90stZISreEaQMh7/6OlCTX
	 bMzApLDWyiyfbsfgtL0WB5mGEIw/Hy+IBqgsJ5d6ZKFz13kMd2AwgWKbR87GFIlXKj
	 WRtPejUWjVD0l7E3IdJFo4OETp/I9basix5tOUO+RsOOnIZsI6UXDvUFZRXz/GJlBw
	 QP2916Nx2V6elXSjO4ukBsfxWx46TlHkXp6T5qk6DhCyzuHlBdJ+ekFjUVzZLwKbsk
	 PxnhT4NFaBaRF2XUbsaX+X7mDYewWMrJOO2L5bjmz9TTKKX4FqAukFUiZfdS4NE+Z4
	 d3eLNUnYj4DLA==
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
Subject: [PATCH 5.10.y] rxrpc: Fix key quota calculation for multitoken keys
Date: Mon, 13 Apr 2026 20:29:48 -0400
Message-ID: <20260414002948.3802454-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041337-chummy-habitual-b416@gregkh>
References: <2026041337-chummy-habitual-b416@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237688-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sashiko.dev:url,auristor.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 4294F3F4917
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Howells <dhowells@redhat.com>

[ Upstream commit bdbfead6d38979475df0c2f4bad2b19394fe9bdc ]

In the rxrpc key preparsing, every token extracted sets the proposed quota
value, but for multitoken keys, this will overwrite the previous proposed
quota, losing it.

Fix this by adding to the proposed quota instead.

Fixes: 8a7a3eb4ddbe ("KEYS: RxRPC: Use key preparsing")
Closes: https://sashiko.dev/#/patchset/20260319150150.4189381-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-2-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ dropped hunk for rxrpc_preparse_xdr_yfs_rxgk() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/key.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index 979338a64c0ca..024dc28b61666 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -108,7 +108,7 @@ static int rxrpc_preparse_xdr_rxkad(struct key_preparsed_payload *prep,
 		return -EKEYREJECTED;
 
 	plen = sizeof(*token) + sizeof(*token->kad) + tktlen;
-	prep->quotalen = datalen + plen;
+	prep->quotalen += datalen + plen;
 
 	plen -= sizeof(*token);
 	token = kzalloc(sizeof(*token), GFP_KERNEL);
@@ -718,6 +718,7 @@ static int rxrpc_preparse(struct key_preparsed_payload *prep)
 	memcpy(&kver, prep->data, sizeof(kver));
 	prep->data += sizeof(kver);
 	prep->datalen -= sizeof(kver);
+	prep->quotalen = 0;
 
 	_debug("KEY I/F VERSION: %u", kver);
 
@@ -755,7 +756,7 @@ static int rxrpc_preparse(struct key_preparsed_payload *prep)
 		goto error;
 
 	plen = sizeof(*token->kad) + v1->ticket_length;
-	prep->quotalen = plen + sizeof(*token);
+	prep->quotalen += plen + sizeof(*token);
 
 	ret = -ENOMEM;
 	token = kzalloc(sizeof(*token), GFP_KERNEL);
-- 
2.53.0


