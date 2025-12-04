Return-Path: <stable+bounces-199955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9A1CA226F
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 03:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECDED3026B34
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 02:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A821246778;
	Thu,  4 Dec 2025 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2cCq+Dx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD7242D7C;
	Thu,  4 Dec 2025 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764814569; cv=none; b=E07WD+am+jKDMlVnJGgIV7g3LPgQlGwrHVgl+FBhw0/FkkRSA+pjkvImz8bcZXCMxbBK7oeDEr79mgfmKQ9is3QHEPD6lmghU/TTc01Czud8fraMdLtIna5RinY5aMNcewr3YY7VW9KrZkBbgm7jFfDt9xqXTsEZufMGeGyTvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764814569; c=relaxed/simple;
	bh=T15PtGF00DzrjFAYoJw6/IiAfJIIc0eMQ+kihWcWEN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6+DLiWZnEv4vBH/On4eOA3aPeV5YP4FQSVp8bnWIH3ocYKCWUvfEpfAbjQUTM42o3OEXsHQ7pvPfe/RgOLmo1dvf8Gi6niSKSO7oibS36qb2p9Rp4OkKBhwLdSFatHT5X1YfPdR4XPjnWmJHS+1iBVQ4MhnFpPO/p9slrIwnd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2cCq+Dx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DDAC4CEF5;
	Thu,  4 Dec 2025 02:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764814568;
	bh=T15PtGF00DzrjFAYoJw6/IiAfJIIc0eMQ+kihWcWEN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l2cCq+DxsxcQMMsk2X4H39rqkEWu5THMfLfy2lgZ3WyUojgNHPlcDI3SC+/RJn1N7
	 UDNW5ysGHCkS+p5tn/GSQvRqZrJIQSkZl+mWMT3O35FgEXZP8DZg/IMCi4h8xk/khs
	 otAd6YBSke4alV+PuFeOw+eCKSeSKjBCvs7DHhwyKMi3ws1HKEoAzhGl737qd8LeoH
	 u9YZ4RZnisGRVdj7wxmHC8TmniCbrq6vsY8HPPBTyxyXZAZeu/ZOg4lA/NexP1Jo/u
	 Cpi/L8EHHzpGOAWIzjntHnV/4R29kLGhmXoyGXJ4nww6dhe1fR3JD3ifYM8I/mHpV0
	 hBA4wDIVLRZTA==
Date: Wed, 3 Dec 2025 19:16:04 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Guenter Roeck <groeck@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernelci@lists.linux.dev, kernelci-results@groups.io,
	gus@collabora.com, stable@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [REGRESSION] stable-rc/linux-6.12.y: (build) variable 'val' is
 uninitialized when passed as a const pointer arg...
Message-ID: <20251204021604.GA843400@ax162>
References: <176398914850.89.13888454130518102455@f771fd7c9232>
 <20251124220404.GA2853001@ax162>
 <CABXOdTfbsoNdv6xMCppMq=JsfNBarp6YyFV4por3eA3cSWdT7g@mail.gmail.com>
 <20251124224046.GA3142687@ax162>
 <2025112730-sterilize-roaming-5c71@gregkh>
 <20251204004314.GA1390678@ax162>
 <CABXOdTfd9C06i8Q8fGMDyMMoTtZ=fwDTvWnM=Yx7g5-ABaAvcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXOdTfd9C06i8Q8fGMDyMMoTtZ=fwDTvWnM=Yx7g5-ABaAvcg@mail.gmail.com>

On Wed, Dec 03, 2025 at 05:03:24PM -0800, Guenter Roeck wrote:
> On Wed, Dec 3, 2025 at 4:43 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Thu, Nov 27, 2025 at 02:22:46PM +0100, Greg Kroah-Hartman wrote:
> > > No objection from me to delete the driver from all of the stable trees :)
> >
> > Sounds rather nuclear for the issue at hand :) but I can send the
> > backports for that change and we can see who complains before trying a
> > more localized (even if wrong) fix.
> >
> 
> Already done (and queued for the next stable releases). Sorry, I
> wanted to copy you but ended up copying myself.

Ah great, one less thing for me to do :)

Cheers,
Nathan

