Return-Path: <stable+bounces-264646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RWRbCmp6MWqEkQUAu9opvQ
	(envelope-from <stable+bounces-264646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:31:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF46922A8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:31:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=IdmDMDtw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264646-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264646-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C2CE3064979
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6880B46AF11;
	Tue, 16 Jun 2026 16:24:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A594466B57;
	Tue, 16 Jun 2026 16:24:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627047; cv=none; b=E3FoZ3ACh2x5mjN/d0WRp+Nxm3tiMkrjNnOoHWg4BM73FK7cbdW2qRVWxJFB4rIJcnLQ3iCPs58/84+Qc3+dgQ2+hUvSVa3Q5+RbaXitkElFHzkY8F3euJs9+KtTl4mLG9xmqIiXotMDZNaQinHdfTVoRGFut4VszVEKVq8qeK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627047; c=relaxed/simple;
	bh=nJ2eTa2ZIQLt7JArccbU8swtCFHh6g6Y16+WcJ+/M8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+SgftHjUk4cnayTFjh3oQDxT0OWQx8L1nopwPHSkgQ9nlRx4GOIfPEXF7N/oK7KuX4jJRNl5kUdFaASHAiDfbc+Xj+t3URbxtoLYmSITeccA9KLSKntjEe3aEyOMifWzjsXhcMVYNq7R4n6zfWl2A47yVtWqHA14T6jWfT2ahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IdmDMDtw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81661F000E9;
	Tue, 16 Jun 2026 16:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627045;
	bh=No0xFgTGmE7SrdwmSjwAd8bebCcKSj8siVK6/aUUVbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IdmDMDtw5BOsUw6et4/jDFB8X1V+Z9xkSRD5v1bA/nhK07iqTN/Z5G8O0TSJLE3p6
	 GNfoJu9YXYaatrQ3zS1f7ARYTW01xoRL4OecZyBp+dgM9tLvYs9Z4h7Mv+6ygx0AtO
	 zIa31n23G4t2bX/JDaOv+86L3ABKC24GJG2PtoRU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jianbo Liu <jianbol@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Simon Liebold <simonlie@amazon.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 111/261] xfrm: hold device only for the asynchronous decryption
Date: Tue, 16 Jun 2026 20:29:09 +0530
Message-ID: <20260616145050.209026904@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264646-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jianbol@nvidia.com,m:cratiu@nvidia.com,m:steffen.klassert@secunet.com,m:simonlie@amazon.de,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amazon.de:email,vger.kernel.org:from_smtp,nvidia.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,secunet.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCCF46922A8

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit b05d42eefac737ce3cd80114d3579111023941b8 ]

The dev_hold() on skb->dev during packet reception was originally
added to prevent the device from being released prematurely during
asynchronous decryption operations.

As current hardware can offload decryption, this asynchronous path is
not always utilized. This often results in a pattern of dev_hold()
immediately followed by dev_put() for each packet, creating
unnecessary reference counting overhead detrimental to performance.

This patch optimizes this by skipping the dev_hold() and subsequent
dev_put() when asynchronous decryption is not being performed.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Stable-dep-of: 1c428b038400 ("xfrm: hold dev ref until after transport_finish NF_HOOK")
Signed-off-by: Simon Liebold <simonlie@amazon.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_input.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 8edcb32735e595..90a79558dca259 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -492,6 +492,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		/* An encap_type of -1 indicates async resumption. */
 		if (encap_type == -1) {
 			async = 1;
+			dev_put(skb->dev);
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
 			goto resume;
 		}
@@ -638,18 +639,18 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		XFRM_SKB_CB(skb)->seq.input.low = seq;
 		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
 
-		dev_hold(skb->dev);
-
-		if (crypto_done)
+		if (crypto_done) {
 			nexthdr = x->type_offload->input_tail(x, skb);
-		else
+		} else {
+			dev_hold(skb->dev);
+
 			nexthdr = x->type->input(x, skb);
+			if (nexthdr == -EINPROGRESS)
+				return 0;
 
-		if (nexthdr == -EINPROGRESS)
-			return 0;
+			dev_put(skb->dev);
+		}
 resume:
-		dev_put(skb->dev);
-
 		spin_lock(&x->lock);
 		if (nexthdr < 0) {
 			if (nexthdr == -EBADMSG) {
-- 
2.53.0




