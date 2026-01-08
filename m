Return-Path: <stable+bounces-206265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B66D01858
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 09:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 108DA30B66ED
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 07:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90AB38E124;
	Thu,  8 Jan 2026 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mk+WIUOw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9C238E5C7;
	Thu,  8 Jan 2026 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858953; cv=none; b=bkd2fgBlpI13aSHnjXlHA7gBV0N4KhRD/fvdTtb8uVC95gSJi4f8qfiV3bupWnGyPW6Aq4IlDJce0NRV4b4rYT2XV0E2KNOmgp5qGEMie+tzdTQZuDNtUZfGY6uP3gqoqX37GsXGMbdY1EvYD1CB7G5iLZMoNjAaoqFVnhKH1iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858953; c=relaxed/simple;
	bh=9ETZSuNCnh1OEMPkn3zBKTrwq0m14g4kMmvd+4Fc/90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJ6Ojl4tyNc/1NMy8KwrQjvMgGLbhCXH5PgubWumnmDWrR/ekOH8oYHu7FdRVpyoBbLGnraF+KYVykJdIqU4LMj03oWR2Pm2UQSeLNbAoMDVPLyTFbn8UU1RV4oQg3cKYA+lEccXBFJ9kJpnP0667MUbZp2DJSEXdJxF3wUF3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mk+WIUOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94403C116C6;
	Thu,  8 Jan 2026 07:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767858952;
	bh=9ETZSuNCnh1OEMPkn3zBKTrwq0m14g4kMmvd+4Fc/90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mk+WIUOwHLQ9iOSCnz60pV/BbjzoJ7CuTj2y087rAl4JP1dTYoITlGYSp8l0HiIVa
	 UDqBTAVwBreqEcgzrIbSrBygV1cfDLLgI7KiMb5dxeA68nA5D8tpRSYrbLCk8w14/d
	 pAxsY/fjy1RkM8FiulwAyeDqURxd43KF4C203Dwk=
Date: Thu, 8 Jan 2026 08:55:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: "Abliyev, Reuven" <reuven.abliyev@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [char-misc v2] mei: trace: treat reg parameter as string
Message-ID: <2026010816-unsolved-wipe-bc45@gregkh>
References: <20260108065702.1224300-1-alexander.usyskin@intel.com>
 <2026010824-symphony-moisture-cb3b@gregkh>
 <CY5PR11MB6366A429654AFBFAA5D41825ED85A@CY5PR11MB6366.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6366A429654AFBFAA5D41825ED85A@CY5PR11MB6366.namprd11.prod.outlook.com>

On Thu, Jan 08, 2026 at 07:42:22AM +0000, Usyskin, Alexander wrote:
> > Subject: Re: [char-misc v2] mei: trace: treat reg parameter as string
> > 
> > On Thu, Jan 08, 2026 at 08:57:02AM +0200, Alexander Usyskin wrote:
> > > Use the string wrapper to check sanity of the reg parameters,
> > > store it value independently and prevent internal kernel data leaks.
> > > Trace subsystem refuses to emit event with plain char*,
> > > without the wrapper.
> > >
> > > Cc: stable@vger.kernel.org
> > 
> > Does this really fix a bug?  If not, there's no need for cc: stable or:
> > 
> > > Fixes: a0a927d06d79 ("mei: me: add io register tracing")
> > 
> > That line as well.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Without this patch the events are not emitted at all, they are dropped
> by trace security checker.

Ah, again, that was not obvious at all from the changelog.  Perhaps
reword it a bit?  How has this ever worked?

thanks,

greg k-h

