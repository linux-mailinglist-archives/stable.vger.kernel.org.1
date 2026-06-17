Return-Path: <stable+bounces-266662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9EUQNUJaMmrSywUAu9opvQ
	(envelope-from <stable+bounces-266662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 10:26:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31179697870
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 10:26:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="DRPm/eTR";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266662-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266662-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C52A3015724
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 08:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C6E381AF0;
	Wed, 17 Jun 2026 08:24:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B8282F2C;
	Wed, 17 Jun 2026 08:24:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684676; cv=none; b=j4MhW9hvbPPcW+Y1cxxmXCBJXvG0o5zSdCsE5mNde5XVvda63gMbnKVuRl78kBguA5Px7j5zHd50Uln/BADF5x/FPmoNEwpgIDbbKN3VZx++vxWG6rSqdZ58d4NufgbP1Yln2ZV/S0zbX/e/A5z37owvytJ8ZxWt8fGuHogLi+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684676; c=relaxed/simple;
	bh=Ia+WBLNubbgfk6u6UMis03irVIVdyTkRNpTAU9YO3ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qq3u8I8VJw7Q5acUvYApWP0LzPNH9Aeb4T8cqaWI2Mq4p5mW8JWgx8Z14oyAT8pXRRUMZnvrMdnDZiGbVyprq+19UiFhfMclAa7nNsw3EYF+1kcVYjyL2gW5YXkcAk+drqlqHQWqaAbhgQag2h+MyOpslJKj85rbICkz4Ox/Xyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DRPm/eTR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E1E1F000E9;
	Wed, 17 Jun 2026 08:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781684675;
	bh=fudLAflm4+0mzNxCNzDM+yWfJX5wGOcrgBqc39zl7l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DRPm/eTRVg7GvXBj9FwfIi5JyyfyVrxuBVNM+wxrdnx1YzccA1xF1qXANPqDHrwsL
	 OzowMt5sp1TXP9Fw/zrFaSm1K0ZC8Z8gTg3ulqjs5olPh9nUMMisKrWx2G7l9bWEPU
	 eX8vWNf519tI/Nq9qSWdMnxrS6xFHAFPRc/7oLv8=
Date: Wed, 17 Jun 2026 13:53:29 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 054/522] selftests/bpf: add generic BPF program
 tester-loader
Message-ID: <2026061719-danger-ensure-f276@gregkh>
References: <20260616145125.307082728@linuxfoundation.org>
 <20260616145128.305073045@linuxfoundation.org>
 <b6b679743c2383b5a367c5d72404b056dfebf080.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6b679743c2383b5a367c5d72404b056dfebf080.camel@decadent.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266662-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ben@decadent.org.uk,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:ast@kernel.org,m:paul.chaignon@gmail.com,m:sashal@kernel.org,m:johnfastabend@gmail.com,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31179697870

On Wed, Jun 17, 2026 at 10:01:56AM +0200, Ben Hutchings wrote:
> On Tue, 2026-06-16 at 20:23 +0530, Greg Kroah-Hartman wrote:
> > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Andrii Nakryiko <andrii@kernel.org>
> > 
> > [ Upstream commit 537c3f66eac137a02ec50a40219d2da6597e5dc9 ]
> [...]
> 
> There seems to be a fix needed on top of this: commit f00bb757ed63
> "selftests/bpf: fix to avoid __msg tag de-duplication by clang".

I tried it, but it didn't apply at all :(

thanks,

greg k-h

