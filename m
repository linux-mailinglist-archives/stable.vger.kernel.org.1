Return-Path: <stable+bounces-237668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLukBd1r3WlNeAkAu9opvQ
	(envelope-from <stable+bounces-237668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:19:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9233F3BF5
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B7DD302AE21
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 22:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF7737CD3C;
	Mon, 13 Apr 2026 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkBQtCFr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FACC3603FC
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118743; cv=none; b=JwI+9L+DUFzckkgXJWbkk2sjC32dDx0cKxTExoAWQyJpGmcYmxbUYmKejqYrYK46bMSFZuGcSlhk5ngfq6up2gFXAGDjBwciLvhZ164FyRWIjIzMf2uskCrY5VFyU3P/+g4jy5N6cyvI+t26G85nTAeY3QG8POyoQW/UYpzBeJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118743; c=relaxed/simple;
	bh=hQ+9e9r12Nnfkh2D2znmJoSgBiw8/ohOw+QiE8NO9yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skXsIbZi/RcpOnYSLHe9/oR0jsApOlHJXfK6Nt4OJgN3HRRU4ILoE2e3CSZm/qK6ncuvbD8HNhO2ZEEmFNa56QTO6F2W2XvknyvaeNn+lXgD6ibD/T1L+dd8BoRzzzmSbAQ05J71iEmKqDUe6YMuDPzvEZoLxjUmt1OwayNobKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkBQtCFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CB0C2BCAF;
	Mon, 13 Apr 2026 22:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776118742;
	bh=hQ+9e9r12Nnfkh2D2znmJoSgBiw8/ohOw+QiE8NO9yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MkBQtCFr/cqmA8uitrNq8Nd4uL4+yNqHudvuM+/vAGi03jHDwxt+Q9gk0r+gDw8SV
	 wOUJS1GL52lHSU2ZQCcmxKCUitTzQj+yVMztqY+nrDAIjJGyyGliWSv3MfPFb5CMxN
	 wYhKCPFTh0mKYqMQtxIfqaXcydXlQ/N94gbAHQA6ssNKuYHCQ2MpzU/lMlKX7MPJv5
	 2suPu7nP3rG0L8bld6SGWISGiFcq6YthbNmypJ54Z5G1v1gOO34bv2TI31xJnHBJrU
	 b0U+qwMGO2FOfVtOYDJeiGKCT+vPtMJ+CiUZcMCW0ZtIWopsiFpxQK57KrcVq2yi8A
	 voT5Eq34S9e1A==
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
Subject: [PATCH 6.12.y] rxrpc: Fix key quota calculation for multitoken keys
Date: Mon, 13 Apr 2026 18:18:59 -0400
Message-ID: <20260413221859.3749467-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041335-acetone-cesspool-822e@gregkh>
References: <2026041335-acetone-cesspool-822e@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237668-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,msgid.link:url]
X-Rspamd-Queue-Id: 6C9233F3BF5
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
index 33e8302a79e33..215e661676381 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -72,7 +72,7 @@ static int rxrpc_preparse_xdr_rxkad(struct key_preparsed_payload *prep,
 		return -EKEYREJECTED;
 
 	plen = sizeof(*token) + sizeof(*token->kad) + tktlen;
-	prep->quotalen = datalen + plen;
+	prep->quotalen += datalen + plen;
 
 	plen -= sizeof(*token);
 	token = kzalloc(sizeof(*token), GFP_KERNEL);
@@ -303,6 +303,7 @@ static int rxrpc_preparse(struct key_preparsed_payload *prep)
 	memcpy(&kver, prep->data, sizeof(kver));
 	prep->data += sizeof(kver);
 	prep->datalen -= sizeof(kver);
+	prep->quotalen = 0;
 
 	_debug("KEY I/F VERSION: %u", kver);
 
@@ -340,7 +341,7 @@ static int rxrpc_preparse(struct key_preparsed_payload *prep)
 		goto error;
 
 	plen = sizeof(*token->kad) + v1->ticket_length;
-	prep->quotalen = plen + sizeof(*token);
+	prep->quotalen += plen + sizeof(*token);
 
 	ret = -ENOMEM;
 	token = kzalloc(sizeof(*token), GFP_KERNEL);
-- 
2.53.0


