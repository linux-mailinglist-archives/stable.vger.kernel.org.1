Return-Path: <stable+bounces-206268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B00E6D01A9B
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 09:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D3473721E5D
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 08:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5478C1F09A8;
	Thu,  8 Jan 2026 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eSCX9O54"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D23A8FEF;
	Thu,  8 Jan 2026 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767860238; cv=none; b=Aw42/3hWUURURQILSr6Nvl4Vz6ioHNKH+2/0xWyN/lklxx2eng+7NKq0Nin6qVYjk9Guxslqg0AS39zxHR9O/oWcHQJzoig12wMSUYqvNETxJ0rDNYa7ZSalVUSxLlwRdvhgkZzL8ZHNGBy/88WQnkyCCyJl2lB6htiFzm6aS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767860238; c=relaxed/simple;
	bh=SwCYXCYQdEV/yIl0DYAxSake0J0tA2q3sRjckUW8pvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUpdHpmxtSZ2mzxAKr9NW23iq1NTn0RybhIgwRwiGy7rCTu7EIkeW89VbZvFqrxp4Swzklf2UK19WHDwQooPgHGWkE+VLa1jheZpmlr6T+kU1lQLZAGG2ZI67dwZwf2VWuG+hDQ2rUzqMWlOZhQ+JmiO5zxRECp2eRAaeHc04BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eSCX9O54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624F1C116C6;
	Thu,  8 Jan 2026 08:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767860235;
	bh=SwCYXCYQdEV/yIl0DYAxSake0J0tA2q3sRjckUW8pvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSCX9O54daICdLVIWitT+0+ui7eDwKZGMf6piXZZldVAX84QD1j3grbJ+TOC5gbWS
	 yHYTBh7v1UdVwNJtwJECKXDJevwphyx+zS3sfIanwsDu/irfctVUU2wk+HhlgvCqYh
	 wAi9Xbw9zQt/fVQKJG0CKKaO++/Kns2omArQMJZ0=
Date: Thu, 8 Jan 2026 09:17:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: "Abliyev, Reuven" <reuven.abliyev@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [char-misc v2] mei: trace: treat reg parameter as string
Message-ID: <2026010801-lard-maximum-7bc3@gregkh>
References: <20260108065702.1224300-1-alexander.usyskin@intel.com>
 <2026010824-symphony-moisture-cb3b@gregkh>
 <CY5PR11MB6366A429654AFBFAA5D41825ED85A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2026010816-unsolved-wipe-bc45@gregkh>
 <CY5PR11MB6366F18F00C57AFB8C1E71CDED85A@CY5PR11MB6366.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6366F18F00C57AFB8C1E71CDED85A@CY5PR11MB6366.namprd11.prod.outlook.com>

On Thu, Jan 08, 2026 at 07:59:08AM +0000, Usyskin, Alexander wrote:
> > Subject: Re: [char-misc v2] mei: trace: treat reg parameter as string
> > 
> > On Thu, Jan 08, 2026 at 07:42:22AM +0000, Usyskin, Alexander wrote:
> > > > Subject: Re: [char-misc v2] mei: trace: treat reg parameter as string
> > > >
> > > > On Thu, Jan 08, 2026 at 08:57:02AM +0200, Alexander Usyskin wrote:
> > > > > Use the string wrapper to check sanity of the reg parameters,
> > > > > store it value independently and prevent internal kernel data leaks.
> > > > > Trace subsystem refuses to emit event with plain char*,
> > > > > without the wrapper.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > >
> > > > Does this really fix a bug?  If not, there's no need for cc: stable or:
> > > >
> > > > > Fixes: a0a927d06d79 ("mei: me: add io register tracing")
> > > >
> > > > That line as well.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > Without this patch the events are not emitted at all, they are dropped
> > > by trace security checker.
> > 
> > Ah, again, that was not obvious at all from the changelog.  Perhaps
> > reword it a bit?  How has this ever worked?
> > 
> 
> This security hardening was introduced way after the initial commit
> and the breakage went unnoticed for some time, unfortunately.

So then the "Fixes:" tag is not correct :(

