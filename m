Return-Path: <stable+bounces-28192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A588E87C359
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 20:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599021F21226
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 19:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15BA74E3F;
	Thu, 14 Mar 2024 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XXymYfU2"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911182BB13
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710443341; cv=none; b=ZIf7U1rw53HzuXO+szzyEl5eLNWBpzQ+dDqtqD6nxLQYVi0boLI0697Dhh0/ggrBScZomfGvqSWlNNr6eqGE+WNi0I4WUG+eD9jAlbL6Z0Ex3kOW3uUd/6DiMMh7Jdzw47Ce3ASJmZk4HfjylYpjm7BUv6RVd0GDFEid2oS5UZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710443341; c=relaxed/simple;
	bh=sU2B6n8Yx6kULSOjprwAl8SaFffub4TdmSKL+sfv4JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrSHJhd152YKpYglJUwQxvc3c+mL2WCYxOKw2jl3D4gQC5r3S67afw6t2adJz+uyzW6HrB1SLuzRKS7oOG7hXqE+zUPZIl/ovIX2k0qFlNDAaLKQdaA/92w7AB+xtDn5TKoOQurJ+B58KWogqCjemSfE7eNHpBsyQsekm02ifvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XXymYfU2; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Mar 2024 15:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710443337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mmk6/vIxqwWF1V1papTOAWblF16BfLkG4cDbrY+Bs7I=;
	b=XXymYfU2gxwCI1PCD4edrJa3FMxjXiZH6DiEIZX7hE8GGibHu+ocNfbEFs+ZBrXh008MVd
	a0unOEv2hhEb3n2GL0LxMN1V+Dg4LTe2HUzULLCGEZybWf3pSSecY7NUlRYayIVYSADsbe
	B3O/VsiqgZLODkfCJK7Oe+KDNdz1a48=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Helge Deller <deller@gmx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, Helge Deller <deller@kernel.org>
Subject: Re: bachefs stable patches [was dddd]
Message-ID: <2vpsaj7bwn5yvpyerexgga3m22wvqfom32hbc3cics4vrs6lbm@gc47zhr756sr>
References: <ZfLGOK954IRvQIHE@carbonx1>
 <vubxxvlsgyzzn64ffdvhhdv75d5fal5jh5xew7mf7354cddykz@45w6b2wvdlie>
 <ed1eda66-8d67-4661-b50f-f2b152928bf3@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed1eda66-8d67-4661-b50f-f2b152928bf3@gmx.de>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 14, 2024 at 01:57:51PM +0100, Helge Deller wrote:
> (fixed email subject)
> On 3/14/24 10:46, Kent Overstreet wrote:
> > On Thu, Mar 14, 2024 at 10:41:12AM +0100, Helge Deller wrote:
> > > Dear Greg & stable team,
> > > 
> > > could you please queue up the patch below for the stable-6.7 kernel?
> > > This is upstream commit:
> > > 	eba38cc7578bef94865341c73608bdf49193a51d
> > > 
> > > Thanks,
> > > Helge
> > 
> > I've already sent Greg a pull request with this patch - _twice_.
> 
> OIC.
> You and Greg had some email exchange :-)
> 
> Greg, I'm seeing kernel build failures in debian with kernel 6.7.9
> and the patch mentioned above isn't sufficient.
> 
> Would you please instead pull in those two upstream commits (in this order) to fix it:
> 44fd13a4c68e87953ccd827e764fa566ddcbbcf5  ("bcachefs: Fixes for rust bindgen")

You'll have to explain what this patch fixes, it shouldn't be doing
anything when building in the kernel (yet; it will when we've pulled our
Rust code into the kernel).

