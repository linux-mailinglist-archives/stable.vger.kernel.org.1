Return-Path: <stable+bounces-146365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD061AC3F4C
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 14:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F59188CCEF
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 12:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B731D1F4C94;
	Mon, 26 May 2025 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="njfRuKg6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F261DFE8
	for <stable@vger.kernel.org>; Mon, 26 May 2025 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748262186; cv=none; b=DK8mf1AbdtK5txxMX6pUX93xg+dEvgn3zEcisGa6xvvEszD7ixR41GkhdzQMqwfm888CPQmnCIJjtPAAltGBHmEZAqSG1w8NFDCCI1jluAG4F6dghbiX+ivLt9aC4oHs8g7eRn27t++LEQVURwtilNEuZN8veUcqCqoy003TwGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748262186; c=relaxed/simple;
	bh=B9BHtoWjn+0cIwJk6D0xoZApJxX8CS1VdLVB1JSpfLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQa9MZ1SNISg+7ZXvy5n3ZHeTKbM6NBCqsOgHAcBHhu/EUOUUf4dqYbiI/XL75fc3uo30GDCvf6+TbSue5oz72jE6TLdVzPGGmLHNb/828w4zJFMXA0k0VbncIRGcWFFXqYJMYzaMCvs71JTP4Hr1Krfa5Vjl2zngcRdcUo6cyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=njfRuKg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD584C4CEE7;
	Mon, 26 May 2025 12:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748262186;
	bh=B9BHtoWjn+0cIwJk6D0xoZApJxX8CS1VdLVB1JSpfLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njfRuKg6Cl+nF8IYlz4YRejL6yvv3bmFddc/yXYLOjoLIcV7pdiDzC2QBIeyIrH2u
	 hu8KV36Pqd8qsu/JsV4d3FqoA65L1VNWroTBcp+Baa5pfnQ4V7YBM0PgJrymstbQXU
	 Vz4H2W82a5VYmJXCOTqJy29W+Io1aQPJCUFcUnqg=
Date: Mon, 26 May 2025 14:23:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hendrik Donner <hd@os-cillation.de>
Cc: stable@vger.kernel.org
Subject: Re: Request to backport b3bee1e7c3f2b1b77182302c7b2131c804175870
 (x86/boot: Compile boot code with -std=gnu11 too)
Message-ID: <2025052621-unclip-monogram-c439@gregkh>
References: <8fab7dc7-a99f-4168-8dff-9ef8443faf38@os-cillation.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fab7dc7-a99f-4168-8dff-9ef8443faf38@os-cillation.de>

On Mon, May 26, 2025 at 12:59:20PM +0200, Hendrik Donner wrote:
> Hello,
> 
> with gcc 15.1.1 i see the following build issue on 6.6.91:
> 
>   CC      arch/x86/boot/a20.o
> In file included from ./include/uapi/linux/posix_types.h:5,
>                  from ./include/uapi/linux/types.h:14,
>                  from ./include/linux/types.h:6,
>                  from arch/x86/boot/boot.h:22,
>                  from arch/x86/boot/a20.c:14:
> ./include/linux/stddef.h:11:9: error: cannot use keyword 'false' as
> enumeration constant
>    11 |         false   = 0,
>       |         ^~~~~
> ./include/linux/stddef.h:11:9: note: 'false' is a keyword with '-std=c23'
> onwards
> ./include/linux/types.h:35:33: error: 'bool' cannot be defined via 'typedef'
>    35 | typedef _Bool                   bool;
>       |                                 ^~~~
> ./include/linux/types.h:35:33: note: 'bool' is a keyword with '-std=c23'
> onwards
> ./include/linux/types.h:35:1: warning: useless type name in empty
> declaration
>    35 | typedef _Bool                   bool;
>       | ^~~~~~~
> make[2]: *** [scripts/Makefile.build:243: arch/x86/boot/a20.o] Error 1
> make[1]: *** [arch/x86/Makefile:284: bzImage] Error 2
> 
> Fixed by b3bee1e7c3f2b1b77182302c7b2131c804175870 (x86/boot: Compile boot
> code with -std=gnu11 too), which hasn't been backported yet.
> 
> Should probably go into all stable trees.z

Is this the only change that is needed to get gcc15 working on this
kernel tree?  What about newer kernel branches, they seem to be failing
on gcc15 still, which implies that 6.6.y still needs more changes,
right?

thanks,

greg k-h

