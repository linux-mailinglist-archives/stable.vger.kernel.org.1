Return-Path: <stable+bounces-43606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E397F8C3D62
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 10:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C019B20AA3
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 08:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1F7147C78;
	Mon, 13 May 2024 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O4weYjVZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5B11474BF;
	Mon, 13 May 2024 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589498; cv=none; b=NJqoYJhSSgqx2ppuVaYCsFsqE7Mb/2ROsoDgYzOLp0FUBH+NIudLFLlXQFL6rFzh4I/ve6y66L+LN9ElcM4MvtY4bIMvMMsaA0quKfjTVdJrMh0RvvVkhtG6Z6cOd07fTYDHzApr5hqQ+RxUSunschAzekd1vMMSz51430qEYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589498; c=relaxed/simple;
	bh=wxX6epJ94bMOYJl9YPKz2h6+jsBH/JG6qIrcbGFB17M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqW/Wx4R6fs1vkAoCJOE+M8jg59JivPYM68KAo7HByQZ4MnVvgFpmVn3xyfivwhG3mXenwvpNQjuvDCl5PRfytV5W59vmuRUXdbIGiOFcmCnIcXM5xgoN0ZzfX9FeF3LQj8saPLQO6ukmtP493FJ7i0GAgn16bb0Zvx3nk9Czvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O4weYjVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC85DC113CC;
	Mon, 13 May 2024 08:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715589498;
	bh=wxX6epJ94bMOYJl9YPKz2h6+jsBH/JG6qIrcbGFB17M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4weYjVZizCTiyGN8eF1EJ5eav/g1PEJjLp7FaJ/qI4r3IaBt3P8ggX8QzJNIwo2Q
	 SqAUu5gRv4R0dgM+89psX3VI/ggFa+7pVxvMb2tWk0F2U1JPdHooIZQL2YKNaSmWHE
	 j2z9+/q9Q8UUOpEcst3ov4DrMe+WKQFb3/dowoLQ=
Date: Mon, 13 May 2024 10:38:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, roger.pau@citrix.com,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: Patch "x86/xen: attempt to inflate the memory balloon on PVH"
 has been added to the 6.1-stable tree
Message-ID: <2024051341-drearily-quaintly-3ea0@gregkh>
References: <20240509173637.559165-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240509173637.559165-1-sashal@kernel.org>

On Thu, May 09, 2024 at 01:36:36PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     x86/xen: attempt to inflate the memory balloon on PVH
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      x86-xen-attempt-to-inflate-the-memory-balloon-on-pvh.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This breaks the build on 6.1.y kernels:

In file included from ./include/linux/ioport.h:15,
                 from ./include/linux/acpi.h:12,
                 from arch/x86/xen/enlighten_pvh.c:2:
arch/x86/xen/enlighten_pvh.c: In function ‘xen_reserve_extra_memory’:
./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro ‘__typecheck’
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro ‘__safe_cmp’
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:45:25: note: in expansion of macro ‘__careful_cmp’
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
arch/x86/xen/enlighten_pvh.c:117:25: note: in expansion of macro ‘min’
  117 |                 pages = min(extra_pages,
      |                         ^~~
cc1: all warnings being treated as errors


So I'm dropping it for now.

thanks,

greg k-h

