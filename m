Return-Path: <stable+bounces-267551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dnWXATXsN2qxVgcAu9opvQ
	(envelope-from <stable+bounces-267551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:50:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 852B06AAFA4
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:50:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EoozgbFM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267551-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267551-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01CEA3037D44
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 13:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CCB288C96;
	Sun, 21 Jun 2026 13:48:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218B29443;
	Sun, 21 Jun 2026 13:48:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049683; cv=none; b=DdsK8gkWMqxT4+A+UnJek5sZjQsCzKN5GVvba9uriuJnyrZrZuak04SfMeP2iBn9s5PNTIk11YQBXQi75ZwknZ7Eg2cIV/waGGnG3u40rZOloK+1mXbBLiNB5n9DLn1VFyjsD+T7HWJOd/mYaZQKdJIBNF7bB3tUyAOp9GxI31M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049683; c=relaxed/simple;
	bh=bloBjJx0axVh0a44uL+s7DyRBExTx6YKWBHDUaDYLik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fq+G9fuXfo1Ushcy1sOMH3XNUQkxlTOsw7alsIXkGTu+LdLZwErObJoFa0Vxrs0mlRVE4yaJUzVDc1CxRyNx4M7WgOLbI6LOAaNYOJwSW53Yalkz186NR3OWS5J1xZUAFyOwPt1g62BWflOA1KVvbebnmh8pTG+teU2mHBMkGOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoozgbFM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CDF1F00A3E;
	Sun, 21 Jun 2026 13:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782049681;
	bh=bloBjJx0axVh0a44uL+s7DyRBExTx6YKWBHDUaDYLik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EoozgbFMZ4995amEUua5eRK2GPrLhmu9bIVUhn5HC4+YsS7Jk7nyW5W8Af3E3lIg6
	 Zl5pdzNodbU/wObx4D/FVtHt7SgJuSD58qhOS+LN5F23BcVokU2mp36CnnMpK+apuZ
	 jx/USJc7KgV6AX2fDZqSH0u4hyPuDgLDQqAIyNfrlx2pwmn0xO74HjqwhGQx+S772a
	 f3o3kU8ffJp7canWMaz/lxLOpytIh1xDKVtIWAPzCwyHwlh2W7XCpKy3sSL+5z0EI+
	 /dcyfWlJNsoKMmnwEQvEsd7pC8ShocNSTSxdV2r57x1hqlM48sB64nsG+bRXOB3GxG
	 3+IHpq3YcvjTg==
From: Sasha Levin <sashal@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.1 208/522] net: Annotate sk->sk_write_space() for UDP SOCKMAP.
Date: Sun, 21 Jun 2026 09:47:46 -0400
Message-ID: <20260621133722.0008.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061944-vaseline-essence-0008@gregkh>
References: <20260616145125.307082728@linuxfoundation.org> <20260616145135.793184452@linuxfoundation.org> <6f805abf1f8b058c1b1241e8568d7539185145df.camel@decadent.org.uk> <2026061944-vaseline-essence-0008@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267551-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ben@decadent.org.uk,m:sashal@kernel.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:kuniyu@google.com,m:jakub@cloudflare.com,m:kuba@kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 852B06AAFA4

> > That other commit hasn't yet been backported to 6.1, so this is not a
> > complete fix.
>
> True, someone needs to provide that backport as well :)

I looked at backporting the write-side annotation 2ef2b20cf4e0 ("net:
annotate data-races around sk->sk_{data_ready,write_space}") to 6.1, but
a straight cherry-pick drags in four drop-counter/scalability
infrastructure commits as Stable-dep-of (sk_drops_skbadd, sk_drop_counters,
the raw-socket and NUMA softnet drop_counters work). That's far too much
feature churn for what should be a small data-race annotation, so I'm not
queuing it as-is.

I'll either prepare a minimal hand-crafted backport of just the
WRITE_ONCE() annotation in net/core/skmsg.c (the part that pairs with the
already-queued b748765019fe ("net: Annotate sk->sk_write_space() for UDP
SOCKMAP.") READ_ONCE side), or we can leave the read-side
annotation unpaired for now. Leaning towards the minimal hand-crafted
version; will follow up.

Thanks,
Sasha

