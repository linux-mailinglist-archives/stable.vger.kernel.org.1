Return-Path: <stable+bounces-20881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238C985C5B4
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B571F2264D
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164937867A;
	Tue, 20 Feb 2024 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iehoQtqy"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216FF768F1
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 20:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460587; cv=none; b=J2Zb3KET1jnQDTscCE7llIqTxnCf494COlnGhJkpzUsNXKdnyIStipa0DNh0WT49DE/Y4y7LRuBUiA4BxpDDoOay/eBFNMyYs9f/WQDfW3/2owx7m9tiFynaVt8II4EWGbWxy/HrgxaTVXoM6220rObOvtYyXRPCOiCKgJn0asc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460587; c=relaxed/simple;
	bh=vcCeL8a/MgNpmbBIT4uIr4/iLTxABFQ9nePVEjU4LxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDreOyJ+AGR8pZawKPWGOvF6SbsilODL2scsx447KI5rZS0BMkRHwRiPB3pDKM3dw5U/kM6HZknxeuUEvtitzAxHWcz8uuxBerCe/BqrBnXWGxyb01pg9IabnrwZ/U86w05bM8JoSVIb9tjyhIt44gZRLO7QKnBUd5NeGpEgm1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iehoQtqy; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Feb 2024 15:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708460583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JtiuJGUe4cTuWvvZPldkzXAxpcBSPT8p0lAIjoEDolQ=;
	b=iehoQtqyVmSm6J58GoAA3j6DmvtkYuH0WOh0wxrhUjkGSyZeJBTxEwzE/Z1mgozrzxOuLO
	1/Zeh0Msa9tzpC8jqeQlCO9BUTKJlxru4+YbZkx7+xJ4UQWeYBDam676zTl6pJfYPtC+dF
	ONSS1ESrOTkJpsnsYSLap+2YPZj020Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <3w7o757uc4pvntklwd2lmcpdxca6wcabus5co43ia2cup5qyl5@4c2fcnbh4i7r>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <ZaW5r5kRbOcKveVn@sashalap>
 <dlxqudswz64v6xn3fg2i6ob2msnytaatmnyhq4ivi7notzs6jf@itt42d42zmsw>
 <2024022056-monkhood-fossil-ec02@gregkh>
 <2024022007-buggy-operator-2dc5@gregkh>
 <g2jlxm6hcpywrezexi3kxrl6nu7bdmkoafa2kh2ptcf7olhofl@ycilgjsqyycq>
 <2024022022-viewless-astronaut-ab8c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022022-viewless-astronaut-ab8c@gregkh>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 20, 2024 at 09:19:01PM +0100, Greg KH wrote:
> On Tue, Feb 20, 2024 at 03:06:14PM -0500, Kent Overstreet wrote:
> > On Tue, Feb 20, 2024 at 07:53:04PM +0100, Greg KH wrote:
> > > On Tue, Feb 20, 2024 at 07:03:23PM +0100, Greg KH wrote:
> > > > On Tue, Feb 20, 2024 at 12:23:33PM -0500, Kent Overstreet wrote:
> > > > > On Mon, Jan 15, 2024 at 06:03:11PM -0500, Sasha Levin wrote:
> > > > > > On Mon, Jan 15, 2024 at 05:12:17PM -0500, Kent Overstreet wrote:
> > > > > > > Hi stable team - please don't take patches for fs/bcachefs/ except from
> > > > > > > myself; I'll be doing backports and sending pull requests after stuff
> > > > > > > has been tested by my CI.
> > > > > > > 
> > > > > > > Thanks, and let me know if there's any other workflow things I should
> > > > > > > know about
> > > > > > 
> > > > > > Sure, we can ignore fs/bcachefs/ patches.
> > > > > 
> > > > > I see that you even acked this.
> > > > > 
> > > > > What the fuck?
> > > > 
> > > > Accidents happen, you were copied on those patches.  I'll go drop them
> > > > now, not a big deal.
> > > 
> > > Wait, why are you doing "Fixes:" with an empty tag in your commits like
> > > 1a1c93e7f814 ("bcachefs: Fix missing bch2_err_class() calls")?
> > > 
> > > That's messing with scripts and doesn't make much sense.  Please put a
> > > real git id in there as the documentation suggests to.
> > 
> > There isn't always a clear-cut commit when a regression was introduced
> > (it might not have been a regresison at all). I could dig and make
> > something up, but that's slowing down your workflow, and I thought I was
> > going to be handling all the stable backports for fs/bcachefs/, so - ?
> > 
> 
> Doesn't matter, please do not put "fake" tags in commit messages like
> this.  It hurts all of the people that parse commit logs.  Just don't
> put a fixes tag at all as the documentation states that after "Fixes:" a
> commit id belongs.

Then there's a gap, because I need a tag that I can stick in a commit
message that says "this is a bugfix I need to consider backporting
later", and the way you want the Fixes: tag used doesn't meet my needs.

