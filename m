Return-Path: <stable+bounces-118425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04921A3D98D
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 13:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3130B189E1EB
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D8D1F4701;
	Thu, 20 Feb 2025 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cHEJmRac"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991631BD01F;
	Thu, 20 Feb 2025 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053480; cv=none; b=Kq+0+tQvZ+4z5rUghOPqEF/oaeULtY0XWDARTCA5GBV87A/k3SHx7d4U6bI/0M67uvVciXuJLvJZVvwLVEmcaunyVv9HVxPGEhMEr7ISCS14bWvZzSmhuN/z1YLsaUFuYAjMqOmN/i/WVqSV5gpucs6VIRKSgVA8dBrDBeHlM34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053480; c=relaxed/simple;
	bh=BNHV6Dc+IdimNYhEFltdZY5LX+bcb1dqm6RZeWFj8AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2gbHwD8DlBX6PBcVC2JIK3TL8CzruAU5xS1w8zs0r5QBY24s6Fd3UziKjXgYtmx0yta1NvjyBFmyjZHtY8y8FcM1OeqnElUwoAVDxt6rdCXxoXmb6dKedaCnKe9l7DJvRaS78zmOL7cxmgPEtPZbXC8lj5NNEZ4qcmpHEiB3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cHEJmRac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6999C4CED1;
	Thu, 20 Feb 2025 12:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740053480;
	bh=BNHV6Dc+IdimNYhEFltdZY5LX+bcb1dqm6RZeWFj8AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHEJmRacocAa8fNFxuupeMVAk72fwHn1UP0NE4HyD7VmZ529OD7dOTYVXZR7Db+10
	 myTNt4HvfLXJMFkB6W7Jyy7XzUPT+n86Dtl5jjjIYIDf6RMk4FkchL+nyWO7+KNaJp
	 dWbCaxMqjIR2G+1YVrFpCbt+QvnzwBktV1X5XgwY=
Date: Thu, 20 Feb 2025 13:11:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>,
	Vimal Agrawal <vimal.agrawal@sophos.com>, kernel-dev@igalia.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] char: misc: deallocate static minor in error path
Message-ID: <2025022041-onyx-regular-d901@gregkh>
References: <20250123123249.4081674-1-cascardo@igalia.com>
 <20250123123249.4081674-5-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123123249.4081674-5-cascardo@igalia.com>

On Thu, Jan 23, 2025 at 09:32:49AM -0300, Thadeu Lima de Souza Cascardo wrote:
> When creating sysfs files fail, the allocated minor must be freed such that
> it can be later reused. That is specially harmful for static minor numbers,
> since those would always fail to register later on.
> 
> Fixes: 6d04d2b554b1 ("misc: misc_minor_alloc to use ida for all dynamic/misc dynamic minors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>  drivers/char/misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index 7a768775e558..7843a1a34d64 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -266,8 +266,8 @@ int misc_register(struct miscdevice *misc)
>  		device_create_with_groups(&misc_class, misc->parent, dev,
>  					  misc, misc->groups, "%s", misc->name);
>  	if (IS_ERR(misc->this_device)) {
> +		misc_minor_free(misc->minor);
>  		if (is_dynamic) {
> -			misc_minor_free(misc->minor);
>  			misc->minor = MISC_DYNAMIC_MINOR;
>  		}
>  		err = PTR_ERR(misc->this_device);
> -- 
> 2.34.1
> 
> 

Having a "fix" as patch 4/4 of a series is a pain, it should go to Linus
now, not for the next merge window, right?  I'll split this apart by
hand, but ugh, please be more careful next time.

thanks,

greg k-h

