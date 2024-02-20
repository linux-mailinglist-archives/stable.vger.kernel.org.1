Return-Path: <stable+bounces-20852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C6985C286
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 18:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22256281C40
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 17:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B0777632;
	Tue, 20 Feb 2024 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rpXjpln5"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759222599
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449819; cv=none; b=YjAmBOu9qe5B5h1GbBZsIe1X19ctdpYV5iJVeTASIphsUjqBTcttM6/peEYxYdUzz8DR+8iqb2VLwy0j9dcgAxeo38YX0Tc+PiuJ/1SqaVjezrknYAEyyCenLJkvTrRN2G6mSHEhJkAhSoy0r4kMiJYPJ+0mLakrh+IGD7oopbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449819; c=relaxed/simple;
	bh=ELP09wkH3ewB5N6rAXi4idg+3FVT12bC3unl0t5Wh18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SueQPdNQn2525PYE6mdmOd4/W8Tn2Kwr6BPqq6RnRdp7fwM0zpMrDcWG2WDdE4y4nfN4HKfQ0JFoxAZp+EiuH7qkUSjMWNZk+1HTR0z1ljAXZ101RaAnsYY1nf1bITuNfWmF8XOsfIuNw8j3LdCFmhrst4SeLNkhmlDPy5PgdTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rpXjpln5; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Feb 2024 12:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708449815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Hb48HTNammuRMd7ioNv7zEIkiMqzbazg14FWnYb3Fg=;
	b=rpXjpln5hXaLKTQR47ltTkiQa+cx2r6HknxCiiVxZM7ovthg9777vDvz/mnLN6+6MY2J4U
	gXX9/u+X9wApYijIX2piEVkZGm3pvbqPEnPu6/5qSwee8SwCi7CSyoYQKaDPFb+XxXtl8+
	LKvwofmeQyyEo2+6C/HyUy0Cv9xWIB8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <dlxqudswz64v6xn3fg2i6ob2msnytaatmnyhq4ivi7notzs6jf@itt42d42zmsw>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <ZaW5r5kRbOcKveVn@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaW5r5kRbOcKveVn@sashalap>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 15, 2024 at 06:03:11PM -0500, Sasha Levin wrote:
> On Mon, Jan 15, 2024 at 05:12:17PM -0500, Kent Overstreet wrote:
> > Hi stable team - please don't take patches for fs/bcachefs/ except from
> > myself; I'll be doing backports and sending pull requests after stuff
> > has been tested by my CI.
> > 
> > Thanks, and let me know if there's any other workflow things I should
> > know about
> 
> Sure, we can ignore fs/bcachefs/ patches.

I see that you even acked this.

What the fuck?

> 
> Note that the proposed workflow would only work through patches coming
> through your tree, but patches in other subsystems that could affect
> bcachefs might break it in stable trees without being caught by your CI.
> 
> I'd recommend integrating your pre-release tests with something like
> kernelci, which would let us catch bcachefs-affecting issues coming from
> other sources.
> 
> What more, if we do the above, we could in the future avoid special
> casing bcachefs :)
> 
> -- 
> Thanks,
> Sasha

