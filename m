Return-Path: <stable+bounces-23241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 903AC85E941
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 21:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461D11F22E5B
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 20:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0573A1DB;
	Wed, 21 Feb 2024 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FzcIr0Ig"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75432574F
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708548754; cv=none; b=p145rN9iVDcGTKnwdwqM8p2O9dg657fvg+WQP5Ki8bLhzZJCl1CxKqbzlG6TliUZqor9NczUNKYzbHcMDfWV+CK7xJCu1ZWZ7JmH7FHWHl/IiWzgzDxKROZa+VPZ+FCHvzUxVQuvoORMofbZbnZj+pnAUfDiM3GogkUfUzq7EPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708548754; c=relaxed/simple;
	bh=E7YJqhkO9TTKcrlQDwJfDb4kzxHh24EHIBQLOWzdMDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1o9I6gxNVYTLjR+14ilWxz6Uz38ZYlFJ4ebffihACD7zdNoTSEAeV7xXr8/ZdAC8yM/HOGiEfmPIVddpeHJ9Mwxf3p0oHIKbfNONBPDgld8Y/ud+vwNM1fmu5ZHgE2sNdffaPXgbUxKrux7POySF4GDSwVomsG3njA3U29uYs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FzcIr0Ig; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Feb 2024 15:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708548749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaQvwiNWMiXtOAkVZAd3cKZiurfyS4+h2v2SCroQ62Y=;
	b=FzcIr0Ig2y3sP8Hm/A9fqh/p2ndiaKOWU3vFhd8nq//c8TGQwmTPo1ZMdkawzRB5p1Fvlc
	ghOVBCJAj4HdCjsvX3/kp2zSL8lNeyPsfljtNeTJsYs9W2WCTo0QuJCJNEkNJH6SJp1eou
	GEZyQyUMkl13Sej4UrfNcE5kvlDd/gY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Oleksandr Natalenko <oleksandr@natalenko.name>, Jiri Benc <jbenc@redhat.com>, Sasha Levin <sashal@kernel.org>, 
	stable@vger.kernel.org, Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: fs/bcachefs/
Message-ID: <diyeogauri6pqd2hqjn5tvtmgfb7yvtrbe4fc3xzp5xmpfhui3@czcp47ql2jgm>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <uknxc26o6td7g6rawxffvsez46djmvcy2532kza2zyjuj33k7p@4jdywourgtqg>
 <2024022103-municipal-filter-fb3f@gregkh>
 <4900587.31r3eYUQgx@natalenko.name>
 <2024022155-reformat-scorer-98ae@gregkh>
 <aaf2f030-b6f4-437b-bb4e-79aa4891ae56@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaf2f030-b6f4-437b-bb4e-79aa4891ae56@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 21, 2024 at 07:10:02PM +0100, Vlastimil Babka wrote:
> On 2/21/24 18:57, Greg KH wrote:
> > On Wed, Feb 21, 2024 at 05:00:05PM +0100, Oleksandr Natalenko wrote:
> >> On středa 21. února 2024 15:53:11 CET Greg KH wrote:
> >> > 	Given the huge patch volume that the stable tree manages (30-40 changes
> >> > 	accepted a day, 7 days a week), any one kernel subsystem that wishes to
> >> > 	do something different only slows down everyone else.
> >> 
> >> Lower down the volume then? Raise the bar for what gets backported?
> >> Stable kernel releases got unnecessarily big [1] (Jiří is in Cc).
> >> Those 40 changes a day cannot get a proper review. Each stable release
> >> tries to mimic -rc except -rc is in consistent state while "stable" is
> >> just a bunch of changes picked here and there.
> > 
> > If you can point out any specific commits that we should not be taking,
> > please let us know.
> > 
> > Personally I think we are not taking enough, and are still missing real
> > fixes.  Overall, this is only a very small % of what goes into Linus's
> > tree every day, so by that measure alone, we know we are missing things.
> 
> What % of what goes into Linus's tree do you think fits within the rules
> stated in Documentation/process/stable-kernel-rules.rst ? I don't know but
> "very small" would be my guess, so we should be fine as it is?
> 
> Or are the rules actually still being observed? I doubt e.g. many of the
> AUTOSEL backports fit them? Should we rename the file to
> stable-rules-nonsense.rst?

Yeah, I'd say around half of the backports I see being done really had
no justification at all - i.e. were for fixes for bugs that weren't
present on the kernel being backported to, including most of the autosel
patches.

There's clearly a balance to be struck with what we backport - but it
doesn't seem like Greg and Sasha are trying to find that balance, it
seems to be all pedal-to-the-metal backport-everything.

And the "process" seems to be whatever makes things most convenient for
Greg and Sasha, and they _really_ want to be doing everything
themselves. That form letter response quite illustrates that.

This doesn't scale.

And Greg not taking signed pull requests is a _real_ what the fuck. If
we care about supply chain attacks at all, surely we care about them for
stable, because those are the kernels most people actually run!

Greg, you're doing an end run around a lot of the process the
_community_ has built up.

