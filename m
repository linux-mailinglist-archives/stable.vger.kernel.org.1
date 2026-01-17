Return-Path: <stable+bounces-210166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E5BD38F82
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 16:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0752B3018D41
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 15:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254792376FD;
	Sat, 17 Jan 2026 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qzthwW3f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25C950094B;
	Sat, 17 Jan 2026 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768664354; cv=none; b=n1HhxQJzX9+fsF4OVUdioiIe7pMX5b1UZT77snRbOcmP+P8SVBBQCAWkWcAsSVwJinoD1M0bzhZUlXGnBSwY5MrZ1M+K8Dtwv/HBOUKpuWEFN9T9iYSzCC6VbkoEkoLk1nMjlRtTsyYvItZL2j6QDXqKSZbWD+Bss9xpjf51mcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768664354; c=relaxed/simple;
	bh=T9nfEgfo/woxFjM1RdWlQzdkbfhIfvI92oxrGZNeIhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0uu+dVCPSQirzXx5OticMKRnnlhYSUTbo8s7Apzb3B6l8F1HlrDMcDXhK7wAT726EIvcUcF8UiqkZ+YPKTrdOXzVBRIlrPeUtslfpRpfzFl/GQtTSrXV3lEJtWqH9iyQ+3+4lN77Wq6Xs31SyAeovLCuKuws/c6UU2szc3k4Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qzthwW3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0C4C4CEF7;
	Sat, 17 Jan 2026 15:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768664354;
	bh=T9nfEgfo/woxFjM1RdWlQzdkbfhIfvI92oxrGZNeIhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzthwW3fD2eApjb3RbOdq3gXAwcxinZwX20jH8Uk6//jyZRUgLV4RAgs8jZZCwR0h
	 JEeaBzUEccFKh4tBwgwqYj055ABK7Gj02DX0skESl1e4fnGkPVdZu9Lx+JDpiWogXh
	 iGqR1V7394nnt//ZmC+b+6NVz1wxirHmYl7IWklU=
Date: Sat, 17 Jan 2026 16:39:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>, ritesh.list@gmail.com,
	hbathini@linux.ibm.com, mpe@ellerman.id.au,
	regressions@lists.linux.dev, benh@debian.org
Subject: Re: [regression 6.1.y] Backport of 353d7a84c214f18
 ("powerpc/64s/radix/kfence: map __kfence_pool at page granularity") to
 stable versions 6.1 causes build failure
Message-ID: <2026011705-turbulent-scheme-71ef@gregkh>
References: <aWqmDHdHVLs5M3HQ@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWqmDHdHVLs5M3HQ@eldamar.lan>

On Fri, Jan 16, 2026 at 09:56:44PM +0100, Salvatore Bonaccorso wrote:
> Hi,
> 
> In v6.1.160 353d7a84c214f18 ("powerpc/64s/radix/kfence: map
> __kfence_pool at page granularity") was backported. But this now
> causes a build failure:
> 
> make KERNELRELEASE=6.1.159+ ARCH=powerpc        KBUILD_BUILD_VERSION=3 -f ./Makefile
>   CALL    scripts/checksyscalls.sh
>   UPD     init/utsversion-tmp.h
>   CC      init/version.o
>   AR      init/built-in.a
>   CC      arch/powerpc/mm/book3s64/radix_pgtable.o
> In file included from arch/powerpc/mm/book3s64/radix_pgtable.c:35:
> ./arch/powerpc/include/asm/kfence.h: In function 'kfence_protect_page':
> ./arch/powerpc/include/asm/kfence.h:37:9: error: implicit declaration of function '__kernel_map_pages'; did you mean 'hash__kernel_map_pages'? [-Werror=implicit-function-declaration]
>    37 |         __kernel_map_pages(page, 1, !protect);
>       |         ^~~~~~~~~~~~~~~~~~
>       |         hash__kernel_map_pages
> cc1: some warnings being treated as errors
> make[7]: *** [scripts/Makefile.build:250: arch/powerpc/mm/book3s64/radix_pgtable.o] Error 1
> make[6]: *** [scripts/Makefile.build:503: arch/powerpc/mm/book3s64] Error 2
> 
> This is because 8f14a96386b2 ("mm: page_poison: always declare
> __kernel_map_pages() function") is missing from 6.1.y (it was only
> included in 6.5-rc1).
> 
> Cherry-picking 8f14a96386b2 fixes the build failure on powerpc.
> 
> #regzbot introduced 36c1dc122eb3b917cd2c343029ff60a366a00539
> 
> Marking as regression for 36c1dc122eb3 ("powerpc/64s/radix/kfence: map
> __kfence_pool at page granularity"), for the 6.1.y specific commit
> causing the regression.

Now queued up, thanks.

greg k-h

