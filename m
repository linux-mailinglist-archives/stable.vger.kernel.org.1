Return-Path: <stable+bounces-266767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /RgtKzymMmq83AUAu9opvQ
	(envelope-from <stable+bounces-266767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:50:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D85069A43B
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:50:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=axybJh57;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266767-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266767-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BF14318811F
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 13:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449B41A5B9E;
	Wed, 17 Jun 2026 13:46:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772113D53C
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 13:46:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703966; cv=none; b=NMVUdoDI13h7DcjjIOJyddrePtbQtoDwVMjynKLYUWz4+tgva5Ev9v+J5cora01PvPqAh9xy0p8BaO7QpD0biTruxKwHGQYABzwiKVGU3fPbOm2OJJyrAQBCNd8JvuEyCkpur1JhJQu78qAbThK5pHa6f5XhAdMWoPz7aw8pXpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703966; c=relaxed/simple;
	bh=soBzkDfVP5l9QPqwRIHU8BeiyDkl8OfYWbIGvLLuB9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRuH2LPItqWl0P3F7k9Qx331rTk+R3q6LfP7KntcjkLAucIZWOrxpKQpK2hTsI8+Q4HnTXQFQOTfqChCgWCFuGmFRplM7ZqUxXRTJU7wKKl88juXD8aiqPw4JRiyJX0ag9Xm5XfCQ2vaYLuzKvnj5g6YpY7RMAyx2E9j+VtLBDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=axybJh57; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34C41F000E9;
	Wed, 17 Jun 2026 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781703964;
	bh=wt8sQsBFtKaL9+ddjigbIPW8SUOk8N9h3GcYASJ5ues=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=axybJh57woBWrWqg9wGrwS8w6meddjZbeJin1DFGHyxfiNMAcjph5Upk3/woJR9Z9
	 1rNOtSXe108JB9D4MNwlVxCIOC0Rmgqh9odEK2+Wi0FBkDeKnwQXpqCGOh5WEwqW2V
	 pYhb+kk/A1pM8bXQzv4PPp9MZkS1/HtE78pS7ldk=
Date: Wed, 17 Jun 2026 19:14:57 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: Vulns DB is missing information for CVE-2026-31456 in 6.12
Message-ID: <2026061712-grievance-enjoyer-3ce1@gregkh>
References: <25098130.ouqheUzb2q@diego>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25098130.ouqheUzb2q@diego>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266767-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:heiko@sntech.de,m:sashal@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D85069A43B

On Wed, Jun 17, 2026 at 03:29:59PM +0200, Heiko Stübner wrote:
> Hi,
> 
> not sure what is the correct procedure for reporting such things and
> didn't find something in the vulns.git .

Normally just email us at cve@kernel.org but this works for now...

> Fixed in mainline in 7.1-rc1 with commit 9b25a6e3d243 ("mm/pagewalk:
> fix race between concurrent split and refault")
> 
> Seemingly backported to 7.0-rc6 as 3b89863c3fa4 ("mm/pagewalk: fix race
> between concurrent split and refault").
> 
> This fix got backported to 6.12.84 with commit
> 138ada1337b4 ("mm/pagewalk: fix race between concurrent split and
> refault").
> 
> The vulnerability DB is missing that entry for 6.12 though, probably
> due to different commit ids floating around.

Yeah, duplicate ids for the same commit.  I've fixed this up in the repo
and pushed out the new json update, so all should be good, thanks!

greg k-h

