Return-Path: <stable+bounces-55979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D5D91AD41
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 18:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F5ADB21E62
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9D9199E95;
	Thu, 27 Jun 2024 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbFS+7gB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F9198A09
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507314; cv=none; b=MazsmHW61Po6ubZWOuJAkuWEUbWKxMEaTOV6vC5QT0cYEQtQygurElO1oFKFMABVlWnf1xyDSUNPdHbGKcy47cx/fM/Kef0lQc8n0FJu6viTtZE4fhbZ/m3bCtcHaQyjtw9c3JG8CZaSRmX73uQE50VQ4JlpTSHkg8wOXACm3dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507314; c=relaxed/simple;
	bh=FW5RRmLT2IL+VMhls4+uvFOumYRPlTRT59Hj6SNT4+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIH9T6EQyR1Yir/H1PvzmAMz6shxxCltEl+wj0rMMmMwtUTm0LX2iwl+2+PoWqDuCvbdDq2JoGYCtyO6ZnSnkTR13iL9PS62okrNNBgsXRHEFYINI2N2YRKP6OSusuOJOB0YV8nXOgl7jMr9mZ8uDExTraRv3KdX9fRv22T5WrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbFS+7gB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437D1C2BBFC;
	Thu, 27 Jun 2024 16:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719507314;
	bh=FW5RRmLT2IL+VMhls4+uvFOumYRPlTRT59Hj6SNT4+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IbFS+7gB+3NYKn/LbxngO2ld3UV+LFzsVtVMOBNQo5OJehTIIuYCGKWH9nCYAjOAX
	 bcfbeLgUP0fOZHMJLUvCLzzmXhCa29oQMCkASZ9D3IDCa1ihCn2P3x5CP50RODdPv4
	 S8wjJf/TUdjU/td2V6pa0uZTPIpDZscxqRNhE2A8Z1jJRQzU5Isdwi4yhbGliyeWGN
	 YX3X5RmnGp5Vs4IUV2W0iNNJSzojR6OE3yJeZcC0pyvARxU34jzqS1bNWSvrBBdhGe
	 OniCABq8Lk7Na+SXH2qYygWXMYIfYGzOVbicpL2ESjvR90c94TL7g0PaVzNZBKvWAM
	 GupWkK876lxpg==
Date: Thu, 27 Jun 2024 09:55:13 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>,
	Koen Vandeputte <koen.vandeputte@citymesh.com>
Subject: Re: Please backport 2ae5c9248e06 ("wifi: mac80211: Use flexible
 array in struct ieee80211_tim_ie")
Message-ID: <202406270953.338CBD20D5@keescook>
References: <fc31dd6f-ec32-4911-921f-1f34e9ad2449@quicinc.com>
 <2024062745-erased-statue-0a01@gregkh>
 <b77e4ae4-fea5-4032-9d76-fbefc1c5dc65@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b77e4ae4-fea5-4032-9d76-fbefc1c5dc65@quicinc.com>

On Thu, Jun 27, 2024 at 07:44:48AM -0700, Jeff Johnson wrote:
> On 6/27/2024 12:18 AM, Greg KH wrote:
> > On Wed, Jun 26, 2024 at 11:32:22AM -0700, Jeff Johnson wrote:
> >> Refer to:
> >> https://lore.kernel.org/all/CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com/
> > 
> > Please provide the information in the email, for those of us traveling
> > with store-and-forward email systems, links don't always work.
> 
> Apologies. I was trying to be concise, but over did it.
> 
> The issue reported is a splat in 6.6 due to FORTIFY_SOURCE complaining about
> access to an "old style" variable array declared with size 1:
>             u8 virtual_map[1];
> 
> >> Looks like this should be backported to all LTS kernels where FORTIFY_SOURCE
> >> is expected to be enabled.
> > 
> > And where would that exactly be?  Have you verified that it will apply
> > properly to those unnamed kernel trees?
> 
> I don't know which trees are actively enabling FORTIFY_SOURCE. Since the
> report is coming from 6.6, I would expect we should backport at least to there.

FWIW, FORTIFY_SOURCE is enabled in every distro kernel config I know of
(and has been for a very long time).

> I've cc'd Kees in case he has more definite information, as well as the
> wireless maintainers and the reporter in case they have anything else to add.
> 
> The actual fix is trivial, containing just a change to a data structure along
> with a related documentation change. Any conflicts would more likely occur due
> to the documentation rather than the code, since that code definition had been
> unchanged since 2012 but the documentation has been refined over time.

Right, this is fixing the splat -- no other behavioral changes were
seen.

-Kees

-- 
Kees Cook

