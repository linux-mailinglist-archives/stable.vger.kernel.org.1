Return-Path: <stable+bounces-220364-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN2BBaE1o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220364-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8D81C604E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4A3E312A6B4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531473A128D;
	Sat, 28 Feb 2026 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psVkRRKC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E63A1285;
	Sat, 28 Feb 2026 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300261; cv=none; b=nWQTHPxjIHiXf2HWgJthGc+7tqNA7OYY/TWvHJychPCP4bCqHLnuuk51LiTTxUcMSFg+Fl7nE9cu2avbPAEVeKae8Rs09XkqXxPoWOzpOKw48Y0urUSrN2lPYjPtQKtO6nSplMV5XeladQjJX+pPAJTo2wju5+t2Gfmt0fbAbnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300261; c=relaxed/simple;
	bh=W15cyp0xaAgC3j6Km803kuRKxO/r6w2fW0XBj3f2/Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFR4BrcP5WcYt1H+7hFbOmB3PlBQRL8NG8DVB8Sw5z9qJRskcabKQIbjBQ0nHTVAgfkiRFQx75fArTEWgfppQECow0WiPIBeyCANFclNX03VcVeUYnsUwR73VBzVEHElSfuKFhOE5jYFqqBG3Zl80L97RJKemezOgWuZ0DUYPWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psVkRRKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B143C116D0;
	Sat, 28 Feb 2026 17:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300261;
	bh=W15cyp0xaAgC3j6Km803kuRKxO/r6w2fW0XBj3f2/Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=psVkRRKCTJ0OkgZJYmmooUq1qVLdixRe5qBK58GHdiZQrxf0O1OgS7qeZgv/JPTDT
	 sKLCg+Zwb4B4nZhcg8tsaouxc/0y7chQ9hKfIWzV25NnPc5bhJLu8XV3hnvFAbSe1M
	 swUAKmv+xEkUjnVSPLmNdS7JWBS3tAXwwsbcuHBwoXMt5IXI9ZdT9FdcavpujWFBaH
	 ctCXTI3vRAs/Y9KLzz13dCxzejM+lDC65aAOu1ZnNU5xGIGjMOr+GC0O4AawolVsj2
	 is3qv1fgA5UflaPMkBmd4E3N94HWXgpg9z4CLF66eDOKepZqKJwocmhOqBwbppyABc
	 PKfkMss4AmTZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 286/844] ipv6: exthdrs: annotate data-race over multiple sysctl
Date: Sat, 28 Feb 2026 12:23:19 -0500
Message-ID: <20260228173244.1509663-287-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220364-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8F8D81C604E
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 978b67d28358b0b4eacfa94453d1ad4e09b123ad ]

Following four sysctls can change under us, add missing READ_ONCE().

- ipv6.sysctl.max_dst_opts_len
- ipv6.sysctl.max_dst_opts_cnt
- ipv6.sysctl.max_hbh_opts_len
- ipv6.sysctl.max_hbh_opts_cnt

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260115094141.3124990-8-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/exthdrs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index a23eb8734e151..54088fa0c09d0 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -314,7 +314,7 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
 	}
 
 	extlen = (skb_transport_header(skb)[1] + 1) << 3;
-	if (extlen > net->ipv6.sysctl.max_dst_opts_len)
+	if (extlen > READ_ONCE(net->ipv6.sysctl.max_dst_opts_len))
 		goto fail_and_free;
 
 	opt->lastopt = opt->dst1 = skb_network_header_len(skb);
@@ -322,7 +322,8 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
 	dstbuf = opt->dst1;
 #endif
 
-	if (ip6_parse_tlv(false, skb, net->ipv6.sysctl.max_dst_opts_cnt)) {
+	if (ip6_parse_tlv(false, skb,
+			  READ_ONCE(net->ipv6.sysctl.max_dst_opts_cnt))) {
 		skb->transport_header += extlen;
 		opt = IP6CB(skb);
 #if IS_ENABLED(CONFIG_IPV6_MIP6)
@@ -1049,11 +1050,12 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
 	}
 
 	extlen = (skb_transport_header(skb)[1] + 1) << 3;
-	if (extlen > net->ipv6.sysctl.max_hbh_opts_len)
+	if (extlen > READ_ONCE(net->ipv6.sysctl.max_hbh_opts_len))
 		goto fail_and_free;
 
 	opt->flags |= IP6SKB_HOPBYHOP;
-	if (ip6_parse_tlv(true, skb, net->ipv6.sysctl.max_hbh_opts_cnt)) {
+	if (ip6_parse_tlv(true, skb,
+			  READ_ONCE(net->ipv6.sysctl.max_hbh_opts_cnt))) {
 		skb->transport_header += extlen;
 		opt = IP6CB(skb);
 		opt->nhoff = sizeof(struct ipv6hdr);
-- 
2.51.0


