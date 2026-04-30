Return-Path: <stable+bounces-242027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAduIW798mmIwQEAu9opvQ
	(envelope-from <stable+bounces-242027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:57:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E92D49E49D
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B9A4301F183
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 06:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52F43783C4;
	Thu, 30 Apr 2026 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H5mZPMzr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ABA374721;
	Thu, 30 Apr 2026 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777532264; cv=none; b=ChAYqtmBodfjaKdR8Ljm+j3sSQf5MxKkfVpwKtMormJCi+kNSeWwvTjMWWms2UtIgG7KNPQeAt8sPhPRpegn57RJ9Jp1mkYKqu2tdwKlKqzAlW1p5x3Ktqi761tnNURjPCoOkg0tWDcQc9h2/zUzel/iMVBcwfvFMHZuD78qNps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777532264; c=relaxed/simple;
	bh=BTQISJ5R6SumSil3t6TJags3aAwmNx5YKtm/aTi3NRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/PDMOjBlfVHXZrwSltrw5XJSgSjgpIrPUpKNMz3TlyHBPmHy+MUyyvGjr881Lk+7wp2Q0M/bgJKPHKJsPjtX42jMueDF4HITcLd9/w/iQqCbB+TMWwVHzFjwS8EcMfdrF4bWebjmrLM7uMeF3o/W/9CGttAq/rIEJ1eeG8BRUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H5mZPMzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D489EC2BCB3;
	Thu, 30 Apr 2026 06:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777532264;
	bh=BTQISJ5R6SumSil3t6TJags3aAwmNx5YKtm/aTi3NRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5mZPMzrwMmGU7RYys4WFigXLXtMupKuRHelZnwbDHEK8e0PUTfih/724no5NcNpd
	 IcJdzIOhNq/sVLSnqwOHni/4xfQO3Yj9OfBZ9flftQ7lH0TekQkP3J1t2Wy5JTp9y0
	 9DdnLBemTmWaUrwCPmmVLedMvoQRFab4cmlUyiK4=
Date: Thu, 30 Apr 2026 08:57:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: stable@vger.kernel.org, linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 6.12 0/8] AF_ALG fixes
Message-ID: <2026043038-unwilling-slogan-a20e@gregkh>
References: <20260430060702.110091-1-ebiggers@kernel.org>
 <20260430061120.GA54208@sol>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430061120.GA54208@sol>
X-Rspamd-Queue-Id: 0E92D49E49D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242027-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,copy.fail:url,linuxfoundation.org:dkim]

On Wed, Apr 29, 2026 at 11:11:20PM -0700, Eric Biggers wrote:
> On Wed, Apr 29, 2026 at 11:06:54PM -0700, Eric Biggers wrote:
> > This series backports the recent AF_ALG fixes to 6.12.  These include
> > the fix for https://copy.fail/, fixes for that fix, and some other fixes
> > that went in at around the same time that seem related.
> > 
> > To enable the 5 actual fix commits to cherry-pick cleanly, commit 1
> > copies the latest implementation of memcpy_sglist() from upstream, and
> > commits 2 and 5 cleanly cherry-pick a couple cleanup commits.
> > 
> > I didn't check older kernels yet, but this should be usable as a
> > starting point for them.
> 
> It applies to 6.6 as well.  There's a conflict on 6.1.

Thanks a lot for these, let me go do some "quick" releases with these
fixes in it to tame my inbox a bit :)

greg k-h

