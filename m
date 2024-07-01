Return-Path: <stable+bounces-56219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C88F91DFB7
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE28B24966
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6642815AACD;
	Mon,  1 Jul 2024 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FTYUinPb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2519213D614
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837917; cv=none; b=b4THOq0ewtI0tzIxiz+Q4SIrjs7suAdY+uOSAt3INxG9ksVzxWmmGUcCAG+9YWQuQMzK2u2Pp0e2dppGqg6zeWUdD5vl8zse3Ep390y7FG8H8uFX3pMTJjymXZpM9ux4NTyShlrlK1FzeQXSmrWjRTcntfsJfFD/baXVHZawmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837917; c=relaxed/simple;
	bh=QOsLTVwinpN1LVFEuMPk65eKUlZjDpB42b7URqt2h9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZSOuFfN+T1UC2m4LlADOSj+6Di1T7UybYXC7lsWQMS3/WuM7dKZr4gW4z2koFhrUeGNL0gk5l0NngA2N1usF2UlUnDJZLFV9eB8W00I9zvMEAu4Sh9fB14JVqfbdsTBIgqoz/94oJo14IUrP2ZHQZ+fSvvhvpD4FRa535y2q3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FTYUinPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547FDC116B1;
	Mon,  1 Jul 2024 12:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719837916;
	bh=QOsLTVwinpN1LVFEuMPk65eKUlZjDpB42b7URqt2h9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTYUinPbsiSY0HOoFL0Q9LyZ0TKbLuyUMpmIUMUUffN12xCr/rqWxETX0G5ymDS47
	 UQYjxD1bMiz8PQu03cKHiTSKZdyLhSvVFBRin9TLJ0qjZv7xSY5QjgHTkOuTpthFmA
	 y11SsdmVlmUsYJukF3oGvtDEQxriBo9kyZN0yuV0=
Date: Mon, 1 Jul 2024 14:26:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: stable@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
	Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	Koen Vandeputte <koen.vandeputte@citymesh.com>
Subject: Re: Please backport 2ae5c9248e06 ("wifi: mac80211: Use flexible
 array in struct ieee80211_tim_ie")
Message-ID: <2024070120-celestial-economist-32de@gregkh>
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

It does not apply to 6.6.y, sorry, please provide a working backport for
any tree you wish to see this applied to.

thanks,

greg k-h

