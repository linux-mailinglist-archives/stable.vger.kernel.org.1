Return-Path: <stable+bounces-127525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEC6A7A438
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAF61739E2
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 13:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FF01EA91;
	Thu,  3 Apr 2025 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZGra0uJB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A346E33DB
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688023; cv=none; b=CLlCDWYtR5oehFkpVIJJV9tsSJR3drkG3FonW4yRFh2P2resOUy648ElggUU5xRSuqmDgUvD5424jQCfGc794pgjFRdSlduR2AX0znG6fksZ90NPf527gJTydSiEl0PvQFvmu9ZgwOdBosJs1V9m4grmXSV7ygyEGZJX9BEWmB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688023; c=relaxed/simple;
	bh=U3x4HpsvPH68R2e5I4HP0ZkBqepOKyRsV0O6GCH1ukY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRvmoIYESFxYvw4wmukPb0Nz7T7nsWX/Cfd92ldxktTsHBgfLFfVIN93IPYTXhHF74RLkuxOioNzPGg19amUY7uo1pGpzBmgJqhvS0aoClYFf/K0C/nghr4gZa14au5NPV9RZcMYXpkFpQwPeAag4SmcEM/8rM9zWDbqBPKGXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZGra0uJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A15C4CEE8;
	Thu,  3 Apr 2025 13:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743688023;
	bh=U3x4HpsvPH68R2e5I4HP0ZkBqepOKyRsV0O6GCH1ukY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGra0uJBqMF0i4p2/awW1+7Ch+KwBwMrOAICvJXO6xznECAD99PWMZuElQWyZKuYz
	 G9zAftWvGLyKionDSQgVKIwFHmJs7ImumZOVvMNHrTY7slteOIZKDDDZWI78oWf2a1
	 6J7Sw+YMX1USb3GVM6mjJu1OXSM9QyjD6xLCTtvQ=
Date: Thu, 3 Apr 2025 14:45:35 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Manthey, Norbert" <nmanthey@amazon.de>
Cc: "sashal@kernel.org" <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Improving Linux Commit Backporting
Message-ID: <2025040348-living-blurred-eb56@gregkh>
References: <f7ceac1ce5b3b42b36c7557feceadbb111e4850d.camel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7ceac1ce5b3b42b36c7557feceadbb111e4850d.camel@amazon.de>

On Thu, Apr 03, 2025 at 01:15:28PM +0000, Manthey, Norbert wrote:
> Dear Linux Stable Maintainers,
> 
> while maintaining downstream Linux releases, we noticed that we have to
> backport some patches manually, because they are not picked up by your
> automated backporting. Some of these backports can be done with
> improved cherry-pick tooling. We have implemented a script/tool "git-
> fuzzy-pick" which we would like to share. Besides picking more commits,
> the tool also supports executing a validation script right after
> picking, e.g. compiling the modified source file. Picking stats and
> details are presented below.
> 
> We would like to discuss whether you can integrate this improved tool
> into into your daily workflows. We already found the stable-tools
> repository [1] with some scripts that help automate backporting. To
> contribute git-fuzzy-pick there, we would need you to declare a license
> for the current state of this repository.

There's no need for us to declare the license for the whole repo, you
just need to pick a license for your script to be under.  Anything
that's under a valid open source license is fine with me.

That being said, I did just go and add SPDX license lines to all of the
scripts that I wrote, or that was already defined in the comments of the
files, to make it more obvious what they are under.

> To test backporting performance, we tried to backport stable-candidate
> patches from 6.12 to 6.1. Specifically, on tag 6.1.125 we executed the
> command stable show-missing-stable v6.12.12..v6.12.17 to collect
> patches considered for backporting. This results in 431 backport
> candidates. When using git-fuzzy-pick, we can pick 9 patches more than
> with default cherry-picking. All modifications have been validated by
> attempting to build the
> object files of the modified C source files with make using the kernels
> “allyesconfig” configuration.
> 
> 196 Cherry-picked with --strategy=recursive --Xpatience -x
>   1 Applied with patch -p1 ... --fuzz=1
>   8 Applied with patch -p1 ... --fuzz=2
> 
> Please let us know how to best share the tool with you! Long term, we
> would like to integrate it into your backporting workflow, so that more
> kernel commits can be applied automatically.

A long long time ago I used to apply patches with a whole lot of fuzz in
a semi-automated way much like this, but things slipped through all the
time.  So now, if we have a failure, I throw it back to the
developers/maintainers involved and let them and/or the community deal
with it if they want to have the commit backported.  That way they can
test and manually verify that the backport is correct.

So no, I don't recommend auto-fuzz-forcing any commits WITHOUT manually
looking and verifying and checking and taking responsibility for the
backport being correct.  Right now we are full of work just keeping up
with 40 commits a day in the stable trees.  If others wish to help out,
we are more than willing to take the backports that have been submitted
to us, and we now can handle them directly from the mailing lists even
easier than before, with Sasha's bot reporting any potential problems,
and my local scripts that properly apply them to the specific queues in
a "very few" key-stroke command from my email client.

So in summary, I'm more than willing to take a patch that adds your tool
to our repo, for others to use, but I don't want to be the one
responsible for running it.  I want others to take that responsibility
if they care about applying those patches to older kernels properly, as
it's the companies that care about those kernels that should be the ones
helping us out the most, instead of asking others to do this work for
them, don't you think?  :)

thanks,

greg k-h

