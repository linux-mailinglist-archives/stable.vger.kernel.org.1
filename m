Return-Path: <stable+bounces-48300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 130168FE73A
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 15:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395C61C24BC7
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D955195F06;
	Thu,  6 Jun 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bREvbPD9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A7D13A86B;
	Thu,  6 Jun 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679442; cv=none; b=A6nuwqVUDP4wBoaMhheruXxnQ+Xz6xjlL74ZhlG0N2d2su8ha4abERiwu4ArZuC+dLFzSJTtiY5UXfuUEtNhNxVBRk0FywfqE0EBX9kRrWMxVV+FIVZzKe5EqRyR6mayMGwwTG9BZAU0Osm47epCQjkj6gLr4k5fGumLs76Ht/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679442; c=relaxed/simple;
	bh=G5jTyKlv2GHxHDkqCrJpysPcPEYqIitI0lZtBhTrfic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkrCDuEE00JfL72oMiH+S3S4n2NcViU209vgZsMoViNYFS0yua56JAI/HtLvcE0/NkEAQpCJfUhaQo6SpOLToIejpyrz+QEuUrXX64s4iO5Q/zTm8O0QZXYCmUUbFGpIWaGQTVctSKrxPJli4OyUWMyQ8a0JVm5iNW1kwpuXDdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bREvbPD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79ADC2BD10;
	Thu,  6 Jun 2024 13:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717679441;
	bh=G5jTyKlv2GHxHDkqCrJpysPcPEYqIitI0lZtBhTrfic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bREvbPD9x6IGw2Lfp3OJ+txA0FIl5IqCJWT2BPixvogHBqiWjUJGdJPZgpeUOGBgl
	 hYQyaGgEpU19cBPzyGsY+LYiQKOxCJCE9wEeXxb3qFIwiK7g6bSxbJ1i5RcsM4Bg1/
	 cE9fUnr5FA3kZ+fbDhafhJ4R9Qvz3i4x7rRR4TXw=
Date: Thu, 6 Jun 2024 15:10:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: Patch "arm64: fpsimd: Drop unneeded 'busy' flag" has been added
 to the 6.6-stable tree
Message-ID: <2024060623-endorphin-gallstone-bf81@gregkh>
References: <20240530191110.24847-1-sashal@kernel.org>
 <CAMj1kXH7rfoV_rsxHrwgY5++OuqTXHYdN_Zje4+HxTeQiwx1NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH7rfoV_rsxHrwgY5++OuqTXHYdN_Zje4+HxTeQiwx1NA@mail.gmail.com>

On Fri, May 31, 2024 at 08:16:56AM +0200, Ard Biesheuvel wrote:
> On Thu, 30 May 2024 at 21:11, Sasha Levin <sashal@kernel.org> wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     arm64: fpsimd: Drop unneeded 'busy' flag
> >
> > to the 6.6-stable tree
> 
> Why?

Because:

> >     Stable-dep-of: b8995a184170 ("Revert "arm64: fpsimd: Implement lazy restore for kernel mode FPSIMD"")

It's needed for the revert?

thanks,

greg k-h

