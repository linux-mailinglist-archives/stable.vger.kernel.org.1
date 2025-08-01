Return-Path: <stable+bounces-165785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF906B18937
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 00:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD441C27297
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 22:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C8D2144B4;
	Fri,  1 Aug 2025 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z2t43Xrf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC2515A8
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754087585; cv=none; b=aSP1LN5c/3eGfvQ6+DptTh49nS837pTmPHp70eDCjTxxUBNsGwOtQIj3MdBJspAQWIW1400Eee0C7PeTJnP+yPAd5iVz8cfEQqV5UdU1pJk8/MI8agOhGxjN4Q22J4Mx6o5Py/36ySRq85DdYnKJ6Su7PAfYHvuUYKBf7zPBd2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754087585; c=relaxed/simple;
	bh=4kH6/3TqERspQwzYdE0tlDFh29jyX5Ih63V/qtXMhHE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LtqKFYNuFIBuGBMuie4NzWw6Cq0LFG7zt+z8L0fRFEyp+tOw99hkm2L/z2M3DFXQkd4reIO2PDgESm3D2KJAyiJr4TdnWB+Fo0m3A3oPezRnLRjdSlwT+Joa5P+hSSasflmdayKToI1+xlgHSIDpFqrwbhag2hrgEKUBRLhVdow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z2t43Xrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A50FC4CEE7;
	Fri,  1 Aug 2025 22:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754087584;
	bh=4kH6/3TqERspQwzYdE0tlDFh29jyX5Ih63V/qtXMhHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z2t43Xrf8h3ahfFXNjE5y0PbgmYRz9EBtP5vAY/GQatZizhbqzzGTrlJat3hCMqEo
	 c1Z59sbU6OonZ93Yv1+yrOUDWq64RzdEH25Ep04T4/pFdwsf2/Pw3zGKIpkxQbyCm0
	 Qj4i2r4oXj0jCDrznoF0nH2+nabWYTUiKO8InlCg=
Date: Fri, 1 Aug 2025 15:33:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gu Bowen <gubowen5@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, <stable@vger.kernel.org>,
 <linux-mm@kvack.org>, Lu Jialin <lujialin4@huawei.com>, Waiman Long
 <longman@redhat.com>, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] mm: Fix possible deadlock in console_trylock_spinning
Message-Id: <20250801153303.cee42dcfc94c63fb5026bba0@linux-foundation.org>
In-Reply-To: <20250730094914.566582-1-gubowen5@huawei.com>
References: <20250730094914.566582-1-gubowen5@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 17:49:14 +0800 Gu Bowen <gubowen5@huawei.com> wrote:

> kmemleak_scan_thread() invokes scan_block() which may invoke a nomal
> printk() to print warning message. This can cause a deadlock in the
> scenario reported below:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(kmemleak_lock);
>                                lock(&port->lock);
>                                lock(kmemleak_lock);
>   lock(console_owner);
> 
> To solve this problem, switch to printk_safe mode before printing warning
> message, this will redirect all printk()-s to a special per-CPU buffer,
> which will be flushed later from a safe context (irq work), and this
> deadlock problem can be avoided.
> 
> Our syztester report the following lockdep error:
> 
> ...
>
> index 4801751cb6b6..d322897a1de1 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -390,9 +390,11 @@ static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
>  		else if (object->pointer == ptr || alias)
>  			return object;
>  		else {
> +			__printk_safe_enter();
>  			kmemleak_warn("Found object by alias at 0x%08lx\n",
>  				      ptr);
>  			dump_object_info(object);
> +			__printk_safe_exit();
>  			break;
>  		}
>  	}

Thanks.

There have been a few kmemleak locking fixes lately.

I believe this fix is independent from the previous ones:

https://lkml.kernel.org/r/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org
https://lkml.kernel.org/r/20250728190248.605750-1-longman@redhat.com

But can people please check?

