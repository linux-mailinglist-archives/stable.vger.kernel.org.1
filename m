Return-Path: <stable+bounces-65312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67198946833
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 08:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1B85B2135C
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 06:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D133814C5B8;
	Sat,  3 Aug 2024 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2iS0neMm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3A2136350
	for <stable@vger.kernel.org>; Sat,  3 Aug 2024 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722666859; cv=none; b=mql9CsXQazTvRMcAYAKQP+08gS/jrlhV04GwDfA+KTyBYbfVPHd/aw3ms4/tNO27mXI7KdHl+1Cfo+VjhaOm8I5dyKkOpCXHqKxMqzq8pKnKu1fuaPi2tzfOTA+At1aYEYDz0NS5oyLWCNanb6GnCiXLWH6HwFveQcs6Dj/JnDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722666859; c=relaxed/simple;
	bh=2r3sNBvQPXW12eKxOfGVG87wm6EEGVAlQiOqIJ5bVJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYxmi42y1NF2Infvpbbsmk+/8U3siz5DCzQ0P+XCU506cPMaEAatp/rt8aydNl0eTYM//LeLe9eJg3yvjwMYgyXDhWZ56El0L46/0X/4GcnrUdL9ARWdcCCLXzMaG2PWhtiESUKjd3vOGgmo+hHZ3YFVPRGi0AwMbx00k+U+y1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2iS0neMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC3BC116B1;
	Sat,  3 Aug 2024 06:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722666859;
	bh=2r3sNBvQPXW12eKxOfGVG87wm6EEGVAlQiOqIJ5bVJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2iS0neMmw0KAh2eJ67g7P+rZz8OYMWARezpczFLjDA7omfKpDbcB6QV8U0WSEDktk
	 Fba0szTWwNRjTKjnnmdmvZ0DoX8gGk4UbImD8oAoDcl6PNMrKZSUD+Z9jlPOr3TonO
	 KU2XESYsQNntPQxBlMUSV1o6LTgpx3aBwEI2n07s=
Date: Sat, 3 Aug 2024 08:34:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: lugomgom <luis.en.gomez@oracle.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+c52ab18308964d248092@syzkaller.appspotmail.com,
	stable@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH UEK-4.1-QU7 1/3] hwrng: core - Fix page fault dead lock
 on mmap-ed hwrng
Message-ID: <2024080352-unmixable-agenda-d580@gregkh>
References: <20240802224548.354733-1-luis.en.gomez@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802224548.354733-1-luis.en.gomez@oracle.com>

On Fri, Aug 02, 2024 at 04:45:48PM -0600, lugomgom wrote:
> From: Herbert Xu <herbert@gondor.apana.org.au>
> 
> commit 78aafb3884f6bc6636efcc1760c891c8500b9922 upstream.
> 
> There is a dead-lock in the hwrng device read path.  This triggers
> when the user reads from /dev/hwrng into memory also mmap-ed from
> /dev/hwrng.  The resulting page fault triggers a recursive read
> which then dead-locks.
> 
> Fix this by using a stack buffer when calling copy_to_user.
> 
> Reported-by: Edward Adam Davis <eadavis@qq.com>
> Reported-by: syzbot+c52ab18308964d248092@syzkaller.appspotmail.com
> Fixes: 9996508b3353 ("hwrng: core - Replace u32 in driver API with byte array")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> (cherry picked from commit eafd83b92f6c044007a3591cbd476bcf90455990)
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> (cherry picked from commit 581445afd04cac92963d8b56b3eea08b320d6330)
> 
> Orabug: 36806668
> CVE: CVE-2023-52615
> 
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Reviewed-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> 
> Conflicts:
> 	drivers/char/hw_random/core.c -- Minor contextual conflicts due
> to missing commit: affdec58dafc ("hwrng: core - Replace asm/uaccess.h by
> linux/uaccess.h") in UEK4, and it is not a candidate for backporting, so
> resolved conflicts instead
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/char/hw_random/core.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)

Why are you resending this to us after it is already in the kernel tree?
What are we supposed to do with it?

confused,

greg k-h

