Return-Path: <stable+bounces-270894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hqhnCjaVRmpyZAsAu9opvQ
	(envelope-from <stable+bounces-270894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:43:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E1A6FA722
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:43:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=u4dOecMS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270894-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270894-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6217B30816F5
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88163451A7;
	Thu,  2 Jul 2026 16:35:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F893314A90;
	Thu,  2 Jul 2026 16:35:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010128; cv=none; b=lHl3I6XNYPEHftfS5EnZEECAZUeUDQ/P2aEH8yUQbGVDW05c+rnu+lrYjpcXuRtjKlqAD4lSlgSfJbDfXx27hNCivvPQEc5VMmbg1aOG/6sMIYD0jKmlPbCV0dRS6lQtbsg3f0jLjyJKKkEGCEyzTqPehhEq5FEaUjlnguMhv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010128; c=relaxed/simple;
	bh=wfeVBR07P6agI+IVkKR9LINq32ockAwHSYpJY9rrP40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgVmFq5l3wgfZh+r6kM4Oq86z1FTt+qMbny7XfyaQZUI8TxlSGIbj+YB50MVAprzqNOSAKd/oW58xQ5dhwDknw9Rx9MGn9B3Cap/EnbJN08+kKlqvJft7/B4pAnv0HU6HNsVbLxUa68hSQr0K/9JKNyT3wGQFLSpt2O0tMvQeq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u4dOecMS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015C71F000E9;
	Thu,  2 Jul 2026 16:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010127;
	bh=Zbgpa6sOJEGvEABzRSAUNjHCfwmONOOFO7iNkVK4Fc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u4dOecMSFV9BfN8UetvFyMyfXrDRUJ4fM/5WsPnKuXMFM7vZvcsFCjy3GYaw0oRQm
	 TDkR0e3EzK7usu3RAUkqNFdxj5WYHNRyOpefY6wZ5DRVYK/vdaEl7zvpGawXMlZJh3
	 MuQ3KKTOISJYdcJTHCNTTdB9d+ugq+bs9aepk0BQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Santosh Kalluri <santosh.kalluri129@gmail.com>,
	=?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 122/129] net: phonet: free phonet_device after RCU grace period
Date: Thu,  2 Jul 2026 18:20:41 +0200
Message-ID: <20260702155114.673182064@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
References: <20260702155112.163984240@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270894-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,remlab.net,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:santosh.kalluri129@gmail.com,m:remi@remlab.net,m:horms@kernel.org,m:kuba@kernel.org,m:sashal@kernel.org,m:santoshkalluri129@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,remlab.net:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0E1A6FA722

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Santosh Kalluri <santosh.kalluri129@gmail.com>

[ Upstream commit 71de0177b28da751f407581a4515cf4d762f6296 ]

phonet_device_destroy() removes a phonet_device from the per-net device
list with list_del_rcu(), but frees it immediately. RCU readers walking
the same list can still hold a pointer to the object after it has been
removed, leading to a slab-use-after-free.

Use kfree_rcu(), matching the lifetime rule already used by
phonet_address_del() for the same object type.

Fixes: eeb74a9d45f7 ("Phonet: convert devices list to RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Santosh Kalluri <santosh.kalluri129@gmail.com>
Acked-by: Rémi Denis-Courmont <remi@remlab.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/phonet/pn_dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -105,7 +105,7 @@ static void phonet_device_destroy(struct
 		for_each_set_bit(addr, pnd->addrs, 64)
 			phonet_address_notify(net, RTM_DELADDR, ifindex, addr);
 
-		kfree(pnd);
+		kfree_rcu(pnd, rcu);
 	}
 }
 



