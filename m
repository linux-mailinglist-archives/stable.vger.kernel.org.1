Return-Path: <stable+bounces-270788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sYFHOIGTRmqQYwsAu9opvQ
	(envelope-from <stable+bounces-270788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:36:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 931736FA47E
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:36:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Ith1IYiu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270788-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270788-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3AED3046153
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB66535E1CE;
	Thu,  2 Jul 2026 16:30:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19E35E1C8;
	Thu,  2 Jul 2026 16:30:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009853; cv=none; b=YYNTuV+Q2AA/A70aeH0B+1jrvaOauRy7r+06koq3RirMDUllw2g1FWyUXAlhSvEoF1VEZDuAQxQ+D7mSNi1f36uTmex37rh6NhSsr1B4u6msr94skail3jMotB6PFZbWhJ6Ycdr39AuVCYEWB2s1QZn4+7UhPvEjX22B9oWyQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009853; c=relaxed/simple;
	bh=UmAtH9oO5DFJMzXbEnHdUsagx2AQw3IuG3r2BJsF1SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTzey17z3ZtzqnOzVIxKsD/qLYUnrueCxLd7uMQ/OL54Z1El6/nlmUxxXCpW/y6r9fnNkadVnErbLi4aIToIimVjxL+PS6Yybxhq70F6r7Ijd6BHzZW9Ay9LJXlTcOIOA9qvfvENlH0J92GuZegCTiNjB8c2Z0RGu65zaUdKclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ith1IYiu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B4D1F000E9;
	Thu,  2 Jul 2026 16:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009852;
	bh=gXDwPn4U+RmsYHdO0YpmyHPakXAQNOU26T7fgwQ9tXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ith1IYiuoMOcaiJJtAQjMQJMZN0pQH0qIVQA6LV6jdCRINSaZgY/r8PWVOiHut7Qz
	 of+L2bx2UKgpDs4MmgKFPdecCz2lEGrsAL2XT1G2X3wk2BzHmq5hRL38VsxtRC0MST
	 lUn4Y0Quo90MIZeo0aaJ9TYBvVy+otjSl7ZUg0AU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Noam Rathaus <noamr@ssd-disclosure.com>,
	Eric Dumazet <edumazet@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 009/129] ip6_vti: set netns_immutable on the fallback device.
Date: Thu,  2 Jul 2026 18:18:48 +0200
Message-ID: <20260702155112.355933028@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270788-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:noamr@ssd-disclosure.com,m:edumazet@google.com,m:steffen.klassert@secunet.com,m:nicolas.dichtel@6wind.com,m:kuba@kernel.org,m:carnil@debian.org,m:sashal@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,6wind.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ssd-disclosure.com:email,secunet.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 931736FA47E

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d289d5307762d1838aaece22c6b6fcad9e8865f9 ]

john1988 and Noam Rathaus reported that vti6_init_net() does not set the
netns_immutable flag on the per-netns fallback tunnel device (ip6_vti0).

Other similar tunnel drivers (like ip6_tunnel, sit, ip6_gre, and ip_tunnel)
correctly set this flag during their fallback device initialization to
prevent them from being moved to another network namespace.

Fixes: 61220ab34948 ("vti6: Enable namespace changing")
Reported-by: Noam Rathaus <noamr@ssd-disclosure.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Link: https://patch.msgid.link/20260608155918.787644-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Salvatore Bonaccorso: Backport for version without 0c493da86374 ("net:
rename netns_local to netns_immutable") in v6.15-rc1 and without
05c1280a2bcf ("netdev_features: convert NETIF_F_NETNS_LOCAL to
dev->netns_local") in v6.12-rc1 and use NETIF_F_NETNS_LOCAL device
feature.]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_vti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 8808067df5168c..aa37ce710cf49a 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1168,6 +1168,7 @@ static int __net_init vti6_init_net(struct net *net)
 		goto err_alloc_dev;
 	dev_net_set(ip6n->fb_tnl_dev, net);
 	ip6n->fb_tnl_dev->rtnl_link_ops = &vti6_link_ops;
+	ip6n->fb_tnl_dev->features |= NETIF_F_NETNS_LOCAL;
 
 	err = vti6_fb_tnl_dev_init(ip6n->fb_tnl_dev);
 	if (err < 0)
-- 
2.53.0




