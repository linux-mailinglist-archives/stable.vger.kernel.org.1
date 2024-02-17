Return-Path: <stable+bounces-20404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D22858FB0
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 14:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61353B21492
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 13:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677DB7A724;
	Sat, 17 Feb 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mCiGhaXu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138CD65BCA
	for <stable@vger.kernel.org>; Sat, 17 Feb 2024 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708176770; cv=none; b=QVJYRkdz8+PLzCLg7hKwRgAGSjLkKiO/4gfEMK6EnmrcUTpkdA7L2Ghr874hL1tkYlVSD+SZ2LnQ+joCEEWv/jqpii60PxWjyr2e2xXZgNXT6P9yMZw4aazcraQQ/F55nOsaGEqUGYB7DNoTN+/oOVYJK6vEADP0Y42FQII0Jyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708176770; c=relaxed/simple;
	bh=RLWePewcGkHGTljL6qaxpA46StCrdniP6u5f2t+0894=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcNaAChjNM9BjNKlE+GwTTFfStSLco4wa6uBHaisFxdr0Y7yHLjc751VyM5QjS+TGwddanJVLnRh2ASHnazQc7SkXQ7yu6FaShpk+zuh1YbRCi7u9hM0ptf0/W34Bd9elnRNuEk29ogzk0H8LbM/jZRN7n27ZUKBkOBTX+OAVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mCiGhaXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AF2C433F1;
	Sat, 17 Feb 2024 13:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708176769;
	bh=RLWePewcGkHGTljL6qaxpA46StCrdniP6u5f2t+0894=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCiGhaXuM0SqTMeqSgH9p/As3t4o8qU/iJnkHAG/zxpUMXWg2+tTRyH71hVU9VupI
	 iA0zCU6e2Fj43lpOVdX3n8+Lig7dB+O4pylyg/2HmSFeZaS6sXLO8b6zQg5kezK+ys
	 OPo734HrGiEsrw+CI3hvx+nei7Xo1dGKrBJlATok=
Date: Sat, 17 Feb 2024 14:32:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable <stable@vger.kernel.org>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: Please put the gcc "asm goto" bug workaround into stable
Message-ID: <2024021737-deliverer-entrap-119d@gregkh>
References: <CAHk-=wgcbbNw-dJu_=9xT3KR-xRgPYG7yLeUwqLkCKoRamx5Ug@mail.gmail.com>
 <2024021623-puma-sympathy-1a4a@gregkh>
 <CAHk-=wgV-LCxsduWWLcXzb6Yk9e1-GEyW9Qqzf2zoOZRWGxR=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgV-LCxsduWWLcXzb6Yk9e1-GEyW9Qqzf2zoOZRWGxR=A@mail.gmail.com>

On Fri, Feb 16, 2024 at 11:14:48AM -0800, Linus Torvalds wrote:
> On Fri, 16 Feb 2024 at 10:45, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > I gave up at 6.1.y and if anyone wants them there, I'll gladly
> > take a working backport, but I'm not going to attempt it.
> 
> The attached *looks* correct for 6.1.y.
> 
> No warranties. Caveat emptor. Your mileage may vary.  Objects in
> mirror are closer than they appear. These patches are known to the
> state of California to cause cancer.

Thanks, seems to build here, now queued up!

greg k-h

