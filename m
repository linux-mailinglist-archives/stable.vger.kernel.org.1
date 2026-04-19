Return-Path: <stable+bounces-238669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GU9mHshY5WmFiQEAu9opvQ
	(envelope-from <stable+bounces-238669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 00:35:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0962F425B06
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 00:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2C163004906
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 22:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A16B30F52A;
	Sun, 19 Apr 2026 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/J6TDTh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D9E2DCBFC
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776638149; cv=none; b=JzlHJUu1A6Ua1ojfw9QlQLNvw1avUiXDY29ifGM285WCUpZbQUWc7uP49oJBNqhW1xywWLxlCwyrXy4ur5K+HDXHgxzU3aEnpCikLmyzv098NPy9SJwFXjKSc+YGsUyr95JDhpA8bSt8UZm5EP6x1zgRyJapLOEErnefQZTTKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776638149; c=relaxed/simple;
	bh=I3Myfp0QkKb5K00juGV5JyULkwTG3pZaIDyX99SJCYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rW6UhyqLJ0sFPdb+bgwaqzGtsdIIjB5X8Uk8A7L4gwvtBcwAOQzV5jUKawemC3ofK8zx+VCeomC/q5En4/F44A74mcN5U1VTIe155ekNyPXSCCOd3+ui0EMQQebK25gVkTmt3UpJjdSMffl5eteXUtoUOR0LfzoAXjOR6+lEAZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/J6TDTh; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8eae9229110so72029285a.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 15:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776638147; x=1777242947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YjJhAhidNVRBtD80lOpLbifsanwTva+YHTmSJo3O1w=;
        b=d/J6TDThi2QEqimMl3rtVk85/fKhYaGOwyBWMIf/B+SVHvpx0KrLDWADmKOqAJ8iYM
         XYNLgxBGBSZhGJFHj963EgTi5p0RHSvupG+rVD/B0wPPtBaBVTO/cZVKR6y0dNMHqvHs
         NdA/p+nxlqy55jdljCpoS75R3D8L4kXvKxUkVH6XjonE3cA/CmlA1CtglFREKMxM91Vi
         01qSmJnYyuf9mtjP4JPQw3iuZfzyBc02BoZeto3vu4kEfbq3/O/2jab0qSyQBPr+4fOw
         jq4/PqWHvpXvdG5pt/N1GuBfRU6+cVRcg/wpLSmhmjq/dXfIdT7kUvAxNRQi6i9GpNSh
         3Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776638147; x=1777242947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YjJhAhidNVRBtD80lOpLbifsanwTva+YHTmSJo3O1w=;
        b=eWuG57GzwzJJuDlhqOGzPoH6/EbvoDZeh0yKYxByoh+LYp8jmmcn0/yHxkG12HAUxE
         AHHhtaSEQ/H4b3HzlniqfjxCIBCtI3bysGqcut8kcl045nRPCdMXs1LK01fFZpL+WDwB
         UxoPWiS+QfKh9o2d8uwwvmAPQw98IHWZmRMxP/mAB3qPAKnLOTb6sXbcFCIBDqo6Qn5b
         KTBDoGZ+Q59TmFY6+F72tPrP0gEYr5YABQ9tmO+48hieJKBkoBt8gijd1lalSc5/bVJY
         smyVbl5IyVniXpNZh14xnP37SU143DCAQeGkHOOxQmY0+O1RlBTMkYfwzD22eOv7fVG2
         0T0A==
X-Forwarded-Encrypted: i=1; AFNElJ893EfsWzmnHl5rYI+IS5IuT3z18zYq58IyBOjETLffo0cyr9dZLAQeSagDSyu3poM6MqnpvuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJOq4y+iU09//fGqXAGAypgFBu5xLxIC9k8XysU0uE44HJvBK8
	ShXBD+/xgQXQd1Rucr8Vy46Z862yV6+NCTppihcMCja5q1zFEKOBcbI7oNg48lu/
X-Gm-Gg: AeBDiet89MsSyOIlggmBprDICYxcpNoUYAWrRkNAO8EFS+T3ozQEJQBpWnGNHDgvjgL
	5NV28Y4GKQxDzuFEAjPuJ4sIDeZJ8rQ1/vWq+JRnkJp2Eqj+RPECI876Gook5Rs4syAjFg/fAKk
	zNqrCqfqZPtB00/0PNx/34Oko7lv0A3oQzBDJt92LbjEay2Gb3Jidw+fB446pxJ++fKmh0Nc/qk
	ntXYhVyTANg4KvxfNwWhO6jxsisQPaIgd8unl9m2MO7gSfh5flhMLFmP2y8dSk5j/I0BCrDezpD
	axrQ07hH4RK4RnohyLVKhn7G2RFIyo369+/ZDiSTJ3K++93FI/7WpJo8zFuE5WRoccNfWFFhSw3
	I8diJpzrY34PbXTw8+MkzOdqOmGXonWsaYSEcdVB1GLOFOzKZscHb6GwUxnYIREYEhuA1cWNiEG
	2f4wx6MXEtUjpjE6i5GKgJcPNnMpmyGbtTrM/+SSx44i3T6jx4afp6m2qZ6aCmECzPx7hRJnXqw
	WTiN4LjxvER15/nqd5BZKtVYTioXuI=
X-Received: by 2002:a05:620a:46a0:b0:8cf:c4d7:dfa with SMTP id af79cd13be357-8e78f827c71mr1660750385a.16.1776638146787;
        Sun, 19 Apr 2026 15:35:46 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d8edb734sm727830985a.29.2026.04.19.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 15:35:46 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Fan Du <fan.du@windriver.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] xfrm: ah: account for ESN high bits in async callbacks
