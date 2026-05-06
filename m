Return-Path: <stable+bounces-244357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGh4F4sN+2mbVQMAu9opvQ
	(envelope-from <stable+bounces-244357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:44:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D0A4D8D35
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F26053029773
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F623E3C45;
	Wed,  6 May 2026 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="C944XhX5"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263433DDDB1;
	Wed,  6 May 2026 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060387; cv=none; b=CkWt9ONK2FegATPBVS4TLi3p3F4iNJpYsWR8t1vEIXafh/zEovn9ElckfSEnB91jTRuaDyzY0qpNOsdxhp+orG6iUIe0wgUOYyt4JQcjMJ1S2BWUv40Sgl0xbrTXrpBmcB/ZJClGCkYFCS1m+4SpOBbw2K7Mo57Lc72Dpu4Ydhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060387; c=relaxed/simple;
	bh=h6m+ghxy1h/+irv9PhRDK5japHTZ6CbKeeqCDu05sk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LII3cUOKvAHw/AbJO1K0sx6vV2S5dVZHkN4plRRuyQNxjw8d60Z3DpwoeTeRvHq4r1UWdjPzIbqfDmztb2B7BP5lm2kT/PhDgEVHguXMQNUl+asPURHifkk0lG66G1J6wt9ZkdEB8bKrVkJoWWJWLDmYrK44mqrRDMb8G2ME2rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=C944XhX5; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ilqncLxDv9KwHIALy4qNC3lzSPjPqxEqi2WTd/zHXvM=; b=C944XhX5N46zrMKMCe9vRGJC/y
	OpdvtAVav6O/qyUK7My0USCXKXAgqXD9mynBb7NhldKKHyCe0jJG9rELqCKlrofdMuj19qSyl58qW
	rKnxyK8hmi5aCnn4TLzniSkGylIhMnomXBHPfcBAHPsVOP/215d17gtkYRzUSdrumPF/cgnf7cSbr
	wQ/UU8EIDo6EU4sKx1F7ZVfgSiLPYLHKvGUfIrm6xpyuMrHOQpcin7XeCJxDvzvry/ffunkQANf6A
	lF0XtPLOeoiqZE754D6jHtaxY752S6b6BboOyuFjgUW0GalEzE70knaMMbz66cxJKbgNmzVIkz8JZ
	AHeICD6Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <carnil@debian.org>)
	id 1wKYj5-003UrJ-0J;
	Wed, 06 May 2026 09:39:31 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id C1354BE2EE7; Wed, 06 May 2026 11:39:29 +0200 (CEST)
Date: Wed, 6 May 2026 11:39:29 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jiayuan Chen <jiayuan.chen@shopee.com>, 1135514@bugs.debian.org
Cc: Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev, stable@vger.kernel.org,
	podorski <podorski@gmail.com>, Brad Barnett <debian-bugs5@l8r.net>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: Bug#1135514: [6.1.y regresssion] 9a95ec9144ee ("xfrm: fix
 ip_rt_bug race in icmp_route_lookup reverse path") causes log spam on ping
 to unreachable host
Message-ID: <afsMUZa99G_gsve1@eldamar.lan>
Mail-Followup-To: Jiayuan Chen <jiayuan.chen@shopee.com>,
	1135514@bugs.debian.org, Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>, regressions@lists.linux.dev,
	stable@vger.kernel.org, podorski <podorski@gmail.com>,
	Brad Barnett <debian-bugs5@l8r.net>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
References: <177771348699.1898023.16904466444228860838@eldamar.lan>
 <177768508393.32886.13183514325428485879.reportbug@pjp3.podorski.net>
 <CAL3Ev5070_=K9F9+03GrE2+4tgr=j_CO19=m4ZPTd17YSwmokQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3Ev5070_=K9F9+03GrE2+4tgr=j_CO19=m4ZPTd17YSwmokQ@mail.gmail.com>
X-Debian-User: carnil
X-Rspamd-Queue-Id: B6D0A4D8D35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244357-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com,l8r.net,davemloft.net,google.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Jiayuan,

On Wed, May 06, 2026 at 09:04:24AM +0800, Jiayuan Chen wrote:
> I think it because we failed to backport  this patch before:
> https://lore.kernel.org/stable/20250207161555-b1a8749027831a1a@stable.kernel.org/T/#m0c880c1f04f7211aea9b7f6b4de0b64aa1726417

Which won't apply cleanly, I assume this was the reason it got not
backported to 6.1.y. Do you have a backport of that, or should the
original commit introducing the issue be reverted from 6.1.y?

Regards,
Salvtore

