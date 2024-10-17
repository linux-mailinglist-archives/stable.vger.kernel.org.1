Return-Path: <stable+bounces-86600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BD49A20F7
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 13:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895B428130E
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 11:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6E61D27B3;
	Thu, 17 Oct 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L3uWKe0T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F0134A8
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164684; cv=none; b=PNIBEC6YffX8nXlvcztPWtPy909yVIOr4aT/7DQTGkxuN1F/W9W7TGangA0FSSyKrKmSzTd9bPF54QQoGV3QFcZS45DMDoapS/GoJ8jg0GdZFOvrYwmROF3hTZaBS0MWXXKfNFeZHLJhgef1CT4v4JUlpFBGVh0UsWix67IPjco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164684; c=relaxed/simple;
	bh=aDFDW2aODb68J4EsWWYEzOi95uoV4PvlThicoqSiH1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuK7U1vzDBBX7hVw23QaqBriptIqdKCpPTb4pNegL5ne+RHdNBTRYU1UHIyBLHr/7hDRR/uj6CC26ILKJ4WUIE3nMimLADh+802vpfK3xc9HZum0VCxyOE6ODl00q0W28HB8PiX54lg8/i+/FpaTuwTXEW5WNDCmBDJdY+m05ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L3uWKe0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BAFC4CEC3;
	Thu, 17 Oct 2024 11:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729164684;
	bh=aDFDW2aODb68J4EsWWYEzOi95uoV4PvlThicoqSiH1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3uWKe0Tkr3x2wHhEZIhZTHTwOm9fsmfX2t0e45xoszmU0xNc+fKr+X648BF5aHjc
	 x0J2WBiV/OtyMYIFQyGHxI8CDu77DLXapKo7Skkd8Ox4iEoZ2uo0vye5VDxEO2cXPy
	 LczR+Tzq3FgZY9CYe4ySFu6szTDuuMofRfXTlVc8=
Date: Thu, 17 Oct 2024 13:31:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vimal Agrawal <avimalin@gmail.com>
Cc: vimal.agrawal@sophos.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] misc: misc_minor_alloc to use ida for all
 dynamic/misc dynamic minors
Message-ID: <2024101702-moody-suspect-702e@gregkh>
References: <20241017105325.18266-1-vimal.agrawal@sophos.com>
 <20241017105325.18266-2-vimal.agrawal@sophos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017105325.18266-2-vimal.agrawal@sophos.com>

On Thu, Oct 17, 2024 at 10:53:25AM +0000, Vimal Agrawal wrote:
> misc_minor_alloc was allocating id using ida for minor only in case of
> MISC_DYNAMIC_MINOR but misc_minor_free was always freeing ids
> using ida_free causing a mismatch and following warn:
> > > WARNING: CPU: 0 PID: 159 at lib/idr.c:525 ida_free+0x3e0/0x41f
> > > ida_free called for id=127 which is not allocated.
> > > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> ...
> > > [<60941eb4>] ida_free+0x3e0/0x41f
> > > [<605ac993>] misc_minor_free+0x3e/0xbc
> > > [<605acb82>] misc_deregister+0x171/0x1b3
> 
> misc_minor_alloc is changed to allocate id from ida for all minors
> falling in the range of dynamic/ misc dynamic minors
> 
> Fixes: ab760791c0cf ("char: misc: Increase the maximum number of dynamic misc devices to 1048448")
> Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
> Cc: stable@vger.kernel.org
> ---
> v2: Added Fixes:
>     added missed case for static minor in misc_minor_alloc
> v3: removed kunit changes as that will be added as second patch in this two patch series
> 
>  drivers/char/misc.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)

Did you mean to send this only to stable and yourself and not the
maintainers involved here?

confused,

greg k-h

