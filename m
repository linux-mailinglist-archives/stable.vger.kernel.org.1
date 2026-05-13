Return-Path: <stable+bounces-246773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PpVAckmBGqaEwIAu9opvQ
	(envelope-from <stable+bounces-246773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 09:22:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6E052E8F8
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 09:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D973300440A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 07:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6E73D5676;
	Wed, 13 May 2026 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MXU0yODI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732A38B130
	for <stable@vger.kernel.org>; Wed, 13 May 2026 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778656925; cv=none; b=URA/wIyhqDpWHAS5U5MJ6sYzrScpb3JAoc+H6py8FZ0Dhj2/KpB+UTpzpu8J6VLTtYEC3iskI9EB9Ql+NIIZhwTwjrVd2n2CQzOeCz1bkvoXEMAfhYbDjlnRslIgLLET5KvKbhoY+DXWehZFKMa9fBsZTk8ZMIIb/iyP1ZgthEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778656925; c=relaxed/simple;
	bh=R/uki2KWesvYBJzJrXFf8LFKGG2CQNSwxqMQCYPGxFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQqWa9LzYA9JHFuLLrn+D+Sd2sJbgC/o5a8veZNWN+4ETT9KHomyjTwC8J2Fu1iftX9QKPegCCKMn9lOJFlU+SnFd+uxu2mT/2s2EgUXWMiG46+gkeWaUTaw5yhe1asLzHClVXdTNoqtxHpH9WfumPhwgGAcJAhUg11KAzlLjNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MXU0yODI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9BDC2BCB7;
	Wed, 13 May 2026 07:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778656924;
	bh=R/uki2KWesvYBJzJrXFf8LFKGG2CQNSwxqMQCYPGxFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXU0yODIgzun/Oz7ngxqekJOPiRKlucCar1NbzDjrDMb94zB2K49KrBzQlDMwKx+j
	 uBnbL+DuWRZF3DFjJKtwqxRJMCJgTC2rgCmdul6wMlYh8tLK0WpNElTPAnh3O6er4X
	 LA//LuPqpAmE/gKJuh8Q3f/H2hbytg8FE3NIZ1+8=
Date: Wed, 13 May 2026 09:21:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shreenidhi Shedi <yesshedi@gmail.com>
Cc: acme@kernel.org, linux@treblig.org, mikhail.v.gavrilov@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y v2 00/18] Backport fixes for -Wdiscarded-qualifiers
 and -Wnonnull with newer glibc
Message-ID: <2026051315-engorge-agreed-39cb@gregkh>
References: <20260511071051.537859-1-yesshedi@gmail.com>
 <2026051124-wildlife-entrust-5690@gregkh>
 <369f39de-e013-4b60-9b24-831a72af4ff6@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <369f39de-e013-4b60-9b24-831a72af4ff6@gmail.com>
X-Rspamd-Queue-Id: EA6E052E8F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246773-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,treblig.org,gmail.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 12:07:30PM +0530, Shreenidhi Shedi wrote:
> On 11/05/26 13:46, Greg KH wrote:
> > On Mon, May 11, 2026 at 12:40:33PM +0530, Shreenidhi Shedi wrote:
> > > Hi all,
> > > 
> > > This patch series backports a number of patches from master to 6.1.y
> > > to fix `-Wdiscarded-qualifiers` and `-Wnonnull` build issues with
> > > newer glibc versions.
> > > 
> > > I will port these changes to other stable trees once this gets reviewed.
> > 
> > You need to do this first for newer kernel trees, and only if they are
> > accepted there, should you do this for older ones as you do not want to
> > have regressions moving to newer kernels, right?
> > 
> > But first, why do this at all?  You should always be using the latest
> > kernel version of perf on older kernels, especially if you are updating
> > glibc.
> > 
> > And if you update glibc, WHY ARE YOU NOT UPDATING YOUR KERNEL?
> > 
> > Why would you be using an old kernel tree like this?  That's very odd,
> > please do not do that.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> 
> Thanks for the response. We have our own distro with 6.1.y kernel and we are
> trying to upgrade glibc to 2.43.

Great, then also update the kernel!  Don't only do one thing.

> As 6.1.y is well within support period I
> thought it would be good to keep it working with glibc-2.43 as these are
> harmless fixes and would help many (if someone is building 6.1.y tree in
> Fedora rawhide for example).

They shouldn't be doing that :)

> Updating kernel to latest LTS is not feasible for us at the moment.

Why not?  Nothing should break if you do that, just like nothing should
break when you update glibc.  What prevents you from doing this, you
will then get a few thousand CVEs fixed automatically for you that are
not currently fixed in the latest 6.1.y tree.

> I will send a patch series to newer LTS releases soon. Thanks for the
> advice.

No, this should not be needed, just build the latest perf if you really
need/want it.

thanks,

greg k-h

