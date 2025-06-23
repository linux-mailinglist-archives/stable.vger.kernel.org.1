Return-Path: <stable+bounces-155319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6D4AE3849
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 10:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62FC1886940
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CEE1FF1A0;
	Mon, 23 Jun 2025 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rMQSipCM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE7611E
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666974; cv=none; b=PmCKZ9ib6Cyy/xreVGtmyASNC0q4IUydWBlPjwXqfVL3Z0nY0G1i5keoRPQt23bQ3PM2F3/9txwpKyAFK0GCb/VThQFLSwfMOf8VnWuvDm9C/GicCDA4dLR3o3E20fOTVwz3Ofn7WaZUKjU+HUz/WJ4QGpUXUj6Ah1bDqyzevHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666974; c=relaxed/simple;
	bh=tq6r7hhfDcy5f+elT7OezMCXRbvuNP8t/l/G6nMSsLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYnzCTA8bi6ZqAqbwB6bVeIWBCMNpl/OQb0DjiffOsfcLynvtj/SoEq7mwi2RAsss2n/xgTlrUgDYQYVqBUyy+H3OjxbjoLu+/C4P1DLx4sDG6lFSib1hQLbbC3PhkUn1xUmxPDH+mzAN5c0tcl9V3DitmDoT8wWlCaJeb030Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rMQSipCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA8DC4CEED;
	Mon, 23 Jun 2025 08:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750666973;
	bh=tq6r7hhfDcy5f+elT7OezMCXRbvuNP8t/l/G6nMSsLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rMQSipCMbKqwxETVv8HNfvEG/BKbbqq7JdOIJsnpws7TvOQMIY9E9X3w9D4oQet26
	 hlJbVNy/zcHCQXXRkXoq44Fq4znURKPOC78Mg0pHqyf4r9BjUfIIMMEcjVMiGnWNiD
	 03ZO46nvHgosSq5Sa6I/jjS9VhfgnlzBplVb5dbA=
Date: Mon, 23 Jun 2025 10:22:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Ingo Saitz <ingo@hannover.ccc.de>, 1104745@bugs.debian.org,
	stable@vger.kernel.org
Subject: Re: Bug#1104745: gcc-15 ICE compiling linux kernel 6.14.5 with
 CONFIG_RANDSTRUCT
Message-ID: <2025062341-wrought-work-fbf3@gregkh>
References: <174645965734.16657.5032027654487191240.reportbug@spatz.zoo>
 <hix7rqnglwxgmhamcu5sjkbaeexsogb5it4dyuu7f5bzovygnj@3sn4an7qgd6g>
 <aEVJDjS6_po-kMj-@spatz.zoo>
 <snq7vjlketwasar4jdufnoostk7xm7umdm6y2xao4tmi4653pd@d6uemvag32nj>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <snq7vjlketwasar4jdufnoostk7xm7umdm6y2xao4tmi4653pd@d6uemvag32nj>

On Wed, Jun 11, 2025 at 06:40:48PM +0200, Uwe Kleine-König wrote:
> Hello Greg, hello Ingo,
> 
> On Sun, Jun 08, 2025 at 10:25:50AM +0200, Ingo Saitz wrote:
> > On Wed, Jun 04, 2025 at 10:43:11PM +0200, Uwe Kleine-König wrote:
> > > Control: tag -1 + fixed-upstream
> > > Control: forwarded -1 https://lore.kernel.org/r/20250530221824.work.623-kees@kernel.org
> > > 
> > > Hello,
> > > 
> > > On Mon, May 05, 2025 at 05:40:57PM +0200, Ingo Saitz wrote:
> > > > When compiling the linux kernel (tested on 6.15-rc5 and 6.14.5 from
> > > > kernel.org) with CONFIG_RANDSTRUCT enabled, gcc-15 throws an ICE:
> > > > 
> > > > arch/x86/kernel/cpu/proc.c:174:14: internal compiler error: in comptypes_check_enum_int, at c/c-typeck.cc:1516
> > > >   174 | const struct seq_operations cpuinfo_op = {
> > > >       |              ^~~~~~~~~~~~~~
> > > 
> > > This is claimed to be fixed in upstream by commit
> > > https://git.kernel.org/linus/f39f18f3c3531aa802b58a20d39d96e82eb96c14
> > > that is scheduled to be included in 6.16-rc1.
> > 
> > I can confirm applying the patches
> > 
> >     e136a4062174a9a8d1c1447ca040ea81accfa6a8: randstruct: gcc-plugin: Remove bogus void member
> >     f39f18f3c3531aa802b58a20d39d96e82eb96c14: randstruct: gcc-plugin: Fix attribute addition
> > 
> > fixes the compile issue (on vanilla 6.12, 6.14 and 6.15 kernel trees;
> > the kernels seem to run fine, too, so far). The first patch was needed
> > for the second to apply cleanly. But I can try to backport only
> > f39f18f3c3531aa802b58a20d39d96e82eb96c14 and see if it still compiles.
> 
> @Ingo: Thanks for testing and confirming the backport works.
> 
> @gregkh: I think it's reasonable to backport both
> e136a4062174a9a8d1c1447ca040ea81accfa6a8 and
> f39f18f3c3531aa802b58a20d39d96e82eb96c14. Do you already have these on
> your radar?

They are in the stable queues now.

thanks,

greg k-h

