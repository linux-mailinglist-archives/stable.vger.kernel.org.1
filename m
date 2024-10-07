Return-Path: <stable+bounces-81219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB239926ED
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 10:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE161C22267
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 08:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1334518BC1E;
	Mon,  7 Oct 2024 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nPUl42Tv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFEA18BC03;
	Mon,  7 Oct 2024 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289480; cv=none; b=Bwvpuv5ThY8grr590Gpk1sWlohXW8s3JC3amtU/HD5oh7Q1QBb9NIIMQVcnZLgXgec8vAdIYRlGnyfcw3AJJ2HYf4bYrr4lTyniOTUJsqJsGj9z/Pb/UzDPEO7pHdkUKurDRNXzoHwMMEifbvoTVNrCNUdHJ+yzOHgM5v8G5mbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289480; c=relaxed/simple;
	bh=/Fo2DjAvsIr3OHEbNLnOjnqG3h/3NfrKWkbkHLelb7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf6Ws1bEAVACeOtpG766BxGZBlSXXTUX/Hyzrul9Hti1pTT6KP3/XCBeyoiR0zkVNW6ePhUfzrzZjEQ6Km//Ul6TqZoA4mYYX1GUumqGj80BOureUmD/UFlvUeBfboHH0mp1/OvpBmFg4pibpAnTXbZiwpyyCJwsHF3MFfDDXqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nPUl42Tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF03C4CECF;
	Mon,  7 Oct 2024 08:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728289480;
	bh=/Fo2DjAvsIr3OHEbNLnOjnqG3h/3NfrKWkbkHLelb7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nPUl42Tvh02I6DA1K6h0VfB2p2eLAJpgE8EcRiV2AVbQqIJabxzFb09GvY9oJzBMS
	 Le8EhH1DNr2/3Hf8O/tU2zPVdtkerjwk6cItVxyM76TqvsiDhwP12Fvy1tNEFhTLaz
	 75M1aCCWTGalXKjkzuh5BhYj7KY8vSQmzr6uw2Is=
Date: Mon, 7 Oct 2024 10:24:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: akpm@linux-foundation.org, usama.anjum@collabora.com, peterx@redhat.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: remove the newlines, which are added for unknown
 reasons and interfere with bug analysis
Message-ID: <2024100748-exhume-overgrown-bf0d@gregkh>
References: <20241007065307.4158-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007065307.4158-1-aha310510@gmail.com>

On Mon, Oct 07, 2024 at 03:53:07PM +0900, Jeongjun Park wrote:
> Looking at the source code links for mm/memory.c in the sample reports 
> in the syzbot report links [1].
> 
> it looks like the line numbers are designated as lines that have been 
> increased by 1. This may seem like a problem with syzkaller or the 
> addr2line program that assigns the line numbers, but there is no problem 
> with either of them.
> 
> In the previous commit d61ea1cb0095 ("userfaultfd: UFFD_FEATURE_WP_ASYNC"), 
> when modifying mm/memory.c, an unknown line break is added to the very first 
> line of the file. However, the git.kernel.org site displays the source code 
> with the added line break removed, so even though addr2line has assigned 
> the correct line number, it looks like the line number has increased by 1.
> 
> This may seem like a trivial thing, but I think it would be appropriate 
> to remove all the newline characters added to the upstream and stable 
> versions, as they are not only incorrect in terms of code style but also 
> hinder bug analysis.
> 
> [1]
> 
> https://syzkaller.appspot.com/bug?extid=4145b11cdf925264bff4
> https://syzkaller.appspot.com/bug?extid=fa43f1b63e3aa6f66329
> https://syzkaller.appspot.com/bug?extid=890a1df7294175947697
> 
> Fixes: d61ea1cb0095 ("userfaultfd: UFFD_FEATURE_WP_ASYNC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  mm/memory.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 2366578015ad..7dffe8749014 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1,4 +1,3 @@
> -

This sounds like you have broken tools that can not handle an empty line
in a file.

Why not fix those?

Also, your changelog text has trailing whitespace, ironic for a patch
that does a whitespace cleanup :)

thanks,

greg k-h

