Return-Path: <stable+bounces-191812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82372C25086
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 13:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9A124F75BE
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 12:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C9E33CEB9;
	Fri, 31 Oct 2025 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rn1EOJ+7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77D2900A8;
	Fri, 31 Oct 2025 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914001; cv=none; b=sMN9uowCEBLtlJ1+VDgz5K40IDBLCW21NI8vhgWdW2NY0085saTWa81Qr2dE/c3lCuC/0vcLMkkUUdCy0QUCHOnHMVcVns2UTvpvG1F9wysTXjM8ip6Y0GvsKsN6mwCIhhO+Rtu1WDbqGjrxUusb09Nkow7TIvWNBGW1I7FSrc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914001; c=relaxed/simple;
	bh=8mG/tT6m7m1SPkxM0FGXaJnTJCfC760z6pu4g9dhsxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHbPcvN8mXA/YnRl5ueIV+gzTBlfm6COsgZGaC+iAuTaxL7KjQWP7hzaPkcFezgCOg0On6MP1Wb9T9wlrC/hIfxdEOIpaoNlGxq8fPl3kQVOb9WAl+rrrbxdfyjDHmuuXtrtHFV0HwZU8cDW8RlCSZK4HLiaAsU3ap7brP6zi8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rn1EOJ+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F4CC4CEE7;
	Fri, 31 Oct 2025 12:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761914000;
	bh=8mG/tT6m7m1SPkxM0FGXaJnTJCfC760z6pu4g9dhsxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rn1EOJ+7eXautIx1gHTna0ncLMzRFhvK2ZhxkpXJMcU2RDpMn0frBfPgAB1vWCLlZ
	 1l8TDTtp1D1Z43aqJBMDjPL1PDLLenlAHyVZtdpWATQE/6EL6Pp31uZczGCIMfGmxK
	 Rll7OuwGcq1dPkhilDeOX/ejvmev1NE5P1VdKf64=
Date: Fri, 31 Oct 2025 13:33:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andreas Radke <andreas.radke@mailbox.org>,
	stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Zhixu Liu <zhixu.liu@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Please backport commit 00d95fcc4dee ("docs: kdoc: handle the
 obsolescensce of docutils.ErrorString()") to v6.17.y
Message-ID: <2025103110-tidings-stench-6552@gregkh>
References: <aPUCTJx5uepKVuM9@eldamar.lan>
 <DDS2XJZB0ECJ.N4LNABSIJHAJ@mailbox.org>
 <aP4amn4YQDnzBBCU@eldamar.lan>
 <87wm4gpbw6.fsf@trenco.lwn.net>
 <aQEjRT5JBLYiBTaL@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQEjRT5JBLYiBTaL@eldamar.lan>

On Tue, Oct 28, 2025 at 09:10:45PM +0100, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Mon, Oct 27, 2025 at 10:06:33AM -0600, Jonathan Corbet wrote:
> > Salvatore Bonaccorso <carnil@debian.org> writes:
> > 
> > > Hi,
> > >
> > > On Sun, Oct 26, 2025 at 08:36:00AM +0100, Andreas Radke wrote:
> > >> For kernel 6.12 there's just one more place required to add the fix:
> > >> 
> > >> --- a/Documentation/sphinx/kernel_abi.py        2025-10-23 16:20:48.000000000 +0200
> > >> +++ b/Documentation/sphinx/kernel_abi.py.new    2025-10-26 08:08:33.168985951 +0100
> > >> @@ -42,9 +42,11 @@
> > >>  from docutils import nodes, statemachine
> > >>  from docutils.statemachine import ViewList
> > >>  from docutils.parsers.rst import directives, Directive
> > >> -from docutils.utils.error_reporting import ErrorString
> > >>  from sphinx.util.docutils import switch_source_input
> > >> 
> > >> +def ErrorString(exc):  # Shamelessly stolen from docutils
> > >> +    return f'{exc.__class__.__name}: {exc}'
> > >> +
> > >>  __version__  = '1.0'
> > >> 
> > >>  def setup(app):
> > >
> > > Yes this is why I asked Jonathan, how to handle backports to older
> > > series, if it is wanted to pick specifically as well faccc0ec64e1
> > > ("docs: sphinx/kernel_abi: adjust coding style") or a partial backport
> > > of it, or do a 6.12.y backport of 00d95fcc4dee with additional
> > > changes (like you pointed out).
> > >
> > > I'm just not sure what is preferred here. 
> > 
> > I'm not sure it matters that much...the additional change suggested by
> > Andreas seems fine.  It's just a backport, and it shouldn't break
> > anything, so doesn't seem worth a lot of worry.
> 
> Okay here is a respective backported change for the 6.12.y series as
> well.
> 
> Does that look good for you?
> 

Now queued up, thanks!

greg k-h

