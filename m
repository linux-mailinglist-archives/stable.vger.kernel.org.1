Return-Path: <stable+bounces-263877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5SvVH7xpMWr8igUAu9opvQ
	(envelope-from <stable+bounces-263877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:20:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A6A690EF1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:20:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=iRTyHetq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263877-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263877-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E88A304495E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E71C3375C5;
	Tue, 16 Jun 2026 15:15:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443443DA56;
	Tue, 16 Jun 2026 15:15:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622942; cv=none; b=QFkd9s/Zs335l4THJJUUVMXD2RHFZH3VZUYV8vcxApcqx+vWQHfhx/icdhmdApIGoFZ4eQlhdnEKn9fMYGm1GwtoaR7w5j0ItfZI8SJaNVG+eGsWqUkzJ81QloH3eEEQ9Yc44ke0yBe43UH6c7i0sgvyrrP47+PPDh4ofZMgGR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622942; c=relaxed/simple;
	bh=60xAuKGInUl3P7PMu0lq2zAWVia9KzwzQrvZdeP9e04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcuM6sFOpoUg2C2C6laauqoSWMh0PI6luw1NmPk751P0UnvLcEFJ5iK+rXCv8bIrLD/acdyfS8jHO7upBeKF97s8UaXr/pdnRuHKvmxREeAixGM9jSBOJNwL2krjEV6Gc6Z+jk86oAQNBnxJjwp9UO+4kAMNAQ+4kIkfCQE2aSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iRTyHetq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3220E1F000E9;
	Tue, 16 Jun 2026 15:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781622941;
	bh=lx8PFpJMiiHy+4WglP0bu7h34/phgFdovUS1r+FBVDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iRTyHetqY7wm+C+Wp3jIkLLhSY+/5PeCQM0rhF+AFN71g1yqTL2T954wX4bvfo1UP
	 lkLX1fV4w07+r1OY78JOuEhbjaZ9gp9bWUmNGTkfgqu2kbh6PPE2ALnONdpLYywSHg
	 QwpcNc8m1E9WJ8eJ9B97gbDdG8U4dtdM0XUOn0oE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tamir Shahar <tamirthesis@gmail.com>,
	Amit Klein <aksecurity@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 058/378] ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
Date: Tue, 16 Jun 2026 20:24:49 +0530
Message-ID: <20260616145113.031603304@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,google.com,kernel.org,nvidia.com];
	TAGGED_FROM(0.00)[bounces-263877-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:tamirthesis@gmail.com,m:aksecurity@gmail.com,m:edumazet@google.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,nvidia.com:email,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1A6A690EF1

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d3915a1f5a4bc0ac911032903c3c6ab8df9fcc7c ]

This patch restricts setting Loose Source and Record Route (LSRR)
and Strict Source and Record Route (SSRR) IP options to users
with CAP_NET_RAW capability.

This prevents unprivileged applications from forcing packets to route
through attacker-controlled nodes to leak TCP ISN and possibly other
protocol information.

While LSRR and SSRR are commonly filtered in many network environments,
they may still be supported and forwarded along some network paths.

RFC 7126 (Recommendations on Filtering of IPv4 Packets Containing
IPv4 Options) recommend to drop these options in 4.3 and 4.4.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Tamir Shahar <tamirthesis@gmail.com>
Reported-by: Amit Klein <aksecurity@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260602161547.2642155-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_options.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index be8815ce3ac242..09d745112c1526 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -530,6 +530,10 @@ int ip_options_get(struct net *net, struct ip_options_rcu **optp,
 		kfree(opt);
 		return -EINVAL;
 	}
+	if (opt->opt.srr && !ns_capable(net->user_ns, CAP_NET_RAW)) {
+		kfree(opt);
+		return -EPERM;
+	}
 	kfree(*optp);
 	*optp = opt;
 	return 0;
-- 
2.53.0




