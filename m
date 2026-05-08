Return-Path: <stable+bounces-244739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFckOfjA/WkpigAAu9opvQ
	(envelope-from <stable+bounces-244739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:54:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7847F4F5523
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A687A30A3398
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 10:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFC1313E01;
	Fri,  8 May 2026 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W3jVZqq+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EE0311973;
	Fri,  8 May 2026 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778237452; cv=none; b=q6O4EPLxIrqHYffHYcGvRcO7iwyJLuf6Gb5i8Ql/HAuqVANUtaSQHa4aiiH3WZBr4VRjZfK5vqyjL2JQIi04WdD2DzwXB3jX4H++etfm17ZsWPl0qjfV8KcORfl0EJRxDVLFxupBt2c3M89N9xtdxFk8MfSwMT6EBjfInI8Ux2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778237452; c=relaxed/simple;
	bh=vFyGVi/FyM4sQSI7rXYjLchjvxxwW7JcuH0Vi/EYzWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY+RQj0fw+EJ7ieneDrMUGy/7J1LVDaUwm7fIEGRKlAOMbuEt+FFR/+TjCooT9+2RlM1h1bme8yI0XzBfp7Ni0k2rCzjv+Pd6KTgcSVUFxGZZsriZJaGRXYEvl15yHS7Kp2L9ws4cADyCzkpp6SShwirZUFIOqln25D9et+F0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W3jVZqq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD733C2BCB0;
	Fri,  8 May 2026 10:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778237452;
	bh=vFyGVi/FyM4sQSI7rXYjLchjvxxwW7JcuH0Vi/EYzWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3jVZqq+FLYms2YrONYdeeOH3IbYCPE/fSXAcR8/XiUgAoFao6ctAda4x3bw1aDRL
	 /gxuNr1IKx6urz/3+3vmuU0k/Dv5Jog7WqY2UAOHTA977KWMfKChR/Bn3qlLrcoGXp
	 ndLHmB/AVo0ikmZcARm4oLK4tsLDtFpk+eNE60sE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.171
Date: Fri,  8 May 2026 12:50:41 +0200
Message-ID: <2026050840-obsolete-bride-e738@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026050840-dart-sampling-7fb7@gregkh>
References: <2026050840-dart-sampling-7fb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7847F4F5523
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244739-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index 8bca26994e0c..2b467b2216e7 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 170
+SUBLEVEL = 171
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 95575bf78d5c..5d59b5923e6b 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -873,7 +873,8 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 			nfrags = 1;
 
 			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
+		} else if (!skb_has_frag_list(skb) &&
+			   !skb_has_shared_frag(skb)) {
 			nfrags = skb_shinfo(skb)->nr_frags;
 			nfrags++;
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 79cf1385e8d2..ec8279278dea 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1463,6 +1463,8 @@ ssize_t	ip_append_page(struct sock *sk, struct flowi4 *fl4, struct page *page,
 			goto error;
 		}
 
+		skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
+
 		if (skb->ip_summed == CHECKSUM_NONE) {
 			__wsum csum;
 			csum = csum_page(page, offset, len);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 76699ec88370..51de2d4f7a2f 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -921,7 +921,8 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 			nfrags = 1;
 
 			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
+		} else if (!skb_has_frag_list(skb) &&
+			   !skb_has_shared_frag(skb)) {
 			nfrags = skb_shinfo(skb)->nr_frags;
 			nfrags++;
 

