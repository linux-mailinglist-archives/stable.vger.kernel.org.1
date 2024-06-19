Return-Path: <stable+bounces-53848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016A190EA9D
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8333AB22C3A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D43E1422BC;
	Wed, 19 Jun 2024 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S1LpjhX+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3101422A2
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799238; cv=none; b=NRmNM0ZEtBCCk8Aqfz7xzPd0fbj/LEnJKiF7po8Wa2CsQZFlvdap34KD/KeWPmWQqVZC9Ww4UQ66QXoCkNFczqwf7e/ouSwFiUrNA+75FNy6c1uamYoZPkuHtIvizRDrF4PwRuKC/dJzGSTTldc84qQPK6DD+8SiPZOuyWSRGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799238; c=relaxed/simple;
	bh=CqUU5E2qwyYdZFw9dinP0u99GBCKn2a3D2QHnsVlAt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWmwQOSRCGZIJN46sqsXFMoHxbeXQWmihi8l6D53558bj2Ypqf/bcGF9gzN0xsm6tywNe8PgtRiswRWHzYC2ravseXGSZ3Lr5dFn4IbqtannJTpVu0oYSEHslK4U7TQ9pMyjqtLq64CECQ2CkNOc2v6dO0dk9KAaKrVX74mkBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S1LpjhX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C147C2BBFC;
	Wed, 19 Jun 2024 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718799237;
	bh=CqUU5E2qwyYdZFw9dinP0u99GBCKn2a3D2QHnsVlAt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1LpjhX+bZvtKk9q+7XqyYT82sJ7ia8hA/lx5pzETPrnRhGogJB1ghbkw54+DFoxf
	 9XXzwUnAGbAe1F2T6pmPGtVjj5nYn2vSlKNS11DiqhAimeq/+rqLpMs6F8u2moDZD2
	 gLpwT4I+kY0ipJD/afGvzJAw/1Gr6Q4a3iUjptJk=
Date: Wed, 19 Jun 2024 14:13:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ronnie Sahlberg <rsahlberg@ciq.com>
Cc: stable@vger.kernel.org
Subject: Re: Candidates for stable v6.9..v6.10-rc1 Use After Free
Message-ID: <2024061918-maternity-unfixed-c67f@gregkh>
References: <CAK4epfz7DewhGqMhfTi_gy3OEEDQQhOZb=pRs4MvxzyN=_Cy+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK4epfz7DewhGqMhfTi_gy3OEEDQQhOZb=pRs4MvxzyN=_Cy+w@mail.gmail.com>

On Fri, May 31, 2024 at 12:14:36AM -0400, Ronnie Sahlberg wrote:
> These commits reference use.after.free between v6.9 and v6.10-rc1
> 
> These commits are not, yet, in stable/linux-rolling-stable.
> Let me know if you would rather me compare to a different repo/branch.
> The list has been manually pruned to only contain commits that look like
> actual issues.
> If they contain a Fixes line it has been verified that at least one of the
> commits that the Fixes tag(s) reference is in stable/linux-rolling-stable
> 
> 
> 90e823498881fb8a91d8

Fun note, there are parts of the kernel, like is touched here, where
unless the commit is explicitly marked "for stable", we should not be
applying them.  Even if, as this changelog text says, "hey, this might
fix a bad thing."  We have to trust the maintainers here, sorry.

> 5c9c5d7f26acc2c669c1

Hey, a real one!

> 573601521277119f2e2b

Already in the tree as something else I think.

> f88da7fbf665ffdcbf5b

Again, amd gpu driver hell, already in the tree as a different commit.

> 47a92dfbe01f41bcbf35

fixes 6.10-rc1 stuff.

> 5bc9de065b8bb9b8dd87

Already merged.

> 5f204051d998ec3d7306

Another subsystem (XFS) that we are not allowed to touch.  The
maintainers will backport patches as needed and send them to us.  We
have a list of these types of files we need to ignore in the
stable-queue ignore_list file if you are curious.

> be84f32bb2c981ca6709

A real one!  Now queued up, thanks!

Note, the security/* files are famously almost never tagged for stable,
or have Fixes: markings on them.  I guess the security code must always
be secure that no fixes are ever needed... :)

> 88ce0106a1f603bf360c

Already in many releases.

thanks for the lists!

greg k-h

