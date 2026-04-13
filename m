Return-Path: <stable+bounces-236228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HugOhUX3WmXZwkAu9opvQ
	(envelope-from <stable+bounces-236228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:17:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD2E3EE8ED
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19C0930BC4D7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0372F2727E2;
	Mon, 13 Apr 2026 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XILIetU2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B648E25DB12;
	Mon, 13 Apr 2026 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096372; cv=none; b=e0W1PiqA/VfUVvwSapnzx2dHjbDzN2KOKMGbZrZ+oFadD+5bKM/TX7imev6dSEeyD28Gv0pPcAJ0YfpxRoNSKJtyYejuydWxS/t7ejIHLzfUCzJQSyxCviCtOebNktRp2UQ3TGp6NXx2O4M876xOwgavV2hVd8GiviepJeF4ef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096372; c=relaxed/simple;
	bh=ks1Hb1jXrE6tuqdZtXgxmpOHxeNChQmd9NZuF1u6bIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uURBxGY9x3lmGtgkaTqoi0QdZFvDAc9ELrMNCZv8jhsK6D+aD8pV4oF4AwJaYEm7zpaCOcBTmV9hdbUHYVg727U3V27GjiXFuoDQ3AjlcNljvyOPN7P0Lx/mHSCdJtfQVfTwX+WOLaNpk1ihi2d2j3RP/oQpYVB4zYoxKOIkXWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XILIetU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18194C2BCB6;
	Mon, 13 Apr 2026 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096372;
	bh=ks1Hb1jXrE6tuqdZtXgxmpOHxeNChQmd9NZuF1u6bIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XILIetU2pJYTQb89CPMzMlnNavgTCHYXnBmg5+GMYqAGxF7iD35ADz3CfJZCKjWRJ
	 HOA0cDUVDKg2JODAf+OsgPbm5qPRufbV6gS9p1pswYqkGmcxmDETRiWBGdf0a20L9R
	 +BQSGqQO6EfzmYdh7NF5iE8D+qdlybWjirJddeLk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.19 65/86] rxrpc: Fix key quota calculation for multitoken keys
Date: Mon, 13 Apr 2026 18:00:12 +0200
Message-ID: <20260413155733.981560551@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
References: <20260413155731.568515178@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236228-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,auristor.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sashiko.dev:url,infradead.org:email]
X-Rspamd-Queue-Id: 6BD2E3EE8ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit bdbfead6d38979475df0c2f4bad2b19394fe9bdc upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/key.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -72,7 +72,7 @@ static int rxrpc_preparse_xdr_rxkad(stru
 		return -EKEYREJECTED;
 
 	plen = sizeof(*token) + sizeof(*token->kad) + tktlen;
-	prep->quotalen = datalen + plen;
+	prep->quotalen += datalen + plen;
 
 	plen -= sizeof(*token);
 	token = kzalloc(sizeof(*token), GFP_KERNEL);
@@ -199,7 +199,7 @@ static int rxrpc_preparse_xdr_yfs_rxgk(s
 	}
 
 	plen = sizeof(*token) + sizeof(*token->rxgk) + tktlen + keylen;
-	prep->quotalen = datalen + plen;
+	prep->quotalen += datalen + plen;
 
 	plen -= sizeof(*token);
 	token = kzalloc(sizeof(*token), GFP_KERNEL);
@@ -460,6 +460,7 @@ static int rxrpc_preparse(struct key_pre
 	memcpy(&kver, prep->data, sizeof(kver));
 	prep->data += sizeof(kver);
 	prep->datalen -= sizeof(kver);
+	prep->quotalen = 0;
 
 	_debug("KEY I/F VERSION: %u", kver);
 
@@ -497,7 +498,7 @@ static int rxrpc_preparse(struct key_pre
 		goto error;
 
 	plen = sizeof(*token->kad) + v1->ticket_length;
-	prep->quotalen = plen + sizeof(*token);
+	prep->quotalen += plen + sizeof(*token);
 
 	ret = -ENOMEM;
 	token = kzalloc(sizeof(*token), GFP_KERNEL);



