Return-Path: <stable+bounces-100433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259339EB295
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 15:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACB016CB55
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313211ACDE7;
	Tue, 10 Dec 2024 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yv71tzND"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F41ABEBA
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839353; cv=none; b=DLPNo7qbWYyCnMFkaMSw9O0+9m/9wVa9VZbctljf2OCkUMv00ukGlxiRdW5cnBQpoE69U53wLSxdNykMPl9p2mmaV8zQZl+nzsdIo0Lbt1fPhHjfDt4HQGrdAY7f6VDglVTd+k1fjljHKrfCzp2bLrhrZkr9P1tg8Hk2BaZyAfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839353; c=relaxed/simple;
	bh=V06Q1QURxwRle95KuIFebcGLx4dtyJOJ3vJ9S/NiBL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfbeqMfzIFWKPInZVcW1DBPskV5tlPyS0Rse8aYoh8s65BJPLBLlWYCFtqp1E2YMY0frQ/1VPV68uRLRf13II+5+esnQrL/KZMs33eI83VBDsXF/Eb1YyUrTmm07mKTWQKYRFk5Xz4YtDemDXzsoaxurf/IzCF5V2WBUK2FMjv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yv71tzND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F615C4CEE2;
	Tue, 10 Dec 2024 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733839352;
	bh=V06Q1QURxwRle95KuIFebcGLx4dtyJOJ3vJ9S/NiBL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yv71tzNDe9CNKGq3V5AMxffRp+eJuh7FIS9F1zOrUG9wEU8mUqDe8eQ5yd/cWUZGV
	 3i8VKFLYCwQVKMXAqDhML1U1lbMzTA39YemKXpFDUH4jy4j/9dYVg4uM/6wD5BR6Qg
	 X2R8OqABglZwxJZOsak9IdV0TiuXUsaDyj0Ec7so=
Date: Tue, 10 Dec 2024 15:01:54 +0100
From: 'Greg KH' <gregkh@linuxfoundation.org>
To: Bilge Aydin <b.aydin@samsung.com>
Cc: stable@vger.kernel.org
Subject: Re: [APS-24624] Missing patch in K5.15 against kernel panic
Message-ID: <2024121015-lettuce-lyrics-5dee@gregkh>
References: <CGME20241210132338eucas1p2228b89f17ab46f90075c07806765a5aa@eucas1p2.samsung.com>
 <0bd701db4b06$b7cbdf00$27639d00$@samsung.com>
 <2024121044-coronary-slacker-cf53@gregkh>
 <0be801db4b0a$3fda7840$bf8f68c0$@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be801db4b0a$3fda7840$bf8f68c0$@samsung.com>

On Tue, Dec 10, 2024 at 02:48:52PM +0100, Bilge Aydin wrote:
> Hello Greg,
> 
> Thank you very much for your prompt reply.
> 
> "So why do you feel it is required in 5.15.y?"
> --> We have faced the issue in our K5.15 based platform. Our technical team has made an investigation and found your given patch. Afterwards we verified it by running a stress test. The result was positive and we did not face the kernel panic again.

That's great, then send us a backported patch (and the fix for that, you
did catch that one, right?)

> Since we are not OS experts, we fully respect Linux community's decisions. That's why we do not see ourselves in that high position to give any guidance and share any patch with you. During our investigation, we only recognized that the given patch was already integrated into the Android common kernel. Outgoing from that, I just want to share the indication with you.
> 
> Would it be possible for you to start an internal communication within the Linux community for the synchronization of the K5.15 and K6.1 mainlines explicitly for iommu driver?

That is not how the stable kernel branches work at all, sorry.  Please
read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for more information.

Also, if you need the iommu code in 6.1, then just use the 6.1.y kernel
please.  There's nothing keeping you from doing that, right?  That way
you get more support for more hardware and more fixes that didn't happen
to get backported to the really old 5.15.y release.  Also, you will have
to move off of 5.15.y in a few years anyway, so might as well do it now
when you have a very good reason to do so.

good luck!

greg k-h

