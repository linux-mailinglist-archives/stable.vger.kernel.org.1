Return-Path: <stable+bounces-154870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 309F9AE129B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 06:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40EAE7AEFC6
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 04:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977CC30E82B;
	Fri, 20 Jun 2025 04:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="I7PB1tUW"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154C21CA0C;
	Fri, 20 Jun 2025 04:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750394790; cv=none; b=i2pqF+FPx5i/5zgDQw3NxTEPlZryXwL7flpVvsW+xQgMxcBNqqoIAk3pGKSCH7CqgT4483KIEYKDmt4h64OfTlHaHyu4TcOIdpeO9zvF1OYtToYdi+RjMmQJVhph3SMGxYXUkQnRwoN9s8RmhWXeWDUzsaS4rOjbH9iTneSWi/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750394790; c=relaxed/simple;
	bh=MDnI1MxSf0siO1p6VIer4KU5FQHklFuaPYfzm5R7XkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTM3R9Bibx6J5iuEDvVGMBf19Fb+39YkIM9T1mstx2pRyaO6cEGxNRW7ztSOALc6NuwqMF3EEHFqB6N13H9s5JJ6s5i+msDFLo+dovaJYcVjK48ixE0eqFthKtF2WpeVcHsVygWOtCzFoEaALAGqIGimkyvzDtHWdnUYNTs9AOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=I7PB1tUW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750394786;
	bh=MDnI1MxSf0siO1p6VIer4KU5FQHklFuaPYfzm5R7XkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7PB1tUWHMatzMLCykp3Fuujrf/KYGglViPQmY9odcjamWrj3smCJzTwnRPO72fUP
	 PRyCPZXD3bg6bhMh0hknSd47oehCuXUjRUblnMVnm815zuTK4cBj7sDP2pn5BeEAQN
	 NDwmLIj3EHsYJ506/e719/T4jfEBd4Q7elaLqlJM=
Date: Fri, 20 Jun 2025 06:46:24 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, thomas.weissschuh@linutronix.de, 
	Willy Tarreau <w@1wt.eu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Subject: Re: Patch "tools/nolibc: use intmax definitions from compiler" has
 been added to the 6.15-stable tree
Message-ID: <a7045756-cd82-4241-a5b0-d8f6fad87b1c@t-8ch.de>
References: <20250620022618.2600341-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250620022618.2600341-1-sashal@kernel.org>

Hi stable team,

On 2025-06-19 22:26:18-0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     tools/nolibc: use intmax definitions from compiler
> 
> to the 6.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      tools-nolibc-use-intmax-definitions-from-compiler.patch
> and it can be found in the queue-6.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

As discussed in [0] and its ancestors, please only backport nolibc
patches are were explicitly tagged for stable@.

[0] https://lore.kernel.org/lkml/2025061907-finance-dodgy-b0ae@gregkh/

Thanks,
Thomas

> commit fb60b190f25c7958f85fdae9b7024548139de281
> Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Date:   Fri Apr 11 11:00:39 2025 +0200
> 
>     tools/nolibc: use intmax definitions from compiler
>     
>     [ Upstream commit e5407c0820ea5fa7117b85ed32b724af73156d63 ]
>     
>     The printf format checking in the compiler uses the intmax types from
>     the compiler, not libc. This can lead to compiler errors.
>     
>     Instead use the types already provided by the compiler.
>     
>     Example issue with clang 19 for arm64:
>     
>     nolibc-test.c:30:2: error: format specifies type 'uintmax_t' (aka 'unsigned long') but the argument has type 'uintmax_t' (aka 'unsigned long long') [-Werror,-Wformat]
>     
>     Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>     Acked-by: Willy Tarreau <w@1wt.eu>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
> index cd79ddd6170e0..b052ad6303c38 100644
> --- a/tools/include/nolibc/stdint.h
> +++ b/tools/include/nolibc/stdint.h
> @@ -39,8 +39,8 @@ typedef   size_t      uint_fast32_t;
>  typedef  int64_t       int_fast64_t;
>  typedef uint64_t      uint_fast64_t;
>  
> -typedef  int64_t           intmax_t;
> -typedef uint64_t          uintmax_t;
> +typedef __INTMAX_TYPE__    intmax_t;
> +typedef __UINTMAX_TYPE__  uintmax_t;
>  
>  /* limits of integral types */
>  

