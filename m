Return-Path: <stable+bounces-159203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3ECAF0D79
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8741C24206
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 08:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAAB219E8C;
	Wed,  2 Jul 2025 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tq3ymXru"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69627137923
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751443594; cv=none; b=ePrL3WNqlFTorIhTzRXHNQArZ+RsrpilE4VZIsWt+NobK03ia1CHbj0ca68Qj2oByGREay4K+eXfoiVhZv8j7WACJPmeadoJ0UiNhKELKyo3u8rldXyAkgnkL44yQmeoWkFMPwtdDjxsdAfUXa7E5Mulw3t5KSeR8qcOcts1ftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751443594; c=relaxed/simple;
	bh=BLq2mB65I9gFpEe65Cnt+yD8qOUQEjeH4FWe338RV+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7pSsEn6HugCxUw29El5Mln72wGv+zlTo0Aw9c8LJt3eOKTrvuCDK/PwB8yTSrbieRWw3tXWD4tgbyDzZBmEkiG1MyVKJLK0lsNwyn38tNwUNk8Fvq+55jonviqHDyJdrYkClePBGp/bfS75ouj9STKCo4zll1gy5HJm34ecqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tq3ymXru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E69C4CEED;
	Wed,  2 Jul 2025 08:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751443594;
	bh=BLq2mB65I9gFpEe65Cnt+yD8qOUQEjeH4FWe338RV+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tq3ymXruRhZOsrzwle2yF0mjiCc1jMKha/M570g2+CRK4amXoib9ocJhZRLLm4ctO
	 mEGrzWx6MzU9b2D/4edt/4HF8wPyWvoY0OC+jNz+bnGTrrwli0OCOOYcWKuBTarUlz
	 wx/nwQJ6bnfO0LiEAe1g+nqFZor5hIMSWyeLELEA=
Date: Wed, 2 Jul 2025 10:06:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable <stable@vger.kernel.org>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Ingo Molnar <mingo@kernel.org>, Larry Wei <larryw3i@yeah.net>,
	1103397@bugs.debian.org
Subject: Re: [stable 6.12+] x86/pkeys: Simplify PKRU update in signal frame
Message-ID: <2025070222-refurbish-aneurism-3f08@gregkh>
References: <103664a92055a889a08cfc7bbe30084c6cb96eda.camel@decadent.org.uk>
 <2025062022-upchuck-headless-0475@gregkh>
 <2025062025-requisite-calcium-ebfa@gregkh>
 <38359c8a4f1edce6a44ea55f9f946b4adb39e92f.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38359c8a4f1edce6a44ea55f9f946b4adb39e92f.camel@decadent.org.uk>

On Wed, Jun 25, 2025 at 12:26:17AM +0200, Ben Hutchings wrote:
> On Fri, 2025-06-20 at 18:11 +0200, Greg KH wrote:
> > On Fri, Jun 20, 2025 at 05:56:29PM +0200, Greg KH wrote:
> > > On Sun, Jun 15, 2025 at 09:25:57PM +0200, Ben Hutchings wrote:
> > > > Hi stable maintainers,
> > > > 
> > > > Please apply commit d1e420772cd1 ("x86/pkeys: Simplify PKRU update in
> > > > signal frame") to the stable branches for 6.12 and later.
> > > > 
> > > > This fixes a regression introduced in 6.13 by commit ae6012d72fa6
> > > > ("x86/pkeys: Ensure updated PKRU value is XRSTOR'd"), which was also
> > > > backported in 6.12.5.
> > > 
> > > Now queued up, thanks.
> > 
> > Nope, this broke the build on 6.12.y and 6.15.y, so now dropped.  How
> > did you test this?
> 
> Sorry, I forgot to say this depends on the preceding commit 64e54461ab6e
> ("x86/fpu: Refactor xfeature bitmask update code for sigframe XSAVE").

Ok, thanks, will go try that now...

greg k-h

