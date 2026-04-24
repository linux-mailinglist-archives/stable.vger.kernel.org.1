Return-Path: <stable+bounces-240644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJWkMrhZ62nkKwAAu9opvQ
	(envelope-from <stable+bounces-240644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:53:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4FC45E0CB
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 540AB300443C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEFD3BF689;
	Fri, 24 Apr 2026 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VNIoLRwG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41F390219
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031600; cv=none; b=bmt+a3Ms4i5LwFpPgPDaY0PUu76qc1s3RWrEk3A4wn9xSJJ1itkNkMV2x6jK6rheF+QEZeowmn2ku7UP6D8vmwu7zIWHpDsXSrPhDOSuzntN18xszgdPU56+SAhVDDoJ8w0AZLeDXhRzxuHVKiDGEzE5KcsT6ALZrtORT1CdwJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031600; c=relaxed/simple;
	bh=o5v3g5sFUvhS8sxlyqskLTuxJRnPC7eD4PLRPoFns1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7F94q/S7esWyXv3YNS1vQN7xq6bWmTRNIbN3XroyKqNwdKv3uKJxbG7k3FYHwMM3cXHA1RBsaOVQcuJlFh918/0pHcHfEFOAOf2z+kE4fTDKkGw3UgT+Ba18Bn2bl5JwQmVENeFpGj9wOX9/cONXOsy7AjChRqpdXHw8rvR7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VNIoLRwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E47C19425;
	Fri, 24 Apr 2026 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777031600;
	bh=o5v3g5sFUvhS8sxlyqskLTuxJRnPC7eD4PLRPoFns1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNIoLRwGofXJd5V6AOTTtAmPjoOQ299QmbKI87yY0CANbDlLZUBzNweOTP6FUJd7V
	 UyjNh8+pFwv5//Lab8iSmFtOBNGN/zeIaWDxPNzqJ4dMmzzbN2Ozc0wqKUefrpOuL/
	 krlyPW4in1YiNFComyHDRJbmexagox0sBs7fhTJk=
Date: Fri, 24 Apr 2026 13:53:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Jeff Barnes <jeffbarnes@linux.microsoft.com>
Subject: Re: [REQUEST] crypto backport for 6.6
Message-ID: <2026042410-corporate-voyage-34c3@gregkh>
References: <aetVcb8pSITaiGg7@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <2026042442-absinthe-reversing-8376@gregkh>
 <aetX6JwQ72GEv80e@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aetX6JwQ72GEv80e@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Rspamd-Queue-Id: CB4FC45E0CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240644-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 04:45:44AM -0700, Hamza Mahfooz wrote:
> On Fri, Apr 24, 2026 at 01:42:42PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Apr 24, 2026 at 04:35:13AM -0700, Hamza Mahfooz wrote:
> > > Hi,
> > > 
> > > Please include commit 35e13e0eacf4 ("crypto: testmgr - Hide ENOENT
> > > errors better") in kernel 6.6, as it resolves a kernel panic.
> > 
> > I see no such commit in Linus's tree, are you sure that is correct?
> > 
> > > (you will also need commit fc0f08317135 ("crypto: testmgr - Hide ENOENT
> > > errors") to have it apply cleanly).
> > 
> > I don't see that commit id either anywhere.
> > 
> > What tree are you looking at?
> > 
> > confused,
> 
> Whoops, I was looking at my local tree, the correct commits are:
> 
> 6318fbe26e67 ("crypto: testmgr - Hide ENOENT errors better")
> 4eded6d14f5b ("crypto: testmgr - Hide ENOENT errors")

That's better, now queued up :)

greg k-h

