Return-Path: <stable+bounces-236514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMKuJdQZ3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:29:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2266A3EF0E5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23B473028B1A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917872F8BC3;
	Mon, 13 Apr 2026 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="afVe+Htw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547E224DCF6;
	Mon, 13 Apr 2026 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097098; cv=none; b=Fs/DSB4CWIfQHYdwvQJE4zuFyKASTAMc6jmcqu/uA6JvgV1iiWA/g9+D6yJTTKtSGg6KhWPzF4JC4hXQorh9Vvv/zht6GJ6Qq+RE69qqhGwAV7YiqTSVtzdob2nTR1WcmQTckRNdKN03Aus3eHdyuhw8oXukHfaAmcHYlOPfpL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097098; c=relaxed/simple;
	bh=jASsFZjtrpIAkY6PpCzbMXhWN3my2D4iBNbQJqYKrfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVVD5k5aUlv4biTfpmIlOFQsN1vMRn1Ul3KKBwcnrcQg5o97g7NiAjhOP5ImBBdugeNa+1hH4YhYIIqg2ayJiEr3S6PItnGqV0GJGctBuIyn6bcFujPx3Im9c7Pl2hJLKUjyGQFV8Y1JZLERn6OtSaH1X/6IpZPmwZG8ZMZb+Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=afVe+Htw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB8BC2BCAF;
	Mon, 13 Apr 2026 16:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097098;
	bh=jASsFZjtrpIAkY6PpCzbMXhWN3my2D4iBNbQJqYKrfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=afVe+Htw7GWF4p7f4kzuR2MEqMLIZtXGU5yOOTXv5Ffyl76KsXbtA7uJqKwBmQcyp
	 I/4O0iA0W2NtDDaYJC2qcgC2P1AD8CjYWG1cOgVEet9jnCTIcbvzd0OeUbSgIpG89O
	 ZBsVQYAIgU6ua74GyZZKsdSHfxctHb4cLAFmoa9M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Anderson Nascimento <anderson@allelesecurity.com>,
	Luxiao Xu <rakukuip@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 54/55] rxrpc: Fix key/keyring checks in setsockopt(RXRPC_SECURITY_KEY/KEYRING)
Date: Mon, 13 Apr 2026 18:01:28 +0200
Message-ID: <20260413155726.848189961@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.820472494@linuxfoundation.org>
References: <20260413155724.820472494@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236514-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,auristor.com,allelesecurity.com,gmail.com,kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,allelesecurity.com:email]
X-Rspamd-Queue-Id: 2266A3EF0E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 2afd86ccbb2082a3c4258aea8c07e5bb6267bc2f upstream.

An AF_RXRPC socket can be both client and server at the same time.  When
sending new calls (ie. it's acting as a client), it uses rx->key to set the
security, and when accepting incoming calls (ie. it's acting as a server),
it uses rx->securities.

setsockopt(RXRPC_SECURITY_KEY) sets rx->key to point to an rxrpc-type key
and setsockopt(RXRPC_SECURITY_KEYRING) sets rx->securities to point to a
keyring of rxrpc_s-type keys.

Now, it should be possible to use both rx->key and rx->securities on the
same socket - but for userspace AF_RXRPC sockets rxrpc_setsockopt()
prevents that.

Fix this by:

 (1) Remove the incorrect check rxrpc_setsockopt(RXRPC_SECURITY_KEYRING)
     makes on rx->key.

 (2) Move the check that rxrpc_setsockopt(RXRPC_SECURITY_KEY) makes on
     rx->key down into rxrpc_request_key().

 (3) Remove rxrpc_request_key()'s check on rx->securities.

This (in combination with a previous patch) pushes the checks down into the
functions that set those pointers and removes the cross-checks that prevent
both key and keyring being set.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Closes: https://sashiko.dev/#/patchset/20260401105614.1696001-10-dhowells@redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Anderson Nascimento <anderson@allelesecurity.com>
cc: Luxiao Xu <rakukuip@gmail.com>
cc: Yuan Tan <yuantan098@gmail.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-16-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/af_rxrpc.c |    6 ------
 net/rxrpc/key.c      |    2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -615,9 +615,6 @@ static int rxrpc_setsockopt(struct socke
 			goto success;
 
 		case RXRPC_SECURITY_KEY:
-			ret = -EINVAL;
-			if (rx->key)
-				goto error;
 			ret = -EISCONN;
 			if (rx->sk.sk_state != RXRPC_UNBOUND)
 				goto error;
@@ -625,9 +622,6 @@ static int rxrpc_setsockopt(struct socke
 			goto error;
 
 		case RXRPC_SECURITY_KEYRING:
-			ret = -EINVAL;
-			if (rx->key)
-				goto error;
 			ret = -EISCONN;
 			if (rx->sk.sk_state != RXRPC_UNBOUND)
 				goto error;
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -452,7 +452,7 @@ int rxrpc_request_key(struct rxrpc_sock
 
 	_enter("");
 
-	if (optlen <= 0 || optlen > PAGE_SIZE - 1 || rx->securities)
+	if (optlen <= 0 || optlen > PAGE_SIZE - 1 || rx->key)
 		return -EINVAL;
 
 	description = memdup_sockptr_nul(optval, optlen);



