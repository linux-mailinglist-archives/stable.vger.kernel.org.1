Return-Path: <stable+bounces-240862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAqhONt062kQNAAAu9opvQ
	(envelope-from <stable+bounces-240862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:49:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7284445FB35
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7F61303DD40
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC913D5236;
	Fri, 24 Apr 2026 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oT578Oxd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125419A288;
	Fri, 24 Apr 2026 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038032; cv=none; b=lbKho3POCUt3bOLL3OAK4zZf0Pb6jY1+AkEG233Wgv32FZaXSxs4uqUhMJwlyCms/HUcRFb34Yi4Dpl6NNBK+izigbIEMMn/BvI59a8eClohZoUzRKXeAU2t9VS27txv+eshscDkR5/1Kux4cUoGIWDr2rNkP4FYqGghRr/NS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038032; c=relaxed/simple;
	bh=YBhw0Xu6MQED94xu0Ejsc1Q6KpfE+ZrQf1ZUPSkJzo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YV6yr3t+pyUavvQV7K/4jNWMPFFBJyZmQ2MXBRksdf26v68HayOmzw/tV3gNh7DXKnbWbg76vMZKJezt0nt7Ly+nTKmex7sqdhylTex3bWkX7LmA7W2hHmTMOxTeILgx29bA+dEVPmUGSRAylbLjzTk3i43RGI7zn+aM6awtvj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oT578Oxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE84C19425;
	Fri, 24 Apr 2026 13:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777038032;
	bh=YBhw0Xu6MQED94xu0Ejsc1Q6KpfE+ZrQf1ZUPSkJzo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oT578OxdQ+x2846RitZCYCTbTo2T6M/N7z1h9AdrjpFXaUJbVD8cl7Ys8bVR3/wpq
	 aHdCdTR+zXOzpv674M/FByzv382SNLnY8mP6wrcXdUkySoBfgE6HbcqZrjYPUTA3+/
	 1H5mM7AWk9B86vIVStUj4ZxTz/BWtfEzSNYvDYXQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anderson Nascimento <anderson@allelesecurity.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 165/166] rxrpc: Fix missing validation of ticket length in non-XDR key preparsing
Date: Fri, 24 Apr 2026 15:31:19 +0200
Message-ID: <20260424132607.605269735@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 7284445FB35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240862-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[allelesecurity.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,infradead.org:email,auristor.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anderson Nascimento <anderson@allelesecurity.com>

commit ac33733b10b484d666f97688561670afd5861383 upstream.

In rxrpc_preparse(), there are two paths for parsing key payloads: the
XDR path (for large payloads) and the non-XDR path (for payloads <= 28
bytes). While the XDR path (rxrpc_preparse_xdr_rxkad()) correctly
validates the ticket length against AFSTOKEN_RK_TIX_MAX, the non-XDR
path fails to do so.

This allows an unprivileged user to provide a very large ticket length.
When this key is later read via rxrpc_read(), the total
token size (toksize) calculation results in a value that exceeds
AFSTOKEN_LENGTH_MAX, triggering a WARN_ON().

[ 2001.302904] WARNING: CPU: 2 PID: 2108 at net/rxrpc/key.c:778 rxrpc_read+0x109/0x5c0 [rxrpc]

Fix this by adding a check in the non-XDR parsing path of rxrpc_preparse()
to ensure the ticket length does not exceed AFSTOKEN_RK_TIX_MAX,
bringing it into parity with the XDR parsing logic.

Fixes: 8a7a3eb4ddbe ("KEYS: RxRPC: Use key preparsing")
Fixes: 84924aac08a4 ("rxrpc: Fix checker warning")
Reported-by: Anderson Nascimento <anderson@allelesecurity.com>
Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260422161438.2593376-7-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/key.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -340,6 +340,10 @@ static int rxrpc_preparse(struct key_pre
 	if (v1->security_index != RXRPC_SECURITY_RXKAD)
 		goto error;
 
+	ret = -EKEYREJECTED;
+	if (v1->ticket_length > AFSTOKEN_RK_TIX_MAX)
+		goto error;
+
 	plen = sizeof(*token->kad) + v1->ticket_length;
 	prep->quotalen += plen + sizeof(*token);
 



