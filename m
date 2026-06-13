Return-Path: <stable+bounces-263012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4gpLF5duLWoHgQQAu9opvQ
	(envelope-from <stable+bounces-263012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 16:52:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D519F67ED3B
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 16:52:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VsMDz5r2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263012-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263012-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58F70303ADD7
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AE0332EC8;
	Sat, 13 Jun 2026 14:51:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94092332EA0
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 14:51:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781362302; cv=none; b=HICCyeoExTrEyBpINaoGvCoS253YDJl5AOFajqijVFluwNiZbLyHZVc15gSUVZkIlwebXjxZRxvXZiNGnmG8ZG4z62j+OzA478D9tiPiFXfFPL0LTbY5Y0LFI+472DgJDPmS0G42ahIbtntXh+T8QjVV6M1D78pIED1l43RLSgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781362302; c=relaxed/simple;
	bh=ld2UUu0GoEg8zq6jL6xt6HQYlRXCdhhqJqHYQbiaHGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPwQfHUfQE7C0cgG4u+RcaExUVML9JTSgupmMoeclvTpcf3XryVtWPilQDzBaUc0awKunMVjFSRV26/dM8sx8OzA1s4hIkIALExjmrfAWjXsiqyxC3QXVRWvK5TUjf4fO0N08RTqJUdcrc8uKNl3h6xSbQa84zX+2ygPVzaoHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsMDz5r2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EF61F00A3A;
	Sat, 13 Jun 2026 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781362298;
	bh=ld2UUu0GoEg8zq6jL6xt6HQYlRXCdhhqJqHYQbiaHGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VsMDz5r2PQKGx7VPIl+jshxIigddHCJODgSwdZQhw7osC+xFaNj3NMFcKnnAX6T/m
	 +Y1sTwxj7UFnhXqDrBE4HTpaOHrgI1s3fX2SFgIa3xi1w1lzrtWuxFJ0s1gAvDT0pT
	 p9yq/7LUbVxKG1PHb1nraQPeFajZrzl2tJEGlPMvs8kINt+IGBnOu5rYJBkCd23Bn6
	 ApzHK/y0eJplncdCrW/tZCrEa4SPtFnwLZv/mQY4q5BcXoBNCwnqAc7IyhQe5w8koo
	 N0Ydef3cmCyOqtBN3yb0kLzoRHRr1h573F5KvU6JRPtxd1ZlNtEy/NTklZoPUczlDU
	 H9Tz+KCuJJ7jQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: Re: [PATCH 6.12.y] netfilter: ctnetlink: ensure safe access to master conntrack
Date: Sat, 13 Jun 2026 10:51:27 -0400
Message-ID: <20260613143001.0002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612190705.909607-1-mkbund@amazon.com>
References: <20260612190705.909607-1-mkbund@amazon.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:mkbund@amazon.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263012-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D519F67ED3B

On Fri, Jun 12, 2026 at 07:07:05PM +0000, Mark Bundschuh wrote:
> From: Pablo Neira Ayuso <pablo@netfilter.org>
>
> [ Upstream commit bffcaad9afdfe45d7fc777397d3b83c1e3ebffe5 ]

Queued for 6.12.y, thanks.

--
Thanks,
Sasha

