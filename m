Return-Path: <stable+bounces-206269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE6CD019E7
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 09:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3621300F9F1
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 08:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A6F381714;
	Thu,  8 Jan 2026 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2uUfxrEW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC6E389458;
	Thu,  8 Jan 2026 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767860298; cv=none; b=OU+81Z3aM88By0HIJqGQPMQwIA8uaD3+D6+/VFSzteBGVSN3BJ2IWFuDsMXT6bwpIkzOzTZL20HjmkLlKJtrVSCbVmta3ZSVo7+5KeelhEefDFC78LWlQiz22EKcFjod2dRYFyUcftYc+mxxhr1OvHCELEFizOFp5FgzDYDB/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767860298; c=relaxed/simple;
	bh=C5VD4/jDJ4CUxNqpsE3o/GHzOL32eNLmvjLhev1NB3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVY5R/+InaQ8q/gdDZ5rwghG/uZuFpsgeJ6enS3ufGEfpqRgy80jmgJgFuCbRzn6tB6798nGBuQ1PmK6gzDCOFb0UuyN4ZULYRNZni+VbI0bmWr+Yj0AixK2Yji9CJRtg8YM5Er2A1P7nbFIJm9PFnzn9mUC7ecNc6YtwbBd0iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2uUfxrEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFDDC116C6;
	Thu,  8 Jan 2026 08:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767860297;
	bh=C5VD4/jDJ4CUxNqpsE3o/GHzOL32eNLmvjLhev1NB3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2uUfxrEW2tr/YIJHlGVJLWE6mZfE3qDVrip3ikM6s5M2LFxBlzmzLhgQMTCoki1jz
	 IVUNrntMW00/VeVJye/cGx1JKl2LFisNPW+mj06els09BqJqEWeeJYKbiHnGbNCd5W
	 fiq3UBtL7Sn9z1U1+mbzRiClGVFJ57xAO1GO/laA=
Date: Thu, 8 Jan 2026 09:18:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: "Abliyev, Reuven" <reuven.abliyev@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [char-misc v2] mei: trace: treat reg parameter as string
Message-ID: <2026010830-overgrown-bouncing-422a@gregkh>
References: <20260108065702.1224300-1-alexander.usyskin@intel.com>
 <2026010824-symphony-moisture-cb3b@gregkh>
 <CY5PR11MB6366A429654AFBFAA5D41825ED85A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2026010816-unsolved-wipe-bc45@gregkh>
 <CY5PR11MB6366F18F00C57AFB8C1E71CDED85A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2026010801-lard-maximum-7bc3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026010801-lard-maximum-7bc3@gregkh>

On Thu, Jan 08, 2026 at 09:17:12AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 08, 2026 at 07:59:08AM +0000, Usyskin, Alexander wrote:
> > > Subject: Re: [char-misc v2] mei: trace: treat reg parameter as string
> > > 
> > > On Thu, Jan 08, 2026 at 07:42:22AM +0000, Usyskin, Alexander wrote:
> > > > > Subject: Re: [char-misc v2] mei: trace: treat reg parameter as string
> > > > >
> > > > > On Thu, Jan 08, 2026 at 08:57:02AM +0200, Alexander Usyskin wrote:
> > > > > > Use the string wrapper to check sanity of the reg parameters,
> > > > > > store it value independently and prevent internal kernel data leaks.
> > > > > > Trace subsystem refuses to emit event with plain char*,
> > > > > > without the wrapper.
> > > > > >
> > > > > > Cc: stable@vger.kernel.org
> > > > >
> > > > > Does this really fix a bug?  If not, there's no need for cc: stable or:
> > > > >
> > > > > > Fixes: a0a927d06d79 ("mei: me: add io register tracing")
> > > > >
> > > > > That line as well.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > Without this patch the events are not emitted at all, they are dropped
> > > > by trace security checker.
> > > 
> > > Ah, again, that was not obvious at all from the changelog.  Perhaps
> > > reword it a bit?  How has this ever worked?
> > > 
> > 
> > This security hardening was introduced way after the initial commit
> > and the breakage went unnoticed for some time, unfortunately.
> 
> So then the "Fixes:" tag is not correct :(

Wait, no, it is, but you need to say why this is now needed, and was not
a problem back then.  And is this really ok to backport all the way to
that commit id, or should it just be relegated to the one where the
"hardening" feature was added?

thanks,
greg k-h

