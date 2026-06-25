Return-Path: <stable+bounces-268331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vN2IAAQGPWq2vwgAu9opvQ
	(envelope-from <stable+bounces-268331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:42:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C78156C4B9E
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:42:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q887776v;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268331-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268331-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EC7E301832B
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C7E3D332C;
	Thu, 25 Jun 2026 10:42:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CB538A72A;
	Thu, 25 Jun 2026 10:42:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384129; cv=none; b=C0vzENsIdwULSA1X/H97c4VSXPjUMj1ykFeuQ6CC5PJi39XlBvmJrPEm25Qh6/taV5eArKTpxoHEXv+JTnIbagvh76y0+Ago7S5JRok9yF768V8GSOH4+3hz6AEgNiIelGOPXeRpLf/pxZTiK8sFP61DoV9uyhJcfJMWWtqclIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384129; c=relaxed/simple;
	bh=RJbzB444OWrgTxvsYUH/llEvnk5lqYsfA9FXH00KzmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoNn8mcbkSbO2tR2ro0C+2BCWi3Rv7OWakcbVv1dagsxTGQvkj2kGhU7VUxB7ppYEkPfpTyESDcQcNAvj7fwZwp2A3HFanpLkGsemGCLcI14k0Hc0VUEkT+eFO/Kg6sB/k34uVCBMOqFhgZutKS4RUE3zW3s5xUIkJ1SJN4qhyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q887776v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED841F00A3A;
	Thu, 25 Jun 2026 10:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384127;
	bh=RJbzB444OWrgTxvsYUH/llEvnk5lqYsfA9FXH00KzmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q887776vUMG3Au1XXl8ruHpHXSLJBXoTWwGgBC2GkpS76taI0r3CtcP4ONfBYk0nl
	 MxnT4LvMooak966yROgF84LrHgXNQY3kPj+pD6X6EE/zdpGN2h7APaImin06wg/9fL
	 xezZOLja3iQCVI4KQDn2akVUNMa/N0s2MyxA+mUJ3rn4kX5uiPnKybTWxrYjhkaQ6Z
	 EiMBGA2r5pofOQ1UA4JN+Wl5yaa1vfibz0LjwsLtt+AtXBbOGH+lgVUyE0rOkJyMav
	 fM0HYtPGNwwJqvM/PfdgpSxDbf3cCJd6ckYgeoLZV73YHaUJpkfsFK9Vfn8I1OvcRr
	 YTEppl7KhC46w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Martyniuk <alexevgmart@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	netfilter-devel@vger.kernel,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH 5.10] netfilter: nf_log: validate MAC header was set before dumping it
Date: Thu, 25 Jun 2026 06:41:50 -0400
Message-ID: <20260625054005.0003.nflog-510@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624140117.19799-1-alexevgmart@gmail.com>
References: <20260624140117.19799-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268331-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:alexevgmart@gmail.com,m:pablo@netfilter.org,m:kadlec@netfilter.org,m:fw@strlen.de,m:davem@davemloft.net,m:kuznet@ms2.inr.ac.ru,m:yoshfuji@linux-ipv6.org,m:kuba@kernel.org,m:kaber@trash.net,m:netfilter-devel@vger.kernel,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,netfilter.org,strlen.de,davemloft.net,ms2.inr.ac.ru,linux-ipv6.org,trash.net,vger.kernel,vger.kernel.org,asu.edu];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C78156C4B9E

> [PATCH 5.10] netfilter: nf_log: validate MAC header was set before
> dumping it
>
> --- a/net/ipv4/netfilter/nf_log_ipv4.c
> +++ b/net/ipv4/netfilter/nf_log_ipv4.c

Thanks for the backport - the retarget to nf_log_ipv4.c is right for 5.10.

One gap though: upstream fixed both loggers via the consolidated
nf_log_syslog.c, but in 5.10 the IPv6 logger (net/ipv6/netfilter/
nf_log_ipv6.c) still has the identical unguarded fallback and is left
vulnerable here - which is also Pablo's "why only 5.10?" point.

--
Thanks,
Sasha

