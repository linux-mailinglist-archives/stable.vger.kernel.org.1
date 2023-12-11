Return-Path: <stable+bounces-5273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC73180C4E9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 10:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8141B1F21074
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 09:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043D721378;
	Mon, 11 Dec 2023 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0mObMuek"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A2521373
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 09:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5CEC433C7;
	Mon, 11 Dec 2023 09:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702287642;
	bh=XQLeFsj1eeUalaViR6qSBhTKxvXo5hq55n1+mxbacpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0mObMuekaED+969DG7MG3dMQ3Yfd0jWeSKO8l5WUilY/ZcmK2nXstn4BvkeYVTP3b
	 2Iva+C9dm/9PwZS+nx5t/bV9u3xurF5+wwQ+KSkEmW48Ab5XC2V1QvK0EszJrgC/m0
	 +zabeoQM3s944xZAeenBH+RkWRmDga7kxTr+aAqQ=
Date: Mon, 11 Dec 2023 10:40:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: Johannes Berg <johannes.berg@intel.com>, stable@vger.kernel.org
Subject: Re: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Message-ID: <2023121128-unlighted-bagful-f6f1@gregkh>
References: <e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org>
 <2023121139-scrunch-smilingly-54f4@gregkh>
 <aee3e5a0-94b5-4c19-88e4-bb6a8d1fafe3@manjaro.org>
 <2023121127-obstinate-constable-e04f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023121127-obstinate-constable-e04f@gregkh>

On Mon, Dec 11, 2023 at 10:39:26AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 11, 2023 at 04:26:26PM +0700, Philip Müller wrote:
> > On 11.12.23 16:25, Greg Kroah-Hartman wrote:
> > > On Mon, Dec 11, 2023 at 04:02:11PM +0700, Philip Müller wrote:
> > > > Hi Johannes, hi Greg,
> > > > 
> > > > Any tree that back-ported 7e7efdda6adb wifi: cfg80211: fix CQM for non-range
> > > > use that does not contain 076fc8775daf wifi: cfg80211: remove wdev mutex
> > > > (which does not apply cleanly to 6.6.y or 6.6.1) will be affected.
> > > > 
> > > > You can find a downstream bug report at Arch Linux:
> > > > 
> > > > https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/17
> > > > 
> > > > So we should either revert 7e7efdda6adb or backport the needed to those
> > > > kernel series. 6.7.y is reported to work with 6.7.0-rc4.
> > > 
> > > Yeah, this looks bad, I'll go just revert this for now and push out a
> > > new release with the fix as lots of people are hitting it.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > 
> > Hi Greg,
> > 
> > there is actually a fix for it:
> > 
> > https://www.spinics.net/lists/stable/msg703040.html
> 
> That "fix" was not cc:ed to any of the wifi developers and would need a
> lot of review before I feel comfortable accepting it, as I said in the
> response to that message.
> 
> Also, please point to lore.kernel.org lists, it's much easier to handle
> as we don't have any control over any other archive web site.

Also, have you tested that proposed fix?

thanks,

greg k-h

