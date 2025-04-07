Return-Path: <stable+bounces-128563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE408A7E251
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 16:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45203442550
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589BC1E102E;
	Mon,  7 Apr 2025 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9VLy3hm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F301DC747
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035958; cv=none; b=Gfm6uWuEIFmMPVHiENpJ3pN8bY8xSaPfiG5kxT846KIDB2sStEmQYJ1EfHiFCb4cXqb1Z6ujYkJlaDxjBRm15mleRREe20idmUov6SPlhl2AT8qrcxk2QW7hz8z8oEcJtEsN6gHrHwL0feQKcFRXTkUKwCxxF9vgmDTGH2TruHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035958; c=relaxed/simple;
	bh=1yXNh3ivOOtRZ30oyz2D2IxLO8ipKlgxOXxrcCQb6sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4vEPFkIrqXbLJEHmJvSFdOX269F7g6X4ZLOpo0LJCX0LGE+PVcIP3uw96RZCSArCavVUhoWXoKHcGh3HDnjKE8xg5LvQJDSNoYdclSRdI3cVHTXUrQr5nU46ofrpMuzzjyVyXf7+68pf7CBGt9AENwFGZlzI0aHNgz+h67C5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9VLy3hm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02CBC4CEDD;
	Mon,  7 Apr 2025 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744035958;
	bh=1yXNh3ivOOtRZ30oyz2D2IxLO8ipKlgxOXxrcCQb6sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9VLy3hmX89acpLnMPvKZuPuo9uPLZoywDKWPO1FXBL7r7dFjrqWTRFzjZi4TQsqV
	 6hbw5LPbXyvTvGiJuNJgdV0C39VGnqWDF0+MuhkYH1buTk4HxNqkkACwnAB4kb5NRZ
	 y5CmIXUAFBXvoZPvDPLw5PT9NTPybDOPzs6JY5lk1pxYtjqdk2Wh3i5T9NGfPQIiq8
	 jWe3zUqxRiLxg39RGnJVCIlO9+SHJFBfCuo6uX7JPW7upPrlV2NLQnwEYfMRQIXWmA
	 HB/Qfd0B7w+klcfOdsPRvXJcpTPD851VZ9ZYno8GSq9wVyaX2YVKqyL1wLRN560WeO
	 ys1C7M/C3tbMw==
Date: Mon, 7 Apr 2025 10:25:54 -0400
From: Sasha Levin <sashal@kernel.org>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "Manthey, Norbert" <nmanthey@amazon.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Improving Linux Commit Backporting
Message-ID: <Z_Pgcov05F-H-UHw@lappy>
References: <f7ceac1ce5b3b42b36c7557feceadbb111e4850d.camel@amazon.de>
 <2025040348-living-blurred-eb56@gregkh>
 <2025040348-grant-unstylish-a78b@gregkh>
 <2025040311-overstate-satin-1a8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2025040311-overstate-satin-1a8f@gregkh>

On Thu, Apr 03, 2025 at 03:51:25PM +0100, gregkh@linuxfoundation.org wrote:
>On Thu, Apr 03, 2025 at 02:57:34PM +0100, gregkh@linuxfoundation.org wrote:
>> On Thu, Apr 03, 2025 at 02:45:35PM +0100, gregkh@linuxfoundation.org wrote:
>> > On Thu, Apr 03, 2025 at 01:15:28PM +0000, Manthey, Norbert wrote:
>> > > Dear Linux Stable Maintainers,
>> > >
>> > > while maintaining downstream Linux releases, we noticed that we have to
>> > > backport some patches manually, because they are not picked up by your
>> > > automated backporting. Some of these backports can be done with
>> > > improved cherry-pick tooling. We have implemented a script/tool "git-
>> > > fuzzy-pick" which we would like to share. Besides picking more commits,
>> > > the tool also supports executing a validation script right after
>> > > picking, e.g. compiling the modified source file. Picking stats and
>> > > details are presented below.
>> > >
>> > > We would like to discuss whether you can integrate this improved tool
>> > > into into your daily workflows. We already found the stable-tools
>> > > repository [1] with some scripts that help automate backporting. To
>> > > contribute git-fuzzy-pick there, we would need you to declare a license
>> > > for the current state of this repository.
>> >
>> > There's no need for us to declare the license for the whole repo, you
>> > just need to pick a license for your script to be under.  Anything
>> > that's under a valid open source license is fine with me.
>> >
>> > That being said, I did just go and add SPDX license lines to all of the
>> > scripts that I wrote, or that was already defined in the comments of the
>> > files, to make it more obvious what they are under.
>>
>> Wait, you should be looking at the scripts in the stable-queue.git tree
>> in the scripts/ directory.  You pointed at a private repo of some things
>> that Sasha uses for his work, which is specific to his workflow.
>
>Also, one final things.  Doing backports to older kernels is a harder
>task than doing it for newer kernels.  This means you need to do more
>work, and have a more experienced developer do that work, as the nuances
>are tricky and slight and they must understand the code base really
>well.
>
>Attempting to automate this, and make it a "junior developer" task
>assignment is ripe for errors and problems and tears (on my side and
>yours.)  We have loads of examples of this in the past, please don't
>duplicate the errors of others and think that "somehow, this time it
>will be different!", but rather "learn from our past mistakes and only
>make new ones."
>
>Good luck with backporting, as I know just how hard of a task this
>really is.  And obviously, you are learning that too :)

I've played with wiggle[1] in the past, which does all what you've
described and more.

It introduced too many issues, where it wasn't worth doing it. I really
think that the better solution here is to figure out dependencies and
bring them in.

I'd advise against using such tool at the scale of -stable :)

[1] https://github.com/neilbrown/wiggle

-- 
Thanks,
Sasha

