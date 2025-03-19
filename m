Return-Path: <stable+bounces-125611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D77C2A69CED
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 00:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D002189F0F5
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 23:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567AC222599;
	Wed, 19 Mar 2025 23:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gB1kCa/w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13291219A7E;
	Wed, 19 Mar 2025 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742428513; cv=none; b=j7JtTPdOc7aBPwgfKCsKC2Dq2aKNF/6ECAY5GPSgM8AxN1wvvota0fXKvDJeNdumEjWMZtg7N34DTFvUCavLslocvGeJwOk6dOOd/1eqV4JE/gaVvBMDwpPNq/gQUVIPigy/aGS9myS7g9syGOw/JMwYTFE08HkA5eJ7ewDsE1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742428513; c=relaxed/simple;
	bh=ZHlDr1DFYlSxB8cpiuHTZVz4DMnmYr21wuhSjCJu4Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/G1iTYXr4cR04M9vJ8o07J+XqcWJ5+UiugtJDiEqHaKaW+NSF0Oeege6cNZ5Vc1qXao7tlACb1iWhHcDWNALVum4gB1a1+6J2RfFhEp2CyHR+/PjOeFNJlZu94jJ5P65GScnIuR15e01SytOK1rCZh8ZuGjkC8pC258IOA/lME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gB1kCa/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A993C4CEE4;
	Wed, 19 Mar 2025 23:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742428512;
	bh=ZHlDr1DFYlSxB8cpiuHTZVz4DMnmYr21wuhSjCJu4Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gB1kCa/wL/HzAdvTkgp38QB5Oapu3pyTOZgBjiYAJj447NC9yOq+Lxpul/ItjqkmV
	 m8qyRNGHkgUHiW6RD268UZL3ZL6uiWf9vvbycp92LnqoHpL/v3kiC3FrNrElw1Etvi
	 OJv4nyGhU5xTHwrEx/Egc8pCmUwd6WF6tqpkPxkA=
Date: Wed, 19 Mar 2025 16:53:53 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: frank.scheiner@web.de, dchinner@redhat.com, djwong@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: 6.1.132-rc1 build regression on Azure x86 and arm64 VM
Message-ID: <2025031946-polygon-barrel-6df0@gregkh>
References: <8c6125d7-363c-42b3-bdbb-f802cb8b4408@web.de>
 <1742423150-5185-1-git-send-email-hargar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1742423150-5185-1-git-send-email-hargar@linux.microsoft.com>

On Wed, Mar 19, 2025 at 03:25:50PM -0700, Hardik Garg wrote:
> v6.1.132-rc1 build fails on Azure x86 and arm64 VM:

Odd, there is no real 6.1.132-rc1 announcement yet, so there's no rush
at the moment :)

> fs/xfs/libxfs/xfs_alloc.c: In function '__xfs_free_extent_later':
> fs/xfs/libxfs/xfs_alloc.c:2551:51: error: 'mp' undeclared (first use in this function); did you mean 'tp'?
>  2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
>       |                                                   ^~
> ./include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
>    78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>       |                                             ^
> fs/xfs/libxfs/xfs_alloc.c:2551:13: note: in expansion of macro 'XFS_IS_CORRUPT'
>  2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
>       |             ^~~~~~~~~~~~~~
> fs/xfs/libxfs/xfs_alloc.c:2551:51: note: each undeclared identifier is reported only once for each function it appears in
>  2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
>       |                                                   ^~
> ./include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
>    78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>       |                                             ^
> fs/xfs/libxfs/xfs_alloc.c:2551:13: note: in expansion of macro 'XFS_IS_CORRUPT'
>  2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
>       |             ^~~~~~~~~~~~~~
> In file included from ./fs/xfs/xfs.h:22,
>                  from fs/xfs/libxfs/xfs_alloc.c:6:
> ./fs/xfs/xfs_linux.h:225:63: warning: left-hand operand of comma expression has no effect [-Wunused-value]
>   225 |                                                __this_address), \
>       |                                                               ^
> fs/xfs/libxfs/xfs_alloc.c:2551:13: note: in expansion of macro 'XFS_IS_CORRUPT'
>  2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
>       |             ^~~~~~~~~~~~~~
>   CC [M]  net/ipv4/netfilter/arpt_mangle.o
>   CC      net/unix/scm.o
> make[3]: *** [scripts/Makefile.build:250: fs/xfs/libxfs/xfs_alloc.o] Error 1
> make[2]: *** [scripts/Makefile.build:503: fs/xfs] Error 2

Something is odd with the xfs patches I took?

Any hints on what to do is appreciated.

thanks,

greg k-h

