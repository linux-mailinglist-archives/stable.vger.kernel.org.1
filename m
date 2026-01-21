Return-Path: <stable+bounces-210800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ5YBj8vcWmcfAAAu9opvQ
	(envelope-from <stable+bounces-210800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:55:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E965CA5E
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D94D8485D9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8942C0296;
	Wed, 21 Jan 2026 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="18Y8Buq1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91A62571A5
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016028; cv=none; b=FToN/ZOA7L0wB+4u2dG+CwVglh20RzO2J+5eR4BUFMnRqlY3Gqt0Mv5gdKucNsbwEXLAFMnhuhmcsxshCUiPF2h62JEMHJ2b15AQUvW1Cc3Mm1bdd5okLv1XW9iU28SWjsFoH5fAf/YrlKBiEQndHWWxH0jTsrdvJ3ZRbKyhkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016028; c=relaxed/simple;
	bh=99HX4DGX3sGtlVTAMsVGJoJNZZ8+/2bibH4B8RBgPeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsNnX+G2TnkBSGZyz5GAJ0TyARrrPTJi27LT7nMJuUC3u9Uc5tdATzFgj4j3GJ8z1cW3bJ8wZzMdauKIja1KgiTrOINYrw0KxjURr/YeOt64z9BCbtL+4Dbaah74YfbPPjOteVzU8OVMo3yytMzOtGyZXDQsrBPf3QaEd6SQ7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=18Y8Buq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8278CC4CEF1;
	Wed, 21 Jan 2026 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769016027;
	bh=99HX4DGX3sGtlVTAMsVGJoJNZZ8+/2bibH4B8RBgPeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=18Y8Buq1x9IZuUXu+ClNtxhC8lp4EeznVbCMtgkH0FF95u6XPObKLPQAaT3fo3xmt
	 VSOtiYoUFvZzeCZAfehAy6bcexodtvECWUP2SFFOk7uBYEk9dVUBh+tGGnCjyZvAF5
	 ZWK2IMnP/ZtqtUtxhUGdrqzvvTnVycA/K1Rryulg=
Date: Wed, 21 Jan 2026 18:20:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [REGRESSION] v6.6.120: i3c crash caused by commit 82a09b9965ed
Message-ID: <2026012102-anyplace-moaner-3197@gregkh>
References: <d0a7accd-3d7d-41ec-b85e-469adf156a91@socionext.com>
 <2026012139-fidgeting-comic-916c@gregkh>
 <202601211657387e890711@mail.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202601211657387e890711@mail.local>
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-210800-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[ams.mirrors.kernel.org:server fail,linuxfoundation.org:server fail];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E4E965CA5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 05:57:38PM +0100, Alexandre Belloni wrote:
> On 21/01/2026 15:56:01+0100, Greg Kroah-Hartman wrote:
> > On Wed, Jan 21, 2026 at 08:04:03PM +0900, Kunihiko Hayashi wrote:
> > > Dear stable maintainers,
> > > 
> > > After updating from v6.6.119 to v6.6.120, I noticed a kernel crash
> > > when I3C was enabled.
> > > 
> > > This regression is caused by:
> > > 
> > >     commit 82a09b9965ed ("i3c: fix refcount inconsistency in i3c_master_register")
> > > 
> > > The issue is resolved when the following upstream fix commit is applied:
> > > 
> > >     commit 3502cea99c7c ("i3c: Move device name assignment after i3c_bus_init")
> > 
> > That does not seem to be a valid git id, where did it come from?
> > 
> 
> This has not yet been sent to Linus and my plan was to wait for the
> merge window as the fix didn't make it clear this was actually happening
> in the field.

So we are bug-compatible with Linus's tree right now?  Great, all should
be fine :)

thanks,

greg k-h

