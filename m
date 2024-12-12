Return-Path: <stable+bounces-100927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C31BA9EE8FB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE11116633B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAA6214A86;
	Thu, 12 Dec 2024 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kyfpSQUE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3622135B0
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014118; cv=none; b=d8L4DKp26v/vUeVUOw2t7HUEHh9u/FAA9x8Ib5mUWOW02/8vkRMpFau1Mi3BBTBX672+ylvyNCDtEyl8a2NflveODgSito4mQGZVWj11+7eSwAtEbgF0aXmZBKvwCr6dD0t6QzQpTpl0jiDXMwOLUm3S0u8q+SqUe2ox2IUnsDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014118; c=relaxed/simple;
	bh=qkzXcDqAglK4nWPeT8NLbKFcTcqwFD2afn9mc7KeS38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqTQlHwapNBfw08fS4nJnu4eftKfgsIfsoCmPuwloB6in1d6b2EoKpNB2iOAyk0tf5rywTsCs9HTxHWoqawHSZ8NegMmz/hcFoLe4K6ImysccChdkyHtElwBY9ANnkaWl06goddpzO1HIkYOH0tBYdr9jXrundnBuB4U72Le+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kyfpSQUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BE5C4CECE;
	Thu, 12 Dec 2024 14:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734014118;
	bh=qkzXcDqAglK4nWPeT8NLbKFcTcqwFD2afn9mc7KeS38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kyfpSQUEyCOTAD8UjM6UBCA1Xo8kxQhEblzATbTDnttxX0xkv/7ng0bfjZpW2eaFC
	 NzuaVcIdXACiOQnxeX7wPxRkLOyJRgKUF2mGq7zcWUlE4qvf5oOcBlUuBhEdUrO4j9
	 +kONTjbBXo5XnhrOBerFdqVNvqHVthgXhXnGAEAY=
Date: Thu, 12 Dec 2024 15:35:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux@roeck-us.net, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] clocksource: Make negative motion
 detection more robust" failed to apply to 6.12-stable tree
Message-ID: <2024121205-override-postbox-5ed6@gregkh>
References: <2024121203-griminess-blah-4e97@gregkh>
 <87ikrp9f59.ffs@tglx>
 <2024121232-obligate-varsity-e68f@gregkh>
 <2024121235-impale-paddle-8f94@gregkh>
 <87frmt9dl3.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frmt9dl3.ffs@tglx>

On Thu, Dec 12, 2024 at 03:32:24PM +0100, Thomas Gleixner wrote:
> On Thu, Dec 12 2024 at 15:18, Greg KH wrote:
> > On Thu, Dec 12, 2024 at 03:17:03PM +0100, Greg KH wrote:
> >> > But I don't think these two commits are necessarily stable material,
> >> > though I don't have a strong opinion on it. If c163e40af9b2 is
> >> > backported, then it has it's own large dependency chain on pre 6.10
> >> > kernels...
> >> 
> >> It's in the queues for some reason, let me figure out why...
> >
> > Ah, it was an AUTOSEL thing, I'll go drop it from all queues except
> > 6.12.y for now, thanks.
> >
> > But, for 6.12.y, we want this fixup too, right?
> 
> If you have c163e40af9b2 pulled back into 6.12.y, then yes. I don't know
> why this actually rejects. I just did
> 
> git-cherry-pick c163e40af9b2
> git-cherry-pick 51f109e92935
> 
> on top of v6.12.4 and that just worked fine.

The build breaks :(

