Return-Path: <stable+bounces-76525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0B197A7A5
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 21:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276401F22641
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 19:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E87315B966;
	Mon, 16 Sep 2024 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ddx4mbp9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7413211F;
	Mon, 16 Sep 2024 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726513533; cv=none; b=INKDWC209ohdfbUMEyyg16fUl2kQioxJGpuO1IbnPj075HZtPE+SFZMCEEkAcYM/Eeonp1sUdu/o1b3cXKI+jsssxHv+1u5Huk7dfTujPdj1lzNvcQTzbTWtzPggTSqBcdmd/I8iof1nsrpY1qOvkGJb7xreDaTYvDYQ062XbM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726513533; c=relaxed/simple;
	bh=XBOfRXYf4P1Fv2tq6LZ5gvr33Oxhkq+gDONQ+QIirRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAVndMUOcSmgxaUkOaKWUHb6H/2lSTZZ//vEPzEVMQfSf/tDNg0HYrsAYU0c9Ljvm8TDJpl4PmH8N0riM8A6inU4Ew5jQ83rRI4Lr7bqxedFg/fRGDvNOVQaweUMZhQr5XjmJkluDdfmrtrn7/FVCvGL+Rk3wC1FFj0dXi1nRGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ddx4mbp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31B2C4CEC4;
	Mon, 16 Sep 2024 19:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726513532;
	bh=XBOfRXYf4P1Fv2tq6LZ5gvr33Oxhkq+gDONQ+QIirRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ddx4mbp9eoX+gb0JMZWmCpivsgntkxMe1+/2pxH6ofc1N5TZGg5GtlV8OdmI6uT6T
	 PcCtkIKRTg9iGwGe1hx0Hf78ssz+woWfSFa/Xv6hLZSqf1BkVks/Tnpz18pH/OYRlV
	 WldnYUExe1lxCSCLQA8mYzZ4zv8qZf5G02wJqySLrVCGmAIemwvnmRNQj6mzyeShXX
	 HCpGgpys1hkMohFe56Txjx3pCt0afzQyhEcY6G4CdjrRc477xwmRxerMdnpcz8mybR
	 Fq1O5TkLPb1abXFpN64Su0qSYfeixEk06lYuWCizQUZz/U3bZaP3L5xkQFGUVYAp41
	 fu5ilnyIvbWIg==
Date: Mon, 16 Sep 2024 20:05:28 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL
Message-ID: <20240916190528.GF396300@kernel.org>
References: <20240916-ipv6_rpl_lwtunnel-dst_cache-v1-1-c34d5d7ba7f3@linutronix.de>
 <20240916184443.GC396300@kernel.org>
 <20240916184851.GD396300@kernel.org>
 <20240916205246-5df7e565-6950-4503-ac4d-741c37b1afda@linutronix.de>
 <20240916190416.GE396300@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240916190416.GE396300@kernel.org>

On Mon, Sep 16, 2024 at 08:04:16PM +0100, Simon Horman wrote:
> On Mon, Sep 16, 2024 at 08:54:21PM +0200, Thomas Weißschuh wrote:
> > On Mon, Sep 16, 2024 at 07:48:51PM GMT, Simon Horman wrote:
> > > On Mon, Sep 16, 2024 at 07:44:43PM +0100, Simon Horman wrote:
> > > > On Mon, Sep 16, 2024 at 06:53:15PM +0200, Thomas Weißschuh wrote:
> > > > > The rpl sr tunnel code contains calls to dst_cache_*() which are
> > > > > only present when the dst cache is built.
> > > > > Select DST_CACHE to build the dst cache, similar to other kconfig
> > > > > options in the same file.
> > > > > 
> > > > > Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> > > > > Cc: stable@vger.kernel.org
> > > > > ---
> > > > > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > > > 
> > > > Reviewed-by: Simon Horman <horms@kernel.org>
> > > > Tested-by: Simon Horman <horms@kernel.org> # build-tested
> > > 
> > > Sorry Thomas, I missed one important thing:
> > > 
> > > Your Signed-off-by line needs to go above the scissors ('---')
> > > because when git applies your patch nothing below the scissors
> > > is included in the patch description.
> > 
> > Welp, this seems to be due to a combination of me forgetting to add it,
> > b4 adding it below the scissors automatically and then failing to warn
> > about the missing sign-off.

BTW, if b4 is adding it then, maybe, you need to remove
it from the cover letter using b4 prep --edit-cover

> > 
> > I'll resend v2 with your tags. And will also remove the Cc: stable as
> > per net rules.
> 
> Thanks. Please be aware of the 24h rule.
> 
> https://docs.kernel.org/process/maintainer-netdev.html
> 

