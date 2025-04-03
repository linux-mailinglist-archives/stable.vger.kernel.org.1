Return-Path: <stable+bounces-127559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD58A7A5B4
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93B2164D24
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B62500CD;
	Thu,  3 Apr 2025 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jOkzUol6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76102505A4
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691972; cv=none; b=U7q6U3MPYc1sXXqaBqypg59TGo0TOKOB1mjPgPWoHWmwogXKv+A6sTw9di+Ei0ZpPXPALY+riwY86ioT6DGaujDBTDSp0fzFwAGDNts5KtzSVgWDJrJMsa3VmZ28MPKL6qGgymdbWmAymn0QvrwvSrSeHNmynUFjIoVHvYByvbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691972; c=relaxed/simple;
	bh=39+2Zy+n/7FbP3hAeFStoHGygZ+QE4Mo1EYhmuQjlqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTp0a5argYJ0VO8NXYc8Yx/uXp1wbnNxkEGmPPz7/HRLCjnrIQ9L2oUVBWy+7E0vxoWP6mlT7YAT2Inf9xLhTvyebZnvm1FszUTc/yWJ9XOVcBRROv1RkltsyT5c1kqf+RSYUTpcVTzzICqbHrOCYU4i13Jd7k46V8NpJzE0pDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jOkzUol6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502D8C4CEE3;
	Thu,  3 Apr 2025 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743691972;
	bh=39+2Zy+n/7FbP3hAeFStoHGygZ+QE4Mo1EYhmuQjlqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOkzUol6tIAnTbG9Ic2+cyLHOxu1AEIatshAGF5SnpYefLBt/nfAA251Emyb9Ua5p
	 SrzsB+uEmboTPlhS3AVv79fpVqNkbr4XLHVQpo8ougKxj37GXnNnB+3zgG1BYbG3aa
	 XUU2gscRRhYmTrV0lIIgxIdfQubTO8Vu6EWoaX/c=
Date: Thu, 3 Apr 2025 15:51:25 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Manthey, Norbert" <nmanthey@amazon.de>
Cc: "sashal@kernel.org" <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Improving Linux Commit Backporting
Message-ID: <2025040311-overstate-satin-1a8f@gregkh>
References: <f7ceac1ce5b3b42b36c7557feceadbb111e4850d.camel@amazon.de>
 <2025040348-living-blurred-eb56@gregkh>
 <2025040348-grant-unstylish-a78b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025040348-grant-unstylish-a78b@gregkh>

On Thu, Apr 03, 2025 at 02:57:34PM +0100, gregkh@linuxfoundation.org wrote:
> On Thu, Apr 03, 2025 at 02:45:35PM +0100, gregkh@linuxfoundation.org wrote:
> > On Thu, Apr 03, 2025 at 01:15:28PM +0000, Manthey, Norbert wrote:
> > > Dear Linux Stable Maintainers,
> > > 
> > > while maintaining downstream Linux releases, we noticed that we have to
> > > backport some patches manually, because they are not picked up by your
> > > automated backporting. Some of these backports can be done with
> > > improved cherry-pick tooling. We have implemented a script/tool "git-
> > > fuzzy-pick" which we would like to share. Besides picking more commits,
> > > the tool also supports executing a validation script right after
> > > picking, e.g. compiling the modified source file. Picking stats and
> > > details are presented below.
> > > 
> > > We would like to discuss whether you can integrate this improved tool
> > > into into your daily workflows. We already found the stable-tools
> > > repository [1] with some scripts that help automate backporting. To
> > > contribute git-fuzzy-pick there, we would need you to declare a license
> > > for the current state of this repository.
> > 
> > There's no need for us to declare the license for the whole repo, you
> > just need to pick a license for your script to be under.  Anything
> > that's under a valid open source license is fine with me.
> > 
> > That being said, I did just go and add SPDX license lines to all of the
> > scripts that I wrote, or that was already defined in the comments of the
> > files, to make it more obvious what they are under.
> 
> Wait, you should be looking at the scripts in the stable-queue.git tree
> in the scripts/ directory.  You pointed at a private repo of some things
> that Sasha uses for his work, which is specific to his workflow.

Also, one final things.  Doing backports to older kernels is a harder
task than doing it for newer kernels.  This means you need to do more
work, and have a more experienced developer do that work, as the nuances
are tricky and slight and they must understand the code base really
well.

Attempting to automate this, and make it a "junior developer" task
assignment is ripe for errors and problems and tears (on my side and
yours.)  We have loads of examples of this in the past, please don't
duplicate the errors of others and think that "somehow, this time it
will be different!", but rather "learn from our past mistakes and only
make new ones."

Good luck with backporting, as I know just how hard of a task this
really is.  And obviously, you are learning that too :)

greg k-h

