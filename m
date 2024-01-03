Return-Path: <stable+bounces-9255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90136822AEE
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 11:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9921C22F01
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8141A1864E;
	Wed,  3 Jan 2024 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RQT1hArF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CD91864A
	for <stable@vger.kernel.org>; Wed,  3 Jan 2024 10:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39981C433C8;
	Wed,  3 Jan 2024 10:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704276558;
	bh=9UqvMLX6EMJc1T5xWDaYN7qaueGeM3k/Ik4UVL5/X4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQT1hArFwbYJ+6apBnwPMz8tIZs047EtRdJmEqTGinPbshp1EayyI+Vk3ZOn7weoi
	 YcYJ9nwj6p+W4z/QzTK5x3XIzOSfOL+994BKfdL1yhRNKygfh+1YrH7ttHjqsq8K6d
	 f0ePcQyXIxZIfQsqwt7iNMemrBcSz6bIxj2FVckk=
Date: Wed, 3 Jan 2024 11:09:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: "Berg, Johannes" <johannes.berg@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	=?iso-8859-1?B?TOlv?= Lam <leo@leolam.fr>
Subject: Re: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Message-ID: <2024010311-unbolted-extras-fa13@gregkh>
References: <43a1aa34-5109-41ad-88e7-19ba6101dad3@manjaro.org>
 <e7a6e6a6-2e5c-4c60-b8e0-0f8eca460586@manjaro.org>
 <DM4PR11MB5359B0524B31A258DD3B20F4E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
 <2023121423-factual-credibly-2d46@gregkh>
 <DM4PR11MB535948386880F5A2DB3C5582E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
 <779818b0-5175-449f-93fb-6e76166a325f@manjaro.org>
 <2023121450-habitual-transpose-68a1@gregkh>
 <a6d9940b-76e4-43cf-9a37-53def408a5b4@manjaro.org>
 <eff5692861533201b7a1e680bc36c551d0aa0a65.camel@leolam.fr>
 <fb44bcd8-6dfd-4a0d-98f5-cb39fedcd919@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb44bcd8-6dfd-4a0d-98f5-cb39fedcd919@manjaro.org>

On Wed, Jan 03, 2024 at 10:45:05AM +0700, Philip Müller wrote:
> On 17.12.23 00:58, Léo Lam wrote:
> > On Sat, 2023-12-16 at 17:47 +0700, Philip Müller wrote:
> > > 
> > > Leo provided the patch series here:
> > > https://lore.kernel.org/stable/20231216054715.7729-4-leo@leolam.fr/
> > > 
> > > However, without a cover letter to it. Since we reverted Johannes' patch
> > > both in 6.1.67 and 6.6.6 both patches may added to both series to
> > > restore the original intent.
> > > 
> > 
> > Ah sorry, I assumed the link I added in the patch description provided
> > enough context!
> > 
> > Also I should note that my Tested-by only covers 6.6.7, while Phillip's
> > Tested-by covers both 6.1 and 6.6 as there are forum users who tested
> > both.
> > 
> 
> This is now part of 6.1.70, however didn't land in 6.6.x series yet ...

Now queued up.

