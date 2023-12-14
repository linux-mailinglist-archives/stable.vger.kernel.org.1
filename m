Return-Path: <stable+bounces-6718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54740812A2A
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 09:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D38C9B210E9
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 08:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D45168AC;
	Thu, 14 Dec 2023 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2uaeL8ER"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E1DDB6
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 08:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90277C433C7;
	Thu, 14 Dec 2023 08:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702541940;
	bh=FpHdXuSx6X/SeV2ntVhUOpyjzeoCmgTKDNKQBgUsSAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2uaeL8ERFWqVuDTZ96WkrSy+3oQYtjY5gEbE/vls/kSKFLvUNZF9Xy0S14WGYsB1B
	 a25mRw3iQAWtztNCnD0oHBe4iCkwg13zyly7FAMmHjed8EvG1hMbXiYCre6yXIBG8R
	 FQWgNCQKwaiXeCiXzDf5HcWAoaCmZGBOvUyR8Osg=
Date: Thu, 14 Dec 2023 09:18:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Berg, Johannes" <johannes.berg@intel.com>
Cc: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>,
	=?iso-8859-1?B?TOlv?= Lam <leo@leolam.fr>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Message-ID: <2023121423-factual-credibly-2d46@gregkh>
References: <e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org>
 <2023121139-scrunch-smilingly-54f4@gregkh>
 <aee3e5a0-94b5-4c19-88e4-bb6a8d1fafe3@manjaro.org>
 <2023121127-obstinate-constable-e04f@gregkh>
 <DM4PR11MB5359FE14974D50E0D48C2D02E98FA@DM4PR11MB5359.namprd11.prod.outlook.com>
 <43a1aa34-5109-41ad-88e7-19ba6101dad3@manjaro.org>
 <e7a6e6a6-2e5c-4c60-b8e0-0f8eca460586@manjaro.org>
 <DM4PR11MB5359B0524B31A258DD3B20F4E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB5359B0524B31A258DD3B20F4E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>

On Thu, Dec 14, 2023 at 08:05:55AM +0000, Berg, Johannes wrote:
>  
> > So Greg, how we move forward with this one? Keep the revert or integrate
> > Leo's work on top of Johannes'?
> 
> It would be "resend with the fixes rolled in as a new backport".

No, the new change needs to be a seprate commit.

> > Johannes, how important is your fix for the stable 6.x kernels when done
> > properly?
> 
> Well CQM was broken completely for anything but (effectively) brcmfmac ... That means roaming decisions will be less optimal, mostly.
> 
> Is that annoying? Probably. Super critical? I guess not.

Is it a regression or was it always like this?

thanks,

greg k-h

