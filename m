Return-Path: <stable+bounces-261193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dYjwCtxFJWqNFgIAu9opvQ
	(envelope-from <stable+bounces-261193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:20:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD95464F8A4
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:20:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ZtMZZPM4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261193-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-261193-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 367C73002B16
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D595B23392F;
	Sun,  7 Jun 2026 10:20:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A74071DA;
	Sun,  7 Jun 2026 10:20:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827607; cv=none; b=mR3CTqF1pD+2VJXH6LSxXbzX90NSfMMCb6T4NROgyOVVZkC5kz8xPdaSHvWA8LnN0TlQIArxxOyJVOkeBIo4tD1o0z9YOo3AFXtpk1ueXSXmPFQ+H/cYM4kIgkmKPYRCBtIQgdEfAhPG/2MUZT7/GW65QccTF6rT9ErJlERZ7tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827607; c=relaxed/simple;
	bh=aYJfX+oU82WX9sveeuBE+dTzZ8EuE7FEzuMTkDz3Oo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMpTFvR+VcNCOkdFy0Oa8f0Qgksodm0Z+b3AR+ZrLHnGnXUTcRLLpOuiRCP36VI7tpjuCsCXQt2+eb88FoVvgnL55fnXsIVeZjATzN9dZZpGVAiReAmMtAZzwps2Sht1xfXv4AyNOFt/lSxnsnAPupEFllOiV7llFbMT7dG8vyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZtMZZPM4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDB71F00893;
	Sun,  7 Jun 2026 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827606;
	bh=W0kJmFq2mfpbyeKzIfcsKaxyq8CWsQKRoGvvuLrMbe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZtMZZPM4WWXZlsHDqtMTLnGWrvC3DNcYQaxLXtlvnV95Xb3pQuVMdm/9wJ2reqayY
	 EwGsth528cYVnEEz7E86AcbKEQV72G6iilcgHbKGwZskYIWVf5VDVk3yNwWOvkCeBQ
	 IsmGHpozD/622qvL08OA9bzna4DQCtL/+XFzERw8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rahul Chandelkar <rc@rexion.ai>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 072/307] ipv6: rpl: fix hdrlen overflow in ipv6_rpl_srh_decompress()
Date: Sun,  7 Jun 2026 11:57:49 +0200
Message-ID: <20260607095730.406974179@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261193-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:rc@rexion.ai,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rexion.ai:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD95464F8A4

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rahul Chandelkar <rc@rexion.ai>

[ Upstream commit 9d5e7a46a9f6d8f503b41bfefef70659845f1679 ]

ipv6_rpl_srh_decompress() computes:

    outhdr->hdrlen = (((n + 1) * sizeof(struct in6_addr)) >> 3);

hdrlen is __u8. For n >= 127 the result exceeds 255 and silently
truncates. With n=127 (cmpri=15, cmpre=15, pad=0, hdrlen=16):

    (128 * 16) >> 3 = 256, truncated to 0 as __u8

The caller in ipv6_rpl_srh_rcv() then places the compressed header
at buf + ((ohdr->hdrlen + 1) << 3). With hdrlen=0 this is buf + 8,
but the decompressed region occupies buf[0..2055] (8-byte header
plus 128 full addresses). The compressed header overlaps the
decompressed data, and ipv6_rpl_srh_compress() writes into this
overlap, corrupting the routing header of the forwarded packet.

The existing guard at exthdrs.c:546 checks (n + 1) > 255, which
prevents n+1 from overflowing unsigned char (the segments_left
field), but does not prevent the computed hdrlen from overflowing
__u8. n=127 passes because 128 <= 255, yet hdrlen=256 does not
fit.

Tighten the bound to (n + 1) > 127. This caps n at 126, giving
hdrlen = (127 * 16) >> 3 = 254, which fits in __u8. The compressed
header then lands at buf + ((254 + 1) << 3) = buf + 2040, exactly
past the decompressed region (buf[0..2039]). No overlap. 127
segments is well beyond any realistic RPL deployment.

Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
Signed-off-by: Rahul Chandelkar <rc@rexion.ai>
Link: https://patch.msgid.link/20260525154031.2290876-1-rc@rexion.ai
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/exthdrs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 5ef6fbc66beb11..43e34fe448ffe5 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -546,7 +546,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	 * unsigned char which is segments_left field. Should not be
 	 * higher than that.
 	 */
-	if (r || (n + 1) > 255) {
+	if (r || (n + 1) > 127) {
 		kfree_skb(skb);
 		return -1;
 	}
-- 
2.53.0




