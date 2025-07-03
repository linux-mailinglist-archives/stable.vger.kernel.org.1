Return-Path: <stable+bounces-159295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AC5AF6FAA
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 12:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09773B0151
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 10:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48272E03F6;
	Thu,  3 Jul 2025 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Eo+gSlf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90E1B95B;
	Thu,  3 Jul 2025 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751537165; cv=none; b=TiChJYC0OXYCWGwB0++TdD518rnQcnsgQHoQW+/JUaTf2fjAHa0mF9gBwxGVr0T0XNicZhQQCD/8/uaAUFMP2VA0E9CRg910xWMQZbi5MiF19INftyHSOhT+sCikIFKcEksznWMGAeGSHhth+tDYXFzsJgcG/27VH/VC7c6QGTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751537165; c=relaxed/simple;
	bh=tBa0DAg0qxrdIzcmLs3H1wllLTK3XwS1UCGg9u5oKHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeoN9vP0O4FJJLKEFFQ8O/HVL2nge7sjRcDMwociZyhvIZxgaEd7N5OROy0YW6ubUlKHiL77s33gJpgbfsoM+ALKg+fq50mgSFHQabpM+M++YOnRIclersSckvQVvtFki2JPmwuTJl42B/2t473V5J+0fIWMaH3YnUAzGKnd6OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Eo+gSlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C8BC4CEE3;
	Thu,  3 Jul 2025 10:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751537164;
	bh=tBa0DAg0qxrdIzcmLs3H1wllLTK3XwS1UCGg9u5oKHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1Eo+gSlfTRvBWoE7OSsEw0r9zCTwxyud4BviRS8WC6p3jYb+6851KPHdtVEZaSN4/
	 cMIs4aDm31In029+81likJL1RxCk2mtUfPSckNj8SuKNYZGxwyCgBTIIH2d9dEk5ey
	 IEkBRge+lljE2AdZMG6chetZ1eSkgKrVntzwfIHY=
Date: Thu, 3 Jul 2025 12:06:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: stable@vger.kernel.org, urezki@gmail.com, akpm@linux-foundation.org,
	edumazet@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.15.y] mm/vmalloc: fix data race in show_numa_info()
Message-ID: <2025070322-front-purchase-b66f@gregkh>
References: <20250702153312.351080-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702153312.351080-1-aha310510@gmail.com>

On Thu, Jul 03, 2025 at 12:33:12AM +0900, Jeongjun Park wrote:
> commit 5c5f0468d172ddec2e333d738d2a1f85402cf0bc upstream.
> 
> The following data-race was found in show_numa_info():
> 
> ==================================================================
> BUG: KCSAN: data-race in vmalloc_info_show / vmalloc_info_show
> 
> read to 0xffff88800971fe30 of 4 bytes by task 8289 on cpu 0:
>  show_numa_info mm/vmalloc.c:4936 [inline]
>  vmalloc_info_show+0x5a8/0x7e0 mm/vmalloc.c:5016
>  seq_read_iter+0x373/0xb40 fs/seq_file.c:230
>  proc_reg_read_iter+0x11e/0x170 fs/proc/inode.c:299
> ....
> 
> write to 0xffff88800971fe30 of 4 bytes by task 8287 on cpu 1:
>  show_numa_info mm/vmalloc.c:4934 [inline]
>  vmalloc_info_show+0x38f/0x7e0 mm/vmalloc.c:5016
>  seq_read_iter+0x373/0xb40 fs/seq_file.c:230
>  proc_reg_read_iter+0x11e/0x170 fs/proc/inode.c:299
> ....
> 
> value changed: 0x0000008f -> 0x00000000
> ==================================================================
> 
> According to this report,there is a read/write data-race because
> m->private is accessible to multiple CPUs.  To fix this, instead of
> allocating the heap in proc_vmalloc_init() and passing the heap address to
> m->private, vmalloc_info_show() should allocate the heap.
> 
> Link: https://lkml.kernel.org/r/20250508165620.15321-1-aha310510@gmail.com
> Fixes: 8e1d743 ("mm: vmalloc: support multiple nodes in vmallocinfo")

Why did you change this line?

> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/vmalloc.c | 63 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 35 insertions(+), 28 deletions(-)

Please document what you changed from the original version, as this does
not match what is in Linus's tree.

thanks,

greg k-h

