Return-Path: <stable+bounces-20876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A2C85C57C
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C5F283C7E
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342E614AD00;
	Tue, 20 Feb 2024 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ONNcYMz4"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692F814A0A4
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459583; cv=none; b=HCkl7Cq9zcSXFVeD9+Qc0SC2jqD/d8c25rX2w+UoDCSaHXRMpqC9O3TPRbjOqgSESwM7SXPJ4K9Tw8HR+P5BUVN8yjanNX2jiwpPe8V5rIFEWN+gK59e6rLtZl3Wr+zvXwG9C+P1QGA80IYSFMBCnMrHzX3EyR62sWGsoYkRQ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459583; c=relaxed/simple;
	bh=pg38rS8S2A1gPabej2HtUmI7TYSVqjZyucQFfNM5+YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JscE1X66rBgidLudnH60x4EWF1p3gCNEAqiV/tQLw+V1GIQv2DONo4nXJHcA2wfR8cyf7p0TXU8XfVJ9M/giJgRUlebu6Y77F+8x4nlW4gFPKRZjwoKmB1Md+k0KRFv9hswCc2n6mRIGAzalTgbvBet1WiAh7GDMPwQq/4QG53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ONNcYMz4; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Feb 2024 15:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708459578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r0bDVeRy/B4z5JVPDIUowCP8fteJCwRoaDNyBKO14kc=;
	b=ONNcYMz4m7w3Xu5m+C4YdqZD3tBy21CuffnM1h+gAutXaQTJeobrp5chKgwBCrggrQzk2Q
	tC2rNRMNb2KZfQhvnUxceH1ubvKZay3+d55y1uS5TaMhb3mP46aLnJqPi6hO+T2+cxEBHa
	eVW5TCSfyRx4rM8iObjLc1v92uJNYoQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <g2jlxm6hcpywrezexi3kxrl6nu7bdmkoafa2kh2ptcf7olhofl@ycilgjsqyycq>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <ZaW5r5kRbOcKveVn@sashalap>
 <dlxqudswz64v6xn3fg2i6ob2msnytaatmnyhq4ivi7notzs6jf@itt42d42zmsw>
 <2024022056-monkhood-fossil-ec02@gregkh>
 <2024022007-buggy-operator-2dc5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022007-buggy-operator-2dc5@gregkh>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 20, 2024 at 07:53:04PM +0100, Greg KH wrote:
> On Tue, Feb 20, 2024 at 07:03:23PM +0100, Greg KH wrote:
> > On Tue, Feb 20, 2024 at 12:23:33PM -0500, Kent Overstreet wrote:
> > > On Mon, Jan 15, 2024 at 06:03:11PM -0500, Sasha Levin wrote:
> > > > On Mon, Jan 15, 2024 at 05:12:17PM -0500, Kent Overstreet wrote:
> > > > > Hi stable team - please don't take patches for fs/bcachefs/ except from
> > > > > myself; I'll be doing backports and sending pull requests after stuff
> > > > > has been tested by my CI.
> > > > > 
> > > > > Thanks, and let me know if there's any other workflow things I should
> > > > > know about
> > > > 
> > > > Sure, we can ignore fs/bcachefs/ patches.
> > > 
> > > I see that you even acked this.
> > > 
> > > What the fuck?
> > 
> > Accidents happen, you were copied on those patches.  I'll go drop them
> > now, not a big deal.
> 
> Wait, why are you doing "Fixes:" with an empty tag in your commits like
> 1a1c93e7f814 ("bcachefs: Fix missing bch2_err_class() calls")?
> 
> That's messing with scripts and doesn't make much sense.  Please put a
> real git id in there as the documentation suggests to.

There isn't always a clear-cut commit when a regression was introduced
(it might not have been a regresison at all). I could dig and make
something up, but that's slowing down your workflow, and I thought I was
going to be handling all the stable backports for fs/bcachefs/, so - ?

