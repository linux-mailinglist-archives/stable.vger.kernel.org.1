Return-Path: <stable+bounces-6737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 135E5812F92
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 12:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5961F2211F
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BBD41220;
	Thu, 14 Dec 2023 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bSapnCof"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855554120E
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 11:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06273C433C7;
	Thu, 14 Dec 2023 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702555153;
	bh=M5xxhdqjusdxRpI65RthaK7ej7Yz8lUwIbdA27z9cFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bSapnCofx+BKj7sI1BQLmoB/epy/tMhEr9dsPvNNUIY+mUGSmV7COr3A/pGB7TRN9
	 cFfkQf6KdOqZQsr7cWml1xXnTrU5LifW9XwJAGgQypXI/Kqqr3InEMbykeHZqtdCd9
	 v/dINaWq44y/ZL0BfkB25i49endRUR76iYguld/I=
Date: Thu, 14 Dec 2023 12:59:10 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: "Berg, Johannes" <johannes.berg@intel.com>,
	=?iso-8859-1?B?TOlv?= Lam <leo@leolam.fr>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Message-ID: <2023121450-habitual-transpose-68a1@gregkh>
References: <2023121139-scrunch-smilingly-54f4@gregkh>
 <aee3e5a0-94b5-4c19-88e4-bb6a8d1fafe3@manjaro.org>
 <2023121127-obstinate-constable-e04f@gregkh>
 <DM4PR11MB5359FE14974D50E0D48C2D02E98FA@DM4PR11MB5359.namprd11.prod.outlook.com>
 <43a1aa34-5109-41ad-88e7-19ba6101dad3@manjaro.org>
 <e7a6e6a6-2e5c-4c60-b8e0-0f8eca460586@manjaro.org>
 <DM4PR11MB5359B0524B31A258DD3B20F4E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
 <2023121423-factual-credibly-2d46@gregkh>
 <DM4PR11MB535948386880F5A2DB3C5582E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
 <779818b0-5175-449f-93fb-6e76166a325f@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <779818b0-5175-449f-93fb-6e76166a325f@manjaro.org>

On Thu, Dec 14, 2023 at 03:32:47PM +0700, Philip Müller wrote:
> On 14.12.23 15:24, Berg, Johannes wrote:
> > > > > So Greg, how we move forward with this one? Keep the revert or
> > > > > integrate Leo's work on top of Johannes'?
> > > > 
> > > > It would be "resend with the fixes rolled in as a new backport".
> > > 
> > > No, the new change needs to be a seprate commit.
> > 
> > Oh, I stand corrected. I thought you said earlier you'd prefer a new, fixed, backport of the change that was meant to fix CQM but broke the locking, rather than two new commits.
> > 
> > > > > Johannes, how important is your fix for the stable 6.x kernels when
> > > > > done properly?
> > > > 
> > > > Well CQM was broken completely for anything but (effectively) brcmfmac ...
> > > That means roaming decisions will be less optimal, mostly.
> > > > 
> > > > Is that annoying? Probably. Super critical? I guess not.
> > > 
> > > Is it a regression or was it always like this?
> > 
> > It was a regression.
> > 
> > johannes
> 
> So basically the reversed patch by Johannes gets re-applied as it was and
> Leo's patch added to the series of patches to fix it. That is the way I
> currently ship it in my kernels so far.

Great, can someone please send the series like this with your:

> We can add a Tested-by from my end if wanted.

that would be wonderful.

greg k-h


