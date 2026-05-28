Return-Path: <stable+bounces-254786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIXZOg0VGGrKbggAu9opvQ
	(envelope-from <stable+bounces-254786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:12:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C25F04C2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AF093040340
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F6838A73B;
	Thu, 28 May 2026 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QzOcEsWS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912383B47D7
	for <stable@vger.kernel.org>; Thu, 28 May 2026 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962352; cv=none; b=cNY5196NPmi8HWxMPFu03TZpmIr3S8aa9VP7O2cQb6wFTsv+moJOJ0gDXJ7IIGey2Q6xg65hEK2FrdqvXkNzLf3sswJ3STURtNbryFBYqc0Q1/kOvFPgrsTe84CS3xhg17K7ygK257hnVGBmNV2k6pu8Pn/RQjbRGvSNNTCPDoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962352; c=relaxed/simple;
	bh=7ClWJOYo58nG0p+PSUgWNvLYvw2Kw4ZM0enQqhNPlMU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Nw8jW/0ylbGsORie8nmOkmUlwMUbm+ll408kGodn6O4JBG6GOuiQHKnvXktUZjLO/E3tifylOeuHzor14+Dj3/tG+eeCOyetZhmnZ1+QUh+cT4zPUv2FTOpWd2ai61AWef4QtG0eqNfy505Lt5qPe6LvTRXq4RRw5MFvsLClZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QzOcEsWS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2041F000E9;
	Thu, 28 May 2026 09:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779962346;
	bh=wnQf/FhZ8EuSHFhp0Yt95ZPb34A2eYK3IO9kDRpPbFU=;
	h=Subject:To:Cc:From:Date;
	b=QzOcEsWSpkGDVU2AjgCFmvsy9TKSf4qW4xUZrmgGh3IX4CTDbI/VYxmCtvjBD7PiP
	 l+f8J406DQfUeGFWFxshFQYR2IKSKWgQfClE87SUMjduK+MAqY/V5S4GiGWxhOx+LX
	 If/WX9Ll4TuhbLIHdb4P/08F1Rar1r2xjDAi6qWA=
Subject: FAILED: patch "[PATCH] ipv6: ioam: add NULL check for idev in ipv6_hop_ioam()" failed to apply to 6.6-stable tree
To: justin.iurman@gmail.com,idosch@nvidia.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 11:58:12 +0200
Message-ID: <2026052812-uncoated-spry-43e1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254786-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,gregkh:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: E23C25F04C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d4ea0dfd75011b78cebf3808f98ac4c4f51a6fb9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052812-uncoated-spry-43e1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d4ea0dfd75011b78cebf3808f98ac4c4f51a6fb9 Mon Sep 17 00:00:00 2001
From: Justin Iurman <justin.iurman@gmail.com>
Date: Sun, 17 May 2026 20:30:59 +0200
Subject: [PATCH] ipv6: ioam: add NULL check for idev in ipv6_hop_ioam()

Reported by Sashiko:

The function ipv6_hop_ioam() accesses
__in6_dev_get(skb->dev)->cnf.ioam6_enabled without validating the returned
idev pointer. Because addrconf_ifdown() can concurrently clear dev->ip6_ptr
via RCU, __in6_dev_get() can return NULL during interface teardown, which
could cause a NULL pointer dereference when processing an IOAM Hop-by-Hop
option.

Let's add a check and use SKB_DROP_REASON_IPV6DISABLED accordingly.

Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Iurman <justin.iurman@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260517183059.29140-1-justin.iurman@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 03cbce842c1a..47c5502a34a2 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -910,16 +910,27 @@ static bool ipv6_hop_ra(struct sk_buff *skb, int optoff)
 
 static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 {
+	enum skb_drop_reason drop_reason;
 	struct ioam6_trace_hdr *trace;
 	struct ioam6_namespace *ns;
+	struct inet6_dev *idev;
 	struct ioam6_hdr *hdr;
 
+	drop_reason = SKB_DROP_REASON_IP_INHDR;
+
 	/* Bad alignment (must be 4n-aligned) */
 	if (optoff & 3)
 		goto drop;
 
+	/* Does the device still have IPv6 configuration? */
+	idev = __in6_dev_get(skb->dev);
+	if (!idev) {
+		drop_reason = SKB_DROP_REASON_IPV6DISABLED;
+		goto drop;
+	}
+
 	/* Ignore if IOAM is not enabled on ingress */
-	if (!READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_enabled))
+	if (!READ_ONCE(idev->cnf.ioam6_enabled))
 		goto ignore;
 
 	/* Truncated Option header */
@@ -972,7 +983,7 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 	return true;
 
 drop:
-	kfree_skb_reason(skb, SKB_DROP_REASON_IP_INHDR);
+	kfree_skb_reason(skb, drop_reason);
 	return false;
 }
 


