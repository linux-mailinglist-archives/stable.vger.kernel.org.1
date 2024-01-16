Return-Path: <stable+bounces-11353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E0C82F369
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 18:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CDD1C23778
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 17:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD351CABA;
	Tue, 16 Jan 2024 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GmzkVcmD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DA61CAB2
	for <stable@vger.kernel.org>; Tue, 16 Jan 2024 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427044; cv=none; b=P560LwMy6kW/pWZWhh/dgYIFsGSpH1/76bsTztW1uXWAX1ts80Ep73FVQFzY/1/+XEZ3lL3PLGa9oQzDkPBFrPtQdEZM+Hg5xLAiWaEyxJV6lypAtxbTiHEXSBepNeCa4NABUncSifyncxA9GuboOPsN+IOr+IW0L/5XffCU8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427044; c=relaxed/simple;
	bh=BnGmetIxwYZGo6XR0Wr9y46T7cLqt411cCoM2s3SavM=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=Zv9qqpEUfLGdWG3lGtSgG5BIxp0IAhRHoWEFGiZVk6p/rCpM2dWhP5UOWsw9juQW62tIKobHL27zdSwtBcDi4cIN46x2H/cetGYBWDl4bviFwbspxzRwU0EiEPbxczajYNp0lf6MCNXV1Zw08iXfXw0TWVKT54MAFWnkFXwzC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GmzkVcmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC656C433C7;
	Tue, 16 Jan 2024 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705427044;
	bh=BnGmetIxwYZGo6XR0Wr9y46T7cLqt411cCoM2s3SavM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmzkVcmDcPC85lc1i/l3cerzZjTA5aXLuknX+WEUlUnbAGMslEDOmRdZZ1pd5/OkW
	 GiVFD3r0y4oXGKfkJMZZJkbNSD4+oMWY21uoLB44kovd0rY0JXTQ/75dvDwhrl/KeK
	 AwBLlYWkAxNGjBi2JeO2fhr3V+x0Tf3CHHwimL2Q=
Date: Tue, 16 Jan 2024 18:44:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <2024011644-lifter-evade-c485@gregkh>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <2024011614-modify-primer-65dd@gregkh>
 <2ve257m37wusszvzkr254hp62nvxecmdcnybmft5ebl6n7hesj@yelqgrderuay>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ve257m37wusszvzkr254hp62nvxecmdcnybmft5ebl6n7hesj@yelqgrderuay>

On Tue, Jan 16, 2024 at 12:26:38PM -0500, Kent Overstreet wrote:
> On Tue, Jan 16, 2024 at 03:13:08PM +0100, Greg KH wrote:
> > On Mon, Jan 15, 2024 at 05:12:17PM -0500, Kent Overstreet wrote:
> > > Hi stable team - please don't take patches for fs/bcachefs/ except from
> > > myself; I'll be doing backports and sending pull requests after stuff
> > > has been tested by my CI.
> > 
> > Now done:
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=9bf1f8f1ca9ae53cf3bc8781e4efdb6ebaee70db
> > 
> > We will ignore it for any "Fixes:" tags, or AUTOSEL, but if you
> > explicitly add a "cc: stable@" in the signed-off-by area, we will pick
> > that up.
> 
> Would it work for your process to ignore cc: stable@ as well?

Nope!  That's explicit, you add it for when you want us to pick up a
change when it hits Linus's tree.  If you don't want that to happen,
then don't add it.

> I want a tag that I can have tooling grep for later that means "this
> patch should be backported later, after seeing sufficient testing", and
> cc: stable@ has that meaning in current usage.

Just use a "Fixes:" tag then, that's what networking did for years
before they gave up and now use cc: stable.

thanks,

greg k-h

