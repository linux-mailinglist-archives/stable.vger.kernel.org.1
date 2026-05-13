Return-Path: <stable+bounces-246948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK3WAMazBGowNQIAu9opvQ
	(envelope-from <stable+bounces-246948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:24:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF78537F5F
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F79E31F822E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46DF48A2CE;
	Wed, 13 May 2026 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnVl0EQF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A849E3321B1
	for <stable@vger.kernel.org>; Wed, 13 May 2026 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691179; cv=none; b=fosg40zkop0pccclltmS70OyNmMtfKuPcMPA6BXe2ue8JYZRU9exUp/L4V6743osbpT7ciER7ysVbGRv4nGSiPvMGV1MiU6ICv7L9LaKw/QhbAsYZIIrp0hyY6W3k2JZKSI65sj7jSsAUXD0VC++woas7fIalvfiMj5BVEdmm6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691179; c=relaxed/simple;
	bh=4QwqJzyl49415VWPWBSUkZmeLz6PfWVdHKkgboy+wW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecqYVWDHk2vgM5HxUk36bsKsAsZJvNILZKZdseCOhIgzD7WU9NZnTiBckQncDZzr3WckvCeC92iYQse0nMZezgdFn7colRSa8CShwMii/1ynYGQzZ2tsWjmoC/Gu6Nw5Z0pWvC9j4p2hlxAMJKZNnL+QIio5Hp8cgIUdTiwspkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnVl0EQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA765C2BCB7;
	Wed, 13 May 2026 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778691179;
	bh=4QwqJzyl49415VWPWBSUkZmeLz6PfWVdHKkgboy+wW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnVl0EQF4UlwUSAgjTFw7K/vTu4IXacInBPYgSbe8xjNsrdCjhBY0kZy+3ImAWjJD
	 TI0OeuU6GC7qhexkJfTVNByiLLpLo+n3rMeM5Ac6gyer1vKJblNqhsqdxxKOrepDOL
	 iMhNtLAV+tUHEqk10Cod5GGw8d+47+uQw6UdI1aBtWL5H+b0cr1HpBWlZdVhFCbjN0
	 5WCn2BzJg1KK+Yvuwh4XrIZ4ImdXHbYYvKmFVNrm2x/QW4ggrK38l/vtmdH2WLDylB
	 y76FjxLzaYnbcAGUJgR6INqXQag/ZrbQ/e2laUVuRJn5V+QNaJqkL07LahjNV8W18x
	 p4xNvc9Ifjqcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] xfrm: ah: account for ESN high bits in async callbacks
Date: Wed, 13 May 2026 12:52:55 -0400
Message-ID: <20260513165255.3822003-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513165255.3822003-1-sashal@kernel.org>
References: <2026051235-gigolo-wriggle-f7a3@gregkh>
 <20260513165255.3822003-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6CF78537F5F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,secunet.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246948-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit ec54093e6a8f87e800bb6aa15eb7fc1e33faa524 ]

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
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ah4.c | 14 ++++++++++++--
 net/ipv6/ah6.c | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index c64e3212581bc..e83049e00ed1c 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -124,9 +124,14 @@ static void ah_output_done(struct crypto_async_request *base, int err)
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
@@ -270,12 +275,17 @@ static void ah_input_done(struct crypto_async_request *base, int err)
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
index 68896e7828b6d..2c505823c18d0 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -317,14 +317,19 @@ static void ah6_output_done(struct crypto_async_request *base, int err)
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
@@ -471,13 +476,18 @@ static void ah6_input_done(struct crypto_async_request *base, int err)
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


