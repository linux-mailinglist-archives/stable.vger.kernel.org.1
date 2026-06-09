Return-Path: <stable+bounces-262151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m8QWJYVkJ2qKvwIAu9opvQ
	(envelope-from <stable+bounces-262151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:55:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DC065B79A
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:55:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lGkWL5D5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262151-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262151-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C61513061014
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 00:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0532F6586;
	Tue,  9 Jun 2026 00:52:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C272EEE60;
	Tue,  9 Jun 2026 00:52:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966343; cv=none; b=TFewzwOOIh95orBggorKsafaHCD0zj4emn4gQlsZMX978yWXtv/3sfLhKcxwXnaj/icMizMzP1zUPhgaeRYOQ0631d0xQLWoNbrLh6NrIieQW58OZih9cRU5bzOLmgauccKp7rIAiKBZLNiHOnQyqhUVEN/vHVW98t+UiWLUYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966343; c=relaxed/simple;
	bh=nsjCiLewUQnyThO/nk3vegxsepbxGCb1ZuGqp/NqJp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyVfcuQvIy3w2q7UPahIfhtF7MJ9korN0WdOYyBvioWVU1/BiPQ8XIibbpQfvB/3RMIS+R54ENny8TdgMql9P67iF/3sgLNMXZZ/5KARMHdG7VKnOhQ/d79vaT6U77WCwvzmi0YsTDZbiqdB4Si25qGFNGvvQkQXI/rDHVMiaPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGkWL5D5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF8F1F00899;
	Tue,  9 Jun 2026 00:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966342;
	bh=Lc0hJgnYhv04evvGi5aODLz+6yXOmwINNyB7mNxpGvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lGkWL5D5tEnCfZm9gL+fCLycFNvCrsCAV2KhPYPlg4kIJV9TC+uk16i1pDq5Nd0Xt
	 Q+wvGxJDjPm1ikIeaWXc0Q3hSPQQnH10uyFe6FytvAre2ch43nV9R/Oi/BRaImhJtL
	 Kb/kbM0UO2i6BUlOH+P0tlFeLYZEsrFZvzmotiYKPuJViYv65Ieb9nfFNOFEMnhcjh
	 UmezEdM245NpKkZYQMsSPoJYF3eUeSBSmYVxjcKxi6DnqlmqnXIgqr7lQGDqUmcjJl
	 QApSpWYmYw1yBKtyKYD1cBwYb2G6vNr4m9UuPA8OicWVYfV5FPF1ouwiM4gRZV3LJ/
	 C9Qrxc5u3hhXg==
From: Sasha Levin <sashal@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Simon Liebold <lieboldsimonpaul@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Qi Tang <tpluszz77@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Simon Liebold <simonlie@amazon.de>
Subject: Re: [PATCH 6.6.y] xfrm: hold dev ref until after transport_finish NF_HOOK
Date: Mon,  8 Jun 2026 20:51:58 -0400
Message-ID: <20260608-stable-reply-0012@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608082454.2786663-1-simonlie@amazon.de>
References: <20260608082454.2786663-1-simonlie@amazon.de>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262151-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:lieboldsimonpaul@gmail.com,m:sashal@kernel.org,m:tpluszz77@gmail.com,m:fw@strlen.de,m:simonlie@amazon.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,strlen.de,amazon.de];
	FREEMAIL_TO(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82DC065B79A

> [PATCH 6.6.y] xfrm: hold dev ref until after transport_finish NF_HOOK

I'm holding all four of these (6.6, 6.1, 5.15 and 5.10) for now.

As adapted, the backport leaks a netdev reference on the nested transport-mode
path where both an async and a sync decapsulation happen: the inner dev_hold is
balanced by a dev_put that the older trees don't have, so the saved reference
is never released. Mainline avoids this because it has b05d42eefac7 ("xfrm:
hold device only for the asynchronous decryption") as a prerequisite.

-- 
Thanks,
Sasha

