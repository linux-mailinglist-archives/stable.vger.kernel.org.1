Return-Path: <stable+bounces-256369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKZiF2usGGphmAgAu9opvQ
	(envelope-from <stable+bounces-256369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:58:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E24BE5F9F1F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8FC83045083
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32224318B96;
	Thu, 28 May 2026 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vqOisOYM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCCF304BB3;
	Thu, 28 May 2026 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001508; cv=none; b=FMNGgkH9+ns+/A1XDnZeJFjPEKfKKZTF7uFnRQyXV45Sf4NvPF32xFe0gVUbiaPTaryVjRu07/Wo9gEoC6adzaoGdGrhy8NQyvPInenhK4fm4scxuV0RyXm6VAswWS8iKMASAzR6ECoLDwK6Gsl1HqSQkfYkw5DEIb/nc5S+GNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001508; c=relaxed/simple;
	bh=008BPo3hgiL1a5Kc0vHQL5LgV4LnWIA2VHy+GeDsTnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMkhmxdLeJOiJIF0swLzLrZ0wGZbVQ2kJN7SZFyb9mCA7JedmrL27t0aOGxuXhq+IcEsS/wUZTo6wimm3Gx7/WolxCGGIP4vCQElUKa+kKIC3pyPRsBUq7dFyEjZbSq6h7g3B+j0gtRp2hC9JvsMZCvx6ESyen8pViIhROaAeN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vqOisOYM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BA11F000E9;
	Thu, 28 May 2026 20:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001506;
	bh=BkC1BGf25Gy6L5qAU8Ae+XiajJqwLhntDeibJBSYhwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vqOisOYMYVKjX2jPnADyE1ljEdXFYEaKdCZqxOrdwf5QUOVgZoJATvcUe4bHFmAkW
	 cI+ZlmM9cShjc1vNpSN6GrPksZRcNcBM26MODG6N4bvtY+Np4q73uGZMo6qXWBVwF2
	 ejmtChfn2/YD/s/s4RpaIRURCOJJhuoTqylR0XBk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 145/186] net: tls: prevent chain-after-chain in plain text SG
Date: Thu, 28 May 2026 21:50:25 +0200
Message-ID: <20260528194932.867970931@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256369-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E24BE5F9F1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit ff26a0e8377dec07e4a7230db7675bed1b9a6d03 ]

Sashiko points out that if end = 0 (start != 0) the current
code will create a chain link to content type right after
the wrap link:

  This would create a chain where the wrap link points directly
  to another chain link. The scatterlist API sg_next iterator
  does not recursively resolve consecutive chain links.

meaning this is illegal input to crypto.

The wrapping link is unnecessary if end = 0. end is the entry after
the last one used so end = 0 means there's nothing pushed after
the wrap:

   end         start            i
    v            v              v
  [   ]...[   ][ d ][ d ][ d ][ d ][rsv for wrap]

Skip the wrapping in this case.

TLS 1.3 can use the "wrapping slot" for it's chaining if end = 0.
This avoids the chain-after-chain.

Move the wrap chaining before marking END and chaining off content
type, that feels like more logical ordering to me, but should not
matter from functional perspective.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 9aaaa56845a0 ("bpf: Sockmap/tls, skmsg can have wrapped skmsg that needs extra chaining")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Link: https://patch.msgid.link/20260511174920.433155-3-kuba@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5ada6e54fb328..0c2e9724083ee 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -789,21 +789,33 @@ static int tls_push_record(struct sock *sk, int flags,
 	i = msg_pl->sg.end;
 	sk_msg_iter_var_prev(i);
 
+	/* msg_pl->sg.data is a ring; data[MAX+1] is reserved for the wrap
+	 * link (frags won't use it). 'i' is now the last filled entry:
+	 *
+	 *         i   end              start
+	 *         v    v                 v            [ rsv ]
+	 *  [ d ][ d ][   ][   ]...[   ][ d ][ d ][ d ][chain]
+	 *    ^   END                                     v
+	 *     `-----------------------------------------'
+	 *
+	 * Note that SGL does not allow chain-after-chain, so for TLS 1.3,
+	 * we must make sure we don't create the wrap entry and then chain
+	 * link to content_type immediately at index 0.
+	 */
+	if (i < msg_pl->sg.start)
+		sg_chain(msg_pl->sg.data, ARRAY_SIZE(msg_pl->sg.data),
+			 msg_pl->sg.data);
+
 	rec->content_type = record_type;
 	if (prot->version == TLS_1_3_VERSION) {
 		/* Add content type to end of message.  No padding added */
 		sg_set_buf(&rec->sg_content_type, &rec->content_type, 1);
 		sg_mark_end(&rec->sg_content_type);
-		sg_chain(msg_pl->sg.data, msg_pl->sg.end + 1,
-			 &rec->sg_content_type);
+		sg_chain(msg_pl->sg.data, i + 2, &rec->sg_content_type);
 	} else {
 		sg_mark_end(sk_msg_elem(msg_pl, i));
 	}
 
-	if (msg_pl->sg.end < msg_pl->sg.start)
-		sg_chain(msg_pl->sg.data, ARRAY_SIZE(msg_pl->sg.data),
-			 msg_pl->sg.data);
-
 	i = msg_pl->sg.start;
 	sg_chain(rec->sg_aead_in, 2, &msg_pl->sg.data[i]);
 
-- 
2.53.0




