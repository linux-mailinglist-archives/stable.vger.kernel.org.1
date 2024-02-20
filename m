Return-Path: <stable+bounces-20862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5274E85C409
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 19:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D331F22A9A
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 18:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A292F12EBEC;
	Tue, 20 Feb 2024 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jj0pamni"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92E7867A
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455188; cv=none; b=hiaKZMKl5oxUONoL3u+xkaC1CSar0KRGnzOqOhbmE8bP+keQ6xMBkNq0XCC2KkLz0C06rVI113s1wp4s9u9H16L+vH9JwsD620OY9vT0cmCHO3D/HXyUh/MsuFGKiOp49E3imxnm3EnGAWb1ziCImxDoJQJzI2erG6+cEZdELBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455188; c=relaxed/simple;
	bh=al+NxzkrQ6yVMNOqEtiMMgz5aK77Q0Ydel9GpoS434Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTYdRftHj3Egxx9u8/0BtnpqZxy83A9ezBqn6EvG6ITIvDb4vzsWtzbLns7oBDY7Y8CvHkOrN/WZBCaYp6TTFWn7Pc6xZIcOm+LtFQMdpkSaadGBcbdszbz0d/erMk95KuXST67tUKVNYBt/EB5XJBW4irP5FlCkLUC4xUfAaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jj0pamni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE5BC433C7;
	Tue, 20 Feb 2024 18:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708455187;
	bh=al+NxzkrQ6yVMNOqEtiMMgz5aK77Q0Ydel9GpoS434Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jj0pamnilsW/vsqV5utZ9sOlRUu+NpP9wVY6EZw8COQFA1n62rWpt+vLPr95xDi+o
	 GQ5cqq3QiHGoKxTXUEdCrUw+R2oLsQ1Ahv3PP9m6k9iUSbksdjGu7KxKlfgq8jzkOT
	 Eugm9YroqN5wI6gDWBzxF7tuPdbldIfIkkTLHcIE=
Date: Tue, 20 Feb 2024 19:53:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <2024022007-buggy-operator-2dc5@gregkh>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <ZaW5r5kRbOcKveVn@sashalap>
 <dlxqudswz64v6xn3fg2i6ob2msnytaatmnyhq4ivi7notzs6jf@itt42d42zmsw>
 <2024022056-monkhood-fossil-ec02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022056-monkhood-fossil-ec02@gregkh>

On Tue, Feb 20, 2024 at 07:03:23PM +0100, Greg KH wrote:
> On Tue, Feb 20, 2024 at 12:23:33PM -0500, Kent Overstreet wrote:
> > On Mon, Jan 15, 2024 at 06:03:11PM -0500, Sasha Levin wrote:
> > > On Mon, Jan 15, 2024 at 05:12:17PM -0500, Kent Overstreet wrote:
> > > > Hi stable team - please don't take patches for fs/bcachefs/ except from
> > > > myself; I'll be doing backports and sending pull requests after stuff
> > > > has been tested by my CI.
> > > > 
> > > > Thanks, and let me know if there's any other workflow things I should
> > > > know about
> > > 
> > > Sure, we can ignore fs/bcachefs/ patches.
> > 
> > I see that you even acked this.
> > 
> > What the fuck?
> 
> Accidents happen, you were copied on those patches.  I'll go drop them
> now, not a big deal.

Wait, why are you doing "Fixes:" with an empty tag in your commits like
1a1c93e7f814 ("bcachefs: Fix missing bch2_err_class() calls")?

That's messing with scripts and doesn't make much sense.  Please put a
real git id in there as the documentation suggests to.

thanks,

greg k-h

