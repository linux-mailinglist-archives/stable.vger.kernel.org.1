Return-Path: <stable+bounces-20857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC57C85C346
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 19:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7E61F249BF
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 18:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0994077621;
	Tue, 20 Feb 2024 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tbOR737k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C276C9F
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452211; cv=none; b=YHfgdxuyQQQUf+z/GX96Vcso0pHWOGHkI16pLL9W8fr7itSsCihUul515/Q1hf552XigietMoTrqezUq4Zaw5Y4jrlqUoZIm0xqYjVG0zR322UwgR3C7vPc8EN5h6yk/UrOAlrsEkWex3tW8p1QmrazgjvN+n3/ynNWMlyVYQjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452211; c=relaxed/simple;
	bh=7xGmTbr9oU2Pi6m1+Kx01FmQMCGt61smzJXw4FA6wPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yb3MgfI70RRhL+KH19v45I3tGy+jSgH2D7iHf8p7G3qwVCXvWyWu4JXPokIGRZOVbV0Uw7vWnFA66EH/zup+u59daQWYcSB40vbmiF10Zf/aU2JsUBOoelWrDL5PL9TzfVUHvp7PSkA6CvMjD8MkkLISeQwJuqUE8GlZ+4RHN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tbOR737k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CD8C433C7;
	Tue, 20 Feb 2024 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708452211;
	bh=7xGmTbr9oU2Pi6m1+Kx01FmQMCGt61smzJXw4FA6wPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tbOR737kAiS6ccHd9ac0U5cAVBtPwXz8f9LHI7/vzaOOYhX66BSQ6vY8LufNydX8E
	 QaFuBLy2Ps5+Owmnp1vaGW1YNRXcYhMqFa5c+Z5lGxeapkHA81bKUy+kgxZLe3WH6F
	 MmpeXuaeiB7IfbV2m7NwNInUWN6PG3j1v6ssvgo0=
Date: Tue, 20 Feb 2024 19:03:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <2024022056-monkhood-fossil-ec02@gregkh>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <ZaW5r5kRbOcKveVn@sashalap>
 <dlxqudswz64v6xn3fg2i6ob2msnytaatmnyhq4ivi7notzs6jf@itt42d42zmsw>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dlxqudswz64v6xn3fg2i6ob2msnytaatmnyhq4ivi7notzs6jf@itt42d42zmsw>

On Tue, Feb 20, 2024 at 12:23:33PM -0500, Kent Overstreet wrote:
> On Mon, Jan 15, 2024 at 06:03:11PM -0500, Sasha Levin wrote:
> > On Mon, Jan 15, 2024 at 05:12:17PM -0500, Kent Overstreet wrote:
> > > Hi stable team - please don't take patches for fs/bcachefs/ except from
> > > myself; I'll be doing backports and sending pull requests after stuff
> > > has been tested by my CI.
> > > 
> > > Thanks, and let me know if there's any other workflow things I should
> > > know about
> > 
> > Sure, we can ignore fs/bcachefs/ patches.
> 
> I see that you even acked this.
> 
> What the fuck?

Accidents happen, you were copied on those patches.  I'll go drop them
now, not a big deal.

thanks,

greg k-h

