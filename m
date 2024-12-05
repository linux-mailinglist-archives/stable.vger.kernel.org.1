Return-Path: <stable+bounces-98816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C2C9E5826
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45BC282475
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001B7218AC2;
	Thu,  5 Dec 2024 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ajMR8PjT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AC31A28D
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733407882; cv=none; b=dYWZVQXHQAmofl/O+vp0a+bodgAtBr80MdGFgTZ2cvpXit5O9Xu7+MIDZfN+uWOsbZWrgQJN5PvqeZyiB4Jnl+j9zseEnewyflug0FJ3XPEu9xOZrIzqhlitoCqi1WykA6rFtZRu6LNApGqGdAlSWJ3Uaq5yDH8SwO1y4F51bzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733407882; c=relaxed/simple;
	bh=U9Z+lTk+PwCj+1wJ6ZpWhI5GRjo1CsAr3FpIHtOe3P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP9DbSJUKTqKlbss/SlKKNgT6EKISwNVyUX7iMks0dJDhG4QiATNYEOl4zmlI3Rrdwzp1d9WrXmlJKV4JigQizw+zpqDjSTX8yBByz824aC3H/Q8tI3thmb7A6mF9/PISc77AdMIsv4DL2Bypt/itZNsM85Pyasp/LN2Y/5u0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ajMR8PjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C9FC4CED1;
	Thu,  5 Dec 2024 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733407882;
	bh=U9Z+lTk+PwCj+1wJ6ZpWhI5GRjo1CsAr3FpIHtOe3P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ajMR8PjTm/3vmtJgNyL7MrfawuYqCig65ARs4W7ijeZr1NeOXqfy+Eu32YEF4w/nf
	 LBEW42aI7UxVLyotcIxvBQnjMnVHETW71wyfxNo4H1UQdZgwXicOFp9mEzsWFHUQUI
	 NLMMhFmnz2k46pGVsCjEeimblW4aSkQqWSG9XjbQ=
Date: Thu, 5 Dec 2024 15:11:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc: Alex Deucher <alexdeucher@gmail.com>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	"Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Subject: Re: drm/amd/display: Pass pwrseq inst for backlight and ABM
Message-ID: <2024120502-pedometer-palpitate-62e9@gregkh>
References: <CADnq5_PCqgDS=2Gh3QScfhutgY4wf4hoS15fW5Ox-nziXWGnBg@mail.gmail.com>
 <1733138635@msgid.manchmal.in-ulm.de>
 <2024120231-untimely-undivided-e1d7@gregkh>
 <1733403204@msgid.manchmal.in-ulm.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1733403204@msgid.manchmal.in-ulm.de>

On Thu, Dec 05, 2024 at 02:02:29PM +0100, Christoph Biedl wrote:
> Greg KH wrote...
> 
> > On Mon, Dec 02, 2024 at 12:33:48PM +0100, Christoph Biedl wrote:
> 
> > > tl;dr: Was it possible to have this in 6.1.y?
> (...)
> > Why not just move to 6.6.y instead?  What's preventing that from
> > happening?
> 
> Reasons are mostly political, also switching series this is a bigger
> change that naturally requires way more careful testing for regressions.

Then your testing infrastructure is wrong.  You need to do careful
testing for every stable release, as we sometimes do "major" things in
them (like rewrite the syscall path, no one noticed that...)

Your testing framework should be the same for any kernel change, "major"
or "minor".

> It will happen somewhen in the next year anyway, a cherry-picked fix
> could have been shipped now-ish. But it seems this is not an option.

Feel free to take it for your own tree if you feel it is needed.

thanks,

greg k-h

