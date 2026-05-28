Return-Path: <stable+bounces-256169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH/3BdesGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:00:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB455FA07D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DB333113DBD
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AACE2EF652;
	Thu, 28 May 2026 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JIXOseL7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCAB33439A;
	Thu, 28 May 2026 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000949; cv=none; b=qdDsf02ljlJ4aZngxQ9COFJoV8tRiRdHkA48ztDSETB7q3rtChCY4EVAasyspP/IGOrWHZFpHpDTFdZ4VHL/ZpksmUOGXMi8b48VZa0hoSUguZ3/jTZcrshRtuhsguZKk+cptiBSF3SSiz8aBL4cWc/blgeHfYfVRatvDlotJmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000949; c=relaxed/simple;
	bh=TeqLiDbcoTDS0tDMuc+sQSnncBCwmMt6mqVqpSVF5dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nObAXwkjYBHMmuz2To0NV0VXromP7Vj7yckAw3UKbpMPwDhyY+e6OmMauXDqtZj3yZNqbDrK+EcT5cktrAAlifsgWLEvOJqENLIdRS0JDKC23dRjom+k16MmSHOcjn9f17QDK0uhJDjId7EDWNDGzKlChV2H/4Xvf8SRgQ8O9J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JIXOseL7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2311F000E9;
	Thu, 28 May 2026 20:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000948;
	bh=8Ay+7K+EsPKqlmtB7gi0UoXQ9hqamitrCZomanr9kag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JIXOseL7ybPFcJI47h7yP9eX4m0zTnwHcZMG0xrYJLNEcq1iSIWso9rk3Ku6ti20n
	 4ELW0hBUVF+xLsasOS3fDVFr6YgdYR73AN8ZJ4SksFY7hYHQ4zm5ydbe6C+l8WXO0u
	 4gSqW1MjWl3rpfjTkr33VU6pLmlgiwY37vz9snT8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 226/272] net: tls: prevent chain-after-chain in plain text SG
Date: Thu, 28 May 2026 21:50:00 +0200
Message-ID: <20260528194635.513508237@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256169-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1FB455FA07D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 834cb01f8e0e8..7511cce76fbbf 100644
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




