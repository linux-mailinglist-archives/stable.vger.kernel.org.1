Return-Path: <stable+bounces-5290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B1280C874
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D13B281EFD
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0449038DD9;
	Mon, 11 Dec 2023 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ikZi0cT1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC930670
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 11:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF58DC433C8;
	Mon, 11 Dec 2023 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702295426;
	bh=YkUG1nJUsq040bEK6vuGgwaAZZ6RKtJO9bz9YNQHGZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikZi0cT1SIzXZ/Ykbw3KoGOEZxRuZnIAtmt8sxWoe0nCOXmKsUjxm/Y2zQ2/QKGTt
	 adLuTHQNEiYwl2SbG6xHAVVaJxOr1TcJQ7lu30wkNdHD2Nymkl24qzx8HAV7SxPLWe
	 cOxLatyfrLlDcr3Qf6NjIi8H1+1ZLECG75ophJnE=
Date: Mon, 11 Dec 2023 12:50:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: leo@leolam.fr, Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org
Subject: Re: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Message-ID: <2023121151-semisoft-tingly-f158@gregkh>
References: <e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org>
 <2023121139-scrunch-smilingly-54f4@gregkh>
 <aee3e5a0-94b5-4c19-88e4-bb6a8d1fafe3@manjaro.org>
 <2023121127-obstinate-constable-e04f@gregkh>
 <2023121128-unlighted-bagful-f6f1@gregkh>
 <fbd66e83-4aa4-4d48-972a-e41d4ec905f9@manjaro.org>
 <8008134b-c830-47ed-adc5-81a8162e4fb5@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8008134b-c830-47ed-adc5-81a8162e4fb5@manjaro.org>

On Mon, Dec 11, 2023 at 05:17:47PM +0700, Philip Müller wrote:
> On 11.12.23 16:46, Philip Müller wrote:
> > On 11.12.23 16:40, Greg Kroah-Hartman wrote:
> > > On Mon, Dec 11, 2023 at 10:39:26AM +0100, Greg Kroah-Hartman wrote:
> > > > On Mon, Dec 11, 2023 at 04:26:26PM +0700, Philip Müller wrote:
> > > > > On 11.12.23 16:25, Greg Kroah-Hartman wrote:
> > > > > > On Mon, Dec 11, 2023 at 04:02:11PM +0700, Philip Müller wrote:
> > > > > > > Hi Johannes, hi Greg,
> > > > > > > 
> > > > > > > Any tree that back-ported 7e7efdda6adb wifi:
> > > > > > > cfg80211: fix CQM for non-range
> > > > > > > use that does not contain 076fc8775daf wifi:
> > > > > > > cfg80211: remove wdev mutex
> > > > > > > (which does not apply cleanly to 6.6.y or 6.6.1) will be affected.
> > > > > > > 
> > > > > > > You can find a downstream bug report at Arch Linux:
> > > > > > > 
> > > > > > > https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/17
> > > > > > > 
> > > > > > > So we should either revert 7e7efdda6adb or backport
> > > > > > > the needed to those
> > > > > > > kernel series. 6.7.y is reported to work with 6.7.0-rc4.
> > > > > > 
> > > > > > Yeah, this looks bad, I'll go just revert this for now and push out a
> > > > > > new release with the fix as lots of people are hitting it.
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > > greg k-h
> > > > > 
> > > > > 
> > > > > Hi Greg,
> > > > > 
> > > > > there is actually a fix for it:
> > > > > 
> > > > > https://www.spinics.net/lists/stable/msg703040.html
> > > > 
> > > > That "fix" was not cc:ed to any of the wifi developers and would need a
> > > > lot of review before I feel comfortable accepting it, as I said in the
> > > > response to that message.
> > > > 
> > > > Also, please point to lore.kernel.org lists, it's much easier to handle
> > > > as we don't have any control over any other archive web site.
> > > 
> > > Also, have you tested that proposed fix?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Not yet. Currently build kernels on my end to see if it fixes the
> > regression. A revert of the patch is confirmed to work also by users who
> > have the issue. I can check with mine, when I've released a kernel with
> > Léo Lam's fix.
> > 
> 
> According to the author of the patch, it was not yet tested:
> 
> This is a kernel bug on the 6.6.x stable branch. As people have correctly
> pointed out, 4a7e92551618 ("wifi: cfg80211: fix CQM for non-range use"
> backported to 6.6.x) is the culprit as it causes cfg80211_cqm_rssi_update
> not to release the wdev lock in some cases - which then causes various other
> things to deadlock.
> 
> I have submitted a patch:
> https://lore.kernel.org/stable/20231210213930.61378-1-leo@leolam.fr/T/
> 
> I'm pretty sure it will fix the issue but I haven't tested it.
> 
> https://bbs.archlinux.org/viewtopic.php?pid=2136529#p2136529
> 
> There is an Arch Kernel with that patch applied for testing:
> https://bbs.archlinux.org/viewtopic.php?pid=2136533#p2136533
> 
> The proper fix seems to be '076fc8775daf wifi: cfg80211: remove wdev mutex'
> which does not apply cleanly to either 6.6.y or 6.1.y as stated here:
> https://bbs.archlinux.org/viewtopic.php?pid=2136579#p2136579

6.6.6 is out now which should fix the issue for the distros to pick up,
it reverts the offending commit.  Now we can take the time to fix this
up "properly" if developers want to.

thanks,

greg k-h