Date: Sun, 19 Apr 2026 18:35:42 -0400
Message-ID: <20260419223542.2293727-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238669-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0962F425B06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

AH allocates its temporary auth/ICV layout differently when ESN is enabled:
the async ahash setup appends a 4-byte seqhi slot before the ICV or
auth_data area, but the async completion callbacks still reconstruct the
temporary layout as if seqhi were absent.

With an async AH implementation selected, that makes AH copy or compare
the wrong bytes on both the IPv4 and IPv6 paths. In UML repro on IPv4 AH
with ESN and forced async hmac(sha1), ping fails with 100% packet loss,
and the callback logs show the pre-fix drift:

  ah4 output_done: esn=1 err=0 icv_off=20 expected_off=24
  ah4 input_done: esn=1 auth_off=20 expected_auth_off=24 icv_off=32 expected_icv_off=36

Reconstruct the callback-side layout the same way the setup path built it
by skipping the ESN seqhi slot before locating the saved auth_data or ICV.
Per RFC 4302, the ESN high-order 32 bits participate in the AH ICV
computation, so the async callbacks must account for the seqhi slot.

Post-fix, the same IPv4 AH+ESN+forced-async-hmac(sha1) UML repro shows
the corrected offset (ah4 output_done: esn=1 err=0 icv_off=24
expected_off=24) and ping succeeds; net/ipv4/ah4.o and net/ipv6/ah6.o
build clean at W=1. IPv6 AH+ESN was not exercised at runtime, and the
change has not been tested against a real async hardware AH engine.

Fixes: d4d573d0334d ("{IPv4,xfrm} Add ESN support for AH egress part")
Fixes: d8b2a8600b0e ("{IPv4,xfrm} Add ESN support for AH ingress part")
Fixes: 26dd70c3fad3 ("{IPv6,xfrm} Add ESN support for AH egress part")
Fixes: 8d6da6f32557 ("{IPv6,xfrm} Add ESN support for AH ingress part")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-4
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ipv4/ah4.c | 14 ++++++++++++--
 net/ipv6/ah6.c | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index 5fb812443a08..4366cbac3f06 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -124,9 +124,14 @@ static void ah_output_done(void *data, int err)
 	struct iphdr *top_iph = ip_hdr(skb);
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	int ihl = ip_hdrlen(skb);
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	iph = AH_SKB_CB(skb)->tmp;
-	icv = ah_tmp_icv(iph, ihl);
+	seqhi = (__be32 *)((char *)iph + ihl);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
 
 	top_iph->tos = iph->tos;
@@ -270,12 +275,17 @@ static void ah_input_done(void *data, int err)
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	int ihl = ip_hdrlen(skb);
 	int ah_hlen = (ah->hdrlen + 2) << 2;
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
 	if (err)
 		goto out;
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	work_iph = AH_SKB_CB(skb)->tmp;
-	auth_data = ah_tmp_auth(work_iph, ihl);
+	seqhi = (__be32 *)((char *)work_iph + ihl);
+	auth_data = ah_tmp_auth(seqhi, seqhi_len);
 	icv = ah_tmp_icv(auth_data, ahp->icv_trunc_len);
 
 	err = crypto_memneq(icv, auth_data, ahp->icv_trunc_len) ? -EBADMSG : 0;
diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index cb26beea4398..de1e68199a01 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -317,14 +317,19 @@ static void ah6_output_done(void *data, int err)
 	struct ipv6hdr *top_iph = ipv6_hdr(skb);
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	struct tmp_ext *iph_ext;
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
 	extlen = skb_network_header_len(skb) - sizeof(struct ipv6hdr);
 	if (extlen)
 		extlen += sizeof(*iph_ext);
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	iph_base = AH_SKB_CB(skb)->tmp;
 	iph_ext = ah_tmp_ext(iph_base);
-	icv = ah_tmp_icv(iph_ext, extlen);
+	seqhi = (__be32 *)((char *)iph_ext + extlen);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 
 	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
 	memcpy(top_iph, iph_base, IPV6HDR_BASELEN);
@@ -471,13 +476,18 @@ static void ah6_input_done(void *data, int err)
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	int hdr_len = skb_network_header_len(skb);
 	int ah_hlen = ipv6_authlen(ah);
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
 	if (err)
 		goto out;
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	work_iph = AH_SKB_CB(skb)->tmp;
 	auth_data = ah_tmp_auth(work_iph, hdr_len);
-	icv = ah_tmp_icv(auth_data, ahp->icv_trunc_len);
+	seqhi = (__be32 *)(auth_data + ahp->icv_trunc_len);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 
 	err = crypto_memneq(icv, auth_data, ahp->icv_trunc_len) ? -EBADMSG : 0;
 	if (err)
-- 
2.53.0


