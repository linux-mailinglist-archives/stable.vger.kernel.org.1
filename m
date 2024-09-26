Return-Path: <stable+bounces-77758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57084986E9C
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 10:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9CC1C20F4E
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 08:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1833E18FC7C;
	Thu, 26 Sep 2024 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GLoLb+JU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2439143C4C;
	Thu, 26 Sep 2024 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727338666; cv=none; b=Cf8DsA/Mx9Kl10a5Y7MaG/L63nZ6htnwuFkZ28wnk3gEzjgfdfq50BhO4CHdsSof+pPkNJ7/qQs5MzoCFhsaygIWKFU5bGrG/NRkMiEiAlR2rk6UMmXyuU0aGwDizabmlltw2XvtKwjBQixD589joP2Vf/ZPrEFLBbLgORxfp28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727338666; c=relaxed/simple;
	bh=zJGAtiQ6hKIqDHqBWVNAwPYrFwC+QZwE/XS3fZBSj+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML5Z50qk+ZEWf01tW7FWQ0brhYF7AUZb3kHh8Z2yzwezddpMFuLLZkmX3Z66bM4REz1+W+96TfqFMSDv2KI+MJ94jOwUB/gxd4pkpQAfM4ZH7Ppfy1UxNFiOu0GOl5qNP+MsMgGzmHgEGEO5+iTsvpqf9lPO4LlZLgVDr9Q32Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GLoLb+JU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AADAC4CEC5;
	Thu, 26 Sep 2024 08:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727338666;
	bh=zJGAtiQ6hKIqDHqBWVNAwPYrFwC+QZwE/XS3fZBSj+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLoLb+JU2ubBx0zEZcGzeHPbDlwTO0uCmZwKaLYvKzkHspmmyYShkJ+T6c/gJPqwa
	 c0eEs3jq4S/qB4h0xaqVrhwwtZCbhShrc+HwxUXLA80tsDvGT0mPrKV98MIJpJuGWI
	 eqxZKqDsuLSbzB/cYmsbjCEn5k93H7wq3HWpz8Ac=
Date: Thu, 26 Sep 2024 10:17:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: cuigaosheng <cuigaosheng1@huawei.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org,
	thunder.leizhen@huawei.com, wangweiyang2@huawei.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH -next 1/2] kobject: fix memory leak in kset_register()
 due to uninitialized kset->kobj.ktype
Message-ID: <2024092637-unthawed-vending-c39b@gregkh>
References: <20240925120747.1930709-1-cuigaosheng1@huawei.com>
 <20240925120747.1930709-2-cuigaosheng1@huawei.com>
 <2024092530-putt-democracy-e2df@gregkh>
 <c928dc7c-3418-d6cb-9503-e0c9a48adc1c@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c928dc7c-3418-d6cb-9503-e0c9a48adc1c@huawei.com>

On Thu, Sep 26, 2024 at 10:56:24AM +0800, cuigaosheng wrote:
> On 2024/9/25 20:19, Greg KH wrote:
> 
> > On Wed, Sep 25, 2024 at 08:07:46PM +0800, Gaosheng Cui wrote:
> > > If a kset with uninitialized kset->kobj.ktype be registered,
> > Does that happen today with any in-kernel code?  If so, let's fix those
> > kset instances, right?
> 
> I didn't find this kset instance in kernel code,itwas discovered through code review.

Great, then it is not a real issue :)

> > > kset_register() will return error, and the kset.kobj.name allocated
> > > by kobject_set_name() will be leaked.
> > > 
> > > To mitigate this, we free the name in kset_register() when an error
> > > is encountered due to uninitialized kset->kobj.ktype.
> > How did you hit this?
> 
> I am testing kernel functionality through fault injection, and I discovered
> it whenI was locating the issue fixed by another patch, I haven't found this
> wrong usage in the kernel, but we can construct it by fault injection,

"fault injection" also shows things that are impossible to ever have
happen as well, so our "need" to fix them is usually very low, right?

thanks,

greg k-h

