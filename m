Return-Path: <stable+bounces-244735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNMiLQjA/WkpigAAu9opvQ
	(envelope-from <stable+bounces-244735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:50:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3064F547A
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BADF30391CF
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 10:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E963101A7;
	Fri,  8 May 2026 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KSzRSBvR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E82F8EBA;
	Fri,  8 May 2026 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778237438; cv=none; b=ITn7U2yYosQkZSpw1ttm/l1GDJZOcFAezPlXpJWSbBsBB+rERfATYq+Ef3wqAQ03umuKJ5KJmuudMgAkEpGFTqBCAWZ11odvgJCTEX4UZDiN4wY9mXk73WNaSGcaAcAvQtGSbYV/aCoxOo2eip6BdlxdwXhMYJ8xwbYBlClyECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778237438; c=relaxed/simple;
	bh=ILWZCu0++F9FVKhgiaQ0MczDYExRpBSh6cymj2cRzCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgwH0iOKeT+QvWwXDz8oourIrFF49rLYJ4iaIb2lf48tbi6vlQEcOV//qGFdPs+h1br3vnKB5pLjqZTWRzcGV9HLJ3ulUFhyG1lc1/cYtYn5Nl0qaapKQVaFLgPl7lIQEDBHTRNdtj4QBd6uJDZmrupbxdoupIkoZ/uh39Nt4gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KSzRSBvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5540C2BCB0;
	Fri,  8 May 2026 10:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778237438;
	bh=ILWZCu0++F9FVKhgiaQ0MczDYExRpBSh6cymj2cRzCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KSzRSBvRrKpyg5SZvizUMadTNfsE6x/fdyt30ejL1nPx6ORVnIaT0ilEsbDQ2Y89A
	 QVMx1Zjv80W3rQyf8E5tkccZ2qKBjnoELrS0Pnb06ib3/+BJEpgovd+5BdormPYmFf
	 gLfzCrF7Wz5Sye4sDe2ZM5LwbQLHdMie10XmWjPU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.255
Date: Fri,  8 May 2026 12:50:27 +0200
Message-ID: <2026050827-riding-grit-275f@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026050827-wobbly-amply-778f@gregkh>
References: <2026050827-wobbly-amply-778f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3E3064F547A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244735-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index 42116a09d73d..2dc1e360a98b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 254
+SUBLEVEL = 255
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 0d5fc4f8c6ad..00bb4c6c86a0 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -921,7 +921,8 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 			nfrags = 1;
 
 			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
+		} else if (!skb_has_frag_list(skb) &&
+			   !skb_has_shared_frag(skb)) {
 			nfrags = skb_shinfo(skb)->nr_frags;
 			nfrags++;
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 70c316c0537f..bb94c032a373 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1447,6 +1447,8 @@ ssize_t	ip_append_page(struct sock *sk, struct flowi4 *fl4, struct page *page,
 			goto error;
 		}
 
+		skb_shinfo(skb)->tx_flags |= SKBTX_SHARED_FRAG;
+
 		if (skb->ip_summed == CHECKSUM_NONE) {
 			__wsum csum;
 			csum = csum_page(page, offset, len);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index a1d20dd4be3c..748f8771d8bf 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -966,7 +966,8 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 			nfrags = 1;
 
 			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
+		} else if (!skb_has_frag_list(skb) &&
+			   !skb_has_shared_frag(skb)) {
 			nfrags = skb_shinfo(skb)->nr_frags;
 			nfrags++;
 

