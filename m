Return-Path: <stable+bounces-244777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBvTF0/4/WlilQAAu9opvQ
	(envelope-from <stable+bounces-244777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:50:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D984E4F81A5
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45AFF301B4F1
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD26B3F54CA;
	Fri,  8 May 2026 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R3sbtcg1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129873F54B3;
	Fri,  8 May 2026 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251825; cv=none; b=pCpCmpda4x49r06I1egVp8GfJSazffatVH0SneKWYOnehD6NLfMwVX23cmUC+F8FvEV6LiE3WuxkyGEnbBbHTi4LUSOmLz38GEMmuFsiAA5hcWCH/Qa2kMz9U6Iby4Orcrx/1y7Q2QVipz15iQCzp/RNvGS+i9xpeOu9FTRboJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251825; c=relaxed/simple;
	bh=1iEXpyueJfRGRw48Xzml++FFZ6GZiXgzid73eVPtY34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5BCF+SRgjw5HM0WNzmWIXWWQBQh5uV0oXl07T5rk1wwYPsc4LRCoeEzoaGIvwOubH2/ufrffrKf1idUWt56difI7+pwlht88pPfnhb9VTUXVPhHm6aHW0gxA70Kt2knh97bBpKc6K9bAT8H0TavtfjWYSb04e6MINxkxgo60Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R3sbtcg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0CBC2BCB0;
	Fri,  8 May 2026 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778251824;
	bh=1iEXpyueJfRGRw48Xzml++FFZ6GZiXgzid73eVPtY34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R3sbtcg1lgEny0Nvui/7tmnbyWQtZHrIvtCO16Iz8o42XER7rF63lKwvHgJ2o+Ggb
	 Lkb99T74T0U+apNKC474jea6TskZvqoyLhUOO+lDo6BPXYzpFrCALxSdz4IXROULO1
	 m0DnWpR7R01Oo1j2y9BAFwmjz1wJZZtGNx299cak=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.206
Date: Fri,  8 May 2026 16:50:13 +0200
Message-ID: <2026050813-pond-arrange-1d19@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026050813-brook-deacon-f194@gregkh>
References: <2026050813-brook-deacon-f194@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D984E4F81A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244777-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index 9fcf204d08af..a5a6e44e331b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 205
+SUBLEVEL = 206
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 68509e1f89b5..5d8f8a5901bc 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1443,7 +1443,7 @@ ssize_t	ip_append_page(struct sock *sk, struct flowi4 *fl4, struct page *page,
 			goto error;
 		}
 
-		skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
+		skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
 
 		if (skb->ip_summed == CHECKSUM_NONE) {
 			__wsum csum;

