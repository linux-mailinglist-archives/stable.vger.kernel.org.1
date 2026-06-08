Return-Path: <stable+bounces-262063-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gTN1CgPrJmp1nAIAu9opvQ
	(envelope-from <stable+bounces-262063-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 18:17:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7721465897B
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 18:17:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=pvrWezwv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262063-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262063-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D513530C3347
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 16:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3387330B11;
	Mon,  8 Jun 2026 16:03:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2C325494;
	Mon,  8 Jun 2026 16:03:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934607; cv=none; b=A7spjVrUrrin33aU+qxF0EFxLGDYe68CJrNg2b9Syk5K7F9SzQJwhBUO1qgFsVPDQnKm4OLVJtnfb8GzuWmNKT6nuIsSE7ENs7IBGrTpTgozbHDin7GDUs2hI1cOfPOCv9yF4n3CZVAg2eyItoRd7LadZKdZwTUm5CtFrjpFw1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934607; c=relaxed/simple;
	bh=8JLxiqgcD0YOvqhERnCcIUPOLSB3aFpHvIB2bHIUDJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sblwVnmJHu63T2wYyiXjbJwUI8xJNwkhm5Th/BHt/07dYpd+OrNhoamfIgL9JSBigH53kwMPQchZHmcper/S3zLxsE+fl7NTGyfg7wrISI7J84zl0iMgprm1le9C20bNKQG+2mSVCx1DI7NVnK79IokYos3nJSC0Z8an4HlQnZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pvrWezwv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB851F00893;
	Mon,  8 Jun 2026 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780934606;
	bh=Vr9jVMS80gOp2YTnFHoD1vcCtZ8qIuWVlrvbBgC3Ci8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pvrWezwvYZ6hp0ECtEE5aeudgIuBWvTtR3DEjZ/exd6Ny/IYpkFUKUZNB8jB9Qcm1
	 K5KP4gCcHFAQjKTd6me/OpF6XyfASogHwAY6JQkNkRLAvviutcLcpfF4maGlVm+mXY
	 YJGQvZ98XbCPGqWZ3mgLUpwjPB3WUxVUNEXjG3fM=
Date: Mon, 8 Jun 2026 18:02:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>, Justin Forbes <jforbes@redhat.com>
Subject: Re: [PATCH 7.0 089/332] net/handshake: Pass negative errno through
 handshake_complete()
Message-ID: <2026060807-egging-prune-a3ae@gregkh>
References: <20260607095728.031258202@linuxfoundation.org>
 <20260607095731.416875228@linuxfoundation.org>
 <3fe6ad12-30e4-4a57-8167-268ffdb4488a@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe6ad12-30e4-4a57-8167-268ffdb4488a@leemhuis.info>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262063-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux@leemhuis.info,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:chuck.lever@oracle.com,m:hare@kernel.org,m:pabeni@redhat.com,m:sashal@kernel.org,m:jforbes@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7721465897B

On Mon, Jun 08, 2026 at 04:37:09PM +0200, Thorsten Leemhuis wrote:
> On 6/7/26 11:57, Greg Kroah-Hartman wrote:
> > 7.0-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > [ Upstream commit 6b22d433aa13f68e3cd9534ca9a5f4277bfa01c2 ]
> > 
> > handshake_complete() declares status as unsigned int and
> > tls_handshake_done() negates that value (-status) before handing
> > it to the TLS consumer. Consumers match on negative errno
> > constants -- xs_tls_handshake_done() has
> 
> This causes a error for me when building ynl. See below for the build
> log. The problem can be avoided by reverting this patch from the
> stable-rc queue or by cherry-picking fbf5df34a4dbcd ("tools: ynl: add
> scope qualifier for definitions") [v7.1-rc4].
> 
> I'd suggest doing the later, as I last week had a quite similar error
> when building ynl during the 7.0.11-rc1 phase:
> https://lore.kernel.org/all/d66f5c95-ebc0-4c53-9852-f73c790363f7@leemhuis.info/
> 
> Back then Sasha went for dropping the problematic change ("net: shaper:
> reject handle IDs exceeding internal bit-width") from the 6.18.y and
> 7.0.y queues. But given that this is the second time within a week the
> missing patch seems to cause trouble I suspect it might not be the last.

I've queued this up now, but it didn't apply to 6.12.y, can someone
provide a working backport for there?

thanks,

greg k-h

