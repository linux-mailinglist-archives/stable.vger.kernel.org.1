Return-Path: <stable+bounces-262043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vK0nNibPJmqpkwIAu9opvQ
	(envelope-from <stable+bounces-262043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 16:18:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72696657111
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 16:18:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=LLaZohXL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262043-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-262043-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 647C9303C907
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 14:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7FD3C457F;
	Mon,  8 Jun 2026 14:13:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E091E5B63
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 14:13:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927984; cv=none; b=s63d5xQPRP7cFsTg9abYqFREnR8u18gOg7osiQcVGSlV8RIvxVrFVsLgcS/5mKbkkYEwuLSFNcQwQGqkjucFVyjIYt0pO/FJhqnqmVfhJLPZkcAclvNKveRu3OnAtEd0yJEZ0AEB8JhdRn8aX30CkVDC4iCy8AsYUDm9HIdAkR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927984; c=relaxed/simple;
	bh=fYWMMlTWsZBdDOkaivNppZ3JKzflfDa2GHVt+MAFj3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o64ajFmP7y8eacFVl+Kamf13RNBqgrUH+21hhlEHUkOAIlPqeBGRVS3Rm3OgecST1RYuf1YMB0ajqljn04SDyX2R28nAzO8IeGQbeOHEb+tg5Ge4nuJqzIAyVLS5H9517QyDPHJLh16SHNYtWmXz03lpD6vij7ShfPjCLlTLaxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LLaZohXL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0766F1F00893;
	Mon,  8 Jun 2026 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780927983;
	bh=vRxLlxgtv49yThNDJjZj+u0T4tKRy5pFjIWLLHPYj04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LLaZohXLdqDt2VDERAmFyjPwBvq+lxTWS/jHUJzlO6uAlmXKEqGVwDnMMaS1bbjMn
	 IhQflL0qdOhSl13g7BtjnIRiKnLAazGLjFcqW860v6+CfWFpWZ2p2x0XPdpPQQhmPW
	 9Q4CBrLI/SILKGZ4KlvQvOwMss0ltbkb/TqjLxiA=
Date: Mon, 8 Jun 2026 16:12:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org, Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 0/4] ARM: stable backports
Message-ID: <2026060832-extortion-cattail-2467@gregkh>
References: <20260511135357.2786242-1-bigeasy@linutronix.de>
 <20260608082818.LZiPJ9ot@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608082818.LZiPJ9ot@linutronix.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262043-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:stable@vger.kernel.org,m:bb@ti.com,m:daniel.wagner@monom.org,m:jan.kiszka@siemens.com,m:cip-dev@lists.cip-project.org,m:nobuhiro.iwamatsu.x90@mail.toshiba,m:pavel@nabladev.com,m:rmk+kernel@armlinux.org.uk,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable,kernel];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72696657111

On Mon, Jun 08, 2026 at 10:28:18AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-05-11 15:53:53 [+0200], To stable@vger.kernel.org wrote:
> > This is a backport of ARM related fixes. This applies cleanly to v6.18
> > and v6.12. I have an updated batch for v6.6 and v6.1 because this does
> > not apply cleanly.
> > 
> > #1 and #2 are prerequisites for #3.
> > 
> > Can't tell the origin of #3 (fix hash_name() fault). It might be there
> > since the begin of time.
> > 
> > #4 (fix branch predictor hardening) fixes commit f5fe12b1eaee2 ("ARM:
> > spectre-v2: harden user aborts in kernel space") which is v4.20-rc2.
> > 
> > If there are no objections I would post the v6.6 version once this is
> > accepted and then rebase the PREEMPT_RT bits on top of this.
> 
> I noticed that the ARM64 patches I sent recently were picked up and
> backported but this is still waiting.
> 
> I there something I can do to speed things up?

We have hundreds of patches in the backlog right now, these are way down
the list, sorry.  Hope to catch up "soon"...

thanks,

greg k-h

