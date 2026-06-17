Return-Path: <stable+bounces-266813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ejbBJXu1MmpV4AUAu9opvQ
	(envelope-from <stable+bounces-266813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:55:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA89069AB62
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:55:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S6s+xOSq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266813-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-266813-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32438301E441
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC2B2E737C;
	Wed, 17 Jun 2026 14:55:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0302DF701
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:55:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708144; cv=none; b=m2jHp1KKzJQxBheB90FjdnlnQfaZx0ILkgINjzAnwOGs+D1CVRLfEYiQl0FN+Ip6duVcX5QhLSRE0Beqy0gl4qK8+LNgZWwR+9M2hYWvc3Xecp/vrymSnYYa98uNA6yHgYB5bI2Om6y21DzyAxs3PpEEaKTiNMKiHiEfVivSEYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708144; c=relaxed/simple;
	bh=ZYUc/U1x3ZS0oe9t0Rr7odEfZqwQANkGgvl+1pxDTLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVwonvnBqaX9V+sfadlzVLpo6b/R1HglMAtPQknbc8hXeu6GTfUy3oozw1GP3+E77HXpnzmujjp9Q+bjTPzA1NnunArNKVAuhtNXsLQjyd685IjV/U4v6qw1D0s52Q7q7/Qheyy/JoIfxnuGlq1A1BWUkkWi8IiR4YUZ0oju3Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6s+xOSq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392D31F00A3F;
	Wed, 17 Jun 2026 14:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781708142;
	bh=pPhumvrDmgpP+yI7sacMiGw55muhNQpo9VCRlmKlHDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S6s+xOSqHf6Gi9tMSx+3cpDwSDx6QNXQWLLwD7QYHwfcaLWOLuBKGYC6JIGFEUYX8
	 yHkQsy2M3BB6/9EIH5PX4Bxretq3Gj5aHeRwbArUD7kxZxn2AFlN6m5sXohu5awT+8
	 rDOG0pKX1CxnZvGxULsgio6uv2Fxi2WxIsIEaxzFgnH0J9Pktw3OyVw+9HCsb+VLXv
	 jJo2wV7VY+Ygd4XujjgoMUZxlstGmY6124+S0rGftg7jetTVo6PKVEc1Y3DHxssVEB
	 bTORbb5Kx0j0J5bmzWGdexdJ6TnucorAJ+MwX7p9KffPZ4oW0/9LYEYCrSQ51BclNX
	 S100o/Tbfu5Aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Santosh Kalluri <santosh.kalluri129@gmail.com>,
	=?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] net: phonet: free phonet_device after RCU grace period
Date: Wed, 17 Jun 2026 10:55:38 -0400
Message-ID: <20260617145538.157435-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617145538.157435-1-sashal@kernel.org>
References: <2026061549-equipment-myspace-2ba7@gregkh>
 <20260617145538.157435-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266813-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:santosh.kalluri129@gmail.com,m:remi@remlab.net,m:horms@kernel.org,m:kuba@kernel.org,m:sashal@kernel.org,m:santoshkalluri129@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,remlab.net,kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[remlab.net:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA89069AB62

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
---
 net/phonet/pn_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index 5a8f3a7c2a6c8a..84e6558f47a9fb 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -105,7 +105,7 @@ static void phonet_device_destroy(struct net_device *dev)
 		for_each_set_bit(addr, pnd->addrs, 64)
 			phonet_address_notify(net, RTM_DELADDR, ifindex, addr);
 
-		kfree(pnd);
+		kfree_rcu(pnd, rcu);
 	}
 }
 
-- 
2.53.0


