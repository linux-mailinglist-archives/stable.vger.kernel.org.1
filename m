Return-Path: <stable+bounces-61864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9BE93D15E
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 12:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A011F2190E
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379CC13D8B3;
	Fri, 26 Jul 2024 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HC3/eoo4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42AE7F8;
	Fri, 26 Jul 2024 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991281; cv=none; b=eI8gubBACqTpxUO7CzBX4wXqx7uB9yrVsrvwY2bHAARkBfiKWcQ1l2t9ZEla6HCAzSuwRVGIXhfNKCyIyrEiS7qkb841nIg6fwiM7fGOgwlObXMh8lr+eVXQNPyH4wI/hRlZl0buO4xyCvuarxAPYJr1KMOKYjksfEm6o7EyfS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991281; c=relaxed/simple;
	bh=XIizdfjc6+pAYN8f9MO4FsTkkIOOk7sjH0gRP/NpdXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2T2vEVEmbnTiAHw63lrPCM2CF+e84RgGWBc3EbmvnS+VJ7sZ/wwr/8+QLxJmT6s90A27PiTop52vBbJhBh5hdJ0Zf0trdNwXMffuQClZnSvrLbzlhxt22vLNA+eCx1xvA3g3tw3D4ahZs8j9ufIyTs753p5MZC5PsaaIvP1v7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HC3/eoo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3257C32782;
	Fri, 26 Jul 2024 10:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721991280;
	bh=XIizdfjc6+pAYN8f9MO4FsTkkIOOk7sjH0gRP/NpdXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HC3/eoo451KFh1J22/nEtHpkQKh8Ljb6RKgfWN9feXCUrOy3lOoBBrci2fym/rrr3
	 wxLcfmmTsQ9GvXrpTTqD/fZgz55/km9mu7/k/De/y7i2GUWetEb/uCUJ/tRP9wtvkI
	 oB1RKeeg0yi7QEcPxorJNcvMUH/7IB5Gw1rIF9N4=
Date: Fri, 26 Jul 2024 12:54:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "michal.hrachovec@volny.cz" <michal.hrachovec@volny.cz>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: mmap 0-th page
Message-ID: <2024072625-backache-component-5372@gregkh>
References: <3855f3cf-9c63-4498-853a-d3a0a2f47e7f@volny.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3855f3cf-9c63-4498-853a-d3a0a2f47e7f@volny.cz>

On Fri, Jul 26, 2024 at 12:36:29PM +0200, michal.hrachovec@volny.cz wrote:
> Good afternoon,
> 
> I am trying to allocate the 0-th page with mmap function in my code.
> I am always getting this error with this error-code: mmap error ffffffff
> Then I was searching the internet for this topic and I have found the same
> topic at stackoverflow web pages.
> 
> Here I am sending the link:
> https://stackoverflow.com/questions/63790813/allocating-address-zero-on-linux-with-mmap-fails
> 
> I was setting value of |/proc/sys/vm/mmap_min_add to zero and using the root
> privileges along the link.
> And I am having the same problem still.
> 
> Can you help, please.

The stable and regressions mailing list is not the proper place for
this type of question, sorry.

If this is a regression from a previous kernel version, it might be the
place but you don't specify any kernel version information here.

best of luck!

greg k-h

