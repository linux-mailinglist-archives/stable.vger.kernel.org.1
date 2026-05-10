Return-Path: <stable+bounces-245047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHGBBN+1AGplLwEAu9opvQ
	(envelope-from <stable+bounces-245047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 18:44:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EF9505272
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 18:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4E843001CC7
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 16:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BBE3AEF24;
	Sun, 10 May 2026 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lCvnYKBt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3373ACF15
	for <stable@vger.kernel.org>; Sun, 10 May 2026 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778431447; cv=none; b=WI1ZL7K6bZmF0OtoHbrfQUZI+chm99v9eT0EABuuy/YvnNxW0UR2/wmq3TwnipuMHUFgh3sIy37GVSXBZ/7wNTwT1OJ2DIIUzsNNrgYJB9WYxsva4mlR5tM0Vgxb/wS2GTRk1MEmYo2tJ7o92ORdZ7IMiUg6vQe3P5um6KFq2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778431447; c=relaxed/simple;
	bh=uX8kb0V+bT5E5hP1yz6XP3+CY4ByVNUqAcjHEseNLj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOHQZzB4PEbzgNvnx1vRlzUMIf489Hcz8rmdqJxKhd+i939gWEJ74z0Nt/bGZ0/1B8UCRBd7w5EHLyOOTEE1534+c9C/bo6M8a+O+S6M0wCMylqZiLKE+8Hgi72HG6/5tsJWntHAwsxU9j495RiuwgkMQwbUUaxl0EBDs8q73Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lCvnYKBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBD6C2BCB8;
	Sun, 10 May 2026 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778431447;
	bh=uX8kb0V+bT5E5hP1yz6XP3+CY4ByVNUqAcjHEseNLj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCvnYKBtwwksHqc641UHurEwnAnHLO4EbimQfEUK2rMF/6S3S4j19Su/mqRJp53yB
	 v5DPPcX1gZDk6R3qD8NhNnt/9jRnObjpvmd6IGMD+DIyaTbDGMlpAnYfirD5icKkj/
	 NjLDV+mud51zLcL47zQUEx1uLqbX4YGsx1lvnGIk=
Date: Sun, 10 May 2026 18:43:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: dhowells@redhat.com, horms@kernel.org, jaltman@auristor.com,
	kuba@kernel.org, linux-afs@lists.infradead.org,
	marc.dionne@auristor.com, sashal@kernel.org, stable@kernel.org,
	stable@vger.kernel.org
Subject: Re: Re: Backport RXRPC for 6.1.y from 6.2
Message-ID: <2026051004-dreamless-dab-f7b0@gregkh>
References: <2026051040-primary-anyway-9a79@gregkh>
 <20260510163636.260801-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510163636.260801-1-guanwentao@uniontech.com>
X-Rspamd-Queue-Id: F1EF9505272
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-245047-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 12:36:36AM +0800, Wentao Guan wrote:
> > Why is this needed?  If you want this, please provide a working set of
> > patches properly submitted, along with the reasoning why you just don't
> > move to a newer kernel version.  And do you really use the AFS
> > filesystem in a 6.1.y kernel tree?  If so, why?
> 
> FYI, there are bugfixes such as ("rxrpc: Fix conn-level packet handling to unshare RESPONSE packets")
> affect the 6.1.y kernel, and the final goal is clean apply fixes for CVE-2026-43500 such as
> ("rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present") in maillist.

That was not stated here at all, so we had no context :(

If you need/want those bugfixes, great!  Provide a patch series of them
and we will be glad to review them.

> > move to a newer kernel version.  And do you really use the AFS
> > filesystem in a 6.1.y kernel tree?  If so, why?
> NO, just affected by compiled kernel which enabled the config:(,
> we are preparing fix such as disable AFS and AF_RXRPC or fix it...

Great, if you don't need this, disable it and then you don't need the
backports either :)

thanks,

greg k-h

